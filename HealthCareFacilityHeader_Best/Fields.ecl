IMPORT ut,SALT30;
EXPORT Fields := MODULE
// Processing for each FieldType
EXPORT SALT30.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'DEFAULT','NUMBER','ALPHA','ALPHANUM','WORDBAG');
EXPORT FieldTypeNum(SALT30.StrType fn) := CASE(fn,'DEFAULT' => 1,'NUMBER' => 2,'ALPHA' => 3,'ALPHANUM' => 4,'WORDBAG' => 5,0);
EXPORT MakeFT_DEFAULT(SALT30.StrType s0) := FUNCTION
  s1 := if ( SALT30.StringFind('"\'',s0[1],1)>0 and SALT30.StringFind('"\'',s0[LENGTH(TRIM(s0))],1)>0,s0[2..LENGTH(TRIM(s0))-1],s0 );// Remove quotes if required
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_DEFAULT(SALT30.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,SALT30.StringFind('"\'',s[1],1)<>0 and SALT30.StringFind('"\'',s[LENGTH(TRIM(s))],1)<>0);
EXPORT InValidMessageFT_DEFAULT(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotLeft,SALT30.HygieneErrors.Inquotes('"\''),SALT30.HygieneErrors.Good);
EXPORT MakeFT_NUMBER(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_NUMBER(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789-'))));
EXPORT InValidMessageFT_NUMBER(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789-'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_ALPHA(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringtouppercase(s0); // Force to upper case
  s2 := SALT30.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s2;
END;
EXPORT InValidFT_ALPHA(SALT30.StrType s) := WHICH(SALT30.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_ALPHA(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotCaps,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_ALPHANUM(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringtouppercase(s0); // Force to upper case
  s2 := SALT30.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'); // Only allow valid symbols
  RETURN  s2;
END;
EXPORT InValidFT_ALPHANUM(SALT30.StrType s) := WHICH(SALT30.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'))));
EXPORT InValidMessageFT_ALPHANUM(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotCaps,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_WORDBAG(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringtouppercase(s0); // Force to upper case
  s2 := SALT30.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
  s3 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_WORDBAG(SALT30.StrType s) := WHICH(SALT30.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))));
EXPORT InValidMessageFT_WORDBAG(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotCaps,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'),SALT30.HygieneErrors.Good);
EXPORT SALT30.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'PHONE','FAX','UPIN','NPI_NUMBER','DEA_NUMBER','CLIA_NUMBER','MEDICARE_FACILITY_NUMBER','NCPDP_NUMBER','TAX_ID','FEIN','C_LIC_NBR','SRC','CNAME','CNP_NAME','CNP_NUMBER','CNP_STORE_NUMBER','CNP_BTYPE','CNP_LOWV','CNP_TRANSLATED','CNP_CLASSID','ADDRESS_ID','ADDRESS_CLASSIFICATION','PRIM_RANGE','PRIM_NAME','SEC_RANGE','ST','V_CITY_NAME','ZIP','TAXONOMY','TAXONOMY_CODE','MEDICAID_NUMBER','VENDOR_ID','DT_FIRST_SEEN','DT_LAST_SEEN','DT_LIC_EXPIRATION','DT_DEA_EXPIRATION','FAC_NAME','ADDR1','LOCALE','ADDRESS','LIC_STATE');
EXPORT FieldNum(SALT30.StrType fn) := CASE(fn,'PHONE' => 1,'FAX' => 2,'UPIN' => 3,'NPI_NUMBER' => 4,'DEA_NUMBER' => 5,'CLIA_NUMBER' => 6,'MEDICARE_FACILITY_NUMBER' => 7,'NCPDP_NUMBER' => 8,'TAX_ID' => 9,'FEIN' => 10,'C_LIC_NBR' => 11,'SRC' => 12,'CNAME' => 13,'CNP_NAME' => 14,'CNP_NUMBER' => 15,'CNP_STORE_NUMBER' => 16,'CNP_BTYPE' => 17,'CNP_LOWV' => 18,'CNP_TRANSLATED' => 19,'CNP_CLASSID' => 20,'ADDRESS_ID' => 21,'ADDRESS_CLASSIFICATION' => 22,'PRIM_RANGE' => 23,'PRIM_NAME' => 24,'SEC_RANGE' => 25,'ST' => 26,'V_CITY_NAME' => 27,'ZIP' => 28,'TAXONOMY' => 29,'TAXONOMY_CODE' => 30,'MEDICAID_NUMBER' => 31,'VENDOR_ID' => 32,'DT_FIRST_SEEN' => 33,'DT_LAST_SEEN' => 34,'DT_LIC_EXPIRATION' => 35,'DT_DEA_EXPIRATION' => 36,'FAC_NAME' => 37,'ADDR1' => 38,'LOCALE' => 39,'ADDRESS' => 40,'LIC_STATE' => 41,0);
//Individual field level validation
EXPORT Make_PHONE(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_PHONE(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_PHONE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_FAX(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_FAX(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_FAX(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_UPIN(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_UPIN(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_UPIN(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_NPI_NUMBER(SALT30.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_NPI_NUMBER(SALT30.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_NPI_NUMBER(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);
EXPORT Make_DEA_NUMBER(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DEA_NUMBER(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DEA_NUMBER(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_CLIA_NUMBER(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_CLIA_NUMBER(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_CLIA_NUMBER(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_MEDICARE_FACILITY_NUMBER(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_MEDICARE_FACILITY_NUMBER(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_MEDICARE_FACILITY_NUMBER(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_NCPDP_NUMBER(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_NCPDP_NUMBER(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_NCPDP_NUMBER(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_TAX_ID(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_TAX_ID(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_TAX_ID(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_FEIN(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_FEIN(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_FEIN(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_C_LIC_NBR(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_C_LIC_NBR(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_C_LIC_NBR(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_SRC(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SRC(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SRC(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_CNAME(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_CNAME(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_CNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_CNP_NAME(SALT30.StrType s0) := MakeFT_WORDBAG(s0);
EXPORT InValid_CNP_NAME(SALT30.StrType s) := InValidFT_WORDBAG(s);
EXPORT InValidMessage_CNP_NAME(UNSIGNED1 wh) := InValidMessageFT_WORDBAG(wh);
EXPORT Make_CNP_NUMBER(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_CNP_NUMBER(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_CNP_NUMBER(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_CNP_STORE_NUMBER(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_CNP_STORE_NUMBER(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_CNP_STORE_NUMBER(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_CNP_BTYPE(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_CNP_BTYPE(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_CNP_BTYPE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_CNP_LOWV(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_CNP_LOWV(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_CNP_LOWV(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_CNP_TRANSLATED(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_CNP_TRANSLATED(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_CNP_TRANSLATED(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_CNP_CLASSID(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_CNP_CLASSID(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_CNP_CLASSID(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_ADDRESS_ID(SALT30.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ADDRESS_ID(SALT30.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ADDRESS_ID(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);
EXPORT Make_ADDRESS_CLASSIFICATION(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_ADDRESS_CLASSIFICATION(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_ADDRESS_CLASSIFICATION(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_PRIM_RANGE(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_PRIM_RANGE(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_PRIM_RANGE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_PRIM_NAME(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_PRIM_NAME(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_PRIM_NAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_SEC_RANGE(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SEC_RANGE(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SEC_RANGE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_ST(SALT30.StrType s0) := MakeFT_ALPHA(s0);
EXPORT InValid_ST(SALT30.StrType s) := InValidFT_ALPHA(s);
EXPORT InValidMessage_ST(UNSIGNED1 wh) := InValidMessageFT_ALPHA(wh);
EXPORT Make_V_CITY_NAME(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_V_CITY_NAME(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_V_CITY_NAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_ZIP(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_ZIP(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_ZIP(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_TAXONOMY(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_TAXONOMY(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_TAXONOMY(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_TAXONOMY_CODE(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_TAXONOMY_CODE(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_TAXONOMY_CODE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_MEDICAID_NUMBER(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_MEDICAID_NUMBER(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_MEDICAID_NUMBER(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_VENDOR_ID(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_VENDOR_ID(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_VENDOR_ID(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_DT_FIRST_SEEN(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DT_FIRST_SEEN(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DT_FIRST_SEEN(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_DT_LAST_SEEN(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DT_LAST_SEEN(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DT_LAST_SEEN(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_DT_LIC_EXPIRATION(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DT_LIC_EXPIRATION(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DT_LIC_EXPIRATION(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_DT_DEA_EXPIRATION(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DT_DEA_EXPIRATION(SALT30.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DT_DEA_EXPIRATION(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_FAC_NAME(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_FAC_NAME(SALT30.StrType CNP_NAME,SALT30.StrType CNP_NUMBER,SALT30.StrType CNP_STORE_NUMBER,SALT30.StrType CNP_BTYPE) := FALSE;
EXPORT InValidMessage_FAC_NAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_ADDR1(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_ADDR1(SALT30.StrType PRIM_RANGE,SALT30.StrType PRIM_NAME,SALT30.StrType SEC_RANGE) := FALSE;
EXPORT InValidMessage_ADDR1(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_LOCALE(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_LOCALE(SALT30.StrType V_CITY_NAME,SALT30.StrType ST,SALT30.StrType ZIP) := FALSE;
EXPORT InValidMessage_LOCALE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_ADDRESS(SALT30.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_ADDRESS(SALT30.StrType ADDR1,SALT30.StrType LOCALE) := FALSE;
EXPORT InValidMessage_ADDRESS(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
EXPORT Make_LIC_STATE(SALT30.StrType s0) := s0;
EXPORT InValid_LIC_STATE(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_LIC_STATE(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT30,HealthCareFacilityHeader_Best;
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
    BOOLEAN Diff_PHONE;
    BOOLEAN Diff_FAX;
    BOOLEAN Diff_UPIN;
    BOOLEAN Diff_NPI_NUMBER;
    BOOLEAN Diff_DEA_NUMBER;
    BOOLEAN Diff_CLIA_NUMBER;
    BOOLEAN Diff_MEDICARE_FACILITY_NUMBER;
    BOOLEAN Diff_NCPDP_NUMBER;
    BOOLEAN Diff_TAX_ID;
    BOOLEAN Diff_FEIN;
    BOOLEAN Diff_C_LIC_NBR;
    BOOLEAN Diff_SRC;
    BOOLEAN Diff_CNAME;
    BOOLEAN Diff_CNP_NAME;
    BOOLEAN Diff_CNP_NUMBER;
    BOOLEAN Diff_CNP_STORE_NUMBER;
    BOOLEAN Diff_CNP_BTYPE;
    BOOLEAN Diff_CNP_LOWV;
    BOOLEAN Diff_CNP_TRANSLATED;
    BOOLEAN Diff_CNP_CLASSID;
    BOOLEAN Diff_ADDRESS_ID;
    BOOLEAN Diff_ADDRESS_CLASSIFICATION;
    BOOLEAN Diff_PRIM_RANGE;
    BOOLEAN Diff_PRIM_NAME;
    BOOLEAN Diff_SEC_RANGE;
    BOOLEAN Diff_ST;
    BOOLEAN Diff_V_CITY_NAME;
    BOOLEAN Diff_ZIP;
    BOOLEAN Diff_TAXONOMY;
    BOOLEAN Diff_TAXONOMY_CODE;
    BOOLEAN Diff_MEDICAID_NUMBER;
    BOOLEAN Diff_VENDOR_ID;
    BOOLEAN Diff_DT_FIRST_SEEN;
    BOOLEAN Diff_DT_LAST_SEEN;
    BOOLEAN Diff_DT_LIC_EXPIRATION;
    BOOLEAN Diff_DT_DEA_EXPIRATION;
    BOOLEAN Diff_LIC_STATE;
    SALT30.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT30.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_PHONE := le.PHONE <> ri.PHONE;
    SELF.Diff_FAX := le.FAX <> ri.FAX;
    SELF.Diff_UPIN := le.UPIN <> ri.UPIN;
    SELF.Diff_NPI_NUMBER := le.NPI_NUMBER <> ri.NPI_NUMBER;
    SELF.Diff_DEA_NUMBER := le.DEA_NUMBER <> ri.DEA_NUMBER;
    SELF.Diff_CLIA_NUMBER := le.CLIA_NUMBER <> ri.CLIA_NUMBER;
    SELF.Diff_MEDICARE_FACILITY_NUMBER := le.MEDICARE_FACILITY_NUMBER <> ri.MEDICARE_FACILITY_NUMBER;
    SELF.Diff_NCPDP_NUMBER := le.NCPDP_NUMBER <> ri.NCPDP_NUMBER;
    SELF.Diff_TAX_ID := le.TAX_ID <> ri.TAX_ID;
    SELF.Diff_FEIN := le.FEIN <> ri.FEIN;
    SELF.Diff_C_LIC_NBR := le.C_LIC_NBR <> ri.C_LIC_NBR;
    SELF.Diff_SRC := le.SRC <> ri.SRC;
    SELF.Diff_CNAME := le.CNAME <> ri.CNAME;
    SELF.Diff_CNP_NAME := le.CNP_NAME <> ri.CNP_NAME;
    SELF.Diff_CNP_NUMBER := le.CNP_NUMBER <> ri.CNP_NUMBER;
    SELF.Diff_CNP_STORE_NUMBER := le.CNP_STORE_NUMBER <> ri.CNP_STORE_NUMBER;
    SELF.Diff_CNP_BTYPE := le.CNP_BTYPE <> ri.CNP_BTYPE;
    SELF.Diff_CNP_LOWV := le.CNP_LOWV <> ri.CNP_LOWV;
    SELF.Diff_CNP_TRANSLATED := le.CNP_TRANSLATED <> ri.CNP_TRANSLATED;
    SELF.Diff_CNP_CLASSID := le.CNP_CLASSID <> ri.CNP_CLASSID;
    SELF.Diff_ADDRESS_ID := le.ADDRESS_ID <> ri.ADDRESS_ID;
    SELF.Diff_ADDRESS_CLASSIFICATION := le.ADDRESS_CLASSIFICATION <> ri.ADDRESS_CLASSIFICATION;
    SELF.Diff_PRIM_RANGE := le.PRIM_RANGE <> ri.PRIM_RANGE;
    SELF.Diff_PRIM_NAME := le.PRIM_NAME <> ri.PRIM_NAME;
    SELF.Diff_SEC_RANGE := le.SEC_RANGE <> ri.SEC_RANGE;
    SELF.Diff_ST := le.ST <> ri.ST;
    SELF.Diff_V_CITY_NAME := le.V_CITY_NAME <> ri.V_CITY_NAME;
    SELF.Diff_ZIP := le.ZIP <> ri.ZIP;
    SELF.Diff_TAXONOMY := le.TAXONOMY <> ri.TAXONOMY;
    SELF.Diff_TAXONOMY_CODE := le.TAXONOMY_CODE <> ri.TAXONOMY_CODE;
    SELF.Diff_MEDICAID_NUMBER := le.MEDICAID_NUMBER <> ri.MEDICAID_NUMBER;
    SELF.Diff_VENDOR_ID := le.VENDOR_ID <> ri.VENDOR_ID;
    SELF.Diff_DT_FIRST_SEEN := le.DT_FIRST_SEEN <> ri.DT_FIRST_SEEN;
    SELF.Diff_DT_LAST_SEEN := le.DT_LAST_SEEN <> ri.DT_LAST_SEEN;
    SELF.Diff_DT_LIC_EXPIRATION := le.DT_LIC_EXPIRATION <> ri.DT_LIC_EXPIRATION;
    SELF.Diff_DT_DEA_EXPIRATION := le.DT_DEA_EXPIRATION <> ri.DT_DEA_EXPIRATION;
    SELF.Diff_LIC_STATE := le.LIC_STATE <> ri.LIC_STATE;
    SELF.Val := (SALT30.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.SRC;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_PHONE,1,0)+ IF( SELF.Diff_FAX,1,0)+ IF( SELF.Diff_UPIN,1,0)+ IF( SELF.Diff_NPI_NUMBER,1,0)+ IF( SELF.Diff_DEA_NUMBER,1,0)+ IF( SELF.Diff_CLIA_NUMBER,1,0)+ IF( SELF.Diff_MEDICARE_FACILITY_NUMBER,1,0)+ IF( SELF.Diff_NCPDP_NUMBER,1,0)+ IF( SELF.Diff_TAX_ID,1,0)+ IF( SELF.Diff_FEIN,1,0)+ IF( SELF.Diff_C_LIC_NBR,1,0)+ IF( SELF.Diff_SRC,1,0)+ IF( SELF.Diff_CNAME,1,0)+ IF( SELF.Diff_CNP_NAME,1,0)+ IF( SELF.Diff_CNP_NUMBER,1,0)+ IF( SELF.Diff_CNP_STORE_NUMBER,1,0)+ IF( SELF.Diff_CNP_BTYPE,1,0)+ IF( SELF.Diff_CNP_LOWV,1,0)+ IF( SELF.Diff_CNP_TRANSLATED,1,0)+ IF( SELF.Diff_CNP_CLASSID,1,0)+ IF( SELF.Diff_ADDRESS_ID,1,0)+ IF( SELF.Diff_ADDRESS_CLASSIFICATION,1,0)+ IF( SELF.Diff_PRIM_RANGE,1,0)+ IF( SELF.Diff_PRIM_NAME,1,0)+ IF( SELF.Diff_SEC_RANGE,1,0)+ IF( SELF.Diff_ST,1,0)+ IF( SELF.Diff_V_CITY_NAME,1,0)+ IF( SELF.Diff_ZIP,1,0)+ IF( SELF.Diff_TAXONOMY,1,0)+ IF( SELF.Diff_TAXONOMY_CODE,1,0)+ IF( SELF.Diff_MEDICAID_NUMBER,1,0)+ IF( SELF.Diff_VENDOR_ID,1,0)+ IF( SELF.Diff_DT_LIC_EXPIRATION,1,0)+ IF( SELF.Diff_DT_DEA_EXPIRATION,1,0)+ IF( SELF.Diff_LIC_STATE,1,0);
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
    Count_Diff_PHONE := COUNT(GROUP,%Closest%.Diff_PHONE);
    Count_Diff_FAX := COUNT(GROUP,%Closest%.Diff_FAX);
    Count_Diff_UPIN := COUNT(GROUP,%Closest%.Diff_UPIN);
    Count_Diff_NPI_NUMBER := COUNT(GROUP,%Closest%.Diff_NPI_NUMBER);
    Count_Diff_DEA_NUMBER := COUNT(GROUP,%Closest%.Diff_DEA_NUMBER);
    Count_Diff_CLIA_NUMBER := COUNT(GROUP,%Closest%.Diff_CLIA_NUMBER);
    Count_Diff_MEDICARE_FACILITY_NUMBER := COUNT(GROUP,%Closest%.Diff_MEDICARE_FACILITY_NUMBER);
    Count_Diff_NCPDP_NUMBER := COUNT(GROUP,%Closest%.Diff_NCPDP_NUMBER);
    Count_Diff_TAX_ID := COUNT(GROUP,%Closest%.Diff_TAX_ID);
    Count_Diff_FEIN := COUNT(GROUP,%Closest%.Diff_FEIN);
    Count_Diff_C_LIC_NBR := COUNT(GROUP,%Closest%.Diff_C_LIC_NBR);
    Count_Diff_SRC := COUNT(GROUP,%Closest%.Diff_SRC);
    Count_Diff_CNAME := COUNT(GROUP,%Closest%.Diff_CNAME);
    Count_Diff_CNP_NAME := COUNT(GROUP,%Closest%.Diff_CNP_NAME);
    Count_Diff_CNP_NUMBER := COUNT(GROUP,%Closest%.Diff_CNP_NUMBER);
    Count_Diff_CNP_STORE_NUMBER := COUNT(GROUP,%Closest%.Diff_CNP_STORE_NUMBER);
    Count_Diff_CNP_BTYPE := COUNT(GROUP,%Closest%.Diff_CNP_BTYPE);
    Count_Diff_CNP_LOWV := COUNT(GROUP,%Closest%.Diff_CNP_LOWV);
    Count_Diff_CNP_TRANSLATED := COUNT(GROUP,%Closest%.Diff_CNP_TRANSLATED);
    Count_Diff_CNP_CLASSID := COUNT(GROUP,%Closest%.Diff_CNP_CLASSID);
    Count_Diff_ADDRESS_ID := COUNT(GROUP,%Closest%.Diff_ADDRESS_ID);
    Count_Diff_ADDRESS_CLASSIFICATION := COUNT(GROUP,%Closest%.Diff_ADDRESS_CLASSIFICATION);
    Count_Diff_PRIM_RANGE := COUNT(GROUP,%Closest%.Diff_PRIM_RANGE);
    Count_Diff_PRIM_NAME := COUNT(GROUP,%Closest%.Diff_PRIM_NAME);
    Count_Diff_SEC_RANGE := COUNT(GROUP,%Closest%.Diff_SEC_RANGE);
    Count_Diff_ST := COUNT(GROUP,%Closest%.Diff_ST);
    Count_Diff_V_CITY_NAME := COUNT(GROUP,%Closest%.Diff_V_CITY_NAME);
    Count_Diff_ZIP := COUNT(GROUP,%Closest%.Diff_ZIP);
    Count_Diff_TAXONOMY := COUNT(GROUP,%Closest%.Diff_TAXONOMY);
    Count_Diff_TAXONOMY_CODE := COUNT(GROUP,%Closest%.Diff_TAXONOMY_CODE);
    Count_Diff_MEDICAID_NUMBER := COUNT(GROUP,%Closest%.Diff_MEDICAID_NUMBER);
    Count_Diff_VENDOR_ID := COUNT(GROUP,%Closest%.Diff_VENDOR_ID);
    Count_Diff_DT_FIRST_SEEN := COUNT(GROUP,%Closest%.Diff_DT_FIRST_SEEN);
    Count_Diff_DT_LAST_SEEN := COUNT(GROUP,%Closest%.Diff_DT_LAST_SEEN);
    Count_Diff_DT_LIC_EXPIRATION := COUNT(GROUP,%Closest%.Diff_DT_LIC_EXPIRATION);
    Count_Diff_DT_DEA_EXPIRATION := COUNT(GROUP,%Closest%.Diff_DT_DEA_EXPIRATION);
    Count_Diff_LIC_STATE := COUNT(GROUP,%Closest%.Diff_LIC_STATE);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
// Now determine the consistency of the identifiers
EXPORT UIDConsistency(infile) := FUNCTIONMACRO
  f := TABLE(infile,{LNPID,RID}); // Consistent type independent of input
  m := MODULE
    r := RECORD
      UNSIGNED RID_null0 := COUNT(GROUP,(UNSIGNED)f.RID=0);
      UNSIGNED RID_belowparent0 := COUNT(GROUP,(UNSIGNED)f.RID<(UNSIGNED)f.LNPID);
      UNSIGNED RID_atparent := COUNT(GROUP,(UNSIGNED)f.LNPID=(UNSIGNED)f.RID);
      UNSIGNED LNPID_null0 := COUNT(GROUP,(UNSIGNED)f.LNPID=0);
    END;
  EXPORT Basic0 := TABLE(f,r);
  EXPORT RID_Clusters := SALT30.MOD_ClusterStats.Counts(f,RID);
  EXPORT LNPID_Clusters := SALT30.MOD_ClusterStats.Counts(f,LNPID);
  EXPORT IdCounts := DATASET([{SUM(RID_Clusters,NumberOfClusters),SUM(LNPID_Clusters,NumberOfClusters)}],{UNSIGNED RID_Count,UNSIGNED LNPID_Count}); // The counts of each ID
 // For deeper debugging; provide the unbased parents
    bases := f((UNSIGNED)LNPID=(UNSIGNED)RID); // Get the bases
  EXPORT LNPID_Unbased := JOIN(f,bases,LEFT.LNPID=RIGHT.LNPID,TRANSFORM(LEFT),LEFT ONLY,HASH);
 // Children with two parents
    bases := f((UNSIGNED)RID=(UNSIGNED)RID); // Get the bases
  EXPORT RID_Twoparents := DEDUP(JOIN(f,f,LEFT.RID=RIGHT.RID AND LEFT.LNPID>RIGHT.LNPID,TRANSFORM({SALT30.UIDType LNPID1,SALT30.UIDType RID,SALT30.UIDType LNPID2},SELF.LNPID1:=LEFT.LNPID,SELF.LNPID2:=RIGHT.LNPID,SELF.RID:=LEFT.RID),HASH),WHOLE RECORD,ALL);
 // Now compute the more involved consistency checks
    r := RECORD
      {Basic0} AND NOT [RID_atparent];
      INTEGER LNPID_unbased0 := IdCounts[1].LNPID_Count-Basic0.RID_atparent;
      INTEGER RID_Twoparents0 := COUNT(RID_Twoparents);
    END;
  EXPORT Advanced0 := TABLE(Basic0,r);
  END;
  RETURN m;
ENDMACRO;
END;
