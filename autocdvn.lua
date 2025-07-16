-- 🌟 QUÉT MAP + HIỆN KẾT QUẢ SCREEN GUI + COPY (FIX SolaraV3)
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")
local coreGui = game:GetService("CoreGui")
local player = players.LocalPlayer

-- 🖥️ Tạo GUI trong CoreGui (để SolaraV3 không chặn)
local gui = Instance.new("ScreenGui")
gui.Name = "ScanResultGUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
pcall(function() gui.Parent = coreGui end)

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 500, 0, 400)
frame.Position = UDim2.new(0.25, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", frame)
title.Text = "📡 QUÉT MAP AUTO FARM – CDVN"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 5)

local scroll = Instance.new("ScrollingFrame", frame)
scroll.Size = UDim2.new(1, -10, 1, -80)
scroll.Position = UDim2.new(0, 5, 0, 35)
scroll.CanvasSize = UDim2.new(0, 0, 10, 0)
scroll.ScrollBarThickness = 8
scroll.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
Instance.new("UICorner", scroll).CornerRadius = UDim.new(0, 5)

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 5)
layout.SortOrder = Enum.SortOrder.LayoutOrder

local clipboardContent = ""

local function addLine(text, color)
    clipboardContent = clipboardContent .. text .. "\n"
    local label = Instance.new("TextLabel", scroll)
    label.Size = UDim2.new(1, -10, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Code
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
end

-- 📍 Vị trí hiện tại
if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
    local pos = player.Character.HumanoidRootPart.Position
    addLine("📍 Vị trí hiện tại:", Color3.fromRGB(0, 255, 255))
    addLine("Vector3.new("..math.floor(pos.X)..","..math.floor(pos.Y)..","..math.floor(pos.Z)..")", Color3.fromRGB(150, 255, 150))
end

-- 🔥 RemoteEvent & RemoteFunction
addLine("\n📡 REMOTEEVENT / FUNCTION:", Color3.fromRGB(255, 200, 0))
for _, v in pairs(replicatedStorage:GetDescendants()) do
    if v:IsA("RemoteEvent") then
        addLine("🔹 "..v:GetFullName(), Color3.fromRGB(255, 255, 0))
    elseif v:IsA("RemoteFunction") then
        addLine("🔸 "..v:GetFullName(), Color3.fromRGB(255, 200, 0))
    end
end

-- 🌲 Cây chặt gỗ
addLine("\n🌳 CÂY CHẶT GỖ:", Color3.fromRGB(0, 255, 0))
for _, obj in pairs(workspace:GetDescendants()) do
    if (obj:IsA("Part") or obj:IsA("MeshPart")) and (obj.Name:lower():find("tree") or obj.Name:lower():find("wood")) then
        local p = obj.Position
        addLine("🌲 "..obj:GetFullName(), Color3.fromRGB(0, 255, 0))
        addLine("  Vector3.new("..math.floor(p.X)..","..math.floor(p.Y)..","..math.floor(p.Z)..")", Color3.fromRGB(150, 255, 150))
    elseif obj:IsA("Model") and obj.Name:lower():find("tree") and obj:FindFirstChild("HumanoidRootPart") then
        local p = obj.HumanoidRootPart.Position
        addLine("🌲 "..obj:GetFullName(), Color3.fromRGB(0, 255, 0))
        addLine("  Vector3.new("..math.floor(p.X)..","..math.floor(p.Y)..","..math.floor(p.Z)..")", Color3.fromRGB(150, 255, 150))
    end
end

-- 🪓 Shop/Rìu
addLine("\n🪓 SHOP HOẶC RÌU:", Color3.fromRGB(0, 200, 255))
for _, obj in pairs(workspace:GetDescendants()) do
    if obj.Name:lower():find("shop") or obj.Name:lower():find("axe") then
        local p = obj.Position or (obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") and obj.HumanoidRootPart.Position)
        if p then
            addLine("🛒 "..obj:GetFullName(), Color3.fromRGB(0, 200, 255))
            addLine("  Vector3.new("..math.floor(p.X)..","..math.floor(p.Y)..","..math.floor(p.Z)..")", Color3.fromRGB(150, 255, 150))
        end
    end
end

-- 💰 Nơi bán gỗ
addLine("\n💰 NƠI BÁN GỖ:", Color3.fromRGB(255, 100, 100))
for _, obj in pairs(workspace:GetDescendants()) do
    if obj.Name:lower():find("sell") or obj.Name:lower():find("cash") then
        local p = obj.Position or (obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") and obj.HumanoidRootPart.Position)
        if p then
            addLine("💰 "..obj:GetFullName(), Color3.fromRGB(255, 100, 100))
            addLine("  Vector3.new("..math.floor(p.X)..","..math.floor(p.Y)..","..math.floor(p.Z)..")", Color3.fromRGB(150, 255, 150))
        end
    end
end

addLine("\n✅ XONG! Ấn COPY để sao chép toàn bộ kết quả.", Color3.fromRGB(0, 255, 127))

-- 📋 Nút COPY
local copyBtn = Instance.new("TextButton", frame)
copyBtn.Size = UDim2.new(0.9, 0, 0, 30)
copyBtn.Position = UDim2.new(0.05, 0, 1, -35)
copyBtn.Text = "📋 COPY TO CLIPBOARD"
copyBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 200)
copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
copyBtn.Font = Enum.Font.GothamBold
copyBtn.TextSize = 14
Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 5)

copyBtn.MouseButton1Click:Connect(function()
    pcall(function()
        setclipboard(clipboardContent)
        copyBtn.Text = "✅ ĐÃ COPY!"
    end)
    wait(2)
    copyBtn.Text = "📋 COPY TO CLIPBOARD"
end)
