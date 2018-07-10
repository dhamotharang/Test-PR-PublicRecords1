IMPORT iesp, DemoSearchTool;

EXPORT TestCaseSearchService_Records (DemoSearchTool.IParams.SearchIParams inMod ) := 
  FUNCTION
    
    
    /* ================================================================ *
     *               Legacy Business Only Records                       *
     * ================================================================ */
    ds_LegacyOnlyIds  := DemoSearchTool.SearchIds.fn_getLegacyOnlyIds(inMod.ds_SearchInput);
                                                                      
    ds_LegacyOnlyRecs_raw := DemoSearchTool.Raw.fn_getLegacyOnlyRecs(ds_LegacyOnlyIds);
    
    ds_LegacyOnlyRecs_sorted := SORT(ds_LegacyOnlyRecs_raw, BDID);
    
    ds_LegacyOnlyRecs := 
      CHOOSEN(
        PROJECT(ds_LegacyOnlyRecs_sorted, 
                iesp.DemoSearchTool.t_DemoSearchToolSearchRecord),
        DemoSearchTool.Constants.MAX_RECS_RETURNED);
    
    
    /* ================================================================ *
     *               BIP Business Only Records                          *
     * ================================================================ */
    ds_BipOnlyIds  := DemoSearchTool.SearchIds.fn_getBipOnlyIds(inMod.ds_SearchInput);
    ds_BipOnlyRecs_raw := DemoSearchTool.Raw.fn_getBipOnlyRecs(ds_BipOnlyIds);
    
    ds_BipOnlyRecs_sorted := SORT(ds_BipOnlyRecs_raw, SELEID);
    
    ds_BipOnlyRecs := 
      CHOOSEN(
        PROJECT(ds_BipOnlyRecs_sorted, 
                iesp.DemoSearchTool.t_DemoSearchToolSearchRecord),
        DemoSearchTool.Constants.MAX_RECS_RETURNED);


    /* ================================================================ *
     *               Direct To Consumer Only Records                    *
     * ================================================================ */
    ds_DtcOnlyIds := DemoSearchTool.SearchIds.fn_getDtcOnlyIds(inMod.ds_SearchInput);
    
    ds_DtcOnlyRecs_raw := DemoSearchTool.Raw.fn_getDtcOnlyRecs(ds_DtcOnlyIds);
    
    ds_DtcOnlyRecs_sorted := SORT(ds_DtcOnlyRecs_raw, UniqueId);
    
    ds_DtcOnlyRecs := 
      CHOOSEN(
        PROJECT(ds_DtcOnlyRecs_sorted, 
                iesp.DemoSearchTool.t_DemoSearchToolSearchRecord),
        DemoSearchTool.Constants.MAX_RECS_RETURNED);

    /* ================================================================ *
     *               Person Only Records                                *
     * ================================================================ */
    ds_PersonOnlyIds  := DemoSearchTool.SearchIds.fn_getPeopleOnlyIds(inMod.ds_SearchInput);
    ds_PersonOnlyRecs_raw := DemoSearchTool.Raw.fn_getPersonOnlyRecs(ds_PersonOnlyIds);
    
    ds_PersonOnlyRecs_sorted := SORT(ds_PersonOnlyRecs_raw, UniqueId);
    ds_PersonOnlyRecs := 
      CHOOSEN(
        PROJECT(ds_PersonOnlyRecs_sorted, 
                iesp.DemoSearchTool.t_DemoSearchToolSearchRecord),
        DemoSearchTool.Constants.MAX_RECS_RETURNED);


    /* ================================================================ *
     *        Direct To Consumer & Legacy Business Records              *
     * ================================================================ */
    ds_DtcForLegacyIds := DemoSearchTool.SearchIds.fn_getDtcForLegacyIds(inMod.ds_SearchInput);
    
    ds_DtcLegacyIds :=
      DemoSearchTool.SearchIds.fn_getCombinedLegacyIds(ds_DtcForLegacyIds);
    
    ds_DtcLegacyRecs_raw := DemoSearchTool.Raw.fn_getCombinedLegacyRecs(ds_DtcLegacyIds);
    ds_DtcLegacyRecs_sorted := SORT(ds_DtcLegacyRecs_raw, UniqueId, BDID);

    ds_DtcAndLegacyBizRecs := 
      CHOOSEN(
        PROJECT(ds_DtcLegacyRecs_sorted, 
                iesp.DemoSearchTool.t_DemoSearchToolSearchRecord),
        DemoSearchTool.Constants.MAX_RECS_RETURNED);
    
    /* ================================================================ *
     *        Direct To Consumer & Bip Business Records                 *
     * ================================================================ */
    ds_DtcForBipIds := DemoSearchTool.SearchIds.fn_getDtcForBipIds(inMod.ds_SearchInput);
    
    ds_DtcBipIds :=
      DemoSearchTool.SearchIds.fn_getCombinedBipIds(ds_DtcForBipIds);
    
    ds_DtcBipRecs_raw := DemoSearchTool.Raw.fn_getCombinedBipRecs(ds_DtcBipIds);
    ds_DtcBipRecs_sorted := SORT(ds_DtcBipRecs_raw, UniqueId, SELEID);

    ds_DtcAndBipBizRecs := 
      CHOOSEN(
        PROJECT(ds_DtcBipRecs_sorted, 
                iesp.DemoSearchTool.t_DemoSearchToolSearchRecord),
        DemoSearchTool.Constants.MAX_RECS_RETURNED);
 
    /* ================================================================ *
     *        Direct To Consumer, BIP & Legacy Business Records         *
     * ================================================================ */
    // Get Legacy IDs/Recs count
    cnt_DtcLegacyRecs := COUNT(ds_DtcLegacyRecs_sorted);
    
    // Get Bip IDs/Recs count
    cnt_DtcBipRecs := COUNT(ds_DtcBipRecs_sorted);
    
    ds_DtcBipLegacyRecs := 
      MAP( cnt_DtcLegacyRecs <= DemoSearchTool.Constants.HALF_MAX_RECS AND
           cnt_DtcBipRecs    <= DemoSearchTool.Constants.HALF_MAX_RECS      =>
                   ds_DtcLegacyRecs_sorted + ds_DtcBipRecs_sorted, 
           cnt_DtcLegacyRecs >  DemoSearchTool.Constants.HALF_MAX_RECS AND
           cnt_DtcBipRecs    <= DemoSearchTool.Constants.HALF_MAX_RECS      =>
                   CHOOSEN(ds_DtcLegacyRecs_sorted,
                          (DemoSearchTool.Constants.MAX_RECS_RETURNED - cnt_DtcBipRecs)) + 
                   ds_DtcBipRecs_sorted,           
           cnt_DtcLegacyRecs <= DemoSearchTool.Constants.HALF_MAX_RECS AND
           cnt_DtcBipRecs    > DemoSearchTool.Constants.HALF_MAX_RECS      =>
                   ds_DtcLegacyRecs_sorted +
                   CHOOSEN(ds_DtcBipRecs_sorted,          
                          (DemoSearchTool.Constants.MAX_RECS_RETURNED - cnt_DtcLegacyRecs)), 
                   // Default legacy & bip rec count > 50
                   CHOOSEN(ds_DtcLegacyRecs_sorted,
                          (DemoSearchTool.Constants.HALF_MAX_RECS)) + 
                   CHOOSEN(ds_DtcBipRecs_sorted,          
                          (DemoSearchTool.Constants.HALF_MAX_RECS)) 
          );        

    ds_DtcAndBothBizRecs := 
      PROJECT(ds_DtcBipLegacyRecs, 
              iesp.DemoSearchTool.t_DemoSearchToolSearchRecord);
 
    /* ================================================================ *
     *            Person & Legacy Business Records                      *
     * ================================================================ */
    ds_PersonForLegacyIds := 
      DemoSearchTool.SearchIds.fn_getPeopleForLegacyIds(inMod.ds_SearchInput);
    ds_PersonLegacyIds :=
      DemoSearchTool.SearchIds.fn_getCombinedLegacyIds(ds_PersonForLegacyIds);
    
    ds_PersonLegacyRecs_raw := DemoSearchTool.Raw.fn_getCombinedLegacyRecs(ds_PersonLegacyIds);
    ds_PersonLegacyRecs_sorted := SORT(ds_PersonLegacyRecs_raw, UniqueId, BDID);

    ds_PersonAndLegacyBizRecs := 
      CHOOSEN(
        PROJECT(ds_PersonLegacyRecs_sorted, 
                iesp.DemoSearchTool.t_DemoSearchToolSearchRecord),
        DemoSearchTool.Constants.MAX_RECS_RETURNED);
    
    /* ================================================================ *
     *            Person & BIP Business Records                         *
     * ================================================================ */
    ds_PersonForBipIds := DemoSearchTool.SearchIds.fn_getPeopleForBipIds(inMod.ds_SearchInput);
    
    ds_PersonBipIds :=
      DemoSearchTool.SearchIds.fn_getCombinedBipIds(ds_PersonForBipIds);
    
    ds_PersonBipRecs_raw := DemoSearchTool.Raw.fn_getCombinedBipRecs(ds_PersonBipIds);
    ds_PersonBipRecs_sorted := SORT(ds_PersonBipRecs_raw, UniqueId, SELEID);

    ds_PersonAndBipBizRecs := 
      CHOOSEN(
        PROJECT(ds_PersonBipRecs_sorted, 
                iesp.DemoSearchTool.t_DemoSearchToolSearchRecord),
        DemoSearchTool.Constants.MAX_RECS_RETURNED);


    /* ================================================================ *
     *         Person, BIP & Legacy Business Records                    *
     * ================================================================ */
    // Get Legacy IDs/Recs count
    cnt_PersonLegacyRecs := COUNT(ds_PersonLegacyRecs_sorted);
    
    // Get Bip IDs/Recs count
    cnt_PersonBipRecs := COUNT(ds_PersonBipRecs_sorted);
    
    // Combine Legacy and Bip Recs 
    ds_PersonBipLegacyRecs := 
      MAP( cnt_PersonLegacyRecs <= DemoSearchTool.Constants.HALF_MAX_RECS AND
           cnt_PersonBipRecs    <= DemoSearchTool.Constants.HALF_MAX_RECS      =>
                   ds_PersonLegacyRecs_sorted + ds_PersonBipRecs_sorted, 
           cnt_PersonLegacyRecs >  DemoSearchTool.Constants.HALF_MAX_RECS AND
           cnt_PersonBipRecs    <= DemoSearchTool.Constants.HALF_MAX_RECS      =>
                   CHOOSEN(ds_PersonLegacyRecs_sorted,
                          (DemoSearchTool.Constants.MAX_RECS_RETURNED - cnt_PersonBipRecs)) + 
                   ds_PersonBipRecs_sorted,           
           cnt_PersonLegacyRecs <= DemoSearchTool.Constants.HALF_MAX_RECS AND
           cnt_PersonBipRecs    > DemoSearchTool.Constants.HALF_MAX_RECS      =>
                   ds_PersonLegacyRecs_sorted +
                   CHOOSEN(ds_PersonBipRecs_sorted,          
                          (DemoSearchTool.Constants.MAX_RECS_RETURNED - cnt_PersonLegacyRecs)), 
                   // Default legacy & bip rec count > 50
                   CHOOSEN(ds_PersonLegacyRecs_sorted,
                          (DemoSearchTool.Constants.HALF_MAX_RECS)) + 
                   CHOOSEN(ds_PersonBipRecs_sorted,          
                          (DemoSearchTool.Constants.HALF_MAX_RECS)) 
          );        

    ds_PersonAndBothBizRecs := 
      PROJECT(ds_PersonBipLegacyRecs, 
              iesp.DemoSearchTool.t_DemoSearchToolSearchRecord);
      
 
    /* ================================================================ *
     *          Multiple Businesses At An Address Records               *
     * ================================================================ */
    ds_MultiBizAtAddrRecs := 
      DemoSearchTool.Raw.fn_getMultiBizAtAddressRecs(inMod.ds_SearchInput, 
                                                     inMod.is_Biz_SearchLegacyKeys, 
                                                     inMod.is_Biz_SearchBipKeys);
 
    
    /* ================================================================ *
     *           Search requested                                       *
     * ================================================================ */
     ds_results  :=  
      MAP(inMod.isMultiBizAtAddress            => ds_MultiBizAtAddrRecs,
      
          inMod.isPersonSearch AND
          NOT inMod.is_Per_searchDirectToConsumer AND
          NOT inMod.isBusinessSearch           => ds_PersonOnlyRecs,
          
          inMod.isPersonSearch AND 
          inMod.is_Per_searchDirectToConsumer AND
          NOT inMod.isBusinessSearch           => ds_DtcOnlyRecs,
          
          inMod.isPersonSearch AND
          NOT inMod.is_Per_searchDirectToConsumer AND
          inMod.isBusinessSearch  AND
          inMod.is_Biz_SearchLegacyKeys AND
          inMod.is_Biz_SearchBipKeys              => ds_PersonAndBothBizRecs,
          
          inMod.isPersonSearch AND
          NOT inMod.is_Per_searchDirectToConsumer AND
          inMod.isBusinessSearch  AND
          inMod.is_Biz_SearchLegacyKeys           => ds_PersonAndLegacyBizRecs,
          
          inMod.isPersonSearch AND
          NOT inMod.is_Per_searchDirectToConsumer AND
          inMod.isBusinessSearch  AND
          inMod.is_Biz_SearchBipKeys              => ds_PersonAndBipBizRecs,
          
          inMod.isPersonSearch AND
          inMod.is_Per_searchDirectToConsumer AND
          inMod.isBusinessSearch  AND
          inMod.is_Biz_SearchLegacyKeys AND
          inMod.is_Biz_SearchBipKeys              => ds_DtcAndBothBizRecs,
          
          inMod.isPersonSearch AND
          inMod.is_Per_searchDirectToConsumer AND
          inMod.isBusinessSearch  AND
          inMod.is_Biz_SearchLegacyKeys           => ds_DtcAndLegacyBizRecs,
          
          inMod.isPersonSearch AND
          inMod.is_Per_searchDirectToConsumer AND
          inMod.isBusinessSearch  AND
          inMod.is_Biz_SearchBipKeys              => ds_DtcAndBipBizRecs,
          
          NOT inMod.isPersonSearch AND
          inMod.isBusinessSearch  AND
          inMod.is_Biz_SearchLegacyKeys           => ds_LegacyOnlyRecs,
          
            /* default: BIP ONLY */               ds_BipOnlyRecs
         ); 

    RETURN ds_results;
  END;