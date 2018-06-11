﻿IMPORT BatchShare,Gateway,Phones;

EXPORT IParam := MODULE
	
	EXPORT PhoneAttributes := MODULE
		EXPORT BatchParams := INTERFACE(BatchShare.IParam.BatchParams)
			EXPORT BOOLEAN 		return_current								:= TRUE;
			EXPORT BOOLEAN		include_temp_susp_reactivate 	:= FALSE;
			EXPORT UNSIGNED		max_lidb_age_days				:= Phones.Constants.PhoneAttributes.LastActivityThreshold; 
			EXPORT BOOLEAN		use_realtime_lidb				:= FALSE;
			EXPORT DATASET(Gateway.Layouts.Config) gateways := DATASET ([], Gateway.Layouts.Config);
		END;	

		EXPORT getBatchParams() := 
		FUNCTION
			
			mBaseParams := BatchShare.IParam.getBatchParams();
			
			in_mod := MODULE(PROJECT(mBaseParams, BatchParams, OPT))							
				EXPORT BOOLEAN return_current								:= TRUE 	: STORED('return_current');									
				EXPORT BOOLEAN include_temp_susp_reactivate	:= FALSE 	: STORED('include_temp_susp_reactivate');			
				EXPORT UNSIGNED max_lidb_age_days						:= Phones.Constants.PhoneAttributes.LastActivityThreshold	: STORED('max_lidb_age_days');			
				EXPORT BOOLEAN use_realtime_lidb						:= FALSE 	: STORED('use_realtime_lidb');			
				EXPORT DATASET (Gateway.Layouts.Config) gateways := Gateway.Configuration.Get(); 
			END;
			
			RETURN in_mod;
		END;	
	END;
	
	EXPORT inZumigoParams := INTERFACE
		EXPORT STRING20 useCase := '';
		EXPORT STRING3 	productCode := '';
		EXPORT STRING8	billingId := '';
		EXPORT STRING20 productName := '';
		EXPORT UNSIGNED	NameAddressPairs := Phones.Constants.ZumigoMaxValidation;
		EXPORT BOOLEAN 	NameAddressValidation := FALSE;
		EXPORT BOOLEAN	NameAddressInfo := FALSE;
		EXPORT BOOLEAN	AccountInfo := FALSE;
		EXPORT BOOLEAN	CarrierInfo := FALSE;
		EXPORT BOOLEAN	CallHandlingInfo := FALSE;
		EXPORT BOOLEAN	DeviceInfo := FALSE;
		EXPORT BOOLEAN 	DeviceChangeOption := FALSE;
		EXPORT BOOLEAN 	DeviceHistory := FALSE;
		EXPORT STRING10 optInType := '';
		EXPORT STRING5 	optInMethod := '';
		EXPORT STRING3 	optinDuration := '';
		EXPORT STRING 	optinId := '';
		EXPORT STRING 	optInVersionId := '';
		EXPORT STRING15 optInTimestamp := '';
		EXPORT DATASET(Gateway.Layouts.Config) gateways := Gateway.Constants.void_gateway;
	END;				
END;