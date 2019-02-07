/*--SOAP--
<message name="Email_BatchService">
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="MaxResults" type="xsd:unsignedInt"/>
	<part name="ApplicationType" type="xsd:string"/>
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="max_results_per_acct" type="xsd:unsignedInt"/>	
	<part name="ReturnDetailedRoyalties" type="xsd:boolean"/>
	<part name="UseDMEmailSourcesOnly" type="xsd:boolean"/>	
</message>
*/

IMPORT BatchShare, BatchServices, Royalty, ut;

EXPORT Email_BatchService(useCannedRecs = 'false') := MACRO
	#constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
	#WEBSERVICE(FIELDS('DPPAPurpose', 'GLBPurpose', 'ApplicationType', 'batch_in', 'IndustryClass' , 'MaxResults', 'max_results_per_acct', 'ReturnDetailedRoyalties', 'UseDMEmailSourcesOnly'));
	
	ds_xml_in := DATASET([], BatchServices.Layouts.Email.rec_batch_email_input) : STORED('batch_in', FEW);
	batch_params := BatchServices.Email_BatchService_Interfaces.getBatchParams();
	
	BatchShare.MAC_SequenceInput(ds_xml_in, ds_sequenced);
	BatchShare.MAC_CapitalizeInput(ds_sequenced, ds_batch_in);

	batch_records := BatchServices.Email_BatchService_Records(batch_params, ds_batch_in, useCannedRecs);
	ds_results_rolled_flat := ROLLUP(batch_records.recs, GROUP, BatchServices.xfm_email_make_flat(LEFT, ROWS(LEFT)));

	BatchShare.MAC_RestoreAcctno(ds_batch_in,ds_results_rolled_flat, ds_output,,false);
	Royalty.MAC_RestoreAcctno(ds_batch_in, batch_records.dRoyalties, royalties);
	
	ut.mac_TrimFields(ds_output, 'ds_output', result);

	OUTPUT( result, NAMED('Results'));
	OUTPUT( royalties, NAMED('RoyaltySet'));
ENDMACRO;