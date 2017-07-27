EXPORT fn_countWords(STRING LineIn) := FUNCTION
  PATTERN Ltrs := PATTERN('[A-Za-z]');
  PATTERN Char := Ltrs | '-' | '\'';
  TOKEN Word := Char+;
  ds := DATASET([{LineIn}],{STRING line});
  parsedWords := PARSE(ds,line,Word,{STRING Pword := MATCHTEXT(Word)});
return count(parsedWords);
END;