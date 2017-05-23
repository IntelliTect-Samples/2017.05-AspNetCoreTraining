return

# Mock Sample for the Install:

invoke-webrequest -Uri 'https://marketplace.visualstudio.com/items?itemName=ms-madsk.RazorLanguageServices'  -outfile Microsoft.VisualStudio.RazorExtension.vsix

set-alias VSIXInstaller "${env:ProgramFiles(x86)}\Microsoft Visual Studio 14.0\Common7\IDE\VSIXInstaller.exe"

& Microsoft.VisualStudio.RazorExtension.vsix