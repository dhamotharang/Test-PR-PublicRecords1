IMPORT SALT311;
IMPORT Scrubs_Calbus; // Import modules for FieldTypes attribute definitions
EXPORT raw_Fields := MODULE
 
EXPORT NumFields := 15;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_district','invalid_numeric','invalid_account_type','invalid_mandatory','invalid_state','invalid_zip_5','invalid_zip_plus_4','invalid_country_name','invalid_start_date','invalid_ownership_code');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_district' => 1,'invalid_numeric' => 2,'invalid_account_type' => 3,'invalid_mandatory' => 4,'invalid_state' => 5,'invalid_zip_5' => 6,'invalid_zip_plus_4' => 7,'invalid_country_name' => 8,'invalid_start_date' => 9,'invalid_ownership_code' => 10,0);
 
EXPORT MakeFT_invalid_district(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_district(SALT311.StrType s) := WHICH(~Scrubs_Calbus.Functions.fn_district_code(s)>0);
EXPORT InValidMessageFT_invalid_district(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Calbus.Functions.fn_district_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(~Scrubs_Calbus.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Calbus.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_account_type(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'SUT|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_account_type(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'SUT|'))));
EXPORT InValidMessageFT_invalid_account_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('SUT|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mandatory(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT311.StrType s) := WHICH(~Scrubs_Calbus.Functions.fn_chk_blanks(s)>0);
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Calbus.Functions.fn_chk_blanks'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state(SALT311.StrType s) := WHICH(~Scrubs_Calbus.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Calbus.Functions.fn_verify_state'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip_5(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip_5(SALT311.StrType s) := WHICH(~Scrubs_Calbus.Functions.fn_verify_zip5(s)>0);
EXPORT InValidMessageFT_invalid_zip_5(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Calbus.Functions.fn_verify_zip5'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip_plus_4(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip_plus_4(SALT311.StrType s) := WHICH(~Scrubs_Calbus.Functions.fn_verify_zip4(s)>0);
EXPORT InValidMessageFT_invalid_zip_plus_4(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Calbus.Functions.fn_verify_zip4'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_country_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'USA|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_country_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'USA|'))));
EXPORT InValidMessageFT_invalid_country_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('USA|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_start_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_start_date(SALT311.StrType s) := WHICH(~Scrubs_Calbus.Functions.fn_general_date(s)>0);
EXPORT InValidMessageFT_invalid_start_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Calbus.Functions.fn_general_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ownership_code(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'B|C|D|E|F|G|K|L|O|P|R|S|T|V|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_ownership_code(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'B|C|D|E|F|G|K|L|O|P|R|S|T|V|'))));
EXPORT InValidMessageFT_invalid_ownership_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('B|C|D|E|F|G|K|L|O|P|R|S|T|V|'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'district_branch','account_number','sub_account_number','district','account_type','firm_name','owner_name','business_street','business_city','business_state','business_zip_5','business_zip_plus_4','business_country_name','start_date','ownership_code');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'district_branch','account_number','sub_account_number','district','account_type','firm_name','owner_name','business_street','business_city','business_state','business_zip_5','business_zip_plus_4','business_country_name','start_date','ownership_code');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'district_branch' => 0,'account_number' => 1,'sub_account_number' => 2,'district' => 3,'account_type' => 4,'firm_name' => 5,'owner_name' => 6,'business_street' => 7,'business_city' => 8,'business_state' => 9,'business_zip_5' => 10,'business_zip_plus_4' => 11,'business_country_name' => 12,'start_date' => 13,'ownership_code' => 14,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_district_branch(SALT311.StrType s0) := MakeFT_invalid_district(s0);
EXPORT InValid_district_branch(SALT311.StrType s) := InValidFT_invalid_district(s);
EXPORT InValidMessage_district_branch(UNSIGNED1 wh) := InValidMessageFT_invalid_district(wh);
 
EXPORT Make_account_number(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_account_number(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_account_number(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_sub_account_number(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_sub_account_number(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_sub_account_number(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_district(SALT311.StrType s0) := MakeFT_invalid_district(s0);
EXPORT InValid_district(SALT311.StrType s) := InValidFT_invalid_district(s);
EXPORT InValidMessage_district(UNSIGNED1 wh) := InValidMessageFT_invalid_district(wh);
 
EXPORT Make_account_type(SALT311.StrType s0) := MakeFT_invalid_account_type(s0);
EXPORT InValid_account_type(SALT311.StrType s) := InValidFT_invalid_account_type(s);
EXPORT InValidMessage_account_type(UNSIGNED1 wh) := InValidMessageFT_invalid_account_type(wh);
 
EXPORT Make_firm_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_firm_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_firm_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_owner_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_owner_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_owner_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_business_street(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_business_street(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_business_street(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_business_city(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_business_city(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_business_city(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_business_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_business_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_business_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_business_zip_5(SALT311.StrType s0) := MakeFT_invalid_zip_5(s0);
EXPORT InValid_business_zip_5(SALT311.StrType s) := InValidFT_invalid_zip_5(s);
EXPORT InValidMessage_business_zip_5(UNSIGNED1 wh) := InValidMessageFT_invalid_zip_5(wh);
 
EXPORT Make_business_zip_plus_4(SALT311.StrType s0) := MakeFT_invalid_zip_plus_4(s0);
EXPORT InValid_business_zip_plus_4(SALT311.StrType s) := InValidFT_invalid_zip_plus_4(s);
EXPORT InValidMessage_business_zip_plus_4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip_plus_4(wh);
 
EXPORT Make_business_country_name(SALT311.StrType s0) := MakeFT_invalid_country_name(s0);
EXPORT InValid_business_country_name(SALT311.StrType s) := InValidFT_invalid_country_name(s);
EXPORT InValidMessage_business_country_name(UNSIGNED1 wh) := InValidMessageFT_invalid_country_name(wh);
 
EXPORT Make_start_date(SALT311.StrType s0) := MakeFT_invalid_start_date(s0);
EXPORT InValid_start_date(SALT311.StrType s) := InValidFT_invalid_start_date(s);
EXPORT InValidMessage_start_date(UNSIGNED1 wh) := InValidMessageFT_invalid_start_date(wh);
 
EXPORT Make_ownership_code(SALT311.StrType s0) := MakeFT_invalid_ownership_code(s0);
EXPORT InValid_ownership_code(SALT311.StrType s) := InValidFT_invalid_ownership_code(s);
EXPORT InValidMessage_ownership_code(UNSIGNED1 wh) := InValidMessageFT_invalid_ownership_code(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Calbus;
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
    BOOLEAN Diff_district_branch;
    BOOLEAN Diff_account_number;
    BOOLEAN Diff_sub_account_number;
    BOOLEAN Diff_district;
    BOOLEAN Diff_account_type;
    BOOLEAN Diff_firm_name;
    BOOLEAN Diff_owner_name;
    BOOLEAN Diff_business_street;
    BOOLEAN Diff_business_city;
    BOOLEAN Diff_business_state;
    BOOLEAN Diff_business_zip_5;
    BOOLEAN Diff_business_zip_plus_4;
    BOOLEAN Diff_business_country_name;
    BOOLEAN Diff_start_date;
    BOOLEAN Diff_ownership_code;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_district_branch := le.district_branch <> ri.district_branch;
    SELF.Diff_account_number := le.account_number <> ri.account_number;
    SELF.Diff_sub_account_number := le.sub_account_number <> ri.sub_account_number;
    SELF.Diff_district := le.district <> ri.district;
    SELF.Diff_account_type := le.account_type <> ri.account_type;
    SELF.Diff_firm_name := le.firm_name <> ri.firm_name;
    SELF.Diff_owner_name := le.owner_name <> ri.owner_name;
    SELF.Diff_business_street := le.business_street <> ri.business_street;
    SELF.Diff_business_city := le.business_city <> ri.business_city;
    SELF.Diff_business_state := le.business_state <> ri.business_state;
    SELF.Diff_business_zip_5 := le.business_zip_5 <> ri.business_zip_5;
    SELF.Diff_business_zip_plus_4 := le.business_zip_plus_4 <> ri.business_zip_plus_4;
    SELF.Diff_business_country_name := le.business_country_name <> ri.business_country_name;
    SELF.Diff_start_date := le.start_date <> ri.start_date;
    SELF.Diff_ownership_code := le.ownership_code <> ri.ownership_code;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_district_branch,1,0)+ IF( SELF.Diff_account_number,1,0)+ IF( SELF.Diff_sub_account_number,1,0)+ IF( SELF.Diff_district,1,0)+ IF( SELF.Diff_account_type,1,0)+ IF( SELF.Diff_firm_name,1,0)+ IF( SELF.Diff_owner_name,1,0)+ IF( SELF.Diff_business_street,1,0)+ IF( SELF.Diff_business_city,1,0)+ IF( SELF.Diff_business_state,1,0)+ IF( SELF.Diff_business_zip_5,1,0)+ IF( SELF.Diff_business_zip_plus_4,1,0)+ IF( SELF.Diff_business_country_name,1,0)+ IF( SELF.Diff_start_date,1,0)+ IF( SELF.Diff_ownership_code,1,0);
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
    Count_Diff_district_branch := COUNT(GROUP,%Closest%.Diff_district_branch);
    Count_Diff_account_number := COUNT(GROUP,%Closest%.Diff_account_number);
    Count_Diff_sub_account_number := COUNT(GROUP,%Closest%.Diff_sub_account_number);
    Count_Diff_district := COUNT(GROUP,%Closest%.Diff_district);
    Count_Diff_account_type := COUNT(GROUP,%Closest%.Diff_account_type);
    Count_Diff_firm_name := COUNT(GROUP,%Closest%.Diff_firm_name);
    Count_Diff_owner_name := COUNT(GROUP,%Closest%.Diff_owner_name);
    Count_Diff_business_street := COUNT(GROUP,%Closest%.Diff_business_street);
    Count_Diff_business_city := COUNT(GROUP,%Closest%.Diff_business_city);
    Count_Diff_business_state := COUNT(GROUP,%Closest%.Diff_business_state);
    Count_Diff_business_zip_5 := COUNT(GROUP,%Closest%.Diff_business_zip_5);
    Count_Diff_business_zip_plus_4 := COUNT(GROUP,%Closest%.Diff_business_zip_plus_4);
    Count_Diff_business_country_name := COUNT(GROUP,%Closest%.Diff_business_country_name);
    Count_Diff_start_date := COUNT(GROUP,%Closest%.Diff_start_date);
    Count_Diff_ownership_code := COUNT(GROUP,%Closest%.Diff_ownership_code);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
