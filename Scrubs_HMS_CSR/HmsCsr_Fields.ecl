IMPORT ut,SALT31;
EXPORT HmsCsr_Fields := MODULE
// Processing for each FieldType
EXPORT SALT31.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'ln_key','hms_src','key','id','entityid','license_number','license_class_type','license_state','status','issue_date','renewal_date','expiration_date','qualifier1','qualifier2','qualifier3','qualifier4','qualifier5','rawclass','rawissue_date','rawexpiration_date','rawstatus','raw_number','name','prefix','first','middle','last','suffix','cred','age','dateofbirth','email','gender','dateofdeath','firmname','street1','street2','street3','city','address_state','orig_zip','orig_county','country','address_type','phone1','phone2','phone3','fax1','fax2','fax3','other_phone1','description','specialty_class_type','phone_number','phone_type','language','degree','graduated','school','location','fine','board','offense','offense_date','action','action_date','action_start','action_end','npi_number','replacement_number','enumeration_date','last_update_date','deactivation_date','reactivation_date','deactivation_reason','csr_number','credential_type','csr_status','sub_status','csr_state','csr_issue_date','effective_date','csr_expiration_date','discipline','all_schedules','dea_expiration_date');
EXPORT FieldTypeNum(SALT31.StrType fn) := CASE(fn,'ln_key' => 1,'hms_src' => 2,'key' => 3,'id' => 4,'entityid' => 5,'license_number' => 6,'license_class_type' => 7,'license_state' => 8,'status' => 9,'issue_date' => 10,'renewal_date' => 11,'expiration_date' => 12,'qualifier1' => 13,'qualifier2' => 14,'qualifier3' => 15,'qualifier4' => 16,'qualifier5' => 17,'rawclass' => 18,'rawissue_date' => 19,'rawexpiration_date' => 20,'rawstatus' => 21,'raw_number' => 22,'name' => 23,'prefix' => 24,'first' => 25,'middle' => 26,'last' => 27,'suffix' => 28,'cred' => 29,'age' => 30,'dateofbirth' => 31,'email' => 32,'gender' => 33,'dateofdeath' => 34,'firmname' => 35,'street1' => 36,'street2' => 37,'street3' => 38,'city' => 39,'address_state' => 40,'orig_zip' => 41,'orig_county' => 42,'country' => 43,'address_type' => 44,'phone1' => 45,'phone2' => 46,'phone3' => 47,'fax1' => 48,'fax2' => 49,'fax3' => 50,'other_phone1' => 51,'description' => 52,'specialty_class_type' => 53,'phone_number' => 54,'phone_type' => 55,'language' => 56,'degree' => 57,'graduated' => 58,'school' => 59,'location' => 60,'fine' => 61,'board' => 62,'offense' => 63,'offense_date' => 64,'action' => 65,'action_date' => 66,'action_start' => 67,'action_end' => 68,'npi_number' => 69,'replacement_number' => 70,'enumeration_date' => 71,'last_update_date' => 72,'deactivation_date' => 73,'reactivation_date' => 74,'deactivation_reason' => 75,'csr_number' => 76,'credential_type' => 77,'csr_status' => 78,'sub_status' => 79,'csr_state' => 80,'csr_issue_date' => 81,'effective_date' => 82,'csr_expiration_date' => 83,'discipline' => 84,'all_schedules' => 85,'dea_expiration_date' => 86,0);
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
EXPORT InValidFT_license_number(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_license_number(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
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
EXPORT MakeFT_renewal_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' -/0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_renewal_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' -/0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_renewal_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' -/0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('0,4..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
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
  s1 := SALT31.stringfilter(s0,' ,-.\'123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ,-.\'123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ,-.\'123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_prefix(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' .ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prefix(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' .ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_prefix(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' .ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_first(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ,-.\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_first(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ,-.\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_first(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ,-.\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_middle(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ,-.\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_middle(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ,-.\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_middle(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ,-.\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_last(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ,-.\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_last(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ,-.\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_last(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ,-.\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('1..'),SALT31.HygieneErrors.Good);
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
  s1 := SALT31.stringfilter(s0,' #\'&,-/.():@0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_firmname(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' #\'&,-/.():@0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_firmname(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' #\'&,-/.():@0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_street1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' #\'&,-./():@0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_street1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' #\'&,-./():@0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_street1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' #\'&,-./():@0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_street2(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' #\'&,-./():@0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_street2(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' #\'&,-./():@0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_street2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' #\'&,-./():@0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_street3(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' #\'&,-./():@0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_street3(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' #\'&,-./():@0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_street3(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' #\'&,-./():@0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
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
  s1 := SALT31.stringfilter(s0,' ()-.01345689ACDEFGHILMNOPRSTUVYabcdehilmnoprstuvy '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_description(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ()-.01345689ACDEFGHILMNOPRSTUVYabcdehilmnoprstuvy '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_description(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ()-.01345689ACDEFGHILMNOPRSTUVYabcdehilmnoprstuvy '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_specialty_class_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_specialty_class_type(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_specialty_class_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_phone_number(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'()-0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_phone_number(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'()-0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 12),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_phone_number(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('()-0123456789 '),SALT31.HygieneErrors.NotLength('0,12'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_phone_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_phone_type(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_phone_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_language(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_language(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_language(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_degree(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_degree(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_degree(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_graduated(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_graduated(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_graduated(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_school(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_school(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_school(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_location(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_location(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_location(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_fine(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_fine(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_fine(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_board(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_board(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_board(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_offense(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_offense(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_offense(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_offense_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_offense_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_offense_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0,4..'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_action(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_action(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_action(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_action_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_action_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_action_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0,4..'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_action_start(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_action_start(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_action_start(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
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
EXPORT InValidFT_npi_number(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_npi_number(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_replacement_number(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_replacement_number(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_replacement_number(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_enumeration_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-/0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_enumeration_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-/0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_enumeration_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-/0123456789 '),SALT31.HygieneErrors.NotLength('0,4..'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_last_update_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-/0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_last_update_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-/0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_last_update_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-/0123456789 '),SALT31.HygieneErrors.NotLength('0,4..'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_deactivation_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-/0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_deactivation_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-/0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_deactivation_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-/0123456789 '),SALT31.HygieneErrors.NotLength('0,4..'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_reactivation_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_reactivation_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_reactivation_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_deactivation_reason(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_deactivation_reason(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_deactivation_reason(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_csr_number(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-.0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_csr_number(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-.0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_csr_number(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-.0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_credential_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ()-./0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_credential_type(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ()-./0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_credential_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ()-./0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_csr_status(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_csr_status(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_csr_status(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_sub_status(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_sub_status(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_sub_status(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_csr_state(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_csr_state(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 2),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_csr_state(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('2'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_csr_issue_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-/0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_csr_issue_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-/0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_csr_issue_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-/0123456789 '),SALT31.HygieneErrors.NotLength('0,4..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_effective_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-/0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_effective_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-/0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_effective_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-/0123456789 '),SALT31.HygieneErrors.NotLength('0,4..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_csr_expiration_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-/0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_csr_expiration_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-/0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_csr_expiration_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-/0123456789 '),SALT31.HygieneErrors.NotLength('0,4..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_discipline(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_discipline(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_discipline(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_all_schedules(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' &(),0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_all_schedules(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' &(),0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_all_schedules(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' &(),0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.NotLength('0,1..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dea_expiration_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-/0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dea_expiration_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-/0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 0 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) >= 1));
EXPORT InValidMessageFT_dea_expiration_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-/0123456789 '),SALT31.HygieneErrors.NotLength('0,4..'),SALT31.HygieneErrors.NotWords('0,1..'),SALT31.HygieneErrors.Good);
EXPORT SALT31.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'ln_key','hms_src','key','id','entityid','license_number','license_class_type','license_state','status','issue_date','renewal_date','expiration_date','qualifier1','qualifier2','qualifier3','qualifier4','qualifier5','rawclass','rawissue_date','rawexpiration_date','rawstatus','raw_number','name','prefix','first','middle','last','suffix','cred','age','dateofbirth','email','gender','dateofdeath','employer_identification_number','raw_full_address','firmname','street1','street2','street3','city','address_state','orig_zip','orig_county','country','address_type','phone1','phone2','phone3','fax1','fax2','fax3','other_phone1','description','specialty_class_type','phone_number','phone_type','language','degree','graduated','school','location','fine','board','offense','offense_date','action','action_date','action_start','action_end','npi_number','replacement_number','enumeration_date','last_update_date','deactivation_date','reactivation_date','deactivation_reason','csr_number','credential_type','csr_status','sub_status','csr_state','csr_issue_date','effective_date','csr_expiration_date','discipline','all_schedules','schedule_1','schedule_2','schedule_2n','schedule_3','schedule_3n','schedule_4','schedule_5','schedule_6','raw_status','raw_sub_status1','raw_sub_status2','dea_number','schedules','dea_expiration_date','activity','bac','bac_subcode','payment','medicaid_number','medicaid_status','medicaid_state','participation_flag','taxonomy_npi_number','taxonomy_code','taxonomy_order_number','license_number_state_code');
EXPORT FieldNum(SALT31.StrType fn) := CASE(fn,'ln_key' => 1,'hms_src' => 2,'key' => 3,'id' => 4,'entityid' => 5,'license_number' => 6,'license_class_type' => 7,'license_state' => 8,'status' => 9,'issue_date' => 10,'renewal_date' => 11,'expiration_date' => 12,'qualifier1' => 13,'qualifier2' => 14,'qualifier3' => 15,'qualifier4' => 16,'qualifier5' => 17,'rawclass' => 18,'rawissue_date' => 19,'rawexpiration_date' => 20,'rawstatus' => 21,'raw_number' => 22,'name' => 23,'prefix' => 24,'first' => 25,'middle' => 26,'last' => 27,'suffix' => 28,'cred' => 29,'age' => 30,'dateofbirth' => 31,'email' => 32,'gender' => 33,'dateofdeath' => 34,'employer_identification_number' => 35,'raw_full_address' => 36,'firmname' => 37,'street1' => 38,'street2' => 39,'street3' => 40,'city' => 41,'address_state' => 42,'orig_zip' => 43,'orig_county' => 44,'country' => 45,'address_type' => 46,'phone1' => 47,'phone2' => 48,'phone3' => 49,'fax1' => 50,'fax2' => 51,'fax3' => 52,'other_phone1' => 53,'description' => 54,'specialty_class_type' => 55,'phone_number' => 56,'phone_type' => 57,'language' => 58,'degree' => 59,'graduated' => 60,'school' => 61,'location' => 62,'fine' => 63,'board' => 64,'offense' => 65,'offense_date' => 66,'action' => 67,'action_date' => 68,'action_start' => 69,'action_end' => 70,'npi_number' => 71,'replacement_number' => 72,'enumeration_date' => 73,'last_update_date' => 74,'deactivation_date' => 75,'reactivation_date' => 76,'deactivation_reason' => 77,'csr_number' => 78,'credential_type' => 79,'csr_status' => 80,'sub_status' => 81,'csr_state' => 82,'csr_issue_date' => 83,'effective_date' => 84,'csr_expiration_date' => 85,'discipline' => 86,'all_schedules' => 87,'schedule_1' => 88,'schedule_2' => 89,'schedule_2n' => 90,'schedule_3' => 91,'schedule_3n' => 92,'schedule_4' => 93,'schedule_5' => 94,'schedule_6' => 95,'raw_status' => 96,'raw_sub_status1' => 97,'raw_sub_status2' => 98,'dea_number' => 99,'schedules' => 100,'dea_expiration_date' => 101,'activity' => 102,'bac' => 103,'bac_subcode' => 104,'payment' => 105,'medicaid_number' => 106,'medicaid_status' => 107,'medicaid_state' => 108,'participation_flag' => 109,'taxonomy_npi_number' => 110,'taxonomy_code' => 111,'taxonomy_order_number' => 112,'license_number_state_code' => 113,0);
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
EXPORT Make_renewal_date(SALT31.StrType s0) := MakeFT_renewal_date(s0);
EXPORT InValid_renewal_date(SALT31.StrType s) := InValidFT_renewal_date(s);
EXPORT InValidMessage_renewal_date(UNSIGNED1 wh) := InValidMessageFT_renewal_date(wh);
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
EXPORT Make_prefix(SALT31.StrType s0) := MakeFT_prefix(s0);
EXPORT InValid_prefix(SALT31.StrType s) := InValidFT_prefix(s);
EXPORT InValidMessage_prefix(UNSIGNED1 wh) := InValidMessageFT_prefix(wh);
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
EXPORT Make_employer_identification_number(SALT31.StrType s0) := s0;
EXPORT InValid_employer_identification_number(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_employer_identification_number(UNSIGNED1 wh) := '';
EXPORT Make_raw_full_address(SALT31.StrType s0) := s0;
EXPORT InValid_raw_full_address(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_raw_full_address(UNSIGNED1 wh) := '';
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
EXPORT Make_degree(SALT31.StrType s0) := MakeFT_degree(s0);
EXPORT InValid_degree(SALT31.StrType s) := InValidFT_degree(s);
EXPORT InValidMessage_degree(UNSIGNED1 wh) := InValidMessageFT_degree(wh);
EXPORT Make_graduated(SALT31.StrType s0) := MakeFT_graduated(s0);
EXPORT InValid_graduated(SALT31.StrType s) := InValidFT_graduated(s);
EXPORT InValidMessage_graduated(UNSIGNED1 wh) := InValidMessageFT_graduated(wh);
EXPORT Make_school(SALT31.StrType s0) := MakeFT_school(s0);
EXPORT InValid_school(SALT31.StrType s) := InValidFT_school(s);
EXPORT InValidMessage_school(UNSIGNED1 wh) := InValidMessageFT_school(wh);
EXPORT Make_location(SALT31.StrType s0) := MakeFT_location(s0);
EXPORT InValid_location(SALT31.StrType s) := InValidFT_location(s);
EXPORT InValidMessage_location(UNSIGNED1 wh) := InValidMessageFT_location(wh);
EXPORT Make_fine(SALT31.StrType s0) := MakeFT_fine(s0);
EXPORT InValid_fine(SALT31.StrType s) := InValidFT_fine(s);
EXPORT InValidMessage_fine(UNSIGNED1 wh) := InValidMessageFT_fine(wh);
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
EXPORT Make_replacement_number(SALT31.StrType s0) := MakeFT_replacement_number(s0);
EXPORT InValid_replacement_number(SALT31.StrType s) := InValidFT_replacement_number(s);
EXPORT InValidMessage_replacement_number(UNSIGNED1 wh) := InValidMessageFT_replacement_number(wh);
EXPORT Make_enumeration_date(SALT31.StrType s0) := MakeFT_enumeration_date(s0);
EXPORT InValid_enumeration_date(SALT31.StrType s) := InValidFT_enumeration_date(s);
EXPORT InValidMessage_enumeration_date(UNSIGNED1 wh) := InValidMessageFT_enumeration_date(wh);
EXPORT Make_last_update_date(SALT31.StrType s0) := MakeFT_last_update_date(s0);
EXPORT InValid_last_update_date(SALT31.StrType s) := InValidFT_last_update_date(s);
EXPORT InValidMessage_last_update_date(UNSIGNED1 wh) := InValidMessageFT_last_update_date(wh);
EXPORT Make_deactivation_date(SALT31.StrType s0) := MakeFT_deactivation_date(s0);
EXPORT InValid_deactivation_date(SALT31.StrType s) := InValidFT_deactivation_date(s);
EXPORT InValidMessage_deactivation_date(UNSIGNED1 wh) := InValidMessageFT_deactivation_date(wh);
EXPORT Make_reactivation_date(SALT31.StrType s0) := MakeFT_reactivation_date(s0);
EXPORT InValid_reactivation_date(SALT31.StrType s) := InValidFT_reactivation_date(s);
EXPORT InValidMessage_reactivation_date(UNSIGNED1 wh) := InValidMessageFT_reactivation_date(wh);
EXPORT Make_deactivation_reason(SALT31.StrType s0) := MakeFT_deactivation_reason(s0);
EXPORT InValid_deactivation_reason(SALT31.StrType s) := InValidFT_deactivation_reason(s);
EXPORT InValidMessage_deactivation_reason(UNSIGNED1 wh) := InValidMessageFT_deactivation_reason(wh);
EXPORT Make_csr_number(SALT31.StrType s0) := MakeFT_csr_number(s0);
EXPORT InValid_csr_number(SALT31.StrType s) := InValidFT_csr_number(s);
EXPORT InValidMessage_csr_number(UNSIGNED1 wh) := InValidMessageFT_csr_number(wh);
EXPORT Make_credential_type(SALT31.StrType s0) := MakeFT_credential_type(s0);
EXPORT InValid_credential_type(SALT31.StrType s) := InValidFT_credential_type(s);
EXPORT InValidMessage_credential_type(UNSIGNED1 wh) := InValidMessageFT_credential_type(wh);
EXPORT Make_csr_status(SALT31.StrType s0) := MakeFT_csr_status(s0);
EXPORT InValid_csr_status(SALT31.StrType s) := InValidFT_csr_status(s);
EXPORT InValidMessage_csr_status(UNSIGNED1 wh) := InValidMessageFT_csr_status(wh);
EXPORT Make_sub_status(SALT31.StrType s0) := MakeFT_sub_status(s0);
EXPORT InValid_sub_status(SALT31.StrType s) := InValidFT_sub_status(s);
EXPORT InValidMessage_sub_status(UNSIGNED1 wh) := InValidMessageFT_sub_status(wh);
EXPORT Make_csr_state(SALT31.StrType s0) := MakeFT_csr_state(s0);
EXPORT InValid_csr_state(SALT31.StrType s) := InValidFT_csr_state(s);
EXPORT InValidMessage_csr_state(UNSIGNED1 wh) := InValidMessageFT_csr_state(wh);
EXPORT Make_csr_issue_date(SALT31.StrType s0) := MakeFT_csr_issue_date(s0);
EXPORT InValid_csr_issue_date(SALT31.StrType s) := InValidFT_csr_issue_date(s);
EXPORT InValidMessage_csr_issue_date(UNSIGNED1 wh) := InValidMessageFT_csr_issue_date(wh);
EXPORT Make_effective_date(SALT31.StrType s0) := MakeFT_effective_date(s0);
EXPORT InValid_effective_date(SALT31.StrType s) := InValidFT_effective_date(s);
EXPORT InValidMessage_effective_date(UNSIGNED1 wh) := InValidMessageFT_effective_date(wh);
EXPORT Make_csr_expiration_date(SALT31.StrType s0) := MakeFT_csr_expiration_date(s0);
EXPORT InValid_csr_expiration_date(SALT31.StrType s) := InValidFT_csr_expiration_date(s);
EXPORT InValidMessage_csr_expiration_date(UNSIGNED1 wh) := InValidMessageFT_csr_expiration_date(wh);
EXPORT Make_discipline(SALT31.StrType s0) := MakeFT_discipline(s0);
EXPORT InValid_discipline(SALT31.StrType s) := InValidFT_discipline(s);
EXPORT InValidMessage_discipline(UNSIGNED1 wh) := InValidMessageFT_discipline(wh);
EXPORT Make_all_schedules(SALT31.StrType s0) := MakeFT_all_schedules(s0);
EXPORT InValid_all_schedules(SALT31.StrType s) := InValidFT_all_schedules(s);
EXPORT InValidMessage_all_schedules(UNSIGNED1 wh) := InValidMessageFT_all_schedules(wh);
EXPORT Make_schedule_1(SALT31.StrType s0) := s0;
EXPORT InValid_schedule_1(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_schedule_1(UNSIGNED1 wh) := '';
EXPORT Make_schedule_2(SALT31.StrType s0) := s0;
EXPORT InValid_schedule_2(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_schedule_2(UNSIGNED1 wh) := '';
EXPORT Make_schedule_2n(SALT31.StrType s0) := s0;
EXPORT InValid_schedule_2n(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_schedule_2n(UNSIGNED1 wh) := '';
EXPORT Make_schedule_3(SALT31.StrType s0) := s0;
EXPORT InValid_schedule_3(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_schedule_3(UNSIGNED1 wh) := '';
EXPORT Make_schedule_3n(SALT31.StrType s0) := s0;
EXPORT InValid_schedule_3n(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_schedule_3n(UNSIGNED1 wh) := '';
EXPORT Make_schedule_4(SALT31.StrType s0) := s0;
EXPORT InValid_schedule_4(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_schedule_4(UNSIGNED1 wh) := '';
EXPORT Make_schedule_5(SALT31.StrType s0) := s0;
EXPORT InValid_schedule_5(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_schedule_5(UNSIGNED1 wh) := '';
EXPORT Make_schedule_6(SALT31.StrType s0) := s0;
EXPORT InValid_schedule_6(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_schedule_6(UNSIGNED1 wh) := '';
EXPORT Make_raw_status(SALT31.StrType s0) := s0;
EXPORT InValid_raw_status(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_raw_status(UNSIGNED1 wh) := '';
EXPORT Make_raw_sub_status1(SALT31.StrType s0) := s0;
EXPORT InValid_raw_sub_status1(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_raw_sub_status1(UNSIGNED1 wh) := '';
EXPORT Make_raw_sub_status2(SALT31.StrType s0) := s0;
EXPORT InValid_raw_sub_status2(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_raw_sub_status2(UNSIGNED1 wh) := '';
EXPORT Make_dea_number(SALT31.StrType s0) := s0;
EXPORT InValid_dea_number(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_dea_number(UNSIGNED1 wh) := '';
EXPORT Make_schedules(SALT31.StrType s0) := s0;
EXPORT InValid_schedules(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_schedules(UNSIGNED1 wh) := '';
EXPORT Make_dea_expiration_date(SALT31.StrType s0) := MakeFT_dea_expiration_date(s0);
EXPORT InValid_dea_expiration_date(SALT31.StrType s) := InValidFT_dea_expiration_date(s);
EXPORT InValidMessage_dea_expiration_date(UNSIGNED1 wh) := InValidMessageFT_dea_expiration_date(wh);
EXPORT Make_activity(SALT31.StrType s0) := s0;
EXPORT InValid_activity(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_activity(UNSIGNED1 wh) := '';
EXPORT Make_bac(SALT31.StrType s0) := s0;
EXPORT InValid_bac(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_bac(UNSIGNED1 wh) := '';
EXPORT Make_bac_subcode(SALT31.StrType s0) := s0;
EXPORT InValid_bac_subcode(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_bac_subcode(UNSIGNED1 wh) := '';
EXPORT Make_payment(SALT31.StrType s0) := s0;
EXPORT InValid_payment(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_payment(UNSIGNED1 wh) := '';
EXPORT Make_medicaid_number(SALT31.StrType s0) := s0;
EXPORT InValid_medicaid_number(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_medicaid_number(UNSIGNED1 wh) := '';
EXPORT Make_medicaid_status(SALT31.StrType s0) := s0;
EXPORT InValid_medicaid_status(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_medicaid_status(UNSIGNED1 wh) := '';
EXPORT Make_medicaid_state(SALT31.StrType s0) := s0;
EXPORT InValid_medicaid_state(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_medicaid_state(UNSIGNED1 wh) := '';
EXPORT Make_participation_flag(SALT31.StrType s0) := s0;
EXPORT InValid_participation_flag(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_participation_flag(UNSIGNED1 wh) := '';
EXPORT Make_taxonomy_npi_number(SALT31.StrType s0) := s0;
EXPORT InValid_taxonomy_npi_number(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_taxonomy_npi_number(UNSIGNED1 wh) := '';
EXPORT Make_taxonomy_code(SALT31.StrType s0) := s0;
EXPORT InValid_taxonomy_code(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_taxonomy_code(UNSIGNED1 wh) := '';
EXPORT Make_taxonomy_order_number(SALT31.StrType s0) := s0;
EXPORT InValid_taxonomy_order_number(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_taxonomy_order_number(UNSIGNED1 wh) := '';
EXPORT Make_license_number_state_code(SALT31.StrType s0) := s0;
EXPORT InValid_license_number_state_code(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_license_number_state_code(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT31,Scrubs_HMS_Csr;
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
    BOOLEAN Diff_renewal_date;
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
    BOOLEAN Diff_prefix;
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
    BOOLEAN Diff_employer_identification_number;
    BOOLEAN Diff_raw_full_address;
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
    BOOLEAN Diff_degree;
    BOOLEAN Diff_graduated;
    BOOLEAN Diff_school;
    BOOLEAN Diff_location;
    BOOLEAN Diff_fine;
    BOOLEAN Diff_board;
    BOOLEAN Diff_offense;
    BOOLEAN Diff_offense_date;
    BOOLEAN Diff_action;
    BOOLEAN Diff_action_date;
    BOOLEAN Diff_action_start;
    BOOLEAN Diff_action_end;
    BOOLEAN Diff_npi_number;
    BOOLEAN Diff_replacement_number;
    BOOLEAN Diff_enumeration_date;
    BOOLEAN Diff_last_update_date;
    BOOLEAN Diff_deactivation_date;
    BOOLEAN Diff_reactivation_date;
    BOOLEAN Diff_deactivation_reason;
    BOOLEAN Diff_csr_number;
    BOOLEAN Diff_credential_type;
    BOOLEAN Diff_csr_status;
    BOOLEAN Diff_sub_status;
    BOOLEAN Diff_csr_state;
    BOOLEAN Diff_csr_issue_date;
    BOOLEAN Diff_effective_date;
    BOOLEAN Diff_csr_expiration_date;
    BOOLEAN Diff_discipline;
    BOOLEAN Diff_all_schedules;
    BOOLEAN Diff_schedule_1;
    BOOLEAN Diff_schedule_2;
    BOOLEAN Diff_schedule_2n;
    BOOLEAN Diff_schedule_3;
    BOOLEAN Diff_schedule_3n;
    BOOLEAN Diff_schedule_4;
    BOOLEAN Diff_schedule_5;
    BOOLEAN Diff_schedule_6;
    BOOLEAN Diff_raw_status;
    BOOLEAN Diff_raw_sub_status1;
    BOOLEAN Diff_raw_sub_status2;
    BOOLEAN Diff_dea_number;
    BOOLEAN Diff_schedules;
    BOOLEAN Diff_dea_expiration_date;
    BOOLEAN Diff_activity;
    BOOLEAN Diff_bac;
    BOOLEAN Diff_bac_subcode;
    BOOLEAN Diff_payment;
    BOOLEAN Diff_medicaid_number;
    BOOLEAN Diff_medicaid_status;
    BOOLEAN Diff_medicaid_state;
    BOOLEAN Diff_participation_flag;
    BOOLEAN Diff_taxonomy_npi_number;
    BOOLEAN Diff_taxonomy_code;
    BOOLEAN Diff_taxonomy_order_number;
    BOOLEAN Diff_license_number_state_code;
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
    SELF.Diff_renewal_date := le.renewal_date <> ri.renewal_date;
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
    SELF.Diff_prefix := le.prefix <> ri.prefix;
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
    SELF.Diff_employer_identification_number := le.employer_identification_number <> ri.employer_identification_number;
    SELF.Diff_raw_full_address := le.raw_full_address <> ri.raw_full_address;
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
    SELF.Diff_degree := le.degree <> ri.degree;
    SELF.Diff_graduated := le.graduated <> ri.graduated;
    SELF.Diff_school := le.school <> ri.school;
    SELF.Diff_location := le.location <> ri.location;
    SELF.Diff_fine := le.fine <> ri.fine;
    SELF.Diff_board := le.board <> ri.board;
    SELF.Diff_offense := le.offense <> ri.offense;
    SELF.Diff_offense_date := le.offense_date <> ri.offense_date;
    SELF.Diff_action := le.action <> ri.action;
    SELF.Diff_action_date := le.action_date <> ri.action_date;
    SELF.Diff_action_start := le.action_start <> ri.action_start;
    SELF.Diff_action_end := le.action_end <> ri.action_end;
    SELF.Diff_npi_number := le.npi_number <> ri.npi_number;
    SELF.Diff_replacement_number := le.replacement_number <> ri.replacement_number;
    SELF.Diff_enumeration_date := le.enumeration_date <> ri.enumeration_date;
    SELF.Diff_last_update_date := le.last_update_date <> ri.last_update_date;
    SELF.Diff_deactivation_date := le.deactivation_date <> ri.deactivation_date;
    SELF.Diff_reactivation_date := le.reactivation_date <> ri.reactivation_date;
    SELF.Diff_deactivation_reason := le.deactivation_reason <> ri.deactivation_reason;
    SELF.Diff_csr_number := le.csr_number <> ri.csr_number;
    SELF.Diff_credential_type := le.credential_type <> ri.credential_type;
    SELF.Diff_csr_status := le.csr_status <> ri.csr_status;
    SELF.Diff_sub_status := le.sub_status <> ri.sub_status;
    SELF.Diff_csr_state := le.csr_state <> ri.csr_state;
    SELF.Diff_csr_issue_date := le.csr_issue_date <> ri.csr_issue_date;
    SELF.Diff_effective_date := le.effective_date <> ri.effective_date;
    SELF.Diff_csr_expiration_date := le.csr_expiration_date <> ri.csr_expiration_date;
    SELF.Diff_discipline := le.discipline <> ri.discipline;
    SELF.Diff_all_schedules := le.all_schedules <> ri.all_schedules;
    SELF.Diff_schedule_1 := le.schedule_1 <> ri.schedule_1;
    SELF.Diff_schedule_2 := le.schedule_2 <> ri.schedule_2;
    SELF.Diff_schedule_2n := le.schedule_2n <> ri.schedule_2n;
    SELF.Diff_schedule_3 := le.schedule_3 <> ri.schedule_3;
    SELF.Diff_schedule_3n := le.schedule_3n <> ri.schedule_3n;
    SELF.Diff_schedule_4 := le.schedule_4 <> ri.schedule_4;
    SELF.Diff_schedule_5 := le.schedule_5 <> ri.schedule_5;
    SELF.Diff_schedule_6 := le.schedule_6 <> ri.schedule_6;
    SELF.Diff_raw_status := le.raw_status <> ri.raw_status;
    SELF.Diff_raw_sub_status1 := le.raw_sub_status1 <> ri.raw_sub_status1;
    SELF.Diff_raw_sub_status2 := le.raw_sub_status2 <> ri.raw_sub_status2;
    SELF.Diff_dea_number := le.dea_number <> ri.dea_number;
    SELF.Diff_schedules := le.schedules <> ri.schedules;
    SELF.Diff_dea_expiration_date := le.dea_expiration_date <> ri.dea_expiration_date;
    SELF.Diff_activity := le.activity <> ri.activity;
    SELF.Diff_bac := le.bac <> ri.bac;
    SELF.Diff_bac_subcode := le.bac_subcode <> ri.bac_subcode;
    SELF.Diff_payment := le.payment <> ri.payment;
    SELF.Diff_medicaid_number := le.medicaid_number <> ri.medicaid_number;
    SELF.Diff_medicaid_status := le.medicaid_status <> ri.medicaid_status;
    SELF.Diff_medicaid_state := le.medicaid_state <> ri.medicaid_state;
    SELF.Diff_participation_flag := le.participation_flag <> ri.participation_flag;
    SELF.Diff_taxonomy_npi_number := le.taxonomy_npi_number <> ri.taxonomy_npi_number;
    SELF.Diff_taxonomy_code := le.taxonomy_code <> ri.taxonomy_code;
    SELF.Diff_taxonomy_order_number := le.taxonomy_order_number <> ri.taxonomy_order_number;
    SELF.Diff_license_number_state_code := le.license_number_state_code <> ri.license_number_state_code;
    SELF.Val := (SALT31.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_ln_key,1,0)+ IF( SELF.Diff_hms_src,1,0)+ IF( SELF.Diff_key,1,0)+ IF( SELF.Diff_id,1,0)+ IF( SELF.Diff_entityid,1,0)+ IF( SELF.Diff_license_number,1,0)+ IF( SELF.Diff_license_class_type,1,0)+ IF( SELF.Diff_license_state,1,0)+ IF( SELF.Diff_status,1,0)+ IF( SELF.Diff_issue_date,1,0)+ IF( SELF.Diff_renewal_date,1,0)+ IF( SELF.Diff_expiration_date,1,0)+ IF( SELF.Diff_qualifier1,1,0)+ IF( SELF.Diff_qualifier2,1,0)+ IF( SELF.Diff_qualifier3,1,0)+ IF( SELF.Diff_qualifier4,1,0)+ IF( SELF.Diff_qualifier5,1,0)+ IF( SELF.Diff_rawclass,1,0)+ IF( SELF.Diff_rawissue_date,1,0)+ IF( SELF.Diff_rawexpiration_date,1,0)+ IF( SELF.Diff_rawstatus,1,0)+ IF( SELF.Diff_raw_number,1,0)+ IF( SELF.Diff_name,1,0)+ IF( SELF.Diff_prefix,1,0)+ IF( SELF.Diff_first,1,0)+ IF( SELF.Diff_middle,1,0)+ IF( SELF.Diff_last,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_cred,1,0)+ IF( SELF.Diff_age,1,0)+ IF( SELF.Diff_dateofbirth,1,0)+ IF( SELF.Diff_email,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_dateofdeath,1,0)+ IF( SELF.Diff_employer_identification_number,1,0)+ IF( SELF.Diff_raw_full_address,1,0)+ IF( SELF.Diff_firmname,1,0)+ IF( SELF.Diff_street1,1,0)+ IF( SELF.Diff_street2,1,0)+ IF( SELF.Diff_street3,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_address_state,1,0)+ IF( SELF.Diff_orig_zip,1,0)+ IF( SELF.Diff_orig_county,1,0)+ IF( SELF.Diff_country,1,0)+ IF( SELF.Diff_address_type,1,0)+ IF( SELF.Diff_phone1,1,0)+ IF( SELF.Diff_phone2,1,0)+ IF( SELF.Diff_phone3,1,0)+ IF( SELF.Diff_fax1,1,0)+ IF( SELF.Diff_fax2,1,0)+ IF( SELF.Diff_fax3,1,0)+ IF( SELF.Diff_other_phone1,1,0)+ IF( SELF.Diff_description,1,0)+ IF( SELF.Diff_specialty_class_type,1,0)+ IF( SELF.Diff_phone_number,1,0)+ IF( SELF.Diff_phone_type,1,0)+ IF( SELF.Diff_language,1,0)+ IF( SELF.Diff_degree,1,0)+ IF( SELF.Diff_graduated,1,0)+ IF( SELF.Diff_school,1,0)+ IF( SELF.Diff_location,1,0)+ IF( SELF.Diff_fine,1,0)+ IF( SELF.Diff_board,1,0)+ IF( SELF.Diff_offense,1,0)+ IF( SELF.Diff_offense_date,1,0)+ IF( SELF.Diff_action,1,0)+ IF( SELF.Diff_action_date,1,0)+ IF( SELF.Diff_action_start,1,0)+ IF( SELF.Diff_action_end,1,0)+ IF( SELF.Diff_npi_number,1,0)+ IF( SELF.Diff_replacement_number,1,0)+ IF( SELF.Diff_enumeration_date,1,0)+ IF( SELF.Diff_last_update_date,1,0)+ IF( SELF.Diff_deactivation_date,1,0)+ IF( SELF.Diff_reactivation_date,1,0)+ IF( SELF.Diff_deactivation_reason,1,0)+ IF( SELF.Diff_csr_number,1,0)+ IF( SELF.Diff_credential_type,1,0)+ IF( SELF.Diff_csr_status,1,0)+ IF( SELF.Diff_sub_status,1,0)+ IF( SELF.Diff_csr_state,1,0)+ IF( SELF.Diff_csr_issue_date,1,0)+ IF( SELF.Diff_effective_date,1,0)+ IF( SELF.Diff_csr_expiration_date,1,0)+ IF( SELF.Diff_discipline,1,0)+ IF( SELF.Diff_all_schedules,1,0)+ IF( SELF.Diff_schedule_1,1,0)+ IF( SELF.Diff_schedule_2,1,0)+ IF( SELF.Diff_schedule_2n,1,0)+ IF( SELF.Diff_schedule_3,1,0)+ IF( SELF.Diff_schedule_3n,1,0)+ IF( SELF.Diff_schedule_4,1,0)+ IF( SELF.Diff_schedule_5,1,0)+ IF( SELF.Diff_schedule_6,1,0)+ IF( SELF.Diff_raw_status,1,0)+ IF( SELF.Diff_raw_sub_status1,1,0)+ IF( SELF.Diff_raw_sub_status2,1,0)+ IF( SELF.Diff_dea_number,1,0)+ IF( SELF.Diff_schedules,1,0)+ IF( SELF.Diff_dea_expiration_date,1,0)+ IF( SELF.Diff_activity,1,0)+ IF( SELF.Diff_bac,1,0)+ IF( SELF.Diff_bac_subcode,1,0)+ IF( SELF.Diff_payment,1,0)+ IF( SELF.Diff_medicaid_number,1,0)+ IF( SELF.Diff_medicaid_status,1,0)+ IF( SELF.Diff_medicaid_state,1,0)+ IF( SELF.Diff_participation_flag,1,0)+ IF( SELF.Diff_taxonomy_npi_number,1,0)+ IF( SELF.Diff_taxonomy_code,1,0)+ IF( SELF.Diff_taxonomy_order_number,1,0)+ IF( SELF.Diff_license_number_state_code,1,0);
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
    Count_Diff_renewal_date := COUNT(GROUP,%Closest%.Diff_renewal_date);
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
    Count_Diff_prefix := COUNT(GROUP,%Closest%.Diff_prefix);
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
    Count_Diff_employer_identification_number := COUNT(GROUP,%Closest%.Diff_employer_identification_number);
    Count_Diff_raw_full_address := COUNT(GROUP,%Closest%.Diff_raw_full_address);
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
    Count_Diff_degree := COUNT(GROUP,%Closest%.Diff_degree);
    Count_Diff_graduated := COUNT(GROUP,%Closest%.Diff_graduated);
    Count_Diff_school := COUNT(GROUP,%Closest%.Diff_school);
    Count_Diff_location := COUNT(GROUP,%Closest%.Diff_location);
    Count_Diff_fine := COUNT(GROUP,%Closest%.Diff_fine);
    Count_Diff_board := COUNT(GROUP,%Closest%.Diff_board);
    Count_Diff_offense := COUNT(GROUP,%Closest%.Diff_offense);
    Count_Diff_offense_date := COUNT(GROUP,%Closest%.Diff_offense_date);
    Count_Diff_action := COUNT(GROUP,%Closest%.Diff_action);
    Count_Diff_action_date := COUNT(GROUP,%Closest%.Diff_action_date);
    Count_Diff_action_start := COUNT(GROUP,%Closest%.Diff_action_start);
    Count_Diff_action_end := COUNT(GROUP,%Closest%.Diff_action_end);
    Count_Diff_npi_number := COUNT(GROUP,%Closest%.Diff_npi_number);
    Count_Diff_replacement_number := COUNT(GROUP,%Closest%.Diff_replacement_number);
    Count_Diff_enumeration_date := COUNT(GROUP,%Closest%.Diff_enumeration_date);
    Count_Diff_last_update_date := COUNT(GROUP,%Closest%.Diff_last_update_date);
    Count_Diff_deactivation_date := COUNT(GROUP,%Closest%.Diff_deactivation_date);
    Count_Diff_reactivation_date := COUNT(GROUP,%Closest%.Diff_reactivation_date);
    Count_Diff_deactivation_reason := COUNT(GROUP,%Closest%.Diff_deactivation_reason);
    Count_Diff_csr_number := COUNT(GROUP,%Closest%.Diff_csr_number);
    Count_Diff_credential_type := COUNT(GROUP,%Closest%.Diff_credential_type);
    Count_Diff_csr_status := COUNT(GROUP,%Closest%.Diff_csr_status);
    Count_Diff_sub_status := COUNT(GROUP,%Closest%.Diff_sub_status);
    Count_Diff_csr_state := COUNT(GROUP,%Closest%.Diff_csr_state);
    Count_Diff_csr_issue_date := COUNT(GROUP,%Closest%.Diff_csr_issue_date);
    Count_Diff_effective_date := COUNT(GROUP,%Closest%.Diff_effective_date);
    Count_Diff_csr_expiration_date := COUNT(GROUP,%Closest%.Diff_csr_expiration_date);
    Count_Diff_discipline := COUNT(GROUP,%Closest%.Diff_discipline);
    Count_Diff_all_schedules := COUNT(GROUP,%Closest%.Diff_all_schedules);
    Count_Diff_schedule_1 := COUNT(GROUP,%Closest%.Diff_schedule_1);
    Count_Diff_schedule_2 := COUNT(GROUP,%Closest%.Diff_schedule_2);
    Count_Diff_schedule_2n := COUNT(GROUP,%Closest%.Diff_schedule_2n);
    Count_Diff_schedule_3 := COUNT(GROUP,%Closest%.Diff_schedule_3);
    Count_Diff_schedule_3n := COUNT(GROUP,%Closest%.Diff_schedule_3n);
    Count_Diff_schedule_4 := COUNT(GROUP,%Closest%.Diff_schedule_4);
    Count_Diff_schedule_5 := COUNT(GROUP,%Closest%.Diff_schedule_5);
    Count_Diff_schedule_6 := COUNT(GROUP,%Closest%.Diff_schedule_6);
    Count_Diff_raw_status := COUNT(GROUP,%Closest%.Diff_raw_status);
    Count_Diff_raw_sub_status1 := COUNT(GROUP,%Closest%.Diff_raw_sub_status1);
    Count_Diff_raw_sub_status2 := COUNT(GROUP,%Closest%.Diff_raw_sub_status2);
    Count_Diff_dea_number := COUNT(GROUP,%Closest%.Diff_dea_number);
    Count_Diff_schedules := COUNT(GROUP,%Closest%.Diff_schedules);
    Count_Diff_dea_expiration_date := COUNT(GROUP,%Closest%.Diff_dea_expiration_date);
    Count_Diff_activity := COUNT(GROUP,%Closest%.Diff_activity);
    Count_Diff_bac := COUNT(GROUP,%Closest%.Diff_bac);
    Count_Diff_bac_subcode := COUNT(GROUP,%Closest%.Diff_bac_subcode);
    Count_Diff_payment := COUNT(GROUP,%Closest%.Diff_payment);
    Count_Diff_medicaid_number := COUNT(GROUP,%Closest%.Diff_medicaid_number);
    Count_Diff_medicaid_status := COUNT(GROUP,%Closest%.Diff_medicaid_status);
    Count_Diff_medicaid_state := COUNT(GROUP,%Closest%.Diff_medicaid_state);
    Count_Diff_participation_flag := COUNT(GROUP,%Closest%.Diff_participation_flag);
    Count_Diff_taxonomy_npi_number := COUNT(GROUP,%Closest%.Diff_taxonomy_npi_number);
    Count_Diff_taxonomy_code := COUNT(GROUP,%Closest%.Diff_taxonomy_code);
    Count_Diff_taxonomy_order_number := COUNT(GROUP,%Closest%.Diff_taxonomy_order_number);
    Count_Diff_license_number_state_code := COUNT(GROUP,%Closest%.Diff_license_number_state_code);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
