function Get-DigitSum1([BigInt]$n) {
  end { [Linq.Enumerable]::Sum([Int32[]]($n -split '[^\d]*')) }
}

function Get-DigitSum2([BigInt]$n) {
  end {
    $r = [Int32]($n / [Math]::Pow(10, [Math]::Floor([Math]::Log10($n + 1))))
    for ($i = 0; $n -ge $r;) { $i, $n = ($i + $n % 10), ($n / 10) }; $i
  }
}
