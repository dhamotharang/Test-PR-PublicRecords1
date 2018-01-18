import doxie, data_services;

export Key_Corporate_Affiliations_DID := 
	index(File_Corporate_Affiliations_Plus, 
		  {did, __filepos }, 
		 data_services.data_location.prefix() + 'thor_data400::key::corporate_affiliations.did_' + doxie.Version_SuperKey);