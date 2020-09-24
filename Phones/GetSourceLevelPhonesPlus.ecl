IMPORT dx_PhonesPlus, Phones, doxie, RiskWise, Suppress, Phone_Shell, std, ut;

// functionmacro for combining stuff into comma-delimited list
// may pull out into some shared location later if it seems useful elsewhere
fn_commaCombo(firstpart, secondpart) := FUNCTIONMACRO
  RETURN TRIM((STRING)firstpart) + ',' + TRIM((STRING)secondpart);
ENDMACRO;

// Expected Input:
// -- dataset of did/phone combos (with optional seq) - the list of phones to grab attributes for
// -- mod_access for restriction and CCPA checking. 
//     - Make certain to populate GLB, DPPA, Industry_Class, DataRestrictionMask, 
//       and anything needed for CCPA appropriately, at a minimum
// -- use_PhoneShell_AllowList - adds extra filtering to the sources the function returns
//     - in order for a new source to be allowed it must be added to the allow-list (an ECL change). 
//     - this allows new sources to be added to the keys but not permitted through this function
//       until the Phone Shell is prepared to start consuming them
//     - the default is set to TRUE so that other products using this shared function will get
//       the same results as the Phone Shell for consistency, but they can turn it off with FALSE
//       to get all the sources (so long as they pass the regular restriction checks of course).

