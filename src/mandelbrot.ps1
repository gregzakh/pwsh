using namespace System.Drawing
using namespace System.Numerics
using namespace System.Windows.Forms

Add-Type -AssemblyName System.Windows.Forms

($frmMain = [Form]@{
  BackgroundImage = ($bmp = [Bitmap]::new(320, 320))
  FormBorderStyle = [FormBorderStyle]::FixedSingle
  Icon = ($ico = [Icon]::ExtractAssociatedIcon("$PSHome\pwsh.exe"))
  MaximizeBox = $false
  Size = [Size]::new(316, 339)
  StartPosition = [FormStartPosition]::CenterScreen
  Text = 'Mandelbrot Set'
}).Add_FormClosing({
  ($bmp, $ico).ForEach{ if ($_) { $_.Dispose() } }
})
$frmMain.Add_Load({
  foreach ($r in 0..299) {
    foreach ($m in 0..299) {
      $i = 99
      $k = $c = [Complex]::new(($m / 75 - 2), ($r / 75 - 2))
      while (($k *= $k).Magnitude -lt 4 -and $i--) { $k += $c }
      $bmp.SetPixel($m, $r, [Color]::FromArgb(-5e6*++$i))
    }
  }
})
[void]$frmMain.ShowDialog()
