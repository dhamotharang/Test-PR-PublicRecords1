EXPORT RoyaltyFirst_Data := module

	IMPORT Royalty;
		
	EXPORT GetOnlineRoyalties(search_results_temp) := 
		FUNCTIONMACRO	
			
			dTGRoyalOut := 
				DATASET([{
									Royalty.Constants.RoyaltyCode.FIRST_DATA,
									Royalty.Constants.RoyaltyType.FIRST_DATA,
									//if the gateway was called, one of the flagship indexes will contain '119' or there will be an exception code 
									if(search_results_temp[1].FDGatewayCalled  = True, 1, 0),
									0
								}],Royalty.Layouts.Royalty);			
			
			RETURN dTGRoyalOut;
	ENDMACRO;		

	EXPORT GetNoRoyalties() := 
		FUNCTIONMACRO	
		
			dTGRoyalOut := 
				DATASET([{
									Royalty.Constants.RoyaltyCode.FIRST_DATA,
									Royalty.Constants.RoyaltyType.FIRST_DATA,
									0,
									0
								}],Royalty.Layouts.Royalty);			
			
			RETURN dTGRoyalOut;
	ENDMACRO;	
/*

Leave as a template knowing batch royalties for First Data will be coming. Base taken from MLA so will need to be updated for First Data.
	
	EXPORT GetBatchRoyaltiesBySeq(dInF, dRecsOut, fSeq='seq') := 
		FUNCTIONMACRO

			model_info := Models.LIB_RiskView_Models().ValidV50Models;
			Custom_info := model_info(Model_Name = 'MLA1608_0')[1];
			
			Royalty.Layouts.RoyaltyForBatch tPrepForRoyalty(RECORDOF(dInF) l, RECORDOF(dRecsOut) r) :=
			TRANSFORM
				SELF.acctno							  := l.acctno;
				SELF.royalty_type_code	:= Royalty.Constants.RoyaltyCode.MLAALERT;
				SELF.royalty_type 			:= Royalty.Constants.RoyaltyType.MLAALERT;
				//if the gateway was called, one of the flagship indexes will contain '119' or there will be an exception code 
				gatewayHit := r.Billing_Index2 = (STRING)Custom_info.Billing_Index2 or
											r.Exception_code = RiskView.Constants.gatewayErrorCode;

				SELF.royalty_count 			:= if(gatewayHit, 1, 0);
				SELF.non_royalty_count 	:= 0;
				SELF.source_type        := 'I'; // Inhouse
			END;

			dRoyaltiesBySeq := 
				JOIN(
					dInF, dRecsOut, 
					(STRING)LEFT.fSeq = (STRING)RIGHT.fSeq, 
					tPrepForRoyalty(LEFT, RIGHT)
				);
			RETURN dRoyaltiesBySeq;
	ENDMACRO;	

	EXPORT GetNoBatchRoyalties() := 
		FUNCTIONMACRO	
		
			dTGRoyalOut := 
				DATASET([{
									'',
									Royalty.Constants.RoyaltyCode.MLAALERT,
									Royalty.Constants.RoyaltyType.MLAALERT,
									0,
									0
								}],Royalty.Layouts.RoyaltyForBatch);			
			
			RETURN dTGRoyalOut;
	ENDMACRO;	
*/	
END;
