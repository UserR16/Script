--// Create Text \\
local function Text(target, title, color, fontsize, name)
local Billboard = Instance.new("BillboardGui", target)
local TextLabel = Instance.new("TextLabel", Billboard)
local UIStroke = Instance.new("UIStroke", TextLabel)
--// Billboard \\
Billboard.AlwaysOnTop = true
Billboard.Size = UDim2.new(0,400,0,100)
Billboard.Name = name
Billboard.Active = true
--// TextLabel \\
TextLabel.AnchorPoint = Vector2.new(0.5,0.5)
TextLabel.BackgroundTransparency = 1
TextLabel.BackgroundColor3 = Color3.new(0,0,0)
TextLabel.TextColor3 = color
TextLabel.Font = "RobotoMono"
TextLabel.TextSize = fontsize
TextLabel.TextTransparency = 0
TextLabel.Visible = true
TextLabel.Text = title
TextLabel.Size = UDim2.new(1,0,0,0)
TextLabel.Position = UDim2.new(0.5,0,0.7,0)
--// UIStroke \\
UIStroke.Thickness = 1
UIStroke.Color = Color3.new()
UIStroke.Transparency = 0
end
--// Create Highlight \\
local function Highlight(target, color, name)
task.wait(0.25)
local Highlight = Instance.new('Highlight', target)
--// Highlight \\
Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
Highlight.FillColor = color
Highlight.OutlineColor = color
Highlight.FillTransparency = 1
Highlight.OutlineTransparency =  0
Highlight.Name = name
end
--// Create Tracer \\
local function Tracer(target, color)
local Tracer = Drawing.new('Line')
game:GetService("RunService").RenderStepped:Connect(function()
Tracer.Color = color
if target.Parent ~= nil and target then
local camera = workspace.CurrentCamera
local vector, onScreen = camera:WorldToViewportPoint(target:IsA("Model") and target:GetPivot().Position or target:IsA("BasePart") and target.Position)
if onScreen then
Tracer.From = Vector2.new(camera.ViewportSize.X /2, camera.ViewportSize.Y / 1)
Tracer.To = Vector2.new(vector.X, vector.Y)
Tracer.Visible = true
else
Tracer.Visible = false
end
end
end)
end
--// Disable Text & Highlight \\
local function Disable(name)
for _,v in ipairs(workspace:GetDescendants()) do
if v.Name == name then
v:Destroy()
end
end
end
for _, v in pairs(workspace.Players.Killers:GetChildren()) do
if v:IsA("Model") and v.Parent.Name == "Killers" then
Text(v.HumanoidRootPart, v.Name .. "\n" .. v:GetAttribute("SkinNameDisplay"), Color3.new(1), 14, "Killer_ESP")
Highlight(v, Color3.new(1), "Killer_ESP")
if _G.TracerKiller then
Tracer(v, Color3.new(1))
end
end
end
for _, v in ipairs(workspace.Players.Survivors:GetChildren()) do
if v:IsA("Model") and v.Parent.Name == "Survivors" then
Text(v.HumanoidRootPart, v.Name, Color3.new(0,1), 14, "Survivor_ESP")
Highlight(v, Color3.new(0,1), "Survivor_ESP")
if _G.TracerSurvivor then
Tracer(v, Color3.new(0,1))
end
end
end
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA("Model") and v.Parent.Name == "Map" and v.Name == "Generator" and not v:FindFirstChild("Generator_ESP") then
Text(v, v.Name, Color3.new(0,0,1), 14, "Generator_ESP")
Highlight(v, Color3.new(0,0,1), "Generator_ESP")
if _G.TracerGenerator then
Tracer(v, Color3.new(0,0,1))
end
end
end
GeneratorESP = workspace.Map.Ingame.Map.ChildAdded:Connect(function(v)
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA("Model") and v.Parent.Name == "Map" and v.Name == "Generator" and not v:FindFirstChild("Generator_ESP") then
Text(v, v.Name, Color3.new(0,0,1), 14, "Generator_ESP")
Highlight(v, Color3.new(0,0,1), "Generator_ESP")
if _G.TracerGenerator then
Tracer(v, Color3.new(0,0,1))
end
end
end
end)
SurvivalESP = workspace.Players.Survivors.ChildAdded:Connect(function(v)
for _, v in ipairs(workspace.Players.Survivors:GetChildren()) do
if v:IsA("Model") and v.Parent.Name == "Survivors" then
Text(v.HumanoidRootPart, v.Name, Color3.new(0,1), 14, "Survivor_ESP")
Highlight(v, Color3.new(0,1), "Survivor_ESP")
if _G.TracerSurvivor then
Tracer(v, Color3.new(0,1))
end
end
end
end)
KillerESP = workspace.Players.Killers.ChildAdded:Connect(function(v)
for _, v in pairs(workspace.Players.Killers:GetChildren()) do
if v:IsA("Model") and v.Parent.Name == "Killers" then
Text(v.HumanoidRootPart, v.Name .. "\n" .. v:GetAttribute("SkinNameDisplay"), Color3.new(1), 14, "Killer_ESP")
Highlight(v, Color3.new(1), "Killer_ESP")
if _G.TracerKiller then
Tracer(v, Color3.new(1))
end
end
end
end)
workspace.DescendantAdded:Connect(function(v)
if v:IsA("ProximityPrompt") then
v.HoldDuration = 0
v.RequiresLineOfSight = false
v.MaxActivationDistance = 15
end
end)

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
