IMPORT SALT311;
EXPORT Fields := MODULE
 
EXPORT NumFields := 22;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'DEFAULT','NUMBER');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'DEFAULT' => 1,'NUMBER' => 2,0);
 
EXPORT MakeFT_DEFAULT(SALT311.StrType s0) := FUNCTION
  s1 := if ( SALT311.StringFind('"\'',s0[1],1)>0 and SALT311.StringFind('"\'',s0[LENGTH(TRIM(s0))],1)>0,s0[2..LENGTH(TRIM(s0))-1],s0 );// Remove quotes if required
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_DEFAULT(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,SALT311.StringFind('"\'',s[1],1)<>0 and SALT311.StringFind('"\'',s[LENGTH(TRIM(s))],1)<>0);
EXPORT InValidMessageFT_DEFAULT(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.Inquotes('"\''),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_NUMBER(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  s2 := if ( SALT311.StringFind('"\'',s1[1],1)>0 and SALT311.StringFind('"\'',s1[LENGTH(TRIM(s1))],1)>0,s1[2..LENGTH(TRIM(s1))-1],s1 );// Remove quotes if required
  RETURN  s2;
END;
EXPORT InValidFT_NUMBER(SALT311.StrType s) := WHICH(SALT311.StringFind('"\'',s[1],1)<>0 and SALT311.StringFind('"\'',s[LENGTH(TRIM(s))],1)<>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_NUMBER(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.Inquotes('"\''),SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'SRC','SSN','DOB','LEXID','SUFFIX','FNAME','MNAME','LNAME','GENDER','PRIM_NAME','PRIM_RANGE','SEC_RANGE','CITY_NAME','ST','ZIP','DT_FIRST_SEEN','DT_LAST_SEEN','MAINNAME','ADDR1','LOCALE','ADDRESS','FULLNAME');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'SRC','SSN','DOB','LEXID','SUFFIX','FNAME','MNAME','LNAME','GENDER','PRIM_NAME','PRIM_RANGE','SEC_RANGE','CITY_NAME','ST','ZIP','DT_FIRST_SEEN','DT_LAST_SEEN','MAINNAME','ADDR1','LOCALE','ADDRESS','FULLNAME');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'SRC' => 0,'SSN' => 1,'DOB' => 2,'LEXID' => 3,'SUFFIX' => 4,'FNAME' => 5,'MNAME' => 6,'LNAME' => 7,'GENDER' => 8,'PRIM_NAME' => 9,'PRIM_RANGE' => 10,'SEC_RANGE' => 11,'CITY_NAME' => 12,'ST' => 13,'ZIP' => 14,'DT_FIRST_SEEN' => 15,'DT_LAST_SEEN' => 16,'MAINNAME' => 17,'ADDR1' => 18,'LOCALE' => 19,'ADDRESS' => 20,'FULLNAME' => 21,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['LEFTTRIM','QUOTES'],['QUOTES','ALLOW'],['LEFTTRIM','QUOTES'],['QUOTES','ALLOW'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE);
 
//Individual field level validation
 
EXPORT Make_SRC(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SRC(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SRC(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_SSN(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_SSN(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_SSN(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);
 
EXPORT Make_DOB(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DOB(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DOB(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_LEXID(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_LEXID(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_LEXID(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);
 
EXPORT Make_SUFFIX(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SUFFIX(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SUFFIX(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_FNAME(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_FNAME(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_FNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_MNAME(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_MNAME(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_MNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_LNAME(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_LNAME(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_LNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_GENDER(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_GENDER(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_GENDER(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_PRIM_NAME(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_PRIM_NAME(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_PRIM_NAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_PRIM_RANGE(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_PRIM_RANGE(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_PRIM_RANGE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_SEC_RANGE(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SEC_RANGE(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SEC_RANGE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_CITY_NAME(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_CITY_NAME(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_CITY_NAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_ST(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_ST(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_ST(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_ZIP(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_ZIP(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_ZIP(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_DT_FIRST_SEEN(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DT_FIRST_SEEN(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DT_FIRST_SEEN(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_DT_LAST_SEEN(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DT_LAST_SEEN(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DT_LAST_SEEN(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_MAINNAME(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_MAINNAME(SALT311.StrType FNAME,SALT311.StrType MNAME,SALT311.StrType LNAME) := WHICH(InValid_FNAME(FNAME)>0,InValid_MNAME(MNAME)>0,InValid_LNAME(LNAME)>0);
EXPORT InValidMessage_MAINNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_ADDR1(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_ADDR1(SALT311.StrType PRIM_RANGE,SALT311.StrType SEC_RANGE,SALT311.StrType PRIM_NAME) := WHICH(InValid_PRIM_RANGE(PRIM_RANGE)>0,InValid_SEC_RANGE(SEC_RANGE)>0,InValid_PRIM_NAME(PRIM_NAME)>0);
EXPORT InValidMessage_ADDR1(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_LOCALE(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_LOCALE(SALT311.StrType CITY_NAME,SALT311.StrType ST,SALT311.StrType ZIP) := WHICH(InValid_CITY_NAME(CITY_NAME)>0,InValid_ST(ST)>0,InValid_ZIP(ZIP)>0);
EXPORT InValidMessage_LOCALE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_ADDRESS(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_ADDRESS(SALT311.StrType PRIM_RANGE,SALT311.StrType SEC_RANGE,SALT311.StrType PRIM_NAME,SALT311.StrType CITY_NAME,SALT311.StrType ST,SALT311.StrType ZIP) := WHICH(InValid_PRIM_RANGE(PRIM_RANGE)>0,InValid_SEC_RANGE(SEC_RANGE)>0,InValid_PRIM_NAME(PRIM_NAME)>0,InValid_CITY_NAME(CITY_NAME)>0,InValid_ST(ST)>0,InValid_ZIP(ZIP)>0);
EXPORT InValidMessage_ADDRESS(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_FULLNAME(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_FULLNAME(SALT311.StrType FNAME,SALT311.StrType MNAME,SALT311.StrType LNAME,SALT311.StrType SUFFIX) := WHICH(InValid_FNAME(FNAME)>0,InValid_MNAME(MNAME)>0,InValid_LNAME(LNAME)>0,InValid_SUFFIX(SUFFIX)>0);
EXPORT InValidMessage_FULLNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,HealthcareNoMatchHeader_ExternalLinking;
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
    BOOLEAN Diff_SRC;
    BOOLEAN Diff_SSN;
    BOOLEAN Diff_DOB;
    BOOLEAN Diff_LEXID;
    BOOLEAN Diff_SUFFIX;
    BOOLEAN Diff_FNAME;
    BOOLEAN Diff_MNAME;
    BOOLEAN Diff_LNAME;
    BOOLEAN Diff_GENDER;
    BOOLEAN Diff_PRIM_NAME;
    BOOLEAN Diff_PRIM_RANGE;
    BOOLEAN Diff_SEC_RANGE;
    BOOLEAN Diff_CITY_NAME;
    BOOLEAN Diff_ST;
    BOOLEAN Diff_ZIP;
    BOOLEAN Diff_DT_FIRST_SEEN;
    BOOLEAN Diff_DT_LAST_SEEN;
    SALT311.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_SRC := le.SRC <> ri.SRC;
    SELF.Diff_SSN := le.SSN <> ri.SSN;
    SELF.Diff_DOB := le.DOB <> ri.DOB;
    SELF.Diff_LEXID := le.LEXID <> ri.LEXID;
    SELF.Diff_SUFFIX := le.SUFFIX <> ri.SUFFIX;
    SELF.Diff_FNAME := le.FNAME <> ri.FNAME;
    SELF.Diff_MNAME := le.MNAME <> ri.MNAME;
    SELF.Diff_LNAME := le.LNAME <> ri.LNAME;
    SELF.Diff_GENDER := le.GENDER <> ri.GENDER;
    SELF.Diff_PRIM_NAME := le.PRIM_NAME <> ri.PRIM_NAME;
    SELF.Diff_PRIM_RANGE := le.PRIM_RANGE <> ri.PRIM_RANGE;
    SELF.Diff_SEC_RANGE := le.SEC_RANGE <> ri.SEC_RANGE;
    SELF.Diff_CITY_NAME := le.CITY_NAME <> ri.CITY_NAME;
    SELF.Diff_ST := le.ST <> ri.ST;
    SELF.Diff_ZIP := le.ZIP <> ri.ZIP;
    SELF.Diff_DT_FIRST_SEEN := le.DT_FIRST_SEEN <> ri.DT_FIRST_SEEN;
    SELF.Diff_DT_LAST_SEEN := le.DT_LAST_SEEN <> ri.DT_LAST_SEEN;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.SRC;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_SRC,1,0)+ IF( SELF.Diff_SSN,1,0)+ IF( SELF.Diff_DOB,1,0)+ IF( SELF.Diff_LEXID,1,0)+ IF( SELF.Diff_SUFFIX,1,0)+ IF( SELF.Diff_FNAME,1,0)+ IF( SELF.Diff_MNAME,1,0)+ IF( SELF.Diff_LNAME,1,0)+ IF( SELF.Diff_GENDER,1,0)+ IF( SELF.Diff_PRIM_NAME,1,0)+ IF( SELF.Diff_PRIM_RANGE,1,0)+ IF( SELF.Diff_SEC_RANGE,1,0)+ IF( SELF.Diff_CITY_NAME,1,0)+ IF( SELF.Diff_ST,1,0)+ IF( SELF.Diff_ZIP,1,0);
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
    Count_Diff_SRC := COUNT(GROUP,%Closest%.Diff_SRC);
    Count_Diff_SSN := COUNT(GROUP,%Closest%.Diff_SSN);
    Count_Diff_DOB := COUNT(GROUP,%Closest%.Diff_DOB);
    Count_Diff_LEXID := COUNT(GROUP,%Closest%.Diff_LEXID);
    Count_Diff_SUFFIX := COUNT(GROUP,%Closest%.Diff_SUFFIX);
    Count_Diff_FNAME := COUNT(GROUP,%Closest%.Diff_FNAME);
    Count_Diff_MNAME := COUNT(GROUP,%Closest%.Diff_MNAME);
    Count_Diff_LNAME := COUNT(GROUP,%Closest%.Diff_LNAME);
    Count_Diff_GENDER := COUNT(GROUP,%Closest%.Diff_GENDER);
    Count_Diff_PRIM_NAME := COUNT(GROUP,%Closest%.Diff_PRIM_NAME);
    Count_Diff_PRIM_RANGE := COUNT(GROUP,%Closest%.Diff_PRIM_RANGE);
    Count_Diff_SEC_RANGE := COUNT(GROUP,%Closest%.Diff_SEC_RANGE);
    Count_Diff_CITY_NAME := COUNT(GROUP,%Closest%.Diff_CITY_NAME);
    Count_Diff_ST := COUNT(GROUP,%Closest%.Diff_ST);
    Count_Diff_ZIP := COUNT(GROUP,%Closest%.Diff_ZIP);
    Count_Diff_DT_FIRST_SEEN := COUNT(GROUP,%Closest%.Diff_DT_FIRST_SEEN);
    Count_Diff_DT_LAST_SEEN := COUNT(GROUP,%Closest%.Diff_DT_LAST_SEEN);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
// Now determine the consistency of the identifiers
EXPORT UIDConsistency(infile) := FUNCTIONMACRO
  IMPORT HealthcareNoMatchHeader_ExternalLinking,SALT311;
  f := TABLE(infile,{RID,nomatch_id}) : GLOBAL; // Consistent type independent of input
  m := MODULE
    r := RECORD
      UNSIGNED RID_null0 := COUNT(GROUP,(UNSIGNED)f.RID=0);
      UNSIGNED RID_belowparent0 := COUNT(GROUP,(UNSIGNED)f.RID<(UNSIGNED)f.nomatch_id);
      UNSIGNED RID_atparent := COUNT(GROUP,(UNSIGNED)f.nomatch_id=(UNSIGNED)f.RID);
      UNSIGNED nomatch_id_null0 := COUNT(GROUP,(UNSIGNED)f.nomatch_id=0);
    END;
    EXPORT Basic0 := TABLE(f,r);
    EXPORT RID_Clusters := SALT311.MOD_ClusterStats.Counts(f,RID);
    EXPORT nomatch_id_Clusters := SALT311.MOD_ClusterStats.Counts(f,nomatch_id);
    EXPORT IdCounts := DATASET([{'RID_Cnt', SUM(RID_Clusters,NumberOfClusters)},{'nomatch_id_Cnt', SUM(nomatch_id_Clusters,NumberOfClusters)}],{STRING10 Count_Type, UNSIGNED Cnt}); // The counts of each ID
    // For deeper debugging; provide the unbased parents
    bases := f((UNSIGNED)nomatch_id=(UNSIGNED)RID); // Get the bases
    EXPORT nomatch_id_Unbased := JOIN(f(nomatch_id<>0),bases,LEFT.nomatch_id=RIGHT.nomatch_id,TRANSFORM(LEFT),LEFT ONLY,HASH);
    // Children with two parents
    f_thin := TABLE(f(RID<>0,nomatch_id<>0),{RID,nomatch_id},RID,nomatch_id,MERGE);
    EXPORT RID_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.RID=RIGHT.RID AND LEFT.nomatch_id>RIGHT.nomatch_id,TRANSFORM({SALT311.UIDType nomatch_id1,SALT311.UIDType RID,SALT311.UIDType nomatch_id2},SELF.nomatch_id1:=LEFT.nomatch_id,SELF.nomatch_id2:=RIGHT.nomatch_id,SELF.RID:=LEFT.RID),HASH),WHOLE RECORD,ALL);
    // Now compute the more involved consistency checks
    r := RECORD
      {Basic0} AND NOT [RID_atparent];
      INTEGER nomatch_id_unbased0 := IdCounts[2].Cnt-Basic0.RID_atparent-IF(Basic0.nomatch_id_null0>0,1,0);
      INTEGER RID_Twoparents0 := COUNT(RID_Twoparents);
    END;
    Advanced00 := TABLE(Basic0,r);
    Advanced0Layout := {STRING label, INTEGER null0, INTEGER belowparent0, INTEGER unbased0, INTEGER Twoparents0};
    EXPORT Advanced0 := SORT(SALT311.MAC_Pivot(Advanced00,Advanced0Layout), MAP(label='RID'=>0,1));
  END;
  RETURN m;
ENDMACRO;
END;
