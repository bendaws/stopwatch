--[[===========================================================================
                                  Stopwatch
===============================================================================
Basic stopwatch library for Lua.

You can create a new stopwatch object with stopwatch.create(). You can either
call the stopwatch as a function or do stopwatch_obj:start() and
stopwatch_obj:stop() to end the stopwatch.
===============================================================================
                                Usage Example
===============================================================================
        local stlib = require("stopwatch")
        local stopwatch = stlib.create()

        stopwatch:start() -- or stopwatch() to toggle starting / stopping

        local endAt = os.time() + 3
        repeat until os.time() > endAt

        stopwatch:stop() -- returns integer value of the stopwatch time

        print(tostring(stopwatch)) -- * secs
===============================================================================
                                 License
===============================================================================
                               MIT License

Copyright (c) 2025 Ben Daws

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

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
            return tostring(t.difference)
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
