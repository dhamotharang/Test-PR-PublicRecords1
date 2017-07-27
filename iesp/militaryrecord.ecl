export militaryrecord := MODULE
			
export t_MilitaryRecordSearchBy := record (share.t_BaseSearchBy)
	string UniqueId {xpath('UniqueId')};
	string MilitaryRecordId {xpath('MilitaryRecordId')};
	share.t_Name Name {xpath('Name')};
	string MilitaryServiceBranch {xpath('MilitaryServiceBranch')};
	string State {xpath('State')};
end;
		
export t_MilitaryRecordSearchOption := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean UsePhonetics {xpath('UsePhonetics')};
	boolean UseNicknames {xpath('UseNicknames')};
	boolean IncludeAlsoFound {xpath('IncludeAlsoFound')};
end;
		
export t_MilitaryOccupation := record
	string Primary {xpath('Primary')};
	string Duty {xpath('Duty')};
	string Second {xpath('Second')};
end;
		
export t_MilitaryRecordBaseRecord := record
	boolean AlsoFound {xpath('AlsoFound')};
	string UniqueId {xpath('UniqueId')};
	string MilitaryRecordId {xpath('MilitaryRecordId')};
	string Title {xpath('Title')};
	share.t_Name Name {xpath('Name')};
	string Gender {xpath('Gender')};
	share.t_Address Address {xpath('Address')};
	string LegalResidentState {xpath('LegalResidentState')};
	string OriginalZipCode {xpath('OriginalZipCode')};
	string HomeState {xpath('HomeState')};
	string DutyBase {xpath('DutyBase')};
	t_MilitaryOccupation Occupation {xpath('Occupation')};
	t_MilitaryOccupation OccupationMOS {xpath('OccupationMOS')};
	string HighestCivilianEducation {xpath('HighestCivilianEducation')};
	string SourceOfEntry {xpath('SourceOfEntry')};
	string MilitaryServiceBranch {xpath('MilitaryServiceBranch')};
	string MilitaryStatus {xpath('MilitaryStatus')};
	string PayGrade {xpath('PayGrade')};
	integer YearsOfService {xpath('YearsOfService')};
	share.t_Date EstimateSeparationDate {xpath('EstimateSeparationDate')};
	share.t_Date SeparationDate {xpath('SeparationDate')};
	share.t_Date BasicActiveServiceDate {xpath('BasicActiveServiceDate')};
end;
		
export t_MilitaryRecordSearchRecord := record (t_MilitaryRecordBaseRecord)
end;
		
export t_MilitaryRecordSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_MilitaryRecordSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_MilitaryRecordSearchRequest := record (share.t_BaseRequest)
	t_MilitaryRecordSearchBy SearchBy {xpath('SearchBy')};
	t_MilitaryRecordSearchOption Options {xpath('Options')};
end;
		
export t_MilitaryRecordSearchResponseEx := record
	t_MilitaryRecordSearchResponse response {xpath('response')};
end;
		

end;

