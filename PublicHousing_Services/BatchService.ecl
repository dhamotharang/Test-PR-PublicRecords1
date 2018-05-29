/*--SOAP--
<message name="BatchService">
	<part name="DPPAPurpose"            type="xsd:byte"/>
	<part name="GLBPurpose"             type="xsd:byte"/> 
	<part name="DataRestrictionMask"    type="xsd:string"/>      <!-- [7] must be '0' for non-DMV sources -->
	<part name="DataPermissionMask"    type="xsd:string"/>
	<part name="SSNMask"                type="xsd:string"/>
	<part name="RealTimePermissibleUse" type="xsd:string"/>
	<part name="IndustryClass"          type="xsd:string"/>
	<part name="ApplicationType"        type="xsd:string"/>
  <part name="IncludeMinors"          type="xsd:boolean"/>

	<part name="InputState"             type="xsd:string"/>      <!-- 2-char state abbr. -->	
	<part name="PropertyValueThreshold" type="xsd:string"/>
	<part name="PropertyYearThreshold"  type="xsd:string"/>
	<part name="MVRYearThreshold"       type="xsd:string"/>
  <part name="GetSSNBest"             type="xsd:boolean"/>

	<part name="batch_in"               type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="Gateways"               type="tns:XmlDataSet" cols="70" rows="25"/>	

	<part name="ViewDebugs"             type="xsd:boolean"/>  <!-- View intermediate datasets for debugging. -->
</message>
*/

IMPORT BatchDatasets, BatchShare, Doxie, doxie_regression, Suppress, ut, AutoheaderV2;

