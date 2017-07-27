export enhancedperson := MODULE
			
export t_HighRiskIndicator := record
	integer RiskIndex {xpath('RiskIndex')};
	string Description {xpath('Description')};
end;
		
export t_EnhancedAddress := record
	string LocationId {xpath('LocationId')};
	share.t_Address Address {xpath('Address')};
	dataset(t_HighRiskIndicator) HighRiskIndicators {xpath('HighRiskIndicators/HighRiskIndicator'), MAXCOUNT(1)};
end;
		
export t_EnhancedPersonSearchRecord := record
	string Type {xpath('Type')};
	boolean Verified {xpath('Verified')};
	string AddressVerification {xpath('AddressVerification')};
	string UniqueId {xpath('UniqueId')};
	integer Age {xpath('Age')};
	integer AgeAtDeath {xpath('AgeAtDeath')};
	share.t_Name Name {xpath('Name')};
	share.t_Date DOB {xpath('DOB')};
	share.t_Date DOD {xpath('DOD')};
	share.t_PhoneInfo PhoneInfo {xpath('PhoneInfo')};
	share.t_SSNInfo SSNInfo {xpath('SSNInfo')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	bankruptcy.t_BankruptcyInfo Bankruptcy {xpath('Bankruptcy')};
	string Gender {xpath('Gender')};
	bpssearch.t_BpsRecordCounts _RecordCounts {xpath('RecordCounts')};//hidden[internal]
	share.t_Address Address {xpath('Address')};
	t_EnhancedAddress EnhancedAddress {xpath('EnhancedAddress')};
	share.t_AddressEx AddressEx {xpath('AddressEx')};
end;
		
export t_EnhancedPersonSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer SubjectTotalCount {xpath('SubjectTotalCount')};
	dataset(t_EnhancedPersonSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_EnhancedPersonSearchOptions := record (bpssearch.t_BpsSearchOption)
	boolean BestOnly {xpath('BestOnly')};
	boolean IncludeAllIndividualRecords {xpath('IncludeAllIndividualRecords')};
end;
		
export t_EnhancedPersonSearchBy := record (bpssearch.t_BpsSearchBy)
	bpssearch.t_BpsRelatedInfo RelatedInfo {xpath('RelatedInfo')};
end;
		
export t_EnhancedPersonSearchRequest := record (share.t_BaseRequest)
	t_EnhancedPersonSearchOptions Options {xpath('Options')};
	t_EnhancedPersonSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_EnhancedPersonSearchResponseEx := record
	t_EnhancedPersonSearchResponse response {xpath('response')};
end;
		

end;

