IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_CA_San_Diego_Fields := MODULE
 
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
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'FILE_NUMBER','FILE_DATE','PREV_FILE_NUMBER','PREV_FILE_DATE','FILING_TYPE','BUSINESS_NAME','prep_addr_line1','prep_addr_line_last');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'FILE_NUMBER','FILE_DATE','PREV_FILE_NUMBER','PREV_FILE_DATE','FILING_TYPE','BUSINESS_NAME','prep_addr_line1','prep_addr_line_last');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'FILE_NUMBER' => 0,'FILE_DATE' => 1,'PREV_FILE_NUMBER' => 2,'PREV_FILE_DATE' => 3,'FILING_TYPE' => 4,'BUSINESS_NAME' => 5,'prep_addr_line1' => 6,'prep_addr_line_last' => 7,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['LENGTHS'],['CUSTOM'],['LENGTHS'],['CUSTOM'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_FILE_NUMBER(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_FILE_NUMBER(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_FILE_NUMBER(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_FILE_DATE(SALT311.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_FILE_DATE(SALT311.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_FILE_DATE(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_PREV_FILE_NUMBER(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_PREV_FILE_NUMBER(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_PREV_FILE_NUMBER(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_PREV_FILE_DATE(SALT311.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_PREV_FILE_DATE(SALT311.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_PREV_FILE_DATE(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_FILING_TYPE(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_FILING_TYPE(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_FILING_TYPE(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_BUSINESS_NAME(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_BUSINESS_NAME(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_BUSINESS_NAME(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_addr_line1(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr_line1(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr_line1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_addr_line_last(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr_line_last(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr_line_last(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
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
    BOOLEAN Diff_FILE_DATE;
    BOOLEAN Diff_PREV_FILE_NUMBER;
    BOOLEAN Diff_PREV_FILE_DATE;
    BOOLEAN Diff_FILING_TYPE;
    BOOLEAN Diff_BUSINESS_NAME;
    BOOLEAN Diff_prep_addr_line1;
    BOOLEAN Diff_prep_addr_line_last;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_FILE_NUMBER := le.FILE_NUMBER <> ri.FILE_NUMBER;
    SELF.Diff_FILE_DATE := le.FILE_DATE <> ri.FILE_DATE;
    SELF.Diff_PREV_FILE_NUMBER := le.PREV_FILE_NUMBER <> ri.PREV_FILE_NUMBER;
    SELF.Diff_PREV_FILE_DATE := le.PREV_FILE_DATE <> ri.PREV_FILE_DATE;
    SELF.Diff_FILING_TYPE := le.FILING_TYPE <> ri.FILING_TYPE;
    SELF.Diff_BUSINESS_NAME := le.BUSINESS_NAME <> ri.BUSINESS_NAME;
    SELF.Diff_prep_addr_line1 := le.prep_addr_line1 <> ri.prep_addr_line1;
    SELF.Diff_prep_addr_line_last := le.prep_addr_line_last <> ri.prep_addr_line_last;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_FILE_NUMBER,1,0)+ IF( SELF.Diff_FILE_DATE,1,0)+ IF( SELF.Diff_PREV_FILE_NUMBER,1,0)+ IF( SELF.Diff_PREV_FILE_DATE,1,0)+ IF( SELF.Diff_FILING_TYPE,1,0)+ IF( SELF.Diff_BUSINESS_NAME,1,0)+ IF( SELF.Diff_prep_addr_line1,1,0)+ IF( SELF.Diff_prep_addr_line_last,1,0);
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
    Count_Diff_FILE_DATE := COUNT(GROUP,%Closest%.Diff_FILE_DATE);
    Count_Diff_PREV_FILE_NUMBER := COUNT(GROUP,%Closest%.Diff_PREV_FILE_NUMBER);
    Count_Diff_PREV_FILE_DATE := COUNT(GROUP,%Closest%.Diff_PREV_FILE_DATE);
    Count_Diff_FILING_TYPE := COUNT(GROUP,%Closest%.Diff_FILING_TYPE);
    Count_Diff_BUSINESS_NAME := COUNT(GROUP,%Closest%.Diff_BUSINESS_NAME);
    Count_Diff_prep_addr_line1 := COUNT(GROUP,%Closest%.Diff_prep_addr_line1);
    Count_Diff_prep_addr_line_last := COUNT(GROUP,%Closest%.Diff_prep_addr_line_last);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
