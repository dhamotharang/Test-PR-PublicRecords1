import VehicleV2, BIPV2, Standard, address_attributes, Vehicle_Wildcard,prte2; 

EXPORT Layouts := module

	shared Standard.Name	Append_Clean_Name;
	shared Standard.Addr	Append_Clean_Address;

//Input Layouts
	export in_main := record
		VehicleV2.Layout_Base.Main - [State_Bitmap_Flag,
																  Brand_Code_1,
																	Brand_Date_1,
																	Brand_State_1,
																	Brand_Code_2,
																	Brand_Date_2,
																	Brand_State_2,
																	Brand_Code_3,
																	Brand_Date_3,
																	Brand_State_3,
																	Brand_Code_4,
																	Brand_Date_4,
																	Brand_State_4,
																	Brand_Code_5,
																	Brand_Date_5,
																	Brand_State_5,
																	TOD_flag,
																	Model_class_code,
																	Model_Class,
																	Min_Door_count,
																	Safety_type,
																	AIRBAG_DRIVER,
																	AIRBAG_FRONT_DRIVER_SIDE,
																	AIRBAG_FRONT_HEAD_CURTAIN,
																	AIRBAG_FRONT_PASS,
																	AIRBAG_FRONT_PASS_SIDE,
																	Branded_title_flag];
			string20 cust_name;
			string10 bug_num;
		end;
		
		export in_party	:= record
		string30				Vehicle_Key;
		string15				Iteration_Key;
		string15				Sequence_Key;
		string2					Source_Code;
		string2					State_Origin;
		string1					Latest_Vehicle_Flag;
		string1					Latest_Vehicle_Iteration_Flag;
		string1					History;
		unsigned4				Date_First_Seen;
		unsigned4				Date_Last_Seen;
		unsigned4				Date_Vendor_First_Reported;
		unsigned4				Date_Vendor_Last_Reported;
		string1					Orig_Party_Type;
		string1					Orig_Name_Type;
		string10				Orig_Conjunction;
		string70				Orig_Name;
		string70				Orig_Address;
		string35				Orig_City;
		string2					Orig_State;
		string10				Orig_Zip;
		string9					Orig_SSN;
		string9					Orig_FEIN;
		string20				Orig_DL_Number;
		string8					Orig_DOB;
		string1					Orig_Sex;
		string8					Orig_Lien_Date;
		string5					title;
		string20				fname;
		string20				mname;
		string20				lname;
		string5					name_suffix;
		string3					name_score;
		string70				Append_Clean_CName;
		string10				prim_range;
		string2					predir;
		string28				prim_name;
		string4					addr_suffix;
		string2					postdir;
		string10				unit_desig;
		string8					sec_range;
		string25				v_city_name;
		string2					st;
		string5					zip5;
		string4					zip4;
		// string2					addr_rec_type;
		string2					fips_state;
		string3					fips_county;
		string10				geo_lat;
		string11				geo_long;
		string4					cbsa;
		string7					geo_blk;
		string1					geo_match;
		string4					err_stat;
		unsigned6				Append_DID;
		unsigned6				Append_BDID;
		string20				Append_DL_Number;
		string9					Append_SSN;
		string9					Append_FEIN;
		string8     		Append_DOB;
		string8					Reg_First_Date;
		string8					Reg_Earliest_Effective_Date;
		string8					Reg_Latest_Effective_Date;
		string10				Reg_Latest_Expiration_Date;
		unsigned1				Reg_Rollup_Count;
		string10				Reg_Decal_Number;
		string4					Reg_Decal_Year;
		string1					Reg_Status_Code;
		string20				Reg_Status_Desc;
		string10				Reg_True_License_Plate;
		string10				Reg_License_Plate;
		string2					Reg_License_State;
		string4					Reg_License_Plate_Type_Code;
		string65				Reg_License_Plate_Type_Desc;
		string2					Reg_Previous_License_State;
		string10				Reg_Previous_License_Plate;
		string20				Ttl_Number;
		string8					Ttl_Earliest_Issue_Date;
		string8					Ttl_Latest_Issue_Date;
		string8					Ttl_Previous_Issue_Date;
		unsigned1				Ttl_Rollup_Count;
		string2					Ttl_Status_Code;
		string48				Ttl_Status_Desc;
  	string7					Ttl_Odometer_Mileage;
		string1					Ttl_Odometer_Status_Code;
		string42				Ttl_Odometer_Status_Desc;
		string8					Ttl_Odometer_Date;
		string70        std_lienholder_name;
		BIPV2.IDlayouts.l_xlink_ids;
		string1 filler;
		string20 cust_name;
		string10 bug_num;
		string8	 link_dob;
		string9	 link_ssn;
		string9  link_fein;
		string8  Link_incorp_date;
		end;
		
