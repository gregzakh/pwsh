#requires -version 7
using namespace System.Runtime.InteropServices

$buf = [Int32[]]::new(2)
[Marshal]::Copy(0x7FFE026C, $buf, 0, $buf.Length)
if (($buf[0]*10+$buf[1]) -lt 100) {
  Write-Warning 'Windows 10 or higher required'
  return
}

"OS boot failed $([BitConverter]::ToUInt32(
  [BitConverter]::GetBytes([Marshal]::ReadInt32([IntPtr]0x7FFE02C4)
), 0) - (
  (Get-ItemProperty ('HKLM:\SYSTEM\CurrentControlSet\Control'+
  '\Session Manager\Memory Management\PrefetchParameters')).BootId
)) times."
