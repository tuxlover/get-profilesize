##############################################################################
##
## Get-ProfileSize
##
##
## Show all folders larger than 50 MB in Size
##############################################################################



param(
# optional switch for full listing content of all subdirectories
# needs to be put at the beginning of the script. otherwise they are not working
[switch] $full , # pass command line switches to the script. the switch can be verified with if ($full)
[switch] $s, 
[string] $p = $env:USERPROFILE   #pass a string to the $p variable otherwise set $p to the users default profile for checking
)


# just continue and dont write any errors to stdout
# e.g. files that cannot be accessed
if ($s)
{
    $ErrorActionPreference = "SilentlyContinue"
}

# get each subfolder of the users profile and put in to the varible dirs
#tofix:  need to check here if we are getting a valid path if not exit the script with a errr message
$dirs = $(Get-ChildItem -recurse -path $p -attributes D -force)

if ($full)
{   
         
    foreach ($i in $dirs)
    {
    # get the size for each file in the directory and sum its values
    # store the value each time in InSize 
	    $InSize = $(get-childitem $i.FullName -Recurse | Measure-Object -Property length -Sum).Sum

    # Compare InSize and if its size is geater or equal to 50 MB display it
	    if ($InSize/1MB -ge 50)
		    {
			    $i.fullname
                get-childitem -path $i.fullname -Recurse
                echo "====================================================================================================================="
			    # get each object even if it is just a file
			    "{0:N2}" -f ($InSize/1MB)
		    }
    }
}
else 
    {
    foreach ($i in $dirs)
    {
        # get the size for each file in the directory and sum its values
        # store the value each time in InSize 
	    $InSize = $(get-childitem $i.FullName -Recurse | Measure-Object -Property length -Sum).Sum

        # Compare InSize and if its size is geater or equal to 50 MB display it
	    if ($InSize/1MB -ge 50)
		    {
			    $i.fullname
			    # get each object even if it is just a file
			    "{0:N2}" -f ($InSize/1MB)
		    }

    }
}