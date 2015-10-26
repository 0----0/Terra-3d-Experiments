local std = require "util/std"

function dumptable(tbl) for k,v in pairs(tbl) do print(k,v) end end
local new = function(T) return `[&T](std.malloc(sizeof(T))) end

local function RBTree(K, V, cmp)
        if not cmp then cmp = terra(l: K, r: K) return l - r end end
        local struct RBTreeNode {
                left: &RBTreeNode
                right: &RBTreeNode
                parent: &RBTreeNode
                red: bool
                key: K
                value: V
        }
        terra RBTreeNode:init(key: K, value: V)
                self.key = key
                self.value = value
                self.red = false
                self.left = nil
                self.right = nil
                self.parent = nil
        end
        terra RBTreeNode:destruct(): {}
                std.rundestructor(self.key)
                std.rundestructor(self.value)
                if self.left ~= nil then self.left:destruct() end
                if self.right ~= nil then self.right:destruct() end
        end
        -- terra RBTreeNode:dump()
        --         if self == nil then std.printf("Nil node.\n") return end
        --         var str: rawstring; if self.red then str = "Red" else str = "Black" end
        --         std.printf("Address: %x.  Value: %d.  Left: %x.  Right: %x.  Parent: %x.  Color: %s\n", self, self.key, self.left, self.right, self.parent, str)
        -- end
        terra RBTreeNode:replace(original: &RBTreeNode, new: &RBTreeNode)
                if self.left == original then self:adoptLeft(new)
                else self:adoptRight(new) end
        end
        terra RBTreeNode:rotateLeft()
                var right = self.right
                self.parent:replace(self, right)
                self:adoptRight(right.left)
                right:adoptLeft(self)
        end
        terra RBTreeNode:rotateRight()
                var left = self.left
                self.parent:replace(self, left)
                self.adoptLeft(left.right)
                left:adoptRight(self)
        end
        terra RBTreeNode:adoptLeft(child: &RBTreeNode)
                self.left = child
                if child ~= nil then child.parent = self end
        end
        terra RBTreeNode:adoptRight(child: &RBTreeNode)
                self.right = child
                if child ~= nil then child.parent = self end
        end
        terra RBTreeNode:grandparent()
                if self ~= nil and self.parent ~= nil then return self.parent.parent
                else return nil end
        end
        terra RBTreeNode:uncle()
                var g = self:grandparent()
                if g == nil then return nil
                elseif self.parent == g.left then return g.right
                else return g.left end
        end
        terra RBTreeNode:isRed()
                if self == nil then return false
                else return self.red end
        end


        local struct RBTree(std.Object) {
                root: &RBTreeNode
        }
        terra RBTree:init()
                self.root = nil
        end
        terra RBTree.methods.create()
                var self: RBTree self:init() return self
        end
        terra RBTree:__destruct()
                if self.root ~= nil then self.root:destruct() end
        end
        terra RBTree:get(key: K)
                var curNode = self.root
                while true do
                        if curNode == nil then return nil end
                        var diff = cmp(key, curNode.key)
                        if diff == 0 then return &curNode.value end
                        if diff < 0 then curNode = curNode.left
                        else curNode = curNode.right end
                end
        end
        terra RBTree:insert(key: K, value: V)
                var node: &RBTreeNode
                if self.root == nil then node = [new(RBTreeNode)] node:init(key,value) self.root = node return &node.value end

                var curNode = self.root
                while true do
                        var diff = cmp(key, curNode.key)
                        if diff == 0 then return nil end
                        if diff < 0 then
                                if curNode.left == nil then
                                        node = [new(RBTreeNode)]
                                        node:init(key, value)
                                        curNode:adoptLeft(node)
                                        break
                                else
                                        curNode = curNode.left
                                end
                        else
                                if curNode.right == nil then
                                        node = [new(RBTreeNode)]
                                        node:init(key, value)
                                        curNode:adoptRight(node)
                                        break
                                else
                                        curNode = curNode.right
                                end
                        end
                end


                ::start::
                node.red = true
                if node == self.root then node.red = false --If we are the root node, become black
                --If parent node is black, then we can remain red
                elseif node.parent.red then --Parent node is red
                        var uncle = node:uncle()
                        var grand = node.parent.parent
                        if uncle:isRed() then
                                node.parent.red = false
                                uncle.red = false
                                node = grand
                                goto start
                        else
                                if node.parent == grand.left then
                                        if node == node.parent.right then
                                                node.parent:adoptRight(node.left)
                                                node:adoptLeft(node.parent)
                                                grand:adoptLeft(node)

                                                node = node.left
                                        end
                                        var greatgrand = grand.parent
                                        if greatgrand == nil then self.root = node.parent
                                        elseif greatgrand.left == grand then greatgrand:adoptLeft(node.parent)
                                        else greatgrand:adoptRight(node.parent) end
                                        grand:adoptLeft(node.parent.right)
                                        node.parent:adoptRight(grand)
                                        grand.red = true
                                        node.parent.red = false
                                else
                                        if node == node.parent.left then
                                                node.parent:adoptLeft(node.right)
                                                node:adoptRight(node.parent)
                                                grand:adoptRight(node)

                                                node = node.right
                                        end
                                        var greatgrand = grand.parent
                                        if greatgrand == nil then self.root = node.parent node.parent.parent = nil
                                        elseif greatgrand.left == grand then greatgrand:adoptLeft(node.parent)
                                        else greatgrand:adoptRight(node.parent) end
                                        grand:adoptRight(node.parent.left)
                                        node.parent:adoptLeft(grand)
                                        grand.red = true
                                        node.parent.red = false
                                end
                        end
                end
                return &node.value
        end

        return RBTree
end
RBTree = terralib.memoize(RBTree)

return RBTree
