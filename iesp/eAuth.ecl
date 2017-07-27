export eAuth := MODULE
			
export t_EAuthOption := record (share.t_BaseOption)
	boolean IsDeceased {xpath('IsDeceased')};
	boolean GetMultipleCorrect {xpath('GetMultipleCorrect')};
	boolean GetDOD {xpath('GetDOD')};
	boolean GetDOB {xpath('GetDOB')};
	boolean VerifySSN {xpath('VerifySSN')};
	boolean IncludeCurrentProperty {xpath('IncludeCurrentProperty')};
end;
		
export t_QuestionReq := record
	integer NumAnswers {xpath('NumAnswers')};
	integer NumValid {xpath('NumValid')};
	string12 Id {xpath('Id')}; //values['county1','ssn1','zip1','city1','city2','city3','city4','city5','city6','people1','property1','property2','property3','property4','property5','property6','property7','vehicle1','vehicle2','vehicle3','vehicle4','vehicle5','address1','']
end;
		
export t_EAuthBy := record
	share.t_Name Name {xpath('Name')};
	string11 SSN {xpath('SSN')};
	string4 SSNLast4 {xpath('SSNLast4')};
	string12 UniqueId {xpath('UniqueId')};
	share.t_Address Address {xpath('Address')};
	dataset(t_QuestionReq) Questions {xpath('Questions/Question'), MAXCOUNT(iesp.Constants.EAUTHORIZE.MaxQuestions), embedded};
end;
		
export t_Answer := record
	string Value {xpath('Value'), maxlength(128)};
	boolean _IsValid {xpath('IsValid')};
end;
		
export t_SubQuestion := record
	string Prompt {xpath('Prompt'), maxlength(128)};
	string Answer {xpath('Answer'), maxlength(128)};
end;
		
export t_QuestionResp := record
	string12 Id {xpath('Id')};
	string128 Prompt {xpath('Prompt'), maxlength(128)};
	boolean MultipleCorrect {xpath('MultipleCorrect')};
	dataset(t_Answer) Answers {xpath('Answers/Answer'), MAXCOUNT(iesp.Constants.EAUTHORIZE.MaxAnswers+1)};
	dataset(t_SubQuestion) SubQuestions {xpath('SubQuestions/SubQuestion'), MAXCOUNT(iesp.Constants.EAUTHORIZE.MaxAnswers+1)};
	dataset(share.t_StringArrayItem) InvalidAnswers {xpath('InvalidAnswers/Item'), MAXCOUNT(iesp.Constants.EAUTHORIZE.MaxInvalidAnswers+1)};
end;

export t_EAuthResponse := record, MAXLENGTH (690230)
	share.t_ResponseHeader _Header {xpath('Header')};
	share.t_Date DOB {xpath('DOB')};
	share.t_Date DOD {xpath('DOD')};
	share.t_Date SSNIssuedStartDate {xpath('SSNIssuedStartDate')};
	share.t_Date SSNIssuedEndDate {xpath('SSNIssuedEndDate')};
	boolean Deceased {xpath('Deceased')};
	dataset(t_QuestionResp) Questions {xpath('Questions/Question'), MAXCOUNT(iesp.Constants.EAUTHORIZE.MaxQuestions)};
	string5 SSNValid {xpath('SSNValid')}; //values['no','yes','maybe','']
end;
		
export t_EAuthRequest := record (share.t_BaseRequest)
	t_EAuthOption Options {xpath('Options')};
	t_EAuthBy SearchBy {xpath('SearchBy')};
end;
		
export t_EAuthResponseEx := record
	t_EAuthResponse response {xpath('response')};
end;
		

end;
