IMPORT Corp2_Mapping;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseProd = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Rejected File Names
	//////////////////////////////////////////////////////////////////
	EXPORT Reject := MODULE
			
			EXPORT Main := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+pversion+'::rejected::main_NJ',Scrubs_Corp2_Mapping_NJ_Main.Scrubs.Expanded_Layout,thor);
														
	END;

END;