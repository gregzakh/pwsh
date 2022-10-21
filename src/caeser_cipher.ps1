function Convert-CaeserCipher {
  <#
    .EXAMPLE
        ($res = Convert-CaeserCipher -Source (
          Read-Host 'Test string'
        ) -Key (Get-Random -Minimum 1 -Maximum 26))
        "$('-'*9) BRUTE $('-'*9)"
        (1..25).ForEach{
          Convert-CaeserCipher -Source $res -Key $_ -Decode
        }
  #>
  [CmdletBinding()]
  param(
    [Parameter(Mandatory, Position=0)]
    [ValidateNotNullOrEmpty()]
    [String]$Source,

    [Parameter()]
    [ValidateRange(1, 25)]
    [Int32]$Key = 1,

    [Parameter()]
    [Switch]$Decode
  )

  end {
    [Char[][]]$arr = ('a'..'z'+'A'..'Z'),$Source
    $mov = $Decode ? ($Key * -1) : $Key
    [String]::Join('', $arr[1].ForEach{
      $_ -in $arr[0] ? $(
        [Char]::"To$([Char]::IsUpper($_) ? 'Upp' : 'Low')er"(
          $arr[0][($arr[0].IndexOf($_) + $mov) % $arr[0].Length]
        )
      ) : $_
    })
  }
}
