# AdminTools

Hey, thanks for stopping by, this is my collection of System Administration PowerShell scripts to make my life easier.
The project can be found on [GitHub](https://github.com/baileydauterman/AdminTools).
I am a newbie at creating PowerShell Modules, so my current suggestion for running this is loading the commands to memory at PowerShell startup:

```powershell
Add-Content -Path $profile -Value 'Import-Module ".\AdminTools.psm1"'
```

## About
I am happy to take suggestions for any PS functions that would be useful to a majority of system administartors. You can either send me a message, my information is [here](https://baileydauterman.github.io/) or submit a pull request to the project and I can merge the functions after testing is completed.