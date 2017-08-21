IMPORT ut,SALT30;
EXPORT Fields := MODULE
// Processing for each FieldType
EXPORT SALT30.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_alpha','invalid_number','invalid_alphanumeric','invalid_vin','invalid_make','invalid_model','invalid_year','invalid_date','invalid_name','invalid_address','invalid_predir','invalid_state','invalid_fuel_type_code','invalid_gender','invalid_append_ownernametypeind');
EXPORT FieldTypeNum(SALT30.StrType fn) := CASE(fn,'invalid_alpha' => 1,'invalid_number' => 2,'invalid_alphanumeric' => 3,'invalid_vin' => 4,'invalid_make' => 5,'invalid_model' => 6,'invalid_year' => 7,'invalid_date' => 8,'invalid_name' => 9,'invalid_address' => 10,'invalid_predir' => 11,'invalid_state' => 12,'invalid_fuel_type_code' => 13,'invalid_gender' => 14,'invalid_append_ownernametypeind' => 15,0);
EXPORT MakeFT_invalid_alpha(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringtouppercase(s0); // Force to upper case
  s2 := SALT30.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -'); // Only allow valid symbols
  s3 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s2,' -',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_alpha(SALT30.StrType s) := WHICH(SALT30.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -'))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotCaps,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_number(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_number(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_number(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_alphanumeric(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringtouppercase(s0); // Force to upper case
  s2 := SALT30.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -,.'); // Only allow valid symbols
  s3 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s2,' -,.',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_alphanumeric(SALT30.StrType s) := WHICH(SALT30.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -,.'))));
EXPORT InValidMessageFT_invalid_alphanumeric(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotCaps,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -,.'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_vin(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringtouppercase(s0); // Force to upper case
  s2 := SALT30.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789x-*\''); // Only allow valid symbols
  RETURN  s2;
END;
EXPORT InValidFT_invalid_vin(SALT30.StrType s) := WHICH(SALT30.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789x-*\''))));
EXPORT InValidMessageFT_invalid_vin(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotCaps,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789x-*\''),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_make(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringtouppercase(s0); // Force to upper case
  s2 := SALT30.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ()/&. -'); // Only allow valid symbols
  s3 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s2,' -',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_make(SALT30.StrType s) := WHICH(SALT30.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ()/&. -'))));
EXPORT InValidMessageFT_invalid_make(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotCaps,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ()/&. -'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_model(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringtouppercase(s0); // Force to upper case
  s2 := SALT30.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789()&/\':. -'); // Only allow valid symbols
  s3 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s2,' -',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_model(SALT30.StrType s) := WHICH(SALT30.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789()&/\':. -'))));
