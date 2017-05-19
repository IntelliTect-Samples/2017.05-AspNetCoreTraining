[CmdletBinding()]
param(
    [switch]$clean,
    [string]$solutionName = 'DotNetCliStuff',
    [string]$projectName = 'SampleWebApplication',
    [string]$rootDirectory = $pwd,
    [switch]$startDebug
)

Function Stop-DemoDebugging {
    Get-PSBreakpoint -Script (__FILE__) | Remove-PSBreakpoint
    return
}

Function Start-DemoDebugging {
    Stop-DemoDebugging
    Set-PSBreakpoint -Script (__FILE__) -Line (Get-DemoStartLine);
    return
}

Function Undo-Demo {
    Remove-Item "$rootDirectory\$solutionName" -Recurse -Force -ErrorAction ignore
    Remove-Item $rootDirectory\$projectName -Recurse -Force -ErrorAction ignore
}


Function Show-DotNetCliInformation {
    dotnet.exe
    Get-Command dotnet | % Source
    dotnet --version
    get-childitem "$env:ProgramFiles\dotnet\sdk"
}

Function Get-DemoStartLine { return ((__LINE__) + 2)}
Function Start-Demo {
    Show-DotNetCliInformation
    Function New-DotNetSolutionDirectory ($solutionName) {
        $solutionDirectory = (Join-Path $rootDirectory $solutionName)
        Write-Debug $solutionDirectory
        New-Item -ItemType Directory $solutionDirectory >> $null
        Set-Location $solutionDirectory
        return $solutionDirectory
    }
    
    try {
        $originalDirectory = $pwd; Set-Location (New-DotNetSolutionDirectory $solutionName) 
        dotnet new sln;                             
        # Test-Path (Get-Item "$(Split-Path (Get-Location) -Leaf).sln")  
        Get-Item "$solutionName.sln"
        dotnet new mvc -n "$projectName";              
        # Test-Path (Get-Item "$projectName") 
        Get-ChildItem $projectName
    }
    finally {
        Set-Location $originalDirectory
    }

    #Remove-Item "$pwd\$(Split-Path (Get-Location) -Leaf).sln" -ErrorAction ignore
    
}

Function Get-ScriptLineNumber { return (Get-PSCallStack)[1].ScriptLineNumber }
Set-Alias -Name __LINE__ -value Get-ScriptLineNumber >> $null
Function Get-ScriptName { return (Get-PSCallStack)[1].ScriptName }
Set-Alias -Name __FILE__ -value Get-ScriptName >> $null 

if (-not $PSBoundParameters.ContainsKey('startDebug')) {
#    (Split-Path (__FILE__) -Leaf)
#    (Get-PSBreakpoint -Script (Split-Path __FILE__ -Leaf))
    $startDebug = -not (Get-PSBreakpoint -Script (Split-Path (__FILE__) -Leaf))
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