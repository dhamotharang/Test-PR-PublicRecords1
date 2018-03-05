EXPORT RoyaltyEquifaxEVS := module

	EXPORT GetOnlineRoyaltiesVOE () :=
					dataset(
						[{
							Royalty.Constants.RoyaltyCode.EFX_TWN_VOE_GW, 
							Royalty.Constants.RoyaltyType.EFX_TWN_VOE_GW, 
							1, 
							0
						}], 
						Royalty.Layouts.Royalty
					);
					
		
		
		EXPORT GetOnlineRoyaltiesVOI () := 
					dataset(
						[{
							Royalty.Constants.RoyaltyCode.EFX_TWN_VOI_GW, 
							Royalty.Constants.RoyaltyType.EFX_TWN_VOI_GW, 
							1, 
							0
						}], 
						Royalty.Layouts.Royalty
					);

end;