IMPORT ut,SALT34;
IMPORT Scrubs,Scrubs_GlobalWatchlists,Scrubs_Infutor_NARC; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT34.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_alpha','invalid_nums','invalid_alphanum','invalid_alphanumeric','invalid_country_name','invalid_address','invalid_id','invalid_gender','invalid_zipcode','invalid_zip','invalid_zip4','invalid_suffix','invalid_flag','invalid_name_type','invalid_aka_type','invalid_aka_category','invalid_giv_designator','invalid_entity_type','invalid_vessel_type','invalid_physique','invalid_complexion','invalid_race','invalid_denial','invalid_date','invalid_source','invalid_source_code','invalid_wgt_hgt','invalid_state_abbr','invalid_name','invalid_expire_dte','invalid_hair_color','invalid_vessel_flag');
EXPORT FieldTypeNum(SALT34.StrType fn) := CASE(fn,'invalid_alpha' => 1,'invalid_nums' => 2,'invalid_alphanum' => 3,'invalid_alphanumeric' => 4,'invalid_country_name' => 5,'invalid_address' => 6,'invalid_id' => 7,'invalid_gender' => 8,'invalid_zipcode' => 9,'invalid_zip' => 10,'invalid_zip4' => 11,'invalid_suffix' => 12,'invalid_flag' => 13,'invalid_name_type' => 14,'invalid_aka_type' => 15,'invalid_aka_category' => 16,'invalid_giv_designator' => 17,'invalid_entity_type' => 18,'invalid_vessel_type' => 19,'invalid_physique' => 20,'invalid_complexion' => 21,'invalid_race' => 22,'invalid_denial' => 23,'invalid_date' => 24,'invalid_source' => 25,'invalid_source_code' => 26,'invalid_wgt_hgt' => 27,'invalid_state_abbr' => 28,'invalid_name' => 29,'invalid_expire_dte' => 30,'invalid_hair_color' => 31,'invalid_vessel_flag' => 32,0);
 
