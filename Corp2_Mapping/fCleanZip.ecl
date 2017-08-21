import ut,corp2;
export fCleanZip(string pStateOrigin,string pStateOriginDesc,string pAddr1 = '',string pAddr2 = '',string pCity  = '',string pState = '',string pZip = '',string pCountry = '') := module

		//********************************************************************
		//CleanZip: The input parameters are the state code (e.g. OH), the state
		//					origin description (e.g. OHIO), the street address (can be
		//					in two parts; pAddr1 and pAddr2), the city, the state, the
		//					zip and the country.  
		//					
		//					If the zip code doesn't exist, then the address 
		//					parameter is searched to see if the zip code exists at the
		//					end of the field.  
		//
		//					Some assumtions are made.  If no country is present we are
		// 					going to default that it as being a US zip code of which any 
		//					alpha characters will be removed.
		//
		//					Note:  This formats the US zip codes into the standard
		//								 format of 99999-9999 or 99999 (based upon input).
		//********************************************************************
		shared UC_StateOrigin			:= ut.fn_RemoveSpecialChars(corp2.t2u(pStateOrigin));
		shared UC_StateOriginDesc	:= ut.fn_RemoveSpecialChars(corp2.t2u(pStateOriginDesc));
		shared UC_Addr1 					:= ut.fn_RemoveSpecialChars(corp2.t2u(pAddr1));
		shared UC_Addr2						:= ut.fn_RemoveSpecialChars(corp2.t2u(pAddr2));
		shared UC_City		 				:= ut.fn_RemoveSpecialChars(corp2.t2u(pCity));
		shared UC_State						:= ut.fn_RemoveSpecialChars(corp2.t2u(pState));
		shared UC_Zip							:= ut.fn_RemoveSpecialChars(corp2.t2u(pZip));
		shared UC_Country 				:= ut.fn_RemoveSpecialChars(corp2.t2u(pCountry));

		shared alpha							:= 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
		
		export isPOBOX						:= IF(corp2.t2u(pZip) = '',stringlib.stringfilter(UC_Addr1 + UC_Addr2,alpha) in ['POBOX','PO','BOX'],false);
		
		//Try and locate zip in pAddress if pZip is blank
		export TempZip		  := IF(corp2.t2u(pZip) = '' and not(isPOBOX)
														 ,REGEXFIND('[0-9]{5}\\-*[0-9]{0,4}$',corp2.t2u(UC_Addr1 + UC_Addr2),0)
														 ,UC_Zip
														 );
		//removes all spaces and special characters
		export vZip 				:= REGEXREPLACE('[^[:alnum:]]',TempZip,'');
		//ck if there are 5 digits and it is valid
		export isvalidZip5	:= REGEXFIND('[0-9]{5}',TempZip[1..5]) and (integer)vZip[1..5] <> 0 and vZip 			 <> '99999';
		//ck if a 4 digit-suffix exists and is valid		
		export isvalidZip4	:= REGEXFIND('[0-9]{4}',TempZip[7..10]) and (integer)vZip[6..9] <> 0 and vZip[6..9] <> '9999';

		export Zip5				:= IF(LENGTH(vZip) >= 5 AND isvalidZip5 = true,corp2.t2u(vZip[1..5]),'');
		export Zip4				:= IF(LENGTH(vZip) >= 9 AND isvalidZip4 = true,corp2.t2u(vZip[6..9]),'');

		export Country		:= Corp2_Mapping.fCleanCountry(pStateOrigin,pStateOriginDesc,pState,pCountry).Country;

		//returns 999999999 if zip5 exists and is valid and zip4 exists and is valid
		//returns 99999 if zip5 exists and zip4 doesn't exist or is invalid
		export Zip				:= MAP(Country  = 'US' => IF(Zip4<>'',vZip,Zip5), //US Zip
														 Country  = ''	 => IF(Zip4<>'',vZip,Zip5), //Assuming US Country and return "cleaned" Zip
														 UC_Zip																			//Assuming NOT the US and return "non-cleaned" Zip
														 );								 
end;