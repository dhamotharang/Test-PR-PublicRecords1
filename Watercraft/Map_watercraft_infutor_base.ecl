Import watercraft, watercraft_infutor, ut;

#OPTION('multiplePersistInstances',FALSE);

watercraft_class_desc(string1 code)
 := case(code,
					'1' => 'BOATS LESS THAN 16 FEET IN LENGTH',
					'2' => 'BOATS 16 - 25 FEET IN LENGTH',
					'3' => 'BOATS 26 - 39 FEET IN LENGTH',
					'4' => 'BOATS 40 - 64 FEET IN LENGTH',
					'5' => 'BOATS 65 FEET AND ABOVE',
					'' );
					
watercraft_type_desc(string1 code)
	:= case(code,
						'1' => 'OPEN BOAT',
						'2' => 'CABIN CRUISER',
						'3' => 'CRUISING HOUSEBOAT',
						'5' => 'PERSONAL WATERCRAFT',
						'6' => 'SAILBOAT',
						'7' => 'CANOE/KAYAK',
						'8' => 'PONTOON',
						'' );
						
watercraft_use_desc(string1 code)
	:= case(code,
						'1' => 'PLEASURE',
						'2' => 'LIVERY',
						'3' => 'DEALER',
						'4' => 'MANUFACTURER',
						'5' => 'COMMERCIAL FISHING',
						'6' => 'COMMERCIAL PASSENGER',
						'7' => 'TUG',
						'8' => 'OTHER',
						'9' => 'OFFICIAL',
						'');
						
watercraft_hull_material(string1 code)
	:= case(code,
						'1' => 'ALUMINUM',
						'2' => 'STEEL',
						'3' => 'WOOD',
						'4' => 'FIBERGLASS/PLASTIC',
						'5' => 'CONCRETE',
						'6' => 'INFLATABLE',
						'7' => 'GLASS',
						'');
						
watercraft_hull_shape(string1 code)
	:= case(code,
						'1' => 'MONOHULL',
						'2' => 'CATAMARAN',
						'3' => 'TRIMARAN',
						'4' => 'TWIN HULL',
						'');
						
watercraft_propulsion_desc(string1 code)
	:= case(code,
						'1' => 'OUTBOARD',
						'2' => 'INBOARD',
						'3' => 'INBOARD/OUTBOARD',
						'4' => 'SAIL',
						'5' => 'STEAM',
						'6' => 'OTHER',
						'7' => 'JET BOAT',
						'');
lengthFttoInch(STRING10 lenft) := FUNCTION
		lengthRecord := RECORD
			DECIMAL5_2 MyLenft;
			DECIMAL5_2 MyLenin;
			STRING10 FinalLenin := '0';
		END;
			MyLenft := (DECIMAL5_2) lenft;
			MyLenin := MyLenft * 12;
	FinalLenin := (STRING10)MyLenin;
	RETURN FinalLenin;
END;

//Filter out blank name records since there are no registration/hull information to identify watercraft info
ds_watercraft_in := dataset('~thor_data400::base::infutor_watercraft_raw',Watercraft_infutor.layouts.layout_CleanFields,flat);

