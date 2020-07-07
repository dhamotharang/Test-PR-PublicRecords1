IMPORT doxie, Autokey_batch, FCRA, FFD, suppress, STD, WatercraftV2_Services;

// Constants
STRING BLNK := '';
STRING CURRENT_IND_STR := 'CURRENT';

toUpper(STRING input) := STD.Str.ToUpperCase(TRIM(input, LEFT, RIGHT));

EXPORT BatchRecords(WatercraftV2_Services.Interfaces.batch_params configData,
                    DATASET(WatercraftV2_Services.Layouts.batch_in) clean_in,
                    BOOLEAN isFCRA = FALSE,
                    DATASET(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
                    DATASET(FCRA.Layout_override_flag) ds_flags = DATASET([], FCRA.Layout_override_flag)
                    ) := FUNCTION
                    
  ds_batch_in_common := PROJECT(clean_in, Autokey_batch.Layouts.rec_inBatchMaster);

  // Search via AutoKey
  fromAK := WatercraftV2_Services.BatchIds.AutoKeyIds(ds_batch_in_common);
                  
  // Search via DID and DID Lookup (deepdive)
  fromDID := WatercraftV2_Services.BatchIds.byDIDIds(ds_batch_in_common, configData.RunDeepDive, isFCRA);
  
  // Search via business linkids
  fromLinkid := WatercraftV2_Services.BatchIds.byLinkIDs(clean_in,configData.BIPFetchLevel);
  
    // if isFCRA skip autokey search
  acctNos := IF(isFCRA, fromDID, fromAK + fromDID + fromLinkid);
  acctNos_final := DEDUP(SORT(acctNos, acctno, watercraft_key, sequence_key), acctno, watercraft_key, sequence_key);
  
  // Get watercraft based on watercraft ids obtained
  in_watercraftkeys := PROJECT(acctNos_final, TRANSFORM(WatercraftV2_Services.Layouts.search_watercraftkey,
                          SELF.subject_did := LEFT.ldid, SELF := LEFT));
  ds_recs_wk := UNGROUP(WatercraftV2_Services.get_watercraft(in_watercraftkeys, BLNK, isFCRA,
                                                              ds_flags,
                                                              configData.include_non_regulated_sources,
                                                              slim_pc_recs,
                                                              configData.FFDOptionsMask).report());

  ds_recs := IF(configData.ReturnCurrentOnly, ds_recs_wk(toUpper(rec_type) = CURRENT_IND_STR), ds_recs_wk);
  
  // recover acctno and handle non_subject suppression
  WatercraftV2_Services.Layouts.batch_report xformNonSubject(WatercraftV2_Services.Layouts.WCReportEX L, WatercraftV2_Services.Layouts.acct_rec R) := TRANSFORM
    SELF.acctno := R.acctno;
    //suppressing owners that are not the subject searched on and are not a company
    owners_supp := PROJECT(L.owners((UNSIGNED6)did = R.ldid OR (bdid <> '' OR company_name <> '' OR ultId <> 0)),
      TRANSFORM(WatercraftV2_Services.Layouts.owner_report_rec,
         SELF.orig_name := '', SELF := LEFT));

    //adding FCRA restriction tag to non-subject owners
    owners_restricted := PROJECT(L.owners(~((UNSIGNED6)did = R.ldid OR (bdid <> '' OR company_name <> '' OR ultId <> 0))),
      TRANSFORM(WatercraftV2_Services.Layouts.owner_report_rec,
                SELF.lname := FCRA.Constants.FCRA_Restricted, SELF := []));

    owners_returnNameOnly := PROJECT(L.owners(~((UNSIGNED6)did = R.ldid OR (bdid <> '' OR company_name <> '' OR ultId <> 0))),
      TRANSFORM(WatercraftV2_Services.Layouts.owner_report_rec,
                SELF.fname := LEFT.fname,
                SELF.mname := LEFT.mname,
                SELF.lname := LEFT.lname,
                SELF.name_suffix := LEFT.name_suffix,
                SELF := []));

    SELF.owners := MAP(configData.non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription => owners_supp + owners_restricted,
                       configData.non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnNameOnly => owners_supp + owners_returnNameOnly,
                       configData.non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnBlank => owners_supp,
                       L.owners); //default: configData.non_subject_suppresson = Suppress.Constants.NonSubjectSuppression.doNothing
    SELF := L;
  END;

  ds_recs_final := JOIN(ds_recs, acctNos_final,
    LEFT.subject_did = (UNSIGNED6)RIGHT.ldid AND
    LEFT.watercraft_key = RIGHT.watercraft_key AND
    LEFT.sequence_key = RIGHT.sequence_key AND
    LEFT.state_origin = RIGHT.state_origin,
    xformNonSubject(LEFT, RIGHT));
  
  // Calculate penalty
  ds_recs_final_with_penalty := JOIN(
    clean_in, ds_recs_final,
    LEFT.acctno = RIGHT.acctno,
    TRANSFORM(WatercraftV2_Services.Layouts.batch_report,
      SELF.penalt := IF(isFCRA, 0, WatercraftV2_services.Functions.penalize_batch_records(LEFT, RIGHT)),
      SELF := RIGHT,
      SELF := LEFT)); // save errors, if any provided in the input
  
  ds_rsrt := ds_recs_final_with_penalty(penalt <= configData.PenaltThreshold);

  RETURN ds_rsrt;
  
END;
