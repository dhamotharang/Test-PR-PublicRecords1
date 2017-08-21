IMPORT ut,SALT31;
EXPORT DRecord_Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT31.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'claim_num','claim_rec_type','diag_code9','diag_code10','diag_code11','diag_code12','diag_code13','diag_code14','diag_code15','diag_code16','diag_code17','diag_code18','diag_code19','diag_code20','diag_code21','diag_code22','diag_code23','diag_code24','other_proc7','other_proc8','other_proc9','other_proc10','other_proc11','other_proc12','other_proc13','other_proc14','other_proc15','other_proc16','other_proc17','other_proc18','other_proc19','other_proc20','other_proc21','other_proc22','claim_indicator_code','ref_prov_state_lic','ref_prov_upin','ref_prov_commercial_id','cob1_group_policy_num','cob1_group_name','cob1_ins_type_code','cob1_claim_filing_indicator');
EXPORT FieldTypeNum(SALT31.StrType fn) := CASE(fn,'claim_num' => 1,'claim_rec_type' => 2,'diag_code9' => 3,'diag_code10' => 4,'diag_code11' => 5,'diag_code12' => 6,'diag_code13' => 7,'diag_code14' => 8,'diag_code15' => 9,'diag_code16' => 10,'diag_code17' => 11,'diag_code18' => 12,'diag_code19' => 13,'diag_code20' => 14,'diag_code21' => 15,'diag_code22' => 16,'diag_code23' => 17,'diag_code24' => 18,'other_proc7' => 19,'other_proc8' => 20,'other_proc9' => 21,'other_proc10' => 22,'other_proc11' => 23,'other_proc12' => 24,'other_proc13' => 25,'other_proc14' => 26,'other_proc15' => 27,'other_proc16' => 28,'other_proc17' => 29,'other_proc18' => 30,'other_proc19' => 31,'other_proc20' => 32,'other_proc21' => 33,'other_proc22' => 34,'claim_indicator_code' => 35,'ref_prov_state_lic' => 36,'ref_prov_upin' => 37,'ref_prov_commercial_id' => 38,'cob1_group_policy_num' => 39,'cob1_group_name' => 40,'cob1_ins_type_code' => 41,'cob1_claim_filing_indicator' => 42,0);
 
