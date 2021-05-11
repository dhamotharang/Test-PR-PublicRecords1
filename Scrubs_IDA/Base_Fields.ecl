IMPORT SALT311;
IMPORT Scrubs_IDA,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Base_Fields := MODULE

EXPORT NumFields := 65;

// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Num','Invalid_Alpha','Invalid_AlphaNum','Invalid_Rec_ID','Invalid_Date','Invalid_FName','Invalid_MName','Invalid_LName','Invalid_Suffix','Invalid_Title','Invalid_Address1','Invalid_Address2','Invalid_City','Invalid_State','Invalid_Zip','Invalid_Zip4','Invalid_SSN','Invalid_DL','Invalid_Phone','Invalid_Clientassigneduniquerecordid','Invalid_Emailaddress','Invalid_Ipaddress','Invalid_NID','Invalid_Dir','Invalid_Add','Invalid_Add_Suff','Invalid_Coor','Invalid_Err','Invalid_AID');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Num' => 1,'Invalid_Alpha' => 2,'Invalid_AlphaNum' => 3,'Invalid_Rec_ID' => 4,'Invalid_Date' => 5,'Invalid_FName' => 6,'Invalid_MName' => 7,'Invalid_LName' => 8,'Invalid_Suffix' => 9,'Invalid_Title' => 10,'Invalid_Address1' => 11,'Invalid_Address2' => 12,'Invalid_City' => 13,'Invalid_State' => 14,'Invalid_Zip' => 15,'Invalid_Zip4' => 16,'Invalid_SSN' => 17,'Invalid_DL' => 18,'Invalid_Phone' => 19,'Invalid_Clientassigneduniquerecordid' => 20,'Invalid_Emailaddress' => 21,'Invalid_Ipaddress' => 22,'Invalid_NID' => 23,'Invalid_Dir' => 24,'Invalid_Add' => 25,'Invalid_Add_Suff' => 26,'Invalid_Coor' => 27,'Invalid_Err' => 28,'Invalid_AID' => 29,0);

