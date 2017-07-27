
/*--SOAP--
<message name="SOS_Batch_Service">
	<part name="batch_in"    type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="IsSearch"    type="xsd:boolean"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose"  type="xsd:byte"/>
	<part name="MaxResults"  type="xsd:unsignedInt"/>
	<part name="Return_Current_Only" type="xsd:boolean"/>
	<part name="PenaltThreshold" type="xsd:unsignedInt"/>
	<part name="BIPFetchLevel"        type="xsd:string"/>
</message>
*/

IMPORT Autokey_batch, BatchServices, AutokeyB2, AutoStandardI, ut, BIPV2, STD;

EXPORT SOS_Batch_Service() := FUNCTION
	
	BOOLEAN return_current_only := FALSE : STORED('Return_Current_Only');
	UNSIGNED2 maxRecsPerInput   := 0     : STORED('MaxResults');
	STRING1 BIPFetchLevel := BIPV2.IDconstants.Fetch_Level_SELEID	 : STORED('BIPFetchLevel');

	ds_batch_in := DATASET([], Corp2_services.layouts.layout_batch_in) : STORED('batch_in', FEW);
	corp_filings := Corp2_services.SOS_Batch_Service_Records( ds_batch_in, return_current_only, maxRecsPerInput, STD.Str.touppercase(BIPFetchLevel));

	// DEBUGs:          
	// OUTPUT(corp_filings.res_outPLfat, NAMED('res_outPLfat'));
	// OUTPUT(corp_filings.res_outpl_filtered, NAMED('res_outpl_filtered'));
	// OUTPUT(corp_filings.res_input_plus_corp_keys_penalized, NAMED('res_input_plus_corp_keys_penalized'));
	// OUTPUT(corp_filings.res_input_plus_corp_keys_filtered, NAMED('res_input_plus_corp_keys_filtered'));
	// OUTPUT(corp_filings.res_corp_keys, NAMED('res_corp_keys'));

	
	ut.mac_TrimFields(corp_filings.results, 'corp_filings.results', results);		
	
	RETURN OUTPUT(results, NAMED('Results'));
	
END;