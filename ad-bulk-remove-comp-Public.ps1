#######################################################################################
#Title: ad-bulk-remove-comp.ps1                                                       #
#Description: Removes computers from ad that are in a list.txt file.                  #
#             You must have a list of computer names for the script to work.          #
#             I used 8470.txt for this one. Modify that file for your use.            #
#             Use the -whatif at the end to see the results before using in prod      #
#             Use at your own risk                                                    #
#Author/Date: Levi Webster 1027 06062013                                              #
#######################################################################################

Get-Content "C:\users\Public\8470.txt" | % { Get-ADComputer -Filter { Name -eq $_ } } | Remove-ADComputer 