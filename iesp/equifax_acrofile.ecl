/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from equifax_acrofile.xml. ***/
/*===================================================*/

import iesp;
export equifax_acrofile := MODULE
			
export t_EquifaxAcrofileRequestOptions := record (iesp.share.t_BaseOption)
	string PermissiblePurpose {xpath('PermissiblePurpose')};
	string DecryptionKeyName {xpath('DecryptionKeyName')};
	string DaytonRiskViewSubscriptionNumber {xpath('DaytonRiskViewSubscriptionNumber')};//hidden[internal]
end;
		
export t_EquifaxAcrofileSearchBy := record
	iesp.equifax_ccr_inquiry_segments.t_EqDial Dial {xpath('Dial')};
	iesp.equifax_ccr_inquiry_segments.t_EqIdentity Identity {xpath('Identity')};
	dataset(iesp.equifax_ccr_inquiry_segments.t_EqAddress) Addresses {xpath('Addresses/Address'), MAXCOUNT(2)};
	iesp.equifax_ccr_inquiry_segments.t_EqEmployment Employment {xpath('Employment')};
	iesp.equifax_ccr_inquiry_segments.t_EqEndUser EndUser {xpath('EndUser')};
	iesp.equifax_ccr_inquiry_segments.t_EqProductCode ProductCode {xpath('ProductCode')};
	iesp.equifax_ccr_inquiry_segments.t_EqProductInfo ProductInfo {xpath('ProductInfo')};
	dataset(iesp.equifax_ccr_inquiry_segments.t_EqModelData) Models {xpath('Models/Model'), MAXCOUNT(10)};
end;
		
export t_EQResponseHeader := record
	integer Status {xpath('Status')};
	string256 Message {xpath('Message')};
	string50 QueryId {xpath('QueryId')};
	string16 TransactionId {xpath('TransactionId')};
	dataset(iesp.share.t_WsException) Exceptions {xpath('Exceptions/Item'), MAXCOUNT(iesp.Constants.MaxResponseExceptions)};
end;
		
export t_EquifaxAcrofileResponse := record
	t_EQResponseHeader _Header {xpath('Header')};
	iesp.ws_credit_share.t_EclErrorStruct EclError {xpath('EclError')};
	iesp.equifax_ccr_share.t_EqCCRError Error {xpath('Error')};
	iesp.equifax_ccr_share.t_EqCCRModelError ModelError {xpath('ModelError')};
	iesp.equifax_ccr_response_segments.t_EquifaxCCRReport Report {xpath('Report')};
	iesp.equifax_ccr_response_segments.t_EquifaxCCRReport JointReport {xpath('JointReport')};
	iesp.equifax_ccr_share.t_EqEndTag EndTag {xpath('EndTag')};
end;
		
export t_EquifaxAcrofileRequest := record (iesp.share.t_BaseRequest)
	iesp.share.t_GatewayParams GatewayParams {xpath('GatewayParams')};
	t_EquifaxAcrofileRequestOptions Options {xpath('Options')};
	t_EquifaxAcrofileSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_EquifaxAcrofileResponseEx := record
	t_EquifaxAcrofileResponse Response {xpath('Response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from equifax_acrofile.xml. ***/
/*===================================================*/

