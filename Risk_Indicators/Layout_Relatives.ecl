
export Layout_Relatives :=
RECORD
	UNSIGNED1 relative_count;
	UNSIGNED1 relative_bankrupt_count;
	// # of 1st degree relatives w/ unreleased judgements less than 2 yrs
	// # of 1st degree relatives w/ unreleased judgements greater than 2 yrs
	// # of 1st degree relatives w/ released judgements less than 2 yrs
	// # of 1st degree relatives w/ released judgements greater than 2 yrs
	UNSIGNED1 relative_criminal_count;
	UNSIGNED1 relative_criminal_total;
	UNSIGNED1 relative_felony_count;
	UNSIGNED1 relative_felony_total;
	UNSIGNED1 criminal_relative_within25miles;
	UNSIGNED1 criminal_relative_within100miles;
	UNSIGNED1 criminal_relative_within500miles;
	UNSIGNED1 criminal_relative_withinOther;
	Layout_Relatives_Property_Values;

	/* *********** Census related aggregates *************** */
	UNSIGNED1 relative_within25miles_count;
	UNSIGNED1 relative_within100miles_count;
	UNSIGNED1 relative_within500miles_count;
	UNSIGNED1 relative_withinOther_count;
	
	UNSIGNED1 relative_incomeUnder25_count;
	UNSIGNED1 relative_incomeUnder50_count;
	UNSIGNED1 relative_incomeUnder75_count;
	UNSIGNED1 relative_incomeUnder100_count;
	UNSIGNED1 relative_incomeOver100_count;

	UNSIGNED1 relative_homeUnder50_count;
	UNSIGNED1 relative_homeUnder100_count;
	UNSIGNED1 relative_homeUnder150_count;
	UNSIGNED1 relative_homeUnder200_count;
	UNSIGNED1 relative_homeUnder300_count;
	UNSIGNED1 relative_homeUnder500_count;
	UNSIGNED1 relative_homeOver500_count;
		
	UNSIGNED1 relative_educationUnder8_count;
	UNSIGNED1 relative_educationUnder12_count;
	UNSIGNED1 relative_educationOver12_count;
	
	UNSIGNED1 relative_ageUnder20_count;
	UNSIGNED1 relative_ageUnder30_count;
	UNSIGNED1 relative_ageUnder40_count;
	UNSIGNED1 relative_ageUnder50_count;
	UNSIGNED1 relative_ageUnder60_count;
	UNSIGNED1 relative_ageUnder70_count;
	UNSIGNED1 relative_ageOver70_count;
	
	unsigned1 relative_vehicle_owned_count;
	unsigned1 relatives_at_input_address;
	
	unsigned1 relative_suspicious_identities_count;
	unsigned1 relative_bureau_only_count;
	unsigned1 relative_bureau_only_count_created_1month;
	unsigned1 relative_bureau_only_count_created_6months;	
END;