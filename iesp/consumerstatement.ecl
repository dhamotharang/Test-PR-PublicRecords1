/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from consumerstatement.xml. ***/
/*===================================================*/

export consumerstatement := MODULE
			
export t_ConsumerStatementSearchBy := record
	integer StatementId {xpath('StatementId')};
	string15 Phone10 {xpath('Phone10')};
	share.t_Address Address {xpath('Address')};
	string12 UniqueId {xpath('UniqueId')};//hidden[ecl_only]
end;
		
export t_ConsumerStatementOption := record (share.t_BaseSearchOptionEx)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean IncludeHistory {xpath('IncludeHistory')};
end;
		
export t_ConsumerStatementRecord := record
	integer StatementId {xpath('StatementId')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string10 Phone {xpath('Phone')};
	share.t_TimeStamp DateCreated {xpath('DateCreated')};
	share.t_TimeStamp DateSubmitted {xpath('DateSubmitted')};
	string Statement {xpath('Statement')};
	integer OverrideFlag {xpath('OverrideFlag')};
	integer _Penalty {xpath('Penalty')};//hidden[ecl_only]
	string12 UniqueId {xpath('UniqueId')};//hidden[ecl_only]
end;
		
export t_ConsumerStatementSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_ConsumerStatementRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.constants.MAX_CONSUMER_STATEMENTS)};
end;
		
export t_ConsumerStatementSearchRequest := record (share.t_BaseRequest)
	t_ConsumerStatementSearchBy SearchBy {xpath('SearchBy')};
	t_ConsumerStatementOption Options {xpath('Options')};
end;
		
export t_ConsumerStatementSearchResponseEx := record
	t_ConsumerStatementSearchResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from consumerstatement.xml. ***/
/*===================================================*/