//Base Layout		
		export Base_Main  := record
			VehicleV2.Layout_Base_Main;
			string20 cust_name;
			string10 bug_num;
		end;
		
		
//Key Layouts		
		// export Base_Party_BIP_2 := record
			// VehicleV2.Layout_Base.Party_bip;
			// string20 cust_name;
			// string10 bug_num;
			// string8	 link_dob;
			// string9	 link_ssn;
			// string9  link_fein;
			// string8  Link_incorp_date;
			// prte2.layouts.DEFLT_CPA;
			// end;
			
			export Base_Party_BIP := record
			VehicleV2.Layout_Base.Party_bip;
			string20 cust_name;
			string10 bug_num;
			string8	 link_dob;
			string9	 link_ssn;
			string9  link_fein;
			string8  Link_incorp_date;
			prte2.layouts.DEFLT_CPA;
			end;
		
		// export Base_Party_BIP_2 := record
			// VehicleV2.Layout_Base.Party_bip;
			// string20 cust_name;
			// string10 bug_num;
			// string8	 link_dob;
			// string9	 link_ssn;
			// string9  link_fein;
			// string8  Link_incorp_date;
		//	prte2.layouts.DEFLT_CPA;
	//		end;
		
		export Party_Building := record
			VehicleV2.Layout_Base.Party_Base_BIP;
		end;
		
		export Party_Sequence := record
			VehicleV2.Layout_Base_Party;
			BIPV2.IDlayouts.l_xlink_ids;
		end;
			
		export Slim_Rec := record
			string10 license_plate;
			string10 reverse_license_plate;
			string30 Vehicle_Key;
			string15 Iteration_Key;
			string15 Sequence_Key;
			string2  reg_previous_license_state;
			string2  state_origin;
			string2  st;
			string2  Reg_License_State;
			string2  state;
			string1  state_type;
			string1  orig_name_type;
			string1	 history;
			string8	 Reg_Latest_Effective_Date;
			string8	 Reg_Latest_Expiration_Date;
			string8	 Ttl_Latest_Issue_Date;
			string8	 orig_dob;
			string9	 orig_ssn;
			string9  append_ssn;
			Append_Clean_Name.fname;
			Append_Clean_Name.lname;
			Append_Clean_Name.mname;
			Append_Clean_Address.predir;
			Append_Clean_Address.prim_name;
			Append_Clean_Address.prim_range;
			Append_Clean_Address.addr_suffix;
			Append_Clean_Address.postdir;
			Append_Clean_Address.sec_range;
			Append_Clean_Address.v_city_name;
			Append_Clean_Address.zip5;
			string70 Append_Clean_Cname;
			Append_Clean_Address.fips_county;
			Append_Clean_Address.geo_lat;
			Append_Clean_Address.geo_long;
			Append_Clean_Address.geo_blk;
			Append_Clean_Address.geo_match;
end;

	export lic_plate_rec := record
		string10 	license_plate;
		string10 	reverse_license_plate;
		string30 	Vehicle_Key;
		string15 	Iteration_Key;
		string15 	Sequence_Key;
		string2  	state_origin;
		boolean 	is_current;
		boolean 	is_minor;
		unsigned4 date;
		string6 	dph_lname;
		string20 	pfname;
		string8		orig_dob;
		string9 	use_ssn;
		Append_Clean_Name.fname;
		Append_Clean_Name.lname;
		Append_Clean_Name.mname;
		Append_Clean_Address.predir;
		Append_Clean_Address.prim_name;
		Append_Clean_Address.prim_range;
		Append_Clean_Address.addr_suffix;
		Append_Clean_Address.postdir;
		Append_Clean_Address.sec_range;
		Append_Clean_Address.v_city_name;
		Append_Clean_Address.zip5;
		string70 Append_Clean_Cname;
		string1 	state_type;
		Append_Clean_Address.fips_county;
		Append_Clean_Address.geo_lat;
		Append_Clean_Address.geo_long;
		Append_Clean_Address.geo_blk;
		Append_Clean_Address.geo_match;
	end;

	
	export Key_Vehicle_Party := 	RECORD
		VehicleV2.Layout_Base_Party;
		STRING70	std_lienholder_name;
		BIPV2.IDlayouts.l_xlink_ids;
		string1 filler := '';
	END;

		
	export Title_Record := record
		string20		Ttl_Number;
		string2     state_origin;
		string30    Vehicle_Key;
		string15    Iteration_Key;
		string15    Sequence_Key;
	end;


	export Layout_Veh_Info := RECORD
		UNSIGNED2 year_make;
		STRING10 make;		
		STRING10 model;
		BOOLEAN title;
		STRING25 vin;
		string2	orig_state;
		string2 source_code;
	END;

	export Layout_Veh := RECORD
		UNSIGNED1 current_count;
		UNSIGNED1 historical_count;
		Layout_Veh_Info Vehicle1;
		Layout_Veh_Info Vehicle2;
		Layout_Veh_Info Vehicle3;
	END;

	export vehrec := RECORD
		unsigned6	did;
		string30		Vehicle_Key;
		string15		Iteration_Key;
		string15		Sequence_Key;
		Layout_Veh;
