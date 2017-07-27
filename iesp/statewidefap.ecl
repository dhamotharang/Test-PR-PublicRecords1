export statewidefap := MODULE
			
export t_StatewidePersonSearchSearchBy := record
	string Jurisdiction {xpath('Jurisdiction')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	integer Radius {xpath('Radius')};
	string SSN {xpath('SSN')};
	share.t_Date DOB {xpath('DOB')};
	string Phone {xpath('Phone')};
	string AdditionalTerms {xpath('AdditionalTerms')};
end;
		
export t_StatewidePersonSearchOption := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean UsePhonetics {xpath('UsePhonetics')};
	boolean IncludeAlsoFound {xpath('IncludeAlsoFound')};
	boolean SelectIndividually {xpath('SelectIndividually')};
	boolean IncludeVoters {xpath('IncludeVoters')};
	boolean IncludeUCC {xpath('IncludeUCC')};
	boolean IncludeProperty {xpath('IncludeProperty')};
	boolean IncludeHuntingFishingLicenses {xpath('IncludeHuntingFishingLicenses')};
	boolean IncludeHunting {xpath('IncludeHunting')};
	boolean IncludeProfessionalLicenses {xpath('IncludeProfessionalLicenses')};
	boolean IncludeSanctions {xpath('IncludeSanctions')};
	boolean IncludeProviders {xpath('IncludeProviders')};
	boolean IncludeBankruptcy {xpath('IncludeBankruptcy')};
	boolean IncludeLiens {xpath('IncludeLiens')};
	boolean IncludeMarriageDivorce {xpath('IncludeMarriageDivorce')};
	boolean IncludeDeath {xpath('IncludeDeath')};
	boolean IncludeDriverLicenses {xpath('IncludeDriverLicenses')};
	boolean IncludeWatercraft {xpath('IncludeWatercraft')};
	boolean IncludeVehicles {xpath('IncludeVehicles')};
	boolean IncludeEquifax {xpath('IncludeEquifax')};
	boolean IncludeCriminalRecords {xpath('IncludeCriminalRecords')};
	boolean IncludeWhitePages {xpath('IncludeWhitePages')};
	boolean IncludeTargus {xpath('IncludeTargus')};
end;
		
export t_Record := record
	string SourceDocType {xpath('SourceDocType')};
	string RecordId {xpath('RecordId')};
	string Jurisdiction {xpath('Jurisdiction')};
	string UniqueId {xpath('UniqueId')};
	boolean IsBusinessId {xpath('IsBusinessId')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string Phone {xpath('Phone')};
	string SSN {xpath('SSN')};
	share.t_Date DOB {xpath('DOB')};
end;
		
export t_StatewidePersonSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_Record) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_StatewidePersonSearchRequest := record (share.t_BaseRequest)
	t_StatewidePersonSearchSearchBy SearchBy {xpath('SearchBy')};
	t_StatewidePersonSearchOption Options {xpath('Options')};
end;
		
export t_StatewidePersonSearchResponseEx := record
	t_StatewidePersonSearchResponse response {xpath('response')};
end;
		

end;

