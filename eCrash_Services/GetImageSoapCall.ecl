/*2017-09-23T00:08:22Z (Lazarenko, Dmitriy (RIS-HBE))
[ECH-5121] implementing append/overwrite supplement images behavior.
*/
IMPORT iesp, Gateway, eCrash_Services;

EXPORT GetImageSoapCall(Gateway.Layouts.Config gatewayCfg) := MODULE
	
	EXPORT GetImages(DATASET(iesp.accident_image.t_AccidentImageRequest) Request) := FUNCTION
		IsSafeToPerformSoap := gatewayCfg.Url <> '' AND gatewayCfg.ServiceName <> '';
		EmptyResponse := dataset([], iesp.accident_image.t_AccidentImageResponseEx);
		
		RETURN IF(
			EXISTS(Request) AND IsSafeToPerformSoap, 
			Gateway.SoapCall_GetReportImage(gatewayCfg, Request), 
			EmptyResponse
		);
	END;
	
	EXPORT GetAccidentImageRequest(
		DATASET(eCrash_Services.Layouts.eCrashRecordStructure) SuperReportRow, 
		DATASET(iesp.accident_image.t_AccidentImageCRUImageHash) ImageHashes, 
		DATASET(iesp.retrieveimage.t_ECrashRetrieveImageRequest) InputRequest,
		BOOLEAN IyetekRedactFlag,
		BOOLEAN isOnlyTm,
		BOOLEAN isExternalGatewayCall) := FUNCTION
		
		Request := InputRequest[1];
		//special logic for Gateways
		IsVendorCrashLogic := Request.ReportBy.Vendor = eCrash_Services.Constants.VENDOR_CRASHLOGIC;
		IsVendorHPD := Request.ReportBy.Vendor = eCrash_Services.Constants.VENDOR_HPD;
		
		iesp.accident_image.t_AccidentImageRequest CreateRequestTm := TRANSFORM
			SELF.Options.IncludeCoverPage := IF(isExternalGatewayCall, FALSE, Request.Options.IncludeCoverPage);
			SELF.Options.DataSource := MAP(IsVendorCrashLogic => eCrash_Services.Constants.VENDOR_CRASHLOGIC_ESP,
                                           IsVendorHPD => eCrash_Services.Constants.VENDOR_HPD,
                                            eCrash_Services.Constants.DATA_SOURCE_IYETEK);
			SELF.Options.DataSource2 := MAP(IsVendorCrashLogic => eCrash_Services.Constants.VENDOR_CRASHLOGIC_ESP,
		                                    IsVendorHPD => eCrash_Services.Constants.VENDOR_HPD_ESP,
                                            SuperReportRow[1].vendor_code);
			SELF.Options.IyetekRoyaltyType := Request.Options.RoyaltyType; 
			SELF.Options.IyetekRedact := IyetekRedactFlag; 
			SELF.Options.RequestType := Request.Options.RequestType;
			SELF.SearchBy.TransactionID := Request.Options.TransactionId; //This is used for external vendor Iyetek
			//orig_accnbr is state_report_number which is being copied over original_case_ident in the deltabase and it's not cleaned from special characters
			// ECH - 4998 - Sprint 11 Apriss Integration - VIYER - assign vendor_report_id instead of orig_accnbr
			SELF.SearchBy.ReportNumber := IF(isExternalGatewayCall, Request.ReportBy.ReportId, SuperReportRow[1].vendor_report_id);
			SELF.SearchBy.AgencyORI := IF(isExternalGatewayCall, Request.ReportBy.AgencyOri, SuperReportRow[1].agency_ori);
			SELF.SearchBy.ReportID := Request.ReportBy.ReportId;
			SELF.SearchBy.ReportType := MAP(IsVendorCrashLogic => eCrash_Services.Constants.REPORT_CODE_ACCIDENT,
			                                IsVendorHPD => eCrash_Services.Constants.REPORT_CODE_ACCIDENT,
			                                SuperReportRow[1].report_type_id);
			SELF.SearchBy.DateOfCrash := IF(isExternalGatewayCall,Request.ReportBy.DateOfCrash,
                                            iesp.ECL2ESP.toDate((UNSIGNED4)SuperReportRow[1].accident_date));
			SELF.SearchBy.State := MAP(IsVendorCrashLogic => eCrash_Services.Constants.KY_STATE_ABBR,
                                       IsVendorHPD => eCrash_Services.Constants.TX_STATE_ABBR,
                                       SuperReportRow[1].jurisdiction_state);
			SELF.User.MaxWaitSeconds := Request.User.MaxWaitSeconds;
			SELF.User.QueryId := Request.User.QueryId;
			SELF.User.AccountNumber  := Request.User.AccountNumber;
			// Below 3 fields are exclusive to HPD, so Assigining directly
			SELF.Options.CustomerType := Request.Options.CustomerType;
			SELF.Options.OrderDate := Request.Options.OrderDate;
			SELF.Options.Fee := Request.Options.Fee;			
			SELF := [];	
		END;	
			
		iesp.accident_image.t_AccidentImageRequest CreateRequest := TRANSFORM
			SELF.Options.DataSource := eCrash_Services.Constants.DATA_SOURCE_CRU;
			SELF.Options.DataSource2 := eCrash_Services.Constants.DATA_SOURCE_CRU;
			SELF.Options.IncludeCoverPage := IF(isExternalGatewayCall, FALSE, Request.Options.IncludeCoverPage);
			SELF.Options.ColoredImage := Request.Options.ColoredImage;
			SELF.Options.Redact := Request.Options.Redact;
			SELF.Options.RequestType := Request.Options.RequestType;
			SELF.SearchBy.ImageHashes := ImageHashes;
			SELF.SearchBy.ReportID := Request.ReportBy.ReportId;
			SELF.User.MaxWaitSeconds := Request.User.MaxWaitSeconds;
			SELF.User.QueryId := Request.User.QueryId;
			SELF.User.AccountNumber  := Request.User.AccountNumber;
			SELF := [];	
		END;	
		
		EmptyRequest := DATASET([], iesp.accident_image.t_AccidentImageRequest);
		Result := 
			MAP(
				NOT EXISTS(SuperReportRow) AND NOT isExternalGatewayCall => EmptyRequest,
				EXISTS(ImageHashes) => DATASET([CreateRequest]),
				isOnlyTm => DATASET([CreateRequestTm]),
				EmptyRequest
		);
		
		// output( DATASET([CreateRequest]),named('CreateRequest'));
		// output(DATASET([CreateRequestTm]),named('CreateRequestTm'));
		RETURN Result;
	END;
	
	EXPORT GetDocumentImageRequest(
		DATASET(iesp.accident_image.t_AccidentImageCRUImageHash) ImageHashes, STRING RequestReportId, BOOLEAN ColoredImage, BOOLEAN Redact, STRING RequestType) := FUNCTION
			
		iesp.accident_image.t_AccidentImageRequest CreateRequest := TRANSFORM
			SELF.Options.DataSource := eCrash_Services.Constants.DATA_SOURCE_CRU;
			SELF.Options.DataSource2 := eCrash_Services.Constants.DATA_SOURCE_CRU;
			SELF.Options.IncludeCoverPage := true;
			SELF.Options.ColoredImage := ColoredImage;
			SELF.Options.Redact := Redact;
			SELF.Options.RequestType := RequestType;
			SELF.SearchBy.ImageHashes := ImageHashes;
			SELF.SearchBy.ReportID := RequestReportId;
			SELF := [];	
		END;	  
		
		RETURN DATASET([CreateRequest]);
	END;
	
END;