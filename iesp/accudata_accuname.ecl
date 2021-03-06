/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from accudata_accuname.xml. ***/
/*===================================================*/

import iesp;

export accudata_accuname := MODULE
			
export t_AccudataCnamOptions := record (iesp.share.t_BaseOption)
	string TransactionType {xpath('TransactionType')}; //values['CNM2','']
	string50 ProductName {xpath('ProductName')};
end;
		
export t_AccudataCnamParams := record
	string19 RequestId {xpath('RequestId')};
	string10 Phone {xpath('Phone')};
end;
		
export t_ReplyData := record
	string CallingName {xpath('CallingName')};
	integer AvailabilityIndicator {xpath('AvailabilityIndicator')};
	integer PresentationIndicator {xpath('PresentationIndicator')};
end;
		
export t_AccudataCnamReport := record
	string CustomerId {xpath('CustomerId')};
	string RequestId {xpath('RequestId')};
	string TransactionType {xpath('TransactionType')};
	string Phone {xpath('Phone')};
	t_ReplyData Reply {xpath('Reply')};
	string ErrorMessage {xpath('ErrorMessage')};
end;
		
export t_AccudataCnamResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	t_AccudataCnamReport AccudataReport {xpath('AccudataReport')};
end;
		
export t_AccudataCnamRequest := record (iesp.share.t_BaseRequest)
	iesp.share.t_GatewayParams GatewayParams {xpath('GatewayParams')};
	t_AccudataCnamOptions Options {xpath('Options')};
	t_AccudataCnamParams SearchBy {xpath('SearchBy')};
end;
		
export t_AccudataCnamResponseEx := record
	t_AccudataCnamResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from accudata_accuname.xml. ***/
/*===================================================*/

