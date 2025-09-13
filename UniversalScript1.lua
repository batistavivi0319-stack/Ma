-- UNIVERSAL HUB V4 (SEM KEY) 🍑
-- Rayfield (Sirius Menu) por Kevin

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
   Name = "Universal Hub V4",
   LoadingTitle = "Carregando Hub...",
   LoadingSubtitle = "by Kevin",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "UniversalHub",
      FileName = "ConfigV4"
   }
})

-------------------------------------------------------
-- 📌 ABA 1: MISC
-------------------------------------------------------
local Misc = Window:CreateTab("Misc", 4483362458)

-- WalkSpeed
Misc:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 300},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(v)
      local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
      if hum then hum.WalkSpeed = v end
   end
})

-- JumpPower
Misc:CreateSlider({
   Name = "JumpPower",
   Range = {50, 500},
   Increment = 5,
   CurrentValue = 50,
   Callback = function(v)
      local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
      if hum then hum.JumpPower = v end
   end
})

-- FOV
Misc:CreateSlider({
   Name = "FOV",
   Range = {70, 120},
   Increment = 1,
   CurrentValue = 70,
   Callback = function(v)
      workspace.CurrentCamera.FieldOfView = v
   end
})

-- ESP Box
local ESPColor = Color3.fromRGB(255,0,0)
local ESPEnabled = false
local function createESP(player)
   if player.Character and not player.Character:FindFirstChild("Highlight") then
      local h = Instance.new("Highlight", player.Character)
      h.FillTransparency = 1
      h.OutlineColor = ESPColor
      h.OutlineTransparency = 0
   end
end

Misc:CreateToggle({
   Name = "ESP Box",
   CurrentValue = false,
   Callback = function(state)
      ESPEnabled = state
      for _,plr in pairs(game.Players:GetPlayers()) do
         if plr ~= game.Players.LocalPlayer then
            if ESPEnabled then
               createESP(plr)
            else
               if plr.Character:FindFirstChild("Highlight") then
                  plr.Character.Highlight:Destroy()
               end
            end
         end
      end
   end
})

Misc:CreateColorPicker({
   Name = "ESP Color",
   Color = ESPColor,
   Callback = function(c)
      ESPColor = c
      for _,plr in pairs(game.Players:GetPlayers()) do
         if plr.Character:FindFirstChild("Highlight") then
            plr.Character.Highlight.OutlineColor = ESPColor
         end
      end
   end
})

-- AutoClicker
local clicking = false
Misc:CreateToggle({
   Name = "AutoClicker",
   CurrentValue = false,
   Callback = function(state)
      clicking = state
      spawn(function()
         while clicking do
            pcall(function() game:GetService("VirtualUser"):ClickButton1(Vector2.new()) end)
            task.wait(0.05)
         end
      end)
   end
})

-- NoFog
Misc:CreateToggle({
   Name = "Remover Fog",
   CurrentValue = false,
   Callback = function(v)
      if v then
         game.Lighting.FogEnd = 1e6
      else
         game.Lighting.FogEnd = 1000
      end
   end
})

-------------------------------------------------------
-- 📌 ABA 2: PLAYER TROLL
-------------------------------------------------------
local Troll = Window:CreateTab("Player Troll", 4483362458)

-- Fake Kick
Troll:CreateButton({
   Name = "Fake Kick",
   Callback = function()
      game.Players.LocalPlayer:Kick("Você foi banido permanentemente. Motivo: Exploit detectado.")
   end
})

-- Freeze
Troll:CreateButton({
   Name = "Freeze",
   Callback = function()
      local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
      if hrp then hrp.Anchored = not hrp.Anchored end
   end
})

-- Noclip
local noclip = false
Troll:CreateToggle({
   Name = "Noclip",
   CurrentValue = false,
   Callback = function(v)
      noclip = v
      game:GetService("RunService").Stepped:Connect(function()
         if noclip and game.Players.LocalPlayer.Character then
            for _,part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
               if part:IsA("BasePart") then
                  part.CanCollide = false
               end
            end
         end
      end)
   end
})

-- Fly
local flying = false
Troll:CreateToggle({
   Name = "Fly",
   CurrentValue = false,
   Callback = function(v)
      flying = v
      spawn(function()
         local plr = game.Players.LocalPlayer
         local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
         while flying and hum do
            hum:ChangeState(Enum.HumanoidStateType.Physics)
            plr.Character:TranslateBy(Vector3.new(0,0.5,0))
            task.wait(0.05)
         end
      end)
   end
})

-- GodMode Local
Troll:CreateButton({
   Name = "GodMode Local",
   Callback = function()
      local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
      if hum then
         local clone = hum:Clone()
         clone.Parent = hum.Parent
         hum:Destroy()
      end
   end
})

-------------------------------------------------------
-- 📌 ABA 3: VISUAL FUN
-------------------------------------------------------
local Visual = Window:CreateTab("Visual Fun", 4483362458)

Visual:CreateButton({
   Name = "Flashbang",
   Callback = function()
      local cc = Instance.new("ColorCorrectionEffect", game.Lighting)
      cc.Brightness = 5
      task.wait(2)
      cc:Destroy()
   end
})

Visual:CreateButton({
   Name = "Tela Invertida",
   Callback = function()
      local cc = Instance.new("ColorCorrectionEffect", game.Lighting)
      cc.Contrast = -1
   end
})

Visual:CreateButton({
   Name = "Camuflagem",
   Callback = function()
      for _,p in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
         if p:IsA("BasePart") then
            p.Transparency = 1
         end
      end
   end
})

Visual:CreateButton({
   Name = "Forçar Dia",
   Callback = function() game.Lighting.ClockTime = 14 end
})
Visual:CreateButton({
   Name = "Forçar Noite",
   Callback = function() game.Lighting.ClockTime = 0 end
})

-------------------------------------------------------
-- 📌 ABA 4: EXTRA
-------------------------------------------------------
local Extra = Window:CreateTab("Extra", 4483362458)

Extra:CreateButton({
   Name = "Rejoin",
   Callback = function()
      game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
   end
})

Extra:CreateButton({
   Name = "ServerHop",
   Callback = function()
      local ts = game:GetService("TeleportService")
      local servers = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
      for _,s in pairs(servers.data) do
         if s.playing < s.maxPlayers then
            ts:TeleportToPlaceInstance(game.PlaceId, s.id)
            break
         end
      end
   end
})

Extra:CreateButton({
   Name = "Reset Rápido",
   Callback = function()
      game.Players.LocalPlayer.Character:BreakJoints()
   end
})

Extra:CreateSlider({
   Name = "Velocidade de Animação",
   Range = {1, 5},
   Increment = 0.1,
   CurrentValue = 1,
   Callback = function(v)
      for _,track in pairs(game.Players.LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks()) do
         track:AdjustSpeed(v)
      end
   end
})
