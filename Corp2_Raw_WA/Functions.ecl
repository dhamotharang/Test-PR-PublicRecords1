﻿IMPORT corp2_raw_ia, corp2;

EXPORT FUNCTIONs := Module
  	
	EXPORT CleanFirstName(string FName, string LName)
			:= map(corp2.t2u(FName) in ['-','"','*','.','/','_','N/A','NAME','VACANT','WSOS']                               => '',
			       corp2.t2u(FName) in ['IS NOT','NOT','TITLE','TITLE NOT','TITLE-NOT'] and corp2.t2u(LName) = 'APPLICABLE' => '',
						 corp2.t2u(FName) in ['CURRENTLY','POSITION','POSITIONS','SPOT','VAC'] and corp2.t2u(LName) = 'VACANT'    => '',
						 corp2.t2u(FName));


  EXPORT CleanMiddleName(string MName, string LName)
			:= map(corp2.t2u(MName) = '.' and corp2.t2u(LName)[1..3] = 'COM'     => corp2.t2u(MName),
			       corp2.t2u(MName) in ['-','--','*',',','.',';','?','`','NONE'] => '',
						 corp2.t2u(MName) = 'NOT' and corp2.t2u(LName) = 'APPLICABLE'  => '',
						 corp2.t2u(MName) = 'ANT' and corp2.t2u(LName) = 'VACANT'      => '',
					   corp2.t2u(MName));
						 
				
  EXPORT CleanLastName(string LName)
			:= if(corp2.t2u(LName) in ['*','ADDITIONAL NAMES ON FILE','ADD\'L GOVERNORS ON FILE',
																	'APPLICABLE','DIRECTORS ON FILE','MORE ON FILE','VACANT']
						,'' ,corp2.t2u(LName));


  EXPORT GetOrgStrucDesc(string code, string typ)
	    := map( corp2.t2u(code) = '3LP'  =>  'LIMITED LIABILITY LIMITED PARTNERSHIP',
							corp2.t2u(code) = 'AUT'  =>  'JOINT MUNICIPAL UTILITY SERVICE',
							corp2.t2u(code) = 'BNK'  =>  'BANK CORPORATION',
							corp2.t2u(code) = 'CAS'  =>  'SPECIAL CO-OPERATIVE CLASS',
							corp2.t2u(code) = 'COP'  =>  'NON-PROFIT CO-OPERATIVE ASSOCIATION',
							corp2.t2u(code) = 'CRU'  =>  'CREDIT UNION',
							corp2.t2u(code) = 'FBS'  =>  'FRATERNAL BUILDING ASSOCIATION',
							corp2.t2u(code) = 'FMA'  =>  'FISH MARKETING ACT',
							corp2.t2u(code) = 'FRA'  =>  'FRATERNAL SOCIETY',
							corp2.t2u(code) = 'GRG'  =>  'GRANGE',
							corp2.t2u(code) = 'INS'  =>  'INSURANCE COMPANY',
							corp2.t2u(code) = 'LLC'  =>  'LIMITED LIABILITY COMPANY',
							corp2.t2u(code) = 'LLP'  =>  'LIMITED LIABILITY PARTNERSHIP',
							corp2.t2u(code) = 'LTD'  =>  'LIMITED PARTNERSHIP PROFIT',
							corp2.t2u(code) = 'MAS'  =>  'MASSACHUSETTS TRUST',
							corp2.t2u(code) = 'MIL'  =>  'MILITARY CORPORATION',
							corp2.t2u(code) = 'MIN'  =>  'NATURAL RESOURCE', 
							corp2.t2u(code) = 'MMC'  =>  'MISCELLANEOUS AND MUTUAL',
							corp2.t2u(code) = 'PBC'  =>  'PUBLIC BENEFIT CORPORATION',
							corp2.t2u(code) = 'PLC'  =>  'PROFESSIONAL LIMITED LIABILITY COMPANY',
							corp2.t2u(code) = 'PRO' and corp2.t2u(typ) = 'NONPROFIT' =>  'NON-PROFIT PROFESSIONAL SERVICE CORPORATION',
							corp2.t2u(code) = 'PRO' and corp2.t2u(typ) = 'PROFIT'    =>  'PROFESSIONAL SERVICE CORPORATION',
							corp2.t2u(code) = 'PUB'  =>  'PUBLIC UTILITIES',
							corp2.t2u(code) = 'REG' and corp2.t2u(typ) = 'NONPROFIT' =>  'NON-PROFIT CORPORATION',
							corp2.t2u(code) = 'REG' and corp2.t2u(typ) = 'PROFIT'    =>  'PROFIT CORPORATION',
							corp2.t2u(code) = 'RFN'  =>  'FOREIGN REGISTRATION',
							corp2.t2u(code) = 'SAL'  =>  'SAVINGS AND LOAN ASSOCIATION',
							corp2.t2u(code) = 'SOL'  =>  'CORPORATION SOLE',
							corp2.t2u(code) = 'SPC'  =>  'SOCIAL PURPOSE',			
							corp2.t2u(code) = ''     =>  'UNREGISTERED CORPORATIONS',
							'**|' + corp2.t2u(code));
							
  EXPORT GetStatus(string desc)
						:= case(corp2.t2u(desc),
								'ACTIVE'  									 => 'ACTIVE',
								'ACTIVE PENDING'  					 => 'ACTIVE PENDING',
								'ADMINISTRATIVELY DISSOLVED' => 'ADMINISTRATIVELY DISSOLVED',
								'CONVERTED'  								 => 'CONVERTED',
								'DELINQUENT'  							 => 'DELINQUENT',
								'DISSOLVED'  								 => 'DISSOLVED',
								'DUPED UBI'  								 => 'DUPED UBI',
								'INACTIVE'  								 => 'INACTIVE',
								'MERGED'  									 => 'MERGED',
								'TERMINATED'  						 	 => 'TERMINATED',
								'VOLUNTARILY DISSOLVED'  	   => 'VOLUNTARILY DISSOLVED',
								'WITHDRAWN'  								 => 'WITHDRAWN',
								''        									 => '',
								'**|' + corp2.t2u(desc));

		EXPORT GetStateCode(string code) 
							:= case(corp2.t2u(code),
										'ALASKA' 								=> 'AK',
										'AK' 										=> 'AK',
										'ALABAMA' 							=> 'AL',
										'AL' 										=> 'AL',
										'ARKANSAS' 							=> 'AR',
										'AR' 										=> 'AR',
										'ARIZONA' 							=> 'AZ',
										'AZ' 										=> 'AZ',
										'CALIFORNIA' 						=> 'CA',
										'CA' 										=> 'CA',
										'COLORADO' 							=> 'CO',
										'CO' 										=> 'CO',
										'CONNECTICUT' 					=> 'CT',
										'CT' 										=> 'CT',
										'DISTRICT OF COLUMBIA' 	=> 'DC',
										'DC' 										=> 'DC',
										'DELAWARE' 							=> 'DE',
										'DE' 										=> 'DE',
										'FLORIDA' 							=> 'FL',
										'FL' 										=> 'FL',
										'GEORGIA' 							=> 'GA',
										'GA' 										=> 'GA',
										'HAWAII' 								=> 'HI',
										'HI' 										=> 'HI',
										'IOWA' 									=> 'IA',
										'IA' 										=> 'IA',
										'IDAHO' 								=> 'ID',
										'ID' 										=> 'ID',
										'ILLINOIS' 							=> 'IL',
										'IL' 										=> 'IL',
										'INDIANA' 							=> 'IN',
										'IN' 										=> 'IN',
										'KANSAS' 								=> 'KS',
										'KS' 										=> 'KS',
										'KENTUCKY' 							=> 'KY',
										'KY' 										=> 'KY',
										'LOUISIANA' 						=> 'LA',
										'LA' 										=> 'LA',
										'MASSACHUSETTS' 				=> 'MA',
										'MA' 										=> 'MA',
										'MARYLAND' 							=> 'MD',
										'MD' 										=> 'MD',
										'MAINE' 								=> 'ME',
										'ME' 										=> 'ME',
										'MICHIGAN' 							=> 'MI',
										'MI' 										=> 'MI',
										'MINNESOTA' 						=> 'MN',
										'MN' 										=> 'MN',
										'MISSOURI' 							=> 'MO',
										'MO' 										=> 'MO',
										'MISSISSIPPI' 					=> 'MS',
										'MS' 										=> 'MS',
										'MONTANA' 							=> 'MT',
										'MT' 										=> 'MT',
										'NORTH CAROLINA' 				=> 'NC',
										'NC' 										=> 'NC',
										'NORTH DAKOTA' 					=> 'ND',
										'ND' 										=> 'ND',
										'NEBRASKA' 							=> 'NE',
										'NE' 										=> 'NE',
										'NEW HAMPSHIRE' 				=> 'NH',
										'NH' 										=> 'NH',
										'NEW JERSEY' 						=> 'NJ',
										'NJ' 										=> 'NJ',
										'NEW MEXICO' 						=> 'NM',
										'NM' 										=> 'NM',
										'NEVADA' 								=> 'NV',
										'NV' 										=> 'NV',
										'NEW YORK' 							=> 'NY',
										'NY' 										=> 'NY',
										'OHIO' 									=> 'OH',
										'OH' 										=> 'OH',
										'OKLAHOMA' 							=> 'OK',
										'OK' 										=> 'OK',
										'OREGON' 								=> 'OR',
										'OR' 										=> 'OR',
										'PENNSYLVANIA' 					=> 'PA',
										'PA' 										=> 'PA',
										'PUERTO RICO' 					=> 'PR',
										'PR' 										=> 'PR',
										'RHODE ISLAND' 					=> 'RI',
										'RI' 										=> 'RI',
										'SOUTH CAROLINA' 				=> 'SC',
										'SC' 										=> 'SC',
										'SOUTH DAKOTA' 					=> 'SD',
										'SD' 										=> 'SD',
										'TENNESSEE' 						=> 'TN',
										'TN' 										=> 'TN',
										'TEXAS' 								=> 'TX',
										'TX' 										=> 'TX',
										'UTAH' 									=> 'UT',
										'UT' 										=> 'UT',
										'VIRGINIA' 							=> 'VA',
										'VA' 										=> 'VA',
										'VERMONT' 							=> 'VT',
										'VT' 										=> 'VT',
										'WASHINGTON' 						=> 'WA',
										'WA' 										=> 'WA',
										'WISCONSIN' 						=> 'WI',
										'WI' 										=> 'WI',
										'WEST VIRGINIA' 				=> 'WV',
										'WV' 										=> 'WV',
										'WYOMING' 							=> 'WY',
										'WY' 										=> 'WY',
										'FOREIGN' 							=> '',
										'');


		EXPORT GetStateDesc(string code) 
							:= case(corp2.t2u(code),
										'AL' 										=> 'ALABAMA',
										'ALABAMA' 							=> 'ALABAMA',
										'AK' 										=> 'ALASKA',
										'ALASKA' 								=> 'ALASKA',
										'ARIZONA' 							=> 'ARIZONA',
										'AZ' 										=> 'ARIZONA',
										'AR' 										=> 'ARKANSAS',
										'ARKANSAS' 							=> 'ARKANSAS',
										'CA' 										=> 'CALIFORNIA',
										'CALIFORNIA' 						=> 'CALIFORNIA',
										'CO' 										=> 'COLORADO',
										'COLORADO' 							=> 'COLORADO',
										'CONNECTICUT' 					=> 'CONNECTICUT',
										'CT' 										=> 'CONNECTICUT',
										'DE' 										=> 'DELAWARE',
										'DELAWARE' 							=> 'DELAWARE',
										'DC' 									 	=> 'DISTRICT OF COLUMBIA',
										'DISTRICT OF COLUMBIA' 	=> 'DISTRICT OF COLUMBIA',
										'FL' 										=> 'FLORIDA',
										'FLORIDA' 							=> 'FLORIDA',
										'GA' 										=> 'GEORGIA',
										'GEORGIA' 							=> 'GEORGIA',
										'HAWAII' 								=> 'HAWAII',
										'HI' 										=> 'HAWAII',
										'ID' 										=> 'IDAHO',
										'IDAHO' 								=> 'IDAHO',
										'IL' 										=> 'ILLINOIS',
										'ILLINOIS' 							=> 'ILLINOIS',
										'IN' 										=> 'INDIANA',
										'INDIANA' 							=> 'INDIANA',
										'IA' 										=> 'IOWA',
										'IOWA' 									=> 'IOWA',
										'KANSAS' 								=> 'KANSAS',
										'KS' 										=> 'KANSAS',
										'KENTUCKY' 							=> 'KENTUCKY',
										'KY' 										=> 'KENTUCKY',
										'LA' 										=> 'LOUISIANA',
										'LOUISIANA' 						=> 'LOUISIANA',
										'MAINE' 								=> 'MAINE',
										'ME' 										=> 'MAINE',
										'MARYLAND' 							=> 'MARYLAND',
										'MD' 										=> 'MARYLAND',
										'MA' 										=> 'MASSACHUSETTS',
										'MASSACHUSETTS' 				=> 'MASSACHUSETTS',
										'MI' 										=> 'MICHIGAN',
										'MICHIGAN' 							=> 'MICHIGAN',
										'MINNESOTA' 						=> 'MINNESOTA',
										'MN' 										=> 'MINNESOTA',
										'MISSISSIPPI' 					=> 'MISSISSIPPI',
										'MS' 										=> 'MISSISSIPPI',
										'MISSOURI' 							=> 'MISSOURI',
										'MO' 										=> 'MISSOURI',
										'MONTANA' 							=> 'MONTANA',
										'MT' 										=> 'MONTANA',
										'NE' 										=> 'NEBRASKA',
										'NEBRASKA' 							=> 'NEBRASKA',
										'NEVADA' 								=> 'NEVADA',
										'NV' 										=> 'NEVADA',
										'NEW HAMPSHIRE' 				=> 'NEW HAMPSHIRE',
										'NH' 										=> 'NEW HAMPSHIRE',
										'NEW JERSEY' 						=> 'NEW JERSEY',
										'NJ' 										=> 'NEW JERSEY',
										'NEW MEXICO' 						=> 'NEW MEXICO',
										'NM' 										=> 'NEW MEXICO',
										'NEW YORK' 							=> 'NEW YORK',
										'NY' 										=> 'NEW YORK',
										'NC' 										=> 'NORTH CAROLINA',
										'NORTH CAROLINA' 				=> 'NORTH CAROLINA',
										'ND' 										=> 'NORTH DAKOTA',
										'NORTH DAKOTA' 					=> 'NORTH DAKOTA',
										'OH' 										=> 'OHIO',
										'OHIO' 									=> 'OHIO',
										'OK' 										=> 'OKLAHOMA',
										'OKLAHOMA' 							=> 'OKLAHOMA',
										'OR' 										=> 'OREGON',
										'OREGON' 								=> 'OREGON',
										'PA' 										=> 'PENNSYLVANIA',
										'PENNSYLVANIA' 					=> 'PENNSYLVANIA',
										'PR' 										=> 'PUERTO RICO',
										'PUERTO RICO' 					=> 'PUERTO RICO',
										'RHODE ISLAND' 					=> 'RHODE ISLAND',
										'RI' 										=> 'RHODE ISLAND',
										'SC' 										=> 'SOUTH CAROLINA',
										'SOUTH CAROLINA' 				=> 'SOUTH CAROLINA',
										'SD' 										=> 'SOUTH DAKOTA',
										'SOUTH DAKOTA' 					=> 'SOUTH DAKOTA',
										'TENNESSEE' 						=> 'TENNESSEE',
										'TN' 										=> 'TENNESSEE',
										'TEXAS' 								=> 'TEXAS',
										'TX' 										=> 'TEXAS',
										'UT' 										=> 'UTAH',
										'UTAH' 									=> 'UTAH',
										'VERMONT' 							=> 'VERMONT',
										'VT' 										=> 'VERMONT',
										'VA' 										=> 'VIRGINIA',
										'VIRGINIA' 							=> 'VIRGINIA',
										'WA' 										=> 'WASHINGTON',
										'WASHINGTON' 						=> 'WASHINGTON',
										'WEST VIRGINIA' 				=> 'WEST VIRGINIA',
										'WV' 										=> 'WEST VIRGINIA',
										'WI' 										=> 'WISCONSIN',
										'WISCONSIN' 						=> 'WISCONSIN',
										'WY' 										=> 'WYOMING',
										'WYOMING' 							=> 'WYOMING',
										'FOREIGN' 							=> '',
										'**|' + corp2.t2u(code));

END;
