//#workunit('name', 'VehicleLien Append')
//**** notes ****/

//there is underlinking issue in the old sequence_key, the owner and lien holder has the same title 
//number and title issue date but different date_vendor_last_reported, they should be linked

//the new sequence_key link all multiple owners with different address and lien holder info, these were not well applied for 
// FDS layout when denormalized
// good solution to combine both, the old + the new (not linked in the old)
// the file based on the old keys was renamed as '~thor_data400::fds::VehicleV2::veh_combine_liens_20100224' on PROD'
// the file based on the new keys need rebuild
import ut, wma,address;

cluster := ut.foreign_prod;
dAssetsin := dataset(ut.foreign_dataland + 'thor_data400::persist::fds_asset_clean_did_bdid', wma.Layout_vehicle_FDS.fdslayout, flat);											

//veh_combine_lien := dataset(cluster + 'thor_data400::persist::VehicleV2::veh_lien_combine_fds', wma.Layout_vehicle_FDS.veh_slim_rec, flat);

veh_combine_lien := dataset(cluster +'thor_data400::persist::VehicleV2::veh_combine_liens_fds', wma.Layout_vehicle_FDS.veh_slim_rec, flat)(orig_name_type = '1');
veh_lien := dataset(cluster +'thor_data400::persist::VehicleV2::veh_combine_liens_fds', wma.Layout_vehicle_FDS.veh_slim_rec, flat)(orig_name_type = '7' );

veh_lien_DI := veh_lien(source_code = 'DI');

wma.Layout_vehicle_FDS.veh_slim_rec cleanOut(veh_lien_DI l):= transform
	tempCName:= datalib.companyclean(l.orig_name);
	tempAddr := Address.CleanAddress182(trim(l.orig_address),address.Addr2FromComponents(l.orig_city,l.orig_state,l.orig_zip));
	self.Append_Clean_CName 		:= tempCName;
	self.prim_range 	:= tempAddr[1..10];
	self.predir 		:= tempAddr[11..12];
	self.prim_name 		:= tempAddr[13..40];
	self.addr_suffix			:= tempAddr[41..44];
	self.postdir 		:= tempAddr[45..46];
	self.unit_desig 	:= tempAddr[47..56];
	self.sec_range 		:= tempAddr[57..64];
	self.v_city_name			:= tempAddr[65..89];
	self.st 			:= tempAddr[115..116];
	self.zip5 			:= tempAddr[117..121];
	self := l;
end;

fdsClean_DI := project(veh_lien_DI, cleanOut(left));

veh_combine_lien1 := fdsClean_DI + veh_lien(~source_code = 'DI');


veh_owner := project(veh_combine_lien,transform(wma.Layout_vehicle_FDS.veh_slim_rec, self.VINA_VIN := trim(if(left.vina_vin <> '', left.vina_vin, left.orig_vin),left, right),
self.Orig_SSN := if(left.Orig_SSN <> '', left.Orig_SSN, left.append_ssn), 
self.append_clean_cname := datalib.companyclean(left.append_clean_cname),
self.reg_license_state := if(left.reg_license_state <> '', left.reg_license_state, left.st), self := left));

veh_owner_dist := distribute(veh_owner, hash(Vehicle_Key, iteration_key, Sequence_Key));

veh_owner_dist tjoinowners(veh_owner_dist le, veh_combine_lien1 ri) := transform

//self.record_id := ri.record_id;
self := le;

end;

veh_combine := dedup(join(veh_owner_dist, distribute(veh_combine_lien1, hash(Vehicle_Key, iteration_key, Sequence_Key)),left.vehicle_key	=	right.vehicle_key and
																		left.sequence_key	=	right.sequence_key and
                                                                        left.iteration_key   = right.iteration_key, tjoinowners(left, right), local),all,local);
																		
veh_append_temp_rec := record
string record_id;
veh_combine;
end;

//**********VIN match

assets_VIN := dAssetsIn(VIN <> '');

veh_append_temp_rec tjoinVIN( veh_combine le, dAssetsIn ri) := transform

self.record_id := ri.record_id;
self := le;

end;

Veh_VIN := join(veh_combine(VINA_vin <> ''), assets_VIN, left.VINa_vin = trim(right.VIN,left,right),tjoinVIN(left, right), lookup);

Veh_VIN_dist := distribute(Veh_VIN, hash(VINa_vin));
veh_VIN_dedup := dedup(sort(Veh_VIN_dist,VINa_vin,local),vina_vin,local);

out1 := output(veh_VIN_dedup,named('VIN_match'),all);
out2 := output((count(veh_VIN_dedup)/count(assets_VIN))*100, named('VIN_match_rate'));

//***********************SSN only 
//SSN with ADLs
assets_ssn_only := dAssetsIn(ssn <> '' and last_name = '');

veh_append_temp_rec tjoinssnDID1(veh_combine le, dAssetsIn ri) := transform

self.record_id := ri.record_id;
self := le;

end;

Veh_combine_ssn_did := join(veh_combine(append_did > 0), assets_ssn_only(ssn_did > 0), left.append_did = right.ssn_did,tjoinssndid1(left, right), lookup);

Veh_ssn_did_dist := distribute(Veh_combine_ssn_did, hash(append_did));
veh_ssn_did_dedup := dedup(sort(Veh_ssn_did_dist,append_did,local),append_did,local);

//SSN without ADLs

veh_append_temp_rec tjoinssn1(veh_combine le, assets_ssn_only ri) := transform

self.record_id := ri.record_id;
self := le;

end;

Veh_combine_ssn := join(veh_combine(orig_ssn <> ''), assets_ssn_only(ssn_did = 0), left.orig_ssn = right.ssn,tjoinssn1(left, right), lookup);

