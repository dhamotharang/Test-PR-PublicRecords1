/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from bair_phonesearch.xml. ***/
/*===================================================*/

import iesp;

export bair_phonesearch := MODULE
			
export t_BAIRPhoneSearchOption := record (iesp.bair_share.t_BAIRBaseSearchOption)
	boolean ReturnScores {xpath('ReturnScores')};//hidden[internal]
	boolean IncludeEvents {xpath('IncludeEvents')};
	boolean IncludeCFS {xpath('IncludeCFS')};
	boolean SearchPhonesInNarratives {xpath('SearchPhonesInNarratives')};
end;
		
export t_BAIRPhoneSearchBy := record
	iesp.share.t_Name Name {xpath('Name')};
	iesp.bair_share.t_BAIRInputAddress Address {xpath('Address')};
	string SSN {xpath('SSN')};
	string LexId {xpath('LexId')};
	string PhoneNumber {xpath('PhoneNumber')};
end;
		
export t_BAIRPhone := record
	string Phone {xpath('Phone')};
	string Source {xpath('Source')};
end;
		
export t_BAIRPhoneSearchRecord := record
	string Phone {xpath('Phone')};
	string Source {xpath('Source')};
	string LexID {xpath('LexID')};
	iesp.share.t_Name Name {xpath('Name')};
	dataset(iesp.bair_share.t_BAIRAddressExt) Addresses {xpath('Addresses/Address'), MAXCOUNT(iesp.bair_constants.MAX_ADDR_PER_PHONE)};
	iesp.share.t_Date Date {xpath('Date')};
	dataset(iesp.bair_share.t_BAIREventRecord) EventRecords {xpath('EventRecords/EventRecord'), MAXCOUNT(iesp.bair_constants.MAX_RECS_PER_MODE)};
	dataset(iesp.bair_share.t_BAIRCFSRecord) CFSRecords {xpath('CFSRecords/CFSRecord'), MAXCOUNT(iesp.bair_constants.MAX_RECS_PER_MODE)};
	iesp.bair_share.t_BAIREIDRecord EIDInfo {xpath('EIDInfo')};
end;
		
export t_BAIRPhoneSearchResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_BAIRPhoneSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.bair_constants.MAX_SEARCH_RECS)};
end;
		
export t_BAIRPhoneSearchRequest := record
	iesp.bair_share.t_BAIRContext BAIRContext {xpath('BAIRContext')};//hidden[ecl_only]
	iesp.bair_share.t_BAIRUser User {xpath('User')};
	t_BAIRPhoneSearchOption Options {xpath('Options')};
	t_BAIRPhoneSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_BAIRPhoneSearchResponseEx := record
	t_BAIRPhoneSearchResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from bair_phonesearch.xml. ***/
/*===================================================*/

