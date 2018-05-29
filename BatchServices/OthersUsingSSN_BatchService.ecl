
/*--SOAP--
<message name="OthersUsingSSN_BatchService">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
		
	<part name="MaxResults"           type="xsd:unsignedInt"/>
	<part name="max_results_per_acct" type="xsd:unsignedInt"/>
	
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
	<part name="ReturnSubjectAlso"  type="xsd:boolean"/>
    <part name="DataRestrictionMask" type="xsd:string"/>
</message>
*/

IMPORT BatchServices;

EXPORT OthersUsingSSN_BatchService(useCannedRecs = 'false') := 
	MACRO
  #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
		BOOLEAN return_subject_also := FALSE : STORED('ReturnSubjectAlso');

		// 1. Grab the input XML and throw into a dataset.	
		ds_batch_in_raw := IF( NOT useCannedRecs, 
		                   BatchServices.file_inBatchMaster(), 
		                   BatchServices._Sample_inBatchMaster() 
                      );	
		
		// 1b. Do project with  transform to convert any lower case input to upper case.
    ds_batch_in := project(ds_batch_in_raw,BatchServices.transforms.xfm_capitalize_input(LEFT));
		
		// 2. Get batch records.
		ds_results := BatchServices.OthersUsingSSN_BatchService_Records(ds_batch_in, return_subject_also);
		
		OUTPUT( ds_results, NAMED('Results') );		
				
	ENDMACRO;	