Veh_ssn_dist := distribute(Veh_combine_ssn, hash(orig_ssn));
veh_ssn_dedup := dedup(sort(Veh_ssn_dist,orig_ssn,local),orig_ssn,local);

out7 := output(veh_ssn_did_dedup + veh_ssn_dedup,named('ssn_did_only_match'),all);
out8 := output((count(veh_ssn_did_dedup + veh_ssn_dedup)/count(assets_ssn_only))*100, named('SSN_did_only_match_rate'));

//*************************full SSN + name 

//full SSN + name with ADLs
assets_name_fssn := dAssetsIn(length(ssn) = 9 and last_name <> ''  );

veh_append_temp_rec tjoinfssnDID1(veh_combine le, dAssetsIn ri) := transform

self.record_id := ri.record_id;
self := le;

end;

Veh_combine_fssn_did := join(veh_combine(append_did > 0), assets_name_fssn(ssn_did >0), left.append_did = right.ssn_did ,tjoinfssndid1(left, right), lookup);

Veh_fssn_did_dist := distribute(Veh_combine_fssn_did, hash(append_did));
veh_fssn_did_dedup := dedup(sort(Veh_fssn_did_dist,append_did,local),append_did,local);

//full SSN + name without ADLs
Veh_append_temp_rec tjoinfssn1(veh_combine le, dAssetsIn ri) := transform

self.record_id := ri.record_id;
self := le;

end;

Veh_combine_fssn := join(veh_combine(length(orig_ssn) = 9 and lname <> ''), assets_name_fssn(ssn_did = 0), left.orig_ssn = right.ssn and left.fname = right.first_name
 and left.mname = right.middle_name and left.lname = right.last_name ,tjoinfssn1(left, right), lookup);

Veh_fssn_dist := distribute(Veh_combine_fssn, hash(fname,lname,orig_ssn));
veh_fssn_dedup := dedup(sort(Veh_fssn_dist,fname,lname,orig_ssn,mname,local),fname,lname,orig_ssn,mname,local);

out9 := output(veh_fssn_dedup + veh_fssn_did_dedup,named('full_ssn_name_match'),all);
out10 := output((count(veh_fssn_dedup + veh_fssn_did_dedup)/count(assets_name_fssn))*100, named('full_SSN_name_match_rate'));

//****************partial SSN + name 

assets_name_pssn := dAssetsIn(last_name <> '' and length(ssn) between 1 and 8);

veh_append_temp_rec tjoinpssn1(veh_combine le, dAssetsIn ri) := transform

self.record_id := ri.record_id;
self := le;

end;

Veh_combine_pssn := join(veh_combine((unsigned)orig_ssn >0 and lname <> ''), assets_name_pssn, left.orig_ssn[6..9] = right.ssn and left.fname = right.first_name
 and left.mname = right.middle_name and left.lname = right.last_name,tjoinpssn1(left, right), lookup);

Veh_pssn_dist := distribute(Veh_combine_pssn, hash(orig_ssn[6..9], lname,fname));
veh_pssn_dedup := dedup(sort(Veh_pssn_dist,orig_ssn[6..9], lname,fname,mname,local),orig_ssn[6..9], lname,fname,mname,local);

out11 := output(veh_pssn_dedup,named('partial_ssn_match'),all);
out12 := output((count(veh_pssn_dedup)/count(assets_name_pssn))*100, named('partial_SSN_match_rate'));


//********************name + complete address 

//name + complete address with ADLs
Assets_name_addr := dAssetsIn(orig_name <> '' and orig_address <> '' );

veh_append_temp_rec tjoinnmAddrdid1(veh_combine le, Assets_name_addr ri) := transform

self.record_id := ri.record_id;
self := le;

end;

Veh_combine_nmAddr_did:= join(veh_combine(append_did > 0), Assets_name_addr(addr_did > 0), left.append_did = right.addr_did,tjoinnmaddrdid1(left, right), lookup);

Veh_nmAddr_did_dist := distribute(Veh_combine_nmAddr_did, hash(append_did));
veh_nmAddr_did_dedup := dedup(sort(Veh_nmAddr_did_dist,append_did,local),append_did,local);


//name + complete address without adls

veh_append_temp_rec tjoinnmaddr1(veh_combine le, Assets_name_addr ri) := transform

self.record_id := ri.record_id;
self := le;

end;

Veh_combine_nmAddr:= join(veh_combine(lname <> '' and fname <> '' and prim_name <> ''), Assets_name_addr(addr_did = 0), left.lname = right.last_name and
left.fname = right.first_name and left.mname = right.middle_name and left.prim_range = right.prim_range and left.prim_name = right.prim_name 
and left.sec_range = right.sec_range and left.v_city_name = right.city and left.st = right.state and left.zip5 = right.zip,tjoinnmaddr1(left, right), lookup);

Veh_nmaddr_dist := distribute(Veh_combine_nmAddr, hash(lname, fname, mname,prim_range, prim_name, sec_range,st, zip5));
veh_nmaddr_dedup := dedup(sort(Veh_nmaddr_dist,lname, fname, mname,prim_range, prim_name, sec_range, st, zip5,v_city_name,local),lname, fname, mname,prim_range, prim_name, sec_range, st, zip5,v_city_name,local);

out13 := output(veh_nmAddr_dedup + veh_nmAddr_did_dedup,all,named('name_addr_match'),all);
out14 := output((count(veh_nmAddr_dedup + veh_nmAddr_did_dedup)/count(Assets_name_addr))*100, named('name_addr_match_rate'));

//********************name + zip 

Assets_name_zip := dAssetsIn(orig_name <> '' , orig_state = '', orig_city = '', orig_zip <> '');

veh_append_temp_rec tjoinnmzip1(veh_combine le, Assets_name_zip ri) := transform

