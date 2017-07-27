#warning('Deprecated. Use Royalty.RoyaltyTargus.GetOnlineRoyalties instead');
export MAC_RoyaltyTargus(inf, royal_out, src='vendor_id', src_type='TargusType') := macro

	royal_out := 
		dataset([{
							Royalty.Constants.RoyaltyType.TARGUS,
							sum(inf, length(trim(src_type))),
							count(inf(src='TG',src_type=''))
						}],Royalty.Layouts.Royalty);			
												
endmacro;											
