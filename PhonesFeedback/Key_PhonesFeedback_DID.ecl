IMPORT Data_Services, doxie, ut;

base := PhonesFeedback.File_PhonesFeedback_base;

// Keep only the valid phone number/DID data
key_base := base (TRIM(phone_number) NOT IN ['0', ''] AND TRIM(phone_number)[1..3] <> '000' AND DID <> 0);	
									
layoutPhonesFeedbackDID := RECORD
	UNSIGNED6 did := 0;
	UNSIGNED1 did_score := 0;
	UNSIGNED6 hhid := 0;
	STRING10 phone_number := '';
	STRING login_history_id := '';
	STRING20 fname := '';
	STRING20 lname := '';
	STRING20 mname := '';
	STRING10 Prim_Range := '';
	STRING2 Predir := '';
	STRING28 Prim_Name := '';
	STRING4 Addr_Suffix := '';
	STRING2 Postdir := '';
	STRING10 Unit_Desig := '';
	STRING8 Sec_Range := '';
	STRING5 Zip5 := '';
	STRING4 Zip4 := '';
	STRING25 City := '';
	STRING2 State := '';
	STRING10 Alt_Phone := '';
	STRING other_info := '';
	STRING phone_contact_type := '';
	STRING feedback_source := '';
	STRING date_time_added := '';
	STRING loginid := '';
	STRING customerid := '';
	//Added for CCPA-355
	UNSIGNED4 global_sid;
	UNSIGNED8 record_sid;
END;

layoutPhonesFeedbackDID cleanKeyBase(key_base le) := TRANSFORM
	SELF.fname := StringLib.StringToUpperCase(TRIM(le.fname));
	SELF.mname := StringLib.StringToUpperCase(TRIM(le.mname));
	SELF.lname := StringLib.StringToUpperCase(TRIM(le.lname));
	SELF.Prim_Range := TRIM(le.street_number);
	SELF.Predir := StringLib.StringToUpperCase(TRIM(le.street_pre_direction));
	SELF.Prim_Name := StringLib.StringToUpperCase(TRIM(le.street_name));
	SELF.Addr_Suffix := StringLib.StringToUpperCase(TRIM(le.street_suffix));
	SELF.Postdir := StringLib.StringToUpperCase(TRIM(le.street_post_direction));
	SELF.Unit_Desig := TRIM(le.unit_designation);
	SELF.Sec_Range := TRIM(le.unit_number);
	SELF.Zip5 := TRIM(le.Zip5);
	SELF.Zip4 := TRIM(le.Zip4);
	SELF := le;
END;

cleanKey_Base := PROJECT(key_base, cleanKeyBase(LEFT));

EXPORT Key_PhonesFeedback_DID := index(cleanKey_Base,
										  {DID},
										  {cleanKey_Base},
										  data_services.data_location.Prefix('phonesFeedback') + 'thor_data400::key::phonesFeedback::'+doxie.Version_SuperKey+'::DID');