EXPORT MakeFT_invalid_alpha(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-"&\'()./,# '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alpha(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-"&\'()./,# '))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-"&\'()./,# '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_nums(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_nums(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_invalid_nums(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanum(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz().-#/:\', +_'); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' +_',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alphanum(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz().-#/:\', +_'))));
EXPORT InValidMessageFT_invalid_alphanum(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz().-#/:\', +_'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanumeric(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789:;-.,@%&*()\'#/`$!_ <>{}[]^=+#?|"'); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' <>{}[]^=+#?|"',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alphanumeric(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789:;-.,@%&*()\'#/`$!_ <>{}[]^=+#?|"'))));
EXPORT InValidMessageFT_invalid_alphanumeric(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789:;-.,@%&*()\'#/`$!_ <>{}[]^=+#?|"'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_country_name(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz()/-&\'-.,: '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := if ( SALT34.StringFind('"',s2[1],1)>0 and SALT34.StringFind('"',s2[LENGTH(TRIM(s2))],1)>0,s2[2..LENGTH(TRIM(s2))-1],s2 );// Remove quotes if required
  RETURN  s3;
END;
EXPORT InValidFT_invalid_country_name(SALT34.StrType s) := WHICH(SALT34.StringFind('"',s[1],1)<>0 and SALT34.StringFind('"',s[LENGTH(TRIM(s))],1)<>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz()/-&\'-.,: '))));
EXPORT InValidMessageFT_invalid_country_name(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.Inquotes('"'),SALT34.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz()/-&\'-.,: '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_address(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'\',.#-&/:;-()"\\`@+0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_address(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'\',.#-&/:;-()"\\`@+0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))));
EXPORT InValidMessageFT_invalid_address(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('\',.#-&/:;-()"\\`@+0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_id(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789- '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_id(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789- '))));
EXPORT InValidMessageFT_invalid_id(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789- '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_gender(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_gender(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['M','F','O','']);
EXPORT InValidMessageFT_invalid_gender(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('M|F|O|'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zipcode(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-/, .'); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' .',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_zipcode(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-/, .'))));
EXPORT InValidMessageFT_invalid_zipcode(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-/, .'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_zip(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('0,5,9'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip4(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_zip4(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_invalid_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('0,4'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_suffix(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_suffix(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['SR','JR','I','II','III','IV','V','VI','VII','VIII','IX','X','8TH',' ']);
EXPORT InValidMessageFT_invalid_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('SR|JR|I|II|III|IV|V|VI|VII|VIII|IX|X|8TH| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_flag(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_flag(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['Y','N','']);
EXPORT InValidMessageFT_invalid_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('Y|N|'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name_type(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name_type(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['AKA','DBA','FKA','COUNTRY','ENTITY','Good AKA','Low AKA','PRIMARY','STRONG AKA','STRONG FKA','STRONG NKA','WEAK AKA','WEAK FKA',' ']);
EXPORT InValidMessageFT_invalid_name_type(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('AKA|DBA|FKA|COUNTRY|ENTITY|Good AKA|Low AKA|PRIMARY|STRONG AKA|STRONG FKA|STRONG NKA|WEAK AKA|WEAK FKA| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_aka_type(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_aka_type(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['A.K.A.','AKA','F.K.A.','FKA','N.K.A.','NKA','PRIME ALIAS','D.B.A.','DBA',' ']);
EXPORT InValidMessageFT_invalid_aka_type(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('A.K.A.|AKA|F.K.A.|FKA|N.K.A.|NKA|PRIME ALIAS|D.B.A.|DBA| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_aka_category(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_aka_category(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['GOOD AKA','LOW AKA','STRONG','Strong','WEAK','Weak',' ']);
EXPORT InValidMessageFT_invalid_aka_category(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('GOOD AKA|LOW AKA|STRONG|Strong|WEAK|Weak| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_giv_designator(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_giv_designator(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['A','G','I','V',' ']);
EXPORT InValidMessageFT_invalid_giv_designator(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('A|G|I|V| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_entity_type(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_entity_type(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['ENTITY','INDIVIDUAL','VESSEL','AIRCRAFT','Entity','Individual',' ']);
EXPORT InValidMessageFT_invalid_entity_type(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('ENTITY|INDIVIDUAL|VESSEL|AIRCRAFT|Entity|Individual| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_vessel_type(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_vessel_type(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['BULK CARRIER','CHEMICAL/PRODUCTS TANKER','CREW/SUPPLY VESSEL','CRUDE OIL TANKER','CRUDE/OIL PRODUCTS TANKER','GENERAL CARGO','LANDING CRAFT','LPG TANKER','OFFSHORE TUG/SUPPLY SHIP','PLATFORM SUPPLY SHIP','SHUTTLE TANKER','TANKER','TUG',' ']);
EXPORT InValidMessageFT_invalid_vessel_type(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('BULK CARRIER|CHEMICAL/PRODUCTS TANKER|CREW/SUPPLY VESSEL|CRUDE OIL TANKER|CRUDE/OIL PRODUCTS TANKER|GENERAL CARGO|LANDING CRAFT|LPG TANKER|OFFSHORE TUG/SUPPLY SHIP|PLATFORM SUPPLY SHIP|SHUTTLE TANKER|TANKER|TUG| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_physique(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_physique(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['MEDIUM','UNKNOWN','SLIM','STOCKY','AVERAGE','TALL, THIN','THIN','SLIGHT','SLENDER','MEDIUM TO LARGE','HEAVY','MEDIUM/STOCKY','SINEWY (THIN)',' ']);
EXPORT InValidMessageFT_invalid_physique(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('MEDIUM|UNKNOWN|SLIM|STOCKY|AVERAGE|TALL, THIN|THIN|SLIGHT|SLENDER|MEDIUM TO LARGE|HEAVY|MEDIUM/STOCKY|SINEWY (THIN)| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_complexion(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_complexion(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['LIGHT','OLIVE','DARK','MEDIUM','LIGHT-SKINNED','MEDIUM TO DARK','DARK/MEDIUM','']);
EXPORT InValidMessageFT_invalid_complexion(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('LIGHT|OLIVE|DARK|MEDIUM|LIGHT-SKINNED|MEDIUM TO DARK|DARK/MEDIUM|'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_race(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_race(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['WHITE','ASIAN','BLACK','WHITE (HISPANIC)','WHITE (MIDDLE EASTERN)','WHITE (PERSIAN)','WHITE (HISPANIC-DARK COMP','WHITE (CENTRAL ASIAN)','WHITE (ASIAN)','WHITE (INDIAN)','BLACK (HISPANIC)',' ']);
EXPORT InValidMessageFT_invalid_race(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('WHITE|ASIAN|BLACK|WHITE (HISPANIC)|WHITE (MIDDLE EASTERN)|WHITE (PERSIAN)|WHITE (HISPANIC-DARK COMP|WHITE (CENTRAL ASIAN)|WHITE (ASIAN)|WHITE (INDIAN)|BLACK (HISPANIC)| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_denial(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_denial(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['STANDARD','NON STANDARD','']);
EXPORT InValidMessageFT_invalid_denial(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('STANDARD|NON STANDARD|'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT34.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_source(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_source(SALT34.StrType s) := WHICH(~Scrubs_GlobalWatchlists.fn_valid_source(s)>0);
EXPORT InValidMessageFT_invalid_source(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_GlobalWatchlists.fn_valid_source'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_source_code(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789/-ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_source_code(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789/-ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))),~Scrubs_GlobalWatchlists.fn_valid_source_code(s)>0);
EXPORT InValidMessageFT_invalid_source_code(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789/-ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT34.HygieneErrors.CustomFail('Scrubs_GlobalWatchlists.fn_valid_source_code'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_wgt_hgt(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789UNKNOWNMETRKGLBAPXIunknownmetrkglbapxi.()- '); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_wgt_hgt(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789UNKNOWNMETRKGLBAPXIunknownmetrkglbapxi.()- '))));
EXPORT InValidMessageFT_invalid_wgt_hgt(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789UNKNOWNMETRKGLBAPXIunknownmetrkglbapxi.()- '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state_abbr(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s1;
END;
EXPORT InValidFT_invalid_state_abbr(SALT34.StrType s) := WHICH(~Scrubs_Infutor_NARC.fn_valid_state_abbr(s)>0);
EXPORT InValidMessageFT_invalid_state_abbr(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_Infutor_NARC.fn_valid_state_abbr'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name(SALT34.StrType s) := WHICH(~Scrubs_GlobalWatchlists.fn_valid_name(s)>0);
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_GlobalWatchlists.fn_valid_name'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_expire_dte(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s1;
END;
EXPORT InValidFT_invalid_expire_dte(SALT34.StrType s) := WHICH(~Scrubs_GlobalWatchlists.fn_valid_0468date(s)>0);
EXPORT InValidMessageFT_invalid_expire_dte(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_GlobalWatchlists.fn_valid_0468date'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_hair_color(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s1;
END;
EXPORT InValidFT_invalid_hair_color(SALT34.StrType s) := WHICH(~Scrubs_GlobalWatchlists.fn_valid_hair_color(s)>0);
EXPORT InValidMessageFT_invalid_hair_color(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_GlobalWatchlists.fn_valid_hair_color'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_vessel_flag(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s1;
END;
EXPORT InValidFT_invalid_vessel_flag(SALT34.StrType s) := WHICH(~Scrubs_GlobalWatchlists.fn_valid_vessel_flag(s)>0);
EXPORT InValidMessageFT_invalid_vessel_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_GlobalWatchlists.fn_valid_vessel_flag'),SALT34.HygieneErrors.Good);
 
EXPORT SALT34.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'pty_key','source','orig_pty_name','orig_vessel_name','country','name_type','addr_1','addr_2','addr_3','addr_4','addr_5','addr_6','addr_7','addr_8','addr_9','addr_10','remarks_1','remarks_2','remarks_3','remarks_4','remarks_5','remarks_6','remarks_7','remarks_8','remarks_9','remarks_10','remarks_11','remarks_12','remarks_13','remarks_14','remarks_15','remarks_16','remarks_17','remarks_18','remarks_19','remarks_20','remarks_21','remarks_22','remarks_23','remarks_24','remarks_25','remarks_26','remarks_27','remarks_28','remarks_29','remarks_30','cname','title','fname','mname','lname','suffix','a_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','record_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','entity_id','first_name','last_name','title_1','title_2','title_3','title_4','title_5','title_6','title_7','title_8','title_9','title_10','aka_id','aka_type','aka_category','giv_designator','entity_type','address_id','address_line_1','address_line_2','address_line_3','address_city','address_state_province','address_postal_code','address_country','remarks','call_sign','vessel_type','tonnage','gross_registered_tonnage','vessel_flag','vessel_owner','sanctions_program_1','sanctions_program_2','sanctions_program_3','sanctions_program_4','sanctions_program_5','sanctions_program_6','sanctions_program_7','sanctions_program_8','sanctions_program_9','sanctions_program_10','passport_details','ni_number_details','id_id_1','id_id_2','id_id_3','id_id_4','id_id_5','id_id_6','id_id_7','id_id_8','id_id_9','id_id_10','id_type_1','id_type_2','id_type_3','id_type_4','id_type_5','id_type_6','id_type_7','id_type_8','id_type_9','id_type_10','id_number_1','id_number_2','id_number_3','id_number_4','id_number_5','id_number_6','id_number_7','id_number_8','id_number_9','id_number_10','id_country_1','id_country_2','id_country_3','id_country_4','id_country_5','id_country_6','id_country_7','id_country_8','id_country_9','id_country_10','id_issue_date_1','id_issue_date_2','id_issue_date_3','id_issue_date_4','id_issue_date_5','id_issue_date_6','id_issue_date_7','id_issue_date_8','id_issue_date_9','id_issue_date_10','id_expiration_date_1','id_expiration_date_2','id_expiration_date_3','id_expiration_date_4','id_expiration_date_5','id_expiration_date_6','id_expiration_date_7','id_expiration_date_8','id_expiration_date_9','id_expiration_date_10','nationality_id_1','nationality_id_2','nationality_id_3','nationality_id_4','nationality_id_5','nationality_id_6','nationality_id_7','nationality_id_8','nationality_id_9','nationality_id_10','nationality_1','nationality_2','nationality_3','nationality_4','nationality_5','nationality_6','nationality_7','nationality_8','nationality_9','nationality_10','primary_nationality_flag_1','primary_nationality_flag_2','primary_nationality_flag_3','primary_nationality_flag_4','primary_nationality_flag_5','primary_nationality_flag_6','primary_nationality_flag_7','primary_nationality_flag_8','primary_nationality_flag_9','primary_nationality_flag_10','citizenship_id_1','citizenship_id_2','citizenship_id_3','citizenship_id_4','citizenship_id_5','citizenship_id_6','citizenship_id_7','citizenship_id_8','citizenship_id_9','citizenship_id_10','citizenship_1','citizenship_2','citizenship_3','citizenship_4','citizenship_5','citizenship_6','citizenship_7','citizenship_8','citizenship_9','citizenship_10','primary_citizenship_flag_1','primary_citizenship_flag_2','primary_citizenship_flag_3','primary_citizenship_flag_4','primary_citizenship_flag_5','primary_citizenship_flag_6','primary_citizenship_flag_7','primary_citizenship_flag_8','primary_citizenship_flag_9','primary_citizenship_flag_10','dob_id_1','dob_id_2','dob_id_3','dob_id_4','dob_id_5','dob_id_6','dob_id_7','dob_id_8','dob_id_9','dob_id_10','dob_1','dob_2','dob_3','dob_4','dob_5','dob_6','dob_7','dob_8','dob_9','dob_10','primary_dob_flag_1','primary_dob_flag_2','primary_dob_flag_3','primary_dob_flag_4','primary_dob_flag_5','primary_dob_flag_6','primary_dob_flag_7','primary_dob_flag_8','primary_dob_flag_9','primary_dob_flag_10','pob_id_1','pob_id_2','pob_id_3','pob_id_4','pob_id_5','pob_id_6','pob_id_7','pob_id_8','pob_id_9','pob_id_10','pob_1','pob_2','pob_3','pob_4','pob_5','pob_6','pob_7','pob_8','pob_9','pob_10','country_of_birth_1','country_of_birth_2','country_of_birth_3','country_of_birth_4','country_of_birth_5','country_of_birth_6','country_of_birth_7','country_of_birth_8','country_of_birth_9','country_of_birth_10','primary_pob_flag_1','primary_pob_flag_2','primary_pob_flag_3','primary_pob_flag_4','primary_pob_flag_5','primary_pob_flag_6','primary_pob_flag_7','primary_pob_flag_8','primary_pob_flag_9','primary_pob_flag_10','language_1','language_2','language_3','language_4','language_5','language_6','language_7','language_8','language_9','language_10','membership_1','membership_2','membership_3','membership_4','membership_5','membership_6','membership_7','membership_8','membership_9','membership_10','position_1','position_2','position_3','position_4','position_5','position_6','position_7','position_8','position_9','position_10','occupation_1','occupation_2','occupation_3','occupation_4','occupation_5','occupation_6','occupation_7','occupation_8','occupation_9','occupation_10','date_added_to_list','date_last_updated','effective_date','expiration_date','gender','grounds','subj_to_common_pos_2001_931_cfsp_fl','federal_register_citation_1','federal_register_citation_2','federal_register_citation_3','federal_register_citation_4','federal_register_citation_5','federal_register_citation_6','federal_register_citation_7','federal_register_citation_8','federal_register_citation_9','federal_register_citation_10','federal_register_citation_date_1','federal_register_citation_date_2','federal_register_citation_date_3','federal_register_citation_date_4','federal_register_citation_date_5','federal_register_citation_date_6','federal_register_citation_date_7','federal_register_citation_date_8','federal_register_citation_date_9','federal_register_citation_date_10','license_requirement','license_review_policy','subordinate_status','height','weight','physique','hair_color','eyes','complexion','race','scars_marks','photo_file','offenses','ncic','warrant_by','caution','reward','type_of_denial','linked_with_1','linked_with_2','linked_with_3','linked_with_4','linked_with_5','linked_with_6','linked_with_7','linked_with_8','linked_with_9','linked_with_10','linked_with_id_1','linked_with_id_2','linked_with_id_3','linked_with_id_4','linked_with_id_5','linked_with_id_6','linked_with_id_7','linked_with_id_8','linked_with_id_9','linked_with_id_10','listing_information','foreign_principal','nature_of_service','activities','finances','registrant_terminated_flag','foreign_principal_terminated_flag','short_form_terminated_flag','src_key');
EXPORT FieldNum(SALT34.StrType fn) := CASE(fn,'pty_key' => 0,'source' => 1,'orig_pty_name' => 2,'orig_vessel_name' => 3,'country' => 4,'name_type' => 5,'addr_1' => 6,'addr_2' => 7,'addr_3' => 8,'addr_4' => 9,'addr_5' => 10,'addr_6' => 11,'addr_7' => 12,'addr_8' => 13,'addr_9' => 14,'addr_10' => 15,'remarks_1' => 16,'remarks_2' => 17,'remarks_3' => 18,'remarks_4' => 19,'remarks_5' => 20,'remarks_6' => 21,'remarks_7' => 22,'remarks_8' => 23,'remarks_9' => 24,'remarks_10' => 25,'remarks_11' => 26,'remarks_12' => 27,'remarks_13' => 28,'remarks_14' => 29,'remarks_15' => 30,'remarks_16' => 31,'remarks_17' => 32,'remarks_18' => 33,'remarks_19' => 34,'remarks_20' => 35,'remarks_21' => 36,'remarks_22' => 37,'remarks_23' => 38,'remarks_24' => 39,'remarks_25' => 40,'remarks_26' => 41,'remarks_27' => 42,'remarks_28' => 43,'remarks_29' => 44,'remarks_30' => 45,'cname' => 46,'title' => 47,'fname' => 48,'mname' => 49,'lname' => 50,'suffix' => 51,'a_score' => 52,'prim_range' => 53,'predir' => 54,'prim_name' => 55,'addr_suffix' => 56,'postdir' => 57,'unit_desig' => 58,'sec_range' => 59,'p_city_name' => 60,'v_city_name' => 61,'st' => 62,'zip' => 63,'zip4' => 64,'cart' => 65,'cr_sort_sz' => 66,'lot' => 67,'lot_order' => 68,'dpbc' => 69,'chk_digit' => 70,'record_type' => 71,'ace_fips_st' => 72,'county' => 73,'geo_lat' => 74,'geo_long' => 75,'msa' => 76,'geo_blk' => 77,'geo_match' => 78,'err_stat' => 79,'date_first_seen' => 80,'date_last_seen' => 81,'date_vendor_first_reported' => 82,'date_vendor_last_reported' => 83,'entity_id' => 84,'first_name' => 85,'last_name' => 86,'title_1' => 87,'title_2' => 88,'title_3' => 89,'title_4' => 90,'title_5' => 91,'title_6' => 92,'title_7' => 93,'title_8' => 94,'title_9' => 95,'title_10' => 96,'aka_id' => 97,'aka_type' => 98,'aka_category' => 99,'giv_designator' => 100,'entity_type' => 101,'address_id' => 102,'address_line_1' => 103,'address_line_2' => 104,'address_line_3' => 105,'address_city' => 106,'address_state_province' => 107,'address_postal_code' => 108,'address_country' => 109,'remarks' => 110,'call_sign' => 111,'vessel_type' => 112,'tonnage' => 113,'gross_registered_tonnage' => 114,'vessel_flag' => 115,'vessel_owner' => 116,'sanctions_program_1' => 117,'sanctions_program_2' => 118,'sanctions_program_3' => 119,'sanctions_program_4' => 120,'sanctions_program_5' => 121,'sanctions_program_6' => 122,'sanctions_program_7' => 123,'sanctions_program_8' => 124,'sanctions_program_9' => 125,'sanctions_program_10' => 126,'passport_details' => 127,'ni_number_details' => 128,'id_id_1' => 129,'id_id_2' => 130,'id_id_3' => 131,'id_id_4' => 132,'id_id_5' => 133,'id_id_6' => 134,'id_id_7' => 135,'id_id_8' => 136,'id_id_9' => 137,'id_id_10' => 138,'id_type_1' => 139,'id_type_2' => 140,'id_type_3' => 141,'id_type_4' => 142,'id_type_5' => 143,'id_type_6' => 144,'id_type_7' => 145,'id_type_8' => 146,'id_type_9' => 147,'id_type_10' => 148,'id_number_1' => 149,'id_number_2' => 150,'id_number_3' => 151,'id_number_4' => 152,'id_number_5' => 153,'id_number_6' => 154,'id_number_7' => 155,'id_number_8' => 156,'id_number_9' => 157,'id_number_10' => 158,'id_country_1' => 159,'id_country_2' => 160,'id_country_3' => 161,'id_country_4' => 162,'id_country_5' => 163,'id_country_6' => 164,'id_country_7' => 165,'id_country_8' => 166,'id_country_9' => 167,'id_country_10' => 168,'id_issue_date_1' => 169,'id_issue_date_2' => 170,'id_issue_date_3' => 171,'id_issue_date_4' => 172,'id_issue_date_5' => 173,'id_issue_date_6' => 174,'id_issue_date_7' => 175,'id_issue_date_8' => 176,'id_issue_date_9' => 177,'id_issue_date_10' => 178,'id_expiration_date_1' => 179,'id_expiration_date_2' => 180,'id_expiration_date_3' => 181,'id_expiration_date_4' => 182,'id_expiration_date_5' => 183,'id_expiration_date_6' => 184,'id_expiration_date_7' => 185,'id_expiration_date_8' => 186,'id_expiration_date_9' => 187,'id_expiration_date_10' => 188,'nationality_id_1' => 189,'nationality_id_2' => 190,'nationality_id_3' => 191,'nationality_id_4' => 192,'nationality_id_5' => 193,'nationality_id_6' => 194,'nationality_id_7' => 195,'nationality_id_8' => 196,'nationality_id_9' => 197,'nationality_id_10' => 198,'nationality_1' => 199,'nationality_2' => 200,'nationality_3' => 201,'nationality_4' => 202,'nationality_5' => 203,'nationality_6' => 204,'nationality_7' => 205,'nationality_8' => 206,'nationality_9' => 207,'nationality_10' => 208,'primary_nationality_flag_1' => 209,'primary_nationality_flag_2' => 210,'primary_nationality_flag_3' => 211,'primary_nationality_flag_4' => 212,'primary_nationality_flag_5' => 213,'primary_nationality_flag_6' => 214,'primary_nationality_flag_7' => 215,'primary_nationality_flag_8' => 216,'primary_nationality_flag_9' => 217,'primary_nationality_flag_10' => 218,'citizenship_id_1' => 219,'citizenship_id_2' => 220,'citizenship_id_3' => 221,'citizenship_id_4' => 222,'citizenship_id_5' => 223,'citizenship_id_6' => 224,'citizenship_id_7' => 225,'citizenship_id_8' => 226,'citizenship_id_9' => 227,'citizenship_id_10' => 228,'citizenship_1' => 229,'citizenship_2' => 230,'citizenship_3' => 231,'citizenship_4' => 232,'citizenship_5' => 233,'citizenship_6' => 234,'citizenship_7' => 235,'citizenship_8' => 236,'citizenship_9' => 237,'citizenship_10' => 238,'primary_citizenship_flag_1' => 239,'primary_citizenship_flag_2' => 240,'primary_citizenship_flag_3' => 241,'primary_citizenship_flag_4' => 242,'primary_citizenship_flag_5' => 243,'primary_citizenship_flag_6' => 244,'primary_citizenship_flag_7' => 245,'primary_citizenship_flag_8' => 246,'primary_citizenship_flag_9' => 247,'primary_citizenship_flag_10' => 248,'dob_id_1' => 249,'dob_id_2' => 250,'dob_id_3' => 251,'dob_id_4' => 252,'dob_id_5' => 253,'dob_id_6' => 254,'dob_id_7' => 255,'dob_id_8' => 256,'dob_id_9' => 257,'dob_id_10' => 258,'dob_1' => 259,'dob_2' => 260,'dob_3' => 261,'dob_4' => 262,'dob_5' => 263,'dob_6' => 264,'dob_7' => 265,'dob_8' => 266,'dob_9' => 267,'dob_10' => 268,'primary_dob_flag_1' => 269,'primary_dob_flag_2' => 270,'primary_dob_flag_3' => 271,'primary_dob_flag_4' => 272,'primary_dob_flag_5' => 273,'primary_dob_flag_6' => 274,'primary_dob_flag_7' => 275,'primary_dob_flag_8' => 276,'primary_dob_flag_9' => 277,'primary_dob_flag_10' => 278,'pob_id_1' => 279,'pob_id_2' => 280,'pob_id_3' => 281,'pob_id_4' => 282,'pob_id_5' => 283,'pob_id_6' => 284,'pob_id_7' => 285,'pob_id_8' => 286,'pob_id_9' => 287,'pob_id_10' => 288,'pob_1' => 289,'pob_2' => 290,'pob_3' => 291,'pob_4' => 292,'pob_5' => 293,'pob_6' => 294,'pob_7' => 295,'pob_8' => 296,'pob_9' => 297,'pob_10' => 298,'country_of_birth_1' => 299,'country_of_birth_2' => 300,'country_of_birth_3' => 301,'country_of_birth_4' => 302,'country_of_birth_5' => 303,'country_of_birth_6' => 304,'country_of_birth_7' => 305,'country_of_birth_8' => 306,'country_of_birth_9' => 307,'country_of_birth_10' => 308,'primary_pob_flag_1' => 309,'primary_pob_flag_2' => 310,'primary_pob_flag_3' => 311,'primary_pob_flag_4' => 312,'primary_pob_flag_5' => 313,'primary_pob_flag_6' => 314,'primary_pob_flag_7' => 315,'primary_pob_flag_8' => 316,'primary_pob_flag_9' => 317,'primary_pob_flag_10' => 318,'language_1' => 319,'language_2' => 320,'language_3' => 321,'language_4' => 322,'language_5' => 323,'language_6' => 324,'language_7' => 325,'language_8' => 326,'language_9' => 327,'language_10' => 328,'membership_1' => 329,'membership_2' => 330,'membership_3' => 331,'membership_4' => 332,'membership_5' => 333,'membership_6' => 334,'membership_7' => 335,'membership_8' => 336,'membership_9' => 337,'membership_10' => 338,'position_1' => 339,'position_2' => 340,'position_3' => 341,'position_4' => 342,'position_5' => 343,'position_6' => 344,'position_7' => 345,'position_8' => 346,'position_9' => 347,'position_10' => 348,'occupation_1' => 349,'occupation_2' => 350,'occupation_3' => 351,'occupation_4' => 352,'occupation_5' => 353,'occupation_6' => 354,'occupation_7' => 355,'occupation_8' => 356,'occupation_9' => 357,'occupation_10' => 358,'date_added_to_list' => 359,'date_last_updated' => 360,'effective_date' => 361,'expiration_date' => 362,'gender' => 363,'grounds' => 364,'subj_to_common_pos_2001_931_cfsp_fl' => 365,'federal_register_citation_1' => 366,'federal_register_citation_2' => 367,'federal_register_citation_3' => 368,'federal_register_citation_4' => 369,'federal_register_citation_5' => 370,'federal_register_citation_6' => 371,'federal_register_citation_7' => 372,'federal_register_citation_8' => 373,'federal_register_citation_9' => 374,'federal_register_citation_10' => 375,'federal_register_citation_date_1' => 376,'federal_register_citation_date_2' => 377,'federal_register_citation_date_3' => 378,'federal_register_citation_date_4' => 379,'federal_register_citation_date_5' => 380,'federal_register_citation_date_6' => 381,'federal_register_citation_date_7' => 382,'federal_register_citation_date_8' => 383,'federal_register_citation_date_9' => 384,'federal_register_citation_date_10' => 385,'license_requirement' => 386,'license_review_policy' => 387,'subordinate_status' => 388,'height' => 389,'weight' => 390,'physique' => 391,'hair_color' => 392,'eyes' => 393,'complexion' => 394,'race' => 395,'scars_marks' => 396,'photo_file' => 397,'offenses' => 398,'ncic' => 399,'warrant_by' => 400,'caution' => 401,'reward' => 402,'type_of_denial' => 403,'linked_with_1' => 404,'linked_with_2' => 405,'linked_with_3' => 406,'linked_with_4' => 407,'linked_with_5' => 408,'linked_with_6' => 409,'linked_with_7' => 410,'linked_with_8' => 411,'linked_with_9' => 412,'linked_with_10' => 413,'linked_with_id_1' => 414,'linked_with_id_2' => 415,'linked_with_id_3' => 416,'linked_with_id_4' => 417,'linked_with_id_5' => 418,'linked_with_id_6' => 419,'linked_with_id_7' => 420,'linked_with_id_8' => 421,'linked_with_id_9' => 422,'linked_with_id_10' => 423,'listing_information' => 424,'foreign_principal' => 425,'nature_of_service' => 426,'activities' => 427,'finances' => 428,'registrant_terminated_flag' => 429,'foreign_principal_terminated_flag' => 430,'short_form_terminated_flag' => 431,'src_key' => 432,0);
 
//Individual field level validation
 
EXPORT Make_pty_key(SALT34.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_pty_key(SALT34.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_pty_key(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_source(SALT34.StrType s0) := MakeFT_invalid_source(s0);
EXPORT InValid_source(SALT34.StrType s) := InValidFT_invalid_source(s);
EXPORT InValidMessage_source(UNSIGNED1 wh) := InValidMessageFT_invalid_source(wh);
 
EXPORT Make_orig_pty_name(SALT34.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_orig_pty_name(SALT34.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_orig_pty_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_orig_vessel_name(SALT34.StrType s0) := MakeFT_invalid_alphanum(s0);
EXPORT InValid_orig_vessel_name(SALT34.StrType s) := InValidFT_invalid_alphanum(s);
EXPORT InValidMessage_orig_vessel_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum(wh);
 
EXPORT Make_country(SALT34.StrType s0) := MakeFT_invalid_country_name(s0);
EXPORT InValid_country(SALT34.StrType s) := InValidFT_invalid_country_name(s);
EXPORT InValidMessage_country(UNSIGNED1 wh) := InValidMessageFT_invalid_country_name(wh);
 
EXPORT Make_name_type(SALT34.StrType s0) := MakeFT_invalid_name_type(s0);
EXPORT InValid_name_type(SALT34.StrType s) := InValidFT_invalid_name_type(s);
EXPORT InValidMessage_name_type(UNSIGNED1 wh) := InValidMessageFT_invalid_name_type(wh);
 
EXPORT Make_addr_1(SALT34.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_1(SALT34.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_1(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_addr_2(SALT34.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_2(SALT34.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_2(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_addr_3(SALT34.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_3(SALT34.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_3(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_addr_4(SALT34.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_4(SALT34.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_4(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_addr_5(SALT34.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_5(SALT34.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_5(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_addr_6(SALT34.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_6(SALT34.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_6(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_addr_7(SALT34.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_7(SALT34.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_7(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_addr_8(SALT34.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_8(SALT34.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_8(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_addr_9(SALT34.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_9(SALT34.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_9(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_addr_10(SALT34.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_10(SALT34.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_10(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_remarks_1(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_1(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_2(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_2(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_3(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_3(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_4(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_4(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_4(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_5(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_5(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_5(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_6(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_6(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_6(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_7(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_7(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_7(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_8(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_8(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_8(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_9(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_9(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_9(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_10(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_10(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_10(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_11(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_11(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_11(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_12(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_12(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_12(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_13(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_13(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_13(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_14(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_14(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_14(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_15(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_15(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_15(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_16(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_16(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_16(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_17(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_17(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_17(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_18(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_18(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_18(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_19(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_19(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_19(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_20(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_20(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_20(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_21(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_21(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_21(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_22(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_22(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_22(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_23(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_23(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_23(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_24(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_24(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_24(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_25(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_25(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_25(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_26(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_26(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_26(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_27(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_27(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_27(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_28(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_28(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_28(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_29(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_29(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_29(UNSIGNED1 wh) := '';
 
EXPORT Make_remarks_30(SALT34.StrType s0) := s0;
EXPORT InValid_remarks_30(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks_30(UNSIGNED1 wh) := '';
 
EXPORT Make_cname(SALT34.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_cname(SALT34.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_cname(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_title(SALT34.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_title(SALT34.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_title(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_fname(SALT34.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_fname(SALT34.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_mname(SALT34.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_mname(SALT34.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_lname(SALT34.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_lname(SALT34.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_suffix(SALT34.StrType s0) := MakeFT_invalid_suffix(s0);
EXPORT InValid_suffix(SALT34.StrType s) := InValidFT_invalid_suffix(s);
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_suffix(wh);
 
EXPORT Make_a_score(SALT34.StrType s0) := s0;
EXPORT InValid_a_score(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_a_score(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT34.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_prim_range(SALT34.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_predir(SALT34.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_predir(SALT34.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_prim_name(SALT34.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_prim_name(SALT34.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_addr_suffix(SALT34.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_suffix(SALT34.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_postdir(SALT34.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_postdir(SALT34.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_unit_desig(SALT34.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_unit_desig(SALT34.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_sec_range(SALT34.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_sec_range(SALT34.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_p_city_name(SALT34.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_p_city_name(SALT34.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_v_city_name(SALT34.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_v_city_name(SALT34.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_st(SALT34.StrType s0) := MakeFT_invalid_state_abbr(s0);
EXPORT InValid_st(SALT34.StrType s) := InValidFT_invalid_state_abbr(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_invalid_state_abbr(wh);
 
EXPORT Make_zip(SALT34.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_zip(SALT34.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_zip4(SALT34.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_zip4(SALT34.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);
 
EXPORT Make_cart(SALT34.StrType s0) := s0;
EXPORT InValid_cart(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cart(UNSIGNED1 wh) := '';
 
EXPORT Make_cr_sort_sz(SALT34.StrType s0) := s0;
EXPORT InValid_cr_sort_sz(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := '';
 
EXPORT Make_lot(SALT34.StrType s0) := s0;
EXPORT InValid_lot(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_lot_order(SALT34.StrType s0) := s0;
EXPORT InValid_lot_order(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := '';
 
EXPORT Make_dpbc(SALT34.StrType s0) := s0;
EXPORT InValid_dpbc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dpbc(UNSIGNED1 wh) := '';
 
EXPORT Make_chk_digit(SALT34.StrType s0) := s0;
EXPORT InValid_chk_digit(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_record_type(SALT34.StrType s0) := s0;
EXPORT InValid_record_type(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := '';
 
EXPORT Make_ace_fips_st(SALT34.StrType s0) := s0;
EXPORT InValid_ace_fips_st(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_ace_fips_st(UNSIGNED1 wh) := '';
 
EXPORT Make_county(SALT34.StrType s0) := s0;
EXPORT InValid_county(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_county(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_lat(SALT34.StrType s0) := s0;
EXPORT InValid_geo_lat(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_long(SALT34.StrType s0) := s0;
EXPORT InValid_geo_long(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := '';
 
EXPORT Make_msa(SALT34.StrType s0) := s0;
EXPORT InValid_msa(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_msa(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_blk(SALT34.StrType s0) := s0;
EXPORT InValid_geo_blk(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_match(SALT34.StrType s0) := s0;
EXPORT InValid_geo_match(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := '';
 
EXPORT Make_err_stat(SALT34.StrType s0) := s0;
EXPORT InValid_err_stat(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := '';
 
EXPORT Make_date_first_seen(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_first_seen(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_date_last_seen(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_last_seen(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_date_vendor_first_reported(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_vendor_first_reported(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_date_vendor_last_reported(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_vendor_last_reported(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_entity_id(SALT34.StrType s0) := s0;
EXPORT InValid_entity_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_entity_id(UNSIGNED1 wh) := '';
 
EXPORT Make_first_name(SALT34.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_first_name(SALT34.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_first_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_last_name(SALT34.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_last_name(SALT34.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_last_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_title_1(SALT34.StrType s0) := s0;
EXPORT InValid_title_1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_title_1(UNSIGNED1 wh) := '';
 
EXPORT Make_title_2(SALT34.StrType s0) := s0;
EXPORT InValid_title_2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_title_2(UNSIGNED1 wh) := '';
 
EXPORT Make_title_3(SALT34.StrType s0) := s0;
EXPORT InValid_title_3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_title_3(UNSIGNED1 wh) := '';
 
EXPORT Make_title_4(SALT34.StrType s0) := s0;
EXPORT InValid_title_4(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_title_4(UNSIGNED1 wh) := '';
 
EXPORT Make_title_5(SALT34.StrType s0) := s0;
EXPORT InValid_title_5(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_title_5(UNSIGNED1 wh) := '';
 
EXPORT Make_title_6(SALT34.StrType s0) := s0;
EXPORT InValid_title_6(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_title_6(UNSIGNED1 wh) := '';
 
EXPORT Make_title_7(SALT34.StrType s0) := s0;
EXPORT InValid_title_7(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_title_7(UNSIGNED1 wh) := '';
 
EXPORT Make_title_8(SALT34.StrType s0) := s0;
EXPORT InValid_title_8(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_title_8(UNSIGNED1 wh) := '';
 
EXPORT Make_title_9(SALT34.StrType s0) := s0;
EXPORT InValid_title_9(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_title_9(UNSIGNED1 wh) := '';
 
EXPORT Make_title_10(SALT34.StrType s0) := s0;
EXPORT InValid_title_10(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_title_10(UNSIGNED1 wh) := '';
 
EXPORT Make_aka_id(SALT34.StrType s0) := s0;
EXPORT InValid_aka_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_aka_id(UNSIGNED1 wh) := '';
 
EXPORT Make_aka_type(SALT34.StrType s0) := MakeFT_invalid_aka_type(s0);
EXPORT InValid_aka_type(SALT34.StrType s) := InValidFT_invalid_aka_type(s);
EXPORT InValidMessage_aka_type(UNSIGNED1 wh) := InValidMessageFT_invalid_aka_type(wh);
 
EXPORT Make_aka_category(SALT34.StrType s0) := MakeFT_invalid_aka_category(s0);
EXPORT InValid_aka_category(SALT34.StrType s) := InValidFT_invalid_aka_category(s);
EXPORT InValidMessage_aka_category(UNSIGNED1 wh) := InValidMessageFT_invalid_aka_category(wh);
 
EXPORT Make_giv_designator(SALT34.StrType s0) := MakeFT_invalid_giv_designator(s0);
EXPORT InValid_giv_designator(SALT34.StrType s) := InValidFT_invalid_giv_designator(s);
EXPORT InValidMessage_giv_designator(UNSIGNED1 wh) := InValidMessageFT_invalid_giv_designator(wh);
 
EXPORT Make_entity_type(SALT34.StrType s0) := MakeFT_invalid_entity_type(s0);
EXPORT InValid_entity_type(SALT34.StrType s) := InValidFT_invalid_entity_type(s);
EXPORT InValidMessage_entity_type(UNSIGNED1 wh) := InValidMessageFT_invalid_entity_type(wh);
 
EXPORT Make_address_id(SALT34.StrType s0) := s0;
EXPORT InValid_address_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_address_id(UNSIGNED1 wh) := '';
 
EXPORT Make_address_line_1(SALT34.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_address_line_1(SALT34.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_address_line_1(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_address_line_2(SALT34.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_address_line_2(SALT34.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_address_line_2(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_address_line_3(SALT34.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_address_line_3(SALT34.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_address_line_3(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_address_city(SALT34.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_address_city(SALT34.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_address_city(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_address_state_province(SALT34.StrType s0) := MakeFT_invalid_alphanum(s0);
EXPORT InValid_address_state_province(SALT34.StrType s) := InValidFT_invalid_alphanum(s);
EXPORT InValidMessage_address_state_province(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum(wh);
 
EXPORT Make_address_postal_code(SALT34.StrType s0) := MakeFT_invalid_zipcode(s0);
EXPORT InValid_address_postal_code(SALT34.StrType s) := InValidFT_invalid_zipcode(s);
EXPORT InValidMessage_address_postal_code(UNSIGNED1 wh) := InValidMessageFT_invalid_zipcode(wh);
 
EXPORT Make_address_country(SALT34.StrType s0) := MakeFT_invalid_country_name(s0);
EXPORT InValid_address_country(SALT34.StrType s) := InValidFT_invalid_country_name(s);
EXPORT InValidMessage_address_country(UNSIGNED1 wh) := InValidMessageFT_invalid_country_name(wh);
 
EXPORT Make_remarks(SALT34.StrType s0) := s0;
EXPORT InValid_remarks(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_remarks(UNSIGNED1 wh) := '';
 
EXPORT Make_call_sign(SALT34.StrType s0) := s0;
EXPORT InValid_call_sign(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_call_sign(UNSIGNED1 wh) := '';
 
EXPORT Make_vessel_type(SALT34.StrType s0) := MakeFT_invalid_vessel_type(s0);
EXPORT InValid_vessel_type(SALT34.StrType s) := InValidFT_invalid_vessel_type(s);
EXPORT InValidMessage_vessel_type(UNSIGNED1 wh) := InValidMessageFT_invalid_vessel_type(wh);
 
EXPORT Make_tonnage(SALT34.StrType s0) := s0;
EXPORT InValid_tonnage(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_tonnage(UNSIGNED1 wh) := '';
 
EXPORT Make_gross_registered_tonnage(SALT34.StrType s0) := s0;
EXPORT InValid_gross_registered_tonnage(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_gross_registered_tonnage(UNSIGNED1 wh) := '';
 
EXPORT Make_vessel_flag(SALT34.StrType s0) := MakeFT_invalid_vessel_flag(s0);
EXPORT InValid_vessel_flag(SALT34.StrType s) := InValidFT_invalid_vessel_flag(s);
EXPORT InValidMessage_vessel_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_vessel_flag(wh);
 
EXPORT Make_vessel_owner(SALT34.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_vessel_owner(SALT34.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_vessel_owner(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_sanctions_program_1(SALT34.StrType s0) := s0;
EXPORT InValid_sanctions_program_1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_sanctions_program_1(UNSIGNED1 wh) := '';
 
EXPORT Make_sanctions_program_2(SALT34.StrType s0) := s0;
EXPORT InValid_sanctions_program_2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_sanctions_program_2(UNSIGNED1 wh) := '';
 
EXPORT Make_sanctions_program_3(SALT34.StrType s0) := s0;
EXPORT InValid_sanctions_program_3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_sanctions_program_3(UNSIGNED1 wh) := '';
 
EXPORT Make_sanctions_program_4(SALT34.StrType s0) := s0;
EXPORT InValid_sanctions_program_4(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_sanctions_program_4(UNSIGNED1 wh) := '';
 
EXPORT Make_sanctions_program_5(SALT34.StrType s0) := s0;
EXPORT InValid_sanctions_program_5(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_sanctions_program_5(UNSIGNED1 wh) := '';
 
EXPORT Make_sanctions_program_6(SALT34.StrType s0) := s0;
EXPORT InValid_sanctions_program_6(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_sanctions_program_6(UNSIGNED1 wh) := '';
 
EXPORT Make_sanctions_program_7(SALT34.StrType s0) := s0;
EXPORT InValid_sanctions_program_7(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_sanctions_program_7(UNSIGNED1 wh) := '';
 
EXPORT Make_sanctions_program_8(SALT34.StrType s0) := s0;
EXPORT InValid_sanctions_program_8(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_sanctions_program_8(UNSIGNED1 wh) := '';
 
EXPORT Make_sanctions_program_9(SALT34.StrType s0) := s0;
EXPORT InValid_sanctions_program_9(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_sanctions_program_9(UNSIGNED1 wh) := '';
 
EXPORT Make_sanctions_program_10(SALT34.StrType s0) := s0;
EXPORT InValid_sanctions_program_10(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_sanctions_program_10(UNSIGNED1 wh) := '';
 
EXPORT Make_passport_details(SALT34.StrType s0) := s0;
EXPORT InValid_passport_details(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_passport_details(UNSIGNED1 wh) := '';
 
EXPORT Make_ni_number_details(SALT34.StrType s0) := s0;
EXPORT InValid_ni_number_details(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_ni_number_details(UNSIGNED1 wh) := '';
 
EXPORT Make_id_id_1(SALT34.StrType s0) := s0;
EXPORT InValid_id_id_1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_id_1(UNSIGNED1 wh) := '';
 
EXPORT Make_id_id_2(SALT34.StrType s0) := s0;
EXPORT InValid_id_id_2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_id_2(UNSIGNED1 wh) := '';
 
EXPORT Make_id_id_3(SALT34.StrType s0) := s0;
EXPORT InValid_id_id_3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_id_3(UNSIGNED1 wh) := '';
 
EXPORT Make_id_id_4(SALT34.StrType s0) := s0;
EXPORT InValid_id_id_4(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_id_4(UNSIGNED1 wh) := '';
 
EXPORT Make_id_id_5(SALT34.StrType s0) := s0;
EXPORT InValid_id_id_5(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_id_5(UNSIGNED1 wh) := '';
 
EXPORT Make_id_id_6(SALT34.StrType s0) := s0;
EXPORT InValid_id_id_6(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_id_6(UNSIGNED1 wh) := '';
 
EXPORT Make_id_id_7(SALT34.StrType s0) := s0;
EXPORT InValid_id_id_7(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_id_7(UNSIGNED1 wh) := '';
 
EXPORT Make_id_id_8(SALT34.StrType s0) := s0;
EXPORT InValid_id_id_8(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_id_8(UNSIGNED1 wh) := '';
 
EXPORT Make_id_id_9(SALT34.StrType s0) := s0;
EXPORT InValid_id_id_9(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_id_9(UNSIGNED1 wh) := '';
 
EXPORT Make_id_id_10(SALT34.StrType s0) := s0;
EXPORT InValid_id_id_10(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_id_10(UNSIGNED1 wh) := '';
 
EXPORT Make_id_type_1(SALT34.StrType s0) := s0;
EXPORT InValid_id_type_1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_type_1(UNSIGNED1 wh) := '';
 
EXPORT Make_id_type_2(SALT34.StrType s0) := s0;
EXPORT InValid_id_type_2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_type_2(UNSIGNED1 wh) := '';
 
EXPORT Make_id_type_3(SALT34.StrType s0) := s0;
EXPORT InValid_id_type_3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_type_3(UNSIGNED1 wh) := '';
 
EXPORT Make_id_type_4(SALT34.StrType s0) := s0;
EXPORT InValid_id_type_4(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_type_4(UNSIGNED1 wh) := '';
 
EXPORT Make_id_type_5(SALT34.StrType s0) := s0;
EXPORT InValid_id_type_5(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_type_5(UNSIGNED1 wh) := '';
 
EXPORT Make_id_type_6(SALT34.StrType s0) := s0;
EXPORT InValid_id_type_6(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_type_6(UNSIGNED1 wh) := '';
 
EXPORT Make_id_type_7(SALT34.StrType s0) := s0;
EXPORT InValid_id_type_7(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_type_7(UNSIGNED1 wh) := '';
 
EXPORT Make_id_type_8(SALT34.StrType s0) := s0;
EXPORT InValid_id_type_8(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_type_8(UNSIGNED1 wh) := '';
 
EXPORT Make_id_type_9(SALT34.StrType s0) := s0;
EXPORT InValid_id_type_9(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_type_9(UNSIGNED1 wh) := '';
 
EXPORT Make_id_type_10(SALT34.StrType s0) := s0;
EXPORT InValid_id_type_10(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_type_10(UNSIGNED1 wh) := '';
 
EXPORT Make_id_number_1(SALT34.StrType s0) := s0;
EXPORT InValid_id_number_1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_number_1(UNSIGNED1 wh) := '';
 
EXPORT Make_id_number_2(SALT34.StrType s0) := s0;
EXPORT InValid_id_number_2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_number_2(UNSIGNED1 wh) := '';
 
EXPORT Make_id_number_3(SALT34.StrType s0) := s0;
EXPORT InValid_id_number_3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_number_3(UNSIGNED1 wh) := '';
 
EXPORT Make_id_number_4(SALT34.StrType s0) := s0;
EXPORT InValid_id_number_4(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_number_4(UNSIGNED1 wh) := '';
 
EXPORT Make_id_number_5(SALT34.StrType s0) := s0;
EXPORT InValid_id_number_5(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_number_5(UNSIGNED1 wh) := '';
 
EXPORT Make_id_number_6(SALT34.StrType s0) := s0;
EXPORT InValid_id_number_6(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_number_6(UNSIGNED1 wh) := '';
 
EXPORT Make_id_number_7(SALT34.StrType s0) := s0;
EXPORT InValid_id_number_7(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_number_7(UNSIGNED1 wh) := '';
 
EXPORT Make_id_number_8(SALT34.StrType s0) := s0;
EXPORT InValid_id_number_8(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_number_8(UNSIGNED1 wh) := '';
 
EXPORT Make_id_number_9(SALT34.StrType s0) := s0;
EXPORT InValid_id_number_9(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_number_9(UNSIGNED1 wh) := '';
 
EXPORT Make_id_number_10(SALT34.StrType s0) := s0;
EXPORT InValid_id_number_10(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_number_10(UNSIGNED1 wh) := '';
 
EXPORT Make_id_country_1(SALT34.StrType s0) := s0;
EXPORT InValid_id_country_1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_country_1(UNSIGNED1 wh) := '';
 
EXPORT Make_id_country_2(SALT34.StrType s0) := s0;
EXPORT InValid_id_country_2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_country_2(UNSIGNED1 wh) := '';
 
EXPORT Make_id_country_3(SALT34.StrType s0) := s0;
EXPORT InValid_id_country_3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_country_3(UNSIGNED1 wh) := '';
 
EXPORT Make_id_country_4(SALT34.StrType s0) := s0;
EXPORT InValid_id_country_4(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_country_4(UNSIGNED1 wh) := '';
 
EXPORT Make_id_country_5(SALT34.StrType s0) := s0;
EXPORT InValid_id_country_5(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_country_5(UNSIGNED1 wh) := '';
 
EXPORT Make_id_country_6(SALT34.StrType s0) := s0;
EXPORT InValid_id_country_6(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_country_6(UNSIGNED1 wh) := '';
 
EXPORT Make_id_country_7(SALT34.StrType s0) := s0;
EXPORT InValid_id_country_7(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_country_7(UNSIGNED1 wh) := '';
 
EXPORT Make_id_country_8(SALT34.StrType s0) := s0;
EXPORT InValid_id_country_8(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_country_8(UNSIGNED1 wh) := '';
 
EXPORT Make_id_country_9(SALT34.StrType s0) := s0;
EXPORT InValid_id_country_9(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_country_9(UNSIGNED1 wh) := '';
 
EXPORT Make_id_country_10(SALT34.StrType s0) := s0;
EXPORT InValid_id_country_10(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_id_country_10(UNSIGNED1 wh) := '';
 
EXPORT Make_id_issue_date_1(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_id_issue_date_1(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_id_issue_date_1(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_id_issue_date_2(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_id_issue_date_2(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_id_issue_date_2(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_id_issue_date_3(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_id_issue_date_3(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_id_issue_date_3(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_id_issue_date_4(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_id_issue_date_4(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_id_issue_date_4(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_id_issue_date_5(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_id_issue_date_5(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_id_issue_date_5(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_id_issue_date_6(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_id_issue_date_6(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_id_issue_date_6(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_id_issue_date_7(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_id_issue_date_7(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_id_issue_date_7(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_id_issue_date_8(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_id_issue_date_8(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_id_issue_date_8(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_id_issue_date_9(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_id_issue_date_9(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_id_issue_date_9(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_id_issue_date_10(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_id_issue_date_10(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_id_issue_date_10(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_id_expiration_date_1(SALT34.StrType s0) := MakeFT_invalid_expire_dte(s0);
EXPORT InValid_id_expiration_date_1(SALT34.StrType s) := InValidFT_invalid_expire_dte(s);
EXPORT InValidMessage_id_expiration_date_1(UNSIGNED1 wh) := InValidMessageFT_invalid_expire_dte(wh);
 
EXPORT Make_id_expiration_date_2(SALT34.StrType s0) := MakeFT_invalid_expire_dte(s0);
EXPORT InValid_id_expiration_date_2(SALT34.StrType s) := InValidFT_invalid_expire_dte(s);
EXPORT InValidMessage_id_expiration_date_2(UNSIGNED1 wh) := InValidMessageFT_invalid_expire_dte(wh);
 
EXPORT Make_id_expiration_date_3(SALT34.StrType s0) := MakeFT_invalid_expire_dte(s0);
EXPORT InValid_id_expiration_date_3(SALT34.StrType s) := InValidFT_invalid_expire_dte(s);
EXPORT InValidMessage_id_expiration_date_3(UNSIGNED1 wh) := InValidMessageFT_invalid_expire_dte(wh);
 
EXPORT Make_id_expiration_date_4(SALT34.StrType s0) := MakeFT_invalid_expire_dte(s0);
EXPORT InValid_id_expiration_date_4(SALT34.StrType s) := InValidFT_invalid_expire_dte(s);
EXPORT InValidMessage_id_expiration_date_4(UNSIGNED1 wh) := InValidMessageFT_invalid_expire_dte(wh);
 
EXPORT Make_id_expiration_date_5(SALT34.StrType s0) := MakeFT_invalid_expire_dte(s0);
EXPORT InValid_id_expiration_date_5(SALT34.StrType s) := InValidFT_invalid_expire_dte(s);
EXPORT InValidMessage_id_expiration_date_5(UNSIGNED1 wh) := InValidMessageFT_invalid_expire_dte(wh);
 
EXPORT Make_id_expiration_date_6(SALT34.StrType s0) := MakeFT_invalid_expire_dte(s0);
EXPORT InValid_id_expiration_date_6(SALT34.StrType s) := InValidFT_invalid_expire_dte(s);
EXPORT InValidMessage_id_expiration_date_6(UNSIGNED1 wh) := InValidMessageFT_invalid_expire_dte(wh);
 
EXPORT Make_id_expiration_date_7(SALT34.StrType s0) := MakeFT_invalid_expire_dte(s0);
EXPORT InValid_id_expiration_date_7(SALT34.StrType s) := InValidFT_invalid_expire_dte(s);
EXPORT InValidMessage_id_expiration_date_7(UNSIGNED1 wh) := InValidMessageFT_invalid_expire_dte(wh);
 
EXPORT Make_id_expiration_date_8(SALT34.StrType s0) := MakeFT_invalid_expire_dte(s0);
EXPORT InValid_id_expiration_date_8(SALT34.StrType s) := InValidFT_invalid_expire_dte(s);
EXPORT InValidMessage_id_expiration_date_8(UNSIGNED1 wh) := InValidMessageFT_invalid_expire_dte(wh);
 
EXPORT Make_id_expiration_date_9(SALT34.StrType s0) := MakeFT_invalid_expire_dte(s0);
EXPORT InValid_id_expiration_date_9(SALT34.StrType s) := InValidFT_invalid_expire_dte(s);
EXPORT InValidMessage_id_expiration_date_9(UNSIGNED1 wh) := InValidMessageFT_invalid_expire_dte(wh);
 
EXPORT Make_id_expiration_date_10(SALT34.StrType s0) := MakeFT_invalid_expire_dte(s0);
EXPORT InValid_id_expiration_date_10(SALT34.StrType s) := InValidFT_invalid_expire_dte(s);
EXPORT InValidMessage_id_expiration_date_10(UNSIGNED1 wh) := InValidMessageFT_invalid_expire_dte(wh);
 
EXPORT Make_nationality_id_1(SALT34.StrType s0) := s0;
EXPORT InValid_nationality_id_1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_nationality_id_1(UNSIGNED1 wh) := '';
 
EXPORT Make_nationality_id_2(SALT34.StrType s0) := s0;
EXPORT InValid_nationality_id_2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_nationality_id_2(UNSIGNED1 wh) := '';
 
EXPORT Make_nationality_id_3(SALT34.StrType s0) := s0;
EXPORT InValid_nationality_id_3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_nationality_id_3(UNSIGNED1 wh) := '';
 
EXPORT Make_nationality_id_4(SALT34.StrType s0) := s0;
EXPORT InValid_nationality_id_4(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_nationality_id_4(UNSIGNED1 wh) := '';
 
EXPORT Make_nationality_id_5(SALT34.StrType s0) := s0;
EXPORT InValid_nationality_id_5(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_nationality_id_5(UNSIGNED1 wh) := '';
 
EXPORT Make_nationality_id_6(SALT34.StrType s0) := s0;
EXPORT InValid_nationality_id_6(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_nationality_id_6(UNSIGNED1 wh) := '';
 
EXPORT Make_nationality_id_7(SALT34.StrType s0) := s0;
EXPORT InValid_nationality_id_7(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_nationality_id_7(UNSIGNED1 wh) := '';
 
EXPORT Make_nationality_id_8(SALT34.StrType s0) := s0;
EXPORT InValid_nationality_id_8(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_nationality_id_8(UNSIGNED1 wh) := '';
 
EXPORT Make_nationality_id_9(SALT34.StrType s0) := s0;
EXPORT InValid_nationality_id_9(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_nationality_id_9(UNSIGNED1 wh) := '';
 
EXPORT Make_nationality_id_10(SALT34.StrType s0) := s0;
EXPORT InValid_nationality_id_10(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_nationality_id_10(UNSIGNED1 wh) := '';
 
EXPORT Make_nationality_1(SALT34.StrType s0) := s0;
EXPORT InValid_nationality_1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_nationality_1(UNSIGNED1 wh) := '';
 
EXPORT Make_nationality_2(SALT34.StrType s0) := s0;
EXPORT InValid_nationality_2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_nationality_2(UNSIGNED1 wh) := '';
 
EXPORT Make_nationality_3(SALT34.StrType s0) := s0;
EXPORT InValid_nationality_3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_nationality_3(UNSIGNED1 wh) := '';
 
EXPORT Make_nationality_4(SALT34.StrType s0) := s0;
EXPORT InValid_nationality_4(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_nationality_4(UNSIGNED1 wh) := '';
 
EXPORT Make_nationality_5(SALT34.StrType s0) := s0;
EXPORT InValid_nationality_5(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_nationality_5(UNSIGNED1 wh) := '';
 
EXPORT Make_nationality_6(SALT34.StrType s0) := s0;
EXPORT InValid_nationality_6(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_nationality_6(UNSIGNED1 wh) := '';
 
EXPORT Make_nationality_7(SALT34.StrType s0) := s0;
EXPORT InValid_nationality_7(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_nationality_7(UNSIGNED1 wh) := '';
 
EXPORT Make_nationality_8(SALT34.StrType s0) := s0;
EXPORT InValid_nationality_8(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_nationality_8(UNSIGNED1 wh) := '';
 
EXPORT Make_nationality_9(SALT34.StrType s0) := s0;
EXPORT InValid_nationality_9(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_nationality_9(UNSIGNED1 wh) := '';
 
EXPORT Make_nationality_10(SALT34.StrType s0) := s0;
EXPORT InValid_nationality_10(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_nationality_10(UNSIGNED1 wh) := '';
 
EXPORT Make_primary_nationality_flag_1(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_nationality_flag_1(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_nationality_flag_1(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_nationality_flag_2(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_nationality_flag_2(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_nationality_flag_2(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_nationality_flag_3(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_nationality_flag_3(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_nationality_flag_3(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_nationality_flag_4(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_nationality_flag_4(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_nationality_flag_4(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_nationality_flag_5(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_nationality_flag_5(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_nationality_flag_5(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_nationality_flag_6(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_nationality_flag_6(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_nationality_flag_6(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_nationality_flag_7(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_nationality_flag_7(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_nationality_flag_7(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_nationality_flag_8(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_nationality_flag_8(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_nationality_flag_8(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_nationality_flag_9(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_nationality_flag_9(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_nationality_flag_9(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_nationality_flag_10(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_nationality_flag_10(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_nationality_flag_10(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_citizenship_id_1(SALT34.StrType s0) := s0;
EXPORT InValid_citizenship_id_1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_citizenship_id_1(UNSIGNED1 wh) := '';
 
EXPORT Make_citizenship_id_2(SALT34.StrType s0) := s0;
EXPORT InValid_citizenship_id_2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_citizenship_id_2(UNSIGNED1 wh) := '';
 
EXPORT Make_citizenship_id_3(SALT34.StrType s0) := s0;
EXPORT InValid_citizenship_id_3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_citizenship_id_3(UNSIGNED1 wh) := '';
 
EXPORT Make_citizenship_id_4(SALT34.StrType s0) := s0;
EXPORT InValid_citizenship_id_4(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_citizenship_id_4(UNSIGNED1 wh) := '';
 
EXPORT Make_citizenship_id_5(SALT34.StrType s0) := s0;
EXPORT InValid_citizenship_id_5(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_citizenship_id_5(UNSIGNED1 wh) := '';
 
EXPORT Make_citizenship_id_6(SALT34.StrType s0) := s0;
EXPORT InValid_citizenship_id_6(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_citizenship_id_6(UNSIGNED1 wh) := '';
 
EXPORT Make_citizenship_id_7(SALT34.StrType s0) := s0;
EXPORT InValid_citizenship_id_7(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_citizenship_id_7(UNSIGNED1 wh) := '';
 
EXPORT Make_citizenship_id_8(SALT34.StrType s0) := s0;
EXPORT InValid_citizenship_id_8(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_citizenship_id_8(UNSIGNED1 wh) := '';
 
EXPORT Make_citizenship_id_9(SALT34.StrType s0) := s0;
EXPORT InValid_citizenship_id_9(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_citizenship_id_9(UNSIGNED1 wh) := '';
 
EXPORT Make_citizenship_id_10(SALT34.StrType s0) := s0;
EXPORT InValid_citizenship_id_10(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_citizenship_id_10(UNSIGNED1 wh) := '';
 
EXPORT Make_citizenship_1(SALT34.StrType s0) := s0;
EXPORT InValid_citizenship_1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_citizenship_1(UNSIGNED1 wh) := '';
 
EXPORT Make_citizenship_2(SALT34.StrType s0) := s0;
EXPORT InValid_citizenship_2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_citizenship_2(UNSIGNED1 wh) := '';
 
EXPORT Make_citizenship_3(SALT34.StrType s0) := s0;
EXPORT InValid_citizenship_3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_citizenship_3(UNSIGNED1 wh) := '';
 
EXPORT Make_citizenship_4(SALT34.StrType s0) := s0;
EXPORT InValid_citizenship_4(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_citizenship_4(UNSIGNED1 wh) := '';
 
EXPORT Make_citizenship_5(SALT34.StrType s0) := s0;
EXPORT InValid_citizenship_5(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_citizenship_5(UNSIGNED1 wh) := '';
 
EXPORT Make_citizenship_6(SALT34.StrType s0) := s0;
EXPORT InValid_citizenship_6(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_citizenship_6(UNSIGNED1 wh) := '';
 
EXPORT Make_citizenship_7(SALT34.StrType s0) := s0;
EXPORT InValid_citizenship_7(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_citizenship_7(UNSIGNED1 wh) := '';
 
EXPORT Make_citizenship_8(SALT34.StrType s0) := s0;
EXPORT InValid_citizenship_8(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_citizenship_8(UNSIGNED1 wh) := '';
 
EXPORT Make_citizenship_9(SALT34.StrType s0) := s0;
EXPORT InValid_citizenship_9(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_citizenship_9(UNSIGNED1 wh) := '';
 
EXPORT Make_citizenship_10(SALT34.StrType s0) := s0;
EXPORT InValid_citizenship_10(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_citizenship_10(UNSIGNED1 wh) := '';
 
EXPORT Make_primary_citizenship_flag_1(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_citizenship_flag_1(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_citizenship_flag_1(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_citizenship_flag_2(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_citizenship_flag_2(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_citizenship_flag_2(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_citizenship_flag_3(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_citizenship_flag_3(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_citizenship_flag_3(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_citizenship_flag_4(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_citizenship_flag_4(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_citizenship_flag_4(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_citizenship_flag_5(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_citizenship_flag_5(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_citizenship_flag_5(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_citizenship_flag_6(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_citizenship_flag_6(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_citizenship_flag_6(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_citizenship_flag_7(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_citizenship_flag_7(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_citizenship_flag_7(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_citizenship_flag_8(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_citizenship_flag_8(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_citizenship_flag_8(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_citizenship_flag_9(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_citizenship_flag_9(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_citizenship_flag_9(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_citizenship_flag_10(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_citizenship_flag_10(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_citizenship_flag_10(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_dob_id_1(SALT34.StrType s0) := s0;
EXPORT InValid_dob_id_1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dob_id_1(UNSIGNED1 wh) := '';
 
EXPORT Make_dob_id_2(SALT34.StrType s0) := s0;
EXPORT InValid_dob_id_2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dob_id_2(UNSIGNED1 wh) := '';
 
EXPORT Make_dob_id_3(SALT34.StrType s0) := s0;
EXPORT InValid_dob_id_3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dob_id_3(UNSIGNED1 wh) := '';
 
EXPORT Make_dob_id_4(SALT34.StrType s0) := s0;
EXPORT InValid_dob_id_4(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dob_id_4(UNSIGNED1 wh) := '';
 
EXPORT Make_dob_id_5(SALT34.StrType s0) := s0;
EXPORT InValid_dob_id_5(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dob_id_5(UNSIGNED1 wh) := '';
 
EXPORT Make_dob_id_6(SALT34.StrType s0) := s0;
EXPORT InValid_dob_id_6(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dob_id_6(UNSIGNED1 wh) := '';
 
EXPORT Make_dob_id_7(SALT34.StrType s0) := s0;
EXPORT InValid_dob_id_7(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dob_id_7(UNSIGNED1 wh) := '';
 
EXPORT Make_dob_id_8(SALT34.StrType s0) := s0;
EXPORT InValid_dob_id_8(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dob_id_8(UNSIGNED1 wh) := '';
 
EXPORT Make_dob_id_9(SALT34.StrType s0) := s0;
EXPORT InValid_dob_id_9(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dob_id_9(UNSIGNED1 wh) := '';
 
EXPORT Make_dob_id_10(SALT34.StrType s0) := s0;
EXPORT InValid_dob_id_10(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dob_id_10(UNSIGNED1 wh) := '';
 
EXPORT Make_dob_1(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dob_1(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dob_1(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_dob_2(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dob_2(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dob_2(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_dob_3(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dob_3(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dob_3(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_dob_4(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dob_4(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dob_4(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_dob_5(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dob_5(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dob_5(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_dob_6(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dob_6(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dob_6(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_dob_7(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dob_7(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dob_7(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_dob_8(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dob_8(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dob_8(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_dob_9(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dob_9(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dob_9(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_dob_10(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dob_10(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dob_10(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_primary_dob_flag_1(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_dob_flag_1(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_dob_flag_1(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_dob_flag_2(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_dob_flag_2(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_dob_flag_2(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_dob_flag_3(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_dob_flag_3(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_dob_flag_3(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_dob_flag_4(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_dob_flag_4(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_dob_flag_4(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_dob_flag_5(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_dob_flag_5(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_dob_flag_5(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_dob_flag_6(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_dob_flag_6(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_dob_flag_6(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_dob_flag_7(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_dob_flag_7(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_dob_flag_7(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_dob_flag_8(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_dob_flag_8(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_dob_flag_8(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_dob_flag_9(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_dob_flag_9(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_dob_flag_9(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_dob_flag_10(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_dob_flag_10(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_dob_flag_10(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_pob_id_1(SALT34.StrType s0) := s0;
EXPORT InValid_pob_id_1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_pob_id_1(UNSIGNED1 wh) := '';
 
EXPORT Make_pob_id_2(SALT34.StrType s0) := s0;
EXPORT InValid_pob_id_2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_pob_id_2(UNSIGNED1 wh) := '';
 
EXPORT Make_pob_id_3(SALT34.StrType s0) := s0;
EXPORT InValid_pob_id_3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_pob_id_3(UNSIGNED1 wh) := '';
 
EXPORT Make_pob_id_4(SALT34.StrType s0) := s0;
EXPORT InValid_pob_id_4(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_pob_id_4(UNSIGNED1 wh) := '';
 
EXPORT Make_pob_id_5(SALT34.StrType s0) := s0;
EXPORT InValid_pob_id_5(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_pob_id_5(UNSIGNED1 wh) := '';
 
EXPORT Make_pob_id_6(SALT34.StrType s0) := s0;
EXPORT InValid_pob_id_6(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_pob_id_6(UNSIGNED1 wh) := '';
 
EXPORT Make_pob_id_7(SALT34.StrType s0) := s0;
EXPORT InValid_pob_id_7(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_pob_id_7(UNSIGNED1 wh) := '';
 
EXPORT Make_pob_id_8(SALT34.StrType s0) := s0;
EXPORT InValid_pob_id_8(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_pob_id_8(UNSIGNED1 wh) := '';
 
EXPORT Make_pob_id_9(SALT34.StrType s0) := s0;
EXPORT InValid_pob_id_9(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_pob_id_9(UNSIGNED1 wh) := '';
 
EXPORT Make_pob_id_10(SALT34.StrType s0) := s0;
EXPORT InValid_pob_id_10(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_pob_id_10(UNSIGNED1 wh) := '';
 
EXPORT Make_pob_1(SALT34.StrType s0) := s0;
EXPORT InValid_pob_1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_pob_1(UNSIGNED1 wh) := '';
 
EXPORT Make_pob_2(SALT34.StrType s0) := s0;
EXPORT InValid_pob_2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_pob_2(UNSIGNED1 wh) := '';
 
EXPORT Make_pob_3(SALT34.StrType s0) := s0;
EXPORT InValid_pob_3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_pob_3(UNSIGNED1 wh) := '';
 
EXPORT Make_pob_4(SALT34.StrType s0) := s0;
EXPORT InValid_pob_4(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_pob_4(UNSIGNED1 wh) := '';
 
EXPORT Make_pob_5(SALT34.StrType s0) := s0;
EXPORT InValid_pob_5(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_pob_5(UNSIGNED1 wh) := '';
 
EXPORT Make_pob_6(SALT34.StrType s0) := s0;
EXPORT InValid_pob_6(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_pob_6(UNSIGNED1 wh) := '';
 
EXPORT Make_pob_7(SALT34.StrType s0) := s0;
EXPORT InValid_pob_7(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_pob_7(UNSIGNED1 wh) := '';
 
EXPORT Make_pob_8(SALT34.StrType s0) := s0;
EXPORT InValid_pob_8(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_pob_8(UNSIGNED1 wh) := '';
 
EXPORT Make_pob_9(SALT34.StrType s0) := s0;
EXPORT InValid_pob_9(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_pob_9(UNSIGNED1 wh) := '';
 
EXPORT Make_pob_10(SALT34.StrType s0) := s0;
EXPORT InValid_pob_10(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_pob_10(UNSIGNED1 wh) := '';
 
EXPORT Make_country_of_birth_1(SALT34.StrType s0) := s0;
EXPORT InValid_country_of_birth_1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_country_of_birth_1(UNSIGNED1 wh) := '';
 
EXPORT Make_country_of_birth_2(SALT34.StrType s0) := s0;
EXPORT InValid_country_of_birth_2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_country_of_birth_2(UNSIGNED1 wh) := '';
 
EXPORT Make_country_of_birth_3(SALT34.StrType s0) := s0;
EXPORT InValid_country_of_birth_3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_country_of_birth_3(UNSIGNED1 wh) := '';
 
EXPORT Make_country_of_birth_4(SALT34.StrType s0) := s0;
EXPORT InValid_country_of_birth_4(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_country_of_birth_4(UNSIGNED1 wh) := '';
 
EXPORT Make_country_of_birth_5(SALT34.StrType s0) := s0;
EXPORT InValid_country_of_birth_5(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_country_of_birth_5(UNSIGNED1 wh) := '';
 
EXPORT Make_country_of_birth_6(SALT34.StrType s0) := s0;
EXPORT InValid_country_of_birth_6(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_country_of_birth_6(UNSIGNED1 wh) := '';
 
EXPORT Make_country_of_birth_7(SALT34.StrType s0) := s0;
EXPORT InValid_country_of_birth_7(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_country_of_birth_7(UNSIGNED1 wh) := '';
 
EXPORT Make_country_of_birth_8(SALT34.StrType s0) := s0;
EXPORT InValid_country_of_birth_8(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_country_of_birth_8(UNSIGNED1 wh) := '';
 
EXPORT Make_country_of_birth_9(SALT34.StrType s0) := s0;
EXPORT InValid_country_of_birth_9(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_country_of_birth_9(UNSIGNED1 wh) := '';
 
EXPORT Make_country_of_birth_10(SALT34.StrType s0) := s0;
EXPORT InValid_country_of_birth_10(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_country_of_birth_10(UNSIGNED1 wh) := '';
 
EXPORT Make_primary_pob_flag_1(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_pob_flag_1(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_pob_flag_1(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_pob_flag_2(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_pob_flag_2(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_pob_flag_2(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_pob_flag_3(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_pob_flag_3(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_pob_flag_3(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_pob_flag_4(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_pob_flag_4(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_pob_flag_4(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_pob_flag_5(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_pob_flag_5(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_pob_flag_5(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_pob_flag_6(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_pob_flag_6(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_pob_flag_6(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_pob_flag_7(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_pob_flag_7(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_pob_flag_7(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_pob_flag_8(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_pob_flag_8(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_pob_flag_8(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_pob_flag_9(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_pob_flag_9(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_pob_flag_9(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_primary_pob_flag_10(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_primary_pob_flag_10(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_primary_pob_flag_10(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_language_1(SALT34.StrType s0) := s0;
EXPORT InValid_language_1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_language_1(UNSIGNED1 wh) := '';
 
EXPORT Make_language_2(SALT34.StrType s0) := s0;
EXPORT InValid_language_2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_language_2(UNSIGNED1 wh) := '';
 
EXPORT Make_language_3(SALT34.StrType s0) := s0;
EXPORT InValid_language_3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_language_3(UNSIGNED1 wh) := '';
 
EXPORT Make_language_4(SALT34.StrType s0) := s0;
EXPORT InValid_language_4(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_language_4(UNSIGNED1 wh) := '';
 
EXPORT Make_language_5(SALT34.StrType s0) := s0;
EXPORT InValid_language_5(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_language_5(UNSIGNED1 wh) := '';
 
EXPORT Make_language_6(SALT34.StrType s0) := s0;
EXPORT InValid_language_6(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_language_6(UNSIGNED1 wh) := '';
 
EXPORT Make_language_7(SALT34.StrType s0) := s0;
EXPORT InValid_language_7(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_language_7(UNSIGNED1 wh) := '';
 
EXPORT Make_language_8(SALT34.StrType s0) := s0;
EXPORT InValid_language_8(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_language_8(UNSIGNED1 wh) := '';
 
EXPORT Make_language_9(SALT34.StrType s0) := s0;
EXPORT InValid_language_9(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_language_9(UNSIGNED1 wh) := '';
 
EXPORT Make_language_10(SALT34.StrType s0) := s0;
EXPORT InValid_language_10(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_language_10(UNSIGNED1 wh) := '';
 
EXPORT Make_membership_1(SALT34.StrType s0) := s0;
EXPORT InValid_membership_1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_membership_1(UNSIGNED1 wh) := '';
 
EXPORT Make_membership_2(SALT34.StrType s0) := s0;
EXPORT InValid_membership_2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_membership_2(UNSIGNED1 wh) := '';
 
EXPORT Make_membership_3(SALT34.StrType s0) := s0;
EXPORT InValid_membership_3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_membership_3(UNSIGNED1 wh) := '';
 
EXPORT Make_membership_4(SALT34.StrType s0) := s0;
EXPORT InValid_membership_4(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_membership_4(UNSIGNED1 wh) := '';
 
EXPORT Make_membership_5(SALT34.StrType s0) := s0;
EXPORT InValid_membership_5(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_membership_5(UNSIGNED1 wh) := '';
 
EXPORT Make_membership_6(SALT34.StrType s0) := s0;
EXPORT InValid_membership_6(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_membership_6(UNSIGNED1 wh) := '';
 
EXPORT Make_membership_7(SALT34.StrType s0) := s0;
EXPORT InValid_membership_7(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_membership_7(UNSIGNED1 wh) := '';
 
EXPORT Make_membership_8(SALT34.StrType s0) := s0;
EXPORT InValid_membership_8(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_membership_8(UNSIGNED1 wh) := '';
 
EXPORT Make_membership_9(SALT34.StrType s0) := s0;
EXPORT InValid_membership_9(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_membership_9(UNSIGNED1 wh) := '';
 
EXPORT Make_membership_10(SALT34.StrType s0) := s0;
EXPORT InValid_membership_10(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_membership_10(UNSIGNED1 wh) := '';
 
EXPORT Make_position_1(SALT34.StrType s0) := s0;
EXPORT InValid_position_1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_position_1(UNSIGNED1 wh) := '';
 
EXPORT Make_position_2(SALT34.StrType s0) := s0;
EXPORT InValid_position_2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_position_2(UNSIGNED1 wh) := '';
 
EXPORT Make_position_3(SALT34.StrType s0) := s0;
EXPORT InValid_position_3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_position_3(UNSIGNED1 wh) := '';
 
EXPORT Make_position_4(SALT34.StrType s0) := s0;
EXPORT InValid_position_4(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_position_4(UNSIGNED1 wh) := '';
 
EXPORT Make_position_5(SALT34.StrType s0) := s0;
EXPORT InValid_position_5(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_position_5(UNSIGNED1 wh) := '';
 
EXPORT Make_position_6(SALT34.StrType s0) := s0;
EXPORT InValid_position_6(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_position_6(UNSIGNED1 wh) := '';
 
EXPORT Make_position_7(SALT34.StrType s0) := s0;
EXPORT InValid_position_7(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_position_7(UNSIGNED1 wh) := '';
 
EXPORT Make_position_8(SALT34.StrType s0) := s0;
EXPORT InValid_position_8(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_position_8(UNSIGNED1 wh) := '';
 
EXPORT Make_position_9(SALT34.StrType s0) := s0;
EXPORT InValid_position_9(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_position_9(UNSIGNED1 wh) := '';
 
EXPORT Make_position_10(SALT34.StrType s0) := s0;
EXPORT InValid_position_10(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_position_10(UNSIGNED1 wh) := '';
 
EXPORT Make_occupation_1(SALT34.StrType s0) := s0;
EXPORT InValid_occupation_1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_occupation_1(UNSIGNED1 wh) := '';
 
EXPORT Make_occupation_2(SALT34.StrType s0) := s0;
EXPORT InValid_occupation_2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_occupation_2(UNSIGNED1 wh) := '';
 
EXPORT Make_occupation_3(SALT34.StrType s0) := s0;
EXPORT InValid_occupation_3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_occupation_3(UNSIGNED1 wh) := '';
 
EXPORT Make_occupation_4(SALT34.StrType s0) := s0;
EXPORT InValid_occupation_4(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_occupation_4(UNSIGNED1 wh) := '';
 
EXPORT Make_occupation_5(SALT34.StrType s0) := s0;
EXPORT InValid_occupation_5(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_occupation_5(UNSIGNED1 wh) := '';
 
EXPORT Make_occupation_6(SALT34.StrType s0) := s0;
EXPORT InValid_occupation_6(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_occupation_6(UNSIGNED1 wh) := '';
 
EXPORT Make_occupation_7(SALT34.StrType s0) := s0;
EXPORT InValid_occupation_7(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_occupation_7(UNSIGNED1 wh) := '';
 
EXPORT Make_occupation_8(SALT34.StrType s0) := s0;
EXPORT InValid_occupation_8(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_occupation_8(UNSIGNED1 wh) := '';
 
EXPORT Make_occupation_9(SALT34.StrType s0) := s0;
EXPORT InValid_occupation_9(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_occupation_9(UNSIGNED1 wh) := '';
 
EXPORT Make_occupation_10(SALT34.StrType s0) := s0;
EXPORT InValid_occupation_10(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_occupation_10(UNSIGNED1 wh) := '';
 
EXPORT Make_date_added_to_list(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_added_to_list(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_added_to_list(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_date_last_updated(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_last_updated(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_last_updated(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_effective_date(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_effective_date(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_effective_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_expiration_date(SALT34.StrType s0) := MakeFT_invalid_expire_dte(s0);
EXPORT InValid_expiration_date(SALT34.StrType s) := InValidFT_invalid_expire_dte(s);
EXPORT InValidMessage_expiration_date(UNSIGNED1 wh) := InValidMessageFT_invalid_expire_dte(wh);
 
EXPORT Make_gender(SALT34.StrType s0) := MakeFT_invalid_gender(s0);
EXPORT InValid_gender(SALT34.StrType s) := InValidFT_invalid_gender(s);
EXPORT InValidMessage_gender(UNSIGNED1 wh) := InValidMessageFT_invalid_gender(wh);
 
EXPORT Make_grounds(SALT34.StrType s0) := s0;
EXPORT InValid_grounds(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_grounds(UNSIGNED1 wh) := '';
 
EXPORT Make_subj_to_common_pos_2001_931_cfsp_fl(SALT34.StrType s0) := s0;
EXPORT InValid_subj_to_common_pos_2001_931_cfsp_fl(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_subj_to_common_pos_2001_931_cfsp_fl(UNSIGNED1 wh) := '';
 
EXPORT Make_federal_register_citation_1(SALT34.StrType s0) := s0;
EXPORT InValid_federal_register_citation_1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_federal_register_citation_1(UNSIGNED1 wh) := '';
 
EXPORT Make_federal_register_citation_2(SALT34.StrType s0) := s0;
EXPORT InValid_federal_register_citation_2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_federal_register_citation_2(UNSIGNED1 wh) := '';
 
EXPORT Make_federal_register_citation_3(SALT34.StrType s0) := s0;
EXPORT InValid_federal_register_citation_3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_federal_register_citation_3(UNSIGNED1 wh) := '';
 
EXPORT Make_federal_register_citation_4(SALT34.StrType s0) := s0;
EXPORT InValid_federal_register_citation_4(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_federal_register_citation_4(UNSIGNED1 wh) := '';
 
EXPORT Make_federal_register_citation_5(SALT34.StrType s0) := s0;
EXPORT InValid_federal_register_citation_5(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_federal_register_citation_5(UNSIGNED1 wh) := '';
 
EXPORT Make_federal_register_citation_6(SALT34.StrType s0) := s0;
EXPORT InValid_federal_register_citation_6(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_federal_register_citation_6(UNSIGNED1 wh) := '';
 
EXPORT Make_federal_register_citation_7(SALT34.StrType s0) := s0;
EXPORT InValid_federal_register_citation_7(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_federal_register_citation_7(UNSIGNED1 wh) := '';
 
EXPORT Make_federal_register_citation_8(SALT34.StrType s0) := s0;
EXPORT InValid_federal_register_citation_8(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_federal_register_citation_8(UNSIGNED1 wh) := '';
 
EXPORT Make_federal_register_citation_9(SALT34.StrType s0) := s0;
EXPORT InValid_federal_register_citation_9(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_federal_register_citation_9(UNSIGNED1 wh) := '';
 
EXPORT Make_federal_register_citation_10(SALT34.StrType s0) := s0;
EXPORT InValid_federal_register_citation_10(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_federal_register_citation_10(UNSIGNED1 wh) := '';
 
EXPORT Make_federal_register_citation_date_1(SALT34.StrType s0) := MakeFT_invalid_expire_dte(s0);
EXPORT InValid_federal_register_citation_date_1(SALT34.StrType s) := InValidFT_invalid_expire_dte(s);
EXPORT InValidMessage_federal_register_citation_date_1(UNSIGNED1 wh) := InValidMessageFT_invalid_expire_dte(wh);
 
EXPORT Make_federal_register_citation_date_2(SALT34.StrType s0) := MakeFT_invalid_expire_dte(s0);
EXPORT InValid_federal_register_citation_date_2(SALT34.StrType s) := InValidFT_invalid_expire_dte(s);
EXPORT InValidMessage_federal_register_citation_date_2(UNSIGNED1 wh) := InValidMessageFT_invalid_expire_dte(wh);
 
EXPORT Make_federal_register_citation_date_3(SALT34.StrType s0) := MakeFT_invalid_expire_dte(s0);
EXPORT InValid_federal_register_citation_date_3(SALT34.StrType s) := InValidFT_invalid_expire_dte(s);
EXPORT InValidMessage_federal_register_citation_date_3(UNSIGNED1 wh) := InValidMessageFT_invalid_expire_dte(wh);
 
EXPORT Make_federal_register_citation_date_4(SALT34.StrType s0) := MakeFT_invalid_expire_dte(s0);
EXPORT InValid_federal_register_citation_date_4(SALT34.StrType s) := InValidFT_invalid_expire_dte(s);
EXPORT InValidMessage_federal_register_citation_date_4(UNSIGNED1 wh) := InValidMessageFT_invalid_expire_dte(wh);
 
EXPORT Make_federal_register_citation_date_5(SALT34.StrType s0) := MakeFT_invalid_expire_dte(s0);
EXPORT InValid_federal_register_citation_date_5(SALT34.StrType s) := InValidFT_invalid_expire_dte(s);
EXPORT InValidMessage_federal_register_citation_date_5(UNSIGNED1 wh) := InValidMessageFT_invalid_expire_dte(wh);
 
EXPORT Make_federal_register_citation_date_6(SALT34.StrType s0) := MakeFT_invalid_expire_dte(s0);
EXPORT InValid_federal_register_citation_date_6(SALT34.StrType s) := InValidFT_invalid_expire_dte(s);
EXPORT InValidMessage_federal_register_citation_date_6(UNSIGNED1 wh) := InValidMessageFT_invalid_expire_dte(wh);
 
EXPORT Make_federal_register_citation_date_7(SALT34.StrType s0) := MakeFT_invalid_expire_dte(s0);
EXPORT InValid_federal_register_citation_date_7(SALT34.StrType s) := InValidFT_invalid_expire_dte(s);
EXPORT InValidMessage_federal_register_citation_date_7(UNSIGNED1 wh) := InValidMessageFT_invalid_expire_dte(wh);
 
EXPORT Make_federal_register_citation_date_8(SALT34.StrType s0) := MakeFT_invalid_expire_dte(s0);
EXPORT InValid_federal_register_citation_date_8(SALT34.StrType s) := InValidFT_invalid_expire_dte(s);
EXPORT InValidMessage_federal_register_citation_date_8(UNSIGNED1 wh) := InValidMessageFT_invalid_expire_dte(wh);
 
EXPORT Make_federal_register_citation_date_9(SALT34.StrType s0) := MakeFT_invalid_expire_dte(s0);
EXPORT InValid_federal_register_citation_date_9(SALT34.StrType s) := InValidFT_invalid_expire_dte(s);
EXPORT InValidMessage_federal_register_citation_date_9(UNSIGNED1 wh) := InValidMessageFT_invalid_expire_dte(wh);
 
EXPORT Make_federal_register_citation_date_10(SALT34.StrType s0) := MakeFT_invalid_expire_dte(s0);
EXPORT InValid_federal_register_citation_date_10(SALT34.StrType s) := InValidFT_invalid_expire_dte(s);
EXPORT InValidMessage_federal_register_citation_date_10(UNSIGNED1 wh) := InValidMessageFT_invalid_expire_dte(wh);
 
EXPORT Make_license_requirement(SALT34.StrType s0) := s0;
EXPORT InValid_license_requirement(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_license_requirement(UNSIGNED1 wh) := '';
 
EXPORT Make_license_review_policy(SALT34.StrType s0) := s0;
EXPORT InValid_license_review_policy(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_license_review_policy(UNSIGNED1 wh) := '';
 
EXPORT Make_subordinate_status(SALT34.StrType s0) := s0;
EXPORT InValid_subordinate_status(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_subordinate_status(UNSIGNED1 wh) := '';
 
EXPORT Make_height(SALT34.StrType s0) := MakeFT_invalid_wgt_hgt(s0);
EXPORT InValid_height(SALT34.StrType s) := InValidFT_invalid_wgt_hgt(s);
EXPORT InValidMessage_height(UNSIGNED1 wh) := InValidMessageFT_invalid_wgt_hgt(wh);
 
EXPORT Make_weight(SALT34.StrType s0) := MakeFT_invalid_wgt_hgt(s0);
EXPORT InValid_weight(SALT34.StrType s) := InValidFT_invalid_wgt_hgt(s);
EXPORT InValidMessage_weight(UNSIGNED1 wh) := InValidMessageFT_invalid_wgt_hgt(wh);
 
EXPORT Make_physique(SALT34.StrType s0) := MakeFT_invalid_physique(s0);
EXPORT InValid_physique(SALT34.StrType s) := InValidFT_invalid_physique(s);
EXPORT InValidMessage_physique(UNSIGNED1 wh) := InValidMessageFT_invalid_physique(wh);
 
EXPORT Make_hair_color(SALT34.StrType s0) := MakeFT_invalid_hair_color(s0);
EXPORT InValid_hair_color(SALT34.StrType s) := InValidFT_invalid_hair_color(s);
EXPORT InValidMessage_hair_color(UNSIGNED1 wh) := InValidMessageFT_invalid_hair_color(wh);
 
EXPORT Make_eyes(SALT34.StrType s0) := MakeFT_invalid_hair_color(s0);
EXPORT InValid_eyes(SALT34.StrType s) := InValidFT_invalid_hair_color(s);
EXPORT InValidMessage_eyes(UNSIGNED1 wh) := InValidMessageFT_invalid_hair_color(wh);
 
EXPORT Make_complexion(SALT34.StrType s0) := MakeFT_invalid_complexion(s0);
EXPORT InValid_complexion(SALT34.StrType s) := InValidFT_invalid_complexion(s);
EXPORT InValidMessage_complexion(UNSIGNED1 wh) := InValidMessageFT_invalid_complexion(wh);
 
EXPORT Make_race(SALT34.StrType s0) := MakeFT_invalid_race(s0);
EXPORT InValid_race(SALT34.StrType s) := InValidFT_invalid_race(s);
EXPORT InValidMessage_race(UNSIGNED1 wh) := InValidMessageFT_invalid_race(wh);
 
EXPORT Make_scars_marks(SALT34.StrType s0) := s0;
EXPORT InValid_scars_marks(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_scars_marks(UNSIGNED1 wh) := '';
 
EXPORT Make_photo_file(SALT34.StrType s0) := s0;
EXPORT InValid_photo_file(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_photo_file(UNSIGNED1 wh) := '';
 
EXPORT Make_offenses(SALT34.StrType s0) := s0;
EXPORT InValid_offenses(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_offenses(UNSIGNED1 wh) := '';
 
EXPORT Make_ncic(SALT34.StrType s0) := s0;
EXPORT InValid_ncic(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_ncic(UNSIGNED1 wh) := '';
 
EXPORT Make_warrant_by(SALT34.StrType s0) := s0;
EXPORT InValid_warrant_by(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_warrant_by(UNSIGNED1 wh) := '';
 
EXPORT Make_caution(SALT34.StrType s0) := s0;
EXPORT InValid_caution(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_caution(UNSIGNED1 wh) := '';
 
EXPORT Make_reward(SALT34.StrType s0) := s0;
EXPORT InValid_reward(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_reward(UNSIGNED1 wh) := '';
 
EXPORT Make_type_of_denial(SALT34.StrType s0) := MakeFT_invalid_denial(s0);
EXPORT InValid_type_of_denial(SALT34.StrType s) := InValidFT_invalid_denial(s);
EXPORT InValidMessage_type_of_denial(UNSIGNED1 wh) := InValidMessageFT_invalid_denial(wh);
 
EXPORT Make_linked_with_1(SALT34.StrType s0) := s0;
EXPORT InValid_linked_with_1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_linked_with_1(UNSIGNED1 wh) := '';
 
EXPORT Make_linked_with_2(SALT34.StrType s0) := s0;
EXPORT InValid_linked_with_2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_linked_with_2(UNSIGNED1 wh) := '';
 
EXPORT Make_linked_with_3(SALT34.StrType s0) := s0;
EXPORT InValid_linked_with_3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_linked_with_3(UNSIGNED1 wh) := '';
 
EXPORT Make_linked_with_4(SALT34.StrType s0) := s0;
EXPORT InValid_linked_with_4(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_linked_with_4(UNSIGNED1 wh) := '';
 
EXPORT Make_linked_with_5(SALT34.StrType s0) := s0;
EXPORT InValid_linked_with_5(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_linked_with_5(UNSIGNED1 wh) := '';
 
EXPORT Make_linked_with_6(SALT34.StrType s0) := s0;
EXPORT InValid_linked_with_6(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_linked_with_6(UNSIGNED1 wh) := '';
 
EXPORT Make_linked_with_7(SALT34.StrType s0) := s0;
EXPORT InValid_linked_with_7(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_linked_with_7(UNSIGNED1 wh) := '';
 
EXPORT Make_linked_with_8(SALT34.StrType s0) := s0;
EXPORT InValid_linked_with_8(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_linked_with_8(UNSIGNED1 wh) := '';
 
EXPORT Make_linked_with_9(SALT34.StrType s0) := s0;
EXPORT InValid_linked_with_9(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_linked_with_9(UNSIGNED1 wh) := '';
 
EXPORT Make_linked_with_10(SALT34.StrType s0) := s0;
EXPORT InValid_linked_with_10(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_linked_with_10(UNSIGNED1 wh) := '';
 
EXPORT Make_linked_with_id_1(SALT34.StrType s0) := s0;
EXPORT InValid_linked_with_id_1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_linked_with_id_1(UNSIGNED1 wh) := '';
 
EXPORT Make_linked_with_id_2(SALT34.StrType s0) := s0;
EXPORT InValid_linked_with_id_2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_linked_with_id_2(UNSIGNED1 wh) := '';
 
EXPORT Make_linked_with_id_3(SALT34.StrType s0) := s0;
EXPORT InValid_linked_with_id_3(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_linked_with_id_3(UNSIGNED1 wh) := '';
 
EXPORT Make_linked_with_id_4(SALT34.StrType s0) := s0;
EXPORT InValid_linked_with_id_4(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_linked_with_id_4(UNSIGNED1 wh) := '';
 
EXPORT Make_linked_with_id_5(SALT34.StrType s0) := s0;
EXPORT InValid_linked_with_id_5(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_linked_with_id_5(UNSIGNED1 wh) := '';
 
EXPORT Make_linked_with_id_6(SALT34.StrType s0) := s0;
EXPORT InValid_linked_with_id_6(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_linked_with_id_6(UNSIGNED1 wh) := '';
 
EXPORT Make_linked_with_id_7(SALT34.StrType s0) := s0;
EXPORT InValid_linked_with_id_7(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_linked_with_id_7(UNSIGNED1 wh) := '';
 
EXPORT Make_linked_with_id_8(SALT34.StrType s0) := s0;
EXPORT InValid_linked_with_id_8(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_linked_with_id_8(UNSIGNED1 wh) := '';
 
EXPORT Make_linked_with_id_9(SALT34.StrType s0) := s0;
EXPORT InValid_linked_with_id_9(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_linked_with_id_9(UNSIGNED1 wh) := '';
 
EXPORT Make_linked_with_id_10(SALT34.StrType s0) := s0;
EXPORT InValid_linked_with_id_10(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_linked_with_id_10(UNSIGNED1 wh) := '';
 
EXPORT Make_listing_information(SALT34.StrType s0) := s0;
EXPORT InValid_listing_information(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_listing_information(UNSIGNED1 wh) := '';
 
EXPORT Make_foreign_principal(SALT34.StrType s0) := s0;
EXPORT InValid_foreign_principal(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_foreign_principal(UNSIGNED1 wh) := '';
 
EXPORT Make_nature_of_service(SALT34.StrType s0) := s0;
EXPORT InValid_nature_of_service(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_nature_of_service(UNSIGNED1 wh) := '';
 
EXPORT Make_activities(SALT34.StrType s0) := s0;
EXPORT InValid_activities(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_activities(UNSIGNED1 wh) := '';
 
EXPORT Make_finances(SALT34.StrType s0) := s0;
EXPORT InValid_finances(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_finances(UNSIGNED1 wh) := '';
 
EXPORT Make_registrant_terminated_flag(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_registrant_terminated_flag(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_registrant_terminated_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_foreign_principal_terminated_flag(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_foreign_principal_terminated_flag(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_foreign_principal_terminated_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_short_form_terminated_flag(SALT34.StrType s0) := MakeFT_invalid_flag(s0);
EXPORT InValid_short_form_terminated_flag(SALT34.StrType s) := InValidFT_invalid_flag(s);
EXPORT InValidMessage_short_form_terminated_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_flag(wh);
 
EXPORT Make_src_key(SALT34.StrType s0) := s0;
EXPORT InValid_src_key(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_src_key(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT34,Scrubs_GlobalWatchlists;
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
    BOOLEAN Diff_pty_key;
    BOOLEAN Diff_source;
    BOOLEAN Diff_orig_pty_name;
    BOOLEAN Diff_orig_vessel_name;
    BOOLEAN Diff_country;
    BOOLEAN Diff_name_type;
    BOOLEAN Diff_addr_1;
    BOOLEAN Diff_addr_2;
    BOOLEAN Diff_addr_3;
    BOOLEAN Diff_addr_4;
    BOOLEAN Diff_addr_5;
    BOOLEAN Diff_addr_6;
    BOOLEAN Diff_addr_7;
    BOOLEAN Diff_addr_8;
    BOOLEAN Diff_addr_9;
    BOOLEAN Diff_addr_10;
    BOOLEAN Diff_remarks_1;
    BOOLEAN Diff_remarks_2;
    BOOLEAN Diff_remarks_3;
    BOOLEAN Diff_remarks_4;
    BOOLEAN Diff_remarks_5;
    BOOLEAN Diff_remarks_6;
    BOOLEAN Diff_remarks_7;
    BOOLEAN Diff_remarks_8;
    BOOLEAN Diff_remarks_9;
    BOOLEAN Diff_remarks_10;
    BOOLEAN Diff_remarks_11;
    BOOLEAN Diff_remarks_12;
    BOOLEAN Diff_remarks_13;
    BOOLEAN Diff_remarks_14;
    BOOLEAN Diff_remarks_15;
    BOOLEAN Diff_remarks_16;
    BOOLEAN Diff_remarks_17;
    BOOLEAN Diff_remarks_18;
    BOOLEAN Diff_remarks_19;
    BOOLEAN Diff_remarks_20;
    BOOLEAN Diff_remarks_21;
    BOOLEAN Diff_remarks_22;
    BOOLEAN Diff_remarks_23;
    BOOLEAN Diff_remarks_24;
    BOOLEAN Diff_remarks_25;
    BOOLEAN Diff_remarks_26;
    BOOLEAN Diff_remarks_27;
    BOOLEAN Diff_remarks_28;
    BOOLEAN Diff_remarks_29;
    BOOLEAN Diff_remarks_30;
    BOOLEAN Diff_cname;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_a_score;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_addr_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_p_city_name;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_cart;
    BOOLEAN Diff_cr_sort_sz;
    BOOLEAN Diff_lot;
    BOOLEAN Diff_lot_order;
    BOOLEAN Diff_dpbc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_ace_fips_st;
    BOOLEAN Diff_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_date_first_seen;
    BOOLEAN Diff_date_last_seen;
    BOOLEAN Diff_date_vendor_first_reported;
    BOOLEAN Diff_date_vendor_last_reported;
    BOOLEAN Diff_entity_id;
    BOOLEAN Diff_first_name;
    BOOLEAN Diff_last_name;
    BOOLEAN Diff_title_1;
    BOOLEAN Diff_title_2;
    BOOLEAN Diff_title_3;
    BOOLEAN Diff_title_4;
    BOOLEAN Diff_title_5;
    BOOLEAN Diff_title_6;
    BOOLEAN Diff_title_7;
    BOOLEAN Diff_title_8;
    BOOLEAN Diff_title_9;
    BOOLEAN Diff_title_10;
    BOOLEAN Diff_aka_id;
    BOOLEAN Diff_aka_type;
    BOOLEAN Diff_aka_category;
    BOOLEAN Diff_giv_designator;
    BOOLEAN Diff_entity_type;
    BOOLEAN Diff_address_id;
    BOOLEAN Diff_address_line_1;
    BOOLEAN Diff_address_line_2;
    BOOLEAN Diff_address_line_3;
    BOOLEAN Diff_address_city;
    BOOLEAN Diff_address_state_province;
    BOOLEAN Diff_address_postal_code;
    BOOLEAN Diff_address_country;
    BOOLEAN Diff_remarks;
    BOOLEAN Diff_call_sign;
    BOOLEAN Diff_vessel_type;
    BOOLEAN Diff_tonnage;
    BOOLEAN Diff_gross_registered_tonnage;
    BOOLEAN Diff_vessel_flag;
    BOOLEAN Diff_vessel_owner;
    BOOLEAN Diff_sanctions_program_1;
    BOOLEAN Diff_sanctions_program_2;
    BOOLEAN Diff_sanctions_program_3;
    BOOLEAN Diff_sanctions_program_4;
    BOOLEAN Diff_sanctions_program_5;
    BOOLEAN Diff_sanctions_program_6;
    BOOLEAN Diff_sanctions_program_7;
    BOOLEAN Diff_sanctions_program_8;
    BOOLEAN Diff_sanctions_program_9;
    BOOLEAN Diff_sanctions_program_10;
    BOOLEAN Diff_passport_details;
    BOOLEAN Diff_ni_number_details;
    BOOLEAN Diff_id_id_1;
    BOOLEAN Diff_id_id_2;
    BOOLEAN Diff_id_id_3;
    BOOLEAN Diff_id_id_4;
    BOOLEAN Diff_id_id_5;
    BOOLEAN Diff_id_id_6;
    BOOLEAN Diff_id_id_7;
    BOOLEAN Diff_id_id_8;
    BOOLEAN Diff_id_id_9;
    BOOLEAN Diff_id_id_10;
    BOOLEAN Diff_id_type_1;
    BOOLEAN Diff_id_type_2;
    BOOLEAN Diff_id_type_3;
    BOOLEAN Diff_id_type_4;
    BOOLEAN Diff_id_type_5;
    BOOLEAN Diff_id_type_6;
    BOOLEAN Diff_id_type_7;
    BOOLEAN Diff_id_type_8;
    BOOLEAN Diff_id_type_9;
    BOOLEAN Diff_id_type_10;
    BOOLEAN Diff_id_number_1;
    BOOLEAN Diff_id_number_2;
    BOOLEAN Diff_id_number_3;
    BOOLEAN Diff_id_number_4;
    BOOLEAN Diff_id_number_5;
    BOOLEAN Diff_id_number_6;
    BOOLEAN Diff_id_number_7;
    BOOLEAN Diff_id_number_8;
    BOOLEAN Diff_id_number_9;
    BOOLEAN Diff_id_number_10;
    BOOLEAN Diff_id_country_1;
    BOOLEAN Diff_id_country_2;
    BOOLEAN Diff_id_country_3;
    BOOLEAN Diff_id_country_4;
    BOOLEAN Diff_id_country_5;
    BOOLEAN Diff_id_country_6;
    BOOLEAN Diff_id_country_7;
    BOOLEAN Diff_id_country_8;
    BOOLEAN Diff_id_country_9;
    BOOLEAN Diff_id_country_10;
    BOOLEAN Diff_id_issue_date_1;
    BOOLEAN Diff_id_issue_date_2;
    BOOLEAN Diff_id_issue_date_3;
    BOOLEAN Diff_id_issue_date_4;
    BOOLEAN Diff_id_issue_date_5;
    BOOLEAN Diff_id_issue_date_6;
    BOOLEAN Diff_id_issue_date_7;
    BOOLEAN Diff_id_issue_date_8;
    BOOLEAN Diff_id_issue_date_9;
    BOOLEAN Diff_id_issue_date_10;
    BOOLEAN Diff_id_expiration_date_1;
    BOOLEAN Diff_id_expiration_date_2;
    BOOLEAN Diff_id_expiration_date_3;
    BOOLEAN Diff_id_expiration_date_4;
    BOOLEAN Diff_id_expiration_date_5;
    BOOLEAN Diff_id_expiration_date_6;
    BOOLEAN Diff_id_expiration_date_7;
    BOOLEAN Diff_id_expiration_date_8;
    BOOLEAN Diff_id_expiration_date_9;
    BOOLEAN Diff_id_expiration_date_10;
    BOOLEAN Diff_nationality_id_1;
    BOOLEAN Diff_nationality_id_2;
    BOOLEAN Diff_nationality_id_3;
    BOOLEAN Diff_nationality_id_4;
    BOOLEAN Diff_nationality_id_5;
    BOOLEAN Diff_nationality_id_6;
    BOOLEAN Diff_nationality_id_7;
    BOOLEAN Diff_nationality_id_8;
    BOOLEAN Diff_nationality_id_9;
    BOOLEAN Diff_nationality_id_10;
    BOOLEAN Diff_nationality_1;
    BOOLEAN Diff_nationality_2;
    BOOLEAN Diff_nationality_3;
    BOOLEAN Diff_nationality_4;
    BOOLEAN Diff_nationality_5;
    BOOLEAN Diff_nationality_6;
    BOOLEAN Diff_nationality_7;
    BOOLEAN Diff_nationality_8;
    BOOLEAN Diff_nationality_9;
    BOOLEAN Diff_nationality_10;
    BOOLEAN Diff_primary_nationality_flag_1;
    BOOLEAN Diff_primary_nationality_flag_2;
    BOOLEAN Diff_primary_nationality_flag_3;
    BOOLEAN Diff_primary_nationality_flag_4;
    BOOLEAN Diff_primary_nationality_flag_5;
    BOOLEAN Diff_primary_nationality_flag_6;
    BOOLEAN Diff_primary_nationality_flag_7;
    BOOLEAN Diff_primary_nationality_flag_8;
    BOOLEAN Diff_primary_nationality_flag_9;
    BOOLEAN Diff_primary_nationality_flag_10;
    BOOLEAN Diff_citizenship_id_1;
    BOOLEAN Diff_citizenship_id_2;
    BOOLEAN Diff_citizenship_id_3;
    BOOLEAN Diff_citizenship_id_4;
    BOOLEAN Diff_citizenship_id_5;
    BOOLEAN Diff_citizenship_id_6;
    BOOLEAN Diff_citizenship_id_7;
    BOOLEAN Diff_citizenship_id_8;
    BOOLEAN Diff_citizenship_id_9;
    BOOLEAN Diff_citizenship_id_10;
    BOOLEAN Diff_citizenship_1;
    BOOLEAN Diff_citizenship_2;
    BOOLEAN Diff_citizenship_3;
    BOOLEAN Diff_citizenship_4;
    BOOLEAN Diff_citizenship_5;
    BOOLEAN Diff_citizenship_6;
    BOOLEAN Diff_citizenship_7;
    BOOLEAN Diff_citizenship_8;
    BOOLEAN Diff_citizenship_9;
    BOOLEAN Diff_citizenship_10;
    BOOLEAN Diff_primary_citizenship_flag_1;
    BOOLEAN Diff_primary_citizenship_flag_2;
    BOOLEAN Diff_primary_citizenship_flag_3;
    BOOLEAN Diff_primary_citizenship_flag_4;
    BOOLEAN Diff_primary_citizenship_flag_5;
    BOOLEAN Diff_primary_citizenship_flag_6;
    BOOLEAN Diff_primary_citizenship_flag_7;
    BOOLEAN Diff_primary_citizenship_flag_8;
    BOOLEAN Diff_primary_citizenship_flag_9;
    BOOLEAN Diff_primary_citizenship_flag_10;
    BOOLEAN Diff_dob_id_1;
    BOOLEAN Diff_dob_id_2;
    BOOLEAN Diff_dob_id_3;
    BOOLEAN Diff_dob_id_4;
    BOOLEAN Diff_dob_id_5;
    BOOLEAN Diff_dob_id_6;
    BOOLEAN Diff_dob_id_7;
    BOOLEAN Diff_dob_id_8;
    BOOLEAN Diff_dob_id_9;
    BOOLEAN Diff_dob_id_10;
    BOOLEAN Diff_dob_1;
    BOOLEAN Diff_dob_2;
    BOOLEAN Diff_dob_3;
    BOOLEAN Diff_dob_4;
    BOOLEAN Diff_dob_5;
    BOOLEAN Diff_dob_6;
    BOOLEAN Diff_dob_7;
    BOOLEAN Diff_dob_8;
    BOOLEAN Diff_dob_9;
    BOOLEAN Diff_dob_10;
    BOOLEAN Diff_primary_dob_flag_1;
    BOOLEAN Diff_primary_dob_flag_2;
    BOOLEAN Diff_primary_dob_flag_3;
    BOOLEAN Diff_primary_dob_flag_4;
    BOOLEAN Diff_primary_dob_flag_5;
    BOOLEAN Diff_primary_dob_flag_6;
    BOOLEAN Diff_primary_dob_flag_7;
    BOOLEAN Diff_primary_dob_flag_8;
    BOOLEAN Diff_primary_dob_flag_9;
    BOOLEAN Diff_primary_dob_flag_10;
    BOOLEAN Diff_pob_id_1;
    BOOLEAN Diff_pob_id_2;
    BOOLEAN Diff_pob_id_3;
    BOOLEAN Diff_pob_id_4;
    BOOLEAN Diff_pob_id_5;
    BOOLEAN Diff_pob_id_6;
    BOOLEAN Diff_pob_id_7;
    BOOLEAN Diff_pob_id_8;
    BOOLEAN Diff_pob_id_9;
    BOOLEAN Diff_pob_id_10;
    BOOLEAN Diff_pob_1;
    BOOLEAN Diff_pob_2;
    BOOLEAN Diff_pob_3;
    BOOLEAN Diff_pob_4;
    BOOLEAN Diff_pob_5;
    BOOLEAN Diff_pob_6;
    BOOLEAN Diff_pob_7;
    BOOLEAN Diff_pob_8;
    BOOLEAN Diff_pob_9;
    BOOLEAN Diff_pob_10;
    BOOLEAN Diff_country_of_birth_1;
    BOOLEAN Diff_country_of_birth_2;
    BOOLEAN Diff_country_of_birth_3;
    BOOLEAN Diff_country_of_birth_4;
    BOOLEAN Diff_country_of_birth_5;
    BOOLEAN Diff_country_of_birth_6;
    BOOLEAN Diff_country_of_birth_7;
    BOOLEAN Diff_country_of_birth_8;
    BOOLEAN Diff_country_of_birth_9;
    BOOLEAN Diff_country_of_birth_10;
    BOOLEAN Diff_primary_pob_flag_1;
    BOOLEAN Diff_primary_pob_flag_2;
    BOOLEAN Diff_primary_pob_flag_3;
    BOOLEAN Diff_primary_pob_flag_4;
    BOOLEAN Diff_primary_pob_flag_5;
    BOOLEAN Diff_primary_pob_flag_6;
    BOOLEAN Diff_primary_pob_flag_7;
    BOOLEAN Diff_primary_pob_flag_8;
    BOOLEAN Diff_primary_pob_flag_9;
    BOOLEAN Diff_primary_pob_flag_10;
    BOOLEAN Diff_language_1;
    BOOLEAN Diff_language_2;
    BOOLEAN Diff_language_3;
    BOOLEAN Diff_language_4;
    BOOLEAN Diff_language_5;
    BOOLEAN Diff_language_6;
    BOOLEAN Diff_language_7;
    BOOLEAN Diff_language_8;
    BOOLEAN Diff_language_9;
    BOOLEAN Diff_language_10;
    BOOLEAN Diff_membership_1;
    BOOLEAN Diff_membership_2;
    BOOLEAN Diff_membership_3;
    BOOLEAN Diff_membership_4;
    BOOLEAN Diff_membership_5;
    BOOLEAN Diff_membership_6;
    BOOLEAN Diff_membership_7;
    BOOLEAN Diff_membership_8;
    BOOLEAN Diff_membership_9;
    BOOLEAN Diff_membership_10;
    BOOLEAN Diff_position_1;
    BOOLEAN Diff_position_2;
    BOOLEAN Diff_position_3;
    BOOLEAN Diff_position_4;
    BOOLEAN Diff_position_5;
    BOOLEAN Diff_position_6;
    BOOLEAN Diff_position_7;
    BOOLEAN Diff_position_8;
    BOOLEAN Diff_position_9;
    BOOLEAN Diff_position_10;
    BOOLEAN Diff_occupation_1;
    BOOLEAN Diff_occupation_2;
    BOOLEAN Diff_occupation_3;
    BOOLEAN Diff_occupation_4;
    BOOLEAN Diff_occupation_5;
    BOOLEAN Diff_occupation_6;
    BOOLEAN Diff_occupation_7;
    BOOLEAN Diff_occupation_8;
    BOOLEAN Diff_occupation_9;
    BOOLEAN Diff_occupation_10;
    BOOLEAN Diff_date_added_to_list;
    BOOLEAN Diff_date_last_updated;
    BOOLEAN Diff_effective_date;
    BOOLEAN Diff_expiration_date;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_grounds;
    BOOLEAN Diff_subj_to_common_pos_2001_931_cfsp_fl;
    BOOLEAN Diff_federal_register_citation_1;
    BOOLEAN Diff_federal_register_citation_2;
    BOOLEAN Diff_federal_register_citation_3;
    BOOLEAN Diff_federal_register_citation_4;
    BOOLEAN Diff_federal_register_citation_5;
    BOOLEAN Diff_federal_register_citation_6;
    BOOLEAN Diff_federal_register_citation_7;
    BOOLEAN Diff_federal_register_citation_8;
    BOOLEAN Diff_federal_register_citation_9;
    BOOLEAN Diff_federal_register_citation_10;
    BOOLEAN Diff_federal_register_citation_date_1;
    BOOLEAN Diff_federal_register_citation_date_2;
    BOOLEAN Diff_federal_register_citation_date_3;
    BOOLEAN Diff_federal_register_citation_date_4;
    BOOLEAN Diff_federal_register_citation_date_5;
    BOOLEAN Diff_federal_register_citation_date_6;
    BOOLEAN Diff_federal_register_citation_date_7;
    BOOLEAN Diff_federal_register_citation_date_8;
    BOOLEAN Diff_federal_register_citation_date_9;
    BOOLEAN Diff_federal_register_citation_date_10;
    BOOLEAN Diff_license_requirement;
    BOOLEAN Diff_license_review_policy;
    BOOLEAN Diff_subordinate_status;
    BOOLEAN Diff_height;
    BOOLEAN Diff_weight;
    BOOLEAN Diff_physique;
    BOOLEAN Diff_hair_color;
    BOOLEAN Diff_eyes;
    BOOLEAN Diff_complexion;
    BOOLEAN Diff_race;
    BOOLEAN Diff_scars_marks;
    BOOLEAN Diff_photo_file;
    BOOLEAN Diff_offenses;
    BOOLEAN Diff_ncic;
    BOOLEAN Diff_warrant_by;
    BOOLEAN Diff_caution;
    BOOLEAN Diff_reward;
    BOOLEAN Diff_type_of_denial;
    BOOLEAN Diff_linked_with_1;
    BOOLEAN Diff_linked_with_2;
    BOOLEAN Diff_linked_with_3;
    BOOLEAN Diff_linked_with_4;
    BOOLEAN Diff_linked_with_5;
    BOOLEAN Diff_linked_with_6;
    BOOLEAN Diff_linked_with_7;
    BOOLEAN Diff_linked_with_8;
    BOOLEAN Diff_linked_with_9;
    BOOLEAN Diff_linked_with_10;
    BOOLEAN Diff_linked_with_id_1;
    BOOLEAN Diff_linked_with_id_2;
    BOOLEAN Diff_linked_with_id_3;
    BOOLEAN Diff_linked_with_id_4;
    BOOLEAN Diff_linked_with_id_5;
    BOOLEAN Diff_linked_with_id_6;
    BOOLEAN Diff_linked_with_id_7;
    BOOLEAN Diff_linked_with_id_8;
    BOOLEAN Diff_linked_with_id_9;
    BOOLEAN Diff_linked_with_id_10;
    BOOLEAN Diff_listing_information;
    BOOLEAN Diff_foreign_principal;
    BOOLEAN Diff_nature_of_service;
    BOOLEAN Diff_activities;
    BOOLEAN Diff_finances;
    BOOLEAN Diff_registrant_terminated_flag;
    BOOLEAN Diff_foreign_principal_terminated_flag;
    BOOLEAN Diff_short_form_terminated_flag;
    BOOLEAN Diff_src_key;
    SALT34.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT34.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_pty_key := le.pty_key <> ri.pty_key;
    SELF.Diff_source := le.source <> ri.source;
    SELF.Diff_orig_pty_name := le.orig_pty_name <> ri.orig_pty_name;
    SELF.Diff_orig_vessel_name := le.orig_vessel_name <> ri.orig_vessel_name;
    SELF.Diff_country := le.country <> ri.country;
    SELF.Diff_name_type := le.name_type <> ri.name_type;
    SELF.Diff_addr_1 := le.addr_1 <> ri.addr_1;
    SELF.Diff_addr_2 := le.addr_2 <> ri.addr_2;
    SELF.Diff_addr_3 := le.addr_3 <> ri.addr_3;
    SELF.Diff_addr_4 := le.addr_4 <> ri.addr_4;
    SELF.Diff_addr_5 := le.addr_5 <> ri.addr_5;
    SELF.Diff_addr_6 := le.addr_6 <> ri.addr_6;
    SELF.Diff_addr_7 := le.addr_7 <> ri.addr_7;
    SELF.Diff_addr_8 := le.addr_8 <> ri.addr_8;
    SELF.Diff_addr_9 := le.addr_9 <> ri.addr_9;
    SELF.Diff_addr_10 := le.addr_10 <> ri.addr_10;
    SELF.Diff_remarks_1 := le.remarks_1 <> ri.remarks_1;
    SELF.Diff_remarks_2 := le.remarks_2 <> ri.remarks_2;
    SELF.Diff_remarks_3 := le.remarks_3 <> ri.remarks_3;
    SELF.Diff_remarks_4 := le.remarks_4 <> ri.remarks_4;
    SELF.Diff_remarks_5 := le.remarks_5 <> ri.remarks_5;
    SELF.Diff_remarks_6 := le.remarks_6 <> ri.remarks_6;
    SELF.Diff_remarks_7 := le.remarks_7 <> ri.remarks_7;
    SELF.Diff_remarks_8 := le.remarks_8 <> ri.remarks_8;
    SELF.Diff_remarks_9 := le.remarks_9 <> ri.remarks_9;
    SELF.Diff_remarks_10 := le.remarks_10 <> ri.remarks_10;
    SELF.Diff_remarks_11 := le.remarks_11 <> ri.remarks_11;
    SELF.Diff_remarks_12 := le.remarks_12 <> ri.remarks_12;
    SELF.Diff_remarks_13 := le.remarks_13 <> ri.remarks_13;
    SELF.Diff_remarks_14 := le.remarks_14 <> ri.remarks_14;
    SELF.Diff_remarks_15 := le.remarks_15 <> ri.remarks_15;
    SELF.Diff_remarks_16 := le.remarks_16 <> ri.remarks_16;
    SELF.Diff_remarks_17 := le.remarks_17 <> ri.remarks_17;
    SELF.Diff_remarks_18 := le.remarks_18 <> ri.remarks_18;
    SELF.Diff_remarks_19 := le.remarks_19 <> ri.remarks_19;
    SELF.Diff_remarks_20 := le.remarks_20 <> ri.remarks_20;
    SELF.Diff_remarks_21 := le.remarks_21 <> ri.remarks_21;
    SELF.Diff_remarks_22 := le.remarks_22 <> ri.remarks_22;
    SELF.Diff_remarks_23 := le.remarks_23 <> ri.remarks_23;
    SELF.Diff_remarks_24 := le.remarks_24 <> ri.remarks_24;
    SELF.Diff_remarks_25 := le.remarks_25 <> ri.remarks_25;
    SELF.Diff_remarks_26 := le.remarks_26 <> ri.remarks_26;
    SELF.Diff_remarks_27 := le.remarks_27 <> ri.remarks_27;
    SELF.Diff_remarks_28 := le.remarks_28 <> ri.remarks_28;
    SELF.Diff_remarks_29 := le.remarks_29 <> ri.remarks_29;
    SELF.Diff_remarks_30 := le.remarks_30 <> ri.remarks_30;
    SELF.Diff_cname := le.cname <> ri.cname;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_a_score := le.a_score <> ri.a_score;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_addr_suffix := le.addr_suffix <> ri.addr_suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_p_city_name := le.p_city_name <> ri.p_city_name;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_cart := le.cart <> ri.cart;
    SELF.Diff_cr_sort_sz := le.cr_sort_sz <> ri.cr_sort_sz;
    SELF.Diff_lot := le.lot <> ri.lot;
    SELF.Diff_lot_order := le.lot_order <> ri.lot_order;
    SELF.Diff_dpbc := le.dpbc <> ri.dpbc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_ace_fips_st := le.ace_fips_st <> ri.ace_fips_st;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_date_first_seen := le.date_first_seen <> ri.date_first_seen;
    SELF.Diff_date_last_seen := le.date_last_seen <> ri.date_last_seen;
    SELF.Diff_date_vendor_first_reported := le.date_vendor_first_reported <> ri.date_vendor_first_reported;
    SELF.Diff_date_vendor_last_reported := le.date_vendor_last_reported <> ri.date_vendor_last_reported;
    SELF.Diff_entity_id := le.entity_id <> ri.entity_id;
    SELF.Diff_first_name := le.first_name <> ri.first_name;
    SELF.Diff_last_name := le.last_name <> ri.last_name;
    SELF.Diff_title_1 := le.title_1 <> ri.title_1;
    SELF.Diff_title_2 := le.title_2 <> ri.title_2;
    SELF.Diff_title_3 := le.title_3 <> ri.title_3;
    SELF.Diff_title_4 := le.title_4 <> ri.title_4;
    SELF.Diff_title_5 := le.title_5 <> ri.title_5;
    SELF.Diff_title_6 := le.title_6 <> ri.title_6;
    SELF.Diff_title_7 := le.title_7 <> ri.title_7;
    SELF.Diff_title_8 := le.title_8 <> ri.title_8;
    SELF.Diff_title_9 := le.title_9 <> ri.title_9;
    SELF.Diff_title_10 := le.title_10 <> ri.title_10;
    SELF.Diff_aka_id := le.aka_id <> ri.aka_id;
    SELF.Diff_aka_type := le.aka_type <> ri.aka_type;
    SELF.Diff_aka_category := le.aka_category <> ri.aka_category;
    SELF.Diff_giv_designator := le.giv_designator <> ri.giv_designator;
    SELF.Diff_entity_type := le.entity_type <> ri.entity_type;
    SELF.Diff_address_id := le.address_id <> ri.address_id;
    SELF.Diff_address_line_1 := le.address_line_1 <> ri.address_line_1;
    SELF.Diff_address_line_2 := le.address_line_2 <> ri.address_line_2;
    SELF.Diff_address_line_3 := le.address_line_3 <> ri.address_line_3;
    SELF.Diff_address_city := le.address_city <> ri.address_city;
    SELF.Diff_address_state_province := le.address_state_province <> ri.address_state_province;
    SELF.Diff_address_postal_code := le.address_postal_code <> ri.address_postal_code;
    SELF.Diff_address_country := le.address_country <> ri.address_country;
    SELF.Diff_remarks := le.remarks <> ri.remarks;
    SELF.Diff_call_sign := le.call_sign <> ri.call_sign;
    SELF.Diff_vessel_type := le.vessel_type <> ri.vessel_type;
    SELF.Diff_tonnage := le.tonnage <> ri.tonnage;
    SELF.Diff_gross_registered_tonnage := le.gross_registered_tonnage <> ri.gross_registered_tonnage;
    SELF.Diff_vessel_flag := le.vessel_flag <> ri.vessel_flag;
    SELF.Diff_vessel_owner := le.vessel_owner <> ri.vessel_owner;
    SELF.Diff_sanctions_program_1 := le.sanctions_program_1 <> ri.sanctions_program_1;
    SELF.Diff_sanctions_program_2 := le.sanctions_program_2 <> ri.sanctions_program_2;
    SELF.Diff_sanctions_program_3 := le.sanctions_program_3 <> ri.sanctions_program_3;
    SELF.Diff_sanctions_program_4 := le.sanctions_program_4 <> ri.sanctions_program_4;
    SELF.Diff_sanctions_program_5 := le.sanctions_program_5 <> ri.sanctions_program_5;
    SELF.Diff_sanctions_program_6 := le.sanctions_program_6 <> ri.sanctions_program_6;
    SELF.Diff_sanctions_program_7 := le.sanctions_program_7 <> ri.sanctions_program_7;
    SELF.Diff_sanctions_program_8 := le.sanctions_program_8 <> ri.sanctions_program_8;
    SELF.Diff_sanctions_program_9 := le.sanctions_program_9 <> ri.sanctions_program_9;
    SELF.Diff_sanctions_program_10 := le.sanctions_program_10 <> ri.sanctions_program_10;
    SELF.Diff_passport_details := le.passport_details <> ri.passport_details;
    SELF.Diff_ni_number_details := le.ni_number_details <> ri.ni_number_details;
    SELF.Diff_id_id_1 := le.id_id_1 <> ri.id_id_1;
    SELF.Diff_id_id_2 := le.id_id_2 <> ri.id_id_2;
    SELF.Diff_id_id_3 := le.id_id_3 <> ri.id_id_3;
    SELF.Diff_id_id_4 := le.id_id_4 <> ri.id_id_4;
    SELF.Diff_id_id_5 := le.id_id_5 <> ri.id_id_5;
    SELF.Diff_id_id_6 := le.id_id_6 <> ri.id_id_6;
    SELF.Diff_id_id_7 := le.id_id_7 <> ri.id_id_7;
    SELF.Diff_id_id_8 := le.id_id_8 <> ri.id_id_8;
    SELF.Diff_id_id_9 := le.id_id_9 <> ri.id_id_9;
    SELF.Diff_id_id_10 := le.id_id_10 <> ri.id_id_10;
    SELF.Diff_id_type_1 := le.id_type_1 <> ri.id_type_1;
    SELF.Diff_id_type_2 := le.id_type_2 <> ri.id_type_2;
    SELF.Diff_id_type_3 := le.id_type_3 <> ri.id_type_3;
    SELF.Diff_id_type_4 := le.id_type_4 <> ri.id_type_4;
    SELF.Diff_id_type_5 := le.id_type_5 <> ri.id_type_5;
    SELF.Diff_id_type_6 := le.id_type_6 <> ri.id_type_6;
    SELF.Diff_id_type_7 := le.id_type_7 <> ri.id_type_7;
    SELF.Diff_id_type_8 := le.id_type_8 <> ri.id_type_8;
    SELF.Diff_id_type_9 := le.id_type_9 <> ri.id_type_9;
    SELF.Diff_id_type_10 := le.id_type_10 <> ri.id_type_10;
    SELF.Diff_id_number_1 := le.id_number_1 <> ri.id_number_1;
    SELF.Diff_id_number_2 := le.id_number_2 <> ri.id_number_2;
    SELF.Diff_id_number_3 := le.id_number_3 <> ri.id_number_3;
    SELF.Diff_id_number_4 := le.id_number_4 <> ri.id_number_4;
    SELF.Diff_id_number_5 := le.id_number_5 <> ri.id_number_5;
    SELF.Diff_id_number_6 := le.id_number_6 <> ri.id_number_6;
    SELF.Diff_id_number_7 := le.id_number_7 <> ri.id_number_7;
    SELF.Diff_id_number_8 := le.id_number_8 <> ri.id_number_8;
    SELF.Diff_id_number_9 := le.id_number_9 <> ri.id_number_9;
    SELF.Diff_id_number_10 := le.id_number_10 <> ri.id_number_10;
    SELF.Diff_id_country_1 := le.id_country_1 <> ri.id_country_1;
    SELF.Diff_id_country_2 := le.id_country_2 <> ri.id_country_2;
    SELF.Diff_id_country_3 := le.id_country_3 <> ri.id_country_3;
    SELF.Diff_id_country_4 := le.id_country_4 <> ri.id_country_4;
    SELF.Diff_id_country_5 := le.id_country_5 <> ri.id_country_5;
    SELF.Diff_id_country_6 := le.id_country_6 <> ri.id_country_6;
    SELF.Diff_id_country_7 := le.id_country_7 <> ri.id_country_7;
    SELF.Diff_id_country_8 := le.id_country_8 <> ri.id_country_8;
    SELF.Diff_id_country_9 := le.id_country_9 <> ri.id_country_9;
    SELF.Diff_id_country_10 := le.id_country_10 <> ri.id_country_10;
    SELF.Diff_id_issue_date_1 := le.id_issue_date_1 <> ri.id_issue_date_1;
    SELF.Diff_id_issue_date_2 := le.id_issue_date_2 <> ri.id_issue_date_2;
    SELF.Diff_id_issue_date_3 := le.id_issue_date_3 <> ri.id_issue_date_3;
    SELF.Diff_id_issue_date_4 := le.id_issue_date_4 <> ri.id_issue_date_4;
    SELF.Diff_id_issue_date_5 := le.id_issue_date_5 <> ri.id_issue_date_5;
    SELF.Diff_id_issue_date_6 := le.id_issue_date_6 <> ri.id_issue_date_6;
    SELF.Diff_id_issue_date_7 := le.id_issue_date_7 <> ri.id_issue_date_7;
    SELF.Diff_id_issue_date_8 := le.id_issue_date_8 <> ri.id_issue_date_8;
    SELF.Diff_id_issue_date_9 := le.id_issue_date_9 <> ri.id_issue_date_9;
    SELF.Diff_id_issue_date_10 := le.id_issue_date_10 <> ri.id_issue_date_10;
    SELF.Diff_id_expiration_date_1 := le.id_expiration_date_1 <> ri.id_expiration_date_1;
    SELF.Diff_id_expiration_date_2 := le.id_expiration_date_2 <> ri.id_expiration_date_2;
    SELF.Diff_id_expiration_date_3 := le.id_expiration_date_3 <> ri.id_expiration_date_3;
    SELF.Diff_id_expiration_date_4 := le.id_expiration_date_4 <> ri.id_expiration_date_4;
    SELF.Diff_id_expiration_date_5 := le.id_expiration_date_5 <> ri.id_expiration_date_5;
    SELF.Diff_id_expiration_date_6 := le.id_expiration_date_6 <> ri.id_expiration_date_6;
    SELF.Diff_id_expiration_date_7 := le.id_expiration_date_7 <> ri.id_expiration_date_7;
    SELF.Diff_id_expiration_date_8 := le.id_expiration_date_8 <> ri.id_expiration_date_8;
    SELF.Diff_id_expiration_date_9 := le.id_expiration_date_9 <> ri.id_expiration_date_9;
    SELF.Diff_id_expiration_date_10 := le.id_expiration_date_10 <> ri.id_expiration_date_10;
    SELF.Diff_nationality_id_1 := le.nationality_id_1 <> ri.nationality_id_1;
    SELF.Diff_nationality_id_2 := le.nationality_id_2 <> ri.nationality_id_2;
    SELF.Diff_nationality_id_3 := le.nationality_id_3 <> ri.nationality_id_3;
    SELF.Diff_nationality_id_4 := le.nationality_id_4 <> ri.nationality_id_4;
    SELF.Diff_nationality_id_5 := le.nationality_id_5 <> ri.nationality_id_5;
    SELF.Diff_nationality_id_6 := le.nationality_id_6 <> ri.nationality_id_6;
    SELF.Diff_nationality_id_7 := le.nationality_id_7 <> ri.nationality_id_7;
    SELF.Diff_nationality_id_8 := le.nationality_id_8 <> ri.nationality_id_8;
    SELF.Diff_nationality_id_9 := le.nationality_id_9 <> ri.nationality_id_9;
    SELF.Diff_nationality_id_10 := le.nationality_id_10 <> ri.nationality_id_10;
    SELF.Diff_nationality_1 := le.nationality_1 <> ri.nationality_1;
    SELF.Diff_nationality_2 := le.nationality_2 <> ri.nationality_2;
    SELF.Diff_nationality_3 := le.nationality_3 <> ri.nationality_3;
    SELF.Diff_nationality_4 := le.nationality_4 <> ri.nationality_4;
    SELF.Diff_nationality_5 := le.nationality_5 <> ri.nationality_5;
    SELF.Diff_nationality_6 := le.nationality_6 <> ri.nationality_6;
    SELF.Diff_nationality_7 := le.nationality_7 <> ri.nationality_7;
    SELF.Diff_nationality_8 := le.nationality_8 <> ri.nationality_8;
    SELF.Diff_nationality_9 := le.nationality_9 <> ri.nationality_9;
    SELF.Diff_nationality_10 := le.nationality_10 <> ri.nationality_10;
    SELF.Diff_primary_nationality_flag_1 := le.primary_nationality_flag_1 <> ri.primary_nationality_flag_1;
    SELF.Diff_primary_nationality_flag_2 := le.primary_nationality_flag_2 <> ri.primary_nationality_flag_2;
    SELF.Diff_primary_nationality_flag_3 := le.primary_nationality_flag_3 <> ri.primary_nationality_flag_3;
    SELF.Diff_primary_nationality_flag_4 := le.primary_nationality_flag_4 <> ri.primary_nationality_flag_4;
    SELF.Diff_primary_nationality_flag_5 := le.primary_nationality_flag_5 <> ri.primary_nationality_flag_5;
    SELF.Diff_primary_nationality_flag_6 := le.primary_nationality_flag_6 <> ri.primary_nationality_flag_6;
    SELF.Diff_primary_nationality_flag_7 := le.primary_nationality_flag_7 <> ri.primary_nationality_flag_7;
    SELF.Diff_primary_nationality_flag_8 := le.primary_nationality_flag_8 <> ri.primary_nationality_flag_8;
    SELF.Diff_primary_nationality_flag_9 := le.primary_nationality_flag_9 <> ri.primary_nationality_flag_9;
    SELF.Diff_primary_nationality_flag_10 := le.primary_nationality_flag_10 <> ri.primary_nationality_flag_10;
    SELF.Diff_citizenship_id_1 := le.citizenship_id_1 <> ri.citizenship_id_1;
    SELF.Diff_citizenship_id_2 := le.citizenship_id_2 <> ri.citizenship_id_2;
    SELF.Diff_citizenship_id_3 := le.citizenship_id_3 <> ri.citizenship_id_3;
    SELF.Diff_citizenship_id_4 := le.citizenship_id_4 <> ri.citizenship_id_4;
    SELF.Diff_citizenship_id_5 := le.citizenship_id_5 <> ri.citizenship_id_5;
    SELF.Diff_citizenship_id_6 := le.citizenship_id_6 <> ri.citizenship_id_6;
    SELF.Diff_citizenship_id_7 := le.citizenship_id_7 <> ri.citizenship_id_7;
    SELF.Diff_citizenship_id_8 := le.citizenship_id_8 <> ri.citizenship_id_8;
    SELF.Diff_citizenship_id_9 := le.citizenship_id_9 <> ri.citizenship_id_9;
    SELF.Diff_citizenship_id_10 := le.citizenship_id_10 <> ri.citizenship_id_10;
    SELF.Diff_citizenship_1 := le.citizenship_1 <> ri.citizenship_1;
    SELF.Diff_citizenship_2 := le.citizenship_2 <> ri.citizenship_2;
    SELF.Diff_citizenship_3 := le.citizenship_3 <> ri.citizenship_3;
    SELF.Diff_citizenship_4 := le.citizenship_4 <> ri.citizenship_4;
    SELF.Diff_citizenship_5 := le.citizenship_5 <> ri.citizenship_5;
    SELF.Diff_citizenship_6 := le.citizenship_6 <> ri.citizenship_6;
    SELF.Diff_citizenship_7 := le.citizenship_7 <> ri.citizenship_7;
    SELF.Diff_citizenship_8 := le.citizenship_8 <> ri.citizenship_8;
    SELF.Diff_citizenship_9 := le.citizenship_9 <> ri.citizenship_9;
    SELF.Diff_citizenship_10 := le.citizenship_10 <> ri.citizenship_10;
    SELF.Diff_primary_citizenship_flag_1 := le.primary_citizenship_flag_1 <> ri.primary_citizenship_flag_1;
    SELF.Diff_primary_citizenship_flag_2 := le.primary_citizenship_flag_2 <> ri.primary_citizenship_flag_2;
    SELF.Diff_primary_citizenship_flag_3 := le.primary_citizenship_flag_3 <> ri.primary_citizenship_flag_3;
    SELF.Diff_primary_citizenship_flag_4 := le.primary_citizenship_flag_4 <> ri.primary_citizenship_flag_4;
    SELF.Diff_primary_citizenship_flag_5 := le.primary_citizenship_flag_5 <> ri.primary_citizenship_flag_5;
    SELF.Diff_primary_citizenship_flag_6 := le.primary_citizenship_flag_6 <> ri.primary_citizenship_flag_6;
    SELF.Diff_primary_citizenship_flag_7 := le.primary_citizenship_flag_7 <> ri.primary_citizenship_flag_7;
    SELF.Diff_primary_citizenship_flag_8 := le.primary_citizenship_flag_8 <> ri.primary_citizenship_flag_8;
    SELF.Diff_primary_citizenship_flag_9 := le.primary_citizenship_flag_9 <> ri.primary_citizenship_flag_9;
    SELF.Diff_primary_citizenship_flag_10 := le.primary_citizenship_flag_10 <> ri.primary_citizenship_flag_10;
    SELF.Diff_dob_id_1 := le.dob_id_1 <> ri.dob_id_1;
    SELF.Diff_dob_id_2 := le.dob_id_2 <> ri.dob_id_2;
    SELF.Diff_dob_id_3 := le.dob_id_3 <> ri.dob_id_3;
    SELF.Diff_dob_id_4 := le.dob_id_4 <> ri.dob_id_4;
    SELF.Diff_dob_id_5 := le.dob_id_5 <> ri.dob_id_5;
    SELF.Diff_dob_id_6 := le.dob_id_6 <> ri.dob_id_6;
    SELF.Diff_dob_id_7 := le.dob_id_7 <> ri.dob_id_7;
    SELF.Diff_dob_id_8 := le.dob_id_8 <> ri.dob_id_8;
    SELF.Diff_dob_id_9 := le.dob_id_9 <> ri.dob_id_9;
    SELF.Diff_dob_id_10 := le.dob_id_10 <> ri.dob_id_10;
    SELF.Diff_dob_1 := le.dob_1 <> ri.dob_1;
    SELF.Diff_dob_2 := le.dob_2 <> ri.dob_2;
    SELF.Diff_dob_3 := le.dob_3 <> ri.dob_3;
    SELF.Diff_dob_4 := le.dob_4 <> ri.dob_4;
    SELF.Diff_dob_5 := le.dob_5 <> ri.dob_5;
    SELF.Diff_dob_6 := le.dob_6 <> ri.dob_6;
    SELF.Diff_dob_7 := le.dob_7 <> ri.dob_7;
    SELF.Diff_dob_8 := le.dob_8 <> ri.dob_8;
    SELF.Diff_dob_9 := le.dob_9 <> ri.dob_9;
    SELF.Diff_dob_10 := le.dob_10 <> ri.dob_10;
    SELF.Diff_primary_dob_flag_1 := le.primary_dob_flag_1 <> ri.primary_dob_flag_1;
    SELF.Diff_primary_dob_flag_2 := le.primary_dob_flag_2 <> ri.primary_dob_flag_2;
    SELF.Diff_primary_dob_flag_3 := le.primary_dob_flag_3 <> ri.primary_dob_flag_3;
    SELF.Diff_primary_dob_flag_4 := le.primary_dob_flag_4 <> ri.primary_dob_flag_4;
    SELF.Diff_primary_dob_flag_5 := le.primary_dob_flag_5 <> ri.primary_dob_flag_5;
    SELF.Diff_primary_dob_flag_6 := le.primary_dob_flag_6 <> ri.primary_dob_flag_6;
    SELF.Diff_primary_dob_flag_7 := le.primary_dob_flag_7 <> ri.primary_dob_flag_7;
    SELF.Diff_primary_dob_flag_8 := le.primary_dob_flag_8 <> ri.primary_dob_flag_8;
    SELF.Diff_primary_dob_flag_9 := le.primary_dob_flag_9 <> ri.primary_dob_flag_9;
    SELF.Diff_primary_dob_flag_10 := le.primary_dob_flag_10 <> ri.primary_dob_flag_10;
    SELF.Diff_pob_id_1 := le.pob_id_1 <> ri.pob_id_1;
    SELF.Diff_pob_id_2 := le.pob_id_2 <> ri.pob_id_2;
    SELF.Diff_pob_id_3 := le.pob_id_3 <> ri.pob_id_3;
    SELF.Diff_pob_id_4 := le.pob_id_4 <> ri.pob_id_4;
    SELF.Diff_pob_id_5 := le.pob_id_5 <> ri.pob_id_5;
    SELF.Diff_pob_id_6 := le.pob_id_6 <> ri.pob_id_6;
    SELF.Diff_pob_id_7 := le.pob_id_7 <> ri.pob_id_7;
    SELF.Diff_pob_id_8 := le.pob_id_8 <> ri.pob_id_8;
    SELF.Diff_pob_id_9 := le.pob_id_9 <> ri.pob_id_9;
    SELF.Diff_pob_id_10 := le.pob_id_10 <> ri.pob_id_10;
    SELF.Diff_pob_1 := le.pob_1 <> ri.pob_1;
    SELF.Diff_pob_2 := le.pob_2 <> ri.pob_2;
    SELF.Diff_pob_3 := le.pob_3 <> ri.pob_3;
    SELF.Diff_pob_4 := le.pob_4 <> ri.pob_4;
    SELF.Diff_pob_5 := le.pob_5 <> ri.pob_5;
    SELF.Diff_pob_6 := le.pob_6 <> ri.pob_6;
    SELF.Diff_pob_7 := le.pob_7 <> ri.pob_7;
    SELF.Diff_pob_8 := le.pob_8 <> ri.pob_8;
    SELF.Diff_pob_9 := le.pob_9 <> ri.pob_9;
    SELF.Diff_pob_10 := le.pob_10 <> ri.pob_10;
    SELF.Diff_country_of_birth_1 := le.country_of_birth_1 <> ri.country_of_birth_1;
    SELF.Diff_country_of_birth_2 := le.country_of_birth_2 <> ri.country_of_birth_2;
    SELF.Diff_country_of_birth_3 := le.country_of_birth_3 <> ri.country_of_birth_3;
    SELF.Diff_country_of_birth_4 := le.country_of_birth_4 <> ri.country_of_birth_4;
    SELF.Diff_country_of_birth_5 := le.country_of_birth_5 <> ri.country_of_birth_5;
    SELF.Diff_country_of_birth_6 := le.country_of_birth_6 <> ri.country_of_birth_6;
    SELF.Diff_country_of_birth_7 := le.country_of_birth_7 <> ri.country_of_birth_7;
    SELF.Diff_country_of_birth_8 := le.country_of_birth_8 <> ri.country_of_birth_8;
    SELF.Diff_country_of_birth_9 := le.country_of_birth_9 <> ri.country_of_birth_9;
    SELF.Diff_country_of_birth_10 := le.country_of_birth_10 <> ri.country_of_birth_10;
    SELF.Diff_primary_pob_flag_1 := le.primary_pob_flag_1 <> ri.primary_pob_flag_1;
    SELF.Diff_primary_pob_flag_2 := le.primary_pob_flag_2 <> ri.primary_pob_flag_2;
    SELF.Diff_primary_pob_flag_3 := le.primary_pob_flag_3 <> ri.primary_pob_flag_3;
    SELF.Diff_primary_pob_flag_4 := le.primary_pob_flag_4 <> ri.primary_pob_flag_4;
    SELF.Diff_primary_pob_flag_5 := le.primary_pob_flag_5 <> ri.primary_pob_flag_5;
    SELF.Diff_primary_pob_flag_6 := le.primary_pob_flag_6 <> ri.primary_pob_flag_6;
    SELF.Diff_primary_pob_flag_7 := le.primary_pob_flag_7 <> ri.primary_pob_flag_7;
    SELF.Diff_primary_pob_flag_8 := le.primary_pob_flag_8 <> ri.primary_pob_flag_8;
    SELF.Diff_primary_pob_flag_9 := le.primary_pob_flag_9 <> ri.primary_pob_flag_9;
    SELF.Diff_primary_pob_flag_10 := le.primary_pob_flag_10 <> ri.primary_pob_flag_10;
    SELF.Diff_language_1 := le.language_1 <> ri.language_1;
    SELF.Diff_language_2 := le.language_2 <> ri.language_2;
    SELF.Diff_language_3 := le.language_3 <> ri.language_3;
    SELF.Diff_language_4 := le.language_4 <> ri.language_4;
    SELF.Diff_language_5 := le.language_5 <> ri.language_5;
    SELF.Diff_language_6 := le.language_6 <> ri.language_6;
    SELF.Diff_language_7 := le.language_7 <> ri.language_7;
    SELF.Diff_language_8 := le.language_8 <> ri.language_8;
    SELF.Diff_language_9 := le.language_9 <> ri.language_9;
    SELF.Diff_language_10 := le.language_10 <> ri.language_10;
    SELF.Diff_membership_1 := le.membership_1 <> ri.membership_1;
    SELF.Diff_membership_2 := le.membership_2 <> ri.membership_2;
    SELF.Diff_membership_3 := le.membership_3 <> ri.membership_3;
    SELF.Diff_membership_4 := le.membership_4 <> ri.membership_4;
    SELF.Diff_membership_5 := le.membership_5 <> ri.membership_5;
    SELF.Diff_membership_6 := le.membership_6 <> ri.membership_6;
    SELF.Diff_membership_7 := le.membership_7 <> ri.membership_7;
    SELF.Diff_membership_8 := le.membership_8 <> ri.membership_8;
    SELF.Diff_membership_9 := le.membership_9 <> ri.membership_9;
    SELF.Diff_membership_10 := le.membership_10 <> ri.membership_10;
    SELF.Diff_position_1 := le.position_1 <> ri.position_1;
    SELF.Diff_position_2 := le.position_2 <> ri.position_2;
    SELF.Diff_position_3 := le.position_3 <> ri.position_3;
    SELF.Diff_position_4 := le.position_4 <> ri.position_4;
    SELF.Diff_position_5 := le.position_5 <> ri.position_5;
    SELF.Diff_position_6 := le.position_6 <> ri.position_6;
    SELF.Diff_position_7 := le.position_7 <> ri.position_7;
    SELF.Diff_position_8 := le.position_8 <> ri.position_8;
    SELF.Diff_position_9 := le.position_9 <> ri.position_9;
    SELF.Diff_position_10 := le.position_10 <> ri.position_10;
    SELF.Diff_occupation_1 := le.occupation_1 <> ri.occupation_1;
    SELF.Diff_occupation_2 := le.occupation_2 <> ri.occupation_2;
    SELF.Diff_occupation_3 := le.occupation_3 <> ri.occupation_3;
    SELF.Diff_occupation_4 := le.occupation_4 <> ri.occupation_4;
    SELF.Diff_occupation_5 := le.occupation_5 <> ri.occupation_5;
    SELF.Diff_occupation_6 := le.occupation_6 <> ri.occupation_6;
    SELF.Diff_occupation_7 := le.occupation_7 <> ri.occupation_7;
    SELF.Diff_occupation_8 := le.occupation_8 <> ri.occupation_8;
    SELF.Diff_occupation_9 := le.occupation_9 <> ri.occupation_9;
    SELF.Diff_occupation_10 := le.occupation_10 <> ri.occupation_10;
    SELF.Diff_date_added_to_list := le.date_added_to_list <> ri.date_added_to_list;
    SELF.Diff_date_last_updated := le.date_last_updated <> ri.date_last_updated;
    SELF.Diff_effective_date := le.effective_date <> ri.effective_date;
    SELF.Diff_expiration_date := le.expiration_date <> ri.expiration_date;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_grounds := le.grounds <> ri.grounds;
    SELF.Diff_subj_to_common_pos_2001_931_cfsp_fl := le.subj_to_common_pos_2001_931_cfsp_fl <> ri.subj_to_common_pos_2001_931_cfsp_fl;
    SELF.Diff_federal_register_citation_1 := le.federal_register_citation_1 <> ri.federal_register_citation_1;
    SELF.Diff_federal_register_citation_2 := le.federal_register_citation_2 <> ri.federal_register_citation_2;
    SELF.Diff_federal_register_citation_3 := le.federal_register_citation_3 <> ri.federal_register_citation_3;
    SELF.Diff_federal_register_citation_4 := le.federal_register_citation_4 <> ri.federal_register_citation_4;
    SELF.Diff_federal_register_citation_5 := le.federal_register_citation_5 <> ri.federal_register_citation_5;
    SELF.Diff_federal_register_citation_6 := le.federal_register_citation_6 <> ri.federal_register_citation_6;
    SELF.Diff_federal_register_citation_7 := le.federal_register_citation_7 <> ri.federal_register_citation_7;
    SELF.Diff_federal_register_citation_8 := le.federal_register_citation_8 <> ri.federal_register_citation_8;
    SELF.Diff_federal_register_citation_9 := le.federal_register_citation_9 <> ri.federal_register_citation_9;
    SELF.Diff_federal_register_citation_10 := le.federal_register_citation_10 <> ri.federal_register_citation_10;
    SELF.Diff_federal_register_citation_date_1 := le.federal_register_citation_date_1 <> ri.federal_register_citation_date_1;
    SELF.Diff_federal_register_citation_date_2 := le.federal_register_citation_date_2 <> ri.federal_register_citation_date_2;
    SELF.Diff_federal_register_citation_date_3 := le.federal_register_citation_date_3 <> ri.federal_register_citation_date_3;
    SELF.Diff_federal_register_citation_date_4 := le.federal_register_citation_date_4 <> ri.federal_register_citation_date_4;
    SELF.Diff_federal_register_citation_date_5 := le.federal_register_citation_date_5 <> ri.federal_register_citation_date_5;
    SELF.Diff_federal_register_citation_date_6 := le.federal_register_citation_date_6 <> ri.federal_register_citation_date_6;
    SELF.Diff_federal_register_citation_date_7 := le.federal_register_citation_date_7 <> ri.federal_register_citation_date_7;
    SELF.Diff_federal_register_citation_date_8 := le.federal_register_citation_date_8 <> ri.federal_register_citation_date_8;
    SELF.Diff_federal_register_citation_date_9 := le.federal_register_citation_date_9 <> ri.federal_register_citation_date_9;
    SELF.Diff_federal_register_citation_date_10 := le.federal_register_citation_date_10 <> ri.federal_register_citation_date_10;
    SELF.Diff_license_requirement := le.license_requirement <> ri.license_requirement;
    SELF.Diff_license_review_policy := le.license_review_policy <> ri.license_review_policy;
    SELF.Diff_subordinate_status := le.subordinate_status <> ri.subordinate_status;
    SELF.Diff_height := le.height <> ri.height;
    SELF.Diff_weight := le.weight <> ri.weight;
    SELF.Diff_physique := le.physique <> ri.physique;
    SELF.Diff_hair_color := le.hair_color <> ri.hair_color;
    SELF.Diff_eyes := le.eyes <> ri.eyes;
    SELF.Diff_complexion := le.complexion <> ri.complexion;
    SELF.Diff_race := le.race <> ri.race;
    SELF.Diff_scars_marks := le.scars_marks <> ri.scars_marks;
    SELF.Diff_photo_file := le.photo_file <> ri.photo_file;
    SELF.Diff_offenses := le.offenses <> ri.offenses;
    SELF.Diff_ncic := le.ncic <> ri.ncic;
    SELF.Diff_warrant_by := le.warrant_by <> ri.warrant_by;
    SELF.Diff_caution := le.caution <> ri.caution;
    SELF.Diff_reward := le.reward <> ri.reward;
    SELF.Diff_type_of_denial := le.type_of_denial <> ri.type_of_denial;
    SELF.Diff_linked_with_1 := le.linked_with_1 <> ri.linked_with_1;
    SELF.Diff_linked_with_2 := le.linked_with_2 <> ri.linked_with_2;
    SELF.Diff_linked_with_3 := le.linked_with_3 <> ri.linked_with_3;
    SELF.Diff_linked_with_4 := le.linked_with_4 <> ri.linked_with_4;
    SELF.Diff_linked_with_5 := le.linked_with_5 <> ri.linked_with_5;
    SELF.Diff_linked_with_6 := le.linked_with_6 <> ri.linked_with_6;
    SELF.Diff_linked_with_7 := le.linked_with_7 <> ri.linked_with_7;
    SELF.Diff_linked_with_8 := le.linked_with_8 <> ri.linked_with_8;
    SELF.Diff_linked_with_9 := le.linked_with_9 <> ri.linked_with_9;
    SELF.Diff_linked_with_10 := le.linked_with_10 <> ri.linked_with_10;
    SELF.Diff_linked_with_id_1 := le.linked_with_id_1 <> ri.linked_with_id_1;
    SELF.Diff_linked_with_id_2 := le.linked_with_id_2 <> ri.linked_with_id_2;
    SELF.Diff_linked_with_id_3 := le.linked_with_id_3 <> ri.linked_with_id_3;
    SELF.Diff_linked_with_id_4 := le.linked_with_id_4 <> ri.linked_with_id_4;
    SELF.Diff_linked_with_id_5 := le.linked_with_id_5 <> ri.linked_with_id_5;
    SELF.Diff_linked_with_id_6 := le.linked_with_id_6 <> ri.linked_with_id_6;
    SELF.Diff_linked_with_id_7 := le.linked_with_id_7 <> ri.linked_with_id_7;
    SELF.Diff_linked_with_id_8 := le.linked_with_id_8 <> ri.linked_with_id_8;
    SELF.Diff_linked_with_id_9 := le.linked_with_id_9 <> ri.linked_with_id_9;
    SELF.Diff_linked_with_id_10 := le.linked_with_id_10 <> ri.linked_with_id_10;
    SELF.Diff_listing_information := le.listing_information <> ri.listing_information;
    SELF.Diff_foreign_principal := le.foreign_principal <> ri.foreign_principal;
    SELF.Diff_nature_of_service := le.nature_of_service <> ri.nature_of_service;
    SELF.Diff_activities := le.activities <> ri.activities;
    SELF.Diff_finances := le.finances <> ri.finances;
    SELF.Diff_registrant_terminated_flag := le.registrant_terminated_flag <> ri.registrant_terminated_flag;
    SELF.Diff_foreign_principal_terminated_flag := le.foreign_principal_terminated_flag <> ri.foreign_principal_terminated_flag;
    SELF.Diff_short_form_terminated_flag := le.short_form_terminated_flag <> ri.short_form_terminated_flag;
    SELF.Diff_src_key := le.src_key <> ri.src_key;
    SELF.Val := (SALT34.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.src_key;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_pty_key,1,0)+ IF( SELF.Diff_source,1,0)+ IF( SELF.Diff_orig_pty_name,1,0)+ IF( SELF.Diff_orig_vessel_name,1,0)+ IF( SELF.Diff_country,1,0)+ IF( SELF.Diff_name_type,1,0)+ IF( SELF.Diff_addr_1,1,0)+ IF( SELF.Diff_addr_2,1,0)+ IF( SELF.Diff_addr_3,1,0)+ IF( SELF.Diff_addr_4,1,0)+ IF( SELF.Diff_addr_5,1,0)+ IF( SELF.Diff_addr_6,1,0)+ IF( SELF.Diff_addr_7,1,0)+ IF( SELF.Diff_addr_8,1,0)+ IF( SELF.Diff_addr_9,1,0)+ IF( SELF.Diff_addr_10,1,0)+ IF( SELF.Diff_remarks_1,1,0)+ IF( SELF.Diff_remarks_2,1,0)+ IF( SELF.Diff_remarks_3,1,0)+ IF( SELF.Diff_remarks_4,1,0)+ IF( SELF.Diff_remarks_5,1,0)+ IF( SELF.Diff_remarks_6,1,0)+ IF( SELF.Diff_remarks_7,1,0)+ IF( SELF.Diff_remarks_8,1,0)+ IF( SELF.Diff_remarks_9,1,0)+ IF( SELF.Diff_remarks_10,1,0)+ IF( SELF.Diff_remarks_11,1,0)+ IF( SELF.Diff_remarks_12,1,0)+ IF( SELF.Diff_remarks_13,1,0)+ IF( SELF.Diff_remarks_14,1,0)+ IF( SELF.Diff_remarks_15,1,0)+ IF( SELF.Diff_remarks_16,1,0)+ IF( SELF.Diff_remarks_17,1,0)+ IF( SELF.Diff_remarks_18,1,0)+ IF( SELF.Diff_remarks_19,1,0)+ IF( SELF.Diff_remarks_20,1,0)+ IF( SELF.Diff_remarks_21,1,0)+ IF( SELF.Diff_remarks_22,1,0)+ IF( SELF.Diff_remarks_23,1,0)+ IF( SELF.Diff_remarks_24,1,0)+ IF( SELF.Diff_remarks_25,1,0)+ IF( SELF.Diff_remarks_26,1,0)+ IF( SELF.Diff_remarks_27,1,0)+ IF( SELF.Diff_remarks_28,1,0)+ IF( SELF.Diff_remarks_29,1,0)+ IF( SELF.Diff_remarks_30,1,0)+ IF( SELF.Diff_cname,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_a_score,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dpbc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_ace_fips_st,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_date_vendor_first_reported,1,0)+ IF( SELF.Diff_date_vendor_last_reported,1,0)+ IF( SELF.Diff_entity_id,1,0)+ IF( SELF.Diff_first_name,1,0)+ IF( SELF.Diff_last_name,1,0)+ IF( SELF.Diff_title_1,1,0)+ IF( SELF.Diff_title_2,1,0)+ IF( SELF.Diff_title_3,1,0)+ IF( SELF.Diff_title_4,1,0)+ IF( SELF.Diff_title_5,1,0)+ IF( SELF.Diff_title_6,1,0)+ IF( SELF.Diff_title_7,1,0)+ IF( SELF.Diff_title_8,1,0)+ IF( SELF.Diff_title_9,1,0)+ IF( SELF.Diff_title_10,1,0)+ IF( SELF.Diff_aka_id,1,0)+ IF( SELF.Diff_aka_type,1,0)+ IF( SELF.Diff_aka_category,1,0)+ IF( SELF.Diff_giv_designator,1,0)+ IF( SELF.Diff_entity_type,1,0)+ IF( SELF.Diff_address_id,1,0)+ IF( SELF.Diff_address_line_1,1,0)+ IF( SELF.Diff_address_line_2,1,0)+ IF( SELF.Diff_address_line_3,1,0)+ IF( SELF.Diff_address_city,1,0)+ IF( SELF.Diff_address_state_province,1,0)+ IF( SELF.Diff_address_postal_code,1,0)+ IF( SELF.Diff_address_country,1,0)+ IF( SELF.Diff_remarks,1,0)+ IF( SELF.Diff_call_sign,1,0)+ IF( SELF.Diff_vessel_type,1,0)+ IF( SELF.Diff_tonnage,1,0)+ IF( SELF.Diff_gross_registered_tonnage,1,0)+ IF( SELF.Diff_vessel_flag,1,0)+ IF( SELF.Diff_vessel_owner,1,0)+ IF( SELF.Diff_sanctions_program_1,1,0)+ IF( SELF.Diff_sanctions_program_2,1,0)+ IF( SELF.Diff_sanctions_program_3,1,0)+ IF( SELF.Diff_sanctions_program_4,1,0)+ IF( SELF.Diff_sanctions_program_5,1,0)+ IF( SELF.Diff_sanctions_program_6,1,0)+ IF( SELF.Diff_sanctions_program_7,1,0)+ IF( SELF.Diff_sanctions_program_8,1,0)+ IF( SELF.Diff_sanctions_program_9,1,0)+ IF( SELF.Diff_sanctions_program_10,1,0)+ IF( SELF.Diff_passport_details,1,0)+ IF( SELF.Diff_ni_number_details,1,0)+ IF( SELF.Diff_id_id_1,1,0)+ IF( SELF.Diff_id_id_2,1,0)+ IF( SELF.Diff_id_id_3,1,0)+ IF( SELF.Diff_id_id_4,1,0)+ IF( SELF.Diff_id_id_5,1,0)+ IF( SELF.Diff_id_id_6,1,0)+ IF( SELF.Diff_id_id_7,1,0)+ IF( SELF.Diff_id_id_8,1,0)+ IF( SELF.Diff_id_id_9,1,0)+ IF( SELF.Diff_id_id_10,1,0)+ IF( SELF.Diff_id_type_1,1,0)+ IF( SELF.Diff_id_type_2,1,0)+ IF( SELF.Diff_id_type_3,1,0)+ IF( SELF.Diff_id_type_4,1,0)+ IF( SELF.Diff_id_type_5,1,0)+ IF( SELF.Diff_id_type_6,1,0)+ IF( SELF.Diff_id_type_7,1,0)+ IF( SELF.Diff_id_type_8,1,0)+ IF( SELF.Diff_id_type_9,1,0)+ IF( SELF.Diff_id_type_10,1,0)+ IF( SELF.Diff_id_number_1,1,0)+ IF( SELF.Diff_id_number_2,1,0)+ IF( SELF.Diff_id_number_3,1,0)+ IF( SELF.Diff_id_number_4,1,0)+ IF( SELF.Diff_id_number_5,1,0)+ IF( SELF.Diff_id_number_6,1,0)+ IF( SELF.Diff_id_number_7,1,0)+ IF( SELF.Diff_id_number_8,1,0)+ IF( SELF.Diff_id_number_9,1,0)+ IF( SELF.Diff_id_number_10,1,0)+ IF( SELF.Diff_id_country_1,1,0)+ IF( SELF.Diff_id_country_2,1,0)+ IF( SELF.Diff_id_country_3,1,0)+ IF( SELF.Diff_id_country_4,1,0)+ IF( SELF.Diff_id_country_5,1,0)+ IF( SELF.Diff_id_country_6,1,0)+ IF( SELF.Diff_id_country_7,1,0)+ IF( SELF.Diff_id_country_8,1,0)+ IF( SELF.Diff_id_country_9,1,0)+ IF( SELF.Diff_id_country_10,1,0)+ IF( SELF.Diff_id_issue_date_1,1,0)+ IF( SELF.Diff_id_issue_date_2,1,0)+ IF( SELF.Diff_id_issue_date_3,1,0)+ IF( SELF.Diff_id_issue_date_4,1,0)+ IF( SELF.Diff_id_issue_date_5,1,0)+ IF( SELF.Diff_id_issue_date_6,1,0)+ IF( SELF.Diff_id_issue_date_7,1,0)+ IF( SELF.Diff_id_issue_date_8,1,0)+ IF( SELF.Diff_id_issue_date_9,1,0)+ IF( SELF.Diff_id_issue_date_10,1,0)+ IF( SELF.Diff_id_expiration_date_1,1,0)+ IF( SELF.Diff_id_expiration_date_2,1,0)+ IF( SELF.Diff_id_expiration_date_3,1,0)+ IF( SELF.Diff_id_expiration_date_4,1,0)+ IF( SELF.Diff_id_expiration_date_5,1,0)+ IF( SELF.Diff_id_expiration_date_6,1,0)+ IF( SELF.Diff_id_expiration_date_7,1,0)+ IF( SELF.Diff_id_expiration_date_8,1,0)+ IF( SELF.Diff_id_expiration_date_9,1,0)+ IF( SELF.Diff_id_expiration_date_10,1,0)+ IF( SELF.Diff_nationality_id_1,1,0)+ IF( SELF.Diff_nationality_id_2,1,0)+ IF( SELF.Diff_nationality_id_3,1,0)+ IF( SELF.Diff_nationality_id_4,1,0)+ IF( SELF.Diff_nationality_id_5,1,0)+ IF( SELF.Diff_nationality_id_6,1,0)+ IF( SELF.Diff_nationality_id_7,1,0)+ IF( SELF.Diff_nationality_id_8,1,0)+ IF( SELF.Diff_nationality_id_9,1,0)+ IF( SELF.Diff_nationality_id_10,1,0)+ IF( SELF.Diff_nationality_1,1,0)+ IF( SELF.Diff_nationality_2,1,0)+ IF( SELF.Diff_nationality_3,1,0)+ IF( SELF.Diff_nationality_4,1,0)+ IF( SELF.Diff_nationality_5,1,0)+ IF( SELF.Diff_nationality_6,1,0)+ IF( SELF.Diff_nationality_7,1,0)+ IF( SELF.Diff_nationality_8,1,0)+ IF( SELF.Diff_nationality_9,1,0)+ IF( SELF.Diff_nationality_10,1,0)+ IF( SELF.Diff_primary_nationality_flag_1,1,0)+ IF( SELF.Diff_primary_nationality_flag_2,1,0)+ IF( SELF.Diff_primary_nationality_flag_3,1,0)+ IF( SELF.Diff_primary_nationality_flag_4,1,0)+ IF( SELF.Diff_primary_nationality_flag_5,1,0)+ IF( SELF.Diff_primary_nationality_flag_6,1,0)+ IF( SELF.Diff_primary_nationality_flag_7,1,0)+ IF( SELF.Diff_primary_nationality_flag_8,1,0)+ IF( SELF.Diff_primary_nationality_flag_9,1,0)+ IF( SELF.Diff_primary_nationality_flag_10,1,0)+ IF( SELF.Diff_citizenship_id_1,1,0)+ IF( SELF.Diff_citizenship_id_2,1,0)+ IF( SELF.Diff_citizenship_id_3,1,0)+ IF( SELF.Diff_citizenship_id_4,1,0)+ IF( SELF.Diff_citizenship_id_5,1,0)+ IF( SELF.Diff_citizenship_id_6,1,0)+ IF( SELF.Diff_citizenship_id_7,1,0)+ IF( SELF.Diff_citizenship_id_8,1,0)+ IF( SELF.Diff_citizenship_id_9,1,0)+ IF( SELF.Diff_citizenship_id_10,1,0)+ IF( SELF.Diff_citizenship_1,1,0)+ IF( SELF.Diff_citizenship_2,1,0)+ IF( SELF.Diff_citizenship_3,1,0)+ IF( SELF.Diff_citizenship_4,1,0)+ IF( SELF.Diff_citizenship_5,1,0)+ IF( SELF.Diff_citizenship_6,1,0)+ IF( SELF.Diff_citizenship_7,1,0)+ IF( SELF.Diff_citizenship_8,1,0)+ IF( SELF.Diff_citizenship_9,1,0)+ IF( SELF.Diff_citizenship_10,1,0)+ IF( SELF.Diff_primary_citizenship_flag_1,1,0)+ IF( SELF.Diff_primary_citizenship_flag_2,1,0)+ IF( SELF.Diff_primary_citizenship_flag_3,1,0)+ IF( SELF.Diff_primary_citizenship_flag_4,1,0)+ IF( SELF.Diff_primary_citizenship_flag_5,1,0)+ IF( SELF.Diff_primary_citizenship_flag_6,1,0)+ IF( SELF.Diff_primary_citizenship_flag_7,1,0)+ IF( SELF.Diff_primary_citizenship_flag_8,1,0)+ IF( SELF.Diff_primary_citizenship_flag_9,1,0)+ IF( SELF.Diff_primary_citizenship_flag_10,1,0)+ IF( SELF.Diff_dob_id_1,1,0)+ IF( SELF.Diff_dob_id_2,1,0)+ IF( SELF.Diff_dob_id_3,1,0)+ IF( SELF.Diff_dob_id_4,1,0)+ IF( SELF.Diff_dob_id_5,1,0)+ IF( SELF.Diff_dob_id_6,1,0)+ IF( SELF.Diff_dob_id_7,1,0)+ IF( SELF.Diff_dob_id_8,1,0)+ IF( SELF.Diff_dob_id_9,1,0)+ IF( SELF.Diff_dob_id_10,1,0)+ IF( SELF.Diff_dob_1,1,0)+ IF( SELF.Diff_dob_2,1,0)+ IF( SELF.Diff_dob_3,1,0)+ IF( SELF.Diff_dob_4,1,0)+ IF( SELF.Diff_dob_5,1,0)+ IF( SELF.Diff_dob_6,1,0)+ IF( SELF.Diff_dob_7,1,0)+ IF( SELF.Diff_dob_8,1,0)+ IF( SELF.Diff_dob_9,1,0)+ IF( SELF.Diff_dob_10,1,0)+ IF( SELF.Diff_primary_dob_flag_1,1,0)+ IF( SELF.Diff_primary_dob_flag_2,1,0)+ IF( SELF.Diff_primary_dob_flag_3,1,0)+ IF( SELF.Diff_primary_dob_flag_4,1,0)+ IF( SELF.Diff_primary_dob_flag_5,1,0)+ IF( SELF.Diff_primary_dob_flag_6,1,0)+ IF( SELF.Diff_primary_dob_flag_7,1,0)+ IF( SELF.Diff_primary_dob_flag_8,1,0)+ IF( SELF.Diff_primary_dob_flag_9,1,0)+ IF( SELF.Diff_primary_dob_flag_10,1,0)+ IF( SELF.Diff_pob_id_1,1,0)+ IF( SELF.Diff_pob_id_2,1,0)+ IF( SELF.Diff_pob_id_3,1,0)+ IF( SELF.Diff_pob_id_4,1,0)+ IF( SELF.Diff_pob_id_5,1,0)+ IF( SELF.Diff_pob_id_6,1,0)+ IF( SELF.Diff_pob_id_7,1,0)+ IF( SELF.Diff_pob_id_8,1,0)+ IF( SELF.Diff_pob_id_9,1,0)+ IF( SELF.Diff_pob_id_10,1,0)+ IF( SELF.Diff_pob_1,1,0)+ IF( SELF.Diff_pob_2,1,0)+ IF( SELF.Diff_pob_3,1,0)+ IF( SELF.Diff_pob_4,1,0)+ IF( SELF.Diff_pob_5,1,0)+ IF( SELF.Diff_pob_6,1,0)+ IF( SELF.Diff_pob_7,1,0)+ IF( SELF.Diff_pob_8,1,0)+ IF( SELF.Diff_pob_9,1,0)+ IF( SELF.Diff_pob_10,1,0)+ IF( SELF.Diff_country_of_birth_1,1,0)+ IF( SELF.Diff_country_of_birth_2,1,0)+ IF( SELF.Diff_country_of_birth_3,1,0)+ IF( SELF.Diff_country_of_birth_4,1,0)+ IF( SELF.Diff_country_of_birth_5,1,0)+ IF( SELF.Diff_country_of_birth_6,1,0)+ IF( SELF.Diff_country_of_birth_7,1,0)+ IF( SELF.Diff_country_of_birth_8,1,0)+ IF( SELF.Diff_country_of_birth_9,1,0)+ IF( SELF.Diff_country_of_birth_10,1,0)+ IF( SELF.Diff_primary_pob_flag_1,1,0)+ IF( SELF.Diff_primary_pob_flag_2,1,0)+ IF( SELF.Diff_primary_pob_flag_3,1,0)+ IF( SELF.Diff_primary_pob_flag_4,1,0)+ IF( SELF.Diff_primary_pob_flag_5,1,0)+ IF( SELF.Diff_primary_pob_flag_6,1,0)+ IF( SELF.Diff_primary_pob_flag_7,1,0)+ IF( SELF.Diff_primary_pob_flag_8,1,0)+ IF( SELF.Diff_primary_pob_flag_9,1,0)+ IF( SELF.Diff_primary_pob_flag_10,1,0)+ IF( SELF.Diff_language_1,1,0)+ IF( SELF.Diff_language_2,1,0)+ IF( SELF.Diff_language_3,1,0)+ IF( SELF.Diff_language_4,1,0)+ IF( SELF.Diff_language_5,1,0)+ IF( SELF.Diff_language_6,1,0)+ IF( SELF.Diff_language_7,1,0)+ IF( SELF.Diff_language_8,1,0)+ IF( SELF.Diff_language_9,1,0)+ IF( SELF.Diff_language_10,1,0)+ IF( SELF.Diff_membership_1,1,0)+ IF( SELF.Diff_membership_2,1,0)+ IF( SELF.Diff_membership_3,1,0)+ IF( SELF.Diff_membership_4,1,0)+ IF( SELF.Diff_membership_5,1,0)+ IF( SELF.Diff_membership_6,1,0)+ IF( SELF.Diff_membership_7,1,0)+ IF( SELF.Diff_membership_8,1,0)+ IF( SELF.Diff_membership_9,1,0)+ IF( SELF.Diff_membership_10,1,0)+ IF( SELF.Diff_position_1,1,0)+ IF( SELF.Diff_position_2,1,0)+ IF( SELF.Diff_position_3,1,0)+ IF( SELF.Diff_position_4,1,0)+ IF( SELF.Diff_position_5,1,0)+ IF( SELF.Diff_position_6,1,0)+ IF( SELF.Diff_position_7,1,0)+ IF( SELF.Diff_position_8,1,0)+ IF( SELF.Diff_position_9,1,0)+ IF( SELF.Diff_position_10,1,0)+ IF( SELF.Diff_occupation_1,1,0)+ IF( SELF.Diff_occupation_2,1,0)+ IF( SELF.Diff_occupation_3,1,0)+ IF( SELF.Diff_occupation_4,1,0)+ IF( SELF.Diff_occupation_5,1,0)+ IF( SELF.Diff_occupation_6,1,0)+ IF( SELF.Diff_occupation_7,1,0)+ IF( SELF.Diff_occupation_8,1,0)+ IF( SELF.Diff_occupation_9,1,0)+ IF( SELF.Diff_occupation_10,1,0)+ IF( SELF.Diff_date_added_to_list,1,0)+ IF( SELF.Diff_date_last_updated,1,0)+ IF( SELF.Diff_effective_date,1,0)+ IF( SELF.Diff_expiration_date,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_grounds,1,0)+ IF( SELF.Diff_subj_to_common_pos_2001_931_cfsp_fl,1,0)+ IF( SELF.Diff_federal_register_citation_1,1,0)+ IF( SELF.Diff_federal_register_citation_2,1,0)+ IF( SELF.Diff_federal_register_citation_3,1,0)+ IF( SELF.Diff_federal_register_citation_4,1,0)+ IF( SELF.Diff_federal_register_citation_5,1,0)+ IF( SELF.Diff_federal_register_citation_6,1,0)+ IF( SELF.Diff_federal_register_citation_7,1,0)+ IF( SELF.Diff_federal_register_citation_8,1,0)+ IF( SELF.Diff_federal_register_citation_9,1,0)+ IF( SELF.Diff_federal_register_citation_10,1,0)+ IF( SELF.Diff_federal_register_citation_date_1,1,0)+ IF( SELF.Diff_federal_register_citation_date_2,1,0)+ IF( SELF.Diff_federal_register_citation_date_3,1,0)+ IF( SELF.Diff_federal_register_citation_date_4,1,0)+ IF( SELF.Diff_federal_register_citation_date_5,1,0)+ IF( SELF.Diff_federal_register_citation_date_6,1,0)+ IF( SELF.Diff_federal_register_citation_date_7,1,0)+ IF( SELF.Diff_federal_register_citation_date_8,1,0)+ IF( SELF.Diff_federal_register_citation_date_9,1,0)+ IF( SELF.Diff_federal_register_citation_date_10,1,0)+ IF( SELF.Diff_license_requirement,1,0)+ IF( SELF.Diff_license_review_policy,1,0)+ IF( SELF.Diff_subordinate_status,1,0)+ IF( SELF.Diff_height,1,0)+ IF( SELF.Diff_weight,1,0)+ IF( SELF.Diff_physique,1,0)+ IF( SELF.Diff_hair_color,1,0)+ IF( SELF.Diff_eyes,1,0)+ IF( SELF.Diff_complexion,1,0)+ IF( SELF.Diff_race,1,0)+ IF( SELF.Diff_scars_marks,1,0)+ IF( SELF.Diff_photo_file,1,0)+ IF( SELF.Diff_offenses,1,0)+ IF( SELF.Diff_ncic,1,0)+ IF( SELF.Diff_warrant_by,1,0)+ IF( SELF.Diff_caution,1,0)+ IF( SELF.Diff_reward,1,0)+ IF( SELF.Diff_type_of_denial,1,0)+ IF( SELF.Diff_linked_with_1,1,0)+ IF( SELF.Diff_linked_with_2,1,0)+ IF( SELF.Diff_linked_with_3,1,0)+ IF( SELF.Diff_linked_with_4,1,0)+ IF( SELF.Diff_linked_with_5,1,0)+ IF( SELF.Diff_linked_with_6,1,0)+ IF( SELF.Diff_linked_with_7,1,0)+ IF( SELF.Diff_linked_with_8,1,0)+ IF( SELF.Diff_linked_with_9,1,0)+ IF( SELF.Diff_linked_with_10,1,0)+ IF( SELF.Diff_linked_with_id_1,1,0)+ IF( SELF.Diff_linked_with_id_2,1,0)+ IF( SELF.Diff_linked_with_id_3,1,0)+ IF( SELF.Diff_linked_with_id_4,1,0)+ IF( SELF.Diff_linked_with_id_5,1,0)+ IF( SELF.Diff_linked_with_id_6,1,0)+ IF( SELF.Diff_linked_with_id_7,1,0)+ IF( SELF.Diff_linked_with_id_8,1,0)+ IF( SELF.Diff_linked_with_id_9,1,0)+ IF( SELF.Diff_linked_with_id_10,1,0)+ IF( SELF.Diff_listing_information,1,0)+ IF( SELF.Diff_foreign_principal,1,0)+ IF( SELF.Diff_nature_of_service,1,0)+ IF( SELF.Diff_activities,1,0)+ IF( SELF.Diff_finances,1,0)+ IF( SELF.Diff_registrant_terminated_flag,1,0)+ IF( SELF.Diff_foreign_principal_terminated_flag,1,0)+ IF( SELF.Diff_short_form_terminated_flag,1,0)+ IF( SELF.Diff_src_key,1,0);
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
    Count_Diff_pty_key := COUNT(GROUP,%Closest%.Diff_pty_key);
    Count_Diff_source := COUNT(GROUP,%Closest%.Diff_source);
    Count_Diff_orig_pty_name := COUNT(GROUP,%Closest%.Diff_orig_pty_name);
    Count_Diff_orig_vessel_name := COUNT(GROUP,%Closest%.Diff_orig_vessel_name);
    Count_Diff_country := COUNT(GROUP,%Closest%.Diff_country);
    Count_Diff_name_type := COUNT(GROUP,%Closest%.Diff_name_type);
    Count_Diff_addr_1 := COUNT(GROUP,%Closest%.Diff_addr_1);
    Count_Diff_addr_2 := COUNT(GROUP,%Closest%.Diff_addr_2);
    Count_Diff_addr_3 := COUNT(GROUP,%Closest%.Diff_addr_3);
    Count_Diff_addr_4 := COUNT(GROUP,%Closest%.Diff_addr_4);
    Count_Diff_addr_5 := COUNT(GROUP,%Closest%.Diff_addr_5);
    Count_Diff_addr_6 := COUNT(GROUP,%Closest%.Diff_addr_6);
    Count_Diff_addr_7 := COUNT(GROUP,%Closest%.Diff_addr_7);
    Count_Diff_addr_8 := COUNT(GROUP,%Closest%.Diff_addr_8);
    Count_Diff_addr_9 := COUNT(GROUP,%Closest%.Diff_addr_9);
    Count_Diff_addr_10 := COUNT(GROUP,%Closest%.Diff_addr_10);
    Count_Diff_remarks_1 := COUNT(GROUP,%Closest%.Diff_remarks_1);
    Count_Diff_remarks_2 := COUNT(GROUP,%Closest%.Diff_remarks_2);
    Count_Diff_remarks_3 := COUNT(GROUP,%Closest%.Diff_remarks_3);
    Count_Diff_remarks_4 := COUNT(GROUP,%Closest%.Diff_remarks_4);
    Count_Diff_remarks_5 := COUNT(GROUP,%Closest%.Diff_remarks_5);
    Count_Diff_remarks_6 := COUNT(GROUP,%Closest%.Diff_remarks_6);
    Count_Diff_remarks_7 := COUNT(GROUP,%Closest%.Diff_remarks_7);
    Count_Diff_remarks_8 := COUNT(GROUP,%Closest%.Diff_remarks_8);
    Count_Diff_remarks_9 := COUNT(GROUP,%Closest%.Diff_remarks_9);
    Count_Diff_remarks_10 := COUNT(GROUP,%Closest%.Diff_remarks_10);
    Count_Diff_remarks_11 := COUNT(GROUP,%Closest%.Diff_remarks_11);
    Count_Diff_remarks_12 := COUNT(GROUP,%Closest%.Diff_remarks_12);
    Count_Diff_remarks_13 := COUNT(GROUP,%Closest%.Diff_remarks_13);
    Count_Diff_remarks_14 := COUNT(GROUP,%Closest%.Diff_remarks_14);
    Count_Diff_remarks_15 := COUNT(GROUP,%Closest%.Diff_remarks_15);
    Count_Diff_remarks_16 := COUNT(GROUP,%Closest%.Diff_remarks_16);
    Count_Diff_remarks_17 := COUNT(GROUP,%Closest%.Diff_remarks_17);
    Count_Diff_remarks_18 := COUNT(GROUP,%Closest%.Diff_remarks_18);
    Count_Diff_remarks_19 := COUNT(GROUP,%Closest%.Diff_remarks_19);
    Count_Diff_remarks_20 := COUNT(GROUP,%Closest%.Diff_remarks_20);
    Count_Diff_remarks_21 := COUNT(GROUP,%Closest%.Diff_remarks_21);
    Count_Diff_remarks_22 := COUNT(GROUP,%Closest%.Diff_remarks_22);
    Count_Diff_remarks_23 := COUNT(GROUP,%Closest%.Diff_remarks_23);
    Count_Diff_remarks_24 := COUNT(GROUP,%Closest%.Diff_remarks_24);
    Count_Diff_remarks_25 := COUNT(GROUP,%Closest%.Diff_remarks_25);
    Count_Diff_remarks_26 := COUNT(GROUP,%Closest%.Diff_remarks_26);
    Count_Diff_remarks_27 := COUNT(GROUP,%Closest%.Diff_remarks_27);
    Count_Diff_remarks_28 := COUNT(GROUP,%Closest%.Diff_remarks_28);
    Count_Diff_remarks_29 := COUNT(GROUP,%Closest%.Diff_remarks_29);
    Count_Diff_remarks_30 := COUNT(GROUP,%Closest%.Diff_remarks_30);
    Count_Diff_cname := COUNT(GROUP,%Closest%.Diff_cname);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_a_score := COUNT(GROUP,%Closest%.Diff_a_score);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_addr_suffix := COUNT(GROUP,%Closest%.Diff_addr_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_p_city_name := COUNT(GROUP,%Closest%.Diff_p_city_name);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_cart := COUNT(GROUP,%Closest%.Diff_cart);
    Count_Diff_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_cr_sort_sz);
    Count_Diff_lot := COUNT(GROUP,%Closest%.Diff_lot);
    Count_Diff_lot_order := COUNT(GROUP,%Closest%.Diff_lot_order);
    Count_Diff_dpbc := COUNT(GROUP,%Closest%.Diff_dpbc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_ace_fips_st := COUNT(GROUP,%Closest%.Diff_ace_fips_st);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_date_first_seen := COUNT(GROUP,%Closest%.Diff_date_first_seen);
    Count_Diff_date_last_seen := COUNT(GROUP,%Closest%.Diff_date_last_seen);
    Count_Diff_date_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_first_reported);
    Count_Diff_date_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_last_reported);
    Count_Diff_entity_id := COUNT(GROUP,%Closest%.Diff_entity_id);
    Count_Diff_first_name := COUNT(GROUP,%Closest%.Diff_first_name);
    Count_Diff_last_name := COUNT(GROUP,%Closest%.Diff_last_name);
    Count_Diff_title_1 := COUNT(GROUP,%Closest%.Diff_title_1);
    Count_Diff_title_2 := COUNT(GROUP,%Closest%.Diff_title_2);
    Count_Diff_title_3 := COUNT(GROUP,%Closest%.Diff_title_3);
    Count_Diff_title_4 := COUNT(GROUP,%Closest%.Diff_title_4);
    Count_Diff_title_5 := COUNT(GROUP,%Closest%.Diff_title_5);
    Count_Diff_title_6 := COUNT(GROUP,%Closest%.Diff_title_6);
    Count_Diff_title_7 := COUNT(GROUP,%Closest%.Diff_title_7);
    Count_Diff_title_8 := COUNT(GROUP,%Closest%.Diff_title_8);
    Count_Diff_title_9 := COUNT(GROUP,%Closest%.Diff_title_9);
    Count_Diff_title_10 := COUNT(GROUP,%Closest%.Diff_title_10);
    Count_Diff_aka_id := COUNT(GROUP,%Closest%.Diff_aka_id);
    Count_Diff_aka_type := COUNT(GROUP,%Closest%.Diff_aka_type);
    Count_Diff_aka_category := COUNT(GROUP,%Closest%.Diff_aka_category);
    Count_Diff_giv_designator := COUNT(GROUP,%Closest%.Diff_giv_designator);
    Count_Diff_entity_type := COUNT(GROUP,%Closest%.Diff_entity_type);
    Count_Diff_address_id := COUNT(GROUP,%Closest%.Diff_address_id);
    Count_Diff_address_line_1 := COUNT(GROUP,%Closest%.Diff_address_line_1);
    Count_Diff_address_line_2 := COUNT(GROUP,%Closest%.Diff_address_line_2);
    Count_Diff_address_line_3 := COUNT(GROUP,%Closest%.Diff_address_line_3);
    Count_Diff_address_city := COUNT(GROUP,%Closest%.Diff_address_city);
    Count_Diff_address_state_province := COUNT(GROUP,%Closest%.Diff_address_state_province);
    Count_Diff_address_postal_code := COUNT(GROUP,%Closest%.Diff_address_postal_code);
    Count_Diff_address_country := COUNT(GROUP,%Closest%.Diff_address_country);
    Count_Diff_remarks := COUNT(GROUP,%Closest%.Diff_remarks);
    Count_Diff_call_sign := COUNT(GROUP,%Closest%.Diff_call_sign);
    Count_Diff_vessel_type := COUNT(GROUP,%Closest%.Diff_vessel_type);
    Count_Diff_tonnage := COUNT(GROUP,%Closest%.Diff_tonnage);
    Count_Diff_gross_registered_tonnage := COUNT(GROUP,%Closest%.Diff_gross_registered_tonnage);
    Count_Diff_vessel_flag := COUNT(GROUP,%Closest%.Diff_vessel_flag);
    Count_Diff_vessel_owner := COUNT(GROUP,%Closest%.Diff_vessel_owner);
    Count_Diff_sanctions_program_1 := COUNT(GROUP,%Closest%.Diff_sanctions_program_1);
    Count_Diff_sanctions_program_2 := COUNT(GROUP,%Closest%.Diff_sanctions_program_2);
    Count_Diff_sanctions_program_3 := COUNT(GROUP,%Closest%.Diff_sanctions_program_3);
    Count_Diff_sanctions_program_4 := COUNT(GROUP,%Closest%.Diff_sanctions_program_4);
    Count_Diff_sanctions_program_5 := COUNT(GROUP,%Closest%.Diff_sanctions_program_5);
    Count_Diff_sanctions_program_6 := COUNT(GROUP,%Closest%.Diff_sanctions_program_6);
    Count_Diff_sanctions_program_7 := COUNT(GROUP,%Closest%.Diff_sanctions_program_7);
    Count_Diff_sanctions_program_8 := COUNT(GROUP,%Closest%.Diff_sanctions_program_8);
    Count_Diff_sanctions_program_9 := COUNT(GROUP,%Closest%.Diff_sanctions_program_9);
    Count_Diff_sanctions_program_10 := COUNT(GROUP,%Closest%.Diff_sanctions_program_10);
    Count_Diff_passport_details := COUNT(GROUP,%Closest%.Diff_passport_details);
    Count_Diff_ni_number_details := COUNT(GROUP,%Closest%.Diff_ni_number_details);
    Count_Diff_id_id_1 := COUNT(GROUP,%Closest%.Diff_id_id_1);
    Count_Diff_id_id_2 := COUNT(GROUP,%Closest%.Diff_id_id_2);
    Count_Diff_id_id_3 := COUNT(GROUP,%Closest%.Diff_id_id_3);
    Count_Diff_id_id_4 := COUNT(GROUP,%Closest%.Diff_id_id_4);
    Count_Diff_id_id_5 := COUNT(GROUP,%Closest%.Diff_id_id_5);
    Count_Diff_id_id_6 := COUNT(GROUP,%Closest%.Diff_id_id_6);
    Count_Diff_id_id_7 := COUNT(GROUP,%Closest%.Diff_id_id_7);
    Count_Diff_id_id_8 := COUNT(GROUP,%Closest%.Diff_id_id_8);
    Count_Diff_id_id_9 := COUNT(GROUP,%Closest%.Diff_id_id_9);
    Count_Diff_id_id_10 := COUNT(GROUP,%Closest%.Diff_id_id_10);
    Count_Diff_id_type_1 := COUNT(GROUP,%Closest%.Diff_id_type_1);
    Count_Diff_id_type_2 := COUNT(GROUP,%Closest%.Diff_id_type_2);
    Count_Diff_id_type_3 := COUNT(GROUP,%Closest%.Diff_id_type_3);
    Count_Diff_id_type_4 := COUNT(GROUP,%Closest%.Diff_id_type_4);
    Count_Diff_id_type_5 := COUNT(GROUP,%Closest%.Diff_id_type_5);
    Count_Diff_id_type_6 := COUNT(GROUP,%Closest%.Diff_id_type_6);
    Count_Diff_id_type_7 := COUNT(GROUP,%Closest%.Diff_id_type_7);
    Count_Diff_id_type_8 := COUNT(GROUP,%Closest%.Diff_id_type_8);
    Count_Diff_id_type_9 := COUNT(GROUP,%Closest%.Diff_id_type_9);
    Count_Diff_id_type_10 := COUNT(GROUP,%Closest%.Diff_id_type_10);
    Count_Diff_id_number_1 := COUNT(GROUP,%Closest%.Diff_id_number_1);
    Count_Diff_id_number_2 := COUNT(GROUP,%Closest%.Diff_id_number_2);
    Count_Diff_id_number_3 := COUNT(GROUP,%Closest%.Diff_id_number_3);
    Count_Diff_id_number_4 := COUNT(GROUP,%Closest%.Diff_id_number_4);
    Count_Diff_id_number_5 := COUNT(GROUP,%Closest%.Diff_id_number_5);
    Count_Diff_id_number_6 := COUNT(GROUP,%Closest%.Diff_id_number_6);
    Count_Diff_id_number_7 := COUNT(GROUP,%Closest%.Diff_id_number_7);
    Count_Diff_id_number_8 := COUNT(GROUP,%Closest%.Diff_id_number_8);
    Count_Diff_id_number_9 := COUNT(GROUP,%Closest%.Diff_id_number_9);
    Count_Diff_id_number_10 := COUNT(GROUP,%Closest%.Diff_id_number_10);
    Count_Diff_id_country_1 := COUNT(GROUP,%Closest%.Diff_id_country_1);
    Count_Diff_id_country_2 := COUNT(GROUP,%Closest%.Diff_id_country_2);
    Count_Diff_id_country_3 := COUNT(GROUP,%Closest%.Diff_id_country_3);
    Count_Diff_id_country_4 := COUNT(GROUP,%Closest%.Diff_id_country_4);
    Count_Diff_id_country_5 := COUNT(GROUP,%Closest%.Diff_id_country_5);
    Count_Diff_id_country_6 := COUNT(GROUP,%Closest%.Diff_id_country_6);
    Count_Diff_id_country_7 := COUNT(GROUP,%Closest%.Diff_id_country_7);
    Count_Diff_id_country_8 := COUNT(GROUP,%Closest%.Diff_id_country_8);
    Count_Diff_id_country_9 := COUNT(GROUP,%Closest%.Diff_id_country_9);
    Count_Diff_id_country_10 := COUNT(GROUP,%Closest%.Diff_id_country_10);
    Count_Diff_id_issue_date_1 := COUNT(GROUP,%Closest%.Diff_id_issue_date_1);
    Count_Diff_id_issue_date_2 := COUNT(GROUP,%Closest%.Diff_id_issue_date_2);
    Count_Diff_id_issue_date_3 := COUNT(GROUP,%Closest%.Diff_id_issue_date_3);
    Count_Diff_id_issue_date_4 := COUNT(GROUP,%Closest%.Diff_id_issue_date_4);
    Count_Diff_id_issue_date_5 := COUNT(GROUP,%Closest%.Diff_id_issue_date_5);
    Count_Diff_id_issue_date_6 := COUNT(GROUP,%Closest%.Diff_id_issue_date_6);
    Count_Diff_id_issue_date_7 := COUNT(GROUP,%Closest%.Diff_id_issue_date_7);
    Count_Diff_id_issue_date_8 := COUNT(GROUP,%Closest%.Diff_id_issue_date_8);
    Count_Diff_id_issue_date_9 := COUNT(GROUP,%Closest%.Diff_id_issue_date_9);
    Count_Diff_id_issue_date_10 := COUNT(GROUP,%Closest%.Diff_id_issue_date_10);
    Count_Diff_id_expiration_date_1 := COUNT(GROUP,%Closest%.Diff_id_expiration_date_1);
    Count_Diff_id_expiration_date_2 := COUNT(GROUP,%Closest%.Diff_id_expiration_date_2);
    Count_Diff_id_expiration_date_3 := COUNT(GROUP,%Closest%.Diff_id_expiration_date_3);
    Count_Diff_id_expiration_date_4 := COUNT(GROUP,%Closest%.Diff_id_expiration_date_4);
    Count_Diff_id_expiration_date_5 := COUNT(GROUP,%Closest%.Diff_id_expiration_date_5);
    Count_Diff_id_expiration_date_6 := COUNT(GROUP,%Closest%.Diff_id_expiration_date_6);
    Count_Diff_id_expiration_date_7 := COUNT(GROUP,%Closest%.Diff_id_expiration_date_7);
    Count_Diff_id_expiration_date_8 := COUNT(GROUP,%Closest%.Diff_id_expiration_date_8);
    Count_Diff_id_expiration_date_9 := COUNT(GROUP,%Closest%.Diff_id_expiration_date_9);
    Count_Diff_id_expiration_date_10 := COUNT(GROUP,%Closest%.Diff_id_expiration_date_10);
    Count_Diff_nationality_id_1 := COUNT(GROUP,%Closest%.Diff_nationality_id_1);
    Count_Diff_nationality_id_2 := COUNT(GROUP,%Closest%.Diff_nationality_id_2);
    Count_Diff_nationality_id_3 := COUNT(GROUP,%Closest%.Diff_nationality_id_3);
    Count_Diff_nationality_id_4 := COUNT(GROUP,%Closest%.Diff_nationality_id_4);
    Count_Diff_nationality_id_5 := COUNT(GROUP,%Closest%.Diff_nationality_id_5);
    Count_Diff_nationality_id_6 := COUNT(GROUP,%Closest%.Diff_nationality_id_6);
    Count_Diff_nationality_id_7 := COUNT(GROUP,%Closest%.Diff_nationality_id_7);
    Count_Diff_nationality_id_8 := COUNT(GROUP,%Closest%.Diff_nationality_id_8);
    Count_Diff_nationality_id_9 := COUNT(GROUP,%Closest%.Diff_nationality_id_9);
    Count_Diff_nationality_id_10 := COUNT(GROUP,%Closest%.Diff_nationality_id_10);
    Count_Diff_nationality_1 := COUNT(GROUP,%Closest%.Diff_nationality_1);
    Count_Diff_nationality_2 := COUNT(GROUP,%Closest%.Diff_nationality_2);
    Count_Diff_nationality_3 := COUNT(GROUP,%Closest%.Diff_nationality_3);
    Count_Diff_nationality_4 := COUNT(GROUP,%Closest%.Diff_nationality_4);
    Count_Diff_nationality_5 := COUNT(GROUP,%Closest%.Diff_nationality_5);
    Count_Diff_nationality_6 := COUNT(GROUP,%Closest%.Diff_nationality_6);
    Count_Diff_nationality_7 := COUNT(GROUP,%Closest%.Diff_nationality_7);
    Count_Diff_nationality_8 := COUNT(GROUP,%Closest%.Diff_nationality_8);
    Count_Diff_nationality_9 := COUNT(GROUP,%Closest%.Diff_nationality_9);
    Count_Diff_nationality_10 := COUNT(GROUP,%Closest%.Diff_nationality_10);
    Count_Diff_primary_nationality_flag_1 := COUNT(GROUP,%Closest%.Diff_primary_nationality_flag_1);
    Count_Diff_primary_nationality_flag_2 := COUNT(GROUP,%Closest%.Diff_primary_nationality_flag_2);
    Count_Diff_primary_nationality_flag_3 := COUNT(GROUP,%Closest%.Diff_primary_nationality_flag_3);
    Count_Diff_primary_nationality_flag_4 := COUNT(GROUP,%Closest%.Diff_primary_nationality_flag_4);
    Count_Diff_primary_nationality_flag_5 := COUNT(GROUP,%Closest%.Diff_primary_nationality_flag_5);
    Count_Diff_primary_nationality_flag_6 := COUNT(GROUP,%Closest%.Diff_primary_nationality_flag_6);
    Count_Diff_primary_nationality_flag_7 := COUNT(GROUP,%Closest%.Diff_primary_nationality_flag_7);
    Count_Diff_primary_nationality_flag_8 := COUNT(GROUP,%Closest%.Diff_primary_nationality_flag_8);
    Count_Diff_primary_nationality_flag_9 := COUNT(GROUP,%Closest%.Diff_primary_nationality_flag_9);
    Count_Diff_primary_nationality_flag_10 := COUNT(GROUP,%Closest%.Diff_primary_nationality_flag_10);
    Count_Diff_citizenship_id_1 := COUNT(GROUP,%Closest%.Diff_citizenship_id_1);
    Count_Diff_citizenship_id_2 := COUNT(GROUP,%Closest%.Diff_citizenship_id_2);
    Count_Diff_citizenship_id_3 := COUNT(GROUP,%Closest%.Diff_citizenship_id_3);
    Count_Diff_citizenship_id_4 := COUNT(GROUP,%Closest%.Diff_citizenship_id_4);
    Count_Diff_citizenship_id_5 := COUNT(GROUP,%Closest%.Diff_citizenship_id_5);
    Count_Diff_citizenship_id_6 := COUNT(GROUP,%Closest%.Diff_citizenship_id_6);
    Count_Diff_citizenship_id_7 := COUNT(GROUP,%Closest%.Diff_citizenship_id_7);
    Count_Diff_citizenship_id_8 := COUNT(GROUP,%Closest%.Diff_citizenship_id_8);
    Count_Diff_citizenship_id_9 := COUNT(GROUP,%Closest%.Diff_citizenship_id_9);
    Count_Diff_citizenship_id_10 := COUNT(GROUP,%Closest%.Diff_citizenship_id_10);
    Count_Diff_citizenship_1 := COUNT(GROUP,%Closest%.Diff_citizenship_1);
    Count_Diff_citizenship_2 := COUNT(GROUP,%Closest%.Diff_citizenship_2);
    Count_Diff_citizenship_3 := COUNT(GROUP,%Closest%.Diff_citizenship_3);
    Count_Diff_citizenship_4 := COUNT(GROUP,%Closest%.Diff_citizenship_4);
    Count_Diff_citizenship_5 := COUNT(GROUP,%Closest%.Diff_citizenship_5);
    Count_Diff_citizenship_6 := COUNT(GROUP,%Closest%.Diff_citizenship_6);
    Count_Diff_citizenship_7 := COUNT(GROUP,%Closest%.Diff_citizenship_7);
    Count_Diff_citizenship_8 := COUNT(GROUP,%Closest%.Diff_citizenship_8);
    Count_Diff_citizenship_9 := COUNT(GROUP,%Closest%.Diff_citizenship_9);
    Count_Diff_citizenship_10 := COUNT(GROUP,%Closest%.Diff_citizenship_10);
    Count_Diff_primary_citizenship_flag_1 := COUNT(GROUP,%Closest%.Diff_primary_citizenship_flag_1);
    Count_Diff_primary_citizenship_flag_2 := COUNT(GROUP,%Closest%.Diff_primary_citizenship_flag_2);
    Count_Diff_primary_citizenship_flag_3 := COUNT(GROUP,%Closest%.Diff_primary_citizenship_flag_3);
    Count_Diff_primary_citizenship_flag_4 := COUNT(GROUP,%Closest%.Diff_primary_citizenship_flag_4);
    Count_Diff_primary_citizenship_flag_5 := COUNT(GROUP,%Closest%.Diff_primary_citizenship_flag_5);
    Count_Diff_primary_citizenship_flag_6 := COUNT(GROUP,%Closest%.Diff_primary_citizenship_flag_6);
    Count_Diff_primary_citizenship_flag_7 := COUNT(GROUP,%Closest%.Diff_primary_citizenship_flag_7);
    Count_Diff_primary_citizenship_flag_8 := COUNT(GROUP,%Closest%.Diff_primary_citizenship_flag_8);
    Count_Diff_primary_citizenship_flag_9 := COUNT(GROUP,%Closest%.Diff_primary_citizenship_flag_9);
    Count_Diff_primary_citizenship_flag_10 := COUNT(GROUP,%Closest%.Diff_primary_citizenship_flag_10);
    Count_Diff_dob_id_1 := COUNT(GROUP,%Closest%.Diff_dob_id_1);
    Count_Diff_dob_id_2 := COUNT(GROUP,%Closest%.Diff_dob_id_2);
    Count_Diff_dob_id_3 := COUNT(GROUP,%Closest%.Diff_dob_id_3);
    Count_Diff_dob_id_4 := COUNT(GROUP,%Closest%.Diff_dob_id_4);
    Count_Diff_dob_id_5 := COUNT(GROUP,%Closest%.Diff_dob_id_5);
    Count_Diff_dob_id_6 := COUNT(GROUP,%Closest%.Diff_dob_id_6);
    Count_Diff_dob_id_7 := COUNT(GROUP,%Closest%.Diff_dob_id_7);
    Count_Diff_dob_id_8 := COUNT(GROUP,%Closest%.Diff_dob_id_8);
    Count_Diff_dob_id_9 := COUNT(GROUP,%Closest%.Diff_dob_id_9);
    Count_Diff_dob_id_10 := COUNT(GROUP,%Closest%.Diff_dob_id_10);
    Count_Diff_dob_1 := COUNT(GROUP,%Closest%.Diff_dob_1);
    Count_Diff_dob_2 := COUNT(GROUP,%Closest%.Diff_dob_2);
    Count_Diff_dob_3 := COUNT(GROUP,%Closest%.Diff_dob_3);
    Count_Diff_dob_4 := COUNT(GROUP,%Closest%.Diff_dob_4);
    Count_Diff_dob_5 := COUNT(GROUP,%Closest%.Diff_dob_5);
    Count_Diff_dob_6 := COUNT(GROUP,%Closest%.Diff_dob_6);
    Count_Diff_dob_7 := COUNT(GROUP,%Closest%.Diff_dob_7);
    Count_Diff_dob_8 := COUNT(GROUP,%Closest%.Diff_dob_8);
    Count_Diff_dob_9 := COUNT(GROUP,%Closest%.Diff_dob_9);
    Count_Diff_dob_10 := COUNT(GROUP,%Closest%.Diff_dob_10);
    Count_Diff_primary_dob_flag_1 := COUNT(GROUP,%Closest%.Diff_primary_dob_flag_1);
    Count_Diff_primary_dob_flag_2 := COUNT(GROUP,%Closest%.Diff_primary_dob_flag_2);
    Count_Diff_primary_dob_flag_3 := COUNT(GROUP,%Closest%.Diff_primary_dob_flag_3);
    Count_Diff_primary_dob_flag_4 := COUNT(GROUP,%Closest%.Diff_primary_dob_flag_4);
    Count_Diff_primary_dob_flag_5 := COUNT(GROUP,%Closest%.Diff_primary_dob_flag_5);
    Count_Diff_primary_dob_flag_6 := COUNT(GROUP,%Closest%.Diff_primary_dob_flag_6);
    Count_Diff_primary_dob_flag_7 := COUNT(GROUP,%Closest%.Diff_primary_dob_flag_7);
    Count_Diff_primary_dob_flag_8 := COUNT(GROUP,%Closest%.Diff_primary_dob_flag_8);
    Count_Diff_primary_dob_flag_9 := COUNT(GROUP,%Closest%.Diff_primary_dob_flag_9);
    Count_Diff_primary_dob_flag_10 := COUNT(GROUP,%Closest%.Diff_primary_dob_flag_10);
    Count_Diff_pob_id_1 := COUNT(GROUP,%Closest%.Diff_pob_id_1);
    Count_Diff_pob_id_2 := COUNT(GROUP,%Closest%.Diff_pob_id_2);
    Count_Diff_pob_id_3 := COUNT(GROUP,%Closest%.Diff_pob_id_3);
    Count_Diff_pob_id_4 := COUNT(GROUP,%Closest%.Diff_pob_id_4);
    Count_Diff_pob_id_5 := COUNT(GROUP,%Closest%.Diff_pob_id_5);
    Count_Diff_pob_id_6 := COUNT(GROUP,%Closest%.Diff_pob_id_6);
    Count_Diff_pob_id_7 := COUNT(GROUP,%Closest%.Diff_pob_id_7);
    Count_Diff_pob_id_8 := COUNT(GROUP,%Closest%.Diff_pob_id_8);
    Count_Diff_pob_id_9 := COUNT(GROUP,%Closest%.Diff_pob_id_9);
    Count_Diff_pob_id_10 := COUNT(GROUP,%Closest%.Diff_pob_id_10);
    Count_Diff_pob_1 := COUNT(GROUP,%Closest%.Diff_pob_1);
    Count_Diff_pob_2 := COUNT(GROUP,%Closest%.Diff_pob_2);
    Count_Diff_pob_3 := COUNT(GROUP,%Closest%.Diff_pob_3);
    Count_Diff_pob_4 := COUNT(GROUP,%Closest%.Diff_pob_4);
    Count_Diff_pob_5 := COUNT(GROUP,%Closest%.Diff_pob_5);
    Count_Diff_pob_6 := COUNT(GROUP,%Closest%.Diff_pob_6);
    Count_Diff_pob_7 := COUNT(GROUP,%Closest%.Diff_pob_7);
    Count_Diff_pob_8 := COUNT(GROUP,%Closest%.Diff_pob_8);
    Count_Diff_pob_9 := COUNT(GROUP,%Closest%.Diff_pob_9);
    Count_Diff_pob_10 := COUNT(GROUP,%Closest%.Diff_pob_10);
    Count_Diff_country_of_birth_1 := COUNT(GROUP,%Closest%.Diff_country_of_birth_1);
    Count_Diff_country_of_birth_2 := COUNT(GROUP,%Closest%.Diff_country_of_birth_2);
    Count_Diff_country_of_birth_3 := COUNT(GROUP,%Closest%.Diff_country_of_birth_3);
    Count_Diff_country_of_birth_4 := COUNT(GROUP,%Closest%.Diff_country_of_birth_4);
    Count_Diff_country_of_birth_5 := COUNT(GROUP,%Closest%.Diff_country_of_birth_5);
    Count_Diff_country_of_birth_6 := COUNT(GROUP,%Closest%.Diff_country_of_birth_6);
    Count_Diff_country_of_birth_7 := COUNT(GROUP,%Closest%.Diff_country_of_birth_7);
    Count_Diff_country_of_birth_8 := COUNT(GROUP,%Closest%.Diff_country_of_birth_8);
    Count_Diff_country_of_birth_9 := COUNT(GROUP,%Closest%.Diff_country_of_birth_9);
    Count_Diff_country_of_birth_10 := COUNT(GROUP,%Closest%.Diff_country_of_birth_10);
    Count_Diff_primary_pob_flag_1 := COUNT(GROUP,%Closest%.Diff_primary_pob_flag_1);
    Count_Diff_primary_pob_flag_2 := COUNT(GROUP,%Closest%.Diff_primary_pob_flag_2);
    Count_Diff_primary_pob_flag_3 := COUNT(GROUP,%Closest%.Diff_primary_pob_flag_3);
    Count_Diff_primary_pob_flag_4 := COUNT(GROUP,%Closest%.Diff_primary_pob_flag_4);
    Count_Diff_primary_pob_flag_5 := COUNT(GROUP,%Closest%.Diff_primary_pob_flag_5);
    Count_Diff_primary_pob_flag_6 := COUNT(GROUP,%Closest%.Diff_primary_pob_flag_6);
    Count_Diff_primary_pob_flag_7 := COUNT(GROUP,%Closest%.Diff_primary_pob_flag_7);
    Count_Diff_primary_pob_flag_8 := COUNT(GROUP,%Closest%.Diff_primary_pob_flag_8);
    Count_Diff_primary_pob_flag_9 := COUNT(GROUP,%Closest%.Diff_primary_pob_flag_9);
    Count_Diff_primary_pob_flag_10 := COUNT(GROUP,%Closest%.Diff_primary_pob_flag_10);
    Count_Diff_language_1 := COUNT(GROUP,%Closest%.Diff_language_1);
    Count_Diff_language_2 := COUNT(GROUP,%Closest%.Diff_language_2);
    Count_Diff_language_3 := COUNT(GROUP,%Closest%.Diff_language_3);
    Count_Diff_language_4 := COUNT(GROUP,%Closest%.Diff_language_4);
    Count_Diff_language_5 := COUNT(GROUP,%Closest%.Diff_language_5);
    Count_Diff_language_6 := COUNT(GROUP,%Closest%.Diff_language_6);
    Count_Diff_language_7 := COUNT(GROUP,%Closest%.Diff_language_7);
    Count_Diff_language_8 := COUNT(GROUP,%Closest%.Diff_language_8);
    Count_Diff_language_9 := COUNT(GROUP,%Closest%.Diff_language_9);
    Count_Diff_language_10 := COUNT(GROUP,%Closest%.Diff_language_10);
    Count_Diff_membership_1 := COUNT(GROUP,%Closest%.Diff_membership_1);
    Count_Diff_membership_2 := COUNT(GROUP,%Closest%.Diff_membership_2);
    Count_Diff_membership_3 := COUNT(GROUP,%Closest%.Diff_membership_3);
    Count_Diff_membership_4 := COUNT(GROUP,%Closest%.Diff_membership_4);
    Count_Diff_membership_5 := COUNT(GROUP,%Closest%.Diff_membership_5);
    Count_Diff_membership_6 := COUNT(GROUP,%Closest%.Diff_membership_6);
    Count_Diff_membership_7 := COUNT(GROUP,%Closest%.Diff_membership_7);
    Count_Diff_membership_8 := COUNT(GROUP,%Closest%.Diff_membership_8);
    Count_Diff_membership_9 := COUNT(GROUP,%Closest%.Diff_membership_9);
    Count_Diff_membership_10 := COUNT(GROUP,%Closest%.Diff_membership_10);
    Count_Diff_position_1 := COUNT(GROUP,%Closest%.Diff_position_1);
    Count_Diff_position_2 := COUNT(GROUP,%Closest%.Diff_position_2);
    Count_Diff_position_3 := COUNT(GROUP,%Closest%.Diff_position_3);
    Count_Diff_position_4 := COUNT(GROUP,%Closest%.Diff_position_4);
    Count_Diff_position_5 := COUNT(GROUP,%Closest%.Diff_position_5);
    Count_Diff_position_6 := COUNT(GROUP,%Closest%.Diff_position_6);
    Count_Diff_position_7 := COUNT(GROUP,%Closest%.Diff_position_7);
    Count_Diff_position_8 := COUNT(GROUP,%Closest%.Diff_position_8);
    Count_Diff_position_9 := COUNT(GROUP,%Closest%.Diff_position_9);
    Count_Diff_position_10 := COUNT(GROUP,%Closest%.Diff_position_10);
    Count_Diff_occupation_1 := COUNT(GROUP,%Closest%.Diff_occupation_1);
    Count_Diff_occupation_2 := COUNT(GROUP,%Closest%.Diff_occupation_2);
    Count_Diff_occupation_3 := COUNT(GROUP,%Closest%.Diff_occupation_3);
    Count_Diff_occupation_4 := COUNT(GROUP,%Closest%.Diff_occupation_4);
    Count_Diff_occupation_5 := COUNT(GROUP,%Closest%.Diff_occupation_5);
    Count_Diff_occupation_6 := COUNT(GROUP,%Closest%.Diff_occupation_6);
    Count_Diff_occupation_7 := COUNT(GROUP,%Closest%.Diff_occupation_7);
    Count_Diff_occupation_8 := COUNT(GROUP,%Closest%.Diff_occupation_8);
    Count_Diff_occupation_9 := COUNT(GROUP,%Closest%.Diff_occupation_9);
    Count_Diff_occupation_10 := COUNT(GROUP,%Closest%.Diff_occupation_10);
    Count_Diff_date_added_to_list := COUNT(GROUP,%Closest%.Diff_date_added_to_list);
    Count_Diff_date_last_updated := COUNT(GROUP,%Closest%.Diff_date_last_updated);
    Count_Diff_effective_date := COUNT(GROUP,%Closest%.Diff_effective_date);
    Count_Diff_expiration_date := COUNT(GROUP,%Closest%.Diff_expiration_date);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_grounds := COUNT(GROUP,%Closest%.Diff_grounds);
    Count_Diff_subj_to_common_pos_2001_931_cfsp_fl := COUNT(GROUP,%Closest%.Diff_subj_to_common_pos_2001_931_cfsp_fl);
    Count_Diff_federal_register_citation_1 := COUNT(GROUP,%Closest%.Diff_federal_register_citation_1);
    Count_Diff_federal_register_citation_2 := COUNT(GROUP,%Closest%.Diff_federal_register_citation_2);
    Count_Diff_federal_register_citation_3 := COUNT(GROUP,%Closest%.Diff_federal_register_citation_3);
    Count_Diff_federal_register_citation_4 := COUNT(GROUP,%Closest%.Diff_federal_register_citation_4);
    Count_Diff_federal_register_citation_5 := COUNT(GROUP,%Closest%.Diff_federal_register_citation_5);
    Count_Diff_federal_register_citation_6 := COUNT(GROUP,%Closest%.Diff_federal_register_citation_6);
    Count_Diff_federal_register_citation_7 := COUNT(GROUP,%Closest%.Diff_federal_register_citation_7);
    Count_Diff_federal_register_citation_8 := COUNT(GROUP,%Closest%.Diff_federal_register_citation_8);
    Count_Diff_federal_register_citation_9 := COUNT(GROUP,%Closest%.Diff_federal_register_citation_9);
    Count_Diff_federal_register_citation_10 := COUNT(GROUP,%Closest%.Diff_federal_register_citation_10);
    Count_Diff_federal_register_citation_date_1 := COUNT(GROUP,%Closest%.Diff_federal_register_citation_date_1);
    Count_Diff_federal_register_citation_date_2 := COUNT(GROUP,%Closest%.Diff_federal_register_citation_date_2);
    Count_Diff_federal_register_citation_date_3 := COUNT(GROUP,%Closest%.Diff_federal_register_citation_date_3);
    Count_Diff_federal_register_citation_date_4 := COUNT(GROUP,%Closest%.Diff_federal_register_citation_date_4);
    Count_Diff_federal_register_citation_date_5 := COUNT(GROUP,%Closest%.Diff_federal_register_citation_date_5);
    Count_Diff_federal_register_citation_date_6 := COUNT(GROUP,%Closest%.Diff_federal_register_citation_date_6);
    Count_Diff_federal_register_citation_date_7 := COUNT(GROUP,%Closest%.Diff_federal_register_citation_date_7);
    Count_Diff_federal_register_citation_date_8 := COUNT(GROUP,%Closest%.Diff_federal_register_citation_date_8);
    Count_Diff_federal_register_citation_date_9 := COUNT(GROUP,%Closest%.Diff_federal_register_citation_date_9);
    Count_Diff_federal_register_citation_date_10 := COUNT(GROUP,%Closest%.Diff_federal_register_citation_date_10);
    Count_Diff_license_requirement := COUNT(GROUP,%Closest%.Diff_license_requirement);
    Count_Diff_license_review_policy := COUNT(GROUP,%Closest%.Diff_license_review_policy);
    Count_Diff_subordinate_status := COUNT(GROUP,%Closest%.Diff_subordinate_status);
    Count_Diff_height := COUNT(GROUP,%Closest%.Diff_height);
    Count_Diff_weight := COUNT(GROUP,%Closest%.Diff_weight);
    Count_Diff_physique := COUNT(GROUP,%Closest%.Diff_physique);
    Count_Diff_hair_color := COUNT(GROUP,%Closest%.Diff_hair_color);
    Count_Diff_eyes := COUNT(GROUP,%Closest%.Diff_eyes);
    Count_Diff_complexion := COUNT(GROUP,%Closest%.Diff_complexion);
    Count_Diff_race := COUNT(GROUP,%Closest%.Diff_race);
    Count_Diff_scars_marks := COUNT(GROUP,%Closest%.Diff_scars_marks);
    Count_Diff_photo_file := COUNT(GROUP,%Closest%.Diff_photo_file);
    Count_Diff_offenses := COUNT(GROUP,%Closest%.Diff_offenses);
    Count_Diff_ncic := COUNT(GROUP,%Closest%.Diff_ncic);
    Count_Diff_warrant_by := COUNT(GROUP,%Closest%.Diff_warrant_by);
    Count_Diff_caution := COUNT(GROUP,%Closest%.Diff_caution);
    Count_Diff_reward := COUNT(GROUP,%Closest%.Diff_reward);
    Count_Diff_type_of_denial := COUNT(GROUP,%Closest%.Diff_type_of_denial);
    Count_Diff_linked_with_1 := COUNT(GROUP,%Closest%.Diff_linked_with_1);
    Count_Diff_linked_with_2 := COUNT(GROUP,%Closest%.Diff_linked_with_2);
    Count_Diff_linked_with_3 := COUNT(GROUP,%Closest%.Diff_linked_with_3);
    Count_Diff_linked_with_4 := COUNT(GROUP,%Closest%.Diff_linked_with_4);
    Count_Diff_linked_with_5 := COUNT(GROUP,%Closest%.Diff_linked_with_5);
    Count_Diff_linked_with_6 := COUNT(GROUP,%Closest%.Diff_linked_with_6);
    Count_Diff_linked_with_7 := COUNT(GROUP,%Closest%.Diff_linked_with_7);
    Count_Diff_linked_with_8 := COUNT(GROUP,%Closest%.Diff_linked_with_8);
    Count_Diff_linked_with_9 := COUNT(GROUP,%Closest%.Diff_linked_with_9);
    Count_Diff_linked_with_10 := COUNT(GROUP,%Closest%.Diff_linked_with_10);
    Count_Diff_linked_with_id_1 := COUNT(GROUP,%Closest%.Diff_linked_with_id_1);
    Count_Diff_linked_with_id_2 := COUNT(GROUP,%Closest%.Diff_linked_with_id_2);
    Count_Diff_linked_with_id_3 := COUNT(GROUP,%Closest%.Diff_linked_with_id_3);
    Count_Diff_linked_with_id_4 := COUNT(GROUP,%Closest%.Diff_linked_with_id_4);
    Count_Diff_linked_with_id_5 := COUNT(GROUP,%Closest%.Diff_linked_with_id_5);
    Count_Diff_linked_with_id_6 := COUNT(GROUP,%Closest%.Diff_linked_with_id_6);
    Count_Diff_linked_with_id_7 := COUNT(GROUP,%Closest%.Diff_linked_with_id_7);
    Count_Diff_linked_with_id_8 := COUNT(GROUP,%Closest%.Diff_linked_with_id_8);
    Count_Diff_linked_with_id_9 := COUNT(GROUP,%Closest%.Diff_linked_with_id_9);
    Count_Diff_linked_with_id_10 := COUNT(GROUP,%Closest%.Diff_linked_with_id_10);
    Count_Diff_listing_information := COUNT(GROUP,%Closest%.Diff_listing_information);
    Count_Diff_foreign_principal := COUNT(GROUP,%Closest%.Diff_foreign_principal);
    Count_Diff_nature_of_service := COUNT(GROUP,%Closest%.Diff_nature_of_service);
    Count_Diff_activities := COUNT(GROUP,%Closest%.Diff_activities);
    Count_Diff_finances := COUNT(GROUP,%Closest%.Diff_finances);
    Count_Diff_registrant_terminated_flag := COUNT(GROUP,%Closest%.Diff_registrant_terminated_flag);
    Count_Diff_foreign_principal_terminated_flag := COUNT(GROUP,%Closest%.Diff_foreign_principal_terminated_flag);
    Count_Diff_short_form_terminated_flag := COUNT(GROUP,%Closest%.Diff_short_form_terminated_flag);
    Count_Diff_src_key := COUNT(GROUP,%Closest%.Diff_src_key);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;
