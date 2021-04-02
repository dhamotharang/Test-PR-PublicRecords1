IMPORT SALT311;
IMPORT Scrubs,Scrubs_IDA; // Import modules for FieldTypes attribute definitions
EXPORT RawInput_Fields := MODULE

EXPORT NumFields := 17;

// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Num','Invalid_Alpha','Invalid_AlphaNum','Invalid_FName','Invalid_MName','Invalid_LName','Invalid_Suffix','Invalid_Address1','Invalid_Address2','Invalid_City','Invalid_State','Invalid_Zip','Invalid_DOB','Invalid_SSN','Invalid_DL','Invalid_Phone','Invalid_Clientassigneduniquerecordid','Invalid_Emailaddress','Invalid_Ipaddress');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Num' => 1,'Invalid_Alpha' => 2,'Invalid_AlphaNum' => 3,'Invalid_FName' => 4,'Invalid_MName' => 5,'Invalid_LName' => 6,'Invalid_Suffix' => 7,'Invalid_Address1' => 8,'Invalid_Address2' => 9,'Invalid_City' => 10,'Invalid_State' => 11,'Invalid_Zip' => 12,'Invalid_DOB' => 13,'Invalid_SSN' => 14,'Invalid_DL' => 15,'Invalid_Phone' => 16,'Invalid_Clientassigneduniquerecordid' => 17,'Invalid_Emailaddress' => 18,'Invalid_Ipaddress' => 19,0);

