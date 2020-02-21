﻿/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from first_data.xml. ***/
/*===================================================*/

import iesp;

export first_data := MODULE
			
export t_FDCIRequestOptions := record (iesp.share.t_BaseOption)
end;
		
export t_FDCIAddress := record
	string AddressLine1 {xpath('AddressLine1')};
	string AddressLine2 {xpath('AddressLine2')};
	string City {xpath('City')};
	string State {xpath('State')};
	string ZipCode {xpath('ZipCode')};
end;
		
export t_FDCIRequest := record
	string MerchantId {xpath('MerchantId')};
	string TeleCheckProductName {xpath('TeleCheckProductName')};
	string VersionControl {xpath('VersionControl')};
	string ManualId {xpath('ManualId')};
	string SSN {xpath('SSN')};
	string SupplementalId {xpath('SupplementalId')};
	iesp.share.t_Date2 DOB {xpath('DOB')};
	string FullName {xpath('FullName')};
	string PhoneNumber {xpath('PhoneNumber')};
	t_FDCIAddress Address {xpath('Address')};
	string EchoData {xpath('EchoData')};
end;
		
export t_FDCheckingIndicators := record
	string ResponseCode {xpath('ResponseCode')};
	string TeleCheckTraceId {xpath('TeleCheckTraceId')};
	string DisplayText {xpath('DisplayText')};
	string ApprovalCode {xpath('ApprovalCode')};
	string DateTime {xpath('DateTime')};
	string EchoData {xpath('EchoData')};
	string Indicator1 {xpath('Indicator1')};
	string Indicator2 {xpath('Indicator2')};
	string Indicator3 {xpath('Indicator3')};
	string Indicator4 {xpath('Indicator4')};
	string Indicator5 {xpath('Indicator5')};
	string Indicator6 {xpath('Indicator6')};
	string Indicator7 {xpath('Indicator7')};
	string Indicator8 {xpath('Indicator8')};
	string Indicator9 {xpath('Indicator9')};
	string Indicator10 {xpath('Indicator10')};
	string Indicator11 {xpath('Indicator11')};
	string Indicator12 {xpath('Indicator12')};
	string Indicator13 {xpath('Indicator13')};
	string Indicator14 {xpath('Indicator14')};
	string Indicator15 {xpath('Indicator15')};
	string Indicator16 {xpath('Indicator16')};
	string Indicator17 {xpath('Indicator17')};
	string Indicator18 {xpath('Indicator18')};
	string Indicator19 {xpath('Indicator19')};
	string Indicator20 {xpath('Indicator20')};
	string Indicator21 {xpath('Indicator21')};
	string Indicator22 {xpath('Indicator22')};
	string Indicator23 {xpath('Indicator23')};
	string Indicator24 {xpath('Indicator24')};
	string Indicator25 {xpath('Indicator25')};
	string Indicator26 {xpath('Indicator26')};
	string Indicator27 {xpath('Indicator27')};
	string Indicator28 {xpath('Indicator28')};
	string Indicator29 {xpath('Indicator29')};
	string Indicator30 {xpath('Indicator30')};
end;
		
export t_FDCheckingIndicatorsResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	t_FDCheckingIndicators FDCheckingIndicators {xpath('FDCheckingIndicators')};
end;
		
export t_FDCheckingIndicatorsRequest := record (iesp.share.t_BaseRequest)
	iesp.share.t_GatewayParams GatewayParams {xpath('GatewayParams')};
	t_FDCIRequestOptions Options {xpath('Options')};
	t_FDCIRequest SearchBy {xpath('SearchBy')};
end;
		
export t_FDCheckingIndicatorsResponseEx := record
	t_FDCheckingIndicatorsResponse Response {xpath('Response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from first_data.xml. ***/
/*===================================================*/