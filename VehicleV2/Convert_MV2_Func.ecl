import Vehiclev2,Text_Search,census_data;

dmain := distribute(vehiclev2.file_VehicleV2_Main,hash(vehicle_key));
dparty := distribute(vehiclev2.file_vehicleV2_party,hash(vehicle_key));

myrec := record
typeof(dmain.Vehicle_Key) Vehicle_Key;
typeof(dmain.Iteration_Key) Iteration_Key;
typeof(dparty.Sequence_Key) Sequence_Key;
typeof(dmain.Source_Code) Source_Code;
typeof(dmain.State_Origin) State_Origin;
typeof(dmain.Orig_VIN) Orig_VIN;
typeof(dmain.VINA_VIN) VINA_VIN;
typeof(dmain.Orig_Year) Orig_Year;
typeof(dmain.VINA_Model_Year) VINA_Model_Year;
typeof(dmain.Orig_Make_Desc) Orig_Make_Desc;
typeof(dmain.VINA_Make_Desc) VINA_Make_Desc;
typeof(dmain.Orig_Vehicle_Type_Desc) Orig_Vehicle_Type_Desc;
typeof(dmain.Orig_Series_Desc) Orig_Series_Desc;
typeof(dmain.VINA_Series_Desc) VINA_Series_Desc;
typeof(dmain.Orig_Model_Desc) Orig_Model_Desc;
typeof(dmain.VINA_Model_Desc) VINA_Model_Desc;
typeof(dmain.Orig_Body_Desc) Orig_Body_Desc;
typeof(dmain.VINA_Body_Style_Desc) VINA_Body_Style_Desc;
typeof(dmain.Orig_Major_Color_Desc) Orig_Major_Color_Desc;
typeof(dmain.Orig_Minor_Color_Desc) Orig_Minor_Color_Desc;
typeof(dparty.Orig_Name_Type) Orig_Name_Type;
typeof(dparty.Orig_Name) Orig_Name;
typeof(dparty.Orig_Address) Orig_Address;
typeof(dparty.Orig_City) Orig_City;
typeof(dparty.Orig_State) Orig_State;
typeof(dparty.orig_province) orig_province;
typeof(dparty.orig_country) orig_country;
typeof(dparty.Orig_Zip) Orig_Zip;
typeof(dparty.Orig_DOB) Orig_DOB;
typeof(dparty.Append_Clean_Address.st) fips_state;
typeof(dparty.Append_Clean_Address.fips_county) fips_county;
typeof(dparty.Reg_True_License_Plate) Reg_True_License_Plate;
typeof(dparty.Reg_License_State) Reg_License_State;
typeof(dparty.Reg_License_Plate_Type_Code) Reg_License_Plate_Type_Code;
typeof(dparty.Reg_Previous_License_Plate) Reg_Previous_License_Plate;
typeof(dparty.Reg_Previous_License_State) Reg_Previous_License_State;
typeof(dparty.Reg_First_Date) Reg_First_Date;
typeof(dparty.Reg_Earliest_Effective_Date) Reg_Earliest_Effective_Date;
typeof(dparty.Reg_Latest_Effective_Date) Reg_Latest_Effective_Date;
typeof(dparty.Reg_Latest_Expiration_Date) Reg_Latest_Expiration_Date;
typeof(dparty.Reg_Decal_Number) Reg_Decal_Number;
typeof(dparty.Reg_Status_Code) Reg_Status_Code;
typeof(dparty.Ttl_Number) Ttl_Number;
typeof(dparty.Ttl_Earliest_Issue_Date) Ttl_Earliest_Issue_Date;
typeof(dparty.Ttl_Latest_Issue_Date) Ttl_Latest_Issue_Date;
typeof(dparty.Ttl_Previous_Issue_Date) Ttl_Previous_Issue_Date;
typeof(dmain.orig_net_weight) orig_net_weight;

end;

myrec join_recs(dparty l,dmain r) := transform
	self := r;
	self.fips_state		:= l.Append_Clean_Address.st;
	self.fips_county	:= l.Append_Clean_Address.fips_county;
	self := l;
end;

dfull_join := join(dparty,dmain,
							left.vehicle_key = right.vehicle_key and left.iteration_key = right.iteration_key,
							join_recs(left,right),
							local
							);
// Explode county names
county_rec := record
	dfull_join;
	string18 county_name;
end;


fips_ds := census_data.Key_Fips2County;

county_rec c_join_recs(dfull_join l,fips_ds r) := transform
	self.county_name := r.county_name;
	self := l;
end;
	
dfull := join(dfull_join,fips_ds,left.fips_state = right.state_code and 
				left.fips_county = right.county_fips,
				c_join_recs(left,right),
				KEYED,
				left outer,
				local);
	
sfull := sort(dfull,vehicle_key,iteration_key,sequence_key,local);
dedup_full := dedup(sfull,record,local);

Text_MV_Record := record(Text_search.Layout_Document)
	typeof(dmain.Vehicle_Key) Vehicle_Key;
typeof(dmain.Iteration_Key) Iteration_Key;
typeof(dparty.Sequence_Key) Sequence_Key;	
end;

Text_MV_Flat := record(Text_Search.Layout_DocSeg)
	typeof(dmain.Vehicle_Key) Vehicle_Key;
typeof(dmain.Iteration_Key) Iteration_Key;
typeof(dparty.Sequence_Key) Sequence_Key;
end;

