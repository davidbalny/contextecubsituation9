# ExerciceDHCP4.ps1
# Auteur : David Balny
# Ce script va permettre de créer plusieurs étendues (scope) DHCP avec paramètres DNS
# Vous devez vérifier la configuration saisie puis confirmer "Oui" ou annuler votre opération
  
########### Début du script ########### 

# Chargement de la bibliothèque "VisualBasic"
[void][System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

#Confirmation des informations saisies
Write-Host Désirez-vous créer une étendue DHCP ?
Write-Host
$input1 = [Microsoft.VisualBasic.Interaction]::InputBox("Combien désirez-vous créer d'étendues DHCP ?", "Nombre d'étendues à créer", "")

#Affichage des informations après validation
for($i=1; $i -le $input1; $i++)
{    
    # Création des boites de saisie en visualbasic => Input Box 
    $dhcpserver = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer le nom du serveur DHCP", "Nom du serveur DHCP", "$env:computername")
    $scopename = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer le nom de l'étendue DHCP (scope)", "Nom de l'étendue DHCP", "")
    $scopeID = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer l'adresse réseau de l'étendue DHCP", "Etendue DHCP", "130.")
    $startrange = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer la première adresse à distribuer", "Première adresse à distribuée", "130.")
    $endrange = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer la dernière adresse à distribuer", "Dernière adresse à distribuer", "130.")
    $subnetmask = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer le masque sous-réseau", "masque sous-réseau", "255.255.255.0")
    $router = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer l'adresse de passerelle", "Adresse de passerelle", "130.")
    $NomZoneDns = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer le nom du domaine", "Nom du domaine", "")
    $IPServeurDns = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer l'adresse du serveur DNS", "Adresse du serveur DNS", "")

    #Affichage des informations saisies
    Write-Host
    Write-Host ----------Configuartion saisie----------- -foregroundcolor "yellow"
    Write-Host
    Write-Host Nom du serveur: {}{}{}{}{}{}{}{}{}{}{}{}{}{}{} $dhcpserver -foregroundcolor "yellow"
    Write-Host Nom de l étendue : {}{}{}{}{}{}{}{}{}{}{}{} $scopename -foregroundcolor "yellow"
    Write-Host Adresse réseau de l étendue : {} $scopeID -foregroundcolor "yellow"
    Write-Host Etendue DHCP : {}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{} $startrange - $endrange -foregroundcolor "yellow"
    Write-Host Masque sous-réseau : {}{}{}{}{}{}{}{}{}{} $subnetmask -foregroundcolor "yellow"
    Write-Host Passerelle : {}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{} $router -foregroundcolor "yellow"
    Write-Host Nom du domaine : {}{}{}{}{}{}{}{}{}{}{}{}{}{} $NomZoneDns -foregroundcolor "yellow"
    Write-Host Adresse du serveur DNS : {}{}{}{}{}{} $IPServeurDns -foregroundcolor "yellow"
    Write-Host
    Write-Host ---------/Congiguration saisie----------- -foregroundcolor "yellow"
    Write-Host
    Write-Host
    Write-Host

    #Confirmation des informations saisies
    Write-Host Entrer Oui pour continuer ou une autre commande pour annuler...
    Write-Host
    $input2 = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer Oui pour continuer ou une autre commande pour annuler...", "Creation de l'étendue DHCP", "")

    #Affichage des informations après validation
    if(($input2) -eq "Oui" )
    {    
        Add-DHCPServerv4Scope -ComputerName $dhcpserver -EndRange $endrange -Name $scopename -StartRange $startrange -SubnetMask $subnetmask -State Active
        Set-DHCPServerv4OptionValue -ComputerName $dhcpserver -ScopeId $scopeID -Router $router
        Set-DHCPServerv4OptionValue -ScopeId $scopeID -OptionId 6 -value $IPServeurDns
        Set-DHCPServerv4OptionValue -ScopeId $scopeID -OptionId 15 -value $NomZoneDns

        Write-Host
        Write-Host
        Write-Host Création de l étendue $scopename  sur le serveur $dhcpserver -foregroundcolor "green"
        Write-Host
        Write-Host ---------------Enregistrement des informations-------------------- -foregroundcolor "green"
        Write-Host ------------------------------------------- -foregroundcolor "green"
        Write-Host
        Write-Host Nom de l étendue : {}{}{}{}{}{}{}{}{}{}{}{} $scopename -foregroundcolor "green"
        Write-Host Adresse réseau de l étendue : {} $scopeID -foregroundcolor "green"
        Write-Host Etendue DHCP : {}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{} $startrange - $endrange -foregroundcolor "green"
        Write-Host Masque sous-réseau : {}{}{}{}{}{}{}{}{}{} $subnetmask -foregroundcolor "green"
        Write-Host Passerelle : {}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{} $router -foregroundcolor "green"
        Write-Host Nom du domaine : {}{}{}{}{}{}{}{}{}{}{}{}{}{} $NomZoneDns -foregroundcolor "green"
        Write-Host Adresse du serveur DNS : {}{}{}{}{}{} $IPServeurDns -foregroundcolor "green"
        Write-Host
        Write-Host ------------------------------------------- -foregroundcolor "green"
        Write-Host --------------/Enregistrement des informations-------------------- -foregroundcolor "green"
    }
    else 
    {
        Write-Host L étendue est annulée "black"
    }
}
