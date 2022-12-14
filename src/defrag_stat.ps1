if (!($devices = Get-ItemProperty HKLM:\SYSTEM\MountedDevices -ErrorAction 0)) {
  Write-Warning 'Mounted devices have not been found.'
  return
}

$points = @{} # volume -> drive letter
$devices.PSObject.Properties.Where{$_.Name -match 'dos'}.ForEach{
  if ([Text.Encoding]::UTF8.GetString($_.Value[0..7]) -eq 'dmio:id:') {
    $points["Volume{$([Guid]::new([Byte[]]$_.Value[8..$_.Value.Length]))}"] = $_.Name[-2]
  }
}

if (!(Test-Path ($stat = 'HKLM:\SOFTWARE\Microsoft\Dfrg\Statistics'))) {
  Write-Warning 'Statistics have not been found.'
  return
}

$to_time = {
  param([Parameter(Mandatory)][Byte[]]$bytes)
  end {
    $date = ($bytes | Group-Object {[Math]::Floor($script:i++ / 2)}).ForEach{
      [BitConverter]::ToUInt16($_.Group, 0)
    }
    [DateTime]::new($date[0], $date[1], $date[3], $date[4], $date[5], $date[6])
  }
}

($points.GetEnumerator() | Sort-Object Value).ForEach{
  if (($log = Get-ItemProperty "$stat\$($_.Name)" -ErrorAction 0)) {
    "Disk: `e[33;1m{0}`e[0m`n`tPoint: {1}" -f $_.Value, $_.Name
    "`t`e[35;1mStatus`e[0m"
    "`t`t Last scan time             : {0}" -f (& $to_time $log.LastRunTime)
    "`t`t Last defrag time           : {0}" -f (& $to_time $log.LastRunFullDefragTime)
    "`t`t Average fragments per file : {0:F2}" -f ($log.AvgFragmentsPerFile / 100)
    "`t`t Movable files and folders  : {0}" -f $log.MovableFiles
    "`t`e[35;1mFiles`e[0m"
    "`t`t Fragmented files           : {0}" -f $log.FragmentedFiles
    "`t`t Total fragmented files     : {0}" -f $log.FragmentedExtents
    "`t`e[35;1mDirectories`e[0m"
    "`t`t Total folders              : {0}" -f $log.DirectoryCount
    "`t`t Fragmented folders         : {0}" -f $log.FragmentedDirectories
    "`t`t Total fragmented folders   : {0}" -f $log.FragmentedDirectoryExtents
    "`t`e[35;1mMFT`e[0m"
    "`t`t MFT size                   : {0:F2} Mb" -f ($log.MFTSize / 1Mb)
    "`t`t MFT records                : {0}" -f $log.InUseMFTRecords
    "`t`t MFT usage                  : {0}%" -f ($log.TotalMFTRecords * 100 / $log.InUseMFTRecords)
    "`t`t MFT fragments              : {0}" -f $log.MFTFragmentCount
  }
}
