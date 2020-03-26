IMPORT SALT311;
EXPORT Fields := MODULE

EXPORT NumFields := 60;

// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Nums','lowercase','uppercase','alphas','lowercaseandnums','uppercaseandnums','alphasandnums','allupper','allupperandnums','allalphaandnums','invalid_blank','invalid_alpha','invalid_Num','invalid_date','invalid_name','invalid_vendor','invalid_source_file','invalid_party_type','invalid_filing_type','invalid_name_format','invalid_age','invalid_race','invalid_address','invalid_city','invalid_county','invalid_state','invalid_filing_number','invalid_docket_volume');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Nums' => 1,'lowercase' => 2,'uppercase' => 3,'alphas' => 4,'lowercaseandnums' => 5,'uppercaseandnums' => 6,'alphasandnums' => 7,'allupper' => 8,'allupperandnums' => 9,'allalphaandnums' => 10,'invalid_blank' => 11,'invalid_alpha' => 12,'invalid_Num' => 13,'invalid_date' => 14,'invalid_name' => 15,'invalid_vendor' => 16,'invalid_source_file' => 17,'invalid_party_type' => 18,'invalid_filing_type' => 19,'invalid_name_format' => 20,'invalid_age' => 21,'invalid_race' => 22,'invalid_address' => 23,'invalid_city' => 24,'invalid_county' => 25,'invalid_state' => 26,'invalid_filing_number' => 27,'invalid_docket_volume' => 28,0);

