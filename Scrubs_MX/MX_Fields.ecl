IMPORT ut,SALT31;
EXPORT MX_Fields := MODULE
// Processing for each FieldType
EXPORT SALT31.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'claim_type','claim_num','billing_addr','billing_city','billing_first_name','billing_last_name','billing_middle_name','billing_npi','billing_org_name','billing_specialty_code','billing_state','billing_tax_id','billing_upin','billing_zip','diag_code1','diag_code2','diag_code3','diag_code4','diag_code5','diag_code6','diag_code7','diag_code8','ext_injury_diag_code','facility_lab_addr','facility_lab_city','facility_lab_name','facility_lab_npi','facility_lab_state','facility_lab_zip','ordering_prov_first_name','ordering_prov_last_name','ordering_prov_middle_name','ordering_prov_npi','ordering_prov_state','pay_to_addr','pay_to_city','pay_to_state','pay_to_zip','performing_prov_tax_id','place_of_service_code','place_of_service_name','prov_a_addr','prov_a_city','prov_a_service_role_code','prov_a_state','prov_a_zip');
EXPORT FieldTypeNum(SALT31.StrType fn) := CASE(fn,'claim_type' => 1,'claim_num' => 2,'billing_addr' => 3,'billing_city' => 4,'billing_first_name' => 5,'billing_last_name' => 6,'billing_middle_name' => 7,'billing_npi' => 8,'billing_org_name' => 9,'billing_specialty_code' => 10,'billing_state' => 11,'billing_tax_id' => 12,'billing_upin' => 13,'billing_zip' => 14,'diag_code1' => 15,'diag_code2' => 16,'diag_code3' => 17,'diag_code4' => 18,'diag_code5' => 19,'diag_code6' => 20,'diag_code7' => 21,'diag_code8' => 22,'ext_injury_diag_code' => 23,'facility_lab_addr' => 24,'facility_lab_city' => 25,'facility_lab_name' => 26,'facility_lab_npi' => 27,'facility_lab_state' => 28,'facility_lab_zip' => 29,'ordering_prov_first_name' => 30,'ordering_prov_last_name' => 31,'ordering_prov_middle_name' => 32,'ordering_prov_npi' => 33,'ordering_prov_state' => 34,'pay_to_addr' => 35,'pay_to_city' => 36,'pay_to_state' => 37,'pay_to_zip' => 38,'performing_prov_tax_id' => 39,'place_of_service_code' => 40,'place_of_service_name' => 41,'prov_a_addr' => 42,'prov_a_city' => 43,'prov_a_service_role_code' => 44,'prov_a_state' => 45,'prov_a_zip' => 46,0);
EXPORT MakeFT_claim_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'P '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_claim_type(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'P '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_claim_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('P '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_claim_num(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_claim_num(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 15),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_claim_num(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('15'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_billing_addr(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ,.0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_billing_addr(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ,.0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '))));
EXPORT InValidMessageFT_billing_addr(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ,.0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_billing_city(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_billing_city(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ABCDEFGHIJKLMNOPRSTUVWXYZ '))));
EXPORT InValidMessageFT_billing_city(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_billing_first_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ,.ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_billing_first_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ,.ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_billing_first_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ,.ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_billing_last_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ,-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_billing_last_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ,-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_billing_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ,-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_billing_middle_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s1;
END;
EXPORT InValidFT_billing_middle_name(SALT31.StrType s) := WHICH();
EXPORT InValidMessageFT_billing_middle_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.Good);
EXPORT MakeFT_billing_npi(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_billing_npi(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_billing_npi(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('10,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_billing_org_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' &,-.ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_billing_org_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' &,-.ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_billing_org_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' &,-.ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_billing_specialty_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_billing_specialty_code(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_billing_specialty_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,2,1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_billing_state(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ACDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_billing_state(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ACDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 2),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_billing_state(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ACDEFGHIJKLMNOPRSTUVWXYZ '),SALT31.HygieneErrors.NotLength('2'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_billing_tax_id(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_billing_tax_id(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_billing_tax_id(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('9,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_billing_upin(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ABCDEFGHKLMNOPRSTVWXZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_billing_upin(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ABCDEFGHKLMNOPRSTVWXZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 6),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_billing_upin(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ABCDEFGHKLMNOPRSTVWXZ '),SALT31.HygieneErrors.NotLength('0,6'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_billing_zip(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_billing_zip(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 5),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_billing_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('5'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_diag_code1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789EV '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789EV '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789EV '),SALT31.HygieneErrors.NotLength('4,5,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_diag_code2(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789EV '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code2(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789EV '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789EV '),SALT31.HygieneErrors.NotLength('0,4,5,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_diag_code3(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789EV '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code3(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789EV '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code3(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789EV '),SALT31.HygieneErrors.NotLength('0,4,5,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_diag_code4(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789EV '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code4(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789EV '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code4(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789EV '),SALT31.HygieneErrors.NotLength('0,4,5,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_diag_code5(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789EV '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code5(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789EV '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code5(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789EV '),SALT31.HygieneErrors.NotLength('0,4,5,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_diag_code6(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789EV '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code6(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789EV '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code6(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789EV '),SALT31.HygieneErrors.NotLength('0,4,5,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_diag_code7(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789EV '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code7(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789EV '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code7(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789EV '),SALT31.HygieneErrors.NotLength('0,4,5,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_diag_code8(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789EV '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code8(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789EV '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code8(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789EV '),SALT31.HygieneErrors.NotLength('0,4,5,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_ext_injury_diag_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789E '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_ext_injury_diag_code(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789E '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_ext_injury_diag_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789E '),SALT31.HygieneErrors.NotLength('0,5'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_facility_lab_addr(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ,.0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_facility_lab_addr(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ,.0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '))));
EXPORT InValidMessageFT_facility_lab_addr(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ,.0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_facility_lab_city(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_facility_lab_city(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ABCDEFGHIJKLMNOPRSTUVWXYZ '))));
EXPORT InValidMessageFT_facility_lab_city(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_facility_lab_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' &,-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZaceiorst '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_facility_lab_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' &,-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZaceiorst '))));
EXPORT InValidMessageFT_facility_lab_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' &,-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZaceiorst '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_facility_lab_npi(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_facility_lab_npi(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_facility_lab_npi(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('10,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_facility_lab_state(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ACDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_facility_lab_state(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ACDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_facility_lab_state(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ACDEFGHIJKLMNOPRSTUVWXYZ '),SALT31.HygieneErrors.NotLength('2,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_facility_lab_zip(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_facility_lab_zip(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_facility_lab_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('5,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_ordering_prov_first_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_ordering_prov_first_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ABCDEFGHIJKLMNOPRSTUVWXYZ '))));
EXPORT InValidMessageFT_ordering_prov_first_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_ordering_prov_last_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_ordering_prov_last_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWYZ '))));
EXPORT InValidMessageFT_ordering_prov_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_ordering_prov_middle_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_ordering_prov_middle_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWYZ '))));
EXPORT InValidMessageFT_ordering_prov_middle_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_ordering_prov_npi(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_ordering_prov_npi(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_ordering_prov_npi(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,10'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_ordering_prov_state(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_ordering_prov_state(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_ordering_prov_state(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWYZ '),SALT31.HygieneErrors.NotLength('0,2'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_pay_to_addr(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ,.0123456789ABCDEFGHIJKLMNOPRSTUVWXY '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_pay_to_addr(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ,.0123456789ABCDEFGHIJKLMNOPRSTUVWXY '))));
EXPORT InValidMessageFT_pay_to_addr(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ,.0123456789ABCDEFGHIJKLMNOPRSTUVWXY '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_pay_to_city(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_pay_to_city(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ABCDEFGHIJKLMNOPRSTUVWXYZ '))));
EXPORT InValidMessageFT_pay_to_city(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_pay_to_state(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ACDEFGHIJKLMNOPRSTVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_pay_to_state(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ACDEFGHIJKLMNOPRSTVWXYZ '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_pay_to_state(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ACDEFGHIJKLMNOPRSTVWXYZ '),SALT31.HygieneErrors.NotLength('2,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_pay_to_zip(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_pay_to_zip(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_pay_to_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('5,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_performing_prov_tax_id(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_performing_prov_tax_id(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 9),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_performing_prov_tax_id(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,9'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_place_of_service_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_place_of_service_code(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 2),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_place_of_service_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('2'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_place_of_service_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' &,-.ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_place_of_service_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' &,-.ABCDEFGHIJKLMNOPRSTUVWXYZ '))));
EXPORT InValidMessageFT_place_of_service_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' &,-.ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_prov_a_addr(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' 0123456789ABCDEFGHIJKLMNOPRSTUVWXY '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prov_a_addr(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' 0123456789ABCDEFGHIJKLMNOPRSTUVWXY '))));
EXPORT InValidMessageFT_prov_a_addr(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' 0123456789ABCDEFGHIJKLMNOPRSTUVWXY '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_prov_a_city(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ABCDEFGHIJKLMNOPRSTUVWY '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prov_a_city(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ABCDEFGHIJKLMNOPRSTUVWY '))));
EXPORT InValidMessageFT_prov_a_city(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPRSTUVWY '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_prov_a_service_role_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'DO '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prov_a_service_role_code(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'DO '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_prov_a_service_role_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('DO '),SALT31.HygieneErrors.NotLength('0,2'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_prov_a_state(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ACDFGHIJKLMNOPRSTVWXY '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prov_a_state(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ACDFGHIJKLMNOPRSTVWXY '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_prov_a_state(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ACDFGHIJKLMNOPRSTVWXY '),SALT31.HygieneErrors.NotLength('0,2'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_prov_a_zip(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prov_a_zip(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 5),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_prov_a_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,9,5'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT SALT31.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'claim_type','claim_num','billing_pay_to_taxonomy','billing_addr','billing_anesth_lic','billing_city','billing_dentist_lic','billing_first_name','billing_last_name','billing_middle_name','billing_npi','billing_org_name','billing_service_phone','billing_specialty_code','billing_specialty_lic','billing_state','billing_state_lic','billing_tax_id','billing_upin','billing_zip','diag_code1','diag_code2','diag_code3','diag_code4','diag_code5','diag_code6','diag_code7','diag_code8','dme_hcpcs_proc_code','emt_paramedic_first_name','emt_paramedic_last_name','emt_paramedic_middle_name','ext_injury_diag_code','facility_lab_addr','facility_lab_city','facility_lab_name','facility_lab_npi','facility_lab_state','facility_lab_tax_id','facility_lab_type_code','facility_lab_zip','ordering_prov_addr','ordering_prov_city','ordering_prov_first_name','ordering_prov_last_name','ordering_prov_middle_name','ordering_prov_npi','ordering_prov_state','ordering_prov_upin','ordering_prov_zip','pay_to_addr','pay_to_city','pay_to_first_name','pay_to_last_name','pay_to_middle_name','pay_to_npi','pay_to_service_phone','pay_to_state','pay_to_tax_id','pay_to_zip','performing_prov_phone','performing_prov_specialty','performing_prov_tax_id','place_of_service_code','place_of_service_name','prov_a_addr','prov_a_city','prov_a_service_role_code','prov_a_state','prov_a_zip','prov_b_addr','prov_b_city','prov_b_service_role_code','prov_b_state','prov_b_zip','prov_c_addr','prov_c_city','prov_c_service_role_code','prov_c_state','prov_c_zip','purch_service_first_name','purch_service_last_name','purch_service_middle_name','purch_service_npi','purch_service_prov_addr','purch_service_prov_city','purch_service_prov_name','purch_service_prov_phone','purch_service_prov_state','purch_service_prov_zip');
EXPORT FieldNum(SALT31.StrType fn) := CASE(fn,'claim_type' => 1,'claim_num' => 2,'billing_pay_to_taxonomy' => 3,'billing_addr' => 4,'billing_anesth_lic' => 5,'billing_city' => 6,'billing_dentist_lic' => 7,'billing_first_name' => 8,'billing_last_name' => 9,'billing_middle_name' => 10,'billing_npi' => 11,'billing_org_name' => 12,'billing_service_phone' => 13,'billing_specialty_code' => 14,'billing_specialty_lic' => 15,'billing_state' => 16,'billing_state_lic' => 17,'billing_tax_id' => 18,'billing_upin' => 19,'billing_zip' => 20,'diag_code1' => 21,'diag_code2' => 22,'diag_code3' => 23,'diag_code4' => 24,'diag_code5' => 25,'diag_code6' => 26,'diag_code7' => 27,'diag_code8' => 28,'dme_hcpcs_proc_code' => 29,'emt_paramedic_first_name' => 30,'emt_paramedic_last_name' => 31,'emt_paramedic_middle_name' => 32,'ext_injury_diag_code' => 33,'facility_lab_addr' => 34,'facility_lab_city' => 35,'facility_lab_name' => 36,'facility_lab_npi' => 37,'facility_lab_state' => 38,'facility_lab_tax_id' => 39,'facility_lab_type_code' => 40,'facility_lab_zip' => 41,'ordering_prov_addr' => 42,'ordering_prov_city' => 43,'ordering_prov_first_name' => 44,'ordering_prov_last_name' => 45,'ordering_prov_middle_name' => 46,'ordering_prov_npi' => 47,'ordering_prov_state' => 48,'ordering_prov_upin' => 49,'ordering_prov_zip' => 50,'pay_to_addr' => 51,'pay_to_city' => 52,'pay_to_first_name' => 53,'pay_to_last_name' => 54,'pay_to_middle_name' => 55,'pay_to_npi' => 56,'pay_to_service_phone' => 57,'pay_to_state' => 58,'pay_to_tax_id' => 59,'pay_to_zip' => 60,'performing_prov_phone' => 61,'performing_prov_specialty' => 62,'performing_prov_tax_id' => 63,'place_of_service_code' => 64,'place_of_service_name' => 65,'prov_a_addr' => 66,'prov_a_city' => 67,'prov_a_service_role_code' => 68,'prov_a_state' => 69,'prov_a_zip' => 70,'prov_b_addr' => 71,'prov_b_city' => 72,'prov_b_service_role_code' => 73,'prov_b_state' => 74,'prov_b_zip' => 75,'prov_c_addr' => 76,'prov_c_city' => 77,'prov_c_service_role_code' => 78,'prov_c_state' => 79,'prov_c_zip' => 80,'purch_service_first_name' => 81,'purch_service_last_name' => 82,'purch_service_middle_name' => 83,'purch_service_npi' => 84,'purch_service_prov_addr' => 85,'purch_service_prov_city' => 86,'purch_service_prov_name' => 87,'purch_service_prov_phone' => 88,'purch_service_prov_state' => 89,'purch_service_prov_zip' => 90,0);
//Individual field level validation
EXPORT Make_claim_type(SALT31.StrType s0) := MakeFT_claim_type(s0);
EXPORT InValid_claim_type(SALT31.StrType s) := InValidFT_claim_type(s);
EXPORT InValidMessage_claim_type(UNSIGNED1 wh) := InValidMessageFT_claim_type(wh);
EXPORT Make_claim_num(SALT31.StrType s0) := MakeFT_claim_num(s0);
EXPORT InValid_claim_num(SALT31.StrType s) := InValidFT_claim_num(s);
EXPORT InValidMessage_claim_num(UNSIGNED1 wh) := InValidMessageFT_claim_num(wh);
EXPORT Make_billing_pay_to_taxonomy(SALT31.StrType s0) := s0;
EXPORT InValid_billing_pay_to_taxonomy(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_billing_pay_to_taxonomy(UNSIGNED1 wh) := '';
EXPORT Make_billing_addr(SALT31.StrType s0) := MakeFT_billing_addr(s0);
EXPORT InValid_billing_addr(SALT31.StrType s) := InValidFT_billing_addr(s);
EXPORT InValidMessage_billing_addr(UNSIGNED1 wh) := InValidMessageFT_billing_addr(wh);
EXPORT Make_billing_anesth_lic(SALT31.StrType s0) := s0;
EXPORT InValid_billing_anesth_lic(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_billing_anesth_lic(UNSIGNED1 wh) := '';
EXPORT Make_billing_city(SALT31.StrType s0) := MakeFT_billing_city(s0);
EXPORT InValid_billing_city(SALT31.StrType s) := InValidFT_billing_city(s);
EXPORT InValidMessage_billing_city(UNSIGNED1 wh) := InValidMessageFT_billing_city(wh);
EXPORT Make_billing_dentist_lic(SALT31.StrType s0) := s0;
EXPORT InValid_billing_dentist_lic(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_billing_dentist_lic(UNSIGNED1 wh) := '';
EXPORT Make_billing_first_name(SALT31.StrType s0) := MakeFT_billing_first_name(s0);
EXPORT InValid_billing_first_name(SALT31.StrType s) := InValidFT_billing_first_name(s);
EXPORT InValidMessage_billing_first_name(UNSIGNED1 wh) := InValidMessageFT_billing_first_name(wh);
EXPORT Make_billing_last_name(SALT31.StrType s0) := MakeFT_billing_last_name(s0);
EXPORT InValid_billing_last_name(SALT31.StrType s) := InValidFT_billing_last_name(s);
EXPORT InValidMessage_billing_last_name(UNSIGNED1 wh) := InValidMessageFT_billing_last_name(wh);
EXPORT Make_billing_middle_name(SALT31.StrType s0) := MakeFT_billing_middle_name(s0);
EXPORT InValid_billing_middle_name(SALT31.StrType s) := InValidFT_billing_middle_name(s);
EXPORT InValidMessage_billing_middle_name(UNSIGNED1 wh) := InValidMessageFT_billing_middle_name(wh);
EXPORT Make_billing_npi(SALT31.StrType s0) := MakeFT_billing_npi(s0);
EXPORT InValid_billing_npi(SALT31.StrType s) := InValidFT_billing_npi(s);
EXPORT InValidMessage_billing_npi(UNSIGNED1 wh) := InValidMessageFT_billing_npi(wh);
EXPORT Make_billing_org_name(SALT31.StrType s0) := MakeFT_billing_org_name(s0);
EXPORT InValid_billing_org_name(SALT31.StrType s) := InValidFT_billing_org_name(s);
EXPORT InValidMessage_billing_org_name(UNSIGNED1 wh) := InValidMessageFT_billing_org_name(wh);
EXPORT Make_billing_service_phone(SALT31.StrType s0) := s0;
EXPORT InValid_billing_service_phone(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_billing_service_phone(UNSIGNED1 wh) := '';
EXPORT Make_billing_specialty_code(SALT31.StrType s0) := MakeFT_billing_specialty_code(s0);
EXPORT InValid_billing_specialty_code(SALT31.StrType s) := InValidFT_billing_specialty_code(s);
EXPORT InValidMessage_billing_specialty_code(UNSIGNED1 wh) := InValidMessageFT_billing_specialty_code(wh);
EXPORT Make_billing_specialty_lic(SALT31.StrType s0) := s0;
EXPORT InValid_billing_specialty_lic(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_billing_specialty_lic(UNSIGNED1 wh) := '';
EXPORT Make_billing_state(SALT31.StrType s0) := MakeFT_billing_state(s0);
EXPORT InValid_billing_state(SALT31.StrType s) := InValidFT_billing_state(s);
EXPORT InValidMessage_billing_state(UNSIGNED1 wh) := InValidMessageFT_billing_state(wh);
EXPORT Make_billing_state_lic(SALT31.StrType s0) := s0;
EXPORT InValid_billing_state_lic(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_billing_state_lic(UNSIGNED1 wh) := '';
EXPORT Make_billing_tax_id(SALT31.StrType s0) := MakeFT_billing_tax_id(s0);
EXPORT InValid_billing_tax_id(SALT31.StrType s) := InValidFT_billing_tax_id(s);
EXPORT InValidMessage_billing_tax_id(UNSIGNED1 wh) := InValidMessageFT_billing_tax_id(wh);
EXPORT Make_billing_upin(SALT31.StrType s0) := MakeFT_billing_upin(s0);
EXPORT InValid_billing_upin(SALT31.StrType s) := InValidFT_billing_upin(s);
EXPORT InValidMessage_billing_upin(UNSIGNED1 wh) := InValidMessageFT_billing_upin(wh);
EXPORT Make_billing_zip(SALT31.StrType s0) := MakeFT_billing_zip(s0);
EXPORT InValid_billing_zip(SALT31.StrType s) := InValidFT_billing_zip(s);
EXPORT InValidMessage_billing_zip(UNSIGNED1 wh) := InValidMessageFT_billing_zip(wh);
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
EXPORT Make_diag_code5(SALT31.StrType s0) := MakeFT_diag_code5(s0);
EXPORT InValid_diag_code5(SALT31.StrType s) := InValidFT_diag_code5(s);
EXPORT InValidMessage_diag_code5(UNSIGNED1 wh) := InValidMessageFT_diag_code5(wh);
EXPORT Make_diag_code6(SALT31.StrType s0) := MakeFT_diag_code6(s0);
EXPORT InValid_diag_code6(SALT31.StrType s) := InValidFT_diag_code6(s);
EXPORT InValidMessage_diag_code6(UNSIGNED1 wh) := InValidMessageFT_diag_code6(wh);
EXPORT Make_diag_code7(SALT31.StrType s0) := MakeFT_diag_code7(s0);
EXPORT InValid_diag_code7(SALT31.StrType s) := InValidFT_diag_code7(s);
EXPORT InValidMessage_diag_code7(UNSIGNED1 wh) := InValidMessageFT_diag_code7(wh);
EXPORT Make_diag_code8(SALT31.StrType s0) := MakeFT_diag_code8(s0);
EXPORT InValid_diag_code8(SALT31.StrType s) := InValidFT_diag_code8(s);
EXPORT InValidMessage_diag_code8(UNSIGNED1 wh) := InValidMessageFT_diag_code8(wh);
EXPORT Make_dme_hcpcs_proc_code(SALT31.StrType s0) := s0;
EXPORT InValid_dme_hcpcs_proc_code(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_dme_hcpcs_proc_code(UNSIGNED1 wh) := '';
EXPORT Make_emt_paramedic_first_name(SALT31.StrType s0) := s0;
EXPORT InValid_emt_paramedic_first_name(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_emt_paramedic_first_name(UNSIGNED1 wh) := '';
EXPORT Make_emt_paramedic_last_name(SALT31.StrType s0) := s0;
EXPORT InValid_emt_paramedic_last_name(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_emt_paramedic_last_name(UNSIGNED1 wh) := '';
EXPORT Make_emt_paramedic_middle_name(SALT31.StrType s0) := s0;
EXPORT InValid_emt_paramedic_middle_name(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_emt_paramedic_middle_name(UNSIGNED1 wh) := '';
EXPORT Make_ext_injury_diag_code(SALT31.StrType s0) := MakeFT_ext_injury_diag_code(s0);
EXPORT InValid_ext_injury_diag_code(SALT31.StrType s) := InValidFT_ext_injury_diag_code(s);
EXPORT InValidMessage_ext_injury_diag_code(UNSIGNED1 wh) := InValidMessageFT_ext_injury_diag_code(wh);
EXPORT Make_facility_lab_addr(SALT31.StrType s0) := MakeFT_facility_lab_addr(s0);
EXPORT InValid_facility_lab_addr(SALT31.StrType s) := InValidFT_facility_lab_addr(s);
EXPORT InValidMessage_facility_lab_addr(UNSIGNED1 wh) := InValidMessageFT_facility_lab_addr(wh);
EXPORT Make_facility_lab_city(SALT31.StrType s0) := MakeFT_facility_lab_city(s0);
EXPORT InValid_facility_lab_city(SALT31.StrType s) := InValidFT_facility_lab_city(s);
EXPORT InValidMessage_facility_lab_city(UNSIGNED1 wh) := InValidMessageFT_facility_lab_city(wh);
EXPORT Make_facility_lab_name(SALT31.StrType s0) := MakeFT_facility_lab_name(s0);
EXPORT InValid_facility_lab_name(SALT31.StrType s) := InValidFT_facility_lab_name(s);
EXPORT InValidMessage_facility_lab_name(UNSIGNED1 wh) := InValidMessageFT_facility_lab_name(wh);
EXPORT Make_facility_lab_npi(SALT31.StrType s0) := MakeFT_facility_lab_npi(s0);
EXPORT InValid_facility_lab_npi(SALT31.StrType s) := InValidFT_facility_lab_npi(s);
EXPORT InValidMessage_facility_lab_npi(UNSIGNED1 wh) := InValidMessageFT_facility_lab_npi(wh);
EXPORT Make_facility_lab_state(SALT31.StrType s0) := MakeFT_facility_lab_state(s0);
EXPORT InValid_facility_lab_state(SALT31.StrType s) := InValidFT_facility_lab_state(s);
EXPORT InValidMessage_facility_lab_state(UNSIGNED1 wh) := InValidMessageFT_facility_lab_state(wh);
EXPORT Make_facility_lab_tax_id(SALT31.StrType s0) := s0;
EXPORT InValid_facility_lab_tax_id(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_facility_lab_tax_id(UNSIGNED1 wh) := '';
EXPORT Make_facility_lab_type_code(SALT31.StrType s0) := s0;
EXPORT InValid_facility_lab_type_code(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_facility_lab_type_code(UNSIGNED1 wh) := '';
EXPORT Make_facility_lab_zip(SALT31.StrType s0) := MakeFT_facility_lab_zip(s0);
EXPORT InValid_facility_lab_zip(SALT31.StrType s) := InValidFT_facility_lab_zip(s);
EXPORT InValidMessage_facility_lab_zip(UNSIGNED1 wh) := InValidMessageFT_facility_lab_zip(wh);
EXPORT Make_ordering_prov_addr(SALT31.StrType s0) := s0;
EXPORT InValid_ordering_prov_addr(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_ordering_prov_addr(UNSIGNED1 wh) := '';
EXPORT Make_ordering_prov_city(SALT31.StrType s0) := s0;
EXPORT InValid_ordering_prov_city(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_ordering_prov_city(UNSIGNED1 wh) := '';
EXPORT Make_ordering_prov_first_name(SALT31.StrType s0) := MakeFT_ordering_prov_first_name(s0);
EXPORT InValid_ordering_prov_first_name(SALT31.StrType s) := InValidFT_ordering_prov_first_name(s);
EXPORT InValidMessage_ordering_prov_first_name(UNSIGNED1 wh) := InValidMessageFT_ordering_prov_first_name(wh);
EXPORT Make_ordering_prov_last_name(SALT31.StrType s0) := MakeFT_ordering_prov_last_name(s0);
EXPORT InValid_ordering_prov_last_name(SALT31.StrType s) := InValidFT_ordering_prov_last_name(s);
EXPORT InValidMessage_ordering_prov_last_name(UNSIGNED1 wh) := InValidMessageFT_ordering_prov_last_name(wh);
EXPORT Make_ordering_prov_middle_name(SALT31.StrType s0) := MakeFT_ordering_prov_middle_name(s0);
EXPORT InValid_ordering_prov_middle_name(SALT31.StrType s) := InValidFT_ordering_prov_middle_name(s);
EXPORT InValidMessage_ordering_prov_middle_name(UNSIGNED1 wh) := InValidMessageFT_ordering_prov_middle_name(wh);
EXPORT Make_ordering_prov_npi(SALT31.StrType s0) := MakeFT_ordering_prov_npi(s0);
EXPORT InValid_ordering_prov_npi(SALT31.StrType s) := InValidFT_ordering_prov_npi(s);
EXPORT InValidMessage_ordering_prov_npi(UNSIGNED1 wh) := InValidMessageFT_ordering_prov_npi(wh);
EXPORT Make_ordering_prov_state(SALT31.StrType s0) := MakeFT_ordering_prov_state(s0);
EXPORT InValid_ordering_prov_state(SALT31.StrType s) := InValidFT_ordering_prov_state(s);
EXPORT InValidMessage_ordering_prov_state(UNSIGNED1 wh) := InValidMessageFT_ordering_prov_state(wh);
EXPORT Make_ordering_prov_upin(SALT31.StrType s0) := s0;
EXPORT InValid_ordering_prov_upin(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_ordering_prov_upin(UNSIGNED1 wh) := '';
EXPORT Make_ordering_prov_zip(SALT31.StrType s0) := s0;
EXPORT InValid_ordering_prov_zip(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_ordering_prov_zip(UNSIGNED1 wh) := '';
EXPORT Make_pay_to_addr(SALT31.StrType s0) := MakeFT_pay_to_addr(s0);
EXPORT InValid_pay_to_addr(SALT31.StrType s) := InValidFT_pay_to_addr(s);
EXPORT InValidMessage_pay_to_addr(UNSIGNED1 wh) := InValidMessageFT_pay_to_addr(wh);
EXPORT Make_pay_to_city(SALT31.StrType s0) := MakeFT_pay_to_city(s0);
EXPORT InValid_pay_to_city(SALT31.StrType s) := InValidFT_pay_to_city(s);
EXPORT InValidMessage_pay_to_city(UNSIGNED1 wh) := InValidMessageFT_pay_to_city(wh);
EXPORT Make_pay_to_first_name(SALT31.StrType s0) := s0;
EXPORT InValid_pay_to_first_name(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_pay_to_first_name(UNSIGNED1 wh) := '';
EXPORT Make_pay_to_last_name(SALT31.StrType s0) := s0;
EXPORT InValid_pay_to_last_name(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_pay_to_last_name(UNSIGNED1 wh) := '';
EXPORT Make_pay_to_middle_name(SALT31.StrType s0) := s0;
EXPORT InValid_pay_to_middle_name(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_pay_to_middle_name(UNSIGNED1 wh) := '';
EXPORT Make_pay_to_npi(SALT31.StrType s0) := s0;
EXPORT InValid_pay_to_npi(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_pay_to_npi(UNSIGNED1 wh) := '';
EXPORT Make_pay_to_service_phone(SALT31.StrType s0) := s0;
EXPORT InValid_pay_to_service_phone(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_pay_to_service_phone(UNSIGNED1 wh) := '';
EXPORT Make_pay_to_state(SALT31.StrType s0) := MakeFT_pay_to_state(s0);
EXPORT InValid_pay_to_state(SALT31.StrType s) := InValidFT_pay_to_state(s);
EXPORT InValidMessage_pay_to_state(UNSIGNED1 wh) := InValidMessageFT_pay_to_state(wh);
EXPORT Make_pay_to_tax_id(SALT31.StrType s0) := s0;
EXPORT InValid_pay_to_tax_id(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_pay_to_tax_id(UNSIGNED1 wh) := '';
EXPORT Make_pay_to_zip(SALT31.StrType s0) := MakeFT_pay_to_zip(s0);
EXPORT InValid_pay_to_zip(SALT31.StrType s) := InValidFT_pay_to_zip(s);
EXPORT InValidMessage_pay_to_zip(UNSIGNED1 wh) := InValidMessageFT_pay_to_zip(wh);
EXPORT Make_performing_prov_phone(SALT31.StrType s0) := s0;
EXPORT InValid_performing_prov_phone(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_performing_prov_phone(UNSIGNED1 wh) := '';
EXPORT Make_performing_prov_specialty(SALT31.StrType s0) := s0;
EXPORT InValid_performing_prov_specialty(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_performing_prov_specialty(UNSIGNED1 wh) := '';
EXPORT Make_performing_prov_tax_id(SALT31.StrType s0) := MakeFT_performing_prov_tax_id(s0);
EXPORT InValid_performing_prov_tax_id(SALT31.StrType s) := InValidFT_performing_prov_tax_id(s);
EXPORT InValidMessage_performing_prov_tax_id(UNSIGNED1 wh) := InValidMessageFT_performing_prov_tax_id(wh);
EXPORT Make_place_of_service_code(SALT31.StrType s0) := MakeFT_place_of_service_code(s0);
EXPORT InValid_place_of_service_code(SALT31.StrType s) := InValidFT_place_of_service_code(s);
EXPORT InValidMessage_place_of_service_code(UNSIGNED1 wh) := InValidMessageFT_place_of_service_code(wh);
EXPORT Make_place_of_service_name(SALT31.StrType s0) := MakeFT_place_of_service_name(s0);
EXPORT InValid_place_of_service_name(SALT31.StrType s) := InValidFT_place_of_service_name(s);
EXPORT InValidMessage_place_of_service_name(UNSIGNED1 wh) := InValidMessageFT_place_of_service_name(wh);
EXPORT Make_prov_a_addr(SALT31.StrType s0) := MakeFT_prov_a_addr(s0);
EXPORT InValid_prov_a_addr(SALT31.StrType s) := InValidFT_prov_a_addr(s);
EXPORT InValidMessage_prov_a_addr(UNSIGNED1 wh) := InValidMessageFT_prov_a_addr(wh);
EXPORT Make_prov_a_city(SALT31.StrType s0) := MakeFT_prov_a_city(s0);
EXPORT InValid_prov_a_city(SALT31.StrType s) := InValidFT_prov_a_city(s);
EXPORT InValidMessage_prov_a_city(UNSIGNED1 wh) := InValidMessageFT_prov_a_city(wh);
EXPORT Make_prov_a_service_role_code(SALT31.StrType s0) := MakeFT_prov_a_service_role_code(s0);
EXPORT InValid_prov_a_service_role_code(SALT31.StrType s) := InValidFT_prov_a_service_role_code(s);
EXPORT InValidMessage_prov_a_service_role_code(UNSIGNED1 wh) := InValidMessageFT_prov_a_service_role_code(wh);
EXPORT Make_prov_a_state(SALT31.StrType s0) := MakeFT_prov_a_state(s0);
EXPORT InValid_prov_a_state(SALT31.StrType s) := InValidFT_prov_a_state(s);
EXPORT InValidMessage_prov_a_state(UNSIGNED1 wh) := InValidMessageFT_prov_a_state(wh);
EXPORT Make_prov_a_zip(SALT31.StrType s0) := MakeFT_prov_a_zip(s0);
EXPORT InValid_prov_a_zip(SALT31.StrType s) := InValidFT_prov_a_zip(s);
EXPORT InValidMessage_prov_a_zip(UNSIGNED1 wh) := InValidMessageFT_prov_a_zip(wh);
EXPORT Make_prov_b_addr(SALT31.StrType s0) := s0;
EXPORT InValid_prov_b_addr(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_prov_b_addr(UNSIGNED1 wh) := '';
EXPORT Make_prov_b_city(SALT31.StrType s0) := s0;
EXPORT InValid_prov_b_city(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_prov_b_city(UNSIGNED1 wh) := '';
EXPORT Make_prov_b_service_role_code(SALT31.StrType s0) := s0;
EXPORT InValid_prov_b_service_role_code(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_prov_b_service_role_code(UNSIGNED1 wh) := '';
EXPORT Make_prov_b_state(SALT31.StrType s0) := s0;
EXPORT InValid_prov_b_state(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_prov_b_state(UNSIGNED1 wh) := '';
EXPORT Make_prov_b_zip(SALT31.StrType s0) := s0;
EXPORT InValid_prov_b_zip(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_prov_b_zip(UNSIGNED1 wh) := '';
EXPORT Make_prov_c_addr(SALT31.StrType s0) := s0;
EXPORT InValid_prov_c_addr(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_prov_c_addr(UNSIGNED1 wh) := '';
EXPORT Make_prov_c_city(SALT31.StrType s0) := s0;
EXPORT InValid_prov_c_city(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_prov_c_city(UNSIGNED1 wh) := '';
EXPORT Make_prov_c_service_role_code(SALT31.StrType s0) := s0;
EXPORT InValid_prov_c_service_role_code(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_prov_c_service_role_code(UNSIGNED1 wh) := '';
EXPORT Make_prov_c_state(SALT31.StrType s0) := s0;
EXPORT InValid_prov_c_state(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_prov_c_state(UNSIGNED1 wh) := '';
EXPORT Make_prov_c_zip(SALT31.StrType s0) := s0;
EXPORT InValid_prov_c_zip(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_prov_c_zip(UNSIGNED1 wh) := '';
EXPORT Make_purch_service_first_name(SALT31.StrType s0) := s0;
EXPORT InValid_purch_service_first_name(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_purch_service_first_name(UNSIGNED1 wh) := '';
EXPORT Make_purch_service_last_name(SALT31.StrType s0) := s0;
EXPORT InValid_purch_service_last_name(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_purch_service_last_name(UNSIGNED1 wh) := '';
EXPORT Make_purch_service_middle_name(SALT31.StrType s0) := s0;
EXPORT InValid_purch_service_middle_name(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_purch_service_middle_name(UNSIGNED1 wh) := '';
EXPORT Make_purch_service_npi(SALT31.StrType s0) := s0;
EXPORT InValid_purch_service_npi(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_purch_service_npi(UNSIGNED1 wh) := '';
EXPORT Make_purch_service_prov_addr(SALT31.StrType s0) := s0;
EXPORT InValid_purch_service_prov_addr(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_purch_service_prov_addr(UNSIGNED1 wh) := '';
EXPORT Make_purch_service_prov_city(SALT31.StrType s0) := s0;
EXPORT InValid_purch_service_prov_city(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_purch_service_prov_city(UNSIGNED1 wh) := '';
EXPORT Make_purch_service_prov_name(SALT31.StrType s0) := s0;
EXPORT InValid_purch_service_prov_name(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_purch_service_prov_name(UNSIGNED1 wh) := '';
EXPORT Make_purch_service_prov_phone(SALT31.StrType s0) := s0;
EXPORT InValid_purch_service_prov_phone(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_purch_service_prov_phone(UNSIGNED1 wh) := '';
EXPORT Make_purch_service_prov_state(SALT31.StrType s0) := s0;
EXPORT InValid_purch_service_prov_state(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_purch_service_prov_state(UNSIGNED1 wh) := '';
EXPORT Make_purch_service_prov_zip(SALT31.StrType s0) := s0;
EXPORT InValid_purch_service_prov_zip(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_purch_service_prov_zip(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT31,Scrubs_MX;
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
    BOOLEAN Diff_billing_pay_to_taxonomy;
    BOOLEAN Diff_billing_addr;
    BOOLEAN Diff_billing_anesth_lic;
    BOOLEAN Diff_billing_city;
    BOOLEAN Diff_billing_dentist_lic;
    BOOLEAN Diff_billing_first_name;
    BOOLEAN Diff_billing_last_name;
    BOOLEAN Diff_billing_middle_name;
    BOOLEAN Diff_billing_npi;
    BOOLEAN Diff_billing_org_name;
    BOOLEAN Diff_billing_service_phone;
    BOOLEAN Diff_billing_specialty_code;
    BOOLEAN Diff_billing_specialty_lic;
    BOOLEAN Diff_billing_state;
    BOOLEAN Diff_billing_state_lic;
    BOOLEAN Diff_billing_tax_id;
    BOOLEAN Diff_billing_upin;
    BOOLEAN Diff_billing_zip;
    BOOLEAN Diff_diag_code1;
    BOOLEAN Diff_diag_code2;
    BOOLEAN Diff_diag_code3;
    BOOLEAN Diff_diag_code4;
    BOOLEAN Diff_diag_code5;
    BOOLEAN Diff_diag_code6;
    BOOLEAN Diff_diag_code7;
    BOOLEAN Diff_diag_code8;
    BOOLEAN Diff_dme_hcpcs_proc_code;
    BOOLEAN Diff_emt_paramedic_first_name;
    BOOLEAN Diff_emt_paramedic_last_name;
    BOOLEAN Diff_emt_paramedic_middle_name;
    BOOLEAN Diff_ext_injury_diag_code;
    BOOLEAN Diff_facility_lab_addr;
    BOOLEAN Diff_facility_lab_city;
    BOOLEAN Diff_facility_lab_name;
    BOOLEAN Diff_facility_lab_npi;
    BOOLEAN Diff_facility_lab_state;
    BOOLEAN Diff_facility_lab_tax_id;
    BOOLEAN Diff_facility_lab_type_code;
    BOOLEAN Diff_facility_lab_zip;
    BOOLEAN Diff_ordering_prov_addr;
    BOOLEAN Diff_ordering_prov_city;
    BOOLEAN Diff_ordering_prov_first_name;
    BOOLEAN Diff_ordering_prov_last_name;
    BOOLEAN Diff_ordering_prov_middle_name;
    BOOLEAN Diff_ordering_prov_npi;
    BOOLEAN Diff_ordering_prov_state;
    BOOLEAN Diff_ordering_prov_upin;
    BOOLEAN Diff_ordering_prov_zip;
    BOOLEAN Diff_pay_to_addr;
    BOOLEAN Diff_pay_to_city;
    BOOLEAN Diff_pay_to_first_name;
    BOOLEAN Diff_pay_to_last_name;
    BOOLEAN Diff_pay_to_middle_name;
    BOOLEAN Diff_pay_to_npi;
    BOOLEAN Diff_pay_to_service_phone;
    BOOLEAN Diff_pay_to_state;
    BOOLEAN Diff_pay_to_tax_id;
    BOOLEAN Diff_pay_to_zip;
    BOOLEAN Diff_performing_prov_phone;
    BOOLEAN Diff_performing_prov_specialty;
    BOOLEAN Diff_performing_prov_tax_id;
    BOOLEAN Diff_place_of_service_code;
    BOOLEAN Diff_place_of_service_name;
    BOOLEAN Diff_prov_a_addr;
    BOOLEAN Diff_prov_a_city;
    BOOLEAN Diff_prov_a_service_role_code;
    BOOLEAN Diff_prov_a_state;
    BOOLEAN Diff_prov_a_zip;
    BOOLEAN Diff_prov_b_addr;
    BOOLEAN Diff_prov_b_city;
    BOOLEAN Diff_prov_b_service_role_code;
    BOOLEAN Diff_prov_b_state;
    BOOLEAN Diff_prov_b_zip;
    BOOLEAN Diff_prov_c_addr;
    BOOLEAN Diff_prov_c_city;
    BOOLEAN Diff_prov_c_service_role_code;
    BOOLEAN Diff_prov_c_state;
    BOOLEAN Diff_prov_c_zip;
    BOOLEAN Diff_purch_service_first_name;
    BOOLEAN Diff_purch_service_last_name;
    BOOLEAN Diff_purch_service_middle_name;
    BOOLEAN Diff_purch_service_npi;
    BOOLEAN Diff_purch_service_prov_addr;
    BOOLEAN Diff_purch_service_prov_city;
    BOOLEAN Diff_purch_service_prov_name;
    BOOLEAN Diff_purch_service_prov_phone;
    BOOLEAN Diff_purch_service_prov_state;
    BOOLEAN Diff_purch_service_prov_zip;
    UNSIGNED Num_Diffs;
    SALT31.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_claim_type := le.claim_type <> ri.claim_type;
    SELF.Diff_claim_num := le.claim_num <> ri.claim_num;
    SELF.Diff_billing_pay_to_taxonomy := le.billing_pay_to_taxonomy <> ri.billing_pay_to_taxonomy;
    SELF.Diff_billing_addr := le.billing_addr <> ri.billing_addr;
    SELF.Diff_billing_anesth_lic := le.billing_anesth_lic <> ri.billing_anesth_lic;
    SELF.Diff_billing_city := le.billing_city <> ri.billing_city;
    SELF.Diff_billing_dentist_lic := le.billing_dentist_lic <> ri.billing_dentist_lic;
    SELF.Diff_billing_first_name := le.billing_first_name <> ri.billing_first_name;
    SELF.Diff_billing_last_name := le.billing_last_name <> ri.billing_last_name;
    SELF.Diff_billing_middle_name := le.billing_middle_name <> ri.billing_middle_name;
    SELF.Diff_billing_npi := le.billing_npi <> ri.billing_npi;
    SELF.Diff_billing_org_name := le.billing_org_name <> ri.billing_org_name;
    SELF.Diff_billing_service_phone := le.billing_service_phone <> ri.billing_service_phone;
    SELF.Diff_billing_specialty_code := le.billing_specialty_code <> ri.billing_specialty_code;
    SELF.Diff_billing_specialty_lic := le.billing_specialty_lic <> ri.billing_specialty_lic;
    SELF.Diff_billing_state := le.billing_state <> ri.billing_state;
    SELF.Diff_billing_state_lic := le.billing_state_lic <> ri.billing_state_lic;
    SELF.Diff_billing_tax_id := le.billing_tax_id <> ri.billing_tax_id;
    SELF.Diff_billing_upin := le.billing_upin <> ri.billing_upin;
    SELF.Diff_billing_zip := le.billing_zip <> ri.billing_zip;
    SELF.Diff_diag_code1 := le.diag_code1 <> ri.diag_code1;
    SELF.Diff_diag_code2 := le.diag_code2 <> ri.diag_code2;
    SELF.Diff_diag_code3 := le.diag_code3 <> ri.diag_code3;
    SELF.Diff_diag_code4 := le.diag_code4 <> ri.diag_code4;
    SELF.Diff_diag_code5 := le.diag_code5 <> ri.diag_code5;
    SELF.Diff_diag_code6 := le.diag_code6 <> ri.diag_code6;
    SELF.Diff_diag_code7 := le.diag_code7 <> ri.diag_code7;
    SELF.Diff_diag_code8 := le.diag_code8 <> ri.diag_code8;
    SELF.Diff_dme_hcpcs_proc_code := le.dme_hcpcs_proc_code <> ri.dme_hcpcs_proc_code;
    SELF.Diff_emt_paramedic_first_name := le.emt_paramedic_first_name <> ri.emt_paramedic_first_name;
    SELF.Diff_emt_paramedic_last_name := le.emt_paramedic_last_name <> ri.emt_paramedic_last_name;
    SELF.Diff_emt_paramedic_middle_name := le.emt_paramedic_middle_name <> ri.emt_paramedic_middle_name;
    SELF.Diff_ext_injury_diag_code := le.ext_injury_diag_code <> ri.ext_injury_diag_code;
    SELF.Diff_facility_lab_addr := le.facility_lab_addr <> ri.facility_lab_addr;
    SELF.Diff_facility_lab_city := le.facility_lab_city <> ri.facility_lab_city;
    SELF.Diff_facility_lab_name := le.facility_lab_name <> ri.facility_lab_name;
    SELF.Diff_facility_lab_npi := le.facility_lab_npi <> ri.facility_lab_npi;
    SELF.Diff_facility_lab_state := le.facility_lab_state <> ri.facility_lab_state;
    SELF.Diff_facility_lab_tax_id := le.facility_lab_tax_id <> ri.facility_lab_tax_id;
    SELF.Diff_facility_lab_type_code := le.facility_lab_type_code <> ri.facility_lab_type_code;
    SELF.Diff_facility_lab_zip := le.facility_lab_zip <> ri.facility_lab_zip;
    SELF.Diff_ordering_prov_addr := le.ordering_prov_addr <> ri.ordering_prov_addr;
    SELF.Diff_ordering_prov_city := le.ordering_prov_city <> ri.ordering_prov_city;
    SELF.Diff_ordering_prov_first_name := le.ordering_prov_first_name <> ri.ordering_prov_first_name;
    SELF.Diff_ordering_prov_last_name := le.ordering_prov_last_name <> ri.ordering_prov_last_name;
    SELF.Diff_ordering_prov_middle_name := le.ordering_prov_middle_name <> ri.ordering_prov_middle_name;
    SELF.Diff_ordering_prov_npi := le.ordering_prov_npi <> ri.ordering_prov_npi;
    SELF.Diff_ordering_prov_state := le.ordering_prov_state <> ri.ordering_prov_state;
    SELF.Diff_ordering_prov_upin := le.ordering_prov_upin <> ri.ordering_prov_upin;
    SELF.Diff_ordering_prov_zip := le.ordering_prov_zip <> ri.ordering_prov_zip;
    SELF.Diff_pay_to_addr := le.pay_to_addr <> ri.pay_to_addr;
    SELF.Diff_pay_to_city := le.pay_to_city <> ri.pay_to_city;
    SELF.Diff_pay_to_first_name := le.pay_to_first_name <> ri.pay_to_first_name;
    SELF.Diff_pay_to_last_name := le.pay_to_last_name <> ri.pay_to_last_name;
    SELF.Diff_pay_to_middle_name := le.pay_to_middle_name <> ri.pay_to_middle_name;
    SELF.Diff_pay_to_npi := le.pay_to_npi <> ri.pay_to_npi;
    SELF.Diff_pay_to_service_phone := le.pay_to_service_phone <> ri.pay_to_service_phone;
    SELF.Diff_pay_to_state := le.pay_to_state <> ri.pay_to_state;
    SELF.Diff_pay_to_tax_id := le.pay_to_tax_id <> ri.pay_to_tax_id;
    SELF.Diff_pay_to_zip := le.pay_to_zip <> ri.pay_to_zip;
    SELF.Diff_performing_prov_phone := le.performing_prov_phone <> ri.performing_prov_phone;
    SELF.Diff_performing_prov_specialty := le.performing_prov_specialty <> ri.performing_prov_specialty;
    SELF.Diff_performing_prov_tax_id := le.performing_prov_tax_id <> ri.performing_prov_tax_id;
    SELF.Diff_place_of_service_code := le.place_of_service_code <> ri.place_of_service_code;
    SELF.Diff_place_of_service_name := le.place_of_service_name <> ri.place_of_service_name;
    SELF.Diff_prov_a_addr := le.prov_a_addr <> ri.prov_a_addr;
    SELF.Diff_prov_a_city := le.prov_a_city <> ri.prov_a_city;
    SELF.Diff_prov_a_service_role_code := le.prov_a_service_role_code <> ri.prov_a_service_role_code;
    SELF.Diff_prov_a_state := le.prov_a_state <> ri.prov_a_state;
    SELF.Diff_prov_a_zip := le.prov_a_zip <> ri.prov_a_zip;
    SELF.Diff_prov_b_addr := le.prov_b_addr <> ri.prov_b_addr;
    SELF.Diff_prov_b_city := le.prov_b_city <> ri.prov_b_city;
    SELF.Diff_prov_b_service_role_code := le.prov_b_service_role_code <> ri.prov_b_service_role_code;
    SELF.Diff_prov_b_state := le.prov_b_state <> ri.prov_b_state;
    SELF.Diff_prov_b_zip := le.prov_b_zip <> ri.prov_b_zip;
    SELF.Diff_prov_c_addr := le.prov_c_addr <> ri.prov_c_addr;
    SELF.Diff_prov_c_city := le.prov_c_city <> ri.prov_c_city;
    SELF.Diff_prov_c_service_role_code := le.prov_c_service_role_code <> ri.prov_c_service_role_code;
    SELF.Diff_prov_c_state := le.prov_c_state <> ri.prov_c_state;
    SELF.Diff_prov_c_zip := le.prov_c_zip <> ri.prov_c_zip;
    SELF.Diff_purch_service_first_name := le.purch_service_first_name <> ri.purch_service_first_name;
    SELF.Diff_purch_service_last_name := le.purch_service_last_name <> ri.purch_service_last_name;
    SELF.Diff_purch_service_middle_name := le.purch_service_middle_name <> ri.purch_service_middle_name;
    SELF.Diff_purch_service_npi := le.purch_service_npi <> ri.purch_service_npi;
    SELF.Diff_purch_service_prov_addr := le.purch_service_prov_addr <> ri.purch_service_prov_addr;
    SELF.Diff_purch_service_prov_city := le.purch_service_prov_city <> ri.purch_service_prov_city;
    SELF.Diff_purch_service_prov_name := le.purch_service_prov_name <> ri.purch_service_prov_name;
    SELF.Diff_purch_service_prov_phone := le.purch_service_prov_phone <> ri.purch_service_prov_phone;
    SELF.Diff_purch_service_prov_state := le.purch_service_prov_state <> ri.purch_service_prov_state;
    SELF.Diff_purch_service_prov_zip := le.purch_service_prov_zip <> ri.purch_service_prov_zip;
    SELF.Val := (SALT31.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_claim_type,1,0)+ IF( SELF.Diff_claim_num,1,0)+ IF( SELF.Diff_billing_pay_to_taxonomy,1,0)+ IF( SELF.Diff_billing_addr,1,0)+ IF( SELF.Diff_billing_anesth_lic,1,0)+ IF( SELF.Diff_billing_city,1,0)+ IF( SELF.Diff_billing_dentist_lic,1,0)+ IF( SELF.Diff_billing_first_name,1,0)+ IF( SELF.Diff_billing_last_name,1,0)+ IF( SELF.Diff_billing_middle_name,1,0)+ IF( SELF.Diff_billing_npi,1,0)+ IF( SELF.Diff_billing_org_name,1,0)+ IF( SELF.Diff_billing_service_phone,1,0)+ IF( SELF.Diff_billing_specialty_code,1,0)+ IF( SELF.Diff_billing_specialty_lic,1,0)+ IF( SELF.Diff_billing_state,1,0)+ IF( SELF.Diff_billing_state_lic,1,0)+ IF( SELF.Diff_billing_tax_id,1,0)+ IF( SELF.Diff_billing_upin,1,0)+ IF( SELF.Diff_billing_zip,1,0)+ IF( SELF.Diff_diag_code1,1,0)+ IF( SELF.Diff_diag_code2,1,0)+ IF( SELF.Diff_diag_code3,1,0)+ IF( SELF.Diff_diag_code4,1,0)+ IF( SELF.Diff_diag_code5,1,0)+ IF( SELF.Diff_diag_code6,1,0)+ IF( SELF.Diff_diag_code7,1,0)+ IF( SELF.Diff_diag_code8,1,0)+ IF( SELF.Diff_dme_hcpcs_proc_code,1,0)+ IF( SELF.Diff_emt_paramedic_first_name,1,0)+ IF( SELF.Diff_emt_paramedic_last_name,1,0)+ IF( SELF.Diff_emt_paramedic_middle_name,1,0)+ IF( SELF.Diff_ext_injury_diag_code,1,0)+ IF( SELF.Diff_facility_lab_addr,1,0)+ IF( SELF.Diff_facility_lab_city,1,0)+ IF( SELF.Diff_facility_lab_name,1,0)+ IF( SELF.Diff_facility_lab_npi,1,0)+ IF( SELF.Diff_facility_lab_state,1,0)+ IF( SELF.Diff_facility_lab_tax_id,1,0)+ IF( SELF.Diff_facility_lab_type_code,1,0)+ IF( SELF.Diff_facility_lab_zip,1,0)+ IF( SELF.Diff_ordering_prov_addr,1,0)+ IF( SELF.Diff_ordering_prov_city,1,0)+ IF( SELF.Diff_ordering_prov_first_name,1,0)+ IF( SELF.Diff_ordering_prov_last_name,1,0)+ IF( SELF.Diff_ordering_prov_middle_name,1,0)+ IF( SELF.Diff_ordering_prov_npi,1,0)+ IF( SELF.Diff_ordering_prov_state,1,0)+ IF( SELF.Diff_ordering_prov_upin,1,0)+ IF( SELF.Diff_ordering_prov_zip,1,0)+ IF( SELF.Diff_pay_to_addr,1,0)+ IF( SELF.Diff_pay_to_city,1,0)+ IF( SELF.Diff_pay_to_first_name,1,0)+ IF( SELF.Diff_pay_to_last_name,1,0)+ IF( SELF.Diff_pay_to_middle_name,1,0)+ IF( SELF.Diff_pay_to_npi,1,0)+ IF( SELF.Diff_pay_to_service_phone,1,0)+ IF( SELF.Diff_pay_to_state,1,0)+ IF( SELF.Diff_pay_to_tax_id,1,0)+ IF( SELF.Diff_pay_to_zip,1,0)+ IF( SELF.Diff_performing_prov_phone,1,0)+ IF( SELF.Diff_performing_prov_specialty,1,0)+ IF( SELF.Diff_performing_prov_tax_id,1,0)+ IF( SELF.Diff_place_of_service_code,1,0)+ IF( SELF.Diff_place_of_service_name,1,0)+ IF( SELF.Diff_prov_a_addr,1,0)+ IF( SELF.Diff_prov_a_city,1,0)+ IF( SELF.Diff_prov_a_service_role_code,1,0)+ IF( SELF.Diff_prov_a_state,1,0)+ IF( SELF.Diff_prov_a_zip,1,0)+ IF( SELF.Diff_prov_b_addr,1,0)+ IF( SELF.Diff_prov_b_city,1,0)+ IF( SELF.Diff_prov_b_service_role_code,1,0)+ IF( SELF.Diff_prov_b_state,1,0)+ IF( SELF.Diff_prov_b_zip,1,0)+ IF( SELF.Diff_prov_c_addr,1,0)+ IF( SELF.Diff_prov_c_city,1,0)+ IF( SELF.Diff_prov_c_service_role_code,1,0)+ IF( SELF.Diff_prov_c_state,1,0)+ IF( SELF.Diff_prov_c_zip,1,0)+ IF( SELF.Diff_purch_service_first_name,1,0)+ IF( SELF.Diff_purch_service_last_name,1,0)+ IF( SELF.Diff_purch_service_middle_name,1,0)+ IF( SELF.Diff_purch_service_npi,1,0)+ IF( SELF.Diff_purch_service_prov_addr,1,0)+ IF( SELF.Diff_purch_service_prov_city,1,0)+ IF( SELF.Diff_purch_service_prov_name,1,0)+ IF( SELF.Diff_purch_service_prov_phone,1,0)+ IF( SELF.Diff_purch_service_prov_state,1,0)+ IF( SELF.Diff_purch_service_prov_zip,1,0);
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
    Count_Diff_billing_pay_to_taxonomy := COUNT(GROUP,%Closest%.Diff_billing_pay_to_taxonomy);
    Count_Diff_billing_addr := COUNT(GROUP,%Closest%.Diff_billing_addr);
    Count_Diff_billing_anesth_lic := COUNT(GROUP,%Closest%.Diff_billing_anesth_lic);
    Count_Diff_billing_city := COUNT(GROUP,%Closest%.Diff_billing_city);
    Count_Diff_billing_dentist_lic := COUNT(GROUP,%Closest%.Diff_billing_dentist_lic);
    Count_Diff_billing_first_name := COUNT(GROUP,%Closest%.Diff_billing_first_name);
    Count_Diff_billing_last_name := COUNT(GROUP,%Closest%.Diff_billing_last_name);
    Count_Diff_billing_middle_name := COUNT(GROUP,%Closest%.Diff_billing_middle_name);
    Count_Diff_billing_npi := COUNT(GROUP,%Closest%.Diff_billing_npi);
    Count_Diff_billing_org_name := COUNT(GROUP,%Closest%.Diff_billing_org_name);
    Count_Diff_billing_service_phone := COUNT(GROUP,%Closest%.Diff_billing_service_phone);
    Count_Diff_billing_specialty_code := COUNT(GROUP,%Closest%.Diff_billing_specialty_code);
    Count_Diff_billing_specialty_lic := COUNT(GROUP,%Closest%.Diff_billing_specialty_lic);
    Count_Diff_billing_state := COUNT(GROUP,%Closest%.Diff_billing_state);
    Count_Diff_billing_state_lic := COUNT(GROUP,%Closest%.Diff_billing_state_lic);
    Count_Diff_billing_tax_id := COUNT(GROUP,%Closest%.Diff_billing_tax_id);
    Count_Diff_billing_upin := COUNT(GROUP,%Closest%.Diff_billing_upin);
    Count_Diff_billing_zip := COUNT(GROUP,%Closest%.Diff_billing_zip);
    Count_Diff_diag_code1 := COUNT(GROUP,%Closest%.Diff_diag_code1);
    Count_Diff_diag_code2 := COUNT(GROUP,%Closest%.Diff_diag_code2);
    Count_Diff_diag_code3 := COUNT(GROUP,%Closest%.Diff_diag_code3);
    Count_Diff_diag_code4 := COUNT(GROUP,%Closest%.Diff_diag_code4);
    Count_Diff_diag_code5 := COUNT(GROUP,%Closest%.Diff_diag_code5);
    Count_Diff_diag_code6 := COUNT(GROUP,%Closest%.Diff_diag_code6);
    Count_Diff_diag_code7 := COUNT(GROUP,%Closest%.Diff_diag_code7);
    Count_Diff_diag_code8 := COUNT(GROUP,%Closest%.Diff_diag_code8);
    Count_Diff_dme_hcpcs_proc_code := COUNT(GROUP,%Closest%.Diff_dme_hcpcs_proc_code);
    Count_Diff_emt_paramedic_first_name := COUNT(GROUP,%Closest%.Diff_emt_paramedic_first_name);
    Count_Diff_emt_paramedic_last_name := COUNT(GROUP,%Closest%.Diff_emt_paramedic_last_name);
    Count_Diff_emt_paramedic_middle_name := COUNT(GROUP,%Closest%.Diff_emt_paramedic_middle_name);
    Count_Diff_ext_injury_diag_code := COUNT(GROUP,%Closest%.Diff_ext_injury_diag_code);
    Count_Diff_facility_lab_addr := COUNT(GROUP,%Closest%.Diff_facility_lab_addr);
    Count_Diff_facility_lab_city := COUNT(GROUP,%Closest%.Diff_facility_lab_city);
    Count_Diff_facility_lab_name := COUNT(GROUP,%Closest%.Diff_facility_lab_name);
    Count_Diff_facility_lab_npi := COUNT(GROUP,%Closest%.Diff_facility_lab_npi);
    Count_Diff_facility_lab_state := COUNT(GROUP,%Closest%.Diff_facility_lab_state);
    Count_Diff_facility_lab_tax_id := COUNT(GROUP,%Closest%.Diff_facility_lab_tax_id);
    Count_Diff_facility_lab_type_code := COUNT(GROUP,%Closest%.Diff_facility_lab_type_code);
    Count_Diff_facility_lab_zip := COUNT(GROUP,%Closest%.Diff_facility_lab_zip);
    Count_Diff_ordering_prov_addr := COUNT(GROUP,%Closest%.Diff_ordering_prov_addr);
    Count_Diff_ordering_prov_city := COUNT(GROUP,%Closest%.Diff_ordering_prov_city);
    Count_Diff_ordering_prov_first_name := COUNT(GROUP,%Closest%.Diff_ordering_prov_first_name);
    Count_Diff_ordering_prov_last_name := COUNT(GROUP,%Closest%.Diff_ordering_prov_last_name);
    Count_Diff_ordering_prov_middle_name := COUNT(GROUP,%Closest%.Diff_ordering_prov_middle_name);
    Count_Diff_ordering_prov_npi := COUNT(GROUP,%Closest%.Diff_ordering_prov_npi);
    Count_Diff_ordering_prov_state := COUNT(GROUP,%Closest%.Diff_ordering_prov_state);
    Count_Diff_ordering_prov_upin := COUNT(GROUP,%Closest%.Diff_ordering_prov_upin);
    Count_Diff_ordering_prov_zip := COUNT(GROUP,%Closest%.Diff_ordering_prov_zip);
    Count_Diff_pay_to_addr := COUNT(GROUP,%Closest%.Diff_pay_to_addr);
    Count_Diff_pay_to_city := COUNT(GROUP,%Closest%.Diff_pay_to_city);
    Count_Diff_pay_to_first_name := COUNT(GROUP,%Closest%.Diff_pay_to_first_name);
    Count_Diff_pay_to_last_name := COUNT(GROUP,%Closest%.Diff_pay_to_last_name);
    Count_Diff_pay_to_middle_name := COUNT(GROUP,%Closest%.Diff_pay_to_middle_name);
    Count_Diff_pay_to_npi := COUNT(GROUP,%Closest%.Diff_pay_to_npi);
    Count_Diff_pay_to_service_phone := COUNT(GROUP,%Closest%.Diff_pay_to_service_phone);
    Count_Diff_pay_to_state := COUNT(GROUP,%Closest%.Diff_pay_to_state);
    Count_Diff_pay_to_tax_id := COUNT(GROUP,%Closest%.Diff_pay_to_tax_id);
    Count_Diff_pay_to_zip := COUNT(GROUP,%Closest%.Diff_pay_to_zip);
    Count_Diff_performing_prov_phone := COUNT(GROUP,%Closest%.Diff_performing_prov_phone);
    Count_Diff_performing_prov_specialty := COUNT(GROUP,%Closest%.Diff_performing_prov_specialty);
    Count_Diff_performing_prov_tax_id := COUNT(GROUP,%Closest%.Diff_performing_prov_tax_id);
    Count_Diff_place_of_service_code := COUNT(GROUP,%Closest%.Diff_place_of_service_code);
    Count_Diff_place_of_service_name := COUNT(GROUP,%Closest%.Diff_place_of_service_name);
    Count_Diff_prov_a_addr := COUNT(GROUP,%Closest%.Diff_prov_a_addr);
    Count_Diff_prov_a_city := COUNT(GROUP,%Closest%.Diff_prov_a_city);
    Count_Diff_prov_a_service_role_code := COUNT(GROUP,%Closest%.Diff_prov_a_service_role_code);
    Count_Diff_prov_a_state := COUNT(GROUP,%Closest%.Diff_prov_a_state);
    Count_Diff_prov_a_zip := COUNT(GROUP,%Closest%.Diff_prov_a_zip);
    Count_Diff_prov_b_addr := COUNT(GROUP,%Closest%.Diff_prov_b_addr);
    Count_Diff_prov_b_city := COUNT(GROUP,%Closest%.Diff_prov_b_city);
    Count_Diff_prov_b_service_role_code := COUNT(GROUP,%Closest%.Diff_prov_b_service_role_code);
    Count_Diff_prov_b_state := COUNT(GROUP,%Closest%.Diff_prov_b_state);
    Count_Diff_prov_b_zip := COUNT(GROUP,%Closest%.Diff_prov_b_zip);
    Count_Diff_prov_c_addr := COUNT(GROUP,%Closest%.Diff_prov_c_addr);
    Count_Diff_prov_c_city := COUNT(GROUP,%Closest%.Diff_prov_c_city);
    Count_Diff_prov_c_service_role_code := COUNT(GROUP,%Closest%.Diff_prov_c_service_role_code);
    Count_Diff_prov_c_state := COUNT(GROUP,%Closest%.Diff_prov_c_state);
    Count_Diff_prov_c_zip := COUNT(GROUP,%Closest%.Diff_prov_c_zip);
    Count_Diff_purch_service_first_name := COUNT(GROUP,%Closest%.Diff_purch_service_first_name);
    Count_Diff_purch_service_last_name := COUNT(GROUP,%Closest%.Diff_purch_service_last_name);
    Count_Diff_purch_service_middle_name := COUNT(GROUP,%Closest%.Diff_purch_service_middle_name);
    Count_Diff_purch_service_npi := COUNT(GROUP,%Closest%.Diff_purch_service_npi);
    Count_Diff_purch_service_prov_addr := COUNT(GROUP,%Closest%.Diff_purch_service_prov_addr);
    Count_Diff_purch_service_prov_city := COUNT(GROUP,%Closest%.Diff_purch_service_prov_city);
    Count_Diff_purch_service_prov_name := COUNT(GROUP,%Closest%.Diff_purch_service_prov_name);
    Count_Diff_purch_service_prov_phone := COUNT(GROUP,%Closest%.Diff_purch_service_prov_phone);
    Count_Diff_purch_service_prov_state := COUNT(GROUP,%Closest%.Diff_purch_service_prov_state);
    Count_Diff_purch_service_prov_zip := COUNT(GROUP,%Closest%.Diff_purch_service_prov_zip);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
