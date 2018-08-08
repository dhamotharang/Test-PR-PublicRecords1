IMPORT SALT38;
EXPORT Fields := MODULE
 
EXPORT NumFields := 15;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_alpha','invalid_alnum','invalid_date','invalid_name','invalid_suffix','invalid_zip5','invalid_zip4','invalid_state','invalid_phone','invalid_ip');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'invalid_alpha' => 1,'invalid_alnum' => 2,'invalid_date' => 3,'invalid_name' => 4,'invalid_suffix' => 5,'invalid_zip5' => 6,'invalid_zip4' => 7,'invalid_state' => 8,'invalid_phone' => 9,'invalid_ip' => 10,0);
 
EXPORT MakeFT_invalid_alpha(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -.,'); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' -.,',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alpha(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -.,'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -.,'),SALT38.HygieneErrors.NotLength('0..'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alnum(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -#.,\\/_'); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' -#.,\\/_',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alnum(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -#.,\\/_'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_alnum(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -#.,\\/_'),SALT38.HygieneErrors.NotLength('0..'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789-'); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,'-',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_date(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789-'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 10));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789-'),SALT38.HygieneErrors.NotLength('0..10'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -.()\'&_`/'); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' -.()\'&_`/',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_name(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -.()\'&_`/'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -.()\'&_`/'),SALT38.HygieneErrors.NotLength('0..'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_suffix(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -.,'); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' -.,',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_suffix(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -.,'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -.,'),SALT38.HygieneErrors.NotLength('0..'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip5(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip5(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_invalid_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.NotLength('0,5'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip4(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip4(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_invalid_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.NotLength('0,4'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_state(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT38.HygieneErrors.NotLength('2,0'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_phone(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 10));
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.NotLength('0..10'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ip(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789.'); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,'.',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_ip(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789.'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_ip(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789.'),SALT38.HygieneErrors.NotLength('0..'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'firstname','middleinit','lastname','suffix','address','city','state','zipcode','zipplus4','phone','dob','email','ipaddr','datestamp','url');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'firstname','middleinit','lastname','suffix','address','city','state','zipcode','zipplus4','phone','dob','email','ipaddr','datestamp','url');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'firstname' => 0,'middleinit' => 1,'lastname' => 2,'suffix' => 3,'address' => 4,'city' => 5,'state' => 6,'zipcode' => 7,'zipplus4' => 8,'phone' => 9,'dob' => 10,'email' => 11,'ipaddr' => 12,'datestamp' => 13,'url' => 14,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],[],[],['ALLOW','LENGTH'],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_firstname(SALT38.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_firstname(SALT38.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_firstname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_middleinit(SALT38.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_middleinit(SALT38.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_middleinit(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_lastname(SALT38.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_lastname(SALT38.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_lastname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_suffix(SALT38.StrType s0) := MakeFT_invalid_suffix(s0);
EXPORT InValid_suffix(SALT38.StrType s) := InValidFT_invalid_suffix(s);
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_suffix(wh);
 
EXPORT Make_address(SALT38.StrType s0) := MakeFT_invalid_alnum(s0);
EXPORT InValid_address(SALT38.StrType s) := InValidFT_invalid_alnum(s);
EXPORT InValidMessage_address(UNSIGNED1 wh) := InValidMessageFT_invalid_alnum(wh);
 
EXPORT Make_city(SALT38.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_city(SALT38.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_state(SALT38.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state(SALT38.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_zipcode(SALT38.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_zipcode(SALT38.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_zipcode(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
EXPORT Make_zipplus4(SALT38.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_zipplus4(SALT38.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_zipplus4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);
 
EXPORT Make_phone(SALT38.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_phone(SALT38.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_dob(SALT38.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dob(SALT38.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_email(SALT38.StrType s0) := s0;
EXPORT InValid_email(SALT38.StrType s) := 0;
EXPORT InValidMessage_email(UNSIGNED1 wh) := '';
 
EXPORT Make_ipaddr(SALT38.StrType s0) := s0;
EXPORT InValid_ipaddr(SALT38.StrType s) := 0;
EXPORT InValidMessage_ipaddr(UNSIGNED1 wh) := '';
 
EXPORT Make_datestamp(SALT38.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_datestamp(SALT38.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_datestamp(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_url(SALT38.StrType s0) := s0;
EXPORT InValid_url(SALT38.StrType s) := 0;
EXPORT InValidMessage_url(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_RealSource;
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
    BOOLEAN Diff_middleinit;
    BOOLEAN Diff_lastname;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_address;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zipcode;
    BOOLEAN Diff_zipplus4;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_email;
    BOOLEAN Diff_ipaddr;
    BOOLEAN Diff_datestamp;
    BOOLEAN Diff_url;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_firstname := le.firstname <> ri.firstname;
    SELF.Diff_middleinit := le.middleinit <> ri.middleinit;
    SELF.Diff_lastname := le.lastname <> ri.lastname;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_address := le.address <> ri.address;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zipcode := le.zipcode <> ri.zipcode;
    SELF.Diff_zipplus4 := le.zipplus4 <> ri.zipplus4;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_email := le.email <> ri.email;
    SELF.Diff_ipaddr := le.ipaddr <> ri.ipaddr;
    SELF.Diff_datestamp := le.datestamp <> ri.datestamp;
    SELF.Diff_url := le.url <> ri.url;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_firstname,1,0)+ IF( SELF.Diff_middleinit,1,0)+ IF( SELF.Diff_lastname,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_address,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zipcode,1,0)+ IF( SELF.Diff_zipplus4,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_email,1,0)+ IF( SELF.Diff_ipaddr,1,0)+ IF( SELF.Diff_datestamp,1,0)+ IF( SELF.Diff_url,1,0);
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
    Count_Diff_middleinit := COUNT(GROUP,%Closest%.Diff_middleinit);
    Count_Diff_lastname := COUNT(GROUP,%Closest%.Diff_lastname);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_address := COUNT(GROUP,%Closest%.Diff_address);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zipcode := COUNT(GROUP,%Closest%.Diff_zipcode);
    Count_Diff_zipplus4 := COUNT(GROUP,%Closest%.Diff_zipplus4);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_email := COUNT(GROUP,%Closest%.Diff_email);
    Count_Diff_ipaddr := COUNT(GROUP,%Closest%.Diff_ipaddr);
    Count_Diff_datestamp := COUNT(GROUP,%Closest%.Diff_datestamp);
    Count_Diff_url := COUNT(GROUP,%Closest%.Diff_url);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
