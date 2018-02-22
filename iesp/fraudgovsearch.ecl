IMPORT iesp;

EXPORT fraudgovsearch := MODULE
		EXPORT t_FraudGovSearchBy := RECORD
				//Identity Search Fields.
				iesp.share.t_Name Name {xpath('Name')};
				iesp.share.t_Address Address {xpath('Address')};
				iesp.share.t_Date DOB {xpath('DOB')};
				string11 SSN {xpath('SSN')};
				string15 Phone10 {xpath('Phone10')};
				string12 UniqueId {xpath('UniqueId')};
				string50 EmailAddress {xpath('EmailAddress')};
				string2 DriversLicenseState {xpath('DriversLicenseState')};
				string25 DriversLicenseNumber {xpath('DriversLicenseNumber')};
				//Programe Information Fields.
				string10 ProgramCode {xpath('ProgramCode')};
				string20 HouseholdID {xpath('HouseholdID')};
				string20 CustomerPersonId {xpath('CustomerPersonId')};
				iesp.share.t_Date TransactionStartDate {xpath('TransactionStartDate')};
				iesp.share.t_Date TransactionEndDate {xpath('TransactionEndDate')};
				string12 AmountMin {xpath('AmountMin')};
				string12 AmountMax {xpath('AmountMax')};
				string100 BankName {xpath('BankName')};
				string10 BankRoutingNumber {xpath('BankRoutingNumber')};
				string30 BankAccountNumber {xpath('BankAccountNumber')};
				//Device Fields.
				string25 ISPName {xpath('ISPName')};
				string25 IpAddress {xpath('IpAddress')};
				String25 MACAddress {xpath('MACAddress')};
				string50 DeviceID {xpath('DeviceID')};
				string20 DeviceSerialNumber {xpath('DeviceSerialNumber')};		
				//Other fields. -- Probably will not be needed for Web Advance Search, but will keep them for now. 
				unsigned6 AppendedProviderId {xpath('AppendedProviderId')};
				unsigned6 LNPID {xpath('LNPID')};
				string10 TIN {xpath('TIN')};
				string10 NPI {xpath('NPI')};
				string12 ProfessionalId {xpath('ProfessionalId')};
				iesp.share.t_GeoLocation GeoLocation {xpath('GeoLocation')};
				dataset(iesp.share.t_BusinessIdentity) BusinessLinkIds {xpath('BusinessLinkIds/BusinessLinkId'), MAXCOUNT(iesp.Constants.FraudGov.MAX_COUNT_BUSINESS_LINKIDS)};
				iesp.share.t_Address MailingAddress {xpath('MailingAddress')};
		END;

		EXPORT t_FraudGovSearchOption := RECORD
				boolean IsOnline {xpath('IsOnline')};//hidden[internal]
				string Platform {xpath('Platform')};
		END;
		
		EXPORT t_FraudGovSearchBestInformation := RECORD
				string12 UniqueId {xpath('UniqueId')};
				iesp.share.t_Name Name {xpath('Name')};
				string11 SSN {xpath('SSN')};				
				iesp.share.t_Date DOB {xpath('DOB')};
				iesp.share.t_Address Address {xpath('Address')};
				string15 Phone10 {xpath('Phone10')};
		END;
		
		EXPORT t_FraudGovSearchRecords := RECORD
				string10 RecordType {xpath('RecordType')}; 
				string60 ElementType {xpath('ElementType')}; // SSN, ADDRESS, PHONE ETC... 
				string100 ElementValue {xpath('ElementValue')};
				integer Score {xpath('Score')};
				integer NoOfIdentities {xpath('NoOfIdentities')}; //RecordType = Identity OR RecordType = Cluster
				t_FraudGovSearchBestInformation BestInformation {xpath('BestInformation')}; //RecordType = Identity 
				string50 EmailAddress {xpath('EmailAddress')}; //RecordType = Identity 
				integer NoOfClusters {xpath('NoOfClusters')}; //RecordType = Element
				integer NoOfRecentTransactions {xpath('NoOfRecentActivities')}; //RecordType = Element
				integer NoOfTransactions {xpath('NoOfIdentitiyTransactions')}; //RecordType = Element
				integer NoOfKnownRisks {xpath('NoOfKnownRisks')}; //RecordType = Element
				iesp.share.t_Date LastActivityDate {xpath('LastActivityDate')}; //RecordType = Element
				iesp.share.t_Date LastKnownRiskDate {xpath('LastKnownRiskDate')}; //RecordType = Element
				string12 DollarAmount {xpath('DollarAmount')}; //RecordType = Cluster
				string100 ClusterName {xpath('ClusterName')}; //RecordType = Cluster
				string50 ClusterNumber {xpath('ClusterNumber')}; //RecordType = Cluster
				integer RateofGrowth {xpath('RateofGrowth')}; //RecordType = Cluster
		END;

		EXPORT t_FraudGovSearchResponse := RECORD
				iesp.share.t_ResponseHeader _Header {xpath('Header')};
				t_FraudGovSearchBy InputEcho {xpath('InputEcho')};
				DATASET(t_FraudGovSearchRecords) Records {xpath('Records/Record')};
		END;

		EXPORT t_FraudGovSearchRequest := RECORD (iesp.fraudgovplatform.t_FraudGovBaseRequest)
				t_FraudGovSearchBy SearchBy {xpath('SearchBy')};
				t_FraudGovSearchOption Options {xpath('Options')};
		END;

		EXPORT t_FraudGovSearchResponseEx := RECORD
				t_FraudGovSearchResponse response {xpath('response')};
		END;
END;