self.record_id := ri.record_id;
self := le;

end;

Veh_combine_nmzip:= join(veh_combine(orig_name <> '' and zip5 <> ''), Assets_name_zip, left.fname = right.first_name
 and left.mname = right.middle_name and left.lname = right.last_name and left.zip5 = right.orig_zip,tjoinnmzip1(left, right), lookup);

Veh_nmzip_dist := distribute(Veh_combine_nmzip, hash(fname, lname,zip5));
veh_nmzip_dedup := dedup(sort(Veh_nmzip_dist,fname, lname,zip5,mname,local),fname, lname,zip5,mname,local);


out15 := output(veh_nmzip_dedup,all,named('name_zip_match'),all);
out16 := output((count(veh_nmzip_dedup)/count(Assets_name_zip))*100, named('name_zip_match_rate'));


//********************name + state address 

Assets_name_st := dAssetsIn(orig_name <> '' , orig_state <> '', orig_city = '', orig_zip = '');

veh_append_temp_rec tjoinnmst1(veh_combine le, Assets_name_st ri) := transform

self.record_id := ri.record_id;
self := le;

end;

Veh_combine_nmst:= join(veh_combine(orig_name <> '',st<> ''), Assets_name_st, left.fname = right.first_name
 and left.mname = right.middle_name and left.lname = right.last_name and left.st = right.orig_state,tjoinnmst1(left, right), lookup);

Veh_nmst_dist := distribute(Veh_combine_nmst, hash(fname,lname,st));
veh_nmst_dedup := dedup(sort(Veh_nmst_dist,fname, lname,st,mname,local),fname, lname,st,mname,local);

out17 := output(veh_nmst_dedup,all,named('name_st_match'),all);
out18 := output((count(veh_nmst_dedup)/count(Assets_name_st))*100, named('name_st_match_rate'));

//********************business name + complete address 

//business name + complete address with ADLs
Assets_Bus_name_addr:= dAssetsIn(orig_business_name <> '' and orig_address <> '' );

veh_append_temp_rec tjoinbusaddrDID1(veh_combine le, Assets_Bus_name_addr ri) := transform

self.record_id := ri.record_id;
self := le;

end;

Veh_combine_bus_addr_DID:= join(veh_combine(append_bdid > 0), Assets_Bus_name_addr(bdid > 0), left.append_bdid = right.bdid,tjoinbusaddrDID1(left, right), lookup);

Veh_bus_addr_DID_dist := distribute(Veh_combine_bus_addr_DID, hash(append_bdid));
veh_bus_addr_DID_dedup := dedup(sort(Veh_bus_addr_DID_dist,append_bdid,local),append_bdid,local);


//business name + complete address without adls

veh_append_temp_rec tjoinbusaddr1(veh_combine le, Assets_Bus_name_addr ri) := transform

self.record_id := ri.record_id;
self := le;

end;

Veh_combine_bus_addr:= join(veh_combine(append_clean_cname <> ''), Assets_Bus_name_addr(bdid = 0), left.append_clean_cname = right.comp_name and left.prim_range = right.prim_range
and left.prim_name = right.prim_name and left.sec_range = right.sec_range and left.v_city_name = right.city and left.st = right.state and left.zip5 = right.zip,tjoinbusaddr1(left, right), lookup);

Veh_bus_addr_dist := distribute(Veh_combine_bus_addr, hash(append_clean_cname,prim_range, prim_name, sec_range,st, zip5));
veh_bus_addr_dedup := dedup(sort(Veh_bus_addr_dist,append_clean_cname,prim_range, prim_name, sec_range, st, zip5,v_city_name,local),append_clean_cname,prim_range, prim_name, sec_range, st, zip5,v_city_name,local);

out19 := output(veh_bus_addr_dedup + veh_bus_addr_DID_dedup,named('bus_name_addr_match'),all);
out20 := output((count(veh_bus_addr_dedup + veh_bus_addr_DID_dedup)/count(Assets_Bus_name_addr))*100, named('bus_name_addr_match_rate'));


//********************business name + city + state

Assets_Bus_name_paddr:= dAssetsIn(orig_business_name <> '' and orig_city <> '' and orig_address = '');

veh_append_temp_rec tjoinbuspaddr1(veh_combine le, Assets_Bus_name_addr ri) := transform

self.record_id := ri.record_id;
self := le;

end;

Veh_combine_bus_paddr:= join(veh_combine(append_clean_cname <> '' and st <> '' and v_city_name <> ''), Assets_Bus_name_paddr, left.append_clean_cname = right.comp_name and
left.v_city_name = right.orig_city and left.st = right.orig_state,tjoinbuspaddr1(left, right), lookup);

Veh_bus_paddr_dist := distribute(Veh_combine_bus_paddr, hash(append_clean_cname,st,v_city_name));
veh_bus_paddr_dedup := dedup(sort(Veh_bus_paddr_dist,append_clean_cname,st,v_city_name,local),append_clean_cname,st,v_city_name,local);

out21 := output(veh_bus_paddr_dedup,named('bus_name_partial_addr_match'),all);
out22 := output((count(veh_bus_paddr_dedup)/count(Assets_Bus_name_paddr))*100, named('bus_name_partial_addr_match_rate'));

//********************address only

Assets_addr:= dAssetsIn(orig_business_name = '' and orig_name = '' and orig_address <> '');

veh_append_temp_rec tjoinAddr1(veh_combine le, Assets_addr ri) := transform

self.record_id := ri.record_id;
self := le;

end;
	
Veh_combine_addr:= join(veh_combine(prim_name <> ''), Assets_addr, left.prim_range = right.prim_range
and left.predir = right.predir and left.prim_name = right.prim_name and left.addr_suffix = right.suffix and left.postdir = right.postdir
and  left.unit_desig = right.unit_desig and left.sec_range = right.sec_range and left.v_city_name = right.city and left.st = right.state and left.zip5 = right.zip,
tjoinAddr1(left, right), lookup);

