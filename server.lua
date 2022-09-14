

addEventHandler ("onResourceStart", resourceRoot, function()
 local delkeys = exports.sal:_Query( "SELECT * FROM CAFESHOPS " )
 
 for i, data in pairs (delkeys) do
	   data["shopID"] = createMarker (tonumber(data["SellposX"]), tonumber(data["SellposY"]), tonumber(data["SellposZ"])-1, "cylinder", 1.5, 50, 0, 0,170)
	   setElementDimension(data["shopID"], tonumber(data["SellDim"]))
       setElementInterior( data["shopID"], tonumber(data["SellInt"]))
	   setElementData( data["shopID"],"getOwnerID" ,tonumber(data["ownerCharID"]))
	   addEventHandler ("onMarkerHit", data["shopID"], hitMarker)
	   addEventHandler ("onMarkerLeave", data["shopID"], hitMarkerLeave)

	   data["stockID"] = createMarker (tonumber(data["StockPosX"]), tonumber(data["StockPosY"]), tonumber(data["StockPosZ"])-1, "cylinder", 3.5, 50, 0, 0,170)
	   setElementDimension(data["stockID"], tonumber(data["StockDim"]))
       setElementInterior(data["stockID"], tonumber(data["StockInt"]))
	   setElementData(data["stockID"],"getOwnerIDStock" ,data["ownerCharID"])
	   addEventHandler ("onMarkerHit", data["stockID"], hitMarkerStock)



 end

end)


function hitMarker (el)
if getElementType (el) == "player" then
        local posX, posY, posZ = getElementPosition(el)
pos = {
	["rentPlace"] = { posX, posY, posZ}, -- marker
	}
	local ownerCharID = getElementData(source,"getOwnerID")
	
	   setElementData(el,"placeToCheck",pos["rentPlace"])
	   setElementData(el,"getOwnerIDClnt",ownerCharID)
end
end
 
 function hitMarkerLeave (el)
if getElementType (el) == "player" then

	   setElementData(el,"placeToCheck",false)
end
end





function hitMarkerStock (el)
if getElementType (el) == "player" then

	local ownerCharID = getElementData(source,"getOwnerIDStock")
	
	                                     if getElementData(el,"dbid") ~= ownerCharID then 
                                                     outputChatBox(" Owner ONLY !!  ", el, 255, 0, 0, true)
                                         elseif getElementData(el,"dbid") == ownerCharID then
       

	   local getTable = exports.sal:_QuerySingle( "SELECT * FROM CAFESHOPS WHERE ownerCharID= ?", ownerCharID)

	   
if not exports.global:hasItem(el, 79) and not exports.global:hasItem(el, 183) then          -- item fardo check

outputChatBox(" انت لا تحمل اي سلعة معك ", el, 255, 0, 0, true)

elseif exports.global:hasItem(el, 183) then
     
	 outputChatBox(" انت تحمل معك طعام ", el, 255, 0, 0, true)  
	 
         local sucess1, key1, itemvalue1 = exports.global:hasItem(el, 183)
		 
                  if getTable.Food > 1200 then                            -- stock limit check
                           outputChatBox(" وصلت للحد الاقصى للتخزين ", el, 255, 0, 0, true)
                  return end

if exports.global:takeItem( el, 183, itemvalue1) then   -- add new stock


local newVal1 = getTable.Food + 12 

exports.sal:_Exec("UPDATE `CAFESHOPS` SET `Food` = ? WHERE `ownerCharID` = " .. ownerCharID.."",newVal1)

outputChatBox("تمت اضافة |".. newVal1 .."|  طعام  ", el, 0, 255, 0, true)

end

elseif  exports.global:hasItem(el, 79) then           -- has fardo

         local sucess, key, itemvalue = exports.global:hasItem(el, 79)

if getTable.Water > 1200 then                            -- stock limit check

outputChatBox("وصلت للحد الاقصى للتخزين ", el, 255, 0, 0, true)

