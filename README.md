# Unique-Love
A library for Löve2D, that provides a framework for entities and rooms. This project is very much a work in progress see **Version** for more info.

I would recommend not using this code yet, it's very barebones, but it works.

Published under the MIT license.


## Usage
To implement this into your project make sure to place the code in your game files. The needed files are so far `ul-base.EntitySystem.lua` `ul-base.BoundingBox` and `ul-base.RoomSystem.lua`
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
* `ENTITY:createBBox(w,h)` - Creates a boundingbox with given parameters.
* `ENTITY:movement(dt)` - Abstract method, used for objects inherting the entity object, and needs to move in some way.

So far the Room System provides following methods:
* `ROOM:placeEntity(x,y,entity)` - Adds an entity to the room and places it at x,y.
* `ROOM:placeBox(x,y,w,h)` - Adds a simple box to the room with given parameters.
* `ROOM:addEntity(entity,id)` - Adds an existing entity to the room. Can be given an ID(1).
* `ROOM:setAcitve()` - Sets the room active
* `ROOM:setInactive()` - Sets the room inactive
* `ROOM:getEntityCount()` - Returns amount of entities in the room.
* `ROOM:update(dt)` - Updates all entities in the room, this includes calculating movement and checking collisions.
* `ROOM:draw(dt)` - Draws all objects in the room.

So far the BoundingBox system provides following methods:
* `BBOX:new()` - Creates new BBOX.
* `BBOX:CheckBBOXColl(x,y, other)` - Returns true if current BoundingBox collides with other's BoundingBox at the coordinates x,y
* `BBOX:CheckPointColl(x,y, other)` - Returns true if the point x,y is inside other's bbox.
* `BBOX:CheckHLineColl(x,y,w, other)` - Returns true if a horizontal line, starting at x,y with width w, is inside other's bbox.
* `BBOX:CheckVLineColl(x,y,h, other)` - Returns true if a vertical line, starting at x,y with height h, is inside other's bbox.

## Roadmap
- Better keypress handling
- Image and animation support
- Room storage format
- Graphical Editor

## Version 0.2
Core functionality works, additional features missing.

### Changelog

#### V0.2
- *Added better filestructure* - now base functionality is found in `ul-base` and an example-game is included
- *Added functionality to rooms* - rooms can create entities, get already created entities, and be set active/inactive
- *Added collision detection in rooms* - rooms now can check collision detection between all entities in it
- *Expanded BoundingBox functionality* - entities can now be assigned a BoundingBox, it is the box that is used to check collisions.
- *Fixed infinite loop bugs in collisions* - faulty collision detection would result in infinite loops if one entity every found itself inside another.
- *Removed tag-tables* - because of the way LUA handles tables, handling tags inside tables resulted in all entities sharing same tags, now tags are boolean values assigned to entities individually.

#### V0.1
- *Added entities* - the base class that allows unique entities to be placed in the love environment.
- *Added player* -  a simple implementation of a class that inherits from base class `ENTITY`.
- *Added rooms* - rooms function as entity containers.
- *Added bounding boxes* - So far it's just a method provided in the official Löve2D documentation, but this will in time be a working collision detection system.
