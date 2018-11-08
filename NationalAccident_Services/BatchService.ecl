/*--SOAP--
<message name="BatchService">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="MaxResults" type="xsd:unsignedInt"/>
	<part name="MaxResultsPerAcct" type="xsd:unsignedInt"/>	
	<part name="ReturnCurrent" type="xsd:boolean"/>
	<part name="PenaltThreshold" type="xsd:unsignedInt"/>
	<part name="EnableExtraAccidents" type="xsd:boolean"/>
</message>
*/

EXPORT BatchService() := MACRO
 #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
	#constant('StrictMatch', true)
	UNSIGNED2 MaxResultsPerAcct := 10 : STORED('MaxResultsPerAcct');
	BOOLEAN   EnableExtraAccidents := false : STORED('EnableExtraAccidents');

	data_in := DATASET([], NationalAccident_Services.Layouts.inBatchNationalAccident) : STORED('batch_in', FEW);
	
	res := NationalAccident_Services.BatchService_Records(data_in,MaxResultsPerAcct,EnableExtraAccidents);
	OUTPUT(res, NAMED('Results'), ALL);

ENDMACRO;
