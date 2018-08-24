IMPORT SALT39;
EXPORT InquiryLogs_Fields := MODULE
 
EXPORT NumFields := 24;
 
// Processing for each FieldType
EXPORT SALT39.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_alpha','invalid_alphanumeric','invalid_email','invalid_date','invalid_numeric','invalid_zip','invalid_state','invalid_ssn','invalid_phone','invalid_ip','invalid_name','invalid_decimal');
EXPORT FieldTypeNum(SALT39.StrType fn) := CASE(fn,'invalid_alpha' => 1,'invalid_alphanumeric' => 2,'invalid_email' => 3,'invalid_date' => 4,'invalid_numeric' => 5,'invalid_zip' => 6,'invalid_state' => 7,'invalid_ssn' => 8,'invalid_phone' => 9,'invalid_ip' => 10,'invalid_name' => 11,'invalid_decimal' => 12,0);
 
EXPORT MakeFT_invalid_alpha(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 4));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT39.HygieneErrors.NotLength('0,4..'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanumeric(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'`!+&,./#()_'); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' <>{}[]-^=\'`!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alphanumeric(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'`!+&,./#()_'))));
EXPORT InValidMessageFT_invalid_alphanumeric(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'`!+&,./#()_'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_email(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'-_.0123456789@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_email(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'-_.0123456789@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_invalid_email(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('-_.0123456789@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 <>{}[]-^=\'`!+&,./#()_'); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' <>{}[]-^=\'`!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_date(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 <>{}[]-^=\'`!+&,./#()_'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 8));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 <>{}[]-^=\'`!+&,./#()_'),SALT39.HygieneErrors.NotLength('0,8..'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'-0123456789 <>{}[]-^=\'`!+&,./#()_'); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' <>{}[]-^=\'`!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_zip(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'-0123456789 <>{}[]-^=\'`!+&,./#()_'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 5));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('-0123456789 <>{}[]-^=\'`!+&,./#()_'),SALT39.HygieneErrors.NotLength('0,5..'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz <>{}[]-^=\'`!+&,./#()_'); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' <>{}[]-^=\'`!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_state(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz <>{}[]-^=\'`!+&,./#()_'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz <>{}[]-^=\'`!+&,./#()_'),SALT39.HygieneErrors.NotLength('0,2'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ssn(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 <>{}[]-^=\'`!+&,./#()_'); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' <>{}[]-^=\'`!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_ssn(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 <>{}[]-^=\'`!+&,./#()_'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 <>{}[]-^=\'`!+&,./#()_'),SALT39.HygieneErrors.NotLength('0,9'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 <>{}[]-^=\'`!+&,./#()_'); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' <>{}[]-^=\'`!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_phone(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 <>{}[]-^=\'`!+&,./#()_'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 10));
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 <>{}[]-^=\'`!+&,./#()_'),SALT39.HygieneErrors.NotLength('0,10..'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ip(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'.0123456789 <>{}[]-^=\'`!+&,./#()_'); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' <>{}[]-^=\'`!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_ip(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'.0123456789 <>{}[]-^=\'`!+&,./#()_'))));
EXPORT InValidMessageFT_invalid_ip(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('.0123456789 <>{}[]-^=\'`!+&,./#()_'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz <>{}[]-^=\'`!+&,./#()_'); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' <>{}[]-^=\'`!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz <>{}[]-^=\'`!+&,./#()_'))));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz <>{}[]-^=\'`!+&,./#()_'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_decimal(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'-.,0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_decimal(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'-.,0123456789'))));
EXPORT InValidMessageFT_invalid_decimal(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('-.,0123456789'),SALT39.HygieneErrors.Good);
 
EXPORT SALT39.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'transaction_id','datetime','full_name','title','fname','mname','lname','name_suffix','ssn','appended_ssn','address','city','state','zip','fips_county','personal_phone','dob','email_address','dl_st','dl','ipaddr','geo_lat','geo_long','Source');
EXPORT SALT39.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'transaction_id','datetime','full_name','title','fname','mname','lname','name_suffix','ssn','appended_ssn','address','city','state','zip','fips_county','personal_phone','dob','email_address','dl_st','dl','ipaddr','geo_lat','geo_long','Source');
EXPORT FieldNum(SALT39.StrType fn) := CASE(fn,'transaction_id' => 0,'datetime' => 1,'full_name' => 2,'title' => 3,'fname' => 4,'mname' => 5,'lname' => 6,'name_suffix' => 7,'ssn' => 8,'appended_ssn' => 9,'address' => 10,'city' => 11,'state' => 12,'zip' => 13,'fips_county' => 14,'personal_phone' => 15,'dob' => 16,'email_address' => 17,'dl_st' => 18,'dl' => 19,'ipaddr' => 20,'geo_lat' => 21,'geo_long' => 22,'Source' => 23,0);
EXPORT SET OF SALT39.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['LEFTTRIM','ALLOW','LENGTHS'],['LEFTTRIM','ALLOW'],['ALLOW'],['LEFTTRIM','ALLOW'],['LEFTTRIM','ALLOW'],['LEFTTRIM','ALLOW'],['ALLOW'],['LEFTTRIM','ALLOW','LENGTHS'],['LEFTTRIM','ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['LEFTTRIM','ALLOW','LENGTHS'],['LEFTTRIM','ALLOW','LENGTHS'],['ALLOW'],['LEFTTRIM','ALLOW','LENGTHS'],['LEFTTRIM','ALLOW','LENGTHS'],['ALLOW'],['LEFTTRIM','ALLOW','LENGTHS'],['ALLOW'],['LEFTTRIM','ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_transaction_id(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_transaction_id(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_transaction_id(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_datetime(SALT39.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_datetime(SALT39.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_datetime(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_full_name(SALT39.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_full_name(SALT39.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_full_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_title(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_title(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_title(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_fname(SALT39.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_fname(SALT39.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_mname(SALT39.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_mname(SALT39.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_lname(SALT39.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_lname(SALT39.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_name_suffix(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_name_suffix(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_ssn(SALT39.StrType s0) := MakeFT_invalid_ssn(s0);
EXPORT InValid_ssn(SALT39.StrType s) := InValidFT_invalid_ssn(s);
EXPORT InValidMessage_ssn(UNSIGNED1 wh) := InValidMessageFT_invalid_ssn(wh);
 
EXPORT Make_appended_ssn(SALT39.StrType s0) := MakeFT_invalid_ssn(s0);
EXPORT InValid_appended_ssn(SALT39.StrType s) := InValidFT_invalid_ssn(s);
EXPORT InValidMessage_appended_ssn(UNSIGNED1 wh) := InValidMessageFT_invalid_ssn(wh);
 
EXPORT Make_address(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_address(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_address(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_city(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_city(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_state(SALT39.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state(SALT39.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_zip(SALT39.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_zip(SALT39.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_fips_county(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_fips_county(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_fips_county(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_personal_phone(SALT39.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_personal_phone(SALT39.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_personal_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_dob(SALT39.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dob(SALT39.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_email_address(SALT39.StrType s0) := MakeFT_invalid_email(s0);
EXPORT InValid_email_address(SALT39.StrType s) := InValidFT_invalid_email(s);
EXPORT InValidMessage_email_address(UNSIGNED1 wh) := InValidMessageFT_invalid_email(wh);
 
EXPORT Make_dl_st(SALT39.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_dl_st(SALT39.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_dl_st(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_dl(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_dl(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_dl(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_ipaddr(SALT39.StrType s0) := MakeFT_invalid_ip(s0);
EXPORT InValid_ipaddr(SALT39.StrType s) := InValidFT_invalid_ip(s);
EXPORT InValidMessage_ipaddr(UNSIGNED1 wh) := InValidMessageFT_invalid_ip(wh);
 
EXPORT Make_geo_lat(SALT39.StrType s0) := MakeFT_invalid_decimal(s0);
EXPORT InValid_geo_lat(SALT39.StrType s) := InValidFT_invalid_decimal(s);
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := InValidMessageFT_invalid_decimal(wh);
 
EXPORT Make_geo_long(SALT39.StrType s0) := MakeFT_invalid_decimal(s0);
EXPORT InValid_geo_long(SALT39.StrType s) := InValidFT_invalid_decimal(s);
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := InValidMessageFT_invalid_decimal(wh);
 
EXPORT Make_Source(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_Source(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_Source(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT39,Scrubs_FraudGov;
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
    BOOLEAN Diff_transaction_id;
    BOOLEAN Diff_datetime;
    BOOLEAN Diff_full_name;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_ssn;
    BOOLEAN Diff_appended_ssn;
    BOOLEAN Diff_address;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_fips_county;
    BOOLEAN Diff_personal_phone;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_email_address;
    BOOLEAN Diff_dl_st;
    BOOLEAN Diff_dl;
    BOOLEAN Diff_ipaddr;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_Source;
    UNSIGNED Num_Diffs;
    SALT39.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_transaction_id := le.transaction_id <> ri.transaction_id;
    SELF.Diff_datetime := le.datetime <> ri.datetime;
    SELF.Diff_full_name := le.full_name <> ri.full_name;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_ssn := le.ssn <> ri.ssn;
    SELF.Diff_appended_ssn := le.appended_ssn <> ri.appended_ssn;
    SELF.Diff_address := le.address <> ri.address;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_fips_county := le.fips_county <> ri.fips_county;
    SELF.Diff_personal_phone := le.personal_phone <> ri.personal_phone;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_email_address := le.email_address <> ri.email_address;
    SELF.Diff_dl_st := le.dl_st <> ri.dl_st;
    SELF.Diff_dl := le.dl <> ri.dl;
    SELF.Diff_ipaddr := le.ipaddr <> ri.ipaddr;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_Source := le.Source <> ri.Source;
    SELF.Val := (SALT39.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_transaction_id,1,0)+ IF( SELF.Diff_datetime,1,0)+ IF( SELF.Diff_full_name,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_ssn,1,0)+ IF( SELF.Diff_appended_ssn,1,0)+ IF( SELF.Diff_address,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_personal_phone,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_email_address,1,0)+ IF( SELF.Diff_dl_st,1,0)+ IF( SELF.Diff_dl,1,0)+ IF( SELF.Diff_ipaddr,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_Source,1,0);
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
    Count_Diff_transaction_id := COUNT(GROUP,%Closest%.Diff_transaction_id);
    Count_Diff_datetime := COUNT(GROUP,%Closest%.Diff_datetime);
    Count_Diff_full_name := COUNT(GROUP,%Closest%.Diff_full_name);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_ssn := COUNT(GROUP,%Closest%.Diff_ssn);
    Count_Diff_appended_ssn := COUNT(GROUP,%Closest%.Diff_appended_ssn);
    Count_Diff_address := COUNT(GROUP,%Closest%.Diff_address);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_fips_county := COUNT(GROUP,%Closest%.Diff_fips_county);
    Count_Diff_personal_phone := COUNT(GROUP,%Closest%.Diff_personal_phone);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_email_address := COUNT(GROUP,%Closest%.Diff_email_address);
    Count_Diff_dl_st := COUNT(GROUP,%Closest%.Diff_dl_st);
    Count_Diff_dl := COUNT(GROUP,%Closest%.Diff_dl);
    Count_Diff_ipaddr := COUNT(GROUP,%Closest%.Diff_ipaddr);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_Source := COUNT(GROUP,%Closest%.Diff_Source);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
