Command `g` makes it easier to `cd` into different folders. Create one custom mapping file and use in all your favorite shells.

## Usage

```
g [alias]
```

For example, with the default `.grc` you can run `g home` to navigate to `%USERPROFILE%`, which is your home directory in Windows.

## Shell supported
-   Command Prompt
-   PowerShell Core
-   Bash on wsl2

## Configuration
The default mapping configuration is `%USERPROFILE%/.grc`. It should be a plain text file with your custom mappings. Every mapping record should be in its own line with format like
```
alias   path
```

-   alias\
    `alias` should be unique, and there should be no whitespace in its value.
-   path\
    `path` should be the path to the folder. Put environment variables between `%` s, for example: `%USERPROFILE%/Desktop`. \
    Use `\` in your path if you want to work with Windows shells, it will be translated to `/` on the fly in Linux shells.

### Example
```
desk    %USERPROFILE%\Desktop
github  %USERPROFILE%\repositories\github
home    %USERPROFILE%
```


## Installation

1.  Copy the `.grc` file to `%USERPROFILE%`
2.  Install for Command Prompt
    -   Ensure you have `cat.exe`, `grep.exe` and `awk.exe` avaliable in your `PATH`. Try cygwin or git for windows if you don't have them.
    -   Copy `cmd/g.cmd` to a local folder
    -   Add the path to the folder above to your `PATH` environment variable.
3.  Install for Powershell Core
    -   Copy `pscore/g.ps1` to a local folder
    -   Add the path to the folder above to your `PATH` environment variable.
4.  Install for WSL Bash
    -   Set environment variable `WSLENV` according to [share-environment-vars-between-wsl-and-windows](https://devblogs.microsoft.com/commandline/share-environment-vars-between-wsl-and-windows/)
    -   Expose `%USERPROFILE%` and all other environment variables you have used in your `.grc` in `WSLENV`
    -   Copy `wsl/g.sh` to a local folder.
    -   Create a bash alias in your `.bashrc`, link it to the folder above
        ```
        alias g='. path/to/g.sh'
        ```