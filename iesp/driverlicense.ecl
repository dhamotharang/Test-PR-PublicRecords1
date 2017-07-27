export driverlicense := MODULE
			
export t_DLSearchBy := record
	string SSN {xpath('SSN')};
	string LicenseNumber {xpath('LicenseNumber')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	share.t_Date DOB {xpath('DOB')};
end;
		
export t_DLSearchOption := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean UsePhonetics {xpath('UsePhonetics')};
end;
		
export t_DriverLicenseRecord := record
	string History {xpath('History')};
	string RecordType {xpath('RecordType')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string UniqueId {xpath('UniqueId')};
	share.t_Date DOB {xpath('DOB')};
	integer Age {xpath('Age')};
	share.t_Date DOD {xpath('DOD')};
	string SSN {xpath('SSN')};
	string Sex {xpath('Sex')};
	string Race {xpath('Race')};
	integer Height {xpath('Height')};
	integer Weight {xpath('Weight')};
	string EyeColor {xpath('EyeColor')};
	string HairColor {xpath('HairColor')};
	share.t_Date IssuedDate {xpath('IssuedDate')};
	string County {xpath('County')};
	string IssuingState {xpath('IssuingState')};
	share.t_Date ExpirationDate {xpath('ExpirationDate')};
	string LicenseNumber {xpath('LicenseNumber')};
	string LicenseType {xpath('LicenseType')};
	string LicenseRestrictionCodes {xpath('LicenseRestrictionCodes')};
	string LicenseEndorsementCodes {xpath('LicenseEndorsementCodes')};
	string MotorcycleCode {xpath('MotorcycleCode')};
	string AttentionFlag {xpath('AttentionFlag')};
	dataset(share.t_StringArrayItem) LicenseRestrictions {xpath('LicenseRestrictions/Value'), MAXCOUNT(iesp.constants.DL.MaxCountRestrictions)};
	dataset(share.t_StringArrayItem) LicenseEndorsements {xpath('LicenseEndorsements/Value'), MAXCOUNT(iesp.constants.DL.MaxCountEndorsements)};
end;
		
export t_DLSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_DriverLicenseRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.constants.DL.MaxCountDL)};
end;
		
export t_RandDLSearchBy := record
	string State {xpath('State')};
	string Sex {xpath('Sex')};
	string Race {xpath('Race')};
	integer Age {xpath('Age')};
end;
		
export t_RandDLSearchOption := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
end;
		
export t_RandDLSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_DriverLicenseRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.constants.DL.MaxCountDL)};
end;
		
export t_DLSearchRequest := record (share.t_BaseRequest)
	t_DLSearchBy SearchBy {xpath('SearchBy')};
	t_DLSearchOption Options {xpath('Options')};
end;
		
export t_RandDLSearchRequest := record (share.t_BaseRequest)
	t_RandDLSearchBy SearchBy {xpath('SearchBy')};
	t_RandDLSearchOption Options {xpath('Options')};
end;
		
export t_DLSearchResponseEx := record
	t_DLSearchResponse response {xpath('response')};
end;
		
export t_RandDLSearchResponseEx := record
	t_RandDLSearchResponse response {xpath('response')};
end;
		

end;

