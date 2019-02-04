/*--SOAP--
<message name="govt_collections_services.report_service">
  <part name="IdentityContactResolutionReportRequest" sequence="1" type="tns:XmlDataset"/>
</message>
*/
IMPORT Address, AutoStandardI, Gateway, iesp, govt_collections_services, ut, Doxie, Suppress, STD, WSInput;

EXPORT Report_Service() := MACRO
    #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
    // Setup the field that shall be displayed on the WsECL page.
    WSInput.MAC_Govt_Collections_Report_Service();
    
    // Parse the ESDL input
    dIn := DATASET([], iesp.identity_contact_resolution.t_IdentityContactResolutionReportRequest) : STORED('IdentityContactResolutionReportRequest',FEW);
    icrRequest := dIn[1] : INDEPENDENT;
    
    // Reportby request
    icrReportBy := GLOBAL(icrRequest.ReportBy);
    
    // Store some standard input parameters (generally, for search purpose)
    iesp.ECL2ESP.SetInputBaseRequest(icrRequest);
    
    // Ensure we specifically store unique values currently supported in batch.
    #stored ('inputstate', icrRequest.Options.inputstate);  

    maxPhoneCount := IF(icrRequest.Options.includephones, 
                            iesp.Constants.IdentityContactResolution.MaxReportPhones, 
                            0);
    #stored ('maxphonecount', maxPhoneCount);  
    
    #stored ('includeminors', icrRequest.Options.includeminors);  
    #stored ('getssnbest', icrRequest.Options.getssnbest);  
    #stored ('appendbestdata', icrRequest.Options.appendbestdata);  
    
		// From batch - Initialize batch param values now that ESP param values have been loaded.
		batch_params := Govt_Collections_Services.IParams.getBatchParams();	
    
   // Global module
   globalMod := AutoStandardI.GlobalModule();

   // Attempt to derive an SSN from the given DID value that may be provided on input to this service
   // interface Use the unmasked SSN regardless of SSN mask setting because we are using this SSN 
   // internally in our search criteria.
   rec := SSNBest_Services.Raw.Get_All(DATASET([{'', icrReportBy.uniqueid}],{STRING best_ssn, INTEGER did}));
   ssn_by_did := rec.subject[1].ssn;

   // Setup some values that will be passed into the Records attribute call later.
		in_ssn_mask := globalMod.SSNMask;
		is_GLB_fail := NOT ut.glb_ok(globalMod.GLBPurpose);
		is_DRM_fail := Doxie.DataRestriction.isECHRestricted(globalMod.DataRestrictionMask); 

   // Build the batch record with the appropriate values transliterated from the ESP Report By inputs.
		ds_xml_in := 
      PROJECT(
        DATASET([icrRequest], iesp.identity_contact_resolution.t_IdentityContactResolutionReportRequest),
        TRANSFORM (Govt_Collections_Services.Layouts.batch_in,
          SELF.acctno := '1',
          SELF.orig_acctno := '1',
          // Adding DID mapping to SSN if DID!='' and SSN field is blank. 
          SELF.ssn := IF (LEFT.reportby.ssn = '' AND ssn_by_did != '', ssn_by_did, LEFT.reportby.ssn),
          SELF.name_first := LEFT.reportby.name.first,
          SELF.name_middle := LEFT.reportby.name.middle,
          SELF.name_last := LEFT.reportby.name.last,
          SELF.name_suffix := LEFT.reportby.name.suffix,
          
          SELF.addr := LEFT.reportby.address.streetaddress1 + ' ' + LEFT.reportby.address.streetaddress2,
          SELF.prim_range := LEFT.reportby.address.streetnumber,
          SELF.predir := LEFT.reportby.address.streetpredirection,
          SELF.prim_name := LEFT.reportby.address.streetname,
          SELF.addr_suffix := LEFT.reportby.address.streetsuffix,
          SELF.postdir := LEFT.reportby.address.streetpostdirection,
          SELF.unit_desig := LEFT.reportby.address.unitdesignation,
          SELF.sec_range := LEFT.reportby.address.unitnumber,
          SELF.p_city_name := LEFT.reportby.address.city,
          SELF.st := LEFT.reportby.address.state,
          SELF.z5 := LEFT.reportby.address.zip5,
          SELF.zip4 := LEFT.reportby.address.zip4,
					SELF := []
        )
      );
        
		// From batch - Project into batch_in for processing. In the case where the entire street address is
		// expressed in both addr1 and addr2, concatenate these values into 'addr'. By implication, we 
		// want to treat any record having a blank addr1 and a value in addr2 as a bad record--the IF-
		// statement below retains the blank addr1 value and ignores the addr2 in such an instance. 
    // Clean the ssn here.
		ds_xml_in_unclean := 
			PROJECT(
				ds_xml_in, 
				TRANSFORM( Govt_Collections_Services.Layouts.batch_in, 
					SELF.addr := STD.Str.CleanSpaces(Address.Addr1FromComponents(LEFT.prim_range,
                                                                       LEFT.predir,
                                                                       LEFT.prim_name,
                                                                       LEFT.addr_suffix,
                                                                       LEFT.postdir,
                                                                       LEFT.unit_desig,
                                                                       LEFT.sec_range)),
					SELF.ssn := STD.Str.Filter( LEFT.ssn, '0123456789' ),
					SELF    := LEFT, 
					SELF    := []
				)
			);

		// From batch - Determine whether each input record has all of the required fields to be processed in 
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

		// From batch - Filter for further processing; those records having insufficient input will
		// be considered 'rejected'. 
		ds_having_suff_input := ds_batch_in_marked(NOT is_rejected_rec);
		
		// From batch - This service requires that the name and address data be passed in uncleaned, so 
    // that they may be compared directly to the Best name and address to generate a 
    // Confidence Score in Govt_Collections_Services.Records.
    //
		// Additionally,the input records must have a cleaned address for record retrieval
		// in Govt_Collections_Services.Records.			
		ds_batch_in_cleaned := 
			PROJECT(
				ds_having_suff_input,
				Govt_Collections_Services.Transforms.xfm_clean_address(LEFT)
			);


		// From batch - Call main attribute to fetch records. Return type = Govt_Collections_Services.Layouts.batch_working.
  	ds_batchview_recs := 
			Govt_Collections_Services.Records.BatchView(ds_batch_in_cleaned, ds_batch_in_marked, batch_params);

    
		// From batch - Restrictions/suppressions based on application type.
		Suppress.MAC_Suppress(ds_batchview_recs, ds_recs_sup_1, batch_params.ApplicationType,,,Suppress.Constants.LinkTypes.DID, lex_id);			
		Suppress.MAC_Suppress(ds_recs_sup_1, ds_recs_sup_2, batch_params.ApplicationType,,,Suppress.Constants.LinkTypes.SSN, ssn);
		Suppress.MAC_Suppress(ds_recs_sup_2, ds_recs_sup_3, batch_params.ApplicationType,,,Suppress.Constants.LinkTypes.SSN, best_ssn);


		// From batch - Provide for ssn masking. Return the input ssn as-is; mask best_ and expanded_ ssn.
		Suppress.MAC_Mask(ds_recs_sup_3, ds_recs_masked_1, ssn, '', true, false,,,,in_ssn_mask);	
		Suppress.MAC_Mask(ds_recs_masked_1, ds_recs_masked_2, best_ssn, '', true, false,,,,in_ssn_mask);	
		Suppress.MAC_Mask(ds_recs_masked_2, ds_recs_masked_3, expanded_ssn, '', true, false,,,,in_ssn_mask);	

   
    // Transliterate the batch output to the format we need for this report service.
    results_batch_out := PROJECT( ds_recs_masked_3, Govt_Collections_Services.Layouts.batch_out );


    // Convert the resulting batch output into the record layout for our ICR Report output.
  	results_ICR_Report_Records := Govt_Collections_Services.Records.ReportView(results_batch_out);


    // Generate exception code and message section to be placed within our report service results.
    iesp.share.t_WsException	transform_Exception()	:= TRANSFORM
    
      SELF.Code			:=	map(	is_GLB_fail			=>	1,
                              is_DRM_fail			=>	2,
                              0
                            );
      SELF.Message	:=	map(	is_GLB_fail =>	'Invalid GLB purpose',
                              is_DRM_fail =>	'Invalid DataRestrictionMask value',
                              ''
                            );
      SELF					:=	[];
      
    END;
    
    // Create exceptions dataset that will be placed into the return Header row.
    dExceptions	:=	DATASET([transform_Exception()]);

    // Create the Header row that will be placed in the report return record structure.
    dHeaderRow := ROW( {0, '', icrRequest.User.QueryId, '', dExceptions},
                       iesp.share.t_ResponseHeader);

    // Toss all of our return elements together, gently, and add them to the Report Response record.
    result_ICR_Report_Response := PROJECT( results_ICR_Report_Records, 
                                           TRANSFORM(iesp.identity_contact_resolution.t_ICRReportResponse, 
                                                     SELF._Header := dHeaderRow;
                                                     SELF.reportRow := LEFT;
                                                     SELF := []));
                                                     
		// Create an empty dataset to return, if there are error conditions.
    iesp.identity_contact_resolution.t_ICRReportResponse	transform_Failed_Result()	:= TRANSFORM
      SELF._Header :=	dHeaderRow;
      SELF :=	[];
    END;
    
 		fail_dataset := DATASET ([transform_Failed_Result()]);

		// Check for failure conditions and fail the query if necessary. We need to explicitly create an
    // 'empty' failed structure because there may be valid results, but we do not want to return them
    // when the required flags and masks are not set correctly to be 'compliant'.
		results := 
			IF( 
				is_GLB_fail OR is_DRM_fail, 
				fail_dataset, 
				result_ICR_Report_Response
			);
      
    // -------------------------------------------------------------------------------------------------------
    // DEBUG    
    // -------------------------------------------------------------------------------------------------------
    // OUTPUT( icrRequest, NAMED('icrRequest') );    
    // OUTPUT( icrReportBy, NAMED('icrReportBy') );    
    // OUTPUT( icrUser, NAMED('icrUser') );    
    // OUTPUT( icrOptions, NAMED('icrOptions') );    
    // OUTPUT( dGateways, NAMED('dGateways') );    
    // OUTPUT( globalMod );
    // OUTPUT( searchMod );
    // OUTPUT( ds_xml_in, NAMED('ds_xml_in') );    
		// OUTPUT(in_ssn_mask, NAMED('in_ssn_mask'));
		// OUTPUT(is_GLB_fail, NAMED('is_GLB_fail'));
		// OUTPUT(is_DRM_fail, NAMED('is_DRM_fail'));
		// OUTPUT(batch_params);
		// OUTPUT(ds_batchview_recs, NAMED('ds_batchview_recs'));
		// OUTPUT(ds_recs_out, NAMED('ds_recs_out'));
		// OUTPUT(dHeaderRow, NAMED('dHeaderRow'));
		// OUTPUT(fail_dataset, NAMED('fail_dataset'));
		// OUTPUT(results_batch_out, NAMED('results_batch_out'));


		OUTPUT(results, NAMED('results'));

ENDMACRO;