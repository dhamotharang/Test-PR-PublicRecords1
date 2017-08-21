//#workunit('name', 'VehicleLien Zip Extract')
//**** notes ****/

//there is underlinking issue in the old sequence_key, the owner and lien holder has the same title 
//number and title issue date but different date_vendor_last_reported, they should be linked

//the new sequence_key link all multiple owners with different address and lien holder info, these were not well applied for 
// FDS layout when denormalized
// good solution to combine both, the old + the new (not linked in the old)
// the file based on the old keys was renamed as '~thor_data400::fds::VehicleV2::veh_combine_liens_20100224' on PROD'
// the file based on the new keys need rebuild
import ut,vehicleV2,address,mdr,business_header,business_header_ss,did_add,wma;

veh_combine := dataset(ut.foreign_prod + 'thor_data400::persist::VehicleV2::veh_combine_liens_fds', wma.Layout_vehicle_FDS.veh_slim_rec, flat)(Orig_Name_Type in ['1', '7']);

//clean name & address

veh_lien_DI := veh_combine(Orig_Name_Type = '7' and source_code = 'DI');

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

veh_lien := fdsClean_DI + veh_combine(~(Orig_Name_Type = '7' and source_code = 'DI'));

veh_combine_dist := distribute(veh_lien, hash(Vehicle_Key, iteration_key, Sequence_Key));
veh_combine_sort	:=	sort(veh_combine_dist, vehicle_key, iteration_key,sequence_key, -Date_Vendor_Last_Reported,-Orig_Lien_Date,-Ttl_Latest_Issue_Date,local);
//expand vehicle file

wma.Layout_vehicle_FDS.liens.vehicles_temp_rec textracttemp(veh_combine_dist le)	:=
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
veh_extract_temp_sort	:=	sort(veh_extract_temp, vehicle_key, iteration_key,sequence_key, -Date_Vendor_Last_Reported,-Orig_Lien_Date,-Ttl_Latest_Issue_Date,local);
veh_extract_temp_dedup	:=	dedup(veh_extract_temp_sort, vehicle_key, iteration_key,sequence_key,local);
//denormalize name & address
wma.Layout_vehicle_FDS.liens.vehicles_temp_rec tdenorm(veh_extract_temp_dedup le, veh_combine_sort ri) := transform

  
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
	
/*veh_Denorm	:=	denormalize(veh_extract_temp_dedup,
																		veh_combine_sort,
																		left.vehicle_key	=	right.vehicle_key and
																		left.sequence_key	=	right.sequence_key and
                                                                        left.iteration_key   = right.iteration_key,
																		tdenorm(left, right),
																		local
																	 ):persist('~thor_data400::persist::vehicle_lien_denorm');*/
																	 
 


//extract final records

veh_Denorm := dataset('~thor_data400::persist::vehicle_lien_denorm', wma.Layout_vehicle_FDS.liens.vehicles_temp_rec, flat);
veh_has_lien := veh_Denorm(lien_holder1_lname <> ''or lien_holder1_cname <> '');
veh_denorm_zip := veh_has_lien(owner1_zip in FDS_TEST.zipcodeSet or owner2_zip in FDS_TEST.zipcodeSet);

//clean company name 

veh_denorm_zip_clean := project(veh_denorm_zip,transform(wma.Layout_vehicle_FDS.liens.vehicles_temp_rec, 
self.lien_holder1_cname := datalib.companyclean(left.lien_holder1_cname),
self.lien_holder2_cname := datalib.companyclean(left.lien_holder2_cname),
self.lien_holder3_cname := datalib.companyclean(left.lien_holder3_cname),
self.VIN := trim(left.VIN, left, right),self := left));

veh_denorm_zip_dist := distribute(veh_denorm_zip_clean, hash(VIN,owner1_fname,owner1_lname,owner1_cname));

veh_denorm_dedup := dedup(sort(veh_denorm_zip_dist,VIN,
owner1_fname,owner1_mname, owner1_lname,owner1_cname,
owner1_street1, owner1_street2, owner1_city, owner1_state, owner1_zip, 
owner2_fname,owner2_mname, owner2_lname,owner2_cname,
owner2_street1, owner2_street2, owner2_city, owner2_state, owner2_zip,lien_holder1_fname,lien_holder1_mname, lien_holder1_lname,lien_holder1_cname,
lien_holder1_street1,lien_holder1_street2,lien_holder1_city,lien_holder1_state,lien_holder1_zip,
lien_holder2_fname,lien_holder2_mname, lien_holder2_lname,lien_holder2_cname,
lien_holder2_street1,lien_holder2_street2,lien_holder2_city,lien_holder2_state,lien_holder2_zip,
lien_holder3_fname,lien_holder3_mname, lien_holder3_lname,lien_holder3_cname,
lien_holder3_street1,lien_holder3_street2,lien_holder3_city,lien_holder3_state,lien_holder3_zip,vehicle_make_description, vehicle_model_description,


-Date_Vendor_Last_Reported,-Orig_lien_Date,-Ttl_Latest_Issue_Date,local), VIN,owner1_fname,owner1_mname, owner1_lname,owner1_cname,
owner1_street1, owner1_street2, owner1_city, owner1_state, owner1_zip, 
owner2_fname,owner2_mname, owner2_lname,owner2_cname,
owner2_street1, owner2_street2, owner2_city, owner2_state, owner2_zip,lien_holder1_fname,lien_holder1_mname, lien_holder1_lname,lien_holder1_cname,
lien_holder1_street1,lien_holder1_street2,lien_holder1_city,lien_holder1_state,lien_holder1_zip,
lien_holder2_fname,lien_holder2_mname, lien_holder2_lname,lien_holder2_cname,
lien_holder2_street1,lien_holder2_street2,lien_holder2_city,lien_holder2_state,lien_holder2_zip,
lien_holder3_fname,lien_holder3_mname, lien_holder3_lname,lien_holder3_cname,
lien_holder3_street1,lien_holder3_street2,lien_holder3_city,lien_holder3_state,lien_holder3_zip,vehicle_make_description, vehicle_model_description,local);


