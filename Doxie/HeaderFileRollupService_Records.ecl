IMPORT $, AddressFeedback, AddressFeedback_Services, BusinessCredit_Services, doxie, DriversV2, iesp,
       PhonesFeedback, PhonesFeedback_Services, Suppress, ut, STD, Header;


EXPORT HeaderFileRollupService_Records :=
  MODULE

    SHARED postProcessResults(DATASET(doxie.Layout_Rollup.header_rolled) rolledRecsIn, doxie.IDataAccess mod_access,
                                             boolean do_address_hierarchy) := FUNCTION

      dids := DATASET([{(UNSIGNED6)rolledRecsIn[1].Results[1].did}],doxie.layout_references);
     
//append did to every address record for Address Hierarchy sorting      
      temp_rec := record(doxie.Layout_Rollup.AddrRec)
        unsigned seq := 0; 
        unsigned6 did;
      end; 

      childAddrRecs_legacy  := NORMALIZE(rolledRecsIn[1].Results,LEFT.addrRecs,TRANSFORM(temp_rec,SELF.DID := (integer)LEFT.DID,  SELF:=RIGHT,self := []));
      
// sorted based on addr_ind, best_addr_rank
      childAddrRecs_AHSorted_pre  := Header.Mac_Append_addr_ind(childAddrRecs_legacy, addr_ind, /*src*/, did, prim_range, prim_name, sec_range, city_name
                                                               , st, zip , predir, postdir, suffix, first_seen, last_seen, dt_vendor_first_reported
                                                               , dt_vendor_last_reported /*,isTrusted,*/ /*isFCRA,*/ /*hitQH,*/ /*debug*/);

                                                                                     
     //childAddrRecs_AHsorted := project(childAddrRecs_AHSorted_pre,
      temp_rec overwriteTNT(childAddrRecs_AHSorted_pre l, UNSIGNED cnt) := transform
          SELF.seq := cnt;
          SELF.location_id := l.locid;
          tnt := map( 
                      (unsigned)l.addr_ind = 1 and (unsigned)l.best_addr_rank = 1 => 'B', 
                      (unsigned)l.addr_ind = 1 and (unsigned)l.best_addr_rank > 1 => 'C',
                      l.tnt
                    );
          SELF.tnt := tnt;             
          SELF.isCurrent := tnt in doxie.rollup_limits.TNT_CURRENT_SET;
          SELF := l;
      END;
                                       
      childAddrRecs_AHsorted := project(childAddrRecs_AHSorted_pre, overwriteTNT(LEFT,COUNTER));
     
      childAddrRecs := if(do_address_hierarchy,childAddrRecs_AHsorted,childAddrRecs_legacy);
      
      childPhoneRecs := NORMALIZE(childAddrRecs,LEFT.phoneRecs,TRANSFORM(doxie.Layout_Rollup.PhoneRec,SELF:=RIGHT));
      dedup_phones   := PROJECT(childPhoneRecs,TRANSFORM(doxie.premium_phone.phone_rec,SELF.phone:=LEFT.phone));

      results := PROJECT(rolledRecsIn[1].Results,TRANSFORM(doxie.Layout_Rollup.KeyRec_Seq,
                   childAddrRecsForDid := childAddrRecs(did = (integer) Left.did);
                   // Conditionally re-sort to preserve address hierarchy sort order
                   childAddrRecsForDidSorted := if(do_address_hierarchy,sort(childAddrRecsForDid,seq),childAddrRecsForDid); 
                   SELF.addrRecs :=  project(childAddrRecsForDidSorted, doxie.Layout_Rollup.AddrRec);  
                   SELF.premium_phone_count:=doxie.premium_phone.get_count(dids,dedup_phones,mod_access,TRUE);
                   SELF:=LEFT));

      doxie.Layout_Rollup.header_rolled rolledRecsOut() := TRANSFORM
        SELF.Results := results;
        SELF.Royalty := rolledRecsIn[1].Royalty;
        SELF.householdRecordsAvailable := rolledRecsIn[1].householdRecordsAvailable;
      END;
      
