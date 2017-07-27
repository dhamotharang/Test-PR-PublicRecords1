export riskview := MODULE
			
export t_RiskViewModels := record
	boolean BankCard {xpath('BankCard')};
	string BankCardF2 {xpath('BankCardF2')};
	boolean Auto {xpath('Auto')};
	string AutoF2 {xpath('AutoF2')};
	boolean Telecom {xpath('Telecom')};
	string TelecomF2 {xpath('TelecomF2')};
	boolean Retail {xpath('Retail')};
	string RetailF2 {xpath('RetailF2')};
	boolean InPersonApplication {xpath('InPersonApplication')};
	dataset(instantid.t_ModelRequest) ModelRequests {xpath('ModelRequests/ModelRequest'), MAXCOUNT(1)};
end;
		
export t_RiskViewOptions := record (share.t_BaseOption)
	t_RiskViewModels IncludeModels {xpath('IncludeModels')};
	string IntendedPurpose {xpath('IntendedPurpose')}; //values['Application','Prescreening','Portfolio Review','']
end;
		
export t_RiskViewSearchBy := record (instantid.t_InstantIDModelSearchBy)
end;
		
export t_RiskViewResult := record (instantid.t_InstantIDModelResult)
end;
		
export t_RiskViewResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	t_RiskViewResult Result {xpath('Result')};
end;
		
export t_RiskViewAttribModels := record (t_RiskViewModels)
	boolean Attributes {xpath('Attributes')};
end;
		
export t_RiskViewAttribOptions := record (share.t_BaseOption)
	t_RiskViewAttribModels IncludeModels {xpath('IncludeModels')};
	string IntendedPurpose {xpath('IntendedPurpose')}; //values['Application','Prescreening','Portfolio Review','']
	dataset(share.t_StringArrayItem) RequestedAttributeGroups {xpath('RequestedAttributeGroups/Name'), MAXCOUNT(1)};
end;
		
export t_RiskViewAttribResult := record (instantid.t_InstantIDModelResult)
	dataset(share.t_AttributeGroup) AttributeGroups {xpath('AttributeGroups/'), MAXCOUNT(1)};
end;
		
export t_RiskViewAttribResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	t_RiskViewAttribResult Result {xpath('Result')};
end;
		
export t_RiskViewPropSearchBy := record
	share.t_Address Address {xpath('Address')};
end;
		
export t_RiskViewPropRptOptions := record (share.t_BaseOption)
end;
		
export t_AVMInfo := record
	integer AutomatedValuation {xpath('AutomatedValuation')};
	integer Score {xpath('Score')};
end;
		
export t_RiskViewPropertyInfo := record
	string CountyName {xpath('CountyName')};
	string AlternateParcelNumber {xpath('AlternateParcelNumber')};
	string LegalDescription {xpath('LegalDescription')};
	string LegalCityMunicipalityTownship {xpath('LegalCityMunicipalityTownship')};
	string LegalSubdivisionName {xpath('LegalSubdivisionName')};
	string LandUse {xpath('LandUse')};
	boolean OwnerOccupied {xpath('OwnerOccupied')};
	share.t_Date SaleDate {xpath('SaleDate')};
	string SalePrice {xpath('SalePrice')};
	string AssessedLandValue {xpath('AssessedLandValue')};
	string AssessedImprovementValue {xpath('AssessedImprovementValue')};
	string AssessedTotalValue {xpath('AssessedTotalValue')};
	integer AssessedValueYear {xpath('AssessedValueYear')};
	string MarketLandValue {xpath('MarketLandValue')};
	string MarketImprovementValue {xpath('MarketImprovementValue')};
	string MarketTotalValue {xpath('MarketTotalValue')};
	integer MarketValueYear {xpath('MarketValueYear')};
	string TaxAmount {xpath('TaxAmount')};
	integer TaxYear {xpath('TaxYear')};
	string LandAcres {xpath('LandAcres')};
	string LandSquareFootage {xpath('LandSquareFootage')};
	string LandDimensions {xpath('LandDimensions')};
	string BuildingArea {xpath('BuildingArea')};
	string BuildingAreaDescription {xpath('BuildingAreaDescription')};
	integer YearBuilt {xpath('YearBuilt')};
	string NoOfBuildings {xpath('NoOfBuildings')};
	string NoOfStories {xpath('NoOfStories')};
	string NoOfUnits {xpath('NoOfUnits')};
	string NoOfRooms {xpath('NoOfRooms')};
	string NoOfBedrooms {xpath('NoOfBedrooms')};
	string NoOfBaths {xpath('NoOfBaths')};
	string ParkingNoOfCars {xpath('ParkingNoOfCars')};
	string GarageDescription {xpath('GarageDescription')};
	string PoolDescription {xpath('PoolDescription')};
	string StyleDescription {xpath('StyleDescription')};
	string TypeConstructionDescription {xpath('TypeConstructionDescription')};
	string ExteriorWallsDescription {xpath('ExteriorWallsDescription')};
	string FoundationDescription {xpath('FoundationDescription')};
	string RoofCoverDescription {xpath('RoofCoverDescription')};
	string RoofTypeDescription {xpath('RoofTypeDescription')};
	string HeatingDescription {xpath('HeatingDescription')};
	string HeatingFuelTypeDescription {xpath('HeatingFuelTypeDescription')};
	string AirConditioningDescription {xpath('AirConditioningDescription')};
	string BasementDescription {xpath('BasementDescription')};
	string FireplaceIndicator {xpath('FireplaceIndicator')};
