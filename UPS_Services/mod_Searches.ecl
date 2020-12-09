﻿IMPORT autoheaderi, autostandardi, BIPV2, doxie, iesp, address, Header, UPS_Services, ut, dx_header;


EXPORT mod_Searches := MODULE

  SHARED AIT := AutoStandardI.InterfaceTranslator;
  SHARED Constant := iesp.Constants.RA;

  // person and business records have slightly different layouts (esp names).
  // This common layout is a standard layout which fits both biz and person
  // responses after this mod is called. Only the fields which we are
  // interested in are preserved..

  // ***** BUSINESS SEARCH *****
  EXPORT BusinessSearch := MODULE
    
    SHARED fn_RestrictBusinessSearch(//AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full in_mod,
      DATASET(BIPV2.IDfunctions.rec_SearchInput) dsInput,
      UPS_Services.mod_Params.BusinessSearch BizParams,
      BOOLEAN useName = TRUE,
      BOOLEAN useStreet = TRUE,
      BOOLEAN useCity = TRUE,
      BOOLEAN useState = TRUE,
      BOOLEAN useZip = TRUE,
      BOOLEAN usePhone = TRUE,
      BOOLEAN useALL = FALSE) := FUNCTION

      InputRow := dsInput[1];
      inName := IF((useName OR useAll), InputRow.company_name, '');

      // Bugzilla 41403
      // we only want to run the street searches if we have a prim_range and
      // a prim_name. Otherwise, we could end up with overly-broad queries
      // such as street name + zip or street name + city + state.
      reallyUseStreet := ((useStreet OR useAll) AND InputRow.prim_range <> '' AND InputRow.prim_name <> '');
      inPrimRange := IF(reallyUseStreet, InputRow.prim_range, '');
      inPrimName := IF(reallyUseStreet, InputRow.prim_name, '');
      inSecRange := IF(reallyUseStreet, InputRow.sec_range, '');

      inCity := IF((useCity OR useAll), InputRow.city, '');
      inState := IF((useState OR useAll), InputRow.state, '');
      inZip:= IF((useZip OR useAll), InputRow.zip5, '');
      inPhone := IF((usePhone OR useAll), InputRow.phone10, '');

      // Format to BIP search layout
      search_input := PROJECT(dsInput,UPS_Services.transforms.adjustSearchInput(LEFT,FALSE,inName,inPhone));

      //this will only be used for cases with '&' or ' AND '
      search_input_altName := PROJECT(dsInput,UPS_Services.transforms.adjustSearchInput(LEFT,TRUE,inName,inPhone));
      
      hasStreet := InputRow.prim_range <> '' OR InputRow.prim_name <> '' OR InputRow.sec_range <> '';
      execute :=
        useALL OR
        (
          (
            // this makes sure that every field is either populated or not in use
            (NOT useName OR InputRow.company_name <> '') AND
            (NOT reallyUseStreet OR hasStreet) AND
            (NOT useCity OR InputRow.city <> '') AND
            (NOT useState OR InputRow.state <> '') AND
            (NOT useZip OR InputRow.zip5 <> '') AND
            (NOT usePhone OR InputRow.phone10 <> '')
          )
          AND
          (
            // the bad situation is where every field not used is empty (because we do an extra search)
            // so, one of the not used fields needs to have a value (or else its just a repeat of the all search)
            // hmm, would this already be taken care of by the first half of the definition of execute if useALL didnt exist?
            (NOT useName AND InputRow.company_name <> '') OR
            (NOT reallyUseStreet AND hasStreet) OR
            (NOT useCity AND InputRow.city <> '') OR
            (NOT useState AND InputRow.state <> '') OR
            (NOT useZip AND InputRow.zip5 <> '') OR
            (NOT usePhone AND InputRow.phone10 <> '')
          )
        );

      // Get links ids for the search criteria
      
      in_mod2 := MODULE(AutoStandardI.DataRestrictionI.params)
        EXPORT BOOLEAN AllowAll := FALSE;
        EXPORT BOOLEAN AllowDPPA := FALSE;
        EXPORT BOOLEAN AllowGLB := FALSE;
        EXPORT STRING DataRestrictionMask := BizParams.datarestrictionmask;
        EXPORT UNSIGNED1 DPPAPurpose := BizParams.dppapurpose;
        EXPORT UNSIGNED1 GLBPurpose := BizParams.glbpurpose;
        EXPORT BOOLEAN ignoreFares := FALSE;
        EXPORT BOOLEAN ignoreFidelity := FALSE;
        EXPORT BOOLEAN includeMinors := FALSE;
      END;
    
      finalInput := search_input + IF(ut.mod_AmpersandTools.hasAmpersandOrHasAnd(inName),search_input_altName);

      tmpTopResultsScoredGrouped := IF( execute,UPS_Services.fn_BIPLookup(finalInput,in_mod2));
                                                 
      rval := DEDUP(SORT(tmpTopResultsScoredGrouped, RECORD), RECORD);
      #IF(UPS_Services.Debug.debug_flag)
        BizQueryHistoryLayout := RECORD
          BOOLEAN Company;
          BOOLEAN Street;
          BOOLEAN City;
          BOOLEAN State;
          BOOLEAN Zip;
          BOOLEAN Phone;
          BOOLEAN _All;
          BOOLEAN executed;
        END;
        hist_ds := DATASET( [ { useName, useStreet, useCity, useState,
                                useZip, usePhone, UseAll, execute } ], BizQueryHistoryLayout);

        BizQueryValsLayout := RECORD
          BOOLEAN execute;
          UNSIGNED numResp;
          STRING120 Company;
          STRING10 PrimRange;
          STRING30 PrimName;
          STRING10 SecRange;
          STRING30 City;
          STRING2 State;
          STRING5 Zip;
          STRING10 Phone;
        END;
        vals_ds := DATASET( [ { execute, COUNT(rval), inName, inPrimRange, inPrimName, inSecRange,
                                inCity, inState, inZip, inPhone } ], BizQueryValsLayout);
        OUTPUT(hist_ds, NAMED('BizQueryHistory'), EXTEND);
        OUTPUT(vals_ds, NAMED('BizQueryValues'), EXTEND);
      #END

      RETURN DEDUP(SORT(tmpTopResultsScoredGrouped, RECORD), RECORD);
    END;

                           
    SHARED RecWeightedLinkID := RECORD(UPS_Services.layouts.RecBipRecordOut2)
      UNSIGNED2 RAweight;
    END;

    SHARED DATASET(RecWeightedLinkID) fn_WeightLinkIds(DATASET(UPS_Services.layouts.RecBipRecordOut2) recs, UNSIGNED2 weight) := FUNCTION

      RecWeightedLinkID weightedTransform(recs L) := TRANSFORM
        SELF := L;
        SELF.RAweight := weight;
      END;

      out_recs := PROJECT(recs, weightedTransform(LEFT));
      RETURN out_recs;
    END;

    SHARED LinkIds(DATASET(BIPV2.IDfunctions.rec_SearchInput) dsInput,
                    UPS_Services.mod_Params.BusinessSearch BizParams) := FUNCTION
                      
      // Get the LinkIds
      mInput := PROJECT(dsInput,TRANSFORM(BIPV2.IDfunctions.rec_SearchInput,
          SELF.state := IF(
          LEFT.state <> '', //IF state is given, use it
          LEFT.state,
            IF(LEFT.city <> '', //IF state empty AND city given, guess the state.
            dx_header.key_CityStChance()(LEFT.state = '' AND KEYED(city_name = LEFT.city) AND percent_chance > 50)[1].st, //no reason not to guess, but > 50 makes me deterministic
            LEFT.state //blank
            )
          );
          SELF.allow7digitmatch := FALSE;
          SELF := LEFT));
          
      // Query BIP in various ways and weight the results.
      linkID_all := fn_RestrictBusinessSearch(mInput,BizParams, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE);
      wt_all := fn_WeightLinkIds(linkID_all, 15);

      linkID_street_city_state_zip := fn_RestrictBusinessSearch(mInput,BizParams, FALSE, TRUE, TRUE, TRUE, TRUE, FALSE);
      wt_street_city_state_zip := fn_WeightLinkIDs(linkID_street_city_state_zip, 3);

      linkID_name_city_state_zip := fn_RestrictBusinessSearch(mInput, BizParams, TRUE, FALSE, TRUE, TRUE, TRUE, FALSE);
      wt_linkID_name_city_state_zip := fn_WeightLinkIDs(linkID_name_city_state_zip, 1);
      
      linkID_name_zip_fuzzy := fn_RestrictBusinessSearch(mInput, BizParams, TRUE, FALSE, FALSE, FALSE, TRUE, FALSE);
      wt_name_zip_fuzzy := PROJECT(
            linkID_name_zip_fuzzy,
            TRANSFORM(
              RecWeightedLinkID,
              SELF.RAweight :=
                IF(LEFT.match_zip >0,LEFT.match_zip,0)
                + IF(LEFT.is_FullMatch,2,0)
                + IF(LEFT.match_company_name > 0 OR
                    LEFT.match_company_name_prefix > 0 OR
                    LEFT.match_cnp_name > 0,1,0),
              SELF := LEFT
            )
          );
      
      linkID_phone := fn_RestrictBusinessSearch(mInput, BizParams, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE);
      wt_phone := fn_WeightLinkIDs(linkID_phone, 7);

      combined_linkIDs := wt_all +
                        wt_street_city_state_zip +
                        wt_name_zip_fuzzy +
                        wt_phone +
                        wt_linkID_name_city_state_zip;

      grouped_linkIDs := GROUP(SORT(combined_linkIDs, UltID , OrgID ,SELEID ,ProxID), UltID , OrgID ,SELEID ,ProxID);
      clinkids := PROJECT(combined_linkIDs,TRANSFORM(UPS_Services.layouts.RecBipRecordOut2, SELF := LEFT , SELF :=[]));
      linkIDWeights := RECORD
        combined_linkIDs ;
        UNSIGNED4 SumRAweight := SUM(GROUP,combined_linkIDs.RAweight);
      END;

      scored_linkIDs := TABLE(grouped_linkIDs, linkIDWeights);
      sorted_linkIDs := SORT(scored_linkIDs, /*-RAweight*/ SumRAweight, ultid, orgid, seleid, proxid,-proxweight);

      max_linkIDs := 150; // TODO - should be based on MaxResults!
      num_linkIDs := COUNT(sorted_linkIDs);
      ref_linkID := IF (num_linkIDs > max_linkIDs, max_linkIDs, num_linkIDs);
      target_score := sorted_linkIDs[ref_linkID].SumRAweight;
      target_linkIDs := IF(num_linkIDs <= max_linkIDs, sorted_linkIDs, sorted_linkIDs(SumRAweight > target_score));

      linkIDs := PROJECT(MAP(num_linkIDs <= max_linkIDs => sorted_linkIDs,
                        COUNT(target_linkIDs) > (0.5 * max_linkIDs) => target_linkIDs,
                        CHOOSEN(sorted_linkIDs, max_linkIDs)), UPS_Services.layouts.RecBipRecordOut2);

      #IF(UPS_Services.Debug.debug_flag)
      OUTPUT(wt_all, NAMED('linkID_wt_all'));
      OUTPUT(COUNT(linkIDs), NAMED('numlinkIDs'));
      OUTPUT(linkIDs, NAMED('linkIDs'));
      #END

      RETURN linkIDs;
    END;

    EXPORT records(UPS_Services.SearchParams SearchParams,
                     UPS_Services.mod_Params.BusinessSearch BizParams) := FUNCTION
      
      dsInput := DATASET([UPS_Services.transforms.ConstructBipInput(SearchParams)]);
      
      bset := linkIDs(dsInput,BizParams);
      uselinkIDs :=
      MAP(
        EXISTS(bset) => bset,
        UPS_Services.Constants.DO_SECOND_SEARCH => mod_SecondSearch.Business(SearchParams, BizParams).records,
        DATASET([], UPS_Services.layouts.RecBipRecordOut2)
      );

      //Get the biz records
      biz_allphones := uselinkIDs;

      //Get the best biz phone
      best_biz_phone := biz_allphones;
      
      //Put the best phone onto the biz record
      biz := best_biz_phone;

      // convert biz records to output layout
      UPS_Services.layout_Common bizToLayoutTransform(biz L) := TRANSFORM
        SELF.rollup_key := L.PowID;
        SELF.rollup_key_type := UPS_Services.Constants.TAG_ROLLUP_KEY_LINKID;
        SELF.dt_last_seen := (INTEGER) L.dt_last_seen;
        SELF.dt_first_seen := (INTEGER) L.dt_first_seen;
        SELF.fname := '';
        SELF.mname := '';
        SELF.lname := '';
        SELF.name_suffix := '';
        SELF.company_name := L.company_name;
        SELF.phone := L.company_phone;
        SELF.prim_range := L.prim_range;
        SELF.predir := L.predir;
        SELF.prim_name := L.prim_name;
        SELF.suffix := L.addr_suffix;
        SELF.postdir := L.postdir;
        SELF.unit_desig := L.unit_desig;
        SELF.sec_range := L.sec_range;
        SELF.city_name := L.city;
        SELF.state := L.st;
        SELF.zip := L.zip;
        SELF.postalcode := '';
        SELF.zip4 := L.zip4;

        SELF.score_name := 0;
        SELF.score_addr := 0;
        // SELF.score_addrStreet := 0;
        // SELF.score_addrCityStZip := 0;
        SELF.score_phone := 0;
        SELF.listing_type := ''; // Used only for canadian data to determine IF business/individual
        SELF.history_flag := ''; // Used only in canadian data
        SELF.Current := MAP (TRIM(L.powid_status_public) = 'I' => 'N',
                            TRIM(L.powid_status_public) <> 'I' => 'Y',
                            'U');
      END;

      resp := CHOOSEN(PROJECT(SORT(biz,ultid, orgid, seleid, proxid,PowID), bizToLayoutTransform(LEFT)), Constant.MAX_SEARCH_RECORDS);//now deterministic

      #IF(UPS_Services.Debug.debug_flag)
      OUTPUT(resp, NAMED('business_recs'));
      OUTPUT(COUNT(resp), NAMED('num_business_recs'));
      OUTPUT(dsInput, NAMED('dsInput'));
      #END
      RETURN resp;
    END; // records() FUNCTION
  END; // BusinessSearch MODULE


  // ***** PERSON SEARCH *****
  EXPORT PersonSearch := MODULE

    SHARED params := mod_Params.PersonSearch;
    SHARED max_dids := 100; // TODO - this should be based on MaxResults!

    EXPORT records(params in_mod) := FUNCTION

      // {in_mod} is basically GlobalModule, but it doesn't define all fields required for projection.
      mod_access := MODULE (doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule ()))
        EXPORT UNSIGNED1 glb := AIT.GLB_Purpose.val(PROJECT(in_mod,AIT.GLB_Purpose.params));
        EXPORT UNSIGNED1 dppa := AIT.DPPA_Purpose.val(PROJECT(in_mod,AIT.DPPA_Purpose.params));
        EXPORT STRING DataPermissionMask := in_mod.DataPermissionMask;
        EXPORT BOOLEAN ln_branded := FALSE;
        EXPORT BOOLEAN probation_override := FALSE;
        EXPORT STRING5 industry_class := AIT.industry_class_val.val(PROJECT(in_mod,AIT.industry_class_val.params));
        EXPORT STRING32 application_type := AIT.application_type_val.val(PROJECT(in_mod,AIT.application_type_val.params));
        EXPORT BOOLEAN no_scrub := FALSE;
        EXPORT UNSIGNED3 date_threshold := 0;
      END;

      // use mod_header_records ONLY to resolve DIDs, skipping daily/util/gong lookups.
      HeaderRecordLookup(DATASET(doxie.layout_references_hh) dids) :=
          doxie.mod_header_records(FALSE, /* do daily/gong/quick search */
                                   FALSE, /* include dailies */
                                   FALSE, /* allow wildcard */
                                   FALSE, /* include_gong */
                                   FALSE, /* suppress_gong_noncurrent */
                                   [], /* daily_autokey_skipset */
                                   FALSE, /* AllowGongFallBack */
                                   FALSE, /* ApplyBpsFilter */
                                   FALSE, /* GongByDidOnly */
                                   mod_access).mod_Header(dids);

      // use mod_header_records only to access daily/gong/util files. In addition to
      // the values in GlobalModule being used for lookups, any records related to the
      // DIDs passed in will be included
      
      GongAndDailyLookup(DATASET(doxie.layout_references_hh) dids) :=
          doxie.mod_header_records(NOT EXISTS(dids), /* do daily/gong/quick search */
                                   NOT EXISTS(dids), /* include dailies */
                                   TRUE, /* allow wildcard */
                                   NOT EXISTS(dids), /* include_gong */
                                   FALSE, /* suppress_gong_noncurrent */
                                   [], /* daily_autokey_skipset */
                                   FALSE, /* AllowGongFallBack */
                                   FALSE, /* ApplyBpsFilter */
                                   EXISTS(dids), /* GongByDidOnly */
                                   mod_access).mod_Daily(dids);


      // might need this for a call to autoheaderi fetch
      AHI_mod := MODULE (PROJECT (in_mod, AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full, opt))
        EXPORT addr := address.Addr1FromComponents(in_mod.prim_range, in_mod.predir, in_mod.prim_name, in_mod.suffix, in_mod.postdir, /*unitdesig*/'', in_mod.sec_range) ;
        EXPORT NoFail := TRUE; //give daily searches a chance - proven to RETURN more results
        EXPORT checknamevariants := FALSE;
      END;

      // autoheaderi does a better job than the partial fetch when state and zip are missing
      std_dids := AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do(AHI_mod);
      par_dids := PROJECT(mod_PartialMatch(in_mod).dids, doxie.layout_references_hh);
      
      dset := CHOOSEN(SORT(IF(in_mod.state = '' AND in_mod.zip = '', std_dids, par_dids),did), max_dids);//now deterministic
      
      DIDs :=
      MAP(
        EXISTS(dset)
          => dset,
        UPS_Services.Constants.DO_SECOND_SEARCH
          => mod_SecondSearch.Individual(in_mod).records,
          DATASET([], doxie.layout_references_hh)
      );
      
      emptyDIDs := DATASET([], doxie.layout_references_hh);

      hdr_recs := HeaderRecordLookup(dids).records;

      // calling GongAndDailyLookup with the set of empty DIDs allows it to be
      // run in parallel with mod_PartialMatch. Calling it with the set of DIDs
      // returned by HeaderRecordLookup forces it to be run sequentially. The
      // parallel/sequential behavior may be toggled by the line uncommented below.

      daily_recs := GongAndDailyLookup(emptyDIDs).records; // parallel with mod_PartialMatch
      // gong_recs := GongAndDailyLookup(dids).records; // executed sequentially (after mod_PM)

      ind := hdr_recs + daily_recs; // + WFPV8_recs;
     
      // The macro Header.MAC_Append_Addr_Ind sorts the result, so we don't have to.
      ind_ranked := Header.MAC_Append_Addr_Ind(ind, addr_ind, /*src*/, did, prim_range ,
                                               prim_name, sec_range, city_name, st, zip,
                                               /*predir*/, /*postdir*/, /*addr_suffix */,
                                               /*dt_first_seen*/, /*dt_last_seen*/, /*dt_vendor_first_reported*/,
                                               /*dt_vendor_last_reported*/ , /*isTrusted*/ ,
                                               /*isFCRA*/, /*hitQH*/, /*debug*/);
                            
      // convert records to output layout
      UPS_Services.layout_Common indToLayoutTransform(ind_ranked L) := TRANSFORM
        SELF.rollup_key := IF (L.did <> 0, L.did, L.rid);
        SELF.rollup_key_type := IF (L.did <> 0, UPS_Services.Constants.TAG_ROLLUP_KEY_DID, UPS_Services.Constants.TAG_ROLLUP_KEY_RID);

        SELF.dt_last_seen := (INTEGER) L.dt_last_seen;
        SELF.dt_first_seen := (INTEGER) L.dt_first_seen;

        SELF.fname := L.fname;
        SELF.mname := L.mname;
        SELF.lname := L.lname;
        SELF.name_suffix := L.name_suffix;

        SELF.company_name := '';

        SELF.phone := IF (L.phone = '', L.listed_phone, L.phone);

        SELF.prim_range := L.prim_range;
        SELF.predir := L.predir;
        SELF.prim_name := L.prim_name;
        SELF.suffix := L.suffix;
        SELF.postdir := L.postdir;
        SELF.unit_desig := L.unit_desig;
        SELF.sec_range := L.sec_range;
        SELF.city_name := L.city_name;
        SELF.state := L.st;
        SELF.zip := L.zip;
        SELF.postalcode := '';
        SELF.zip4 := L.zip4;
        SELF.score_name := 0;
        SELF.score_addr := 0;
        // SELF.score_addrStreet := 0;
        // SELF.score_addrCityStZip := 0;
        SELF.score_phone := 0;
        SELF.listing_type := ''; // Used only for canadian data to determine IF business/individual
        SELF.history_flag := ''; // Used only for canadian data
      END;

      resp := CHOOSEN(PROJECT(ind_ranked, indToLayoutTransform(LEFT)), //now deterministic
                      Constant.MAX_SEARCH_RECORDS);
                    
      #IF(UPS_Services.Debug.debug_flag)
      OUTPUT(resp, NAMED('ind_hdr'));
      #END
      RETURN resp;
    END; // PersonSearch.records() function
  END; // PersonSearch module
  

END; // mod_Searches module
