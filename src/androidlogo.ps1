Add-Type -AssemblyName PresentationFramework

$xaml = [Windows.Markup.XamlReader]::Load(($xml = [Xml.XmlNodeReader]::new(
[xml]@'
  <Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
          xmlns:x="https://schemas.microsoft.com/winfx/2006/xaml"
          Title="Android" SizeToContent="WidthAndHeight"
          ResizeMode="NoResize" WindowStartupLocation="CenterScreen">
     <Grid Height="105" Width="95">
        <Canvas>
           <Path Data="m 32 5l5 10M64 5l-6 10" Fill="#97c024"
                 Stroke="#97c024"
                 StrokeThickness="2"
                 StrokeStartLineCap="Round" />
           <Path Data="m 22 35h51v10h-51zM22 33c0-31 51-31 51 0"
                 Fill="#97c024"
                 Stroke="#97c024" />
           <Path Data="m 14 40v24M81 40v24M38 68v24M57 68v24M28 42v31h39v-31z"
                 Fill="#97c024"
                 Stroke="#97c024"
                 StrokeThickness="12.5"
                 StrokeStartLineCap="Round"
                 StrokeEndLineCap="Round" />
           <Ellipse Fill="#fff" Canvas.Top="18.7" Canvas.Left="33" Height="5" Width="4" />
           <Ellipse Fill="#fff" Canvas.Top="18.7" Canvas.Left="58" Height="5" Width="4" />
        </Canvas>
     </Grid>
  </Window>
'@)))

[void]$xaml.ShowDialog()
$xaml.Close()
$xml.Dispose()
