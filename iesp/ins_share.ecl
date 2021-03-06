/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from ins_share.xml. ***/
/*===================================================*/

export ins_share := MODULE
			
export t_PrecisionDateTime := record (share.t_TimeStamp)
	integer2 MilliSeconds {xpath('MilliSeconds')};
end;
		
export t_SidexInfo := record
	string9 SourceNode {xpath('SourceNode')};
	string9 DestinationNode {xpath('DestinationNode')};
	string9 ReturnNode {xpath('ReturnNode')};
end;
		
export t_TransactionDetails := record
	string10 RuleplanId {xpath('RuleplanId')};
	string60 InternalTransactionId {xpath('InternalTransactionId')};//hidden[internal]
	integer MaxWaitSeconds {xpath('MaxWaitSeconds')};
	string1 InquiryVersion {xpath('InquiryVersion')};
	t_SidexInfo SidexInfo {xpath('SidexInfo')};
	string20 BatchOrderNumber {xpath('BatchOrderNumber')};//hidden[internal]
	string20 BatchOrderSequence {xpath('BatchOrderSequence')};//hidden[internal]
	t_PrecisionDateTime DateTimeOrdered {xpath('DateTimeOrdered')};
	t_PrecisionDateTime DateTimeReceived {xpath('DateTimeReceived')};
	t_PrecisionDateTime DateTimeCompleted {xpath('DateTimeCompleted')};
	dataset(share.t_NameValuePair) QuoteBacks {xpath('QuoteBacks/QuoteBack'), MAXCOUNT(99)};
end;
		
export t_TransactionDetailsEx := record (t_TransactionDetails)
	string ProcessingStatus {xpath('ProcessingStatus')};
	string ProcessingMessage {xpath('ProcessingMessage')};
	string16 TransactionId {xpath('TransactionId')};
	dataset(share.t_WsException) Exceptions {xpath('Exceptions/Item'), MAXCOUNT(4)};
end;
		
export t_InsuranceBaseOptions := record (share.t_BaseOption)
	string Id {xpath('Id')};
	string OrderId {xpath('OrderId')};//hidden[internal]
	string4 ReportCode {xpath('ReportCode')};
	string1 ReportType {xpath('ReportType')};
	string2 ReportUsage {xpath('ReportUsage')};
	string9 AccountNumber {xpath('AccountNumber')};
end;
		
export t_CustomerOrganization := record
	dataset(share.t_NameValuePair) InquiryIds {xpath('InquiryIds/InquiryId'), MAXCOUNT(16)};
end;
		
export t_ISSModel := record
	string Id {xpath('Id')};
end;
		
export t_RequesterInformation := record
	string2 Classification {xpath('Classification')};
	string120 Name {xpath('Name')};
	string20 AccountNumber {xpath('AccountNumber')};
	string20 BillingCode {xpath('BillingCode')};
	string1 ProductLine {xpath('ProductLine')};
	string8 DeliverySystem {xpath('DeliverySystem')};//hidden[internal]
	string50 ReferenceCode {xpath('ReferenceCode')};
	share.t_EndUserInfo EndUser {xpath('EndUser')};
	t_CustomerOrganization CustomerOrganization {xpath('CustomerOrganization')};
	dataset(t_ISSModel) ModelIds {xpath('ModelIds/ModelId'), MAXCOUNT(10)};
end;
		
export t_InsuranceBaseResult := record
	string Id {xpath('Id')};
	string OrderId {xpath('OrderId')};
	string14 ReferenceNumber {xpath('ReferenceNumber')};
end;
		
export t_InsuranceBaseResponse := record
	t_RequesterInformation RequesterInfo {xpath('RequesterInfo')};
	t_TransactionDetailsEx Transaction {xpath('Transaction')};
end;
		
export t_InsuranceAddress := record (share.t_Address)
	integer2 YearsAtAddress {xpath('YearsAtAddress')};
	integer2 MonthsAtAddress {xpath('MonthsAtAddress')};
	share.t_Date DateFirstAtAddress {xpath('DateFirstAtAddress')};
	share.t_Date DateLastAtAddress {xpath('DateLastAtAddress')};
end;
		
export t_QualifiedInsuranceAddress := record (t_InsuranceAddress)
	string2 Classification {xpath('Classification')};
end;
		
