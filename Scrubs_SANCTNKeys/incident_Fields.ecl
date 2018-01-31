IMPORT SALT38;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT incident_Fields := MODULE
 
EXPORT NumFields := 23;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Batch','Invalid_Num','Invalid_Date','Invalid_CleanDate');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'Invalid_Batch' => 1,'Invalid_Num' => 2,'Invalid_Date' => 3,'Invalid_CleanDate' => 4,0);
 
EXPORT MakeFT_Invalid_Batch(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Batch(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Invalid_Batch(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_'),SALT38.HygieneErrors.NotLength('1..'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Num(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789/'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Date(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789/'))));
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789/'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_CleanDate(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_CleanDate(SALT38.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_CleanDate(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'batch_number','incident_number','party_number','record_type','order_number','ag_code','case_number','incident_date','jurisdiction','source_document','additional_info','agency','alleged_amount','estimated_loss','fcr_date','ok_for_fcr','modified_date','load_date','incident_text','incident_date_clean','fcr_date_clean','cln_modified_date','cln_load_date');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'batch_number','incident_number','party_number','record_type','order_number','ag_code','case_number','incident_date','jurisdiction','source_document','additional_info','agency','alleged_amount','estimated_loss','fcr_date','ok_for_fcr','modified_date','load_date','incident_text','incident_date_clean','fcr_date_clean','cln_modified_date','cln_load_date');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'batch_number' => 0,'incident_number' => 1,'party_number' => 2,'record_type' => 3,'order_number' => 4,'ag_code' => 5,'case_number' => 6,'incident_date' => 7,'jurisdiction' => 8,'source_document' => 9,'additional_info' => 10,'agency' => 11,'alleged_amount' => 12,'estimated_loss' => 13,'fcr_date' => 14,'ok_for_fcr' => 15,'modified_date' => 16,'load_date' => 17,'incident_text' => 18,'incident_date_clean' => 19,'fcr_date_clean' => 20,'cln_modified_date' => 21,'cln_load_date' => 22,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','LENGTH'],['ALLOW'],['ALLOW'],[],['ALLOW'],[],[],['ALLOW'],[],[],[],[],[],[],['ALLOW'],[],['ALLOW'],['ALLOW'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_batch_number(SALT38.StrType s0) := MakeFT_Invalid_Batch(s0);
EXPORT InValid_batch_number(SALT38.StrType s) := InValidFT_Invalid_Batch(s);
EXPORT InValidMessage_batch_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Batch(wh);
 
EXPORT Make_incident_number(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_incident_number(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_incident_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_party_number(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_party_number(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_party_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_record_type(SALT38.StrType s0) := s0;
EXPORT InValid_record_type(SALT38.StrType s) := 0;
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := '';
 
EXPORT Make_order_number(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_order_number(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_order_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_ag_code(SALT38.StrType s0) := s0;
EXPORT InValid_ag_code(SALT38.StrType s) := 0;
EXPORT InValidMessage_ag_code(UNSIGNED1 wh) := '';
 
EXPORT Make_case_number(SALT38.StrType s0) := s0;
EXPORT InValid_case_number(SALT38.StrType s) := 0;
EXPORT InValidMessage_case_number(UNSIGNED1 wh) := '';
 
EXPORT Make_incident_date(SALT38.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_incident_date(SALT38.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_incident_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_jurisdiction(SALT38.StrType s0) := s0;
EXPORT InValid_jurisdiction(SALT38.StrType s) := 0;
EXPORT InValidMessage_jurisdiction(UNSIGNED1 wh) := '';
 
EXPORT Make_source_document(SALT38.StrType s0) := s0;
EXPORT InValid_source_document(SALT38.StrType s) := 0;
EXPORT InValidMessage_source_document(UNSIGNED1 wh) := '';
 
EXPORT Make_additional_info(SALT38.StrType s0) := s0;
EXPORT InValid_additional_info(SALT38.StrType s) := 0;
EXPORT InValidMessage_additional_info(UNSIGNED1 wh) := '';
 
EXPORT Make_agency(SALT38.StrType s0) := s0;
EXPORT InValid_agency(SALT38.StrType s) := 0;
EXPORT InValidMessage_agency(UNSIGNED1 wh) := '';
 
EXPORT Make_alleged_amount(SALT38.StrType s0) := s0;
EXPORT InValid_alleged_amount(SALT38.StrType s) := 0;
EXPORT InValidMessage_alleged_amount(UNSIGNED1 wh) := '';
 
EXPORT Make_estimated_loss(SALT38.StrType s0) := s0;
EXPORT InValid_estimated_loss(SALT38.StrType s) := 0;
EXPORT InValidMessage_estimated_loss(UNSIGNED1 wh) := '';
 
EXPORT Make_fcr_date(SALT38.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_fcr_date(SALT38.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_fcr_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_ok_for_fcr(SALT38.StrType s0) := s0;
EXPORT InValid_ok_for_fcr(SALT38.StrType s) := 0;
EXPORT InValidMessage_ok_for_fcr(UNSIGNED1 wh) := '';
 
EXPORT Make_modified_date(SALT38.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_modified_date(SALT38.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_modified_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_load_date(SALT38.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_load_date(SALT38.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_load_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_incident_text(SALT38.StrType s0) := s0;
EXPORT InValid_incident_text(SALT38.StrType s) := 0;
EXPORT InValidMessage_incident_text(UNSIGNED1 wh) := '';
 
EXPORT Make_incident_date_clean(SALT38.StrType s0) := MakeFT_Invalid_CleanDate(s0);
EXPORT InValid_incident_date_clean(SALT38.StrType s) := InValidFT_Invalid_CleanDate(s);
EXPORT InValidMessage_incident_date_clean(UNSIGNED1 wh) := InValidMessageFT_Invalid_CleanDate(wh);
 
EXPORT Make_fcr_date_clean(SALT38.StrType s0) := MakeFT_Invalid_CleanDate(s0);
EXPORT InValid_fcr_date_clean(SALT38.StrType s) := InValidFT_Invalid_CleanDate(s);
EXPORT InValidMessage_fcr_date_clean(UNSIGNED1 wh) := InValidMessageFT_Invalid_CleanDate(wh);
 
EXPORT Make_cln_modified_date(SALT38.StrType s0) := MakeFT_Invalid_CleanDate(s0);
EXPORT InValid_cln_modified_date(SALT38.StrType s) := InValidFT_Invalid_CleanDate(s);
EXPORT InValidMessage_cln_modified_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_CleanDate(wh);
 
EXPORT Make_cln_load_date(SALT38.StrType s0) := MakeFT_Invalid_CleanDate(s0);
EXPORT InValid_cln_load_date(SALT38.StrType s) := InValidFT_Invalid_CleanDate(s);
EXPORT InValidMessage_cln_load_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_CleanDate(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_SANCTNKeys;
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
    BOOLEAN Diff_batch_number;
    BOOLEAN Diff_incident_number;
    BOOLEAN Diff_party_number;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_order_number;
    BOOLEAN Diff_ag_code;
    BOOLEAN Diff_case_number;
    BOOLEAN Diff_incident_date;
    BOOLEAN Diff_jurisdiction;
    BOOLEAN Diff_source_document;
    BOOLEAN Diff_additional_info;
    BOOLEAN Diff_agency;
    BOOLEAN Diff_alleged_amount;
    BOOLEAN Diff_estimated_loss;
    BOOLEAN Diff_fcr_date;
    BOOLEAN Diff_ok_for_fcr;
    BOOLEAN Diff_modified_date;
    BOOLEAN Diff_load_date;
    BOOLEAN Diff_incident_text;
    BOOLEAN Diff_incident_date_clean;
    BOOLEAN Diff_fcr_date_clean;
    BOOLEAN Diff_cln_modified_date;
    BOOLEAN Diff_cln_load_date;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_batch_number := le.batch_number <> ri.batch_number;
    SELF.Diff_incident_number := le.incident_number <> ri.incident_number;
    SELF.Diff_party_number := le.party_number <> ri.party_number;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_order_number := le.order_number <> ri.order_number;
    SELF.Diff_ag_code := le.ag_code <> ri.ag_code;
    SELF.Diff_case_number := le.case_number <> ri.case_number;
    SELF.Diff_incident_date := le.incident_date <> ri.incident_date;
    SELF.Diff_jurisdiction := le.jurisdiction <> ri.jurisdiction;
    SELF.Diff_source_document := le.source_document <> ri.source_document;
    SELF.Diff_additional_info := le.additional_info <> ri.additional_info;
    SELF.Diff_agency := le.agency <> ri.agency;
    SELF.Diff_alleged_amount := le.alleged_amount <> ri.alleged_amount;
    SELF.Diff_estimated_loss := le.estimated_loss <> ri.estimated_loss;
    SELF.Diff_fcr_date := le.fcr_date <> ri.fcr_date;
    SELF.Diff_ok_for_fcr := le.ok_for_fcr <> ri.ok_for_fcr;
    SELF.Diff_modified_date := le.modified_date <> ri.modified_date;
    SELF.Diff_load_date := le.load_date <> ri.load_date;
    SELF.Diff_incident_text := le.incident_text <> ri.incident_text;
    SELF.Diff_incident_date_clean := le.incident_date_clean <> ri.incident_date_clean;
    SELF.Diff_fcr_date_clean := le.fcr_date_clean <> ri.fcr_date_clean;
    SELF.Diff_cln_modified_date := le.cln_modified_date <> ri.cln_modified_date;
    SELF.Diff_cln_load_date := le.cln_load_date <> ri.cln_load_date;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_batch_number,1,0)+ IF( SELF.Diff_incident_number,1,0)+ IF( SELF.Diff_party_number,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_order_number,1,0)+ IF( SELF.Diff_ag_code,1,0)+ IF( SELF.Diff_case_number,1,0)+ IF( SELF.Diff_incident_date,1,0)+ IF( SELF.Diff_jurisdiction,1,0)+ IF( SELF.Diff_source_document,1,0)+ IF( SELF.Diff_additional_info,1,0)+ IF( SELF.Diff_agency,1,0)+ IF( SELF.Diff_alleged_amount,1,0)+ IF( SELF.Diff_estimated_loss,1,0)+ IF( SELF.Diff_fcr_date,1,0)+ IF( SELF.Diff_ok_for_fcr,1,0)+ IF( SELF.Diff_modified_date,1,0)+ IF( SELF.Diff_load_date,1,0)+ IF( SELF.Diff_incident_text,1,0)+ IF( SELF.Diff_incident_date_clean,1,0)+ IF( SELF.Diff_fcr_date_clean,1,0)+ IF( SELF.Diff_cln_modified_date,1,0)+ IF( SELF.Diff_cln_load_date,1,0);
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
    Count_Diff_batch_number := COUNT(GROUP,%Closest%.Diff_batch_number);
    Count_Diff_incident_number := COUNT(GROUP,%Closest%.Diff_incident_number);
    Count_Diff_party_number := COUNT(GROUP,%Closest%.Diff_party_number);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_order_number := COUNT(GROUP,%Closest%.Diff_order_number);
    Count_Diff_ag_code := COUNT(GROUP,%Closest%.Diff_ag_code);
    Count_Diff_case_number := COUNT(GROUP,%Closest%.Diff_case_number);
    Count_Diff_incident_date := COUNT(GROUP,%Closest%.Diff_incident_date);
    Count_Diff_jurisdiction := COUNT(GROUP,%Closest%.Diff_jurisdiction);
    Count_Diff_source_document := COUNT(GROUP,%Closest%.Diff_source_document);
    Count_Diff_additional_info := COUNT(GROUP,%Closest%.Diff_additional_info);
    Count_Diff_agency := COUNT(GROUP,%Closest%.Diff_agency);
    Count_Diff_alleged_amount := COUNT(GROUP,%Closest%.Diff_alleged_amount);
    Count_Diff_estimated_loss := COUNT(GROUP,%Closest%.Diff_estimated_loss);
    Count_Diff_fcr_date := COUNT(GROUP,%Closest%.Diff_fcr_date);
    Count_Diff_ok_for_fcr := COUNT(GROUP,%Closest%.Diff_ok_for_fcr);
    Count_Diff_modified_date := COUNT(GROUP,%Closest%.Diff_modified_date);
    Count_Diff_load_date := COUNT(GROUP,%Closest%.Diff_load_date);
    Count_Diff_incident_text := COUNT(GROUP,%Closest%.Diff_incident_text);
    Count_Diff_incident_date_clean := COUNT(GROUP,%Closest%.Diff_incident_date_clean);
    Count_Diff_fcr_date_clean := COUNT(GROUP,%Closest%.Diff_fcr_date_clean);
    Count_Diff_cln_modified_date := COUNT(GROUP,%Closest%.Diff_cln_modified_date);
    Count_Diff_cln_load_date := COUNT(GROUP,%Closest%.Diff_cln_load_date);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
