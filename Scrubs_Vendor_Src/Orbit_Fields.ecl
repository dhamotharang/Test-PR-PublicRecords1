IMPORT SALT311;
EXPORT Orbit_Fields := MODULE
 
EXPORT NumFields := 23;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'item_id','item_name','item_description','status_name','item_source_code','source_id','source_name','source_address1','source_address2','source_city','source_state','source_zip','source_phone','source_website','unused_source_sourcecodes','unused_fcra','unused_fcra_comments','market_restrict_flag','unused_market_comments','unused_contact_category_name','unused_contact_name','unused_contact_phone','unused_contact_email');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'item_id' => 1,'item_name' => 2,'item_description' => 3,'status_name' => 4,'item_source_code' => 5,'source_id' => 6,'source_name' => 7,'source_address1' => 8,'source_address2' => 9,'source_city' => 10,'source_state' => 11,'source_zip' => 12,'source_phone' => 13,'source_website' => 14,'unused_source_sourcecodes' => 15,'unused_fcra' => 16,'unused_fcra_comments' => 17,'market_restrict_flag' => 18,'unused_market_comments' => 19,'unused_contact_category_name' => 20,'unused_contact_name' => 21,'unused_contact_phone' => 22,'unused_contact_email' => 23,0);
 
EXPORT MakeFT_item_id(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' 0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_item_id(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' 0123456789'))));
EXPORT InValidMessageFT_item_id(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' 0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_item_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ()%@$&*,.-/#\'+_0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_item_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ()%@$&*,.-/#\'+_0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'))));
EXPORT InValidMessageFT_item_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' ()%@$&*,.-/#\'+_0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_item_description(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ()&\',-./+_:$0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_item_description(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ()&\',-./+_:$0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'))));
EXPORT InValidMessageFT_item_description(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' ()&\',-./+_:$0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_status_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' \'-ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_status_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' \'-ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_status_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' \'-ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_item_source_code(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ()!#$%&*+,-./;<>?@[\\]^{|}~:_=0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_item_source_code(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ()!#$%&*+,-./;<>?@[\\]^{|}~:_=0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_item_source_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' ()!#$%&*+,-./;<>?@[\\]^{|}~:_=0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_source_id(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' 0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_source_id(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' 0123456789'))));
EXPORT InValidMessageFT_source_id(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' 0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_source_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ()&,-./_\'0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_source_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ()&,-./_\'0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'))));
EXPORT InValidMessageFT_source_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' ()&,-./_\'0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_source_address1(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ()\'#&,-./:0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_source_address1(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ()\'#&,-./:0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'))));
EXPORT InValidMessageFT_source_address1(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' ()\'#&,-./:0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_source_address2(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' \'#,-._0123456789:0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_source_address2(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' \'#,-._0123456789:0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'))));
EXPORT InValidMessageFT_source_address2(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' \'#,-._0123456789:0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_source_city(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' .ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_source_city(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' .ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_source_city(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' .ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_source_state(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_source_state(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_source_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_source_zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' -0123456789ai'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_source_zip(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' -0123456789ai'))));
EXPORT InValidMessageFT_source_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' -0123456789ai'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_source_phone(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ()-./#0123456789?aenotwxpN'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_source_phone(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ()-./#0123456789?aenotwxpN'))));
EXPORT InValidMessageFT_source_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' ()-./#0123456789?aenotwxpN'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_source_website(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ~&,-./0123456789:=?@\\_ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_source_website(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ~&,-./0123456789:=?@\\_ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_source_website(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' ~&,-./0123456789:=?@\\_ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_unused_source_sourcecodes(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_unused_source_sourcecodes(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,''))));
EXPORT InValidMessageFT_unused_source_sourcecodes(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(''),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_unused_fcra(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_unused_fcra(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,''))));
EXPORT InValidMessageFT_unused_fcra(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(''),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_unused_fcra_comments(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_unused_fcra_comments(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,''))));
EXPORT InValidMessageFT_unused_fcra_comments(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(''),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_market_restrict_flag(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' NSYeost'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_market_restrict_flag(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' NSYeost'))));
EXPORT InValidMessageFT_market_restrict_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' NSYeost'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_unused_market_comments(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_unused_market_comments(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,''))));
EXPORT InValidMessageFT_unused_market_comments(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(''),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_unused_contact_category_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_unused_contact_category_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,''))));
EXPORT InValidMessageFT_unused_contact_category_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(''),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_unused_contact_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_unused_contact_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,''))));
EXPORT InValidMessageFT_unused_contact_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(''),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_unused_contact_phone(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_unused_contact_phone(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,''))));
EXPORT InValidMessageFT_unused_contact_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(''),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_unused_contact_email(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_unused_contact_email(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,''))));
EXPORT InValidMessageFT_unused_contact_email(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(''),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'item_id','item_name','item_description','status_name','item_source_code','source_id','source_name','source_address1','source_address2','source_city','source_state','source_zip','source_phone','source_website','unused_source_sourcecodes','unused_fcra','unused_fcra_comments','market_restrict_flag','unused_market_comments','unused_contact_category_name','unused_contact_name','unused_contact_phone','unused_contact_email');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'item_id','item_name','item_description','status_name','item_source_code','source_id','source_name','source_address1','source_address2','source_city','source_state','source_zip','source_phone','source_website','unused_source_sourcecodes','unused_fcra','unused_fcra_comments','market_restrict_flag','unused_market_comments','unused_contact_category_name','unused_contact_name','unused_contact_phone','unused_contact_email');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'item_id' => 0,'item_name' => 1,'item_description' => 2,'status_name' => 3,'item_source_code' => 4,'source_id' => 5,'source_name' => 6,'source_address1' => 7,'source_address2' => 8,'source_city' => 9,'source_state' => 10,'source_zip' => 11,'source_phone' => 12,'source_website' => 13,'unused_source_sourcecodes' => 14,'unused_fcra' => 15,'unused_fcra_comments' => 16,'market_restrict_flag' => 17,'unused_market_comments' => 18,'unused_contact_category_name' => 19,'unused_contact_name' => 20,'unused_contact_phone' => 21,'unused_contact_email' => 22,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_item_id(SALT311.StrType s0) := MakeFT_item_id(s0);
EXPORT InValid_item_id(SALT311.StrType s) := InValidFT_item_id(s);
EXPORT InValidMessage_item_id(UNSIGNED1 wh) := InValidMessageFT_item_id(wh);
 
