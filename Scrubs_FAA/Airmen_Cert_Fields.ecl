IMPORT SALT38;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Airmen_Cert_Fields := MODULE
 
EXPORT NumFields := 15;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Num','Invalid_Alpha','Invalid_CerLevel','Invalid_CerType','Invalid_RecType','Invalid_Date','Invalid_Flag','Invalid_LetterCode');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'Invalid_Num' => 1,'Invalid_Alpha' => 2,'Invalid_CerLevel' => 3,'Invalid_CerType' => 4,'Invalid_RecType' => 5,'Invalid_Date' => 6,'Invalid_Flag' => 7,'Invalid_LetterCode' => 8,0);
 
EXPORT MakeFT_Invalid_Num(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Alpha(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Alpha(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_Invalid_Alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_CerLevel(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_CerLevel(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['P','S','C','A','Y','Z','W','T','U','V','']);
EXPORT InValidMessageFT_Invalid_CerLevel(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('P|S|C|A|Y|Z|W|T|U|V|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_CerType(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_CerType(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['P','F','M','Y','G','R','T','E','U','D','I','W','L','Z','N','H','A','X','J','']);
EXPORT InValidMessageFT_Invalid_CerType(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('P|F|M|Y|G|R|T|E|U|D|I|W|L|Z|N|H|A|X|J|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_RecType(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_RecType(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['01','02','03','04','05','06','07','']);
EXPORT InValidMessageFT_Invalid_RecType(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('01|02|03|04|05|06|07|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT38.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Flag(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Flag(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['H','I','A']);
EXPORT InValidMessageFT_Invalid_Flag(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('H|I|A'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_LetterCode(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_LetterCode(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['A','C']);
EXPORT InValidMessageFT_Invalid_LetterCode(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('A|C'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'date_first_seen','date_last_seen','current_flag','letter','unique_id','rec_type','cer_type','cer_type_mapped','cer_level','cer_level_mapped','cer_exp_date','ratings','filler','lfcr','persistent_record_id');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'date_first_seen','date_last_seen','current_flag','letter','unique_id','rec_type','cer_type','cer_type_mapped','cer_level','cer_level_mapped','cer_exp_date','ratings','filler','lfcr','persistent_record_id');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'date_first_seen' => 0,'date_last_seen' => 1,'current_flag' => 2,'letter' => 3,'unique_id' => 4,'rec_type' => 5,'cer_type' => 6,'cer_type_mapped' => 7,'cer_level' => 8,'cer_level_mapped' => 9,'cer_exp_date' => 10,'ratings' => 11,'filler' => 12,'lfcr' => 13,'persistent_record_id' => 14,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['ALLOW'],['ENUM'],['ENUM'],[],['ENUM'],[],['ALLOW'],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_date_first_seen(SALT38.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_first_seen(SALT38.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_first_seen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_date_last_seen(SALT38.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_last_seen(SALT38.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_last_seen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_current_flag(SALT38.StrType s0) := MakeFT_Invalid_Flag(s0);
EXPORT InValid_current_flag(SALT38.StrType s) := InValidFT_Invalid_Flag(s);
EXPORT InValidMessage_current_flag(UNSIGNED1 wh) := InValidMessageFT_Invalid_Flag(wh);
 
EXPORT Make_letter(SALT38.StrType s0) := MakeFT_Invalid_LetterCode(s0);
EXPORT InValid_letter(SALT38.StrType s) := InValidFT_Invalid_LetterCode(s);
EXPORT InValidMessage_letter(UNSIGNED1 wh) := InValidMessageFT_Invalid_LetterCode(wh);
 
EXPORT Make_unique_id(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_unique_id(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_unique_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_rec_type(SALT38.StrType s0) := MakeFT_Invalid_RecType(s0);
EXPORT InValid_rec_type(SALT38.StrType s) := InValidFT_Invalid_RecType(s);
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_RecType(wh);
 
EXPORT Make_cer_type(SALT38.StrType s0) := MakeFT_Invalid_CerType(s0);
EXPORT InValid_cer_type(SALT38.StrType s) := InValidFT_Invalid_CerType(s);
EXPORT InValidMessage_cer_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_CerType(wh);
 
EXPORT Make_cer_type_mapped(SALT38.StrType s0) := s0;
EXPORT InValid_cer_type_mapped(SALT38.StrType s) := 0;
EXPORT InValidMessage_cer_type_mapped(UNSIGNED1 wh) := '';
 
EXPORT Make_cer_level(SALT38.StrType s0) := MakeFT_Invalid_CerLevel(s0);
EXPORT InValid_cer_level(SALT38.StrType s) := InValidFT_Invalid_CerLevel(s);
EXPORT InValidMessage_cer_level(UNSIGNED1 wh) := InValidMessageFT_Invalid_CerLevel(wh);
 
EXPORT Make_cer_level_mapped(SALT38.StrType s0) := s0;
EXPORT InValid_cer_level_mapped(SALT38.StrType s) := 0;
EXPORT InValidMessage_cer_level_mapped(UNSIGNED1 wh) := '';
 
EXPORT Make_cer_exp_date(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_cer_exp_date(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_cer_exp_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_ratings(SALT38.StrType s0) := s0;
EXPORT InValid_ratings(SALT38.StrType s) := 0;
EXPORT InValidMessage_ratings(UNSIGNED1 wh) := '';
 
EXPORT Make_filler(SALT38.StrType s0) := s0;
EXPORT InValid_filler(SALT38.StrType s) := 0;
EXPORT InValidMessage_filler(UNSIGNED1 wh) := '';
 
EXPORT Make_lfcr(SALT38.StrType s0) := s0;
EXPORT InValid_lfcr(SALT38.StrType s) := 0;
EXPORT InValidMessage_lfcr(UNSIGNED1 wh) := '';
 
EXPORT Make_persistent_record_id(SALT38.StrType s0) := s0;
EXPORT InValid_persistent_record_id(SALT38.StrType s) := 0;
EXPORT InValidMessage_persistent_record_id(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_FAA;
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
    BOOLEAN Diff_date_first_seen;
    BOOLEAN Diff_date_last_seen;
    BOOLEAN Diff_current_flag;
    BOOLEAN Diff_letter;
    BOOLEAN Diff_unique_id;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_cer_type;
    BOOLEAN Diff_cer_type_mapped;
    BOOLEAN Diff_cer_level;
    BOOLEAN Diff_cer_level_mapped;
    BOOLEAN Diff_cer_exp_date;
    BOOLEAN Diff_ratings;
    BOOLEAN Diff_filler;
    BOOLEAN Diff_lfcr;
    BOOLEAN Diff_persistent_record_id;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_date_first_seen := le.date_first_seen <> ri.date_first_seen;
    SELF.Diff_date_last_seen := le.date_last_seen <> ri.date_last_seen;
    SELF.Diff_current_flag := le.current_flag <> ri.current_flag;
    SELF.Diff_letter := le.letter <> ri.letter;
    SELF.Diff_unique_id := le.unique_id <> ri.unique_id;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_cer_type := le.cer_type <> ri.cer_type;
    SELF.Diff_cer_type_mapped := le.cer_type_mapped <> ri.cer_type_mapped;
    SELF.Diff_cer_level := le.cer_level <> ri.cer_level;
    SELF.Diff_cer_level_mapped := le.cer_level_mapped <> ri.cer_level_mapped;
    SELF.Diff_cer_exp_date := le.cer_exp_date <> ri.cer_exp_date;
    SELF.Diff_ratings := le.ratings <> ri.ratings;
    SELF.Diff_filler := le.filler <> ri.filler;
    SELF.Diff_lfcr := le.lfcr <> ri.lfcr;
    SELF.Diff_persistent_record_id := le.persistent_record_id <> ri.persistent_record_id;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_current_flag,1,0)+ IF( SELF.Diff_letter,1,0)+ IF( SELF.Diff_unique_id,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_cer_type,1,0)+ IF( SELF.Diff_cer_type_mapped,1,0)+ IF( SELF.Diff_cer_level,1,0)+ IF( SELF.Diff_cer_level_mapped,1,0)+ IF( SELF.Diff_cer_exp_date,1,0)+ IF( SELF.Diff_ratings,1,0)+ IF( SELF.Diff_filler,1,0)+ IF( SELF.Diff_lfcr,1,0)+ IF( SELF.Diff_persistent_record_id,1,0);
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
    Count_Diff_date_first_seen := COUNT(GROUP,%Closest%.Diff_date_first_seen);
    Count_Diff_date_last_seen := COUNT(GROUP,%Closest%.Diff_date_last_seen);
    Count_Diff_current_flag := COUNT(GROUP,%Closest%.Diff_current_flag);
    Count_Diff_letter := COUNT(GROUP,%Closest%.Diff_letter);
    Count_Diff_unique_id := COUNT(GROUP,%Closest%.Diff_unique_id);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_cer_type := COUNT(GROUP,%Closest%.Diff_cer_type);
    Count_Diff_cer_type_mapped := COUNT(GROUP,%Closest%.Diff_cer_type_mapped);
    Count_Diff_cer_level := COUNT(GROUP,%Closest%.Diff_cer_level);
    Count_Diff_cer_level_mapped := COUNT(GROUP,%Closest%.Diff_cer_level_mapped);
    Count_Diff_cer_exp_date := COUNT(GROUP,%Closest%.Diff_cer_exp_date);
    Count_Diff_ratings := COUNT(GROUP,%Closest%.Diff_ratings);
    Count_Diff_filler := COUNT(GROUP,%Closest%.Diff_filler);
    Count_Diff_lfcr := COUNT(GROUP,%Closest%.Diff_lfcr);
    Count_Diff_persistent_record_id := COUNT(GROUP,%Closest%.Diff_persistent_record_id);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