Veh_addr_dist := distribute(Veh_combine_addr, hash(prim_range, prim_name, sec_range,st, zip5));
veh_addr_dedup := dedup(sort(Veh_addr_dist,prim_range, prim_name, sec_range, st, zip5,v_city_name,local),prim_name, sec_range, st, zip5,v_city_name,local);

out23 := output(veh_addr_dedup,named('addr_only_match'),all);
out24 := output((count(veh_addr_dedup)/count(Assets_addr))*100, named('addr_only_match_rate'));


//************************Combine Files*****
//matchFiles := Veh_VIN + Veh_lic + Veh_lic_st + Veh_ssn_did + Veh_fssn + Veh_pssn + Veh_name_addr + veh_name_st + veh_name_zip + Veh_bus_addr + Veh_bus_paddr + Veh_addr;

//************************Combine Files*****
matchFiles := Veh_VIN + Veh_combine_ssn_did + Veh_combine_ssn + Veh_combine_fssn_did +Veh_combine_fssn + Veh_combine_pssn + 
Veh_combine_nmaddr_did + Veh_combine_nmaddr + veh_combine_nmst + veh_combine_nmzip + Veh_combine_bus_addr_did + Veh_combine_bus_addr + Veh_combine_bus_paddr + Veh_combine_addr;

//expand vehicle file

//finding the liens

matchFiles_dist := distribute(matchFiles, hash(Vehicle_Key, iteration_key, Sequence_Key));

veh_append_temp_rec tjoinliens(veh_combine_lien1 le, matchFiles_dist ri) := transform

self.record_id := ri.record_id;
self := le;

end;


append_liens := dedup(join(distribute(veh_combine_lien1, hash(Vehicle_Key, iteration_key, Sequence_Key)), matchFiles_dist,left.vehicle_key	=	right.vehicle_key and
																		left.sequence_key	=	right.sequence_key and
                                                                        left.iteration_key   = right.iteration_key, tjoinliens(left, right), local),all,local);

owner_liens := distribute(matchFiles_dist + append_liens, hash(Vehicle_Key, iteration_key, Sequence_Key, record_id));

owner_liens_sort := sort(owner_liens, Vehicle_Key, iteration_key, Sequence_Key, record_id, -Date_Vendor_Last_Reported,-Orig_Lien_Date,-Ttl_Latest_Issue_Date,local);
																																				
wma.Layout_vehicle_FDS.liens.vehicles_temp_rec textracttemp(owner_liens le)	:=
transform

   // self.vehicle_make_code         := le.Orig_Make_Code;
	self.vehicle_make_description  := if(le.VINA_Make_Desc <> '',le.VINA_Make_Desc, le.Orig_Make_Desc);  
	//self.vehicle_model_code        := le.Orig_Model_Code;
	self.vehicle_model_description := if(le.VINA_Model_Desc <> '',le.VINA_Model_Desc, le.Orig_Model_Desc);  
	//self.license_plate_number      := if(Le.reg_true_license_plate <> '', Le.reg_true_license_plate, if(Le.Reg_License_Plate <> '',Le.Reg_License_Plate, le.Reg_Previous_License_Plate));  
    //self.license_plate_state       := if(Le.state_origin <> '', Le.state_origin, if(Le.st <> '',Le.st, le.Reg_License_State));  
    self.VIN                       := if(Le.VINA_vin <> '',Le.VINA_vin, le.Orig_VIN); 
	self	:=	le;
	self	:=	[];
end;

matchfiles_temp		:=	project(owner_liens, textracttemp(left));

