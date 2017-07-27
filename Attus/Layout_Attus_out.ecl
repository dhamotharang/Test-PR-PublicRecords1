Layout_AKA := record
	string75	Name {xpath('Name')};
	string20	AKA_Type {xpath('Type')};
	real		MatchScore {xpath('MatchScore')};
end;

Layout_Address := record
	string10	StreetNumber {xpath('StreetNumber')};
     string2   StreetPreDirection {xpath('StreetPreDirection')};
     string100 StreetName {xpath('StreetName')};
     string4	StreetSuffix {xpath('StreetSuffix')};
     string2	StreetPostDirection {xpath('StreetPostDirection')};
     string10	UnitDesignation {xpath('UnitDesignation')};
     string8 	UnitNumber {xpath('UnitNumber')};
     string25  City {xpath('City')};
     string2	State {xpath('State')};
     string5	Zip5 {xpath('Zip5')};
     string4	Zip4 {xpath('Zip4')};
     string30	County {xpath('Country')};
     string120 StreetAddress1 {xpath('StreetAddress1')};
     string120	StreetAddress2 {xpath('StreetAddress2')};
	string50  StateCityZip {xpath('StateCityZip')};
     string10  PostalCode {xpath('PostalCode')};
end;

Layout_EntityAddress := record
	layout_address Address {xpath('Address/')};
	string30	Country {xpath('Country')};
	string100	Remark {xpath('Remark')};
end;

Layout_Name := record
	string75	Fullname {xpath('Full')};
	string50	Lname {xpath('Last')};
	string40	Fname {xpath('First')};
	string5	Suffix {xpath('Suffix')};
	string5	Prefix {xpath('Prefix')};
	string20	Mname {xpath('Middle')};
end;

Layout_ResultEntity := record, maxlength(20000)
	string20	EntityId {xpath('EntityId')};
	real		MaxMatchScore {xpath('MaxMatchScore')};
	layout_name	Name {xpath('Name/')};
	string75	OtherName {xpath('OtherName')};
	boolean	IsAliasHit {xpath('IsAliasHit')};
	real		MatchScore {xpath('MatchScore')};
	string20	Res_Type {xpath('Type')};
	string100	Programs {xpath('Programs')};
	string100 Remarks {xpath('Remarks')};
	dataset(layout_AKA)	AKAs {xpath('AKAs/AKA/')};
	dataset(layout_EntityAddress)	EntityAddresses {xpath('EntityAddresses/EntityAddress/')};
end;

layout_BlockedCountry := record
	string30	CountryId {xpath('CountryId')};
	string75	Name {xpath('Name')};
	real		MatchScore {xpath('MatchScore')};
	string100	Description {xpath('Description')};
end;

layout_listResult := record, maxlength(25000)
	unsigned	TotalHits {xpath('TotalHits')};
	unsigned 	EntityHits {xpath('EntityHits')};
	unsigned	BlockedCountryHits {xpath('BlockedCountryHits')};
	string120	ListName {xpath('ListName')};
	string20	ListCode {xpath('ListCode')};
	string220	ListDescription {xpath('ListDescription')};
	dataset(Layout_ResultEntity) ResultEntities {xpath('ResultEntities/ResultEntity/')};
	dataset(Layout_BlockedCountry) BlockedCountries {xpath('BlockedCountries/BlockedCountry/')};
end;

layout_query_item := record
	string25	Operator {xpath('Operator')};
	real		Thresh {xpath('Threshold')};
	layout_name	Name {xpath('Name/')};
	layout_address Address {xpath('Address/')};
	string50	Country {xpath('Country')};	
	string50	BlockedCountry {xpath('BlockedCountry')};	
	string100	OtherName {xpath('OtherName')};	
	string100	AllEntities {xpath('AllEntities')};	
	string25	EntityId {xpath('EntityId')};
end;

layout_list := record
	string25 List {xpath('List')};
end;

layout_input_echo := record, maxlength(10000)
	dataset(layout_List) CheckLists {xpath('CheckLists/')};
	dataset(layout_Query_Item) QueryItems {xpath('QueryItems/QueryItem/')};
end;

layout_Header := record
	string25	TransactionId {xpath('TransactionId')};
	string25	QueryId {xpath('QueryId')};
	unsigned2	Status {xpath('Status')};
	string100	Message {xpath('Message')};
end;

export Layout_Attus_out := record, maxlength(30000)
	string100	ErrorMessage;
	unsigned	ErrorCode;
	layout_header	Header {xpath('Header/')};
	layout_input_echo InputEcho {xpath('InputEcho/')};
	dataset(layout_listResult) ListResults {xpath('ListResults/ListResult')};
end;
