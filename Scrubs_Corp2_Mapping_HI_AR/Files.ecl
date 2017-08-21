IMPORT Corp2_Mapping;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Rejected File Names
	//////////////////////////////////////////////////////////////////
	EXPORT Reject := MODULE
			
		EXPORT File := dataset(
		  Corp2_Mapping._Dataset(pUseOtherEnvironment).thor_cluster_Files + 'out::corp2::'+pversion+'::rejected::AR_HI',
			Scrubs_Corp2_Mapping_HI_AR.Scrubs.Expanded_Layout,thor);
														
	END;

END;