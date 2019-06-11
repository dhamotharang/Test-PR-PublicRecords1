import Email_Data, ut, Data_Services, Header;
//New base layout with scrubbits field appended
	ds_base := dataset('~thor_data400::base::email_data', Email_Data.Layout_Email.Scrubs_bits_base, thor);
	fDeathMaster	:= Header.File_DID_Death_MasterV3_ssa;
	
//Flag invalid emails
pValidEmail	:= PROJECT(ds_base, TRANSFORM(Layout_email.temp_Validate, SELF.SkipRec := Email_Data.Fn_InvalidEmail(LEFT.clean_email, LEFT.append_domain);
																																			SELF.IsDeath := FALSE;
																																			SELF := LEFT)
											);
																						 
//Determine if record meets DOD filter
fNoDeathRecs	:= Email_Data.Fn_ApplyDeathRule(pValidEmail);
//persist removed to avoid using previous base.
									
//Concat Emails that do not meet death criteria with valid emails with no DID(these were removed from the death join)
ValidEmailAll := fNoDeathRecs + pValidEmail(SkipRec = FALSE and DID = 0);

//Project to layout expected by keybuild
pEmailout	:= PROJECT(ValidEmailAll,Layout_Email.base);

//Project back into previous layout expected by the keybuild	
export File_Email_Base := pEmailout;
