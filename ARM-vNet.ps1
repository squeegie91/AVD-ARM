$resourceGroupName = Read-Host -Prompt "Enter the Resource Group name"
$location = Read-Host -Prompt "Enter the location (i.e. centralus)"
$addressSpaces = Read-Host -Prompt "Enter the Address Space for the vNet (i.e. 10.200.0.0/21)"
$subnet0_Name = Read-Host -Prompt "Enter Infrastructure Subnet Name"
$subnet0_addressRange = Read-Host -Prompt "Enter Infrastructure Subnet Prefix (i.e. 10.200.0.0/24)" 
$subnet1_Name = Read-Host -Prompt "Enter AVD Subnet Name (i.e. RS-EUS-AVD)"
$subnet1_addressRange = Read-Host -Prompt "Enter AVD Subnet Prefix (i.e. 10.200.2.0/24)" 
$virtualNetworkName = Read-Host -Prompt "Enter vNet Name"

New-AzResourceGroup -Name $resourceGroupName -Location $location


New-AzResourceGroupDeployment `
    -ResourceGroupName $resourceGroupName `
    -TemplateFile "C:\temp\vNetTemplate.json" `
    -location $location `
    -virtualNetworkName $virtualNetworkName `
    -addressSpaces $addressSpaces `
    -ipv6Enabled $false `
    -subnetCount "2" `
    -subnet0_name $subnet0_name `
    -subnet0_addressRange $subnet0_addressRange `
    -subnet1_name $subnet1_name `
    -subnet1_addressRange $subnet1_addressRange `
    -ddosProtectionPlanEnabled $false `
    -firewallEnabled $false `
    -bastionEnabled $false `

 (Get-AzVm -ResourceGroupName $resourceGroupName).name

