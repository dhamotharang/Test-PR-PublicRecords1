IMPORT MIDEX_Services,SANCTN,SANCTN_Mari,STD,ut;

EXPORT Search_IDs := MODULE

  EXPORT Mari_NonPublic_Sanct_val(MIDEX_Services.Iparam.searchrecords in_mod) :=
    FUNCTION
    
      autoKey_Hits := MIDEX_Services.Raw_Nonpublic.fn_get_nonPublicAutokeyData();
                
      // CCPA - Suppression will take place with the payload join in the service funtion calls
      // We are only keeping the midex report number components from the key here
      autoKey_Pay := JOIN(autoKey_Hits,SANCTN_Mari.key_autokey_payload,
                          KEYED(LEFT.id = RIGHT.fakeid),
                          TRANSFORM(MIDEX_Services.Layouts.rec_midex_payloadKeyField,
                                    SELF.BATCH := RIGHT.batch;
                                    SELF.INCIDENT_NUM := RIGHT.incident_num;
                                    SELF.PARTY_NUM := RIGHT.party_num;
                                    SELF.MIDEX_RPT_NBR := '';
                                   ),
                          INNER,
                          LIMIT(ut.limits.default,SKIP));

      MIDEX_Services.Macros.MAC_midexPayloadKeyField(autoKey_Pay, ds_nonPub_autoKey, BATCH, INCIDENT_NUM, PARTY_NUM, MIDEX_RPT_NBR );
      
      // CCPA - Suppression will take place with the payload join in the service funtion calls
      // there is no personal info in this key
      ds_nonPub_did := IF(in_mod.DID != '',
                              MIDEX_Services.Raw_Nonpublic.fn_get_nonPublicDidData ( (UNSIGNED6)in_mod.DID ),
                              DATASET( [], MIDEX_Services.Layouts.rec_midex_payloadKeyField )
                             );
      ds_nonPub_ssn4 := IF(in_mod.ssn_last4 != '',
                              MIDEX_Services.Raw_Nonpublic.fn_get_nonPublicSsn4Data ( in_mod.ssn_last4 ),
                              DATASET( [], MIDEX_Services.Layouts.rec_midex_payloadKeyField )
                             );
      ds_nonPub_lic := IF(in_mod.license_number != '',
                              MIDEX_Services.Raw_Nonpublic.fn_get_nonPublicLicNbrData( in_mod.license_number, in_mod.license_state ),
                              DATASET( [], MIDEX_Services.Layouts.rec_midex_payloadKeyField )
                             );
      
      ds_nonPub_nmlsId := IF(in_mod.nmls_id != '',
                              MIDEX_Services.Raw_Nonpublic.fn_get_nonPublicNMLSId( in_mod.nmls_id ),
                              DATASET( [], MIDEX_Services.Layouts.rec_midex_payloadKeyField )
                             );

      ds_nonPub_tin := IF(in_mod.tin != '',
                              MIDEX_Services.Raw_Nonpublic.fn_get_nonPublicTinData( in_mod.tin ),
                              DATASET( [], MIDEX_Services.Layouts.rec_midex_payloadKeyField )
                             );
                                 
      // if the user enters the MIDEX Report Number, pull the three pieces out for the payload key
      ds_nonPub_midexRptNumRaw := IF(in_mod.midex_rpt_num != '',
                                      DATASET( [{TRIM(STD.STR.ToUpperCase(in_mod.midex_rpt_num), LEFT, RIGHT), '' ,'', '' } ], MIDEX_Services.Layouts.rec_midex_payloadKeyField ),
                                      DATASET( [], MIDEX_Services.Layouts.rec_midex_payloadKeyField )
                                     );
      MIDEX_Services.Macros.MAC_getIncidentNumFromMidexReportNum ( ds_nonPub_midexRptNumRaw, ds_nonPub_midexRptNum );
            
            
      ds_all_nonPub_midexRptNums := DEDUP(ds_nonPub_autoKey +
                                          ds_nonpub_did +
                                          ds_nonpub_ssn4 +
                                          ds_nonpub_lic +
                                          ds_nonpub_tin +
                                          ds_nonPub_nmlsId +
                                          ds_nonpub_midexRptNum,ALL);
      
      RETURN(ds_all_nonpub_midexRptNums);
    END; // Mari_NonPublic_Sanct_val
  
  EXPORT Mari_Public_Sanct_val(MIDEX_Services.Iparam.searchrecords in_mod) :=
    FUNCTION
    
        ds_pubSanctn_autokey_hits := MIDEX_Services.Raw_Public.fn_get_PublicSanctnAutokeyData();
        // CCPA - Suppression will take place with the payload join in the service funtion calls
        // We are only keeping the midex report number components from the key here
        ds_pubSanctnAutokey_pay :=
          JOIN( ds_pubSanctn_autokey_hits,
                SANCTN.Key_SANCTN_autokey_payload,
                KEYED(LEFT.id = RIGHT.fakeid),
                TRANSFORM( MIDEX_Services.Layouts.rec_midex_payloadKeyField,
                           SELF.BATCH := RIGHT.batch_number;
                           SELF.INCIDENT_NUM := RIGHT.incident_number;
                           SELF.PARTY_NUM := RIGHT.party_number;
                           SELF.midex_rpt_nbr := '';
                         ),
                INNER,
                LIMIT(ut.limits.default,SKIP));

        MIDEX_Services.Macros.MAC_midexPayloadKeyField(ds_pubSanctnAutokey_pay, ds_PubSanctn_autoKey, BATCH, INCIDENT_NUM, PARTY_NUM, MIDEX_RPT_NBR );
                     
        // CCPA - Suppression will take place with the payload join in the service funtion calls
        // there is no personal info in this key
        ds_PubSanctn_did := IF(in_mod.DID != '',
                               MIDEX_Services.Raw_Public.fn_get_PublicSanctnDidData( (UNSIGNED6)in_mod.DID ),
                               DATASET( [], MIDEX_Services.Layouts.rec_midex_payloadKeyField )
                              );

        ds_PubSanctn_ssn4 := IF(in_mod.ssn_last4 != '',
                                MIDEX_Services.Raw_Public.fn_get_PublicSanctnSsn4Data ( in_mod.ssn_last4 ),
                                DATASET( [], MIDEX_Services.Layouts.rec_midex_payloadKeyField )
                               );
        
        ds_PubSanctn_lic := IF(in_mod.license_number != '',
                              MIDEX_Services.Raw_Public.fn_get_PublicLicNbrData( in_mod.license_number, in_mod.license_state ),
                              DATASET( [], MIDEX_Services.Layouts.rec_midex_payloadKeyField )
                             );
                             
        ds_PubSanctn_nmlsId := IF(in_mod.nmls_id != '',
                                  MIDEX_Services.Raw_Public.fn_get_PublicNMLSIdData( in_mod.nmls_Id ),
                                  DATASET( [], MIDEX_Services.Layouts.rec_midex_payloadKeyField )
                                 );

        ds_PubSanctn_midexRptNumRaw := IF(in_mod.midex_rpt_num != '',
                                           DATASET( [{in_mod.midex_rpt_num, '' ,'', '' }], MIDEX_Services.Layouts.rec_midex_payloadKeyField ),
                                           DATASET( [], MIDEX_Services.Layouts.rec_midex_payloadKeyField )
                                          );
        MIDEX_Services.Macros.MAC_getIncidentNumFromMidexReportNum ( ds_PubSanctn_midexRptNumRaw, ds_PubSanctn_midexRptNum );
      
        ds_PubSanctn_midexRptNums := DEDUP(ds_PubSanctn_autoKey +
                                           ds_Pubsanctn_did +
                                           ds_Pubsanctn_ssn4 +
                                           ds_PubSanctn_lic +
                                           ds_PubSanctn_nmlsId +
                                           ds_Pubsanctn_midexRptNum,ALL);

    RETURN(ds_PubSanctn_midexRptNums);
  END; // Mari_Public_Sanct_val
  
  EXPORT Mari_ProfLic_val(MIDEX_Services.Iparam.searchrecords in_mod) :=
    FUNCTION
    
        // CCPA - Suppression will take place with the payload join in the service funtion calls
        // We are only keeping the midex report number components from the key here
        ds_autokey_ProfLicMari_mari_rids := MIDEX_Services.Raw_ProfessionalLicenses.fn_get_ProfLicMari_AutokeyData();
        
        
        ds_inDid_ProfLicMari_mari_rids := IF(in_mod.DID != '',
                                             MIDEX_Services.Raw_ProfessionalLicenses.fn_get_ProfLicMari_DidData( (UNSIGNED6)in_mod.DID ),
                                             DATASET( [], MIDEX_Services.Layouts.rec_profLicMari_payloadKeyField )
                                            );
        
        ds_inTin_ProfLicMari_mari_rids := IF(in_mod.tin != '',
                                             MIDEX_Services.Raw_ProfessionalLicenses.fn_get_ProfLicMari_tinSsnData ( in_mod.tin, 'E' ),
                                             DATASET( [], MIDEX_Services.Layouts.rec_profLicMari_payloadKeyField )
                                            );
        
        
        ds_inSsn4_ProfLicMari_mari_rids := IF(in_mod.ssn_last4 != '',
                                              MIDEX_Services.Raw_ProfessionalLicenses.fn_get_ProfLicMari_tinSsnData ( (STRING4)in_mod.ssn_last4, 'S4' ),
                                              DATASET( [], MIDEX_Services.Layouts.rec_profLicMari_payloadKeyField )
                                             );
        

        ds_inLic_ProfLicMari_mari_rids := IF(in_mod.license_number != '',
                                             MIDEX_Services.Raw_ProfessionalLicenses.fn_get_ProfLicMari_licNbrData( in_mod.license_number, in_mod.license_state ),
                                             DATASET( [], MIDEX_Services.Layouts.rec_profLicMari_payloadKeyField )
                                            );
        
        ds_inNmlsID_ProfLicMari_mari_rids := IF(in_mod.nmls_id != '',
                                             MIDEX_Services.Raw_ProfessionalLicenses.fn_get_ProfLicMari_nmlsIDData( in_mod.nmls_id ),
                                             DATASET( [], MIDEX_Services.Layouts.rec_profLicMari_payloadKeyField )
                                            );
                                            
        ds_ProfLicMari_mari_rids := DEDUP(ds_autokey_ProfLicMari_mari_rids +
                                          ds_inDid_ProfLicMari_mari_rids +
                                          ds_inTin_ProfLicMari_mari_rids +
                                          ds_inSsn4_ProfLicMari_mari_rids +
                                          ds_inLic_ProfLicMari_mari_rids +
                                          ds_inNmlsID_ProfLicMari_mari_rids,ALL);
    
    RETURN(ds_ProfLicMari_mari_rids);
  END; // Mari_ProfLic_val
  
END;
