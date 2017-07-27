#warning('Deprecated. Use Royalty.RoyaltyDMXML instead')
// --------------------------------------------------------------------
// Royalty counter will be incremented for every DM/TotalSource field returned
//
export mac_best_royalties(best_recs, royalties) := MACRO

	#uniquename(layout_royalty_count)
	%layout_royalty_count% := record
		recordof(best_recs);
		unsigned1 royalty_count;
	end;

	#uniquename(calculate_royalties)
	%layout_royalty_count% %calculate_royalties%(best_recs l) := transform
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

	#uniquename(best_plus_royalties)
	%best_plus_royalties% := project(best_recs, %calculate_royalties%(left));	
	
	#uniquename(layout_royalties)
	%layout_royalties% := RECORD
		string 		Royalty_Type;
		unsigned 	royalty_count;
		unsigned 	non_royalty_count;
	END;			
	
	royalties := dataset([{'DMXML',sum(%best_plus_royalties%(royalty_count>0), royalty_count),count(%best_plus_royalties%(royalty_count=0))}],
												doxie_LN.layout_royalties);	

ENDMACRO;
