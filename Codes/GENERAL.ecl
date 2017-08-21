export GENERAL :=
MODULE
     export VARSTRING DL_PURPOSE(string field2, string code) := 
              CASE(field2,
          'AK' => CASE(code,
																'2'=>'Not Allowed',  
																'4'=>'Not Allowed',  
                                '7'=>'Not Allowed',  
                                ''),
			    'CT' => CASE(code,
                                '7'=>'Not Allowed',  
                                ''),
			    'IL' => CASE(code,
                                '7'=>'Not Allowed',  
                                ''),
			    'KY' => CASE(code,
                                '5'=>'Not Allowed',  
                                ''),
			    'MA' => CASE(code,
                                '7'=>'Not Allowed',  
                                ''),
			    'MD' => CASE(code,
                                '7'=>'Not Allowed',  
                                ''),
			    'MI' => CASE(code,
                                '7'=>'Not Allowed',  
                                ''),
			    'MT' => CASE(code,
                                '5'=>'Not Allowed',  
                                ''),
          'NE' => CASE(code,
                                '7'=>'Not Allowed',  
                                ''),
			    'NM' => CASE(code,
                                '3'=>'Not Allowed',  
																'4'=>'Not Allowed',  
																'7'=>'Not Allowed',  
                                ''),
          'NV' => CASE(code,
                                '3'=>'Not Allowed',  
                                '5'=>'Not Allowed',  
                                '7'=>'Not Allowed',  
                                ''),
					'NY' => CASE(code,
                                '7'=>'Not Allowed',  
                                ''),
          'OR' => CASE(code,
                                '5'=>'Not Allowed',  
                                '7'=>'Not Allowed',  
								'1'=>'Not Allowed',
								'2'=>'Not Allowed',
								'3'=>'Not Allowed',
								'4'=>'Not Allowed',
								'6'=>'Not Allowed',
                                ''),
          'UT' => CASE(code,
                                '7'=>'Not Allowed',  
                                ''),
           'WY' => CASE(code,
                                '7'=>'Not Allowed',  
                                ''),
                  '');

	export VARSTRING GENDER(string code) := MAP(
               code='M'=>'Male',  
			code='F'=>'Female',  
			code='U'=>'Unknown',  
               '');

	export VARSTRING NAME_SUFFIX(string code) := MAP(
               code='1' => '1',  
			code='2' => '2',  
			code='3' => '3',  
			code='4' => '4',  
			code='5' => '5',  
			code='6' => '6',  
			code='I' => '1',  
			code='II' => '2',  
			code='III' => '3',  
			code='IV' => '4',  
			code='JR' => 'J',  
			code='SR' => 'S',  
			code='V' => '5',  
			code='VI' => '6',  
               '');

     export VARSTRING CANADIAN_PROVINCE_LONG(string code) := MAP(
		 code='AB'=>'Alberta',  
		 code='BC'=>'British Columbia',  
		 code='MB'=>'Manitoba',  
		 code='NB'=>'New Brunswick',  
		 code='NL'=>'Newfoundland and Labrador',  
		 code='NT'=>'Northwest Territories',  
		 code='NS'=>'Nova Scotia',  
		 code='NU'=>'Nunavut',  
		 code='ON'=>'Ontario',  
		 code='PE'=>'Prince Edward Island',  
		 code='QC'=>'Quebec',  
		 code='SK'=>'Saskatchewan',  
		 code='YT'=>'Yukon',  
								'');
								
     export VARSTRING STATE_LONG(string code) := MAP(
			code='AL'=>'Alabama',  
			code='AK'=>'Alaska',  
			code='AZ'=>'Arizona',  
			code='AR'=>'Arkansas',  
			code='CA'=>'California',  
			code='CO'=>'Colorado',  
			code='CT'=>'Connecticut',  
			code='DE'=>'Delaware',  
			code='FL'=>'Florida',  
			code='GA'=>'Georgia',  
			code='HI'=>'Hawaii',  
			code='ID'=>'Idaho',  
			code='IL'=>'Illinois',  
			code='IN'=>'Indiana',  
			code='IA'=>'Iowa',  
			code='KS'=>'Kansas',  
			code='KY'=>'Kentucky',  
			code='LA'=>'Louisiana',  
			code='ME'=>'Maine',  
			code='MD'=>'Maryland',  
			code='MA'=>'Massachusetts',  
			code='MI'=>'Michigan',  
			code='MN'=>'Minnesota',  
			code='MS'=>'Mississippi',  
			code='MO'=>'Missouri',  
			code='MT'=>'Montana',  
			code='NE'=>'Nebraska',  
			code='NV'=>'Nevada',  
			code='NH'=>'New Hampshire',  
			code='NJ'=>'New Jersey',  
			code='NM'=>'New Mexico',  
			code='NY'=>'New York',  
			code='NC'=>'North Carolina',  
			code='ND'=>'North Dakota',  
			code='OH'=>'Ohio',  
			code='OK'=>'Oklahoma',  
			code='OR'=>'Oregon',  
			code='PA'=>'Pennsylvania',  
			code='PR'=>'Puerto Rico',  
			code='RI'=>'Rhode Island',  
			code='SC'=>'South Carolina',  
			code='SD'=>'South Dakota',  
			code='TN'=>'Tennessee',  
			code='TX'=>'Texas',  
			code='UT'=>'Utah',  
			code='VT'=>'Vermont',  
			code='VA'=>'Virginia',  
			code='WA'=>'Washington',  
			code='WV'=>'West Virginia',  
			code='WI'=>'Wisconsin',  
			code='WY'=>'Wyoming',  
			code='DC'=>'District of Columbia',
			code='VI'=>'Virgin Islands',
               '');

     export VARSTRING YESNO(string code) := MAP(
			code='Y'=>'Yes',  
			code='N'=>'No',  
			'');

	export checkChanges :=
	FUNCTION
		
	codes.Layout_Codes_V3 trans(codes.File_Codes_V3_in le) :=
		TRANSFORM
			translation := 
				MAP(le.field_name = 'DL-PURPOSE'  =>	DL_PURPOSE(le.field_name2,le.code),
                        le.field_name = 'GENDER'	=>	GENDER(le.code),
                        le.field_name = 'NAME_SUFFIX'	=>	NAME_SUFFIX(le.code),  
				    le.field_name = 'STATE_LONG'	=>	STATE_LONG(le.code),
                        le.field_name = 'YESNO'	=>	YESNO(le.code),
				    '');
				  
			SELF.code := IF(le.long_desc=translation,SKIP,le.code);
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='GENERAL'),trans(LEFT));
	RETURN p;
		
	END;

END; 