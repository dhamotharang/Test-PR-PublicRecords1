IMPORT Corp2_Mapping;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Rejected File Names
	//////////////////////////////////////////////////////////////////
	EXPORT Reject := MODULE
			
		EXPORT File := dataset(
			Corp2_Mapping._Dataset(pUseOtherEnvironment).thor_cluster_Files + 'out::corp2::'+pversion+'::rejected::main_CA',
			Scrubs_Corp2_Mapping_CA_Main.Scrubs.Expanded_Layout,thor);
														
	END;

END;