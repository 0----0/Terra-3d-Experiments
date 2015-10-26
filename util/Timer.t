local CTime = {}
if jit.os == "Windows" then
        CTime.timeType = uint
        CTime.curTime = error("curTime not yet implemented for windows.") --TODO
        CTime.sleepMS = terralib.includec("windows.h").Sleep
        CTime.getTimeMS = terra(x : uint) return x end
        CTime.subTime = terra(a : uint, b : uint) return a - b end
else
        CTime = terralib.includecstring(
        "#include <time.h>\n"..
        "#include <sys/time.h>\n"..[[
        typedef struct timeval timeType;

        timeType curTime() {
                timeType ret;
                gettimeofday(&ret, 0);
                return ret;
        }

        void sleepMS(unsigned int ms) {
                struct timespec sleepTime;
                sleepTime.tv_sec = ms / 1000;
                sleepTime.tv_nsec = ms * 1000000;
                nanosleep(&sleepTime, 0);
        }

        unsigned int getTimeMS(timeType CTime) {
                return CTime.tv_sec * 1000 + CTime.tv_usec / 1000;
        }

        timeType subTime(timeType a, timeType b) {
                timeType ret;
                timersub(&a, &b, &ret);
                return ret;
        }
        ]])
end


local struct Timer {
        startT : CTime.timeType
}

terra Timer:init()
        self.startT = CTime.curTime()
end

Timer.methods.create = terra()
        var timer : Timer
        timer:init()
        return timer
end

terra Timer:getElapsedMS()
        return CTime.getTimeMS(CTime.subTime(CTime.curTime(), self.startT))
end

terra Timer:round(ms: uint)
        while true do
                var elapsedMS = self:getElapsedMS()
                if elapsedMS < ms then CTime.sleepMS(ms - elapsedMS) else break end
        end
end

return Timer