EXPORT MakeFT_Invalid_Num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_Invalid_Alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_AlphaNum(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaNum(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_Invalid_AlphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Rec_ID(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789_'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Rec_ID(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789_'))),~(LENGTH(TRIM(s)) = 15));
EXPORT InValidMessageFT_Invalid_Rec_ID(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789_'),SALT311.HygieneErrors.NotLength('15'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Scrubs_IDA.Functions.Fn_Valid_Date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IDA.Functions.Fn_Valid_Date'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_FName(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ- '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_Invalid_FName(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ- '))),~(LENGTH(TRIM(s)) >= 2 AND LENGTH(TRIM(s)) <= 20),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 0 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_Invalid_FName(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ- '),SALT311.HygieneErrors.NotLength('2..20'),SALT311.HygieneErrors.NotWords('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_MName(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ. '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_Invalid_MName(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ. '))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 15),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 0 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_Invalid_MName(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ. '),SALT311.HygieneErrors.NotLength('0..15'),SALT311.HygieneErrors.NotWords('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_LName(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ.- '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_Invalid_LName(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ.- '))),~(LENGTH(TRIM(s)) >= 2 AND LENGTH(TRIM(s)) <= 20),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) >= 0 AND SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) <= 2));
EXPORT InValidMessageFT_Invalid_LName(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ.- '),SALT311.HygieneErrors.NotLength('2..20'),SALT311.HygieneErrors.NotWords('0..2'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Suffix(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'SRJr.IVXPHMD '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_Invalid_Suffix(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'SRJr.IVXPHMD '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 0 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_Invalid_Suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('SRJr.IVXPHMD '),SALT311.HygieneErrors.NotLength('0,1,2,3'),SALT311.HygieneErrors.NotWords('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Title(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'DMRS '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_Invalid_Title(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'DMRS '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 0 OR SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_Invalid_Title(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('DMRS '),SALT311.HygieneErrors.NotLength('0,1,2,3'),SALT311.HygieneErrors.NotWords('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Address1(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ .'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' .',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_AlphaNum(s2);
END;
EXPORT InValidFT_Invalid_Address1(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ .'))),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' .',' ')) >= 0 AND SALT311.WordCount(SALT311.StringSubstituteOut(s,' .',' ')) <= 7));
EXPORT InValidMessageFT_Invalid_Address1(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ .'),SALT311.HygieneErrors.NotWords('0..7'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Address2(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ #'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' #',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_AlphaNum(s2);
END;
EXPORT InValidFT_Invalid_Address2(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ #'))),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' #',' ')) >= 0 AND SALT311.WordCount(SALT311.StringSubstituteOut(s,' #',' ')) <= 2));
EXPORT InValidMessageFT_Invalid_Address2(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ #'),SALT311.HygieneErrors.NotWords('0..2'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_City(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_Alpha(s2);
END;
EXPORT InValidFT_Invalid_City(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) >= 0 AND SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) <= 4));
EXPORT InValidMessageFT_Invalid_City(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.NotWords('0..4'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_State(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_State(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_verify_state'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_Invalid_Num(s1);
END;
EXPORT InValidFT_Invalid_Zip(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_Invalid_Zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0,5'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Zip4(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_Invalid_Num(s1);
END;
EXPORT InValidFT_Invalid_Zip4(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_Invalid_Zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0,4'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_SSN(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_Invalid_Num(s1);
END;
EXPORT InValidFT_Invalid_SSN(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_Invalid_SSN(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0,9'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_DL(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_DL(SALT311.StrType s) := WHICH(~Scrubs_IDA.Functions.Fn_Valid_DL(s)>0);
EXPORT InValidMessageFT_Invalid_DL(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IDA.Functions.Fn_Valid_DL'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Phone(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Phone(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_Invalid_Phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0,10'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Clientassigneduniquerecordid(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'abcdefghijklmnopqrstuvwxyz0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Clientassigneduniquerecordid(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'abcdefghijklmnopqrstuvwxyz0123456789'))),~(LENGTH(TRIM(s)) >= 12 AND LENGTH(TRIM(s)) <= 20));
EXPORT InValidMessageFT_Invalid_Clientassigneduniquerecordid(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyz0123456789'),SALT311.HygieneErrors.NotLength('12..20'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Emailaddress(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Emailaddress(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_valid_email(s)>0);
EXPORT InValidMessageFT_Invalid_Emailaddress(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_valid_email'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Ipaddress(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Ipaddress(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_valid_IP(s)>0);
EXPORT InValidMessageFT_Invalid_Ipaddress(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_valid_IP'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_NID(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_Invalid_Num(s1);
END;
EXPORT InValidFT_Invalid_NID(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 18 OR LENGTH(TRIM(s)) = 19 OR LENGTH(TRIM(s)) = 20));
EXPORT InValidMessageFT_Invalid_NID(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0,18,19,20'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Dir(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'NESW'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Dir(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'NESW'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 2));
EXPORT InValidMessageFT_Invalid_Dir(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('NESW'),SALT311.HygieneErrors.NotLength('0..2'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Add(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Invalid_AlphaNum(s2);
END;
EXPORT InValidFT_Invalid_Add(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) >= 0 AND SALT311.WordCount(SALT311.StringSubstituteOut(s,' ',' ')) <= 3));
EXPORT InValidMessageFT_Invalid_Add(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.NotWords('0..3'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Add_Suff(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  MakeFT_Invalid_AlphaNum(s1);
END;
EXPORT InValidFT_Invalid_Add_Suff(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 2 AND LENGTH(TRIM(s)) <= 4));
EXPORT InValidMessageFT_Invalid_Add_Suff(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.NotLength('0,2..4'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Coor(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Coor(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_geo_coord(s)>0);
EXPORT InValidMessageFT_Invalid_Coor(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_geo_coord'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Err(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  MakeFT_Invalid_AlphaNum(s1);
END;
EXPORT InValidFT_Invalid_Err(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_Invalid_Err(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.NotLength('4'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_AID(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_Invalid_Num(s1);
END;
EXPORT InValidFT_Invalid_AID(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 12 OR LENGTH(TRIM(s)) = 13));
EXPORT InValidMessageFT_Invalid_AID(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('12,13'),SALT311.HygieneErrors.Good);


EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'persistent_record_id','src','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','did','did_score','orig_first_name','orig_middle_name','orig_last_name','orig_suffix','orig_address1','orig_address2','orig_city','orig_state_province','orig_zip4','orig_zip5','orig_dob','orig_ssn','orig_dl','orig_dlstate','orig_phone','clientassigneduniquerecordid','adl_ind','orig_email','orig_ipaddress','orig_filecategory','title','fname','mname','lname','name_suffix','nid','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','aceaid','clean_phone','clean_dob');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'persistent_record_id','src','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','did','did_score','orig_first_name','orig_middle_name','orig_last_name','orig_suffix','orig_address1','orig_address2','orig_city','orig_state_province','orig_zip4','orig_zip5','orig_dob','orig_ssn','orig_dl','orig_dlstate','orig_phone','clientassigneduniquerecordid','adl_ind','orig_email','orig_ipaddress','orig_filecategory','title','fname','mname','lname','name_suffix','nid','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','aceaid','clean_phone','clean_dob');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'persistent_record_id' => 0,'src' => 1,'dt_first_seen' => 2,'dt_last_seen' => 3,'dt_vendor_first_reported' => 4,'dt_vendor_last_reported' => 5,'did' => 6,'did_score' => 7,'orig_first_name' => 8,'orig_middle_name' => 9,'orig_last_name' => 10,'orig_suffix' => 11,'orig_address1' => 12,'orig_address2' => 13,'orig_city' => 14,'orig_state_province' => 15,'orig_zip4' => 16,'orig_zip5' => 17,'orig_dob' => 18,'orig_ssn' => 19,'orig_dl' => 20,'orig_dlstate' => 21,'orig_phone' => 22,'clientassigneduniquerecordid' => 23,'adl_ind' => 24,'orig_email' => 25,'orig_ipaddress' => 26,'orig_filecategory' => 27,'title' => 28,'fname' => 29,'mname' => 30,'lname' => 31,'name_suffix' => 32,'nid' => 33,'prim_range' => 34,'predir' => 35,'prim_name' => 36,'addr_suffix' => 37,'postdir' => 38,'unit_desig' => 39,'sec_range' => 40,'p_city_name' => 41,'v_city_name' => 42,'st' => 43,'zip' => 44,'zip4' => 45,'cart' => 46,'cr_sort_sz' => 47,'lot' => 48,'lot_order' => 49,'dbpc' => 50,'chk_digit' => 51,'rec_type' => 52,'fips_st' => 53,'fips_county' => 54,'geo_lat' => 55,'geo_long' => 56,'msa' => 57,'geo_blk' => 58,'geo_match' => 59,'err_stat' => 60,'rawaid' => 61,'aceaid' => 62,'clean_phone' => 63,'clean_dob' => 64,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','LENGTHS'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['CUSTOM'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['CUSTOM'],['ALLOW','LENGTHS'],['CUSTOM'],['CUSTOM'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['CUSTOM'],['CUSTOM'],[],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','WORDS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW','WORDS'],['ALLOW','WORDS'],['CUSTOM'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);

//Individual field level validation


EXPORT Make_persistent_record_id(SALT311.StrType s0) := MakeFT_Invalid_Rec_ID(s0);
EXPORT InValid_persistent_record_id(SALT311.StrType s) := InValidFT_Invalid_Rec_ID(s);
EXPORT InValidMessage_persistent_record_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_Rec_ID(wh);


EXPORT Make_src(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_src(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_src(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);


EXPORT Make_dt_first_seen(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_first_seen(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);


EXPORT Make_dt_last_seen(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_last_seen(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);


EXPORT Make_dt_vendor_first_reported(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_vendor_first_reported(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);


EXPORT Make_dt_vendor_last_reported(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_vendor_last_reported(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);


EXPORT Make_did(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_did(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_did_score(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_did_score(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_did_score(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_orig_first_name(SALT311.StrType s0) := MakeFT_Invalid_FName(s0);
EXPORT InValid_orig_first_name(SALT311.StrType s) := InValidFT_Invalid_FName(s);
EXPORT InValidMessage_orig_first_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_FName(wh);


EXPORT Make_orig_middle_name(SALT311.StrType s0) := MakeFT_Invalid_MName(s0);
EXPORT InValid_orig_middle_name(SALT311.StrType s) := InValidFT_Invalid_MName(s);
EXPORT InValidMessage_orig_middle_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_MName(wh);


EXPORT Make_orig_last_name(SALT311.StrType s0) := MakeFT_Invalid_LName(s0);
EXPORT InValid_orig_last_name(SALT311.StrType s) := InValidFT_Invalid_LName(s);
EXPORT InValidMessage_orig_last_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_LName(wh);


EXPORT Make_orig_suffix(SALT311.StrType s0) := MakeFT_Invalid_Suffix(s0);
EXPORT InValid_orig_suffix(SALT311.StrType s) := InValidFT_Invalid_Suffix(s);
EXPORT InValidMessage_orig_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Suffix(wh);


EXPORT Make_orig_address1(SALT311.StrType s0) := MakeFT_Invalid_Address1(s0);
EXPORT InValid_orig_address1(SALT311.StrType s) := InValidFT_Invalid_Address1(s);
EXPORT InValidMessage_orig_address1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Address1(wh);


EXPORT Make_orig_address2(SALT311.StrType s0) := MakeFT_Invalid_Address2(s0);
EXPORT InValid_orig_address2(SALT311.StrType s) := InValidFT_Invalid_Address2(s);
EXPORT InValidMessage_orig_address2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Address2(wh);


EXPORT Make_orig_city(SALT311.StrType s0) := MakeFT_Invalid_City(s0);
EXPORT InValid_orig_city(SALT311.StrType s) := InValidFT_Invalid_City(s);
EXPORT InValidMessage_orig_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_City(wh);


EXPORT Make_orig_state_province(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_orig_state_province(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_orig_state_province(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);


EXPORT Make_orig_zip4(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_orig_zip4(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_orig_zip4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);


EXPORT Make_orig_zip5(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_orig_zip5(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_orig_zip5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);


EXPORT Make_orig_dob(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_orig_dob(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_orig_dob(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);


EXPORT Make_orig_ssn(SALT311.StrType s0) := MakeFT_Invalid_SSN(s0);
EXPORT InValid_orig_ssn(SALT311.StrType s) := InValidFT_Invalid_SSN(s);
EXPORT InValidMessage_orig_ssn(UNSIGNED1 wh) := InValidMessageFT_Invalid_SSN(wh);


EXPORT Make_orig_dl(SALT311.StrType s0) := MakeFT_Invalid_DL(s0);
EXPORT InValid_orig_dl(SALT311.StrType s) := InValidFT_Invalid_DL(s);
EXPORT InValidMessage_orig_dl(UNSIGNED1 wh) := InValidMessageFT_Invalid_DL(wh);


EXPORT Make_orig_dlstate(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_orig_dlstate(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_orig_dlstate(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);


EXPORT Make_orig_phone(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_orig_phone(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_orig_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);


EXPORT Make_clientassigneduniquerecordid(SALT311.StrType s0) := MakeFT_Invalid_Clientassigneduniquerecordid(s0);
EXPORT InValid_clientassigneduniquerecordid(SALT311.StrType s) := InValidFT_Invalid_Clientassigneduniquerecordid(s);
EXPORT InValidMessage_clientassigneduniquerecordid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Clientassigneduniquerecordid(wh);


EXPORT Make_adl_ind(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_adl_ind(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_adl_ind(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);


EXPORT Make_orig_email(SALT311.StrType s0) := MakeFT_Invalid_Emailaddress(s0);
EXPORT InValid_orig_email(SALT311.StrType s) := InValidFT_Invalid_Emailaddress(s);
EXPORT InValidMessage_orig_email(UNSIGNED1 wh) := InValidMessageFT_Invalid_Emailaddress(wh);


EXPORT Make_orig_ipaddress(SALT311.StrType s0) := MakeFT_Invalid_Ipaddress(s0);
EXPORT InValid_orig_ipaddress(SALT311.StrType s) := InValidFT_Invalid_Ipaddress(s);
EXPORT InValidMessage_orig_ipaddress(UNSIGNED1 wh) := InValidMessageFT_Invalid_Ipaddress(wh);


EXPORT Make_orig_filecategory(SALT311.StrType s0) := s0;
EXPORT InValid_orig_filecategory(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_filecategory(UNSIGNED1 wh) := '';


EXPORT Make_title(SALT311.StrType s0) := MakeFT_Invalid_Title(s0);
EXPORT InValid_title(SALT311.StrType s) := InValidFT_Invalid_Title(s);
EXPORT InValidMessage_title(UNSIGNED1 wh) := InValidMessageFT_Invalid_Title(wh);


EXPORT Make_fname(SALT311.StrType s0) := MakeFT_Invalid_FName(s0);
EXPORT InValid_fname(SALT311.StrType s) := InValidFT_Invalid_FName(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_Invalid_FName(wh);


EXPORT Make_mname(SALT311.StrType s0) := MakeFT_Invalid_MName(s0);
EXPORT InValid_mname(SALT311.StrType s) := InValidFT_Invalid_MName(s);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_Invalid_MName(wh);


EXPORT Make_lname(SALT311.StrType s0) := MakeFT_Invalid_LName(s0);
EXPORT InValid_lname(SALT311.StrType s) := InValidFT_Invalid_LName(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_Invalid_LName(wh);


EXPORT Make_name_suffix(SALT311.StrType s0) := MakeFT_Invalid_Suffix(s0);
EXPORT InValid_name_suffix(SALT311.StrType s) := InValidFT_Invalid_Suffix(s);
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Suffix(wh);


EXPORT Make_nid(SALT311.StrType s0) := MakeFT_Invalid_NID(s0);
EXPORT InValid_nid(SALT311.StrType s) := InValidFT_Invalid_NID(s);
EXPORT InValidMessage_nid(UNSIGNED1 wh) := InValidMessageFT_Invalid_NID(wh);


EXPORT Make_prim_range(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_prim_range(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_predir(SALT311.StrType s0) := MakeFT_Invalid_Dir(s0);
EXPORT InValid_predir(SALT311.StrType s) := InValidFT_Invalid_Dir(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_Invalid_Dir(wh);


EXPORT Make_prim_name(SALT311.StrType s0) := MakeFT_Invalid_Add(s0);
EXPORT InValid_prim_name(SALT311.StrType s) := InValidFT_Invalid_Add(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Add(wh);


EXPORT Make_addr_suffix(SALT311.StrType s0) := MakeFT_Invalid_Add_Suff(s0);
EXPORT InValid_addr_suffix(SALT311.StrType s) := InValidFT_Invalid_Add_Suff(s);
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Add_Suff(wh);


EXPORT Make_postdir(SALT311.StrType s0) := MakeFT_Invalid_Dir(s0);
EXPORT InValid_postdir(SALT311.StrType s) := InValidFT_Invalid_Dir(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_Invalid_Dir(wh);


EXPORT Make_unit_desig(SALT311.StrType s0) := MakeFT_Invalid_Add_Suff(s0);
EXPORT InValid_unit_desig(SALT311.StrType s) := InValidFT_Invalid_Add_Suff(s);
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := InValidMessageFT_Invalid_Add_Suff(wh);


EXPORT Make_sec_range(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_sec_range(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_p_city_name(SALT311.StrType s0) := MakeFT_Invalid_City(s0);
EXPORT InValid_p_city_name(SALT311.StrType s) := InValidFT_Invalid_City(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_City(wh);


EXPORT Make_v_city_name(SALT311.StrType s0) := MakeFT_Invalid_City(s0);
EXPORT InValid_v_city_name(SALT311.StrType s) := InValidFT_Invalid_City(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_City(wh);


EXPORT Make_st(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_st(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);


EXPORT Make_zip(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_zip(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);


EXPORT Make_zip4(SALT311.StrType s0) := MakeFT_Invalid_Zip4(s0);
EXPORT InValid_zip4(SALT311.StrType s) := InValidFT_Invalid_Zip4(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip4(wh);


EXPORT Make_cart(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_cart(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_cart(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);


EXPORT Make_cr_sort_sz(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_cr_sort_sz(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);


EXPORT Make_lot(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_lot(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_lot(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_lot_order(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_lot_order(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);


EXPORT Make_dbpc(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_dbpc(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_chk_digit(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_chk_digit(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_rec_type(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_rec_type(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);


EXPORT Make_fips_st(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_fips_st(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_fips_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_fips_county(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_fips_county(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_fips_county(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_geo_lat(SALT311.StrType s0) := MakeFT_Invalid_Coor(s0);
EXPORT InValid_geo_lat(SALT311.StrType s) := InValidFT_Invalid_Coor(s);
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := InValidMessageFT_Invalid_Coor(wh);


EXPORT Make_geo_long(SALT311.StrType s0) := MakeFT_Invalid_Coor(s0);
EXPORT InValid_geo_long(SALT311.StrType s) := InValidFT_Invalid_Coor(s);
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := InValidMessageFT_Invalid_Coor(wh);


EXPORT Make_msa(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_msa(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_msa(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_geo_blk(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_geo_blk(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_geo_match(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_geo_match(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_err_stat(SALT311.StrType s0) := MakeFT_Invalid_Err(s0);
EXPORT InValid_err_stat(SALT311.StrType s) := InValidFT_Invalid_Err(s);
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := InValidMessageFT_Invalid_Err(wh);


EXPORT Make_rawaid(SALT311.StrType s0) := MakeFT_Invalid_AID(s0);
EXPORT InValid_rawaid(SALT311.StrType s) := InValidFT_Invalid_AID(s);
EXPORT InValidMessage_rawaid(UNSIGNED1 wh) := InValidMessageFT_Invalid_AID(wh);


EXPORT Make_aceaid(SALT311.StrType s0) := MakeFT_Invalid_AID(s0);
EXPORT InValid_aceaid(SALT311.StrType s) := InValidFT_Invalid_AID(s);
EXPORT InValidMessage_aceaid(UNSIGNED1 wh) := InValidMessageFT_Invalid_AID(wh);


EXPORT Make_clean_phone(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_clean_phone(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_clean_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);


EXPORT Make_clean_dob(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_clean_dob(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_clean_dob(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);

// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_IDA;
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
    BOOLEAN Diff_persistent_record_id;
    BOOLEAN Diff_src;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_did;
    BOOLEAN Diff_did_score;
    BOOLEAN Diff_orig_first_name;
    BOOLEAN Diff_orig_middle_name;
    BOOLEAN Diff_orig_last_name;
    BOOLEAN Diff_orig_suffix;
    BOOLEAN Diff_orig_address1;
    BOOLEAN Diff_orig_address2;
    BOOLEAN Diff_orig_city;
    BOOLEAN Diff_orig_state_province;
    BOOLEAN Diff_orig_zip4;
    BOOLEAN Diff_orig_zip5;
    BOOLEAN Diff_orig_dob;
    BOOLEAN Diff_orig_ssn;
    BOOLEAN Diff_orig_dl;
    BOOLEAN Diff_orig_dlstate;
    BOOLEAN Diff_orig_phone;
    BOOLEAN Diff_clientassigneduniquerecordid;
    BOOLEAN Diff_adl_ind;
    BOOLEAN Diff_orig_email;
    BOOLEAN Diff_orig_ipaddress;
    BOOLEAN Diff_orig_filecategory;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_nid;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_addr_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_p_city_name;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_cart;
    BOOLEAN Diff_cr_sort_sz;
    BOOLEAN Diff_lot;
    BOOLEAN Diff_lot_order;
    BOOLEAN Diff_dbpc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_fips_st;
    BOOLEAN Diff_fips_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_rawaid;
    BOOLEAN Diff_aceaid;
    BOOLEAN Diff_clean_phone;
    BOOLEAN Diff_clean_dob;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_persistent_record_id := le.persistent_record_id <> ri.persistent_record_id;
    SELF.Diff_src := le.src <> ri.src;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_did_score := le.did_score <> ri.did_score;
    SELF.Diff_orig_first_name := le.orig_first_name <> ri.orig_first_name;
    SELF.Diff_orig_middle_name := le.orig_middle_name <> ri.orig_middle_name;
    SELF.Diff_orig_last_name := le.orig_last_name <> ri.orig_last_name;
    SELF.Diff_orig_suffix := le.orig_suffix <> ri.orig_suffix;
    SELF.Diff_orig_address1 := le.orig_address1 <> ri.orig_address1;
    SELF.Diff_orig_address2 := le.orig_address2 <> ri.orig_address2;
    SELF.Diff_orig_city := le.orig_city <> ri.orig_city;
    SELF.Diff_orig_state_province := le.orig_state_province <> ri.orig_state_province;
    SELF.Diff_orig_zip4 := le.orig_zip4 <> ri.orig_zip4;
    SELF.Diff_orig_zip5 := le.orig_zip5 <> ri.orig_zip5;
    SELF.Diff_orig_dob := le.orig_dob <> ri.orig_dob;
    SELF.Diff_orig_ssn := le.orig_ssn <> ri.orig_ssn;
    SELF.Diff_orig_dl := le.orig_dl <> ri.orig_dl;
    SELF.Diff_orig_dlstate := le.orig_dlstate <> ri.orig_dlstate;
    SELF.Diff_orig_phone := le.orig_phone <> ri.orig_phone;
    SELF.Diff_clientassigneduniquerecordid := le.clientassigneduniquerecordid <> ri.clientassigneduniquerecordid;
    SELF.Diff_adl_ind := le.adl_ind <> ri.adl_ind;
    SELF.Diff_orig_email := le.orig_email <> ri.orig_email;
    SELF.Diff_orig_ipaddress := le.orig_ipaddress <> ri.orig_ipaddress;
    SELF.Diff_orig_filecategory := le.orig_filecategory <> ri.orig_filecategory;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_nid := le.nid <> ri.nid;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_addr_suffix := le.addr_suffix <> ri.addr_suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_p_city_name := le.p_city_name <> ri.p_city_name;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_cart := le.cart <> ri.cart;
    SELF.Diff_cr_sort_sz := le.cr_sort_sz <> ri.cr_sort_sz;
    SELF.Diff_lot := le.lot <> ri.lot;
    SELF.Diff_lot_order := le.lot_order <> ri.lot_order;
    SELF.Diff_dbpc := le.dbpc <> ri.dbpc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_fips_st := le.fips_st <> ri.fips_st;
    SELF.Diff_fips_county := le.fips_county <> ri.fips_county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_rawaid := le.rawaid <> ri.rawaid;
    SELF.Diff_aceaid := le.aceaid <> ri.aceaid;
    SELF.Diff_clean_phone := le.clean_phone <> ri.clean_phone;
    SELF.Diff_clean_dob := le.clean_dob <> ri.clean_dob;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_persistent_record_id,1,0)+ IF( SELF.Diff_src,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_did_score,1,0)+ IF( SELF.Diff_orig_first_name,1,0)+ IF( SELF.Diff_orig_middle_name,1,0)+ IF( SELF.Diff_orig_last_name,1,0)+ IF( SELF.Diff_orig_suffix,1,0)+ IF( SELF.Diff_orig_address1,1,0)+ IF( SELF.Diff_orig_address2,1,0)+ IF( SELF.Diff_orig_city,1,0)+ IF( SELF.Diff_orig_state_province,1,0)+ IF( SELF.Diff_orig_zip4,1,0)+ IF( SELF.Diff_orig_zip5,1,0)+ IF( SELF.Diff_orig_dob,1,0)+ IF( SELF.Diff_orig_ssn,1,0)+ IF( SELF.Diff_orig_dl,1,0)+ IF( SELF.Diff_orig_dlstate,1,0)+ IF( SELF.Diff_orig_phone,1,0)+ IF( SELF.Diff_clientassigneduniquerecordid,1,0)+ IF( SELF.Diff_adl_ind,1,0)+ IF( SELF.Diff_orig_email,1,0)+ IF( SELF.Diff_orig_ipaddress,1,0)+ IF( SELF.Diff_orig_filecategory,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_nid,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_fips_st,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_rawaid,1,0)+ IF( SELF.Diff_aceaid,1,0)+ IF( SELF.Diff_clean_phone,1,0)+ IF( SELF.Diff_clean_dob,1,0);
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
    Count_Diff_persistent_record_id := COUNT(GROUP,%Closest%.Diff_persistent_record_id);
    Count_Diff_src := COUNT(GROUP,%Closest%.Diff_src);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_did_score := COUNT(GROUP,%Closest%.Diff_did_score);
    Count_Diff_orig_first_name := COUNT(GROUP,%Closest%.Diff_orig_first_name);
    Count_Diff_orig_middle_name := COUNT(GROUP,%Closest%.Diff_orig_middle_name);
    Count_Diff_orig_last_name := COUNT(GROUP,%Closest%.Diff_orig_last_name);
    Count_Diff_orig_suffix := COUNT(GROUP,%Closest%.Diff_orig_suffix);
    Count_Diff_orig_address1 := COUNT(GROUP,%Closest%.Diff_orig_address1);
    Count_Diff_orig_address2 := COUNT(GROUP,%Closest%.Diff_orig_address2);
    Count_Diff_orig_city := COUNT(GROUP,%Closest%.Diff_orig_city);
    Count_Diff_orig_state_province := COUNT(GROUP,%Closest%.Diff_orig_state_province);
    Count_Diff_orig_zip4 := COUNT(GROUP,%Closest%.Diff_orig_zip4);
    Count_Diff_orig_zip5 := COUNT(GROUP,%Closest%.Diff_orig_zip5);
    Count_Diff_orig_dob := COUNT(GROUP,%Closest%.Diff_orig_dob);
    Count_Diff_orig_ssn := COUNT(GROUP,%Closest%.Diff_orig_ssn);
    Count_Diff_orig_dl := COUNT(GROUP,%Closest%.Diff_orig_dl);
    Count_Diff_orig_dlstate := COUNT(GROUP,%Closest%.Diff_orig_dlstate);
    Count_Diff_orig_phone := COUNT(GROUP,%Closest%.Diff_orig_phone);
    Count_Diff_clientassigneduniquerecordid := COUNT(GROUP,%Closest%.Diff_clientassigneduniquerecordid);
    Count_Diff_adl_ind := COUNT(GROUP,%Closest%.Diff_adl_ind);
    Count_Diff_orig_email := COUNT(GROUP,%Closest%.Diff_orig_email);
    Count_Diff_orig_ipaddress := COUNT(GROUP,%Closest%.Diff_orig_ipaddress);
    Count_Diff_orig_filecategory := COUNT(GROUP,%Closest%.Diff_orig_filecategory);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_nid := COUNT(GROUP,%Closest%.Diff_nid);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_addr_suffix := COUNT(GROUP,%Closest%.Diff_addr_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_p_city_name := COUNT(GROUP,%Closest%.Diff_p_city_name);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_cart := COUNT(GROUP,%Closest%.Diff_cart);
    Count_Diff_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_cr_sort_sz);
    Count_Diff_lot := COUNT(GROUP,%Closest%.Diff_lot);
    Count_Diff_lot_order := COUNT(GROUP,%Closest%.Diff_lot_order);
    Count_Diff_dbpc := COUNT(GROUP,%Closest%.Diff_dbpc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_fips_st := COUNT(GROUP,%Closest%.Diff_fips_st);
    Count_Diff_fips_county := COUNT(GROUP,%Closest%.Diff_fips_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_rawaid := COUNT(GROUP,%Closest%.Diff_rawaid);
    Count_Diff_aceaid := COUNT(GROUP,%Closest%.Diff_aceaid);
    Count_Diff_clean_phone := COUNT(GROUP,%Closest%.Diff_clean_phone);
    Count_Diff_clean_dob := COUNT(GROUP,%Closest%.Diff_clean_dob);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
