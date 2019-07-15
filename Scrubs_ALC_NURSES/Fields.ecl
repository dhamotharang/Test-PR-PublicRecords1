IMPORT SALT37;
IMPORT Scrubs,ALC; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT37.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_slashO_date','invalid_alpha','invalid_alphapound','invalid_alphaspace','invalid_alphaspacequote','invalid_date','invalid_numeric','invalid_numericpound','invalid_alphanumeric','invalid_gender','invalid_addr_type','invalid_license_number','invalid_marital_status');
EXPORT FieldTypeNum(SALT37.StrType fn) := CASE(fn,'invalid_slashO_date' => 1,'invalid_alpha' => 2,'invalid_alphapound' => 3,'invalid_alphaspace' => 4,'invalid_alphaspacequote' => 5,'invalid_date' => 6,'invalid_numeric' => 7,'invalid_numericpound' => 8,'invalid_alphanumeric' => 9,'invalid_gender' => 10,'invalid_addr_type' => 11,'invalid_license_number' => 12,'invalid_marital_status' => 13,0);
 
EXPORT MakeFT_invalid_slashO_date(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'/O0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_slashO_date(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'/O0123456789'))));
EXPORT InValidMessageFT_invalid_slashO_date(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('/O0123456789'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphapound(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'#ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphapound(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'#ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_invalid_alphapound(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('#ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphaspace(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphaspace(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_invalid_alphaspace(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphaspacequote(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' \'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphaspacequote(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' \'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_invalid_alphaspacequote(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' \'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_pastDate(s)>0);
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('0123456789'),SALT37.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('0123456789'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numericpound(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'#0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numericpound(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'#0123456789'))));
EXPORT InValidMessageFT_invalid_numericpound(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('#0123456789'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanumeric(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphanumeric(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'))));
EXPORT InValidMessageFT_invalid_alphanumeric(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_gender(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_gender(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['M','F','B','I','U',' ']);
EXPORT InValidMessageFT_invalid_gender(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('M|F|B|I|U| '),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_addr_type(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'#BCDHLPUXY'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_addr_type(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'#BCDHLPUXY'))));
EXPORT InValidMessageFT_invalid_addr_type(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('#BCDHLPUXY'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_license_number(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' .-#*\\ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_license_number(SALT37.StrType s,SALT37.StrType reg_state) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' .-#*\\ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'))),~ALC.Custom_Scrubs.fn_valid_tx_nurse_license_no(s,reg_state)<1);
EXPORT InValidMessageFT_invalid_license_number(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' .-#*\\ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),SALT37.HygieneErrors.CustomFail('ALC.Custom_Scrubs.fn_valid_tx_nurse_license_no'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_marital_status(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_marital_status(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['M','S',' ']);
EXPORT InValidMessageFT_invalid_marital_status(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('M|S| '),SALT37.HygieneErrors.Good);
 
EXPORT SALT37.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'fname','lname','title','company','address1','address2','city','state','zip','zip4','cart','bar','gender','country','postal_cd','dpv','addr_type','age','county_cd','household_income','marital_status','msa','nielsen_county_cd','nurse_type','reg_state','specialty','email','phone','list_id','scno','keycode','custno','license_no','dob','orig_date','exp_date','degree');
EXPORT FieldNum(SALT37.StrType fn) := CASE(fn,'fname' => 0,'lname' => 1,'title' => 2,'company' => 3,'address1' => 4,'address2' => 5,'city' => 6,'state' => 7,'zip' => 8,'zip4' => 9,'cart' => 10,'bar' => 11,'gender' => 12,'country' => 13,'postal_cd' => 14,'dpv' => 15,'addr_type' => 16,'age' => 17,'county_cd' => 18,'household_income' => 19,'marital_status' => 20,'msa' => 21,'nielsen_county_cd' => 22,'nurse_type' => 23,'reg_state' => 24,'specialty' => 25,'email' => 26,'phone' => 27,'list_id' => 28,'scno' => 29,'keycode' => 30,'custno' => 31,'license_no' => 32,'dob' => 33,'orig_date' => 34,'exp_date' => 35,'degree' => 36,0);
 
//Individual field level validation
 
EXPORT Make_fname(SALT37.StrType s0) := MakeFT_invalid_alphaspacequote(s0);
EXPORT InValid_fname(SALT37.StrType s) := InValidFT_invalid_alphaspacequote(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_alphaspacequote(wh);
 
EXPORT Make_lname(SALT37.StrType s0) := MakeFT_invalid_alphaspacequote(s0);
EXPORT InValid_lname(SALT37.StrType s) := InValidFT_invalid_alphaspacequote(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_alphaspacequote(wh);
 
EXPORT Make_title(SALT37.StrType s0) := MakeFT_invalid_alphaspace(s0);
EXPORT InValid_title(SALT37.StrType s) := InValidFT_invalid_alphaspace(s);
EXPORT InValidMessage_title(UNSIGNED1 wh) := InValidMessageFT_invalid_alphaspace(wh);
 
EXPORT Make_company(SALT37.StrType s0) := s0;
EXPORT InValid_company(SALT37.StrType s) := 0;
EXPORT InValidMessage_company(UNSIGNED1 wh) := '';
 
EXPORT Make_address1(SALT37.StrType s0) := s0;
EXPORT InValid_address1(SALT37.StrType s) := 0;
EXPORT InValidMessage_address1(UNSIGNED1 wh) := '';
 
EXPORT Make_address2(SALT37.StrType s0) := s0;
EXPORT InValid_address2(SALT37.StrType s) := 0;
EXPORT InValidMessage_address2(UNSIGNED1 wh) := '';
 
EXPORT Make_city(SALT37.StrType s0) := s0;
EXPORT InValid_city(SALT37.StrType s) := 0;
EXPORT InValidMessage_city(UNSIGNED1 wh) := '';
 
EXPORT Make_state(SALT37.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_state(SALT37.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_zip(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_zip(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_zip4(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_zip4(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_cart(SALT37.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_cart(SALT37.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_cart(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_bar(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_bar(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_bar(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_gender(SALT37.StrType s0) := MakeFT_invalid_gender(s0);
EXPORT InValid_gender(SALT37.StrType s) := InValidFT_invalid_gender(s);
EXPORT InValidMessage_gender(UNSIGNED1 wh) := InValidMessageFT_invalid_gender(wh);
 
EXPORT Make_country(SALT37.StrType s0) := s0;
EXPORT InValid_country(SALT37.StrType s) := 0;
EXPORT InValidMessage_country(UNSIGNED1 wh) := '';
 
EXPORT Make_postal_cd(SALT37.StrType s0) := s0;
EXPORT InValid_postal_cd(SALT37.StrType s) := 0;
EXPORT InValidMessage_postal_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_dpv(SALT37.StrType s0) := s0;
EXPORT InValid_dpv(SALT37.StrType s) := 0;
EXPORT InValidMessage_dpv(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_type(SALT37.StrType s0) := MakeFT_invalid_addr_type(s0);
EXPORT InValid_addr_type(SALT37.StrType s) := InValidFT_invalid_addr_type(s);
EXPORT InValidMessage_addr_type(UNSIGNED1 wh) := InValidMessageFT_invalid_addr_type(wh);
 
EXPORT Make_age(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_age(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_age(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_county_cd(SALT37.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_county_cd(SALT37.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_county_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_household_income(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_household_income(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_household_income(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_marital_status(SALT37.StrType s0) := MakeFT_invalid_marital_status(s0);
EXPORT InValid_marital_status(SALT37.StrType s) := InValidFT_invalid_marital_status(s);
EXPORT InValidMessage_marital_status(UNSIGNED1 wh) := InValidMessageFT_invalid_marital_status(wh);
 
EXPORT Make_msa(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_msa(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_msa(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_nielsen_county_cd(SALT37.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_nielsen_county_cd(SALT37.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_nielsen_county_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_nurse_type(SALT37.StrType s0) := MakeFT_invalid_numericpound(s0);
EXPORT InValid_nurse_type(SALT37.StrType s) := InValidFT_invalid_numericpound(s);
EXPORT InValidMessage_nurse_type(UNSIGNED1 wh) := InValidMessageFT_invalid_numericpound(wh);
 
EXPORT Make_reg_state(SALT37.StrType s0) := MakeFT_invalid_alphapound(s0);
EXPORT InValid_reg_state(SALT37.StrType s) := InValidFT_invalid_alphapound(s);
EXPORT InValidMessage_reg_state(UNSIGNED1 wh) := InValidMessageFT_invalid_alphapound(wh);
 
EXPORT Make_specialty(SALT37.StrType s0) := MakeFT_invalid_numericpound(s0);
EXPORT InValid_specialty(SALT37.StrType s) := InValidFT_invalid_numericpound(s);
EXPORT InValidMessage_specialty(UNSIGNED1 wh) := InValidMessageFT_invalid_numericpound(wh);
 
EXPORT Make_email(SALT37.StrType s0) := s0;
EXPORT InValid_email(SALT37.StrType s) := 0;
EXPORT InValidMessage_email(UNSIGNED1 wh) := '';
 
EXPORT Make_phone(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_phone(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_list_id(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_list_id(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_list_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_scno(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_scno(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_scno(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_keycode(SALT37.StrType s0) := s0;
EXPORT InValid_keycode(SALT37.StrType s) := 0;
EXPORT InValidMessage_keycode(UNSIGNED1 wh) := '';
 
EXPORT Make_custno(SALT37.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_custno(SALT37.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_custno(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_license_no(SALT37.StrType s0) := MakeFT_invalid_license_number(s0);
EXPORT InValid_license_no(SALT37.StrType s,SALT37.StrType reg_state) := InValidFT_invalid_license_number(s,reg_state);
EXPORT InValidMessage_license_no(UNSIGNED1 wh) := InValidMessageFT_invalid_license_number(wh);
 
EXPORT Make_dob(SALT37.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dob(SALT37.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_orig_date(SALT37.StrType s0) := MakeFT_invalid_slashO_date(s0);
EXPORT InValid_orig_date(SALT37.StrType s) := InValidFT_invalid_slashO_date(s);
EXPORT InValidMessage_orig_date(UNSIGNED1 wh) := InValidMessageFT_invalid_slashO_date(wh);
 
EXPORT Make_exp_date(SALT37.StrType s0) := MakeFT_invalid_slashO_date(s0);
EXPORT InValid_exp_date(SALT37.StrType s) := InValidFT_invalid_slashO_date(s);
EXPORT InValidMessage_exp_date(UNSIGNED1 wh) := InValidMessageFT_invalid_slashO_date(wh);
 
EXPORT Make_degree(SALT37.StrType s0) := s0;
EXPORT InValid_degree(SALT37.StrType s) := 0;
EXPORT InValidMessage_degree(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT37,Scrubs_ALC_NURSES;
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
    BOOLEAN Diff_fname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_title;
    BOOLEAN Diff_company;
    BOOLEAN Diff_address1;
    BOOLEAN Diff_address2;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_cart;
    BOOLEAN Diff_bar;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_country;
    BOOLEAN Diff_postal_cd;
    BOOLEAN Diff_dpv;
    BOOLEAN Diff_addr_type;
    BOOLEAN Diff_age;
    BOOLEAN Diff_county_cd;
    BOOLEAN Diff_household_income;
    BOOLEAN Diff_marital_status;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_nielsen_county_cd;
    BOOLEAN Diff_nurse_type;
    BOOLEAN Diff_reg_state;
    BOOLEAN Diff_specialty;
    BOOLEAN Diff_email;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_list_id;
    BOOLEAN Diff_scno;
    BOOLEAN Diff_keycode;
    BOOLEAN Diff_custno;
    BOOLEAN Diff_license_no;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_orig_date;
    BOOLEAN Diff_exp_date;
    BOOLEAN Diff_degree;
    UNSIGNED Num_Diffs;
    SALT37.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_company := le.company <> ri.company;
    SELF.Diff_address1 := le.address1 <> ri.address1;
    SELF.Diff_address2 := le.address2 <> ri.address2;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_cart := le.cart <> ri.cart;
    SELF.Diff_bar := le.bar <> ri.bar;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_country := le.country <> ri.country;
    SELF.Diff_postal_cd := le.postal_cd <> ri.postal_cd;
    SELF.Diff_dpv := le.dpv <> ri.dpv;
    SELF.Diff_addr_type := le.addr_type <> ri.addr_type;
    SELF.Diff_age := le.age <> ri.age;
    SELF.Diff_county_cd := le.county_cd <> ri.county_cd;
    SELF.Diff_household_income := le.household_income <> ri.household_income;
    SELF.Diff_marital_status := le.marital_status <> ri.marital_status;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_nielsen_county_cd := le.nielsen_county_cd <> ri.nielsen_county_cd;
    SELF.Diff_nurse_type := le.nurse_type <> ri.nurse_type;
    SELF.Diff_reg_state := le.reg_state <> ri.reg_state;
    SELF.Diff_specialty := le.specialty <> ri.specialty;
    SELF.Diff_email := le.email <> ri.email;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_list_id := le.list_id <> ri.list_id;
    SELF.Diff_scno := le.scno <> ri.scno;
    SELF.Diff_keycode := le.keycode <> ri.keycode;
    SELF.Diff_custno := le.custno <> ri.custno;
    SELF.Diff_license_no := le.license_no <> ri.license_no;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_orig_date := le.orig_date <> ri.orig_date;
    SELF.Diff_exp_date := le.exp_date <> ri.exp_date;
    SELF.Diff_degree := le.degree <> ri.degree;
    SELF.Val := (SALT37.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_company,1,0)+ IF( SELF.Diff_address1,1,0)+ IF( SELF.Diff_address2,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_bar,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_country,1,0)+ IF( SELF.Diff_postal_cd,1,0)+ IF( SELF.Diff_dpv,1,0)+ IF( SELF.Diff_addr_type,1,0)+ IF( SELF.Diff_age,1,0)+ IF( SELF.Diff_county_cd,1,0)+ IF( SELF.Diff_household_income,1,0)+ IF( SELF.Diff_marital_status,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_nielsen_county_cd,1,0)+ IF( SELF.Diff_nurse_type,1,0)+ IF( SELF.Diff_reg_state,1,0)+ IF( SELF.Diff_specialty,1,0)+ IF( SELF.Diff_email,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_list_id,1,0)+ IF( SELF.Diff_scno,1,0)+ IF( SELF.Diff_keycode,1,0)+ IF( SELF.Diff_custno,1,0)+ IF( SELF.Diff_license_no,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_orig_date,1,0)+ IF( SELF.Diff_exp_date,1,0)+ IF( SELF.Diff_degree,1,0);
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
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_company := COUNT(GROUP,%Closest%.Diff_company);
    Count_Diff_address1 := COUNT(GROUP,%Closest%.Diff_address1);
    Count_Diff_address2 := COUNT(GROUP,%Closest%.Diff_address2);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_cart := COUNT(GROUP,%Closest%.Diff_cart);
    Count_Diff_bar := COUNT(GROUP,%Closest%.Diff_bar);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_country := COUNT(GROUP,%Closest%.Diff_country);
    Count_Diff_postal_cd := COUNT(GROUP,%Closest%.Diff_postal_cd);
    Count_Diff_dpv := COUNT(GROUP,%Closest%.Diff_dpv);
    Count_Diff_addr_type := COUNT(GROUP,%Closest%.Diff_addr_type);
    Count_Diff_age := COUNT(GROUP,%Closest%.Diff_age);
    Count_Diff_county_cd := COUNT(GROUP,%Closest%.Diff_county_cd);
    Count_Diff_household_income := COUNT(GROUP,%Closest%.Diff_household_income);
    Count_Diff_marital_status := COUNT(GROUP,%Closest%.Diff_marital_status);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_nielsen_county_cd := COUNT(GROUP,%Closest%.Diff_nielsen_county_cd);
    Count_Diff_nurse_type := COUNT(GROUP,%Closest%.Diff_nurse_type);
    Count_Diff_reg_state := COUNT(GROUP,%Closest%.Diff_reg_state);
    Count_Diff_specialty := COUNT(GROUP,%Closest%.Diff_specialty);
    Count_Diff_email := COUNT(GROUP,%Closest%.Diff_email);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_list_id := COUNT(GROUP,%Closest%.Diff_list_id);
    Count_Diff_scno := COUNT(GROUP,%Closest%.Diff_scno);
    Count_Diff_keycode := COUNT(GROUP,%Closest%.Diff_keycode);
    Count_Diff_custno := COUNT(GROUP,%Closest%.Diff_custno);
    Count_Diff_license_no := COUNT(GROUP,%Closest%.Diff_license_no);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_orig_date := COUNT(GROUP,%Closest%.Diff_orig_date);
    Count_Diff_exp_date := COUNT(GROUP,%Closest%.Diff_exp_date);
    Count_Diff_degree := COUNT(GROUP,%Closest%.Diff_degree);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
