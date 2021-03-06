export string2 Header_Source_Code(string pSource, string2 pState)
 :=	map(pSource = 'CG' or pState='CG'	=> 'CG',
		pSource in ['DI']	=> case(pState,
										'FL'	=> 'FW',
										'MO'	=> 'BW',
										'KY'	=> 'KW',
										fail(string2,99,'Problem with Watercraft.Header_Source_Code: (pSource: ' + pSource + ' - pState: ' + pState + ')')
									   ),
		pSource in ['UM','LN','AW','IT']	=> case(pState,
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

										'KY'	=> '$W',
										'FL'	=> '(W',
										'MO'	=> ')W',
										//'CG'	=> '-W',

										fail(string2,99,'Problem with Watercraft.Header_Source_Code: (pSource: ' + pSource + ' - pState: ' + pState + ')')
					   				   ),
		 fail(string2,99,'Problem with Watercraft.Header_Source_Code: (pSource: ' + pSource + ' - pState: ' + pState + ')')
		);
