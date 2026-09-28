local repo="https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"

local Library=loadstring(game:HttpGet(repo.."Library.lua"))()
local ThemeManager=loadstring(game:HttpGet(repo.."addons/ThemeManager.lua"))()
local SaveManager=loadstring(game:HttpGet(repo.."addons/SaveManager.lua"))()

local Options=Library.Options
local Toggles=Library.Toggles

--==================================================
-- CONFIG
--==================================================

local KEY="Key_123"
local KEY_LINK="https://work.ink/327x/keysystem-4-script"

--==================================================
-- GAME DATABASE
--==================================================

local GameScripts={

    [17625359962]={
        Name="Rivals",

        Scripts={
            {
                Name="Placeholder",
                URL=""
            },
            {
                Name="Placeholder",
                URL=""
            },
            {
                Name="Placeholder",
                URL=""
            },
            {
                Name="Placeholder",
                URL=""
            },
            {
                Name="Placeholder",
                URL=""
            }
        }
    },

    [16732694052]={
        Name="Fisch",

        Scripts={
            {
                Name="Meng Hub (KEYLESS, BEST)",
                URL="https://raw.githubusercontent.com/GrexXMeng/Mengs/refs/heads/main/Fisch.lua"
            },
            {
                Name="Axon Hub",
                URL="https://rawscripts.net/raw/Universal-Script-Axon-Hub-79767"
            },
            {
                Name="Flow Hub",
                URL="https://rawscripts.net/raw/Universal-Script-Flow-ScriptHub-20-Games-240374"
            },
            {
                Name="Forge Hub",
                URL="https://api.luarmor.net/files/v3/loaders/d5ed1fbd4301b1d18d75153c5b47181d.lua"
            },
            {
                Name="Air Flow Hub",
                URL="https://airflowscript.com/loader"
            }
        }
    },

    [107778070777162]={
        Name="Steal An Egg",

        Scripts={
            {
                Name="Flow Hub",
                URL="https://rawscripts.net/raw/Universal-Script-Flow-ScriptHub-20-Games-240374"
            },
            {
                Name="Axonic Hub",
                URL="https://rawscripts.net/raw/Universal-Script-Axonic-Hub-228755"
            },
            {
                Name="Lumin Hub",
                URL="https://rawscripts.net/raw/Steal-An-Egg-Lumin-Hub-223771"
            },
            {
                Name="Ronix Hub",
                URL="https://rawscripts.net/raw/Universal-Script-Radius-Hub-15-Games-61719"
            },
            {
                Name="Atherhub",
                URL="https://rawscripts.net/raw/Steal-An-Egg-Atherhub-Auto-Farm-Eggs-Auto-Event-Auto-Steal-227565"
            }
        }
    }
}

--==================================================
-- WINDOW
--==================================================

local Window=Library:CreateWindow({
    Title="Archwieran Hub",
    Footer="Key System",
    Center=true,
    AutoShow=true,
    NotifySide="Right",
    ShowCustomCursor=true,
})

--==================================================
-- KEY SYSTEM
--==================================================

local KeyTab=Window:AddKeyTab(
    "Key System",
    "key"
)

KeyTab:AddLabel({
    Text="Archwieran Hub",
    DoesWrap=true,
    Size=20,
})

KeyTab:AddLabel({
    Text="Get your key using the button below.",
    DoesWrap=true,
    Size=15,
})

KeyTab:AddButton({
    Text="Copy Key System Link",

    Func=function()
        if setclipboard then
            setclipboard(KEY_LINK)

            Library:Notify({
                Title="Archwieran Hub",
                Description="Key System Has been copied To Your Clipboard",
                Time=5,
            })
        end
    end,
})

KeyTab:AddLabel({
    Text=KEY_LINK,
    DoesWrap=true,
    Size=13,
})

--==================================================
-- DETECT GAME
--==================================================

local GameInfo=GameScripts[game.PlaceId]
local DetectedTab

if GameInfo then

    DetectedTab=Window:AddTab(
        GameInfo.Name,
        "gamepad-2"
    )

    for Index,ScriptInfo in ipairs(GameInfo.Scripts) do

        if Index>5 then
            break
        end

        local ScriptGroup=DetectedTab:AddLeftGroupbox(
            ScriptInfo.Name,
            "code"
        )

        ScriptGroup:AddLabel({
            Text=ScriptInfo.Name,
            DoesWrap=true,
            Size=18,
        })

        ScriptGroup:AddButton({
            Text="Execute",

            Func=function()

                if ScriptInfo.URL=="" then

                    Library:Notify({
                        Title="Archwieran Hub",
                        Description="This script has not been added yet.",
                        Time=4,
                    })

                    return
                end

                local Success,Error=pcall(function()

                    local Source=game:HttpGet(
                        ScriptInfo.URL
                    )

                    local Loaded=loadstring(Source)

                    if Loaded then
                        Loaded()
                    end

                end)

                if Success then

                    Library:Notify({
                        Title="Archwieran Hub",
                        Description=ScriptInfo.Name.." executed!",
                        Time=4,
                    })

                else

                    warn(Error)

                    Library:Notify({
                        Title="Archwieran Hub",
                        Description="Failed to execute "..ScriptInfo.Name,
                        Time=5,
                    })

                end
            end,
        })
    end

