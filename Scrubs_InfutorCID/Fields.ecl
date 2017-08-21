IMPORT ut,SALT30;
EXPORT Fields := MODULE
// Processing for each FieldType
EXPORT SALT30.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_numseq','invalid_namealpha','invalid_alpha','invalid_date','invalid_num','invalid_orig_city','invalid_state','invalid_phone','invalid_zip','invalid_recordtype','invalid_phonetype','invalid_directindial','invalid_z4type','invalid_dpbc','invalid_crte','invalid_cnty','invalid_dpv','invalid_maildeliverabilitycode','invalid_directoryassistanceflag','invalid_telephoneconfidencescore');
EXPORT FieldTypeNum(SALT30.StrType fn) := CASE(fn,'invalid_numseq' => 1,'invalid_namealpha' => 2,'invalid_alpha' => 3,'invalid_date' => 4,'invalid_num' => 5,'invalid_orig_city' => 6,'invalid_state' => 7,'invalid_phone' => 8,'invalid_zip' => 9,'invalid_recordtype' => 10,'invalid_phonetype' => 11,'invalid_directindial' => 12,'invalid_z4type' => 13,'invalid_dpbc' => 14,'invalid_crte' => 15,'invalid_cnty' => 16,'invalid_dpv' => 17,'invalid_maildeliverabilitycode' => 18,'invalid_directoryassistanceflag' => 19,'invalid_telephoneconfidencescore' => 20,0);
EXPORT MakeFT_invalid_numseq(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'abcd0123456789-_'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numseq(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'abcd0123456789-_'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_numseq(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('abcd0123456789-_'),SALT30.HygieneErrors.NotLength('0..'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_namealpha(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 _-,./:"&\'!()#|;\\*@`'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_namealpha(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 _-,./:"&\'!()#|;\\*@`'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_namealpha(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 _-,./:"&\'!()#|;\\*@`'),SALT30.HygieneErrors.NotLength('0..'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_alpha(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -_;,"*'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -_;,"*'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -_;,"*'),SALT30.HygieneErrors.NotLength('0..'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_date(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('0,1,6,8'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_num(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_num(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_num(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('0..'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_orig_city(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 \'()&-_;.:,/#+!'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_orig_city(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 \'()&-_;.:,/#+!'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_orig_city(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 \'()&-_;.:,/#+!'),SALT30.HygieneErrors.NotLength('0..'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_state(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_state(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT30.HygieneErrors.NotLength('0,2'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_phone(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_phone(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT30.HygieneErrors.NotLength('0,10'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_zip(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('0,4,5'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_recordtype(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'RBPU'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_recordtype(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'RBPU'))),~(LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_recordtype(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('RBPU'),SALT30.HygieneErrors.NotLength('1'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_phonetype(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'LVWO'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_phonetype(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'LVWO'))),~(LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_phonetype(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('LVWO'),SALT30.HygieneErrors.NotLength('1'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_directindial(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'Y'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_directindial(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'Y'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_directindial(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('Y'),SALT30.HygieneErrors.NotLength('0,1'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_z4type(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'SHPFRG'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_z4type(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'SHPFRG'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_z4type(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('SHPFRG'),SALT30.HygieneErrors.NotLength('0,1'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_dpbc(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_dpbc(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 3));
EXPORT InValidMessageFT_invalid_dpbc(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('0..3'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_crte(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_crte(SALT30.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_invalid_crte(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotLength('0,4'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_cnty(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cnty(SALT30.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3));
EXPORT InValidMessageFT_invalid_cnty(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotLength('0,3'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_dpv(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'YDNS'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_dpv(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'YDNS'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_dpv(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('YDNS'),SALT30.HygieneErrors.NotLength('0,1'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_maildeliverabilitycode(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'YN'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_maildeliverabilitycode(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'YN'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_maildeliverabilitycode(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('YN'),SALT30.HygieneErrors.NotLength('0,1'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_directoryassistanceflag(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'YD'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_directoryassistanceflag(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'YD'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_directoryassistanceflag(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('YD'),SALT30.HygieneErrors.NotLength('0,1'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_telephoneconfidencescore(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'12345'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_telephoneconfidencescore(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'12345'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_telephoneconfidencescore(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('12345'),SALT30.HygieneErrors.NotLength('0,1'),SALT30.HygieneErrors.Good);
EXPORT SALT30.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'orig_phone','orig_phonetype','orig_directindial','orig_recordtype','orig_firstdate','orig_lastdate','orig_telconame','orig_businessname','orig_firstname','orig_mi','orig_lastname','orig_primaryhousenumber','orig_primarypredirabbrev','orig_primarystreetname','orig_primarystreettype','orig_primarypostdirabbrev','orig_secondaryapttype','orig_secondaryaptnbr','orig_city','orig_state','orig_zip','orig_zip4','orig_dpbc','orig_crte','orig_cnty','orig_z4type','orig_dpv','orig_maildeliverabilitycode','orig_addressvalidationdate','orig_filler1','orig_directoryassistanceflag','orig_telephoneconfidencescore');
EXPORT FieldNum(SALT30.StrType fn) := CASE(fn,'orig_phone' => 1,'orig_phonetype' => 2,'orig_directindial' => 3,'orig_recordtype' => 4,'orig_firstdate' => 5,'orig_lastdate' => 6,'orig_telconame' => 7,'orig_businessname' => 8,'orig_firstname' => 9,'orig_mi' => 10,'orig_lastname' => 11,'orig_primaryhousenumber' => 12,'orig_primarypredirabbrev' => 13,'orig_primarystreetname' => 14,'orig_primarystreettype' => 15,'orig_primarypostdirabbrev' => 16,'orig_secondaryapttype' => 17,'orig_secondaryaptnbr' => 18,'orig_city' => 19,'orig_state' => 20,'orig_zip' => 21,'orig_zip4' => 22,'orig_dpbc' => 23,'orig_crte' => 24,'orig_cnty' => 25,'orig_z4type' => 26,'orig_dpv' => 27,'orig_maildeliverabilitycode' => 28,'orig_addressvalidationdate' => 29,'orig_filler1' => 30,'orig_directoryassistanceflag' => 31,'orig_telephoneconfidencescore' => 32,0);
//Individual field level validation
EXPORT Make_orig_phone(SALT30.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_orig_phone(SALT30.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_orig_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
EXPORT Make_orig_phonetype(SALT30.StrType s0) := MakeFT_invalid_phonetype(s0);
EXPORT InValid_orig_phonetype(SALT30.StrType s) := InValidFT_invalid_phonetype(s);
EXPORT InValidMessage_orig_phonetype(UNSIGNED1 wh) := InValidMessageFT_invalid_phonetype(wh);
EXPORT Make_orig_directindial(SALT30.StrType s0) := MakeFT_invalid_directindial(s0);
EXPORT InValid_orig_directindial(SALT30.StrType s) := InValidFT_invalid_directindial(s);
EXPORT InValidMessage_orig_directindial(UNSIGNED1 wh) := InValidMessageFT_invalid_directindial(wh);
EXPORT Make_orig_recordtype(SALT30.StrType s0) := MakeFT_invalid_recordtype(s0);
EXPORT InValid_orig_recordtype(SALT30.StrType s) := InValidFT_invalid_recordtype(s);
EXPORT InValidMessage_orig_recordtype(UNSIGNED1 wh) := InValidMessageFT_invalid_recordtype(wh);
EXPORT Make_orig_firstdate(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_orig_firstdate(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_orig_firstdate(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_orig_lastdate(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_orig_lastdate(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_orig_lastdate(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_orig_telconame(SALT30.StrType s0) := MakeFT_invalid_namealpha(s0);
EXPORT InValid_orig_telconame(SALT30.StrType s) := InValidFT_invalid_namealpha(s);
EXPORT InValidMessage_orig_telconame(UNSIGNED1 wh) := InValidMessageFT_invalid_namealpha(wh);
EXPORT Make_orig_businessname(SALT30.StrType s0) := MakeFT_invalid_namealpha(s0);
EXPORT InValid_orig_businessname(SALT30.StrType s) := InValidFT_invalid_namealpha(s);
EXPORT InValidMessage_orig_businessname(UNSIGNED1 wh) := InValidMessageFT_invalid_namealpha(wh);
EXPORT Make_orig_firstname(SALT30.StrType s0) := MakeFT_invalid_namealpha(s0);
EXPORT InValid_orig_firstname(SALT30.StrType s) := InValidFT_invalid_namealpha(s);
EXPORT InValidMessage_orig_firstname(UNSIGNED1 wh) := InValidMessageFT_invalid_namealpha(wh);
EXPORT Make_orig_mi(SALT30.StrType s0) := MakeFT_invalid_namealpha(s0);
EXPORT InValid_orig_mi(SALT30.StrType s) := InValidFT_invalid_namealpha(s);
EXPORT InValidMessage_orig_mi(UNSIGNED1 wh) := InValidMessageFT_invalid_namealpha(wh);
EXPORT Make_orig_lastname(SALT30.StrType s0) := MakeFT_invalid_namealpha(s0);
EXPORT InValid_orig_lastname(SALT30.StrType s) := InValidFT_invalid_namealpha(s);
EXPORT InValidMessage_orig_lastname(UNSIGNED1 wh) := InValidMessageFT_invalid_namealpha(wh);
EXPORT Make_orig_primaryhousenumber(SALT30.StrType s0) := s0;
EXPORT InValid_orig_primaryhousenumber(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orig_primaryhousenumber(UNSIGNED1 wh) := '';
EXPORT Make_orig_primarypredirabbrev(SALT30.StrType s0) := s0;
EXPORT InValid_orig_primarypredirabbrev(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orig_primarypredirabbrev(UNSIGNED1 wh) := '';
EXPORT Make_orig_primarystreetname(SALT30.StrType s0) := s0;
EXPORT InValid_orig_primarystreetname(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orig_primarystreetname(UNSIGNED1 wh) := '';
EXPORT Make_orig_primarystreettype(SALT30.StrType s0) := s0;
EXPORT InValid_orig_primarystreettype(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orig_primarystreettype(UNSIGNED1 wh) := '';
EXPORT Make_orig_primarypostdirabbrev(SALT30.StrType s0) := s0;
EXPORT InValid_orig_primarypostdirabbrev(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orig_primarypostdirabbrev(UNSIGNED1 wh) := '';
EXPORT Make_orig_secondaryapttype(SALT30.StrType s0) := s0;
EXPORT InValid_orig_secondaryapttype(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orig_secondaryapttype(UNSIGNED1 wh) := '';
EXPORT Make_orig_secondaryaptnbr(SALT30.StrType s0) := s0;
EXPORT InValid_orig_secondaryaptnbr(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orig_secondaryaptnbr(UNSIGNED1 wh) := '';
EXPORT Make_orig_city(SALT30.StrType s0) := MakeFT_invalid_orig_city(s0);
EXPORT InValid_orig_city(SALT30.StrType s) := InValidFT_invalid_orig_city(s);
EXPORT InValidMessage_orig_city(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_city(wh);
EXPORT Make_orig_state(SALT30.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_orig_state(SALT30.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_orig_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
EXPORT Make_orig_zip(SALT30.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_orig_zip(SALT30.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_orig_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
EXPORT Make_orig_zip4(SALT30.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_orig_zip4(SALT30.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_orig_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
EXPORT Make_orig_dpbc(SALT30.StrType s0) := MakeFT_invalid_dpbc(s0);
EXPORT InValid_orig_dpbc(SALT30.StrType s) := InValidFT_invalid_dpbc(s);
EXPORT InValidMessage_orig_dpbc(UNSIGNED1 wh) := InValidMessageFT_invalid_dpbc(wh);
EXPORT Make_orig_crte(SALT30.StrType s0) := s0;
EXPORT InValid_orig_crte(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orig_crte(UNSIGNED1 wh) := '';
EXPORT Make_orig_cnty(SALT30.StrType s0) := s0;
EXPORT InValid_orig_cnty(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orig_cnty(UNSIGNED1 wh) := '';
EXPORT Make_orig_z4type(SALT30.StrType s0) := MakeFT_invalid_z4type(s0);
EXPORT InValid_orig_z4type(SALT30.StrType s) := InValidFT_invalid_z4type(s);
EXPORT InValidMessage_orig_z4type(UNSIGNED1 wh) := InValidMessageFT_invalid_z4type(wh);
EXPORT Make_orig_dpv(SALT30.StrType s0) := MakeFT_invalid_dpv(s0);
EXPORT InValid_orig_dpv(SALT30.StrType s) := InValidFT_invalid_dpv(s);
EXPORT InValidMessage_orig_dpv(UNSIGNED1 wh) := InValidMessageFT_invalid_dpv(wh);
EXPORT Make_orig_maildeliverabilitycode(SALT30.StrType s0) := MakeFT_invalid_maildeliverabilitycode(s0);
EXPORT InValid_orig_maildeliverabilitycode(SALT30.StrType s) := InValidFT_invalid_maildeliverabilitycode(s);
EXPORT InValidMessage_orig_maildeliverabilitycode(UNSIGNED1 wh) := InValidMessageFT_invalid_maildeliverabilitycode(wh);
EXPORT Make_orig_addressvalidationdate(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_orig_addressvalidationdate(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_orig_addressvalidationdate(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_orig_filler1(SALT30.StrType s0) := s0;
EXPORT InValid_orig_filler1(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_orig_filler1(UNSIGNED1 wh) := '';
EXPORT Make_orig_directoryassistanceflag(SALT30.StrType s0) := MakeFT_invalid_directoryassistanceflag(s0);
EXPORT InValid_orig_directoryassistanceflag(SALT30.StrType s) := InValidFT_invalid_directoryassistanceflag(s);
EXPORT InValidMessage_orig_directoryassistanceflag(UNSIGNED1 wh) := InValidMessageFT_invalid_directoryassistanceflag(wh);
EXPORT Make_orig_telephoneconfidencescore(SALT30.StrType s0) := MakeFT_invalid_telephoneconfidencescore(s0);
EXPORT InValid_orig_telephoneconfidencescore(SALT30.StrType s) := InValidFT_invalid_telephoneconfidencescore(s);
EXPORT InValidMessage_orig_telephoneconfidencescore(UNSIGNED1 wh) := InValidMessageFT_invalid_telephoneconfidencescore(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT30,Scrubs_InfutorCID;
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
    BOOLEAN Diff_orig_phone;
    BOOLEAN Diff_orig_phonetype;
    BOOLEAN Diff_orig_directindial;
    BOOLEAN Diff_orig_recordtype;
    BOOLEAN Diff_orig_firstdate;
    BOOLEAN Diff_orig_lastdate;
    BOOLEAN Diff_orig_telconame;
    BOOLEAN Diff_orig_businessname;
    BOOLEAN Diff_orig_firstname;
    BOOLEAN Diff_orig_mi;
    BOOLEAN Diff_orig_lastname;
    BOOLEAN Diff_orig_primaryhousenumber;
    BOOLEAN Diff_orig_primarypredirabbrev;
    BOOLEAN Diff_orig_primarystreetname;
    BOOLEAN Diff_orig_primarystreettype;
    BOOLEAN Diff_orig_primarypostdirabbrev;
    BOOLEAN Diff_orig_secondaryapttype;
    BOOLEAN Diff_orig_secondaryaptnbr;
    BOOLEAN Diff_orig_city;
    BOOLEAN Diff_orig_state;
    BOOLEAN Diff_orig_zip;
    BOOLEAN Diff_orig_zip4;
    BOOLEAN Diff_orig_dpbc;
    BOOLEAN Diff_orig_crte;
    BOOLEAN Diff_orig_cnty;
    BOOLEAN Diff_orig_z4type;
    BOOLEAN Diff_orig_dpv;
    BOOLEAN Diff_orig_maildeliverabilitycode;
    BOOLEAN Diff_orig_addressvalidationdate;
    BOOLEAN Diff_orig_filler1;
    BOOLEAN Diff_orig_directoryassistanceflag;
    BOOLEAN Diff_orig_telephoneconfidencescore;
    UNSIGNED Num_Diffs;
    SALT30.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_orig_phone := le.orig_phone <> ri.orig_phone;
    SELF.Diff_orig_phonetype := le.orig_phonetype <> ri.orig_phonetype;
    SELF.Diff_orig_directindial := le.orig_directindial <> ri.orig_directindial;
    SELF.Diff_orig_recordtype := le.orig_recordtype <> ri.orig_recordtype;
    SELF.Diff_orig_firstdate := le.orig_firstdate <> ri.orig_firstdate;
    SELF.Diff_orig_lastdate := le.orig_lastdate <> ri.orig_lastdate;
    SELF.Diff_orig_telconame := le.orig_telconame <> ri.orig_telconame;
    SELF.Diff_orig_businessname := le.orig_businessname <> ri.orig_businessname;
    SELF.Diff_orig_firstname := le.orig_firstname <> ri.orig_firstname;
    SELF.Diff_orig_mi := le.orig_mi <> ri.orig_mi;
    SELF.Diff_orig_lastname := le.orig_lastname <> ri.orig_lastname;
    SELF.Diff_orig_primaryhousenumber := le.orig_primaryhousenumber <> ri.orig_primaryhousenumber;
    SELF.Diff_orig_primarypredirabbrev := le.orig_primarypredirabbrev <> ri.orig_primarypredirabbrev;
    SELF.Diff_orig_primarystreetname := le.orig_primarystreetname <> ri.orig_primarystreetname;
    SELF.Diff_orig_primarystreettype := le.orig_primarystreettype <> ri.orig_primarystreettype;
    SELF.Diff_orig_primarypostdirabbrev := le.orig_primarypostdirabbrev <> ri.orig_primarypostdirabbrev;
    SELF.Diff_orig_secondaryapttype := le.orig_secondaryapttype <> ri.orig_secondaryapttype;
    SELF.Diff_orig_secondaryaptnbr := le.orig_secondaryaptnbr <> ri.orig_secondaryaptnbr;
    SELF.Diff_orig_city := le.orig_city <> ri.orig_city;
    SELF.Diff_orig_state := le.orig_state <> ri.orig_state;
    SELF.Diff_orig_zip := le.orig_zip <> ri.orig_zip;
    SELF.Diff_orig_zip4 := le.orig_zip4 <> ri.orig_zip4;
    SELF.Diff_orig_dpbc := le.orig_dpbc <> ri.orig_dpbc;
    SELF.Diff_orig_crte := le.orig_crte <> ri.orig_crte;
    SELF.Diff_orig_cnty := le.orig_cnty <> ri.orig_cnty;
    SELF.Diff_orig_z4type := le.orig_z4type <> ri.orig_z4type;
    SELF.Diff_orig_dpv := le.orig_dpv <> ri.orig_dpv;
    SELF.Diff_orig_maildeliverabilitycode := le.orig_maildeliverabilitycode <> ri.orig_maildeliverabilitycode;
    SELF.Diff_orig_addressvalidationdate := le.orig_addressvalidationdate <> ri.orig_addressvalidationdate;
    SELF.Diff_orig_filler1 := le.orig_filler1 <> ri.orig_filler1;
    SELF.Diff_orig_directoryassistanceflag := le.orig_directoryassistanceflag <> ri.orig_directoryassistanceflag;
    SELF.Diff_orig_telephoneconfidencescore := le.orig_telephoneconfidencescore <> ri.orig_telephoneconfidencescore;
    SELF.Val := (SALT30.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_orig_phone,1,0)+ IF( SELF.Diff_orig_phonetype,1,0)+ IF( SELF.Diff_orig_directindial,1,0)+ IF( SELF.Diff_orig_recordtype,1,0)+ IF( SELF.Diff_orig_firstdate,1,0)+ IF( SELF.Diff_orig_lastdate,1,0)+ IF( SELF.Diff_orig_telconame,1,0)+ IF( SELF.Diff_orig_businessname,1,0)+ IF( SELF.Diff_orig_firstname,1,0)+ IF( SELF.Diff_orig_mi,1,0)+ IF( SELF.Diff_orig_lastname,1,0)+ IF( SELF.Diff_orig_primaryhousenumber,1,0)+ IF( SELF.Diff_orig_primarypredirabbrev,1,0)+ IF( SELF.Diff_orig_primarystreetname,1,0)+ IF( SELF.Diff_orig_primarystreettype,1,0)+ IF( SELF.Diff_orig_primarypostdirabbrev,1,0)+ IF( SELF.Diff_orig_secondaryapttype,1,0)+ IF( SELF.Diff_orig_secondaryaptnbr,1,0)+ IF( SELF.Diff_orig_city,1,0)+ IF( SELF.Diff_orig_state,1,0)+ IF( SELF.Diff_orig_zip,1,0)+ IF( SELF.Diff_orig_zip4,1,0)+ IF( SELF.Diff_orig_dpbc,1,0)+ IF( SELF.Diff_orig_crte,1,0)+ IF( SELF.Diff_orig_cnty,1,0)+ IF( SELF.Diff_orig_z4type,1,0)+ IF( SELF.Diff_orig_dpv,1,0)+ IF( SELF.Diff_orig_maildeliverabilitycode,1,0)+ IF( SELF.Diff_orig_addressvalidationdate,1,0)+ IF( SELF.Diff_orig_filler1,1,0)+ IF( SELF.Diff_orig_directoryassistanceflag,1,0)+ IF( SELF.Diff_orig_telephoneconfidencescore,1,0);
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
    Count_Diff_orig_phone := COUNT(GROUP,%Closest%.Diff_orig_phone);
    Count_Diff_orig_phonetype := COUNT(GROUP,%Closest%.Diff_orig_phonetype);
    Count_Diff_orig_directindial := COUNT(GROUP,%Closest%.Diff_orig_directindial);
    Count_Diff_orig_recordtype := COUNT(GROUP,%Closest%.Diff_orig_recordtype);
    Count_Diff_orig_firstdate := COUNT(GROUP,%Closest%.Diff_orig_firstdate);
    Count_Diff_orig_lastdate := COUNT(GROUP,%Closest%.Diff_orig_lastdate);
    Count_Diff_orig_telconame := COUNT(GROUP,%Closest%.Diff_orig_telconame);
    Count_Diff_orig_businessname := COUNT(GROUP,%Closest%.Diff_orig_businessname);
    Count_Diff_orig_firstname := COUNT(GROUP,%Closest%.Diff_orig_firstname);
    Count_Diff_orig_mi := COUNT(GROUP,%Closest%.Diff_orig_mi);
    Count_Diff_orig_lastname := COUNT(GROUP,%Closest%.Diff_orig_lastname);
    Count_Diff_orig_primaryhousenumber := COUNT(GROUP,%Closest%.Diff_orig_primaryhousenumber);
    Count_Diff_orig_primarypredirabbrev := COUNT(GROUP,%Closest%.Diff_orig_primarypredirabbrev);
    Count_Diff_orig_primarystreetname := COUNT(GROUP,%Closest%.Diff_orig_primarystreetname);
    Count_Diff_orig_primarystreettype := COUNT(GROUP,%Closest%.Diff_orig_primarystreettype);
    Count_Diff_orig_primarypostdirabbrev := COUNT(GROUP,%Closest%.Diff_orig_primarypostdirabbrev);
    Count_Diff_orig_secondaryapttype := COUNT(GROUP,%Closest%.Diff_orig_secondaryapttype);
    Count_Diff_orig_secondaryaptnbr := COUNT(GROUP,%Closest%.Diff_orig_secondaryaptnbr);
    Count_Diff_orig_city := COUNT(GROUP,%Closest%.Diff_orig_city);
    Count_Diff_orig_state := COUNT(GROUP,%Closest%.Diff_orig_state);
    Count_Diff_orig_zip := COUNT(GROUP,%Closest%.Diff_orig_zip);
    Count_Diff_orig_zip4 := COUNT(GROUP,%Closest%.Diff_orig_zip4);
    Count_Diff_orig_dpbc := COUNT(GROUP,%Closest%.Diff_orig_dpbc);
    Count_Diff_orig_crte := COUNT(GROUP,%Closest%.Diff_orig_crte);
    Count_Diff_orig_cnty := COUNT(GROUP,%Closest%.Diff_orig_cnty);
    Count_Diff_orig_z4type := COUNT(GROUP,%Closest%.Diff_orig_z4type);
    Count_Diff_orig_dpv := COUNT(GROUP,%Closest%.Diff_orig_dpv);
    Count_Diff_orig_maildeliverabilitycode := COUNT(GROUP,%Closest%.Diff_orig_maildeliverabilitycode);
    Count_Diff_orig_addressvalidationdate := COUNT(GROUP,%Closest%.Diff_orig_addressvalidationdate);
    Count_Diff_orig_filler1 := COUNT(GROUP,%Closest%.Diff_orig_filler1);
    Count_Diff_orig_directoryassistanceflag := COUNT(GROUP,%Closest%.Diff_orig_directoryassistanceflag);
    Count_Diff_orig_telephoneconfidencescore := COUNT(GROUP,%Closest%.Diff_orig_telephoneconfidencescore);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
