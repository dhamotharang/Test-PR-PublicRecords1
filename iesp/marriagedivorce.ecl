export marriagedivorce := MODULE
			
export t_MarriageSearchBy := record
	share.t_Name Name {xpath('Name')};
	string State {xpath('State')};
	string County {xpath('County')};
	string FilingNumber {xpath('FilingNumber')};
end;
		
export t_MarriageSearchOption := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
end;
		
export t_MarriageSearchParty := record
	string PartyType {xpath('PartyType')};
	share.t_Name Name {xpath('Name')};
	string ResidenceState {xpath('ResidenceState')};
	string ResidenceCity {xpath('ResidenceCity')};
	string ResidenceCounty {xpath('ResidenceCounty')};
	integer Age {xpath('Age')};
end;
		
export t_MarriageSearchRecord := record
	string FilingType {xpath('FilingType')};
	string FilingNumber {xpath('FilingNumber')};
	string StateOrigin {xpath('StateOrigin')};
	string CountyOrigin {xpath('CountyOrigin')};
	string CityOrigin {xpath('CityOrigin')};
	string DivorceGrounds {xpath('DivorceGrounds')};
	integer NumberOfChildren {xpath('NumberOfChildren')};
	share.t_Date FilingDate {xpath('FilingDate')};
	share.t_Date MarriageDate {xpath('MarriageDate')};
	share.t_Date DivorceDate {xpath('DivorceDate')};
	t_MarriageSearchParty Party1 {xpath('Party1')};
	t_MarriageSearchParty Party2 {xpath('Party2')};
end;
		
export t_MarriageSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_MarriageSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_MarriageSearch2By := record (share.t_BaseSearchBy)
	share.t_Name Name {xpath('Name')};
	string State {xpath('State')};
	string County {xpath('County')};
	string FilingNumber {xpath('FilingNumber')};
	string UniqueId {xpath('UniqueId')};
	string RecordId {xpath('RecordId')};
	share.t_DateRange FilingDate {xpath('FilingDate')};
end;
		
export t_MarriageSearch2Option := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean UseNicknames {xpath('UseNicknames')};
	boolean IncludeAlsoFound {xpath('IncludeAlsoFound')};
	boolean UsePhonetics {xpath('UsePhonetics')};
end;
		
export t_MarriageSearch2Party := record
	string UniqueId {xpath('UniqueId')};
	string PartyType {xpath('PartyType')};
	string PartyTypeCode {xpath('PartyTypeCode')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	integer Age {xpath('Age')};
	integer TimesMarried {xpath('TimesMarried')};
	share.t_Date DOB {xpath('DOB')};
	string PreviousMaritalStatus {xpath('PreviousMaritalStatus')};
	string BirthState {xpath('BirthState')};
	string HowMarriageEnded {xpath('HowMarriageEnded')};
	string Race {xpath('Race')};
end;
		
export t_MarriageSearch2Record := record
	boolean AlsoFound {xpath('AlsoFound')};
	string RecordId {xpath('RecordId')};
	string FilingType {xpath('FilingType')};
	string FilingTypeCode {xpath('FilingTypeCode')};
	string StateOrigin {xpath('StateOrigin')};
	string FilingNumber {xpath('FilingNumber')};
	share.t_Date FilingDate {xpath('FilingDate')};
	share.t_Date MarriageDate {xpath('MarriageDate')};
	share.t_Date DivorceDate {xpath('DivorceDate')};
	string CountyOrigin {xpath('CountyOrigin')};
	string DivorceCounty {xpath('DivorceCounty')};
	string CityOrigin {xpath('CityOrigin')};
	string DivorceGrounds {xpath('DivorceGrounds')};
	integer NumberOfChildren {xpath('NumberOfChildren')};
	t_MarriageSearch2Party Party1 {xpath('Party1')};
	t_MarriageSearch2Party Party2 {xpath('Party2')};
	string Ceremony {xpath('Ceremony')};
	string PlaceOfMarriage {xpath('PlaceOfMarriage')};
end;
		
export t_MarriageSearch2Response := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_MarriageSearch2Record) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_MarriageSearchRequest := record (share.t_BaseRequest)
	t_MarriageSearchBy SearchBy {xpath('SearchBy')};
	t_MarriageSearchOption Options {xpath('Options')};
end;
		
export t_MarriageSearch2Request := record (share.t_BaseRequest)
	t_MarriageSearch2By SearchBy {xpath('SearchBy')};
	t_MarriageSearch2Option Options {xpath('Options')};
end;
		
export t_MarriageSearchResponseEx := record
	t_MarriageSearchResponse response {xpath('response')};
end;
		
export t_MarriageSearch2ResponseEx := record
	t_MarriageSearch2Response response {xpath('response')};
end;
		

end;

