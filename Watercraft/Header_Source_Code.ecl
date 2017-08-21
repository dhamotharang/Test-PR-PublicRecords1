export string2 Header_Source_Code(string pSource, string2 pState) 
 :=	if(pSource='CG','CG',
			if(pSource='W1','W1',
       case(pState,
		'AK'	=> '#W',
		'AL'	=> 'LW',
		'AR'	=> 'RW',
		'AZ'	=> 'ZW',
		'CO'	=> 'CW',
		'CT'	=> 'EW',
		'GA'	=> 'GW',
		'IA'	=> 'IW',
		'IL'	=> 'PW',
		'KS'	=> 'HW',
		'MA'	=> 'JW',
		'MD'	=> 'DW',
		'ME'	=> 'QW',
		'MI'	=> 'XW',
		'MN'	=> '1W',
		'MS'	=> '2W',
		'MT'	=> '3W',
		'NC'	=> 'NW',
		'ND'	=> '4W',
		'NE'	=> '5W',
		'NH'	=> '6W',
		'NM'  => 'W2',
		'NV'	=> '7W',
		'NY'	=> 'YW',
		'OH'	=> 'OW',
		'OR'	=> '8W',
		'SC'	=> 'SW',
		'TN'	=> 'TW',
		'TX'	=> '[W',
		'UT'	=> '9W',
		'VA'	=> 'VW',
		'WI'	=> 'WW',
		'WV'	=> '!W',
		'WY'	=> '@W',
		'FL'	=> 'FW',
		'MO'	=> 'BW',
		'KY'	=> 'KW',
		'WA'  => '%W',
		//'CG'	=> 'CG',
		'FV'	=> '^W',
		''
	   )));
