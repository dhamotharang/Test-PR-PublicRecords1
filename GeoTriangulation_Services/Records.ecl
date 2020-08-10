IMPORT Address_Attributes, BatchServices, GeoTriangulation_Services, STD;

EXPORT Records(DATASET(GeoTriangulation_Services.Layouts.rec_batch_seq) ds_batch_in_seq) := FUNCTION

  //Short names/aliases
  ABDCNST := BatchServices.AccuityBankData_Constants;
  GTCNST  := GeoTriangulation_Services.Constants;

  // v--- NOTE: some of this coding was cloned from BatchServices.AccuityBankData_BatchService and revised as needed for GeoTriang

  // Determine whether each input record has all of the required fields to be processed and 
  // TRANSFORM onto the AccuityBankData_BatchService interim/work layout so can use it to call BS.ABD_Records later
  BatchServices.AccuityBankData_Layouts.batch_wrk tf_ValidateInputs(GeoTriangulation_Services.Layouts.rec_batch_seq L) := TRANSFORM
    RTN := L.bank_routing_number;
    ST  := L.st;
    IP  := L.ip_address;

    // Fill in fields used by BatchServices.AccuityBankData_Records
    SELF.in_routing_nbr := RTN;
    SELF.in_state       := ST;

    //Check for required input
    SELF.error_code     := IF(LENGTH(TRIM(RTN,ALL))= 9 AND RTN != GTCNST.NineZeros AND
                              LENGTH(TRIM(ST,ALL))= 2 AND
                              IP != '' AND
                              (L.prim_name !='' and ((L.p_city_name !='' and L.st !='') or L.z5 !=''))
                              ,L.error_code, ABDCNST.ErrCode.INSUFFICIENT_INPUT);
    SELF := L;
    SELF := [];
  END;

  ds_input_validated  := PROJECT(ds_batch_in_seq, tf_ValidateInputs(LEFT));

  // Split out recs with all required input vs those missing something (rejects)
  ds_having_req_input := ds_input_validated(error_code = 0);
  ds_rejects          := ds_input_validated(error_code != 0);

  // Run recs with required input through the TRISv3 Functions.getIP_Metadata function
  // to get ip metadata data for a IPv4 format or a IPv6 format input ip_address.
  // This must be done before the call to AccuityBankData_Records because we need the IP metadata edge_region for input to that.
  //
  // First project the input data into the layout expected by the TRISv3 getIPMetadataRecords function
  ds_tris_rec_prjctd   := PROJECT(ds_having_req_input,
                                  TRANSFORM(BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_in_wdid,
                                    SELF.acctno     := LEFT.acctno, 
                                    SELF.ip_address := LEFT.ip_address,
                                    SELF            := [], // only 1 input ip_address, so the rest of the fields can be nulled
                                  ));

  ds_ip_metadata := BatchServices.TaxRefundISv3_BatchService_Functions.getIPMetaDataRecords(ds_tris_rec_prjctd);

  // join ds of valid input records to ds of ip_metdata records to associate the ip metadata found to each input record/acctno
  BatchServices.AccuityBankData_Layouts.batch_wrk tf_IpMetadata (BatchServices.AccuityBankData_Layouts.batch_wrk L,
                                                                 BatchServices.IP_Metadata_Layouts.batch_out_flat_acctno R) := TRANSFORM

    // Do ip addr validation and input addr lat/long vs ip_metadata lat/long distance determination here
    SELF.ValidationIpProblems := BatchServices.TaxRefundISv3_BatchService_Functions.getValidationIpProblems(  //use existing BS.TRISv3 function
                                                               L.ip_address , R.ip_address1, R.edge_country1);

    in_latitude    := (REAL) L.latitude;
    in_longitude   := (REAL) L.longitude;
    ipmd_latitude  := (REAL) R.edge_latitude1;
    ipmd_longitude := (REAL) R.edge_longitude1;
    SELF.IPAddrExceedsInputAddr := IF(Address_Attributes.functions.GeoDist( //Like done in TRISv3, use existing function to do the distance calculation
                                      in_latitude, in_longitude, ipmd_latitude, ipmd_longitude) > GTCNST.IpValidDistance, 
                                      GTCNST.IpExceedsInAddr, '');

    // Store the ip_metadata fields from the 'right' ds coresponding ***1 fields 
    SELF.in_region           := R.edge_region1;  // for use in call to BS.ABD_Records below
    SELF.edge_country        := R.edge_country1;
    SELF.ipm_edge_region     := R.edge_region1; //note out field name change due to layout field names conflict
    SELF.edge_city           := R.edge_city1;
    SELF.edge_conn_speed     := R.edge_conn_speed1;
    SELF.edge_latitude       := R.edge_latitude1;
    SELF.edge_longitude      := R.edge_longitude1;
    SELF.edge_postal_code    := R.edge_postal_code1;
    SELF.edge_continent_code := R.edge_continent_code1;
    SELF.edge_gmt_offset     := R.edge_gmt_offset1;
    SELF.isp_name            := R.isp_name1;
    SELF.domain_name         := R.domain_name1;
    SELF.proxy_type          := R.proxy_type1;
    SELF.proxy_description   := R.proxy_description1;
    SELF.asn                 := R.asn1;
    SELF.asn_name            := R.asn_name1;
    SELF                     := L;  // keep rest of fields with matching names from left ds
    SELF                     := []; // null any remaining fields
  END;

  ds_batch_in_wipm := JOIN(ds_having_req_input, ds_ip_metadata,
                             LEFT.acctno = RIGHT.acctno,
                           tf_IpMetadata(LEFT,RIGHT),
                           LEFT OUTER);

  // For 'rejects', also set ValidationIpProblems='-1' if input ip_address is null(blank)
  ds_rejects_in_ip_chkd := PROJECT(ds_rejects,
                                   TRANSFORM(BatchServices.AccuityBankData_Layouts.batch_wrk,
                                     SELF.ValidationIpProblems := IF(LEFT.ip_address = '',  GTCNST.IpNotInput,'');
                                     SELF := LEFT;)
                                  );

  // Call BatchServices.AccuityBankData_Records to look up the input bank routing number on the bank routing key and set 3 fields
  ds_abd_records := BatchServices.AccuityBankData_Records(ds_batch_in_wipm);
  
  // Join ds with ipm data with the 1 out of BS.ABD_Records above
  ds_ipm_and_br_info := JOIN(ds_batch_in_wipm, ds_abd_records,
                               LEFT.acctno = RIGHT.acctno, 
                             TRANSFORM(BatchServices.AccuityBankData_Layouts.batch_wrk,
                               // Take 3 fields from 'Right' ds
                               SELF.err_search     := RIGHT.err_search,
                               SELF.routing_number := RIGHT.routing_number,
                               SELF.routing_state  := RIGHT.routing_state,
                               SELF                := LEFT //take rest of fields from 'Left' ds
                             ),
                             LEFT OUTER); 

   // Combine datasets of valid recs (with ipm & br data added) with the rejected recs and sort back into acctno order
   ds_all_recs := SORT(ds_rejects_in_ip_chkd + ds_ipm_and_br_info, 
                       (UNSIGNED) acctno);

   // Call new BS.ABD_Functions.fn_SetOutputs to set the 2 bank_rtn/state/ip related fields
   ds_w2outputs_set := BatchServices.AccuityBankData_Functions.fn_SetOutputs(ds_all_recs, 
                                                                             TRUE,  // TRUE=IncludeGeotriangulationComparison
                                                                             TRUE); // TRUE=GeoTriangQueryRun

  // Then join ds of 'all recs' with ip & br info to ds with 2 outputs set from above
  ds_recs_out := JOIN(ds_all_recs, ds_w2outputs_set, 
                        LEFT.acctno = RIGHT.acctno, 
                      TRANSFORM(BatchServices.AccuityBankData_Layouts.batch_wrk,
                        // Take 2 fields from right
                        SELF.ultimate_bank_in_state := RIGHT.ultimate_bank_in_state,
                        SELF.geotriangulation       := RIGHT.geotriangulation,
                        SELF                        := LEFT //take rest of fields from Left ds
                      ),
                      LEFT OUTER); 


  // *--- DEBUG outputs ---* //
	//OUTPUT(ds_batch_in_seq,            NAMED('ds_batch_in_seq'));
	//OUTPUT(ds_input_validated,         NAMED('ds_input_validated'));
  //OUTPUT(ds_having_req_input,        NAMED('ds_having_req_input'));
  //OUTPUT(ds_rejects,                 NAMED('ds_rejects'));
  //OUTPUT(ds_tris_rec_prjctd,         NAMED('ds_tris_rec_prjctd'));
  //OUTPUT(ds_ip_metadata,             NAMED('ds_ip_metadata'));
  //OUTPUT(ds_batch_in_wipm,           NAMED('ds_batch_in_wipm'));
  //OUTPUT(ds_rejects_in_ip_chkd,      NAMED('ds_rejects_in_ip_chkd'));
  //OUTPUT(ds_abd_records,             NAMED('ds_abd_records'));
  //OUTPUT(ds_ipm_and_br_info,         NAMED('ds_ipm_and_br_info'));
  //OUTPUT(ds_all_recs,                NAMED('ds_all_recs'));
  //OUTPUT(ds_w2outputs_set,           NAMED('ds_w2outputs_set'));
  //OUTPUT(ds_recs_out,                NAMED('ds_recs_out'));

  RETURN ds_recs_out;

END;
