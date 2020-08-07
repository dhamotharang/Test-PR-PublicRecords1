EXPORT getmatchinginitialstring(STRING in_text1, STRING in_text2) :=
FUNCTION
  RETURN regexreplace('^(.*).*\\0001\\0002\\0003\\1.*$',in_text1 + '\001\002\003' + in_text2,'$1');
END;
