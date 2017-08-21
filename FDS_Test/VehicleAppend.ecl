
/*2009-12-04T07:35:50Z (wma)
c:\SuperComputer\Dataland\QueryBuilder\workspace\wma\Dataland\FDS_Test\VehicleAppend\2009-12-04T07_35_50Z.ecl
*/

#workunit('name', 'Vehicle Append');
import ut,wma;
// Assets search file from FDS
/*dAssetsIn	:=	dataset	(	ut.foreign_prod+'~thor_data400::in::fds_test::20091130::assets::search',
												Layout_assets.Input.rAssetsIn_layout,
												CSV(HEADING(1),SEPARATOR(['|']), TERMINATOR(['\r\n', '\n']));
												
												);*/
												
//Clean FDS Input File
											
dAssetsin := dataset('~thor_data400::persist::fds_asset_clean_did_bdid', wma.Layout_vehicle_FDS.fdslayout, flat);											

veh_Denorm := dataset(ut.foreign_prod + 'thor_data400::persist::vehicle_denorm', wma.Layout_vehicle_FDS.vehicles_extract_temp_rec, flat);

//**********VIN match

assets_VIN := dAssetsIn(VIN <> '');

wma.Layout_vehicle_FDS.vehicles_extract_temp_rec tjoinVIN( veh_Denorm le, dAssetsIn ri) := transform

self.record_id := ri.record_id;
self := le;

end;

Veh_VIN := join(veh_denorm(VIN <> ''), assets_VIN, left.VIN = trim(right.VIN,left,right),tjoinVIN(left, right), lookup);

Veh_VIN_dist := distribute(Veh_VIN, hash(VIN));
veh_VIN_dedup := dedup(sort(Veh_VIN_dist,VIN,local),vin,local);

out1 := output(veh_VIN_dedup,named('VIN_match'),all);
out2 := output((count(veh_VIN_dedup)/count(assets_VIN))*100, named('VIN_match_rate'));

//****************license plate number match only

veh_has_lic := veh_denorm(Reg_License_Plate <> '');
assets_lic := dAssetsIn(license_plate_number <> ''and license_plate_state = '');

wma.Layout_vehicle_FDS.vehicles_extract_temp_rec tjoinlic( veh_has_lic le, dAssetsIn ri) := transform

self.record_id := ri.record_id;
self := le;

end;

Veh_lic := join(veh_has_lic, dAssetsIn(license_plate_number <> ''and license_plate_state = ''), left.Reg_License_Plate= right.license_plate_number,tjoinlic(left, right), lookup);

Veh_lic_dist := distribute(Veh_lic, hash(Reg_License_Plate));
veh_lic_dedup := dedup(sort(Veh_lic_dist,Reg_License_Plate,local),Reg_License_Plate,local);

out3 := output(veh_lic_dedup,named('license_number_match'),all);
out4 := output((count(veh_lic_dedup)/count(assets_lic))*100, named('license_number_match_rate'));


//****************license plate number + state

veh_lic_has_st := veh_denorm(Reg_License_plate <> '' and Reg_License_State <> '');
 
 assets_lic_st := dAssetsIn(license_plate_number <> ''and license_plate_state <> '');
 
wma.Layout_vehicle_FDS.vehicles_extract_temp_rec tjoinlicst( veh_lic_has_st le, dAssetsIn ri) := transform

self.record_id := ri.record_id;
self := le;

end;

Veh_lic_st := join(veh_lic_has_st, assets_lic_st, left.Reg_License_plate = right.license_plate_number and
left.Reg_License_State = right.license_plate_state,tjoinlicst(left, right), lookup);

Veh_lic_st_dist := distribute(Veh_lic_st, hash(Reg_License_Plate,Reg_License_State));
veh_lic_st_dedup := dedup(sort(Veh_lic_st_dist,Reg_License_Plate,Reg_License_State,local),Reg_License_Plate,Reg_License_State,local);

