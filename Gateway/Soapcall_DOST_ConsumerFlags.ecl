import risk_indicators;

// accepts a dataset of input DID and SSN makes a soapcall to wsDBHandler service to check for security freeze and other FCRA flags in MBS
EXPORT Soapcall_DOST_ConsumerFlags(dataset(risk_indicators.layout_input) ds_in, string gateway_URL, integer timeout=1, integer retries=1) := function

Layout_Where := record
	string			lexid {xpath('lexid')};
	string			ssn {xpath('ssn')};
end;

Layout_SOAP_In := record
	Layout_Where		Where {xpath('Where')} ;
end;

layout_ResponseHeader := record
	string12 LexID;
	string200	ErrorMessage;
	unsigned	ErrorCode;
end;

// to get the wsdl, open the service on dev box
// http://espdev.br.seisint.com:9999/WsDbHandler/
layout_dbrecord := record
	integer dost_consumer_flag_id  {xpath('dost_consumer_flag_id')} ;
	string lexid  {xpath('lexid')} ;
  string ssn  {xpath('ssn')} ;
	string fname  {xpath('first_name')} ;
  string lname  {xpath('last_name')} ;
  integer security_freeze  {xpath('security_freeze')} ;
	integer id_theft_flag  {xpath('id_theft_flag')} ;
  integer security_fraud_alert  {xpath('security_fraud_alert')} ;
  integer consumer_statement_flag  {xpath('consumer_statement_flag')} ;
  integer dispute_flag  {xpath('dispute_flag')} ;
  integer negative_alert  {xpath('negative_alert')} ;
  integer prescreen_opt_out  {xpath('presreen_opt_out')} ;  // this flag is not in the PCR export
  string date_added  {xpath('date_added')} ;
  string user_added  {xpath('user_added')} ;
  string date_changed  {xpath('date_changed')} ;
  string user_changed  {xpath('user_changed')} ;
end;

layout_MbsDostDostConsumerFlagSelectResponse := record
	integer RecordCount {xpath('RecordCount')} ;
	dataset(layout_dbrecord) dbrecords {xpath('Records/Record'), MAXCOUNT(1)};
end;

layout_soap_out := record
	unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	layout_ResponseHeader responseHeader;
	layout_MbsDostDostConsumerFlagSelectResponse;
end;


layout_soap_out errX(layout_soap_In le) := transform
	self.responseHeader.ErrorMessage := FAILMESSAGE;
	self.responseHeader.ErrorCode := FAILCODE;
	self.responseHeader.LexID := le.where.lexid;
	self := [];
end;

// search MBS by DID.  If did is not populated, search by SSN as a backup
layout_soap_in into_in(risk_indicators.layout_input le) := transform
	self.where.LexID := if(le.did=0, '', trim((string)le.did) );
	self.where.ssn:= if(le.did=0, trim(le.ssn), '' ) ;
	self := [];
end;

// project potential applicants into the soap input structure
soap_in := project(ds_in(did<>0 or ssn<>''), into_in(left));

soap_out := 
if (gateway_URL != '', 
				soapcall(soap_in,
				gateway_URL,
				'MbsDostDostConsumerFlagSelect',
				{soap_In},  
				dataset(layout_soap_out),
				XPATH('MbsDostDostConsumerFlagSelectResponse'),
				ONFAIL(errX(left)), 
				timeout(timeout), 
				retry(retries))
		);

// output(ds_in, named('ds_in'));
// output(soap_in, named('soap_in'));
// output(soap_out, named('soap_out'));

return soap_out;

end;