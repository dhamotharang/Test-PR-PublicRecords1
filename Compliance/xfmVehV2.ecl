IMPORT VehicleV2, VINA, Standard, ut,Data_Services, AID, BIPV2;


//Party Base File:
ds_VehV2_Party := PULL(DATASET(ut.foreign_prod+'thor_data400::base::VehicleV2::party',
															VehicleV2.Layout_Base.Party_Bip, FLAT, __COMPRESSED__));

//Main Base File:
ds_VehV2_Main := DATASET(ut.foreign_prod+'thor_data400::base::VehicleV2::Main',
							VehicleV2.Layout_Base.Main, FLAT);

/*							
//Non-FCRA Party Key (VehicleV2.Key_Vehicle_Party_Key)
layout_VehV2_Party_Key :=
	RECORD
		VehicleV2.Layout_Base_Party;
		STRING70	std_lienholder_name;
		BIPV2.IDlayouts.l_xlink_ids;
		string1 filler := '';
		unsigned8 __internal_fpos__;
 END;

rec_key_VehV2_Party_keyfields := 
	RECORD
		string30 vehicle_key;
		string15 iteration_key;
		string15 sequence_key;
	END;

rec_key_VehV2_Party_nonkeyfields := {layout_VehV2_Party_Key} - {rec_key_VehV2_Party_keyfields};

ky_VehV2_Party := PULL(INDEX(rec_key_VehV2_Party_keyfields, rec_key_VehV2_Party_nonkeyfields, Data_Services.foreign_prod+'thor_data400::key::vehiclev2::party_key_qa'));							

//Non-FCRA Main Key (thor_data400::key::vehicleV2::main_Key_qa):							
ky_VehV2_Main := VehicleV2.Key_Vehicle_Main_Key;
*/
//-----

rec_VehV2_party_base_with_VIN := {ds_VehV2_Party, string25 orig_vin := '', string17	VINA_VIN := ''};
ds_VehV2_Party_base_with_VIN := PROJECT(ds_VehV2_Party, rec_VehV2_party_base_with_VIN);


EXPORT Compliance.Layout_Out_v3 xfmVehV2(rec_VehV2_party_base_with_VIN LE, Compliance.Layout_orig_out RI) := 
	TRANSFORM
		self.listed_phone := LE.source_code + '_' + LE.state_origin;
		
		self.src := MAP(LE.source_code  = 'AE' AND LE.state_origin = 'AK' => 'AE',
										LE.source_code  = 'AE' AND LE.state_origin = 'AL' => 'BE',
										LE.source_code  = 'AE' AND LE.state_origin = 'CO' => 'EE',
										LE.source_code  = 'AE' AND LE.state_origin = 'CT' => 'CE',
										LE.source_code  = 'AE' AND LE.state_origin = 'DC' => '&E',
										LE.source_code  = 'AE' AND LE.state_origin = 'DE' => '$E',
										LE.source_code  = 'AE' AND LE.state_origin = 'FL' => 'GE',
										LE.source_code  = 'AE' AND LE.state_origin = 'ID' => 'JE',
										LE.source_code  = 'AE' AND LE.state_origin = 'IL' => 'IE',
										LE.source_code  = 'AE' AND LE.state_origin = 'KY' => 'KE',
										LE.source_code  = 'AE' AND LE.state_origin = 'LA' => 'LE',
										LE.source_code  = 'AE' AND LE.state_origin = 'MA' => 'NE',
										LE.source_code  = 'AE' AND LE.state_origin = 'MD' => 'ME',
										LE.source_code  = 'AE' AND LE.state_origin = 'ME' => 'RE',
										LE.source_code  = 'AE' AND LE.state_origin = 'MI' => 'PE',
										LE.source_code  = 'AE' AND LE.state_origin = 'MN' => 'VE',
										LE.source_code  = 'AE' AND LE.state_origin = 'MO' => 'YE',
										LE.source_code  = 'AE' AND LE.state_origin = 'MS' => 'XE',
										LE.source_code  = 'AE' AND LE.state_origin = 'MT' => 'ZE',
										LE.source_code  = 'AE' AND LE.state_origin = 'ND' => '@E',
										LE.source_code  = 'AE' AND LE.state_origin = 'NE' => 'HE',
										LE.source_code  = 'AE' AND LE.state_origin = 'NM' => '+E',
										LE.source_code  = 'AE' AND LE.state_origin = 'NV' => '?E',
										LE.source_code  = 'AE' AND LE.state_origin = 'NY' => 'QE',
										LE.source_code  = 'AE' AND LE.state_origin = 'OH' => '!E',
										LE.source_code  = 'AE' AND LE.state_origin = 'OK' => 'OE',
										LE.source_code  = 'AE' AND LE.state_origin = 'SC' => 'SE',
										LE.source_code  = 'AE' AND LE.state_origin = 'TN' => 'TE',
										LE.source_code  = 'AE' AND LE.state_origin = 'TX' => '.E',
										LE.source_code  = 'AE' AND LE.state_origin = 'UT' => 'UE',
										LE.source_code  = 'AE' AND LE.state_origin = 'WI' => 'WE',
										LE.source_code  = 'AE' AND LE.state_origin = 'WY' => '#E',
										LE.source_code  = 'DI' AND LE.state_origin = 'FL' => 'FV',
										LE.source_code  = 'DI' AND LE.state_origin = 'ID' => 'IV',
										LE.source_code  = 'DI' AND LE.state_origin = 'KY' => 'KV',
										LE.source_code  = 'DI' AND LE.state_origin = 'ME' => 'AV',
										LE.source_code  = 'DI' AND LE.state_origin = 'MN' => 'NV',
										LE.source_code  = 'DI' AND LE.state_origin = 'MO' => 'SV',
										LE.source_code  = 'DI' AND LE.state_origin = 'MS' => 'MV',
										LE.source_code  = 'DI' AND LE.state_origin = 'MT' => 'LV',
										LE.source_code  = 'DI' AND LE.state_origin = 'NC' => 'RV',
										LE.source_code  = 'DI' AND LE.state_origin = 'ND' => 'PV',
										LE.source_code  = 'DI' AND LE.state_origin = 'NE' => 'EV',
										LE.source_code  = 'DI' AND LE.state_origin = 'NV' => 'QV',
										LE.source_code  = 'DI' AND LE.state_origin = 'OH' => 'OV',
										LE.source_code  = 'DI' AND LE.state_origin = 'TX' => 'TV',
										LE.source_code  = 'DI' AND LE.state_origin = 'WI' => 'WV',
										LE.source_code  = 'DI' AND LE.state_origin = 'WY' => 'YV',
										
										LE.source_code  = '1V'  => LE.source_code,	//1V and 2V are Infutor; both not in PHDR
										LE.source_code  = '2V'  => LE.source_code,
										''	//need to know if mistake, or a new code/vendor/State	
										);
		
