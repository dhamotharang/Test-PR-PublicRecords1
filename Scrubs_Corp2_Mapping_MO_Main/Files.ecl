import Corp2_Mapping;
EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Rejected File Names
	//////////////////////////////////////////////////////////////////
	EXPORT Reject := MODULE
			
			EXPORT File := dataset(Corp2_Mapping._Dataset(pUseOtherEnvironment).thor_cluster_Files + 'out::corp2::'+pversion+'::rejected::main_mo',Scrubs_Corp2_Mapping_MO_Main.Scrubs.Expanded_Layout,thor);
														
	END;

END;