/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from business_registrations.xml. ***/
/*===================================================*/

export business_registrations := MODULE
			
export t_BusinessRegistrationOfficer := record
	share.t_Name Name {xpath('Name')};
	string10 Position {xpath('Position')};
	string10 Phone {xpath('Phone')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_BusinessRegistrationRegisteredAgent := record
	string40 Name {xpath('Name')};
	string10 Phone {xpath('Phone')};
	share.t_Date Date {xpath('Date')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_BusinessRegistrationRecord := record
	share.t_BusinessIdentity BusinessIds {xpath('BusinessIds')};
	string100 IdValue {xpath('IdValue')};
	string BusinessId {xpath('BusinessId')};
	string25 FilingNumber {xpath('FilingNumber')};
	string75 CompanyName {xpath('CompanyName')};
	string75 Description {xpath('Description')};
	string4 SicCode {xpath('SicCode')};
	string120 SicDesc {xpath('SicDesc')};
	string6 NaicsCode {xpath('NaicsCode')};
	string120 NaicsDesc {xpath('NaicsDesc')};
	integer NumberOfEmployees {xpath('NumberOfEmployees')};
	integer NumberOfOwners {xpath('NumberOfOwners')};
	string4 CorporationCode {xpath('CorporationCode')};
	string120 CorporationDesc {xpath('CorporationDesc')};
	string8 SecretaryOfStateCode {xpath('SecretaryOfStateCode')};
	string120 SecretaryOfStateDesc {xpath('SecretaryOfStateDesc')};
	string4 FilingCode {xpath('FilingCode')};
	string120 FilingDesc {xpath('FilingDesc')};
	string75 Status {xpath('Status')};
	string20 LicenseNumber {xpath('LicenseNumber')};
	string20 Duration {xpath('Duration')};
	string40 Email {xpath('Email')};
	string21 Fips {xpath('Fips')};
	string10 Phone {xpath('Phone')};
	share.t_Date StartDate {xpath('StartDate')};
	share.t_Date FilingDate {xpath('FilingDate')};
	share.t_Date ExpirationDate {xpath('ExpirationDate')};
	share.t_Date DisolvedDate {xpath('DisolvedDate')};
	share.t_Date ReportDate {xpath('ReportDate')};
	share.t_Date RenewalDate {xpath('RenewalDate')};
	share.t_Date ChangeDate {xpath('ChangeDate')};
	share.t_Date AppointedDate {xpath('AppointedDate')};
	share.t_Date FiscalDate {xpath('FiscalDate')};
	share.t_Date ProcessDate {xpath('ProcessDate')};
	t_BusinessRegistrationRegisteredAgent RegisteredAgent {xpath('RegisteredAgent')};
	share.t_Address Address {xpath('Address')};
	share.t_Address MailingAddress {xpath('MailingAddress')};
	dataset(t_BusinessRegistrationOfficer) BusinessRegistrationOfficers {xpath('BusinessRegistrationOfficers/BusinessRegistrationOfficer'), MAXCOUNT(iesp.Constants.BUSREG.MAX_OFFICERS)};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from business_registrations.xml. ***/
/*===================================================*/

