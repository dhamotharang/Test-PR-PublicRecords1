IMPORT SALT311;
EXPORT Fields := MODULE
 
EXPORT NumFields := 44;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'DEFAULT','ALPHA','NAME','NUMBER','ALPHANUM','WORDBAG','lex_id','product_id','inquiry_date','transaction_id','date_added','customer_number','customer_account','ssn','drivers_license_number','drivers_license_state','name_first','name_last','name_middle','name_suffix','addr_street','addr_city','addr_state','addr_zip5','addr_zip4','dob','transaction_location','ppc','internal_identifier','eu1_customer_number','eu1_customer_account','eu2_customer_number','eu2_customer_account','email_addr','ip_address','state_id_number','state_id_state','eu_company_name','eu_addr_street','eu_addr_city','eu_addr_state','eu_addr_zip5','eu_phone_nbr','product_code','transaction_type','function_name','customer_id','company_id','global_company_id','phone_nbr');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'DEFAULT' => 1,'ALPHA' => 2,'NAME' => 3,'NUMBER' => 4,'ALPHANUM' => 5,'WORDBAG' => 6,'lex_id' => 7,'product_id' => 8,'inquiry_date' => 9,'transaction_id' => 10,'date_added' => 11,'customer_number' => 12,'customer_account' => 13,'ssn' => 14,'drivers_license_number' => 15,'drivers_license_state' => 16,'name_first' => 17,'name_last' => 18,'name_middle' => 19,'name_suffix' => 20,'addr_street' => 21,'addr_city' => 22,'addr_state' => 23,'addr_zip5' => 24,'addr_zip4' => 25,'dob' => 26,'transaction_location' => 27,'ppc' => 28,'internal_identifier' => 29,'eu1_customer_number' => 30,'eu1_customer_account' => 31,'eu2_customer_number' => 32,'eu2_customer_account' => 33,'email_addr' => 34,'ip_address' => 35,'state_id_number' => 36,'state_id_state' => 37,'eu_company_name' => 38,'eu_addr_street' => 39,'eu_addr_city' => 40,'eu_addr_state' => 41,'eu_addr_zip5' => 42,'eu_phone_nbr' => 43,'product_code' => 44,'transaction_type' => 45,'function_name' => 46,'customer_id' => 47,'company_id' => 48,'global_company_id' => 49,'phone_nbr' => 50,0);
 
