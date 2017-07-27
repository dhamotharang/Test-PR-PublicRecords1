/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from bankruptcy.xml. ***/
/*===================================================*/

import iesp;
export bankruptcy := MODULE
			
export t_BankruptcyInfo := record
	string CourtLocation {xpath('CourtLocation')};
	string CourtCode {xpath('CourtCode')};
	string CaseNumber {xpath('CaseNumber')};
	string FilingType {xpath('FilingType')};
	string FilingStatus {xpath('FilingStatus')};
	iesp.share.t_Date FilingDate {xpath('FilingDate')};
	iesp.share.t_Date DischargeDate {xpath('DischargeDate')};
end;
		
export t_TrusteeAddress := record
	string PrimRange {xpath('PrimRange')};
	string PreDir {xpath('PreDir')};
	string PrimName {xpath('PrimName')};
	string AddrSuffix {xpath('AddrSuffix')};
	string PostDir {xpath('PostDir')};
	string UnitDesig {xpath('UnitDesig')};
	string SecRange {xpath('SecRange')};
	string PCityName {xpath('PCityName')};
	string VCityName {xpath('VCityName')};
	string State {xpath('State')};
	string Zip {xpath('Zip')};
	string Zip4 {xpath('Zip4')};
	string County {xpath('County')};
end;
		
export t_BankruptcySearchOption := record (iesp.share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean IncludeCriminalIndicators {xpath('IncludeCriminalIndicators')};//hidden[internal]
end;
		
export t_BankruptcyCaseNumberKey := record
	string CourtStateCode {xpath('CourtStateCode')};
	string CaseNumber {xpath('CaseNumber')};
end;
		
export t_BankruptcySearchBy := record
	string SSN {xpath('SSN')};
	t_BankruptcyCaseNumberKey CaseNumberKey {xpath('CaseNumberKey')};
	string CompanyName {xpath('CompanyName')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
end;
		
export t_BankruptcySearchDebtor := record (iesp.share.t_CriminalIndicators)
	string9 SSN {xpath('SSN')};
	dataset(iesp.share.t_NameAndCompany) Names {xpath('Names/Name'), MAXCOUNT(iesp.constants.BANKRPT.MaxPersonNames)};
	dataset(iesp.share.t_Address) Addresses {xpath('Addresses/Address'), MAXCOUNT(iesp.constants.BANKRPT.MaxPersonAddresses)};
end;
		
export t_BankruptcySearchRecord := record
	string50 ExternalKey {xpath('ExternalKey')};
	dataset(t_BankruptcySearchDebtor) Debtors {xpath('Debtors/Debtor'), MAXCOUNT(iesp.constants.BANKRPT.MaxDebtors)};
	string7 CaseNumber {xpath('CaseNumber')};
	string40 CourtLocation {xpath('CourtLocation')};
	string5 CourtCode {xpath('CourtCode')};
	string3 Chapter {xpath('Chapter')};
	iesp.share.t_Date FilingDate {xpath('FilingDate')};
	string10 FilerType {xpath('FilerType')};
	string1 CorpFlag {xpath('CorpFlag')};
	string12 FilingStatus {xpath('FilingStatus')};
	string10 FilingType {xpath('FilingType')};
end;
		
export t_BankruptcySearchResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_BankruptcySearchRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.constants.BANKRPT.MaxCountSearch)};
end;
		
export t_BankruptcyReportBy := record
	string5 CourtCode {xpath('CourtCode')};
	string7 CaseNumber {xpath('CaseNumber')};
end;
		
export t_BankruptcyReportOption := record (iesp.share.t_BaseReportOption)
	boolean IncludeCriminalIndicators {xpath('IncludeCriminalIndicators')};//hidden[internal]
end;
		
export t_BankruptcyPerson := record (iesp.share.t_CriminalIndicators)
	string60 Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	string10 Phone10 {xpath('Phone10')};
	string10 Fax {xpath('Fax')};
	string50 EMail {xpath('EMail')};
end;
		
export t_BankruptcyDebtor := record (iesp.share.t_CriminalIndicators)
	string9 SSN {xpath('SSN')};
	dataset(iesp.share.t_NameAndCompany) Names {xpath('Names/Name'), MAXCOUNT(iesp.Constants.BANKRPT.MaxPersonNames)};
	dataset(iesp.share.t_Address) Addresses {xpath('Addresses/Address'), MAXCOUNT(iesp.Constants.BANKRPT.MaxPersonAddresses)};
end;
		
export t_BankruptcyMeeting := record
	iesp.share.t_Date Date {xpath('Date')};
	string8 Time {xpath('Time')};
	iesp.share.t_Address Address {xpath('Address')};
end;
		
export t_Bankruptcy2Meeting := record
	iesp.share.t_Date Date {xpath('Date')};
	string8 Time {xpath('Time')};
	string90 Address {xpath('Address')};
end;
		
