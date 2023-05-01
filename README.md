# scripts
scripts i use which make my overall workflow go easy with terminal.

To ease out things wih admin privileges it is highly recommended to use [gsudo](https://github.com/gerardog/gsudo)

# zipExtractor.ps1
This PowerShell script extracts the contents of a specified zip file to a directory within the "C:\User Programs" directory. This way it makes it easy to find all executables in one place.

``` powershell
zipExtractor.ps1 [path to zip]
```

## Prerequisites
* powershell 5.0 or later
* admin privileges 

# addPath.ps1
This PowerShell script adds the current working directory to the system's PATH environment variable in Windows.
``` powershell
addPath.ps1
```
##prerequisites
*admin privileges
