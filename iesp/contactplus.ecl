/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from contactplus.xml. ***/
/*===================================================*/

export contactplus := MODULE
			
export t_ContactPlusSearchOption := record (iesp.share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};//hidden[internal]
	integer StartingRecord {xpath('StartingRecord')};//hidden[internal]
	boolean UseNicknames {xpath('UseNicknames')};//hidden[internal]
	boolean UsePhonetics {xpath('UsePhonetics')};//hidden[internal]
	boolean KeepSamePhoneInDiffLevels {xpath('KeepSamePhoneInDiffLevels')};//hidden[internal]
	boolean DedupeAgainstInputPhones {xpath('DedupeAgainstInputPhones')};//hidden[internal]
	boolean StrictAPSXMatch {xpath('StrictAPSXMatch')};//hidden[internal]
	boolean BlankOutDuplicatePhones {xpath('BlankOutDuplicatePhones')};//hidden[internal]
	boolean IncludePhonesFeedback {xpath('IncludePhonesFeedback')};//hidden[internal]
	boolean IncludeAddressFeedback {xpath('IncludeAddressFeedback')};//hidden[internal]
	boolean IncludeBusinessPhone {xpath('IncludeBusinessPhone')};//hidden[internal]
	boolean IncludeLandlordPhone {xpath('IncludeLandlordPhone')};//hidden[internal]
	boolean IncludeNonCellPhonesPlusData {xpath('IncludeNonCellPhonesPlusData')};//hidden[internal]
	boolean IncludeLastResort {xpath('IncludeLastResort')};//hidden[internal]
	boolean IncludeDeadContacts {xpath('IncludeDeadContacts')};//hidden[internal]
	integer UniqueIDConfidenceTreshold {xpath('UniqueIDConfidenceTreshold')};//hidden[internal]
	boolean SkipPhoneScoring {xpath('SkipPhoneScoring')};//hidden[internal]
	boolean ReturnScore {xpath('ReturnScore')};//hidden[internal]
	boolean ReturnAddressesSeenInLast24Mos {xpath('ReturnAddressesSeenInLast24Mos')};
	boolean UseMetronet {xpath('UseMetronet')};//hidden[internal]
	integer MetronetLimit {xpath('MetronetLimit')};//hidden[internal]
	integer MaxPhoneCount {xpath('MaxPhoneCount')};//hidden[internal]
	integer EDACount {xpath('EDACount')};//hidden[internal]
	integer SkipTraceCount {xpath('SkipTraceCount')};//hidden[internal]
	integer ProgressiveAddressCount {xpath('ProgressiveAddressCount')};//hidden[internal]
	integer SpouseCount {xpath('SpouseCount')};//hidden[internal]
	integer ParentsCount {xpath('ParentsCount')};//hidden[internal]
	integer ClosestRelativesCount {xpath('ClosestRelativesCount')};//hidden[internal]
	integer CoResidentCount {xpath('CoResidentCount')};//hidden[internal]
	integer ExpandedSkipTraceCount {xpath('ExpandedSkipTraceCount')};//hidden[internal]
	integer PhonesPlusCount {xpath('PhonesPlusCount')};//hidden[internal]
	integer UnverifiedCount {xpath('UnverifiedCount')};//hidden[internal]
	integer ClosestNeighborCount {xpath('ClosestNeighborCount')};//hidden[internal]
	integer PAWCount {xpath('PAWCount')};//hidden[internal]
	integer PossibleRelocationCount {xpath('PossibleRelocationCount')};//hidden[internal]
	integer TypeThTryHarderCount {xpath('TypeThTryHarderCount')};//hidden[internal]
	boolean DynamicOrdering {xpath('DynamicOrdering')};//hidden[internal]
	integer EDAOrder {xpath('EDAOrder')};//hidden[internal]
	integer SkipTraceOrder {xpath('SkipTraceOrder')};//hidden[internal]
	integer ProgressiveAddressOrder {xpath('ProgressiveAddressOrder')};//hidden[internal]
	integer SpouseOrder {xpath('SpouseOrder')};//hidden[internal]
	integer ParentsOrder {xpath('ParentsOrder')};//hidden[internal]
	integer ClosestRelativesOrder {xpath('ClosestRelativesOrder')};//hidden[internal]
	integer CoResidentOrder {xpath('CoResidentOrder')};//hidden[internal]
	integer ExpandedSkipTraceOrder {xpath('ExpandedSkipTraceOrder')};//hidden[internal]
	integer PhonesPlusOrder {xpath('PhonesPlusOrder')};//hidden[internal]
	integer UnverifiedOrder {xpath('UnverifiedOrder')};//hidden[internal]
	integer ClosestNeighborOrder {xpath('ClosestNeighborOrder')};//hidden[internal]
	integer PAWOrder {xpath('PAWOrder')};//hidden[internal]
	integer PossibleRelocationOrder {xpath('PossibleRelocationOrder')};//hidden[internal]
	integer TypeThTryHarderOrder {xpath('TypeThTryHarderOrder')};//hidden[internal]
	string ScoreModel {xpath('ScoreModel')};
	integer MaxNumAssociate {xpath('MaxNumAssociate')};//hidden[internal]
	integer MaxNumAssociateOther {xpath('MaxNumAssociateOther')};//hidden[internal]
	integer MaxNumFamilyOther {xpath('MaxNumFamilyOther')};//hidden[internal]
	integer MaxNumFamilyClose {xpath('MaxNumFamilyClose')};//hidden[internal]
	integer MaxNumParent {xpath('MaxNumParent')};//hidden[internal]
	integer MaxNumSpouse {xpath('MaxNumSpouse')};//hidden[internal]
	integer MaxNumNeighbor {xpath('MaxNumNeighbor')};//hidden[internal]
	integer MaxNumSubject {xpath('MaxNumSubject')};//hidden[internal]
	boolean GoToGateway {xpath('GoToGateway')};//hidden[internal]
	boolean UsePremiumSourceA {xpath('UsePremiumSourceA')};//hidden[internal]
	integer PremiumSourceLimitA {xpath('PremiumSourceLimitA')};//hidden[internal]
