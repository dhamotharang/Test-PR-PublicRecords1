import mdr;

EXPORT _files := MODULE

		// Both of these Phase1 files s/b temporary work files.  
		EXPORT Phase1_Sprayed_File := p1_file_sprayed.file;
		EXPORT Phase1_Output_File := p1_file_output.file;
		// -----------------------------------------------------------------------------------------------------------------------
		
		EXPORT File_Email_Base_DS := DATASET ( _constants.baseSuperFileString, _layouts.base, thor);

		//doing this just to add zero and blanks to the standardization dataset in order to pass it through the autokey mac.
		email_ds := File_Email_Base_DS(append_is_valid_domain_ext AND current_rec);
		EXPORT File_AutoKey := PROJECT(email_ds,_layouts.Autokey_layout);
	
		//*************************** PROBABLE OBSOLETE STUFF FOUND ONLY IN z_attributes ****************************
		// we should not need FCRA data for the email product in PRCT 
	
END;