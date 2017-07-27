import GlobalWatchLists;

export globalwatchlist_v4 := MODULE

export t_Name := record
	unicode25 Prefix 	{xpath('Prefix')};
	unicode50 First 	{xpath('First')};
	unicode50 Middle 	{xpath('Middle')};
	unicode50 Last 		{xpath('Last')};
	unicode25 Suffix 	{xpath('Suffix')};
	unicode200 Full 	{xpath('Full')};
end;

export t_Address := record
	unicode10 StreetNumber 				{xpath('StreetNumber')};
	unicode50	StreetName 					{xpath('StreetName')};
	unicode12 StreetSuffix 				{xpath('StreetSuffix')};
	unicode12 StreetPreDirection 	{xpath('StreetPreDirection')};
	unicode12 StreetPostDirection {xpath('StreetPostDirection')};
	unicode12 UnitDesignation 		{xpath('UnitDesignation')};
	unicode10 UnitNumber 					{xpath('UnitNumber')};
	unicode200 StreetAddress1 		{xpath('StreetAddress1')};
	unicode200 StreetAddress2 		{xpath('StreetAddress2')};
	unicode50 City 								{xpath('City')};
	unicode50 StateOrProvince 		{xpath('StateOrProvince')};
	unicode12 PostalCode 					{xpath('PostalCode')};
	unicode50 Country 						{xpath('Country')};
end;

export t_Identification	:= record
		unicode50	IDNumber			{xpath('IDNumber')};
		unsigned1	IDType				{xpath('IDType')};
		unicode50	Label					{xpath('Label')};
		unicode50	IssuedBy			{xpath('IssuedBy')};
		string10	DateIssued		{xpath('DateIssued')};
		string10	DateExpires		{xpath('DateExpires')};
end;

export t_Phone := record 
	unicode20	PhoneNumber		{xpath('PhoneNumber')};
	unicode20	PhoneType			{xpath('PhoneType')};
end;

export t_SearchBy := record
	string1 EntityType {xpath('EntityType')}; 
	dataset(t_Name) Names {xpath('Names/Name')};
	dataset(share.t_Date) DOBs {xpath('DOBs/DOB')};
	dataset(t_Address) Addresses {xpath('Addresses/Address'), MAXCOUNT(GlobalWatchLists.constants.MaxInputDataRows)};
	dataset(t_Identification) IDs {xpath('IDs/ID'), MAXCOUNT(GlobalWatchLists.constants.MaxInputDataRows)};
	dataset(t_Phone) Phones {xpath('Phones/Phone'), MAXCOUNT(GlobalWatchLists.constants.MaxInputDataRows)};
end;

export t_SearchOptions := record
	boolean AFPRuleAddress {xpath('AFPRuleAddress')};
	boolean AFPRuleCountry {xpath('AFPRuleCountry')};
	boolean AFPRuleDOB {xpath('AFPRuleDOB')};
	integer DOBRadiusInMonths {xpath('DOBRadiusInMonths')};
	boolean AFPRuleEntityType {xpath('AFPRuleEntityType')};
	boolean AFPRuleGender {xpath('AFPRuleGender')};
	boolean AFPRuleID {xpath('AFPRuleID')};
	boolean AFPRulePhone {xpath('AFPRulePhone')};
	boolean AFPReturnMatches {xpath('AFPReturnMatches')};
	
	boolean IgnoreVesselMatches {xpath('IgnoreVesselMatches')};
	boolean IgnoreWeakAKAs {xpath('IgnoreWeakAKAs')};
	boolean IncreaseScoreForInitials {xpath('IncreaseScoreForInitials')};
	
	boolean IndexAddress {xpath('IndexAddress')};
	boolean IndexID {xpath('IndexID')};
	boolean IndexName {xpath('IndexName')};
	boolean IndexPhone {xpath('IndexPhone')};
	
	boolean ScanAddressForCountries {xpath('ScanAddressForCountries')};
	boolean ScanAddressNames {xpath('ScanAddressNames')};
	boolean ScanNameForCountries {xpath('ScanNameForCountries')};
	

	real4 ThresholdCountryScore {xpath('ThresholdCountryScore')};
	real4 ThresholdEntityScore {xpath('ThresholdEntityScore')};
	
	dataset(share.t_StringArrayItem) WatchList {xpath('WatchList/Name'), MAXCOUNT(iesp.Constants.MaxCountWatchLists)};
