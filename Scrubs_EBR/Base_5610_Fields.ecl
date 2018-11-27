﻿IMPORT SALT311;
IMPORT Scrubs_EBR; // Import modules for FieldTypes attribute definitions
EXPORT Base_5610_Fields := MODULE
 
EXPORT NumFields := 26;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_numeric','invalid_numeric_or_allzeros','invalid_pastdate','invalid_dt_first_seen','invalid_record_type','invalid_segment','invalid_file_number');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_numeric' => 2,'invalid_numeric_or_allzeros' => 3,'invalid_pastdate' => 4,'invalid_dt_first_seen' => 5,'invalid_record_type' => 6,'invalid_segment' => 7,'invalid_file_number' => 8,0);
 
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
EXPORT InValidFT_invalid_segment(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['5610','5610']);
EXPORT InValidMessageFT_invalid_segment(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('5610|5610'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_file_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_file_number(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~(LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_file_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT311.HygieneErrors.NotLength('9'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','did','ssn','process_date','file_number','segment_code','sequence_number','officer_title','officer_first_name','officer_m_i','officer_last_name','clean_officer_name_title','clean_officer_name_fname','clean_officer_name_mname','clean_officer_name_lname','clean_officer_name_name_suffix');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','did','ssn','process_date','file_number','segment_code','sequence_number','officer_title','officer_first_name','officer_m_i','officer_last_name','clean_officer_name_title','clean_officer_name_fname','clean_officer_name_mname','clean_officer_name_lname','clean_officer_name_name_suffix');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'powid' => 0,'proxid' => 1,'seleid' => 2,'orgid' => 3,'ultid' => 4,'bdid' => 5,'date_first_seen' => 6,'date_last_seen' => 7,'process_date_first_seen' => 8,'process_date_last_seen' => 9,'record_type' => 10,'did' => 11,'ssn' => 12,'process_date' => 13,'file_number' => 14,'segment_code' => 15,'sequence_number' => 16,'officer_title' => 17,'officer_first_name' => 18,'officer_m_i' => 19,'officer_last_name' => 20,'clean_officer_name_title' => 21,'clean_officer_name_fname' => 22,'clean_officer_name_mname' => 23,'clean_officer_name_lname' => 24,'clean_officer_name_name_suffix' => 25,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW','LENGTHS'],['ENUM'],['CUSTOM'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
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
 
EXPORT Make_did(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_did(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_ssn(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_ssn(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_ssn(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
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
 
EXPORT Make_officer_title(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_officer_title(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_officer_title(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_officer_first_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_officer_first_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_officer_first_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_officer_m_i(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_officer_m_i(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_officer_m_i(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_officer_last_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_officer_last_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_officer_last_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_clean_officer_name_title(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_clean_officer_name_title(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_clean_officer_name_title(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_clean_officer_name_fname(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_clean_officer_name_fname(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_clean_officer_name_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_clean_officer_name_mname(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_clean_officer_name_mname(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_clean_officer_name_mname(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_clean_officer_name_lname(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_clean_officer_name_lname(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_clean_officer_name_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_clean_officer_name_name_suffix(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_clean_officer_name_name_suffix(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_clean_officer_name_name_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
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
    BOOLEAN Diff_did;
    BOOLEAN Diff_ssn;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_file_number;
    BOOLEAN Diff_segment_code;
    BOOLEAN Diff_sequence_number;
    BOOLEAN Diff_officer_title;
    BOOLEAN Diff_officer_first_name;
    BOOLEAN Diff_officer_m_i;
    BOOLEAN Diff_officer_last_name;
    BOOLEAN Diff_clean_officer_name_title;
    BOOLEAN Diff_clean_officer_name_fname;
    BOOLEAN Diff_clean_officer_name_mname;
    BOOLEAN Diff_clean_officer_name_lname;
    BOOLEAN Diff_clean_officer_name_name_suffix;
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
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_ssn := le.ssn <> ri.ssn;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_file_number := le.file_number <> ri.file_number;
    SELF.Diff_segment_code := le.segment_code <> ri.segment_code;
    SELF.Diff_sequence_number := le.sequence_number <> ri.sequence_number;
    SELF.Diff_officer_title := le.officer_title <> ri.officer_title;
    SELF.Diff_officer_first_name := le.officer_first_name <> ri.officer_first_name;
    SELF.Diff_officer_m_i := le.officer_m_i <> ri.officer_m_i;
    SELF.Diff_officer_last_name := le.officer_last_name <> ri.officer_last_name;
    SELF.Diff_clean_officer_name_title := le.clean_officer_name_title <> ri.clean_officer_name_title;
    SELF.Diff_clean_officer_name_fname := le.clean_officer_name_fname <> ri.clean_officer_name_fname;
    SELF.Diff_clean_officer_name_mname := le.clean_officer_name_mname <> ri.clean_officer_name_mname;
    SELF.Diff_clean_officer_name_lname := le.clean_officer_name_lname <> ri.clean_officer_name_lname;
    SELF.Diff_clean_officer_name_name_suffix := le.clean_officer_name_name_suffix <> ri.clean_officer_name_name_suffix;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_process_date_first_seen,1,0)+ IF( SELF.Diff_process_date_last_seen,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_ssn,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_file_number,1,0)+ IF( SELF.Diff_segment_code,1,0)+ IF( SELF.Diff_sequence_number,1,0)+ IF( SELF.Diff_officer_title,1,0)+ IF( SELF.Diff_officer_first_name,1,0)+ IF( SELF.Diff_officer_m_i,1,0)+ IF( SELF.Diff_officer_last_name,1,0)+ IF( SELF.Diff_clean_officer_name_title,1,0)+ IF( SELF.Diff_clean_officer_name_fname,1,0)+ IF( SELF.Diff_clean_officer_name_mname,1,0)+ IF( SELF.Diff_clean_officer_name_lname,1,0)+ IF( SELF.Diff_clean_officer_name_name_suffix,1,0);
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
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_ssn := COUNT(GROUP,%Closest%.Diff_ssn);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_file_number := COUNT(GROUP,%Closest%.Diff_file_number);
    Count_Diff_segment_code := COUNT(GROUP,%Closest%.Diff_segment_code);
    Count_Diff_sequence_number := COUNT(GROUP,%Closest%.Diff_sequence_number);
    Count_Diff_officer_title := COUNT(GROUP,%Closest%.Diff_officer_title);
    Count_Diff_officer_first_name := COUNT(GROUP,%Closest%.Diff_officer_first_name);
    Count_Diff_officer_m_i := COUNT(GROUP,%Closest%.Diff_officer_m_i);
    Count_Diff_officer_last_name := COUNT(GROUP,%Closest%.Diff_officer_last_name);
    Count_Diff_clean_officer_name_title := COUNT(GROUP,%Closest%.Diff_clean_officer_name_title);
    Count_Diff_clean_officer_name_fname := COUNT(GROUP,%Closest%.Diff_clean_officer_name_fname);
    Count_Diff_clean_officer_name_mname := COUNT(GROUP,%Closest%.Diff_clean_officer_name_mname);
    Count_Diff_clean_officer_name_lname := COUNT(GROUP,%Closest%.Diff_clean_officer_name_lname);
    Count_Diff_clean_officer_name_name_suffix := COUNT(GROUP,%Closest%.Diff_clean_officer_name_name_suffix);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
