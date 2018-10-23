﻿IMPORT BatchShare,Gateway,Phones, AutoStandardI, iesp, suppress;

EXPORT IParam := MODULE
	
	EXPORT PhoneAttributes := MODULE

 // Global module
	SHARED globalMod := AutoStandardI.GlobalModule(): GLOBAL;

 EXPORT ReportParams := INTERFACE (AutoStandardI.DataPermissionI.params, AutoStandardI.DataRestrictionI.params, AutoStandardI.PermissionI_Tools.params)
   export string32  ApplicationType	  := AutoStandardI.InterfaceTranslator.application_type_val.val(project(globalMod, AutoStandardI.InterfaceTranslator.application_type_val.params));
   export STRING5   IndustryClass     := AutoStandardI.InterfaceTranslator.industry_class_val.val(PROJECT(globalMod, AutoStandardI.InterfaceTranslator.industry_class_val.params));	// D2C - consumer restriction
   export STRING6   DOBMask           := AutoStandardI.InterfaceTranslator.dob_mask_val.val(PROJECT(globalMod, AutoStandardI.InterfaceTranslator.dob_mask_val.params));
   export STRING6   SSNMask           := AutoStandardI.InterfaceTranslator.ssn_mask_val.val(PROJECT(globalMod, AutoStandardI.InterfaceTranslator.ssn_mask_val.params));
   export Boolean   dl_mask           := AutoStandardI.InterfaceTranslator.dl_mask_value.val(PROJECT(globalMod, AutoStandardI.InterfaceTranslator.dl_mask_value.params)); 
   export UNSIGNED2 PenaltThreshold   := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(project(globalMod, AutoStandardI.InterfaceTranslator.penalt_threshold_value.params));
   export UNSIGNED8 MaxResults        := AutoStandardI.InterfaceTranslator.maxResults_val.val(project(globalMod, AutoStandardI.InterfaceTranslator.maxResults_val.params));	
   export boolean 		ReturnCurrentOnly	:= false;
   export boolean 		RunDeepDive			:= false;
   export BOOLEAN 		return_current		:= true;
   export UNSIGNED		max_lidb_age_days	:= Phones.Constants.PhoneAttributes.LastActivityThreshold; 
   export BOOLEAN		 use_realtime_lidb	:= false;
   export DATASET(Gateway.Layouts.Config) gateways := DATASET ([], Gateway.Layouts.Config);
 END;

 EXPORT getReportParams(iesp.phonemetadatasearch.t_PhoneMetadataSearchOption  report_opt) := 
   		FUNCTION
     in_mod := MODULE(PROJECT(globalMod, ReportParams, opt));								
       EXPORT BOOLEAN  return_current         := report_opt.ReturnCurrent;														
       EXPORT UNSIGNED  max_lidb_age_days     := IF(report_opt.MaxAgeDays <> 0, report_opt.MaxAgeDays, Phones.Constants.PhoneAttributes.LastActivityThreshold);				
       EXPORT BOOLEAN  use_realtime_lidb      := report_opt.UseRealTime;			
       EXPORT DATASET (Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
     END;
 	 RETURN in_mod;
  END;

  EXPORT BatchParams := INTERFACE(BatchShare.IParam.BatchParams)
    EXPORT BOOLEAN 		return_current                 := TRUE;
    EXPORT BOOLEAN		include_temp_susp_reactivate   := FALSE;
    EXPORT UNSIGNED		max_lidb_age_days              := Phones.Constants.PhoneAttributes.LastActivityThreshold; 
    EXPORT BOOLEAN		use_realtime_lidb              := FALSE;
    EXPORT DATASET(Gateway.Layouts.Config) gateways    := DATASET ([], Gateway.Layouts.Config);
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
		EXPORT BOOLEAN	AccountStatusInfo := FALSE;
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
