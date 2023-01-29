-- github tabs are so weird
local blacklisted = {
    att_perk = true,
    att_magazine = true
}

local wildcards = {
    ["*_mag"] = true,
	["att_ammo*"] = true
}

local printOnRemove = true -- prints the gun that had its attachment group removed so I can tell if it worked

local function ContainsWildcard(str, wildcard)
    local startPos, endPos = string.find(wildcard, "*", 1, true)
    local isAtStart = startPos ~= 1

    if isAtStart then
        if str:StartsWith(wildcard:sub(1, #wildcard - 1)) then
            return true
        end

        return false
    else
        local wildcardEnd = wildcard:sub(2, #wildcard)

        if str:sub(#str - #wildcardEnd + 1, #str) == wildcardEnd then
            return true
        end

        return false
    end
end

local function GetWeaponAttachmentGroups(className, returnData)
    local wep = weapons.GetStored(className)
    if not wep or not wep.Customization then return end
    local result = {}
    print("Weapon class name: " .. className)
    
    for index, data in ipairs(wep.Customization) do
        local attGroup = data[1]
        
        if !returnValue then
            print(attGroup)
        else
            table.insert(result, data)
        end
    end

    return result
end

hook.Add("Initialize", "kari_att_group_blacklist", function()
    timer.Simple(0, function()
        for _, weaponInfo in ipairs(weapons.GetList()) do
            local wep = weapons.GetStored(weaponInfo.ClassName)
            if not wep.Customization then continue end

            for index, data in ipairs(wep.Customization) do
                local attGroup = data[1]

                for key, value in pairs(wildcards) do
                    if ContainsWildcard(attGroup, key) then
                        if printOnRemove then
						    print(string.format("Removed %s\'s %s category.", weaponInfo.ClassName, attGroup))
                        end
                        
                        wep.Customization[index] = {data[1]}
                    end
                end

                if blacklisted[attGroup] then
					-- could duplicate, don't care
                    if printOnRemove then
					    print(string.format("Removed %s\'s %s category.", weaponInfo.ClassName, attGroup))
                    end
                    
                    wep.Customization[index] = {data[1]}
                end
            end
        end
    end)
end)

if CLIENT then
    concommand.Add("mw_attgroups", function(ply, cmd, args)
        if not ply:IsSuperAdmin() then return end

        if #args >= 1 then
            for _, className in ipairs(args) do
                GetWeaponAttachmentGroups(className)
            end
        end

        for _, weaponInfo in ipairs(weapons.GetList()) do
            GetWeaponAttachmentGroups(weaponInfo.ClassName)
        end
    end)

    concommand.Add("mw_specificattcheck", function(ply, cmd, args)
        if not ply:IsSuperAdmin() then return end

        if #args >= 1 then
            for _, className in ipairs(args) do
                local allData = GetWeaponAttachmentGroups(className, true)

                if allData then
                    PrintTable(allData)
                end
            end
        end
    end)
end
