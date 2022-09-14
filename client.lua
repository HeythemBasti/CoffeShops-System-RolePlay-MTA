screenWidth, screenHeight = guiGetScreenSize() -- مقاسات الصفحة
windowSold =  guiCreateWindow(0.23, 0.01, 0.59, 0.91, "Sold", true) -- لوحة gui عادية نصممها لنعرض داخلها html
guiSetAlpha(windowSold, 0.00)  -- نخفي لوحة Gui 
local browserSold = guiCreateBrowser(0, 0, screenWidth, screenHeight, true, false, false,windowSold) -- عرض المتصفح

guiSetVisible ( windowSold, false ) -- اول ما نشغل المود نخفي الصفحة من الظهور

local thebrowserSold = guiGetBrowser( browserSold )

addEventHandler("onClientBrowserCreated", thebrowserSold, 
	function()
		loadBrowserURL(source, "http://mta/CAFESHOPS/index.html") -- هنا اسم المود ومسار ملف ال html
	end 
)



function sold(player)
if (player == "sold") then

local localPlayer1 = getLocalPlayer()
local charID = getElementData(localPlayer1, "dbid")
local shopIdOwner = getElementData(getLocalPlayer(),"getOwnerIDClnt")

triggerServerEvent("soldWater", localPlayer,localPlayer1,charID,shopIdOwner)


setElementFrozen(localPlayer1,false)

showCursor ( false)
guiSetVisible ( windowSold, false)
showChat(true) 
   end   
end
addEvent("sold", true)
addEventHandler("sold", root, sold)


---------------------------------------------------------------------------------------
function sold6(player)
if (player == "sold6") then

local localPlayer1 = getLocalPlayer()
local charID = getElementData(localPlayer1, "dbid")
local shopIdOwner = getElementData(getLocalPlayer(),"getOwnerIDClnt")

triggerServerEvent("soldFood", localPlayer,localPlayer1,charID,shopIdOwner)


setElementFrozen(localPlayer1,false)

showCursor ( false)
guiSetVisible ( windowSold, false)
showChat(true) 
   end   
end
addEvent("sold6", true)
addEventHandler("sold6", root, sold6)



---------------------------------------------------------------------------------------

function openSOLD(hit, dim)
	
	local px, py, pz = getElementPosition(getLocalPlayer())
	local mpx = getElementData(getLocalPlayer(),"placeToCheck")
	
	if not mpx then return end
	local distance = getDistanceBetweenPoints3D(px, py, pz, mpx[1],mpx[2],mpx[3])
	
	if tonumber(distance) < 4 then
						
if guiGetVisible ( windowSold ) == false then
showCursor ( true )
guiSetVisible ( windowSold, true)
  showChat(false) 
else
showCursor ( false)
guiSetVisible ( windowSold, false)
  showChat(true) 
end
	end
end
 bindKey ( "INSERT", "down", openSOLD )




----------------------------------------------------------------------------------------------





