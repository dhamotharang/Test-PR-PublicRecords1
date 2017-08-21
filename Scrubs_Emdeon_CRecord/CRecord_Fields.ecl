IMPORT ut,SALT31;
EXPORT CRecord_Fields := MODULE
// Processing for each FieldType
EXPORT SALT31.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'claim_num','claim_rec_type','payer_id','form_type','received_date','claim_type','adjustment_code','prev_claim_number','member_dob','member_state','member_zip','patient_relation','patient_gender','patient_dob','billing_id','billing_npi','billing_state','billing_zip','referring_id','referring_npi','referring_name1','referring_name2','attending_id','attending_npi','facility_state','facility_zip','statement_to','total_charge','drg_code','bill_type','release_sign','assignment_sign','principal_proc','admit_diag','primary_diag','diag_code2','diag_code3','diag_code4','diag_code5','diag_code6','diag_code7','diag_code8','other_proc','other_proc3','other_proc4','other_proc5','other_proc6','coverage_type','accident_related','esrd_patient','hosp_admit_or_er','amb_nurse_to_hosp','non_covered_specialty','electronic_claim','dialysis_related','new_patient','init_proc','amb_nurse_to_diag');
EXPORT FieldTypeNum(SALT31.StrType fn) := CASE(fn,'claim_num' => 1,'claim_rec_type' => 2,'payer_id' => 3,'form_type' => 4,'received_date' => 5,'claim_type' => 6,'adjustment_code' => 7,'prev_claim_number' => 8,'member_dob' => 9,'member_state' => 10,'member_zip' => 11,'patient_relation' => 12,'patient_gender' => 13,'patient_dob' => 14,'billing_id' => 15,'billing_npi' => 16,'billing_state' => 17,'billing_zip' => 18,'referring_id' => 19,'referring_npi' => 20,'referring_name1' => 21,'referring_name2' => 22,'attending_id' => 23,'attending_npi' => 24,'facility_state' => 25,'facility_zip' => 26,'statement_to' => 27,'total_charge' => 28,'drg_code' => 29,'bill_type' => 30,'release_sign' => 31,'assignment_sign' => 32,'principal_proc' => 33,'admit_diag' => 34,'primary_diag' => 35,'diag_code2' => 36,'diag_code3' => 37,'diag_code4' => 38,'diag_code5' => 39,'diag_code6' => 40,'diag_code7' => 41,'diag_code8' => 42,'other_proc' => 43,'other_proc3' => 44,'other_proc4' => 45,'other_proc5' => 46,'other_proc6' => 47,'coverage_type' => 48,'accident_related' => 49,'esrd_patient' => 50,'hosp_admit_or_er' => 51,'amb_nurse_to_hosp' => 52,'non_covered_specialty' => 53,'electronic_claim' => 54,'dialysis_related' => 55,'new_patient' => 56,'init_proc' => 57,'amb_nurse_to_diag' => 58,0);
EXPORT MakeFT_claim_num(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789EIP '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_claim_num(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789EIP '))),~(LENGTH(TRIM(s)) = 17),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_claim_num(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789EIP '),SALT31.HygieneErrors.NotLength('17'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_claim_rec_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'C '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_claim_rec_type(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'C '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_claim_rec_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('C '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_payer_id(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPRSTVWXY '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_payer_id(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPRSTVWXY '))),~(LENGTH(TRIM(s)) = 5),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_payer_id(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPRSTVWXY '),SALT31.HygieneErrors.NotLength('5'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_form_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'9 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_form_type(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'9 '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_form_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('9 '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_received_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_received_date(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 8),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_received_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('8'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_claim_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'IP '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_claim_type(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'IP '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_claim_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('IP '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_adjustment_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_adjustment_code(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_adjustment_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_prev_claim_number(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ()-/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prev_claim_number(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ()-/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_prev_claim_number(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ()-/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_member_dob(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_member_dob(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_member_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('4,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_member_state(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ACDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_member_state(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ACDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_member_state(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ACDEFGHIJKLMNOPRSTUVWXYZ '),SALT31.HygieneErrors.NotLength('2,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_member_zip(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_member_zip(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_member_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('3,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_patient_relation(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789G '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_patient_relation(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789G '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_patient_relation(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789G '),SALT31.HygieneErrors.NotLength('0,2'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_patient_gender(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'FM '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_patient_gender(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'FM '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_patient_gender(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('FM '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_patient_dob(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_patient_dob(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_patient_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_billing_id(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_billing_id(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_billing_id(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('9,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_billing_npi(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_billing_npi(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_billing_npi(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('10,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_billing_state(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ACDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_billing_state(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ACDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 2),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_billing_state(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ACDEFGHIJKLMNOPRSTUVWXYZ '),SALT31.HygieneErrors.NotLength('2'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_billing_zip(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_billing_zip(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 5),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_billing_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('9,5'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_referring_id(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0124 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_referring_id(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0124 '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_referring_id(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0124 '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_referring_npi(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_referring_npi(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_referring_npi(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('10,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_referring_name1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' &apos;(),-./469ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_referring_name1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' &apos;(),-./469ABCDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_referring_name1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' &apos;(),-./469ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT31.HygieneErrors.NotLength('0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_referring_name2(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ,.ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_referring_name2(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ,.ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_referring_name2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ,.ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_attending_id(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_attending_id(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_attending_id(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_attending_npi(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_attending_npi(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_attending_npi(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('10,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_facility_state(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ACDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_facility_state(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ACDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_facility_state(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ACDEFGHIJKLMNOPRSTUVWXYZ '),SALT31.HygieneErrors.NotLength('2,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_facility_zip(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_facility_zip(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_facility_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('9,0,5'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_statement_to(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_statement_to(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_statement_to(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_total_charge(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_total_charge(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_total_charge(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_drg_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_drg_code(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_drg_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_bill_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_bill_type(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 2),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_bill_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('3,2'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_release_sign(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'IY '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_release_sign(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'IY '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_release_sign(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('IY '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_assignment_sign(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'NY '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_assignment_sign(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'NY '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_assignment_sign(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('NY '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_principal_proc(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_principal_proc(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_principal_proc(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_admit_diag(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789EV '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_admit_diag(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789EV '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_admit_diag(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789EV '),SALT31.HygieneErrors.NotLength('0,5,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_primary_diag(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789EV '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_primary_diag(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789EV '))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_primary_diag(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789EV '),SALT31.HygieneErrors.NotLength('5,4,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
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
EXPORT InValidFT_diag_code5(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789EV '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code5(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789EV '),SALT31.HygieneErrors.NotLength('0,5,4,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_diag_code6(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789EV '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code6(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789EV '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code6(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789EV '),SALT31.HygieneErrors.NotLength('0,5,4,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_diag_code7(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789EV '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code7(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789EV '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code7(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789EV '),SALT31.HygieneErrors.NotLength('0,5,4,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_diag_code8(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789EV '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code8(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789EV '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 3),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code8(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789EV '),SALT31.HygieneErrors.NotLength('0,5,4,3'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_other_proc(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_proc(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_proc(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_other_proc3(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_proc3(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_proc3(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_other_proc4(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_proc4(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_proc4(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_other_proc5(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_proc5(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_proc5(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_other_proc6(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_proc6(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_proc6(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_coverage_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'1BCDFGHMOPVWZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_coverage_type(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'1BCDFGHMOPVWZ '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_coverage_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('1BCDFGHMOPVWZ '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_accident_related(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'NY '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_accident_related(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'NY '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_accident_related(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('NY '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_esrd_patient(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'NY '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_esrd_patient(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'NY '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_esrd_patient(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('NY '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_hosp_admit_or_er(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'NY '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_hosp_admit_or_er(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'NY '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_hosp_admit_or_er(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('NY '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_amb_nurse_to_hosp(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'NY '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_amb_nurse_to_hosp(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'NY '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_amb_nurse_to_hosp(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('NY '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_non_covered_specialty(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'NY '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_non_covered_specialty(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'NY '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_non_covered_specialty(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('NY '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_electronic_claim(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'NY '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_electronic_claim(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'NY '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_electronic_claim(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('NY '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dialysis_related(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'NY '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dialysis_related(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'NY '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dialysis_related(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('NY '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_new_patient(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'NY '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_new_patient(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'NY '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_new_patient(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('NY '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_init_proc(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'NY '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_init_proc(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'NY '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_init_proc(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('NY '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_amb_nurse_to_diag(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'NY '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_amb_nurse_to_diag(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'NY '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_amb_nurse_to_diag(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('NY '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT SALT31.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'claim_num','claim_rec_type','payer_id','form_type','received_date','claim_type','adjustment_code','prev_claim_number','sub_client_id','group_name','member_id','member_fname','member_lname','member_gender','member_dob','member_address1','member_address2','member_city','member_state','member_zip','patient_id','patient_relation','patient_fname','patient_lname','patient_gender','patient_dob','patient_age','billing_id','billing_npi','billing_name1','billing_name2','billing_address1','billing_address2','billing_city','billing_state','billing_zip','referring_id','referring_npi','referring_name1','referring_name2','attending_id','attending_npi','attending_name1','attending_name2','facility_id','facility_name1','facility_name2','facility_address1','facility_address2','facility_city','facility_state','facility_zip','statement_from','statement_to','total_charge','total_allowed','drg_code','patient_control','bill_type','release_sign','assignment_sign','in_out_network','principal_proc','admit_diag','primary_diag','diag_code2','diag_code3','diag_code4','diag_code5','diag_code6','diag_code7','diag_code8','other_proc','other_proc3','other_proc4','other_proc5','other_proc6','prov_specialty','coverage_type','explanation_code','accident_related','esrd_patient','hosp_admit_or_er','amb_nurse_to_hosp','non_covered_specialty','electronic_claim','dialysis_related','new_patient','init_proc','amb_nurse_to_diag');
EXPORT FieldNum(SALT31.StrType fn) := CASE(fn,'claim_num' => 1,'claim_rec_type' => 2,'payer_id' => 3,'form_type' => 4,'received_date' => 5,'claim_type' => 6,'adjustment_code' => 7,'prev_claim_number' => 8,'sub_client_id' => 9,'group_name' => 10,'member_id' => 11,'member_fname' => 12,'member_lname' => 13,'member_gender' => 14,'member_dob' => 15,'member_address1' => 16,'member_address2' => 17,'member_city' => 18,'member_state' => 19,'member_zip' => 20,'patient_id' => 21,'patient_relation' => 22,'patient_fname' => 23,'patient_lname' => 24,'patient_gender' => 25,'patient_dob' => 26,'patient_age' => 27,'billing_id' => 28,'billing_npi' => 29,'billing_name1' => 30,'billing_name2' => 31,'billing_address1' => 32,'billing_address2' => 33,'billing_city' => 34,'billing_state' => 35,'billing_zip' => 36,'referring_id' => 37,'referring_npi' => 38,'referring_name1' => 39,'referring_name2' => 40,'attending_id' => 41,'attending_npi' => 42,'attending_name1' => 43,'attending_name2' => 44,'facility_id' => 45,'facility_name1' => 46,'facility_name2' => 47,'facility_address1' => 48,'facility_address2' => 49,'facility_city' => 50,'facility_state' => 51,'facility_zip' => 52,'statement_from' => 53,'statement_to' => 54,'total_charge' => 55,'total_allowed' => 56,'drg_code' => 57,'patient_control' => 58,'bill_type' => 59,'release_sign' => 60,'assignment_sign' => 61,'in_out_network' => 62,'principal_proc' => 63,'admit_diag' => 64,'primary_diag' => 65,'diag_code2' => 66,'diag_code3' => 67,'diag_code4' => 68,'diag_code5' => 69,'diag_code6' => 70,'diag_code7' => 71,'diag_code8' => 72,'other_proc' => 73,'other_proc3' => 74,'other_proc4' => 75,'other_proc5' => 76,'other_proc6' => 77,'prov_specialty' => 78,'coverage_type' => 79,'explanation_code' => 80,'accident_related' => 81,'esrd_patient' => 82,'hosp_admit_or_er' => 83,'amb_nurse_to_hosp' => 84,'non_covered_specialty' => 85,'electronic_claim' => 86,'dialysis_related' => 87,'new_patient' => 88,'init_proc' => 89,'amb_nurse_to_diag' => 90,0);
//Individual field level validation
EXPORT Make_claim_num(SALT31.StrType s0) := MakeFT_claim_num(s0);
EXPORT InValid_claim_num(SALT31.StrType s) := InValidFT_claim_num(s);
EXPORT InValidMessage_claim_num(UNSIGNED1 wh) := InValidMessageFT_claim_num(wh);
EXPORT Make_claim_rec_type(SALT31.StrType s0) := MakeFT_claim_rec_type(s0);
EXPORT InValid_claim_rec_type(SALT31.StrType s) := InValidFT_claim_rec_type(s);
EXPORT InValidMessage_claim_rec_type(UNSIGNED1 wh) := InValidMessageFT_claim_rec_type(wh);
EXPORT Make_payer_id(SALT31.StrType s0) := MakeFT_payer_id(s0);
EXPORT InValid_payer_id(SALT31.StrType s) := InValidFT_payer_id(s);
EXPORT InValidMessage_payer_id(UNSIGNED1 wh) := InValidMessageFT_payer_id(wh);
EXPORT Make_form_type(SALT31.StrType s0) := MakeFT_form_type(s0);
EXPORT InValid_form_type(SALT31.StrType s) := InValidFT_form_type(s);
EXPORT InValidMessage_form_type(UNSIGNED1 wh) := InValidMessageFT_form_type(wh);
EXPORT Make_received_date(SALT31.StrType s0) := MakeFT_received_date(s0);
EXPORT InValid_received_date(SALT31.StrType s) := InValidFT_received_date(s);
EXPORT InValidMessage_received_date(UNSIGNED1 wh) := InValidMessageFT_received_date(wh);
EXPORT Make_claim_type(SALT31.StrType s0) := MakeFT_claim_type(s0);
EXPORT InValid_claim_type(SALT31.StrType s) := InValidFT_claim_type(s);
EXPORT InValidMessage_claim_type(UNSIGNED1 wh) := InValidMessageFT_claim_type(wh);
EXPORT Make_adjustment_code(SALT31.StrType s0) := MakeFT_adjustment_code(s0);
EXPORT InValid_adjustment_code(SALT31.StrType s) := InValidFT_adjustment_code(s);
EXPORT InValidMessage_adjustment_code(UNSIGNED1 wh) := InValidMessageFT_adjustment_code(wh);
EXPORT Make_prev_claim_number(SALT31.StrType s0) := MakeFT_prev_claim_number(s0);
EXPORT InValid_prev_claim_number(SALT31.StrType s) := InValidFT_prev_claim_number(s);
EXPORT InValidMessage_prev_claim_number(UNSIGNED1 wh) := InValidMessageFT_prev_claim_number(wh);
EXPORT Make_sub_client_id(SALT31.StrType s0) := s0;
EXPORT InValid_sub_client_id(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_sub_client_id(UNSIGNED1 wh) := '';
EXPORT Make_group_name(SALT31.StrType s0) := s0;
EXPORT InValid_group_name(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_group_name(UNSIGNED1 wh) := '';
EXPORT Make_member_id(SALT31.StrType s0) := s0;
EXPORT InValid_member_id(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_member_id(UNSIGNED1 wh) := '';
EXPORT Make_member_fname(SALT31.StrType s0) := s0;
EXPORT InValid_member_fname(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_member_fname(UNSIGNED1 wh) := '';
EXPORT Make_member_lname(SALT31.StrType s0) := s0;
EXPORT InValid_member_lname(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_member_lname(UNSIGNED1 wh) := '';
EXPORT Make_member_gender(SALT31.StrType s0) := s0;
EXPORT InValid_member_gender(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_member_gender(UNSIGNED1 wh) := '';
EXPORT Make_member_dob(SALT31.StrType s0) := MakeFT_member_dob(s0);
EXPORT InValid_member_dob(SALT31.StrType s) := InValidFT_member_dob(s);
EXPORT InValidMessage_member_dob(UNSIGNED1 wh) := InValidMessageFT_member_dob(wh);
EXPORT Make_member_address1(SALT31.StrType s0) := s0;
EXPORT InValid_member_address1(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_member_address1(UNSIGNED1 wh) := '';
EXPORT Make_member_address2(SALT31.StrType s0) := s0;
EXPORT InValid_member_address2(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_member_address2(UNSIGNED1 wh) := '';
EXPORT Make_member_city(SALT31.StrType s0) := s0;
EXPORT InValid_member_city(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_member_city(UNSIGNED1 wh) := '';
EXPORT Make_member_state(SALT31.StrType s0) := MakeFT_member_state(s0);
EXPORT InValid_member_state(SALT31.StrType s) := InValidFT_member_state(s);
EXPORT InValidMessage_member_state(UNSIGNED1 wh) := InValidMessageFT_member_state(wh);
EXPORT Make_member_zip(SALT31.StrType s0) := MakeFT_member_zip(s0);
EXPORT InValid_member_zip(SALT31.StrType s) := InValidFT_member_zip(s);
EXPORT InValidMessage_member_zip(UNSIGNED1 wh) := InValidMessageFT_member_zip(wh);
EXPORT Make_patient_id(SALT31.StrType s0) := s0;
EXPORT InValid_patient_id(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_patient_id(UNSIGNED1 wh) := '';
EXPORT Make_patient_relation(SALT31.StrType s0) := MakeFT_patient_relation(s0);
EXPORT InValid_patient_relation(SALT31.StrType s) := InValidFT_patient_relation(s);
EXPORT InValidMessage_patient_relation(UNSIGNED1 wh) := InValidMessageFT_patient_relation(wh);
EXPORT Make_patient_fname(SALT31.StrType s0) := s0;
EXPORT InValid_patient_fname(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_patient_fname(UNSIGNED1 wh) := '';
EXPORT Make_patient_lname(SALT31.StrType s0) := s0;
EXPORT InValid_patient_lname(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_patient_lname(UNSIGNED1 wh) := '';
EXPORT Make_patient_gender(SALT31.StrType s0) := MakeFT_patient_gender(s0);
EXPORT InValid_patient_gender(SALT31.StrType s) := InValidFT_patient_gender(s);
EXPORT InValidMessage_patient_gender(UNSIGNED1 wh) := InValidMessageFT_patient_gender(wh);
EXPORT Make_patient_dob(SALT31.StrType s0) := MakeFT_patient_dob(s0);
EXPORT InValid_patient_dob(SALT31.StrType s) := InValidFT_patient_dob(s);
EXPORT InValidMessage_patient_dob(UNSIGNED1 wh) := InValidMessageFT_patient_dob(wh);
EXPORT Make_patient_age(SALT31.StrType s0) := s0;
EXPORT InValid_patient_age(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_patient_age(UNSIGNED1 wh) := '';
EXPORT Make_billing_id(SALT31.StrType s0) := MakeFT_billing_id(s0);
EXPORT InValid_billing_id(SALT31.StrType s) := InValidFT_billing_id(s);
EXPORT InValidMessage_billing_id(UNSIGNED1 wh) := InValidMessageFT_billing_id(wh);
EXPORT Make_billing_npi(SALT31.StrType s0) := MakeFT_billing_npi(s0);
EXPORT InValid_billing_npi(SALT31.StrType s) := InValidFT_billing_npi(s);
EXPORT InValidMessage_billing_npi(UNSIGNED1 wh) := InValidMessageFT_billing_npi(wh);
EXPORT Make_billing_name1(SALT31.StrType s0) := s0;
EXPORT InValid_billing_name1(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_billing_name1(UNSIGNED1 wh) := '';
EXPORT Make_billing_name2(SALT31.StrType s0) := s0;
EXPORT InValid_billing_name2(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_billing_name2(UNSIGNED1 wh) := '';
EXPORT Make_billing_address1(SALT31.StrType s0) := s0;
EXPORT InValid_billing_address1(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_billing_address1(UNSIGNED1 wh) := '';
EXPORT Make_billing_address2(SALT31.StrType s0) := s0;
EXPORT InValid_billing_address2(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_billing_address2(UNSIGNED1 wh) := '';
EXPORT Make_billing_city(SALT31.StrType s0) := s0;
EXPORT InValid_billing_city(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_billing_city(UNSIGNED1 wh) := '';
EXPORT Make_billing_state(SALT31.StrType s0) := MakeFT_billing_state(s0);
EXPORT InValid_billing_state(SALT31.StrType s) := InValidFT_billing_state(s);
EXPORT InValidMessage_billing_state(UNSIGNED1 wh) := InValidMessageFT_billing_state(wh);
EXPORT Make_billing_zip(SALT31.StrType s0) := MakeFT_billing_zip(s0);
EXPORT InValid_billing_zip(SALT31.StrType s) := InValidFT_billing_zip(s);
EXPORT InValidMessage_billing_zip(UNSIGNED1 wh) := InValidMessageFT_billing_zip(wh);
EXPORT Make_referring_id(SALT31.StrType s0) := MakeFT_referring_id(s0);
EXPORT InValid_referring_id(SALT31.StrType s) := InValidFT_referring_id(s);
EXPORT InValidMessage_referring_id(UNSIGNED1 wh) := InValidMessageFT_referring_id(wh);
EXPORT Make_referring_npi(SALT31.StrType s0) := MakeFT_referring_npi(s0);
EXPORT InValid_referring_npi(SALT31.StrType s) := InValidFT_referring_npi(s);
EXPORT InValidMessage_referring_npi(UNSIGNED1 wh) := InValidMessageFT_referring_npi(wh);
EXPORT Make_referring_name1(SALT31.StrType s0) := MakeFT_referring_name1(s0);
EXPORT InValid_referring_name1(SALT31.StrType s) := InValidFT_referring_name1(s);
EXPORT InValidMessage_referring_name1(UNSIGNED1 wh) := InValidMessageFT_referring_name1(wh);
EXPORT Make_referring_name2(SALT31.StrType s0) := MakeFT_referring_name2(s0);
EXPORT InValid_referring_name2(SALT31.StrType s) := InValidFT_referring_name2(s);
EXPORT InValidMessage_referring_name2(UNSIGNED1 wh) := InValidMessageFT_referring_name2(wh);
EXPORT Make_attending_id(SALT31.StrType s0) := MakeFT_attending_id(s0);
EXPORT InValid_attending_id(SALT31.StrType s) := InValidFT_attending_id(s);
EXPORT InValidMessage_attending_id(UNSIGNED1 wh) := InValidMessageFT_attending_id(wh);
EXPORT Make_attending_npi(SALT31.StrType s0) := MakeFT_attending_npi(s0);
EXPORT InValid_attending_npi(SALT31.StrType s) := InValidFT_attending_npi(s);
EXPORT InValidMessage_attending_npi(UNSIGNED1 wh) := InValidMessageFT_attending_npi(wh);
EXPORT Make_attending_name1(SALT31.StrType s0) := s0;
EXPORT InValid_attending_name1(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_attending_name1(UNSIGNED1 wh) := '';
EXPORT Make_attending_name2(SALT31.StrType s0) := s0;
EXPORT InValid_attending_name2(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_attending_name2(UNSIGNED1 wh) := '';
EXPORT Make_facility_id(SALT31.StrType s0) := s0;
EXPORT InValid_facility_id(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_facility_id(UNSIGNED1 wh) := '';
EXPORT Make_facility_name1(SALT31.StrType s0) := s0;
EXPORT InValid_facility_name1(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_facility_name1(UNSIGNED1 wh) := '';
EXPORT Make_facility_name2(SALT31.StrType s0) := s0;
EXPORT InValid_facility_name2(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_facility_name2(UNSIGNED1 wh) := '';
EXPORT Make_facility_address1(SALT31.StrType s0) := s0;
EXPORT InValid_facility_address1(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_facility_address1(UNSIGNED1 wh) := '';
EXPORT Make_facility_address2(SALT31.StrType s0) := s0;
EXPORT InValid_facility_address2(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_facility_address2(UNSIGNED1 wh) := '';
EXPORT Make_facility_city(SALT31.StrType s0) := s0;
EXPORT InValid_facility_city(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_facility_city(UNSIGNED1 wh) := '';
EXPORT Make_facility_state(SALT31.StrType s0) := MakeFT_facility_state(s0);
EXPORT InValid_facility_state(SALT31.StrType s) := InValidFT_facility_state(s);
EXPORT InValidMessage_facility_state(UNSIGNED1 wh) := InValidMessageFT_facility_state(wh);
EXPORT Make_facility_zip(SALT31.StrType s0) := MakeFT_facility_zip(s0);
EXPORT InValid_facility_zip(SALT31.StrType s) := InValidFT_facility_zip(s);
EXPORT InValidMessage_facility_zip(UNSIGNED1 wh) := InValidMessageFT_facility_zip(wh);
EXPORT Make_statement_from(SALT31.StrType s0) := s0;
EXPORT InValid_statement_from(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_statement_from(UNSIGNED1 wh) := '';
EXPORT Make_statement_to(SALT31.StrType s0) := MakeFT_statement_to(s0);
EXPORT InValid_statement_to(SALT31.StrType s) := InValidFT_statement_to(s);
EXPORT InValidMessage_statement_to(UNSIGNED1 wh) := InValidMessageFT_statement_to(wh);
EXPORT Make_total_charge(SALT31.StrType s0) := MakeFT_total_charge(s0);
EXPORT InValid_total_charge(SALT31.StrType s) := InValidFT_total_charge(s);
EXPORT InValidMessage_total_charge(UNSIGNED1 wh) := InValidMessageFT_total_charge(wh);
EXPORT Make_total_allowed(SALT31.StrType s0) := s0;
EXPORT InValid_total_allowed(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_total_allowed(UNSIGNED1 wh) := '';
EXPORT Make_drg_code(SALT31.StrType s0) := MakeFT_drg_code(s0);
EXPORT InValid_drg_code(SALT31.StrType s) := InValidFT_drg_code(s);
EXPORT InValidMessage_drg_code(UNSIGNED1 wh) := InValidMessageFT_drg_code(wh);
EXPORT Make_patient_control(SALT31.StrType s0) := s0;
EXPORT InValid_patient_control(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_patient_control(UNSIGNED1 wh) := '';
EXPORT Make_bill_type(SALT31.StrType s0) := MakeFT_bill_type(s0);
EXPORT InValid_bill_type(SALT31.StrType s) := InValidFT_bill_type(s);
EXPORT InValidMessage_bill_type(UNSIGNED1 wh) := InValidMessageFT_bill_type(wh);
EXPORT Make_release_sign(SALT31.StrType s0) := MakeFT_release_sign(s0);
EXPORT InValid_release_sign(SALT31.StrType s) := InValidFT_release_sign(s);
EXPORT InValidMessage_release_sign(UNSIGNED1 wh) := InValidMessageFT_release_sign(wh);
EXPORT Make_assignment_sign(SALT31.StrType s0) := MakeFT_assignment_sign(s0);
EXPORT InValid_assignment_sign(SALT31.StrType s) := InValidFT_assignment_sign(s);
EXPORT InValidMessage_assignment_sign(UNSIGNED1 wh) := InValidMessageFT_assignment_sign(wh);
EXPORT Make_in_out_network(SALT31.StrType s0) := s0;
EXPORT InValid_in_out_network(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_in_out_network(UNSIGNED1 wh) := '';
EXPORT Make_principal_proc(SALT31.StrType s0) := MakeFT_principal_proc(s0);
EXPORT InValid_principal_proc(SALT31.StrType s) := InValidFT_principal_proc(s);
EXPORT InValidMessage_principal_proc(UNSIGNED1 wh) := InValidMessageFT_principal_proc(wh);
EXPORT Make_admit_diag(SALT31.StrType s0) := MakeFT_admit_diag(s0);
EXPORT InValid_admit_diag(SALT31.StrType s) := InValidFT_admit_diag(s);
EXPORT InValidMessage_admit_diag(UNSIGNED1 wh) := InValidMessageFT_admit_diag(wh);
EXPORT Make_primary_diag(SALT31.StrType s0) := MakeFT_primary_diag(s0);
EXPORT InValid_primary_diag(SALT31.StrType s) := InValidFT_primary_diag(s);
EXPORT InValidMessage_primary_diag(UNSIGNED1 wh) := InValidMessageFT_primary_diag(wh);
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
EXPORT Make_other_proc(SALT31.StrType s0) := MakeFT_other_proc(s0);
EXPORT InValid_other_proc(SALT31.StrType s) := InValidFT_other_proc(s);
EXPORT InValidMessage_other_proc(UNSIGNED1 wh) := InValidMessageFT_other_proc(wh);
EXPORT Make_other_proc3(SALT31.StrType s0) := MakeFT_other_proc3(s0);
EXPORT InValid_other_proc3(SALT31.StrType s) := InValidFT_other_proc3(s);
EXPORT InValidMessage_other_proc3(UNSIGNED1 wh) := InValidMessageFT_other_proc3(wh);
EXPORT Make_other_proc4(SALT31.StrType s0) := MakeFT_other_proc4(s0);
EXPORT InValid_other_proc4(SALT31.StrType s) := InValidFT_other_proc4(s);
EXPORT InValidMessage_other_proc4(UNSIGNED1 wh) := InValidMessageFT_other_proc4(wh);
EXPORT Make_other_proc5(SALT31.StrType s0) := MakeFT_other_proc5(s0);
EXPORT InValid_other_proc5(SALT31.StrType s) := InValidFT_other_proc5(s);
EXPORT InValidMessage_other_proc5(UNSIGNED1 wh) := InValidMessageFT_other_proc5(wh);
EXPORT Make_other_proc6(SALT31.StrType s0) := MakeFT_other_proc6(s0);
EXPORT InValid_other_proc6(SALT31.StrType s) := InValidFT_other_proc6(s);
EXPORT InValidMessage_other_proc6(UNSIGNED1 wh) := InValidMessageFT_other_proc6(wh);
EXPORT Make_prov_specialty(SALT31.StrType s0) := s0;
EXPORT InValid_prov_specialty(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_prov_specialty(UNSIGNED1 wh) := '';
EXPORT Make_coverage_type(SALT31.StrType s0) := MakeFT_coverage_type(s0);
EXPORT InValid_coverage_type(SALT31.StrType s) := InValidFT_coverage_type(s);
EXPORT InValidMessage_coverage_type(UNSIGNED1 wh) := InValidMessageFT_coverage_type(wh);
EXPORT Make_explanation_code(SALT31.StrType s0) := s0;
EXPORT InValid_explanation_code(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_explanation_code(UNSIGNED1 wh) := '';
EXPORT Make_accident_related(SALT31.StrType s0) := MakeFT_accident_related(s0);
EXPORT InValid_accident_related(SALT31.StrType s) := InValidFT_accident_related(s);
EXPORT InValidMessage_accident_related(UNSIGNED1 wh) := InValidMessageFT_accident_related(wh);
EXPORT Make_esrd_patient(SALT31.StrType s0) := MakeFT_esrd_patient(s0);
EXPORT InValid_esrd_patient(SALT31.StrType s) := InValidFT_esrd_patient(s);
EXPORT InValidMessage_esrd_patient(UNSIGNED1 wh) := InValidMessageFT_esrd_patient(wh);
EXPORT Make_hosp_admit_or_er(SALT31.StrType s0) := MakeFT_hosp_admit_or_er(s0);
EXPORT InValid_hosp_admit_or_er(SALT31.StrType s) := InValidFT_hosp_admit_or_er(s);
EXPORT InValidMessage_hosp_admit_or_er(UNSIGNED1 wh) := InValidMessageFT_hosp_admit_or_er(wh);
EXPORT Make_amb_nurse_to_hosp(SALT31.StrType s0) := MakeFT_amb_nurse_to_hosp(s0);
EXPORT InValid_amb_nurse_to_hosp(SALT31.StrType s) := InValidFT_amb_nurse_to_hosp(s);
EXPORT InValidMessage_amb_nurse_to_hosp(UNSIGNED1 wh) := InValidMessageFT_amb_nurse_to_hosp(wh);
EXPORT Make_non_covered_specialty(SALT31.StrType s0) := MakeFT_non_covered_specialty(s0);
EXPORT InValid_non_covered_specialty(SALT31.StrType s) := InValidFT_non_covered_specialty(s);
EXPORT InValidMessage_non_covered_specialty(UNSIGNED1 wh) := InValidMessageFT_non_covered_specialty(wh);
EXPORT Make_electronic_claim(SALT31.StrType s0) := MakeFT_electronic_claim(s0);
EXPORT InValid_electronic_claim(SALT31.StrType s) := InValidFT_electronic_claim(s);
EXPORT InValidMessage_electronic_claim(UNSIGNED1 wh) := InValidMessageFT_electronic_claim(wh);
EXPORT Make_dialysis_related(SALT31.StrType s0) := MakeFT_dialysis_related(s0);
EXPORT InValid_dialysis_related(SALT31.StrType s) := InValidFT_dialysis_related(s);
EXPORT InValidMessage_dialysis_related(UNSIGNED1 wh) := InValidMessageFT_dialysis_related(wh);
EXPORT Make_new_patient(SALT31.StrType s0) := MakeFT_new_patient(s0);
EXPORT InValid_new_patient(SALT31.StrType s) := InValidFT_new_patient(s);
EXPORT InValidMessage_new_patient(UNSIGNED1 wh) := InValidMessageFT_new_patient(wh);
EXPORT Make_init_proc(SALT31.StrType s0) := MakeFT_init_proc(s0);
EXPORT InValid_init_proc(SALT31.StrType s) := InValidFT_init_proc(s);
EXPORT InValidMessage_init_proc(UNSIGNED1 wh) := InValidMessageFT_init_proc(wh);
EXPORT Make_amb_nurse_to_diag(SALT31.StrType s0) := MakeFT_amb_nurse_to_diag(s0);
EXPORT InValid_amb_nurse_to_diag(SALT31.StrType s) := InValidFT_amb_nurse_to_diag(s);
EXPORT InValidMessage_amb_nurse_to_diag(UNSIGNED1 wh) := InValidMessageFT_amb_nurse_to_diag(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT31,Scrubs_Emdeon_CRecord;
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
    BOOLEAN Diff_payer_id;
    BOOLEAN Diff_form_type;
    BOOLEAN Diff_received_date;
    BOOLEAN Diff_claim_type;
    BOOLEAN Diff_adjustment_code;
    BOOLEAN Diff_prev_claim_number;
    BOOLEAN Diff_sub_client_id;
    BOOLEAN Diff_group_name;
    BOOLEAN Diff_member_id;
    BOOLEAN Diff_member_fname;
    BOOLEAN Diff_member_lname;
    BOOLEAN Diff_member_gender;
    BOOLEAN Diff_member_dob;
    BOOLEAN Diff_member_address1;
    BOOLEAN Diff_member_address2;
    BOOLEAN Diff_member_city;
    BOOLEAN Diff_member_state;
    BOOLEAN Diff_member_zip;
    BOOLEAN Diff_patient_id;
    BOOLEAN Diff_patient_relation;
    BOOLEAN Diff_patient_fname;
    BOOLEAN Diff_patient_lname;
    BOOLEAN Diff_patient_gender;
    BOOLEAN Diff_patient_dob;
    BOOLEAN Diff_patient_age;
    BOOLEAN Diff_billing_id;
    BOOLEAN Diff_billing_npi;
    BOOLEAN Diff_billing_name1;
    BOOLEAN Diff_billing_name2;
    BOOLEAN Diff_billing_address1;
    BOOLEAN Diff_billing_address2;
    BOOLEAN Diff_billing_city;
    BOOLEAN Diff_billing_state;
    BOOLEAN Diff_billing_zip;
    BOOLEAN Diff_referring_id;
    BOOLEAN Diff_referring_npi;
    BOOLEAN Diff_referring_name1;
    BOOLEAN Diff_referring_name2;
    BOOLEAN Diff_attending_id;
    BOOLEAN Diff_attending_npi;
    BOOLEAN Diff_attending_name1;
    BOOLEAN Diff_attending_name2;
    BOOLEAN Diff_facility_id;
    BOOLEAN Diff_facility_name1;
    BOOLEAN Diff_facility_name2;
    BOOLEAN Diff_facility_address1;
    BOOLEAN Diff_facility_address2;
    BOOLEAN Diff_facility_city;
    BOOLEAN Diff_facility_state;
    BOOLEAN Diff_facility_zip;
    BOOLEAN Diff_statement_from;
    BOOLEAN Diff_statement_to;
    BOOLEAN Diff_total_charge;
    BOOLEAN Diff_total_allowed;
    BOOLEAN Diff_drg_code;
    BOOLEAN Diff_patient_control;
    BOOLEAN Diff_bill_type;
    BOOLEAN Diff_release_sign;
    BOOLEAN Diff_assignment_sign;
    BOOLEAN Diff_in_out_network;
    BOOLEAN Diff_principal_proc;
    BOOLEAN Diff_admit_diag;
    BOOLEAN Diff_primary_diag;
    BOOLEAN Diff_diag_code2;
    BOOLEAN Diff_diag_code3;
    BOOLEAN Diff_diag_code4;
    BOOLEAN Diff_diag_code5;
    BOOLEAN Diff_diag_code6;
    BOOLEAN Diff_diag_code7;
    BOOLEAN Diff_diag_code8;
    BOOLEAN Diff_other_proc;
    BOOLEAN Diff_other_proc3;
    BOOLEAN Diff_other_proc4;
    BOOLEAN Diff_other_proc5;
    BOOLEAN Diff_other_proc6;
    BOOLEAN Diff_prov_specialty;
    BOOLEAN Diff_coverage_type;
    BOOLEAN Diff_explanation_code;
    BOOLEAN Diff_accident_related;
    BOOLEAN Diff_esrd_patient;
    BOOLEAN Diff_hosp_admit_or_er;
    BOOLEAN Diff_amb_nurse_to_hosp;
    BOOLEAN Diff_non_covered_specialty;
    BOOLEAN Diff_electronic_claim;
    BOOLEAN Diff_dialysis_related;
    BOOLEAN Diff_new_patient;
    BOOLEAN Diff_init_proc;
    BOOLEAN Diff_amb_nurse_to_diag;
    UNSIGNED Num_Diffs;
    SALT31.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_claim_num := le.claim_num <> ri.claim_num;
    SELF.Diff_claim_rec_type := le.claim_rec_type <> ri.claim_rec_type;
    SELF.Diff_payer_id := le.payer_id <> ri.payer_id;
    SELF.Diff_form_type := le.form_type <> ri.form_type;
    SELF.Diff_received_date := le.received_date <> ri.received_date;
    SELF.Diff_claim_type := le.claim_type <> ri.claim_type;
    SELF.Diff_adjustment_code := le.adjustment_code <> ri.adjustment_code;
    SELF.Diff_prev_claim_number := le.prev_claim_number <> ri.prev_claim_number;
    SELF.Diff_sub_client_id := le.sub_client_id <> ri.sub_client_id;
    SELF.Diff_group_name := le.group_name <> ri.group_name;
    SELF.Diff_member_id := le.member_id <> ri.member_id;
    SELF.Diff_member_fname := le.member_fname <> ri.member_fname;
    SELF.Diff_member_lname := le.member_lname <> ri.member_lname;
    SELF.Diff_member_gender := le.member_gender <> ri.member_gender;
    SELF.Diff_member_dob := le.member_dob <> ri.member_dob;
    SELF.Diff_member_address1 := le.member_address1 <> ri.member_address1;
    SELF.Diff_member_address2 := le.member_address2 <> ri.member_address2;
    SELF.Diff_member_city := le.member_city <> ri.member_city;
    SELF.Diff_member_state := le.member_state <> ri.member_state;
    SELF.Diff_member_zip := le.member_zip <> ri.member_zip;
    SELF.Diff_patient_id := le.patient_id <> ri.patient_id;
    SELF.Diff_patient_relation := le.patient_relation <> ri.patient_relation;
    SELF.Diff_patient_fname := le.patient_fname <> ri.patient_fname;
    SELF.Diff_patient_lname := le.patient_lname <> ri.patient_lname;
    SELF.Diff_patient_gender := le.patient_gender <> ri.patient_gender;
    SELF.Diff_patient_dob := le.patient_dob <> ri.patient_dob;
    SELF.Diff_patient_age := le.patient_age <> ri.patient_age;
    SELF.Diff_billing_id := le.billing_id <> ri.billing_id;
    SELF.Diff_billing_npi := le.billing_npi <> ri.billing_npi;
    SELF.Diff_billing_name1 := le.billing_name1 <> ri.billing_name1;
    SELF.Diff_billing_name2 := le.billing_name2 <> ri.billing_name2;
    SELF.Diff_billing_address1 := le.billing_address1 <> ri.billing_address1;
    SELF.Diff_billing_address2 := le.billing_address2 <> ri.billing_address2;
    SELF.Diff_billing_city := le.billing_city <> ri.billing_city;
    SELF.Diff_billing_state := le.billing_state <> ri.billing_state;
    SELF.Diff_billing_zip := le.billing_zip <> ri.billing_zip;
    SELF.Diff_referring_id := le.referring_id <> ri.referring_id;
    SELF.Diff_referring_npi := le.referring_npi <> ri.referring_npi;
    SELF.Diff_referring_name1 := le.referring_name1 <> ri.referring_name1;
    SELF.Diff_referring_name2 := le.referring_name2 <> ri.referring_name2;
    SELF.Diff_attending_id := le.attending_id <> ri.attending_id;
    SELF.Diff_attending_npi := le.attending_npi <> ri.attending_npi;
    SELF.Diff_attending_name1 := le.attending_name1 <> ri.attending_name1;
    SELF.Diff_attending_name2 := le.attending_name2 <> ri.attending_name2;
    SELF.Diff_facility_id := le.facility_id <> ri.facility_id;
    SELF.Diff_facility_name1 := le.facility_name1 <> ri.facility_name1;
    SELF.Diff_facility_name2 := le.facility_name2 <> ri.facility_name2;
    SELF.Diff_facility_address1 := le.facility_address1 <> ri.facility_address1;
    SELF.Diff_facility_address2 := le.facility_address2 <> ri.facility_address2;
    SELF.Diff_facility_city := le.facility_city <> ri.facility_city;
    SELF.Diff_facility_state := le.facility_state <> ri.facility_state;
    SELF.Diff_facility_zip := le.facility_zip <> ri.facility_zip;
    SELF.Diff_statement_from := le.statement_from <> ri.statement_from;
    SELF.Diff_statement_to := le.statement_to <> ri.statement_to;
    SELF.Diff_total_charge := le.total_charge <> ri.total_charge;
    SELF.Diff_total_allowed := le.total_allowed <> ri.total_allowed;
    SELF.Diff_drg_code := le.drg_code <> ri.drg_code;
    SELF.Diff_patient_control := le.patient_control <> ri.patient_control;
    SELF.Diff_bill_type := le.bill_type <> ri.bill_type;
    SELF.Diff_release_sign := le.release_sign <> ri.release_sign;
    SELF.Diff_assignment_sign := le.assignment_sign <> ri.assignment_sign;
    SELF.Diff_in_out_network := le.in_out_network <> ri.in_out_network;
    SELF.Diff_principal_proc := le.principal_proc <> ri.principal_proc;
    SELF.Diff_admit_diag := le.admit_diag <> ri.admit_diag;
    SELF.Diff_primary_diag := le.primary_diag <> ri.primary_diag;
    SELF.Diff_diag_code2 := le.diag_code2 <> ri.diag_code2;
    SELF.Diff_diag_code3 := le.diag_code3 <> ri.diag_code3;
    SELF.Diff_diag_code4 := le.diag_code4 <> ri.diag_code4;
    SELF.Diff_diag_code5 := le.diag_code5 <> ri.diag_code5;
    SELF.Diff_diag_code6 := le.diag_code6 <> ri.diag_code6;
    SELF.Diff_diag_code7 := le.diag_code7 <> ri.diag_code7;
    SELF.Diff_diag_code8 := le.diag_code8 <> ri.diag_code8;
    SELF.Diff_other_proc := le.other_proc <> ri.other_proc;
    SELF.Diff_other_proc3 := le.other_proc3 <> ri.other_proc3;
    SELF.Diff_other_proc4 := le.other_proc4 <> ri.other_proc4;
    SELF.Diff_other_proc5 := le.other_proc5 <> ri.other_proc5;
    SELF.Diff_other_proc6 := le.other_proc6 <> ri.other_proc6;
    SELF.Diff_prov_specialty := le.prov_specialty <> ri.prov_specialty;
    SELF.Diff_coverage_type := le.coverage_type <> ri.coverage_type;
    SELF.Diff_explanation_code := le.explanation_code <> ri.explanation_code;
    SELF.Diff_accident_related := le.accident_related <> ri.accident_related;
    SELF.Diff_esrd_patient := le.esrd_patient <> ri.esrd_patient;
    SELF.Diff_hosp_admit_or_er := le.hosp_admit_or_er <> ri.hosp_admit_or_er;
    SELF.Diff_amb_nurse_to_hosp := le.amb_nurse_to_hosp <> ri.amb_nurse_to_hosp;
    SELF.Diff_non_covered_specialty := le.non_covered_specialty <> ri.non_covered_specialty;
    SELF.Diff_electronic_claim := le.electronic_claim <> ri.electronic_claim;
    SELF.Diff_dialysis_related := le.dialysis_related <> ri.dialysis_related;
    SELF.Diff_new_patient := le.new_patient <> ri.new_patient;
    SELF.Diff_init_proc := le.init_proc <> ri.init_proc;
    SELF.Diff_amb_nurse_to_diag := le.amb_nurse_to_diag <> ri.amb_nurse_to_diag;
    SELF.Val := (SALT31.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_claim_num,1,0)+ IF( SELF.Diff_claim_rec_type,1,0)+ IF( SELF.Diff_payer_id,1,0)+ IF( SELF.Diff_form_type,1,0)+ IF( SELF.Diff_received_date,1,0)+ IF( SELF.Diff_claim_type,1,0)+ IF( SELF.Diff_adjustment_code,1,0)+ IF( SELF.Diff_prev_claim_number,1,0)+ IF( SELF.Diff_sub_client_id,1,0)+ IF( SELF.Diff_group_name,1,0)+ IF( SELF.Diff_member_id,1,0)+ IF( SELF.Diff_member_fname,1,0)+ IF( SELF.Diff_member_lname,1,0)+ IF( SELF.Diff_member_gender,1,0)+ IF( SELF.Diff_member_dob,1,0)+ IF( SELF.Diff_member_address1,1,0)+ IF( SELF.Diff_member_address2,1,0)+ IF( SELF.Diff_member_city,1,0)+ IF( SELF.Diff_member_state,1,0)+ IF( SELF.Diff_member_zip,1,0)+ IF( SELF.Diff_patient_id,1,0)+ IF( SELF.Diff_patient_relation,1,0)+ IF( SELF.Diff_patient_fname,1,0)+ IF( SELF.Diff_patient_lname,1,0)+ IF( SELF.Diff_patient_gender,1,0)+ IF( SELF.Diff_patient_dob,1,0)+ IF( SELF.Diff_patient_age,1,0)+ IF( SELF.Diff_billing_id,1,0)+ IF( SELF.Diff_billing_npi,1,0)+ IF( SELF.Diff_billing_name1,1,0)+ IF( SELF.Diff_billing_name2,1,0)+ IF( SELF.Diff_billing_address1,1,0)+ IF( SELF.Diff_billing_address2,1,0)+ IF( SELF.Diff_billing_city,1,0)+ IF( SELF.Diff_billing_state,1,0)+ IF( SELF.Diff_billing_zip,1,0)+ IF( SELF.Diff_referring_id,1,0)+ IF( SELF.Diff_referring_npi,1,0)+ IF( SELF.Diff_referring_name1,1,0)+ IF( SELF.Diff_referring_name2,1,0)+ IF( SELF.Diff_attending_id,1,0)+ IF( SELF.Diff_attending_npi,1,0)+ IF( SELF.Diff_attending_name1,1,0)+ IF( SELF.Diff_attending_name2,1,0)+ IF( SELF.Diff_facility_id,1,0)+ IF( SELF.Diff_facility_name1,1,0)+ IF( SELF.Diff_facility_name2,1,0)+ IF( SELF.Diff_facility_address1,1,0)+ IF( SELF.Diff_facility_address2,1,0)+ IF( SELF.Diff_facility_city,1,0)+ IF( SELF.Diff_facility_state,1,0)+ IF( SELF.Diff_facility_zip,1,0)+ IF( SELF.Diff_statement_from,1,0)+ IF( SELF.Diff_statement_to,1,0)+ IF( SELF.Diff_total_charge,1,0)+ IF( SELF.Diff_total_allowed,1,0)+ IF( SELF.Diff_drg_code,1,0)+ IF( SELF.Diff_patient_control,1,0)+ IF( SELF.Diff_bill_type,1,0)+ IF( SELF.Diff_release_sign,1,0)+ IF( SELF.Diff_assignment_sign,1,0)+ IF( SELF.Diff_in_out_network,1,0)+ IF( SELF.Diff_principal_proc,1,0)+ IF( SELF.Diff_admit_diag,1,0)+ IF( SELF.Diff_primary_diag,1,0)+ IF( SELF.Diff_diag_code2,1,0)+ IF( SELF.Diff_diag_code3,1,0)+ IF( SELF.Diff_diag_code4,1,0)+ IF( SELF.Diff_diag_code5,1,0)+ IF( SELF.Diff_diag_code6,1,0)+ IF( SELF.Diff_diag_code7,1,0)+ IF( SELF.Diff_diag_code8,1,0)+ IF( SELF.Diff_other_proc,1,0)+ IF( SELF.Diff_other_proc3,1,0)+ IF( SELF.Diff_other_proc4,1,0)+ IF( SELF.Diff_other_proc5,1,0)+ IF( SELF.Diff_other_proc6,1,0)+ IF( SELF.Diff_prov_specialty,1,0)+ IF( SELF.Diff_coverage_type,1,0)+ IF( SELF.Diff_explanation_code,1,0)+ IF( SELF.Diff_accident_related,1,0)+ IF( SELF.Diff_esrd_patient,1,0)+ IF( SELF.Diff_hosp_admit_or_er,1,0)+ IF( SELF.Diff_amb_nurse_to_hosp,1,0)+ IF( SELF.Diff_non_covered_specialty,1,0)+ IF( SELF.Diff_electronic_claim,1,0)+ IF( SELF.Diff_dialysis_related,1,0)+ IF( SELF.Diff_new_patient,1,0)+ IF( SELF.Diff_init_proc,1,0)+ IF( SELF.Diff_amb_nurse_to_diag,1,0);
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
    Count_Diff_payer_id := COUNT(GROUP,%Closest%.Diff_payer_id);
    Count_Diff_form_type := COUNT(GROUP,%Closest%.Diff_form_type);
    Count_Diff_received_date := COUNT(GROUP,%Closest%.Diff_received_date);
    Count_Diff_claim_type := COUNT(GROUP,%Closest%.Diff_claim_type);
    Count_Diff_adjustment_code := COUNT(GROUP,%Closest%.Diff_adjustment_code);
    Count_Diff_prev_claim_number := COUNT(GROUP,%Closest%.Diff_prev_claim_number);
    Count_Diff_sub_client_id := COUNT(GROUP,%Closest%.Diff_sub_client_id);
    Count_Diff_group_name := COUNT(GROUP,%Closest%.Diff_group_name);
    Count_Diff_member_id := COUNT(GROUP,%Closest%.Diff_member_id);
    Count_Diff_member_fname := COUNT(GROUP,%Closest%.Diff_member_fname);
    Count_Diff_member_lname := COUNT(GROUP,%Closest%.Diff_member_lname);
    Count_Diff_member_gender := COUNT(GROUP,%Closest%.Diff_member_gender);
    Count_Diff_member_dob := COUNT(GROUP,%Closest%.Diff_member_dob);
    Count_Diff_member_address1 := COUNT(GROUP,%Closest%.Diff_member_address1);
    Count_Diff_member_address2 := COUNT(GROUP,%Closest%.Diff_member_address2);
    Count_Diff_member_city := COUNT(GROUP,%Closest%.Diff_member_city);
    Count_Diff_member_state := COUNT(GROUP,%Closest%.Diff_member_state);
    Count_Diff_member_zip := COUNT(GROUP,%Closest%.Diff_member_zip);
    Count_Diff_patient_id := COUNT(GROUP,%Closest%.Diff_patient_id);
    Count_Diff_patient_relation := COUNT(GROUP,%Closest%.Diff_patient_relation);
    Count_Diff_patient_fname := COUNT(GROUP,%Closest%.Diff_patient_fname);
    Count_Diff_patient_lname := COUNT(GROUP,%Closest%.Diff_patient_lname);
    Count_Diff_patient_gender := COUNT(GROUP,%Closest%.Diff_patient_gender);
    Count_Diff_patient_dob := COUNT(GROUP,%Closest%.Diff_patient_dob);
    Count_Diff_patient_age := COUNT(GROUP,%Closest%.Diff_patient_age);
    Count_Diff_billing_id := COUNT(GROUP,%Closest%.Diff_billing_id);
    Count_Diff_billing_npi := COUNT(GROUP,%Closest%.Diff_billing_npi);
    Count_Diff_billing_name1 := COUNT(GROUP,%Closest%.Diff_billing_name1);
    Count_Diff_billing_name2 := COUNT(GROUP,%Closest%.Diff_billing_name2);
    Count_Diff_billing_address1 := COUNT(GROUP,%Closest%.Diff_billing_address1);
    Count_Diff_billing_address2 := COUNT(GROUP,%Closest%.Diff_billing_address2);
    Count_Diff_billing_city := COUNT(GROUP,%Closest%.Diff_billing_city);
    Count_Diff_billing_state := COUNT(GROUP,%Closest%.Diff_billing_state);
    Count_Diff_billing_zip := COUNT(GROUP,%Closest%.Diff_billing_zip);
    Count_Diff_referring_id := COUNT(GROUP,%Closest%.Diff_referring_id);
    Count_Diff_referring_npi := COUNT(GROUP,%Closest%.Diff_referring_npi);
    Count_Diff_referring_name1 := COUNT(GROUP,%Closest%.Diff_referring_name1);
    Count_Diff_referring_name2 := COUNT(GROUP,%Closest%.Diff_referring_name2);
    Count_Diff_attending_id := COUNT(GROUP,%Closest%.Diff_attending_id);
    Count_Diff_attending_npi := COUNT(GROUP,%Closest%.Diff_attending_npi);
    Count_Diff_attending_name1 := COUNT(GROUP,%Closest%.Diff_attending_name1);
    Count_Diff_attending_name2 := COUNT(GROUP,%Closest%.Diff_attending_name2);
    Count_Diff_facility_id := COUNT(GROUP,%Closest%.Diff_facility_id);
    Count_Diff_facility_name1 := COUNT(GROUP,%Closest%.Diff_facility_name1);
    Count_Diff_facility_name2 := COUNT(GROUP,%Closest%.Diff_facility_name2);
    Count_Diff_facility_address1 := COUNT(GROUP,%Closest%.Diff_facility_address1);
    Count_Diff_facility_address2 := COUNT(GROUP,%Closest%.Diff_facility_address2);
    Count_Diff_facility_city := COUNT(GROUP,%Closest%.Diff_facility_city);
    Count_Diff_facility_state := COUNT(GROUP,%Closest%.Diff_facility_state);
    Count_Diff_facility_zip := COUNT(GROUP,%Closest%.Diff_facility_zip);
    Count_Diff_statement_from := COUNT(GROUP,%Closest%.Diff_statement_from);
    Count_Diff_statement_to := COUNT(GROUP,%Closest%.Diff_statement_to);
    Count_Diff_total_charge := COUNT(GROUP,%Closest%.Diff_total_charge);
    Count_Diff_total_allowed := COUNT(GROUP,%Closest%.Diff_total_allowed);
    Count_Diff_drg_code := COUNT(GROUP,%Closest%.Diff_drg_code);
    Count_Diff_patient_control := COUNT(GROUP,%Closest%.Diff_patient_control);
    Count_Diff_bill_type := COUNT(GROUP,%Closest%.Diff_bill_type);
    Count_Diff_release_sign := COUNT(GROUP,%Closest%.Diff_release_sign);
    Count_Diff_assignment_sign := COUNT(GROUP,%Closest%.Diff_assignment_sign);
    Count_Diff_in_out_network := COUNT(GROUP,%Closest%.Diff_in_out_network);
    Count_Diff_principal_proc := COUNT(GROUP,%Closest%.Diff_principal_proc);
    Count_Diff_admit_diag := COUNT(GROUP,%Closest%.Diff_admit_diag);
    Count_Diff_primary_diag := COUNT(GROUP,%Closest%.Diff_primary_diag);
    Count_Diff_diag_code2 := COUNT(GROUP,%Closest%.Diff_diag_code2);
    Count_Diff_diag_code3 := COUNT(GROUP,%Closest%.Diff_diag_code3);
    Count_Diff_diag_code4 := COUNT(GROUP,%Closest%.Diff_diag_code4);
    Count_Diff_diag_code5 := COUNT(GROUP,%Closest%.Diff_diag_code5);
    Count_Diff_diag_code6 := COUNT(GROUP,%Closest%.Diff_diag_code6);
    Count_Diff_diag_code7 := COUNT(GROUP,%Closest%.Diff_diag_code7);
    Count_Diff_diag_code8 := COUNT(GROUP,%Closest%.Diff_diag_code8);
    Count_Diff_other_proc := COUNT(GROUP,%Closest%.Diff_other_proc);
    Count_Diff_other_proc3 := COUNT(GROUP,%Closest%.Diff_other_proc3);
    Count_Diff_other_proc4 := COUNT(GROUP,%Closest%.Diff_other_proc4);
    Count_Diff_other_proc5 := COUNT(GROUP,%Closest%.Diff_other_proc5);
    Count_Diff_other_proc6 := COUNT(GROUP,%Closest%.Diff_other_proc6);
    Count_Diff_prov_specialty := COUNT(GROUP,%Closest%.Diff_prov_specialty);
    Count_Diff_coverage_type := COUNT(GROUP,%Closest%.Diff_coverage_type);
    Count_Diff_explanation_code := COUNT(GROUP,%Closest%.Diff_explanation_code);
    Count_Diff_accident_related := COUNT(GROUP,%Closest%.Diff_accident_related);
    Count_Diff_esrd_patient := COUNT(GROUP,%Closest%.Diff_esrd_patient);
    Count_Diff_hosp_admit_or_er := COUNT(GROUP,%Closest%.Diff_hosp_admit_or_er);
    Count_Diff_amb_nurse_to_hosp := COUNT(GROUP,%Closest%.Diff_amb_nurse_to_hosp);
    Count_Diff_non_covered_specialty := COUNT(GROUP,%Closest%.Diff_non_covered_specialty);
    Count_Diff_electronic_claim := COUNT(GROUP,%Closest%.Diff_electronic_claim);
    Count_Diff_dialysis_related := COUNT(GROUP,%Closest%.Diff_dialysis_related);
    Count_Diff_new_patient := COUNT(GROUP,%Closest%.Diff_new_patient);
    Count_Diff_init_proc := COUNT(GROUP,%Closest%.Diff_init_proc);
    Count_Diff_amb_nurse_to_diag := COUNT(GROUP,%Closest%.Diff_amb_nurse_to_diag);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
