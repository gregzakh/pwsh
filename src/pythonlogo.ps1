Add-Type -AssemblyName PresentationFramework

$xaml = [Windows.Markup.XamlReader]::Load(($xml = [Xml.XmlNodeReader]::new(
[xml]@'
  <Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
          xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
          Title="Python" SizeToContent="WidthAndHeight"
          ResizeMode="NoResize" WindowStartupLocation="CenterScreen">
     <Grid Height="110" Width="100">
        <Canvas>
           <Path Fill="DarkBlue"
                 Data="M27,16c0-7,9-13,24-13c15,0,23,6,23,13l0,22c0,7-5,12-11,
                       12l-24,0c-8,0-14,6-14,15l0,10l-9,0c-8,0-13-9-13-24c0-14,
                       5-23,13-23l35,0l0-3l-24,0l0-9l0,0z M88,50v1" />
           <Path Fill="Yellow"
                 Data="M74,87c0,7-8,13-23,13c-15,0-24-6-24-13l0-22c0-7,6-12,
                       12-12l24,0c8,0,14-7,14-15l0-10l9,0c7,0,13,9,13,23c0,15-6,
                       24-13,24l-35,0l0,3l23,0l0,9l0,0z M140,50v1" />
           <Ellipse Fill="#FFF" Canvas.Top="12" Canvas.Left="32" Height="8" Width="8" />
           <Ellipse Fill="#FFF" Canvas.Top="83" Canvas.Left="59" Height="8" Width="8" />
        </Canvas>
     </Grid>
  </Window>
'@)))

[void]$xaml.ShowDialog()
$xaml.Close()
$xml.Dispose()