EXPORT BatchService() := FUNCTION
  
		batch_params := PublicHousing_Services.IParams.getBatchParams();				
		#CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
		in_ssn_mask := batch_params.ssn_mask; // 'NONE'
		is_GLB_fail := NOT ut.glb_ok(batch_params.GLBpurpose);
		is_DRM_fail := Doxie.DataRestriction.isECHRestricted(batch_params.DataRestrictionMask); // i.e. if pos #6 = '1'

		_layouts := PublicHousing_Services.Layouts;
		
		ds_xml_in := DATASET( [], /* _layouts.batch_in */ BatchDatasets.Layouts.batch_in) : STORED('batch_in', FEW);

		// 1.a. Use common macro to get input file ready for processing. This will take care of
		// sequencing the input records whose count is N. NOTE: MAC_SequenceInput will append 
		// several fields to the dataset: Batchshare.Layouts.ShareErrors and orig_acctno. acctno 
		// will hold the sequence value (1 thru N).
		BatchShare.MAC_SequenceInput(ds_xml_in, ds_xml_in_seq);
		BatchShare.MAC_CapitalizeInput(ds_xml_in_seq, ds_xml_in_cap);
		
		// 1.b. Transform to a known layout since MAC_SequenceInput adds fields to an arbitrary dataset.
		ds_batch_in :=
			PROJECT( 
				ds_xml_in_cap, 
				TRANSFORM( _layouts.batch_in,
					SELF := LEFT,
					SELF := []
				)
			);
		
		// 1.c. If prim_name is populated, assume that the address has been cleaned. But if it's not 
		// populated, parse/clean the 'addr' (string100) field and populate the atomic address values.
		ds_batch_in_addr_cleaned :=
			PROJECT( ds_batch_in(prim_name = ''), PublicHousing_Services.Transforms.xfm_clean_address(LEFT) );

		// 1.d. Union the dataset having cleaned addresses already, and the dataset whose addresses
		// were cleaned just now; sort.
		ds_batch_in_cleaned := SORT( (ds_batch_in(prim_name != '') + ds_batch_in_addr_cleaned), (INTEGER)acctno );
		
		// 2. Determine whether each input record has all of the required fields to be processed in 
		// this service. If not, mark with an error message. See Req. 4.1.2 in _documentation: 
		// minimum input requirements and additional notes.
		ds_batch_in_marked := 
			PROJECT(
				ds_batch_in_cleaned,
				TRANSFORM( _layouts.batch_in,
						has_suff_input := 
							LEFT.name_last != '' AND LEFT.name_first != '' AND 
							(INTEGER)LEFT.ssn != 0 AND (INTEGER)LEFT.dob != 0 AND LEFT.prim_name != '' AND 
							((LEFT.p_city_name != '' AND LEFT.st != '') OR (INTEGER)LEFT.z5 != 0);
					SELF.record_err_msg  := IF( NOT has_suff_input, 'INSUFF. DATA TO PROCESS',	'' ),
					SELF.is_rejected_rec := NOT has_suff_input,
					SELF := LEFT,
					SELF := []
				)
			);		

		// 3. Filter for further processing; those records having insufficient input will
		// be considered 'rejected'. Clean the ssn here.
		ds_having_suff_input := 
			PROJECT(
				ds_batch_in_marked(NOT is_rejected_rec),
				TRANSFORM( _layouts.batch_in,
					SELF.ssn := StringLib.StringFilter( LEFT.ssn, '0123456789' ),
					SELF     := LEFT,
					SELF     := []
				)
			);
		
		ds_having_insuff_input := ds_batch_in_marked(is_rejected_rec);
		
		// 4. Call main attribute to fetch records. Return type = Govt_Collections_Services.Layouts.batch_working.
		ds_batchview_recs := 
				PublicHousing_Services.BatchService_Records.BatchView(ds_having_suff_input, batch_params);

		// 5. Join back to original, sequenced input. Transform to final layout. Preserve orig_acctno.
		ds_recs_out_pre := 
			JOIN(
				ds_xml_in_seq, ds_batchview_recs,
				LEFT.acctno = RIGHT.acctno,
				TRANSFORM( {_layouts.batch_out, STRING20 orig_acctno},
					SELF := RIGHT,
					SELF := LEFT
				),
				INNER,
				KEEP(1)
			);
		
		// 5.a. Project disqualified records into output layout...
		ds_rejected_recs := 
			PROJECT(
				ds_having_insuff_input,
				TRANSFORM( {_layouts.batch_out, STRING20 orig_acctno},
					SELF := LEFT,
					SELF := []
				)
			);
		
		// 5.b. ...and union the two datasets.
		ds_recs_out := ds_recs_out_pre + ds_rejected_recs;
		
		// 6. Restore orignal acctno.
		BatchShare.MAC_RestoreAcctno(ds_batch_in_marked, ds_recs_out, ds_recs_ready)		
    
		// 7. Restrictions/suppressions based on application type.
		Suppress.MAC_Suppress(ds_recs_ready, ds_recs_sup_1, batch_params.ApplicationType,,,Suppress.Constants.LinkTypes.DID, LexID);			
		Suppress.MAC_Suppress(ds_recs_sup_1, ds_recs_sup_2, batch_params.ApplicationType,,,Suppress.Constants.LinkTypes.SSN, ssn);
		Suppress.MAC_Suppress(ds_recs_sup_2, ds_recs_sup_3, batch_params.ApplicationType,,,Suppress.Constants.LinkTypes.SSN, best_ssn);

		// 8. Provide for ssn masking. Here, 'ssn' is a field from Criminal records.
		Suppress.MAC_Mask(ds_recs_sup_3   , ds_recs_masked_1, ssn     ,  '', true, false,,,,in_ssn_mask);	
		Suppress.MAC_Mask(ds_recs_masked_1, ds_recs_masked_2, best_ssn,  '', true, false,,,,in_ssn_mask);
		Suppress.MAC_Mask(ds_recs_masked_2, ds_recs_masked_3, doc_ssn_1, '', true, false,,,,in_ssn_mask);
   
		// 9. Sort results, converting acctno to integer because string numbers don't sort correctly. 
		// 1, 10, 2 ,20..etc. This presumes, of course, that the acctnos are numeric and that they
		// ascend in order in the batch_in dataset.
	  results_sorted := SORT(ds_recs_masked_3, (INTEGER)acctno, (INTEGER)LexID);
		
		// 10. Slim off the orig_acctno, check for failure conditions and fail the query if necessary.
		// If all goes well, return the results dataset.		
		results_untrimmed := 
			IF( 
				is_GLB_fail OR is_DRM_fail, 
				DATASET( [], _layouts.batch_out ), 
				PROJECT( results_sorted, _layouts.batch_out )
			);
 
		// 12. Remove unneeded whitespace.
		ut.mac_TrimFields(results_untrimmed, 'results_untrimmed', results)

		IF(
			is_GLB_fail, FAIL('An error occurred while running PublicHousing_Services.BatchService: invalid GLB purpose.'),
			// ELSE- 
			IF(
				is_DRM_fail, FAIL('An error occurred while running PublicHousing_Services.BatchService: Experian Credit header is restricted; check DataRestrictionMask value.') ) );
				
		RETURN OUTPUT( results, NAMED('Results') );
		
END;
