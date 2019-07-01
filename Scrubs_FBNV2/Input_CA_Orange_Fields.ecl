IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_CA_Orange_Fields := MODULE
 
EXPORT NumFields := 13;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_phone','invalid_past_date');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_phone' => 2,'invalid_past_date' => 3,0);
 
EXPORT MakeFT_invalid_mandatory(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phone(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_verify_optional_phone(s)>0);
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_verify_optional_phone'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_past_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_past_date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_pastDate(s)>0);
EXPORT InValidMessageFT_invalid_past_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'REGIS_NBR','BUSINESS_NAME','PHONE_NBR','FILE_DATE','FIRST_NAME','MIDDLE_NAME','LAST_NAME_COMPANY','OWNER_ADDRESS','prep_bus_addr_line1','prep_bus_addr_line_last','prep_owner_addr_line1','prep_owner_addr_line_last','cname');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'REGIS_NBR','BUSINESS_NAME','PHONE_NBR','FILE_DATE','FIRST_NAME','MIDDLE_NAME','LAST_NAME_COMPANY','OWNER_ADDRESS','prep_bus_addr_line1','prep_bus_addr_line_last','prep_owner_addr_line1','prep_owner_addr_line_last','cname');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'REGIS_NBR' => 0,'BUSINESS_NAME' => 1,'PHONE_NBR' => 2,'FILE_DATE' => 3,'FIRST_NAME' => 4,'MIDDLE_NAME' => 5,'LAST_NAME_COMPANY' => 6,'OWNER_ADDRESS' => 7,'prep_bus_addr_line1' => 8,'prep_bus_addr_line_last' => 9,'prep_owner_addr_line1' => 10,'prep_owner_addr_line_last' => 11,'cname' => 12,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['LENGTHS'],['LENGTHS'],['CUSTOM'],['CUSTOM'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_REGIS_NBR(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_REGIS_NBR(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_REGIS_NBR(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_BUSINESS_NAME(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_BUSINESS_NAME(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_BUSINESS_NAME(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_PHONE_NBR(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_PHONE_NBR(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_PHONE_NBR(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_FILE_DATE(SALT311.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_FILE_DATE(SALT311.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_FILE_DATE(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_FIRST_NAME(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_FIRST_NAME(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_FIRST_NAME(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_MIDDLE_NAME(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_MIDDLE_NAME(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_MIDDLE_NAME(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_LAST_NAME_COMPANY(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_LAST_NAME_COMPANY(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_LAST_NAME_COMPANY(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_OWNER_ADDRESS(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_OWNER_ADDRESS(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_OWNER_ADDRESS(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_bus_addr_line1(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_bus_addr_line1(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_bus_addr_line1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_bus_addr_line_last(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_bus_addr_line_last(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_bus_addr_line_last(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_owner_addr_line1(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_owner_addr_line1(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_owner_addr_line1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_owner_addr_line_last(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_owner_addr_line_last(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_owner_addr_line_last(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_cname(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_cname(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_cname(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_FBNV2;
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
    BOOLEAN Diff_REGIS_NBR;
    BOOLEAN Diff_BUSINESS_NAME;
    BOOLEAN Diff_PHONE_NBR;
    BOOLEAN Diff_FILE_DATE;
    BOOLEAN Diff_FIRST_NAME;
    BOOLEAN Diff_MIDDLE_NAME;
    BOOLEAN Diff_LAST_NAME_COMPANY;
    BOOLEAN Diff_OWNER_ADDRESS;
    BOOLEAN Diff_prep_bus_addr_line1;
    BOOLEAN Diff_prep_bus_addr_line_last;
    BOOLEAN Diff_prep_owner_addr_line1;
    BOOLEAN Diff_prep_owner_addr_line_last;
    BOOLEAN Diff_cname;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_REGIS_NBR := le.REGIS_NBR <> ri.REGIS_NBR;
    SELF.Diff_BUSINESS_NAME := le.BUSINESS_NAME <> ri.BUSINESS_NAME;
    SELF.Diff_PHONE_NBR := le.PHONE_NBR <> ri.PHONE_NBR;
    SELF.Diff_FILE_DATE := le.FILE_DATE <> ri.FILE_DATE;
    SELF.Diff_FIRST_NAME := le.FIRST_NAME <> ri.FIRST_NAME;
    SELF.Diff_MIDDLE_NAME := le.MIDDLE_NAME <> ri.MIDDLE_NAME;
    SELF.Diff_LAST_NAME_COMPANY := le.LAST_NAME_COMPANY <> ri.LAST_NAME_COMPANY;
    SELF.Diff_OWNER_ADDRESS := le.OWNER_ADDRESS <> ri.OWNER_ADDRESS;
    SELF.Diff_prep_bus_addr_line1 := le.prep_bus_addr_line1 <> ri.prep_bus_addr_line1;
    SELF.Diff_prep_bus_addr_line_last := le.prep_bus_addr_line_last <> ri.prep_bus_addr_line_last;
    SELF.Diff_prep_owner_addr_line1 := le.prep_owner_addr_line1 <> ri.prep_owner_addr_line1;
    SELF.Diff_prep_owner_addr_line_last := le.prep_owner_addr_line_last <> ri.prep_owner_addr_line_last;
    SELF.Diff_cname := le.cname <> ri.cname;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_REGIS_NBR,1,0)+ IF( SELF.Diff_BUSINESS_NAME,1,0)+ IF( SELF.Diff_PHONE_NBR,1,0)+ IF( SELF.Diff_FILE_DATE,1,0)+ IF( SELF.Diff_FIRST_NAME,1,0)+ IF( SELF.Diff_MIDDLE_NAME,1,0)+ IF( SELF.Diff_LAST_NAME_COMPANY,1,0)+ IF( SELF.Diff_OWNER_ADDRESS,1,0)+ IF( SELF.Diff_prep_bus_addr_line1,1,0)+ IF( SELF.Diff_prep_bus_addr_line_last,1,0)+ IF( SELF.Diff_prep_owner_addr_line1,1,0)+ IF( SELF.Diff_prep_owner_addr_line_last,1,0)+ IF( SELF.Diff_cname,1,0);
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
    Count_Diff_REGIS_NBR := COUNT(GROUP,%Closest%.Diff_REGIS_NBR);
    Count_Diff_BUSINESS_NAME := COUNT(GROUP,%Closest%.Diff_BUSINESS_NAME);
    Count_Diff_PHONE_NBR := COUNT(GROUP,%Closest%.Diff_PHONE_NBR);
    Count_Diff_FILE_DATE := COUNT(GROUP,%Closest%.Diff_FILE_DATE);
    Count_Diff_FIRST_NAME := COUNT(GROUP,%Closest%.Diff_FIRST_NAME);
    Count_Diff_MIDDLE_NAME := COUNT(GROUP,%Closest%.Diff_MIDDLE_NAME);
    Count_Diff_LAST_NAME_COMPANY := COUNT(GROUP,%Closest%.Diff_LAST_NAME_COMPANY);
    Count_Diff_OWNER_ADDRESS := COUNT(GROUP,%Closest%.Diff_OWNER_ADDRESS);
    Count_Diff_prep_bus_addr_line1 := COUNT(GROUP,%Closest%.Diff_prep_bus_addr_line1);
    Count_Diff_prep_bus_addr_line_last := COUNT(GROUP,%Closest%.Diff_prep_bus_addr_line_last);
    Count_Diff_prep_owner_addr_line1 := COUNT(GROUP,%Closest%.Diff_prep_owner_addr_line1);
    Count_Diff_prep_owner_addr_line_last := COUNT(GROUP,%Closest%.Diff_prep_owner_addr_line_last);
    Count_Diff_cname := COUNT(GROUP,%Closest%.Diff_cname);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
