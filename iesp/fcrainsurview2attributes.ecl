﻿/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from fcrainsurview2attributes.xml. ***/
/*===================================================*/

import iesp;

export fcrainsurview2attributes := MODULE
			
export t_Iv2MLAGatewayInfo := record
	string20 CustomerNumber {xpath('CustomerNumber')};
	string10 SecurityCode {xpath('SecurityCode')};
	string120 UserCompanyName {xpath('UserCompanyName')};
end;
		
export t_Iv2TransactionContext := record
	t_Iv2MLAGatewayInfo MLAGatewayInfo {xpath('MLAGatewayInfo')};
end;
		
export t_FCRAInsurView2AttributesLiensJudgmentsReportOptions := record
	boolean IncludeRecordsWithSSN {xpath('IncludeRecordsWithSSN')};
	boolean ExcludeCityTaxLiens {xpath('ExcludeCityTaxLiens')};
	boolean ExcludeCountyTaxLiens {xpath('ExcludeCountyTaxLiens')};
	boolean ExcludeStateTaxWarrants {xpath('ExcludeStateTaxWarrants')};
	boolean ExcludeStateTaxLiens {xpath('ExcludeStateTaxLiens')};
	boolean ExcludeFederalTaxLiens {xpath('ExcludeFederalTaxLiens')};
	boolean ExcludeOtherLiens {xpath('ExcludeOtherLiens')};
	boolean ExcludeJudgments {xpath('ExcludeJudgments')};
	boolean ExcludeEvictions {xpath('ExcludeEvictions')};
	boolean IncludeBureauRecs {xpath('IncludeBureauRecs')};
	boolean GeneratePDF {xpath('GeneratePDF')};
	integer ReportingPeriod {xpath('ReportingPeriod')};
end;
		
export t_FCRAInsurView2AttributesOptions := record (iesp.share.t_BaseSearchOptionEx)
	string20 FFDOptionsMask {xpath('FFDOptionsMask')};//hidden[ecl_only]
	string64 AttributesVersionRequest {xpath('AttributesVersionRequest')};
	boolean Allow10YearBankruptcy {xpath('Allow10YearBankruptcy')};
	string IntendedPurpose {xpath('IntendedPurpose')}; //values['Application','Prescreening','Portfolio Review','Insurance Application','Insurance Portfolio Review','Disclosure','Government','Collections','Tenant Screening','Healthcare Credit Transaction','Healthcare Legitimate Business Need','Rental Car Loss Damage Waiver','Employee or Volunteer Screening','Written Consent Prequalification','Rental Car','Written Consent','Child Support','Demand Deposit','Written Consent Direct to Consumer','Credit Application','']
	boolean IncludeLiensJudgmentsReport {xpath('IncludeLiensJudgmentsReport')};
	t_FCRAInsurView2AttributesLiensJudgmentsReportOptions LiensJudgmentsReportOptions {xpath('LiensJudgmentsReportOptions')};
end;
		
