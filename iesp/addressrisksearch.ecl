/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from addressrisksearch.xml. ***/
/*===================================================*/

export addressrisksearch := MODULE
			
export t_AddrRiskSearchOption := record (share.t_BaseSearchOptionEx)
	integer ReturnCount {xpath('ReturnCount')};
	integer ReturnType {xpath('ReturnType')};
	integer StartingRecord {xpath('StartingRecord')};
	unsigned SurroundingPropertyCount {xpath('SurroundingPropertyCount')};
	real4 GeoRadiusMiles {xpath('GeoRadiusMiles')};
end;
		
export t_AddrRiskSearchBy := record
	string12 GeoLink {xpath('GeoLink')};
	share.t_GeoLocation GeoLocation {xpath('GeoLocation')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_AddrRiskCountByYear := record
	string10 Current {xpath('Current')};
	string10 Last {xpath('Last')};
	string10 Two {xpath('Two')};
	string10 Three {xpath('Three')};
	string10 Four {xpath('Four')};
	string10 Five {xpath('Five')};
end;
		
export t_AddrRiskIndex := record
	string10 Crime {xpath('Crime')};
	string10 Poverty {xpath('Poverty')};
	string10 Foreclosure {xpath('Foreclosure')};
	string10 Disruption {xpath('Disruption')};
	string10 Mobility {xpath('Mobility')};
	string10 Risk {xpath('Risk')};
end;
		
export t_SexOffenderRecord := record
	string12 UniqueId {xpath('UniqueId')};
	share.t_Name Name {xpath('Name')};
	share.t_MaskableDate DOB {xpath('DOB')};
	share.t_Address Address {xpath('Address')};
	string10 Latitude {xpath('Latitude')};
	string11 Longitude {xpath('Longitude')};
end;
		
export t_PublicSafetyRecord := record
	string12 BDID {xpath('BDID')};
	string120 CompanyName {xpath('CompanyName')};
	share.t_Address Address {xpath('Address')};
	string10 Phone10 {xpath('Phone10')};
	string10 Latitude {xpath('Latitude')};
	string11 Longitude {xpath('Longitude')};
end;
		
export t_AddressRiskScoreRecord := record
	string12 GeoLink {xpath('GeoLink')};
	string10 Risk {xpath('Risk')};
	string10 Latitude {xpath('Latitude')};
	string11 Longitude {xpath('Longitude')};
end;
		
export t_AddrRiskSearchRecord := record
	string GeoLink {xpath('GeoLink')};
	share.t_GeoLocation GeoLocation {xpath('GeoLocation')};
	t_AddrRiskCountByYear Occupants {xpath('Occupants')};
	t_AddrRiskCountByYear PeopleMovedIn {xpath('PeopleMovedIn')};
	t_AddrRiskCountByYear PeopleMovedOut {xpath('PeopleMovedOut')};
	t_AddrRiskCountByYear Crimes {xpath('Crimes')};
	t_AddrRiskCountByYear Foreclosures {xpath('Foreclosures')};
	t_AddrRiskCountByYear SexOffenders {xpath('SexOffenders')};
	t_AddrRiskIndex Indices {xpath('Indices')};
	string10 MilesToTargetProperty {xpath('MilesToTargetProperty')};
	dataset(t_AddressRiskScoreRecord) AddressRiskScoreRecords {xpath('AddressRiskScoreRecords/AddressRiskScoreRecord'), MAXCOUNT(30)};
	dataset(t_SexOffenderRecord) SexOffenderRecords {xpath('SexOffenderRecords/SexOffenderRecord'), MAXCOUNT(30)};
	dataset(t_PublicSafetyRecord) PublicSafetyRecords {xpath('PublicSafetyRecords/PublicSafetyRecord'), MAXCOUNT(30)};
end;
		
export t_AddrRiskSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_AddrRiskSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.constants.AddrRisk.MAX_COUNT_SEARCH_RESPONSE_RECORDS)};
end;
		
export t_AddrRiskSearchRequest := record (share.t_BaseRequest)
	t_AddrRiskSearchOption Options {xpath('Options')};
	t_AddrRiskSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_AddrRiskSearchResponseEx := record
	t_AddrRiskSearchResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from addressrisksearch.xml. ***/
/*===================================================*/

