﻿/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from accident_image.xml. ***/
/*===================================================*/

import iesp;

export accident_image := MODULE
			
export t_AccidentImageCRUImageHash := record
	string Hash {xpath('Hash')};
	boolean IncludeCoverPage {xpath('IncludeCoverPage')};
end;
		
export t_AccidentImageSearchBy := record
	string ImageHash {xpath('ImageHash')};
	dataset(t_AccidentImageCRUImageHash) ImageHashes {xpath('ImageHashes/ImageHash'), MAXCOUNT(99)};
	string ReportNumber {xpath('ReportNumber')};
	string AgencyORI {xpath('AgencyORI')};
	string ReferenceNumber {xpath('ReferenceNumber')};
	string ReportID {xpath('ReportID')};
	string TransactionID {xpath('TransactionID')};
	string ReportType {xpath('ReportType')}; //values['A','DE','','']
	iesp.share.t_Date DateOfCrash {xpath('DateOfCrash')};
	string State {xpath('State')};
end;
		
export t_AccidentImageSearchOption := record (iesp.share.t_BaseSearchOption)
	string DataSource {xpath('DataSource')}; //values['CRU','IyeTek','CrashLogic','HarrisCounty','']
	string DataSource2 {xpath('DataSource2')};
	string RoyaltyType {xpath('RoyaltyType')}; //values['','N','R','']
	string IyetekRoyaltyType {xpath('IyetekRoyaltyType')}; //values['','N','R','']
	boolean IncludeCoverPage {xpath('IncludeCoverPage')};
	boolean IyetekRedact {xpath('IyetekRedact')};
	boolean ColoredImage {xpath('ColoredImage')};
	boolean Redact {xpath('Redact')};
end;
		
export t_AccidentImageResponse := record
	string Source {xpath('Source')};
	string ImageData {xpath('ImageData'), maxlength(iesp.Constants.Retrieve_Image.MaxImageSize)}; // Xsd type: base64binary
end;
		
export t_AccidentImageRequest := record (iesp.share.t_BaseRequest)
	iesp.share.t_GatewayParams GatewayParams {xpath('GatewayParams')};
	t_AccidentImageSearchOption Options {xpath('Options')};
	t_AccidentImageSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_AccidentImageResponseEx := record
	t_AccidentImageResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from accident_image.xml. ***/
/*===================================================*/

