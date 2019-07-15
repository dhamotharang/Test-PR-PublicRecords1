IMPORT SALT39;
EXPORT Fields := MODULE
 
EXPORT NumFields := 21;
 
// Processing for each FieldType
EXPORT SALT39.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'DEFAULT','ALPHA','NAME','NUMBER','WORDBAG','datetime','customer_id','search_function_name','entity_type','field1','field2','field3','field4','field5','field6','field7','field8','field9','field10','field11','field12','field13','field14','field15','field16','id_');
EXPORT FieldTypeNum(SALT39.StrType fn) := CASE(fn,'DEFAULT' => 1,'ALPHA' => 2,'NAME' => 3,'NUMBER' => 4,'WORDBAG' => 5,'datetime' => 6,'customer_id' => 7,'search_function_name' => 8,'entity_type' => 9,'field1' => 10,'field2' => 11,'field3' => 12,'field4' => 13,'field5' => 14,'field6' => 15,'field7' => 16,'field8' => 17,'field9' => 18,'field10' => 19,'field11' => 20,'field12' => 21,'field13' => 22,'field14' => 23,'field15' => 24,'field16' => 25,'id_' => 26,0);
 
EXPORT MakeFT_DEFAULT(SALT39.StrType s0) := FUNCTION
  s1 := if ( SALT39.StringFind('"\'',s0[1],1)>0 and SALT39.StringFind('"\'',s0[LENGTH(TRIM(s0))],1)>0,s0[2..LENGTH(TRIM(s0))-1],s0 );// Remove quotes if required
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_DEFAULT(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,SALT39.StringFind('"\'',s[1],1)<>0 and SALT39.StringFind('"\'',s[LENGTH(TRIM(s))],1)<>0);
EXPORT InValidMessageFT_DEFAULT(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.Inquotes('"\''),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_ALPHA(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_ALPHA(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_ALPHA(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_NAME(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'.'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_NAME(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'.'))));
EXPORT InValidMessageFT_NAME(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'.'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_NUMBER(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_NUMBER(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_NUMBER(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_WORDBAG(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_WORDBAG(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '))));
EXPORT InValidMessageFT_WORDBAG(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_datetime(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NUMBER(s2);
END;
EXPORT InValidFT_datetime(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 2));
EXPORT InValidMessageFT_datetime(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('2'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_customer_id(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_NUMBER(s2);
END;
EXPORT InValidFT_customer_id(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_customer_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_search_function_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,' -BRTacdeghilmrtÂ€Â“Ã¢ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_search_function_name(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,' -BRTacdeghilmrtÂ€Â“Ã¢ '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 3));
EXPORT InValidMessageFT_search_function_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars(' -BRTacdeghilmrtÂ€Â“Ã¢ '),SALT39.HygieneErrors.NotWords('3'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_entity_type(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABDEILNSTUVY_ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_entity_type(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABDEILNSTUVY_ '))),~(SALT39.WordCount(SALT39.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_entity_type(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABDEILNSTUVY_ '),SALT39.HygieneErrors.NotWords('1'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_field1(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_field1(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '))));
EXPORT InValidMessageFT_field1(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_field2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_field2(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '))));
EXPORT InValidMessageFT_field2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_field3(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_field3(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '))));
EXPORT InValidMessageFT_field3(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_field4(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_field4(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '))));
EXPORT InValidMessageFT_field4(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_field5(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_field5(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '))));
EXPORT InValidMessageFT_field5(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_field6(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_field6(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '))));
EXPORT InValidMessageFT_field6(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_field7(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_field7(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '))));
EXPORT InValidMessageFT_field7(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_field8(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_field8(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '))));
EXPORT InValidMessageFT_field8(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_field9(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_field9(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '))));
EXPORT InValidMessageFT_field9(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_field10(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_field10(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '))));
EXPORT InValidMessageFT_field10(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_field11(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_field11(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '))));
EXPORT InValidMessageFT_field11(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_field12(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_field12(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '))));
EXPORT InValidMessageFT_field12(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_field13(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_field13(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '))));
EXPORT InValidMessageFT_field13(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_field14(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_field14(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '))));
EXPORT InValidMessageFT_field14(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_field15(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_field15(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '))));
EXPORT InValidMessageFT_field15(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_field16(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_field16(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '))));
EXPORT InValidMessageFT_field16(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_id_(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_id_(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '))));
EXPORT InValidMessageFT_id_(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$* '),SALT39.HygieneErrors.Good);
 
EXPORT SALT39.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'datetime','customer_id','search_function_name','entity_type','field1','field2','field3','field4','field5','field6','field7','field8','field9','field10','field11','field12','field13','field14','field15','field16','id_');
EXPORT SALT39.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'datetime','customer_id','search_function_name','entity_type','field1','field2','field3','field4','field5','field6','field7','field8','field9','field10','field11','field12','field13','field14','field15','field16','id_');
EXPORT FieldNum(SALT39.StrType fn) := CASE(fn,'datetime' => 0,'customer_id' => 1,'search_function_name' => 2,'entity_type' => 3,'field1' => 4,'field2' => 5,'field3' => 6,'field4' => 7,'field5' => 8,'field6' => 9,'field7' => 10,'field8' => 11,'field9' => 12,'field10' => 13,'field11' => 14,'field12' => 15,'field13' => 16,'field14' => 17,'field15' => 18,'field16' => 19,'id_' => 20,0);
EXPORT SET OF SALT39.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW','WORDS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_datetime(SALT39.StrType s0) := MakeFT_datetime(s0);
EXPORT InValid_datetime(SALT39.StrType s) := InValidFT_datetime(s);
EXPORT InValidMessage_datetime(UNSIGNED1 wh) := InValidMessageFT_datetime(wh);
 
EXPORT Make_customer_id(SALT39.StrType s0) := MakeFT_datetime(s0);
EXPORT InValid_customer_id(SALT39.StrType s) := InValidFT_datetime(s);
EXPORT InValidMessage_customer_id(UNSIGNED1 wh) := InValidMessageFT_datetime(wh);
 
EXPORT Make_search_function_name(SALT39.StrType s0) := MakeFT_datetime(s0);
EXPORT InValid_search_function_name(SALT39.StrType s) := InValidFT_datetime(s);
EXPORT InValidMessage_search_function_name(UNSIGNED1 wh) := InValidMessageFT_datetime(wh);
 
EXPORT Make_entity_type(SALT39.StrType s0) := MakeFT_datetime(s0);
EXPORT InValid_entity_type(SALT39.StrType s) := InValidFT_datetime(s);
EXPORT InValidMessage_entity_type(UNSIGNED1 wh) := InValidMessageFT_datetime(wh);
 
EXPORT Make_field1(SALT39.StrType s0) := MakeFT_field1(s0);
EXPORT InValid_field1(SALT39.StrType s) := InValidFT_field1(s);
EXPORT InValidMessage_field1(UNSIGNED1 wh) := InValidMessageFT_field1(wh);
 
EXPORT Make_field2(SALT39.StrType s0) := MakeFT_field2(s0);
EXPORT InValid_field2(SALT39.StrType s) := InValidFT_field2(s);
EXPORT InValidMessage_field2(UNSIGNED1 wh) := InValidMessageFT_field2(wh);
 
EXPORT Make_field3(SALT39.StrType s0) := MakeFT_field3(s0);
EXPORT InValid_field3(SALT39.StrType s) := InValidFT_field3(s);
EXPORT InValidMessage_field3(UNSIGNED1 wh) := InValidMessageFT_field3(wh);
 
EXPORT Make_field4(SALT39.StrType s0) := MakeFT_field4(s0);
EXPORT InValid_field4(SALT39.StrType s) := InValidFT_field4(s);
EXPORT InValidMessage_field4(UNSIGNED1 wh) := InValidMessageFT_field4(wh);
 
EXPORT Make_field5(SALT39.StrType s0) := MakeFT_field5(s0);
EXPORT InValid_field5(SALT39.StrType s) := InValidFT_field5(s);
EXPORT InValidMessage_field5(UNSIGNED1 wh) := InValidMessageFT_field5(wh);
 
EXPORT Make_field6(SALT39.StrType s0) := MakeFT_field6(s0);
EXPORT InValid_field6(SALT39.StrType s) := InValidFT_field6(s);
EXPORT InValidMessage_field6(UNSIGNED1 wh) := InValidMessageFT_field6(wh);
 
EXPORT Make_field7(SALT39.StrType s0) := MakeFT_field7(s0);
EXPORT InValid_field7(SALT39.StrType s) := InValidFT_field7(s);
EXPORT InValidMessage_field7(UNSIGNED1 wh) := InValidMessageFT_field7(wh);
 
EXPORT Make_field8(SALT39.StrType s0) := MakeFT_field8(s0);
EXPORT InValid_field8(SALT39.StrType s) := InValidFT_field8(s);
EXPORT InValidMessage_field8(UNSIGNED1 wh) := InValidMessageFT_field8(wh);
 
EXPORT Make_field9(SALT39.StrType s0) := MakeFT_field9(s0);
EXPORT InValid_field9(SALT39.StrType s) := InValidFT_field9(s);
EXPORT InValidMessage_field9(UNSIGNED1 wh) := InValidMessageFT_field9(wh);
 
EXPORT Make_field10(SALT39.StrType s0) := MakeFT_field10(s0);
EXPORT InValid_field10(SALT39.StrType s) := InValidFT_field10(s);
EXPORT InValidMessage_field10(UNSIGNED1 wh) := InValidMessageFT_field10(wh);
 
EXPORT Make_field11(SALT39.StrType s0) := MakeFT_field11(s0);
EXPORT InValid_field11(SALT39.StrType s) := InValidFT_field11(s);
EXPORT InValidMessage_field11(UNSIGNED1 wh) := InValidMessageFT_field11(wh);
 
EXPORT Make_field12(SALT39.StrType s0) := MakeFT_field12(s0);
EXPORT InValid_field12(SALT39.StrType s) := InValidFT_field12(s);
EXPORT InValidMessage_field12(UNSIGNED1 wh) := InValidMessageFT_field12(wh);
 
EXPORT Make_field13(SALT39.StrType s0) := MakeFT_field13(s0);
EXPORT InValid_field13(SALT39.StrType s) := InValidFT_field13(s);
EXPORT InValidMessage_field13(UNSIGNED1 wh) := InValidMessageFT_field13(wh);
 
EXPORT Make_field14(SALT39.StrType s0) := MakeFT_field14(s0);
EXPORT InValid_field14(SALT39.StrType s) := InValidFT_field14(s);
EXPORT InValidMessage_field14(UNSIGNED1 wh) := InValidMessageFT_field14(wh);
 
EXPORT Make_field15(SALT39.StrType s0) := MakeFT_field15(s0);
EXPORT InValid_field15(SALT39.StrType s) := InValidFT_field15(s);
EXPORT InValidMessage_field15(UNSIGNED1 wh) := InValidMessageFT_field15(wh);
 
EXPORT Make_field16(SALT39.StrType s0) := MakeFT_field16(s0);
EXPORT InValid_field16(SALT39.StrType s) := InValidFT_field16(s);
EXPORT InValidMessage_field16(UNSIGNED1 wh) := InValidMessageFT_field16(wh);
 
EXPORT Make_id_(SALT39.StrType s0) := MakeFT_id_(s0);
EXPORT InValid_id_(SALT39.StrType s) := InValidFT_id_(s);
EXPORT InValidMessage_id_(UNSIGNED1 wh) := InValidMessageFT_id_(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT39,Scrubs_Inql_Nfcra_Bridger;
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
    BOOLEAN Diff_datetime;
    BOOLEAN Diff_customer_id;
    BOOLEAN Diff_search_function_name;
    BOOLEAN Diff_entity_type;
    BOOLEAN Diff_field1;
    BOOLEAN Diff_field2;
    BOOLEAN Diff_field3;
    BOOLEAN Diff_field4;
    BOOLEAN Diff_field5;
    BOOLEAN Diff_field6;
    BOOLEAN Diff_field7;
    BOOLEAN Diff_field8;
    BOOLEAN Diff_field9;
    BOOLEAN Diff_field10;
    BOOLEAN Diff_field11;
    BOOLEAN Diff_field12;
    BOOLEAN Diff_field13;
    BOOLEAN Diff_field14;
    BOOLEAN Diff_field15;
    BOOLEAN Diff_field16;
    BOOLEAN Diff_id_;
    UNSIGNED Num_Diffs;
    SALT39.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_datetime := le.datetime <> ri.datetime;
    SELF.Diff_customer_id := le.customer_id <> ri.customer_id;
    SELF.Diff_search_function_name := le.search_function_name <> ri.search_function_name;
    SELF.Diff_entity_type := le.entity_type <> ri.entity_type;
    SELF.Diff_field1 := le.field1 <> ri.field1;
    SELF.Diff_field2 := le.field2 <> ri.field2;
    SELF.Diff_field3 := le.field3 <> ri.field3;
    SELF.Diff_field4 := le.field4 <> ri.field4;
    SELF.Diff_field5 := le.field5 <> ri.field5;
    SELF.Diff_field6 := le.field6 <> ri.field6;
    SELF.Diff_field7 := le.field7 <> ri.field7;
    SELF.Diff_field8 := le.field8 <> ri.field8;
    SELF.Diff_field9 := le.field9 <> ri.field9;
    SELF.Diff_field10 := le.field10 <> ri.field10;
    SELF.Diff_field11 := le.field11 <> ri.field11;
    SELF.Diff_field12 := le.field12 <> ri.field12;
    SELF.Diff_field13 := le.field13 <> ri.field13;
    SELF.Diff_field14 := le.field14 <> ri.field14;
    SELF.Diff_field15 := le.field15 <> ri.field15;
    SELF.Diff_field16 := le.field16 <> ri.field16;
    SELF.Diff_id_ := le.id_ <> ri.id_;
    SELF.Val := (SALT39.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_datetime,1,0)+ IF( SELF.Diff_customer_id,1,0)+ IF( SELF.Diff_search_function_name,1,0)+ IF( SELF.Diff_entity_type,1,0)+ IF( SELF.Diff_field1,1,0)+ IF( SELF.Diff_field2,1,0)+ IF( SELF.Diff_field3,1,0)+ IF( SELF.Diff_field4,1,0)+ IF( SELF.Diff_field5,1,0)+ IF( SELF.Diff_field6,1,0)+ IF( SELF.Diff_field7,1,0)+ IF( SELF.Diff_field8,1,0)+ IF( SELF.Diff_field9,1,0)+ IF( SELF.Diff_field10,1,0)+ IF( SELF.Diff_field11,1,0)+ IF( SELF.Diff_field12,1,0)+ IF( SELF.Diff_field13,1,0)+ IF( SELF.Diff_field14,1,0)+ IF( SELF.Diff_field15,1,0)+ IF( SELF.Diff_field16,1,0)+ IF( SELF.Diff_id_,1,0);
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
    Count_Diff_datetime := COUNT(GROUP,%Closest%.Diff_datetime);
    Count_Diff_customer_id := COUNT(GROUP,%Closest%.Diff_customer_id);
    Count_Diff_search_function_name := COUNT(GROUP,%Closest%.Diff_search_function_name);
    Count_Diff_entity_type := COUNT(GROUP,%Closest%.Diff_entity_type);
    Count_Diff_field1 := COUNT(GROUP,%Closest%.Diff_field1);
    Count_Diff_field2 := COUNT(GROUP,%Closest%.Diff_field2);
    Count_Diff_field3 := COUNT(GROUP,%Closest%.Diff_field3);
    Count_Diff_field4 := COUNT(GROUP,%Closest%.Diff_field4);
    Count_Diff_field5 := COUNT(GROUP,%Closest%.Diff_field5);
    Count_Diff_field6 := COUNT(GROUP,%Closest%.Diff_field6);
    Count_Diff_field7 := COUNT(GROUP,%Closest%.Diff_field7);
    Count_Diff_field8 := COUNT(GROUP,%Closest%.Diff_field8);
    Count_Diff_field9 := COUNT(GROUP,%Closest%.Diff_field9);
    Count_Diff_field10 := COUNT(GROUP,%Closest%.Diff_field10);
    Count_Diff_field11 := COUNT(GROUP,%Closest%.Diff_field11);
    Count_Diff_field12 := COUNT(GROUP,%Closest%.Diff_field12);
    Count_Diff_field13 := COUNT(GROUP,%Closest%.Diff_field13);
    Count_Diff_field14 := COUNT(GROUP,%Closest%.Diff_field14);
    Count_Diff_field15 := COUNT(GROUP,%Closest%.Diff_field15);
    Count_Diff_field16 := COUNT(GROUP,%Closest%.Diff_field16);
    Count_Diff_id_ := COUNT(GROUP,%Closest%.Diff_id_);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
