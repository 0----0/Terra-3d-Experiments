#include <iostream>
extern "C" {
#include <stdio.h>
}

template <typename T>
class _DeferredPrint {
public:
        T deferred;
        _DeferredPrint(T deferred) noexcept: deferred(deferred) {}
        ~_DeferredPrint() noexcept {
                std::cout << deferred << std::endl;
        }
};

template <typename T>
inline _DeferredPrint<T> DeferredPrint(T deferred) noexcept {
        return _DeferredPrint<T>(deferred);
}


int main() noexcept {
        int x;
        scanf("%d", &x);
        auto a = DeferredPrint(3);
        if(x == 3) {
                scanf("%d", &x);
                auto b = DeferredPrint("lol");
                auto e = DeferredPrint("lol");
                // auto f = DeferredPrint("lol");
                // auto g = DeferredPrint("lol");
                // auto h = DeferredPrint("lol");
                // auto i = DeferredPrint("lol");
                // auto j = DeferredPrint("lol");
                if(x == 4) {
                        return 0;
                }
                else if(x == 5) {
                        goto exitif;
                }
                auto c = DeferredPrint("no");
        }
        puts("ay");
        exitif:
        auto d = DeferredPrint(4);
        return 0;
}
