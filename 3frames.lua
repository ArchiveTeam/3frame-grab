local url_count = 0

local read_file = function(file)
  if file then
    local f = io.open(file)
    local data = f:read("*all")
    f:close()
    return data
  else
    return ""
  end
end

local compare_code = function(a, b)
  i = 1
  n = #(a)
  while i <= n do
    ascii_a = string.byte(a, i)
    ascii_b = string.byte(b, i)
    if ascii_a < 92 and ascii_b > 92 then
      -- a: uppercase, b: lowercase
      return 1
    elseif ascii_a > 92 and ascii_b < 92 then
      -- a: lowercase, b: uppercase
      return -1
    elseif ascii_a < ascii_b then
      return -1
    elseif ascii_a > ascii_b then
      return 1
    end
    i = i + 1
  end
  return 0
end

local increment_code = function(a)
  new_code = ""
  i = #(a)
  carry = true
  while i > 0 do
    ascii_a = string.byte(a, i)
    if carry then
      carry = false
      if ascii_a == string.byte("z") then
        new_code = "A"..new_code
      elseif ascii_a == string.byte("Z") then
        new_code = "a"..new_code
        carry = true
      else
        new_code = string.char(ascii_a + 1)..new_code
      end
    else
      new_code = string.char(ascii_a)..new_code
    end
    i = i - 1
  end
  return new_code
end

wget.callbacks.get_urls = function(file, url, is_css, iri)
  -- progress message
  url_count = url_count + 1
  if url_count % 20 == 0 then
    io.stdout:write("\r - Downloaded "..url_count.." URLs")
    io.stdout:flush()
  end

  local urls = {}

--if url == "http://3fram.es/getMainPosts.php" then
--  local json_str = read_file(file)
--  local latest_code = string.match(json_str, "\\/([a-zA-Z]+)%.gif\",\"")
--  print("Latest code: "..latest_code)
--  local new_code = "aaa"
--  print("Enumerating codes...")
--  while compare_code(new_code, latest_code) <= 0 do
--    table.insert(urls, { url="http://3fram.es/"..new_code })
--    new_code = increment_code(new_code)
--  end
--end

  local m = string.match(url, "^http://3fram%.es/([a-zA-Z])aa$")
  if m then
    print("Enumerating codes for "..m.."??")
    local new_code = m.."aa"
    local latest_code = m.."ZZ"
    while compare_code(new_code, latest_code) <= 0 do
      table.insert(urls, { url="http://3fram.es/"..new_code })
      new_code = increment_code(new_code)
    end
    print "... and we're off."
  end

  local m = string.match(url, "^(http://3fram%.es/gifs/[^/]+/[a-zA-Z]+%).gif$")
  if m then
    -- smaller gif
    table.insert(urls, { url=m.."_s.gif"})
  end

  return urls
end

