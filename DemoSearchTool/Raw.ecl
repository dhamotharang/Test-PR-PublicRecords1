IMPORT BIPV2, BIPV2_Best, Business_Header, IESP, DemoSearchTool, 
       Infutor, Watchdog;

EXPORT Raw := 
  MODULE

    /* ================================================================ *
     *               Get Legacy Business Records                        *
     *      hit the legacy best key and get the BII for output          *      
     * ================================================================ */
    EXPORT fn_getLegacyOnlyRecs(DATASET(DemoSearchTool.Layouts.Ids_rec) ds_BizIds) := 
      FUNCTION
                  
        ds_BizRecs := 
          JOIN(ds_bizIds, Business_Header.Key_BH_Best,  // prte::key::business_header::20140206a::best::filepos.data
            KEYED(LEFT.BDID = RIGHT.BDID),
            TRANSFORM(DemoSearchTool.Layouts.finalPlusSorting_rec,
                      SELF.PersonInformation := [],  
                      SELF.BusinessInformation := 
                        PROJECT(RIGHT, 
                                DemoSearchTool.Transforms.xfm_intoBusinessLayout_bdid(LEFT)),
                      SELF := LEFT,  // bdid
                      SELF := []
                     ),
            LIMIT(0),
            KEEP(DemoSearchTool.Constants.BEST_JOIN_LIMIT));    
            
        RETURN ds_bizRecs;
        
      END; // end fn_getBusinessLegacyRecs


    /* =============================================================== *
     *               Get BipIds Business Records                       *
     *   hit the LinkIds kfetch2 best key and get the BII for output   *      
     * =============================================================== */
    EXPORT fn_getBipOnlyRecs(DATASET(DemoSearchTool.Layouts.Ids_rec) ds_BizIds) := 
      FUNCTION
        
        ds_bizRecs_l_xlink_ids2 := 
            PROJECT(ds_BizIds, 
	            TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2, 
                        SELF.SeleId := LEFT.SeleId,
                        SELF.OrgId  := LEFT.OrgId,
                        SELF.UltId  := LEFT.UltId,
                        SELF        := [] 
                       )); 
                        
        ds_BipIdsRecsRaw := 
          BIPV2_Best.Key_LinkIds.kfetch2(ds_bizRecs_l_xlink_ids2,  // prte::key::bipv2_best::20160725::linkids
                                         BIPV2.IDconstants.Fetch_Level_SELEID,,,
                                         DemoSearchTool.Constants.BIZ_HEADER_KFETCH_MAX_LIMIT );
        
        ds_BipRecs_raw := 
          PROJECT(ds_BipIdsRecsRaw,
            TRANSFORM(DemoSearchTool.Layouts.finalPlusSorting_rec,
                      SELF.PersonInformation   := [],  
                      SELF.BusinessInformation := 
                        PROJECT(LEFT,
                                DemoSearchTool.Transforms.xfm_intoBusinessLayout_BipIds(LEFT)),
                      SELF := LEFT,  // SELE, ORG & ULT Ids
                      SELF := []
                     ));
        
        // deduping because the key considers all LinkIds and this
        // service is only using the top three.
        ds_BipbizRecs := DEDUP(SORT(ds_bipRecs_raw,RECORD),ALL); 
        
        RETURN ds_BipBizRecs;
        
      END;  // end fn_getBusinessBipIdRecs

    
    /* ================================================================ *
     *               Get DTC only Records                               *
     *        NOTE: Direct To Consumer does not have FCRA               *
     *      hit the DTC best key and get the PII for output             *      
     * ================================================================ */
    EXPORT fn_getDtcOnlyRecs ( DATASET(DemoSearchTool.Layouts.Ids_rec) ds_DtcIds ) := 
      FUNCTION
        
        ds_DtcRecs :=
          JOIN(ds_DtcIds, Infutor.key_infutor_best_did,
               KEYED(LEFT.DID = RIGHT.DID),
               TRANSFORM(DemoSearchTool.Layouts.finalPlusSorting_rec,
                         SELF.PersonInformation := PROJECT(RIGHT, DemoSearchTool.Transforms.xfm_intoDtcLayout(LEFT) ),  
                         SELF.BusinessInformation := [],
                         SELF.UniqueId := LEFT.did, 
                         SELF          := [] // bdid, sele, org, ult
                        ),
               LIMIT(0),
               KEEP(DemoSearchTool.Constants.BEST_JOIN_LIMIT));        
        
        RETURN ds_DtcRecs; 
        
      END; // end fn_getDtcOnlyRecs


    /* ================================================================ *
     *               Get Person only Records                            *
     *      hit the Person best key and get the PII for output          *      
     * ================================================================ */
    EXPORT fn_getPersonOnlyRecs(DATASET(DemoSearchTool.Layouts.Ids_rec) ds_persIds) := 
      FUNCTION
        
        ds_PerRecs := 
          JOIN(ds_persIds, Watchdog.Key_Prep_Watchdog_GLB(),
               KEYED(LEFT.DID = RIGHT.DID),
               TRANSFORM(DemoSearchTool.Layouts.finalPlusSorting_rec,
                         SELF.PersonInformation := PROJECT(RIGHT, DemoSearchTool.Transforms.xfm_intoPersonLayout(LEFT) ),  
                         SELF.UniqueId := LEFT.did,
                         SELF := [] // biz info, bdid, sele, org & ult Ids.
                        ),
               LIMIT(0),
               KEEP(DemoSearchTool.Constants.BEST_JOIN_LIMIT));  
                        
        RETURN ds_PerRecs; 
        
      END; // end fn_getPersonRecs
      

    /* ================================================================ *
     *         Get Person Combined - Person & Legacy Biz Records        *
     *    hit the Person best key and get the PII for output then       *      
     *    join with the legacy best key and get the BII for output      *      
     * ================================================================ */
    EXPORT fn_getCombinedLegacyRecs ( DATASET(DemoSearchTool.Layouts.Ids_rec) ds_combinedIds ) := 
      FUNCTION
        
        ds_PerRecs := 
          JOIN(ds_combinedIds, Watchdog.Key_Prep_Watchdog_GLB(),
            KEYED(LEFT.DID = RIGHT.DID),     
            TRANSFORM(DemoSearchTool.Layouts.SearchToolSrcRecPlusBdidForCombOutput_rec,
                      SELF.PersonInformation := PROJECT(RIGHT, DemoSearchTool.Transforms.xfm_intoPersonLayout(LEFT) ),  
                      SELF.BusinessInformation := [],
                      SELF := LEFT // preserve the bdid to glean BII in next join
                     ),
             LIMIT(0),
             KEEP(DemoSearchTool.Constants.BEST_JOIN_LIMIT));  

        // Add business header records using BDIDs
        ds_combBdidRecs := 
          JOIN(ds_PerRecs, Business_Header.Key_BH_Best,  // prte::key::business_header::20140206a::best::filepos.data
            KEYED(LEFT.BDID = RIGHT.BDID),
            TRANSFORM(DemoSearchTool.Layouts.finalPlusSorting_rec,
                      SELF.PersonInformation   := LEFT.PersonInformation,  
                      SELF.BusinessInformation := PROJECT(RIGHT, DemoSearchTool.Transforms.xfm_intoBusinessLayout_BDID(LEFT)),
                      SELF.UniqueId            := (UNSIGNED6)LEFT.PersonInformation.UniqueId,
                      SELF                     := RIGHT, // bdid
                      SELF                     := []
                     ),
            LIMIT(0),
            KEEP(DemoSearchTool.Constants.BEST_JOIN_LIMIT));        

        RETURN ds_combBdidRecs;

      END; // end fn_getCombinedLegacyRecs
      
      
    /* ================================================================ *
     *          Get Person Combined - Person & BipId Biz Records        *
     *      hit the Person best key and get the PII for output then     *      
     *     join with the LinkIds best key and get the BII for output    *      
     * ================================================================ */
    EXPORT fn_getCombinedBipRecs(DATASET(DemoSearchTool.Layouts.Ids_rec) ds_combinedIds) := 
      FUNCTION
        
        ds_PerRecs := 
          JOIN(ds_combinedIds, Watchdog.Key_Prep_Watchdog_GLB(),
            KEYED(LEFT.DID = RIGHT.DID),
            TRANSFORM(DemoSearchTool.Layouts.SearchToolSrcRecPlusBipidsForCombOutput_rec,
                      SELF.PersonInformation := PROJECT(RIGHT, DemoSearchTool.Transforms.xfm_intoPersonLayout(LEFT) ),  
                      SELF.BusinessInformation := [],
                      SELF := LEFT // preserve the SELE, ORG & ULT Ids to glean BII in next kfetch2
                     ),
            LIMIT(0),
            KEEP(DemoSearchTool.Constants.BEST_JOIN_LIMIT));  
                        
        // Add business header records using LinkIds
        ds_bizRecs_l_xlink_ids2 := 
            PROJECT(ds_combinedIds, 
	            TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2, 
                        SELF.SeleId := LEFT.SeleId,
                        SELF.OrgId  := LEFT.OrgId,
                        SELF.UltId  := LEFT.UltId,
                        SELF        := [] )); 
                        
        ds_BipIdsRecsRaw := 
          BIPV2_Best.Key_LinkIds.kfetch2(ds_bizRecs_l_xlink_ids2,  // prte::key::bipv2_best::20160725::linkids
                                         BIPV2.IDconstants.Fetch_Level_SELEID,,,
                                         DemoSearchTool.Constants.BIZ_HEADER_KFETCH_MAX_LIMIT);
                      
       ds_CombBipIdsRecs := 
          JOIN(ds_PerRecs,ds_BipIdsRecsRaw, 
               BIPV2.IDMacros.mac_JoinTop3Linkids(),
               TRANSFORM( DemoSearchTool.Layouts.finalPlusSorting_rec,
                          SELF.PersonInformation   := LEFT.PersonInformation,  
                          SELF.BusinessInformation := PROJECT(RIGHT,DemoSearchTool.Transforms.xfm_intoBusinessLayout_BipIds(LEFT)),
                          SELF.UniqueId            := (UNSIGNED6)LEFT.PersonInformation.UniqueId,  
                          SELF.BDID                := 0,
                          SELF                     := RIGHT // sele, org, ult
                        ),
               LIMIT(0),
               KEEP(DemoSearchTool.Constants.BEST_JOIN_LIMIT));  
         
        RETURN ds_CombBipIdsRecs;
        
      END;  // end fn_getCombinedBipIdRecs

      
    /* ================================================================ *
     *     Get multiple businesses at an address Records                *
     * The PRTE - Business_Address key is different than the others in  *
     * that is contains not only the needed keyed field, but also all   *
     * of the fields needed for the output.  The key is hit, records    *
     * normalized based on BDID/SELEID and the output is transformed.   *
     * ================================================================ */
    EXPORT fn_getMultiBizAtAddressRecs(DATASET(DemoSearchTool.Layouts.SearchInput_rec) ds_in, 
                                       BOOLEAN SearchLegacyKeys, BOOLEAN SearchBipKeys) := 
      FUNCTION

        ds_multiBdidAtAddrRecs_keyLayout :=
          JOIN(ds_in, DemoSearchTool.Keys.Business_Address,
               KEYED(LEFT.Biz_NumMultiBusinessesCount <= RIGHT.BDID_cnt),
               TRANSFORM(RIGHT),
               LIMIT(0),
               KEEP(DemoSearchTool.Constants.JOIN_LIMIT));
        
        ds_multiBipIdsAtAddrRecs_keyLayout :=
          JOIN(ds_in, DemoSearchTool.Keys.Business_Address,
               KEYED(WILD(RIGHT.BDID_cnt) AND
                     LEFT.Biz_NumMultiBusinessesCount <= RIGHT.SELEID_cnt),
               TRANSFORM(RIGHT),
               LIMIT(0),
               KEEP(DemoSearchTool.Constants.JOIN_LIMIT));
          
        iesp.DemoSearchTool.t_DemoSearchToolSearchRecord 
          xfm_normMultiBizBdids(RECORDOF(DemoSearchTool.Keys.Business_Address)rw_in, INTEGER C ) :=
          TRANSFORM
            SELF.PersonInformation := [];  
            SELF.BusinessInformation.BusinessId := (STRING)rw_in.Businesses_BDID[C].bdid;
            SELF.BusinessInformation.CompanyName := rw_in.Businesses_BDID[C].company_name;  
            SELF.BusinessInformation.Address := iesp.ECL2ESP.SetAddress((STRING28)rw_in.prim_name, 
                                                    (STRING10)rw_in.prim_range, 
                                                    (STRING2)rw_in.Businesses_BDID[C].predir, 
                                                    (STRING2)rw_in.Businesses_BDID[C].postdir,
                                                    (STRING4)rw_in.Businesses_BDID[C].addr_suffix, 
                                                    (STRING10)rw_in.Businesses_BDID[C].unit_desig, 
                                                    (STRING8)rw_in.sec_range, 
                                                    (STRING25)rw_in.Businesses_BDID[C].city,
                                                    (STRING2)rw_in.Businesses_BDID[C].state, 
                                                    (STRING5)rw_in.zip, 
                                                    (STRING4)rw_in.Businesses_BDID[C].zip4,'');
            SELF.BusinessInformation.PhoneNumber := (STRING10)rw_in.Businesses_BDID[C].phone;
            SELF.BusinessInformation.FEIN := (STRING9)rw_in.Businesses_BDID[C].FEIN;
            SELF := []; // no BipIds for BDID Business Recs 
          END;

        ds_BdidRecs_finalLayout := 
          NORMALIZE(ds_multiBdidAtAddrRecs_keyLayout, 
                    COUNT(LEFT.Businesses_BDID), 
                    xfm_normMultiBizBdids(LEFT,COUNTER)); 
        
        cnt_BdidRecs := COUNT(ds_BdidRecs_finalLayout);

        iesp.DemoSearchTool.t_DemoSearchToolSearchRecord  
            xfm_normMultiBizBipIds(RECORDOF(DemoSearchTool.Keys.Business_Address)rw_in, INTEGER C ) :=
          TRANSFORM
            SELF.PersonInformation := [];  
            SELF.BusinessInformation.BusinessId := (STRING)rw_in.Businesses_SELEID[C].bdid;
            SELF.BusinessInformation.CompanyName := rw_in.Businesses_SELEID[C].company_name;  
            SELF.BusinessInformation.Address := iesp.ECL2ESP.SetAddress((STRING28)rw_in.prim_name, 
                                                                        (STRING10)rw_in.prim_range, 
                                                                        (STRING2)rw_in.Businesses_SELEID[C].predir, 
                                                                        (STRING2)rw_in.Businesses_SELEID[C].postdir,
                                                                        (STRING4)rw_in.Businesses_SELEID[C].addr_suffix, 
                                                                        (STRING10)rw_in.Businesses_SELEID[C].unit_desig, 
                                                                        (STRING8)rw_in.sec_range, 
                                                                        (STRING25)rw_in.Businesses_SELEID[C].city,
                                                                        (STRING2)rw_in.Businesses_SELEID[C].state, 
                                                                        (STRING5)rw_in.zip, 
                                                                        (STRING4)rw_in.Businesses_SELEID[C].zip4,'');
            SELF.BusinessInformation.PhoneNumber := (STRING10)rw_in.Businesses_SELEID[C].phone;
            SELF.BusinessInformation.FEIN := (STRING9)rw_in.Businesses_SELEID[C].FEIN;
            SELF.BusinessInformation.BusinessIds.SeleId := rw_in.Businesses_SELEID[C].SeleId;
            SELF.BusinessInformation.BusinessIds.OrgId  := rw_in.Businesses_SELEID[C].OrgId;
            SELF.BusinessInformation.BusinessIds.UltId  := rw_in.Businesses_SELEID[C].UltId;  
            SELF := [];  // DotId, EmpId, PowId & ProxId are not in the key
          END;

        ds_BipRecs_finalLayout := 
          NORMALIZE(ds_multiBipIdsAtAddrRecs_keyLayout, 
                    COUNT(LEFT.Businesses_SELEID), 
                    xfm_normMultiBizBipIds(LEFT,COUNTER)); 
 
        cnt_BipRecs := COUNT(ds_BipRecs_finalLayout);
        
        // Combine Legacy and Bip Recs 
        ds_MultiBizAtAddrRecs := 
          MAP( SearchLegacyKeys AND
               NOT SearchBipKeys                                           =>
                       CHOOSEN(ds_BdidRecs_finalLayout,
                               DemoSearchTool.Constants.MAX_RECS_RETURNED),
               SearchBipKeys AND
               NOT SearchLegacyKeys                                        =>
                       CHOOSEN(ds_BipRecs_finalLayout,
                               DemoSearchTool.Constants.MAX_RECS_RETURNED),
               cnt_BdidRecs <= DemoSearchTool.Constants.HALF_MAX_RECS AND
               cnt_BipRecs  <= DemoSearchTool.Constants.HALF_MAX_RECS      =>
                       (ds_BdidRecs_finalLayout + ds_BipRecs_finalLayout), 
               cnt_BdidRecs >  DemoSearchTool.Constants.HALF_MAX_RECS AND
               cnt_BipRecs  <= DemoSearchTool.Constants.HALF_MAX_RECS      =>
                       (CHOOSEN(ds_BdidRecs_finalLayout,
                                (DemoSearchTool.Constants.MAX_RECS_RETURNED - cnt_BipRecs)) + 
                        ds_BipRecs_finalLayout),           
               cnt_BdidRecs <= DemoSearchTool.Constants.HALF_MAX_RECS AND
               cnt_BipRecs   > DemoSearchTool.Constants.HALF_MAX_RECS      =>
                       (ds_BdidRecs_finalLayout +
                        CHOOSEN(ds_BipRecs_finalLayout,          
                               (DemoSearchTool.Constants.MAX_RECS_RETURNED - cnt_BdidRecs))), 
                       // Default legacy & bip rec count > 50
                       (CHOOSEN(ds_BdidRecs_finalLayout,
                               (DemoSearchTool.Constants.HALF_MAX_RECS)) + 
                        CHOOSEN(ds_BipRecs_finalLayout,          
                               (DemoSearchTool.Constants.HALF_MAX_RECS))) 
              );     

        RETURN ds_multiBizAtAddrRecs;
      END;  // end fn_getMultiBizAtAddressRecs

    END;  // END Module