function Convert-Rot13 {
  <#
    .EXAMPLE
        PS C:\> Convert-Rot13 'One vision, one purpose!', 'Bar ivfvba, bar checbfr!'
    .EXAMPLE
        PS C:\> 'One vision, one purpose!', 'Bar ivfvba, bar checbfr!' | Convert-Rot13
  #>
  [CmdletBinding()]
  param(
    [Parameter(Mandatory, ValueFromPipeline)]
    [ValidateNotNullOrEmpty()]
    [String[]]$Source
  )

  begin {
    $map = [Char[]](0,64,78,90,65,77,91,96,110,122,97,109,123,255 |
      Group-Object {[Math]::Floor($script:i++ / 2)}
    ).ForEach{$_.Group[0]..$_.Group[1]}
  }
  process { $Source.ForEach{ -join$map[[Char[]]$_] } }
  # end {}
}
