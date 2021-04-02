//////////////////////////////////////////////////////////////////////////////////////////
// Attribute 	: Call_Manage_Superfiles

// PARAMETERS	: movefile = true - moves the logical file from in superfile to using 
//							preprocess = true - moves only preprocess files
//												 = false - moves only postprocess files
//							 false - if the subcount of using superfile is more than 1, 
//									 removes all the logical files from "in" superfiles 
//									 that are in "using"  

// DEPENDENT ON	: UCCV2.UCCV2_Dictionary
//				  UCCV2.Manage_InSuperfiles

// PURPOSE	 	: Call Manage superfiles function for each source and sourcetype file.

//////////////////////////////////////////////////////////////////////////////////////////


import UCCV2;

export Call_Manage_InSuperfiles(boolean movefile,boolean preprocess = false) := function
	// UCCV2 dictionary is used as s lookup for source and sourcetype
	ds := if (preprocess,UCCV2.UCCV2_Dictionary(sourcetype in ['ALL','AllSecuredParty','AllDebtors','Filings']),UCCV2.UCCV2_Dictionary);
	recs := record
		ds.source;
		ds.sourcetype;
	end;
	subds := table(ds,recs,few);
	retval := nothor(apply(global(ds,few),UCCV2.Manage_InSuperfiles('~thor_data400::in::uccv2::' + source + 
						if(sourcetype <> 'UCC','::' + sourcetype,''),movefile)));
	
	return retval;
end;
