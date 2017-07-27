// This code replaces ClickData.mac_best_royalties.
EXPORT MAC_RoyaltyDMXML(inf, royal_out) := MACRO

	#uniquename(layout_royalty_count)
	%layout_royalty_count% := record
		recordof(inf);
		unsigned1 royalty_count;
	end;

	#uniquename(count_royalties)
	%layout_royalty_count% %count_royalties%(recordof(inf) l) := transform
		self.royalty_count := 
			if((unsigned1) l.age <> 0, 1, 0) +
			if((unsigned1) l.gender <> 0, 1, 0) +
			if((unsigned1) l.marital_status <> 0, 1, 0) +
			if((unsigned1) l.number_of_adults_in_household <> 0, 1, 0) +
			if((unsigned1) l.number_of_children_in_household <> 0, 1, 0) +
			if((unsigned1) l.dwelling_type <> 0, 1, 0) +
			if((unsigned1) l.home_ownerrenter_code <> 0, 1, 0) +
			if(l.household_income_identifier <> '', 1, 0) +
			if((unsigned1) l.household_occupation <> 0, 1, 0) +
			if(l.length_of_residence <> '', 1, 0) +
			if((unsigned1) l.mail_responsive_donor_indicator <> 0, 1, 0) +
			if((unsigned1) l.mail_responsive_buyer_indicator <> 0, 1, 0) +
			if(l.telephone <> '', 1, 0) +
			if(l.outdoors_dimension_household, 1, 0) +
			if(l.athletic_dimension_household, 1, 0) +
			if(l.fitness_dimension_household, 1, 0) +
			if(l.domestic_dimension_household, 1, 0) +
			if(l.good_life_dimension_household, 1, 0) +
			if(l.cultural_dimension_household, 1, 0) +
			if(l.blue_chip_dimension_household, 1, 0) +
			if(l.do_it_yourself_dimension_household, 1, 0) +
			if(l.technology_dimension_household, 1, 0) +
			if(l.credit_card_usage_miscellaneous, 1, 0) +
			if(l.credit_card_usage_standard_retail, 1, 0) +
			if(l.credit_card_usage_standard_specialty_card, 1, 0) +
			if(l.credit_card_usage_upscale_retail, 1, 0) +
			if(l.credit_card_usage_upscale_spec_retail, 1, 0) +
			if(l.credit_card_usage_bank_card, 1, 0) +
			if(l.credit_card_usage_oil_gas_card, 1, 0) +
			if(l.credit_card_usage_Finance_Co_Card, 1, 0) +
			if(l.credit_card_usage_Travel_Entertainment, 1, 0);			
		self := l;
	end;		

	#uniquename(inf_royalty_cnt)
	%inf_royalty_cnt% := project(inf, %count_royalties%(left));		

	royal_out := 
		dataset([{
							Royalty.Constants.RoyaltyCode.DMXML,
							Royalty.Constants.RoyaltyType.DMXML,
							sum(%inf_royalty_cnt%(royalty_count>0), royalty_count),
							count(%inf_royalty_cnt%(royalty_count=0))
						 }],Royalty.Layouts.Royalty);					

endmacro;
