/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from fraudgovsearch.xml. ***/
/*===================================================*/

import iesp;

export fraudgovsearch := MODULE
			
export t_FraudGovSearchBy := record
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	iesp.share.t_Date DOB {xpath('DOB')};
	string11 SSN {xpath('SSN')};
	string15 Phone10 {xpath('Phone10')};
	string12 UniqueId {xpath('UniqueId')};
	string50 EmailAddress {xpath('EmailAddress')};
	iesp.fraudgovplatform.t_FraudGovDriversLicense DriversLicense {xpath('DriversLicense')};
	string10 ProgramCode {xpath('ProgramCode')};
	string20 HouseholdId {xpath('HouseholdId')};
	string20 CustomerPersonId {xpath('CustomerPersonId')};
	iesp.share.t_Date TransactionStartDate {xpath('TransactionStartDate')};
	iesp.share.t_Date TransactionEndDate {xpath('TransactionEndDate')};
	string12 AmountMin {xpath('AmountMin')};
	string12 AmountMax {xpath('AmountMax')};
	string100 BankName {xpath('BankName')};
	iesp.fraudgovplatform.t_FraudGovBankInformation BankInformation {xpath('BankInformation')};
	string75 ISPName {xpath('ISPName')};
	string25 IpAddress {xpath('IpAddress')};
	string25 MACAddress {xpath('MACAddress')};
	string50 DeviceId {xpath('DeviceId')};
	string20 DeviceSerialNumber {xpath('DeviceSerialNumber')};
	unsigned6 AppendedProviderId {xpath('AppendedProviderId')};
	unsigned6 LNPID {xpath('LNPID')};
	string10 TIN {xpath('TIN')};
	string10 NPI {xpath('NPI')};
	string12 ProfessionalId {xpath('ProfessionalId')};
	iesp.share.t_GeoLocation GeoLocation {xpath('GeoLocation')};
	dataset(iesp.share.t_BusinessIdentity) BusinessLinkIds {xpath('BusinessLinkIds/BusinessLinkId'), MAXCOUNT(iesp.Constants.FraudGov.MAX_COUNT_BUSINESS_LINKIDS)};
	iesp.share.t_Address MailingAddress {xpath('MailingAddress')};
end;
		
export t_FraudGovSearchOption := record (iesp.share.t_BaseOption)
	boolean IsOnline {xpath('IsOnline')};
	boolean IsTestRequest {xpath('IsTestRequest')};
	string Platform {xpath('Platform')};
end;
		
export t_FraudGovSearchElementInformation := record
	string12 UniqueId {xpath('UniqueId')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	iesp.share.t_GeoLocation GeoLocation {xpath('GeoLocation')};
	string11 SSN {xpath('SSN')};
	string15 Phone10 {xpath('Phone10')};
	string25 IpAddress {xpath('IpAddress')};
	iesp.fraudgovplatform.t_FraudGovBankInformation BankInformation {xpath('BankInformation')};
	iesp.fraudgovplatform.t_FraudGovDriversLicense DriversLicense {xpath('DriversLicense')};
	string50 DeviceId {xpath('DeviceId')};
	iesp.share.t_Address MailingAddress {xpath('MailingAddress')};
end;
		
export t_FraudGovSearchRecord := record
	string70 AnalyticsRecordId {xpath('AnalyticsRecordId')};
	string10 RecordType {xpath('RecordType')};
	string30 RecordSource {xpath('RecordSource')};
	string60 ElementType {xpath('ElementType')};
	string100 ElementValue {xpath('ElementValue')};
	t_FraudGovSearchElementInformation ElementInformation {xpath('ElementInformation')};
	integer Score {xpath('Score')};
	integer NoOfIdentities {xpath('NoOfIdentities')};
	iesp.fraudgovplatform.t_FraudGovBestInfo GovernmentBest {xpath('GovernmentBest')};
	iesp.fraudgovplatform.t_FraudGovBestInfo ContributedBest {xpath('ContributedBest')};
	string50 EmailAddress {xpath('EmailAddress')};
	integer NoOfClusters {xpath('NoOfClusters')};
	integer NoOfRecentTransactions {xpath('NoOfRecentTransactions')};
	integer NoOfTransactions {xpath('NoOfTransactions')};
	integer NoOfKnownRisks {xpath('NoOfKnownRisks')};
	iesp.share.t_Date LastActivityDate {xpath('LastActivityDate')};
	iesp.share.t_Date LastKnownRiskDate {xpath('LastKnownRiskDate')};
	string100 ClusterName {xpath('ClusterName')};
	dataset(iesp.share.t_NameValuePair) NVPs {xpath('NVPs/NVP'), MAXCOUNT(iesp.Constants.FraudGov.MAX_COUNT_NVP)};
end;
		
export t_FraudGovSearchResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	t_FraudGovSearchBy InputEcho {xpath('InputEcho')};
	unsigned2 RecordCount {xpath('RecordCount')};
	dataset(t_FraudGovSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.Constants.FraudGov.MAX_COUNT_SEARCH_RECORDS)};
end;
		
export t_FraudGovSearchRequest := record (iesp.fraudgovplatform.t_FraudGovBaseRequest)
	t_FraudGovSearchBy SearchBy {xpath('SearchBy')};
	t_FraudGovSearchOption Options {xpath('Options')};
end;
		
export t_FraudGovSearchResponseEx := record
	t_FraudGovSearchResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from fraudgovsearch.xml. ***/
/*===================================================*/

