IMPORT SALT311;
IMPORT Scrubs_Txbus; // Import modules for FieldTypes attribute definitions
EXPORT Raw_Fields := MODULE
 
EXPORT NumFields := 22;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_taxpayer_number','invalid_outlet_number','invalid_taxpayer_name','invalid_taxpayer_state','invalid_taxpayer_zipcode','invalid_taxpayer_county_code','invalid_taxpayer_phone','invalid_taxpayer_org_type','outlet_name','invalid_outlet_state','invalid_outlet_zipcode','invalid_outlet_county_code','invalid_outlet_phone','invalid_outlet_naics_code','invalid_outlet_city_limits_indicator','invalid_outlet_permit_issue_date','invalid_outlet_first_sales_date');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_taxpayer_number' => 1,'invalid_outlet_number' => 2,'invalid_taxpayer_name' => 3,'invalid_taxpayer_state' => 4,'invalid_taxpayer_zipcode' => 5,'invalid_taxpayer_county_code' => 6,'invalid_taxpayer_phone' => 7,'invalid_taxpayer_org_type' => 8,'outlet_name' => 9,'invalid_outlet_state' => 10,'invalid_outlet_zipcode' => 11,'invalid_outlet_county_code' => 12,'invalid_outlet_phone' => 13,'invalid_outlet_naics_code' => 14,'invalid_outlet_city_limits_indicator' => 15,'invalid_outlet_permit_issue_date' => 16,'invalid_outlet_first_sales_date' => 17,0);
 
