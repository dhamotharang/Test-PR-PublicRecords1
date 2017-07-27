/* filtering returned fields based on data package settings */

outrec := ClickData.Layout_ClickData_Out_Ext;

export fn_filter_demographics(dataset(outrec) recs, string1 dpe /* data package enhancement */) := 
function

	// Package enhancements are cumulative. Enhancement D includes C which includes B. 
	// Enhancement A can be ignored here as it is just Click data with no demographics.	
  includeEnhB := dpe in ['B','C','D'];
  includeEnhC := dpe in ['C','D'];
  includeEnhD := dpe in ['D'];
	
	outrec filter_demographics(outrec l) := transform
	
		// ENHANCEMENT B,C AND D only
		self.age := if(includeEnhB, L.age, '');
		self.gender := if(includeEnhB, L.gender, '');
		self.marital_status := if(includeEnhB, L.marital_status, '');
		self.household_income_identifier := if(includeEnhB, L.household_income_identifier, '');
		self.home_ownerrenter_code := if(includeEnhB, L.home_ownerrenter_code, '');
		
		// ENHANCEMENT C AND D only
		self.number_of_children_in_household := if(includeEnhC, L.number_of_children_in_household, '');
		self.dwelling_type := if(includeEnhC, L.dwelling_type, '');
		self.telephone := if(includeEnhC, L.telephone, '');	
		self.length_of_residence := if(includeEnhC, L.length_of_residence, '');
		self.household_occupation := if(includeEnhC, L.household_occupation, '');
		
		// ENHANCEMENT C only
		self.number_of_adults_in_household := if(includeEnhD, L.number_of_adults_in_household, '');
		self.mail_responsive_donor_indicator := if(includeEnhD, L.mail_responsive_donor_indicator, '');
		self.mail_responsive_buyer_indicator := if(includeEnhD, L.mail_responsive_buyer_indicator, '');						
		self.outdoors_dimension_household := if(includeEnhD, L.outdoors_dimension_household, false);
		self.athletic_dimension_household := if(includeEnhD, L.athletic_dimension_household, false);
		self.fitness_dimension_household 	:= if(includeEnhD, L.fitness_dimension_household, false);
		self.domestic_dimension_household := if(includeEnhD, L.domestic_dimension_household, false);
		self.good_life_dimension_household := if(includeEnhD, L.good_life_dimension_household, false);
		self.cultural_dimension_household := if(includeEnhD, L.cultural_dimension_household, false);
		self.blue_chip_dimension_household := if(includeEnhD, L.blue_chip_dimension_household, false);
		self.do_it_yourself_dimension_household := if(includeEnhD, L.do_it_yourself_dimension_household, false);
		self.technology_dimension_household := if(includeEnhD, L.technology_dimension_household, false);
		self.credit_card_usage_miscellaneous := if(includeEnhD, L.credit_card_usage_miscellaneous, false);
		self.credit_card_usage_standard_retail := if(includeEnhD, L.credit_card_usage_standard_retail, false);
		self.credit_card_usage_standard_specialty_card := if(includeEnhD, L.credit_card_usage_standard_specialty_card, false);
		self.credit_card_usage_upscale_retail := if(includeEnhD, L.credit_card_usage_upscale_retail, false);
		self.credit_card_usage_upscale_spec_retail := if(includeEnhD, L.credit_card_usage_upscale_spec_retail, false);
		self.credit_card_usage_bank_card := if(includeEnhD, L.credit_card_usage_bank_card, false);
		self.credit_card_usage_oil_gas_card := if(includeEnhD, L.credit_card_usage_oil_gas_card, false);
		self.credit_card_usage_Finance_Co_Card :=	if(includeEnhD, L.credit_card_usage_Finance_Co_Card, false);
		self.credit_card_usage_Travel_Entertainment := if(includeEnhD, L.credit_card_usage_Travel_Entertainment, false);		
		
		self := l;	
		
	end;

	out_recs := project(recs, filter_demographics(left));

	return out_recs;
end;