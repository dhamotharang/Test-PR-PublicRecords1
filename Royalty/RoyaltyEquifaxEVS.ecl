EXPORT RoyaltyEquifaxEVS := module

	EXPORT GetOnlineRoyaltiesVOE (boolean gotData) :=
					dataset(
						[{
							Royalty.Constants.RoyaltyCode.EFX_TWN_VOE_GW, 
							Royalty.Constants.RoyaltyType.EFX_TWN_VOE_GW, 
							if(gotData,1,0), 
							0
						}], 
						Royalty.Layouts.Royalty
					);
					
		
		
		EXPORT GetOnlineRoyaltiesVOI (boolean gotData) := 
					dataset(
						[{
							Royalty.Constants.RoyaltyCode.EFX_TWN_VOI_GW, 
							Royalty.Constants.RoyaltyType.EFX_TWN_VOI_GW, 
							if(gotData,1,0), 
							0
						}], 
						Royalty.Layouts.Royalty
					);

end;