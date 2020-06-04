IMPORT SALT311;
IMPORT Scrubs_OPM; // Import modules for FieldTypes attribute definitions
EXPORT raw_Fields := MODULE
 
EXPORT NumFields := 11;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_name','invalid_alpha_num','invalid_country','invalid_alpha_blank','invalid_alpha_blank_sp','invalid_alpha_num_sp','invalid_past_date','invalid_occu_Series_cd');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_name' => 1,'invalid_alpha_num' => 2,'invalid_country' => 3,'invalid_alpha_blank' => 4,'invalid_alpha_blank_sp' => 5,'invalid_alpha_num_sp' => 6,'invalid_past_date' => 7,'invalid_occu_Series_cd' => 8,0);
 
EXPORT MakeFT_invalid_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ.-\'`/, '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ.-\'`/, '))));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ.-\'`/, '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha_num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha_num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_alpha_num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_country(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ-,\' '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_country(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ-,\' '))));
EXPORT InValidMessageFT_invalid_country(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ-,\' '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha_blank(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ \' '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha_blank(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ \' '))));
EXPORT InValidMessageFT_invalid_alpha_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ \' '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha_blank_sp(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\',.(-) '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha_blank_sp(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\',.(-) '))));
EXPORT InValidMessageFT_invalid_alpha_blank_sp(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ\',.(-) '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha_num_sp(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ(-)., /&:\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha_num_sp(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ(-)., /&:\''))));
EXPORT InValidMessageFT_invalid_alpha_num_sp(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ(-)., /&:\''),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_past_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_past_date(SALT311.StrType s) := WHICH(~Scrubs_OPM.Functions.fn_check_past_date(s)>0);
EXPORT InValidMessageFT_invalid_past_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OPM.Functions.fn_check_past_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_occu_Series_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_occu_Series_cd(SALT311.StrType s) := WHICH(~Scrubs_OPM.Functions.fn_check_occu_Series_cd(s)>0);
EXPORT InValidMessageFT_invalid_occu_Series_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_OPM.Functions.fn_check_occu_Series_cd'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'employee_name','duty_station','country','state','city','county','agency','agency_sub_element','computation_date','occupational_series','file_date');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'employee_name','duty_station','country','state','city','county','agency','agency_sub_element','computation_date','occupational_series','file_date');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'employee_name' => 0,'duty_station' => 1,'country' => 2,'state' => 3,'city' => 4,'county' => 5,'agency' => 6,'agency_sub_element' => 7,'computation_date' => 8,'occupational_series' => 9,'file_date' => 10,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_employee_name(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_employee_name(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_employee_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_duty_station(SALT311.StrType s0) := MakeFT_invalid_alpha_num(s0);
EXPORT InValid_duty_station(SALT311.StrType s) := InValidFT_invalid_alpha_num(s);
EXPORT InValidMessage_duty_station(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_num(wh);
 
EXPORT Make_country(SALT311.StrType s0) := MakeFT_invalid_country(s0);
EXPORT InValid_country(SALT311.StrType s) := InValidFT_invalid_country(s);
EXPORT InValidMessage_country(UNSIGNED1 wh) := InValidMessageFT_invalid_country(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_invalid_alpha_blank(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_invalid_alpha_blank(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_blank(wh);
 
EXPORT Make_city(SALT311.StrType s0) := MakeFT_invalid_alpha_blank_sp(s0);
EXPORT InValid_city(SALT311.StrType s) := InValidFT_invalid_alpha_blank_sp(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_blank_sp(wh);
 
EXPORT Make_county(SALT311.StrType s0) := MakeFT_invalid_alpha_blank_sp(s0);
EXPORT InValid_county(SALT311.StrType s) := InValidFT_invalid_alpha_blank_sp(s);
EXPORT InValidMessage_county(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_blank_sp(wh);
 
EXPORT Make_agency(SALT311.StrType s0) := MakeFT_invalid_alpha_num_sp(s0);
EXPORT InValid_agency(SALT311.StrType s) := InValidFT_invalid_alpha_num_sp(s);
EXPORT InValidMessage_agency(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_num_sp(wh);
 
EXPORT Make_agency_sub_element(SALT311.StrType s0) := MakeFT_invalid_alpha_num_sp(s0);
EXPORT InValid_agency_sub_element(SALT311.StrType s) := InValidFT_invalid_alpha_num_sp(s);
EXPORT InValidMessage_agency_sub_element(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_num_sp(wh);
 
EXPORT Make_computation_date(SALT311.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_computation_date(SALT311.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_computation_date(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_occupational_series(SALT311.StrType s0) := MakeFT_invalid_occu_Series_cd(s0);
EXPORT InValid_occupational_series(SALT311.StrType s) := InValidFT_invalid_occu_Series_cd(s);
EXPORT InValidMessage_occupational_series(UNSIGNED1 wh) := InValidMessageFT_invalid_occu_Series_cd(wh);
 
EXPORT Make_file_date(SALT311.StrType s0) := s0;
EXPORT InValid_file_date(SALT311.StrType s) := 0;
EXPORT InValidMessage_file_date(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_OPM;
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
    BOOLEAN Diff_employee_name;
    BOOLEAN Diff_duty_station;
    BOOLEAN Diff_country;
    BOOLEAN Diff_state;
    BOOLEAN Diff_city;
    BOOLEAN Diff_county;
    BOOLEAN Diff_agency;
    BOOLEAN Diff_agency_sub_element;
    BOOLEAN Diff_computation_date;
    BOOLEAN Diff_occupational_series;
    BOOLEAN Diff_file_date;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_employee_name := le.employee_name <> ri.employee_name;
    SELF.Diff_duty_station := le.duty_station <> ri.duty_station;
    SELF.Diff_country := le.country <> ri.country;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_agency := le.agency <> ri.agency;
    SELF.Diff_agency_sub_element := le.agency_sub_element <> ri.agency_sub_element;
    SELF.Diff_computation_date := le.computation_date <> ri.computation_date;
    SELF.Diff_occupational_series := le.occupational_series <> ri.occupational_series;
    SELF.Diff_file_date := le.file_date <> ri.file_date;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_employee_name,1,0)+ IF( SELF.Diff_duty_station,1,0)+ IF( SELF.Diff_country,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_agency,1,0)+ IF( SELF.Diff_agency_sub_element,1,0)+ IF( SELF.Diff_computation_date,1,0)+ IF( SELF.Diff_occupational_series,1,0)+ IF( SELF.Diff_file_date,1,0);
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
    Count_Diff_employee_name := COUNT(GROUP,%Closest%.Diff_employee_name);
    Count_Diff_duty_station := COUNT(GROUP,%Closest%.Diff_duty_station);
    Count_Diff_country := COUNT(GROUP,%Closest%.Diff_country);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_agency := COUNT(GROUP,%Closest%.Diff_agency);
    Count_Diff_agency_sub_element := COUNT(GROUP,%Closest%.Diff_agency_sub_element);
    Count_Diff_computation_date := COUNT(GROUP,%Closest%.Diff_computation_date);
    Count_Diff_occupational_series := COUNT(GROUP,%Closest%.Diff_occupational_series);
    Count_Diff_file_date := COUNT(GROUP,%Closest%.Diff_file_date);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
