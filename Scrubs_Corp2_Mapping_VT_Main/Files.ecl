IMPORT Corp2_Mapping;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Rejected File Names
	//////////////////////////////////////////////////////////////////
	EXPORT Reject := MODULE
			
			EXPORT File := dataset(Corp2_Mapping._Dataset(pUseOtherEnvironment).thor_cluster_Files + 'out::corp2::'+pversion+'::rejected::main_VT',Scrubs_Corp2_Mapping_VT_Main.Scrubs.Expanded_Layout,thor);
														
	END;

END;