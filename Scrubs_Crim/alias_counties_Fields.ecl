IMPORT SALT311;
IMPORT Scrubs,Scrubs_Crim; // Import modules for FieldTypes attribute definitions
EXPORT alias_counties_Fields := MODULE
 
EXPORT NumFields := 10;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Record_ID','Invalid_State','Invalid_Date','AKA_Search');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Record_ID' => 1,'Invalid_State' => 2,'Invalid_Date' => 3,'AKA_Search' => 4,0);
 
EXPORT MakeFT_Invalid_Record_ID(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Record_ID(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_ '))));
EXPORT InValidMessageFT_Invalid_Record_ID(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_State(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_State(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_AKA_Search(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_AKA_Search(SALT311.StrType s) := WHICH(~Scrubs_Crim.fn_FindAKA(s)>0);
EXPORT InValidMessageFT_AKA_Search(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Crim.fn_FindAKA'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'recordid','statecode','akaname','akalastname','akafirstname','akamiddlename','akasuffix','akadob','sourcename','vendor');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'recordid','statecode','akaname','akalastname','akafirstname','akamiddlename','akasuffix','akadob','sourcename','vendor');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'recordid' => 0,'statecode' => 1,'akaname' => 2,'akalastname' => 3,'akafirstname' => 4,'akamiddlename' => 5,'akasuffix' => 6,'akadob' => 7,'sourcename' => 8,'vendor' => 9,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_recordid(SALT311.StrType s0) := MakeFT_Invalid_Record_ID(s0);
EXPORT InValid_recordid(SALT311.StrType s) := InValidFT_Invalid_Record_ID(s);
EXPORT InValidMessage_recordid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Record_ID(wh);
 
EXPORT Make_statecode(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_statecode(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_statecode(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_akaname(SALT311.StrType s0) := MakeFT_AKA_Search(s0);
EXPORT InValid_akaname(SALT311.StrType s) := InValidFT_AKA_Search(s);
EXPORT InValidMessage_akaname(UNSIGNED1 wh) := InValidMessageFT_AKA_Search(wh);
 
EXPORT Make_akalastname(SALT311.StrType s0) := MakeFT_AKA_Search(s0);
EXPORT InValid_akalastname(SALT311.StrType s) := InValidFT_AKA_Search(s);
EXPORT InValidMessage_akalastname(UNSIGNED1 wh) := InValidMessageFT_AKA_Search(wh);
 
EXPORT Make_akafirstname(SALT311.StrType s0) := MakeFT_AKA_Search(s0);
EXPORT InValid_akafirstname(SALT311.StrType s) := InValidFT_AKA_Search(s);
EXPORT InValidMessage_akafirstname(UNSIGNED1 wh) := InValidMessageFT_AKA_Search(wh);
 
EXPORT Make_akamiddlename(SALT311.StrType s0) := MakeFT_AKA_Search(s0);
EXPORT InValid_akamiddlename(SALT311.StrType s) := InValidFT_AKA_Search(s);
EXPORT InValidMessage_akamiddlename(UNSIGNED1 wh) := InValidMessageFT_AKA_Search(wh);
 
EXPORT Make_akasuffix(SALT311.StrType s0) := s0;
EXPORT InValid_akasuffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_akasuffix(UNSIGNED1 wh) := '';
 
EXPORT Make_akadob(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_akadob(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_akadob(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_sourcename(SALT311.StrType s0) := s0;
EXPORT InValid_sourcename(SALT311.StrType s) := 0;
EXPORT InValidMessage_sourcename(UNSIGNED1 wh) := '';
 
EXPORT Make_vendor(SALT311.StrType s0) := s0;
EXPORT InValid_vendor(SALT311.StrType s) := 0;
EXPORT InValidMessage_vendor(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Crim;
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
    BOOLEAN Diff_recordid;
    BOOLEAN Diff_statecode;
    BOOLEAN Diff_akaname;
    BOOLEAN Diff_akalastname;
    BOOLEAN Diff_akafirstname;
    BOOLEAN Diff_akamiddlename;
    BOOLEAN Diff_akasuffix;
    BOOLEAN Diff_akadob;
    BOOLEAN Diff_sourcename;
    BOOLEAN Diff_vendor;
    SALT311.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_recordid := le.recordid <> ri.recordid;
    SELF.Diff_statecode := le.statecode <> ri.statecode;
    SELF.Diff_akaname := le.akaname <> ri.akaname;
    SELF.Diff_akalastname := le.akalastname <> ri.akalastname;
    SELF.Diff_akafirstname := le.akafirstname <> ri.akafirstname;
    SELF.Diff_akamiddlename := le.akamiddlename <> ri.akamiddlename;
    SELF.Diff_akasuffix := le.akasuffix <> ri.akasuffix;
    SELF.Diff_akadob := le.akadob <> ri.akadob;
    SELF.Diff_sourcename := le.sourcename <> ri.sourcename;
    SELF.Diff_vendor := le.vendor <> ri.vendor;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.vendor;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_recordid,1,0)+ IF( SELF.Diff_statecode,1,0)+ IF( SELF.Diff_akaname,1,0)+ IF( SELF.Diff_akalastname,1,0)+ IF( SELF.Diff_akafirstname,1,0)+ IF( SELF.Diff_akamiddlename,1,0)+ IF( SELF.Diff_akasuffix,1,0)+ IF( SELF.Diff_akadob,1,0)+ IF( SELF.Diff_sourcename,1,0)+ IF( SELF.Diff_vendor,1,0);
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
    Count_Diff_recordid := COUNT(GROUP,%Closest%.Diff_recordid);
    Count_Diff_statecode := COUNT(GROUP,%Closest%.Diff_statecode);
    Count_Diff_akaname := COUNT(GROUP,%Closest%.Diff_akaname);
    Count_Diff_akalastname := COUNT(GROUP,%Closest%.Diff_akalastname);
    Count_Diff_akafirstname := COUNT(GROUP,%Closest%.Diff_akafirstname);
    Count_Diff_akamiddlename := COUNT(GROUP,%Closest%.Diff_akamiddlename);
    Count_Diff_akasuffix := COUNT(GROUP,%Closest%.Diff_akasuffix);
    Count_Diff_akadob := COUNT(GROUP,%Closest%.Diff_akadob);
    Count_Diff_sourcename := COUNT(GROUP,%Closest%.Diff_sourcename);
    Count_Diff_vendor := COUNT(GROUP,%Closest%.Diff_vendor);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;
