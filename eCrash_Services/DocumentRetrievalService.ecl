/*--SOAP--
<message name="DocumentRetrievalService">
  <part name="ECrashRetrieveDocumentRequest" type="tns:XmlDataSet" cols="200" rows="20" />
  <part name="ECrashRetrieveDocumentResponseEx" type="tns:XmlDataSet" cols="200" rows="20" />
	<part name="Gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
 </message>
*/
/*--INFO-- Ecrash Document Retrieval service -- 
   Input:  iesp.retrievedocument.t_ECrashRetrieveDocumentRequest (xml)
   Output: iesp.retrievedocument.t_ECrashRetrieveDocumentResponseEx (xml)
*/

IMPORT AutoStandardI, Iesp, dx_eCrash, Risk_Indicators, lib_stringlib, Ut, Gateway, Doxie, Std;

EXPORT DocumentRetrievalService() := FUNCTION
   GatewaysIn := dataset([], Risk_Indicators.Layout_Gateways_In) : stored ('Gateways', FEW);
	
	STRING DeltabaseEspNameGateway := 'DeltaBaseSql';	
	STRING ImageRetrievalEspNameGateway := 'AccidentImage';	
	
	STRING SqlSearchEspUrlGateway := GatewaysIn(servicename = 'delta_ec')[1].url;	
	STRING ImageRetrievalEspUrlGateway := GatewaysIn(servicename = 'gateway_esp')[1].url;	
	
	Request	:= DATASET([], iesp.retrievedocument.t_ECrashRetrieveDocumentRequest) : STORED('ECrashRetrieveDocumentRequest', FEW);
	InModuleDeltaBase := MODULE(PROJECT(AutoStandardI.GlobalModule(), IParam.searchrecords, OPT))
		EXPORT STRING200 SqlSearchEspURL := SqlSearchEspUrlGateway;
		EXPORT STRING SqlSearchEspNAME := DeltabaseEspNameGateway;
  END;
	
	RawDocumentIn := RawDocument(InModuleDeltaBase);
	
	Gateway.Layouts.Config ImageSoapCallGatewaysStructure := TRANSFORM
		SELF.ServiceName := ImageRetrievalEspNameGateway;
		SELF.Url := ImageRetrievalEspUrlGateway;
		SELF := [];
	END;
	
	ImageSoapCallGateways := ROW(ImageSoapCallGatewaysStructure);
	ImageService := eCrash_Services.GetImageSoapCall(ImageSoapCallGateways);	
	
	ReportBy := Request[1].ReportBy;
	
	RequestReportId := ReportBy.ReportID;
	DocumentType := ReportBy.DocumentType;
	ColoredImage := Request[1].Options.ColoredImage;
	Redact       := Request[1].Options.Redact;
	RequestType  := '';
	
	ErrorCodeImageOverflow      := 404;
	ErrorCodeImageNonReleasable := 406;
	
	FilteredDupedDocuments := RawDocumentIn.GetReportDocuments(RequestReportId, DocumentType);
	
	ImageHashes := PROJECT(
		FilteredDupedDocuments,
		TRANSFORM(
			iesp.accident_image.t_AccidentImageCRUImageHash,
			SELF.Hash := LEFT.hashkey;
			SELF.IncludeCoverPage := true;
		)
	);
	
	ImageRetrievalResponse := ImageService.GetImages(ImageService.GetDocumentImageRequest(ImageHashes, RequestReportId, ColoredImage, Redact, RequestType));
	
	EmptyHeader := ROW(
		TRANSFORM(
			iesp.retrievedocument.t_ECrashRetrieveDocumentResponse._Header, 
			SELF := [];
		)
	);
	
	// The response for image too large.
	iesp.retrievedocument.t_ECrashRetrieveDocumentResponse._Header ExceptionImageOverflowLayout := TRANSFORM
		SELF.Status := ErrorCodeImageOverflow;
		SELF.Exceptions := DATASET([
			{'Roxie', 
				ErrorCodeImageOverflow, 
				'eCrashServices.DocumentRetrievalService', 
				'Image is bigger than max size ' + iesp.Constants.Retrieve_Document.MaxDocumentSize + ' bytes'
			}
		], iesp.share.t_WsException);
		SELF := [];
	END;

	HeaderImageOverflow := ROW(ExceptionImageOverflowLayout);
	
	SuperReportIdToReportId := CHOOSEN(dx_eCrash.Key_ReportId(KEYED(report_id = RequestReportId)), 1);
	
	ReportHashKeysFromKey := JOIN(
		SuperReportIdToReportId,
		dx_eCrash.Key_Supplemental,
		KEYED(LEFT.super_report_id = RIGHT.super_report_id),
		TRANSFORM(RIGHT),
		LIMIT(eCrash_Services.constants.MAX_REPORT_NUMBER, FAIL(203, doxie.ErrorCodes(203))));
	
	ReportsDeltabaseResult := IF(
		ReportHashKeysFromKey[1].Vendor_Code IN eCrash_Services.Constants.VENDOR_CODES_BYPASS_DELTABASE, 
		eCrash_Services.Functions.getSupplementalsBypassDeltabase(ReportHashKeysFromKey),
		eCrash_Services.Functions.getSupplementalsDeltabase(
			RequestReportId,
			ReportHashKeysFromKey,
			InModuleDeltaBase));
		
	SuperReportRow := ReportsDeltabaseResult.superReportRow;
	
	ReportsAll := IF(
		ReportHashKeysFromKey[1].Vendor_Code IN eCrash_Services.Constants.VENDOR_CODES_BYPASS_DELTABASE, 
		SuperReportRow,
		ReportsDeltabaseResult.deltabaseReportsAll);
	
	// Check the releasable flag for the last item in "ReportsAll", since it will be the most recent.
	MostRecentReport := ReportsAll[COUNT(ReportsAll)];
	IF(EXISTS(ReportsAll) AND MostRecentReport.Releasable != '1',
		FAIL(ErrorCodeImageNonReleasable, 'Image is non-releasable'));
	
	// Compose our reponse.
	IsImageTooLarge := LENGTH(ImageRetrievalResponse[1].response.ImageData) = iesp.Constants.Retrieve_Document.MaxDocumentSize;

	ResponseHeader := MAP(IsImageTooLarge => HeaderImageOverflow,
		                    EmptyHeader);
	
	iesp.retrievedocument.t_ECrashRetrieveDocumentResponse GenerateResponse(
		iesp.accident_image.t_AccidentImageResponseEx L,
		iesp.retrievedocument.t_ECrashRetrieveDocumentResponse._Header H) := TRANSFORM
		SELF._Header := H;
		SELF.DocumentData := IF(
			H.Exceptions[1].Code = ErrorCodeImageOverflow,
			'',
			L.response.ImageData);
	END;
	
	Images := PROJECT(ImageRetrievalResponse, GenerateResponse(LEFT, ResponseHeader));
	EmptyResponse := DATASET([TRANSFORM(iesp.retrievedocument.t_ECrashRetrieveDocumentResponse, SELF := [])]);
	Result := IF(EXISTS(FilteredDupedDocuments), Images, EmptyResponse);
	
	return OUTPUT(Result, named('Results'));
END;