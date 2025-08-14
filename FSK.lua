local LibESP = loadstring(game:HttpGet("https://github.com/ImamGV/Script/blob/main/ESP?raw=true"))()
game:GetService("RunService").RenderStepped:Connect(function()
game.Players.LocalPlayer.PlayerGui.TemporaryUI.PlayerInfo.CurrentSurvivors.Visible = true
StaminaScript = require(game:GetService("ReplicatedStorage").Systems.Character.Game.Sprinting)
StaminaScript.MaxStamina = 5000
StaminaScript.StaminaGain = 500
StaminaScript.StaminaLoss = 10
StaminaScript.SprintSpeed = 30
game.Lighting.OutdoorAmbient = Color3.fromRGB(255,255,255)
game.Lighting.Brightness = 1.5
game.Lighting.GlobalShadows = false
workspace.Camera.FieldOfView = 120
if not game.Lighting:GetAttribute("FogStart") then game.Lighting:SetAttribute("FogStart", game.Lighting.FogStart) end
if not game.Lighting:GetAttribute("FogEnd") then game.Lighting:SetAttribute("FogEnd", game.Lighting.FogEnd) end
game.Lighting.FogStart = true and 0 or game.Lighting:GetAttribute("FogStart")
game.Lighting.FogEnd = true and math.huge or game.Lighting:GetAttribute("FogEnd")
local fog = game.Lighting:FindFirstChildOfClass("Atmosphere")
if fog then
if not fog:GetAttribute("Density") then fog:SetAttribute("Density", fog.Density) end
fog.Density = true and 0 or fog:GetAttribute("Density")
end
end)
if game:GetService("ReplicatedStorage").Modules.StatusEffects:WaitForChild("Slowness") then
game:GetService("ReplicatedStorage").Modules.StatusEffects.Slowness:Destroy()
end
