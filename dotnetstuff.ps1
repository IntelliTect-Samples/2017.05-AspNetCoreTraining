[CmdletBinding()]
param(
    [switch]$clean,
    $solutionName = 'AspNetCoreStuff',
    $projectName = 'DotNetAspNetMvc',
    [switch]$startDebug =(-not (Get-PSBreakpoint -Script (Split-Path $MyInvocation.MyCommand.Path -Leaf)))
)

Function Stop-DemoDebugging {
    Get-PSBreakpoint -Script (__FILE__) | Remove-PSBreakpoint
    return
}

Function Start-DemoDebugging {
    Set-PSBreakpoint -Script (__FILE__) -Line (Get-DemoStartLine);
    return
}

Function Undo-Demo {
    Remove-Item "$PSScriptRoot\$solutionName.sln" -ErrorAction ignore
    Remove-Item $pwd\$projectName -Recurse -Force -ErrorAction ignore
}

Function Get-DemoStartLine { return ((__LINE__) + 2)}
Function Start-Demo {
    dotnet.exe
    Get-Command dotnet | % Source
    dotnet --version
    get-childitem "$env:ProgramFiles\dotnet\sdk"

    dotnet new sln --name $solutionName

    #Remove-Item "$pwd\$(Split-Path (Get-Location) -Leaf).sln" -ErrorAction ignore
    
    dotnet new mvc -n $projectName
    Get-ChildItem ".\$projectName"

    dotnet sln ".\$solutionName.sln" add ".\$projectName\$projectName.csproj"
}

Function Get-ScriptLineNumber { return (Get-PSCallStack)[1].ScriptLineNumber }
Set-Alias -Name __LINE__ -value Get-ScriptLineNumber >> $null
Function Get-ScriptName { return (Get-PSCallStack)[1].ScriptName }
Set-Alias -Name __FILE__ -value Get-ScriptName >> $null 

Function New-DotNetSolutionUsingDirectoryName {
    [CmdletBinding()]
    Param($projectDirectory)

    try {
        Set-Location "$PSScriptRoot\$projectDirectory"
        dotnet new sln
        Test-Path (Get-Item "$pwd\$(Split-Path (Get-Location) -Leaf).sln")
    }
    finally {
        Set-Location $PSScriptRoot
    }
}


if($clean)
{
    Undo-Demo
}
else {
    if($startDebug) {
        Start-DemoDebugging
    }
    else {
        Start-Demo
    }
}