out5 := output(veh_lic_st_dedup,named('license_state_match'),all);
out6 := output((count(veh_lic_st_dedup)/count(assets_lic_st))*100, named('license_state_match_rate'));

//***********************SSN only 

veh_combine := project(dataset('~thor_data400::persist::VehicleV2::veh_combine_fds', wma.Layout_vehicle_FDS.veh_slim_rec, flat)(orig_name_type in ['1','4']), transform(
wma.Layout_vehicle_FDS.veh_slim_rec, self.VINA_VIN := trim(if(left.vina_vin <> '', left.vina_vin, left.orig_vin),left, right),
self.Orig_SSN := if(left.Orig_SSN <> '', left.Orig_SSN, left.append_ssn), 
self.append_clean_cname := datalib.companyclean(left.append_clean_cname),
self.reg_license_state := if(left.reg_license_state <> '', left.reg_license_state, left.st), self := left));

veh_append_temp_rec := record
string record_id;
veh_combine;
end;


assets_ssn_did := dAssetsIn(ssn <> '' and last_name = '');

veh_append_temp_rec tjoinssnDID1(veh_combine le, dAssetsIn ri) := transform

self.record_id := ri.record_id;
self := le;

end;

Veh_combine_ssn_did := join(veh_combine(append_did > 0), assets_ssn_did(ssn_did > 0), left.append_did = right.ssn_did,tjoinssndid1(left, right), lookup);

Veh_ssn_did_dist := distribute(Veh_combine_ssn_did, hash(append_did));
veh_ssn_did_dedup := dedup(sort(Veh_ssn_did_dist,append_did,local),append_did,local);

wma.Layout_vehicle_FDS.vehicles_extract_temp_rec tjoinssnDID2(veh_denorm le, Veh_combine_ssn_did ri) := transform

self.record_id := ri.record_id;
self := le;

end;

Veh_ssn_did := join(veh_denorm, Veh_combine_ssn_did, left.vehicle_key = right.vehicle_key and left.iteration_key = right.iteration_key and
left.sequence_key = right.sequence_key, tjoinssnDID2(left, right), lookup);


out7 := output(veh_ssn_did_dedup,named('ssn_did_only_match'),all);
out8 := output((count(veh_ssn_did_dedup)/count(assets_ssn_did))*100, named('SSN_did_only_match_rate'));


//
/*
assets_ssn := dAssetsIn(ssn <> '' and last_name = '');

veh_combine tjoinssn1(veh_combine le, assets_ssn ri) := transform

self.Iteration_Key := ri.record_id;
self := le;

end;

Veh_combine_ssn := join(veh_combine(orig_ssn <> ''), assets_ssn, left.orig_ssn = right.ssn,tjoinssn1(left, right), lookup);

Veh_ssn_dist := distribute(Veh_combine_ssn, hash(orig_ssn));
veh_ssn_cnt := count(dedup(sort(Veh_ssn_dist,orig_ssn,local),orig_ssn,local));

vehicles_append_rec tjoinssn2(veh_denorm le, Veh_combine_ssn ri) := transform

self.record_id := ri.Iteration_Key;
self := le;

end;

Veh_ssn := join(veh_denorm, Veh_combine_ssn, left.VIN = right.VINA_VIN, tjoinssn2(left, right), lookup);

output(Veh_ssn, named('SSN_only_match'));

output(veh_ssn_cnt,named('ssn_only_match_cnt'));
output((veh_ssn_cnt/count(assets_ssn))*100, named('SSN_only_match_rate'));*/

//*************************full SSN + name 

assets_name_fssn := dAssetsIn(length(ssn) = 9 and last_name <> ''  );

veh_append_temp_rec tjoinfssnDID1(veh_combine le, dAssetsIn ri) := transform

self.record_id := ri.record_id;
self := le;

end;

