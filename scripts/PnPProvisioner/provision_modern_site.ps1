. .\helpers.ps1
. .\credentials.ps1

# These come from credentials.ps1, which is not checked in.  Create a credentials.ps1 and copy these lines in
# $user = ""
# $pass = ""

$encpassword = convertto-securestring -String $pass -AsPlainText -Force
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $user, $encpassword

Connect-PnPOnline "https://umassdevelop.sharepoint.com" -Credentials $cred

$siteName = "DemroCommPnP"
$tenantUrl = "https://umassdevelop.sharepoint.com"
$siteUrl = "$($tenantUrl)/sites/$($siteName)"


GenerateTemplate

CreateModernSite -name $siteName -url $siteUrl

ApplyPnPTemplate -templatePath $filePath -siteUrl $siteUrl -credentials $cred

#DeleteModernSite -url $siteUrl



