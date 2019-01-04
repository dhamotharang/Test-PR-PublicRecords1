IMPORT SALT311;
EXPORT Fields := MODULE
 
EXPORT NumFields := 39;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_phone','invalid_fname','invalid_mname','invalid_lname','invalid_gender','invalid_dob','invalid_predir_postdir','invalid_street_type','invalid_apt_type','invalid_zip','invalid_plus4','invalid_dpc','invalid_z4_type','invalid_city','invalid_state','invalid_fips_state','invalid_fips_county','invalid_cbsa','invalid_lat_long','invalid_email','invalid_verified','invalid_activity_status','invalid_Y_N');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_phone' => 1,'invalid_fname' => 2,'invalid_mname' => 3,'invalid_lname' => 4,'invalid_gender' => 5,'invalid_dob' => 6,'invalid_predir_postdir' => 7,'invalid_street_type' => 8,'invalid_apt_type' => 9,'invalid_zip' => 10,'invalid_plus4' => 11,'invalid_dpc' => 12,'invalid_z4_type' => 13,'invalid_city' => 14,'invalid_state' => 15,'invalid_fips_state' => 16,'invalid_fips_county' => 17,'invalid_cbsa' => 18,'invalid_lat_long' => 19,'invalid_email' => 20,'invalid_verified' => 21,'invalid_activity_status' => 22,'invalid_Y_N' => 23,0);
 
