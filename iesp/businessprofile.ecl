export businessprofile := MODULE
			
export t_BusinessProfileSearchOption := record (share.t_BaseSearchOption)
	boolean UsePhonetics {xpath('UsePhonetics')};
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
end;
		
export t_BusinessProfileSearchBy := record
	string CompanyName {xpath('CompanyName')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string FEIN {xpath('FEIN')};
	string PhoneNumber {xpath('PhoneNumber')};
	integer Radius {xpath('Radius')};
end;
		
export t_BusinessName := record
	string BusinessId {xpath('BusinessId')};
	string CompanyName {xpath('CompanyName')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
end;
		
export t_BusinessProfileSearchRecord := record
	share.t_Address Address {xpath('Address')};
	integer Score {xpath('Score')};
	dataset(t_BusinessName) GroupBusinesses {xpath('GroupBusinesses/Business'), MAXCOUNT(1)};
end;
		
export t_BusinessProfileSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer SubjectTotalCount {xpath('SubjectTotalCount')};
	dataset(t_BusinessProfileSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_BusinessProfileReportOption := record (share.t_BaseReportOption)
	boolean IncludeRiskIndicators {xpath('IncludeRiskIndicators')};
	boolean IncludeReversePhone {xpath('IncludeReversePhone')};
	boolean IncludeYellowPages {xpath('IncludeYellowPages')};
	boolean IncludeBusinessesAtSameAddress {xpath('IncludeBusinessesAtSameAddress')};
	boolean IncludeRelatedBussinesses {xpath('IncludeRelatedBussinesses')};
	boolean IncludeCorporateFilings {xpath('IncludeCorporateFilings')};
	boolean IncludeLiens {xpath('IncludeLiens')};
	boolean IncludeJudgements {xpath('IncludeJudgements')};
	boolean IncludeLienJudgments {xpath('IncludeLienJudgments')};
	boolean IncludeContacts {xpath('IncludeContacts')};
	boolean IncludeInternetDomains {xpath('IncludeInternetDomains')};
	boolean IncludeBankruptcies {xpath('IncludeBankruptcies')};
	boolean IncludeBusinessRegistrations {xpath('IncludeBusinessRegistrations')};
	boolean IncludeDnBReport {xpath('IncludeDnBReport')};
	boolean IncludeProperties {xpath('IncludeProperties')};
	boolean IncludeProfessionalLicenses {xpath('IncludeProfessionalLicenses')};
	boolean IncludePatriotActRecords {xpath('IncludePatriotActRecords')};
	boolean IncludeBusinessIdentifiers {xpath('IncludeBusinessIdentifiers')};
	boolean IncludeAlternativeNames {xpath('IncludeAlternativeNames')};
	boolean IncludeUCCFilings {xpath('IncludeUCCFilings')};
	boolean IncludeBetterBusinessBureaus {xpath('IncludeBetterBusinessBureaus')};
	boolean IncludeTradeLines {xpath('IncludeTradeLines')};
	boolean ShowPersonalData {xpath('ShowPersonalData')};
end;
		
export t_BusinessProfileReportBy := record
	string CompanyName {xpath('CompanyName')};
	string BusinessId {xpath('BusinessId')};
end;
		
export t_ExperianNumber := record
	string ID {xpath('ID')};
	string Name {xpath('Name')};
end;
		
export t_FEINId := record
	string FEIN {xpath('FEIN')};
	string CompanyName {xpath('CompanyName')};
end;
		
export t_StateId := record
	string StateOfOriginCode {xpath('StateOfOriginCode')};
	string CorporationNumber {xpath('CorporationNumber')};
	string CompanyName {xpath('CompanyName')};
end;
		
export t_BusinessProfileIdentifier := record
	string BusinessId {xpath('BusinessId')};
	t_FEINId FEINId {xpath('FEINId')};
	dataset(share.t_StringArrayItem) DunsNumbers {xpath('DunsNumbers/DunsNumber'), MAXCOUNT(1)};
	dataset(t_StateId) StateIds {xpath('StateIds/StateId'), MAXCOUNT(1)};
	dataset(share.t_StringArrayItem) BetterBusinessBureauIds {xpath('BetterBusinessBureauIds/BetterBusinessBureauId'), MAXCOUNT(1)};
end;
		
export t_BusinessProfileIdentity := record
	string CompanyName {xpath('CompanyName')};
	string FEIN {xpath('FEIN')};
	string Phone10 {xpath('Phone10')};
	string BusinessId {xpath('BusinessId')};
	share.t_Address Address {xpath('Address')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
end;
		
export t_BusinessProfileGroupInformation := record (t_BusinessProfileIdentity)
	string Type {xpath('Type')};
	boolean Verified {xpath('Verified')};
	boolean IsBetterBusinessBureauMember {xpath('IsBetterBusinessBureauMember')};
	boolean IsBetterBusinessBureauNonMember {xpath('IsBetterBusinessBureauNonMember')};
	dataset(share.t_StringArrayItem) AlternativeNames {xpath('AlternativeNames/AlternativeName'), MAXCOUNT(1)};
	dataset(t_BusinessProfileIdentifier) BusinessIdentifiers {xpath('BusinessIdentifiers/BusinessIdentifier'), MAXCOUNT(1)};
end;
		
export t_AddressRiskIndicator := record
	share.t_Address Address {xpath('Address')};
	dataset(share.t_HRIWarning) Warnings {xpath('Warnings/Warning'), MAXCOUNT(1)};
end;
		
export t_RiskIndicators := record
	integer Score {xpath('Score')};
	dataset(t_AddressRiskIndicator) RiskAssessedAddresses {xpath('RiskAssessedAddresses/RiskAssessedAddress'), MAXCOUNT(1)};
end;
		
export t_YellowPagesRecord := record
	string CompanyName {xpath('CompanyName')};
	string Phone10 {xpath('Phone10')};
	share.t_Date PublishedDate {xpath('PublishedDate')};
	share.t_Address Address {xpath('Address')};
	string Heading {xpath('Heading')};
	string HeadingDescription {xpath('HeadingDescription')};
	string SICCode {xpath('SICCode')};
	string SICDescription {xpath('SICDescription')};
	dataset(share.t_RiskIndicator) PhoneRiskIndicators {xpath('PhoneRiskIndicators/RiskIndicator'), MAXCOUNT(1)};
end;
		
export t_BizJudicialDebtor := record
	share.t_Name Name {xpath('Name')};
	string SSN {xpath('SSN')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_BizJudicial := record
	string FilingType {xpath('FilingType')};
	string CourtLocation {xpath('CourtLocation')};
	string CourtState {xpath('CourtState')};
	string CourtDescription {xpath('CourtDescription')};
	string CaseNumber {xpath('CaseNumber')};
	string Amount {xpath('Amount')};
	share.t_Date DateFiled {xpath('DateFiled')};
	share.t_Date DateDisposed {xpath('DateDisposed')};
	t_BizJudicialDebtor Debtor {xpath('Debtor')};
	string Creditor {xpath('Creditor')};
end;
		
export t_CorporateFillingRecord := record
	string StateOfOrigin {xpath('StateOfOrigin')};
	string StateOfOriginCode {xpath('StateOfOriginCode')};
	string CorporationNumber {xpath('CorporationNumber')};
	dataset(corporate.t_CorpCorporation) Corporations {xpath('Corporations/Corporation'), MAXCOUNT(1)};
end;
		
export t_BetterBusinessBureau := record
	string Name {xpath('Name')};
	string BusinessType {xpath('BusinessType')};
	share.t_Address Address {xpath('Address')};
	share.t_Date MemberSince {xpath('MemberSince')};
	string BetterBusinessBureauId {xpath('BetterBusinessBureauId')};
	string HttpLink {xpath('HttpLink')};
end;
		
export t_RelatedBusinessIdentity := record
	boolean IsCurrent {xpath('IsCurrent')};
	boolean IsHistorical {xpath('IsHistorical')};
	boolean IsBetterBusinessBureauMember {xpath('IsBetterBusinessBureauMember')};
	t_BetterBusinessBureau BetterBusinessBureau {xpath('BetterBusinessBureau')};
	boolean IsBetterBusinessBureauNonMember {xpath('IsBetterBusinessBureauNonMember')};
	t_BetterBusinessBureau BetterBusinessBureauNonMember {xpath('BetterBusinessBureauNonMember')};
	t_BusinessProfileIdentity Business {xpath('Business')};
	dataset(share.t_StringArrayItem) Relationships {xpath('Relationships/Relationship'), MAXCOUNT(1)};
end;
		
export t_BusinessProfileCountSummary := record
	integer CorporationFilings {xpath('CorporationFilings')};
	integer BusinessRegistrations {xpath('BusinessRegistrations')};
	integer Properties {xpath('Properties')};
	integer PropertiesOwned {xpath('PropertiesOwned')};
	integer Liens {xpath('Liens')};
	integer Judgements {xpath('Judgements')};
	integer LienJudgments {xpath('LienJudgments')};
	integer Bankruptcies {xpath('Bankruptcies')};
	integer PatriotRecords {xpath('PatriotRecords')};
	integer UCCRecords {xpath('UCCRecords')};
	integer HighRiskAddresses {xpath('HighRiskAddresses')};
	integer Contacts {xpath('Contacts')};
	integer AssociatedBusinesses {xpath('AssociatedBusinesses')};
	integer DNBRecords {xpath('DNBRecords')};
	integer InternetDomains {xpath('InternetDomains')};
	integer ProfessionalLicenses {xpath('ProfessionalLicenses')};
	integer BusinessesAtSameAddress {xpath('BusinessesAtSameAddress')};
	integer BetterBusinessBureauNonMembers {xpath('BetterBusinessBureauNonMembers')};
	integer BetterBusinessBureausAssociateOnly {xpath('BetterBusinessBureausAssociateOnly')};
	integer BetterBusinessBureauNonMembersAssociateOnly {xpath('BetterBusinessBureauNonMembersAssociateOnly')};
	integer BetterBusinessBureaus {xpath('BetterBusinessBureaus')};
	integer OthersAtSameAddress {xpath('OthersAtSameAddress')};
	integer ReversePhoneRecords {xpath('ReversePhoneRecords')};
	integer NameVariants {xpath('NameVariants')};
	integer YellowPages {xpath('YellowPages')};
	integer TradeLines {xpath('TradeLines')};
	integer AssociatesByContact {xpath('AssociatesByContact')};
end;
		
export t_BusinessProfileInternetDomain := record
	string DomainName {xpath('DomainName')};
	share.t_Date DateCreated {xpath('DateCreated')};
end;
		
export t_BusinessProfileCorpContact := record (corporate.t_CorpContact)
	boolean HasDeathRecord {xpath('HasDeathRecord')};
	dataset(share.t_StringArrayItem) CompanyTitles {xpath('CompanyTitles/Title'), MAXCOUNT(1)};
end;
		
export t_ListedName := record
	string Level {xpath('Level')};
	string Name {xpath('Name')};
end;
		
export t_ReversePhone := record
	string Phone10 {xpath('Phone10')};
	string CompanyName {xpath('CompanyName')};
	share.t_Address Address {xpath('Address')};
	dataset(share.t_StringArrayItem) ListingTypes {xpath('ListingTypes/ListingType'), MAXCOUNT(1)};
	dataset(t_ListedName) ListedNames {xpath('ListedNames/ListedName'), MAXCOUNT(1)};
end;
		
export t_TradeLineSummary := record
	integer CurrentDaysBeyondTerms {xpath('CurrentDaysBeyondTerms')};
	integer PredictedDaysBeyondTerms {xpath('PredictedDaysBeyondTerms')};
	share.t_Date DateOfPrediction {xpath('DateOfPrediction')};
	integer ConfidencePercent {xpath('ConfidencePercent')};
	integer ConfidenceSlope {xpath('ConfidenceSlope')};
	integer ThisIndustryAverageDaysBeyondTerms {xpath('ThisIndustryAverageDaysBeyondTerms')};
	integer AllIndustriesAverageDaysBeyondTerms {xpath('AllIndustriesAverageDaysBeyondTerms')};
	integer SixMonthLowBalance {xpath('SixMonthLowBalance')};
	integer SixMonthHighBalance {xpath('SixMonthHighBalance')};
	integer CurrentAccountBalance {xpath('CurrentAccountBalance')};
	integer HighestCreditExtended {xpath('HighestCreditExtended')};
	integer MedianOfCreditExtended {xpath('MedianOfCreditExtended')};
	string PaymentPerformance {xpath('PaymentPerformance')};
	string PaymentTrend {xpath('PaymentTrend')};
	string IndustryDescription {xpath('IndustryDescription')};
end;
		
export t_AssociateByContact := record
	string BusinessId {xpath('BusinessId')};
	share.t_Address Address {xpath('Address')};
	share.t_Name Name {xpath('Name')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	boolean IsBetterBusinessBureau {xpath('IsBetterBusinessBureau')};
	boolean IsBetterBusinessBureauNonMember {xpath('IsBetterBusinessBureauNonMember')};
end;
		
export t_BusinessProfileReportRecord := record
	t_BusinessProfileGroupInformation GroupInformation {xpath('GroupInformation')};
	t_RiskIndicators RiskIndicators {xpath('RiskIndicators')};
	t_BusinessProfileCountSummary CountSummary {xpath('CountSummary')};
	t_BetterBusinessBureau BetterBusinessBureau {xpath('BetterBusinessBureau')};
	t_BetterBusinessBureau BetterBusinessBureauNonMember {xpath('BetterBusinessBureauNonMember')};
	t_TradeLineSummary TradeLine {xpath('TradeLine')};
	dataset(t_ReversePhone) ReversePhoneRecords {xpath('ReversePhoneRecords/ReversePhoneRecord'), MAXCOUNT(1)};
	dataset(t_YellowPagesRecord) YellowPagesRecords {xpath('YellowPagesRecords/YellowPagesRecord'), MAXCOUNT(1)};
	dataset(t_BusinessProfileIdentity) BusinessesAtSameAddress {xpath('BusinessesAtSameAddress/Business'), MAXCOUNT(1)};
	dataset(t_RelatedBusinessIdentity) RelatedBusinesses {xpath('RelatedBusinesses/RelatedBusiness'), MAXCOUNT(1)};
	dataset(t_CorporateFillingRecord) CorporateFilings {xpath('CorporateFilings/CorporateFiling'), MAXCOUNT(1)};
	dataset(t_BizJudicial) Liens {xpath('Liens/Lien'), MAXCOUNT(1)};
	dataset(t_BizJudicial) Judgments {xpath('Judgments/Judgment'), MAXCOUNT(1)};
	dataset(lienjudgement.t_LienJudgmentReportRecord) LienJudgments {xpath('LienJudgments/LienJudgment'), MAXCOUNT(1)};
	dataset(t_BusinessProfileCorpContact) Contacts {xpath('Contacts/Contact'), MAXCOUNT(1)};
	dataset(t_BusinessProfileInternetDomain) InternetDomains {xpath('InternetDomains/Domain'), MAXCOUNT(1)};
	dataset(bankruptcy.t_BankruptcyReportRecord) Bankruptcies {xpath('Bankruptcies/Bankruptcy'), MAXCOUNT(1)};
	dataset(bankruptcy.t_BankruptcyReport2Record) Bankruptcies2 {xpath('Bankruptcies2/Bankruptcy'), MAXCOUNT(1)};
	dataset(bizreport.t_BizRegistration) BusinessRegistrations {xpath('BusinessRegistrations/BusinessRegistration'), MAXCOUNT(1)};
	dataset(bizreport.t_DnBRcord) DnBReports {xpath('DnBReports/DnBReport'), MAXCOUNT(1)};
	dataset(bizreport.t_PropertyRecord) PropertiesAtAddress {xpath('PropertiesAtAddress/PropertyAtAddress'), MAXCOUNT(1)};
	dataset(proflicense.t_PLRecord) ProfessionalLicensesAtAddress {xpath('ProfessionalLicensesAtAddress/ProfessionalLicense'), MAXCOUNT(1)};
	dataset(patriotsearch.t_PatriotRecord) PatriotActRecords {xpath('PatriotActRecords/PatriotActRecord'), MAXCOUNT(1)};
	dataset(ucc.t_UCCRecord) UCCRecords {xpath('UCCRecords/UCCRecord'), MAXCOUNT(1)};
	dataset(ucc.t_UCCReport2Record) UCCRecords2 {xpath('UCCRecords2/UCCRecord'), MAXCOUNT(1)};
	dataset(t_AssociateByContact) AssociatesByContact {xpath('AssociatesByContact/Associate'), MAXCOUNT(1)};
end;
		
export t_BusinessProfileReportResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	dataset(t_BusinessProfileReportRecord) BusinessProfiles {xpath('BusinessProfiles/BusinessProfile'), MAXCOUNT(1)};
end;
		
export t_BusinessProfileSearchRequest := record (share.t_BaseRequest)
	t_BusinessProfileSearchOption Options {xpath('Options')};
	t_BusinessProfileSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_BusinessProfileReportRequest := record (share.t_BaseRequest)
	t_BusinessProfileReportOption Options {xpath('Options')};
	t_BusinessProfileReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_BusinessProfileSearchResponseEx := record
	t_BusinessProfileSearchResponse response {xpath('response')};
end;
		
export t_BusinessProfileReportResponseEx := record
	t_BusinessProfileReportResponse response {xpath('response')};
end;
		

end;

