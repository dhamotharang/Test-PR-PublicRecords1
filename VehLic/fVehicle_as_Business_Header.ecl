import business_header,business_header_ss,ut,mdr;

export fVehicle_as_Business_Header(dataset(layout_vehicles) pVehicles)
 :=
  function

	dVehicles	:= pVehicles;
	//Filter IRS Dummy DID's
	dVehiclesWithCompany_ := dVehicles(own_1_did < vehlic.irs_dummy_cutoff
                                             ,own_2_did < vehlic.irs_dummy_cutoff
                                             ,reg_1_did < vehlic.irs_dummy_cutoff
                                             ,reg_2_did < vehlic.irs_dummy_cutoff
	                                         );

	dVehiclesWithCompany			:=	dVehiclesWithCompany_(own_1_company_name <> '' or own_2_company_name <> '' or reg_1_company_name <> '' or reg_2_company_name <> '');

	Layout_vehicle_Local := record
	unsigned6 record_id := 0;
	Layout_Vehicles;
	end;

	// Add unique record id to vehicle file
	Layout_vehicle_Local AddRecordID(Layout_Vehicles L) := transform
	self := L;
	end;

	vehicle_Init := project(dVehiclesWithCompany, AddRecordID(left));

	ut.MAC_Sequence_Records(vehicle_Init, record_id, vehicle_Seq)

	business_header.Layout_Business_Header_New tNormalizeEntities(Layout_vehicle_Local pInput,integer pCounter)
	 :=
	  transform
		self.source 					:=	if(pInput.source_code = 'AE', 'AE', 'MV');
		self.group1_id 					:=	pInput.record_id;
		self.dppa						:=	true;	// vehicles are DPPA, automatically
		self.dt_first_seen 				:=	pInput.dt_first_seen * 100;
		self.dt_last_seen 				:=	pInput.dt_last_seen * 100;
		self.dt_vendor_last_reported  	:=	pInput.dt_vendor_last_reported * 100;
		self.dt_vendor_first_reported 	:=	pInput.dt_vendor_first_reported * 100;
		self.vl_id 					    :=	pInput.orig_state + pInput.vehicle_numberxbg1;
		self.vendor_id 					:=	pInput.orig_state + pInput.vehicle_numberxbg1 + pInput.dt_vendor_last_reported;
		self.prim_range 				:=	choose(pCounter,pInput.own_1_prim_range,pInput.own_2_prim_range,pInput.reg_1_prim_range,pInput.reg_2_prim_range);
		self.predir 					:=	choose(pCounter,pInput.own_1_predir,pInput.own_2_predir,pInput.reg_1_predir,pInput.reg_2_predir);
		self.prim_name 					:=	choose(pCounter,pInput.own_1_prim_name,pInput.own_2_prim_name,pInput.reg_1_prim_name,pInput.reg_2_prim_name);
		self.addr_suffix 				:=	choose(pCounter,pInput.own_1_suffix,pInput.own_2_suffix,pInput.reg_1_suffix,pInput.reg_2_suffix);
		self.postdir 					:=	choose(pCounter,pInput.own_1_postdir,pInput.own_2_postdir,pInput.reg_1_postdir,pInput.reg_2_postdir);
		self.unit_desig 				:=	choose(pCounter,pInput.own_1_unit_desig,pInput.own_2_unit_desig,pInput.reg_1_unit_desig,pInput.reg_2_unit_desig);
		self.sec_range 					:=	choose(pCounter,pInput.own_1_sec_range,pInput.own_2_sec_range,pInput.reg_1_sec_range,pInput.reg_2_sec_range);
		self.city 						:=	choose(pCounter,pInput.own_1_p_city_name,pInput.own_2_p_city_name,pInput.reg_1_p_city_name,pInput.reg_2_p_city_name);
		self.state 						:=	choose(pCounter,pInput.own_1_state_2,pInput.own_2_state_2,pInput.reg_1_state_2,pInput.reg_2_state_2);
		self.zip 						:=	(typeof(self.zip))(choose(pCounter,pInput.own_1_zip5,pInput.own_2_zip5,pInput.reg_1_zip5,pInput.reg_2_zip5));
		self.zip4 						:=	(typeof(self.zip4))(choose(pCounter,pInput.own_1_zip4,pInput.own_2_zip4,pInput.reg_1_zip4,pInput.reg_2_zip4));
		self.county 					:=	choose(pCounter,pInput.own_1_county,pInput.own_2_county,pInput.reg_1_county,pInput.reg_2_county);
		self.msa 						:=	'';
		self.geo_lat 					:=	choose(pCounter,pInput.own_1_geo_lat,pInput.own_2_geo_lat,pInput.reg_1_geo_lat,pInput.reg_2_geo_lat);
		self.geo_long 					:=	choose(pCounter,pInput.own_1_geo_long,pInput.own_2_geo_long,pInput.reg_1_geo_long,pInput.reg_2_geo_long);
		self.current 					:=	if (pInput.history = '', true, false);
		self.phone 						:=	0;
		self.company_name 				:=	choose(pCounter,pInput.own_1_company_name,pInput.own_2_company_name,pInput.reg_1_company_name,pInput.reg_2_company_name);
		self.bdid 						:=	(typeof(self.bdid))(choose(pCounter,pInput.own_1_bdid,pInput.own_2_bdid,pInput.reg_1_bdid,pInput.reg_2_bdid));
	  end
	 ;

	dVehiclesAsBusHdr				:=	normalize(vehicle_Seq,4,tNormalizeEntities(left,counter));

	////only vehicle records that match another record in business headers from a different source 
	// will be allowed in business headers
	bhfile					:= Business_Header.File_Business_Header(source not in ['MV','AE']);

	layout_bh_bdid :=
	record
		bhfile.bdid;
	end;

	bhfilebdid := distribute(table(bhfile, layout_bh_bdid, bdid), bdid);

	layout_vh_bdid :=
	record
		dVehiclesAsBusHdr.bdid;
	end;

	vhfilebdid := table(dVehiclesAsBusHdr(bdid != 0), layout_vh_bdid, bdid);


	dVehiclesAsBusHdrbdid	:= distribute(vhfilebdid, bdid);

	layout_vh_bdid tmatch2BH(dVehiclesAsBusHdrbdid r) :=
	transform
		self := r;
	end;

	dVehiclesMatchBusHdr := join(bhfilebdid
								,dVehiclesAsBusHdrbdid
								,left.bdid = right.bdid
								,tmatch2BH(right)
								,local
								,hash
								);

	business_header.Layout_Business_Header_New tmatchback(dVehiclesAsBusHdr l) :=
	transform
		self := l;
	end;

	dVehiclesMatchBusHdr2 := join(distribute(dVehiclesAsBusHdr(bdid != 0), bdid)
								,distribute(dVehiclesMatchBusHdr, bdid)
								,left.bdid = right.bdid
								,tmatchback(left)
								,local
								,hash
								);
								
	////
	vehicles_clean_rollup := Business_Header.As_Business_Header_Function(dVehiclesMatchBusHdr2, true, true);

	return vehicles_clean_rollup;
	
  end
 ;