return end

if exports.global:takeItem( el, 79, itemvalue) then   -- add new stock


local newVal = getTable.Water + 12 

exports.sal:_Exec("UPDATE `CAFESHOPS` SET `Water` = ? WHERE `ownerCharID` = " .. ownerCharID.."",newVal)

outputChatBox("تمت اضافة |".. newVal .."|  قارورة مياه ", el, 0, 255, 0, true)




end

end
	       end
	   end
end
 








 function addMarkerSell(source,ownerCharID1,ownerCharID)

 	if (exports.integration:isPlayerTrialAdmin(source)) then
    if ownerCharID == "" then
outputChatBox("CharID يجب ان لا تكون فارغة", localPlayer1, 255, 0, 0)
    elseif   ownerCharID == nil then
outputChatBox("CharID يجب ان لا تكون فارغة", localPlayer1, 255, 0, 0)
	elseif string.len(ownerCharID) < 0 then
outputChatBox("CharID على الاقل رقم واحد", localPlayer1, 255, 0, 0)
	elseif string.len(ownerCharID) > 7 then
outputChatBox("CharID يجب ان يكون اقل من 7 ارقام", localPlayer1, 255, 0, 0)
	elseif string.find(ownerCharID, "'") or string.find(ownerCharID, '"') then
outputChatBox( "CharID خطأ اكتب قيمة رقم حقيقي ", localPlayer1, 255, 0, 0)
	elseif string.match(ownerCharID,"%W") then
	outputChatBox( "CharID خطأ اكتب قيمة رقم حقيقي ", localPlayer1, 255, 0, 0)

else

        local posX, posY, posZ = getElementPosition(source)
		local dimension = getElementDimension(source)
	    local interiorchk = getElementInterior(source)
		local createduser = getElementData(source, "account:username")
		local createdchar = getElementData(source, "dbid")
		local createdbyuser = ""..createduser .. "--"..createdchar ..""

		if dimension == 0 and interiorchk == 0 then 
		outputChatBox("لا يمكنك فعل هاذا في الخارج", source, 255, 255, 0)
		return end		
		
		    local possibleInteriors = exports.pool:getPoolElementsByType('interior')
		for _, interior in ipairs(possibleInteriors) do
			local interiorEntrance = getElementData(interior, "entrance")
			local interiorExit = getElementData(interior, "exit")
		for _, point in ipairs( { interiorExit } ) do
			
			if (point[5] == dimension) then
					local distance = getDistanceBetweenPoints3D(posX, posY, posZ, point[1], point[2], point[3])
			if (distance <= 50) then
			      local dbid = getElementData(interior, "dbid")
                  local q = exports.sal:_QuerySingle( "SELECT type FROM interiors WHERE id = ?", dbid )


if q.type == 0 then   --house

             if not exports.global:hasItem(source, 4,dbid) then 
                   outputChatBox("ماهيش دارك اودي احشم", source, 255, 126, 0)		
             return end
           
		   
		     if exports.global:hasItem(source, 4,dbid) then 

		            local Sleep = getElementData(source, "Sleep")
				
				end



elseif q.type == 3 then  --Rentable


             if not exports.global:hasItem(source, 4,dbid) then 
                   outputChatBox("ليس لديك اي حق هنا", source, 255, 126, 0)		
             return end
           
		   
		     if exports.global:hasItem(source, 4,dbid) then 
			local thePlayerOwner = exports.global:getPlayerFromCharacterID(ownerCharID)

if not thePlayerOwner then
				                   outputChatBox("لايوجد لاعب او الاعب اوفلاين", source, 255, 126, 0)		

elseif thePlayerOwner then

		         local sk = getPlayerName(thePlayerOwner)

				outputChatBox("هل انت متأكد انك سوف تكتب الشوب بأسم ".. sk .."", source, 255, 126, 0)
				
		setTimer(function()
                          setElementData(source,"addSellConfirm",getPlayerName(thePlayerOwner))
		end,505,1)
		
		
