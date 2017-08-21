#workunit('name','Inquiry Velocity Service')

import	iesp,risk_indicators,riskwise,ut;

ds_gateways := dataset([{'SP_SEARCHIDENTITYVELOCITYID','http://webapp_roxie_test:web33436$@gatewaycertesp.sc.seisint.com:7726/WsDbHandler/'}],risk_indicators.Layout_Gateways_In);

prii_layout	:=
RECORD
	string	AccountNumber;
	string	FirstName;
	string	MiddleName;
	string	LastName;
	string	StreetAddress;
	string	City;
	string	State;
	string	Zip;
	string	HomePhone;
	string	SSN;
	string	DateOfBirth;
	string	WorkPhone;
	string	income;  
	string	DLNumber;
	string	DLState;
	string	BALANCE; 
	string	CHARGEOFFD;  
	string	FormerName;
	string	EMAIL;  
	string	COMPANY;
	integer	historydateyyyymm;
	string	industry;
	string	product;
END;

dIn := dataset('~tfuerstenberg::in::kinecta_5078_id_velocity_all_all_in',prii_layout, csv(quote('"')));
// dIn	:=	choosen(DATASET(ut.foreign_prod+'~tfuerstenberg::in::kinecta_5078_id_velocity_money_all_in',prii_layout,csv(quote('"'))),500);

output(dIn,named('dIn'));

iesp.searchalert.t_SearchAlertRequest	tFormat2Soap(dIn	pInput)	:=
transform
	string	vHistoryDate	:=	(string)pInput.historydateyyyymm;
	string	vRollbackDate	:=	if(	length(vHistoryDate) = 8,
																ut.DateFrom_DaysSince1900(ut.DaysSince1900(vHistoryDate[1..4],vHistoryDate[5..6],vHistoryDate[7..8]) - 1),
																'00000000'
															);
	self.User.AccountNumber								:=	pInput.accountnumber;
	self.User.QueryID											:=	pInput.accountnumber;
	self.User.GLBPurpose									:=	'1';
	self.Options.Velocity									:=	true;
	
	self.SearchBy.UniqueID								:=	'';
	self.SearchBy.Industry								:=	if(pInput.industry	=	'','ALL',pInput.industry);
	self.SearchBy.Product									:=	if(pInput.product	=	'','ALL',pInput.product);
	self.SearchBy.Name										:=	row({'',pInput.FirstName,pInput.MiddleName,pInput.LastName,'',''},iesp.share.t_Name);
	self.SearchBy.Address.StreetAddress1	:=	pInput.StreetAddress;
	self.SearchBy.Address.City						:=	pInput.City;
	self.SearchBy.Address.State						:=	pInput.State;
	self.SearchBy.Address.Zip5						:=	pInput.Zip;
	self.SearchBy.SSN											:=	pInput.SSN;
	self.SearchBy.DOB											:=	row({(integer)pInput.DateOfBirth[1..4],(integer)pInput.DateOfBirth[5..6],(integer)pInput.DateOfBirth[7..8]},iesp.share.t_Date);
	self.SearchBy.Phone10									:=	pInput.HomePhone;
	
	self.SearchBy.RetroDate                 :=  case(   length(vHistoryDate),
																											8   =>  row({   (integer)vRollbackDate[1..4],
																																			(integer)vRollbackDate[5..6],
																																			(integer)vRollbackDate[7..8]
																																			},iesp.share.t_Date),
																											6   =>  row({   (integer)vHistoryDate[1..4],
																																			(integer)vHistoryDate[5..6],
																																			1
																																			},iesp.share.t_Date),
																											row([],iesp.share.t_Date)
																											);
	self																	:=	pInput;
	self																	:=	[];
end;

dIespRequest	:=	project(dIn,tFormat2Soap(left));

// Wrap request so that we create the root xml reqeust tag
rRequest_Layout	:=
record
	dataset(iesp.searchalert.t_SearchAlertRequest)	SearchAlertRequest;
  dataset(risk_indicators.Layout_Gateways_In)			gateways;
end;

rRequest_Layout	tRequest(dIespRequest	pInput)	:=
transform
	self.SearchAlertRequest	:=	pInput;
  self.gateways						:=	ds_gateways;
end;

dSoapRequest	:=	project(dIespRequest,tRequest(left));

output(dSoapRequest,named('dSoapRequest'));

roxieIP	:=	RiskWise.shortcuts.prod_batch_neutral;	//roxie batch ip prod

iesp.searchalert.t_SearchAlertResponse	myFail(dSoapRequest	l)	:=
transform
	self._Header.status		:=	failcode;
	self._Header.message	:=	if(failcode=0,'success',failmessage);
	self									:=	[];
end;

dSoapResponse	:=	soapcall(	dSoapRequest,
														roxieIP,
														'inquiry_services.Velocity_SearchService',
														{dSoapRequest},
														DATASET(iesp.searchalert.t_SearchAlertResponse),
														PARALLEL(30),
														onFail(myFail(LEFT))
													);

output(dSoapResponse,named('dSoapResponse'));

rOut_Layout	:=
record(prii_layout)
	string16	TransactionID;
	integer		ErrorCode;
	string256	ErrorMessage;
	string8		RetroDate;
	string		IndustryClass;
	unsigned2	Last24HoursCnt;
	unsigned2	Last7DaysCnt;
	unsigned2	Last30DaysCnt;
	unsigned2	Last90DaysCnt;
	unsigned2	Last12MonthsCnt;
	unsigned2	AllSearchPeriodsCnt;	
end;

rOut_Layout	tFormat2Out(prii_layout	le,dSoapResponse	ri)	:=
transform
	self.TransactionID				:=	ri._Header.TransactionID;
	self.ErrorCode						:=	if(	le.AccountNumber	=	ri._Header.QueryID,
																		ri._Header.Status,
																		-99
																	);
	self.ErrorMessage					:=	if(	le.AccountNumber	=	ri._Header.QueryID,
																		ri._Header.Message,
																		'Request timed out'
																	);
	self.RetroDate						:=	iesp.ECL2ESP.t_DateToString8(ri.InputEcho.RetroDate);
	self.IndustryClass				:=	ri.InputEcho.Industry;
	self.Last24HoursCnt				:=	ri.Records[1].SearchDateCounts(SearchPeriod	=	'LAST 24 HOURS')[1].SearchCount;
	self.Last7DaysCnt					:=	ri.Records[1].SearchDateCounts(SearchPeriod	=	'LAST 7 DAYS')[1].SearchCount;
	self.Last30DaysCnt				:=	ri.Records[1].SearchDateCounts(SearchPeriod	=	'LAST 30 DAYS')[1].SearchCount;
	self.Last90DaysCnt				:=	ri.Records[1].SearchDateCounts(SearchPeriod	=	'LAST 90 DAYS')[1].SearchCount;
	self.Last12MonthsCnt			:=	ri.Records[1].SearchDateCounts(SearchPeriod	=	'LAST 12 MONTHS')[1].SearchCount;
	self.AllSearchPeriodsCnt	:=	ri.Records[1].SearchDateCounts(SearchPeriod	=	'ALL TIME PERIODS')[1].SearchCount;
	self											:=	le;
end;

dOut	:=	join(	dIn,
								dSoapResponse,
								left.AccountNumber	=	right._Header.QueryID,
								tFormat2Out(left,right),
								left outer,
								hash
							);

output(dOut,named('dOut'));
output(dOut,,'~temp::out::inquiry_service',csv(heading(single),quote('"')),overwrite);