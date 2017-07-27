EXPORT RoyaltyDNB := module
		
	EXPORT GetOnlineRoyalties(dRecsOut) := 
	FUNCTIONMACRO	
	
		dTGRoyalOut := 
			dataset([{
								Royalty.Constants.RoyaltyCode.DNB,
								Royalty.Constants.RoyaltyType.DNB,
								count(dRecsOut),
								0
							}],Royalty.Layouts.Royalty);			
		
		return dTGRoyalOut;
	ENDMACRO;				

END;