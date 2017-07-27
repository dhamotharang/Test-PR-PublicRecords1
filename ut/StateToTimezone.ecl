// Given a state this function returns the numerical timezone that can then be passed
// into ut.TimeZone_Convert to handle daylight savings.

// ** NOTE: There are several states which contain multiple timezones, for these states the
// timezone with the largest representation in the Telcordia TDS file is used as this timezone
// is likely more populated.

EXPORT StateToTimezone (STRING2 St) := FUNCTION
	State := StringLib.StringToUpperCase(TRIM(St));
	timezone := CASE(State,
										'AB' => 5,
										'AI' => 8,
										'AK' => 3, // **
										'AL' => 6, // **
										'AN' => 8,
										'AR' => 6,
										'AS' => 2,
										'AZ' => 5,
										'BA' => 7,
										'BC' => 4, // **
										'BD' => 8,
										'BM' => 8,
										'BV' => 8,
										'CA' => 4,
										'CO' => 5,
										'CQ' => 7,
										'CT' => 7,
										'DC' => 7,
										'DE' => 7,
										'DM' => 8,
										'DR' => 8,
										'FL' => 7, // **
										'GA' => 7,
										'GN' => 8,
										'GU' => 1,
										'HI' => 2,
										'IA' => 6,
										'ID' => 5, // **
										'IL' => 6,
										'IN' => 7, // **
										'JM' => 7,
										'KA' => 8,
										'KS' => 6, // **
										'KY' => 7, // **
										'LA' => 6,
										'MA' => 7,
										'MB' => 6,
										'MD' => 7,
										'ME' => 7,
										'MI' => 7, // **
										'MN' => 6,
										'MO' => 6,
										'MS' => 6,
										'MT' => 5,
										'NB' => 8,
										'NC' => 7,
										'ND' => 6, // **
										'NE' => 6, // **
										'NF' => 9, // **
										'NH' => 7,
										'NJ' => 7,
										'NM' => 5,
										'NN' => 1,
										'NS' => 8,
										'NT' => 5,
										'NV' => 4,
										'NY' => 7,
										'OH' => 7,
										'OK' => 6,
										'ON' => 7, // **
										'OR' => 4, // **
										'PA' => 7,
										'PE' => 8,
										'PQ' => 7, // **
										'PR' => 8,
										'RI' => 7,
										'RT' => 8,
										'SA' => 8,
										'SC' => 7,
										'SD' => 6, // **
										'SK' => 6, // **
										'TC' => 7,
										'TN' => 6, // **
										'TR' => 8,
										'TX' => 6, // **
										'UT' => 5,
										'VA' => 7,
										'VI' => 8,
										'VT' => 7,
										'VU' => 7, // **
										'WA' => 4,
										'WI' => 6,
										'WV' => 7,
										'WY' => 5,
										'YT' => 4,
										'ZF' => 8,
														0);

	RETURN(timezone);
END;