
/*--SOAP--
<message name="PhoneAttributes_BatchService">
	<part name="batch_in"              					type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DataRestrictionMask" 						type="xsd:string"/>
	<part name="return_current"									type="xsd:boolean"/>
	<part name="include_temp_susp_reactivate"		type="xsd:boolean"/>
	<part name="max_lidb_age_days"							type="xsd:unsignedInt"/>
	<part name="use_realtime_lidb"							type="xsd:boolean"/>
	<part name="ReturnDetailedRoyalties" 				type="xsd:boolean"/>	
	<separator/>
  <part name="Gateways" type="tns:XmlDataSet" cols="70" rows="8"/>
</message>
*/
/*--INFO-- This service hits the LIDB key by Phone number and returns info with regards to the 
						status of the phone number. 
						The search requires an account number and a phone.
*/

IMPORT BatchShare,Phones,Royalty,ut;

EXPORT PhoneAttributes_BatchService(useCannedRecs = 'false') := 
	MACRO

		batch_params		:= Phones.IParam.PhoneAttributes.getBatchParams();	
		// Grab the input XML and throw into a dataset.	
		ds_xml_in_raw  	:= DATASET([], Phones.Layouts.PhoneAttributes.BatchIn) : STORED('batch_in', FEW);
		ds_xml_in 			:= IF( useCannedRecs, Phones.BatchCannedInput.PhonesAttribute, ds_xml_in_raw);	

		BatchShare.MAC_SequenceInput(ds_xml_in, ds_xml_in_seq);		
		BatchShare.MAC_CapitalizeInput(ds_xml_in_seq, ds_batch_in);		
		
		dBatchPhonesOut := Phones.PhoneAttributes_BatchRecords(ds_batch_in, batch_params);
		BatchShare.MAC_RestoreAcctno(ds_batch_in, dBatchPhonesOut, dPreResults,false,false);		
		dSortResults := SORT(dPreResults, acctno);

		ut.mac_TrimFields(dSortResults, 'dSortResults', dBatchResults);		
			
		OUTPUT(dBatchResults,  NAMED('Results') );				
				
	ENDMACRO;	