Veh_combine_fssn := join(veh_combine(append_did > 0), assets_name_fssn(ssn_did >0), left.append_did = right.ssn_did ,tjoinfssndid1(left, right), lookup);

Veh_fssn_dist := distribute(Veh_combine_fssn, hash(append_did));
veh_fssn_dedup := dedup(sort(Veh_fssn_dist,append_did,local),append_did,local);

wma.Layout_vehicle_FDS.vehicles_extract_temp_rec tjoinfssn2(veh_denorm le, Veh_combine_fssn ri) := transform

self.record_id := ri.record_id;
self := le;

end;

Veh_fssn := join(veh_denorm, Veh_combine_fssn, left.vehicle_key = right.vehicle_key and left.iteration_key = right.iteration_key and
left.sequence_key = right.sequence_key, tjoinfssn2(left, right), lookup);


out9 := output(veh_fssn_dedup,named('full_ssn_name_match'),all);
out10 := output((count(veh_fssn_dedup)/count(assets_name_fssn))*100, named('full_SSN_name_match_rate'));

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

wma.Layout_vehicle_FDS.vehicles_extract_temp_rec tjoinpssn2(veh_denorm le, Veh_combine_fssn ri) := transform

self.record_id := ri.record_id;
self := le;

end;

Veh_pssn := join(veh_denorm, Veh_combine_pssn, left.vehicle_key = right.vehicle_key and left.iteration_key = right.iteration_key and
left.sequence_key = right.sequence_key, tjoinpssn2(left, right), lookup);

out11 := output(veh_pssn_dedup,named('partial_ssn_match'),all);
out12 := output((count(veh_pssn_dedup)/count(assets_name_pssn))*100, named('partial_SSN_match_rate'));


//********************name + complete address 

Assets_name_addr := dAssetsIn(orig_name <> '' and orig_address <> '' );

veh_append_temp_rec tjoinnmAddr1(veh_combine le, Assets_name_addr ri) := transform

self.record_id := ri.record_id;
self := le;

end;

Veh_combine_nmAddr:= join(veh_combine(append_did > 0), Assets_name_addr(addr_did > 0), left.append_did = right.addr_did,tjoinnmaddr1(left, right), lookup);

Veh_nmAddr_dist := distribute(Veh_combine_nmAddr, hash(append_did));
veh_nmAddr_dedup := dedup(sort(Veh_nmAddr_dist,append_did,local),append_did,local);


wma.Layout_vehicle_FDS.vehicles_extract_temp_rec tjoinnmAddr2( veh_denorm le, Veh_combine_nmAddr ri) := transform

self.record_id := ri.Iteration_Key;
self := le;

end;

Veh_name_addr := join(veh_denorm, Veh_combine_nmAddr, left.vehicle_key = right.vehicle_key and left.iteration_key = right.iteration_key and
left.sequence_key = right.sequence_key,tjoinnmAddr2(left, right), lookup);

out13 := output(veh_nmAddr_dedup,all,named('name_addr_match'),all);
out14 := output((count(veh_nmAddr_dedup)/count(Assets_name_addr))*100, named('name_addr_match_rate'));

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
wma.Layout_vehicle_FDS.vehicles_extract_temp_rec tjoinnmzip2( veh_denorm le, Veh_combine_nmzip ri) := transform

self.record_id := ri.record_id;
self := le;

end;

Veh_name_zip := join(veh_denorm, Veh_combine_nmzip, left.vehicle_key = right.vehicle_key and left.iteration_key = right.iteration_key and
left.sequence_key = right.sequence_key,tjoinnmzip2(left, right), lookup);

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

wma.Layout_vehicle_FDS.vehicles_extract_temp_rec tjoinnmst2( veh_denorm le, Veh_combine_nmst ri) := transform

self.record_id := ri.record_id;
self := le;

end;

