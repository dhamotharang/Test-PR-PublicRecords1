IMPORT AddressFeedback, AddressFeedback_Services, BusinessCredit_Services, DriversV2,  
       PhonesFeedback, PhonesFeedback_Services, Suppress, ut, iesp, doxie;

EXPORT HeaderFileRollupService_Records := 
  MODULE

		SHARED set_premium_phone_count(DATASET(doxie.Layout_Rollup.header_rolled) rolledRecsIn, STRING DRM) := FUNCTION

			dids := DATASET([{(UNSIGNED6)rolledRecsIn[1].Results[1].did}],doxie.layout_references);
			childAddrRecs  := NORMALIZE(rolledRecsIn[1].Results,LEFT.addrRecs,TRANSFORM(doxie.Layout_Rollup.AddrRec,SELF:=RIGHT));
			childPhoneRecs := NORMALIZE(childAddrRecs,LEFT.phoneRecs,TRANSFORM(doxie.Layout_Rollup.PhoneRec,SELF:=RIGHT));
			dedup_phones   := PROJECT(childPhoneRecs,TRANSFORM(doxie.premium_phone.phone_rec,SELF.phone:=LEFT.phone));

			results := PROJECT(rolledRecsIn[1].Results,TRANSFORM(doxie.Layout_Rollup.KeyRec_Seq,
				SELF.premium_phone_count:=doxie.premium_phone.get_count(dids,dedup_phones,DRM,TRUE,TRUE);
				SELF:=LEFT));

			doxie.Layout_Rollup.header_rolled rolledRecsOut() := TRANSFORM
				SELF.Results := results;
				SELF.Royalty := rolledRecsIn[1].Royalty;
				SELF.householdRecordsAvailable := rolledRecsIn[1].householdRecordsAvailable;
			END;

			RETURN DATASET([rolledRecsOut()]);
		END;

    EXPORT fn_get_ta1_temp ( doxie.HeaderFileRollupService_IParam.ta1_iparams ta1_iparam_mod ):=
      FUNCTION
        doxie.MAC_Header_Field_Declare();
				glbMod := AutoStandardI.GlobalModule();

        // Choose how to search for DIDs -- by DL or in the header 
        dlSearch := ta1_iparam_mod.DLNumber <> '' AND ta1_iparam_mod.DLState <> '';
        DLkey_dids := LIMIT(DriversV2.Key_DL_Number(KEYED(s_dl=ta1_iparam_mod.DLNumber),orig_state=stringlib.StringToUpperCase(ta1_iparam_mod.DLState),did >0), ut.limits.DEFAULT,SKIP);
        DLraw_dids := IF(dlSearch,PROJECT(DEDUP(SORT(DLkey_dids,did),did),doxie.layout_references_hh));
        DLDids     := PROJECT(DLraw_dids,doxie.layout_references_hh);
        isDLSearch := dlSearch AND EXISTS(DLDids);

        header_dids := if(~ta1_iparam_mod.reduced_data,doxie.get_dids(,isDLSearch));
        dids := if(isDLSearch, DLDids, header_dids);

        // Get header records
        Recs := doxie.header_records_byDID(dids,~isDLSearch,~isDLSearch AND ta1_iparam_mod.allow_wildcard,,~isDLSearch,,,,,,,isrollup:=TRUE);

        presRecs_ready := PROJECT(Recs, doxie.layout_presentation);

        doxie.MAC_Apply_DtSeen_Filter(presRecs_ready, presRecs_filtered, dt_last_seen, dt_first_seen); 
        presRecs := IF(ta1_iparam_mod.allow_date_seen AND ta1_iparam_mod.date_last_seen != 0 AND ta1_iparam_mod.pname != '', presRecs_filtered, presRecs_ready);

        // Rollup header records
        tmpRecs := doxie.rollup_presentation(presRecs, ta1_iparam_mod.allow_wildcard);
        ta1_tmp := set_premium_phone_count(tmpRecs,glbMod.dataRestrictionMask)[1];

      RETURN ta1_tmp;
    END; // fn_get_ta1_temp

    
    EXPORT fn_get_ta2 ( DATASET(doxie.layout_rollup.KeyRec_Seq) ta1_tmp_results,doxie.HeaderFileRollupService_IParam.ta2_iparams ta2_iparam_mod ):=
			FUNCTION

        useBusinessCreditSorting := BusinessCredit_Services.Functions.fn_useBusinessCredit( ta2_iparam_mod.dataPermissionMask, ta2_iparam_mod.Include_BusinessCredit );

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
                                                        );
            SELF.PhoneRecs        := IF(ta2_iparam_mod.Include_PhonesFeedback,phnRecsWithFeedback,_phoneRecs);
            SELF.address_feedback := [];
            SELF.did              := ldid;
            SELF                  := L;	
          END;

        sdocfilter := doxie.SourceDocFilter.GetBitmask(ta2_iparam_mod.Include_SourceList);

        doxie.Layout_Rollup.KeyRec_feedback xform_final (doxie.layout_rollup.KeyRec_Seq L):=
          TRANSFORM
            _addrRecs := PROJECT(L.AddrRecs,xform_addr(LEFT, (UNSIGNED6) L.did));																	 
            AddressFeedback_Services.MAC_Append_Feedback(_addrRecs,
                                                         addrRecsWithFeedback,
                                                         Address_Feedback);																						

            filtered_rids 		:= doxie.rid_cnt.rid_filter(L.rids, sdocfilter);	
            SELF.rid_cnt			:= doxie.rid_cnt.rid_cnt(filtered_rids);
            SELF.src_cnt			:= doxie.rid_cnt.src_cnt(filtered_rids);
            SELF.src_doc_cnt	:= doxie.rid_cnt.src_doc_cnt(filtered_rids);
            SELF.rids					:= filtered_rids;
            SELF.AddrRecs			:= PROJECT(IF(ta2_iparam_mod.Include_AddressFeedback, addrRecsWithFeedback, _addrRecs), doxie.Layout_Rollup.AddrRec_feedback);
            SELF.ssn_count    := COUNT(L.ssnRecs);
						SELF.progressive_phones := [];
		        SELF              := L;
          END;

        // ----------------------------------------------------------------------

        Suppress.MAC_Suppress(ta1_tmp_results,ta1_tmp_pulled,ta2_iparam_mod.application_type_val,Suppress.Constants.LinkTypes.DID,did,'','',FALSE,'');
        
        ta1 := PROJECT(ta1_tmp_pulled,xform_final(LEFT));
        
        //apply additional Smart rollup on NameRecs and AddrRecs
        ta1Smart := doxie.fn_SmartHFRS(ta1);
        
        ta2_preBusinessCredit := IF(ta2_iparam_mod.Smart_Rollup, ta1Smart, ta1);
        
        // Business Credit / SBFE - request is to resort SBFE records to the top of the results list
        ds_ta2_BusinessCredit_atTop := BusinessCredit_Services.Functions.fn_BusinessCreditSorting ( ta2_preBusinessCredit, ta2_iparam_mod.SeleId, ta2_iparam_mod.OrgId, ta2_iparam_mod.UltId ); 
         
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
    EXPORT fn_get_personRecords ( doxie.HeaderFileRollupService_IParam.ta1_IParams ta1_Iparam_mod, doxie.HeaderFileRollupService_IParam.ta2_IParams ta2_IParam_mod ):=
      FUNCTION
        ta1_tmp := fn_get_ta1_temp(ta1_iparam_mod);
        ta2     := fn_get_ta2(ta1_tmp.Results, ta2_iparam_mod);

        RETURN ta2;
      END;

      
  END;  // Module HeaderFileRollupService_Records