-- Brainfuck Interpreter

local code = io.read("*all"):gsub("[^><+-.,%[%]]", "")

local bracket_lvl = 0
for c in code:gmatch("[%[%]]") do
    bracket_lvl = bracket_lvl + (c == "[" and 1 or -1)
end
if bracket_lvl ~= 0 then
    print("Wrong bracketing!")
    os.exit()
end

local ini = 1
local fin = 1
local loops = {}
ini, fin = code:find("%[[^%[%]]*%]")
while ini ~= nil do
    local loop = code:sub(ini, fin)
    local loop_idx = #loops + 1
    loops[loop_idx] = loop
    code = code:sub(1, ini-1) .. "("..loop_idx..")" .. code:sub(fin+1,#code)
    ini, fin = code:find("%[[^%[%]]*%]")
end


-- print(code)
-- for k, v in ipairs(loops) do
--     print(k, v)
-- end
