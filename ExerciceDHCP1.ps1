# ExerciceDHCP1.ps1
# Auteur : David Balny
# Ce script va permettre de créer une étendue (scope) DHCP sans boite de dialogue
# Vous devez vérifier la configuration saisie puis confirmer "Oui" ou annuler votre opération
  
########### Début du script ########### 

# Affectation des variables
Write-Host "Voici le nom du serveur DHCP : $env:computername"
$dhcpserver = $env:computername
$scopename = Read-Host "Entrer le nom de l'étendue DHCP (scope)"
$scopeID = Read-Host "Entrer l'adresse réseau de l'étendue DHCP"
$startrange = Read-Host "Entrer la première adresse à distribuer"
$endrange = Read-Host "Entrer la dernière adresse à distribuer"
$subnetmask = Read-Host "Entrer le masque sous-réseau"
$router = Read-Host "Entrer l'adresse de passerelle"

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

#Confirmation des informations saisies
$input = Read-Host "Entrer Oui pour continuer ou une autre commande pour annuler..."

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

