IMPORT SALT311;
EXPORT party_aka_dba_Fields := MODULE
 
EXPORT NumFields := 10;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Batch','Invalid_DBCode','Invalid_NameType','Invalid_Num');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Batch' => 1,'Invalid_DBCode' => 2,'Invalid_NameType' => 3,'Invalid_Num' => 4,0);
 
EXPORT MakeFT_Invalid_Batch(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Batch(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Invalid_Batch(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'),SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_DBCode(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_DBCode(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['N','F','P']);
EXPORT InValidMessageFT_Invalid_DBCode(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('N|F|P'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_NameType(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_NameType(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['D','A']);
EXPORT InValidMessageFT_Invalid_NameType(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('D|A'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'batch','dbcode','incident_num','party_num','name_type','first_name','middle_name','last_name','aka_dba_text','party_key');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'batch','dbcode','incident_num','party_num','name_type','first_name','middle_name','last_name','aka_dba_text','party_key');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'batch' => 0,'dbcode' => 1,'incident_num' => 2,'party_num' => 3,'name_type' => 4,'first_name' => 5,'middle_name' => 6,'last_name' => 7,'aka_dba_text' => 8,'party_key' => 9,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','LENGTHS'],['ENUM'],['ALLOW'],['ALLOW'],['ENUM'],[],[],[],[],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_batch(SALT311.StrType s0) := MakeFT_Invalid_Batch(s0);
EXPORT InValid_batch(SALT311.StrType s) := InValidFT_Invalid_Batch(s);
EXPORT InValidMessage_batch(UNSIGNED1 wh) := InValidMessageFT_Invalid_Batch(wh);
 
EXPORT Make_dbcode(SALT311.StrType s0) := MakeFT_Invalid_DBCode(s0);
EXPORT InValid_dbcode(SALT311.StrType s) := InValidFT_Invalid_DBCode(s);
EXPORT InValidMessage_dbcode(UNSIGNED1 wh) := InValidMessageFT_Invalid_DBCode(wh);
 
EXPORT Make_incident_num(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_incident_num(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_incident_num(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_party_num(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_party_num(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_party_num(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_name_type(SALT311.StrType s0) := MakeFT_Invalid_NameType(s0);
EXPORT InValid_name_type(SALT311.StrType s) := InValidFT_Invalid_NameType(s);
EXPORT InValidMessage_name_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_NameType(wh);
 
EXPORT Make_first_name(SALT311.StrType s0) := s0;
EXPORT InValid_first_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_first_name(UNSIGNED1 wh) := '';
 
EXPORT Make_middle_name(SALT311.StrType s0) := s0;
EXPORT InValid_middle_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_middle_name(UNSIGNED1 wh) := '';
 
EXPORT Make_last_name(SALT311.StrType s0) := s0;
EXPORT InValid_last_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_last_name(UNSIGNED1 wh) := '';
 
EXPORT Make_aka_dba_text(SALT311.StrType s0) := s0;
EXPORT InValid_aka_dba_text(SALT311.StrType s) := 0;
EXPORT InValidMessage_aka_dba_text(UNSIGNED1 wh) := '';
 
EXPORT Make_party_key(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_party_key(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_party_key(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_SANCTN_NPKeys;
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
    BOOLEAN Diff_name_type;
    BOOLEAN Diff_first_name;
    BOOLEAN Diff_middle_name;
    BOOLEAN Diff_last_name;
    BOOLEAN Diff_aka_dba_text;
    BOOLEAN Diff_party_key;
    SALT311.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_batch := le.batch <> ri.batch;
    SELF.Diff_dbcode := le.dbcode <> ri.dbcode;
    SELF.Diff_incident_num := le.incident_num <> ri.incident_num;
    SELF.Diff_party_num := le.party_num <> ri.party_num;
    SELF.Diff_name_type := le.name_type <> ri.name_type;
    SELF.Diff_first_name := le.first_name <> ri.first_name;
    SELF.Diff_middle_name := le.middle_name <> ri.middle_name;
    SELF.Diff_last_name := le.last_name <> ri.last_name;
    SELF.Diff_aka_dba_text := le.aka_dba_text <> ri.aka_dba_text;
    SELF.Diff_party_key := le.party_key <> ri.party_key;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.dbcode;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_batch,1,0)+ IF( SELF.Diff_dbcode,1,0)+ IF( SELF.Diff_incident_num,1,0)+ IF( SELF.Diff_party_num,1,0)+ IF( SELF.Diff_name_type,1,0)+ IF( SELF.Diff_first_name,1,0)+ IF( SELF.Diff_middle_name,1,0)+ IF( SELF.Diff_last_name,1,0)+ IF( SELF.Diff_aka_dba_text,1,0)+ IF( SELF.Diff_party_key,1,0);
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
    Count_Diff_name_type := COUNT(GROUP,%Closest%.Diff_name_type);
    Count_Diff_first_name := COUNT(GROUP,%Closest%.Diff_first_name);
    Count_Diff_middle_name := COUNT(GROUP,%Closest%.Diff_middle_name);
    Count_Diff_last_name := COUNT(GROUP,%Closest%.Diff_last_name);
    Count_Diff_aka_dba_text := COUNT(GROUP,%Closest%.Diff_aka_dba_text);
    Count_Diff_party_key := COUNT(GROUP,%Closest%.Diff_party_key);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;
