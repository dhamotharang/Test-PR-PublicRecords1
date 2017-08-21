IMPORT corp2, corp2_mapping, ut;

EXPORT Functions_LLC := MODULE

		//****************************************************************************
		//State_Foreign_Codes: returns whether the state/foreign code is a known 
		//										 code and if so, what the corresponding code is.
		//****************************************************************************
		EXPORT State_Foreign_Codes(string s) := FUNCTION

					 uc_s := corp2.t2u(s);
					 
					 RETURN map (uc_s in ['1']  => 'AL',
											 uc_s in ['2']  => 'AK', 
											 uc_s in ['5']  => 'AR', 
											 uc_s in ['3']  => 'AS', 
											 uc_s in ['4']  => 'AZ', 
											 uc_s in ['6']  => 'CA', 
											 uc_s in ['8']  => 'CO', 
											 uc_s in ['9']  => 'CT',
											 uc_s in ['7']  => 'CZ',
											 uc_s in ['11'] => 'DC', 
											 uc_s in ['10'] => 'DE', 
											 uc_s in ['12'] => 'FL',
											 uc_s in ['13'] => 'GA', 
											 uc_s in ['14'] => 'GU', 
											 uc_s in ['15'] => 'HI', 
											 uc_s in ['19'] => 'IA', 
											 uc_s in ['16'] => 'ID', 
											 uc_s in ['17'] => 'IL', 
											 uc_s in ['18'] => 'IN', 
											 uc_s in ['20'] => 'KS', 
											 uc_s in ['21'] => 'KY', 
											 uc_s in ['22'] => 'LA', 
											 uc_s in ['25'] => 'MA', 
											 uc_s in ['24'] => 'MD', 
											 uc_s in ['23'] => 'ME', 
											 uc_s in ['26'] => 'MI', 
											 uc_s in ['27'] => 'MN', 
											 uc_s in ['29'] => 'MO', 
											 uc_s in ['28'] => 'MS', 
											 uc_s in ['30'] => 'MT', 
											 uc_s in ['37'] => 'NC', 
											 uc_s in ['38'] => 'ND', 
											 uc_s in ['31'] => 'NE', 
											 uc_s in ['33'] => 'NH', 
											 uc_s in ['34'] => 'NJ', 
											 uc_s in ['35'] => 'NM', 
											 uc_s in ['32'] => 'NV', 
											 uc_s in ['36'] => 'NY', 
											 uc_s in ['39'] => 'OH', 
											 uc_s in ['40'] => 'OK', 
											 uc_s in ['41'] => 'OR', 
											 uc_s in ['42'] => 'PA', 
											 uc_s in ['43'] => 'PR', 
											 uc_s in ['44'] => 'RI', 
											 uc_s in ['45'] => 'SC', 
											 uc_s in ['46'] => 'SD', 
											 uc_s in ['47'] => 'TN', 
											 uc_s in ['48'] => 'TX',
											 uc_s in ['49'] => 'UT', 
											 uc_s in ['51'] => 'VA', 
											 uc_s in ['52'] => 'VI', 
											 uc_s in ['50'] => 'VT', 
											 uc_s in ['53'] => 'WA', 
											 uc_s in ['55'] => 'WI', 
											 uc_s in ['54'] => 'WV', 
											 uc_s in ['56'] => 'WY',
											 uc_s in ['57'] => 'AO',
											 uc_s in ['58'] => 'AB',
											 uc_s in ['59'] => 'BC',
											 uc_s in ['60'] => 'MB',
											 uc_s in ['61'] => 'MM',
											 uc_s in ['62'] => 'NB',
											 uc_s in ['63'] => 'NB',
											 uc_s in ['64'] => 'ON',
											 uc_s in ['65'] => 'PQ',
											 uc_s in ['66'] => 'SK',
											 uc_s in ['67'] => 'LB',
											 uc_s in ['68'] => 'NF',
											 uc_s in ['69'] => 'NT',
											 uc_s in ['70'] => 'PE',
											 uc_s in ['71'] => 'YT',
											 uc_s in ['72'] => 'HO',	//changed 72 from PR to HO (Honduras)
											 uc_s in ['78'] => '',		//changed 78 from VI to blank											 
											 uc_s in ['AK','AL','AR','AS','AZ','CA','CO','CT','CZ','DC','DE','FL','GA','GU','HI',
																'IA','ID','IL','IN','KS','KY','LA','MA','MD','ME','MI','MN','MO','MS','MT',
																'NC','ND','NE','NH','NJ','NM','NV','NY','OH','OK','OR','PA','PR','RI','SC',
																'SD','TN','TX','TT','US','UT','VA','VI','VT','WA','WI','WV','WY',''] 						 => uc_s,
											 uc_s in ['AO','AB','BC','HO','LB','MB','MM','NB','NF','NS','NT','ON','PE','PQ','SK','YT'] => uc_s,															
											 '**'
											);
		END;

		//****************************************************************************
		//State_Description: returns whether the state is a valid us state.
		//****************************************************************************
		EXPORT State_Code_Translation(string s) := FUNCTION

					 uc_s := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

	         RETURN map(uc_s = ''		=> '',
											uc_s = 'AL' => 'ALABAMA',
											uc_s = 'AK' => 'ALASKA', 
											uc_s = 'AR' => 'ARKANSAS', 
											uc_s = 'AS' => 'AMERICAN SAMOA', 
											uc_s = 'AZ' => 'ARIZONA', 
											uc_s = 'CA' => 'CALIFORNIA', 
											uc_s = 'CO' => 'COLORADO', 
											uc_s = 'CT' => 'CONNECTICUT',
											uc_s = 'CZ' => 'CANAL ZONE',										
											uc_s = 'DC' => 'DISTRICT OF COLUMBIA', 
											uc_s = 'DE' => 'DELAWARE', 
											uc_s = 'FL' => 'FLORIDA',
											uc_s = 'FN' => 'FOREIGN',
											uc_s = 'GA' => 'GEORGIA', 
											uc_s = 'GU' => 'GUAM', 
											uc_s = 'HI' => 'HAWAII', 
											uc_s = 'IA' => 'IOWA', 
											uc_s = 'ID' => 'IDAHO', 
											uc_s = 'IL' => 'ILLINOIS', 
											uc_s = 'IN' => 'INDIANA', 
											uc_s = 'KS' => 'KANSAS', 
											uc_s = 'KY' => 'KENTUCKY', 
											uc_s = 'LA' => 'LOUISIANA', 
											uc_s = 'MA' => 'MASSACHUSETTS', 
											uc_s = 'MD' => 'MARYLAND', 
											uc_s = 'ME' => 'MAINE' , 
											uc_s = 'MI' => 'MICHIGAN', 
											uc_s = 'MN' => 'MINNESOTA', 
											uc_s = 'MO' => 'MISSOURI', 
											uc_s = 'MS' => 'MISSISSIPPI', 
											uc_s = 'MT' => 'MONTANA', 
											uc_s = 'NC' => 'NORTH CAROLINA', 
											uc_s = 'ND' => 'NORTH DAKOTA', 
											uc_s = 'NE' => 'NEBRASKA', 
											uc_s = 'NH' => 'NEW HAMPSHIRE', 
											uc_s = 'NJ' => 'NEW JERSEY', 
											uc_s = 'NM' => 'NEW MEXICO', 
											uc_s = 'NV' => 'NEVADA', 
											uc_s = 'NY' => 'NEW YORK', 
											uc_s = 'OH' => 'OHIO', 
											uc_s = 'OK' => 'OKLAHOMA', 
											uc_s = 'OR' => 'OREGON', 
											uc_s = 'PA' => 'PENNSYLVANIA', 
											uc_s = 'PR' => 'PUERTO RICO', 
											uc_s = 'RI' => 'RHODE ISLAND', 
											uc_s = 'SC' => 'SOUTH CAROLINA', 
											uc_s = 'SD' => 'SOUTH DAKOTA', 
											uc_s = 'TN' => 'TENNESSEE', 
											uc_s = 'TT' => 'TRUST TERRITORIES',
											uc_s = 'TX' => 'TEXAS',
											uc_s = 'US' => 'US', 
											uc_s = 'UT' => 'UTAH', 
											uc_s = 'VA' => 'VIRGINIA', 
											uc_s = 'VI' => 'VIRGIN ISLANDS', 
											uc_s = 'VT' => 'VERMONT', 
											uc_s = 'WA' => 'WASHINGTON', 
											uc_s = 'WI' => 'WISCONSIN', 
											uc_s = 'WV' => 'WEST VIRGINIA', 
											uc_s = 'WY' => 'WYOMING',
											//Numeric Values
											uc_s = '1'  => 'ALABAMA',
											uc_s = '2'  => 'ALASKA', 
											uc_s = '5'  => 'ARKANSAS', 
											uc_s = '3'  => 'AMERICAN SAMOA', 
											uc_s = '4'  => 'ARIZONA', 
											uc_s = '6'  => 'CALIFORNIA', 
											uc_s = '8'  => 'COLORADO', 
											uc_s = '9'  => 'CONNECTICUT',
											uc_s = '7'  => 'CANAL ZONE',										
											uc_s = '11' => 'DISTRICT OF COLUMBIA', 
											uc_s = '10' => 'DELAWARE', 
											uc_s = '12' => 'FLORIDA',
											uc_s = '13' => 'GEORGIA', 
											uc_s = '14' => 'GUAM', 
											uc_s = '15' => 'HAWAII', 
											uc_s = '19' => 'IOWA', 
											uc_s = '16' => 'IDAHO', 
											uc_s = '17' => 'ILLINOIS', 
											uc_s = '18' => 'INDIANA', 
											uc_s = '20' => 'KANSAS', 
											uc_s = '21' => 'KENTUCKY', 
											uc_s = '22' => 'LOUISIANA', 
											uc_s = '25' => 'MASSACHUSETTS', 
											uc_s = '24' => 'MARYLAND', 
											uc_s = '23' => 'MAINE' , 
											uc_s = '26' => 'MICHIGAN', 
											uc_s = '27' => 'MINNESOTA', 
											uc_s = '29' => 'MISSOURI', 
											uc_s = '28' => 'MISSISSIPPI', 
											uc_s = '30' => 'MONTANA', 
											uc_s = '37' => 'NORTH CAROLINA', 
											uc_s = '38' => 'NORTH DAKOTA', 
											uc_s = '31' => 'NEBRASKA', 
											uc_s = '33' => 'NEW HAMPSHIRE', 
											uc_s = '34' => 'NEW JERSEY', 
											uc_s = '35' => 'NEW MEXICO', 
											uc_s = '32' => 'NEVADA', 
											uc_s = '36' => 'NEW YORK', 
											uc_s = '39' => 'OHIO', 
											uc_s = '40' => 'OKLAHOMA', 
											uc_s = '41' => 'OREGON', 
											uc_s = '42' => 'PENNSYLVANIA', 
											uc_s = '43' => 'PUERTO RICO', 
											uc_s = '44' => 'RHODE ISLAND', 
											uc_s = '45' => 'SOUTH CAROLINA', 
											uc_s = '46' => 'SOUTH DAKOTA', 
											uc_s = '47' => 'TENNESSEE', 
											uc_s = '48' => 'TEXAS',
											uc_s = '49' => 'UTAH', 
											uc_s = '51' => 'VIRGINIA', 
											uc_s = '52' => 'VIRGIN ISLANDS', 
											uc_s = '50' => 'VERMONT', 
											uc_s = '53' => 'WASHINGTON', 
											uc_s = '55' => 'WISCONSIN', 
											uc_s = '54' => 'WEST VIRGINIA', 
											uc_s = '56' => 'WYOMING',
											'**|'+uc_s
										 );
		END;

		//****************************************************************************
		//Foreign_Code_Translation: returns whether the code is valid or not.
		//****************************************************************************
		EXPORT Foreign_Code_Translation(string s) := FUNCTION

					 uc_s := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

	         RETURN map(uc_s = '' 	=> '',
											uc_s = 'AO' => 'FOREIGN COUNTRIES',
											uc_s = 'AB' => 'ALBERTA',
											uc_s = 'BC' => 'BRITISH COLUMBIA',
											uc_s = 'MB' => 'MANITOBA',
											uc_s = 'MM' => 'MEXICO',
											uc_s = 'NB' => 'NEW BRUNSWICK',
											uc_s = 'NS' => 'NOVA SCOTIA',
											uc_s = 'ON' => 'ONTARIO',
											uc_s = 'PQ' => 'QUEBEC',
											uc_s = 'SK' => 'SASKATCHEWAN',
											uc_s = 'LB' => 'LABRADOR',
											uc_s = 'NF' => 'NEWFOUNDLAND',
											uc_s = 'NT' => 'NORTHWEST TERRITORY',
											uc_s = 'PE' => 'PRINCE EDWARD ISLAND',
											uc_s = 'YT' => 'YUKON',
											uc_s = 'HO' => 'HONDURAS',
											uc_s = '57' => 'FOREIGN COUNTRIES',
											uc_s = '58' => 'ALBERTA',
											uc_s = '59' => 'BRITISH COLUMBIA',
											uc_s = '60' => 'MANITOBA',
											uc_s = '61' => 'MEXICO',
											uc_s = '62' => 'NEW BRUNSWICK',
											uc_s = '63' => 'NOVA SCOTIA',
											uc_s = '64' => 'ONTARIO',
											uc_s = '65' => 'QUEBEC',
											uc_s = '66' => 'SASKATCHEWAN',
											uc_s = '67' => 'LABRADOR',
											uc_s = '68' => 'NEWFOUNDLAND',
											uc_s = '69' => 'NORTHWEST TERRITORY',
											uc_s = '70' => 'PRINCE EDWARD ISLAND',
											uc_s = '71' => 'YUKON',
											uc_s = '72' => 'HONDURAS',
											'**|'+uc_s
										 );
		END;

		//****************************************************************************
		//CorpForgnStateDesc: returns the "corp_forgn_state_desc".
		//****************************************************************************
		EXPORT CorpForgnStateDesc(STRING s) := FUNCTION			 
		
			 uc_s := corp2.t2u(s);
					 
			 RETURN  map(State_Code_Translation(uc_s)[1..2]  <>'**'	=> State_Code_Translation(uc_s),
									 Foreign_Code_Translation(uc_s)[1..2]<>'**' => Foreign_Code_Translation(uc_s),
									 '**|'+uc_s
								  );
										
		END;

		//****************************************************************************
		//CorpCountryOfFormation: returns the "corp_country_of_formation".
		//****************************************************************************
		EXPORT CorpCountryOfFormation(STRING s) := FUNCTION			 
		
			 uc_s := corp2.t2u(s);
					 
			 RETURN  map(State_Code_Translation(uc_s)[1..2]  <>'**'	=> 'US',
									 Foreign_Code_Translation(uc_s)[1..2]<>'**' => Foreign_Code_Translation(uc_s),
									 '**|'+uc_s
								  );
										
		END;

		//****************************************************************************
		//CorpAddlInfo: returns the "corp_addl_info" for LLC.
		//****************************************************************************
		EXPORT CorpAddlInfo(STRING p, STRING o) := FUNCTION

				int_p 	:= corp2.t2u(p); //provision indicator
				int_o 	:= corp2.t2u(o); //opt indicator

				p_desc 	:= map(corp2.t2u(int_p) = '0' => 'NO PROVISIONS SELECTED',
											 corp2.t2u(int_p) = '1' => 'SOME, BUT NOT ALL, PROVISIONS SELECTED',
											 corp2.t2u(int_p) = '2' => 'ALL PROVISIONS SELECTED',
											 ''
											);
				//Overloaded field; can be removed after corp_opt_in_llc_act_ind is visible to
				//customer
				o_desc 	:= map(corp2.t2u(int_o) = '0' => 'DID NOT OPT IN TO THE NEW LLC ACT OF 1/1/1998',
											 corp2.t2u(int_o) = '1' => 'OPTED IN TO THE NEW LLC ACT OF 1/1/1998',				
											 ''
											);
						 
				addinfo	:= corp2.t2u(p_desc) + if(corp2.t2u(p_desc) <> '' and corp2.t2u(o_desc) <> '',';','') + corp2.t2u(o_desc);
				
				RETURN corp2.t2u(addinfo);
				
		END;

		//****************************************************************************
		//CorpAgentCounty: returns the associated "IL" county.
		//****************************************************************************
		EXPORT CorpAgentCounty(STRING s) := FUNCTION
		
			 uc_s  := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

			 county_list := ['ADAMS','ALEXANDER','BOND','BOONE','BROWN','BUREAU','CALHOUN','CARROLL','CASS',
											 'CHAMPAIGN','CHRISTIAN','CITY OF CHICAGO','CLARK','CLAY','CLINTON','COLES',											 
											 'COOK','CRAWFORD','CUMBERLAND','DEKALB','DEWITT','DOUGLAS','DU PAGE','EDGAR',
											 'EDWARDS','EFFINGHAM','FAYETTE','FORD','FRANKLIN','FULTON','GALLATIN','GREENE',
											 'GRUNDY','HAMILTON','HANCOCK','HARDIN','HENDERSON','HENRY','IROQUOIS','JACKSON',
											 'JASPER','JEFFERSON','JERSEY','JO DAVIESS','JOHNSON',  'KANE','KANKAKEE','KENDALL',
											 'KNOX','LA SALLE','LAKE','LAWRENCE','LEE','LIVINGSTON','LOGAN','MACON',
											 'MACOUPIN','MADISON','MARION','MARSHALL','MASON','MASSAC','MC DONOUGH','MC HENRY',
											 'MC LEAN','MENARD','MERCER','MONROE','MONTGOMERY','MORGAN','MOULTRIE','OGLE',
											 'PEORIA','PERRY','PIATT','PIKE','POPE','PULASKI','PUTNAM','RANDOLPH',
											 'RICHLAND','ROCK ISLAND','SALINE','SANGAMON','SCHUYLER','SCOTT','SHELBY','ST CLAIR',
											 'STARK','STEPHENSON','TAZEWELL','UNION','VERMILION','WABASH','WARREN','WASHINGTON',
											 'WAYNE','WHITE','WHITESIDE','WILL','WILLIAMSON','WINNEBAGO','WOODFORD'];

			 RETURN MAP(uc_s in ['','000'] 	=> '',			//unknown
									uc_s = '001'  			=> 'ADAMS',
									uc_s = '002'  			=> 'ALEXANDER',
									uc_s = '003'  			=> 'BOND',
									uc_s = '004'  			=> 'BOONE',
									uc_s = '005'  			=> 'BROWN',
									uc_s = '006'  			=> 'BUREAU',
									uc_s = '007'  			=> 'CALHOUN',
									uc_s = '008'  			=> 'CARROLL',
									uc_s = '009'  			=> 'CASS',
									uc_s = '010'  			=> 'CHAMPAIGN',
									uc_s = '011'  			=> 'CHRISTIAN',
									uc_s = '012'  			=> 'CLARK',
									uc_s = '013'  			=> 'CLAY',
									uc_s = '014'  			=> 'CLINTON',
									uc_s = '015'  			=> 'COLES',
									uc_s = '016'  			=> 'COOK',
									uc_s = '017'  			=> 'CRAWFORD',
									uc_s = '018'  			=> 'CUMBERLAND',
									uc_s = '019'  			=> 'DEKALB',
									uc_s = '020'  			=> 'DEWITT',
									uc_s = '021'  			=> 'DOUGLAS',
									uc_s = '022'  			=> 'DU PAGE',
									uc_s = '023'  			=> 'EDGAR',
									uc_s = '024'  			=> 'EDWARDS',
									uc_s = '025'  			=> 'EFFINGHAM',
									uc_s = '026'  			=> 'FAYETTE',
									uc_s = '027'  			=> 'FORD',
									uc_s = '028'  			=> 'FRANKLIN',
									uc_s = '029'  			=> 'FULTON',
									uc_s = '030'  			=> 'GALLATIN',
									uc_s = '031'  			=> 'GREENE',
									uc_s = '032'  			=> 'GRUNDY',
									uc_s = '033'  			=> 'HAMILTON',
									uc_s = '034'  			=> 'HANCOCK',
									uc_s = '035'  			=> 'HARDIN',
									uc_s = '036'  			=> 'HENDERSON',
									uc_s = '037'  			=> 'HENRY',
									uc_s = '038'  			=> 'IROQUOIS',
									uc_s = '039'  			=> 'JACKSON',
									uc_s = '040'  			=> 'JASPER',
									uc_s = '041'  			=> 'JEFFERSON',
									uc_s = '042'  			=> 'JERSEY',
									uc_s = '043'  			=> 'JO DAVIESS',
									uc_s = '044'  			=> 'JOHNSON',  
									uc_s = '045'  			=> 'KANE',
									uc_s = '046'  			=> 'KANKAKEE',
									uc_s = '047'  			=> 'KENDALL',
									uc_s = '048'  			=> 'KNOX',
									uc_s = '049'  			=> 'LAKE',
									uc_s = '050'  			=> 'LA SALLE',
									uc_s = '051'  			=> 'LAWRENCE',
									uc_s = '052'  			=> 'LEE',
									uc_s = '053'  			=> 'LIVINGSTON',
									uc_s = '054'  			=> 'LOGAN',
									uc_s = '055'  			=> 'MC DONOUGH',
									uc_s = '056'  			=> 'MC HENRY',
									uc_s = '057'  			=> 'MC LEAN',
									uc_s = '058'  			=> 'MACON',
									uc_s = '059'  			=> 'MACOUPIN',
									uc_s = '060'  			=> 'MADISON',
									uc_s = '061'  			=> 'MARION',
									uc_s = '062'  			=> 'MARSHALL',
									uc_s = '063'  			=> 'MASON',
									uc_s = '064'  			=> 'MASSAC',
									uc_s = '065'  			=> 'MENARD',
									uc_s = '066'  			=> 'MERCER',
									uc_s = '067'  			=> 'MONROE',
									uc_s = '068'  			=> 'MONTGOMERY',
									uc_s = '069'  			=> 'MORGAN',
									uc_s = '070'  			=> 'MOULTRIE',
									uc_s = '071'  			=> 'OGLE',
									uc_s = '072'  			=> 'PEORIA',
									uc_s = '073'  			=> 'PERRY',
									uc_s = '074'  			=> 'PIATT',
									uc_s = '075'  			=> 'PIKE',
									uc_s = '076'  			=> 'POPE',
									uc_s = '077'  			=> 'PULASKI',
									uc_s = '078'  			=> 'PUTNAM',
									uc_s = '079'  			=> 'RANDOLPH',
									uc_s = '080'  			=> 'RICHLAND',
									uc_s = '081'  			=> 'ROCK ISLAND',
									uc_s = '082'  			=> 'ST CLAIR',
									uc_s = '083'  			=> 'SALINE',
									uc_s = '084'  			=> 'SANGAMON',
									uc_s = '085'  			=> 'SCHUYLER',
									uc_s = '086'  			=> 'SCOTT',
									uc_s = '087'  			=> 'SHELBY',
									uc_s = '088'  			=> 'STARK',
									uc_s = '089'  			=> 'STEPHENSON',
									uc_s = '090'  			=> 'TAZEWELL',
									uc_s = '091'  			=> 'UNION',
									uc_s = '092'  			=> 'VERMILION',
									uc_s = '093'  			=> 'WABASH',
									uc_s = '094'  			=> 'WARREN',
									uc_s = '095'  			=> 'WASHINGTON',
									uc_s = '096'  			=> 'WAYNE',
									uc_s = '097'  			=> 'WHITE',
									uc_s = '098'  			=> 'WHITESIDE',
									uc_s = '099'  			=> 'WILL', 
									uc_s = '100' 				=> 'WILLIAMSON',
									uc_s = '101' 				=> 'WINNEBAGO',
									uc_s = '102' 				=> 'WOODFORD',
									uc_s = '103' 				=> 'CITY OF CHICAGO',
									uc_s in county_list => uc_s,
									'**|'+uc_s
									);
		END;

		//****************************************************************************
		//CorpFedTaxID: returns the "corp_fed_tax_id"
		//****************************************************************************
		EXPORT CorpFedTaxID(STRING s) := FUNCTION
			 uc_s := corp2.t2u(s);
			 
			 //The search pattern is looking for the following:
			 //1) A string of nine numbers of the same digit.  E.g. 000000000 or 111111111
			 //2) A string of "123456789" (which is also an invalid federal tax id 
			 searchpattern := '^(0{9})*(1{9})*(2{9})*(3{9})*(4{9})*(5{9})*(6{9})*(7{9})*(8{9})*(9{9})*(123456789)*$';
			 
			 cleaned_fein := if(regexfind(searchpattern,uc_s,0) <> '','',uc_s);

			 RETURN if(length(cleaned_fein) <> 9,'',cleaned_fein);

		END;

		//****************************************************************************
		//CorpNameComment: returns the "corp_name_comment" for LLC.
		//Note: cc => ll_assumed_can_code_42006
		//****************************************************************************
		EXPORT CorpNameComment(STRING cd, STRING cc, STRING ad, STRING rd) := FUNCTION

				cancel_date					 := if(corp2.t2u(cd)<>'' or (integer)cd <> 0,ut.date_YYYYMMDDtoDateSlashed(cd),'');  	//ll_assumed_can_date_42006
				adopted_date 			   := if(corp2.t2u(ad)<>'' or (integer)ad <> 0,ut.date_YYYYMMDDtoDateSlashed(ad),''); 	//ll_assumed_adopt_date_42006
				renew_date	  			 := if(corp2.t2u(rd)<>'' or (integer)rd <> 0,ut.date_YYYYMMDDtoDateSlashed(rd),'');		//ll_assumed_renew_date_42006
				
				cancelcode_desc		 	 := if(Corp2_mapping.fValidateDate(cd,'CCYYMMDD').GeneralDate<>'',
																	 map(corp2.t2u(cc) = '1' => 'VOLUNTARY CANCELLATION: ' 	 + cancel_date,
																			 corp2.t2u(cc) = '2' => 'INVOLUNTARY CANCELLATION: ' + cancel_date,
																			 ''
																		  ),
																	 ''
																	);
				adopted_desc				 := if(Corp2_mapping.fValidateDate(ad,'CCYYMMDD').GeneralDate<>'','ADOPTED DATE: '+adopted_date,'');
				renew_desc					 := if(Corp2_mapping.fValidateDate(rd,'CCYYMMDD').GeneralDate<>'','RENEWAL DATE: '+renew_date,'');
				cancel_desc				 	 := if(Corp2_mapping.fValidateDate(cd,'CCYYMMDD').GeneralDate<>'','CANCELLATION DATE: '+cancel_date,'');			
				name_comment				 := cancelcode_desc+if(adopted_desc<>'','; '+adopted_desc,'')+if(renew_desc<>'','; '+renew_desc,'')+if(cancel_desc<>'','; '+cancel_desc,'');
				cleaned_name_comment := regexreplace('^(\\;)',name_comment,'');

				RETURN corp2.t2u(cleaned_name_comment);

		END;

		//****************************************************************************
		//CorpStatusDesc: returns the "corp_status_desc" for LLC.
		//****************************************************************************
		EXPORT CorpStatusDesc(STRING s) := FUNCTION

			 uc_s := corp2.t2u(s);

			 RETURN MAP(uc_s = '00'		=>'GOOD STANDING',
									uc_s = '01'		=>'REINSTATED',
									uc_s = '02'		=>'NOT IN GOOD STANDING',
									uc_s = '03'		=>'FEIN DELINQUENT',
									uc_s = '04'		=>'UNACCEPTABLE PAYMENT',
									uc_s = '05'		=>'AGENT VACATED',
									uc_s = '06'		=>'WITHDRAWN',
									uc_s = '07'		=>'REVOKED',
									uc_s = '08'		=>'VOLUNTARY DISSOLUTION',
									uc_s = '09'		=>'INVOLUNTARY DISSOLUTION',
									uc_s = '10'		=>'MERGED',
									uc_s = '11'		=>'EXPIRED',
									uc_s = '12'		=>'AB INITIO',
									uc_s = '13'		=>'BANKRUPTCY',
									uc_s = '14'		=>'SUSPENDED',
									''
								 );
		END;

END;