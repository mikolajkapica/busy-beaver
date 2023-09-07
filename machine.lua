local entry = {
    value = 0,
    left = nil,
    right = nil
}

function entry.new(value, left, right)
    local self = setmetatable({}, { __index = entry })
    self.value = value
    self.left = left
    self.right = right
    return self
end

function entry:goLeft()
    if not self.left then
        self.left = entry.new(0, nil, self)
    end
    return self.left
end

function entry:goRight()
    if not self.right then
        self.right = entry.new(0, self, nil)
    end
    return self.right
end

function entry:go(direction)
    if direction == "L" then
        return self:goLeft()
    elseif direction == "R" then
        return self:goRight()
    else
        error("Invalid direction")
    end
end

function entry:printTrack()
    local current = self
    while current.left do
        current = current.left
    end

    local track = ""
    while current do
        track = track .. " " .. current.value
        current = current.right
    end
    return track
end

function entry:set(value)
    self.value = value
    return self
end


local machine = {
    state = "A",
    tape = entry.new(0, nil, nil),
    instructions = {},
    steps = 0
}

function machine:printTrack()
    io.write("Final tape: ..0 0 0", self.tape:printTrack(), " 0 0 0..\nsteps:", self.steps , "\n")
end

function machine:exec()
    local current = self.tape
    while true do
        self.steps = self.steps + 1
        local instruction = self.instructions[self.state][current.value]
        current:set(instruction[1])
        current = current:go(instruction[2])
        self.state = instruction[3]
        if self.state == "H" then
            print("Halted")
            break
        end
    end
    return self
end

function machine:checkIfValidInstructions()
    if #self.instruction ~= 3 then
        error("Invalid instruction")
    end
    if self.instruction[1] ~= 0 and self.instruction[1] ~= 1 then
        error("Invalid instruction")
    end
    if self.instruction[2] ~= "L" and self.instruction[2] ~= "R" then
        error("Invalid instruction")
    end
    if string.match(self.instruction[3], "[A-Z]") ~= self.instruction[3] then
        error("Invalid instruction")
    end
end

function machine:new()
    local self = setmetatable({}, { __index = machine })
    self.state = "A"
    self.tape = entry.new(0, nil, nil)
    self.instructions = {}
    self.steps = 0
    return self
end

function machine:setInstructions(instructions)
    self.instructions = instructions
    return self
end

function machine:run(instructions)
    self:new():setInstructions(instructions):exec():printTrack()
end

return machine 