EXPORT GetSourceLevelPhonesPlus(DATASET(Phones.Layouts.SourceLevelAttributes.BatchIn) batch_in,
                         doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END,
                         BOOLEAN use_PhoneShell_AllowList = TRUE) := FUNCTION

  SourceLevelPayloadKey := dx_PhonesPlus.Key_Source_Level_Payload();
  
  // working layout with some extra fields to assist rollup
  layout_working := RECORD
    Phones.Layouts.SourceLevelAttributes.BatchOut - seq;
    BOOLEAN did_match; // used for those payload records for the same phone but a different DID
    UNSIGNED8 source_did; // used to calc phone_did_count
    UNSIGNED4 global_sid; // needed for CCPA suppression
    
    /*UNSIGNED3 orig_dtfseen; // these are just for testing so we can see them
    UNSIGNED3 orig_dtlseen;
    UNSIGNED3 orig_vdtfseen;
    UNSIGNED3 orig_vdtlseen;
    
    // just for testing, dump the rest of the payload here
    dx_PhonesPlus.Layouts.i_source_level_payload;*/
    
    STRING src_all := ''; // for testing
    STRING rules_all := '';
  END;
  
  layout_record_search := RECORD
    UNSIGNED8 did;
    STRING10  phone;
    UNSIGNED8 record_sid;
  END;
  
  // first, sort and dedup input
  // if performance issues, maybe go down to unique phones only (in case same phone came in with multiple DIDs) 
  // and then join back to the DIDs for the transform, rollups, etc.
  deduped_batch_in := DEDUP(SORT(batch_in, did, phone), did, phone);
  
  // while (most) attributes will be for the did/phone combo, the primary search is by phone, so get the record_sid by phone
  // this is an inner join, so phone numbers not in these keys will be dropped, but that's okay they will be joined back to the input at the end
  recordsid_batch_in := JOIN(deduped_batch_in, dx_PhonesPlus.Key_Source_Level_Phone(),
                             KEYED(LEFT.phone = RIGHT.cellphone),
                             TRANSFORM(layout_record_search,
                                       SELF.did := LEFT.did;
                                       SELF.phone := LEFT.phone;
                                       SELF.record_sid := RIGHT.record_sid;
                                      ),
                             // LIMIT(riskwise.max_atmost), KEEP(Phones.Constants.PhoneAttributes.MaxRecsPerPhone));
                             KEEP(riskwise.max_atmost), ATMOST(2 * riskwise.max_atmost));
                             
  // this will transform the payload data into the pre-rolled-up layout we need
  layout_working transformPayload(layout_record_search l, SourceLevelPayloadKey r) := TRANSFORM
    SELF.did   := l.did;
    SELF.phone := l.phone;
    
    didMatch := l.did = r.did;
    SELF.did_match  := didMatch;
    SELF.source_did := r.did;
    
    // there are some cases where e.g. first-seen and last-seen dates seem to be swapped. Get them back in the right order.
    // note also that some dates aren't populated. If so, don't switch them.
    /*SELF.orig_dtfseen := r.datefirstseen; // won't need these in the final, but keep em for now to test logic
    SELF.orig_dtlseen := r.datelastseen;
    SELF.orig_vdtfseen := r.datevendorfirstreported;
    SELF.orig_vdtlseen := r.datevendorlastreported;*/
    date_first_seen_good := IF(r.datefirstseen > r.datelastseen AND r.datelastseen > 0, r.datelastseen, r.datefirstseen);
    date_last_seen_good  := IF(r.datefirstseen > r.datelastseen AND r.datelastseen > 0, r.datefirstseen, r.datelastseen);
    vdate_first_seen_good := IF(r.datevendorfirstreported > r.datevendorlastreported AND r.datevendorlastreported > 0, r.datevendorlastreported, r.datevendorfirstreported);
    vdate_last_seen_good  := IF(r.datevendorfirstreported > r.datevendorlastreported AND r.datevendorlastreported > 0, r.datevendorfirstreported, r.datevendorlastreported);
    
    // the following will be populated/rolled up only if they match the input DID
    SELF.source_did_scores := IF(didMatch, r.did_score, '');
    SELF.source_codes := IF(didMatch, r.source, '');
    SELF.source_household_flags := IF(didMatch, (STRING)r.household_flag, '');
    SELF.source_glb_dppa_flags := IF(didMatch, r.glb_dppa_flag, '');
    SELF.source_dt_nonglb_last_seen := IF(didMatch, (STRING)r.dt_nonglb_last_seen, '');
    SELF.source_date_first_seen := IF(didMatch, (STRING)date_first_seen_good, '');
    SELF.source_date_last_seen  := IF(didMatch, (STRING)date_last_seen_good, '');
    SELF.source_date_vendor_first_reported := IF(didMatch, (STRING)vdate_first_seen_good, '');
    SELF.source_date_vendor_last_reported  := IF(didMatch, (STRING)vdate_last_seen_good, '');
    SELF.source_first_build_date := IF(didMatch, (STRING)r.first_build_date, '');
    SELF.source_last_build_date  := IF(didMatch, (STRING)r.last_build_date, '');
    SELF.source_bitmap := IF(didMatch, r.src_bitmap, 0);
    SELF.source_rules  := IF(didMatch, r.rules, 0);
    
    // testing
    self.src_all := std.str.reverse(ut.IntegerToBinaryString(self.source_bitmap,false));
    self.rules_all := std.str.reverse(ut.IntegerToBinaryString(self.source_rules,false));
    
    // these are calculated across all records regardless of source
    SELF.phone_last_seen_date_same_lexid := IF(didMatch, date_last_seen_good, 0);
    SELF.phone_last_seen_date_diff_lexid := IF(didMatch, 0, IF(r.did = 0, 0, date_last_seen_good)); // make sure to exclude 0 DIDs here
    SELF.phone_vendor_last_seen_same_lexid := IF(didMatch, vdate_last_seen_good, 0);
    SELF.phone_vendor_last_seen_diff_lexid := IF(didMatch, 0, IF(r.did = 0, 0, vdate_last_seen_good)); // make sure to exclude 0 DIDs here
    SELF.phone_did_count := 1; // for counting later
    
    SELF.global_sid := r.global_sid;    
    
    // extra payload output for testing
    //SELF := r;
  END;
  
  // now use that record_sid to grab what we need from the payload key
  batch_payload_unsuppressed := JOIN(recordsid_batch_in, SourceLevelPayloadKey,
                                     KEYED(LEFT.record_sid = RIGHT.record_sid) AND
                                      Phones.Functions.IsPhoneRestricted(RIGHT.origstate,
																																														 mod_access.glb, 
																																														 mod_access.dppa, 
																																														 mod_access.industry_class,
																																														 ,
																																														 RIGHT.datefirstseen, 
																																														 RIGHT.dt_nonglb_last_seen,
																																														 RIGHT.rules, 
																																														 RIGHT.src_bitmap,
																																														 mod_access.DataRestrictionMask 
																																														 ) = FALSE                          
                                      AND IFF(use_PhoneShell_AllowList, Phone_Shell.Common.PhonesPlusSourceAllowed(RIGHT.src_bitmap), TRUE),
                                     transformPayload(LEFT,RIGHT),
                                     // LIMIT(riskwise.max_atmost),KEEP(Phones.Constants.PhoneAttributes.MaxRecsPerPhone));
                                     KEEP(riskwise.max_atmost), ATMOST(2 * riskwise.max_atmost));
                                     
  // run these records through the CCPA suppression routine
  batch_payload := Suppress.MAC_SuppressSource(batch_payload_unsuppressed, mod_access);
  
  // next clean up the data - roll up multiple records of the same source into one record per source (per phone and did combo)
  // for this we want only the records where input DID = source DID (did_match = true)
  // these are sorted with the most-recent record first/at the top
  layout_working consolidateSources(layout_working l, layout_working r) := TRANSFORM
    // want most recent POPULATED value for this
    SELF.source_glb_dppa_flags := IF(l.source_glb_dppa_flags = '', r.source_glb_dppa_flags, l.source_glb_dppa_flags);
  
    // want the max of the last seen dates and the min of the first seen dates
    SELF.source_dt_nonglb_last_seen := MAX(l.source_dt_nonglb_last_seen, r.source_dt_nonglb_last_seen);
    
    SELF.source_date_first_seen := 
      MAP(l.source_date_first_seen = '0' => r.source_date_first_seen,
          r.source_date_first_seen = '0' => l.source_date_first_seen,
                                            MIN(l.source_date_first_seen, r.source_date_first_seen));
    SELF.source_date_last_seen  := MAX(l.source_date_last_seen, r.source_date_last_seen);
    
    SELF.source_date_vendor_first_reported := 
      MAP(l.source_date_vendor_first_reported = '0' => r.source_date_vendor_first_reported, 
          r.source_date_vendor_first_reported = '0' => l.source_date_vendor_first_reported, 
                                                       MIN(l.source_date_vendor_first_reported, r.source_date_vendor_first_reported));
    SELF.source_date_vendor_last_reported  := MAX(l.source_date_vendor_last_reported, r.source_date_vendor_last_reported);
    
    SELF.source_first_build_date := 
      MAP(l.source_first_build_date = '0' => r.source_first_build_date, 
          r.source_first_build_date = '0' => l.source_first_build_date, 
                                             MIN(l.source_first_build_date,r.source_first_build_date));
    SELF.source_last_build_date  := MAX(l.source_last_build_date, r.source_last_build_date);
                                      
    SELF.phone_last_seen_date_same_lexid   := MAX(l.phone_last_seen_date_same_lexid,r.phone_last_seen_date_same_lexid);
    SELF.phone_vendor_last_seen_same_lexid := MAX(l.phone_vendor_last_seen_same_lexid,r.phone_vendor_last_seen_same_lexid);
    
    // everything else just take the most recent record's value
    SELF := l;
  END;
  
  consolidated_payload := ROLLUP(SORT(batch_payload(did_match = TRUE), did, phone, source_codes, -source_date_last_seen, // main sort, most recent-seen record per source
                                                                       -source_date_vendor_last_reported, -source_last_build_date), // extra tie-breaker sorts to get most recent to the top
                                 LEFT.did = RIGHT.did AND
                                 LEFT.phone = RIGHT.phone AND
                                 LEFT.source_codes = RIGHT.source_codes,
                                 consolidateSources(LEFT,RIGHT));
  
  // now we roll all the individual source records per phone/did to get the comma-delimited lists of sources, last seen dates, etc
  // these are still only the didMatch = true records. Result will be one row per phone/did combo
  layout_working rollphones(layout_working l, layout_working r) := TRANSFORM
    // build the comma-delimited lists
    SELF.source_codes := fn_commaCombo(l.source_codes,r.source_codes);
    SELF.source_did_scores := fn_commaCombo(l.source_did_scores,r.source_did_scores);
    SELF.source_household_flags := fn_commaCombo(l.source_household_flags,r.source_household_flags);
    SELF.source_glb_dppa_flags := fn_commaCombo(l.source_glb_dppa_flags,r.source_glb_dppa_flags);
    SELF.source_dt_nonglb_last_seen := fn_commaCombo(l.source_dt_nonglb_last_seen,r.source_dt_nonglb_last_seen);
    SELF.source_date_first_seen := fn_commaCombo(l.source_date_first_seen,r.source_date_first_seen);
    SELF.source_date_last_seen  := fn_commaCombo(l.source_date_last_seen,r.source_date_last_seen);
    SELF.source_date_vendor_first_reported := fn_commaCombo(l.source_date_vendor_first_reported,r.source_date_vendor_first_reported);
    SELF.source_date_vendor_last_reported  := fn_commaCombo(l.source_date_vendor_last_reported,r.source_date_vendor_last_reported);
    SELF.source_first_build_date := fn_commaCombo(l.source_first_build_date,r.source_first_build_date);
    SELF.source_last_build_date  := fn_commaCombo(l.source_last_build_date,r.source_last_build_date);
    
    // combine source_bitmaps via logical OR into a consolidated bitmap containing all sources (like src_all in the rolled key)
    // likewise do the same for the rules bitmap.
    SELF.source_bitmap := l.source_bitmap | r.source_bitmap;
    SELF.source_rules  := l.source_rules | r.source_rules;
    
    // testing
    self.src_all := std.str.reverse(ut.IntegerToBinaryString(self.source_bitmap,false));
    self.rules_all := std.str.reverse(ut.IntegerToBinaryString(self.source_rules,false));
    
    // and the calculated values
    SELF.phone_last_seen_date_same_lexid := MAX(l.phone_last_seen_date_same_lexid,r.phone_last_seen_date_same_lexid);
    SELF.phone_last_seen_date_diff_lexid := 0;
    SELF.phone_vendor_last_seen_same_lexid := MAX(l.phone_vendor_last_seen_same_lexid,r.phone_vendor_last_seen_same_lexid);
    SELF.phone_vendor_last_seen_diff_lexid := 0;
    SELF.phone_did_count := 1; // these are did-match records so there's only one did involved here so far
    
    // that's all the final layout attributes, don't care about the rest of the working layout
    SELF := l;
  END;
  
  phones_rolled := ROLLUP(SORT(consolidated_payload, did, phone, -source_date_last_seen, source_codes),
                          LEFT.did = RIGHT.did AND
                          LEFT.phone = RIGHT.phone,
                          rollPhones(LEFT,RIGHT));
  
  // next we need to populate the diff-lexid attributes from among all the didMatch = false records
  // result is one record per did/phone combo
  layout_working rollDiffDIDs(layout_working l, layout_working r) := TRANSFORM
    SELF.did := l.did;
    SELF.phone := l.phone;
    SELF.phone_last_seen_date_diff_lexid := MAX(l.phone_last_seen_date_diff_lexid,r.phone_last_seen_date_diff_lexid);
    SELF.phone_vendor_last_seen_diff_lexid := MAX(l.phone_vendor_last_seen_diff_lexid,r.phone_vendor_last_seen_diff_lexid);
    // count all unique non-input DIDs per input DID/phone combo. 
    // this is why we sorted by source_did, so each change in source_did is a new unique DID
    SELF.phone_did_count := IF(l.source_did = r.source_did, l.phone_did_count, l.phone_did_count+1);
    SELF.source_did := r.source_did; // preserve the DID to check the next record against
    SELF := []; // don't need anything else on these records
  END;
  
  diff_dids_rolled := ROLLUP(SORT(batch_payload(did_match = FALSE AND source_did <> 0), did, phone, source_did),
                             LEFT.did = RIGHT.did AND
                             LEFT.phone = RIGHT.phone,
                             rollDiffDIDs(LEFT,RIGHT));
  
  // join the didMatch = true and didMatch = false records back together.
  // for phone/did combos in both, consolidate to one record via the transform
  // for phone/did combos in only one or the other, still keep what we have
  // (thus the full outer join)
  // we still want to end up with only one record per did/phone combo
  final_combo := JOIN(phones_rolled, diff_dids_rolled,
                      LEFT.did = RIGHT.did AND
                      LEFT.phone = RIGHT.phone,
                      TRANSFORM(layout_working,
                        SELF.did := MAX(LEFT.did, RIGHT.did);
                        SELF.phone := MAX(LEFT.phone, RIGHT.phone);
                        SELF.phone_last_seen_date_diff_lexid := RIGHT.phone_last_seen_date_diff_lexid;
                        SELF.phone_vendor_last_seen_diff_lexid := RIGHT.phone_vendor_last_seen_diff_lexid;
                        SELF.phone_did_count := LEFT.phone_did_count + RIGHT.phone_did_count;
                        SELF := LEFT),
                      FULL OUTER);
                      
  // join back to input dataset to maintain phone/did combos that were input but the phone did not exist in the keys
  // result should be same number of rows as input (though not likely in the same order)
  // which does mean that if duped input was sent in, the dupes will be retained on the way out. (differentiated by input seq if provided)
  final_output := SORT(JOIN(batch_in, final_combo,
                            LEFT.did = RIGHT.did AND
                            LEFT.phone = RIGHT.phone,
                            TRANSFORM(Phones.Layouts.SourceLevelAttributes.BatchOut,
                              SELF.seq := LEFT.seq;
                              SELF.did := LEFT.did;
                              SELF.phone := LEFT.phone;
                              SELF := RIGHT),
                            LEFT OUTER),
                       seq, did, phone);
  
  // output unrolled payload info (debug)
  // output(choosen(batch_payload,1000),named('unrolled_payload_info'));
  // output(choosen(consolidated_payload,1000),named('did_match_recs'));
  // output(choosen(phones_rolled,1000),named('did_match_rolled'));
  // output(choosen(diff_dids_rolled,1000),named('did_not_match_rolled'));
  // output(choosen(final_combo,1000),named('final_combo'));
  
  return final_output;

END;