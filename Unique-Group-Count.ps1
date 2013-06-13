#######################################################
#Group unique objects in an array by -Unique property #
#                                                     #
#Author: Levi Webster @ 830 06132013                  #
#######################################################

#$gdata pulls grouped data from a printlog. Group-Object does the work and groups by userId
$gdata = $printsLogs | Group-Object -Property userId

#Array used to store values
$test = @()

# This does the work.
#-Unique userId,@{Name = 'PageTotal'} selects the Columns
#The @{Name = 'PageTotal'} creates a new column
#The Expression is what is used to populate the PageTotal. In this case it is pages from a print log
#The final result is the total sum of printed document per unique user
$test += foreach($item in $gdata){

    $item.Group | Select -Unique userId,
    @{Name = 'PageTotal';Expression = {(($item.Group) | measure -Property pages -sum).Sum}}

}

###End###