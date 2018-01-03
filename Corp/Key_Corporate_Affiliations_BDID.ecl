import doxie, data_services;

export Key_Corporate_Affiliations_BDID := 
	index(File_Corporate_Affiliations_Plus, 
		  {bdid, __filepos }, 
		 data_services.data_location.prefix() + 'thor_data400::key::corporate_affiliations.bdid_' + doxie.Version_SuperKey);