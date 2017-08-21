EXPORT Geocode := module		
		
		EXPORT Google_Geocode_OFFLINE(string pStandardAddress)  := FUNCTION
				google_geocoded:= '<GeocodeResponse><status>OK</status><result><type>street_address</type><formatted_address></formatted_address><geometry><location><lat>0</lat><lng>0</lng></location></geometry><place_id></place_id></result></GeocodeResponse>';
				RETURN google_geocoded;
		END; 		
		
		EXPORT Google_Geocode(string pStandardAddress) 			:= FUNCTION
			IMPORT STD;
			STD.System.Debug.Sleep(_Constants.sleep_time);    //pause for one second before continuing
				
			queryURL := 'http://'+ESP_Config.User+':'+ESP_Config.Password+'@'+ESP_Config.Host+':'+ESP_Config.Port+'/'+ESP_Config.WebService+'?ver_='+ESP_Config.Version;
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
				STRING ClientID	{	XPATH('ClientID' )}	:= ESP_Config.ClientID;
				STRING Key			{	XPATH('Key' )}			:= ESP_Config.Key;
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
		
		
	EXPORT Geocoding_Log(pVersion, pAddresses, pFilename) := FUNCTIONMACRO
			import PromoteSupers;
			datetime_stamp_v := (unsigned8)((string8)std.date.today() + Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S'))-bair_batchimporter._Constants.us_eastern_time;
			count_v := COUNT(pAddresses(ac_originated = 'GOOGLE'));
			geocoding_log := dataset([{datetime_stamp_v,pVersion,count_v}],bair_batchimporter.layouts.geocoding_log);

			RETURN bair_batchimporter.BuildNewLogicalFile(pFilename, geocoding_log, false);	
	ENDMACRO;
	
	EXPORT GoogleIt_fun (pAddresses) := 	FUNCTIONMACRO
		IMPORT _Control;
		xcount := sum(dataset(_Dataset().thor_cluster_files +_Constants.geocodingLog_built,layouts.geocoding_log,thor,opt),counts); 

		GeocodeOffline := IF( _Constants.Geo_Test_Mode = TRUE 
													OR xcount >= _Constants.max_geocoding_calls
													OR _Control.ThisEnvironment.ThisDaliIp not in [ _Control.IPAddress.bair_DR_dali1, _Control.IPAddress.bair_prod_dali1],
														TRUE, FALSE
													);
	
		bair_batchimporter.layouts.address_cache temp_googleit (bair_batchimporter.layouts.address_cache L) := TRANSFORM
		
				google_geocoded		:= IF (GeocodeOffline															
																,bair_batchimporter.Geocode.Google_Geocode_OFFLINE(L.ac_address)
																,bair_batchimporter.Geocode.Google_Geocode(L.ac_address));
				
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
			SELF.ac_originated 											:= 		IF (GeocodeOffline,'OFFLINE', 'GOOGLE');
			SELF.ac_clean_address_182								:=    L.ac_clean_address_182[1..145] + y_coordinate[1..10] + x_coordinate[1..10] + l.ac_clean_address_182[166..182];
			SELF																		:= 		L;
		END;		
		
		google_addresses := project(pAddresses, temp_googleit(left));	

		RETURN google_addresses;
	ENDMACRO;
	
	
	EXPORT CleanIt_fun (pAddresses) := 	FUNCTIONMACRO
		import Std;
		
		CleanItTbl := table(pAddresses,{ac_dataProviderID, ac_address});
		CleanItSrt := sort(CleanItTbl, ac_dataProviderID, ac_address);
		CleanItSet := dedup(CleanItSrt, ac_dataProviderID, ac_address);
		DataProviderLoc := Bair.files().DataProviderLoc_Base.built();

		Bair_BatchImporter.layouts.address_cache temp_cleanit (CleanItSet L, DataProviderLoc R ) := TRANSFORM
			
			
			address1 := ut.CleanSpacesAndUpper(L.ac_address);
			address2 := ut.CleanSpacesAndUpper(R.city + ', ' + R.state);
					
			Clean_Address_182 		:= 		if(address1 != '' AND address2 != '',address.CleanAddress182(address1, address2),'');
			SELF.ac_address				:=  	ut.CleanSpacesAndUpper(L.ac_address);
			SELF.ac_dataProviderID:=	  L.ac_dataProviderID;
			SELF.ac_x_coordinate 	:= 	  if(Clean_Address_182[179] != 'E',(real8)Clean_Address_182[156..165],0);
			SELF.ac_y_coordinate 	:= 		if(Clean_Address_182[179] != 'E',(real8)Clean_Address_182[146..155],0);
			SELF.ac_accuracy 			:= 		'8';
			SELF.ac_originated 		:= 		if(Clean_Address_182[179] != 'E','INTERNAL','GOOGLEIT');
			SELF.ac_clean_address_182 := Clean_Address_182;
			SELF.ac_google_geocoded := '';
			SELF.ac_edit_date			:= 		v_edit_date;
			SELF.ac_geocoded			:= 		'1';
			SELF									:= 		L;
		END;
		
		address_cleaned := JOIN(CleanItSet, 
														DataProviderLoc,
														LEFT.ac_dataProviderID = RIGHT.dataProviderID, 
														temp_cleanit(LEFT,RIGHT),
																					INNER,
																					LOOKUP);	
		return address_cleaned;
	ENDMACRO;
	
	EXPORT MAC_GeoMos(pVersion,EVENT_MO_input) := FUNCTIONMACRO  

		IMPORT bair,ut,STD,address;

		time := Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S');
		date := (string8)std.date.today();
		v_edit_date := date[1..4] + '-' + date[5..6] + '-' + date[7..8] + ' ' + time[1..2] + ':' + time[3..4] + ':' + time[5..6] + '.000';

		AddressCache 	:= files().baseLNAddressCache.built;

		layouts.address_cache temp_mos (EVENT_MO_input L, layouts.address_cache R, INTEGER C) := TRANSFORM
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
			SELF.ac_originated 											:= 		IF (provided_by_agency,'AGENCY',R.ac_originated);
			SELF																		:= 		L;
		END;
		
		addresses := join(distribute(EVENT_MO_input,hash(ori)), 
											distribute(AddressCache,hash(ac_dataproviderid)), 
											left.ORI = right.ac_dataProviderID and ut.CleanSpacesAndUpper(left.address_of_Crime) = ut.CleanSpacesAndUpper(right.ac_address), 
											temp_mos(LEFT,RIGHT,COUNTER),
											left outer,
											local);

		addresses_NotFound  := dedup(addresses(ac_originated='' or (ac_originated='GOOGLE' and regexfind('<error_message>', ac_google_geocoded))),ac_dataproviderid,ac_address, all);
		address_cleaned 		:= Geocode.CleanIT_fun(addresses_NotFound);
		internal_addresses	:= address_cleaned(ac_originated = 'INTERNAL');
		googleIt 						:= address_cleaned(ac_originated = 'GOOGLEIT');		
		google_addresses 		:= Geocode.GoogleIT_fun (googleIt);
		
		Geocode.Geocoding_Log(pVersion, google_addresses, filenames(pVersion).baseEventGeocodingLog.new);
		
		new_addresses 			:= internal_addresses + google_addresses;
		RETURN new_addresses;
		
	ENDMACRO;

	EXPORT MAC_GeoPersons(pVersion, EVENT_PERSONS_input, pAddresses ) := FUNCTIONMACRO  

		IMPORT bair,ut,STD,address;
		time := Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S');
		date := (string8)std.date.today();
		v_edit_date := date[1..4] + '-' + date[5..6] + '-' + date[7..8] + ' ' + time[1..2] + ':' + time[3..4] + ':' + time[5..6] + '.000';

		AddressCache  := files().baseLNAddressCache.built + pAddresses;

		layouts.address_cache temp_mos (EVENT_PERSONS_input L, layouts.address_cache R, INTEGER C) := TRANSFORM
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
			SELF.ac_originated 											:= 		IF (provided_by_agency,'AGENCY',R.ac_originated);
			SELF																		:= 		L;
		END;

		addresses := join(distribute(EVENT_PERSONS_input,hash(ori)), 
											distribute(AddressCache,hash(ac_dataproviderid)),
											left.ORI = right.ac_dataProviderID and ut.CleanSpacesAndUpper(left.persons_address) = ut.CleanSpacesAndUpper(right.ac_address), 
											temp_mos(LEFT,RIGHT,COUNTER),
											left outer,
											local);

		addresses_NotFound  :=  dedup(addresses(ac_originated='' or (ac_originated='GOOGLE' and regexfind('<error_message>', ac_google_geocoded))),ac_dataproviderid,ac_address, all);
		address_cleaned 		:= Geocode.CleanIT_fun(addresses_NotFound);
		new_addresses				:= address_cleaned(ac_originated = 'INTERNAL');
		RETURN new_addresses;
		
	ENDMACRO;
	
	EXPORT MAC_GeoVehicles( pVersion, EVENT_VEHICLES_input,pAddreses) := FUNCTIONMACRO  

		IMPORT bair,ut,STD,address;
		time := Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S');
		date := (string8)std.date.today();
		v_edit_date := date[1..4] + '-' + date[5..6] + '-' + date[7..8] + ' ' + time[1..2] + ':' + time[3..4] + ':' + time[5..6] + '.000';

		AddressCache  := files().baseLNAddressCache.built + pAddreses;

		layouts.address_cache temp_mos (EVENT_VEHICLES_input L, layouts.address_cache R, INTEGER C) := TRANSFORM
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
			SELF.ac_originated 											:= 		IF (provided_by_agency,'AGENCY',R.ac_originated);
			SELF																		:= 		L;
		END;

		addresses := join(distribute(EVENT_VEHICLES_input,hash(ori)), 
											distribute(AddressCache,hash(ac_dataproviderid)),
											left.ORI = right.ac_dataProviderID and ut.CleanSpacesAndUpper(left.vehicle_address) = ut.CleanSpacesAndUpper(right.ac_address), 
											temp_mos(LEFT,RIGHT,COUNTER),
											left outer,
											local);

		addresses_NotFound  := dedup(addresses(ac_originated='' or (ac_originated='GOOGLE' and regexfind('<error_message>', ac_google_geocoded))),ac_dataproviderid,ac_address, all);
		address_cleaned 		:= Geocode.CleanIT_fun(addresses_NotFound);
		new_addresses				:= address_cleaned(ac_originated = 'INTERNAL');
		RETURN new_addresses;
		
	ENDMACRO;
	
	EXPORT MAC_GeoEvent(filename, EVENT_MO_input,EVENT_PERSONS_input,EVENT_VEHICLES_input) := FUNCTIONMACRO  
	
					geo_mos 					:= DEDUP(Geocode.MAC_GeoMos( filename, EVENT_MO_input) ,ac_dataProviderID, ac_address, all);
					geo_persons 			:= DEDUP(Geocode.MAC_GeoPersons	( filename, EVENT_PERSONS_input ,geo_mos), ac_dataProviderID, ac_address,all);
					geo_vehicles 			:= DEDUP(Geocode.MAC_GeoVehicles(	filename, EVENT_VEHICLES_input,	geo_mos+geo_persons ),ac_dataProviderID, ac_address,all);
					geo_addresses 		:= geo_mos + geo_persons + geo_vehicles;
					return geo_addresses;
	ENDMACRO;
	
	EXPORT MAC_GeoCfsAddress(pVersion, pCFSInput) := FUNCTIONMACRO  

		IMPORT bair,ut,STD,address;
		time := Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S');
		date := (string8)std.date.today();
		v_edit_date := date[1..4] + '-' + date[5..6] + '-' + date[7..8] + ' ' + time[1..2] + ':' + time[3..4] + ':' + time[5..6] + '.000';
		
		AddressCache  	:= bair_batchimporter.files().baseLNAddressCache.built;

		bair_batchimporter.layouts.address_cache temp_mos (pCFSInput L, bair_batchimporter.layouts.address_cache R, INTEGER C) := TRANSFORM
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
			SELF.ac_originated 											:= 		IF (provided_by_agency,'AGENCY',R.ac_originated);
			SELF																		:= 		L;
		END;
		
		
		addresses := join(distribute(pCFSInput,hash(ori)), 
											distribute(AddressCache,hash(ac_dataproviderid)),
											left.ORI = right.ac_dataProviderID and ut.CleanSpacesAndUpper(left.address) = ut.CleanSpacesAndUpper(right.ac_address), 
											temp_mos(LEFT,RIGHT,COUNTER),
											left outer,
											local);

		addresses_NotFound  := dedup(addresses(ac_originated='' or (ac_originated='GOOGLE' and regexfind('<error_message>', ac_google_geocoded))),ac_dataproviderid,ac_address, all);
		address_cleaned 		:= bair_batchimporter.Geocode.CleanIT_fun(addresses_NotFound);
		internal_addresses	:= address_cleaned(ac_originated = 'INTERNAL');
		googleIt 						:= address_cleaned(ac_originated = 'GOOGLEIT');		
		google_addresses 		:= bair_batchimporter.Geocode.GoogleIT_fun ( googleIt);
										
		bair_batchimporter.Geocode.Geocoding_Log(pVersion, google_addresses, bair_batchimporter.filenames(pVersion).baseCFSGeocodingLog.new);
		
		new_addresses 			:= internal_addresses + google_addresses;
		RETURN new_addresses;
		
	ENDMACRO;
	
	EXPORT MAC_GeoCallerAddress(pCFSInput, pAddresses ) := FUNCTIONMACRO  

		IMPORT bair,ut,STD,address;
		time := Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S');
		date := (string8)std.date.today();
		v_edit_date := date[1..4] + '-' + date[5..6] + '-' + date[7..8] + ' ' + time[1..2] + ':' + time[3..4] + ':' + time[5..6] + '.000';

		AddressCache  	:= bair_batchimporter.files().baseLNAddressCache.built + pAddresses;

		bair_batchimporter.layouts.address_cache temp_mos (pCFSInput L, bair_batchimporter.layouts.address_cache R, INTEGER C) := TRANSFORM
		
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

		addresses := join(distribute(pCFSInput,hash(ori)), 
											distribute(AddressCache,hash(ac_dataproviderid)),
											left.ORI = right.ac_dataProviderID and ut.CleanSpacesAndUpper(left.caller_address) = ut.CleanSpacesAndUpper(right.ac_address), 
											temp_mos(LEFT,RIGHT,COUNTER),
											left outer,
											local);

		addresses_NotFound  := dedup(addresses(ac_originated='' or (ac_originated='GOOGLE' and regexfind('<error_message>', ac_google_geocoded))),ac_dataproviderid,ac_address, all);
		address_cleaned 		:= bair_batchimporter.Geocode.CleanIT_fun( addresses_NotFound);
		new_addresses				:= address_cleaned(ac_originated = 'INTERNAL');
		RETURN new_addresses;
		
	ENDMACRO;	
	
	EXPORT MAC_GeoComplainantAddress(pCFSInput, pAddresses ) := FUNCTIONMACRO  

		IMPORT bair,ut,STD,address;
		time := Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S');
		date := (string8)std.date.today();
		v_edit_date := date[1..4] + '-' + date[5..6] + '-' + date[7..8] + ' ' + time[1..2] + ':' + time[3..4] + ':' + time[5..6] + '.000';

		AddressCache  	:= bair_batchimporter.files().baseLNAddressCache.built + pAddresses;

		bair_batchimporter.layouts.address_cache temp_mos (pCFSInput L, bair_batchimporter.layouts.address_cache R, INTEGER C) := TRANSFORM
			//extend =>
			
			x_coordinate 	:= (real8)L.complainant_x_coordinate;
			y_coordinate 	:= (real8)L.complainant_y_coordinate;
			provided_by_agency := IF (x_coordinate != 0 and y_coordinate != 0, TRUE, FALSE);
			
			accuracy :=  if(L.accuracy = '0','5', L.accuracy);
			geocoded :=  if(R.ac_geocoded='','1',R.ac_geocoded);
			
			SELF.ac_dataProviderID									:=		(unsigned4)L.ori;
			SELF.ac_address 												:= 		ut.CleanSpacesAndUpper(L.complainant_address);
			SELF.ac_x_coordinate 										:= 		IF (provided_by_agency,x_coordinate, R.ac_x_coordinate);
			SELF.ac_y_coordinate 										:= 		IF (provided_by_agency,y_coordinate, R.ac_y_coordinate);
			SELF.ac_geocoded 												:= 		IF (provided_by_agency, L.complainant_geocoded, geocoded);
			SELF.ac_accuracy 												:= 		IF (provided_by_agency, accuracy ,R.ac_accuracy);
			SELF.ac_edit_date 											:= 		R.ac_edit_date;
			SELF.ac_clean_address_182 							:= 		R.ac_clean_address_182;
			SELF.ac_google_geocoded									:= 		R.ac_google_geocoded;
			SELF.ac_originated 											:= 		IF (provided_by_agency,'AGENCY',R.ac_originated);
			SELF																		:= 		L;
		END;
		
		addresses := join(distribute(pCFSInput,hash(ori)), 
											distribute(AddressCache,hash(ac_dataproviderid)),
											left.ORI = right.ac_dataProviderID and ut.CleanSpacesAndUpper(left.complainant_address) = ut.CleanSpacesAndUpper(right.ac_address), 
											temp_mos(LEFT,RIGHT,COUNTER),
											left outer,
											local);

		addresses_NotFound  := dedup(addresses(ac_originated='' or (ac_originated='GOOGLE' and regexfind('<error_message>', ac_google_geocoded))),ac_dataproviderid,ac_address, all);
		address_cleaned 		:= bair_batchimporter.Geocode.CleanIT_fun( addresses_NotFound);
		new_addresses				:= address_cleaned(ac_originated = 'INTERNAL');
		RETURN new_addresses;
		
	ENDMACRO;	
	
	EXPORT MAC_GeoCFS(filename, CFS_add_input) := FUNCTIONMACRO  
					geo_address 						:= DEDUP(	bair_batchimporter.Geocode.MAC_GeoCfsAddress(filename, CFS_add_input),ac_dataProviderID, ac_address, all);
					geo_caller_address  		:= DEDUP(	bair_batchimporter.Geocode.MAC_GeoCallerAddress(CFS_add_input,geo_address),ac_dataProviderID, ac_address, all);
					geo_complainant_address	:= DEDUP(	bair_batchimporter.Geocode.MAC_GeoComplainantAddress(CFS_add_input, geo_address + geo_caller_address),ac_dataProviderID, ac_address, all);
					geo_addresses 					:= geo_address + geo_caller_address + geo_complainant_address;
					return geo_addresses;
	ENDMACRO;
	
	EXPORT MAC_GeoCrash(pVersion,CRASH_add_input) := FUNCTIONMACRO  

		IMPORT bair,ut,STD,address;
		time := Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S');
		date := (string8)std.date.today();
		v_edit_date := date[1..4] + '-' + date[5..6] + '-' + date[7..8] + ' ' + time[1..2] + ':' + time[3..4] + ':' + time[5..6] + '.000';

		AddressCache  	:= files().baseLNAddressCache.built;

		layouts.address_cache temp_mos (CRASH_add_input L, layouts.address_cache R, INTEGER C) := TRANSFORM
			x_coordinate 	:= (real8)L.x_coordinate;
			y_coordinate 	:= (real8)L.y_coordinate;
			provided_by_agency := IF (x_coordinate != 0 and y_coordinate != 0, TRUE, FALSE);		
			//extend =>
			SELF.ac_dataProviderID									:=		(unsigned4)L.dataProviderId;
			SELF.ac_address 												:= 		ut.CleanSpacesAndUpper(L.address);
			SELF.ac_x_coordinate 										:= 		IF (provided_by_agency,x_coordinate, R.ac_x_coordinate);
			SELF.ac_y_coordinate 										:= 		IF (provided_by_agency,y_coordinate, R.ac_y_coordinate);
			SELF.ac_geocoded 												:= 		IF (provided_by_agency, '0', if(R.ac_geocoded='','1',R.ac_geocoded));
			SELF.ac_accuracy 												:= 		IF (provided_by_agency, '8' ,R.ac_accuracy);
			SELF.ac_edit_date 											:= 		R.ac_edit_date;
			SELF.ac_clean_address_182 							:= 		R.ac_clean_address_182;
			SELF.ac_google_geocoded									:= 		R.ac_google_geocoded;
			SELF.ac_originated 											:= 		IF (provided_by_agency,'AGENCY',R.ac_originated);
			SELF																		:= 		L;
		END;
		

		addresses := join(distribute(CRASH_add_input,hash(dataProviderId)), 
											distribute(AddressCache,hash(ac_dataproviderid)),
											left.dataProviderId = right.ac_dataProviderID and ut.CleanSpacesAndUpper(left.address) = ut.CleanSpacesAndUpper(right.ac_address), 
											temp_mos(LEFT,RIGHT,COUNTER),
											left outer,
											local);

		addresses_NotFound  := dedup(addresses(ac_originated='' or (ac_originated='GOOGLE' and regexfind('<error_message>', ac_google_geocoded))),ac_dataproviderid,ac_address, all);
		address_cleaned 		:= Geocode.CleanIT_fun(addresses_NotFound);
		internal_addresses	:= address_cleaned(ac_originated = 'INTERNAL');
		googleIt 						:= address_cleaned(ac_originated = 'GOOGLEIT');		
		google_addresses 		:= Geocode.GoogleIT_fun (googleIt);
		
		Geocode.Geocoding_Log(pVersion, google_addresses,filenames(pVersion).baseCrashGeocodingLog.new);
		
		new_addresses 			:= internal_addresses + google_addresses;
		RETURN new_addresses;
		
	ENDMACRO;
	
	EXPORT MAC_GeoOffender(pVersion,OFFENDER_add_input) := FUNCTIONMACRO  

		IMPORT bair,ut,STD,address;
		time := Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S');
		date := (string8)std.date.today();
		v_edit_date := date[1..4] + '-' + date[5..6] + '-' + date[7..8] + ' ' + time[1..2] + ':' + time[3..4] + ':' + time[5..6] + '.000';

		AddressCache  	:= files().baseLNAddressCache.built;

		layouts.address_cache temp_mos (OFFENDER_add_input L, layouts.address_cache R, INTEGER C) := TRANSFORM
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
			SELF.ac_originated 											:= 		IF (provided_by_agency,'AGENCY',R.ac_originated);
			SELF																		:= 		L;
		END;
		
		addresses := join(distribute(OFFENDER_add_input,hash(data_provider_id)), 
											distribute(AddressCache,hash(ac_dataproviderid)),
											left.data_provider_id = right.ac_dataProviderID and ut.CleanSpacesAndUpper(left.address) = ut.CleanSpacesAndUpper(right.ac_address), 
											temp_mos(LEFT,RIGHT,COUNTER),
											left outer,
											local);
		addresses_NotFound  := dedup(addresses(ac_originated='' or (ac_originated='GOOGLE' and regexfind('<error_message>', ac_google_geocoded))),ac_dataproviderid,ac_address, all);
		address_cleaned 		:= Geocode.CleanIT_fun(addresses_NotFound);
		internal_addresses	:= address_cleaned(ac_originated = 'INTERNAL');
		googleIt 						:= address_cleaned(ac_originated = 'GOOGLEIT');	
		google_addresses 		:= Geocode.GoogleIT_fun (googleIt);
		
		Geocode.Geocoding_Log(pVersion, google_addresses,filenames(pVersion).baseOffendersGeocodingLog.new);
		
		new_addresses 			:= internal_addresses + google_addresses;
		RETURN new_addresses;
		
	ENDMACRO;
END;			