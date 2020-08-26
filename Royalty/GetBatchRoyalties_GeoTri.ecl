// NOTE: Cloned from Royalty.GetBatchRoyalties and modified for use by new GeoTriangulation_Services.BatchService in the 
// 08/25/2020 RR via JIRA RR-19445.  Until the near future (Sept 2020) when all queries using the 
// Royalty.Layouts.RoyaltyForBatch record layout can be researched and tested. 
// Then the GeoTriangulation_Services.BatchService atrr using this temp attribute can be revised and this attr can be deleted.

/*
  This function will count and aggregate royalties by type and return a RoyaltySet as expected by the Batch Platform.
*/
export GetBatchRoyalties_GeoTri(dataset(Layouts_GeoTri.RoyaltyForBatch) dRoyalIn, boolean pReturnDetails=false) := function

  Layouts_GeoTri.RoyaltyForBatch tRollupByAcctno(Layouts_GeoTri.RoyaltyForBatch L, 
                                                 DATASET(Layouts_GeoTri.RoyaltyForBatch) R, boolean pIsAggr) := TRANSFORM
    SELF.acctno             := IF(pIsAggr, '__BATCH__', L.acctno);
    SELF.royalty_count      := SUM(R, royalty_count);
    SELF.non_royalty_count  := SUM(R, non_royalty_count);
    SELF.source_type        := IF(L.royalty_type_code in Royalty.Constants.GatewayRoyalties,
                                  Royalty.Constants.SourceType.GATEWAY, 
                                  Royalty.Constants.SourceType.INHOUSE);
    SELF                    := L;
  END;
 
  dRoyaltyInGRPByAcctno := GROUP(SORT(dRoyalIn, acctno, royalty_type_code, royalty_type, count_entity),
                                   acctno, royalty_type_code, royalty_type, count_entity);
  dRoyaltiesByAcctno    := ROLLUP(dRoyaltyInGRPByAcctno, GROUP, tRollupByAcctno(LEFT, ROWS(LEFT), FALSE));

  dRoyaltyInGRPByType   := GROUP(SORT(dRoyalIn, royalty_type_code, royalty_type, count_entity), 
                                 royalty_type_code, royalty_type, count_entity);
  dRoyaltiesByType      := ROLLUP(dRoyaltyInGRPByType, GROUP, tRollupByAcctno(LEFT, ROWS(LEFT), TRUE));

  dRoyalties := sort(UNGROUP(dRoyaltiesByType) + UNGROUP(if(pReturnDetails, dRoyaltiesByAcctno)), 
                     acctno[1..5]<>'__BAT', if(acctno[1..5]='__BAT', '', acctno), // just to keep '__BATCH__' royalties at the top
                     royalty_type_code,
                     count_entity);

  return dRoyalties;
 
end;