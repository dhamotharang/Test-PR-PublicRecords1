/* 2009-07-27T14:30:15 (Magesh Thulasi) */
/*--SOAP--
<message name="Common_Service">
	<part name="DataRestrictionMask" type="xsd:string"/>
  <part name="DataEnhanceRequest" type="tns:XmlDataSet" cols="200" rows="20" />
</message>
*/
/*--INFO--  
	Input: EDITS request (XML)
	Output: EDITS response (XML)
	
	This is the generic CompID service. It invokes one of the four CompID functions and 
	returns the appropriate response. The four functions include SSN-based, DL-based, Address-based
	and Address Enhancement.
*/

IMPORT iesp, Insurance_iesp;

EXPORT Common_Service() := FUNCTION
	Layout_Request 	:= Insurance_iesp.DataEnhanceOrder.t_DataEnhanceRequest;
	Layout_Response := Insurance_iesp.DataEnhanceReport.t_DataEnhanceResponse;
	Layout_CompId_Order := CompId_Services.Layouts.CompId_Order;
	
	// AllowAll=true allows GLB and DPPA data to be included
	#STORED ('AllowAll',true);
	#STORED ('LogWorkunit', true);
	
	// Read the request
	Raw_Request := DATASET([], Layout_Request) : STORED('DataEnhanceRequest', FEW);
	Request 		:= CHOOSEN(Raw_Request, 1);
	
	// Construct CompIdOrder from the Request
	Layout_CompId_Order xformCompId(Layout_Request L) := TRANSFORM
		// RI01 (from Inquiry section)
		SELF.ReportUseCode	:= L.InquiryIdSection.InquiryRequestId.ReportUsage;

		// PI01 (from Subject section)
		SELF.PrefName 		:= L.SubjectIdSection.Subject.Prefix;
		SELF.LastName 		:= L.SubjectIdSection.Subject.Last;
		SELF.FirstName 		:= L.SubjectIdSection.Subject.First;
		SELF.MidName 			:= L.SubjectIdSection.Subject.Middle;
		SELF.SufName 			:= L.SubjectIdSection.Subject.Suffix;
		
		SELF.BirthDate 		:= L.SubjectIdSection.Subject.DateOfBirth.Month +
													L.SubjectIdSection.Subject.DateOfBirth.Day +
													L.SubjectIdSection.Subject.DateOfBirth.Year;
		SELF.SsnNum 			:= L.SubjectIdSection.Subject.SSN;
		
		// AL01 (from Subject section)
     
		SELF.HouseNum			:= L.SubjectIdSection.CurrentAddress.HouseNumber;
		SELF.StrName			:= L.SubjectIdSection.CurrentAddress.StreetName;
		SELF.AptNum				:= L.SubjectIdSection.CurrentAddress.AptNumber;
		
		SELF.CityName			:= L.SubjectIdSection.CurrentAddress.City;
		SELF.StateCode		:= L.SubjectIdSection.CurrentAddress.State;
		SELF.ZipNum				:= L.SubjectIdSection.CurrentAddress.Zip;
		SELF.ZipSufNum		:= L.SubjectIdSection.CurrentAddress.ZipPlus4;
		
		// DL01 (from Subject section)
		SELF.LicNum				:= L.SubjectIdSection.CurrentLicense.LicenseNumber;
		SELF.DLStateCode	:= L.SubjectIdSection.CurrentLicense.State;
	END;
	CompIdOrder := PROJECT(Request, xformCompId(LEFT));
	
	// Get result by calling appropriate CompId function
	CompIdResult := Sub_Common.callCompIdFeature (CompIdOrder);
	
	// Convert CompIdResult into t_DataEnhanceReponse
	Response := Sub_Common.convertCompIdToGeneric(Request, CompIdResult);
	
	Insurance_iesp.ECL2ESP.Marshall.MAC_Marshall_Results(Response[1], FinalResults, 
			Insurance_iesp.DataEnhanceReport.t_Response, Results, TRUE);
	
	// Return action for execution
	RETURN OUTPUT(FinalResults, NAMED('FinalResults'));
	
END;
