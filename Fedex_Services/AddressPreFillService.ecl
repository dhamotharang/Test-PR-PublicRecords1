/*--SOAP--
<message name="AddressPreFillServiceRequest" fast_display = "true">
  <part name="LastName" type="xsd:string"/>
  <part name="Addr" type="xsd:string"/>
  <part name="PrimRange" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="Phone" type="xsd:string"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
  <part name="ScoreThreshold" type="xsd:unsignedInt"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
  <part name="DialContactPrecision" type="xsd:unsignedInt"/>
	<part name="AddressOrigin" type="xsd:unsignedInt"/>
	<part name="CustomerDataOnly" type="xsd:boolean"/>
	<part name="CustomerDataMaxRecords" type="xsd:unsignedInt"/>
	<part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
	<part name="SkipRecords" type="xsd:unsignedInt"/>
</message>
*/

export AddressPreFillService := macro
#constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
#constant('AllowLeadingLname',true);
#constant('IncludeZeroDIDRefs',true);
#stored('ScoreThreshold',fedex_services.Contants.ScoreThreshold);

#constant('IsPRP', true);
doxie.MAC_Header_Field_Declare();

res_unm := Fedex_Services.mod_AddressPreFill.Records;
doxie.MAC_Marshall_Results(res_unm, res)
output(res, named(doxie.strResultsName));
output(Fedex_Services.mod_AddressPreFill.isMultiStateReturn, named('isMultiStateReturn'));

ENDMACRO;