EXPORT Make_item_name(SALT311.StrType s0) := MakeFT_item_name(s0);
EXPORT InValid_item_name(SALT311.StrType s) := InValidFT_item_name(s);
EXPORT InValidMessage_item_name(UNSIGNED1 wh) := InValidMessageFT_item_name(wh);
 
EXPORT Make_item_description(SALT311.StrType s0) := MakeFT_item_description(s0);
EXPORT InValid_item_description(SALT311.StrType s) := InValidFT_item_description(s);
EXPORT InValidMessage_item_description(UNSIGNED1 wh) := InValidMessageFT_item_description(wh);
 
EXPORT Make_status_name(SALT311.StrType s0) := MakeFT_status_name(s0);
EXPORT InValid_status_name(SALT311.StrType s) := InValidFT_status_name(s);
EXPORT InValidMessage_status_name(UNSIGNED1 wh) := InValidMessageFT_status_name(wh);
 
EXPORT Make_item_source_code(SALT311.StrType s0) := MakeFT_item_source_code(s0);
EXPORT InValid_item_source_code(SALT311.StrType s) := InValidFT_item_source_code(s);
EXPORT InValidMessage_item_source_code(UNSIGNED1 wh) := InValidMessageFT_item_source_code(wh);
 
EXPORT Make_source_id(SALT311.StrType s0) := MakeFT_source_id(s0);
EXPORT InValid_source_id(SALT311.StrType s) := InValidFT_source_id(s);
EXPORT InValidMessage_source_id(UNSIGNED1 wh) := InValidMessageFT_source_id(wh);
 
EXPORT Make_source_name(SALT311.StrType s0) := MakeFT_source_name(s0);
EXPORT InValid_source_name(SALT311.StrType s) := InValidFT_source_name(s);
EXPORT InValidMessage_source_name(UNSIGNED1 wh) := InValidMessageFT_source_name(wh);
 
