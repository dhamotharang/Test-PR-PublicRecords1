import ut, Data_Services, Header;

ds	:= dataset('~thor_data400::base::email_data_fcra', Layout_Email.base, thor);
fDeathMaster	:= Header.File_DID_Death_MasterV3_ssa;

//Flag invalid emails
pValidEmail	:= PROJECT(ds, TRANSFORM(Layout_email.temp_Validate, SELF.SkipRec := Email_Data.Fn_InvalidEmail(LEFT.clean_email, LEFT.append_domain);
																																SELF.IsDeath := FALSE;
																																SELF := LEFT)
											);
																						 
//Determine if record meets DOD filter
fNoDeathRecs	:= Email_Data.Fn_ApplyDeathRule(pValidEmail);
									
//Concat Emails that do not meet death criteria with valid emails with no DID(these were removed from the death join)
ValidEmailAll := fNoDeathRecs + pValidEmail(SkipRec = FALSE and DID = 0);

//Project to layout expected by keybuild
pEmailout	:= PROJECT(ValidEmailAll,Layout_Email.base);

export File_Email_Base_FCRA := pEmailout;
