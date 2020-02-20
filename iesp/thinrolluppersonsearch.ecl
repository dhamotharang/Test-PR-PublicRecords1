﻿/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from thinrolluppersonsearch.xml. ***/
/*===================================================*/

import iesp;

export thinrolluppersonsearch := MODULE
			
export t_ThinRpsSearchBy := record (iesp.share.t_BaseSearchBy)
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	integer ZipRadius {xpath('ZipRadius')};
	string Phone {xpath('Phone')};
	iesp.share.t_Date DOB {xpath('DOB')};
	iesp.share.t_IntRange AgeRange {xpath('AgeRange')};
end;
		
export t_ThinRpsSearchOptions := record (iesp.share.t_BaseSearchOption)
	string12 PreferredUniqueId {xpath('PreferredUniqueId')};
	boolean IncludeFullHistory {xpath('IncludeFullHistory')};
	boolean IncludeRelativeNames {xpath('IncludeRelativeNames')};
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean UsePhonetics {xpath('UsePhonetics')};
	boolean UseNicknames {xpath('UseNicknames')};
	boolean IncludePhoneIndicator {xpath('IncludePhoneIndicator')};
	boolean IncludePhones {xpath('IncludePhones')};
	boolean RelaxedMiddleNameMatch {xpath('RelaxedMiddleNameMatch')};
	boolean IncludeAllAddresses {xpath('IncludeAllAddresses')};
	boolean WidenSearchResults {xpath('WidenSearchResults')};
	boolean AlwaysReturnRecords {xpath('AlwaysReturnRecords')};
	boolean ForceLogging {xpath('ForceLogging')};//hidden[ecl_only]
	boolean SortAgeRange {xpath('SortAgeRange')};
end;
		
export t_ThinRpsAddress := record
	iesp.share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string City {xpath('City')};
	string2 State {xpath('State')};
	string5 Zip5 {xpath('Zip5')};
	string4 Zip4 {xpath('Zip4')};
	boolean PhoneIndicator {xpath('PhoneIndicator')};
	string14 Phone {xpath('Phone')};
	iesp.share.t_Date VendorDateLastSeen {xpath('VendorDateLastSeen')};//hidden[ecl_only]
	iesp.share.t_Date VendorDateFirstSeen {xpath('VendorDateFirstSeen')};//hidden[ecl_only]
end;
		
export t_ThinRpsDOB := record
	iesp.share.t_Date DOB {xpath('DOB')};
	integer Age {xpath('Age')};
end;
		
export t_ThinRpsRelative := record
	iesp.share.t_Name Name {xpath('Name')};
	string12 UniqueId {xpath('UniqueId')};
end;
		
export t_ThinRpsDOD := record
	iesp.share.t_Date DOD {xpath('DOD')};
	integer DeadAge {xpath('DeadAge')};
end;
		
export t_ThinRpsSearchRecord := record
	string UniqueId {xpath('UniqueId')};
	dataset(iesp.share.t_Name) Names {xpath('Names/Name'), MAXCOUNT(iesp.Constants.ThinRps.MaxCountNames)};
	dataset(t_ThinRpsAddress) Addresses {xpath('Addresses/Address'), MAXCOUNT(iesp.Constants.ThinRps.MaxCountAddresses)};
	dataset(t_ThinRpsDOB) DOBs {xpath('DOBs/Item'), MAXCOUNT(iesp.Constants.ThinRps.MaxCountDOBs)};
	dataset(t_ThinRpsDOD) DODs {xpath('DODs/Item'), MAXCOUNT(iesp.Constants.ThinRps.MaxCountDODs)};
	dataset(t_ThinRpsRelative) RelativesNew {xpath('RelativesNew/Relative'), MAXCOUNT(iesp.Constants.ThinRps.MaxCountRelatives)};
	dataset(iesp.share.t_Name) Relatives {xpath('Relatives/Relative'), MAXCOUNT(iesp.Constants.ThinRps.MaxCountRelatives)};
end;
		
export t_ThinRollupPersonSearchResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_ThinRpsSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.Constants.ThinRps.MaxCountResponseRecords)};
end;
		
export t_ThinRollupPersonSearchRequest := record (iesp.share.t_BaseRequest)
	t_ThinRpsSearchOptions Options {xpath('Options')};
	t_ThinRpsSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_ThinRollupPersonSearchResponseEx := record
	t_ThinRollupPersonSearchResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from thinrolluppersonsearch.xml. ***/
/*===================================================*/