if getElementData(source,"addSellConfirm") == getPlayerName(thePlayerOwner) then

       local markersell = createMarker(posX, posY, posZ-1,"cylinder",  1.5, 50, 0, 0, 170 )
	                       setElementDimension( markersell, dimension)
                           setElementInterior( markersell, interiorchk)
	   local thePlayerOwner = exports.global:getPlayerFromCharacterID(ownerCharID)
	   
		setTimer(function()
                          setElementData(source,"addSellConfirm",false)		
		end,505,1)

exports.sal:_Exec("INSERT INTO `CAFESHOPS` (`shopID`, `ShopintDBID`, `SellposX`, `SellposY`, `SellposZ`, `SellDim`, `SellInt`, `ownerCharID`, `createdBY`) values (NULL,?, ?, ?, ?, ?, ?, ?, ?)",dbid,posX,posY,posZ,dimension,interiorchk,ownerCharID,createdbyuser)

				           outputChatBox("تم صناعة الشوب بنجاح ", source, 0, 255, 0)		

				
				        end
				   
				end
		end


elseif q.type == 1 then    -- BUSSINES



             if not exports.global:hasItem(source, 5,dbid) then 
                   outputChatBox("ليس لديك اي حق هنا", source, 255, 126, 0)		
             return end
           
		   
		     if exports.global:hasItem(source, 5,dbid) then 
			local thePlayerOwner = exports.global:getPlayerFromCharacterID(ownerCharID)

if not thePlayerOwner then
				                   outputChatBox("لايوجد لاعب او الاعب اوفلاين", source, 255, 126, 0)		

elseif thePlayerOwner then

		         local sk = getPlayerName(thePlayerOwner)

				outputChatBox("هل انت متأكد انك سوف تكتب الشوب بأسم ".. sk .."", source, 255, 126, 0)
				
		setTimer(function()
                          setElementData(source,"addSellConfirm",getPlayerName(thePlayerOwner))
		end,505,1)
		
		
if getElementData(source,"addSellConfirm") == getPlayerName(thePlayerOwner) then

       local markersell = createMarker(posX, posY, posZ-1,"cylinder",  1.5, 50, 0, 0, 170 )
	                       setElementDimension( markersell, dimension)
                           setElementInterior( markersell, interiorchk)
	   local thePlayerOwner = exports.global:getPlayerFromCharacterID(ownerCharID)
	   
		setTimer(function()
                          setElementData(source,"addSellConfirm",false)		
		end,505,1)

exports.sal:_Exec("INSERT INTO `CAFESHOPS` (`shopID`, `ShopintDBID`, `SellposX`, `SellposY`, `SellposZ`, `SellDim`, `SellInt`, `ownerCharID`, `createdBY`) values (NULL,?, ?, ?, ?, ?, ?, ?, ?)",dbid,posX,posY,posZ,dimension,interiorchk,ownerCharID,createdbyuser)

				           outputChatBox("تم صناعة الشوب بنجاح ", source, 0, 255, 0)		

				
				        end
				   
				end
		end


elseif q.type == 2 then  -- goverment bulding


             if not exports.global:hasItem(source, 4,dbid) then 
                   outputChatBox("لا تملك هاذا المكان", source, 255, 126, 0)		
             return end
           
		   
		     if exports.global:hasItem(source, 4,dbid) then 
			
	      outputChatBox("لا يمكنك في مبنى حكومي ", source, 255, 126, 0)		
						   
				end




end --- t3 int type



            end

         end

     end

end


end
end
end
addCommandHandler("addSM", addMarkerSell, false, false)








------------------------------------------------------------------------------------------------------------------















 function addMarkerStock(source,ownerCharID1,ownerCharID)
 	if (exports.integration:isPlayerTrialAdmin(source)) then
    if ownerCharID == "" then
outputChatBox("CharID يجب ان لا تكون فارغة", localPlayer1, 255, 0, 0)
    elseif   ownerCharID == nil then
