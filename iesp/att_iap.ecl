/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from att_iap.xml. ***/
/*===================================================*/

import iesp;

export att_iap := MODULE
			
export t_IapOptions := record (iesp.share.t_BaseOption)
	string QueryType {xpath('QueryType')}; //values['DQ_IRS','DQ_ComCheck','']
	string50 ProductName {xpath('ProductName')};
end;
		
export t_IapEchoData := record
	string8 TransactionId {xpath('TransactionId')};
	iesp.share.t_Date TransactionDate {xpath('TransactionDate')};
	iesp.share.t_Time TransactionTime {xpath('TransactionTime')};
	string30 Custom1 {xpath('Custom1')};
	string30 Custom2 {xpath('Custom2')};
	string30 Custom3 {xpath('Custom3')};
end;
		
export t_IapInformationRetrievalService := record
	string10 QueryNumber {xpath('QueryNumber')};
	boolean IncludeRoutingNumber {xpath('IncludeRoutingNumber')};
	boolean IncludeAccountOwner {xpath('IncludeAccountOwner')};
	boolean IncludeCarrierName {xpath('IncludeCarrierName')};
	boolean IncludeCategory {xpath('IncludeCategory')};
	boolean IncludeLocalAccessAndTransport {xpath('IncludeLocalAccessAndTransport')};
	boolean IncludeCityState {xpath('IncludeCityState')};
end;
		
export t_IapQuery := record
	t_IapInformationRetrievalService InformationRetrievalService {xpath('InformationRetrievalService')};
	boolean DataGatewayComCheck {xpath('DataGatewayComCheck')};
end;
		
export t_IapMessage := record
	string CustomerID {xpath('CustomerID')};
	t_IapEchoData EchoData {xpath('EchoData')};
	t_IapQuery Query {xpath('Query')};
end;
		
export t_IapInformationRetrievalResponse := record
	string DataGatewayReplyCode {xpath('DataGatewayReplyCode')};
	string PointCode {xpath('PointCode')};
	string RoutingNumber {xpath('RoutingNumber')};
	string AccountOwner {xpath('AccountOwner')};
	string CarrierName {xpath('CarrierName')};
	string Category {xpath('Category')};
	string LocalAccessAndTransport {xpath('LocalAccessAndTransport')};
	string CityState {xpath('CityState')};
end;
		
export t_IapDataGatewayComCheck := record
	string Status {xpath('Status')};
end;
		
export t_IapResponseData := record
	string Status {xpath('Status')};
	t_IapInformationRetrievalResponse InformationRetrievalResponse {xpath('InformationRetrievalResponse')};
	t_IapDataGatewayComCheck DataGatewayComCheck {xpath('DataGatewayComCheck')};
end;
		
export t_IapResponseMessage := record
	string CustomerID {xpath('CustomerID')};
	t_IapEchoData EchoData {xpath('EchoData')};
	t_IapResponseData AttResponse {xpath('AttResponse')};
end;
		
export t_AttIapQueryResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	t_IapResponseMessage AttMessage {xpath('AttMessage')};
end;
		
export t_AttIapQueryRequest := record (iesp.share.t_BaseRequest)
	iesp.share.t_GatewayParams GatewayParams {xpath('GatewayParams')};
	t_IapOptions Options {xpath('Options')};
	t_IapMessage SearchBy {xpath('SearchBy')};
end;
		
export t_AttIapQueryResponseEx := record
	t_AttIapQueryResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from att_iap.xml. ***/
/*===================================================*/

