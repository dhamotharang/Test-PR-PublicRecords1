IMPORT FFD;
EXPORT Constants := MODULE
	EXPORT STRING20 FCRA_Restricted := 'FCRA Restricted';
	
	EXPORT ALERT_CODE := MODULE
		EXPORT STRING INSUFFICIENT_INPUT_INFO := '50A';
		EXPORT STRING SECURITY_FREEZE := '100A';
		EXPORT STRING SECURITY_FRAUD_ALERT := '100B';
		EXPORT STRING CONSUMER_STATEMENT := '100C';
		EXPORT STRING STATE_EXCEPTION := '100D';
		EXPORT STRING IDENTITY_THEFT_ALERT := '100E';
		EXPORT STRING LEGAL_HOLD_ALERT := '100F';
		EXPORT STRING NO_DID_FOUND := '222A';
	END;

 SHARED ds_alerts := DATASET ([
					{ALERT_CODE.INSUFFICIENT_INPUT_INFO, 'Insufficient Input','',''},
					{ALERT_CODE.STATE_EXCEPTION, 'Insufficient verification to return a score under state or federal law', '', ''},
					{ALERT_CODE.NO_DID_FOUND, 'No consumer file was found matching the input information', '', ''},
					{ALERT_CODE.CONSUMER_STATEMENT, 'Consumer Statement on file', FFD.Constants.RecordType.CS, FFD.Constants.AlertMessage.CSMessage},
					{ALERT_CODE.IDENTITY_THEFT_ALERT, 'Identity Theft Alert',FFD.Constants.RecordType.IT, FFD.Constants.AlertMessage.IDTheftMessage},
					{ALERT_CODE.LEGAL_HOLD_ALERT, 'Legal Hold Alert', FFD.Constants.RecordType.LH, ''},
					{ALERT_CODE.SECURITY_FREEZE, 'Security Freeze on file', FFD.Constants.RecordType.SF, FFD.Constants.AlertMessage.FreezeMessage},
					{ALERT_CODE.SECURITY_FRAUD_ALERT, 'Security Fraud Alert on file',  FFD.Constants.RecordType.FA, FFD.Constants.AlertMessage.FraudMessage}
  ], {STRING code, STRING description, STRING alert_type, STRING message});
  
 dict_AlertCode2Description := DICTIONARY (ds_alerts, {code => description});
	EXPORT STRING getAlertDescription(STRING cd) := dict_AlertCode2Description[cd].description;
  
 dict_AlertCode2Message := DICTIONARY (ds_alerts, {code => message});
	EXPORT STRING getAlertMessage(STRING cd) := dict_AlertCode2Message[cd].message;
  
 dict_AlertType2Code := DICTIONARY (ds_alerts(alert_type<>''), {alert_type => code});
	EXPORT STRING convertAlertType2Code(STRING cd) := dict_AlertType2Code[cd].code;
	
		
END;