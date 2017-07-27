import ut;

accuracy_layout := record
	string5 fips_code;
	string1 land_use;	
	
	unsigned assessed_valuations_count;
	real overall_assessed_accuracy;
	integer assessed_bin1_cap;
	integer assessed_bin2_cap;
	integer assessed_bin3_cap;
	real assessed_bin1_accuracy;
	real assessed_bin2_accuracy;
	real assessed_bin3_accuracy;
	real assessed_bin4_accuracy;
	
	unsigned market_valuations_count;
	real overall_market_accuracy;
	real market_bin1_accuracy;
	real market_bin2_accuracy;
	real market_bin3_accuracy;
	real market_bin4_accuracy;
	integer market_bin1_cap;
	integer market_bin2_cap;
	integer market_bin3_cap;
	
	unsigned PI_valuations_count;
	real overall_PI_accuracy;
	real PI_bin1_accuracy;
	real PI_bin2_accuracy;
	real PI_bin3_accuracy;
	real PI_bin4_accuracy;
	real PI_bin1_cap;
	real PI_bin2_cap;
	real PI_bin3_cap;
	
	unsigned hedonic_valuations_count;
	real overall_hedonic_accuracy;
	real hedonic_bin1_accuracy;
	real hedonic_bin2_accuracy;
	real hedonic_bin3_accuracy;
	real hedonic_bin4_accuracy;
	real hedonic_bin1_cap;
	real hedonic_bin2_cap;
	real hedonic_bin3_cap;
	
end;

export File_Model_Accuracy_Table := dataset('~thor_data400::in::avm::model_accuracy', accuracy_layout, csv(heading(single), quote('"')) );