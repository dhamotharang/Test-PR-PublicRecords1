IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_FL_Filing_Fields := MODULE
 
EXPORT NumFields := 12;
 
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
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'FIC_FIL_DOC_NUM','FIC_FIL_NAME','FIC_FIL_DATE','FIC_OWNER_DOC_NUM','FIC_OWNER_NAME','p_owner_name','c_owner_name','prep_addr_line1','prep_addr_line_last','prep_owner_addr_line1','prep_owner_addr_line_last','seq');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'FIC_FIL_DOC_NUM','FIC_FIL_NAME','FIC_FIL_DATE','FIC_OWNER_DOC_NUM','FIC_OWNER_NAME','p_owner_name','c_owner_name','prep_addr_line1','prep_addr_line_last','prep_owner_addr_line1','prep_owner_addr_line_last','seq');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'FIC_FIL_DOC_NUM' => 0,'FIC_FIL_NAME' => 1,'FIC_FIL_DATE' => 2,'FIC_OWNER_DOC_NUM' => 3,'FIC_OWNER_NAME' => 4,'p_owner_name' => 5,'c_owner_name' => 6,'prep_addr_line1' => 7,'prep_addr_line_last' => 8,'prep_owner_addr_line1' => 9,'prep_owner_addr_line_last' => 10,'seq' => 11,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['LENGTHS'],['LENGTHS'],['CUSTOM'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_FIC_FIL_DOC_NUM(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_FIC_FIL_DOC_NUM(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_FIC_FIL_DOC_NUM(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_FIC_FIL_NAME(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_FIC_FIL_NAME(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_FIC_FIL_NAME(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_FIC_FIL_DATE(SALT311.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_FIC_FIL_DATE(SALT311.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_FIC_FIL_DATE(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_FIC_OWNER_DOC_NUM(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_FIC_OWNER_DOC_NUM(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_FIC_OWNER_DOC_NUM(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_FIC_OWNER_NAME(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_FIC_OWNER_NAME(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_FIC_OWNER_NAME(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_p_owner_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_p_owner_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_p_owner_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_c_owner_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_c_owner_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_c_owner_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_addr_line1(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr_line1(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr_line1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_addr_line_last(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr_line_last(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr_line_last(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_owner_addr_line1(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_owner_addr_line1(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_owner_addr_line1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_owner_addr_line_last(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_owner_addr_line_last(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_owner_addr_line_last(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_seq(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_seq(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_seq(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
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
    BOOLEAN Diff_FIC_FIL_DOC_NUM;
    BOOLEAN Diff_FIC_FIL_NAME;
    BOOLEAN Diff_FIC_FIL_DATE;
    BOOLEAN Diff_FIC_OWNER_DOC_NUM;
    BOOLEAN Diff_FIC_OWNER_NAME;
    BOOLEAN Diff_p_owner_name;
    BOOLEAN Diff_c_owner_name;
    BOOLEAN Diff_prep_addr_line1;
    BOOLEAN Diff_prep_addr_line_last;
    BOOLEAN Diff_prep_owner_addr_line1;
    BOOLEAN Diff_prep_owner_addr_line_last;
    BOOLEAN Diff_seq;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_FIC_FIL_DOC_NUM := le.FIC_FIL_DOC_NUM <> ri.FIC_FIL_DOC_NUM;
    SELF.Diff_FIC_FIL_NAME := le.FIC_FIL_NAME <> ri.FIC_FIL_NAME;
    SELF.Diff_FIC_FIL_DATE := le.FIC_FIL_DATE <> ri.FIC_FIL_DATE;
    SELF.Diff_FIC_OWNER_DOC_NUM := le.FIC_OWNER_DOC_NUM <> ri.FIC_OWNER_DOC_NUM;
    SELF.Diff_FIC_OWNER_NAME := le.FIC_OWNER_NAME <> ri.FIC_OWNER_NAME;
    SELF.Diff_p_owner_name := le.p_owner_name <> ri.p_owner_name;
    SELF.Diff_c_owner_name := le.c_owner_name <> ri.c_owner_name;
    SELF.Diff_prep_addr_line1 := le.prep_addr_line1 <> ri.prep_addr_line1;
    SELF.Diff_prep_addr_line_last := le.prep_addr_line_last <> ri.prep_addr_line_last;
    SELF.Diff_prep_owner_addr_line1 := le.prep_owner_addr_line1 <> ri.prep_owner_addr_line1;
    SELF.Diff_prep_owner_addr_line_last := le.prep_owner_addr_line_last <> ri.prep_owner_addr_line_last;
    SELF.Diff_seq := le.seq <> ri.seq;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_FIC_FIL_DOC_NUM,1,0)+ IF( SELF.Diff_FIC_FIL_NAME,1,0)+ IF( SELF.Diff_FIC_FIL_DATE,1,0)+ IF( SELF.Diff_FIC_OWNER_DOC_NUM,1,0)+ IF( SELF.Diff_FIC_OWNER_NAME,1,0)+ IF( SELF.Diff_p_owner_name,1,0)+ IF( SELF.Diff_c_owner_name,1,0)+ IF( SELF.Diff_prep_addr_line1,1,0)+ IF( SELF.Diff_prep_addr_line_last,1,0)+ IF( SELF.Diff_prep_owner_addr_line1,1,0)+ IF( SELF.Diff_prep_owner_addr_line_last,1,0)+ IF( SELF.Diff_seq,1,0);
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
    Count_Diff_FIC_FIL_DOC_NUM := COUNT(GROUP,%Closest%.Diff_FIC_FIL_DOC_NUM);
    Count_Diff_FIC_FIL_NAME := COUNT(GROUP,%Closest%.Diff_FIC_FIL_NAME);
    Count_Diff_FIC_FIL_DATE := COUNT(GROUP,%Closest%.Diff_FIC_FIL_DATE);
    Count_Diff_FIC_OWNER_DOC_NUM := COUNT(GROUP,%Closest%.Diff_FIC_OWNER_DOC_NUM);
    Count_Diff_FIC_OWNER_NAME := COUNT(GROUP,%Closest%.Diff_FIC_OWNER_NAME);
    Count_Diff_p_owner_name := COUNT(GROUP,%Closest%.Diff_p_owner_name);
    Count_Diff_c_owner_name := COUNT(GROUP,%Closest%.Diff_c_owner_name);
    Count_Diff_prep_addr_line1 := COUNT(GROUP,%Closest%.Diff_prep_addr_line1);
    Count_Diff_prep_addr_line_last := COUNT(GROUP,%Closest%.Diff_prep_addr_line_last);
    Count_Diff_prep_owner_addr_line1 := COUNT(GROUP,%Closest%.Diff_prep_owner_addr_line1);
    Count_Diff_prep_owner_addr_line_last := COUNT(GROUP,%Closest%.Diff_prep_owner_addr_line_last);
    Count_Diff_seq := COUNT(GROUP,%Closest%.Diff_seq);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
