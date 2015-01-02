Entity = class("Entity")

function Entity:__init(parent)
    self.components = {}
    self.eventManager = nil
    self.alive = true
    if parent then
        self:setParent(parent)
    else
        parent = nil
    end
    self.children = {}
end

-- Sets the entities component of this type to the given component.
-- An entity can only have one Component of each type.
function Entity:add(component)
    if self.components[component.__name] then 
        print("Trying to add " .. component.__name .. ", but it's already existing. Please use Entity:set to overwrite a component in an entity.")
    else
        self.components[component.__name] = component
        if self.eventManager then
            self.eventManager:fireEvent(ComponentAdded(self, component.__name))
        end
    end
end

function Entity:set(component)
    if self.components[component.__name] == nil then
        self:add(component)
    else
        self.components[component.__name] = component
    end
end

function Entity:addMultiple(componentList)
    for _, component in  pairs(componentList) do
        self:add(component)
    end
end

-- Removes a component from the entity.
function Entity:remove(name)
    if self.components[name] then
        self.components[name] = nil
    else
        print("Trying to remove unexisting component " .. name .. " from Entity. Please fix this")
    end
    if self.eventManager then
        self.eventManager:fireEvent(ComponentRemoved(self, name))
    end
end

function Entity:setParent(parent)
    self.parent = parent
end

function Entity:getParent(parent)
    return self.parent
end

function Entity:registerAsChild()
    self.parent.children[self.id] = self
end

function Entity:get(name)
    return self.components[name]
end

function Entity:has(name)
    if self.components[name] then
        return true
    else
        return false
    end
end

function Entity:getComponents()
    return self.components
end

function Entity:has(name)
    return not (self:get(name) == nil)
end

