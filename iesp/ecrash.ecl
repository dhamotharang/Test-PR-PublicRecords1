/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from ecrash.xml. ***/
/*===================================================*/

import iesp;

export ecrash := MODULE
			
export t_ECrashSearchOption := record (iesp.share.t_BaseOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean GroupRecords {xpath('GroupRecords')};//hidden[ecldev]
	string SortField {xpath('SortField')};
	string SortOrder {xpath('SortOrder')}; //values['ASC','DESC','']
	boolean StrictMatch {xpath('StrictMatch')};//hidden[internal]
	integer MaxResults {xpath('MaxResults')};//hidden[internal]
	boolean SubscriptionReports {xpath('SubscriptionReports')};
end;
		
export t_ECrashAccidentLocation := record
	string Street {xpath('Street')};
	string CrossStreet {xpath('CrossStreet')};
end;
		
export t_ECrashSearchVehicle := record
	string LicensePlate {xpath('LicensePlate')};
	string Vin {xpath('Vin')};
	string VehicleUnitNumber {xpath('VehicleUnitNumber')};
	string PlateState {xpath('PlateState')};
end;
		
export t_ECrashInvolvedParty := record
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Date DOB {xpath('DOB')};
	string25 DriverLicenseNumber {xpath('DriverLicenseNumber')};
	iesp.share.t_Address Address {xpath('Address')};
	t_ECrashSearchVehicle Vehicle {xpath('Vehicle')};
end;
		
export t_ECrashSearchAgency := record
	string JurisdictionState {xpath('JurisdictionState')};
	string Jurisdiction {xpath('Jurisdiction')};
	string AgencyId {xpath('AgencyId')};
	string AgencyORI {xpath('AgencyORI')};
	boolean PrimaryAgency {xpath('PrimaryAgency')};
end;
		
export t_ECrashSearchShared := record
	string ReportNumber {xpath('ReportNumber')};
	iesp.share.t_Date DateOfLoss {xpath('DateOfLoss')};
	iesp.share.t_Date StartDate {xpath('StartDate')};
	iesp.share.t_Date EndDate {xpath('EndDate')};
	t_ECrashAccidentLocation AccidentLocation {xpath('AccidentLocation')};
	string ReportLinkID {xpath('ReportLinkID')};
	string VendorCode {xpath('VendorCode')};
end;
		
export t_ECrashSearchBy := record (t_ECrashSearchShared)
	boolean RequestHashKey {xpath('RequestHashKey')};
	string30 UserType {xpath('UserType')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	string JurisdictionState {xpath('JurisdictionState')};
	string Jurisdiction {xpath('Jurisdiction')};
	string AgencyId {xpath('AgencyId')};
	string AgencyORI {xpath('AgencyORI')};
	dataset(t_ECrashSearchAgency) Agencies {xpath('Agencies/Agency'), MAXCOUNT(1)};
	string DriversLicense {xpath('DriversLicense')};
	string OfficerBadgeNumber {xpath('OfficerBadgeNumber')};
	string Vin {xpath('Vin')};
	string LicensePlate {xpath('LicensePlate')};
end;
		
export t_ECrashDocument := record
	string DocType {xpath('DocType')};
	string Id {xpath('Id')};
	string Extension {xpath('Extension')};
	integer Pages {xpath('Pages')};
end;
		
export t_ECrashSearchRecordData := record (t_ECrashSearchShared)
	string15 ResultType {xpath('ResultType')};
	string ReportHashKey {xpath('ReportHashKey')};
	boolean HasCoverSheet {xpath('HasCoverSheet')};
	boolean IsReadyForPublic {xpath('IsReadyForPublic')};
	string StateReportNumber {xpath('StateReportNumber')};
	dataset(t_ECrashInvolvedParty) InvolvedParties {xpath('InvolvedParties/Party'), MAXCOUNT(iesp.Constants.eCrashMod.Max_Involved_Parties)};
	string SuperReportID {xpath('SuperReportID')};
	string VendorReportId {xpath('VendorReportId')};
	string ReportType {xpath('ReportType')};
	dataset(t_ECrashDocument) Documents {xpath('Documents/Document'), MAXCOUNT(iesp.Constants.eCrashMod.Max_Documents)};
	integer Pages {xpath('Pages')};
	string JurisdictionState {xpath('JurisdictionState')};
	string Jurisdiction {xpath('Jurisdiction')};
	string AgencyId {xpath('AgencyId')};
	string AgencyORI {xpath('AgencyORI')};
	string ContribSource {xpath('ContribSource')};
	string DateReportCreated {xpath('DateReportCreated')};
	string OfficerBadgeNumber {xpath('OfficerBadgeNumber')};
	iesp.share.t_Date DateReportSubmitted {xpath('DateReportSubmitted')};
end;
		
export t_ECrashSearchRecord := record
	string LastName {xpath('LastName')};//hidden[ecldev]
	string ReportCode {xpath('ReportCode')};//hidden[ecldev]
	integer Pages {xpath('Pages')};//hidden[ecldev]
	dataset(t_ECrashSearchRecordData) Reports {xpath('Reports/Report'), MAXCOUNT(iesp.Constants.eCrashMod.MaxRecords)};
	string ReportLinkID {xpath('ReportLinkID')};
	string VendorCode {xpath('VendorCode')};
	string JurisdictionState {xpath('JurisdictionState')};
	string Jurisdiction {xpath('Jurisdiction')};
	string AgencyId {xpath('AgencyId')};
	string AgencyORI {xpath('AgencyORI')};
	string ReportNumber {xpath('ReportNumber')};
	iesp.share.t_Date DateOfLoss {xpath('DateOfLoss')};
	iesp.share.t_Date StartDate {xpath('StartDate')};
	iesp.share.t_Date EndDate {xpath('EndDate')};
	t_ECrashAccidentLocation AccidentLocation {xpath('AccidentLocation')};
	string15 ResultType {xpath('ResultType')};
	string ReportHashKey {xpath('ReportHashKey')};
	boolean HasCoverSheet {xpath('HasCoverSheet')};
	boolean IsReadyForPublic {xpath('IsReadyForPublic')};
	string StateReportNumber {xpath('StateReportNumber')};
	dataset(t_ECrashInvolvedParty) InvolvedParties {xpath('InvolvedParties/Party'), MAXCOUNT(iesp.Constants.eCrashMod.Max_Involved_Parties)};
	string SuperReportID {xpath('SuperReportID')};
	string VendorReportId {xpath('VendorReportId')};
	string ReportType {xpath('ReportType')};
	string ContribSource {xpath('ContribSource')};
	string DateReportCreated {xpath('DateReportCreated')};
	string OfficerBadgeNumber {xpath('OfficerBadgeNumber')};
	iesp.share.t_Date DateReportSubmitted {xpath('DateReportSubmitted')};
end;
		
export t_ECrashSearchResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_ECrashSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.Constants.eCrashMod.MaxRecords)};
end;
		
export t_ECrashSearchRequest := record (iesp.share.t_BaseRequest)
	t_ECrashSearchOption Options {xpath('Options')};
	t_ECrashSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_ECrashSearchResponseEx := record
	t_ECrashSearchResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from ecrash.xml. ***/
/*===================================================*/

