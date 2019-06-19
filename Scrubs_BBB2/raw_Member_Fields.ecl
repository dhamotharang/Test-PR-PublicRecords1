IMPORT SALT311;
IMPORT Scrubs_BBB2; // Import modules for FieldTypes attribute definitions
EXPORT raw_Member_Fields := MODULE
 
EXPORT NumFields := 15;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_bbb_id','invalid_chk_blanks','invalid_country','invalid_phone','invalid_phone_type','invalid_listing_year','invalid_http_link','invalid_member_attr_name1','invalid_member_attr1','invalid_member_attr_name2');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_bbb_id' => 1,'invalid_chk_blanks' => 2,'invalid_country' => 3,'invalid_phone' => 4,'invalid_phone_type' => 5,'invalid_listing_year' => 6,'invalid_http_link' => 7,'invalid_member_attr_name1' => 8,'invalid_member_attr1' => 9,'invalid_member_attr_name2' => 10,0);
 
EXPORT MakeFT_invalid_bbb_id(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_bbb_id(SALT311.StrType s) := WHICH(~Scrubs_BBB2.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_bbb_id(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BBB2.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_chk_blanks(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_chk_blanks(SALT311.StrType s) := WHICH(~Scrubs_BBB2.Functions.fn_chk_blanks(s)>0);
EXPORT InValidMessageFT_invalid_chk_blanks(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BBB2.Functions.fn_chk_blanks'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_country(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_country(SALT311.StrType s) := WHICH(~Scrubs_BBB2.Functions.fn_chk_country(s)>0);
EXPORT InValidMessageFT_invalid_country(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BBB2.Functions.fn_chk_country'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phone(SALT311.StrType s) := WHICH(~Scrubs_BBB2.functions.fn_verify_phone(s)>0);
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BBB2.functions.fn_verify_phone'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phone_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['main','MAIN','']);
EXPORT InValidMessageFT_invalid_phone_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('main|MAIN|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_listing_year(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_listing_year(SALT311.StrType s,SALT311.StrType listing_month,SALT311.StrType listing_day) := WHICH(~Scrubs_BBB2.Functions.fn_valid_general_yyyymmdd(s,listing_month,listing_day)>0);
EXPORT InValidMessageFT_invalid_listing_year(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BBB2.Functions.fn_valid_general_yyyymmdd'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_http_link(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_http_link(SALT311.StrType s) := WHICH(~Scrubs_BBB2.Functions.fn_url(s)>0);
EXPORT InValidMessageFT_invalid_http_link(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BBB2.Functions.fn_url'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_member_attr_name1(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_member_attr_name1(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['member since','MEMBER SINCE','']);
EXPORT InValidMessageFT_invalid_member_attr_name1(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('member since|MEMBER SINCE|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_member_attr1(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_member_attr1(SALT311.StrType s) := WHICH(~Scrubs_BBB2.Functions.fn_valid_past_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_member_attr1(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BBB2.Functions.fn_valid_past_yyyymmdd'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_member_attr_name2(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_member_attr_name2(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['category','CATEGORY','']);
EXPORT InValidMessageFT_invalid_member_attr_name2(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('category|CATEGORY|'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'bbb_id','company_name','address','country','phone','phone_type','listing_month','listing_day','listing_year','http_link','member_title','member_attr_name1','member_attr1','member_attr_name2','member_attr2');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'bbb_id','company_name','address','country','phone','phone_type','listing_month','listing_day','listing_year','http_link','member_title','member_attr_name1','member_attr1','member_attr_name2','member_attr2');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'bbb_id' => 0,'company_name' => 1,'address' => 2,'country' => 3,'phone' => 4,'phone_type' => 5,'listing_month' => 6,'listing_day' => 7,'listing_year' => 8,'http_link' => 9,'member_title' => 10,'member_attr_name1' => 11,'member_attr1' => 12,'member_attr_name2' => 13,'member_attr2' => 14,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ENUM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_bbb_id(SALT311.StrType s0) := MakeFT_invalid_bbb_id(s0);
EXPORT InValid_bbb_id(SALT311.StrType s) := InValidFT_invalid_bbb_id(s);
EXPORT InValidMessage_bbb_id(UNSIGNED1 wh) := InValidMessageFT_invalid_bbb_id(wh);
 
EXPORT Make_company_name(SALT311.StrType s0) := MakeFT_invalid_chk_blanks(s0);
EXPORT InValid_company_name(SALT311.StrType s) := InValidFT_invalid_chk_blanks(s);
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := InValidMessageFT_invalid_chk_blanks(wh);
 
EXPORT Make_address(SALT311.StrType s0) := MakeFT_invalid_chk_blanks(s0);
EXPORT InValid_address(SALT311.StrType s) := InValidFT_invalid_chk_blanks(s);
EXPORT InValidMessage_address(UNSIGNED1 wh) := InValidMessageFT_invalid_chk_blanks(wh);
 
EXPORT Make_country(SALT311.StrType s0) := MakeFT_invalid_country(s0);
EXPORT InValid_country(SALT311.StrType s) := InValidFT_invalid_country(s);
EXPORT InValidMessage_country(UNSIGNED1 wh) := InValidMessageFT_invalid_country(wh);
 
EXPORT Make_phone(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_phone(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_phone_type(SALT311.StrType s0) := MakeFT_invalid_phone_type(s0);
EXPORT InValid_phone_type(SALT311.StrType s) := InValidFT_invalid_phone_type(s);
EXPORT InValidMessage_phone_type(UNSIGNED1 wh) := InValidMessageFT_invalid_phone_type(wh);
 
EXPORT Make_listing_month(SALT311.StrType s0) := s0;
EXPORT InValid_listing_month(SALT311.StrType s) := 0;
EXPORT InValidMessage_listing_month(UNSIGNED1 wh) := '';
 
EXPORT Make_listing_day(SALT311.StrType s0) := s0;
EXPORT InValid_listing_day(SALT311.StrType s) := 0;
EXPORT InValidMessage_listing_day(UNSIGNED1 wh) := '';
 
EXPORT Make_listing_year(SALT311.StrType s0) := MakeFT_invalid_listing_year(s0);
EXPORT InValid_listing_year(SALT311.StrType s,SALT311.StrType listing_month,SALT311.StrType listing_day) := InValidFT_invalid_listing_year(s,listing_month,listing_day);
EXPORT InValidMessage_listing_year(UNSIGNED1 wh) := InValidMessageFT_invalid_listing_year(wh);
 
EXPORT Make_http_link(SALT311.StrType s0) := MakeFT_invalid_http_link(s0);
EXPORT InValid_http_link(SALT311.StrType s) := InValidFT_invalid_http_link(s);
EXPORT InValidMessage_http_link(UNSIGNED1 wh) := InValidMessageFT_invalid_http_link(wh);
 
EXPORT Make_member_title(SALT311.StrType s0) := MakeFT_invalid_chk_blanks(s0);
EXPORT InValid_member_title(SALT311.StrType s) := InValidFT_invalid_chk_blanks(s);
EXPORT InValidMessage_member_title(UNSIGNED1 wh) := InValidMessageFT_invalid_chk_blanks(wh);
 
EXPORT Make_member_attr_name1(SALT311.StrType s0) := MakeFT_invalid_member_attr_name1(s0);
EXPORT InValid_member_attr_name1(SALT311.StrType s) := InValidFT_invalid_member_attr_name1(s);
EXPORT InValidMessage_member_attr_name1(UNSIGNED1 wh) := InValidMessageFT_invalid_member_attr_name1(wh);
 
EXPORT Make_member_attr1(SALT311.StrType s0) := MakeFT_invalid_member_attr1(s0);
EXPORT InValid_member_attr1(SALT311.StrType s) := InValidFT_invalid_member_attr1(s);
EXPORT InValidMessage_member_attr1(UNSIGNED1 wh) := InValidMessageFT_invalid_member_attr1(wh);
 
EXPORT Make_member_attr_name2(SALT311.StrType s0) := MakeFT_invalid_member_attr_name2(s0);
EXPORT InValid_member_attr_name2(SALT311.StrType s) := InValidFT_invalid_member_attr_name2(s);
EXPORT InValidMessage_member_attr_name2(UNSIGNED1 wh) := InValidMessageFT_invalid_member_attr_name2(wh);
 
EXPORT Make_member_attr2(SALT311.StrType s0) := MakeFT_invalid_chk_blanks(s0);
EXPORT InValid_member_attr2(SALT311.StrType s) := InValidFT_invalid_chk_blanks(s);
EXPORT InValidMessage_member_attr2(UNSIGNED1 wh) := InValidMessageFT_invalid_chk_blanks(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_BBB2;
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
    BOOLEAN Diff_bbb_id;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_address;
    BOOLEAN Diff_country;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_phone_type;
    BOOLEAN Diff_listing_month;
    BOOLEAN Diff_listing_day;
    BOOLEAN Diff_listing_year;
    BOOLEAN Diff_http_link;
    BOOLEAN Diff_member_title;
    BOOLEAN Diff_member_attr_name1;
    BOOLEAN Diff_member_attr1;
    BOOLEAN Diff_member_attr_name2;
    BOOLEAN Diff_member_attr2;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_bbb_id := le.bbb_id <> ri.bbb_id;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_address := le.address <> ri.address;
    SELF.Diff_country := le.country <> ri.country;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_phone_type := le.phone_type <> ri.phone_type;
    SELF.Diff_listing_month := le.listing_month <> ri.listing_month;
    SELF.Diff_listing_day := le.listing_day <> ri.listing_day;
    SELF.Diff_listing_year := le.listing_year <> ri.listing_year;
    SELF.Diff_http_link := le.http_link <> ri.http_link;
    SELF.Diff_member_title := le.member_title <> ri.member_title;
    SELF.Diff_member_attr_name1 := le.member_attr_name1 <> ri.member_attr_name1;
    SELF.Diff_member_attr1 := le.member_attr1 <> ri.member_attr1;
    SELF.Diff_member_attr_name2 := le.member_attr_name2 <> ri.member_attr_name2;
    SELF.Diff_member_attr2 := le.member_attr2 <> ri.member_attr2;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_bbb_id,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_address,1,0)+ IF( SELF.Diff_country,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_phone_type,1,0)+ IF( SELF.Diff_listing_month,1,0)+ IF( SELF.Diff_listing_day,1,0)+ IF( SELF.Diff_listing_year,1,0)+ IF( SELF.Diff_http_link,1,0)+ IF( SELF.Diff_member_title,1,0)+ IF( SELF.Diff_member_attr_name1,1,0)+ IF( SELF.Diff_member_attr1,1,0)+ IF( SELF.Diff_member_attr_name2,1,0)+ IF( SELF.Diff_member_attr2,1,0);
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
    Count_Diff_bbb_id := COUNT(GROUP,%Closest%.Diff_bbb_id);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_address := COUNT(GROUP,%Closest%.Diff_address);
    Count_Diff_country := COUNT(GROUP,%Closest%.Diff_country);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_phone_type := COUNT(GROUP,%Closest%.Diff_phone_type);
    Count_Diff_listing_month := COUNT(GROUP,%Closest%.Diff_listing_month);
    Count_Diff_listing_day := COUNT(GROUP,%Closest%.Diff_listing_day);
    Count_Diff_listing_year := COUNT(GROUP,%Closest%.Diff_listing_year);
    Count_Diff_http_link := COUNT(GROUP,%Closest%.Diff_http_link);
    Count_Diff_member_title := COUNT(GROUP,%Closest%.Diff_member_title);
    Count_Diff_member_attr_name1 := COUNT(GROUP,%Closest%.Diff_member_attr_name1);
    Count_Diff_member_attr1 := COUNT(GROUP,%Closest%.Diff_member_attr1);
    Count_Diff_member_attr_name2 := COUNT(GROUP,%Closest%.Diff_member_attr_name2);
    Count_Diff_member_attr2 := COUNT(GROUP,%Closest%.Diff_member_attr2);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
