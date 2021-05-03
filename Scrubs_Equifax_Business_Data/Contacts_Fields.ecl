IMPORT SALT311;
IMPORT Scrubs_Equifax_Business_Data; // Import modules for FieldTypes attribute definitions
EXPORT Contacts_Fields := MODULE
 
EXPORT NumFields := 8;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_last_name','invalid_first_name','invalid_mandatory','invalid_title','invalid_title_desc','invalid_efx_id','invalid_efx_titlecd','invalid_efx_date');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_last_name' => 1,'invalid_first_name' => 2,'invalid_mandatory' => 3,'invalid_title' => 4,'invalid_title_desc' => 5,'invalid_efx_id' => 6,'invalid_efx_titlecd' => 7,'invalid_efx_date' => 8,0);
 
EXPORT MakeFT_invalid_last_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ,.-\'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_last_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ,.-\'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz'))));
EXPORT InValidMessageFT_invalid_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' ,.-\'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_first_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ,.-\'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_first_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ,.-\'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz'))));
EXPORT InValidMessageFT_invalid_first_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' ,.-\'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mandatory(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_title(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_title(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_title(s)>0);
EXPORT InValidMessageFT_invalid_title(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_title'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_title_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_title_desc(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_verify_title_desc(s)>0);
EXPORT InValidMessageFT_invalid_title_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_verify_title_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_efx_id(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_efx_id(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1 AND LENGTH(TRIM(s)) <= 10));
EXPORT InValidMessageFT_invalid_efx_id(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('1..10'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_efx_titlecd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_efx_titlecd(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 2));
EXPORT InValidMessageFT_invalid_efx_titlecd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('0..2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_efx_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_efx_date(SALT311.StrType s) := WHICH(~Scrubs_Equifax_Business_Data.Functions.fn_valid_Load_Date(s)>0);
EXPORT InValidMessageFT_invalid_efx_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Equifax_Business_Data.Functions.fn_valid_Load_Date'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'EFX_id','EFX_CONTCT','EFX_TITLECD','EFX_TITLEDESC','EFX_LASTNAM','EFX_FSTNAM','EFX_EMAIL','EFX_DATE');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'EFX_id','EFX_CONTCT','EFX_TITLECD','EFX_TITLEDESC','EFX_LASTNAM','EFX_FSTNAM','EFX_EMAIL','EFX_DATE');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'EFX_id' => 0,'EFX_CONTCT' => 1,'EFX_TITLECD' => 2,'EFX_TITLEDESC' => 3,'EFX_LASTNAM' => 4,'EFX_FSTNAM' => 5,'EFX_EMAIL' => 6,'EFX_DATE' => 7,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','LENGTHS'],['LENGTHS'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],[],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_EFX_id(SALT311.StrType s0) := MakeFT_invalid_efx_id(s0);
EXPORT InValid_EFX_id(SALT311.StrType s) := InValidFT_invalid_efx_id(s);
EXPORT InValidMessage_EFX_id(UNSIGNED1 wh) := InValidMessageFT_invalid_efx_id(wh);
 
EXPORT Make_EFX_CONTCT(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_EFX_CONTCT(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_EFX_CONTCT(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_EFX_TITLECD(SALT311.StrType s0) := MakeFT_invalid_title(s0);
EXPORT InValid_EFX_TITLECD(SALT311.StrType s) := InValidFT_invalid_title(s);
EXPORT InValidMessage_EFX_TITLECD(UNSIGNED1 wh) := InValidMessageFT_invalid_title(wh);
 
EXPORT Make_EFX_TITLEDESC(SALT311.StrType s0) := MakeFT_invalid_title_desc(s0);
EXPORT InValid_EFX_TITLEDESC(SALT311.StrType s) := InValidFT_invalid_title_desc(s);
EXPORT InValidMessage_EFX_TITLEDESC(UNSIGNED1 wh) := InValidMessageFT_invalid_title_desc(wh);
 
EXPORT Make_EFX_LASTNAM(SALT311.StrType s0) := MakeFT_invalid_last_name(s0);
EXPORT InValid_EFX_LASTNAM(SALT311.StrType s) := InValidFT_invalid_last_name(s);
EXPORT InValidMessage_EFX_LASTNAM(UNSIGNED1 wh) := InValidMessageFT_invalid_last_name(wh);
 
EXPORT Make_EFX_FSTNAM(SALT311.StrType s0) := MakeFT_invalid_first_name(s0);
EXPORT InValid_EFX_FSTNAM(SALT311.StrType s) := InValidFT_invalid_first_name(s);
EXPORT InValidMessage_EFX_FSTNAM(UNSIGNED1 wh) := InValidMessageFT_invalid_first_name(wh);
 
EXPORT Make_EFX_EMAIL(SALT311.StrType s0) := s0;
EXPORT InValid_EFX_EMAIL(SALT311.StrType s) := 0;
EXPORT InValidMessage_EFX_EMAIL(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_DATE(SALT311.StrType s0) := MakeFT_invalid_efx_date(s0);
EXPORT InValid_EFX_DATE(SALT311.StrType s) := InValidFT_invalid_efx_date(s);
EXPORT InValidMessage_EFX_DATE(UNSIGNED1 wh) := InValidMessageFT_invalid_efx_date(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Equifax_Business_Data;
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
    BOOLEAN Diff_EFX_id;
    BOOLEAN Diff_EFX_CONTCT;
    BOOLEAN Diff_EFX_TITLECD;
    BOOLEAN Diff_EFX_TITLEDESC;
    BOOLEAN Diff_EFX_LASTNAM;
    BOOLEAN Diff_EFX_FSTNAM;
    BOOLEAN Diff_EFX_EMAIL;
    BOOLEAN Diff_EFX_DATE;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_EFX_id := le.EFX_id <> ri.EFX_id;
    SELF.Diff_EFX_CONTCT := le.EFX_CONTCT <> ri.EFX_CONTCT;
    SELF.Diff_EFX_TITLECD := le.EFX_TITLECD <> ri.EFX_TITLECD;
    SELF.Diff_EFX_TITLEDESC := le.EFX_TITLEDESC <> ri.EFX_TITLEDESC;
    SELF.Diff_EFX_LASTNAM := le.EFX_LASTNAM <> ri.EFX_LASTNAM;
    SELF.Diff_EFX_FSTNAM := le.EFX_FSTNAM <> ri.EFX_FSTNAM;
    SELF.Diff_EFX_EMAIL := le.EFX_EMAIL <> ri.EFX_EMAIL;
    SELF.Diff_EFX_DATE := le.EFX_DATE <> ri.EFX_DATE;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_EFX_id,1,0)+ IF( SELF.Diff_EFX_CONTCT,1,0)+ IF( SELF.Diff_EFX_TITLECD,1,0)+ IF( SELF.Diff_EFX_TITLEDESC,1,0)+ IF( SELF.Diff_EFX_LASTNAM,1,0)+ IF( SELF.Diff_EFX_FSTNAM,1,0)+ IF( SELF.Diff_EFX_EMAIL,1,0)+ IF( SELF.Diff_EFX_DATE,1,0);
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
    Count_Diff_EFX_id := COUNT(GROUP,%Closest%.Diff_EFX_id);
    Count_Diff_EFX_CONTCT := COUNT(GROUP,%Closest%.Diff_EFX_CONTCT);
    Count_Diff_EFX_TITLECD := COUNT(GROUP,%Closest%.Diff_EFX_TITLECD);
    Count_Diff_EFX_TITLEDESC := COUNT(GROUP,%Closest%.Diff_EFX_TITLEDESC);
    Count_Diff_EFX_LASTNAM := COUNT(GROUP,%Closest%.Diff_EFX_LASTNAM);
    Count_Diff_EFX_FSTNAM := COUNT(GROUP,%Closest%.Diff_EFX_FSTNAM);
    Count_Diff_EFX_EMAIL := COUNT(GROUP,%Closest%.Diff_EFX_EMAIL);
    Count_Diff_EFX_DATE := COUNT(GROUP,%Closest%.Diff_EFX_DATE);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
