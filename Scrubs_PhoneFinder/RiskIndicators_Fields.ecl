IMPORT SALT311;
IMPORT Scrubs_PhoneFinder; // Import modules for FieldTypes attribute definitions
EXPORT RiskIndicators_Fields := MODULE
 
EXPORT NumFields := 9;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_No','Invalid_ID','Invalid_Alpha','Invalid_AlphaChar','Invalid_Risk','Invalid_Date','Invalid_File');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_No' => 1,'Invalid_ID' => 2,'Invalid_Alpha' => 3,'Invalid_AlphaChar' => 4,'Invalid_Risk' => 5,'Invalid_Date' => 6,'Invalid_File' => 7,0);
 
EXPORT MakeFT_Invalid_No(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789-\\\\N'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_No(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789-\\\\N'))));
EXPORT InValidMessageFT_Invalid_No(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789-\\\\N'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_ID(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789R\\\\N'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_ID(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789R\\\\N'))));
EXPORT InValidMessageFT_Invalid_ID(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789R\\\\N'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\\\\ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\\\\ '))));
EXPORT InValidMessageFT_Invalid_Alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ\\\\ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaChar(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ .,/-\\\\\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaChar(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ .,/-\\\\\''))));
EXPORT InValidMessageFT_Invalid_AlphaChar(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ .,/-\\\\\''),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Risk(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Risk(SALT311.StrType s) := WHICH(~Scrubs_PhoneFinder.Functions.Risk_Check(s)>0);
EXPORT InValidMessageFT_Invalid_Risk(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_PhoneFinder.Functions.Risk_Check'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Scrubs_PhoneFinder.Functions.Split_Date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_PhoneFinder.Functions.Split_Date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_File(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_File(SALT311.StrType s) := WHICH(~Scrubs_PhoneFinder.Functions.Check_File(s)>0);
EXPORT InValidMessageFT_Invalid_File(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_PhoneFinder.Functions.Check_File'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'transaction_id','phone_id','sequence_number','date_added','risk_indicator_id','risk_indicator_level','risk_indicator_text','risk_indicator_category','filename');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'transaction_id','phone_id','sequence_number','date_added','risk_indicator_id','risk_indicator_level','risk_indicator_text','risk_indicator_category','filename');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'transaction_id' => 0,'phone_id' => 1,'sequence_number' => 2,'date_added' => 3,'risk_indicator_id' => 4,'risk_indicator_level' => 5,'risk_indicator_text' => 6,'risk_indicator_category' => 7,'filename' => 8,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],[],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_transaction_id(SALT311.StrType s0) := MakeFT_Invalid_ID(s0);
EXPORT InValid_transaction_id(SALT311.StrType s) := InValidFT_Invalid_ID(s);
EXPORT InValidMessage_transaction_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_ID(wh);
 
EXPORT Make_phone_id(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_phone_id(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_phone_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_sequence_number(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_sequence_number(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_sequence_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_date_added(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_added(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_added(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_risk_indicator_id(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_risk_indicator_id(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_risk_indicator_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_risk_indicator_level(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_risk_indicator_level(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_risk_indicator_level(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_risk_indicator_text(SALT311.StrType s0) := s0;
EXPORT InValid_risk_indicator_text(SALT311.StrType s) := 0;
EXPORT InValidMessage_risk_indicator_text(UNSIGNED1 wh) := '';
 
EXPORT Make_risk_indicator_category(SALT311.StrType s0) := MakeFT_Invalid_Risk(s0);
EXPORT InValid_risk_indicator_category(SALT311.StrType s) := InValidFT_Invalid_Risk(s);
EXPORT InValidMessage_risk_indicator_category(UNSIGNED1 wh) := InValidMessageFT_Invalid_Risk(wh);
 
EXPORT Make_filename(SALT311.StrType s0) := MakeFT_Invalid_File(s0);
EXPORT InValid_filename(SALT311.StrType s) := InValidFT_Invalid_File(s);
EXPORT InValidMessage_filename(UNSIGNED1 wh) := InValidMessageFT_Invalid_File(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_PhoneFinder;
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
    BOOLEAN Diff_phone_id;
    BOOLEAN Diff_sequence_number;
    BOOLEAN Diff_date_added;
    BOOLEAN Diff_risk_indicator_id;
    BOOLEAN Diff_risk_indicator_level;
    BOOLEAN Diff_risk_indicator_text;
    BOOLEAN Diff_risk_indicator_category;
    BOOLEAN Diff_filename;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_transaction_id := le.transaction_id <> ri.transaction_id;
    SELF.Diff_phone_id := le.phone_id <> ri.phone_id;
    SELF.Diff_sequence_number := le.sequence_number <> ri.sequence_number;
    SELF.Diff_date_added := le.date_added <> ri.date_added;
    SELF.Diff_risk_indicator_id := le.risk_indicator_id <> ri.risk_indicator_id;
    SELF.Diff_risk_indicator_level := le.risk_indicator_level <> ri.risk_indicator_level;
    SELF.Diff_risk_indicator_text := le.risk_indicator_text <> ri.risk_indicator_text;
    SELF.Diff_risk_indicator_category := le.risk_indicator_category <> ri.risk_indicator_category;
    SELF.Diff_filename := le.filename <> ri.filename;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_transaction_id,1,0)+ IF( SELF.Diff_phone_id,1,0)+ IF( SELF.Diff_sequence_number,1,0)+ IF( SELF.Diff_date_added,1,0)+ IF( SELF.Diff_risk_indicator_id,1,0)+ IF( SELF.Diff_risk_indicator_level,1,0)+ IF( SELF.Diff_risk_indicator_text,1,0)+ IF( SELF.Diff_risk_indicator_category,1,0)+ IF( SELF.Diff_filename,1,0);
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
    Count_Diff_phone_id := COUNT(GROUP,%Closest%.Diff_phone_id);
    Count_Diff_sequence_number := COUNT(GROUP,%Closest%.Diff_sequence_number);
    Count_Diff_date_added := COUNT(GROUP,%Closest%.Diff_date_added);
    Count_Diff_risk_indicator_id := COUNT(GROUP,%Closest%.Diff_risk_indicator_id);
    Count_Diff_risk_indicator_level := COUNT(GROUP,%Closest%.Diff_risk_indicator_level);
    Count_Diff_risk_indicator_text := COUNT(GROUP,%Closest%.Diff_risk_indicator_text);
    Count_Diff_risk_indicator_category := COUNT(GROUP,%Closest%.Diff_risk_indicator_category);
    Count_Diff_filename := COUNT(GROUP,%Closest%.Diff_filename);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
