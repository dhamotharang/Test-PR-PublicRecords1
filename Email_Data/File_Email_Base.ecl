import Email_Data, ut;
//New base layout with scrubbits field appended
	ds_base := dataset('~thor_data400::base::email_data', Email_Data.Layout_Email.Scrubs_bits_base, thor);

//Project back into previous layout expected by the keybuild	
export File_Email_Base := project(ds_base,Layout_Email.base);