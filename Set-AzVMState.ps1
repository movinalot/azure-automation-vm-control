<#
    .DESCRIPTION
        A runbook which starts/stops VMs in my reseouce groups

    .NOTES
        AUTHOR: jmcdonough@fortinet.com
        LASTEDIT: May 17, 2021
#>

param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("Start","Stop")]
    [string] $VmAction
)

Connect-AzAccount -Identity

if ($VmAction.Equals("Start")) {
    Start-AzVM -ResourceGroupName jmcdonough-utility -Name jmcdonough-win10 -NoWait
    Get-AzVm -ResourceGroupName jmcdonough-ap-elb-ilb-az-eastus2-01 | Start-AzVm -NoWait
    Get-AzVm -ResourceGroupName jmcdonough-ap-elb-ilb-az-westus2-02 | Start-AzVm -NoWait

} elseif ($VmAction.Equals("Stop")) {
    Stop-AzVM -ResourceGroupName jmcdonough-utility -Name jmcdonough-win10 -NoWait -Force
    Get-AzVm -ResourceGroupName jmcdonough-ap-elb-ilb-az-eastus2-01 | Stop-AzVm -NoWait -Force
    Get-AzVm -ResourceGroupName jmcdonough-ap-elb-ilb-az-westus2-02 | Stop-AzVm -NoWait -Force
}
