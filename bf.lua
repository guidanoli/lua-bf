-- Brainfuck Interpreter

local code = io.read("*all"):gsub("[^><+-.,%[%]]", "")

local bracket_lvl = 0
for c in code:gmatch("[%[%]]") do
    bracket_lvl = bracket_lvl + (c == "[" and 1 or -1)
    if bracket_lvl < 0 then
        io.stderr:write("Wrong bracketing!\n")
        os.exit()
    end
end
if bracket_lvl ~= 0 then
    io.stderr:write("Wrong bracketing!\n")
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
        if type(v) == "number" then
            t[i] = build_code_table(v)
        end
    end
    return t
end

local code_table = build_code_table(0)
local tape_table = { [0] = 0 }
local head_loc = 0

function run_code (proc_s)
    for c in proc_s:gmatch(".") do
        if c == "+" then
            tape_table[head_loc] = tape_table[head_loc] + 1
        elseif c == "-" then
            tape_table[head_loc] = tape_table[head_loc] - 1
        elseif c == "<" then
            head_loc = head_loc - 1
        elseif c == ">" then
            head_loc = head_loc + 1
        elseif c == "." then
            io.write(string.char(tape_table[head_loc]))
        elseif c == "," then
            local ch = io.read(1)
            tape_table[head_loc] = ch and ch:byte() or 0
        end
        tape_table[head_loc] = tape_table[head_loc] and
            (tape_table[head_loc] % (2^32)) or 0
    end
end

function run_procedure (proc_t)
    for _, subproc in ipairs(proc_t) do
        if type(subproc) == "table" then
            while tape_table[head_loc] ~= 0 do
                run_procedure(subproc)
            end
        else
            run_code(subproc)
        end
    end
end

run_procedure(code_table)
