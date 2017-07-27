/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from AccountInformation.xml. ***/
/*===================================================*/

export AccountInformation := MODULE
			
export t_CommonInformation := record
	string14 ReferenceNumber {xpath('ReferenceNumber')};
	string16 TransactionId {xpath('TransactionId')};
	string1 OperationMode {xpath('OperationMode')};
	string9 CustomerNodeId {xpath('CustomerNodeId')};
	string20 ClientId {xpath('ClientId')};
	boolean UnrecognizedRecsFound {xpath('UnrecognizedRecsFound')};
	real8 ClientVersion {xpath('ClientVersion')};
end;
		
export t_LegacyAccount := record
	string6 Base {xpath('Base')};
	string3 Suffix {xpath('Suffix')};
end;
		
export t_AccountInformation := record
	string11 MBSId {xpath('MBSId')};
	string40 Name {xpath('Name')};
	string100 DisplayName {xpath('DisplayName')};
	string2 AccountType {xpath('AccountType')};
	string11 CompanyId {xpath('CompanyId')};
	string1 Status {xpath('Status')};
	string20 CustomerNumber {xpath('CustomerNumber')};
	string40 CustomerName {xpath('CustomerName')};
	string34 AddressLine1 {xpath('AddressLine1')};
	string34 AddressLine2 {xpath('AddressLine2')};
	string20 City {xpath('City')};
	string2 State {xpath('State')};
	string5 Zip {xpath('Zip')};
	string4 Zip4 {xpath('Zip4')};
	t_LegacyAccount Legacy {xpath('Legacy')};
end;
		
export t_CommonAccountInformation := record
	string11 MBSId {xpath('MBSId')};
	string40 Name {xpath('Name')};
	string100 DisplayName {xpath('DisplayName')};
	string2 AccountType {xpath('AccountType')};
	string11 CompanyId {xpath('CompanyId')};
	string1 Status {xpath('Status')};
	string34 AddressLine1 {xpath('AddressLine1')};
	string34 AddressLine2 {xpath('AddressLine2')};
	string20 City {xpath('City')};
	string2 State {xpath('State')};
	string5 Zip {xpath('Zip')};
	string4 Zip4 {xpath('Zip4')};
	t_LegacyAccount Legacy {xpath('Legacy')};
end;
		
export t_Gateway := record
	string40 ServiceName {xpath('ServiceName')};
	string150 URL {xpath('URL')};
end;
		
export t_DMFInformation := record
	string1 DMFFlag {xpath('DMFFlag')};
	string20 DMFList {xpath('DMFList')};
end;
		
export t_RiskModelsInformation := record
	boolean TestDataEnabled {xpath('TestDataEnabled')};
	string20 TestDataTableName {xpath('TestDataTableName')};
end;
		
export t_InsuranceContext := record
	t_CommonInformation Common {xpath('Common')};
	t_AccountInformation Account {xpath('Account')};
	t_RiskModelsInformation RiskModels {xpath('RiskModels')};
	dataset(t_Gateway) Gateways {xpath('Gateways/Gateway'), MAXCOUNT(15)};
end;
		
export t_BaseInsuranceContext := record
	t_CommonInformation Common {xpath('Common')};
	t_CommonAccountInformation Account {xpath('Account')};
	dataset(t_Gateway) Gateways {xpath('Gateways/Gateway'), MAXCOUNT(15)};
	t_DMFInformation DMFInfo {xpath('DMFInfo')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from AccountInformation.xml. ***/
/*===================================================*/

