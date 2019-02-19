/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from duediligenceattributes.xml. ***/
/*===================================================*/

import iesp;

export duediligenceattributes := MODULE
			
export t_DDRCitizenship := record (iesp.citizenshipscore.t_CITRequest)
end;
		
export t_DDRCitizenshipResults := record (iesp.citizenshipscore.t_CITResponse)
end;
		
export t_DDRPersonAttributesReportBy := record (iesp.duediligenceshared.t_DDRAttributesPerson)
	t_DDRCitizenship Citizenship {xpath('Citizenship')};
end;
		
export t_DDRAttributesReportBy := record
	string ProductRequestType {xpath('ProductRequestType')}; //values['AttributesOnly','CitizenshipOnly','AttributesAndCitizenship','']
	t_DDRPersonAttributesReportBy Person {xpath('Person')};
	iesp.duediligenceshared.t_DDRAttributesBusiness Business {xpath('Business')};
end;
		
export t_DDRAttributesResult := record
	string12 UniqueId {xpath('UniqueId')};
	string12 BusinessId {xpath('BusinessId')};
	boolean LexIDChanged {xpath('LexIDChanged')};
	t_DDRAttributesReportBy InputEcho {xpath('InputEcho')};
	iesp.duediligenceshared.t_DDRAttributeGroup AttributeGroup {xpath('AttributeGroup')};
	t_DDRCitizenshipResults CitizenshipResults {xpath('CitizenshipResults')};
	iesp.duediligenceshared.t_DDRAttributesAdditionalInfo AdditionalInput {xpath('AdditionalInput')};
	integer2 PersonLexIDMatch {xpath('PersonLexIDMatch')};
	integer2 BusinessLexIDMatch {xpath('BusinessLexIDMatch')};
end;
		
export t_DueDiligenceAttributesResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	t_DDRAttributesResult Result {xpath('Result')};
end;
		
export t_DueDiligenceAttributesRequest := record (iesp.share.t_BaseRequest)
	iesp.duediligenceshared.t_DDRAttributesOptions Options {xpath('Options')};
	t_DDRAttributesReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_DueDiligenceAttributesResponseEx := record
	t_DueDiligenceAttributesResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from duediligenceattributes.xml. ***/
/*===================================================*/

