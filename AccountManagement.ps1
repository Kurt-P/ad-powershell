#####################################################
# This is an interactive script that does some      #
# simple and basic account management in an AD      #
#                                                   #
# Written by Kurt Prudhomme                         #
# Date 07/16/2013                                   #
#####################################################

##Import the AD modules
Import-Module ActiveDirectory

$run = $true

function disableAccount() {
    Write-Host -ForegroundColor Red -BackgroundColor Yellow "You are about to DISABLE an account"
    $user = Read-Host "User account to DISABLE"
    Disable-ADAccount -Identity $user -Confirm
    Write-Host "Done!"
}

function enableAccount() {
    Write-Host "You are about to ENABLE an account"
    $user = Read-Host "User account to enable"
    Enable-ADAccount -Identity $user -Confirm
    Write-Host "Done!"
}

function unlockAccount() {
    Write-Host "You are about to UNLOCK an account"
    $user = Read-Host "User account to unlock"
    Unlock-ADAccount -Identity $user -Confirm
    Write-Host "Done!"
}

do {
    ##Give them the illision of choice
    $choice = Read-Host "[D]isable account, [E]nable account, [U]nlock account, [Q]uit"
    switch($choice.ToUpper()) {
        D {disableAccount}
        E {enableAccount}
        U {unlockAccount}
        Q {Write-Host "Good Bye!"
            $run = $false}
        default {$choice = Read-Host "[D]isable account, [E]nable account, [U]nlock account, [Q]uit"}
    }
}
while ($run)
