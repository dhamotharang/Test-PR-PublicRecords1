IMPORT iesp, Gateway, lib_stringlib;

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
		DATASET(Layouts.eCrashRecordStructure) SuperReportRow, 
		DATASET(iesp.accident_image.t_AccidentImageCRUImageHash) ImageHashes, 
		STRING RequestReportId,
		BOOLEAN IncludeCoverPage,
		STRING RoyaltyType,
		STRING TransactionId,
		BOOLEAN IyetekRedactFlag) := FUNCTION
		
		//StringLib.StringToTitleCase is not working, so this is the workaround for it
		vendorCode := SuperReportRow[1].vendor_code;
		formatedVendorCode := vendorCode[1] + lib_stringlib.StringLib.StringToLowerCase(vendorCode[2..LENGTH(vendorCode)]); 
		
		iesp.accident_image.t_AccidentImageRequest TmLayout := TRANSFORM
			SELF.Options.IncludeCoverPage := IncludeCoverPage;
			SELF.Options.DataSource := 'IyeTek';
			SELF.Options.DataSource2 := formatedVendorCode;
			SELF.Options.IyetekRoyaltyType := RoyaltyType; 
			SELF.Options.IyetekRedact := IyetekRedactFlag; 
			SELF.SearchBy.TransactionID := TransactionId; //This is used for external vendor Iyetek
			//orig_accnbr is state_report_number which is being copied over original_case_ident in the deltabase and it's not cleaned from special characters
			SELF.SearchBy.ReportNumber := SuperReportRow[1].orig_accnbr;
			SELF.SearchBy.AgencyORI := SuperReportRow[1].agency_ori;
			SELF.SearchBy.ReportID := RequestReportId;
			SELF.SearchBy.ReportType := SuperReportRow[1].report_type_id;
			SELF := [];	
		END;	
			
		iesp.accident_image.t_AccidentImageRequest Layout := TRANSFORM
			SELF.Options.DataSource := 'CRU';
			SELF.Options.DataSource2 := 'CRU';
			SELF.Options.IncludeCoverPage := IncludeCoverPage;
			SELF.SearchBy.ImageHashes := ImageHashes;
			SELF.SearchBy.ReportID := RequestReportId;
			SELF := [];	
		END;	
		
		RETURN MAP(
			NOT EXISTS(SuperReportRow) => DATASET(
				[TRANSFORM(iesp.accident_image.t_AccidentImageRequest, SELF := [])]
			),
			EXISTS(ImageHashes) => DATASET([Layout]),
			NOT EXISTS(ImageHashes) => DATASET([TmLayout])
		);
	END;
	
	EXPORT GetDocumentImageRequest(
		DATASET(iesp.accident_image.t_AccidentImageCRUImageHash) ImageHashes, STRING RequestReportId) := FUNCTION
			
		iesp.accident_image.t_AccidentImageRequest Layout := TRANSFORM
			SELF.Options.DataSource := 'CRU';
			SELF.Options.DataSource2 := 'CRU';
			SELF.Options.IncludeCoverPage := true;
			SELF.SearchBy.ImageHashes := ImageHashes;
			SELF.SearchBy.ReportID := RequestReportId;
			SELF := [];	
		END;	  
		
		RETURN DATASET([Layout]);
	END;
	
END;