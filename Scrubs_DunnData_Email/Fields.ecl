IMPORT SALT311;
EXPORT Fields := MODULE
 
EXPORT NumFields := 16;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_alpha','invalid_alnum','invalid_date','invalid_name','invalid_address1','invalid_address2','invalid_city','invalid_zip','invalid_state','invalid_ip','invalid_datestamp','invalid_url','invalid_lastdate');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_alpha' => 1,'invalid_alnum' => 2,'invalid_date' => 3,'invalid_name' => 4,'invalid_address1' => 5,'invalid_address2' => 6,'invalid_city' => 7,'invalid_zip' => 8,'invalid_state' => 9,'invalid_ip' => 10,'invalid_datestamp' => 11,'invalid_url' => 12,'invalid_lastdate' => 13,0);
 
EXPORT MakeFT_invalid_alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -.,'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -.,',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_alpha(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -.,'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ\' -.,'),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alnum(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -.,'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -.,',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_alnum(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -.,'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_alnum(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -.,'),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_invalid_date(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 8));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0..8'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_name(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 2 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.NotWords('2,3'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_address1(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_address1(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_address1(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars(' 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ '),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_address2(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' #-0123456789ABCDEFGHIJKLMNOPRSTUVW '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_address2(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' #-0123456789ABCDEFGHIJKLMNOPRSTUVW '))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_address2(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars(' #-0123456789ABCDEFGHIJKLMNOPRSTUVW '),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_city(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXY '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_city(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXY '))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_city(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXY '),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_invalid_zip(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0,5'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_invalid_state(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.NotLength('2,0'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'.0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_ip(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'.0123456789 '))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_ip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('.0123456789 '),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_datestamp(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' -./0123456789: '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_datestamp(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' -./0123456789: '))),~(LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 16 OR LENGTH(TRIM(s)) = 23 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_datestamp(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars(' -./0123456789: '),SALT311.HygieneErrors.NotLength('19,8,0,16,23,10'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_url(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'-./01234:ABCDEFGHIJKLMNOPQRSTUVWXYZ_ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_url(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'-./01234:ABCDEFGHIJKLMNOPQRSTUVWXYZ_ '))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_url(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('-./01234:ABCDEFGHIJKLMNOPQRSTUVWXYZ_ '),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lastdate(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'/0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_lastdate(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'/0123456789 '))),~(LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_lastdate(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('/0123456789 '),SALT311.HygieneErrors.NotLength('10,0'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dtmatch','email','name_full','address1','address2','city','state','zip5','zip_ext','ipaddr','datestamp','url','lastdate','em_src_cnt','num_emails','num_indiv');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'dtmatch','email','name_full','address1','address2','city','state','zip5','zip_ext','ipaddr','datestamp','url','lastdate','em_src_cnt','num_emails','num_indiv');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'dtmatch' => 0,'email' => 1,'name_full' => 2,'address1' => 3,'address2' => 4,'city' => 5,'state' => 6,'zip5' => 7,'zip_ext' => 8,'ipaddr' => 9,'datestamp' => 10,'url' => 11,'lastdate' => 12,'em_src_cnt' => 13,'num_emails' => 14,'num_indiv' => 15,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],[],['LEFTTRIM','ALLOW','WORDS'],['LEFTTRIM','ALLOW','LENGTHS'],['LEFTTRIM','ALLOW','LENGTHS'],['LEFTTRIM','ALLOW','LENGTHS'],['LEFTTRIM','ALLOW','LENGTHS'],['LEFTTRIM','ALLOW','LENGTHS'],[],['LEFTTRIM','ALLOW','LENGTHS'],['LEFTTRIM','ALLOW','LENGTHS'],['LEFTTRIM','ALLOW','LENGTHS'],['LEFTTRIM','ALLOW','LENGTHS'],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_dtmatch(SALT311.StrType s0) := s0;
EXPORT InValid_dtmatch(SALT311.StrType s) := 0;
EXPORT InValidMessage_dtmatch(UNSIGNED1 wh) := '';
 
EXPORT Make_email(SALT311.StrType s0) := s0;
EXPORT InValid_email(SALT311.StrType s) := 0;
EXPORT InValidMessage_email(UNSIGNED1 wh) := '';
 
