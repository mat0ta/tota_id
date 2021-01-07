local disPlayerNames = 5
local playerDistances = {}
local id = false

local function DrawText3D(x,y,z, text, r,g,b) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = #(vector3(px,py,pz)-vector3(x,y,z))
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        if not useCustomScale then
            SetTextScale(0.0*scale, 0.55*scale)
        else 
            SetTextScale(0.0*scale, customScale)
        end
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(function()
	Wait(500)
    while true do
        for _, id in ipairs(GetActivePlayers()) do
				if GetPlayerPed(id) ~= GetPlayerPed(-1) then
                    if playerDistances[id] then
                        if IsControlPressed(0, 19) then
						    if (playerDistances[id] < disPlayerNames) then
						 	    x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
							    if NetworkIsPlayerTalking(id) then
                                   DrawText3D(x2, y2, z2+1.2, GetPlayerServerId(id), 119,238,225)
                                   DrawMarker(2, x2, y2, z2+0.9, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.08, 0.2, 0.08, 0, 255, 0, 155, false, false, false, true, false, false, false)
							    else
							 	   DrawText3D(x2, y2, z2+1, GetPlayerServerId(id), 186,186,186)
							    end
						    elseif (playerDistances[id] < 25) then
							    x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))						
							    if NetworkIsPlayerTalking(id) then
                                    DrawMarker(2, x2, y2, z2+0.9, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.08, 0.2, 0.08, 0, 255, 0, 155, false, false, false, true, false, false, false)
							    end
                            end
                        end
					end
				end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        for _, id in ipairs(GetActivePlayers()) do
            if GetPlayerPed(id) ~= GetPlayerPed(-1) then
                x1, y1, z1 = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
                x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
                distance = math.floor(#(vector3(x1,  y1,  z1)-vector3(x2,  y2,  z2)))
				playerDistances[id] = distance
            end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
	Wait(500)
    while true do
        for _, id in ipairs(GetActivePlayers()) do
				if GetPlayerPed(id) ~= GetPlayerPed(-1) and not IsControlPressed(0, 19) then
                    if playerDistances[id] then
						    if (playerDistances[id] < disPlayerNames) then
						 	    x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
							    if NetworkIsPlayerTalking(id) then
                                DrawMarker(2, x2, y2, z2+0.9, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.08, 0.2, 0.08, 0, 255, 0, 155, false, false, false, true, false, false, false)
							    end
						    elseif (playerDistances[id] < 25) then
							    x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))						
							    if NetworkIsPlayerTalking(id) then
                                    DrawMarker(2, x2, y2, z2+0.9, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.08, 0.2, 0.08, 0, 255, 0, 155, false, false, false, true, false, false, false)
							    end
                            end
					end
				end
        end
        Citizen.Wait(0)
    end
end)