IMPORT ut,SALT33;
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT33.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'DEFAULT','NUMBER');
EXPORT FieldTypeNum(SALT33.StrType fn) := CASE(fn,'DEFAULT' => 1,'NUMBER' => 2,0);
 
EXPORT MakeFT_DEFAULT(SALT33.StrType s0) := FUNCTION
  s1 := if ( SALT33.StringFind('"\'',s0[1],1)>0 and SALT33.StringFind('"\'',s0[LENGTH(TRIM(s0))],1)>0,s0[2..LENGTH(TRIM(s0))-1],s0 );// Remove quotes if required
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_DEFAULT(SALT33.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,SALT33.StringFind('"\'',s[1],1)<>0 and SALT33.StringFind('"\'',s[LENGTH(TRIM(s))],1)<>0);
EXPORT InValidMessageFT_DEFAULT(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotLeft,SALT33.HygieneErrors.Inquotes('"\''),SALT33.HygieneErrors.Good);
 
EXPORT MakeFT_NUMBER(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_NUMBER(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_NUMBER(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
 
EXPORT SALT33.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'NAME_SUFFIX','FNAME','MNAME','LNAME','PRIM_RANGE','PRIM_NAME','SEC_RANGE','P_CITY_NAME','ST','ZIP','DOB','PHONE','DL_ST','DL','LEXID','POSSIBLE_SSN','CRIME','NAME_TYPE','CLEAN_GENDER','CLASS_CODE','DT_FIRST_SEEN','DT_LAST_SEEN','DATA_PROVIDER_ORI','VIN','PLATE','LATITUDE','LONGITUDE','SEARCH_ADDR1','SEARCH_ADDR2','CLEAN_COMPANY_NAME','MAINNAME','FULLNAME');
EXPORT FieldNum(SALT33.StrType fn) := CASE(fn,'NAME_SUFFIX' => 0,'FNAME' => 1,'MNAME' => 2,'LNAME' => 3,'PRIM_RANGE' => 4,'PRIM_NAME' => 5,'SEC_RANGE' => 6,'P_CITY_NAME' => 7,'ST' => 8,'ZIP' => 9,'DOB' => 10,'PHONE' => 11,'DL_ST' => 12,'DL' => 13,'LEXID' => 14,'POSSIBLE_SSN' => 15,'CRIME' => 16,'NAME_TYPE' => 17,'CLEAN_GENDER' => 18,'CLASS_CODE' => 19,'DT_FIRST_SEEN' => 20,'DT_LAST_SEEN' => 21,'DATA_PROVIDER_ORI' => 22,'VIN' => 23,'PLATE' => 24,'LATITUDE' => 25,'LONGITUDE' => 26,'SEARCH_ADDR1' => 27,'SEARCH_ADDR2' => 28,'CLEAN_COMPANY_NAME' => 29,'MAINNAME' => 30,'FULLNAME' => 31,0);
 
//Individual field level validation
 
EXPORT Make_NAME_SUFFIX(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_NAME_SUFFIX(SALT33.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_NAME_SUFFIX(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_FNAME(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_FNAME(SALT33.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_FNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_MNAME(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_MNAME(SALT33.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_MNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_LNAME(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_LNAME(SALT33.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_LNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_PRIM_RANGE(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_PRIM_RANGE(SALT33.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_PRIM_RANGE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_PRIM_NAME(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_PRIM_NAME(SALT33.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_PRIM_NAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_SEC_RANGE(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SEC_RANGE(SALT33.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SEC_RANGE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_P_CITY_NAME(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_P_CITY_NAME(SALT33.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_P_CITY_NAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_ST(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_ST(SALT33.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_ST(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_ZIP(SALT33.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ZIP(SALT33.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ZIP(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);
 
EXPORT Make_DOB(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DOB(SALT33.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DOB(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_PHONE(SALT33.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_PHONE(SALT33.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_PHONE(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);
 
EXPORT Make_DL_ST(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DL_ST(SALT33.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DL_ST(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_DL(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DL(SALT33.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DL(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_LEXID(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_LEXID(SALT33.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_LEXID(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_POSSIBLE_SSN(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_POSSIBLE_SSN(SALT33.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_POSSIBLE_SSN(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_CRIME(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_CRIME(SALT33.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_CRIME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_NAME_TYPE(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_NAME_TYPE(SALT33.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_NAME_TYPE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_CLEAN_GENDER(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_CLEAN_GENDER(SALT33.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_CLEAN_GENDER(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_CLASS_CODE(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_CLASS_CODE(SALT33.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_CLASS_CODE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_DT_FIRST_SEEN(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DT_FIRST_SEEN(SALT33.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DT_FIRST_SEEN(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_DT_LAST_SEEN(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DT_LAST_SEEN(SALT33.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DT_LAST_SEEN(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_DATA_PROVIDER_ORI(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DATA_PROVIDER_ORI(SALT33.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DATA_PROVIDER_ORI(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_VIN(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_VIN(SALT33.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_VIN(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_PLATE(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_PLATE(SALT33.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_PLATE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_LATITUDE(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_LATITUDE(SALT33.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_LATITUDE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_LONGITUDE(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_LONGITUDE(SALT33.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_LONGITUDE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_SEARCH_ADDR1(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SEARCH_ADDR1(SALT33.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SEARCH_ADDR1(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_SEARCH_ADDR2(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SEARCH_ADDR2(SALT33.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SEARCH_ADDR2(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_CLEAN_COMPANY_NAME(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_CLEAN_COMPANY_NAME(SALT33.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_CLEAN_COMPANY_NAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_MAINNAME(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_MAINNAME(SALT33.StrType FNAME,SALT33.StrType MNAME,SALT33.StrType LNAME) := FALSE;
EXPORT InValidMessage_MAINNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_FULLNAME(SALT33.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_FULLNAME(SALT33.StrType MAINNAME,SALT33.StrType NAME_SUFFIX) := FALSE;
EXPORT InValidMessage_FULLNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT33,Bair_ExternalLinkKeys;
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
    BOOLEAN Diff_NAME_SUFFIX;
    BOOLEAN Diff_FNAME;
    BOOLEAN Diff_MNAME;
    BOOLEAN Diff_LNAME;
    BOOLEAN Diff_PRIM_RANGE;
    BOOLEAN Diff_PRIM_NAME;
    BOOLEAN Diff_SEC_RANGE;
    BOOLEAN Diff_P_CITY_NAME;
    BOOLEAN Diff_ST;
    BOOLEAN Diff_ZIP;
    BOOLEAN Diff_DOB;
    BOOLEAN Diff_PHONE;
    BOOLEAN Diff_DL_ST;
    BOOLEAN Diff_DL;
    BOOLEAN Diff_LEXID;
    BOOLEAN Diff_POSSIBLE_SSN;
    BOOLEAN Diff_CRIME;
    BOOLEAN Diff_NAME_TYPE;
    BOOLEAN Diff_CLEAN_GENDER;
    BOOLEAN Diff_CLASS_CODE;
    BOOLEAN Diff_DT_FIRST_SEEN;
    BOOLEAN Diff_DT_LAST_SEEN;
    BOOLEAN Diff_DATA_PROVIDER_ORI;
    BOOLEAN Diff_VIN;
    BOOLEAN Diff_PLATE;
    BOOLEAN Diff_LATITUDE;
    BOOLEAN Diff_LONGITUDE;
    BOOLEAN Diff_SEARCH_ADDR1;
    BOOLEAN Diff_SEARCH_ADDR2;
    BOOLEAN Diff_CLEAN_COMPANY_NAME;
    UNSIGNED Num_Diffs;
    SALT33.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_NAME_SUFFIX := le.NAME_SUFFIX <> ri.NAME_SUFFIX;
    SELF.Diff_FNAME := le.FNAME <> ri.FNAME;
    SELF.Diff_MNAME := le.MNAME <> ri.MNAME;
    SELF.Diff_LNAME := le.LNAME <> ri.LNAME;
    SELF.Diff_PRIM_RANGE := le.PRIM_RANGE <> ri.PRIM_RANGE;
    SELF.Diff_PRIM_NAME := le.PRIM_NAME <> ri.PRIM_NAME;
    SELF.Diff_SEC_RANGE := le.SEC_RANGE <> ri.SEC_RANGE;
    SELF.Diff_P_CITY_NAME := le.P_CITY_NAME <> ri.P_CITY_NAME;
    SELF.Diff_ST := le.ST <> ri.ST;
    SELF.Diff_ZIP := le.ZIP <> ri.ZIP;
    SELF.Diff_DOB := le.DOB <> ri.DOB;
    SELF.Diff_PHONE := le.PHONE <> ri.PHONE;
    SELF.Diff_DL_ST := le.DL_ST <> ri.DL_ST;
    SELF.Diff_DL := le.DL <> ri.DL;
    SELF.Diff_LEXID := le.LEXID <> ri.LEXID;
    SELF.Diff_POSSIBLE_SSN := le.POSSIBLE_SSN <> ri.POSSIBLE_SSN;
    SELF.Diff_CRIME := le.CRIME <> ri.CRIME;
    SELF.Diff_NAME_TYPE := le.NAME_TYPE <> ri.NAME_TYPE;
    SELF.Diff_CLEAN_GENDER := le.CLEAN_GENDER <> ri.CLEAN_GENDER;
    SELF.Diff_CLASS_CODE := le.CLASS_CODE <> ri.CLASS_CODE;
    SELF.Diff_DT_FIRST_SEEN := le.DT_FIRST_SEEN <> ri.DT_FIRST_SEEN;
    SELF.Diff_DT_LAST_SEEN := le.DT_LAST_SEEN <> ri.DT_LAST_SEEN;
    SELF.Diff_DATA_PROVIDER_ORI := le.DATA_PROVIDER_ORI <> ri.DATA_PROVIDER_ORI;
    SELF.Diff_VIN := le.VIN <> ri.VIN;
    SELF.Diff_PLATE := le.PLATE <> ri.PLATE;
    SELF.Diff_LATITUDE := le.LATITUDE <> ri.LATITUDE;
    SELF.Diff_LONGITUDE := le.LONGITUDE <> ri.LONGITUDE;
    SELF.Diff_SEARCH_ADDR1 := le.SEARCH_ADDR1 <> ri.SEARCH_ADDR1;
    SELF.Diff_SEARCH_ADDR2 := le.SEARCH_ADDR2 <> ri.SEARCH_ADDR2;
    SELF.Diff_CLEAN_COMPANY_NAME := le.CLEAN_COMPANY_NAME <> ri.CLEAN_COMPANY_NAME;
    SELF.Val := (SALT33.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_NAME_SUFFIX,1,0)+ IF( SELF.Diff_FNAME,1,0)+ IF( SELF.Diff_MNAME,1,0)+ IF( SELF.Diff_LNAME,1,0)+ IF( SELF.Diff_PRIM_RANGE,1,0)+ IF( SELF.Diff_PRIM_NAME,1,0)+ IF( SELF.Diff_SEC_RANGE,1,0)+ IF( SELF.Diff_P_CITY_NAME,1,0)+ IF( SELF.Diff_ST,1,0)+ IF( SELF.Diff_ZIP,1,0)+ IF( SELF.Diff_DOB,1,0)+ IF( SELF.Diff_PHONE,1,0)+ IF( SELF.Diff_DL_ST,1,0)+ IF( SELF.Diff_DL,1,0)+ IF( SELF.Diff_LEXID,1,0)+ IF( SELF.Diff_POSSIBLE_SSN,1,0)+ IF( SELF.Diff_CRIME,1,0)+ IF( SELF.Diff_NAME_TYPE,1,0)+ IF( SELF.Diff_CLEAN_GENDER,1,0)+ IF( SELF.Diff_CLASS_CODE,1,0)+ IF( SELF.Diff_DT_FIRST_SEEN,1,0)+ IF( SELF.Diff_DT_LAST_SEEN,1,0)+ IF( SELF.Diff_DATA_PROVIDER_ORI,1,0)+ IF( SELF.Diff_VIN,1,0)+ IF( SELF.Diff_PLATE,1,0)+ IF( SELF.Diff_LATITUDE,1,0)+ IF( SELF.Diff_LONGITUDE,1,0)+ IF( SELF.Diff_SEARCH_ADDR1,1,0)+ IF( SELF.Diff_SEARCH_ADDR2,1,0)+ IF( SELF.Diff_CLEAN_COMPANY_NAME,1,0);
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
    Count_Diff_NAME_SUFFIX := COUNT(GROUP,%Closest%.Diff_NAME_SUFFIX);
    Count_Diff_FNAME := COUNT(GROUP,%Closest%.Diff_FNAME);
    Count_Diff_MNAME := COUNT(GROUP,%Closest%.Diff_MNAME);
    Count_Diff_LNAME := COUNT(GROUP,%Closest%.Diff_LNAME);
    Count_Diff_PRIM_RANGE := COUNT(GROUP,%Closest%.Diff_PRIM_RANGE);
    Count_Diff_PRIM_NAME := COUNT(GROUP,%Closest%.Diff_PRIM_NAME);
    Count_Diff_SEC_RANGE := COUNT(GROUP,%Closest%.Diff_SEC_RANGE);
    Count_Diff_P_CITY_NAME := COUNT(GROUP,%Closest%.Diff_P_CITY_NAME);
    Count_Diff_ST := COUNT(GROUP,%Closest%.Diff_ST);
    Count_Diff_ZIP := COUNT(GROUP,%Closest%.Diff_ZIP);
    Count_Diff_DOB := COUNT(GROUP,%Closest%.Diff_DOB);
    Count_Diff_PHONE := COUNT(GROUP,%Closest%.Diff_PHONE);
    Count_Diff_DL_ST := COUNT(GROUP,%Closest%.Diff_DL_ST);
    Count_Diff_DL := COUNT(GROUP,%Closest%.Diff_DL);
    Count_Diff_LEXID := COUNT(GROUP,%Closest%.Diff_LEXID);
    Count_Diff_POSSIBLE_SSN := COUNT(GROUP,%Closest%.Diff_POSSIBLE_SSN);
    Count_Diff_CRIME := COUNT(GROUP,%Closest%.Diff_CRIME);
    Count_Diff_NAME_TYPE := COUNT(GROUP,%Closest%.Diff_NAME_TYPE);
    Count_Diff_CLEAN_GENDER := COUNT(GROUP,%Closest%.Diff_CLEAN_GENDER);
    Count_Diff_CLASS_CODE := COUNT(GROUP,%Closest%.Diff_CLASS_CODE);
    Count_Diff_DT_FIRST_SEEN := COUNT(GROUP,%Closest%.Diff_DT_FIRST_SEEN);
    Count_Diff_DT_LAST_SEEN := COUNT(GROUP,%Closest%.Diff_DT_LAST_SEEN);
    Count_Diff_DATA_PROVIDER_ORI := COUNT(GROUP,%Closest%.Diff_DATA_PROVIDER_ORI);
    Count_Diff_VIN := COUNT(GROUP,%Closest%.Diff_VIN);
    Count_Diff_PLATE := COUNT(GROUP,%Closest%.Diff_PLATE);
    Count_Diff_LATITUDE := COUNT(GROUP,%Closest%.Diff_LATITUDE);
    Count_Diff_LONGITUDE := COUNT(GROUP,%Closest%.Diff_LONGITUDE);
    Count_Diff_SEARCH_ADDR1 := COUNT(GROUP,%Closest%.Diff_SEARCH_ADDR1);
    Count_Diff_SEARCH_ADDR2 := COUNT(GROUP,%Closest%.Diff_SEARCH_ADDR2);
    Count_Diff_CLEAN_COMPANY_NAME := COUNT(GROUP,%Closest%.Diff_CLEAN_COMPANY_NAME);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
// Now determine the consistency of the identifiers
EXPORT UIDConsistency(infile) := FUNCTIONMACRO
  f := TABLE(infile,{EID_HASH}) : GLOBAL; // Consistent type independent of input
  m := MODULE
    r := RECORD
      UNSIGNED EID_HASH_null0 := COUNT(GROUP,(UNSIGNED)f.EID_HASH=0);
    END;
  EXPORT Basic0 := TABLE(f,r);
  EXPORT EID_HASH_Clusters := SALT33.MOD_ClusterStats.Counts(f,EID_HASH);
  EXPORT IdCounts := DATASET([{'EID_HASH_Cnt', SUM(EID_HASH_Clusters,NumberOfClusters)}],{STRING10 Count_Type, UNSIGNED Cnt}); // The counts of each ID
 // For deeper debugging; provide the unbased parents
 // Children with two parents
 // Now compute the more involved consistency checks
    r := RECORD
      {Basic0} AND NOT [];
    END;
  Advanced00 := TABLE(Basic0,r);
  Advanced0Layout := {STRING label, INTEGER null0, INTEGER belowparent0, INTEGER unbased0, INTEGER Twoparents0};
  EXPORT Advanced0 := SORT(SALT33.MAC_Pivot(Advanced00,Advanced0Layout), MAP(,0));
  END;
  RETURN m;
ENDMACRO;
END;
