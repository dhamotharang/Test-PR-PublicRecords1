IMPORT BIPV2, DemoSearchTool;

EXPORT SearchIds := 
  MODULE

    // NOTE: Using a KEEP and not limit skip because this is an 
    //       internal only search tool and Meishawn/product doesn't 
    //       want the tool to ever return a "too many results" error.
    //       She was advised that when the number of records becomes
    //       larger than 10000, the results will not be repeatable.
    
    // NOTE: The People key (DemoSearchTool.Keys.people) and the Business 
    //       Legacy key (DemoSearchTool.Keys.businesses_bdid) will contain 
    //       both FCRA & nonFCRA data/records.  This is ONLY acceptable because 
    //       this is the PRTE environment.  Each of the respective keys will 
    //       have one record for FCRA and one for nonFCRA for each entity type 
    //       (Two records for each DID/BDID).  Additionally, an â€œFCRAâ€ keyed 
    //       field was added as the first keyed field; which would eliminate 
    //       half the records immediately and help with performance.  
    //       This adopted change deviated from the initial proposal to add just 
    //       the FCRA compliant counts to the nonFCRA key (FCRA_bankruptcy_count, 
    //       FCRA_criminal_count, etc.).  However, going with the adopted changes 
    //       eliminated data fabrications concern that the counts from the FCRA 
    //       header files for the nonFCRA compliant fields/counts (such as 
    //       properties) could be different than the nonFCRA header file counts.  
    //       Implementing this approach also allows the Demo Search Tool to handle 
    //       both FCRA and nonFCRA from one service by having an isFCRA option 
    //       included as an input parameter at the userâ€™s request. 
    
    EXPORT fn_getLegacyOnlyIds(DATASET(DemoSearchTool.Layouts.SearchInput_rec) ds_in) := 
      FUNCTION

        // The indexes created for this project were built as one part indexes and contain only  a small
        // amount of PRTE data. Hence, even with multiple keyed fields, performance shouldn't be an issue.    
        ds_LegacyIds :=     
          JOIN(ds_in, DemoSearchTool.Keys.businesses_bdid,
               KEYED(LEFT.isFCRA = RIGHT.isFCRA AND
                     DemoSearchTool.Macros.mac_JoinBizKeys()),
               TRANSFORM(DemoSearchTool.Layouts.Ids_rec,
                         SELF.BDID  := RIGHT.BDID,
                         SELF       := []),  
               LIMIT(0),
               KEEP(DemoSearchTool.Constants.JOIN_LIMIT));

        RETURN ds_LegacyIds; 
      END;


    EXPORT fn_getBipOnlyIds(DATASET(DemoSearchTool.Layouts.SearchInput_rec) ds_in ) := 
      FUNCTION

        // The indexes created for this project were built as one part indexes and contain only  a small
        // amount of PRTE data. Hence, even with multiple keyed fields, performance shouldn't be an issue.    
        ds_BipIds :=            
          JOIN(ds_in, DemoSearchTool.Keys.businesses_linkids, 
               KEYED( DemoSearchTool.Macros.mac_JoinBizKeys() ),
               TRANSFORM(DemoSearchTool.Layouts.Ids_rec,
                         SELF.SELEID := RIGHT.SELEID,
                         SELF.ORGID  := RIGHT.ORGID,
                         SELF.ULTID  := RIGHT.ULTID,
                         SELF        := []),  
               LIMIT(0),
               KEEP(DemoSearchTool.Constants.JOIN_LIMIT));
 
        RETURN ds_BipIds;
      END;
    

      EXPORT fn_getDtcOnlyIds(DATASET(DemoSearchTool.Layouts.SearchInput_rec) ds_in) := 
        FUNCTION
            
          // The indexes created for this project were built as one part indexes and contain only  a small
          // amount of PRTE data. Hence, even with multiple keyed fields, performance shouldn't be an issue.    
          ds_DtcKeyIds := 
            JOIN(ds_in, DemoSearchTool.Keys.DTC,  
                 KEYED(DemoSearchTool.Macros.mac_JoinPersonKeys()),
                 TRANSFORM(DemoSearchTool.Layouts.Ids_rec,
                           SELF.did := RIGHT.did, 
                           SELF := [] ),  
                 LIMIT(0),
                 KEEP(DemoSearchTool.Constants.JOIN_LIMIT));
                 
          RETURN  ds_DtcKeyIds;   
        END;
       

      EXPORT fn_getPeopleOnlyIds(DATASET(DemoSearchTool.Layouts.SearchInput_rec) ds_in ) := 
          FUNCTION
          
            // The indexes created for this project were built as one part indexes and contain only  a small
            // amount of PRTE data. Hence, even with multiple keyed fields, performance shouldn't be an issue.    
            ds_PeopleKeyIds := 
              JOIN(ds_in, DemoSearchTool.Keys.people,  
                 KEYED(LEFT.isFCRA = RIGHT.isFCRA AND
                       DemoSearchTool.Macros.mac_JoinPersonKeys()),
                 TRANSFORM(DemoSearchTool.Layouts.Ids_rec,
                           SELF.did := RIGHT.did, 
                           SELF := []), 
                 LIMIT(0),
                 KEEP(DemoSearchTool.Constants.JOIN_LIMIT));
                
          RETURN  ds_PeoplekeyIds;   
        END;           


      // get DTC IDs for joining with Legacy IDs later
      EXPORT fn_getDtcForLegacyIds(DATASET(DemoSearchTool.Layouts.SearchInput_rec) ds_in) := 
        FUNCTION
        
          // The indexes created for this project were built as one part indexes and contain only  a small
          // amount of PRTE data. Hence, even with multiple keyed fields, performance shouldn't be an issue.    
          ds_DtcKeyIds := 
            JOIN(ds_in, DemoSearchTool.Keys.DTC,  
                 KEYED(DemoSearchTool.Macros.mac_JoinPersonKeys() AND
                       IF(LEFT.Per_NumOfBizExecutiveOfCount  = 0,
                          LEFT.Per_NumOfBizExecutiveOfCount  = RIGHT.Owned_Business_bdid_cnt,
                          LEFT.Per_NumOfBizExecutiveOfCount <= RIGHT.Owned_Business_bdid_cnt)
                       ),
                 TRANSFORM(DemoSearchTool.Layouts.combinedTemp_rec,
                           SELF.did                         := RIGHT.did, 
                           SELF.owned_business_bdid_cnt     := RIGHT.owned_business_bdid_cnt,
		                       SELF.ds_owned_businesses_bdid    := CHOOSEN(RIGHT.owned_businesses_bdid,DemoSearchTool.Constants.JOIN_LIMIT),
                           SELF := LEFT,   // keep all biz counts & isFCRA
                           SELF := []), 
                 LIMIT(0),
                 KEEP(DemoSearchTool.Constants.JOIN_LIMIT));
                 
          RETURN  ds_DtcKeyIds;   
        END;
       

      // get People IDs for joining with Legacy IDs later
      EXPORT fn_getPeopleForLegacyIds(DATASET(DemoSearchTool.Layouts.SearchInput_rec) ds_in) := 
          FUNCTION

            // The indexes created for this project were built as one part indexes and contain only  a small
            // amount of PRTE data. Hence, even with multiple keyed fields, performance shouldn't be an issue.    
            ds_PeopleKeyIds := 
              JOIN(ds_in, DemoSearchTool.Keys.people,  
                 KEYED(LEFT.isFCRA = RIGHT.isFCRA AND
                       DemoSearchTool.Macros.mac_JoinPersonKeys() AND
                       IF(LEFT.Per_NumOfBizExecutiveOfCount  = 0,
                          LEFT.Per_NumOfBizExecutiveOfCount  = RIGHT.Owned_Business_bdid_cnt,
                          LEFT.Per_NumOfBizExecutiveOfCount <= RIGHT.Owned_Business_bdid_cnt)
                       ),
                 TRANSFORM(DemoSearchTool.Layouts.combinedTemp_rec,
                           SELF.did                         := RIGHT.did, 
                           SELF.owned_business_bdid_cnt     := RIGHT.owned_business_bdid_cnt,
		                       SELF.ds_owned_businesses_bdid    := CHOOSEN(RIGHT.owned_businesses_bdid,DemoSearchTool.Constants.JOIN_LIMIT),
                           SELF := LEFT,   // keep all biz counts & isFCRA
                           SELF := []), 
                 LIMIT(0),
                 KEEP(DemoSearchTool.Constants.JOIN_LIMIT));
                
          RETURN  ds_PeoplekeyIds;   
        END;  
        

      // get DTC IDs for joining with BIP IDs later
      EXPORT fn_getDtcForBipIds(DATASET(DemoSearchTool.Layouts.SearchInput_rec) ds_in) := 
        FUNCTION

          // The indexes created for this project were built as one part indexes and contain only  a small
          // amount of PRTE data. Hence, even with multiple keyed fields, performance shouldn't be an issue.    
          ds_DtcKeyIds := 
            JOIN(ds_in, DemoSearchTool.Keys.DTC,  
                 KEYED(DemoSearchTool.Macros.mac_JoinPersonKeys()) AND
                 WILD(RIGHT.Owned_Business_bdid_cnt) AND
                 KEYED( IF(LEFT.Per_NumOfBizExecutiveOfCount = 0,
                           LEFT.Per_NumOfBizExecutiveOfCount = RIGHT.Owned_Business_linkid_cnt,
                           LEFT.Per_NumOfBizExecutiveOfCount <= RIGHT.Owned_Business_linkid_cnt
                       ) 
                      ),
                 TRANSFORM(DemoSearchTool.Layouts.combinedTemp_rec,
                           SELF.did                         := RIGHT.did, 
                           SELF.owned_business_linkId_cnt   := RIGHT.owned_business_linkId_cnt,
                           SELF.ds_owned_businesses_linkId  := CHOOSEN(RIGHT.owned_businesses_linkId,DemoSearchTool.Constants.JOIN_LIMIT),
                           SELF := LEFT,   // keep all biz counts & isFCRA
                           SELF := []), 
                 LIMIT(0),
                 KEEP(DemoSearchTool.Constants.JOIN_LIMIT));
                 
          RETURN  ds_DtcKeyIds;   
        END;
       

      // get People IDs for joining with BIP IDs later
      EXPORT fn_getPeopleForBipIds(DATASET(DemoSearchTool.Layouts.SearchInput_rec) ds_in ) := 
          FUNCTION
            
            // The indexes created for this project were built as one part indexes and contain only  a small
            // amount of PRTE data. Hence, even with multiple keyed fields, performance shouldn't be an issue.    
            ds_PeopleKeyIds := 
              JOIN(ds_in, DemoSearchTool.Keys.people,  
                   KEYED(LEFT.isFCRA = RIGHT.isFCRA AND
                         DemoSearchTool.Macros.mac_JoinPersonKeys()) AND
                   WILD(RIGHT.Owned_Business_bdid_cnt) AND
                   KEYED(IF(LEFT.Per_NumOfBizExecutiveOfCount = 0,
                            LEFT.Per_NumOfBizExecutiveOfCount = RIGHT.Owned_Business_linkid_cnt,
                            LEFT.Per_NumOfBizExecutiveOfCount <= RIGHT.Owned_Business_linkid_cnt
                           ) ),
                 TRANSFORM(DemoSearchTool.Layouts.combinedTemp_rec,
                           SELF.did                         := RIGHT.did, 
                           SELF.owned_business_linkId_cnt   := RIGHT.owned_business_linkId_cnt,
                           SELF.ds_owned_businesses_linkId  := CHOOSEN(RIGHT.owned_businesses_linkId,DemoSearchTool.Constants.JOIN_LIMIT),
                           SELF := LEFT,   // keep all of the biz counts & isFCRA
                           SELF := []), 
                 LIMIT(0),
                 KEEP(DemoSearchTool.Constants.JOIN_LIMIT));
                
          RETURN  ds_PeoplekeyIds;   
        END;  
 
    
    // get Legacy Business IDs for combined search after the 
    // DIDs (and bdid child dataset) has been gleaned from the person/DTC key
    EXPORT fn_getCombinedLegacyIds(DATASET(DemoSearchTool.Layouts.combinedTemp_rec) ds_PerIdsWithBizCounts) := 
      FUNCTION
        
        /* ***************************************************************     
         *           Normalize by Legacy Business Ids                    *
         *       add join to BDID key for combined search                *
         *****************************************************************/               
        DemoSearchTool.Layouts.combinedTemp_rec xfm_normBdids
          (DemoSearchTool.Layouts.combinedTemp_rec L, INTEGER C):=
          TRANSFORM
            SELF.BDID := L.ds_owned_businesses_bdid[C].BDID;
            SELF      := L;  
          END;

        ds_perIds_withBizCountsBdid_norm := 
          NORMALIZE(ds_PerIdsWithBizCounts, 
                    LEFT.owned_business_bdid_cnt, 
                    xfm_normBdids(LEFT,COUNTER));

        // The indexes created for this project were built as one part indexes and contain only  a small
        // amount of PRTE data. Hence, even with multiple keyed fields, performance shouldn't be an issue.    
        ds_combinedBdidIds := 
          JOIN(ds_perIds_withBizCountsBdid_norm, DemoSearchTool.Keys.combined_biz_bdid, 
            KEYED(LEFT.bdid = RIGHT.bdid AND
                  LEFT.isFCRA = RIGHT.isFCRA AND 
                  DemoSearchTool.Macros.mac_JoinBizKeys()),
                  TRANSFORM(DemoSearchTool.Layouts.Ids_rec,
                            SELF.BDID   := RIGHT.BDID,
                            SELF.DID    := LEFT.DID,
                            SELF        := []),  
                  LIMIT(0),
                  KEEP(DemoSearchTool.Constants.JOIN_LIMIT));  

        RETURN ds_combinedBdidIds;
      END;
 

    // get BIP Business IDs for combined search after the 
    // DIDs (and LinkIds child dataset) has been gleaned from the person/DTC key
    EXPORT fn_getCombinedBipIds(DATASET(DemoSearchTool.Layouts.combinedTemp_rec) ds_PerIdsWithBizCounts) := 
      FUNCTION
        
        /* ******************************************************************     
         *             Normalize BIP Business Ids (LinkIds)                 *
         *     add join to LinkIds Business key for combines search         *
         ********************************************************************/               
        DemoSearchTool.Layouts.combinedTemp_rec xfm_normBdids
          (DemoSearchTool.Layouts.combinedTemp_rec L, INTEGER C):=
          TRANSFORM
            SELF.SELEID := L.ds_owned_businesses_linkid[C].SELEID;
            SELF        := L;  
          END;

        ds_perIds_withBizCountsBipIds_norm := 
          NORMALIZE(ds_PerIdsWithBizCounts, 
                    LEFT.owned_business_linkId_cnt, 
                    xfm_normBdids(LEFT,COUNTER));

        // The indexes created for this project were built as one part indexes and contain only  a small
        // amount of PRTE data. Hence, even with multiple keyed fields, performance shouldn't be an issue.    
        ds_combinedBipIds := 
          JOIN(ds_perIds_withBizCountsBipIds_norm, DemoSearchTool.Keys.combined_biz_linkids,
            KEYED(BIPV2.IDmacros.mac_JoinTop3Linkids() AND
                  DemoSearchTool.Macros.mac_JoinBizKeys()),
                  TRANSFORM(DemoSearchTool.Layouts.Ids_rec,
                            SELF.ULTID  := RIGHT.ULTID,
                            SELF.ORGID  := RIGHT.ORGID,
                            SELF.SELEID := RIGHT.SELEID,
                            SELF.DID    := LEFT.DID,
                            SELF        := []),  
                 LIMIT(0),
                 KEEP(DemoSearchTool.Constants.JOIN_LIMIT));

        RETURN ds_combinedBipIds;
      END;

  END;
  
