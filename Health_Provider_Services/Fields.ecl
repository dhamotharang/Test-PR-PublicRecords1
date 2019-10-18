IMPORT SALT311;
EXPORT Fields := MODULE
 
EXPORT NumFields := 35;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'DEFAULT','NUMBER','ALPHA','ALPHANUM','WORDBAG');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'DEFAULT' => 1,'NUMBER' => 2,'ALPHA' => 3,'ALPHANUM' => 4,'WORDBAG' => 5,0);
 
EXPORT MakeFT_DEFAULT(SALT311.StrType s0) := FUNCTION
  s1 := if ( SALT311.StringFind('"\'',s0[1],1)>0 and SALT311.StringFind('"\'',s0[LENGTH(TRIM(s0))],1)>0,s0[2..LENGTH(TRIM(s0))-1],s0 );// Remove quotes if required
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_DEFAULT(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,SALT311.StringFind('"\'',s[1],1)<>0 and SALT311.StringFind('"\'',s[LENGTH(TRIM(s))],1)<>0);
EXPORT InValidMessageFT_DEFAULT(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.Inquotes('"\''),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_NUMBER(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_NUMBER(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789-'))));
EXPORT InValidMessageFT_NUMBER(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789-'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_ALPHA(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringtouppercase(s0); // Force to upper case
  s2 := SALT311.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s2;
END;
EXPORT InValidFT_ALPHA(SALT311.StrType s) := WHICH(SALT311.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_ALPHA(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotCaps,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_ALPHANUM(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringtouppercase(s0); // Force to upper case
  s2 := SALT311.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'); // Only allow valid symbols
  RETURN  s2;
END;
EXPORT InValidFT_ALPHANUM(SALT311.StrType s) := WHICH(SALT311.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'))));
EXPORT InValidMessageFT_ALPHANUM(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotCaps,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_WORDBAG(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringtouppercase(s0); // Force to upper case
  s2 := SALT311.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
  s3 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_WORDBAG(SALT311.StrType s) := WHICH(SALT311.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))));
EXPORT InValidMessageFT_WORDBAG(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotCaps,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'FNAME','MNAME','LNAME','SNAME','GENDER','PRIM_RANGE','PRIM_NAME','SEC_RANGE','V_CITY_NAME','ST','ZIP','SSN','CNSMR_SSN','DOB','CNSMR_DOB','PHONE','LIC_STATE','C_LIC_NBR','TAX_ID','BILLING_TAX_ID','DEA_NUMBER','VENDOR_ID','NPI_NUMBER','BILLING_NPI_NUMBER','UPIN','DID','BDID','SRC','SOURCE_RID','RID','MAINNAME','FULLNAME','ADDR1','LOCALE','ADDRESS');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'FNAME','MNAME','LNAME','SNAME','GENDER','PRIM_RANGE','PRIM_NAME','SEC_RANGE','V_CITY_NAME','ST','ZIP','SSN','CNSMR_SSN','DOB','CNSMR_DOB','PHONE','LIC_STATE','C_LIC_NBR','TAX_ID','BILLING_TAX_ID','DEA_NUMBER','VENDOR_ID','NPI_NUMBER','BILLING_NPI_NUMBER','UPIN','DID','BDID','SRC','SOURCE_RID','RID','MAINNAME','FULLNAME','ADDR1','LOCALE','ADDRESS');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'FNAME' => 0,'MNAME' => 1,'LNAME' => 2,'SNAME' => 3,'GENDER' => 4,'PRIM_RANGE' => 5,'PRIM_NAME' => 6,'SEC_RANGE' => 7,'V_CITY_NAME' => 8,'ST' => 9,'ZIP' => 10,'SSN' => 11,'CNSMR_SSN' => 12,'DOB' => 13,'CNSMR_DOB' => 14,'PHONE' => 15,'LIC_STATE' => 16,'C_LIC_NBR' => 17,'TAX_ID' => 18,'BILLING_TAX_ID' => 19,'DEA_NUMBER' => 20,'VENDOR_ID' => 21,'NPI_NUMBER' => 22,'BILLING_NPI_NUMBER' => 23,'UPIN' => 24,'DID' => 25,'BDID' => 26,'SRC' => 27,'SOURCE_RID' => 28,'RID' => 29,'MAINNAME' => 30,'FULLNAME' => 31,'ADDR1' => 32,'LOCALE' => 33,'ADDRESS' => 34,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE);
 
//Individual field level validation
 
EXPORT Make_FNAME(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_FNAME(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_FNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_MNAME(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_MNAME(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_MNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_LNAME(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_LNAME(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_LNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_SNAME(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SNAME(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_GENDER(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_GENDER(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_GENDER(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_PRIM_RANGE(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_PRIM_RANGE(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_PRIM_RANGE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_PRIM_NAME(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_PRIM_NAME(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_PRIM_NAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_SEC_RANGE(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SEC_RANGE(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SEC_RANGE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_V_CITY_NAME(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_V_CITY_NAME(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_V_CITY_NAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_ST(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_ST(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_ST(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_ZIP(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_ZIP(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_ZIP(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_SSN(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SSN(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SSN(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_CNSMR_SSN(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_CNSMR_SSN(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_CNSMR_SSN(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_DOB(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DOB(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DOB(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_CNSMR_DOB(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_CNSMR_DOB(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_CNSMR_DOB(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_PHONE(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_PHONE(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_PHONE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_LIC_STATE(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_LIC_STATE(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_LIC_STATE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_C_LIC_NBR(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_C_LIC_NBR(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_C_LIC_NBR(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_TAX_ID(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_TAX_ID(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_TAX_ID(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_BILLING_TAX_ID(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_BILLING_TAX_ID(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_BILLING_TAX_ID(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_DEA_NUMBER(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DEA_NUMBER(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DEA_NUMBER(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_VENDOR_ID(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_VENDOR_ID(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_VENDOR_ID(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_NPI_NUMBER(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_NPI_NUMBER(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_NPI_NUMBER(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_BILLING_NPI_NUMBER(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_BILLING_NPI_NUMBER(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_BILLING_NPI_NUMBER(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_UPIN(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_UPIN(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_UPIN(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_DID(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DID(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DID(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_BDID(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_BDID(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_BDID(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_SRC(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SRC(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SRC(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_SOURCE_RID(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SOURCE_RID(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SOURCE_RID(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_RID(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_RID(SALT311.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_RID(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_MAINNAME(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_MAINNAME(SALT311.StrType FNAME,SALT311.StrType MNAME,SALT311.StrType LNAME) := WHICH(InValid_FNAME(FNAME)>0,InValid_MNAME(MNAME)>0,InValid_LNAME(LNAME)>0);
EXPORT InValidMessage_MAINNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_FULLNAME(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_FULLNAME(SALT311.StrType FNAME,SALT311.StrType MNAME,SALT311.StrType LNAME,SALT311.StrType SNAME) := WHICH(InValid_FNAME(FNAME)>0,InValid_MNAME(MNAME)>0,InValid_LNAME(LNAME)>0,InValid_SNAME(SNAME)>0);
EXPORT InValidMessage_FULLNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_ADDR1(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_ADDR1(SALT311.StrType PRIM_NAME,SALT311.StrType PRIM_RANGE,SALT311.StrType SEC_RANGE) := WHICH(InValid_PRIM_NAME(PRIM_NAME)>0,InValid_PRIM_RANGE(PRIM_RANGE)>0,InValid_SEC_RANGE(SEC_RANGE)>0);
EXPORT InValidMessage_ADDR1(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_LOCALE(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_LOCALE(SALT311.StrType V_CITY_NAME,SALT311.StrType ST,SALT311.StrType ZIP) := WHICH(InValid_V_CITY_NAME(V_CITY_NAME)>0,InValid_ST(ST)>0,InValid_ZIP(ZIP)>0);
EXPORT InValidMessage_LOCALE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_ADDRESS(SALT311.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_ADDRESS(SALT311.StrType PRIM_NAME,SALT311.StrType PRIM_RANGE,SALT311.StrType SEC_RANGE,SALT311.StrType V_CITY_NAME,SALT311.StrType ST,SALT311.StrType ZIP) := WHICH(InValid_PRIM_NAME(PRIM_NAME)>0,InValid_PRIM_RANGE(PRIM_RANGE)>0,InValid_SEC_RANGE(SEC_RANGE)>0,InValid_V_CITY_NAME(V_CITY_NAME)>0,InValid_ST(ST)>0,InValid_ZIP(ZIP)>0);
EXPORT InValidMessage_ADDRESS(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Health_Provider_Services;
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
    SALT311.StrType Val {MAXLENGTH(1024)};
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
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
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
  IMPORT Health_Provider_Services,SALT311;
  f := TABLE(infile,{LNPID}) : GLOBAL; // Consistent type independent of input
  m := MODULE
    r := RECORD
      UNSIGNED LNPID_null0 := COUNT(GROUP,(UNSIGNED)f.LNPID=0);
    END;
    EXPORT Basic0 := TABLE(f,r);
    EXPORT LNPID_Clusters := SALT311.MOD_ClusterStats.Counts(f,LNPID);
    EXPORT IdCounts := DATASET([{'LNPID_Cnt', SUM(LNPID_Clusters,NumberOfClusters)}],{STRING10 Count_Type, UNSIGNED Cnt}); // The counts of each ID
  END;
  RETURN m;
ENDMACRO;
END;
