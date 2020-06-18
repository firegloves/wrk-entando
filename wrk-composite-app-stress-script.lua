local counter = 0
local threads = {}
local endpoints = {
  	[1] = "/entando-de-app/api/users/userProfiles/myGroupPermissions",
  	[2] = "/entando-de-app/api/pages?parentCode=homepage",
  	[3] = "/entando-de-app/api/pageModels?page=1&pageSize=0",
  	[4] = "/entando-de-app/api/pages/homepage?status=draft",
  	[5] = "/entando-de-app/api/widgets?page=1&pageSize=0",
  	[6] = "/entando-de-app/api/groups?page=1&pageSize=0",
  	[7] = "/entando-de-app/api/database?page=1&pageSize=0",
  	[8] = "/entando-de-app/api/languages?page=1&pageSize=0",
  	[9] = "/entando-de-app/api/pages?parentCode=service",
  	[10] = "/entando-de-app/api/userSettings"
  }
-- local statuses = {}

-- PRINT ENTRY
function printEntry(k, v, indent)

    local msg = "%s%s: %s"

    if type(v) == "table" then

        print(msg:format(indent, k, '{'))

        for k_nested, v_nested in pairs(v) do
            printEntry(k_nested, v_nested, indent .. indent)
        end

        print(indent .. '}')
    else
        print(msg:format(indent, k, v))
    end
end



-- SETUP
function setup(thread)
   thread:set("id", counter)
   thread:set("statuses", statuses)
   table.insert(threads, thread)
   counter = counter + 1
end

-- INIT
function init(args)
   requests  = 0
   responses = 0

   jwt = args[1]

   wrk.headers["Accept"] = "*/*"
   wrk.headers["Content-type"] = "application/json"
   wrk.headers["Host"] = "keb-keb.apps.rd.entando.org"
   wrk.headers["Authorization"] = "Bearer " .. jwt

end

-- REQUEST
function request()
   requests = requests + 1
   counter = counter + 1

--    return wrk.format("GET", endpoints[10])
   return wrk.format("GET", endpoints[counter])
end

-- RESPONSE
function response(status, headers, body)
   responses = responses + 1
    if status ~= 200 then
        print('STATUS: ' .. status)
    else
        print('... OK')
    end

--    if statuses[status] == nil then
--    print(' ' )
--            statuses[status] = 0
--    end
--
--    statuses[status] = statuses[status] + 1
end

-- DONE
function done(summary, latency, requests)

 print('##########################')

   for index, thread in ipairs(threads) do
      local id   = thread:get("id")
      local requests  = thread:get("requests")
      local responses = thread:get("responses")
      local msg = "thread %d made %d requests and got %d responses"
      print(msg:format(id, requests, responses))
   end

    print('##########################')

    for k, v in pairs(summary) do
        printEntry(k, v, '    ')
    end

--     print('##########################')
--
--     for index, thread in ipairs(threads) do
--       local statuses = thread:get("statuses")
--       print(statuses)
--       print(table.getn(statuses))
--        for k, v in pairs(statuses) do
--         print(k)
--         print(v)
--               printEntry(k, v, '    ')
--           end
--     end

end