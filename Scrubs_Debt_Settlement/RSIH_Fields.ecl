IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT RSIH_Fields := MODULE
 
EXPORT NumFields := 14;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_avdanum','Invalid_mandatory_alpha','Invalid_alpha','Invalid_numeric','Invalid_Phone');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_avdanum' => 1,'Invalid_mandatory_alpha' => 2,'Invalid_alpha' => 3,'Invalid_numeric' => 4,'Invalid_Phone' => 5,0);
 
EXPORT MakeFT_Invalid_avdanum(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_avdanum(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1 AND LENGTH(TRIM(s)) <= 5));
EXPORT InValidMessageFT_Invalid_avdanum(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('1..5'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_mandatory_alpha(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_mandatory_alpha(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_ASCII_printable(s)>0,~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Invalid_mandatory_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_ASCII_printable'),SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_alpha(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_alpha(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_ASCII_printable(s)>0);
EXPORT InValidMessageFT_Invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_ASCII_printable'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_numeric(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_numeric(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_Invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Phone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Phone(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_verify_optional_phone(s)>0);
EXPORT InValidMessageFT_Invalid_Phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_verify_optional_phone'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'avdanumber','attorneyname','businessname','address1','address2','phone','email','primary_range_cln','primary_name_cln','sec_range_cln','zip_cln','did_header_addr_count','did_header_phone_count','did_phoneplus_gongphone_count');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'avdanumber','attorneyname','businessname','address1','address2','phone','email','primary_range_cln','primary_name_cln','sec_range_cln','zip_cln','did_header_addr_count','did_header_phone_count','did_phoneplus_gongphone_count');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'avdanumber' => 0,'attorneyname' => 1,'businessname' => 2,'address1' => 3,'address2' => 4,'phone' => 5,'email' => 6,'primary_range_cln' => 7,'primary_name_cln' => 8,'sec_range_cln' => 9,'zip_cln' => 10,'did_header_addr_count' => 11,'did_header_phone_count' => 12,'did_phoneplus_gongphone_count' => 13,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','LENGTHS'],['CUSTOM','LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_avdanumber(SALT311.StrType s0) := MakeFT_Invalid_avdanum(s0);
EXPORT InValid_avdanumber(SALT311.StrType s) := InValidFT_Invalid_avdanum(s);
EXPORT InValidMessage_avdanumber(UNSIGNED1 wh) := InValidMessageFT_Invalid_avdanum(wh);
 
EXPORT Make_attorneyname(SALT311.StrType s0) := MakeFT_Invalid_mandatory_alpha(s0);
EXPORT InValid_attorneyname(SALT311.StrType s) := InValidFT_Invalid_mandatory_alpha(s);
EXPORT InValidMessage_attorneyname(UNSIGNED1 wh) := InValidMessageFT_Invalid_mandatory_alpha(wh);
 
EXPORT Make_businessname(SALT311.StrType s0) := MakeFT_Invalid_alpha(s0);
EXPORT InValid_businessname(SALT311.StrType s) := InValidFT_Invalid_alpha(s);
EXPORT InValidMessage_businessname(UNSIGNED1 wh) := InValidMessageFT_Invalid_alpha(wh);
 
EXPORT Make_address1(SALT311.StrType s0) := MakeFT_Invalid_alpha(s0);
EXPORT InValid_address1(SALT311.StrType s) := InValidFT_Invalid_alpha(s);
EXPORT InValidMessage_address1(UNSIGNED1 wh) := InValidMessageFT_Invalid_alpha(wh);
 
EXPORT Make_address2(SALT311.StrType s0) := MakeFT_Invalid_alpha(s0);
EXPORT InValid_address2(SALT311.StrType s) := InValidFT_Invalid_alpha(s);
EXPORT InValidMessage_address2(UNSIGNED1 wh) := InValidMessageFT_Invalid_alpha(wh);
 
EXPORT Make_phone(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_phone(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_email(SALT311.StrType s0) := MakeFT_Invalid_alpha(s0);
EXPORT InValid_email(SALT311.StrType s) := InValidFT_Invalid_alpha(s);
EXPORT InValidMessage_email(UNSIGNED1 wh) := InValidMessageFT_Invalid_alpha(wh);
 
EXPORT Make_primary_range_cln(SALT311.StrType s0) := MakeFT_Invalid_alpha(s0);
EXPORT InValid_primary_range_cln(SALT311.StrType s) := InValidFT_Invalid_alpha(s);
EXPORT InValidMessage_primary_range_cln(UNSIGNED1 wh) := InValidMessageFT_Invalid_alpha(wh);
 
EXPORT Make_primary_name_cln(SALT311.StrType s0) := MakeFT_Invalid_alpha(s0);
EXPORT InValid_primary_name_cln(SALT311.StrType s) := InValidFT_Invalid_alpha(s);
EXPORT InValidMessage_primary_name_cln(UNSIGNED1 wh) := InValidMessageFT_Invalid_alpha(wh);
 
EXPORT Make_sec_range_cln(SALT311.StrType s0) := MakeFT_Invalid_alpha(s0);
EXPORT InValid_sec_range_cln(SALT311.StrType s) := InValidFT_Invalid_alpha(s);
EXPORT InValidMessage_sec_range_cln(UNSIGNED1 wh) := InValidMessageFT_Invalid_alpha(wh);
 
EXPORT Make_zip_cln(SALT311.StrType s0) := MakeFT_Invalid_numeric(s0);
EXPORT InValid_zip_cln(SALT311.StrType s) := InValidFT_Invalid_numeric(s);
EXPORT InValidMessage_zip_cln(UNSIGNED1 wh) := InValidMessageFT_Invalid_numeric(wh);
 
EXPORT Make_did_header_addr_count(SALT311.StrType s0) := MakeFT_Invalid_numeric(s0);
EXPORT InValid_did_header_addr_count(SALT311.StrType s) := InValidFT_Invalid_numeric(s);
EXPORT InValidMessage_did_header_addr_count(UNSIGNED1 wh) := InValidMessageFT_Invalid_numeric(wh);
 
EXPORT Make_did_header_phone_count(SALT311.StrType s0) := MakeFT_Invalid_numeric(s0);
EXPORT InValid_did_header_phone_count(SALT311.StrType s) := InValidFT_Invalid_numeric(s);
EXPORT InValidMessage_did_header_phone_count(UNSIGNED1 wh) := InValidMessageFT_Invalid_numeric(wh);
 
EXPORT Make_did_phoneplus_gongphone_count(SALT311.StrType s0) := s0;
EXPORT InValid_did_phoneplus_gongphone_count(SALT311.StrType s) := 0;
EXPORT InValidMessage_did_phoneplus_gongphone_count(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Debt_Settlement;
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
    BOOLEAN Diff_avdanumber;
    BOOLEAN Diff_attorneyname;
    BOOLEAN Diff_businessname;
    BOOLEAN Diff_address1;
    BOOLEAN Diff_address2;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_email;
    BOOLEAN Diff_primary_range_cln;
    BOOLEAN Diff_primary_name_cln;
    BOOLEAN Diff_sec_range_cln;
    BOOLEAN Diff_zip_cln;
    BOOLEAN Diff_did_header_addr_count;
    BOOLEAN Diff_did_header_phone_count;
    BOOLEAN Diff_did_phoneplus_gongphone_count;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_avdanumber := le.avdanumber <> ri.avdanumber;
    SELF.Diff_attorneyname := le.attorneyname <> ri.attorneyname;
    SELF.Diff_businessname := le.businessname <> ri.businessname;
    SELF.Diff_address1 := le.address1 <> ri.address1;
    SELF.Diff_address2 := le.address2 <> ri.address2;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_email := le.email <> ri.email;
    SELF.Diff_primary_range_cln := le.primary_range_cln <> ri.primary_range_cln;
    SELF.Diff_primary_name_cln := le.primary_name_cln <> ri.primary_name_cln;
    SELF.Diff_sec_range_cln := le.sec_range_cln <> ri.sec_range_cln;
    SELF.Diff_zip_cln := le.zip_cln <> ri.zip_cln;
    SELF.Diff_did_header_addr_count := le.did_header_addr_count <> ri.did_header_addr_count;
    SELF.Diff_did_header_phone_count := le.did_header_phone_count <> ri.did_header_phone_count;
    SELF.Diff_did_phoneplus_gongphone_count := le.did_phoneplus_gongphone_count <> ri.did_phoneplus_gongphone_count;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_avdanumber,1,0)+ IF( SELF.Diff_attorneyname,1,0)+ IF( SELF.Diff_businessname,1,0)+ IF( SELF.Diff_address1,1,0)+ IF( SELF.Diff_address2,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_email,1,0)+ IF( SELF.Diff_primary_range_cln,1,0)+ IF( SELF.Diff_primary_name_cln,1,0)+ IF( SELF.Diff_sec_range_cln,1,0)+ IF( SELF.Diff_zip_cln,1,0)+ IF( SELF.Diff_did_header_addr_count,1,0)+ IF( SELF.Diff_did_header_phone_count,1,0)+ IF( SELF.Diff_did_phoneplus_gongphone_count,1,0);
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
    Count_Diff_avdanumber := COUNT(GROUP,%Closest%.Diff_avdanumber);
    Count_Diff_attorneyname := COUNT(GROUP,%Closest%.Diff_attorneyname);
    Count_Diff_businessname := COUNT(GROUP,%Closest%.Diff_businessname);
    Count_Diff_address1 := COUNT(GROUP,%Closest%.Diff_address1);
    Count_Diff_address2 := COUNT(GROUP,%Closest%.Diff_address2);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_email := COUNT(GROUP,%Closest%.Diff_email);
    Count_Diff_primary_range_cln := COUNT(GROUP,%Closest%.Diff_primary_range_cln);
    Count_Diff_primary_name_cln := COUNT(GROUP,%Closest%.Diff_primary_name_cln);
    Count_Diff_sec_range_cln := COUNT(GROUP,%Closest%.Diff_sec_range_cln);
    Count_Diff_zip_cln := COUNT(GROUP,%Closest%.Diff_zip_cln);
    Count_Diff_did_header_addr_count := COUNT(GROUP,%Closest%.Diff_did_header_addr_count);
    Count_Diff_did_header_phone_count := COUNT(GROUP,%Closest%.Diff_did_header_phone_count);
    Count_Diff_did_phoneplus_gongphone_count := COUNT(GROUP,%Closest%.Diff_did_phoneplus_gongphone_count);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
