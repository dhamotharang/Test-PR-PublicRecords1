Layout_TimeStamp := RECORD
	unsigned1 Hour24 {xpath('Hour24')} := 0;
	unsigned1 Minute {xpath('Minute')} := 0;
	unsigned1 Second {xpath('Second')} := 0;	
	unsigned2 Year {xpath('Year')} := 0;
	unsigned1 Month {xpath('Month')} := 0;
	unsigned1 Day {xpath('Day')} := 0;
END;

Layout_GDCResponseHeader := RECORD
	string QueryId {xpath('QueryId')};
	string TransactionId {xpath('TransactionId')};
	string TransactionFee {xpath('Fee')};
	Layout_TimeStamp TimeStamp {xpath('TimeStamp')};	
	string GDCErrorCode {xpath('GeneralErrorCode')};
	string GDCErrorMessage {xpath('GeneralErrorDescription')};
	string100	ErrorMessage;
	unsigned	ErrorCode;
	string URL {xpath('URL')};
END;

Layout_GDCResultsResponse := RECORD
	string FirstName {xpath('FirstName')};
	string FirstInitial {xpath('FirstInitial')};
	string MiddleName {xpath('MiddleName')};
	string LastName {xpath('LastName')};
	string FullName {xpath('FullName')};
	string Address {xpath('Address')};
	string FullStreet {xpath('FullStreet')};
	string UnitNumber {xpath('UnitNumber')};
	string StreetNumber {xpath('StreetNumber')};
	string StreetName {xpath('StreetName')};
	string StreetType {xpath('StreetType')};
	string Aza {xpath('Aza')};
	string Suburb {xpath('Suburb')};
	string Area {xpath('Area')};
	string State {xpath('State')};
	string PostalCode {xpath('PostalCode')};
	string PhoneNumber {xpath('PhoneNumber')};
	string DateOfBirth {xpath('DateOfBirth')};
	string DayOfBirth {xpath('DayOfBirth')};
	string MonthOfBirth {xpath('MonthOfBirth')};
	string YearOfBirth {xpath('YearOfBirth')};
	string IdCard {xpath('IdCard')};
	string AMLBureau {xpath('AMLBureau')};
END;

Layout_GDCDataSourceResponse := RECORD
	string SourceName {xpath('SourceName')};
	string SourceId {xpath('DataSourceId')};
	string SourceType {xpath('DataSourceType')};	
	Layout_GDCResultsResponse Results {xpath('Result/')};
	string MatchedToRules {xpath('MatchedToRules')};
	string ErrorCode {xpath('ErrorCode')};
	string ErrorMessage {xpath('ErrorDescription')};
	string Photo {xpath('Photo'), maxlength(25000)};
END;

Layout_GDCOverAllResultsResponse := RECORD
	string MatchedToRules  {xpath('OverAllMatchedToRules')};
END;

Layout_GDCVerifyCheckResponseEx := RECORD
	Layout_GDCResponseHeader Header {xpath('Header/')};
	dataset(Layout_GDCDataSourceResponse) DataSources {xpath('DataSources/DataSource')};
	Layout_GDCOverAllResultsResponse OverAllResultsResponse {xpath('OverAllResults/')};
END;

export Layout_GDCVerify_Out := RECORD
	Layout_GDCVerifyCheckResponseEx Response {xpath('response/GDCResponse')};
END;
