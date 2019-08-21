EXPORT File_Global_SID := MODULE
	
	//Input: 	Orbit Table Used For Obtaining the Global_SIDs
	EXPORT orbitTable 	:= DATASET('~thor_data400::in::ccpa::orbit_global_sid', 		Layout_Global_SID.orbitTableLayout, 	CSV(HEADING(1), TERMINATOR('\n'), SEPARATOR('\t'))); 	
	
	//Output: Consolidated Lookup Table
	EXPORT lookupTable 	:= DATASET('~thor_data400::base::ccpa::global_sid_lookup', 	Layout_Global_SID.lookupTableLayout, 	flat);	

END;