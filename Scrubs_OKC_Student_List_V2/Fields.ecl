﻿IMPORT ut,SALT33;
EXPORT Fields := MODULE
// Processing for each FieldType
EXPORT SALT33.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','nums','lowercase','uppercase','alphas','lowercaseandnums','uppercaseandnums','alphasandnums','allupper','blank','invalid_blank','invalid_collegeid','invalid_projectsource','invalid_studentID','invalid_date','invalid_AttendanceDate','invalid_phone','invalid_phonetyp','invalid_firstname','invalid_lastname','invalid_name','invalid_suffix','invalid_college','invalid_address','invalid_cleanaddress','invalid_city','invalid_state','invalid_zip','invalid_semester','invalid_email','invalid_addresstype');
EXPORT FieldTypeNum(SALT33.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'nums' => 2,'lowercase' => 3,'uppercase' => 4,'alphas' => 5,'lowercaseandnums' => 6,'uppercaseandnums' => 7,'alphasandnums' => 8,'allupper' => 9,'blank' => 10,'invalid_blank' => 11,'invalid_collegeid' => 12,'invalid_projectsource' => 13,'invalid_studentID' => 14,'invalid_date' => 15,'invalid_AttendanceDate' => 16,'invalid_phone' => 17,'invalid_phonetyp' => 18,'invalid_firstname' => 19,'invalid_lastname' => 20,'invalid_name' => 21,'invalid_suffix' => 22,'invalid_college' => 23,'invalid_address' => 24,'invalid_cleanaddress' => 25,'invalid_city' => 26,'invalid_state' => 27,'invalid_zip' => 28,'invalid_semester' => 29,'invalid_email' => 30,'invalid_addresstype' => 31,0);
EXPORT MakeFT_invalid_mandatory(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT33.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotLength('1..'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_nums(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_nums(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_nums(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_lowercase(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'abcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_lowercase(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'abcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_lowercase(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyz'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_uppercase(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_uppercase(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_uppercase(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_alphas(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_alphas(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_alphas(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_lowercaseandnums(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'abcdefghijklmnopqrstuvwxyz0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_lowercaseandnums(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'abcdefghijklmnopqrstuvwxyz0123456789'))));
EXPORT InValidMessageFT_lowercaseandnums(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyz0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_uppercaseandnums(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_uppercaseandnums(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))));
EXPORT InValidMessageFT_uppercaseandnums(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_alphasandnums(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_alphasandnums(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'))));
EXPORT InValidMessageFT_alphasandnums(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_allupper(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZÅÉÑÕÚÜÍáãñóöé'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_allupper(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZÅÉÑÕÚÜÍáãñóöé'))));
EXPORT InValidMessageFT_allupper(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZÅÉÑÕÚÜÍáãñóöé'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_blank(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_blank(SALT33.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotLength('0'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_blank(SALT33.StrType s0) := FUNCTION
  RETURN  MakeFT_blank(s0);
END;
EXPORT InValidFT_invalid_blank(SALT33.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotLength('0'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_collegeid(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_nums(s1);
END;
EXPORT InValidFT_invalid_collegeid(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_invalid_collegeid(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.NotLength('5'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_projectsource(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_projectsource(SALT33.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_projectsource(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotLength('1..'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_studentID(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_nums(s1);
END;
EXPORT InValidFT_invalid_studentID(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_studentID(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.NotLength('1..'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_date(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT33.stringcleanspaces( SALT33.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_nums(s2);
END;
EXPORT InValidFT_invalid_date(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789 '),SALT33.HygieneErrors.NotLength('0,8'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_AttendanceDate(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,' /;0123456789SPRINGUMEFALTW'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_AttendanceDate(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,' /;0123456789SPRINGUMEFALTW'))));
EXPORT InValidMessageFT_invalid_AttendanceDate(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars(' /;0123456789SPRINGUMEFALTW'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_phone(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789()-+'); // Only allow valid symbols
  s2 := SALT33.stringcleanspaces( SALT33.stringsubstituteout(s1,'()-+',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_nums(s2);
END;
EXPORT InValidFT_invalid_phone(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789()-+'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 9 AND LENGTH(TRIM(s)) <= 15));
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789()-+'),SALT33.HygieneErrors.NotLength('0,9..15'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_phonetyp(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phonetyp(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['HOME','CELL','OTHER','']);
EXPORT InValidMessageFT_invalid_phonetyp(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('HOME|CELL|OTHER|'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_firstname(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZÅÉÑÕÚÜÍáãñóöé -,&\\/.:;`\'()_+'); // Only allow valid symbols
  s2 := SALT33.stringcleanspaces( SALT33.stringsubstituteout(s1,' -,&\\/.:;`\'()_+',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_allupper(s2);
END;
EXPORT InValidFT_invalid_firstname(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZÅÉÑÕÚÜÍáãñóöé -,&\\/.:;`\'()_+'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_firstname(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZÅÉÑÕÚÜÍáãñóöé -,&\\/.:;`\'()_+'),SALT33.HygieneErrors.NotLength('1..'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_lastname(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZÅÉÑÕÚÜÍáãñóöé -,&\\/.:;`\'()_+'); // Only allow valid symbols
  s2 := SALT33.stringcleanspaces( SALT33.stringsubstituteout(s1,' -,&\\/.:;`\'()_+',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_allupper(s2);
END;
EXPORT InValidFT_invalid_lastname(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZÅÉÑÕÚÜÍáãñóöé -,&\\/.:;`\'()_+'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_lastname(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZÅÉÑÕÚÜÍáãñóöé -,&\\/.:;`\'()_+'),SALT33.HygieneErrors.NotLength('1..'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_name(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZÅÉÑÕÚÜÍáãñóöé -,&\\/.:;`\'()_+'); // Only allow valid symbols
  s2 := SALT33.stringcleanspaces( SALT33.stringsubstituteout(s1,' -,&\\/.:;`\'()_+',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_allupper(s2);
END;
EXPORT InValidFT_invalid_name(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZÅÉÑÕÚÜÍáãñóöé -,&\\/.:;`\'()_+'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZÅÉÑÕÚÜÍáãñóöé -,&\\/.:;`\'()_+'),SALT33.HygieneErrors.NotLength('0..'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_suffix(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_suffix(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_college(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -&/./()'); // Only allow valid symbols
  s2 := SALT33.stringcleanspaces( SALT33.stringsubstituteout(s1,' -&/./',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_alphasandnums(s2);
END;
EXPORT InValidFT_invalid_college(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -&/./()'))));
EXPORT InValidMessageFT_invalid_college(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -&/./()'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_address(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,-.()\':;"&#/'); // Only allow valid symbols
  s2 := SALT33.stringcleanspaces( SALT33.stringsubstituteout(s1,' ,-.()\':;"&#/',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercaseandnums(s2);
END;
EXPORT InValidFT_invalid_address(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,-.()\':;"&#/'))));
EXPORT InValidMessageFT_invalid_address(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,-.()\':;"&#/'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_cleanaddress(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,-.()\':;"&#/'); // Only allow valid symbols
  s2 := SALT33.stringcleanspaces( SALT33.stringsubstituteout(s1,' ,-.()\':;"&#/',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_invalid_address(s2);
END;
EXPORT InValidFT_invalid_cleanaddress(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,-.()\':;"&#/'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_cleanaddress(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,-.()\':;"&#/'),SALT33.HygieneErrors.NotLength('1..'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_city(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ .\'-,'); // Only allow valid symbols
  s2 := SALT33.stringcleanspaces( SALT33.stringsubstituteout(s1,' .\'-,',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercase(s2);
END;
EXPORT InValidFT_invalid_city(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ .\'-,'))));
EXPORT InValidMessageFT_invalid_city(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ .\'-,'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_state(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  MakeFT_uppercase(s1);
END;
EXPORT InValidFT_invalid_state(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT33.HygieneErrors.NotLength('0,2'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_zip(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_nums(s1);
END;
EXPORT InValidFT_invalid_zip(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.NotLength('5,9'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_semester(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_semester(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['SPRING','SUMMER','FALL','AUTUMN','WINTER',''],~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 6));
EXPORT InValidMessageFT_invalid_semester(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('SPRING|SUMMER|FALL|AUTUMN|WINTER|'),SALT33.HygieneErrors.NotLength('0,4,6'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_email(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.@-_,|'); // Only allow valid symbols
  s2 := SALT33.stringcleanspaces( SALT33.stringsubstituteout(s1,'.@-_',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_alphasandnums(s2);
END;
EXPORT InValidFT_invalid_email(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.@-_,|'))));
EXPORT InValidMessageFT_invalid_email(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.@-_,|'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_addresstype(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_addresstype(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['CURRENT','PERMANENT','DORM','HOME','']);
EXPORT InValidMessageFT_invalid_addresstype(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('CURRENT|Permanent|DORM|HOME|'),SALT33.HygieneErrors.Good);
EXPORT SALT33.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'cleanaddr1','cleanaddr2','cleanattendancedte','cleancity','cleanstate','cleandob','cleanupdatedte','cleanemail','append_email_username','append_domain','append_domain_type','append_domain_root','append_domain_ext','append_is_tld_state','append_is_tld_generic','append_is_tld_country','append_is_valid_domain_ext','cleancollegeID','cleantitle','cleanfirstname','cleanmidname','cleanlastname','cleansuffixname','cleanzip','cleanzip4','cleanmajor','cleanphone','rcid','did','process_date','date_first_seen','date_last_seen','vendor_first_reported','vendor_last_reported','dateupdated','studentid','dartid','collegeid','projectsource','collegestate','college','semester','year','firstname','middlename','lastname','suffix','major','grade','email','dateofbirth','dob_formatted','attendancedate','enrollmentstatus','addresstype','address1','address2','city','state','zip','zip4','phonetyp','phonenumber','tier','school_size_code','competitive_code','tuition_code','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','z5','z4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','telephone','tier2','source');
EXPORT FieldNum(SALT33.StrType fn) := CASE(fn,'cleanaddr1' => 0,'cleanaddr2' => 1,'cleanattendancedte' => 2,'cleancity' => 3,'cleanstate' => 4,'cleandob' => 5,'cleanupdatedte' => 6,'cleanemail' => 7,'append_email_username' => 8,'append_domain' => 9,'append_domain_type' => 10,'append_domain_root' => 11,'append_domain_ext' => 12,'append_is_tld_state' => 13,'append_is_tld_generic' => 14,'append_is_tld_country' => 15,'append_is_valid_domain_ext' => 16,'cleancollegeID' => 17,'cleantitle' => 18,'cleanfirstname' => 19,'cleanmidname' => 20,'cleanlastname' => 21,'cleansuffixname' => 22,'cleanzip' => 23,'cleanzip4' => 24,'cleanmajor' => 25,'cleanphone' => 26,'rcid' => 27,'did' => 28,'process_date' => 29,'date_first_seen' => 30,'date_last_seen' => 31,'vendor_first_reported' => 32,'vendor_last_reported' => 33,'dateupdated' => 34,'studentid' => 35,'dartid' => 36,'collegeid' => 37,'projectsource' => 38,'collegestate' => 39,'college' => 40,'semester' => 41,'year' => 42,'firstname' => 43,'middlename' => 44,'lastname' => 45,'suffix' => 46,'major' => 47,'grade' => 48,'email' => 49,'dateofbirth' => 50,'dob_formatted' => 51,'attendancedate' => 52,'enrollmentstatus' => 53,'addresstype' => 54,'address1' => 55,'address2' => 56,'city' => 57,'state' => 58,'zip' => 59,'zip4' => 60,'phonetyp' => 61,'phonenumber' => 62,'tier' => 63,'school_size_code' => 64,'competitive_code' => 65,'tuition_code' => 66,'title' => 67,'fname' => 68,'mname' => 69,'lname' => 70,'name_suffix' => 71,'name_score' => 72,'prim_range' => 73,'predir' => 74,'prim_name' => 75,'addr_suffix' => 76,'postdir' => 77,'unit_desig' => 78,'sec_range' => 79,'p_city_name' => 80,'v_city_name' => 81,'st' => 82,'z5' => 83,'z4' => 84,'cart' => 85,'cr_sort_sz' => 86,'lot' => 87,'lot_order' => 88,'dbpc' => 89,'chk_digit' => 90,'rec_type' => 91,'county' => 92,'fips_state' => 93,'fips_county' => 94,'geo_lat' => 95,'geo_long' => 96,'msa' => 97,'geo_blk' => 98,'geo_match' => 99,'err_stat' => 100,'telephone' => 101,'tier2' => 102,'source' => 103,0);
//Individual field level validation
EXPORT Make_cleanaddr1(SALT33.StrType s0) := MakeFT_invalid_cleanaddress(s0);
EXPORT InValid_cleanaddr1(SALT33.StrType s) := InValidFT_invalid_cleanaddress(s);
EXPORT InValidMessage_cleanaddr1(UNSIGNED1 wh) := InValidMessageFT_invalid_cleanaddress(wh);
EXPORT Make_cleanaddr2(SALT33.StrType s0) := MakeFT_invalid_cleanaddress(s0);
EXPORT InValid_cleanaddr2(SALT33.StrType s) := InValidFT_invalid_cleanaddress(s);
EXPORT InValidMessage_cleanaddr2(UNSIGNED1 wh) := InValidMessageFT_invalid_cleanaddress(wh);
EXPORT Make_cleanattendancedte(SALT33.StrType s0) := s0;
EXPORT InValid_cleanattendancedte(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_cleanattendancedte(UNSIGNED1 wh) := '';
EXPORT Make_cleancity(SALT33.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_cleancity(SALT33.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_cleancity(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);
EXPORT Make_cleanstate(SALT33.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_cleanstate(SALT33.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_cleanstate(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
EXPORT Make_cleandob(SALT33.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_cleandob(SALT33.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_cleandob(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_cleanupdatedte(SALT33.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_cleanupdatedte(SALT33.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_cleanupdatedte(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_cleanemail(SALT33.StrType s0) := MakeFT_invalid_email(s0);
EXPORT InValid_cleanemail(SALT33.StrType s) := InValidFT_invalid_email(s);
EXPORT InValidMessage_cleanemail(UNSIGNED1 wh) := InValidMessageFT_invalid_email(wh);
EXPORT Make_append_email_username(SALT33.StrType s0) := s0;
EXPORT InValid_append_email_username(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_append_email_username(UNSIGNED1 wh) := '';
EXPORT Make_append_domain(SALT33.StrType s0) := s0;
EXPORT InValid_append_domain(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_append_domain(UNSIGNED1 wh) := '';
EXPORT Make_append_domain_type(SALT33.StrType s0) := s0;
EXPORT InValid_append_domain_type(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_append_domain_type(UNSIGNED1 wh) := '';
EXPORT Make_append_domain_root(SALT33.StrType s0) := s0;
EXPORT InValid_append_domain_root(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_append_domain_root(UNSIGNED1 wh) := '';
EXPORT Make_append_domain_ext(SALT33.StrType s0) := s0;
EXPORT InValid_append_domain_ext(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_append_domain_ext(UNSIGNED1 wh) := '';
EXPORT Make_append_is_tld_state(SALT33.StrType s0) := s0;
EXPORT InValid_append_is_tld_state(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_append_is_tld_state(UNSIGNED1 wh) := '';
EXPORT Make_append_is_tld_generic(SALT33.StrType s0) := s0;
EXPORT InValid_append_is_tld_generic(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_append_is_tld_generic(UNSIGNED1 wh) := '';
EXPORT Make_append_is_tld_country(SALT33.StrType s0) := s0;
EXPORT InValid_append_is_tld_country(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_append_is_tld_country(UNSIGNED1 wh) := '';
EXPORT Make_append_is_valid_domain_ext(SALT33.StrType s0) := s0;
EXPORT InValid_append_is_valid_domain_ext(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_append_is_valid_domain_ext(UNSIGNED1 wh) := '';
EXPORT Make_cleancollegeID(SALT33.StrType s0) := MakeFT_invalid_collegeid(s0);
EXPORT InValid_cleancollegeID(SALT33.StrType s) := InValidFT_invalid_collegeid(s);
EXPORT InValidMessage_cleancollegeID(UNSIGNED1 wh) := InValidMessageFT_invalid_collegeid(wh);
EXPORT Make_cleantitle(SALT33.StrType s0) := s0;
EXPORT InValid_cleantitle(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_cleantitle(UNSIGNED1 wh) := '';
EXPORT Make_cleanfirstname(SALT33.StrType s0) := MakeFT_invalid_firstname(s0);
EXPORT InValid_cleanfirstname(SALT33.StrType s) := InValidFT_invalid_firstname(s);
EXPORT InValidMessage_cleanfirstname(UNSIGNED1 wh) := InValidMessageFT_invalid_firstname(wh);
EXPORT Make_cleanmidname(SALT33.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_cleanmidname(SALT33.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_cleanmidname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_cleanlastname(SALT33.StrType s0) := MakeFT_invalid_lastname(s0);
EXPORT InValid_cleanlastname(SALT33.StrType s) := InValidFT_invalid_lastname(s);
EXPORT InValidMessage_cleanlastname(UNSIGNED1 wh) := InValidMessageFT_invalid_lastname(wh);
EXPORT Make_cleansuffixname(SALT33.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_cleansuffixname(SALT33.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_cleansuffixname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_cleanzip(SALT33.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_cleanzip(SALT33.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_cleanzip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
EXPORT Make_cleanzip4(SALT33.StrType s0) := s0;
EXPORT InValid_cleanzip4(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_cleanzip4(UNSIGNED1 wh) := '';
EXPORT Make_cleanmajor(SALT33.StrType s0) := s0;
EXPORT InValid_cleanmajor(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_cleanmajor(UNSIGNED1 wh) := '';
EXPORT Make_cleanphone(SALT33.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_cleanphone(SALT33.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_cleanphone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
EXPORT Make_rcid(SALT33.StrType s0) := s0;
EXPORT InValid_rcid(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_rcid(UNSIGNED1 wh) := '';
EXPORT Make_did(SALT33.StrType s0) := s0;
EXPORT InValid_did(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_did(UNSIGNED1 wh) := '';
EXPORT Make_process_date(SALT33.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_process_date(SALT33.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_date_first_seen(SALT33.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_first_seen(SALT33.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_date_last_seen(SALT33.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_last_seen(SALT33.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_vendor_first_reported(SALT33.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_vendor_first_reported(SALT33.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_vendor_last_reported(SALT33.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_vendor_last_reported(SALT33.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_dateupdated(SALT33.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dateupdated(SALT33.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dateupdated(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_studentid(SALT33.StrType s0) := MakeFT_invalid_studentID(s0);
EXPORT InValid_studentid(SALT33.StrType s) := InValidFT_invalid_studentID(s);
EXPORT InValidMessage_studentid(UNSIGNED1 wh) := InValidMessageFT_invalid_studentID(wh);
EXPORT Make_dartid(SALT33.StrType s0) := MakeFT_nums(s0);
EXPORT InValid_dartid(SALT33.StrType s) := InValidFT_nums(s);
EXPORT InValidMessage_dartid(UNSIGNED1 wh) := InValidMessageFT_nums(wh);
EXPORT Make_collegeid(SALT33.StrType s0) := s0;
EXPORT InValid_collegeid(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_collegeid(UNSIGNED1 wh) := '';
EXPORT Make_projectsource(SALT33.StrType s0) := MakeFT_invalid_projectsource(s0);
EXPORT InValid_projectsource(SALT33.StrType s) := InValidFT_invalid_projectsource(s);
EXPORT InValidMessage_projectsource(UNSIGNED1 wh) := InValidMessageFT_invalid_projectsource(wh);
EXPORT Make_collegestate(SALT33.StrType s0) := s0;
EXPORT InValid_collegestate(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_collegestate(UNSIGNED1 wh) := '';
EXPORT Make_college(SALT33.StrType s0) := MakeFT_invalid_college(s0);
EXPORT InValid_college(SALT33.StrType s) := InValidFT_invalid_college(s);
EXPORT InValidMessage_college(UNSIGNED1 wh) := InValidMessageFT_invalid_college(wh);
EXPORT Make_semester(SALT33.StrType s0) := MakeFT_invalid_semester(s0);
EXPORT InValid_semester(SALT33.StrType s) := InValidFT_invalid_semester(s);
EXPORT InValidMessage_semester(UNSIGNED1 wh) := InValidMessageFT_invalid_semester(wh);
EXPORT Make_year(SALT33.StrType s0) := MakeFT_nums(s0);
EXPORT InValid_year(SALT33.StrType s) := InValidFT_nums(s);
EXPORT InValidMessage_year(UNSIGNED1 wh) := InValidMessageFT_nums(wh);
EXPORT Make_firstname(SALT33.StrType s0) := s0;
EXPORT InValid_firstname(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_firstname(UNSIGNED1 wh) := '';
EXPORT Make_middlename(SALT33.StrType s0) := s0;
EXPORT InValid_middlename(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_middlename(UNSIGNED1 wh) := '';
EXPORT Make_lastname(SALT33.StrType s0) := s0;
EXPORT InValid_lastname(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_lastname(UNSIGNED1 wh) := '';
EXPORT Make_suffix(SALT33.StrType s0) := s0;
EXPORT InValid_suffix(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := '';
EXPORT Make_major(SALT33.StrType s0) := s0;
EXPORT InValid_major(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_major(UNSIGNED1 wh) := '';
EXPORT Make_grade(SALT33.StrType s0) := s0;
EXPORT InValid_grade(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_grade(UNSIGNED1 wh) := '';
EXPORT Make_email(SALT33.StrType s0) := s0;
EXPORT InValid_email(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_email(UNSIGNED1 wh) := '';
EXPORT Make_dateofbirth(SALT33.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dateofbirth(SALT33.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dateofbirth(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_dob_formatted(SALT33.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dob_formatted(SALT33.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dob_formatted(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_attendancedate(SALT33.StrType s0) := s0;
EXPORT InValid_attendancedate(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_attendancedate(UNSIGNED1 wh) := '';
EXPORT Make_enrollmentstatus(SALT33.StrType s0) := s0;
EXPORT InValid_enrollmentstatus(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_enrollmentstatus(UNSIGNED1 wh) := '';
EXPORT Make_addresstype(SALT33.StrType s0) := MakeFT_invalid_addresstype(s0);
EXPORT InValid_addresstype(SALT33.StrType s) := InValidFT_invalid_addresstype(s);
EXPORT InValidMessage_addresstype(UNSIGNED1 wh) := InValidMessageFT_invalid_addresstype(wh);
EXPORT Make_address1(SALT33.StrType s0) := s0;
EXPORT InValid_address1(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_address1(UNSIGNED1 wh) := '';
EXPORT Make_address2(SALT33.StrType s0) := s0;
EXPORT InValid_address2(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_address2(UNSIGNED1 wh) := '';
EXPORT Make_city(SALT33.StrType s0) := s0;
EXPORT InValid_city(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_city(UNSIGNED1 wh) := '';
EXPORT Make_state(SALT33.StrType s0) := s0;
EXPORT InValid_state(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_state(UNSIGNED1 wh) := '';
EXPORT Make_zip(SALT33.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_zip(SALT33.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
EXPORT Make_zip4(SALT33.StrType s0) := s0;
EXPORT InValid_zip4(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := '';
EXPORT Make_phonetyp(SALT33.StrType s0) := MakeFT_invalid_phonetyp(s0);
EXPORT InValid_phonetyp(SALT33.StrType s) := InValidFT_invalid_phonetyp(s);
EXPORT InValidMessage_phonetyp(UNSIGNED1 wh) := InValidMessageFT_invalid_phonetyp(wh);
EXPORT Make_phonenumber(SALT33.StrType s0) := s0;
EXPORT InValid_phonenumber(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_phonenumber(UNSIGNED1 wh) := '';
EXPORT Make_tier(SALT33.StrType s0) := s0;
EXPORT InValid_tier(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_tier(UNSIGNED1 wh) := '';
EXPORT Make_school_size_code(SALT33.StrType s0) := s0;
EXPORT InValid_school_size_code(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_school_size_code(UNSIGNED1 wh) := '';
EXPORT Make_competitive_code(SALT33.StrType s0) := s0;
EXPORT InValid_competitive_code(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_competitive_code(UNSIGNED1 wh) := '';
EXPORT Make_tuition_code(SALT33.StrType s0) := s0;
EXPORT InValid_tuition_code(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_tuition_code(UNSIGNED1 wh) := '';
EXPORT Make_title(SALT33.StrType s0) := s0;
EXPORT InValid_title(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
EXPORT Make_fname(SALT33.StrType s0) := s0;
EXPORT InValid_fname(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_fname(UNSIGNED1 wh) := '';
EXPORT Make_mname(SALT33.StrType s0) := s0;
EXPORT InValid_mname(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
EXPORT Make_lname(SALT33.StrType s0) := s0;
EXPORT InValid_lname(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_lname(UNSIGNED1 wh) := '';
EXPORT Make_name_suffix(SALT33.StrType s0) := MakeFT_invalid_suffix(s0);
EXPORT InValid_name_suffix(SALT33.StrType s) := InValidFT_invalid_suffix(s);
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_suffix(wh);
EXPORT Make_name_score(SALT33.StrType s0) := s0;
EXPORT InValid_name_score(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_name_score(UNSIGNED1 wh) := '';
EXPORT Make_prim_range(SALT33.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_prim_range(SALT33.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_predir(SALT33.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_predir(SALT33.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_prim_name(SALT33.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prim_name(SALT33.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
EXPORT Make_addr_suffix(SALT33.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_suffix(SALT33.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_postdir(SALT33.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_postdir(SALT33.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_unit_desig(SALT33.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_unit_desig(SALT33.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_sec_range(SALT33.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_sec_range(SALT33.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_p_city_name(SALT33.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_p_city_name(SALT33.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);
EXPORT Make_v_city_name(SALT33.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_v_city_name(SALT33.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);
EXPORT Make_st(SALT33.StrType s0) := s0;
EXPORT InValid_st(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_st(UNSIGNED1 wh) := '';
EXPORT Make_z5(SALT33.StrType s0) := s0;
EXPORT InValid_z5(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_z5(UNSIGNED1 wh) := '';
EXPORT Make_z4(SALT33.StrType s0) := s0;
EXPORT InValid_z4(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_z4(UNSIGNED1 wh) := '';
EXPORT Make_cart(SALT33.StrType s0) := s0;
EXPORT InValid_cart(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_cart(UNSIGNED1 wh) := '';
EXPORT Make_cr_sort_sz(SALT33.StrType s0) := s0;
EXPORT InValid_cr_sort_sz(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := '';
EXPORT Make_lot(SALT33.StrType s0) := s0;
EXPORT InValid_lot(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_lot(UNSIGNED1 wh) := '';
EXPORT Make_lot_order(SALT33.StrType s0) := s0;
EXPORT InValid_lot_order(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := '';
EXPORT Make_dbpc(SALT33.StrType s0) := s0;
EXPORT InValid_dbpc(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := '';
EXPORT Make_chk_digit(SALT33.StrType s0) := s0;
EXPORT InValid_chk_digit(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := '';
EXPORT Make_rec_type(SALT33.StrType s0) := s0;
EXPORT InValid_rec_type(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := '';
EXPORT Make_county(SALT33.StrType s0) := s0;
EXPORT InValid_county(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_county(UNSIGNED1 wh) := '';
EXPORT Make_fips_state(SALT33.StrType s0) := s0;
EXPORT InValid_fips_state(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_fips_state(UNSIGNED1 wh) := '';
EXPORT Make_fips_county(SALT33.StrType s0) := s0;
EXPORT InValid_fips_county(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_fips_county(UNSIGNED1 wh) := '';
EXPORT Make_geo_lat(SALT33.StrType s0) := s0;
EXPORT InValid_geo_lat(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := '';
EXPORT Make_geo_long(SALT33.StrType s0) := s0;
EXPORT InValid_geo_long(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := '';
EXPORT Make_msa(SALT33.StrType s0) := s0;
EXPORT InValid_msa(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_msa(UNSIGNED1 wh) := '';
EXPORT Make_geo_blk(SALT33.StrType s0) := s0;
EXPORT InValid_geo_blk(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := '';
EXPORT Make_geo_match(SALT33.StrType s0) := s0;
EXPORT InValid_geo_match(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := '';
EXPORT Make_err_stat(SALT33.StrType s0) := s0;
EXPORT InValid_err_stat(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := '';
EXPORT Make_telephone(SALT33.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_telephone(SALT33.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_telephone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
EXPORT Make_tier2(SALT33.StrType s0) := s0;
EXPORT InValid_tier2(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_tier2(UNSIGNED1 wh) := '';
EXPORT Make_source(SALT33.StrType s0) := s0;
EXPORT InValid_source(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_source(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT33,Scrubs_OKC_Student_List_V2;
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
    BOOLEAN Diff_cleanaddr1;
    BOOLEAN Diff_cleanaddr2;
    BOOLEAN Diff_cleanattendancedte;
    BOOLEAN Diff_cleancity;
    BOOLEAN Diff_cleanstate;
    BOOLEAN Diff_cleandob;
    BOOLEAN Diff_cleanupdatedte;
    BOOLEAN Diff_cleanemail;
    BOOLEAN Diff_append_email_username;
    BOOLEAN Diff_append_domain;
    BOOLEAN Diff_append_domain_type;
    BOOLEAN Diff_append_domain_root;
    BOOLEAN Diff_append_domain_ext;
    BOOLEAN Diff_append_is_tld_state;
    BOOLEAN Diff_append_is_tld_generic;
    BOOLEAN Diff_append_is_tld_country;
    BOOLEAN Diff_append_is_valid_domain_ext;
    BOOLEAN Diff_cleancollegeID;
    BOOLEAN Diff_cleantitle;
    BOOLEAN Diff_cleanfirstname;
    BOOLEAN Diff_cleanmidname;
    BOOLEAN Diff_cleanlastname;
    BOOLEAN Diff_cleansuffixname;
    BOOLEAN Diff_cleanzip;
    BOOLEAN Diff_cleanzip4;
    BOOLEAN Diff_cleanmajor;
    BOOLEAN Diff_cleanphone;
    BOOLEAN Diff_rcid;
    BOOLEAN Diff_did;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_date_first_seen;
    BOOLEAN Diff_date_last_seen;
    BOOLEAN Diff_vendor_first_reported;
    BOOLEAN Diff_vendor_last_reported;
    BOOLEAN Diff_dateupdated;
    BOOLEAN Diff_studentid;
    BOOLEAN Diff_dartid;
    BOOLEAN Diff_collegeid;
    BOOLEAN Diff_projectsource;
    BOOLEAN Diff_collegestate;
    BOOLEAN Diff_college;
    BOOLEAN Diff_semester;
    BOOLEAN Diff_year;
    BOOLEAN Diff_firstname;
    BOOLEAN Diff_middlename;
    BOOLEAN Diff_lastname;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_major;
    BOOLEAN Diff_grade;
    BOOLEAN Diff_email;
    BOOLEAN Diff_dateofbirth;
    BOOLEAN Diff_dob_formatted;
    BOOLEAN Diff_attendancedate;
    BOOLEAN Diff_enrollmentstatus;
    BOOLEAN Diff_addresstype;
    BOOLEAN Diff_address1;
    BOOLEAN Diff_address2;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_phonetyp;
    BOOLEAN Diff_phonenumber;
    BOOLEAN Diff_tier;
    BOOLEAN Diff_school_size_code;
    BOOLEAN Diff_competitive_code;
    BOOLEAN Diff_tuition_code;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_name_score;
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
    BOOLEAN Diff_z5;
    BOOLEAN Diff_z4;
    BOOLEAN Diff_cart;
    BOOLEAN Diff_cr_sort_sz;
    BOOLEAN Diff_lot;
    BOOLEAN Diff_lot_order;
    BOOLEAN Diff_dbpc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_county;
    BOOLEAN Diff_fips_state;
    BOOLEAN Diff_fips_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_telephone;
    BOOLEAN Diff_tier2;
    BOOLEAN Diff_source;
    SALT33.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT33.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_cleanaddr1 := le.cleanaddr1 <> ri.cleanaddr1;
    SELF.Diff_cleanaddr2 := le.cleanaddr2 <> ri.cleanaddr2;
    SELF.Diff_cleanattendancedte := le.cleanattendancedte <> ri.cleanattendancedte;
    SELF.Diff_cleancity := le.cleancity <> ri.cleancity;
    SELF.Diff_cleanstate := le.cleanstate <> ri.cleanstate;
    SELF.Diff_cleandob := le.cleandob <> ri.cleandob;
    SELF.Diff_cleanupdatedte := le.cleanupdatedte <> ri.cleanupdatedte;
    SELF.Diff_cleanemail := le.cleanemail <> ri.cleanemail;
    SELF.Diff_append_email_username := le.append_email_username <> ri.append_email_username;
    SELF.Diff_append_domain := le.append_domain <> ri.append_domain;
    SELF.Diff_append_domain_type := le.append_domain_type <> ri.append_domain_type;
    SELF.Diff_append_domain_root := le.append_domain_root <> ri.append_domain_root;
    SELF.Diff_append_domain_ext := le.append_domain_ext <> ri.append_domain_ext;
    SELF.Diff_append_is_tld_state := le.append_is_tld_state <> ri.append_is_tld_state;
    SELF.Diff_append_is_tld_generic := le.append_is_tld_generic <> ri.append_is_tld_generic;
    SELF.Diff_append_is_tld_country := le.append_is_tld_country <> ri.append_is_tld_country;
    SELF.Diff_append_is_valid_domain_ext := le.append_is_valid_domain_ext <> ri.append_is_valid_domain_ext;
    SELF.Diff_cleancollegeID := le.cleancollegeID <> ri.cleancollegeID;
    SELF.Diff_cleantitle := le.cleantitle <> ri.cleantitle;
    SELF.Diff_cleanfirstname := le.cleanfirstname <> ri.cleanfirstname;
    SELF.Diff_cleanmidname := le.cleanmidname <> ri.cleanmidname;
    SELF.Diff_cleanlastname := le.cleanlastname <> ri.cleanlastname;
    SELF.Diff_cleansuffixname := le.cleansuffixname <> ri.cleansuffixname;
    SELF.Diff_cleanzip := le.cleanzip <> ri.cleanzip;
    SELF.Diff_cleanzip4 := le.cleanzip4 <> ri.cleanzip4;
    SELF.Diff_cleanmajor := le.cleanmajor <> ri.cleanmajor;
    SELF.Diff_cleanphone := le.cleanphone <> ri.cleanphone;
    SELF.Diff_rcid := le.rcid <> ri.rcid;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_date_first_seen := le.date_first_seen <> ri.date_first_seen;
    SELF.Diff_date_last_seen := le.date_last_seen <> ri.date_last_seen;
    SELF.Diff_vendor_first_reported := le.vendor_first_reported <> ri.vendor_first_reported;
    SELF.Diff_vendor_last_reported := le.vendor_last_reported <> ri.vendor_last_reported;
    SELF.Diff_dateupdated := le.dateupdated <> ri.dateupdated;
    SELF.Diff_studentid := le.studentid <> ri.studentid;
    SELF.Diff_dartid := le.dartid <> ri.dartid;
    SELF.Diff_collegeid := le.collegeid <> ri.collegeid;
    SELF.Diff_projectsource := le.projectsource <> ri.projectsource;
    SELF.Diff_collegestate := le.collegestate <> ri.collegestate;
    SELF.Diff_college := le.college <> ri.college;
    SELF.Diff_semester := le.semester <> ri.semester;
    SELF.Diff_year := le.year <> ri.year;
    SELF.Diff_firstname := le.firstname <> ri.firstname;
    SELF.Diff_middlename := le.middlename <> ri.middlename;
    SELF.Diff_lastname := le.lastname <> ri.lastname;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_major := le.major <> ri.major;
    SELF.Diff_grade := le.grade <> ri.grade;
    SELF.Diff_email := le.email <> ri.email;
    SELF.Diff_dateofbirth := le.dateofbirth <> ri.dateofbirth;
    SELF.Diff_dob_formatted := le.dob_formatted <> ri.dob_formatted;
    SELF.Diff_attendancedate := le.attendancedate <> ri.attendancedate;
    SELF.Diff_enrollmentstatus := le.enrollmentstatus <> ri.enrollmentstatus;
    SELF.Diff_addresstype := le.addresstype <> ri.addresstype;
    SELF.Diff_address1 := le.address1 <> ri.address1;
    SELF.Diff_address2 := le.address2 <> ri.address2;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_phonetyp := le.phonetyp <> ri.phonetyp;
    SELF.Diff_phonenumber := le.phonenumber <> ri.phonenumber;
    SELF.Diff_tier := le.tier <> ri.tier;
    SELF.Diff_school_size_code := le.school_size_code <> ri.school_size_code;
    SELF.Diff_competitive_code := le.competitive_code <> ri.competitive_code;
    SELF.Diff_tuition_code := le.tuition_code <> ri.tuition_code;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_name_score := le.name_score <> ri.name_score;
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
    SELF.Diff_z5 := le.z5 <> ri.z5;
    SELF.Diff_z4 := le.z4 <> ri.z4;
    SELF.Diff_cart := le.cart <> ri.cart;
    SELF.Diff_cr_sort_sz := le.cr_sort_sz <> ri.cr_sort_sz;
    SELF.Diff_lot := le.lot <> ri.lot;
    SELF.Diff_lot_order := le.lot_order <> ri.lot_order;
    SELF.Diff_dbpc := le.dbpc <> ri.dbpc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_fips_state := le.fips_state <> ri.fips_state;
    SELF.Diff_fips_county := le.fips_county <> ri.fips_county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_telephone := le.telephone <> ri.telephone;
    SELF.Diff_tier2 := le.tier2 <> ri.tier2;
    SELF.Diff_source := le.source <> ri.source;
    SELF.Val := (SALT33.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.cleancollegeid;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_cleanaddr1,1,0)+ IF( SELF.Diff_cleanaddr2,1,0)+ IF( SELF.Diff_cleanattendancedte,1,0)+ IF( SELF.Diff_cleancity,1,0)+ IF( SELF.Diff_cleanstate,1,0)+ IF( SELF.Diff_cleandob,1,0)+ IF( SELF.Diff_cleanupdatedte,1,0)+ IF( SELF.Diff_cleanemail,1,0)+ IF( SELF.Diff_append_email_username,1,0)+ IF( SELF.Diff_append_domain,1,0)+ IF( SELF.Diff_append_domain_type,1,0)+ IF( SELF.Diff_append_domain_root,1,0)+ IF( SELF.Diff_append_domain_ext,1,0)+ IF( SELF.Diff_append_is_tld_state,1,0)+ IF( SELF.Diff_append_is_tld_generic,1,0)+ IF( SELF.Diff_append_is_tld_country,1,0)+ IF( SELF.Diff_append_is_valid_domain_ext,1,0)+ IF( SELF.Diff_cleancollegeID,1,0)+ IF( SELF.Diff_cleantitle,1,0)+ IF( SELF.Diff_cleanfirstname,1,0)+ IF( SELF.Diff_cleanmidname,1,0)+ IF( SELF.Diff_cleanlastname,1,0)+ IF( SELF.Diff_cleansuffixname,1,0)+ IF( SELF.Diff_cleanzip,1,0)+ IF( SELF.Diff_cleanzip4,1,0)+ IF( SELF.Diff_cleanmajor,1,0)+ IF( SELF.Diff_cleanphone,1,0)+ IF( SELF.Diff_rcid,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_vendor_first_reported,1,0)+ IF( SELF.Diff_vendor_last_reported,1,0)+ IF( SELF.Diff_dateupdated,1,0)+ IF( SELF.Diff_studentid,1,0)+ IF( SELF.Diff_dartid,1,0)+ IF( SELF.Diff_collegeid,1,0)+ IF( SELF.Diff_projectsource,1,0)+ IF( SELF.Diff_collegestate,1,0)+ IF( SELF.Diff_college,1,0)+ IF( SELF.Diff_semester,1,0)+ IF( SELF.Diff_year,1,0)+ IF( SELF.Diff_firstname,1,0)+ IF( SELF.Diff_middlename,1,0)+ IF( SELF.Diff_lastname,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_major,1,0)+ IF( SELF.Diff_grade,1,0)+ IF( SELF.Diff_email,1,0)+ IF( SELF.Diff_dateofbirth,1,0)+ IF( SELF.Diff_dob_formatted,1,0)+ IF( SELF.Diff_attendancedate,1,0)+ IF( SELF.Diff_enrollmentstatus,1,0)+ IF( SELF.Diff_addresstype,1,0)+ IF( SELF.Diff_address1,1,0)+ IF( SELF.Diff_address2,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_phonetyp,1,0)+ IF( SELF.Diff_phonenumber,1,0)+ IF( SELF.Diff_tier,1,0)+ IF( SELF.Diff_school_size_code,1,0)+ IF( SELF.Diff_competitive_code,1,0)+ IF( SELF.Diff_tuition_code,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_z5,1,0)+ IF( SELF.Diff_z4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_fips_state,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_telephone,1,0)+ IF( SELF.Diff_tier2,1,0)+ IF( SELF.Diff_source,1,0);
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
    Count_Diff_cleanaddr1 := COUNT(GROUP,%Closest%.Diff_cleanaddr1);
    Count_Diff_cleanaddr2 := COUNT(GROUP,%Closest%.Diff_cleanaddr2);
    Count_Diff_cleanattendancedte := COUNT(GROUP,%Closest%.Diff_cleanattendancedte);
    Count_Diff_cleancity := COUNT(GROUP,%Closest%.Diff_cleancity);
    Count_Diff_cleanstate := COUNT(GROUP,%Closest%.Diff_cleanstate);
    Count_Diff_cleandob := COUNT(GROUP,%Closest%.Diff_cleandob);
    Count_Diff_cleanupdatedte := COUNT(GROUP,%Closest%.Diff_cleanupdatedte);
    Count_Diff_cleanemail := COUNT(GROUP,%Closest%.Diff_cleanemail);
    Count_Diff_append_email_username := COUNT(GROUP,%Closest%.Diff_append_email_username);
    Count_Diff_append_domain := COUNT(GROUP,%Closest%.Diff_append_domain);
    Count_Diff_append_domain_type := COUNT(GROUP,%Closest%.Diff_append_domain_type);
    Count_Diff_append_domain_root := COUNT(GROUP,%Closest%.Diff_append_domain_root);
    Count_Diff_append_domain_ext := COUNT(GROUP,%Closest%.Diff_append_domain_ext);
    Count_Diff_append_is_tld_state := COUNT(GROUP,%Closest%.Diff_append_is_tld_state);
    Count_Diff_append_is_tld_generic := COUNT(GROUP,%Closest%.Diff_append_is_tld_generic);
    Count_Diff_append_is_tld_country := COUNT(GROUP,%Closest%.Diff_append_is_tld_country);
    Count_Diff_append_is_valid_domain_ext := COUNT(GROUP,%Closest%.Diff_append_is_valid_domain_ext);
    Count_Diff_cleancollegeID := COUNT(GROUP,%Closest%.Diff_cleancollegeID);
    Count_Diff_cleantitle := COUNT(GROUP,%Closest%.Diff_cleantitle);
    Count_Diff_cleanfirstname := COUNT(GROUP,%Closest%.Diff_cleanfirstname);
    Count_Diff_cleanmidname := COUNT(GROUP,%Closest%.Diff_cleanmidname);
    Count_Diff_cleanlastname := COUNT(GROUP,%Closest%.Diff_cleanlastname);
    Count_Diff_cleansuffixname := COUNT(GROUP,%Closest%.Diff_cleansuffixname);
    Count_Diff_cleanzip := COUNT(GROUP,%Closest%.Diff_cleanzip);
    Count_Diff_cleanzip4 := COUNT(GROUP,%Closest%.Diff_cleanzip4);
    Count_Diff_cleanmajor := COUNT(GROUP,%Closest%.Diff_cleanmajor);
    Count_Diff_cleanphone := COUNT(GROUP,%Closest%.Diff_cleanphone);
    Count_Diff_rcid := COUNT(GROUP,%Closest%.Diff_rcid);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_date_first_seen := COUNT(GROUP,%Closest%.Diff_date_first_seen);
    Count_Diff_date_last_seen := COUNT(GROUP,%Closest%.Diff_date_last_seen);
    Count_Diff_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_vendor_first_reported);
    Count_Diff_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_vendor_last_reported);
    Count_Diff_dateupdated := COUNT(GROUP,%Closest%.Diff_dateupdated);
    Count_Diff_studentid := COUNT(GROUP,%Closest%.Diff_studentid);
    Count_Diff_dartid := COUNT(GROUP,%Closest%.Diff_dartid);
    Count_Diff_collegeid := COUNT(GROUP,%Closest%.Diff_collegeid);
    Count_Diff_projectsource := COUNT(GROUP,%Closest%.Diff_projectsource);
    Count_Diff_collegestate := COUNT(GROUP,%Closest%.Diff_collegestate);
    Count_Diff_college := COUNT(GROUP,%Closest%.Diff_college);
    Count_Diff_semester := COUNT(GROUP,%Closest%.Diff_semester);
    Count_Diff_year := COUNT(GROUP,%Closest%.Diff_year);
    Count_Diff_firstname := COUNT(GROUP,%Closest%.Diff_firstname);
    Count_Diff_middlename := COUNT(GROUP,%Closest%.Diff_middlename);
    Count_Diff_lastname := COUNT(GROUP,%Closest%.Diff_lastname);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_major := COUNT(GROUP,%Closest%.Diff_major);
    Count_Diff_grade := COUNT(GROUP,%Closest%.Diff_grade);
    Count_Diff_email := COUNT(GROUP,%Closest%.Diff_email);
    Count_Diff_dateofbirth := COUNT(GROUP,%Closest%.Diff_dateofbirth);
    Count_Diff_dob_formatted := COUNT(GROUP,%Closest%.Diff_dob_formatted);
    Count_Diff_attendancedate := COUNT(GROUP,%Closest%.Diff_attendancedate);
    Count_Diff_enrollmentstatus := COUNT(GROUP,%Closest%.Diff_enrollmentstatus);
    Count_Diff_addresstype := COUNT(GROUP,%Closest%.Diff_addresstype);
    Count_Diff_address1 := COUNT(GROUP,%Closest%.Diff_address1);
    Count_Diff_address2 := COUNT(GROUP,%Closest%.Diff_address2);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_phonetyp := COUNT(GROUP,%Closest%.Diff_phonetyp);
    Count_Diff_phonenumber := COUNT(GROUP,%Closest%.Diff_phonenumber);
    Count_Diff_tier := COUNT(GROUP,%Closest%.Diff_tier);
    Count_Diff_school_size_code := COUNT(GROUP,%Closest%.Diff_school_size_code);
    Count_Diff_competitive_code := COUNT(GROUP,%Closest%.Diff_competitive_code);
    Count_Diff_tuition_code := COUNT(GROUP,%Closest%.Diff_tuition_code);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_name_score := COUNT(GROUP,%Closest%.Diff_name_score);
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
    Count_Diff_z5 := COUNT(GROUP,%Closest%.Diff_z5);
    Count_Diff_z4 := COUNT(GROUP,%Closest%.Diff_z4);
    Count_Diff_cart := COUNT(GROUP,%Closest%.Diff_cart);
    Count_Diff_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_cr_sort_sz);
    Count_Diff_lot := COUNT(GROUP,%Closest%.Diff_lot);
    Count_Diff_lot_order := COUNT(GROUP,%Closest%.Diff_lot_order);
    Count_Diff_dbpc := COUNT(GROUP,%Closest%.Diff_dbpc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_fips_state := COUNT(GROUP,%Closest%.Diff_fips_state);
    Count_Diff_fips_county := COUNT(GROUP,%Closest%.Diff_fips_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_telephone := COUNT(GROUP,%Closest%.Diff_telephone);
    Count_Diff_tier2 := COUNT(GROUP,%Closest%.Diff_tier2);
    Count_Diff_source := COUNT(GROUP,%Closest%.Diff_source);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;
