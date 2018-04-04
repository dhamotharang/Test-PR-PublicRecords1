IMPORT SALT38;
EXPORT input_Fields := MODULE
 
EXPORT NumFields := 29;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_nums','invalid_gender_code','invalid_alpha','invalid_address','invalid_county_name','invalid_zip','invalid_college_class','invalid_college_code','invalid_college_type','invalid_income_lvl_code','invalid_income','invalid_file_type','invalid_major');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'invalid_nums' => 1,'invalid_gender_code' => 2,'invalid_alpha' => 3,'invalid_address' => 4,'invalid_county_name' => 5,'invalid_zip' => 6,'invalid_college_class' => 7,'invalid_college_code' => 8,'invalid_college_type' => 9,'invalid_income_lvl_code' => 10,'invalid_income' => 11,'invalid_file_type' => 12,'invalid_major' => 13,0);
 
EXPORT MakeFT_invalid_nums(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_nums(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_invalid_nums(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789 '),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_gender_code(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_gender_code(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['1','2','M','F','U','']);
EXPORT InValidMessageFT_invalid_gender_code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('1|2|M|F|U|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz- '); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alpha(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz- '))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz- '),SALT38.HygieneErrors.NotLength('1..'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_address(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'\',./#-&/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_address(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'\',./#-&/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_address(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('\',./#-&/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_county_name(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -'); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' -',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_county_name(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -'))),~(SALT38.WordCount(SALT38.StringSubstituteOut(s,' -',' ')) = 1 OR SALT38.WordCount(SALT38.StringSubstituteOut(s,' -',' ')) = 2 OR SALT38.WordCount(SALT38.StringSubstituteOut(s,' -',' ')) = 3 OR SALT38.WordCount(SALT38.StringSubstituteOut(s,' -',' ')) = 4 OR SALT38.WordCount(SALT38.StringSubstituteOut(s,' -',' ')) = 5));
EXPORT InValidMessageFT_invalid_county_name(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -'),SALT38.HygieneErrors.NotWords('1,2,3,4,5'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.NotLength('5,9'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_college_class(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_college_class(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['FR','GR','JR','SO','SR','UN','']);
EXPORT InValidMessageFT_invalid_college_class(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('FR|GR|JR|SO|SR|UN|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_college_code(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_college_code(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['1','2','4','']);
EXPORT InValidMessageFT_invalid_college_code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('1|2|4|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_college_type(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_college_type(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['N','P','R','S','']);
EXPORT InValidMessageFT_invalid_college_type(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('N|P|R|S|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_income_lvl_code(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_income_lvl_code(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['A','B','C','D','E','F','G','H','I','J','K','T','L','M','N','O','']);
EXPORT InValidMessageFT_invalid_income_lvl_code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('A|B|C|D|E|F|G|H|I|J|K|T|L|M|N|O|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_income(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'$,+-0123456789OVER '); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_income(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'$,+-0123456789OVER '))));
EXPORT InValidMessageFT_invalid_income(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('$,+-0123456789OVER '),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_file_type(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_file_type(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['M','C','H']);
EXPORT InValidMessageFT_invalid_file_type(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('M|C|H'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_major(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_major(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_major(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'name','first_name','last_name','address_1','address_2','city','state','z5','zip_4','crrt_code','delivery_point_barcode','zip4_check_digit','address_type','county_number','county_name','gender','age','birth_date','telephone','class','college_class','college_name','college_major','college_code','college_type','head_of_household_first_name','head_of_household_gender','income_level','file_type');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'name','first_name','last_name','address_1','address_2','city','state','z5','zip_4','crrt_code','delivery_point_barcode','zip4_check_digit','address_type','county_number','county_name','gender','age','birth_date','telephone','class','college_class','college_name','college_major','college_code','college_type','head_of_household_first_name','head_of_household_gender','income_level','file_type');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'name' => 0,'first_name' => 1,'last_name' => 2,'address_1' => 3,'address_2' => 4,'city' => 5,'state' => 6,'z5' => 7,'zip_4' => 8,'crrt_code' => 9,'delivery_point_barcode' => 10,'zip4_check_digit' => 11,'address_type' => 12,'county_number' => 13,'county_name' => 14,'gender' => 15,'age' => 16,'birth_date' => 17,'telephone' => 18,'class' => 19,'college_class' => 20,'college_name' => 21,'college_major' => 22,'college_code' => 23,'college_type' => 24,'head_of_household_first_name' => 25,'head_of_household_gender' => 26,'income_level' => 27,'file_type' => 28,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW'],['ALLOW'],['ALLOW','LENGTH'],[],['ALLOW','LENGTH'],[],[],[],[],[],['ALLOW'],['ALLOW','WORDS'],['ENUM'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ENUM'],[],['ALLOW'],['ENUM'],['ENUM'],[],['ENUM'],['ENUM'],['ENUM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_name(SALT38.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_name(SALT38.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_first_name(SALT38.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_first_name(SALT38.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_first_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_last_name(SALT38.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_last_name(SALT38.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_last_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_address_1(SALT38.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_address_1(SALT38.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_address_1(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_address_2(SALT38.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_address_2(SALT38.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_address_2(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_city(SALT38.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_city(SALT38.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_state(SALT38.StrType s0) := s0;
EXPORT InValid_state(SALT38.StrType s) := 0;
EXPORT InValidMessage_state(UNSIGNED1 wh) := '';
 
EXPORT Make_z5(SALT38.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_z5(SALT38.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_z5(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_zip_4(SALT38.StrType s0) := s0;
EXPORT InValid_zip_4(SALT38.StrType s) := 0;
EXPORT InValidMessage_zip_4(UNSIGNED1 wh) := '';
 
EXPORT Make_crrt_code(SALT38.StrType s0) := s0;
EXPORT InValid_crrt_code(SALT38.StrType s) := 0;
EXPORT InValidMessage_crrt_code(UNSIGNED1 wh) := '';
 
EXPORT Make_delivery_point_barcode(SALT38.StrType s0) := s0;
EXPORT InValid_delivery_point_barcode(SALT38.StrType s) := 0;
EXPORT InValidMessage_delivery_point_barcode(UNSIGNED1 wh) := '';
 
EXPORT Make_zip4_check_digit(SALT38.StrType s0) := s0;
EXPORT InValid_zip4_check_digit(SALT38.StrType s) := 0;
EXPORT InValidMessage_zip4_check_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_address_type(SALT38.StrType s0) := s0;
EXPORT InValid_address_type(SALT38.StrType s) := 0;
EXPORT InValidMessage_address_type(UNSIGNED1 wh) := '';
 
EXPORT Make_county_number(SALT38.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_county_number(SALT38.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_county_number(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_county_name(SALT38.StrType s0) := MakeFT_invalid_county_name(s0);
EXPORT InValid_county_name(SALT38.StrType s) := InValidFT_invalid_county_name(s);
EXPORT InValidMessage_county_name(UNSIGNED1 wh) := InValidMessageFT_invalid_county_name(wh);
 
EXPORT Make_gender(SALT38.StrType s0) := MakeFT_invalid_gender_code(s0);
EXPORT InValid_gender(SALT38.StrType s) := InValidFT_invalid_gender_code(s);
EXPORT InValidMessage_gender(UNSIGNED1 wh) := InValidMessageFT_invalid_gender_code(wh);
 
EXPORT Make_age(SALT38.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_age(SALT38.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_age(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_birth_date(SALT38.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_birth_date(SALT38.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_birth_date(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_telephone(SALT38.StrType s0) := MakeFT_invalid_nums(s0);
EXPORT InValid_telephone(SALT38.StrType s) := InValidFT_invalid_nums(s);
EXPORT InValidMessage_telephone(UNSIGNED1 wh) := InValidMessageFT_invalid_nums(wh);
 
EXPORT Make_class(SALT38.StrType s0) := s0;
EXPORT InValid_class(SALT38.StrType s) := 0;
EXPORT InValidMessage_class(UNSIGNED1 wh) := '';
 
EXPORT Make_college_class(SALT38.StrType s0) := MakeFT_invalid_college_class(s0);
EXPORT InValid_college_class(SALT38.StrType s) := InValidFT_invalid_college_class(s);
EXPORT InValidMessage_college_class(UNSIGNED1 wh) := InValidMessageFT_invalid_college_class(wh);
 
EXPORT Make_college_name(SALT38.StrType s0) := s0;
EXPORT InValid_college_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_college_name(UNSIGNED1 wh) := '';
 
EXPORT Make_college_major(SALT38.StrType s0) := MakeFT_invalid_major(s0);
EXPORT InValid_college_major(SALT38.StrType s) := InValidFT_invalid_major(s);
EXPORT InValidMessage_college_major(UNSIGNED1 wh) := InValidMessageFT_invalid_major(wh);
 
EXPORT Make_college_code(SALT38.StrType s0) := MakeFT_invalid_college_code(s0);
EXPORT InValid_college_code(SALT38.StrType s) := InValidFT_invalid_college_code(s);
EXPORT InValidMessage_college_code(UNSIGNED1 wh) := InValidMessageFT_invalid_college_code(wh);
 
EXPORT Make_college_type(SALT38.StrType s0) := MakeFT_invalid_college_type(s0);
EXPORT InValid_college_type(SALT38.StrType s) := InValidFT_invalid_college_type(s);
EXPORT InValidMessage_college_type(UNSIGNED1 wh) := InValidMessageFT_invalid_college_type(wh);
 
EXPORT Make_head_of_household_first_name(SALT38.StrType s0) := s0;
EXPORT InValid_head_of_household_first_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_head_of_household_first_name(UNSIGNED1 wh) := '';
 
EXPORT Make_head_of_household_gender(SALT38.StrType s0) := MakeFT_invalid_gender_code(s0);
EXPORT InValid_head_of_household_gender(SALT38.StrType s) := InValidFT_invalid_gender_code(s);
EXPORT InValidMessage_head_of_household_gender(UNSIGNED1 wh) := InValidMessageFT_invalid_gender_code(wh);
 
EXPORT Make_income_level(SALT38.StrType s0) := MakeFT_invalid_income_lvl_code(s0);
EXPORT InValid_income_level(SALT38.StrType s) := InValidFT_invalid_income_lvl_code(s);
EXPORT InValidMessage_income_level(UNSIGNED1 wh) := InValidMessageFT_invalid_income_lvl_code(wh);
 
EXPORT Make_file_type(SALT38.StrType s0) := MakeFT_invalid_file_type(s0);
EXPORT InValid_file_type(SALT38.StrType s) := InValidFT_invalid_file_type(s);
EXPORT InValidMessage_file_type(UNSIGNED1 wh) := InValidMessageFT_invalid_file_type(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_American_Student_List;
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
    BOOLEAN Diff_name;
    BOOLEAN Diff_first_name;
    BOOLEAN Diff_last_name;
    BOOLEAN Diff_address_1;
    BOOLEAN Diff_address_2;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_z5;
    BOOLEAN Diff_zip_4;
    BOOLEAN Diff_crrt_code;
    BOOLEAN Diff_delivery_point_barcode;
    BOOLEAN Diff_zip4_check_digit;
    BOOLEAN Diff_address_type;
    BOOLEAN Diff_county_number;
    BOOLEAN Diff_county_name;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_age;
    BOOLEAN Diff_birth_date;
    BOOLEAN Diff_telephone;
    BOOLEAN Diff_class;
    BOOLEAN Diff_college_class;
    BOOLEAN Diff_college_name;
    BOOLEAN Diff_college_major;
    BOOLEAN Diff_college_code;
    BOOLEAN Diff_college_type;
    BOOLEAN Diff_head_of_household_first_name;
    BOOLEAN Diff_head_of_household_gender;
    BOOLEAN Diff_income_level;
    BOOLEAN Diff_file_type;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_name := le.name <> ri.name;
    SELF.Diff_first_name := le.first_name <> ri.first_name;
    SELF.Diff_last_name := le.last_name <> ri.last_name;
    SELF.Diff_address_1 := le.address_1 <> ri.address_1;
    SELF.Diff_address_2 := le.address_2 <> ri.address_2;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_z5 := le.z5 <> ri.z5;
    SELF.Diff_zip_4 := le.zip_4 <> ri.zip_4;
    SELF.Diff_crrt_code := le.crrt_code <> ri.crrt_code;
    SELF.Diff_delivery_point_barcode := le.delivery_point_barcode <> ri.delivery_point_barcode;
    SELF.Diff_zip4_check_digit := le.zip4_check_digit <> ri.zip4_check_digit;
    SELF.Diff_address_type := le.address_type <> ri.address_type;
    SELF.Diff_county_number := le.county_number <> ri.county_number;
    SELF.Diff_county_name := le.county_name <> ri.county_name;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_age := le.age <> ri.age;
    SELF.Diff_birth_date := le.birth_date <> ri.birth_date;
    SELF.Diff_telephone := le.telephone <> ri.telephone;
    SELF.Diff_class := le.class <> ri.class;
    SELF.Diff_college_class := le.college_class <> ri.college_class;
    SELF.Diff_college_name := le.college_name <> ri.college_name;
    SELF.Diff_college_major := le.college_major <> ri.college_major;
    SELF.Diff_college_code := le.college_code <> ri.college_code;
    SELF.Diff_college_type := le.college_type <> ri.college_type;
    SELF.Diff_head_of_household_first_name := le.head_of_household_first_name <> ri.head_of_household_first_name;
    SELF.Diff_head_of_household_gender := le.head_of_household_gender <> ri.head_of_household_gender;
    SELF.Diff_income_level := le.income_level <> ri.income_level;
    SELF.Diff_file_type := le.file_type <> ri.file_type;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_name,1,0)+ IF( SELF.Diff_first_name,1,0)+ IF( SELF.Diff_last_name,1,0)+ IF( SELF.Diff_address_1,1,0)+ IF( SELF.Diff_address_2,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_z5,1,0)+ IF( SELF.Diff_zip_4,1,0)+ IF( SELF.Diff_crrt_code,1,0)+ IF( SELF.Diff_delivery_point_barcode,1,0)+ IF( SELF.Diff_zip4_check_digit,1,0)+ IF( SELF.Diff_address_type,1,0)+ IF( SELF.Diff_county_number,1,0)+ IF( SELF.Diff_county_name,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_age,1,0)+ IF( SELF.Diff_birth_date,1,0)+ IF( SELF.Diff_telephone,1,0)+ IF( SELF.Diff_class,1,0)+ IF( SELF.Diff_college_class,1,0)+ IF( SELF.Diff_college_name,1,0)+ IF( SELF.Diff_college_major,1,0)+ IF( SELF.Diff_college_code,1,0)+ IF( SELF.Diff_college_type,1,0)+ IF( SELF.Diff_head_of_household_first_name,1,0)+ IF( SELF.Diff_head_of_household_gender,1,0)+ IF( SELF.Diff_income_level,1,0)+ IF( SELF.Diff_file_type,1,0);
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
    Count_Diff_name := COUNT(GROUP,%Closest%.Diff_name);
    Count_Diff_first_name := COUNT(GROUP,%Closest%.Diff_first_name);
    Count_Diff_last_name := COUNT(GROUP,%Closest%.Diff_last_name);
    Count_Diff_address_1 := COUNT(GROUP,%Closest%.Diff_address_1);
    Count_Diff_address_2 := COUNT(GROUP,%Closest%.Diff_address_2);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_z5 := COUNT(GROUP,%Closest%.Diff_z5);
    Count_Diff_zip_4 := COUNT(GROUP,%Closest%.Diff_zip_4);
    Count_Diff_crrt_code := COUNT(GROUP,%Closest%.Diff_crrt_code);
    Count_Diff_delivery_point_barcode := COUNT(GROUP,%Closest%.Diff_delivery_point_barcode);
    Count_Diff_zip4_check_digit := COUNT(GROUP,%Closest%.Diff_zip4_check_digit);
    Count_Diff_address_type := COUNT(GROUP,%Closest%.Diff_address_type);
    Count_Diff_county_number := COUNT(GROUP,%Closest%.Diff_county_number);
    Count_Diff_county_name := COUNT(GROUP,%Closest%.Diff_county_name);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_age := COUNT(GROUP,%Closest%.Diff_age);
    Count_Diff_birth_date := COUNT(GROUP,%Closest%.Diff_birth_date);
    Count_Diff_telephone := COUNT(GROUP,%Closest%.Diff_telephone);
    Count_Diff_class := COUNT(GROUP,%Closest%.Diff_class);
    Count_Diff_college_class := COUNT(GROUP,%Closest%.Diff_college_class);
    Count_Diff_college_name := COUNT(GROUP,%Closest%.Diff_college_name);
    Count_Diff_college_major := COUNT(GROUP,%Closest%.Diff_college_major);
    Count_Diff_college_code := COUNT(GROUP,%Closest%.Diff_college_code);
    Count_Diff_college_type := COUNT(GROUP,%Closest%.Diff_college_type);
    Count_Diff_head_of_household_first_name := COUNT(GROUP,%Closest%.Diff_head_of_household_first_name);
    Count_Diff_head_of_household_gender := COUNT(GROUP,%Closest%.Diff_head_of_household_gender);
    Count_Diff_income_level := COUNT(GROUP,%Closest%.Diff_income_level);
    Count_Diff_file_type := COUNT(GROUP,%Closest%.Diff_file_type);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
