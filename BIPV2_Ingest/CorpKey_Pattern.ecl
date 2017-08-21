EXPORT CorpKey_Pattern(string corpkey):=FUNCTION
  regex:='^[0-9][0-9]-[A-Z0-9][A-Z0-9-]*';
	BB:=REGEXFIND(regex, trim(corpkey)) OR length(trim(corpkey))=0;    //'XXXXX1234'
  RETURN BB;
END;  