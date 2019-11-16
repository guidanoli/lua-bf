-- Brainfuck Interpreter

-- For debugging purposes
function dump_ (t, sep)
    for k, v in pairs(t) do
        if type(v) == "table" then
            print(sep.."["..tostring(k).."] = {")
            dump_(v, sep .. "\t")
            print(sep.."}")
        else
            print(sep.."["..tostring(k).."] = "..tostring(v))
        end
    end
end

function dump (t)
    print("{")
    dump_(t, "\t")
    print("}")
end
------------------------------

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
    local loop = code:sub(ini, fin):match("%[(.*)%]")
    local loop_idx = #loops + 1
    loops[loop_idx] = loop
    code = code:sub(1, ini-1) .. "("..loop_idx..")" .. code:sub(fin+1,#code)
    ini, fin = code:find("%[[^%[%]]*%]")
end

local procedures = {}

function build_procedure_table (s)
    local t = {}
    local inicode = s:match("([><+-.,]*)")
    if #inicode > 0 then table.insert(t, inicode) end
    for _, proc, code in s:gmatch("(%((%d+)%))([><+-.,]*)") do
        if #proc > 0 then table.insert(t, tonumber(proc)) end
        if #code > 0 then table.insert(t, code) end
    end
    return t
end

procedures[0] = build_procedure_table(code)
for proc_id, proc_cod in ipairs(loops) do
    procedures[proc_id] = build_procedure_table(proc_cod)
end

function build_code_table (proc_id)
    local t = procedures[proc_id]
    for i, v in ipairs(t) do
        print(i, v, type(v))
        if type(v) == "number" then
            t[i] = build_code_table(v)
        end
    end
    return t
end

code_table = build_code_table(0)

dump(code_table)
