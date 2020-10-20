
# index files 

[int] $n = 0
[array] $FILE = Get-ChildItem -Path $PWD\*.MSI -Recurse -File 
[int] $List = ($FILE).Length

While ($n -lt $List)
    {
        Write-Host ($n+1): $FILE[$n]
        $n++
    }

[string] $arg = Read-Host -Prompt "Hello, please select the packages you'd like to install"
[array] $SELECT = $arg.Split(" ")
[array] $install = @()

$x = 0 
Clear-Host
Write-Host "Selected packages: "
foreach ($item in $SELECT) 
{
    [int] $pkg = $SELECT[$x]
    $x++
   
    if ($pkg -le $List) 
     {
        Write-Host $FILE[$pkg-1]
        $install += $FILE[$pkg-1]
     }
    else 
     {
        Write-Host @("Invalid selection, $pkg isn't a valid choice")    
     }
}

Function msiInstall($install)
{
    Write-Host "Installing files: "
    $z = 0 
    [int] $length = ($install).Length
    While ($z -le $length) 
    {
        $msipkg = $install[$z]
        Write-Host $msipkg
        Start-Process msiexec.exe -Wait -ArgumentList @('/I $msipkg /passive')
        $z++
        
    }
    [string] $installed = Read-Host -Prompt "Installed, press [ENTER] to continue..."
# Start-Process programname.exe -Wait -ArgumentList '/I /quiet' 
#if exe 
}

[string] $yn = Read-Host -Prompt "Are you sure you want to install these files? (Y/N)"

if ($yn -eq "Y")
    {
        msiInstall($install)
    }
    else 
    {
        [string] $end = Read-Host -Prompt "Exiting script, press [ENTER] to continue..."
        Clear-Host
    }
