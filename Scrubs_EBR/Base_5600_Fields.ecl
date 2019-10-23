IMPORT SALT311;
IMPORT Scrubs_EBR; // Import modules for FieldTypes attribute definitions
EXPORT Base_5600_Fields := MODULE
 
EXPORT NumFields := 32;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_numeric','invalid_numeric_or_allzeros','invalid_pastdate','invalid_dt_first_seen','invalid_record_type','invalid_segment','invalid_file_number','invalid_sic_code','invalid_bustyp_code','invalid_bustyp_desc','invalid_ownertyp_code','invalid_ownertyp_desc','invalid_location_code','invalid_location_desc','invalid_sales');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_numeric' => 2,'invalid_numeric_or_allzeros' => 3,'invalid_pastdate' => 4,'invalid_dt_first_seen' => 5,'invalid_record_type' => 6,'invalid_segment' => 7,'invalid_file_number' => 8,'invalid_sic_code' => 9,'invalid_bustyp_code' => 10,'invalid_bustyp_desc' => 11,'invalid_ownertyp_code' => 12,'invalid_ownertyp_desc' => 13,'invalid_location_code' => 14,'invalid_location_desc' => 15,'invalid_sales' => 16,0);
 
EXPORT MakeFT_invalid_mandatory(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric_or_allzeros(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric_or_allzeros(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_numeric_or_allzeros(s)>0);
EXPORT InValidMessageFT_invalid_numeric_or_allzeros(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_numeric_or_allzeros'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pastdate(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pastdate(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_past_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_pastdate(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_past_yyyymmdd'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dt_first_seen(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dt_first_seen(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_dt_first_seen(s)>0);
EXPORT InValidMessageFT_invalid_dt_first_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_dt_first_seen'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_record_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['H','C']);
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('H|C'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_segment(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_segment(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['5600','5600']);
EXPORT InValidMessageFT_invalid_segment(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('5600|5600'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_file_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_file_number(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~(LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_file_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT311.HygieneErrors.NotLength('9'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sic_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sic_code(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_sic_code(s)>0);
EXPORT InValidMessageFT_invalid_sic_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_sic_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_bustyp_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_bustyp_code(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_bustyp_code(s)>0);
EXPORT InValidMessageFT_invalid_bustyp_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_bustyp_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_bustyp_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_bustyp_desc(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_bustyp_desc(s)>0);
EXPORT InValidMessageFT_invalid_bustyp_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_bustyp_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ownertyp_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ownertyp_code(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_ownertyp_code(s)>0);
EXPORT InValidMessageFT_invalid_ownertyp_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_ownertyp_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ownertyp_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ownertyp_desc(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_ownertyp_desc(s)>0);
EXPORT InValidMessageFT_invalid_ownertyp_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_ownertyp_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_location_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_location_code(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_location_code(s)>0);
EXPORT InValidMessageFT_invalid_location_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_location_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_location_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_location_desc(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_location_desc(s)>0);
EXPORT InValidMessageFT_invalid_location_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_location_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sales(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHI-{'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_sales(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHI-{'))));
EXPORT InValidMessageFT_invalid_sales(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHI-{'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','sic_1_code','sic_1_desc','sic_2_code','sic_2_desc','sic_3_code','sic_3_desc','sic_4_code','sic_4_desc','yrs_in_bus_actual','sales_actual','empl_size_actual','bus_type_code','bus_type_desc','owner_type_code','owner_type_desc','location_code','location_desc');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','sic_1_code','sic_1_desc','sic_2_code','sic_2_desc','sic_3_code','sic_3_desc','sic_4_code','sic_4_desc','yrs_in_bus_actual','sales_actual','empl_size_actual','bus_type_code','bus_type_desc','owner_type_code','owner_type_desc','location_code','location_desc');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'powid' => 0,'proxid' => 1,'seleid' => 2,'orgid' => 3,'ultid' => 4,'bdid' => 5,'date_first_seen' => 6,'date_last_seen' => 7,'process_date_first_seen' => 8,'process_date_last_seen' => 9,'record_type' => 10,'process_date' => 11,'file_number' => 12,'segment_code' => 13,'sequence_number' => 14,'sic_1_code' => 15,'sic_1_desc' => 16,'sic_2_code' => 17,'sic_2_desc' => 18,'sic_3_code' => 19,'sic_3_desc' => 20,'sic_4_code' => 21,'sic_4_desc' => 22,'yrs_in_bus_actual' => 23,'sales_actual' => 24,'empl_size_actual' => 25,'bus_type_code' => 26,'bus_type_desc' => 27,'owner_type_code' => 28,'owner_type_desc' => 29,'location_code' => 30,'location_desc' => 31,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ALLOW','LENGTHS'],['ENUM'],['CUSTOM'],['CUSTOM'],['LENGTHS'],['CUSTOM'],['LENGTHS'],['CUSTOM'],['LENGTHS'],['CUSTOM'],['LENGTHS'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_powid(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_powid(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_powid(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_proxid(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_proxid(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_seleid(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_seleid(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_orgid(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_orgid(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_ultid(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_ultid(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_bdid(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_bdid(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_date_first_seen(SALT311.StrType s0) := MakeFT_invalid_dt_first_seen(s0);
EXPORT InValid_date_first_seen(SALT311.StrType s) := InValidFT_invalid_dt_first_seen(s);
EXPORT InValidMessage_date_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_dt_first_seen(wh);
 
EXPORT Make_date_last_seen(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_date_last_seen(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_date_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_process_date_first_seen(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_process_date_first_seen(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_process_date_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_process_date_last_seen(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_process_date_last_seen(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_process_date_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_record_type(SALT311.StrType s0) := MakeFT_invalid_record_type(s0);
EXPORT InValid_record_type(SALT311.StrType s) := InValidFT_invalid_record_type(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_invalid_record_type(wh);
 
EXPORT Make_process_date(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_process_date(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_file_number(SALT311.StrType s0) := MakeFT_invalid_file_number(s0);
EXPORT InValid_file_number(SALT311.StrType s) := InValidFT_invalid_file_number(s);
EXPORT InValidMessage_file_number(UNSIGNED1 wh) := InValidMessageFT_invalid_file_number(wh);
 
EXPORT Make_segment_code(SALT311.StrType s0) := MakeFT_invalid_segment(s0);
EXPORT InValid_segment_code(SALT311.StrType s) := InValidFT_invalid_segment(s);
EXPORT InValidMessage_segment_code(UNSIGNED1 wh) := InValidMessageFT_invalid_segment(wh);
 
EXPORT Make_sequence_number(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_sequence_number(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_sequence_number(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_sic_1_code(SALT311.StrType s0) := MakeFT_invalid_sic_code(s0);
EXPORT InValid_sic_1_code(SALT311.StrType s) := InValidFT_invalid_sic_code(s);
EXPORT InValidMessage_sic_1_code(UNSIGNED1 wh) := InValidMessageFT_invalid_sic_code(wh);
 
EXPORT Make_sic_1_desc(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_sic_1_desc(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_sic_1_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_sic_2_code(SALT311.StrType s0) := MakeFT_invalid_sic_code(s0);
EXPORT InValid_sic_2_code(SALT311.StrType s) := InValidFT_invalid_sic_code(s);
EXPORT InValidMessage_sic_2_code(UNSIGNED1 wh) := InValidMessageFT_invalid_sic_code(wh);
 
EXPORT Make_sic_2_desc(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_sic_2_desc(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_sic_2_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_sic_3_code(SALT311.StrType s0) := MakeFT_invalid_sic_code(s0);
EXPORT InValid_sic_3_code(SALT311.StrType s) := InValidFT_invalid_sic_code(s);
EXPORT InValidMessage_sic_3_code(UNSIGNED1 wh) := InValidMessageFT_invalid_sic_code(wh);
 
EXPORT Make_sic_3_desc(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_sic_3_desc(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_sic_3_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_sic_4_code(SALT311.StrType s0) := MakeFT_invalid_sic_code(s0);
EXPORT InValid_sic_4_code(SALT311.StrType s) := InValidFT_invalid_sic_code(s);
EXPORT InValidMessage_sic_4_code(UNSIGNED1 wh) := InValidMessageFT_invalid_sic_code(wh);
 
EXPORT Make_sic_4_desc(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_sic_4_desc(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_sic_4_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_yrs_in_bus_actual(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_yrs_in_bus_actual(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_yrs_in_bus_actual(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_sales_actual(SALT311.StrType s0) := MakeFT_invalid_sales(s0);
EXPORT InValid_sales_actual(SALT311.StrType s) := InValidFT_invalid_sales(s);
EXPORT InValidMessage_sales_actual(UNSIGNED1 wh) := InValidMessageFT_invalid_sales(wh);
 
EXPORT Make_empl_size_actual(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_empl_size_actual(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_empl_size_actual(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_bus_type_code(SALT311.StrType s0) := MakeFT_invalid_bustyp_code(s0);
EXPORT InValid_bus_type_code(SALT311.StrType s) := InValidFT_invalid_bustyp_code(s);
EXPORT InValidMessage_bus_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_bustyp_code(wh);
 
EXPORT Make_bus_type_desc(SALT311.StrType s0) := MakeFT_invalid_bustyp_desc(s0);
EXPORT InValid_bus_type_desc(SALT311.StrType s) := InValidFT_invalid_bustyp_desc(s);
EXPORT InValidMessage_bus_type_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_bustyp_desc(wh);
 
EXPORT Make_owner_type_code(SALT311.StrType s0) := MakeFT_invalid_ownertyp_code(s0);
EXPORT InValid_owner_type_code(SALT311.StrType s) := InValidFT_invalid_ownertyp_code(s);
EXPORT InValidMessage_owner_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_ownertyp_code(wh);
 
EXPORT Make_owner_type_desc(SALT311.StrType s0) := MakeFT_invalid_ownertyp_desc(s0);
EXPORT InValid_owner_type_desc(SALT311.StrType s) := InValidFT_invalid_ownertyp_desc(s);
EXPORT InValidMessage_owner_type_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_ownertyp_desc(wh);
 
EXPORT Make_location_code(SALT311.StrType s0) := MakeFT_invalid_location_code(s0);
EXPORT InValid_location_code(SALT311.StrType s) := InValidFT_invalid_location_code(s);
EXPORT InValidMessage_location_code(UNSIGNED1 wh) := InValidMessageFT_invalid_location_code(wh);
 
EXPORT Make_location_desc(SALT311.StrType s0) := MakeFT_invalid_location_desc(s0);
EXPORT InValid_location_desc(SALT311.StrType s) := InValidFT_invalid_location_desc(s);
EXPORT InValidMessage_location_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_location_desc(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_EBR;
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
    BOOLEAN Diff_powid;
    BOOLEAN Diff_proxid;
    BOOLEAN Diff_seleid;
    BOOLEAN Diff_orgid;
    BOOLEAN Diff_ultid;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_date_first_seen;
    BOOLEAN Diff_date_last_seen;
    BOOLEAN Diff_process_date_first_seen;
    BOOLEAN Diff_process_date_last_seen;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_file_number;
    BOOLEAN Diff_segment_code;
    BOOLEAN Diff_sequence_number;
    BOOLEAN Diff_sic_1_code;
    BOOLEAN Diff_sic_1_desc;
    BOOLEAN Diff_sic_2_code;
    BOOLEAN Diff_sic_2_desc;
    BOOLEAN Diff_sic_3_code;
    BOOLEAN Diff_sic_3_desc;
    BOOLEAN Diff_sic_4_code;
    BOOLEAN Diff_sic_4_desc;
    BOOLEAN Diff_yrs_in_bus_actual;
    BOOLEAN Diff_sales_actual;
    BOOLEAN Diff_empl_size_actual;
    BOOLEAN Diff_bus_type_code;
    BOOLEAN Diff_bus_type_desc;
    BOOLEAN Diff_owner_type_code;
    BOOLEAN Diff_owner_type_desc;
    BOOLEAN Diff_location_code;
    BOOLEAN Diff_location_desc;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_powid := le.powid <> ri.powid;
    SELF.Diff_proxid := le.proxid <> ri.proxid;
    SELF.Diff_seleid := le.seleid <> ri.seleid;
    SELF.Diff_orgid := le.orgid <> ri.orgid;
    SELF.Diff_ultid := le.ultid <> ri.ultid;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_date_first_seen := le.date_first_seen <> ri.date_first_seen;
    SELF.Diff_date_last_seen := le.date_last_seen <> ri.date_last_seen;
    SELF.Diff_process_date_first_seen := le.process_date_first_seen <> ri.process_date_first_seen;
    SELF.Diff_process_date_last_seen := le.process_date_last_seen <> ri.process_date_last_seen;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_file_number := le.file_number <> ri.file_number;
    SELF.Diff_segment_code := le.segment_code <> ri.segment_code;
    SELF.Diff_sequence_number := le.sequence_number <> ri.sequence_number;
    SELF.Diff_sic_1_code := le.sic_1_code <> ri.sic_1_code;
    SELF.Diff_sic_1_desc := le.sic_1_desc <> ri.sic_1_desc;
    SELF.Diff_sic_2_code := le.sic_2_code <> ri.sic_2_code;
    SELF.Diff_sic_2_desc := le.sic_2_desc <> ri.sic_2_desc;
    SELF.Diff_sic_3_code := le.sic_3_code <> ri.sic_3_code;
    SELF.Diff_sic_3_desc := le.sic_3_desc <> ri.sic_3_desc;
    SELF.Diff_sic_4_code := le.sic_4_code <> ri.sic_4_code;
    SELF.Diff_sic_4_desc := le.sic_4_desc <> ri.sic_4_desc;
    SELF.Diff_yrs_in_bus_actual := le.yrs_in_bus_actual <> ri.yrs_in_bus_actual;
    SELF.Diff_sales_actual := le.sales_actual <> ri.sales_actual;
    SELF.Diff_empl_size_actual := le.empl_size_actual <> ri.empl_size_actual;
    SELF.Diff_bus_type_code := le.bus_type_code <> ri.bus_type_code;
    SELF.Diff_bus_type_desc := le.bus_type_desc <> ri.bus_type_desc;
    SELF.Diff_owner_type_code := le.owner_type_code <> ri.owner_type_code;
    SELF.Diff_owner_type_desc := le.owner_type_desc <> ri.owner_type_desc;
    SELF.Diff_location_code := le.location_code <> ri.location_code;
    SELF.Diff_location_desc := le.location_desc <> ri.location_desc;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_process_date_first_seen,1,0)+ IF( SELF.Diff_process_date_last_seen,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_file_number,1,0)+ IF( SELF.Diff_segment_code,1,0)+ IF( SELF.Diff_sequence_number,1,0)+ IF( SELF.Diff_sic_1_code,1,0)+ IF( SELF.Diff_sic_1_desc,1,0)+ IF( SELF.Diff_sic_2_code,1,0)+ IF( SELF.Diff_sic_2_desc,1,0)+ IF( SELF.Diff_sic_3_code,1,0)+ IF( SELF.Diff_sic_3_desc,1,0)+ IF( SELF.Diff_sic_4_code,1,0)+ IF( SELF.Diff_sic_4_desc,1,0)+ IF( SELF.Diff_yrs_in_bus_actual,1,0)+ IF( SELF.Diff_sales_actual,1,0)+ IF( SELF.Diff_empl_size_actual,1,0)+ IF( SELF.Diff_bus_type_code,1,0)+ IF( SELF.Diff_bus_type_desc,1,0)+ IF( SELF.Diff_owner_type_code,1,0)+ IF( SELF.Diff_owner_type_desc,1,0)+ IF( SELF.Diff_location_code,1,0)+ IF( SELF.Diff_location_desc,1,0);
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
    Count_Diff_powid := COUNT(GROUP,%Closest%.Diff_powid);
    Count_Diff_proxid := COUNT(GROUP,%Closest%.Diff_proxid);
    Count_Diff_seleid := COUNT(GROUP,%Closest%.Diff_seleid);
    Count_Diff_orgid := COUNT(GROUP,%Closest%.Diff_orgid);
    Count_Diff_ultid := COUNT(GROUP,%Closest%.Diff_ultid);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_date_first_seen := COUNT(GROUP,%Closest%.Diff_date_first_seen);
    Count_Diff_date_last_seen := COUNT(GROUP,%Closest%.Diff_date_last_seen);
    Count_Diff_process_date_first_seen := COUNT(GROUP,%Closest%.Diff_process_date_first_seen);
    Count_Diff_process_date_last_seen := COUNT(GROUP,%Closest%.Diff_process_date_last_seen);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_file_number := COUNT(GROUP,%Closest%.Diff_file_number);
    Count_Diff_segment_code := COUNT(GROUP,%Closest%.Diff_segment_code);
    Count_Diff_sequence_number := COUNT(GROUP,%Closest%.Diff_sequence_number);
    Count_Diff_sic_1_code := COUNT(GROUP,%Closest%.Diff_sic_1_code);
    Count_Diff_sic_1_desc := COUNT(GROUP,%Closest%.Diff_sic_1_desc);
    Count_Diff_sic_2_code := COUNT(GROUP,%Closest%.Diff_sic_2_code);
    Count_Diff_sic_2_desc := COUNT(GROUP,%Closest%.Diff_sic_2_desc);
    Count_Diff_sic_3_code := COUNT(GROUP,%Closest%.Diff_sic_3_code);
    Count_Diff_sic_3_desc := COUNT(GROUP,%Closest%.Diff_sic_3_desc);
    Count_Diff_sic_4_code := COUNT(GROUP,%Closest%.Diff_sic_4_code);
    Count_Diff_sic_4_desc := COUNT(GROUP,%Closest%.Diff_sic_4_desc);
    Count_Diff_yrs_in_bus_actual := COUNT(GROUP,%Closest%.Diff_yrs_in_bus_actual);
    Count_Diff_sales_actual := COUNT(GROUP,%Closest%.Diff_sales_actual);
    Count_Diff_empl_size_actual := COUNT(GROUP,%Closest%.Diff_empl_size_actual);
    Count_Diff_bus_type_code := COUNT(GROUP,%Closest%.Diff_bus_type_code);
    Count_Diff_bus_type_desc := COUNT(GROUP,%Closest%.Diff_bus_type_desc);
    Count_Diff_owner_type_code := COUNT(GROUP,%Closest%.Diff_owner_type_code);
    Count_Diff_owner_type_desc := COUNT(GROUP,%Closest%.Diff_owner_type_desc);
    Count_Diff_location_code := COUNT(GROUP,%Closest%.Diff_location_code);
    Count_Diff_location_desc := COUNT(GROUP,%Closest%.Diff_location_desc);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