end;

export t_SearchRequest := record (share.t_BaseRequest)
	t_SearchOptions SearchOptions {xpath('SearchOptions')};
	t_SearchBy SearchBy {xpath('SearchBy')};
end;

export t_WatchListEntity := record, maxlength(10240)
	string20	EntityID {xpath('EntityID')};	
	string150	WatchListName {xpath('WatchListName')};
	string10	WatchListDate {xpath('WatchListDate')};
	string1		EntityType {xpath('EntityType')};
	unicode200	Title {xpath('Title')};
	unicode100	FirstName {xpath('FirstName')};
	unicode100	MiddleName {xpath('MiddleName')};
	unicode100	LastName {xpath('LastName')};
	unicode20	Generation {xpath('Generation')};
	unicode320	FullName {xpath('FullName')};
	unicode1		Gender {xpath('Gender')};
	string10	DateListed {xpath('DateListed')};
	unicode100	ReasonListed {xpath('ReasonListed')};
	unicode40	ReferenceID {xpath('ReferenceID')};
	unicode8192	Comments {xpath('Comments')}; 
end;

export t_WatchListAKA := record, maxlength(8192)
	unicode10	AkaType {xpath('AkaType')};
	unicode10	Category {xpath('Category')};
	unicode200	Title {xpath('Title')};
	unicode100	FirstName {xpath('FirstName')};
	unicode100	MiddleName {xpath('MiddleName')};
	unicode100	LastName {xpath('LastName')};
	unicode20	Generation {xpath('Generation')};
	unicode320	FullName {xpath('FullName')};
	unicode1024 Comments {xpath('Comments')}; 
end;

export t_WatchListAddress := record, maxlength(8192)
	unicode10	AddressType {xpath('AddressType')};
	unicode256	StreetAddress1 {xpath('StreetAddress1')};
	unicode256	StreetAddress2 {xpath('StreetAddress2')};
	unicode50	City {xpath('City')};
	unicode50	State {xpath('State')};
	unicode20	Zip {xpath('Zip')};
	unicode50	Country {xpath('Country')};
	unicode1024	Comments {xpath('Comments')};
end;

export t_WatchListIdentification := record, maxlength(8192)
	unicode50	IDNumber {xpath('IDNumber')};
	unsigned1 IDType {xpath('IDType')};
	unicode50	Label {xpath('Label')};
	unicode50	IssuedBy {xpath('IssuedBy')};
	string10	DateIssued {xpath('DateIssued')};
	string10	DateExpires {xpath('DateExpires')};
	unicode1024	Comments {xpath('Comments')};
end;

export t_WatchListPhone := record, maxlength(8192)
	unicode20	PhoneNumber {xpath('PhoneNumber')};
	unicode20	PhoneType {xpath('PhoneType')};
	unicode1024	Comments {xpath('Comments')};
end;

export t_WatchListAdditionalInfo := record, maxlength(10240)
	unicode50		AddlInfoType {xpath('AddlInfoType')};
	unicode1024	AddlInfo {xpath('AddlInfo')};
	unicode8192	Comments {xpath('Comments')};
end;

export t_WatchListCountry := record, maxlength(4800)
	string20	CountryID {xpath('CountryID')}; 
	string150	WatchListName {xpath('WatchListName')};
	string10	WatchListDate {xpath('WatchListDate')};
	unicode120	CountryName {xpath('CountryName')};
	string10	DateListed {xpath('DateListed')};
	unicode100	ReasonListed {xpath('ReasonListed')};
	unicode4096	Comments {xpath('Comments')};
end;

export t_WatchListCountryAKA := record, maxlength(256)
	unicode10	AkaType {xpath('AkaType')};
	unicode120	Aka {xpath('Aka')};
