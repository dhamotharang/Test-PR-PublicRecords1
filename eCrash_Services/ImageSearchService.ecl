/*2017-09-23T00:08:22Z (Lazarenko, Dmitriy (RIS-HBE))
[ECH-5121] implementing append/overwrite supplement images behavior.
*/
/*2015-06-24T16:52:16Z (Sai Nagula)
Open State search and Drivers exchange report grouping.
*/
/*--SOAP--
<message name="eCrashAnalyticsService">
  <part name="ECrashRetrieveImageRequest" type="tns:XmlDataSet" cols="200" rows="20" />
  <part name="ECrashRetrieveImageResponseEx" type="tns:XmlDataSet" cols="200" rows="20" />
	<part name="Gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
 </message>
*/
/*--INFO-- Ecrash Analytics service -- 
   Input:  iesp.retrieveimage.ECrashRetrieveImageRequest (xml)
   Output: iesp.retrieveimage.ECrashRetrieveImageResponseEx (xml)
*/

IMPORT AutoStandardI, iesp, FLAccidents_Ecrash, Gateway, doxie, eCrash_Services;

EXPORT ImageSearchService() := FUNCTION
	GatewaysIn := Gateway.Configuration.Get();
	
	//since ESP	doesn't pass the actual service name, we use "delta_ec" and "gateway_esp" just to filter out the service URLs.
	STRING RequestSqlSearchEspUrl := GatewaysIn(servicename = 'delta_ec')[1].url;	
	STRING RequestImageRetrievalEspUrl := GatewaysIn(servicename = 'gateway_esp')[1].url;	
		
	Request	:= DATASET([], iesp.retrieveimage.t_ECrashRetrieveImageRequest) : STORED('ECrashRetrieveImageRequest', FEW);
	InModuleDeltaBase := MODULE(PROJECT(AutoStandardI.GlobalModule(), eCrash_Services.IParam.searchrecords, OPT))
		EXPORT STRING200 SqlSearchEspURL := RequestSqlSearchEspUrl;
		EXPORT STRING SqlSearchEspNAME := Gateway.Constants.ServiceName.DeltabaseSql;
  END;
	
	DeltaBaseService := eCrash_Services.DeltaBaseSoapCall(InModuleDeltaBase);
	DeltaBaseSql := eCrash_Services.RawDeltaBaseSQL(InModuleDeltaBase);
	
	Gateway.Layouts.Config ImageSoapCallGatewaysStructure := TRANSFORM
		SELF.ServiceName := Gateway.Constants.ServiceName.EcrashImageRetrieval;
		SELF.Url := RequestImageRetrievalEspUrl;
		SELF := [];
	END;
	ImageSoapCallGateways := ROW(ImageSoapCallGatewaysStructure);
	ImageService := eCrash_Services.GetImageSoapCall(ImageSoapCallGateways);	
	
	RequestRoyaltyType := Request[1].Options.RoyaltyType;
	RequestIncludeCoverPage := Request[1].Options.IncludeCoverPage;
	RequestAppendSuppliments := Request[1].Options.AppendSupplements;
	RequestTransactionId := Request[1].Options.TransactionID;
	RequestVendorCode := Request[1].ReportBy.Vendor;
	RequestAgencyOri := Request[1].ReportBy.AgencyORI;
	RequestDateOfCrash := Request[1].ReportBy.DateOfCrash;
    RequestColoredImage := Request[1].Options.ColoredImage;
	RequestRedact       := Request[1].Options.Redact;

	RequestReportIdRaw := Request[1].ReportBy.ReportID;
	//blanking out RequestReportId for KYCrashLogic since we need to get an image for it straigt away without search performed. 
	//Also, when it comes to KYCrashLogic the Request[1].ReportBy.ReportID actually contains ReportNumber value (because we don't have the actual reportid
	//since we don't have those reports in our system and have to request them from the KY gateway)
	RequestReportId := IF(RequestVendorCode = eCrash_Services.Constants.VENDOR_CRASHLOGIC, '', RequestReportIdRaw);
	
	ErrorCodeImageOverflow := 404;
	ErrorCodeImageRetrievalIssue := 405;
	SuperReportIdToReportId := CHOOSEN(
		FLAccidents_Ecrash.Key_eCrashV2_ReportId(KEYED(report_id = RequestReportId)),
		1
	);
	
	//All of the records in ReportHashKeysFromKey have the same accident_nbr, report_code, jurisdiction_state, jurisdiction, accident_date, orig_accnbr
	ReportHashKeysFromKey := JOIN(
		SuperReportIdToReportId,
		FLAccidents_Ecrash.Key_eCrashv2_Supplemental,
		KEYED(LEFT.super_report_id = RIGHT.super_report_id),
		TRANSFORM(RIGHT),
		LIMIT(eCrash_Services.constants.MAX_REPORT_NUMBER, FAIL(203, doxie.ErrorCodes(203)))
	);
	
	ReportsDeltabaseResult := IF(
		ReportHashKeysFromKey[1].Vendor_Code IN eCrash_Services.Constants.VENDOR_CODES_BYPASS_DELTABASE, 
		eCrash_Services.Functions.getSupplementalsBypassDeltabase(
			ReportHashKeysFromKey
		),
		eCrash_Services.Functions.getSupplementalsDeltabase(
			RequestReportId,
			ReportHashKeysFromKey,
			InModuleDeltaBase
		)
	);
		
	ReportHashKeysFromKeyFinal := ReportsDeltabaseResult.reportHashKeysFromKeyFinal;
	SuperReportRow := ReportsDeltabaseResult.superReportRow;
	ReportsAll := IF (
		ReportHashKeysFromKey[1].Vendor_Code IN eCrash_Services.Constants.VENDOR_CODES_BYPASS_DELTABASE, 
		SuperReportRow,
		ReportsDeltabaseResult.deltabaseReportsAll
	);
	ReportsAllSlimWithoutDeleted := ReportsDeltabaseResult.reportsAllSlim; 
		
	ReportsAllSlimDedupedRaw := SORT(	
		DEDUP(
			SORT(ReportsAllSlimWithoutDeleted, hash_key, -(UNSIGNED8)report_id),
			hash_key
		),
		(UNSIGNED8)report_id
	);
	
	AgencyInfo := FLAccidents_Ecrash.key_EcrashV2_agency(
		KEYED(
			agency_state_abbr = SuperReportRow[1].jurisdiction_state 
			AND agency_name = SuperReportRow[1].jurisdiction
		)	
	);
	AgencyAppendOverwriteFlag := AgencyInfo[1].append_overwrite_flag;
	
	ReportsAllSlimDeduped := CASE(
		AgencyAppendOverwriteFlag,
		Constants.AGENCY_FLAG_APPEND => ReportsAllSlimDedupedRaw,
		Constants.AGENCY_FLAG_OVERWRITE => TOPN(ReportsAllSlimDedupedRaw, 1, -(UNSIGNED8)report_id),
		ReportsAllSlimDedupedRaw
	);
	
	ImageHashes := PROJECT(
		ReportsAllSlimDeduped(hash_key != ''),
		TRANSFORM(
			iesp.accident_image.t_AccidentImageCRUImageHash,
			SELF.Hash := LEFT.hash_key;
			SELF.IncludeCoverPage := RequestIncludeCoverPage;
		)
	);

	isOnlyTm := COUNT(ReportsAllSlimWithoutDeleted) = COUNT(ReportsAllSlimWithoutDeleted(report_code = 'TM'));

	IyetekRedactFlag := SuperReportRow[1].jurisdiction_nbr IN eCrash_Services.constants.REDACTION_AGENCY_LIST;
	ImageRetrievalRequest := ImageService.GetAccidentImageRequest(
		SuperReportRow, 
		ImageHashes, 
		RequestReportIdRaw, 
		RequestIncludeCoverPage,
		RequestRoyaltyType,
		RequestTransactionId,
		IyetekRedactFlag,
		RequestAgencyOri,
		RequestVendorCode,
		RequestDateOfCrash,
		isOnlyTm,
		RequestColoredImage,
		RequestRedact
	);

	//We don't know which report_id was used to retreive image for TM that's why we are searching by all the possible report ids. ESP inserts report_id from the request.
	AllReportIdSet := SET(ReportsAll, report_id) + SET(ReportHashKeysFromKeyFinal, report_id) + [RequestReportId]; 
	
	ImageDataFromDeltabase := IF(
		isOnlyTm,
		Functions.GetImageDataFromDeltabase(AllReportIdSet, InModuleDeltaBase)
	);
		
	isTMExistsInDeltabase := ImageDataFromDeltabase[1].response.ImageData != '';
		
	ImageRetrievalResponse := IF(
		isTMExistsInDeltabase,
		ImageDataFromDeltabase, 
		ImageService.GetImages(ImageRetrievalRequest)
	);

	IF (
		ImageRetrievalResponse[1].response.ImageData = '' 
		AND (EXISTS(SuperReportRow) OR RequestVendorCode = eCrash_Services.Constants.VENDOR_CRASHLOGIC),
		FAIL(ErrorCodeImageRetrievalIssue, 'Image retrieval issue')
	);

	EmptyHeader := ROW(
		TRANSFORM(
			iesp.retrieveimage.t_ECrashRetrieveImageResponse._Header, 
			SELF := []
		)
	);
	
	iesp.retrieveimage.t_ECrashRetrieveImageResponse._Header ExceptionImageOverflowLayout := TRANSFORM
		SELF.Status := ErrorCodeImageOverflow;
		SELF.Exceptions := DATASET([
			{'Roxie', 
				ErrorCodeImageOverflow, 
				'eCrashServices.ImageSearchService', 
				'Image is bigger then max size ' + iesp.Constants.Retrieve_Image.MaxImageSize + ' bytes'
			}
		], iesp.share.t_WsException);
		SELF := [];
	END;
	
	HeaderImageOverflow := ROW(ExceptionImageOverflowLayout);
	ResponseHeader := IF(
		LENGTH(ImageRetrievalResponse[1].response.ImageData) = iesp.Constants.Retrieve_Image.MaxImageSize,
		HeaderImageOverflow,
		EmptyHeader
	);
	
  iesp.retrieveimage.t_ECrashRetrieveImageResponse GenerateResponse(
		iesp.accident_image.t_AccidentImageResponseEx L,
		iesp.retrieveimage.t_ECrashRetrieveImageResponse._Header H,
		BOOLEAN InitialPurchase
	) := TRANSFORM
		SELF._Header := H;
		SELF.InitialPurchase := InitialPurchase;
		SELF.ImageData := IF(
			H.Exceptions[1].Code = ErrorCodeImageOverflow,
			'',
			L.response.ImageData
		);
	END;
	
	InitialPurchase := IF(RequestRoyaltyType = 'N', false, isOnlyTm AND NOT(isTMExistsInDeltabase));
	
	Images := PROJECT(ImageRetrievalResponse, GenerateResponse(LEFT, ResponseHeader, InitialPurchase));
	EmptyResponse := DATASET([TRANSFORM(iesp.retrieveimage.t_ECrashRetrieveImageResponse, SELF := [])]);
	Result := IF(EXISTS(SuperReportRow) OR RequestVendorCode = eCrash_Services.Constants.VENDOR_CRASHLOGIC, Images, EmptyResponse);
	
	RETURN OUTPUT(Result, named('Results'));
END;