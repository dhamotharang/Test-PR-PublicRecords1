import business_header,ut;

dVehicles	:= VehLic.File_Base_Vehicles_Prod;

rLayoutBusinessContactFullWithType
 :=
  record
	business_header.Layout_Business_Contact_Full;
	string1	temp_name_type_code	:=	'';
  end
 ;

rLayoutBusinessContactFullWithType tNormalizeVehiclesAsBusinessContacts(dVehicles pInput, integer pCounter)
 :=
  transform
	self.source 				:=	'MV';
	self.dppa					:=	true;// vehicles are DPPA, automatically
	self.dt_first_seen 			:=	pInput.dt_first_seen * 100;
	self.dt_last_seen 			:=	pInput.dt_last_seen * 100;
	self.prim_range 			:=	choose(pCounter,pInput.own_1_prim_range,pInput.own_2_prim_range,pInput.reg_1_prim_range,pInput.reg_2_prim_range);
	self.predir 				:=	choose(pCounter,pInput.own_1_predir,pInput.own_2_predir,pInput.reg_1_predir,pInput.reg_2_predir);
	self.prim_name 				:=	choose(pCounter,pInput.own_1_prim_name,pInput.own_2_prim_name,pInput.reg_1_prim_name,pInput.reg_2_prim_name);
	self.addr_suffix 			:=	choose(pCounter,pInput.own_1_suffix,pInput.own_2_suffix,pInput.reg_1_suffix,pInput.reg_2_suffix);
	self.postdir 				:=	choose(pCounter,pInput.own_1_postdir,pInput.own_2_postdir,pInput.reg_1_postdir,pInput.reg_2_postdir);
	self.unit_desig 			:=	choose(pCounter,pInput.own_1_unit_desig,pInput.own_2_unit_desig,pInput.reg_1_unit_desig,pInput.reg_2_unit_desig);
	self.sec_range 				:=	choose(pCounter,pInput.own_1_sec_range,pInput.own_2_sec_range,pInput.reg_1_sec_range,pInput.reg_2_sec_range);
	self.city 					:=	choose(pCounter,pInput.own_1_p_city_name,pInput.own_2_p_city_name,pInput.reg_1_p_city_name,pInput.reg_2_p_city_name);
	self.state 					:=	choose(pCounter,pInput.own_1_state_2,pInput.own_2_state_2,pInput.reg_1_state_2,pInput.reg_2_state_2);
	self.zip 					:=	(typeof(self.zip))(choose(pCounter,pInput.own_1_zip5,pInput.own_2_zip5,pInput.reg_1_zip5,pInput.reg_2_zip5));
	self.zip4 					:=	(typeof(self.zip4))(choose(pCounter,pInput.own_1_zip4,pInput.own_2_zip4,pInput.reg_1_zip4,pInput.reg_2_zip4));
	self.county 				:=	choose(pCounter,pInput.own_1_county,pInput.own_2_county,pInput.reg_1_county,pInput.reg_2_county);
	self.msa 					:=	'';
	self.geo_lat 				:=	choose(pCounter,pInput.own_1_geo_lat,pInput.own_2_geo_lat,pInput.reg_1_geo_lat,pInput.reg_2_geo_lat);
	self.geo_long 				:=	choose(pCounter,pInput.own_1_geo_long,pInput.own_2_geo_long,pInput.reg_1_geo_long,pInput.reg_2_geo_long);
	self.record_type 			:=	if (pInput.history = '', 'C', 'H');
	self.phone 					:=	0;
	self.email_address  		:=	'';
	self.ssn					:=	0;
	self.title					:=	choose(pCounter,pInput.own_1_title,pInput.own_2_title,pInput.reg_1_title,pInput.reg_2_title);
	self.fname 					:=	choose(pCounter,pInput.own_1_fname,pInput.own_2_fname,pInput.reg_1_fname,pInput.reg_2_fname);
	self.mname					:=	choose(pCounter,pInput.own_1_mname,pInput.own_2_mname,pInput.reg_1_mname,pInput.reg_2_mname);
	self.lname					:=	choose(pCounter,pInput.own_1_lname,pInput.own_2_lname,pInput.reg_1_lname,pInput.reg_2_lname);
	self.name_suffix			:=	choose(pCounter,pInput.own_1_name_suffix,pInput.own_2_name_suffix,pInput.reg_1_name_suffix,pInput.reg_2_name_suffix);
	self.name_score				:=	business_header.CleanName(self.fname,self.mname,self.lname,self.name_suffix)[142];
	self.vendor_id 				:=	pInput.orig_state + pInput.vehicle_numberxbg1 + pInput.dt_vendor_last_reported;
	self.company_title  		:=	'';
	self.company_department 	:=	'';
	self.company_source_group	:=	''; // Source group
	self.company_name 			:=	choose(pCounter,pInput.own_1_company_name,pInput.own_2_company_name,pInput.reg_1_company_name,pInput.reg_2_company_name);
	self.company_prim_range 	:=	self.prim_range;
	self.company_predir 		:=	self.predir;
	self.company_prim_name 		:=	self.prim_name;
	self.company_addr_suffix 	:=	self.addr_suffix;
	self.company_postdir 		:=	self.postdir;
	self.company_unit_desig 	:=	self.unit_desig;
	self.company_sec_range 		:=	self.sec_range;
	self.company_city 			:=	self.city;
	self.company_state 			:=	self.state;
	self.company_zip 			:=	self.zip;
	self.company_zip4 			:=	self.zip4;
	self.company_phone 			:=	0;
	self.company_fein 			:=	0;
	self.bdid 					:=	(typeof(self.bdid))(choose(pCounter,pInput.own_1_bdid,pInput.own_2_bdid,pInput.reg_1_bdid,pInput.reg_2_bdid));
	self.temp_name_type_code	:=	choose(pCounter,'O','O','R','R');
  end
 ;

