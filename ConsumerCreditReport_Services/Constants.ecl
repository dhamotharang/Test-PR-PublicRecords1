IMPORT AutoKeyI, iesp, Gateway;

EXPORT Constants := MODULE

	EXPORT INTEGER SCORE_THRESHOLD := 80;
	
	EXPORT STRING GLB_REQUIRED_MSG := 'GLBA permissible purpose is required';

	EXPORT NO_LEXID_FOUND_CODE       := AutoKeyI.errorcodes._codes.NO_RECORDS;
	EXPORT TOO_MANY_SUBJECTS_CODE    := AutoKeyI.errorcodes._codes.TOO_MANY_SUBJECTS;
	EXPORT CONSUMER_ALERT_CODE       := 300;  // not reported in results, for internal use only
	EXPORT INSUFFICIENT_INPUT_CODE   := AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT;
	EXPORT NON_MATCHING_LEXID_CODE   := AutoKeyI.errorcodes._codes.LEXID_FAIL;
	EXPORT SOAP_ERROR_CODE           := AutoKeyI.errorcodes._codes.SOAP_ERR;
	
	EXPORT NO_LEXID_FOUND       := DATASET([{'Roxie',NO_LEXID_FOUND_CODE,'',AutoKeyI.errorcodes._msgs(NO_LEXID_FOUND_CODE)}],iesp.share.t_WsException);
	EXPORT TOO_MANY_SUBJECTS_I  := DATASET([{'Roxie',TOO_MANY_SUBJECTS_CODE,'Input',AutoKeyI.errorcodes._msgs(TOO_MANY_SUBJECTS_CODE)}],iesp.share.t_WsException);
	EXPORT TOO_MANY_SUBJECTS_G  := DATASET([{'Roxie',TOO_MANY_SUBJECTS_CODE,'Gateway',AutoKeyI.errorcodes._msgs(TOO_MANY_SUBJECTS_CODE)}],iesp.share.t_WsException);
	EXPORT INSUFFICIENT_INPUT   := DATASET([{'Roxie',INSUFFICIENT_INPUT_CODE,'',AutoKeyI.errorcodes._msgs(INSUFFICIENT_INPUT_CODE)}],iesp.share.t_WsException);
	EXPORT NON_MATCHING_LEXID   := DATASET([{'Roxie',NON_MATCHING_LEXID_CODE,'',AutoKeyI.errorcodes._msgs(NON_MATCHING_LEXID_CODE)}],iesp.share.t_WsException);
	EXPORT SOAP_ERROR_CCR       := DATASET([{'Roxie',SOAP_ERROR_CODE,Gateway.Constants.ServiceName.consumerCreditReport,AutoKeyI.errorcodes._msgs(SOAP_ERROR_CODE)}],iesp.share.t_WsException);

END;