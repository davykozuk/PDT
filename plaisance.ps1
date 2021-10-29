[xml]$xaml = @"
<Window 
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    x:Name="Window" Title="PlaisanceUsers" WindowStartupLocation = "CenterScreen" ResizeMode="NoResize"
    Width = "350" Height = "200" ShowInTaskbar = "True" Background = "lightgray"> 
    <Grid>
        <ListBox HorizontalAlignment="Left" Height="110.013" Margin="10,10,0,0" VerticalAlignment="Top" Width="103.398" Name="Listbox1">
            <ListBoxItem Content="Daudet" FontSize="16"/>
            <ListBoxItem Content="Riviere" FontSize="16"/>
            <ListBoxItem Content="Prevert" FontSize="16"/>
            <ListBoxItem Content="Pagnol" FontSize="16"/>
        </ListBox>
        <Button Content="USERS ADD" HorizontalAlignment="Left" Margin="137.579,10,0,0" VerticalAlignment="Top" Width="173.889" Height="110.013" FontSize="22" Name="BUsers"/>
    </Grid>
</Window>
"@
 
$reader=(New-Object System.Xml.XmlNodeReader $xaml)
$Window=[Windows.Markup.XamlReader]::Load( $reader )
 
#Connect to Controls

function FUsers()
{
$Ecole= $Listbox1.SelectedItems

if ($Ecole.content -eq "Daudet"){$School="dau"}
if ($Ecole.content -eq "Prevert"){$School="pre"}
if ($Ecole.content -eq "Riviere"){$School="riv"}
if ($Ecole.content -eq "Prevert"){$School="pre"}

New-LocalUser -Name "Eleve" -AccountNeverExpires -Password "eleve" -PasswordNeverExpires
New-LocalUser -Name "Enseignant" -AccountNeverExpires -Password "en"$School"830" -PasswordNeverExpires
New-LocalUser -Name "Animateur" -AccountNeverExpires -Password "an"$School"830" -PasswordNeverExpires
net user Administrateur "DNAcred12"




<#
if ($User -eq "Eleve"){$Password="eleve"}
if ($User -eq "Enseignant"){$Password="en"+"$School"+"830"}
if ($User -eq "Animateur"){$Password="an"+"$School"+"830"}
if ($User -eq "Administrateur"){$Password="DNAcred12"}
#>
}
 
#Events


[xml]$xml = $Xaml

$xml.SelectNodes("//*[@Name]") | ForEach-Object { Set-Variable -Name $_.Name -Value $Window.FindName($_.Name) }

$BUsers.Add_Click({FUsers $this $_})


[Void]$Window.ShowDialog()
 