matchfiles_temp_sort	:=	sort(matchfiles_temp, vehicle_key, iteration_key,sequence_key,record_id, -Date_Vendor_Last_Reported,-Orig_Lien_Date,-Ttl_Latest_Issue_Date,local);
matchfiles_temp_dedup	:=	dedup(matchfiles_temp_sort, vehicle_key, iteration_key,sequence_key,record_id,local);
//denormalize name & address
wma.Layout_vehicle_FDS.liens.vehicles_temp_rec tdenorm(matchfiles_temp_dedup le, owner_liens_sort ri) := transform

  
	boolean	isBlankLien1			:=	le.lien_holder1_lname = '' and le.lien_holder1_cname = '';
	
	boolean	isBlankLien2		:=	le.lien_holder2_lname = '' and le.lien_holder2_cname ='';
	boolean	isBlankLien3		:=	le.lien_holder3_lname = '' and le.lien_holder3_cname ='';
    boolean	isBlankOwner1				:=	le.owner1_lname = '' and le.owner1_cname = '';
	
	boolean	isBlankOwner2		:=	le.owner2_lname = '' and le.owner2_cname = '';
   self.owner1_fname		:=	if(	ri.orig_name_type = '1' and isBlankOwner1,
																		ri.fname,
																		le.owner1_fname
																	);
	self.owner1_lname		:=	if(	ri.orig_name_type = '1' and isBlankOwner1,
																		ri.lname,
																		le.owner1_lname
																	);
	self.owner1_mname		:=	if(	ri.orig_name_type = '1' and isBlankOwner1,
																		ri.mname,
																		le.owner1_mname
																	);
	self.owner1_cname	   :=	if(	ri.orig_name_type = '1' and isBlankOwner1,
																		ri.Append_Clean_CName,
																		le.owner1_cname
	
																);
																
	self.owner1_street1 :=	if(	ri.orig_name_type = '1' and isBlankOwner1,
															trim(Address.Addr1FromComponents(ri.prim_range
                                                                                            ,ri.predir
                                                                                            ,ri.prim_name
                                                                                            ,ri.addr_suffix
                                                                                            ,ri.postdir
                                                                                        ,'',''),left,right),
																		le.owner1_street1);
	self.owner1_street2 :=	if(	ri.orig_name_type = '1' and isBlankOwner1,
															trim(Address.Addr1FromComponents(ri.unit_desig
                                                                                            ,ri.sec_range
                                                                                            ,''
                                                                                            ,''
                                                                                            ,''
                                                                                            ,''
                                                                                            ,''),left,right),	
																		                    le.owner1_street2);
	self.owner1_city := if(ri.orig_name_type = '1' and isBlankOwner1, ri.v_city_name, le.owner1_city);
    self.owner1_state := if(ri.orig_name_type = '1' and isBlankOwner1, ri.st, le.owner1_state );
    self.owner1_zip := if(ri.orig_name_type = '1' and isBlankOwner1, ri.zip5, le.owner1_zip );														
														
	self.owner2_fname		:=	if(	ri.orig_name_type = '1' and ~isBlankOwner1 and isblankowner2,
																		ri.fname,
																		le.owner2_fname
																	);
	self.owner2_lname		:=	if(	ri.orig_name_type = '1' and ~isBlankOwner1 and isblankowner2,
																		ri.lname,
																		le.owner2_lname
																	);
	self.owner2_mname		:=	if(	ri.orig_name_type = '1' and ~isBlankOwner1 and isblankowner2,
																		ri.mname,
																		le.owner2_mname
																	);
	self.owner2_cname	   :=	if(	ri.orig_name_type = '1' and ~isBlankOwner1 and isblankowner2,
																		ri.Append_Clean_CName,
																		le.owner2_cname
																		);
	self.owner2_street1 :=	if(	ri.orig_name_type = '1' and ~isBlankOwner1 and isblankowner2,
															trim(Address.Addr1FromComponents(ri.prim_range
                                                                                            ,ri.predir
                                                                                            ,ri.prim_name
                                                                                            ,ri.addr_suffix
                                                                                            ,ri.postdir
                                                                                        ,'',''),left,right),
																		le.owner2_street1);
	self.owner2_street2 :=	if(	ri.orig_name_type = '1' and ~isBlankOwner1 and isblankowner2,
															trim(Address.Addr1FromComponents(ri.unit_desig
                                                                                            ,ri.sec_range
                                                                                            ,''
                                                                                            ,''
                                                                                            ,''
                                                                                            ,''
                                                                                            ,''),left,right),	
																		                    le.owner2_street2);
	self.owner2_city := if(ri.orig_name_type = '1' and ~isBlankOwner1 and isblankowner2, ri.v_city_name, le.owner2_city);
    self.owner2_state := if(ri.orig_name_type = '1' and ~isBlankOwner1 and isblankowner2, ri.st, le.owner2_state );
    self.owner2_zip := if(ri.orig_name_type = '1' and ~isBlankOwner1 and isblankowner2, ri.zip5, le.owner2_zip );	
	
   self.lien_holder1_fname		:=	if(	ri.orig_name_type = '7' and isBlankLien1,
																		ri.fname,
																		le.lien_holder1_fname
																	);
	self.lien_holder1_lname		:=	if(	ri.orig_name_type = '7' and isBlankLien1,
																		ri.lname,
																		le.lien_holder1_lname
																	);
	self.lien_holder1_mname		:=	if(	ri.orig_name_type = '7' and isBlankLien1,
																		ri.mname,
																		le.lien_holder1_mname
																	);
	self.lien_holder1_cname	   :=	if(	ri.orig_name_type = '7' and isBlankLien1,
																		ri.Append_Clean_CName,
																		le.lien_holder1_cname
																		);
   
   self.lien_holder1_street1 :=	if(	ri.orig_name_type = '7' and isBlankLien1, 
   trim(Address.Addr1FromComponents(ri.prim_range
                                                                                            ,ri.predir
                                                                                            ,ri.prim_name
                                                                                            ,ri.addr_suffix
                                                                                            ,ri.postdir
                                                                                        ,'',''),left,right),
																		le.lien_holder1_street1);
self.lien_holder1_street2 :=	if(	ri.orig_name_type = '7' and isBlankLien1,
															trim(Address.Addr1FromComponents(ri.unit_desig
                                                                                            ,ri.sec_range
                                                                                            ,''
                                                                                            ,''
                                                                                            ,''
                                                                                            ,''
                                                                                            ,''),left,right),	
															le.lien_holder1_street2);
self.lien_holder1_city := if(ri.orig_name_type = '7' and isBlankLien1, ri.v_city_name, le.lien_holder1_city);
self.lien_holder1_state := if(ri.orig_name_type = '7' and isBlankLien1, ri.st, le.lien_holder1_state );
self.lien_holder1_zip := if(ri.orig_name_type = '7' and isBlankLien1, ri.zip5, le.lien_holder1_zip );	
   
   
   self.lien_holder2_fname		:=	if(	ri.orig_name_type = '7' and ~isBlankLien1 and isBlankLien2,
																		ri.fname,
																		le.lien_holder2_fname
																	);
	self.lien_holder2_lname		:=	if(	ri.orig_name_type = '7' and ~isBlankLien1 and isBlankLien2,
																		ri.lname,
																		le.lien_holder2_lname
																	);
	self.lien_holder2_mname		:=	if(	ri.orig_name_type = '7' and ~isBlankLien1 and isBlankLien2,
																		ri.mname,
																		le.lien_holder2_mname
																	);
	self.lien_holder2_cname	   :=	if(	ri.orig_name_type = '7' and ~isBlankLien1 and isBlankLien2,
																		ri.Append_Clean_CName,
																		le.lien_holder2_cname
																		);
   
   
   self.lien_holder2_street1 :=	if(	ri.orig_name_type = '7' and ~isBlankLien1 and isBlankLien2, 
                                                             trim(Address.Addr1FromComponents(ri.prim_range
                                                                                            ,ri.predir
                                                                                            ,ri.prim_name
                                                                                            ,ri.addr_suffix
                                                                                            ,ri.postdir
                                                                                        ,'',''),left,right),	
															le.lien_holder2_street1);
