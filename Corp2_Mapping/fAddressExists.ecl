import address,corp2,ut;
export fAddressExists(string pStateOrigin,string pStateOriginDesc,string pAddr1 = '',string pAddr2 = '',string pCity = '',string pState = '',string pZip = '', string pCountry = '') := module
		//********************************************************************
		//AddressExists: Address Line1 and Zip Code or combination of City and
		//							 State indicates that an address exists.
		//******************************************************************** 
		shared UC_StateOrigin			:= ut.fn_RemoveSpecialChars(corp2.t2u(pStateOrigin));
		shared UC_StateOriginDesc	:= ut.fn_RemoveSpecialChars(corp2.t2u(pStateOriginDesc));
		shared UC_Addr1 					:= ut.fn_RemoveSpecialChars(corp2.t2u(pAddr1));
		shared UC_Addr2						:= ut.fn_RemoveSpecialChars(corp2.t2u(pAddr2));
		shared UC_City		 				:= ut.fn_RemoveSpecialChars(corp2.t2u(pCity));
		shared UC_State						:= ut.fn_RemoveSpecialChars(corp2.t2u(pState));
		shared UC_Zip							:= ut.fn_RemoveSpecialChars(corp2.t2u(pZip));
		shared UC_Country 				:= ut.fn_RemoveSpecialChars(corp2.t2u(pCountry));

		export AddressLine1				:= Corp2_Mapping.fCleanAddress(UC_StateOrigin,UC_StateOriginDesc,UC_Addr1,UC_Addr2,UC_City,UC_State,UC_Zip,UC_Country).AddressLine1; //street address
		export AddressLine2				:= Corp2_Mapping.fCleanAddress(UC_StateOrigin,UC_StateOriginDesc,UC_Addr1,UC_Addr2,UC_City,UC_State,UC_Zip,UC_Country).AddressLine2; //city and state
		export AddressLine3				:= Corp2_Mapping.fCleanAddress(UC_StateOrigin,UC_StateOriginDesc,UC_Addr1,UC_Addr2,UC_City,UC_State,UC_Zip,UC_Country).AddressLine3; //country
		export City								:= Corp2_Mapping.fCleanAddress(UC_StateOrigin,UC_StateOriginDesc,UC_Addr1,UC_Addr2,UC_City,UC_State,UC_Zip,UC_Country).City;				 //can be a US or Foreign City
		export State							:= Corp2_Mapping.fCleanAddress(UC_StateOrigin,UC_StateOriginDesc,UC_Addr1,UC_Addr2,UC_City,UC_State,UC_Zip,UC_Country).State;				 //should be a US state
		export Zip								:= Corp2_Mapping.fCleanAddress(UC_StateOrigin,UC_StateOriginDesc,UC_Addr1,UC_Addr2,UC_City,UC_State,UC_Zip,UC_Country).Zip;					 //can be a US or Foreign Zip

		export streetaddr_exists 	:= AddressLine1 <> ''; 	//street address
		export citystate_exists		:= AddressLine2 <> ''; 	//city and state
		export country_exists			:= AddressLine3 <> ''; 	//country
		export city_exists				:= City  <> '';				 	//can be a US or Foreign City
		export state_exists				:= State <> '';					//should be a US state
		export zip_exists					:= Zip   <> '';					//can be a US or Foreign Zip
		
		export boolean ifAddr1_or_Addr2_exists  := if (streetaddr_exists or citystate_exists,true,false);
		export boolean ifCity_and_State_exists  := if (city_exists and state_exists,true,false);
		export boolean ifZip_exists						 	:= if (zip_exists,true,false);
		export boolean ifAddressZipExists			 	:= if (ifAddr1_or_Addr2_exists and ifZip_exists,true,false);
		export boolean ifAddressCityStateExists := if (ifAddr1_or_Addr2_exists and ifCity_and_State_exists,true,false);
		export boolean ifAddressExists					:= map(ifAddressZipExists 																 													=> true, //US Zip
																									 ifAddressCityStateExists 																								 	 	=> true, //US City/State
																									 ifAddr1_or_Addr2_exists  and country_exists <> true 													=> true, //Assuming Foreign Address
																									 ifAddr1_or_Addr2_exists  and country_exists = true and AddressLine3 <> 'US'  => true, //Assuming Foreign Address
																									 false
																									);
end;