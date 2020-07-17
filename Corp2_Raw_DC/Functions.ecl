IMPORT corp2, corp2_mapping;

EXPORT Functions := Module
			
		//********************************************************************
		//CorpOrigOrgStructureDesc: Returns "corp_orig_org_structure_desc".
		//********************************************************************	
		EXPORT CorpOrigOrgStructDesc(STRING s) := FUNCTION
					 OrgSt_dec  := corp2.t2u(s);
					 RETURN map(OrgSt_dec='ACT OF CONGRESS CORPORATION FOREIGN'													 =>'ACT OF CONGRESS CORPORATION FOREIGN',
											OrgSt_dec='ACT OF CONGRESS CORPORATION FOREIGN NON-PROFIT'							 =>'ACT OF CONGRESS CORPORATION FOREIGN NON-PROFIT',
											OrgSt_dec='FOR-PROFIT BENEFIT CORPORATION DOMESTIC FOR-PROFIT'					 =>'FOR-PROFIT BENEFIT CORPORATION DOMESTIC FOR-PROFIT',
											OrgSt_dec='FOR-PROFIT CORPORATION DOMESTIC FOR-PROFIT'									 =>'FOR-PROFIT CORPORATION DOMESTIC FOR-PROFIT',
											OrgSt_dec='FOR-PROFIT CORPORATION DOMESTIC FOR-PROFIT PROFESSIONAL'			 =>'FOR-PROFIT CORPORATION DOMESTIC FOR-PROFIT PROFESSIONAL',
											OrgSt_dec='FOR-PROFIT CORPORATION DOMESTIC'															 =>'FOR-PROFIT CORPORATION DOMESTIC',
											OrgSt_dec='FOR-PROFIT CORPORATION FOREIGN'															 =>'FOR-PROFIT CORPORATION FOREIGN',
											OrgSt_dec='FOR-PROFIT CORPORATION FOREIGN FOR-PROFIT'							  		 =>'FOR-PROFIT CORPORATION FOREIGN FOR-PROFIT',
											OrgSt_dec='FOR-PROFIT CORPORATION FOREIGN FOR-PROFIT PROFESSIONAL'			 =>'FOR-PROFIT CORPORATION FOREIGN FOR-PROFIT PROFESSIONAL',
											OrgSt_dec='GENERAL COOPERATIVE ASSOCIATION DOMESTIC'										 =>'GENERAL COOPERATIVE ASSOCIATION DOMESTIC',
											OrgSt_dec='GENERAL COOPERATIVE ASSOCIATION FOREIGN'								  		 =>'GENERAL COOPERATIVE ASSOCIATION FOREIGN',
											OrgSt_dec='GENERAL PARTNERSHIP DOMESTIC'														     =>'GENERAL PARTNERSHIP DOMESTIC',
											OrgSt_dec='LIABILITY COMPANY DOMESTIC'																	 =>'LIABILITY COMPANY DOMESTIC',
											OrgSt_dec='LIMITED COOPERATIVE ASSOCIATION DOMESTIC'										 =>'LIMITED COOPERATIVE ASSOCIATION DOMESTIC',
											OrgSt_dec='LIMITED LIABILITY COMPANY DOMESTIC'													 =>'LIMITED LIABILITY COMPANY DOMESTIC',
											OrgSt_dec='LIMITED LIABILITY COMPANY DOMESTIC FOR-PROFIT'								 =>'LIMITED LIABILITY COMPANY DOMESTIC FOR-PROFIT',
											OrgSt_dec='LIMITED LIABILITY COMPANY FOREIGN'														 =>'LIMITED LIABILITY COMPANY FOREIGN',
											OrgSt_dec='LIMITED LIABILITY COMPANY FOREIGN FOR-PROFIT'								 =>'LIMITED LIABILITY COMPANY FOREIGN FOR-PROFIT',
											OrgSt_dec='LIMITED LIABILITY PARTNERSHIP DOMESTIC'											 =>'LIMITED LIABILITY PARTNERSHIP DOMESTIC',
											OrgSt_dec='LIMITED LIABILITY PARTNERSHIP FOREIGN'												 =>'LIMITED LIABILITY PARTNERSHIP FOREIGN',
											OrgSt_dec='LIMITED PARTNERSHIP DOMESTIC'																 =>'LIMITED PARTNERSHIP DOMESTIC',
											OrgSt_dec='LIMITED PARTNERSHIP FOREIGN'																	 =>'LIMITED PARTNERSHIP FOREIGN',
											OrgSt_dec='NAME RESERVATION DOMESTIC'																	   =>'NAME RESERVATION DOMESTIC' ,
											OrgSt_dec='NAME RESERVATION DOMESTIC NON-PROFIT'												 =>'NAME RESERVATION DOMESTIC NON-PROFIT' ,
											OrgSt_dec='NAME RESERVATION FOREIGN'																	   =>'NAME RESERVATION FOREIGN',
											OrgSt_dec='NON-PROFIT CORPORATION DOMESTIC'															 =>'NON-PROFIT CORPORATION DOMESTIC',
											OrgSt_dec='NON-PROFIT CORPORATION FOREIGN'															 =>'NON-PROFIT CORPORATION FOREIGN',
											OrgSt_dec='NON-PROFIT CORPORATION FOREIGN NON-PROFIT'										 =>'NON-PROFIT CORPORATION FOREIGN NON-PROFIT',
											OrgSt_dec='NONREGISTERED NONFILING ENTITY NONE'													 =>'NONREGISTERED NONFILING ENTITY NONE',											
											OrgSt_dec='PROFESSIONAL LIMITED LIABILITY COMPANY DOMESTIC'							 =>'PROFESSIONAL LIMITED LIABILITY COMPANY DOMESTIC',
											OrgSt_dec='PROFESSIONAL LIMITED LIABILITY COMPANY DOMESTIC PROFESSIONAL' =>'PROFESSIONAL LIMITED LIABILITY COMPANY DOMESTIC PROFESSIONAL',
											OrgSt_dec='STATUTORY TRUST DOMESTIC'																		 =>'STATUTORY TRUST DOMESTIC',
											OrgSt_dec='STATUTORY TRUST FOREIGN'																			 =>'STATUTORY TRUST FOREIGN',
											OrgSt_dec=''																														 =>'',
											'**|'+OrgSt_dec);
	END;
		
		
	//********************************************************************
	//fGetStateCode: Returns " Two digit State_Code" from full name.
	//********************************************************************	
	EXPORT  string2 fGetStateCode(STRING state) := FUNCTION
		st  := corp2.t2u(state);
		RETURN map( st='ALABAMA' 							=> 'AL',
								st='ALASKA' 							=> 'AK', 
								st='ARKANSAS' 						=> 'AR', 
								st='AMERICAN SAMOA' 			=> 'AS', 
								st='ARIZONA' 							=> 'AZ', 
								st='CALIFORNIA' 					=> 'CA', 
								st='COLORADO' 						=> 'CO', 
								st='CONNECTICUT' 					=> 'CT', 
								st='DISTRICT OF COLUMBIA' => 'DC', 
								st='DELAWARE' 						=> 'DE', 
								st='FLORIDA' 							=> 'FL', 
								st='GEORGIA' 							=> 'GA', 
								st='GUAM' 								=> 'GU', 
								st='HAWAII' 							=> 'HI', 
								st='IOWA' 								=> 'IA', 
								st='IDAHO' 								=> 'ID', 
								st='ILLINOIS' 						=> 'IL', 
								st='INDIANA'	 						=> 'IN', 
								st='KANSAS' 							=> 'KS', 
								st='KENTUCKY' 						=> 'KY', 
								st='LOUISIANA' 						=> 'LA', 
								st='MASSACHUSETTS' 				=> 'MA', 
								st='MARYLAND'							=> 'MD', 
								st='MAINE' 								=> 'ME', 
								st='MICHIGAN' 						=> 'MI', 
								st='MINNESOTA' 						=> 'MN', 
								st='MISSOURI' 						=> 'MO', 
								st='MISSISSIPPI' 					=> 'MS', 
								st='MONTANA' 							=> 'MT', 
								st='NORTH CAROLINA' 			=> 'NC', 
								st='NORTH DAKOTA' 				=> 'ND', 
								st='NEBRASKA' 						=> 'NE', 
								st='NEW HAMPSHIRE' 				=> 'NH', 
								st='NEW JERSEY' 					=> 'NJ', 
								st='NEW MEXICO' 					=> 'NM', 
								st='NEVADA' 							=> 'NV', 
								st='NEW YORK' 						=> 'NY', 
								st='OHIO' 								=> 'OH', 
								st='OKLAHOMA' 						=> 'OK', 
								st='OREGON' 							=> 'OR', 
								st='PENNSYLVANIA' 				=> 'PA', 
								st='PUERTO RICO'					=> 'PR', 
								st='RHODE ISLAND' 				=> 'RI', 
								st='SOUTH CAROLINA' 			=> 'SC', 
								st='SOUTH DAKOTA'		 			=> 'SD', 
								st='TENNESSEE' 						=> 'TN', 
								st='TEXAS' 								=> 'TX', 
								st='UTAH' 								=> 'UT', 
								st='VIRGINIA' 						=> 'VA', 
								st='VIRGIN ISLAND'				=> 'VI',
								st='VIRGIN ISLANDS' 			=> 'VI',		
								st='VERMONT' 							=> 'VT', 
								st='WASHINGTON' 					=> 'WA', 
								st='WISCONSIN' 						=> 'WI', 
								st='WEST VIRGINIA' 				=> 'WV', 
								st='WYOMING' 							=> 'WY',
								st in ['','UNKNOWN' ]			=> '',
								'**' );
							
		END;						

	//********************************************************************
	//fGetNameAddress: Returns "Name & Address" separated by a "pipe".
	//********************************************************************	
	EXPORT fGetNameAddress(STRING state_origin, STRING state_desc, STRING s) := FUNCTION
	    
    //DF-27872: Removes the slash found in the zip values 
		stripInvalids       := regexreplace('\\x5C|\\x2F', s,''); 
		uc_s  							:= corp2.t2u(stripInvalids);	
		name					  		:= corp2.t2u(stringlib.splitwords(uc_s,'|',false)[1]);
		addr								:= stringlib.splitwords(uc_s,'|',false)[2];
		zip				 	 				:= Corp2_Mapping.fCleanZip(state_origin,state_desc,addr).Zip;
		addr_wo_zip					:= if(zip<>'',regexreplace(zip,addr,''),addr);
		addr_parts_by_comma	:= stringlib.splitwords(addr_wo_zip,',',false);
		wc									:= count(addr_parts_by_comma);
		state								:= addr_parts_by_comma[wc];
		addr_wo_state				:= if(state<>'',regexreplace(state,addr_wo_zip,''),addr_wo_zip);
		city_addr						:= corp2.t2u(addr_parts_by_comma[wc-1]);
		city								:= map(city_addr = 'WASHINGTON DC'	=> 'WASHINGTON',
															 city_addr = 'WASHINGTON'			=> 'WASHINGTON',
															 city_addr = 'WASHIGTON'			=> 'WASHINGTON', 
															 city_addr = 'WASHINGON'			=> 'WASHINGTON', 
															 city_addr = 'WASHINGRON'			=> 'WASHINGTON', 
															 city_addr = 'WASHINGTO'			=> 'WASHINGTON',
															 city_addr = 'WASHINTON'			=> 'WASHINGTON', 
															 city_addr = 'WASJOMGTPM'			=> 'WASHINGTON', 
															 city_addr = 'WSHINGTON'			=> 'WASHINGTON', 
															 city_addr = 'WASH'						=> 'WASHINGTON',
															 city_addr = 'DC NE'					=> 'WASHINGTON',															 
															 city_addr = 'DC'							=> 'WASHINGTON',
															 city_addr = 'DC, DC' 				=> 'WASHINGTON',                                                       
															 city_addr
															);                                                                                                                                       

		street_addr					:= if(city_addr<>'',regexreplace(city_addr,addr_wo_state,''),addr_wo_state);
		street							:= regexreplace('(\\,)*$',corp2.t2u(street_addr),'');															 

		RETURN corp2.t2u(name)+'|'+corp2.t2u(street)+'|'+corp2.t2u(city)+'|'+corp2.t2u(state)+'|'+corp2.t2u(zip);

	END;	
	
	//********************************************************************
	//fGetBusAddress: Returns  Address parts separated by a "pipe".
	//********************************************************************		
	EXPORT fGetBusAddress(STRING state_origin, STRING state_desc, STRING s) := FUNCTION
	
	  //DF-27872: Removes the slash found in the zip values
		stripInvalids       := regexreplace('\\x5C|\\x2F', s,'');
		uc_s  							:= corp2.t2u(stripInvalids);
		zip				 	 				:= Corp2_Mapping.fCleanZip(state_origin,state_desc,uc_s).Zip;
		addr_wo_zip					:= if(zip<>'',regexreplace(zip,uc_s,''),uc_s);
		addr_parts_by_comma	:= stringlib.splitwords(addr_wo_zip,',',false);
		wc									:= count(addr_parts_by_comma);
		state								:= addr_parts_by_comma[wc];
		addr_wo_state				:= if(state<>'',regexreplace(state,addr_wo_zip,''),addr_wo_zip);
		city_addr						:= corp2.t2u(addr_parts_by_comma[wc-1]);
		city								:= map(city_addr = 'WASHINGTON DC'	=> 'WASHINGTON',
															 city_addr = 'WASHINGTON'			=> 'WASHINGTON',
															 city_addr = 'WASHIGTON'			=> 'WASHINGTON', 
															 city_addr = 'WASHINGON'			=> 'WASHINGTON', 
															 city_addr = 'WASHINGRON'			=> 'WASHINGTON', 
															 city_addr = 'WASHINGTO'			=> 'WASHINGTON',
															 city_addr = 'WASHINTON'			=> 'WASHINGTON', 
															 city_addr = 'WASJOMGTPM'			=> 'WASHINGTON', 
															 city_addr = 'WSHINGTON'			=> 'WASHINGTON', 
															 city_addr = 'WASH'						=> 'WASHINGTON',
															 city_addr = 'DC NE'					=> 'WASHINGTON',															 
															 city_addr = 'DC'							=> 'WASHINGTON',
															 city_addr = 'DC, DC' 				=> 'WASHINGTON',                                                       
															 city_addr
															);                                                                                                                                       

		street_addr					:= if(city_addr<>'',regexreplace(city_addr,addr_wo_state,''),addr_wo_state);
		street							:= regexreplace('(\\,)*$',corp2.t2u(street_addr),'');															 

		RETURN corp2.t2u(street)+'|'+corp2.t2u(city)+'|'+corp2.t2u(state)+'|'+corp2.t2u(zip);

	END;
	
END;