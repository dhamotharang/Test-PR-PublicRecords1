export Layout_ClickData_Out_Ext := record
	Layout_ClickData_Out;
	string2	age; 
	string1	gender;   
	string1	marital_status; // 0 - not available, 1 - hh w/ married person, 2 - hh w/ single person, 3 - hh w/ single & married person
  string1	number_of_adults_in_household; 
	string1	number_of_children_in_household; 
	string1	dwelling_type; // 0 - not available, 1 - single, 2-7 - multiple
	string1	home_ownerrenter_code; // 0 - no info, 1 - renter, 2 - probable renter, 3 - probable owner, 4 - owner
  string1	household_income_identifier; // 1 - 0-14K, 2 - 15K-19K, 3 - 20K-29K, etc.
	string2	household_occupation; // 0 - not available, 10 - tecnhical, 11 - doctors, 12 - Lawyers, 13 - Teachers, 20 - Administrative, etc...
  string1	length_of_residence; // A - 06 months, B - 07-12 months, C - 13-18 months, D - 19-24 months, E - 3rd year, F - 4th year, etc.
	String1	mail_responsive_donor_indicator; // 0 - no info, 1 - single mail donor, 2 - multiple mail donor
	String1	mail_responsive_buyer_indicator; // 0 - no info, 1 - single mail buyer, 2 - multiple mail buyer	
	string10 telephone; 	
	boolean outdoors_dimension_household; 
	boolean athletic_dimension_household;
	boolean fitness_dimension_household;
	boolean domestic_dimension_household;
	boolean good_life_dimension_household;
	boolean cultural_dimension_household;
	boolean blue_chip_dimension_household;
	boolean do_it_yourself_dimension_household;
	boolean technology_dimension_household;	
	boolean credit_card_usage_miscellaneous;
	boolean credit_card_usage_standard_retail;
	boolean credit_card_usage_standard_specialty_card;
	boolean credit_card_usage_upscale_retail;
	boolean credit_card_usage_upscale_spec_retail;
	boolean credit_card_usage_bank_card;
	boolean credit_card_usage_oil_gas_card;
	boolean credit_card_usage_Finance_Co_Card;
	boolean credit_card_usage_Travel_Entertainment;
	boolean enhanced_srch;
end; 
