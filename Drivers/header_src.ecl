export Header_Src(string2 pSource, string2 pState)
 :=	if(pSource <> 'AX',
	   case(pState,			//non-Experian
			'MO' => 'MD',
			'MN' => 'ND',
			'FL' => 'FD',
			'OH' => 'OD',
			'TX' => 'TD',
			'NM' => 'ED',
			'WI' => 'WD',
			'ID' => 'ID',
			'OR' => 'RD',
			'ME' => 'AD',
			'WV' => 'VD',
			'MI' => 'CD',
			'UT' => 'UD',
			'IA' => 'JD',
			'MA' => 'PD',
			'TN' => 'SD',
			'WY' => 'YD',
			'KY' => 'KD',
			''
		   ),
	   case(pState,			//Experian
			'CO' => '1X',
			'DE' => '2X',
			'ID' => '3X',
			'IL' => '4X',
			'KY' => '5X',
			'LA' => '6X',
			'MD' => '7X',
			'MS' => '8X',
			'ND' => '9X',
			'NH' => 'ZX',
			'SC' => 'XX',
			'WV' => 'BX',
			''
		   )
	  );