dVehiclesWithCompany			:=	dVehicles(own_1_company_name <> '' or own_2_company_name <> '' or reg_1_company_name <> '' or reg_2_company_name <> '');
dVehiclesAsBusCon				:=	project(dVehiclesWithCompany,tNormalizeVehiclesAsBusinessContacts(left,counter));
dVehiclesAsBusConDist			:=	distribute(dVehiclesAsBusCon,hash(vendor_id));
dVehiclesAsBusConPersons		:=	dVehiclesAsBusConDist(lname != '', company_name = '', (integer)name_score < 3);
dVehiclesAsBusConCompanies		:=	dVehiclesAsBusConDist(company_name != '' and company_name[01..09] != 'VAULT NOM' and company_name[01..16] != 'VAULT AS NOMINEE');

business_header.Layout_Business_Contact_Full tGetMatchingCompany(dVehiclesAsBusConPersons pPerson, dVehiclesAsBusConCompanies pCompany)
 :=
  transform
	self.company_name 			:=	pCompany.company_name;
	self.company_prim_range		:=	pCompany.company_prim_range;
	self.company_predir 		:=	pCompany.company_predir;
	self.company_prim_name		:=	pCompany.company_prim_name;
	self.company_addr_suffix	:=	pCompany.company_addr_suffix;
	self.company_postdir		:=	pCompany.company_postdir;
	self.company_unit_desig		:=	pCompany.company_unit_desig;
	self.company_sec_range		:=	pCompany.company_sec_range;
	self.company_city			:=	pCompany.company_city;
	self.company_state			:=	pCompany.company_state;
	self.company_zip			:=	pCompany.company_zip;
	self.company_zip4			:=	pCompany.company_zip4;
	self 						:=	pPerson;
  end
 ;

dContactsWithMatchingCompany	:=	join(dVehiclesAsBusConPersons,dVehiclesAsBusConCompanies,
										 left.vendor_id 			= right.vendor_id
									 and left.temp_name_type_code 	= right.temp_name_type_code,
										 tGetMatchingCompany(left,right),
										 local
										);

dContactsOnlySort				:=	sort(dContactsWithMatchingCompany,vendor_id,lname,company_name,local);
dContactsOnlyDedup				:=	dedup(dContactsOnlySort,vendor_id,lname,company_name,local);

// match on vendor id and company name to as bus header file to make sure these contacts have a company record
// that made it to business headers

asbus := vehlic.Vehicle_as_Business_Header;

business_header.Layout_Business_Contact_Full matchtoasbus(dContactsOnlyDedup L, asbus R) := transform
self.vendor_id := R.vendor_id;
self := L;
end;

dContactsWithMatchingAsBus	:=	join(dContactsOnlyDedup,asbus,
										left.vendor_id = right.vendor_id,
										 matchtoasbus(left,right),
										 local
										);

export Vehicle_as_Business_Contact
 :=	dContactsWithMatchingAsBus((integer)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix))
 :	persist('persist::bushdr_vehicles_as_bus_con')
 ;