EXPORT MakeFT_Nums(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Nums(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Nums(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_lowercase(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'abcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_lowercase(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'abcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_lowercase(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyz'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_uppercase(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_uppercase(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_uppercase(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_alphas(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_alphas(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_alphas(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_lowercaseandnums(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'abcdefghijklmnopqrstuvwxyz0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_lowercaseandnums(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'abcdefghijklmnopqrstuvwxyz0123456789'))));
EXPORT InValidMessageFT_lowercaseandnums(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyz0123456789'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_uppercaseandnums(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_uppercaseandnums(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))));
EXPORT InValidMessageFT_uppercaseandnums(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_alphasandnums(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_alphasandnums(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'))));
EXPORT InValidMessageFT_alphasandnums(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_allupper(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_allupper(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_allupper(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_allupperandnums(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_allupperandnums(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))));
EXPORT InValidMessageFT_allupperandnums(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_allalphaandnums(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_allalphaandnums(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'))));
EXPORT InValidMessageFT_allalphaandnums(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_blank(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_blank(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('0'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringtouppercase(s0); // Force to upper case
  s2 := SALT311.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -'); // Only allow valid symbols
  s3 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s2,' -',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_alpha(SALT311.StrType s) := WHICH(SALT311.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotCaps,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -'),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_Num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_Num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_date(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 -/'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -/',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_Nums(s2);
END;
EXPORT InValidFT_invalid_date(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 -/'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 -/'),SALT311.HygieneErrors.NotLength('0,1,6,7,8,9,10'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -,./\\#:;&*"\'`_()[]{}!?'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -,./\\#:;&*"\'`_()[]{}!?',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_allalphaandnums(s2);
END;
EXPORT InValidFT_invalid_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -,./\\#:;&*"\'`_()[]{}!?'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -,./\\#:;&*"\'`_()[]{}!?'),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_vendor(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercaseandnums(s2);
END;
EXPORT InValidFT_invalid_vendor(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_vendor(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -'),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_source_file(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -_/'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -_/',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercase(s2);
END;
EXPORT InValidFT_invalid_source_file(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -_/'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_source_file(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -_/'),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_party_type(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringtouppercase(s0); // Force to upper case
  s2 := SALT311.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s2;
END;
EXPORT InValidFT_invalid_party_type(SALT311.StrType s) := WHICH(SALT311.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_party_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotCaps,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.NotLength('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_filing_type(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_Num(s1);
END;
EXPORT InValidFT_invalid_filing_type(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_filing_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_name_format(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name_format(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['L','F','']);
EXPORT InValidMessageFT_invalid_name_format(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('L|F|'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_age(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_Nums(s1);
END;
EXPORT InValidFT_invalid_age(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3));
EXPORT InValidMessageFT_invalid_age(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0,1,2,3'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_race(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -,/&'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -,/&',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercase(s2);
END;
EXPORT InValidFT_invalid_race(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -,/&'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_race(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -,/&'),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_address(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringtouppercase(s0); // Force to upper case
  s2 := SALT311.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -&/\\#%.;,\'_"*()%?=@'); // Only allow valid symbols
  s3 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s2,' -&/\\#%.;,\'_"*()%?=@',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_allupperandnums(s3);
END;
EXPORT InValidFT_invalid_address(SALT311.StrType s) := WHICH(SALT311.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -&/\\#%.;,\'_"*()%?=@'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_address(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotCaps,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -&/\\#%.;,\'_"*()%?=@'),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_city(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz -,&\\/.:#;\''); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -,&\\/.:#;\'',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_alphas(s2);
END;
EXPORT InValidFT_invalid_city(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz -,&\\/.:#;\''))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_city(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz -,&\\/.:#;\''),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_county(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz -,&\\/.:#();'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -,&\\/.:#();',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_alphas(s2);
END;
EXPORT InValidFT_invalid_county(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz -,&\\/.:#();'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_county(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz -,&\\/.:#();'),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_state(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  MakeFT_uppercase(s1);
END;
EXPORT InValidFT_invalid_state(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.NotLength('0,2'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_filing_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -.*/'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -.*/',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_allalphaandnums(s2);
END;
EXPORT InValidFT_invalid_filing_number(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -.*/'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_filing_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -.*/'),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_docket_volume(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -/,*()#."'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -/,*()#."',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_allalphaandnums(s2);
END;
EXPORT InValidFT_invalid_docket_volume(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -/,*()#."'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_docket_volume(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -/,*()#."'),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);


EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_id','filing_type','filing_subtype','vendor','source_file','process_date','state_origin','party1_type','party1_name_format','party1_name','party1_alias','party1_dob','party1_birth_state','party1_age','party1_race','party1_addr1','party1_csz','party1_county','party1_previous_marital_status','party1_how_marriage_ended','party1_times_married','party1_last_marriage_end_dt','party2_type','party2_name_format','party2_name','party2_alias','party2_dob','party2_birth_state','party2_age','party2_race','party2_addr1','party2_csz','party2_county','party2_previous_marital_status','party2_how_marriage_ended','party2_times_married','party2_last_marriage_end_dt','number_of_children','marriage_filing_dt','marriage_dt','marriage_city','marriage_county','place_of_marriage','type_of_ceremony','marriage_filing_number','marriage_docket_volume','divorce_filing_dt','divorce_dt','divorce_docket_volume','divorce_filing_number','divorce_city','divorce_county','grounds_for_divorce','marriage_duration_cd','marriage_duration','persistent_record_id');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_id','filing_type','filing_subtype','vendor','source_file','process_date','state_origin','party1_type','party1_name_format','party1_name','party1_alias','party1_dob','party1_birth_state','party1_age','party1_race','party1_addr1','party1_csz','party1_county','party1_previous_marital_status','party1_how_marriage_ended','party1_times_married','party1_last_marriage_end_dt','party2_type','party2_name_format','party2_name','party2_alias','party2_dob','party2_birth_state','party2_age','party2_race','party2_addr1','party2_csz','party2_county','party2_previous_marital_status','party2_how_marriage_ended','party2_times_married','party2_last_marriage_end_dt','number_of_children','marriage_filing_dt','marriage_dt','marriage_city','marriage_county','place_of_marriage','type_of_ceremony','marriage_filing_number','marriage_docket_volume','divorce_filing_dt','divorce_dt','divorce_docket_volume','divorce_filing_number','divorce_city','divorce_county','grounds_for_divorce','marriage_duration_cd','marriage_duration','persistent_record_id');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'dt_first_seen' => 0,'dt_last_seen' => 1,'dt_vendor_first_reported' => 2,'dt_vendor_last_reported' => 3,'record_id' => 4,'filing_type' => 5,'filing_subtype' => 6,'vendor' => 7,'source_file' => 8,'process_date' => 9,'state_origin' => 10,'party1_type' => 11,'party1_name_format' => 12,'party1_name' => 13,'party1_alias' => 14,'party1_dob' => 15,'party1_birth_state' => 16,'party1_age' => 17,'party1_race' => 18,'party1_addr1' => 19,'party1_csz' => 20,'party1_county' => 21,'party1_previous_marital_status' => 22,'party1_how_marriage_ended' => 23,'party1_times_married' => 24,'party1_last_marriage_end_dt' => 25,'party2_type' => 26,'party2_name_format' => 27,'party2_name' => 28,'party2_alias' => 29,'party2_dob' => 30,'party2_birth_state' => 31,'party2_age' => 32,'party2_race' => 33,'party2_addr1' => 34,'party2_csz' => 35,'party2_county' => 36,'party2_previous_marital_status' => 37,'party2_how_marriage_ended' => 38,'party2_times_married' => 39,'party2_last_marriage_end_dt' => 40,'number_of_children' => 41,'marriage_filing_dt' => 42,'marriage_dt' => 43,'marriage_city' => 44,'marriage_county' => 45,'place_of_marriage' => 46,'type_of_ceremony' => 47,'marriage_filing_number' => 48,'marriage_docket_volume' => 49,'divorce_filing_dt' => 50,'divorce_dt' => 51,'divorce_docket_volume' => 52,'divorce_filing_number' => 53,'divorce_city' => 54,'divorce_county' => 55,'grounds_for_divorce' => 56,'marriage_duration_cd' => 57,'marriage_duration' => 58,'persistent_record_id' => 59,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['CAPS','ALLOW','LENGTHS'],['ENUM'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],['ALLOW','LENGTHS'],['CAPS','ALLOW','LENGTHS'],[],['ALLOW','LENGTHS'],[],[],[],['ALLOW','LENGTHS'],['CAPS','ALLOW','LENGTHS'],['ENUM'],['ALLOW','LENGTHS'],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],['CAPS','ALLOW','LENGTHS'],[],['ALLOW','LENGTHS'],[],[],[],['ALLOW','LENGTHS'],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);

//Individual field level validation


EXPORT Make_dt_first_seen(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_first_seen(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_dt_last_seen(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_last_seen(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_dt_vendor_first_reported(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_vendor_first_reported(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_dt_vendor_last_reported(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_vendor_last_reported(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_record_id(SALT311.StrType s0) := MakeFT_invalid_Num(s0);
EXPORT InValid_record_id(SALT311.StrType s) := InValidFT_invalid_Num(s);
EXPORT InValidMessage_record_id(UNSIGNED1 wh) := InValidMessageFT_invalid_Num(wh);


EXPORT Make_filing_type(SALT311.StrType s0) := MakeFT_invalid_filing_type(s0);
EXPORT InValid_filing_type(SALT311.StrType s) := InValidFT_invalid_filing_type(s);
EXPORT InValidMessage_filing_type(UNSIGNED1 wh) := InValidMessageFT_invalid_filing_type(wh);


EXPORT Make_filing_subtype(SALT311.StrType s0) := s0;
EXPORT InValid_filing_subtype(SALT311.StrType s) := 0;
EXPORT InValidMessage_filing_subtype(UNSIGNED1 wh) := '';


EXPORT Make_vendor(SALT311.StrType s0) := MakeFT_invalid_vendor(s0);
EXPORT InValid_vendor(SALT311.StrType s) := InValidFT_invalid_vendor(s);
EXPORT InValidMessage_vendor(UNSIGNED1 wh) := InValidMessageFT_invalid_vendor(wh);


EXPORT Make_source_file(SALT311.StrType s0) := MakeFT_invalid_source_file(s0);
EXPORT InValid_source_file(SALT311.StrType s) := InValidFT_invalid_source_file(s);
EXPORT InValidMessage_source_file(UNSIGNED1 wh) := InValidMessageFT_invalid_source_file(wh);


EXPORT Make_process_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_process_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_state_origin(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state_origin(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state_origin(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);


EXPORT Make_party1_type(SALT311.StrType s0) := MakeFT_invalid_party_type(s0);
EXPORT InValid_party1_type(SALT311.StrType s) := InValidFT_invalid_party_type(s);
EXPORT InValidMessage_party1_type(UNSIGNED1 wh) := InValidMessageFT_invalid_party_type(wh);


EXPORT Make_party1_name_format(SALT311.StrType s0) := MakeFT_invalid_name_format(s0);
EXPORT InValid_party1_name_format(SALT311.StrType s) := InValidFT_invalid_name_format(s);
EXPORT InValidMessage_party1_name_format(UNSIGNED1 wh) := InValidMessageFT_invalid_name_format(wh);


EXPORT Make_party1_name(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_party1_name(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_party1_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);


EXPORT Make_party1_alias(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_party1_alias(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_party1_alias(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);


EXPORT Make_party1_dob(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_party1_dob(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_party1_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_party1_birth_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_party1_birth_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_party1_birth_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);


EXPORT Make_party1_age(SALT311.StrType s0) := s0;
EXPORT InValid_party1_age(SALT311.StrType s) := 0;
EXPORT InValidMessage_party1_age(UNSIGNED1 wh) := '';


EXPORT Make_party1_race(SALT311.StrType s0) := MakeFT_invalid_race(s0);
EXPORT InValid_party1_race(SALT311.StrType s) := InValidFT_invalid_race(s);
EXPORT InValidMessage_party1_race(UNSIGNED1 wh) := InValidMessageFT_invalid_race(wh);


EXPORT Make_party1_addr1(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_party1_addr1(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_party1_addr1(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);


EXPORT Make_party1_csz(SALT311.StrType s0) := s0;
EXPORT InValid_party1_csz(SALT311.StrType s) := 0;
EXPORT InValidMessage_party1_csz(UNSIGNED1 wh) := '';


EXPORT Make_party1_county(SALT311.StrType s0) := MakeFT_invalid_county(s0);
EXPORT InValid_party1_county(SALT311.StrType s) := InValidFT_invalid_county(s);
EXPORT InValidMessage_party1_county(UNSIGNED1 wh) := InValidMessageFT_invalid_county(wh);


EXPORT Make_party1_previous_marital_status(SALT311.StrType s0) := s0;
EXPORT InValid_party1_previous_marital_status(SALT311.StrType s) := 0;
EXPORT InValidMessage_party1_previous_marital_status(UNSIGNED1 wh) := '';


EXPORT Make_party1_how_marriage_ended(SALT311.StrType s0) := s0;
EXPORT InValid_party1_how_marriage_ended(SALT311.StrType s) := 0;
EXPORT InValidMessage_party1_how_marriage_ended(UNSIGNED1 wh) := '';


EXPORT Make_party1_times_married(SALT311.StrType s0) := s0;
EXPORT InValid_party1_times_married(SALT311.StrType s) := 0;
EXPORT InValidMessage_party1_times_married(UNSIGNED1 wh) := '';


EXPORT Make_party1_last_marriage_end_dt(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_party1_last_marriage_end_dt(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_party1_last_marriage_end_dt(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_party2_type(SALT311.StrType s0) := MakeFT_invalid_party_type(s0);
EXPORT InValid_party2_type(SALT311.StrType s) := InValidFT_invalid_party_type(s);
EXPORT InValidMessage_party2_type(UNSIGNED1 wh) := InValidMessageFT_invalid_party_type(wh);


EXPORT Make_party2_name_format(SALT311.StrType s0) := MakeFT_invalid_name_format(s0);
EXPORT InValid_party2_name_format(SALT311.StrType s) := InValidFT_invalid_name_format(s);
EXPORT InValidMessage_party2_name_format(UNSIGNED1 wh) := InValidMessageFT_invalid_name_format(wh);


EXPORT Make_party2_name(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_party2_name(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_party2_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);


EXPORT Make_party2_alias(SALT311.StrType s0) := s0;
EXPORT InValid_party2_alias(SALT311.StrType s) := 0;
EXPORT InValidMessage_party2_alias(UNSIGNED1 wh) := '';


EXPORT Make_party2_dob(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_party2_dob(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_party2_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_party2_birth_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_party2_birth_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_party2_birth_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);


EXPORT Make_party2_age(SALT311.StrType s0) := s0;
EXPORT InValid_party2_age(SALT311.StrType s) := 0;
EXPORT InValidMessage_party2_age(UNSIGNED1 wh) := '';


EXPORT Make_party2_race(SALT311.StrType s0) := s0;
EXPORT InValid_party2_race(SALT311.StrType s) := 0;
EXPORT InValidMessage_party2_race(UNSIGNED1 wh) := '';


EXPORT Make_party2_addr1(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_party2_addr1(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_party2_addr1(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);


EXPORT Make_party2_csz(SALT311.StrType s0) := s0;
EXPORT InValid_party2_csz(SALT311.StrType s) := 0;
EXPORT InValidMessage_party2_csz(UNSIGNED1 wh) := '';


EXPORT Make_party2_county(SALT311.StrType s0) := MakeFT_invalid_county(s0);
EXPORT InValid_party2_county(SALT311.StrType s) := InValidFT_invalid_county(s);
EXPORT InValidMessage_party2_county(UNSIGNED1 wh) := InValidMessageFT_invalid_county(wh);


EXPORT Make_party2_previous_marital_status(SALT311.StrType s0) := s0;
EXPORT InValid_party2_previous_marital_status(SALT311.StrType s) := 0;
EXPORT InValidMessage_party2_previous_marital_status(UNSIGNED1 wh) := '';


EXPORT Make_party2_how_marriage_ended(SALT311.StrType s0) := s0;
EXPORT InValid_party2_how_marriage_ended(SALT311.StrType s) := 0;
EXPORT InValidMessage_party2_how_marriage_ended(UNSIGNED1 wh) := '';


EXPORT Make_party2_times_married(SALT311.StrType s0) := s0;
EXPORT InValid_party2_times_married(SALT311.StrType s) := 0;
EXPORT InValidMessage_party2_times_married(UNSIGNED1 wh) := '';


EXPORT Make_party2_last_marriage_end_dt(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_party2_last_marriage_end_dt(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_party2_last_marriage_end_dt(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_number_of_children(SALT311.StrType s0) := s0;
EXPORT InValid_number_of_children(SALT311.StrType s) := 0;
EXPORT InValidMessage_number_of_children(UNSIGNED1 wh) := '';


EXPORT Make_marriage_filing_dt(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_marriage_filing_dt(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_marriage_filing_dt(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_marriage_dt(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_marriage_dt(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_marriage_dt(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_marriage_city(SALT311.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_marriage_city(SALT311.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_marriage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);


EXPORT Make_marriage_county(SALT311.StrType s0) := MakeFT_invalid_county(s0);
EXPORT InValid_marriage_county(SALT311.StrType s) := InValidFT_invalid_county(s);
EXPORT InValidMessage_marriage_county(UNSIGNED1 wh) := InValidMessageFT_invalid_county(wh);


EXPORT Make_place_of_marriage(SALT311.StrType s0) := s0;
EXPORT InValid_place_of_marriage(SALT311.StrType s) := 0;
EXPORT InValidMessage_place_of_marriage(UNSIGNED1 wh) := '';


EXPORT Make_type_of_ceremony(SALT311.StrType s0) := s0;
EXPORT InValid_type_of_ceremony(SALT311.StrType s) := 0;
EXPORT InValidMessage_type_of_ceremony(UNSIGNED1 wh) := '';


EXPORT Make_marriage_filing_number(SALT311.StrType s0) := MakeFT_invalid_filing_number(s0);
EXPORT InValid_marriage_filing_number(SALT311.StrType s) := InValidFT_invalid_filing_number(s);
EXPORT InValidMessage_marriage_filing_number(UNSIGNED1 wh) := InValidMessageFT_invalid_filing_number(wh);


EXPORT Make_marriage_docket_volume(SALT311.StrType s0) := MakeFT_invalid_docket_volume(s0);
EXPORT InValid_marriage_docket_volume(SALT311.StrType s) := InValidFT_invalid_docket_volume(s);
EXPORT InValidMessage_marriage_docket_volume(UNSIGNED1 wh) := InValidMessageFT_invalid_docket_volume(wh);


EXPORT Make_divorce_filing_dt(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_divorce_filing_dt(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_divorce_filing_dt(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_divorce_dt(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_divorce_dt(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_divorce_dt(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_divorce_docket_volume(SALT311.StrType s0) := MakeFT_invalid_docket_volume(s0);
EXPORT InValid_divorce_docket_volume(SALT311.StrType s) := InValidFT_invalid_docket_volume(s);
EXPORT InValidMessage_divorce_docket_volume(UNSIGNED1 wh) := InValidMessageFT_invalid_docket_volume(wh);


EXPORT Make_divorce_filing_number(SALT311.StrType s0) := MakeFT_invalid_filing_number(s0);
EXPORT InValid_divorce_filing_number(SALT311.StrType s) := InValidFT_invalid_filing_number(s);
EXPORT InValidMessage_divorce_filing_number(UNSIGNED1 wh) := InValidMessageFT_invalid_filing_number(wh);


EXPORT Make_divorce_city(SALT311.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_divorce_city(SALT311.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_divorce_city(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);


EXPORT Make_divorce_county(SALT311.StrType s0) := MakeFT_invalid_county(s0);
EXPORT InValid_divorce_county(SALT311.StrType s) := InValidFT_invalid_county(s);
EXPORT InValidMessage_divorce_county(UNSIGNED1 wh) := InValidMessageFT_invalid_county(wh);


EXPORT Make_grounds_for_divorce(SALT311.StrType s0) := s0;
EXPORT InValid_grounds_for_divorce(SALT311.StrType s) := 0;
EXPORT InValidMessage_grounds_for_divorce(UNSIGNED1 wh) := '';


EXPORT Make_marriage_duration_cd(SALT311.StrType s0) := s0;
EXPORT InValid_marriage_duration_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_marriage_duration_cd(UNSIGNED1 wh) := '';


EXPORT Make_marriage_duration(SALT311.StrType s0) := s0;
EXPORT InValid_marriage_duration(SALT311.StrType s) := 0;
EXPORT InValidMessage_marriage_duration(UNSIGNED1 wh) := '';


EXPORT Make_persistent_record_id(SALT311.StrType s0) := s0;
EXPORT InValid_persistent_record_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_persistent_record_id(UNSIGNED1 wh) := '';

// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Marriage_Divorce_V2;
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
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_record_id;
    BOOLEAN Diff_filing_type;
    BOOLEAN Diff_filing_subtype;
    BOOLEAN Diff_vendor;
    BOOLEAN Diff_source_file;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_state_origin;
    BOOLEAN Diff_party1_type;
    BOOLEAN Diff_party1_name_format;
    BOOLEAN Diff_party1_name;
    BOOLEAN Diff_party1_alias;
    BOOLEAN Diff_party1_dob;
    BOOLEAN Diff_party1_birth_state;
    BOOLEAN Diff_party1_age;
    BOOLEAN Diff_party1_race;
    BOOLEAN Diff_party1_addr1;
    BOOLEAN Diff_party1_csz;
    BOOLEAN Diff_party1_county;
    BOOLEAN Diff_party1_previous_marital_status;
    BOOLEAN Diff_party1_how_marriage_ended;
    BOOLEAN Diff_party1_times_married;
    BOOLEAN Diff_party1_last_marriage_end_dt;
    BOOLEAN Diff_party2_type;
    BOOLEAN Diff_party2_name_format;
    BOOLEAN Diff_party2_name;
    BOOLEAN Diff_party2_alias;
    BOOLEAN Diff_party2_dob;
    BOOLEAN Diff_party2_birth_state;
    BOOLEAN Diff_party2_age;
    BOOLEAN Diff_party2_race;
    BOOLEAN Diff_party2_addr1;
    BOOLEAN Diff_party2_csz;
    BOOLEAN Diff_party2_county;
    BOOLEAN Diff_party2_previous_marital_status;
    BOOLEAN Diff_party2_how_marriage_ended;
    BOOLEAN Diff_party2_times_married;
    BOOLEAN Diff_party2_last_marriage_end_dt;
    BOOLEAN Diff_number_of_children;
    BOOLEAN Diff_marriage_filing_dt;
    BOOLEAN Diff_marriage_dt;
    BOOLEAN Diff_marriage_city;
    BOOLEAN Diff_marriage_county;
    BOOLEAN Diff_place_of_marriage;
    BOOLEAN Diff_type_of_ceremony;
    BOOLEAN Diff_marriage_filing_number;
    BOOLEAN Diff_marriage_docket_volume;
    BOOLEAN Diff_divorce_filing_dt;
    BOOLEAN Diff_divorce_dt;
    BOOLEAN Diff_divorce_docket_volume;
    BOOLEAN Diff_divorce_filing_number;
    BOOLEAN Diff_divorce_city;
    BOOLEAN Diff_divorce_county;
    BOOLEAN Diff_grounds_for_divorce;
    BOOLEAN Diff_marriage_duration_cd;
    BOOLEAN Diff_marriage_duration;
    BOOLEAN Diff_persistent_record_id;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_record_id := le.record_id <> ri.record_id;
    SELF.Diff_filing_type := le.filing_type <> ri.filing_type;
    SELF.Diff_filing_subtype := le.filing_subtype <> ri.filing_subtype;
    SELF.Diff_vendor := le.vendor <> ri.vendor;
    SELF.Diff_source_file := le.source_file <> ri.source_file;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_state_origin := le.state_origin <> ri.state_origin;
    SELF.Diff_party1_type := le.party1_type <> ri.party1_type;
    SELF.Diff_party1_name_format := le.party1_name_format <> ri.party1_name_format;
    SELF.Diff_party1_name := le.party1_name <> ri.party1_name;
    SELF.Diff_party1_alias := le.party1_alias <> ri.party1_alias;
    SELF.Diff_party1_dob := le.party1_dob <> ri.party1_dob;
    SELF.Diff_party1_birth_state := le.party1_birth_state <> ri.party1_birth_state;
    SELF.Diff_party1_age := le.party1_age <> ri.party1_age;
    SELF.Diff_party1_race := le.party1_race <> ri.party1_race;
    SELF.Diff_party1_addr1 := le.party1_addr1 <> ri.party1_addr1;
    SELF.Diff_party1_csz := le.party1_csz <> ri.party1_csz;
    SELF.Diff_party1_county := le.party1_county <> ri.party1_county;
    SELF.Diff_party1_previous_marital_status := le.party1_previous_marital_status <> ri.party1_previous_marital_status;
    SELF.Diff_party1_how_marriage_ended := le.party1_how_marriage_ended <> ri.party1_how_marriage_ended;
    SELF.Diff_party1_times_married := le.party1_times_married <> ri.party1_times_married;
    SELF.Diff_party1_last_marriage_end_dt := le.party1_last_marriage_end_dt <> ri.party1_last_marriage_end_dt;
    SELF.Diff_party2_type := le.party2_type <> ri.party2_type;
    SELF.Diff_party2_name_format := le.party2_name_format <> ri.party2_name_format;
    SELF.Diff_party2_name := le.party2_name <> ri.party2_name;
    SELF.Diff_party2_alias := le.party2_alias <> ri.party2_alias;
    SELF.Diff_party2_dob := le.party2_dob <> ri.party2_dob;
    SELF.Diff_party2_birth_state := le.party2_birth_state <> ri.party2_birth_state;
    SELF.Diff_party2_age := le.party2_age <> ri.party2_age;
    SELF.Diff_party2_race := le.party2_race <> ri.party2_race;
    SELF.Diff_party2_addr1 := le.party2_addr1 <> ri.party2_addr1;
    SELF.Diff_party2_csz := le.party2_csz <> ri.party2_csz;
    SELF.Diff_party2_county := le.party2_county <> ri.party2_county;
    SELF.Diff_party2_previous_marital_status := le.party2_previous_marital_status <> ri.party2_previous_marital_status;
    SELF.Diff_party2_how_marriage_ended := le.party2_how_marriage_ended <> ri.party2_how_marriage_ended;
    SELF.Diff_party2_times_married := le.party2_times_married <> ri.party2_times_married;
    SELF.Diff_party2_last_marriage_end_dt := le.party2_last_marriage_end_dt <> ri.party2_last_marriage_end_dt;
    SELF.Diff_number_of_children := le.number_of_children <> ri.number_of_children;
    SELF.Diff_marriage_filing_dt := le.marriage_filing_dt <> ri.marriage_filing_dt;
    SELF.Diff_marriage_dt := le.marriage_dt <> ri.marriage_dt;
    SELF.Diff_marriage_city := le.marriage_city <> ri.marriage_city;
    SELF.Diff_marriage_county := le.marriage_county <> ri.marriage_county;
    SELF.Diff_place_of_marriage := le.place_of_marriage <> ri.place_of_marriage;
    SELF.Diff_type_of_ceremony := le.type_of_ceremony <> ri.type_of_ceremony;
    SELF.Diff_marriage_filing_number := le.marriage_filing_number <> ri.marriage_filing_number;
    SELF.Diff_marriage_docket_volume := le.marriage_docket_volume <> ri.marriage_docket_volume;
    SELF.Diff_divorce_filing_dt := le.divorce_filing_dt <> ri.divorce_filing_dt;
    SELF.Diff_divorce_dt := le.divorce_dt <> ri.divorce_dt;
    SELF.Diff_divorce_docket_volume := le.divorce_docket_volume <> ri.divorce_docket_volume;
    SELF.Diff_divorce_filing_number := le.divorce_filing_number <> ri.divorce_filing_number;
    SELF.Diff_divorce_city := le.divorce_city <> ri.divorce_city;
    SELF.Diff_divorce_county := le.divorce_county <> ri.divorce_county;
    SELF.Diff_grounds_for_divorce := le.grounds_for_divorce <> ri.grounds_for_divorce;
    SELF.Diff_marriage_duration_cd := le.marriage_duration_cd <> ri.marriage_duration_cd;
    SELF.Diff_marriage_duration := le.marriage_duration <> ri.marriage_duration;
    SELF.Diff_persistent_record_id := le.persistent_record_id <> ri.persistent_record_id;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_record_id,1,0)+ IF( SELF.Diff_filing_type,1,0)+ IF( SELF.Diff_filing_subtype,1,0)+ IF( SELF.Diff_vendor,1,0)+ IF( SELF.Diff_source_file,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_state_origin,1,0)+ IF( SELF.Diff_party1_type,1,0)+ IF( SELF.Diff_party1_name_format,1,0)+ IF( SELF.Diff_party1_name,1,0)+ IF( SELF.Diff_party1_alias,1,0)+ IF( SELF.Diff_party1_dob,1,0)+ IF( SELF.Diff_party1_birth_state,1,0)+ IF( SELF.Diff_party1_age,1,0)+ IF( SELF.Diff_party1_race,1,0)+ IF( SELF.Diff_party1_addr1,1,0)+ IF( SELF.Diff_party1_csz,1,0)+ IF( SELF.Diff_party1_county,1,0)+ IF( SELF.Diff_party1_previous_marital_status,1,0)+ IF( SELF.Diff_party1_how_marriage_ended,1,0)+ IF( SELF.Diff_party1_times_married,1,0)+ IF( SELF.Diff_party1_last_marriage_end_dt,1,0)+ IF( SELF.Diff_party2_type,1,0)+ IF( SELF.Diff_party2_name_format,1,0)+ IF( SELF.Diff_party2_name,1,0)+ IF( SELF.Diff_party2_alias,1,0)+ IF( SELF.Diff_party2_dob,1,0)+ IF( SELF.Diff_party2_birth_state,1,0)+ IF( SELF.Diff_party2_age,1,0)+ IF( SELF.Diff_party2_race,1,0)+ IF( SELF.Diff_party2_addr1,1,0)+ IF( SELF.Diff_party2_csz,1,0)+ IF( SELF.Diff_party2_county,1,0)+ IF( SELF.Diff_party2_previous_marital_status,1,0)+ IF( SELF.Diff_party2_how_marriage_ended,1,0)+ IF( SELF.Diff_party2_times_married,1,0)+ IF( SELF.Diff_party2_last_marriage_end_dt,1,0)+ IF( SELF.Diff_number_of_children,1,0)+ IF( SELF.Diff_marriage_filing_dt,1,0)+ IF( SELF.Diff_marriage_dt,1,0)+ IF( SELF.Diff_marriage_city,1,0)+ IF( SELF.Diff_marriage_county,1,0)+ IF( SELF.Diff_place_of_marriage,1,0)+ IF( SELF.Diff_type_of_ceremony,1,0)+ IF( SELF.Diff_marriage_filing_number,1,0)+ IF( SELF.Diff_marriage_docket_volume,1,0)+ IF( SELF.Diff_divorce_filing_dt,1,0)+ IF( SELF.Diff_divorce_dt,1,0)+ IF( SELF.Diff_divorce_docket_volume,1,0)+ IF( SELF.Diff_divorce_filing_number,1,0)+ IF( SELF.Diff_divorce_city,1,0)+ IF( SELF.Diff_divorce_county,1,0)+ IF( SELF.Diff_grounds_for_divorce,1,0)+ IF( SELF.Diff_marriage_duration_cd,1,0)+ IF( SELF.Diff_marriage_duration,1,0)+ IF( SELF.Diff_persistent_record_id,1,0);
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
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_record_id := COUNT(GROUP,%Closest%.Diff_record_id);
    Count_Diff_filing_type := COUNT(GROUP,%Closest%.Diff_filing_type);
    Count_Diff_filing_subtype := COUNT(GROUP,%Closest%.Diff_filing_subtype);
    Count_Diff_vendor := COUNT(GROUP,%Closest%.Diff_vendor);
    Count_Diff_source_file := COUNT(GROUP,%Closest%.Diff_source_file);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_state_origin := COUNT(GROUP,%Closest%.Diff_state_origin);
    Count_Diff_party1_type := COUNT(GROUP,%Closest%.Diff_party1_type);
    Count_Diff_party1_name_format := COUNT(GROUP,%Closest%.Diff_party1_name_format);
    Count_Diff_party1_name := COUNT(GROUP,%Closest%.Diff_party1_name);
    Count_Diff_party1_alias := COUNT(GROUP,%Closest%.Diff_party1_alias);
    Count_Diff_party1_dob := COUNT(GROUP,%Closest%.Diff_party1_dob);
    Count_Diff_party1_birth_state := COUNT(GROUP,%Closest%.Diff_party1_birth_state);
    Count_Diff_party1_age := COUNT(GROUP,%Closest%.Diff_party1_age);
    Count_Diff_party1_race := COUNT(GROUP,%Closest%.Diff_party1_race);
    Count_Diff_party1_addr1 := COUNT(GROUP,%Closest%.Diff_party1_addr1);
    Count_Diff_party1_csz := COUNT(GROUP,%Closest%.Diff_party1_csz);
    Count_Diff_party1_county := COUNT(GROUP,%Closest%.Diff_party1_county);
    Count_Diff_party1_previous_marital_status := COUNT(GROUP,%Closest%.Diff_party1_previous_marital_status);
    Count_Diff_party1_how_marriage_ended := COUNT(GROUP,%Closest%.Diff_party1_how_marriage_ended);
    Count_Diff_party1_times_married := COUNT(GROUP,%Closest%.Diff_party1_times_married);
    Count_Diff_party1_last_marriage_end_dt := COUNT(GROUP,%Closest%.Diff_party1_last_marriage_end_dt);
    Count_Diff_party2_type := COUNT(GROUP,%Closest%.Diff_party2_type);
    Count_Diff_party2_name_format := COUNT(GROUP,%Closest%.Diff_party2_name_format);
    Count_Diff_party2_name := COUNT(GROUP,%Closest%.Diff_party2_name);
    Count_Diff_party2_alias := COUNT(GROUP,%Closest%.Diff_party2_alias);
    Count_Diff_party2_dob := COUNT(GROUP,%Closest%.Diff_party2_dob);
    Count_Diff_party2_birth_state := COUNT(GROUP,%Closest%.Diff_party2_birth_state);
    Count_Diff_party2_age := COUNT(GROUP,%Closest%.Diff_party2_age);
    Count_Diff_party2_race := COUNT(GROUP,%Closest%.Diff_party2_race);
    Count_Diff_party2_addr1 := COUNT(GROUP,%Closest%.Diff_party2_addr1);
    Count_Diff_party2_csz := COUNT(GROUP,%Closest%.Diff_party2_csz);
    Count_Diff_party2_county := COUNT(GROUP,%Closest%.Diff_party2_county);
    Count_Diff_party2_previous_marital_status := COUNT(GROUP,%Closest%.Diff_party2_previous_marital_status);
    Count_Diff_party2_how_marriage_ended := COUNT(GROUP,%Closest%.Diff_party2_how_marriage_ended);
    Count_Diff_party2_times_married := COUNT(GROUP,%Closest%.Diff_party2_times_married);
    Count_Diff_party2_last_marriage_end_dt := COUNT(GROUP,%Closest%.Diff_party2_last_marriage_end_dt);
    Count_Diff_number_of_children := COUNT(GROUP,%Closest%.Diff_number_of_children);
    Count_Diff_marriage_filing_dt := COUNT(GROUP,%Closest%.Diff_marriage_filing_dt);
    Count_Diff_marriage_dt := COUNT(GROUP,%Closest%.Diff_marriage_dt);
    Count_Diff_marriage_city := COUNT(GROUP,%Closest%.Diff_marriage_city);
    Count_Diff_marriage_county := COUNT(GROUP,%Closest%.Diff_marriage_county);
    Count_Diff_place_of_marriage := COUNT(GROUP,%Closest%.Diff_place_of_marriage);
    Count_Diff_type_of_ceremony := COUNT(GROUP,%Closest%.Diff_type_of_ceremony);
    Count_Diff_marriage_filing_number := COUNT(GROUP,%Closest%.Diff_marriage_filing_number);
    Count_Diff_marriage_docket_volume := COUNT(GROUP,%Closest%.Diff_marriage_docket_volume);
    Count_Diff_divorce_filing_dt := COUNT(GROUP,%Closest%.Diff_divorce_filing_dt);
    Count_Diff_divorce_dt := COUNT(GROUP,%Closest%.Diff_divorce_dt);
    Count_Diff_divorce_docket_volume := COUNT(GROUP,%Closest%.Diff_divorce_docket_volume);
    Count_Diff_divorce_filing_number := COUNT(GROUP,%Closest%.Diff_divorce_filing_number);
    Count_Diff_divorce_city := COUNT(GROUP,%Closest%.Diff_divorce_city);
    Count_Diff_divorce_county := COUNT(GROUP,%Closest%.Diff_divorce_county);
    Count_Diff_grounds_for_divorce := COUNT(GROUP,%Closest%.Diff_grounds_for_divorce);
    Count_Diff_marriage_duration_cd := COUNT(GROUP,%Closest%.Diff_marriage_duration_cd);
    Count_Diff_marriage_duration := COUNT(GROUP,%Closest%.Diff_marriage_duration);
    Count_Diff_persistent_record_id := COUNT(GROUP,%Closest%.Diff_persistent_record_id);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
