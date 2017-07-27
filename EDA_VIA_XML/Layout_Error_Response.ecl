export Layout_Error_Response := RECORD
	UNSIGNED2 errorCode;
	VARSTRING errorMessage;
	VARSTRING errorDescription;
END;