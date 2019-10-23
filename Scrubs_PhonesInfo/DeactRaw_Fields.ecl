IMPORT SALT38;
EXPORT DeactRaw_Fields := MODULE

EXPORT NumFields := 5;

// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Action_Code','Invalid_Num','Invalid_Num_Blank','Invalid_Filename');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'Invalid_Action_Code' => 1,'Invalid_Num' => 2,'Invalid_Num_Blank' => 3,'Invalid_Filename' => 4,0);

EXPORT MakeFT_Invalid_Action_Code(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Action_Code(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['DE','SW','SU','RE']);
EXPORT InValidMessageFT_Invalid_Action_Code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('DE|SW|SU|RE'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Num(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Num_Blank(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num_Blank(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_Invalid_Num_Blank(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789 '),SALT38.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Filename(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.:'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Filename(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.:'))));
EXPORT InValidMessageFT_Invalid_Filename(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.:'),SALT38.HygieneErrors.Good);


EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'action_code','timestamp','phone','phone_swap','filename');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'action_code','timestamp','phone','phone_swap','filename');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'action_code' => 0,'timestamp' => 1,'phone' => 2,'phone_swap' => 3,'filename' => 4,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ENUM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);

//Individual field level validation


EXPORT Make_action_code(SALT38.StrType s0) := MakeFT_Invalid_Action_Code(s0);
EXPORT InValid_action_code(SALT38.StrType s) := InValidFT_Invalid_Action_Code(s);
EXPORT InValidMessage_action_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Action_Code(wh);


EXPORT Make_timestamp(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_timestamp(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_timestamp(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_phone(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phone(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_phone_swap(SALT38.StrType s0) := MakeFT_Invalid_Num_Blank(s0);
EXPORT InValid_phone_swap(SALT38.StrType s) := InValidFT_Invalid_Num_Blank(s);
EXPORT InValidMessage_phone_swap(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num_Blank(wh);


EXPORT Make_filename(SALT38.StrType s0) := MakeFT_Invalid_Filename(s0);
EXPORT InValid_filename(SALT38.StrType s) := InValidFT_Invalid_Filename(s);
EXPORT InValidMessage_filename(UNSIGNED1 wh) := InValidMessageFT_Invalid_Filename(wh);

// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_PhonesInfo;
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
    BOOLEAN Diff_action_code;
    BOOLEAN Diff_timestamp;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_phone_swap;
    BOOLEAN Diff_filename;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_action_code := le.action_code <> ri.action_code;
    SELF.Diff_timestamp := le.timestamp <> ri.timestamp;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_phone_swap := le.phone_swap <> ri.phone_swap;
    SELF.Diff_filename := le.filename <> ri.filename;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_action_code,1,0)+ IF( SELF.Diff_timestamp,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_phone_swap,1,0)+ IF( SELF.Diff_filename,1,0);
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
    Count_Diff_action_code := COUNT(GROUP,%Closest%.Diff_action_code);
    Count_Diff_timestamp := COUNT(GROUP,%Closest%.Diff_timestamp);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_phone_swap := COUNT(GROUP,%Closest%.Diff_phone_swap);
    Count_Diff_filename := COUNT(GROUP,%Closest%.Diff_filename);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
