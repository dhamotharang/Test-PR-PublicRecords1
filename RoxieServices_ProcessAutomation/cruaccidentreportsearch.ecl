import iesp;

export cruaccidentreportsearch := MODULE
			
export t_StringElementWithMatchTypeAttribute := record
	string MatchType {xpath('@MatchType')};
	string Content_ {xpath('')};
end;
export t_Date := record
	integer2 Year {xpath('Year')};
	integer2 Month {xpath('Month')};
	integer2 Day {xpath('Day')};
end;			
export t_DateElementWithMatchTypeAttribute := record (t_Date)
	string MatchType {xpath('@MatchType')};
end;
		
export t_CRUAccidentVehicleRequest := record
	string VIN {xpath('VIN')};
	string Tag {xpath('Tag')};
	string TagState {xpath('TagState')};
	string MakeYear {xpath('MakeYear')};
	string MakeModel {xpath('MakeModel')};
	string Make {xpath('Make')};
end;
		
export t_CRUAccidentVehicleResponse := record
	// t_StringElementWithMatchTypeAttribute VIN {xpath('VIN')};
	string Tag {xpath('Tag')};
	string TagState {xpath('TagState')};
	// t_StringElementWithMatchTypeAttribute MakeYear {xpath('MakeYear')};
	// t_StringElementWithMatchTypeAttribute MakeModel {xpath('MakeModel')};
	string Make {xpath('Make')};
	string VehicleUnitNumber {xpath('VehicleUnitNumber')};
	// t_StringElementWithMatchTypeAttribute VinStatus {xpath('VinStatus')};
	// t_StringElementWithMatchTypeAttribute CarrierName {xpath('CarrierName')};
	// t_StringElementWithMatchTypeAttribute ImpactLocation {xpath('ImpactLocation')};
	// t_StringElementWithMatchTypeAttribute Color {xpath('Color')};
	// t_StringElementWithMatchTypeAttribute Towed {xpath('Towed')};
	// t_StringElementWithMatchTypeAttribute AirbagDeployed {xpath('AirbagDeployed')};
	// string InsurancePolicyNumber {xpath('InsurancePolicyNumber')};
	// string InsuranceExpirationDate {xpath('InsuranceExpirationDate')};
end;
		
export t_CRUAccidentReportPolicy := record
	string PolicyNumber {xpath('PolicyNumber')};
	string PolicyState {xpath('PolicyState')};
	string PolicyExpirationDate {xpath('PolicyExpirationDate')};
end;
		
export t_CRUAccidentReportDriversLicenseRequest := record
	string DriversLicenseNumber {xpath('DriversLicenseNumber')};
	string DriversLicenseState {xpath('DriversLicenseState')};
end;

export t_Name := record
	string62 Full {xpath('Full')};
	string20 First {xpath('First')};
	string20 Middle {xpath('Middle')};
	string20 Last {xpath('Last')};
	string5 Suffix {xpath('Suffix')};
	string3 Prefix {xpath('Prefix')};
end;	
export t_CRUAccidentReportSubjectRequest := record
	string SubjectType {xpath('SubjectType')};
	t_Name Name {xpath('Name')};
	t_Date DOB {xpath('DOB')};
	string SSN {xpath('SSN')};
	t_CRUAccidentReportDriversLicenseRequest DriversLicense {xpath('DriversLicense')};
end;
		
export t_CRUAccidentReportBy := record
	integer CruInqOrderid {xpath('CruInqOrderid')};
	integer CruInqSeqNumber {xpath('CruInqSeqNumber')};
	string CruInqClaimNumber {xpath('CruInqClaimNumber')};
	string CruInqAdjusterId {xpath('CruInqAdjusterId')};
	t_Date CruInqLossDate {xpath('CruInqLossDate')};
	string CruInqLossTime {xpath('CruInqLossTime')};
	string CruInqLossStreet {xpath('CruInqLossStreet')};
	string CruInqLossCrossStreet {xpath('CruInqLossCrossStreet')};
	string CruInqLossCity {xpath('CruInqLossCity')};
	string CruInqLossState {xpath('CruInqLossState')};
	string CruInqLossZip4 {xpath('CruInqLossZip4')};
	string CruInqLossZip5 {xpath('CruInqLossZip5')};
	string CruInqLossCounty {xpath('CruInqLossCounty')};
	dataset(t_CRUAccidentReportSubjectRequest) Subjects {xpath('Subjects/Subject'), MAXCOUNT(3)};
	t_CRUAccidentVehicleRequest Vehicle {xpath('Vehicle')};
	string CruInqAgencyName {xpath('CruInqAgencyName')};
	string CruInqReportNumber {xpath('CruInqReportNumber')};
	t_CRUAccidentReportPolicy CruInqPolicy {xpath('CruInqPolicy')};
	string CruInqPrecinct {xpath('CruInqPrecinct')};
	string CruInqAdditionallnfo {xpath('CruInqAdditionallnfo')};
	string CruInqCarrierName {xpath('CruInqCarrierName')};
	string CruInqCarrierTypeId {xpath('CruInqCarrierTypeId')};
	string ServiceId {xpath('ServiceId')}; //values['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','']
	integer StateNumber {xpath('StateNumber')};
	string AgencyId {xpath('AgencyId')};
	string IncidentId {xpath('IncidentId')};
