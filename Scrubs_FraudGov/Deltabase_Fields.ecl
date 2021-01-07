IMPORT SALT311;
EXPORT Deltabase_Fields := MODULE
EXPORT NumFields := 57;
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_alpha','invalid_alphanumeric','invalid_email','invalid_date','invalid_numeric','invalid_numeric_string','invalid_real','invalid_real_string','invalid_zip','invalid_state','invalid_ssn','invalid_phone','invalid_ip','invalid_name');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_alpha' => 1,'invalid_alphanumeric' => 2,'invalid_email' => 3,'invalid_date' => 4,'invalid_numeric' => 5,'invalid_numeric_string' => 6,'invalid_real' => 7,'invalid_real_string' => 8,'invalid_zip' => 9,'invalid_state' => 10,'invalid_ssn' => 11,'invalid_phone' => 12,'invalid_ip' => 13,'invalid_name' => 14,0);
EXPORT MakeFT_invalid_alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\NABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\NABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('\\NABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT311.HygieneErrors.Good);
EXPORT MakeFT_invalid_alphanumeric(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'`!+&,./#()_'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' <>{}[]-^=\'`!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alphanumeric(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'`!+&,./#()_'))));
EXPORT InValidMessageFT_invalid_alphanumeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('\\ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'`!+&,./#()_'),SALT311.HygieneErrors.Good);
EXPORT MakeFT_invalid_email(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\-_.0123456789@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_email(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\-_.0123456789@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_invalid_email(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('\\-_.0123456789@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT311.HygieneErrors.Good);
EXPORT MakeFT_invalid_date(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\N0123456789 ./:-'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ./:-',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_date(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\N0123456789 ./:-'))));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('\\N0123456789 ./:-'),SALT311.HygieneErrors.Good);
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
EXPORT MakeFT_invalid_numeric_string(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\N-0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric_string(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\N-0123456789'))));
EXPORT InValidMessageFT_invalid_numeric_string(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('\\N-0123456789'),SALT311.HygieneErrors.Good);
EXPORT MakeFT_invalid_real(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'-.,0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_real(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'-.,0123456789'))));
EXPORT InValidMessageFT_invalid_real(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('-.,0123456789'),SALT311.HygieneErrors.Good);
EXPORT MakeFT_invalid_real_string(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\N-.,0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_real_string(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\N-.,0123456789'))));
EXPORT InValidMessageFT_invalid_real_string(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('\\N-.,0123456789'),SALT311.HygieneErrors.Good);
EXPORT MakeFT_invalid_zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\N-0123456789 -'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_zip(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\N-0123456789 -'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('\\N-0123456789 -'),SALT311.HygieneErrors.NotLength('0,2,5,9,10'),SALT311.HygieneErrors.Good);
EXPORT MakeFT_invalid_state(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_invalid_state(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('\\ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT311.HygieneErrors.NotLength('0,2'),SALT311.HygieneErrors.Good);
EXPORT MakeFT_invalid_ssn(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\N0123456789 -'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_ssn(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\N0123456789 -'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) >= 9));
EXPORT InValidMessageFT_invalid_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('\\N0123456789 -'),SALT311.HygieneErrors.NotLength('0,2,9..'),SALT311.HygieneErrors.Good);
EXPORT MakeFT_invalid_phone(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\N0123456789 +#()-'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' +#()-',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_phone(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\N0123456789 +#()-'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) >= 10));
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('\\N0123456789 +#()-'),SALT311.HygieneErrors.NotLength('0,2,10..'),SALT311.HygieneErrors.Good);
EXPORT MakeFT_invalid_ip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\N.x0123456789 .'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' .',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_ip(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\N.x0123456789 .'))));
EXPORT InValidMessageFT_invalid_ip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('\\N.x0123456789 .'),SALT311.HygieneErrors.Good);
EXPORT MakeFT_invalid_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\NABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz \','); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' \',',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_name(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\NABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz \','))));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('\\NABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz \','),SALT311.HygieneErrors.Good);
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'inqlog_id','customer_id','transaction_id','date_of_transaction','household_id','customer_person_id','customer_program','reason_for_transaction_activity','inquiry_source','customer_county','customer_state','customer_agency_vertical_type','ssn','dob','rawlinkid','raw_full_name','raw_title','raw_first_name','raw_middle_name','raw_last_name','raw_orig_suffix','full_address','street_1','city','state','zip','county','mailing_street_1','mailing_city','mailing_state','mailing_zip','mailing_county','phone_number','ultid','orgid','seleid','tin','email_address','appended_provider_id','lnpid','npi','ip_address','device_id','professional_id','bank_routing_number_1','bank_account_number_1','drivers_license_state','drivers_license','geo_lat','geo_long','reported_date','file_type','deceitful_confidence','reported_by','reason_description','event_type_1','event_entity_1');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'inqlog_id','customer_id','transaction_id','date_of_transaction','household_id','customer_person_id','customer_program','reason_for_transaction_activity','inquiry_source','customer_county','customer_state','customer_agency_vertical_type','ssn','dob','rawlinkid','raw_full_name','raw_title','raw_first_name','raw_middle_name','raw_last_name','raw_orig_suffix','full_address','street_1','city','state','zip','county','mailing_street_1','mailing_city','mailing_state','mailing_zip','mailing_county','phone_number','ultid','orgid','seleid','tin','email_address','appended_provider_id','lnpid','npi','ip_address','device_id','professional_id','bank_routing_number_1','bank_account_number_1','drivers_license_state','drivers_license','geo_lat','geo_long','reported_date','file_type','deceitful_confidence','reported_by','reason_description','event_type_1','event_entity_1');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'inqlog_id' => 0,'customer_id' => 1,'transaction_id' => 2,'date_of_transaction' => 3,'household_id' => 4,'customer_person_id' => 5,'customer_program' => 6,'reason_for_transaction_activity' => 7,'inquiry_source' => 8,'customer_county' => 9,'customer_state' => 10,'customer_agency_vertical_type' => 11,'ssn' => 12,'dob' => 13,'rawlinkid' => 14,'raw_full_name' => 15,'raw_title' => 16,'raw_first_name' => 17,'raw_middle_name' => 18,'raw_last_name' => 19,'raw_orig_suffix' => 20,'full_address' => 21,'street_1' => 22,'city' => 23,'state' => 24,'zip' => 25,'county' => 26,'mailing_street_1' => 27,'mailing_city' => 28,'mailing_state' => 29,'mailing_zip' => 30,'mailing_county' => 31,'phone_number' => 32,'ultid' => 33,'orgid' => 34,'seleid' => 35,'tin' => 36,'email_address' => 37,'appended_provider_id' => 38,'lnpid' => 39,'npi' => 40,'ip_address' => 41,'device_id' => 42,'professional_id' => 43,'bank_routing_number_1' => 44,'bank_account_number_1' => 45,'drivers_license_state' => 46,'drivers_license' => 47,'geo_lat' => 48,'geo_long' => 49,'reported_date' => 50,'file_type' => 51,'deceitful_confidence' => 52,'reported_by' => 53,'reason_description' => 54,'event_type_1' => 55,'event_entity_1' => 56,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['LEFTTRIM','ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['LEFTTRIM','ALLOW','LENGTHS'],['ALLOW'],['LEFTTRIM','ALLOW','LENGTHS'],['LEFTTRIM','ALLOW'],['ALLOW'],['LEFTTRIM','ALLOW'],['ALLOW'],['LEFTTRIM','ALLOW'],['LEFTTRIM','ALLOW'],['LEFTTRIM','ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['LEFTTRIM','ALLOW'],['LEFTTRIM','ALLOW','LENGTHS'],['LEFTTRIM','ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['LEFTTRIM','ALLOW'],['LEFTTRIM','ALLOW','LENGTHS'],['LEFTTRIM','ALLOW','LENGTHS'],['ALLOW'],['LEFTTRIM','ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['LEFTTRIM','ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['LEFTTRIM','ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
//Individual field level validation
EXPORT Make_inqlog_id(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_inqlog_id(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_inqlog_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_customer_id(SALT311.StrType s0) := MakeFT_invalid_numeric_string(s0);
EXPORT InValid_customer_id(SALT311.StrType s) := InValidFT_invalid_numeric_string(s);
EXPORT InValidMessage_customer_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_string(wh);
EXPORT Make_transaction_id(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_transaction_id(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_transaction_id(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
EXPORT Make_date_of_transaction(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_of_transaction(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_of_transaction(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_household_id(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_household_id(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_household_id(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
EXPORT Make_customer_person_id(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_customer_person_id(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_customer_person_id(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
EXPORT Make_customer_program(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_customer_program(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_customer_program(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
EXPORT Make_reason_for_transaction_activity(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_reason_for_transaction_activity(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_reason_for_transaction_activity(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
EXPORT Make_inquiry_source(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_inquiry_source(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_inquiry_source(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
EXPORT Make_customer_county(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_customer_county(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_customer_county(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
EXPORT Make_customer_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_customer_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_customer_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
EXPORT Make_customer_agency_vertical_type(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_customer_agency_vertical_type(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_customer_agency_vertical_type(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
EXPORT Make_ssn(SALT311.StrType s0) := MakeFT_invalid_ssn(s0);
EXPORT InValid_ssn(SALT311.StrType s) := InValidFT_invalid_ssn(s);
EXPORT InValidMessage_ssn(UNSIGNED1 wh) := InValidMessageFT_invalid_ssn(wh);
EXPORT Make_dob(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dob(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_rawlinkid(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_rawlinkid(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_rawlinkid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_raw_full_name(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_raw_full_name(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_raw_full_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_raw_title(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_raw_title(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_raw_title(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
EXPORT Make_raw_first_name(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_raw_first_name(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_raw_first_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_raw_middle_name(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_raw_middle_name(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_raw_middle_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_raw_last_name(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_raw_last_name(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_raw_last_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_raw_orig_suffix(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_raw_orig_suffix(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_raw_orig_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
EXPORT Make_full_address(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_full_address(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_full_address(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
EXPORT Make_street_1(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_street_1(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_street_1(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
EXPORT Make_city(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_city(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
EXPORT Make_zip(SALT311.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_zip(SALT311.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
EXPORT Make_county(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_county(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_county(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
EXPORT Make_mailing_street_1(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_mailing_street_1(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_mailing_street_1(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
EXPORT Make_mailing_city(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_mailing_city(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_mailing_city(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_mailing_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_mailing_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_mailing_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
EXPORT Make_mailing_zip(SALT311.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_mailing_zip(SALT311.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_mailing_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
EXPORT Make_mailing_county(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_mailing_county(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_mailing_county(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
EXPORT Make_phone_number(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_phone_number(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_phone_number(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
EXPORT Make_ultid(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_ultid(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_orgid(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_orgid(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_seleid(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_seleid(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_tin(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_tin(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_tin(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
EXPORT Make_email_address(SALT311.StrType s0) := MakeFT_invalid_email(s0);
EXPORT InValid_email_address(SALT311.StrType s) := InValidFT_invalid_email(s);
EXPORT InValidMessage_email_address(UNSIGNED1 wh) := InValidMessageFT_invalid_email(wh);
EXPORT Make_appended_provider_id(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_appended_provider_id(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_appended_provider_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_lnpid(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_lnpid(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_lnpid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_npi(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_npi(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_npi(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
EXPORT Make_ip_address(SALT311.StrType s0) := MakeFT_invalid_ip(s0);
EXPORT InValid_ip_address(SALT311.StrType s) := InValidFT_invalid_ip(s);
EXPORT InValidMessage_ip_address(UNSIGNED1 wh) := InValidMessageFT_invalid_ip(wh);
EXPORT Make_device_id(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_device_id(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_device_id(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
EXPORT Make_professional_id(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_professional_id(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_professional_id(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
EXPORT Make_bank_routing_number_1(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_bank_routing_number_1(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_bank_routing_number_1(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
EXPORT Make_bank_account_number_1(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_bank_account_number_1(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_bank_account_number_1(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
EXPORT Make_drivers_license_state(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_drivers_license_state(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_drivers_license_state(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
EXPORT Make_drivers_license(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_drivers_license(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_drivers_license(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
EXPORT Make_geo_lat(SALT311.StrType s0) := MakeFT_invalid_real_string(s0);
EXPORT InValid_geo_lat(SALT311.StrType s) := InValidFT_invalid_real_string(s);
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := InValidMessageFT_invalid_real_string(wh);
EXPORT Make_geo_long(SALT311.StrType s0) := MakeFT_invalid_real_string(s0);
EXPORT InValid_geo_long(SALT311.StrType s) := InValidFT_invalid_real_string(s);
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := InValidMessageFT_invalid_real_string(wh);
EXPORT Make_reported_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_reported_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_reported_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_file_type(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_file_type(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_file_type(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
EXPORT Make_deceitful_confidence(SALT311.StrType s0) := MakeFT_invalid_numeric_string(s0);
EXPORT InValid_deceitful_confidence(SALT311.StrType s) := InValidFT_invalid_numeric_string(s);
EXPORT InValidMessage_deceitful_confidence(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_string(wh);
EXPORT Make_reported_by(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_reported_by(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_reported_by(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
EXPORT Make_reason_description(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_reason_description(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_reason_description(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
EXPORT Make_event_type_1(SALT311.StrType s0) := MakeFT_invalid_numeric_string(s0);
EXPORT InValid_event_type_1(SALT311.StrType s) := InValidFT_invalid_numeric_string(s);
EXPORT InValidMessage_event_type_1(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_string(wh);
EXPORT Make_event_entity_1(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_event_entity_1(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_event_entity_1(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_FraudGov;
//Find those highly occuring pivot values to remove them from consideration
#uniquename(tr)
  %tr% := table(in_left+in_right,{ val := pivot_exp; });
#uniquename(r1)
  %r1% := record
    %tr%.val;    unsigned Cnt := COUNT(GROUP);
  end;
#uniquename(t1)
  %t1% := table(%tr%,%r1%,val,local); // Pre-aggregate before distribute
#uniquename(r2)
  %r2% := record
    %t1%.val;    unsigned Cnt := SUM(GROUP,%t1%.Cnt);
  end;
#uniquename(t2)
  %t2% := table(%t1%,%r2%,val); // Now do global aggregate
Bad_Pivots := %t2%(Cnt>100);
#uniquename(dl)
  %dl% := RECORD
    BOOLEAN Diff_inqlog_id;
    BOOLEAN Diff_customer_id;
    BOOLEAN Diff_transaction_id;
    BOOLEAN Diff_date_of_transaction;
    BOOLEAN Diff_household_id;
    BOOLEAN Diff_customer_person_id;
    BOOLEAN Diff_customer_program;
    BOOLEAN Diff_reason_for_transaction_activity;
    BOOLEAN Diff_inquiry_source;
    BOOLEAN Diff_customer_county;
    BOOLEAN Diff_customer_state;
    BOOLEAN Diff_customer_agency_vertical_type;
    BOOLEAN Diff_ssn;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_rawlinkid;
    BOOLEAN Diff_raw_full_name;
    BOOLEAN Diff_raw_title;
    BOOLEAN Diff_raw_first_name;
    BOOLEAN Diff_raw_middle_name;
    BOOLEAN Diff_raw_last_name;
    BOOLEAN Diff_raw_orig_suffix;
    BOOLEAN Diff_full_address;
    BOOLEAN Diff_street_1;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_county;
    BOOLEAN Diff_mailing_street_1;
    BOOLEAN Diff_mailing_city;
    BOOLEAN Diff_mailing_state;
    BOOLEAN Diff_mailing_zip;
    BOOLEAN Diff_mailing_county;
    BOOLEAN Diff_phone_number;
    BOOLEAN Diff_ultid;
    BOOLEAN Diff_orgid;
    BOOLEAN Diff_seleid;
    BOOLEAN Diff_tin;
    BOOLEAN Diff_email_address;
    BOOLEAN Diff_appended_provider_id;
    BOOLEAN Diff_lnpid;
    BOOLEAN Diff_npi;
    BOOLEAN Diff_ip_address;
    BOOLEAN Diff_device_id;
    BOOLEAN Diff_professional_id;
    BOOLEAN Diff_bank_routing_number_1;
    BOOLEAN Diff_bank_account_number_1;
    BOOLEAN Diff_drivers_license_state;
    BOOLEAN Diff_drivers_license;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_reported_date;
    BOOLEAN Diff_file_type;
    BOOLEAN Diff_deceitful_confidence;
    BOOLEAN Diff_reported_by;
    BOOLEAN Diff_reason_description;
    BOOLEAN Diff_event_type_1;
    BOOLEAN Diff_event_entity_1;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_inqlog_id := le.inqlog_id <> ri.inqlog_id;
    SELF.Diff_customer_id := le.customer_id <> ri.customer_id;
    SELF.Diff_transaction_id := le.transaction_id <> ri.transaction_id;
    SELF.Diff_date_of_transaction := le.date_of_transaction <> ri.date_of_transaction;
    SELF.Diff_household_id := le.household_id <> ri.household_id;
    SELF.Diff_customer_person_id := le.customer_person_id <> ri.customer_person_id;
    SELF.Diff_customer_program := le.customer_program <> ri.customer_program;
    SELF.Diff_reason_for_transaction_activity := le.reason_for_transaction_activity <> ri.reason_for_transaction_activity;
    SELF.Diff_inquiry_source := le.inquiry_source <> ri.inquiry_source;
    SELF.Diff_customer_county := le.customer_county <> ri.customer_county;
    SELF.Diff_customer_state := le.customer_state <> ri.customer_state;
    SELF.Diff_customer_agency_vertical_type := le.customer_agency_vertical_type <> ri.customer_agency_vertical_type;
    SELF.Diff_ssn := le.ssn <> ri.ssn;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_rawlinkid := le.rawlinkid <> ri.rawlinkid;
    SELF.Diff_raw_full_name := le.raw_full_name <> ri.raw_full_name;
    SELF.Diff_raw_title := le.raw_title <> ri.raw_title;
    SELF.Diff_raw_first_name := le.raw_first_name <> ri.raw_first_name;
    SELF.Diff_raw_middle_name := le.raw_middle_name <> ri.raw_middle_name;
    SELF.Diff_raw_last_name := le.raw_last_name <> ri.raw_last_name;
    SELF.Diff_raw_orig_suffix := le.raw_orig_suffix <> ri.raw_orig_suffix;
    SELF.Diff_full_address := le.full_address <> ri.full_address;
    SELF.Diff_street_1 := le.street_1 <> ri.street_1;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_mailing_street_1 := le.mailing_street_1 <> ri.mailing_street_1;
    SELF.Diff_mailing_city := le.mailing_city <> ri.mailing_city;
    SELF.Diff_mailing_state := le.mailing_state <> ri.mailing_state;
    SELF.Diff_mailing_zip := le.mailing_zip <> ri.mailing_zip;
    SELF.Diff_mailing_county := le.mailing_county <> ri.mailing_county;
    SELF.Diff_phone_number := le.phone_number <> ri.phone_number;
    SELF.Diff_ultid := le.ultid <> ri.ultid;
    SELF.Diff_orgid := le.orgid <> ri.orgid;
    SELF.Diff_seleid := le.seleid <> ri.seleid;
    SELF.Diff_tin := le.tin <> ri.tin;
    SELF.Diff_email_address := le.email_address <> ri.email_address;
    SELF.Diff_appended_provider_id := le.appended_provider_id <> ri.appended_provider_id;
    SELF.Diff_lnpid := le.lnpid <> ri.lnpid;
    SELF.Diff_npi := le.npi <> ri.npi;
    SELF.Diff_ip_address := le.ip_address <> ri.ip_address;
    SELF.Diff_device_id := le.device_id <> ri.device_id;
    SELF.Diff_professional_id := le.professional_id <> ri.professional_id;
    SELF.Diff_bank_routing_number_1 := le.bank_routing_number_1 <> ri.bank_routing_number_1;
    SELF.Diff_bank_account_number_1 := le.bank_account_number_1 <> ri.bank_account_number_1;
    SELF.Diff_drivers_license_state := le.drivers_license_state <> ri.drivers_license_state;
    SELF.Diff_drivers_license := le.drivers_license <> ri.drivers_license;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_reported_date := le.reported_date <> ri.reported_date;
    SELF.Diff_file_type := le.file_type <> ri.file_type;
    SELF.Diff_deceitful_confidence := le.deceitful_confidence <> ri.deceitful_confidence;
    SELF.Diff_reported_by := le.reported_by <> ri.reported_by;
    SELF.Diff_reason_description := le.reason_description <> ri.reason_description;
    SELF.Diff_event_type_1 := le.event_type_1 <> ri.event_type_1;
    SELF.Diff_event_entity_1 := le.event_entity_1 <> ri.event_entity_1;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_inqlog_id,1,0)+ IF( SELF.Diff_customer_id,1,0)+ IF( SELF.Diff_transaction_id,1,0)+ IF( SELF.Diff_date_of_transaction,1,0)+ IF( SELF.Diff_household_id,1,0)+ IF( SELF.Diff_customer_person_id,1,0)+ IF( SELF.Diff_customer_program,1,0)+ IF( SELF.Diff_reason_for_transaction_activity,1,0)+ IF( SELF.Diff_inquiry_source,1,0)+ IF( SELF.Diff_customer_county,1,0)+ IF( SELF.Diff_customer_state,1,0)+ IF( SELF.Diff_customer_agency_vertical_type,1,0)+ IF( SELF.Diff_ssn,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_rawlinkid,1,0)+ IF( SELF.Diff_raw_full_name,1,0)+ IF( SELF.Diff_raw_title,1,0)+ IF( SELF.Diff_raw_first_name,1,0)+ IF( SELF.Diff_raw_middle_name,1,0)+ IF( SELF.Diff_raw_last_name,1,0)+ IF( SELF.Diff_raw_orig_suffix,1,0)+ IF( SELF.Diff_full_address,1,0)+ IF( SELF.Diff_street_1,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_mailing_street_1,1,0)+ IF( SELF.Diff_mailing_city,1,0)+ IF( SELF.Diff_mailing_state,1,0)+ IF( SELF.Diff_mailing_zip,1,0)+ IF( SELF.Diff_mailing_county,1,0)+ IF( SELF.Diff_phone_number,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_tin,1,0)+ IF( SELF.Diff_email_address,1,0)+ IF( SELF.Diff_appended_provider_id,1,0)+ IF( SELF.Diff_lnpid,1,0)+ IF( SELF.Diff_npi,1,0)+ IF( SELF.Diff_ip_address,1,0)+ IF( SELF.Diff_device_id,1,0)+ IF( SELF.Diff_professional_id,1,0)+ IF( SELF.Diff_bank_routing_number_1,1,0)+ IF( SELF.Diff_bank_account_number_1,1,0)+ IF( SELF.Diff_drivers_license_state,1,0)+ IF( SELF.Diff_drivers_license,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_reported_date,1,0)+ IF( SELF.Diff_file_type,1,0)+ IF( SELF.Diff_deceitful_confidence,1,0)+ IF( SELF.Diff_reported_by,1,0)+ IF( SELF.Diff_reason_description,1,0)+ IF( SELF.Diff_event_type_1,1,0)+ IF( SELF.Diff_event_entity_1,1,0);
  END;
// Now need to remove bad pivots from comparison
#uniquename(L)
  %L% := JOIN(in_left,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(R)
  %R% := JOIN(in_right,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(DiffL)
  %DiffL% := JOIN(%L%,%R%,evaluate(left,pivot_exp)=evaluate(right,pivot_exp),%fd%(left,right),hash);
#uniquename(Closest)
  %Closest% := DEDUP(SORT(%DiffL%,Val,Num_Diffs,local),Val,local); // Join will have distributed by pivot_exp
#uniquename(AggRec)
  %AggRec% := RECORD
    Count_Diff_inqlog_id := COUNT(GROUP,%Closest%.Diff_inqlog_id);
    Count_Diff_customer_id := COUNT(GROUP,%Closest%.Diff_customer_id);
    Count_Diff_transaction_id := COUNT(GROUP,%Closest%.Diff_transaction_id);
    Count_Diff_date_of_transaction := COUNT(GROUP,%Closest%.Diff_date_of_transaction);
    Count_Diff_household_id := COUNT(GROUP,%Closest%.Diff_household_id);
    Count_Diff_customer_person_id := COUNT(GROUP,%Closest%.Diff_customer_person_id);
    Count_Diff_customer_program := COUNT(GROUP,%Closest%.Diff_customer_program);
    Count_Diff_reason_for_transaction_activity := COUNT(GROUP,%Closest%.Diff_reason_for_transaction_activity);
    Count_Diff_inquiry_source := COUNT(GROUP,%Closest%.Diff_inquiry_source);
    Count_Diff_customer_county := COUNT(GROUP,%Closest%.Diff_customer_county);
    Count_Diff_customer_state := COUNT(GROUP,%Closest%.Diff_customer_state);
    Count_Diff_customer_agency_vertical_type := COUNT(GROUP,%Closest%.Diff_customer_agency_vertical_type);
    Count_Diff_ssn := COUNT(GROUP,%Closest%.Diff_ssn);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_rawlinkid := COUNT(GROUP,%Closest%.Diff_rawlinkid);
    Count_Diff_raw_full_name := COUNT(GROUP,%Closest%.Diff_raw_full_name);
    Count_Diff_raw_title := COUNT(GROUP,%Closest%.Diff_raw_title);
    Count_Diff_raw_first_name := COUNT(GROUP,%Closest%.Diff_raw_first_name);
    Count_Diff_raw_middle_name := COUNT(GROUP,%Closest%.Diff_raw_middle_name);
    Count_Diff_raw_last_name := COUNT(GROUP,%Closest%.Diff_raw_last_name);
    Count_Diff_raw_orig_suffix := COUNT(GROUP,%Closest%.Diff_raw_orig_suffix);
    Count_Diff_full_address := COUNT(GROUP,%Closest%.Diff_full_address);
    Count_Diff_street_1 := COUNT(GROUP,%Closest%.Diff_street_1);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_mailing_street_1 := COUNT(GROUP,%Closest%.Diff_mailing_street_1);
    Count_Diff_mailing_city := COUNT(GROUP,%Closest%.Diff_mailing_city);
    Count_Diff_mailing_state := COUNT(GROUP,%Closest%.Diff_mailing_state);
    Count_Diff_mailing_zip := COUNT(GROUP,%Closest%.Diff_mailing_zip);
    Count_Diff_mailing_county := COUNT(GROUP,%Closest%.Diff_mailing_county);
    Count_Diff_phone_number := COUNT(GROUP,%Closest%.Diff_phone_number);
    Count_Diff_ultid := COUNT(GROUP,%Closest%.Diff_ultid);
    Count_Diff_orgid := COUNT(GROUP,%Closest%.Diff_orgid);
    Count_Diff_seleid := COUNT(GROUP,%Closest%.Diff_seleid);
    Count_Diff_tin := COUNT(GROUP,%Closest%.Diff_tin);
    Count_Diff_email_address := COUNT(GROUP,%Closest%.Diff_email_address);
    Count_Diff_appended_provider_id := COUNT(GROUP,%Closest%.Diff_appended_provider_id);
    Count_Diff_lnpid := COUNT(GROUP,%Closest%.Diff_lnpid);
    Count_Diff_npi := COUNT(GROUP,%Closest%.Diff_npi);
    Count_Diff_ip_address := COUNT(GROUP,%Closest%.Diff_ip_address);
    Count_Diff_device_id := COUNT(GROUP,%Closest%.Diff_device_id);
    Count_Diff_professional_id := COUNT(GROUP,%Closest%.Diff_professional_id);
    Count_Diff_bank_routing_number_1 := COUNT(GROUP,%Closest%.Diff_bank_routing_number_1);
    Count_Diff_bank_account_number_1 := COUNT(GROUP,%Closest%.Diff_bank_account_number_1);
    Count_Diff_drivers_license_state := COUNT(GROUP,%Closest%.Diff_drivers_license_state);
    Count_Diff_drivers_license := COUNT(GROUP,%Closest%.Diff_drivers_license);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_reported_date := COUNT(GROUP,%Closest%.Diff_reported_date);
    Count_Diff_file_type := COUNT(GROUP,%Closest%.Diff_file_type);
    Count_Diff_deceitful_confidence := COUNT(GROUP,%Closest%.Diff_deceitful_confidence);
    Count_Diff_reported_by := COUNT(GROUP,%Closest%.Diff_reported_by);
    Count_Diff_reason_description := COUNT(GROUP,%Closest%.Diff_reason_description);
    Count_Diff_event_type_1 := COUNT(GROUP,%Closest%.Diff_event_type_1);
    Count_Diff_event_entity_1 := COUNT(GROUP,%Closest%.Diff_event_entity_1);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
