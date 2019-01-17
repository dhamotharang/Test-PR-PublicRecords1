/*--SOAP--
<message name="Batch_Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="MaxResults" type="xsd:unsignedInt"/>
	<part name="Max_results_per_acct" type="xsd:unsignedInt"/>
	<part name="Return_Current_Only" type="xsd:boolean"/>
	<part name="Run_Deep_Dive" type="xsd:boolean"/>
	<part name="PenaltThreshold" type="xsd:unsignedInt"/>
	<part name="IncludeNonDMVSources" type="xsd:boolean"/>
</message>
*/

IMPORT Autokey_batch, DriversV2, DriversV2_Services, UT, WSInput,AutoheaderV2;

EXPORT Batch_Service() := FUNCTION

 #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
	//The following macro defines the field sequence on WsECL page of query. 
	WSInput.MAC_DriversV2_Services_Batch_Service();
	
	data_in := DATASET([], Autokey_batch.Layouts.rec_inBatchMaster) : STORED('batch_in', FEW);
		
	cfgs := MODULE(DriversV2_Services.GetDLParams.batch_params)
		EXPORT useAllLookups := TRUE;
		EXPORT skip_set := DriversV2.Constants.autokey_skipSet;
		EXPORT UNSIGNED8 MaxResultsPerAcct := 2000 : STORED('Max_results_per_acct');
		EXPORT boolean return_current_only	:= FALSE : STORED('Return_Current_Only');
	END;
	
	recs := DriversV2_Services.Batch_Service_Records(data_in, cfgs, TRUE);
	ut.mac_TrimFields(recs, 'recs', result);

	RETURN OUTPUT(result, NAMED('RESULTS'), ALL);

END;