end;
		
export t_CRUAccidentReportSearchRequestOptions := record 
// (iesp.share.t_BaseOption)
	boolean SearchForReportsOnly {xpath('SearchForReportsOnly')};
end;
		
export t_CRUAccidentReportResponseHeader := record
	integer SearchOrderId {xpath('SearchOrderId')};
	integer SearchSeqNumber {xpath('SearchSeqNumber')};
	integer ReportExactMatchCount {xpath('ReportExactMatchCount')};
	integer ReportPotentialMatchCount {xpath('ReportPotentialMatchCount')};
	integer OrdersMatchCount {xpath('OrdersMatchCount')};
	// string CruSystemAccountNumber {xpath('CruSystemAccountNumber')};
	// string TransactionId {xpath('TransactionId')};
	string SearchStatus {xpath('SearchStatus')}; //values['RecordFound','NoRecordFound','']
end;
		
export t_CRUAccidentDriversLicenseResponse := record
	t_StringElementWithMatchTypeAttribute DriversLicenseNumber {xpath('DriversLicenseNumber')};
	t_StringElementWithMatchTypeAttribute DriversLicenseState {xpath('DriversLicenseState')};
end;
		
export t_CRUAccidentReportSubjectResponse := record
	string SubjectType {xpath('SubjectType')};
	string LastName {xpath('LastName')};
	string FirstName {xpath('FirstName')};
	string MiddleName {xpath('MiddleName')};
	// t_DateElementWithMatchTypeAttribute DOB {xpath('DOB')};
	// t_StringElementWithMatchTypeAttribute SSN {xpath('SSN')};
	// t_CRUAccidentDriversLicenseResponse DriversLicense {xpath('DriversLicense')};
	string VehicleUnitNumber {xpath('VehicleUnitNumber')};
	// string Address {xpath('Address')};
	// string Address2 {xpath('Address2')};
	// string State {xpath('State')};
	// string Zip4 {xpath('Zip4')};
	// string Zip5 {xpath('Zip5')};
	// string HomePhone {xpath('HomePhone')};
	// string NameSuffix {xpath('NameSuffix')};
	// string City {xpath('City')};
end;
		
export t_CRUAccidentReportMatchedReports := record
	string MatchedStatus {xpath('MatchedStatus')}; //values['NOMT','CLMT','MATC','BADM','']
	integer MatchedWeightScore {xpath('MatchedWeightScore')};
	integer MatchedOrderId {xpath('MatchedOrderId')};
	integer matchedSequenceNbr {xpath('matchedSequenceNbr')};
	string DataSourceId {xpath('DataSourceId')}; //values['TM','TF','EA','']
	string WorkTypeId {xpath('WorkTypeId')}; //values['0','1','2','3','']
	string ServiceId {xpath('ServiceId')}; //values['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','']
	string IncidentId {xpath('IncidentId')};
	t_Date CreationDate {xpath('CreationDate')};
	// string OriNumber {xpath('OriNumber')};
	string VendorCode {xpath('VendorCode')};
	// string VendorReportNumber {xpath('VendorReportNumber')};
	t_StringElementWithMatchTypeAttribute StateReportNumber {xpath('StateReportNumber')};
	// t_StringElementWithMatchTypeAttribute StateAbbr {xpath('StateAbbr')};
	string StateAbbr {xpath('StateAbbr')};
	string ReportHashKey {xpath('ReportHashKey')};
	t_DateElementWithMatchTypeAttribute LossDate {xpath('LossDate')};
	// string LossTime {xpath('LossTime')};
	string LossCity {xpath('LossCity')};//kvm
	string LossCounty {xpath('LossCounty')}; //kvm
	// t_StringElementWithMatchTypeAttribute LossStreet {xpath('LossStreet')};
	// t_StringElementWithMatchTypeAttribute LossCrossStreet {xpath('LossCrossStreet')};
	// string Precinct {xpath('Precinct')};
	dataset(t_CRUAccidentReportSubjectResponse) PartyTypes {xpath('PartyTypes/PartyType'), MAXCOUNT(100)};
	dataset(t_CRUAccidentVehicleResponse) VehicleInfos {xpath('VehicleInfos/VehicleInfo'), MAXCOUNT(100)};
	integer StateNumber {xpath('StateNumber')};
	string AgencyId {xpath('AgencyId')};
	integer EcrashAgencyMBSId {xpath('EcrashAgencyMBSId')};
	// string ECrashAgencyName {xpath('ECrashAgencyName')};
	string AgencyName {xpath('AgencyName')};
	// t_StringElementWithMatchTypeAttribute Zip4 {xpath('Zip4')};
	// t_StringElementWithMatchTypeAttribute Zip5 {xpath('Zip5')};
	string LocalReportNumber {xpath('LocalReportNumber')};
	integer IsAvailableForPublic {xpath('IsAvailableForPublic')};
	string ReportID {xpath('ReportID')};
	// string FatalityInvolved {xpath('FatalityInvolved')};
	// string Latitude {xpath('Latitude')};
	// string Longitude {xpath('Longitude')};
	// string ContribSource {xpath('ContribSource')};
	// string DateReportSubmitted {xpath('DateReportSubmitted')};
