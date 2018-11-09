IMPORT SALT39;
EXPORT LIDBReceived_Fields := MODULE
 
EXPORT NumFields := 9;
 
// Processing for each FieldType
EXPORT SALT39.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Num','Invalid_Char','Invalid_AccOwn','Invalid_RefID');
EXPORT FieldTypeNum(SALT39.StrType fn) := CASE(fn,'Invalid_Num' => 1,'Invalid_Char' => 2,'Invalid_AccOwn' => 3,'Invalid_RefID' => 4,0);
 
EXPORT MakeFT_Invalid_Num(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Char(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 ()&-.,/-#@\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Char(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 ()&-.,/-#@\''))));
EXPORT InValidMessageFT_Invalid_Char(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 ()&-.,/-#@\''),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AccOwn(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABHGCDFE0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AccOwn(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABHGCDFE0123456789 '))));
EXPORT InValidMessageFT_Invalid_AccOwn(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABHGCDFE0123456789 '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_RefID(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'MGP0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_RefID(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'MGP0123456789 '))));
EXPORT InValidMessageFT_Invalid_RefID(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('MGP0123456789 '),SALT39.HygieneErrors.Good);
 
EXPORT SALT39.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'reference_id','phone','reply_code','local_routing_number','account_owner','carrier_name','carrier_category','local_area_transport_area','point_code');
EXPORT SALT39.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'reference_id','phone','reply_code','local_routing_number','account_owner','carrier_name','carrier_category','local_area_transport_area','point_code');
EXPORT FieldNum(SALT39.StrType fn) := CASE(fn,'reference_id' => 0,'phone' => 1,'reply_code' => 2,'local_routing_number' => 3,'account_owner' => 4,'carrier_name' => 5,'carrier_category' => 6,'local_area_transport_area' => 7,'point_code' => 8,0);
EXPORT SET OF SALT39.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_reference_id(SALT39.StrType s0) := MakeFT_Invalid_RefID(s0);
EXPORT InValid_reference_id(SALT39.StrType s) := InValidFT_Invalid_RefID(s);
EXPORT InValidMessage_reference_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_RefID(wh);
 
EXPORT Make_phone(SALT39.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phone(SALT39.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_reply_code(SALT39.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_reply_code(SALT39.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_reply_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_local_routing_number(SALT39.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_local_routing_number(SALT39.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_local_routing_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_account_owner(SALT39.StrType s0) := MakeFT_Invalid_AccOwn(s0);
EXPORT InValid_account_owner(SALT39.StrType s) := InValidFT_Invalid_AccOwn(s);
EXPORT InValidMessage_account_owner(UNSIGNED1 wh) := InValidMessageFT_Invalid_AccOwn(wh);
 
EXPORT Make_carrier_name(SALT39.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_carrier_name(SALT39.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_carrier_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_carrier_category(SALT39.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_carrier_category(SALT39.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_carrier_category(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_local_area_transport_area(SALT39.StrType s0) := s0;
EXPORT InValid_local_area_transport_area(SALT39.StrType s) := 0;
EXPORT InValidMessage_local_area_transport_area(UNSIGNED1 wh) := '';
 
EXPORT Make_point_code(SALT39.StrType s0) := s0;
EXPORT InValid_point_code(SALT39.StrType s) := 0;
EXPORT InValidMessage_point_code(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT39,Scrubs_PhonesInfo;
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
    BOOLEAN Diff_reference_id;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_reply_code;
    BOOLEAN Diff_local_routing_number;
    BOOLEAN Diff_account_owner;
    BOOLEAN Diff_carrier_name;
    BOOLEAN Diff_carrier_category;
    BOOLEAN Diff_local_area_transport_area;
    BOOLEAN Diff_point_code;
    UNSIGNED Num_Diffs;
    SALT39.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_reference_id := le.reference_id <> ri.reference_id;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_reply_code := le.reply_code <> ri.reply_code;
    SELF.Diff_local_routing_number := le.local_routing_number <> ri.local_routing_number;
    SELF.Diff_account_owner := le.account_owner <> ri.account_owner;
    SELF.Diff_carrier_name := le.carrier_name <> ri.carrier_name;
    SELF.Diff_carrier_category := le.carrier_category <> ri.carrier_category;
    SELF.Diff_local_area_transport_area := le.local_area_transport_area <> ri.local_area_transport_area;
    SELF.Diff_point_code := le.point_code <> ri.point_code;
    SELF.Val := (SALT39.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_reference_id,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_reply_code,1,0)+ IF( SELF.Diff_local_routing_number,1,0)+ IF( SELF.Diff_account_owner,1,0)+ IF( SELF.Diff_carrier_name,1,0)+ IF( SELF.Diff_carrier_category,1,0)+ IF( SELF.Diff_local_area_transport_area,1,0)+ IF( SELF.Diff_point_code,1,0);
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
    Count_Diff_reference_id := COUNT(GROUP,%Closest%.Diff_reference_id);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_reply_code := COUNT(GROUP,%Closest%.Diff_reply_code);
    Count_Diff_local_routing_number := COUNT(GROUP,%Closest%.Diff_local_routing_number);
    Count_Diff_account_owner := COUNT(GROUP,%Closest%.Diff_account_owner);
    Count_Diff_carrier_name := COUNT(GROUP,%Closest%.Diff_carrier_name);
    Count_Diff_carrier_category := COUNT(GROUP,%Closest%.Diff_carrier_category);
    Count_Diff_local_area_transport_area := COUNT(GROUP,%Closest%.Diff_local_area_transport_area);
    Count_Diff_point_code := COUNT(GROUP,%Closest%.Diff_point_code);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
