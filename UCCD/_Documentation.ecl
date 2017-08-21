/*
Ok, so here's what I need to do:
find the new files on tapeload02b for the following states/counties:

CA 		-- no lookups in /ucc_new_build/ca/lookups.  Can't find them on any of the read-write 
					mounts on edata10 or edata12.  Ended up recreating them by doing stats on the code and 
					description fields on thor for the filing and events files to find out exactly how the codes
					were populated and also going into the vendor documentation to get the complete list of codes
					doing 20060801 - 20061004
DnB 	-- no lookups in /ucc_new_build/dnb/lookup.  Created all of them except: jurisdiction. Collateral_type was used
					to create the collateral item file, but not sprayed to thor, so I created that file, but didn't make sure it
					correct.  F_state and Fips lookups were not used in the abinitio graph, so disabled them.  Title should be fine
					but it doesn't seem to be used in the files that get sprayed to thor.
IL 		-- had to transfer in ascii mode to remove the carriage returns
MA 
NYC 
TX 
TXD 	-- no updates
TXH 

put in a mount move request for the new ucc mount

ftp the new files to edata10:/ucc_new_build/<state>

figure out which graph to use(by looking at the modified date and output format) to run each of the states/dnb

Here's the scripts I used to run the data:
/ucc_new_build/work/DEV/ksh/run_ca_20061004.sh
/ucc_new_build/work/DEV/ksh/run_il.sh
/ucc_new_build/work/DEV/ksh/run_dnb.sh
/ucc_new_build/work/DEV/ksh/run_tx.sh
/ucc_new_build/work/DEV/ksh/run_th.sh
/ucc_new_build/work/DEV/ksh/run_ma.sh

The output files are here:
/ucc_new_build/work/DEV/out
/ucc_new_build/work/DEV/out/new
/ucc_new_build/work/DEV/out/new/harris

I zipped up old output files to make some space on the mount

spray the resulting files to thor, and add to the correct attribute:
I created an attribute to spray the files to thor and add them to the correct superfiles:
UCCD.Spray_Input_Files

I created 4 superfiles for these 4 input file attributes.  I sprayed and added all of the new updates I 
	ran to these superfiles, then added back all of the old files that were in that attribute:
UCCD.File_UCC_Collateral_In
UCCD.File_UCC_Event_In
UCCD.File_UCC_Filing_In
UCCD.File_UCC_Party_In

Then, modify the following attributes before running:

UCCD.version_development	-- the current date
UCCD.Moxie_mount			-- to correct mount
UCCD.Moxie_DKC_server 		-- the correct mount/server.


Run UCCD.Proc_build_UCC


*/