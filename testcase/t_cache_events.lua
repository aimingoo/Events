--
-- the demo for safed/unsafed event cache
--

-- local Events = require('Events')
local Events = dofile('../Events.lua')

local cached = {}

local e = Events.new()
e.on("Active", function(msg)
	print(' before cached: ', msg)
end)

-- "Active" event is safe cached
table.insert(cached, e.Active)

-- "Something" is uninitialtied, so is null event, can't cache!
print('==> if e.XXX is null, cant cache it now!!')
print('Something is null: ', Events.isNull(e.Something))
--	1) there is invalid cache because event is null
table.insert(cached, e.Something)  -- !!! invalid !!!

-- test events and dynamic append handle after safe cached
e.on("Active", function(msg)
	print(' after cached: ', msg)
end)

-- initialtiation it when call e.on("XXX") once
e.on("Something", function(msg)
	print(' after cached: ', msg)
end)
-- now, e.Something isnt null event
-- print('Something is null: ', Events.isNull(e.Something))


-- fire
print('\n==> direct fire event is safed for all')
e.Something('fire Something')	-- you can fire it witout cache
e.Active('fire Active')


print('\n==> fire all cached handles(after/before)')
-- fire with cache, the e.Something is LOST, because a null event cached
table.foreachi(cached, function(_, e)
	--	at here, the <e> is cached event, from a events
	print('The cached event is null: ', Events.isNull(e))
	if not Events.isNull(e) then
		e('call from cache')
	else
		e('do nothing') -- do nothing, it's null
		print(' LOST when event is null')
	end
end)