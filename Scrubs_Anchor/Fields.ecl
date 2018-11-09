IMPORT SALT38;
EXPORT Fields := MODULE
 
EXPORT NumFields := 16;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_alpha','invalid_alnum','invalid_date','invalid_name','invalid_address','invalid_city','invalid_zip','invalid_state','invalid_ip');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'invalid_alpha' => 1,'invalid_alnum' => 2,'invalid_date' => 3,'invalid_name' => 4,'invalid_address' => 5,'invalid_city' => 6,'invalid_zip' => 7,'invalid_state' => 8,'invalid_ip' => 9,0);
 
EXPORT MakeFT_invalid_alpha(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -.,'); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' -.,',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alpha(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -.,'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -.,'),SALT38.HygieneErrors.NotLength('0..'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alnum(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -.,'); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' -.,',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alnum(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -.,'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_alnum(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -.,'),SALT38.HygieneErrors.NotLength('0..'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 8));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.NotLength('0..8'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -.()\'&_`\\/,'); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' -.()\'&_`\\/,',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_name(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -.()\'&_`\\/,'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -.()\'&_`\\/,'),SALT38.HygieneErrors.NotLength('0..'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_address(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -#.&:+\\/()_,'); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' -#.&:+\\/()_,',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_address(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -#.&:+\\/()_,'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_address(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -#.&:+\\/()_,'),SALT38.HygieneErrors.NotLength('0..'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_city(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' '); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_city(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' '))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_city(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' '),SALT38.HygieneErrors.NotLength('0..'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.NotLength('0,5,9,10'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_state(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT38.HygieneErrors.NotLength('2,0'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ip(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789.'); // Only allow valid symbols
  s2 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s1,'.',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_ip(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789.'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_ip(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789.'),SALT38.HygieneErrors.NotLength('0..'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'firstname','lastname','address_1','address_2','city','state','zipcode','sourceurl','ipaddress','optindate','emailaddress','anchorinternalcode','addresstype','dob','latitude','longitude');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'firstname','lastname','address_1','address_2','city','state','zipcode','sourceurl','ipaddress','optindate','emailaddress','anchorinternalcode','addresstype','dob','latitude','longitude');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'firstname' => 0,'lastname' => 1,'address_1' => 2,'address_2' => 3,'city' => 4,'state' => 5,'zipcode' => 6,'sourceurl' => 7,'ipaddress' => 8,'optindate' => 9,'emailaddress' => 10,'anchorinternalcode' => 11,'addresstype' => 12,'dob' => 13,'latitude' => 14,'longitude' => 15,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],[],['ALLOW','LENGTH'],['ALLOW','LENGTH'],[],[],[],['ALLOW','LENGTH'],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_firstname(SALT38.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_firstname(SALT38.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_firstname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_lastname(SALT38.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_lastname(SALT38.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_lastname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_address_1(SALT38.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_address_1(SALT38.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_address_1(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_address_2(SALT38.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_address_2(SALT38.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_address_2(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_city(SALT38.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_city(SALT38.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);
 
EXPORT Make_state(SALT38.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state(SALT38.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_zipcode(SALT38.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_zipcode(SALT38.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_zipcode(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_sourceurl(SALT38.StrType s0) := s0;
EXPORT InValid_sourceurl(SALT38.StrType s) := 0;
EXPORT InValidMessage_sourceurl(UNSIGNED1 wh) := '';
 
EXPORT Make_ipaddress(SALT38.StrType s0) := MakeFT_invalid_ip(s0);
EXPORT InValid_ipaddress(SALT38.StrType s) := InValidFT_invalid_ip(s);
EXPORT InValidMessage_ipaddress(UNSIGNED1 wh) := InValidMessageFT_invalid_ip(wh);
 
EXPORT Make_optindate(SALT38.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_optindate(SALT38.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_optindate(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_emailaddress(SALT38.StrType s0) := s0;
EXPORT InValid_emailaddress(SALT38.StrType s) := 0;
EXPORT InValidMessage_emailaddress(UNSIGNED1 wh) := '';
 
EXPORT Make_anchorinternalcode(SALT38.StrType s0) := s0;
EXPORT InValid_anchorinternalcode(SALT38.StrType s) := 0;
EXPORT InValidMessage_anchorinternalcode(UNSIGNED1 wh) := '';
 
EXPORT Make_addresstype(SALT38.StrType s0) := s0;
EXPORT InValid_addresstype(SALT38.StrType s) := 0;
EXPORT InValidMessage_addresstype(UNSIGNED1 wh) := '';
 
EXPORT Make_dob(SALT38.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dob(SALT38.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_latitude(SALT38.StrType s0) := s0;
EXPORT InValid_latitude(SALT38.StrType s) := 0;
EXPORT InValidMessage_latitude(UNSIGNED1 wh) := '';
 
EXPORT Make_longitude(SALT38.StrType s0) := s0;
EXPORT InValid_longitude(SALT38.StrType s) := 0;
EXPORT InValidMessage_longitude(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_Anchor;
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
    BOOLEAN Diff_lastname;
    BOOLEAN Diff_address_1;
    BOOLEAN Diff_address_2;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zipcode;
    BOOLEAN Diff_sourceurl;
    BOOLEAN Diff_ipaddress;
    BOOLEAN Diff_optindate;
    BOOLEAN Diff_emailaddress;
    BOOLEAN Diff_anchorinternalcode;
    BOOLEAN Diff_addresstype;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_latitude;
    BOOLEAN Diff_longitude;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_firstname := le.firstname <> ri.firstname;
    SELF.Diff_lastname := le.lastname <> ri.lastname;
    SELF.Diff_address_1 := le.address_1 <> ri.address_1;
    SELF.Diff_address_2 := le.address_2 <> ri.address_2;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zipcode := le.zipcode <> ri.zipcode;
    SELF.Diff_sourceurl := le.sourceurl <> ri.sourceurl;
    SELF.Diff_ipaddress := le.ipaddress <> ri.ipaddress;
    SELF.Diff_optindate := le.optindate <> ri.optindate;
    SELF.Diff_emailaddress := le.emailaddress <> ri.emailaddress;
    SELF.Diff_anchorinternalcode := le.anchorinternalcode <> ri.anchorinternalcode;
    SELF.Diff_addresstype := le.addresstype <> ri.addresstype;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_latitude := le.latitude <> ri.latitude;
    SELF.Diff_longitude := le.longitude <> ri.longitude;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_firstname,1,0)+ IF( SELF.Diff_lastname,1,0)+ IF( SELF.Diff_address_1,1,0)+ IF( SELF.Diff_address_2,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zipcode,1,0)+ IF( SELF.Diff_sourceurl,1,0)+ IF( SELF.Diff_ipaddress,1,0)+ IF( SELF.Diff_optindate,1,0)+ IF( SELF.Diff_emailaddress,1,0)+ IF( SELF.Diff_anchorinternalcode,1,0)+ IF( SELF.Diff_addresstype,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_latitude,1,0)+ IF( SELF.Diff_longitude,1,0);
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
    Count_Diff_lastname := COUNT(GROUP,%Closest%.Diff_lastname);
    Count_Diff_address_1 := COUNT(GROUP,%Closest%.Diff_address_1);
    Count_Diff_address_2 := COUNT(GROUP,%Closest%.Diff_address_2);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zipcode := COUNT(GROUP,%Closest%.Diff_zipcode);
    Count_Diff_sourceurl := COUNT(GROUP,%Closest%.Diff_sourceurl);
    Count_Diff_ipaddress := COUNT(GROUP,%Closest%.Diff_ipaddress);
    Count_Diff_optindate := COUNT(GROUP,%Closest%.Diff_optindate);
    Count_Diff_emailaddress := COUNT(GROUP,%Closest%.Diff_emailaddress);
    Count_Diff_anchorinternalcode := COUNT(GROUP,%Closest%.Diff_anchorinternalcode);
    Count_Diff_addresstype := COUNT(GROUP,%Closest%.Diff_addresstype);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_latitude := COUNT(GROUP,%Closest%.Diff_latitude);
    Count_Diff_longitude := COUNT(GROUP,%Closest%.Diff_longitude);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
