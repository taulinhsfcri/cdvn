-- 🌟 QUÉT MAP TÌM BIẾN AUTO FARM 🌟
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")
local player = players.LocalPlayer

print("🌐 ---- QUÉT BẢN ĐỒ ----")

-- 🧭 Lấy tọa độ vị trí hiện tại
if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
    local pos = player.Character.HumanoidRootPart.Position
    print("📍 Vị trí hiện tại:")
    print("Vector3.new(" .. math.floor(pos.X) .. ", " .. math.floor(pos.Y) .. ", " .. math.floor(pos.Z) .. ")")
end

-- 🔥 Quét RemoteEvent
print("\n📡 ---- REMOTEEVENT TRONG GAME ----")
for _, v in pairs(replicatedStorage:GetDescendants()) do
    if v:IsA("RemoteEvent") then
        print("🔹 RemoteEvent: "..v:GetFullName())
    elseif v:IsA("RemoteFunction") then
        print("🔹 RemoteFunction: "..v:GetFullName())
    end
end

-- 🌲 Tìm cây chặt gỗ (Part hoặc Model có “Tree”)
print("\n🌳 ---- CÂY CHẶT GỖ ----")
for _, obj in pairs(workspace:GetDescendants()) do
    if obj:IsA("Part") or obj:IsA("MeshPart") then
        if obj.Name:lower():find("tree") or obj.Name:lower():find("wood") then
            local p = obj.Position
            print("🌲 Cây: "..obj:GetFullName())
            print("Vector3.new(" .. math.floor(p.X) .. ", " .. math.floor(p.Y) .. ", " .. math.floor(p.Z) .. ")\n")
        end
    elseif obj:IsA("Model") and obj.Name:lower():find("tree") then
        if obj:FindFirstChild("HumanoidRootPart") then
            local p = obj.HumanoidRootPart.Position
            print("🌲 Cây (Model): "..obj:GetFullName())
            print("Vector3.new(" .. math.floor(p.X) .. ", " .. math.floor(p.Y) .. ", " .. math.floor(p.Z) .. ")\n")
        end
    end
end

-- 🏪 Tìm shop/rìu
print("\n🪓 ---- SHOP HOẶC RÌU ----")
for _, obj in pairs(workspace:GetDescendants()) do
    if obj.Name:lower():find("shop") or obj.Name:lower():find("axe") then
        local p = obj.Position or (obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") and obj.HumanoidRootPart.Position)
        if p then
            print("🛒 Shop/Rìu: "..obj:GetFullName())
            print("Vector3.new(" .. math.floor(p.X) .. ", " .. math.floor(p.Y) .. ", " .. math.floor(p.Z) .. ")\n")
        end
    end
end

-- 💰 Tìm nơi bán gỗ
print("\n💰 ---- NƠI BÁN GỖ ----")
for _, obj in pairs(workspace:GetDescendants()) do
    if obj.Name:lower():find("sell") or obj.Name:lower():find("cash") then
        local p = obj.Position or (obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") and obj.HumanoidRootPart.Position)
        if p then
            print("💰 Bán gỗ: "..obj:GetFullName())
            print("Vector3.new(" .. math.floor(p.X) .. ", " .. math.floor(p.Y) .. ", " .. math.floor(p.Z) .. ")\n")
        end
    end
end

print("\n✅ XONG! Copy các giá trị trên vào script farm.")
