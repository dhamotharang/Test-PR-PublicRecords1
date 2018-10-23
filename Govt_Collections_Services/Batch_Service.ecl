/*--SOAP--
<message name="Batch_Service">
	<part name="DPPAPurpose"         type="xsd:byte"/>
	<part name="GLBPurpose"          type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>      <!-- [7] must be '0' for non-DMV sources -->
  <part name="DataPermissionMask"  type="xsd:string"/>
	<part name="SSNMask"             type="xsd:string"/>
	<part name="DIDScoreThreshold"   type="xsd:unsignedInt"/> <!-- Not per requirements; for convenience. -->
	<part name="InputState"          type="xsd:string"/>      <!-- 2-char state abbr. -->
	<part name="MaxPhoneCount"       type="xsd:unsignedInt" default="3"/>      <!-- values 0 or 3. -->
  <part name="IncludeMinors"       type="xsd:boolean"/>
  <part name="GetSSNBest"          type="xsd:boolean"/>
  <part name="AppendBestData"		   type="xsd:boolean"/>
	<part name="batch_in"            type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>
*/
/*
	 batch_in fields:
	 ======================
	 STRING20  acctno;
	 STRING9   ssn;
	 STRING8   dob;
	 STRING20  name_first;
	 STRING20  name_middle;
	 STRING20  name_last;
	 STRING    suffix;
		STRING10  	prim_range 		:= '';
		STRING2   	predir     		:= '';
		STRING28  	prim_name  		:= '';
		STRING4   	addr_suffix 	:= '';
		STRING2   	postdir     	:= '';
		STRING10  	unit_desig  	:= '';
		STRING8   	sec_range  	 	:= '';
	 STRING25  p_city_name;
	 STRING2   st;
	 STRING5   z5;
*/
IMPORT Address, BatchShare, Doxie, Govt_Collections_Services, Suppress, ut, STD, AutoheaderV2;

