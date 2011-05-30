
-- moved the worker thread to own file so we cant pick up any out of thread upvalues by mistake

module(...)

-----------------------------------------------------------------------------
--
-- the generic worker thread function
--
-- used to create new worker threads
--
-- pass in a linda and an id to use on that linda for coms
--
-- this function needs to require and setup the things it neads as otherwise it has nothing
--
-----------------------------------------------------------------------------
function lanes_worker(linda,idx)

package.cpath=wetlua.cpath -- and set paths so we can find things
package.path=wetlua.path


local http=require("socket.http")

-----------------------------------------------------------------------------
--
-- return a msg from a worker
--
-----------------------------------------------------------------------------
function lanes_return(linda,msg,ret)
	
	if work_lanes_disable then
	
		return ret
	
	else

		linda:send(nil,0,{ cmd="ret" , id=msg.id , ret=ret })
	
	end
	
	return nil
	
end

-----------------------------------------------------------------------------
--
-- perform the end in the worker
--
-----------------------------------------------------------------------------
function lanes_end_worker(linda,msg)

local kay=math.floor(collectgarbage("count"))
	print("lua thread was using "..kay.."k\n")
					
	linda:send(nil,0,{ cmd="end" , id=msg.id })

end

-----------------------------------------------------------------------------
--
-- get url content
--
-----------------------------------------------------------------------------
function lanes_url_worker(linda,msg)

local body, headers, code = http.request(msg.url)

local ret={}

	ret.body=body
	ret.headers=headers
	ret.code=code
	
	return lanes_return(linda,msg,ret)
--	linda:send(nil,0,{ cmd="ret" , id=msg.id , ret=ret })

end



local loop=true

	while loop do

	local msg= linda:receive( nil, idx )

--print(idx," : ",msg.cmd,"\n")
	
		if msg then
		
			if msg.cmd=="end" then

				lanes_end_worker(linda,msg)
				
				return -- finish since we where told to
					
			elseif msg.cmd=="url" then
			
				lanes_url_worker(linda,msg)
			
			end
			
-- requests can be large hits on memory, so
-- perform a full garbage collect after every request?
--			collectgarbage("collect")
			
		end
	end
	
end
