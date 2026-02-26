local v1 = loadstring(game:HttpGet('https://raw.githubusercontent.com/SkireScripts/F3X-Panel/main/Panel.lua'))()
local _Players = game:GetService('Players')
local _RunService = game:GetService('RunService')
local u4 = _Players.LocalPlayer.Character or _Players.LocalPlayer.CharacterAdded:Wait()
local u5 = nil
local u6 = {
    ['loop kill'] = false,
    ['loop tools'] = false,
    burn = false,
}
local v7 = v1:Window({
    Name = 'F3X Panel',
    Title = '<font color="#ffb31a">F3X</font> Panel',
    Hidden = false,
    Key = Enum.KeyCode.Insert,
})
local v8 = v7:AddTab({
    Name = 'Builds',
    Icon = '7072706318',
    Selected = true,
})
local v9 = v7:AddTab({
    Name = 'Grief',
    Icon = '7072723685',
    Selected = false,
})
local v10 = v7:AddTab({
    Name = 'Maps',
    Icon = '7072718631',
    Selected = false,
})
local v11 = v7:AddTab({
    Name = 'Players',
    Icon = '7072724538',
    Selected = false,
})
local v12 = v7:AddTab({
    Name = 'Credits',
    Icon = '7072724538',
    Selected = false,
})

local function u22()
    pcall(function()
        if u4 then
            local v13 = u4
            local v14, v15, v16 = pairs(v13:GetDescendants())

            while true do
                local v17

                v16, v17 = v14(v15, v16)

                if v16 == nil then
                    break
                end
                if v17.Name == 'SyncAPI' then
                    u5 = v17:FindFirstChildWhichIsA('RemoteFunction')
                end
            end

            if not u5 then
                local v18, v19, v20 = pairs(_Players.LocalPlayer.Backpack:GetDescendants())

                while true do
                    local v21

                    v20, v21 = v18(v19, v20)

                    if v20 == nil then
                        break
                    end
                    if v21.Name == 'SyncAPI' then
                        u5 = v21:FindFirstChildWhichIsA('RemoteFunction')
                    end
                end
            end
        end
    end)
end

_RunService.Stepped:Connect(function()
    u22()
end)
_Players.LocalPlayer.CharacterAdded:Connect(function(_)
    u5 = nil
end)

local function u29(p23)
    local v24 = _Players
    local v25, v26, v27 = pairs(v24:GetPlayers())

    while true do
        local v28

        v27, v28 = v25(v26, v27)

        if v27 == nil then
            break
        end
        if v28.Name:lower():match(p23:lower()) then
            return v28
        end
        if v28.DisplayName:lower():match(p23:lower()) then
            return v28
        end
    end

    return nil
