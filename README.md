# Events
The multi-cast events in lua. it's very Simple, Fast and compatible any lua runtime. support features:
- multi-event single Events instance
- multi-handle single event
- events concat/merge
- cache initialized event anywhere
- exception mute/catch
- e.on("EventName", func) syntax, or e("EventName", func)

# Install & Usage
download the Events.lua file and put into lua search path or current directory.

load it as a file module from lua. use Events.new() get a multi-event instance.
```lua
local e = require('Events')

-- init event 'Begin', with first handle
e.on("Begin", function()
	..
end)

-- fire
e.Begin()
```

# More examples
```lua
-- (next...)

-- more events, ex: "End"
e.on("End", function(x)
	..
end)

-- more handles of event 'Begin'
e.on("Begin", function()
	..
end)

-- fire all handles once call
e.Begin()

-- pass arg/arguments to event, ex: 'x' arg of "End" event
e.End('abcd')

-- new Begin2 event
e.on("Begin2", function()
	..
end)

-- concat "Begin" and "Begin2"
--	*) will append Begin2 to Begin
e.on("Begin", e.Begin2)

-- fire all handles in Begin and Begin2
e.Begin()
```