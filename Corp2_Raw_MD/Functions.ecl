IMPORT corp2, corp2_mapping;

EXPORT Functions := Module	
	
		//fGetStateCode: validates vendor codes and Returns '**' if we receive invalid or new codes from vendor 
		EXPORT fGetStateCode(string code) 
	        := map ( corp2.t2u(code) in 
									 ['AL','AK','AF','AS','AZ','AR','AE','AP','AA','AU',
									  'BE','BL','BR','BW','CB','CH','CZ','CI','CA','CD',
										'CO','CT','DE','DC','EU','FC','FM','FL','FR','GA',
										'GR','GU','GB','HK','HI','ID','IE','IL','II','IN',
										'IA','JA','KS','KY','LA','LX','ME','MH','MD','MA',
										'MI','MX','MP','MN','MS','MO','MT','NE','NV','NH',
										'NJ','NM','NY','NL','NS','NC','ND','OA','OH','OK',
										'OR','PH','PN','PW','PA','PR','RI','SA','SC','SD',
										'SL','TN','TX','UT','US','UK','VT','VI','VA','WA',
										'WV','WI','WY']	=>	corp2.t2u(code),
									  corp2.t2u(code) in ['XX','X','NA',''] =>'',
									  '**'
									);
										
	//fGetStateDesc: Returns full name from "Two digit State_Code" 
	EXPORT  string fGetStateDesc(STRING state) := FUNCTION

		st  := corp2.t2u(state);
		RETURN case(st,								
								'AA'  =>'ARMED FORCES (AMERICAS EXCEPT CANADA)',
								'AE'  =>'ARMED FORCES EUROPE THE MIDDLE EAST AND CANADA',
								'AF'  =>'AFRICA',
								'AK'  =>'ALASKA',
								'AL'  =>'ALABAMA',
								'AP'  =>'ARMED FORCES PACIFIC',
								'AR'  =>'ARKANSAS',
								'AS'  =>'AMERICAN SAMOA',
								'AU'  =>'AUSTRALIA',
								'AZ'  =>'ARIZONA',
								'BE'  =>'BERMUDA',
								'BL'  =>'BELGIUM',
								'BR'  =>'BARBADOS',
								'BW'  =>'BRITISH WEST INDIES',
								'CA'  =>'CALIFORNIA',
								'CB'  =>'COLUMBIA',
								'CD'  =>'CANADA',
								'CH'  =>'CHINA',
								'CI'  =>'COOK ISLANDS',
								'CO'  =>'COLORADO',
								'CT'  =>'CONNECTICUT',
								'CZ'  =>'CANAL ZONE',
								'DC'  =>'DISTRICT OF COLUMBIA',
								'DE'  =>'DELAWARE',
								'EU'  =>'EUROPE',
								'FC'  =>'FUTBOL CLUB BARCELONA SPAIN', 
								'FL'  =>'FLORIDA',
								'FM'  =>'FEDERATED STATES OF MICRONESIA',
								'FR'  =>'FRANCE',
								'GA'  =>'GEORGIA',
								'GB'  =>'GREAT BRITAIN',
								'GR'  =>'GERMANY',
								'GU'  =>'GUAM',
								'HI'  =>'HAWAII',
								'HK'  =>'HONG KONG',
								'IA'  =>'IOWA',
								'ID'  =>'IDAHO',
								'IE'  =>'IRELAND',
								'II'  =>'INDIA',
								'IL'  =>'ILLINOIS',
								'IN'  =>'INDIANA',
								'JA'  =>'JAPAN',
								'KS'  =>'KANSAS',
								'KY'  =>'KENTUCKY',
								'LA'  =>'LOUISIANA',
								'LX'  =>'LUXEMBOURG',
								'MA'  =>'MASSACHUSETTS',
								'MD'  =>'MARYLAND',
								'ME'  =>'MAINE',
								'MH'  =>'MARSHALL ISLANDS',
								'MI'  =>'MICHIGAN',
								'MN'  =>'MINNESOTA',
								'MO'  =>'MISSOURI',
								'MP'  =>'NORTHERN MARIANA ISLANDS',
								'MS'  =>'MISSISSIPPI',
								'MT'  =>'MONTANA',
								'MX'  =>'MEXICO',
								'NA'  =>'',
								'NC'  =>'NORTH CAROLINA',
								'ND'  =>'NORTH DAKOTA',
								'NE'  =>'NEBRASKA',
								'NH'  =>'NEW HAMPSHIRE',
								'NJ'  =>'NEW JERSEY',
								'NL'  =>'NETHERLANDS',
								'NM'  =>'NEW MEXICO',
								'NS'  =>'NOVA SCOTIA CANADA',
								'NV'  =>'NEVADA',
								'NY'  =>'NEW YORK',
								'OA'  =>'OTHER ASIA',
								'OH'  =>'OHIO',
								'OK'  =>'OKLAHOMA',
								'OR'  =>'OREGON',
								'PA'  =>'PENNSYLVANIA',
								'PH'  =>'PHILIPPINES',
								'PN'  =>'PANAMA',   
								'PR'  =>'PUERTO RICO',
								'PW'  =>'PALAU',
								'RI'  =>'RHODE ISLAND',
								'SA'  =>'OTHER S&C AMERICAN',
								'SC'  =>'SOUTH CAROLINA',
								'SD'  =>'SOUTH DAKOTA',
								'SL'  =>'SCOTLAND',
								'TN'  =>'TENNESSEE',
								'TX'  =>'TEXAS',
								'UK'  =>'UNITED KINGDOM',
								'US'  =>'UNITED STATES',
								'UT'  =>'UTAH',
								'VA'  =>'VIRGINIA',
								'VI'  =>'VIRGIN ISLANDS',
								'VT'  =>'VERMONT',
								'WA'  =>'WASHINGTON',
								'WI'  =>'WISCONSIN',
								'WV'  =>'WEST VIRGINIA',
								'WY'  =>'WYOMING',
								'X '  =>'',
								'XX'  =>'',
								'' 		=>'',
								'**|'+st
								 );
		END;						
	
	//OrgStrucDesc: Returns corp_orig_org_structure_desc" 
	EXPORT  OrgStrucDesc(STRING code) := FUNCTION

		st  := corp2.t2u(code);
		RETURN map( st = 'A' => 'DOMESTIC LIMITED LIABILITY PARTNERSHIP',
								st = 'B' => 'BUSINESS TRUST',
								st = 'C' => 'GENERAL PARTNERSHIP',
								st = 'D' => 'DOMESTIC CORPORATION',
								st = 'E' => 'FOREIGN LIMITED LIABILITY PARTNERSHIP',
								st = 'F' => 'FOREIGN CORPORATION',
								st = 'L' => 'UNINCORPORATED ENTITY',
								st = 'M' => 'DOMESTIC LP OR DOMESTIC LLLP',
								ST = 'P' => 'FOREIGN LP OR FOREIGN LLLP',
								st = 'R' => '',//'REGISTERED NAME'  [Per CI :Do not map  Registered Name, Reserved Name and Trade Name]
								st = 'S' => 'OTHER',
								st = 'T' => '',//'TRADE NAME'
								st = 'U' => 'UNCLASSIFIED ENTITY',
								st = 'V' => '',//'RESERVED NAME'
								st = 'W' => 'DOMESTIC LIMITED LIABILITY COMPANY',
								st = 'Z' => 'FOREIGN LIMITED LIABILITY COMPANY',
								st = '' => '',
								'**|'+st
								 );

	END;
	
END;