IMPORT SALT37;
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT37.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'DEFAULT','NUMBER');
EXPORT FieldTypeNum(SALT37.StrType fn) := CASE(fn,'DEFAULT' => 1,'NUMBER' => 2,0);
 
EXPORT MakeFT_DEFAULT(SALT37.StrType s0) := FUNCTION
  s1 := if ( SALT37.StringFind('"\'',s0[1],1)>0 and SALT37.StringFind('"\'',s0[LENGTH(TRIM(s0))],1)>0,s0[2..LENGTH(TRIM(s0))-1],s0 );// Remove quotes if required
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_DEFAULT(SALT37.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,SALT37.StringFind('"\'',s[1],1)<>0 and SALT37.StringFind('"\'',s[LENGTH(TRIM(s))],1)<>0);
EXPORT InValidMessageFT_DEFAULT(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLeft,SALT37.HygieneErrors.Inquotes('"\''),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_NUMBER(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789'); // Only allow valid symbols
  s2 := if ( SALT37.StringFind('"\'',s1[1],1)>0 and SALT37.StringFind('"\'',s1[LENGTH(TRIM(s1))],1)>0,s1[2..LENGTH(TRIM(s1))-1],s1 );// Remove quotes if required
  RETURN  s2;
END;
EXPORT InValidFT_NUMBER(SALT37.StrType s) := WHICH(SALT37.StringFind('"\'',s[1],1)<>0 and SALT37.StringFind('"\'',s[LENGTH(TRIM(s))],1)<>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_NUMBER(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.Inquotes('"\''),SALT37.HygieneErrors.NotInChars('0123456789'),SALT37.HygieneErrors.Good);
 
EXPORT SALT37.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'ADDRESS','SSN','POLICY_NUMBER','CLAIM_NUMBER','DL_NBR','FULLNAME','MAINNAME','ADDR1','DOB','ZIP','LOCALE','PRIM_NAME','LNAME','PRIM_RANGE','CITY','FNAME','SEC_RANGE','MNAME','ST','SNAME','GENDER','DERIVED_GENDER','VENDOR_ID','BOCA_DID','SRC','DT_FIRST_SEEN','DT_LAST_SEEN','DL_STATE','AMBEST');
EXPORT FieldNum(SALT37.StrType fn) := CASE(fn,'ADDRESS' => 0,'SSN' => 1,'POLICY_NUMBER' => 2,'CLAIM_NUMBER' => 3,'DL_NBR' => 4,'FULLNAME' => 5,'MAINNAME' => 6,'ADDR1' => 7,'DOB' => 8,'ZIP' => 9,'LOCALE' => 10,'PRIM_NAME' => 11,'LNAME' => 12,'PRIM_RANGE' => 13,'CITY' => 14,'FNAME' => 15,'SEC_RANGE' => 16,'MNAME' => 17,'ST' => 18,'SNAME' => 19,'GENDER' => 20,'DERIVED_GENDER' => 21,'VENDOR_ID' => 22,'BOCA_DID' => 23,'SRC' => 24,'DT_FIRST_SEEN' => 25,'DT_LAST_SEEN' => 26,'DL_STATE' => 27,'AMBEST' => 28,0);
 
//Individual field level validation
 
EXPORT Make_ADDRESS(SALT37.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_ADDRESS(SALT37.StrType ADDR1,SALT37.StrType LOCALE) := 0;
EXPORT InValidMessage_ADDRESS(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_SSN(SALT37.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_SSN(SALT37.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_SSN(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);
 
EXPORT Make_POLICY_NUMBER(SALT37.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_POLICY_NUMBER(SALT37.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_POLICY_NUMBER(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_CLAIM_NUMBER(SALT37.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_CLAIM_NUMBER(SALT37.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_CLAIM_NUMBER(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_DL_NBR(SALT37.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DL_NBR(SALT37.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DL_NBR(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_FULLNAME(SALT37.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_FULLNAME(SALT37.StrType MAINNAME,SALT37.StrType SNAME) := 0;
EXPORT InValidMessage_FULLNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_MAINNAME(SALT37.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_MAINNAME(SALT37.StrType FNAME,SALT37.StrType MNAME,SALT37.StrType LNAME) := 0;
EXPORT InValidMessage_MAINNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_ADDR1(SALT37.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_ADDR1(SALT37.StrType PRIM_RANGE,SALT37.StrType SEC_RANGE,SALT37.StrType PRIM_NAME) := 0;
EXPORT InValidMessage_ADDR1(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_DOB(SALT37.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DOB(SALT37.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DOB(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_ZIP(SALT37.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_ZIP(SALT37.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_ZIP(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_LOCALE(SALT37.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_LOCALE(SALT37.StrType CITY,SALT37.StrType ST,SALT37.StrType ZIP) := 0;
EXPORT InValidMessage_LOCALE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_PRIM_NAME(SALT37.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_PRIM_NAME(SALT37.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_PRIM_NAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_LNAME(SALT37.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_LNAME(SALT37.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_LNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_PRIM_RANGE(SALT37.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_PRIM_RANGE(SALT37.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_PRIM_RANGE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_CITY(SALT37.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_CITY(SALT37.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_CITY(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_FNAME(SALT37.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_FNAME(SALT37.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_FNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_SEC_RANGE(SALT37.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SEC_RANGE(SALT37.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SEC_RANGE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_MNAME(SALT37.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_MNAME(SALT37.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_MNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_ST(SALT37.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_ST(SALT37.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_ST(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_SNAME(SALT37.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SNAME(SALT37.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_GENDER(SALT37.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_GENDER(SALT37.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_GENDER(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_DERIVED_GENDER(SALT37.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DERIVED_GENDER(SALT37.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DERIVED_GENDER(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_VENDOR_ID(SALT37.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_VENDOR_ID(SALT37.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_VENDOR_ID(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_BOCA_DID(SALT37.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_BOCA_DID(SALT37.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_BOCA_DID(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_SRC(SALT37.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SRC(SALT37.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SRC(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_DT_FIRST_SEEN(SALT37.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DT_FIRST_SEEN(SALT37.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DT_FIRST_SEEN(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_DT_LAST_SEEN(SALT37.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DT_LAST_SEEN(SALT37.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DT_LAST_SEEN(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_DL_STATE(SALT37.StrType s0) := s0;
EXPORT InValid_DL_STATE(SALT37.StrType s) := 0;
EXPORT InValidMessage_DL_STATE(UNSIGNED1 wh) := '';
 
EXPORT Make_AMBEST(SALT37.StrType s0) := s0;
EXPORT InValid_AMBEST(SALT37.StrType s) := 0;
EXPORT InValidMessage_AMBEST(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT37,InsuranceHeader_RemoteLinking;
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
    BOOLEAN Diff_SSN;
    BOOLEAN Diff_POLICY_NUMBER;
    BOOLEAN Diff_CLAIM_NUMBER;
    BOOLEAN Diff_DL_NBR;
    BOOLEAN Diff_DOB;
    BOOLEAN Diff_ZIP;
    BOOLEAN Diff_PRIM_NAME;
    BOOLEAN Diff_LNAME;
    BOOLEAN Diff_PRIM_RANGE;
    BOOLEAN Diff_CITY;
    BOOLEAN Diff_FNAME;
    BOOLEAN Diff_SEC_RANGE;
    BOOLEAN Diff_MNAME;
    BOOLEAN Diff_ST;
    BOOLEAN Diff_SNAME;
    BOOLEAN Diff_GENDER;
    BOOLEAN Diff_DERIVED_GENDER;
    BOOLEAN Diff_VENDOR_ID;
    BOOLEAN Diff_BOCA_DID;
    BOOLEAN Diff_SRC;
    BOOLEAN Diff_DT_FIRST_SEEN;
    BOOLEAN Diff_DT_LAST_SEEN;
    BOOLEAN Diff_DL_STATE;
    BOOLEAN Diff_AMBEST;
    SALT37.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT37.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_SSN := le.SSN <> ri.SSN;
    SELF.Diff_POLICY_NUMBER := le.POLICY_NUMBER <> ri.POLICY_NUMBER;
    SELF.Diff_CLAIM_NUMBER := le.CLAIM_NUMBER <> ri.CLAIM_NUMBER;
    SELF.Diff_DL_NBR := le.DL_NBR <> ri.DL_NBR;
    SELF.Diff_DOB := le.DOB <> ri.DOB;
    SELF.Diff_ZIP := le.ZIP <> ri.ZIP;
    SELF.Diff_PRIM_NAME := le.PRIM_NAME <> ri.PRIM_NAME;
    SELF.Diff_LNAME := le.LNAME <> ri.LNAME;
    SELF.Diff_PRIM_RANGE := le.PRIM_RANGE <> ri.PRIM_RANGE;
    SELF.Diff_CITY := le.CITY <> ri.CITY;
    SELF.Diff_FNAME := le.FNAME <> ri.FNAME;
    SELF.Diff_SEC_RANGE := le.SEC_RANGE <> ri.SEC_RANGE;
    SELF.Diff_MNAME := le.MNAME <> ri.MNAME;
    SELF.Diff_ST := le.ST <> ri.ST;
    SELF.Diff_SNAME := le.SNAME <> ri.SNAME;
    SELF.Diff_GENDER := le.GENDER <> ri.GENDER;
    SELF.Diff_DERIVED_GENDER := le.DERIVED_GENDER <> ri.DERIVED_GENDER;
    SELF.Diff_VENDOR_ID := le.VENDOR_ID <> ri.VENDOR_ID;
    SELF.Diff_BOCA_DID := le.BOCA_DID <> ri.BOCA_DID;
    SELF.Diff_SRC := le.SRC <> ri.SRC;
    SELF.Diff_DT_FIRST_SEEN := le.DT_FIRST_SEEN <> ri.DT_FIRST_SEEN;
    SELF.Diff_DT_LAST_SEEN := le.DT_LAST_SEEN <> ri.DT_LAST_SEEN;
    SELF.Diff_DL_STATE := le.DL_STATE <> ri.DL_STATE;
    SELF.Diff_AMBEST := le.AMBEST <> ri.AMBEST;
    SELF.Val := (SALT37.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.SRC;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_SSN,1,0)+ IF( SELF.Diff_POLICY_NUMBER,1,0)+ IF( SELF.Diff_CLAIM_NUMBER,1,0)+ IF( SELF.Diff_DL_NBR,1,0)+ IF( SELF.Diff_DOB,1,0)+ IF( SELF.Diff_ZIP,1,0)+ IF( SELF.Diff_PRIM_NAME,1,0)+ IF( SELF.Diff_LNAME,1,0)+ IF( SELF.Diff_PRIM_RANGE,1,0)+ IF( SELF.Diff_CITY,1,0)+ IF( SELF.Diff_FNAME,1,0)+ IF( SELF.Diff_SEC_RANGE,1,0)+ IF( SELF.Diff_MNAME,1,0)+ IF( SELF.Diff_ST,1,0)+ IF( SELF.Diff_SNAME,1,0)+ IF( SELF.Diff_GENDER,1,0)+ IF( SELF.Diff_DERIVED_GENDER,1,0)+ IF( SELF.Diff_VENDOR_ID,1,0)+ IF( SELF.Diff_BOCA_DID,1,0)+ IF( SELF.Diff_SRC,1,0)+ IF( SELF.Diff_DL_STATE,1,0)+ IF( SELF.Diff_AMBEST,1,0);
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
    Count_Diff_SSN := COUNT(GROUP,%Closest%.Diff_SSN);
    Count_Diff_POLICY_NUMBER := COUNT(GROUP,%Closest%.Diff_POLICY_NUMBER);
    Count_Diff_CLAIM_NUMBER := COUNT(GROUP,%Closest%.Diff_CLAIM_NUMBER);
    Count_Diff_DL_NBR := COUNT(GROUP,%Closest%.Diff_DL_NBR);
    Count_Diff_DOB := COUNT(GROUP,%Closest%.Diff_DOB);
    Count_Diff_ZIP := COUNT(GROUP,%Closest%.Diff_ZIP);
    Count_Diff_PRIM_NAME := COUNT(GROUP,%Closest%.Diff_PRIM_NAME);
    Count_Diff_LNAME := COUNT(GROUP,%Closest%.Diff_LNAME);
    Count_Diff_PRIM_RANGE := COUNT(GROUP,%Closest%.Diff_PRIM_RANGE);
    Count_Diff_CITY := COUNT(GROUP,%Closest%.Diff_CITY);
    Count_Diff_FNAME := COUNT(GROUP,%Closest%.Diff_FNAME);
    Count_Diff_SEC_RANGE := COUNT(GROUP,%Closest%.Diff_SEC_RANGE);
    Count_Diff_MNAME := COUNT(GROUP,%Closest%.Diff_MNAME);
    Count_Diff_ST := COUNT(GROUP,%Closest%.Diff_ST);
    Count_Diff_SNAME := COUNT(GROUP,%Closest%.Diff_SNAME);
    Count_Diff_GENDER := COUNT(GROUP,%Closest%.Diff_GENDER);
    Count_Diff_DERIVED_GENDER := COUNT(GROUP,%Closest%.Diff_DERIVED_GENDER);
    Count_Diff_VENDOR_ID := COUNT(GROUP,%Closest%.Diff_VENDOR_ID);
    Count_Diff_BOCA_DID := COUNT(GROUP,%Closest%.Diff_BOCA_DID);
    Count_Diff_SRC := COUNT(GROUP,%Closest%.Diff_SRC);
    Count_Diff_DT_FIRST_SEEN := COUNT(GROUP,%Closest%.Diff_DT_FIRST_SEEN);
    Count_Diff_DT_LAST_SEEN := COUNT(GROUP,%Closest%.Diff_DT_LAST_SEEN);
    Count_Diff_DL_STATE := COUNT(GROUP,%Closest%.Diff_DL_STATE);
    Count_Diff_AMBEST := COUNT(GROUP,%Closest%.Diff_AMBEST);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
// Now determine the consistency of the identifiers
EXPORT UIDConsistency(infile) := FUNCTIONMACRO
  f := TABLE(infile,{RID,DID}) : GLOBAL; // Consistent type independent of input
  m := MODULE
    r := RECORD
      UNSIGNED RID_null0 := COUNT(GROUP,(UNSIGNED)f.RID=0);
      UNSIGNED RID_belowparent0 := COUNT(GROUP,(UNSIGNED)f.RID<(UNSIGNED)f.DID);
      UNSIGNED RID_atparent := COUNT(GROUP,(UNSIGNED)f.DID=(UNSIGNED)f.RID);
      UNSIGNED DID_null0 := COUNT(GROUP,(UNSIGNED)f.DID=0);
    END;
  EXPORT Basic0 := TABLE(f,r);
  EXPORT RID_Clusters := SALT37.MOD_ClusterStats.Counts(f,RID);
  EXPORT DID_Clusters := SALT37.MOD_ClusterStats.Counts(f,DID);
  EXPORT IdCounts := DATASET([{'RID_Cnt', SUM(RID_Clusters,NumberOfClusters)},{'DID_Cnt', SUM(DID_Clusters,NumberOfClusters)}],{STRING10 Count_Type, UNSIGNED Cnt}); // The counts of each ID
 // For deeper debugging; provide the unbased parents
    bases := f((UNSIGNED)DID=(UNSIGNED)RID); // Get the bases
  EXPORT DID_Unbased := JOIN(f(DID<>0),bases,LEFT.DID=RIGHT.DID,TRANSFORM(LEFT),LEFT ONLY,HASH);
 // Children with two parents
    f_thin := TABLE(f(RID<>0,DID<>0),{RID,DID},RID,DID,MERGE);
  EXPORT RID_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.RID=RIGHT.RID AND LEFT.DID>RIGHT.DID,TRANSFORM({SALT37.UIDType DID1,SALT37.UIDType RID,SALT37.UIDType DID2},SELF.DID1:=LEFT.DID,SELF.DID2:=RIGHT.DID,SELF.RID:=LEFT.RID),HASH),WHOLE RECORD,ALL);
 // Now compute the more involved consistency checks
    r := RECORD
      {Basic0} AND NOT [RID_atparent];
      INTEGER DID_unbased0 := IdCounts[2].Cnt-Basic0.RID_atparent-IF(Basic0.DID_null0>0,1,0);
      INTEGER RID_Twoparents0 := COUNT(RID_Twoparents);
    END;
  Advanced00 := TABLE(Basic0,r);
  Advanced0Layout := {STRING label, INTEGER null0, INTEGER belowparent0, INTEGER unbased0, INTEGER Twoparents0};
  EXPORT Advanced0 := SORT(SALT37.MAC_Pivot(Advanced00,Advanced0Layout), MAP(label='RID'=>0,1));
  END;
  RETURN m;
ENDMACRO;
END;
