/*
Earlier in 2014 after Edata12 crashed, Danny and I found a PERSIST of the Boca data that was being done after reading the old CSV
and performing various pre-processing and initializations - the PERSIST was just prior to key building.  We took that persist and
saved it as a generation protected THOR file and created a spray and despray process.  
The new build uses that new THOR file as Boca Base
(This code was discussed but never checked in until I noticed it in Feb 2015 - revisited the tests and sent results to Danny to 
let him decide if Boca wants this new code.  NOTE: THESE CHANGES ARE NOT FOR ALPHARETTA's SAKE BUT ARE SIMPLY TO MAKE A BOCA BASE 
BECAUSE THE EDATA12 CRASH BROKE THINGS -- SO ACCEPTANCE IS FULLY UP TO BOCA.

During the build process, the BWR calls
		NEW_proc_build_autokeys(filedate).retval
			AND
		Proc_build_foreclosure_keys(filedate).buildkey

The second one (Proc_build_foreclosure_keys), then uses these references to do Index:
		NEW_proc_build_autokeys_bid(filedate).df3;
		NEW_proc_build_autokeys_bid(filedate).df3_bdid;
		NEW_Proc_Build_Autokeys_bid(filedate).df3_did;
		NEW_proc_build_autokeys(filedate).foreclosure_ak_dataset2;
	
Plus auto key generation done

Boca lost all CSVs on Edata12 and the keys have both Boca and Alpharetta data so cannot create new CSV unless they are filtered.
Changes to:
PRTE2_Foreclosure.Files
PRTE2_Foreclosure.BWR_Spray_Boca_Base
PRTE2_Foreclosure.Fn_Spray_Boca_Spreadsheet
PRTE2_Foreclosure.Get_payload


*/