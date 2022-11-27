function Test-Pangram {
  <#
    .EXAMPLE
        PS> 'The quick brown fox jumps over the lazy dog' | Test-Pangram
  #>
  param(
    [Parameter(Mandatory, ValueFromPipeline)]
    [ValidateNotNullOrEmpty()]
    [String[]]$Sentence
  )

  end {
    $abc = 'a'..'z'
    $Sentence.ForEach{
      !(Compare-Object -ReferenceObject (
        [Char[]]($_.ToLower() -replace '[^\p{L}]*', ''
      ) | Group-Object).Name -DifferenceObject $abc)
    }
  }
}
