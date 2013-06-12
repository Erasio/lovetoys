ExampleSystem = class("ExampleSystem", System)

function ExampleSystem:__init()

end

function ExampleSystem:update(dt)
	for index, value in pairs(self.targets) do
		value:getComponent("ExampleComponent").timer = value:getComponent("ExampleComponent").timer+dt
	end
end


function ExampleSystem:getRequiredComponents()
	return {"ExampleComponent"}
end