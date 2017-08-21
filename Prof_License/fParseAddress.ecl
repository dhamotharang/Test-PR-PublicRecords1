import RiskWise, ut,lib_stringlib, lib_word, address, AID, idl_header;;

export fParseAddress :=	module
	export StateNameTable	:=	[	'ALABAMA',							'ALASKA',					'AMERICAN SAMOA',	
															'ARIZONA',							'ARKANSAS',				'CALIFORNIA',			
															'PANAMA CANAL ZONE',		'COLORADO',				'CONNECTICUT',		
															'DISTRICT OF COLUMBIA',	'DELAWARE',				'FLORIDA',	
															'GEORGIA',							'GUAM',						'HAWAII',				
															'IDAHO',								'ILLINOIS',				'INDIANA',
															'IOWA',									'KANSAS',					'KENTUCKY',
															'LOUISIANA',						'MAINE',					'MARYLAND',				
															'MASSACHUSETTS',				'MICHIGAN',				'MINNESOTA',			
															'MISSISSIPPI',					'MISSOURI',				'MONTANA',	
															'NEBRASKA',							'NEVADA',					'NEW HAMPSHIRE',	
															'NEW JERSEY',						'NEW MEXICO',			'NEW YORK',		
															'NORTH CAROLINA',				'NORTH DAKOTA',		'OHIO',	
															'OKLAHOMA',							'OREGON',					'PENNSYLVANIA',
															'PUERTO RICO',					'RHODE ISLAND',		'SOUTH CAROLINA',	
															'TENNESSEE',						'SOUTH DAKOTA',		'UTAH',						
															'TEXAS',								'VIRGINIA',				'VERMONT',				
															'WASHINGTON',						'VIRGIN ISLANDS',	'WISCONSIN',
															'WEST VIRGINIA',				'ILL'];
															
	export StateAbbrTable	:=	[	'AL',	'AK',	'AZ', 'AR', 'CA', 'PR', 'CO', 'CT', 'DC',	'DE',	'FL',	
															'GA',	'HI',	'ID',	'IL',	'IN', 'IA',	'KS',	'KY', 'LA',	'ME',	'MD',
															'MA',	'MI',	'MN', 'MS', 'MO',	'MT',	'NE',	'NV',	'NH',	'NJ',	'NM',	
															'NY',	'NC',	'ND',	'OH', 'OK',	'OR',	'PA',	'PR',	'RI',	'SC',	'TN',
															'SD',	'UT',	'TX',	'VA',	'VT',	'WA',	'VI',	'WI',	'WV'];															
															
	export CityFile := RiskWise.File_CityStateZip;
	
	export FindAddr(string200 Addr2Parse)	:=	function
	
				// extract numeric zip, keeping only first 5 digits
			tmpZip						:=	StringLib.StringFilter(Addr2Parse,'0123456789')[1..5];
		
			// extract alpha data (i.e. city & state data), removing extra spacing & setting to uppercase		
			tmpCleanCityState	:=	stringlib.StringToUppercase(StringLib.StringCleanSpaces(lib_stringlib.StringLib.StringFilter(Addr2Parse,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ')));
		
			// Split the city state data into words. This will allow us to compare state data to a state full name 
			// table & also to a state abbreviation table and take anything not considered a state value as the
			// city.
			tmpCityState			:=	Address.WordSplit(tmpCleanCityState);
		
			// Since some states are multi words (i.e. New York, we need to pull off the last two words 
			// in the city state data.
			string LastWord		:=	LIB_Word.StripUpToWord( tmpCleanCityState , Count(tmpCityState) - 1 );	
			string Second2Last:=	LIB_Word.StripUpToWord( tmpCleanCityState , Count(tmpCityState) - 2 );
		
			// Check for the last two words being in the state tables first. The reason is because we
			// of Virginia & West Virginia. If we compared the last word first, we would convert 
			// all west virginia values to virginia & include west as part of the city. No harm is done 
			// looking for "DAYTON OHIO" since the default is to go with the last word if the last two
			// words are not in the state tables. 
			tmpStateName			:=	if (LastWord = '' and Second2Last = '',
																	if (tmpCleanCityState in StateNameTable or tmpCleanCityState in StateAbbrTable,
																				tmpCleanCityState,
																				''
																			),
																	if (Second2Last in StateNameTable, 
																				Second2Last,
																				LastWord
																			)
																);
																
			// since it is possible that we only have a city value with no state data, resulting in LastWord &
			// second2Last being blank, we test for that condition prior to extracting city from state.
			tmpCityOnly				:=	if (tmpStateName != '',
																	tmpCleanCityState[1..StringLib.StringFind(tmpCleanCityState, tmpStateName, 1)-1],
																	tmpCleanCityState
																);
		
			// If the state data is a full name, it will get mapped to the abbreviation, otherwise it will default to 
			// the abbreviation.
			tmpStateOnly			:=	MAP(	tmpStateName = 'ALABAMA'						 => 'AL', tmpStateName = 'ALASKA'	    	=> 'AK',
																	tmpStateName = 'AMERICAN SAMOA'      => 'AS', tmpStateName = 'ARIZONA'    	=> 'AZ',
																	tmpStateName = 'ARKANSAS'            => 'AR', tmpStateName = 'CALIFORNIA' 	=> 'CA',
																	tmpStateName = 'PANAMA CANAL ZONE'   => 'CZ', tmpStateName = 'COLORADO'   	=> 'CO',
																	tmpStateName = 'CONNECTICUT'         => 'CT', tmpStateName = 'DELAWARE'  	 	=> 'DE',
																	tmpStateName = 'DISTRICT OF COLUMBIA'=> 'DC', tmpStateName = 'FLORIDA'   	 	=> 'FL',
																	tmpStateName = 'GEORGIA'             => 'GA', tmpStateName = 'GUAM'	     	 	=> 'GU',
																	tmpStateName = 'HAWAII'              => 'HI', tmpStateName = 'IDAHO'	   	 	=> 'ID',
																	tmpStateName = 'ILLINOIS'            => 'IL', tmpStateName = 'INDIANA'    	=> 'IN',
																	tmpStateName = 'IOWA'                => 'IA', tmpStateName = 'KANSAS'	    	=> 'KS',
																	tmpStateName = 'KENTUCKY'            => 'KY', tmpStateName = 'LOUISIANA'  	=> 'LA',
																	tmpStateName = 'MAINE'               => 'ME', tmpStateName = 'MARYLAND'   	=> 'MD',
																	tmpStateName = 'MASSACHUSETTS'       => 'MA', tmpStateName = 'MICHIGAN'   	=> 'MI',
																	tmpStateName = 'MINNESOTA'           => 'MN', tmpStateName = 'MISSISSIPPI'	=> 'MS',
																	tmpStateName = 'MISSOURI'            => 'MO', tmpStateName = 'MONTANA'    	=> 'MT',
																	tmpStateName = 'NEBRASKA'            => 'NE', tmpStateName = 'NEVADA'	   	 	=> 'NV',
																	tmpStateName = 'NEW HAMPSHIRE'       => 'NH', tmpStateName = 'NEW JERSEY' 	=> 'NJ',
																	tmpStateName = 'NEW MEXICO'          => 'NM', tmpStateName = 'NEW YORK'   	=> 'NY',
																	tmpStateName = 'NORTH CAROLINA'      => 'NC', tmpStateName = 'NORTH DAKOTA' => 'ND',
																	tmpStateName = 'OHIO'                => 'OH', tmpStateName = 'OKLAHOMA'     => 'OK',                                                                                                 
																	tmpStateName = 'OREGON'              => 'OR', tmpStateName = 'PENNSYLVANIA' => 'PA', 
																	tmpStateName = 'PUERTO RICO'         => 'PR', tmpStateName = 'RHODE ISLAND' => 'RI',
																	tmpStateName = 'SOUTH CAROLINA'      => 'SC', tmpStateName = 'TENNESSEE'    => 'TN',
																	tmpStateName = 'SOUTH DAKOTA'        => 'SD', tmpStateName = 'UTAH'	       	=> 'UT',
																	tmpStateName = 'TEXAS'               => 'TX', tmpStateName = 'VIRGINIA'	   	=> 'VA',
																	tmpStateName = 'VERMONT'             => 'VT', tmpStateName = 'WASHINGTON'	 	=> 'WA',
																	tmpStateName = 'VIRGIN ISLANDS'      => 'VI', tmpStateName = 'WISCONSIN'	 	=> 'WI',
																	tmpStateName = 'WEST VIRGINIA'       => 'WV', tmpStateName = 'WYOMING'	   	=> 'WY',
																	tmpStateName = 'ILL'								 => 'IL',
																	tmpStateName);
																	
			returnAddr	:=	if (trim(tmpStateOnly,left,right) != '' or trim(tmpZip,left,right) != '',
														if(	trim(tmpCityOnly,left,right) != '',
																	StringLib.StringCleanSpaces(trim(tmpCityOnly,left,right) + ', ' +
																															trim(tmpStateOnly,left,right) + ' ' + 
																															trim(tmpZip,left,right)
																															), 
																	StringLib.StringCleanSpaces(trim(tmpStateOnly,left,right) + ' ' + 
																															trim(tmpZip,left,right)	
																															)
															),
														trim(tmpCityOnly,left,right)
													);	
			return returnAddr;
	end;												
																	
	
	//------------ csz parser ------------------//

  // This function handles the data that comes to us in the correct format, which is street data in 
	// address lines 1-4 and city state & zip data in their respective orig_city, orig_st & 
	// orig_zip fields.
	export csz(dataset(Prof_License.Layout_proLic_in) pProfLic, string1 ParseType, string1 CtyStZip) :=	function
	
		Prof_License.Layout_prolic_in_with_AID	trfCSZ(Prof_License.Layout_proLic_in l) :=	transform	
			// in order to handle all variations of how the city, state, zip data comes in a parameter drives what fields  
			// are looked at and concatenated together if needed.
			Addr2Parse				:=	map(	CtyStZip = '1'	=>	StringLib.StringCleanSpaces(l.orig_addr_1),
																	CtyStZip = '2'	=>	StringLib.StringCleanSpaces(l.orig_addr_2),
																	CtyStZip = '3'	=>	StringLib.StringCleanSpaces(l.orig_addr_3),
																	CtyStZip = '4'	=>	StringLib.StringCleanSpaces(l.orig_addr_4),
																	CtyStZip = 'S'	=>	StringLib.StringCleanSpaces(l.orig_addr_3 + ' ' + l.orig_st + ' ' + l.orig_zip),
																	CtyStZip = 'C'	=>	StringLib.StringCleanSpaces(l.orig_city + ' ' + l.orig_st + ' ' + l.orig_zip),
																	''
																);
					
			self.prep_addr_line1	:=	map(	ParseType = '1'	=>	trim(l.orig_addr_1,left,right),
																			ParseType = '2'	=>	StringLib.StringCleanSpaces(	trim(l.orig_addr_1,left,right) + ' ' +
																																												trim(l.orig_addr_2,left,right)
																																											),
																			ParseType = '3'	=>	StringLib.StringCleanSpaces(	trim(l.orig_addr_1,left,right) + ' ' +
																																												trim(l.orig_addr_2,left,right) + ' ' +
																																												trim(l.orig_addr_3,left,right)
																																											),
																			ParseType = '4'	=> 	StringLib.StringCleanSpaces(	trim(l.orig_addr_1,left,right) + ' ' +
																																												trim(l.orig_addr_2,left,right) + ' ' +
																																												trim(l.orig_addr_3,left,right) + ' ' +
																																												trim(l.orig_addr_4,left,right)
																																											),
																			''
																		);
												
																
			self.prep_addr_last_line	:=	FindAddr(Addr2Parse);
																			
			self							:=	l;
			SELF							:=	[];
		end;
		
		prepAddr	:=	project(pProfLic, trfCSZ(left));
		
		return prepAddr;
	end;  // csz function

//--------------- Special_1 Parser ------------------//
	
	export Special_1(dataset(Prof_License.Layout_proLic_in) pProfLic) :=	function
	
		Prof_License.Layout_prolic_in_with_AID	trfSpecial_1(Prof_License.Layout_proLic_in l) :=	transform	
			// For these vendors, the city state and zip data is either contained in the orig_addr_2 or 
			// orig_addr_3 fields, depending on the population of orig_addr_3 field
			Addr2Parse				:=	if (trim(l.orig_addr_3,left,right) != '',
																	StringLib.StringCleanSpaces(l.orig_addr_3),
																	StringLib.StringCleanSpaces(l.orig_addr_2)
																);
																
			self.prep_addr_line1			:=	if (trim(l.orig_addr_3,left,right) != '',
																					StringLib.StringCleanSpaces(	trim(l.orig_addr_1,left,right) + ' ' +
																																				trim(l.orig_addr_2,left,right)
																																			),
																					trim(l.orig_addr_1,left,right)
																				);
												
																
			self.prep_addr_last_line	:=	FindAddr(Addr2Parse);
																			
			self							:=	l;
			SELF							:=	[];
		end;
		
		prepAddr	:=	project(pProfLic, trfSpecial_1(left));
		
		return prepAddr;
	end;
	
//--------------- Special_2 Parser ------------------//
	
	export Special_2(dataset(Prof_License.Layout_proLic_in) pProfLic) :=	function
	
		Prof_License.Layout_prolic_in_with_AID	trfSpecial_2(Prof_License.Layout_proLic_in l) :=	transform	
			// For these vendors, the city state and zip data is either contained in the orig_addr_1 and 
			// orig_addr_2 fields or the orig_addr_3 & orig_addr_4 fields depending on the population of 
			// orig_addr_4 field
			Addr2Parse				:=	if (trim(l.orig_addr_4,left,right) != '',
																	StringLib.StringCleanSpaces(trim(l.orig_addr_3,left,right) + ' ' +
																															trim(l.orig_addr_4,left,right)
																															),
																	StringLib.StringCleanSpaces(trim(l.orig_addr_1,left,right) + ' ' +
																															trim(l.orig_addr_2,left,right)
																															)
																);

			self.prep_addr_line1			:=	if (trim(l.orig_addr_4,left,right) != '',
																					StringLib.StringCleanSpaces(	trim(l.orig_addr_1,left,right) + ' ' +
																																				trim(l.orig_addr_2,left,right)
																																			),
																					trim(l.orig_addr_1,left,right)
																				);
												
																
			self.prep_addr_last_line	:=	FindAddr(Addr2Parse);
																			
			self							:=	l;
			SELF							:=	[];
		end;
		
		prepAddr	:=	project(pProfLic, trfSpecial_2(left));
		
		return prepAddr;
	end;

//--------------- Special_3 Parser ------------------//
	
	export Special_3(dataset(Prof_License.Layout_proLic_in) pProfLic) :=	function
	
		Prof_License.Layout_prolic_in_with_AID	trfSpecial_3(Prof_License.Layout_proLic_in l) :=	transform	
			// For these vendors, the city state and zip data is either contained in the orig_addr_2 or the 
			// orig_city & orig_st & orig_zip fields depending on the population of orig_st & orig_zip fields. 
			Addr2Parse				:=	if (trim(l.orig_st,left,right) != '' and trim(l.orig_zip,left,right) != '',
																	StringLib.StringCleanSpaces(trim(l.orig_city,left,right) + ' ' +
																															trim(l.orig_st,left,right) + ' ' +
																															trim(l.orig_zip,left,right)
																															),
																	trim(l.orig_addr_2,left,right)
																);
																
			self.prep_addr_line1			:=	if (trim(l.orig_st,left,right) != '' and trim(l.orig_zip,left,right) != '',
																					StringLib.StringCleanSpaces(trim(l.orig_addr_1,left,right) + ' ' +
																																			trim(l.orig_addr_2,left,right) + ' ' +
																																			trim(l.orig_addr_3,left,right) + ' ' +
																																			trim(l.orig_addr_4,left,right)
																																			),
																					trim(l.orig_addr_1,left,right)
																				);
											
			self.prep_addr_last_line	:=	FindAddr(Addr2Parse);
																			
			self							:=	l;
			SELF							:=	[];
		end;
		
		prepAddr	:=	project(pProfLic, trfSpecial_3(left));
		
		return prepAddr;
	end;
	
//--------------- Special_4 Parser ------------------//
	
	export Special_4(dataset(Prof_License.Layout_proLic_in) pProfLic) :=	function
	
		Prof_License.Layout_prolic_in_with_AID	trfSpecial_4(Prof_License.Layout_proLic_in l) :=	transform	
			// For these vendors, the city state and zip data is either contained in the orig_addr_2, 
			// orig_addr_3 or the orig_addr_4 field depending on population of the orig_addr_4 field.
			Addr2Parse				:=	if (trim(l.orig_addr_4,left,right) != '',
																	trim(l.orig_addr_4,left,right),
																	if (trim(l.orig_addr_3,left,right) != '',
																				trim(l.orig_addr_3,left,right),
																				trim(l.orig_addr_2,left,right)
																			)
																);
																
			self.prep_addr_line1			:=	if (trim(l.orig_addr_4,left,right) != '',
																					StringLib.StringCleanSpaces(trim(l.orig_addr_1,left,right) + ' ' +
																																			trim(l.orig_addr_2,left,right) + ' ' +
																																			trim(l.orig_addr_3,left,right)
																																			),
																					if (trim(l.orig_addr_3,left,right) != '',
																								StringLib.StringCleanSpaces(trim(l.orig_addr_1,left,right) + ' ' +
																																						trim(l.orig_addr_2,left,right)
																																					  ),
																								trim(l.orig_addr_1,left,right)
																							)
																				);
											
			self.prep_addr_last_line	:=	FindAddr(Addr2Parse);
																			
			self							:=	l;
			SELF							:=	[];
		end;
		
		prepAddr	:=	project(pProfLic, trfSpecial_4(left));
		
		return prepAddr;
	end;
	
	//--------------- Special_6 Parser ------------------//
	
	export Special_6(dataset(Prof_License.Layout_proLic_in) pProfLic) :=	function
	
		Prof_License.Layout_prolic_in_with_AID	trfSpecial_6(Prof_License.Layout_proLic_in l) :=	transform	
			// For these vendors, the city state and zip data is either contained in the orig_addr_1, 
			// or the orig_addr_3 field depending on population of the orig_addr_1 field.
			Addr2Parse				:=	if (trim(l.orig_addr_1,left,right) != '',
																	trim(l.orig_addr_1,left,right),
																	trim(l.orig_addr_3,left,right)
																);

			self.prep_addr_line1			:=	if (trim(l.orig_addr_1,left,right) != '',
																					StringLib.StringCleanSpaces(trim(l.orig_addr_2,left,right) + ' ' +
																																			trim(l.orig_addr_3,left,right)
																																			),
																					trim(l.orig_addr_2,left,right)
																				);
											
			self.prep_addr_last_line	:=	FindAddr(Addr2Parse);
																			
			self							:=	l;
			SELF							:=	[];
		end;
		
		prepAddr	:=	project(pProfLic, trfSpecial_6(left));
		
		return prepAddr;
	end;

	//--------------- Special_7 Parser ------------------//
	
	export Special_7(dataset(Prof_License.Layout_proLic_in) pProfLic) :=	function
	
		Prof_License.Layout_prolic_in_with_AID	trfSpecial_7(Prof_License.Layout_proLic_in l) :=	transform	
			// For these vendors, the city state and zip data is either contained in the orig_addr_2, 
			// or the orig_addr_4 field depending on population of the orig_addr_4 field.
			Addr2Parse				:=	if (trim(l.orig_addr_4,left,right) != '',
																	trim(l.orig_addr_4,left,right),
																	trim(l.orig_addr_2,left,right)
																);
																
			self.prep_addr_line1			:=	if (trim(l.orig_addr_4,left,right) != '',
																					StringLib.StringCleanSpaces(trim(l.orig_addr_1,left,right) + ' ' +
																																			trim(l.orig_addr_2,left,right) + ' ' +
																																			trim(l.orig_addr_3,left,right)
																																			),
																					trim(l.orig_addr_1,left,right)
																				);
											
			self.prep_addr_last_line	:=	FindAddr(Addr2Parse);
																			
			self							:=	l;
			SELF							:=	[];
		end;
		
		prepAddr	:=	project(pProfLic, trfSpecial_7(left));
		
		return prepAddr;
	end;

	//--------------- Special_8 Parser ------------------//
	
	export Special_8(dataset(Prof_License.Layout_proLic_in) pProfLic) :=	function
	
		Prof_License.Layout_prolic_in_with_AID	trfSpecial_8(Prof_License.Layout_proLic_in l) :=	transform	
			// For these vendors, the city state and zip data is either contained in the orig_addr_2, 
			// or the orig_st & orig_zip fields depending on population of the orig_addr_2 field.
			Addr2Parse				:=	if (trim(l.orig_st,left,right) != '',
																	StringLib.StringCleanSpaces(trim(l.orig_st,left,right) + ' ' +
																															trim(l.orig_zip,left,right)
																															),
																	trim(l.orig_addr_1,left,right)
																);
																
			self.prep_addr_line1			:=	if (trim(l.orig_st,left,right) != '',
																					trim(l.orig_addr_2,left,right),
																					trim(l.orig_addr_1,left,right)
																				);
											
			self.prep_addr_last_line	:=	FindAddr(Addr2Parse);
																			
			self							:=	l;
			SELF							:=	[];
		end;
		
		prepAddr	:=	project(pProfLic, trfSpecial_8(left));
		
		return prepAddr;
	end;

	//--------------- Special_9 Parser ------------------//
	
	export Special_9(dataset(Prof_License.Layout_proLic_in) pProfLic) :=	function
	
		Prof_License.Layout_prolic_in_with_AID	trfSpecial_9(Prof_License.Layout_proLic_in l) :=	transform	
			// For these vendors, the city state and zip data is contained in the orig_addr_4 field.
			Addr2Parse				:=	trim(l.orig_addr_4,left,right);
																
			self.prep_addr_line1			:=	StringLib.StringCleanSpaces(trim(l.orig_addr_1,left,right) + ' ' +
																																trim(l.orig_addr_2,left,right) + ' ' +
																																trim(l.orig_addr_3,left,right)
																																);
											
			self.prep_addr_last_line	:=	FindAddr(Addr2Parse);
																			
			self							:=	l;
			SELF							:=	[];
		end;
		
		prepAddr	:=	project(pProfLic, trfSpecial_9(left));
		
		return prepAddr;
	end;
	
	//----------------- entire address spans two fields ------------------//
	
	export TwoField(dataset(Prof_License.Layout_proLic_in) pProfLic) :=	function
	
		Prof_License.Layout_proLic_in	trfTwoAddress(Prof_License.Layout_proLic_in l) :=	transform
			self.orig_zip		:=	lib_stringlib.StringLib.StringFilter(l.orig_addr_2,'0123456789')[1..5];
			self.orig_addr_1:=	StringLib.StringCleanSpaces(StringLib.StringFindReplace(trim(l.orig_addr_1,left,right) + ' ' + 
																											lib_stringlib.StringLib.StringFilter(stringlib.StringToUppercase(l.orig_addr_2),
																											'ABCDEFGHIJKLMNOPQRSTUVWXYZ '),',',''));
			self.orig_st		:=	if (self.orig_addr_1[length(trim(self.orig_addr_1,left,right))-2] = ' ',
																self.orig_addr_1[length(trim(self.orig_addr_1,left,right))-1..length(trim(self.orig_addr_1,left,right))],
																''	
															);
			self						:=	l;
			self						:=	[];
		end;

		captureAddr	:=	project(pProfLic, trfTwoAddress(left));

		withCity	:=	record
				Prof_License.Layout_proLic_in;
				string50	city1;
				string50	city2;
				string		match;
		end;

		withCity	joinCity(captureAddr l, CityFile r)	:=	transform
				self.city1	:=	r.city;
				self.city2	:=	r.prefctystname;
				self.match	:=	if (StringLib.StringFind(l.orig_addr_1, ' ' + trim(r.city,left,right) + ' ', 1) != 0,
													r.city,
													if (StringLib.StringFind(l.orig_addr_1, ' ' + trim(r.prefctystname,left,right) + ' ', 1) != 0,
																	r.prefctystname,
																	''
															)
											);
				self				:=	l;
		end;

		joinForCity	:=	join	(	captureAddr
														,CityFile
														,left.zip		=	right.zip5 
														,joinCity(left,right)
														,left outer
													);
											
		file_dist := distribute(joinForCity, hash(prolic_key));
		file_sort := sort(group(sort(file_dist,RECORD, except city1,city2, match,local),record, except city1,city2, match,local),-match);

		withCity  rollupXform(withCity l, withCity r) := transform
				self.orig_city  	:= if(l.orig_city = '' and r.match != '', r.match, l.orig_city);
				self 							:= r;
		end;

		updateCity := dedup(group(iterate(file_sort,rollupXform(LEFT,RIGHT))),record, except city1,city2,match,local);		

		Prof_License.Layout_prolic_in_with_AID trfPrep(withCity l)	:=	transform
				string csz								:=	StringLib.StringCleanSpaces(trim(l.orig_city,left,right) + ' ' + trim(l.orig_st,left,right) ) + '$';
				self.prep_addr_line1			:=	regexreplace(csz,trim(l.orig_addr_1,left,right),'');		
				self.prep_addr_last_line	:=	if (l.orig_city != '',
																						StringLib.StringCleanSpaces(	trim(l.orig_city,left,right) + ', ' +
																																					trim(l.orig_st,left,right) + ' ' + 
																																					trim(l.orig_zip,left,right)[1..5]
																																				), 
																						StringLib.StringCleanSpaces( 	trim(l.orig_st,left,right) + ' ' + 
																																					trim(l.orig_zip,left,right)[1..5])
																					); 
				self											:=	l;
				self											:=	[];
		end;																	

		prepAddr	:=	project(updateCity, trfPrep(left));
		
		RETURN prepAddr;
	END;
	
		//----------------- entire address is in one field ------------------//

	export OneField(dataset(Prof_License.Layout_proLic_in) pProfLic) :=	function

		Prof_License.Layout_proLic_in	trfOneAddress(Prof_License.Layout_proLic_in l) :=	transform
			self.orig_zip		:=	trim(regexfind('[0-9]*$ | [0-9]*[-]*[0-9]*$',trim(l.orig_addr_1,left,right), 0),left,right)[1..5];
			self.orig_addr_1:=	trim(l.orig_addr_1[1..StringLib.StringFind(l.orig_addr_1, trim(self.orig_zip,left,right),1)-1],left,right);
			self.orig_st		:=	if (self.orig_addr_1[length(trim(self.orig_addr_1,left,right))-2] = ' ',
																self.orig_addr_1[length(trim(self.orig_addr_1,left,right))-1..length(trim(self.orig_addr_1,left,right))],
																''	
															);
			self						:=	l;
			self						:=	[];
		end;

		captureAddr	:=	project(pProfLic, trfOneAddress(left));

		withCity	:=	record
				Prof_License.Layout_proLic_in;
				string50	city1;
				string50	city2;
				string		match;
		end;

		withCity	joinCity(captureAddr l, CityFile r)	:=	transform
				self.city1	:=	r.city;
				self.city2	:=	r.prefctystname;
				self.match	:=	if (StringLib.StringFind(l.orig_addr_1, ' ' + trim(r.city,left,right) + ' ', 1) != 0,
													r.city,
													if (StringLib.StringFind(l.orig_addr_1, ' ' + trim(r.prefctystname,left,right) + ' ', 1) != 0,
																	r.prefctystname,
																	''
															)
											);
				self				:=	l;
		end;

		joinForCity	:=	join	(	captureAddr
														,CityFile
														,left.zip		=	right.zip5 
														,joinCity(left,right)
														,left outer
													);
											
		file_dist := distribute(joinForCity, hash(prolic_key));
		file_sort := sort(group(sort(file_dist,RECORD, except city1,city2, match,local),record, except city1,city2, match,local),-match);
		
		withCity  rollupXform(withCity l, withCity r) := transform
				self.orig_city  	:= if(l.orig_city = '' and r.match != '', r.match, l.orig_city);
				self 							:= r;
		end;

		updateCity := dedup(group(iterate(file_sort,rollupXform(LEFT,RIGHT))),record, except city1,city2,match,local);		

		Prof_License.Layout_prolic_in_with_AID trfPrep(withCity l)	:=	transform
				string csz								:=	StringLib.StringCleanSpaces(trim(l.orig_city,left,right) + ' ' + trim(l.orig_st,left,right) ) + '$';
				self.prep_addr_line1			:=	regexreplace(csz,trim(l.orig_addr_1,left,right),'');
				self.prep_addr_last_line	:=	if (l.orig_city != '',
																					StringLib.StringCleanSpaces(	trim(l.orig_city,left,right) + ', ' +
																																				trim(l.orig_st,left,right) + ' ' + 
																																				trim(l.orig_zip,left,right)[1..5]
																																			), 
																					StringLib.StringCleanSpaces( 	trim(l.orig_st,left,right) + ' ' + 
																																				trim(l.orig_zip,left,right)[1..5])
																					); 
				self											:=	l;
				self											:=	[];
		end;																	

		prepAddr	:=	project(updateCity, trfPrep(left));
		
		RETURN prepAddr;
	END;

END;	