layout_user := record
	string20	ReferenceCode {xpath('ReferenceCode')} := '';
	string20	BillingCode {xpath('BillingCode')} := '';
	string20	QueryID {xpath('QueryId')} := '';
	unsigned1	GLBPurpose {xpath('GLBPurpose')} := 5;
	unsigned1	DLPurpose {xpath('DLPurpose')} := 0;
end;

Layout_GatewayParams := record
	string16 	TxnTransactionId {xpath('TxnTransactionId')} := '';
	integer 	BatchJobId {xpath('BatchJobId')} := 0;
	integer 	ProcessSpecId {xpath('ProcessSpecId')} := 0;
	integer 	RoyaltyCode {xpath('RoyaltyCode')} := 0;
	string50 	RoyaltyType {xpath('RoyaltyType')} := '';
	string80 	QueryName {xpath('QueryName')} := '';
	boolean	 	CheckVendorGatewayCall {xpath('CheckVendorGatewayCall')} := false;//hidden[internal]
	boolean  	MakeVendorGatewayCall {xpath('MakeVendorGatewayCall')} := false; //hidden[internal]
end;

Layout_VerifyExpressOptions := record
	boolean	IncludeInputNameScore {xpath('IncludeInputNameScore')} := false;
	boolean	IncludeInputAddressScore  {xpath('IncludeInputAddressScore')}:= false;
	boolean	IncludeInputPhoneScore {xpath('IncludeInputPhoneScore')} := false;
	boolean	IncludeMatchedNameScore {xpath('IncludeMatchedNameScore')} := false;
	boolean	IncludeMatchedAddressScore {xpath('IncludeMatchedAddressScore')} := false;
	boolean	IncludeMatchedPhoneScore {xpath('IncludeMatchedPhoneScore')} := false;
	boolean	IncludeMatchedCompositeScore {xpath('IncludeMatchedCompositeScore')} := false;
	boolean	IncludeMatchedName {xpath('IncludeMatchedName')} := false; 
	boolean	IncludeMatchedPrimaryAddress {xpath('IncludeMatchedPrimaryAddress')} := false;
	boolean	IncludeMatchedSecondaryAddress {xpath('IncludeMatchedSecondaryAddress')} := false;
	boolean	IncludeMatchedCityName {xpath('IncludeMatchedCityName')} := false;
	boolean	IncludeMatchedState {xpath('IncludeMatchedState')} := false;
	boolean	IncludeMatchedCorrectedZIPCode {xpath('IncludeMatchedCorrectedZIPCode')} := false;
	boolean	IncludeStatusCodes {xpath('IncludeStatusCodes')} := false;
	boolean	IncludeMatchedOrCorrectedPhone {xpath('IncludeMatchedOrCorrectedPhone')} := false;
	boolean	IncludeDoNotCallFlag {xpath('IncludeDoNotCallFlag')} := false;
	boolean	IncludeCurrentPhoneStatus {xpath('IncludeCurrentPhoneStatus')} := false; 
	boolean	IncludeNameAddressCurrencyIndicator {xpath('IncludeNameAddressCurrencyIndicator')} := false;
	boolean	IncludeStateDoNotCall {xpath('IncludeStateDoNotCall')} := false;
	boolean	IncludeEquipmentPortFlag {xpath('IncludeEquipmentPortFlag')} := false;
	string20	ScreenOptions {xpath('ScreenOptions')} := ''; 
end;


layout_Options := record
	boolean 				IncludeWirelessConnectionSearch {xpath('IncludeWirelessConnectionSearch')} := false;
	boolean					IncludePhoneDataExpressSearch {xpath('IncludePhoneDataExpressSearch')} := false;
	boolean					IncludeIntlPhoneDataExpressSearch {xpath('IncludeIntlPhoneDataExpressSearch')} := false;
	Layout_VerifyExpressOptions 	VerifyExpressOptions {xpath('VerifyExpressOptions')};
	boolean					IncludeNameVerificationSearch {xpath('IncludeNameVerificationSearch')} := false;
	boolean					Blind {xpath('Blind')} := false;
end;

Layout_ConsumerName := record
	string75	FullName {xpath('Full')} := '';
	string20	Fname {xpath('First')} := '';
	string20	Middle {xpath('Middle')} := '' ;
	string20	Lname {xpath('Last')} := '';
	string5	Suffix {xpath('Suffix')} := '';
	string5	Prefix {xpath('Prefix')} := '';
end;

Layout_Address := record
	string28		streetName {xpath('StreetName')} := '';
	string10		streetNumber {xpath('StreetNumber')} := '';
	string2		streetPreDirection {xpath('StreetPreDirection')} := '';
	string2		streetPostDirection {xpath('StreetPostDirection')} := '';
	string4		StreetSuffix {xpath('StreetSuffix')} := '';
	string10		UnitDesignation {xpath('UnitDesignation')} := '';
	string8		UnitNumber {xpath('UnitNumber')} := '';
	string100		StreetAddress1 {xpath('StreetAddress1')} := '';
	string100		StreetAddress2 {xpath('StreetAddress2')} := '';
	string2		State {xpath('State')} := '';
	string25		City {xpath('City')} := '';
	string5		zip5 {xpath('Zip5')} := '';
	string4		zip4 {xpath('Zip4')} := '';
	string30		County {xpath('County')} := '';
	string10		PostalCode {xpath('PostalCode')} := '';
	string40		StateCityZip {xpath('StateCityZip')} := '';
end;

Layout_SearchBy := record
	Layout_ConsumerName	ConsumerName {xpath('ConsumerName')};
	string120			CompanyName {xpath('CompanyName')} := '';
	string120			UnknownName {xpath('UnknownName')} := '';
	string10			PhoneNumber {xpath('PhoneNumber')} := '';
	Layout_Address		Address {xpath('Address')} ;
end;

export Layout_Targus_In := record
	Layout_GatewayParams GatewayParams {xpath('GatewayParams')};
	layout_user		User {xpath('User')};	
	layout_Options		Options {xpath('Options')};
	Layout_SearchBy	SearchBy {xpath('SearchBy')};
end;
