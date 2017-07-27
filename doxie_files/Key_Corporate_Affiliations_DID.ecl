import doxie, Corp;

export Key_Corporate_Affiliations_DID := 
	index(Corp.File_Corporate_Affiliations_Plus, 
		  {did, __filepos }, 
		 '~thor_data400::key::corporate_affiliations.did_' + doxie.Version_SuperKey);