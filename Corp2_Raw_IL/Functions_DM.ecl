IMPORT address, corp2, corp2_mapping, std, ut;

EXPORT Functions_DM := MODULE
		
		//****************************************************************************
		//State_Foreign_Codes: returns whether the state/foreign code is a known 
		//										 code and if so, what the corresponding code is.
		//****************************************************************************
		EXPORT State_Foreign_Codes(string s) := FUNCTION

					 uc_s := corp2.t2u(s);
					 
					 RETURN map (uc_s in ['01'] => 'AL',
											 uc_s in ['02'] => 'AK', 
											 uc_s in ['05'] => 'AR', 
											 uc_s in ['03'] => 'AS', 
											 uc_s in ['04'] => 'AZ', 
											 uc_s in ['06'] => 'CA', 
											 uc_s in ['08'] => 'CO', 
											 uc_s in ['09'] => 'CT',
											 uc_s in ['07'] => 'CZ',
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
											uc_s = '01' => 'ALABAMA',
											uc_s = '02' => 'ALASKA', 
											uc_s = '05' => 'ARKANSAS', 
											uc_s = '03' => 'AMERICAN SAMOA', 
											uc_s = '04' => 'ARIZONA', 
											uc_s = '06' => 'CALIFORNIA', 
											uc_s = '08' => 'COLORADO', 
											uc_s = '09' => 'CONNECTICUT',
											uc_s = '07' => 'CANAL ZONE',										
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

		//********************************************************************
		//ARTaxAmountPaid: returns the "ar_tax_amount_paid".
		//Note: This routine formats a number into a "dollar amount" format.		
		//********************************************************************
		EXPORT ARTaxAmountPaid(STRING pmoney,BOOLEAN pdecimalpoint = TRUE) := FUNCTION
				trim_money						:= corp2.t2u(pmoney);
				integerpart						:= if(pdecimalpoint,trim_money[1..length(pmoney)-2],trim_money);
				fractional_part				:= pmoney[length(trim_money) - 1.. length(trim_money)];
				integer_with_commas 	:= stringlib.stringreverse(regexreplace('([0-9]{3})(?=[0-9])',stringlib.stringreverse((string)(integer) integerpart),'$1,'));
				RETURN '$' + integer_with_commas + if (pdecimalpoint,'.'+fractional_part,'');
		END;

		//****************************************************************************
		//ContAddressDM: returns the address portion of the contact name/address.
		//****************************************************************************
		EXPORT ContAddress(STRING s) := FUNCTION

				uc_s  := stringlib.stringtouppercase(s);

				//****************************************************************************
				//removeBadChars: remove "I" or "I"+ that begins at the beginning of the field.
				//****************************************************************************
				removeBadChars(STRING uc_s)	:=	FUNCTION
						RETURN if(regexfind('^(\\"I\\")(\\+)*( )*',uc_s,0)<>'',regexreplace('^(\\"I\\")(\\+)*( )*',uc_s,''),uc_s);
				END;
				
				fixBadChars := removeBadChars(uc_s);

				//****************************************************************************
				//addNameAddrSeparator: In trying to find where the person's name ENDs and the
				//											address begins, certain addresses don't begin with a 
				//											"digit".  This logic is an attempt to find the beginning
				//											of the address where a "digit" doesn't exist.
				//****************************************************************************
				addNameAddrSeparator(STRING uc_s)	:=	FUNCTION
						nameaddrseparators 		:= '( R( )*R | NEW | APT | HC 3 | MILL POND RD | FRANKLIN GROVE  61031 | FAIRMOUNT ADDITION ALTON )';
						addseparator			 		:= regexreplace(nameaddrseparators,uc_s,' ^$1');
						addtilda					 		:= regexreplace('(^[A-Za-z,-.\' ]* )(.*)',addseparator,'$1~$2');
						nameaddrwithseparator := addtilda;
						RETURN nameaddrwithseparator;
				END;
				
				addseparator := addnameaddrseparator(fixbadchars);

				//****************************************************************************
				//standardize_POBOX: returns a "standardized" verbiage for "PO BOX".
				//****************************************************************************
				standardize_POBOX(STRING uc_s)	:=	FUNCTION
						poboxpattern 			:= 'P(.)*( )*O(.)*( )*B( )*O( )*X( )*|P(.)*( )*O(.)*( )*B( )*';
						pobpattern	 			:= 'P(.)*( )*O(.)*( )*B( )*';
						boxpattern	 			:= 'B(.)*( )*O(.)*( )*X( )*';
						postofficepattern := 'P(.)*( )*O(.)*( )*S( )*T( )*O( )*F(.)*( )*F(.)*( )*I( )*C(.)*( )*E(.)*( )*';
						popattern					:= poboxpattern + pobpattern + boxpattern + postofficepattern;
						RETURN regexreplace(popattern, uc_s, ' PO BOX ');
				END;
	
				fixedaddr  := standardize_POBOX(addseparator);

				//****************************************************************************
				//This MAP FUNCTIONality tries to identify where the address begins and adds a
				//"~" (tilda) directly before the address.  This is for "splitting" purposes;
				//to be able to identify where the contact name ENDs and the address begins.
				//****************************************************************************
				findaddresslocation := 	map(regexfind(' PO BOX ', fixedAddr, 0)<>'' =>	regexreplace(' PO BOX ', fixedAddr, '$1~ PO BOX $2'),
																		regexfind(' ONE'    , fixedAddr, 0)<>'' => regexreplace(' ONE'		 , fixedAddr, '$1~ ONE$2'),
																		regexfind(' TWO'    , fixedAddr, 0)<>'' => regexreplace(' TWO'		 , fixedAddr, '$1~ TWO$2'),
																		regexfind(' THREE'  , fixedAddr, 0)<>'' => regexreplace(' THREE'	 , fixedAddr, '$1~ THREE$2'),
																		regexfind(' FOUR'   , fixedAddr, 0)<>'' => regexreplace(' FOUR'	 	 , fixedAddr, '$1~ FOUR$2'),
																		regexfind(' FIVE'   , fixedAddr, 0)<>'' => regexreplace(' FIVE'	 	 , fixedAddr, '$1~ FIVE$2'),
																		regexfind(' SIX'    , fixedAddr, 0)<>'' => regexreplace(' SIX'		 , fixedAddr, '$1~ SIX$2'),
																		regexfind(' SEVEN'  , fixedAddr, 0)<>'' => regexreplace(' SEVEN'	 , fixedAddr, '$1~ SEVEN$2'),
																		regexfind(' EIGHT'  , fixedAddr, 0)<>'' => regexreplace(' EIGHT'	 , fixedAddr, '$1~ EIGHT$2'),
																		regexfind(' NINE'   , fixedAddr, 0)<>'' => regexreplace(' NINE'	 	 , fixedAddr, '$1~ NINE$2'),
																		regexfind(' TEN'    , fixedAddr, 0)<>'' => regexreplace(' TEN'		 , fixedAddr, '$1~ TEN$2'),
																		stringlib.stringfilter(fixedAddr,'1234567890')<>''=> regexreplace('(^[A-Z\\(\\),-.\' ]*)(.*)', fixedaddr, '$1~$2'),
																		fixedaddr
																	 );

				fulladdress 		:= if(stringlib.stringfind(findaddresslocation,'~',1)<>0,
															findAddressLocation[stringlib.stringfind(findaddresslocation,'~',1)+1..], //if an address is found
															findaddresslocation //if no address is found
														 );
				removeseparators:= corp2.t2u(stringlib.stringfilterout(fulladdress,'^~'));
				zip 						:= regexfind('[0-9]{5}\\-*[0-9]{0,4}$',removeseparators,0); //identify zip code
				cleanedaddress	:= regexreplace(zip,removeseparators,''); //remove zip from address line
				tempaddress 		:= address.cleanaddress182(cleanedaddress,zip); 

				addressline1 		:= regexreplace(corp2.t2u(tempaddress[65..89])+' '+corp2.t2u(tempaddress[115..116]),corp2.t2u(tempaddress[1..64]),'');
				//****************************************************************************
				//Note:
				//tempAddress[1..64] 			=> contains the address line1 information
				//tempAddress[65..89] 		=> contains the city
				//tempAddress[115..116]		=> contains the state code
				//tempAddress[117..125]		=> contains the zip code (all 9 digits if they exist)
				//****************************************************************************
				RETURN corp2.t2u(addressline1) + '|' + corp2.t2u(tempaddress[65..89]) + '|' + corp2.t2u(tempaddress[115..116]) + '|' + corp2.t2u(tempaddress[117..125]);
		END;

		//****************************************************************************
		//ContName: returns the "cont_full_name".
		//****************************************************************************
		EXPORT ContName(STRING s) := FUNCTION

				//****************************************************************************
				//fixbadname:  returns any name that contains "I" or "I"+ in the beginning of
				//						 of the name.  The "I" indicates then this is an incorporator
				//						 and not necessarily the "president".
				//
				//						 Also blank out any bad "contact" names.  
				//****************************************************************************
				fixbadname(STRING s)	:=	FUNCTION
						uc_s	  						:= corp2.t2u(s);
						clean_incorporator	:= if(regexfind('\\"I\\"(\\+)*( )*',uc_s,0)<>'',regexreplace('\\"I\\"(\\+)*( )*',uc_s,''),uc_s);
						clean_title					:= if(regexfind('SEC\\/( )*VP( )*',clean_incorporator,0)<>'',regexreplace('SEC\\/( )*VP( )*',clean_incorporator,''),clean_incorporator);
						cleanname						:= clean_title;
						RETURN map(corp2.t2u(cleanname) in ['IL','ILLINOIS','NA','ST','STE']	=> '',
											 corp2.t2u(cleanname) in ['REGISERED NAME EXPIRED'] 				=> '',
											 corp2.t2u(cleanname)
											);
				END;

				//****************************************************************************
				//standardizePOBOX: returns a "standardized" verbiage for "PO BOX".
				//****************************************************************************
				standardizePOBOX(STRING a)	:=	FUNCTION
						uc_a 							:= corp2.t2u(a);
						poboxpattern 			:= 'P(\\.)*( )*O(\\.)*( )*B( )*O( )*X( )*|P(\\.)*( )*O(\\.)*( )*B( )*';
						pobpattern	 			:= 'P(\\.)*( )*O(\\.)*( )*B( )*';
						boxpattern	 			:= 'B(\\.)*( )*O(\\.)*( )*X( )*';
						pobxpattern	 			:= 'P(\\.)*( )*O(\\.)*( )*B(\\.)*( )*X(.)*( )*';						
						postofficepattern := 'P(\\.)*( )*O(\\.)*( )*S( )*T( )*O( )*F(\\.)*( )*F(\\.)*( )*I( )*C(\\.)*( )*E(\\.)*( )*';
						popattern					:= poboxpattern + pobpattern + boxpattern + pobxpattern + postofficepattern;
						RETURN regexreplace(popattern, uc_a, ' PO BOX ');
				END;
	
				uc_s  := standardizePOBOX(fixbadname(s));

				//****************************************************************************
				//This map functionality tries to identify where the address begins and adds a
				//"~" (tilda) directly before the address.  This is for "splitting" purposes;
				//to be able to identify where the contact name ends and the address begins.
				//****************************************************************************
				findaddresslocation := 	map(regexfind(' PO BOX '  , uc_s, 0)<>'' 					=> regexreplace(' PO BOX '			 						, uc_s, '$1~ PO BOX $2'),
																		regexfind(' ONEILL'   , uc_s, 0)<>'' 					=> regexreplace(' ONEILL' 			 						, uc_s, ' ONEILL$1~$2'),
																		regexfind(' ONE'      , uc_s, 0)<>'' 					=> regexreplace(' ONE'		 			 						, uc_s, '$1~ ONE$2'),
																		regexfind(' TWO'      , uc_s, 0)<>'' 					=> regexreplace(' TWO'		 			 						, uc_s, '$1~ TWO$2'),
																		regexfind(' THREE'    , uc_s, 0)<>'' 					=> regexreplace(' THREE'	 			 						, uc_s, '$1~ THREE$2'),
																		regexfind(' FOUR'     , uc_s, 0)<>'' 					=> regexreplace(' FOUR'	 			 	 						, uc_s, '$1~ FOUR$2'),
																		regexfind(' FIVE'     , uc_s, 0)<>'' 					=> regexreplace(' FIVE'	 				 						, uc_s, '$1~ FIVE$2'),
																		regexfind(' SIX'      , uc_s, 0)<>'' 					=> regexreplace(' SIX'		 			 						, uc_s, '$1~ SIX$2'),
																		regexfind(' SEVEN'    , uc_s, 0)<>'' 					=> regexreplace(' SEVEN'	 			 						, uc_s, '$1~ SEVEN$2'),
																		regexfind(' EIGHT'    , uc_s, 0)<>'' 					=> regexreplace(' EIGHT'	 									, uc_s, '$1~ EIGHT$2'),
																		regexfind(' NINE'     , uc_s, 0)<>''					=> regexreplace(' NINE'	 			 	 						, uc_s, '$1~ NINE$2'),
																		regexfind(' TEN'      , uc_s, 0)<>'' 					=> regexreplace(' TEN'		 			 						, uc_s, '$1~ TEN$2'),
																		regexfind(' LIVERY CT', uc_s, 0)<>'' 					=> regexreplace(' LIVERY CT'		 						, uc_s, '$1~ LIVERY CT$2'),
																		//Note: If numeric data exists in the input string then an address exists.  To separate out the contact name from the
																		//address portion look for alpha characters at the beginning of the string (identified as $1) along with other possible
																		//special characters and (.*) identifies the address portion (represented by $2).  A "tilda" separates the two parts.
																		stringlib.stringfilter(uc_s,'1234567890')<>''	=> regexreplace('(^[A-Z\\(\\),-.&\' ]*)(.*)', uc_s, '$1~$2'),
																		uc_s
																	 );

				//Note:  Found that both a street and a po box number exists as part of the address.  This does an additional check
				//			 to ensure no additional numeric values exists.
				temp_name		 	:= if(stringlib.stringfilter(findaddresslocation,'1234567890')<>'',regexreplace('(^[A-Z\\(\\),-.&\' ]*)(.*)', findaddresslocation, '$1~$2'),findaddresslocation);

				contact_name 	:= if(stringlib.stringfind(temp_name,'~',1)<>0,
														temp_name[1..stringlib.stringfind(temp_name,'~',1)-1], //if an address is found
														temp_name //if no address is found
													 );
													 
				RETURN contact_name;
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

			 RETURN MAP(uc_s in ['','000']	=> '',			//unknown
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
									uc_s in county_list => corp2.t2u(s),
									'**|'+corp2.t2u(s)
									);
		END;

		//****************************************************************************
		//CorpAnniversaryMonth: returns the "corp_anniversary_month"
		//****************************************************************************
		EXPORT CorpAnniversaryMonth(string s) := FUNCTION
		
			 uc_s := corp2.t2u(s);
			 
			 RETURN map(uc_s = '01'	=> 'JANUARY',
								  uc_s = '02'	=> 'FEBRUARY',
								  uc_s = '03'	=> 'MARCH',
								  uc_s = '04'	=> 'APRIL',                                                    
								  uc_s = '05'	=> 'MAY',
								  uc_s = '06'	=> 'JUNE',                                                    
								  uc_s = '07'	=> 'JULY',
								  uc_s = '08'	=> 'AUGUST',                                                    
								  uc_s = '09'	=> 'SEPTEMBER',
								  uc_s = '10'	=> 'OCTOBER',
								  uc_s = '11'	=> 'NOVEMBER',
								  uc_s = '12'	=> 'DECEMBER',
								  ''
								 );
		END;

		//****************************************************************************
		//CorpLNNameTypeDesc: returns the "corp_ln_name_type_desc" for AssumedNames.
		//****************************************************************************
		EXPORT CorpLNNameTypeDesc(string s) := FUNCTION
		
					 uc_s := corp2.t2u(s);

					 RETURN MAP(uc_s = '1' => 'ASSUMED',
											uc_s = '2' => 'OLD NAME',
											uc_s = '3' => 'EXPIRED',
											uc_s = '4' => 'FOREIGN ASSUMED',
											uc_s = '5' => 'VOLUNTARY CANCELLATION',
											uc_s = '6' => 'INVOLUNTARY CANCELLATION',
											uc_s = '7' => 'FORGN ASSUMED VOL CANCELLATION',
											uc_s = '8' => 'NOT-FOR-PROFIT ASSUMED',
											uc_s = '9' => 'NOT-FOR-PROFIT FOREIGN ASSUMED',
											''
										 );

		END; 

		//****************************************************************************
		//CorpNameCommentDM: returns the "corp_name_comment" for Daily/Monthly.
		//	 name_currdate	 = cd40008_assumed_curr_date 	-> renewal date
		//	 name_canceldate = cd40008_date_cancel			 	-> cancel date
		//	 name_date			 = cd40008_assumed_old_date 	-> adoption date
		//	 name_ind		   	 = cd40008_assumed_old_ind
		//****************************************************************************
		EXPORT CorpNameComment(STRING cd, STRING oi, STRING ad, STRING rd) := FUNCTION
				cancel_date					 := if(corp2.t2u(cd)<>'' or (integer)cd <> 0,ut.date_YYYYMMDDtoDateSlashed(cd),'');
				adopted_date 			   := if(corp2.t2u(ad)<>'' or (integer)ad <> 0,ut.date_YYYYMMDDtoDateSlashed(ad),'');
				renew_date	  			 := if(corp2.t2u(rd)<>'' or (integer)rd <> 0,ut.date_YYYYMMDDtoDateSlashed(rd),'');

				isvalidadoptedpast	 := if(corp2_mapping.fValidateDate(ad,'CCYYMMDD').PastDate<>'',true,false);
				isvalidadopted			 := if(corp2_mapping.fValidateDate(ad,'CCYYMMDD').GeneralDate<>'',true,false);
				isvalidrenew				 := if(corp2_mapping.fValidateDate(rd,'CCYYMMDD').GeneralDate<>'',true,false);
				isvalidcancel			 	 := if(corp2_mapping.fValidateDate(cd,'CCYYMMDD').GeneralDate<>'',true,false);
																																								
				adopted_desc				 := if(isvalidadopted,'ADOPTED DATE: '+adopted_date,'');
				renew_desc					 := if(isvalidrenew,'RENEWAL DATE: '+renew_date,'');
				cancel_desc				 	 := if(isvalidcancel,'CANCELLATION DATE: '+cancel_date,'');			
				
				name_comment				 := if(adopted_desc<>'',adopted_desc,'')+if(renew_desc<>'','; '+renew_desc,'')+if(cancel_desc<>'','; '+cancel_desc,'');
				cleaned_name_comment := regexreplace('^(\\;)',name_comment,'');
				new_name_comment		 := map(corp2.t2u(oi) in ['1','4','8','9'] and isvalidadoptedpast => 'DATE ASSUMED NAME ORIGINALLY ADOPTED: '+ adopted_date,
																		corp2.t2u(oi) in ['2']	and isvalidadoptedpast 						=> 'DATE NAME CONSIDERED OLD: '+ adopted_date,
																		''
															 		 );
				RETURN if(corp2.t2u(new_name_comment)<>'',
									if(corp2.t2u(cleaned_name_comment)<>'',
										 corp2.t2u(cleaned_name_comment + '; ' + new_name_comment),
										 corp2.t2u(new_name_comment)
										 ), //end new_name_comment <> ''
									if(corp2.t2u(cleaned_name_comment)<>'',
										 corp2.t2u(cleaned_name_comment),
										 ''
										 )  //end new_name_comment = ''
									);
		END;

		//****************************************************************************
		//CorpNameStatusDescriptionDM: returns the "corp_name_status_description".
		//****************************************************************************
		EXPORT CorpNameStatusDescription(STRING d1, STRING d2) := FUNCTION
			 uc_d1 := corp2.t2u(d1); //date_cancel
			 uc_d2 := corp2.t2u(d2); //assumed_curr_date
			 isD1ValidDate	:= if(corp2_mapping.fValidateDate(uc_d1,'CCYYMMDD').PastDate <>'',true,false);
			 isD2ValidDate	:= if(corp2_mapping.fValidateDate(uc_d2,'CCYYMMDD').PastDate <>'',true,false);			 
			 RETURN map(isD1ValidDate and isD2ValidDate 				=> 'NAME RENEWED',
									isD1ValidDate 													=> 'NAME CANCELLED',
									isD2ValidDate and uc_d2[5..8] <> '0101' => 'ASSUMED NAME RENEWED', //MM & DD cannot be 01
									''
								 );
		END;
										 
		//****************************************************************************
		//CorpOrigBusTypeDesc: returns the "corp_orig_bus_type_desc".
		//****************************************************************************
		EXPORT CorpOrigBusTypeDesc(string s) := FUNCTION

			 uc_s := corp2.t2u(s); //cd41100_corp_intent

			 RETURN map(uc_s = '000' => '',
									uc_s = '001' => 'ADVERTISING',
									uc_s = '002' => 'AGRICULTURE ENTERPRISE',
									uc_s = '003' => 'AMUSEMENTS AND RECREATIONAL',
									uc_s = '004' => 'AUTOMOBILE AND OTHER REPAIR SHOPS',
									uc_s = '005' => 'AUTOMOBILE,TRUCK,IMPLEMENT, AND BOAT DEALERS',
									uc_s = '006' => 'BUILDING OWNERSHIP AND OPERATION',
									uc_s = '007' => 'BUSINESS SERVICES - CREDIT BUREAUS AND COLLECTION AGENCIES; ' + 
																  'PERSONAL SUPPLY SERVICES;MANAGEMENT, CONSULTING AND PUBLIC RELATIONS; ' +
																  'DETECTIVE AND PROTECTION AGENCIES, ETC.',
									uc_s = '008' => 'CEMETERIES',
									uc_s = '009' => 'COAL MINING AND SALE OF COAL',
									uc_s = '010' => 'COMMODITIES AND FUTURES BROKERS',
									uc_s = '011' => 'COMMUNICATION-RADIO AND TV BROADCASTING,CABLEVISION',
									uc_s = '012' => 'CONSTRUCTION-GENERAL BUILDING CONTRACTORS',
									uc_s = '013' => 'CONSTRUCTION-SPECIAL TRADE CONTRACTORS - PLUMBING, HEATING ' +
								                  'ELECTRICAL,MASONRY,CARPENTRY,ROOFING,LANDSCAPING, ETC' ,
									uc_s = '014' => 'CURRENCY EXCHANGES',
									uc_s = '015' => 'DISC CORPORATIONS',
									uc_s = '016' => 'FINANCIAL,LENDING AND INVESTMENT INSTITUTIONS OTHER THAN BANKS',
									uc_s = '017' => 'HEALTH SERVICES-PHYSICIANS,DENTISTS, AND OTHER HEALTH PRACTITIONERS',
									uc_s = '018' => 'HEALTH SERVICES-NURSING HOMES,HOSPITALS, AND CLINICS',
									uc_s = '019' => 'HOTELS,MOTELS, AND OTHER LODGING',
									uc_s = '020' => 'IMPROVING AND BREEDING OF STOCK',
									uc_s = '021' => 'INSURANCE AND/OR REAL ESTATE AGENCIES AND BROKERS',
									uc_s = '022' => 'LEASING OR RENTAL-EQUIPMENT,AUTOS, ETC',
									uc_s = '023' => 'MANUFACTURING (ONLY)',
									uc_s = '024' => 'MANUFACTURING AND MERCANTILE (ONLY)',
									uc_s = '025' => 'MERCANTILE (SALES ONLY, NO SERVICE)',
									uc_s = '026' => 'PERSONAL SERVICES - BARBER AND BEAUTY SHOPS, LAUNDRY AND DRY CLEANING ' +
								                  'PHOTOGRAPHIC STUDIOS, HEALTH SPAS, ETC',
									uc_s = '027' => 'PETROLEUM PRODUCTION,METAL MINING, QUARRYING',
									uc_s = '028' => 'PRINTING AND PUBLICATION',
									uc_s = '029' => 'PROFESSIONAL SERVICES - LEGAL, ACCOUNTING, ENGINEERING, ETC. ' +
								                  '(REGISTER WITH REGISTRATION AND EDUCATION)',
									uc_s = '030' => 'REAL ESTATE INVESTMENT',
									uc_s = '031' => 'RESTAURANT AND LOUNGE',
									uc_s = '032' => 'RETAIL SALES AND SERVICE',
									uc_s = '033' => 'SCHOOLS AND OTHER EDUCATIONAL SERVICES',
									uc_s = '034' => 'TRANSPORTATION-FREIGHT',
									uc_s = '035' => 'TRANSPORTATION-PASSENGER',
									uc_s = '036' => 'UTILITIES',
									uc_s = '037' => 'WAREHOUSING,STORAGE AND/OR FREIGHT FORWARDING',
									uc_s = '038' => 'CORPORATION REGISTERED AGENT',
									uc_s = '039' => 'WHOLESALE SALES',
									uc_s = '040' => 'WHOLESALE AND RETAIL',
									uc_s = '042' => '', //unknown									
									uc_s = '043' => '', //unknown
									uc_s = '041' => 'MEDICAL,X-RAY OR DENTAL LABORATORY',
									uc_s = '044' => 'ALL INCLUSIVE PURPOSE',
									uc_s = '045' => 'BUSINESS CORPORATION',
									uc_s = '046' => 'ATHLETIC',
									uc_s = '047' => 'CHARITABLE OR BENEVOLENT',
									uc_s = '048' => 'CONDOMINIUM ASSOCIATION',
									uc_s = '049' => 'EDUCATIONAL,RESEARCH, OR SCIENTIFIC',
									uc_s = '050' => 'CIVIC OR PATRIOTIC',
									uc_s = '051' => 'POLITICAL',
									uc_s = '052' => 'PROFESSIONAL,COMMERCIAL, OR TRADE ASSOCIATION',
									uc_s = '053' => 'RELIGIOUS',
									uc_s = '054' => 'SOCIAL',
									uc_s = '055' => 'COOPERATIVE HOUSING',
									uc_s = '056' => 'HOMEOWNERS ASSOCIATION-AS DEFINED BY CIVIL PROCEDURE ACT',
									uc_s = '060' => 'NOT FOR PROFIT',
									'**|'+uc_s
								 );

		END;

		//****************************************************************************
		//CorpOrigOrgStructureDescDM: returns the "corp_orig_org_structure_desc"
		//														for Daily/Monthly.
		//****************************************************************************
		EXPORT CorpOrigOrgStructureDesc(STRING s) := FUNCTION
			 
			 uc_s := corp2.t2u(s);

			 RETURN MAP(uc_s = '2' => 'SUMMONS - NOT QUALIFIEED',
									uc_s = '3' => 'REGISTRATION NAME ONLY',
									uc_s = '4' => 'DOMESTIC BCA',
									uc_s = '5' => 'NOT FOR PROFIT',
									uc_s = '6' => 'FOREIGN BCA',
									uc_s						
								 );
								 
		END;

		//****************************************************************************
		//CorpStatusDateDM: returns the "corp_status_date".
		//****************************************************************************
		EXPORT CorpStatusDate(STRING s) := FUNCTION
			 filtered_s 	:= stringlib.stringfilter(s,'0123456789');
			 RETURN (STRING)Std.Date.FromStringToDate(filtered_s,'%m%d%y');
		END;

		//****************************************************************************
		//CorpStatusDescDM: returns the "corp_status_desc".
		//****************************************************************************
		EXPORT CorpStatusDesc(STRING s, STRING a) := FUNCTION

			 datepattern	:= '([0-9]{2})( )+([0-9]{2})( )+([0-9]{2})$';
			 outpattern 	:= '$1/$3/$5'; //Note:  For each grouping (designated by enclosed parens) in "datepattern"
																	 //				above (e.g. ([0-9]{2}) is $1, ( )+ is $2, ([0-9]{2}) is $3, etc.)
																	 //				it can be identified by a numeric value such as $1, $2, etc.  
																	 //Note:  outpattern adds a "/" between each grouping.

			 uc_s					:= corp2.t2u(s); //cd41100_status
			 uc_a 				:= corp2.t2u(a); //cd41100_sec_name_addr

			 RETURN map(uc_s = '00'																						=> 'GOOD STANDING',
									uc_s = '01'																						=> 'REINSTATED',
									uc_s = '02'																						=> 'INTENT TO DISSOLVE',
									uc_s = '03'																						=> 'BANKRUPTCY',
									uc_s = '04'																						=> 'UNACCEPTABLE PAYMENT',
									uc_s = '05'																						=> 'AGENT VACATED',
									uc_s = '06'																						=> 'WITHDRAWN',
									uc_s = '07'																				 		=> 'REVOKED',
									uc_s = '08' and regexfind('DISSOLUTION',uc_a,0) <> ''	=> regexreplace(datepattern,corp2.t2u(uc_a),outpattern), //this adds "/" if a date pattern exists
									uc_s = '08' and regexfind('DISSOLUTION',uc_a,0) = ''	=> 'DISSOLVED',									
									uc_s = '09'																						=> 'MERGED/CONSOLIDATED',
									uc_s = '10'																						=> 'REGISTERED NAME EXPIRATION',
									uc_s = '11'																						=> 'EXPIRED',
									uc_s = '12'																						=> 'REGISTERED NAME CANCELLATION',
									uc_s = '13'																						=> 'SPECIAL ACT CORPORATION',
									uc_s = '14'																						=> 'SUSPENDED',
									''
								 );
		END;

		//****************************************************************************
		//EventDesc: returns the "event_desc".
		//****************************************************************************
		EXPORT EventDesc(STRING s) := FUNCTION
		
			 uc_s 	:= corp2.t2u(s); //cd41100_section_code

			 RETURN map(uc_s = ''			=> '',
									uc_s = '0035' => 'ARTICLES OF AMENDMENT NOT FOR PROFIT (DOMESTIC)',
									uc_s = '0040' => 'CERTIFIED COPY OF ARTICLES OF AMENDMENT NOT FOR PROFIT',
									uc_s = '0041'	=> 'CORRESPONDENCE FROM FORMAT 41', 
									uc_s = '0042'	=> 'CORRESPONDENCE FROM FORMAT 42', 
									uc_s = '0051'	=> 'NOTICE OF CAPITAL INCREASE LETTER', 
									uc_s = '0052'	=> 'FINAL NOTICE OF CAPITAL INCREASE LETTER',  
									uc_s = '0053'	=> 'INCREASE OF CAPITAL REPORTED IN ERROR',
									uc_s = '0055' => 'ARTICLES OF AMENDMENT BUSINESS CORPORATION (DOMESTIC)',
									uc_s = '0065' => 'ARTICLES OF MERGER DOMESTIC BUSINESS CORPORATIONS',
									uc_s = '0066' => 'ARTICLES OF MERGER BETWEEN DOMESTIC BUSINESS PARENT CORPORATION AND WHOLLY OWN SUBSIDIARY',
									uc_s = '0069' => 'ARTICLES OF MERGER BETWEEN DOMESTIC BUSINESS AND FOREIGN CORPORATION',
									uc_s = '0112'	=> 'CERTIFIED COPY OF AMENDMENT FOREIGN CORPORATION',
									uc_s = '0113'	=> 'CERTIFIED COPY OF MERGER OF FOREIGN CORPORATION',
									uc_s = '0114'	=> 'APPLICATION FOR AMENDED AUTHORITY FOREIGN CORPORATION',
									uc_s = '0115'	=> 'STATEMENT OF CORRECTION', 
									uc_s = '0117'	=> 'PETITION FOR REFUND',  
									uc_s = '0139'	=> 'ARTICLES OF MERGER BETWEEN DOMESTIC BUSINESS CORPORATION AND LLC',
									uc_s = '0199'	=> 'MERGER NO FEE',
									uc_s = '0204'	=> 'REINSTATEMENT',
									uc_s = '0222'	=> 'AGENT CHANGE NO FEE',
									uc_s = '0511'	=> 'NOT FOR PROFIT REGISTERED AGENT CHANGE',
									uc_s = '0525'	=> 'REGULAR SUMMONS - CORPORATION EXITS', 
									uc_s = '0530'	=> 'NON-QUALIFIED SUMMONS - NO CORPORATION EXISTS', 
									uc_s = '1030'	=> 'ARTICLES OF AMENDMENT BUSINESS CORPORATION (DOMESTIC)',
									uc_s = '1031'	=> 'ARTICLES OF AMENDMENT NOT FOR PROFIT (DOMESTIC)',
									uc_s = '1125'	=> 'ARTICLES OF MERGER DOMESTIC CORPORATIONS',
									uc_s = '1126'	=> 'ARTICLES OF MERGER DOMESTIC NOT FOR PROFIT CORPORATIONS',
									uc_s = '1130'	=> 'ARTICLES OF MERGER BETWEEN DOMESTIC PARENT AND WHOLLY OWN SUBSIDIARY',
									uc_s = '1135'	=> 'CERTIFIED COPY OF MERGER BETWEEN DOMESTIC AND FOREIGN BUSINESS CORPORATIONS',
									uc_s = '1225'	=> 'ARTICLES OF REVOCATION OF DISSOLUTION',
									uc_s = '1245'	=> 'REINSTATEMENT',
									uc_s = '1330'	=> 'CERTIFIED COPY OF AMENDMENT FOREIGN CORPORATION',
									uc_s = '1335'	=> 'CERTIFIED COPY OF ARTICLES OF MERGER FOREIGN',
									uc_s = '1340'	=> 'AMENDED AUTHORITY OF FOREIGN CORPORATION',
									uc_s = '6666'	=> 'COUNTY RECORDER PAYMENTS',
									uc_s = '9999'	=> 'MISCELLANEOUS',
									uc_s in ['0000','0001','0003','0006','0012','0015','0030','0039',
													 '0044','0047','0048','0089','0093','0094','0095','0106',
													 '0119','0120','0131','0133','0150','0164','0185','0194',
													 '0200','0203','0205','0402','0409','0411','0412','0415',
													 '0450','0461','0495','0505','0520','0545','0645','0845',
													 '0900','0924','0943','0946','0948','0950','0954','0995',
													 '1009','1011','1021','1035','1040','1060','1061','1110',
													 '1137','1139','1212','1222','1226','1240','1270','1310',
													 '1316','1331','1333','1334','1341','1360','1400','1401',
													 '1408','1410','1412','1420','1425','1431','1435','1445',
													 '1455','1495','1510','1515','1520','2011','4015','4105',
													 '6194','8435','9450','9506'] => '', //unknown 							
									'**|'+uc_s
								 );		
		END;

		//****************************************************************************
		//StockClassDM: returns the "stock_class".
		//****************************************************************************
		EXPORT StockClass(STRING s) := FUNCTION
				uc_s 					:= corp2.t2u(stringlib.stringfilterout(s,'"\\\'\\\\'));

				common 				:= 'COMMON \\:|COMMON\\:|COMMON \\.|COMMON\\.|COMMON|COM\\.|COMM\\.|COMM\\:|COMMO|COM|CMN|COOM';
				preferred 		:= 'PREFERRED|PREFERRE |PREF |PREF\\.|PREFD|PREFERD';
				cumulative 		:= 'CUMULATIVE|CUMULATIV$|CUMULATIV|CUMULAT';
				nonvoting			:= 'NONVOTING|NON VOTING|NON\\-VOTING|NON \\-VOTING|NON-VOTIN|NON-VOTI|NON \\-VO|NON\\-VO|NON\\-V|NON_VOTING';
				voting				:= 'VOTING|VOTTING';
				stock					:= 'STK|STOCKS|STOCK|STOC';
				unlimited   	:= 'UNLIMITED|UMLIMITED|UMLIMITE|UNLIMITE';

				clean1 				:= corp2.t2u(regexreplace(common,uc_s,'COMMON '));																		//clean up common
				clean2 				:= corp2.t2u(regexreplace(preferred,clean1,'PREFERRED '));														//clean up preferred
				clean3				:= corp2.t2u(regexreplace(cumulative,clean2,'CUMULATIVE '));													//clean up cumulative
				clean4				:= corp2.t2u(regexreplace(nonvoting,clean3,'NON-VOTING '));														//clean up nonvoting
				clean5				:= corp2.t2u(regexreplace(voting,clean4,'VOTING '));																	//clean up voting
				clean6				:= corp2.t2u(regexreplace(stock,clean5,'STOCK '));																		//clean up stock
				clean7				:= corp2.t2u(regexreplace(unlimited,clean6,'UNLIMITED '));														//clean up unlimited				
				clean8				:= corp2.t2u(regexreplace('(\\.)*$|(\\,)*$',clean7,''));															//clean up ending periods and commas				
				cleanedclass	:= corp2.t2u(stringlib.stringfilterout(clean8,'()`'));																//clean up left & right parens and "`"
				
				stockclass  	:= map(cleanedclass in ['#1','HOME','S']															=> '',					//invalid if the word "#1", "S", etc. exists
														 cleanedclass in ['N/A','NA','(NONE)','NON','UNKNOWN']					=> '',					//invalid if the word "N/A", "NONE", etc. exists
													   regexfind('^NONE',cleanedclass,0)<>''													=> '',					//invalid if the word "NONE" exits
														 stringlib.stringfilterout(cleanedclass,' ,.%0123456789') =''		=> '', 					//invalid if only digits, and special characters exist
													   regexfind('^COMMON PV: ',cleanedclass,0)<>''										=> 'COMMON',		//remove any par value or issued value after "COMMON"
													   regexfind('^COMMON ISSUED: ',cleanedclass,0)<>''								=> 'COMMON',		//invalid if the word "NONE" exits
													   regexfind('^PREFERRED PV: ',cleanedclass,0)<>''								=> 'PREFERRED',	//remove any par value or issued value after "PREFERRED"														 
													   cleanedclass
													  );
				
				RETURN corp2.t2u(stockclass);
				
		END;

		//****************************************************************************
		//StockParValueDM: returns the "stock_par_value".
		//****************************************************************************
		EXPORT StockParValue(STRING s) := FUNCTION
			 str_s := (STRING)(INTEGER)s;
			 RETURN map(str_s = '0'																  => '',								 //map blank if all zeroes
									'$' + regexreplace('^[.]',str_s[1..length(str_s)-5] + '.' + str_s[length(str_s)- 4..],'0.')
								 );
		END;															 

		//****************************************************************************
		//StockSharesIssuedDM: returns the "stock_shares_issued".
		//****************************************************************************
		EXPORT StockSharesIssued(STRING s) := FUNCTION
			 str_s := (STRING)(INTEGER)s;
			 RETURN map(str_s = '0'																  => '',								 //map blank if all zeroes
								  regexreplace('0$',str_s[1..length(str_s)-3] + '.' +str_s[length(str_s)- 2..],'')
								 );			 
		END;

		//****************************************************************************
		//StockStockSeriesDM: returns the "stock_stock_series".
		//****************************************************************************
		EXPORT StockStockSeries(STRING s) := FUNCTION
			 uc_s := corp2.t2u(s);
			 RETURN  map(uc_s in ['N/A','NONE']												=> '', //invalid if only "N/A", "NONE", etc. exist
									 stringlib.stringfilterout(uc_s,'(),.%') =''	=> '', //invalid if only special characters exist
									 stringlib.stringfilterout(uc_s,'0') 	 =''		=> '', //invalid if only 0's
									 uc_s
									);
		END;

END;