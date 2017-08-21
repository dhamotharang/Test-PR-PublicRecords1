IMPORT Corp2_Mapping;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseProd = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Rejected File Names
	//////////////////////////////////////////////////////////////////
	EXPORT Reject := MODULE
			
		EXPORT events := dataset(
		  Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+pversion+'::rejected::event_OK',
			Scrubs_Corp2_Mapping_OK_event.Scrubs.Expanded_Layout,thor);
														
	END;

END;