export t_AddressFieldStatusIndicator := record
	string HouseNumber {xpath('HouseNumber')};
	string StreetName {xpath('StreetName')};
	string ApartmentNumber {xpath('ApartmentNumber')};
	string City {xpath('City')};
	string State {xpath('State')};
	string Zip5 {xpath('Zip5')};
	string Zip4 {xpath('Zip4')};
	string YearsAtAddress {xpath('YearsAtAddress')};
	string MonthsAtAddress {xpath('MonthsAtAddress')};
	string DateFirstAtAddress {xpath('DateFirstAtAddress')};
	string DateLastAtAddress {xpath('DateLastAtAddress')};
end;
		
export t_ResultAddress := record (t_InsuranceAddress)
	string3 GroupSequenceNumber {xpath('GroupSequenceNumber')};
	t_AddressFieldStatusIndicator FieldStatusIndicator {xpath('FieldStatusIndicator')};
end;
		
export t_QualifiedResultAddress := record (t_ResultAddress)
	string2 Classification {xpath('Classification')};
end;
		
export t_InsuranceTelephone := record
	string Classification {xpath('Classification')};
	string AreaCode {xpath('AreaCode')};
	string Exchange {xpath('Exchange')};
	string Number {xpath('Number')};
	string Extension {xpath('Extension')};
end;
		
export t_TelephoneFieldStatusIndicator := record
	string AreaCode {xpath('AreaCode')};
	string Exchange {xpath('Exchange')};
	string Number {xpath('Number')};
	string Extension {xpath('Extension')};
end;
		
export t_ResultTelephone := record (t_InsuranceTelephone)
	string3 GroupSequenceNumber {xpath('GroupSequenceNumber')};
	t_TelephoneFieldStatusIndicator FieldStatusIndicator {xpath('FieldStatusIndicator')};
end;
		
export t_InsuranceMortgage := record
	string Number {xpath('Number')};
	string Classification {xpath('Classification')};
	string Company {xpath('Company')};
	dataset(share.t_StringArrayItem) Borrowers {xpath('Borrowers/Borrower'), MAXCOUNT(99)};
	string MortgageType {xpath('MortgageType')};
	string LoanAmount {xpath('LoanAmount')};
	string LoanType {xpath('LoanType')};
	string InterestRate {xpath('InterestRate')};
	string InterestRateType {xpath('InterestRateType')};
end;
		
export t_MortgageFieldStatusInd := record
	string MortgageLoadNumber {xpath('MortgageLoadNumber')};
	string MortgageCompanyName {xpath('MortgageCompanyName')};
end;
		
export t_ResultMortgage := record (t_InsuranceMortgage)
	string3 GroupSequenceNumber {xpath('GroupSequenceNumber')};
	t_MortgageFieldStatusInd FieldStatusInd {xpath('FieldStatusInd')};
end;
		
export t_InsuranceDriversLicense := record
	string2 Classification {xpath('Classification')};
	string25 DriversLicenseNumber {xpath('DriversLicenseNumber')};
	string2 DriversLicenseState {xpath('DriversLicenseState')};
end;
		
export t_DriversLicenseFieldStatusInd := record
	string DriversLicenseClass {xpath('DriversLicenseClass')};
	string DriversLicenseNumber {xpath('DriversLicenseNumber')};
	string DriversLicenseState {xpath('DriversLicenseState')};
end;
		
export t_ResultDriversLicense := record (t_InsuranceDriversLicense)
	string10 _Type {xpath('Type')};
	share.t_Date IssueDate {xpath('IssueDate')};
	share.t_Date ExpirationDate {xpath('ExpirationDate')};
	string15 Restriction {xpath('Restriction')};
	t_DriversLicenseFieldStatusInd FieldStatusInd {xpath('FieldStatusInd')};
	string LicenseStatus {xpath('LicenseStatus')};
	string LicenseClass {xpath('LicenseClass')};
end;
		
export t_InsuranceSubjectBase := record
	string Id {xpath('Id')};
	string QuoteBack {xpath('QuoteBack')};
	string Classification {xpath('Classification')};
	share.t_Name Name {xpath('Name')};
	string12 UniqueId {xpath('UniqueId')};
	string9 SSN {xpath('SSN')};
	string DriversLicense {xpath('DriversLicense')};
	string2 DriversLicenseState {xpath('DriversLicenseState')};
	integer Age {xpath('Age')};
	string Gender {xpath('Gender')};
	share.t_Date DOB {xpath('DOB')};
	string HeightFeet {xpath('HeightFeet')};
	string HeightInches {xpath('HeightInches')};
	string Weight {xpath('Weight')};
	string Relationship {xpath('Relationship')};
	string MaritalStatus {xpath('MaritalStatus')};
	string EyeColor {xpath('EyeColor')};
	string HairColor {xpath('HairColor')};
	string Race {xpath('Race')};
