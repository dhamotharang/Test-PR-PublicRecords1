IMPORT SALT311;
IMPORT Scrubs_Spoke,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_Fields := MODULE
 
EXPORT NumFields := 12;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_first_name','invalid_last_name','invalid_company_name','invalid_validation_date','invalid_owner_name','invalid_company_state','invalid_postal_code','invalid_phone_number','invalid_annual_revenue');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_first_name' => 1,'invalid_last_name' => 2,'invalid_company_name' => 3,'invalid_validation_date' => 4,'invalid_owner_name' => 5,'invalid_company_state' => 6,'invalid_postal_code' => 7,'invalid_phone_number' => 8,'invalid_annual_revenue' => 9,0);
 
EXPORT MakeFT_invalid_first_name(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_first_name(SALT311.StrType s) := WHICH(~Scrubs_Spoke.Functions.fn_valid_name(s)>0);
EXPORT InValidMessageFT_invalid_first_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Spoke.Functions.fn_valid_name'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_last_name(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_last_name(SALT311.StrType s) := WHICH(~Scrubs_Spoke.Functions.fn_valid_name(s)>0);
EXPORT InValidMessageFT_invalid_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Spoke.Functions.fn_valid_name'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_company_name(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_company_name(SALT311.StrType s) := WHICH(~Scrubs_Spoke.Functions.fn_valid_name(s)>0);
EXPORT InValidMessageFT_invalid_company_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Spoke.Functions.fn_valid_name'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_validation_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_validation_date(SALT311.StrType s) := WHICH(~Scrubs_Spoke.Functions.fn_valid_Date(s)>0);
EXPORT InValidMessageFT_invalid_validation_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Spoke.Functions.fn_valid_Date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_owner_name(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_owner_name(SALT311.StrType s) := WHICH(~Scrubs_Spoke.Functions.fn_valid_name(s)>0);
EXPORT InValidMessageFT_invalid_owner_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Spoke.Functions.fn_valid_name'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_company_state(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_company_state(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_Valid_StateAbbrev(s)>0);
EXPORT InValidMessageFT_invalid_company_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_Valid_StateAbbrev'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_postal_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_postal_code(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_valid_zip(s)>0);
EXPORT InValidMessageFT_invalid_postal_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_valid_zip'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone_number(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phone_number(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_verify_optional_phone(s)>0);
EXPORT InValidMessageFT_invalid_phone_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_verify_optional_phone'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_annual_revenue(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_annual_revenue(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_annual_revenue(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'first_name','last_name','job_title','company_name','validation_date','company_street_address','company_city','company_state','company_postal_code','company_phone_number','company_annual_revenue','company_business_description');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'first_name','last_name','job_title','company_name','validation_date','company_street_address','company_city','company_state','company_postal_code','company_phone_number','company_annual_revenue','company_business_description');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'first_name' => 0,'last_name' => 1,'job_title' => 2,'company_name' => 3,'validation_date' => 4,'company_street_address' => 5,'company_city' => 6,'company_state' => 7,'company_postal_code' => 8,'company_phone_number' => 9,'company_annual_revenue' => 10,'company_business_description' => 11,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],[],['CUSTOM'],[],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_first_name(SALT311.StrType s0) := MakeFT_invalid_first_name(s0);
EXPORT InValid_first_name(SALT311.StrType s) := InValidFT_invalid_first_name(s);
EXPORT InValidMessage_first_name(UNSIGNED1 wh) := InValidMessageFT_invalid_first_name(wh);
 
EXPORT Make_last_name(SALT311.StrType s0) := MakeFT_invalid_last_name(s0);
EXPORT InValid_last_name(SALT311.StrType s) := InValidFT_invalid_last_name(s);
EXPORT InValidMessage_last_name(UNSIGNED1 wh) := InValidMessageFT_invalid_last_name(wh);
 
EXPORT Make_job_title(SALT311.StrType s0) := s0;
EXPORT InValid_job_title(SALT311.StrType s) := 0;
EXPORT InValidMessage_job_title(UNSIGNED1 wh) := '';
 
EXPORT Make_company_name(SALT311.StrType s0) := MakeFT_invalid_company_name(s0);
EXPORT InValid_company_name(SALT311.StrType s) := InValidFT_invalid_company_name(s);
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := InValidMessageFT_invalid_company_name(wh);
 
EXPORT Make_validation_date(SALT311.StrType s0) := s0;
EXPORT InValid_validation_date(SALT311.StrType s) := 0;
EXPORT InValidMessage_validation_date(UNSIGNED1 wh) := '';
 
EXPORT Make_company_street_address(SALT311.StrType s0) := s0;
EXPORT InValid_company_street_address(SALT311.StrType s) := 0;
EXPORT InValidMessage_company_street_address(UNSIGNED1 wh) := '';
 
EXPORT Make_company_city(SALT311.StrType s0) := s0;
EXPORT InValid_company_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_company_city(UNSIGNED1 wh) := '';
 
EXPORT Make_company_state(SALT311.StrType s0) := MakeFT_invalid_company_state(s0);
EXPORT InValid_company_state(SALT311.StrType s) := InValidFT_invalid_company_state(s);
EXPORT InValidMessage_company_state(UNSIGNED1 wh) := InValidMessageFT_invalid_company_state(wh);
 
EXPORT Make_company_postal_code(SALT311.StrType s0) := MakeFT_invalid_postal_code(s0);
EXPORT InValid_company_postal_code(SALT311.StrType s) := InValidFT_invalid_postal_code(s);
EXPORT InValidMessage_company_postal_code(UNSIGNED1 wh) := InValidMessageFT_invalid_postal_code(wh);
 
EXPORT Make_company_phone_number(SALT311.StrType s0) := MakeFT_invalid_phone_number(s0);
EXPORT InValid_company_phone_number(SALT311.StrType s) := InValidFT_invalid_phone_number(s);
EXPORT InValidMessage_company_phone_number(UNSIGNED1 wh) := InValidMessageFT_invalid_phone_number(wh);
 
EXPORT Make_company_annual_revenue(SALT311.StrType s0) := MakeFT_invalid_annual_revenue(s0);
EXPORT InValid_company_annual_revenue(SALT311.StrType s) := InValidFT_invalid_annual_revenue(s);
EXPORT InValidMessage_company_annual_revenue(UNSIGNED1 wh) := InValidMessageFT_invalid_annual_revenue(wh);
 
EXPORT Make_company_business_description(SALT311.StrType s0) := s0;
EXPORT InValid_company_business_description(SALT311.StrType s) := 0;
EXPORT InValidMessage_company_business_description(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Spoke;
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
    BOOLEAN Diff_first_name;
    BOOLEAN Diff_last_name;
    BOOLEAN Diff_job_title;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_validation_date;
    BOOLEAN Diff_company_street_address;
    BOOLEAN Diff_company_city;
    BOOLEAN Diff_company_state;
    BOOLEAN Diff_company_postal_code;
    BOOLEAN Diff_company_phone_number;
    BOOLEAN Diff_company_annual_revenue;
    BOOLEAN Diff_company_business_description;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_first_name := le.first_name <> ri.first_name;
    SELF.Diff_last_name := le.last_name <> ri.last_name;
    SELF.Diff_job_title := le.job_title <> ri.job_title;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_validation_date := le.validation_date <> ri.validation_date;
    SELF.Diff_company_street_address := le.company_street_address <> ri.company_street_address;
    SELF.Diff_company_city := le.company_city <> ri.company_city;
    SELF.Diff_company_state := le.company_state <> ri.company_state;
    SELF.Diff_company_postal_code := le.company_postal_code <> ri.company_postal_code;
    SELF.Diff_company_phone_number := le.company_phone_number <> ri.company_phone_number;
    SELF.Diff_company_annual_revenue := le.company_annual_revenue <> ri.company_annual_revenue;
    SELF.Diff_company_business_description := le.company_business_description <> ri.company_business_description;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_first_name,1,0)+ IF( SELF.Diff_last_name,1,0)+ IF( SELF.Diff_job_title,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_validation_date,1,0)+ IF( SELF.Diff_company_street_address,1,0)+ IF( SELF.Diff_company_city,1,0)+ IF( SELF.Diff_company_state,1,0)+ IF( SELF.Diff_company_postal_code,1,0)+ IF( SELF.Diff_company_phone_number,1,0)+ IF( SELF.Diff_company_annual_revenue,1,0)+ IF( SELF.Diff_company_business_description,1,0);
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
    Count_Diff_first_name := COUNT(GROUP,%Closest%.Diff_first_name);
    Count_Diff_last_name := COUNT(GROUP,%Closest%.Diff_last_name);
    Count_Diff_job_title := COUNT(GROUP,%Closest%.Diff_job_title);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_validation_date := COUNT(GROUP,%Closest%.Diff_validation_date);
    Count_Diff_company_street_address := COUNT(GROUP,%Closest%.Diff_company_street_address);
    Count_Diff_company_city := COUNT(GROUP,%Closest%.Diff_company_city);
    Count_Diff_company_state := COUNT(GROUP,%Closest%.Diff_company_state);
    Count_Diff_company_postal_code := COUNT(GROUP,%Closest%.Diff_company_postal_code);
    Count_Diff_company_phone_number := COUNT(GROUP,%Closest%.Diff_company_phone_number);
    Count_Diff_company_annual_revenue := COUNT(GROUP,%Closest%.Diff_company_annual_revenue);
    Count_Diff_company_business_description := COUNT(GROUP,%Closest%.Diff_company_business_description);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
