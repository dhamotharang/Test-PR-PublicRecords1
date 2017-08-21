IMPORT ut,SALT33;
EXPORT party_text_Fields := MODULE
// Processing for each FieldType
EXPORT SALT33.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Batch','Invalid_DBCode','Invalid_Num','Invalid_Field');
EXPORT FieldTypeNum(SALT33.StrType fn) := CASE(fn,'Invalid_Batch' => 1,'Invalid_DBCode' => 2,'Invalid_Num' => 3,'Invalid_Field' => 4,0);
EXPORT MakeFT_Invalid_Batch(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Batch(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Invalid_Batch(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'),SALT33.HygieneErrors.NotLength('1..'),SALT33.HygieneErrors.Good);
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
EXPORT InValidFT_Invalid_Field(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['OTHERINFO','']);
EXPORT InValidMessageFT_Invalid_Field(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('OTHERINFO|'),SALT33.HygieneErrors.Good);
EXPORT SALT33.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'batch','dbcode','incident_num','party_num','seq','field_name','field_txt');
EXPORT FieldNum(SALT33.StrType fn) := CASE(fn,'batch' => 0,'dbcode' => 1,'incident_num' => 2,'party_num' => 3,'seq' => 4,'field_name' => 5,'field_txt' => 6,0);
//Individual field level validation
EXPORT Make_batch(SALT33.StrType s0) := MakeFT_Invalid_Batch(s0);
EXPORT InValid_batch(SALT33.StrType s) := InValidFT_Invalid_Batch(s);
EXPORT InValidMessage_batch(UNSIGNED1 wh) := InValidMessageFT_Invalid_Batch(wh);
EXPORT Make_dbcode(SALT33.StrType s0) := MakeFT_Invalid_DBCode(s0);
EXPORT InValid_dbcode(SALT33.StrType s) := InValidFT_Invalid_DBCode(s);
EXPORT InValidMessage_dbcode(UNSIGNED1 wh) := InValidMessageFT_Invalid_DBCode(wh);
EXPORT Make_incident_num(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_incident_num(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_incident_num(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_party_num(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_party_num(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_party_num(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_seq(SALT33.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_seq(SALT33.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_seq(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
EXPORT Make_field_name(SALT33.StrType s0) := s0;
EXPORT InValid_field_name(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_field_name(UNSIGNED1 wh) := '';
EXPORT Make_field_txt(SALT33.StrType s0) := s0;
EXPORT InValid_field_txt(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_field_txt(UNSIGNED1 wh) := '';
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
    BOOLEAN Diff_incident_num;
    BOOLEAN Diff_party_num;
    BOOLEAN Diff_seq;
    BOOLEAN Diff_field_name;
    BOOLEAN Diff_field_txt;
    SALT33.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT33.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_batch := le.batch <> ri.batch;
    SELF.Diff_dbcode := le.dbcode <> ri.dbcode;
    SELF.Diff_incident_num := le.incident_num <> ri.incident_num;
    SELF.Diff_party_num := le.party_num <> ri.party_num;
    SELF.Diff_seq := le.seq <> ri.seq;
    SELF.Diff_field_name := le.field_name <> ri.field_name;
    SELF.Diff_field_txt := le.field_txt <> ri.field_txt;
    SELF.Val := (SALT33.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.dbcode;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_batch,1,0)+ IF( SELF.Diff_dbcode,1,0)+ IF( SELF.Diff_incident_num,1,0)+ IF( SELF.Diff_party_num,1,0)+ IF( SELF.Diff_seq,1,0)+ IF( SELF.Diff_field_name,1,0)+ IF( SELF.Diff_field_txt,1,0);
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
    Count_Diff_incident_num := COUNT(GROUP,%Closest%.Diff_incident_num);
    Count_Diff_party_num := COUNT(GROUP,%Closest%.Diff_party_num);
    Count_Diff_seq := COUNT(GROUP,%Closest%.Diff_seq);
    Count_Diff_field_name := COUNT(GROUP,%Closest%.Diff_field_name);
    Count_Diff_field_txt := COUNT(GROUP,%Closest%.Diff_field_txt);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;