watercraft_infutor.layouts.Watercraft_Main_Base main_mapping_format(ds_watercraft_in L) := TRANSFORM
	tempName								:= REGEXREPLACE('[^a-zA-Z0-9]',trim(L.fname,all)+trim(L.mname,all)+trim(L.lname,left,right)+trim(L.suffix,all),'');
	self.watercraft_key			:= IF(trim(L.pid,all)='',REGEXREPLACE('[^a-zA-Z0-9]',tempName+trim(L.make,left,right)+trim(L.model,left,right)+
																trim(L.year,left,right)+trim(L.boat_length,left,right)[1..30],''),
																REGEXREPLACE('[^a-zA-Z0-9]',trim(L.pid,all)+trim(L.make,left,right)+trim(L.model,left,right)+
																						trim(L.year,left,right)+trim(L.boat_length,left,right)[1..30],''));                      
	self.sequence_key				:=	(string) IF(tempName <> '',hash(tempName),hash(REGEXREPLACE('[^a-zA-Z0-9]',trim(L.ADDRESS1,left,right)+trim(L.ADDRESS2,left,right)+
																	trim(L.make,left,right)+trim(L.model,left,right)+trim(L.year,left,right)+trim(L.boat_length,left,right),'')));
	self.watercraft_id						:=	'';
	self.state_origin						:=	'US'; //State origin cannot be determined
	self.source_code						:=	'W1';
	self.st_registration					:=	trim(L.state,left,right); //Address state is not necessarily the registration state
	self.county_registration				:=	trim(L.fips_county,left,right); //Address is not necessarily registration address
	self.registration_number				:=	'';
	self.hull_number						:=	'';
	self.propulsion_code					:=	L.boat_propulsion;
	self.propulsion_description				:=	watercraft_propulsion_desc(L.boat_propulsion);
	self.vehicle_type_Code					:=	L.boat_type;
	self.vehicle_type_Description			:=	watercraft_type_desc(L.boat_type);
	self.fuel_code							:=	L.boat_fuel;
	self.fuel_description					:=	CASE(L.boat_fuel, '1' => 'GASOLINE', '2' => 'DIESEL','');
	self.hull_type_code						:=	L.boat_hull_material;
	self.hull_type_description				:=	watercraft_hull_shape(L.boat_hull_material);
	self.use_code							:=	L.boat_use;
	self.use_description					:=	watercraft_use_desc(L.boat_use);
	self.watercraft_length					:=	lengthFttoInch(L.boat_length);
	self.model_year							:=	L.year;
	self.watercraft_name					:=	'';
	self.watercraft_class_code				:=	L.boat_size;
	self.watercraft_class_description		:=	watercraft_class_desc(L.boat_size);
	self.watercraft_make_code				:=	'';
	self.watercraft_make_description		:=	L.make;
	self.watercraft_model_code				:=	'';
	self.watercraft_model_description		:=	L.model;
	self.watercraft_width					:=	'';
	self.watercraft_weight					:=	'';
	self.watercraft_color_1_code			:=	'';
	self.watercraft_color_1_description		:=	'';
	self.watercraft_color_2_code			:=	'';
	self.watercraft_color_2_description		:=	'';
	self.watercraft_toilet_code				:=	'';
	self.watercraft_toilet_description		:=	'';
	self.watercraft_number_of_engines		:=	'';
	self.watercraft_hp_1					:=	'';
	self.watercraft_hp_2					:=	'';
	self.watercraft_hp_3					:=	'';
	self.engine_number_1					:=	'';
	self.engine_number_2					:=	'';
	self.engine_number_3					:=	'';
	self.engine_make_1						:=	'';
	self.engine_make_2						:=	'';
	self.engine_make_3						:=	'';
	self.engine_model_1						:=	'';
	self.engine_model_2						:=	'';
	self.engine_model_3						:=	'';
	self.engine_year_1						:=	'';
	self.engine_year_2						:=	'';
	self.engine_year_3						:=	'';
	self.coast_guard_documented_flag		:=	'';
	self.coast_guard_number					:=	'';
	self.registration_date					:=	'';
	self.registration_expiration_date		:=	'';
	self.registration_status_code			:=	'';
	self.registration_status_description	:=	'';
	self.registration_status_date			:=	'';
	self.registration_renewal_date			:=	'';
	self.decal_number						:=	'';
	self.transaction_type_code				:=	'';
	self.transaction_type_description		:=	'';
	self.title_state						:=	'';
	self.title_status_code					:=	'';
	self.title_status_description			:=	'';
	self.title_number						:=	'';
	self.title_issue_date					:=	'';
	self.title_type_code					:=	'';
	self.title_type_description				:=	'';
	self.additional_owner_count				:=	'';
	self.lien_1_indicator					:=	'';
	self.lien_1_name						:=	'';
	self.lien_1_date						:=	'';
	self.lien_1_address_1					:=	'';
	self.lien_1_address_2					:=	'';
	self.lien_1_city						:=	'';
	self.lien_1_state						:=	'';
	self.lien_1_zip							:=	'';
	self.lien_2_indicator					:=	'';
	self.lien_2_name						:=	'';
	self.lien_2_date						:=	'';
	self.lien_2_address_1					:=	'';
	self.lien_2_address_2					:=	'';
	self.lien_2_city						:=	'';
	self.lien_2_state						:=	'';
	self.lien_2_zip							:=	'';
	self.state_purchased					:=	'';
	self.purchase_date						:=	'';
	self.dealer								:=	'';
	self.purchase_price						:=	'';
	self.new_used_flag						:=	'';
	self.watercraft_status_code				:=	'';
	self.watercraft_status_description		:=	'';
	self.history_flag							:=	'';
	self.coastguard_flag					:=	'';
	self.hull_shape								:= L.boat_hull_shape;
	self.hull_shape_description		:= watercraft_hull_shape(L.boat_hull_shape);
	// self.src_first_date	:= L.first_seen_date;
	// self.src_last_date	:= L.last_seen_date;
  end;
	
//output that includes the extra Infutor fields
ds_map_base := project(ds_watercraft_in(trim(fname,all) <> '' and trim(lname,all) <> ''), main_mapping_format(left)) :	persist(Watercraft.Cluster +'persist::Watercraft_NonDPPA_Main');

//Output to watercraft Main layout to be included in Watercraft.Persist_Main_Joined process
ds_map_to_watercraft := project(ds_map_base, transform(watercraft.Layout_Watercraft_Main_Base, self := left));
//Remove duplicate records
ds_watercraft_dedup := dedup(ds_map_to_watercraft,
															watercraft_key,
															sequence_key,
															watercraft_make_description,
															watercraft_model_description,
															model_year,
															watercraft_length);

//Count of records that were filtered due to blank names
output(count(ds_watercraft_in(trim(fname,all) = '' and trim(lname,all) = '')),named('BlankNamesFiltered2'));

EXPORT Map_watercraft_infutor_base :=	ds_watercraft_dedup;
