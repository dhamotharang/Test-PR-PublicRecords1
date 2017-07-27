export BogusCities(string city_field, string state_field) := 
	(
	(city_field = 'OZ' and state_field = 'GA') or
	(city_field = 'FANTASY ISLAND') or
	//Handled differently because "29 Palms" is a valid city in California
	((regexfind('[0-9]',city_field) and ~regexfind('[A-Z]',city_field)) or (integer)state_field<>0)
	);