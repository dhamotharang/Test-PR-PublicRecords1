IMPORT SALT311;
EXPORT InfutorWP_Fields := MODULE
 
EXPORT NumFields := 18;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_phone','invalid_canadian_zip','invalid_province','invalid_record_type','invalid_address','invalid_city','invalid_name','invalid_alpha');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_phone' => 1,'invalid_canadian_zip' => 2,'invalid_province' => 3,'invalid_record_type' => 4,'invalid_address' => 5,'invalid_city' => 6,'invalid_name' => 7,'invalid_alpha' => 8,0);
 
EXPORT MakeFT_invalid_phone(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_phone(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 10 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('10,0'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_canadian_zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_canadian_zip(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 6));
EXPORT InValidMessageFT_invalid_canadian_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '),SALT311.HygieneErrors.NotLength('0,6'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_province(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_province(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_province(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.NotLength('2,0'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_record_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['B','R',''],~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('B|R|'),SALT311.HygieneErrors.NotLength('1,0'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_address(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890\' ()-&/\\#.;,\\:"=*+'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ()-&/\\#.;,\\:"=*+',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_address(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890\' ()-&/\\#.;,\\:"=*+'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_address(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890\' ()-&/\\#.;,\\:"=*+'),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_city(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-\'.,&/ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_city(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-\'.,&/ '))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_city(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-\'.,&/ '),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\'"+=@#$%^&+-_\\:*!?` ,.(){}/\\;'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ,.(){}/\\;',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\'"+=@#$%^&+-_\\:*!?` ,.(){}/\\;'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\'"+=@#$%^&+-_\\:*!?` ,.(){}/\\;'),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890+_` -\'/.'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -\'/.',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890+_` -\'/.'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890+_` -\'/.'),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'can_phone','can_title','can_fname','can_lname','can_suffix','can_address1','can_house','can_predir','can_street','can_strtype','can_postdir','can_apttype','can_aptnbr','can_city','can_province','can_postalcd','can_lang','can_rectype');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'can_phone','can_title','can_fname','can_lname','can_suffix','can_address1','can_house','can_predir','can_street','can_strtype','can_postdir','can_apttype','can_aptnbr','can_city','can_province','can_postalcd','can_lang','can_rectype');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'can_phone' => 0,'can_title' => 1,'can_fname' => 2,'can_lname' => 3,'can_suffix' => 4,'can_address1' => 5,'can_house' => 6,'can_predir' => 7,'can_street' => 8,'can_strtype' => 9,'can_postdir' => 10,'can_apttype' => 11,'can_aptnbr' => 12,'can_city' => 13,'can_province' => 14,'can_postalcd' => 15,'can_lang' => 16,'can_rectype' => 17,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],['ENUM','LENGTHS'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_can_phone(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_can_phone(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_can_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_can_title(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_can_title(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_can_title(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_can_fname(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_can_fname(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_can_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_can_lname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_can_lname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_can_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_can_suffix(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_can_suffix(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_can_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_can_address1(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_can_address1(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_can_address1(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_can_house(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_can_house(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_can_house(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_can_predir(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_can_predir(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_can_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_can_street(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_can_street(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_can_street(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_can_strtype(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_can_strtype(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_can_strtype(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_can_postdir(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_can_postdir(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_can_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_can_apttype(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_can_apttype(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_can_apttype(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_can_aptnbr(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_can_aptnbr(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_can_aptnbr(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_can_city(SALT311.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_can_city(SALT311.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_can_city(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);
 
EXPORT Make_can_province(SALT311.StrType s0) := MakeFT_invalid_province(s0);
EXPORT InValid_can_province(SALT311.StrType s) := InValidFT_invalid_province(s);
EXPORT InValidMessage_can_province(UNSIGNED1 wh) := InValidMessageFT_invalid_province(wh);
 
EXPORT Make_can_postalcd(SALT311.StrType s0) := MakeFT_invalid_canadian_zip(s0);
EXPORT InValid_can_postalcd(SALT311.StrType s) := InValidFT_invalid_canadian_zip(s);
EXPORT InValidMessage_can_postalcd(UNSIGNED1 wh) := InValidMessageFT_invalid_canadian_zip(wh);
 
EXPORT Make_can_lang(SALT311.StrType s0) := s0;
EXPORT InValid_can_lang(SALT311.StrType s) := 0;
EXPORT InValidMessage_can_lang(UNSIGNED1 wh) := '';
 
EXPORT Make_can_rectype(SALT311.StrType s0) := MakeFT_invalid_record_type(s0);
EXPORT InValid_can_rectype(SALT311.StrType s) := InValidFT_invalid_record_type(s);
EXPORT InValidMessage_can_rectype(UNSIGNED1 wh) := InValidMessageFT_invalid_record_type(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_CanadianPhones;
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
    BOOLEAN Diff_can_phone;
    BOOLEAN Diff_can_title;
    BOOLEAN Diff_can_fname;
    BOOLEAN Diff_can_lname;
    BOOLEAN Diff_can_suffix;
    BOOLEAN Diff_can_address1;
    BOOLEAN Diff_can_house;
    BOOLEAN Diff_can_predir;
    BOOLEAN Diff_can_street;
    BOOLEAN Diff_can_strtype;
    BOOLEAN Diff_can_postdir;
    BOOLEAN Diff_can_apttype;
    BOOLEAN Diff_can_aptnbr;
    BOOLEAN Diff_can_city;
    BOOLEAN Diff_can_province;
    BOOLEAN Diff_can_postalcd;
    BOOLEAN Diff_can_lang;
    BOOLEAN Diff_can_rectype;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_can_phone := le.can_phone <> ri.can_phone;
    SELF.Diff_can_title := le.can_title <> ri.can_title;
    SELF.Diff_can_fname := le.can_fname <> ri.can_fname;
    SELF.Diff_can_lname := le.can_lname <> ri.can_lname;
    SELF.Diff_can_suffix := le.can_suffix <> ri.can_suffix;
    SELF.Diff_can_address1 := le.can_address1 <> ri.can_address1;
    SELF.Diff_can_house := le.can_house <> ri.can_house;
    SELF.Diff_can_predir := le.can_predir <> ri.can_predir;
    SELF.Diff_can_street := le.can_street <> ri.can_street;
    SELF.Diff_can_strtype := le.can_strtype <> ri.can_strtype;
    SELF.Diff_can_postdir := le.can_postdir <> ri.can_postdir;
    SELF.Diff_can_apttype := le.can_apttype <> ri.can_apttype;
    SELF.Diff_can_aptnbr := le.can_aptnbr <> ri.can_aptnbr;
    SELF.Diff_can_city := le.can_city <> ri.can_city;
    SELF.Diff_can_province := le.can_province <> ri.can_province;
    SELF.Diff_can_postalcd := le.can_postalcd <> ri.can_postalcd;
    SELF.Diff_can_lang := le.can_lang <> ri.can_lang;
    SELF.Diff_can_rectype := le.can_rectype <> ri.can_rectype;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_can_phone,1,0)+ IF( SELF.Diff_can_title,1,0)+ IF( SELF.Diff_can_fname,1,0)+ IF( SELF.Diff_can_lname,1,0)+ IF( SELF.Diff_can_suffix,1,0)+ IF( SELF.Diff_can_address1,1,0)+ IF( SELF.Diff_can_house,1,0)+ IF( SELF.Diff_can_predir,1,0)+ IF( SELF.Diff_can_street,1,0)+ IF( SELF.Diff_can_strtype,1,0)+ IF( SELF.Diff_can_postdir,1,0)+ IF( SELF.Diff_can_apttype,1,0)+ IF( SELF.Diff_can_aptnbr,1,0)+ IF( SELF.Diff_can_city,1,0)+ IF( SELF.Diff_can_province,1,0)+ IF( SELF.Diff_can_postalcd,1,0)+ IF( SELF.Diff_can_lang,1,0)+ IF( SELF.Diff_can_rectype,1,0);
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
    Count_Diff_can_phone := COUNT(GROUP,%Closest%.Diff_can_phone);
    Count_Diff_can_title := COUNT(GROUP,%Closest%.Diff_can_title);
    Count_Diff_can_fname := COUNT(GROUP,%Closest%.Diff_can_fname);
    Count_Diff_can_lname := COUNT(GROUP,%Closest%.Diff_can_lname);
    Count_Diff_can_suffix := COUNT(GROUP,%Closest%.Diff_can_suffix);
    Count_Diff_can_address1 := COUNT(GROUP,%Closest%.Diff_can_address1);
    Count_Diff_can_house := COUNT(GROUP,%Closest%.Diff_can_house);
    Count_Diff_can_predir := COUNT(GROUP,%Closest%.Diff_can_predir);
    Count_Diff_can_street := COUNT(GROUP,%Closest%.Diff_can_street);
    Count_Diff_can_strtype := COUNT(GROUP,%Closest%.Diff_can_strtype);
    Count_Diff_can_postdir := COUNT(GROUP,%Closest%.Diff_can_postdir);
    Count_Diff_can_apttype := COUNT(GROUP,%Closest%.Diff_can_apttype);
    Count_Diff_can_aptnbr := COUNT(GROUP,%Closest%.Diff_can_aptnbr);
    Count_Diff_can_city := COUNT(GROUP,%Closest%.Diff_can_city);
    Count_Diff_can_province := COUNT(GROUP,%Closest%.Diff_can_province);
    Count_Diff_can_postalcd := COUNT(GROUP,%Closest%.Diff_can_postalcd);
    Count_Diff_can_lang := COUNT(GROUP,%Closest%.Diff_can_lang);
    Count_Diff_can_rectype := COUNT(GROUP,%Closest%.Diff_can_rectype);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
