layout_lkp_SSA_state_cntry_cd
 :=
  RECORD
		string2 ST_COUNTRY_CODE;
		string2	LN_ST_COUNTRY_CODE;
  end
 ;
 
 export lkp_SSA_state_cntry_cd
 :=
  dataset([
		{'01', 'AL'},
		{'02', 'AK'},
		{'03', 'AZ'},
		{'04', 'AR'},
		{'05', 'CA'},
		{'06', 'CO'},
		{'07', 'CT'},
		{'08', 'DE'},
		{'09', 'DC'},
		{'10', 'FL'},
		{'11', 'GA'},
		{'12', 'HI'},
		{'13', 'ID'},
		{'14', 'IL'},
		{'15', 'IN'},
		{'16', 'IA'},
		{'17', 'KS'},
		{'18', 'KY'},
		{'19', 'LA'},
		{'20', 'ME'},
		{'21', 'MD'},
		{'22', 'MA'},
		{'23', 'MI'},
		{'24', 'MN'},
		{'25', 'MS'},
		{'26', 'MO'},
		{'27', 'MT'},
		{'28', 'NE'},
		{'29', 'NV'},
		{'30', 'NH'},
		{'31', 'NJ'},
		{'32', 'NM'},
		{'33', 'NY'},
		{'34', 'NC'},
		{'35', 'ND'},
		{'36', 'OH'},
		{'37', 'OK'},
		{'38', 'OR'},
		{'39', 'PA'},
		{'40', 'PR'},
		{'41', 'RI'},
		{'42', 'SC'},
		{'43', 'SD'},
		{'44', 'TN'},
		{'45', 'TX'},
		{'46', 'UT'},
		{'47', 'VT'},
		{'48', 'VI'},
		{'49', 'VA'},
		{'50', 'WA'},
		{'51', 'WV'},
		{'52', 'WI'},
		{'53', 'WY'},
		{'54', 'AF'}, //Africa
		{'55', 'AA'}, //Asia
		{'56', 'CN'}, //Canada
		{'57', 'CW'}, //Central America & West Indies
		{'58', 'EU'}, //Europe
		{'59', 'MX'}, //Mexico
		{'60', 'OC'}, //Oceania
		{'61', 'PI'}, //Philippine Islands
		{'62', 'SA'}, //South America
		{'63', 'OT'}, //Other - AREAS UNDER U.S. ADMINISTRATION:CANAL ZONE, CANTON ISLANDS, CAROLINE ISLANDS, MARIANA ISLANDS (OTHER THAN GUAM), MARSHALL ISLANDS, MIDWAY ISLANDS, WAKE ISLANDS)
		{'64', 'AS'}, //American Samoa
		{'65', 'GU'}  //Guam
	],layout_lkp_SSA_state_cntry_cd
);