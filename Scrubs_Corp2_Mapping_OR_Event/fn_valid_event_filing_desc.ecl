import ut, corp2;
//****************************************************************************
//fn_valid_event_filing_desc: returns true or false based upon the incoming
//														code.
//****************************************************************************
export fn_valid_event_filing_desc(string code) := function
		isValidActionType := case(corp2.t2u(code),
														 'ANNUAL REPORT'												=> false,
														 'ANNUAL REPORT PAYMENT'								=> false,
														 'AMENDED ANNUAL REPORT'								=> false,
														 'AMNDMT TO ANNUAL RPT/INFO STATEMENT' 	=> false,
														 'CORRECTION OF ANNUAL'									=> false,
														 'IMAGE ANNUAL REPORT'									=> false,
														 'NOTICE LATE ANNUAL'										=> false,
														  true
														 );
		return if(isValidActionType,1,0);
end;