export t_BankruptcyReportRecord := record
	string50 CourtName {xpath('CourtName')};
	string5 CourtCode {xpath('CourtCode')};
	string35 JudgeName {xpath('JudgeName')};
	string7 CaseNumber {xpath('CaseNumber')};
	string25 OriginalCaseNumber {xpath('OriginalCaseNumber')};
	string3 Chapter {xpath('Chapter')};
	string3 OriginalChapter {xpath('OriginalChapter')};
	string12 FilingStatus {xpath('FilingStatus')};
	iesp.share.t_Date FilingDate {xpath('FilingDate')};
	iesp.share.t_Date OriginalFilingDate {xpath('OriginalFilingDate')};
	iesp.share.t_Date DischargeDate {xpath('DischargeDate')};
	string35 Disposition {xpath('Disposition')};
	string10 FilingType {xpath('FilingType')};
	string10 FilerType {xpath('FilerType')};
	boolean SelfRepresented {xpath('SelfRepresented')};
	boolean AssetsForUnsecured {xpath('AssetsForUnsecured')};
	string20 Liabilities {xpath('Liabilities')};
	string20 Assets {xpath('Assets')};
	string5 Exempt {xpath('Exempt')};
	dataset(t_BankruptcyDebtor) Debtors {xpath('Debtors/Debtor'), MAXCOUNT(iesp.Constants.BANKRPT.MaxDebtors)};
	dataset(t_BankruptcyPerson) Attorneys {xpath('Attorneys/Attorney'), MAXCOUNT(2)};
	dataset(t_BankruptcyPerson) Trustees {xpath('Trustees/Trustee'), MAXCOUNT(1)};
	t_BankruptcyMeeting Meeting {xpath('Meeting')};
	iesp.share.t_Date ComplaintDeadline {xpath('ComplaintDeadline')};
	iesp.share.t_Date ClaimsDeadline {xpath('ClaimsDeadline')};
end;
		
export t_BankruptcyReportResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	dataset(t_BankruptcyReportRecord) BankruptcyReportRecords {xpath('BankruptcyReportRecords/BankruptcyReportRecord'), MAXCOUNT(iesp.Constants.BANKRPT.MaxCountReport)};
end;
		
