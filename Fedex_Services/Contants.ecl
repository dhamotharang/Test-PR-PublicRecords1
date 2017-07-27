export Contants := 
MODULE

export ScoreThreshold := 8;  //this allows max penalty of 7, which is what a leading lname generates

export max_results := 10;
export max_FedexSourcedResults := 3;
export max_FedexSourcedResultsAdmin := 100;
export max_FedexSourcedResultsAdminMax := 1000;

export min_LengthPhoneInput := 10;		//if this number decreases, consider setting AllowGongFallBack to true
export min_LengthLnameInput	:= 4;
export min_BusinessSearchScore := 41;

export AllowGongFallBack := false;		//this turns off the gong feature that allows for 7 digit match when no 10 digit match is found

export autokey_skipset := ['Z','-'];

export str_Business := 'Business';
export str_Residential := 'Residential';
export str_US := 'US';
export str_CA := 'CA';

export internal_src_header 				:= 'H';
export internal_src_gong 					:= 'G';
export internal_src_gong_patched 	:= 'P';
export internal_src_phonesplus 		:= '+';
export internal_src_business 			:= 'B';
export internal_src_canada	 			:= 'C';
export internal_src_fedexNoHit	 	:= 'F';

export PreferStrictMatch := true; // return only exact matches (no penalty), if any, otherwise return all records found.

END;