export phoneheaderscore := MODULE
import iesp;		
export t_PhoneHeaderAccount := record
	string AccountNumber {xpath('AccountNumber')};
	string AccountSuffix {xpath('AccountSuffix')};
	string CustomerNumber {xpath('CustomerNumber')};
	string CustomerName {xpath('CustomerName')};
end;
		
export t_RequireExactMatchPhoneHeader := record
	boolean LastName {xpath('LastName')};
	boolean FirstName {xpath('FirstName')};
	boolean FirstNameAllowNickname {xpath('FirstNameAllowNickname')};
end;
		
export t_PhoneHeaderOptions := record (iesp.share.t_BaseOption)
	t_RequireExactMatchPhoneHeader RequireExactMatch {xpath('RequireExactMatch')};
	string6 HistoryDateYYYYMM {xpath('HistoryDateYYYYMM')};
	string4 LastSeenThreshold {xpath('LastSeenThreshold')};
	string TransactionID {xpath('TransactionID')};
end;
		
export t_PhoneHeaderSearchBy := record
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	string10 HomePhone {xpath('HomePhone')};
end;
		
export t_PhoneHeaderResponseNAP := record
	string Summary {xpath('Summary')};
	string Type {xpath('Type')};
	string Status {xpath('Status')};
end;
		
export t_PhoneHeaderResponseData := record
	t_PhoneHeaderResponseNAP NameAddressPhone {xpath('NameAddressPhone')};
end;

export t_ResponseHeader := record
string16 TransactionId {xpath('TransactionId')};
	integer Status {xpath('Status')};
	// string256 Message {xpath('Message')};
	string50 QueryId {xpath('QueryId')};
	
	// dataset(t_WsException) Exceptions {xpath('Exceptions/Item'), MAXCOUNT(iesp.Constants.MaxResponseExceptions)};
end;
		
export t_PhoneHeaderResponse := record
	t_ResponseHeader _Header {xpath('Header')};
	t_PhoneHeaderResponseData ResponseData {xpath('ResponseData')};
end;
export t_EndUserInfo := record
	string120 CompanyName {xpath('CompanyName')};
	string200 StreetAddress1 {xpath('StreetAddress1')};
	string25 City {xpath('City')};
	string2 State {xpath('State')};
	string5 Zip5 {xpath('Zip5')};
	// string10 Phone {xpath('Phone')};
end;
export t_User := record
	string50 ReferenceCode {xpath('ReferenceCode')};
	string20 BillingCode {xpath('BillingCode')};
	string50 QueryId {xpath('QueryId')};
	string20 CompanyId {xpath('CompanyId')};//hidden[internal]
	string2 GLBPurpose {xpath('GLBPurpose')};
	string2 DLPurpose {xpath('DLPurpose')};
	t_EndUserInfo EndUser {xpath('EndUser')};
	integer MaxWaitSeconds {xpath('MaxWaitSeconds')};
	// string16 RelatedTransactionId {xpath('RelatedTransactionId')};//hidden[internal]
	string20 AccountNumber {xpath('AccountNumber')};
end;

export t_PhoneHeaderScoreRequest := record 
// iesp.share.t_BaseRequest)
	// t_PhoneHeaderAccount Account {xpath('Account')};
	// t_PhoneHeaderOptions Options {xpath('Options')};
	t_User User {xpath('User')};
	t_PhoneHeaderOptions Options {xpath('Options')};
	t_PhoneHeaderSearchBy SearchBy {xpath('SearchBy')};
	// string30 Seq {xpath('Seq')};//hidden[ecldev]
end;


export t_Report := record
	t_PhoneHeaderScoreRequest PhoneHeaderScoreRequest {xpath('PhoneHeaderScoreRequest')};
end;
		
export t_PhoneHeaderScoreResponseEx := record
	t_PhoneHeaderResponse response {xpath('response')};
end;

end;