end;
		
export t_InsuranceBusiness := record
	string120 Name {xpath('Name')};
	t_InsuranceTelephone Telephone {xpath('Telephone')};
	string9 TaxId {xpath('TaxId')};
	string9 ExperianBin {xpath('ExperianBin')};
	string9 DunsNumber {xpath('DunsNumber')};
	string9 AustinTetra {xpath('AustinTetra')};
	string9 BusinessId {xpath('BusinessId')};
end;
		
export t_InsuranceInquirySubject := record (t_InsuranceSubjectBase)
	t_InsuranceTelephone Telephone {xpath('Telephone')};
	t_InsuranceMortgage Mortgage {xpath('Mortgage')};
	t_InsuranceAddress CurrentAddress {xpath('CurrentAddress')};
	t_InsuranceAddress MailingAddress {xpath('MailingAddress')};
	dataset(t_InsuranceAddress) FormerAddresses {xpath('FormerAddresses/FormerAddress'), MAXCOUNT(99)};
	dataset(t_QualifiedInsuranceAddress) QualifiedInsuranceAddresses {xpath('QualifiedInsuranceAddresses/QualifiedInsuranceAddress'), MAXCOUNT(99)};
	dataset(t_InsuranceDriversLicense) DriversLicenses {xpath('DriversLicenses/DriversLicense'), MAXCOUNT(9)};
end;
		
export t_SubjectFieldStatusIndicator := record
	string DriverLicenseNumber {xpath('DriverLicenseNumber')};
	string LicenseState {xpath('LicenseState')};
	share.t_Name Name {xpath('Name')};
	string DOB {xpath('DOB')};
	string Gender {xpath('Gender')};
	string SSN {xpath('SSN')};
	string HeightFeet {xpath('HeightFeet')};
	string HeightInches {xpath('HeightInches')};
	string Weight {xpath('Weight')};
	string Relationship {xpath('Relationship')};
	string MaritalStatus {xpath('MaritalStatus')};
	string EyeColor {xpath('EyeColor')};
	string HairColor {xpath('HairColor')};
end;
		
export t_ResultSubject := record (t_InsuranceSubjectBase)
	string3 GroupSequenceNumber {xpath('GroupSequenceNumber')};
	t_SubjectFieldStatusIndicator FieldStatusIndicator {xpath('FieldStatusIndicator')};
	dataset(t_ResultTelephone) Telephones {xpath('Telephones/Telephone'), MAXCOUNT(99)};
	dataset(t_ResultMortgage) Mortgages {xpath('Mortgages/Mortgage'), MAXCOUNT(99)};
	share.t_Date DOD {xpath('DOD')};
	string NameAssociationIndicator {xpath('NameAssociationIndicator')};
	t_ResultAddress CurrentAddress {xpath('CurrentAddress')};
	t_ResultAddress MailingAddress {xpath('MailingAddress')};
	dataset(t_ResultAddress) FormerAddresses {xpath('FormerAddresses/FormerAddress'), MAXCOUNT(99)};
	dataset(t_QualifiedResultAddress) QualifiedResultAddresses {xpath('QualifiedResultAddresses/QualifiedResultAddress'), MAXCOUNT(99)};
	dataset(t_ResultDriversLicense) DriversLicenses {xpath('DriversLicenses/DriversLicense'), MAXCOUNT(9)};
end;
		
export t_InsuranceInquiryProperty := record
	string Id {xpath('Id')};
	string Classification {xpath('Classification')};
	string QuoteBack {xpath('QuoteBack')};
	dataset(share.t_StringArrayItem) SubjectIds {xpath('SubjectIds/SubjectId'), MAXCOUNT(10)};
	t_InsuranceAddress Address {xpath('Address')};
end;
		
