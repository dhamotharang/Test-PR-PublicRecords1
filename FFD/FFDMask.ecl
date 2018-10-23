IMPORT $,ut,STD,AutoStandardI;
EXPORT FFDMask := MODULE
	isFCRA := TRUE;
	STRING inFFDMaskSTORED := '0' : STORED('FFDOptionsMask'); 
	STRING inApplicationTypeSTORED := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.InterfaceTranslator.application_type_val.params));

	EXPORT INTEGER8 Get(STRING inFFDMask = '', STRING inApplicationType = '') := FUNCTION
		FFDMask_pre := TRIM(IF(inFFDMask<>'', inFFDMask, inFFDMaskSTORED));   
		ApplicationType := TRIM(IF(inApplicationType<>'', inApplicationType, inApplicationTypeSTORED));
		BankruptcyBit := IF(ApplicationType IN AutoStandardI.Constants.COLLECTION_TYPES,$.Constants.ConsumerOptions.SHOW_DISPUTED_BANKRUPTCY,0); 

		FFDMask_out := ut.BinaryStringToInteger(STD.Str.Reverse(FFDMask_pre)) | BankruptcyBit;

		RETURN FFDMask_out;
	END;
	
	//1st position in FFDOptionsMask string
	EXPORT BOOLEAN isShowConsumerStatements(INTEGER8 inFFDMask) := (inFFDMask & $.Constants.ConsumerOptions.SHOW_CONSUMER_STATEMENTS) = $.Constants.ConsumerOptions.SHOW_CONSUMER_STATEMENTS;
	//2nd position in FFDOptionsMask string (plus 1st position should be set to be enforced)
	EXPORT BOOLEAN isShowDisputedBankruptcies(INTEGER8 inFFDMask) := isShowConsumerStatements(inFFDMask) AND (inFFDMask & $.Constants.ConsumerOptions.SHOW_DISPUTED_BANKRUPTCY) = $.Constants.ConsumerOptions.SHOW_DISPUTED_BANKRUPTCY;
	//3rd position in FFDOptionsMask string
	EXPORT BOOLEAN isSuppressRecordsWhenITAlert(INTEGER8 inFFDMask) := (inFFDMask & $.Constants.ConsumerOptions.SUPPRESS_RECORDS_WHEN_IT_ALERT) = $.Constants.ConsumerOptions.SUPPRESS_RECORDS_WHEN_IT_ALERT;
	//4th position in FFDOptionsMask string
	EXPORT BOOLEAN isShowDisputed(INTEGER8 inFFDMask) := (inFFDMask & $.Constants.ConsumerOptions.SHOW_DISPUTED) = $.Constants.ConsumerOptions.SHOW_DISPUTED;
	
	// EXPORT SetMask(STRING strFFDMask) := FUNCTION
		// #stored('FFDOptionsMask', strFFDMask);
		// RETURN OUTPUT (dataset ([],{INTEGER x}), NAMED('__internal__'), EXTEND);
	// END;
	
END;