else

    DetectedTab=Window:AddTab(
        "Unsupported",
        "circle-help"
    )

    local UnsupportedGroup=
        DetectedTab:AddLeftGroupbox(
            "Game Detection",
            "circle-help"
        )

    UnsupportedGroup:AddLabel({
        Text="Unsupported game, Suggest In comments!",
        DoesWrap=true,
        Size=17,
    })

    UnsupportedGroup:AddDivider()

    UnsupportedGroup:AddLabel({
        Text="Place ID: "..tostring(game.PlaceId),
        DoesWrap=true,
        Size=14,
    })
end

--==================================================
-- SETTINGS
--==================================================

local Settings=Window:AddTab(
    "Settings",
    "settings"
)

--==================================================
-- SUPPORT TAB
--==================================================

local SupportTab=Window:AddTab(
    "Support",
    "badge-check"
)

--==================================================
-- HIDE UNTIL KEY IS VERIFIED
--==================================================

DetectedTab:SetVisible(false)
Settings:SetVisible(false)
SupportTab:SetVisible(false)

--==================================================
-- SETTINGS: MENU
--==================================================

local MenuGroup=Settings:AddLeftGroupbox(
    "Menu",
    "wrench"
)

MenuGroup:AddToggle("KeybindMenuOpen",{
    Default=Library.KeybindFrame.Visible,
    Text="Open Keybind Menu",

    Callback=function(Value)
        Library.KeybindFrame.Visible=Value
    end,
})

MenuGroup:AddToggle("ShowCustomCursor",{
    Text="Custom Cursor",
    Default=Library.ShowCustomCursor,

    Callback=function(Value)
        Library.ShowCustomCursor=Value
    end,
})

MenuGroup:AddDropdown("NotificationSide",{
    Values={
        "Left",
        "Right"
    },

    Default="Right",
    Text="Notification Side",

    Callback=function(Value)
        Library:SetNotifySide(Value)
    end,
})

MenuGroup:AddSlider("DPIScale",{
    Text="DPI Scale",
    Default=100,
    Min=50,
    Max=200,
    Rounding=0,

    Callback=function(Value)
        Library:SetDPIScale(Value)
    end,
})

--==================================================
-- SETTINGS: THEME
--==================================================

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

ThemeManager:SetFolder("ArchwieranHub")
SaveManager:SetFolder("ArchwieranHub")

ThemeManager:ApplyToTab(Settings)
SaveManager:BuildConfigSection(Settings)

--==================================================
-- SETTINGS: KEYBIND
--==================================================

local KeybindGroup=Settings:AddLeftGroupbox(
    "Menu Keybind",
    "keyboard"
)

KeybindGroup:AddLabel("Menu Bind")
    :AddKeyPicker("MenuKeybind",{
        Default="RightShift",
        NoUI=true,
        Text="Menu keybind"
    })

Library.ToggleKeybind=Options.MenuKeybind

--==================================================
-- SETTINGS: UNLOAD
--==================================================

KeybindGroup:AddButton({
    Text="Unload",

    Func=function()
        Library:Unload()
    end,
})

--==================================================
-- SUPPORT CONTENT
--==================================================

local SupportGroup=SupportTab:AddLeftGroupbox(
    "Supported Games",
    "gamepad-2"
)

SupportGroup:AddLabel({
    Text="Archwieran Hub currently supports:",
    DoesWrap=true,
    Size=17,
})

SupportGroup:AddDivider()

SupportGroup:AddLabel({
    Text="Rivals",
    DoesWrap=true,
    Size=16,
})

SupportGroup:AddLabel({
    Text="Place ID: 17625359962",
    DoesWrap=true,
    Size=13,
})

SupportGroup:AddDivider()

SupportGroup:AddLabel({
    Text="Fisch",
    DoesWrap=true,
    Size=16,
})

SupportGroup:AddLabel({
    Text="Place ID: 16732694052",
    DoesWrap=true,
    Size=13,
})

SupportGroup:AddDivider()

SupportGroup:AddLabel({
    Text="Steal An Egg",
    DoesWrap=true,
    Size=16,
})

SupportGroup:AddLabel({
    Text="Place ID: 107778070777162",
    DoesWrap=true,
    Size=13,
})

SupportGroup:AddDivider()

SupportGroup:AddLabel({
    Text="More games coming soon!",
    DoesWrap=true,
    Size=14,
})

--==================================================
-- KEY VALIDATION
--==================================================

KeyTab:AddKeyBox(function(ReceivedKey)

    if ReceivedKey==KEY then

        Library:Notify({
            Title="Archwieran Hub",
            Description="Key accepted!",
            Time=4,
        })

        task.wait(0.5)

        -- Hide Key System
        KeyTab:SetVisible(false)

        -- Show detected game
        DetectedTab:SetVisible(true)

        -- Show Settings
        Settings:SetVisible(true)

        -- Show Support
        SupportTab:SetVisible(true)

        -- Open detected game
        DetectedTab:Show()

    else

        Library:Notify({
            Title="Archwieran Hub",
            Description="Invalid key!",
            Time=4,
        })

    end
end)

--==================================================
-- AUTO COPY KEY LINK
--==================================================

if setclipboard then

    setclipboard(KEY_LINK)

    Library:Notify({
        Title="Archwieran Hub",
        Description="Key System Has been copied To Your Clipboard",
        Time=5,
    })

end

--==================================================
-- LOAD SAVED CONFIG
--==================================================

SaveManager:LoadAutoloadConfig()
