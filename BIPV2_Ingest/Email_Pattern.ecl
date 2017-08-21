EXPORT Email_Pattern(string email):=FUNCTION
  //regex:='^[A-Z0-9]+([A-Z0-9_.-]+[A-Z0-9])?\\@[A-Z0-9][A-Z0-9.-]*[A-Z0-9]\\.[A-Z0-9-]{2,6}$';
	regex:='^(?=[A-Z0-9][A-Z0-9@._%+-]{5,253}+$)[A-Z0-9._%+-]{1,64}+@(?:(?=[A-Z0-9-]{1,63}+\\.)[A-Z0-9]++(?:-[A-Z0-9]++)*+\\.){1,8}+[A-Z]{2,63}+$';
	BB:=REGEXFIND(regex, trim(email)) OR length(trim(email))=0;    
  RETURN BB;
END;  