end;
		
export t_ContactPlusSearchBy := record
	string SSN {xpath('SSN')};
	string UniqueId {xpath('UniqueId')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string50 Email {xpath('Email')};
	string Phone10 {xpath('Phone10')};
	progressivephones.t_DedupeInfo DedupeInfo {xpath('DedupeInfo')};//hidden[internal]
end;
		
export t_ContactPlusDOB := record (share.t_Date)
	integer Age {xpath('Age')};
end;
		
export t_ContactPlusAddress := record (share.t_AddressEx)
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	share.t_Date UtilityConnectDate {xpath('UtilityConnectDate')};
	string30 UtilityType {xpath('UtilityType')};
	addressfeedback.t_AddressFeedback AddressFeedback {xpath('AddressFeedback')};//hidden[internal]
  boolean IsCurrent {xpath('IsCurrent')};
end;
		
export t_ContactPlusSource := record
	string Source {xpath('Source')};
	integer Occurrences {xpath('Occurrences')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
end;
		
export t_ContactPlusSourceSummary := record
	string Name {xpath('Name')};
	integer SourceCount {xpath('SourceCount')};
	dataset(t_ContactPlusSource) Sources {xpath('Sources/Source'), MAXCOUNT(iesp.Constants.Contact_Plus.MaxCountSources)};
end;
		
export t_ContactPlusAlsoFound := record
	integer Vehicles {xpath('Vehicles')};
	integer DriverLicenses {xpath('DriverLicenses')};
	integer Headers {xpath('Headers')};
	integer Criminals {xpath('Criminals')};
	integer SexualOffenses {xpath('SexualOffenses')};
	integer ConcealedWeapons {xpath('ConcealedWeapons')};
	integer Relatives {xpath('Relatives')};
	integer Firearms {xpath('Firearms')};
	integer FAAPilots {xpath('FAAPilots')};
	integer ProfessionalLicenses {xpath('ProfessionalLicenses')};
	integer MerchantVessels {xpath('MerchantVessels')};
	integer Businesses {xpath('Businesses')};
	integer PeopleAtWork {xpath('PeopleAtWork')};
	integer BusinessContact {xpath('BusinessContact')};
	integer Properties {xpath('Properties')};
	integer PropertyAssessment {xpath('PropertyAssessment')};
	integer PropertyDeeds {xpath('PropertyDeeds')};
	integer Bankruptcies {xpath('Bankruptcies')};
	integer CorporateAffiliations {xpath('CorporateAffiliations')};
	integer CurrentlyOwnedProperties {xpath('CurrentlyOwnedProperties')};
	integer Emails {xpath('Emails')};
	integer Accidents {xpath('Accidents')};
end;
		
export t_ContactPlusProgPhoneRecord := record (progressivephones.t_ProgressivePhonesSearchRecord)
	string NewPhoneType {xpath('NewPhoneType')};
end;
		
export t_ContactPlusDOD := record (iesp.share.t_Date)
	boolean IsLimitedAccessDMF {xpath('IsLimitedAccessDMF')};//hidden[internal]
	integer DeadAge {xpath('DeadAge')};
	string1 Deceased {xpath('Deceased')};
end;
		
export t_ContactPlusSearchRecord := record
	string UniqueId {xpath('UniqueId')};
	dataset(share.t_NameWithGender) Names {xpath('Names/Name'), MAXCOUNT(iesp.Constants.Contact_Plus.MaxCountNameRecords)};
	dataset(share.t_StringArrayItem) SSNs {xpath('SSNs/SSN'), MAXCOUNT(iesp.Constants.Contact_Plus.MaxCountSSNRecords)};
	dataset(t_ContactPlusDOB) DOBs {xpath('DOBs/DOB'), MAXCOUNT(iesp.Constants.Contact_Plus.MaxCountDOBRecords)};
	dataset(t_ContactPlusDOD) DODs {xpath('DODs/DOD'), MAXCOUNT(iesp.Constants.Contact_Plus.MaxCountDODRecords)};
	dataset(t_ContactPlusAddress) Addresses {xpath('Addresses/Address'), MAXCOUNT(iesp.Constants.Contact_Plus.MaxCountAddressRecords)};
	t_ContactPlusAlsoFound AlsoFound {xpath('AlsoFound')};//hidden[internal]
	dataset(t_ContactPlusSourceSummary) Sources {xpath('Sources/Source'), MAXCOUNT(iesp.Constants.Contact_Plus.MaxCountSources)};
end;
		
export t_ContactPlusSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_ContactPlusProgPhoneRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.Constants.ProgPhones.MaxCountPhoneRecords)};
	t_ContactPlusSearchRecord ContactPlus {xpath('ContactPlus')};
end;
		
export t_ContactPlusSearchRequest := record (share.t_BaseRequest)
	t_ContactPlusSearchBy SearchBy {xpath('SearchBy')};
	t_ContactPlusSearchOption Options {xpath('Options')};
end;
		
export t_ContactPlusSearchResponseEx := record
	t_ContactPlusSearchResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from contactplus.xml. ***/
/*===================================================*/

