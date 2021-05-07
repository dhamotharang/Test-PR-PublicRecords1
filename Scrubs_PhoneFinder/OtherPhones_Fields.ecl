IMPORT SALT311;
IMPORT Scrubs_PhoneFinder; // Import modules for FieldTypes attribute definitions
EXPORT OtherPhones_Fields := MODULE
 
EXPORT NumFields := 16;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_No','Invalid_ID','Invalid_Rating','Invalid_Risk','Invalid_Type','Invalid_Status','Invalid_Port','Invalid_AlphaChar','Invalid_Phone','Invalid_Date','Invalid_File');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_No' => 1,'Invalid_ID' => 2,'Invalid_Rating' => 3,'Invalid_Risk' => 4,'Invalid_Type' => 5,'Invalid_Status' => 6,'Invalid_Port' => 7,'Invalid_AlphaChar' => 8,'Invalid_Phone' => 9,'Invalid_Date' => 10,'Invalid_File' => 11,0);
 
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
 
EXPORT MakeFT_Invalid_Rating(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789\\\\N| '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Rating(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789\\\\N| '))));
EXPORT InValidMessageFT_Invalid_Rating(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789\\\\N| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Risk(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Risk(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['PASS','FAIL','WARN','\\N','']);
EXPORT InValidMessageFT_Invalid_Risk(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('PASS|FAIL|WARN|\\N|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['LANDLINE','POSSIBLE WIRELESS','PAGER','POSSIBLE VOIP','WIRELESS','VOIP','OTHER/UNKNOWN','CABLE','\\N','']);
EXPORT InValidMessageFT_Invalid_Type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('LANDLINE|POSSIBLE WIRELESS|PAGER|POSSIBLE VOIP|WIRELESS|VOIP|OTHER/UNKNOWN|CABLE|\\N|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Status(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Status(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['ACTIVE','NOT AVAILABLE','INACTIVE','\\N','']);
EXPORT InValidMessageFT_Invalid_Status(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('ACTIVE|NOT AVAILABLE|INACTIVE|\\N|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Port(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Port(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['Not Ported','Ported','\\N','']);
EXPORT InValidMessageFT_Invalid_Port(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('Not Ported|Ported|\\N|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaChar(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\\(\\)@*:;#_ .,/-&|\\\\\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaChar(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\\(\\)@*:;#_ .,/-&|\\\\\''))));
EXPORT InValidMessageFT_Invalid_AlphaChar(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\\(\\)@*:;#_ .,/-&|\\\\\''),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Phone(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789\\\\N'); // Only allow valid symbols
  RETURN  MakeFT_Invalid_No(s1);
END;
EXPORT InValidFT_Invalid_Phone(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789\\\\N'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_Invalid_Phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789\\\\N'),SALT311.HygieneErrors.NotLength('0,9,10'),SALT311.HygieneErrors.Good);
 
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
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'transaction_id','sequence_number','phone_id','phonenumber','risk_indicator','phone_type','phone_status','listing_name','porting_code','phone_forwarded','verified_carrier','date_added','identity_count','carrier','phone_star_rating','filename');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'transaction_id','sequence_number','phone_id','phonenumber','risk_indicator','phone_type','phone_status','listing_name','porting_code','phone_forwarded','verified_carrier','date_added','identity_count','carrier','phone_star_rating','filename');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'transaction_id' => 0,'sequence_number' => 1,'phone_id' => 2,'phonenumber' => 3,'risk_indicator' => 4,'phone_type' => 5,'phone_status' => 6,'listing_name' => 7,'porting_code' => 8,'phone_forwarded' => 9,'verified_carrier' => 10,'date_added' => 11,'identity_count' => 12,'carrier' => 13,'phone_star_rating' => 14,'filename' => 15,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ENUM'],['ENUM'],['ENUM'],['ALLOW'],['ENUM'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],[],['ALLOW'],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_transaction_id(SALT311.StrType s0) := MakeFT_Invalid_ID(s0);
EXPORT InValid_transaction_id(SALT311.StrType s) := InValidFT_Invalid_ID(s);
EXPORT InValidMessage_transaction_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_ID(wh);
 
EXPORT Make_sequence_number(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_sequence_number(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_sequence_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_phone_id(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_phone_id(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_phone_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_phonenumber(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_phonenumber(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_phonenumber(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_risk_indicator(SALT311.StrType s0) := MakeFT_Invalid_Risk(s0);
EXPORT InValid_risk_indicator(SALT311.StrType s) := InValidFT_Invalid_Risk(s);
EXPORT InValidMessage_risk_indicator(UNSIGNED1 wh) := InValidMessageFT_Invalid_Risk(wh);
 
EXPORT Make_phone_type(SALT311.StrType s0) := MakeFT_Invalid_Type(s0);
EXPORT InValid_phone_type(SALT311.StrType s) := InValidFT_Invalid_Type(s);
EXPORT InValidMessage_phone_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Type(wh);
 
EXPORT Make_phone_status(SALT311.StrType s0) := MakeFT_Invalid_Status(s0);
EXPORT InValid_phone_status(SALT311.StrType s) := InValidFT_Invalid_Status(s);
EXPORT InValidMessage_phone_status(UNSIGNED1 wh) := InValidMessageFT_Invalid_Status(wh);
 
EXPORT Make_listing_name(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_listing_name(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_listing_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_porting_code(SALT311.StrType s0) := MakeFT_Invalid_Port(s0);
EXPORT InValid_porting_code(SALT311.StrType s) := InValidFT_Invalid_Port(s);
EXPORT InValidMessage_porting_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Port(wh);
 
EXPORT Make_phone_forwarded(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_phone_forwarded(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_phone_forwarded(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_verified_carrier(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_verified_carrier(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_verified_carrier(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_date_added(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_added(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_added(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_identity_count(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_identity_count(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_identity_count(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_carrier(SALT311.StrType s0) := s0;
EXPORT InValid_carrier(SALT311.StrType s) := 0;
EXPORT InValidMessage_carrier(UNSIGNED1 wh) := '';
 
EXPORT Make_phone_star_rating(SALT311.StrType s0) := MakeFT_Invalid_Rating(s0);
EXPORT InValid_phone_star_rating(SALT311.StrType s) := InValidFT_Invalid_Rating(s);
EXPORT InValidMessage_phone_star_rating(UNSIGNED1 wh) := InValidMessageFT_Invalid_Rating(wh);
 
EXPORT Make_filename(SALT311.StrType s0) := s0;
EXPORT InValid_filename(SALT311.StrType s) := 0;
EXPORT InValidMessage_filename(UNSIGNED1 wh) := '';
 
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
    BOOLEAN Diff_phone_id;
    BOOLEAN Diff_phonenumber;
    BOOLEAN Diff_risk_indicator;
    BOOLEAN Diff_phone_type;
    BOOLEAN Diff_phone_status;
    BOOLEAN Diff_listing_name;
    BOOLEAN Diff_porting_code;
    BOOLEAN Diff_phone_forwarded;
    BOOLEAN Diff_verified_carrier;
    BOOLEAN Diff_date_added;
    BOOLEAN Diff_identity_count;
    BOOLEAN Diff_carrier;
    BOOLEAN Diff_phone_star_rating;
    BOOLEAN Diff_filename;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_transaction_id := le.transaction_id <> ri.transaction_id;
    SELF.Diff_sequence_number := le.sequence_number <> ri.sequence_number;
    SELF.Diff_phone_id := le.phone_id <> ri.phone_id;
    SELF.Diff_phonenumber := le.phonenumber <> ri.phonenumber;
    SELF.Diff_risk_indicator := le.risk_indicator <> ri.risk_indicator;
    SELF.Diff_phone_type := le.phone_type <> ri.phone_type;
    SELF.Diff_phone_status := le.phone_status <> ri.phone_status;
    SELF.Diff_listing_name := le.listing_name <> ri.listing_name;
    SELF.Diff_porting_code := le.porting_code <> ri.porting_code;
    SELF.Diff_phone_forwarded := le.phone_forwarded <> ri.phone_forwarded;
    SELF.Diff_verified_carrier := le.verified_carrier <> ri.verified_carrier;
    SELF.Diff_date_added := le.date_added <> ri.date_added;
    SELF.Diff_identity_count := le.identity_count <> ri.identity_count;
    SELF.Diff_carrier := le.carrier <> ri.carrier;
    SELF.Diff_phone_star_rating := le.phone_star_rating <> ri.phone_star_rating;
    SELF.Diff_filename := le.filename <> ri.filename;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_transaction_id,1,0)+ IF( SELF.Diff_sequence_number,1,0)+ IF( SELF.Diff_phone_id,1,0)+ IF( SELF.Diff_phonenumber,1,0)+ IF( SELF.Diff_risk_indicator,1,0)+ IF( SELF.Diff_phone_type,1,0)+ IF( SELF.Diff_phone_status,1,0)+ IF( SELF.Diff_listing_name,1,0)+ IF( SELF.Diff_porting_code,1,0)+ IF( SELF.Diff_phone_forwarded,1,0)+ IF( SELF.Diff_verified_carrier,1,0)+ IF( SELF.Diff_date_added,1,0)+ IF( SELF.Diff_identity_count,1,0)+ IF( SELF.Diff_carrier,1,0)+ IF( SELF.Diff_phone_star_rating,1,0)+ IF( SELF.Diff_filename,1,0);
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
    Count_Diff_phone_id := COUNT(GROUP,%Closest%.Diff_phone_id);
    Count_Diff_phonenumber := COUNT(GROUP,%Closest%.Diff_phonenumber);
    Count_Diff_risk_indicator := COUNT(GROUP,%Closest%.Diff_risk_indicator);
    Count_Diff_phone_type := COUNT(GROUP,%Closest%.Diff_phone_type);
    Count_Diff_phone_status := COUNT(GROUP,%Closest%.Diff_phone_status);
    Count_Diff_listing_name := COUNT(GROUP,%Closest%.Diff_listing_name);
    Count_Diff_porting_code := COUNT(GROUP,%Closest%.Diff_porting_code);
    Count_Diff_phone_forwarded := COUNT(GROUP,%Closest%.Diff_phone_forwarded);
    Count_Diff_verified_carrier := COUNT(GROUP,%Closest%.Diff_verified_carrier);
    Count_Diff_date_added := COUNT(GROUP,%Closest%.Diff_date_added);
    Count_Diff_identity_count := COUNT(GROUP,%Closest%.Diff_identity_count);
    Count_Diff_carrier := COUNT(GROUP,%Closest%.Diff_carrier);
    Count_Diff_phone_star_rating := COUNT(GROUP,%Closest%.Diff_phone_star_rating);
    Count_Diff_filename := COUNT(GROUP,%Closest%.Diff_filename);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
