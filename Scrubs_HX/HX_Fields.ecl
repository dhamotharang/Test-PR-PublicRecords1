IMPORT ut,SALT31;
EXPORT HX_Fields := MODULE
// Processing for each FieldType
EXPORT SALT31.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'claim_type','claim_num','attend_prov_id','attend_prov_name','billing_addr','billing_city','billing_npi','billing_org_name','billing_state','billing_tax_id','billing_zip','inpatient_proc1','inpatient_proc2','inpatient_proc3','operating_prov_id','operating_prov_name','other_diag1','other_diag2','other_diag3','other_diag4','other_diag5','other_diag6','other_diag7','other_diag8','other_proc1','other_proc2','other_proc3','other_proc4','other_proc5','other_proc_method_code','other_prov_id1','other_prov_name1','outpatient_proc1','outpatient_proc2','outpatient_proc3','principle_diag','principle_proc','service_from','service_line','service_to','submitted_date');
EXPORT FieldTypeNum(SALT31.StrType fn) := CASE(fn,'claim_type' => 1,'claim_num' => 2,'attend_prov_id' => 3,'attend_prov_name' => 4,'billing_addr' => 5,'billing_city' => 6,'billing_npi' => 7,'billing_org_name' => 8,'billing_state' => 9,'billing_tax_id' => 10,'billing_zip' => 11,'inpatient_proc1' => 12,'inpatient_proc2' => 13,'inpatient_proc3' => 14,'operating_prov_id' => 15,'operating_prov_name' => 16,'other_diag1' => 17,'other_diag2' => 18,'other_diag3' => 19,'other_diag4' => 20,'other_diag5' => 21,'other_diag6' => 22,'other_diag7' => 23,'other_diag8' => 24,'other_proc1' => 25,'other_proc2' => 26,'other_proc3' => 27,'other_proc4' => 28,'other_proc5' => 29,'other_proc_method_code' => 30,'other_prov_id1' => 31,'other_prov_name1' => 32,'outpatient_proc1' => 33,'outpatient_proc2' => 34,'outpatient_proc3' => 35,'principle_diag' => 36,'principle_proc' => 37,'service_from' => 38,'service_line' => 39,'service_to' => 40,'submitted_date' => 41,0);
EXPORT MakeFT_claim_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'I '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_claim_type(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'I '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_claim_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('I '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_claim_num(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_claim_num(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 16),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_claim_num(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('15,16'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_attend_prov_id(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_attend_prov_id(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_attend_prov_id(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('10,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_attend_prov_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_attend_prov_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWYZ '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 2 OR SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_attend_prov_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWYZ '),SALT31.HygieneErrors.NotWords('2,1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_billing_addr(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_billing_addr(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWYZ '))));
EXPORT InValidMessageFT_billing_addr(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_billing_city(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_billing_city(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWYZ '))));
EXPORT InValidMessageFT_billing_city(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_billing_npi(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_billing_npi(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_billing_npi(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,10'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_billing_org_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' -ABCDEFGHIJKLMNOPQRSTUVWYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_billing_org_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' -ABCDEFGHIJKLMNOPQRSTUVWYZ '))));
EXPORT InValidMessageFT_billing_org_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' -ABCDEFGHIJKLMNOPQRSTUVWYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_billing_state(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_billing_state(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWYZ '))),~(LENGTH(TRIM(s)) = 2),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_billing_state(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWYZ '),SALT31.HygieneErrors.NotLength('2'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_billing_tax_id(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0135 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_billing_tax_id(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0135 '))),~(LENGTH(TRIM(s)) = 10),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_billing_tax_id(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0135 '),SALT31.HygieneErrors.NotLength('10'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_billing_zip(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_billing_zip(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 2),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_billing_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('2'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_inpatient_proc1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ACEGJNOQ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_inpatient_proc1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ACEGJNOQ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_inpatient_proc1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ACEGJNOQ '),SALT31.HygieneErrors.NotLength('0,4,5'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_inpatient_proc2(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ACEGJNOQ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_inpatient_proc2(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ACEGJNOQ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_inpatient_proc2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ACEGJNOQ '),SALT31.HygieneErrors.NotLength('0,4,5'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_inpatient_proc3(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ACEGJNOQ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_inpatient_proc3(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ACEGJNOQ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_inpatient_proc3(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ACEGJNOQ '),SALT31.HygieneErrors.NotLength('0,4,5'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_operating_prov_id(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_operating_prov_id(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_operating_prov_id(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,10'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_operating_prov_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_operating_prov_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_operating_prov_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_other_diag1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789V '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_diag1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789V '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_diag1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789V '),SALT31.HygieneErrors.NotLength('4,5,0,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_other_diag2(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789V '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_diag2(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789V '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_diag2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789V '),SALT31.HygieneErrors.NotLength('0,5,4,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_other_diag3(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789V '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_diag3(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789V '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_diag3(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789V '),SALT31.HygieneErrors.NotLength('0,5,4,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_other_diag4(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789V '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_diag4(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789V '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_diag4(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789V '),SALT31.HygieneErrors.NotLength('0,5,4,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_other_diag5(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789V '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_diag5(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789V '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_diag5(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789V '),SALT31.HygieneErrors.NotLength('0,5,4,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_other_diag6(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789V '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_diag6(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789V '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_diag6(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789V '),SALT31.HygieneErrors.NotLength('0,5,4,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_other_diag7(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789V '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_diag7(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789V '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_diag7(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789V '),SALT31.HygieneErrors.NotLength('0,5,4,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_other_diag8(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789V '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_diag8(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789V '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_diag8(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789V '),SALT31.HygieneErrors.NotLength('0,5,4,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_other_proc1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_proc1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_proc1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,4,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_other_proc2(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_proc2(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_proc2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,4,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_other_proc3(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_proc3(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_proc3(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,4,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_other_proc4(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_proc4(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_proc4(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,4,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_other_proc5(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_proc5(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_proc5(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,4,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_other_proc_method_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'09 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_proc_method_code(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'09 '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_proc_method_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('09 '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_other_prov_id1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_prov_id1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_prov_id1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,10'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_other_prov_name1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_prov_name1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ABCDEFGHIJKLMNOPRSTUVWXYZ '))));
EXPORT InValidMessageFT_other_prov_name1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_outpatient_proc1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ACEGJNOPQTZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_outpatient_proc1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ACEGJNOPQTZ '))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_outpatient_proc1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ACEGJNOPQTZ '),SALT31.HygieneErrors.NotLength('5,0,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_outpatient_proc2(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ACEGJNOPQTZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_outpatient_proc2(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ACEGJNOPQTZ '))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_outpatient_proc2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ACEGJNOPQTZ '),SALT31.HygieneErrors.NotLength('5,0,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_outpatient_proc3(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ACEGJNOPQTZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_outpatient_proc3(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ACEGJNOPQTZ '))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_outpatient_proc3(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ACEGJNOPQTZ '),SALT31.HygieneErrors.NotLength('5,0,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_principle_diag(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789V '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_principle_diag(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789V '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_principle_diag(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789V '),SALT31.HygieneErrors.NotLength('4,5,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_principle_proc(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_principle_proc(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_principle_proc(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,4,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_service_from(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_service_from(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_service_from(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('8'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_service_line(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_service_line(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_service_line(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('3,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_service_to(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_service_to(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_service_to(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('8'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_submitted_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_submitted_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_submitted_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('8'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT SALT31.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'claim_type','claim_num','attend_prov_id','attend_prov_name','billing_addr','billing_city','billing_npi','billing_org_name','billing_state','billing_tax_id','billing_zip','ext_injury_diag_code','inpatient_proc1','inpatient_proc2','inpatient_proc3','operating_prov_id','operating_prov_name','other_diag1','other_diag2','other_diag3','other_diag4','other_diag5','other_diag6','other_diag7','other_diag8','other_proc1','other_proc2','other_proc3','other_proc4','other_proc5','other_proc_method_code','other_prov_id1','other_prov_id2','other_prov_name1','other_prov_name2','outpatient_proc1','outpatient_proc2','outpatient_proc3','principle_diag','principle_proc','service_from','service_line','service_to','submitted_date');
EXPORT FieldNum(SALT31.StrType fn) := CASE(fn,'claim_type' => 1,'claim_num' => 2,'attend_prov_id' => 3,'attend_prov_name' => 4,'billing_addr' => 5,'billing_city' => 6,'billing_npi' => 7,'billing_org_name' => 8,'billing_state' => 9,'billing_tax_id' => 10,'billing_zip' => 11,'ext_injury_diag_code' => 12,'inpatient_proc1' => 13,'inpatient_proc2' => 14,'inpatient_proc3' => 15,'operating_prov_id' => 16,'operating_prov_name' => 17,'other_diag1' => 18,'other_diag2' => 19,'other_diag3' => 20,'other_diag4' => 21,'other_diag5' => 22,'other_diag6' => 23,'other_diag7' => 24,'other_diag8' => 25,'other_proc1' => 26,'other_proc2' => 27,'other_proc3' => 28,'other_proc4' => 29,'other_proc5' => 30,'other_proc_method_code' => 31,'other_prov_id1' => 32,'other_prov_id2' => 33,'other_prov_name1' => 34,'other_prov_name2' => 35,'outpatient_proc1' => 36,'outpatient_proc2' => 37,'outpatient_proc3' => 38,'principle_diag' => 39,'principle_proc' => 40,'service_from' => 41,'service_line' => 42,'service_to' => 43,'submitted_date' => 44,0);
//Individual field level validation
EXPORT Make_claim_type(SALT31.StrType s0) := MakeFT_claim_type(s0);
EXPORT InValid_claim_type(SALT31.StrType s) := InValidFT_claim_type(s);
EXPORT InValidMessage_claim_type(UNSIGNED1 wh) := InValidMessageFT_claim_type(wh);
EXPORT Make_claim_num(SALT31.StrType s0) := MakeFT_claim_num(s0);
EXPORT InValid_claim_num(SALT31.StrType s) := InValidFT_claim_num(s);
EXPORT InValidMessage_claim_num(UNSIGNED1 wh) := InValidMessageFT_claim_num(wh);
EXPORT Make_attend_prov_id(SALT31.StrType s0) := MakeFT_attend_prov_id(s0);
EXPORT InValid_attend_prov_id(SALT31.StrType s) := InValidFT_attend_prov_id(s);
EXPORT InValidMessage_attend_prov_id(UNSIGNED1 wh) := InValidMessageFT_attend_prov_id(wh);
EXPORT Make_attend_prov_name(SALT31.StrType s0) := MakeFT_attend_prov_name(s0);
EXPORT InValid_attend_prov_name(SALT31.StrType s) := InValidFT_attend_prov_name(s);
EXPORT InValidMessage_attend_prov_name(UNSIGNED1 wh) := InValidMessageFT_attend_prov_name(wh);
EXPORT Make_billing_addr(SALT31.StrType s0) := MakeFT_billing_addr(s0);
EXPORT InValid_billing_addr(SALT31.StrType s) := InValidFT_billing_addr(s);
EXPORT InValidMessage_billing_addr(UNSIGNED1 wh) := InValidMessageFT_billing_addr(wh);
EXPORT Make_billing_city(SALT31.StrType s0) := MakeFT_billing_city(s0);
EXPORT InValid_billing_city(SALT31.StrType s) := InValidFT_billing_city(s);
EXPORT InValidMessage_billing_city(UNSIGNED1 wh) := InValidMessageFT_billing_city(wh);
EXPORT Make_billing_npi(SALT31.StrType s0) := MakeFT_billing_npi(s0);
EXPORT InValid_billing_npi(SALT31.StrType s) := InValidFT_billing_npi(s);
EXPORT InValidMessage_billing_npi(UNSIGNED1 wh) := InValidMessageFT_billing_npi(wh);
EXPORT Make_billing_org_name(SALT31.StrType s0) := MakeFT_billing_org_name(s0);
EXPORT InValid_billing_org_name(SALT31.StrType s) := InValidFT_billing_org_name(s);
EXPORT InValidMessage_billing_org_name(UNSIGNED1 wh) := InValidMessageFT_billing_org_name(wh);
EXPORT Make_billing_state(SALT31.StrType s0) := MakeFT_billing_state(s0);
EXPORT InValid_billing_state(SALT31.StrType s) := InValidFT_billing_state(s);
EXPORT InValidMessage_billing_state(UNSIGNED1 wh) := InValidMessageFT_billing_state(wh);
EXPORT Make_billing_tax_id(SALT31.StrType s0) := MakeFT_billing_tax_id(s0);
EXPORT InValid_billing_tax_id(SALT31.StrType s) := InValidFT_billing_tax_id(s);
EXPORT InValidMessage_billing_tax_id(UNSIGNED1 wh) := InValidMessageFT_billing_tax_id(wh);
EXPORT Make_billing_zip(SALT31.StrType s0) := MakeFT_billing_zip(s0);
EXPORT InValid_billing_zip(SALT31.StrType s) := InValidFT_billing_zip(s);
EXPORT InValidMessage_billing_zip(UNSIGNED1 wh) := InValidMessageFT_billing_zip(wh);
EXPORT Make_ext_injury_diag_code(SALT31.StrType s0) := s0;
EXPORT InValid_ext_injury_diag_code(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_ext_injury_diag_code(UNSIGNED1 wh) := '';
EXPORT Make_inpatient_proc1(SALT31.StrType s0) := MakeFT_inpatient_proc1(s0);
EXPORT InValid_inpatient_proc1(SALT31.StrType s) := InValidFT_inpatient_proc1(s);
EXPORT InValidMessage_inpatient_proc1(UNSIGNED1 wh) := InValidMessageFT_inpatient_proc1(wh);
EXPORT Make_inpatient_proc2(SALT31.StrType s0) := MakeFT_inpatient_proc2(s0);
EXPORT InValid_inpatient_proc2(SALT31.StrType s) := InValidFT_inpatient_proc2(s);
EXPORT InValidMessage_inpatient_proc2(UNSIGNED1 wh) := InValidMessageFT_inpatient_proc2(wh);
EXPORT Make_inpatient_proc3(SALT31.StrType s0) := MakeFT_inpatient_proc3(s0);
EXPORT InValid_inpatient_proc3(SALT31.StrType s) := InValidFT_inpatient_proc3(s);
EXPORT InValidMessage_inpatient_proc3(UNSIGNED1 wh) := InValidMessageFT_inpatient_proc3(wh);
EXPORT Make_operating_prov_id(SALT31.StrType s0) := MakeFT_operating_prov_id(s0);
EXPORT InValid_operating_prov_id(SALT31.StrType s) := InValidFT_operating_prov_id(s);
EXPORT InValidMessage_operating_prov_id(UNSIGNED1 wh) := InValidMessageFT_operating_prov_id(wh);
EXPORT Make_operating_prov_name(SALT31.StrType s0) := MakeFT_operating_prov_name(s0);
EXPORT InValid_operating_prov_name(SALT31.StrType s) := InValidFT_operating_prov_name(s);
EXPORT InValidMessage_operating_prov_name(UNSIGNED1 wh) := InValidMessageFT_operating_prov_name(wh);
EXPORT Make_other_diag1(SALT31.StrType s0) := MakeFT_other_diag1(s0);
EXPORT InValid_other_diag1(SALT31.StrType s) := InValidFT_other_diag1(s);
EXPORT InValidMessage_other_diag1(UNSIGNED1 wh) := InValidMessageFT_other_diag1(wh);
EXPORT Make_other_diag2(SALT31.StrType s0) := MakeFT_other_diag2(s0);
EXPORT InValid_other_diag2(SALT31.StrType s) := InValidFT_other_diag2(s);
EXPORT InValidMessage_other_diag2(UNSIGNED1 wh) := InValidMessageFT_other_diag2(wh);
EXPORT Make_other_diag3(SALT31.StrType s0) := MakeFT_other_diag3(s0);
EXPORT InValid_other_diag3(SALT31.StrType s) := InValidFT_other_diag3(s);
EXPORT InValidMessage_other_diag3(UNSIGNED1 wh) := InValidMessageFT_other_diag3(wh);
EXPORT Make_other_diag4(SALT31.StrType s0) := MakeFT_other_diag4(s0);
EXPORT InValid_other_diag4(SALT31.StrType s) := InValidFT_other_diag4(s);
EXPORT InValidMessage_other_diag4(UNSIGNED1 wh) := InValidMessageFT_other_diag4(wh);
EXPORT Make_other_diag5(SALT31.StrType s0) := MakeFT_other_diag5(s0);
EXPORT InValid_other_diag5(SALT31.StrType s) := InValidFT_other_diag5(s);
EXPORT InValidMessage_other_diag5(UNSIGNED1 wh) := InValidMessageFT_other_diag5(wh);
EXPORT Make_other_diag6(SALT31.StrType s0) := MakeFT_other_diag6(s0);
EXPORT InValid_other_diag6(SALT31.StrType s) := InValidFT_other_diag6(s);
EXPORT InValidMessage_other_diag6(UNSIGNED1 wh) := InValidMessageFT_other_diag6(wh);
EXPORT Make_other_diag7(SALT31.StrType s0) := MakeFT_other_diag7(s0);
EXPORT InValid_other_diag7(SALT31.StrType s) := InValidFT_other_diag7(s);
EXPORT InValidMessage_other_diag7(UNSIGNED1 wh) := InValidMessageFT_other_diag7(wh);
EXPORT Make_other_diag8(SALT31.StrType s0) := MakeFT_other_diag8(s0);
EXPORT InValid_other_diag8(SALT31.StrType s) := InValidFT_other_diag8(s);
EXPORT InValidMessage_other_diag8(UNSIGNED1 wh) := InValidMessageFT_other_diag8(wh);
EXPORT Make_other_proc1(SALT31.StrType s0) := MakeFT_other_proc1(s0);
EXPORT InValid_other_proc1(SALT31.StrType s) := InValidFT_other_proc1(s);
EXPORT InValidMessage_other_proc1(UNSIGNED1 wh) := InValidMessageFT_other_proc1(wh);
EXPORT Make_other_proc2(SALT31.StrType s0) := MakeFT_other_proc2(s0);
EXPORT InValid_other_proc2(SALT31.StrType s) := InValidFT_other_proc2(s);
EXPORT InValidMessage_other_proc2(UNSIGNED1 wh) := InValidMessageFT_other_proc2(wh);
EXPORT Make_other_proc3(SALT31.StrType s0) := MakeFT_other_proc3(s0);
EXPORT InValid_other_proc3(SALT31.StrType s) := InValidFT_other_proc3(s);
EXPORT InValidMessage_other_proc3(UNSIGNED1 wh) := InValidMessageFT_other_proc3(wh);
EXPORT Make_other_proc4(SALT31.StrType s0) := MakeFT_other_proc4(s0);
EXPORT InValid_other_proc4(SALT31.StrType s) := InValidFT_other_proc4(s);
EXPORT InValidMessage_other_proc4(UNSIGNED1 wh) := InValidMessageFT_other_proc4(wh);
EXPORT Make_other_proc5(SALT31.StrType s0) := MakeFT_other_proc5(s0);
EXPORT InValid_other_proc5(SALT31.StrType s) := InValidFT_other_proc5(s);
EXPORT InValidMessage_other_proc5(UNSIGNED1 wh) := InValidMessageFT_other_proc5(wh);
EXPORT Make_other_proc_method_code(SALT31.StrType s0) := MakeFT_other_proc_method_code(s0);
EXPORT InValid_other_proc_method_code(SALT31.StrType s) := InValidFT_other_proc_method_code(s);
EXPORT InValidMessage_other_proc_method_code(UNSIGNED1 wh) := InValidMessageFT_other_proc_method_code(wh);
EXPORT Make_other_prov_id1(SALT31.StrType s0) := MakeFT_other_prov_id1(s0);
EXPORT InValid_other_prov_id1(SALT31.StrType s) := InValidFT_other_prov_id1(s);
EXPORT InValidMessage_other_prov_id1(UNSIGNED1 wh) := InValidMessageFT_other_prov_id1(wh);
EXPORT Make_other_prov_id2(SALT31.StrType s0) := s0;
EXPORT InValid_other_prov_id2(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_other_prov_id2(UNSIGNED1 wh) := '';
EXPORT Make_other_prov_name1(SALT31.StrType s0) := MakeFT_other_prov_name1(s0);
EXPORT InValid_other_prov_name1(SALT31.StrType s) := InValidFT_other_prov_name1(s);
EXPORT InValidMessage_other_prov_name1(UNSIGNED1 wh) := InValidMessageFT_other_prov_name1(wh);
EXPORT Make_other_prov_name2(SALT31.StrType s0) := s0;
EXPORT InValid_other_prov_name2(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_other_prov_name2(UNSIGNED1 wh) := '';
EXPORT Make_outpatient_proc1(SALT31.StrType s0) := MakeFT_outpatient_proc1(s0);
EXPORT InValid_outpatient_proc1(SALT31.StrType s) := InValidFT_outpatient_proc1(s);
EXPORT InValidMessage_outpatient_proc1(UNSIGNED1 wh) := InValidMessageFT_outpatient_proc1(wh);
EXPORT Make_outpatient_proc2(SALT31.StrType s0) := MakeFT_outpatient_proc2(s0);
EXPORT InValid_outpatient_proc2(SALT31.StrType s) := InValidFT_outpatient_proc2(s);
EXPORT InValidMessage_outpatient_proc2(UNSIGNED1 wh) := InValidMessageFT_outpatient_proc2(wh);
EXPORT Make_outpatient_proc3(SALT31.StrType s0) := MakeFT_outpatient_proc3(s0);
EXPORT InValid_outpatient_proc3(SALT31.StrType s) := InValidFT_outpatient_proc3(s);
EXPORT InValidMessage_outpatient_proc3(UNSIGNED1 wh) := InValidMessageFT_outpatient_proc3(wh);
EXPORT Make_principle_diag(SALT31.StrType s0) := MakeFT_principle_diag(s0);
EXPORT InValid_principle_diag(SALT31.StrType s) := InValidFT_principle_diag(s);
EXPORT InValidMessage_principle_diag(UNSIGNED1 wh) := InValidMessageFT_principle_diag(wh);
EXPORT Make_principle_proc(SALT31.StrType s0) := MakeFT_principle_proc(s0);
EXPORT InValid_principle_proc(SALT31.StrType s) := InValidFT_principle_proc(s);
EXPORT InValidMessage_principle_proc(UNSIGNED1 wh) := InValidMessageFT_principle_proc(wh);
EXPORT Make_service_from(SALT31.StrType s0) := MakeFT_service_from(s0);
EXPORT InValid_service_from(SALT31.StrType s) := InValidFT_service_from(s);
EXPORT InValidMessage_service_from(UNSIGNED1 wh) := InValidMessageFT_service_from(wh);
EXPORT Make_service_line(SALT31.StrType s0) := MakeFT_service_line(s0);
EXPORT InValid_service_line(SALT31.StrType s) := InValidFT_service_line(s);
EXPORT InValidMessage_service_line(UNSIGNED1 wh) := InValidMessageFT_service_line(wh);
EXPORT Make_service_to(SALT31.StrType s0) := MakeFT_service_to(s0);
EXPORT InValid_service_to(SALT31.StrType s) := InValidFT_service_to(s);
EXPORT InValidMessage_service_to(UNSIGNED1 wh) := InValidMessageFT_service_to(wh);
EXPORT Make_submitted_date(SALT31.StrType s0) := MakeFT_submitted_date(s0);
EXPORT InValid_submitted_date(SALT31.StrType s) := InValidFT_submitted_date(s);
EXPORT InValidMessage_submitted_date(UNSIGNED1 wh) := InValidMessageFT_submitted_date(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT31,Scrubs_HX;
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
    BOOLEAN Diff_claim_type;
    BOOLEAN Diff_claim_num;
    BOOLEAN Diff_attend_prov_id;
    BOOLEAN Diff_attend_prov_name;
    BOOLEAN Diff_billing_addr;
    BOOLEAN Diff_billing_city;
    BOOLEAN Diff_billing_npi;
    BOOLEAN Diff_billing_org_name;
    BOOLEAN Diff_billing_state;
    BOOLEAN Diff_billing_tax_id;
    BOOLEAN Diff_billing_zip;
    BOOLEAN Diff_ext_injury_diag_code;
    BOOLEAN Diff_inpatient_proc1;
    BOOLEAN Diff_inpatient_proc2;
    BOOLEAN Diff_inpatient_proc3;
    BOOLEAN Diff_operating_prov_id;
    BOOLEAN Diff_operating_prov_name;
    BOOLEAN Diff_other_diag1;
    BOOLEAN Diff_other_diag2;
    BOOLEAN Diff_other_diag3;
    BOOLEAN Diff_other_diag4;
    BOOLEAN Diff_other_diag5;
    BOOLEAN Diff_other_diag6;
    BOOLEAN Diff_other_diag7;
    BOOLEAN Diff_other_diag8;
    BOOLEAN Diff_other_proc1;
    BOOLEAN Diff_other_proc2;
    BOOLEAN Diff_other_proc3;
    BOOLEAN Diff_other_proc4;
    BOOLEAN Diff_other_proc5;
    BOOLEAN Diff_other_proc_method_code;
    BOOLEAN Diff_other_prov_id1;
    BOOLEAN Diff_other_prov_id2;
    BOOLEAN Diff_other_prov_name1;
    BOOLEAN Diff_other_prov_name2;
    BOOLEAN Diff_outpatient_proc1;
    BOOLEAN Diff_outpatient_proc2;
    BOOLEAN Diff_outpatient_proc3;
    BOOLEAN Diff_principle_diag;
    BOOLEAN Diff_principle_proc;
    BOOLEAN Diff_service_from;
    BOOLEAN Diff_service_line;
    BOOLEAN Diff_service_to;
    BOOLEAN Diff_submitted_date;
    UNSIGNED Num_Diffs;
    SALT31.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_claim_type := le.claim_type <> ri.claim_type;
    SELF.Diff_claim_num := le.claim_num <> ri.claim_num;
    SELF.Diff_attend_prov_id := le.attend_prov_id <> ri.attend_prov_id;
    SELF.Diff_attend_prov_name := le.attend_prov_name <> ri.attend_prov_name;
    SELF.Diff_billing_addr := le.billing_addr <> ri.billing_addr;
    SELF.Diff_billing_city := le.billing_city <> ri.billing_city;
    SELF.Diff_billing_npi := le.billing_npi <> ri.billing_npi;
    SELF.Diff_billing_org_name := le.billing_org_name <> ri.billing_org_name;
    SELF.Diff_billing_state := le.billing_state <> ri.billing_state;
    SELF.Diff_billing_tax_id := le.billing_tax_id <> ri.billing_tax_id;
    SELF.Diff_billing_zip := le.billing_zip <> ri.billing_zip;
    SELF.Diff_ext_injury_diag_code := le.ext_injury_diag_code <> ri.ext_injury_diag_code;
    SELF.Diff_inpatient_proc1 := le.inpatient_proc1 <> ri.inpatient_proc1;
    SELF.Diff_inpatient_proc2 := le.inpatient_proc2 <> ri.inpatient_proc2;
    SELF.Diff_inpatient_proc3 := le.inpatient_proc3 <> ri.inpatient_proc3;
    SELF.Diff_operating_prov_id := le.operating_prov_id <> ri.operating_prov_id;
    SELF.Diff_operating_prov_name := le.operating_prov_name <> ri.operating_prov_name;
    SELF.Diff_other_diag1 := le.other_diag1 <> ri.other_diag1;
    SELF.Diff_other_diag2 := le.other_diag2 <> ri.other_diag2;
    SELF.Diff_other_diag3 := le.other_diag3 <> ri.other_diag3;
    SELF.Diff_other_diag4 := le.other_diag4 <> ri.other_diag4;
    SELF.Diff_other_diag5 := le.other_diag5 <> ri.other_diag5;
    SELF.Diff_other_diag6 := le.other_diag6 <> ri.other_diag6;
    SELF.Diff_other_diag7 := le.other_diag7 <> ri.other_diag7;
    SELF.Diff_other_diag8 := le.other_diag8 <> ri.other_diag8;
    SELF.Diff_other_proc1 := le.other_proc1 <> ri.other_proc1;
    SELF.Diff_other_proc2 := le.other_proc2 <> ri.other_proc2;
    SELF.Diff_other_proc3 := le.other_proc3 <> ri.other_proc3;
    SELF.Diff_other_proc4 := le.other_proc4 <> ri.other_proc4;
    SELF.Diff_other_proc5 := le.other_proc5 <> ri.other_proc5;
    SELF.Diff_other_proc_method_code := le.other_proc_method_code <> ri.other_proc_method_code;
    SELF.Diff_other_prov_id1 := le.other_prov_id1 <> ri.other_prov_id1;
    SELF.Diff_other_prov_id2 := le.other_prov_id2 <> ri.other_prov_id2;
    SELF.Diff_other_prov_name1 := le.other_prov_name1 <> ri.other_prov_name1;
    SELF.Diff_other_prov_name2 := le.other_prov_name2 <> ri.other_prov_name2;
    SELF.Diff_outpatient_proc1 := le.outpatient_proc1 <> ri.outpatient_proc1;
    SELF.Diff_outpatient_proc2 := le.outpatient_proc2 <> ri.outpatient_proc2;
    SELF.Diff_outpatient_proc3 := le.outpatient_proc3 <> ri.outpatient_proc3;
    SELF.Diff_principle_diag := le.principle_diag <> ri.principle_diag;
    SELF.Diff_principle_proc := le.principle_proc <> ri.principle_proc;
    SELF.Diff_service_from := le.service_from <> ri.service_from;
    SELF.Diff_service_line := le.service_line <> ri.service_line;
    SELF.Diff_service_to := le.service_to <> ri.service_to;
    SELF.Diff_submitted_date := le.submitted_date <> ri.submitted_date;
    SELF.Val := (SALT31.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_claim_type,1,0)+ IF( SELF.Diff_claim_num,1,0)+ IF( SELF.Diff_attend_prov_id,1,0)+ IF( SELF.Diff_attend_prov_name,1,0)+ IF( SELF.Diff_billing_addr,1,0)+ IF( SELF.Diff_billing_city,1,0)+ IF( SELF.Diff_billing_npi,1,0)+ IF( SELF.Diff_billing_org_name,1,0)+ IF( SELF.Diff_billing_state,1,0)+ IF( SELF.Diff_billing_tax_id,1,0)+ IF( SELF.Diff_billing_zip,1,0)+ IF( SELF.Diff_ext_injury_diag_code,1,0)+ IF( SELF.Diff_inpatient_proc1,1,0)+ IF( SELF.Diff_inpatient_proc2,1,0)+ IF( SELF.Diff_inpatient_proc3,1,0)+ IF( SELF.Diff_operating_prov_id,1,0)+ IF( SELF.Diff_operating_prov_name,1,0)+ IF( SELF.Diff_other_diag1,1,0)+ IF( SELF.Diff_other_diag2,1,0)+ IF( SELF.Diff_other_diag3,1,0)+ IF( SELF.Diff_other_diag4,1,0)+ IF( SELF.Diff_other_diag5,1,0)+ IF( SELF.Diff_other_diag6,1,0)+ IF( SELF.Diff_other_diag7,1,0)+ IF( SELF.Diff_other_diag8,1,0)+ IF( SELF.Diff_other_proc1,1,0)+ IF( SELF.Diff_other_proc2,1,0)+ IF( SELF.Diff_other_proc3,1,0)+ IF( SELF.Diff_other_proc4,1,0)+ IF( SELF.Diff_other_proc5,1,0)+ IF( SELF.Diff_other_proc_method_code,1,0)+ IF( SELF.Diff_other_prov_id1,1,0)+ IF( SELF.Diff_other_prov_id2,1,0)+ IF( SELF.Diff_other_prov_name1,1,0)+ IF( SELF.Diff_other_prov_name2,1,0)+ IF( SELF.Diff_outpatient_proc1,1,0)+ IF( SELF.Diff_outpatient_proc2,1,0)+ IF( SELF.Diff_outpatient_proc3,1,0)+ IF( SELF.Diff_principle_diag,1,0)+ IF( SELF.Diff_principle_proc,1,0)+ IF( SELF.Diff_service_from,1,0)+ IF( SELF.Diff_service_line,1,0)+ IF( SELF.Diff_service_to,1,0)+ IF( SELF.Diff_submitted_date,1,0);
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
    Count_Diff_claim_type := COUNT(GROUP,%Closest%.Diff_claim_type);
    Count_Diff_claim_num := COUNT(GROUP,%Closest%.Diff_claim_num);
    Count_Diff_attend_prov_id := COUNT(GROUP,%Closest%.Diff_attend_prov_id);
    Count_Diff_attend_prov_name := COUNT(GROUP,%Closest%.Diff_attend_prov_name);
    Count_Diff_billing_addr := COUNT(GROUP,%Closest%.Diff_billing_addr);
    Count_Diff_billing_city := COUNT(GROUP,%Closest%.Diff_billing_city);
    Count_Diff_billing_npi := COUNT(GROUP,%Closest%.Diff_billing_npi);
    Count_Diff_billing_org_name := COUNT(GROUP,%Closest%.Diff_billing_org_name);
    Count_Diff_billing_state := COUNT(GROUP,%Closest%.Diff_billing_state);
    Count_Diff_billing_tax_id := COUNT(GROUP,%Closest%.Diff_billing_tax_id);
    Count_Diff_billing_zip := COUNT(GROUP,%Closest%.Diff_billing_zip);
    Count_Diff_ext_injury_diag_code := COUNT(GROUP,%Closest%.Diff_ext_injury_diag_code);
    Count_Diff_inpatient_proc1 := COUNT(GROUP,%Closest%.Diff_inpatient_proc1);
    Count_Diff_inpatient_proc2 := COUNT(GROUP,%Closest%.Diff_inpatient_proc2);
    Count_Diff_inpatient_proc3 := COUNT(GROUP,%Closest%.Diff_inpatient_proc3);
    Count_Diff_operating_prov_id := COUNT(GROUP,%Closest%.Diff_operating_prov_id);
    Count_Diff_operating_prov_name := COUNT(GROUP,%Closest%.Diff_operating_prov_name);
    Count_Diff_other_diag1 := COUNT(GROUP,%Closest%.Diff_other_diag1);
    Count_Diff_other_diag2 := COUNT(GROUP,%Closest%.Diff_other_diag2);
    Count_Diff_other_diag3 := COUNT(GROUP,%Closest%.Diff_other_diag3);
    Count_Diff_other_diag4 := COUNT(GROUP,%Closest%.Diff_other_diag4);
    Count_Diff_other_diag5 := COUNT(GROUP,%Closest%.Diff_other_diag5);
    Count_Diff_other_diag6 := COUNT(GROUP,%Closest%.Diff_other_diag6);
    Count_Diff_other_diag7 := COUNT(GROUP,%Closest%.Diff_other_diag7);
    Count_Diff_other_diag8 := COUNT(GROUP,%Closest%.Diff_other_diag8);
    Count_Diff_other_proc1 := COUNT(GROUP,%Closest%.Diff_other_proc1);
    Count_Diff_other_proc2 := COUNT(GROUP,%Closest%.Diff_other_proc2);
    Count_Diff_other_proc3 := COUNT(GROUP,%Closest%.Diff_other_proc3);
    Count_Diff_other_proc4 := COUNT(GROUP,%Closest%.Diff_other_proc4);
    Count_Diff_other_proc5 := COUNT(GROUP,%Closest%.Diff_other_proc5);
    Count_Diff_other_proc_method_code := COUNT(GROUP,%Closest%.Diff_other_proc_method_code);
    Count_Diff_other_prov_id1 := COUNT(GROUP,%Closest%.Diff_other_prov_id1);
    Count_Diff_other_prov_id2 := COUNT(GROUP,%Closest%.Diff_other_prov_id2);
    Count_Diff_other_prov_name1 := COUNT(GROUP,%Closest%.Diff_other_prov_name1);
    Count_Diff_other_prov_name2 := COUNT(GROUP,%Closest%.Diff_other_prov_name2);
    Count_Diff_outpatient_proc1 := COUNT(GROUP,%Closest%.Diff_outpatient_proc1);
    Count_Diff_outpatient_proc2 := COUNT(GROUP,%Closest%.Diff_outpatient_proc2);
    Count_Diff_outpatient_proc3 := COUNT(GROUP,%Closest%.Diff_outpatient_proc3);
    Count_Diff_principle_diag := COUNT(GROUP,%Closest%.Diff_principle_diag);
    Count_Diff_principle_proc := COUNT(GROUP,%Closest%.Diff_principle_proc);
    Count_Diff_service_from := COUNT(GROUP,%Closest%.Diff_service_from);
    Count_Diff_service_line := COUNT(GROUP,%Closest%.Diff_service_line);
    Count_Diff_service_to := COUNT(GROUP,%Closest%.Diff_service_to);
    Count_Diff_submitted_date := COUNT(GROUP,%Closest%.Diff_submitted_date);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
