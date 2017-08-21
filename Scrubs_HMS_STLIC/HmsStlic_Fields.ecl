IMPORT ut,SALT31;
EXPORT HmsStlic_Fields := MODULE
// Processing for each FieldType
EXPORT SALT31.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'ln_key','hms_src','key','id','entityid','license_number','license_class_type','license_state','status','issue_date','expiration_date','qualifier1','qualifier2','qualifier3','qualifier4','qualifier5','rawclass','rawissue_date','rawexpiration_date','rawstatus','raw_number','name','first','middle','last','suffix','cred','age','dateofbirth','email','gender','dateofdeath','firmname','street1','street2','street3','city','address_state','orig_zip','orig_county','country','address_type','phone1','phone2','phone3','fax1','fax2','fax3','other_phone1','description','specialty_class_type','phone_number','phone_type','language','graduated','school','location','board','offense','offense_date','action','action_date','action_start','action_end','npi_number','csr_number','dea_number','prepped_addr1','prepped_addr2','clean_phone','clean_phone1','clean_phone2','clean_phone3','clean_fax1','clean_fax2','clean_fax3','clean_other_phone1','clean_dateofbirth','clean_dateofdeath','clean_company_name','clean_issue_date','clean_expiration_date','clean_offense_date','clean_action_date','src','zip','zip4','bdid','bdid_score','lnpid','did','did_score','dt_vendor_first_reported','dt_vendor_last_reported','in_state','in_class','in_status','in_qualifier1','in_qualifier2','mapped_state','mapped_class','mapped_status','mapped_qualifier1','mapped_qualifier2','mapped_pdma','mapped_pract_type','source_code','taxonomy_code');
EXPORT FieldTypeNum(SALT31.StrType fn) := CASE(fn,'ln_key' => 1,'hms_src' => 2,'key' => 3,'id' => 4,'entityid' => 5,'license_number' => 6,'license_class_type' => 7,'license_state' => 8,'status' => 9,'issue_date' => 10,'expiration_date' => 11,'qualifier1' => 12,'qualifier2' => 13,'qualifier3' => 14,'qualifier4' => 15,'qualifier5' => 16,'rawclass' => 17,'rawissue_date' => 18,'rawexpiration_date' => 19,'rawstatus' => 20,'raw_number' => 21,'name' => 22,'first' => 23,'middle' => 24,'last' => 25,'suffix' => 26,'cred' => 27,'age' => 28,'dateofbirth' => 29,'email' => 30,'gender' => 31,'dateofdeath' => 32,'firmname' => 33,'street1' => 34,'street2' => 35,'street3' => 36,'city' => 37,'address_state' => 38,'orig_zip' => 39,'orig_county' => 40,'country' => 41,'address_type' => 42,'phone1' => 43,'phone2' => 44,'phone3' => 45,'fax1' => 46,'fax2' => 47,'fax3' => 48,'other_phone1' => 49,'description' => 50,'specialty_class_type' => 51,'phone_number' => 52,'phone_type' => 53,'language' => 54,'graduated' => 55,'school' => 56,'location' => 57,'board' => 58,'offense' => 59,'offense_date' => 60,'action' => 61,'action_date' => 62,'action_start' => 63,'action_end' => 64,'npi_number' => 65,'csr_number' => 66,'dea_number' => 67,'prepped_addr1' => 68,'prepped_addr2' => 69,'clean_phone' => 70,'clean_phone1' => 71,'clean_phone2' => 72,'clean_phone3' => 73,'clean_fax1' => 74,'clean_fax2' => 75,'clean_fax3' => 76,'clean_other_phone1' => 77,'clean_dateofbirth' => 78,'clean_dateofdeath' => 79,'clean_company_name' => 80,'clean_issue_date' => 81,'clean_expiration_date' => 82,'clean_offense_date' => 83,'clean_action_date' => 84,'src' => 85,'zip' => 86,'zip4' => 87,'bdid' => 88,'bdid_score' => 89,'lnpid' => 90,'did' => 91,'did_score' => 92,'dt_vendor_first_reported' => 93,'dt_vendor_last_reported' => 94,'in_state' => 95,'in_class' => 96,'in_status' => 97,'in_qualifier1' => 98,'in_qualifier2' => 99,'mapped_state' => 100,'mapped_class' => 101,'mapped_status' => 102,'mapped_qualifier1' => 103,'mapped_qualifier2' => 104,'mapped_pdma' => 105,'mapped_pract_type' => 106,'source_code' => 107,'taxonomy_code' => 108,0);
EXPORT MakeFT_ln_key(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' -._0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_ln_key(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' -._0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_ln_key(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' -._0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_hms_src(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_hms_src(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_hms_src(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('1..'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_key(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' -._0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_key(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' -._0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_key(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' -._0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_id(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_id(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_id(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('1..'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_entityid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_entityid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwyz '))),~(LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_entityid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwyz '),SALT31.HygieneErrors.NotLength('1..'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_license_number(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_license_number(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_license_number(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_license_class_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' (),-&_.\'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_license_class_type(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' (),-&_.\'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_license_class_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' (),-&_.\'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_license_state(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_license_state(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_license_state(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_status(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' :()*-.&_/01234568789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_status(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' :()*-.&_/01234568789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_status(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' :()*-.&_/01234568789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_issue_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' -/0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_issue_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' -/0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_issue_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' -/0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('0,4..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_expiration_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' -/0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_expiration_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' -/0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_expiration_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' -/0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('0,4..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_qualifier1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ()*-._\'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_qualifier1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ()*-._\'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_qualifier1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ()*-._\'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_qualifier2(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ()*-._\'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_qualifier2(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ()*-._\'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_qualifier2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ()*-._\'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_qualifier3(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ()*-._\'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_qualifier3(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ()*-._\'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_qualifier3(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ()*-._\'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_qualifier4(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ()*-._\'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_qualifier4(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ()*-._\'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_qualifier4(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ()*-._\'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_qualifier5(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ()*-._\'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_qualifier5(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ()*-._\'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_qualifier5(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ()*-._\'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_rawclass(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' (),-&_.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_rawclass(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' (),-&_.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_rawclass(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' (),-&_.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_rawissue_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' "-/0123456789:=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_rawissue_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' "-/0123456789:=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_rawissue_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' "-/0123456789:=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('0,4..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_rawexpiration_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' "-/0123456789:=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_rawexpiration_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' "-/0123456789:=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_rawexpiration_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' "-/0123456789:=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('0,4..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_rawstatus(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' :()*-.&_/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_rawstatus(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' :()*-.&_/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_rawstatus(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' :()*-.&_/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_raw_number(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'"-.0123456789=ABCDEFGHIJKLMNOPQRSTUVWXYZacdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_raw_number(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'"-.0123456789=ABCDEFGHIJKLMNOPQRSTUVWXYZacdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_raw_number(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('"-.0123456789=ABCDEFGHIJKLMNOPQRSTUVWXYZacdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ,-.\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ,-.\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ,-.\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_first(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' -.\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_first(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' -.\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_first(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' -.\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_middle(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' -.\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_middle(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' -.\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_middle(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' -.\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_last(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' -.\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_last(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' -.\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_last(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' -.\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_suffix(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'()./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_suffix(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'()./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('()./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_cred(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ,-.ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_cred(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ,-.ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_cred(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ,-.ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_age(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_age(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1 AND LENGTH(TRIM(s)) <= 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_age(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0 '),SALT31.HygieneErrors.NotLength('0,1..3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dateofbirth(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' -/0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dateofbirth(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' -/0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dateofbirth(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' -/0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('0,4..'),SALT31.HygieneErrors.NotWords('0,1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_email(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'*-_.0123456789@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_email(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'*-_.0123456789@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_email(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('*-_.0123456789@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('0,3..'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_gender(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'FMU '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_gender(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'FMU '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_gender(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('FMU '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dateofdeath(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' -/0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dateofdeath(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' -/0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dateofdeath(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' -/0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('0,4..'),SALT31.HygieneErrors.NotWords('0,1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_firmname(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' #\',-/.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_firmname(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' #\',-/.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_firmname(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' #\',-/.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_street1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' #\',-./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_street1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' #\',-./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_street1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' #\',-./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_street2(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' #\',-./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_street2(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' #\',-./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_street2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' #\',-./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_street3(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' #\',-./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_street3(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' #\',-./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_street3(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' #\',-./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_city(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' #\',-/.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZacdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_city(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' #\',-/.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZacdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_city(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' #\',-/.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZacdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_address_state(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_address_state(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_address_state(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_orig_zip(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' -0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_zip(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' -0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 5 AND LENGTH(TRIM(s)) <= 10),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_orig_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' -0123456789 '),SALT31.HygieneErrors.NotLength('0,5..10'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_orig_county(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' -.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_orig_county(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' -.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_orig_county(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' -.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_country(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' -.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_country(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' -.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_country(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' -.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_address_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_address_type(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_address_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_phone1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ()*-0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_phone1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ()*-0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 10 AND LENGTH(TRIM(s)) <= 15),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_phone1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ()*-0123456789 '),SALT31.HygieneErrors.NotLength('0,10..15'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_phone2(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ()*-0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_phone2(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ()*-0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 10 AND LENGTH(TRIM(s)) <= 15),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_phone2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ()*-0123456789 '),SALT31.HygieneErrors.NotLength('0,10..15'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_phone3(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ()*-0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_phone3(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ()*-0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 10 AND LENGTH(TRIM(s)) <= 15),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_phone3(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ()*-0123456789 '),SALT31.HygieneErrors.NotLength('0,10..15'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_fax1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'()*-0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_fax1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'()*-0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 10 AND LENGTH(TRIM(s)) <= 15),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_fax1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('()*-0123456789 '),SALT31.HygieneErrors.NotLength('0,10..15'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_fax2(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'()*-0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_fax2(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'()*-0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 10 AND LENGTH(TRIM(s)) <= 15),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_fax2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('()*-0123456789 '),SALT31.HygieneErrors.NotLength('0,10..15'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_fax3(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'()*-0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_fax3(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'()*-0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 10 AND LENGTH(TRIM(s)) <= 15),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_fax3(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('()*-0123456789 '),SALT31.HygieneErrors.NotLength('0,10..15'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_other_phone1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ()*-0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_phone1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ()*-0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 10 AND LENGTH(TRIM(s)) <= 15),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_phone1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ()*-0123456789 '),SALT31.HygieneErrors.NotLength('0,10..15'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_description(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ()&*,-./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_description(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ()&*,-./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_description(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ()&*,-./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_specialty_class_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ()-012345689ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefhijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_specialty_class_type(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ()-012345689ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefhijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_specialty_class_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ()-012345689ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefhijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_phone_number(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ()-0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_phone_number(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ()-0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 10 AND LENGTH(TRIM(s)) <= 15),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_phone_number(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ()-0123456789 '),SALT31.HygieneErrors.NotLength('0,10..15'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_phone_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-.0123456789_ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_phone_type(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-.0123456789_ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_phone_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-.0123456789_ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_language(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_language(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_language(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_graduated(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_graduated(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_graduated(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_school(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_school(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_school(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_location(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_location(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_location(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_board(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_board(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_board(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_offense(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ()-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_offense(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ()-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_offense(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ()-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_offense_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-/0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_offense_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-/0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_offense_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-/0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('0,4..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_action(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ()-ABCDEFGHIJKLMNOPQRSTUVWXYZacdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_action(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ()-ABCDEFGHIJKLMNOPQRSTUVWXYZacdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_action(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ()-ABCDEFGHIJKLMNOPQRSTUVWXYZacdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_action_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'/0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_action_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'/0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_action_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('/0123456789 '),SALT31.HygieneErrors.NotLength('0,4..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_action_start(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'/0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_action_start(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'/0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_action_start(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('/0123456789 '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_action_end(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_action_end(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_action_end(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_npi_number(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_npi_number(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_npi_number(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_csr_number(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_csr_number(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_csr_number(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dea_number(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dea_number(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dea_number(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_prepped_addr1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' () #,-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prepped_addr1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' () #,-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_prepped_addr1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' () #,-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_prepped_addr2(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' () #,-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prepped_addr2(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' () #,-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_prepped_addr2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' () #,-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_phone(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_phone(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_clean_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,10'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_phone1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_phone1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_clean_phone1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,10'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_phone2(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_phone2(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_clean_phone2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_phone3(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_phone3(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_clean_phone3(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_fax1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_fax1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_clean_fax1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,10'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_fax2(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_fax2(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_clean_fax2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0,10'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_fax3(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_fax3(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_clean_fax3(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0,10'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_other_phone1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_other_phone1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_clean_other_phone1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,10'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_dateofbirth(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_dateofbirth(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_clean_dateofbirth(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,8'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_dateofdeath(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_dateofdeath(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0 '))),~(LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_clean_dateofdeath(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0 '),SALT31.HygieneErrors.NotLength('0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_company_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ()_-,.#0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_company_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ()_-,.#0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_clean_company_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ()_-,.#0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_issue_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_issue_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_clean_issue_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('8,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_expiration_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_expiration_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_clean_expiration_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('8,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_offense_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_offense_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_clean_offense_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_action_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_action_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_clean_action_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_src(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_src(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_src(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('1..'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_zip(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_zip(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,5'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_zip4(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_zip4(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_bdid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_bdid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_bdid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_bdid_score(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_bdid_score(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_bdid_score(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0 '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_lnpid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lnpid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_lnpid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_did(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_did(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_did(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_did_score(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_did_score(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_did_score(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dt_vendor_first_reported(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dt_vendor_first_reported(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dt_vendor_first_reported(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('8'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dt_vendor_last_reported(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dt_vendor_last_reported(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dt_vendor_last_reported(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('8'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_in_state(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_in_state(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_in_state(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_in_class(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_in_class(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_in_class(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_in_status(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_in_status(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_in_status(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_in_qualifier1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_in_qualifier1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_in_qualifier1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_in_qualifier2(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_in_qualifier2(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_in_qualifier2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_mapped_state(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_mapped_state(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_mapped_state(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_mapped_class(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_mapped_class(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_mapped_class(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_mapped_status(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_mapped_status(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_mapped_status(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_mapped_qualifier1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_mapped_qualifier1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_mapped_qualifier1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_mapped_qualifier2(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_mapped_qualifier2(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_mapped_qualifier2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_mapped_pdma(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_mapped_pdma(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_mapped_pdma(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_mapped_pract_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_mapped_pract_type(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_mapped_pract_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_source_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_source_code(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_source_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_taxonomy_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_taxonomy_code(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_taxonomy_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT SALT31.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'ln_key','hms_src','key','id','entityid','license_number','license_class_type','license_state','status','issue_date','expiration_date','qualifier1','qualifier2','qualifier3','qualifier4','qualifier5','rawclass','rawissue_date','rawexpiration_date','rawstatus','raw_number','name','first','middle','last','suffix','cred','age','dateofbirth','email','gender','dateofdeath','firmname','street1','street2','street3','city','address_state','orig_zip','orig_county','country','address_type','phone1','phone2','phone3','fax1','fax2','fax3','other_phone1','description','specialty_class_type','phone_number','phone_type','language','graduated','school','location','board','offense','offense_date','action','action_date','action_start','action_end','npi_number','csr_number','dea_number','prepped_addr1','prepped_addr2','clean_phone','clean_phone1','clean_phone2','clean_phone3','clean_fax1','clean_fax2','clean_fax3','clean_other_phone1','clean_dateofbirth','clean_dateofdeath','clean_company_name','clean_issue_date','clean_expiration_date','clean_offense_date','clean_action_date','src','zip','zip4','bdid','bdid_score','lnpid','did','did_score','dt_vendor_first_reported','dt_vendor_last_reported','in_state','in_class','in_status','in_qualifier1','in_qualifier2','mapped_class','mapped_status','mapped_qualifier1','mapped_qualifier2','mapped_pdma','mapped_pract_type','source_code','taxonomy_code');
EXPORT FieldNum(SALT31.StrType fn) := CASE(fn,'ln_key' => 1,'hms_src' => 2,'key' => 3,'id' => 4,'entityid' => 5,'license_number' => 6,'license_class_type' => 7,'license_state' => 8,'status' => 9,'issue_date' => 10,'expiration_date' => 11,'qualifier1' => 12,'qualifier2' => 13,'qualifier3' => 14,'qualifier4' => 15,'qualifier5' => 16,'rawclass' => 17,'rawissue_date' => 18,'rawexpiration_date' => 19,'rawstatus' => 20,'raw_number' => 21,'name' => 22,'first' => 23,'middle' => 24,'last' => 25,'suffix' => 26,'cred' => 27,'age' => 28,'dateofbirth' => 29,'email' => 30,'gender' => 31,'dateofdeath' => 32,'firmname' => 33,'street1' => 34,'street2' => 35,'street3' => 36,'city' => 37,'address_state' => 38,'orig_zip' => 39,'orig_county' => 40,'country' => 41,'address_type' => 42,'phone1' => 43,'phone2' => 44,'phone3' => 45,'fax1' => 46,'fax2' => 47,'fax3' => 48,'other_phone1' => 49,'description' => 50,'specialty_class_type' => 51,'phone_number' => 52,'phone_type' => 53,'language' => 54,'graduated' => 55,'school' => 56,'location' => 57,'board' => 58,'offense' => 59,'offense_date' => 60,'action' => 61,'action_date' => 62,'action_start' => 63,'action_end' => 64,'npi_number' => 65,'csr_number' => 66,'dea_number' => 67,'prepped_addr1' => 68,'prepped_addr2' => 69,'clean_phone' => 70,'clean_phone1' => 71,'clean_phone2' => 72,'clean_phone3' => 73,'clean_fax1' => 74,'clean_fax2' => 75,'clean_fax3' => 76,'clean_other_phone1' => 77,'clean_dateofbirth' => 78,'clean_dateofdeath' => 79,'clean_company_name' => 80,'clean_issue_date' => 81,'clean_expiration_date' => 82,'clean_offense_date' => 83,'clean_action_date' => 84,'src' => 85,'zip' => 86,'zip4' => 87,'bdid' => 88,'bdid_score' => 89,'lnpid' => 90,'did' => 91,'did_score' => 92,'dt_vendor_first_reported' => 93,'dt_vendor_last_reported' => 94,'in_state' => 95,'in_class' => 96,'in_status' => 97,'in_qualifier1' => 98,'in_qualifier2' => 99,'mapped_class' => 100,'mapped_status' => 101,'mapped_qualifier1' => 102,'mapped_qualifier2' => 103,'mapped_pdma' => 104,'mapped_pract_type' => 105,'source_code' => 106,'taxonomy_code' => 107,0);
//Individual field level validation
EXPORT Make_ln_key(SALT31.StrType s0) := MakeFT_ln_key(s0);
EXPORT InValid_ln_key(SALT31.StrType s) := InValidFT_ln_key(s);
EXPORT InValidMessage_ln_key(UNSIGNED1 wh) := InValidMessageFT_ln_key(wh);
EXPORT Make_hms_src(SALT31.StrType s0) := MakeFT_hms_src(s0);
EXPORT InValid_hms_src(SALT31.StrType s) := InValidFT_hms_src(s);
EXPORT InValidMessage_hms_src(UNSIGNED1 wh) := InValidMessageFT_hms_src(wh);
EXPORT Make_key(SALT31.StrType s0) := MakeFT_key(s0);
EXPORT InValid_key(SALT31.StrType s) := InValidFT_key(s);
EXPORT InValidMessage_key(UNSIGNED1 wh) := InValidMessageFT_key(wh);
EXPORT Make_id(SALT31.StrType s0) := MakeFT_id(s0);
EXPORT InValid_id(SALT31.StrType s) := InValidFT_id(s);
EXPORT InValidMessage_id(UNSIGNED1 wh) := InValidMessageFT_id(wh);
EXPORT Make_entityid(SALT31.StrType s0) := MakeFT_entityid(s0);
EXPORT InValid_entityid(SALT31.StrType s) := InValidFT_entityid(s);
EXPORT InValidMessage_entityid(UNSIGNED1 wh) := InValidMessageFT_entityid(wh);
EXPORT Make_license_number(SALT31.StrType s0) := MakeFT_license_number(s0);
EXPORT InValid_license_number(SALT31.StrType s) := InValidFT_license_number(s);
EXPORT InValidMessage_license_number(UNSIGNED1 wh) := InValidMessageFT_license_number(wh);
EXPORT Make_license_class_type(SALT31.StrType s0) := MakeFT_license_class_type(s0);
EXPORT InValid_license_class_type(SALT31.StrType s) := InValidFT_license_class_type(s);
EXPORT InValidMessage_license_class_type(UNSIGNED1 wh) := InValidMessageFT_license_class_type(wh);
EXPORT Make_license_state(SALT31.StrType s0) := MakeFT_license_state(s0);
EXPORT InValid_license_state(SALT31.StrType s) := InValidFT_license_state(s);
EXPORT InValidMessage_license_state(UNSIGNED1 wh) := InValidMessageFT_license_state(wh);
EXPORT Make_status(SALT31.StrType s0) := MakeFT_status(s0);
EXPORT InValid_status(SALT31.StrType s) := InValidFT_status(s);
EXPORT InValidMessage_status(UNSIGNED1 wh) := InValidMessageFT_status(wh);
EXPORT Make_issue_date(SALT31.StrType s0) := MakeFT_issue_date(s0);
EXPORT InValid_issue_date(SALT31.StrType s) := InValidFT_issue_date(s);
EXPORT InValidMessage_issue_date(UNSIGNED1 wh) := InValidMessageFT_issue_date(wh);
EXPORT Make_expiration_date(SALT31.StrType s0) := MakeFT_expiration_date(s0);
EXPORT InValid_expiration_date(SALT31.StrType s) := InValidFT_expiration_date(s);
EXPORT InValidMessage_expiration_date(UNSIGNED1 wh) := InValidMessageFT_expiration_date(wh);
EXPORT Make_qualifier1(SALT31.StrType s0) := MakeFT_qualifier1(s0);
EXPORT InValid_qualifier1(SALT31.StrType s) := InValidFT_qualifier1(s);
EXPORT InValidMessage_qualifier1(UNSIGNED1 wh) := InValidMessageFT_qualifier1(wh);
EXPORT Make_qualifier2(SALT31.StrType s0) := MakeFT_qualifier2(s0);
EXPORT InValid_qualifier2(SALT31.StrType s) := InValidFT_qualifier2(s);
EXPORT InValidMessage_qualifier2(UNSIGNED1 wh) := InValidMessageFT_qualifier2(wh);
EXPORT Make_qualifier3(SALT31.StrType s0) := MakeFT_qualifier3(s0);
EXPORT InValid_qualifier3(SALT31.StrType s) := InValidFT_qualifier3(s);
EXPORT InValidMessage_qualifier3(UNSIGNED1 wh) := InValidMessageFT_qualifier3(wh);
EXPORT Make_qualifier4(SALT31.StrType s0) := MakeFT_qualifier4(s0);
EXPORT InValid_qualifier4(SALT31.StrType s) := InValidFT_qualifier4(s);
EXPORT InValidMessage_qualifier4(UNSIGNED1 wh) := InValidMessageFT_qualifier4(wh);
EXPORT Make_qualifier5(SALT31.StrType s0) := MakeFT_qualifier5(s0);
EXPORT InValid_qualifier5(SALT31.StrType s) := InValidFT_qualifier5(s);
EXPORT InValidMessage_qualifier5(UNSIGNED1 wh) := InValidMessageFT_qualifier5(wh);
EXPORT Make_rawclass(SALT31.StrType s0) := MakeFT_rawclass(s0);
EXPORT InValid_rawclass(SALT31.StrType s) := InValidFT_rawclass(s);
EXPORT InValidMessage_rawclass(UNSIGNED1 wh) := InValidMessageFT_rawclass(wh);
EXPORT Make_rawissue_date(SALT31.StrType s0) := MakeFT_rawissue_date(s0);
EXPORT InValid_rawissue_date(SALT31.StrType s) := InValidFT_rawissue_date(s);
EXPORT InValidMessage_rawissue_date(UNSIGNED1 wh) := InValidMessageFT_rawissue_date(wh);
EXPORT Make_rawexpiration_date(SALT31.StrType s0) := MakeFT_rawexpiration_date(s0);
EXPORT InValid_rawexpiration_date(SALT31.StrType s) := InValidFT_rawexpiration_date(s);
EXPORT InValidMessage_rawexpiration_date(UNSIGNED1 wh) := InValidMessageFT_rawexpiration_date(wh);
EXPORT Make_rawstatus(SALT31.StrType s0) := MakeFT_rawstatus(s0);
EXPORT InValid_rawstatus(SALT31.StrType s) := InValidFT_rawstatus(s);
EXPORT InValidMessage_rawstatus(UNSIGNED1 wh) := InValidMessageFT_rawstatus(wh);
EXPORT Make_raw_number(SALT31.StrType s0) := MakeFT_raw_number(s0);
EXPORT InValid_raw_number(SALT31.StrType s) := InValidFT_raw_number(s);
EXPORT InValidMessage_raw_number(UNSIGNED1 wh) := InValidMessageFT_raw_number(wh);
EXPORT Make_name(SALT31.StrType s0) := MakeFT_name(s0);
EXPORT InValid_name(SALT31.StrType s) := InValidFT_name(s);
EXPORT InValidMessage_name(UNSIGNED1 wh) := InValidMessageFT_name(wh);
EXPORT Make_first(SALT31.StrType s0) := MakeFT_first(s0);
EXPORT InValid_first(SALT31.StrType s) := InValidFT_first(s);
EXPORT InValidMessage_first(UNSIGNED1 wh) := InValidMessageFT_first(wh);
EXPORT Make_middle(SALT31.StrType s0) := MakeFT_middle(s0);
EXPORT InValid_middle(SALT31.StrType s) := InValidFT_middle(s);
EXPORT InValidMessage_middle(UNSIGNED1 wh) := InValidMessageFT_middle(wh);
EXPORT Make_last(SALT31.StrType s0) := MakeFT_last(s0);
EXPORT InValid_last(SALT31.StrType s) := InValidFT_last(s);
EXPORT InValidMessage_last(UNSIGNED1 wh) := InValidMessageFT_last(wh);
EXPORT Make_suffix(SALT31.StrType s0) := MakeFT_suffix(s0);
EXPORT InValid_suffix(SALT31.StrType s) := InValidFT_suffix(s);
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := InValidMessageFT_suffix(wh);
EXPORT Make_cred(SALT31.StrType s0) := MakeFT_cred(s0);
EXPORT InValid_cred(SALT31.StrType s) := InValidFT_cred(s);
EXPORT InValidMessage_cred(UNSIGNED1 wh) := InValidMessageFT_cred(wh);
EXPORT Make_age(SALT31.StrType s0) := MakeFT_age(s0);
EXPORT InValid_age(SALT31.StrType s) := InValidFT_age(s);
EXPORT InValidMessage_age(UNSIGNED1 wh) := InValidMessageFT_age(wh);
EXPORT Make_dateofbirth(SALT31.StrType s0) := MakeFT_dateofbirth(s0);
EXPORT InValid_dateofbirth(SALT31.StrType s) := InValidFT_dateofbirth(s);
EXPORT InValidMessage_dateofbirth(UNSIGNED1 wh) := InValidMessageFT_dateofbirth(wh);
EXPORT Make_email(SALT31.StrType s0) := MakeFT_email(s0);
EXPORT InValid_email(SALT31.StrType s) := InValidFT_email(s);
EXPORT InValidMessage_email(UNSIGNED1 wh) := InValidMessageFT_email(wh);
EXPORT Make_gender(SALT31.StrType s0) := MakeFT_gender(s0);
EXPORT InValid_gender(SALT31.StrType s) := InValidFT_gender(s);
EXPORT InValidMessage_gender(UNSIGNED1 wh) := InValidMessageFT_gender(wh);
EXPORT Make_dateofdeath(SALT31.StrType s0) := MakeFT_dateofdeath(s0);
EXPORT InValid_dateofdeath(SALT31.StrType s) := InValidFT_dateofdeath(s);
EXPORT InValidMessage_dateofdeath(UNSIGNED1 wh) := InValidMessageFT_dateofdeath(wh);
EXPORT Make_firmname(SALT31.StrType s0) := MakeFT_firmname(s0);
EXPORT InValid_firmname(SALT31.StrType s) := InValidFT_firmname(s);
EXPORT InValidMessage_firmname(UNSIGNED1 wh) := InValidMessageFT_firmname(wh);
EXPORT Make_street1(SALT31.StrType s0) := MakeFT_street1(s0);
EXPORT InValid_street1(SALT31.StrType s) := InValidFT_street1(s);
EXPORT InValidMessage_street1(UNSIGNED1 wh) := InValidMessageFT_street1(wh);
EXPORT Make_street2(SALT31.StrType s0) := MakeFT_street2(s0);
EXPORT InValid_street2(SALT31.StrType s) := InValidFT_street2(s);
EXPORT InValidMessage_street2(UNSIGNED1 wh) := InValidMessageFT_street2(wh);
EXPORT Make_street3(SALT31.StrType s0) := MakeFT_street3(s0);
EXPORT InValid_street3(SALT31.StrType s) := InValidFT_street3(s);
EXPORT InValidMessage_street3(UNSIGNED1 wh) := InValidMessageFT_street3(wh);
EXPORT Make_city(SALT31.StrType s0) := MakeFT_city(s0);
EXPORT InValid_city(SALT31.StrType s) := InValidFT_city(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_city(wh);
EXPORT Make_address_state(SALT31.StrType s0) := MakeFT_address_state(s0);
EXPORT InValid_address_state(SALT31.StrType s) := InValidFT_address_state(s);
EXPORT InValidMessage_address_state(UNSIGNED1 wh) := InValidMessageFT_address_state(wh);
EXPORT Make_orig_zip(SALT31.StrType s0) := MakeFT_orig_zip(s0);
EXPORT InValid_orig_zip(SALT31.StrType s) := InValidFT_orig_zip(s);
EXPORT InValidMessage_orig_zip(UNSIGNED1 wh) := InValidMessageFT_orig_zip(wh);
EXPORT Make_orig_county(SALT31.StrType s0) := MakeFT_orig_county(s0);
EXPORT InValid_orig_county(SALT31.StrType s) := InValidFT_orig_county(s);
EXPORT InValidMessage_orig_county(UNSIGNED1 wh) := InValidMessageFT_orig_county(wh);
EXPORT Make_country(SALT31.StrType s0) := MakeFT_country(s0);
EXPORT InValid_country(SALT31.StrType s) := InValidFT_country(s);
EXPORT InValidMessage_country(UNSIGNED1 wh) := InValidMessageFT_country(wh);
EXPORT Make_address_type(SALT31.StrType s0) := MakeFT_address_type(s0);
EXPORT InValid_address_type(SALT31.StrType s) := InValidFT_address_type(s);
EXPORT InValidMessage_address_type(UNSIGNED1 wh) := InValidMessageFT_address_type(wh);
EXPORT Make_phone1(SALT31.StrType s0) := MakeFT_phone1(s0);
EXPORT InValid_phone1(SALT31.StrType s) := InValidFT_phone1(s);
EXPORT InValidMessage_phone1(UNSIGNED1 wh) := InValidMessageFT_phone1(wh);
EXPORT Make_phone2(SALT31.StrType s0) := MakeFT_phone2(s0);
EXPORT InValid_phone2(SALT31.StrType s) := InValidFT_phone2(s);
EXPORT InValidMessage_phone2(UNSIGNED1 wh) := InValidMessageFT_phone2(wh);
EXPORT Make_phone3(SALT31.StrType s0) := MakeFT_phone3(s0);
EXPORT InValid_phone3(SALT31.StrType s) := InValidFT_phone3(s);
EXPORT InValidMessage_phone3(UNSIGNED1 wh) := InValidMessageFT_phone3(wh);
EXPORT Make_fax1(SALT31.StrType s0) := MakeFT_fax1(s0);
EXPORT InValid_fax1(SALT31.StrType s) := InValidFT_fax1(s);
EXPORT InValidMessage_fax1(UNSIGNED1 wh) := InValidMessageFT_fax1(wh);
EXPORT Make_fax2(SALT31.StrType s0) := MakeFT_fax2(s0);
EXPORT InValid_fax2(SALT31.StrType s) := InValidFT_fax2(s);
EXPORT InValidMessage_fax2(UNSIGNED1 wh) := InValidMessageFT_fax2(wh);
EXPORT Make_fax3(SALT31.StrType s0) := MakeFT_fax3(s0);
EXPORT InValid_fax3(SALT31.StrType s) := InValidFT_fax3(s);
EXPORT InValidMessage_fax3(UNSIGNED1 wh) := InValidMessageFT_fax3(wh);
EXPORT Make_other_phone1(SALT31.StrType s0) := MakeFT_other_phone1(s0);
EXPORT InValid_other_phone1(SALT31.StrType s) := InValidFT_other_phone1(s);
EXPORT InValidMessage_other_phone1(UNSIGNED1 wh) := InValidMessageFT_other_phone1(wh);
EXPORT Make_description(SALT31.StrType s0) := MakeFT_description(s0);
EXPORT InValid_description(SALT31.StrType s) := InValidFT_description(s);
EXPORT InValidMessage_description(UNSIGNED1 wh) := InValidMessageFT_description(wh);
EXPORT Make_specialty_class_type(SALT31.StrType s0) := MakeFT_specialty_class_type(s0);
EXPORT InValid_specialty_class_type(SALT31.StrType s) := InValidFT_specialty_class_type(s);
EXPORT InValidMessage_specialty_class_type(UNSIGNED1 wh) := InValidMessageFT_specialty_class_type(wh);
EXPORT Make_phone_number(SALT31.StrType s0) := MakeFT_phone_number(s0);
EXPORT InValid_phone_number(SALT31.StrType s) := InValidFT_phone_number(s);
EXPORT InValidMessage_phone_number(UNSIGNED1 wh) := InValidMessageFT_phone_number(wh);
EXPORT Make_phone_type(SALT31.StrType s0) := MakeFT_phone_type(s0);
EXPORT InValid_phone_type(SALT31.StrType s) := InValidFT_phone_type(s);
EXPORT InValidMessage_phone_type(UNSIGNED1 wh) := InValidMessageFT_phone_type(wh);
EXPORT Make_language(SALT31.StrType s0) := MakeFT_language(s0);
EXPORT InValid_language(SALT31.StrType s) := InValidFT_language(s);
EXPORT InValidMessage_language(UNSIGNED1 wh) := InValidMessageFT_language(wh);
EXPORT Make_graduated(SALT31.StrType s0) := MakeFT_graduated(s0);
EXPORT InValid_graduated(SALT31.StrType s) := InValidFT_graduated(s);
EXPORT InValidMessage_graduated(UNSIGNED1 wh) := InValidMessageFT_graduated(wh);
EXPORT Make_school(SALT31.StrType s0) := MakeFT_school(s0);
EXPORT InValid_school(SALT31.StrType s) := InValidFT_school(s);
EXPORT InValidMessage_school(UNSIGNED1 wh) := InValidMessageFT_school(wh);
EXPORT Make_location(SALT31.StrType s0) := MakeFT_location(s0);
EXPORT InValid_location(SALT31.StrType s) := InValidFT_location(s);
EXPORT InValidMessage_location(UNSIGNED1 wh) := InValidMessageFT_location(wh);
EXPORT Make_board(SALT31.StrType s0) := MakeFT_board(s0);
EXPORT InValid_board(SALT31.StrType s) := InValidFT_board(s);
EXPORT InValidMessage_board(UNSIGNED1 wh) := InValidMessageFT_board(wh);
EXPORT Make_offense(SALT31.StrType s0) := MakeFT_offense(s0);
EXPORT InValid_offense(SALT31.StrType s) := InValidFT_offense(s);
EXPORT InValidMessage_offense(UNSIGNED1 wh) := InValidMessageFT_offense(wh);
EXPORT Make_offense_date(SALT31.StrType s0) := MakeFT_offense_date(s0);
EXPORT InValid_offense_date(SALT31.StrType s) := InValidFT_offense_date(s);
EXPORT InValidMessage_offense_date(UNSIGNED1 wh) := InValidMessageFT_offense_date(wh);
EXPORT Make_action(SALT31.StrType s0) := MakeFT_action(s0);
EXPORT InValid_action(SALT31.StrType s) := InValidFT_action(s);
EXPORT InValidMessage_action(UNSIGNED1 wh) := InValidMessageFT_action(wh);
EXPORT Make_action_date(SALT31.StrType s0) := MakeFT_action_date(s0);
EXPORT InValid_action_date(SALT31.StrType s) := InValidFT_action_date(s);
EXPORT InValidMessage_action_date(UNSIGNED1 wh) := InValidMessageFT_action_date(wh);
EXPORT Make_action_start(SALT31.StrType s0) := MakeFT_action_start(s0);
EXPORT InValid_action_start(SALT31.StrType s) := InValidFT_action_start(s);
EXPORT InValidMessage_action_start(UNSIGNED1 wh) := InValidMessageFT_action_start(wh);
EXPORT Make_action_end(SALT31.StrType s0) := MakeFT_action_end(s0);
EXPORT InValid_action_end(SALT31.StrType s) := InValidFT_action_end(s);
EXPORT InValidMessage_action_end(UNSIGNED1 wh) := InValidMessageFT_action_end(wh);
EXPORT Make_npi_number(SALT31.StrType s0) := MakeFT_npi_number(s0);
EXPORT InValid_npi_number(SALT31.StrType s) := InValidFT_npi_number(s);
EXPORT InValidMessage_npi_number(UNSIGNED1 wh) := InValidMessageFT_npi_number(wh);
EXPORT Make_csr_number(SALT31.StrType s0) := MakeFT_csr_number(s0);
EXPORT InValid_csr_number(SALT31.StrType s) := InValidFT_csr_number(s);
EXPORT InValidMessage_csr_number(UNSIGNED1 wh) := InValidMessageFT_csr_number(wh);
EXPORT Make_dea_number(SALT31.StrType s0) := MakeFT_dea_number(s0);
EXPORT InValid_dea_number(SALT31.StrType s) := InValidFT_dea_number(s);
EXPORT InValidMessage_dea_number(UNSIGNED1 wh) := InValidMessageFT_dea_number(wh);
EXPORT Make_prepped_addr1(SALT31.StrType s0) := MakeFT_prepped_addr1(s0);
EXPORT InValid_prepped_addr1(SALT31.StrType s) := InValidFT_prepped_addr1(s);
EXPORT InValidMessage_prepped_addr1(UNSIGNED1 wh) := InValidMessageFT_prepped_addr1(wh);
EXPORT Make_prepped_addr2(SALT31.StrType s0) := MakeFT_prepped_addr2(s0);
EXPORT InValid_prepped_addr2(SALT31.StrType s) := InValidFT_prepped_addr2(s);
EXPORT InValidMessage_prepped_addr2(UNSIGNED1 wh) := InValidMessageFT_prepped_addr2(wh);
EXPORT Make_clean_phone(SALT31.StrType s0) := MakeFT_clean_phone(s0);
EXPORT InValid_clean_phone(SALT31.StrType s) := InValidFT_clean_phone(s);
EXPORT InValidMessage_clean_phone(UNSIGNED1 wh) := InValidMessageFT_clean_phone(wh);
EXPORT Make_clean_phone1(SALT31.StrType s0) := MakeFT_clean_phone1(s0);
EXPORT InValid_clean_phone1(SALT31.StrType s) := InValidFT_clean_phone1(s);
EXPORT InValidMessage_clean_phone1(UNSIGNED1 wh) := InValidMessageFT_clean_phone1(wh);
EXPORT Make_clean_phone2(SALT31.StrType s0) := MakeFT_clean_phone2(s0);
EXPORT InValid_clean_phone2(SALT31.StrType s) := InValidFT_clean_phone2(s);
EXPORT InValidMessage_clean_phone2(UNSIGNED1 wh) := InValidMessageFT_clean_phone2(wh);
EXPORT Make_clean_phone3(SALT31.StrType s0) := MakeFT_clean_phone3(s0);
EXPORT InValid_clean_phone3(SALT31.StrType s) := InValidFT_clean_phone3(s);
EXPORT InValidMessage_clean_phone3(UNSIGNED1 wh) := InValidMessageFT_clean_phone3(wh);
EXPORT Make_clean_fax1(SALT31.StrType s0) := MakeFT_clean_fax1(s0);
EXPORT InValid_clean_fax1(SALT31.StrType s) := InValidFT_clean_fax1(s);
EXPORT InValidMessage_clean_fax1(UNSIGNED1 wh) := InValidMessageFT_clean_fax1(wh);
EXPORT Make_clean_fax2(SALT31.StrType s0) := MakeFT_clean_fax2(s0);
EXPORT InValid_clean_fax2(SALT31.StrType s) := InValidFT_clean_fax2(s);
EXPORT InValidMessage_clean_fax2(UNSIGNED1 wh) := InValidMessageFT_clean_fax2(wh);
EXPORT Make_clean_fax3(SALT31.StrType s0) := MakeFT_clean_fax3(s0);
EXPORT InValid_clean_fax3(SALT31.StrType s) := InValidFT_clean_fax3(s);
EXPORT InValidMessage_clean_fax3(UNSIGNED1 wh) := InValidMessageFT_clean_fax3(wh);
EXPORT Make_clean_other_phone1(SALT31.StrType s0) := MakeFT_clean_other_phone1(s0);
EXPORT InValid_clean_other_phone1(SALT31.StrType s) := InValidFT_clean_other_phone1(s);
EXPORT InValidMessage_clean_other_phone1(UNSIGNED1 wh) := InValidMessageFT_clean_other_phone1(wh);
EXPORT Make_clean_dateofbirth(SALT31.StrType s0) := MakeFT_clean_dateofbirth(s0);
EXPORT InValid_clean_dateofbirth(SALT31.StrType s) := InValidFT_clean_dateofbirth(s);
EXPORT InValidMessage_clean_dateofbirth(UNSIGNED1 wh) := InValidMessageFT_clean_dateofbirth(wh);
EXPORT Make_clean_dateofdeath(SALT31.StrType s0) := MakeFT_clean_dateofdeath(s0);
EXPORT InValid_clean_dateofdeath(SALT31.StrType s) := InValidFT_clean_dateofdeath(s);
EXPORT InValidMessage_clean_dateofdeath(UNSIGNED1 wh) := InValidMessageFT_clean_dateofdeath(wh);
EXPORT Make_clean_company_name(SALT31.StrType s0) := MakeFT_clean_company_name(s0);
EXPORT InValid_clean_company_name(SALT31.StrType s) := InValidFT_clean_company_name(s);
EXPORT InValidMessage_clean_company_name(UNSIGNED1 wh) := InValidMessageFT_clean_company_name(wh);
EXPORT Make_clean_issue_date(SALT31.StrType s0) := MakeFT_clean_issue_date(s0);
EXPORT InValid_clean_issue_date(SALT31.StrType s) := InValidFT_clean_issue_date(s);
EXPORT InValidMessage_clean_issue_date(UNSIGNED1 wh) := InValidMessageFT_clean_issue_date(wh);
EXPORT Make_clean_expiration_date(SALT31.StrType s0) := MakeFT_clean_expiration_date(s0);
EXPORT InValid_clean_expiration_date(SALT31.StrType s) := InValidFT_clean_expiration_date(s);
EXPORT InValidMessage_clean_expiration_date(UNSIGNED1 wh) := InValidMessageFT_clean_expiration_date(wh);
EXPORT Make_clean_offense_date(SALT31.StrType s0) := MakeFT_clean_offense_date(s0);
EXPORT InValid_clean_offense_date(SALT31.StrType s) := InValidFT_clean_offense_date(s);
EXPORT InValidMessage_clean_offense_date(UNSIGNED1 wh) := InValidMessageFT_clean_offense_date(wh);
EXPORT Make_clean_action_date(SALT31.StrType s0) := MakeFT_clean_action_date(s0);
EXPORT InValid_clean_action_date(SALT31.StrType s) := InValidFT_clean_action_date(s);
EXPORT InValidMessage_clean_action_date(UNSIGNED1 wh) := InValidMessageFT_clean_action_date(wh);
EXPORT Make_src(SALT31.StrType s0) := MakeFT_src(s0);
EXPORT InValid_src(SALT31.StrType s) := InValidFT_src(s);
EXPORT InValidMessage_src(UNSIGNED1 wh) := InValidMessageFT_src(wh);
EXPORT Make_zip(SALT31.StrType s0) := MakeFT_zip(s0);
EXPORT InValid_zip(SALT31.StrType s) := InValidFT_zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_zip(wh);
EXPORT Make_zip4(SALT31.StrType s0) := MakeFT_zip4(s0);
EXPORT InValid_zip4(SALT31.StrType s) := InValidFT_zip4(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_zip4(wh);
EXPORT Make_bdid(SALT31.StrType s0) := MakeFT_bdid(s0);
EXPORT InValid_bdid(SALT31.StrType s) := InValidFT_bdid(s);
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := InValidMessageFT_bdid(wh);
EXPORT Make_bdid_score(SALT31.StrType s0) := MakeFT_bdid_score(s0);
EXPORT InValid_bdid_score(SALT31.StrType s) := InValidFT_bdid_score(s);
EXPORT InValidMessage_bdid_score(UNSIGNED1 wh) := InValidMessageFT_bdid_score(wh);
EXPORT Make_lnpid(SALT31.StrType s0) := MakeFT_lnpid(s0);
EXPORT InValid_lnpid(SALT31.StrType s) := InValidFT_lnpid(s);
EXPORT InValidMessage_lnpid(UNSIGNED1 wh) := InValidMessageFT_lnpid(wh);
EXPORT Make_did(SALT31.StrType s0) := MakeFT_did(s0);
EXPORT InValid_did(SALT31.StrType s) := InValidFT_did(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_did(wh);
EXPORT Make_did_score(SALT31.StrType s0) := MakeFT_did_score(s0);
EXPORT InValid_did_score(SALT31.StrType s) := InValidFT_did_score(s);
EXPORT InValidMessage_did_score(UNSIGNED1 wh) := InValidMessageFT_did_score(wh);
EXPORT Make_dt_vendor_first_reported(SALT31.StrType s0) := MakeFT_dt_vendor_first_reported(s0);
EXPORT InValid_dt_vendor_first_reported(SALT31.StrType s) := InValidFT_dt_vendor_first_reported(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_dt_vendor_first_reported(wh);
EXPORT Make_dt_vendor_last_reported(SALT31.StrType s0) := MakeFT_dt_vendor_last_reported(s0);
EXPORT InValid_dt_vendor_last_reported(SALT31.StrType s) := InValidFT_dt_vendor_last_reported(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_dt_vendor_last_reported(wh);
EXPORT Make_in_state(SALT31.StrType s0) := MakeFT_in_state(s0);
EXPORT InValid_in_state(SALT31.StrType s) := InValidFT_in_state(s);
EXPORT InValidMessage_in_state(UNSIGNED1 wh) := InValidMessageFT_in_state(wh);
EXPORT Make_in_class(SALT31.StrType s0) := MakeFT_in_class(s0);
EXPORT InValid_in_class(SALT31.StrType s) := InValidFT_in_class(s);
EXPORT InValidMessage_in_class(UNSIGNED1 wh) := InValidMessageFT_in_class(wh);
EXPORT Make_in_status(SALT31.StrType s0) := MakeFT_in_status(s0);
EXPORT InValid_in_status(SALT31.StrType s) := InValidFT_in_status(s);
EXPORT InValidMessage_in_status(UNSIGNED1 wh) := InValidMessageFT_in_status(wh);
EXPORT Make_in_qualifier1(SALT31.StrType s0) := MakeFT_in_qualifier1(s0);
EXPORT InValid_in_qualifier1(SALT31.StrType s) := InValidFT_in_qualifier1(s);
EXPORT InValidMessage_in_qualifier1(UNSIGNED1 wh) := InValidMessageFT_in_qualifier1(wh);
EXPORT Make_in_qualifier2(SALT31.StrType s0) := MakeFT_in_qualifier2(s0);
EXPORT InValid_in_qualifier2(SALT31.StrType s) := InValidFT_in_qualifier2(s);
EXPORT InValidMessage_in_qualifier2(UNSIGNED1 wh) := InValidMessageFT_in_qualifier2(wh);
EXPORT Make_mapped_class(SALT31.StrType s0) := MakeFT_mapped_class(s0);
EXPORT InValid_mapped_class(SALT31.StrType s) := InValidFT_mapped_class(s);
EXPORT InValidMessage_mapped_class(UNSIGNED1 wh) := InValidMessageFT_mapped_class(wh);
EXPORT Make_mapped_status(SALT31.StrType s0) := MakeFT_mapped_status(s0);
EXPORT InValid_mapped_status(SALT31.StrType s) := InValidFT_mapped_status(s);
EXPORT InValidMessage_mapped_status(UNSIGNED1 wh) := InValidMessageFT_mapped_status(wh);
EXPORT Make_mapped_qualifier1(SALT31.StrType s0) := MakeFT_mapped_qualifier1(s0);
EXPORT InValid_mapped_qualifier1(SALT31.StrType s) := InValidFT_mapped_qualifier1(s);
EXPORT InValidMessage_mapped_qualifier1(UNSIGNED1 wh) := InValidMessageFT_mapped_qualifier1(wh);
EXPORT Make_mapped_qualifier2(SALT31.StrType s0) := MakeFT_mapped_qualifier2(s0);
EXPORT InValid_mapped_qualifier2(SALT31.StrType s) := InValidFT_mapped_qualifier2(s);
EXPORT InValidMessage_mapped_qualifier2(UNSIGNED1 wh) := InValidMessageFT_mapped_qualifier2(wh);
EXPORT Make_mapped_pdma(SALT31.StrType s0) := MakeFT_mapped_pdma(s0);
EXPORT InValid_mapped_pdma(SALT31.StrType s) := InValidFT_mapped_pdma(s);
EXPORT InValidMessage_mapped_pdma(UNSIGNED1 wh) := InValidMessageFT_mapped_pdma(wh);
EXPORT Make_mapped_pract_type(SALT31.StrType s0) := MakeFT_mapped_pract_type(s0);
EXPORT InValid_mapped_pract_type(SALT31.StrType s) := InValidFT_mapped_pract_type(s);
EXPORT InValidMessage_mapped_pract_type(UNSIGNED1 wh) := InValidMessageFT_mapped_pract_type(wh);
EXPORT Make_source_code(SALT31.StrType s0) := MakeFT_source_code(s0);
EXPORT InValid_source_code(SALT31.StrType s) := InValidFT_source_code(s);
EXPORT InValidMessage_source_code(UNSIGNED1 wh) := InValidMessageFT_source_code(wh);
EXPORT Make_taxonomy_code(SALT31.StrType s0) := MakeFT_taxonomy_code(s0);
EXPORT InValid_taxonomy_code(SALT31.StrType s) := InValidFT_taxonomy_code(s);
EXPORT InValidMessage_taxonomy_code(UNSIGNED1 wh) := InValidMessageFT_taxonomy_code(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT31,Scrubs_HMS_STLIC;
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
    BOOLEAN Diff_ln_key;
    BOOLEAN Diff_hms_src;
    BOOLEAN Diff_key;
    BOOLEAN Diff_id;
    BOOLEAN Diff_entityid;
    BOOLEAN Diff_license_number;
    BOOLEAN Diff_license_class_type;
    BOOLEAN Diff_license_state;
    BOOLEAN Diff_status;
    BOOLEAN Diff_issue_date;
    BOOLEAN Diff_expiration_date;
    BOOLEAN Diff_qualifier1;
    BOOLEAN Diff_qualifier2;
    BOOLEAN Diff_qualifier3;
    BOOLEAN Diff_qualifier4;
    BOOLEAN Diff_qualifier5;
    BOOLEAN Diff_rawclass;
    BOOLEAN Diff_rawissue_date;
    BOOLEAN Diff_rawexpiration_date;
    BOOLEAN Diff_rawstatus;
    BOOLEAN Diff_raw_number;
    BOOLEAN Diff_name;
    BOOLEAN Diff_first;
    BOOLEAN Diff_middle;
    BOOLEAN Diff_last;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_cred;
    BOOLEAN Diff_age;
    BOOLEAN Diff_dateofbirth;
    BOOLEAN Diff_email;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_dateofdeath;
    BOOLEAN Diff_firmname;
    BOOLEAN Diff_street1;
    BOOLEAN Diff_street2;
    BOOLEAN Diff_street3;
    BOOLEAN Diff_city;
    BOOLEAN Diff_address_state;
    BOOLEAN Diff_orig_zip;
    BOOLEAN Diff_orig_county;
    BOOLEAN Diff_country;
    BOOLEAN Diff_address_type;
    BOOLEAN Diff_phone1;
    BOOLEAN Diff_phone2;
    BOOLEAN Diff_phone3;
    BOOLEAN Diff_fax1;
    BOOLEAN Diff_fax2;
    BOOLEAN Diff_fax3;
    BOOLEAN Diff_other_phone1;
    BOOLEAN Diff_description;
    BOOLEAN Diff_specialty_class_type;
    BOOLEAN Diff_phone_number;
    BOOLEAN Diff_phone_type;
    BOOLEAN Diff_language;
    BOOLEAN Diff_graduated;
    BOOLEAN Diff_school;
    BOOLEAN Diff_location;
    BOOLEAN Diff_board;
    BOOLEAN Diff_offense;
    BOOLEAN Diff_offense_date;
    BOOLEAN Diff_action;
    BOOLEAN Diff_action_date;
    BOOLEAN Diff_action_start;
    BOOLEAN Diff_action_end;
    BOOLEAN Diff_npi_number;
    BOOLEAN Diff_csr_number;
    BOOLEAN Diff_dea_number;
    BOOLEAN Diff_prepped_addr1;
    BOOLEAN Diff_prepped_addr2;
    BOOLEAN Diff_clean_phone;
    BOOLEAN Diff_clean_phone1;
    BOOLEAN Diff_clean_phone2;
    BOOLEAN Diff_clean_phone3;
    BOOLEAN Diff_clean_fax1;
    BOOLEAN Diff_clean_fax2;
    BOOLEAN Diff_clean_fax3;
    BOOLEAN Diff_clean_other_phone1;
    BOOLEAN Diff_clean_dateofbirth;
    BOOLEAN Diff_clean_dateofdeath;
    BOOLEAN Diff_clean_company_name;
    BOOLEAN Diff_clean_issue_date;
    BOOLEAN Diff_clean_expiration_date;
    BOOLEAN Diff_clean_offense_date;
    BOOLEAN Diff_clean_action_date;
    BOOLEAN Diff_src;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_bdid_score;
    BOOLEAN Diff_lnpid;
    BOOLEAN Diff_did;
    BOOLEAN Diff_did_score;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_in_state;
    BOOLEAN Diff_in_class;
    BOOLEAN Diff_in_status;
    BOOLEAN Diff_in_qualifier1;
    BOOLEAN Diff_in_qualifier2;
    BOOLEAN Diff_mapped_class;
    BOOLEAN Diff_mapped_status;
    BOOLEAN Diff_mapped_qualifier1;
    BOOLEAN Diff_mapped_qualifier2;
    BOOLEAN Diff_mapped_pdma;
    BOOLEAN Diff_mapped_pract_type;
    BOOLEAN Diff_source_code;
    BOOLEAN Diff_taxonomy_code;
    UNSIGNED Num_Diffs;
    SALT31.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_ln_key := le.ln_key <> ri.ln_key;
    SELF.Diff_hms_src := le.hms_src <> ri.hms_src;
    SELF.Diff_key := le.key <> ri.key;
    SELF.Diff_id := le.id <> ri.id;
    SELF.Diff_entityid := le.entityid <> ri.entityid;
    SELF.Diff_license_number := le.license_number <> ri.license_number;
    SELF.Diff_license_class_type := le.license_class_type <> ri.license_class_type;
    SELF.Diff_license_state := le.license_state <> ri.license_state;
    SELF.Diff_status := le.status <> ri.status;
    SELF.Diff_issue_date := le.issue_date <> ri.issue_date;
    SELF.Diff_expiration_date := le.expiration_date <> ri.expiration_date;
    SELF.Diff_qualifier1 := le.qualifier1 <> ri.qualifier1;
    SELF.Diff_qualifier2 := le.qualifier2 <> ri.qualifier2;
    SELF.Diff_qualifier3 := le.qualifier3 <> ri.qualifier3;
    SELF.Diff_qualifier4 := le.qualifier4 <> ri.qualifier4;
    SELF.Diff_qualifier5 := le.qualifier5 <> ri.qualifier5;
    SELF.Diff_rawclass := le.rawclass <> ri.rawclass;
    SELF.Diff_rawissue_date := le.rawissue_date <> ri.rawissue_date;
    SELF.Diff_rawexpiration_date := le.rawexpiration_date <> ri.rawexpiration_date;
    SELF.Diff_rawstatus := le.rawstatus <> ri.rawstatus;
    SELF.Diff_raw_number := le.raw_number <> ri.raw_number;
    SELF.Diff_name := le.name <> ri.name;
    SELF.Diff_first := le.first <> ri.first;
    SELF.Diff_middle := le.middle <> ri.middle;
    SELF.Diff_last := le.last <> ri.last;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_cred := le.cred <> ri.cred;
    SELF.Diff_age := le.age <> ri.age;
    SELF.Diff_dateofbirth := le.dateofbirth <> ri.dateofbirth;
    SELF.Diff_email := le.email <> ri.email;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_dateofdeath := le.dateofdeath <> ri.dateofdeath;
    SELF.Diff_firmname := le.firmname <> ri.firmname;
    SELF.Diff_street1 := le.street1 <> ri.street1;
    SELF.Diff_street2 := le.street2 <> ri.street2;
    SELF.Diff_street3 := le.street3 <> ri.street3;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_address_state := le.address_state <> ri.address_state;
    SELF.Diff_orig_zip := le.orig_zip <> ri.orig_zip;
    SELF.Diff_orig_county := le.orig_county <> ri.orig_county;
    SELF.Diff_country := le.country <> ri.country;
    SELF.Diff_address_type := le.address_type <> ri.address_type;
    SELF.Diff_phone1 := le.phone1 <> ri.phone1;
    SELF.Diff_phone2 := le.phone2 <> ri.phone2;
    SELF.Diff_phone3 := le.phone3 <> ri.phone3;
    SELF.Diff_fax1 := le.fax1 <> ri.fax1;
    SELF.Diff_fax2 := le.fax2 <> ri.fax2;
    SELF.Diff_fax3 := le.fax3 <> ri.fax3;
    SELF.Diff_other_phone1 := le.other_phone1 <> ri.other_phone1;
    SELF.Diff_description := le.description <> ri.description;
    SELF.Diff_specialty_class_type := le.specialty_class_type <> ri.specialty_class_type;
    SELF.Diff_phone_number := le.phone_number <> ri.phone_number;
    SELF.Diff_phone_type := le.phone_type <> ri.phone_type;
    SELF.Diff_language := le.language <> ri.language;
    SELF.Diff_graduated := le.graduated <> ri.graduated;
    SELF.Diff_school := le.school <> ri.school;
    SELF.Diff_location := le.location <> ri.location;
    SELF.Diff_board := le.board <> ri.board;
    SELF.Diff_offense := le.offense <> ri.offense;
    SELF.Diff_offense_date := le.offense_date <> ri.offense_date;
    SELF.Diff_action := le.action <> ri.action;
    SELF.Diff_action_date := le.action_date <> ri.action_date;
    SELF.Diff_action_start := le.action_start <> ri.action_start;
    SELF.Diff_action_end := le.action_end <> ri.action_end;
    SELF.Diff_npi_number := le.npi_number <> ri.npi_number;
    SELF.Diff_csr_number := le.csr_number <> ri.csr_number;
    SELF.Diff_dea_number := le.dea_number <> ri.dea_number;
    SELF.Diff_prepped_addr1 := le.prepped_addr1 <> ri.prepped_addr1;
    SELF.Diff_prepped_addr2 := le.prepped_addr2 <> ri.prepped_addr2;
    SELF.Diff_clean_phone := le.clean_phone <> ri.clean_phone;
    SELF.Diff_clean_phone1 := le.clean_phone1 <> ri.clean_phone1;
    SELF.Diff_clean_phone2 := le.clean_phone2 <> ri.clean_phone2;
    SELF.Diff_clean_phone3 := le.clean_phone3 <> ri.clean_phone3;
    SELF.Diff_clean_fax1 := le.clean_fax1 <> ri.clean_fax1;
    SELF.Diff_clean_fax2 := le.clean_fax2 <> ri.clean_fax2;
    SELF.Diff_clean_fax3 := le.clean_fax3 <> ri.clean_fax3;
    SELF.Diff_clean_other_phone1 := le.clean_other_phone1 <> ri.clean_other_phone1;
    SELF.Diff_clean_dateofbirth := le.clean_dateofbirth <> ri.clean_dateofbirth;
    SELF.Diff_clean_dateofdeath := le.clean_dateofdeath <> ri.clean_dateofdeath;
    SELF.Diff_clean_company_name := le.clean_company_name <> ri.clean_company_name;
    SELF.Diff_clean_issue_date := le.clean_issue_date <> ri.clean_issue_date;
    SELF.Diff_clean_expiration_date := le.clean_expiration_date <> ri.clean_expiration_date;
    SELF.Diff_clean_offense_date := le.clean_offense_date <> ri.clean_offense_date;
    SELF.Diff_clean_action_date := le.clean_action_date <> ri.clean_action_date;
    SELF.Diff_src := le.src <> ri.src;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_bdid_score := le.bdid_score <> ri.bdid_score;
    SELF.Diff_lnpid := le.lnpid <> ri.lnpid;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_did_score := le.did_score <> ri.did_score;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_in_state := le.in_state <> ri.in_state;
    SELF.Diff_in_class := le.in_class <> ri.in_class;
    SELF.Diff_in_status := le.in_status <> ri.in_status;
    SELF.Diff_in_qualifier1 := le.in_qualifier1 <> ri.in_qualifier1;
    SELF.Diff_in_qualifier2 := le.in_qualifier2 <> ri.in_qualifier2;
    SELF.Diff_mapped_class := le.mapped_class <> ri.mapped_class;
    SELF.Diff_mapped_status := le.mapped_status <> ri.mapped_status;
    SELF.Diff_mapped_qualifier1 := le.mapped_qualifier1 <> ri.mapped_qualifier1;
    SELF.Diff_mapped_qualifier2 := le.mapped_qualifier2 <> ri.mapped_qualifier2;
    SELF.Diff_mapped_pdma := le.mapped_pdma <> ri.mapped_pdma;
    SELF.Diff_mapped_pract_type := le.mapped_pract_type <> ri.mapped_pract_type;
    SELF.Diff_source_code := le.source_code <> ri.source_code;
    SELF.Diff_taxonomy_code := le.taxonomy_code <> ri.taxonomy_code;
    SELF.Val := (SALT31.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_ln_key,1,0)+ IF( SELF.Diff_hms_src,1,0)+ IF( SELF.Diff_key,1,0)+ IF( SELF.Diff_id,1,0)+ IF( SELF.Diff_entityid,1,0)+ IF( SELF.Diff_license_number,1,0)+ IF( SELF.Diff_license_class_type,1,0)+ IF( SELF.Diff_license_state,1,0)+ IF( SELF.Diff_status,1,0)+ IF( SELF.Diff_issue_date,1,0)+ IF( SELF.Diff_expiration_date,1,0)+ IF( SELF.Diff_qualifier1,1,0)+ IF( SELF.Diff_qualifier2,1,0)+ IF( SELF.Diff_qualifier3,1,0)+ IF( SELF.Diff_qualifier4,1,0)+ IF( SELF.Diff_qualifier5,1,0)+ IF( SELF.Diff_rawclass,1,0)+ IF( SELF.Diff_rawissue_date,1,0)+ IF( SELF.Diff_rawexpiration_date,1,0)+ IF( SELF.Diff_rawstatus,1,0)+ IF( SELF.Diff_raw_number,1,0)+ IF( SELF.Diff_name,1,0)+ IF( SELF.Diff_first,1,0)+ IF( SELF.Diff_middle,1,0)+ IF( SELF.Diff_last,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_cred,1,0)+ IF( SELF.Diff_age,1,0)+ IF( SELF.Diff_dateofbirth,1,0)+ IF( SELF.Diff_email,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_dateofdeath,1,0)+ IF( SELF.Diff_firmname,1,0)+ IF( SELF.Diff_street1,1,0)+ IF( SELF.Diff_street2,1,0)+ IF( SELF.Diff_street3,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_address_state,1,0)+ IF( SELF.Diff_orig_zip,1,0)+ IF( SELF.Diff_orig_county,1,0)+ IF( SELF.Diff_country,1,0)+ IF( SELF.Diff_address_type,1,0)+ IF( SELF.Diff_phone1,1,0)+ IF( SELF.Diff_phone2,1,0)+ IF( SELF.Diff_phone3,1,0)+ IF( SELF.Diff_fax1,1,0)+ IF( SELF.Diff_fax2,1,0)+ IF( SELF.Diff_fax3,1,0)+ IF( SELF.Diff_other_phone1,1,0)+ IF( SELF.Diff_description,1,0)+ IF( SELF.Diff_specialty_class_type,1,0)+ IF( SELF.Diff_phone_number,1,0)+ IF( SELF.Diff_phone_type,1,0)+ IF( SELF.Diff_language,1,0)+ IF( SELF.Diff_graduated,1,0)+ IF( SELF.Diff_school,1,0)+ IF( SELF.Diff_location,1,0)+ IF( SELF.Diff_board,1,0)+ IF( SELF.Diff_offense,1,0)+ IF( SELF.Diff_offense_date,1,0)+ IF( SELF.Diff_action,1,0)+ IF( SELF.Diff_action_date,1,0)+ IF( SELF.Diff_action_start,1,0)+ IF( SELF.Diff_action_end,1,0)+ IF( SELF.Diff_npi_number,1,0)+ IF( SELF.Diff_csr_number,1,0)+ IF( SELF.Diff_dea_number,1,0)+ IF( SELF.Diff_prepped_addr1,1,0)+ IF( SELF.Diff_prepped_addr2,1,0)+ IF( SELF.Diff_clean_phone,1,0)+ IF( SELF.Diff_clean_phone1,1,0)+ IF( SELF.Diff_clean_phone2,1,0)+ IF( SELF.Diff_clean_phone3,1,0)+ IF( SELF.Diff_clean_fax1,1,0)+ IF( SELF.Diff_clean_fax2,1,0)+ IF( SELF.Diff_clean_fax3,1,0)+ IF( SELF.Diff_clean_other_phone1,1,0)+ IF( SELF.Diff_clean_dateofbirth,1,0)+ IF( SELF.Diff_clean_dateofdeath,1,0)+ IF( SELF.Diff_clean_company_name,1,0)+ IF( SELF.Diff_clean_issue_date,1,0)+ IF( SELF.Diff_clean_expiration_date,1,0)+ IF( SELF.Diff_clean_offense_date,1,0)+ IF( SELF.Diff_clean_action_date,1,0)+ IF( SELF.Diff_src,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_bdid_score,1,0)+ IF( SELF.Diff_lnpid,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_did_score,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_in_state,1,0)+ IF( SELF.Diff_in_class,1,0)+ IF( SELF.Diff_in_status,1,0)+ IF( SELF.Diff_in_qualifier1,1,0)+ IF( SELF.Diff_in_qualifier2,1,0)+ IF( SELF.Diff_mapped_class,1,0)+ IF( SELF.Diff_mapped_status,1,0)+ IF( SELF.Diff_mapped_qualifier1,1,0)+ IF( SELF.Diff_mapped_qualifier2,1,0)+ IF( SELF.Diff_mapped_pdma,1,0)+ IF( SELF.Diff_mapped_pract_type,1,0)+ IF( SELF.Diff_source_code,1,0)+ IF( SELF.Diff_taxonomy_code,1,0);
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
    Count_Diff_ln_key := COUNT(GROUP,%Closest%.Diff_ln_key);
    Count_Diff_hms_src := COUNT(GROUP,%Closest%.Diff_hms_src);
    Count_Diff_key := COUNT(GROUP,%Closest%.Diff_key);
    Count_Diff_id := COUNT(GROUP,%Closest%.Diff_id);
    Count_Diff_entityid := COUNT(GROUP,%Closest%.Diff_entityid);
    Count_Diff_license_number := COUNT(GROUP,%Closest%.Diff_license_number);
    Count_Diff_license_class_type := COUNT(GROUP,%Closest%.Diff_license_class_type);
    Count_Diff_license_state := COUNT(GROUP,%Closest%.Diff_license_state);
    Count_Diff_status := COUNT(GROUP,%Closest%.Diff_status);
    Count_Diff_issue_date := COUNT(GROUP,%Closest%.Diff_issue_date);
    Count_Diff_expiration_date := COUNT(GROUP,%Closest%.Diff_expiration_date);
    Count_Diff_qualifier1 := COUNT(GROUP,%Closest%.Diff_qualifier1);
    Count_Diff_qualifier2 := COUNT(GROUP,%Closest%.Diff_qualifier2);
    Count_Diff_qualifier3 := COUNT(GROUP,%Closest%.Diff_qualifier3);
    Count_Diff_qualifier4 := COUNT(GROUP,%Closest%.Diff_qualifier4);
    Count_Diff_qualifier5 := COUNT(GROUP,%Closest%.Diff_qualifier5);
    Count_Diff_rawclass := COUNT(GROUP,%Closest%.Diff_rawclass);
    Count_Diff_rawissue_date := COUNT(GROUP,%Closest%.Diff_rawissue_date);
    Count_Diff_rawexpiration_date := COUNT(GROUP,%Closest%.Diff_rawexpiration_date);
    Count_Diff_rawstatus := COUNT(GROUP,%Closest%.Diff_rawstatus);
    Count_Diff_raw_number := COUNT(GROUP,%Closest%.Diff_raw_number);
    Count_Diff_name := COUNT(GROUP,%Closest%.Diff_name);
    Count_Diff_first := COUNT(GROUP,%Closest%.Diff_first);
    Count_Diff_middle := COUNT(GROUP,%Closest%.Diff_middle);
    Count_Diff_last := COUNT(GROUP,%Closest%.Diff_last);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_cred := COUNT(GROUP,%Closest%.Diff_cred);
    Count_Diff_age := COUNT(GROUP,%Closest%.Diff_age);
    Count_Diff_dateofbirth := COUNT(GROUP,%Closest%.Diff_dateofbirth);
    Count_Diff_email := COUNT(GROUP,%Closest%.Diff_email);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_dateofdeath := COUNT(GROUP,%Closest%.Diff_dateofdeath);
    Count_Diff_firmname := COUNT(GROUP,%Closest%.Diff_firmname);
    Count_Diff_street1 := COUNT(GROUP,%Closest%.Diff_street1);
    Count_Diff_street2 := COUNT(GROUP,%Closest%.Diff_street2);
    Count_Diff_street3 := COUNT(GROUP,%Closest%.Diff_street3);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_address_state := COUNT(GROUP,%Closest%.Diff_address_state);
    Count_Diff_orig_zip := COUNT(GROUP,%Closest%.Diff_orig_zip);
    Count_Diff_orig_county := COUNT(GROUP,%Closest%.Diff_orig_county);
    Count_Diff_country := COUNT(GROUP,%Closest%.Diff_country);
    Count_Diff_address_type := COUNT(GROUP,%Closest%.Diff_address_type);
    Count_Diff_phone1 := COUNT(GROUP,%Closest%.Diff_phone1);
    Count_Diff_phone2 := COUNT(GROUP,%Closest%.Diff_phone2);
    Count_Diff_phone3 := COUNT(GROUP,%Closest%.Diff_phone3);
    Count_Diff_fax1 := COUNT(GROUP,%Closest%.Diff_fax1);
    Count_Diff_fax2 := COUNT(GROUP,%Closest%.Diff_fax2);
    Count_Diff_fax3 := COUNT(GROUP,%Closest%.Diff_fax3);
    Count_Diff_other_phone1 := COUNT(GROUP,%Closest%.Diff_other_phone1);
    Count_Diff_description := COUNT(GROUP,%Closest%.Diff_description);
    Count_Diff_specialty_class_type := COUNT(GROUP,%Closest%.Diff_specialty_class_type);
    Count_Diff_phone_number := COUNT(GROUP,%Closest%.Diff_phone_number);
    Count_Diff_phone_type := COUNT(GROUP,%Closest%.Diff_phone_type);
    Count_Diff_language := COUNT(GROUP,%Closest%.Diff_language);
    Count_Diff_graduated := COUNT(GROUP,%Closest%.Diff_graduated);
    Count_Diff_school := COUNT(GROUP,%Closest%.Diff_school);
    Count_Diff_location := COUNT(GROUP,%Closest%.Diff_location);
    Count_Diff_board := COUNT(GROUP,%Closest%.Diff_board);
    Count_Diff_offense := COUNT(GROUP,%Closest%.Diff_offense);
    Count_Diff_offense_date := COUNT(GROUP,%Closest%.Diff_offense_date);
    Count_Diff_action := COUNT(GROUP,%Closest%.Diff_action);
    Count_Diff_action_date := COUNT(GROUP,%Closest%.Diff_action_date);
    Count_Diff_action_start := COUNT(GROUP,%Closest%.Diff_action_start);
    Count_Diff_action_end := COUNT(GROUP,%Closest%.Diff_action_end);
    Count_Diff_npi_number := COUNT(GROUP,%Closest%.Diff_npi_number);
    Count_Diff_csr_number := COUNT(GROUP,%Closest%.Diff_csr_number);
    Count_Diff_dea_number := COUNT(GROUP,%Closest%.Diff_dea_number);
    Count_Diff_prepped_addr1 := COUNT(GROUP,%Closest%.Diff_prepped_addr1);
    Count_Diff_prepped_addr2 := COUNT(GROUP,%Closest%.Diff_prepped_addr2);
    Count_Diff_clean_phone := COUNT(GROUP,%Closest%.Diff_clean_phone);
    Count_Diff_clean_phone1 := COUNT(GROUP,%Closest%.Diff_clean_phone1);
    Count_Diff_clean_phone2 := COUNT(GROUP,%Closest%.Diff_clean_phone2);
    Count_Diff_clean_phone3 := COUNT(GROUP,%Closest%.Diff_clean_phone3);
    Count_Diff_clean_fax1 := COUNT(GROUP,%Closest%.Diff_clean_fax1);
    Count_Diff_clean_fax2 := COUNT(GROUP,%Closest%.Diff_clean_fax2);
    Count_Diff_clean_fax3 := COUNT(GROUP,%Closest%.Diff_clean_fax3);
    Count_Diff_clean_other_phone1 := COUNT(GROUP,%Closest%.Diff_clean_other_phone1);
    Count_Diff_clean_dateofbirth := COUNT(GROUP,%Closest%.Diff_clean_dateofbirth);
    Count_Diff_clean_dateofdeath := COUNT(GROUP,%Closest%.Diff_clean_dateofdeath);
    Count_Diff_clean_company_name := COUNT(GROUP,%Closest%.Diff_clean_company_name);
    Count_Diff_clean_issue_date := COUNT(GROUP,%Closest%.Diff_clean_issue_date);
    Count_Diff_clean_expiration_date := COUNT(GROUP,%Closest%.Diff_clean_expiration_date);
    Count_Diff_clean_offense_date := COUNT(GROUP,%Closest%.Diff_clean_offense_date);
    Count_Diff_clean_action_date := COUNT(GROUP,%Closest%.Diff_clean_action_date);
    Count_Diff_src := COUNT(GROUP,%Closest%.Diff_src);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_bdid_score := COUNT(GROUP,%Closest%.Diff_bdid_score);
    Count_Diff_lnpid := COUNT(GROUP,%Closest%.Diff_lnpid);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_did_score := COUNT(GROUP,%Closest%.Diff_did_score);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_in_state := COUNT(GROUP,%Closest%.Diff_in_state);
    Count_Diff_in_class := COUNT(GROUP,%Closest%.Diff_in_class);
    Count_Diff_in_status := COUNT(GROUP,%Closest%.Diff_in_status);
    Count_Diff_in_qualifier1 := COUNT(GROUP,%Closest%.Diff_in_qualifier1);
    Count_Diff_in_qualifier2 := COUNT(GROUP,%Closest%.Diff_in_qualifier2);
    Count_Diff_mapped_class := COUNT(GROUP,%Closest%.Diff_mapped_class);
    Count_Diff_mapped_status := COUNT(GROUP,%Closest%.Diff_mapped_status);
    Count_Diff_mapped_qualifier1 := COUNT(GROUP,%Closest%.Diff_mapped_qualifier1);
    Count_Diff_mapped_qualifier2 := COUNT(GROUP,%Closest%.Diff_mapped_qualifier2);
    Count_Diff_mapped_pdma := COUNT(GROUP,%Closest%.Diff_mapped_pdma);
    Count_Diff_mapped_pract_type := COUNT(GROUP,%Closest%.Diff_mapped_pract_type);
    Count_Diff_source_code := COUNT(GROUP,%Closest%.Diff_source_code);
    Count_Diff_taxonomy_code := COUNT(GROUP,%Closest%.Diff_taxonomy_code);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
