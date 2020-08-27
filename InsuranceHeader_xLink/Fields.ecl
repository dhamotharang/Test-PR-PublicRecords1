IMPORT SALT311;
EXPORT Fields := MODULE
 
EXPORT NumFields := 31;
 
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
  RETURN  s1;
END;
EXPORT InValidFT_NUMBER(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_NUMBER(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'SNAME','FNAME','MNAME','LNAME','DERIVED_GENDER','PRIM_RANGE','PRIM_NAME','SEC_RANGE','CITY','ST','ZIP','SSN5','SSN4','DOB','PHONE','DL_STATE','DL_NBR','SRC','SOURCE_RID','DT_FIRST_SEEN','DT_LAST_SEEN','DT_EFFECTIVE_FIRST','DT_EFFECTIVE_LAST','MAINNAME','FULLNAME','ADDR1','LOCALE','ADDRESS','fname2','lname2','VIN');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'SNAME','FNAME','MNAME','LNAME','DERIVED_GENDER','PRIM_RANGE','PRIM_NAME','SEC_RANGE','CITY','ST','ZIP','SSN5','SSN4','DOB','PHONE','DL_STATE','DL_NBR','SRC','SOURCE_RID','DT_FIRST_SEEN','DT_LAST_SEEN','DT_EFFECTIVE_FIRST','DT_EFFECTIVE_LAST','MAINNAME','FULLNAME','ADDR1','LOCALE','ADDRESS','fname2','lname2','VIN');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'SNAME' => 0,'FNAME' => 1,'MNAME' => 2,'LNAME' => 3,'DERIVED_GENDER' => 4,'PRIM_RANGE' => 5,'PRIM_NAME' => 6,'SEC_RANGE' => 7,'CITY' => 8,'ST' => 9,'ZIP' => 10,'SSN5' => 11,'SSN4' => 12,'DOB' => 13,'PHONE' => 14,'DL_STATE' => 15,'DL_NBR' => 16,'SRC' => 17,'SOURCE_RID' => 18,'DT_FIRST_SEEN' => 19,'DT_LAST_SEEN' => 20,'DT_EFFECTIVE_FIRST' => 21,'DT_EFFECTIVE_LAST' => 22,'MAINNAME' => 23,'FULLNAME' => 24,'ADDR1' => 25,'LOCALE' => 26,'ADDRESS' => 27,'fname2' => 28,'lname2' => 29,'VIN' => 30,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['ALLOW'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['ALLOW'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE);
 
//Individual field level validation
 
EXPORT Make_SNAME(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SNAME(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_FNAME(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_FNAME(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_FNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_MNAME(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_MNAME(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_MNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_LNAME(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_LNAME(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_LNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_DERIVED_GENDER(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DERIVED_GENDER(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DERIVED_GENDER(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_PRIM_RANGE(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_PRIM_RANGE(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_PRIM_RANGE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_PRIM_NAME(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_PRIM_NAME(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_PRIM_NAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_SEC_RANGE(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SEC_RANGE(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SEC_RANGE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_CITY(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_CITY(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_CITY(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_ST(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_ST(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_ST(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_ZIP(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ZIP(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ZIP(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);
 
EXPORT Make_SSN5(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SSN5(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SSN5(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_SSN4(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SSN4(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SSN4(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_DOB(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DOB(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DOB(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_PHONE(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_PHONE(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_PHONE(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);
 
EXPORT Make_DL_STATE(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DL_STATE(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DL_STATE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_DL_NBR(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DL_NBR(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DL_NBR(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_SRC(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SRC(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SRC(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_SOURCE_RID(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SOURCE_RID(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SOURCE_RID(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_DT_FIRST_SEEN(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DT_FIRST_SEEN(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DT_FIRST_SEEN(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_DT_LAST_SEEN(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DT_LAST_SEEN(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DT_LAST_SEEN(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_DT_EFFECTIVE_FIRST(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DT_EFFECTIVE_FIRST(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DT_EFFECTIVE_FIRST(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_DT_EFFECTIVE_LAST(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DT_EFFECTIVE_LAST(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DT_EFFECTIVE_LAST(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_MAINNAME(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_MAINNAME(SALT311.StrType FNAME,SALT311.StrType MNAME,SALT311.StrType LNAME) := WHICH(InValid_FNAME(FNAME)>0,InValid_MNAME(MNAME)>0,InValid_LNAME(LNAME)>0);
EXPORT InValidMessage_MAINNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_FULLNAME(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_FULLNAME(SALT311.StrType FNAME,SALT311.StrType MNAME,SALT311.StrType LNAME,SALT311.StrType SNAME) := WHICH(InValid_FNAME(FNAME)>0,InValid_MNAME(MNAME)>0,InValid_LNAME(LNAME)>0,InValid_SNAME(SNAME)>0);
EXPORT InValidMessage_FULLNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_ADDR1(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_ADDR1(SALT311.StrType PRIM_RANGE,SALT311.StrType SEC_RANGE,SALT311.StrType PRIM_NAME) := WHICH(InValid_PRIM_RANGE(PRIM_RANGE)>0,InValid_SEC_RANGE(SEC_RANGE)>0,InValid_PRIM_NAME(PRIM_NAME)>0);
EXPORT InValidMessage_ADDR1(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_LOCALE(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_LOCALE(SALT311.StrType CITY,SALT311.StrType ST,SALT311.StrType ZIP) := WHICH(InValid_CITY(CITY)>0,InValid_ST(ST)>0,InValid_ZIP(ZIP)>0);
EXPORT InValidMessage_LOCALE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_ADDRESS(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_ADDRESS(SALT311.StrType PRIM_RANGE,SALT311.StrType SEC_RANGE,SALT311.StrType PRIM_NAME,SALT311.StrType CITY,SALT311.StrType ST,SALT311.StrType ZIP) := WHICH(InValid_PRIM_RANGE(PRIM_RANGE)>0,InValid_SEC_RANGE(SEC_RANGE)>0,InValid_PRIM_NAME(PRIM_NAME)>0,InValid_CITY(CITY)>0,InValid_ST(ST)>0,InValid_ZIP(ZIP)>0);
EXPORT InValidMessage_ADDRESS(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_fname2(SALT311.StrType s0) := s0;
EXPORT InValid_fname2(SALT311.StrType s) := 0;
EXPORT InValidMessage_fname2(UNSIGNED1 wh) := '';
 
EXPORT Make_lname2(SALT311.StrType s0) := s0;
EXPORT InValid_lname2(SALT311.StrType s) := 0;
EXPORT InValidMessage_lname2(UNSIGNED1 wh) := '';
 
EXPORT Make_VIN(SALT311.StrType s0) := s0;
EXPORT InValid_VIN(SALT311.StrType s) := 0;
EXPORT InValidMessage_VIN(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,InsuranceHeader_xLink;
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
    BOOLEAN Diff_SNAME;
    BOOLEAN Diff_FNAME;
    BOOLEAN Diff_MNAME;
    BOOLEAN Diff_LNAME;
    BOOLEAN Diff_DERIVED_GENDER;
    BOOLEAN Diff_PRIM_RANGE;
    BOOLEAN Diff_PRIM_NAME;
    BOOLEAN Diff_SEC_RANGE;
    BOOLEAN Diff_CITY;
    BOOLEAN Diff_ST;
    BOOLEAN Diff_ZIP;
    BOOLEAN Diff_SSN5;
    BOOLEAN Diff_SSN4;
    BOOLEAN Diff_DOB;
    BOOLEAN Diff_PHONE;
    BOOLEAN Diff_DL_STATE;
    BOOLEAN Diff_DL_NBR;
    BOOLEAN Diff_SRC;
    BOOLEAN Diff_SOURCE_RID;
    BOOLEAN Diff_DT_FIRST_SEEN;
    BOOLEAN Diff_DT_LAST_SEEN;
    BOOLEAN Diff_DT_EFFECTIVE_FIRST;
    BOOLEAN Diff_DT_EFFECTIVE_LAST;
    SALT311.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_SNAME := le.SNAME <> ri.SNAME;
    SELF.Diff_FNAME := le.FNAME <> ri.FNAME;
    SELF.Diff_MNAME := le.MNAME <> ri.MNAME;
    SELF.Diff_LNAME := le.LNAME <> ri.LNAME;
    SELF.Diff_DERIVED_GENDER := le.DERIVED_GENDER <> ri.DERIVED_GENDER;
    SELF.Diff_PRIM_RANGE := le.PRIM_RANGE <> ri.PRIM_RANGE;
    SELF.Diff_PRIM_NAME := le.PRIM_NAME <> ri.PRIM_NAME;
    SELF.Diff_SEC_RANGE := le.SEC_RANGE <> ri.SEC_RANGE;
    SELF.Diff_CITY := le.CITY <> ri.CITY;
    SELF.Diff_ST := le.ST <> ri.ST;
    SELF.Diff_ZIP := le.ZIP <> ri.ZIP;
    SELF.Diff_SSN5 := le.SSN5 <> ri.SSN5;
    SELF.Diff_SSN4 := le.SSN4 <> ri.SSN4;
    SELF.Diff_DOB := le.DOB <> ri.DOB;
    SELF.Diff_PHONE := le.PHONE <> ri.PHONE;
    SELF.Diff_DL_STATE := le.DL_STATE <> ri.DL_STATE;
    SELF.Diff_DL_NBR := le.DL_NBR <> ri.DL_NBR;
    SELF.Diff_SRC := le.SRC <> ri.SRC;
    SELF.Diff_SOURCE_RID := le.SOURCE_RID <> ri.SOURCE_RID;
    SELF.Diff_DT_FIRST_SEEN := le.DT_FIRST_SEEN <> ri.DT_FIRST_SEEN;
    SELF.Diff_DT_LAST_SEEN := le.DT_LAST_SEEN <> ri.DT_LAST_SEEN;
    SELF.Diff_DT_EFFECTIVE_FIRST := le.DT_EFFECTIVE_FIRST <> ri.DT_EFFECTIVE_FIRST;
    SELF.Diff_DT_EFFECTIVE_LAST := le.DT_EFFECTIVE_LAST <> ri.DT_EFFECTIVE_LAST;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.SRC;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_SNAME,1,0)+ IF( SELF.Diff_FNAME,1,0)+ IF( SELF.Diff_MNAME,1,0)+ IF( SELF.Diff_LNAME,1,0)+ IF( SELF.Diff_DERIVED_GENDER,1,0)+ IF( SELF.Diff_PRIM_RANGE,1,0)+ IF( SELF.Diff_PRIM_NAME,1,0)+ IF( SELF.Diff_SEC_RANGE,1,0)+ IF( SELF.Diff_CITY,1,0)+ IF( SELF.Diff_ST,1,0)+ IF( SELF.Diff_ZIP,1,0)+ IF( SELF.Diff_SSN5,1,0)+ IF( SELF.Diff_SSN4,1,0)+ IF( SELF.Diff_DOB,1,0)+ IF( SELF.Diff_PHONE,1,0)+ IF( SELF.Diff_DL_STATE,1,0)+ IF( SELF.Diff_DL_NBR,1,0)+ IF( SELF.Diff_SRC,1,0)+ IF( SELF.Diff_SOURCE_RID,1,0);
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
    Count_Diff_SNAME := COUNT(GROUP,%Closest%.Diff_SNAME);
    Count_Diff_FNAME := COUNT(GROUP,%Closest%.Diff_FNAME);
    Count_Diff_MNAME := COUNT(GROUP,%Closest%.Diff_MNAME);
    Count_Diff_LNAME := COUNT(GROUP,%Closest%.Diff_LNAME);
    Count_Diff_DERIVED_GENDER := COUNT(GROUP,%Closest%.Diff_DERIVED_GENDER);
    Count_Diff_PRIM_RANGE := COUNT(GROUP,%Closest%.Diff_PRIM_RANGE);
    Count_Diff_PRIM_NAME := COUNT(GROUP,%Closest%.Diff_PRIM_NAME);
    Count_Diff_SEC_RANGE := COUNT(GROUP,%Closest%.Diff_SEC_RANGE);
    Count_Diff_CITY := COUNT(GROUP,%Closest%.Diff_CITY);
    Count_Diff_ST := COUNT(GROUP,%Closest%.Diff_ST);
    Count_Diff_ZIP := COUNT(GROUP,%Closest%.Diff_ZIP);
    Count_Diff_SSN5 := COUNT(GROUP,%Closest%.Diff_SSN5);
    Count_Diff_SSN4 := COUNT(GROUP,%Closest%.Diff_SSN4);
    Count_Diff_DOB := COUNT(GROUP,%Closest%.Diff_DOB);
    Count_Diff_PHONE := COUNT(GROUP,%Closest%.Diff_PHONE);
    Count_Diff_DL_STATE := COUNT(GROUP,%Closest%.Diff_DL_STATE);
    Count_Diff_DL_NBR := COUNT(GROUP,%Closest%.Diff_DL_NBR);
    Count_Diff_SRC := COUNT(GROUP,%Closest%.Diff_SRC);
    Count_Diff_SOURCE_RID := COUNT(GROUP,%Closest%.Diff_SOURCE_RID);
    Count_Diff_DT_FIRST_SEEN := COUNT(GROUP,%Closest%.Diff_DT_FIRST_SEEN);
    Count_Diff_DT_LAST_SEEN := COUNT(GROUP,%Closest%.Diff_DT_LAST_SEEN);
    Count_Diff_DT_EFFECTIVE_FIRST := COUNT(GROUP,%Closest%.Diff_DT_EFFECTIVE_FIRST);
    Count_Diff_DT_EFFECTIVE_LAST := COUNT(GROUP,%Closest%.Diff_DT_EFFECTIVE_LAST);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
// Now determine the consistency of the identifiers
EXPORT UIDConsistency(infile) := FUNCTIONMACRO
  IMPORT InsuranceHeader_xLink,SALT311;
  f := TABLE(infile,{RID,DID}) : GLOBAL; // Consistent type independent of input
  m := MODULE
    r := RECORD
      UNSIGNED RID_null0 := COUNT(GROUP,(UNSIGNED)f.RID=0);
      UNSIGNED RID_belowparent0 := COUNT(GROUP,(UNSIGNED)f.RID<(UNSIGNED)f.DID);
      UNSIGNED RID_atparent := COUNT(GROUP,(UNSIGNED)f.DID=(UNSIGNED)f.RID);
      UNSIGNED DID_null0 := COUNT(GROUP,(UNSIGNED)f.DID=0);
    END;
    EXPORT Basic0 := TABLE(f,r);
    EXPORT RID_Clusters := SALT311.MOD_ClusterStats.Counts(f,RID);
    EXPORT DID_Clusters := SALT311.MOD_ClusterStats.Counts(f,DID);
    EXPORT IdCounts := DATASET([{'RID_Cnt', SUM(RID_Clusters,NumberOfClusters)},{'DID_Cnt', SUM(DID_Clusters,NumberOfClusters)}],{STRING10 Count_Type, UNSIGNED Cnt}); // The counts of each ID
    // For deeper debugging; provide the unbased parents
    bases := f((UNSIGNED)DID=(UNSIGNED)RID); // Get the bases
    EXPORT DID_Unbased := JOIN(f(DID<>0),bases,LEFT.DID=RIGHT.DID,TRANSFORM(LEFT),LEFT ONLY,HASH);
    // Children with two parents
    f_thin := TABLE(f(RID<>0,DID<>0),{RID,DID},RID,DID,MERGE);
    EXPORT RID_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.RID=RIGHT.RID AND LEFT.DID>RIGHT.DID,TRANSFORM({SALT311.UIDType DID1,SALT311.UIDType RID,SALT311.UIDType DID2},SELF.DID1:=LEFT.DID,SELF.DID2:=RIGHT.DID,SELF.RID:=LEFT.RID),HASH),WHOLE RECORD,ALL);
    // Now compute the more involved consistency checks
    r := RECORD
      {Basic0} AND NOT [RID_atparent];
      INTEGER DID_unbased0 := IdCounts[2].Cnt-Basic0.RID_atparent-IF(Basic0.DID_null0>0,1,0);
      INTEGER RID_Twoparents0 := COUNT(RID_Twoparents);
    END;
    Advanced00 := TABLE(Basic0,r);
    Advanced0Layout := {STRING label, INTEGER null0, INTEGER belowparent0, INTEGER unbased0, INTEGER Twoparents0};
    EXPORT Advanced0 := SORT(SALT311.MAC_Pivot(Advanced00,Advanced0Layout), MAP(label='RID'=>0,1));
  END;
  RETURN m;
ENDMACRO;
END;
