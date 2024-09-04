# Sign in to your Azure subscription
$sub = Get-AzSubscription -ErrorAction SilentlyContinue
if(-not ($sub)) {
    Connect-AzAccount
}

# If you have multiple subscriptions, set the one to use
# Select-AzSubscription -SubscriptionId <SUBSCRIPTIONID>

$resourceGroup = "rg-test"

# These values are used in this tutorial
$automationAccount = "Bozmie"
$userAssignedManagedIdentity = "msi"

$role1 = "DevTest Labs User"

$SAMI = (Get-AzAutomationAccount -ResourceGroupName $resourceGroup -Name $automationAccount).Identity.PrincipalId
New-AzRoleAssignment -ObjectId $SAMI -ResourceGroupName $resourceGroup -RoleDefinitionName $role1

$UAMI = (Get-AzUserAssignedIdentity -ResourceGroupName $resourceGroup -Name $userAssignedManagedIdentity).PrincipalId
New-AzRoleAssignment -ObjectId $UAMI -ResourceGroupName $resourceGroup -RoleDefinitionName $role1

$role2 = "Reader"
New-AzRoleAssignment -ObjectId $SAMI -ResourceGroupName $resourceGroup -RoleDefinitionName $role2