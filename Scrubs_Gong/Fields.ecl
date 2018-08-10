IMPORT ut,SALT33;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE


// Processing for each FieldType
EXPORT SALT33.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'alpha','name','fname','bizname','cityname','phone','zip','zip4','date','date_alt','Invalid_Date','RecordTypes','PublishCodes','ActionCodes','YesNo','StateAbrv','Numeric','Directional','primname');
EXPORT FieldTypeNum(SALT33.StrType fn) := CASE(fn,'alpha' => 1,'name' => 2,'fname' => 3,'bizname' => 4,'cityname' => 5,'phone' => 6,'zip' => 7,'zip4' => 8,'date' => 9,'date_alt' => 10,'Invalid_Date' => 11,'RecordTypes' => 12,'PublishCodes' => 13,'ActionCodes' => 14,'YesNo' => 15,'StateAbrv' => 16,'Numeric' => 17,'Directional' => 18,'primname' => 19,0);

EXPORT MakeFT_alpha(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./#()'); // Only allow valid symbols
  s2 := SALT33.stringcleanspaces( SALT33.stringsubstituteout(s1,' <>{}[]-^=!+&,./#()',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_alpha(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./#()'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./#()'),SALT33.HygieneErrors.NotLength('0,1..'),SALT33.HygieneErrors.Good);

EXPORT MakeFT_name(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz./ \'-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_name(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz./ \'-'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_name(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz./ \'-'),SALT33.HygieneErrors.NotLength('0,1..'),SALT33.HygieneErrors.Good);

EXPORT MakeFT_fname(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz./& \'-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_fname(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz./& \'-'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_fname(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz./& \'-'),SALT33.HygieneErrors.NotLength('0,1..'),SALT33.HygieneErrors.Good);

EXPORT MakeFT_bizname(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789./@"_&,#():!*+?;$ \\\'-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_bizname(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789./@"_&,#():!*+?;$ \\\'-'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_bizname(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789./@"_&,#():!*+?;$ \\\'-'),SALT33.HygieneErrors.NotLength('0,1..'),SALT33.HygieneErrors.Good);

EXPORT MakeFT_cityname(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz29 \'-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_cityname(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz29 \'-'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_cityname(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz29 \'-'),SALT33.HygieneErrors.NotLength('0,1..'),SALT33.HygieneErrors.Good);

EXPORT MakeFT_phone(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_phone(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.NotLength('0,10'),SALT33.HygieneErrors.Good);

EXPORT MakeFT_zip(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_zip(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.NotLength('0,5'),SALT33.HygieneErrors.Good);

EXPORT MakeFT_zip4(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_zip4(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.NotLength('0,4'),SALT33.HygieneErrors.Good);

EXPORT MakeFT_date(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_date(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_date(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789 '),SALT33.HygieneErrors.NotLength('0,8'),SALT33.HygieneErrors.Good);

EXPORT MakeFT_date_alt(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT33.stringcleanspaces( SALT33.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_date_alt(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_date_alt(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789 '),SALT33.HygieneErrors.NotLength('0,1,6,8'),SALT33.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Date(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT33.StrType s) := WHICH(~Scrubs.fn_valid_date(s,'F')>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT33.HygieneErrors.Good);

EXPORT MakeFT_RecordTypes(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'BGPRLCSF'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_RecordTypes(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'BGPRLCSF'))));
EXPORT InValidMessageFT_RecordTypes(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('BGPRLCSF'),SALT33.HygieneErrors.Good);

EXPORT MakeFT_PublishCodes(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'LUP'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_PublishCodes(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'LUP'))));
EXPORT InValidMessageFT_PublishCodes(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('LUP'),SALT33.HygieneErrors.Good);

EXPORT MakeFT_ActionCodes(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ADI'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_ActionCodes(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ADI'))));
EXPORT InValidMessageFT_ActionCodes(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ADI'),SALT33.HygieneErrors.Good);

EXPORT MakeFT_YesNo(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'YN '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_YesNo(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'YN '))));
EXPORT InValidMessageFT_YesNo(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('YN '),SALT33.HygieneErrors.Good);

EXPORT MakeFT_StateAbrv(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_StateAbrv(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_StateAbrv(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT33.HygieneErrors.NotLength('0,2'),SALT33.HygieneErrors.Good);

EXPORT MakeFT_Numeric(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Numeric(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);

EXPORT MakeFT_Directional(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Directional(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['N','S','E','W','NW','Nw','SW','Sw','NE','Ne','SE','Se',' ']);
EXPORT InValidMessageFT_Directional(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('N|S|E|W|NW|Nw|SW|Sw|NE|Ne|SE|Se| '),SALT33.HygieneErrors.Good);

EXPORT MakeFT_primname(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 \'/.#&?;-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_primname(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 \'/.#&?;-'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_primname(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 \'/.#&?;-'),SALT33.HygieneErrors.NotLength('0,1..'),SALT33.HygieneErrors.Good);


EXPORT SALT33.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'ACTION_CODE','RECORD_ID','RECORD_TYPE','TELEPHONE','LISTING_TYPE','BUSINESS_NAME','BUSINESS_CAPTIONS','CATEGORY','INDENT','LAST_NAME','SUFFIX_NAME','FIRST_NAME','MIDDLE_NAME','PRIMARY_STREET_NUMBER','PRE_DIR','PRIMARY_STREET_NAME','PRIMARY_STREET_SUFFIX','POST_DIR','SECONDARY_ADDRESS_TYPE','SECONDARY_RANGE','CITY','STATE','ZIP_CODE','ZIP_PLUS4','LATITUDE','LONGITUDE','LAT_LONG_MATCH_LEVEL','UNLICENSED','ADD_DATE','OMIT_ADDRESS','DATA_SOURCE','unknownField','TransactionID','Original_Suffix','Original_First_Name','Original_Middle_Name','Original_Last_Name','Original_Address','Original_Last_Line','filename');
EXPORT FieldNum(SALT33.StrType fn) := CASE(fn,'ACTION_CODE' => 0,'RECORD_ID' => 1,'RECORD_TYPE' => 2,'TELEPHONE' => 3,'LISTING_TYPE' => 4,'BUSINESS_NAME' => 5,'BUSINESS_CAPTIONS' => 6,'CATEGORY' => 7,'INDENT' => 8,'LAST_NAME' => 9,'SUFFIX_NAME' => 10,'FIRST_NAME' => 11,'MIDDLE_NAME' => 12,'PRIMARY_STREET_NUMBER' => 13,'PRE_DIR' => 14,'PRIMARY_STREET_NAME' => 15,'PRIMARY_STREET_SUFFIX' => 16,'POST_DIR' => 17,'SECONDARY_ADDRESS_TYPE' => 18,'SECONDARY_RANGE' => 19,'CITY' => 20,'STATE' => 21,'ZIP_CODE' => 22,'ZIP_PLUS4' => 23,'LATITUDE' => 24,'LONGITUDE' => 25,'LAT_LONG_MATCH_LEVEL' => 26,'UNLICENSED' => 27,'ADD_DATE' => 28,'OMIT_ADDRESS' => 29,'DATA_SOURCE' => 30,'unknownField' => 31,'TransactionID' => 32,'Original_Suffix' => 33,'Original_First_Name' => 34,'Original_Middle_Name' => 35,'Original_Last_Name' => 36,'Original_Address' => 37,'Original_Last_Line' => 38,'filename' => 39,0);

//Individual field level validation


EXPORT Make_ACTION_CODE(SALT33.StrType s0) := MakeFT_ActionCodes(s0);
EXPORT InValid_ACTION_CODE(SALT33.StrType s) := InValidFT_ActionCodes(s);
EXPORT InValidMessage_ACTION_CODE(UNSIGNED1 wh) := InValidMessageFT_ActionCodes(wh);


EXPORT Make_RECORD_ID(SALT33.StrType s0) := s0;
EXPORT InValid_RECORD_ID(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_RECORD_ID(UNSIGNED1 wh) := '';


EXPORT Make_RECORD_TYPE(SALT33.StrType s0) := MakeFT_RecordTypes(s0);
EXPORT InValid_RECORD_TYPE(SALT33.StrType s) := InValidFT_RecordTypes(s);
EXPORT InValidMessage_RECORD_TYPE(UNSIGNED1 wh) := InValidMessageFT_RecordTypes(wh);


EXPORT Make_TELEPHONE(SALT33.StrType s0) := MakeFT_phone(s0);
EXPORT InValid_TELEPHONE(SALT33.StrType s) := InValidFT_phone(s);
EXPORT InValidMessage_TELEPHONE(UNSIGNED1 wh) := InValidMessageFT_phone(wh);


EXPORT Make_LISTING_TYPE(SALT33.StrType s0) := MakeFT_PublishCodes(s0);
EXPORT InValid_LISTING_TYPE(SALT33.StrType s) := InValidFT_PublishCodes(s);
EXPORT InValidMessage_LISTING_TYPE(UNSIGNED1 wh) := InValidMessageFT_PublishCodes(wh);


EXPORT Make_BUSINESS_NAME(SALT33.StrType s0) := MakeFT_bizname(s0);
EXPORT InValid_BUSINESS_NAME(SALT33.StrType s) := InValidFT_bizname(s);
EXPORT InValidMessage_BUSINESS_NAME(UNSIGNED1 wh) := InValidMessageFT_bizname(wh);


EXPORT Make_BUSINESS_CAPTIONS(SALT33.StrType s0) := s0;
EXPORT InValid_BUSINESS_CAPTIONS(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_BUSINESS_CAPTIONS(UNSIGNED1 wh) := '';


EXPORT Make_CATEGORY(SALT33.StrType s0) := s0;
EXPORT InValid_CATEGORY(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_CATEGORY(UNSIGNED1 wh) := '';


EXPORT Make_INDENT(SALT33.StrType s0) := MakeFT_Numeric(s0);
EXPORT InValid_INDENT(SALT33.StrType s) := InValidFT_Numeric(s);
EXPORT InValidMessage_INDENT(UNSIGNED1 wh) := InValidMessageFT_Numeric(wh);


EXPORT Make_LAST_NAME(SALT33.StrType s0) := MakeFT_name(s0);
EXPORT InValid_LAST_NAME(SALT33.StrType s) := InValidFT_name(s);
EXPORT InValidMessage_LAST_NAME(UNSIGNED1 wh) := InValidMessageFT_name(wh);


EXPORT Make_SUFFIX_NAME(SALT33.StrType s0) := MakeFT_name(s0);
EXPORT InValid_SUFFIX_NAME(SALT33.StrType s) := InValidFT_name(s);
EXPORT InValidMessage_SUFFIX_NAME(UNSIGNED1 wh) := InValidMessageFT_name(wh);


EXPORT Make_FIRST_NAME(SALT33.StrType s0) := MakeFT_fname(s0);
EXPORT InValid_FIRST_NAME(SALT33.StrType s) := InValidFT_fname(s);
EXPORT InValidMessage_FIRST_NAME(UNSIGNED1 wh) := InValidMessageFT_fname(wh);


EXPORT Make_MIDDLE_NAME(SALT33.StrType s0) := MakeFT_name(s0);
EXPORT InValid_MIDDLE_NAME(SALT33.StrType s) := InValidFT_name(s);
EXPORT InValidMessage_MIDDLE_NAME(UNSIGNED1 wh) := InValidMessageFT_name(wh);


EXPORT Make_PRIMARY_STREET_NUMBER(SALT33.StrType s0) := s0;
EXPORT InValid_PRIMARY_STREET_NUMBER(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_PRIMARY_STREET_NUMBER(UNSIGNED1 wh) := '';


EXPORT Make_PRE_DIR(SALT33.StrType s0) := MakeFT_Directional(s0);
EXPORT InValid_PRE_DIR(SALT33.StrType s) := InValidFT_Directional(s);
EXPORT InValidMessage_PRE_DIR(UNSIGNED1 wh) := InValidMessageFT_Directional(wh);


EXPORT Make_PRIMARY_STREET_NAME(SALT33.StrType s0) := MakeFT_primname(s0);
EXPORT InValid_PRIMARY_STREET_NAME(SALT33.StrType s) := InValidFT_primname(s);
EXPORT InValidMessage_PRIMARY_STREET_NAME(UNSIGNED1 wh) := InValidMessageFT_primname(wh);


EXPORT Make_PRIMARY_STREET_SUFFIX(SALT33.StrType s0) := s0;
EXPORT InValid_PRIMARY_STREET_SUFFIX(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_PRIMARY_STREET_SUFFIX(UNSIGNED1 wh) := '';


EXPORT Make_POST_DIR(SALT33.StrType s0) := MakeFT_Directional(s0);
EXPORT InValid_POST_DIR(SALT33.StrType s) := InValidFT_Directional(s);
EXPORT InValidMessage_POST_DIR(UNSIGNED1 wh) := InValidMessageFT_Directional(wh);


EXPORT Make_SECONDARY_ADDRESS_TYPE(SALT33.StrType s0) := s0;
EXPORT InValid_SECONDARY_ADDRESS_TYPE(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_SECONDARY_ADDRESS_TYPE(UNSIGNED1 wh) := '';


EXPORT Make_SECONDARY_RANGE(SALT33.StrType s0) := s0;
EXPORT InValid_SECONDARY_RANGE(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_SECONDARY_RANGE(UNSIGNED1 wh) := '';


EXPORT Make_CITY(SALT33.StrType s0) := MakeFT_cityname(s0);
EXPORT InValid_CITY(SALT33.StrType s) := InValidFT_cityname(s);
EXPORT InValidMessage_CITY(UNSIGNED1 wh) := InValidMessageFT_cityname(wh);


EXPORT Make_STATE(SALT33.StrType s0) := MakeFT_StateAbrv(s0);
EXPORT InValid_STATE(SALT33.StrType s) := InValidFT_StateAbrv(s);
EXPORT InValidMessage_STATE(UNSIGNED1 wh) := InValidMessageFT_StateAbrv(wh);


EXPORT Make_ZIP_CODE(SALT33.StrType s0) := MakeFT_zip(s0);
EXPORT InValid_ZIP_CODE(SALT33.StrType s) := InValidFT_zip(s);
EXPORT InValidMessage_ZIP_CODE(UNSIGNED1 wh) := InValidMessageFT_zip(wh);


EXPORT Make_ZIP_PLUS4(SALT33.StrType s0) := MakeFT_zip4(s0);
EXPORT InValid_ZIP_PLUS4(SALT33.StrType s) := InValidFT_zip4(s);
EXPORT InValidMessage_ZIP_PLUS4(UNSIGNED1 wh) := InValidMessageFT_zip4(wh);


EXPORT Make_LATITUDE(SALT33.StrType s0) := s0;
EXPORT InValid_LATITUDE(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_LATITUDE(UNSIGNED1 wh) := '';


EXPORT Make_LONGITUDE(SALT33.StrType s0) := s0;
EXPORT InValid_LONGITUDE(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_LONGITUDE(UNSIGNED1 wh) := '';


EXPORT Make_LAT_LONG_MATCH_LEVEL(SALT33.StrType s0) := s0;
EXPORT InValid_LAT_LONG_MATCH_LEVEL(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_LAT_LONG_MATCH_LEVEL(UNSIGNED1 wh) := '';


EXPORT Make_UNLICENSED(SALT33.StrType s0) := s0;
EXPORT InValid_UNLICENSED(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_UNLICENSED(UNSIGNED1 wh) := '';


EXPORT Make_ADD_DATE(SALT33.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_ADD_DATE(SALT33.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_ADD_DATE(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);


EXPORT Make_OMIT_ADDRESS(SALT33.StrType s0) := MakeFT_YesNo(s0);
EXPORT InValid_OMIT_ADDRESS(SALT33.StrType s) := InValidFT_YesNo(s);
EXPORT InValidMessage_OMIT_ADDRESS(UNSIGNED1 wh) := InValidMessageFT_YesNo(wh);


EXPORT Make_DATA_SOURCE(SALT33.StrType s0) := s0;
EXPORT InValid_DATA_SOURCE(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_DATA_SOURCE(UNSIGNED1 wh) := '';


EXPORT Make_unknownField(SALT33.StrType s0) := s0;
EXPORT InValid_unknownField(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_unknownField(UNSIGNED1 wh) := '';


EXPORT Make_TransactionID(SALT33.StrType s0) := s0;
EXPORT InValid_TransactionID(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_TransactionID(UNSIGNED1 wh) := '';


EXPORT Make_Original_Suffix(SALT33.StrType s0) := s0;
EXPORT InValid_Original_Suffix(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_Original_Suffix(UNSIGNED1 wh) := '';


EXPORT Make_Original_First_Name(SALT33.StrType s0) := s0;
EXPORT InValid_Original_First_Name(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_Original_First_Name(UNSIGNED1 wh) := '';


EXPORT Make_Original_Middle_Name(SALT33.StrType s0) := s0;
EXPORT InValid_Original_Middle_Name(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_Original_Middle_Name(UNSIGNED1 wh) := '';


EXPORT Make_Original_Last_Name(SALT33.StrType s0) := s0;
EXPORT InValid_Original_Last_Name(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_Original_Last_Name(UNSIGNED1 wh) := '';


EXPORT Make_Original_Address(SALT33.StrType s0) := s0;
EXPORT InValid_Original_Address(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_Original_Address(UNSIGNED1 wh) := '';


EXPORT Make_Original_Last_Line(SALT33.StrType s0) := s0;
EXPORT InValid_Original_Last_Line(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_Original_Last_Line(UNSIGNED1 wh) := '';


EXPORT Make_filename(SALT33.StrType s0) := s0;
EXPORT InValid_filename(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_filename(UNSIGNED1 wh) := '';

// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT33,Scrubs_Gong;
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
    BOOLEAN Diff_ACTION_CODE;
    BOOLEAN Diff_RECORD_ID;
    BOOLEAN Diff_RECORD_TYPE;
    BOOLEAN Diff_TELEPHONE;
    BOOLEAN Diff_LISTING_TYPE;
    BOOLEAN Diff_BUSINESS_NAME;
    BOOLEAN Diff_BUSINESS_CAPTIONS;
    BOOLEAN Diff_CATEGORY;
    BOOLEAN Diff_INDENT;
    BOOLEAN Diff_LAST_NAME;
    BOOLEAN Diff_SUFFIX_NAME;
    BOOLEAN Diff_FIRST_NAME;
    BOOLEAN Diff_MIDDLE_NAME;
    BOOLEAN Diff_PRIMARY_STREET_NUMBER;
    BOOLEAN Diff_PRE_DIR;
    BOOLEAN Diff_PRIMARY_STREET_NAME;
    BOOLEAN Diff_PRIMARY_STREET_SUFFIX;
    BOOLEAN Diff_POST_DIR;
    BOOLEAN Diff_SECONDARY_ADDRESS_TYPE;
    BOOLEAN Diff_SECONDARY_RANGE;
    BOOLEAN Diff_CITY;
    BOOLEAN Diff_STATE;
    BOOLEAN Diff_ZIP_CODE;
    BOOLEAN Diff_ZIP_PLUS4;
    BOOLEAN Diff_LATITUDE;
    BOOLEAN Diff_LONGITUDE;
    BOOLEAN Diff_LAT_LONG_MATCH_LEVEL;
    BOOLEAN Diff_UNLICENSED;
    BOOLEAN Diff_ADD_DATE;
    BOOLEAN Diff_OMIT_ADDRESS;
    BOOLEAN Diff_DATA_SOURCE;
    BOOLEAN Diff_unknownField;
    BOOLEAN Diff_TransactionID;
    BOOLEAN Diff_Original_Suffix;
    BOOLEAN Diff_Original_First_Name;
    BOOLEAN Diff_Original_Middle_Name;
    BOOLEAN Diff_Original_Last_Name;
    BOOLEAN Diff_Original_Address;
    BOOLEAN Diff_Original_Last_Line;
    BOOLEAN Diff_filename;
    UNSIGNED Num_Diffs;
    SALT33.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_ACTION_CODE := le.ACTION_CODE <> ri.ACTION_CODE;
    SELF.Diff_RECORD_ID := le.RECORD_ID <> ri.RECORD_ID;
    SELF.Diff_RECORD_TYPE := le.RECORD_TYPE <> ri.RECORD_TYPE;
    SELF.Diff_TELEPHONE := le.TELEPHONE <> ri.TELEPHONE;
    SELF.Diff_LISTING_TYPE := le.LISTING_TYPE <> ri.LISTING_TYPE;
    SELF.Diff_BUSINESS_NAME := le.BUSINESS_NAME <> ri.BUSINESS_NAME;
    SELF.Diff_BUSINESS_CAPTIONS := le.BUSINESS_CAPTIONS <> ri.BUSINESS_CAPTIONS;
    SELF.Diff_CATEGORY := le.CATEGORY <> ri.CATEGORY;
    SELF.Diff_INDENT := le.INDENT <> ri.INDENT;
    SELF.Diff_LAST_NAME := le.LAST_NAME <> ri.LAST_NAME;
    SELF.Diff_SUFFIX_NAME := le.SUFFIX_NAME <> ri.SUFFIX_NAME;
    SELF.Diff_FIRST_NAME := le.FIRST_NAME <> ri.FIRST_NAME;
    SELF.Diff_MIDDLE_NAME := le.MIDDLE_NAME <> ri.MIDDLE_NAME;
    SELF.Diff_PRIMARY_STREET_NUMBER := le.PRIMARY_STREET_NUMBER <> ri.PRIMARY_STREET_NUMBER;
    SELF.Diff_PRE_DIR := le.PRE_DIR <> ri.PRE_DIR;
    SELF.Diff_PRIMARY_STREET_NAME := le.PRIMARY_STREET_NAME <> ri.PRIMARY_STREET_NAME;
    SELF.Diff_PRIMARY_STREET_SUFFIX := le.PRIMARY_STREET_SUFFIX <> ri.PRIMARY_STREET_SUFFIX;
    SELF.Diff_POST_DIR := le.POST_DIR <> ri.POST_DIR;
    SELF.Diff_SECONDARY_ADDRESS_TYPE := le.SECONDARY_ADDRESS_TYPE <> ri.SECONDARY_ADDRESS_TYPE;
    SELF.Diff_SECONDARY_RANGE := le.SECONDARY_RANGE <> ri.SECONDARY_RANGE;
    SELF.Diff_CITY := le.CITY <> ri.CITY;
    SELF.Diff_STATE := le.STATE <> ri.STATE;
    SELF.Diff_ZIP_CODE := le.ZIP_CODE <> ri.ZIP_CODE;
    SELF.Diff_ZIP_PLUS4 := le.ZIP_PLUS4 <> ri.ZIP_PLUS4;
    SELF.Diff_LATITUDE := le.LATITUDE <> ri.LATITUDE;
    SELF.Diff_LONGITUDE := le.LONGITUDE <> ri.LONGITUDE;
    SELF.Diff_LAT_LONG_MATCH_LEVEL := le.LAT_LONG_MATCH_LEVEL <> ri.LAT_LONG_MATCH_LEVEL;
    SELF.Diff_UNLICENSED := le.UNLICENSED <> ri.UNLICENSED;
    SELF.Diff_ADD_DATE := le.ADD_DATE <> ri.ADD_DATE;
    SELF.Diff_OMIT_ADDRESS := le.OMIT_ADDRESS <> ri.OMIT_ADDRESS;
    SELF.Diff_DATA_SOURCE := le.DATA_SOURCE <> ri.DATA_SOURCE;
    SELF.Diff_unknownField := le.unknownField <> ri.unknownField;
    SELF.Diff_TransactionID := le.TransactionID <> ri.TransactionID;
    SELF.Diff_Original_Suffix := le.Original_Suffix <> ri.Original_Suffix;
    SELF.Diff_Original_First_Name := le.Original_First_Name <> ri.Original_First_Name;
    SELF.Diff_Original_Middle_Name := le.Original_Middle_Name <> ri.Original_Middle_Name;
    SELF.Diff_Original_Last_Name := le.Original_Last_Name <> ri.Original_Last_Name;
    SELF.Diff_Original_Address := le.Original_Address <> ri.Original_Address;
    SELF.Diff_Original_Last_Line := le.Original_Last_Line <> ri.Original_Last_Line;
    SELF.Diff_filename := le.filename <> ri.filename;
    SELF.Val := (SALT33.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_ACTION_CODE,1,0)+ IF( SELF.Diff_RECORD_ID,1,0)+ IF( SELF.Diff_RECORD_TYPE,1,0)+ IF( SELF.Diff_TELEPHONE,1,0)+ IF( SELF.Diff_LISTING_TYPE,1,0)+ IF( SELF.Diff_BUSINESS_NAME,1,0)+ IF( SELF.Diff_BUSINESS_CAPTIONS,1,0)+ IF( SELF.Diff_CATEGORY,1,0)+ IF( SELF.Diff_INDENT,1,0)+ IF( SELF.Diff_LAST_NAME,1,0)+ IF( SELF.Diff_SUFFIX_NAME,1,0)+ IF( SELF.Diff_FIRST_NAME,1,0)+ IF( SELF.Diff_MIDDLE_NAME,1,0)+ IF( SELF.Diff_PRIMARY_STREET_NUMBER,1,0)+ IF( SELF.Diff_PRE_DIR,1,0)+ IF( SELF.Diff_PRIMARY_STREET_NAME,1,0)+ IF( SELF.Diff_PRIMARY_STREET_SUFFIX,1,0)+ IF( SELF.Diff_POST_DIR,1,0)+ IF( SELF.Diff_SECONDARY_ADDRESS_TYPE,1,0)+ IF( SELF.Diff_SECONDARY_RANGE,1,0)+ IF( SELF.Diff_CITY,1,0)+ IF( SELF.Diff_STATE,1,0)+ IF( SELF.Diff_ZIP_CODE,1,0)+ IF( SELF.Diff_ZIP_PLUS4,1,0)+ IF( SELF.Diff_LATITUDE,1,0)+ IF( SELF.Diff_LONGITUDE,1,0)+ IF( SELF.Diff_LAT_LONG_MATCH_LEVEL,1,0)+ IF( SELF.Diff_UNLICENSED,1,0)+ IF( SELF.Diff_ADD_DATE,1,0)+ IF( SELF.Diff_OMIT_ADDRESS,1,0)+ IF( SELF.Diff_DATA_SOURCE,1,0)+ IF( SELF.Diff_unknownField,1,0)+ IF( SELF.Diff_TransactionID,1,0)+ IF( SELF.Diff_Original_Suffix,1,0)+ IF( SELF.Diff_Original_First_Name,1,0)+ IF( SELF.Diff_Original_Middle_Name,1,0)+ IF( SELF.Diff_Original_Last_Name,1,0)+ IF( SELF.Diff_Original_Address,1,0)+ IF( SELF.Diff_Original_Last_Line,1,0)+ IF( SELF.Diff_filename,1,0);
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
    Count_Diff_ACTION_CODE := COUNT(GROUP,%Closest%.Diff_ACTION_CODE);
    Count_Diff_RECORD_ID := COUNT(GROUP,%Closest%.Diff_RECORD_ID);
    Count_Diff_RECORD_TYPE := COUNT(GROUP,%Closest%.Diff_RECORD_TYPE);
    Count_Diff_TELEPHONE := COUNT(GROUP,%Closest%.Diff_TELEPHONE);
    Count_Diff_LISTING_TYPE := COUNT(GROUP,%Closest%.Diff_LISTING_TYPE);
    Count_Diff_BUSINESS_NAME := COUNT(GROUP,%Closest%.Diff_BUSINESS_NAME);
    Count_Diff_BUSINESS_CAPTIONS := COUNT(GROUP,%Closest%.Diff_BUSINESS_CAPTIONS);
    Count_Diff_CATEGORY := COUNT(GROUP,%Closest%.Diff_CATEGORY);
    Count_Diff_INDENT := COUNT(GROUP,%Closest%.Diff_INDENT);
    Count_Diff_LAST_NAME := COUNT(GROUP,%Closest%.Diff_LAST_NAME);
    Count_Diff_SUFFIX_NAME := COUNT(GROUP,%Closest%.Diff_SUFFIX_NAME);
    Count_Diff_FIRST_NAME := COUNT(GROUP,%Closest%.Diff_FIRST_NAME);
    Count_Diff_MIDDLE_NAME := COUNT(GROUP,%Closest%.Diff_MIDDLE_NAME);
    Count_Diff_PRIMARY_STREET_NUMBER := COUNT(GROUP,%Closest%.Diff_PRIMARY_STREET_NUMBER);
    Count_Diff_PRE_DIR := COUNT(GROUP,%Closest%.Diff_PRE_DIR);
    Count_Diff_PRIMARY_STREET_NAME := COUNT(GROUP,%Closest%.Diff_PRIMARY_STREET_NAME);
    Count_Diff_PRIMARY_STREET_SUFFIX := COUNT(GROUP,%Closest%.Diff_PRIMARY_STREET_SUFFIX);
    Count_Diff_POST_DIR := COUNT(GROUP,%Closest%.Diff_POST_DIR);
    Count_Diff_SECONDARY_ADDRESS_TYPE := COUNT(GROUP,%Closest%.Diff_SECONDARY_ADDRESS_TYPE);
    Count_Diff_SECONDARY_RANGE := COUNT(GROUP,%Closest%.Diff_SECONDARY_RANGE);
    Count_Diff_CITY := COUNT(GROUP,%Closest%.Diff_CITY);
    Count_Diff_STATE := COUNT(GROUP,%Closest%.Diff_STATE);
    Count_Diff_ZIP_CODE := COUNT(GROUP,%Closest%.Diff_ZIP_CODE);
    Count_Diff_ZIP_PLUS4 := COUNT(GROUP,%Closest%.Diff_ZIP_PLUS4);
    Count_Diff_LATITUDE := COUNT(GROUP,%Closest%.Diff_LATITUDE);
    Count_Diff_LONGITUDE := COUNT(GROUP,%Closest%.Diff_LONGITUDE);
    Count_Diff_LAT_LONG_MATCH_LEVEL := COUNT(GROUP,%Closest%.Diff_LAT_LONG_MATCH_LEVEL);
    Count_Diff_UNLICENSED := COUNT(GROUP,%Closest%.Diff_UNLICENSED);
    Count_Diff_ADD_DATE := COUNT(GROUP,%Closest%.Diff_ADD_DATE);
    Count_Diff_OMIT_ADDRESS := COUNT(GROUP,%Closest%.Diff_OMIT_ADDRESS);
    Count_Diff_DATA_SOURCE := COUNT(GROUP,%Closest%.Diff_DATA_SOURCE);
    Count_Diff_unknownField := COUNT(GROUP,%Closest%.Diff_unknownField);
    Count_Diff_TransactionID := COUNT(GROUP,%Closest%.Diff_TransactionID);
    Count_Diff_Original_Suffix := COUNT(GROUP,%Closest%.Diff_Original_Suffix);
    Count_Diff_Original_First_Name := COUNT(GROUP,%Closest%.Diff_Original_First_Name);
    Count_Diff_Original_Middle_Name := COUNT(GROUP,%Closest%.Diff_Original_Middle_Name);
    Count_Diff_Original_Last_Name := COUNT(GROUP,%Closest%.Diff_Original_Last_Name);
    Count_Diff_Original_Address := COUNT(GROUP,%Closest%.Diff_Original_Address);
    Count_Diff_Original_Last_Line := COUNT(GROUP,%Closest%.Diff_Original_Last_Line);
    Count_Diff_filename := COUNT(GROUP,%Closest%.Diff_filename);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