outputChatBox("CharID يجب ان لا تكون فارغة", localPlayer1, 255, 0, 0)
	elseif string.len(ownerCharID) < 0 then
outputChatBox("CharID على الاقل رقم واحد", localPlayer1, 255, 0, 0)
	elseif string.len(ownerCharID) > 7 then
outputChatBox("CharID يجب ان يكون اقل من 7 ارقام", localPlayer1, 255, 0, 0)
	elseif string.find(ownerCharID, "'") or string.find(ownerCharID, '"') then
outputChatBox( "CharID خطأ اكتب قيمة رقم حقيقي ", localPlayer1, 255, 0, 0)
	elseif string.match(ownerCharID,"%W") then
	outputChatBox( "CharID خطأ اكتب قيمة رقم حقيقي ", localPlayer1, 255, 0, 0)

else

        local posX, posY, posZ = getElementPosition(source)
		local dimension = getElementDimension(source)
	    local interiorchk = getElementInterior(source)
		
		if dimension == 0 and interiorchk == 0 then 
		outputChatBox("لا يمكنك فعل هاذا في الخارج", source, 255, 255, 0)
		return end		
		
		    local possibleInteriors = exports.pool:getPoolElementsByType('interior')
		for _, interior in ipairs(possibleInteriors) do
			local interiorEntrance = getElementData(interior, "entrance")
			local interiorExit = getElementData(interior, "exit")
		for _, point in ipairs( { interiorExit } ) do
			
			if (point[5] == dimension) then
					local distance = getDistanceBetweenPoints3D(posX, posY, posZ, point[1], point[2], point[3])
			if (distance <= 50) then
			      local dbid = getElementData(interior, "dbid")
                  local q = exports.sal:_QuerySingle( "SELECT type FROM interiors WHERE id = ?", dbid )


if q.type == 0 then   --house

             if not exports.global:hasItem(source, 4,dbid) then 
                   outputChatBox("ماهيش دارك اودي احشم", source, 255, 126, 0)		
             return end
           
		   
		     if exports.global:hasItem(source, 4,dbid) then 

                   outputChatBox("هاذي دار ماهيش حانوت", source, 255, 126, 0)		
				
				end



elseif q.type == 3 then  --Rentable

             if not exports.global:hasItem(source, 4,dbid) then 
                   outputChatBox("ليس لديك اي حق هنا", source, 255, 126, 0)		
             return end
           
		   
		     if exports.global:hasItem(source, 4,dbid) then 
			local thePlayerOwner = exports.global:getPlayerFromCharacterID(ownerCharID)

if not thePlayerOwner then
				                   outputChatBox("لايوجد لاعب او الاعب اوفلاين", source, 255, 126, 0)		

elseif thePlayerOwner then

		         local sk = getPlayerName(thePlayerOwner)

				outputChatBox("هل انت متأكد انك سوف تكتب الشوب بأسم ".. sk .."", source, 255, 126, 0)
				
		setTimer(function()
                          setElementData(source,"addStockConfirm",getPlayerName(thePlayerOwner))
		end,505,1)

				 local shopidd = exports.sal:_QuerySingle( "SELECT shopID FROM CAFESHOPS WHERE `ownerCharID` = " .. ownerCharID .."")
				 
if getElementData(source,"addStockConfirm") == getPlayerName(thePlayerOwner) then

       local markersell = createMarker(posX, posY, posZ-1,"cylinder",  3.5, 50, 0, 0, 170 )
	                       setElementDimension( markersell, dimension)
                           setElementInterior( markersell, interiorchk)
	   local thePlayerOwner = exports.global:getPlayerFromCharacterID(ownerCharID)
	   
		setTimer(function()
                          setElementData(source,"addStockConfirm",false)		
		end,505,1)
