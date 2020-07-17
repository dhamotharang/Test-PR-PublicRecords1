IMPORT BIPV2, AutoStandardI, TopBusiness_Services, MDR, STD, Doxie;
EXPORT fn_BIPLookup( DATASET(BIPV2.IDfunctions.rec_SearchInput) ds_Format2SearchInput,
                        AutoStandardI.DataRestrictionI.params in_mod2
                      ) := FUNCTION
  
    
  mod_access := MODULE (doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule ()))
    EXPORT UNSIGNED1 glb := in_mod2.glbPurpose;
    EXPORT UNSIGNED1 dppa := in_mod2.dppapurpose;
    EXPORT STRING DataRestrictionMask := in_mod2.DataRestrictionMask;
    EXPORT BOOLEAN show_minors := in_mod2.IncludeMinors;
  END;
  
  ds_Format2SearchInput_Hsort := PROJECT(ds_Format2SearchInput,
    TRANSFORM(BIPV2.IDfunctions.rec_SearchInput,
      SELF.hsort := TRUE,
      SELF := LEFT )) ;
  
  ds_InfoProxIdNonRestrictedWithD := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(ds_Format2SearchInput_Hsort).SearchKeyData(mod_access);
  ds_InfoProxIdNonRestricted := ds_InfoProxIdNonRestrictedWithD(source <> MDR.SourceTools.src_Dunn_Bradstreet);
     
  TopBusiness_Services.functions.MAC_IsRestricted(ds_InfoProxIdNonRestricted,
                                 ds_ProxIdRestricted,
                                 source, // field name
                                 vl_id, // field name
                                 in_mod2,
                                 FALSE, //in_options.lnBranded,
                                 FALSE, // //in_options.internal_testing, default to FALSE for internal_testing
                                 dt_first_seen // this is field name only no value
                               );
                                                      
  topResults := DEDUP(SORT(ds_ProxIdRestricted,ultid, orgid, seleid, proxid,powid,-proxweight,-record_score,-dt_last_seen,RECORD),
                              ultid, orgid, seleid, proxid,powid);
 
    
  status_coded := bipv2.key_bh_linking_ids.kFetch2(
    PROJECT(topResults,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2,SELF := LEFT)),
    BIPV2.IDconstants.Fetch_Level_PowID, //The lowest level you'd like to pay attention to.
    0, //ScoreThreshold
    PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt),
    5, //JoinLimit
    TRUE, //dnbFullRemove
    , , ,
    mod_access); //doxie.IDataAccess mod_access
  
  topResults_with_status :=
    JOIN(topResults,status_coded,
      LEFT.ultid = RIGHT.ultid AND
      LEFT.orgid = RIGHT.orgid AND
      LEFT.seleid = RIGHT.seleid AND
      LEFT.proxid = RIGHT.proxid AND
      LEFT.powid = RIGHT.powid,
      TRANSFORM(UPS_Services.layouts.RecBipRecordOut2,
        SELF := LEFT , SELF := RIGHT),
      LEFT OUTER, KEEP(1),LIMIT(0));
  
  //sort by -proxweight to bubble top score within a proxid group to the top again.
  tmpTopResultsScored := PROJECT(SORT(topResults_with_status,-proxweight,-record_score, -dt_last_seen), UPS_Services.layouts.RecBipRecordOut2);
  
  RETURN tmpTopResultsScored;
  END;
