IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 15;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_id','Invalid_mandatory_alpha','Invalid_alpha','Invalid_zip','Invalid_Numeric_Optional','Invalid_interstate','Invalid_no_id_flag');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_id' => 1,'Invalid_mandatory_alpha' => 2,'Invalid_alpha' => 3,'Invalid_zip' => 4,'Invalid_Numeric_Optional' => 5,'Invalid_interstate' => 6,'Invalid_no_id_flag' => 7,0);
 
EXPORT MakeFT_Invalid_id(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_id(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_numeric(s,7)>0);
EXPORT InValidMessageFT_Invalid_id(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_mandatory_alpha(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_mandatory_alpha(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_ASCII_printable(s)>0,~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Invalid_mandatory_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_ASCII_printable'),SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_alpha(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_alpha(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_ASCII_printable(s)>0);
EXPORT InValidMessageFT_Invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_ASCII_printable'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_zip(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_zip(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_valid_zip(s)>0);
EXPORT InValidMessageFT_Invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_valid_zip'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Numeric_Optional(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Numeric_Optional(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_Invalid_Numeric_Optional(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_interstate(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_interstate(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['N','Y','X',' ']);
EXPORT InValidMessageFT_Invalid_interstate(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('N|Y|X| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_no_id_flag(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_no_id_flag(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['0','1']);
EXPORT InValidMessageFT_Invalid_no_id_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('0|1'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'carrier_id','crash_id','carrier_source_code','carrier_name','carrier_street','carrier_city','carrier_city_code','carrier_state','carrier_zip_code','crash_colonia','docket_number','interstate','no_id_flag','state_number','state_issuing_number');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'carrier_id','crash_id','carrier_source_code','carrier_name','carrier_street','carrier_city','carrier_city_code','carrier_state','carrier_zip_code','crash_colonia','docket_number','interstate','no_id_flag','state_number','state_issuing_number');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'carrier_id' => 0,'crash_id' => 1,'carrier_source_code' => 2,'carrier_name' => 3,'carrier_street' => 4,'carrier_city' => 5,'carrier_city_code' => 6,'carrier_state' => 7,'carrier_zip_code' => 8,'crash_colonia' => 9,'docket_number' => 10,'interstate' => 11,'no_id_flag' => 12,'state_number' => 13,'state_issuing_number' => 14,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],[],['CUSTOM','LENGTHS'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],[],['ALLOW'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_carrier_id(SALT311.StrType s0) := MakeFT_Invalid_id(s0);
EXPORT InValid_carrier_id(SALT311.StrType s) := InValidFT_Invalid_id(s);
EXPORT InValidMessage_carrier_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_id(wh);
 
EXPORT Make_crash_id(SALT311.StrType s0) := MakeFT_Invalid_id(s0);
EXPORT InValid_crash_id(SALT311.StrType s) := InValidFT_Invalid_id(s);
EXPORT InValidMessage_crash_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_id(wh);
 
EXPORT Make_carrier_source_code(SALT311.StrType s0) := s0;
EXPORT InValid_carrier_source_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_carrier_source_code(UNSIGNED1 wh) := '';
 
EXPORT Make_carrier_name(SALT311.StrType s0) := MakeFT_Invalid_mandatory_alpha(s0);
EXPORT InValid_carrier_name(SALT311.StrType s) := InValidFT_Invalid_mandatory_alpha(s);
EXPORT InValidMessage_carrier_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_mandatory_alpha(wh);
 
EXPORT Make_carrier_street(SALT311.StrType s0) := MakeFT_Invalid_alpha(s0);
EXPORT InValid_carrier_street(SALT311.StrType s) := InValidFT_Invalid_alpha(s);
EXPORT InValidMessage_carrier_street(UNSIGNED1 wh) := InValidMessageFT_Invalid_alpha(wh);
 
EXPORT Make_carrier_city(SALT311.StrType s0) := MakeFT_Invalid_alpha(s0);
EXPORT InValid_carrier_city(SALT311.StrType s) := InValidFT_Invalid_alpha(s);
EXPORT InValidMessage_carrier_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_alpha(wh);
 
EXPORT Make_carrier_city_code(SALT311.StrType s0) := s0;
EXPORT InValid_carrier_city_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_carrier_city_code(UNSIGNED1 wh) := '';
 
EXPORT Make_carrier_state(SALT311.StrType s0) := MakeFT_Invalid_alpha(s0);
EXPORT InValid_carrier_state(SALT311.StrType s) := InValidFT_Invalid_alpha(s);
EXPORT InValidMessage_carrier_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_alpha(wh);
 
EXPORT Make_carrier_zip_code(SALT311.StrType s0) := MakeFT_Invalid_alpha(s0);
EXPORT InValid_carrier_zip_code(SALT311.StrType s) := InValidFT_Invalid_alpha(s);
EXPORT InValidMessage_carrier_zip_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_alpha(wh);
 
EXPORT Make_crash_colonia(SALT311.StrType s0) := s0;
EXPORT InValid_crash_colonia(SALT311.StrType s) := 0;
EXPORT InValidMessage_crash_colonia(UNSIGNED1 wh) := '';
 
EXPORT Make_docket_number(SALT311.StrType s0) := MakeFT_Invalid_Numeric_Optional(s0);
EXPORT InValid_docket_number(SALT311.StrType s) := InValidFT_Invalid_Numeric_Optional(s);
EXPORT InValidMessage_docket_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Numeric_Optional(wh);
 
EXPORT Make_interstate(SALT311.StrType s0) := MakeFT_Invalid_interstate(s0);
EXPORT InValid_interstate(SALT311.StrType s) := InValidFT_Invalid_interstate(s);
EXPORT InValidMessage_interstate(UNSIGNED1 wh) := InValidMessageFT_Invalid_interstate(wh);
 
EXPORT Make_no_id_flag(SALT311.StrType s0) := MakeFT_Invalid_no_id_flag(s0);
EXPORT InValid_no_id_flag(SALT311.StrType s) := InValidFT_Invalid_no_id_flag(s);
EXPORT InValidMessage_no_id_flag(UNSIGNED1 wh) := InValidMessageFT_Invalid_no_id_flag(wh);
 
EXPORT Make_state_number(SALT311.StrType s0) := MakeFT_Invalid_alpha(s0);
EXPORT InValid_state_number(SALT311.StrType s) := InValidFT_Invalid_alpha(s);
EXPORT InValidMessage_state_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_alpha(wh);
 
EXPORT Make_state_issuing_number(SALT311.StrType s0) := MakeFT_Invalid_alpha(s0);
EXPORT InValid_state_issuing_number(SALT311.StrType s) := InValidFT_Invalid_alpha(s);
EXPORT InValidMessage_state_issuing_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_alpha(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_CrashCarrier;
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
    BOOLEAN Diff_carrier_id;
    BOOLEAN Diff_crash_id;
    BOOLEAN Diff_carrier_source_code;
    BOOLEAN Diff_carrier_name;
    BOOLEAN Diff_carrier_street;
    BOOLEAN Diff_carrier_city;
    BOOLEAN Diff_carrier_city_code;
    BOOLEAN Diff_carrier_state;
    BOOLEAN Diff_carrier_zip_code;
    BOOLEAN Diff_crash_colonia;
    BOOLEAN Diff_docket_number;
    BOOLEAN Diff_interstate;
    BOOLEAN Diff_no_id_flag;
    BOOLEAN Diff_state_number;
    BOOLEAN Diff_state_issuing_number;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_carrier_id := le.carrier_id <> ri.carrier_id;
    SELF.Diff_crash_id := le.crash_id <> ri.crash_id;
    SELF.Diff_carrier_source_code := le.carrier_source_code <> ri.carrier_source_code;
    SELF.Diff_carrier_name := le.carrier_name <> ri.carrier_name;
    SELF.Diff_carrier_street := le.carrier_street <> ri.carrier_street;
    SELF.Diff_carrier_city := le.carrier_city <> ri.carrier_city;
    SELF.Diff_carrier_city_code := le.carrier_city_code <> ri.carrier_city_code;
    SELF.Diff_carrier_state := le.carrier_state <> ri.carrier_state;
    SELF.Diff_carrier_zip_code := le.carrier_zip_code <> ri.carrier_zip_code;
    SELF.Diff_crash_colonia := le.crash_colonia <> ri.crash_colonia;
    SELF.Diff_docket_number := le.docket_number <> ri.docket_number;
    SELF.Diff_interstate := le.interstate <> ri.interstate;
    SELF.Diff_no_id_flag := le.no_id_flag <> ri.no_id_flag;
    SELF.Diff_state_number := le.state_number <> ri.state_number;
    SELF.Diff_state_issuing_number := le.state_issuing_number <> ri.state_issuing_number;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_carrier_id,1,0)+ IF( SELF.Diff_crash_id,1,0)+ IF( SELF.Diff_carrier_source_code,1,0)+ IF( SELF.Diff_carrier_name,1,0)+ IF( SELF.Diff_carrier_street,1,0)+ IF( SELF.Diff_carrier_city,1,0)+ IF( SELF.Diff_carrier_city_code,1,0)+ IF( SELF.Diff_carrier_state,1,0)+ IF( SELF.Diff_carrier_zip_code,1,0)+ IF( SELF.Diff_crash_colonia,1,0)+ IF( SELF.Diff_docket_number,1,0)+ IF( SELF.Diff_interstate,1,0)+ IF( SELF.Diff_no_id_flag,1,0)+ IF( SELF.Diff_state_number,1,0)+ IF( SELF.Diff_state_issuing_number,1,0);
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
    Count_Diff_carrier_id := COUNT(GROUP,%Closest%.Diff_carrier_id);
    Count_Diff_crash_id := COUNT(GROUP,%Closest%.Diff_crash_id);
    Count_Diff_carrier_source_code := COUNT(GROUP,%Closest%.Diff_carrier_source_code);
    Count_Diff_carrier_name := COUNT(GROUP,%Closest%.Diff_carrier_name);
    Count_Diff_carrier_street := COUNT(GROUP,%Closest%.Diff_carrier_street);
    Count_Diff_carrier_city := COUNT(GROUP,%Closest%.Diff_carrier_city);
    Count_Diff_carrier_city_code := COUNT(GROUP,%Closest%.Diff_carrier_city_code);
    Count_Diff_carrier_state := COUNT(GROUP,%Closest%.Diff_carrier_state);
    Count_Diff_carrier_zip_code := COUNT(GROUP,%Closest%.Diff_carrier_zip_code);
    Count_Diff_crash_colonia := COUNT(GROUP,%Closest%.Diff_crash_colonia);
    Count_Diff_docket_number := COUNT(GROUP,%Closest%.Diff_docket_number);
    Count_Diff_interstate := COUNT(GROUP,%Closest%.Diff_interstate);
    Count_Diff_no_id_flag := COUNT(GROUP,%Closest%.Diff_no_id_flag);
    Count_Diff_state_number := COUNT(GROUP,%Closest%.Diff_state_number);
    Count_Diff_state_issuing_number := COUNT(GROUP,%Closest%.Diff_state_issuing_number);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
