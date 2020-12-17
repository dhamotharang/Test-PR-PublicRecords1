IMPORT BatchShare,Gateway,Phones, AutoStandardI, iesp, suppress,doxie;

EXPORT IParam := MODULE

 SHARED mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule());

 EXPORT ReportParams := INTERFACE (doxie.IDataAccess)
   export UNSIGNED2 PenaltThreshold   := Phones.Constants.PenaltThreshold;
	 export UNSIGNED8 MaxResults        := Phones.Constants.MaxResults;
   export boolean 		ReturnCurrentOnly	:= false;
   export boolean 		RunDeepDive			:= false;
   export BOOLEAN 		return_current		:= true;
   export UNSIGNED		max_age_days	:= Phones.Constants.PhoneAttributes.LastActivityThreshold;
   export DATASET(Gateway.Layouts.Config) gateways := DATASET ([], Gateway.Layouts.Config);
 END;

 EXPORT getReportParams(iesp.phonemetadatasearch.t_PhoneMetadataSearchOption  report_opt) :=
   		FUNCTION
     in_mod := MODULE(PROJECT(mod_access, ReportParams, opt));
			 EXPORT UNSIGNED8 	MaxResults	:= report_opt.MaxResults;
       EXPORT BOOLEAN  return_current         := report_opt.ReturnCurrent;
       EXPORT UNSIGNED  max_age_days     := IF(report_opt.MaxAgeDays <> 0, report_opt.MaxAgeDays, Phones.Constants.PhoneAttributes.LastActivityThreshold);
       EXPORT DATASET (Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
     END;
 	 RETURN in_mod;
  END;

  EXPORT BatchParams := INTERFACE(BatchShare.IParam.BatchParams)
    EXPORT BOOLEAN 		return_current                 := TRUE;
    EXPORT BOOLEAN		include_temp_susp_reactivate   := FALSE;
    EXPORT BOOLEAN    AllowPortingData := FALSE;
    EXPORT UNSIGNED		max_lidb_age_days              := Phones.Constants.PhoneAttributes.LastActivityThreshold;
	EXPORT UNSIGNED		max_age_days              := Phones.Constants.PhoneAttributes.LastActivityThreshold;
    EXPORT DATASET(Gateway.Layouts.Config) gateways    := DATASET ([], Gateway.Layouts.Config);
	EXPORT BOOLEAN Allow_TCPA_Port := FALSE;
  END;	

		EXPORT getBatchParams() :=
		FUNCTION

			mBaseParams := BatchShare.IParam.getBatchParams();

			in_mod := MODULE(PROJECT(mBaseParams, BatchParams, OPT))
				EXPORT BOOLEAN return_current								:= TRUE 	: STORED('return_current');
				EXPORT BOOLEAN include_temp_susp_reactivate	:= FALSE 	: STORED('include_temp_susp_reactivate');
				EXPORT UNSIGNED max_lidb_age_days						:= Phones.Constants.PhoneAttributes.LastActivityThreshold	: STORED('max_lidb_age_days');
				EXPORT UNSIGNED max_age_days					:= Phones.Constants.PhoneAttributes.LastActivityThreshold : STORED('max_age_days');
				EXPORT DATASET (Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
			END;

			RETURN in_mod;
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
		EXPORT BOOLEAN 	DeviceChangeInfo := FALSE;
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
