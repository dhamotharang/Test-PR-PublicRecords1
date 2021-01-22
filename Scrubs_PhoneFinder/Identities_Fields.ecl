IMPORT SALT311;
IMPORT Scrubs_PhoneFinder; // Import modules for FieldTypes attribute definitions
EXPORT Identities_Fields := MODULE
 
EXPORT NumFields := 11;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_No','Invalid_ID','Invalid_State','Invalid_AlphaChar','Invalid_AlphaNumChar','Invalid_Zip','Invalid_Date','Invalid_File');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_No' => 1,'Invalid_ID' => 2,'Invalid_State' => 3,'Invalid_AlphaChar' => 4,'Invalid_AlphaNumChar' => 5,'Invalid_Zip' => 6,'Invalid_Date' => 7,'Invalid_File' => 8,0);
 
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
 
EXPORT MakeFT_Invalid_State(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\\\\ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_State(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\\\\ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ\\\\ '),SALT311.HygieneErrors.NotLength('0,2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaChar(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ&#\\(\\)_\\|:;* .,/+-@\\\\\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaChar(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ&#\\(\\)_\\|:;* .,/+-@\\\\\''))));
EXPORT InValidMessageFT_Invalid_AlphaChar(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ&#\\(\\)_\\|:;* .,/+-@\\\\\''),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNumChar(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ&#\\(\\)_\\|:;* .,/+-@\\\\\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaNumChar(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ&#\\(\\)_\\|:;* .,/+-@\\\\\''))));
EXPORT InValidMessageFT_Invalid_AlphaNumChar(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ&#\\(\\)_\\|:;* .,/+-@\\\\\''),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789\\\\N'); // Only allow valid symbols
  RETURN  MakeFT_Invalid_No(s1);
END;
EXPORT InValidFT_Invalid_Zip(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789\\\\N'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_Invalid_Zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789\\\\N'),SALT311.HygieneErrors.NotLength('0,2,5'),SALT311.HygieneErrors.Good);
 
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
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'transaction_id','sequence_number','lexid','full_name','full_address','city','state','zip','verified_carrier','date_added','filename');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'transaction_id','sequence_number','lexid','full_name','full_address','city','state','zip','verified_carrier','date_added','filename');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'transaction_id' => 0,'sequence_number' => 1,'lexid' => 2,'full_name' => 3,'full_address' => 4,'city' => 5,'state' => 6,'zip' => 7,'verified_carrier' => 8,'date_added' => 9,'filename' => 10,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_transaction_id(SALT311.StrType s0) := MakeFT_Invalid_ID(s0);
EXPORT InValid_transaction_id(SALT311.StrType s) := InValidFT_Invalid_ID(s);
EXPORT InValidMessage_transaction_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_ID(wh);
 
EXPORT Make_sequence_number(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_sequence_number(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_sequence_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_lexid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_lexid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_lexid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_full_name(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_full_name(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_full_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_full_address(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_full_address(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_full_address(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_city(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_city(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_zip(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_zip(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_verified_carrier(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_verified_carrier(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_verified_carrier(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
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
    BOOLEAN Diff_transaction_id;
    BOOLEAN Diff_sequence_number;
    BOOLEAN Diff_lexid;
    BOOLEAN Diff_full_name;
    BOOLEAN Diff_full_address;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_verified_carrier;
    BOOLEAN Diff_date_added;
    BOOLEAN Diff_filename;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_transaction_id := le.transaction_id <> ri.transaction_id;
    SELF.Diff_sequence_number := le.sequence_number <> ri.sequence_number;
    SELF.Diff_lexid := le.lexid <> ri.lexid;
    SELF.Diff_full_name := le.full_name <> ri.full_name;
    SELF.Diff_full_address := le.full_address <> ri.full_address;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_verified_carrier := le.verified_carrier <> ri.verified_carrier;
    SELF.Diff_date_added := le.date_added <> ri.date_added;
    SELF.Diff_filename := le.filename <> ri.filename;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_transaction_id,1,0)+ IF( SELF.Diff_sequence_number,1,0)+ IF( SELF.Diff_lexid,1,0)+ IF( SELF.Diff_full_name,1,0)+ IF( SELF.Diff_full_address,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_verified_carrier,1,0)+ IF( SELF.Diff_date_added,1,0)+ IF( SELF.Diff_filename,1,0);
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
    Count_Diff_sequence_number := COUNT(GROUP,%Closest%.Diff_sequence_number);
    Count_Diff_lexid := COUNT(GROUP,%Closest%.Diff_lexid);
    Count_Diff_full_name := COUNT(GROUP,%Closest%.Diff_full_name);
    Count_Diff_full_address := COUNT(GROUP,%Closest%.Diff_full_address);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_verified_carrier := COUNT(GROUP,%Closest%.Diff_verified_carrier);
    Count_Diff_date_added := COUNT(GROUP,%Closest%.Diff_date_added);
    Count_Diff_filename := COUNT(GROUP,%Closest%.Diff_filename);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