EXPORT Batch_Service() := FUNCTION
		batch_params := Govt_Collections_Services.IParams.getBatchParams();	

  // batch_params is a module, so this couldn't be declared before it (side effect)
  #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
		
		
		/* ************************************************************************
		 *                      Force the order on the WsECL page                 *
		 ************************************************************************ */
		#WEBSERVICE(FIELDS(
			'Batch_In',
			'DPPAPurpose',
			'GLBPurpose',
			'DataRestrictionMask',
			'DataPermissionMask',
			'AppendBestData',
			'DIDScoreThreshold',
			'GetSSNBest',
			'IncludeMinors',
			'industry_class',
			'InputState',
			'MaxPhoneCount',
			'MaxResultsPerAcct',
			'PenaltThreshold',
			'SSNMask'
		));
		
		in_ssn_mask := batch_params.ssn_mask;
		is_GLB_fail := NOT ut.glb_ok(batch_params.GLBpurpose);
		is_DRM_fail := Doxie.DataRestriction.isECHRestricted(batch_params.DataRestrictionMask); // i.e. if pos #6 = '1'

		ds_xml_in := DATASET( [], Govt_Collections_Services.Layouts.batch_in_raw ) : STORED('batch_in', FEW);

		//  1.a. Use common macro to get input file ready for processing. This will take care of
		// 	sequencing and the input records. NOTE: ds_xml_in_seq will have Batchshare.Layouts.ShareErrors  
		//  and orig_acctno appended.
		BatchShare.MAC_SequenceInput(ds_xml_in, ds_xml_in_seq); // Add string20 orig_acctno and ShareErrors
		BatchShare.MAC_CapitalizeInput(ds_xml_in_seq, ds_xml_in_cap);

		// 1.b. Project into batch_in for processing. In the case where the entire street address is
		// expressed in both addr1 and addr2, concatenate these values into 'addr'. By implication, we 
		// want to treat any record having a blank addr1 and a value in addr2 as a bad record--the IF-
		// statement below retains the blank addr1 value and ignores the addr2 in such an instance. Clean the ssn here.
		ds_xml_in_unclean := 
			PROJECT(
				ds_xml_in_cap, 
				TRANSFORM( Govt_Collections_Services.Layouts.batch_in, 
					SELF.addr := STD.Str.CleanSpaces(Address.Addr1FromComponents(LEFT.prim_range,LEFT.predir,LEFT.prim_name,LEFT.addr_suffix,LEFT.postdir,LEFT.unit_desig,LEFT.sec_range)),
					SELF.ssn := STD.Str.Filter( LEFT.ssn, '0123456789' ),
					SELF    := LEFT, 
					SELF    := []
				)
			);

		// 2. Determine whether each input record has all of the required fields to be processed in 
		// this service. If not, mark with an error message. See Req. 4.1.2 in _documentation: 
		// minimum input requirements and additional notes. 
		// ICRBE V1.5 changes input req. 4.1.2 to allow either input SSN or address in combination with input name. 
		// From V1.3 Req. 4.1.3: Social security numbers containing only the last 4 digits will also be accepted so long 
		//   as address is also provided on input. 
		ds_batch_in_marked := 
			PROJECT(
				ds_xml_in_unclean,
				Govt_Collections_Services.Transforms.xfm_in_marked(LEFT)
			);		

		// 3. Filter for further processing; those records having insufficient input will
		// be considered 'rejected'. 
		ds_having_suff_input := ds_batch_in_marked(NOT is_rejected_rec);
		
		// 4.a. This batch service requires that the name and address data be passed in uncleaned, 
		// so that they may be compared directly to the Best name and address to generate a Confidence 
		// Score in Govt_Collections_Services.Records.
		ds_batch_in_parsed := ds_having_suff_input;
		// input data now is coming already parsed
		
		// 4.b. On the other hand, the input records must have a cleaned address for record retrieval
		// in Govt_Collections_Services.Records.			
		ds_batch_in_cleaned := 
			PROJECT(
				ds_having_suff_input,
				Govt_Collections_Services.Transforms.xfm_clean_address(LEFT)
			);

		// 5. Call main attribute to fetch records. Return type = Govt_Collections_Services.Layouts.batch_working.
  	ds_batchview_recs := 
			Govt_Collections_Services.Records.BatchView(ds_batch_in_cleaned, ds_batch_in_parsed, batch_params);

		// 6. Join back to original, sequenced input. Transform to final layout. Preserve orig_acctno.
	  ds_recs_out := 
			JOIN(
				ds_batch_in_marked, ds_batchview_recs,
				LEFT.acctno = RIGHT.acctno,
				TRANSFORM( {Govt_Collections_Services.Layouts.batch_out, STRING20 orig_acctno},
				  SELF.record_err_msg  := IF(RIGHT.record_err_msg != '', RIGHT.record_err_msg, LEFT.record_err_msg),
				  SELF.is_rejected_rec := IF(RIGHT.record_err_msg != '', RIGHT.is_rejected_rec, LEFT.is_rejected_rec),
					SELF.NCOA_Addr1 		 := RIGHT.NCOA_Addr1,
					SELF.NCOA_city 			 := RIGHT.NCOA_city,
					SELF.NCOA_state 		 := RIGHT.NCOA_state,
				  SELF.NCOA_zip 	     := RIGHT.NCOA_zip,
					SELF.MatchMoveEffDate := RIGHT.MatchMoveEffDate,
					SELF := LEFT,
					SELF := RIGHT
				),
				LEFT OUTER,
				KEEP(1)
			);
	
		// 7. Restore orignal acctno.
		BatchShare.MAC_RestoreAcctno(ds_batch_in_marked, ds_recs_out, ds_recs_ready)		
    
		// 8. Restrictions/suppressions based on application type.
		Suppress.MAC_Suppress(ds_recs_ready, ds_recs_sup_1, batch_params.ApplicationType,,,Suppress.Constants.LinkTypes.DID, lex_id);			
		Suppress.MAC_Suppress(ds_recs_sup_1, ds_recs_sup_2, batch_params.ApplicationType,,,Suppress.Constants.LinkTypes.SSN, ssn);
		Suppress.MAC_Suppress(ds_recs_sup_2, ds_recs_sup_3, batch_params.ApplicationType,,,Suppress.Constants.LinkTypes.SSN, best_ssn);

		// 9. Provide for ssn masking. Return the input ssn as-is; mask best_ and expanded_ ssn.
		Suppress.MAC_Mask(ds_recs_sup_3, ds_recs_masked_1, best_ssn, '', true, false,,,,in_ssn_mask);	
		Suppress.MAC_Mask(ds_recs_masked_1, ds_recs_masked_2, expanded_ssn, '', true, false,,,,in_ssn_mask);	
   
		// 9. Sort results, converting acctno to integer because string numbers don't sort correctly.  1, 10, 2 ,20..etc.
	  results_sorted := SORT(ds_recs_masked_2, (INTEGER)acctno, (INTEGER)lex_id);
		
		// 10. Slim off the orig_acctno.
		fail_dataset := DATASET( [], Govt_Collections_Services.Layouts.batch_out );
		
		// 11. Check for failure conditions and fail the query if necessary.
		results := 
			IF( 
				is_GLB_fail OR is_DRM_fail, 
				fail_dataset, 
				PROJECT( results_sorted, Govt_Collections_Services.Layouts.batch_out )
			);
		
		IF(
			is_GLB_fail, FAIL('An error occurred while running Govt_Collections_Services.Batch_Service: invalid GLB purpose.'),
			/* ELSE- */ 
			IF(
				is_DRM_fail, FAIL('An error occurred while running Govt_Collections_Services.Batch_Service: invalid DataRestrictionMask value.') ) );
				
		RETURN OUTPUT( results, NAMED('Results') );

END;
