IMPORT ut,SALT27;
EXPORT Fields := MODULE

// Processing for each FieldType
EXPORT SALT27.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'DEFAULT','NUMBER','ALPHA','ALPHANUM','WORDBAG','GENDERONLY');
EXPORT FieldTypeNum(SALT27.StrType fn) := CASE(fn,'DEFAULT' => 1,'NUMBER' => 2,'ALPHA' => 3,'ALPHANUM' => 4,'WORDBAG' => 5,'GENDERONLY' => 6,0);

EXPORT MakeFT_DEFAULT(SALT27.StrType s0) := FUNCTION
s1 := if ( SALT27.StringFind('"\'',s0[1],1)>0 and SALT27.StringFind('"\'',s0[LENGTH(TRIM(s0))],1)>0,s0[2..LENGTH(TRIM(s0))-1],s0 );// Remove quotes if required
s2 := TRIM(s1,LEFT); // Left trim
RETURN  s2;
END;
EXPORT InValidFT_DEFAULT(SALT27.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,SALT27.StringFind('"\'',s[1],1)<>0 and SALT27.StringFind('"\'',s[LENGTH(TRIM(s))],1)<>0);
EXPORT InValidMessageFT_DEFAULT(UNSIGNED1 wh) := CHOOSE(wh,SALT27.HygieneErrors.NotLeft,SALT27.HygieneErrors.Inquotes('"\''),SALT27.HygieneErrors.Good);

EXPORT MakeFT_NUMBER(SALT27.StrType s0) := FUNCTION
s1 := SALT27.stringfilter(s0,'0123456789-'); // Only allow valid symbols
RETURN  s1;
END;
EXPORT InValidFT_NUMBER(SALT27.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT27.StringFilter(s,'0123456789-'))));
EXPORT InValidMessageFT_NUMBER(UNSIGNED1 wh) := CHOOSE(wh,SALT27.HygieneErrors.NotInChars('0123456789-'),SALT27.HygieneErrors.Good);

