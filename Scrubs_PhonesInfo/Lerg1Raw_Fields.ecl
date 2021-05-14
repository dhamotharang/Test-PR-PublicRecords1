IMPORT SALT311;
EXPORT Lerg1Raw_Fields := MODULE
 
EXPORT NumFields := 26;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Alpha','Invalid_AlphaNum','Invalid_Category','Invalid_Char','Invalid_Filename','Invalid_Indicator','Invalid_NotBlank','Invalid_Ocn','Invalid_Ocn_State','Invalid_Phone');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Alpha' => 1,'Invalid_AlphaNum' => 2,'Invalid_Category' => 3,'Invalid_Char' => 4,'Invalid_Filename' => 5,'Invalid_Indicator' => 6,'Invalid_NotBlank' => 7,'Invalid_Ocn' => 8,'Invalid_Ocn_State' => 9,'Invalid_Phone' => 10,0);
 
EXPORT MakeFT_Invalid_Alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_Invalid_Alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_Invalid_Alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNum(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_Invalid_AlphaNum(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '))));
EXPORT InValidMessageFT_Invalid_AlphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Category(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_Invalid_Category(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Invalid_Category(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Char(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-/\',. '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_Invalid_Char(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-/\',. '))));
EXPORT InValidMessageFT_Invalid_Char(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-/\',. '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Filename(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.:'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Filename(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.:'))));
EXPORT InValidMessageFT_Invalid_Filename(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.:'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Indicator(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'X '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_Invalid_Indicator(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'X '))));
EXPORT InValidMessageFT_Invalid_Indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('X '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_NotBlank(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_NotBlank(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Invalid_NotBlank(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Ocn(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Ocn(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Invalid_Ocn(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Ocn_State(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Ocn_State(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) >= 1 AND LENGTH(TRIM(s)) <= 2));
EXPORT InValidMessageFT_Invalid_Ocn_State(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.NotLength('1..2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Phone(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789- '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_Invalid_Phone(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789- '))));
EXPORT InValidMessageFT_Invalid_Phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789- '),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'ocn','ocn_name','ocn_abbr_name','ocn_state','category','overall_ocn','filler1','filler2','last_name','first_name','middle_initial','company_name','title','address1','address2','floor','room','city','state','postal_code','phone','target_ocn','overall_target_ocn','rural_lec_indicator','small_ilec_indicator','filename');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'ocn','ocn_name','ocn_abbr_name','ocn_state','category','overall_ocn','filler1','filler2','last_name','first_name','middle_initial','company_name','title','address1','address2','floor','room','city','state','postal_code','phone','target_ocn','overall_target_ocn','rural_lec_indicator','small_ilec_indicator','filename');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'ocn' => 0,'ocn_name' => 1,'ocn_abbr_name' => 2,'ocn_state' => 3,'category' => 4,'overall_ocn' => 5,'filler1' => 6,'filler2' => 7,'last_name' => 8,'first_name' => 9,'middle_initial' => 10,'company_name' => 11,'title' => 12,'address1' => 13,'address2' => 14,'floor' => 15,'room' => 16,'city' => 17,'state' => 18,'postal_code' => 19,'phone' => 20,'target_ocn' => 21,'overall_target_ocn' => 22,'rural_lec_indicator' => 23,'small_ilec_indicator' => 24,'filename' => 25,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','LENGTHS'],['LENGTHS'],['LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],[],[],['LENGTHS'],['LENGTHS'],['ALLOW'],[],[],[],[],[],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_ocn(SALT311.StrType s0) := MakeFT_Invalid_Ocn(s0);
EXPORT InValid_ocn(SALT311.StrType s) := InValidFT_Invalid_Ocn(s);
EXPORT InValidMessage_ocn(UNSIGNED1 wh) := InValidMessageFT_Invalid_Ocn(wh);
 
EXPORT Make_ocn_name(SALT311.StrType s0) := MakeFT_Invalid_NotBlank(s0);
EXPORT InValid_ocn_name(SALT311.StrType s) := InValidFT_Invalid_NotBlank(s);
EXPORT InValidMessage_ocn_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_NotBlank(wh);
 
EXPORT Make_ocn_abbr_name(SALT311.StrType s0) := MakeFT_Invalid_NotBlank(s0);
EXPORT InValid_ocn_abbr_name(SALT311.StrType s) := InValidFT_Invalid_NotBlank(s);
EXPORT InValidMessage_ocn_abbr_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_NotBlank(wh);
 
EXPORT Make_ocn_state(SALT311.StrType s0) := MakeFT_Invalid_Ocn_State(s0);
EXPORT InValid_ocn_state(SALT311.StrType s) := InValidFT_Invalid_Ocn_State(s);
EXPORT InValidMessage_ocn_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_Ocn_State(wh);
 
EXPORT Make_category(SALT311.StrType s0) := MakeFT_Invalid_Category(s0);
EXPORT InValid_category(SALT311.StrType s) := InValidFT_Invalid_Category(s);
EXPORT InValidMessage_category(UNSIGNED1 wh) := InValidMessageFT_Invalid_Category(wh);
 
EXPORT Make_overall_ocn(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_overall_ocn(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_overall_ocn(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_filler1(SALT311.StrType s0) := s0;
EXPORT InValid_filler1(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler1(UNSIGNED1 wh) := '';
 
EXPORT Make_filler2(SALT311.StrType s0) := s0;
EXPORT InValid_filler2(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler2(UNSIGNED1 wh) := '';
 
EXPORT Make_last_name(SALT311.StrType s0) := MakeFT_Invalid_NotBlank(s0);
EXPORT InValid_last_name(SALT311.StrType s) := InValidFT_Invalid_NotBlank(s);
EXPORT InValidMessage_last_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_NotBlank(wh);
 
EXPORT Make_first_name(SALT311.StrType s0) := MakeFT_Invalid_NotBlank(s0);
EXPORT InValid_first_name(SALT311.StrType s) := InValidFT_Invalid_NotBlank(s);
EXPORT InValidMessage_first_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_NotBlank(wh);
 
EXPORT Make_middle_initial(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_middle_initial(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_middle_initial(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_company_name(SALT311.StrType s0) := s0;
EXPORT InValid_company_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := '';
 
EXPORT Make_title(SALT311.StrType s0) := s0;
EXPORT InValid_title(SALT311.StrType s) := 0;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_address1(SALT311.StrType s0) := s0;
EXPORT InValid_address1(SALT311.StrType s) := 0;
EXPORT InValidMessage_address1(UNSIGNED1 wh) := '';
 
EXPORT Make_address2(SALT311.StrType s0) := s0;
EXPORT InValid_address2(SALT311.StrType s) := 0;
EXPORT InValidMessage_address2(UNSIGNED1 wh) := '';
 
EXPORT Make_floor(SALT311.StrType s0) := s0;
EXPORT InValid_floor(SALT311.StrType s) := 0;
EXPORT InValidMessage_floor(UNSIGNED1 wh) := '';
 
EXPORT Make_room(SALT311.StrType s0) := s0;
EXPORT InValid_room(SALT311.StrType s) := 0;
EXPORT InValidMessage_room(UNSIGNED1 wh) := '';
 
EXPORT Make_city(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_city(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_postal_code(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_postal_code(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_postal_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_phone(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_phone(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_target_ocn(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_target_ocn(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_target_ocn(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_overall_target_ocn(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_overall_target_ocn(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_overall_target_ocn(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_rural_lec_indicator(SALT311.StrType s0) := MakeFT_Invalid_Indicator(s0);
EXPORT InValid_rural_lec_indicator(SALT311.StrType s) := InValidFT_Invalid_Indicator(s);
EXPORT InValidMessage_rural_lec_indicator(UNSIGNED1 wh) := InValidMessageFT_Invalid_Indicator(wh);
 
EXPORT Make_small_ilec_indicator(SALT311.StrType s0) := s0;
EXPORT InValid_small_ilec_indicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_small_ilec_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_filename(SALT311.StrType s0) := MakeFT_Invalid_Filename(s0);
EXPORT InValid_filename(SALT311.StrType s) := InValidFT_Invalid_Filename(s);
EXPORT InValidMessage_filename(UNSIGNED1 wh) := InValidMessageFT_Invalid_Filename(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_PhonesInfo;
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
    BOOLEAN Diff_ocn;
    BOOLEAN Diff_ocn_name;
    BOOLEAN Diff_ocn_abbr_name;
    BOOLEAN Diff_ocn_state;
    BOOLEAN Diff_category;
    BOOLEAN Diff_overall_ocn;
    BOOLEAN Diff_filler1;
    BOOLEAN Diff_filler2;
    BOOLEAN Diff_last_name;
    BOOLEAN Diff_first_name;
    BOOLEAN Diff_middle_initial;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_title;
    BOOLEAN Diff_address1;
    BOOLEAN Diff_address2;
    BOOLEAN Diff_floor;
    BOOLEAN Diff_room;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_postal_code;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_target_ocn;
    BOOLEAN Diff_overall_target_ocn;
    BOOLEAN Diff_rural_lec_indicator;
    BOOLEAN Diff_small_ilec_indicator;
    BOOLEAN Diff_filename;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_ocn := le.ocn <> ri.ocn;
    SELF.Diff_ocn_name := le.ocn_name <> ri.ocn_name;
    SELF.Diff_ocn_abbr_name := le.ocn_abbr_name <> ri.ocn_abbr_name;
    SELF.Diff_ocn_state := le.ocn_state <> ri.ocn_state;
    SELF.Diff_category := le.category <> ri.category;
    SELF.Diff_overall_ocn := le.overall_ocn <> ri.overall_ocn;
    SELF.Diff_filler1 := le.filler1 <> ri.filler1;
    SELF.Diff_filler2 := le.filler2 <> ri.filler2;
    SELF.Diff_last_name := le.last_name <> ri.last_name;
    SELF.Diff_first_name := le.first_name <> ri.first_name;
    SELF.Diff_middle_initial := le.middle_initial <> ri.middle_initial;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_address1 := le.address1 <> ri.address1;
    SELF.Diff_address2 := le.address2 <> ri.address2;
    SELF.Diff_floor := le.floor <> ri.floor;
    SELF.Diff_room := le.room <> ri.room;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_postal_code := le.postal_code <> ri.postal_code;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_target_ocn := le.target_ocn <> ri.target_ocn;
    SELF.Diff_overall_target_ocn := le.overall_target_ocn <> ri.overall_target_ocn;
    SELF.Diff_rural_lec_indicator := le.rural_lec_indicator <> ri.rural_lec_indicator;
    SELF.Diff_small_ilec_indicator := le.small_ilec_indicator <> ri.small_ilec_indicator;
    SELF.Diff_filename := le.filename <> ri.filename;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_ocn,1,0)+ IF( SELF.Diff_ocn_name,1,0)+ IF( SELF.Diff_ocn_abbr_name,1,0)+ IF( SELF.Diff_ocn_state,1,0)+ IF( SELF.Diff_category,1,0)+ IF( SELF.Diff_overall_ocn,1,0)+ IF( SELF.Diff_filler1,1,0)+ IF( SELF.Diff_filler2,1,0)+ IF( SELF.Diff_last_name,1,0)+ IF( SELF.Diff_first_name,1,0)+ IF( SELF.Diff_middle_initial,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_address1,1,0)+ IF( SELF.Diff_address2,1,0)+ IF( SELF.Diff_floor,1,0)+ IF( SELF.Diff_room,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_postal_code,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_target_ocn,1,0)+ IF( SELF.Diff_overall_target_ocn,1,0)+ IF( SELF.Diff_rural_lec_indicator,1,0)+ IF( SELF.Diff_small_ilec_indicator,1,0)+ IF( SELF.Diff_filename,1,0);
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
    Count_Diff_ocn := COUNT(GROUP,%Closest%.Diff_ocn);
    Count_Diff_ocn_name := COUNT(GROUP,%Closest%.Diff_ocn_name);
    Count_Diff_ocn_abbr_name := COUNT(GROUP,%Closest%.Diff_ocn_abbr_name);
    Count_Diff_ocn_state := COUNT(GROUP,%Closest%.Diff_ocn_state);
    Count_Diff_category := COUNT(GROUP,%Closest%.Diff_category);
    Count_Diff_overall_ocn := COUNT(GROUP,%Closest%.Diff_overall_ocn);
    Count_Diff_filler1 := COUNT(GROUP,%Closest%.Diff_filler1);
    Count_Diff_filler2 := COUNT(GROUP,%Closest%.Diff_filler2);
    Count_Diff_last_name := COUNT(GROUP,%Closest%.Diff_last_name);
    Count_Diff_first_name := COUNT(GROUP,%Closest%.Diff_first_name);
    Count_Diff_middle_initial := COUNT(GROUP,%Closest%.Diff_middle_initial);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_address1 := COUNT(GROUP,%Closest%.Diff_address1);
    Count_Diff_address2 := COUNT(GROUP,%Closest%.Diff_address2);
    Count_Diff_floor := COUNT(GROUP,%Closest%.Diff_floor);
    Count_Diff_room := COUNT(GROUP,%Closest%.Diff_room);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_postal_code := COUNT(GROUP,%Closest%.Diff_postal_code);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_target_ocn := COUNT(GROUP,%Closest%.Diff_target_ocn);
    Count_Diff_overall_target_ocn := COUNT(GROUP,%Closest%.Diff_overall_target_ocn);
    Count_Diff_rural_lec_indicator := COUNT(GROUP,%Closest%.Diff_rural_lec_indicator);
    Count_Diff_small_ilec_indicator := COUNT(GROUP,%Closest%.Diff_small_ilec_indicator);
    Count_Diff_filename := COUNT(GROUP,%Closest%.Diff_filename);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