export t_InsuranceVehicle := record
	string Id {xpath('Id')};
	string QuoteBack {xpath('QuoteBack')};
	string Classification {xpath('Classification')};
	integer Year {xpath('Year')};
	string Make {xpath('Make')};
	string MakeDescription {xpath('MakeDescription')};
	string Model {xpath('Model')};
	string ModelDescription {xpath('ModelDescription')};
	string VIN {xpath('VIN')};
	string PlateNumber {xpath('PlateNumber')};
	string PlateClass {xpath('PlateClass')};
	string2 PlateState {xpath('PlateState')};
	dataset(share.t_StringArrayItem) SubjectIds {xpath('SubjectIds/SubjectId'), MAXCOUNT(10)};
end;
		
export t_VehicleFieldStatusIndicator := record
	string PlateNumber {xpath('PlateNumber')};
	string PlateState {xpath('PlateState')};
	string Year {xpath('Year')};
	string Make {xpath('Make')};
	string Model {xpath('Model')};
	string1 MakeModel {xpath('MakeModel')};
	string VIN {xpath('VIN')};
	string Branded {xpath('Branded')};
end;
		
export t_VehicleMechanical := record
	string ShippingWeight {xpath('ShippingWeight')};
	string WeightVariance {xpath('WeightVariance')};
	string DryWeight {xpath('DryWeight')};
	string GrossVehicleWeight {xpath('GrossVehicleWeight')};
	string TonnageRate1 {xpath('TonnageRate1')};
	string TonnageRate2 {xpath('TonnageRate2')};
	string TireSize {xpath('TireSize')};
	string WheelBase {xpath('WheelBase')};
	integer TotalAxles {xpath('TotalAxles')};
	integer DriveAxles {xpath('DriveAxles')};
	string Carburetion {xpath('Carburetion')};
	string Cycles {xpath('Cycles')};
	string Displacement {xpath('Displacement')};
	string DisplacementType {xpath('DisplacementType')};
	string Cylinders {xpath('Cylinders')};
	string Fuel {xpath('Fuel')};
end;
		
export t_VehicleOptional := record
	string AntiLockbrakes {xpath('AntiLockbrakes')};
	string FrontWheelDrive {xpath('FrontWheelDrive')};
	string FourWheelDrive {xpath('FourWheelDrive')};
	string PowerSteering {xpath('PowerSteering')};
	string PowerBrakes {xpath('PowerBrakes')};
	string PowerWindows {xpath('PowerWindows')};
	string AirConditioning {xpath('AirConditioning')};
	string TiltWheel {xpath('TiltWheel')};
	string Security {xpath('Security')};
	string RestraintAirbags {xpath('RestraintAirbags')};
	string RestraintBelts {xpath('RestraintBelts')};
end;
		
export t_RentalCarInformation := record
	string RentalCarId {xpath('RentalCarId')};
	string1 AirportFlag {xpath('AirportFlag')};
	string1 GroupLevel {xpath('GroupLevel')};
	string2 RentalState {xpath('RentalState')};
	string1 CarClassCode {xpath('CarClassCode')};
	string50 CarClassCategory {xpath('CarClassCategory')};
	t_InsuranceVehicle VehicleInfo {xpath('VehicleInfo')};
end;
		
export t_InsuranceReportMessage := record
	string Classification {xpath('Classification')};
	string _Type {xpath('Type')};
	string Code {xpath('Code')};
	string Message {xpath('Message')};
	string FailureStatus {xpath('FailureStatus')};
	string ApplicationStatus {xpath('ApplicationStatus')};
end;
		
export t_VinDecodeResult := record
	string Result {xpath('Result')};
	string _Type {xpath('Type')};
	string Year {xpath('Year')};
	string Status {xpath('Status')};
	string MakeCode {xpath('MakeCode')};
	string MakeDescription {xpath('MakeDescription')};
	string SeriesCode {xpath('SeriesCode')};
	string SeriesDescription {xpath('SeriesDescription')};
	string SubSeriesCode {xpath('SubSeriesCode')};
	string SubSeriesDescription {xpath('SubSeriesDescription')};
	string BodyStyleCode {xpath('BodyStyleCode')};
	string BodyStyleDescription {xpath('BodyStyleDescription')};
end;
		
export t_VinInterestedParty := record
	string Description {xpath('Description')};
	t_ResultAddress Address {xpath('Address')};
	string _Type {xpath('Type')};
	string FsiDescription {xpath('FsiDescription')};
end;
		