exports.sal:_Exec("UPDATE `CAFESHOPS` SET `stockID` = '"..shopidd.shopID.."', `StockPosX` = '"..posX.."',`StockPosY` = '"..posY.."', `StockPosZ` = '"..posZ.."', `StockDim` = '"..dimension.."', `StockInt` = '"..interiorchk.."' WHERE `ownerCharID` = " .. ownerCharID .."")

				           outputChatBox("ID # "..shopidd.shopID.." تم صناعة الشوب بنجاح ", source, 0, 255, 0)		

				
				        end
				   
				end
		end


elseif q.type == 1 then    -- BUSSINES



             if not exports.global:hasItem(source, 5,dbid) then 
                   outputChatBox("ليس لديك اي حق هنا", source, 255, 126, 0)		
             return end
           
		   
		     if exports.global:hasItem(source, 5,dbid) then 
			local thePlayerOwner = exports.global:getPlayerFromCharacterID(ownerCharID)

if not thePlayerOwner then
				                   outputChatBox("لايوجد لاعب او الاعب اوفلاين", source, 255, 126, 0)		

elseif thePlayerOwner then

		         local sk = getPlayerName(thePlayerOwner)

				outputChatBox("هل انت متأكد انك سوف تكتب الشوب بأسم ".. sk .."", source, 255, 126, 0)
				
		setTimer(function()
                          setElementData(source,"addStockConfirm",getPlayerName(thePlayerOwner))
		end,505,1)

				 local shopidd = exports.sal:_QuerySingle( "SELECT shopID FROM CAFESHOPS WHERE `ownerCharID` = " .. ownerCharID .."")
				 
if getElementData(source,"addStockConfirm") == getPlayerName(thePlayerOwner) then

       local markersell = createMarker(posX, posY, posZ-1,"cylinder",  3.5, 50, 0, 0, 170 )
	                       setElementDimension( markersell, dimension)
                           setElementInterior( markersell, interiorchk)
	   local thePlayerOwner = exports.global:getPlayerFromCharacterID(ownerCharID)
	   
		setTimer(function()
                          setElementData(source,"addStockConfirm",false)		
		end,505,1)
exports.sal:_Exec("UPDATE `CAFESHOPS` SET `stockID` = '"..shopidd.shopID.."', `StockPosX` = '"..posX.."',`StockPosY` = '"..posY.."', `StockPosZ` = '"..posZ.."', `StockDim` = '"..dimension.."', `StockInt` = '"..interiorchk.."' WHERE `ownerCharID` = " .. ownerCharID .."")

				           outputChatBox("ID # "..shopidd.shopID.." تم صناعة الشوب بنجاح ", source, 0, 255, 0)		

				
				        end
				   
				end
		end



elseif q.type == 2 then  -- goverment bulding


             if not exports.global:hasItem(source, 4,dbid) then 
                   outputChatBox("لا تملك هاذا المكان", source, 255, 126, 0)		
             return end
           
		   
		     if exports.global:hasItem(source, 4,dbid) then 
			
	      outputChatBox("لا يمكنك في مبنى حكومي ", source, 255, 126, 0)		
						   
				end




end --- t3 int type



            end

         end

     end

end

end
end
end
addCommandHandler("addstockm", addMarkerStock, false, false)

-----------------------------------------------------------------------------------------------------------



 function delShop(source,ownerCharID1,shopID)
 	if (exports.integration:isPlayerTrialAdmin(source)) then
    if shopID == "" then
outputChatBox("shopID يجب ان لا تكون فارغة", localPlayer1, 255, 0, 0)
    elseif   shopID == nil then
outputChatBox("shopID يجب ان لا تكون فارغة", localPlayer1, 255, 0, 0)
	elseif string.len(shopID) < 0 then
outputChatBox("shopID على الاقل رقم واحد", localPlayer1, 255, 0, 0)
	elseif string.len(shopID) > 7 then
outputChatBox("shopID يجب ان يكون اقل من 7 ارقام", localPlayer1, 255, 0, 0)
	elseif string.find(shopID, "'") or string.find(shopID, '"') then
