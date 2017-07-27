export MAC_RoyaltyTeaser(inf, royal_out, lastID) := 	macro

	royal_out := project(inf,	
									transform(Royalty.Layouts.Royalty,							
										self.Royalty_type_code:=Royalty.Constants.RoyaltyCode.TEASER,
										self.Royalty_type:=Royalty.Constants.RoyaltyType.TEASER,
										self.royalty_count:=0,
										self.non_royalty_count:=1,
										self.count_entity:=lastID+'|'+Trim(left.City,right)+'|'+left.State+'|'+left.Zip5));
											
endmacro;
