/*--SOAP--
<message name="BenefitAssessment_BatchServiceFCRA">
	<part name="DPPAPurpose"							type="xsd:byte"/>
	<part name="GLBPurpose" 							type="xsd:byte" />
	<part name="batch_in"									type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="IncludeSexOffenders"  	  type="xsd:boolean"/>
	<part name="IncludeAssetsAndWealth"  	type="xsd:boolean"/>
	<part name="IncludeCriminalDerogatory" 	type="xsd:boolean"/>
	<part name="IncludeFamilyComp" 					type="xsd:boolean"/>
	<part name="PropertyReturnCount"	  	type="xsd:integer"/>
	<part name="PropertyTransferPeriod"		type="xsd:integer"/>
	<part name="NonSubjectSuppression"  	type="xsd:unsignedInt"/>
	<part name="DataPermissionMask" 			type="xsd:string"/>
	<part name="DataRestrictionMask" 			type="xsd:string"/>
	<part name="gateways" 								type="tns:XmlDataSet" cols="110" rows="4"/>
</message>
*/
IMPORT BatchShare, FCRA, ut, Gateway;

// **************************************************************************************
// This service will append the did onto the input data. It will use the input data, without
// the appended DID, to see if the input records are deceased. If they are they, they will
// be taken off the stream and added to the output. The non-deceased hits, will continue 
// on to see if the input people are criminals. If they have a criminal record, they will
// be taken off the stream and added to the output. The non-criminal hits and non-deceased hits,
// will continue to see if these records are or have any of the following: sex offender, properties,
// criminal and derogatory offenses, best header address and individuals living with them.
// Incarceration and deceased will always run when this query is called. However, the other
// products will only run when when their appropriate include option is true. If an include is
// not turned on or it's using the default of false, then those product fields will be 
// blank in the output.  
// **************************************************************************************

EXPORT BenefitAssessment_BatchServiceFCRA(useCannedRecs = false) := MACRO
		isFCRA := true;
		#STORED('Return_SSN', true);
		#STORED('Return_DOC_Name', true);		
		nss := ut.getNonSubjectSuppression (Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription);
	// **************************************************************************************
		//   Read parameters and XML input. 
		// **************************************************************************************		
		
		ds_xml_in_raw 		:= DATASET([], BenefitAssessment_Services.Layouts.Batch_In) : STORED('batch_in', FEW);
		ds_canned_raw 		:= PROJECT(BatchServices._Sample_inBatchMaster('BENEFIT_ASSESSMENT'),  BenefitAssessment_Services.Layouts.Batch_In);
	
		ds_xml_in 				:= if( useCannedRecs, ds_canned_raw , ds_xml_in_raw);	

		BatchShare.MAC_SequenceInput(ds_xml_in, ds_xml_in_seq);		
		BatchShare.MAC_CapitalizeInput(ds_xml_in_seq, ds_tmp_batch_in);
		BatchShare.MAC_CleanAddresses(ds_tmp_batch_in, ds_batch_in);
		
		batch_params		:= BatchShare.IParam.getBatchParams();

		ba_batch_params := module(project(batch_params, BenefitAssessment_Services.IParam.batch_params, opt))
			export dataset (Gateway.layouts.config) gateways 	:= Gateway.Configuration.Get();
			export integer1 non_subject_suppression := nss;
			export boolean include_sex_offenders := FALSE : STORED('IncludeSexOffenders');
			export boolean include_assets_and_wealth := FALSE : STORED('IncludeAssetsAndWealth');
			export boolean include_criminal_derogatory := FALSE : STORED('IncludeCriminalDerogatory');
			export boolean include_family_comp := FALSE : STORED('IncludeFamilyComp');
			export integer property_return_count:= 3 : STORED('PropertyReturnCount');
			export integer property_transfer_period:= 12 : STORED('PropertyTransferPeriod');		
		END;

		//grab the dids
		BatchShare.MAC_AppendPicklistDID(ds_batch_in (did=0), ds_batch_with_did, ba_batch_params, isFCRA);			
		
		ds_batch_In_Shared := project(ds_batch_with_did, BenefitAssessment_Services.Layouts.Batch_In_Shared) +
                          project(ds_batch_in (did!=0), BenefitAssessment_Services.Layouts.Batch_In_Shared);

		ds_batch_recs := BenefitAssessment_Services.BatchRecords(ba_batch_params, ds_batch_In_Shared, isFCRA, nss);
		//Restore original acctno	
		BatchShare.MAC_RestoreAcctno(ds_batch_in, ds_batch_recs, ds_batch_out)		
			
		ut.mac_TrimFields(ds_batch_out, 'ds_batch_out', results);
	
		OUTPUT(results, NAMED('Results'));				

ENDMACRO;	