EXPORT MakeFT_invalid_taxpayer_number(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_taxpayer_number(SALT311.StrType s) := WHICH(~Scrubs_Txbus.Functions.fn_numeric(s,11)>0);
EXPORT InValidMessageFT_invalid_taxpayer_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Txbus.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_outlet_number(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_outlet_number(SALT311.StrType s) := WHICH(~Scrubs_Txbus.Functions.fn_numeric(s,5)>0);
EXPORT InValidMessageFT_invalid_outlet_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Txbus.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_taxpayer_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' &\',-.0123457ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_taxpayer_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' &\',-.0123457ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_taxpayer_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' &\',-.0123457ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_taxpayer_state(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_taxpayer_state(SALT311.StrType s) := WHICH(~Scrubs_Txbus.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_taxpayer_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Txbus.Functions.fn_verify_state'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_taxpayer_zipcode(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_taxpayer_zipcode(SALT311.StrType s) := WHICH(~Scrubs_Txbus.Functions.fn_verify_zip5(s)>0);
EXPORT InValidMessageFT_invalid_taxpayer_zipcode(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Txbus.Functions.fn_verify_zip5'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_taxpayer_county_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_taxpayer_county_code(SALT311.StrType s) := WHICH(~Scrubs_Txbus.Functions.fn_numeric(s,3)>0);
EXPORT InValidMessageFT_invalid_taxpayer_county_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Txbus.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_taxpayer_phone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_taxpayer_phone(SALT311.StrType s) := WHICH(~Scrubs_Txbus.Functions.fn_verify_phone(s)>0);
EXPORT InValidMessageFT_invalid_taxpayer_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Txbus.Functions.fn_verify_phone'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_taxpayer_org_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_taxpayer_org_type(SALT311.StrType s) := WHICH(~Scrubs_Txbus.Functions.fn_check_taxpayer_org_type(s)>0);
EXPORT InValidMessageFT_invalid_taxpayer_org_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Txbus.Functions.fn_check_taxpayer_org_type'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_outlet_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' #&\',-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_outlet_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' #&\',-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_outlet_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' #&\',-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_outlet_state(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_outlet_state(SALT311.StrType s) := WHICH(~Scrubs_Txbus.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_outlet_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Txbus.Functions.fn_verify_state'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_outlet_zipcode(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_outlet_zipcode(SALT311.StrType s) := WHICH(~Scrubs_Txbus.Functions.fn_verify_zip5(s)>0);
EXPORT InValidMessageFT_invalid_outlet_zipcode(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Txbus.Functions.fn_verify_zip5'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_outlet_county_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_outlet_county_code(SALT311.StrType s) := WHICH(~Scrubs_Txbus.Functions.fn_numeric(s,3)>0);
EXPORT InValidMessageFT_invalid_outlet_county_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Txbus.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_outlet_phone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_outlet_phone(SALT311.StrType s) := WHICH(~Scrubs_Txbus.Functions.fn_verify_phone(s)>0);
EXPORT InValidMessageFT_invalid_outlet_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Txbus.Functions.fn_verify_phone'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_outlet_naics_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_outlet_naics_code(SALT311.StrType s) := WHICH(~Scrubs_Txbus.Functions.fn_naics_code(s)>0);
EXPORT InValidMessageFT_invalid_outlet_naics_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Txbus.Functions.fn_naics_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_outlet_city_limits_indicator(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_outlet_city_limits_indicator(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['Y','N','']);
EXPORT InValidMessageFT_invalid_outlet_city_limits_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('Y|N|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_outlet_permit_issue_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_outlet_permit_issue_date(SALT311.StrType s) := WHICH(~Scrubs_Txbus.Functions.fn_general_date(s)>0);
EXPORT InValidMessageFT_invalid_outlet_permit_issue_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Txbus.Functions.fn_general_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_outlet_first_sales_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_outlet_first_sales_date(SALT311.StrType s) := WHICH(~Scrubs_Txbus.Functions.fn_general_date(s)>0);
EXPORT InValidMessageFT_invalid_outlet_first_sales_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Txbus.Functions.fn_general_date'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'taxpayer_number','outlet_number','taxpayer_name','taxpayer_address','taxpayer_city','taxpayer_state','taxpayer_zipcode','taxpayer_county_code','taxpayer_phone','taxpayer_org_type','outlet_name','outlet_address','outlet_city','outlet_state','outlet_zipcode','outlet_county_code','outlet_phone','outlet_naics_code','outlet_city_limits_indicator','outlet_permit_issue_date','outlet_first_sales_date','crlf');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'taxpayer_number','outlet_number','taxpayer_name','taxpayer_address','taxpayer_city','taxpayer_state','taxpayer_zipcode','taxpayer_county_code','taxpayer_phone','taxpayer_org_type','outlet_name','outlet_address','outlet_city','outlet_state','outlet_zipcode','outlet_county_code','outlet_phone','outlet_naics_code','outlet_city_limits_indicator','outlet_permit_issue_date','outlet_first_sales_date','crlf');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'taxpayer_number' => 0,'outlet_number' => 1,'taxpayer_name' => 2,'taxpayer_address' => 3,'taxpayer_city' => 4,'taxpayer_state' => 5,'taxpayer_zipcode' => 6,'taxpayer_county_code' => 7,'taxpayer_phone' => 8,'taxpayer_org_type' => 9,'outlet_name' => 10,'outlet_address' => 11,'outlet_city' => 12,'outlet_state' => 13,'outlet_zipcode' => 14,'outlet_county_code' => 15,'outlet_phone' => 16,'outlet_naics_code' => 17,'outlet_city_limits_indicator' => 18,'outlet_permit_issue_date' => 19,'outlet_first_sales_date' => 20,'crlf' => 21,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['ALLOW'],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_taxpayer_number(SALT311.StrType s0) := MakeFT_invalid_taxpayer_number(s0);
EXPORT InValid_taxpayer_number(SALT311.StrType s) := InValidFT_invalid_taxpayer_number(s);
EXPORT InValidMessage_taxpayer_number(UNSIGNED1 wh) := InValidMessageFT_invalid_taxpayer_number(wh);
 
EXPORT Make_outlet_number(SALT311.StrType s0) := MakeFT_invalid_outlet_number(s0);
EXPORT InValid_outlet_number(SALT311.StrType s) := InValidFT_invalid_outlet_number(s);
EXPORT InValidMessage_outlet_number(UNSIGNED1 wh) := InValidMessageFT_invalid_outlet_number(wh);
 
EXPORT Make_taxpayer_name(SALT311.StrType s0) := MakeFT_invalid_taxpayer_name(s0);
EXPORT InValid_taxpayer_name(SALT311.StrType s) := InValidFT_invalid_taxpayer_name(s);
EXPORT InValidMessage_taxpayer_name(UNSIGNED1 wh) := InValidMessageFT_invalid_taxpayer_name(wh);
 
EXPORT Make_taxpayer_address(SALT311.StrType s0) := s0;
EXPORT InValid_taxpayer_address(SALT311.StrType s) := 0;
EXPORT InValidMessage_taxpayer_address(UNSIGNED1 wh) := '';
 
EXPORT Make_taxpayer_city(SALT311.StrType s0) := s0;
EXPORT InValid_taxpayer_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_taxpayer_city(UNSIGNED1 wh) := '';
 
EXPORT Make_taxpayer_state(SALT311.StrType s0) := MakeFT_invalid_taxpayer_state(s0);
EXPORT InValid_taxpayer_state(SALT311.StrType s) := InValidFT_invalid_taxpayer_state(s);
EXPORT InValidMessage_taxpayer_state(UNSIGNED1 wh) := InValidMessageFT_invalid_taxpayer_state(wh);
 
EXPORT Make_taxpayer_zipcode(SALT311.StrType s0) := MakeFT_invalid_taxpayer_zipcode(s0);
EXPORT InValid_taxpayer_zipcode(SALT311.StrType s) := InValidFT_invalid_taxpayer_zipcode(s);
EXPORT InValidMessage_taxpayer_zipcode(UNSIGNED1 wh) := InValidMessageFT_invalid_taxpayer_zipcode(wh);
 
EXPORT Make_taxpayer_county_code(SALT311.StrType s0) := MakeFT_invalid_taxpayer_zipcode(s0);
EXPORT InValid_taxpayer_county_code(SALT311.StrType s) := InValidFT_invalid_taxpayer_zipcode(s);
EXPORT InValidMessage_taxpayer_county_code(UNSIGNED1 wh) := InValidMessageFT_invalid_taxpayer_zipcode(wh);
 
EXPORT Make_taxpayer_phone(SALT311.StrType s0) := MakeFT_invalid_taxpayer_zipcode(s0);
EXPORT InValid_taxpayer_phone(SALT311.StrType s) := InValidFT_invalid_taxpayer_zipcode(s);
EXPORT InValidMessage_taxpayer_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_taxpayer_zipcode(wh);
 
EXPORT Make_taxpayer_org_type(SALT311.StrType s0) := s0;
EXPORT InValid_taxpayer_org_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_taxpayer_org_type(UNSIGNED1 wh) := '';
 
EXPORT Make_outlet_name(SALT311.StrType s0) := MakeFT_invalid_taxpayer_zipcode(s0);
EXPORT InValid_outlet_name(SALT311.StrType s) := InValidFT_invalid_taxpayer_zipcode(s);
EXPORT InValidMessage_outlet_name(UNSIGNED1 wh) := InValidMessageFT_invalid_taxpayer_zipcode(wh);
 
EXPORT Make_outlet_address(SALT311.StrType s0) := s0;
EXPORT InValid_outlet_address(SALT311.StrType s) := 0;
EXPORT InValidMessage_outlet_address(UNSIGNED1 wh) := '';
 
EXPORT Make_outlet_city(SALT311.StrType s0) := s0;
EXPORT InValid_outlet_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_outlet_city(UNSIGNED1 wh) := '';
 
EXPORT Make_outlet_state(SALT311.StrType s0) := MakeFT_invalid_outlet_state(s0);
EXPORT InValid_outlet_state(SALT311.StrType s) := InValidFT_invalid_outlet_state(s);
EXPORT InValidMessage_outlet_state(UNSIGNED1 wh) := InValidMessageFT_invalid_outlet_state(wh);
 
EXPORT Make_outlet_zipcode(SALT311.StrType s0) := MakeFT_invalid_outlet_zipcode(s0);
EXPORT InValid_outlet_zipcode(SALT311.StrType s) := InValidFT_invalid_outlet_zipcode(s);
EXPORT InValidMessage_outlet_zipcode(UNSIGNED1 wh) := InValidMessageFT_invalid_outlet_zipcode(wh);
 
EXPORT Make_outlet_county_code(SALT311.StrType s0) := MakeFT_invalid_outlet_county_code(s0);
EXPORT InValid_outlet_county_code(SALT311.StrType s) := InValidFT_invalid_outlet_county_code(s);
EXPORT InValidMessage_outlet_county_code(UNSIGNED1 wh) := InValidMessageFT_invalid_outlet_county_code(wh);
 
EXPORT Make_outlet_phone(SALT311.StrType s0) := MakeFT_invalid_outlet_phone(s0);
EXPORT InValid_outlet_phone(SALT311.StrType s) := InValidFT_invalid_outlet_phone(s);
EXPORT InValidMessage_outlet_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_outlet_phone(wh);
 
EXPORT Make_outlet_naics_code(SALT311.StrType s0) := MakeFT_invalid_outlet_naics_code(s0);
EXPORT InValid_outlet_naics_code(SALT311.StrType s) := InValidFT_invalid_outlet_naics_code(s);
EXPORT InValidMessage_outlet_naics_code(UNSIGNED1 wh) := InValidMessageFT_invalid_outlet_naics_code(wh);
 
EXPORT Make_outlet_city_limits_indicator(SALT311.StrType s0) := MakeFT_invalid_outlet_city_limits_indicator(s0);
EXPORT InValid_outlet_city_limits_indicator(SALT311.StrType s) := InValidFT_invalid_outlet_city_limits_indicator(s);
EXPORT InValidMessage_outlet_city_limits_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_outlet_city_limits_indicator(wh);
 
EXPORT Make_outlet_permit_issue_date(SALT311.StrType s0) := MakeFT_invalid_outlet_permit_issue_date(s0);
EXPORT InValid_outlet_permit_issue_date(SALT311.StrType s) := InValidFT_invalid_outlet_permit_issue_date(s);
EXPORT InValidMessage_outlet_permit_issue_date(UNSIGNED1 wh) := InValidMessageFT_invalid_outlet_permit_issue_date(wh);
 
EXPORT Make_outlet_first_sales_date(SALT311.StrType s0) := MakeFT_invalid_outlet_first_sales_date(s0);
EXPORT InValid_outlet_first_sales_date(SALT311.StrType s) := InValidFT_invalid_outlet_first_sales_date(s);
EXPORT InValidMessage_outlet_first_sales_date(UNSIGNED1 wh) := InValidMessageFT_invalid_outlet_first_sales_date(wh);
 
EXPORT Make_crlf(SALT311.StrType s0) := s0;
EXPORT InValid_crlf(SALT311.StrType s) := 0;
EXPORT InValidMessage_crlf(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Txbus;
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
    BOOLEAN Diff_taxpayer_number;
    BOOLEAN Diff_outlet_number;
    BOOLEAN Diff_taxpayer_name;
    BOOLEAN Diff_taxpayer_address;
    BOOLEAN Diff_taxpayer_city;
    BOOLEAN Diff_taxpayer_state;
    BOOLEAN Diff_taxpayer_zipcode;
    BOOLEAN Diff_taxpayer_county_code;
    BOOLEAN Diff_taxpayer_phone;
    BOOLEAN Diff_taxpayer_org_type;
    BOOLEAN Diff_outlet_name;
    BOOLEAN Diff_outlet_address;
    BOOLEAN Diff_outlet_city;
    BOOLEAN Diff_outlet_state;
    BOOLEAN Diff_outlet_zipcode;
    BOOLEAN Diff_outlet_county_code;
    BOOLEAN Diff_outlet_phone;
    BOOLEAN Diff_outlet_naics_code;
    BOOLEAN Diff_outlet_city_limits_indicator;
    BOOLEAN Diff_outlet_permit_issue_date;
    BOOLEAN Diff_outlet_first_sales_date;
    BOOLEAN Diff_crlf;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_taxpayer_number := le.taxpayer_number <> ri.taxpayer_number;
    SELF.Diff_outlet_number := le.outlet_number <> ri.outlet_number;
    SELF.Diff_taxpayer_name := le.taxpayer_name <> ri.taxpayer_name;
    SELF.Diff_taxpayer_address := le.taxpayer_address <> ri.taxpayer_address;
    SELF.Diff_taxpayer_city := le.taxpayer_city <> ri.taxpayer_city;
    SELF.Diff_taxpayer_state := le.taxpayer_state <> ri.taxpayer_state;
    SELF.Diff_taxpayer_zipcode := le.taxpayer_zipcode <> ri.taxpayer_zipcode;
    SELF.Diff_taxpayer_county_code := le.taxpayer_county_code <> ri.taxpayer_county_code;
    SELF.Diff_taxpayer_phone := le.taxpayer_phone <> ri.taxpayer_phone;
    SELF.Diff_taxpayer_org_type := le.taxpayer_org_type <> ri.taxpayer_org_type;
    SELF.Diff_outlet_name := le.outlet_name <> ri.outlet_name;
    SELF.Diff_outlet_address := le.outlet_address <> ri.outlet_address;
    SELF.Diff_outlet_city := le.outlet_city <> ri.outlet_city;
    SELF.Diff_outlet_state := le.outlet_state <> ri.outlet_state;
    SELF.Diff_outlet_zipcode := le.outlet_zipcode <> ri.outlet_zipcode;
    SELF.Diff_outlet_county_code := le.outlet_county_code <> ri.outlet_county_code;
    SELF.Diff_outlet_phone := le.outlet_phone <> ri.outlet_phone;
    SELF.Diff_outlet_naics_code := le.outlet_naics_code <> ri.outlet_naics_code;
    SELF.Diff_outlet_city_limits_indicator := le.outlet_city_limits_indicator <> ri.outlet_city_limits_indicator;
    SELF.Diff_outlet_permit_issue_date := le.outlet_permit_issue_date <> ri.outlet_permit_issue_date;
    SELF.Diff_outlet_first_sales_date := le.outlet_first_sales_date <> ri.outlet_first_sales_date;
    SELF.Diff_crlf := le.crlf <> ri.crlf;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_taxpayer_number,1,0)+ IF( SELF.Diff_outlet_number,1,0)+ IF( SELF.Diff_taxpayer_name,1,0)+ IF( SELF.Diff_taxpayer_address,1,0)+ IF( SELF.Diff_taxpayer_city,1,0)+ IF( SELF.Diff_taxpayer_state,1,0)+ IF( SELF.Diff_taxpayer_zipcode,1,0)+ IF( SELF.Diff_taxpayer_county_code,1,0)+ IF( SELF.Diff_taxpayer_phone,1,0)+ IF( SELF.Diff_taxpayer_org_type,1,0)+ IF( SELF.Diff_outlet_name,1,0)+ IF( SELF.Diff_outlet_address,1,0)+ IF( SELF.Diff_outlet_city,1,0)+ IF( SELF.Diff_outlet_state,1,0)+ IF( SELF.Diff_outlet_zipcode,1,0)+ IF( SELF.Diff_outlet_county_code,1,0)+ IF( SELF.Diff_outlet_phone,1,0)+ IF( SELF.Diff_outlet_naics_code,1,0)+ IF( SELF.Diff_outlet_city_limits_indicator,1,0)+ IF( SELF.Diff_outlet_permit_issue_date,1,0)+ IF( SELF.Diff_outlet_first_sales_date,1,0)+ IF( SELF.Diff_crlf,1,0);
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
    Count_Diff_taxpayer_number := COUNT(GROUP,%Closest%.Diff_taxpayer_number);
    Count_Diff_outlet_number := COUNT(GROUP,%Closest%.Diff_outlet_number);
    Count_Diff_taxpayer_name := COUNT(GROUP,%Closest%.Diff_taxpayer_name);
    Count_Diff_taxpayer_address := COUNT(GROUP,%Closest%.Diff_taxpayer_address);
    Count_Diff_taxpayer_city := COUNT(GROUP,%Closest%.Diff_taxpayer_city);
    Count_Diff_taxpayer_state := COUNT(GROUP,%Closest%.Diff_taxpayer_state);
    Count_Diff_taxpayer_zipcode := COUNT(GROUP,%Closest%.Diff_taxpayer_zipcode);
    Count_Diff_taxpayer_county_code := COUNT(GROUP,%Closest%.Diff_taxpayer_county_code);
    Count_Diff_taxpayer_phone := COUNT(GROUP,%Closest%.Diff_taxpayer_phone);
    Count_Diff_taxpayer_org_type := COUNT(GROUP,%Closest%.Diff_taxpayer_org_type);
    Count_Diff_outlet_name := COUNT(GROUP,%Closest%.Diff_outlet_name);
    Count_Diff_outlet_address := COUNT(GROUP,%Closest%.Diff_outlet_address);
    Count_Diff_outlet_city := COUNT(GROUP,%Closest%.Diff_outlet_city);
    Count_Diff_outlet_state := COUNT(GROUP,%Closest%.Diff_outlet_state);
    Count_Diff_outlet_zipcode := COUNT(GROUP,%Closest%.Diff_outlet_zipcode);
    Count_Diff_outlet_county_code := COUNT(GROUP,%Closest%.Diff_outlet_county_code);
    Count_Diff_outlet_phone := COUNT(GROUP,%Closest%.Diff_outlet_phone);
    Count_Diff_outlet_naics_code := COUNT(GROUP,%Closest%.Diff_outlet_naics_code);
    Count_Diff_outlet_city_limits_indicator := COUNT(GROUP,%Closest%.Diff_outlet_city_limits_indicator);
    Count_Diff_outlet_permit_issue_date := COUNT(GROUP,%Closest%.Diff_outlet_permit_issue_date);
    Count_Diff_outlet_first_sales_date := COUNT(GROUP,%Closest%.Diff_outlet_first_sales_date);
    Count_Diff_crlf := COUNT(GROUP,%Closest%.Diff_crlf);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