keep5 := dedup(sort(veh_denorm_dedup,VIN,owner1_fname,owner1_lname,owner1_cname,owner2_fname,owner2_lname,owner2_cname,-Date_Vendor_Last_Reported,-Ttl_Latest_Issue_Date,-Orig_Lien_Date,local), VIN,owner1_fname,owner1_lname,owner1_cname,owner2_fname,owner2_lname,owner2_cname,local, keep 5);

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


wma.Layout_vehicle_FDS.liens.zipextract textractfinal(Keep5ID le) := transform

self.sourcezip := map(le.owner1_zip in FDS_TEST.zipcodeSet => le.owner1_zip,
                      le.owner2_zip in FDS_TEST.zipcodeSet => le.owner2_zip,'');


self.Orig_Lien_Date := le.Orig_Lien_Date[5..8]+le.Orig_Lien_Date[1..4];
self.Ttl_Latest_Issue_Date := le.Ttl_Latest_Issue_Date[5..8]+le.Ttl_Latest_Issue_Date[1..4];
self.date_vendor_last_reported := if((unsigned)le.date_vendor_last_reported <> 0, (string)le.date_vendor_last_reported[5..6] + '00' + (string)le.date_vendor_last_reported[1..4], '');

self := le;

end;

veh_extract := project(Keep5ID, textractfinal(left));
veh_extract_sort := sort(veh_extract,sourcezip,record_id);

output(choosen(veh_extract_sort,1000), named('Vehicle_Lien_FDS_Extract'));

output(choosen(sort(veh_extract_sort, -Orig_Lien_Date[5..8],-date_vendor_last_reported[5..8],-Ttl_Latest_Issue_Date[5..8]),1000), named('Vehicle_Lien_FDS_Extract_sort_by_dates'));

output(veh_extract_sort(VIN = '1FTDF182XVNC50853'));
output(veh_extract_sort(VIN = '1J4FA49S0YP791260'));

output(veh_extract_sort,,'~thor_data400::out::fds_test::assets::vehicle_lien_extract_fixed_fmt_new',overwrite);

dFDSVehicleExtract			:=	output(veh_extract_sort,,'~thor_data400::out::fds_test::assets::vehicle_lien_extract_new',csv(heading(single),separator('|'),terminator('\n')),__compressed__,overwrite);