outputChatBox( "shopID خطأ اكتب قيمة رقم حقيقي ", localPlayer1, 255, 0, 0)
	elseif string.match(shopID,"%W") then
	outputChatBox( "shopID خطأ اكتب قيمة رقم حقيقي ", localPlayer1, 255, 0, 0)

else
		       	     local getCharIdFromShopId = exports.sal:_QuerySingle( "SELECT ownerCharID FROM CAFESHOPS WHERE shopID = ?", shopID)
					 if getCharIdFromShopId == nil then
					 			 outputChatBox("لا يوجد شوب بهاذا الايدي اعد المحاولة بعد التحقق", source, 255, 126, 0)

					 return end
					 
                     local getCharName = exports.sal:_QuerySingle( "SELECT charactername FROM characters WHERE id = ?", getCharIdFromShopId.ownerCharID)

			 outputChatBox("هل انت متاكد انك ستحذف الشوب رقم ".. shopID .." المكتوب بأسم ".. getCharName.charactername .."", source, 255, 126, 0)
				
		 setTimer(function()
                           setElementData(source,"delshopConfirm",shopID)
		 end,505,1)

				 
 if getElementData(source,"delshopConfirm") == shopID then


               exports.sal:_Exec("DELETE FROM CAFESHOPS WHERE shopID=?", shopID)
			   
 				outputChatBox("تم حذف الشوب رقم ".. shopID .." بنجاح", source, 255, 126, 0)
				
              end
        end
		end
end
addCommandHandler("delthisShop", delShop, false, false)




 function thisShop(source,ownerCharID1)
 	if (exports.integration:isPlayerTrialAdmin(source)) then
	
	  local posX, posY, posZ = getElementPosition(source)
		local dimension = getElementDimension(source)
	    local interiorchk = getElementInterior(source)
		
		if dimension == 0 and interiorchk == 0 then 
		outputChatBox("لا يمكنك فعل هاذا في الخارج", source, 255, 255, 0)
		return end		
		
		    local possibleInteriors = exports.pool:getPoolElementsByType('interior')
		for _, interior in ipairs(possibleInteriors) do
			local interiorEntrance = getElementData(interior, "entrance")
			local interiorExit = getElementData(interior, "exit")
		for _, point in ipairs( { interiorExit } ) do
			
			if (point[5] == dimension) then
					local distance = getDistanceBetweenPoints3D(posX, posY, posZ, point[1], point[2], point[3])
			if (distance <= 50) then
			      local dbid = getElementData(interior, "dbid")
	
			       	     local getShopId = exports.sal:_QuerySingle( "SELECT * FROM CAFESHOPS WHERE ShopintDBID = ?", dbid)
if getShopId == nil then 
					 			 outputChatBox("لايوجد شوب هنا", source, 255, 0, 0)

return end
					 			 outputChatBox("ايدي الشوب هو ".. getShopId.shopID .."", source, 0, 255, 0)

	
	end
	end
	end
	end
	end
	
	
end
addCommandHandler("thisShop", thisShop, false, false)

 function getallshops(source,ownerCharID1)
 	if (exports.integration:isPlayerLeadAdmin(source)) then
	
	  local posX, posY, posZ = getElementPosition(source)
		local dimension = getElementDimension(source)
	    local interiorchk = getElementInterior(source)
		
		if dimension == 0 and interiorchk == 0 then 
		outputChatBox("لا يمكنك فعل هاذا في الخارج", source, 255, 255, 0)
		return end		
		
		    local possibleInteriors = exports.pool:getPoolElementsByType('interior')
		for _, interior in ipairs(possibleInteriors) do
			local interiorEntrance = getElementData(interior, "entrance")
			local interiorExit = getElementData(interior, "exit")
		for _, point in ipairs( { interiorExit } ) do
			
			if (point[5] == dimension) then
					local distance = getDistanceBetweenPoints3D(posX, posY, posZ, point[1], point[2], point[3])
			if (distance <= 50) then
			      local dbid = getElementData(interior, "dbid")
	
	

 local getall = exports.sal:_Query( "SELECT shopID,ShopintDBID,ownerCharID,createdBY FROM CAFESHOPS" )
                                                    for i, dataget in pairs (getall) do
												   
 					 			  outputChatBox(" ID: ".. dataget["shopID"] .." / INTERIOR ID: ".. dataget["ShopintDBID"] .." / OwnerCHARID:  ".. dataget["ownerCharID"] .." / Created By USER/ChrID: ".. dataget["createdBY"] .."", source, 0, 255, 0)


                                                       
													  end
	
	                         end
	                    end
	                end
	            end
	        end
	
	
