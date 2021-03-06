#requires -version 2
<#
.SYNOPSIS
  Windows build script for mixlab
.PARAMETER Release
    Builds in release mode
.EXAMPLE
  Build-Frontend -Release
#>

Param(
  [Parameter(
  HelpMessage="Build in release mode")]
  [switch]
  $Release
)

Set-Location -Path (Join-Path -Path (Get-Location) -ChildPath "frontend")

if ($Release) {
  $BuildMode = "--release"
} else {
  $BuildMode = "--dev"
}

$env:RUSTFLAGS = "--remap-path-prefix src=frontend/src"

if ($null -eq (Get-Command "wasm-pack.exe" -ErrorAction SilentlyContinue)) 
{ 
   Write-Host "wasm-pack is not installed... please install it from https://rustwasm.github.io/wasm-pack/installer/"
}

wasm-pack.exe build "$BuildMode" --target no-modules