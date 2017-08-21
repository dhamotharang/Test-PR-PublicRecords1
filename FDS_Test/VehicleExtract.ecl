/*2009-12-02T02:48:17Z (wma)
c:\SuperComputer\Dataland\QueryBuilder\workspace\wma\Dataland\FDS_Test\VehicleExtract\2009-12-02T02_48_17Z.ecl
*/
#workunit('name', 'Vehicle Zip Extract')

import vehicleV2,address,wma,ut;

veh_combine := dataset('~thor_data400::persist::VehicleV2::veh_combine_fds', wma.Layout_vehicle_FDS.veh_slim_rec, flat);

veh_combine_dist := distribute(veh_combine(Orig_Name_Type in ['1','4']), hash(Vehicle_Key, iteration_key, Sequence_Key));

//expand vehicle file

wma.Layout_vehicle_FDS.vehicles_extract_temp_rec textracttemp(veh_combine_dist le)	:=
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

veh_extract_temp		:=	project(veh_combine_dist, textracttemp(left));
veh_extract_temp_sort	:=	sort(veh_extract_temp, vehicle_key, -iteration_key,-sequence_key, -Date_Vendor_Last_Reported,-Ttl_Latest_Issue_Date,local);
veh_extract_temp_dedup	:=	dedup(veh_extract_temp_sort, vehicle_key, iteration_key,sequence_key,local);

