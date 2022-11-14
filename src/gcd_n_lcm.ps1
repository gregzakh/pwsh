# greatest common divisor
# recursive (compatibility with old versions)
# function gcd($x, $y) {[Math]::Abs((.({gcd $y ($x % $y)}, {$x})[!$y]))}
function gcd($x, $y) {[Math]::Abs($y ? (gcd $y ($x % $y)) : $x)}
# iterative
# function gcd($x, $y) {while($y){$x, $y = $y, ($x % $y)};[Math]::Abs($x)}
# least common multiple
function lcm($x, $y) {[Math]::Abs($x * $y / (gcd $x $y))}
