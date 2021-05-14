IMPORT SALT311;
IMPORT Scrubs_PhoneFinder; // Import modules for FieldTypes attribute definitions
EXPORT Sources_Fields := MODULE
 
EXPORT NumFields := 10;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_No','Invalid_ID','Invalid_Date','Invalid_File','Invalid_Phone');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_No' => 1,'Invalid_ID' => 2,'Invalid_Date' => 3,'Invalid_File' => 4,'Invalid_Phone' => 5,0);
 
EXPORT MakeFT_Invalid_No(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789\\\\N'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_No(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789\\\\N'))));
EXPORT InValidMessageFT_Invalid_No(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789\\\\N'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_ID(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789R\\\\N'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_ID(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789R\\\\N'))));
EXPORT InValidMessageFT_Invalid_ID(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789R\\\\N'),SALT311.HygieneErrors.Good);
 
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
 
EXPORT MakeFT_Invalid_Phone(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789\\\\N'); // Only allow valid symbols
  RETURN  MakeFT_Invalid_No(s1);
END;
EXPORT InValidFT_Invalid_Phone(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789\\\\N'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_Invalid_Phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789\\\\N'),SALT311.HygieneErrors.NotLength('0,2,9,10'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'auto_id','transaction_id','phonenumber','lexid','phone_id','identity_id','sequence_number','totalsourcecount','date_added','filename');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'auto_id','transaction_id','phonenumber','lexid','phone_id','identity_id','sequence_number','totalsourcecount','date_added','filename');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'auto_id' => 0,'transaction_id' => 1,'phonenumber' => 2,'lexid' => 3,'phone_id' => 4,'identity_id' => 5,'sequence_number' => 6,'totalsourcecount' => 7,'date_added' => 8,'filename' => 9,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_auto_id(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_auto_id(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_auto_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_transaction_id(SALT311.StrType s0) := MakeFT_Invalid_ID(s0);
EXPORT InValid_transaction_id(SALT311.StrType s) := InValidFT_Invalid_ID(s);
EXPORT InValidMessage_transaction_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_ID(wh);
 
EXPORT Make_phonenumber(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_phonenumber(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_phonenumber(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_lexid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_lexid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_lexid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_phone_id(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_phone_id(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_phone_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_identity_id(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_identity_id(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_identity_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_sequence_number(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_sequence_number(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_sequence_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_totalsourcecount(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_totalsourcecount(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_totalsourcecount(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_date_added(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_added(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_added(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
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
    BOOLEAN Diff_auto_id;
    BOOLEAN Diff_transaction_id;
    BOOLEAN Diff_phonenumber;
    BOOLEAN Diff_lexid;
    BOOLEAN Diff_phone_id;
    BOOLEAN Diff_identity_id;
    BOOLEAN Diff_sequence_number;
    BOOLEAN Diff_totalsourcecount;
    BOOLEAN Diff_date_added;
    BOOLEAN Diff_filename;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_auto_id := le.auto_id <> ri.auto_id;
    SELF.Diff_transaction_id := le.transaction_id <> ri.transaction_id;
    SELF.Diff_phonenumber := le.phonenumber <> ri.phonenumber;
    SELF.Diff_lexid := le.lexid <> ri.lexid;
    SELF.Diff_phone_id := le.phone_id <> ri.phone_id;
    SELF.Diff_identity_id := le.identity_id <> ri.identity_id;
    SELF.Diff_sequence_number := le.sequence_number <> ri.sequence_number;
    SELF.Diff_totalsourcecount := le.totalsourcecount <> ri.totalsourcecount;
    SELF.Diff_date_added := le.date_added <> ri.date_added;
    SELF.Diff_filename := le.filename <> ri.filename;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_auto_id,1,0)+ IF( SELF.Diff_transaction_id,1,0)+ IF( SELF.Diff_phonenumber,1,0)+ IF( SELF.Diff_lexid,1,0)+ IF( SELF.Diff_phone_id,1,0)+ IF( SELF.Diff_identity_id,1,0)+ IF( SELF.Diff_sequence_number,1,0)+ IF( SELF.Diff_totalsourcecount,1,0)+ IF( SELF.Diff_date_added,1,0)+ IF( SELF.Diff_filename,1,0);
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
    Count_Diff_auto_id := COUNT(GROUP,%Closest%.Diff_auto_id);
    Count_Diff_transaction_id := COUNT(GROUP,%Closest%.Diff_transaction_id);
    Count_Diff_phonenumber := COUNT(GROUP,%Closest%.Diff_phonenumber);
    Count_Diff_lexid := COUNT(GROUP,%Closest%.Diff_lexid);
    Count_Diff_phone_id := COUNT(GROUP,%Closest%.Diff_phone_id);
    Count_Diff_identity_id := COUNT(GROUP,%Closest%.Diff_identity_id);
    Count_Diff_sequence_number := COUNT(GROUP,%Closest%.Diff_sequence_number);
    Count_Diff_totalsourcecount := COUNT(GROUP,%Closest%.Diff_totalsourcecount);
    Count_Diff_date_added := COUNT(GROUP,%Closest%.Diff_date_added);
    Count_Diff_filename := COUNT(GROUP,%Closest%.Diff_filename);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