Veh_name_st := join(veh_denorm, Veh_combine_nmst, left.vehicle_key = right.vehicle_key and left.iteration_key = right.iteration_key and
left.sequence_key = right.sequence_key ,tjoinnmst2(left, right), lookup);

out17 := output(veh_nmst_dedup,all,named('name_st_match'),all);
out18 := output((count(veh_nmst_dedup)/count(Assets_name_st))*100, named('name_st_match_rate'));

//********************business name + complete address 

Assets_Bus_name_addr:= dAssetsIn(orig_business_name <> '' and orig_address <> '' );

veh_append_temp_rec tjoinbusaddr1(veh_combine le, Assets_Bus_name_addr ri) := transform

self.record_id := ri.record_id;
self := le;

end;

Veh_combine_bus_addr:= join(veh_combine(append_bdid > 0), Assets_Bus_name_addr(bdid > 0), left.append_bdid = right.bdid,tjoinbusaddr1(left, right), lookup);

Veh_bus_addr_dist := distribute(Veh_combine_bus_addr, hash(append_bdid));
veh_bus_addr_dedup := dedup(sort(Veh_bus_addr_dist,append_bdid,local),append_bdid,local);

wma.Layout_vehicle_FDS.vehicles_extract_temp_rec tjoinbusaddr2( veh_denorm le, Veh_combine_bus_addr ri) := transform

self.record_id := ri.record_id;
self := le;

end;

Veh_bus_addr := join(veh_denorm, Veh_combine_bus_addr, left.vehicle_key = right.vehicle_key and left.iteration_key = right.iteration_key and
left.sequence_key = right.sequence_key ,tjoinbusaddr2(left, right), lookup);

out19 := output(veh_bus_addr_dedup,named('bus_name_addr_match'),all);
out20 := output((count(veh_bus_addr_dedup)/count(Assets_Bus_name_addr))*100, named('bus_name_addr_match_rate'));

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

wma.Layout_vehicle_FDS.vehicles_extract_temp_rec tjoinbuspaddr2( veh_denorm le, Veh_combine_bus_paddr ri) := transform

self.record_id := ri.record_id;
self := le;

end;

Veh_bus_paddr := join(veh_denorm, Veh_combine_bus_paddr, left.vehicle_key = right.vehicle_key and left.iteration_key = right.iteration_key and
left.sequence_key = right.sequence_key ,tjoinbuspaddr2(left, right), lookup);

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

wma.Layout_vehicle_FDS.vehicles_extract_temp_rec tjoinaddr2( veh_denorm le, Veh_combine_addr ri) := transform

self.record_id := ri.record_id;
self := le;

end;

Veh_addr := join(veh_denorm, Veh_combine_addr, left.vehicle_key = right.vehicle_key and left.iteration_key = right.iteration_key and
left.sequence_key = right.sequence_key ,tjoinaddr2(left, right), lookup);

out23 := output(veh_addr_dedup,named('addr_only_match'),all);
out24 := output((count(veh_addr_dedup)/count(Assets_addr))*100, named('addr_only_match_rate'));

//************************Combine Files*****
matchFiles := Veh_VIN + Veh_lic + Veh_lic_st + Veh_ssn_did + Veh_fssn + Veh_pssn + Veh_name_addr + veh_name_st + veh_name_zip + Veh_bus_addr + Veh_bus_paddr + Veh_addr;


matchFiles_clean := project(matchFiles,transform(wma.Layout_vehicle_FDS.vehicles_extract_temp_rec, 
self.owner1_cname := datalib.companyclean(left.owner1_cname),
self.owner2_cname := datalib.companyclean(left.owner2_cname),
self.reg1_cname := datalib.companyclean(left.reg2_cname),
self.reg2_cname := datalib.companyclean(left.reg2_cname),
self.VIN := trim(left.VIN, left, right),self := left));

//dedup by VIN and names 

matchFiles_dist := distribute(matchFiles_clean, hash(VIN));

