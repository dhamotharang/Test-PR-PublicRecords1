IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_TX_Harris_Fields := MODULE
 
EXPORT NumFields := 8;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_past_date');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_past_date' => 2,0);
 
EXPORT MakeFT_invalid_mandatory(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_past_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_past_date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_pastDate(s)>0);
EXPORT InValidMessageFT_invalid_past_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'FILE_NUMBER','DATE_FILED','NAME1','NAME2','prep_addr1_line1','prep_addr1_line_last','prep_addr2_line1','prep_addr2_line_last');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'FILE_NUMBER','DATE_FILED','NAME1','NAME2','prep_addr1_line1','prep_addr1_line_last','prep_addr2_line1','prep_addr2_line_last');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'FILE_NUMBER' => 0,'DATE_FILED' => 1,'NAME1' => 2,'NAME2' => 3,'prep_addr1_line1' => 4,'prep_addr1_line_last' => 5,'prep_addr2_line1' => 6,'prep_addr2_line_last' => 7,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['LENGTHS'],['CUSTOM'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_FILE_NUMBER(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_FILE_NUMBER(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_FILE_NUMBER(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_DATE_FILED(SALT311.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_DATE_FILED(SALT311.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_DATE_FILED(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_NAME1(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_NAME1(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_NAME1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_NAME2(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_NAME2(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_NAME2(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_addr1_line1(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr1_line1(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr1_line1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_addr1_line_last(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr1_line_last(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr1_line_last(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_addr2_line1(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr2_line1(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr2_line1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_addr2_line_last(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr2_line_last(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr2_line_last(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
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
    BOOLEAN Diff_FILE_NUMBER;
    BOOLEAN Diff_DATE_FILED;
    BOOLEAN Diff_NAME1;
    BOOLEAN Diff_NAME2;
    BOOLEAN Diff_prep_addr1_line1;
    BOOLEAN Diff_prep_addr1_line_last;
    BOOLEAN Diff_prep_addr2_line1;
    BOOLEAN Diff_prep_addr2_line_last;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_FILE_NUMBER := le.FILE_NUMBER <> ri.FILE_NUMBER;
    SELF.Diff_DATE_FILED := le.DATE_FILED <> ri.DATE_FILED;
    SELF.Diff_NAME1 := le.NAME1 <> ri.NAME1;
    SELF.Diff_NAME2 := le.NAME2 <> ri.NAME2;
    SELF.Diff_prep_addr1_line1 := le.prep_addr1_line1 <> ri.prep_addr1_line1;
    SELF.Diff_prep_addr1_line_last := le.prep_addr1_line_last <> ri.prep_addr1_line_last;
    SELF.Diff_prep_addr2_line1 := le.prep_addr2_line1 <> ri.prep_addr2_line1;
    SELF.Diff_prep_addr2_line_last := le.prep_addr2_line_last <> ri.prep_addr2_line_last;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_FILE_NUMBER,1,0)+ IF( SELF.Diff_DATE_FILED,1,0)+ IF( SELF.Diff_NAME1,1,0)+ IF( SELF.Diff_NAME2,1,0)+ IF( SELF.Diff_prep_addr1_line1,1,0)+ IF( SELF.Diff_prep_addr1_line_last,1,0)+ IF( SELF.Diff_prep_addr2_line1,1,0)+ IF( SELF.Diff_prep_addr2_line_last,1,0);
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
    Count_Diff_FILE_NUMBER := COUNT(GROUP,%Closest%.Diff_FILE_NUMBER);
    Count_Diff_DATE_FILED := COUNT(GROUP,%Closest%.Diff_DATE_FILED);
    Count_Diff_NAME1 := COUNT(GROUP,%Closest%.Diff_NAME1);
    Count_Diff_NAME2 := COUNT(GROUP,%Closest%.Diff_NAME2);
    Count_Diff_prep_addr1_line1 := COUNT(GROUP,%Closest%.Diff_prep_addr1_line1);
    Count_Diff_prep_addr1_line_last := COUNT(GROUP,%Closest%.Diff_prep_addr1_line_last);
    Count_Diff_prep_addr2_line1 := COUNT(GROUP,%Closest%.Diff_prep_addr2_line1);
    Count_Diff_prep_addr2_line_last := COUNT(GROUP,%Closest%.Diff_prep_addr2_line_last);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
