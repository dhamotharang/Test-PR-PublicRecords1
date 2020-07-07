IMPORT $, Address, doxie, iesp;

EXPORT parser_netwise_email := MODULE
  
  // Common temp record layouts used by the functions below
  SHARED rec_request_wseq := RECORD
    UNSIGNED1 request_seq; // needed for joining later
    iesp.net_wise.t_NetWiseQueryRequest;
  END;

  SHARED rec_results_wseq := RECORD
    UNSIGNED1 results_seq; // needed for joining later
    iesp.net_wise_share.t_NetWiseResult;
  END;

  SHARED rec_t_NetWiseQueryResponse := record
	  iesp.share.t_ResponseHeader _Header {xpath('Header')};
	  iesp.net_wise_share.t_NetWiseTransaction Transaction {xpath('Transaction')};
	  DATASET(rec_results_wseq) Results {xpath('Results/Result'), MAXCOUNT(iesp.Constants.NETWISE.MAX_COUNT_RESULTS_RECORDS)};
  END;

  SHARED rec_response_wseq := RECORD
    UNSIGNED1 response_seq; // needed for joining later
    rec_t_NetWiseQueryResponse response {xpath('response')};
  END;


  // ********************************************************************************************************
  // ********************************************************************************************************
  EXPORT fn_parseRequest(DATASET(rec_request_wseq) ds_in_request) := FUNCTION

    ds_out_request := PROJECT(ds_in_request,
      TRANSFORM($.Layouts.common_optout,
        SELF.seq            := LEFT.request_seq; 
        SELF.did            := (UNSIGNED6) LEFT.SearchBy.UniqueId; // use ESP passed in LexID, even though the gateway does not accept LexID
        SELF.global_sid     := $.Constants.Netwise.GLOBAL_SID_EMAIL;
        SELF.transaction_id := LEFT.GatewayParams.TxnTransactionId;
        // other fields on common_optout layout don't matter so they can be nulled out
        SELF := []
        ));
 
    //OUTPUT(ds_in_request,  named('ds_in_request'));
    //OUTPUT(ds_out_request, named('ds_out_request')); 

    RETURN ds_out_request;
  END;


  // ********************************************************************************************************
  // ********************************************************************************************************
  EXPORT fn_parseResponse(DATASET(rec_response_wseq) ds_in_response) := FUNCTION

    // First normalize all <Results> child dataset records on every <response> record using 
    // a transform to parse/clean each of the Results.Name.Text field data which appears to have 
    // the full name of the person associated with the query input email, in First (no middle?) Last format. 
    rec_response_wseq_parsedname := RECORD
      rec_response_wseq;
      $.Layouts.common_optout.title;
      $.Layouts.common_optout.fname;
      $.Layouts.common_optout.mname;
      $.Layouts.common_optout.lname;
      $.Layouts.common_optout.suffix;
    END;

    rec_response_wseq_parsedname tf_norm_parsename(rec_response_wseq L, integer norm_count) := TRANSFORM
      // use standard name cleaner to parse the (full) Name.text into standard name parts
      clean_name  := Address.CleanPersonFML73_fields(L.response.Results[norm_count].Name.Text);
      SELF.title  := clean_name.title;
      SELF.fname  := clean_name.fname;
      SELF.mname  := clean_name.mname;
      SELF.lname  := clean_name.lname;  
      SELF.suffix := clean_name.name_suffix;
      SELF.response.Results := L.response.Results[norm_count];
      SELF        := L; // stores response_seq and rest of the response.*** data
    END;

    ds_in_resp_name_parsed := NORMALIZE(ds_in_response, 
                                        COUNT(LEFT.response.Results),
                                        tf_norm_parsename(LEFT, COUNTER));

    // Use below to normalize all AddressRecords, using Results.Name.Text "name cleaned" from above, 
    // plus once for each PersonalContactInfo.AddressRecords
    $.Layouts.common_optout tf_Norm_addrs(rec_response_wseq_parsedname L,
                                          integer norm_count) := TRANSFORM

      SELF.seq            := L.response_seq; 

      // NOTE: at this point there is only 1 record in each 'Results' child ds on each response record; 
      // so the "...Results[1]..." can be used in multiple places below.
      // Use common layout sec_id field to hold the 'Results' child ds results_seq#
      SELF.section_id     := L.response.Results[1].results_seq;

      SELF.transaction_id := L.response._Header.TransactionId;

      // clean/parse the gateway response.results person's full address
      temp_addr_rec := L.response.Results[1].PersonalContactInfo.AddressRecords[norm_count];
      temp_addr :=iesp.ECL2ESP.SetAddress('', '', '', '', '','', '',  
                                          temp_addr_rec.City, temp_addr_rec.State, 
                                          temp_addr_rec.Zip, '', '', '', 
                                          temp_addr_rec.Address1, temp_addr_rec.Address2, '');
        
      clean_addr := Address.GetCleanNameAddress.fnCleanAddress(temp_addr);
      SELF.prim_range  := clean_addr.prim_range;
      SELF.predir      := clean_addr.predir;
      SELF.prim_name   := clean_addr.prim_name;
      SELF.addr_suffix := clean_addr.addr_suffix;
      SELF.postdir     := clean_addr.postdir;
      SELF.unit_desig  := clean_addr.unit_desig;
      SELF.sec_range   := clean_addr.sec_range;
      SELF.p_city_name := clean_addr.p_city_name;
      SELF.st          := clean_addr.st;
      SELF.z5          := clean_addr.zip;
      SELF.zip4        := clean_addr.zip4;

      SELF := L;  // assign parsed name fields from left
      SELF := []; // null all other fields not already assigned (phone, ssn, dob, did, record_sid, etc.) 
                  // some will be assigned later
    END;

    ds_parse_res_addrs := NORMALIZE(ds_in_resp_name_parsed,
                                    COUNT(LEFT.response.Results[1].PersonalContactInfo.AddressRecords),
                                    tf_Norm_addrs(LEFT, COUNTER));


    // Use below to normalize all PhoneRecords, using Results.Name.Text "name cleaned" from above, 
    // plus once for each PersonalContactInfo.PhoneRecords
    $.Layouts.common_optout tf_Norm_phones(rec_response_wseq_parsedname L,
                                           integer norm_count) := TRANSFORM

      SELF.seq            := L.response_seq; 

      // NOTE: at this point there is only 1 record in each 'Results' child ds on each response record; 
      // so the "...Results[1]..." can be used in multiple places below.
      // Use common layout sec_id field to hold the 'Results' child ds results_seq#
      SELF.section_id     := L.response.Results[1].results_seq;

      SELF.phone10 := L.response.Results[1].PersonalContactInfo.PhoneRecords[norm_count].value;

      SELF := []; // null all other fields not already assigned (name, address, email, ssn, dob, did, record_sid, etc.)
    END;

    ds_parse_res_phones := NORMALIZE(ds_in_resp_name_parsed,
                                     COUNT(LEFT.response.Results[1].PersonalContactInfo.PhoneRecords),
                                     tf_Norm_phones(LEFT, COUNTER));

    // Join to put all the normed data into 1 dataset keeping most data from left and only phone from right
    // and setting other common fields as needed.
    ds_parse_results_out := JOIN(ds_parse_res_addrs, ds_parse_res_phones,
                                   LEFT.seq = RIGHT.seq
                                   AND
                                   LEFT.section_id = RIGHT.section_id,
                                 TRANSFORM($.Layouts.common_optout,
                                   SELF.phone10    := RIGHT.phone10;
                                   SELF.global_sid := $.Constants.Netwise.GLOBAL_SID_EMAIL;
                                   SELF            := LEFT //rest of info (name, address, email, etc. comes from LEFT
                                 ),
                                 FULL OUTER // 1 rec for every normed address
                                );

    //OUTPUT(ds_in_response,            named('ds_in_response'));
    //OUTPUT(ds_in_resp_name_parsed,    named('ds_in_resp_name_parsed'));
    //OUTPUT(ds_parse_res_addrs,        named('ds_parse_res_addrs')); 
    //OUTPUT(ds_parse_res_phones,       named('ds_parse_res_phones')); 
    //OUTPUT(ds_parse_results_out,      named('ds_parse_results_out')); 

    RETURN ds_parse_results_out;
  END;


  // ********************************************************************************************************
  // ********************************************************************************************************
  EXPORT fn_CleanRequest(DATASET(iesp.net_wise.t_NetWiseQueryRequest) ds_request_in, 
                         doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

    // Add a sequence# to each request dataset record to be used for joining on later.
    rec_request_wseq tf_add_req_seq(iesp.net_wise.t_NetWiseQueryRequest L, INTEGER C) := TRANSFORM
      SELF.request_seq := C;
      SELF             := L;
    END;

    ds_req_in_wseq := PROJECT(ds_request_in, tf_add_req_seq(LEFT,COUNTER));

    ds_req_parsed := fn_parseRequest(ds_req_in_wseq);

    dx_gateway.mac_flag_optout(ds_req_parsed, ds_req_did_optout, mod_access);

    ds_req_clean := JOIN(ds_req_in_wseq, ds_req_did_optout(~is_suppressed), 
                           LEFT.request_seq = RIGHT.seq,
                         TRANSFORM(iesp.net_wise.t_NetWiseQueryRequest,
                           SELF := LEFT),
                         KEEP(1), LIMIT(0));

    //OUTPUT(ds_request_in,           named('ds_request_in'));
    //OUTPUT(ds_req_in_wseq,          named('ds_req_in_wseq'));
    //OUTPUT(ds_req_parsed,           named('ds_req_parsed'));
    //OUTPUT(ds_req_did_optout,       named('ds_req_did_optout'));
    //OUTPUT(ds_req_clean,            named('ds_req_clean'));

    RETURN ds_req_clean;

  END;


  // ********************************************************************************************************
  // ********************************************************************************************************
  EXPORT fn_CleanResponse(DATASET(iesp.net_wise.t_NetWiseQueryResponseEx) ds_response_in,
                          doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

    // Add a response sequence# and a results sequence# to each response 'Results' child dataset record 
    // to be used for joining on later.
    rec_results_wseq tf_add_results_seq(iesp.net_wise_share.t_NetWiseResult L, INTEGER C) := TRANSFORM
      SELF.results_seq := C;
      SELF             := L;
    END;

    rec_response_wseq tf_add_resp_seq(iesp.net_wise.t_NetWiseQueryResponseEx L, INTEGER C) := TRANSFORM
      SELF.response_seq     := C;
      SELF.response.Results := PROJECT(L.response.Results, tf_add_results_seq(LEFT,COUNTER));
      SELF                  := L;
    END;

    ds_resp_in_wseq := PROJECT(ds_response_in, tf_add_resp_seq(LEFT,COUNTER));

    // Next parse the sequenced response 'Results' child dataset records to normalize off all the PII data.
    ds_resp_in_parsed := fn_parseResponse(ds_resp_in_wseq);

    // Try to assign a did/LexID to each normalized/parsed record (name plus address/phone pair)
    dx_gateway.mac_append_did(ds_resp_in_parsed,
                              ds_resp_did_append,
                              mod_access, 
                              $.Constants.DID_APPEND_LOCAL);

    // Remove duplicate did recs for the same seq# and section_id# to cut down on the number of opt_out key lookups
    ds_resp_did_app_dedup := DEDUP(SORT(ds_resp_did_append, seq, section_id, did),
                                        seq, section_id, did);
  
    // Check deduped dids for opt_out
    dx_gateway.mac_flag_optout(ds_resp_did_app_dedup, ds_resp_did_optout, mod_access);

   // In case multiple LexIds for 1 response 'Results' record (normed recs with same seq & section_id values) 
   // were opted out, only need to keep 1 for each seq & section_id combo, preferring any that are "suppressed" 
   // over those that are not.
   // Note: "is_suppressed" is a boolean, so it has to be sorted descending.   
   ds_resp_did_optout_dedup := DEDUP(SORT(ds_resp_did_optout,
                                          seq, section_id, -is_suppressed), // is_suppressed TRUEs before FALSEs
                                     seq, section_id);

   // Finally, project the sequenced response in ds onto the original response layout (without seq#s) using a separate 
   // transform to build each response 'Results' child ds and blanking out any child ds record that corresponds 
   // to a lexid that was opted out.
   iesp.net_wise_share.t_NetWiseResult tf_results_final(rec_results_wseq L,
                                                        UNSIGNED1 resp_seq) := TRANSFORM
                                                                                
     // Find matching response_seq & results_seq in the ds_resp_did_optout_dedup dataset from above 
     // for use in this transform and set a boolean for ease of use in the lines below.
     boolean IS_SUPPRESSED := ds_resp_did_optout_dedup(seq        = resp_seq
                                                       AND 
                                                       section_id = L.results_seq)[1].is_suppressed;
     // When ccpa opted out found (is_suppressed=true), only output the echoed input Email 
     SELF.Email := L.Email;
     // When opted out, all other gateway response 'Results' child dataset fields are to be blanked out
     // Otherwise if NOT opted out, just output the original passed in gateway response 'Results' data
     SELF.LinkedInProfileUrl      := IF(IS_SUPPRESSED, '', L.LinkedInProfileUrl);
     SELF.LinkedInProfileImageUrl := IF(IS_SUPPRESSED, '', L.LinkedInProfileImageUrl);
     SELF.Age                     := IF(IS_SUPPRESSED, '', L.Age);
     SELF.PersonalContactInfo     := IF(IS_SUPPRESSED, ROW([], iesp.net_wise_share.t_NetWisePersonalContactInfo),
                                                       L.PersonalContactInfo);
     SELF.WorkRecords      := IF(IS_SUPPRESSED, dataset([], iesp.net_wise_share.t_NetWiseWork), L.WorkRecords);                                                                               
     SELF.EducationRecords := IF(IS_SUPPRESSED, dataset([], iesp.net_wise_share.t_NetWiseEducation), L.EducationRecords);                                                                 
     SELF.Bio.Gender       := IF(IS_SUPPRESSED, '', L.Bio.Gender);
     SELF.Bio.Age          := IF(IS_SUPPRESSED, '', L.Bio.Age);
     SELF.NameRecords      := IF(IS_SUPPRESSED, dataset([], iesp.share.t_StringArrayItem), L.NameRecords);
     SELF.Name.Text        := IF(IS_SUPPRESSED, '', L.Name.Text);
     SELF.ImageRecords     := IF(IS_SUPPRESSED, dataset([], iesp.net_wise_share.t_NetWiseUrl), L.ImageRecords);
     SELF.PlaceRecords     := IF(IS_SUPPRESSED, dataset([], iesp.net_wise_share.t_NetWiseUrl), L.PlaceRecords);

     // v--- 02/25/2020(RR-18527), chgs needed due to iesp.net_wise & iesp.net_wise_share ESP gw response.Results changes
     SELF.PersonId             := IF(IS_SUPPRESSED, '', L.PersonId);
     SELF.FullName             := IF(IS_SUPPRESSED, '', L.FullName);
     SELF.FirstName            := IF(IS_SUPPRESSED, '', L.FirstName); 
     SELF.LastName             := IF(IS_SUPPRESSED, '', L.LastName);
     SELF.OptionalFieldMatches := IF(IS_SUPPRESSED, ROW([], iesp.net_wise_share.t_NetWiseOptionalFieldMatches),
                                                    L.OptionalFieldMatches);
   END;

   ds_resp_clean := PROJECT(ds_resp_in_wseq, 
                            TRANSFORM(iesp.net_wise.t_NetWiseQueryResponseEx, // use orig layout without the temp seq#s
                              temp_response_seq := LEFT.response_seq; // need response_seq to pass into transform below
                              SELF.response.Results := PROJECT(LEFT.response.Results, 
                                                               tf_results_final(LEFT, temp_response_seq));
                              SELF := LEFT;
                           ));


    //OUTPUT(ds_response_in,           named('ds_response_in'));
    //OUTPUT(ds_resp_in_wseq,          named('ds_resp_in_wseq'));
    //OUTPUT(ds_resp_in_parsed,        named('ds_resp_in_parsed'));
    //OUTPUT(ds_resp_did_append,       named('ds_resp_did_append'));
    //OUTPUT(ds_resp_did_app_dedup,    named('ds_resp_did_app_dedup'));
    //OUTPUT(ds_resp_did_optout,       named('ds_resp_did_optout'));
    //OUTPUT(ds_resp_did_optout_dedup, named('ds_resp_did_optout_dedup')); 
    //OUTPUT(ds_resp_clean,            named('ds_resp_clean'));

    RETURN ds_resp_clean;

  END;

END;