matchFiles_dedup := dedup(sort(matchFiles_dist,VIN,owner1_fname,owner1_mname, owner1_lname,owner1_cname,
owner1_street1, owner1_street2, owner1_city, owner1_state, owner1_zip, 
owner2_fname,owner2_mname, owner2_lname,owner2_cname,
owner2_street1, owner2_street2, owner2_city, owner2_state, owner2_zip, 
reg1_fname,reg1_mname, reg1_lname,reg1_cname,
reg1_street1, reg1_street2, reg1_city, reg1_state, reg1_zip, 
reg2_fname,reg2_mname, reg2_lname,reg2_cname,
reg2_street1, reg2_street2, reg2_city, reg2_state, reg2_zip,vehicle_make_description,vehicle_model_description,
Reg_License_Plate, Reg_License_State,Reg_Previous_License_Plate,Reg_Previous_License_state, history,
-Date_Vendor_Last_Reported,-Reg_Latest_Effective_Date,-Ttl_Latest_Issue_Date,local), 

VIN,owner1_fname,owner1_mname, owner1_lname,owner1_cname,
owner1_street1, owner1_street2, owner1_city, owner1_state, owner1_zip, 
owner2_fname,owner2_mname, owner2_lname,owner2_cname,
owner2_street1, owner2_street2, owner2_city, owner2_state, owner2_zip, 
reg1_fname,reg1_mname, reg1_lname,reg1_cname,
reg1_street1, reg1_street2, reg1_city, reg1_state, reg1_zip, 
reg2_fname,reg2_mname, reg2_lname,reg2_cname,
reg2_street1, reg2_street2, reg2_city, reg2_state, reg2_zip,vehicle_make_description,vehicle_model_description,
Reg_License_Plate, Reg_License_State, Reg_Previous_License_Plate,Reg_Previous_License_state, local);


keep5 := dedup(sort(distribute(matchFiles_dedup,hash(record_id)),record_id,-Date_Vendor_Last_Reported,-Reg_Latest_Effective_Date,-Ttl_Latest_Issue_Date,local),record_id,local, keep 5);


//append output

wma.Layout_vehicle_FDS.license_plate.append tappendinput(matchFiles le) := transform
boolean	isBlankOwner1				:=	le.owner1_lname = '' and le.owner1_cname = '';
	
	boolean	isNotBlankOwner1		:=	le.owner1_lname != '' or le.owner1_cname != '';
	
	boolean	isBlankReg1			:=	le.reg1_lname = '' and le.reg1_cname = '';
	
	boolean	isNotBlankReg1		:=	le.reg1_lname != '' or le.reg1_cname != '';
	

self.record_type := if(isNotBlankOwner1 and isBlankReg1, 'title', if(isNotBlankOwner1 and isNotBlankReg1, 'combination',
                    if(isBlankOwner1 and isNotBlankReg1, 'registration', '')));


self.Reg_Latest_Effective_Date := le.Reg_Latest_Effective_Date[5..8]+le.Reg_Latest_Effective_Date[1..4];
self.Ttl_Latest_Issue_Date := le.Ttl_Latest_Issue_Date[5..8]+le.Ttl_Latest_Issue_Date[1..4];
self := le;

end;
veh_append := project(keep5,tappendinput(left));

//APPEND SAMPLES
out25 := output(choosen(sort(veh_append,record_id),1000),named('QA_Append_Sample'));

out26 := output(veh_append,
			,'~thor_data400::out::fds_test::assets::vehicle_append_fixed_fmt'
			,overwrite);

out27 := output(veh_append,
			,'~thor_data400::out::fds_test::assets::vehicle_append'
			,overwrite
			,csv(heading,separator('|'),terminator('\n')));

