import STD;
export unicode St2Name(unicode state) := 
CASE(STD.Uni.FilterOut(STD.Uni.ToUpperCase(state),'.'),
'AL' => 'ALABAMA',
'AK' => 'ALASKA', 
'AR' => 'ARKANSAS', 
'AS' => 'AMERICAN SAMOA', 
'AZ' => 'ARIZONA', 
'CA' => 'CALIFORNIA', 
'CO' => 'COLORADO', 
'CT' => 'CONNECTICUT', 
'DC' => 'DISTRICT OF COLUMBIA', 
'DE' => 'DELAWARE', 
'FL' => 'FLORIDA', 
'GA' => 'GEORGIA', 
'GU' => 'GUAM', 
'HI' => 'HAWAII', 
'IA' => 'IOWA', 
'ID' => 'IDAHO', 
'IL' => 'ILLINOIS', 
'IN' => 'INDIANA', 
'KS' => 'KANSAS', 
'KY' => 'KENTUCKY', 
'LA' => 'LOUISIANA', 
'MA' => 'MASSACHUSETTS', 
'MD' => 'MARYLAND', 
'ME' => 'MAINE' , 
'MI' => 'MICHIGAN', 
'MN' => 'MINNESOTA', 
'MO' => 'MISSOURI', 
'MS' => 'MISSISSIPPI', 
'MT' => 'MONTANA', 
'NC' => 'NORTH CAROLINA', 
'ND' => 'NORTH DAKOTA', 
'NE' => 'NEBRASKA', 
'NH' => 'NEW HAMPSHIRE', 
'NJ' => 'NEW JERSEY', 
'NM' => 'NEW MEXICO', 
'NV' => 'NEVADA', 
'NY' => 'NEW YORK', 
'OH' => 'OHIO', 
'OK' => 'OKLAHOMA', 
'OR' => 'OREGON', 
'PA' => 'PENNSYLVANIA', 
'PR' => 'PUERTO RICO', 
'RI' => 'RHODE ISLAND', 
'SC' => 'SOUTH CAROLINA', 
'SD' => 'SOUTH DAKOTA', 
'TN' => 'TENNESSEE', 
'TX' => 'TEXAS', 
//	state = 'US' => 'UNITED STATES', 
'UT' => 'UTAH', 
'VA' => 'VIRGINIA', 
'VI' => 'VIRGIN ISLANDS', 
'VT' => 'VERMONT', 
'WA' => 'WASHINGTON', 
'WI' => 'WISCONSIN', 
'WV' => 'WEST VIRGINIA', 
'WY' => 'WYOMING',
    state);