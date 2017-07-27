export getmatchinginitialstring(string in_text1, string in_text2) :=
function
  return regexreplace('^(.*).*\\0001\\0002\\0003\\1.*$',in_text1 + '\001\002\003' + in_text2,'$1');
end;