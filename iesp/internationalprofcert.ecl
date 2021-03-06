/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from internationalprofcert.xml. ***/
/*===================================================*/

export internationalprofcert := MODULE
			
export t_InternationalProfCertificationSearchBy := record
	unsigned8 UniqueId {xpath('UniqueId')}; // hidden[internal] // Xsd type: string
	string20 Category {xpath('Category')};
	string1 Gender {xpath('Gender')};
	internationaldocket.t_InternationalName Name {xpath('Name')};
end;
		
export t_InternationalProfCertificationOption := record (share.t_BaseSearchOptionEx)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
end;
		
export t_InternationalProfCertification := record
	string20 Category {xpath('Category')};
	unsigned2 ProfessionNumber {xpath('ProfessionNumber')}; // hidden[internal] // Xsd type: string
	string100 Profession {xpath('Profession')};
	string100 EducationLevel {xpath('EducationLevel')};
end;
		
export t_InternationalProfCertificationRecord := record
	unsigned8 UniqueId {xpath('UniqueId')}; // Xsd type: string
	integer _Penalty {xpath('Penalty')}; // hidden[ecldev]
	string1 Gender {xpath('Gender')};
	unicode100 FullName {xpath('FullName')}; // Xsd type: string
	dataset(internationaldocket.t_InternationalName) AKAs {xpath('AKAs/Name'), MAXCOUNT(iesp.constants.INTERNATIONALPROFCERT_MAX_COUNT_AKAS)};
	dataset(t_InternationalProfCertification) Certifications {xpath('Certifications/Certification'), MAXCOUNT(iesp.constants.INTERNATIONALPROFCERT_MAX_COUNT_CERTIFICATIONS)};
end;
		
export t_InternationalProfCertificationSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_InternationalProfCertificationRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.constants.INTERNATIONALPROFCERT_MAX_COUNT_SEARCH_RESPONSE_RECORDS)};
end;
		
export t_InternationalProfCertificationSearchRequest := record (share.t_BaseRequest)
	t_InternationalProfCertificationSearchBy SearchBy {xpath('SearchBy')};
	t_InternationalProfCertificationOption Options {xpath('Options')};
end;
		
export t_InternationalProfCertificationSearchResponseEx := record
	t_InternationalProfCertificationSearchResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from internationalprofcert.xml. ***/
/*===================================================*/

