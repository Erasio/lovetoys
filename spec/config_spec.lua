local classes = {
    "Entity",
    "Engine",
    "Component",
    "EventManager",
    "System",
    "util",
    "class",
    "ComponentAdded",
    "ComponentRemoved"
}

describe('Configuration', function()
    it('injects classes into the global namespace if globals = true is passed', function()
        local env = {}
        setmetatable(_G, {
            __newindex = function(table, key, value)
                env[key] = value
            end,
            __index = function(table, key)
                return env[key]
            end
        })
        local factory = require('lovetoys')
        factory({ globals = true })

        for _, entry in ipairs(classes) do
            assert.not_nil(env[entry])
        end

        setmetatable(_G, nil)
    end)

    it('doesnt modify the global table by default', function()
        require('lovetoys')()

        for _, entry in ipairs(classes) do
            assert.is_nil(_G[entry])
        end
    end)
end)