END;

	export lic_plate_slim := record
		lic_plate_rec - {Append_Clean_Address.fips_county,
										 Append_Clean_Address.geo_lat,
										 Append_Clean_Address.geo_long,
										 Append_Clean_Address.geo_blk,
										 Append_Clean_Address.geo_match
										 };
		end;
	
	export mfd_rec := record
		STRING5 	zip5;
		STRING10 	prim_range;
		STRING28 	prim_name;
		STRING4 	suffix;
		STRING2 	predir;
		STRING2 	postdir;
		//payload
		STRING10 	unit_desig;
		STRING8 	sec_range;
		STRING25 	v_city_name;
		STRING2 	st;
		STRING4 	zip4;	
		STRING30 	vehicle_key;
		STRING15 	iteration_key;
		STRING15 	sequence_key;
		STRING2 	source_code;
		STRING2 	state_origin;
		BOOLEAN 	is_minor;
		STRING1 	history;
		UNSIGNED3 date_last_seen;
		UNSIGNED6 reg_expire_date;						
	END;
	
	export Autokey := record
		string30	Vehicle_Key;
		string15	Iteration_Key;
		string15	Sequence_Key;
		string2		Source_Code;
		string1		Orig_Party_Type;
		string1		Orig_Name_Type;
		unsigned6	Append_DID;
		unsigned6	Append_BDID;
		string20	Append_DL_Number;
		string9		Append_SSN;	
		string9		Append_FEIN;
		standard.Addr addr;
		standard.name name;
		string70	Append_Clean_CName;
		string1	history;
		prte2.layouts.DEFLT_CPA;
		unsigned4 Reg_Latest_Effective_Date;
		unsigned4 Reg_Latest_Expiration_Date;
		unsigned4 Ttl_Latest_Issue_Date;
		unsigned4 lookup_bit := 0;
		unsigned1 zero := 0;
		string1  blank:='';
end;
	
	export Address_Attributes_Vehicle := record
		address_attributes.layouts.vehicles;
	end;


	export wildcard_public	:= record
		Vehicle_Wildcard.Layout_Hole_Veh;
 end;

	export keymodelindex_public	:= record
		qstring36 str;
		unsigned2 i;
end;

	export keynameindex_public	:= record
		qstring20 str;
		unsigned4 i;
end;

	export wc_vehicle_bodystyle	:= record
		string2 	body_style;
		unsigned2 i;
		string50 	body_style_description;
		string20 	category;
		unsigned8 __internal_fpos__;
end;

	export wc_vehicle_make	:= record
		string10 makecode;
		unsigned2 i;
end;

//DID Key Layout
	export did_rec := record
		string30 Vehicle_Key;
		string15 Iteration_Key;
		string15 Sequence_Key;
		unsigned6	Append_DID;	
		boolean is_minor;
	end;

//Key DL Number
	export dl_rec := record
		string20 DL_number;
		string30 Vehicle_Key;
		string15 Iteration_Key;
		string15 Sequence_Key;
		string2  state_origin;
		boolean  is_minor;
	end;


	//Vin Key
	export vin_rec := record
		string25 VIN;
		string30 Vehicle_Key;		
		string15 Iteration_Key;
		string2  state_origin;
	end;

// Blur Key
	export l_blur := record
		string10 license_plate_blur;
		string10 license_plate;
	end;
	
// Source Rec Key	
	export source_rec := record
		unsigned8 	source_rec_id;
		string30		vehicle_key;
		string15		iteration_key;
		string15		sequence_key;
	end;

end;