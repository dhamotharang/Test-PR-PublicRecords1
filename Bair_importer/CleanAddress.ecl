import address, bair;
EXPORT CleanAddress := MODULE

			EXPORT get_address_street (STRING pAddress) := FUNCTION
				address_street 	:= trim(regexfind('(.*)\\s(.*),',pAddress,1) + ' ' + regexfind('(.*)\\s(.*),',pAddress,2));
				return address_street;
			END;
			
			EXPORT get_city_state_zip (STRING pAddress):= FUNCTION
				city_st_zip 	:= trim(regexfind(',(.*)\\s(.*)',pAddress,1),LEFT,RIGHT) + ' ' + regexfind(',(.*)\\s(.*)',pAddress,2);			
				return city_st_zip;
			END;
			
			EXPORT clean_address(unsigned4 pDataProviderID, STRING pAddress) := FUNCTION
				
				dpl := Bair.files().DataProviderLoc_Base.built(dataProviderID=pDataProviderID);
				dpi := bair.files().DataProviderImp_Base.built(dataProviderID=pDataProviderID);
				
				pCity 					:= dpl[1].city;
				pState 					:= dpl[1].state;
				pMultiplecities := dpi[1].multiplecities;
				
				address_street 		:= get_address_street(pAddress);
				address_street_F 	:= if (pMultiplecities=0, pAddress, address_street);			
				city_st_zip				:= get_city_state_zip(pAddress);
				city_st_zip_F 		:= if (pMultiplecities=0,	pCity + ', ' + pState, city_st_zip); 
				
				address_clean := address.CleanAddress182(address_street_F, city_st_zip_F);	
				
				return address_clean;
			END;
			
			EXPORT address_lookup(unsigned4 pDataProviderID, STRING pAddress) := FUNCTION
			  
				al	:= bair.files().AddressLookup_Base.built(dataProviderID=pDataProviderID and address=pAddress);
				address_coordinates := (string)al[1].x_coordinate + '|' + (string)al[1].y_coordinate;
				return address_coordinates; 
			END;

END;