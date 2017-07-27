// -- ACE U.S. address status codes

export Error_Codes(

	string pErr_stat

) :=
function

	// -- 1st character
	firstchar := map(
			 trim(pErr_stat)[1] = 'A'	=> 'ACE had to truncate the address line to make it fit into your field.'
			,trim(pErr_stat)[1] = 'B'	=> 'ACE truncated both the address line and the city name.'
			,trim(pErr_stat)[1] = 'C'	=> 'ACE had to truncate the city name to make it fit into your field.'
			,trim(pErr_stat)[1] = 'S'	=> 'ACE didn’t truncate anything.'
			,					'first character not recognized'
		);

	// -- 2nd character
	secondchar := map(
			 trim(pErr_stat)[2] = '0'	=> 'Regarding the city, state, ZIP, and ZIP+4, there is no significant difference between the input data and the data that ACE assigned.'
			,trim(pErr_stat)[2] = '1'	=> 'ACE assigned a different ZIP.' 
			,trim(pErr_stat)[2] = '2'	=> 'ACE assigned a different city.'
			,trim(pErr_stat)[2] = '3'	=> 'ACE assigned a different city and ZIP.' 
			,trim(pErr_stat)[2] = '4'	=> 'ACE assigned a different state.' 
			,trim(pErr_stat)[2] = '5'	=> 'ACE assigned a different state and ZIP.'
			,trim(pErr_stat)[2] = '6'	=> 'ACE assigned a different city and state. '
			,trim(pErr_stat)[2] = '7'	=> 'ACE assigned a different city, state, and ZIP.' 
			,trim(pErr_stat)[2] = '8'	=> 'ACE assigned a different ZIP+4.'
			,trim(pErr_stat)[2] = '9'	=> 'ACE assigned a different ZIP and ZIP+4.'
			,trim(pErr_stat)[2] = 'A'	=> 'ACE assigned a different city and ZIP+4.'
			,trim(pErr_stat)[2] = 'B'	=> 'ACE assigned a different city, ZIP, and ZIP+4.'
			,trim(pErr_stat)[2] = 'C'	=> 'ACE assigned a different state and ZIP+4.'
			,trim(pErr_stat)[2] = 'D'	=> 'ACE assigned a different state, ZIP, and ZIP+4.'
			,trim(pErr_stat)[2] = 'E'	=> 'ACE assigned a different city, state, and ZIP+4.'
			,trim(pErr_stat)[2] = 'F'	=> 'ACE assigned a different city, state, ZIP and ZIP+4.'
			,					'second character not recognized'
		);

	// -- 3rd character
	thirdchar := map(
			 trim(pErr_stat)[3] = '0'	=> 'Regarding the primary name, directionals, and suffix, there is no significant difference between the input and what ACE assigned.'
			,trim(pErr_stat)[3] = '1'	=> 'ACE assigned a different suffix.'
			,trim(pErr_stat)[3] = '2'	=> 'ACE assigned a different predirectional.' 
			,trim(pErr_stat)[3] = '3'	=> 'ACE assigned a different predirectional and suffix.'
			,trim(pErr_stat)[3] = '4'	=> 'ACE assigned a different postdirectional.'
			,trim(pErr_stat)[3] = '5'	=> 'ACE assigned a different suffix and postdirectional.'
			,trim(pErr_stat)[3] = '6'	=> 'ACE assigned a different predirectional and postdirectional.'
			,trim(pErr_stat)[3] = '7'	=> 'ACE assigned a different predirectional, suffix, and postdirectional.'
			,trim(pErr_stat)[3] = '8'	=> 'ACE assigned a different primary name.'
			,trim(pErr_stat)[3] = '9'	=> 'ACE assigned a different primary name and suffix.'
			,trim(pErr_stat)[3] = 'A'	=> 'ACE assigned a different predirectional and primary name.'
			,trim(pErr_stat)[3] = 'B'	=> 'ACE assigned a different predirectional, primary name, and suffix.'
			,trim(pErr_stat)[3] = 'C'	=> 'ACE assigned a different primary name and postdirectional.'
			,trim(pErr_stat)[3] = 'D'	=> 'ACE assigned a different primary name, suffix, and postdirectional.'
			,trim(pErr_stat)[3] = 'E'	=> 'ACE assigned a different predirectional, primary name, and postdirectional.'
			,trim(pErr_stat)[3] = 'F'	=> 'ACE assigned a different predirectional, primary name, postdirectional, and suffix.'
			,					'third character not recognized'
		);

	// -- 4th character
	fourthchar := map(
			 trim(pErr_stat)[4] = '0'	=> 'Regarding the county number, CART (carrier-route number), DPBC, and unit designator, there is no significant difference between the input data and the data that ACE assigned.'
			,trim(pErr_stat)[4] = '1'	=> 'ACE assigned a different unit designator.'
			,trim(pErr_stat)[4] = '2'	=> 'ACE assigned a different DPBC.'
			,trim(pErr_stat)[4] = '3'	=> 'ACE assigned a different DPBC and unit designator.'
			,trim(pErr_stat)[4] = '4'	=> 'ACE assigned a different CART.'
			,trim(pErr_stat)[4] = '5'	=> 'ACE assigned a different CART and unit designator.'
			,trim(pErr_stat)[4] = '6'	=> 'ACE assigned a different CART and DPBC.'
			,trim(pErr_stat)[4] = '7'	=> 'ACE assigned a different CART, DPBC, and unit designator.'
			,trim(pErr_stat)[4] = '8'	=> 'ACE assigned a different county number.'
			,trim(pErr_stat)[4] = '9'	=> 'ACE assigned a different county number and unit designator.'
			,trim(pErr_stat)[4] = 'A'	=> 'ACE assigned a different county number and DPBC.'
			,trim(pErr_stat)[4] = 'B'	=> 'ACE assigned a different county number, DPBC, and unit designator.'
			,trim(pErr_stat)[4] = 'C'	=> 'ACE assigned a different county number and CART.'
			,trim(pErr_stat)[4] = 'D'	=> 'ACE assigned a different county number, CART, and unit designator.'
			,trim(pErr_stat)[4] = 'E'	=> 'ACE assigned a different county number, CART, and DPBC.'
			,trim(pErr_stat)[4] = 'F'	=> 'ACE assigned a different county number, CART, DPBC, and unit designator.'
			,					'fourth character not recognized'
		);


	// -- ACE address error codes
	error_codes := map(
			 trim(pErr_stat) = 'E101'	=> 'Last line is bad or missing'
			,trim(pErr_stat) = 'E212'	=> 'No city and bad ZIP/postal code' 
			,trim(pErr_stat) = 'E213'	=> 'Bad city, valid state/province, and no ZIP/postal code'
			,trim(pErr_stat) = 'E214'	=> 'Bad city and bad ZIP/postal code '
			,trim(pErr_stat) = 'E216'	=> 'Bad ZIP, can’t determine which city match to select'
			,trim(pErr_stat) = 'E302'	=> 'No primary address line parsed' 
			,trim(pErr_stat) = 'E412'	=> 'Street name not found in directory' 
			,trim(pErr_stat) = 'E413'	=> 'Possible street-name matches too close to choose one'
			,trim(pErr_stat) = 'E420'	=> 'Primary range is missing' 
			,trim(pErr_stat) = 'E421'	=> 'Primary range is invalid for the street/route/building'
			,trim(pErr_stat) = 'E422'	=> 'Predirectional needed, input is wrong or missing'
			,trim(pErr_stat) = 'E423'	=> 'Suffix needed, input is wrong or missing'
			,trim(pErr_stat) = 'E425'	=> 'Suffix and directional needed, input is wrong or missing'
			,trim(pErr_stat) = 'E427'	=> '[Post] Directional needed, input is wrong or missing'
			,trim(pErr_stat) = 'E428'	=> 'Bad ZIP, can’t select an address match' 
			,trim(pErr_stat) = 'E429'	=> 'Bad city, can’t select an address match' 
			,trim(pErr_stat) = 'E430'	=> 'Possible address-line matches too close to choose one'
			,trim(pErr_stat) = 'E431'	=> 'Urbanization needed, input is wrong or missing'
			,trim(pErr_stat) = 'E439'	=> 'Exact match made in EWS directory'
			,trim(pErr_stat) = 'E500'	=> 'Other error'
			,trim(pErr_stat) = 'E501'	=> 'Foreign address'
			,trim(pErr_stat) = 'E502'	=> 'Input record entirely blank'
			,trim(pErr_stat) = 'E503'	=> 'ZIP not in area covered by partial ZIP+4 directory'
			,trim(pErr_stat) = 'E504'	=> 'Overlapping ranges in ZIP+4 directory'
			,trim(pErr_stat) = 'E505'	=> 'Address does not exist in the USPS directories, undeliverable address.'
			,trim(pErr_stat) = 'E600'	=> 'Marked by USPS as unsuitable for delivery of mail'
			,															firstchar + '\n' + secondchar + '\n' + thirdchar + '\n' + fourthchar
	);   

	return error_codes;

end;