export t_ResultVehicle := record (t_InsuranceVehicle)
	string3 GroupSequenceNumber {xpath('GroupSequenceNumber')};
	string _Type {xpath('Type')};
	share.t_Date PlateExpirationDate {xpath('PlateExpirationDate')};
	string Title {xpath('Title')};
	share.t_Date TitleIssueDate {xpath('TitleIssueDate')};
	share.t_Date PurchaseDate {xpath('PurchaseDate')};
	share.t_Date RegistrationDate {xpath('RegistrationDate')};
	share.t_Date SaleDate {xpath('SaleDate')};
	string BrandedIndicator {xpath('BrandedIndicator')};
	integer Odometer {xpath('Odometer')};
	string Price {xpath('Price')};
	string PriceVariance {xpath('PriceVariance')};
	string BodyStyle {xpath('BodyStyle')};
	string CountryOfOrigin {xpath('CountryOfOrigin')};
	t_VinDecodeResult VinDecode {xpath('VinDecode')};
	t_VehicleMechanical Mechanical {xpath('Mechanical')};
	t_VehicleOptional Optional {xpath('Optional')};
	t_VehicleFieldStatusIndicator FieldStatusIndicator {xpath('FieldStatusIndicator')};
	dataset(t_VinInterestedParty) InterestedParties {xpath('InterestedParties/VinInterestedParty'), MAXCOUNT(2)};
	dataset(t_InsuranceReportMessage) Messages {xpath('Messages/Message'), MAXCOUNT(99)};
	string1 VehicleDisposition {xpath('VehicleDisposition')};
end;
		
export t_SubjectWithRelationship := record
	string SubjectId {xpath('SubjectId')};
	string Relationship {xpath('Relationship')};
end;
		
export t_InsurancePolicy := record
	string QuoteBack {xpath('QuoteBack')};
	string Classification {xpath('Classification')};
	string PolicyNumber {xpath('PolicyNumber')};
	string PolicyType {xpath('PolicyType')};
	string Issuer {xpath('Issuer')};
	share.t_Date StartDate {xpath('StartDate')};
	share.t_Date EndDate {xpath('EndDate')};
	dataset(t_SubjectWithRelationship) PolicyHolders {xpath('PolicyHolders/PolicyHolder'), MAXCOUNT(99)};
end;
		
export t_PolicyFieldStatusIndicator := record
	string Number {xpath('Number')};
	string QuoteBack {xpath('QuoteBack')};
	string Classification {xpath('Classification')};
	string _Type {xpath('Type')};
	string Issuer {xpath('Issuer')};
	share.t_Date StartDate {xpath('StartDate')};
	share.t_Date EndDate {xpath('EndDate')};
	dataset(t_SubjectWithRelationship) PolicyHolders {xpath('PolicyHolders/PolicyHolder'), MAXCOUNT(99)};
end;
		
export t_ResultPolicy := record (t_InsurancePolicy)
	string3 GroupSequenceNumber {xpath('GroupSequenceNumber')};
	t_PolicyFieldStatusIndicator FieldStatusIndicator {xpath('FieldStatusIndicator')};
end;
		
export t_PolicyRef := record
	string30 PolicyRefId {xpath('PolicyRefId')};
end;
		
export t_VehicleRef := record
	string10 VehicleRefId {xpath('VehicleRefId')};
end;
		
export t_Participant := record
	string3 ParticipantNumber {xpath('ParticipantNumber')};
	string15 ParticipantRole {xpath('ParticipantRole')};
	string15 ParticipantType {xpath('ParticipantType')};
	string30 PolicyNumber {xpath('PolicyNumber')};
	string80 CarrierName {xpath('CarrierName')};
	string10 SubjectRefId {xpath('SubjectRefId')};
	dataset(t_VehicleRef) VehicleList {xpath('VehicleList/VehicleList'), MAXCOUNT(iesp.Constants.Participant.MaxVehicles)};
	dataset(t_PolicyRef) PolicyList {xpath('PolicyList/PolicyList'), MAXCOUNT(iesp.Constants.Participant.MaxPolicies)};
end;
		
