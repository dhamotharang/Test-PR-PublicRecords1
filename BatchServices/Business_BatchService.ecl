
/*--SOAP--
<message name="Business_BatchService">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/>
	<part name="Phonetics"            type="xsd:boolean"/>
	<part name="Nicknames"            type="xsd:boolean"/>

	<part name="Match_Name"           type="xsd:boolean"/>
	<part name="Match_Comp_Name"      type="xsd:boolean"/>
	<part name="Match_Street_Address" type="xsd:boolean"/>
	<part name="Match_City"           type="xsd:boolean"/>
	<part name="Match_State"          type="xsd:boolean"/>
	<part name="Match_Zip"            type="xsd:boolean"/>
	<part name="Match_Phone"          type="xsd:boolean"/>
	<part name="Match_SSN"            type="xsd:boolean"/>
	<part name="Match_FEIN"           type="xsd:boolean"/>
	<part name="Match_DOB"            type="xsd:boolean"/>

	<part name="MaxResults"           type="xsd:unsignedInt"/>

	<part name="PenaltThreshold"      type="xsd:unsignedInt"/>

	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/

IMPORT BatchServices;

EXPORT Business_BatchService(useCannedRecs = 'false') :=
	MACRO

		#constant('SearchIgnoresAddressOnly',false)
		#stored('ScoreThreshold', 10)

		mod_access := Doxie.Compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());

		// To run this service using canned records for deve/debugging purposes, ensure useCannedRecs == true.
		Pre_result := BatchServices.Business_BatchService_Records(useCannedRecs, mod_access);
		ut.mac_TrimFields(Pre_result, 'Pre_result', result);
		OUTPUT(result, NAMED('Results'));

	ENDMACRO;