EXPORT Make_name_full(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_name_full(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_name_full(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_address1(SALT311.StrType s0) := MakeFT_invalid_address1(s0);
EXPORT InValid_address1(SALT311.StrType s) := InValidFT_invalid_address1(s);
EXPORT InValidMessage_address1(UNSIGNED1 wh) := InValidMessageFT_invalid_address1(wh);
 
EXPORT Make_address2(SALT311.StrType s0) := MakeFT_invalid_address2(s0);
EXPORT InValid_address2(SALT311.StrType s) := InValidFT_invalid_address2(s);
EXPORT InValidMessage_address2(UNSIGNED1 wh) := InValidMessageFT_invalid_address2(wh);
 
EXPORT Make_city(SALT311.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_city(SALT311.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_zip5(SALT311.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_zip5(SALT311.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_zip5(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_zip_ext(SALT311.StrType s0) := s0;
EXPORT InValid_zip_ext(SALT311.StrType s) := 0;
EXPORT InValidMessage_zip_ext(UNSIGNED1 wh) := '';
 
EXPORT Make_ipaddr(SALT311.StrType s0) := MakeFT_invalid_ip(s0);
EXPORT InValid_ipaddr(SALT311.StrType s) := InValidFT_invalid_ip(s);
EXPORT InValidMessage_ipaddr(UNSIGNED1 wh) := InValidMessageFT_invalid_ip(wh);
 
EXPORT Make_datestamp(SALT311.StrType s0) := MakeFT_invalid_datestamp(s0);
EXPORT InValid_datestamp(SALT311.StrType s) := InValidFT_invalid_datestamp(s);
EXPORT InValidMessage_datestamp(UNSIGNED1 wh) := InValidMessageFT_invalid_datestamp(wh);
 
EXPORT Make_url(SALT311.StrType s0) := MakeFT_invalid_url(s0);
EXPORT InValid_url(SALT311.StrType s) := InValidFT_invalid_url(s);
EXPORT InValidMessage_url(UNSIGNED1 wh) := InValidMessageFT_invalid_url(wh);
 
EXPORT Make_lastdate(SALT311.StrType s0) := MakeFT_invalid_lastdate(s0);
EXPORT InValid_lastdate(SALT311.StrType s) := InValidFT_invalid_lastdate(s);
EXPORT InValidMessage_lastdate(UNSIGNED1 wh) := InValidMessageFT_invalid_lastdate(wh);
 
EXPORT Make_em_src_cnt(SALT311.StrType s0) := s0;
EXPORT InValid_em_src_cnt(SALT311.StrType s) := 0;
EXPORT InValidMessage_em_src_cnt(UNSIGNED1 wh) := '';
 
EXPORT Make_num_emails(SALT311.StrType s0) := s0;
EXPORT InValid_num_emails(SALT311.StrType s) := 0;
EXPORT InValidMessage_num_emails(UNSIGNED1 wh) := '';
 
EXPORT Make_num_indiv(SALT311.StrType s0) := s0;
EXPORT InValid_num_indiv(SALT311.StrType s) := 0;
EXPORT InValidMessage_num_indiv(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_DunnData_Email;
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
    BOOLEAN Diff_dtmatch;
    BOOLEAN Diff_email;
    BOOLEAN Diff_name_full;
    BOOLEAN Diff_address1;
    BOOLEAN Diff_address2;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip5;
    BOOLEAN Diff_zip_ext;
    BOOLEAN Diff_ipaddr;
    BOOLEAN Diff_datestamp;
    BOOLEAN Diff_url;
    BOOLEAN Diff_lastdate;
    BOOLEAN Diff_em_src_cnt;
    BOOLEAN Diff_num_emails;
    BOOLEAN Diff_num_indiv;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_dtmatch := le.dtmatch <> ri.dtmatch;
    SELF.Diff_email := le.email <> ri.email;
    SELF.Diff_name_full := le.name_full <> ri.name_full;
    SELF.Diff_address1 := le.address1 <> ri.address1;
    SELF.Diff_address2 := le.address2 <> ri.address2;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip5 := le.zip5 <> ri.zip5;
    SELF.Diff_zip_ext := le.zip_ext <> ri.zip_ext;
    SELF.Diff_ipaddr := le.ipaddr <> ri.ipaddr;
    SELF.Diff_datestamp := le.datestamp <> ri.datestamp;
    SELF.Diff_url := le.url <> ri.url;
    SELF.Diff_lastdate := le.lastdate <> ri.lastdate;
    SELF.Diff_em_src_cnt := le.em_src_cnt <> ri.em_src_cnt;
    SELF.Diff_num_emails := le.num_emails <> ri.num_emails;
    SELF.Diff_num_indiv := le.num_indiv <> ri.num_indiv;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dtmatch,1,0)+ IF( SELF.Diff_email,1,0)+ IF( SELF.Diff_name_full,1,0)+ IF( SELF.Diff_address1,1,0)+ IF( SELF.Diff_address2,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip5,1,0)+ IF( SELF.Diff_zip_ext,1,0)+ IF( SELF.Diff_ipaddr,1,0)+ IF( SELF.Diff_datestamp,1,0)+ IF( SELF.Diff_url,1,0)+ IF( SELF.Diff_lastdate,1,0)+ IF( SELF.Diff_em_src_cnt,1,0)+ IF( SELF.Diff_num_emails,1,0)+ IF( SELF.Diff_num_indiv,1,0);
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
    Count_Diff_dtmatch := COUNT(GROUP,%Closest%.Diff_dtmatch);
    Count_Diff_email := COUNT(GROUP,%Closest%.Diff_email);
    Count_Diff_name_full := COUNT(GROUP,%Closest%.Diff_name_full);
    Count_Diff_address1 := COUNT(GROUP,%Closest%.Diff_address1);
    Count_Diff_address2 := COUNT(GROUP,%Closest%.Diff_address2);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip5 := COUNT(GROUP,%Closest%.Diff_zip5);
    Count_Diff_zip_ext := COUNT(GROUP,%Closest%.Diff_zip_ext);
    Count_Diff_ipaddr := COUNT(GROUP,%Closest%.Diff_ipaddr);
    Count_Diff_datestamp := COUNT(GROUP,%Closest%.Diff_datestamp);
    Count_Diff_url := COUNT(GROUP,%Closest%.Diff_url);
    Count_Diff_lastdate := COUNT(GROUP,%Closest%.Diff_lastdate);
    Count_Diff_em_src_cnt := COUNT(GROUP,%Closest%.Diff_em_src_cnt);
    Count_Diff_num_emails := COUNT(GROUP,%Closest%.Diff_num_emails);
    Count_Diff_num_indiv := COUNT(GROUP,%Closest%.Diff_num_indiv);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
