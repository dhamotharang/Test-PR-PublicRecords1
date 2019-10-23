IMPORT SALT311;
EXPORT Infutor_VIN_Fields := MODULE

EXPORT NumFields := 67;

// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_alpha','invalid_number','invalid_alphanumeric','invalid_vin','invalid_make','invalid_model','invalid_year','invalid_date','invalid_name','invalid_address','invalid_predir','invalid_state','invalid_fuel_type_code','invalid_gender','invalid_append_ownernametypeind');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_alpha' => 1,'invalid_number' => 2,'invalid_alphanumeric' => 3,'invalid_vin' => 4,'invalid_make' => 5,'invalid_model' => 6,'invalid_year' => 7,'invalid_date' => 8,'invalid_name' => 9,'invalid_address' => 10,'invalid_predir' => 11,'invalid_state' => 12,'invalid_fuel_type_code' => 13,'invalid_gender' => 14,'invalid_append_ownernametypeind' => 15,0);

EXPORT MakeFT_invalid_alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringtouppercase(s0); // Force to upper case
  s2 := SALT311.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -'); // Only allow valid symbols
  s3 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s2,' -',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_alpha(SALT311.StrType s) := WHICH(SALT311.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -'))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotCaps,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_number(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_alphanumeric(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringtouppercase(s0); // Force to upper case
  s2 := SALT311.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -,.'); // Only allow valid symbols
  s3 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s2,' -,.',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_alphanumeric(SALT311.StrType s) := WHICH(SALT311.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -,.'))));
EXPORT InValidMessageFT_invalid_alphanumeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotCaps,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -,.'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_vin(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringtouppercase(s0); // Force to upper case
  s2 := SALT311.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789x\''); // Only allow valid symbols
  RETURN  s2;
END;
EXPORT InValidFT_invalid_vin(SALT311.StrType s) := WHICH(SALT311.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789x\''))));
EXPORT InValidMessageFT_invalid_vin(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotCaps,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789x\''),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_make(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringtouppercase(s0); // Force to upper case
  s2 := SALT311.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ() -'); // Only allow valid symbols
  s3 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s2,' -',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_make(SALT311.StrType s) := WHICH(SALT311.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ() -'))));
EXPORT InValidMessageFT_invalid_make(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotCaps,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ() -'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_model(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringtouppercase(s0); // Force to upper case
  s2 := SALT311.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789()&/. -'); // Only allow valid symbols
  s3 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s2,' -',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_model(SALT311.StrType s) := WHICH(SALT311.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789()&/. -'))));
EXPORT InValidMessageFT_invalid_model(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotCaps,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789()&/. -'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_year(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_year(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_year(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('4,0'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_date(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('8,0'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringtouppercase(s0); // Force to upper case
  s2 := SALT311.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\'& -.()"'); // Only allow valid symbols
  s3 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s2,' -.()"',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_name(SALT311.StrType s) := WHICH(SALT311.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\'& -.()"'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotCaps,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ\'& -.()"'),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_address(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringtouppercase(s0); // Force to upper case
  s2 := SALT311.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789#\'/-&()@$ .,'); // Only allow valid symbols
  s3 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s2,' .,',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_address(SALT311.StrType s) := WHICH(SALT311.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789#\'/-&()@$ .,'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_address(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotCaps,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789#\'/-&()@$ .,'),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_predir(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ESWN .'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' .',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_predir(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ESWN .'))));
EXPORT InValidMessageFT_invalid_predir(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ESWN .'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_state(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringtouppercase(s0); // Force to upper case
  s2 := SALT311.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s2;
END;
EXPORT InValidFT_invalid_state(SALT311.StrType s) := WHICH(SALT311.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotCaps,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.NotLength('2,0'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_fuel_type_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fuel_type_code(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['B','D','F','G','I','L','N','O','P','Y','H',''],~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_fuel_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('B|D|F|G|I|L|N|O|P|Y|H|'),SALT311.HygieneErrors.NotLength('1,0'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_gender(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_gender(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['F','M',''],~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_gender(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('F|M|'),SALT311.HygieneErrors.NotLength('1,0'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_append_ownernametypeind(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_append_ownernametypeind(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['B','D','I','P','U',''],~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_append_ownernametypeind(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('B|D|I|P|U|'),SALT311.HygieneErrors.NotLength('1,0'),SALT311.HygieneErrors.Good);


EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'iid','pid','vin','make','model','year','class_code','fuel_type_code','mfg_code','style_code','mileagecd','nbr_vehicles','idate','odate','fname','mi','lname','suffix','gender','house','predir','street','strtype','postdir','apttype','aptnbr','city','state','zip','z4','dpc','crte','cnty','z4type','dpv','vacant','phone','dnc','internal1','internal2','internal3','county','msa','cbsa','ehi','child','homeowner','pctw','pctb','pcta','pcth','pctspe','pctsps','pctspa','mhv','mor','pctoccw','pctoccb','pctocco','lor','sfdu','mfdu','processdate','source_code','state_origin','append_ownernametypeind','fullname');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'iid','pid','vin','make','model','year','class_code','fuel_type_code','mfg_code','style_code','mileagecd','nbr_vehicles','idate','odate','fname','mi','lname','suffix','gender','house','predir','street','strtype','postdir','apttype','aptnbr','city','state','zip','z4','dpc','crte','cnty','z4type','dpv','vacant','phone','dnc','internal1','internal2','internal3','county','msa','cbsa','ehi','child','homeowner','pctw','pctb','pcta','pcth','pctspe','pctsps','pctspa','mhv','mor','pctoccw','pctoccb','pctocco','lor','sfdu','mfdu','processdate','source_code','state_origin','append_ownernametypeind','fullname');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'iid' => 0,'pid' => 1,'vin' => 2,'make' => 3,'model' => 4,'year' => 5,'class_code' => 6,'fuel_type_code' => 7,'mfg_code' => 8,'style_code' => 9,'mileagecd' => 10,'nbr_vehicles' => 11,'idate' => 12,'odate' => 13,'fname' => 14,'mi' => 15,'lname' => 16,'suffix' => 17,'gender' => 18,'house' => 19,'predir' => 20,'street' => 21,'strtype' => 22,'postdir' => 23,'apttype' => 24,'aptnbr' => 25,'city' => 26,'state' => 27,'zip' => 28,'z4' => 29,'dpc' => 30,'crte' => 31,'cnty' => 32,'z4type' => 33,'dpv' => 34,'vacant' => 35,'phone' => 36,'dnc' => 37,'internal1' => 38,'internal2' => 39,'internal3' => 40,'county' => 41,'msa' => 42,'cbsa' => 43,'ehi' => 44,'child' => 45,'homeowner' => 46,'pctw' => 47,'pctb' => 48,'pcta' => 49,'pcth' => 50,'pctspe' => 51,'pctsps' => 52,'pctspa' => 53,'mhv' => 54,'mor' => 55,'pctoccw' => 56,'pctoccb' => 57,'pctocco' => 58,'lor' => 59,'sfdu' => 60,'mfdu' => 61,'processdate' => 62,'source_code' => 63,'state_origin' => 64,'append_ownernametypeind' => 65,'fullname' => 66,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],[],[],['CAPS','ALLOW'],['CAPS','ALLOW'],['ALLOW','LENGTHS'],[],['ENUM','LENGTHS'],[],['CAPS','ALLOW'],['CAPS','ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['CAPS','ALLOW','LENGTHS'],['CAPS','ALLOW','LENGTHS'],['CAPS','ALLOW','LENGTHS'],['CAPS','ALLOW','LENGTHS'],['ENUM','LENGTHS'],['CAPS','ALLOW','LENGTHS'],['ALLOW'],['CAPS','ALLOW','LENGTHS'],['CAPS','ALLOW','LENGTHS'],['ALLOW'],['CAPS','ALLOW','LENGTHS'],['CAPS','ALLOW','LENGTHS'],['CAPS','ALLOW','LENGTHS'],['CAPS','ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],[],[],[],[],[],[],['ALLOW'],[],['CAPS','ALLOW'],[],[],['CAPS','ALLOW','LENGTHS'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);

//Individual field level validation


EXPORT Make_iid(SALT311.StrType s0) := s0;
EXPORT InValid_iid(SALT311.StrType s) := 0;
EXPORT InValidMessage_iid(UNSIGNED1 wh) := '';


EXPORT Make_pid(SALT311.StrType s0) := s0;
EXPORT InValid_pid(SALT311.StrType s) := 0;
EXPORT InValidMessage_pid(UNSIGNED1 wh) := '';


EXPORT Make_vin(SALT311.StrType s0) := s0;
EXPORT InValid_vin(SALT311.StrType s) := 0;
EXPORT InValidMessage_vin(UNSIGNED1 wh) := '';


EXPORT Make_make(SALT311.StrType s0) := MakeFT_invalid_make(s0);
EXPORT InValid_make(SALT311.StrType s) := InValidFT_invalid_make(s);
EXPORT InValidMessage_make(UNSIGNED1 wh) := InValidMessageFT_invalid_make(wh);


EXPORT Make_model(SALT311.StrType s0) := MakeFT_invalid_model(s0);
EXPORT InValid_model(SALT311.StrType s) := InValidFT_invalid_model(s);
EXPORT InValidMessage_model(UNSIGNED1 wh) := InValidMessageFT_invalid_model(wh);


EXPORT Make_year(SALT311.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_year(SALT311.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_year(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);


EXPORT Make_class_code(SALT311.StrType s0) := s0;
EXPORT InValid_class_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_class_code(UNSIGNED1 wh) := '';


EXPORT Make_fuel_type_code(SALT311.StrType s0) := MakeFT_invalid_fuel_type_code(s0);
EXPORT InValid_fuel_type_code(SALT311.StrType s) := InValidFT_invalid_fuel_type_code(s);
EXPORT InValidMessage_fuel_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_fuel_type_code(wh);


EXPORT Make_mfg_code(SALT311.StrType s0) := s0;
EXPORT InValid_mfg_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_mfg_code(UNSIGNED1 wh) := '';


EXPORT Make_style_code(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_style_code(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_style_code(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);


EXPORT Make_mileagecd(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_mileagecd(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_mileagecd(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_nbr_vehicles(SALT311.StrType s0) := MakeFT_invalid_number(s0);
EXPORT InValid_nbr_vehicles(SALT311.StrType s) := InValidFT_invalid_number(s);
EXPORT InValidMessage_nbr_vehicles(UNSIGNED1 wh) := InValidMessageFT_invalid_number(wh);


EXPORT Make_idate(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_idate(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_idate(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_odate(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_odate(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_odate(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_fname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_fname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);


EXPORT Make_mi(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_mi(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_mi(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);


EXPORT Make_lname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_lname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);


EXPORT Make_suffix(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_suffix(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);


EXPORT Make_gender(SALT311.StrType s0) := MakeFT_invalid_gender(s0);
EXPORT InValid_gender(SALT311.StrType s) := InValidFT_invalid_gender(s);
EXPORT InValidMessage_gender(UNSIGNED1 wh) := InValidMessageFT_invalid_gender(wh);


EXPORT Make_house(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_house(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_house(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);


EXPORT Make_predir(SALT311.StrType s0) := MakeFT_invalid_predir(s0);
EXPORT InValid_predir(SALT311.StrType s) := InValidFT_invalid_predir(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_predir(wh);


EXPORT Make_street(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_street(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_street(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);


EXPORT Make_strtype(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_strtype(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_strtype(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);


EXPORT Make_postdir(SALT311.StrType s0) := MakeFT_invalid_predir(s0);
EXPORT InValid_postdir(SALT311.StrType s) := InValidFT_invalid_predir(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_predir(wh);


EXPORT Make_apttype(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_apttype(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_apttype(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);


EXPORT Make_aptnbr(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_aptnbr(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_aptnbr(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);


EXPORT Make_city(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_city(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);


EXPORT Make_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);


EXPORT Make_zip(SALT311.StrType s0) := MakeFT_invalid_number(s0);
EXPORT InValid_zip(SALT311.StrType s) := InValidFT_invalid_number(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_number(wh);


EXPORT Make_z4(SALT311.StrType s0) := MakeFT_invalid_number(s0);
EXPORT InValid_z4(SALT311.StrType s) := InValidFT_invalid_number(s);
EXPORT InValidMessage_z4(UNSIGNED1 wh) := InValidMessageFT_invalid_number(wh);


EXPORT Make_dpc(SALT311.StrType s0) := s0;
EXPORT InValid_dpc(SALT311.StrType s) := 0;
EXPORT InValidMessage_dpc(UNSIGNED1 wh) := '';


EXPORT Make_crte(SALT311.StrType s0) := s0;
EXPORT InValid_crte(SALT311.StrType s) := 0;
EXPORT InValidMessage_crte(UNSIGNED1 wh) := '';


EXPORT Make_cnty(SALT311.StrType s0) := s0;
EXPORT InValid_cnty(SALT311.StrType s) := 0;
EXPORT InValidMessage_cnty(UNSIGNED1 wh) := '';


EXPORT Make_z4type(SALT311.StrType s0) := s0;
EXPORT InValid_z4type(SALT311.StrType s) := 0;
EXPORT InValidMessage_z4type(UNSIGNED1 wh) := '';


EXPORT Make_dpv(SALT311.StrType s0) := s0;
EXPORT InValid_dpv(SALT311.StrType s) := 0;
EXPORT InValidMessage_dpv(UNSIGNED1 wh) := '';


EXPORT Make_vacant(SALT311.StrType s0) := s0;
EXPORT InValid_vacant(SALT311.StrType s) := 0;
EXPORT InValidMessage_vacant(UNSIGNED1 wh) := '';


EXPORT Make_phone(SALT311.StrType s0) := MakeFT_invalid_number(s0);
EXPORT InValid_phone(SALT311.StrType s) := InValidFT_invalid_number(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_number(wh);


EXPORT Make_dnc(SALT311.StrType s0) := s0;
EXPORT InValid_dnc(SALT311.StrType s) := 0;
EXPORT InValidMessage_dnc(UNSIGNED1 wh) := '';


EXPORT Make_internal1(SALT311.StrType s0) := MakeFT_invalid_vin(s0);
EXPORT InValid_internal1(SALT311.StrType s) := InValidFT_invalid_vin(s);
EXPORT InValidMessage_internal1(UNSIGNED1 wh) := InValidMessageFT_invalid_vin(wh);


EXPORT Make_internal2(SALT311.StrType s0) := s0;
EXPORT InValid_internal2(SALT311.StrType s) := 0;
EXPORT InValidMessage_internal2(UNSIGNED1 wh) := '';


EXPORT Make_internal3(SALT311.StrType s0) := s0;
EXPORT InValid_internal3(SALT311.StrType s) := 0;
EXPORT InValidMessage_internal3(UNSIGNED1 wh) := '';


EXPORT Make_county(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_county(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_county(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);


EXPORT Make_msa(SALT311.StrType s0) := s0;
EXPORT InValid_msa(SALT311.StrType s) := 0;
EXPORT InValidMessage_msa(UNSIGNED1 wh) := '';


EXPORT Make_cbsa(SALT311.StrType s0) := s0;
EXPORT InValid_cbsa(SALT311.StrType s) := 0;
EXPORT InValidMessage_cbsa(UNSIGNED1 wh) := '';


EXPORT Make_ehi(SALT311.StrType s0) := s0;
EXPORT InValid_ehi(SALT311.StrType s) := 0;
EXPORT InValidMessage_ehi(UNSIGNED1 wh) := '';


EXPORT Make_child(SALT311.StrType s0) := s0;
EXPORT InValid_child(SALT311.StrType s) := 0;
EXPORT InValidMessage_child(UNSIGNED1 wh) := '';


EXPORT Make_homeowner(SALT311.StrType s0) := s0;
EXPORT InValid_homeowner(SALT311.StrType s) := 0;
EXPORT InValidMessage_homeowner(UNSIGNED1 wh) := '';


EXPORT Make_pctw(SALT311.StrType s0) := s0;
EXPORT InValid_pctw(SALT311.StrType s) := 0;
EXPORT InValidMessage_pctw(UNSIGNED1 wh) := '';


EXPORT Make_pctb(SALT311.StrType s0) := s0;
EXPORT InValid_pctb(SALT311.StrType s) := 0;
EXPORT InValidMessage_pctb(UNSIGNED1 wh) := '';


EXPORT Make_pcta(SALT311.StrType s0) := s0;
EXPORT InValid_pcta(SALT311.StrType s) := 0;
EXPORT InValidMessage_pcta(UNSIGNED1 wh) := '';


EXPORT Make_pcth(SALT311.StrType s0) := s0;
EXPORT InValid_pcth(SALT311.StrType s) := 0;
EXPORT InValidMessage_pcth(UNSIGNED1 wh) := '';


EXPORT Make_pctspe(SALT311.StrType s0) := s0;
EXPORT InValid_pctspe(SALT311.StrType s) := 0;
EXPORT InValidMessage_pctspe(UNSIGNED1 wh) := '';


EXPORT Make_pctsps(SALT311.StrType s0) := s0;
EXPORT InValid_pctsps(SALT311.StrType s) := 0;
EXPORT InValidMessage_pctsps(UNSIGNED1 wh) := '';


EXPORT Make_pctspa(SALT311.StrType s0) := s0;
EXPORT InValid_pctspa(SALT311.StrType s) := 0;
EXPORT InValidMessage_pctspa(UNSIGNED1 wh) := '';


EXPORT Make_mhv(SALT311.StrType s0) := s0;
EXPORT InValid_mhv(SALT311.StrType s) := 0;
EXPORT InValidMessage_mhv(UNSIGNED1 wh) := '';


EXPORT Make_mor(SALT311.StrType s0) := s0;
EXPORT InValid_mor(SALT311.StrType s) := 0;
EXPORT InValidMessage_mor(UNSIGNED1 wh) := '';


EXPORT Make_pctoccw(SALT311.StrType s0) := s0;
EXPORT InValid_pctoccw(SALT311.StrType s) := 0;
EXPORT InValidMessage_pctoccw(UNSIGNED1 wh) := '';


EXPORT Make_pctoccb(SALT311.StrType s0) := s0;
EXPORT InValid_pctoccb(SALT311.StrType s) := 0;
EXPORT InValidMessage_pctoccb(UNSIGNED1 wh) := '';


EXPORT Make_pctocco(SALT311.StrType s0) := s0;
EXPORT InValid_pctocco(SALT311.StrType s) := 0;
EXPORT InValidMessage_pctocco(UNSIGNED1 wh) := '';


EXPORT Make_lor(SALT311.StrType s0) := s0;
EXPORT InValid_lor(SALT311.StrType s) := 0;
EXPORT InValidMessage_lor(UNSIGNED1 wh) := '';


EXPORT Make_sfdu(SALT311.StrType s0) := s0;
EXPORT InValid_sfdu(SALT311.StrType s) := 0;
EXPORT InValidMessage_sfdu(UNSIGNED1 wh) := '';


EXPORT Make_mfdu(SALT311.StrType s0) := s0;
EXPORT InValid_mfdu(SALT311.StrType s) := 0;
EXPORT InValidMessage_mfdu(UNSIGNED1 wh) := '';


EXPORT Make_processdate(SALT311.StrType s0) := s0;
EXPORT InValid_processdate(SALT311.StrType s) := 0;
EXPORT InValidMessage_processdate(UNSIGNED1 wh) := '';


EXPORT Make_source_code(SALT311.StrType s0) := s0;
EXPORT InValid_source_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_source_code(UNSIGNED1 wh) := '';


EXPORT Make_state_origin(SALT311.StrType s0) := s0;
EXPORT InValid_state_origin(SALT311.StrType s) := 0;
EXPORT InValidMessage_state_origin(UNSIGNED1 wh) := '';


EXPORT Make_append_ownernametypeind(SALT311.StrType s0) := s0;
EXPORT InValid_append_ownernametypeind(SALT311.StrType s) := 0;
EXPORT InValidMessage_append_ownernametypeind(UNSIGNED1 wh) := '';


EXPORT Make_fullname(SALT311.StrType s0) := s0;
EXPORT InValid_fullname(SALT311.StrType s) := 0;
EXPORT InValidMessage_fullname(UNSIGNED1 wh) := '';

// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_VehicleV2;
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
    SALT311.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
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
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
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
