# registry hives list
if ($IsWindows) {
  ($x = Get-Item HKLM:\SYSTEM\CurrentControlSet\Control\hivelist).Property.ForEach{
    ($_ -split '(\\.+)\\')[1] # becase first is an empty value
  } | Sort-Object -Unique
}
