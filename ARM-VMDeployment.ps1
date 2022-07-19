$resourceGroupName = Read-Host -Prompt "Enter the Resource Group name"
$location = Read-Host -Prompt "Enter the location (i.e. centralus)"
$subnetName = Read-Host - Prompt "Enter Subnet Name"
$adminUsername = Read-Host -Prompt "Enter the administrator username"
$adminPassword = Read-Host -Prompt "Enter the administrator password" -AsSecureString
$VirtualMachineName = Read-Host -Prompt "Enter the new VM Name"
$osDiskType = Read-Host -Prompt "Enter Disk Type (i.e Premium_LRS)"
$VirtualMachineSize = Read-Host = Prompt "Enter Virtual Machine Size (i.e Standard_D2s_v4)"
$vnic = Get-AzVirtualNetwork -ResourceGroupName $resourceGroupName
$virtualNetworkId = $vnic.Id
$networkInterfaceName = ($VirtualMachineName + "130")
$virtualMachineRG = $resourceGroupName

New-AzResourceGroup -Name $resourceGroupName -Location "$location"

New-AzResourceGroupDeployment `
    -resourceGroupName $resourceGroupName `
    -TemplateFile "C:\Users\Squeegie\OneDrive - Rapidscale, Inc\AzureVirtualDesktops\AutomationScripts\ARM Templates\VMDeployTemplate.json" `
    -location $location `
    -virtualMachineRG $virtualMachineRG `
    -subnetName $subnetName `
    -adminUsername $adminUsername `
    -adminPassword $adminPassword `
    -VirtualMachineName $VirtualMachineName `
    -osDiskType $osDiskType `
    -VirtualMachineSize $VirtualMachineSize `
    -virtualNetworkId $virtualNetworkId `
    -networkInterfaceName $networkInterfaceName `
    -virtualMachineComputerName $virtualMachineName `
    -enableAcceleratedNetworking $true `
    -osDiskDeleteOption "delete" `
    -nicDeleteOption "delete" `
    -patchMode "AutomaticByOS" `
    -enableHotpatching $false `

 (Get-AzVm -ResourceGroupName $resourceGroupName).name




