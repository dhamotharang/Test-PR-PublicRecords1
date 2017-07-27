export gateway_polk := MODULE
			
export t_VehicleCheckOptions := record (share.t_BaseOption)
	boolean skipDisallowedStateChecks {xpath('skipDisallowedStateChecks')};
end;

export t_VehicleCheckNameIn := record
	string First {xpath('First')};
	string Middle {xpath('Middle')};
	string Last {xpath('Last')};
	string Suffix {xpath('Suffix')}; //values['','JR','SR','I','II','III','IV'] //Blank for right now
end;
		
export t_VehicleCheckAddressIn := record
	string StreetAddress {xpath('StreetAddress')};
	string City {xpath('City')};
	string StateCode {xpath('StateCode')};
	string Zip5 {xpath('Zip5')};
end;
		
export t_VehicleCheckVehicleIn := record
	string VIN {xpath('VIN')};
	string ModelYear {xpath('ModelYear')};//Blank for right now
	string Make {xpath('Make')};//Blank for right now
	string Model {xpath('Model')};//Blank for right now
	string LicensePlateNum {xpath('LicensePlateNum')};
	string LicenseStateCode {xpath('LicenseStateCode')}; //Blank for right now
end;
		
export t_VehicleCheckSearchBy := record
	string SubCustomerId {xpath('SubCustomerId')};
	boolean BrandedTitleRequest {xpath('BrandedTitleRequest')};
	string Company {xpath('Company')};
	t_VehicleCheckNameIn Name {xpath('Name')};
	t_VehicleCheckAddressIn Address {xpath('Address')};
	dataset(t_VehicleCheckVehicleIn) ListedVehicles {xpath('ListedVehicles/Vehicle'), MAXCOUNT(1)};
	string PermissibleUse {xpath('PermissibleUse')}; //values['1A','1L','1P','2','3','4C','4U','5','6','']
	string Operation {xpath('Operation')}; //values['1','3','C','N','V','E','P','G','Z','X',''] - not anymore
end;
		
export t_VehicleCheckTitleBrand := record
	string BrandName {xpath('BrandName')};
	string2 StateCode {xpath('StateCode')};
end;
		
export t_VehicleCheckNameOut := record
	string30 Last {xpath('Last')};
	string14 First {xpath('First')};
	string1 Middle {xpath('Middle')};
	string24 Suffix {xpath('Suffix')};
end;
		
export t_VehicleCheckAddressOut := record
	string13 City {xpath('City')};
	string2 StateCode {xpath('StateCode')};
	string5 Zip5 {xpath('Zip5')};
	string4 Zip4 {xpath('Zip4')};
	string1 AddressTypeCode {xpath('AddressTypeCode')};
	string10 HouseNum {xpath('HouseNum')};
	string21 RuralRouteAddress {xpath('RuralRouteAddress')};
	string17 POBoxAddress {xpath('POBoxAddress')};
	string3 HouseNumFraction {xpath('HouseNumFraction')};
	string2 DirectionPrefix {xpath('DirectionPrefix')};
	string30 StreetName {xpath('StreetName')};
	string4 StreetSuffix {xpath('StreetSuffix')};
	string2 DirectionSuffix {xpath('DirectionSuffix')};
	string4 UnitType {xpath('UnitType')};
	string8 UnitNum {xpath('UnitNum')};
end;
		
export t_VehicleCheckVehicleOut := record
	boolean MatchesName {xpath('MatchesName')};
	boolean MatchesLastName {xpath('MatchesLastName')};
	boolean MatchesAddress {xpath('MatchesAddress')};
	boolean ValidVIN {xpath('ValidVIN')};
	t_VehicleCheckTitleBrand Brand1 {xpath('Brand1')};
	t_VehicleCheckTitleBrand Brand2 {xpath('Brand2')};
	integer SeqNum {xpath('SeqNum')};
	string17 VIN {xpath('VIN')};
	string4 ModelYear {xpath('ModelYear')};
	string4 Make {xpath('Make')};
	string2 BodyStyle {xpath('BodyStyle')};
	string3 Model {xpath('Model')};
	string2 LicenseStateCode {xpath('LicenseStateCode')};
	string8 LicenseDate {xpath('LicenseDate')};
	string8 ExpirationDate {xpath('ExpirationDate')};
	string4 RecordingDate {xpath('RecordingDate')};
	string1 PlateType {xpath('PlateType')};
	string1 LesseeLessorCode {xpath('LesseeLessorCode')};
	boolean IsVinBranded {xpath('IsVinBranded')};
	string1 DocumentType {xpath('DocumentType')};
	string1 VinChangedCode {xpath('VinChangedCode')};
	t_VehicleCheckAddressOut Address {xpath('Address')};
	string1 NameTitleCode1 {xpath('NameTitleCode1')};
	string1 NameTitleCode2 {xpath('NameTitleCode2')};
	string1 Name2Code {xpath('Name2Code')};
	t_VehicleCheckNameOut Name {xpath('Name')};
	t_VehicleCheckNameOut Name2 {xpath('Name2')};
	string45 Company {xpath('Company')};
	string45 Company2 {xpath('Company2')};
	string1 VINCompare {xpath('VINCompare')}; //values['Y','C','A','N','Z','']
	string1 Operation {xpath('Operation')}; //values['1','3','C','N','V','E','P','G','Z','X','']
end;
		
export t_VehicleCheckResponseRec := record
	string4 SubCustomerId {xpath('SubCustomerId')};
	boolean BrandedTitleRequest {xpath('BrandedTitleRequest')};
	integer NumVehicles {xpath('NumVehicles')};
	dataset(t_VehicleCheckVehicleOut) Vehicles {xpath('Vehicles/Vehicle'), MAXCOUNT(10)};
	string2 PermissibleUse {xpath('PermissibleUse')}; //values['1A','1L','1P','2','3','4C','4U','5','6','']
	string10 ErrorCode {xpath('ErrorCode')}; //values['','01','02','PU','SC']
end;
		
export t_VehicleCheckResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	t_VehicleCheckResponseRec Response {xpath('Response')};
end;
		
export t_VehicleCheckRequest := record (share.t_BaseRequest)
	share.t_GatewayParams GatewayParams {xpath('GatewayParams')};
	t_VehicleCheckOptions Options {xpath('Options')};
	t_VehicleCheckSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_VehicleCheckResponseEx := record
	t_VehicleCheckResponse response {xpath('response')};
end;
		

end;

