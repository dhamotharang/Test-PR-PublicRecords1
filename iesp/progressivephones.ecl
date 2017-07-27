/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from progressivephones.xml. ***/
/*===================================================*/

import iesp;
export progressivephones := MODULE
			
export t_ProgressivePhonesSearchOption := record (iesp.share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean UseNicknames {xpath('UseNicknames')};
	boolean UsePhonetics {xpath('UsePhonetics')};
	boolean KeepSamePhoneInDiffLevels {xpath('KeepSamePhoneInDiffLevels')};
	boolean DedupeAgainstInputPhones {xpath('DedupeAgainstInputPhones')};
	boolean IncludePhonesFeedback {xpath('IncludePhonesFeedback')};
	boolean IncludeBusinessPhone {xpath('IncludeBusinessPhone')};
	boolean IncludeLandlordPhone {xpath('IncludeLandlordPhone')};
	boolean IncludeNonCellPhonesPlusData {xpath('IncludeNonCellPhonesPlusData')};
	boolean IncludeLastResort {xpath('IncludeLastResort')};//hidden[internal]
	boolean StrictAPSXMatch {xpath('StrictAPSXMatch')};
	boolean BlankOutDuplicatePhones {xpath('BlankOutDuplicatePhones')};
	boolean IncludeDeadContacts {xpath('IncludeDeadContacts')};
	integer UniqueIDConfidenceTreshold {xpath('UniqueIDConfidenceTreshold')};
	boolean SkipPhoneScoring {xpath('SkipPhoneScoring')};
	boolean ReturnScore {xpath('ReturnScore')};
	integer MaxPhoneCount {xpath('MaxPhoneCount')};
	integer EDACount {xpath('EDACount')};
	integer SkipTraceCount {xpath('SkipTraceCount')};
	integer ProgressiveAddressCount {xpath('ProgressiveAddressCount')};
	integer SpouseCount {xpath('SpouseCount')};
	integer ParentsCount {xpath('ParentsCount')};
	integer ClosestRelativesCount {xpath('ClosestRelativesCount')};
	integer CoResidentCount {xpath('CoResidentCount')};
	integer ExpandedSkipTraceCount {xpath('ExpandedSkipTraceCount')};
	integer PhonesPlusCount {xpath('PhonesPlusCount')};
	integer UnverifiedCount {xpath('UnverifiedCount')};
	integer ClosestNeighborCount {xpath('ClosestNeighborCount')};
	integer PAWCount {xpath('PAWCount')};
	integer PossibleRelocationCount {xpath('PossibleRelocationCount')};
	integer TypeThTryHarderCount {xpath('TypeThTryHarderCount')};
	integer InputCount {xpath('InputCount')};
	boolean DynamicOrdering {xpath('DynamicOrdering')};
	integer EDAOrder {xpath('EDAOrder')};
	integer SkipTraceOrder {xpath('SkipTraceOrder')};
	integer ProgressiveAddressOrder {xpath('ProgressiveAddressOrder')};
	integer SpouseOrder {xpath('SpouseOrder')};
	integer ParentsOrder {xpath('ParentsOrder')};
	integer ClosestRelativesOrder {xpath('ClosestRelativesOrder')};
	integer CoResidentOrder {xpath('CoResidentOrder')};
	integer ExpandedSkipTraceOrder {xpath('ExpandedSkipTraceOrder')};
	integer PhonesPlusOrder {xpath('PhonesPlusOrder')};
	integer UnverifiedOrder {xpath('UnverifiedOrder')};
	integer ClosestNeighborOrder {xpath('ClosestNeighborOrder')};
	integer PAWOrder {xpath('PAWOrder')};
	integer PossibleRelocationOrder {xpath('PossibleRelocationOrder')};
	integer TypeThTryHarderOrder {xpath('TypeThTryHarderOrder')};
	string ScoreModel {xpath('ScoreModel')};
	integer MaxNumAssociate {xpath('MaxNumAssociate')};//hidden[internal]
	integer MaxNumAssociateOther {xpath('MaxNumAssociateOther')};//hidden[internal]
	integer MaxNumFamilyOther {xpath('MaxNumFamilyOther')};//hidden[internal]
	integer MaxNumFamilyClose {xpath('MaxNumFamilyClose')};//hidden[internal]
	integer MaxNumParent {xpath('MaxNumParent')};//hidden[internal]
	integer MaxNumSpouse {xpath('MaxNumSpouse')};//hidden[internal]
	integer MaxNumNeighbor {xpath('MaxNumNeighbor')};//hidden[internal]
	integer MaxNumSubject {xpath('MaxNumSubject')};//hidden[internal]
end;
		
export t_DedupeInfo := record
	dataset(iesp.share.t_StringArrayItem) Phones {xpath('Phones/Item'), MAXCOUNT(iesp.Constants.ProgPhones.MaxDedupePhones)};
end;
		
export t_ProgressivePhonesSearchBy := record
	string SSN {xpath('SSN')};
	string UniqueId {xpath('UniqueId')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	t_DedupeInfo DedupeInfo {xpath('DedupeInfo')};
end;
		
export t_ProgressivePhonesSearchRecord := record
	string12 PhoneType {xpath('PhoneType')};
	string UniqueId {xpath('UniqueId')};
	iesp.share.t_Name Name {xpath('Name')};
	string ListedName {xpath('ListedName')};
	string Phone10 {xpath('Phone10')};
	string TimeZone {xpath('TimeZone')};
	string CarrierName {xpath('CarrierName')};
	string25 CarrierCity {xpath('CarrierCity')};
	string2 CarrierState {xpath('CarrierState')};
	string NewType {xpath('NewType')};
	iesp.share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	iesp.share.t_Date DateLastSeen {xpath('DateLastSeen')};
	iesp.phonesfeedback.t_PhonesFeedback PhoneFeedback {xpath('PhoneFeedback')};
	iesp.share.t_Address Address {xpath('Address')};
	string3 PhoneScore {xpath('PhoneScore')};
	string40 SubjPhonePossibleRelationship {xpath('SubjPhonePossibleRelationship')};//hidden[internal]
	string15 SubjPhonePossibleTimezone {xpath('SubjPhonePossibleTimezone')};//hidden[internal]
	string15 SubjPhoneAddressZipcodeTimezone {xpath('SubjPhoneAddressZipcodeTimezone')};//hidden[internal]
	string15 SubjTimezoneMatchFlag {xpath('SubjTimezoneMatchFlag')};//hidden[internal]
	string8 SubjPhonePortedDate {xpath('SubjPhonePortedDate')};//hidden[internal]
	string3 SubjPhoneSeenFreq {xpath('SubjPhoneSeenFreq')};//hidden[internal]
	string3 SubjPhoneAge {xpath('SubjPhoneAge')};//hidden[internal]
	string1 SubjPhoneTransientFlag {xpath('SubjPhoneTransientFlag')};//hidden[internal]
	string2 Source {xpath('Source')};//hidden[ecldev]
	string20 ServiceVersion {xpath('ServiceVersion')};//hidden[ecldev]
end;
		
export t_ProgressivePhonesSearchResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_ProgressivePhonesSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.Constants.ProgPhones.MaxCountPhoneRecords)};
end;
		
export t_ProgressivePhonesSearchRequest := record (iesp.share.t_BaseRequest)
	t_ProgressivePhonesSearchBy SearchBy {xpath('SearchBy')};
	t_ProgressivePhonesSearchOption Options {xpath('Options')};
end;
		
export t_ProgressivePhonesSearchResponseEx := record
	t_ProgressivePhonesSearchResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from progressivephones.xml. ***/
/*===================================================*/

