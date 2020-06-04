import header,ut,vehlic,Data_Services,Std;

export	Vehicle_as_Source(	dataset(VehicleV2.Layout_Base_Main)		pVehiclemain		=	dataset([],VehicleV2.Layout_Base_Main),
														dataset(VehicleV2.Layout_Base.Party_CCPA)	pVehicleSearch	=	dataset([],VehicleV2.Layout_Base.Party_CCPA),
														boolean pForHeaderBuild=false,
														boolean pFastHeader = false
													)
	:=
  function
	lc := Data_Services.Data_location.prefix('VehicleV2');
	dSourceDatasearch_	:=	project(map(pForHeaderBuild => dataset(lc+'thor_data400::base::vehicles_v2_party_header_building',VehicleV2.Layout_Base.Party_CCPA,flat)
																		,pFastHeader => dataset(lc+'thor_data400::base::vehicles_v2_party_Quickheader_building',VehicleV2.Layout_Base.Party_CCPA,flat)
														,pvehicleSearch(append_did<999999000000)
													),VehicleV2.Layout_Base.Party)
													(lname<>'' and fname<>'' and ace_prim_name<>'')
													;
								
	dSourceDataMain		:=	map(	pForHeaderBuild => dataset(lc+'thor_data400::base::vehicles_v2_main_header_building',VehicleV2.Layout_Base_Main,flat)
														,pFastHeader => dataset(lc+'thor_data400::base::vehicles_v2_main_Quickheader_building',VehicleV2.Layout_Base_Main,flat)
														,pvehicleMain
													)
													(Orig_Vehicle_Type_Code != 'VS')
													;
	
	dSourceDatasearch     := if (pFastHeader, dSourceDatasearch_(ut.DaysApart((STRING8)Std.Date.Today(), ((string)date_vendor_last_reported)[..6] + '01') <= Header.Sourcedata_month.v_fheader_days_to_keep) , dSourceDatasearch_);							
								

	//Exclude infutor data
	dis_srch	:=	distribute(dSourceDatasearch(source_code not in ['1V','2V']),hash(state_origin,vehicle_key,iteration_key,source_code));
	dis_main	:=	distribute(dSourceDataMain(source_code not in ['1V','2V']),hash(state_origin,vehicle_key,iteration_key,source_code));

	src_rec	:=	header.layouts_SeqdSrc.VH_src_rec;
	
	ConvertYYYYMMToNumberOfMonths(integer	pInput)	:=	(((integer)(((string)pInput)[1..4])*12)	+	((integer)(((string)pInput)[5..6])));
	 
	src_rec	getall(dis_srch L,dis_main R)	:=	transform
		self.orig_DOB													:=	if(ConvertYYYYMMToNumberOfMonths((integer)(STRING8)Std.Date.Today()) - ConvertYYYYMMToNumberOfMonths((integer)L.orig_DOB) > 180, L.orig_DOB ,'');
		self.Date_First_Seen									:=	(unsigned3)((string)L.Date_First_Seen)[1..6];
		self.Date_Last_Seen										:=	(unsigned3)((string)L.Date_Last_Seen)[1..6];
		self.Date_Vendor_First_Reported				:=	(unsigned3)((string)L.Date_Vendor_First_Reported)[1..6];
		self.Date_Vendor_Last_Reported				:=	(unsigned3)((string)L.Date_Vendor_Last_Reported)[1..6];
		self.append_clean_name.title					:=	L.title;                                                                                                                      
		self.append_clean_name.fname					:=	L.fname;                                                                                                                      
		self.append_clean_name.mname					:=	L.mname;                                                                                                                      
		self.append_clean_name.lname					:=	L.lname;                                                                                                                      
		self.append_clean_name.name_suffix		:=	L.name_suffix;                                                                                                                      
		self.append_clean_name.name_score			:=	L.name_score; 
		self.append_clean_address.prim_range	:=	L.ace_prim_range;                                                                      
		self.append_clean_address.predir			:=	L.ace_predir;                                                                      
		self.append_clean_address.prim_name		:=	L.ace_prim_name;                                                                      
		self.append_clean_address.addr_suffix	:=  L.ace_addr_suffix;                                                                      
		self.append_clean_address.postdir			:=	L.ace_postdir;                                                                      
		self.append_clean_address.unit_desig	:=	L.ace_unit_desig;                                                                      
		self.append_clean_address.sec_range		:=	L.ace_sec_range;                                                                      
		self.append_clean_address.v_city_name	:=	L.ace_v_city_name;
		self.append_clean_address.st					:=	L.ace_st;
		self.append_clean_address.zip5				:=	L.ace_zip5;
		self.append_clean_address.zip4				:=	L.ace_zip4;
		self.append_clean_address.fips_state	:=	L.ace_fips_state;
		self.append_clean_address.fips_county	:=	L.ace_fips_county;
		self.append_clean_address.geo_lat			:=	L.ace_geo_lat;
		self.append_clean_address.geo_long		:=	L.ace_geo_long;
		self.append_clean_address.cbsa				:=	L.ace_cbsa;
		self.append_clean_address.geo_blk			:=	L.ace_geo_blk;
		self.append_clean_address.geo_match		:=	L.ace_geo_match;
		self.append_clean_address.err_stat		:=	L.ace_err_stat;
		self																	:= r;
		self																	:= l;
		self																	:= [];
	end;

    j	:=	join(	dis_srch,dis_main,
								left.state_origin = right.state_origin 
								and	left.vehicle_key = right.vehicle_key
								and	left.iteration_key = right.iteration_key
								and left.source_code = right.source_code,
								getall(left,right),local
							);

	seed:=if(pFastHeader,999999999999,1);
	header.Mac_Set_Header_Source(j,src_rec,src_rec,vehlic.header_src(l.State_Origin,l.source_code),withID,seed)

	return	withID;
end;