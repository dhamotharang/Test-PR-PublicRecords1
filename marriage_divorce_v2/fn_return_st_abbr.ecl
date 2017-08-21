export fn_return_st_abbr(string long_desc) := function

string50 v_abbr := case(long_desc,
'ALASKA'               => 'AK',
'ALABAMA'              => 'AL',
'ARKANSAS'             => 'AR',
'ARIZONA'              => 'AZ',
'CALIFORNIA'           => 'CA',
'COLORADO'             => 'CO',
'CONNECTICUT'          => 'CT',
'DISTRICT OF COLUMBIA' => 'DC',
'DELAWARE'             => 'DE',
'FLORIDA'              => 'FL',
'GEORGIA'              => 'GA',
'HAWAII'               => 'HI',
'IOWA'                 => 'IA',
'IDAHO'                => 'ID',
'ILLINOIS'             => 'IL',
'INDIANA'              => 'IN',
'KANSAS'               => 'KS',
'KENTUCKY'             => 'KY',
'LOUISIANA'            => 'LA',
'MASSACHUSETTS'        => 'MA',
//known mis-spelling in the ln-xml data
'MASSACHSETTS'         => 'MA',
'MARYLAND'             => 'MD',
'MAINE'                => 'ME',
'MICHIGAN'             => 'MI',
'MINNESOTA'            => 'MN',
'MISSOURI'             => 'MO',
'MISSISSIPPI'          => 'MS',
'MONTANA'              => 'MT',
'NORTH CAROLINA'       => 'NC',
'NORTH DAKOTA'         => 'ND',
'NEBRASKA'             => 'NE',
'NEW HAMPSHIRE'        => 'NH',
'NEW JERSEY'           => 'NJ',
'NEW MEXICO'           => 'NM',
'NEVADA'               => 'NV',
'NEW YORK'             => 'NY',
'OHIO'                 => 'OH',
'OKLAHOMA'             => 'OK',
'OREGON'               => 'OR',
'PENNSYLVANIA'         => 'PA',
'RHODE ISLAND'         => 'RI',
'SOUTH CAROLINA'       => 'SC',
'SOUTH DAKOTA'         => 'SD',
'TENNESSEE'            => 'TN',
//known mis-spelling in the ln-xml data
'TENNEESSEE'           => 'TN',
'TEXAS'                => 'TX',
'UTAH'                 => 'UT',
'VIRGINIA'             => 'VA',
'VIRGIN ISLANDS'       => 'VI',
'VERMONT'              => 'VT',
'WASHINGTON'           => 'WA',
'WISCONSIN'            => 'WI',
'WEST VIRGINIA'        => 'WV',
'WYOMING'              => 'WY',
'CUBA'                 => 'CU',
'GUAM'                 => 'GU',
'CANADA'               => 'CN',
'MEXICO'               => 'MX',
'PUERTO RICO'          => 'PR',
'UNKNOWN'              => '',
'REMAINDER OF WORLD'   => '',
long_desc
);

return v_abbr;

end;