//**************************POPULATION STATS
fill_rate_vehicle_rec :=
  record
    CountGroup                          := count(group);
	Recordid_CountNonBlank              := AVE(group,if(veh_append.Record_id<>'',100,0));
    vehicle_make_description_CountNonBlank            := AVE(group,if(veh_append.vehicle_make_description<>'',100,0));
    vehicle_model_description_CountNonBlank           := AVE(group,if(veh_append.vehicle_model_description<>'',100,0));
    reg_true_license_plate_CountNonBlank             := AVE(group,if(veh_append.reg_true_license_plate<>'',100,0));
    reg_license_plate_CountNonBlank          := AVE(group,if(veh_append.reg_license_plate<>'',100,0));
    reg_license_state_CountNonBlank              := AVE(group,if(veh_append.reg_license_state<>'',100,0));
    reg_previous_license_state_CountNonBlank              := AVE(group,if(veh_append.reg_previous_license_state<>'',100,0));
    reg_previous_license_plate_CountNonBlank                  := AVE(group,if(veh_append.reg_previous_license_plate<>'',100,0));
    record_type_CountNonBlank                 := AVE(group,if(veh_append.record_type<>'',100,0));
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
	reg1_fname_CountNonBlank					:= AVE(group,if(veh_append.reg1_fname<>'',100,0));
	reg1_mname_CountNonBlank			:= AVE(group,if(veh_append.reg1_mname<>'',100,0));
	reg1_lname_CountNonBlank           := AVE(group,if(veh_append.reg1_lname<>'',100,0));
    reg1_cname_CountNonBlank     := AVE(group,if(veh_append.reg1_cname<>'',100,0));
    reg1_street1_CountNonBlank       := AVE(group,if(veh_append.reg1_street1<>'',100,0));
    reg1_street2_CountNonBlank             := AVE(group,if(veh_append.reg1_street2<>'',100,0));
    reg1_city_CountNonBlank         := AVE(group,if(veh_append.reg1_city<>'',100,0));
    reg1_state_CountNonBlank       := AVE(group,if(veh_append.reg1_state<>'',100,0));
    reg1_zip_CountNonBlank             := AVE(group,if(veh_append.reg1_zip<>'',100,0));
	reg2_fname_CountNonBlank					:= AVE(group,if(veh_append.reg2_fname<>'',100,0));
	reg2_mname_CountNonBlank			:= AVE(group,if(veh_append.reg2_mname<>'',100,0));
	reg2_lname_CountNonBlank           := AVE(group,if(veh_append.reg2_lname<>'',100,0));
    reg2_cname_CountNonBlank     := AVE(group,if(veh_append.reg2_cname<>'',100,0));
    reg2_street1_CountNonBlank       := AVE(group,if(veh_append.reg2_street1<>'',100,0));
    reg2_street2_CountNonBlank             := AVE(group,if(veh_append.reg2_street2<>'',100,0));
    reg2_city_CountNonBlank         := AVE(group,if(veh_append.reg2_city<>'',100,0));
    reg2_state_CountNonBlank       := AVE(group,if(veh_append.reg2_state<>'',100,0));
    reg2_zip_CountNonBlank             := AVE(group,if(veh_append.reg2_zip<>'',100,0));
	reg_latest_effective_date_CountNonBlank         := AVE(group,if(veh_append.reg_latest_effective_date<>'',100,0));
    ttl_latest_issue_date_CountNonBlank       := AVE(group,if(veh_append.ttl_latest_issue_date<>'',100,0));
    history_CountNonBlank             := AVE(group,if(veh_append.history<>'',100,0));
	
  end;

fill_rate_vehicle 			:= table(veh_append
												,fill_rate_vehicle_rec
												,few);

out28 := output(fill_rate_vehicle,all,named('Vehicle_Population_Stats'));
				
veh_append_out := parallel(out1,out2,out3,out4,out5,out6,out7,out8,out9,out10,out11,out12,out13,out14,out15,out16,out17,
out18,out19,out20,out21,out22,out23,out24,out25,out26,out27,out28);


export VehicleAppend := veh_append_out;
