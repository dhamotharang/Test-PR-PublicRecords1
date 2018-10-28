/*--SOAP--
<message name="LicPlate_Batch_Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="MaxResults" type="xsd:unsignedInt"/>
	<part name="ReturnCurrent" type="xsd:boolean"/>
	<part name="Run_Deep_Dive" type="xsd:boolean"/>
	<part name="PenaltThreshold" type="xsd:unsignedInt"/>
	<part name="FullNameMatch" type="xsd:boolean"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="IncludeNonRegulatedVehicleSources" type="xsd:boolean"/>
</message>
*/

IMPORT VehicleV2_Services;

EXPORT LicPlate_Batch_Service() := MACRO
 #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
	data_in := DATASET([], VehicleV2_Services.Batch_Layout.LicPlate_InLayout) : STORED('batch_in', FEW);
	
	mod := module(VehicleV2_Services.IParam.RTBatch_V2_params)
		export BOOLEAN ReturnCurrent	:= false :Stored('ReturnCurrent');
		export boolean FullNameMatch	:= FALSE : STORED('FullNameMatch');
		export boolean Is_UseDate			:= FALSE;
	end;
	
	res := VehicleV2_Services.LicPlate_Batch_Service_records(data_in,mod);
	OUTPUT(res, NAMED('Results'), ALL);

ENDMACRO;