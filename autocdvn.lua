local players = game:GetService("Players")
local runService = game:GetService("RunService")
local virtualInput = game:GetService("VirtualInputManager")
local player = players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local farming = false
local radius = 3
local angle = 0
local lastPress = tick()
local pressCooldown = 0.5 -- 0.5 giây spam F

local password = "SCRIPT CDVN FRAM"

-- 🌳 Tìm object gần nhất
local function getClosestObject()
    local closestObj, minDist = nil, math.huge
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Part") or obj:IsA("MeshPart") then
            local dist = (obj.Position - hrp.Position).Magnitude
            if dist < minDist then
                closestObj, minDist = obj, dist
            end
        elseif obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") then
            local dist = (obj.HumanoidRootPart.Position - hrp.Position).Magnitude
            if dist < minDist then
                closestObj, minDist = obj.HumanoidRootPart, dist
            end
        end
    end
    return closestObj
end

-- 🔥 Spam phím F
local function pressF()
    if tick() - lastPress >= pressCooldown then
        lastPress = tick()
        virtualInput:SendKeyEvent(true, Enum.KeyCode.F, false, game)
        virtualInput:SendKeyEvent(false, Enum.KeyCode.F, false, game)
    end
end

-- 🔁 Vòng lặp farm gỗ
runService.RenderStepped:Connect(function()
    if farming then
        local target = getClosestObject()
        if target then
            angle += 0.04
            local offset = Vector3.new(math.cos(angle), 0, math.sin(angle)) * radius
            local targetPos = target.Position + offset
            hrp.CFrame = hrp.CFrame:Lerp(CFrame.new(targetPos), 0.3)
            pressF()
        end
    end
end)

-- 🔐 GUI mật khẩu
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "GUI_FRAM_WOOD"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 160)
frame.Position = UDim2.new(0.35, 0, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", frame)
title.Text = "🔐 NHẬP MẬT KHẨU TOOL"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 16

local passwordBox = Instance.new("TextBox", frame)
passwordBox.PlaceholderText = "Nhập mật khẩu..."
passwordBox.Size = UDim2.new(0.9, 0, 0, 40)
passwordBox.Position = UDim2.new(0.05, 0, 0.4, 0)
passwordBox.Font = Enum.Font.Gotham
passwordBox.TextColor3 = Color3.fromRGB(255, 255, 255)
passwordBox.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
passwordBox.TextSize = 14
Instance.new("UICorner", passwordBox).CornerRadius = UDim.new(0, 8)

local confirmBtn = Instance.new("TextButton", frame)
confirmBtn.Text = "✅ XÁC NHẬN"
confirmBtn.Size = UDim2.new(0.9, 0, 0, 35)
confirmBtn.Position = UDim2.new(0.05, 0, 0.75, 0)
confirmBtn.Font = Enum.Font.GothamBold
confirmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
confirmBtn.BackgroundColor3 = Color3.fromRGB(40, 140, 80)
confirmBtn.TextSize = 14
Instance.new("UICorner", confirmBtn).CornerRadius = UDim.new(0, 8)

-- 📦 GUI chính
local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 240, 0, 190)
mainFrame.Position = UDim2.new(0.1, 0, 0.25, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 40)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = false
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

local mainTitle = Instance.new("TextLabel", mainFrame)
mainTitle.Text = "🌳 AUTO FARM GỖ"
mainTitle.Size = UDim2.new(1, 0, 0, 40)
mainTitle.BackgroundTransparency = 1
mainTitle.Font = Enum.Font.GothamBold
mainTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
mainTitle.TextSize = 18

local toggleBtn = Instance.new("TextButton", mainFrame)
toggleBtn.Size = UDim2.new(0.9, 0, 0, 45)
toggleBtn.Position = UDim2.new(0.05, 0, 0.45, 0)
toggleBtn.Text = "▶️ BẬT AUTO FARM GỖ"
toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
toggleBtn.Font = Enum.Font.Gotham
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 15
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 10)

toggleBtn.MouseButton1Click:Connect(function()
    farming = not farming
    toggleBtn.Text = farming and "⛔️ TẮT AUTO FARM GỖ" or "▶️ BẬT AUTO FARM GỖ"
    toggleBtn.BackgroundColor3 = farming and Color3.fromRGB(255, 70, 70) or Color3.fromRGB(40, 40, 60)
end)

confirmBtn.MouseButton1Click:Connect(function()
    if passwordBox.Text == password then
        frame.Visible = false
        mainFrame.Visible = true
    else
        passwordBox.Text = "❌ Sai mật khẩu!"
        wait(1)
        passwordBox.Text = ""
    end
end)