self.lien_holder2_street2 :=	if(	ri.orig_name_type = '7' and ~isBlankLien1 and isBlankLien2,
															trim(Address.Addr1FromComponents(ri.unit_desig
                                                                                            ,ri.sec_range
                                                                                            ,''
                                                                                            ,''
                                                                                            ,''
                                                                                            ,''
                                                                                            ,''),left,right),	
															le.lien_holder2_street2);
self.lien_holder2_city := if(ri.orig_name_type = '7' and ~isBlankLien1 and isBlankLien2, ri.v_city_name, le.lien_holder2_city);
self.lien_holder2_state := if(ri.orig_name_type = '7' and ~isBlankLien1 and isBlankLien2, ri.st, le.lien_holder2_state );
self.lien_holder2_zip := if(ri.orig_name_type = '7' and ~isBlankLien1 and isBlankLien2, ri.zip5, le.lien_holder2_zip );	
   
   
   self.lien_holder3_fname		:=	if(	ri.orig_name_type = '7' and ~isblanklien1 and ~isBlankLien2 and isBlankLien3,
																		ri.fname,
																		le.lien_holder3_fname
																	);
	self.lien_holder3_lname		:=	if(	ri.orig_name_type = '7' and ~isblanklien1 and ~isBlankLien2 and isBlankLien3,
																		ri.lname,
																		le.lien_holder3_lname
																	);
	self.lien_holder3_mname		:=	if(	ri.orig_name_type = '7' and ~isblanklien1 and ~isBlankLien2 and isBlankLien3,
																		ri.mname,
																		le.lien_holder3_mname
																	);
	self.lien_holder3_cname	   :=	if(	ri.orig_name_type = '7' and ~isblanklien1 and ~isBlankLien2 and isBlankLien3,
																		ri.Append_Clean_CName,
																		le.lien_holder3_cname
																		);
   
   self.lien_holder3_street1 :=	if(	ri.orig_name_type = '7' and ~isblanklien1 and ~isBlankLien2 and isBlankLien3, 
                                                            trim(Address.Addr1FromComponents(ri.prim_range
                                                                                            ,ri.predir
                                                                                            ,ri.prim_name
                                                                                            ,ri.addr_suffix
                                                                                            ,ri.postdir
                                                                                        ,'',''),left,right),
															le.lien_holder3_street1);
self.lien_holder3_street2 :=	if(	ri.orig_name_type = '7' and ~isblanklien1 and ~isBlankLien2 and isBlankLien3,
															trim(Address.Addr1FromComponents(ri.unit_desig
                                                                                            ,ri.sec_range
                                                                                            ,''
                                                                                            ,''
                                                                                            ,''
                                                                                            ,''
                                                                                            ,''),left,right),	
															le.lien_holder3_street2);
self.lien_holder3_city := if(ri.orig_name_type = '7' and ~isblanklien1 and ~isBlankLien2 and isBlankLien3, ri.v_city_name, le.lien_holder3_city);
self.lien_holder3_state := if(ri.orig_name_type = '7' and ~isblanklien1 and ~isBlankLien2 and isBlankLien3 ,ri.st, le.lien_holder3_state );
self.lien_holder3_zip := if(ri.orig_name_type = '7' and ~isblanklien1 and ~isBlankLien2 and isBlankLien3, ri.zip5, le.lien_holder3_zip );	
   
   
   self.lien_holder1_ssn := if (ri.orig_name_type = '7' , if((unsigned)ri.orig_ssn > 0, ri.orig_ssn, ri.Append_SSN), le.lien_holder1_ssn);
   self.lien_holder2_ssn := if (ri.orig_name_type = '7', if((unsigned)ri.orig_ssn > 0, ri.orig_ssn, ri.Append_SSN), le.lien_holder2_ssn);
   self.lien_holder3_ssn := if (ri.orig_name_type = '7' , if((unsigned)ri.orig_ssn > 0, ri.orig_ssn, ri.Append_SSN), le.lien_holder3_ssn);
   self.lien_holder1_fein := if (ri.orig_name_type = '7', if((unsigned)ri.orig_fein > 0, ri.orig_fein, ri.Append_fein), le.lien_holder1_FEIN);
   self.lien_holder2_fein := if (ri.orig_name_type = '7', if((unsigned)ri.orig_fein > 0, ri.orig_fein, ri.Append_fein), le.lien_holder2_FEIN);
   self.lien_holder3_fein := if (ri.orig_name_type = '7',if((unsigned)ri.orig_fein > 0, ri.orig_fein, ri.Append_fein), le.lien_holder3_FEIN);
   self.lien_holder1_dob := if (ri.orig_name_type = '7' , ri.orig_dob, le.lien_holder1_dob);
   self.lien_holder2_dob := if (ri.orig_name_type = '7', ri.orig_dob, le.lien_holder2_dob);
   self.lien_holder3_dob := if (ri.orig_name_type = '7' , ri.orig_dob, le.lien_holder3_dob);

   self := le;
   
   end;
	
veh_Denorm	:=	denormalize(matchfiles_temp_dedup,
																		owner_liens_sort,
																		left.vehicle_key	=	right.vehicle_key and
																		left.sequence_key	=	right.sequence_key and
                                                                        left.iteration_key   = right.iteration_key and 
																		left.record_id = right.record_id,
																		tdenorm(left, right),
																		local
																	 ): persist('~thor_data400::persist::vehicle_owners_liens_denorm');

 
