IMPORT SALT311;
EXPORT Lerg1ConRaw_Fields := MODULE
 
EXPORT NumFields := 8;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Alpha','Invalid_AlphaNum','Invalid_Char','Invalid_Filename','Invalid_Indicator','Invalid_NotBlank','Invalid_Ocn','Invalid_Ocn_State','Invalid_Phone');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Alpha' => 1,'Invalid_AlphaNum' => 2,'Invalid_Char' => 3,'Invalid_Filename' => 4,'Invalid_Indicator' => 5,'Invalid_NotBlank' => 6,'Invalid_Ocn' => 7,'Invalid_Ocn_State' => 8,'Invalid_Phone' => 9,0);
 
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
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'ocn','ocn_name','ocn_state','contact_function','contact_phone','contact_information','filler','filename');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'ocn','ocn_name','ocn_state','contact_function','contact_phone','contact_information','filler','filename');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'ocn' => 0,'ocn_name' => 1,'ocn_state' => 2,'contact_function' => 3,'contact_phone' => 4,'contact_information' => 5,'filler' => 6,'filename' => 7,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','LENGTHS'],['LENGTHS'],['ALLOW','LENGTHS'],['LENGTHS'],['ALLOW'],[],[],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_ocn(SALT311.StrType s0) := MakeFT_Invalid_Ocn(s0);
EXPORT InValid_ocn(SALT311.StrType s) := InValidFT_Invalid_Ocn(s);
EXPORT InValidMessage_ocn(UNSIGNED1 wh) := InValidMessageFT_Invalid_Ocn(wh);
 
EXPORT Make_ocn_name(SALT311.StrType s0) := MakeFT_Invalid_NotBlank(s0);
EXPORT InValid_ocn_name(SALT311.StrType s) := InValidFT_Invalid_NotBlank(s);
EXPORT InValidMessage_ocn_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_NotBlank(wh);
 
EXPORT Make_ocn_state(SALT311.StrType s0) := MakeFT_Invalid_Ocn_State(s0);
EXPORT InValid_ocn_state(SALT311.StrType s) := InValidFT_Invalid_Ocn_State(s);
EXPORT InValidMessage_ocn_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_Ocn_State(wh);
 
EXPORT Make_contact_function(SALT311.StrType s0) := MakeFT_Invalid_NotBlank(s0);
EXPORT InValid_contact_function(SALT311.StrType s) := InValidFT_Invalid_NotBlank(s);
EXPORT InValidMessage_contact_function(UNSIGNED1 wh) := InValidMessageFT_Invalid_NotBlank(wh);
 
EXPORT Make_contact_phone(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_contact_phone(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_contact_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_contact_information(SALT311.StrType s0) := s0;
EXPORT InValid_contact_information(SALT311.StrType s) := 0;
EXPORT InValidMessage_contact_information(UNSIGNED1 wh) := '';
 
EXPORT Make_filler(SALT311.StrType s0) := s0;
EXPORT InValid_filler(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler(UNSIGNED1 wh) := '';
 
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
    BOOLEAN Diff_ocn_state;
    BOOLEAN Diff_contact_function;
    BOOLEAN Diff_contact_phone;
    BOOLEAN Diff_contact_information;
    BOOLEAN Diff_filler;
    BOOLEAN Diff_filename;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_ocn := le.ocn <> ri.ocn;
    SELF.Diff_ocn_name := le.ocn_name <> ri.ocn_name;
    SELF.Diff_ocn_state := le.ocn_state <> ri.ocn_state;
    SELF.Diff_contact_function := le.contact_function <> ri.contact_function;
    SELF.Diff_contact_phone := le.contact_phone <> ri.contact_phone;
    SELF.Diff_contact_information := le.contact_information <> ri.contact_information;
    SELF.Diff_filler := le.filler <> ri.filler;
    SELF.Diff_filename := le.filename <> ri.filename;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_ocn,1,0)+ IF( SELF.Diff_ocn_name,1,0)+ IF( SELF.Diff_ocn_state,1,0)+ IF( SELF.Diff_contact_function,1,0)+ IF( SELF.Diff_contact_phone,1,0)+ IF( SELF.Diff_contact_information,1,0)+ IF( SELF.Diff_filler,1,0)+ IF( SELF.Diff_filename,1,0);
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
    Count_Diff_ocn_state := COUNT(GROUP,%Closest%.Diff_ocn_state);
    Count_Diff_contact_function := COUNT(GROUP,%Closest%.Diff_contact_function);
    Count_Diff_contact_phone := COUNT(GROUP,%Closest%.Diff_contact_phone);
    Count_Diff_contact_information := COUNT(GROUP,%Closest%.Diff_contact_information);
    Count_Diff_filler := COUNT(GROUP,%Closest%.Diff_filler);
    Count_Diff_filename := COUNT(GROUP,%Closest%.Diff_filename);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