Text_MV_Record convert_func(dedup_full l) := transform
	self.Vehicle_key := l.vehicle_key;
	self.Iteration_key := l.Iteration_key;
	self.Sequence_key := l.Sequence_key;
	self.docref.src := TRANSFER(l.source_code, INTEGER2);
	self.docref.doc := 0;
	self.segs := dataset([
			{1,0,l.state_origin},
			{2,0,if(l.orig_vin <> '',l.orig_vin,l.VINA_vin)},
			{3,0,if(l.orig_year <> '',l.orig_year,l.vina_model_year)},
			{4,0,if(l.orig_make_desc <> '',l.orig_make_desc,l.vina_make_desc)},
			{5,0,l.orig_vehicle_type_desc},
			{6,0,if(l.orig_series_desc <> '',l.orig_series_desc,l.vina_series_desc)},
			{7,0,if(l.orig_model_desc <> '',l.orig_model_desc,l.vina_model_desc)},
			{8,0,if(l.orig_body_desc <> '',l.orig_body_desc,l.vina_body_style_desc)},
			{9,0,l.orig_major_color_desc + ';' + l.orig_minor_color_desc},
			{10,0,l.orig_net_weight},
			{11,0,if(l.orig_name_type = '1',l.orig_name + ';','')},
			{13,0,if(l.orig_name_type = '1',l.orig_address + ' ' +
														l.orig_city + ' ' + l.orig_state + ' ' + l.orig_zip  
														+ ' ' + l.county_name + ' COUNTY' + ';','')},
			{12,0,if(l.orig_name_type = '1',l.orig_dob + ';','')},
			{14,0,l.Reg_True_License_Plate},
			{15,0,l.Reg_License_State},
			{16,0,l.Reg_License_Plate_Type_Code},
			{17,0,l.Reg_Previous_License_Plate},
			{18,0,l.Reg_Previous_License_State},
			{19,0,l.Reg_First_Date},
			{20,0,l.Reg_Earliest_Effective_Date + ';' + l.Reg_Latest_Effective_Date},
			{21,0,l.Reg_Latest_Expiration_Date},
			{22,0,l.Reg_Decal_Number},
			{23,0,l.Reg_Status_Code},
			{24,0,if(l.orig_name_type = '4',l.orig_name + ';','')},
			{26,0,if(l.orig_name_type = '4',l.orig_address + ' ' +
														l.orig_city + ' ' + l.orig_state + ' ' + l.orig_zip 
														+ ' ' + l.county_name + ' COUNTY' + ';','')},
			{25,0,if(l.orig_name_type = '4',l.orig_dob + ';','')},
			{27,0,l.Ttl_Number},
			{28,0,l.Ttl_Earliest_Issue_Date + ';' + l.Ttl_Latest_Issue_Date},
			{29,0,l.Ttl_Previous_Issue_Date},
			{30,0,if(l.orig_name_type = '7',l.orig_name + ';','')},
			{31,0,if(l.orig_name_type = '7',l.orig_address + ' ' +
														l.orig_city + ' ' + l.orig_state + ' ' + l.orig_zip 
														+ ' ' + l.county_name + ' COUNTY' + ';','')},
			{32,0,if(l.orig_name_type = '2',l.orig_name + ';','')},
			{34,0,if(l.orig_name_type = '2',l.orig_address + ' ' +
														l.orig_city + ' ' + l.orig_state + ' ' + l.orig_zip 
														+ ' ' + l.county_name + ' COUNTY' + ';','')},
			{33,0,if(l.orig_name_type = '2',l.orig_dob + ';','')},
			{35,0,if(l.orig_name_type = '5',l.orig_name + ';','')},
			{37,0,if(l.orig_name_type = '5',l.orig_address + ' ' +
														l.orig_city + ' ' + l.orig_state + ' ' + l.orig_zip 
														+ ' ' + l.county_name + ' COUNTY' + ';','')},
			{36,0,if(l.orig_name_type = '5',l.orig_dob + ';','')}
			],text_search.Layout_Segment
			);
end;

proj_out := project(dedup_full,convert_func(left));

Text_MV_Flat norm_recs(Text_MV_Record l,Text_search.Layout_segment r) := transform
	self.docref := l.docref;
	self.vehicle_key := l.vehicle_key;
	self.iteration_key := l.iteration_key;
	self.sequence_key := l.sequence_key;
	self := r;
end;

norm_out := normalize(proj_out,left.segs,norm_recs(left,right));

Text_MV_Flat iterate_recs(Text_MV_Flat l,Text_MV_Flat r) := transform
	self.docref.doc := 	if(l.vehicle_key = r.vehicle_key and l.iteration_key = r.iteration_key
														and l.sequence_key = r.sequence_key,
												l.docref.doc,
												if(l.docref.doc = 0,thorlib.node() + 1,l.docref.doc + thorlib.nodes())
											);
	self.docref.src := r.docref.src;
	self.sect := if(l.sequence_key <> r.sequence_key or l.segment <> r.segment,0,l.sect+1);
	self := r;
end;

iterate_out := iterate(norm_out,iterate_recs(left,right),local);

// External key
	
Text_MV_Flat MakeKeySegs( iterate_out l, unsigned2 segno ) := TRANSFORM
	self.vehicle_key := l.vehicle_key;
	self.iteration_key := l.iteration_key;
	self.sequence_key := trim(l.sequence_key,left);
        self.docref.doc := l.docref.doc;
        self.docref.src := l.docref.src;
		self.segment := segno;
        self.content := l.vehicle_key + l.iteration_key + trim(l.sequence_key,left);
        self.sect := 1;
    END;

    segkeys := PROJECT(iterate_out(trim(content) <> '' and trim(content) <> ';'),MakeKeySegs(LEFT,250));

	full_ret := iterate_out(trim(content) <> '' and trim(content) <> ';') + segkeys;


export Convert_MV2_Func := full_ret;