EXPORT MakeFT_invalid_phone(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_phone(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('10'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fname(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s1;
END;
EXPORT InValidFT_invalid_fname(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 15));
EXPORT InValidMessageFT_invalid_fname(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('0..15'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mname(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s1;
END;
EXPORT InValidFT_invalid_mname(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_mname(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('0,1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lname(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s1;
END;
EXPORT InValidFT_invalid_lname(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 20));
EXPORT InValidMessageFT_invalid_lname(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('0..20'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_gender(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s1;
END;
EXPORT InValidFT_invalid_gender(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['F','M','']);
EXPORT InValidMessageFT_invalid_gender(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('F|M|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dob(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_dob(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('0,8'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_predir_postdir(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ENSW '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_predir_postdir(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ENSW '))));
EXPORT InValidMessageFT_invalid_predir_postdir(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ENSW '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_street_type(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_street_type(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_street_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_apt_type(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'#ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_apt_type(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'#ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_apt_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('#ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_zip(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('5,0'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_plus4(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_plus4(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_plus4(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('4,0'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dpc(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_dpc(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_invalid_dpc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_z4_type(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'FGHPRS '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_z4_type(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'FGHPRS '))));
EXPORT InValidMessageFT_invalid_z4_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('FGHPRS '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_city(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_city(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_city(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['AL','AK','AZ','AR','CA','CO','CT','DE','DC','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY','AA','AP','AE','AS','GU','MP','PR','VI','PW','']);
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('AL|AK|AZ|AR|CA|CO|CT|DE|DC|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AA|AP|AE|AS|GU|MP|PR|VI|PW|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fips_state(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_fips_state(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_fips_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('2,0'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fips_county(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_fips_county(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_fips_county(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('3,0'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cbsa(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_cbsa(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_invalid_cbsa(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lat_long(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'-.0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_lat_long(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'-.0123456789 '))));
EXPORT InValidMessageFT_invalid_lat_long(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('-.0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_email(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'@.ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_email(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'@.ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_email(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('@.ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_verified(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDE'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_verified(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDE'))));
EXPORT InValidMessageFT_invalid_verified(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDE'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_activity_status(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s1;
END;
EXPORT InValidFT_invalid_activity_status(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['A1','A2','A3','A4','A5','A6','A7','I1','I2','I3','I4','I5','I6','I7','U']);
EXPORT InValidMessageFT_invalid_activity_status(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('A1|A2|A3|A4|A5|A6|A7|I1|I2|I3|I4|I5|I6|I7|U'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_Y_N(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_Y_N(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['Y','N']);
EXPORT InValidMessageFT_invalid_Y_N(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('Y|N'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'phone','fname','mname','lname','salutation','suffix','gender','dob','house','pre_dir','street','street_type','post_dir','apt_type','apt_nbr','zip','plus4','dpc','z4_type','crte','city','state','dpvcmra','dpvconf','fips_state','fips_county','census_tract','census_block_group','cbsa','match_code','latitude','longitude','email','filler1','filler2','verified','activity_status','prepaid','cord_cutter');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'phone','fname','mname','lname','salutation','suffix','gender','dob','house','pre_dir','street','street_type','post_dir','apt_type','apt_nbr','zip','plus4','dpc','z4_type','crte','city','state','dpvcmra','dpvconf','fips_state','fips_county','census_tract','census_block_group','cbsa','match_code','latitude','longitude','email','filler1','filler2','verified','activity_status','prepaid','cord_cutter');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'phone' => 0,'fname' => 1,'mname' => 2,'lname' => 3,'salutation' => 4,'suffix' => 5,'gender' => 6,'dob' => 7,'house' => 8,'pre_dir' => 9,'street' => 10,'street_type' => 11,'post_dir' => 12,'apt_type' => 13,'apt_nbr' => 14,'zip' => 15,'plus4' => 16,'dpc' => 17,'z4_type' => 18,'crte' => 19,'city' => 20,'state' => 21,'dpvcmra' => 22,'dpvconf' => 23,'fips_state' => 24,'fips_county' => 25,'census_tract' => 26,'census_block_group' => 27,'cbsa' => 28,'match_code' => 29,'latitude' => 30,'longitude' => 31,'email' => 32,'filler1' => 33,'filler2' => 34,'verified' => 35,'activity_status' => 36,'prepaid' => 37,'cord_cutter' => 38,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','LENGTHS'],[],[],[],[],[],['ENUM'],['ALLOW','LENGTHS'],[],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ENUM'],[],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],[],[],['ALLOW'],['ENUM'],['ENUM'],['ENUM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_phone(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_phone(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_fname(SALT311.StrType s0) := s0;
EXPORT InValid_fname(SALT311.StrType s) := 0;
EXPORT InValidMessage_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_mname(SALT311.StrType s0) := s0;
EXPORT InValid_mname(SALT311.StrType s) := 0;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_lname(SALT311.StrType s0) := s0;
EXPORT InValid_lname(SALT311.StrType s) := 0;
EXPORT InValidMessage_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_salutation(SALT311.StrType s0) := s0;
EXPORT InValid_salutation(SALT311.StrType s) := 0;
EXPORT InValidMessage_salutation(UNSIGNED1 wh) := '';
 
EXPORT Make_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_gender(SALT311.StrType s0) := MakeFT_invalid_gender(s0);
EXPORT InValid_gender(SALT311.StrType s) := InValidFT_invalid_gender(s);
EXPORT InValidMessage_gender(UNSIGNED1 wh) := InValidMessageFT_invalid_gender(wh);
 
EXPORT Make_dob(SALT311.StrType s0) := MakeFT_invalid_dob(s0);
EXPORT InValid_dob(SALT311.StrType s) := InValidFT_invalid_dob(s);
EXPORT InValidMessage_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_dob(wh);
 
EXPORT Make_house(SALT311.StrType s0) := s0;
EXPORT InValid_house(SALT311.StrType s) := 0;
EXPORT InValidMessage_house(UNSIGNED1 wh) := '';
 
EXPORT Make_pre_dir(SALT311.StrType s0) := MakeFT_invalid_predir_postdir(s0);
EXPORT InValid_pre_dir(SALT311.StrType s) := InValidFT_invalid_predir_postdir(s);
EXPORT InValidMessage_pre_dir(UNSIGNED1 wh) := InValidMessageFT_invalid_predir_postdir(wh);
 
EXPORT Make_street(SALT311.StrType s0) := s0;
EXPORT InValid_street(SALT311.StrType s) := 0;
EXPORT InValidMessage_street(UNSIGNED1 wh) := '';
 
EXPORT Make_street_type(SALT311.StrType s0) := MakeFT_invalid_street_type(s0);
EXPORT InValid_street_type(SALT311.StrType s) := InValidFT_invalid_street_type(s);
EXPORT InValidMessage_street_type(UNSIGNED1 wh) := InValidMessageFT_invalid_street_type(wh);
 
EXPORT Make_post_dir(SALT311.StrType s0) := MakeFT_invalid_predir_postdir(s0);
EXPORT InValid_post_dir(SALT311.StrType s) := InValidFT_invalid_predir_postdir(s);
EXPORT InValidMessage_post_dir(UNSIGNED1 wh) := InValidMessageFT_invalid_predir_postdir(wh);
 
EXPORT Make_apt_type(SALT311.StrType s0) := MakeFT_invalid_apt_type(s0);
EXPORT InValid_apt_type(SALT311.StrType s) := InValidFT_invalid_apt_type(s);
EXPORT InValidMessage_apt_type(UNSIGNED1 wh) := InValidMessageFT_invalid_apt_type(wh);
 
EXPORT Make_apt_nbr(SALT311.StrType s0) := s0;
EXPORT InValid_apt_nbr(SALT311.StrType s) := 0;
EXPORT InValidMessage_apt_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_zip(SALT311.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_zip(SALT311.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_plus4(SALT311.StrType s0) := MakeFT_invalid_plus4(s0);
EXPORT InValid_plus4(SALT311.StrType s) := InValidFT_invalid_plus4(s);
EXPORT InValidMessage_plus4(UNSIGNED1 wh) := InValidMessageFT_invalid_plus4(wh);
 
EXPORT Make_dpc(SALT311.StrType s0) := MakeFT_invalid_dpc(s0);
EXPORT InValid_dpc(SALT311.StrType s) := InValidFT_invalid_dpc(s);
EXPORT InValidMessage_dpc(UNSIGNED1 wh) := InValidMessageFT_invalid_dpc(wh);
 
EXPORT Make_z4_type(SALT311.StrType s0) := MakeFT_invalid_z4_type(s0);
EXPORT InValid_z4_type(SALT311.StrType s) := InValidFT_invalid_z4_type(s);
EXPORT InValidMessage_z4_type(UNSIGNED1 wh) := InValidMessageFT_invalid_z4_type(wh);
 
EXPORT Make_crte(SALT311.StrType s0) := s0;
EXPORT InValid_crte(SALT311.StrType s) := 0;
EXPORT InValidMessage_crte(UNSIGNED1 wh) := '';
 
EXPORT Make_city(SALT311.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_city(SALT311.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_dpvcmra(SALT311.StrType s0) := s0;
EXPORT InValid_dpvcmra(SALT311.StrType s) := 0;
EXPORT InValidMessage_dpvcmra(UNSIGNED1 wh) := '';
 
EXPORT Make_dpvconf(SALT311.StrType s0) := s0;
EXPORT InValid_dpvconf(SALT311.StrType s) := 0;
EXPORT InValidMessage_dpvconf(UNSIGNED1 wh) := '';
 
EXPORT Make_fips_state(SALT311.StrType s0) := MakeFT_invalid_fips_state(s0);
EXPORT InValid_fips_state(SALT311.StrType s) := InValidFT_invalid_fips_state(s);
EXPORT InValidMessage_fips_state(UNSIGNED1 wh) := InValidMessageFT_invalid_fips_state(wh);
 
EXPORT Make_fips_county(SALT311.StrType s0) := MakeFT_invalid_fips_county(s0);
EXPORT InValid_fips_county(SALT311.StrType s) := InValidFT_invalid_fips_county(s);
EXPORT InValidMessage_fips_county(UNSIGNED1 wh) := InValidMessageFT_invalid_fips_county(wh);
 
EXPORT Make_census_tract(SALT311.StrType s0) := s0;
EXPORT InValid_census_tract(SALT311.StrType s) := 0;
EXPORT InValidMessage_census_tract(UNSIGNED1 wh) := '';
 
EXPORT Make_census_block_group(SALT311.StrType s0) := s0;
EXPORT InValid_census_block_group(SALT311.StrType s) := 0;
EXPORT InValidMessage_census_block_group(UNSIGNED1 wh) := '';
 
EXPORT Make_cbsa(SALT311.StrType s0) := MakeFT_invalid_cbsa(s0);
EXPORT InValid_cbsa(SALT311.StrType s) := InValidFT_invalid_cbsa(s);
EXPORT InValidMessage_cbsa(UNSIGNED1 wh) := InValidMessageFT_invalid_cbsa(wh);
 
EXPORT Make_match_code(SALT311.StrType s0) := s0;
EXPORT InValid_match_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_match_code(UNSIGNED1 wh) := '';
 
EXPORT Make_latitude(SALT311.StrType s0) := MakeFT_invalid_lat_long(s0);
EXPORT InValid_latitude(SALT311.StrType s) := InValidFT_invalid_lat_long(s);
EXPORT InValidMessage_latitude(UNSIGNED1 wh) := InValidMessageFT_invalid_lat_long(wh);
 
EXPORT Make_longitude(SALT311.StrType s0) := MakeFT_invalid_lat_long(s0);
EXPORT InValid_longitude(SALT311.StrType s) := InValidFT_invalid_lat_long(s);
EXPORT InValidMessage_longitude(UNSIGNED1 wh) := InValidMessageFT_invalid_lat_long(wh);
 
EXPORT Make_email(SALT311.StrType s0) := MakeFT_invalid_email(s0);
EXPORT InValid_email(SALT311.StrType s) := InValidFT_invalid_email(s);
EXPORT InValidMessage_email(UNSIGNED1 wh) := InValidMessageFT_invalid_email(wh);
 
EXPORT Make_filler1(SALT311.StrType s0) := s0;
EXPORT InValid_filler1(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler1(UNSIGNED1 wh) := '';
 
EXPORT Make_filler2(SALT311.StrType s0) := s0;
EXPORT InValid_filler2(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler2(UNSIGNED1 wh) := '';
 
EXPORT Make_verified(SALT311.StrType s0) := MakeFT_invalid_verified(s0);
EXPORT InValid_verified(SALT311.StrType s) := InValidFT_invalid_verified(s);
EXPORT InValidMessage_verified(UNSIGNED1 wh) := InValidMessageFT_invalid_verified(wh);
 
EXPORT Make_activity_status(SALT311.StrType s0) := MakeFT_invalid_activity_status(s0);
EXPORT InValid_activity_status(SALT311.StrType s) := InValidFT_invalid_activity_status(s);
EXPORT InValidMessage_activity_status(UNSIGNED1 wh) := InValidMessageFT_invalid_activity_status(wh);
 
EXPORT Make_prepaid(SALT311.StrType s0) := MakeFT_invalid_Y_N(s0);
EXPORT InValid_prepaid(SALT311.StrType s) := InValidFT_invalid_Y_N(s);
EXPORT InValidMessage_prepaid(UNSIGNED1 wh) := InValidMessageFT_invalid_Y_N(wh);
 
EXPORT Make_cord_cutter(SALT311.StrType s0) := MakeFT_invalid_Y_N(s0);
EXPORT InValid_cord_cutter(SALT311.StrType s) := InValidFT_invalid_Y_N(s);
EXPORT InValidMessage_cord_cutter(UNSIGNED1 wh) := InValidMessageFT_invalid_Y_N(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_NeustarWireless;
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
    BOOLEAN Diff_phone;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_salutation;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_house;
    BOOLEAN Diff_pre_dir;
    BOOLEAN Diff_street;
    BOOLEAN Diff_street_type;
    BOOLEAN Diff_post_dir;
    BOOLEAN Diff_apt_type;
    BOOLEAN Diff_apt_nbr;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_plus4;
    BOOLEAN Diff_dpc;
    BOOLEAN Diff_z4_type;
    BOOLEAN Diff_crte;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_dpvcmra;
    BOOLEAN Diff_dpvconf;
    BOOLEAN Diff_fips_state;
    BOOLEAN Diff_fips_county;
    BOOLEAN Diff_census_tract;
    BOOLEAN Diff_census_block_group;
    BOOLEAN Diff_cbsa;
    BOOLEAN Diff_match_code;
    BOOLEAN Diff_latitude;
    BOOLEAN Diff_longitude;
    BOOLEAN Diff_email;
    BOOLEAN Diff_filler1;
    BOOLEAN Diff_filler2;
    BOOLEAN Diff_verified;
    BOOLEAN Diff_activity_status;
    BOOLEAN Diff_prepaid;
    BOOLEAN Diff_cord_cutter;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_salutation := le.salutation <> ri.salutation;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_house := le.house <> ri.house;
    SELF.Diff_pre_dir := le.pre_dir <> ri.pre_dir;
    SELF.Diff_street := le.street <> ri.street;
    SELF.Diff_street_type := le.street_type <> ri.street_type;
    SELF.Diff_post_dir := le.post_dir <> ri.post_dir;
    SELF.Diff_apt_type := le.apt_type <> ri.apt_type;
    SELF.Diff_apt_nbr := le.apt_nbr <> ri.apt_nbr;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_plus4 := le.plus4 <> ri.plus4;
    SELF.Diff_dpc := le.dpc <> ri.dpc;
    SELF.Diff_z4_type := le.z4_type <> ri.z4_type;
    SELF.Diff_crte := le.crte <> ri.crte;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_dpvcmra := le.dpvcmra <> ri.dpvcmra;
    SELF.Diff_dpvconf := le.dpvconf <> ri.dpvconf;
    SELF.Diff_fips_state := le.fips_state <> ri.fips_state;
    SELF.Diff_fips_county := le.fips_county <> ri.fips_county;
    SELF.Diff_census_tract := le.census_tract <> ri.census_tract;
    SELF.Diff_census_block_group := le.census_block_group <> ri.census_block_group;
    SELF.Diff_cbsa := le.cbsa <> ri.cbsa;
    SELF.Diff_match_code := le.match_code <> ri.match_code;
    SELF.Diff_latitude := le.latitude <> ri.latitude;
    SELF.Diff_longitude := le.longitude <> ri.longitude;
    SELF.Diff_email := le.email <> ri.email;
    SELF.Diff_filler1 := le.filler1 <> ri.filler1;
    SELF.Diff_filler2 := le.filler2 <> ri.filler2;
    SELF.Diff_verified := le.verified <> ri.verified;
    SELF.Diff_activity_status := le.activity_status <> ri.activity_status;
    SELF.Diff_prepaid := le.prepaid <> ri.prepaid;
    SELF.Diff_cord_cutter := le.cord_cutter <> ri.cord_cutter;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_salutation,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_house,1,0)+ IF( SELF.Diff_pre_dir,1,0)+ IF( SELF.Diff_street,1,0)+ IF( SELF.Diff_street_type,1,0)+ IF( SELF.Diff_post_dir,1,0)+ IF( SELF.Diff_apt_type,1,0)+ IF( SELF.Diff_apt_nbr,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_plus4,1,0)+ IF( SELF.Diff_dpc,1,0)+ IF( SELF.Diff_z4_type,1,0)+ IF( SELF.Diff_crte,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_dpvcmra,1,0)+ IF( SELF.Diff_dpvconf,1,0)+ IF( SELF.Diff_fips_state,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_census_tract,1,0)+ IF( SELF.Diff_census_block_group,1,0)+ IF( SELF.Diff_cbsa,1,0)+ IF( SELF.Diff_match_code,1,0)+ IF( SELF.Diff_latitude,1,0)+ IF( SELF.Diff_longitude,1,0)+ IF( SELF.Diff_email,1,0)+ IF( SELF.Diff_filler1,1,0)+ IF( SELF.Diff_filler2,1,0)+ IF( SELF.Diff_verified,1,0)+ IF( SELF.Diff_activity_status,1,0)+ IF( SELF.Diff_prepaid,1,0)+ IF( SELF.Diff_cord_cutter,1,0);
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
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_salutation := COUNT(GROUP,%Closest%.Diff_salutation);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_house := COUNT(GROUP,%Closest%.Diff_house);
    Count_Diff_pre_dir := COUNT(GROUP,%Closest%.Diff_pre_dir);
    Count_Diff_street := COUNT(GROUP,%Closest%.Diff_street);
    Count_Diff_street_type := COUNT(GROUP,%Closest%.Diff_street_type);
    Count_Diff_post_dir := COUNT(GROUP,%Closest%.Diff_post_dir);
    Count_Diff_apt_type := COUNT(GROUP,%Closest%.Diff_apt_type);
    Count_Diff_apt_nbr := COUNT(GROUP,%Closest%.Diff_apt_nbr);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_plus4 := COUNT(GROUP,%Closest%.Diff_plus4);
    Count_Diff_dpc := COUNT(GROUP,%Closest%.Diff_dpc);
    Count_Diff_z4_type := COUNT(GROUP,%Closest%.Diff_z4_type);
    Count_Diff_crte := COUNT(GROUP,%Closest%.Diff_crte);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_dpvcmra := COUNT(GROUP,%Closest%.Diff_dpvcmra);
    Count_Diff_dpvconf := COUNT(GROUP,%Closest%.Diff_dpvconf);
    Count_Diff_fips_state := COUNT(GROUP,%Closest%.Diff_fips_state);
    Count_Diff_fips_county := COUNT(GROUP,%Closest%.Diff_fips_county);
    Count_Diff_census_tract := COUNT(GROUP,%Closest%.Diff_census_tract);
    Count_Diff_census_block_group := COUNT(GROUP,%Closest%.Diff_census_block_group);
    Count_Diff_cbsa := COUNT(GROUP,%Closest%.Diff_cbsa);
    Count_Diff_match_code := COUNT(GROUP,%Closest%.Diff_match_code);
    Count_Diff_latitude := COUNT(GROUP,%Closest%.Diff_latitude);
    Count_Diff_longitude := COUNT(GROUP,%Closest%.Diff_longitude);
    Count_Diff_email := COUNT(GROUP,%Closest%.Diff_email);
    Count_Diff_filler1 := COUNT(GROUP,%Closest%.Diff_filler1);
    Count_Diff_filler2 := COUNT(GROUP,%Closest%.Diff_filler2);
    Count_Diff_verified := COUNT(GROUP,%Closest%.Diff_verified);
    Count_Diff_activity_status := COUNT(GROUP,%Closest%.Diff_activity_status);
    Count_Diff_prepaid := COUNT(GROUP,%Closest%.Diff_prepaid);
    Count_Diff_cord_cutter := COUNT(GROUP,%Closest%.Diff_cord_cutter);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