fill_rate_vehicle_rec :=
  record
    CountGroup                          := count(group);
		Sourcezip_CountNonBlank              := AVE(group,if(veh_extract.sourcezip<>'',100,0));

	Recordid_CountNonBlank              := AVE(group,if(veh_extract.Record_id<>'',100,0));
   
	owner1_fname_CountNonBlank					:= AVE(group,if(veh_extract.owner1_fname<>'',100,0));
	owner1_mname_CountNonBlank			:= AVE(group,if(veh_extract.owner1_mname<>'',100,0));
	owner1_lname_CountNonBlank           := AVE(group,if(veh_extract.owner1_lname<>'',100,0));
    owner1_cname_CountNonBlank     := AVE(group,if(veh_extract.owner1_cname<>'',100,0));
    owner1_street1_CountNonBlank       := AVE(group,if(veh_extract.owner1_street1<>'',100,0));
    owner1_street2_CountNonBlank             := AVE(group,if(veh_extract.owner1_street2<>'',100,0));
    owner1_city_CountNonBlank         := AVE(group,if(veh_extract.owner1_city<>'',100,0));
    owner1_state_CountNonBlank       := AVE(group,if(veh_extract.owner1_state<>'',100,0));
    owner1_zip_CountNonBlank             := AVE(group,if(veh_extract.owner1_zip<>'',100,0));
	owner2_fname_CountNonBlank					:= AVE(group,if(veh_extract.owner2_fname<>'',100,0));
	owner2_mname_CountNonBlank			:= AVE(group,if(veh_extract.owner2_mname<>'',100,0));
	owner2_lname_CountNonBlank           := AVE(group,if(veh_extract.owner2_lname<>'',100,0));
    owner2_cname_CountNonBlank     := AVE(group,if(veh_extract.owner2_cname<>'',100,0));
    owner2_street1_CountNonBlank       := AVE(group,if(veh_extract.owner2_street1<>'',100,0));
    owner2_street2_CountNonBlank             := AVE(group,if(veh_extract.owner2_street2<>'',100,0));
    owner2_city_CountNonBlank         := AVE(group,if(veh_extract.owner2_city<>'',100,0));
    owner2_state_CountNonBlank       := AVE(group,if(veh_extract.owner2_state<>'',100,0));
    owner2_zip_CountNonBlank             := AVE(group,if(veh_extract.owner2_zip<>'',100,0));	
	lien_holder1_fname_CountNonBlank					:= AVE(group,if(veh_extract.lien_holder1_fname<>'',100,0));
	lien_holder1_mname_CountNonBlank			:= AVE(group,if(veh_extract.lien_holder1_mname<>'',100,0));
	lien_holder1_lname_CountNonBlank           := AVE(group,if(veh_extract.lien_holder1_lname<>'',100,0));
    lien_holder1_cname_CountNonBlank     := AVE(group,if(veh_extract.lien_holder1_cname<>'',100,0));
    lien_holder1_street1_CountNonBlank       := AVE(group,if(veh_extract.lien_holder1_street1<>'',100,0));
    lien_holder1_street2_CountNonBlank             := AVE(group,if(veh_extract.lien_holder1_street2<>'',100,0));
    lien_holder1_city_CountNonBlank         := AVE(group,if(veh_extract.lien_holder1_city<>'',100,0));
    lien_holder1_state_CountNonBlank       := AVE(group,if(veh_extract.lien_holder1_state<>'',100,0));
    lien_holder1_zip_CountNonBlank             := AVE(group,if(veh_extract.lien_holder1_zip<>'',100,0));
	lien_holder2_fname_CountNonBlank					:= AVE(group,if(veh_extract.lien_holder2_fname<>'',100,0));
	lien_holder2_mname_CountNonBlank			:= AVE(group,if(veh_extract.lien_holder2_mname<>'',100,0));
	lien_holder2_lname_CountNonBlank           := AVE(group,if(veh_extract.lien_holder2_lname<>'',100,0));
    lien_holder2_cname_CountNonBlank     := AVE(group,if(veh_extract.lien_holder2_cname<>'',100,0));
    lien_holder2_street1_CountNonBlank       := AVE(group,if(veh_extract.lien_holder2_street1<>'',100,0));
    lien_holder2_street2_CountNonBlank             := AVE(group,if(veh_extract.lien_holder2_street2<>'',100,0));
    lien_holder2_city_CountNonBlank         := AVE(group,if(veh_extract.lien_holder2_city<>'',100,0));
    lien_holder2_state_CountNonBlank       := AVE(group,if(veh_extract.lien_holder2_state<>'',100,0));
    lien_holder2_zip_CountNonBlank             := AVE(group,if(veh_extract.lien_holder2_zip<>'',100,0));
	lien_holder3_fname_CountNonBlank					:= AVE(group,if(veh_extract.lien_holder3_fname<>'',100,0));
	lien_holder3_mname_CountNonBlank			:= AVE(group,if(veh_extract.lien_holder3_mname<>'',100,0));
	lien_holder3_lname_CountNonBlank           := AVE(group,if(veh_extract.lien_holder3_lname<>'',100,0));
    lien_holder3_cname_CountNonBlank     := AVE(group,if(veh_extract.lien_holder3_cname<>'',100,0));
    lien_holder3_street1_CountNonBlank       := AVE(group,if(veh_extract.lien_holder3_street1<>'',100,0));
    lien_holder3_street2_CountNonBlank             := AVE(group,if(veh_extract.lien_holder3_street2<>'',100,0));
    lien_holder3_city_CountNonBlank         := AVE(group,if(veh_extract.lien_holder3_city<>'',100,0));
    lien_holder3_state_CountNonBlank       := AVE(group,if(veh_extract.lien_holder3_state<>'',100,0));
    lien_holder3_zip_CountNonBlank             := AVE(group,if(veh_extract.lien_holder3_zip<>'',100,0));
	VIN_CountNonBlank                	:= AVE(group,if(veh_extract.VIN<>'',100,0));

	 vehicle_make_description_CountNonBlank            := AVE(group,if(veh_extract.vehicle_make_description<>'',100,0));
    vehicle_model_description_CountNonBlank           := AVE(group,if(veh_extract.vehicle_model_description<>'',100,0));
		ttl_latest_issue_Date_CountNonBlank         := AVE(group,if(veh_extract.ttl_latest_issue_Date<>'',100,0));

	Orig_lien_Date_CountNonBlank         := AVE(group,if(veh_extract.Orig_lien_Date<>'',100,0));
    date_vendor_last_reported_CountNonBlank       := AVE(group,if(veh_extract.date_vendor_last_reported<>'',100,0));
   // history_CountNonBlank             := AVE(group,if(veh_extract.history<>'',100,0));
  end;

fill_rate_vehicle 			:= table(veh_extract
												,fill_rate_vehicle_rec
												,few);
												
												
		dFDSVehicleExtractStats			:= output(fill_rate_vehicle);

dFDSVehicleExtract;
dFDSVehicleExtractStats;

