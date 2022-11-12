function Test-Palindrome {
  <#
    .EXAMPLE
        PS> Test-Palindrome 123454321, "Madam, I'm Adam!", {}
    .EXAMPLE
        PS> [Object] | Test-Palindrome
  #>
  [OutputType([Boolean])]
  [CmdletBinding()]
  param(
    [Parameter(Mandatory, ValueFromPipeline)]
    [ValidateNotNullOrEmpty()]
    [Object[]]$InputObject
  )

  end {
    $InputObject.ForEach{
      ($$ = $_.ToString()).Length -gt 1 `
        ? -join[Linq.Enumerable]::Reverse((
          $$ = $$ -replace '[^\p{L}\p{N}]'
        )) -eq $$ : $false
    }
  }
}
