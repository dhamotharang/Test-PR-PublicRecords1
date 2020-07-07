EXPORT File_Global_SID := MODULE
	
	//In-Scope Flagged File
	EXPORT inScopeFile 	:= DATASET('~thor_data400::in::ccpa::in_scope_file', 				Layout_Global_SID.inScopeLayout, 			CSV(HEADING(1), TERMINATOR('\n'), SEPARATOR('\t')))(in_scope_for_ccpa='Y'); 			
	
	//Input: 	Orbit Table Used For Obtaining the Global_SIDs
	EXPORT orbitTable 	:= DATASET('~thor_data400::in::ccpa::orbit_global_sid', 		Layout_Global_SID.orbitTableLayout, 	CSV(HEADING(1), TERMINATOR('\n'), SEPARATOR('\t'))); 	
	
	//Output: Consolidated Lookup Table
	EXPORT lookupTable 	:= DATASET('~thor_data400::base::global_sid::lookup', 	Layout_Global_SID.lookupTableLayout, 	flat);	

END;
