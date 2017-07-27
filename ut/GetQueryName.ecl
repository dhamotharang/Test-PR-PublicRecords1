EXPORT GetQueryName() := FUNCTION;
	string 	QName := thorlib.jobname(); //returns for ex ssn_finder.batchservice.7
	//Second Decimal Position
	integer sdp := stringlib.stringfind(QName,'.',2)-1;
	RETURN IF(sdp>0, QName[1..sdp], QName); //returns for ex ssnfinder.batchservice in lowercase
END;