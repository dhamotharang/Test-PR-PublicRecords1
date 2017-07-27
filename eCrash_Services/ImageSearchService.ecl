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

IMPORT AutoStandardI, iesp, FLAccidents_Ecrash, Risk_Indicators, lib_stringlib, ut, Gateway, doxie;

EXPORT ImageSearchService() := FUNCTION
	GatewaysIn := Gateway.Configuration.Get();
	
	STRING DeltabaseEspNameGateway := 'DeltaBaseSql';	
	STRING ImageRetrievalEspNameGateway := 'AccidentImage';	
	
	STRING SqlSearchEspUrlGateway := GatewaysIn(servicename = 'delta_ec')[1].url;	
	STRING ImageRetrievalEspUrlGateway := GatewaysIn(servicename = 'gateway_esp')[1].url;	
	
	Request	:= DATASET([], iesp.retrieveimage.t_ECrashRetrieveImageRequest) : STORED('ECrashRetrieveImageRequest', FEW);
	InModuleDeltaBase := MODULE(PROJECT(AutoStandardI.GlobalModule(), IParam.searchrecords, OPT))
		EXPORT STRING200 SqlSearchEspURL := SqlSearchEspUrlGateway;
		EXPORT STRING SqlSearchEspNAME := DeltabaseEspNameGateway;
  END;
	
	DeltaBaseService := eCrash_Services.DeltaBaseSoapCall(InModuleDeltaBase);
	DeltaBaseSql := RawDeltaBaseSQL(InModuleDeltaBase);
	
	Gateway.Layouts.Config ImageSoapCallGatewaysStructure := TRANSFORM
		SELF.ServiceName := ImageRetrievalEspNameGateway;
		SELF.Url := ImageRetrievalEspUrlGateway;
		SELF := [];
	END;
	ImageSoapCallGateways := ROW(ImageSoapCallGatewaysStructure);
	ImageService := eCrash_Services.GetImageSoapCall(ImageSoapCallGateways);	
	
	RequestReportId := Request[1].ReportBy.ReportID;
	RequestRoyaltyType := Request[1].Options.RoyaltyType;
	RequestIncludeCoverPage := Request[1].Options.IncludeCoverPage;
	RequestAppendSuppliments := Request[1].Options.AppendSupplements;
	RequestTransactionId := Request[1].Options.TransactionID;
	
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
		LIMIT(constants.MAX_REPORT_NUMBER, FAIL(203, doxie.ErrorCodes(203)))
	);
	
	ReportsDeltabaseResult := IF(
		ReportHashKeysFromKey[1].Vendor_Code IN Constants.VENDOR_CODES_BYPASS_DELTABASE, 
		Functions.getSupplementalsBypassDeltabase(
			ReportHashKeysFromKey
		),
		Functions.getSupplementalsDeltabase(
			RequestReportId,
			ReportHashKeysFromKey,
			InModuleDeltaBase
		)
	);
		
	ReportHashKeysFromKeyFinal := ReportsDeltabaseResult.reportHashKeysFromKeyFinal;
	SuperReportRow := ReportsDeltabaseResult.superReportRow;
	ReportsAll := IF (
		ReportHashKeysFromKey[1].Vendor_Code IN Constants.VENDOR_CODES_BYPASS_DELTABASE, 
		SuperReportRow,
		ReportsDeltabaseResult.deltabaseReportsAll
	);
	ReportsAllSlimWithoutDeleted := ReportsDeltabaseResult.reportsAllSlim; 
		
	ReportsAllSlimDeduped := SORT(	
		DEDUP(
			SORT(ReportsAllSlimWithoutDeleted, hash_key, -(UNSIGNED8)report_id),
			hash_key
		),
		(UNSIGNED8)report_id
	);
	
	ImageHashes := PROJECT(
		ReportsAllSlimDeduped(hash_key != ''),
		TRANSFORM(
			iesp.accident_image.t_AccidentImageCRUImageHash,
			SELF.Hash := LEFT.hash_key;
			SELF.IncludeCoverPage := RequestIncludeCoverPage;
		)
	);

	IyetekRedactFlag := SuperReportRow[1].jurisdiction_nbr IN constants.REDACTION_AGENCY_LIST;
	ImageRetrievalRequest := ImageService.GetAccidentImageRequest(
		SuperReportRow, 
		ImageHashes, 
		RequestReportId, 
		RequestIncludeCoverPage,
		RequestRoyaltyType,
		RequestTransactionId,
		IyetekRedactFlag
	);

	isOnlyTm := COUNT(ReportsAllSlimWithoutDeleted) = COUNT(ReportsAllSlimWithoutDeleted(report_code = 'TM'));
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
		AND EXISTS(SuperReportRow),
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
	Result := IF(EXISTS(SuperReportRow), Images, EmptyResponse);
	
	RETURN OUTPUT(Result, named('Results'));
END;