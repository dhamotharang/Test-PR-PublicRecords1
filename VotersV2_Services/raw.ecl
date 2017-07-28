// This module provides voters data in different formats.
import VotersV2, doxie, suppress, ut, census_data, codes,AutoStandardI;

//IMPORTANT FCRA-NOTE: -- FCRA ISN't USED SO FAR, placeholders are reserved for future needs

EXPORT raw := MODULE

  // Batch - Gets voters' IDs from DIDs (grouped by acctno)
  EXPORT Get_vtids_from_dids_batch (GROUPED DATASET (doxie.layout_references_acctno) in_dids,
                                    boolean IsFCRA = FALSE) := function

    res := JOIN (DEDUP (SORT (in_dids, did), did), VotersV2.key_voters_did,
                 keyed (left.did = right.did),
                 transform (VotersV2_services.layout_vtid, Self.acctno := Left.acctno, Self.vtid := Right.vtid),
                 LIMIT (ut.limits.VOTERS_PER_DID, SKIP));

		RETURN DEDUP (SORT (res, vtid), vtid); //why sort???
	END;
	
  EXPORT Layout_vtid Get_vtids_from_dids (DATASET (Doxie.layout_references) dids) := FUNCTION
    dids_batch := GROUP (SORTED (PROJECT (dids, doxie.layout_references_acctno), acctno), acctno);
    RETURN UNGROUP (Get_vtids_from_dids_batch (dids_batch));
  END;


  // =============================================
  // Returns the voters data as part of the report
  // =============================================
  EXPORT REPORT_VIEW := MODULE

    // Batch - voters by vtids: this is main call - all other methods use this function
    export by_vtid_batch (GROUPED DATASET (VotersV2_Services.layout_vtid) in_vtids,
                          string in_ssn_mask_type = '',
                          boolean IsFCRA = FALSE) := function
      res := VotersV2_Services.GetVotersByID (in_vtids, in_ssn_mask_type);
      return PROJECT (res, layouts.EmbeddedOutput);
    end;	

    // Batch - voters by dids
    export by_did_batch (GROUPED DATASET (doxie.layout_references_acctno) in_dids,
                         string in_ssn_mask_type = '',
                         boolean IsFCRA = FALSE) := function
      return by_vtid_batch (Get_vtids_from_dids_batch (in_dids, IsFCRA), in_ssn_mask_type, IsFCRA);
    end;


    // Returns voters by VTIDs
    export by_vtid (DATASET (VotersV2_services.layout_vtid) in_vtids,
		                string in_ssn_mask_type = '') := function
		  return UNGROUP (by_vtid_batch (GROUP (SORTED (in_vtids, acctno), acctno),in_ssn_mask_type));
    end;
	
    // Returns voters by DIDs
    export by_did (DATASET (doxie.layout_references) in_dids,
                   string in_ssn_mask_type = '',
                   boolean IsFCRA = FALSE) := function

      ds_batch := GROUP (SORTED (PROJECT (in_dids, doxie.layout_references_acctno), acctno), acctno);
      return UNGROUP (by_did_batch (ds_batch, in_ssn_mask_type, IsFCRA));
    end;
	END;

	
  // ======================================================================
  // Returns the voters data in the moxie view
  // ======================================================================
  EXPORT MOXIE_VIEW := MODULE

    //here we use new data and return it in the old format (no child datasets)
    export by_vtid (DATASET (VotersV2_services.layout_vtid) in_vtids,
                    string in_ssn_mask_type = '',
                    boolean IsFCRA = false) := function

      // Get general info
      ds_voters := JOIN (in_vtids, VotersV2.Key_Voters_VTID,
                         keyed (Left.vtid = Right.vtid),
                         transform (VotersV2.Layouts_Voters.Layout_Voters_base, SELF := Right),
                         //there can be more records per vtid than by did, but this constant is set to a safe threshhold
                         LIMIT (ut.limits.VOTERS_PER_DID, SKIP));

      // masking, pulling
			appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
			Suppress.MAC_Suppress(ds_voters,ds_pull_1,appType,Suppress.Constants.LinkTypes.DID,did);
			Suppress.MAC_Suppress(ds_pull_1,ds_pull_2,appType,Suppress.Constants.LinkTypes.SSN,ssn);

      doxie.MAC_PruneOldSSNs (ds_pull_2, ds_prunned, ssn, did);		
			Suppress.MAC_Mask(ds_prunned, ds_mskd, ssn, null, true, false, maskVal:=in_ssn_mask_type);

      srt := sort (ds_mskd, RECORD); // sorting is better after pulling
     
      // place into the old layout until we start using new layout for all customers (so far it is used only here)
      ds_old_format := GetVotersInOldFormat (srt);

      // mapping
      codes.mac_map_gender (ds_old_format, gender, gender_mapped, ds_map_1);
      codes.mac_map_race   (ds_map_1, race, race_mapped, ds_map_2) // it's in the key, actually, with blank=unknown
      codes.mac_map_state  (ds_map_2, source_state, source_state_mapped, ds_map_3);
      census_data.MAC_Fips2County_Keyed (ds_map_3, st, county, county_name, ds_map_4);

      return ds_map_4;
		end;

	  // by did
    export by_did (dataset(doxie.layout_references) in_dids,
                   string in_ssn_mask_type = '',
                   boolean IsFCRA = FALSE) := function
      return by_vtid (Get_vtids_from_dids (in_dids), in_ssn_mask_type, IsFCRA);
    end;
	END;


  // ==========================================================================
  // Returns the voters data in search view 
  // ==========================================================================
	EXPORT SEARCH_VIEW := MODULE
    //NB: FCRA rules, probably, are not applied to search; also there's no batch

    // Returns voters by VTIDs
    export by_vtid (DATASET (VotersV2_services.layout_vtid) in_vtids,
		                string in_ssn_mask_type = '') := function

      vtids_grp := GROUP (SORTED (in_vtids, acctno), acctno);
      res := UNGROUP (VotersV2_Services.GetVotersByID (vtids_grp, in_ssn_mask_type));
      return PROJECT (res, layouts.SearchOutput);
    end;
	END;

	
  // ================================================================
  // Returns the voters data in the stand-alone source or report view 
  // ================================================================

  //TODO: check if batch is needed
	EXPORT SOURCE_VIEW := MODULE
    // by vtid
		export by_vtid (dataset(VotersV2_services.layout_vtid) in_vtids,
		                string in_ssn_mask_type = '',
                    boolean IsFCRA = FALSE,
										string32 appType) := function

      // have to dedup in case of invalid input; grouping is formal (unless batch)
      ds_grp := GROUP (SORTED (DEDUP (in_vtids, ALL), acctno), acctno);
//      ds_grp := GROUP (SORTED (in_vtids, acctno), acctno); for deployment in SR < SR6

		  ds_voters := VotersV2_services.GetVotersSourceByID (ds_grp, in_ssn_mask_type,,appType);
      return UNGROUP (ds_voters);
		end;

	  // by did
    export by_did (dataset(doxie.layout_references) in_dids,
                   string in_ssn_mask_type = '',
                   boolean IsFCRA = FALSE,
									 string32 appType) := function
      return by_vtid (Get_vtids_from_dids (in_dids), in_ssn_mask_type, IsFCRA, AppType);
    end;
	END;

END;