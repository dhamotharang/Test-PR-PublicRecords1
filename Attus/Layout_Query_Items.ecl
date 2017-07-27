Layout_Name := record
	string	Fullname {xpath('Full')};
	string	Lname {xpath('Last')};
	string	Fname {xpath('First')};
	string	Suffix {xpath('Suffix')};
	string	Prefix {xpath('Prefix')};
	string	Mname {xpath('Middle')};
end;

Layout_Address := record
	string	StreetNumber {xpath('StreetNumber')};
     string   StreetPreDirection {xpath('StreetPreDirection')};
     string StreetName {xpath('StreetName')};
     string	StreetSuffix {xpath('StreetSuffix')};
     string	StreetPostDirection {xpath('StreetPostDirection')};
     string	UnitDesignation {xpath('UnitDesignation')};
     string 	UnitNumber {xpath('UnitNumber')};
     string  City {xpath('City')};
     string	State {xpath('State')};
     string	Zip5 {xpath('Zip5')};
     string	Zip4 {xpath('Zip4')};
     string	County {xpath('County')};
     string StreetAddress1 {xpath('StreetAddress1')};
     string	StreetAddress2 {xpath('StreetAddress2')};
	string  StateCityZip {xpath('StateCityZip')};
     string  PostalCode {xpath('PostalCode')};
end;

export Layout_Query_Items := record
	string	Operator {xpath('Operator'), maxlength(25)};
	real		Thresh {xpath('Threshold')};
	layout_name	Name {xpath('Name')};
	layout_address Address {xpath('Address')};
	string	Country {xpath('Country')};	
	string	BlockedCountry {xpath('BlockedCountry')};	
	string	OtherName {xpath('OtherName')};	
	string	AllEntities {xpath('AllEntities')};	
	string	EntityId {xpath('EntityId')};
end;