end
addCommandHandler("getallshops", getallshops, false, false)




-----------------------------------------------------------------------------------------


















------------------------------------------------


function soldWaters ( PlayerClnt,PlayerChrid,shopOwner )

                   local getTableSell = exports.sal:_QuerySingle( "SELECT * FROM CAFESHOPS WHERE ownerCharID = ?", shopOwner)
       	           local getSellerMoney = exports.sal:_QuerySingle( "SELECT bankmoney FROM characters WHERE id = ?", shopOwner)
		 
       if getTableSell.Water == 0 then 
                   outputChatBox(" انتهى مخزون المياه الخاص بنا عد لاحقا   ", PlayerClnt, 255, 0, 0, true)
       return end

local newValr = getTableSell.Water - 1
 
exports.global:giveItem( PlayerClnt, 15, 1)

exports.global:takeMoney( PlayerClnt, 7 )

exports.sal:_Exec("UPDATE `CAFESHOPS` SET `Water` = ? WHERE `ownerCharID` = " .. shopOwner.."",newValr)

local newSellerBank = getSellerMoney.bankmoney + 7 

exports.sal:_Exec("UPDATE `characters` SET `bankmoney` = ? WHERE `id` = " .. shopOwner.."",newSellerBank)

local zubi = exports.global:getPlayerFromCharacterID(tonumber(shopOwner))

 if zubi then
 
exports.anticheat:changeProtectedElementDataEx(zubi, "bankmoney", newSellerBank, false)

elseif exports.global:getPlayerFromCharacterID(tonumber(shopOwner)) == false then return end

end
addEvent ("soldWater", true)
addEventHandler ("soldWater", root, soldWaters)



------------------------------------------------------------------------------------


function soldFoods ( PlayerClnt,PlayerChrid,shopOwner )

                   local getTableSell = exports.sal:_QuerySingle( "SELECT * FROM CAFESHOPS WHERE ownerCharID = ?", shopOwner)
       	           local getSellerMoney = exports.sal:_QuerySingle( "SELECT bankmoney FROM characters WHERE id = ?", shopOwner)
		 
       if getTableSell.Food == 0 then 
                   outputChatBox(" انتهى مخزون الاكل الخاص بنا عد لاحقا ", PlayerClnt, 255, 0, 0, true)
       return end

local newValr = getTableSell.Food - 1
 
exports.global:giveItem( PlayerClnt, 1, 1)

exports.global:takeMoney( PlayerClnt, 10 )

exports.sal:_Exec("UPDATE `CAFESHOPS` SET `Food` = ? WHERE `ownerCharID` = " .. shopOwner.."",newValr)

local newSellerBank = getSellerMoney.bankmoney + 15 

exports.sal:_Exec("UPDATE `characters` SET `bankmoney` = ? WHERE `id` = " .. shopOwner.."",newSellerBank)

local zubi = exports.global:getPlayerFromCharacterID(tonumber(shopOwner))

 if zubi then
 
exports.anticheat:changeProtectedElementDataEx(zubi, "bankmoney", newSellerBank, false)

elseif exports.global:getPlayerFromCharacterID(tonumber(shopOwner)) == false then return end

end
addEvent ("soldFood", true)
addEventHandler ("soldFood", root, soldFoods)