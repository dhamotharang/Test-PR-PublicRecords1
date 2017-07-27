// *********************************************************************
//
//	The idea is to have all batch services calling this macro to handle
// functionality usually needed by all services to process the input file.
// 
//	As with the rest of the code in this module, this is meant to be enhanced 
// as we move along, so if you've come accross something that you think should 
// be here, feel free to make the change.
// 
// *********************************************************************
//
// Min input layout required:
// 	 BatchShare.Layouts.ShareAcct
//	 BatchShare.Layouts.ShareName
// 	 BatchShare.Layouts.ShareAddress
//
// *********************************************************************

// *********************************************************************
//
// ATTENTION: THIS MACRO IS CURRENTLY UNDER INVESTIGATION. :-)
//	DO NOT USE IT AS IT WILL CAUSE DEPLOYMENT ISSUES.
// 
// *********************************************************************

export MAC_ProcessInput(inf, outf, cleanAddress = false) := 
macro
	
	import address, BatchShare;	
	
	BatchShare.MAC_SequenceInput(inf, sequenced_recs);
	BatchShare.MAC_CapitalizeInput(sequenced_recs, capitalized_recs);
	
	#IF(cleanAddress)
		BatchShare.MAC_CleanAddresses(capitalized_recs, outf);
	#ELSE
		outf := capitalized_recs;
	#END
	
endmacro;