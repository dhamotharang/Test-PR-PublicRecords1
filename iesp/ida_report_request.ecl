﻿/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from ida_report_request.xml. ***/
/*===================================================*/

import iesp;

export ida_report_request := MODULE
			
export t_IDAOrigination := record
	string RequestType {xpath('RequestType')};
	string ApplicationDate {xpath('ApplicationDate')};
	string AppID {xpath('AppID')};
	string Designation {xpath('Designation')};
	string AcctLinkKey {xpath('AcctLinkKey')};
	string EventType {xpath('EventType')};
	string EventTypes {xpath('EventTypes')};
	string IndustryType {xpath('IndustryType')};
	string ChangeRequestSource {xpath('ChangeRequestSource')};
	string PrescreenDate {xpath('PrescreenDate')};
	string ProgramDate {xpath('ProgramDate')};
	string PromoCode {xpath('PromoCode')};
	string PassThru1 {xpath('PassThru1')};
	string PassThru2 {xpath('PassThru2')};
	string PassThru3 {xpath('PassThru3')};
	string PassThru4 {xpath('PassThru4')};
end;
		
export t_IDAAddress := record
	string Line1 {xpath('Line1')};
	string Line2 {xpath('Line2')};
end;
		
export t_IDAParsedAddress := record
	string StreetDir {xpath('StreetDir')};
	string Street {xpath('Street')};
	string StreetNumber {xpath('StreetNumber')};
	string StreetType {xpath('StreetType')};
	string AptNumber {xpath('AptNumber')};
	string POBox {xpath('POBox')};
	string RuralRoute {xpath('RuralRoute')};
end;
		
export t_IDAEmployment := record
	string EmployerType {xpath('EmployerType')};
	string EmploymentType {xpath('EmploymentType')};
	string Name {xpath('Name')};
	t_IDAAddress Address {xpath('Address')};
	t_IDAParsedAddress ParsedAddress {xpath('ParsedAddress')};
	string City {xpath('City')};
	string State {xpath('State')};
	string Zip {xpath('Zip')};
	string Country {xpath('Country')};
	string TimeAtEmployer {xpath('TimeAtEmployer')};
	string StartDate {xpath('StartDate')};
	string Title {xpath('Title')};
	string Salary {xpath('Salary')};
	string SalaryPeriodicity {xpath('SalaryPeriodicity')};
	string PrevEmployerType {xpath('PrevEmployerType')};
	string PrevEmploymentType {xpath('PrevEmploymentType')};
	string PrevName {xpath('PrevName')};
	t_IDAAddress PrevAddress {xpath('PrevAddress')};
	t_IDAParsedAddress ParsedPrevAddress {xpath('ParsedPrevAddress')};
	string PrevCity {xpath('PrevCity')};
	string PrevState {xpath('PrevState')};
	string PrevZip {xpath('PrevZip')};
	string PrevCountry {xpath('PrevCountry')};
	string PrevPhone {xpath('PrevPhone')};
	string PrevTimeAtEmployer {xpath('PrevTimeAtEmployer')};
	string PrevStartDate {xpath('PrevStartDate')};
	string PrevTitle {xpath('PrevTitle')};
	string PrevSalary {xpath('PrevSalary')};
	string PrevSalaryPeriodicity {xpath('PrevSalaryPeriodicity')};
end;
		
