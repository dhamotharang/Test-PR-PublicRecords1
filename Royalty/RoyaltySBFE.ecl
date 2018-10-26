Import LNSmallBusiness;
EXPORT RoyaltySBFE := module
		

    EXPORT GetOnlineRoyalties(dRecsOut) := 

		FUNCTIONMACRO	
		
			dTGRoyalOut :=      DATASET([{
                              Royalty.Constants.RoyaltyCode.SBFE,
                              Royalty.Constants.RoyaltyType.SBFE,
                              (UNSIGNED)((INTEGER)dRecsOut[1].SBFEAccountCount > 0),
                              0
                            }],Royalty.Layouts.Royalty);			
			
			RETURN dTGRoyalOut;
	ENDMACRO;		

	EXPORT GetNoRoyalties() := 
		FUNCTIONMACRO	
		
			dTGRoyalOut :=    DATASET([{
                                  Royalty.Constants.RoyaltyCode.SBFE,
                                  Royalty.Constants.RoyaltyType.SBFE,
                                  0,
                                  0
                                }],Royalty.Layouts.Royalty);			
			
			RETURN dTGRoyalOut;
	ENDMACRO;
	
	EXPORT GetOnlineRoyaltiesPlus(dRecsOut,OutputType) := 
		FUNCTIONMACRO	
		
			dTGRoyalPlusOut :=  if ( OutputType IN [ LNSmallBusiness.Constants.OutputType.PDF_AND_XML,
                                          LNSmallBusiness.Constants.OutputType.PDF_ONLY],
                          DATASET([{
                              Royalty.Constants.RoyaltyCode.SBFE_PDF,
                              Royalty.Constants.RoyaltyType.SBFE_PDF,
                              (UNSIGNED)((INTEGER)dRecsOut[1].SBFEAccountCount > 0),
                              0
                            },
                            {
                              Royalty.Constants.RoyaltyCode.SBFE,
                              Royalty.Constants.RoyaltyType.SBFE,
                              (UNSIGNED)((INTEGER)dRecsOut[1].SBFEAccountCount > 0),
                              0
                            }],Royalty.Layouts.Royalty)
                            ,
                        DATASET([{
                              Royalty.Constants.RoyaltyCode.SBFE,
                              Royalty.Constants.RoyaltyType.SBFE,
                              (UNSIGNED)((INTEGER)dRecsOut[1].SBFEAccountCount > 0),
                              0
                            }],Royalty.Layouts.Royalty)
         );			
			
			RETURN dTGRoyalPlusOut;
	ENDMACRO;		

	EXPORT GetNoRoyaltiesPlus(OutputType) := 
		FUNCTIONMACRO	
		
			dTGRoyalPlusOut := if ( OutputType IN [ LNSmallBusiness.Constants.OutputType.PDF_AND_XML,
                                          LNSmallBusiness.Constants.OutputType.PDF_ONLY],
                      DATASET([{
                                  Royalty.Constants.RoyaltyCode.SBFE,
                                  Royalty.Constants.RoyaltyType.SBFE,
                                  0,
                                  0
                                },
                                {
                                  Royalty.Constants.RoyaltyCode.SBFE_PDF,
                                  Royalty.Constants.RoyaltyType.SBFE_PDF,
                                  0,
                                  0
                                }
                                ],Royalty.Layouts.Royalty)
                                ,
                        DATASET([{
                                  Royalty.Constants.RoyaltyCode.SBFE,
                                  Royalty.Constants.RoyaltyType.SBFE,
                                  0,
                                  0
                                }],Royalty.Layouts.Royalty));			
			
			RETURN dTGRoyalPlusOut;
	ENDMACRO;	
	
	EXPORT GetBatchRoyaltiesByAcctno(dInF, dRecsOut, fAcctno='acctno') := 
		FUNCTIONMACRO

			Royalty.Layouts.RoyaltyForBatch tPrepForRoyalty(RECORDOF(dInF) l, RECORDOF(dRecsOut) r) :=
			TRANSFORM
				SELF.acctno							:= l.acctno;
				SELF.royalty_type_code	:= Royalty.Constants.RoyaltyCode.SBFE;
				SELF.royalty_type 			:= Royalty.Constants.RoyaltyType.SBFE;
				SELF.royalty_count 			:= (UNSIGNED)((INTEGER)r.SBFEAccountCount > 0); 
				SELF.non_royalty_count 	:= 0;
				SELF.source_type        := 'I'; // Inhouse
			END;

			dRoyaltiesByAcctno := 
				JOIN(
					dInF, dRecsOut, 
					(STRING)LEFT.fAcctno = (STRING)RIGHT.fAcctno, 
					tPrepForRoyalty(LEFT, RIGHT)
				);
			
			RETURN dRoyaltiesByAcctno;
	ENDMACRO;	

END;