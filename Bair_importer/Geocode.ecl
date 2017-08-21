import iesp,STD,bair,address,bair_importer;

EXPORT Geocode := module		
		
		EXPORT Google_Geocode_OFFLINE(string pStandardAddress)  := FUNCTION
				google_geocoded:= '<GeocodeResponse><status>OK</status><result><type>street_address</type><formatted_address></formatted_address><geometry><location><lat>0</lat><lng>0</lng></location></geometry><place_id></place_id></result></GeocodeResponse>';
				RETURN google_geocoded;
		END; 		
		
		EXPORT Google_Geocode(string pStandardAddress) 			:= FUNCTION
			IMPORT STD;
			STD.System.Debug.Sleep(bair_importer._Constants.sleep_time);    //pause for one second before continuing
				
			queryURL := 'http://'+bair_importer.ESP_Config.User+':'+bair_importer.ESP_Config.Password+'@'+bair_importer.ESP_Config.Host+':'+bair_importer.ESP_Config.Port+'/'+bair_importer.ESP_Config.WebService+'?ver_='+bair_importer.ESP_Config.Version;
			vStandardAddress := XMLENCODE(pStandardAddress);
			t_EndUser := record
				STRING CompanyName		{	XPATH('CompanyName' )}		:= '';
				STRING StreetAddress1	{	XPATH('StreetAddress1')}	:= '';
				STRING City						{	XPATH('City')}						:= '';
				STRING State					{	XPATH('State')}						:= '';
				STRING Zip5						{	XPATH('Zip5')}						:= '';
			end;

			t_User := record
				STRING ReferenceCode	{	XPATH('ReferenceCode' )} 	:= '';
				STRING BillingCode		{	XPATH('BillingCode')} 		:= '';
				STRING QueryId				{	XPATH('QueryId')}					:= '';
				STRING GLBPurpose			{	XPATH('GLBPurpose')}			:= '';
				STRING DLPurpose			{	XPATH('DLPurpose')}				:= '';
				t_EndUser EndUser  		{ XPATH('EndUser')};
				STRING MaxWaitSeconds	{	XPATH('MaxWaitSeconds')}	:= '0';
				STRING AccountNumber	{	XPATH('AccountNumber')}		:= '';
			end;

			t_SearchBy := record
				STRING ClientID	{	XPATH('ClientID' )}	:= bair_importer.ESP_Config.ClientID;
				STRING Key			{	XPATH('Key' )}			:= bair_importer.ESP_Config.Key;
				STRING Address	{	XPATH('Address')} 	:= STD.Str.ToUpperCase(vStandardAddress);
			end;

			rRequest := record
				t_User		 	User  		{	XPATH('User')};	
				STRING 			Options		{	XPATH('Options' )} 				:= '';
				t_SearchBy 	SearchBy 	{	XPATH('SearchBy')};
			end;

			t_location := record
				string lat {XPATH('lat')};
				string lng {XPATH('lng')};
			end;

			t_viewport := record
				t_location southwest {XPATH('southwest')};
				t_location northeast {XPATH('northeast')};
			end;
			
			t_geometry := record
				t_location location 	{XPATH('location')};
				string location_type 	{XPATH('location_type')};
				t_viewport	viewport 	{XPATH('viewport')};
			end;
			
			t_type := record
				string type1 {XPATH('')};
			end;
			
			t_address_component := record
				string long_name 	{XPATH('long_name')};
				string short_name {XPATH('short_name')};		
				dataset(t_type) type {XPATH('type')};
			end;

			t_result := record
				dataset(t_type) type {XPATH('type')};
				string formatted_address 				{XPATH('formatted_address')};
				dataset(t_address_component)	address_component {XPATH('address_component')};
				t_geometry	geometry						{XPATH('geometry')};
				string place_id 								{XPATH('place_id')};
			end;

			t_SearchRecord := record
				string status		{XPATH('status')};
				dataset(t_result) result {XPATH('result')};
			end;

			rResponse := record,maxlength(5000000)
				string XMLResponse {XPATH('Data')};
			end;
			
			soapresults	:=	SOAPCALL(	
														queryURL
													,	'GoogleGeolocationRequest'
													,	rRequest
													,	dataset(rResponse)
													,	LITERAL
													,	XPATH('GoogleGeolocationResponseEx/response')
													,	SOAPACTION('WsGatewayEx/GoogleGeolocation?ver_=2&_product_code=false&soap_builder_')
													, LOG
												)	;
												
			return(soapresults[1].XMLResponse);

			
		END;
		
		
	EXPORT Geocoding_Log(pBuildVersion, pAddresses) := FUNCTIONMACRO
			import PromoteSupers;
	
			//Pull Log since last 24 hours - Discard older
			previous 			:= dataset(bair_importer._Constants.bair_geocoding_log,bair_importer.layouts.Bair_Geocoding_Log,thor,opt)(datetime >= (unsigned8)((string8)std.date.today() + ut.getTime())-bair_importer._Constants.ONE_DAY);

			//New Count
			datetime_stamp_v := (unsigned8)((string8)std.date.today() + ut.getTime())-bair_importer._Constants.us_eastern_time;
			count_v := COUNT(pAddresses(ac_originated = 'GOOGLE'));
			geocoding_log := dataset([{datetime_stamp_v,pBuildVersion,count_v}],bair_importer.layouts.Bair_Geocoding_Log);

			//Append new records to existing Log
			new_geocoding_log := previous + geocoding_log;
			
			//Write the Log File
			// ut.MAC_SF_BuildProcess(sort(new_geocoding_log,-datetime),bair_importer._Constants.bair_geocoding_log, doIt ,2,false,true,'','');
			PromoteSupers.MAC_SF_BuildProcess(sort(new_geocoding_log,-datetime),bair_importer._Constants.bair_geocoding_log, doIt ,2,false,true,'','');
			RETURN doIt;	
	ENDMACRO;
	
	EXPORT GoogleIt_fun (pAgency, pAddresses) := 	FUNCTIONMACRO
	
		bair_importer.layouts.address_cache temp_googleit (bair_importer.layouts.address_cache L) := TRANSFORM
				google_geocoded := bair_importer.Geocode.Google_Geocode(L.ac_address);
				address_type := regexreplace('<type>|<\\/type>',regexfind('<type>[\\s\\S]*?<\\/type>',google_geocoded,0),'');
				x_coordinate := regexreplace('<lng>|<\\/lng>',regexfind('<lng>[\\s\\S]*?<\\/lng>',google_geocoded,0),'');
				y_coordinate := regexreplace('<lat>|<\\/lat>',regexfind('<lat>[\\s\\S]*?<\\/lat>',google_geocoded,0),'');
				SELF.ac_google_geocoded									:=		google_geocoded;
				SELF.ac_x_coordinate 										:= 		(real8)x_coordinate;
				SELF.ac_y_coordinate 										:= 		(real8)y_coordinate;
				SELF.ac_accuracy 												:= 		map(address_type = 'street_address' => '8', 
																												address_type = 'intersection' => '7',
																												address_type = 'administrative_area_level_2' => '4',
																												address_type = 'political' => '4',
																												address_type = 'administrative_area_level_1' => '4',
																												address_type = 'natural_feature' => '4',
																												address_type = 'park' => '4',
																												address_type = 'administrative_area_level_3' => '4',
																												address_type = 'parking' => '4',
																												address_type = 'route' => '4',
																												address_type = 'locality' => '4',
																												address_type = 'transit_station' => '4',
																												address_type = 'neighborhood' => '4',
																												address_type = 'colloquial_area' => '4',
																												address_type = 'postal_code_prefix' => '4',
																												address_type = 'postal_code' => '4',
																												address_type = 'sublocality_level_1' => '5',
																												address_type = 'sublocality_level_4' => '5',
																												address_type = 'country' => '2',
																												address_type = 'ZERO_RESULTS' => '0',
																												address_type = 'zoo' => '6',
																												address_type = 'school' => '6',
																												address_type = 'doctor' => '6',
																												address_type = 'campground' => '6',
																												address_type = 'bus_station' => '6',
																												address_type = 'hospital' => '6',
																												address_type = 'library'=> '6',
																												address_type = 'courthouse' => '6',
																												address_type = 'veterinary_care'=> '6',
																												address_type = 'stadium' => '6',
																												address_type = 'aquarium' => '6',
																												address_type = 'subpremise' => '6',
																												address_type = 'city_hall'=> '6',
																												address_type = 'synagogue' => '6',
																												address_type = 'place_of_worship' => '6',
																												address_type = 'pharmacy'=> '6',
																												address_type = 'subway_station' => '6',
																												address_type = 'museum' => '6',
																												address_type = 'cemetery' => '6',
																												address_type = 'university' => '6',
																												address_type = 'establishment' => '6',
																												address_type = 'premise' => '6',
																												address_type = 'fire_station' => '6',
																												address_type = 'police' => '6',
																												address_type = 'point_of_interest' => '6',
																												address_type = 'airport' => '6',
																												address_type = 'church' => '6',
																												'6');
			SELF.ac_originated 											:= 		'GOOGLE';
			SELF.ac_clean_address_182								:=    L.ac_clean_address_182[1..145] + y_coordinate[1..10] + x_coordinate[1..10] + l.ac_clean_address_182[166..182];
			SELF																		:= 		L;
		END;		
		
		google_addresses := project(pAddresses, temp_googleit(left));	

		RETURN google_addresses;
	ENDMACRO;
	
	
	EXPORT CleanIt_fun (pAgency, pAddresses) := 	FUNCTIONMACRO
		
		CleanItTbl := table(pAddresses,{ac_dataProviderID, ac_address});
		CleanItSrt := sort(CleanItTbl, ac_dataProviderID, ac_address);
		CleanItSet := dedup(CleanItSrt, ac_dataProviderID, ac_address);

		dpl := Bair.files().DataProviderLoc_Base.built(dataProviderID = (unsigned4) pAgency);
		city_state := dpl[1].city + ' ' + dpl[1].state;
		
		bair_importer.layouts.address_cache temp_cleanit (CleanItSet L) := TRANSFORM
			
			clean_address := ut.CleanSpacesAndUpper(regexreplace('^,|,$|^-|-$',regexreplace('[^a-zA-Z0-9 \\-,]|,,|^0\\s', regexreplace('\\s,\\s',L.ac_address,', ') ,''),''));
			address1 := regexfind('([^,]+)',clean_address,1);
			address2 	:= trim(regexfind(',(.*)\\s(.*)',clean_address,1),LEFT,RIGHT) + ' ' + regexfind(',(.*)\\s(.*)',clean_address,2);
			address2F :=  if (address2 = '',city_state, address2);		
			address1F := regexreplace(' \\d*$', regexreplace(dpl[1].city+'|'+dpl[1].state,address1,''),'');
			states := 'AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY';
			address3F := if (regexfind(states,address2F),ut.CleanSpacesAndUpper(regexreplace(',',address2F,'')),city_state);
					
			Clean_Address_182 		:= 		if(L.ac_address != '' AND L.ac_address != 'AT LARGE',address.CleanAddress182(address1F, address3F),'');
			SELF.ac_address				:=  	ut.CleanSpacesAndUpper(L.ac_address);
			SELF.ac_dataProviderID:=	  L.ac_dataProviderID;
			SELF.ac_x_coordinate 	:= 	  if(Clean_Address_182[179] != 'E',(real8)Clean_Address_182[156..165],0);
			SELF.ac_y_coordinate 	:= 		if(Clean_Address_182[179] != 'E',(real8)Clean_Address_182[146..155],0);
			SELF.ac_accuracy 			:= 		'8';
			SELF.ac_originated 		:= 		if(Clean_Address_182 != '' or  L.ac_address = 'AT LARGE',if(Clean_Address_182[179] != 'E','INTERNAL','GOOGLEIT'),'EMPTY');
			SELF.ac_clean_address_182 := Clean_Address_182;
			SELF.ac_google_geocoded := '';
			SELF.ac_edit_date			:= 		v_edit_date;
			SELF.ac_geocoded			:= 		'1';
			SELF									:= 		L;
		END;
		
		address_cleaned := project (CleanItSet, temp_cleanit(LEFT));	
		return address_cleaned;
	ENDMACRO;
	
	EXPORT MAC_GeoMos(pBuildVersion,EVENT_MO_input, pAgency) := FUNCTIONMACRO  

		IMPORT bair,ut,STD,address;

		time := ut.getTime();
		date := (string8)std.date.today();
		v_edit_date := date[1..4] + '-' + date[5..6] + '-' + date[7..8] + ' ' + time[1..2] + ':' + time[3..4] + ':' + time[5..6] + '.000';

		AddressCache 	:= bair_importer.files().baseLNAddressCache.built(ac_x_coordinate != 0 and ac_y_coordinate != 0);

		bair_importer.layouts.address_cache temp_mos (EVENT_MO_input L, bair_importer.layouts.address_cache R, INTEGER C) := TRANSFORM
			//extend =>
			x_coordinate 	:= (real8)L.x_coordinate;
			y_coordinate 	:= (real8)L.y_coordinate;
			accuracy :=  if(L.Accuracy = '0','5', L.Accuracy);
			geocoded :=  if(R.ac_geocoded='','1',R.ac_geocoded);
			provided_by_agency := IF (x_coordinate != 0 and y_coordinate != 0, TRUE, FALSE);
			
			SELF.ac_dataProviderID									:=		(unsigned4)L.ORI;
			SELF.ac_address 												:= 		ut.CleanSpacesAndUpper(L.address_of_Crime);
			SELF.ac_x_coordinate 										:= 		IF (provided_by_agency, x_coordinate, R.ac_x_coordinate);
			SELF.ac_y_coordinate 										:= 		IF (provided_by_agency, y_coordinate, R.ac_y_coordinate);
			SELF.ac_geocoded 												:= 		IF (provided_by_agency, L.Geocoded, geocoded);
			SELF.ac_accuracy 												:= 		IF (provided_by_agency, accuracy, R.ac_accuracy);
			SELF.ac_edit_date 											:= 		R.ac_edit_date;
			SELF.ac_clean_address_182 							:= 		R.ac_clean_address_182;
			SELF.ac_google_geocoded									:= 		R.ac_google_geocoded;
			SELF.ac_originated 											:= 		R.ac_originated;
			SELF																		:= 		L;
		END;
		
		addresses := join(EVENT_MO_input, 
							 AddressCache, 
							left.ORI = right.ac_dataProviderID and ut.CleanSpacesAndUpper(left.address_of_Crime) = ut.CleanSpacesAndUpper(right.ac_address), 
							temp_mos(LEFT,RIGHT,COUNTER),
							left outer,
							hash);

		addresses_NotFound  := addresses(ac_clean_address_182  = '' and ac_x_coordinate = 0 and ac_y_coordinate = 0);
		address_cleaned 		:= Bair_importer.Geocode.CleanIT_fun(pAgency, addresses_NotFound);
		internal_addresses	:= address_cleaned(ac_originated = 'INTERNAL');
		googleIt 						:= address_cleaned(ac_originated = 'GOOGLEIT');		
		google_addresses 		:= Bair_importer.Geocode.GoogleIT_fun (pAgency, googleIt);
		bair_importer.geocode.Geocoding_Log(pBuildVersion, google_addresses);
		new_addresses 			:= internal_addresses + google_addresses;
		RETURN new_addresses;
		
	ENDMACRO;

	EXPORT MAC_GeoPersons(pBuildVersion, EVENT_PERSONS_input, pAgency, pAddresses ) := FUNCTIONMACRO  

		IMPORT bair,ut,STD,address;
		time := ut.getTime();
		date := (string8)std.date.today();
		v_edit_date := date[1..4] + '-' + date[5..6] + '-' + date[7..8] + ' ' + time[1..2] + ':' + time[3..4] + ':' + time[5..6] + '.000';

		AddressCache  := dedup(bair_importer.files().baseLNAddressCache.built(ac_x_coordinate != 0 and ac_y_coordinate != 0) + pAddresses, ac_address):INDEPENDENT;

		bair_importer.layouts.address_cache temp_mos (EVENT_PERSONS_input L, bair_importer.layouts.address_cache R, INTEGER C) := TRANSFORM
			//extend =>
			x_coordinate 	:= (real8)L.persons_x_coordinate;
			y_coordinate 	:= (real8)L.persons_y_coordinate;
			provided_by_agency := IF (x_coordinate != 0 and y_coordinate != 0, TRUE, FALSE);
			
			accuracy :=  if(L.persons_accuracy = '0','5', L.persons_accuracy);
			geocoded :=  if(R.ac_geocoded='','1',R.ac_geocoded);
			
			
			SELF.ac_dataProviderID									:=		(unsigned4)L.ori;
			SELF.ac_address 												:= 		ut.CleanSpacesAndUpper(L.persons_address);
			SELF.ac_x_coordinate 										:= 		IF (provided_by_agency,(real8)L.persons_x_coordinate, R.ac_x_coordinate);
			SELF.ac_y_coordinate 										:= 		IF (provided_by_agency,(real8)L.persons_y_coordinate, R.ac_y_coordinate);
			SELF.ac_geocoded 												:= 		IF (provided_by_agency, L.persons_geocoded, geocoded);
			SELF.ac_accuracy 												:= 		IF (provided_by_agency, accuracy ,R.ac_accuracy);
			SELF.ac_edit_date 											:= 		R.ac_edit_date;
			SELF.ac_clean_address_182 							:= 		R.ac_clean_address_182;
			SELF.ac_google_geocoded									:= 		R.ac_google_geocoded;
			SELF.ac_originated 											:= 		R.ac_originated;
			SELF																		:= 		L;
		END;
		
		addresses := join(EVENT_PERSONS_input, 
							 AddressCache, 
							left.ORI = right.ac_dataProviderID and ut.CleanSpacesAndUpper(left.persons_address) = ut.CleanSpacesAndUpper(right.ac_address), 
							temp_mos(LEFT,RIGHT,COUNTER),
							left outer,
							hash);

		addresses_NotFound  :=  addresses(ac_clean_address_182  = '' and ac_x_coordinate = 0 and ac_y_coordinate = 0);
		address_cleaned 		:= Bair_importer.Geocode.CleanIT_fun(pAgency, addresses_NotFound);
		new_addresses				:= address_cleaned(ac_originated = 'INTERNAL');
		RETURN new_addresses;
		
	ENDMACRO;
	
	EXPORT MAC_GeoVehicles( pBuildVersion, EVENT_VEHICLES_input,pAgency, pAddreses) := FUNCTIONMACRO  

		IMPORT bair,ut,STD,address;
		time := ut.getTime();
		date := (string8)std.date.today();
		v_edit_date := date[1..4] + '-' + date[5..6] + '-' + date[7..8] + ' ' + time[1..2] + ':' + time[3..4] + ':' + time[5..6] + '.000';

		AddressCache  := dedup(bair_importer.files().baseLNAddressCache.built(ac_x_coordinate != 0 and ac_y_coordinate != 0) + pAddreses, ac_address);

		bair_importer.layouts.address_cache temp_mos (EVENT_VEHICLES_input L, bair_importer.layouts.address_cache R, INTEGER C) := TRANSFORM
			//extend =>
			
			x_coordinate 	:= (real8)L.vehicle_x_coordinate;
			y_coordinate 	:= (real8)L.vehicle_y_coordinate;
			provided_by_agency := IF (x_coordinate != 0 and y_coordinate != 0, TRUE, FALSE);
			
			accuracy :=  if(L.vehicle_accuracy = '0','5', L.vehicle_accuracy);
			geocoded :=  if(R.ac_geocoded='','1',R.ac_geocoded);
			
			SELF.ac_dataProviderID									:=		(unsigned4)L.ori;
			SELF.ac_address 												:= 		ut.CleanSpacesAndUpper(L.vehicle_address);
			SELF.ac_x_coordinate 										:= 		IF (provided_by_agency,x_coordinate, R.ac_x_coordinate);
			SELF.ac_y_coordinate 										:= 		IF (provided_by_agency,y_coordinate, R.ac_y_coordinate);
			SELF.ac_geocoded 												:= 		IF (provided_by_agency, L.vehicle_geocoded, geocoded);
			SELF.ac_accuracy 												:= 		IF (provided_by_agency, accuracy ,R.ac_accuracy);
			SELF.ac_edit_date 											:= 		R.ac_edit_date;
			SELF.ac_clean_address_182 							:= 		R.ac_clean_address_182;
			SELF.ac_google_geocoded									:= 		R.ac_google_geocoded;
			SELF.ac_originated 											:= 		R.ac_originated;
			SELF																		:= 		L;
		END;
		
		addresses := join(EVENT_VEHICLES_input, 
							 AddressCache, 
							left.ORI = right.ac_dataProviderID and ut.CleanSpacesAndUpper(left.vehicle_address) = ut.CleanSpacesAndUpper(right.ac_address), 
							temp_mos(LEFT,RIGHT,COUNTER),
							left outer,
							hash);

		addresses_NotFound  := addresses(ac_clean_address_182  = '' and ac_x_coordinate = 0 and ac_y_coordinate = 0);
		address_cleaned 		:= Bair_importer.Geocode.CleanIT_fun(pAgency, addresses_NotFound);
		new_addresses				:= address_cleaned(ac_originated = 'INTERNAL');
		RETURN new_addresses;
		
	ENDMACRO;
	
	EXPORT MAC_GeoEvent(filename, EVENT_MO_input,EVENT_PERSONS_input,EVENT_VEHICLES_input ,pAgency) := FUNCTIONMACRO  
					geo_mos 					:= Bair_Importer.Geocode.MAC_GeoMos			( filename, EVENT_MO_input, pAgency ):INDEPENDENT;
					geo_persons 			:= Bair_Importer.Geocode.MAC_GeoPersons	( filename, EVENT_PERSONS_input,pAgency,	geo_mos  ):INDEPENDENT;
					geo_vehicles 			:= Bair_Importer.Geocode.MAC_GeoVehicles(	filename, EVENT_VEHICLES_input,pAgency,	geo_mos+geo_persons ):INDEPENDENT;
					geo_addresses 		:= DEDUP( geo_mos(ac_x_coordinate != 0 and ac_y_coordinate != 0) + geo_persons(ac_x_coordinate != 0 and ac_y_coordinate != 0) + geo_vehicles(ac_x_coordinate != 0 and ac_y_coordinate != 0) );
					return geo_addresses;
	ENDMACRO;
	
	EXPORT MAC_GeoCfsAddress(pBuildVersion, pCFSInput, pAgency) := FUNCTIONMACRO  

		IMPORT bair,ut,STD,address;
		time := ut.getTime();
		date := (string8)std.date.today();
		v_edit_date := date[1..4] + '-' + date[5..6] + '-' + date[7..8] + ' ' + time[1..2] + ':' + time[3..4] + ':' + time[5..6] + '.000';
		
		AddressCache  	:= dedup(bair_importer.files().baseLNAddressCache.built(ac_x_coordinate != 0 and ac_y_coordinate != 0), ac_address);

		bair_importer.layouts.address_cache temp_mos (pCFSInput L, bair_importer.layouts.address_cache R, INTEGER C) := TRANSFORM
			//extend =>
			
			x_coordinate 	:= (real8)L.x_coordinate;
			y_coordinate 	:= (real8)L.y_coordinate;
			provided_by_agency := IF (x_coordinate != 0 and y_coordinate != 0, TRUE, FALSE);
			
			accuracy :=  if(L.accuracy = '0','5', L.accuracy);
			geocoded :=  if(R.ac_geocoded='','1',R.ac_geocoded);
			
			SELF.ac_dataProviderID									:=		(unsigned4)L.ori;
			SELF.ac_address 												:= 		ut.CleanSpacesAndUpper(L.address);
			SELF.ac_x_coordinate 										:= 		IF (provided_by_agency,x_coordinate, R.ac_x_coordinate);
			SELF.ac_y_coordinate 										:= 		IF (provided_by_agency,y_coordinate, R.ac_y_coordinate);
			SELF.ac_geocoded 												:= 		IF (provided_by_agency, L.geocoded, geocoded);
			SELF.ac_accuracy 												:= 		IF (provided_by_agency, accuracy ,R.ac_accuracy);
			SELF.ac_edit_date 											:= 		R.ac_edit_date;
			SELF.ac_clean_address_182 							:= 		R.ac_clean_address_182;
			SELF.ac_google_geocoded									:= 		R.ac_google_geocoded;
			SELF.ac_originated 											:= 		R.ac_originated;
			SELF																		:= 		L;
		END;
		
		addresses := join(pCFSInput, 
							 AddressCache, 
							left.ORI = right.ac_dataProviderID and ut.CleanSpacesAndUpper(left.address) = ut.CleanSpacesAndUpper(right.ac_address), 
							temp_mos(LEFT,RIGHT,COUNTER),
							left outer,
							hash);

		addresses_NotFound  := addresses(ac_clean_address_182  = '' and ac_x_coordinate = 0 and ac_y_coordinate = 0);
		address_cleaned 		:= Bair_importer.Geocode.CleanIT_fun(pAgency, addresses_NotFound);
		internal_addresses	:= address_cleaned(ac_originated = 'INTERNAL');
		googleIt 						:= address_cleaned(ac_originated = 'GOOGLEIT');		
		google_addresses 		:= Bair_importer.Geocode.GoogleIT_fun (pAgency, googleIt);
										
		bair_importer.geocode.Geocoding_Log(pBuildVersion, google_addresses);
		new_addresses 			:= internal_addresses + google_addresses;
		RETURN new_addresses;
		
	ENDMACRO;
	
	EXPORT MAC_GeoCallerAddress(pCFSInput, pAgency, pAddresses ) := FUNCTIONMACRO  

		IMPORT bair,ut,STD,address;
		time := ut.getTime();
		date := (string8)std.date.today();
		v_edit_date := date[1..4] + '-' + date[5..6] + '-' + date[7..8] + ' ' + time[1..2] + ':' + time[3..4] + ':' + time[5..6] + '.000';

		AddressCache  	:= dedup(bair_importer.files().baseLNAddressCache.built(ac_x_coordinate != 0 and ac_y_coordinate != 0) + pAddresses, ac_address);

		bair_importer.layouts.address_cache temp_mos (pCFSInput L, bair_importer.layouts.address_cache R, INTEGER C) := TRANSFORM
		
			//extend =>
			SELF.ac_dataProviderID									:=		(unsigned4)L.ori;
			SELF.ac_address 												:= 		ut.CleanSpacesAndUpper(L.caller_address);
			SELF.ac_x_coordinate 										:= 		R.ac_x_coordinate;
			SELF.ac_y_coordinate 										:= 		R.ac_y_coordinate;
			SELF.ac_geocoded 												:= 		if(R.ac_geocoded='','1',R.ac_geocoded);
			SELF.ac_accuracy 												:= 		R.ac_accuracy;
			SELF.ac_edit_date 											:= 		R.ac_edit_date;
			SELF.ac_clean_address_182 							:= 		R.ac_clean_address_182;
			SELF.ac_google_geocoded									:= 		R.ac_google_geocoded;
			SELF.ac_originated 											:= 		R.ac_originated;
			SELF																		:= 		L;
		END;
		
		addresses := join(pCFSInput, 
							 AddressCache, 
							left.ORI = right.ac_dataProviderID and ut.CleanSpacesAndUpper(left.caller_address) = ut.CleanSpacesAndUpper(right.ac_address), 
							temp_mos(LEFT,RIGHT,COUNTER),
							left outer,
							hash);

		addresses_NotFound  := addresses(ac_clean_address_182  = '' and ac_x_coordinate = 0 and ac_y_coordinate = 0);
		address_cleaned 		:= Bair_importer.Geocode.CleanIT_fun(pAgency, addresses_NotFound);
		new_addresses				:= address_cleaned(ac_originated = 'INTERNAL');
		RETURN new_addresses;
		
	ENDMACRO;	
	
	EXPORT MAC_GeoComplainantAddress(pCFSInput, pAgency, pAddresses ) := FUNCTIONMACRO  

		IMPORT bair,ut,STD,address;
		time := ut.getTime();
		date := (string8)std.date.today();
		v_edit_date := date[1..4] + '-' + date[5..6] + '-' + date[7..8] + ' ' + time[1..2] + ':' + time[3..4] + ':' + time[5..6] + '.000';

		AddressCache  	:= bair_importer.files().baseLNAddressCache.built(ac_x_coordinate != 0 and ac_y_coordinate != 0) + pAddresses;

		bair_importer.layouts.address_cache temp_mos (pCFSInput L, bair_importer.layouts.address_cache R, INTEGER C) := TRANSFORM
			//extend =>
			
			x_coordinate 	:= (real8)L.complainant_x_coordinate;
			y_coordinate 	:= (real8)L.complainant_y_coordinate;
			provided_by_agency := IF (x_coordinate != 0 and y_coordinate != 0, TRUE, FALSE);
			
			accuracy :=  if(L.accuracy = '0','5', L.accuracy);
			geocoded :=  if(R.ac_geocoded='','1',R.ac_geocoded);
			
			SELF.ac_dataProviderID									:=		(unsigned4)L.ori;
			SELF.ac_address 												:= 		ut.CleanSpacesAndUpper(L.complainant_address);
			SELF.ac_x_coordinate 										:= 		IF (provided_by_agency,(real8)L.x_coordinate, R.ac_x_coordinate);
			SELF.ac_y_coordinate 										:= 		IF (provided_by_agency,(real8)L.y_coordinate, R.ac_y_coordinate);
			SELF.ac_geocoded 												:= 		IF (provided_by_agency, L.complainant_geocoded, geocoded);
			SELF.ac_accuracy 												:= 		IF (provided_by_agency, accuracy ,R.ac_accuracy);
			SELF.ac_edit_date 											:= 		R.ac_edit_date;
			SELF.ac_clean_address_182 							:= 		R.ac_clean_address_182;
			SELF.ac_google_geocoded									:= 		R.ac_google_geocoded;
			SELF.ac_originated 											:= 		R.ac_originated;
			SELF																		:= 		L;
		END;
		
		addresses := join(pCFSInput, 
							 AddressCache, 
							left.ORI = right.ac_dataProviderID and ut.CleanSpacesAndUpper(left.complainant_address) = ut.CleanSpacesAndUpper(right.ac_address), 
							temp_mos(LEFT,RIGHT,COUNTER),
							left outer,
							hash);

		addresses_NotFound  := addresses(ac_clean_address_182  = '' and ac_x_coordinate = 0 and ac_y_coordinate = 0);
		address_cleaned 		:= Bair_importer.Geocode.CleanIT_fun(pAgency, addresses_NotFound);
		new_addresses				:= address_cleaned(ac_originated = 'INTERNAL');
		RETURN new_addresses;
		
	ENDMACRO;	
	
	EXPORT MAC_GeoCFS(filename, CFS_add_input, pAgency) := FUNCTIONMACRO  
					geo_address 						:= bair_importer.Geocode.MAC_GeoCfsAddress(filename, CFS_add_input,pAgency):INDEPENDENT;
					geo_caller_address  		:= bair_importer.Geocode.MAC_GeoCallerAddress(CFS_add_input,pAgency,geo_address):INDEPENDENT;
					geo_complainant_address	:= bair_importer.Geocode.MAC_GeoComplainantAddress(CFS_add_input,pAgency, geo_address + geo_caller_address):INDEPENDENT;
					geo_addresses 					:= DEDUP(geo_address(ac_x_coordinate != 0 and ac_y_coordinate != 0) + geo_caller_address(ac_x_coordinate != 0 and ac_y_coordinate != 0) + geo_complainant_address(ac_x_coordinate != 0 and ac_y_coordinate != 0));
					return geo_addresses;
	ENDMACRO;
	
	EXPORT MAC_GeoCrash(pBuildVersion, pVersion, pAgency) := FUNCTIONMACRO  

		IMPORT bair,ut,STD,address;
		time := ut.getTime();
		date := (string8)std.date.today();
		v_edit_date := date[1..4] + '-' + date[5..6] + '-' + date[7..8] + ' ' + time[1..2] + ':' + time[3..4] + ':' + time[5..6] + '.000';

		InputCrash := bair_importer.files().crash_add;
		AddressCache  	:= bair_importer.files().baseLNAddressCache.built(ac_x_coordinate != 0 and ac_y_coordinate != 0);

		bair_importer.layouts.address_cache temp_mos (bair_importer.layouts.SprayedCrash L, bair_importer.layouts.address_cache R, INTEGER C) := TRANSFORM
			//extend =>
			SELF.ac_dataProviderID									:=		(unsigned4)L.dataProviderId;
			SELF.ac_address 												:= 		ut.CleanSpacesAndUpper(L.address);
			SELF.ac_x_coordinate 										:= 		IF ((real8)L.x_coordinate != 0,(real8)L.x_coordinate, R.ac_x_coordinate);
			SELF.ac_y_coordinate 										:= 		IF ((real8)L.y_coordinate != 0,(real8)L.y_coordinate, R.ac_y_coordinate);
			SELF.ac_geocoded 												:= 		IF ((real8)L.x_coordinate != 0 and (real8)L.y_coordinate != 0, '0', if(R.ac_geocoded='','1',R.ac_geocoded));
			SELF.ac_accuracy 												:= 		IF ((real8)L.x_coordinate != 0 and (real8)L.y_coordinate != 0, '8' ,R.ac_accuracy);
			SELF.ac_edit_date 											:= 		R.ac_edit_date;
			SELF.ac_clean_address_182 							:= 		R.ac_clean_address_182;
			SELF.ac_google_geocoded									:= 		R.ac_google_geocoded;
			SELF.ac_originated 											:= 		R.ac_originated;
			SELF																		:= 		L;
		END;
		
		addresses := join(InputCrash, 
							 AddressCache, 
							left.dataProviderId = right.ac_dataProviderID and ut.CleanSpacesAndUpper(left.address) = ut.CleanSpacesAndUpper(right.ac_address), 
							temp_mos(LEFT,RIGHT,COUNTER),
							left outer,
							hash);

		addresses_NotFound  := addresses(ac_clean_address_182  = '' and ac_x_coordinate = 0 and ac_y_coordinate = 0);
		address_cleaned 		:= Bair_importer.Geocode.CleanIT_fun(pAgency, addresses_NotFound);
		internal_addresses	:= address_cleaned(ac_originated = 'INTERNAL');
		googleIt 						:= address_cleaned(ac_originated = 'GOOGLEIT');		
		google_addresses 		:= Bair_importer.Geocode.GoogleIT_fun (pAgency, googleIt);
		bair_importer.geocode.Geocoding_Log(pBuildVersion, google_addresses);
		new_addresses 			:= internal_addresses + google_addresses;
		RETURN new_addresses;
		
	ENDMACRO;
	
	EXPORT MAC_GeoOffender(pBuildVersion, pVersion, pAgency) := FUNCTIONMACRO  

		IMPORT bair,ut,STD,address;
		time := ut.getTime();
		date := (string8)std.date.today();
		v_edit_date := date[1..4] + '-' + date[5..6] + '-' + date[7..8] + ' ' + time[1..2] + ':' + time[3..4] + ':' + time[5..6] + '.000';

		InputOffenders	:= bair_importer.files().offender_add;
		AddressCache  	:= bair_importer.files().baseLNAddressCache.built(ac_x_coordinate != 0 and ac_y_coordinate != 0);

		bair_importer.layouts.address_cache temp_mos (bair_importer.layouts.SprayedOffenders L, bair_importer.layouts.address_cache R, INTEGER C) := TRANSFORM
			//extend =>
			
			x_coordinate 	:= (real8)L.x_coordinate;
			y_coordinate 	:= (real8)L.y_coordinate;
			provided_by_agency := IF (x_coordinate != 0 and y_coordinate != 0, TRUE, FALSE);
			geocoded :=  if(R.ac_geocoded='','1',R.ac_geocoded);
			
			SELF.ac_dataProviderID									:=		(unsigned4)L.data_provider_id;
			SELF.ac_address 												:= 		ut.CleanSpacesAndUpper(L.address);
			SELF.ac_x_coordinate 										:= 		IF (provided_by_agency,x_coordinate, R.ac_x_coordinate);
			SELF.ac_y_coordinate 										:= 		IF (provided_by_agency,y_coordinate, R.ac_y_coordinate);
			SELF.ac_geocoded 												:= 		IF (provided_by_agency, '0', geocoded);
			SELF.ac_accuracy 												:= 		IF (provided_by_agency, '8' ,R.ac_accuracy);
			SELF.ac_edit_date 											:= 		R.ac_edit_date;
			SELF.ac_clean_address_182 							:= 		R.ac_clean_address_182;
			SELF.ac_google_geocoded									:= 		R.ac_google_geocoded;
			SELF.ac_originated 											:= 		R.ac_originated;
			SELF																		:= 		L;
		END;
		
		addresses := join(InputOffenders, 
							 AddressCache, 
							left.data_provider_id = right.ac_dataProviderID and ut.CleanSpacesAndUpper(left.address) = ut.CleanSpacesAndUpper(right.ac_address), 
							temp_mos(LEFT,RIGHT,COUNTER),
							left outer,
							hash);
		addresses_NotFound  := addresses(ac_clean_address_182  = '' and ac_x_coordinate = 0 and ac_y_coordinate = 0);
		address_cleaned 		:= Bair_importer.Geocode.CleanIT_fun(pAgency, addresses_NotFound);
		internal_addresses	:= address_cleaned(ac_originated = 'INTERNAL');
		googleIt 						:= address_cleaned(ac_originated = 'GOOGLEIT');	
		google_addresses 		:= Bair_importer.Geocode.GoogleIT_fun (pAgency, googleIt);
		bair_importer.geocode.Geocoding_Log(pBuildVersion, google_addresses);
		new_addresses 			:= internal_addresses + google_addresses;
		RETURN new_addresses;
		
	ENDMACRO;
END;			