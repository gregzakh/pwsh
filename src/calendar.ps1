if ($IsWindows) {
  Set-Alias -Name cal -Value Get-Calendar
}

function Get-Calendar {
  <#
    .SYNOPSIS
        Displays a simple calendar in traditional format.
    .DESCRIPTION
        By default (if the function is called without parameters), the calendar for the
        current month is displayed. If the year is specified but the month is not, then
        the function uses the current month number like a substitute.
        Pay close attention that "Month" and "Full" parameters are  mutually exclusive.
        This means you cannot use them at the same time.
    .PARAMETER Month
        Set a month number. The current month number is set by default.
    .PARAMETER Year
        Set a year number. The current year number is set by default.
    .PARAMETER Invert
        Indicates that the week starts on Monday.
    .PARAMETER Vertical
        Indicates that an alternative layout should be used.
    .PARAMETER Full
        Indicates that a calendar for entire year shoul be printed.
    .INPUTS
        System.Int32 - Month
        System.Int32 - Year
        System.Management.Automation.SwitchParameter - all other parameters
    .OUTPUTS
        System.Array
    .EXAMPLE
        PS C:\> Get-Calendar
        This prints the current month calendar.
    .EXAMPLE
        PS C:\> Get-Calendar -Month 10 -Invert
                2022
               October
        Mo Tu We Th Fr Sa Su
                        1  2
         3  4  5  6  7  8  9
        10 11 12 13 14 15 16
        17 18 19 20 21 22 23
        24 25 26 27 28 29 30
        31
    .EXAMPLE
        PS C:\> Get-Calendar -Vertical -Year 2023
                2023
             September
        Su     3 10 17 24
        Mo     4 11 18 25
        Tu     5 12 19 26
        We     6 13 20 27
        Th     7 14 21 28
        Fr  1  8 15 22 29
        Sa  2  9 16 23 30
    .EXAMPLE
        PS C:\> Get-Calendar -Full -Year 2023 -Invert
                                       2023
               January                February                  March
        Mo Tu We Th Fr Sa Su    Mo Tu We Th Fr Sa Su    Mo Tu We Th Fr Sa Su
                           1           1  2  3  4  5           1  2  3  4  5
         2  3  4  5  6  7  8     6  7  8  9 10 11 12     6  7  8  9 10 11 12
         9 10 11 12 13 14 15    13 14 15 16 17 18 19    13 14 15 16 17 18 19
        16 17 18 19 20 21 22    20 21 22 23 24 25 26    20 21 22 23 24 25 26
        23 24 25 26 27 28 29    27 28                   27 28 29 30 31
        30 31

                April                    May                    June
        Mo Tu We Th Fr Sa Su    Mo Tu We Th Fr Sa Su    Mo Tu We Th Fr Sa Su
                        1  2     1  2  3  4  5  6  7              1  2  3  4
         3  4  5  6  7  8  9     8  9 10 11 12 13 14     5  6  7  8  9 10 11
        10 11 12 13 14 15 16    15 16 17 18 19 20 21    12 13 14 15 16 17 18
        17 18 19 20 21 22 23    22 23 24 25 26 27 28    19 20 21 22 23 24 25
        24 25 26 27 28 29 30    29 30 31                26 27 28 29 30


                July                    August                September
        Mo Tu We Th Fr Sa Su    Mo Tu We Th Fr Sa Su    Mo Tu We Th Fr Sa Su
                        1  2        1  2  3  4  5  6                 1  2  3
         3  4  5  6  7  8  9     7  8  9 10 11 12 13     4  5  6  7  8  9 10
        10 11 12 13 14 15 16    14 15 16 17 18 19 20    11 12 13 14 15 16 17
        17 18 19 20 21 22 23    21 22 23 24 25 26 27    18 19 20 21 22 23 24
        24 25 26 27 28 29 30    28 29 30 31             25 26 27 28 29 30
        31

               October                November                December
        Mo Tu We Th Fr Sa Su    Mo Tu We Th Fr Sa Su    Mo Tu We Th Fr Sa Su
                           1           1  2  3  4  5                 1  2  3
         2  3  4  5  6  7  8     6  7  8  9 10 11 12     4  5  6  7  8  9 10
         9 10 11 12 13 14 15    13 14 15 16 17 18 19    11 12 13 14 15 16 17
        16 17 18 19 20 21 22    20 21 22 23 24 25 26    18 19 20 21 22 23 24
        23 24 25 26 27 28 29    27 28 29 30             25 26 27 28 29 30 31
        30 31
    .EXAMPLE
        PS C:\> Get-Calendar -Full -Year 2023 -Invert -Vertical
                                       2023
              January                 February                 March
        Mo     2  9 16 23 30    Mo     6 13 20 27       Mo     6 13 20 27
        Tu     3 10 17 24 31    Tu     7 14 21 28       Tu     7 14 21 28
        We     4 11 18 25       We  1  8 15 22          We  1  8 15 22 29
        Th     5 12 19 26       Th  2  9 16 23          Th  2  9 16 23 30
        Fr     6 13 20 27       Fr  3 10 17 24          Fr  3 10 17 24 31
        Sa     7 14 21 28       Sa  4 11 18 25          Sa  4 11 18 25
        Su  1  8 15 22 29       Su  5 12 19 26          Su  5 12 19 26

               April                    May                     June
        Mo     3 10 17 24       Mo  1  8 15 22 29       Mo     5 12 19 26
        Tu     4 11 18 25       Tu  2  9 16 23 30       Tu     6 13 20 27
        We     5 12 19 26       We  3 10 17 24 31       We     7 14 21 28
        Th     6 13 20 27       Th  4 11 18 25          Th  1  8 15 22 29
        Fr     7 14 21 28       Fr  5 12 19 26          Fr  2  9 16 23 30
        Sa  1  8 15 22 29       Sa  6 13 20 27          Sa  3 10 17 24
        Su  2  9 16 23 30       Su  7 14 21 28          Su  4 11 18 25

                July                  August                 September
        Mo     3 10 17 24 31    Mo     7 14 21 28       Mo     4 11 18 25
        Tu     4 11 18 25       Tu  1  8 15 22 29       Tu     5 12 19 26
        We     5 12 19 26       We  2  9 16 23 30       We     6 13 20 27
        Th     6 13 20 27       Th  3 10 17 24 31       Th     7 14 21 28
        Fr     7 14 21 28       Fr  4 11 18 25          Fr  1  8 15 22 29
        Sa  1  8 15 22 29       Sa  5 12 19 26          Sa  2  9 16 23 30
        Su  2  9 16 23 30       Su  6 13 20 27          Su  3 10 17 24

              October                 November                December
        Mo     2  9 16 23 30    Mo     6 13 20 27       Mo     4 11 18 25
        Tu     3 10 17 24 31    Tu     7 14 21 28       Tu     5 12 19 26
        We     4 11 18 25       We  1  8 15 22 29       We     6 13 20 27
        Th     5 12 19 26       Th  2  9 16 23 30       Th     7 14 21 28
        Fr     6 13 20 27       Fr  3 10 17 24          Fr  1  8 15 22 29
        Sa     7 14 21 28       Sa  4 11 18 25          Sa  2  9 16 23 30
        Su  1  8 15 22 29       Su  5 12 19 26          Su  3 10 17 24 31
  #>
  [CmdletBinding()]
  param(
    [Parameter(DontShow)]
    [ValidateNotNullOrEmpty()]
    [DateTime]$Dummy = (Get-Date),

    [Parameter()]
    [ValidateRange(1, 12)]
    [Alias('m')]
    [Int32]$Month = $Dummy.Month,

    [Parameter()]
    [ValidateRange(1970, 3000)]
    [Alias('y')]
    [Int32]$Year = $Dummy.Year,

    [Parameter()][Alias('i')][Switch]$Invert,
    [Parameter()][Alias('v')][Switch]$Vertical,
    [Parameter()][Alias('f')][Switch]$Full
  )

  begin {
    $dfi, $par = (Get-Culture en-US).DateTimeFormat, $PSBoundParameters
    $arr, $cal = ($dfi.AbbreviatedDayNames -replace '.$'), $dfi.Calendar

    $dow, $cap = [Int32]($cal.GetDayOfWeek("$Month.1.$Year")), $dfi.MonthNames[$Month - 1]
    if ($Invert) {
      $arr = $arr[1..$arr.Length] + $arr[0]
      if (($dow = --$dow) -lt 0) { $dow += 7 }
    }
    if ($dow) { (0..($dow - 1)).ForEach{ $arr += "$([Char]32)" * 2 } }
    $arr += (1..$cal.GetDaysInMonth($Year, $Month)).ForEach{ "$_".PadLeft(2, [Char]32) }

    if ($Month -eq $Dummy.Month -and $Year -eq $Dummy.Year) {
      $arr[$arr.IndexOf($Dummy.Day)] = "`e[39;7m$($Dummy.Day)`e[0m"
    }
  }
  process {}
  end {
    if ($Full -and $par.ContainsKey('Month')) {
      Write-Warning 'Mutually exclusive options'
      return
    }

    if ($Full) {
      $params = @{
        Month    = 1
        Year     = $par.Year ?? $Dummy.Year
        Invert   = $par.Invert
        Vertical = $par.Vertical
        Full     = $false
      }

      "$($params.Year)".PadLeft(35, [Char]32)
      for ($i = 0; $i -lt 4; $i++) {
        $line = @()
        for ($j = 0; $j -lt 3; $j++) {
          $line += , (Get-Calendar @params)
          ++$params.Month
        }

        for ($j = 0; $j -lt 9; $j++) {
          ($line[0][$j], $line[1][$j], $line[2][$j]).ForEach{
            ($_ ?? '').PadRight(20, [Char]32)
          } -join "`t"
        }
      }
      return
    }

    if (!$par.ContainsKey('Full')) { "$Year".PadLeft(12, [Char]32) }
    "$([Char]32)" * [Math]::Round((((21, 19)[$Vertical -and 1]) - $cap.Length) / 2) + $cap
    $Vertical ? $(
      $i = 0
      $seq = (,7 * 6).ForEach{$_ * (++$i)}
      for ($i = 0; $i -lt 7; $i++) {
        $arr[,$i + $seq] -join [Char]32
        $seq = $seq.ForEach{$_ + 1}
      }
    ) : $(
      for ($i = 0; $i -lt $arr.Length; $i += 6) {
        $arr[$i..($i + 6)] -join [Char]32
        $i++
      }
    )
  }
}
