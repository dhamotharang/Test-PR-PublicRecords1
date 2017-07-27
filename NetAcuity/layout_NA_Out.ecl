layout_exception := record
	string50	source;
	string20	code;
	string50	location;
	string100	message;
end;

layout_exceptions := record
	layout_exception	item {xpath('Item/')};
end;

layout_ResponseHeader := record, maxlength(10000)
	integer	Status {xpath('Status')};
	string100	Message {xpath('Message')};
	string25	QueryId {xpath('QueryId')};
	string25	TransactionId {xpath('TransactionId')};
	string100	ErrMsg {xpath('ErrMsg')};
	unsigned2	ErrCode {xpath('ErrCode')};
	dataset(layout_Exceptions) Exceptions {xpath('Exceptions/')};
end;

layout_Response := record
	layout_responseheader header {xpath('Header/')};
	string16	NetAddress {xpath('NetAddress')};
	string100	Country {xpath('Country')};
	string50	Region {xpath('Region')};
	string50	RegionDescription {xpath('RegionDescription')};
	string30	City {xpath('City')};
	integer	CountryConfid {xpath('CountryConfid')};
	integer	RegionConfid {xpath('RegionConfid')};
	integer	CityConfid {xpath('CityConfid')};
	integer	MetroCode {xpath('MetroCode')};
	integer	CountryCode {xpath('CountryCode')};
	integer	RegionCode {xpath('RegionCode')};
	integer	CityCode {xpath('CityCode')};
	integer	ContinentCode {xpath('ContinentCode')};
	string25	ConnectionSpeed {xpath('ConnectionSpeed')};
	real	Latitude {xpath('Latitude')};
	real	Longitude {xpath('Longitude')};
	string100	Domain {xpath('Domain')};
	integer	AreaCode {xpath('AreaCode')};
	string	TimeOffset {xpath('TimeOffset')};
	string20	InDst {xpath('InDst')};
	integer	ZipCode {xpath('ZipCode')};
	string10	ZipCodeText {xpath('ZipCodeText')};
	string100	Isp {xpath('ISP')};
	string100	HomeBiz {xpath('HomeBiz')};
	string25	PrimaryLanguage {xpath('PrimaryLanguage')};
	string25	SecondaryLanguage {xpath('SecondaryLanguage')};
	string100	Proxy {xpath('Proxy')};
	string3	IsAnIsp {xpath('IsAnIsp')};
	string120	Company {xpath('Company')};
	integer	Rnk {xpath('Rank')};
	integer 	Households {xpath('Households')};
	integer	Women {xpath('Women')};
	integer	Women18to34 {xpath('Women18to34')};
	integer	Women35to49 {xpath('women3to49')};
	integer	Men {xpath('Men')};
	integer	Men18to34 {xpath('Men18to34')};
	integer	Men35to49 {xpath('Men35to49')};
	integer	Teens {xpath('Teens')};
	integer	Kids {xpath('Kids')};
end;

export layout_NA_Out := record, maxlength(15000)
	layout_response	  response {xpath('Response/')};
end;
