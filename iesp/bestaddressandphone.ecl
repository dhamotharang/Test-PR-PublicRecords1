export bestaddressandphone := MODULE
			
export t_BestAddressAndPhoneSearchBy := record
	string9 SSN {xpath('SSN')};
	string10 Phone10 {xpath('Phone10')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	share.t_Date DOB {xpath('DOB')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	dataset(share.t_Address) DedupAddresses {xpath('DedupAddresses/Address'), MAXCOUNT(10)};
	dataset(share.t_StringArrayItem) DedupPhones {xpath('DedupPhones/Phone10'), MAXCOUNT(10)};
end;
		
export t_BestAPPhoneMaxCounts := record
	integer EDA {xpath('EDA')};
	integer SkipTrace {xpath('SkipTrace')};
	integer ProgressiveAddress {xpath('ProgressiveAddress')};
	integer PossibleSpouse {xpath('PossibleSpouse')};
	integer PossibleParrents {xpath('PossibleParrents')};
	integer ClosestRelative {xpath('ClosestRelative')};
	integer Coresident {xpath('Coresident')};
	integer ExpandedSkipTrace {xpath('ExpandedSkipTrace')};
	integer PhonesPlus {xpath('PhonesPlus')};
	integer UnverifiedPhone {xpath('UnverifiedPhone')};
	integer ClosestNeighbor {xpath('ClosestNeighbor')};
	integer PeopleAtWork {xpath('PeopleAtWork')};
	integer PossibleRelocation {xpath('PossibleRelocation')};
end;
		
export t_BestAPPhoneSortOrder := record
	integer EDA {xpath('EDA')};
	integer SkipTrace {xpath('SkipTrace')};
	integer ProgressiveAddress {xpath('ProgressiveAddress')};
	integer PossibleSpouse {xpath('PossibleSpouse')};
	integer PossibleParrents {xpath('PossibleParrents')};
	integer ClosestRelative {xpath('ClosestRelative')};
	integer Coresident {xpath('Coresident')};
	integer ExpandedSkipTrace {xpath('ExpandedSkipTrace')};
	integer PhonesPlus {xpath('PhonesPlus')};
	integer UnverifiedPhone {xpath('UnverifiedPhone')};
	integer ClosestNeighbor {xpath('ClosestNeighbor')};
	integer PeopleAtWork {xpath('PeopleAtWork')};
	integer PossibleRelocation {xpath('PossibleRelocation')};
end;
		
export t_BestAPSearchOption := record (share.t_BaseSearchOptionEx)
	integer MaxAddressCount {xpath('MaxAddressCount')};
	integer MaxPhoneCount {xpath('MaxPhoneCount')};
	boolean IncludePhones {xpath('IncludePhones')};
	boolean UseNameUniqueID {xpath('UseNameUniqueID')};
	boolean IncludeDedupFlag {xpath('IncludeDedupFlag')};
	boolean IncludeBusinessPhone {xpath('IncludeBusinessPhone')};
	boolean IncludeLandlordPhone {xpath('IncludeLandlordPhone')};
	boolean MatchFirstAndLastName {xpath('MatchFirstAndLastName')};
	boolean MatchFirstName {xpath('MatchFirstName')};
	boolean MatchLastName {xpath('MatchLastName')};
	boolean MatchFullName {xpath('MatchFullName')};
	boolean MatchFirstInitialLastName {xpath('MatchFirstInitialLastName')};
	boolean DedupPartialAddress {xpath('DedupPartialAddress')};
	boolean DedupInputAddress {xpath('DedupInputAddress')};
	boolean DedupInputPhone {xpath('DedupInputPhone')};
	boolean StartWithNextMostCurrent {xpath('StartWithNextMostCurrent')};
	boolean EndWithNextMostCurrent {xpath('EndWithNextMostCurrent')};
	boolean KeepSamePhoneInDiffLevels {xpath('KeepSamePhoneInDiffLevels')};
	boolean UseCustomSortOrder {xpath('UseCustomSortOrder')};
	t_BestAPPhoneSortOrder CustomSortOrder {xpath('CustomSortOrder')};
	t_BestAPPhoneMaxCounts MaxPhoneCounts {xpath('MaxPhoneCounts')};
end;
		
export t_BestAPAddressRecord := record (share.t_Address)
	boolean RecordDeduped {xpath('RecordDeduped')};
	string120 ListingName {xpath('ListingName')};
	string10 Phone10 {xpath('Phone10')};
	share.t_Name Name {xpath('Name')};
	string9 SSN {xpath('SSN')};
	share.t_Date DOB {xpath('DOB')};
	integer NameScore {xpath('NameScore')};
	integer SSNScore {xpath('SSNScore')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
end;
		
export t_BestAPPhoneRecord := record
	string120 ListingName {xpath('ListingName')};
	string10 Phone10 {xpath('Phone10')};
	share.t_Name Name {xpath('Name')};
	string2 PhoneType {xpath('PhoneType')};
	string30 Carrier {xpath('Carrier')};
	string25 CarrierCity {xpath('CarrierCity')};
	string2 CarrierState {xpath('CarrierState')};
	string2 TypeNew {xpath('TypeNew')};
	string1 SwitchType {xpath('SwitchType')};
	integer SortOrder {xpath('SortOrder')};
	integer SortOrderInternal {xpath('SortOrderInternal')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
end;
		
export t_BestAddressAndPhoneRecords := record
	integer AddressCount {xpath('AddressCount')};
	integer PhoneCount {xpath('PhoneCount')};
	dataset(t_BestAPAddressRecord) Addresses {xpath('Addresses/Address'), MAXCOUNT(iesp.Constants.BAP_MAX_COUNT_SEARCH_ADDRESS_RESPONSE_RECORDS)};
	dataset(t_BestAPPhoneRecord) Phones {xpath('Phones/Phone'), MAXCOUNT(iesp.Constants.BAP_MAX_COUNT_SEARCH_PHONE_RESPONSE_RECORDS)};
end;

export t_BestAddressAndPhoneSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	t_BestAddressAndPhoneRecords Records {xpath('Records')};
end;
		
export t_BestAddressAndPhoneSearchRequest := record (share.t_BaseRequest)
	t_BestAPSearchOption Options {xpath('Options')};
	t_BestAddressAndPhoneSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_BestAddressAndPhoneSearchResponseEx := record
	t_BestAddressAndPhoneSearchResponse response {xpath('response')};
end;
		

end;

