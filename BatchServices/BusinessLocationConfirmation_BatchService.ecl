/*--SOAP--
<message name="BusinessLocationConfirmation_BatchService">

	<part name="GLBPurpose"             type="xsd:byte"/>
	<part name="DLPurpose"              type="xsd:byte"/>
	<part name="PenaltThreshold"        type="xsd:unsignedInt"/>
  <part name="IncludeRealTimePhones"  type="xsd:boolean"/> 
  <part name="Gateways"               type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="batch_in"               type="tns:XmlDataSet" cols="70" rows="25"/>

</message>
*/

EXPORT BusinessLocationConfirmation_BatchService := MACRO
 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
	// Layout of input data
	in_layout := BatchServices.BusinessLocationConfirmation_BatchService_Layouts.Input;
	
	// Grab input data from SOAP variable
	DATASET(in_layout) indata := DATASET([], in_layout) : STORED('batch_in', FEW);
	
	// Retrieve and output records
	OUTPUT(BatchServices.BusinessLocationConfirmation_BatchService_Records(indata), NAMED('Results'));
	
ENDMACRO;
