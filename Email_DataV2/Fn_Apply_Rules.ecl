﻿//**********Funtion to flag rules
IMPORT ut, Email_DataV2, dx_Email, STD, Entiera;

EXPORT Fn_Apply_Rules (dataset(recordof(Layouts.Base_BIP)) email_in) := FUNCTION

	//Project to temp layout to apply rules
	xRuleFields	:=	PROJECT(email_in, TRANSFORM(Email_DataV2.Layouts.temp_Validate, SELF := LEFT));
	
	//Set Invalid Email Rules
	setEmailFlags	:= Email_DataV2.Fn_InvalidEmail(xRuleFields);
	
	//Set Death rule flag
	setDODFlag	:= Email_DataV2.Fn_SetDODRule(setEmailFlags);
	
	//Validate Email from lookup table
	setEmailStatus := Email_DataV2.Fn_EmailEventStatus(setDODFlag);
	
	//Translate rules to bitmap
	Email_DataV2.Layouts.Base_BIP t_flag_rules(setEmailStatus L) := TRANSFORM
		// Invalid_domain_ext	:= IF(L.append_is_valid_domain_ext = FALSE,
															// dx_Email.Translation_Codes.rules_bitmap_code('invalid_domain_ext'),0);
		Missing_domain_ext	:= IF(STD.Str.FindCount(L.clean_email,  '.') = 0,
															dx_Email.Translation_Codes.rules_bitmap_code('missing_domain_ext'),0);
		// Invalid_domain			:= IF(L.InvalidDomain,
															// dx_Email.Translation_Codes.rules_bitmap_code('invalid_domain'),
															// IF(Invalid_domain_ext <> 0 OR Missing_domain_ext <> 0,
															// dx_Email.Translation_Codes.rules_bitmap_code('invalid_domain'),0));
															
    Invalid_domain			:= IF(L.InvalidDomain,
															dx_Email.Translation_Codes.rules_bitmap_code('invalid_domain'),0);															
															
		Invalid_username		:= IF(TRIM(L.append_email_username) = '', 
															dx_Email.Translation_Codes.rules_bitmap_code('missing_username'),0);
		Missing_at_symbol		:= IF(STD.Str.FindCount(L.orig_email,  '@') = 0,
															dx_Email.Translation_Codes.rules_bitmap_code('missing_@_symbol'),0);
		on_known_invalid_list  := IF(L.InvalidEmail, 
														  	dx_Email.Translation_Codes.rules_bitmap_code('on_known_invalid_list'),0);
		DOD_B4_Email				:= IF(L.IsDeath,
															dx_Email.Translation_Codes.rules_bitmap_code('dod_b4_email'),0);
		Invalid_account			:= IF(L.InvalidAccount,
															dx_Email.Translation_Codes.rules_bitmap_code('invalid_account'),0); //Use BV lookup to determine this
		Profane_email				:= IF(Entiera.fn_profanity(L.clean_email),
															dx_Email.Translation_Codes.rules_bitmap_code('includes_profanity'),0);
		disposable_address	:= IF(L.disposable,
															dx_Email.Translation_Codes.rules_bitmap_code('disposable_address'),0);  //rule determined by BV lookup
		role_address				:= IF(L.role,
															dx_Email.Translation_Codes.rules_bitmap_code('role_address'),0);	//rule determined by BV lookup
															
		SELF.rules 					:= L.rules |
													// Invalid_domain_ext |
													Missing_domain_ext	|
													Invalid_domain	|
													Invalid_username	|
													Missing_at_symbol	|
													on_known_invalid_list |
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
	
		
		