IMPORT Corp2_Mapping;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseProd = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Rejected File Names
	//////////////////////////////////////////////////////////////////
	EXPORT Reject := MODULE
			
			EXPORT Main := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+pversion+'::rejected::AR_NV',Scrubs_Corp2_Mapping_NV_AR.Scrubs.Expanded_Layout,thor);
														
	END;

END;