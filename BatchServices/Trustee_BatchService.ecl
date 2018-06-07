/*--SOAP--
<message name="Trustee_BatchService">
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>		
	<part name="Chapter_Includes"	  type="xsd:string"/>
	<part name="DCode_Includes"  	  type="xsd:string"/>		
	<part name="DaysBack"		 	  type="xsd:unsignedInt"/>	
</message>
*/

IMPORT BatchServices;

export Trustee_BatchService() := 
	MACRO
	 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
		#OPTION('optimizeProjects', TRUE);
		#constant('isFCRA', false);

		/*	Grab the input XML and throw into a dataset. */
		ds_batch_in := DATASET([], BatchServices.layout_Trustee_Batch_in) : STORED('batch_in', FEW);
		
		ds_batch_in_valid := ds_batch_in(trusteeid not in BatchServices.Constants.Trustee.BAD_IDS);
		
		ds_in := ds_batch_in_valid;
						
		/* 	Send records through the bankruptcy batchservice trustee function. */
		ds_recs := BatchServices.Bankruptcy_BatchService_Records.trustee(ds_in, false);
		
		/* 	Search for Bk records by party. */
		ut.mac_TrimFields(ds_recs, 'ds_recs', result);
		
		OUTPUT(result, NAMED('Results'));		
		
	
	ENDMACRO;	

// BatchServices.Trustee_BatchService();