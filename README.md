# Unique-Love
A library for Löve2D, that provides a framework for entities and rooms. This project is very much a work in progress see **Version** for more info.

I STRONGLY ADVISE NOT TO USE THE CODE IN THIS PROJECT YET!

Published under the MIT license.


## Usage
To implement this into your project make sure to place the code in your game files. The needed files are so far `EntitySystem.lua` and `RoomSystem.lua`
To create a new entity use following code:

```lua
local entitySystem = require('EntitySystem')
local EXAMPLE = entitySystem:new()
```

Where `EXAMPLE` is the entity you are creating.

So far the Entity System provides following methods:
* `ENTITY:place(x,y)` - places the object at given coordinates, default coordinates are 0,0
* `ENTITY:collision(other)` - checks for collision with other object, returns a boolean.
* `ENTITY:hit(n)` - entities comes with a build in variable for health, this mehtod will make the entity take n damage.
* `ENTITY:gravity(dt)` - This function is ment to be called internally, but it makes gravity act on the entity
* `ENTITY:step(dt)` - This method should be called each time the entity should be updated.
* `ENTITY:destroy()` - Destroys the entity (sets it´s index to nil)
* `ENTITY:setTag(name, n)` - Sets a tag for the entity, so far tags does nothing.
* `ENTITY:getTag(name)` - Gets a tag from the entity, so far tags does nothing.

So far the Room System provides following methods:
* `ROOM:placeEntity(x,y,entity)` - Adds an entity to the room and places it at x,y.

## Version 0.1
Early development, only part of core features are implemented.

### Changelog

#### V0.1
- *Added entities* - the base class that allows unique entities to be placed in the love environment.
- *Added player* -  a simple implementation of a class that inherits from base class `ENTITY`.
- *Added rooms* - rooms function as entity containers.
- *Added bounding boxes* - So far it's just a method provided in the official Löve2D documentation, but this will in time be a working collision detection system.