EXPORT Make_source_address1(SALT311.StrType s0) := MakeFT_source_address1(s0);
EXPORT InValid_source_address1(SALT311.StrType s) := InValidFT_source_address1(s);
EXPORT InValidMessage_source_address1(UNSIGNED1 wh) := InValidMessageFT_source_address1(wh);
 
EXPORT Make_source_address2(SALT311.StrType s0) := MakeFT_source_address2(s0);
EXPORT InValid_source_address2(SALT311.StrType s) := InValidFT_source_address2(s);
EXPORT InValidMessage_source_address2(UNSIGNED1 wh) := InValidMessageFT_source_address2(wh);
 
EXPORT Make_source_city(SALT311.StrType s0) := MakeFT_source_city(s0);
EXPORT InValid_source_city(SALT311.StrType s) := InValidFT_source_city(s);
EXPORT InValidMessage_source_city(UNSIGNED1 wh) := InValidMessageFT_source_city(wh);
 
EXPORT Make_source_state(SALT311.StrType s0) := MakeFT_source_state(s0);
EXPORT InValid_source_state(SALT311.StrType s) := InValidFT_source_state(s);
EXPORT InValidMessage_source_state(UNSIGNED1 wh) := InValidMessageFT_source_state(wh);
 
EXPORT Make_source_zip(SALT311.StrType s0) := MakeFT_source_zip(s0);
EXPORT InValid_source_zip(SALT311.StrType s) := InValidFT_source_zip(s);
EXPORT InValidMessage_source_zip(UNSIGNED1 wh) := InValidMessageFT_source_zip(wh);
 
EXPORT Make_source_phone(SALT311.StrType s0) := MakeFT_source_phone(s0);
EXPORT InValid_source_phone(SALT311.StrType s) := InValidFT_source_phone(s);
EXPORT InValidMessage_source_phone(UNSIGNED1 wh) := InValidMessageFT_source_phone(wh);
 
EXPORT Make_source_website(SALT311.StrType s0) := MakeFT_source_website(s0);
EXPORT InValid_source_website(SALT311.StrType s) := InValidFT_source_website(s);
EXPORT InValidMessage_source_website(UNSIGNED1 wh) := InValidMessageFT_source_website(wh);
 
EXPORT Make_unused_source_sourcecodes(SALT311.StrType s0) := MakeFT_unused_source_sourcecodes(s0);
EXPORT InValid_unused_source_sourcecodes(SALT311.StrType s) := InValidFT_unused_source_sourcecodes(s);
EXPORT InValidMessage_unused_source_sourcecodes(UNSIGNED1 wh) := InValidMessageFT_unused_source_sourcecodes(wh);
 
EXPORT Make_unused_fcra(SALT311.StrType s0) := MakeFT_unused_fcra(s0);
EXPORT InValid_unused_fcra(SALT311.StrType s) := InValidFT_unused_fcra(s);
EXPORT InValidMessage_unused_fcra(UNSIGNED1 wh) := InValidMessageFT_unused_fcra(wh);
 
EXPORT Make_unused_fcra_comments(SALT311.StrType s0) := MakeFT_unused_fcra_comments(s0);
EXPORT InValid_unused_fcra_comments(SALT311.StrType s) := InValidFT_unused_fcra_comments(s);
EXPORT InValidMessage_unused_fcra_comments(UNSIGNED1 wh) := InValidMessageFT_unused_fcra_comments(wh);
 
EXPORT Make_market_restrict_flag(SALT311.StrType s0) := MakeFT_market_restrict_flag(s0);
EXPORT InValid_market_restrict_flag(SALT311.StrType s) := InValidFT_market_restrict_flag(s);
EXPORT InValidMessage_market_restrict_flag(UNSIGNED1 wh) := InValidMessageFT_market_restrict_flag(wh);
 
EXPORT Make_unused_market_comments(SALT311.StrType s0) := MakeFT_unused_market_comments(s0);
EXPORT InValid_unused_market_comments(SALT311.StrType s) := InValidFT_unused_market_comments(s);
EXPORT InValidMessage_unused_market_comments(UNSIGNED1 wh) := InValidMessageFT_unused_market_comments(wh);
 