EXPORT MakeFT_ALPHA(SALT27.StrType s0) := FUNCTION
s1 := SALT27.stringtouppercase(s0); // Force to upper case
s2 := SALT27.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
RETURN  s2;
END;
EXPORT InValidFT_ALPHA(SALT27.StrType s) := WHICH(SALT27.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT27.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_ALPHA(UNSIGNED1 wh) := CHOOSE(wh,SALT27.HygieneErrors.NotCaps,SALT27.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT27.HygieneErrors.Good);

EXPORT MakeFT_ALPHANUM(SALT27.StrType s0) := FUNCTION
s1 := SALT27.stringtouppercase(s0); // Force to upper case
s2 := SALT27.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'); // Only allow valid symbols
RETURN  s2;
END;
EXPORT InValidFT_ALPHANUM(SALT27.StrType s) := WHICH(SALT27.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT27.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'))));
EXPORT InValidMessageFT_ALPHANUM(UNSIGNED1 wh) := CHOOSE(wh,SALT27.HygieneErrors.NotCaps,SALT27.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'),SALT27.HygieneErrors.Good);

EXPORT MakeFT_WORDBAG(SALT27.StrType s0) := FUNCTION
s1 := SALT27.stringtouppercase(s0); // Force to upper case
s2 := SALT27.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
s3 := SALT27.stringcleanspaces( SALT27.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
RETURN  s3;
END;
EXPORT InValidFT_WORDBAG(SALT27.StrType s) := WHICH(SALT27.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT27.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))));
EXPORT InValidMessageFT_WORDBAG(UNSIGNED1 wh) := CHOOSE(wh,SALT27.HygieneErrors.NotCaps,SALT27.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'),SALT27.HygieneErrors.Good);

EXPORT MakeFT_GENDERONLY(SALT27.StrType s0) := FUNCTION
s1 := SALT27.stringtouppercase(s0); // Force to upper case
s2 := SALT27.stringfilter(s1,'MF'); // Only allow valid symbols
RETURN  s2;
END;
EXPORT InValidFT_GENDERONLY(SALT27.StrType s) := WHICH(SALT27.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT27.StringFilter(s,'MF'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 1));
EXPORT InValidMessageFT_GENDERONLY(UNSIGNED1 wh) := CHOOSE(wh,SALT27.HygieneErrors.NotCaps,SALT27.HygieneErrors.NotInChars('MF'),SALT27.HygieneErrors.NotLength('0..1'),SALT27.HygieneErrors.Good);

EXPORT SALT27.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'VENDOR_ID','DID','NPI_NUMBER','DEA_NUMBER','MAINNAME','FULLNAME','LIC_NBR','UPIN','ADDR','ADDRESS','TAX_ID','DOB','PRIM_NAME','ZIP','LOCALE','PRIM_RANGE','LNAME','V_CITY_NAME','LAT_LONG','MNAME','FNAME','SEC_RANGE','SNAME','ST','GENDER','PHONE','LIC_STATE','ADDRESS_ID','CNAME','SRC','DT_FIRST_SEEN','DT_LAST_SEEN','DT_LIC_EXPIRATION','DT_DEA_EXPIRATION','GEO_LAT','GEO_LONG');
EXPORT FieldNum(SALT27.StrType fn) := CASE(fn,'VENDOR_ID' => 1,'DID' => 2,'NPI_NUMBER' => 3,'DEA_NUMBER' => 4,'MAINNAME' => 5,'FULLNAME' => 6,'LIC_NBR' => 7,'UPIN' => 8,'ADDR' => 9,'ADDRESS' => 10,'TAX_ID' => 11,'DOB' => 12,'PRIM_NAME' => 13,'ZIP' => 14,'LOCALE' => 15,'PRIM_RANGE' => 16,'LNAME' => 17,'V_CITY_NAME' => 18,'LAT_LONG' => 19,'MNAME' => 20,'FNAME' => 21,'SEC_RANGE' => 22,'SNAME' => 23,'ST' => 24,'GENDER' => 25,'PHONE' => 26,'LIC_STATE' => 27,'ADDRESS_ID' => 28,'CNAME' => 29,'SRC' => 30,'DT_FIRST_SEEN' => 31,'DT_LAST_SEEN' => 32,'DT_LIC_EXPIRATION' => 33,'DT_DEA_EXPIRATION' => 34,'GEO_LAT' => 35,'GEO_LONG' => 36,0);

//Individual field level validation

EXPORT Make_VENDOR_ID(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_VENDOR_ID(SALT27.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_VENDOR_ID(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_DID(SALT27.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_DID(SALT27.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_DID(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);

EXPORT Make_NPI_NUMBER(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_NPI_NUMBER(SALT27.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_NPI_NUMBER(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_DEA_NUMBER(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DEA_NUMBER(SALT27.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DEA_NUMBER(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_MAINNAME(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_MAINNAME(SALT27.StrType FNAME,SALT27.StrType MNAME,SALT27.StrType LNAME) := FALSE;
EXPORT InValidMessage_MAINNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_FULLNAME(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_FULLNAME(SALT27.StrType MAINNAME,SALT27.StrType SNAME) := FALSE;
EXPORT InValidMessage_FULLNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_LIC_NBR(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_LIC_NBR(SALT27.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_LIC_NBR(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_UPIN(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_UPIN(SALT27.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_UPIN(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_ADDR(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_ADDR(SALT27.StrType PRIM_RANGE,SALT27.StrType SEC_RANGE,SALT27.StrType PRIM_NAME) := FALSE;
EXPORT InValidMessage_ADDR(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_ADDRESS(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_ADDRESS(SALT27.StrType ADDR,SALT27.StrType LOCALE) := FALSE;
EXPORT InValidMessage_ADDRESS(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_TAX_ID(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_TAX_ID(SALT27.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_TAX_ID(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_DOB(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DOB(SALT27.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DOB(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_PRIM_NAME(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_PRIM_NAME(SALT27.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_PRIM_NAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_ZIP(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_ZIP(SALT27.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_ZIP(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_LOCALE(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_LOCALE(SALT27.StrType V_CITY_NAME,SALT27.StrType ST,SALT27.StrType ZIP) := FALSE;
EXPORT InValidMessage_LOCALE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_PRIM_RANGE(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_PRIM_RANGE(SALT27.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_PRIM_RANGE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_LNAME(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_LNAME(SALT27.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_LNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_V_CITY_NAME(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_V_CITY_NAME(SALT27.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_V_CITY_NAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_MNAME(SALT27.StrType s0) := MakeFT_WORDBAG(s0);
EXPORT InValid_MNAME(SALT27.StrType s) := InValidFT_WORDBAG(s);
EXPORT InValidMessage_MNAME(UNSIGNED1 wh) := InValidMessageFT_WORDBAG(wh);

EXPORT Make_FNAME(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_FNAME(SALT27.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_FNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_SEC_RANGE(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SEC_RANGE(SALT27.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SEC_RANGE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_SNAME(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SNAME(SALT27.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_ST(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_ST(SALT27.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_ST(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_GENDER(SALT27.StrType s0) := MakeFT_GENDERONLY(s0);
EXPORT InValid_GENDER(SALT27.StrType s) := InValidFT_GENDERONLY(s);
EXPORT InValidMessage_GENDER(UNSIGNED1 wh) := InValidMessageFT_GENDERONLY(wh);

EXPORT Make_PHONE(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_PHONE(SALT27.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_PHONE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_LIC_STATE(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_LIC_STATE(SALT27.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_LIC_STATE(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_ADDRESS_ID(SALT27.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ADDRESS_ID(SALT27.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ADDRESS_ID(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);

EXPORT Make_CNAME(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_CNAME(SALT27.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_CNAME(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_SRC(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_SRC(SALT27.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_SRC(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_DT_FIRST_SEEN(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DT_FIRST_SEEN(SALT27.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DT_FIRST_SEEN(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_DT_LAST_SEEN(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DT_LAST_SEEN(SALT27.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DT_LAST_SEEN(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_DT_LIC_EXPIRATION(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DT_LIC_EXPIRATION(SALT27.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DT_LIC_EXPIRATION(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_DT_DEA_EXPIRATION(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_DT_DEA_EXPIRATION(SALT27.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_DT_DEA_EXPIRATION(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_GEO_LAT(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_GEO_LAT(SALT27.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_GEO_LAT(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);

EXPORT Make_GEO_LONG(SALT27.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_GEO_LONG(SALT27.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_GEO_LONG(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
IMPORT SALT27,HealthCareProviderHeader_prod;
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
BOOLEAN Diff_VENDOR_ID;
BOOLEAN Diff_DID;
BOOLEAN Diff_NPI_NUMBER;
BOOLEAN Diff_DEA_NUMBER;
BOOLEAN Diff_LIC_NBR;
BOOLEAN Diff_UPIN;
BOOLEAN Diff_TAX_ID;
BOOLEAN Diff_DOB;
BOOLEAN Diff_PRIM_NAME;
BOOLEAN Diff_ZIP;
BOOLEAN Diff_PRIM_RANGE;
BOOLEAN Diff_LNAME;
BOOLEAN Diff_V_CITY_NAME;
BOOLEAN Diff_LAT_LONG;
BOOLEAN Diff_MNAME;
BOOLEAN Diff_FNAME;
BOOLEAN Diff_SEC_RANGE;
BOOLEAN Diff_SNAME;
BOOLEAN Diff_ST;
BOOLEAN Diff_GENDER;
BOOLEAN Diff_PHONE;
BOOLEAN Diff_LIC_STATE;
BOOLEAN Diff_ADDRESS_ID;
BOOLEAN Diff_CNAME;
BOOLEAN Diff_SRC;
BOOLEAN Diff_DT_FIRST_SEEN;
BOOLEAN Diff_DT_LAST_SEEN;
BOOLEAN Diff_DT_LIC_EXPIRATION;
BOOLEAN Diff_DT_DEA_EXPIRATION;
BOOLEAN Diff_GEO_LAT;
BOOLEAN Diff_GEO_LONG;
SALT27.StrType SourceField {MAXLENGTH(30)};
UNSIGNED Num_Diffs;
SALT27.StrType Val {MAXLENGTH(1024)};
END;
#uniquename(fd)
%dl% %fd%(in_left le,in_right ri) := TRANSFORM
SELF.Diff_VENDOR_ID := le.VENDOR_ID <> ri.VENDOR_ID;
SELF.Diff_DID := le.DID <> ri.DID;
SELF.Diff_NPI_NUMBER := le.NPI_NUMBER <> ri.NPI_NUMBER;
SELF.Diff_DEA_NUMBER := le.DEA_NUMBER <> ri.DEA_NUMBER;
SELF.Diff_LIC_NBR := le.LIC_NBR <> ri.LIC_NBR;
SELF.Diff_UPIN := le.UPIN <> ri.UPIN;
SELF.Diff_TAX_ID := le.TAX_ID <> ri.TAX_ID;
SELF.Diff_DOB := le.DOB <> ri.DOB;
SELF.Diff_PRIM_NAME := le.PRIM_NAME <> ri.PRIM_NAME;
SELF.Diff_ZIP := le.ZIP <> ri.ZIP;
SELF.Diff_PRIM_RANGE := le.PRIM_RANGE <> ri.PRIM_RANGE;
SELF.Diff_LNAME := le.LNAME <> ri.LNAME;
SELF.Diff_V_CITY_NAME := le.V_CITY_NAME <> ri.V_CITY_NAME;
SELF.Diff_LAT_LONG := le.GEO_LAT <> ri.GEO_LAT OR le.GEO_LONG <> ri.GEO_LONG;
SELF.Diff_MNAME := le.MNAME <> ri.MNAME;
SELF.Diff_FNAME := le.FNAME <> ri.FNAME;
SELF.Diff_SEC_RANGE := le.SEC_RANGE <> ri.SEC_RANGE;
SELF.Diff_SNAME := le.SNAME <> ri.SNAME;
SELF.Diff_ST := le.ST <> ri.ST;
SELF.Diff_GENDER := le.GENDER <> ri.GENDER;
SELF.Diff_PHONE := le.PHONE <> ri.PHONE;
SELF.Diff_LIC_STATE := le.LIC_STATE <> ri.LIC_STATE;
SELF.Diff_ADDRESS_ID := le.ADDRESS_ID <> ri.ADDRESS_ID;
SELF.Diff_CNAME := le.CNAME <> ri.CNAME;
SELF.Diff_SRC := le.SRC <> ri.SRC;
SELF.Diff_DT_FIRST_SEEN := le.DT_FIRST_SEEN <> ri.DT_FIRST_SEEN;
SELF.Diff_DT_LAST_SEEN := le.DT_LAST_SEEN <> ri.DT_LAST_SEEN;
SELF.Diff_DT_LIC_EXPIRATION := le.DT_LIC_EXPIRATION <> ri.DT_LIC_EXPIRATION;
SELF.Diff_DT_DEA_EXPIRATION := le.DT_DEA_EXPIRATION <> ri.DT_DEA_EXPIRATION;
SELF.Diff_GEO_LAT := le.GEO_LAT <> ri.GEO_LAT;
SELF.Diff_GEO_LONG := le.GEO_LONG <> ri.GEO_LONG;
SELF.Val := (SALT27.StrType)evaluate(le,pivot_exp);
SELF.SourceField := le.SRC;
SELF.Num_Diffs := 0+ IF( SELF.Diff_VENDOR_ID,1,0)+ IF( SELF.Diff_DID,1,0)+ IF( SELF.Diff_NPI_NUMBER,1,0)+ IF( SELF.Diff_DEA_NUMBER,1,0)+ IF( SELF.Diff_LIC_NBR,1,0)+ IF( SELF.Diff_UPIN,1,0)+ IF( SELF.Diff_TAX_ID,1,0)+ IF( SELF.Diff_DOB,1,0)+ IF( SELF.Diff_PRIM_NAME,1,0)+ IF( SELF.Diff_ZIP,1,0)+ IF( SELF.Diff_PRIM_RANGE,1,0)+ IF( SELF.Diff_LNAME,1,0)+ IF( SELF.Diff_V_CITY_NAME,1,0)+ IF( SELF.Diff_LAT_LONG,1,0)+ IF( SELF.Diff_MNAME,1,0)+ IF( SELF.Diff_FNAME,1,0)+ IF( SELF.Diff_SEC_RANGE,1,0)+ IF( SELF.Diff_SNAME,1,0)+ IF( SELF.Diff_ST,1,0)+ IF( SELF.Diff_GENDER,1,0)+ IF( SELF.Diff_PHONE,1,0)+ IF( SELF.Diff_LIC_STATE,1,0)+ IF( SELF.Diff_ADDRESS_ID,1,0)+ IF( SELF.Diff_CNAME,1,0)+ IF( SELF.Diff_SRC,1,0)+ IF( SELF.Diff_DT_LIC_EXPIRATION,1,0)+ IF( SELF.Diff_DT_DEA_EXPIRATION,1,0)+ IF( SELF.Diff_GEO_LAT,1,0)+ IF( SELF.Diff_GEO_LONG,1,0);
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
Count_Diff_VENDOR_ID := COUNT(GROUP,%Closest%.Diff_VENDOR_ID);
Count_Diff_DID := COUNT(GROUP,%Closest%.Diff_DID);
Count_Diff_NPI_NUMBER := COUNT(GROUP,%Closest%.Diff_NPI_NUMBER);
Count_Diff_DEA_NUMBER := COUNT(GROUP,%Closest%.Diff_DEA_NUMBER);
Count_Diff_LIC_NBR := COUNT(GROUP,%Closest%.Diff_LIC_NBR);
Count_Diff_UPIN := COUNT(GROUP,%Closest%.Diff_UPIN);
Count_Diff_TAX_ID := COUNT(GROUP,%Closest%.Diff_TAX_ID);
Count_Diff_DOB := COUNT(GROUP,%Closest%.Diff_DOB);
Count_Diff_PRIM_NAME := COUNT(GROUP,%Closest%.Diff_PRIM_NAME);
Count_Diff_ZIP := COUNT(GROUP,%Closest%.Diff_ZIP);
Count_Diff_PRIM_RANGE := COUNT(GROUP,%Closest%.Diff_PRIM_RANGE);
Count_Diff_LNAME := COUNT(GROUP,%Closest%.Diff_LNAME);
Count_Diff_V_CITY_NAME := COUNT(GROUP,%Closest%.Diff_V_CITY_NAME);
Count_Diff_LAT_LONG := COUNT(GROUP,%Closest%.Diff_LAT_LONG);
Count_Diff_MNAME := COUNT(GROUP,%Closest%.Diff_MNAME);
Count_Diff_FNAME := COUNT(GROUP,%Closest%.Diff_FNAME);
Count_Diff_SEC_RANGE := COUNT(GROUP,%Closest%.Diff_SEC_RANGE);
Count_Diff_SNAME := COUNT(GROUP,%Closest%.Diff_SNAME);
Count_Diff_ST := COUNT(GROUP,%Closest%.Diff_ST);
Count_Diff_GENDER := COUNT(GROUP,%Closest%.Diff_GENDER);
Count_Diff_PHONE := COUNT(GROUP,%Closest%.Diff_PHONE);
Count_Diff_LIC_STATE := COUNT(GROUP,%Closest%.Diff_LIC_STATE);
Count_Diff_ADDRESS_ID := COUNT(GROUP,%Closest%.Diff_ADDRESS_ID);
Count_Diff_CNAME := COUNT(GROUP,%Closest%.Diff_CNAME);
Count_Diff_SRC := COUNT(GROUP,%Closest%.Diff_SRC);
Count_Diff_DT_FIRST_SEEN := COUNT(GROUP,%Closest%.Diff_DT_FIRST_SEEN);
Count_Diff_DT_LAST_SEEN := COUNT(GROUP,%Closest%.Diff_DT_LAST_SEEN);
Count_Diff_DT_LIC_EXPIRATION := COUNT(GROUP,%Closest%.Diff_DT_LIC_EXPIRATION);
Count_Diff_DT_DEA_EXPIRATION := COUNT(GROUP,%Closest%.Diff_DT_DEA_EXPIRATION);
Count_Diff_GEO_LAT := COUNT(GROUP,%Closest%.Diff_GEO_LAT);
Count_Diff_GEO_LONG := COUNT(GROUP,%Closest%.Diff_GEO_LONG);
%Closest%.SourceField;
END;
out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
end;
