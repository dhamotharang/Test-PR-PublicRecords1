/*--SOAP--
<message name="CompanyID_IndustryLookup_Service">
	<part name="Product_ID" type="xsd:string"/>
	<part name="Transaction_Type" type="xsd:string"/>
	<part name="Function_Name" type="xsd:string"/>
 </message>
*/
IMPORT std;
export Function_Description_Lookup_Service := MACRO

string4 input_ProductID := ''   : stored('Product_ID');
string2 input_Transaction_Type := ''   : stored('Transaction_Type');
string40 input_Function_Name := ''   : stored('Function_Name');

Results := choosen(Inquiry_AccLogs.key_lookup_function_desc(
keyed(s_product_id=std.Str.ToUpperCase(trim(input_ProductID))) and
keyed(s_transaction_type IN [std.Str.ToUpperCase(trim(input_transaction_type)), '']) and
keyed(s_function_name=std.Str.ToUpperCase(trim(input_Function_Name))) 
), 1);
			
output(Results, named('Results'));

ENDMACRO;