EXPORT Make_unused_contact_category_name(SALT311.StrType s0) := s0;
EXPORT InValid_unused_contact_category_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_unused_contact_category_name(UNSIGNED1 wh) := '';
 
EXPORT Make_unused_contact_name(SALT311.StrType s0) := MakeFT_unused_contact_category_name(s0);
EXPORT InValid_unused_contact_name(SALT311.StrType s) := InValidFT_unused_contact_category_name(s);
EXPORT InValidMessage_unused_contact_name(UNSIGNED1 wh) := InValidMessageFT_unused_contact_category_name(wh);
 
EXPORT Make_unused_contact_phone(SALT311.StrType s0) := MakeFT_unused_contact_phone(s0);
EXPORT InValid_unused_contact_phone(SALT311.StrType s) := InValidFT_unused_contact_phone(s);
EXPORT InValidMessage_unused_contact_phone(UNSIGNED1 wh) := InValidMessageFT_unused_contact_phone(wh);
 
EXPORT Make_unused_contact_email(SALT311.StrType s0) := MakeFT_unused_contact_email(s0);
EXPORT InValid_unused_contact_email(SALT311.StrType s) := InValidFT_unused_contact_email(s);
EXPORT InValidMessage_unused_contact_email(UNSIGNED1 wh) := InValidMessageFT_unused_contact_email(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Vendor_Src;
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
    BOOLEAN Diff_item_id;
    BOOLEAN Diff_item_name;
    BOOLEAN Diff_item_description;
    BOOLEAN Diff_status_name;
    BOOLEAN Diff_item_source_code;
    BOOLEAN Diff_source_id;
    BOOLEAN Diff_source_name;
    BOOLEAN Diff_source_address1;
    BOOLEAN Diff_source_address2;
    BOOLEAN Diff_source_city;
    BOOLEAN Diff_source_state;
    BOOLEAN Diff_source_zip;
    BOOLEAN Diff_source_phone;
    BOOLEAN Diff_source_website;
    BOOLEAN Diff_unused_source_sourcecodes;
    BOOLEAN Diff_unused_fcra;
    BOOLEAN Diff_unused_fcra_comments;
    BOOLEAN Diff_market_restrict_flag;
    BOOLEAN Diff_unused_market_comments;
    BOOLEAN Diff_unused_contact_category_name;
    BOOLEAN Diff_unused_contact_name;
    BOOLEAN Diff_unused_contact_phone;
    BOOLEAN Diff_unused_contact_email;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_item_id := le.item_id <> ri.item_id;
    SELF.Diff_item_name := le.item_name <> ri.item_name;
    SELF.Diff_item_description := le.item_description <> ri.item_description;
    SELF.Diff_status_name := le.status_name <> ri.status_name;
    SELF.Diff_item_source_code := le.item_source_code <> ri.item_source_code;
    SELF.Diff_source_id := le.source_id <> ri.source_id;
    SELF.Diff_source_name := le.source_name <> ri.source_name;
    SELF.Diff_source_address1 := le.source_address1 <> ri.source_address1;
    SELF.Diff_source_address2 := le.source_address2 <> ri.source_address2;
    SELF.Diff_source_city := le.source_city <> ri.source_city;
    SELF.Diff_source_state := le.source_state <> ri.source_state;
    SELF.Diff_source_zip := le.source_zip <> ri.source_zip;
    SELF.Diff_source_phone := le.source_phone <> ri.source_phone;
    SELF.Diff_source_website := le.source_website <> ri.source_website;
    SELF.Diff_unused_source_sourcecodes := le.unused_source_sourcecodes <> ri.unused_source_sourcecodes;
    SELF.Diff_unused_fcra := le.unused_fcra <> ri.unused_fcra;
    SELF.Diff_unused_fcra_comments := le.unused_fcra_comments <> ri.unused_fcra_comments;
    SELF.Diff_market_restrict_flag := le.market_restrict_flag <> ri.market_restrict_flag;
    SELF.Diff_unused_market_comments := le.unused_market_comments <> ri.unused_market_comments;
    SELF.Diff_unused_contact_category_name := le.unused_contact_category_name <> ri.unused_contact_category_name;
    SELF.Diff_unused_contact_name := le.unused_contact_name <> ri.unused_contact_name;
    SELF.Diff_unused_contact_phone := le.unused_contact_phone <> ri.unused_contact_phone;
    SELF.Diff_unused_contact_email := le.unused_contact_email <> ri.unused_contact_email;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_item_id,1,0)+ IF( SELF.Diff_item_name,1,0)+ IF( SELF.Diff_item_description,1,0)+ IF( SELF.Diff_status_name,1,0)+ IF( SELF.Diff_item_source_code,1,0)+ IF( SELF.Diff_source_id,1,0)+ IF( SELF.Diff_source_name,1,0)+ IF( SELF.Diff_source_address1,1,0)+ IF( SELF.Diff_source_address2,1,0)+ IF( SELF.Diff_source_city,1,0)+ IF( SELF.Diff_source_state,1,0)+ IF( SELF.Diff_source_zip,1,0)+ IF( SELF.Diff_source_phone,1,0)+ IF( SELF.Diff_source_website,1,0)+ IF( SELF.Diff_unused_source_sourcecodes,1,0)+ IF( SELF.Diff_unused_fcra,1,0)+ IF( SELF.Diff_unused_fcra_comments,1,0)+ IF( SELF.Diff_market_restrict_flag,1,0)+ IF( SELF.Diff_unused_market_comments,1,0)+ IF( SELF.Diff_unused_contact_category_name,1,0)+ IF( SELF.Diff_unused_contact_name,1,0)+ IF( SELF.Diff_unused_contact_phone,1,0)+ IF( SELF.Diff_unused_contact_email,1,0);
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
    Count_Diff_item_id := COUNT(GROUP,%Closest%.Diff_item_id);
    Count_Diff_item_name := COUNT(GROUP,%Closest%.Diff_item_name);
    Count_Diff_item_description := COUNT(GROUP,%Closest%.Diff_item_description);
    Count_Diff_status_name := COUNT(GROUP,%Closest%.Diff_status_name);
    Count_Diff_item_source_code := COUNT(GROUP,%Closest%.Diff_item_source_code);
    Count_Diff_source_id := COUNT(GROUP,%Closest%.Diff_source_id);
    Count_Diff_source_name := COUNT(GROUP,%Closest%.Diff_source_name);
    Count_Diff_source_address1 := COUNT(GROUP,%Closest%.Diff_source_address1);
    Count_Diff_source_address2 := COUNT(GROUP,%Closest%.Diff_source_address2);
    Count_Diff_source_city := COUNT(GROUP,%Closest%.Diff_source_city);
    Count_Diff_source_state := COUNT(GROUP,%Closest%.Diff_source_state);
    Count_Diff_source_zip := COUNT(GROUP,%Closest%.Diff_source_zip);
    Count_Diff_source_phone := COUNT(GROUP,%Closest%.Diff_source_phone);
    Count_Diff_source_website := COUNT(GROUP,%Closest%.Diff_source_website);
    Count_Diff_unused_source_sourcecodes := COUNT(GROUP,%Closest%.Diff_unused_source_sourcecodes);
    Count_Diff_unused_fcra := COUNT(GROUP,%Closest%.Diff_unused_fcra);
    Count_Diff_unused_fcra_comments := COUNT(GROUP,%Closest%.Diff_unused_fcra_comments);
    Count_Diff_market_restrict_flag := COUNT(GROUP,%Closest%.Diff_market_restrict_flag);
    Count_Diff_unused_market_comments := COUNT(GROUP,%Closest%.Diff_unused_market_comments);
    Count_Diff_unused_contact_category_name := COUNT(GROUP,%Closest%.Diff_unused_contact_category_name);
    Count_Diff_unused_contact_name := COUNT(GROUP,%Closest%.Diff_unused_contact_name);
    Count_Diff_unused_contact_phone := COUNT(GROUP,%Closest%.Diff_unused_contact_phone);
    Count_Diff_unused_contact_email := COUNT(GROUP,%Closest%.Diff_unused_contact_email);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