end;
		
export t_RiskViewPropertyResult := record
	t_RiskViewPropSearchBy InputEcho {xpath('InputEcho')};
	t_AVMInfo AvmInformation {xpath('AvmInformation')};
	t_RiskViewPropertyInfo PropertyInformation {xpath('PropertyInformation')};
end;
		
export t_RiskViewPropRptResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	t_RiskViewPropertyResult Result {xpath('Result')};
end;
		
export t_FCRAPhoneHistoryOptions := record (share.t_BaseOption)
end;
		
export t_FCRAPhoneHistorySearchBy := record
	string UniqueId {xpath('UniqueId')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string SSN {xpath('SSN')};
	share.t_Date DOB {xpath('DOB')};
	string Phone10 {xpath('Phone10')};
end;
		
export t_PhoneHistory := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	string UniqueId {xpath('UniqueId')};
	string HouseholdId {xpath('HouseholdId')};
	string Phone10 {xpath('Phone10')};
	string OmitAddress {xpath('OmitAddress')};
	string OmitPhone {xpath('OmitPhone')};
	string OmitLocality {xpath('OmitLocality')};
	string PublishCode {xpath('PublishCode')};
	dataset(share.t_StringArrayItem) ListingTypes {xpath('ListingTypes/ListingType'), MAXCOUNT(1)};
end;
		
export t_FCRAPhoneHistoryResult := record
	t_FCRAPhoneHistorySearchBy InputEcho {xpath('InputEcho')};
	dataset(t_PhoneHistory) PhoneHistories {xpath('PhoneHistories/PhoneHistory'), MAXCOUNT(1)};
end;
		
export t_FCRAPhoneHistoryResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	t_FCRAPhoneHistoryResult Result {xpath('Result')};
end;
		
export t_LienJudgmentBankruptcyOptions := record (share.t_BaseOption)
end;
		
export t_LienJudgmentBankruptcySearchBy := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string SSN {xpath('SSN')};
	share.t_Date DOB {xpath('DOB')};
	string Phone10 {xpath('Phone10')};
end;
		
export t_FilingInfo := record
	share.t_Date OriginalDate {xpath('OriginalDate')};
	string Number {xpath('Number')};
	string OriginalNumber {xpath('OriginalNumber')};
	string _Type {xpath('Type')};
	string Book {xpath('Book')};
	string Page {xpath('Page')};
	string Status {xpath('Status')};
	string StatusDescription {xpath('StatusDescription')};
	string Jurisdiction {xpath('Jurisdiction')};
	string JurisdictionName {xpath('JurisdictionName')};
	string County {xpath('County')};
	string State {xpath('State')};
end;
		
export t_DebtorInfo := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string SSN {xpath('SSN')};
end;
		
export t_LienJudgment := record
	t_FilingInfo Filing {xpath('Filing')};
	t_DebtorInfo Debtor {xpath('Debtor')};
	integer Amount {xpath('Amount')};
	string CaseNumber {xpath('CaseNumber')};
end;
		
export t_Bankruptcy := record
	string FilerType {xpath('FilerType')};
	string FilingStatus {xpath('FilingStatus')};
	share.t_Date FilingDate {xpath('FilingDate')};
	share.t_Date OriginalFilingDate {xpath('OriginalFilingDate')};
	t_DebtorInfo Debtor {xpath('Debtor')};
	string CaseNumber {xpath('CaseNumber')};
	string CourtCode {xpath('CourtCode')};
	string CourtName {xpath('CourtName')};
	string CourtLocation {xpath('CourtLocation')};
	string CourtState {xpath('CourtState')};
	string Chapter {xpath('Chapter')};
	string Disposition {xpath('Disposition')};
	share.t_Date ClosedDate {xpath('ClosedDate')};
	share.t_Date ConvertedDate {xpath('ConvertedDate')};
	string CorpFlag {xpath('CorpFlag')};
end;
		
export t_LienJudgmentBankruptcyResult := record
	t_LienJudgmentBankruptcySearchBy InputEcho {xpath('InputEcho')};
	boolean HasBankruptcy {xpath('HasBankruptcy')};
	boolean HasFederalTaxLien {xpath('HasFederalTaxLien')};
	integer FederalTaxLienAmount {xpath('FederalTaxLienAmount')};
	boolean HasStateTaxLien {xpath('HasStateTaxLien')};
	integer StateTaxLienAmount {xpath('StateTaxLienAmount')};
	boolean HasCountyTaxLien {xpath('HasCountyTaxLien')};
	integer CountyTaxLienAmount {xpath('CountyTaxLienAmount')};
	boolean HasChildSupport {xpath('HasChildSupport')};
	integer ChildSupportAmount {xpath('ChildSupportAmount')};
	dataset(t_Bankruptcy) Bankruptcies {xpath('Bankruptcies/Bankruptcy'), MAXCOUNT(1)};
	dataset(t_LienJudgment) LiensJudgments {xpath('LiensJudgments/LienJudgment'), MAXCOUNT(1)};
end;
		
export t_RiskViewLienJudgmentBankruptcyReportResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	t_LienJudgmentBankruptcyResult Result {xpath('Result')};
end;
		
export t_SmallBusinessReportOptions := record (share.t_BaseSearchOption)
end;
		
export t_BusinessInfo := record
	string Name {xpath('Name')};
	string AlternateName {xpath('AlternateName')};
	share.t_Address Address {xpath('Address')};
	string FEIN {xpath('FEIN')};
	string Phone10 {xpath('Phone10')};
end;
		
export t_OwnerAgentInfo := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string SSN {xpath('SSN')};
	share.t_Date DOB {xpath('DOB')};
	string Phone10 {xpath('Phone10')};
	string DriverLicenseNumber {xpath('DriverLicenseNumber')};
	string DriverLicenseState {xpath('DriverLicenseState')};
end;
		
export t_SmallBusinessReportSearchBy := record
	t_BusinessInfo Business {xpath('Business')};
	t_OwnerAgentInfo OwnerAgent {xpath('OwnerAgent')};
end;
		
export t_RiskViewSmallBusinessReportRequest := record (share.t_BaseRequest)
	t_SmallBusinessReportOptions Options {xpath('Options')};
	t_SmallBusinessReportSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_SmallBusinessScoreHRI := record
	string _Type {xpath('Type')};
	integer Value {xpath('Value')};
	integer Index {xpath('Index')};//hidden[internal]
	dataset(share.t_RiskIndicator) BusinessHighRiskIndicators {xpath('BusinessHighRiskIndicators/HighRiskIndicator'), MAXCOUNT(Constants.MaxCountRVSmallBusinessHRI)};
	dataset(share.t_RiskIndicator) OwnerAgentHighRiskIndicators {xpath('OwnerAgentHighRiskIndicators/HighRiskIndicator'), MAXCOUNT(Constants.MaxCountRVSmallBusinessHRI)};
end;
		
export t_SmallBusinessModelHRI := record
	string Name {xpath('Name')};
	string Description {xpath('Description')};
	dataset(t_SmallBusinessScoreHRI) Scores {xpath('Scores/Score'), MAXCOUNT(1)};
end;
		
export t_SmallBusinessReportResult := record
	t_SmallBusinessReportSearchBy InputEcho {xpath('InputEcho')};
	dataset(t_SmallBusinessModelHRI) Models {xpath('Models/Model'), MAXCOUNT(Constants.MaxCountRVSmallBusinessModels)};
end;
		
export t_RiskViewSmallBusinessReportResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	t_SmallBusinessReportResult Result {xpath('Result')};
end;
		
export t_RiskViewRequest := record (share.t_BaseRequest)
	t_RiskViewOptions Options {xpath('Options')};
	t_RiskViewSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_RiskViewAttribRequest := record (share.t_BaseRequest)
	t_RiskViewAttribOptions Options {xpath('Options')};
	t_RiskViewSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_RiskViewPropRptRequest := record (share.t_BaseRequest)
	t_RiskViewPropRptOptions Options {xpath('Options')};
	t_RiskViewPropSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_FCRAPhoneHistoryReportRequest := record (share.t_BaseRequest)
	t_FCRAPhoneHistoryOptions Options {xpath('Options')};
	t_FCRAPhoneHistorySearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_RiskViewLienJudgmentBankruptcyReportRequest := record (share.t_BaseRequest)
	t_LienJudgmentBankruptcyOptions Options {xpath('Options')};
	t_LienJudgmentBankruptcySearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_RiskViewResponseEx := record
	t_RiskViewResponse response {xpath('response')};
end;
		
export t_RiskViewAttribResponseEx := record
	t_RiskViewAttribResponse response {xpath('response')};
end;
		
export t_RiskViewPropRptResponseEx := record
	t_RiskViewPropRptResponse response {xpath('response')};
end;
		
export t_FCRAPhoneHistoryReportResponseEx := record
	t_FCRAPhoneHistoryResponse response {xpath('response')};
end;
		
export t_RiskViewLienJudgmentBankruptcyReportResponseEx := record
	t_RiskViewLienJudgmentBankruptcyReportResponse response {xpath('response')};
end;
		
export t_RiskViewSmallBusinessReportResponseEx := record
	t_RiskViewSmallBusinessReportResponse response {xpath('response')};
end;
		

end;

