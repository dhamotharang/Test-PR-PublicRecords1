export string50 geo_desc(string1 geo_match) := case(
	geo_match,
	'0' => 'Matched in address level',
	'1' => '9-digit match in Centroid',
	'4' => '7-digit match in Centroid',
	'5' => '5-digit match in Centroid',
	'7' => 'No match in Centroid',
	'8' => 'Not matched in Address level',
	'9' => 'Both options tried, but no match in either',
	''  => 'Not tried',
	'unknown'
);