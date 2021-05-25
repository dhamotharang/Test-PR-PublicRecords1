IMPORT Gateway, iesp, PhoneFinder_Services;

EXPORT GetIconectivElep_GatewayRecs(DATASET(PhoneFinder_Services.Layouts.SubjectPhone) ds_subjectInfo_in,
                                    PhoneFinder_Services.iParam.SearchParams inMod,
                                    DATASET(Gateway.Layouts.Config) ds_Gateways
                                   ) := FUNCTION

  makeGatewayCall := inMod.IncludePortingDetails; // make the gateway call based upon new DPM[38] != 0/blank

  // To reduce the number of potential records being sent into the gateway, sort & dedup the input ds so we only 
  // use 1 record for each phone/acctno combo, preferring any rec with a non-zero did (for use in ccpa opt_out checking).
  ds_subjectInfo_in_dd := DEDUP(SORT(ds_subjectInfo_in, acctno, phone, -did), 
                                acctno, phone);

  //Project subject input layout (acctno, did & phone) onto the Iconectiv iesp gateway request layout
  ds_gw_req_in := PROJECT(ds_subjectInfo_in_dd,
                          TRANSFORM(PhoneFinder_Services.Layouts.IconectivElepRequest_ext, // need a gw request layout with did & acctno also
                            SELF.Options.MaxHistoryCount := inMod.IconectivElepGwMaxHistories, 
                            // subjectInfo_in just has 1 phone#, so make into 1 row of a gateway request dataset
                            SELF.SearchBy.PhoneNumbers   := DATASET([{LEFT.phone}], iesp.share.t_StringArrayItem),
                            SELF.acctno                  := LEFT.acctno,
                            SELF.did                     := LEFT.did, 
                            SELF := [] // just null GatewayParams here, they will be set in Gateway.SoapCall_IconectivElep
                          ));

  // Call the attribute that does the actual SoapCall
  ds_gw_resp_out := Gateway.SoapCall_IconectivElep(ds_gw_req_in, 
                                                   inMod,
                                                   ds_gateways,
                                                   Gateway.Constants.Defaults.ICONECTIV_ELEP_TIMEOUT, 
                                                   Gateway.Constants.Defaults.ICONECTIV_ELEP_RETRIES, 
                                                   Gateway.Constants.Defaults.ICONECTIV_ELEP_NUM_THREADS,
                                                   makeGatewayCall, 
                                                   TRUE // TRUE=apply CCPA opt out logic
                                                  );

  // NOTE: In Gateway.SoapCall_IconectivElep, the gateway is called with a dataset of records, but only 1 input phone# 
  //       will be on each record.
  //       Therefore each gateway output "response" record will only contain 1 response.ElepHistoryReponse.PortingRecords 
  //       child dataset record.
  //       Which is why 'PortingRecords[1]' can be used in the in-line TRANSFORM below.
  //
  // Project the records in the iesp Iconectiv Elep gateway response layout onto SubjectPhone & Porting combined layout
  ds_gw_resp_formatted := PROJECT(ds_gw_resp_out,
                                  TRANSFORM(PhoneFinder_Services.Layouts.SubPhone_Porting_Comb,
                                    // grab requested phone# that is returned in the gw response
                                    SELF.phone := LEFT.response.ElepHistoryResponse.PortingRecords[1].PhoneNumber,
                                    // Handle the gw response PortingRecords[1].PortingHistory child dataset records
                                    SELF.portingcount   := COUNT(LEFT.response.ElepHistoryResponse.PortingRecords[1].PortingHistory),
                                    SELF.PortingHistory := PROJECT(LEFT.response.ElepHistoryResponse.PortingRecords[1].PortingHistory,
                                                                   TRANSFORM(PhoneFinder_Services.Layouts.PhoneFinder.PortHistory,
                                                                     //Convert LEFT.OwnedSinceDate in iesp.share.t_date2 
                                                                     // format of: <Year>string4</Year><Month>string2</Month><Day>sting2</Day> 
                                                                     // to a UNSIGNED4 yyyymmdd format date
                                                                     STRING4 OSD_year  := LEFT.OwnedSinceDate.Year;
                                                                     STRING2 OSD_month := LEFT.OwnedSinceDate.Month;
                                                                     STRING3 OSD_day   := LEFT.OwnedSinceDate.Day;
                                                                     UNSIGNED4 OSD_US4 := (UNSIGNED2) OSD_day        +
                                                                                          (UNSIGNED2) OSD_month*100  +
                                                                                          (UNSIGNED2) OSD_year*10000;
                                                                     
                                                                     SELF.ServiceProvider := LEFT.ServiceProvider.CompanyName,
                                                                     SELF.PortStartDate   := OSD_US4,
                                                                     SELF.PortEndDate     := 0, //nothing like this returned in gw results
                                                                     SELF.DateofChange := OSD_US4;
                                                                     SELF.ServiceProviderinfo.id            := LEFT.ServiceProvider.ServiceProviderId,
                                                                     SELF.ServiceProviderinfo.company       := LEFT.ServiceProvider.CompanyName,
                                                                     SELF.ServiceProviderinfo.contact       := LEFT.ServiceProvider.ContactName,
                                                                     SELF.ServiceProviderinfo.contact_phone := LEFT.ServiceProvider.ContactPhoneNumber,
                                                                     SELF.AltServiceProviderinfo.id            := LEFT.AltServiceProvider.ServiceProviderId,
                                                                     SELF.AltServiceProviderinfo.company       := LEFT.AltServiceProvider.CompanyName,
                                                                     SELF.AltServiceProviderinfo.contact       := LEFT.AltServiceProvider.ContactName,
                                                                     SELF.AltServiceProviderinfo.contact_phone := LEFT.AltServiceProvider.ContactPhoneNumber,
                                                                     SELF.LastAltServiceProviderinfo.id            := LEFT.LastAltServiceProvider.ServiceProviderId,
                                                                     SELF.LastAltServiceProviderinfo.company       := LEFT.LastAltServiceProvider.CompanyName,
                                                                     SELF.LastAltServiceProviderinfo.contact       := LEFT.LastAltServiceProvider.ContactName,
                                                                     SELF.LastAltServiceProviderinfo.contact_phone := LEFT.LastAltServiceProvider.ContactPhoneNumber,
                                                                     SELF := [];
                                                                   ));
                                    SELF := [];
                                  ));

  // Then join the formatted gw response recs to the input ds deduped to re-attach the correct acctno to each phone#
  ds_gw_resp_formatted_wacctnos := JOIN(ds_subjectInfo_in_dd,
                                        ds_gw_resp_formatted,
                                        LEFT.phone = RIGHT.phone,
                                        TRANSFORM(PhoneFinder_Services.Layouts.SubPhone_Porting_Comb,
                                          SELF.acctno := LEFT.acctno,
                                          SELF.did    := LEFT.did,
                                          SELF.phone  := LEFT.phone,
                                          SELF        := RIGHT // keep gw response data from right
                                        ),
                                        LEFT OUTER
                                       );

  //Outputs for debugging. Un-comment them as needed!
  //OUTPUT(ds_subjectinfo_in,    NAMED('giegr_ds_subjectinfo_in'));
  //OUTPUT(ds_subjectinfo_in_dd, NAMED('giegr_ds_subjectinfo_in_dd'));
  //OUTPUT(ds_gw_req_in,         NAMED('giegr_ds_gw_req_in'));
  //OUTPUT(ds_gw_resp_out,       NAMED('giegr_ds_gw_resp_out'));
  //OUTPUT(ds_gw_resp_formatted, NAMED('giegr_ds_gw_resp_formatted'));
  //OUTPUT(ds_gw_resp_formatted_wacctnos, NAMED('giegr_ds_gw_resp_formatted_wacctnos'));

  RETURN ds_gw_resp_formatted_wacctnos;
          

END;