EXPORT InValidMessageFT_invalid_model(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotCaps,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789()&/\':. -'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_year(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_year(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_year(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('4,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_date(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('8,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_name(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringtouppercase(s0); // Force to upper case
  s2 := SALT30.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ‘\'& -.()"'); // Only allow valid symbols
  s3 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s2,' -.()"',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_name(SALT30.StrType s) := WHICH(SALT30.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ‘\'& -.()"'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotCaps,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZÃ‘\'& -.()"'),SALT30.HygieneErrors.NotLength('0..'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_address(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringtouppercase(s0); // Force to upper case
  s2 := SALT30.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ‘0123456789#\'/-& .,'); // Only allow valid symbols
  s3 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s2,' .,',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_address(SALT30.StrType s) := WHICH(SALT30.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ‘0123456789#\'/-& .,'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_address(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotCaps,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZÃ‘0123456789#\'/-& .,'),SALT30.HygieneErrors.NotLength('0..'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_predir(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ESWN .'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' .',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_predir(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ESWN .'))));
EXPORT InValidMessageFT_invalid_predir(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ESWN .'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_state(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringtouppercase(s0); // Force to upper case
  s2 := SALT30.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s2;
END;
EXPORT InValidFT_invalid_state(SALT30.StrType s) := WHICH(SALT30.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotCaps,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT30.HygieneErrors.NotLength('2,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_fuel_type_code(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fuel_type_code(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['B','D','F','G','I','L','N','O','P','Y',''],~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_fuel_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('B|D|F|G|I|L|N|O|P|Y|'),SALT30.HygieneErrors.NotLength('1,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_gender(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_gender(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['F','M',''],~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_gender(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('F|M|'),SALT30.HygieneErrors.NotLength('1,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_append_ownernametypeind(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_append_ownernametypeind(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['B','D','I','P','U',''],~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_append_ownernametypeind(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('B|D|I|P|U|'),SALT30.HygieneErrors.NotLength('1,0'),SALT30.HygieneErrors.Good);
EXPORT SALT30.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'iid','pid','vin','make','model','year','class_code','fuel_type_code','mfg_code','style_code','mileagecd','nbr_vehicles','idate','odate','fname','mi','lname','suffix','gender','house','predir','street','strtype','postdir','apttype','aptnbr','city','state','zip','z4','dpc','crte','cnty','z4type','dpv','vacant','phone','dnc','internal1','internal2','internal3','county','msa','cbsa','ehi','child','homeowner','pctw','pctb','pcta','pcth','pctspe','pctsps','pctspa','mhv','mor','pctoccw','pctoccb','pctocco','lor','sfdu','mfdu','processdate','source_code','state_origin','append_ownernametypeind','fullname');
EXPORT FieldNum(SALT30.StrType fn) := CASE(fn,'iid' => 1,'pid' => 2,'vin' => 3,'make' => 4,'model' => 5,'year' => 6,'class_code' => 7,'fuel_type_code' => 8,'mfg_code' => 9,'style_code' => 10,'mileagecd' => 11,'nbr_vehicles' => 12,'idate' => 13,'odate' => 14,'fname' => 15,'mi' => 16,'lname' => 17,'suffix' => 18,'gender' => 19,'house' => 20,'predir' => 21,'street' => 22,'strtype' => 23,'postdir' => 24,'apttype' => 25,'aptnbr' => 26,'city' => 27,'state' => 28,'zip' => 29,'z4' => 30,'dpc' => 31,'crte' => 32,'cnty' => 33,'z4type' => 34,'dpv' => 35,'vacant' => 36,'phone' => 37,'dnc' => 38,'internal1' => 39,'internal2' => 40,'internal3' => 41,'county' => 42,'msa' => 43,'cbsa' => 44,'ehi' => 45,'child' => 46,'homeowner' => 47,'pctw' => 48,'pctb' => 49,'pcta' => 50,'pcth' => 51,'pctspe' => 52,'pctsps' => 53,'pctspa' => 54,'mhv' => 55,'mor' => 56,'pctoccw' => 57,'pctoccb' => 58,'pctocco' => 59,'lor' => 60,'sfdu' => 61,'mfdu' => 62,'processdate' => 63,'source_code' => 64,'state_origin' => 65,'append_ownernametypeind' => 66,'fullname' => 67,0);
//Individual field level validation
EXPORT Make_iid(SALT30.StrType s0) := s0;
EXPORT InValid_iid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_iid(UNSIGNED1 wh) := '';
EXPORT Make_pid(SALT30.StrType s0) := s0;
EXPORT InValid_pid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_pid(UNSIGNED1 wh) := '';
EXPORT Make_vin(SALT30.StrType s0) := s0;
EXPORT InValid_vin(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_vin(UNSIGNED1 wh) := '';
EXPORT Make_make(SALT30.StrType s0) := MakeFT_invalid_make(s0);
EXPORT InValid_make(SALT30.StrType s) := InValidFT_invalid_make(s);
EXPORT InValidMessage_make(UNSIGNED1 wh) := InValidMessageFT_invalid_make(wh);
EXPORT Make_model(SALT30.StrType s0) := MakeFT_invalid_model(s0);
EXPORT InValid_model(SALT30.StrType s) := InValidFT_invalid_model(s);
EXPORT InValidMessage_model(UNSIGNED1 wh) := InValidMessageFT_invalid_model(wh);
EXPORT Make_year(SALT30.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_year(SALT30.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_year(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);
EXPORT Make_class_code(SALT30.StrType s0) := s0;
EXPORT InValid_class_code(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_class_code(UNSIGNED1 wh) := '';
EXPORT Make_fuel_type_code(SALT30.StrType s0) := MakeFT_invalid_fuel_type_code(s0);
EXPORT InValid_fuel_type_code(SALT30.StrType s) := InValidFT_invalid_fuel_type_code(s);
EXPORT InValidMessage_fuel_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_fuel_type_code(wh);
EXPORT Make_mfg_code(SALT30.StrType s0) := s0;
EXPORT InValid_mfg_code(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_mfg_code(UNSIGNED1 wh) := '';
EXPORT Make_style_code(SALT30.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_style_code(SALT30.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_style_code(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
EXPORT Make_mileagecd(SALT30.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_mileagecd(SALT30.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_mileagecd(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
EXPORT Make_nbr_vehicles(SALT30.StrType s0) := MakeFT_invalid_number(s0);
EXPORT InValid_nbr_vehicles(SALT30.StrType s) := InValidFT_invalid_number(s);
EXPORT InValidMessage_nbr_vehicles(UNSIGNED1 wh) := InValidMessageFT_invalid_number(wh);
EXPORT Make_idate(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_idate(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_idate(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_odate(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_odate(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_odate(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_fname(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_fname(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_mi(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_mi(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_mi(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_lname(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_lname(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_suffix(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_suffix(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_gender(SALT30.StrType s0) := MakeFT_invalid_gender(s0);
EXPORT InValid_gender(SALT30.StrType s) := InValidFT_invalid_gender(s);
EXPORT InValidMessage_gender(UNSIGNED1 wh) := InValidMessageFT_invalid_gender(wh);
EXPORT Make_house(SALT30.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_house(SALT30.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_house(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_predir(SALT30.StrType s0) := MakeFT_invalid_predir(s0);
EXPORT InValid_predir(SALT30.StrType s) := InValidFT_invalid_predir(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_predir(wh);
EXPORT Make_street(SALT30.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_street(SALT30.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_street(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_strtype(SALT30.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_strtype(SALT30.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_strtype(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_postdir(SALT30.StrType s0) := MakeFT_invalid_predir(s0);
EXPORT InValid_postdir(SALT30.StrType s) := InValidFT_invalid_predir(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_predir(wh);
EXPORT Make_apttype(SALT30.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_apttype(SALT30.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_apttype(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_aptnbr(SALT30.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_aptnbr(SALT30.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_aptnbr(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_city(SALT30.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_city(SALT30.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_state(SALT30.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state(SALT30.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
EXPORT Make_zip(SALT30.StrType s0) := MakeFT_invalid_number(s0);
EXPORT InValid_zip(SALT30.StrType s) := InValidFT_invalid_number(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_number(wh);
EXPORT Make_z4(SALT30.StrType s0) := MakeFT_invalid_number(s0);
EXPORT InValid_z4(SALT30.StrType s) := InValidFT_invalid_number(s);
EXPORT InValidMessage_z4(UNSIGNED1 wh) := InValidMessageFT_invalid_number(wh);
EXPORT Make_dpc(SALT30.StrType s0) := s0;
EXPORT InValid_dpc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_dpc(UNSIGNED1 wh) := '';
EXPORT Make_crte(SALT30.StrType s0) := s0;
EXPORT InValid_crte(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_crte(UNSIGNED1 wh) := '';
EXPORT Make_cnty(SALT30.StrType s0) := s0;
EXPORT InValid_cnty(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cnty(UNSIGNED1 wh) := '';
EXPORT Make_z4type(SALT30.StrType s0) := s0;
EXPORT InValid_z4type(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_z4type(UNSIGNED1 wh) := '';
EXPORT Make_dpv(SALT30.StrType s0) := s0;
EXPORT InValid_dpv(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_dpv(UNSIGNED1 wh) := '';
EXPORT Make_vacant(SALT30.StrType s0) := s0;
EXPORT InValid_vacant(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_vacant(UNSIGNED1 wh) := '';
EXPORT Make_phone(SALT30.StrType s0) := MakeFT_invalid_number(s0);
EXPORT InValid_phone(SALT30.StrType s) := InValidFT_invalid_number(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_number(wh);
EXPORT Make_dnc(SALT30.StrType s0) := s0;
EXPORT InValid_dnc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_dnc(UNSIGNED1 wh) := '';
EXPORT Make_internal1(SALT30.StrType s0) := MakeFT_invalid_vin(s0);
EXPORT InValid_internal1(SALT30.StrType s) := InValidFT_invalid_vin(s);
EXPORT InValidMessage_internal1(UNSIGNED1 wh) := InValidMessageFT_invalid_vin(wh);
EXPORT Make_internal2(SALT30.StrType s0) := s0;
EXPORT InValid_internal2(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_internal2(UNSIGNED1 wh) := '';
EXPORT Make_internal3(SALT30.StrType s0) := s0;
EXPORT InValid_internal3(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_internal3(UNSIGNED1 wh) := '';
EXPORT Make_county(SALT30.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_county(SALT30.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_county(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_msa(SALT30.StrType s0) := s0;
EXPORT InValid_msa(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_msa(UNSIGNED1 wh) := '';
EXPORT Make_cbsa(SALT30.StrType s0) := s0;
EXPORT InValid_cbsa(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cbsa(UNSIGNED1 wh) := '';
EXPORT Make_ehi(SALT30.StrType s0) := s0;
EXPORT InValid_ehi(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_ehi(UNSIGNED1 wh) := '';
EXPORT Make_child(SALT30.StrType s0) := s0;
EXPORT InValid_child(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_child(UNSIGNED1 wh) := '';
EXPORT Make_homeowner(SALT30.StrType s0) := s0;
EXPORT InValid_homeowner(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_homeowner(UNSIGNED1 wh) := '';
EXPORT Make_pctw(SALT30.StrType s0) := s0;
EXPORT InValid_pctw(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_pctw(UNSIGNED1 wh) := '';
EXPORT Make_pctb(SALT30.StrType s0) := s0;
EXPORT InValid_pctb(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_pctb(UNSIGNED1 wh) := '';
EXPORT Make_pcta(SALT30.StrType s0) := s0;
EXPORT InValid_pcta(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_pcta(UNSIGNED1 wh) := '';
EXPORT Make_pcth(SALT30.StrType s0) := s0;
EXPORT InValid_pcth(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_pcth(UNSIGNED1 wh) := '';
EXPORT Make_pctspe(SALT30.StrType s0) := s0;
EXPORT InValid_pctspe(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_pctspe(UNSIGNED1 wh) := '';
EXPORT Make_pctsps(SALT30.StrType s0) := s0;
EXPORT InValid_pctsps(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_pctsps(UNSIGNED1 wh) := '';
EXPORT Make_pctspa(SALT30.StrType s0) := s0;
EXPORT InValid_pctspa(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_pctspa(UNSIGNED1 wh) := '';
EXPORT Make_mhv(SALT30.StrType s0) := s0;
EXPORT InValid_mhv(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_mhv(UNSIGNED1 wh) := '';
EXPORT Make_mor(SALT30.StrType s0) := s0;
EXPORT InValid_mor(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_mor(UNSIGNED1 wh) := '';
EXPORT Make_pctoccw(SALT30.StrType s0) := s0;
EXPORT InValid_pctoccw(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_pctoccw(UNSIGNED1 wh) := '';
EXPORT Make_pctoccb(SALT30.StrType s0) := s0;
EXPORT InValid_pctoccb(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_pctoccb(UNSIGNED1 wh) := '';
EXPORT Make_pctocco(SALT30.StrType s0) := s0;
EXPORT InValid_pctocco(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_pctocco(UNSIGNED1 wh) := '';
EXPORT Make_lor(SALT30.StrType s0) := s0;
EXPORT InValid_lor(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_lor(UNSIGNED1 wh) := '';
EXPORT Make_sfdu(SALT30.StrType s0) := s0;
EXPORT InValid_sfdu(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_sfdu(UNSIGNED1 wh) := '';
EXPORT Make_mfdu(SALT30.StrType s0) := s0;
EXPORT InValid_mfdu(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_mfdu(UNSIGNED1 wh) := '';
EXPORT Make_processdate(SALT30.StrType s0) := s0;
EXPORT InValid_processdate(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_processdate(UNSIGNED1 wh) := '';
EXPORT Make_source_code(SALT30.StrType s0) := s0;
EXPORT InValid_source_code(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_source_code(UNSIGNED1 wh) := '';
EXPORT Make_state_origin(SALT30.StrType s0) := s0;
EXPORT InValid_state_origin(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_state_origin(UNSIGNED1 wh) := '';
EXPORT Make_append_ownernametypeind(SALT30.StrType s0) := s0;
EXPORT InValid_append_ownernametypeind(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_append_ownernametypeind(UNSIGNED1 wh) := '';
EXPORT Make_fullname(SALT30.StrType s0) := s0;
EXPORT InValid_fullname(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_fullname(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT30,Scrubs_VehicleV2_Infutor_Motorcycle;
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
    BOOLEAN Diff_iid;
    BOOLEAN Diff_pid;
    BOOLEAN Diff_vin;
    BOOLEAN Diff_make;
    BOOLEAN Diff_model;
    BOOLEAN Diff_year;
    BOOLEAN Diff_class_code;
    BOOLEAN Diff_fuel_type_code;
    BOOLEAN Diff_mfg_code;
    BOOLEAN Diff_style_code;
    BOOLEAN Diff_mileagecd;
    BOOLEAN Diff_nbr_vehicles;
    BOOLEAN Diff_idate;
    BOOLEAN Diff_odate;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mi;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_house;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_street;
    BOOLEAN Diff_strtype;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_apttype;
    BOOLEAN Diff_aptnbr;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_z4;
    BOOLEAN Diff_dpc;
    BOOLEAN Diff_crte;
    BOOLEAN Diff_cnty;
    BOOLEAN Diff_z4type;
    BOOLEAN Diff_dpv;
    BOOLEAN Diff_vacant;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_dnc;
    BOOLEAN Diff_internal1;
    BOOLEAN Diff_internal2;
    BOOLEAN Diff_internal3;
    BOOLEAN Diff_county;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_cbsa;
    BOOLEAN Diff_ehi;
    BOOLEAN Diff_child;
    BOOLEAN Diff_homeowner;
    BOOLEAN Diff_pctw;
    BOOLEAN Diff_pctb;
    BOOLEAN Diff_pcta;
    BOOLEAN Diff_pcth;
    BOOLEAN Diff_pctspe;
    BOOLEAN Diff_pctsps;
    BOOLEAN Diff_pctspa;
    BOOLEAN Diff_mhv;
    BOOLEAN Diff_mor;
    BOOLEAN Diff_pctoccw;
    BOOLEAN Diff_pctoccb;
    BOOLEAN Diff_pctocco;
    BOOLEAN Diff_lor;
    BOOLEAN Diff_sfdu;
    BOOLEAN Diff_mfdu;
    BOOLEAN Diff_processdate;
    BOOLEAN Diff_source_code;
    BOOLEAN Diff_state_origin;
    BOOLEAN Diff_append_ownernametypeind;
    BOOLEAN Diff_fullname;
    SALT30.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT30.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_iid := le.iid <> ri.iid;
    SELF.Diff_pid := le.pid <> ri.pid;
    SELF.Diff_vin := le.vin <> ri.vin;
    SELF.Diff_make := le.make <> ri.make;
    SELF.Diff_model := le.model <> ri.model;
    SELF.Diff_year := le.year <> ri.year;
    SELF.Diff_class_code := le.class_code <> ri.class_code;
    SELF.Diff_fuel_type_code := le.fuel_type_code <> ri.fuel_type_code;
    SELF.Diff_mfg_code := le.mfg_code <> ri.mfg_code;
    SELF.Diff_style_code := le.style_code <> ri.style_code;
    SELF.Diff_mileagecd := le.mileagecd <> ri.mileagecd;
    SELF.Diff_nbr_vehicles := le.nbr_vehicles <> ri.nbr_vehicles;
    SELF.Diff_idate := le.idate <> ri.idate;
    SELF.Diff_odate := le.odate <> ri.odate;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mi := le.mi <> ri.mi;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_house := le.house <> ri.house;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_street := le.street <> ri.street;
    SELF.Diff_strtype := le.strtype <> ri.strtype;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_apttype := le.apttype <> ri.apttype;
    SELF.Diff_aptnbr := le.aptnbr <> ri.aptnbr;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_z4 := le.z4 <> ri.z4;
    SELF.Diff_dpc := le.dpc <> ri.dpc;
    SELF.Diff_crte := le.crte <> ri.crte;
    SELF.Diff_cnty := le.cnty <> ri.cnty;
    SELF.Diff_z4type := le.z4type <> ri.z4type;
    SELF.Diff_dpv := le.dpv <> ri.dpv;
    SELF.Diff_vacant := le.vacant <> ri.vacant;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_dnc := le.dnc <> ri.dnc;
    SELF.Diff_internal1 := le.internal1 <> ri.internal1;
    SELF.Diff_internal2 := le.internal2 <> ri.internal2;
    SELF.Diff_internal3 := le.internal3 <> ri.internal3;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_cbsa := le.cbsa <> ri.cbsa;
    SELF.Diff_ehi := le.ehi <> ri.ehi;
    SELF.Diff_child := le.child <> ri.child;
    SELF.Diff_homeowner := le.homeowner <> ri.homeowner;
    SELF.Diff_pctw := le.pctw <> ri.pctw;
    SELF.Diff_pctb := le.pctb <> ri.pctb;
    SELF.Diff_pcta := le.pcta <> ri.pcta;
    SELF.Diff_pcth := le.pcth <> ri.pcth;
    SELF.Diff_pctspe := le.pctspe <> ri.pctspe;
    SELF.Diff_pctsps := le.pctsps <> ri.pctsps;
    SELF.Diff_pctspa := le.pctspa <> ri.pctspa;
    SELF.Diff_mhv := le.mhv <> ri.mhv;
    SELF.Diff_mor := le.mor <> ri.mor;
    SELF.Diff_pctoccw := le.pctoccw <> ri.pctoccw;
    SELF.Diff_pctoccb := le.pctoccb <> ri.pctoccb;
    SELF.Diff_pctocco := le.pctocco <> ri.pctocco;
    SELF.Diff_lor := le.lor <> ri.lor;
    SELF.Diff_sfdu := le.sfdu <> ri.sfdu;
    SELF.Diff_mfdu := le.mfdu <> ri.mfdu;
    SELF.Diff_processdate := le.processdate <> ri.processdate;
    SELF.Diff_source_code := le.source_code <> ri.source_code;
    SELF.Diff_state_origin := le.state_origin <> ri.state_origin;
    SELF.Diff_append_ownernametypeind := le.append_ownernametypeind <> ri.append_ownernametypeind;
    SELF.Diff_fullname := le.fullname <> ri.fullname;
    SELF.Val := (SALT30.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.state_origin;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_iid,1,0)+ IF( SELF.Diff_pid,1,0)+ IF( SELF.Diff_vin,1,0)+ IF( SELF.Diff_make,1,0)+ IF( SELF.Diff_model,1,0)+ IF( SELF.Diff_year,1,0)+ IF( SELF.Diff_class_code,1,0)+ IF( SELF.Diff_fuel_type_code,1,0)+ IF( SELF.Diff_mfg_code,1,0)+ IF( SELF.Diff_style_code,1,0)+ IF( SELF.Diff_mileagecd,1,0)+ IF( SELF.Diff_nbr_vehicles,1,0)+ IF( SELF.Diff_idate,1,0)+ IF( SELF.Diff_odate,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mi,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_house,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_street,1,0)+ IF( SELF.Diff_strtype,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_apttype,1,0)+ IF( SELF.Diff_aptnbr,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_z4,1,0)+ IF( SELF.Diff_dpc,1,0)+ IF( SELF.Diff_crte,1,0)+ IF( SELF.Diff_cnty,1,0)+ IF( SELF.Diff_z4type,1,0)+ IF( SELF.Diff_dpv,1,0)+ IF( SELF.Diff_vacant,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_dnc,1,0)+ IF( SELF.Diff_internal1,1,0)+ IF( SELF.Diff_internal2,1,0)+ IF( SELF.Diff_internal3,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_cbsa,1,0)+ IF( SELF.Diff_ehi,1,0)+ IF( SELF.Diff_child,1,0)+ IF( SELF.Diff_homeowner,1,0)+ IF( SELF.Diff_pctw,1,0)+ IF( SELF.Diff_pctb,1,0)+ IF( SELF.Diff_pcta,1,0)+ IF( SELF.Diff_pcth,1,0)+ IF( SELF.Diff_pctspe,1,0)+ IF( SELF.Diff_pctsps,1,0)+ IF( SELF.Diff_pctspa,1,0)+ IF( SELF.Diff_mhv,1,0)+ IF( SELF.Diff_mor,1,0)+ IF( SELF.Diff_pctoccw,1,0)+ IF( SELF.Diff_pctoccb,1,0)+ IF( SELF.Diff_pctocco,1,0)+ IF( SELF.Diff_lor,1,0)+ IF( SELF.Diff_sfdu,1,0)+ IF( SELF.Diff_mfdu,1,0)+ IF( SELF.Diff_processdate,1,0)+ IF( SELF.Diff_source_code,1,0)+ IF( SELF.Diff_state_origin,1,0)+ IF( SELF.Diff_append_ownernametypeind,1,0)+ IF( SELF.Diff_fullname,1,0);
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
    Count_Diff_iid := COUNT(GROUP,%Closest%.Diff_iid);
    Count_Diff_pid := COUNT(GROUP,%Closest%.Diff_pid);
    Count_Diff_vin := COUNT(GROUP,%Closest%.Diff_vin);
    Count_Diff_make := COUNT(GROUP,%Closest%.Diff_make);
    Count_Diff_model := COUNT(GROUP,%Closest%.Diff_model);
    Count_Diff_year := COUNT(GROUP,%Closest%.Diff_year);
    Count_Diff_class_code := COUNT(GROUP,%Closest%.Diff_class_code);
    Count_Diff_fuel_type_code := COUNT(GROUP,%Closest%.Diff_fuel_type_code);
    Count_Diff_mfg_code := COUNT(GROUP,%Closest%.Diff_mfg_code);
    Count_Diff_style_code := COUNT(GROUP,%Closest%.Diff_style_code);
    Count_Diff_mileagecd := COUNT(GROUP,%Closest%.Diff_mileagecd);
    Count_Diff_nbr_vehicles := COUNT(GROUP,%Closest%.Diff_nbr_vehicles);
    Count_Diff_idate := COUNT(GROUP,%Closest%.Diff_idate);
    Count_Diff_odate := COUNT(GROUP,%Closest%.Diff_odate);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mi := COUNT(GROUP,%Closest%.Diff_mi);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_house := COUNT(GROUP,%Closest%.Diff_house);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_street := COUNT(GROUP,%Closest%.Diff_street);
    Count_Diff_strtype := COUNT(GROUP,%Closest%.Diff_strtype);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_apttype := COUNT(GROUP,%Closest%.Diff_apttype);
    Count_Diff_aptnbr := COUNT(GROUP,%Closest%.Diff_aptnbr);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_z4 := COUNT(GROUP,%Closest%.Diff_z4);
    Count_Diff_dpc := COUNT(GROUP,%Closest%.Diff_dpc);
    Count_Diff_crte := COUNT(GROUP,%Closest%.Diff_crte);
    Count_Diff_cnty := COUNT(GROUP,%Closest%.Diff_cnty);
    Count_Diff_z4type := COUNT(GROUP,%Closest%.Diff_z4type);
    Count_Diff_dpv := COUNT(GROUP,%Closest%.Diff_dpv);
    Count_Diff_vacant := COUNT(GROUP,%Closest%.Diff_vacant);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_dnc := COUNT(GROUP,%Closest%.Diff_dnc);
    Count_Diff_internal1 := COUNT(GROUP,%Closest%.Diff_internal1);
    Count_Diff_internal2 := COUNT(GROUP,%Closest%.Diff_internal2);
    Count_Diff_internal3 := COUNT(GROUP,%Closest%.Diff_internal3);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_cbsa := COUNT(GROUP,%Closest%.Diff_cbsa);
    Count_Diff_ehi := COUNT(GROUP,%Closest%.Diff_ehi);
    Count_Diff_child := COUNT(GROUP,%Closest%.Diff_child);
    Count_Diff_homeowner := COUNT(GROUP,%Closest%.Diff_homeowner);
    Count_Diff_pctw := COUNT(GROUP,%Closest%.Diff_pctw);
    Count_Diff_pctb := COUNT(GROUP,%Closest%.Diff_pctb);
    Count_Diff_pcta := COUNT(GROUP,%Closest%.Diff_pcta);
    Count_Diff_pcth := COUNT(GROUP,%Closest%.Diff_pcth);
    Count_Diff_pctspe := COUNT(GROUP,%Closest%.Diff_pctspe);
    Count_Diff_pctsps := COUNT(GROUP,%Closest%.Diff_pctsps);
    Count_Diff_pctspa := COUNT(GROUP,%Closest%.Diff_pctspa);
    Count_Diff_mhv := COUNT(GROUP,%Closest%.Diff_mhv);
    Count_Diff_mor := COUNT(GROUP,%Closest%.Diff_mor);
    Count_Diff_pctoccw := COUNT(GROUP,%Closest%.Diff_pctoccw);
    Count_Diff_pctoccb := COUNT(GROUP,%Closest%.Diff_pctoccb);
    Count_Diff_pctocco := COUNT(GROUP,%Closest%.Diff_pctocco);
    Count_Diff_lor := COUNT(GROUP,%Closest%.Diff_lor);
    Count_Diff_sfdu := COUNT(GROUP,%Closest%.Diff_sfdu);
    Count_Diff_mfdu := COUNT(GROUP,%Closest%.Diff_mfdu);
    Count_Diff_processdate := COUNT(GROUP,%Closest%.Diff_processdate);
    Count_Diff_source_code := COUNT(GROUP,%Closest%.Diff_source_code);
    Count_Diff_state_origin := COUNT(GROUP,%Closest%.Diff_state_origin);
    Count_Diff_append_ownernametypeind := COUNT(GROUP,%Closest%.Diff_append_ownernametypeind);
    Count_Diff_fullname := COUNT(GROUP,%Closest%.Diff_fullname);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;
