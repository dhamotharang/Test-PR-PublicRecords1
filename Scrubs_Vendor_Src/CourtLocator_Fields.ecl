IMPORT SALT311;
EXPORT CourtLocator_Fields := MODULE
 
EXPORT NumFields := 22;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'fipscode','statefips','countyfips','courtid','consolidatedcourtid','masterid','stateofservice','countyofservice','courtname','phone','address1','address2','city','state','zipcode','zip4','mailaddress1','mailaddress2','mailcity','mailctate','mailzipcode','mailzip4');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'fipscode' => 1,'statefips' => 2,'countyfips' => 3,'courtid' => 4,'consolidatedcourtid' => 5,'masterid' => 6,'stateofservice' => 7,'countyofservice' => 8,'courtname' => 9,'phone' => 10,'address1' => 11,'address2' => 12,'city' => 13,'state' => 14,'zipcode' => 15,'zip4' => 16,'mailaddress1' => 17,'mailaddress2' => 18,'mailcity' => 19,'mailctate' => 20,'mailzipcode' => 21,'mailzip4' => 22,0);
 
EXPORT MakeFT_fipscode(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_fipscode(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_fipscode(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_statefips(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789LA'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_statefips(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789LA'))));
EXPORT InValidMessageFT_statefips(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789LA'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_countyfips(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_countyfips(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_countyfips(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_courtid(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_courtid(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_courtid(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_consolidatedcourtid(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_consolidatedcourtid(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_consolidatedcourtid(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_masterid(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_masterid(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_masterid(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_stateofservice(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_stateofservice(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_stateofservice(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_countyofservice(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ()\'.-ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_countyofservice(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ()\'.-ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_countyofservice(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' ()\'.-ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_courtname(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ()&#-.,/\\\'0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_courtname(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ()&#-.,/\\\'0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'))));
EXPORT InValidMessageFT_courtname(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' ()&#-.,/\\\'0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_phone(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_phone(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_address1(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ()$\'/#,&-.:;0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_address1(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ()$\'/#,&-.:;0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'))));
EXPORT InValidMessageFT_address1(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' ()$\'/#,&-.:;0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_address2(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ()#&\',-./:;0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_address2(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ()#&\',-./:;0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'))));
EXPORT InValidMessageFT_address2(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' ()#&\',-./:;0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_city(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' /&-\'.,ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_city(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' /&-\'.,ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_city(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' /&-\'.,ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_state(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ACDEFGHIJKLMNOPRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_state(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ACDEFGHIJKLMNOPRSTUVWXYZ'))));
EXPORT InValidMessageFT_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ACDEFGHIJKLMNOPRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_zipcode(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_zipcode(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_zipcode(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_zip4(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'-0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_zip4(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'-0123456789'))));
EXPORT InValidMessageFT_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('-0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_mailaddress1(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ()&\'/#,-.;:0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_mailaddress1(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ()&\'/#,-.;:0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'))));
EXPORT InValidMessageFT_mailaddress1(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' ()&\'/#,-.;:0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_mailaddress2(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' #&\',-./:;0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_mailaddress2(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' #&\',-./:;0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'))));
EXPORT InValidMessageFT_mailaddress2(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' #&\',-./:;0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_mailcity(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' /&-\'.ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_mailcity(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' /&-\'.ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_mailcity(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' /&-\'.ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_mailctate(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_mailctate(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_mailctate(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_mailzipcode(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_mailzipcode(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_mailzipcode(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_mailzip4(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_mailzip4(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_mailzip4(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'fipscode','statefips','countyfips','courtid','consolidatedcourtid','masterid','stateofservice','countyofservice','courtname','phone','address1','address2','city','state','zipcode','zip4','mailaddress1','mailaddress2','mailcity','mailctate','mailzipcode','mailzip4');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'fipscode','statefips','countyfips','courtid','consolidatedcourtid','masterid','stateofservice','countyofservice','courtname','phone','address1','address2','city','state','zipcode','zip4','mailaddress1','mailaddress2','mailcity','mailctate','mailzipcode','mailzip4');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'fipscode' => 0,'statefips' => 1,'countyfips' => 2,'courtid' => 3,'consolidatedcourtid' => 4,'masterid' => 5,'stateofservice' => 6,'countyofservice' => 7,'courtname' => 8,'phone' => 9,'address1' => 10,'address2' => 11,'city' => 12,'state' => 13,'zipcode' => 14,'zip4' => 15,'mailaddress1' => 16,'mailaddress2' => 17,'mailcity' => 18,'mailctate' => 19,'mailzipcode' => 20,'mailzip4' => 21,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_fipscode(SALT311.StrType s0) := MakeFT_fipscode(s0);
EXPORT InValid_fipscode(SALT311.StrType s) := InValidFT_fipscode(s);
EXPORT InValidMessage_fipscode(UNSIGNED1 wh) := InValidMessageFT_fipscode(wh);
 
EXPORT Make_statefips(SALT311.StrType s0) := MakeFT_statefips(s0);
EXPORT InValid_statefips(SALT311.StrType s) := InValidFT_statefips(s);
EXPORT InValidMessage_statefips(UNSIGNED1 wh) := InValidMessageFT_statefips(wh);
 
EXPORT Make_countyfips(SALT311.StrType s0) := MakeFT_countyfips(s0);
EXPORT InValid_countyfips(SALT311.StrType s) := InValidFT_countyfips(s);
EXPORT InValidMessage_countyfips(UNSIGNED1 wh) := InValidMessageFT_countyfips(wh);
 
EXPORT Make_courtid(SALT311.StrType s0) := MakeFT_courtid(s0);
EXPORT InValid_courtid(SALT311.StrType s) := InValidFT_courtid(s);
EXPORT InValidMessage_courtid(UNSIGNED1 wh) := InValidMessageFT_courtid(wh);
 
EXPORT Make_consolidatedcourtid(SALT311.StrType s0) := MakeFT_consolidatedcourtid(s0);
EXPORT InValid_consolidatedcourtid(SALT311.StrType s) := InValidFT_consolidatedcourtid(s);
EXPORT InValidMessage_consolidatedcourtid(UNSIGNED1 wh) := InValidMessageFT_consolidatedcourtid(wh);
 
EXPORT Make_masterid(SALT311.StrType s0) := MakeFT_masterid(s0);
EXPORT InValid_masterid(SALT311.StrType s) := InValidFT_masterid(s);
EXPORT InValidMessage_masterid(UNSIGNED1 wh) := InValidMessageFT_masterid(wh);
 
EXPORT Make_stateofservice(SALT311.StrType s0) := MakeFT_stateofservice(s0);
EXPORT InValid_stateofservice(SALT311.StrType s) := InValidFT_stateofservice(s);
EXPORT InValidMessage_stateofservice(UNSIGNED1 wh) := InValidMessageFT_stateofservice(wh);
 
EXPORT Make_countyofservice(SALT311.StrType s0) := MakeFT_countyofservice(s0);
EXPORT InValid_countyofservice(SALT311.StrType s) := InValidFT_countyofservice(s);
EXPORT InValidMessage_countyofservice(UNSIGNED1 wh) := InValidMessageFT_countyofservice(wh);
 
EXPORT Make_courtname(SALT311.StrType s0) := MakeFT_courtname(s0);
EXPORT InValid_courtname(SALT311.StrType s) := InValidFT_courtname(s);
EXPORT InValidMessage_courtname(UNSIGNED1 wh) := InValidMessageFT_courtname(wh);
 
EXPORT Make_phone(SALT311.StrType s0) := MakeFT_phone(s0);
EXPORT InValid_phone(SALT311.StrType s) := InValidFT_phone(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_phone(wh);
 
EXPORT Make_address1(SALT311.StrType s0) := MakeFT_address1(s0);
EXPORT InValid_address1(SALT311.StrType s) := InValidFT_address1(s);
EXPORT InValidMessage_address1(UNSIGNED1 wh) := InValidMessageFT_address1(wh);
 
EXPORT Make_address2(SALT311.StrType s0) := MakeFT_address2(s0);
EXPORT InValid_address2(SALT311.StrType s) := InValidFT_address2(s);
EXPORT InValidMessage_address2(UNSIGNED1 wh) := InValidMessageFT_address2(wh);
 
EXPORT Make_city(SALT311.StrType s0) := MakeFT_city(s0);
EXPORT InValid_city(SALT311.StrType s) := InValidFT_city(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_city(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_state(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_state(wh);
 
EXPORT Make_zipcode(SALT311.StrType s0) := MakeFT_zipcode(s0);
EXPORT InValid_zipcode(SALT311.StrType s) := InValidFT_zipcode(s);
EXPORT InValidMessage_zipcode(UNSIGNED1 wh) := InValidMessageFT_zipcode(wh);
 
EXPORT Make_zip4(SALT311.StrType s0) := MakeFT_zip4(s0);
EXPORT InValid_zip4(SALT311.StrType s) := InValidFT_zip4(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_zip4(wh);
 
EXPORT Make_mailaddress1(SALT311.StrType s0) := MakeFT_mailaddress1(s0);
EXPORT InValid_mailaddress1(SALT311.StrType s) := InValidFT_mailaddress1(s);
EXPORT InValidMessage_mailaddress1(UNSIGNED1 wh) := InValidMessageFT_mailaddress1(wh);
 
EXPORT Make_mailaddress2(SALT311.StrType s0) := MakeFT_mailaddress2(s0);
EXPORT InValid_mailaddress2(SALT311.StrType s) := InValidFT_mailaddress2(s);
EXPORT InValidMessage_mailaddress2(UNSIGNED1 wh) := InValidMessageFT_mailaddress2(wh);
 
EXPORT Make_mailcity(SALT311.StrType s0) := MakeFT_mailcity(s0);
EXPORT InValid_mailcity(SALT311.StrType s) := InValidFT_mailcity(s);
EXPORT InValidMessage_mailcity(UNSIGNED1 wh) := InValidMessageFT_mailcity(wh);
 
EXPORT Make_mailctate(SALT311.StrType s0) := MakeFT_mailctate(s0);
EXPORT InValid_mailctate(SALT311.StrType s) := InValidFT_mailctate(s);
EXPORT InValidMessage_mailctate(UNSIGNED1 wh) := InValidMessageFT_mailctate(wh);
 
EXPORT Make_mailzipcode(SALT311.StrType s0) := MakeFT_mailzipcode(s0);
EXPORT InValid_mailzipcode(SALT311.StrType s) := InValidFT_mailzipcode(s);
EXPORT InValidMessage_mailzipcode(UNSIGNED1 wh) := InValidMessageFT_mailzipcode(wh);
 
EXPORT Make_mailzip4(SALT311.StrType s0) := MakeFT_mailzip4(s0);
EXPORT InValid_mailzip4(SALT311.StrType s) := InValidFT_mailzip4(s);
EXPORT InValidMessage_mailzip4(UNSIGNED1 wh) := InValidMessageFT_mailzip4(wh);
 
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
    BOOLEAN Diff_fipscode;
    BOOLEAN Diff_statefips;
    BOOLEAN Diff_countyfips;
    BOOLEAN Diff_courtid;
    BOOLEAN Diff_consolidatedcourtid;
    BOOLEAN Diff_masterid;
    BOOLEAN Diff_stateofservice;
    BOOLEAN Diff_countyofservice;
    BOOLEAN Diff_courtname;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_address1;
    BOOLEAN Diff_address2;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zipcode;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_mailaddress1;
    BOOLEAN Diff_mailaddress2;
    BOOLEAN Diff_mailcity;
    BOOLEAN Diff_mailctate;
    BOOLEAN Diff_mailzipcode;
    BOOLEAN Diff_mailzip4;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_fipscode := le.fipscode <> ri.fipscode;
    SELF.Diff_statefips := le.statefips <> ri.statefips;
    SELF.Diff_countyfips := le.countyfips <> ri.countyfips;
    SELF.Diff_courtid := le.courtid <> ri.courtid;
    SELF.Diff_consolidatedcourtid := le.consolidatedcourtid <> ri.consolidatedcourtid;
    SELF.Diff_masterid := le.masterid <> ri.masterid;
    SELF.Diff_stateofservice := le.stateofservice <> ri.stateofservice;
    SELF.Diff_countyofservice := le.countyofservice <> ri.countyofservice;
    SELF.Diff_courtname := le.courtname <> ri.courtname;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_address1 := le.address1 <> ri.address1;
    SELF.Diff_address2 := le.address2 <> ri.address2;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zipcode := le.zipcode <> ri.zipcode;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_mailaddress1 := le.mailaddress1 <> ri.mailaddress1;
    SELF.Diff_mailaddress2 := le.mailaddress2 <> ri.mailaddress2;
    SELF.Diff_mailcity := le.mailcity <> ri.mailcity;
    SELF.Diff_mailctate := le.mailctate <> ri.mailctate;
    SELF.Diff_mailzipcode := le.mailzipcode <> ri.mailzipcode;
    SELF.Diff_mailzip4 := le.mailzip4 <> ri.mailzip4;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_fipscode,1,0)+ IF( SELF.Diff_statefips,1,0)+ IF( SELF.Diff_countyfips,1,0)+ IF( SELF.Diff_courtid,1,0)+ IF( SELF.Diff_consolidatedcourtid,1,0)+ IF( SELF.Diff_masterid,1,0)+ IF( SELF.Diff_stateofservice,1,0)+ IF( SELF.Diff_countyofservice,1,0)+ IF( SELF.Diff_courtname,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_address1,1,0)+ IF( SELF.Diff_address2,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zipcode,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_mailaddress1,1,0)+ IF( SELF.Diff_mailaddress2,1,0)+ IF( SELF.Diff_mailcity,1,0)+ IF( SELF.Diff_mailctate,1,0)+ IF( SELF.Diff_mailzipcode,1,0)+ IF( SELF.Diff_mailzip4,1,0);
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
    Count_Diff_fipscode := COUNT(GROUP,%Closest%.Diff_fipscode);
    Count_Diff_statefips := COUNT(GROUP,%Closest%.Diff_statefips);
    Count_Diff_countyfips := COUNT(GROUP,%Closest%.Diff_countyfips);
    Count_Diff_courtid := COUNT(GROUP,%Closest%.Diff_courtid);
    Count_Diff_consolidatedcourtid := COUNT(GROUP,%Closest%.Diff_consolidatedcourtid);
    Count_Diff_masterid := COUNT(GROUP,%Closest%.Diff_masterid);
    Count_Diff_stateofservice := COUNT(GROUP,%Closest%.Diff_stateofservice);
    Count_Diff_countyofservice := COUNT(GROUP,%Closest%.Diff_countyofservice);
    Count_Diff_courtname := COUNT(GROUP,%Closest%.Diff_courtname);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_address1 := COUNT(GROUP,%Closest%.Diff_address1);
    Count_Diff_address2 := COUNT(GROUP,%Closest%.Diff_address2);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zipcode := COUNT(GROUP,%Closest%.Diff_zipcode);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_mailaddress1 := COUNT(GROUP,%Closest%.Diff_mailaddress1);
    Count_Diff_mailaddress2 := COUNT(GROUP,%Closest%.Diff_mailaddress2);
    Count_Diff_mailcity := COUNT(GROUP,%Closest%.Diff_mailcity);
    Count_Diff_mailctate := COUNT(GROUP,%Closest%.Diff_mailctate);
    Count_Diff_mailzipcode := COUNT(GROUP,%Closest%.Diff_mailzipcode);
    Count_Diff_mailzip4 := COUNT(GROUP,%Closest%.Diff_mailzip4);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
