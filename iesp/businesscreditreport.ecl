﻿/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from businesscreditreport.xml. ***/
/*===================================================*/

import iesp;

export businesscreditreport := MODULE
			
export t_BusinessCreditReportCompany := record
	iesp.share.t_BusinessIdentity BusinessIds {xpath('BusinessIds')};
	string120 CompanyName {xpath('CompanyName')};
	iesp.share.t_Address Address {xpath('Address')};
	unsigned2 Radius {xpath('Radius')};
	string10 Phone10 {xpath('Phone10')};
	string11 TIN {xpath('TIN')};
	string100 URL {xpath('URL')};
	string100 Email {xpath('Email')};
end;
		
export t_BusinessCreditReportAuthRep := record
	string12 UniqueId {xpath('UniqueId')};
	string11 SSN {xpath('SSN')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	string10 Phone10 {xpath('Phone10')};
	iesp.share.t_Date DOB {xpath('DOB')};
	string50 DLNumber {xpath('DLNumber')};
	string2 DLState {xpath('DLState')};
end;
		
export t_BusinessCreditBestInformation := record
	iesp.share.t_BusinessIdentity BusinessIds {xpath('BusinessIds')};
	string120 CompanyName {xpath('CompanyName')};
	iesp.share.t_Address CompanyAddress {xpath('CompanyAddress')};
	string11 TIN {xpath('TIN')};
	string2 TINSource {xpath('TINSource')};
	string10 CompanyPhone {xpath('CompanyPhone')};
	string12 UniqueId {xpath('UniqueId')};
	iesp.share.t_Name AuthRepName {xpath('AuthRepName')};
	iesp.share.t_Address AuthRepAddress {xpath('AuthRepAddress')};
	string11 AuthRepSSN {xpath('AuthRepSSN')};
	string10 AuthRepPhone {xpath('AuthRepPhone')};
	iesp.share.t_Date RecentTradeDate {xpath('RecentTradeDate')};
	iesp.share.t_Date EstablishedDate {xpath('EstablishedDate')};
	string15 AnnualIncome {xpath('AnnualIncome')};
	string10 NoOfEmployees {xpath('NoOfEmployees')};
	string8 PrimaryIndustryCode {xpath('PrimaryIndustryCode')};
	string100 PrimaryIndustryDescription {xpath('PrimaryIndustryDescription')};
	string60 BusinessType {xpath('BusinessType')};
	string120 ParentCompanyName {xpath('ParentCompanyName')};
	string60 SOSActiveIndicator {xpath('SOSActiveIndicator')};
	unsigned1 BusinessCreditIndicator {xpath('BusinessCreditIndicator')};
end;
		
export t_BusinessCreditScoreReason := record
	integer Sequence {xpath('Sequence')};
	string6 ReasonCode {xpath('ReasonCode')};
	string100 Description {xpath('Description')};
end;
		
export t_BusinessCreditScore := record
	string20 ScoreType {xpath('ScoreType')};
	unsigned2 MinScoreRange {xpath('MinScoreRange')};
	unsigned2 MaxScoreRange {xpath('MaxScoreRange')};
	unsigned2 Score {xpath('Score')};
	string20 ScoreRiskLevel {xpath('ScoreRiskLevel')};
	dataset(t_BusinessCreditScoreReason) ScoreReasons {xpath('ScoreReasons/BusinessCreditScoreReason'), MAXCOUNT(iesp.constants.BusinessCredit.MaxReasons)};
end;
		
export t_BusinessCreditScoring := record
	iesp.share.t_Date DateScored {xpath('DateScored')};
	string1 CurrentPriorFlag {xpath('CurrentPriorFlag')};
	string8 PrimaryIndustryCode {xpath('PrimaryIndustryCode')};
	string100 PrimaryIndustryDescription {xpath('PrimaryIndustryDescription')};
	unsigned2 IndustryScore {xpath('IndustryScore')};
	dataset(t_BusinessCreditScore) Scores {xpath('Scores/BusinessCreditScore'), MAXCOUNT(iesp.constants.BusinessCredit.MaxScores)};
end;
		
export t_BusinessCreditTradeSummary := record
	unsigned2 OpenAccountsCount {xpath('OpenAccountsCount')};
	iesp.share.t_Date AccountOpenDate {xpath('AccountOpenDate')};
	string12 TotalOverdue {xpath('TotalOverdue')};
	string30 MostSevereStatus {xpath('MostSevereStatus')};
	string12 HighestCredit {xpath('HighestCredit')};
	string12 TotalCurrentExposure {xpath('TotalCurrentExposure')};
	string12 MedianBalance {xpath('MedianBalance')};
	string12 AvgOpenBalance {xpath('AvgOpenBalance')};
	unsigned2 ChargeOffRecorded {xpath('ChargeOffRecorded')};
	unsigned2 AccountsWithGuarantor {xpath('AccountsWithGuarantor')};
end;
		
export t_BusinessCreditPaymentSummary := record
	string12 TotalCurrentExposure {xpath('TotalCurrentExposure')};
	string3 WithinTermsPercent {xpath('WithinTermsPercent')};
	string3 PastDueAgingAmount01to30Percent {xpath('PastDueAgingAmount01to30Percent')};
	string3 PastDueAgingAmount31to60Percent {xpath('PastDueAgingAmount31to60Percent')};
	string3 PastDueAgingAmount61to90Percent {xpath('PastDueAgingAmount61to90Percent')};
	string3 PastDueAgingAmount91PlusPercent {xpath('PastDueAgingAmount91PlusPercent')};
end;
		
export t_BusinessYearlyCreditUtilized := record
	string4 Year {xpath('Year')};
	string3 AvgCreditUtilizedPercent {xpath('AvgCreditUtilizedPercent')};
	string12 HighestCreditLimitOfYear {xpath('HighestCreditLimitOfYear')};
	string12 HighestOutstandingAmountOfYear {xpath('HighestOutstandingAmountOfYear')};
end;
		
export t_BusinessCreditAccountPaymentHistory := record
	iesp.share.t_Date ReportedDate {xpath('ReportedDate')};
	iesp.share.t_Date ClosureDate {xpath('ClosureDate')};
	string100 ClosureReason {xpath('ClosureReason')};
	string12 CurrentCreditLimit {xpath('CurrentCreditLimit')};
	string12 AmountOutstanding {xpath('AmountOutstanding')};
	string25 PaymentStatus {xpath('PaymentStatus')};
	string12 PastDueAmount {xpath('PastDueAmount')};
	boolean IsExtendedOverdue {xpath('IsExtendedOverdue')};
end;
		
export t_BusinessCreditAccountDetail := record
	string30 BusinessContributorNumber {xpath('BusinessContributorNumber')};//hidden[internal]
	string50 BusinessAccountNumber {xpath('BusinessAccountNumber')};//hidden[internal]
	string30 AccountStatus {xpath('AccountStatus')};
	string3 AccountTypeReportedCode {xpath('AccountTypeReportedCode')};
	string100 AccountTypeReportedDesc {xpath('AccountTypeReportedDesc')};
	iesp.share.t_Date AccountOpenDate {xpath('AccountOpenDate')};
	iesp.share.t_Date AccountReportedDate {xpath('AccountReportedDate')};
	iesp.share.t_Date AccountClosureDate {xpath('AccountClosureDate')};
	string100 AccountClosureReason {xpath('AccountClosureReason')};
	string12 OriginalAmount {xpath('OriginalAmount')};
	string12 AmountOutstanding {xpath('AmountOutstanding')};
	boolean CollateralIndicator {xpath('CollateralIndicator')};
	string50 TypeOfCollateral {xpath('TypeOfCollateral')};
	string20 Overdue {xpath('Overdue')};
	string12 PastDueAmount {xpath('PastDueAmount')};
	iesp.share.t_Date AccountExpirationDate {xpath('AccountExpirationDate')};
	string12 PaymentAmountScheduled {xpath('PaymentAmountScheduled')};
	string20 PaymentFrequency {xpath('PaymentFrequency')};
	string3 PaymentTypeCode {xpath('PaymentTypeCode')};
	string100 PaymentTypeDesc {xpath('PaymentTypeDesc')};
	string12 LastPaymentAmount {xpath('LastPaymentAmount')};
	iesp.share.t_Date LastPaymentDate {xpath('LastPaymentDate')};
	iesp.share.t_Date DelinquencyDate {xpath('DelinquencyDate')};
	boolean GovernmentGuaranteed {xpath('GovernmentGuaranteed')};
	string50 GovernmentGuaranteedCategory {xpath('GovernmentGuaranteedCategory')};
	string2 NumberOfGuarantors {xpath('NumberOfGuarantors')};
	dataset(t_BusinessYearlyCreditUtilized) YearlyCreditUtils {xpath('YearlyCreditUtils/BusinessYearlyCreditUtilized'), MAXCOUNT(iesp.constants.BusinessCredit.MaxSection)};
	dataset(t_BusinessCreditAccountPaymentHistory) AccountPaymentHistory {xpath('AccountPaymentHistory/BusinessCreditAccountPaymentHistory'), MAXCOUNT(iesp.constants.BusinessCredit.MaxPaymentHistory)};
	unsigned8 UniqueAccountDetailNumber {xpath('UniqueAccountDetailNumber')};
	string1 ChargedOff {xpath('ChargedOff')};
	string25 PaymentStatus {xpath('PaymentStatus')};
	iesp.share.t_Date ChargedOffDate {xpath('ChargedOffDate')};
	string12 ChargedOffAmount {xpath('ChargedOffAmount')};
	iesp.share.t_CodeMap ChargedOffType {xpath('ChargedOffType')};
	string12 TotalChargedOffRecoveries {xpath('TotalChargedOffRecoveries')};
	string1 ContributedByInquirer {xpath('ContributedByInquirer')};
end;
		
export t_BusinessCreditUtilized := record
	string12 CreditLimit {xpath('CreditLimit')};
	string12 CreditUtilized {xpath('CreditUtilized')};
	string12 AvailableCredit {xpath('AvailableCredit')};
	string3 CreditUtilizedPercent {xpath('CreditUtilizedPercent')};
	string1 CurrentPriorFlag {xpath('CurrentPriorFlag')};
	iesp.share.t_Date ScoreCalculatedDate {xpath('ScoreCalculatedDate')};
end;
		
export t_BusinessCreditDBT := record
	iesp.share.t_Date DBTCalculatedDate {xpath('DBTCalculatedDate')};
	unsigned2 DBTMinRange {xpath('DBTMinRange')};
	unsigned2 DBTMaxRange {xpath('DBTMaxRange')};
	string3 DBT {xpath('DBT')};
	string1 CurrentPriorFlag {xpath('CurrentPriorFlag')};
	string4 PriorYear {xpath('PriorYear')};
	string3 PriorYearDBTAverage {xpath('PriorYearDBTAverage')};
	string8 PrimaryIndustryCode {xpath('PrimaryIndustryCode')};
	string100 PrimaryIndustryDescription {xpath('PrimaryIndustryDescription')};
	string3 IndustryDBTAverage {xpath('IndustryDBTAverage')};
end;
		
export t_BusinessCreditInquiry := record
	string8 PrimaryIndustryCode {xpath('PrimaryIndustryCode')};
	string100 PrimaryIndustryDescription {xpath('PrimaryIndustryDescription')};
	unsigned2 TotalInquiryCount {xpath('TotalInquiryCount')};
	unsigned2 InquiryCount03Month {xpath('InquiryCount03Month')};
	unsigned2 InquiryCount06Month {xpath('InquiryCount06Month')};
	unsigned2 InquiryCount09Month {xpath('InquiryCount09Month')};
	unsigned2 InquiryCount12Month {xpath('InquiryCount12Month')};
end;
		
export t_BusinessCreditSubsidiary := record
	iesp.share.t_BusinessIdentity BusinessIds {xpath('BusinessIds')};
	string120 CompanyName {xpath('CompanyName')};
	string30 RelationType {xpath('RelationType')};
	unsigned1 BusinessCreditIndicator {xpath('BusinessCreditIndicator')};
end;
		
export t_BusinessCreditAccountDetails := record
	iesp.share.t_BusinessIdentity BusinessIds {xpath('BusinessIds')};
	string120 CompanyName {xpath('CompanyName')};
	string30 BusinessContributorNumber {xpath('BusinessContributorNumber')};//hidden[internal]
	string50 BusinessAccountNumber {xpath('BusinessAccountNumber')};//hidden[internal]
	string3 AccountTypeReportedCode {xpath('AccountTypeReportedCode')};
	string100 AccountTypeReportedDesc {xpath('AccountTypeReportedDesc')};
	string30 AccountStatus {xpath('AccountStatus')};
	iesp.share.t_Date AccountOpenDate {xpath('AccountOpenDate')};
	string12 OriginalAmount {xpath('OriginalAmount')};
	string12 AmountOutstanding {xpath('AmountOutstanding')};
	string20 Overdue {xpath('Overdue')};
	string12 PastDueAmount {xpath('PastDueAmount')};
	unsigned1 BusinessCreditIndicator {xpath('BusinessCreditIndicator')};
	dataset(t_BusinessCreditAccountPaymentHistory) AccountPaymentHistory {xpath('AccountPaymentHistory/BusinessCreditAccountPaymentHistory'), MAXCOUNT(iesp.constants.BusinessCredit.MaxPaymentHistory)};
end;
		
export t_BusinessCreditOwnerGuarantor := record
	iesp.share.t_BusinessIdentity BusinessIds {xpath('BusinessIds')};
	string12 UniqueId {xpath('UniqueId')};
	iesp.share.t_NameAndCompany EntityName {xpath('EntityName')};
	string10 EntityType {xpath('EntityType')};
	iesp.share.t_Address EntityAddress {xpath('EntityAddress')};
	string10 OwnerGuarantorIndicator {xpath('OwnerGuarantorIndicator')};
	string3 OwnershipPercent {xpath('OwnershipPercent')};
	unsigned1 BusinessCreditIndicator {xpath('BusinessCreditIndicator')};
	dataset(t_BusinessCreditAccountDetails) AccountDetails {xpath('AccountDetails/BusinessCreditAccountDetails'), MAXCOUNT(iesp.constants.BusinessCredit.MaxSection)};
	dataset(t_BusinessCreditAccountDetails) RelatedAccountDetails {xpath('RelatedAccountDetails/BusinessCreditAccountDetails'), MAXCOUNT(iesp.constants.BusinessCredit.MaxSection)};
end;
		
export t_BusinessCreditParentSection := record
	iesp.share.t_BusinessIdentity BusinessIds {xpath('BusinessIds')};
	string120 CompanyName {xpath('CompanyName')};
	iesp.share.t_Address Address {xpath('Address')};
	iesp.share.t_PhoneInfo PhoneInfo {xpath('PhoneInfo')};
	unsigned1 BusinessCreditIndicator {xpath('BusinessCreditIndicator')};
end;
		
export t_BusinessCreditConnectedBusiness := record
	iesp.share.t_BusinessIdentity BusinessIds {xpath('BusinessIds')};
	string120 CompanyName {xpath('CompanyName')};
	iesp.share.t_Address Address {xpath('Address')};
	string9 TIN {xpath('TIN')};
	string2 TINSource {xpath('TINSource')};
	unsigned1 BusinessCreditIndicator {xpath('BusinessCreditIndicator')};
end;
		
export t_BusinessCreditConnectedBusinessSection := record
	integer CountConnectedBusinesses {xpath('CountConnectedBusinesses')};
	integer TotalCountConnectedBusinesses {xpath('TotalCountConnectedBusinesses')};
	dataset(t_BusinessCreditConnectedBusiness) ConnectedBusinessRecords {xpath('ConnectedBusinessRecords/ConnectedBusinessRecord'), MAXCOUNT(iesp.constants.TOPBUSINESS.MAX_COUNT_CONNECTED_BUSINESSES)};
end;
		
export t_BusinessCreditContactSection := record
	integer2 CurrentExecutiveCount {xpath('CurrentExecutiveCount')};
	integer2 TotalCurrentExecutiveCount {xpath('TotalCurrentExecutiveCount')};
	dataset(iesp.topbusinessreport.t_TopBusinessIndividual) CurrentExecutives {xpath('CurrentExecutives/Individual'), MAXCOUNT(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_CONTACT_RECORDS)};
	dataset(iesp.topbusiness_share.t_TopBusinessSourceDocInfo) CurrentSourceDocs {xpath('CurrentSourceDocs/SourceDoc'), MAXCOUNT(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS)};
	integer2 PriorExecutiveCount {xpath('PriorExecutiveCount')};
	integer2 TotalPriorExecutiveCount {xpath('TotalPriorExecutiveCount')};
	dataset(iesp.topbusinessreport.t_TopBusinessIndividual) PriorExecutives {xpath('PriorExecutives/Individual'), MAXCOUNT(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_CONTACT_RECORDS)};
end;
		
export t_BusinessCreditTopBusinessRecord := record
	iesp.topbusinessreport.t_TopBusinessBankruptcySection BankruptcySection {xpath('BankruptcySection')};
	iesp.topbusinessreport.t_TopBusinessLienSection LienSection {xpath('LienSection')};
	iesp.topbusinessreport.t_TopBusinessUCCSection UCCSection {xpath('UCCSection')};
	iesp.topbusinessreport.t_TopBusinessPropertySection PropertySection {xpath('PropertySection')};
	iesp.topbusinessreport.t_TopBusinessMotorVehicleSection MotorVehicleSection {xpath('MotorVehicleSection')};
	iesp.topbusinessreport.t_TopBusinessWatercraftSection WatercraftSection {xpath('WatercraftSection')};
	iesp.topbusinessreport.t_TopBusinessAircraftSection AircraftSection {xpath('AircraftSection')};
	iesp.topbusinessreport.t_TopBusinessLicenseSection LicenseSection {xpath('LicenseSection')};
	iesp.topbusinessreport.t_TopBusinessIncorporationSection IncorporationSection {xpath('IncorporationSection')};
	iesp.topbusinessreport.t_TopBusinessOperationsSitesSection OperationsSitesSection {xpath('OperationsSitesSection')};
	t_BusinessCreditParentSection ParentSection {xpath('ParentSection')};
	t_BusinessCreditConnectedBusinessSection ConnectedBusinessSection {xpath('ConnectedBusinessSection')};
	t_BusinessCreditContactSection ContactSection {xpath('ContactSection')};
end;
		
export t_BusinessCreditCodeDescription := record
	string8 Code {xpath('Code')};
	string100 Description {xpath('Description')};
	boolean IsPrimary {xpath('IsPrimary')};
end;
		
export t_BusinessCreditActivity := record
	dataset(t_BusinessCreditCodeDescription) SicCodes {xpath('SicCodes/BusinessCreditCodeDescription'), MAXCOUNT(iesp.constants.BusinessCredit.MaxCodes)};
	dataset(t_BusinessCreditCodeDescription) NaicsCodes {xpath('NaicsCodes/BusinessCreditCodeDescription'), MAXCOUNT(iesp.constants.BusinessCredit.MaxCodes)};
end;
		
export t_BusinessCreditAdditionalInfo := record
	dataset(iesp.topbusinessreport.t_TopBusinessBestOtherCompany) CompanyNameVariations {xpath('CompanyNameVariations/TopBusinessBestOtherCompany'), MAXCOUNT(iesp.constants.BusinessCredit.MaxVariation)};
	iesp.share.t_Address MailingAddress {xpath('MailingAddress')};
	string10 PhoneNumber {xpath('PhoneNumber')};
	string100 CompanyURL {xpath('CompanyURL')};
end;
		
export t_BusinessCreditPhoneSources := record
	string2 Source {xpath('Source')};
	iesp.share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	iesp.share.t_Date DateLastSeen {xpath('DateLastSeen')};
	unsigned4 RecordCount {xpath('RecordCount')};
end;
		
export t_BusinessCreditMatch := record
	string120 CompanyName {xpath('CompanyName')};
	string9 TIN {xpath('TIN')};
	string10 CompanyPhone {xpath('CompanyPhone')};
	iesp.share.t_Address Address {xpath('Address')};
end;
		
export t_BusinessCreditReportRecord := record
	t_BusinessCreditBestInformation BestInformation {xpath('BestInformation')};
	dataset(t_BusinessCreditScoring) Scorings {xpath('Scorings/BusinessCreditScoring'), MAXCOUNT(iesp.constants.BusinessCredit.MaxSection)};
	t_BusinessCreditTradeSummary TradeSummary {xpath('TradeSummary')};
	t_BusinessCreditPaymentSummary PaymentSummary {xpath('PaymentSummary')};
	dataset(t_BusinessCreditAccountDetail) AccountDetail {xpath('AccountDetail/BusinessCreditAccountDetail'), MAXCOUNT(iesp.constants.BusinessCredit.MaxSection)};
	unsigned2 TotalAccountDetailCount {xpath('TotalAccountDetailCount')};
	dataset(t_BusinessCreditUtilized) CreditUtils {xpath('CreditUtils/BusinessCreditUtilized'), MAXCOUNT(iesp.constants.BusinessCredit.MaxSection)};
	dataset(t_BusinessCreditDBT) DBTs {xpath('DBTs/BusinessCreditDBT'), MAXCOUNT(iesp.constants.BusinessCredit.MaxSection)};
	dataset(t_BusinessCreditInquiry) Inquiries {xpath('Inquiries/BusinessCreditInquiry'), MAXCOUNT(iesp.constants.BusinessCredit.MaxSection)};
	dataset(t_BusinessCreditSubsidiary) Subsidiaries {xpath('Subsidiaries/BusinessCreditSubsidiary'), MAXCOUNT(iesp.constants.BusinessCredit.MaxSection)};
	dataset(t_BusinessCreditOwnerGuarantor) OwnerGuarantors {xpath('OwnerGuarantors/BusinessCreditOwnerGuarantor'), MAXCOUNT(iesp.constants.BusinessCredit.MaxSection)};
	t_BusinessCreditTopBusinessRecord TopBusinessRecord {xpath('TopBusinessRecord')};
	t_BusinessCreditActivity Activity {xpath('Activity')};
	t_BusinessCreditAdditionalInfo AdditionalInfo {xpath('AdditionalInfo')};
	dataset(t_BusinessCreditPhoneSources) PhoneSources {xpath('PhoneSources/BusinessCreditPhoneSources'), MAXCOUNT(iesp.constants.BusinessCredit.MaxSection)};
	t_BusinessCreditMatch MatchReason {xpath('MatchReason')};
end;
		
export t_BusinessCreditReportOption := record (iesp.share.t_BaseReportOption)
	boolean IncludeBusinessCredit {xpath('IncludeBusinessCredit')};
	boolean LimitPaymentHistory24Months {xpath('LimitPaymentHistory24Months')};
	string ContributorIds {xpath('ContributorIds')};//hidden[internal]
end;
		
export t_BusinessCreditReportBy := record
	t_BusinessCreditReportCompany Company {xpath('Company')};
	t_BusinessCreditReportAuthRep AuthorizedRep {xpath('AuthorizedRep')};
end;
		
export t_BusinessCreditReportResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	t_BusinessCreditReportBy InputEcho {xpath('InputEcho')};
	dataset(t_BusinessCreditReportRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.Constants.TOPBUSINESS.MAX_COUNT_REPORT_RESPONSE_RECORDS)};
end;
		
export t_BusinessCreditReportRequest := record (iesp.share.t_BaseRequest)
	t_BusinessCreditReportOption Options {xpath('Options')};
	t_BusinessCreditReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_BusinessCreditReportResponseEx := record
	t_BusinessCreditReportResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from businesscreditreport.xml. ***/
/*===================================================*/

