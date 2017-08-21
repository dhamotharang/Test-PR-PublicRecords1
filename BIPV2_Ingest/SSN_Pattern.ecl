EXPORT SSN_Pattern(string ssn_str):=FUNCTION
  regex:='^XXXXX\\d{4}';
	BB:=REGEXFIND(regex, ssn_str);    //'XXXXX1234'
	CC:=if(Stringlib.StringFilterout(ssn_str,'0123456789')='',true,false);
  RETURN BB OR CC;
END;  