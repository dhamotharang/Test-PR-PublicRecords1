EXPORT RoyaltyTargus := MODULE;

	EXPORT GetBatchRoyaltiesByAcctno(dInF, dRecsOut, pSrc='vendor_id', pTargusType='TargusType', fAcctno='acctno', fOrigAcctno='orig_acctno') := 
	FUNCTIONMACRO
    IMPORT MDR;
		dTGRecsOut 		:= dRecsOut(pSrc=MDR.sourceTools.src_Targus_Gateway);
				
		Royalty.Layouts.RoyaltyForBatch tNormForRoyalty(RECORDOF(dTGRecsOut) l, INTEGER C) := 
		TRANSFORM
			SELF.acctno						:= l.fAcctno;

			_rcode := MAP(
				C = 1 => Royalty.Constants.RoyaltyCode.TARGUS,
				C = 2 => Royalty.Constants.RoyaltyCode.TARGUS_PDE,
				C = 3 => Royalty.Constants.RoyaltyCode.TARGUS_WCS,
				C = 4 => Royalty.Constants.RoyaltyCode.TARGUS_VE,
				C = 5 => Royalty.Constants.RoyaltyCode.TARGUS_NV,
				0
				);		
			SELF.royalty_type_code	:= _rcode;			
			SELF.royalty_type 			:= Royalty.Functions.GetRoyaltyType(_rcode);
			
			// TargusType may carry more than one type, depending on how we hit the gateway. E.g. 'PW' means we hit the gateway twice, once 
			// for a PDE search and again for a Wireless Connection search.
			_royalty_count 			:= MAP(
				C = 1 																									=> length(trim(l.pTargusType)), // preserving legacy/old counters
				C = 2 and Royalty.Functions.isTargusPDE(l.pTargusType) 	=> 1,
				C = 3 and Royalty.Functions.isTargusWCS(l.pTargusType) 	=> 1,
				C = 4 and Royalty.Functions.isTargusVE(l.pTargusType) 	=> 1,
				C = 5 and Royalty.Functions.isTargusNV(l.pTargusType) 	=> 1,
				0);
			_non_royalty_count 	:= MAP(
				C = 1 and l.pTargusType=''															=> 1, // preserving legacy/old counters
				// C = 2 and Royalty.Functions.isTargusPDE(l.pTargusType) => 0,
				// C = 3 and Royalty.Functions.isTargusWCS(l.pTargusType) => 0,
				// C = 4 and Royalty.Functions.isTargusVE(l.pTargusType) 	=> 0,
				// C = 5 and Royalty.Functions.isTargusNV(l.pTargusType) 	=> 0,
				0);							
			
			// Skip record if both royalty counters are 0.
			SELF.royalty_count			:= IF(_royalty_count = 0 AND _non_royalty_count = 0, SKIP, _royalty_count);
			SELF.non_royalty_count	:= _non_royalty_count;			
		END;		
				
		unsigned1 N_TG_ROYALTY_TYPES := 5;		
		dNormTGRoyalties 	:= NORMALIZE(dTGRecsOut, N_TG_ROYALTY_TYPES, tNormForRoyalty(LEFT, COUNTER));				
				
		dRoyaltiesByAcctno := 
			JOIN(dInF, dNormTGRoyalties, 
					 (string)LEFT.fAcctno = (string)RIGHT.acctno, 
					 TRANSFORM(Royalty.Layouts.RoyaltyForBatch,
								SELF.acctno := LEFT.fOrigAcctno;
								SELF := RIGHT)
					 );
		
		RETURN dRoyaltiesByAcctno;
		
	ENDMACRO;

	EXPORT GetOnlineRoyalties(dRecsOut, pSrc='vendor_id', pTargusType='TargusType', trackPDE='true', trackWCS='true', trackVE='true', trackNV='false') := 
	FUNCTIONMACRO	
    IMPORT MDR;

		dRoyalOutLegacy := 
			dataset([{
								Royalty.Constants.RoyaltyCode.TARGUS,
								Royalty.Constants.RoyaltyType.TARGUS,
								sum(dRecsOut, length(trim(pTargusType))),
								count(dRecsOut(pSrc=MDR.sourceTools.src_Targus_Gateway,pTargusType=''))
							}],Royalty.Layouts.Royalty)(royalty_count>0 or non_royalty_count>0);			

		dRoyalOutPDE := 
			dataset([{
								Royalty.Constants.RoyaltyCode.TARGUS_PDE,
								Royalty.Constants.RoyaltyType.TARGUS_PDE,
								count(dRecsOut(Royalty.Functions.isTargusPDE(pTargusType))),
								0
							}],Royalty.Layouts.Royalty);			
		
		dRoyalOutWCS := 
			dataset([{
								Royalty.Constants.RoyaltyCode.TARGUS_WCS,
								Royalty.Constants.RoyaltyType.TARGUS_WCS,
								count(dRecsOut(Royalty.Functions.isTargusWCS(pTargusType))),
								0
							}],Royalty.Layouts.Royalty);	
		
		dRoyalOutVE := 
			dataset([{
								Royalty.Constants.RoyaltyCode.TARGUS_VE,
								Royalty.Constants.RoyaltyType.TARGUS_VE,
								count(dRecsOut(Royalty.Functions.isTargusVE(pTargusType))),
								0
							}],Royalty.Layouts.Royalty);	
		
		dRoyalOutNV := 
			dataset([{
								Royalty.Constants.RoyaltyCode.TARGUS_NV,
								Royalty.Constants.RoyaltyType.TARGUS_NV,
								count(dRecsOut(Royalty.Functions.isTargusNV(pTargusType))),
								0
							}],Royalty.Layouts.Royalty)(royalty_count>0);	// does not appear to be used at all

		dTGRoyalOut := dRoyalOutLegacy + 
									 if(trackPDE, dRoyalOutPDE) + 
									 if(trackWCS, dRoyalOutWCS) + 
									 if(trackVE, dRoyalOutVE) + 
									 if(trackNV, dRoyalOutNV);
			
		return dTGRoyalOut;
												
	ENDMACRO;		

END;	