function GenerateTemplate {
    write-host 'generate template'

    # Connect-PnPOnline "https://umassdevelop.sharepoint.com/sites/TestCommPnP" -Credentials $cred
    
    # $templateDateTime = get-date -f MM-dd-yyyy_HH_mm_ss
    # #$filePath = "./templates/template-$($templateDateTime).pnp"
    # $filePath = './templates/template-11-15-2017_10_40_07.pnp'


    #Prepare the provisioning template
    #TODO: Test different handlers
    # Handlers: uditSettings, ComposedLook, CustomActions, ExtensibilityProviders, Features, Fields, Files, Lists, Pages, Publishing, RegionalSettings, SearchSettings, SitePolicy, SupportedUILanguages, TermGroups, Workflows, SiteSecurity, ContentTypes, PropertyBagEntries, PageContents, WebSettings, Navigation, ImageRenditions, All
    #Get-PnPProvisioningTemplate -out $filePath -handlers Lists, Pages, PageContents
}

function DeleteModernSite {
    Param(
        [string]$url
    )

    Remove-PnPTenantSite -Url $url -SkipRecycleBin -Force

    write-host 'deleteModernSite'
}

function CreateModernSite {
    Param(
        [string]$name,
        [string]$url
    )
    
    #New-PnPSite -Type CommunicationSite -Title DemroCommPnP -url https://umassdevelop.sharepoint.com/sites/DemroCommPnP

    write-host 'createModernSite'

    New-PnPSite -Type CommunicationSite -Title $name -Url $url
}

function ApplyPnPTemplate {
    Param (
        [string]$templatePath,
        [string]$siteUrl,
        $credentials
    )
    
    write-host 'applyPnPTemplate'

    Connect-PnPOnline $siteUrl -Credentials $credentials

    Apply-PnPProvisioningTemplate -Path $templatePath
}

function GetWebPart {
    Param(
        [string]$webPartID
        [string]$sourceUrl
        [string]$siteUrl
        [string]$zoneId
    )

    $webPartXML = Get-PnPWebPartXml -ServerRelativePageUrl $sourceUrl -Identity $webPartID  

    Add-SPOWebPartToWebPartPage -ServerRelativePageUrl $siteUrl -Xml $webPartXML -ZoneId $zoneId -ZoneIndex 0  
}