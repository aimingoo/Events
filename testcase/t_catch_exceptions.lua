--
-- the demo for catch exceptions from your handle function
--	1) all event handles is run in pcall(), cant direct throw/catch error
--

local CATCH = function(f)
	return function(...)
		local results = { pcall(f, ...) }
		if not results[1] then --  pcall() return {ok, reson}
			print('[ERROR]', results[2]..'\n'..debug.traceback())
		else
			return unpack(results)
		end
	end
end

-- local e = require('Events').new()
local e = dofile('../Events.lua').new()

--
-- add handles
--

-- all error will ignore in Events
local function doSomething()
	print('ding dong.')
	error('a error in handle, break at here')
end
e.on("Test", doSomething)

-- catch it with CATCH()
e.on("Test", CATCH(doSomething))


--
-- fire
--
e.Test()