//clean company name 


//veh_Denorm := dataset('~thor_data400::persist::vehicle_owners_liens_denorm_new', wma.Layout_vehicle_FDS.liens.vehicles_temp_rec, flat);

veh_Denorm_dist := distribute(veh_Denorm(lien_holder1_lname <> ''or lien_holder1_cname <> ''), hash(VIN,record_id));

matchFiles_dedup := dedup(sort(veh_Denorm_dist,record_id,VIN,
owner1_fname,owner1_mname, owner1_lname,owner1_cname,
owner1_street1, owner1_street2, owner1_city, owner1_state, owner1_zip, 
owner2_fname,owner2_mname, owner2_lname,owner2_cname,
owner2_street1, owner2_street2, owner2_city, owner2_state, owner2_zip,lien_holder1_fname,lien_holder1_mname, lien_holder1_lname,lien_holder1_cname,
lien_holder1_street1,lien_holder1_street2,lien_holder1_city,lien_holder1_state,lien_holder1_zip,
lien_holder2_fname,lien_holder2_mname, lien_holder2_lname,lien_holder2_cname,
lien_holder2_street1,lien_holder2_street2,lien_holder2_city,lien_holder2_state,lien_holder2_zip,
lien_holder3_fname,lien_holder3_mname, lien_holder3_lname,lien_holder3_cname,
lien_holder3_street1,lien_holder3_street2,lien_holder3_city,lien_holder3_state,lien_holder3_zip,vehicle_make_description, vehicle_model_description,


-Date_Vendor_Last_Reported,-Orig_lien_Date,-Ttl_Latest_Issue_Date,local), record_id,VIN,owner1_fname,owner1_mname, owner1_lname,owner1_cname,
owner1_street1, owner1_street2, owner1_city, owner1_state, owner1_zip, 
owner2_fname,owner2_mname, owner2_lname,owner2_cname,
owner2_street1, owner2_street2, owner2_city, owner2_state, owner2_zip,lien_holder1_fname,lien_holder1_mname, lien_holder1_lname,lien_holder1_cname,
lien_holder1_street1,lien_holder1_street2,lien_holder1_city,lien_holder1_state,lien_holder1_zip,
lien_holder2_fname,lien_holder2_mname, lien_holder2_lname,lien_holder2_cname,
lien_holder2_street1,lien_holder2_street2,lien_holder2_city,lien_holder2_state,lien_holder2_zip,
lien_holder3_fname,lien_holder3_mname, lien_holder3_lname,lien_holder3_cname,
lien_holder3_street1,lien_holder3_street2,lien_holder3_city,lien_holder3_state,lien_holder3_zip,vehicle_make_description, vehicle_model_description,local);




keep5 := dedup(sort(distribute(matchFiles_dedup,hash(record_id)),record_id,-Date_Vendor_Last_Reported,-Orig_lien_Date,-Ttl_Latest_Issue_Date,local),record_id,local, keep 5);

//dAssetsin record_id

wma.Layout_vehicle_FDS.license_plate.append trid(dAssetsin le) := transform

self.record_id := le.record_id;
self := [];
end;

append_rid := project(dAssetsin,trid(left));
//append output

wma.Layout_vehicle_FDS.liens.append tappendinput(append_rid le, keep5 ri) := transform

self.Orig_lien_Date := ri.Orig_lien_Date[5..8]+ri.Orig_lien_Date[1..4];
self.date_vendor_last_reported := if(le.record_id = ri.record_id and (unsigned)ri.date_vendor_last_reported <> 0, (string)ri.date_vendor_last_reported[5..6] + '00' + (string)ri.date_vendor_last_reported[1..4], '');
self.Ttl_Latest_Issue_Date := ri.Ttl_Latest_Issue_Date[5..8]+ri.Ttl_Latest_Issue_Date[1..4];
self.record_id := le.record_id;

self := ri;

end;

veh_append := join(append_rid, keep5, left.record_id = right.record_id, tappendinput(left, right), left outer);

veh_append_sort := sort(veh_append,(integer)record_id);

//APPEND SAMPLES
out25 := output(choosen(sort(veh_append_sort,record_id),1000),named('QA_Append_Sample'));

out26 := output(veh_append_sort,
			,'~thor_data400::out::fds_test::assets::vehicle_liens_append_fixed_fmt'
			,overwrite);

out27 := output(veh_append_sort,
			,'~thor_data400::out::fds_test::assets::vehicle_liens_append'
			,overwrite
			,csv(heading(single),separator('|'),terminator('\n')));