EXPORT MakeFT_Invalid_Num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_Invalid_Alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_AlphaNum(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaNum(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_Invalid_AlphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_FName(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ- '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_Invalid_FName(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ- '))),~(LENGTH(TRIM(s)) >= 2 AND LENGTH(TRIM(s)) <= 15),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 0 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_Invalid_FName(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ- '),SALT311.HygieneErrors.NotLength('2..15'),SALT311.HygieneErrors.NotWords('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_MName(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ. '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_Invalid_MName(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ. '))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 0 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_Invalid_MName(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ. '),SALT311.HygieneErrors.NotLength('0..2'),SALT311.HygieneErrors.NotWords('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_LName(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ.- '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_Invalid_LName(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ.- '))),~(LENGTH(TRIM(s)) >= 2 AND LENGTH(TRIM(s)) <= 20),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) >= 0 AND SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) <= 2));
EXPORT InValidMessageFT_Invalid_LName(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ.- '),SALT311.HygieneErrors.NotLength('2..20'),SALT311.HygieneErrors.NotWords('0..2'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Suffix(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'SRJr.IVX12345PHMD '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_Invalid_Suffix(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'SRJr.IVX12345PHMD '))),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 0 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_Invalid_Suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('SRJr.IVX12345PHMD '),SALT311.HygieneErrors.NotWords('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Address1(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ. '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,'. ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_AlphaNum(s2);
END;
EXPORT InValidFT_Invalid_Address1(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ. '))),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,'. ',' ')) >= 0 AND SALT311.WordCount(SALT311.StringSubstituteOut(s,'. ',' ')) <= 7));
EXPORT InValidMessageFT_Invalid_Address1(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ. '),SALT311.HygieneErrors.NotWords('0..7'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Address2(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ# '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,'# ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_AlphaNum(s2);
END;
EXPORT InValidFT_Invalid_Address2(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ# '))),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,'# ',' ')) >= 0 AND SALT311.WordCount(SALT311.StringSubstituteOut(s,'# ',' ')) <= 2));
EXPORT InValidMessageFT_Invalid_Address2(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ# '),SALT311.HygieneErrors.NotWords('0..2'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_City(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ. '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,'. ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Alpha(s2);
END;
EXPORT InValidFT_Invalid_City(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ. '))),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,'. ',' ')) >= 0 AND SALT311.WordCount(SALT311.StringSubstituteOut(s,'. ',' ')) <= 4));
EXPORT InValidMessageFT_Invalid_City(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ. '),SALT311.HygieneErrors.NotWords('0..4'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_State(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_State(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_verify_state'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_Invalid_Num(s1);
END;
EXPORT InValidFT_Invalid_Zip(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 3 AND LENGTH(TRIM(s)) <= 5));
EXPORT InValidMessageFT_Invalid_Zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0,3..5'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_DOB(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_DOB(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_dob(s)>0);
EXPORT InValidMessageFT_Invalid_DOB(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_dob'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_SSN(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_Invalid_SSN(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 9),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 0 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_Invalid_SSN(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.NotLength('0,9'),SALT311.HygieneErrors.NotWords('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_DL(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_DL(SALT311.StrType s) := WHICH(~Scrubs_IDA.Functions.FN_valid_DL(s)>0);
EXPORT InValidMessageFT_Invalid_DL(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IDA.Functions.FN_valid_DL'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Phone(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_Invalid_Num(s1);
END;
EXPORT InValidFT_Invalid_Phone(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_Invalid_Phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0,10'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Clientassigneduniquerecordid(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'nfr0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Clientassigneduniquerecordid(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'nfr0123456789'))));
EXPORT InValidMessageFT_Invalid_Clientassigneduniquerecordid(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('nfr0123456789'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Emailaddress(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Emailaddress(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_valid_email(s)>0);
EXPORT InValidMessageFT_Invalid_Emailaddress(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_valid_email'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Ipaddress(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Ipaddress(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_valid_IP(s)>0);
EXPORT InValidMessageFT_Invalid_Ipaddress(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_valid_IP'),SALT311.HygieneErrors.Good);


EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'firstname','middlename','lastname','suffix','addressline1','addressline2','city','state','zip','dob','ssn','dl','dlstate','phone','clientassigneduniquerecordid','emailaddress','ipaddress');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'firstname','middlename','lastname','suffix','addressline1','addressline2','city','state','zip','dob','ssn','dl','dlstate','phone','clientassigneduniquerecordid','emailaddress','ipaddress');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'firstname' => 0,'middlename' => 1,'lastname' => 2,'suffix' => 3,'addressline1' => 4,'addressline2' => 5,'city' => 6,'state' => 7,'zip' => 8,'dob' => 9,'ssn' => 10,'dl' => 11,'dlstate' => 12,'phone' => 13,'clientassigneduniquerecordid' => 14,'emailaddress' => 15,'ipaddress' => 16,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['CUSTOM'],['ALLOW','LENGTHS'],['CUSTOM'],['ALLOW','LENGTHS','WORDS'],['CUSTOM'],['CUSTOM'],['ALLOW','LENGTHS'],['ALLOW'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);

//Individual field level validation


EXPORT Make_firstname(SALT311.StrType s0) := MakeFT_Invalid_FName(s0);
EXPORT InValid_firstname(SALT311.StrType s) := InValidFT_Invalid_FName(s);
EXPORT InValidMessage_firstname(UNSIGNED1 wh) := InValidMessageFT_Invalid_FName(wh);


EXPORT Make_middlename(SALT311.StrType s0) := MakeFT_Invalid_MName(s0);
EXPORT InValid_middlename(SALT311.StrType s) := InValidFT_Invalid_MName(s);
EXPORT InValidMessage_middlename(UNSIGNED1 wh) := InValidMessageFT_Invalid_MName(wh);


EXPORT Make_lastname(SALT311.StrType s0) := MakeFT_Invalid_LName(s0);
EXPORT InValid_lastname(SALT311.StrType s) := InValidFT_Invalid_LName(s);
EXPORT InValidMessage_lastname(UNSIGNED1 wh) := InValidMessageFT_Invalid_LName(wh);


EXPORT Make_suffix(SALT311.StrType s0) := MakeFT_Invalid_Suffix(s0);
EXPORT InValid_suffix(SALT311.StrType s) := InValidFT_Invalid_Suffix(s);
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Suffix(wh);


EXPORT Make_addressline1(SALT311.StrType s0) := MakeFT_Invalid_Address1(s0);
EXPORT InValid_addressline1(SALT311.StrType s) := InValidFT_Invalid_Address1(s);
EXPORT InValidMessage_addressline1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Address1(wh);


EXPORT Make_addressline2(SALT311.StrType s0) := MakeFT_Invalid_Address2(s0);
EXPORT InValid_addressline2(SALT311.StrType s) := InValidFT_Invalid_Address2(s);
EXPORT InValidMessage_addressline2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Address2(wh);


EXPORT Make_city(SALT311.StrType s0) := MakeFT_Invalid_City(s0);
EXPORT InValid_city(SALT311.StrType s) := InValidFT_Invalid_City(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_City(wh);


EXPORT Make_state(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);


EXPORT Make_zip(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_zip(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);


EXPORT Make_dob(SALT311.StrType s0) := MakeFT_Invalid_DOB(s0);
EXPORT InValid_dob(SALT311.StrType s) := InValidFT_Invalid_DOB(s);
EXPORT InValidMessage_dob(UNSIGNED1 wh) := InValidMessageFT_Invalid_DOB(wh);


EXPORT Make_ssn(SALT311.StrType s0) := MakeFT_Invalid_SSN(s0);
EXPORT InValid_ssn(SALT311.StrType s) := InValidFT_Invalid_SSN(s);
EXPORT InValidMessage_ssn(UNSIGNED1 wh) := InValidMessageFT_Invalid_SSN(wh);


EXPORT Make_dl(SALT311.StrType s0) := MakeFT_Invalid_DL(s0);
EXPORT InValid_dl(SALT311.StrType s) := InValidFT_Invalid_DL(s);
EXPORT InValidMessage_dl(UNSIGNED1 wh) := InValidMessageFT_Invalid_DL(wh);


EXPORT Make_dlstate(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_dlstate(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_dlstate(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);


EXPORT Make_phone(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_phone(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);


EXPORT Make_clientassigneduniquerecordid(SALT311.StrType s0) := MakeFT_Invalid_Clientassigneduniquerecordid(s0);
EXPORT InValid_clientassigneduniquerecordid(SALT311.StrType s) := InValidFT_Invalid_Clientassigneduniquerecordid(s);
EXPORT InValidMessage_clientassigneduniquerecordid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Clientassigneduniquerecordid(wh);


EXPORT Make_emailaddress(SALT311.StrType s0) := MakeFT_Invalid_Emailaddress(s0);
EXPORT InValid_emailaddress(SALT311.StrType s) := InValidFT_Invalid_Emailaddress(s);
EXPORT InValidMessage_emailaddress(UNSIGNED1 wh) := InValidMessageFT_Invalid_Emailaddress(wh);


EXPORT Make_ipaddress(SALT311.StrType s0) := MakeFT_Invalid_Ipaddress(s0);
EXPORT InValid_ipaddress(SALT311.StrType s) := InValidFT_Invalid_Ipaddress(s);
EXPORT InValidMessage_ipaddress(UNSIGNED1 wh) := InValidMessageFT_Invalid_Ipaddress(wh);

// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_IDA;
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
    BOOLEAN Diff_firstname;
    BOOLEAN Diff_middlename;
    BOOLEAN Diff_lastname;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_addressline1;
    BOOLEAN Diff_addressline2;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_ssn;
    BOOLEAN Diff_dl;
    BOOLEAN Diff_dlstate;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_clientassigneduniquerecordid;
    BOOLEAN Diff_emailaddress;
    BOOLEAN Diff_ipaddress;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_firstname := le.firstname <> ri.firstname;
    SELF.Diff_middlename := le.middlename <> ri.middlename;
    SELF.Diff_lastname := le.lastname <> ri.lastname;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_addressline1 := le.addressline1 <> ri.addressline1;
    SELF.Diff_addressline2 := le.addressline2 <> ri.addressline2;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_ssn := le.ssn <> ri.ssn;
    SELF.Diff_dl := le.dl <> ri.dl;
    SELF.Diff_dlstate := le.dlstate <> ri.dlstate;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_clientassigneduniquerecordid := le.clientassigneduniquerecordid <> ri.clientassigneduniquerecordid;
    SELF.Diff_emailaddress := le.emailaddress <> ri.emailaddress;
    SELF.Diff_ipaddress := le.ipaddress <> ri.ipaddress;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_firstname,1,0)+ IF( SELF.Diff_middlename,1,0)+ IF( SELF.Diff_lastname,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_addressline1,1,0)+ IF( SELF.Diff_addressline2,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_ssn,1,0)+ IF( SELF.Diff_dl,1,0)+ IF( SELF.Diff_dlstate,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_clientassigneduniquerecordid,1,0)+ IF( SELF.Diff_emailaddress,1,0)+ IF( SELF.Diff_ipaddress,1,0);
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
    Count_Diff_firstname := COUNT(GROUP,%Closest%.Diff_firstname);
    Count_Diff_middlename := COUNT(GROUP,%Closest%.Diff_middlename);
    Count_Diff_lastname := COUNT(GROUP,%Closest%.Diff_lastname);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_addressline1 := COUNT(GROUP,%Closest%.Diff_addressline1);
    Count_Diff_addressline2 := COUNT(GROUP,%Closest%.Diff_addressline2);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_ssn := COUNT(GROUP,%Closest%.Diff_ssn);
    Count_Diff_dl := COUNT(GROUP,%Closest%.Diff_dl);
    Count_Diff_dlstate := COUNT(GROUP,%Closest%.Diff_dlstate);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_clientassigneduniquerecordid := COUNT(GROUP,%Closest%.Diff_clientassigneduniquerecordid);
    Count_Diff_emailaddress := COUNT(GROUP,%Closest%.Diff_emailaddress);
    Count_Diff_ipaddress := COUNT(GROUP,%Closest%.Diff_ipaddress);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
