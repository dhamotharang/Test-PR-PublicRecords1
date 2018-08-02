﻿/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from retrievedocument.xml. ***/
/*===================================================*/

export retrievedocument := MODULE
			
export t_ECrashRetrieveDocumentOptions := record (iesp.share.t_BaseOption)
	boolean ColoredImage {xpath('ColoredImage')};
	boolean Redact {xpath('Redact')};
end;
		
export t_ECrashRetrieveDocumentReportBy := record
	string ReportID {xpath('ReportID')};
	string DocumentType {xpath('DocumentType')};
end;
		
export t_ECrashRetrieveDocumentResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	string DocumentData {xpath('DocumentData'), maxlength(iesp.Constants.Retrieve_Document.MaxDocumentSize)}; // Xsd type: base64binary
end;
		
export t_ECrashRetrieveDocumentRequest := record (iesp.share.t_BaseRequest)
	t_ECrashRetrieveDocumentOptions Options {xpath('Options')};
	t_ECrashRetrieveDocumentReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_ECrashRetrieveDocumentResponseEx := record
	t_ECrashRetrieveDocumentResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from retrievedocument.xml. ***/
/*===================================================*/

