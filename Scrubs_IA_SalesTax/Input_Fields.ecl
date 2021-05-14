IMPORT SALT311;
IMPORT Scrubs,Scrubs_IA_SalesTax; // Import modules for FieldTypes attribute definitions
EXPORT Input_Fields := MODULE
 
EXPORT NumFields := 12;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_permit_nbr','invalid_issue_date','invalid_owner_name','invalid_business_name','invalid_state','invalid_zip');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_permit_nbr' => 1,'invalid_issue_date' => 2,'invalid_owner_name' => 3,'invalid_business_name' => 4,'invalid_state' => 5,'invalid_zip' => 6,0);
 
EXPORT MakeFT_invalid_permit_nbr(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_permit_nbr(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_numeric(s,9)>0);
EXPORT InValidMessageFT_invalid_permit_nbr(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_issue_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_issue_date(SALT311.StrType s) := WHICH(~Scrubs_IA_SalesTax.Functions.fn_valid_Date(s)>0);
EXPORT InValidMessageFT_invalid_issue_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IA_SalesTax.Functions.fn_valid_Date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_owner_name(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_owner_name(SALT311.StrType s) := WHICH(~Scrubs_IA_SalesTax.Functions.fn_valid_name(s)>0);
EXPORT InValidMessageFT_invalid_owner_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IA_SalesTax.Functions.fn_valid_name'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_business_name(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_business_name(SALT311.StrType s) := WHICH(~Scrubs_IA_SalesTax.Functions.fn_valid_name(s)>0);
EXPORT InValidMessageFT_invalid_business_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IA_SalesTax.Functions.fn_valid_name'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_verify_state'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_verify_zip59(s)>0);
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_verify_zip59'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'permit_nbr','issue_date','owner_name','business_name','city_mailing_address','mailing_address','state_mailing_address','mailing_zip_code','location_address','city_of_location','state_of_location','location_zip_code');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'permit_nbr','issue_date','owner_name','business_name','city_mailing_address','mailing_address','state_mailing_address','mailing_zip_code','location_address','city_of_location','state_of_location','location_zip_code');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'permit_nbr' => 0,'issue_date' => 1,'owner_name' => 2,'business_name' => 3,'city_mailing_address' => 4,'mailing_address' => 5,'state_mailing_address' => 6,'mailing_zip_code' => 7,'location_address' => 8,'city_of_location' => 9,'state_of_location' => 10,'location_zip_code' => 11,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],['CUSTOM'],['CUSTOM'],[],[],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_permit_nbr(SALT311.StrType s0) := MakeFT_invalid_permit_nbr(s0);
EXPORT InValid_permit_nbr(SALT311.StrType s) := InValidFT_invalid_permit_nbr(s);
EXPORT InValidMessage_permit_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_permit_nbr(wh);
 
EXPORT Make_issue_date(SALT311.StrType s0) := MakeFT_invalid_issue_date(s0);
EXPORT InValid_issue_date(SALT311.StrType s) := InValidFT_invalid_issue_date(s);
EXPORT InValidMessage_issue_date(UNSIGNED1 wh) := InValidMessageFT_invalid_issue_date(wh);
 
EXPORT Make_owner_name(SALT311.StrType s0) := MakeFT_invalid_owner_name(s0);
EXPORT InValid_owner_name(SALT311.StrType s) := InValidFT_invalid_owner_name(s);
EXPORT InValidMessage_owner_name(UNSIGNED1 wh) := InValidMessageFT_invalid_owner_name(wh);
 
EXPORT Make_business_name(SALT311.StrType s0) := MakeFT_invalid_business_name(s0);
EXPORT InValid_business_name(SALT311.StrType s) := InValidFT_invalid_business_name(s);
EXPORT InValidMessage_business_name(UNSIGNED1 wh) := InValidMessageFT_invalid_business_name(wh);
 
EXPORT Make_city_mailing_address(SALT311.StrType s0) := s0;
EXPORT InValid_city_mailing_address(SALT311.StrType s) := 0;
EXPORT InValidMessage_city_mailing_address(UNSIGNED1 wh) := '';
 
EXPORT Make_mailing_address(SALT311.StrType s0) := s0;
EXPORT InValid_mailing_address(SALT311.StrType s) := 0;
EXPORT InValidMessage_mailing_address(UNSIGNED1 wh) := '';
 
EXPORT Make_state_mailing_address(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state_mailing_address(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state_mailing_address(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_mailing_zip_code(SALT311.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_mailing_zip_code(SALT311.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_mailing_zip_code(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_location_address(SALT311.StrType s0) := s0;
EXPORT InValid_location_address(SALT311.StrType s) := 0;
EXPORT InValidMessage_location_address(UNSIGNED1 wh) := '';
 
EXPORT Make_city_of_location(SALT311.StrType s0) := s0;
EXPORT InValid_city_of_location(SALT311.StrType s) := 0;
EXPORT InValidMessage_city_of_location(UNSIGNED1 wh) := '';
 
EXPORT Make_state_of_location(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state_of_location(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state_of_location(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_location_zip_code(SALT311.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_location_zip_code(SALT311.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_location_zip_code(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_IA_SalesTax;
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
    BOOLEAN Diff_permit_nbr;
    BOOLEAN Diff_issue_date;
    BOOLEAN Diff_owner_name;
    BOOLEAN Diff_business_name;
    BOOLEAN Diff_city_mailing_address;
    BOOLEAN Diff_mailing_address;
    BOOLEAN Diff_state_mailing_address;
    BOOLEAN Diff_mailing_zip_code;
    BOOLEAN Diff_location_address;
    BOOLEAN Diff_city_of_location;
    BOOLEAN Diff_state_of_location;
    BOOLEAN Diff_location_zip_code;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_permit_nbr := le.permit_nbr <> ri.permit_nbr;
    SELF.Diff_issue_date := le.issue_date <> ri.issue_date;
    SELF.Diff_owner_name := le.owner_name <> ri.owner_name;
    SELF.Diff_business_name := le.business_name <> ri.business_name;
    SELF.Diff_city_mailing_address := le.city_mailing_address <> ri.city_mailing_address;
    SELF.Diff_mailing_address := le.mailing_address <> ri.mailing_address;
    SELF.Diff_state_mailing_address := le.state_mailing_address <> ri.state_mailing_address;
    SELF.Diff_mailing_zip_code := le.mailing_zip_code <> ri.mailing_zip_code;
    SELF.Diff_location_address := le.location_address <> ri.location_address;
    SELF.Diff_city_of_location := le.city_of_location <> ri.city_of_location;
    SELF.Diff_state_of_location := le.state_of_location <> ri.state_of_location;
    SELF.Diff_location_zip_code := le.location_zip_code <> ri.location_zip_code;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_permit_nbr,1,0)+ IF( SELF.Diff_issue_date,1,0)+ IF( SELF.Diff_owner_name,1,0)+ IF( SELF.Diff_business_name,1,0)+ IF( SELF.Diff_city_mailing_address,1,0)+ IF( SELF.Diff_mailing_address,1,0)+ IF( SELF.Diff_state_mailing_address,1,0)+ IF( SELF.Diff_mailing_zip_code,1,0)+ IF( SELF.Diff_location_address,1,0)+ IF( SELF.Diff_city_of_location,1,0)+ IF( SELF.Diff_state_of_location,1,0)+ IF( SELF.Diff_location_zip_code,1,0);
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
    Count_Diff_permit_nbr := COUNT(GROUP,%Closest%.Diff_permit_nbr);
    Count_Diff_issue_date := COUNT(GROUP,%Closest%.Diff_issue_date);
    Count_Diff_owner_name := COUNT(GROUP,%Closest%.Diff_owner_name);
    Count_Diff_business_name := COUNT(GROUP,%Closest%.Diff_business_name);
    Count_Diff_city_mailing_address := COUNT(GROUP,%Closest%.Diff_city_mailing_address);
    Count_Diff_mailing_address := COUNT(GROUP,%Closest%.Diff_mailing_address);
    Count_Diff_state_mailing_address := COUNT(GROUP,%Closest%.Diff_state_mailing_address);
    Count_Diff_mailing_zip_code := COUNT(GROUP,%Closest%.Diff_mailing_zip_code);
    Count_Diff_location_address := COUNT(GROUP,%Closest%.Diff_location_address);
    Count_Diff_city_of_location := COUNT(GROUP,%Closest%.Diff_city_of_location);
    Count_Diff_state_of_location := COUNT(GROUP,%Closest%.Diff_state_of_location);
    Count_Diff_location_zip_code := COUNT(GROUP,%Closest%.Diff_location_zip_code);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