EXPORT MakeFT_claim_num(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789EIP '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_claim_num(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789EIP '))),~(LENGTH(TRIM(s)) = 17),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_claim_num(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789EIP '),SALT31.HygieneErrors.NotLength('17'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_claim_rec_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'D '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_claim_rec_type(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'D '))),~(LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_claim_rec_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('D '),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_diag_code9(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789V '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code9(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789V '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code9(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789V '),SALT31.HygieneErrors.NotLength('0,5,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_diag_code10(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789V '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code10(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789V '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code10(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789V '),SALT31.HygieneErrors.NotLength('0,5,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_diag_code11(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789V '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code11(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789V '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code11(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789V '),SALT31.HygieneErrors.NotLength('0,5,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_diag_code12(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789V '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code12(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789V '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code12(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789V '),SALT31.HygieneErrors.NotLength('0,5,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_diag_code13(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789V '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code13(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789V '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code13(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789V '),SALT31.HygieneErrors.NotLength('0,5,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_diag_code14(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789V '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code14(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789V '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code14(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789V '),SALT31.HygieneErrors.NotLength('0,5,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_diag_code15(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789V '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code15(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789V '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code15(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789V '),SALT31.HygieneErrors.NotLength('0,5,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_diag_code16(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789V '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code16(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789V '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code16(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789V '),SALT31.HygieneErrors.NotLength('0,5,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_diag_code17(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789V '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code17(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789V '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code17(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789V '),SALT31.HygieneErrors.NotLength('0,5,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_diag_code18(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789V '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code18(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789V '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code18(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789V '),SALT31.HygieneErrors.NotLength('0,5,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_diag_code19(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789V '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code19(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789V '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code19(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789V '),SALT31.HygieneErrors.NotLength('0,5,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_diag_code20(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789V '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code20(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789V '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code20(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789V '),SALT31.HygieneErrors.NotLength('0,5,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_diag_code21(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789V '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code21(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789V '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code21(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789V '),SALT31.HygieneErrors.NotLength('0,5,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_diag_code22(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789V '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code22(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789V '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code22(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789V '),SALT31.HygieneErrors.NotLength('0,5,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_diag_code23(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789V '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code23(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789V '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code23(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789V '),SALT31.HygieneErrors.NotLength('0,5,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_diag_code24(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789V '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_diag_code24(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789V '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_diag_code24(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789V '),SALT31.HygieneErrors.NotLength('0,5,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_other_proc7(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789V '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_proc7(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789V '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_proc7(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789V '),SALT31.HygieneErrors.NotLength('0,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_other_proc8(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_proc8(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_proc8(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_other_proc9(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_proc9(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_proc9(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_other_proc10(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_proc10(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_proc10(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_other_proc11(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_proc11(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_proc11(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_other_proc12(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_proc12(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_proc12(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_other_proc13(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_proc13(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_proc13(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_other_proc14(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_proc14(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_proc14(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_other_proc15(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_proc15(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_proc15(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_other_proc16(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_proc16(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_proc16(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_other_proc17(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_proc17(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_proc17(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_other_proc18(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_proc18(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_proc18(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_other_proc19(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_proc19(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_proc19(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_other_proc20(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_proc20(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_proc20(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_other_proc21(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_proc21(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_proc21(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_other_proc22(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_other_proc22(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_other_proc22(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,4'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_claim_indicator_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'12356ABCFHILMVZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_claim_indicator_code(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'12356ABCFHILMVZ '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_claim_indicator_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('12356ABCFHILMVZ '),SALT31.HygieneErrors.NotLength('2,0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_ref_prov_state_lic(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_ref_prov_state_lic(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_ref_prov_state_lic(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_ref_prov_upin(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_ref_prov_upin(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 6),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_ref_prov_upin(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.NotLength('0,6'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_ref_prov_commercial_id(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_ref_prov_commercial_id(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_ref_prov_commercial_id(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_cob1_group_policy_num(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_cob1_group_policy_num(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_cob1_group_policy_num(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_cob1_group_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_cob1_group_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_cob1_group_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_cob1_ins_type_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'1234567BCGIMOPST '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_cob1_ins_type_code(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'1234567BCGIMOPST '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_cob1_ins_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('1234567BCGIMOPST '),SALT31.HygieneErrors.NotLength('0,2'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT MakeFT_cob1_claim_filing_indicator(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_cob1_claim_filing_indicator(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 1),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_cob1_claim_filing_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.NotLength('0,2,1'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
 
EXPORT SALT31.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'claim_num','claim_rec_type','diag_code9','diag_code10','diag_code11','diag_code12','diag_code13','diag_code14','diag_code15','diag_code16','diag_code17','diag_code18','diag_code19','diag_code20','diag_code21','diag_code22','diag_code23','diag_code24','other_proc7','other_proc8','other_proc9','other_proc10','other_proc11','other_proc12','other_proc13','other_proc14','other_proc15','other_proc16','other_proc17','other_proc18','other_proc19','other_proc20','other_proc21','other_proc22','claim_indicator_code','ref_prov_state_lic','ref_prov_upin','ref_prov_commercial_id','pay_to_address1','pay_to_address2','pay_to_city','pay_to_zip','pay_to_state','supervising_prov_org_name','supervising_prov_last_name','supervising_prov_first_name','supervising_prov_middle_name','supervising_prov_npi','supervising_prov_state_lic','supervising_prov_upin','supervising_prov_commercial_id','supervising_prov_location','operating_prov_org_name','operating_prov_last_name','operating_prov_first_name','operating_prov_middle_name','operating_prov_npi','operating_prov_state_lic','operating_prov_upin','operating_prov_commercial_id','operating_prov_location','other_operating_prov_org_name','other_operating_prov_last_name','other_operating_prov_first_name','other_operating_prov_middle_name','other_operating_prov_npi','other_operating_prov_state_lic','other_operating_prov_upin','other_operating_prov_commercial_id','other_operating_prov_location','pay_to_plan_name','pay_to_plan_address1','pay_to_plan_address2','pay_to_plan_city','pay_to_plan_zip','pay_to_plan_state','pay_to_plan_naic_id','pay_to_plan_payer_id','pay_to_plan_plan_id','pay_to_plan_claim_ofc_num','pay_to_plan_tax_id','cob1_payer_name','cob1_payer_id','cob1_hpid','cob1_resp_seq_code','cob1_relationship_code','cob1_group_policy_num','cob1_group_name','cob1_ins_type_code','cob1_claim_filing_indicator');
EXPORT FieldNum(SALT31.StrType fn) := CASE(fn,'claim_num' => 1,'claim_rec_type' => 2,'diag_code9' => 3,'diag_code10' => 4,'diag_code11' => 5,'diag_code12' => 6,'diag_code13' => 7,'diag_code14' => 8,'diag_code15' => 9,'diag_code16' => 10,'diag_code17' => 11,'diag_code18' => 12,'diag_code19' => 13,'diag_code20' => 14,'diag_code21' => 15,'diag_code22' => 16,'diag_code23' => 17,'diag_code24' => 18,'other_proc7' => 19,'other_proc8' => 20,'other_proc9' => 21,'other_proc10' => 22,'other_proc11' => 23,'other_proc12' => 24,'other_proc13' => 25,'other_proc14' => 26,'other_proc15' => 27,'other_proc16' => 28,'other_proc17' => 29,'other_proc18' => 30,'other_proc19' => 31,'other_proc20' => 32,'other_proc21' => 33,'other_proc22' => 34,'claim_indicator_code' => 35,'ref_prov_state_lic' => 36,'ref_prov_upin' => 37,'ref_prov_commercial_id' => 38,'pay_to_address1' => 39,'pay_to_address2' => 40,'pay_to_city' => 41,'pay_to_zip' => 42,'pay_to_state' => 43,'supervising_prov_org_name' => 44,'supervising_prov_last_name' => 45,'supervising_prov_first_name' => 46,'supervising_prov_middle_name' => 47,'supervising_prov_npi' => 48,'supervising_prov_state_lic' => 49,'supervising_prov_upin' => 50,'supervising_prov_commercial_id' => 51,'supervising_prov_location' => 52,'operating_prov_org_name' => 53,'operating_prov_last_name' => 54,'operating_prov_first_name' => 55,'operating_prov_middle_name' => 56,'operating_prov_npi' => 57,'operating_prov_state_lic' => 58,'operating_prov_upin' => 59,'operating_prov_commercial_id' => 60,'operating_prov_location' => 61,'other_operating_prov_org_name' => 62,'other_operating_prov_last_name' => 63,'other_operating_prov_first_name' => 64,'other_operating_prov_middle_name' => 65,'other_operating_prov_npi' => 66,'other_operating_prov_state_lic' => 67,'other_operating_prov_upin' => 68,'other_operating_prov_commercial_id' => 69,'other_operating_prov_location' => 70,'pay_to_plan_name' => 71,'pay_to_plan_address1' => 72,'pay_to_plan_address2' => 73,'pay_to_plan_city' => 74,'pay_to_plan_zip' => 75,'pay_to_plan_state' => 76,'pay_to_plan_naic_id' => 77,'pay_to_plan_payer_id' => 78,'pay_to_plan_plan_id' => 79,'pay_to_plan_claim_ofc_num' => 80,'pay_to_plan_tax_id' => 81,'cob1_payer_name' => 82,'cob1_payer_id' => 83,'cob1_hpid' => 84,'cob1_resp_seq_code' => 85,'cob1_relationship_code' => 86,'cob1_group_policy_num' => 87,'cob1_group_name' => 88,'cob1_ins_type_code' => 89,'cob1_claim_filing_indicator' => 90,0);
 
//Individual field level validation
 
EXPORT Make_claim_num(SALT31.StrType s0) := MakeFT_claim_num(s0);
EXPORT InValid_claim_num(SALT31.StrType s) := InValidFT_claim_num(s);
EXPORT InValidMessage_claim_num(UNSIGNED1 wh) := InValidMessageFT_claim_num(wh);
 
EXPORT Make_claim_rec_type(SALT31.StrType s0) := MakeFT_claim_rec_type(s0);
EXPORT InValid_claim_rec_type(SALT31.StrType s) := InValidFT_claim_rec_type(s);
EXPORT InValidMessage_claim_rec_type(UNSIGNED1 wh) := InValidMessageFT_claim_rec_type(wh);
 
EXPORT Make_diag_code9(SALT31.StrType s0) := MakeFT_diag_code9(s0);
EXPORT InValid_diag_code9(SALT31.StrType s) := InValidFT_diag_code9(s);
EXPORT InValidMessage_diag_code9(UNSIGNED1 wh) := InValidMessageFT_diag_code9(wh);
 
EXPORT Make_diag_code10(SALT31.StrType s0) := MakeFT_diag_code10(s0);
EXPORT InValid_diag_code10(SALT31.StrType s) := InValidFT_diag_code10(s);
EXPORT InValidMessage_diag_code10(UNSIGNED1 wh) := InValidMessageFT_diag_code10(wh);
 
EXPORT Make_diag_code11(SALT31.StrType s0) := MakeFT_diag_code11(s0);
EXPORT InValid_diag_code11(SALT31.StrType s) := InValidFT_diag_code11(s);
EXPORT InValidMessage_diag_code11(UNSIGNED1 wh) := InValidMessageFT_diag_code11(wh);
 
EXPORT Make_diag_code12(SALT31.StrType s0) := MakeFT_diag_code12(s0);
EXPORT InValid_diag_code12(SALT31.StrType s) := InValidFT_diag_code12(s);
EXPORT InValidMessage_diag_code12(UNSIGNED1 wh) := InValidMessageFT_diag_code12(wh);
 
EXPORT Make_diag_code13(SALT31.StrType s0) := MakeFT_diag_code13(s0);
EXPORT InValid_diag_code13(SALT31.StrType s) := InValidFT_diag_code13(s);
EXPORT InValidMessage_diag_code13(UNSIGNED1 wh) := InValidMessageFT_diag_code13(wh);
 
EXPORT Make_diag_code14(SALT31.StrType s0) := MakeFT_diag_code14(s0);
EXPORT InValid_diag_code14(SALT31.StrType s) := InValidFT_diag_code14(s);
EXPORT InValidMessage_diag_code14(UNSIGNED1 wh) := InValidMessageFT_diag_code14(wh);
 
EXPORT Make_diag_code15(SALT31.StrType s0) := MakeFT_diag_code15(s0);
EXPORT InValid_diag_code15(SALT31.StrType s) := InValidFT_diag_code15(s);
EXPORT InValidMessage_diag_code15(UNSIGNED1 wh) := InValidMessageFT_diag_code15(wh);
 
EXPORT Make_diag_code16(SALT31.StrType s0) := MakeFT_diag_code16(s0);
EXPORT InValid_diag_code16(SALT31.StrType s) := InValidFT_diag_code16(s);
EXPORT InValidMessage_diag_code16(UNSIGNED1 wh) := InValidMessageFT_diag_code16(wh);
 
EXPORT Make_diag_code17(SALT31.StrType s0) := MakeFT_diag_code17(s0);
EXPORT InValid_diag_code17(SALT31.StrType s) := InValidFT_diag_code17(s);
EXPORT InValidMessage_diag_code17(UNSIGNED1 wh) := InValidMessageFT_diag_code17(wh);
 
EXPORT Make_diag_code18(SALT31.StrType s0) := MakeFT_diag_code18(s0);
EXPORT InValid_diag_code18(SALT31.StrType s) := InValidFT_diag_code18(s);
EXPORT InValidMessage_diag_code18(UNSIGNED1 wh) := InValidMessageFT_diag_code18(wh);
 
EXPORT Make_diag_code19(SALT31.StrType s0) := MakeFT_diag_code19(s0);
EXPORT InValid_diag_code19(SALT31.StrType s) := InValidFT_diag_code19(s);
EXPORT InValidMessage_diag_code19(UNSIGNED1 wh) := InValidMessageFT_diag_code19(wh);
 
EXPORT Make_diag_code20(SALT31.StrType s0) := MakeFT_diag_code20(s0);
EXPORT InValid_diag_code20(SALT31.StrType s) := InValidFT_diag_code20(s);
EXPORT InValidMessage_diag_code20(UNSIGNED1 wh) := InValidMessageFT_diag_code20(wh);
 
EXPORT Make_diag_code21(SALT31.StrType s0) := MakeFT_diag_code21(s0);
EXPORT InValid_diag_code21(SALT31.StrType s) := InValidFT_diag_code21(s);
EXPORT InValidMessage_diag_code21(UNSIGNED1 wh) := InValidMessageFT_diag_code21(wh);
 
EXPORT Make_diag_code22(SALT31.StrType s0) := MakeFT_diag_code22(s0);
EXPORT InValid_diag_code22(SALT31.StrType s) := InValidFT_diag_code22(s);
EXPORT InValidMessage_diag_code22(UNSIGNED1 wh) := InValidMessageFT_diag_code22(wh);
 
EXPORT Make_diag_code23(SALT31.StrType s0) := MakeFT_diag_code23(s0);
EXPORT InValid_diag_code23(SALT31.StrType s) := InValidFT_diag_code23(s);
EXPORT InValidMessage_diag_code23(UNSIGNED1 wh) := InValidMessageFT_diag_code23(wh);
 
EXPORT Make_diag_code24(SALT31.StrType s0) := MakeFT_diag_code24(s0);
EXPORT InValid_diag_code24(SALT31.StrType s) := InValidFT_diag_code24(s);
EXPORT InValidMessage_diag_code24(UNSIGNED1 wh) := InValidMessageFT_diag_code24(wh);
 
EXPORT Make_other_proc7(SALT31.StrType s0) := MakeFT_other_proc7(s0);
EXPORT InValid_other_proc7(SALT31.StrType s) := InValidFT_other_proc7(s);
EXPORT InValidMessage_other_proc7(UNSIGNED1 wh) := InValidMessageFT_other_proc7(wh);
 
EXPORT Make_other_proc8(SALT31.StrType s0) := MakeFT_other_proc8(s0);
EXPORT InValid_other_proc8(SALT31.StrType s) := InValidFT_other_proc8(s);
EXPORT InValidMessage_other_proc8(UNSIGNED1 wh) := InValidMessageFT_other_proc8(wh);
 
EXPORT Make_other_proc9(SALT31.StrType s0) := MakeFT_other_proc9(s0);
EXPORT InValid_other_proc9(SALT31.StrType s) := InValidFT_other_proc9(s);
EXPORT InValidMessage_other_proc9(UNSIGNED1 wh) := InValidMessageFT_other_proc9(wh);
 
EXPORT Make_other_proc10(SALT31.StrType s0) := MakeFT_other_proc10(s0);
EXPORT InValid_other_proc10(SALT31.StrType s) := InValidFT_other_proc10(s);
EXPORT InValidMessage_other_proc10(UNSIGNED1 wh) := InValidMessageFT_other_proc10(wh);
 
EXPORT Make_other_proc11(SALT31.StrType s0) := MakeFT_other_proc11(s0);
EXPORT InValid_other_proc11(SALT31.StrType s) := InValidFT_other_proc11(s);
EXPORT InValidMessage_other_proc11(UNSIGNED1 wh) := InValidMessageFT_other_proc11(wh);
 
EXPORT Make_other_proc12(SALT31.StrType s0) := MakeFT_other_proc12(s0);
EXPORT InValid_other_proc12(SALT31.StrType s) := InValidFT_other_proc12(s);
EXPORT InValidMessage_other_proc12(UNSIGNED1 wh) := InValidMessageFT_other_proc12(wh);
 
EXPORT Make_other_proc13(SALT31.StrType s0) := MakeFT_other_proc13(s0);
EXPORT InValid_other_proc13(SALT31.StrType s) := InValidFT_other_proc13(s);
EXPORT InValidMessage_other_proc13(UNSIGNED1 wh) := InValidMessageFT_other_proc13(wh);
 
EXPORT Make_other_proc14(SALT31.StrType s0) := MakeFT_other_proc14(s0);
EXPORT InValid_other_proc14(SALT31.StrType s) := InValidFT_other_proc14(s);
EXPORT InValidMessage_other_proc14(UNSIGNED1 wh) := InValidMessageFT_other_proc14(wh);
 
EXPORT Make_other_proc15(SALT31.StrType s0) := MakeFT_other_proc15(s0);
EXPORT InValid_other_proc15(SALT31.StrType s) := InValidFT_other_proc15(s);
EXPORT InValidMessage_other_proc15(UNSIGNED1 wh) := InValidMessageFT_other_proc15(wh);
 
EXPORT Make_other_proc16(SALT31.StrType s0) := MakeFT_other_proc16(s0);
EXPORT InValid_other_proc16(SALT31.StrType s) := InValidFT_other_proc16(s);
EXPORT InValidMessage_other_proc16(UNSIGNED1 wh) := InValidMessageFT_other_proc16(wh);
 
EXPORT Make_other_proc17(SALT31.StrType s0) := MakeFT_other_proc17(s0);
EXPORT InValid_other_proc17(SALT31.StrType s) := InValidFT_other_proc17(s);
EXPORT InValidMessage_other_proc17(UNSIGNED1 wh) := InValidMessageFT_other_proc17(wh);
 
EXPORT Make_other_proc18(SALT31.StrType s0) := MakeFT_other_proc18(s0);
EXPORT InValid_other_proc18(SALT31.StrType s) := InValidFT_other_proc18(s);
EXPORT InValidMessage_other_proc18(UNSIGNED1 wh) := InValidMessageFT_other_proc18(wh);
 
EXPORT Make_other_proc19(SALT31.StrType s0) := MakeFT_other_proc19(s0);
EXPORT InValid_other_proc19(SALT31.StrType s) := InValidFT_other_proc19(s);
EXPORT InValidMessage_other_proc19(UNSIGNED1 wh) := InValidMessageFT_other_proc19(wh);
 
EXPORT Make_other_proc20(SALT31.StrType s0) := MakeFT_other_proc20(s0);
EXPORT InValid_other_proc20(SALT31.StrType s) := InValidFT_other_proc20(s);
EXPORT InValidMessage_other_proc20(UNSIGNED1 wh) := InValidMessageFT_other_proc20(wh);
 
EXPORT Make_other_proc21(SALT31.StrType s0) := MakeFT_other_proc21(s0);
EXPORT InValid_other_proc21(SALT31.StrType s) := InValidFT_other_proc21(s);
EXPORT InValidMessage_other_proc21(UNSIGNED1 wh) := InValidMessageFT_other_proc21(wh);
 
EXPORT Make_other_proc22(SALT31.StrType s0) := MakeFT_other_proc22(s0);
EXPORT InValid_other_proc22(SALT31.StrType s) := InValidFT_other_proc22(s);
EXPORT InValidMessage_other_proc22(UNSIGNED1 wh) := InValidMessageFT_other_proc22(wh);
 
EXPORT Make_claim_indicator_code(SALT31.StrType s0) := MakeFT_claim_indicator_code(s0);
EXPORT InValid_claim_indicator_code(SALT31.StrType s) := InValidFT_claim_indicator_code(s);
EXPORT InValidMessage_claim_indicator_code(UNSIGNED1 wh) := InValidMessageFT_claim_indicator_code(wh);
 
EXPORT Make_ref_prov_state_lic(SALT31.StrType s0) := MakeFT_ref_prov_state_lic(s0);
EXPORT InValid_ref_prov_state_lic(SALT31.StrType s) := InValidFT_ref_prov_state_lic(s);
EXPORT InValidMessage_ref_prov_state_lic(UNSIGNED1 wh) := InValidMessageFT_ref_prov_state_lic(wh);
 
EXPORT Make_ref_prov_upin(SALT31.StrType s0) := MakeFT_ref_prov_upin(s0);
EXPORT InValid_ref_prov_upin(SALT31.StrType s) := InValidFT_ref_prov_upin(s);
EXPORT InValidMessage_ref_prov_upin(UNSIGNED1 wh) := InValidMessageFT_ref_prov_upin(wh);
 
EXPORT Make_ref_prov_commercial_id(SALT31.StrType s0) := MakeFT_ref_prov_commercial_id(s0);
EXPORT InValid_ref_prov_commercial_id(SALT31.StrType s) := InValidFT_ref_prov_commercial_id(s);
EXPORT InValidMessage_ref_prov_commercial_id(UNSIGNED1 wh) := InValidMessageFT_ref_prov_commercial_id(wh);
 
EXPORT Make_pay_to_address1(SALT31.StrType s0) := s0;
EXPORT InValid_pay_to_address1(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_pay_to_address1(UNSIGNED1 wh) := '';
 
EXPORT Make_pay_to_address2(SALT31.StrType s0) := s0;
EXPORT InValid_pay_to_address2(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_pay_to_address2(UNSIGNED1 wh) := '';
 
EXPORT Make_pay_to_city(SALT31.StrType s0) := s0;
EXPORT InValid_pay_to_city(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_pay_to_city(UNSIGNED1 wh) := '';
 
EXPORT Make_pay_to_zip(SALT31.StrType s0) := s0;
EXPORT InValid_pay_to_zip(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_pay_to_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_pay_to_state(SALT31.StrType s0) := s0;
EXPORT InValid_pay_to_state(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_pay_to_state(UNSIGNED1 wh) := '';
 
EXPORT Make_supervising_prov_org_name(SALT31.StrType s0) := s0;
EXPORT InValid_supervising_prov_org_name(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_supervising_prov_org_name(UNSIGNED1 wh) := '';
 
EXPORT Make_supervising_prov_last_name(SALT31.StrType s0) := s0;
EXPORT InValid_supervising_prov_last_name(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_supervising_prov_last_name(UNSIGNED1 wh) := '';
 
EXPORT Make_supervising_prov_first_name(SALT31.StrType s0) := s0;
EXPORT InValid_supervising_prov_first_name(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_supervising_prov_first_name(UNSIGNED1 wh) := '';
 
EXPORT Make_supervising_prov_middle_name(SALT31.StrType s0) := s0;
EXPORT InValid_supervising_prov_middle_name(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_supervising_prov_middle_name(UNSIGNED1 wh) := '';
 
EXPORT Make_supervising_prov_npi(SALT31.StrType s0) := s0;
EXPORT InValid_supervising_prov_npi(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_supervising_prov_npi(UNSIGNED1 wh) := '';
 
EXPORT Make_supervising_prov_state_lic(SALT31.StrType s0) := s0;
EXPORT InValid_supervising_prov_state_lic(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_supervising_prov_state_lic(UNSIGNED1 wh) := '';
 
EXPORT Make_supervising_prov_upin(SALT31.StrType s0) := s0;
EXPORT InValid_supervising_prov_upin(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_supervising_prov_upin(UNSIGNED1 wh) := '';
 
EXPORT Make_supervising_prov_commercial_id(SALT31.StrType s0) := s0;
EXPORT InValid_supervising_prov_commercial_id(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_supervising_prov_commercial_id(UNSIGNED1 wh) := '';
 
EXPORT Make_supervising_prov_location(SALT31.StrType s0) := s0;
EXPORT InValid_supervising_prov_location(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_supervising_prov_location(UNSIGNED1 wh) := '';
 
EXPORT Make_operating_prov_org_name(SALT31.StrType s0) := s0;
EXPORT InValid_operating_prov_org_name(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_operating_prov_org_name(UNSIGNED1 wh) := '';
 
EXPORT Make_operating_prov_last_name(SALT31.StrType s0) := s0;
EXPORT InValid_operating_prov_last_name(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_operating_prov_last_name(UNSIGNED1 wh) := '';
 
EXPORT Make_operating_prov_first_name(SALT31.StrType s0) := s0;
EXPORT InValid_operating_prov_first_name(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_operating_prov_first_name(UNSIGNED1 wh) := '';
 
EXPORT Make_operating_prov_middle_name(SALT31.StrType s0) := s0;
EXPORT InValid_operating_prov_middle_name(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_operating_prov_middle_name(UNSIGNED1 wh) := '';
 
EXPORT Make_operating_prov_npi(SALT31.StrType s0) := s0;
EXPORT InValid_operating_prov_npi(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_operating_prov_npi(UNSIGNED1 wh) := '';
 
EXPORT Make_operating_prov_state_lic(SALT31.StrType s0) := s0;
EXPORT InValid_operating_prov_state_lic(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_operating_prov_state_lic(UNSIGNED1 wh) := '';
 
EXPORT Make_operating_prov_upin(SALT31.StrType s0) := s0;
EXPORT InValid_operating_prov_upin(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_operating_prov_upin(UNSIGNED1 wh) := '';
 
EXPORT Make_operating_prov_commercial_id(SALT31.StrType s0) := s0;
EXPORT InValid_operating_prov_commercial_id(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_operating_prov_commercial_id(UNSIGNED1 wh) := '';
 
EXPORT Make_operating_prov_location(SALT31.StrType s0) := s0;
EXPORT InValid_operating_prov_location(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_operating_prov_location(UNSIGNED1 wh) := '';
 
EXPORT Make_other_operating_prov_org_name(SALT31.StrType s0) := s0;
EXPORT InValid_other_operating_prov_org_name(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_other_operating_prov_org_name(UNSIGNED1 wh) := '';
 
EXPORT Make_other_operating_prov_last_name(SALT31.StrType s0) := s0;
EXPORT InValid_other_operating_prov_last_name(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_other_operating_prov_last_name(UNSIGNED1 wh) := '';
 
EXPORT Make_other_operating_prov_first_name(SALT31.StrType s0) := s0;
EXPORT InValid_other_operating_prov_first_name(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_other_operating_prov_first_name(UNSIGNED1 wh) := '';
 
EXPORT Make_other_operating_prov_middle_name(SALT31.StrType s0) := s0;
EXPORT InValid_other_operating_prov_middle_name(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_other_operating_prov_middle_name(UNSIGNED1 wh) := '';
 
EXPORT Make_other_operating_prov_npi(SALT31.StrType s0) := s0;
EXPORT InValid_other_operating_prov_npi(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_other_operating_prov_npi(UNSIGNED1 wh) := '';
 
EXPORT Make_other_operating_prov_state_lic(SALT31.StrType s0) := s0;
EXPORT InValid_other_operating_prov_state_lic(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_other_operating_prov_state_lic(UNSIGNED1 wh) := '';
 
EXPORT Make_other_operating_prov_upin(SALT31.StrType s0) := s0;
EXPORT InValid_other_operating_prov_upin(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_other_operating_prov_upin(UNSIGNED1 wh) := '';
 
EXPORT Make_other_operating_prov_commercial_id(SALT31.StrType s0) := s0;
EXPORT InValid_other_operating_prov_commercial_id(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_other_operating_prov_commercial_id(UNSIGNED1 wh) := '';
 
EXPORT Make_other_operating_prov_location(SALT31.StrType s0) := s0;
EXPORT InValid_other_operating_prov_location(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_other_operating_prov_location(UNSIGNED1 wh) := '';
 
EXPORT Make_pay_to_plan_name(SALT31.StrType s0) := s0;
EXPORT InValid_pay_to_plan_name(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_pay_to_plan_name(UNSIGNED1 wh) := '';
 
EXPORT Make_pay_to_plan_address1(SALT31.StrType s0) := s0;
EXPORT InValid_pay_to_plan_address1(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_pay_to_plan_address1(UNSIGNED1 wh) := '';
 
EXPORT Make_pay_to_plan_address2(SALT31.StrType s0) := s0;
EXPORT InValid_pay_to_plan_address2(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_pay_to_plan_address2(UNSIGNED1 wh) := '';
 
EXPORT Make_pay_to_plan_city(SALT31.StrType s0) := s0;
EXPORT InValid_pay_to_plan_city(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_pay_to_plan_city(UNSIGNED1 wh) := '';
 
EXPORT Make_pay_to_plan_zip(SALT31.StrType s0) := s0;
EXPORT InValid_pay_to_plan_zip(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_pay_to_plan_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_pay_to_plan_state(SALT31.StrType s0) := s0;
EXPORT InValid_pay_to_plan_state(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_pay_to_plan_state(UNSIGNED1 wh) := '';
 
EXPORT Make_pay_to_plan_naic_id(SALT31.StrType s0) := s0;
EXPORT InValid_pay_to_plan_naic_id(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_pay_to_plan_naic_id(UNSIGNED1 wh) := '';
 
EXPORT Make_pay_to_plan_payer_id(SALT31.StrType s0) := s0;
EXPORT InValid_pay_to_plan_payer_id(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_pay_to_plan_payer_id(UNSIGNED1 wh) := '';
 
EXPORT Make_pay_to_plan_plan_id(SALT31.StrType s0) := s0;
EXPORT InValid_pay_to_plan_plan_id(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_pay_to_plan_plan_id(UNSIGNED1 wh) := '';
 
EXPORT Make_pay_to_plan_claim_ofc_num(SALT31.StrType s0) := s0;
EXPORT InValid_pay_to_plan_claim_ofc_num(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_pay_to_plan_claim_ofc_num(UNSIGNED1 wh) := '';
 
EXPORT Make_pay_to_plan_tax_id(SALT31.StrType s0) := s0;
EXPORT InValid_pay_to_plan_tax_id(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_pay_to_plan_tax_id(UNSIGNED1 wh) := '';
 
EXPORT Make_cob1_payer_name(SALT31.StrType s0) := s0;
EXPORT InValid_cob1_payer_name(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_cob1_payer_name(UNSIGNED1 wh) := '';
 
EXPORT Make_cob1_payer_id(SALT31.StrType s0) := s0;
EXPORT InValid_cob1_payer_id(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_cob1_payer_id(UNSIGNED1 wh) := '';
 
EXPORT Make_cob1_hpid(SALT31.StrType s0) := s0;
EXPORT InValid_cob1_hpid(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_cob1_hpid(UNSIGNED1 wh) := '';
 
EXPORT Make_cob1_resp_seq_code(SALT31.StrType s0) := s0;
EXPORT InValid_cob1_resp_seq_code(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_cob1_resp_seq_code(UNSIGNED1 wh) := '';
 
EXPORT Make_cob1_relationship_code(SALT31.StrType s0) := s0;
EXPORT InValid_cob1_relationship_code(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_cob1_relationship_code(UNSIGNED1 wh) := '';
 
EXPORT Make_cob1_group_policy_num(SALT31.StrType s0) := MakeFT_cob1_group_policy_num(s0);
EXPORT InValid_cob1_group_policy_num(SALT31.StrType s) := InValidFT_cob1_group_policy_num(s);
EXPORT InValidMessage_cob1_group_policy_num(UNSIGNED1 wh) := InValidMessageFT_cob1_group_policy_num(wh);
 
EXPORT Make_cob1_group_name(SALT31.StrType s0) := MakeFT_cob1_group_name(s0);
EXPORT InValid_cob1_group_name(SALT31.StrType s) := InValidFT_cob1_group_name(s);
EXPORT InValidMessage_cob1_group_name(UNSIGNED1 wh) := InValidMessageFT_cob1_group_name(wh);
 
EXPORT Make_cob1_ins_type_code(SALT31.StrType s0) := MakeFT_cob1_ins_type_code(s0);
EXPORT InValid_cob1_ins_type_code(SALT31.StrType s) := InValidFT_cob1_ins_type_code(s);
EXPORT InValidMessage_cob1_ins_type_code(UNSIGNED1 wh) := InValidMessageFT_cob1_ins_type_code(wh);
 
EXPORT Make_cob1_claim_filing_indicator(SALT31.StrType s0) := MakeFT_cob1_claim_filing_indicator(s0);
EXPORT InValid_cob1_claim_filing_indicator(SALT31.StrType s) := InValidFT_cob1_claim_filing_indicator(s);
EXPORT InValidMessage_cob1_claim_filing_indicator(UNSIGNED1 wh) := InValidMessageFT_cob1_claim_filing_indicator(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT31,Scrubs_Emdeon_DRecord;
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
    BOOLEAN Diff_diag_code9;
    BOOLEAN Diff_diag_code10;
    BOOLEAN Diff_diag_code11;
    BOOLEAN Diff_diag_code12;
    BOOLEAN Diff_diag_code13;
    BOOLEAN Diff_diag_code14;
    BOOLEAN Diff_diag_code15;
    BOOLEAN Diff_diag_code16;
    BOOLEAN Diff_diag_code17;
    BOOLEAN Diff_diag_code18;
    BOOLEAN Diff_diag_code19;
    BOOLEAN Diff_diag_code20;
    BOOLEAN Diff_diag_code21;
    BOOLEAN Diff_diag_code22;
    BOOLEAN Diff_diag_code23;
    BOOLEAN Diff_diag_code24;
    BOOLEAN Diff_other_proc7;
    BOOLEAN Diff_other_proc8;
    BOOLEAN Diff_other_proc9;
    BOOLEAN Diff_other_proc10;
    BOOLEAN Diff_other_proc11;
    BOOLEAN Diff_other_proc12;
    BOOLEAN Diff_other_proc13;
    BOOLEAN Diff_other_proc14;
    BOOLEAN Diff_other_proc15;
    BOOLEAN Diff_other_proc16;
    BOOLEAN Diff_other_proc17;
    BOOLEAN Diff_other_proc18;
    BOOLEAN Diff_other_proc19;
    BOOLEAN Diff_other_proc20;
    BOOLEAN Diff_other_proc21;
    BOOLEAN Diff_other_proc22;
    BOOLEAN Diff_claim_indicator_code;
    BOOLEAN Diff_ref_prov_state_lic;
    BOOLEAN Diff_ref_prov_upin;
    BOOLEAN Diff_ref_prov_commercial_id;
    BOOLEAN Diff_pay_to_address1;
    BOOLEAN Diff_pay_to_address2;
    BOOLEAN Diff_pay_to_city;
    BOOLEAN Diff_pay_to_zip;
    BOOLEAN Diff_pay_to_state;
    BOOLEAN Diff_supervising_prov_org_name;
    BOOLEAN Diff_supervising_prov_last_name;
    BOOLEAN Diff_supervising_prov_first_name;
    BOOLEAN Diff_supervising_prov_middle_name;
    BOOLEAN Diff_supervising_prov_npi;
    BOOLEAN Diff_supervising_prov_state_lic;
    BOOLEAN Diff_supervising_prov_upin;
    BOOLEAN Diff_supervising_prov_commercial_id;
    BOOLEAN Diff_supervising_prov_location;
    BOOLEAN Diff_operating_prov_org_name;
    BOOLEAN Diff_operating_prov_last_name;
    BOOLEAN Diff_operating_prov_first_name;
    BOOLEAN Diff_operating_prov_middle_name;
    BOOLEAN Diff_operating_prov_npi;
    BOOLEAN Diff_operating_prov_state_lic;
    BOOLEAN Diff_operating_prov_upin;
    BOOLEAN Diff_operating_prov_commercial_id;
    BOOLEAN Diff_operating_prov_location;
    BOOLEAN Diff_other_operating_prov_org_name;
    BOOLEAN Diff_other_operating_prov_last_name;
    BOOLEAN Diff_other_operating_prov_first_name;
    BOOLEAN Diff_other_operating_prov_middle_name;
    BOOLEAN Diff_other_operating_prov_npi;
    BOOLEAN Diff_other_operating_prov_state_lic;
    BOOLEAN Diff_other_operating_prov_upin;
    BOOLEAN Diff_other_operating_prov_commercial_id;
    BOOLEAN Diff_other_operating_prov_location;
    BOOLEAN Diff_pay_to_plan_name;
    BOOLEAN Diff_pay_to_plan_address1;
    BOOLEAN Diff_pay_to_plan_address2;
    BOOLEAN Diff_pay_to_plan_city;
    BOOLEAN Diff_pay_to_plan_zip;
    BOOLEAN Diff_pay_to_plan_state;
    BOOLEAN Diff_pay_to_plan_naic_id;
    BOOLEAN Diff_pay_to_plan_payer_id;
    BOOLEAN Diff_pay_to_plan_plan_id;
    BOOLEAN Diff_pay_to_plan_claim_ofc_num;
    BOOLEAN Diff_pay_to_plan_tax_id;
    BOOLEAN Diff_cob1_payer_name;
    BOOLEAN Diff_cob1_payer_id;
    BOOLEAN Diff_cob1_hpid;
    BOOLEAN Diff_cob1_resp_seq_code;
    BOOLEAN Diff_cob1_relationship_code;
    BOOLEAN Diff_cob1_group_policy_num;
    BOOLEAN Diff_cob1_group_name;
    BOOLEAN Diff_cob1_ins_type_code;
    BOOLEAN Diff_cob1_claim_filing_indicator;
    UNSIGNED Num_Diffs;
    SALT31.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_claim_num := le.claim_num <> ri.claim_num;
    SELF.Diff_claim_rec_type := le.claim_rec_type <> ri.claim_rec_type;
    SELF.Diff_diag_code9 := le.diag_code9 <> ri.diag_code9;
    SELF.Diff_diag_code10 := le.diag_code10 <> ri.diag_code10;
    SELF.Diff_diag_code11 := le.diag_code11 <> ri.diag_code11;
    SELF.Diff_diag_code12 := le.diag_code12 <> ri.diag_code12;
    SELF.Diff_diag_code13 := le.diag_code13 <> ri.diag_code13;
    SELF.Diff_diag_code14 := le.diag_code14 <> ri.diag_code14;
    SELF.Diff_diag_code15 := le.diag_code15 <> ri.diag_code15;
    SELF.Diff_diag_code16 := le.diag_code16 <> ri.diag_code16;
    SELF.Diff_diag_code17 := le.diag_code17 <> ri.diag_code17;
    SELF.Diff_diag_code18 := le.diag_code18 <> ri.diag_code18;
    SELF.Diff_diag_code19 := le.diag_code19 <> ri.diag_code19;
    SELF.Diff_diag_code20 := le.diag_code20 <> ri.diag_code20;
    SELF.Diff_diag_code21 := le.diag_code21 <> ri.diag_code21;
    SELF.Diff_diag_code22 := le.diag_code22 <> ri.diag_code22;
    SELF.Diff_diag_code23 := le.diag_code23 <> ri.diag_code23;
    SELF.Diff_diag_code24 := le.diag_code24 <> ri.diag_code24;
    SELF.Diff_other_proc7 := le.other_proc7 <> ri.other_proc7;
    SELF.Diff_other_proc8 := le.other_proc8 <> ri.other_proc8;
    SELF.Diff_other_proc9 := le.other_proc9 <> ri.other_proc9;
    SELF.Diff_other_proc10 := le.other_proc10 <> ri.other_proc10;
    SELF.Diff_other_proc11 := le.other_proc11 <> ri.other_proc11;
    SELF.Diff_other_proc12 := le.other_proc12 <> ri.other_proc12;
    SELF.Diff_other_proc13 := le.other_proc13 <> ri.other_proc13;
    SELF.Diff_other_proc14 := le.other_proc14 <> ri.other_proc14;
    SELF.Diff_other_proc15 := le.other_proc15 <> ri.other_proc15;
    SELF.Diff_other_proc16 := le.other_proc16 <> ri.other_proc16;
    SELF.Diff_other_proc17 := le.other_proc17 <> ri.other_proc17;
    SELF.Diff_other_proc18 := le.other_proc18 <> ri.other_proc18;
    SELF.Diff_other_proc19 := le.other_proc19 <> ri.other_proc19;
    SELF.Diff_other_proc20 := le.other_proc20 <> ri.other_proc20;
    SELF.Diff_other_proc21 := le.other_proc21 <> ri.other_proc21;
    SELF.Diff_other_proc22 := le.other_proc22 <> ri.other_proc22;
    SELF.Diff_claim_indicator_code := le.claim_indicator_code <> ri.claim_indicator_code;
    SELF.Diff_ref_prov_state_lic := le.ref_prov_state_lic <> ri.ref_prov_state_lic;
    SELF.Diff_ref_prov_upin := le.ref_prov_upin <> ri.ref_prov_upin;
    SELF.Diff_ref_prov_commercial_id := le.ref_prov_commercial_id <> ri.ref_prov_commercial_id;
    SELF.Diff_pay_to_address1 := le.pay_to_address1 <> ri.pay_to_address1;
    SELF.Diff_pay_to_address2 := le.pay_to_address2 <> ri.pay_to_address2;
    SELF.Diff_pay_to_city := le.pay_to_city <> ri.pay_to_city;
    SELF.Diff_pay_to_zip := le.pay_to_zip <> ri.pay_to_zip;
    SELF.Diff_pay_to_state := le.pay_to_state <> ri.pay_to_state;
    SELF.Diff_supervising_prov_org_name := le.supervising_prov_org_name <> ri.supervising_prov_org_name;
    SELF.Diff_supervising_prov_last_name := le.supervising_prov_last_name <> ri.supervising_prov_last_name;
    SELF.Diff_supervising_prov_first_name := le.supervising_prov_first_name <> ri.supervising_prov_first_name;
    SELF.Diff_supervising_prov_middle_name := le.supervising_prov_middle_name <> ri.supervising_prov_middle_name;
    SELF.Diff_supervising_prov_npi := le.supervising_prov_npi <> ri.supervising_prov_npi;
    SELF.Diff_supervising_prov_state_lic := le.supervising_prov_state_lic <> ri.supervising_prov_state_lic;
    SELF.Diff_supervising_prov_upin := le.supervising_prov_upin <> ri.supervising_prov_upin;
    SELF.Diff_supervising_prov_commercial_id := le.supervising_prov_commercial_id <> ri.supervising_prov_commercial_id;
    SELF.Diff_supervising_prov_location := le.supervising_prov_location <> ri.supervising_prov_location;
    SELF.Diff_operating_prov_org_name := le.operating_prov_org_name <> ri.operating_prov_org_name;
    SELF.Diff_operating_prov_last_name := le.operating_prov_last_name <> ri.operating_prov_last_name;
    SELF.Diff_operating_prov_first_name := le.operating_prov_first_name <> ri.operating_prov_first_name;
    SELF.Diff_operating_prov_middle_name := le.operating_prov_middle_name <> ri.operating_prov_middle_name;
    SELF.Diff_operating_prov_npi := le.operating_prov_npi <> ri.operating_prov_npi;
    SELF.Diff_operating_prov_state_lic := le.operating_prov_state_lic <> ri.operating_prov_state_lic;
    SELF.Diff_operating_prov_upin := le.operating_prov_upin <> ri.operating_prov_upin;
    SELF.Diff_operating_prov_commercial_id := le.operating_prov_commercial_id <> ri.operating_prov_commercial_id;
    SELF.Diff_operating_prov_location := le.operating_prov_location <> ri.operating_prov_location;
    SELF.Diff_other_operating_prov_org_name := le.other_operating_prov_org_name <> ri.other_operating_prov_org_name;
    SELF.Diff_other_operating_prov_last_name := le.other_operating_prov_last_name <> ri.other_operating_prov_last_name;
    SELF.Diff_other_operating_prov_first_name := le.other_operating_prov_first_name <> ri.other_operating_prov_first_name;
    SELF.Diff_other_operating_prov_middle_name := le.other_operating_prov_middle_name <> ri.other_operating_prov_middle_name;
    SELF.Diff_other_operating_prov_npi := le.other_operating_prov_npi <> ri.other_operating_prov_npi;
    SELF.Diff_other_operating_prov_state_lic := le.other_operating_prov_state_lic <> ri.other_operating_prov_state_lic;
    SELF.Diff_other_operating_prov_upin := le.other_operating_prov_upin <> ri.other_operating_prov_upin;
    SELF.Diff_other_operating_prov_commercial_id := le.other_operating_prov_commercial_id <> ri.other_operating_prov_commercial_id;
    SELF.Diff_other_operating_prov_location := le.other_operating_prov_location <> ri.other_operating_prov_location;
    SELF.Diff_pay_to_plan_name := le.pay_to_plan_name <> ri.pay_to_plan_name;
    SELF.Diff_pay_to_plan_address1 := le.pay_to_plan_address1 <> ri.pay_to_plan_address1;
    SELF.Diff_pay_to_plan_address2 := le.pay_to_plan_address2 <> ri.pay_to_plan_address2;
    SELF.Diff_pay_to_plan_city := le.pay_to_plan_city <> ri.pay_to_plan_city;
    SELF.Diff_pay_to_plan_zip := le.pay_to_plan_zip <> ri.pay_to_plan_zip;
    SELF.Diff_pay_to_plan_state := le.pay_to_plan_state <> ri.pay_to_plan_state;
    SELF.Diff_pay_to_plan_naic_id := le.pay_to_plan_naic_id <> ri.pay_to_plan_naic_id;
    SELF.Diff_pay_to_plan_payer_id := le.pay_to_plan_payer_id <> ri.pay_to_plan_payer_id;
    SELF.Diff_pay_to_plan_plan_id := le.pay_to_plan_plan_id <> ri.pay_to_plan_plan_id;
    SELF.Diff_pay_to_plan_claim_ofc_num := le.pay_to_plan_claim_ofc_num <> ri.pay_to_plan_claim_ofc_num;
    SELF.Diff_pay_to_plan_tax_id := le.pay_to_plan_tax_id <> ri.pay_to_plan_tax_id;
    SELF.Diff_cob1_payer_name := le.cob1_payer_name <> ri.cob1_payer_name;
    SELF.Diff_cob1_payer_id := le.cob1_payer_id <> ri.cob1_payer_id;
    SELF.Diff_cob1_hpid := le.cob1_hpid <> ri.cob1_hpid;
    SELF.Diff_cob1_resp_seq_code := le.cob1_resp_seq_code <> ri.cob1_resp_seq_code;
    SELF.Diff_cob1_relationship_code := le.cob1_relationship_code <> ri.cob1_relationship_code;
    SELF.Diff_cob1_group_policy_num := le.cob1_group_policy_num <> ri.cob1_group_policy_num;
    SELF.Diff_cob1_group_name := le.cob1_group_name <> ri.cob1_group_name;
    SELF.Diff_cob1_ins_type_code := le.cob1_ins_type_code <> ri.cob1_ins_type_code;
    SELF.Diff_cob1_claim_filing_indicator := le.cob1_claim_filing_indicator <> ri.cob1_claim_filing_indicator;
    SELF.Val := (SALT31.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_claim_num,1,0)+ IF( SELF.Diff_claim_rec_type,1,0)+ IF( SELF.Diff_diag_code9,1,0)+ IF( SELF.Diff_diag_code10,1,0)+ IF( SELF.Diff_diag_code11,1,0)+ IF( SELF.Diff_diag_code12,1,0)+ IF( SELF.Diff_diag_code13,1,0)+ IF( SELF.Diff_diag_code14,1,0)+ IF( SELF.Diff_diag_code15,1,0)+ IF( SELF.Diff_diag_code16,1,0)+ IF( SELF.Diff_diag_code17,1,0)+ IF( SELF.Diff_diag_code18,1,0)+ IF( SELF.Diff_diag_code19,1,0)+ IF( SELF.Diff_diag_code20,1,0)+ IF( SELF.Diff_diag_code21,1,0)+ IF( SELF.Diff_diag_code22,1,0)+ IF( SELF.Diff_diag_code23,1,0)+ IF( SELF.Diff_diag_code24,1,0)+ IF( SELF.Diff_other_proc7,1,0)+ IF( SELF.Diff_other_proc8,1,0)+ IF( SELF.Diff_other_proc9,1,0)+ IF( SELF.Diff_other_proc10,1,0)+ IF( SELF.Diff_other_proc11,1,0)+ IF( SELF.Diff_other_proc12,1,0)+ IF( SELF.Diff_other_proc13,1,0)+ IF( SELF.Diff_other_proc14,1,0)+ IF( SELF.Diff_other_proc15,1,0)+ IF( SELF.Diff_other_proc16,1,0)+ IF( SELF.Diff_other_proc17,1,0)+ IF( SELF.Diff_other_proc18,1,0)+ IF( SELF.Diff_other_proc19,1,0)+ IF( SELF.Diff_other_proc20,1,0)+ IF( SELF.Diff_other_proc21,1,0)+ IF( SELF.Diff_other_proc22,1,0)+ IF( SELF.Diff_claim_indicator_code,1,0)+ IF( SELF.Diff_ref_prov_state_lic,1,0)+ IF( SELF.Diff_ref_prov_upin,1,0)+ IF( SELF.Diff_ref_prov_commercial_id,1,0)+ IF( SELF.Diff_pay_to_address1,1,0)+ IF( SELF.Diff_pay_to_address2,1,0)+ IF( SELF.Diff_pay_to_city,1,0)+ IF( SELF.Diff_pay_to_zip,1,0)+ IF( SELF.Diff_pay_to_state,1,0)+ IF( SELF.Diff_supervising_prov_org_name,1,0)+ IF( SELF.Diff_supervising_prov_last_name,1,0)+ IF( SELF.Diff_supervising_prov_first_name,1,0)+ IF( SELF.Diff_supervising_prov_middle_name,1,0)+ IF( SELF.Diff_supervising_prov_npi,1,0)+ IF( SELF.Diff_supervising_prov_state_lic,1,0)+ IF( SELF.Diff_supervising_prov_upin,1,0)+ IF( SELF.Diff_supervising_prov_commercial_id,1,0)+ IF( SELF.Diff_supervising_prov_location,1,0)+ IF( SELF.Diff_operating_prov_org_name,1,0)+ IF( SELF.Diff_operating_prov_last_name,1,0)+ IF( SELF.Diff_operating_prov_first_name,1,0)+ IF( SELF.Diff_operating_prov_middle_name,1,0)+ IF( SELF.Diff_operating_prov_npi,1,0)+ IF( SELF.Diff_operating_prov_state_lic,1,0)+ IF( SELF.Diff_operating_prov_upin,1,0)+ IF( SELF.Diff_operating_prov_commercial_id,1,0)+ IF( SELF.Diff_operating_prov_location,1,0)+ IF( SELF.Diff_other_operating_prov_org_name,1,0)+ IF( SELF.Diff_other_operating_prov_last_name,1,0)+ IF( SELF.Diff_other_operating_prov_first_name,1,0)+ IF( SELF.Diff_other_operating_prov_middle_name,1,0)+ IF( SELF.Diff_other_operating_prov_npi,1,0)+ IF( SELF.Diff_other_operating_prov_state_lic,1,0)+ IF( SELF.Diff_other_operating_prov_upin,1,0)+ IF( SELF.Diff_other_operating_prov_commercial_id,1,0)+ IF( SELF.Diff_other_operating_prov_location,1,0)+ IF( SELF.Diff_pay_to_plan_name,1,0)+ IF( SELF.Diff_pay_to_plan_address1,1,0)+ IF( SELF.Diff_pay_to_plan_address2,1,0)+ IF( SELF.Diff_pay_to_plan_city,1,0)+ IF( SELF.Diff_pay_to_plan_zip,1,0)+ IF( SELF.Diff_pay_to_plan_state,1,0)+ IF( SELF.Diff_pay_to_plan_naic_id,1,0)+ IF( SELF.Diff_pay_to_plan_payer_id,1,0)+ IF( SELF.Diff_pay_to_plan_plan_id,1,0)+ IF( SELF.Diff_pay_to_plan_claim_ofc_num,1,0)+ IF( SELF.Diff_pay_to_plan_tax_id,1,0)+ IF( SELF.Diff_cob1_payer_name,1,0)+ IF( SELF.Diff_cob1_payer_id,1,0)+ IF( SELF.Diff_cob1_hpid,1,0)+ IF( SELF.Diff_cob1_resp_seq_code,1,0)+ IF( SELF.Diff_cob1_relationship_code,1,0)+ IF( SELF.Diff_cob1_group_policy_num,1,0)+ IF( SELF.Diff_cob1_group_name,1,0)+ IF( SELF.Diff_cob1_ins_type_code,1,0)+ IF( SELF.Diff_cob1_claim_filing_indicator,1,0);
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
    Count_Diff_diag_code9 := COUNT(GROUP,%Closest%.Diff_diag_code9);
    Count_Diff_diag_code10 := COUNT(GROUP,%Closest%.Diff_diag_code10);
    Count_Diff_diag_code11 := COUNT(GROUP,%Closest%.Diff_diag_code11);
    Count_Diff_diag_code12 := COUNT(GROUP,%Closest%.Diff_diag_code12);
    Count_Diff_diag_code13 := COUNT(GROUP,%Closest%.Diff_diag_code13);
    Count_Diff_diag_code14 := COUNT(GROUP,%Closest%.Diff_diag_code14);
    Count_Diff_diag_code15 := COUNT(GROUP,%Closest%.Diff_diag_code15);
    Count_Diff_diag_code16 := COUNT(GROUP,%Closest%.Diff_diag_code16);
    Count_Diff_diag_code17 := COUNT(GROUP,%Closest%.Diff_diag_code17);
    Count_Diff_diag_code18 := COUNT(GROUP,%Closest%.Diff_diag_code18);
    Count_Diff_diag_code19 := COUNT(GROUP,%Closest%.Diff_diag_code19);
    Count_Diff_diag_code20 := COUNT(GROUP,%Closest%.Diff_diag_code20);
    Count_Diff_diag_code21 := COUNT(GROUP,%Closest%.Diff_diag_code21);
    Count_Diff_diag_code22 := COUNT(GROUP,%Closest%.Diff_diag_code22);
    Count_Diff_diag_code23 := COUNT(GROUP,%Closest%.Diff_diag_code23);
    Count_Diff_diag_code24 := COUNT(GROUP,%Closest%.Diff_diag_code24);
    Count_Diff_other_proc7 := COUNT(GROUP,%Closest%.Diff_other_proc7);
    Count_Diff_other_proc8 := COUNT(GROUP,%Closest%.Diff_other_proc8);
    Count_Diff_other_proc9 := COUNT(GROUP,%Closest%.Diff_other_proc9);
    Count_Diff_other_proc10 := COUNT(GROUP,%Closest%.Diff_other_proc10);
    Count_Diff_other_proc11 := COUNT(GROUP,%Closest%.Diff_other_proc11);
    Count_Diff_other_proc12 := COUNT(GROUP,%Closest%.Diff_other_proc12);
    Count_Diff_other_proc13 := COUNT(GROUP,%Closest%.Diff_other_proc13);
    Count_Diff_other_proc14 := COUNT(GROUP,%Closest%.Diff_other_proc14);
    Count_Diff_other_proc15 := COUNT(GROUP,%Closest%.Diff_other_proc15);
    Count_Diff_other_proc16 := COUNT(GROUP,%Closest%.Diff_other_proc16);
    Count_Diff_other_proc17 := COUNT(GROUP,%Closest%.Diff_other_proc17);
    Count_Diff_other_proc18 := COUNT(GROUP,%Closest%.Diff_other_proc18);
    Count_Diff_other_proc19 := COUNT(GROUP,%Closest%.Diff_other_proc19);
    Count_Diff_other_proc20 := COUNT(GROUP,%Closest%.Diff_other_proc20);
    Count_Diff_other_proc21 := COUNT(GROUP,%Closest%.Diff_other_proc21);
    Count_Diff_other_proc22 := COUNT(GROUP,%Closest%.Diff_other_proc22);
    Count_Diff_claim_indicator_code := COUNT(GROUP,%Closest%.Diff_claim_indicator_code);
    Count_Diff_ref_prov_state_lic := COUNT(GROUP,%Closest%.Diff_ref_prov_state_lic);
    Count_Diff_ref_prov_upin := COUNT(GROUP,%Closest%.Diff_ref_prov_upin);
    Count_Diff_ref_prov_commercial_id := COUNT(GROUP,%Closest%.Diff_ref_prov_commercial_id);
    Count_Diff_pay_to_address1 := COUNT(GROUP,%Closest%.Diff_pay_to_address1);
    Count_Diff_pay_to_address2 := COUNT(GROUP,%Closest%.Diff_pay_to_address2);
    Count_Diff_pay_to_city := COUNT(GROUP,%Closest%.Diff_pay_to_city);
    Count_Diff_pay_to_zip := COUNT(GROUP,%Closest%.Diff_pay_to_zip);
    Count_Diff_pay_to_state := COUNT(GROUP,%Closest%.Diff_pay_to_state);
    Count_Diff_supervising_prov_org_name := COUNT(GROUP,%Closest%.Diff_supervising_prov_org_name);
    Count_Diff_supervising_prov_last_name := COUNT(GROUP,%Closest%.Diff_supervising_prov_last_name);
    Count_Diff_supervising_prov_first_name := COUNT(GROUP,%Closest%.Diff_supervising_prov_first_name);
    Count_Diff_supervising_prov_middle_name := COUNT(GROUP,%Closest%.Diff_supervising_prov_middle_name);
    Count_Diff_supervising_prov_npi := COUNT(GROUP,%Closest%.Diff_supervising_prov_npi);
    Count_Diff_supervising_prov_state_lic := COUNT(GROUP,%Closest%.Diff_supervising_prov_state_lic);
    Count_Diff_supervising_prov_upin := COUNT(GROUP,%Closest%.Diff_supervising_prov_upin);
    Count_Diff_supervising_prov_commercial_id := COUNT(GROUP,%Closest%.Diff_supervising_prov_commercial_id);
    Count_Diff_supervising_prov_location := COUNT(GROUP,%Closest%.Diff_supervising_prov_location);
    Count_Diff_operating_prov_org_name := COUNT(GROUP,%Closest%.Diff_operating_prov_org_name);
    Count_Diff_operating_prov_last_name := COUNT(GROUP,%Closest%.Diff_operating_prov_last_name);
    Count_Diff_operating_prov_first_name := COUNT(GROUP,%Closest%.Diff_operating_prov_first_name);
    Count_Diff_operating_prov_middle_name := COUNT(GROUP,%Closest%.Diff_operating_prov_middle_name);
    Count_Diff_operating_prov_npi := COUNT(GROUP,%Closest%.Diff_operating_prov_npi);
    Count_Diff_operating_prov_state_lic := COUNT(GROUP,%Closest%.Diff_operating_prov_state_lic);
    Count_Diff_operating_prov_upin := COUNT(GROUP,%Closest%.Diff_operating_prov_upin);
    Count_Diff_operating_prov_commercial_id := COUNT(GROUP,%Closest%.Diff_operating_prov_commercial_id);
    Count_Diff_operating_prov_location := COUNT(GROUP,%Closest%.Diff_operating_prov_location);
    Count_Diff_other_operating_prov_org_name := COUNT(GROUP,%Closest%.Diff_other_operating_prov_org_name);
    Count_Diff_other_operating_prov_last_name := COUNT(GROUP,%Closest%.Diff_other_operating_prov_last_name);
    Count_Diff_other_operating_prov_first_name := COUNT(GROUP,%Closest%.Diff_other_operating_prov_first_name);
    Count_Diff_other_operating_prov_middle_name := COUNT(GROUP,%Closest%.Diff_other_operating_prov_middle_name);
    Count_Diff_other_operating_prov_npi := COUNT(GROUP,%Closest%.Diff_other_operating_prov_npi);
    Count_Diff_other_operating_prov_state_lic := COUNT(GROUP,%Closest%.Diff_other_operating_prov_state_lic);
    Count_Diff_other_operating_prov_upin := COUNT(GROUP,%Closest%.Diff_other_operating_prov_upin);
    Count_Diff_other_operating_prov_commercial_id := COUNT(GROUP,%Closest%.Diff_other_operating_prov_commercial_id);
    Count_Diff_other_operating_prov_location := COUNT(GROUP,%Closest%.Diff_other_operating_prov_location);
    Count_Diff_pay_to_plan_name := COUNT(GROUP,%Closest%.Diff_pay_to_plan_name);
    Count_Diff_pay_to_plan_address1 := COUNT(GROUP,%Closest%.Diff_pay_to_plan_address1);
    Count_Diff_pay_to_plan_address2 := COUNT(GROUP,%Closest%.Diff_pay_to_plan_address2);
    Count_Diff_pay_to_plan_city := COUNT(GROUP,%Closest%.Diff_pay_to_plan_city);
    Count_Diff_pay_to_plan_zip := COUNT(GROUP,%Closest%.Diff_pay_to_plan_zip);
    Count_Diff_pay_to_plan_state := COUNT(GROUP,%Closest%.Diff_pay_to_plan_state);
    Count_Diff_pay_to_plan_naic_id := COUNT(GROUP,%Closest%.Diff_pay_to_plan_naic_id);
    Count_Diff_pay_to_plan_payer_id := COUNT(GROUP,%Closest%.Diff_pay_to_plan_payer_id);
    Count_Diff_pay_to_plan_plan_id := COUNT(GROUP,%Closest%.Diff_pay_to_plan_plan_id);
    Count_Diff_pay_to_plan_claim_ofc_num := COUNT(GROUP,%Closest%.Diff_pay_to_plan_claim_ofc_num);
    Count_Diff_pay_to_plan_tax_id := COUNT(GROUP,%Closest%.Diff_pay_to_plan_tax_id);
    Count_Diff_cob1_payer_name := COUNT(GROUP,%Closest%.Diff_cob1_payer_name);
    Count_Diff_cob1_payer_id := COUNT(GROUP,%Closest%.Diff_cob1_payer_id);
    Count_Diff_cob1_hpid := COUNT(GROUP,%Closest%.Diff_cob1_hpid);
    Count_Diff_cob1_resp_seq_code := COUNT(GROUP,%Closest%.Diff_cob1_resp_seq_code);
    Count_Diff_cob1_relationship_code := COUNT(GROUP,%Closest%.Diff_cob1_relationship_code);
    Count_Diff_cob1_group_policy_num := COUNT(GROUP,%Closest%.Diff_cob1_group_policy_num);
    Count_Diff_cob1_group_name := COUNT(GROUP,%Closest%.Diff_cob1_group_name);
    Count_Diff_cob1_ins_type_code := COUNT(GROUP,%Closest%.Diff_cob1_ins_type_code);
    Count_Diff_cob1_claim_filing_indicator := COUNT(GROUP,%Closest%.Diff_cob1_claim_filing_indicator);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
