export statewidefab := MODULE
			
export t_StatewideBusinessSearchSearchBy := record
	string Jurisdiction {xpath('Jurisdiction')};
	string CompanyName {xpath('CompanyName')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	integer Radius {xpath('Radius')};
	string FEIN {xpath('FEIN')};
	string Phone {xpath('Phone')};
	string AdditionalTerms {xpath('AdditionalTerms')};
end;
		
export t_StatewideBusinessSearchOption := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean UsePhonetics {xpath('UsePhonetics')};
	boolean IncludeAlsoFound {xpath('IncludeAlsoFound')};
	boolean SelectIndividually {xpath('SelectIndividually')};
	boolean IncludeUCC {xpath('IncludeUCC')};
	boolean IncludeProperty {xpath('IncludeProperty')};
	boolean IncludeProfessionalLicenses {xpath('IncludeProfessionalLicenses')};
	boolean IncludeBankruptcy {xpath('IncludeBankruptcy')};
	boolean IncludeLiens {xpath('IncludeLiens')};
	boolean IncludeWatercraft {xpath('IncludeWatercraft')};
	boolean IncludeVehicles {xpath('IncludeVehicles')};
	boolean IncludeCorp {xpath('IncludeCorp')};
	boolean IncludeFBN {xpath('IncludeFBN')};
	boolean IncludeCalBus {xpath('IncludeCalBus')};
	boolean IncludeTxBus {xpath('IncludeTxBus')};
end;
		
export t_StatewideBusinessSearchRecord := record
	string SourceDocType {xpath('SourceDocType')};
	string RecordId {xpath('RecordId')};
	string Jurisdiction {xpath('Jurisdiction')};
	string UniqueId {xpath('UniqueId')};
	boolean IsBusinessId {xpath('IsBusinessId')};
	share.t_Name Name {xpath('Name')};
	string CompanyName {xpath('CompanyName')};
	share.t_Address Address {xpath('Address')};
	string Phone {xpath('Phone')};
	string SSN {xpath('SSN')};
	string FEIN {xpath('FEIN')};
	share.t_Date DOB {xpath('DOB')};
end;
		
export t_StatewideBusinessSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_StatewideBusinessSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_StatewideBusinessSearchRequest := record (share.t_BaseRequest)
	t_StatewideBusinessSearchSearchBy SearchBy {xpath('SearchBy')};
	t_StatewideBusinessSearchOption Options {xpath('Options')};
end;
		
export t_StatewideBusinessSearchResponseEx := record
	t_StatewideBusinessSearchResponse response {xpath('response')};
end;
		

end;

