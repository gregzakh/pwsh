#requires -version 5
using namespace System.Runtime.InteropServices

&({ # sizeof(KUSER_SHARED_DATA->InterruptTime) = 0x0C
  $buf = [Byte[]]::new(0x0C)
  [Marshal]::Copy([IntPtr]0x7FFE0008, $buf, 0, $buf.Length)
  [TimeSpan]::FromTicks([BitConverter]::ToInt64($buf, 0))
},{Get-Uptime})[$PSVersionTable.PSVersion.Major -ge 6]
