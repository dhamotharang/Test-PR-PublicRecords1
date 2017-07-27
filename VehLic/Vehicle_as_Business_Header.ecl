import business_header,business_header_ss,ut,mdr;



dVehicles	:= VehLic.File_Base_Vehicles_Prod;
dVehiclesWithCompany			:=	dVehicles(own_1_company_name <> '' or own_2_company_name <> '' or reg_1_company_name <> '' or reg_2_company_name <> '');

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

business_header.Layout_Business_Header tNormalizeEntities(Layout_vehicle_Local pInput,integer pCounter)
 :=
  transform
	self.source 					:=	'MV';
	self.group1_id 				:=	pInput.record_id;
	self.dppa						:=	true;	// vehicles are DPPA, automatically
	self.dt_first_seen 				:=	pInput.dt_first_seen * 100;
	self.dt_last_seen 				:=	pInput.dt_last_seen * 100;
	self.dt_vendor_last_reported  	:=	pInput.dt_vendor_last_reported * 100;
	self.dt_vendor_first_reported 	:=	pInput.dt_vendor_first_reported * 100;
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

vehicles_clean_rollup := Business_Header.As_Business_Header_Function(dVehiclesAsBusHdr);


export Vehicle_as_Business_Header
 :=	vehicles_clean_rollup
 :	persist('persist::bushdr_vehicles_as_bus_hdr')
 ;













