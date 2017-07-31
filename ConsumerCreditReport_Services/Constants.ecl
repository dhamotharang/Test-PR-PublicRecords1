IMPORT AutoKeyI, iesp, Gateway;

EXPORT Constants := MODULE

	EXPORT INTEGER SCORE_THRESHOLD := 80;
	
	EXPORT STRING SECURITY_FRAUD_ALERT_MSG1 :=
	'The subject of this consumer report currently has a Security Fraud Alert on file preventing the return of the information you requested.';
	EXPORT STRING SECURITY_FRAUD_ALERT_MSG2 :=
	'If the consumer would like their Security Fraud Alert lifted please instruct them to call LexisNexis Risk Solutions Inc. at 800-456-1244';

	EXPORT NO_LEXID_FOUND_CODE       := AutoKeyI.errorcodes._codes.NO_RECORDS;
	EXPORT TOO_MANY_SUBJECTS_CODE    := AutoKeyI.errorcodes._codes.TOO_MANY_SUBJECTS;
	EXPORT SECURITY_FRAUD_ALERT_CODE := 300;
	EXPORT INSUFFICIENT_INPUT_CODE   := AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT;
	EXPORT NON_MATCHING_LEXID_CODE   := AutoKeyI.errorcodes._codes.LEXID_FAIL;
	EXPORT SOAP_ERROR_CODE           := AutoKeyI.errorcodes._codes.SOAP_ERR;
	
	EXPORT NO_LEXID_FOUND       := DATASET([{'Roxie',NO_LEXID_FOUND_CODE,'',AutoKeyI.errorcodes._msgs(NO_LEXID_FOUND_CODE)}],iesp.share.t_WsException);
	EXPORT TOO_MANY_SUBJECTS_I  := DATASET([{'Roxie',TOO_MANY_SUBJECTS_CODE,'Input',AutoKeyI.errorcodes._msgs(TOO_MANY_SUBJECTS_CODE)}],iesp.share.t_WsException);
	EXPORT TOO_MANY_SUBJECTS_G  := DATASET([{'Roxie',TOO_MANY_SUBJECTS_CODE,'Gateway',AutoKeyI.errorcodes._msgs(TOO_MANY_SUBJECTS_CODE)}],iesp.share.t_WsException);
	EXPORT SECURITY_FRAUD_ALERT := DATASET([{'Roxie',SECURITY_FRAUD_ALERT_CODE,'',SECURITY_FRAUD_ALERT_MSG1},{'Roxie',SECURITY_FRAUD_ALERT_CODE,'',SECURITY_FRAUD_ALERT_MSG2}],iesp.share.t_WsException);
	EXPORT INSUFFICIENT_INPUT   := DATASET([{'Roxie',INSUFFICIENT_INPUT_CODE,'',AutoKeyI.errorcodes._msgs(INSUFFICIENT_INPUT_CODE)}],iesp.share.t_WsException);
	EXPORT NON_MATCHING_LEXID   := DATASET([{'Roxie',NON_MATCHING_LEXID_CODE,'',AutoKeyI.errorcodes._msgs(NON_MATCHING_LEXID_CODE)}],iesp.share.t_WsException);
	EXPORT SOAP_ERROR_CCR       := DATASET([{'Roxie',SOAP_ERROR_CODE,Gateway.Constants.ServiceName.consumerCreditReport,AutoKeyI.errorcodes._msgs(SOAP_ERROR_CODE)}],iesp.share.t_WsException);

END;