export t_FCRAInsurView2AttributesSearchBy := record
	string30 Seq {xpath('Seq')};//hidden[ecldev]
	string12 UniqueId {xpath('UniqueId')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_AddressWithGeoLocation Address {xpath('Address')};
	iesp.share.t_Date DOB {xpath('DOB')};
	integer Age {xpath('Age')};
	string9 SSN {xpath('SSN')};
	string4 SSNLast4 {xpath('SSNLast4')};
	string32 DriverLicenseNumber {xpath('DriverLicenseNumber')};
	string2 DriverLicenseState {xpath('DriverLicenseState')};
	string45 IPAddress {xpath('IPAddress')};
	string10 HomePhone {xpath('HomePhone')};
	string10 WorkPhone {xpath('WorkPhone')};
	string50 Email {xpath('Email')};
end;
		
export t_InputDataCheckFlagsAttributesV2 := record
	string1 InputProvidedFirstName {xpath('InputProvidedFirstName')};
	string1 InputProvidedLastName {xpath('InputProvidedLastName')};
	string1 InputProvidedStreetAddress {xpath('InputProvidedStreetAddress')};
	string1 InputProvidedCity {xpath('InputProvidedCity')};
	string1 InputProvidedState {xpath('InputProvidedState')};
	string1 InputProvidedZipCode {xpath('InputProvidedZipCode')};
	string1 InputProvidedSSN {xpath('InputProvidedSSN')};
	string1 InputProvidedDateofBirth {xpath('InputProvidedDateofBirth')};
	string1 InputProvidedPhone {xpath('InputProvidedPhone')};
	string1 InputProvidedLexID {xpath('InputProvidedLexID')};
end;
		
export t_SubjectSourceAttributesV2 := record
	string3 SubjectRecordTimeOldest {xpath('SubjectRecordTimeOldest')};
	string3 SubjectRecordTimeNewest {xpath('SubjectRecordTimeNewest')};
	string2 SubjectNewestRecord12Month {xpath('SubjectNewestRecord12Month')};
	string2 SubjectActivityIndex03Month {xpath('SubjectActivityIndex03Month')};
	string2 SubjectActivityIndex06Month {xpath('SubjectActivityIndex06Month')};
	string2 SubjectActivityIndex12Month {xpath('SubjectActivityIndex12Month')};
	string3 SubjectAge {xpath('SubjectAge')};
	string2 SubjectDeceased {xpath('SubjectDeceased')};
	string3 SubjectSSNCount {xpath('SubjectSSNCount')};
	string2 SubjectStabilityIndex {xpath('SubjectStabilityIndex')};
	string3 SubjectStabilityPrimaryFactor {xpath('SubjectStabilityPrimaryFactor')};
	string2 SubjectAbilityIndex {xpath('SubjectAbilityIndex')};
	string3 SubjectAbilityPrimaryFactor {xpath('SubjectAbilityPrimaryFactor')};
	string2 SubjectWillingnessIndex {xpath('SubjectWillingnessIndex')};
	string3 SubjectWillingnessPrimaryFactor {xpath('SubjectWillingnessPrimaryFactor')};
end;
		
export t_SubjectConfirmationAttributesV2 := record
	string1 ConfirmationSubjectFound {xpath('ConfirmationSubjectFound')};
	string2 ConfirmationInputName {xpath('ConfirmationInputName')};
	string2 ConfirmationInputDOB {xpath('ConfirmationInputDOB')};
	string2 ConfirmationInputSSN {xpath('ConfirmationInputSSN')};
	string2 ConfirmationInputAddress {xpath('ConfirmationInputAddress')};
end;
		
export t_SourceRecordActivityAttributesV2 := record
	string2 SourceNonDerogProfileIndex {xpath('SourceNonDerogProfileIndex')};
	string3 SourceNonDerogCount {xpath('SourceNonDerogCount')};
	string3 SourceNonDerogCount03Month {xpath('SourceNonDerogCount03Month')};
	string3 SourceNonDerogCount06Month {xpath('SourceNonDerogCount06Month')};
	string3 SourceNonDerogCount12Month {xpath('SourceNonDerogCount12Month')};
	string3 SourceCredHeaderTimeOldest {xpath('SourceCredHeaderTimeOldest')};
	string3 SourceCredHeaderTimeNewest {xpath('SourceCredHeaderTimeNewest')};
	string2 SourceVoterRegistration {xpath('SourceVoterRegistration')};
end;
		
export t_SSNCharacteristicsAttributesV2 := record
	string3 SSNSubjectCount {xpath('SSNSubjectCount')};
	string2 SSNDeceased {xpath('SSNDeceased')};
	string8 SSNDateLowIssued {xpath('SSNDateLowIssued')};
	string2 SSNProblems {xpath('SSNProblems')};
end;
		
export t_AddressCharacteristicsAttributesV2 := record
	string3 AddrOnFileCount {xpath('AddrOnFileCount')};
	string2 AddrOnFileCorrectional {xpath('AddrOnFileCorrectional')};
	string2 AddrOnFileCollege {xpath('AddrOnFileCollege')};
	string2 AddrOnFileHighRisk {xpath('AddrOnFileHighRisk')};
	string3 AddrInputTimeOldest {xpath('AddrInputTimeOldest')};
	string3 AddrInputTimeNewest {xpath('AddrInputTimeNewest')};
	string3 AddrInputLengthOfRes {xpath('AddrInputLengthOfRes')};
	string3 AddrInputSubjectCount {xpath('AddrInputSubjectCount')};
	string2 AddrInputMatchIndex {xpath('AddrInputMatchIndex')};
	string2 AddrInputSubjectOwned {xpath('AddrInputSubjectOwned')};
	string2 AddrInputDeedMailing {xpath('AddrInputDeedMailing')};
	string2 AddrInputOwnershipIndex {xpath('AddrInputOwnershipIndex')};
	string2 AddrInputPhoneService {xpath('AddrInputPhoneService')};
	string3 AddrInputPhoneCount {xpath('AddrInputPhoneCount')};
	string2 AddrInputDwellType {xpath('AddrInputDwellType')};
	string2 AddrInputDwellTypeIndex {xpath('AddrInputDwellTypeIndex')};
	string2 AddrInputDelivery {xpath('AddrInputDelivery')};
	string3 AddrInputTimeLastSale {xpath('AddrInputTimeLastSale')};
	string7 AddrInputLastSalePrice {xpath('AddrInputLastSalePrice')};
	string7 AddrInputTaxValue {xpath('AddrInputTaxValue')};
	string4 AddrInputTaxYr {xpath('AddrInputTaxYr')};
	string7 AddrInputTaxMarketValue {xpath('AddrInputTaxMarketValue')};
	string7 AddrInputAVMValue {xpath('AddrInputAVMValue')};
	string7 AddrInputAVMValue12Month {xpath('AddrInputAVMValue12Month')};
	string5 AddrInputAVMRatio12MonthPrior {xpath('AddrInputAVMRatio12MonthPrior')};
	string7 AddrInputAVMValue60Month {xpath('AddrInputAVMValue60Month')};
	string5 AddrInputAVMRatio60MonthPrior {xpath('AddrInputAVMRatio60MonthPrior')};
	string5 AddrInputCountyRatio {xpath('AddrInputCountyRatio')};
	string5 AddrInputTractRatio {xpath('AddrInputTractRatio')};
	string5 AddrInputBlockRatio {xpath('AddrInputBlockRatio')};
	string2 AddrInputProblems {xpath('AddrInputProblems')};
	string3 AddrCurrentTimeOldest {xpath('AddrCurrentTimeOldest')};
	string3 AddrCurrentTimeNewest {xpath('AddrCurrentTimeNewest')};
	string3 AddrCurrentLengthOfRes {xpath('AddrCurrentLengthOfRes')};
	string2 AddrCurrentSubjectOwned {xpath('AddrCurrentSubjectOwned')};
	string2 AddrCurrentDeedMailing {xpath('AddrCurrentDeedMailing')};
	string2 AddrCurrentOwnershipIndex {xpath('AddrCurrentOwnershipIndex')};
	string2 AddrCurrentPhoneService {xpath('AddrCurrentPhoneService')};
	string2 AddrCurrentDwellType {xpath('AddrCurrentDwellType')};
	string2 AddrCurrentDwellTypeIndex {xpath('AddrCurrentDwellTypeIndex')};
	string3 AddrCurrentTimeLastSale {xpath('AddrCurrentTimeLastSale')};
	string7 AddrCurrentLastSalesPrice {xpath('AddrCurrentLastSalesPrice')};
	string7 AddrCurrentTaxValue {xpath('AddrCurrentTaxValue')};
	string4 AddrCurrentTaxYr {xpath('AddrCurrentTaxYr')};
	string7 AddrCurrentTaxMarketValue {xpath('AddrCurrentTaxMarketValue')};
	string7 AddrCurrentAVMValue {xpath('AddrCurrentAVMValue')};
	string7 AddrCurrentAVMValue12Month {xpath('AddrCurrentAVMValue12Month')};
	string5 AddrCurrentAVMRatio12MonthPrior {xpath('AddrCurrentAVMRatio12MonthPrior')};
	string7 AddrCurrentAVMValue60Month {xpath('AddrCurrentAVMValue60Month')};
	string5 AddrCurrentAVMRatio60MonthPrior {xpath('AddrCurrentAVMRatio60MonthPrior')};
	string5 AddrCurrentCountyRatio {xpath('AddrCurrentCountyRatio')};
	string5 AddrCurrentTractRatio {xpath('AddrCurrentTractRatio')};
	string5 AddrCurrentBlockRatio {xpath('AddrCurrentBlockRatio')};
	string2 AddrCurrentCorrectional {xpath('AddrCurrentCorrectional')};
	string3 AddrPreviousTimeOldest {xpath('AddrPreviousTimeOldest')};
	string3 AddrPreviousTimeNewest {xpath('AddrPreviousTimeNewest')};
	string3 AddrPreviousLengthOfRes {xpath('AddrPreviousLengthOfRes')};
	string2 AddrPreviousSubjectOwned {xpath('AddrPreviousSubjectOwned')};
	string2 AddrPreviousOwnershipIndex {xpath('AddrPreviousOwnershipIndex')};
	string2 AddrPreviousDwellType {xpath('AddrPreviousDwellType')};
	string2 AddrPreviousDwellTypeIndex {xpath('AddrPreviousDwellTypeIndex')};
	string2 AddrPreviousCorrectional {xpath('AddrPreviousCorrectional')};
end;
		
export t_AddressHistoryAttributesV2 := record
	string2 AddrStabilityIndex {xpath('AddrStabilityIndex')};
	string3 AddrChangeCount03Month {xpath('AddrChangeCount03Month')};
	string3 AddrChangeCount06Month {xpath('AddrChangeCount06Month')};
	string3 AddrChangeCount12Month {xpath('AddrChangeCount12Month')};
	string3 AddrChangeCount24Month {xpath('AddrChangeCount24Month')};
	string3 AddrChangeCount60Month {xpath('AddrChangeCount60Month')};
	string5 AddrLastMoveTaxRatioDiff {xpath('AddrLastMoveTaxRatioDiff')};
	string2 AddrLastMoveEconTrajectory {xpath('AddrLastMoveEconTrajectory')};
	string2 AddrLastMoveEconTrajectoryIndex {xpath('AddrLastMoveEconTrajectoryIndex')};
end;
		
export t_PhoneCharacteristicsAttrributesV2 := record
	string2 PhoneInputProblems {xpath('PhoneInputProblems')};
	string3 PhoneInputSubjectCount {xpath('PhoneInputSubjectCount')};
	string2 PhoneInputMobile {xpath('PhoneInputMobile')};
end;
		
export t_EducationAttributesV2 := record
	string2 EducationAttendance {xpath('EducationAttendance')};
	string2 EducationEvidence {xpath('EducationEvidence')};
	string2 EducationProgramAttended {xpath('EducationProgramAttended')};
	string2 EducationInstitutionPrivate {xpath('EducationInstitutionPrivate')};
	string2 EducationInstitutionRating {xpath('EducationInstitutionRating')};
end;
		
export t_BusinessAssociationAttributesV2 := record
	string2 BusinessAssociation {xpath('BusinessAssociation')};
	string2 BusinessAssociationIndex {xpath('BusinessAssociationIndex')};
	string3 BusinessAssociationTimeOldest {xpath('BusinessAssociationTimeOldest')};
	string2 BusinessTitleLeadership {xpath('BusinessTitleLeadership')};
end;
		
export t_ProfessionalLicenseAttributesV2 := record
	string3 ProfLicCount {xpath('ProfLicCount')};
	string2 ProfLicTypeCategory {xpath('ProfLicTypeCategory')};
end;
		
export t_AssetsAttributesV2 := record
	string2 AssetIndex {xpath('AssetIndex')};
	string3 AssetIndexPrimaryFactor {xpath('AssetIndexPrimaryFactor')};
	string2 AssetOwnership {xpath('AssetOwnership')};
	string2 AssetProp {xpath('AssetProp')};
	string2 AssetPropIndex {xpath('AssetPropIndex')};
	string3 AssetPropEverCount {xpath('AssetPropEverCount')};
	string3 AssetPropCurrentCount {xpath('AssetPropCurrentCount')};
	string7 AssetPropCurrentTaxTotal {xpath('AssetPropCurrentTaxTotal')};
	string3 AssetPropPurchaseCount12Month {xpath('AssetPropPurchaseCount12Month')};
	string3 AssetPropPurchaseTimeOldest {xpath('AssetPropPurchaseTimeOldest')};
	string3 AssetPropPurchaseTimeNewest {xpath('AssetPropPurchaseTimeNewest')};
	string2 AssetPropNewestMortgageType {xpath('AssetPropNewestMortgageType')};
	string3 AssetPropEverSoldCount {xpath('AssetPropEverSoldCount')};
	string3 AssetPropSoldCount12Month {xpath('AssetPropSoldCount12Month')};
	string3 AssetPropSaleTimeOldest {xpath('AssetPropSaleTimeOldest')};
	string3 AssetPropSaleTimeNewest {xpath('AssetPropSaleTimeNewest')};
	string7 AssetPropNewestSalePrice {xpath('AssetPropNewestSalePrice')};
	string5 AssetPropSalePurchaseRatio {xpath('AssetPropSalePurchaseRatio')};
	string2 AssetPersonal {xpath('AssetPersonal')};
	string3 AssetPersonalCount {xpath('AssetPersonalCount')};
end;
		
export t_PurchaseActivityAttributesV2 := record
	string2 PurchaseActivityIndex {xpath('PurchaseActivityIndex')};
	string3 PurchaseActivityCount {xpath('PurchaseActivityCount')};
	string7 PurchaseActivityDollarTotal {xpath('PurchaseActivityDollarTotal')};
end;
		
export t_DerogatoryPublicRecordsAttributesV2 := record
	string2 DerogSeverityIndex {xpath('DerogSeverityIndex')};
	string3 DerogCount {xpath('DerogCount')};
	string3 DerogCount12Month {xpath('DerogCount12Month')};
	string3 DerogTimeNewest {xpath('DerogTimeNewest')};
end;
		
export t_CriminalRecordsAttributesV2 := record
	string3 CriminalFelonyCount {xpath('CriminalFelonyCount')};
	string3 CriminalFelonyCount12Month {xpath('CriminalFelonyCount12Month')};
	string2 CriminalFelonyTimeNewest {xpath('CriminalFelonyTimeNewest')};
	string3 CriminalNonFelonyCount {xpath('CriminalNonFelonyCount')};
	string3 CriminalNonFelonyCount12Month {xpath('CriminalNonFelonyCount12Month')};
	string2 CriminalNonFelonyTimeNewest {xpath('CriminalNonFelonyTimeNewest')};
end;
		
export t_EvictionRecordsAttributesV2 := record
	string3 EvictionCount {xpath('EvictionCount')};
	string3 EvictionCount12Month {xpath('EvictionCount12Month')};
	string2 EvictionTimeNewest {xpath('EvictionTimeNewest')};
end;
		
export t_TaxLienAndCourtJudgmentRecordsAttributesV2 := record
	string2 LienJudgmentSeverityIndex {xpath('LienJudgmentSeverityIndex')};
	string3 LienJudgmentCount {xpath('LienJudgmentCount')};
	string3 LienJudgmentCount12Month {xpath('LienJudgmentCount12Month')};
	string3 LienJudgmentSmallClaimsCount {xpath('LienJudgmentSmallClaimsCount')};
	string3 LienJudgmentCourtCount {xpath('LienJudgmentCourtCount')};
	string3 LienJudgmentTaxCount {xpath('LienJudgmentTaxCount')};
	string3 LienJudgmentForeclosureCount {xpath('LienJudgmentForeclosureCount')};
	string3 LienJudgmentOtherCount {xpath('LienJudgmentOtherCount')};
	string2 LienJudgmentTimeNewest {xpath('LienJudgmentTimeNewest')};
	string7 LienJudgmentDollarTotal {xpath('LienJudgmentDollarTotal')};
end;
		
export t_BankruptcyRecordsAttributesV2 := record
	string3 BankruptcyCount {xpath('BankruptcyCount')};
	string3 BankruptcyCount24Month {xpath('BankruptcyCount24Month')};
	string3 BankruptcyTimeNewest {xpath('BankruptcyTimeNewest')};
	string2 BankruptcyChapter {xpath('BankruptcyChapter')};
	string2 BankruptcyStatus {xpath('BankruptcyStatus')};
	string2 BankruptcyDismissed24Month {xpath('BankruptcyDismissed24Month')};
end;
		
export t_ShortTermLoanSolicitationRecordsAttributesV2 := record
	string2 ShortTermLoanRequest {xpath('ShortTermLoanRequest')};
	string2 ShortTermLoanRequest12Month {xpath('ShortTermLoanRequest12Month')};
	string2 ShortTermLoanRequest24Month {xpath('ShortTermLoanRequest24Month')};
end;
		
export t_InquiryActivityAttributesV2 := record
	string2 InquiryAuto12Month {xpath('InquiryAuto12Month')};
	string2 InquiryBanking12Month {xpath('InquiryBanking12Month')};
	string2 InquiryTelcom12Month {xpath('InquiryTelcom12Month')};
	string2 InquiryNonShortTerm12Month {xpath('InquiryNonShortTerm12Month')};
	string2 InquiryShortTerm12Month {xpath('InquiryShortTerm12Month')};
	string2 InquiryCollections12Month {xpath('InquiryCollections12Month')};
end;
		
export t_ConsumerAlertAttributesV2 := record
	string1 AlertRegulatoryCondition {xpath('AlertRegulatoryCondition')};
end;
		
export t_LiensAndJudgmentsReportAttributesV2 := record
	string2 LnJEvictionTimeNewest {xpath('LnJEvictionTimeNewest')};
	string3 LnJEvictionTotalCount {xpath('LnJEvictionTotalCount')};
	string3 LnJEvictionTotalCount12Month {xpath('LnJEvictionTotalCount12Month')};
	string3 LnJJudgmentCount {xpath('LnJJudgmentCount')};
	string3 LnJJudgmentCourtCount {xpath('LnJJudgmentCourtCount')};
	string7 LnJJudgmentDollarTotal {xpath('LnJJudgmentDollarTotal')};
	string3 LnJJudgmentForeclosureCount {xpath('LnJJudgmentForeclosureCount')};
	string3 LnJJudgmentSmallClaimsCount {xpath('LnJJudgmentSmallClaimsCount')};
	string2 LnJJudgementTimeNewest {xpath('LnJJudgementTimeNewest')};
	string3 LnJLienCount {xpath('LnJLienCount')};
	string7 LnJLienDollarTotal {xpath('LnJLienDollarTotal')};
	string3 LnJLienJudgmentCount {xpath('LnJLienJudgmentCount')};
	string3 LnJLienJudgmentCount12Month {xpath('LnJLienJudgmentCount12Month')};
	string7 LnJLienJudgmentDollarTotal {xpath('LnJLienJudgmentDollarTotal')};
	string3 LnJLienJudgmentOtherCount {xpath('LnJLienJudgmentOtherCount')};
	string3 LnJLienJudgmentSeverityIndex {xpath('LnJLienJudgmentSeverityIndex')};
	string2 LnJLienJudgmentTimeNewest {xpath('LnJLienJudgmentTimeNewest')};
	string3 LnJLienTaxCount {xpath('LnJLienTaxCount')};
	string7 LnJLienTaxDollarTotal {xpath('LnJLienTaxDollarTotal')};
	string3 LnJLienTaxFederalCount {xpath('LnJLienTaxFederalCount')};
	string7 LnJLienTaxFederalDollarTotal {xpath('LnJLienTaxFederalDollarTotal')};
	string2 LnJLienTaxFederalTimeNewest {xpath('LnJLienTaxFederalTimeNewest')};
	string3 LnJLienTaxStateCount {xpath('LnJLienTaxStateCount')};
	string7 LnJLienTaxStateDollarTotal {xpath('LnJLienTaxStateDollarTotal')};
	string2 LnJLienTaxStateTimeNewest {xpath('LnJLienTaxStateTimeNewest')};
	string2 LnJLienTimeNewest {xpath('LnJLienTimeNewest')};
	string2 LnJLienTaxTimeNewest {xpath('LnJLienTaxTimeNewest')};
end;
		
export t_FCRAInsurView2Attributes := record
	t_InputDataCheckFlagsAttributesV2 InputDataCheckFlags {xpath('InputDataCheckFlags')};
	t_SubjectSourceAttributesV2 SubjectSource {xpath('SubjectSource')};
	t_SubjectConfirmationAttributesV2 SubjectConfirmation {xpath('SubjectConfirmation')};
	t_SourceRecordActivityAttributesV2 SourceRecordActivity {xpath('SourceRecordActivity')};
	t_SSNCharacteristicsAttributesV2 SSNCharacteristics {xpath('SSNCharacteristics')};
	t_AddressCharacteristicsAttributesV2 AddressCharacteristics {xpath('AddressCharacteristics')};
	t_AddressHistoryAttributesV2 AddressHistory {xpath('AddressHistory')};
	t_PhoneCharacteristicsAttrributesV2 PhoneCharacteristics {xpath('PhoneCharacteristics')};
	t_EducationAttributesV2 Education {xpath('Education')};
	t_BusinessAssociationAttributesV2 BusinessAssociation {xpath('BusinessAssociation')};
	t_ProfessionalLicenseAttributesV2 ProfessionalLicense {xpath('ProfessionalLicense')};
	t_AssetsAttributesV2 Asset {xpath('Asset')};
	t_PurchaseActivityAttributesV2 PurchaseActivity {xpath('PurchaseActivity')};
	t_DerogatoryPublicRecordsAttributesV2 DerogatoryPublicRecords {xpath('DerogatoryPublicRecords')};
	t_CriminalRecordsAttributesV2 CriminalRecords {xpath('CriminalRecords')};
	t_EvictionRecordsAttributesV2 EvictionRecords {xpath('EvictionRecords')};
	t_TaxLienAndCourtJudgmentRecordsAttributesV2 TaxLienAndCourtJudgmentRecords {xpath('TaxLienAndCourtJudgmentRecords')};
	t_BankruptcyRecordsAttributesV2 BankruptcyRecords {xpath('BankruptcyRecords')};
	t_ShortTermLoanSolicitationRecordsAttributesV2 ShortTermLoanSolicitationRecords {xpath('ShortTermLoanSolicitationRecords')};
	t_InquiryActivityAttributesV2 InquiryActivity {xpath('InquiryActivity')};
	t_ConsumerAlertAttributesV2 ConsumerAlert {xpath('ConsumerAlert')};
	t_LiensAndJudgmentsReportAttributesV2 LiensAndJudgmentsReport {xpath('LiensAndJudgmentsReport')};
end;
		
export t_FCRAInsurView2AttributesResult := record
	string12 UniqueId {xpath('UniqueId')};
	t_FCRAInsurView2AttributesSearchBy InputEcho {xpath('InputEcho')};
	t_FCRAInsurView2Attributes InsurView2Attributes {xpath('InsurView2Attributes')};
	dataset(iesp.share_fcra.t_ConsumerStatement) ConsumerStatements {xpath('ConsumerStatements/ConsumerStatement'), MAXCOUNT(iesp.Constants.MAX_CONSUMER_STATEMENTS)};
	iesp.share_fcra.t_FcraConsumer Consumer {xpath('Consumer')};//hidden[__inq_hislogging__]
end;
		
export t_FCRAInsurView2AttributesResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	t_FCRAInsurView2AttributesResult Result {xpath('Result')};
end;
		
export t_FCRAInsurView2AttributesRequest := record (iesp.share.t_BaseRequest)
	t_FCRAInsurView2AttributesOptions Options {xpath('Options')};
	t_FCRAInsurView2AttributesSearchBy SearchBy {xpath('SearchBy')};
	t_Iv2TransactionContext TransactionContext {xpath('TransactionContext')};//hidden[ecl_only]
end;
		
export t_FCRAInsurView2AttributesResponseEx := record
	t_FCRAInsurView2AttributesResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from fcrainsurview2attributes.xml. ***/
/*===================================================*/

