const { hot } = require("react-hot-loader/root")

// prefer default export if available
const preferDefault = m => (m && m.default) || m


exports.components = {
  "component---pages-get-computer-tracking-info-mdx": hot(preferDefault(require("C:\\Users\\daute\\source\\repos\\AdminTools\\docs\\pages\\Get-ComputerTrackingInfo.mdx"))),
  "component---pages-get-computer-uptime-mdx": hot(preferDefault(require("C:\\Users\\daute\\source\\repos\\AdminTools\\docs\\pages\\Get-ComputerUptime.mdx"))),
  "component---pages-get-directory-last-write-time-mdx": hot(preferDefault(require("C:\\Users\\daute\\source\\repos\\AdminTools\\docs\\pages\\Get-DirectoryLastWriteTime.mdx"))),
  "component---pages-get-installed-software-runspace-mdx": hot(preferDefault(require("C:\\Users\\daute\\source\\repos\\AdminTools\\docs\\pages\\Get-InstalledSoftwareRunspace.mdx"))),
  "component---pages-get-mac-address-mdx": hot(preferDefault(require("C:\\Users\\daute\\source\\repos\\AdminTools\\docs\\pages\\Get-MacAddress.mdx"))),
  "component---pages-get-path-stats-mdx": hot(preferDefault(require("C:\\Users\\daute\\source\\repos\\AdminTools\\docs\\pages\\Get-PathStats.mdx"))),
  "component---pages-get-user-sessions-mdx": hot(preferDefault(require("C:\\Users\\daute\\source\\repos\\AdminTools\\docs\\pages\\Get-UserSessions.mdx"))),
  "component---pages-home-mdx": hot(preferDefault(require("C:\\Users\\daute\\source\\repos\\AdminTools\\docs\\pages\\home.mdx"))),
  "component---pages-invoke-ping-sweep-mdx": hot(preferDefault(require("C:\\Users\\daute\\source\\repos\\AdminTools\\docs\\pages\\Invoke-PingSweep.mdx"))),
  "component---pages-start-sccm-actions-mdx": hot(preferDefault(require("C:\\Users\\daute\\source\\repos\\AdminTools\\docs\\pages\\Start-SCCMActions.mdx"))),
  "component---pages-test-connection-runspace-mdx": hot(preferDefault(require("C:\\Users\\daute\\source\\repos\\AdminTools\\docs\\pages\\Test-ConnectionRunspace.mdx"))),
  "component---pages-test-server-reboot-mdx": hot(preferDefault(require("C:\\Users\\daute\\source\\repos\\AdminTools\\docs\\pages\\Test-ServerReboot.mdx"))),
  "component---src-pages-404-js": hot(preferDefault(require("C:\\Users\\daute\\source\\repos\\AdminTools\\docs\\.docz\\src\\pages\\404.js")))
}

