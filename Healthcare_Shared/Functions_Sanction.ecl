EXPORT Functions_Sanction := MODULE


	EXPORT fn_SetActSancType(STRING sanc_code) := FUNCTION
			sanc_type_oig_codes    := ['1128a3',  '1128b1',  '1128b1A', '1128b1B', '1128b2',  '1128b6',  '1128b7',   '1128b4',
																'1128',    '1128a1',  '1128b5',  '1128c3a', '1128c3b', '1128a2',  '1128a4',   '1128b3',
																'1128b9',  '1128b12', '1128Aa',  '1128b8',  '1128b8A', '1128b10', '1128b11',  '1128b13',
																'1128b14', '1128b15', '1892',    '1156',    '1156b',   '1160',    'BRCH CIA', 'BRCH SA'];
			sanc_type_state_codes  := ['112eS',   '111L',    '112dS',   '112cS',    'CandD',  'NONDISC', '112aS',    '112bS',
																'113R',    'SME',     'SMR'];
			sanc_type_opm_codes    := ['b5'];
			
			sanc_type := MAP(sanc_code in sanc_type_opm_codes => 'OPM',
											 sanc_code in sanc_type_state_codes => 'State',
											 sanc_code in sanc_type_oig_codes => 'OIG',
											 '');
															
			return sanc_type;																	
			
	END;

	EXPORT fn_SetActSancCategory(STRING sanc_code) := FUNCTION
			sanc_cat_fraud_codes   := ['112eS',  '1128a3',  '1128b1',  '1128b1A', '1128b1B',  '1128b2', '1128b6', '1128b7'];
			sanc_cat_license_codes := ['111L',   '1128b4'];
			sanc_cat_program_codes := ['1128',   '1128a1',  '1128b5',  '1128c3a', '1128c3b',  'b5',     'SME'];
			sanc_cat_quality_codes := ['112dS',  '1128a2'];
			sanc_cat_rx_codes      := ['112cS',  '1128a4',  '1128b3'];
			sanc_cat_other_codes   := ['1128b9', '1128b12', 'OTHER',   'CandD',   'NONDISC',  '112aS',   '112bS', '1128Aa',
																'1128b8', '1128b8A', '1128b10', '1128b11', '1128b13',  '1128b14', '1128b15',
																'1156',   '1156b',   '1160',    '1892',    'BRCH CIA', 'BRCH SA'];
			sanc_cat_rein_codes    := ['113R',   'SMR'];
			
			sanc_cat := MAP(sanc_code in sanc_cat_fraud_codes => 1,
													sanc_code in sanc_cat_license_codes => 2,
													sanc_code in sanc_cat_program_codes => 4,
													sanc_code in sanc_cat_rx_codes => 8,
													sanc_code in sanc_cat_quality_codes => 16,
													sanc_code in sanc_cat_other_codes => 32,
													sanc_code in sanc_cat_rein_codes => 64,
													32);
		return sanc_cat;
		
	END;
	
END;