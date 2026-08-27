-- deobfuscated and renamed using malbot

local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/SkireScripts/F3X-Panel/main/Panel.lua'))()
local Players = game:GetService('Players')
local RunService = game:GetService('RunService')
local LocalCharacter = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()
local ServerEndpoint = nil
local StateFlags = {
    ['loop kill'] = false,
    ['loop tools'] = false,
    burn = false,
}
local PanelWindow = Library:Window({
    Name = 'F3X Panel',
    Title = '<font color="#ffb31a">F3X</font> Panel',
    Hidden = false,
    Key = Enum.KeyCode.Insert,
})
local BuildsTab = PanelWindow:AddTab({
    Name = 'Builds',
    Icon = '7072706318',
    Selected = true,
})
local GriefTab = PanelWindow:AddTab({
    Name = 'Grief',
    Icon = '7072723685',
    Selected = false,
})
local MapsTab = PanelWindow:AddTab({
    Name = 'Maps',
    Icon = '7072718631',
    Selected = false,
})
local PlayersTab = PanelWindow:AddTab({
    Name = 'Players',
    Icon = '7072724538',
    Selected = false,
})
local CreditsTab = PanelWindow:AddTab({
    Name = 'Credits',
    Icon = '7072724538',
    Selected = false,
})

local function FindServerEndpoint()
    pcall(function()
        if LocalCharacter then
            local characterInstance = LocalCharacter
            local iterFunc, iterTable, iterIndex = pairs(characterInstance:GetDescendants())

            while true do
                local descendant

                iterIndex, descendant = iterFunc(iterTable, iterIndex)

                if iterIndex == nil then
                    break
                end
                if descendant.Name == 'SyncAPI' then
                    ServerEndpoint = descendant:FindFirstChildWhichIsA('RemoteFunction')
                end
            end

            if not ServerEndpoint then
                local backpackIterFunc, backpackIterTable, backpackIterIndex = pairs(Players.LocalPlayer.Backpack:GetDescendants())

                while true do
                    local backpackDescendant

                    backpackIterIndex, backpackDescendant = backpackIterFunc(backpackIterTable, backpackIterIndex)

                    if backpackIterIndex == nil then
                        break
                    end
                    if backpackDescendant.Name == 'SyncAPI' then
                        ServerEndpoint = backpackDescendant:FindFirstChildWhichIsA('RemoteFunction')
                    end
                end
            end
        end
    end)
end

RunService.Stepped:Connect(function()
    FindServerEndpoint()
end)
Players.LocalPlayer.CharacterAdded:Connect(function(_)
    ServerEndpoint = nil
end)

local function FindPlayerByName(searchQuery)
    local playerList = Players
    local iterFunc, iterTable, iterIndex = pairs(playerList:GetPlayers())

    while true do
        local player

        iterIndex, player = iterFunc(iterTable, iterIndex)

        if iterIndex == nil then
            break
        end
        if player.Name:lower():match(searchQuery:lower()) then
            return player
        end
        if player.DisplayName:lower():match(searchQuery:lower()) then
            return player
        end
    end

    return nil
end

