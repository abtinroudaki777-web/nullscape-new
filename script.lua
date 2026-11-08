-- Wait for the game workspace to fully load
if not game:IsLoaded() then game.Loaded:Wait() end

-- The 100% verified target dictionary combining all your console logs
local verifiedTargets = {
    -- Kolona Group
    ["kolona"] = true,
    ["kolona_ai"] = true,
    
    -- Operator Group
    ["operator"] = true,
    ["operator_ai"] = true,
    ["vboperator"] = true,
    ["operatorhalt"] = true,

    -- Voidbreaker Group
    ["voidbreaker"] = true,
    ["voidbreaker_ai"] = true,

    -- Scrapmaw Group
    ["scrapmaw"] = true,
    ["scrapmaw_ai"] = true,

    -- Voidbound ICBM Group (Newly Added!)
    ["voidboundicbm"] = true,
    ["voidboundicm_clientai"] = true
}

-- Target evaluation function
local function cleanTarget(instance)
    if instance then
        local lowerName = string.lower(instance.Name)
        
        -- Instantly remove if it matches any verified log entry or contains the keyword
        if verifiedTargets[lowerName] or string.find(lowerName, "voidboundicbm") or string.find(lowerName, "voidboundicm") then
            print("[Matrix Cleaner] Erased verified target: " .. tostring(instance.Name))
            instance:Destroy()
        end
    end
end

-- 1. Initial Map Sweep: Scan everything currently loaded
for _, item in pairs(workspace:GetDescendants()) do
    cleanTarget(item)
end

-- 2. Active Monitor: Intercept the exact millisecond a new instance appears
workspace.DescendantAdded:Connect(cleanTarget)

-- Standard system confirmation popup
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "ICBM Logs Applied",
    Text = "Monitoring actively for all core entities and Voidbound ICBM components.",
    Duration = 5
})
