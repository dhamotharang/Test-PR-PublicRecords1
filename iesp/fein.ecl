/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from fein.xml. ***/
/*===================================================*/

export fein := MODULE
			
export t_FEINSearchBy := record (share.t_BaseSearchBy)
	string TMSId {xpath('TMSId')};
	string FEIN {xpath('FEIN')};
	string CompanyName {xpath('CompanyName')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_FEINSearchOption := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean UsePhonetics {xpath('UsePhonetics')};
	boolean UseNicknames {xpath('UseNicknames')};
	boolean IncludeAlsoFound {xpath('IncludeAlsoFound')};
end;
		
export t_FEINContactInfo := record
	share.t_Name Name {xpath('Name')};
	string60 Title {xpath('Title')};
end;
		
export t_FEINCompanyInfo := record
	string CompanyName {xpath('CompanyName')};
	string120 TradeStyle {xpath('TradeStyle')};
	string8 SICCode {xpath('SICCode')};
	string120 SICDescription {xpath('SICDescription')};
	string16 Phone {xpath('Phone')};
	dataset(share.t_Address) AddressRecords {xpath('AddressRecords/AddressRecord'), MAXCOUNT(iesp.Constants.DNBFEIN.MAX_ADDRESSES)};
	dataset(t_FEINContactInfo) ContactRecords {xpath('ContactRecords/ContactRecord'), MAXCOUNT(iesp.Constants.DNBFEIN.MAX_CONTACTS)};
end;
		
export t_FEINBaseRecord := record
	share.t_BusinessIdentity BusinessIds {xpath('BusinessIds')};
	string100 IdValue {xpath('IdValue')};
	boolean AlsoFound {xpath('AlsoFound')};
	string TMSId {xpath('TMSId')};
	string FEIN {xpath('FEIN')};
	string FEINSource {xpath('FEINSource')};
	dataset(t_FEINCompanyInfo) FEINCompanyInfoRecords {xpath('FEINCompanyInfoRecords/FEINCompanyInfoRecord'), MAXCOUNT(iesp.Constants.DNBFEIN.MAX_COMPANIES)};
end;
		
export t_FEINSearchRecord := record (t_FEINBaseRecord)
	string255 ExternalKey {xpath('ExternalKey')};
end;
		
export t_FEINSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_FEINSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.Constants.DNBFEIN.MAX_COUNT_SEARCH_RECORDS)};
end;
		
export t_FEINSearchRequest := record (share.t_BaseRequest)
	t_FEINSearchBy SearchBy {xpath('SearchBy')};
	t_FEINSearchOption Options {xpath('Options')};
end;
		
export t_FEINSearchResponseEx := record
	t_FEINSearchResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from fein.xml. ***/
/*===================================================*/