local function RemoveTarget(target)
    if target and ServerEndpoint then
        if typeof(target) == 'string' then
            if target == 'others' then
                local playerList = Players
                local iterFunc, iterTable, iterIndex = pairs(playerList:GetPlayers())
                local targetHeads = {}

                while true do
                    local player

                    iterIndex, player = iterFunc(iterTable, iterIndex)

                    if iterIndex == nil then
                        break
                    end
                    if player ~= Players.LocalPlayer then
                        targetHeads[#targetHeads + 1] = player.Character.Head
                    end
                end

                pcall(function()
                    ServerEndpoint:InvokeServer('Remove', targetHeads)
                end)
            elseif target == 'all' then
                local playerList = Players
                local iterFunc, iterTable, iterIndex = pairs(playerList:GetPlayers())
                local targetHeads = {}

                while true do
                    local player

                    iterIndex, player = iterFunc(iterTable, iterIndex)

                    if iterIndex == nil then
                        break
                    end

                    targetHeads[#targetHeads + 1] = player.Character.Head
                end

                pcall(function()
                    ServerEndpoint:InvokeServer('Remove', targetHeads)
                end)
            end
        else
            pcall(function()
                ServerEndpoint:InvokeServer('Remove', {
                    target.Character.Head,
                })
            end)
        end
    end
end

local function RemovePlayerTools(target)
    if target and ServerEndpoint then
        if typeof(target) == 'string' then
            if target == 'others' then
                local playerList = Players
                local iterFunc, iterTable, iterIndex = pairs(playerList:GetPlayers())
                local toolsList = {}

                while true do
                    local player

                    iterIndex, player = iterFunc(iterTable, iterIndex)

                    if iterIndex == nil then
                        break
                    end
                    if player ~= Players.LocalPlayer then
                        local charIterFunc, charIterTable, charIterIndex = pairs(player.Character:GetChildren())

                        while true do
                            local child

                            charIterIndex, child = charIterFunc(charIterTable, charIterIndex)

                            if charIterIndex == nil then
                                break
                            end
                            if child:IsA('Tool') then
                                toolsList[#toolsList + 1] = child
                            end
                        end

                        local bpIterFunc, bpIterTable, bpIterIndex = pairs(player.Backpack:GetChildren())

                        while true do
                            local tool

                            bpIterIndex, tool = bpIterFunc(bpIterTable, bpIterIndex)

                            if bpIterIndex == nil then
                                break
                            end
                            if tool:IsA('Tool') then
                                toolsList[#toolsList + 1] = tool
                            end
                        end
                    end
                end

                pcall(function()
                    ServerEndpoint:InvokeServer('Remove', toolsList)
                end)
            elseif target == 'all' then
                local playerList = Players
                local iterFunc, iterTable, iterIndex = pairs(playerList:GetPlayers())
                local toolsList = {}

                while true do
                    local player

                    iterIndex, player = iterFunc(iterTable, iterIndex)

                    if iterIndex == nil then
                        break
                    end

                    local charIterFunc, charIterTable, charIterIndex = pairs(player.Character:GetChildren())

                    while true do
                        local child

                        charIterIndex, child = charIterFunc(charIterTable, charIterIndex)

                        if charIterIndex == nil then
                            break
                        end
                        if child:IsA('Tool') then
                            toolsList[#toolsList + 1] = child
                        end
                    end

                    local bpIterFunc, bpIterTable, bpIterIndex = pairs(player.Backpack:GetChildren())

                    while true do
                        local tool

                        bpIterIndex, tool = bpIterFunc(bpIterTable, bpIterIndex)

                        if bpIterIndex == nil then
                            break
                        end
                        if tool:IsA('Tool') then
                            toolsList[#toolsList + 1] = tool
                        end
                    end
                end

                pcall(function()
                    ServerEndpoint:InvokeServer('Remove', toolsList)
                end)
            end
        else
            local charIterFunc, charIterTable, charIterIndex = pairs(target.Character:GetChildren())
            local toolsList = {}

            while true do
                local child

                charIterIndex, child = charIterFunc(charIterTable, charIterIndex)

                if charIterIndex == nil then
                    break
                end
                if child:IsA('Tool') then
                    toolsList[#toolsList + 1] = child
                end
            end

            local bpIterFunc, bpIterTable, bpIterIndex = pairs(target.Backpack:GetChildren())

            while true do
                local tool

                bpIterIndex, tool = bpIterFunc(bpIterTable, bpIterIndex)

                if bpIterIndex == nil then
                    break
                end
                if tool:IsA('Tool') then
                    toolsList[#toolsList + 1] = tool
                end
            end

            pcall(function()
                ServerEndpoint:InvokeServer('Remove', toolsList)
            end)
        end
    end
end

local function LoadBuildFromUrl(buildUrl)
    loadstring(game:HttpGet('https://raw.githubusercontent.com/SkireScripts/F3X-Panel/main/buildloader.lua'))():LoadBuild(buildUrl, ServerEndpoint)
end

local BasicSection = BuildsTab:Section('Basic')
local SkyboxIdInput = ''

BasicSection:Input({
    Name = 'Skybox id',
    ClearOnFocus = false,
    PlaceHolder = 'rbxassetid',
    Text = '',
    Callback = function(value)
        SkyboxIdInput = value
    end,
})
BasicSection:Button({
    Name = 'SkyBox',
    Callback = function()
        LoadBuildFromUrl(loadstring(game:HttpGet('https://raw.githubusercontent.com/SkireScripts/F3X-Panel/main/maps/skybox'))():load(SkyboxIdInput))
    end,
})

local GriefSection = GriefTab:Section('Grief')
local FireSizeValue = 6
local DecalIdInput = ''

GriefSection:Label('Fire')
GriefSection:Input({
    Name = 'Size',
    ClearOnFocus = false,
    Text = '6',
    PlaceHolder = 'Fire Size',
    Callback = function(value)
        FireSizeValue = tonumber(value)
    end,
})
GriefSection:Toggle({
    Name = 'Burn all',
    Enabled = false,
    Callback = function(state)
        StateFlags.burn = state

        while StateFlags.burn do
            wait()

            local iterFunc, iterTable, iterIndex = pairs(game.Workspace:GetDescendants())
            local partsList = {}

            while true do
                local part

                iterIndex, part = iterFunc(iterTable, iterIndex)

                if iterIndex == nil then
                    break
                end
                if part:IsA('Part') or (part:IsA('SpawnLocation') or (part:IsA('WedgePart') or (part:IsA('CornerWedgePart') or (part:IsA('TrussPart') or (part:IsA('Seat') or (part:IsA('MeshPart') or part:IsA('VehicleSeat'))))))) then
                    local fireData = {
                        DecorationType = 'Fire',
                        Part = part,
                        Size = FireSizeValue,
                    }

                    partsList[#partsList + 1] = fireData
                end
            end

            ServerEndpoint:InvokeServer('CreateDecorations', partsList)
        end
    end,
})
GriefSection:Button({
    Name = 'Remove Fire',
    Callback = function()
        local iterFunc, iterTable, iterIndex = pairs(game.Workspace:GetDescendants())
        local firesList = {}

        while true do
            local fireInstance

            iterIndex, fireInstance = iterFunc(iterTable, iterIndex)

            if iterIndex == nil then
                break
            end
            if fireInstance:IsA('Fire') then
                firesList[#firesList + 1] = fireInstance
            end
        end

        ServerEndpoint:InvokeServer('Remove', firesList)
    end,
})
GriefSection:Label('Troll')
GriefSection:Button({
    Name = 'Unanchor all',
    Callback = function()
        local iterFunc, iterTable, iterIndex = pairs(game.Workspace:GetDescendants())
        local unanchorList = {}

        while true do
            local part

            iterIndex, part = iterFunc(iterTable, iterIndex)

            if iterIndex == nil then
                break
            end
            if not Players:GetPlayerFromCharacter(part:FindFirstAncestorWhichIsA('Model')) and (part:IsA('Part') or (part:IsA('SpawnLocation') or (part:IsA('WedgePart') or (part:IsA('CornerWedgePart') or (part:IsA('TrussPart') or (part:IsA('Seat') or (part:IsA('MeshPart') or part:IsA('VehicleSeat')))))))) then
                unanchorList[#unanchorList + 1] = {
                    Anchored = false,
                    Part = part,
                }
            end
        end

        ServerEndpoint:InvokeServer('SyncAnchor', unanchorList)
    end,
})
GriefSection:Input({
    Name = 'Decal ID',
    ClearOnFocus = false,
    Text = '',
    PlaceHolder = 'Decal',
    Callback = function(value)
        DecalIdInput = 'rbxassetid://' .. value
    end,
})
GriefSection:Button({
    Name = 'decal all (top)',
    Callback = function()
        local iterFunc, iterTable, iterIndex = pairs(game.Workspace:GetDescendants())
        local decalsList = {}

        while true do
            local part

            iterIndex, part = iterFunc(iterTable, iterIndex)

            if iterIndex == nil then
                break
            end
            if part:IsA('Part') or (part:IsA('SpawnLocation') or (part:IsA('WedgePart') or (part:IsA('CornerWedgePart') or (part:IsA('TrussPart') or (part:IsA('Seat') or (part:IsA('MeshPart') or part:IsA('VehicleSeat'))))))) then
                decalsList[#decalsList + 1] = {
                    Part = part,
                    Face = Enum.NormalId.Top,
                    TextureType = 'Decal',
                    Texture = DecalIdInput,
                }
            end
        end

        ServerEndpoint:InvokeServer('CreateTextures', decalsList)
        ServerEndpoint:InvokeServer('SyncTexture', decalsList)
    end,
})

local MapsSection = MapsTab:Section('Maps')
local CustomMapSection = MapsTab:Section('Custom Map')
local SavedMapsSection = MapsTab:Section('Saved Maps')

local function CreateSavedMapButton(mapFileName)
    SavedMapsSection:Button({
        Name = mapFileName,
        Callback = function()
            LoadBuildFromUrl(loadstring(readfile('f3x maps/' .. mapFileName))())
        end,
    })
end

if not isfolder('f3x maps') then
    makefolder('f3x maps')
end

local iterFunc, iterTable, iterIndex = pairs(listfiles('f3x maps'))
local localStateFlags = StateFlags
local localLoadBuildFunc = LoadBuildFromUrl

while true do
    local fileEntry

    iterIndex, fileEntry = iterFunc(iterTable, iterIndex)

    if iterIndex == nil then
        break
    end

    local pathSegments = string.split(fileEntry, '/')

    CreateSavedMapButton(pathSegments[#pathSegments])
end

MapsSection:Button({
    Name = 'Tree House',
    Callback = function()
        localLoadBuildFunc(loadstring(game:HttpGet('https://raw.githubusercontent.com/SkireScripts/F3X-Panel/main/maps/tree-house.lua'))())
    end,
})
MapsSection:Button({
    Name = 'Crossroads',
    Callback = function()
        localLoadBuildFunc(loadstring(game:HttpGet('https://raw.githubusercontent.com/SkireScripts/F3X-Panel/main/maps/crossroads.lua'))())
    end,
})
MapsSection:Button({
    Name = 'Doomspire',
    Callback = function()
        localLoadBuildFunc(loadstring(game:HttpGet('https://raw.githubusercontent.com/SkireScripts/F3X-Panel/main/maps/doomspire.lua'))())
    end,
})

local CustomMapUrlInput = nil
local CustomMapNameInput = nil

CustomMapSection:Input({
    Name = 'Custom Map',
    ClearOnFocus = false,
    PlaceHolder = 'Map Source/Url',
    Text = '',
    Callback = function(value)
        CustomMapUrlInput = value
    end,
})
CustomMapSection:Button({
    Name = 'Load Map',
    Callback = function()
        localLoadBuildFunc(loadstring(game:HttpGet(CustomMapUrlInput))())
    end,
})
CustomMapSection:Input({
    Name = 'Map Name',
    ClearOnFocus = false,
    PlaceHolder = 'Map Name',
    Text = '',
    Callback = function(value)
        CustomMapNameInput = value
    end,
})
CustomMapSection:Button({
    Name = 'Save Map',
    Callback = function()
        if not isfolder('f3x maps') then
            makefolder('f3x maps')
        end

        writefile('f3x maps/' .. CustomMapNameInput .. '.lua', game:HttpGet(CustomMapUrlInput))
        CreateSavedMapButton(CustomMapNameInput .. '.lua')
    end,
})

local PlayerControlsSection = PlayersTab:Section('Player Controls')
local SelectedTarget = ''

PlayerControlsSection:Label('Target')
PlayerControlsSection:Input({
    Name = 'Target',
    ClearOnFocus = false,
    PlaceHolder = 'User',
    Text = '',
    Callback = function(value)
        SelectedTarget = FindPlayerByName(value:lower())

        if SelectedTarget == nil then
            SelectedTarget = value:lower()
        end
    end,
})
PlayerControlsSection:Label('Kill')
PlayerControlsSection:Button({
    Name = 'Kill',
    Callback = function()
        RemoveTarget(SelectedTarget)
    end,
})
PlayerControlsSection:Toggle({
    Name = 'Loop kill',
    Enabled = false,
    Callback = function(state)
        localStateFlags['loop kill'] = state

        while true do
            repeat
                wait()
            until localStateFlags['loop kill']

            RemoveTarget(SelectedTarget)
        end
    end,
})
PlayerControlsSection:Label('Tools')
PlayerControlsSection:Button({
    Name = 'Remove tools',
    Callback = function()
        RemovePlayerTools(SelectedTarget)
    end,
})
PlayerControlsSection:Toggle({
    Name = 'Loop remove tools',
    Enabled = false,
    Callback = function(state)
        localStateFlags['loop tools'] = state

        while true do
            repeat
                wait()
            until localStateFlags['loop tools']

            RemovePlayerTools(SelectedTarget)
        end
    end,
})

local CreditsSection = CreditsTab:Section('Credits')

CreditsSection:Label('Skire - Main dev')
CreditsSection:Label('logs - idea guy')
