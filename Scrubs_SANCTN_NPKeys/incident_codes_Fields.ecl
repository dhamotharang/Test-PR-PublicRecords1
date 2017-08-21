IMPORT ut,SALT33;
IMPORT Scrubs,Scrubs_SANCTN_NPKeys; // Import modules for FieldTypes attribute definitions
EXPORT incident_codes_Fields := MODULE
// Processing for each FieldType
EXPORT SALT33.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Batch','Invalid_Licence','Invalid_DBCode','Invalid_Num','Invalid_Field','Invalid_State','Invalid_LicenceCode','Invalid_ProfessionCode');
EXPORT FieldTypeNum(SALT33.StrType fn) := CASE(fn,'Invalid_Batch' => 1,'Invalid_Licence' => 2,'Invalid_DBCode' => 3,'Invalid_Num' => 4,'Invalid_Field' => 5,'Invalid_State' => 6,'Invalid_LicenceCode' => 7,'Invalid_ProfessionCode' => 8,0);
EXPORT MakeFT_Invalid_Batch(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Batch(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Invalid_Batch(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'),SALT33.HygieneErrors.NotLength('1..'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_Licence(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Licence(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'))));
EXPORT InValidMessageFT_Invalid_Licence(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_DBCode(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_DBCode(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['N','F']);
EXPORT InValidMessageFT_Invalid_DBCode(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('N|F'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_Num(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_Field(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Field(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['LICENSECODE','INTERNALCODE','PROFESSIONCODE','']);
EXPORT InValidMessageFT_Invalid_Field(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('LICENSECODE|INTERNALCODE|PROFESSIONCODE|'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_State(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_State(SALT33.StrType s) := WHICH(~Scrubs.fn_Valid_StateAbbrev(s)>0);
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.CustomFail('Scrubs.fn_Valid_StateAbbrev'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_LicenceCode(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_LicenceCode(SALT33.StrType s,SALT33.StrType field_name) := WHICH(~Scrubs_SANCTN_NPKeys.fn_CodeCheck_Licence(s,field_name)>0);
EXPORT InValidMessageFT_Invalid_LicenceCode(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.CustomFail('Scrubs_SANCTN_NPKeys.fn_CodeCheck_Licence'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_Invalid_ProfessionCode(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_ProfessionCode(SALT33.StrType s,SALT33.StrType field_name) := WHICH(~Scrubs_SANCTN_NPKeys.fn_CodeCheck_Professional(s,field_name)>0);
EXPORT InValidMessageFT_Invalid_ProfessionCode(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.CustomFail('Scrubs_SANCTN_NPKeys.fn_CodeCheck_Professional'),SALT33.HygieneErrors.Good);
EXPORT SALT33.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'batch','dbcode','primary_key','foreign_key','incident_num','number','field_name','code_type','code_value','code_state','other_desc','std_type_desc','cln_license_number');
EXPORT FieldNum(SALT33.StrType fn) := CASE(fn,'batch' => 0,'dbcode' => 1,'primary_key' => 2,'foreign_key' => 3,'incident_num' => 4,'number' => 5,'field_name' => 6,'code_type' => 7,'code_value' => 8,'code_state' => 9,'other_desc' => 10,'std_type_desc' => 11,'cln_license_number' => 12,0);
//Individual field level validation
EXPORT Make_batch(SALT33.StrType s0) := MakeFT_Invalid_Batch(s0);
EXPORT InValid_batch(SALT33.StrType s) := InValidFT_Invalid_Batch(s);
EXPORT InValidMessage_batch(UNSIGNED1 wh) := InValidMessageFT_Invalid_Batch(wh);
EXPORT Make_dbcode(SALT33.StrType s0) := MakeFT_Invalid_DBCode(s0);
EXPORT InValid_dbcode(SALT33.StrType s) := InValidFT_Invalid_DBCode(s);
EXPORT InValidMessage_dbcode(UNSIGNED1 wh) := InValidMessageFT_Invalid_DBCode(wh);
EXPORT Make_primary_key(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_primary_key(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_primary_key(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_foreign_key(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_foreign_key(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_foreign_key(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_incident_num(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_incident_num(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_incident_num(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_number(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_number(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_field_name(SALT33.StrType s0) := MakeFT_Invalid_Field(s0);
EXPORT InValid_field_name(SALT33.StrType s) := InValidFT_Invalid_Field(s);
EXPORT InValidMessage_field_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Field(wh);
EXPORT Make_code_type(SALT33.StrType s0) := MakeFT_Invalid_LicenceCode(s0);
EXPORT InValid_code_type(SALT33.StrType s,SALT33.StrType field_name) := InValidFT_Invalid_LicenceCode(s,field_name);
EXPORT InValidMessage_code_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_LicenceCode(wh);
EXPORT Make_code_value(SALT33.StrType s0) := MakeFT_Invalid_ProfessionCode(s0);
EXPORT InValid_code_value(SALT33.StrType s,SALT33.StrType field_name) := InValidFT_Invalid_ProfessionCode(s,field_name);
EXPORT InValidMessage_code_value(UNSIGNED1 wh) := InValidMessageFT_Invalid_ProfessionCode(wh);
EXPORT Make_code_state(SALT33.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_code_state(SALT33.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_code_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
EXPORT Make_other_desc(SALT33.StrType s0) := s0;
EXPORT InValid_other_desc(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_other_desc(UNSIGNED1 wh) := '';
EXPORT Make_std_type_desc(SALT33.StrType s0) := s0;
EXPORT InValid_std_type_desc(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_std_type_desc(UNSIGNED1 wh) := '';
EXPORT Make_cln_license_number(SALT33.StrType s0) := MakeFT_Invalid_Licence(s0);
EXPORT InValid_cln_license_number(SALT33.StrType s) := InValidFT_Invalid_Licence(s);
EXPORT InValidMessage_cln_license_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Licence(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT33,Scrubs_SANCTN_NPKeys;
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
    BOOLEAN Diff_batch;
    BOOLEAN Diff_dbcode;
    BOOLEAN Diff_primary_key;
    BOOLEAN Diff_foreign_key;
    BOOLEAN Diff_incident_num;
    BOOLEAN Diff_number;
    BOOLEAN Diff_field_name;
    BOOLEAN Diff_code_type;
    BOOLEAN Diff_code_value;
    BOOLEAN Diff_code_state;
    BOOLEAN Diff_other_desc;
    BOOLEAN Diff_std_type_desc;
    BOOLEAN Diff_cln_license_number;
    SALT33.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT33.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_batch := le.batch <> ri.batch;
    SELF.Diff_dbcode := le.dbcode <> ri.dbcode;
    SELF.Diff_primary_key := le.primary_key <> ri.primary_key;
    SELF.Diff_foreign_key := le.foreign_key <> ri.foreign_key;
    SELF.Diff_incident_num := le.incident_num <> ri.incident_num;
    SELF.Diff_number := le.number <> ri.number;
    SELF.Diff_field_name := le.field_name <> ri.field_name;
    SELF.Diff_code_type := le.code_type <> ri.code_type;
    SELF.Diff_code_value := le.code_value <> ri.code_value;
    SELF.Diff_code_state := le.code_state <> ri.code_state;
    SELF.Diff_other_desc := le.other_desc <> ri.other_desc;
    SELF.Diff_std_type_desc := le.std_type_desc <> ri.std_type_desc;
    SELF.Diff_cln_license_number := le.cln_license_number <> ri.cln_license_number;
    SELF.Val := (SALT33.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.dbcode;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_batch,1,0)+ IF( SELF.Diff_dbcode,1,0)+ IF( SELF.Diff_primary_key,1,0)+ IF( SELF.Diff_foreign_key,1,0)+ IF( SELF.Diff_incident_num,1,0)+ IF( SELF.Diff_number,1,0)+ IF( SELF.Diff_field_name,1,0)+ IF( SELF.Diff_code_type,1,0)+ IF( SELF.Diff_code_value,1,0)+ IF( SELF.Diff_code_state,1,0)+ IF( SELF.Diff_other_desc,1,0)+ IF( SELF.Diff_std_type_desc,1,0)+ IF( SELF.Diff_cln_license_number,1,0);
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
    Count_Diff_batch := COUNT(GROUP,%Closest%.Diff_batch);
    Count_Diff_dbcode := COUNT(GROUP,%Closest%.Diff_dbcode);
    Count_Diff_primary_key := COUNT(GROUP,%Closest%.Diff_primary_key);
    Count_Diff_foreign_key := COUNT(GROUP,%Closest%.Diff_foreign_key);
    Count_Diff_incident_num := COUNT(GROUP,%Closest%.Diff_incident_num);
    Count_Diff_number := COUNT(GROUP,%Closest%.Diff_number);
    Count_Diff_field_name := COUNT(GROUP,%Closest%.Diff_field_name);
    Count_Diff_code_type := COUNT(GROUP,%Closest%.Diff_code_type);
    Count_Diff_code_value := COUNT(GROUP,%Closest%.Diff_code_value);
    Count_Diff_code_state := COUNT(GROUP,%Closest%.Diff_code_state);
    Count_Diff_other_desc := COUNT(GROUP,%Closest%.Diff_other_desc);
    Count_Diff_std_type_desc := COUNT(GROUP,%Closest%.Diff_std_type_desc);
    Count_Diff_cln_license_number := COUNT(GROUP,%Closest%.Diff_cln_license_number);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;
