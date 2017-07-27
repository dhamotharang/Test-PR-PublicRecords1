String InMedschool := 'SHANGHAI FIRST MED COLL (NAT LSHANGHAI MED COLL)';
String InState := '';
Integer InThreshold := 50;
getbestMedschool := Healthcare_Cleaners.Functions_Medschool.getBestMatch(InMedschool,InState,InThreshold);
output(getbestMedschool,named('getbestMedschool'));
