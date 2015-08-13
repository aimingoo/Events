---------------------------------------------------------------
---		Base demo of Events module
---------------------------------------------------------------

-- local Events = require('Events')
local Events = dofile('../Events.lua')

-- Simple case: create events, add handles and fire
local e = Events.new()
e.on('Now', function(msg)
	print(msg, os.time())
end)
print("==> simple fire")
e.Now('current time:')

-- Multicat case: more handles
e.on('Now', function(msg)
	print(msg, os.date("%x", os.time()))
end)
print("==> trigge multi handles")
e.Now("time in handles:")

print("==> event concatenate")
-- Event-Concat case:
local e2 = Events.new()
e2.on('NewNow', function(msg)
	print(msg, os.time(), '<- new events <e2>')
end)
-- add event 'e2.NewNow' as handle
e.on('Now', e2.NewNow)
-- fire
e.Now("time in multi concat events:")

-- safe append handles in <e2> and fire from <e>
e2.on('NewNow', function(msg)
	print(msg, os.time(), '<- in <e2>')
end)
e.Now("from events <e>:")

--
-- statistics/report
--
print("==> statistics")

-- print event names for events
local function keys(t, names)
	local keys = {}
	for key in pairs(t) do
		if type(key) == 'string' then table.insert(keys, key) end
	end
	return keys
end

-- more event in e/e2
local null_handle = function() end
e.on("Before", null_handle)
e.on("After", null_handle)
e("Other", null_handle)		-- e("xxx", ..) is shortcut of e.on("xxx", ..)
print('names in e: ', table.concat(keys(e), ', '))
print('names in e2: ', table.concat(keys(e2), ', '))

-- print handle count for event
print(#e.Now .. ' handles in e.Now')
print(#e2.NewNow .. ' handles in e2.NewNow')