export t_BankruptcySearch2Option := record (iesp.share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean UseNicknames {xpath('UseNicknames')};
	boolean IncludeAlsoFound {xpath('IncludeAlsoFound')};
	boolean UsePhonetics {xpath('UsePhonetics')};
	boolean IncludeBankruptcies {xpath('IncludeBankruptcies')};//hidden[nofocus]
	boolean IncludeLiensJudgments {xpath('IncludeLiensJudgments')};//hidden[nofocus]
	boolean IncludeCriminalIndicators {xpath('IncludeCriminalIndicators')};//hidden[internal]
	boolean IncludeAttorneyTrustee {xpath('IncludeAttorneyTrustee')};//hidden[internal]
	string1 BusinessIdFetchLevel {xpath('BusinessIdFetchLevel')}; //values['S','D','E','W','P','O','U','','']//hidden[internal]
end;
		
export t_BankruptcySearch2By := record (iesp.share.t_BaseSearchBy)
	string TaxId {xpath('TaxId')};
	string SSN {xpath('SSN')};
	string CaseNumber {xpath('CaseNumber')};
	string CompanyName {xpath('CompanyName')};
	string FilingJurisdiction {xpath('FilingJurisdiction')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	string PartyType {xpath('PartyType')}; //values['','D','A','T','']
	string12 UniqueId {xpath('UniqueId')};
	iesp.share.t_BusinessIdentity BusinessIds {xpath('BusinessIds')};//hidden[internal]
end;
		
export t_BankruptcySearch2Name := record (iesp.share.t_NameAndCompany)
	string2 _Type {xpath('Type')};
end;
		
export t_BankruptcySearch2Debtor := record (iesp.share.t_CriminalIndicators)
	string9 TaxId {xpath('TaxId')};
	string9 AppendedTaxId {xpath('AppendedTaxId')};
	string12 UniqueId {xpath('UniqueId')};
	string12 BusinessId {xpath('BusinessId')};
	string9 SSN {xpath('SSN')};
	string9 AppendedSSN {xpath('AppendedSSN')};
	dataset(t_BankruptcySearch2Name) Names {xpath('Names/Name'), MAXCOUNT(iesp.Constants.BANKRPT.MaxPersonNames)};
	dataset(iesp.share.t_Address) Addresses {xpath('Addresses/Address'), MAXCOUNT(iesp.Constants.BANKRPT.MaxPersonAddresses)};
	dataset(iesp.share.t_PhoneTimeZone) Phones {xpath('Phones/Phone'), MAXCOUNT(iesp.Constants.BANKRPT.MaxPersonPhones)};
end;
		
export t_BankruptcyMatchedParty2 := record
	string PartyType {xpath('PartyType')};
	string OriginName {xpath('OriginName')};
	t_BankruptcySearch2Name ParsedParty {xpath('ParsedParty')};
	iesp.share.t_AddressWithRawInfo Address {xpath('Address')};
end;
		
export t_BankruptcyPerson2 := record (iesp.share.t_CriminalIndicators)
	iesp.share.t_BusinessIdentity BusinessIds {xpath('BusinessIds')};
	string100 IdValue {xpath('IdValue')};
	dataset(t_BankruptcySearch2Name) Names {xpath('Names/Name'), MAXCOUNT(iesp.Constants.BANKRPT.MaxPersonNames)};
	dataset(iesp.share.t_Address) Addresses {xpath('Addresses/Address'), MAXCOUNT(iesp.Constants.BANKRPT.MaxPersonAddresses)};
	dataset(iesp.share.t_AddressWithRawInfo) AddressesEx {xpath('AddressesEx/Address'), MAXCOUNT(iesp.Constants.BANKRPT.MaxPersonAddresses)};
	dataset(iesp.share.t_StringArrayItem) Phones {xpath('Phones/Phone10'), MAXCOUNT(iesp.Constants.BANKRPT.MaxPersonPhones)};
	dataset(iesp.share.t_PhoneTimeZone) PhonesEx {xpath('PhonesEx/Phone'), MAXCOUNT(iesp.Constants.BANKRPT.MaxPersonPhones)};
	dataset(iesp.share.t_StringArrayItem) Emails {xpath('Emails/Email'), MAXCOUNT(iesp.Constants.BANKRPT.MaxPersonEmails)};
	string12 UniqueId {xpath('UniqueId')};
	string12 BusinessId {xpath('BusinessId')};
	string9 SSN {xpath('SSN')};
	string9 AppendedSSN {xpath('AppendedSSN')};
	string9 TaxId {xpath('TaxId')};
	string9 AppendedTaxId {xpath('AppendedTaxId')};
end;
		
export t_BankruptcySearch2Record := record
	dataset(t_BankruptcySearch2Debtor) Debtors {xpath('Debtors/Debtor'), MAXCOUNT(iesp.Constants.BANKRPT.MaxDebtors)};
	boolean AlsoFound {xpath('AlsoFound')};
	string50 TMSId {xpath('TMSId')};
	iesp.share.t_MatchedParty MatchedParty {xpath('MatchedParty')};
	t_BankruptcyMatchedParty2 MatchedParty2 {xpath('MatchedParty2')};
	string7 CaseNumber {xpath('CaseNumber')};
	string40 CourtLocation {xpath('CourtLocation')};
	string50 CourtName {xpath('CourtName')};
	string3 Chapter {xpath('Chapter')};
	string5 CourtCode {xpath('CourtCode')};
	iesp.share.t_Date OriginalFilingDate {xpath('OriginalFilingDate')};
	string3 OriginalChapter {xpath('OriginalChapter')};
	iesp.share.t_Date FilingDate {xpath('FilingDate')};
	string10 FilerType {xpath('FilerType')};
	string12 FilingStatus {xpath('FilingStatus')};
	string35 Disposition {xpath('Disposition')};
	string10 FilingType {xpath('FilingType')};
	string1 CorpFlag {xpath('CorpFlag')};
	dataset(iesp.share.t_PhoneTimeZone) Phones {xpath('Phones/Phone'), MAXCOUNT(iesp.Constants.BANKRPT.MaxPersonPhones)};
	string50 ExternalKey {xpath('ExternalKey')};
	string40 JudgeInitials {xpath('JudgeInitials')};//hidden[internal]
	string40 Liabilities {xpath('Liabilities')};//hidden[internal]
	string40 Assets {xpath('Assets')};//hidden[internal]
	t_Bankruptcy2Meeting Meeting {xpath('Meeting')};//hidden[internal]
	dataset(t_BankruptcyPerson2) Attorneys {xpath('Attorneys/Attorney'), MAXCOUNT(1)};//hidden[internal]
	dataset(t_BankruptcyPerson2) Trustees {xpath('Trustees/Trustee'), MAXCOUNT(1)};//hidden[internal]
	iesp.share.t_Date DischargeDate {xpath('DischargeDate')};//hidden[internal]
end;
		
export t_BankrupcyLienJudgmentRecord := record
	string RecordType {xpath('RecordType')};
	string RecordDescription {xpath('RecordDescription')};
	t_BankruptcySearch2Record Bankruptcy {xpath('Bankruptcy')};
	iesp.lienjudgement.t_LienJudgmentSearchRecord2 LienJudgment {xpath('LienJudgment')};//hidden[internal]
end;
		
export t_BankruptcySearch2Response := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_BankruptcySearch2Record) Records {xpath('Records/Record'), MAXCOUNT(iesp.Constants.BANKRPT.MaxCountSearch)};
	dataset(t_BankrupcyLienJudgmentRecord) RecordsEx {xpath('RecordsEx/Record'), MAXCOUNT(1)};
end;
		
export t_BkSearch3SortOptions := record
	integer StateSort {xpath('StateSort')};
	integer FileDateSort {xpath('FileDateSort')};
	integer CaseSort {xpath('CaseSort')};
	integer LastNameSort {xpath('LastNameSort')};
	integer CompanyNameSort {xpath('CompanyNameSort')};
end;
		
export t_BankruptcySearch3Option := record (iesp.share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean UseNicknames {xpath('UseNicknames')};
	boolean IncludeAlsoFound {xpath('IncludeAlsoFound')};
	boolean UsePhonetics {xpath('UsePhonetics')};
	t_BkSearch3SortOptions SortOptions {xpath('SortOptions')};
end;
		
export t_BankruptcySearch3By := record (iesp.share.t_BaseSearchBy)
	string TaxId {xpath('TaxId')};
	string SSN {xpath('SSN')};
	string SSNLast4 {xpath('SSNLast4')};
	string CaseNumber {xpath('CaseNumber')};
	string CompanyName {xpath('CompanyName')};
	string FilingJurisdiction {xpath('FilingJurisdiction')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	string PartyType {xpath('PartyType')}; //values['','D','A','T','']
end;
		
export t_BankruptcySearch3Name := record (iesp.share.t_NameAndCompany)
	string _Type {xpath('Type')};
	string DID {xpath('DID')};//hidden[internal]
	string UniqueId {xpath('UniqueId')};
end;
		
export t_BankruptcySearch3Debtor := record
	string TaxId {xpath('TaxId')};
	string AppendedTaxId {xpath('AppendedTaxId')};
	string UniqueId {xpath('UniqueId')};
	string PersonFilterId {xpath('PersonFilterId')};
	string BusinessId {xpath('BusinessId')};
	string SSN {xpath('SSN')};
	string AppendedSSN {xpath('AppendedSSN')};
	string SSNMatch {xpath('SSNMatch')};
	string SSNMSrc {xpath('SSNMSrc')};
	string DebtorType {xpath('DebtorType')};
	string DCodeDesc {xpath('DCodeDesc')};
	string DispType {xpath('DispType')};
	string DispTypeDesc {xpath('DispTypeDesc')};
	string Chapter {xpath('Chapter')};
	iesp.share.t_Date StatusDate {xpath('StatusDate')};
	iesp.share.t_Date DateVacated {xpath('DateVacated')};
	iesp.share.t_Date DateTransferred {xpath('DateTransferred')};
	iesp.share.t_Date ConvertedDate {xpath('ConvertedDate')};
	dataset(t_BankruptcySearch3Name) Names {xpath('Names/Name'), MAXCOUNT(1)};
	dataset(iesp.share.t_Address) Addresses {xpath('Addresses/Address'), MAXCOUNT(1)};
end;
		
export t_Bankruptcy3TrusteeOrigAddress := record
	string OrigAddress {xpath('OrigAddress')};
	string OrigZIP {xpath('OrigZIP')};
	string OrigCity {xpath('OrigCity')};
	string OrigState {xpath('OrigState')};
	string OrigZIP4 {xpath('OrigZIP4')};
end;
		
export t_Bankruptcy3TrusteeName := record
	string Title {xpath('Title')};
	string FirstName {xpath('FirstName')};
	string MiddleName {xpath('MiddleName')};
	string LastName {xpath('LastName')};
	string Suffix {xpath('Suffix')};
	string NameScore {xpath('NameScore')};
	string OrigName {xpath('OrigName')};
end;
		
export t_BankruptcyTrustee := record
	string DID {xpath('DID')};
	string TrusteeId {xpath('TrusteeId')};
	string AppSSN {xpath('AppSSN')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address OrigAddress {xpath('OrigAddress')};
	iesp.share.t_Address Address {xpath('Address')};
	string TrusteePhone {xpath('TrusteePhone')};
	string Phone {xpath('Phone')};
	string Cart {xpath('Cart')};//hidden[internal]
	string CrSortSz {xpath('CrSortSz')};//hidden[internal]
	string Lot {xpath('Lot')};//hidden[internal]
	string LotOrder {xpath('LotOrder')};//hidden[internal]
	integer DBPC {xpath('DBPC')};//hidden[internal]
	integer ChkDigit {xpath('ChkDigit')};//hidden[internal]
	string RecType {xpath('RecType')};//hidden[internal]
end;
		
export t_BankruptcySearch3Record := record
	dataset(t_BankruptcySearch3Debtor) Debtors {xpath('Debtors/Debtor'), MAXCOUNT(1)};
	boolean AlsoFound {xpath('AlsoFound')};
	string TMSId {xpath('TMSId')};
	string ExternalKey {xpath('ExternalKey')};//hidden[internal]
	iesp.share.t_MatchedParty MatchedParty {xpath('MatchedParty')};
	string AssetsForUnsecured {xpath('AssetsForUnsecured')};
	string CaseNumber {xpath('CaseNumber')};
	string CourtLocation {xpath('CourtLocation')};
	string CourtName {xpath('CourtName')};
	string Chapter {xpath('Chapter')};
	string CourtCode {xpath('CourtCode')};
	iesp.share.t_Date OriginalFilingDate {xpath('OriginalFilingDate')};
	string OriginalChapter {xpath('OriginalChapter')};
	iesp.share.t_Date FilingDate {xpath('FilingDate')};
	iesp.share.t_Date ClaimsDeadline {xpath('ClaimsDeadline')};
	string FilerType {xpath('FilerType')};
	string FilingStatus {xpath('FilingStatus')};
	string Disposition {xpath('Disposition')};
	dataset(iesp.share.t_PhoneTimeZone) Phones {xpath('Phones/Phone'), MAXCOUNT(1)};
	string SplitCase {xpath('SplitCase')};
	string FiledInError {xpath('FiledInError')};
	string DateReclosed {xpath('DateReclosed')};
	string CaseId {xpath('CaseId')};
	string BarDate {xpath('BarDate')};
	string TransferIn {xpath('TransferIn')};
	t_BankruptcyTrustee Trustee {xpath('Trustee')};
	boolean HasDocketInfo {xpath('HasDocketInfo')};
end;
		
export t_BankruptcySearch3Response := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_BankruptcySearch3Record) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_BankruptcyReport2By := record
	string12 UniqueId {xpath('UniqueId')};
	string12 BusinessId {xpath('BusinessId')};
	string50 TMSId {xpath('TMSId')};
end;
		
export t_BankruptcyReport2Option := record (t_BankruptcyReportOption)
	boolean IncludeAllBankruptcies {xpath('IncludeAllBankruptcies')};
end;
		
export t_BankruptcyStatus := record
	string30 _Type {xpath('Type')};
	iesp.share.t_Date Date {xpath('Date')};
end;
		
export t_BankruptcyComment := record
	string30 Description {xpath('Description')};
	iesp.share.t_Date FilingDate {xpath('FilingDate')};
end;
		
export t_BankruptcyReport2Debtor := record (t_BankruptcyPerson2)
	string12 CaseId {xpath('CaseId')};
	string12 DefendantId {xpath('DefendantId')};
	string12 RecordId {xpath('RecordId')};
	string1 DefendantType {xpath('DefendantType')}; //values['I','B','']
	string30 OriginalCounty {xpath('OriginalCounty')};
	string1 SSNSource {xpath('SSNSource')};
	string35 SSNSourceDesc {xpath('SSNSourceDesc')};
	string9 SSNMatch {xpath('SSNMatch')};
	string35 SSNMatchDesc {xpath('SSNMatchDesc')};
	string11 SSNMatchSource {xpath('SSNMatchSource')};
	string11 Screen {xpath('Screen')};
	string35 ScreenDesc {xpath('ScreenDesc')};
	string2 DispositionCode {xpath('DispositionCode')};
	string35 DispositionCodeDesc {xpath('DispositionCodeDesc')};
	string3 DispositionType {xpath('DispositionType')};
	string35 DispositionTypeDesc {xpath('DispositionTypeDesc')};
	string3 DispositionReason {xpath('DispositionReason')};
	iesp.share.t_Date StatusDate {xpath('StatusDate')};
	string8 HoldCase {xpath('HoldCase')};
	iesp.share.t_Date DateVacated {xpath('DateVacated')};
	iesp.share.t_Date DateTransferred {xpath('DateTransferred')};
	string12 ActivityReceipt {xpath('ActivityReceipt')};
end;
		
export t_BankruptcyReport2Record := record
	iesp.share.t_BusinessIdentity BusinessIds {xpath('BusinessIds')};
	string100 IdValue {xpath('IdValue')};
	string1 CorpFlag {xpath('CorpFlag')};
	string10 FilingType {xpath('FilingType')};
	string10 FilerType {xpath('FilerType')};
	string2 FilingJurisdiction {xpath('FilingJurisdiction')};
	string1 CaseType {xpath('CaseType')};
	string7 CaseNumber {xpath('CaseNumber')};
	iesp.share.t_Date FilingDate {xpath('FilingDate')};
	iesp.share.t_Date OriginalFilingDate {xpath('OriginalFilingDate')};
	iesp.share.t_Date ClosedDate {xpath('ClosedDate')};
	iesp.share.t_Date ReopenDate {xpath('ReopenDate')};
	iesp.share.t_Date ConvertedDate {xpath('ConvertedDate')};
	string3 Chapter {xpath('Chapter')};
	string3 OriginalChapter {xpath('OriginalChapter')};
	string50 CourtName {xpath('CourtName')};
	string40 CourtLocation {xpath('CourtLocation')};
	string35 JudgeName {xpath('JudgeName')};
	string5 JudgeIdentification {xpath('JudgeIdentification')};
	iesp.share.t_Date ClaimsDeadline {xpath('ClaimsDeadline')};
	iesp.share.t_Date ComplaintDeadline {xpath('ComplaintDeadline')};
	string12 FilingStatus {xpath('FilingStatus')};
	string5 CourtCode {xpath('CourtCode')};
	iesp.share.t_Date DischargeDate {xpath('DischargeDate')};
	string35 Disposition {xpath('Disposition')};
	string20 Liabilities {xpath('Liabilities')};
	string20 Assets {xpath('Assets')};
	t_Bankruptcy2Meeting Meeting {xpath('Meeting')};
	string1 SelfRepresented {xpath('SelfRepresented')}; //values['U','Y','N','']
	string1 AssetsForUnsecured {xpath('AssetsForUnsecured')}; //values['U','Y','N','']
	string1 MethodDismiss {xpath('MethodDismiss')};
	string1 CaseStatus {xpath('CaseStatus')};
	string25 SplitCase {xpath('SplitCase')};
	string FiledInError {xpath('FiledInError')}; //values['U','Y','N','']
	iesp.share.t_Date DateReclosed {xpath('DateReclosed')};
	string12 TrusteeId {xpath('TrusteeId')};
	string12 CaseId {xpath('CaseId')};
	iesp.share.t_Date BarDate {xpath('BarDate')};
	string7 TransferIn {xpath('TransferIn')};
	boolean DeleteFlag {xpath('DeleteFlag')};
	dataset(t_BankruptcyStatus) StatusHistory {xpath('StatusHistory/Status'), MAXCOUNT(iesp.Constants.BANKRPT.MaxStatusHistory)};
	dataset(t_BankruptcyComment) Comments {xpath('Comments/Comment'), MAXCOUNT(iesp.Constants.BANKRPT.MaxComments)};
	dataset(t_BankruptcyReport2Debtor) Debtors {xpath('Debtors/Debtor'), MAXCOUNT(iesp.Constants.BANKRPT.MaxDebtors)};
	dataset(t_BankruptcyPerson2) Attorneys {xpath('Attorneys/Attorney'), MAXCOUNT(2)};
	dataset(t_BankruptcyPerson2) Trustees {xpath('Trustees/Trustee'), MAXCOUNT(1)};
end;
		
export t_BankruptcyReport2Response := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	dataset(t_BankruptcyReport2Record) BankruptcyReportRecords {xpath('BankruptcyReportRecords/BankruptcyReportRecord'), MAXCOUNT(iesp.Constants.BANKRPT.MaxCountReport)};
end;
		
export t_BankruptcyReport3By := record
	string UniqueId {xpath('UniqueId')};
	string BusinessId {xpath('BusinessId')};
	string TMSId {xpath('TMSId')};
	string PersonFilterId {xpath('PersonFilterId')};
end;
		
export t_BankruptcyReport3Name := record (t_BankruptcySearch3Name)
end;
		
export t_BankruptcyReport3Debtor := record
	string BusinessId {xpath('BusinessId')};
	string UniqueId {xpath('UniqueId')};
	string PersonFilterId {xpath('PersonFilterId')};
	string DebtorType {xpath('DebtorType')};
	string SSN {xpath('SSN')};
	string AppendedSSN {xpath('AppendedSSN')};
	string SSNMatch {xpath('SSNMatch')};
	string SSNMSrc {xpath('SSNMSrc')};
	string TaxId {xpath('TaxId')};
	string AppendedTaxId {xpath('AppendedTaxId')};
	string DCodeDesc {xpath('DCodeDesc')};
	string DispTypeDesc {xpath('DispTypeDesc')};
	string Chapter {xpath('Chapter')};
	string Chapter_2 {xpath('Chapter_2')};//hidden[internal]
	iesp.share.t_Date StatusDate {xpath('StatusDate')};
	iesp.share.t_Date DateVacated {xpath('DateVacated')};
	iesp.share.t_Date DateTransferred {xpath('DateTransferred')};
	iesp.share.t_Date ConvertedDate {xpath('ConvertedDate')};
	dataset(t_BankruptcyReport3Name) Names {xpath('Names/Name'), MAXCOUNT(iesp.Constants.BANKRPT.MaxPersonNames)};
	dataset(iesp.share.t_Address) Addresses {xpath('Addresses/Address'), MAXCOUNT(iesp.Constants.BANKRPT.MaxPersonAddresses)};
	dataset(iesp.share.t_PhoneTimeZone) Phones {xpath('Phones/Phone'), MAXCOUNT(iesp.Constants.BANKRPT.MaxPersonPhones)};
end;
		
export t_TrusteeName := record
	string OrigName {xpath('OrigName')};
	string Title {xpath('Title')};
	string FirstName {xpath('FirstName')};
	string MiddleName {xpath('MiddleName')};
	string LastName {xpath('LastName')};
	string Suffix {xpath('Suffix')};
	string NameScore {xpath('NameScore')};
end;
		
export t_TrusteeOrigAddress := record
	string OrigAddress {xpath('OrigAddress')};
	string OrigCity {xpath('OrigCity')};
	string OrigState {xpath('OrigState')};
	string OrigZIP {xpath('OrigZIP')};
	string OrigZIP4 {xpath('OrigZIP4')};
end;
		
export t_Bankruptcy3Trustee := record
	string DID {xpath('DID')};
	string TrusteeId {xpath('TrusteeId')};
	string AppSSN {xpath('AppSSN')};
	string Title {xpath('Title')};
	t_TrusteeName Name {xpath('Name')};
	t_TrusteeOrigAddress OrigAddress {xpath('OrigAddress')};
	t_TrusteeAddress Address {xpath('Address')};
	string Cart {xpath('Cart')};
	string CrSortSz {xpath('CrSortSz')};
	string Lot {xpath('Lot')};
	string LotOrder {xpath('LotOrder')};
	string DBPC {xpath('DBPC')};
	string ChkDigit {xpath('ChkDigit')};
	string RecType {xpath('RecType')};
	string Phone {xpath('Phone')};
	string TrusteePhone {xpath('TrusteePhone')};
end;
		
export t_Bankruptcy3Meeting := record
	iesp.share.t_Date Date {xpath('Date')};
	string Time {xpath('Time')};
	string Address {xpath('Address')};
end;
		
export t_BankruptcyReport3Attorney := record
	string BusinessId {xpath('BusinessId')};
	string UniqueId {xpath('UniqueId')};
	string SSN {xpath('SSN')};
	string AppendedSSN {xpath('AppendedSSN')};
	string TaxId {xpath('TaxId')};
	string AppendedTaxId {xpath('AppendedTaxId')};
	dataset(t_BankruptcySearch3Name) Names {xpath('Names/Name'), MAXCOUNT(iesp.Constants.BANKRPT.MaxPersonNames)};
	dataset(iesp.share.t_Address) Addresses {xpath('Addresses/Address'), MAXCOUNT(iesp.Constants.BANKRPT.MaxPersonAddresses)};
	dataset(iesp.share.t_PhoneTimeZone) Phones {xpath('Phones/Phone'), MAXCOUNT(iesp.Constants.BANKRPT.MaxPersonPhones)};
	dataset(iesp.share.t_StringArrayItem) Emails {xpath('Emails/Email'), MAXCOUNT(iesp.Constants.BANKRPT.MaxPersonEmails)};
end;
		
export t_BankruptcyReport3Dockets := record
	string DocketText {xpath('DocketText')};
	iesp.share.t_Date PacerEnteredDate {xpath('PacerEnteredDate')};
	iesp.share.t_Date FiledDate {xpath('FiledDate')};
	string AttachmentURL {xpath('AttachmentURL')};
	string EntryNumber {xpath('EntryNumber')};
	string DocketEntryId {xpath('DocketEntryId')};
	string DRCategoryEventId {xpath('DRCategoryEventId')};
	iesp.share.t_Date EnteredDate {xpath('EnteredDate')};
	string EventDescription {xpath('EventDescription')};
	string EventCategory {xpath('EventCategory')};
	string PacerCaseId {xpath('PacerCaseId')};
end;
		
export t_BankruptcyReport3Option := record (iesp.share.t_BaseReportOption)
	boolean IncludeDockets {xpath('IncludeDockets')};
	string LowerEnteredDateLimit {xpath('LowerEnteredDateLimit')};
	string UpperEnteredDateLimit {xpath('UpperEnteredDateLimit')};
end;
		
export t_BankruptcyCourtAddress := record
	string Address {xpath('Address')};
	string City {xpath('City')};
	string State {xpath('State')};
	string Zip {xpath('Zip')};
end;
		
export t_BankruptcyCourt := record
	string LegacyCourt {xpath('LegacyCourt')};
	t_BankruptcyCourtAddress Address {xpath('Address')};
	string Phone {xpath('Phone')};
	string District {xpath('District')};
	string FilingCity {xpath('FilingCity')};
	string CourtCode {xpath('CourtCode')};
	string CourtId {xpath('CourtId')};
end;
		
export t_Bankruptcy3BpsDebtor := record
	string BusinessId {xpath('BusinessId')};
	string UniqueId {xpath('UniqueId')};
	string PersonFilterId {xpath('PersonFilterId')};
	string DebtorType {xpath('DebtorType')};
	string FilingType {xpath('FilingType')};
	string SSN {xpath('SSN')};
	string AppendedSSN {xpath('AppendedSSN')};
	string SSNMatch {xpath('SSNMatch')};
	string SSNMSrc {xpath('SSNMSrc')};
	string TaxId {xpath('TaxId')};
	string AppendedTaxId {xpath('AppendedTaxId')};
	string DCodeDesc {xpath('DCodeDesc')};
	string DispTypeDesc {xpath('DispTypeDesc')};
	string Chapter {xpath('Chapter')};
	string CorpFlag {xpath('CorpFlag')};
	string Disposition {xpath('Disposition')};
	string SelfRepresented {xpath('SelfRepresented')};
	iesp.share.t_Date DischargeDate {xpath('DischargeDate')};
	iesp.share.t_Date StatusDate {xpath('StatusDate')};
	iesp.share.t_Date DateVacated {xpath('DateVacated')};
	iesp.share.t_Date DateTransferred {xpath('DateTransferred')};
	iesp.share.t_Date ConvertedDate {xpath('ConvertedDate')};
	dataset(t_BankruptcyReport3Name) Names {xpath('Names/Name'), MAXCOUNT(iesp.Constants.BANKRPT.MaxPersonNames)};
	dataset(iesp.share.t_Address) Addresses {xpath('Addresses/Address'), MAXCOUNT(iesp.Constants.BANKRPT.MaxPersonAddresses)};
	dataset(iesp.share.t_PhoneTimeZone) Phones {xpath('Phones/Phone'), MAXCOUNT(iesp.Constants.BANKRPT.MaxPersonPhones)};
end;
		
export t_Bankruptcy3BpsRecord := record
	string TMSId {xpath('TMSId')};
	string CaseNumber {xpath('CaseNumber')};
	string CourtLocation {xpath('CourtLocation')};
	string CourtCode {xpath('CourtCode')};
	string CaseType {xpath('CaseType')};
	iesp.share.t_Date FilingDate {xpath('FilingDate')};
	iesp.share.t_Date OriginalFilingDate {xpath('OriginalFilingDate')};
	iesp.share.t_Date ReopenDate {xpath('ReopenDate')};
	iesp.share.t_Date ClosedDate {xpath('ClosedDate')};
	string CourtName {xpath('CourtName')};
	string FilerType {xpath('FilerType')};
	string CorpFlag {xpath('CorpFlag')};
	string FilingStatus {xpath('FilingStatus')};
	string FilingJurisdiction {xpath('FilingJurisdiction')};
	string Chapter {xpath('Chapter')};
	string OriginalChapter {xpath('OriginalChapter')};
	string JudgeName {xpath('JudgeName')};
	t_Bankruptcy3Meeting Meeting {xpath('Meeting')};
	string JudgeIdentification {xpath('JudgeIdentification')};
	iesp.share.t_Date ClaimsDeadline {xpath('ClaimsDeadline')};
	iesp.share.t_Date ComplaintDeadline {xpath('ComplaintDeadline')};
	iesp.share.t_Date DischargeDate {xpath('DischargeDate')};
	string Disposition {xpath('Disposition')};
	string SelfRepresented {xpath('SelfRepresented')};
	string AssetsForUnsecured {xpath('AssetsForUnsecured')};
	string Assets {xpath('Assets')};
	string Liabilities {xpath('Liabilities')};
	string SplitCase {xpath('SplitCase')};
	string FiledInError {xpath('FiledInError')};
	string DateReclosed {xpath('DateReclosed')};
	string CaseId {xpath('CaseId')};
	string BarDate {xpath('BarDate')};
	string TransferIn {xpath('TransferIn')};
	t_Bankruptcy3Trustee Trustee {xpath('Trustee')};
	dataset(t_BankruptcyStatus) StatusHistory {xpath('StatusHistory/Status'), MAXCOUNT(iesp.Constants.BANKRPT.MaxStatusHistory)};
	dataset(t_BankruptcyComment) Comments {xpath('Comments/Comment'), MAXCOUNT(iesp.Constants.BANKRPT.MaxComments)};
	dataset(t_BankruptcyReport3Attorney) Attorneys {xpath('Attorneys/Attorney'), MAXCOUNT(iesp.Constants.BANKRPT.MaxAttorneys)};
	dataset(t_Bankruptcy3BpsDebtor) Debtors {xpath('Debtors/Debtor'), MAXCOUNT(iesp.Constants.BANKRPT.MaxDebtors)};
end;
		
export t_BankruptcyReport3Record := record
	string TMSId {xpath('TMSId')};
	string CaseNumber {xpath('CaseNumber')};
	string CourtLocation {xpath('CourtLocation')};
	string CourtCode {xpath('CourtCode')};
	string CaseType {xpath('CaseType')};
	iesp.share.t_Date FilingDate {xpath('FilingDate')};
	iesp.share.t_Date OriginalFilingDate {xpath('OriginalFilingDate')};
	iesp.share.t_Date ReopenDate {xpath('ReopenDate')};
	iesp.share.t_Date ClosedDate {xpath('ClosedDate')};
	string CourtName {xpath('CourtName')};
	string FilingType {xpath('FilingType')};
	string FilerType {xpath('FilerType')};
	string CorpFlag {xpath('CorpFlag')};
	string FilingStatus {xpath('FilingStatus')};
	string FilingJurisdiction {xpath('FilingJurisdiction')};
	string Chapter {xpath('Chapter')};
	string OriginalChapter {xpath('OriginalChapter')};
	string JudgeName {xpath('JudgeName')};
	t_Bankruptcy3Meeting Meeting {xpath('Meeting')};
	string JudgeIdentification {xpath('JudgeIdentification')};
	iesp.share.t_Date ClaimsDeadline {xpath('ClaimsDeadline')};
	iesp.share.t_Date ComplaintDeadline {xpath('ComplaintDeadline')};
	iesp.share.t_Date DischargeDate {xpath('DischargeDate')};
	string Disposition {xpath('Disposition')};
	string SelfRepresented {xpath('SelfRepresented')};
	string AssetsForUnsecured {xpath('AssetsForUnsecured')};
	string Assets {xpath('Assets')};
	string Liabilities {xpath('Liabilities')};
	string SplitCase {xpath('SplitCase')};
	string FiledInError {xpath('FiledInError')};
	string DateReclosed {xpath('DateReclosed')};
	string CaseId {xpath('CaseId')};
	string BarDate {xpath('BarDate')};
	string TransferIn {xpath('TransferIn')};
	dataset(t_BankruptcyStatus) StatusHistory {xpath('StatusHistory/Status'), MAXCOUNT(iesp.Constants.BANKRPT.MaxStatusHistory)};
	dataset(t_BankruptcyComment) Comments {xpath('Comments/Comment'), MAXCOUNT(iesp.Constants.BANKRPT.MaxComments)};
	dataset(t_BankruptcyReport3Dockets) Dockets {xpath('Dockets/Docket'), MAXCOUNT(iesp.Constants.BANKRPT.MaxDockets)};
	t_Bankruptcy3Trustee Trustee {xpath('Trustee')};
	dataset(t_BankruptcyReport3Attorney) Attorneys {xpath('Attorneys/Attorney'), MAXCOUNT(iesp.Constants.BANKRPT.MaxAttorneys)};
	dataset(t_BankruptcyReport3Debtor) Debtors {xpath('Debtors/Debtor'), MAXCOUNT(iesp.Constants.BANKRPT.MaxDebtors)};
	t_BankruptcyCourt Court {xpath('Court')};
	boolean HasDocketInfo {xpath('HasDocketInfo')};
end;
		
export t_BankruptcyReport3Response := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	dataset(t_BankruptcyReport3Record) BankruptcyReportRecords {xpath('BankruptcyReportRecords/BankruptcyReport3Record'), MAXCOUNT(iesp.Constants.BANKRPT.MaxCountReport)};
end;
		
export t_BankruptcySearchRequest := record (iesp.share.t_BaseRequest)
	t_BankruptcySearchBy SearchBy {xpath('SearchBy')};
	t_BankruptcySearchOption Options {xpath('Options')};
end;
		
export t_BankruptcyReportRequest := record (iesp.share.t_BaseRequest)
	t_BankruptcyReportOption Options {xpath('Options')};
	t_BankruptcyReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_BankruptcySearch2Request := record (iesp.share.t_BaseRequest)
	t_BankruptcySearch2By SearchBy {xpath('SearchBy')};
	t_BankruptcySearch2Option Options {xpath('Options')};
end;
		
export t_BankruptcySearch3Request := record (iesp.share.t_BaseRequest)
	t_BankruptcySearch3By SearchBy {xpath('SearchBy')};
	t_BankruptcySearch3Option Options {xpath('Options')};
end;
		
export t_BankruptcyReport2Request := record (iesp.share.t_BaseRequest)
	t_BankruptcyReport2Option Options {xpath('Options')};
	t_BankruptcyReport2By ReportBy {xpath('ReportBy')};
end;
		
export t_BankruptcyReport3Request := record (iesp.share.t_BaseRequest)
	t_BankruptcyReport3Option Options {xpath('Options')};
	t_BankruptcyReport3By ReportBy {xpath('ReportBy')};
end;
		
export t_BankruptcySearchResponseEx := record
	t_BankruptcySearchResponse response {xpath('response')};
end;
		
export t_BankruptcyReportResponseEx := record
	t_BankruptcyReportResponse response {xpath('response')};
end;
		
export t_BankruptcySearch2ResponseEx := record
	t_BankruptcySearch2Response response {xpath('response')};
end;
		
export t_BankruptcySearch3ResponseEx := record
	t_BankruptcySearch3Response response {xpath('response')};
end;
		
export t_BankruptcyReport2ResponseEx := record
	t_BankruptcyReport2Response response {xpath('response')};
end;
		
export t_BankruptcyReport3ResponseEx := record
	t_BankruptcyReport3Response response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from bankruptcy.xml. ***/
/*===================================================*/