EXPORT MakeFT_DEFAULT(SALT311.StrType s0) := FUNCTION
  s1 := if ( SALT311.StringFind('"\'',s0[1],1)>0 and SALT311.StringFind('"\'',s0[LENGTH(TRIM(s0))],1)>0,s0[2..LENGTH(TRIM(s0))-1],s0 );// Remove quotes if required
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_DEFAULT(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,SALT311.StringFind('"\'',s[1],1)<>0 and SALT311.StringFind('"\'',s[LENGTH(TRIM(s))],1)<>0);
EXPORT InValidMessageFT_DEFAULT(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.Inquotes('"\''),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_ALPHA(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_ALPHA(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_ALPHA(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_NAME(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'.'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_NAME(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'.'))));
EXPORT InValidMessageFT_NAME(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'.'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_NUMBER(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_NUMBER(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_NUMBER(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_ALPHANUM(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_ALPHANUM(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'))));
EXPORT InValidMessageFT_ALPHANUM(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_WORDBAG(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_WORDBAG(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '))));
EXPORT InValidMessageFT_WORDBAG(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$; '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_lex_id(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lex_id(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 7),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_lex_id(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('12,10,9,11,8,7'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_product_id(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'12 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_product_id(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'12 '))),~(LENGTH(TRIM(s)) = 1),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_product_id(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('12 '),SALT311.HygieneErrors.NotLength('1'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_inquiry_date(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' -0123456789: '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_inquiry_date(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' -0123456789: '))),~(LENGTH(TRIM(s)) = 19),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_inquiry_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars(' -0123456789: '),SALT311.HygieneErrors.NotLength('19'),SALT311.HygieneErrors.NotWords('2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_transaction_id(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789R '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_transaction_id(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789R '))),~(LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 15),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_transaction_id(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789R '),SALT311.HygieneErrors.NotLength('16,15'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_date_added(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' -0123456789: '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_date_added(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' -0123456789: '))),~(LENGTH(TRIM(s)) = 19),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_date_added(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars(' -0123456789: '),SALT311.HygieneErrors.NotLength('19'),SALT311.HygieneErrors.NotWords('2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_customer_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_customer_number(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_customer_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('2'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_customer_account(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_customer_account(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_customer_account(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('2'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_ssn(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_ssn(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('9,4,2'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_drivers_license_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_drivers_license_number(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 6),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_drivers_license_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('2,8,9,13,10,7,12,15,14,11,17,6'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_drivers_license_state(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_drivers_license_state(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_drivers_license_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('2'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_name_first(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_name_first(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 14),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_name_first(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('6,7,5,4,8,9,3,11,10,2,1,12,13,15,14'),SALT311.HygieneErrors.NotWords('1,2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_name_last(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_name_last(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 18),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 2 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_name_last(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('6,5,7,8,4,9,10,3,11,12,2,13,14,15,16,17,1,18'),SALT311.HygieneErrors.NotWords('1,2,3'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_name_middle(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_name_middle(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 3),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_name_middle(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('2,1,6,7,5,4,8,9,3'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_name_suffix(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_name_suffix(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_name_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('2'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_addr_street(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_addr_street(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 21 OR LENGTH(TRIM(s)) = 22 OR LENGTH(TRIM(s)) = 23 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 24 OR LENGTH(TRIM(s)) = 25 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 26 OR LENGTH(TRIM(s)) = 27 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 28 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 29 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 30 OR LENGTH(TRIM(s)) = 31 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 32 OR LENGTH(TRIM(s)) = 33 OR LENGTH(TRIM(s)) = 34 OR LENGTH(TRIM(s)) = 35 OR LENGTH(TRIM(s)) = 36 OR LENGTH(TRIM(s)) = 38 OR LENGTH(TRIM(s)) = 37 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 39 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 40 OR LENGTH(TRIM(s)) = 41 OR LENGTH(TRIM(s)) = 43),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 3 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 4 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 0 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 5 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 6 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 2 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 7 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 8));
EXPORT InValidMessageFT_addr_street(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('0,15,16,17,14,18,13,19,20,12,21,22,23,11,24,25,10,26,27,9,28,8,6,7,4,29,5,30,31,3,32,33,34,35,36,38,37,2,39,1,40,41,43'),SALT311.HygieneErrors.NotWords('3,4,0,5,1,6,2,7,8'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_addr_city(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_addr_city(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 19),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 2 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_addr_city(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('2,7,9,8,6,10,11,12,5,13,14,4,15,16,17,18,3,19'),SALT311.HygieneErrors.NotWords('1,2,3'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_addr_state(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_addr_state(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_addr_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('2'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_addr_zip5(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_addr_zip5(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 4),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_addr_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('5,2,4'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_addr_zip4(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_addr_zip4(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_addr_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('2'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_dob(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_dob(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('10,2'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_transaction_location(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_transaction_location(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 8),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_transaction_location(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('13,8'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_ppc(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_ppc(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_ppc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('3,1,0'),SALT311.HygieneErrors.NotWords('1,0'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_internal_identifier(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_internal_identifier(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 1),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_internal_identifier(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('1'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_eu1_customer_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_eu1_customer_number(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_eu1_customer_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('2'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_eu1_customer_account(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_eu1_customer_account(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_eu1_customer_account(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('2'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_eu2_customer_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_eu2_customer_number(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_eu2_customer_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('2'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_eu2_customer_account(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_eu2_customer_account(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_eu2_customer_account(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('2'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_email_addr(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_email_addr(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 18),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_email_addr(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('2,20,19,18'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_ip_address(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_ip_address(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 39 OR LENGTH(TRIM(s)) = 38),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_ip_address(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('2,13,14,12,39,38'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_state_id_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_state_id_number(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_state_id_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('2'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_state_id_state(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_state_id_state(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_state_id_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('2'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_eu_company_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_eu_company_name(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 27 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 23 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 26 OR LENGTH(TRIM(s)) = 22 OR LENGTH(TRIM(s)) = 37 OR LENGTH(TRIM(s)) = 24 OR LENGTH(TRIM(s)) = 29 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 38 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 28 OR LENGTH(TRIM(s)) = 32 OR LENGTH(TRIM(s)) = 21 OR LENGTH(TRIM(s)) = 34 OR LENGTH(TRIM(s)) = 41 OR LENGTH(TRIM(s)) = 30 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 45 OR LENGTH(TRIM(s)) = 40 OR LENGTH(TRIM(s)) = 31 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 36 OR LENGTH(TRIM(s)) = 25 OR LENGTH(TRIM(s)) = 35 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 33),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 2 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 4 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 3 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 5 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 6 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 8 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 7));
EXPORT InValidMessageFT_eu_company_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('2,13,6,10,27,15,7,3,9,11,19,23,17,26,22,37,24,29,16,8,38,12,5,28,32,21,34,41,30,20,45,40,31,14,36,25,35,18,33'),SALT311.HygieneErrors.NotWords('1,2,4,3,5,6,8,7'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_eu_addr_street(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_eu_addr_street(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 20 OR LENGTH(TRIM(s)) = 17 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 29 OR LENGTH(TRIM(s)) = 22 OR LENGTH(TRIM(s)) = 30 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 21 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 28 OR LENGTH(TRIM(s)) = 24 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 26 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 23 OR LENGTH(TRIM(s)) = 25 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 27 OR LENGTH(TRIM(s)) = 36),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 4 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 3 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 5 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 6 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 2 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 0));
EXPORT InValidMessageFT_eu_addr_street(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('2,20,17,13,19,16,29,22,30,14,21,18,28,24,5,10,15,26,11,23,25,12,0,9,27,36'),SALT311.HygieneErrors.NotWords('1,4,3,5,6,2,0'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_eu_addr_city(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_eu_addr_city(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 4),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 2 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_eu_addr_city(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('2,7,9,10,8,12,6,13,11,15,5,14,4'),SALT311.HygieneErrors.NotWords('1,2,3'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_eu_addr_state(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_eu_addr_state(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_eu_addr_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('2'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_eu_addr_zip5(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_eu_addr_zip5(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 5),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_eu_addr_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('2,5'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_eu_phone_nbr(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_eu_phone_nbr(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 10),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_eu_phone_nbr(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('2,10'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_product_code(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_product_code(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 3),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_product_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('3'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_transaction_type(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_transaction_type(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 1),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_transaction_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('1'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_function_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_function_name(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 13),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_function_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('16,9,11,13'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_customer_id(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_customer_id(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 11 OR LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 13 OR LENGTH(TRIM(s)) = 14 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 15 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 17),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_customer_id(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('11,12,8,10,9,13,14,16,7,15,18,17'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_company_id(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_company_id(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_company_id(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('6,7'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_global_company_id(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_global_company_id(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_global_company_id(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('7,5,8,2'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_phone_nbr(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_phone_nbr(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_phone_nbr(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('10,2'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'lex_id','product_id','inquiry_date','transaction_id','date_added','customer_number','customer_account','ssn','drivers_license_number','drivers_license_state','name_first','name_last','name_middle','name_suffix','addr_street','addr_city','addr_state','addr_zip5','addr_zip4','dob','transaction_location','ppc','internal_identifier','eu1_customer_number','eu1_customer_account','eu2_customer_number','eu2_customer_account','email_addr','ip_address','state_id_number','state_id_state','eu_company_name','eu_addr_street','eu_addr_city','eu_addr_state','eu_addr_zip5','eu_phone_nbr','product_code','transaction_type','function_name','customer_id','company_id','global_company_id','phone_nbr');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'lex_id','product_id','inquiry_date','transaction_id','date_added','customer_number','customer_account','ssn','drivers_license_number','drivers_license_state','name_first','name_last','name_middle','name_suffix','addr_street','addr_city','addr_state','addr_zip5','addr_zip4','dob','transaction_location','ppc','internal_identifier','eu1_customer_number','eu1_customer_account','eu2_customer_number','eu2_customer_account','email_addr','ip_address','state_id_number','state_id_state','eu_company_name','eu_addr_street','eu_addr_city','eu_addr_state','eu_addr_zip5','eu_phone_nbr','product_code','transaction_type','function_name','customer_id','company_id','global_company_id','phone_nbr');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'lex_id' => 0,'product_id' => 1,'inquiry_date' => 2,'transaction_id' => 3,'date_added' => 4,'customer_number' => 5,'customer_account' => 6,'ssn' => 7,'drivers_license_number' => 8,'drivers_license_state' => 9,'name_first' => 10,'name_last' => 11,'name_middle' => 12,'name_suffix' => 13,'addr_street' => 14,'addr_city' => 15,'addr_state' => 16,'addr_zip5' => 17,'addr_zip4' => 18,'dob' => 19,'transaction_location' => 20,'ppc' => 21,'internal_identifier' => 22,'eu1_customer_number' => 23,'eu1_customer_account' => 24,'eu2_customer_number' => 25,'eu2_customer_account' => 26,'email_addr' => 27,'ip_address' => 28,'state_id_number' => 29,'state_id_state' => 30,'eu_company_name' => 31,'eu_addr_street' => 32,'eu_addr_city' => 33,'eu_addr_state' => 34,'eu_addr_zip5' => 35,'eu_phone_nbr' => 36,'product_code' => 37,'transaction_type' => 38,'function_name' => 39,'customer_id' => 40,'company_id' => 41,'global_company_id' => 42,'phone_nbr' => 43,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','ALLOW','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],['LEFTTRIM','LENGTHS','WORDS'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_lex_id(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_lex_id(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_lex_id(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);
 
EXPORT Make_product_id(SALT311.StrType s0) := MakeFT_product_id(s0);
EXPORT InValid_product_id(SALT311.StrType s) := InValidFT_product_id(s);
EXPORT InValidMessage_product_id(UNSIGNED1 wh) := InValidMessageFT_product_id(wh);
 
EXPORT Make_inquiry_date(SALT311.StrType s0) := MakeFT_inquiry_date(s0);
EXPORT InValid_inquiry_date(SALT311.StrType s) := InValidFT_inquiry_date(s);
EXPORT InValidMessage_inquiry_date(UNSIGNED1 wh) := InValidMessageFT_inquiry_date(wh);
 
EXPORT Make_transaction_id(SALT311.StrType s0) := MakeFT_transaction_id(s0);
EXPORT InValid_transaction_id(SALT311.StrType s) := InValidFT_transaction_id(s);
EXPORT InValidMessage_transaction_id(UNSIGNED1 wh) := InValidMessageFT_transaction_id(wh);
 
EXPORT Make_date_added(SALT311.StrType s0) := MakeFT_date_added(s0);
EXPORT InValid_date_added(SALT311.StrType s) := InValidFT_date_added(s);
EXPORT InValidMessage_date_added(UNSIGNED1 wh) := InValidMessageFT_date_added(wh);
 
EXPORT Make_customer_number(SALT311.StrType s0) := MakeFT_customer_number(s0);
EXPORT InValid_customer_number(SALT311.StrType s) := InValidFT_customer_number(s);
EXPORT InValidMessage_customer_number(UNSIGNED1 wh) := InValidMessageFT_customer_number(wh);
 
EXPORT Make_customer_account(SALT311.StrType s0) := MakeFT_customer_account(s0);
EXPORT InValid_customer_account(SALT311.StrType s) := InValidFT_customer_account(s);
EXPORT InValidMessage_customer_account(UNSIGNED1 wh) := InValidMessageFT_customer_account(wh);
 
EXPORT Make_ssn(SALT311.StrType s0) := MakeFT_ssn(s0);
EXPORT InValid_ssn(SALT311.StrType s) := InValidFT_ssn(s);
EXPORT InValidMessage_ssn(UNSIGNED1 wh) := InValidMessageFT_ssn(wh);
 
EXPORT Make_drivers_license_number(SALT311.StrType s0) := MakeFT_drivers_license_number(s0);
EXPORT InValid_drivers_license_number(SALT311.StrType s) := InValidFT_drivers_license_number(s);
EXPORT InValidMessage_drivers_license_number(UNSIGNED1 wh) := InValidMessageFT_drivers_license_number(wh);
 
EXPORT Make_drivers_license_state(SALT311.StrType s0) := MakeFT_drivers_license_state(s0);
EXPORT InValid_drivers_license_state(SALT311.StrType s) := InValidFT_drivers_license_state(s);
EXPORT InValidMessage_drivers_license_state(UNSIGNED1 wh) := InValidMessageFT_drivers_license_state(wh);
 
EXPORT Make_name_first(SALT311.StrType s0) := MakeFT_name_first(s0);
EXPORT InValid_name_first(SALT311.StrType s) := InValidFT_name_first(s);
EXPORT InValidMessage_name_first(UNSIGNED1 wh) := InValidMessageFT_name_first(wh);
 
EXPORT Make_name_last(SALT311.StrType s0) := MakeFT_name_last(s0);
EXPORT InValid_name_last(SALT311.StrType s) := InValidFT_name_last(s);
EXPORT InValidMessage_name_last(UNSIGNED1 wh) := InValidMessageFT_name_last(wh);
 
EXPORT Make_name_middle(SALT311.StrType s0) := MakeFT_name_middle(s0);
EXPORT InValid_name_middle(SALT311.StrType s) := InValidFT_name_middle(s);
EXPORT InValidMessage_name_middle(UNSIGNED1 wh) := InValidMessageFT_name_middle(wh);
 
EXPORT Make_name_suffix(SALT311.StrType s0) := MakeFT_name_suffix(s0);
EXPORT InValid_name_suffix(SALT311.StrType s) := InValidFT_name_suffix(s);
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := InValidMessageFT_name_suffix(wh);
 
EXPORT Make_addr_street(SALT311.StrType s0) := MakeFT_addr_street(s0);
EXPORT InValid_addr_street(SALT311.StrType s) := InValidFT_addr_street(s);
EXPORT InValidMessage_addr_street(UNSIGNED1 wh) := InValidMessageFT_addr_street(wh);
 
EXPORT Make_addr_city(SALT311.StrType s0) := MakeFT_addr_city(s0);
EXPORT InValid_addr_city(SALT311.StrType s) := InValidFT_addr_city(s);
EXPORT InValidMessage_addr_city(UNSIGNED1 wh) := InValidMessageFT_addr_city(wh);
 
EXPORT Make_addr_state(SALT311.StrType s0) := MakeFT_addr_state(s0);
EXPORT InValid_addr_state(SALT311.StrType s) := InValidFT_addr_state(s);
EXPORT InValidMessage_addr_state(UNSIGNED1 wh) := InValidMessageFT_addr_state(wh);
 
EXPORT Make_addr_zip5(SALT311.StrType s0) := MakeFT_addr_zip5(s0);
EXPORT InValid_addr_zip5(SALT311.StrType s) := InValidFT_addr_zip5(s);
EXPORT InValidMessage_addr_zip5(UNSIGNED1 wh) := InValidMessageFT_addr_zip5(wh);
 
EXPORT Make_addr_zip4(SALT311.StrType s0) := MakeFT_addr_zip4(s0);
EXPORT InValid_addr_zip4(SALT311.StrType s) := InValidFT_addr_zip4(s);
EXPORT InValidMessage_addr_zip4(UNSIGNED1 wh) := InValidMessageFT_addr_zip4(wh);
 
EXPORT Make_dob(SALT311.StrType s0) := MakeFT_dob(s0);
EXPORT InValid_dob(SALT311.StrType s) := InValidFT_dob(s);
EXPORT InValidMessage_dob(UNSIGNED1 wh) := InValidMessageFT_dob(wh);
 
EXPORT Make_transaction_location(SALT311.StrType s0) := MakeFT_transaction_location(s0);
EXPORT InValid_transaction_location(SALT311.StrType s) := InValidFT_transaction_location(s);
EXPORT InValidMessage_transaction_location(UNSIGNED1 wh) := InValidMessageFT_transaction_location(wh);
 
EXPORT Make_ppc(SALT311.StrType s0) := MakeFT_ppc(s0);
EXPORT InValid_ppc(SALT311.StrType s) := InValidFT_ppc(s);
EXPORT InValidMessage_ppc(UNSIGNED1 wh) := InValidMessageFT_ppc(wh);
 
EXPORT Make_internal_identifier(SALT311.StrType s0) := MakeFT_internal_identifier(s0);
EXPORT InValid_internal_identifier(SALT311.StrType s) := InValidFT_internal_identifier(s);
EXPORT InValidMessage_internal_identifier(UNSIGNED1 wh) := InValidMessageFT_internal_identifier(wh);
 
EXPORT Make_eu1_customer_number(SALT311.StrType s0) := MakeFT_eu1_customer_number(s0);
EXPORT InValid_eu1_customer_number(SALT311.StrType s) := InValidFT_eu1_customer_number(s);
EXPORT InValidMessage_eu1_customer_number(UNSIGNED1 wh) := InValidMessageFT_eu1_customer_number(wh);
 
EXPORT Make_eu1_customer_account(SALT311.StrType s0) := MakeFT_eu1_customer_account(s0);
EXPORT InValid_eu1_customer_account(SALT311.StrType s) := InValidFT_eu1_customer_account(s);
EXPORT InValidMessage_eu1_customer_account(UNSIGNED1 wh) := InValidMessageFT_eu1_customer_account(wh);
 
EXPORT Make_eu2_customer_number(SALT311.StrType s0) := MakeFT_eu2_customer_number(s0);
EXPORT InValid_eu2_customer_number(SALT311.StrType s) := InValidFT_eu2_customer_number(s);
EXPORT InValidMessage_eu2_customer_number(UNSIGNED1 wh) := InValidMessageFT_eu2_customer_number(wh);
 
EXPORT Make_eu2_customer_account(SALT311.StrType s0) := MakeFT_eu2_customer_account(s0);
EXPORT InValid_eu2_customer_account(SALT311.StrType s) := InValidFT_eu2_customer_account(s);
EXPORT InValidMessage_eu2_customer_account(UNSIGNED1 wh) := InValidMessageFT_eu2_customer_account(wh);
 
EXPORT Make_email_addr(SALT311.StrType s0) := MakeFT_email_addr(s0);
EXPORT InValid_email_addr(SALT311.StrType s) := InValidFT_email_addr(s);
EXPORT InValidMessage_email_addr(UNSIGNED1 wh) := InValidMessageFT_email_addr(wh);
 
EXPORT Make_ip_address(SALT311.StrType s0) := MakeFT_ip_address(s0);
EXPORT InValid_ip_address(SALT311.StrType s) := InValidFT_ip_address(s);
EXPORT InValidMessage_ip_address(UNSIGNED1 wh) := InValidMessageFT_ip_address(wh);
 
EXPORT Make_state_id_number(SALT311.StrType s0) := MakeFT_state_id_number(s0);
EXPORT InValid_state_id_number(SALT311.StrType s) := InValidFT_state_id_number(s);
EXPORT InValidMessage_state_id_number(UNSIGNED1 wh) := InValidMessageFT_state_id_number(wh);
 
EXPORT Make_state_id_state(SALT311.StrType s0) := MakeFT_state_id_state(s0);
EXPORT InValid_state_id_state(SALT311.StrType s) := InValidFT_state_id_state(s);
EXPORT InValidMessage_state_id_state(UNSIGNED1 wh) := InValidMessageFT_state_id_state(wh);
 
EXPORT Make_eu_company_name(SALT311.StrType s0) := MakeFT_eu_company_name(s0);
EXPORT InValid_eu_company_name(SALT311.StrType s) := InValidFT_eu_company_name(s);
EXPORT InValidMessage_eu_company_name(UNSIGNED1 wh) := InValidMessageFT_eu_company_name(wh);
 
EXPORT Make_eu_addr_street(SALT311.StrType s0) := MakeFT_eu_addr_street(s0);
EXPORT InValid_eu_addr_street(SALT311.StrType s) := InValidFT_eu_addr_street(s);
EXPORT InValidMessage_eu_addr_street(UNSIGNED1 wh) := InValidMessageFT_eu_addr_street(wh);
 
EXPORT Make_eu_addr_city(SALT311.StrType s0) := MakeFT_eu_addr_city(s0);
EXPORT InValid_eu_addr_city(SALT311.StrType s) := InValidFT_eu_addr_city(s);
EXPORT InValidMessage_eu_addr_city(UNSIGNED1 wh) := InValidMessageFT_eu_addr_city(wh);
 
EXPORT Make_eu_addr_state(SALT311.StrType s0) := MakeFT_eu_addr_state(s0);
EXPORT InValid_eu_addr_state(SALT311.StrType s) := InValidFT_eu_addr_state(s);
EXPORT InValidMessage_eu_addr_state(UNSIGNED1 wh) := InValidMessageFT_eu_addr_state(wh);
 
EXPORT Make_eu_addr_zip5(SALT311.StrType s0) := MakeFT_eu_addr_zip5(s0);
EXPORT InValid_eu_addr_zip5(SALT311.StrType s) := InValidFT_eu_addr_zip5(s);
EXPORT InValidMessage_eu_addr_zip5(UNSIGNED1 wh) := InValidMessageFT_eu_addr_zip5(wh);
 
EXPORT Make_eu_phone_nbr(SALT311.StrType s0) := MakeFT_eu_phone_nbr(s0);
EXPORT InValid_eu_phone_nbr(SALT311.StrType s) := InValidFT_eu_phone_nbr(s);
EXPORT InValidMessage_eu_phone_nbr(UNSIGNED1 wh) := InValidMessageFT_eu_phone_nbr(wh);
 
EXPORT Make_product_code(SALT311.StrType s0) := MakeFT_product_code(s0);
EXPORT InValid_product_code(SALT311.StrType s) := InValidFT_product_code(s);
EXPORT InValidMessage_product_code(UNSIGNED1 wh) := InValidMessageFT_product_code(wh);
 
EXPORT Make_transaction_type(SALT311.StrType s0) := MakeFT_transaction_type(s0);
EXPORT InValid_transaction_type(SALT311.StrType s) := InValidFT_transaction_type(s);
EXPORT InValidMessage_transaction_type(UNSIGNED1 wh) := InValidMessageFT_transaction_type(wh);
 
EXPORT Make_function_name(SALT311.StrType s0) := MakeFT_function_name(s0);
EXPORT InValid_function_name(SALT311.StrType s) := InValidFT_function_name(s);
EXPORT InValidMessage_function_name(UNSIGNED1 wh) := InValidMessageFT_function_name(wh);
 
EXPORT Make_customer_id(SALT311.StrType s0) := MakeFT_customer_id(s0);
EXPORT InValid_customer_id(SALT311.StrType s) := InValidFT_customer_id(s);
EXPORT InValidMessage_customer_id(UNSIGNED1 wh) := InValidMessageFT_customer_id(wh);
 
EXPORT Make_company_id(SALT311.StrType s0) := MakeFT_company_id(s0);
EXPORT InValid_company_id(SALT311.StrType s) := InValidFT_company_id(s);
EXPORT InValidMessage_company_id(UNSIGNED1 wh) := InValidMessageFT_company_id(wh);
 
EXPORT Make_global_company_id(SALT311.StrType s0) := MakeFT_global_company_id(s0);
EXPORT InValid_global_company_id(SALT311.StrType s) := InValidFT_global_company_id(s);
EXPORT InValidMessage_global_company_id(UNSIGNED1 wh) := InValidMessageFT_global_company_id(wh);
 
EXPORT Make_phone_nbr(SALT311.StrType s0) := MakeFT_phone_nbr(s0);
EXPORT InValid_phone_nbr(SALT311.StrType s) := InValidFT_phone_nbr(s);
EXPORT InValidMessage_phone_nbr(UNSIGNED1 wh) := InValidMessageFT_phone_nbr(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Inquiry_History;
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
    BOOLEAN Diff_lex_id;
    BOOLEAN Diff_product_id;
    BOOLEAN Diff_inquiry_date;
    BOOLEAN Diff_transaction_id;
    BOOLEAN Diff_date_added;
    BOOLEAN Diff_customer_number;
    BOOLEAN Diff_customer_account;
    BOOLEAN Diff_ssn;
    BOOLEAN Diff_drivers_license_number;
    BOOLEAN Diff_drivers_license_state;
    BOOLEAN Diff_name_first;
    BOOLEAN Diff_name_last;
    BOOLEAN Diff_name_middle;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_addr_street;
    BOOLEAN Diff_addr_city;
    BOOLEAN Diff_addr_state;
    BOOLEAN Diff_addr_zip5;
    BOOLEAN Diff_addr_zip4;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_transaction_location;
    BOOLEAN Diff_ppc;
    BOOLEAN Diff_internal_identifier;
    BOOLEAN Diff_eu1_customer_number;
    BOOLEAN Diff_eu1_customer_account;
    BOOLEAN Diff_eu2_customer_number;
    BOOLEAN Diff_eu2_customer_account;
    BOOLEAN Diff_email_addr;
    BOOLEAN Diff_ip_address;
    BOOLEAN Diff_state_id_number;
    BOOLEAN Diff_state_id_state;
    BOOLEAN Diff_eu_company_name;
    BOOLEAN Diff_eu_addr_street;
    BOOLEAN Diff_eu_addr_city;
    BOOLEAN Diff_eu_addr_state;
    BOOLEAN Diff_eu_addr_zip5;
    BOOLEAN Diff_eu_phone_nbr;
    BOOLEAN Diff_product_code;
    BOOLEAN Diff_transaction_type;
    BOOLEAN Diff_function_name;
    BOOLEAN Diff_customer_id;
    BOOLEAN Diff_company_id;
    BOOLEAN Diff_global_company_id;
    BOOLEAN Diff_phone_nbr;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_lex_id := le.lex_id <> ri.lex_id;
    SELF.Diff_product_id := le.product_id <> ri.product_id;
    SELF.Diff_inquiry_date := le.inquiry_date <> ri.inquiry_date;
    SELF.Diff_transaction_id := le.transaction_id <> ri.transaction_id;
    SELF.Diff_date_added := le.date_added <> ri.date_added;
    SELF.Diff_customer_number := le.customer_number <> ri.customer_number;
    SELF.Diff_customer_account := le.customer_account <> ri.customer_account;
    SELF.Diff_ssn := le.ssn <> ri.ssn;
    SELF.Diff_drivers_license_number := le.drivers_license_number <> ri.drivers_license_number;
    SELF.Diff_drivers_license_state := le.drivers_license_state <> ri.drivers_license_state;
    SELF.Diff_name_first := le.name_first <> ri.name_first;
    SELF.Diff_name_last := le.name_last <> ri.name_last;
    SELF.Diff_name_middle := le.name_middle <> ri.name_middle;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_addr_street := le.addr_street <> ri.addr_street;
    SELF.Diff_addr_city := le.addr_city <> ri.addr_city;
    SELF.Diff_addr_state := le.addr_state <> ri.addr_state;
    SELF.Diff_addr_zip5 := le.addr_zip5 <> ri.addr_zip5;
    SELF.Diff_addr_zip4 := le.addr_zip4 <> ri.addr_zip4;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_transaction_location := le.transaction_location <> ri.transaction_location;
    SELF.Diff_ppc := le.ppc <> ri.ppc;
    SELF.Diff_internal_identifier := le.internal_identifier <> ri.internal_identifier;
    SELF.Diff_eu1_customer_number := le.eu1_customer_number <> ri.eu1_customer_number;
    SELF.Diff_eu1_customer_account := le.eu1_customer_account <> ri.eu1_customer_account;
    SELF.Diff_eu2_customer_number := le.eu2_customer_number <> ri.eu2_customer_number;
    SELF.Diff_eu2_customer_account := le.eu2_customer_account <> ri.eu2_customer_account;
    SELF.Diff_email_addr := le.email_addr <> ri.email_addr;
    SELF.Diff_ip_address := le.ip_address <> ri.ip_address;
    SELF.Diff_state_id_number := le.state_id_number <> ri.state_id_number;
    SELF.Diff_state_id_state := le.state_id_state <> ri.state_id_state;
    SELF.Diff_eu_company_name := le.eu_company_name <> ri.eu_company_name;
    SELF.Diff_eu_addr_street := le.eu_addr_street <> ri.eu_addr_street;
    SELF.Diff_eu_addr_city := le.eu_addr_city <> ri.eu_addr_city;
    SELF.Diff_eu_addr_state := le.eu_addr_state <> ri.eu_addr_state;
    SELF.Diff_eu_addr_zip5 := le.eu_addr_zip5 <> ri.eu_addr_zip5;
    SELF.Diff_eu_phone_nbr := le.eu_phone_nbr <> ri.eu_phone_nbr;
    SELF.Diff_product_code := le.product_code <> ri.product_code;
    SELF.Diff_transaction_type := le.transaction_type <> ri.transaction_type;
    SELF.Diff_function_name := le.function_name <> ri.function_name;
    SELF.Diff_customer_id := le.customer_id <> ri.customer_id;
    SELF.Diff_company_id := le.company_id <> ri.company_id;
    SELF.Diff_global_company_id := le.global_company_id <> ri.global_company_id;
    SELF.Diff_phone_nbr := le.phone_nbr <> ri.phone_nbr;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_lex_id,1,0)+ IF( SELF.Diff_product_id,1,0)+ IF( SELF.Diff_inquiry_date,1,0)+ IF( SELF.Diff_transaction_id,1,0)+ IF( SELF.Diff_date_added,1,0)+ IF( SELF.Diff_customer_number,1,0)+ IF( SELF.Diff_customer_account,1,0)+ IF( SELF.Diff_ssn,1,0)+ IF( SELF.Diff_drivers_license_number,1,0)+ IF( SELF.Diff_drivers_license_state,1,0)+ IF( SELF.Diff_name_first,1,0)+ IF( SELF.Diff_name_last,1,0)+ IF( SELF.Diff_name_middle,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_addr_street,1,0)+ IF( SELF.Diff_addr_city,1,0)+ IF( SELF.Diff_addr_state,1,0)+ IF( SELF.Diff_addr_zip5,1,0)+ IF( SELF.Diff_addr_zip4,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_transaction_location,1,0)+ IF( SELF.Diff_ppc,1,0)+ IF( SELF.Diff_internal_identifier,1,0)+ IF( SELF.Diff_eu1_customer_number,1,0)+ IF( SELF.Diff_eu1_customer_account,1,0)+ IF( SELF.Diff_eu2_customer_number,1,0)+ IF( SELF.Diff_eu2_customer_account,1,0)+ IF( SELF.Diff_email_addr,1,0)+ IF( SELF.Diff_ip_address,1,0)+ IF( SELF.Diff_state_id_number,1,0)+ IF( SELF.Diff_state_id_state,1,0)+ IF( SELF.Diff_eu_company_name,1,0)+ IF( SELF.Diff_eu_addr_street,1,0)+ IF( SELF.Diff_eu_addr_city,1,0)+ IF( SELF.Diff_eu_addr_state,1,0)+ IF( SELF.Diff_eu_addr_zip5,1,0)+ IF( SELF.Diff_eu_phone_nbr,1,0)+ IF( SELF.Diff_product_code,1,0)+ IF( SELF.Diff_transaction_type,1,0)+ IF( SELF.Diff_function_name,1,0)+ IF( SELF.Diff_customer_id,1,0)+ IF( SELF.Diff_company_id,1,0)+ IF( SELF.Diff_global_company_id,1,0)+ IF( SELF.Diff_phone_nbr,1,0);
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
    Count_Diff_lex_id := COUNT(GROUP,%Closest%.Diff_lex_id);
    Count_Diff_product_id := COUNT(GROUP,%Closest%.Diff_product_id);
    Count_Diff_inquiry_date := COUNT(GROUP,%Closest%.Diff_inquiry_date);
    Count_Diff_transaction_id := COUNT(GROUP,%Closest%.Diff_transaction_id);
    Count_Diff_date_added := COUNT(GROUP,%Closest%.Diff_date_added);
    Count_Diff_customer_number := COUNT(GROUP,%Closest%.Diff_customer_number);
    Count_Diff_customer_account := COUNT(GROUP,%Closest%.Diff_customer_account);
    Count_Diff_ssn := COUNT(GROUP,%Closest%.Diff_ssn);
    Count_Diff_drivers_license_number := COUNT(GROUP,%Closest%.Diff_drivers_license_number);
    Count_Diff_drivers_license_state := COUNT(GROUP,%Closest%.Diff_drivers_license_state);
    Count_Diff_name_first := COUNT(GROUP,%Closest%.Diff_name_first);
    Count_Diff_name_last := COUNT(GROUP,%Closest%.Diff_name_last);
    Count_Diff_name_middle := COUNT(GROUP,%Closest%.Diff_name_middle);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_addr_street := COUNT(GROUP,%Closest%.Diff_addr_street);
    Count_Diff_addr_city := COUNT(GROUP,%Closest%.Diff_addr_city);
    Count_Diff_addr_state := COUNT(GROUP,%Closest%.Diff_addr_state);
    Count_Diff_addr_zip5 := COUNT(GROUP,%Closest%.Diff_addr_zip5);
    Count_Diff_addr_zip4 := COUNT(GROUP,%Closest%.Diff_addr_zip4);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_transaction_location := COUNT(GROUP,%Closest%.Diff_transaction_location);
    Count_Diff_ppc := COUNT(GROUP,%Closest%.Diff_ppc);
    Count_Diff_internal_identifier := COUNT(GROUP,%Closest%.Diff_internal_identifier);
    Count_Diff_eu1_customer_number := COUNT(GROUP,%Closest%.Diff_eu1_customer_number);
    Count_Diff_eu1_customer_account := COUNT(GROUP,%Closest%.Diff_eu1_customer_account);
    Count_Diff_eu2_customer_number := COUNT(GROUP,%Closest%.Diff_eu2_customer_number);
    Count_Diff_eu2_customer_account := COUNT(GROUP,%Closest%.Diff_eu2_customer_account);
    Count_Diff_email_addr := COUNT(GROUP,%Closest%.Diff_email_addr);
    Count_Diff_ip_address := COUNT(GROUP,%Closest%.Diff_ip_address);
    Count_Diff_state_id_number := COUNT(GROUP,%Closest%.Diff_state_id_number);
    Count_Diff_state_id_state := COUNT(GROUP,%Closest%.Diff_state_id_state);
    Count_Diff_eu_company_name := COUNT(GROUP,%Closest%.Diff_eu_company_name);
    Count_Diff_eu_addr_street := COUNT(GROUP,%Closest%.Diff_eu_addr_street);
    Count_Diff_eu_addr_city := COUNT(GROUP,%Closest%.Diff_eu_addr_city);
    Count_Diff_eu_addr_state := COUNT(GROUP,%Closest%.Diff_eu_addr_state);
    Count_Diff_eu_addr_zip5 := COUNT(GROUP,%Closest%.Diff_eu_addr_zip5);
    Count_Diff_eu_phone_nbr := COUNT(GROUP,%Closest%.Diff_eu_phone_nbr);
    Count_Diff_product_code := COUNT(GROUP,%Closest%.Diff_product_code);
    Count_Diff_transaction_type := COUNT(GROUP,%Closest%.Diff_transaction_type);
    Count_Diff_function_name := COUNT(GROUP,%Closest%.Diff_function_name);
    Count_Diff_customer_id := COUNT(GROUP,%Closest%.Diff_customer_id);
    Count_Diff_company_id := COUNT(GROUP,%Closest%.Diff_company_id);
    Count_Diff_global_company_id := COUNT(GROUP,%Closest%.Diff_global_company_id);
    Count_Diff_phone_nbr := COUNT(GROUP,%Closest%.Diff_phone_nbr);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