//denormalize name & address
wma.Layout_vehicle_FDS.vehicles_extract_temp_rec tdenorm(veh_extract_temp_dedup le, veh_combine_dist ri) := transform

    boolean	isBlankOwner1				:=	le.owner1_lname = '' and le.owner1_cname = '';
	
	boolean	isNotBlankOwner1		:=	le.owner1_lname != '' or le.owner1_cname != '';
	
	boolean	isBlankReg1			:=	le.reg1_lname = '' and le.reg1_cname = '';
	
	boolean	isNotBlankReg1		:=	le.reg1_lname != '' or le.reg1_cname != '';
	
	self.Reg_True_License_Plate := if(	ri.orig_name_type = '4', ri.Reg_True_License_Plate, le.Reg_True_License_Plate);
    self.Reg_License_Plate  := if(	ri.orig_name_type = '4', ri.Reg_License_Plate, le.Reg_License_Plate);
	self.Reg_License_State  := if(	ri.orig_name_type = '4', ri.Reg_License_state, le.Reg_License_state);
	self.Reg_Previous_License_Plate := if(	ri.orig_name_type = '4', ri.Reg_Previous_License_Plate, le.Reg_Previous_License_Plate);
		self.Reg_Previous_License_state := if(	ri.orig_name_type = '4', ri.Reg_Previous_License_state, le.Reg_Previous_License_state);

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
	self.owner1_did		  :=	if( ri.orig_name_type = '1' and isBlankOwner1,
																		ri.append_did,
																		le.owner1_did
																	);
	self.owner1_Bdid		  :=	if( ri.orig_name_type = '1' and isBlankOwner1,
																		ri.append_Bdid,
																		le.owner1_Bdid
																	);																
	self.owner1_ssn		  :=	if(	ri.orig_name_type = '1' and isBlankOwner1,
																		if((unsigned)ri.orig_ssn > 0, ri.orig_ssn, ri.Append_SSN),
																		le.owner1_ssn
																		);
	self.owner1_fein		  :=	if(	ri.orig_name_type = '1' and isBlankOwner1,
																		if((unsigned)ri.orig_fein > 0, ri.orig_fein, ri.Append_fein),
																		le.owner1_fein
																	);														
	self.owner2_fname		:=	if(	ri.orig_name_type = '1' and isNotBlankOwner1,
																		ri.fname,
																		le.owner2_fname
																	);
	self.owner2_lname		:=	if(	ri.orig_name_type = '1' and isNotBlankOwner1,
																		ri.lname,
																		le.owner2_lname
																	);
	self.owner2_mname		:=	if(	ri.orig_name_type = '1' and isNotBlankOwner1,
																		ri.mname,
																		le.owner2_mname
																	);
	self.owner2_cname	   :=	if(	ri.orig_name_type = '1' and isNotBlankOwner1,
																		ri.Append_Clean_CName,
																		le.owner2_cname
																		);
	self.owner2_street1 :=	if(	ri.orig_name_type = '1' and isNotBlankOwner1,
															trim(Address.Addr1FromComponents(ri.prim_range
                                                                                            ,ri.predir
                                                                                            ,ri.prim_name
                                                                                            ,ri.addr_suffix
                                                                                            ,ri.postdir
                                                                                        ,'',''),left,right),
																		le.owner2_street1);
	self.owner2_street2 :=	if(	ri.orig_name_type = '1' and isNotBlankOwner1,
															trim(Address.Addr1FromComponents(ri.unit_desig
                                                                                            ,ri.sec_range
                                                                                            ,''
                                                                                            ,''
                                                                                            ,''
                                                                                            ,''
                                                                                            ,''),left,right),	
																		                    le.owner2_street2);
	self.owner2_city := if(ri.orig_name_type = '1' and isNotBlankOwner1, ri.v_city_name, le.owner2_city);
    self.owner2_state := if(ri.orig_name_type = '1' and isNotBlankOwner1, ri.st, le.owner2_state );
    self.owner2_zip := if(ri.orig_name_type = '1' and isNotBlankOwner1, ri.zip5, le.owner2_zip );																
	self.owner2_did		  :=	if( ri.orig_name_type = '1' and isNotBlankOwner1,
																		ri.append_did,
																		le.owner2_did
																	);
	self.owner2_Bdid		  :=	if( ri.orig_name_type = '1' and isNotBlankOwner1,
																		ri.append_Bdid,
																		le.owner2_Bdid
																	);																
	self.owner2_ssn		  :=	if(	ri.orig_name_type = '1' and isNotBlankOwner1,
																		if((unsigned)ri.orig_ssn > 0, ri.orig_ssn, ri.Append_SSN),
																		le.owner2_ssn
																	);
	
	self.owner2_fein		  :=	if(	ri.orig_name_type = '1' and isNotBlankOwner1,
																		if((unsigned)ri.orig_fein > 0, ri.orig_fein, ri.Append_fein),
																		le.owner2_fein
																	);	
	self.reg1_fname		:=	if(	ri.orig_name_type = '4' and isBlankreg1,
																		ri.fname,
																		le.reg1_fname
																	);
	self.reg1_lname		:=	if(	ri.orig_name_type = '4' and isBlankreg1,
																		ri.lname,
																		le.reg1_lname
																	);
	self.reg1_mname		:=	if(	ri.orig_name_type = '4' and isBlankreg1,
																		ri.mname,
																		le.reg1_mname
																	);
	self.reg1_cname	   :=	if(	ri.orig_name_type = '4' and isBlankreg1,
																		ri.Append_Clean_CName,
																		le.reg1_cname
	
																);
																
	self.reg1_street1 :=	if(	ri.orig_name_type = '4' and isBlankreg1,
															trim(Address.Addr1FromComponents(ri.prim_range
                                                                                            ,ri.predir
                                                                                            ,ri.prim_name
                                                                                            ,ri.addr_suffix
                                                                                            ,ri.postdir
                                                                                        ,'',''),left,right),
																		le.reg1_street1);
	self.reg1_street2 :=	if(	ri.orig_name_type = '4' and isBlankreg1,
															trim(Address.Addr1FromComponents(ri.unit_desig
                                                                                            ,ri.sec_range
                                                                                            ,''
                                                                                            ,''
                                                                                            ,''
                                                                                            ,''
                                                                                            ,''),left,right),	
																		                    le.reg1_street2);
	self.reg1_city := if(ri.orig_name_type = '4' and isBlankreg1, ri.v_city_name, le.reg1_city);
    self.reg1_state := if(ri.orig_name_type = '4' and isBlankreg1, ri.st, le.reg1_state );
    self.reg1_zip := if(ri.orig_name_type = '4' and isBlankreg1, ri.zip5, le.reg1_zip );															
	self.reg1_did		  :=	if( ri.orig_name_type = '4' and isBlankreg1,
																		ri.append_did,
																		le.reg1_did
																	);
																	
	self.reg1_Bdid		  :=	if( ri.orig_name_type = '4' and isBlankreg1,
																		ri.append_Bdid,
																		le.reg1_Bdid
																	);																
	self.reg1_ssn		  :=	if(	ri.orig_name_type = '4' and isBlankreg1,
																		if((unsigned)ri.orig_ssn > 0, ri.orig_ssn, ri.Append_SSN),
																		le.reg1_ssn
	);
	self.reg1_fein		  :=	if(	ri.orig_name_type = '4' and isBlankreg1,
																		if((unsigned)ri.orig_fein > 0, ri.orig_fein, ri.Append_fein),
																		le.reg1_fein
																	);
	self.reg2_fname		:=	if(	ri.orig_name_type = '4' and isNotBlankreg1,
																		ri.fname,
																		le.reg2_fname
																	);
	self.reg2_lname		:=	if(	ri.orig_name_type = '4' and isNotBlankreg1,
																		ri.lname,
																		le.reg2_lname
																	);
	self.reg2_mname		:=	if(	ri.orig_name_type = '4' and isNotBlankreg1,
																		ri.mname,
																		le.reg2_mname
																	);
	self.reg2_cname	   :=	if(	ri.orig_name_type = '4' and isNotBlankreg1,
																		ri.Append_Clean_CName,
																		le.reg2_cname
																	);
																	
	self.reg2_street1 :=	if(	ri.orig_name_type = '4' and isNotBlankreg1,
															trim(Address.Addr1FromComponents(ri.prim_range
                                                                                            ,ri.predir
                                                                                            ,ri.prim_name
                                                                                            ,ri.addr_suffix
                                                                                            ,ri.postdir
                                                                                        ,'',''),left,right),
																		le.reg2_street1);
	self.reg2_street2 :=	if(	ri.orig_name_type = '4' and isNotBlankreg1,
															trim(Address.Addr1FromComponents(ri.unit_desig
                                                                                            ,ri.sec_range
                                                                                            ,''
                                                                                            ,''
                                                                                            ,''
                                                                                            ,''
                                                                                            ,''),left,right),	
																		                    le.reg2_street2);
	self.reg2_city := if(ri.orig_name_type = '4' and isNotBlankreg1, ri.v_city_name, le.reg2_city);
    self.reg2_state := if(ri.orig_name_type = '4' and isNotBlankreg1, ri.st, le.reg2_state );
    self.reg2_zip := if(ri.orig_name_type = '4' and isNotBlankreg1, ri.zip5, le.reg2_zip );																
																	
	self.reg2_did		  :=	if( ri.orig_name_type = '4' and isNotBlankreg1,
																		ri.append_did,
																		le.reg2_did
																	);
	self.reg2_Bdid		  :=	if( ri.orig_name_type = '4' and isNotBlankreg1,
																		ri.append_Bdid,
																		le.reg2_Bdid
																	);																	
	self.reg2_ssn		  :=	if(	ri.orig_name_type = '4' and isNotBlankreg1,
																		if((unsigned)ri.orig_ssn > 0, ri.orig_ssn, ri.Append_SSN),
																		le.reg2_ssn
																	);																
	self.reg2_fein		  :=	if(	ri.orig_name_type = '4' and isNotBlankreg1,
																		if((unsigned)ri.orig_fein > 0, ri.orig_fein, ri.Append_fein),
																		le.reg2_fein
																);																
																
