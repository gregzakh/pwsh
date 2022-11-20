using namespace System.Security.Principal
using namespace System.Runtime.InteropServices

[Int32[]]$ver = [Int32[]]::new(2)
[Marshal]::Copy([IntPtr]0x7FFE026C, $ver, 0, $ver.Length)
if (($ver[0]*10+$ver[1]) -lt 100) {
  Write-Warning 'Windows 10 (or higher) is strongly required.'
  return
}

$key = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList'
$get = {param($high, $low)
  if ($high -and $low) {
    [DateTime]::FromFileTime([Int64]($high * 0x100000000) + $low)
  }
}
try {
  ($rk = Get-ChildItem $key).ForEach{
    [PSCustomObject]@{
      SID    = ($$ = Split-Path -Leaf $_.Name)
      User   = [SecurityIdentifier]::new($$).Translate([NTAccount])
      Path   = $_.GetValue('ProfileImagePath')
      Unload = &$get $_.GetValue('LocalProfileUnloadTimeHigh') $_.GetValue('LocalProfileUnloadTimeLow')
      Load   = &$get $_.GetValue('LocalProfileLoadTimeHigh') $_.GetValue('LocalProfileLoadTimeLow')
    }
    $_.Dispose()
  }
}
catch { Write-Warning $_ }
finally {
  if ($rk) { $rk.Dispose() }
}
