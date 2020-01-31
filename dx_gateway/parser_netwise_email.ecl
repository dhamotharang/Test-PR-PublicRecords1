// Currently as of the 02/11/2020 roxie release, this coding is not "batch compatible".
// Will be attempting to add that functionality in the 02/11/2020 2nd cycle.

// ****************** New module description *********************
// Create a new dx_gateway.parser_netwise attribute: 
// to parse the netwise gateway email search <Response><Results> 
// in the iesp.net_wise.t_NetWiseQueryResponseEx.Results child dataset format
// and assign dids to (primary) name (First Last format) + PersonalContactInfo all addresses and all phones.
// Then look for the did on the new (CCPA) suppression opt-out key (see existing macro for that) and when any did for 
// a <Results> record is found, blank out that associated record from the <Results> child dataset.
// NOTE: For netwise email search, do not have to parse/check the input request to the gateway, 
// since it only has an email and we cannot assign a did just from an email.

IMPORT $, Address, doxie, iesp;

EXPORT parser_netwise_email := MODULE

  // Common temp record layout used by both functions below
  SHARED rec_results_wseq := RECORD
      UNSIGNED1 results_seq; // needed for joining later
      iesp.net_wise_share.t_NetWiseResult;
    END;


  EXPORT fn_parseResults(DATASET(rec_results_wseq) ds_in_results, 
                         string16 transid_in 
                        ) := FUNCTION

    rec_results_wseq_parsedname := RECORD
      rec_results_wseq;
      $.Layouts.common_optout.title;
      $.Layouts.common_optout.fname;
      $.Layouts.common_optout.mname;
      $.Layouts.common_optout.lname;
      $.Layouts.common_optout.suffix;
    END;


    rec_results_wseq_parsedname tf_parsename(rec_results_wseq L) := TRANSFORM
      // use standard name cleaner to parse the (full) Name.text into standard name parts
      clean_name  := Address.CleanPersonFML73_fields(L.Name.Text);
      SELF.title  := clean_name.title;
      SELF.fname  := clean_name.fname;
      SELF.mname  := clean_name.mname;
      SELF.lname  := clean_name.lname;  
      SELF.suffix := clean_name.name_suffix;
      SELF             := L;
    END;

    // Project in 'Results' ds thru a transform to parse the Results.Name.Text field data which appears to have 
    // the full name of the person associated with the query input email, in First (no middle?) Last format.
    ds_in_res_wseq_parsedname := PROJECT(ds_in_results, tf_parsename(LEFT));


    // Use below to normalize all AddressRecords, using Results.Name.Text "name cleaned" from above, 
    // plus once for each PersonalContactInfo.AddressRecords
    $.Layouts.common_optout tf_Norm_addrs(rec_results_wseq_parsedname L, integer norm_count) := TRANSFORM

      SELF.seq            := L.results_seq;

      // clean/parse the gateway response.results person's full address
      temp_addr_rec := L.PersonalContactInfo.AddressRecords[norm_count];
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
      
      SELF := L;
      SELF := []; // null all other fields not already assigned (phone, ssn, dob, did, record_sid, etc.) 
                  //some will be assigned later
    END;

    ds_parse_res_addrs := NORMALIZE(ds_in_res_wseq_parsedname, 
                                    COUNT(left.PersonalContactInfo.AddressRecords),
                                    tf_Norm_addrs(LEFT, COUNTER));


    // Use below to normalize all PhoneRecords, using Results.Name.Text "name cleaned" from above, 
    // plus once for each PersonalContactInfo.PhoneRecords
    dx_gateway.Layouts.common_optout tf_Norm_phones(rec_results_wseq_parsedname L, 
                                             integer norm_count
                                            ) := TRANSFORM

      SELF.seq     := L.results_seq;
      SELF.phone10 := L.PersonalContactInfo.PhoneRecords[norm_count].value;
      SELF := []; // null all other fields not already assigned (name, address, email, ssn, dob, did, record_sid, etc.)
    END;


    ds_parse_res_phones := NORMALIZE(ds_in_res_wseq_parsedname, 
                                     COUNT(left.PersonalContactInfo.PhoneRecords),
                                     tf_Norm_phones(LEFT, COUNTER));

    // Join to put all the normed data into 1 dataset keeping most data from left and only phone from right
    // and setting other common fields as needed.
    ds_parse_results_out := JOIN(ds_parse_res_addrs, ds_parse_res_phones,
                                  LEFT.seq = RIGHT.seq,
                                  TRANSFORM(dx_gateway.Layouts.common_optout,
                                    SELF.seq            := LEFT.seq,
                                    SELF.transaction_id := transid_in;
                                    SELF.phone10        := RIGHT.phone10;
                                    SELF.global_sid     := $.Constants.Netwise.GLOBAL_SID_EMAIL;
                                    SELF := LEFT //rest of info (name, address, email, etc. comes from LEFT
                                  ),
                                 FULL OUTER // 1 rec for every normed address
                                );
                                  

    //OUTPUT(ds_in_results,             named('ds_in_results'));
    //OUTPUT(ds_in_res_wseq_parsedname, named('ds_in_res_wseq_parsedname'));
    //OUTPUT(ds_parse_res_addrs,        named('ds_parse_res_addrs')); 
    //OUTPUT(ds_parse_res_phones,       named('ds_parse_res_phones')); 
    //OUTPUT(ds_parse_results_out,      named('ds_parse_results_out')); 

    RETURN ds_parse_results_out;
  END;


  // ********************************************************************************************************
  // ********************************************************************************************************
  EXPORT fn_CleanResponse(
    DATASET(iesp.net_wise.t_NetWiseQueryResponseEx) ds_response_in,
    doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

    // Pull off just the '<Results>' child dataset from the gateway <response>;
    // which includes the PersonalContactInfo/PII data to be parsed and used to try to assign a LexId/did
    ds_results_in := ds_response_in[1].response.Results;

    // Add a sequence# to each Results child dataset record for joining on later
    rec_results_wseq tf_add_seq(iesp.net_wise_share.t_NetWiseResult L, INTEGER C) := TRANSFORM
      SELF.results_seq := C;
      SELF             := L;
    END;

    ds_results_in_wseq := PROJECT(ds_results_in , tf_add_seq(LEFT,COUNTER));

    //First parse the sequenced 'Results' child dataset data
    ds_results_parsed := fn_parseResults(ds_results_in_wseq,
                                         ds_response_in[1].Response._Header.TransactionId);

    // Try to assign a did/LexID to each normalized/parsed record (name plus address/phone) pair)
    dx_gateway.mac_append_did(ds_results_parsed, 
                              ds_results_did_append, 
                              mod_access, 
                              $.Constants.DID_APPEND_LOCAL);

    // remove duplicate did recs for the same seq# to cut down on the number of opt_out key lookups
    ds_results_did_app_dedup := DEDUP(SORT(ds_results_did_append, seq, did),
                                      seq, did);
   
    dx_gateway.mac_flag_optout(ds_results_did_app_dedup, ds_results_did_optout, mod_access);

   // In case multiple LexIds for 1 input 'Results' record (normed recs with same seq value) were opted out, 
   //  only need to keep 1 for each seq#, preferring any that are "suppressed" over those that are not.
   // Note: "is_suppressed" is a boolean, so it has to be sorted descending.   
   ds_results_did_optout_dedup := DEDUP(SORT(ds_results_did_optout,
                                             seq, -is_suppressed), // is_suppressed TRUEs before FALSEs
                                        seq);

   // Join the input 'Response.Results' child dataset that was sequenced with the 
   // normed/parsed/did appended/opt-out checked/deduped dataset of records, joining on seq#.
   // Looking for any records with a person(did) that is opted-out and is to be suppresed.
   // If found, blank out all of the gw response 'Results' data (except the input/echoed email) on the corresponding 
   // 'Results' child ds record.
   ds_results_clean := JOIN(ds_results_in_wseq,  ds_results_did_optout_dedup,
                              LEFT.results_seq = RIGHT.seq, 
                            TRANSFORM(iesp.net_wise_share.t_NetWiseResult, // use orig layout without the temp results_seq
                            // Had to add a SELF.xxx line for each iesp.net_wise_share.t_NetWiseResult field
                              SELF.Email          := LEFT.email; 
                              RIGHT_SUPPRESSED := RIGHT.is_suppressed; // for ease of use in lines below
                              SELF.LinkedInProfileUrl      := IF(RIGHT_SUPPRESSED, '', LEFT.LinkedInProfileUrl);
                              SELF.LinkedInProfileImageUrl := IF(RIGHT_SUPPRESSED, '', LEFT.LinkedInProfileImageUrl);
                              SELF.Age                     := IF(RIGHT_SUPPRESSED, '', LEFT.Age);
                              SELF.PersonalContactInfo.EmailRecords   := IF(RIGHT_SUPPRESSED, 
                                                                            dataset([], iesp.share.t_StringArrayItem),
                                                                            LEFT.PersonalContactInfo.EmailRecords);
                              SELF.PersonalContactInfo.PhoneRecords   := IF(RIGHT_SUPPRESSED, 
                                                                            dataset([], iesp.share.t_StringArrayItem),
                                                                            LEFT.PersonalContactInfo.PhoneRecords);
                              SELF.PersonalContactInfo.AddressRecords := IF(RIGHT_SUPPRESSED, 
                                                                            dataset([], iesp.net_wise_share.t_NetWiseAddress),
                                                                            LEFT.PersonalContactInfo.AddressRecords);
                              SELF.WorkRecords      := IF(RIGHT_SUPPRESSED, dataset([], iesp.net_wise_share.t_NetWiseWork),
                                                                            LEFT.WorkRecords);                                                                               
                              SELF.EducationRecords := IF(RIGHT_SUPPRESSED, dataset([], iesp.net_wise_share.t_NetWiseEducation),
                                                                            LEFT.EducationRecords);                                                                 
                              SELF.Bio.Gender       := IF(RIGHT_SUPPRESSED, '', LEFT.Bio.Gender);
                              SELF.Bio.Age          := IF(RIGHT_SUPPRESSED, '', LEFT.Bio.Age);
                              SELF.NameRecords      := IF(RIGHT_SUPPRESSED, dataset([], iesp.share.t_StringArrayItem),
                                                                            LEFT.NameRecords);
                              SELF.Name.Text        := IF(RIGHT_SUPPRESSED, '', LEFT.Name.Text);
                              SELF.ImageRecords     := IF(RIGHT_SUPPRESSED, dataset([], iesp.net_wise_share.t_NetWiseUrl),
                                                                            LEFT.ImageRecords);
                              SELF.PlaceRecords     := IF(RIGHT_SUPPRESSED, dataset([], iesp.net_wise_share.t_NetWiseUrl),
                                                                            LEFT.PlaceRecords);
                            ),
                            INNER //(default but listed for clarity) 1 out rec for every left that matches a right
                           );

    // Finally re-build the '<Response>' dataset (with 1 record) to be returned to be in 
    // iesp.net_wise.t_NetWiseQueryResponseEx format
    ds_resp_clean := PROJECT(ds_response_in,
                             TRANSFORM(iesp.net_wise.t_NetWiseQueryResponseEx,
                                SELF.response._Header     := LEFT.response._Header;
                                SELF.response.Transaction := LEFT.response.Transaction;
                                SELF.response.Results := ds_results_clean; //use the potentially revised '<Results>' child ds
                             ));


    //OUTPUT(ds_response_in,           named('ds_response_in'));
    //OUTPUT(ds_results_in,            named('ds_results_in'));
    //OUTPUT(ds_results_in_wseq,       named('ds_results_in_wseq'));
    //OUTPUT(ds_results_parsed,        named('ds_results_parsed'));
    //OUTPUT(ds_results_did_append,    named('ds_results_did_append'));
    //OUTPUT(ds_results_did_app_dedup, named('ds_results_did_app_dedup'));
    //OUTPUT(ds_results_did_optout,    named('ds_results_did_optout'));
    //OUTPUT(ds_results_did_optout_test, named('ds_results_did_optout_test')); 
    //OUTPUT(ds_results_did_optout_dedup, named('ds_results_did_optout_dedup')); 
    //OUTPUT(ds_results_clean,         named('ds_results_clean'));
    //OUTPUT(ds_resp_clean,            named('ds_resp_clean'));

    RETURN ds_resp_clean;

  END;

END;
