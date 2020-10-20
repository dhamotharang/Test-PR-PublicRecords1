IMPORT corp2, corp2_mapping, _validate, ut, std;

EXPORT Functions := Module
	 
	  EXPORT Dom_Bus_list     := ['DOMESTIC LIMITED LIABILITY COMPANY','DOMESTIC LIMITED LIABILITY PARTNERSHIP',
																'DOMESTIC LIMITED PARTNERSHIP','DOMESTIC LOW PROFIT LIMITED LIABILITY COMPANY','DOMESTIC MUTUAL BENEFIT ENTERPRISE',
																'DOMESTIC NON-PROFIT CORPORATION','DOMESTIC PROFESSIONAL LIMITED LIABILITY COMPANY','DOMESTIC PROFIT CORPORATION'];
							
		EXPORT For_Bus_list     := ['FOREIGN LIMITED LIABILITY COMPANY','FOREIGN LIMITED LIABILITY PARTNERSHIP',
																'FOREIGN LIMITED PARTNERSHIP','FOREIGN LOW PROFIT LIMITED LIABILITY COMPANY','FOREIGN NON-PROFIT CORPORATION',
																'FOREIGN PROFESSIONAL LIMITED LIABILITY COMPANY','FOREIGN PROFIT CORPORATION'];
																
		EXPORT All_Bus_list	    := Dom_Bus_list + For_Bus_list + ['ASSUMED BUSINESS NAME','GENERAL PARTNERSHIP','TRADE NAME'];
		
		EXPORT Months_Zero_Blnk := ['','0','1','2','3','4','5','6','7','8','9','10','11','12'];
		
		EXPORT Filter_List  		:= ['2 MORE IN FILE','3 MORE IN FILE','4 MORE IN FILE','5 MORE IN FILE','(2 MORE)','(2 MORE IN FILE)',
																'6 MORE IN FILE','(3 MORE)','(3 MORE IN FILE)','7 MORE IN FILE','(FOUR MORE, SEE FILE)','(4 MORE IN FILE)',
																'(4 MORE SEE FILE)','AGENT RESIGNED','BOUNCED','CHECK', 'CHECK BOUNCED','N/A','-NONE ON FILE-',
																'NONE','NONE LISTED','NO DIRECTORS','S/A','SAME','SAME AS ABOVE','SAME AS OFFICERS','(SEE FILE)',
																'(SEE FIILE)','SEE FILE','SOMEBODY ELSE','(6 MORE IN FILE)','(6 MORE SEE FILE)','(SIX MORE IN FILE)',
																'7 MORE SEE FILE','VACANT','SEE FILE FOR LTD PTNRS.','MORE IN FILE','SEE FILE FOR LTD PTN','9 MORE IN FILE',
																'10 MORE IN FILE','~NONE~','VACANT VACANT','(TWO MORE IN FILE)','9 MORE IN FILE','27 MORE IN FILE',
																'(THREE MORE IN FILE)','SEE FILE FOR MORE','(5 MORE IN FILE)','SEE FILE FOR LIMITED','(SEE FILE FOR PRTNRS',
																'9 MORE IN FILE','(MANY MORE IN FILE)'];
		
	//StDesc2Abbrev: validates vendor state desc & Returns State code to "Corp_Forgn_State_CD" !
	//Countries will have three-character codes per CI/DF-28174
	export StDesc2Abbrev(string code) := function

		st :=corp2.t2u(code);
		return map( st = 'ALABAMA'                   => 'AL',
								st = 'ALASKA'                    => 'AK', 
								st = 'ARKANSAS'                  => 'AR', 
								st = 'AMERICAN SAMOA'            => 'ASM', 
								st = 'ARIZONA'                   => 'AZ', 
								st = 'ARMED FORCES EUROPE'       => 'AE',
								st = 'BAHAMAS, THE'              => 'BHS',  
								st = 'BARBADOS'                  => 'BRB', 
								st = 'BERMUDA'                   => 'BMU',
								st = 'CANADA'                    => 'CAN',                                                    
								st = 'CAYMAN ISLANDS'            => 'CYM', 
								st = 'CHEROKEE NATION'           => 'CHR',  
								st = 'CALIFORNIA'                => 'CA', 
								st = 'COLORADO'                  => 'CO', 
								st = 'CONNECTICUT'               => 'CT',
								st = 'CZECH REPUBLIC'            => 'CZE',
								st = 'DISTRICT OF COLUMBIA'      => 'DC', 
								st = 'DELAWARE'                  => 'DE', 
								st = 'FLORIDA'                   => 'FL', 
								st = 'GEORGIA'                   => 'GA', 
								st = 'GERMANY'                   => 'DEU',
								st = 'GUAM'                      => 'GUM', 
								st = 'HAITI'                     => 'HTI',
								st = 'HAWAII'                    => 'HI', 
								st = 'IOWA'                      => 'IA', 
								st = 'IDAHO'                     => 'ID', 
								st = 'ILLINOIS'                  => 'IL', 
								st = 'INDIANA'                   => 'IN', 
								st = 'INDIA'                     => 'IND',
								st = 'INDONESIA'                 => 'IDN',          
								st = 'ISRAEL'                    => 'ISR',          
								st = 'ITALY'                     => 'ITA',                                                                             
								st = 'JAPAN'                     => 'JPN',
								st = 'KANSAS'                    => 'KS', 
								st = 'KENTUCKY'                  => 'KY', 
								st = 'LOUISIANA'                 => 'LA',
								st = 'LUXEMBOURG'                => 'LUX', 
								st = 'MASSACHUSETTS'             => 'MA', 
								st = 'MARYLAND'                  => 'MD', 
								st = 'MAINE'                     => 'ME', 
								st = 'MICHIGAN'                  => 'MI', 
								st = 'MINNESOTA'                 => 'MN', 
								st = 'MISSOURI'                  => 'MO', 
								st = 'MISSISSIPPI'               => 'MS', 
								st = 'MONTANA'                   => 'MT', 
								st = 'NORTH CAROLINA'            => 'NC', 
								st = 'NORTH DAKOTA'              => 'ND', 
								st = 'NEBRASKA'                  => 'NE', 
								st = 'NEW HAMPSHIRE'             => 'NH', 
								st = 'NEW JERSEY'                => 'NJ', 
								st = 'NEW MEXICO'                => 'NM', 
								st = 'NEVADA'                    => 'NV', 
								st = 'NEW YORK'                  => 'NY', 
								st = 'NETHERLANDS'               => 'NDL',
								st = 'NETHERLANDS ANTILLES'      => 'ANT',
								st = 'OHIO'                      => 'OH', 
								st = 'OKLAHOMA'                  => 'OK', 
								st = 'OREGON'                    => 'OR', 
								st = 'PENNSYLVANIA'              => 'PA',
								st = 'PHILIPPINES'               => 'PHL',
								st = 'PUERTO RICO'               => 'PRI', 
								st = 'RHODE ISLAND'              => 'RI', 
								st = 'SOUTH CAROLINA'            => 'SC', 
								st = 'SOUTH DAKOTA'              => 'SD', 
								st = 'SWEDEN'                    => 'SWE',
								st = 'SWITZERLAND'               => 'CHE',
								st = 'TENNESSEE'                 => 'TN', 
								st = 'TEXAS'                     => 'TX', 
								st in ['UNITED STATES','US']     => 'USA', 
								st = 'UNITED ARAB EMIRATES'      => 'ARE',                                       
								st = 'UNITED KINGDOM'            => 'GBR', 
								st = 'UTAH'                      => 'UT', 
								st = 'VIRGINIA'                  => 'VA', 
								st = 'VIRGIN ISLANDS'            => 'VIR', 
								st = 'VERMONT'                   => 'VT', 
								st = 'WASHINGTON'                => 'WA', 
								st = 'WISCONSIN'                 => 'WI', 
								st = 'WEST VIRGINIA'             => 'WV', 
								st = 'WYOMING'                   => 'WY',
								st in ['XX','X','NA','']         => '',
								'**');
									
		End;					
		
		//********************************************************************
		//GetMonth: Returns the name of the month 
	  //********************************************************************	
		EXPORT GetMonth(STRING s)  := FUNCTION
				
			Month_str := MAP(stringlib.stringfilter(s,'0123456789') =  '1'   => 'JANUARY',
											 stringlib.stringfilter(s,'0123456789') =  '2'   => 'FEBRUARY',
											 stringlib.stringfilter(s,'0123456789') =  '3'   => 'MARCH',
											 stringlib.stringfilter(s,'0123456789') =  '4'   => 'APRIL',
											 stringlib.stringfilter(s,'0123456789') =  '5'   => 'MAY',
											 stringlib.stringfilter(s,'0123456789') =  '6'   => 'JUNE',
											 stringlib.stringfilter(s,'0123456789') =  '7'   => 'JULY',
											 stringlib.stringfilter(s,'0123456789') =  '8'   => 'AUGUST',
											 stringlib.stringfilter(s,'0123456789') =  '9'   => 'SEPTEMBER',
											 stringlib.stringfilter(s,'0123456789') =  '10'  => 'OCTOBER',
											 stringlib.stringfilter(s,'0123456789') =  '11'  => 'NOVEMBER',
											 stringlib.stringfilter(s,'0123456789') =  '12'  => 'DECEMBER',
											 '');
			RETURN corp2.t2u(Month_str);

		END; 
		
		EXPORT GetAddlInfo(string naics_code ,string naics_subcode ,string fiscal_year_month ,string manager_managed ,string members_liable ,string member_organization)  := FUNCTION
		
		 ConcatAddlInfo          := if(corp2.t2u(naics_code) <> '','NAICS: ' + corp2.t2u(naics_code)+ '; ','') +
															  if(corp2.t2u(naics_subcode) <> '','NAICS SUBCODE: ' + corp2.t2u(naics_subcode) + '; ','') +
															  if((string)(integer)trim(fiscal_year_month,left,right)not in['0',''],'FISCAL YEAR MONTH: '+ GetMonth(FISCAL_YEAR_MONTH) + '; ','') +
															  if(corp2.t2u(manager_managed) = 'YES','MEMBER MANAGED; ','') +
															  if(corp2.t2u(members_liable) = 'YES','MEMBERS LIABLE; ','') +
															  if(corp2.t2u(member_organization) = 'YES','HAS MEMBERS','');
			addl_info              := regexreplace('[;]$',trim(ConcatAddlInfo,left,right),''); 
      RETURN addl_info;

		END; 
		
   //fix_ForeignChar-- returns VT state-site matching legal names!
   //Cleaning up foreign characters & unprintables from legal names
		EXPORT fix_ForeignChar(STRING s) := FUNCTION

			uc_s  							 := corp2.t2u(s);				
			fix_legal_name       := map(regexfind('LA MONTAÃA LLC',  uc_s,0)  <> ''                             =>'LA MONTAÑA LLC',
																	regexfind('LULA-LÃ BOUTIQUE LLC',  uc_s,0)  <> ''                       =>'A&M BOUTIQUE LLC',
																	regexfind('POZÃ CATERING LLC',  uc_s,0)  <> ''                          =>'POZE CATERING LLC',
																	regexfind('PÃR\\\'S'+'SMOKED OF VERMONT, LLC',  uc_s,0)  <> ''          =>'PER\\\'S'+'SMOKED OF VERMONT, LLC',
																	regexfind('SAVOURÃ LLC',  uc_s,0)  <> ''                                =>'SAVOURE LLC',
																	regexfind('VERMONT COFFEE COMPANY CAFÃ, LLC',  uc_s,0)  <> ''           =>'VERMONT COFFEE COMPANY CAFE, LLC',
																	regexfind('WINTERFÃLK LLC',  uc_s,0)  <> ''                             =>'WINTERFOLK LLC',
																	regexfind('YVONNE\\\'S'+'BAKERY AND CAFÃ LLC',  uc_s,0)  <> ''          =>'YVONNE\\\'S'+ 'BAKERY AND CAFE LLC',
																	regexfind('ÃBERDAS, LLC',  uc_s,0)  <> ''                                =>'UBERDAS, LLC',
																	regexfind('BRÃT DESIGN L.L.C',  uc_s,0)  <> ''                           =>'BRUT DESIGN L.L.C',
																	regexfind('GREEN STATE CAFÃ LTD. CO.',  uc_s,0)  <> ''                  =>'GREEN STATE CAFE LTD. CO.',
																	regexfind('ALNÃBAIWI CO.',  uc_s,0)  <> ''                              =>'ALNOBAIWI CO.',
																	regexfind('ALCOA TREASURY S.Ã R.L., LLC',  uc_s,0)  <> ''               =>'ALCOA TREASURY S.A R.L., LLC',
																	regexfind('ARCONIC LUXEMBOURG S.Ã R.L., L.L.C.',  uc_s,0)  <> ''        =>'ARCONIC LUXEMBOURG S.A R.L., L.L.C.',
																	regexfind('AÃRUS SOLUTIONS PROVIDER CORP',  uc_s,0)  <> '' 						  =>'AERUS SOLUTIONS PROVIDER CORP',
																	regexfind('HOMESTYLE HOSTEL INN & CAFÃ',  uc_s,0)  <> '' 								=>'HOMESTYLE HOSTEL INN & CAFE',
																	regexfind('MR MIKEÂ´S PROPERTY SERVICE',  uc_s,0)  <> '' 									  =>'MR MIKE\\\'S'+'PROPERTY SERVICE',
																	regexfind('MÃSHKA AND ANNIKA\\\'S'+'WORLD OF WONDERS',  uc_s,0)  <> ''   =>'MASHKA AND ANNIKA\\\'S'+'WORLD OF WONDERS',
																	regexfind('NORTH WOODS CAFÃ #446',  uc_s,0)  <> ''                       =>'NORTH WOODS CAFE #446',
																	regexfind('NORTH WOODS CAFÃ #450',  uc_s,0)  <> ''                       =>'NORTH WOODS CAFE #450',
																	regexfind('NORTH WOODS CAFÃ #437',  uc_s,0)  <> ''                       =>'NORTH WOODS CAFE #437',
																	regexfind('NORTH WOODS CAFÃ #443',  uc_s,0)  <> ''                       =>'NORTH WOODS CAFE #443',
																	regexfind('NORTH WOODS CAFÃ #445',  uc_s,0)  <> ''                       =>'NORTH WOODS CAFE #445',
																	regexfind('NORTH WOODS CAFÃ #449',  uc_s,0)  <> ''                       =>'NORTH WOODS CAFE #449',
																	regexfind('NORTH WOODS CAFÃ #454',  uc_s,0)  <> ''                       =>'NORTH WOODS CAFE #454',
																	regexfind('PRÃT A MANGER',  uc_s,0)  <> ''                               =>'PRET A MANGER',
																	regexfind('RÃPUBLIQUE DU COEUR PRODUCTIONS',  uc_s,0)  <> ''             =>'REPUBLIQUE DU COEUR PRODUCTIONS',
																	regexfind('SUPERFRESH! ORGANIC CAFÃ',  uc_s,0)  <> ''                    =>'SUPERFRESH! ORGANIC CAFE',
																	regexfind('TISÃNE PUBLISHING',  uc_s,0)  <> ''                           =>'TISANE PUBLISHING',
																	regexfind('TRÃNORTH NATURALS',  uc_s,0)  <> ''                            =>'TRUNORTH NATURALS',
																	regexfind('XFÃL',  uc_s,0)  <> '' 							    	                     =>'XFOL',
																	regexfind('ÃLAN HAIR LOUNGE',  uc_s,0)  <> ''                            =>'ELAN HAIR LOUNGE',
																	regexfind('GISÃLEâS STUDIO',  uc_s,0)  <> ''                    =>'GISELE’S STUDIO', uc_s);
			R_unprintables       := regexreplace('|||||||||||||' ,fix_legal_name,'');  //unprintables noticed in the data & Cleaning them													
			return ut.fn_RemoveSpecialChars((string)Std.Uni.CleanAccents(R_unprintables));		
				
			END;
		
END;