end;
		
export t_CRUMatchedFields := record
	t_DateElementWithMatchTypeAttribute LossDate {xpath('LossDate')};
	t_StringElementWithMatchTypeAttribute LossStreet {xpath('LossStreet')};
	t_StringElementWithMatchTypeAttribute LossCrossStreet {xpath('LossCrossStreet')};
	t_StringElementWithMatchTypeAttribute LossCity {xpath('LossCity')};
	t_StringElementWithMatchTypeAttribute StateAbbr {xpath('StateAbbr')};
	t_StringElementWithMatchTypeAttribute Zip4 {xpath('Zip4')};
	t_StringElementWithMatchTypeAttribute Zip5 {xpath('Zip5')};
	t_StringElementWithMatchTypeAttribute LossCounty {xpath('LossCounty')};
	t_StringElementWithMatchTypeAttribute LastName {xpath('LastName')};
	t_StringElementWithMatchTypeAttribute LastName_2 {xpath('LastName_2')};
	t_StringElementWithMatchTypeAttribute LastName_3 {xpath('LastName_3')};
	t_StringElementWithMatchTypeAttribute FirstName {xpath('FirstName')};
	t_StringElementWithMatchTypeAttribute FirstName_2 {xpath('FirstName_2')};
	t_StringElementWithMatchTypeAttribute FirstName_3 {xpath('FirstName_3')};
	t_DateElementWithMatchTypeAttribute DOB {xpath('DOB')};
	t_StringElementWithMatchTypeAttribute SSN {xpath('SSN')};
	t_CRUAccidentDriversLicenseResponse DriversLicense {xpath('DriversLicense')};
	t_CRUAccidentVehicleResponse Vehicle {xpath('Vehicle')};
	t_StringElementWithMatchTypeAttribute AgencyName {xpath('AgencyName')};
	t_StringElementWithMatchTypeAttribute ReportNumber {xpath('ReportNumber')};
	t_StringElementWithMatchTypeAttribute ServiceId {xpath('ServiceId')};
end;
		
export t_CRUMatchedOrders := record
	integer MatchedOrderScore {xpath('MatchedOrderScore')};
	integer MatchedOrderId {xpath('MatchedOrderId')};
	integer MatchedSequenceNbr {xpath('MatchedSequenceNbr')};
	string DataSourceId {xpath('DataSourceId')}; //values['IA','']
	t_CRUMatchedFields MatchedFields {xpath('MatchedFields')};
end;
		
export t_CRUAccidentReportSearchResponse := record
	t_CRUAccidentReportResponseHeader ResponseHeader {xpath('ResponseHeader')};
	dataset(t_CRUAccidentReportMatchedReports) MatchedReports {xpath('MatchedReports/MatchedReport'), MAXCOUNT(10)};
	// dataset(t_CRUMatchedOrders) MatchedOrders {xpath('MatchedOrders/MatchedOrder'), MAXCOUNT(10)};
	integer RecordCount {xpath('RecordCount')};
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

		
export t_CRUAccidentReportSearchRequest := record 
// (iesp.share.t_BaseRequest)
  t_User User {xpath('User')};
	t_CRUAccidentReportSearchRequestOptions Options {xpath('Options')};
	t_CRUAccidentReportBy SearchBy {xpath('SearchBy')};
end;

export t_BaseRequest := record
	t_CRUAccidentReportSearchRequest CRUAccidentReportSearchRequest {xpath('CRUAccidentReportSearchRequest')};
end;

export t_Report:=record
	t_CRUAccidentReportSearchRequest CRUAccidentReportSearchRequest {xpath('CRUAccidentReportSearchRequest')};
end;

export t_BaseRequest_2 := record
	t_Report Report {xpath('Report')};
end;
		
export t_CRUAccidentReportSearchResponseEx := record
	t_CRUAccidentReportSearchResponse response {xpath('response')};
end;
		
end;