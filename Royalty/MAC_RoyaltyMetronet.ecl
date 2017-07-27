
export MAC_RoyaltyMetronet(recs, royal_out, royalty_type_field = 'royalty_type', royalty_type_value = 'Royalty.Constants.RoyaltyType.METRONET') := 
		macro
			royal_out := 
					dataset(
						[{
							Royalty.Constants.RoyaltyCode.METRONET, 
							Royalty.Constants.RoyaltyType.METRONET, 
							count(recs(royalty_type_field = royalty_type_value)), 
							0
						}], 
						Royalty.Layouts.Royalty
					);			
		endmacro;