//output(childAddrRecs_legacy,named('legacy_sorted_records_original_tnt'));
//output(childAddrRecs_AHSorted_pre,named('ah_sorted_records_original_tnt'));
//output(childAddrRecs_AHSorted,named('ah_sorted_records_updated_tnt'));

      RETURN DATASET([rolledRecsOut()]);
    END;

    EXPORT fn_get_ta1 (doxie.IDataAccess mod_access, doxie.HeaderFileRollupService_IParam.ta1 mod_ta1, boolean do_address_hierarchy = false):=
      FUNCTION

        //needed for MAC_Apply_DtSeen_Filter
        date_last_seen_value :=  mod_ta1.date_last_seen;
        date_first_seen_value := mod_ta1.date_first_seen;


        // Choose how to search for DIDs -- by DL or in the header
        dlSearch := mod_ta1.DLNumber <> '' AND mod_ta1.DLState <> '';
        DLkey_dids := LIMIT(DriversV2.Key_DL_Number(KEYED(s_dl=mod_ta1.DLNumber),orig_state=STD.Str.ToUpperCase(mod_ta1.DLState),did >0), ut.limits.DEFAULT,SKIP);
        DLraw_dids := IF(dlSearch,PROJECT(DEDUP(SORT(DLkey_dids,did),did),doxie.layout_references_hh));
        DLDids     := PROJECT(DLraw_dids,doxie.layout_references_hh);
        isDLSearch := dlSearch AND EXISTS(DLDids);

        header_dids := if(~mod_ta1.reduced_data,doxie.get_dids(,isDLSearch));
        dids := if(isDLSearch, DLDids, header_dids);

        // Get header records
        Recs := doxie.header_records_byDID(dids,~isDLSearch,~isDLSearch AND mod_ta1.allow_wildcard,,~isDLSearch,,,,,,,isrollup:=TRUE);

        presRecs_ready := PROJECT(Recs, doxie.layout_presentation);

        doxie.MAC_Apply_DtSeen_Filter(presRecs_ready, presRecs_filtered, dt_last_seen, dt_first_seen);
        presRecs := IF(mod_ta1.allow_date_seen AND mod_ta1.date_last_seen != 0 AND mod_ta1.pname != '', presRecs_filtered, presRecs_ready);

        // Rollup header records
        tmpRecs := doxie.rollup_presentation(presRecs, mod_ta1.allow_wildcard);        
        ta1 := postProcessResults(tmpRecs,mod_access,do_address_hierarchy)[1];

      RETURN ta1;
    END; // fn_get_ta1


    EXPORT fn_get_ta2 (DATASET(doxie.layout_rollup.KeyRec_Seq) ta1_results,
                       doxie.IDataAccess mod_access,
                       doxie.HeaderFileRollupService_IParam.ta2 mod_ta2) :=
      FUNCTION
        // ----------------------------------------------------------------------
        // Addr/Phone feedback section
        // ----------------------------------------------------------------------

        doxie.Layout_Rollup.AddrRec_feedback_ext xform_addr(doxie.Layout_Rollup.AddrRec L, UNSIGNED6 ldid) :=
          TRANSFORM
            _phoneRecs:=PROJECT(L.PhoneRecs,TRANSFORM(doxie.Layout_Rollup.PhoneRec_feedback, SELF.feedback := [], SELF := LEFT));
            PhonesFeedback_Services.Mac_Append_Feedback(_phoneRecs
                                                        ,did
                                                        ,Phone
                                                        ,phnRecsWithFeedback
                                                        ,mod_access
                                                        );
            SELF.PhoneRecs        := IF(mod_ta2.Include_PhonesFeedback,phnRecsWithFeedback,_phoneRecs);
            SELF.address_feedback := [];
            SELF.did              := ldid;
            SELF                  := L;
          END;

        sdocfilter := doxie.SourceDocFilter.GetBitmask(mod_ta2.Include_SourceList);

        doxie.Layout_Rollup.KeyRec_feedback xform_final (doxie.layout_rollup.KeyRec_Seq L):=
          TRANSFORM
            _addrRecs := PROJECT(L.AddrRecs,xform_addr(LEFT, (UNSIGNED6) L.did));
            AddressFeedback_Services.MAC_Append_Feedback(_addrRecs,
                                                         addrRecsWithFeedback,
                                                         Address_Feedback);

            filtered_rids     := doxie.rid_cnt.rid_filter(L.rids, sdocfilter);
            SELF.rid_cnt      := doxie.rid_cnt.rid_cnt(filtered_rids);
            SELF.src_cnt      := doxie.rid_cnt.src_cnt(filtered_rids);
            SELF.src_doc_cnt  := doxie.rid_cnt.src_doc_cnt(filtered_rids);
            SELF.rids         := filtered_rids;
            SELF.AddrRecs     := PROJECT(IF(mod_ta2.Include_AddressFeedback, addrRecsWithFeedback, _addrRecs), doxie.Layout_Rollup.AddrRec_feedback);
            SELF.ssn_count    := COUNT(L.ssnRecs);
            SELF.progressive_phones := [];
            SELF              := L;
          END;

        // ----------------------------------------------------------------------

        Suppress.MAC_Suppress(ta1_results, ta1_pulled, mod_access.application_type, Suppress.Constants.LinkTypes.DID, did, '', '', FALSE, '');

        ta1 := PROJECT(ta1_pulled,xform_final(LEFT));

        //apply additional Smart rollup on NameRecs and AddrRecs
        ta1Smart := doxie.fn_SmartHFRS(ta1);

        ta2_preBusinessCredit := IF(mod_ta2.Smart_Rollup, ta1Smart, ta1);

        // Business Credit / SBFE - request is to resort SBFE records to the top of the results list
        ds_ta2_BusinessCredit_atTop := BusinessCredit_Services.Functions.fn_BusinessCreditSorting ( ta2_preBusinessCredit, mod_access, mod_ta2.SeleId, mod_ta2.OrgId, mod_ta2.UltId );

        useBusinessCreditSorting := BusinessCredit_Services.Functions.fn_useBusinessCredit( mod_access.dataPermissionMask, mod_ta2.Include_BusinessCredit );
        ta2 := IF( useBusinessCreditSorting, ds_ta2_BusinessCredit_atTop, ta2_preBusinessCredit );

        RETURN ta2;
    END;


    EXPORT get_progressive_phone ( DATASET(doxie.Layout_Rollup.KeyRec_feedback) in_records,
                                    doxie.iParam.ProgressivePhoneParams progphone_mod = module(doxie.iParam.ProgressivePhoneParams)end):=
      FUNCTION

        PhoneDids := DEDUP(SORT(PROJECT(in_records(did <> ''), TRANSFORM(doxie.layout_references, SELF.did := (UNSIGNED6) LEFT.did)), did, did));

        ds_ProgPhone := doxie.fn_progressivePhone.byDIDonly(PhoneDids,progphone_mod);

        doxie.Layout_Rollup.KeyRec_feedback AppendProgPhone(doxie.Layout_Rollup.KeyRec_feedback inRec, RECORDOF(ds_ProgPhone) PhoneRecs) := TRANSFORM
          SELF.progressive_phones := iesp.transform_progressive_phones(PhoneRecs.phoneinfo,progphone_mod.ReturnPhoneScore, progphone_mod.ScoreModel);
          SELF := inRec;
        END;

        progPhoneRecs := JOIN(in_records,ds_ProgPhone,(INTEGER)LEFT.did=RIGHT.did,
                              AppendProgPhone(LEFT,RIGHT),
                              LEFT OUTER);

        RETURN progPhoneRecs;
    END;


    // Added the following function to allow records from the Doxie.HFRS to be returned
    EXPORT fn_get_personRecords (doxie.IDataAccess mod_access,
                                 doxie.HeaderFileRollupService_IParam.ta1 mod_ta1,
                                 doxie.HeaderFileRollupService_IParam.ta2 mod_ta2):=
      FUNCTION
        ta1 := fn_get_ta1(mod_access, mod_ta1);
        ta2 := fn_get_ta2(ta1.Results, mod_access, mod_ta2);

        RETURN ta2;
      END;


  END;  // Module HeaderFileRollupService_Records
