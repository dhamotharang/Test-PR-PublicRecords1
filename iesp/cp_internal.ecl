 /* This is Generated code.  Do not modify this attribute directly, 
			or if you do please modify the ESDL interface definiton to match */

export cp_internal := MODULE
			
export t_InsuranceIdEnhancementOption := record (share.t_BaseSearchOptionEx)
	boolean BestAddressOnly {xpath('BestAddressOnly')};
end;
		
export t_InsuranceIdEnhancementSearchBy := record
	string12 UniqueId {xpath('UniqueId')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string11 SSN {xpath('SSN')};
	share.t_Date DOB {xpath('DOB')};
	string1 Gender {xpath('Gender')};
	string2 DLState {xpath('DLState')};
	string14 DLNumber {xpath('DLNumber')};
end;
		
export t_InsuranceEnhancementDriversInfo := record
	string2 IssueState {xpath('IssueState')};
	share.t_Date IssueDate {xpath('IssueDate')};
	share.t_Date ExpirationDate {xpath('ExpirationDate')};
	string42 restrictions {xpath('restrictions')};
	string6 LicenseClass {xpath('LicenseClass')};
	string4 LicenseType {xpath('LicenseType')};
	string14 DLNumber {xpath('DLNumber')};
	dataset(share.t_StringArrayItem) RestrictionsDetail {xpath('RestrictionsDetail/Restriction'), MAXCOUNT(iesp.constants.DL.MaxCountRestrictions)};
end;
		
export t_AddressWithDates := record (share.t_Address)
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
end;
		
export t_InsuranceEnhancementResult := record
	string12 UniqueId {xpath('UniqueId')};
	string15 DID {xpath('DID')};
	share.t_Date DOB {xpath('DOB')};
	share.t_Date DOD {xpath('DOD')};
	share.t_SSNInfoEx SSN {xpath('SSN')};
	share.t_Name Name {xpath('Name')};
	string1 Gender {xpath('Gender')};
	t_InsuranceEnhancementDriversInfo CurrentLicense {xpath('CurrentLicense')};
	t_AddressWithDates CurrentAddress {xpath('CurrentAddress')};
	string3 Score {xpath('Score')};
	dataset(t_AddressWithDates) AddressHistory {xpath('AddressHistory/Address'), MAXCOUNT(3)};
end;
		
export t_InsuranceIdEnhancementResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	dataset(t_InsuranceEnhancementResult) Results {xpath('Results/Result'), MAXCOUNT(100)};
end;
		
export t_EditsInputSet := record
	dataset(share.t_StringArrayItem) EditsInputRecords {xpath('EditsInputRecords/Record'), MAXCOUNT(20)};
end;
		
export t_EditsOutputSet := record
	dataset(share.t_StringArrayItem) EditsOutputRecords {xpath('EditsOutputRecords/Record'), MAXCOUNT(40)};
end;
		
export t_EditsCompIdResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	t_EditsOutputSet Results {xpath('Results')};
end;
		
export t_InsuranceIdEnhancementRequest := record (share.t_BaseRequest)
	dataset(t_InsuranceIdEnhancementSearchBy) SearchList {xpath('SearchList/SearchBy'), MAXCOUNT(100)};
	t_InsuranceIdEnhancementOption Options {xpath('Options')};
end;
		
export t_EditsCompIdRequest := record (share.t_BaseRequest)
	share.t_BaseSearchOptionEx Options {xpath('Options')};
	t_EditsInputSet InputSet {xpath('InputSet')};
end;
		
export t_InsuranceIdEnhancementResponseEx := record
	t_InsuranceIdEnhancementResponse response {xpath('response')};
end;
		
export t_EditsCompIdResponseEx := record
	t_EditsCompIdResponse Response {xpath('Response')};
end;
		

end;

