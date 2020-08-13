/*--SOAP--
<message name="BH_BDID_Service">
  <part name="CompanyName" type="xsd:string"/>
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="Phone" type="xsd:string"/>
  <part name="FEIN" type="xsd:string"/>
  <part name="BestAppend" type="xsd:string"/>
  <part name="BestVerify" type="xsd:string"/>
  <part name="Threshold" type="xsd:byte"/>
 </message>
*/
/*--INFO-- This service finds the best matching BDID, and optionally returns the best available info for that BDID and/or compares the best to the input data.*/

EXPORT BH_BDID_Service() := MACRO

STRING120 best_append_val1 := '' : stored('BestAppend');
STRING120 best_verify_val1 := '' : stored('BestVerify');
UNSIGNED1 threshold_value := 1 : stored('Threshold');
best_append_val := stringlib.StringToUpperCase(best_append_val1);
best_verify_val := stringlib.StringToUpperCase(best_verify_val1);

Business_Header.doxie_MAC_Field_Declare(true)

string DataRestrictionMask := AutoStandardI.Constants.DataRestrictionMask_default : STORED('DataRestrictionMask');
string DataPermissionMask := AutoStandardI.Constants.DataPermissionMask_default : STORED('DataPermissionMask');
Business_Header_SS.MAC_BDID_Append(
	precs,
	match_res,
	threshold_value)

Business_Header_SS.MAC_BestAppend(
	match_res,
	best_append_val,
	best_verify_val,
	best_res,
  DataPermissionMask,
  DataRestrictionMask,
	true
)

output(best_res)

endmacro;
