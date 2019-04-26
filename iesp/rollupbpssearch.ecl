/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from rollupbpssearch.xml. ***/
/*===================================================*/

import iesp;
export rollupbpssearch := MODULE
			
export t_RollupBpsSearchOption := record (iesp.share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean UsePhonetics {xpath('UsePhonetics')};
	boolean CheckNameVariants {xpath('CheckNameVariants')};
	boolean UseNicknames {xpath('UseNicknames')};
	boolean IncludeBankruptcy {xpath('IncludeBankruptcy')};
	boolean IncludeAlsoFound {xpath('IncludeAlsoFound')};//hidden[internal]
	boolean IncludeSourceDocCounts {xpath('IncludeSourceDocCounts')};//hidden[internal]
	boolean IncludePhonesPlus {xpath('IncludePhonesPlus')};//hidden[internal]
	boolean IncludeAlternatePhonesCount {xpath('IncludeAlternatePhonesCount')};//hidden[internal]
	boolean UsePartialSSNMatch {xpath('UsePartialSSNMatch')};
	boolean IncludeDLInfo {xpath('IncludeDLInfo')};//hidden[internal]
	boolean IncludeNonDMVSources {xpath('IncludeNonDMVSources')};//hidden[internal]
	boolean IncludePhonesFeedback {xpath('IncludePhonesFeedback')};//hidden[internal]
	boolean IncludeAddressFeedback {xpath('IncludeAddressFeedback')};//hidden[internal]
	dataset(iesp.share.t_StringArrayItem) IncludeSourceList {xpath('IncludeSourceList/Item'), MAXCOUNT(10)};//hidden[internal]
	boolean IncludeFraudDefenseNetwork {xpath('IncludeFraudDefenseNetwork')};
end;
		
export t_RollupBpsSearchBy := record
	string11 SSN {xpath('SSN')};
	string4 SSNLast4 {xpath('SSNLast4')};
	string5 SSNFirst5 {xpath('SSNFirst5')};
	string15 Phone10 {xpath('Phone10')};
	string12 UniqueId {xpath('UniqueId')};
	integer Radius {xpath('Radius')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	iesp.share.t_Date DOB {xpath('DOB')};
	iesp.share.t_IntRange AgeRange {xpath('AgeRange')};
	string30 DLNumber {xpath('DLNumber')};//hidden[internal]
	string2 DLState {xpath('DLState')};//hidden[internal]
end;
		
export t_RollupBpsSearchSource := record
	string Name {xpath('Name')};
	string Id {xpath('Id')};
end;
		
export t_RollupBpsSearchDate := record
	iesp.share.t_Date DOB {xpath('DOB')};
	integer Age {xpath('Age')};
	iesp.share.t_Date DOD {xpath('DOD')};
	iesp.share.t_Identity.IsLimitedAccessDMF;
	string1 Deceased {xpath('Deceased')}; //values['U','Y','N','']
	integer AgeAtDeath {xpath('AgeAtDeath')};
	string1 DeathVerificationCode {xpath('DeathVerificationCode')};
end;
		
export t_RollupBpsSearchPhone := record
	string Phone10 {xpath('Phone10')};
	string ListingName {xpath('ListingName')};
	boolean IsActive {xpath('IsActive')};
	string TimeZone {xpath('TimeZone')};
	iesp.phonesfeedback.t_PhonesFeedback PhoneFeedback {xpath('PhoneFeedback')};//hidden[internal]
	string UniqueId {xpath('UniqueId')};//hidden[internal]
	string TypeCell {xpath('TypeCell')};//hidden[internal]
	string TypeResidence {xpath('TypeResidence')};//hidden[internal]
	integer MatchType {xpath('MatchType')};//hidden[internal]
	integer GongScore {xpath('GongScore')};//hidden[internal]
	string NewType {xpath('NewType')};//hidden[internal]
	string Carrier {xpath('Carrier')};//hidden[internal]
	string CarrierCity {xpath('CarrierCity')};//hidden[internal]
	string CarrierState {xpath('CarrierState')};//hidden[internal]
	iesp.share.t_Date PhoneFirstSeen {xpath('PhoneFirstSeen')};
	iesp.share.t_Date PhoneLastSeen {xpath('PhoneLastSeen')};
	integer2 FDNPhoneInd {xpath('FDNPhoneInd')};
end;
		
export t_RollupBpsSearchDL := record
	string24 DriverLicense {xpath('DriverLicense')};
	string2 OriginState {xpath('OriginState')};
	iesp.share.t_Date EarliestIssueDate {xpath('EarliestIssueDate')};
	iesp.share.t_Date LatestExpirationDate {xpath('LatestExpirationDate')};
end;
		
export t_RollupBpsSearchSSN := record (iesp.share.t_SSNInfo)
	integer2 FDNSsnInd {xpath('FDNSsnInd')};
end;
		
export t_RollupBpsSearchRecord := record
	integer _Penalty {xpath('Penalty')};//hidden[ecldev]
	boolean Verified {xpath('Verified')};
	string UniqueId {xpath('UniqueId')};
	iesp.share.t_AddressEx Address {xpath('Address')};
	iesp.addressfeedback.t_AddressFeedback AddressFeedback {xpath('AddressFeedback')};//hidden[internal]
	dataset(t_RollupBpsSearchSource) Sources {xpath('Sources/Source'), MAXCOUNT(1)};
	dataset(iesp.share.t_NameWithGender) Names {xpath('Names/Name'), MAXCOUNT(iesp.Constants.BPS.ROLLUP_MAX_COUNT_NAMES)};
	dataset(t_RollupBpsSearchSSN) SSNs {xpath('SSNs/SSN'), MAXCOUNT(iesp.Constants.BPS.ROLLUP_MAX_COUNT_SSNS)};
	dataset(t_RollupBpsSearchPhone) Phones {xpath('Phones/Phone'), MAXCOUNT(iesp.Constants.BPS.ROLLUP_MAX_COUNT_PHONES)};
	dataset(t_RollupBpsSearchDate) Dates {xpath('Dates/Date'), MAXCOUNT(iesp.Constants.BPS.ROLLUP_MAX_COUNT_DATES)};
	iesp.share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	iesp.share.t_Date DateLastSeen {xpath('DateLastSeen')};
	iesp.bankruptcy.t_BankruptcyInfo Bankruptcy {xpath('Bankruptcy')};
	iesp.bpssearch.t_BpsRecordCounts Counts {xpath('Counts')};//hidden[internal]
	dataset(iesp.share.t_SourceDocInfo) SourceDocIds {xpath('SourceDocIds/SourceDocInfo'), MAXCOUNT(iesp.Constants.BPS.SOURCE_DOC_MAX_IDS)};//hidden[internal]
	iesp.share.t_SourceCounts SourceCounts {xpath('SourceCounts')};//hidden[internal]
	dataset(t_RollupBpsSearchDL) DLs {xpath('DLs/DL'), MAXCOUNT(iesp.Constants.BPS.ROLLUP_MAX_COUNT_DLS)};//hidden[internal]
	integer2 FDNUniqueIdInd {xpath('FDNUniqueIdInd')};
	integer2 FDNAddressInd {xpath('FDNAddressInd')};
	boolean FDNWafContribData {xpath('FDNWafContribData')};
	boolean FDNResultsFound {xpath('FDNResultsFound')};
	boolean FDNIndicatorsReturned {xpath('FDNIndicatorsReturned')};
end;
		
export t_RollupBpsSearchResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	integer SubjectTotalCount {xpath('SubjectTotalCount')};
	dataset(t_RollupBpsSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.Constants.BPS.ROLLUP_MAX_COUNT_RESPONSE_RECORDS)};
end;
		
export t_RollupBpsSearchRequest := record (iesp.fdn_share.t_FDNBaseRequest)
	t_RollupBpsSearchOption Options {xpath('Options')};
	t_RollupBpsSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_RollupBpsSearchResponseEx := record
	t_RollupBpsSearchResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from rollupbpssearch.xml. ***/
/*===================================================*/