end;

export t_WatchListMatchInfo := record, maxlength(1024)
	unsigned1 EntityScore {xpath('EntityScore')};
	boolean 	EntityTypeConflict {xpath('EntityTypeConflict')};
	boolean		FalsePositive {xpath('FalsePositive')};
	boolean 	GenderConflict {xpath('GenderConflict')};

	unsigned1	AddressRecordID {xpath('AddressRecordID')};
	unsigned1	AddressScore {xpath('AddressScore')};
	boolean 	AddressConflict {xpath('AddressConflict')};
	boolean 	CountryConflict {xpath('CountryConflict')};
	boolean 	IsAddressPartial {xpath('IsAddressPartial')};
	
	unsigned1	DOBRecordID {xpath('DOBRecordID')};
	unsigned1	DOBScore {xpath('DOBScore')};
	boolean 	DOBConflict {xpath('DOBConflict')};
	boolean 	IsDOBPartial {xpath('IsDOBPartial')};

	unsigned1	IDRecordID {xpath('IDRecordID')};
	unsigned1	IDScore {xpath('IDScore')};
	boolean 	IDConflict {xpath('IDConflict')};

	unsigned1	NameRecordID {xpath('NameRecordID')};
	unsigned1	NameScore {xpath('NameScore')};
	unicode		MatchingFirstName {xpath('MatchingFirstName')};
	unicode		MatchingMiddleName {xpath('MatchingMiddleName')};
	unicode		MatchingLastName {xpath('MatchingLastName')};
	unicode		MatchingFullName {xpath('MatchingFullName')};
	boolean 	IsNameSingleWordMatch {xpath('IsNameSingleWordMatch')};

	unsigned1	PhoneRecordID {xpath('PhoneRecordID')};
	unsigned1	PhoneScore {xpath('PhoneScore')};
	boolean 	PhoneConflict {xpath('PhoneConflict')};
end;

export t_WatchListData := record
	t_WatchListMatchInfo MatchInfo {xpath('MatchInfo')};
	t_WatchListEntity Entity {xpath('Entity')};
	dataset(t_WatchListAKA) AKAs  {xpath('AKAs/AKA'), MAXCOUNT(GlobalWatchLists.constants.MaxOutputDataRows)};
	dataset(t_WatchListAddress) Addresses {xpath('Addresses/Address'), MAXCOUNT(GlobalWatchLists.constants.MaxOutputDataRows)};
	dataset(t_WatchListIdentification) IDs {xpath('IDs/ID'), MAXCOUNT(GlobalWatchLists.constants.MaxOutputDataRows)};
	dataset(t_WatchListPhone) Phones {xpath('Phones/Phone'), MAXCOUNT(GlobalWatchLists.constants.MaxOutputDataRows)};
	dataset(t_WatchListAdditionalInfo) AddInfo  {xpath('AddInfo/Info'), MAXCOUNT(GlobalWatchLists.constants.MaxOutputDataRows)};
end;

export t_WatchListCountryData := record
	unsigned1 CountryRecordID {xpath('CountryRecordID')};
	unsigned1 CountryScore {xpath('CountryScore')};
	unicode		MatchingCountry {xpath('MatchingCountry')};
	t_WatchListCountry Country {xpath('Country')};
	dataset(t_WatchListCountryAKA) AKAs  {xpath('AKAs/AKA'), MAXCOUNT(GlobalWatchLists.constants.MaxOutputDataRows)};
end;

export t_GlobalWatchListResponse := record
	t_SearchBy InputEcho {xpath('InputEcho')};
	dataset(t_WatchListData) EntityResults {xpath('EntityResults/Result'), MAXCOUNT(GlobalWatchLists.constants.MaxOutputDataRows)};
	dataset(t_WatchListCountryData) CountryResults {xpath('CountryResults/Result'), MAXCOUNT(GlobalWatchLists.constants.MaxOutputDataRows)};
end;

export t_GlobalWatchListResponseEx := record
	t_GlobalWatchListResponse response {xpath('response')};
end;

end;