//		self.rec_type := LE.current_record_flag;
		self.pflag1 := LE.latest_vehicle_flag;
		self.pflag2 := LE.latest_vehicle_iteration_flag;
		self.pflag3 := LE.history;
		self.jflag1 := LE.orig_party_type;
		self.jflag2 := LE.orig_name_type;
//		self.jflag3 := LE.indent_code;
		
		self.did := MAP(LE.append_did = 0 AND (LE.SeleID <> 0 AND LE.Append_Clean_CName <> '') => LE.SeleID
										,LE.append_did);
										
		self.rid := LE.source_rec_id;
		self.dt_first_seen := (unsigned3) LE.date_first_seen;
		self.dt_last_seen := (unsigned3) LE.date_last_seen;
		self.dt_vendor_last_reported := (unsigned3) LE.date_vendor_last_reported;
		self.dt_vendor_first_reported := (unsigned3) LE.date_vendor_first_reported;
		self.dt_nonglb_last_seen := (unsigned3) LE.ttl_latest_issue_date;
		
		self.vendor_id := LE.reg_true_license_plate;
		self.ssn := LE.append_ssn;
		self.dob := (integer4) LE.append_dob;
		
		self.title := LE.title;
		self.fname := LE.fname;
		self.mname := LE.mname;
		self.lname := MAP(LE.Append_Clean_CName <> '' => LE.Append_Clean_CName
											,LE.lname);
		self.name_suffix := LE.name_suffix;
		self.prim_range := LE.prim_range;
		self.predir := LE.predir;
		self.prim_name := LE.prim_name;
		self.suffix := LE.addr_suffix;
		self.postdir := LE.postdir;
		self.unit_desig := LE.unit_desig;
		self.sec_range := LE.sec_range;
		self.city_name := LE.v_city_name;
		self.st := LE.st;
		self.zip := LE.zip5;
		self.zip4 := LE.zip4;
		
//		self.RawAID := LE.RawAID;
//		self.NID := LE.NID;
//		self.name_ind := LE.name_ind;
		self.persistent_record_ID := LE.source_rec_id;
//		self.hhid := LE.hhid;
		
		self.listed_name := LE.vehicle_key;
		self.county_name := LE.iteration_key;
		self.phone := LE.registration_effective_date;
		
		self.source_value := self.src;
		
		self.vin_num := RI.srch_vin;
		self.tag_num := RI.srch_tag;
						
		SELF := LE;
		SELF := RI;
	END;