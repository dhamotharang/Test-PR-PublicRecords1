
/*--SOAP--
<message name="AKA_BatchService">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
	<part name="DataRestrictionMask"	type="xsd:string"/>
		
	<part name="MaxResults"           type="xsd:unsignedInt"/>
	<part name="max_results_per_acct" type="xsd:unsignedInt"/>
	
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DidLimit"             type="xsd:unsignedInt"/>
</message>
*/

IMPORT BatchServices;

EXPORT AKA_BatchService(useCannedRecs = 'false') := 
	MACRO

    #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
    UNSIGNED1 did_limit := 1 : STORED('DidLimit');
		
		// 1a. Grab the input XML and throw into a dataset.	
		ds_batch_in_raw := IF(NOT useCannedRecs, 
		                      BatchServices.file_inBatchMaster(), 
		                      BatchServices._Sample_inBatchMaster('AKA') 
                         );		
 
    // 1b. Do project with  transform to convert any lower case input to upper case.
    ds_batch_in := project(ds_batch_in_raw,BatchServices.transforms.xfm_capitalize_input(LEFT));
		
		ds_results := BatchServices.AKA_BatchService_Records(ds_batch_in, did_limit);
		
		OUTPUT( ds_results, NAMED('Results') );
		
	ENDMACRO;	