self.Reg_Latest_Effective_Date := if(ri.orig_name_type = '4'         , ri.Reg_Latest_Effective_Date,le.Reg_Latest_Effective_Date);
 self.Ttl_Latest_Issue_Date  := if(ri.orig_name_type = '1'         , ri.Ttl_Latest_Issue_Date,le.Ttl_Latest_Issue_Date);
   
   self.history_owner := if(ri.orig_name_type = '1'         , ri.history,le.history_owner);
      self.history_reg := if(ri.orig_name_type = '4'         , ri.history,le.history_reg);

   self := le;
   
   end;
	
/*veh_Denorm	:=	denormalize(veh_extract_temp_dedup,
																		veh_combine_dist,
																		left.vehicle_key	=	right.vehicle_key and
																		left.sequence_key	=	right.sequence_key and
                                                                        left.iteration_key   = right.iteration_key,
																		tdenorm(left, right),
																		local
																	 ): persist('~thor_data400::persist::vehicle_denorm');*/
    

//extract final records

veh_Denorm := dataset(ut.foreign_dataland +'thor_data400::persist::vehicle_denorm', wma.Layout_vehicle_FDS.vehicles_extract_temp_rec, flat);


veh_denorm_zip := veh_Denorm(owner1_zip in FDS_TEST.zipcodeSet or owner2_zip in FDS_TEST.zipcodeSet 
                           or reg1_zip in FDS_TEST.zipcodeSet or reg2_zip in FDS_TEST.zipcodeSet);


//clean company name 

veh_denorm_zip_clean := project(veh_denorm_zip,transform(wma.Layout_vehicle_FDS.vehicles_extract_temp_rec, 
self.owner1_cname := datalib.companyclean(left.owner1_cname),
self.owner2_cname := datalib.companyclean(left.owner2_cname),
self.reg1_cname := datalib.companyclean(left.reg2_cname),
self.reg2_cname := datalib.companyclean(left.reg2_cname),
self.VIN := trim(left.VIN, left, right),self := left));

