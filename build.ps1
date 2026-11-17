param([string]$CompilerDirectory = "")
$ErrorActionPreference = "Stop"
if ($CompilerDirectory) {
    $resolvedCompilerDirectory = (Resolve-Path -LiteralPath $CompilerDirectory).Path
    $env:PATH = $resolvedCompilerDirectory + [IO.Path]::PathSeparator + $env:PATH
}
$compiler = (Get-Command g++ -CommandType Application -ErrorAction Stop).Source
$archiver = (Get-Command ar -CommandType Application -ErrorAction Stop).Source
Push-Location -LiteralPath $PSScriptRoot
try {
    & $compiler '-std=c++14' '-O2' '-Wall' '-Wextra' '-pedantic' '-c' 'complex.cpp' '-o' 'complex.o'
    if ($LASTEXITCODE -ne 0) { throw 'g++ failed' }
    & $archiver 'rcs' 'libcomplex.a' 'complex.o'
    if ($LASTEXITCODE -ne 0) { throw 'ar failed' }
    & $compiler '-std=c++14' '-O2' '-Wall' '-Wextra' '-pedantic' 'main.cpp' '-L.' '-lcomplex' '-o' 'lab05.exe'
    if ($LASTEXITCODE -ne 0) { throw 'g++ failed' }
    Write-Host 'Build completed: lab05.exe'
} finally {
    Pop-Location
}
