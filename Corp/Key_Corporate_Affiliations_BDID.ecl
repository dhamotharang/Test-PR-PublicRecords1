import doxie;

export Key_Corporate_Affiliations_BDID := 
	index(File_Corporate_Affiliations_Plus, 
		  {bdid, __filepos }, 
		 '~thor_data400::key::corporate_affiliations.bdid_' + doxie.Version_SuperKey);