//dedup by VIN and names 

veh_denorm_zip_dist := distribute(veh_denorm_zip_clean, hash(VIN));

veh_denorm_dedup := dedup(sort(veh_denorm_zip_dist,VIN,owner1_fname,owner1_mname, owner1_lname,owner1_cname,
owner1_street1, owner1_street2, owner1_city, owner1_state, owner1_zip, 
owner2_fname,owner2_mname, owner2_lname,owner2_cname,
owner2_street1, owner2_street2, owner2_city, owner2_state, owner2_zip, 
reg1_fname,reg1_mname, reg1_lname,reg1_cname,
reg1_street1, reg1_street2, reg1_city, reg1_state, reg1_zip, 
reg2_fname,reg2_mname, reg2_lname,reg2_cname,
reg2_street1, reg2_street2, reg2_city, reg2_state, reg2_zip,vehicle_make_description,vehicle_model_description,
Reg_License_Plate, Reg_License_State,Reg_Previous_License_Plate,Reg_Previous_License_state,
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

keep5 := dedup(sort(veh_denorm_dedup,VIN,-Date_Vendor_Last_Reported,-Reg_Latest_Effective_Date,-Ttl_Latest_Issue_Date,local), VIN,local, keep 5);


//setup recordID

	recordof(keep5) setRecordID(keep5 L,keep5 R) := transform
	self.record_ID := if(L.record_ID = '',
						'1',
						if(L.VIN = R.VIN,
							L.record_ID,
							(string)((integer)L.record_ID + 1)));
    self := R;
	end;
							
Keep5ID := iterate(keep5,setRecordID(left,right));

wma.Layout_vehicle_FDS.license_plate.zipextract textractfinal(Keep5ID le) := transform

boolean	isBlankOwner1				:=	le.owner1_lname = '' and le.owner1_cname = '';
	
	boolean	isNotBlankOwner1		:=	le.owner1_lname != '' or le.owner1_cname != '';
	
	boolean	isBlankReg1			:=	le.reg1_lname = '' and le.reg1_cname = '';
	
	boolean	isNotBlankReg1		:=	le.reg1_lname != '' or le.reg1_cname != '';
	

self.record_type := if(isNotBlankOwner1 and isBlankReg1, 'title', if(isNotBlankOwner1 and isNotBlankReg1, 'combination',
                    if(isBlankOwner1 and isNotBlankReg1, 'registration', '')));


self.sourcezip := map(le.owner1_zip in FDS_TEST.zipcodeSet => le.owner1_zip,
                      le.owner2_zip in FDS_TEST.zipcodeSet => le.owner2_zip,
					  le.reg1_zip in FDS_TEST.zipcodeSet => le.reg1_zip,
					  le.reg2_zip in FDS_TEST.zipcodeSet => le.reg2_zip, '');

self.Reg_Latest_Effective_Date := le.Reg_Latest_Effective_Date[5..8]+le.Reg_Latest_Effective_Date[1..4];
self.Ttl_Latest_Issue_Date := le.Ttl_Latest_Issue_Date[5..8]+le.Ttl_Latest_Issue_Date[1..4];
self.history := if(isNotBlankReg1 and le.history_reg = '', le.history_reg, if(isBlankReg1 and isNotBlankOwner1, le.history_owner, 'H'));
self := le;

end;

veh_extract := project(Keep5ID, textractfinal(left));

veh_extract_sort := sort(veh_extract, sourcezip, record_id);

output(choosen(veh_extract_sort,1000), named('Vehicle_FDS_Extract'));

output(choosen(sort(veh_extract_sort, -Reg_Latest_Effective_Date[5..8], -Ttl_Latest_Issue_Date[5..8]),1000), named('Vehicle_FDS_Extract_sort_by_dates'));

output(veh_extract_sort(VIN = '1FMDU35P1VZC28813'));
output(veh_extract_sort,,'~thor_data400::out::fds_test::assets::vehicle_extract_fixed_fmt',__compressed__,overwrite);

dFDSVehicleExtract			:=	output(veh_extract_sort,,'~thor_data400::out::fds_test::assets::vehicle_extract',csv(heading,separator('|'),terminator('\n')),__compressed__,overwrite);

export vehicleextract := dFDSVehicleExtract;


