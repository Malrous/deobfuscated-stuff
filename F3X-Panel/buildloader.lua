local _Players = game:GetService('Players')

game:GetService('RunService')

if not _Players.LocalPlayer.Character then
    _Players.LocalPlayer.CharacterAdded:Wait()
end

local u2 = loadstring(game:HttpGet('https://raw.githubusercontent.com/SkireScripts/F3X-Panel/main/Terminal.lua'))()

return {
    LoadBuild = function(_, p3, p4)
        local _BuildLoaderv13 = u2:Window('Build Loader v1.3')
        local _BindableEvent = Instance.new('BindableEvent', game)
        local u7 = {}

        _BindableEvent.Event:Connect(function(p8)
            local v9 = p3[p8]
            local _shape = v9.shape

            p4:InvokeServer('CreatePart', v9.shape == 'Block' and 'Normal' or _shape, CFrame.new(unpack(v9.cframe)), game.Workspace)
        end)

        local v14 = game.Workspace.ChildAdded:Connect(function(p11)
            u7[#u7 + 1] = {}

            local _shape2 = p11.shape
            local v13 = p11.shape == 'Block' and 'Normal' or _shape2

            u7[#u7] = {
                type = v13,
                part = p11,
            }
        end)

        game.Workspace.ChildRemoved:Connect(function(p15)
            if u7[p15] then
                _BindableEvent:Fire(u7[p15])
                table.remove(u7, u7[p15])
            end
        end)

        local u16 = 0

        _BuildLoaderv13:Log({
            Color = Color3.fromRGB(255, 255, 255),
            Content = 'Mapping build...',
        })

        local u17 = _BuildLoaderv13:Log({
            Color = Color3.fromRGB(255, 255, 255),
            Content = 'Progress: ' .. u16 .. '%\n[\u{2581}\u{2581}\u{2581}\u{2581}\u{2581}\u{2581}\u{2581}\u{2581}\u{2581}\u{2581}\u{2581}\u{2581}\u{2581}\u{2581}\u{2581}\u{2581}\u{2581}\u{2581}\u{2581}\u{2581}]',
        })
        local v18, v19, v20 = pairs(p3)
        local u21 = u7
        local u22 = 0
        local u23 = 0

        while true do
            local v24

            v20, v24 = v18(v19, v20)

            if v20 == nil then
                break
            end

            u22 = u22 + 1
        end

        local function u33(p25, p26, p27)
            local v28 = p25 / p26
            local v29 = math.floor(p27 * v28)
            local v30 = p27 - v29
            local v31 = string.rep('\u{fffd}\u{fffd}', v29)
            local v32 = string.rep('\u{fffd}\u{fffd}', v30)

            return string.format('[%s%s]', v31, v32)
        end

        local v34 = tick()
        local u35 = {}
        local v56, v57 = pcall(function()
            (function()
                local v36, v37, v38 = pairs(p3)
                local v39, v40 = v36(v37, v38)

                if v39 ~= nil then
                    local _shape3 = v40.shape
                    local v42 = v40.shape == 'Block' and 'Normal' or _shape3

                    if not _BuildLoaderv13[v42] then
                        p4:InvokeServer('CreatePart', v42, CFrame.new(0, -800, 0), game.Workspace)

                        u35[#_BuildLoaderv13 + 1] = v42
                    end
                end
            end)()
            task.wait()

            local v43, v44, v45 = pairs(p3)
            local v46 = {}

            while true do
                local v47

                v45, v47 = v43(v44, v45)

                if v45 == nil then
                    break
                end

                local v48 = u21[#u21]
                local _shape4 = v48.part.shape
                local v50 = v48.part.shape == 'Block' and 'Normal' or _shape4
                local v51, v52, v53 = pairs(u21)

                while true do
                    local v54

                    v53, v54 = v51(v52, v53)

                    if v53 == nil then
                        break
                    end
                    if v54.type == v50 then
                        v46[#v46 + 1] = v54.part
                    end
                end

                u23 = u23 + 1
                u16 = u23

                local v55 = math.floor(u16 / u22 * 100)

                u17:Edit({
                    Color = u17:GetColor(),
                    Content = 'Progress: ' .. v55 .. '%\n' .. u33(u16, u22, 20),
                })
            end

            p4:InvokeServer('Clone', v46, game.Workspace)
            task.wait(2)
        end)
        local v58, v59, v60 = pairs(u21)
        local v61 = {}

        while true do
            local v62

            v60, v62 = v58(v59, v60)

            if v60 == nil then
                break
            end

            v61[v60] = v62.part
        end

        u7 = v61

        v14:Disconnect()

        if v56 then
            _BuildLoaderv13:Log({
                Color = Color3.fromRGB(255, 255, 255),
                Content = 'Done Mapping!',
            })
            _BuildLoaderv13:Log({
                Color = Color3.fromRGB(255, 255, 255),
                Content = 'Setting Properties...',
            })

            local v63, v64, v65 = pairs(p3)
            local v66 = u7
            local u67 = {
                Colors = {},
                Resize = {},
                Surface = {},
                Material = {},
                Rotate = {},
                Anchor = {},
                Locked = {},
                Collision = {},
                Decal = {},
                SyncDecal = {},
                Mesh = {},
                SyncMesh = {},
            }

            while true do
                local v68

                v65, v68 = v63(v64, v65)

                if v65 == nil then
                    break
                end

                local v69 = v66[v65]

                u67.Colors[#u67.Colors + 1] = {
                    Color = Color3.fromRGB(unpack(v68.color)),
                    Part = v69,
                    UnionColoring = true,
                }
                u67.Resize[#u67.Resize + 1] = {
                    CFrame = CFrame.new(unpack(v68.cframe)),
                    Part = v69,
                    Size = Vector3.new(unpack(v68.size)),
                }

                if v68.surface then
                    u67.Surface[#u67.Surface + 1] = {
                        Part = v69,
                        Surfaces = v68.surface,
                    }
                end

                u67.Material[#u67.Material + 1] = {
                    Part = v69,
                    Material = v68.texture,
                    Transparency = v68.transparency,
                    Reflectance = v68.reflectance,
                }
                u67.Rotate[#u67.Rotate + 1] = {
                    CFrame = CFrame.new(unpack(v68.cframe)),
                    Part = v69,
                }
                u67.Anchor[#u67.Anchor + 1] = {
                    Anchored = v68.anchored,
                    Part = v69,
                }
                u67.Locked[#u67.Locked + 1] = v69
                u67.Collision[#u67.Collision + 1] = {
                    CanCollide = v68.cancollide,
                    Part = v69,
                }

                if v68.decal then
                    u67.Decal[#u67.Decal + 1] = {
                        Face = v68.decal.face,
                        Part = v69,
                        TextureType = 'Decal',
                    }
                    u67.SyncDecal[#u67.SyncDecal + 1] = {
                        Face = v68.decal.face,
                        Part = v69,
                        Texture = v68.decal.texture,
                        Transparency = v68.decal.transparency,
                        TextureType = 'Decal',
                    }
                end
                if v68.mesh then
                    local v70 = {
                        Part = v69,
                        TextureId = v68.mesh.texture,
                        VertexColor = Vector3.new(unpack(v68.mesh.vertexcolor)),
                        MeshType = v68.mesh.meshtype,
                        Scale = Vector3.new(unpack(v68.mesh.scale)),
                        Offset = Vector3.new(unpack(v68.mesh.offset)),
                    }

                    if v68.mesh.meshtype == Enum.MeshType.FileMesh then
                        v70.MeshId = v68.mesh.meshid
                    end

                    u67.Mesh[#u67.Mesh + 1] = {
                        Part = v70.Part,
                    }
                    u67.SyncMesh[#u67.SyncMesh + 1] = v70
                end
            end

            local v71, v72 = pcall(function()
                p4:InvokeServer('SyncColor', u67.Colors)
                p4:InvokeServer('SyncResize', u67.Resize)
                p4:InvokeServer('SyncSurface', u67.Surface)
                p4:InvokeServer('SyncMaterial', u67.Material)
                p4:InvokeServer('SyncRotate', u67.Rotate)
                p4:InvokeServer('SyncAnchor', u67.Anchor)
                p4:InvokeServer('SetLocked', u67.Locked, true)
                p4:InvokeServer('SyncCollision', u67.Collision)
                p4:InvokeServer('CreateTextures', u67.Decal)
                p4:InvokeServer('SyncTexture', u67.SyncDecal)
                p4:InvokeServer('CreateMeshes', u67.Mesh)
                p4:InvokeServer('SyncMesh', u67.SyncMesh)
            end)
            local v73 = tick() - v34
            local v74

            if v73 < 60 then
                v74 = string.format('Finished in %.0fs', v73)
            elseif v73 < 3600 then
                local v75 = math.floor(v73 / 60)
                local v76 = v73 % 60

                v74 = string.format('Finished in %dm %.0fs', v75, v76)
            else
                local v77 = math.floor(v73 / 3600)
                local v78 = math.floor(v73 % 3600 / 60)

                v74 = string.format('Finished in %dh %dm', v77, v78)
            end
            if not v71 then
                _BuildLoaderv13:Log({
                    Color = Color3.fromRGB(255, 65, 65),
                    Content = '[IGNORABLE][ERROR]: ' .. v72,
                })
            end

            _BuildLoaderv13:Log({
                Color = Color3.fromRGB(84, 255, 84),
                Content = 'Done! | ' .. v74,
            })
            _BuildLoaderv13:Complete()
        else
            _BuildLoaderv13:Log({
                Color = Color3.fromRGB(255, 65, 65),
                Content = '[ERROR]: ' .. v57,
            })
            _BuildLoaderv13:Complete()
        end
    end,
}
