# ExerciceDHCP2.ps1
# Auteur : David Balny
# Ce script va permettre de créer une étendue (scope) DHCP
# Vous devez vérifier la configuration saisie puis confirmer "Oui" ou annuler votre opération
  
########### Début du script ########### 

# Chargement de la bibliothèque "VisualBasic"
[void][System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

# Création des boites de saisie en visualbasic => Input Box 
$dhcpserver = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer le nom du serveur DHCP", "Nom du serveur DHCP", "$env:computername")
$scopename = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer le nom de l'étendue DHCP (scope)", "Nom de l'étendue DHCP", "")
$scopeID = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer l'adresse réseau de l'étendue DHCP", "Etendue DHCP", "192.168.8.")
$startrange = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer la première adresse à distribuer", "Première adresse à distribuée", "192.168.8.")
$endrange = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer la dernière adresse à distribuer", "Dernière adresse à distribuer", "192.168.8.")
$subnetmask = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer le masque sous-réseau", "masque sous-réseau", "255.255.255.")
$router = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer l'adresse de passerelle", "Adresse de passerelle", "192.168.8.")

#Affichage des informations saisies
Write-Host
Write-Host ----------Configuartion saisie----------- -foregroundcolor "yellow"
Write-Host
Write-Host Nom du serveur: {}{}{}{}{}{}{}{} $dhcpserver -foregroundcolor "yellow"
Write-Host Nom de l étendue : {}{}{}{} $scopename -foregroundcolor "yellow"
Write-Host Adresse réseau de l étendue : {}{}{}{}{}{} $scopeID -foregroundcolor "yellow"
Write-Host Etendue DHCP : {}{}{}{}{}{} $startrange - $endrange -foregroundcolor "yellow"
Write-Host Masque sous-réseau : {}{}{}{} $subnetmask -foregroundcolor "yellow"
Write-Host Passerelle : {}{}{}{}{}{}{}{} $router -foregroundcolor "yellow"
Write-Host
Write-Host ---------/Congiguration saisie----------- -foregroundcolor "yellow"
Write-Host
Write-Host
Write-Host

#Confirmation des informations saisies
Write-Host Entrer Oui pour continuer ou une autre commande pour annuler...
Write-Host
$input = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer Oui pour continuer ou une autre commande pour annuler...", "Creation de l'étendue DHCP", "")

#Affichage des informations après validation
if(($input) -eq "Oui" )
{    
     Add-DHCPServerv4Scope -ComputerName $dhcpserver -EndRange $endrange -Name $scopename -StartRange $startrange -SubnetMask $subnetmask -State Active
     Set-DHCPServerv4OptionValue -ComputerName $dhcpserver -ScopeId $scopeID -Router $router
 
     Write-Host
     Write-Host
     Write-Host Création de l étendue $scopename  sur le serveur $dhcpserver -foregroundcolor "green"
     Write-Host
     Write-Host ---------------Enregistrement des informations-------------------- -foregroundcolor "green"
     Write-Host ------------------------------------------- -foregroundcolor "green"
     Write-Host
     Write-Host Nom de l étendue : {}{}{} $scopename -foregroundcolor "green"
     Write-Host Adresse réseau de l étendue : {}{}{}{}{} $scopeID -foregroundcolor "green"
     Write-Host Etendue DHCP : {}{}{}{}{} $startrange - $endrange -foregroundcolor "green"
     Write-Host Masque sous-réseau : {}{}{} $subnetmask -foregroundcolor "green"
     Write-Host Passerelle : {}{}{}{}{}{}{} $router -foregroundcolor "green"
     Write-Host
     Write-Host ------------------------------------------- -foregroundcolor "green"
     Write-Host --------------/Enregistrement des informations-------------------- -foregroundcolor "green"
}
else 
{
     exit
}

