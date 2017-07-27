/*--SOAP--
<message name="CompanyID_IndustryLookup_Service">
	<part name="CompanyID" type="xsd:string"/>
 </message>
*/

export CompanyID_IndustryLookup_Service := MACRO

string20 input_companyID := ''   : stored('CompanyID');

Results := choosen(Inquiry_AccLogs.Key_Inquiry_industry_use_vertical(FALSE)(keyed(s_company_id=input_companyID)), 1);
			
output(Results, named('Results'));

ENDMACRO;