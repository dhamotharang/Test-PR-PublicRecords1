
/*--SOAP--
<message name="Death_BatchService">
	<part name="DPPAPurpose"           type="xsd:byte"/>
	<part name="GLBPurpose"            type="xsd:byte" />
	<part name="DataRestrictionMask"   type="xsd:string"/>
	<part name="DataPermissionMask"    type="xsd:string"/>
	
	<part name="AddSupplemental"	     type="xsd:boolean"/>
	<part name="ExtraMatchCodes"	     type="xsd:boolean"/>
	<part name="PartialNameMatchCodes" type="xsd:boolean"/>
	<part name="MatchCode_ADL_Append"  type="xsd:boolean"/>
	<part name="ApplicationType"     	 type="xsd:string"/>
	<part name="batch_in"              type="tns:XmlDataSet" cols="70" rows="25"/>
	
	<part name="MatchCode_Includes"	   type="xsd:string"/>
	
	<part name="DaysBack"		 	         type="xsd:unsignedInt"/>	
	<part name="DID_Score_Threshold"   type="xsd:unsignedInt"/>
	<part name="IncludeBlankDOD"	     type="xsd:boolean"/>
	<part name="NoDIDAppend"           type="xsd:boolean"/>
</message>
*/


IMPORT DeathV2_Services,BatchShare;

EXPORT Death_BatchService(useCannedRecs = 'false') := 
	MACRO
		#constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
    #CONSTANT ('SaltLeadThreshold', 20); // lead threshold set here according to Linking Team's recommendation.
		batch_params		:= DeathV2_Services.IParam.getBatchParams();				
		// Grab the input XML and throw into a dataset.	
		ds_xml_in_raw  	:= DATASET([], DeathV2_Services.Layouts.BatchIn) : STORED('batch_in', FEW);
		ds_xml_in 			:= if( useCannedRecs, DeathV2_Services.BatchCannedInput, ds_xml_in_raw);					

		BatchShare.MAC_SequenceInput(ds_xml_in, ds_xml_in_seq);		
		BatchShare.MAC_CapitalizeInput(ds_xml_in_seq, ds_batch_in);		
		
		ds_recs := DeathV2_Services.BatchRecords(ds_batch_in, batch_params);
		BatchShare.MAC_RestoreAcctno(ds_batch_in, ds_recs, Pre_result,,false);		
		
		ut.mac_TrimFields(Pre_result, 'Pre_result', result);		
		OUTPUT(result,  NAMED('Results') );		
				
	ENDMACRO;	
	
// BatchServices.Death_BatchService();