end
local function u43(p30)
    if p30 and u5 then
        if typeof(p30) == 'string' then
            if p30 == 'others' then
                local v31 = _Players
                local v32, v33, v34 = pairs(v31:GetPlayers())
                local u35 = {}

                while true do
                    local v36

                    v34, v36 = v32(v33, v34)

                    if v34 == nil then
                        break
                    end
                    if v36 ~= _Players.LocalPlayer then
                        u35[#u35 + 1] = v36.Character.Head
                    end
                end

                pcall(function()
                    u5:InvokeServer('Remove', u35)
                end)
            elseif p30 == 'all' then
                local v37 = _Players
                local v38, v39, v40 = pairs(v37:GetPlayers())
                local u41 = {}

                while true do
                    local v42

                    v40, v42 = v38(v39, v40)

                    if v40 == nil then
                        break
                    end

                    u41[#u41 + 1] = v42.Character.Head
                end

                pcall(function()
                    u5:InvokeServer('Remove', u41)
                end)
            end
        else
            pcall(function()
                u5:InvokeServer('Remove', {
                    p30.Character.Head,
                })
            end)
        end
    end
end
local function u82(p44)
    if p44 and u5 then
        if typeof(p44) == 'string' then
            if p44 == 'others' then
                local v45 = _Players
                local v46, v47, v48 = pairs(v45:GetPlayers())
                local u49 = {}

                while true do
                    local v50

                    v48, v50 = v46(v47, v48)

                    if v48 == nil then
                        break
                    end
                    if v50 ~= _Players.LocalPlayer then
                        local v51, v52, v53 = pairs(v50.Character:GetChildren())

                        while true do
                            local v54

                            v53, v54 = v51(v52, v53)

                            if v53 == nil then
                                break
                            end
                            if v54:IsA('Tool') then
                                u49[#u49 + 1] = v54
                            end
                        end

                        local v55, v56, v57 = pairs(v50.Backpack:GetChildren())

                        while true do
                            local v58

                            v57, v58 = v55(v56, v57)

                            if v57 == nil then
                                break
                            end
                            if v58:IsA('Tool') then
                                u49[#u49 + 1] = v58
                            end
                        end
                    end
                end

                pcall(function()
                    u5:InvokeServer('Remove', u49)
                end)
            elseif p44 == 'all' then
                local v59 = _Players
                local v60, v61, v62 = pairs(v59:GetPlayers())
                local u63 = {}

                while true do
                    local v64

                    v62, v64 = v60(v61, v62)

                    if v62 == nil then
                        break
                    end

                    local v65, v66, v67 = pairs(v64.Character:GetChildren())

                    while true do
                        local v68

                        v67, v68 = v65(v66, v67)

                        if v67 == nil then
                            break
                        end
                        if v68:IsA('Tool') then
                            u63[#u63 + 1] = v68
                        end
                    end

                    local v69, v70, v71 = pairs(v64.Backpack:GetChildren())

                    while true do
                        local v72

                        v71, v72 = v69(v70, v71)

                        if v71 == nil then
                            break
                        end
                        if v72:IsA('Tool') then
                            u63[#u63 + 1] = v72
                        end
                    end
                end

                pcall(function()
                    u5:InvokeServer('Remove', u63)
                end)
            end
        else
            local v73, v74, v75 = pairs(p44.Character:GetChildren())
            local u76 = {}

            while true do
                local v77

                v75, v77 = v73(v74, v75)

                if v75 == nil then
                    break
                end
                if v77:IsA('Tool') then
                    u76[#u76 + 1] = v77
                end
            end

            local v78, v79, v80 = pairs(p44.Backpack:GetChildren())

            while true do
                local v81

                v80, v81 = v78(v79, v80)

                if v80 == nil then
                    break
                end
                if v81:IsA('Tool') then
                    u76[#u76 + 1] = v81
                end
            end

            pcall(function()
                u5:InvokeServer('Remove', u76)
            end)
        end
    end
end
local function u84(p83)
    loadstring(game:HttpGet('https://raw.githubusercontent.com/SkireScripts/F3X-Panel/main/buildloader.lua'))():LoadBuild(p83, u5)
end

local _Basic = v8:Section('Basic')
local u86 = ''

_Basic:Input({
    Name = 'Skybox id',
    ClearOnFocus = false,
    PlaceHolder = 'rbxassetid',
    Text = '',
    Callback = function(p87)
        u86 = p87
    end,
})
_Basic:Button({
    Name = 'SkyBox',
    Callback = function()
        u84(loadstring(game:HttpGet('https://raw.githubusercontent.com/SkireScripts/F3X-Panel/main/maps/skybox'))():load(u86))
    end,
})

local _Grief = v9:Section('Grief')
local u89 = 6
local u90 = ''

_Grief:Label('Fire')
_Grief:Input({
    Name = 'Size',
    ClearOnFocus = false,
    Text = '6',
    PlaceHolder = 'Fire Size',
    Callback = function(p91)
        u89 = tonumber(p91)
    end,
})
_Grief:Toggle({
    Name = 'Burn all',
    Enabled = false,
    Callback = function(p92)
        u6.burn = p92

        while u6.burn do
            wait()

            local v93, v94, v95 = pairs(game.Workspace:GetDescendants())
            local v96 = {}

            while true do
                local v97

                v95, v97 = v93(v94, v95)

                if v95 == nil then
                    break
                end
                if v97:IsA('Part') or (v97:IsA('SpawnLocation') or (v97:IsA('WedgePart') or (v97:IsA('CornerWedgePart') or (v97:IsA('TrussPart') or (v97:IsA('Seat') or (v97:IsA('MeshPart') or v97:IsA('VehicleSeat'))))))) then
                    local v98 = {
                        DecorationType = 'Fire',
                        Part = v97,
                        Size = u89,
                    }

                    v96[#v96 + 1] = v98
                end
            end

            u5:InvokeServer('CreateDecorations', v96)
        end
    end,
})
_Grief:Button({
    Name = 'Remove Fire',
    Callback = function()
        local v99, v100, v101 = pairs(game.Workspace:GetDescendants())
        local v102 = {}

        while true do
            local v103

            v101, v103 = v99(v100, v101)

            if v101 == nil then
                break
            end
            if v103:IsA('Fire') then
                v102[#v102 + 1] = v103
            end
        end

        u5:InvokeServer('Remove', v102)
    end,
})
_Grief:Label('Troll')
_Grief:Button({
    Name = 'Unanchor all',
    Callback = function()
        local v104, v105, v106 = pairs(game.Workspace:GetDescendants())
        local v107 = {}

        while true do
            local v108

            v106, v108 = v104(v105, v106)

            if v106 == nil then
                break
            end
            if not _Players:GetPlayerFromCharacter(v108:FindFirstAncestorWhichIsA('Model')) and (v108:IsA('Part') or (v108:IsA('SpawnLocation') or (v108:IsA('WedgePart') or (v108:IsA('CornerWedgePart') or (v108:IsA('TrussPart') or (v108:IsA('Seat') or (v108:IsA('MeshPart') or v108:IsA('VehicleSeat')))))))) then
                v107[#v107 + 1] = {
                    Anchored = false,
                    Part = v108,
                }
            end
        end

        u5:InvokeServer('SyncAnchor', v107)
    end,
})
_Grief:Input({
    Name = 'Decal ID',
    ClearOnFocus = false,
    Text = '',
    PlaceHolder = 'Decal',
    Callback = function(p109)
        u90 = 'rbxassetid://' .. p109
    end,
})
_Grief:Button({
    Name = 'decal all (top)',
    Callback = function()
        local v110, v111, v112 = pairs(game.Workspace:GetDescendants())
        local v113 = {}

        while true do
            local v114

            v112, v114 = v110(v111, v112)

            if v112 == nil then
                break
            end
            if v114:IsA('Part') or (v114:IsA('SpawnLocation') or (v114:IsA('WedgePart') or (v114:IsA('CornerWedgePart') or (v114:IsA('TrussPart') or (v114:IsA('Seat') or (v114:IsA('MeshPart') or v114:IsA('VehicleSeat'))))))) then
                v113[#v113 + 1] = {
                    Part = v114,
                    Face = Enum.NormalId.Top,
                    TextureType = 'Decal',
                    Texture = u90,
                }
            end
        end

        u5:InvokeServer('CreateTextures', v113)
        u5:InvokeServer('SyncTexture', v113)
    end,
})

local _Maps = v10:Section('Maps')
local _CustomMap = v10:Section('Custom Map')
local _SavedMaps = v10:Section('Saved Maps')

local function u119(p118)
    _SavedMaps:Button({
        Name = p118,
        Callback = function()
            u84(loadstring(readfile('f3x maps/' .. p118))())
        end,
    })
end

if not isfolder('f3x maps') then
    makefolder('f3x maps')
end

local v120, v121, v122 = pairs(listfiles('f3x maps'))
local u123 = u6
local u124 = u84

while true do
    local v125

    v122, v125 = v120(v121, v122)

    if v122 == nil then
        break
    end

    local v126 = string.split(v125, '/')

    u119(v126[#v126])
end

_Maps:Button({
    Name = 'Tree House',
    Callback = function()
        u124(loadstring(game:HttpGet('https://raw.githubusercontent.com/SkireScripts/F3X-Panel/main/maps/tree-house.lua'))())
    end,
})
_Maps:Button({
    Name = 'Crossroads',
    Callback = function()
        u124(loadstring(game:HttpGet('https://raw.githubusercontent.com/SkireScripts/F3X-Panel/main/maps/crossroads.lua'))())
    end,
})
_Maps:Button({
    Name = 'Doomspire',
    Callback = function()
        u124(loadstring(game:HttpGet('https://raw.githubusercontent.com/SkireScripts/F3X-Panel/main/maps/doomspire.lua'))())
    end,
})

local u127 = nil
local u128 = nil

_CustomMap:Input({
    Name = 'Custom Map',
    ClearOnFocus = false,
    PlaceHolder = 'Map Source/Url',
    Text = '',
    Callback = function(p129)
        u127 = p129
    end,
})
_CustomMap:Button({
    Name = 'Load Map',
    Callback = function()
        u124(loadstring(game:HttpGet(u127))())
    end,
})
_CustomMap:Input({
    Name = 'Map Name',
    ClearOnFocus = false,
    PlaceHolder = 'Map Name',
    Text = '',
    Callback = function(p130)
        u128 = p130
    end,
})
_CustomMap:Button({
    Name = 'Save Map',
    Callback = function()
        if not isfolder('f3x maps') then
            makefolder('f3x maps')
        end

        writefile('f3x maps/' .. u128 .. '.lua', game:HttpGet(u127))
        u119(u128 .. '.lua')
    end,
})

local _PlayerControls = v11:Section('Player Controls')
local u132 = ''

_PlayerControls:Label('Target')
_PlayerControls:Input({
    Name = 'Target',
    ClearOnFocus = false,
    PlaceHolder = 'User',
    Text = '',
    Callback = function(p133)
        u132 = u29(p133:lower())

        if u132 == nil then
            u132 = p133:lower()
        end
    end,
})
_PlayerControls:Label('Kill')
_PlayerControls:Button({
    Name = 'Kill',
    Callback = function()
        u43(u132)
    end,
})
_PlayerControls:Toggle({
    Name = 'Loop kill',
    Enabled = false,
    Callback = function(p134)
        u123['loop kill'] = p134

        while true do
            repeat
                wait()
            until u123['loop kill']

            u43(u132)
        end
    end,
})
_PlayerControls:Label('Tools')
_PlayerControls:Button({
    Name = 'Remove tools',
    Callback = function()
        u82(u132)
    end,
})
_PlayerControls:Toggle({
    Name = 'Loop remove tools',
    Enabled = false,
    Callback = function(p135)
        u123['loop tools'] = p135

        while true do
            repeat
                wait()
            until u123['loop tools']

            u82(u132)
        end
    end,
})

local _Credits = v12:Section('Credits')

_Credits:Label('Skire - Main dev')
_Credits:Label('logs - idea guy')
