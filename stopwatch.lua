--// Title: stopwatch.lua
--// Description: stopwatch implementation

local stopwatch = {}

function stopwatch.create()
    local this_stopwatch = {
        start_time = -1,
        end_time = -1,
        difference = -1,

        start = function(self)
            self.start_time = os.time()
            self.end_time = -1
            self.difference = -1
        end,

        stop = function(self)
            self.end_time = os.time()

            if self.start_time < 0 then
                return -1
            end

            self.difference = os.difftime(self.end_time, self.start_time)
            self.start_time = -1
            self.end_time = -1

            return self.difference
        end,
    }

    setmetatable(this_stopwatch, {
        __call = function(t)
            if t.start_time > -1 then
                t:stop()
            else
                t:start()
            end
        end,

        __eq = function(t1, t2)
            return t1.difference == t2.difference
        end,

        __lt = function(t1, t2)
            return t1.difference < t2.difference
        end,

        __le = function(t1, t2)
            return t1.difference <= t2.difference
        end,

        __tostring = function(t)
            return ("%s secs"):format(t.difference)
        end,

        __len = function(t)
            return t.difference
        end,

        __concat = function(t)
            return tostring(t)
        end,
    })

    return this_stopwatch
end

return stopwatch