//**************************POPULATION STATS
fill_rate_vehicle_rec :=
  record
    CountGroup                          := count(group);
	Recordid_CountNonBlank              := AVE(group,if(veh_append.Record_id<>'',100,0));
    vehicle_make_description_CountNonBlank            := AVE(group,if(veh_append.vehicle_make_description<>'',100,0));
    vehicle_model_description_CountNonBlank           := AVE(group,if(veh_append.vehicle_model_description<>'',100,0));
    VIN_CountNonBlank                	:= AVE(group,if(veh_append.VIN<>'',100,0));
	owner1_fname_CountNonBlank					:= AVE(group,if(veh_append.owner1_fname<>'',100,0));
	owner1_mname_CountNonBlank			:= AVE(group,if(veh_append.owner1_mname<>'',100,0));
	owner1_lname_CountNonBlank           := AVE(group,if(veh_append.owner1_lname<>'',100,0));
    owner1_cname_CountNonBlank     := AVE(group,if(veh_append.owner1_cname<>'',100,0));
    owner1_street1_CountNonBlank       := AVE(group,if(veh_append.owner1_street1<>'',100,0));
    owner1_street2_CountNonBlank             := AVE(group,if(veh_append.owner1_street2<>'',100,0));
    owner1_city_CountNonBlank         := AVE(group,if(veh_append.owner1_city<>'',100,0));
    owner1_state_CountNonBlank       := AVE(group,if(veh_append.owner1_state<>'',100,0));
    owner1_zip_CountNonBlank             := AVE(group,if(veh_append.owner1_zip<>'',100,0));
	owner2_fname_CountNonBlank					:= AVE(group,if(veh_append.owner2_fname<>'',100,0));
	owner2_mname_CountNonBlank			:= AVE(group,if(veh_append.owner2_mname<>'',100,0));
	owner2_lname_CountNonBlank           := AVE(group,if(veh_append.owner2_lname<>'',100,0));
    owner2_cname_CountNonBlank     := AVE(group,if(veh_append.owner2_cname<>'',100,0));
    owner2_street1_CountNonBlank       := AVE(group,if(veh_append.owner2_street1<>'',100,0));
    owner2_street2_CountNonBlank             := AVE(group,if(veh_append.owner2_street2<>'',100,0));
    owner2_city_CountNonBlank         := AVE(group,if(veh_append.owner2_city<>'',100,0));
    owner2_state_CountNonBlank       := AVE(group,if(veh_append.owner2_state<>'',100,0));
    owner2_zip_CountNonBlank             := AVE(group,if(veh_append.owner2_zip<>'',100,0));	
	lien_holder1_fname_CountNonBlank					:= AVE(group,if(veh_append.lien_holder1_fname<>'',100,0));
	lien_holder1_mname_CountNonBlank			:= AVE(group,if(veh_append.lien_holder1_mname<>'',100,0));
	lien_holder1_lname_CountNonBlank           := AVE(group,if(veh_append.lien_holder1_lname<>'',100,0));
    lien_holder1_cname_CountNonBlank     := AVE(group,if(veh_append.lien_holder1_cname<>'',100,0));
    lien_holder1_street1_CountNonBlank       := AVE(group,if(veh_append.lien_holder1_street1<>'',100,0));
    lien_holder1_street2_CountNonBlank             := AVE(group,if(veh_append.lien_holder1_street2<>'',100,0));
    lien_holder1_city_CountNonBlank         := AVE(group,if(veh_append.lien_holder1_city<>'',100,0));
    lien_holder1_state_CountNonBlank       := AVE(group,if(veh_append.lien_holder1_state<>'',100,0));
    lien_holder1_zip_CountNonBlank             := AVE(group,if(veh_append.lien_holder1_zip<>'',100,0));
	lien_holder2_fname_CountNonBlank					:= AVE(group,if(veh_append.lien_holder2_fname<>'',100,0));
	lien_holder2_mname_CountNonBlank			:= AVE(group,if(veh_append.lien_holder2_mname<>'',100,0));
	lien_holder2_lname_CountNonBlank           := AVE(group,if(veh_append.lien_holder2_lname<>'',100,0));
    lien_holder2_cname_CountNonBlank     := AVE(group,if(veh_append.lien_holder2_cname<>'',100,0));
    lien_holder2_street1_CountNonBlank       := AVE(group,if(veh_append.lien_holder2_street1<>'',100,0));
    lien_holder2_street2_CountNonBlank             := AVE(group,if(veh_append.lien_holder2_street2<>'',100,0));
    lien_holder2_city_CountNonBlank         := AVE(group,if(veh_append.lien_holder2_city<>'',100,0));
    lien_holder2_state_CountNonBlank       := AVE(group,if(veh_append.lien_holder2_state<>'',100,0));
    lien_holder2_zip_CountNonBlank             := AVE(group,if(veh_append.lien_holder2_zip<>'',100,0));
	lien_holder3_fname_CountNonBlank					:= AVE(group,if(veh_append.lien_holder3_fname<>'',100,0));
	lien_holder3_mname_CountNonBlank			:= AVE(group,if(veh_append.lien_holder3_mname<>'',100,0));
	lien_holder3_lname_CountNonBlank           := AVE(group,if(veh_append.lien_holder3_lname<>'',100,0));
    lien_holder3_cname_CountNonBlank     := AVE(group,if(veh_append.lien_holder3_cname<>'',100,0));
    lien_holder3_street1_CountNonBlank       := AVE(group,if(veh_append.lien_holder3_street1<>'',100,0));
    lien_holder3_street2_CountNonBlank             := AVE(group,if(veh_append.lien_holder3_street2<>'',100,0));
    lien_holder3_city_CountNonBlank         := AVE(group,if(veh_append.lien_holder3_city<>'',100,0));
    lien_holder3_state_CountNonBlank       := AVE(group,if(veh_append.lien_holder3_state<>'',100,0));
    lien_holder3_zip_CountNonBlank             := AVE(group,if(veh_append.lien_holder3_zip<>'',100,0));
	Orig_lien_Date_CountNonBlank         := AVE(group,if(veh_append.Orig_lien_Date<>'',100,0));
    date_vendor_last_reported_CountNonBlank       := AVE(group,if(veh_append.date_vendor_last_reported<>'',100,0));
   // history_CountNonBlank             := AVE(group,if(veh_append.history<>'',100,0));
	
  end;

fill_rate_vehicle 			:= table(veh_append_sort
												,fill_rate_vehicle_rec
												,few);

out28 := output(fill_rate_vehicle,all,named('Vehicle_liens_Population_Stats'));
				
veh_append_out := parallel(out1,out2,out7,out8,out9,out10,out11,out12,out13,out14,out15,out16,out17,
out18,out19,out20,out21,out22,out23,out24,out25,out26,out27,out28);

//veh_append_out := parallel(out25,out26,out27,out28);

veh_append_out;
