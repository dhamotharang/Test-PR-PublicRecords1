/*
	This function will count and aggregate royalties by type and return a RoyaltySet as expected by the Batch Platform.
*/
export GetBatchRoyalties(dataset(Layouts.RoyaltyForBatch) dRoyalIn, boolean pReturnDetails=false) := function
	
	 Layouts.RoyaltyForBatch tRollupByAcctno(Layouts.RoyaltyForBatch L, DATASET(Layouts.RoyaltyForBatch) R, boolean pIsAggr) := TRANSFORM
		SELF.acctno 						:= IF(pIsAggr, '__BATCH__', L.acctno);
		SELF.royalty_count 			:= SUM(R, royalty_count);
		SELF.non_royalty_count 	:= SUM(R, non_royalty_count);		
		SELF.source_type				:= IF(L.royalty_type_code in Royalty.Constants.GatewayRoyalties, 
																	Royalty.Constants.SourceType.GATEWAY, 
																	Royalty.Constants.SourceType.INHOUSE);
		SELF 										:= L;
	 END;
	 
	 dRoyaltyInGRPByAcctno 	:= GROUP(SORT(dRoyalIn, acctno, royalty_type_code, royalty_type, count_entity), 
															acctno, royalty_type_code, royalty_type, count_entity);
	 dRoyaltiesByAcctno 	 	:= ROLLUP(dRoyaltyInGRPByAcctno, GROUP, tRollupByAcctno(LEFT, ROWS(LEFT), FALSE));

	 dRoyaltyInGRPByType		:= GROUP(SORT(dRoyalIn, royalty_type_code, royalty_type, count_entity), 
															royalty_type_code, royalty_type, count_entity);
	 dRoyaltiesByType 			:= ROLLUP(dRoyaltyInGRPByType, GROUP, tRollupByAcctno(LEFT, ROWS(LEFT), TRUE));

	 dRoyalties := sort(UNGROUP(dRoyaltiesByType) + UNGROUP(if(pReturnDetails, dRoyaltiesByAcctno)), 
											acctno[1..5]<>'__BAT', if(acctno[1..5]='__BAT', '', acctno), // just to keep '__BATCH__' royalties at the top
											royalty_type_code,
											count_entity);

	 return dRoyalties;		
	 
end;