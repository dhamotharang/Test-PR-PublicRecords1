IMPORT corp2, corp2_mapping, _validate;

EXPORT Functions := Module
	 
	  EXPORT Dom_Bus_list     := ['DOMESTIC LIMITED LIABILITY COMPANY','DOMESTIC LIMITED LIABILITY PARTNERSHIP',
																'DOMESTIC LIMITED PARTNERSHIP','DOMESTIC LOW PROFIT LIMITED LIABILITY COMPANY','DOMESTIC MUTUAL BENEFIT ENTERPRISE',
																'DOMESTIC NON-PROFIT CORPORATION','DOMESTIC PROFESSIONAL LIMITED LIABILITY COMPANY','DOMESTIC PROFIT CORPORATION'];
							
		EXPORT For_Bus_list     := ['FOREIGN LIMITED LIABILITY COMPANY','FOREIGN LIMITED LIABILITY PARTNERSHIP',
																'FOREIGN LIMITED PARTNERSHIP','FOREIGN LOW PROFIT LIMITED LIABILITY COMPANY','FOREIGN NON-PROFIT CORPORATION',
																'FOREIGN PROFESSIONAL LIMITED LIABILITY COMPANY','FOREIGN PROFIT CORPORATION'];
																
		EXPORT All_Bus_list	    := Dom_Bus_list + For_Bus_list + ['TRADE NAME','GENERAL PARTNERSHIP'];
		
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
	export StDesc2Abbrev(string code) := function

		st :=corp2.t2u(code);
		return map( st = 'ALABAMA'               => 'AL',
								st = 'ALASKA'                => 'AK', 
								st = 'ARKANSAS'              => 'AR', 
								st = 'AMERICAN SAMOA'        => 'AS', 
								st = 'ARIZONA'               => 'AZ', 
								st = 'ARMED FORCES EUROPE'   => 'AE',
								st = 'BAHAMAS, THE'  				 => 'BHS',                                         
								st = 'CANADA'   						 => 'UK',                                                    
								st = 'CAYMAN ISLANDS'   		 => 'CYM', 
								st = 'CHEROKEE NATION'  		 => 'CHR',  
								st = 'CALIFORNIA'            => 'CA', 
								st = 'COLORADO'              => 'CO', 
								st = 'CONNECTICUT'           => 'CT', 
								st = 'DISTRICT OF COLUMBIA'  => 'DC', 
								st = 'DELAWARE'              => 'DE', 
								st = 'FLORIDA'               => 'FL', 
								st = 'GEORGIA'               => 'GA', 
								st = 'GUAM'                  => 'GU', 
								st = 'HAWAII'                => 'HI', 
								st = 'IOWA'                  => 'IA', 
								st = 'IDAHO'                 => 'ID', 
								st = 'ILLINOIS'              => 'IL', 
								st = 'INDIANA'               => 'IN', 
								st = 'INDIA'                 => 'IND',
								st = 'JAPAN'                 => 'JAP',
								st = 'KANSAS'                => 'KS', 
								st = 'KENTUCKY'              => 'KY', 
								st = 'LOUISIANA'             => 'LA',
								st = 'LUXEMBOURG'            => 'LUX', 
								st = 'MASSACHUSETTS'         => 'MA', 
								st = 'MARYLAND'              => 'MD', 
								st = 'MAINE'                 => 'ME', 
								st = 'MICHIGAN'              => 'MI', 
								st = 'MINNESOTA'             => 'MN', 
								st = 'MISSOURI'              => 'MO', 
								st = 'MISSISSIPPI'           => 'MS', 
								st = 'MONTANA'               => 'MT', 
								st = 'NORTH CAROLINA'        => 'NC', 
								st = 'NORTH DAKOTA'          => 'ND', 
								st = 'NEBRASKA'              => 'NE', 
								st = 'NEW HAMPSHIRE'         => 'NH', 
								st = 'NEW JERSEY'            => 'NJ', 
								st = 'NEW MEXICO'            => 'NM', 
								st = 'NEVADA'                => 'NV', 
								st = 'NEW YORK'              => 'NY', 
								st = 'NETHERLANDS'           => 'ANT',
								st = 'OHIO'                  => 'OH', 
								st = 'OKLAHOMA'              => 'OK', 
								st = 'OREGON'                => 'OR', 
								st = 'PENNSYLVANIA'          => 'PA',
								st = 'PHILIPPINES'           => 'PHL',
								st = 'PUERTO RICO'           => 'PR', 
								st = 'RHODE ISLAND'          => 'RI', 
								st = 'SOUTH CAROLINA'        => 'SC', 
								st = 'SOUTH DAKOTA'          => 'SD', 
								st = 'TENNESSEE'             => 'TN', 
								st = 'TEXAS'                 => 'TX', 
								st in ['UNITED STATES','US'] => 'US', 
								st = 'UNITED ARAB EMIRATES'  => 'ARE',                                       
								st = 'UNITED KINGDOM'        => 'UK', 
								st = 'UTAH' 				         => 'UT', 
								st = 'VIRGINIA' 		         => 'VA', 
								st = 'VIRGIN ISLANDS'        => 'VI', 
								st = 'VERMONT'               => 'VT', 
								st = 'WASHINGTON'            => 'WA', 
								st = 'WISCONSIN' 		         => 'WI', 
								st = 'WEST VIRGINIA'         => 'WV', 
								st = 'WYOMING' 			         => 'WY',
								st = 'HAITI' 			         	 => 'HT',
								st in ['XX','X','NA','']		 => '',
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

End;