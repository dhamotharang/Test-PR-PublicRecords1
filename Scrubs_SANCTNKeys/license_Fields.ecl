IMPORT SALT38;
IMPORT Scrubs,Scrubs_SANCTNKeys; // Import modules for FieldTypes attribute definitions
EXPORT license_Fields := MODULE
 
EXPORT NumFields := 10;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Batch','Invalid_Num','Invalid_LicenseNumber','Invalid_ClnLicenseNumber','Invalid_State','Invalid_LicenseType');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'Invalid_Batch' => 1,'Invalid_Num' => 2,'Invalid_LicenseNumber' => 3,'Invalid_ClnLicenseNumber' => 4,'Invalid_State' => 5,'Invalid_LicenseType' => 6,0);
 
EXPORT MakeFT_Invalid_Batch(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Batch(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Invalid_Batch(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_'),SALT38.HygieneErrors.NotLength('1..'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Num(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_LicenseNumber(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz .-#'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_LicenseNumber(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz .-#'))));
EXPORT InValidMessageFT_Invalid_LicenseNumber(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz .-#'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_ClnLicenseNumber(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_ClnLicenseNumber(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_Invalid_ClnLicenseNumber(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_State(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_State(SALT38.StrType s) := WHICH(~Scrubs.fn_Valid_StateAbbrev(s)>0);
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs.fn_Valid_StateAbbrev'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_LicenseType(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_LicenseType(SALT38.StrType s) := WHICH(~Scrubs_SANCTNKeys.fn_CodeCheck_Licence(s)>0);
EXPORT InValidMessageFT_Invalid_LicenseType(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_SANCTNKeys.fn_CodeCheck_Licence'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'batch_number','incident_number','party_number','record_type','order_number','license_number','license_type','license_state','cln_license_number','std_type_desc');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'batch_number','incident_number','party_number','record_type','order_number','license_number','license_type','license_state','cln_license_number','std_type_desc');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'batch_number' => 0,'incident_number' => 1,'party_number' => 2,'record_type' => 3,'order_number' => 4,'license_number' => 5,'license_type' => 6,'license_state' => 7,'cln_license_number' => 8,'std_type_desc' => 9,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','LENGTH'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_batch_number(SALT38.StrType s0) := MakeFT_Invalid_Batch(s0);
EXPORT InValid_batch_number(SALT38.StrType s) := InValidFT_Invalid_Batch(s);
EXPORT InValidMessage_batch_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Batch(wh);
 
EXPORT Make_incident_number(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_incident_number(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_incident_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_party_number(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_party_number(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_party_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_record_type(SALT38.StrType s0) := s0;
EXPORT InValid_record_type(SALT38.StrType s) := 0;
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := '';
 
EXPORT Make_order_number(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_order_number(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_order_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_license_number(SALT38.StrType s0) := MakeFT_Invalid_LicenseNumber(s0);
EXPORT InValid_license_number(SALT38.StrType s) := InValidFT_Invalid_LicenseNumber(s);
EXPORT InValidMessage_license_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_LicenseNumber(wh);
 
EXPORT Make_license_type(SALT38.StrType s0) := MakeFT_Invalid_LicenseType(s0);
EXPORT InValid_license_type(SALT38.StrType s) := InValidFT_Invalid_LicenseType(s);
EXPORT InValidMessage_license_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_LicenseType(wh);
 
EXPORT Make_license_state(SALT38.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_license_state(SALT38.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_license_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_cln_license_number(SALT38.StrType s0) := MakeFT_Invalid_ClnLicenseNumber(s0);
EXPORT InValid_cln_license_number(SALT38.StrType s) := InValidFT_Invalid_ClnLicenseNumber(s);
EXPORT InValidMessage_cln_license_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_ClnLicenseNumber(wh);
 
EXPORT Make_std_type_desc(SALT38.StrType s0) := s0;
EXPORT InValid_std_type_desc(SALT38.StrType s) := 0;
EXPORT InValidMessage_std_type_desc(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_SANCTNKeys;
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
    BOOLEAN Diff_batch_number;
    BOOLEAN Diff_incident_number;
    BOOLEAN Diff_party_number;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_order_number;
    BOOLEAN Diff_license_number;
    BOOLEAN Diff_license_type;
    BOOLEAN Diff_license_state;
    BOOLEAN Diff_cln_license_number;
    BOOLEAN Diff_std_type_desc;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_batch_number := le.batch_number <> ri.batch_number;
    SELF.Diff_incident_number := le.incident_number <> ri.incident_number;
    SELF.Diff_party_number := le.party_number <> ri.party_number;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_order_number := le.order_number <> ri.order_number;
    SELF.Diff_license_number := le.license_number <> ri.license_number;
    SELF.Diff_license_type := le.license_type <> ri.license_type;
    SELF.Diff_license_state := le.license_state <> ri.license_state;
    SELF.Diff_cln_license_number := le.cln_license_number <> ri.cln_license_number;
    SELF.Diff_std_type_desc := le.std_type_desc <> ri.std_type_desc;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_batch_number,1,0)+ IF( SELF.Diff_incident_number,1,0)+ IF( SELF.Diff_party_number,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_order_number,1,0)+ IF( SELF.Diff_license_number,1,0)+ IF( SELF.Diff_license_type,1,0)+ IF( SELF.Diff_license_state,1,0)+ IF( SELF.Diff_cln_license_number,1,0)+ IF( SELF.Diff_std_type_desc,1,0);
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
    Count_Diff_batch_number := COUNT(GROUP,%Closest%.Diff_batch_number);
    Count_Diff_incident_number := COUNT(GROUP,%Closest%.Diff_incident_number);
    Count_Diff_party_number := COUNT(GROUP,%Closest%.Diff_party_number);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_order_number := COUNT(GROUP,%Closest%.Diff_order_number);
    Count_Diff_license_number := COUNT(GROUP,%Closest%.Diff_license_number);
    Count_Diff_license_type := COUNT(GROUP,%Closest%.Diff_license_type);
    Count_Diff_license_state := COUNT(GROUP,%Closest%.Diff_license_state);
    Count_Diff_cln_license_number := COUNT(GROUP,%Closest%.Diff_cln_license_number);
    Count_Diff_std_type_desc := COUNT(GROUP,%Closest%.Diff_std_type_desc);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
