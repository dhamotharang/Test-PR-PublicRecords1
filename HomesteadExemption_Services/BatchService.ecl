
/*--SOAP--
<message name="HomesteadExemption_BatchService">
	<part name="DPPAPurpose"         type="xsd:byte"/>
	<part name="GLBPurpose"          type="xsd:byte"/> 
	<part name="SSNMask"             type="xsd:string"/>
	<part name="DOBMask"             type="xsd:string"/>	
	<part name="IncludeBlankDOD"     type="xsd:boolean"/>	
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask"  type="xsd:string"/>
	<part name="DIDScoreThreshold"   type="xsd:unsignedInt"/> <!-- Not per requirements; for convenience. -->
	<part name="batch_in"            type="tns:XmlDataSet" cols="70" rows="25"/>	
  <part name="GetSSNBest"          type="xsd:boolean"/>
  <part name="IncludeMinors"       type="xsd:boolean"/>
	<part name="ViewDebugs"          type="xsd:boolean"/>  <!-- View intermediate datasets for debugging. -->
</message>
*/

IMPORT BatchShare, Doxie, Suppress, ut;

EXPORT BatchService() := MACRO
    #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
    //required for property search.
    #STORED('Return_Property',TRUE);
    #STORED('Return_Assessments',TRUE);
    #STORED('Return_Deeds',TRUE);
		#STORED('Return_Owners',TRUE);
		#STORED('Return_Borrower',TRUE);
    #STORED('Return_Seller',TRUE);
		#STORED('Skip_Dedup',FALSE);
   // #STORED('Max_Results_Per_Acct',30);  //not sure if this is needed, removing for now...

		batch_params := HomesteadExemption_Services.IParams.getBatchParams();				
		
		in_ssn_mask := batch_params.ssn_mask;
		is_GLB_fail := NOT ut.glb_ok(batch_params.GLBpurpose);
		
		// 0. Read the batch into a dataset.
		ds_xml_in := DATASET( [], HomesteadExemption_Services.Layouts.batch_in_raw ) : STORED('batch_in', FEW);
		
		// 1. Sequence and capitalize the input records.
		BatchShare.MAC_SequenceInput(ds_xml_in, ds_xml_in_seq);
		BatchShare.MAC_CapitalizeInput(ds_xml_in_seq, ds_xml_in_cap);
		
		// 2. Determine whether each input record has all of the required fields to be processed in 
		// this service. If not, mark with an error message. 
		ds_batch_in_marked := 
			PROJECT(
				ds_xml_in_cap,
				TRANSFORM( HomesteadExemption_Services.Layouts.batch_in_raw_with_seq,
						has_suff_input := HomesteadExemption_Services.Functions.fn_determine_sufficient_data(LEFT);
					SELF.error_code := IF( NOT has_suff_input, 301, 0 ), // from doxie.ErrorCodes 'Insufficient input'
					SELF := LEFT,
					SELF := []
				)
			);
		
		// 3. Filter for further processing; those records having insufficient input will be
		// considered 'rejected'. 
		ds_having_suff_input   := ds_batch_in_marked(error_code = 0);
		ds_having_insuff_input := ds_batch_in_marked(error_code = 301);
		
		// 4. Call main attribute to fetch records. 
		ds_batchview_recs := 
				HomesteadExemption_Services.BatchService_Records(ds_having_suff_input, batch_params);

		// 5. Join back to original, sequenced input. Transform to final layout. Preserve orig_acctno.
		ds_recs_out_pre := 
			JOIN(
				ds_xml_in_seq, ds_batchview_recs,
				LEFT.acctno = RIGHT.acctno,
				TRANSFORM( {HomesteadExemption_Services.Layouts.batch_out, STRING20 orig_acctno},
					SELF := RIGHT,
					SELF := LEFT
				),
				INNER,
				KEEP(1)
			);
		
		// 6. Project disqualified records into output layout...
		ds_rejected_recs := 
			PROJECT(
				ds_having_insuff_input,
				TRANSFORM( {HomesteadExemption_Services.Layouts.batch_out, STRING20 orig_acctno},
					SELF       := LEFT,
					SELF       := []
				)
			);
		
		// ...and union the two datasets.
		ds_recs_out := ds_recs_out_pre + ds_rejected_recs;
		
		// 7. Restore orignal acctno.
		BatchShare.MAC_RestoreAcctno(ds_batch_in_marked, ds_recs_out, ds_recs_ready)		
    
		// 8. Restrictions/suppressions based on application type.
		Suppress.MAC_Suppress(ds_recs_ready, ds_recs_sup_1, batch_params.ApplicationType,,,Suppress.Constants.LinkTypes.DID, did1);
		Suppress.MAC_Suppress(ds_recs_sup_1, ds_recs_sup_2, batch_params.ApplicationType,,,Suppress.Constants.LinkTypes.DID, did2);
		Suppress.MAC_Suppress(ds_recs_sup_2, ds_recs_sup_3, batch_params.ApplicationType,,,Suppress.Constants.LinkTypes.SSN, owner_1_SSN);
		Suppress.MAC_Suppress(ds_recs_sup_3, ds_recs_sup_4, batch_params.ApplicationType,,,Suppress.Constants.LinkTypes.SSN, owner_2_SSN);

		// 9. Provide for ssn masking. Return the input ssn as-is; mask best_ and expanded_ ssn.
		Suppress.MAC_Mask(ds_recs_sup_4, ds_recs_masked_1, owner_1_SSN, '', true, false,,,,in_ssn_mask);	
		Suppress.MAC_Mask(ds_recs_masked_1, ds_recs_masked_2, owner_2_SSN, '', true, false,,,,in_ssn_mask);	
   
		// 10. Sort results, converting acctno to integer because string numbers don't sort correctly.  1, 10, 2 ,20..etc.
	  results_sorted := SORT(ds_recs_masked_2, (INTEGER)acctno);
		
		// 11. Slim off the orig_acctno.
		fail_dataset := DATASET( [], HomesteadExemption_Services.Layouts.batch_out );
		
		// 12. Check for failure conditions and fail the query if necessary.
		results := 
			IF( 
				is_GLB_fail, 
				fail_dataset, 
				PROJECT( results_sorted, HomesteadExemption_Services.Layouts.batch_out )
			);
		
		//
		// 12. Perhaps TODO: Apply ut.mac_TrimFields to remove unneeded whitespace.
		//

		IF(
			is_GLB_fail, FAIL('An error occurred while running HomesteadExemption.BatchService: invalid GLB purpose.') );

		// OUTPUT( ds_xml_in, NAMED('ds_xml_in') );
		// OUTPUT( ds_xml_in_cap, NAMED('ds_xml_in_cap') );
		// OUTPUT( ds_batch_in_norm, NAMED('ds_batch_in_norm') );
		// OUTPUT( ds_batch_in_cleaned, NAMED('ds_batch_in_cleaned') );
		// OUTPUT( ds_batch_in_marked, NAMED('ds_batch_in_marked') );
		// OUTPUT( ds_having_suff_input, NAMED('ds_having_suff_input') );
		
		OUTPUT( results, NAMED('Results') );
ENDMACRO;
