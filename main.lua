local machine = require "machine"

--  1-state 2-symbol busy beaver
--    | A           |
--  0 | 1RH         |
--  1 | (not used)  |

local instructions = {}
instructions["A"] = {
        [0] = { 1, "R", "H" },
        [1] = {1, 2}
}
machine:run(instructions)
print()

-- 3-state, 2-symbol busy beaver
--   	A	B
-- 0	1RB	1LA
-- 1	1LB	1RH
local instructions = {}
instructions["A"] = {
        [0] = { 1, "R", "B" },
        [1] = { 1, "L", "B" }
}
instructions["B"] = {
        [0] = { 1, "L", "A" },
        [1] = { 1, "R", "H" }
}
machine:run(instructions)

-- 4-state, 2-symbol busy beaver
--      A	B	C	D
-- 0	1RB	1LA	1RH	1RD
-- 1	1LB	0LC	1LD	0RA
local instructions = {}
instructions["A"] = {
        [0] = { 1, "R", "B" },
        [1] = { 1, "L", "B" }
}
instructions["B"] = {
        [0] = { 1, "L", "A" },
        [1] = { 0, "L", "C" }
}
instructions["C"] = {
        [0] = { 1, "R", "H" },
        [1] = { 1, "L", "D" }
}
instructions["D"] = {
        [0] = { 1, "R", "D" },
        [1] = { 0, "R", "A" }
}
machine:run(instructions)
print()

-- current 5-state, 2-symbol best contender (possible busy beaver)
--   	A	B	C	D	E
-- 0	1RB	1RC	1RD	1LA	1RH
-- 1	1LC	1RB	0LE	1LD	0LA
local instructions = {}
instructions["A"] = {
        [0] = { 1, "R", "B" },
        [1] = { 1, "L", "C" }
}
instructions["B"] = {
        [0] = { 1, "R", "C" },
        [1] = { 1, "R", "B" }
}
instructions["C"] = {
        [0] = { 1, "R", "D" },
        [1] = { 0, "L", "E" }
}
instructions["D"] = {
        [0] = { 1, "L", "A" },
        [1] = { 1, "L", "D" }
}
instructions["E"] = {
        [0] = { 1, "R", "H" },
        [1] = { 0, "L", "A" }
}

machine:run(instructions) -- 47176870 steps !!!
print()

