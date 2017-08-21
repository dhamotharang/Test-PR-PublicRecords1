IMPORT ut,SALT31;
EXPORT SRecord_Fields := MODULE
// Processing for each FieldType
EXPORT SALT31.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'claim_num','claim_rec_type','line_number','service_from','service_to','place_service','cpt_code','proc_qual','proc_mod1','proc_mod2','proc_mod3','line_charge','units','revenue_code','diag_code1','diag_code2','diag_code3','diag_code4','ambulance_to_hosp','emergency','paid_date','bene_not_entitled','patient_reach_max','svc_during_postop','pid','src','dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','ln_record_type','clean_service_from','clean_service_to','clean_paid_date');
EXPORT FieldTypeNum(SALT31.StrType fn) := CASE(fn,'claim_num' => 1,'claim_rec_type' => 2,'line_number' => 3,'service_from' => 4,'service_to' => 5,'place_service' => 6,'cpt_code' => 7,'proc_qual' => 8,'proc_mod1' => 9,'proc_mod2' => 10,'proc_mod3' => 11,'line_charge' => 12,'units' => 13,'revenue_code' => 14,'diag_code1' => 15,'diag_code2' => 16,'diag_code3' => 17,'diag_code4' => 18,'ambulance_to_hosp' => 19,'emergency' => 20,'paid_date' => 21,'bene_not_entitled' => 22,'patient_reach_max' => 23,'svc_during_postop' => 24,'pid' => 25,'src' => 26,'dt_vendor_first_reported' => 27,'dt_vendor_last_reported' => 28,'dt_first_seen' => 29,'dt_last_seen' => 30,'ln_record_type' => 31,'clean_service_from' => 32,'clean_service_to' => 33,'clean_paid_date' => 34,0);
EXPORT MakeFT_claim_num(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789EIP '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_claim_num(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789EIP '))),~(LENGTH(TRIM(s)) = 17),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_claim_num(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789EIP '),SALT31.HygieneErrors.NotLength('17'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_claim_rec_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'S '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_claim_rec_type(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'S '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_claim_rec_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('S '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_line_number(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_line_number(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_line_number(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('1,2'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_service_from(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_service_from(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_service_from(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('8,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_service_to(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_service_to(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_service_to(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('8,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_place_service(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_place_service(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_place_service(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('2,1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_cpt_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ABCEFGHJKLQSTV '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_cpt_code(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ABCEFGHJKLQSTV '))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_cpt_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ABCEFGHJKLQSTV '),SALT31.HygieneErrors.NotLength('5,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_proc_qual(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'CH '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_proc_qual(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'CH '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_proc_qual(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('CH '),SALT31.HygieneErrors.NotLength('2,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_proc_mod1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_proc_mod1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_proc_mod1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.NotLength('0,2'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_proc_mod2(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ACDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_proc_mod2(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ACDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_proc_mod2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ACDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.NotLength('0,2'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_proc_mod3(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ABCDEFGHIKLNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_proc_mod3(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ABCDEFGHIKLNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_proc_mod3(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ABCDEFGHIKLNOPQRSTUVWXYZ '),SALT31.HygieneErrors.NotLength('0,2'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_line_charge(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_line_charge(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_line_charge(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_units(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_units(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_units(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_revenue_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_revenue_code(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_revenue_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_diag_code1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'1234567 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'1234567 '))),~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('1234567 '),SALT31.HygieneErrors.NotLength('1,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_diag_code2(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'1234567 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code2(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'1234567 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('1234567 '),SALT31.HygieneErrors.NotLength('0,1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_diag_code3(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'1234567 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code3(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'1234567 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code3(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('1234567 '),SALT31.HygieneErrors.NotLength('0,1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_diag_code4(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'12345678 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code4(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'12345678 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code4(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('12345678 '),SALT31.HygieneErrors.NotLength('0,1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_ambulance_to_hosp(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_ambulance_to_hosp(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_ambulance_to_hosp(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('N '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_emergency(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'NY '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_emergency(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'NY '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_emergency(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('NY '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_paid_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_paid_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_paid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('8,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_bene_not_entitled(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_bene_not_entitled(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_bene_not_entitled(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('N '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_patient_reach_max(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_patient_reach_max(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_patient_reach_max(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('N '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_svc_during_postop(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'N '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_svc_during_postop(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'N '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_svc_during_postop(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('N '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_pid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_pid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0 '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_pid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0 '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_src(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'7U '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_src(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'7U '))),~(LENGTH(TRIM(s)) = 2),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_src(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('7U '),SALT31.HygieneErrors.NotLength('2'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dt_vendor_first_reported(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123459 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dt_vendor_first_reported(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123459 '))),~(LENGTH(TRIM(s)) = 6),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dt_vendor_first_reported(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123459 '),SALT31.HygieneErrors.NotLength('6'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dt_vendor_last_reported(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123459 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dt_vendor_last_reported(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123459 '))),~(LENGTH(TRIM(s)) = 6),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dt_vendor_last_reported(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123459 '),SALT31.HygieneErrors.NotLength('6'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dt_first_seen(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dt_first_seen(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0 '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dt_first_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0 '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dt_last_seen(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dt_last_seen(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0 '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dt_last_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0 '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_ln_record_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'CH '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_ln_record_type(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'CH '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_ln_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('CH '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_service_from(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_service_from(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_clean_service_from(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('8,1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_service_to(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_service_to(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_clean_service_to(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('8,1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_paid_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_paid_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_clean_paid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('8,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT SALT31.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'claim_num','claim_rec_type','line_number','service_from','service_to','place_service','cpt_code','proc_qual','proc_mod1','proc_mod2','proc_mod3','proc_mod4','line_charge','line_allowed','units','revenue_code','diag_code1','diag_code2','diag_code3','diag_code4','diag_code5','diag_code6','diag_code7','diag_code8','ndc','ambulance_to_hosp','emergency','tooth_surface','oral_cavity','service_type','copay','paid_amount','paid_date','bene_not_entitled','patient_reach_max','svc_during_postop','adjudicated_proc','adjudicated_proc_qual','adjudicated_proc_mod1','adjudicated_proc_mod2','adjudicated_proc_mod3','adjudicated_proc_mod4','pid','src','dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','ln_record_type','clean_service_from','clean_service_to','clean_paid_date');
EXPORT FieldNum(SALT31.StrType fn) := CASE(fn,'claim_num' => 1,'claim_rec_type' => 2,'line_number' => 3,'service_from' => 4,'service_to' => 5,'place_service' => 6,'cpt_code' => 7,'proc_qual' => 8,'proc_mod1' => 9,'proc_mod2' => 10,'proc_mod3' => 11,'proc_mod4' => 12,'line_charge' => 13,'line_allowed' => 14,'units' => 15,'revenue_code' => 16,'diag_code1' => 17,'diag_code2' => 18,'diag_code3' => 19,'diag_code4' => 20,'diag_code5' => 21,'diag_code6' => 22,'diag_code7' => 23,'diag_code8' => 24,'ndc' => 25,'ambulance_to_hosp' => 26,'emergency' => 27,'tooth_surface' => 28,'oral_cavity' => 29,'service_type' => 30,'copay' => 31,'paid_amount' => 32,'paid_date' => 33,'bene_not_entitled' => 34,'patient_reach_max' => 35,'svc_during_postop' => 36,'adjudicated_proc' => 37,'adjudicated_proc_qual' => 38,'adjudicated_proc_mod1' => 39,'adjudicated_proc_mod2' => 40,'adjudicated_proc_mod3' => 41,'adjudicated_proc_mod4' => 42,'pid' => 43,'src' => 44,'dt_vendor_first_reported' => 45,'dt_vendor_last_reported' => 46,'dt_first_seen' => 47,'dt_last_seen' => 48,'ln_record_type' => 49,'clean_service_from' => 50,'clean_service_to' => 51,'clean_paid_date' => 52,0);
//Individual field level validation
EXPORT Make_claim_num(SALT31.StrType s0) := MakeFT_claim_num(s0);
EXPORT InValid_claim_num(SALT31.StrType s) := InValidFT_claim_num(s);
EXPORT InValidMessage_claim_num(UNSIGNED1 wh) := InValidMessageFT_claim_num(wh);
EXPORT Make_claim_rec_type(SALT31.StrType s0) := MakeFT_claim_rec_type(s0);
EXPORT InValid_claim_rec_type(SALT31.StrType s) := InValidFT_claim_rec_type(s);
EXPORT InValidMessage_claim_rec_type(UNSIGNED1 wh) := InValidMessageFT_claim_rec_type(wh);
EXPORT Make_line_number(SALT31.StrType s0) := MakeFT_line_number(s0);
EXPORT InValid_line_number(SALT31.StrType s) := InValidFT_line_number(s);
EXPORT InValidMessage_line_number(UNSIGNED1 wh) := InValidMessageFT_line_number(wh);
EXPORT Make_service_from(SALT31.StrType s0) := MakeFT_service_from(s0);
EXPORT InValid_service_from(SALT31.StrType s) := InValidFT_service_from(s);
EXPORT InValidMessage_service_from(UNSIGNED1 wh) := InValidMessageFT_service_from(wh);
EXPORT Make_service_to(SALT31.StrType s0) := MakeFT_service_to(s0);
EXPORT InValid_service_to(SALT31.StrType s) := InValidFT_service_to(s);
EXPORT InValidMessage_service_to(UNSIGNED1 wh) := InValidMessageFT_service_to(wh);
EXPORT Make_place_service(SALT31.StrType s0) := MakeFT_place_service(s0);
EXPORT InValid_place_service(SALT31.StrType s) := InValidFT_place_service(s);
EXPORT InValidMessage_place_service(UNSIGNED1 wh) := InValidMessageFT_place_service(wh);
EXPORT Make_cpt_code(SALT31.StrType s0) := MakeFT_cpt_code(s0);
EXPORT InValid_cpt_code(SALT31.StrType s) := InValidFT_cpt_code(s);
EXPORT InValidMessage_cpt_code(UNSIGNED1 wh) := InValidMessageFT_cpt_code(wh);
EXPORT Make_proc_qual(SALT31.StrType s0) := MakeFT_proc_qual(s0);
EXPORT InValid_proc_qual(SALT31.StrType s) := InValidFT_proc_qual(s);
EXPORT InValidMessage_proc_qual(UNSIGNED1 wh) := InValidMessageFT_proc_qual(wh);
EXPORT Make_proc_mod1(SALT31.StrType s0) := MakeFT_proc_mod1(s0);
EXPORT InValid_proc_mod1(SALT31.StrType s) := InValidFT_proc_mod1(s);
EXPORT InValidMessage_proc_mod1(UNSIGNED1 wh) := InValidMessageFT_proc_mod1(wh);
EXPORT Make_proc_mod2(SALT31.StrType s0) := MakeFT_proc_mod2(s0);
EXPORT InValid_proc_mod2(SALT31.StrType s) := InValidFT_proc_mod2(s);
EXPORT InValidMessage_proc_mod2(UNSIGNED1 wh) := InValidMessageFT_proc_mod2(wh);
EXPORT Make_proc_mod3(SALT31.StrType s0) := MakeFT_proc_mod3(s0);
EXPORT InValid_proc_mod3(SALT31.StrType s) := InValidFT_proc_mod3(s);
EXPORT InValidMessage_proc_mod3(UNSIGNED1 wh) := InValidMessageFT_proc_mod3(wh);
EXPORT Make_proc_mod4(SALT31.StrType s0) := s0;
EXPORT InValid_proc_mod4(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_proc_mod4(UNSIGNED1 wh) := '';
EXPORT Make_line_charge(SALT31.StrType s0) := MakeFT_line_charge(s0);
EXPORT InValid_line_charge(SALT31.StrType s) := InValidFT_line_charge(s);
EXPORT InValidMessage_line_charge(UNSIGNED1 wh) := InValidMessageFT_line_charge(wh);
EXPORT Make_line_allowed(SALT31.StrType s0) := s0;
EXPORT InValid_line_allowed(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_line_allowed(UNSIGNED1 wh) := '';
EXPORT Make_units(SALT31.StrType s0) := MakeFT_units(s0);
EXPORT InValid_units(SALT31.StrType s) := InValidFT_units(s);
EXPORT InValidMessage_units(UNSIGNED1 wh) := InValidMessageFT_units(wh);
EXPORT Make_revenue_code(SALT31.StrType s0) := MakeFT_revenue_code(s0);
EXPORT InValid_revenue_code(SALT31.StrType s) := InValidFT_revenue_code(s);
EXPORT InValidMessage_revenue_code(UNSIGNED1 wh) := InValidMessageFT_revenue_code(wh);
EXPORT Make_diag_code1(SALT31.StrType s0) := MakeFT_diag_code1(s0);
EXPORT InValid_diag_code1(SALT31.StrType s) := InValidFT_diag_code1(s);
EXPORT InValidMessage_diag_code1(UNSIGNED1 wh) := InValidMessageFT_diag_code1(wh);
EXPORT Make_diag_code2(SALT31.StrType s0) := MakeFT_diag_code2(s0);
EXPORT InValid_diag_code2(SALT31.StrType s) := InValidFT_diag_code2(s);
EXPORT InValidMessage_diag_code2(UNSIGNED1 wh) := InValidMessageFT_diag_code2(wh);
EXPORT Make_diag_code3(SALT31.StrType s0) := MakeFT_diag_code3(s0);
EXPORT InValid_diag_code3(SALT31.StrType s) := InValidFT_diag_code3(s);
EXPORT InValidMessage_diag_code3(UNSIGNED1 wh) := InValidMessageFT_diag_code3(wh);
EXPORT Make_diag_code4(SALT31.StrType s0) := MakeFT_diag_code4(s0);
EXPORT InValid_diag_code4(SALT31.StrType s) := InValidFT_diag_code4(s);
EXPORT InValidMessage_diag_code4(UNSIGNED1 wh) := InValidMessageFT_diag_code4(wh);
EXPORT Make_diag_code5(SALT31.StrType s0) := s0;
EXPORT InValid_diag_code5(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_diag_code5(UNSIGNED1 wh) := '';
EXPORT Make_diag_code6(SALT31.StrType s0) := s0;
EXPORT InValid_diag_code6(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_diag_code6(UNSIGNED1 wh) := '';
EXPORT Make_diag_code7(SALT31.StrType s0) := s0;
EXPORT InValid_diag_code7(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_diag_code7(UNSIGNED1 wh) := '';
EXPORT Make_diag_code8(SALT31.StrType s0) := s0;
EXPORT InValid_diag_code8(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_diag_code8(UNSIGNED1 wh) := '';
EXPORT Make_ndc(SALT31.StrType s0) := s0;
EXPORT InValid_ndc(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_ndc(UNSIGNED1 wh) := '';
EXPORT Make_ambulance_to_hosp(SALT31.StrType s0) := MakeFT_ambulance_to_hosp(s0);
EXPORT InValid_ambulance_to_hosp(SALT31.StrType s) := InValidFT_ambulance_to_hosp(s);
EXPORT InValidMessage_ambulance_to_hosp(UNSIGNED1 wh) := InValidMessageFT_ambulance_to_hosp(wh);
EXPORT Make_emergency(SALT31.StrType s0) := MakeFT_emergency(s0);
EXPORT InValid_emergency(SALT31.StrType s) := InValidFT_emergency(s);
EXPORT InValidMessage_emergency(UNSIGNED1 wh) := InValidMessageFT_emergency(wh);
EXPORT Make_tooth_surface(SALT31.StrType s0) := s0;
EXPORT InValid_tooth_surface(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_tooth_surface(UNSIGNED1 wh) := '';
EXPORT Make_oral_cavity(SALT31.StrType s0) := s0;
EXPORT InValid_oral_cavity(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_oral_cavity(UNSIGNED1 wh) := '';
EXPORT Make_service_type(SALT31.StrType s0) := s0;
EXPORT InValid_service_type(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_service_type(UNSIGNED1 wh) := '';
EXPORT Make_copay(SALT31.StrType s0) := s0;
EXPORT InValid_copay(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_copay(UNSIGNED1 wh) := '';
EXPORT Make_paid_amount(SALT31.StrType s0) := s0;
EXPORT InValid_paid_amount(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_paid_amount(UNSIGNED1 wh) := '';
EXPORT Make_paid_date(SALT31.StrType s0) := MakeFT_paid_date(s0);
EXPORT InValid_paid_date(SALT31.StrType s) := InValidFT_paid_date(s);
EXPORT InValidMessage_paid_date(UNSIGNED1 wh) := InValidMessageFT_paid_date(wh);
EXPORT Make_bene_not_entitled(SALT31.StrType s0) := MakeFT_bene_not_entitled(s0);
EXPORT InValid_bene_not_entitled(SALT31.StrType s) := InValidFT_bene_not_entitled(s);
EXPORT InValidMessage_bene_not_entitled(UNSIGNED1 wh) := InValidMessageFT_bene_not_entitled(wh);
EXPORT Make_patient_reach_max(SALT31.StrType s0) := MakeFT_patient_reach_max(s0);
EXPORT InValid_patient_reach_max(SALT31.StrType s) := InValidFT_patient_reach_max(s);
EXPORT InValidMessage_patient_reach_max(UNSIGNED1 wh) := InValidMessageFT_patient_reach_max(wh);
EXPORT Make_svc_during_postop(SALT31.StrType s0) := MakeFT_svc_during_postop(s0);
EXPORT InValid_svc_during_postop(SALT31.StrType s) := InValidFT_svc_during_postop(s);
EXPORT InValidMessage_svc_during_postop(UNSIGNED1 wh) := InValidMessageFT_svc_during_postop(wh);
EXPORT Make_adjudicated_proc(SALT31.StrType s0) := s0;
EXPORT InValid_adjudicated_proc(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_adjudicated_proc(UNSIGNED1 wh) := '';
EXPORT Make_adjudicated_proc_qual(SALT31.StrType s0) := s0;
EXPORT InValid_adjudicated_proc_qual(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_adjudicated_proc_qual(UNSIGNED1 wh) := '';
EXPORT Make_adjudicated_proc_mod1(SALT31.StrType s0) := s0;
EXPORT InValid_adjudicated_proc_mod1(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_adjudicated_proc_mod1(UNSIGNED1 wh) := '';
EXPORT Make_adjudicated_proc_mod2(SALT31.StrType s0) := s0;
EXPORT InValid_adjudicated_proc_mod2(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_adjudicated_proc_mod2(UNSIGNED1 wh) := '';
EXPORT Make_adjudicated_proc_mod3(SALT31.StrType s0) := s0;
EXPORT InValid_adjudicated_proc_mod3(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_adjudicated_proc_mod3(UNSIGNED1 wh) := '';
EXPORT Make_adjudicated_proc_mod4(SALT31.StrType s0) := s0;
EXPORT InValid_adjudicated_proc_mod4(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_adjudicated_proc_mod4(UNSIGNED1 wh) := '';
EXPORT Make_pid(SALT31.StrType s0) := MakeFT_pid(s0);
EXPORT InValid_pid(SALT31.StrType s) := InValidFT_pid(s);
EXPORT InValidMessage_pid(UNSIGNED1 wh) := InValidMessageFT_pid(wh);
EXPORT Make_src(SALT31.StrType s0) := MakeFT_src(s0);
EXPORT InValid_src(SALT31.StrType s) := InValidFT_src(s);
EXPORT InValidMessage_src(UNSIGNED1 wh) := InValidMessageFT_src(wh);
EXPORT Make_dt_vendor_first_reported(SALT31.StrType s0) := MakeFT_dt_vendor_first_reported(s0);
EXPORT InValid_dt_vendor_first_reported(SALT31.StrType s) := InValidFT_dt_vendor_first_reported(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_dt_vendor_first_reported(wh);
EXPORT Make_dt_vendor_last_reported(SALT31.StrType s0) := MakeFT_dt_vendor_last_reported(s0);
EXPORT InValid_dt_vendor_last_reported(SALT31.StrType s) := InValidFT_dt_vendor_last_reported(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_dt_vendor_last_reported(wh);
EXPORT Make_dt_first_seen(SALT31.StrType s0) := MakeFT_dt_first_seen(s0);
EXPORT InValid_dt_first_seen(SALT31.StrType s) := InValidFT_dt_first_seen(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_dt_first_seen(wh);
EXPORT Make_dt_last_seen(SALT31.StrType s0) := MakeFT_dt_last_seen(s0);
EXPORT InValid_dt_last_seen(SALT31.StrType s) := InValidFT_dt_last_seen(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_dt_last_seen(wh);
EXPORT Make_ln_record_type(SALT31.StrType s0) := MakeFT_ln_record_type(s0);
EXPORT InValid_ln_record_type(SALT31.StrType s) := InValidFT_ln_record_type(s);
EXPORT InValidMessage_ln_record_type(UNSIGNED1 wh) := InValidMessageFT_ln_record_type(wh);
EXPORT Make_clean_service_from(SALT31.StrType s0) := MakeFT_clean_service_from(s0);
EXPORT InValid_clean_service_from(SALT31.StrType s) := InValidFT_clean_service_from(s);
EXPORT InValidMessage_clean_service_from(UNSIGNED1 wh) := InValidMessageFT_clean_service_from(wh);
EXPORT Make_clean_service_to(SALT31.StrType s0) := MakeFT_clean_service_to(s0);
EXPORT InValid_clean_service_to(SALT31.StrType s) := InValidFT_clean_service_to(s);
EXPORT InValidMessage_clean_service_to(UNSIGNED1 wh) := InValidMessageFT_clean_service_to(wh);
EXPORT Make_clean_paid_date(SALT31.StrType s0) := MakeFT_clean_paid_date(s0);
EXPORT InValid_clean_paid_date(SALT31.StrType s) := InValidFT_clean_paid_date(s);
EXPORT InValidMessage_clean_paid_date(UNSIGNED1 wh) := InValidMessageFT_clean_paid_date(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT31,Scrubs_Emdeon_SRecord;
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
    BOOLEAN Diff_claim_num;
    BOOLEAN Diff_claim_rec_type;
    BOOLEAN Diff_line_number;
    BOOLEAN Diff_service_from;
    BOOLEAN Diff_service_to;
    BOOLEAN Diff_place_service;
    BOOLEAN Diff_cpt_code;
    BOOLEAN Diff_proc_qual;
    BOOLEAN Diff_proc_mod1;
    BOOLEAN Diff_proc_mod2;
    BOOLEAN Diff_proc_mod3;
    BOOLEAN Diff_proc_mod4;
    BOOLEAN Diff_line_charge;
    BOOLEAN Diff_line_allowed;
    BOOLEAN Diff_units;
    BOOLEAN Diff_revenue_code;
    BOOLEAN Diff_diag_code1;
    BOOLEAN Diff_diag_code2;
    BOOLEAN Diff_diag_code3;
    BOOLEAN Diff_diag_code4;
    BOOLEAN Diff_diag_code5;
    BOOLEAN Diff_diag_code6;
    BOOLEAN Diff_diag_code7;
    BOOLEAN Diff_diag_code8;
    BOOLEAN Diff_ndc;
    BOOLEAN Diff_ambulance_to_hosp;
    BOOLEAN Diff_emergency;
    BOOLEAN Diff_tooth_surface;
    BOOLEAN Diff_oral_cavity;
    BOOLEAN Diff_service_type;
    BOOLEAN Diff_copay;
    BOOLEAN Diff_paid_amount;
    BOOLEAN Diff_paid_date;
    BOOLEAN Diff_bene_not_entitled;
    BOOLEAN Diff_patient_reach_max;
    BOOLEAN Diff_svc_during_postop;
    BOOLEAN Diff_adjudicated_proc;
    BOOLEAN Diff_adjudicated_proc_qual;
    BOOLEAN Diff_adjudicated_proc_mod1;
    BOOLEAN Diff_adjudicated_proc_mod2;
    BOOLEAN Diff_adjudicated_proc_mod3;
    BOOLEAN Diff_adjudicated_proc_mod4;
    BOOLEAN Diff_pid;
    BOOLEAN Diff_src;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_ln_record_type;
    BOOLEAN Diff_clean_service_from;
    BOOLEAN Diff_clean_service_to;
    BOOLEAN Diff_clean_paid_date;
    UNSIGNED Num_Diffs;
    SALT31.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_claim_num := le.claim_num <> ri.claim_num;
    SELF.Diff_claim_rec_type := le.claim_rec_type <> ri.claim_rec_type;
    SELF.Diff_line_number := le.line_number <> ri.line_number;
    SELF.Diff_service_from := le.service_from <> ri.service_from;
    SELF.Diff_service_to := le.service_to <> ri.service_to;
    SELF.Diff_place_service := le.place_service <> ri.place_service;
    SELF.Diff_cpt_code := le.cpt_code <> ri.cpt_code;
    SELF.Diff_proc_qual := le.proc_qual <> ri.proc_qual;
    SELF.Diff_proc_mod1 := le.proc_mod1 <> ri.proc_mod1;
    SELF.Diff_proc_mod2 := le.proc_mod2 <> ri.proc_mod2;
    SELF.Diff_proc_mod3 := le.proc_mod3 <> ri.proc_mod3;
    SELF.Diff_proc_mod4 := le.proc_mod4 <> ri.proc_mod4;
    SELF.Diff_line_charge := le.line_charge <> ri.line_charge;
    SELF.Diff_line_allowed := le.line_allowed <> ri.line_allowed;
    SELF.Diff_units := le.units <> ri.units;
    SELF.Diff_revenue_code := le.revenue_code <> ri.revenue_code;
    SELF.Diff_diag_code1 := le.diag_code1 <> ri.diag_code1;
    SELF.Diff_diag_code2 := le.diag_code2 <> ri.diag_code2;
    SELF.Diff_diag_code3 := le.diag_code3 <> ri.diag_code3;
    SELF.Diff_diag_code4 := le.diag_code4 <> ri.diag_code4;
    SELF.Diff_diag_code5 := le.diag_code5 <> ri.diag_code5;
    SELF.Diff_diag_code6 := le.diag_code6 <> ri.diag_code6;
    SELF.Diff_diag_code7 := le.diag_code7 <> ri.diag_code7;
    SELF.Diff_diag_code8 := le.diag_code8 <> ri.diag_code8;
    SELF.Diff_ndc := le.ndc <> ri.ndc;
    SELF.Diff_ambulance_to_hosp := le.ambulance_to_hosp <> ri.ambulance_to_hosp;
    SELF.Diff_emergency := le.emergency <> ri.emergency;
    SELF.Diff_tooth_surface := le.tooth_surface <> ri.tooth_surface;
    SELF.Diff_oral_cavity := le.oral_cavity <> ri.oral_cavity;
    SELF.Diff_service_type := le.service_type <> ri.service_type;
    SELF.Diff_copay := le.copay <> ri.copay;
    SELF.Diff_paid_amount := le.paid_amount <> ri.paid_amount;
    SELF.Diff_paid_date := le.paid_date <> ri.paid_date;
    SELF.Diff_bene_not_entitled := le.bene_not_entitled <> ri.bene_not_entitled;
    SELF.Diff_patient_reach_max := le.patient_reach_max <> ri.patient_reach_max;
    SELF.Diff_svc_during_postop := le.svc_during_postop <> ri.svc_during_postop;
    SELF.Diff_adjudicated_proc := le.adjudicated_proc <> ri.adjudicated_proc;
    SELF.Diff_adjudicated_proc_qual := le.adjudicated_proc_qual <> ri.adjudicated_proc_qual;
    SELF.Diff_adjudicated_proc_mod1 := le.adjudicated_proc_mod1 <> ri.adjudicated_proc_mod1;
    SELF.Diff_adjudicated_proc_mod2 := le.adjudicated_proc_mod2 <> ri.adjudicated_proc_mod2;
    SELF.Diff_adjudicated_proc_mod3 := le.adjudicated_proc_mod3 <> ri.adjudicated_proc_mod3;
    SELF.Diff_adjudicated_proc_mod4 := le.adjudicated_proc_mod4 <> ri.adjudicated_proc_mod4;
    SELF.Diff_pid := le.pid <> ri.pid;
    SELF.Diff_src := le.src <> ri.src;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_ln_record_type := le.ln_record_type <> ri.ln_record_type;
    SELF.Diff_clean_service_from := le.clean_service_from <> ri.clean_service_from;
    SELF.Diff_clean_service_to := le.clean_service_to <> ri.clean_service_to;
    SELF.Diff_clean_paid_date := le.clean_paid_date <> ri.clean_paid_date;
    SELF.Val := (SALT31.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_claim_num,1,0)+ IF( SELF.Diff_claim_rec_type,1,0)+ IF( SELF.Diff_line_number,1,0)+ IF( SELF.Diff_service_from,1,0)+ IF( SELF.Diff_service_to,1,0)+ IF( SELF.Diff_place_service,1,0)+ IF( SELF.Diff_cpt_code,1,0)+ IF( SELF.Diff_proc_qual,1,0)+ IF( SELF.Diff_proc_mod1,1,0)+ IF( SELF.Diff_proc_mod2,1,0)+ IF( SELF.Diff_proc_mod3,1,0)+ IF( SELF.Diff_proc_mod4,1,0)+ IF( SELF.Diff_line_charge,1,0)+ IF( SELF.Diff_line_allowed,1,0)+ IF( SELF.Diff_units,1,0)+ IF( SELF.Diff_revenue_code,1,0)+ IF( SELF.Diff_diag_code1,1,0)+ IF( SELF.Diff_diag_code2,1,0)+ IF( SELF.Diff_diag_code3,1,0)+ IF( SELF.Diff_diag_code4,1,0)+ IF( SELF.Diff_diag_code5,1,0)+ IF( SELF.Diff_diag_code6,1,0)+ IF( SELF.Diff_diag_code7,1,0)+ IF( SELF.Diff_diag_code8,1,0)+ IF( SELF.Diff_ndc,1,0)+ IF( SELF.Diff_ambulance_to_hosp,1,0)+ IF( SELF.Diff_emergency,1,0)+ IF( SELF.Diff_tooth_surface,1,0)+ IF( SELF.Diff_oral_cavity,1,0)+ IF( SELF.Diff_service_type,1,0)+ IF( SELF.Diff_copay,1,0)+ IF( SELF.Diff_paid_amount,1,0)+ IF( SELF.Diff_paid_date,1,0)+ IF( SELF.Diff_bene_not_entitled,1,0)+ IF( SELF.Diff_patient_reach_max,1,0)+ IF( SELF.Diff_svc_during_postop,1,0)+ IF( SELF.Diff_adjudicated_proc,1,0)+ IF( SELF.Diff_adjudicated_proc_qual,1,0)+ IF( SELF.Diff_adjudicated_proc_mod1,1,0)+ IF( SELF.Diff_adjudicated_proc_mod2,1,0)+ IF( SELF.Diff_adjudicated_proc_mod3,1,0)+ IF( SELF.Diff_adjudicated_proc_mod4,1,0)+ IF( SELF.Diff_pid,1,0)+ IF( SELF.Diff_src,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_ln_record_type,1,0)+ IF( SELF.Diff_clean_service_from,1,0)+ IF( SELF.Diff_clean_service_to,1,0)+ IF( SELF.Diff_clean_paid_date,1,0);
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
    Count_Diff_claim_num := COUNT(GROUP,%Closest%.Diff_claim_num);
    Count_Diff_claim_rec_type := COUNT(GROUP,%Closest%.Diff_claim_rec_type);
    Count_Diff_line_number := COUNT(GROUP,%Closest%.Diff_line_number);
    Count_Diff_service_from := COUNT(GROUP,%Closest%.Diff_service_from);
    Count_Diff_service_to := COUNT(GROUP,%Closest%.Diff_service_to);
    Count_Diff_place_service := COUNT(GROUP,%Closest%.Diff_place_service);
    Count_Diff_cpt_code := COUNT(GROUP,%Closest%.Diff_cpt_code);
    Count_Diff_proc_qual := COUNT(GROUP,%Closest%.Diff_proc_qual);
    Count_Diff_proc_mod1 := COUNT(GROUP,%Closest%.Diff_proc_mod1);
    Count_Diff_proc_mod2 := COUNT(GROUP,%Closest%.Diff_proc_mod2);
    Count_Diff_proc_mod3 := COUNT(GROUP,%Closest%.Diff_proc_mod3);
    Count_Diff_proc_mod4 := COUNT(GROUP,%Closest%.Diff_proc_mod4);
    Count_Diff_line_charge := COUNT(GROUP,%Closest%.Diff_line_charge);
    Count_Diff_line_allowed := COUNT(GROUP,%Closest%.Diff_line_allowed);
    Count_Diff_units := COUNT(GROUP,%Closest%.Diff_units);
    Count_Diff_revenue_code := COUNT(GROUP,%Closest%.Diff_revenue_code);
    Count_Diff_diag_code1 := COUNT(GROUP,%Closest%.Diff_diag_code1);
    Count_Diff_diag_code2 := COUNT(GROUP,%Closest%.Diff_diag_code2);
    Count_Diff_diag_code3 := COUNT(GROUP,%Closest%.Diff_diag_code3);
    Count_Diff_diag_code4 := COUNT(GROUP,%Closest%.Diff_diag_code4);
    Count_Diff_diag_code5 := COUNT(GROUP,%Closest%.Diff_diag_code5);
    Count_Diff_diag_code6 := COUNT(GROUP,%Closest%.Diff_diag_code6);
    Count_Diff_diag_code7 := COUNT(GROUP,%Closest%.Diff_diag_code7);
    Count_Diff_diag_code8 := COUNT(GROUP,%Closest%.Diff_diag_code8);
    Count_Diff_ndc := COUNT(GROUP,%Closest%.Diff_ndc);
    Count_Diff_ambulance_to_hosp := COUNT(GROUP,%Closest%.Diff_ambulance_to_hosp);
    Count_Diff_emergency := COUNT(GROUP,%Closest%.Diff_emergency);
    Count_Diff_tooth_surface := COUNT(GROUP,%Closest%.Diff_tooth_surface);
    Count_Diff_oral_cavity := COUNT(GROUP,%Closest%.Diff_oral_cavity);
    Count_Diff_service_type := COUNT(GROUP,%Closest%.Diff_service_type);
    Count_Diff_copay := COUNT(GROUP,%Closest%.Diff_copay);
    Count_Diff_paid_amount := COUNT(GROUP,%Closest%.Diff_paid_amount);
    Count_Diff_paid_date := COUNT(GROUP,%Closest%.Diff_paid_date);
    Count_Diff_bene_not_entitled := COUNT(GROUP,%Closest%.Diff_bene_not_entitled);
    Count_Diff_patient_reach_max := COUNT(GROUP,%Closest%.Diff_patient_reach_max);
    Count_Diff_svc_during_postop := COUNT(GROUP,%Closest%.Diff_svc_during_postop);
    Count_Diff_adjudicated_proc := COUNT(GROUP,%Closest%.Diff_adjudicated_proc);
    Count_Diff_adjudicated_proc_qual := COUNT(GROUP,%Closest%.Diff_adjudicated_proc_qual);
    Count_Diff_adjudicated_proc_mod1 := COUNT(GROUP,%Closest%.Diff_adjudicated_proc_mod1);
    Count_Diff_adjudicated_proc_mod2 := COUNT(GROUP,%Closest%.Diff_adjudicated_proc_mod2);
    Count_Diff_adjudicated_proc_mod3 := COUNT(GROUP,%Closest%.Diff_adjudicated_proc_mod3);
    Count_Diff_adjudicated_proc_mod4 := COUNT(GROUP,%Closest%.Diff_adjudicated_proc_mod4);
    Count_Diff_pid := COUNT(GROUP,%Closest%.Diff_pid);
    Count_Diff_src := COUNT(GROUP,%Closest%.Diff_src);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_ln_record_type := COUNT(GROUP,%Closest%.Diff_ln_record_type);
    Count_Diff_clean_service_from := COUNT(GROUP,%Closest%.Diff_clean_service_from);
    Count_Diff_clean_service_to := COUNT(GROUP,%Closest%.Diff_clean_service_to);
    Count_Diff_clean_paid_date := COUNT(GROUP,%Closest%.Diff_clean_paid_date);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
