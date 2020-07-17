/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from okc_courtrunner_request.xml. ***/
/*===================================================*/

import iesp;

export okc_courtrunner_request := MODULE

export t_OkcCourtRunnerOptions := record (iesp.share.t_BaseOption)
	string32 TransactionId {xpath('TransactionId')};
end;

export t_OkcCourtRunnerSearchBy := record
    integer ProceedingTypeId {xpath('ProceedingTypeId')}; //values['1','2','']
    string17 RMSId {xpath('RMSId')};
end;

export t_OkcCourtRunnerResult := record
	string36 TaskId {xpath('TaskId')};
	boolean IsValid {xpath('IsValid')};
	boolean IsSuccess {xpath('IsSuccess')};
	dataset(iesp.share.t_StringArrayItem) Messages {xpath('Messages/Message'), MAXCOUNT(1)};
end;

export t_OkcCourtRunnerResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	t_OkcCourtRunnerResult Result {xpath('Result')};
end;

export t_OkcCourtRunnerRequest := record (iesp.share.t_BaseRequest)
	t_OkcCourtRunnerOptions Options {xpath('Options')};
	t_OkcCourtRunnerSearchBy SearchBy {xpath('SearchBy')};
end;

export t_OkcCourtRunnerResponseEx := record
	t_OkcCourtRunnerResponse response {xpath('response')};
end;


end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from okc_courtrunner_request.xml. ***/
/*===================================================*/

