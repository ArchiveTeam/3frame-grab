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

wget.callbacks.get_urls = function(file, url, is_css, iri)
  -- progress message
  url_count = url_count + 1
  if url_count % 20 == 0 then
    io.stdout:write("\r - Downloaded "..url_count.." URLs")
    io.stdout:flush()
  end

  local urls = {}

  local m = string.match(url, "^http://3fram%.es/gallery%?p=([0-9]+)$")
  if m then
    local html_str = read_file(file)
    for img in string.gmatch(html_str, "href=\"(http://3fram%.es/[A-Za-z0-9]+)\"><img class=\"gridpic") do
      table.insert(urls, { url=img, link_expect_html=1 })
    end
  end

  local m = string.match(url, "^(http://3fram%.es/gifs/[^/]+/[A-Za-z0-9]+%).gif$")
  if m then
    -- smaller gif
    table.insert(urls, { url=m.."_s.gif"})
  end

  return urls
end

