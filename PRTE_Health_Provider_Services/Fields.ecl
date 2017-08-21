IMPORT ut,SALT29;
EXPORT Fields := MODULE
// Processing for each FieldType
EXPORT SALT29.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'DEFAULT','NUMBER','ALPHA','ALPHANUM','WORDBAG');
EXPORT FieldTypeNum(SALT29.StrType fn) := CASE(fn,'DEFAULT' => 1,'NUMBER' => 2,'ALPHA' => 3,'ALPHANUM' => 4,'WORDBAG' => 5,0);
EXPORT MakeFT_DEFAULT(SALT29.StrType s0) := FUNCTION
  s1 := if ( SALT29.StringFind('"\'',s0[1],1)>0 and SALT29.StringFind('"\'',s0[LENGTH(TRIM(s0))],1)>0,s0[2..LENGTH(TRIM(s0))-1],s0 );// Remove quotes if required
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_DEFAULT(SALT29.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,SALT29.StringFind('"\'',s[1],1)<>0 and SALT29.StringFind('"\'',s[LENGTH(TRIM(s))],1)<>0);
EXPORT InValidMessageFT_DEFAULT(UNSIGNED1 wh) := CHOOSE(wh,SALT29.HygieneErrors.NotLeft,SALT29.HygieneErrors.Inquotes('"\''),SALT29.HygieneErrors.Good);
EXPORT MakeFT_NUMBER(SALT29.StrType s0) := FUNCTION
  s1 := SALT29.stringfilter(s0,'0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_NUMBER(SALT29.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT29.StringFilter(s,'0123456789-'))));
EXPORT InValidMessageFT_NUMBER(UNSIGNED1 wh) := CHOOSE(wh,SALT29.HygieneErrors.NotInChars('0123456789-'),SALT29.HygieneErrors.Good);
EXPORT MakeFT_ALPHA(SALT29.StrType s0) := FUNCTION
  s1 := SALT29.stringtouppercase(s0); // Force to upper case
  s2 := SALT29.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s2;
END;
EXPORT InValidFT_ALPHA(SALT29.StrType s) := WHICH(SALT29.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT29.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_ALPHA(UNSIGNED1 wh) := CHOOSE(wh,SALT29.HygieneErrors.NotCaps,SALT29.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT29.HygieneErrors.Good);
EXPORT MakeFT_ALPHANUM(SALT29.StrType s0) := FUNCTION
  s1 := SALT29.stringtouppercase(s0); // Force to upper case
  s2 := SALT29.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'); // Only allow valid symbols
  RETURN  s2;
END;
EXPORT InValidFT_ALPHANUM(SALT29.StrType s) := WHICH(SALT29.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT29.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'))));
EXPORT InValidMessageFT_ALPHANUM(UNSIGNED1 wh) := CHOOSE(wh,SALT29.HygieneErrors.NotCaps,SALT29.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'),SALT29.HygieneErrors.Good);
EXPORT MakeFT_WORDBAG(SALT29.StrType s0) := FUNCTION
  s1 := SALT29.stringtouppercase(s0); // Force to upper case
  s2 := SALT29.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
  s3 := SALT29.stringcleanspaces( SALT29.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_WORDBAG(SALT29.StrType s) := WHICH(SALT29.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT29.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))));
EXPORT InValidMessageFT_WORDBAG(UNSIGNED1 wh) := CHOOSE(wh,SALT29.HygieneErrors.NotCaps,SALT29.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'),SALT29.HygieneErrors.Good);
EXPORT SALT29.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'FNAME','MNAME','LNAME','SNAME','GENDER','PRIM_RANGE','PRIM_NAME','SEC_RANGE','V_CITY_NAME','ST','ZIP','SSN','CNSMR_SSN','DOB','CNSMR_DOB','PHONE','LIC_STATE','C_LIC_NBR','TAX_ID','BILLING_TAX_ID','DEA_NUMBER','VENDOR_ID','NPI_NUMBER','BILLING_NPI_NUMBER','UPIN','DID','BDID','SRC','SOURCE_RID','RID','MAINNAME','FULLNAME','ADDR1','LOCALE','ADDRESS');
EXPORT FieldNum(SALT29.StrType fn) := CASE(fn,'FNAME' => 1,'MNAME' => 2,'LNAME' => 3,'SNAME' => 4,'GENDER' => 5,'PRIM_RANGE' => 6,'PRIM_NAME' => 7,'SEC_RANGE' => 8,'V_CITY_NAME' => 9,'ST' => 10,'ZIP' => 11,'SSN' => 12,'CNSMR_SSN' => 13,'DOB' => 14,'CNSMR_DOB' => 15,'PHONE' => 16,'LIC_STATE' => 17,'C_LIC_NBR' => 18,'TAX_ID' => 19,'BILLING_TAX_ID' => 20,'DEA_NUMBER' => 21,'VENDOR_ID' => 22,'NPI_NUMBER' => 23,'BILLING_NPI_NUMBER' => 24,'UPIN' => 25,'DID' => 26,'BDID' => 27,'SRC' => 28,'SOURCE_RID' => 29,'RID' => 30,'MAINNAME' => 31,'FULLNAME' => 32,'ADDR1' => 33,'LOCALE' => 34,'ADDRESS' => 35,0);
//Individual field level validation
EXPORT Make_FNAME(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_FNAME(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_FNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_MNAME(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_MNAME(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_MNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_LNAME(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_LNAME(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_LNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_SNAME(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SNAME(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_GENDER(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_GENDER(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_GENDER(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_PRIM_RANGE(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_PRIM_RANGE(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_PRIM_RANGE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_PRIM_NAME(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_PRIM_NAME(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_PRIM_NAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_SEC_RANGE(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SEC_RANGE(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SEC_RANGE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_V_CITY_NAME(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_V_CITY_NAME(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_V_CITY_NAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_ST(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_ST(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_ST(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_ZIP(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_ZIP(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_ZIP(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_SSN(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SSN(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SSN(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_CNSMR_SSN(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_CNSMR_SSN(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_CNSMR_SSN(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_DOB(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DOB(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DOB(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_CNSMR_DOB(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_CNSMR_DOB(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_CNSMR_DOB(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_PHONE(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_PHONE(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_PHONE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_LIC_STATE(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_LIC_STATE(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_LIC_STATE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_C_LIC_NBR(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_C_LIC_NBR(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_C_LIC_NBR(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_TAX_ID(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_TAX_ID(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_TAX_ID(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_BILLING_TAX_ID(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_BILLING_TAX_ID(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_BILLING_TAX_ID(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_DEA_NUMBER(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DEA_NUMBER(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DEA_NUMBER(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_VENDOR_ID(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_VENDOR_ID(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_VENDOR_ID(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_NPI_NUMBER(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_NPI_NUMBER(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_NPI_NUMBER(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_BILLING_NPI_NUMBER(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_BILLING_NPI_NUMBER(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_BILLING_NPI_NUMBER(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_UPIN(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_UPIN(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_UPIN(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_DID(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DID(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DID(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_BDID(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_BDID(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_BDID(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_SRC(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SRC(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SRC(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_SOURCE_RID(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SOURCE_RID(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SOURCE_RID(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_RID(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_RID(SALT29.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_RID(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_MAINNAME(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_MAINNAME(SALT29.StrType FNAME,SALT29.StrType MNAME,SALT29.StrType LNAME) := FALSE;
EXPORT InValidMessage_MAINNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_FULLNAME(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_FULLNAME(SALT29.StrType MAINNAME,SALT29.StrType SNAME) := FALSE;
EXPORT InValidMessage_FULLNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_ADDR1(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_ADDR1(SALT29.StrType PRIM_NAME,SALT29.StrType PRIM_RANGE,SALT29.StrType SEC_RANGE) := FALSE;
EXPORT InValidMessage_ADDR1(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_LOCALE(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_LOCALE(SALT29.StrType V_CITY_NAME,SALT29.StrType ST,SALT29.StrType ZIP) := FALSE;
EXPORT InValidMessage_LOCALE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_ADDRESS(SALT29.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_ADDRESS(SALT29.StrType ADDR1,SALT29.StrType LOCALE) := FALSE;
EXPORT InValidMessage_ADDRESS(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT29,PRTE_Health_Provider_Services;
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
    BOOLEAN Diff_FNAME;
    BOOLEAN Diff_MNAME;
    BOOLEAN Diff_LNAME;
    BOOLEAN Diff_SNAME;
    BOOLEAN Diff_GENDER;
    BOOLEAN Diff_PRIM_RANGE;
    BOOLEAN Diff_PRIM_NAME;
    BOOLEAN Diff_SEC_RANGE;
    BOOLEAN Diff_V_CITY_NAME;
    BOOLEAN Diff_ST;
    BOOLEAN Diff_ZIP;
    BOOLEAN Diff_SSN;
    BOOLEAN Diff_CNSMR_SSN;
    BOOLEAN Diff_DOB;
    BOOLEAN Diff_CNSMR_DOB;
    BOOLEAN Diff_PHONE;
    BOOLEAN Diff_LIC_STATE;
    BOOLEAN Diff_C_LIC_NBR;
    BOOLEAN Diff_TAX_ID;
    BOOLEAN Diff_BILLING_TAX_ID;
    BOOLEAN Diff_DEA_NUMBER;
    BOOLEAN Diff_VENDOR_ID;
    BOOLEAN Diff_NPI_NUMBER;
    BOOLEAN Diff_BILLING_NPI_NUMBER;
    BOOLEAN Diff_UPIN;
    BOOLEAN Diff_DID;
    BOOLEAN Diff_BDID;
    BOOLEAN Diff_SRC;
    BOOLEAN Diff_SOURCE_RID;
    BOOLEAN Diff_RID;
    UNSIGNED Num_Diffs;
    SALT29.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_FNAME := le.FNAME <> ri.FNAME;
    SELF.Diff_MNAME := le.MNAME <> ri.MNAME;
    SELF.Diff_LNAME := le.LNAME <> ri.LNAME;
    SELF.Diff_SNAME := le.SNAME <> ri.SNAME;
    SELF.Diff_GENDER := le.GENDER <> ri.GENDER;
    SELF.Diff_PRIM_RANGE := le.PRIM_RANGE <> ri.PRIM_RANGE;
    SELF.Diff_PRIM_NAME := le.PRIM_NAME <> ri.PRIM_NAME;
    SELF.Diff_SEC_RANGE := le.SEC_RANGE <> ri.SEC_RANGE;
    SELF.Diff_V_CITY_NAME := le.V_CITY_NAME <> ri.V_CITY_NAME;
    SELF.Diff_ST := le.ST <> ri.ST;
    SELF.Diff_ZIP := le.ZIP <> ri.ZIP;
    SELF.Diff_SSN := le.SSN <> ri.SSN;
    SELF.Diff_CNSMR_SSN := le.CNSMR_SSN <> ri.CNSMR_SSN;
    SELF.Diff_DOB := le.DOB <> ri.DOB;
    SELF.Diff_CNSMR_DOB := le.CNSMR_DOB <> ri.CNSMR_DOB;
    SELF.Diff_PHONE := le.PHONE <> ri.PHONE;
    SELF.Diff_LIC_STATE := le.LIC_STATE <> ri.LIC_STATE;
    SELF.Diff_C_LIC_NBR := le.C_LIC_NBR <> ri.C_LIC_NBR;
    SELF.Diff_TAX_ID := le.TAX_ID <> ri.TAX_ID;
    SELF.Diff_BILLING_TAX_ID := le.BILLING_TAX_ID <> ri.BILLING_TAX_ID;
    SELF.Diff_DEA_NUMBER := le.DEA_NUMBER <> ri.DEA_NUMBER;
    SELF.Diff_VENDOR_ID := le.VENDOR_ID <> ri.VENDOR_ID;
    SELF.Diff_NPI_NUMBER := le.NPI_NUMBER <> ri.NPI_NUMBER;
    SELF.Diff_BILLING_NPI_NUMBER := le.BILLING_NPI_NUMBER <> ri.BILLING_NPI_NUMBER;
    SELF.Diff_UPIN := le.UPIN <> ri.UPIN;
    SELF.Diff_DID := le.DID <> ri.DID;
    SELF.Diff_BDID := le.BDID <> ri.BDID;
    SELF.Diff_SRC := le.SRC <> ri.SRC;
    SELF.Diff_SOURCE_RID := le.SOURCE_RID <> ri.SOURCE_RID;
    SELF.Diff_RID := le.RID <> ri.RID;
    SELF.Val := (SALT29.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_FNAME,1,0)+ IF( SELF.Diff_MNAME,1,0)+ IF( SELF.Diff_LNAME,1,0)+ IF( SELF.Diff_SNAME,1,0)+ IF( SELF.Diff_GENDER,1,0)+ IF( SELF.Diff_PRIM_RANGE,1,0)+ IF( SELF.Diff_PRIM_NAME,1,0)+ IF( SELF.Diff_SEC_RANGE,1,0)+ IF( SELF.Diff_V_CITY_NAME,1,0)+ IF( SELF.Diff_ST,1,0)+ IF( SELF.Diff_ZIP,1,0)+ IF( SELF.Diff_SSN,1,0)+ IF( SELF.Diff_CNSMR_SSN,1,0)+ IF( SELF.Diff_DOB,1,0)+ IF( SELF.Diff_CNSMR_DOB,1,0)+ IF( SELF.Diff_PHONE,1,0)+ IF( SELF.Diff_LIC_STATE,1,0)+ IF( SELF.Diff_C_LIC_NBR,1,0)+ IF( SELF.Diff_TAX_ID,1,0)+ IF( SELF.Diff_BILLING_TAX_ID,1,0)+ IF( SELF.Diff_DEA_NUMBER,1,0)+ IF( SELF.Diff_VENDOR_ID,1,0)+ IF( SELF.Diff_NPI_NUMBER,1,0)+ IF( SELF.Diff_BILLING_NPI_NUMBER,1,0)+ IF( SELF.Diff_UPIN,1,0)+ IF( SELF.Diff_DID,1,0)+ IF( SELF.Diff_BDID,1,0)+ IF( SELF.Diff_SRC,1,0)+ IF( SELF.Diff_SOURCE_RID,1,0)+ IF( SELF.Diff_RID,1,0);
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
    Count_Diff_FNAME := COUNT(GROUP,%Closest%.Diff_FNAME);
    Count_Diff_MNAME := COUNT(GROUP,%Closest%.Diff_MNAME);
    Count_Diff_LNAME := COUNT(GROUP,%Closest%.Diff_LNAME);
    Count_Diff_SNAME := COUNT(GROUP,%Closest%.Diff_SNAME);
    Count_Diff_GENDER := COUNT(GROUP,%Closest%.Diff_GENDER);
    Count_Diff_PRIM_RANGE := COUNT(GROUP,%Closest%.Diff_PRIM_RANGE);
    Count_Diff_PRIM_NAME := COUNT(GROUP,%Closest%.Diff_PRIM_NAME);
    Count_Diff_SEC_RANGE := COUNT(GROUP,%Closest%.Diff_SEC_RANGE);
    Count_Diff_V_CITY_NAME := COUNT(GROUP,%Closest%.Diff_V_CITY_NAME);
    Count_Diff_ST := COUNT(GROUP,%Closest%.Diff_ST);
    Count_Diff_ZIP := COUNT(GROUP,%Closest%.Diff_ZIP);
    Count_Diff_SSN := COUNT(GROUP,%Closest%.Diff_SSN);
    Count_Diff_CNSMR_SSN := COUNT(GROUP,%Closest%.Diff_CNSMR_SSN);
    Count_Diff_DOB := COUNT(GROUP,%Closest%.Diff_DOB);
    Count_Diff_CNSMR_DOB := COUNT(GROUP,%Closest%.Diff_CNSMR_DOB);
    Count_Diff_PHONE := COUNT(GROUP,%Closest%.Diff_PHONE);
    Count_Diff_LIC_STATE := COUNT(GROUP,%Closest%.Diff_LIC_STATE);
    Count_Diff_C_LIC_NBR := COUNT(GROUP,%Closest%.Diff_C_LIC_NBR);
    Count_Diff_TAX_ID := COUNT(GROUP,%Closest%.Diff_TAX_ID);
    Count_Diff_BILLING_TAX_ID := COUNT(GROUP,%Closest%.Diff_BILLING_TAX_ID);
    Count_Diff_DEA_NUMBER := COUNT(GROUP,%Closest%.Diff_DEA_NUMBER);
    Count_Diff_VENDOR_ID := COUNT(GROUP,%Closest%.Diff_VENDOR_ID);
    Count_Diff_NPI_NUMBER := COUNT(GROUP,%Closest%.Diff_NPI_NUMBER);
    Count_Diff_BILLING_NPI_NUMBER := COUNT(GROUP,%Closest%.Diff_BILLING_NPI_NUMBER);
    Count_Diff_UPIN := COUNT(GROUP,%Closest%.Diff_UPIN);
    Count_Diff_DID := COUNT(GROUP,%Closest%.Diff_DID);
    Count_Diff_BDID := COUNT(GROUP,%Closest%.Diff_BDID);
    Count_Diff_SRC := COUNT(GROUP,%Closest%.Diff_SRC);
    Count_Diff_SOURCE_RID := COUNT(GROUP,%Closest%.Diff_SOURCE_RID);
    Count_Diff_RID := COUNT(GROUP,%Closest%.Diff_RID);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
// Now determine the consistency of the identifiers
EXPORT UIDConsistency(infile) := FUNCTIONMACRO
  f := TABLE(infile,{LNPID}); // Consistent type independent of input
  m := MODULE
    r := RECORD
      UNSIGNED LNPID_null0 := COUNT(GROUP,(UNSIGNED)f.LNPID=0);
    END;
  EXPORT Basic0 := TABLE(f,r);
  EXPORT LNPID_Clusters := SALT29.MOD_ClusterStats.Counts(f,LNPID);
  EXPORT IdCounts := DATASET([{SUM(LNPID_Clusters,NumberOfClusters)}],{UNSIGNED LNPID_Count}); // The counts of each ID
 // For deeper debugging; provide the unbased parents
 // Children with two parents
 // Now compute the more involved consistency checks
    r := RECORD
      {Basic0} AND NOT [];
    END;
  EXPORT Advanced0 := TABLE(Basic0,r);
  END;
  RETURN m;
ENDMACRO;
END;
