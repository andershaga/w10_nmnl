<#
.SYNOPSIS
    Several Windows 10 adjustments
     - no more, no less
.NOTES
    Creator: github.com/andershaga
    Created: 2021-06-01
    Changed: 2021-06-10
#>

#Requires -RunAsAdministrator

BEGIN
{
    Clear-Host
    
    $ProgressPreference = "SilentlyContinue"

    function Step-Registry
    {
        write-host "VARIOUS REGISTRY SETTINGS`n" -f Yellow

        $registrySettings = @(
            
            # Search
            'Allow cortana,HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search,AllowCortana,DWord,0'
            'Use web search suggestion in start menu,HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search,ConnectedSearchUseWeb,DWord,0'
            'Turn off search companion content file updates,HKLM:\SOFTWARE\Policies\Microsoft\SearchCompanion,DisableContentFileUpdates,DWord,1'
            'Turn off search box suggestions,HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer,DisableSearchBoxSuggestions,DWord,1'

            # Notifications
            'Remove notifications and action center,HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer,DisableNotificationCenter,DWord,0'
            'Hide non-critical notifications,HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications,DisableEnhancedNotifications,DWord,1'
            #'Hide all notifications,HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications,DisableNotifications,DWord,1'
            'Hide firewall notifications,HKLM:\SOFTWARE\Microsoft\Windows Defender Security Center\Notifications,DisableNotifications,DWord,1'
            'Show reminders and incoming voip calls on the lock screen,HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings,NOC_GLOBAL_SETTING_ALLOW_CRITICAL_TOASTS_ABOVE_LOCK,DWord,0'
            'Allow notifications to play sounds,HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings,NOC_GLOBAL_SETTING_ALLOW_NOTIFICATION_SOUND,DWord,0'
            'Show notifications on the lock screen,HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings,NOC_GLOBAL_SETTING_ALLOW_TOASTS_ABOVE_LOCK,DWord,0'

            # Updates
            'Disable automatic updates,HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU,NoAutoUpdate,DWord,1' # You can still update manually
            'Automatically wake up the system to install scheduled updates,HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU,AUPowerManagement,DWord,0'
            'No auto-restart with logged on users for scheduled automatic updates installations,HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU,NoAutoRebootWithLoggedOnUsers,DWord,1'

			# UAC (level 2)
            'Consent Prompt Behavior Admin,HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System,ConsentPromptBehaviorAdmin,DWord,5'
            'Consent Prompt Behavior User,HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System,ConsentPromptBehaviorUser,DWord,3'
            'Enable Installer Detection,HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System,EnableInstallerDetection,DWord,1'
            'Enable LUA,HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System,EnableLUA,DWord,1'
            'Enable Virtualization,HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System,EnableVirtualization,DWord,1'
            'Prompt On Secure Desktop,HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System,PromptOnSecureDesktop,DWord,0'
            'Validate Admin Code Signatures,HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System,ValidateAdminCodeSignatures,DWord,0'
            'Filter Administrator Token,HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System,FilterAdministratorToken,DWord,0'
			
            # Taskbar
            'Show task view button,HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced,ShowTaskViewButton,DWord,0'
            'Show cortana button,HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced,ShowCortanaButton,DWord,0'
            'Show search box,HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search,SearchboxTaskbarMode,DWord,0'
            'Hide meet now,HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer,HideSCAMeetNow,DWord,1'
            'Turn off news and interests,HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds,ShellFeedsTaskbarViewMode,DWord,2'
            'Use light theme for apps,HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize,AppsUseLightTheme,DWord,0'
            'Use light theme for system,HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize,SystemUsesLightTheme,DWord,0'

            # Personalization
            'Explorer shows freqent files,HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer,ShowFrequent,DWord,0'
            'Explorer shows recent files,HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer,ShowRecent,DWord,0'
            'Explorer start in my computer,HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced,LaunchTo,DWord,1'
            'Explorer use check boxes,HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced,AutoCheckSelect,DWord,0'
            'Hide file extensions,HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced,HideFileExt,DWord,0'
            'Automatically hide scrollbars,HKCU:\Control Panel\Accessibility,DynamicScrollbars,DWord,0'
            'Use transparency effects,HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize,EnableTransparency,DWord,0'
            'Do not show windows tips,HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent,DisableSoftLanding,DWord,1'
            'Do not display the lock screen,HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization,NoLockScreen,DWord,1'
            'Disable logon background image,HKLM:\Software\Policies\Microsoft\Windows\System,DisableLogonBackgroundImage,DWord,1'
            'Display recently opened programs in the start menu,HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced,Start_TrackDocs,DWord,0'
            'Remove recently added list from start menu,HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer,HideRecentlyAddedApps,DWord,1'
            'Remove sleep button,HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings,ShowSleepOption,DWord,0'
            'Remove wallpaper,HKCU:\Control Panel\Desktop,WallPaper,String,'
            'Set solid color,HKCU:\Control Panel\Colors,Background,String,45 125 154'

            # Various
            'Enable hibernation,HKCU:\SYSTEM\CurrentControlSet\Control\Power,HibernateEnabled,DWord,0'
            'Prevent the usage of onedrive for file storage,HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive,DisableFileSyncNGSC,DWord,1'
            'Enables or disables windows game recording and broadcasting,HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR,AllowGameDVR,DWord,0'
            'Activate storage sense for user,HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy,01,DWord,0'
            'Activate storage sense for machine,HKLM:\SOFTWARE\Policies\Microsoft\Windows\StorageSense,AllowStorageSenseGlobal,DWord,0'
            'I/O request packet stack size,HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters,IRPStackSize,DWord,30'
            'Download method of delivery optimization,HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization,DODownloadMode,DWord,0'
            'Passwordless device checkbox,HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\PasswordLess\Device,DevicePasswordLessBuildVersion,DWord,0'
            'Fast startup,HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power,HiberbootEnabled,DWord,0'

        ) | ConvertFrom-Csv -Delimiter ',' -Header DESCRIPTION,PATH,NAME,TYPE,VALUE
                
        foreach ($setting in $registrySettings  )
        {
            write-host "" $setting.description -n; write-host "" $setting.value -f yellow
        
            if (!(test-path $setting.path)) {new-item $setting.path -force | out-null}
            New-ItemProperty $setting.path -Name $setting.name -PropertyType $setting.type -Value $(if(!$setting.value){""}else{$setting.value}) -force | out-null
        }

        # Subscribed Content (Suggestions)
        
        $contentDeliveryMgr = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'
        
        (Get-Item -Path $contentDeliveryMgr).property | ? {$_ -like "*SubscribedContent*"} | % {

            write-host " Suggested content ($_)" -n; write-host "" 0 -f yellow
            New-ItemProperty $contentDeliveryMgr -Name $_ -Value 0 -Force | out-null
        }

        write-host ""
    }
    function Step-PerformanceOptions
    {
        write-host "ANIMATIONS AND PERFORMANCE`n" -f Yellow

        $animationSettings = @(

            'Appearance option mode,HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects,VisualFXSetting,DWord,2' # 1 appearance, 2 performance, 3 custom
            'Animate windows when minimizing and maximizing,HKCU:\Control Panel\Desktop\WindowMetrics,MinAnimate,String,0'
            'Animations in the taskbar,HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced,TaskbarAnimations,DWord,0'
            'Enable peek,HKCU:\SOFTWARE\Microsoft\Windows\DWM,EnableAeroPeek,DWord,0'
            'Save thumbnail taskbar previews,HKCU:\SOFTWARE\Microsoft\Windows\DWM,AlwaysHibernateThumbnails,DWord,0'
            'Show thumbnails instead of icons,HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced,IconsOnly,DWord,1'
            'Show translucent selection rectangle,HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced,ListviewAlphaSelect,DWord,0'
            'Show window contents while dragging,HKCU:\Control Panel\Desktop,DragFullWindows,String,0'
            'Smooth edges of screen fonts,HKCU:\Control Panel\Desktop,FontSmoothing,String,0'
            'Use drop shadows for icon labels on the desktop,HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced,ListviewShadow,DWord,0'

        ) | ConvertFrom-Csv -Delimiter ',' -Header DESCRIPTION,PATH,NAME,TYPE,VALUE

        foreach ($setting in $animationSettings)
        {
            write-host "" $setting.description -n; write-host "" $setting.value -f yellow
        
            if (!(test-path $setting.path)) {new-item $setting.path -force | out-null}
            New-ItemProperty $setting.path -Name $setting.name -PropertyType $setting.type -Value $setting.value -force | out-null
        }

        write-host ' Animate controls and elements inside windows ' -n; write-host 0 -f y
        write-host ' Fade or slide menus into view ' -n; write-host 0 -f y
        write-host ' Fade or slide ToolTips into view ' -n; write-host 0 -f y
        write-host ' Fade out menu items after clicking ' -n; write-host 0 -f y
        write-host ' Show shadows under mouse pointer ' -n; write-host 0 -f y
        write-host ' Show shadows under windows ' -n; write-host 0 -f y
        write-host ' Slide open combo boxes ' -n; write-host 0 -f y

        write-host " UserPreferencesMask" -n; write-host " Binary" -f gray -n; write-host " 144,18,3,128,16,0,0,0" -f yellow
        New-ItemProperty 'HKCU:\Control Panel\Desktop\' -name 'UserPreferencesMask' -PropertyType binary -Value $([byte[]](144,18,3,128,16,0,0,0)) -Force -ea 0 | out-null

        write-host ""
    }
    function Step-AppX
    {
        write-host "APPX APPLICATIONS (Microsoft Store)`n" -f Yellow

        # wildcard search of things to keep
        $storeAppsToKeep = @(

            'store'
            'calculator'
            'sketch'
            'photos'
            'edge'
        )

        # converting the array to a regex search string
        $regex = [string]($storeAppsToKeep | % {".*$_*."}) -replace ' ','|'

        # find appx packages and remove
        Get-AppxPackage | ? {
            
            $_.name -notmatch $regex -and`
            !$_.nonremovable

        } | % {

            write-host " Removing AppX:" $_.name
            Remove-AppxPackage $_ -ea 0 | out-null
        }

        write-host ""
    }
    function Step-UserEnvironment
    {
        write-host "CLEANING UP DESKTOP, START MENU TILES AND PINNED PROGRAMS`n" -f Yellow

        write-host " Removing pinned programs"
        Remove-Item 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Taskband' -Recurse -Force -ea 0 | Out-Null

        write-host " Cleaning public desktop"
        Remove-Item 'C:\Users\Public\Desktop\*' -Force -ea 0 | out-null

        write-host " Creating layout file"
        ('
            <LayoutModificationTemplate Version="1" xmlns="http://schemas.microsoft.com/Start/2014/LayoutModification">
             <LayoutOptions StartTileGroupCellWidth="6" />
              <DefaultLayoutOverride>
               <StartLayoutCollection>
                <defaultlayout:StartLayout GroupCellWidth="6" xmlns:defaultlayout="http://schemas.microsoft.com/Start/2014/FullDefaultLayout"/>
               </StartLayoutCollection>
              </DefaultLayoutOverride>
            </LayoutModificationTemplate>

        ') | Out-File ($tempFile = "$env:temp\StartLayout.xml") -Force

        $regPath = 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer'

        if (!(Test-Path $regPath))
        {
            New-Item $regPath -Force | Out-Null
        }

        write-host " Writing to registry"
        New-ItemProperty -Path $regPath -Name 'StartLayoutFile' -Value $tempFile -PropertyType String -Force | Out-Null
        New-ItemProperty -Path $regPath -Name 'LockedStartLayout' -Value 1 -PropertyType Dword -Force | Out-Null

        write-host " Setting colors"
        $accentRoot = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent'
        
        $accentPalette = Get-ItemProperty $accentRoot -Name 'AccentPalette'
        $bin = 164,232,255,0,124,214,245,0,77,172,207,0,45,125,154,0,33,93,115,0,14,67,87,0,11,40,51,0,0,204,106,0
        0..31 | % { $accentPalette.AccentPalette[$_] = $bin[$_] }

        Set-ItemProperty $accentRoot -name 'AccentPalette' -Value $accentPalette.AccentPalette -ea 0 | out-null
        Set-ItemProperty $accentRoot -Name  'AccentColorMenu' -Value 0xff767676 -ea 0 | out-null
        Set-ItemProperty $accentRoot -Name  'StartColorMenu' -Value 0xff735d21 -ea 0 | out-null

        write-host " Restarting explorer"
        Stop-Process -Name 'explorer'
        do {Start-Sleep -Milliseconds 500} until ((Get-Process -Name 'explorer').PriorityClass -eq 'Normal')

        write-host " Cleaning up"
        Remove-ItemProperty -Path $regPath -Name 'StartLayoutFile' -Force | Out-Null
        Remove-ItemProperty -Path $regPath -Name 'LockedStartLayout' -Force | Out-Null
        Remove-Item $tempFile | Out-Null

        write-host ""
    }
    function Step-OneDrive
    {
        write-host "UNINSTALL ONEDRIVE`n" -f Yellow
        if ($onedrive = (Get-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\onedrive*))
        {
            $onedrive.uninstallstring | % {
            
                $path = ($_ -split "/")[0]
    
                write-host " $path /uninstall /silent"
                start-process $path -args '/uninstall /silent' -wait
            }
            
        }
        else
        {
            " No user installation found"
        }

        write-host " Cleaning leftover crap"
        
        write-host "  Files" -f gray
        remove-item "$env:appdata\Microsoft\Windows\Start Menu\Programs\onedrive*.*" -force -ea 0 | out-null
        remove-item "$env:localappdata\Microsoft\OneDrive" -Recurse -Force -ea 0 | out-null

        write-host "  Tasks" -f gray
        Unregister-ScheduledTask "*onedrive*" -Confirm:$false -ea 0 | out-null

        write-host ""
    }
    function Step-Consent
    {
        write-host "CONSENT SETTINGS`n" -f Yellow

        # Reg keys for different privacy settings
        $keys = @(
        
            "appDiagnostics"
            "appointments"
            "bluetoothSync"
            "broadFileSystemAccess"
            "cellularData"
            "chat"
            "contacts"
            "documentsLibrary"
            "email"
            "gazeInput"
            "location"
            "microphone"
            "phoneCall"
            "phoneCallHistory"
            "picturesLibrary"
            "radios"
            "userAccountInformation"
            "userDataTasks"
            "userNotificationListener"
            "videosLibrary"
            "webcam"
            "wifiData"
        )
        
        # things we want enabled for desktop apps
        $onlyDesktopApps = @(
        
            "microphone"
            "location"
        )
        
        $rootPath = "SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore"
        
        # enable location for system
        
        write-host " location" -n; write-host " (system)" -f gray -n; write-host " Allow" -f green
        
        New-Item "HKLM:\$rootPath\location" -Force | out-null
        New-ItemProperty "HKLM:\$rootPath\location" -Name 'Value' -Value 'Allow' -Force | out-null
        write-host ""
        
        # user settings
        
        foreach ($key in $keys)
        {
            if (!(test-path "HKCU:\$rootPath\$key"))
            {
                new-item "HKCU:\$rootPath\$key" -force | out-null
            }
            else
            {
                remove-item "HKCU:\$rootPath\$key\*" -Force | out-null
            }
        }
        
        (Get-Item "HKCU:\$rootPath\*" -Exclude $onlyDesktopApps) | % {
        
            write-host " $($_.pschildname)" -n; write-host " (user)" -f gray -n; write-host " Deny" -f yellow
            New-ItemProperty -Path $_.pspath -Name 'Value' -Value "Deny" -Force | out-null
        }
        
        (Get-Item "HKCU:\$rootPath\*" -Include $onlyDesktopApps) | % {
        
            write-host " $($_.pschildname)" -n; write-host " (user, desktop apps)" -f gray -n; write-host " Allow" -f green
            New-ItemProperty -Path $_.pspath -Name 'Value' -Value "Allow" -Force | out-null
            New-Item $_.pspath -Name 'NonPackaged' -Force | out-null
            New-ItemProperty "$($_.pspath)\NonPackaged" -Name 'Value' -Value 'Allow' -Force | out-null
        }

        write-host ""
    }
    function Step-Firewall
    {
        write-host "DISABLE FIREWALL PROFILES`n" -f Yellow

        Set-NetFirewallProfile -All -Enabled False

        Get-NetFirewallProfile | % {
        
            if (!($_.enabled))
            {
                write-host "" $_.name "profile is" -n; write-host " Disabled" -f yellow
            }
            else
            {
                write-host "" $_.name "profile is still" -n; write-host " Enabled" -f red
            }
        }

        write-host ""
    }
    function Step-Autoruns
    {
        write-host "REMOVING AUTORUNS AND SCHEDULED TASKS`n" -f yellow

        write-host " CurrentVersion\Run"
        Remove-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name "*" -ea 0 -Force | Out-Null
        Remove-ItemProperty 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name "*" -ea 0 -Force | Out-Null
        write-host " StartupApproved\Run"
        Remove-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run' -Name "*" -ea 0 -Force | Out-Null
        Remove-ItemProperty 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run' -Name "*" -ea 0 -Force | Out-Null

        write-host " Disable tasks in root"
        Get-ScheduledTask -TaskPath \ | Disable-ScheduledTask | out-null
        write-host " Xbox Game Save Task"
        Get-ScheduledTask -TaskName XblGameSaveTask | Disable-ScheduledTask | out-null

        write-host ""
    }
    function Step-Services
    {
        write-host "ADJUSTING SERVICES`n" -f yellow
        
        $services = @(
            
            "wuauserv,manual"    
            "wsearch,disabled"
            "diagtrack,disabled"

        ) | ConvertFrom-Csv -Delimiter ',' -Header NAME,STARTUPTYPE

        foreach ($service in $services)
        {
            foreach ($svc in (get-service $service.name))
            {
                write-host ""$svc.displayname -n; write-host ""$service.startuptype -f gray
                Set-Service -Name $svc.servicename -StartupType $service.startuptype -ea 0 | out-null
                Stop-Service $svc.servicename -ea 0 | out-null
            }
        }

        write-host ""
    }
    function Step-PowerPlan
    {
        write-host "POWERPLAN SELECTION" -f yellow

        function Get-PowerPlan
        {
            (powercfg /list | select -skip 3) -replace '^.*.: | \(|\)','' |  % {
                
                [PSCustomObject]@{
                
                    NAME = $_.Substring(37).Replace(' *','')
                    GUID = $_.Substring(0,36)
                    ACTIVE = if ($_ -match '.*\*$') {$true} else {$false}
                }
            }
        }
        
        if (!(Get-PowerPlan | ? {$_.name -match '^ultimate.*'}))
        {
            start-process powercfg -args '/DUPLICATESCHEME e9a42b02-d5df-448d-aa00-03f14749eb61' -windowstyle minimized -wait
        }
        
        start-process powercfg -args "/s $((Get-PowerPlan | ? {$_.name -match '^high.*'}).guid)" -windowstyle minimized -wait
        start-process powercfg -args "/s $((Get-PowerPlan | ? {$_.name -match '^ultimate.*'}).guid)" -windowstyle minimized -wait

        write-host "`n Powerplan: " -n; write-host $(Get-PowerPlan | ? {$_.active}).name -f yellow; ""
    }
    function Step-InstallApps
    {
        write-host "OPTIONAL PROGRAMS" -f yellow

        write-host "`n Install optional programs? (y/n): " -n
        if (($Host.UI.RawUI.ReadKey().character) -eq 'y')
        {        
            write-host ""
        
            @(
                "7zip"
                "notepadplusplus"
                "vlc"
                "discord"
                "spotify"
                "brave"

                "vscode"
                "powershell-core"
                "sysinternals"
                "powertoys"
                "latencymon"
                "cpu-z"
                "gpu-z"
                "ddu"
        
            ) | % {
        
                write-host " - $($_)? (y/n): " -n
        
                if (($Host.UI.RawUI.ReadKey().character) -eq 'y')
                {
                    $install += @($_)
                    write-host " added" -f darkgreen
                }
                else
                {
                    write-host " skipped" -f darkred
                }
            }
        
            if ($install)
            {
                if (!($env:ChocolateyInstall))
                {
                    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
                }
    
                @("chocolateygui")+$install | % {choco install $_ -y}
            }
        }
        
        write-host ""
    }
}
PROCESS
{
    Clear-Host
    
    Step-Registry
    Step-PerformanceOptions
    Step-AppX
    Step-UserEnvironment
    Step-OneDrive
    Step-Consent
    Step-Firewall
    Step-Autoruns
    Step-Services
    Step-PowerPlan
    Step-InstallApps
}
END
{
    write-host "`n`nFINISHED!" -f cyan
    Write-Host "`n Press any key to restart computer`n" -f gray -n
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | out-null

    Restart-Computer -Force
}
