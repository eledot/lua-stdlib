-- I/O

require "std.data.code"


-- EOL string
endOfLine = "\n"

-- @func readLines: Read a file into a list of lines and close the file
--   @param [h]: file handle or name [io.input ()]
-- returns
--   @param l: list of lines
function readLines (h)
  if h == nil then
    h = io.input ()
  elseif type (h) == "string" then
    h = io.open (h)
  end
  local l = {}
  for line in h:lines () do
    table.insert (l, line)
  end
  h:close ()
  return l
end

-- @func writeLine: Write values adding a newline after each
--   @param [h]: file handle [current output file]
--   @param ...: values to write (as for write)
function writeLine (h, ...)
  if io.type (h) == "file" then
    io.output (h)
  else
    table.insert (arg, 1, h)
  end
  for i = 1, table.getn (arg) do
    io.write (arg[i], endOfLine)
  end
end

-- @func changeSuffix: Change the suffix of a filename
--   @param from: suffix to change [.-]
--   @param to: suffix to replace with
--   @param name: file name to change
-- returns
--   @param name_: file name with new suffix
function changeSuffix (from, to, name)
  local from = from or ".-"
  return string.gsub (name, "%." .. from .. "$", "") .. "." .. to
end

-- @func addSuffix: Add a suffix to a filename
--   @param suff: suffix to add
--   @param name: file name to change
-- returns
--   @param name_: file name with new suffix
function addSuffix (suff, name)
  return changeSuffix (suff, suff, name)
end
