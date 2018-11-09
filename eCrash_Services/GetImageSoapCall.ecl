IMPORT iesp, Gateway, eCrash_Services;

EXPORT GetImageSoapCall(Gateway.Layouts.Config gatewayCfg) := MODULE
	
	IsSafeToPerformSoap := gatewayCfg.Url <> '' AND gatewayCfg.ServiceName <> '';
	
	EXPORT GetImages(DATASET(iesp.accident_image.t_AccidentImageRequest) Request) := FUNCTION
		EmptyDataset := dataset([], iesp.accident_image.t_AccidentImageResponseEx);

		RETURN IF(
			EXISTS(Request) AND IsSafeToPerformSoap, 
			Gateway.SoapCall_GetReportImage(gatewayCfg, Request), 
			EmptyDataset
		);
	END;
	
		EXPORT GetAccidentImageRequest(
		DATASET(eCrash_Services.Layouts.eCrashRecordStructure) SuperReportRow, 
		DATASET(iesp.accident_image.t_AccidentImageCRUImageHash) ImageHashes, 
		STRING RequestReportId,
		BOOLEAN RequestIncludeCoverPage,
		STRING RoyaltyType,
		STRING TransactionId,
		BOOLEAN IyetekRedactFlag,
		STRING RequestAgencyOri,
		STRING RequestVendorCode,
		iesp.share.t_Date RequestDateOfCrash) := FUNCTION
		
		//special logic for 'KYCrashLogic'
		IsVendorCrashLogic := RequestVendorCode = Constants.VENDOR_CRASHLOGIC;
		VendorCode := IF(IsVendorCrashLogic, Constants.VENDOR_CRASHLOGIC_ESP, SuperReportRow[1].vendor_code);
		ReportNumber := IF(IsVendorCrashLogic, RequestReportId, SuperReportRow[1].vendor_report_id);
		ReportType := IF(IsVendorCrashLogic, Constants.REPORT_CODE_ACCIDENT, SuperReportRow[1].report_type_id);
		AgencyOri := IF(IsVendorCrashLogic, RequestAgencyOri, SuperReportRow[1].agency_ori);
		IncludeCoverPage := IF(IsVendorCrashLogic, FALSE, RequestIncludeCoverPage);
		DataSourceExternal := IF(IsVendorCrashLogic, Constants.VENDOR_CRASHLOGIC_ESP, Constants.DATA_SOURCE_IYETEK);	
		State := IF(IsVendorCrashLogic, 'KY', SuperReportRow[1].jurisdiction_state);
		
		DateOfCrash := IF(
			IsVendorCrashLogic, 
			RequestDateOfCrash,
			iesp.ECL2ESP.toDate((UNSIGNED4)SuperReportRow[1].accident_date)
		);		
		
		iesp.accident_image.t_AccidentImageRequest CreateRequestTm := TRANSFORM
			SELF.Options.IncludeCoverPage := IncludeCoverPage;
			SELF.Options.DataSource := DataSourceExternal;
			SELF.Options.DataSource2 := VendorCode;
			SELF.Options.IyetekRoyaltyType := RoyaltyType; 
			SELF.Options.IyetekRedact := IyetekRedactFlag; 
			SELF.SearchBy.TransactionID := TransactionId; //This is used for external vendor Iyetek
			//orig_accnbr is state_report_number which is being copied over original_case_ident in the deltabase and it's not cleaned from special characters
			// ECH - 4998 - Sprint 11 Apriss Integration - VIYER - assign vendor_report_id instead of orig_accnbr
			SELF.SearchBy.ReportNumber := ReportNumber;
			SELF.SearchBy.AgencyORI := AgencyORI;
			SELF.SearchBy.ReportID := RequestReportId;
			SELF.SearchBy.ReportType := ReportType;
			SELF.SearchBy.DateOfCrash := DateOfCrash;
			SELF.SearchBy.State := State;
			
			SELF := [];	
		END;	
			
		iesp.accident_image.t_AccidentImageRequest CreateRequest := TRANSFORM
			SELF.Options.DataSource := eCrash_Services.Constants.DATA_SOURCE_CRU;
			SELF.Options.DataSource2 := eCrash_Services.Constants.DATA_SOURCE_CRU;
			SELF.Options.IncludeCoverPage := IncludeCoverPage;
			SELF.SearchBy.ImageHashes := ImageHashes;
			SELF.SearchBy.ReportID := RequestReportId;
			SELF := [];	
		END;	
		
		Result := 
			MAP(
				NOT EXISTS(SuperReportRow) AND NOT IsVendorCrashLogic => DATASET(
					[TRANSFORM(iesp.accident_image.t_AccidentImageRequest, SELF := [])]
				),
				EXISTS(ImageHashes) => DATASET([CreateRequest]),
				NOT EXISTS(ImageHashes) => DATASET([CreateRequestTm])
		);
		
		RETURN Result;
	END;
	
	EXPORT GetDocumentImageRequest(
		DATASET(iesp.accident_image.t_AccidentImageCRUImageHash) ImageHashes, STRING RequestReportId) := FUNCTION
			
		iesp.accident_image.t_AccidentImageRequest CreateRequest := TRANSFORM
			SELF.Options.DataSource := eCrash_Services.Constants.DATA_SOURCE_CRU;
			SELF.Options.DataSource2 := eCrash_Services.Constants.DATA_SOURCE_CRU;
			SELF.Options.IncludeCoverPage := true;
			SELF.SearchBy.ImageHashes := ImageHashes;
			SELF.SearchBy.ReportID := RequestReportId;
			SELF := [];	
		END;	  
		
		RETURN DATASET([CreateRequest]);
	END;
	
END;