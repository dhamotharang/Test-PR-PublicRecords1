IMPORT doxie,doxie_cbrs,suppress,watercraft,ut, fcra,FFD;

EXPORT WatercraftV2_raw := MODULE

  //*******
  //******* Only join bdids to the master file because all bdids should be there
  //*******
  SHARED outrec := watercraftV2_services.Layouts.search_watercraftkey;
  
  EXPORT get_watercraftkeys_from_bdids(DATASET(doxie_cbrs.layout_references) in_bdids) := FUNCTION
    key := watercraft.Key_watercraft_Bdid;

    res := JOIN(DEDUP(SORT(in_bdids,bdid),bdid),key,
      KEYED(LEFT.bdid = RIGHT.L_bdid),
      TRANSFORM(outrec,
                SELF := RIGHT),
      KEEP(ut.limits.WATERCRAFT_PER_BDID), LIMIT(0));

    ded := DEDUP(SORT(res,watercraft_key,sequence_key,state_origin),watercraft_key,sequence_key,state_origin);
    RETURN ded;
  END;


  EXPORT get_watercraftkeys_from_dids(DATASET(doxie.layout_references) in_dids,
                                     BOOLEAN IsFCRA = FALSE) :=FUNCTION
    key := watercraft.key_watercraft_did (IsFCRA);
    res := JOIN(DEDUP(SORT(in_dids,did),did),key,
      KEYED(LEFT.did = RIGHT.l_did),
      TRANSFORM(outrec,
        SELF.subject_did := RIGHT.l_did,
        SELF := RIGHT),
      KEEP(ut.limits.WATERCRAFT_PER_DID), LIMIT(0));
    ded :=DEDUP(SORT(res,watercraft_key,sequence_key,state_origin),watercraft_key,sequence_key,state_origin);
    RETURN ded;
  END;

  EXPORT get_watercraftkeys_from_hullnum(DATASET(WatercraftV2_services.Layouts.search_hullnum) in_hullnum) :=FUNCTION
    key :=watercraft.key_watercraft_hullnum;
    res :=JOIN(in_hullnum,key,
      KEYED(LEFT.hull_num =RIGHT.hull_number),
      TRANSFORM(outrec,
                SELF:=RIGHT),
      KEEP(ut.limits.WATERCRAFT_PER_HULL), LIMIT(0));
    RETURN (DEDUP(SORT(res,watercraft_key,sequence_key,state_origin),watercraft_key,sequence_key,state_origin));
  END;

  EXPORT get_watercraftkeys_from_offnum(DATASET(WatercraftV2_services.Layouts.search_offnum) in_offnum) :=FUNCTION
    key :=watercraft.key_watercraft_offnum;
    res :=JOIN(in_offnum,key,
      KEYED(LEFT.off_num =RIGHT.official_number),
      TRANSFORM(outrec,
                SELF:=RIGHT),
      KEEP(ut.limits.WATERCRAFT_PER_OFFNUM), LIMIT(0));
    RETURN (DEDUP(SORT(res,watercraft_key,sequence_key,state_origin),watercraft_key,sequence_key,state_origin));
  END;


  EXPORT get_watercraftkeys_from_vesselname(DATASET(WatercraftV2_services.layouts.search_vesselname) in_vesselname) :=FUNCTION
    key :=watercraft.key_watercraft_vslnam;
    res :=JOIN(in_vesselname,key,
      KEYED(LEFT.vessel_name =RIGHT.vessel_name[1..LENGTH(TRIM(LEFT.vessel_name))]),
      TRANSFORM(outrec,
                SELF:=RIGHT),
      KEEP(ut.limits.WATERCRAFT_PER_NAME), LIMIT(0));
    RETURN (DEDUP(SORT(res,watercraft_key,sequence_key,state_origin),watercraft_key,sequence_key,state_origin));
  END;

    
  EXPORT report_view := MODULE
  

    EXPORT by_watercraftkey (
      DATASET(outrec) in_watercraftkeys,
      STRING in_ssn_mask_type = '',
      BOOLEAN isReport = FALSE,
      BOOLEAN IsFCRA = FALSE,
      DATASET (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
      BOOLEAN include_non_regulated_sources = FALSE,
      DATASET(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
      INTEGER8 inFFDOptionsMask = 0
      ):= FUNCTION
                            
      RETURN PROJECT(watercraftV2_services.get_watercraft(in_watercraftkeys,in_ssn_mask_type,IsFCRA,
                                                          flagfile, include_non_regulated_sources,
                                                          slim_pc_recs, inFFDOptionsMask).report(isReport),
                     watercraftV2_Services.layouts.report_out);
    END;
    
    
    EXPORT by_bdid(
      DATASET(doxie_cbrs.layout_references) in_bdids,
      STRING in_ssn_mask_type = '',
      BOOLEAN include_non_regulated_sources = FALSE
      ) := FUNCTION
      watercraft_keys := get_watercraftkeys_from_bdids(in_bdids);
      RETURN by_watercraftkey(watercraft_keys,in_ssn_mask_type,,,,include_non_regulated_sources);
    END;

    EXPORT by_did (
      DATASET(doxie.layout_references) in_dids,
      STRING in_ssn_mask_type = '',
      BOOLEAN isReport = FALSE,
      BOOLEAN IsFCRA = FALSE,
      DATASET (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
      UNSIGNED1 non_subject_suppression = 1,
      BOOLEAN include_non_regulated_sources = FALSE,
      DATASET(FFD.Layouts.PersonContextBatchSlim ) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
      INTEGER8 inFFDOptionsMask = 0
      ) := FUNCTION
                    
      keyes := get_watercraftkeys_from_dids(in_dids,IsFCRA);
      recs := by_watercraftkey(keyes,in_ssn_mask_type,isReport,IsFCRA, flagfile,include_non_regulated_sources,slim_pc_recs,inFFDOptionsMask);
      
      //Handle non-subject found records
      WatercraftV2_Services.Layouts.report_out xformNonSubject(watercraftV2_Services.layouts.report_out L) := TRANSFORM
        non_bus_owners := L.owners(company_name = '' OR did <> '');
        bus_owners := L.owners(~(company_name = '' OR did <> ''));
        owners_supp := PROJECT(JOIN(non_bus_owners, in_dids,
                                    (INTEGER)LEFT.did = RIGHT.did,
                                    TRANSFORM(LEFT), KEEP(1)) + bus_owners,
                               TRANSFORM(WatercraftV2_Services.Layouts.owner_report_rec,
                                         SELF.orig_name := '',
                                         SELF := LEFT)); //only KEEP the subjects that have a DID in incoming in_dids OR are a company
        
        owners_returnNameOnly := JOIN(L.owners, in_dids,
                                      (INTEGER)LEFT.did = RIGHT.did,
                                      TRANSFORM(WatercraftV2_Services.Layouts.owner_report_rec,
                                        SELF.fname := LEFT.fname,
                                        SELF.mname := LEFT.mname,
                                        SELF.lname := LEFT.lname,
                                        SELF.name_suffix := LEFT.name_suffix,
                                        SELF := []),LEFT ONLY);
                                        
        owners_restricted := PROJECT(owners_returnNameOnly,
                                  TRANSFORM(WatercraftV2_Services.Layouts.owner_report_rec,
                                            SELF.lname := FCRA.Constants.FCRA_Restricted,
                                            SELF := []));
        
        SELF.owners := MAP(non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription => owners_supp + owners_restricted,
                           non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnNameOnly => owners_supp + owners_returnNameOnly,
                           non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnBlank => owners_supp,
                           isFCRA => owners_restricted, //if we have isFCRA and we didn't specify 2 or 3 let's do an override of co-owners.
                           //The goal here is not to force the isFCRA = true to enter a non_subject_suppression...
                           //if we want to allow non_subject_suppression = 1 with isFCRA = true then this will need to be changed
                           L.owners);
        SELF := L;
      END;
      filter := PROJECT(recs, xformNonSubject(LEFT));
                     
      res := IF(isFCRA OR non_subject_suppression <> Suppress.Constants.NonSubjectSuppression.doNothing, filter, recs);

      RETURN res;
    END;
    
  END;

END;
