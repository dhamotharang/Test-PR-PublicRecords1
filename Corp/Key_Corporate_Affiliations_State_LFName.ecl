import doxie;

export Key_Corporate_Affiliations_State_LFName := 
	INDEX(File_Corporate_Affiliations_Plus, 
		  {st, string6 dph_lname, lname, qstring20 pfname, fname, __filepos }, 
		 '~thor_data400::key::corporate_affiliations.state.lfname_' + doxie.Version_SuperKey);