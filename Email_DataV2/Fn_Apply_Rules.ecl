//**********Funtion to flag rules
IMPORT ut, Email_DataV2, dx_Email, STD, Entiera;

EXPORT Fn_Apply_Rules (dataset(recordof(Layouts.Base_BIP)) email_in) := FUNCTION

	//Project to temp layout to apply rules
	xRuleFields	:=	PROJECT(email_in, TRANSFORM(Email_DataV2.Layouts.temp_Validate, SELF := LEFT));
	
	//Set Invalid Email Rules
	setEmailFlags	:= Email_DataV2.Fn_InvalidEmail(xRuleFields);
	
	//Set Death rule flag
	setDODFlag	:= Email_DataV2.Fn_SetDODRule(setEmailFlags);
	
	//Translate rules to bitmap
	Email_DataV2.Layouts.Base_BIP t_flag_rules(setDODFlag L) := TRANSFORM
		Invalid_domain_ext	:= IF(L.append_is_valid_domain_ext = FALSE,
															dx_Email.Translation_Codes.rules_bitmap_code('invalid_domain_ext'),0);
		Missing_domain_ext	:= IF(STD.Str.FindCount(L.clean_email,  '.') = 0,
															dx_Email.Translation_Codes.rules_bitmap_code('missing_domain_ext'),0);
		Invalid_domain			:= IF(L.InvalidDomain,
															dx_Email.Translation_Codes.rules_bitmap_code('invalid_domain'),
															IF(Invalid_domain_ext <> 0 OR Missing_domain_ext <> 0,
															dx_Email.Translation_Codes.rules_bitmap_code('invalid_domain'),0));
		Invalid_username		:= IF(TRIM(L.append_email_username) = '', 
															dx_Email.Translation_Codes.rules_bitmap_code('missing_username'),0);
		Missing_at_symbol		:= IF(STD.Str.FindCount(L.orig_email,  '@') = 0,
															dx_Email.Translation_Codes.rules_bitmap_code('missing_@_symbol'),0);
		Invalid_email_rule	:= IF(L.InvalidEmail, 
															dx_Email.Translation_Codes.rules_bitmap_code('invalid_email'),
															IF(Invalid_username <> 0 OR Missing_at_symbol <> 0,
															dx_Email.Translation_Codes.rules_bitmap_code('invalid_email'),0));
		DOD_B4_Email				:= IF(L.IsDeath,
															dx_Email.Translation_Codes.rules_bitmap_code('dod_b4_email'),0);
		// Invalid_account			:= IF(L.InvalidAccount,
															// dx_Email.Translation_Codes.rules_bitmap_code('invalid_account'),0); //waiting for BV lookup to determine this
		Invalid_account			:= 0;
		Profane_email				:= IF(Entiera.fn_profanity(L.clean_email),
															dx_Email.Translation_Codes.rules_bitmap_code('includes_profanity'),0);
		disposable_address	:= 0;  //rule will be determined by BV lookup - future use
		role_address				:= 0;		//rule will be determined by BV lookup - future use
															
		SELF.rules 					:= L.rules |
													Invalid_domain_ext |
													Missing_domain_ext	|
													Invalid_domain	|
													Invalid_username	|
													Missing_at_symbol	|
													Invalid_email_rule |
													DOD_B4_Email	|
													Invalid_account	|
													Profane_email	|
													disposable_address	|
													role_address
												;
		SELF := L;
	END;
	
	Flag_Rules := PROJECT(setDODFlag, t_flag_rules(left));
	
RETURN Flag_Rules;

END;
	
		
		