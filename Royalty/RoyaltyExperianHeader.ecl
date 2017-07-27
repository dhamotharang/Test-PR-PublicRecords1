import MDR;
EXPORT RoyaltyExperianHeader := MODULE

	export GetFCRARoyaltySet(dRecsIn) := 
	FUNCTIONMACRO	
	
		dENRoyalOut := 
			row({
						Royalty.Constants.RoyaltyCode.EN_HEADER_FCRA,
						Royalty.Constants.RoyaltyType.EN_HEADER_FCRA,
						count(dRecsIn(src=MDR.sourceTools.src_Experian_Credit_Header)),
						count(dRecsIn(src!=MDR.sourceTools.src_Experian_Credit_Header))
					},Royalty.Layouts.Royalty);			

			
		return dENRoyalOut;
												
	ENDMACRO;		

END;