export t_IDAIdentity := record
	string SSN {xpath('SSN')};
	string SSNLast4 {xpath('SSNLast4')};
	string SSNFirst8 {xpath('SSNFirst8')};
	string SSNLast8 {xpath('SSNLast8')};
	string Title {xpath('Title')};
	string FirstName {xpath('FirstName')};
	string MiddleName {xpath('MiddleName')};
	string LastName {xpath('LastName')};
	string Suffix {xpath('Suffix')};
	string DOB {xpath('DOB')};
	string Gender {xpath('Gender')};
	string PlaceOfBirth {xpath('PlaceOfBirth')};
	string MothersMaiden {xpath('MothersMaiden')};
	string Company {xpath('Company')};
	t_IDAAddress Address {xpath('Address')};
	t_IDAParsedAddress ParsedAddress {xpath('ParsedAddress')};
	string City {xpath('City')};
	string State {xpath('State')};
	string Zip {xpath('Zip')};
	string Country {xpath('Country')};
	string AddressSince {xpath('AddressSince')};
	string Occupancy {xpath('Occupancy')};
	t_IDAAddress PhysicalAddress {xpath('PhysicalAddress')};
	t_IDAParsedAddress ParsedPhysicalAddress {xpath('ParsedPhysicalAddress')};
	string PhysicalCity {xpath('PhysicalCity')};
	string PhysicalState {xpath('PhysicalState')};
	string PhysicalZip {xpath('PhysicalZip')};
	string PhysicalCountry {xpath('PhysicalCountry')};
	string PrevSSN {xpath('PrevSSN')};
	string PrevTitle {xpath('PrevTitle')};
	string PrevFirstName {xpath('PrevFirstName')};
	string PrevMiddleName {xpath('PrevMiddleName')};
	string PrevLastName {xpath('PrevLastName')};
	string PrevSuffix {xpath('PrevSuffix')};
	string PrevDOB {xpath('PrevDOB')};
	t_IDAAddress PrevAddress {xpath('PrevAddress')};
	t_IDAParsedAddress ParsedPrevAddress {xpath('ParsedPrevAddress')};
	string PrevCity {xpath('PrevCity')};
	string PrevState {xpath('PrevState')};
	string PrevZip {xpath('PrevZip')};
	string PrevCountry {xpath('PrevCountry')};
	string PrevAddressSince {xpath('PrevAddressSince')};
	string PrevOccupancy {xpath('PrevOccupancy')};
	string HomePhone {xpath('HomePhone')};
	string HomePhone2 {xpath('HomePhone2')};
	string MobilePhone {xpath('MobilePhone')};
	string WorkPhone {xpath('WorkPhone')};
	string PrevHomePhone {xpath('PrevHomePhone')};
	string PrevHomePhone2 {xpath('PrevHomePhone2')};
	string PrevMobilePhone {xpath('PrevMobilePhone')};
	string PrevWorkPhone {xpath('PrevWorkPhone')};
	string Email {xpath('Email')};
	string PrevEmail {xpath('PrevEmail')};
	string IDType {xpath('IDType')};
	string IDOrigin {xpath('IDOrigin')};
	string IDNumber {xpath('IDNumber')};
	t_IDAEmployment Employment {xpath('Employment')};
end;
		
export t_IDAApplication := record
	string Channel {xpath('Channel')};
	string AcquisitionMethod {xpath('AcquisitionMethod')};
	string AgentLoc {xpath('AgentLoc')};
	string AgentID {xpath('AgentID')};
	string SourceIP {xpath('SourceIP')};
	string DeviceID {xpath('DeviceID')};
	string EncodedDeviceInfo {xpath('EncodedDeviceInfo')};
	string DeviceIDSource {xpath('DeviceIDSource')};
	string PrimaryDecisionCode {xpath('PrimaryDecisionCode')};
	string SecondaryDecisionCode {xpath('SecondaryDecisionCode')};
	string PrimaryPortfolio {xpath('PrimaryPortfolio')};
	string SecondaryPortfolio {xpath('SecondaryPortfolio')};
	string ConfirmedFraud {xpath('ConfirmedFraud')};
	string PrimaryFraudCode {xpath('PrimaryFraudCode')};
	string SecondaryFraudCode {xpath('SecondaryFraudCode')};
	string CARetailFlag {xpath('CARetailFlag')};
	string LexID {xpath('LexID')};
	string LNTransactionID {xpath('LNTransactionID')};
	string PrimaryIncome {xpath('PrimaryIncome')};
	string OtherIncome {xpath('OtherIncome')};
	string InferredIncome {xpath('InferredIncome')};
	string RecommendedCreditLine {xpath('RecommendedCreditLine')};
end;
		
export t_IDAReportOptions := record (iesp.share.t_BaseOption)
	boolean UseUATService {xpath('UseUATService')};
end;
		
export t_IDAReportParams := record
	string Client {xpath('Client')};
	string Affiliate {xpath('Affiliate')};
	string Solution {xpath('Solution')};
	string ProductName {xpath('ProductName')};
	string ProductID {xpath('ProductID')};
	t_IDAOrigination Origination {xpath('Origination')};
	t_IDAIdentity Identity {xpath('Identity')};
	t_IDAApplication Application {xpath('Application')};
end;
		
export t_IDAReportRequest := record (iesp.share.t_BaseRequest)
	iesp.share.t_GatewayParams GatewayParams {xpath('GatewayParams')};
	t_IDAReportOptions Options {xpath('Options')};
	t_IDAReportParams ReportBy {xpath('ReportBy')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from ida_report_request.xml. ***/
/*===================================================*/

