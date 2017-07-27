import ut;

pi_coefficient_layout := record
	string2 state;
	string5 fips_code;
	string1 land_use;
	real coef1_Ofheo;
	real coef2_MSP;
end;

export File_PI_Coefficients := dataset('~thor_data400::in::avm_pi_coefficients', pi_coefficient_layout, csv(heading(3)));