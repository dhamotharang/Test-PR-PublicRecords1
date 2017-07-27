/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from retrieveimage.xml. ***/
/*===================================================*/

export retrieveimage := MODULE
			
export t_ECrashRetrieveImageOptions := record (share.t_BaseOption)
	boolean IncludeCoverPage {xpath('IncludeCoverPage')};
	boolean AppendSupplements {xpath('AppendSupplements')};
	string RoyaltyType {xpath('RoyaltyType')}; //values['','N','R','']
	string TransactionID {xpath('TransactionID')};
end;
		
export t_ECrashRetrieveImageReportBy := record
	string ReportID {xpath('ReportID')};
end;
		
export t_ECrashRetrieveImageResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	boolean InitialPurchase {xpath('InitialPurchase')};
	string ImageData {xpath('ImageData'), maxlength(iesp.Constants.Retrieve_Image.MaxImageSize)}; // Xsd type: base64binary
end;
		
export t_ECrashRetrieveImageRequest := record (share.t_BaseRequest)
	t_ECrashRetrieveImageOptions Options {xpath('Options')};
	t_ECrashRetrieveImageReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_ECrashRetrieveImageResponseEx := record
	t_ECrashRetrieveImageResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from retrieveimage.xml. ***/
/*===================================================*/