export t_Claims := record
	string50 ClaimNumber {xpath('ClaimNumber')};
	string2 ClaimState {xpath('ClaimState')};
	string80 CarrierName {xpath('CarrierName')};
	string30 CarrierPolicyNumber {xpath('CarrierPolicyNumber')};
	share.t_Date ReportedDate {xpath('ReportedDate')};
	share.t_Date LossDate {xpath('LossDate')};
	dataset(t_Participant) Participants {xpath('Participants/Participant'), MAXCOUNT(iesp.Constants.Claims.MaxParticipants)};
end;
		
export t_InsuranceCommonSearchBy := record
	dataset(t_InsuranceInquirySubject) Subjects {xpath('Subjects/Subject'), MAXCOUNT(50)};
	dataset(t_InsuranceBusiness) Businesses {xpath('Businesses/Business'), MAXCOUNT(50)};
	dataset(t_InsuranceInquiryProperty) Properties {xpath('Properties/Property'), MAXCOUNT(10)};
	dataset(t_InsuranceVehicle) Vehicles {xpath('Vehicles/Vehicle'), MAXCOUNT(10)};
	dataset(t_InsurancePolicy) Policies {xpath('Policies/Policy'), MAXCOUNT(10)};
	dataset(t_RentalCarInformation) RentalCars {xpath('RentalCars/RentalCar'), MAXCOUNT(10)};
	dataset(t_QualifiedInsuranceAddress) InsuranceAddresses {xpath('InsuranceAddresses/InsuranceAddress'), MAXCOUNT(10)};
	dataset(share.t_NameValuePair) Parameters {xpath('Parameters/Parameter'), MAXCOUNT(500)};
	dataset(t_Claims) Claims {xpath('Claims/Claim'), MAXCOUNT(iesp.Constants.Claims.MaxClaims)};
end;
		
export t_AttachedProduct := record
	dataset(t_InsuranceReportMessage) Messages {xpath('Messages/Message'), MAXCOUNT(999)};
	string Name {xpath('Name')};
	string Title {xpath('Title')};
end;
		
export t_ConsumerNarrative := record
	dataset(t_InsuranceReportMessage) Messages {xpath('Messages/Message'), MAXCOUNT(5)};
	string Relationship {xpath('Relationship')};
	string Name {xpath('Name')};
	share.t_Date DateFiled {xpath('DateFiled')};
end;
		
export t_ClaimPayment := record
	string _Type {xpath('Type')};
	string CauseOfLoss {xpath('CauseOfLoss')};
	string AmountPaid {xpath('AmountPaid')};
	string Disposition {xpath('Disposition')};
end;
		
export t_Claim := record
	string Number {xpath('Number')};
	string Id {xpath('Id')};
	string GroupSequenceNumber {xpath('GroupSequenceNumber')};
	string ScopeOfClaim {xpath('ScopeOfClaim')};
	string AtFaultCatastropheIndicator {xpath('AtFaultCatastropheIndicator')};
	share.t_Date ClaimDate {xpath('ClaimDate')};
	share.t_Date FirstPaymentDate {xpath('FirstPaymentDate')};
	share.t_Date LatestPaymentDate {xpath('LatestPaymentDate')};
	string ClaimAssociationIndicator {xpath('ClaimAssociationIndicator')};
	integer2 ClaimAgeYears {xpath('ClaimAgeYears')};
	integer2 ClaimAgeMonths {xpath('ClaimAgeMonths')};
	string ClueFileNumber {xpath('ClueFileNumber')};
	share.t_Date DisputeClearanceDate {xpath('DisputeClearanceDate')};
	t_ResultPolicy Policy {xpath('Policy')};
	dataset(t_ResultSubject) Subjects {xpath('Subjects/Subject'), MAXCOUNT(2)};
	t_ResultVehicle Vehicle {xpath('Vehicle')};
	string Telephone {xpath('Telephone')};
	dataset(t_ClaimPayment) ClaimPayments {xpath('ClaimPayments/ClaimPayment'), MAXCOUNT(15)};
	dataset(t_ConsumerNarrative) ConsumerNarratives {xpath('ConsumerNarratives/ConsumerNarrative'), MAXCOUNT(2)};
	string VehicleOperatorIndicator {xpath('VehicleOperatorIndicator')};
	boolean PossiblyRelatedClaim {xpath('PossiblyRelatedClaim')};
end;
		
export t_InsuranceBaseRequest := record
	t_RequesterInformation RequesterInfo {xpath('RequesterInfo')};
	t_TransactionDetails Transaction {xpath('Transaction')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from ins_share.xml. ***/
/*===================================================*/

