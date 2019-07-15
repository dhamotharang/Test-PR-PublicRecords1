IMPORT SALT37;
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT37.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_addr_type','invalid_alpha','invalid_alphanumeric','invalid_alphanumericpound','invalid_alphanumericpoundspacequote','invalid_alphapound','invalid_alphaspacequote','invalid_business_ind','invalid_gender','invalid_number_of_lawyers_range','invalid_numeric','invalid_numericpound');
EXPORT FieldTypeNum(SALT37.StrType fn) := CASE(fn,'invalid_addr_type' => 1,'invalid_alpha' => 2,'invalid_alphanumeric' => 3,'invalid_alphanumericpound' => 4,'invalid_alphanumericpoundspacequote' => 5,'invalid_alphapound' => 6,'invalid_alphaspacequote' => 7,'invalid_business_ind' => 8,'invalid_gender' => 9,'invalid_number_of_lawyers_range' => 10,'invalid_numeric' => 11,'invalid_numericpound' => 12,0);
 
EXPORT MakeFT_invalid_addr_type(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'#BCDHLPUXY'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_addr_type(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'#BCDHLPUXY'))));
EXPORT InValidMessageFT_invalid_addr_type(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('#BCDHLPUXY'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanumeric(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphanumeric(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'))));
EXPORT InValidMessageFT_invalid_alphanumeric(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanumericpound(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'#ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphanumericpound(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'#ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'))));
EXPORT InValidMessageFT_invalid_alphanumericpound(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('#ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanumericpoundspacequote(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' \'#ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphanumericpoundspacequote(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' \'#ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'))));
EXPORT InValidMessageFT_invalid_alphanumericpoundspacequote(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' \'#ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphapound(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'#ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphapound(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'#ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_invalid_alphapound(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('#ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphaspacequote(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' \'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphaspacequote(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' \'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_invalid_alphaspacequote(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' \'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_business_ind(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_business_ind(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['1','2',' ']);
EXPORT InValidMessageFT_invalid_business_ind(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('1|2| '),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_gender(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_gender(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['M','F','B','I','U',' ']);
EXPORT InValidMessageFT_invalid_gender(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('M|F|B|I|U| '),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_number_of_lawyers_range(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_number_of_lawyers_range(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['01','02','03','04','05','06','07','08','09',' ']);
EXPORT InValidMessageFT_invalid_number_of_lawyers_range(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('01|02|03|04|05|06|07|08|09| '),SALT37.HygieneErrors.Good);
 
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
 
EXPORT SALT37.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'fname','lname','title','company','address1','address2','city','state','zip','zip4','cart','bar','gender','country','postal_cd','dpv','addr_type','business_ind','county_cd','msa','nielsen_county_cd','number_of_lawyers_range','practice_area','title_cd','phone','list_id','scno','keycode','custno');
EXPORT FieldNum(SALT37.StrType fn) := CASE(fn,'fname' => 0,'lname' => 1,'title' => 2,'company' => 3,'address1' => 4,'address2' => 5,'city' => 6,'state' => 7,'zip' => 8,'zip4' => 9,'cart' => 10,'bar' => 11,'gender' => 12,'country' => 13,'postal_cd' => 14,'dpv' => 15,'addr_type' => 16,'business_ind' => 17,'county_cd' => 18,'msa' => 19,'nielsen_county_cd' => 20,'number_of_lawyers_range' => 21,'practice_area' => 22,'title_cd' => 23,'phone' => 24,'list_id' => 25,'scno' => 26,'keycode' => 27,'custno' => 28,0);
 
//Individual field level validation
 
EXPORT Make_fname(SALT37.StrType s0) := MakeFT_invalid_alphaspacequote(s0);
EXPORT InValid_fname(SALT37.StrType s) := InValidFT_invalid_alphaspacequote(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_alphaspacequote(wh);
 
EXPORT Make_lname(SALT37.StrType s0) := MakeFT_invalid_alphaspacequote(s0);
EXPORT InValid_lname(SALT37.StrType s) := InValidFT_invalid_alphaspacequote(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_alphaspacequote(wh);
 
EXPORT Make_title(SALT37.StrType s0) := MakeFT_invalid_alphanumericpoundspacequote(s0);
EXPORT InValid_title(SALT37.StrType s) := InValidFT_invalid_alphanumericpoundspacequote(s);
EXPORT InValidMessage_title(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumericpoundspacequote(wh);
 
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
 
EXPORT Make_business_ind(SALT37.StrType s0) := MakeFT_invalid_business_ind(s0);
EXPORT InValid_business_ind(SALT37.StrType s) := InValidFT_invalid_business_ind(s);
EXPORT InValidMessage_business_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_business_ind(wh);
 
EXPORT Make_county_cd(SALT37.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_county_cd(SALT37.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_county_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_msa(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_msa(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_msa(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_nielsen_county_cd(SALT37.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_nielsen_county_cd(SALT37.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_nielsen_county_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_number_of_lawyers_range(SALT37.StrType s0) := MakeFT_invalid_number_of_lawyers_range(s0);
EXPORT InValid_number_of_lawyers_range(SALT37.StrType s) := InValidFT_invalid_number_of_lawyers_range(s);
EXPORT InValidMessage_number_of_lawyers_range(UNSIGNED1 wh) := InValidMessageFT_invalid_number_of_lawyers_range(wh);
 
EXPORT Make_practice_area(SALT37.StrType s0) := MakeFT_invalid_alphanumericpound(s0);
EXPORT InValid_practice_area(SALT37.StrType s) := InValidFT_invalid_alphanumericpound(s);
EXPORT InValidMessage_practice_area(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumericpound(wh);
 
EXPORT Make_title_cd(SALT37.StrType s0) := MakeFT_invalid_numericpound(s0);
EXPORT InValid_title_cd(SALT37.StrType s) := InValidFT_invalid_numericpound(s);
EXPORT InValidMessage_title_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_numericpound(wh);
 
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
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT37,Scrubs_ALC_LAWYERS;
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
    BOOLEAN Diff_business_ind;
    BOOLEAN Diff_county_cd;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_nielsen_county_cd;
    BOOLEAN Diff_number_of_lawyers_range;
    BOOLEAN Diff_practice_area;
    BOOLEAN Diff_title_cd;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_list_id;
    BOOLEAN Diff_scno;
    BOOLEAN Diff_keycode;
    BOOLEAN Diff_custno;
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
    SELF.Diff_business_ind := le.business_ind <> ri.business_ind;
    SELF.Diff_county_cd := le.county_cd <> ri.county_cd;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_nielsen_county_cd := le.nielsen_county_cd <> ri.nielsen_county_cd;
    SELF.Diff_number_of_lawyers_range := le.number_of_lawyers_range <> ri.number_of_lawyers_range;
    SELF.Diff_practice_area := le.practice_area <> ri.practice_area;
    SELF.Diff_title_cd := le.title_cd <> ri.title_cd;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_list_id := le.list_id <> ri.list_id;
    SELF.Diff_scno := le.scno <> ri.scno;
    SELF.Diff_keycode := le.keycode <> ri.keycode;
    SELF.Diff_custno := le.custno <> ri.custno;
    SELF.Val := (SALT37.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_company,1,0)+ IF( SELF.Diff_address1,1,0)+ IF( SELF.Diff_address2,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_bar,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_country,1,0)+ IF( SELF.Diff_postal_cd,1,0)+ IF( SELF.Diff_dpv,1,0)+ IF( SELF.Diff_addr_type,1,0)+ IF( SELF.Diff_business_ind,1,0)+ IF( SELF.Diff_county_cd,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_nielsen_county_cd,1,0)+ IF( SELF.Diff_number_of_lawyers_range,1,0)+ IF( SELF.Diff_practice_area,1,0)+ IF( SELF.Diff_title_cd,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_list_id,1,0)+ IF( SELF.Diff_scno,1,0)+ IF( SELF.Diff_keycode,1,0)+ IF( SELF.Diff_custno,1,0);
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
    Count_Diff_business_ind := COUNT(GROUP,%Closest%.Diff_business_ind);
    Count_Diff_county_cd := COUNT(GROUP,%Closest%.Diff_county_cd);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_nielsen_county_cd := COUNT(GROUP,%Closest%.Diff_nielsen_county_cd);
    Count_Diff_number_of_lawyers_range := COUNT(GROUP,%Closest%.Diff_number_of_lawyers_range);
    Count_Diff_practice_area := COUNT(GROUP,%Closest%.Diff_practice_area);
    Count_Diff_title_cd := COUNT(GROUP,%Closest%.Diff_title_cd);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_list_id := COUNT(GROUP,%Closest%.Diff_list_id);
    Count_Diff_scno := COUNT(GROUP,%Closest%.Diff_scno);
    Count_Diff_keycode := COUNT(GROUP,%Closest%.Diff_keycode);
    Count_Diff_custno := COUNT(GROUP,%Closest%.Diff_custno);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
