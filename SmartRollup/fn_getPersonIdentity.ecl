IMPORT doxie,iesp,PersonReports, smartRollup, header;

  EXPORT  fn_getPersonIdentity ( DATASET (doxie.layout_references) input_dids                                                
                                                   ,PersonReports.IParam._smartlinxreport Mod_smartLinx                                                                                                      
                                                  ) := FUNCTION                                  
      
  header_families  := SmartRollup.fn_smart_getSourceCounts.GetAddressIndicators( 
                         PROJECT(input_dids, TRANSFORM(PersonReports.layouts.header_recPlusSource, SELF.did := LEFT.did; SELF := []; )),
                          Mod_smartLinx).header_ext;	

  // ========================================================================
  // get all header records for all "participants" and categorize sources
  // ========================================================================

  header_rec := RECORD(personreports.layouts.header_recPlusSource)
      TYPEOF (header.key_nlr_payload.not_in_bureau) not_in_bureau := 0;
   END;
  
  // Fetch "no longer reported" by record_id: it'll be attached only to bureaus' records 
  header_ext := JOIN (header_families, header.key_nlr_payload,
                      KEYED (LEFT.did = RIGHT.did) and
                      KEYED (LEFT.rid = RIGHT.rid),
											TRANSFORM (header_rec, SELF.not_in_bureau := RIGHT.not_in_bureau, SELF := LEFT),
                      LEFT OUTER, KEEP (1), LIMIT (0));

  //DIDs
  header_dids := GROUP (SORT (header_ext, did), did);
  
  did_did_rec := RECORD(iesp.smartlinxreport.t_SLRLinkId)
              UNSIGNED6 did;
              UNSIGNED4 dateFirst;
              UNSIGNED4 dateLast;
  END;
  did_did_rec  SetAssociatedDIDs (header_rec L, DATASET (header_rec) R) := TRANSFORM
     SELF.did := L.did; // duplicate
     SELF.UniqueId := INTFORMAT (L.did,12, 1);
     SELF.datefirst := MIN (R (dt_first_seen > 0), dt_first_seen);
     SELF.datelast := MAX (R, dt_last_seen);

      // get source categories' counts:
      SELF.Sources := CHOOSEN (SmartRollup.fn_smart_getSourceCounts.GetSources (R), iesp.Constants.SLR.MaxSourcetypes);    
      SELF.SourceCount :=    COUNT (DEDUP (R, src, all)); // product wants overall count here not just count of # of categories but total source docs
      SELF := [];
  END;
	
  dids_pre := ROLLUP (header_dids, GROUP, SetAssociatedDIDs (LEFT, ROWS (LEFT)));

  iesp.SmartLinxreport.t_SLRPersonRiskIdentity AddAggregateIndicators () := TRANSFORM
      SELF.linkidInfo := dids_pre[1];   
      SELF := [];
   END;

      resultsTmp := DATASET ( [AddAggregateIndicators()]);
      //output(dids_pre, named('dids_pre'));
      // output(header_ext, named('header_ext'));
      // output(header_dids, named('header_dids'));
      // Export results := resultsTmp;
      RETURN(resultsTmp);
  END; // function