import	_control,PRTE_CSV, BIPV2;

export	Proc_Build_VehicleV2_Keys(string	pIndexVersion)	:=
function
	// Get the previous key version that exists on prct roxie
	vPrevIndexVersion	:=	PRTE.GetDemoBuildVersion('VehicleV2Keys','N');

	// Get the key layout definitions
	rKeyVehicleV2__data_wildcard_public	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__data__vehiclev2__wildcard_public;
	end;

	rKeyVehicleV2__keymodelindex_public	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__vehiclev2__keymodelindex_public;
	end;

	rKeyVehicleV2__keynameindex_public	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__vehiclev2__keynameindex_public;
	end;

	rKeyVehicleV2__autokey__address	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__vehiclev2__autokey__address;
	end;
	
	rKeyVehicleV2__autokey__addressb2	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__vehiclev2__autokey__addressb2;
	end;
	
	rKeyVehicleV2__autokey__citystname	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__VehicleV2__autokey__citystname;
	end;
	
	rKeyVehicleV2__autokey__citystnameb2	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__VehicleV2__autokey__citystnameb2;
	end;
	
	rKeyVehicleV2__autokey__fein2	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__VehicleV2__autokey__fein2;
	end;
	
	rKeyVehicleV2__autokey__name	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__VehicleV2__autokey__name;
	end;
	
	rKeyVehicleV2__autokey__nameb2	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__VehicleV2__autokey__nameb2;
	end;
	
	rKeyVehicleV2__autokey__namewords2	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__VehicleV2__autokey__namewords2;
	end;
	
	rKeyVehicleV2__autokey__payload	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__VehicleV2__autokey__payload;
	end;
	
	rKeyVehicleV2__autokey__ssn2	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__VehicleV2__autokey__ssn2;
	end;
	
	rKeyVehicleV2__autokey__stname	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__VehicleV2__autokey__stname;
	end;
	
	rKeyVehicleV2__autokey__stnameb2	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__VehicleV2__autokey__stnameb2;
	end;
	
	rKeyVehicleV2__autokey__zip	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__VehicleV2__autokey__zip;
	end;
		
	rKeyVehicleV2__autokey__zipb2	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__VehicleV2__autokey__zipb2;
	end;
	
	rKeyVehicleV2__bdid	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__vehiclev2__bdid;
	end;
	
	rKeyVehicleV2__bocashell_did	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__vehiclev2__bocashell_did
 END;
		
	rKeyVehicleV2__did	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__VehicleV2__did;
	end;
	
	rKeyVehicleV2__dl_number	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__vehiclev2__dl_number;
	end;

	rKeyVehicleV2__lic_plate	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__vehiclev2__lic_plate;
	end;
	
	rKeyVehicleV2__lic_plate_blur	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__vehiclev2__lic_plate_blur;
	end;

	rKeyVehicleV2__linkids	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__vehiclev2__linkids;
	end;	
	
//Add changes introduced in verson 20120803, but not checked in
	rKeyVehicleV2__main_key	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__vehiclev2__main_key;
		  string1 branded_title_flag;
  string3 brand_code_1;
  string10 brand_date_1;
  string2 brand_state_1;
  string3 brand_code_2;
  string10 brand_date_2;
  string2 brand_state_2;
  string3 brand_code_3;
  string10 brand_date_3;
  string2 brand_state_3;
  string3 brand_code_4;
  string10 brand_date_4;
  string2 brand_state_4;
  string3 brand_code_5;
  string10 brand_date_5;
  string2 brand_state_5;
  string1 tod_flag;
  string3 model_class_code;
  string50 model_class;
  string2 min_door_count;
  string3 safety_type;
  string50 airbag_driver;
  string50 airbag_front_driver_side;
  string50 airbag_front_head_curtain;
  string50 airbag_front_pass;
  string50 airbag_front_pass_side;
  string50 airbags;

	end;

	//DF-17145. Add MFD search key
	rKeyVehicleV2__mdf_srch	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__vehiclev2__mfd_srch;
	end;	
	
	//Layout change in bug Bug 124446
	rKeyVehicleV2__party_key	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__vehiclev2__party_key	-	__internal_fpos__;	// Removing the internal_fpos as during the key build process, this field was being added automatically by the build index
		string8	SRC_FIRST_DATE	:= '';
		string8	SRC_LAST_DATE	:= '';
		STRING70	std_lienholder_name	:=	'';
		BIPV2.IDlayouts.l_xlink_ids;
		string1 filler := '';
	end;

	rKeyVehicleV2__party_key_linkids	:=
	record
 		PRTE_CSV.VehicleV2.rthor_data400__key__party_key_linkids;
	end;

	rKeyVehicleV2__reverse_lic_plate	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__vehiclev2__reverse_lic_plate;
	end;

	rKeyVehicleV2__source_rec_id	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__source_rec_id;
	end;

	rKeyVehicleV2__title_number	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__vehiclev2__title_number;
	end;

	rKeyVehicleV2__vehicles_address	:=
	record	
		PRTE_CSV.VehicleV2.rthor_data400__key__vehiclev2__vehicles_address	
	end;
	
	rKeyVehicleV2__vin	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__key__vehiclev2__vin;
	end;	

	rKeyVehicleV2__wc_vehicle_bodystyle	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__wc_vehicle_bodystyle;
	end;

	rKeyVehicleV2__wc_vehicle_make	:=
	record
		PRTE_CSV.VehicleV2.rthor_data400__wc_vehicle_make;
	end;

	// Reformat the csv datasets to the layouts defined above
	ds_data_wildcard_public				:= 	project(PRTE_CSV.VehicleV2.dthor_data400__data__vehiclev2__wildcard_public,rKeyVehicleV2__data_wildcard_public);
	ds_key_keymodelindex_public		:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__keymodelindex_public,rKeyVehicleV2__keymodelindex_public);
	ds_key_keynameindex_public		:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__keynameindex_public,rKeyVehicleV2__keynameindex_public);
	ds_key_autokey__address				:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__autokey__address,rKeyVehicleV2__autokey__address);
	ds_key_autokey__addressb2			:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__autokey__addressb2,rKeyVehicleV2__autokey__addressb2);
	ds_key_autokey__citystname		:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__autokey__citystname,rKeyVehicleV2__autokey__citystname);
	ds_key_autokey__citystnameb2	:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__autokey__citystnameb2,rKeyVehicleV2__autokey__citystnameb2);
	ds_key_autokey__fein2					:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__autokey__fein2,rKeyVehicleV2__autokey__fein2);
	ds_key_autokey__name					:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__autokey__name,rKeyVehicleV2__autokey__name);
	ds_key_autokey__nameb2				:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__autokey__nameb2,rKeyVehicleV2__autokey__nameb2);
	ds_key_autokey__namewords2		:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__autokey__namewords2,rKeyVehicleV2__autokey__namewords2);
	ds_key_autokey__payload				:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__autokey__payload,rKeyVehicleV2__autokey__payload);
	ds_key_autokey__ssn2					:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__autokey__ssn2,rKeyVehicleV2__autokey__ssn2);
	ds_key_autokey__stname				:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__autokey__stname,rKeyVehicleV2__autokey__stname);
	ds_key_autokey__stnameb2			:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__autokey__stnameb2,rKeyVehicleV2__autokey__stnameb2);
	ds_key_autokey__zip						:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__autokey__zip,rKeyVehicleV2__autokey__zip);
	ds_key_autokey__zipb2					:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__autokey__zipb2,rKeyVehicleV2__autokey__zipb2);	
	ds_key__bdid									:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__bdid,rKeyVehicleV2__bdid);
	ds_key__bocashell_did					:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__bocashell_did,rKeyVehicleV2__bocashell_did);
	ds_key__did										:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__did,rKeyVehicleV2__did);
	ds_key__dl_number							:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__dl_number,rKeyVehicleV2__dl_number);
	ds_key__lic_plate							:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__lic_plate,rKeyVehicleV2__lic_plate);
	ds_key__lic_plate_blur				:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__lic_plate_blur,rKeyVehicleV2__lic_plate_blur);
	ds_key__linkids	 							:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__linkids,rKeyVehicleV2__linkids);	
	ds_key__main_key		 					:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__main_key,transform(rKeyVehicleV2__main_key, self:= left, self := []));
	ds_key__mdf_srch		 					:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__mfd_srch,transform(rKeyVehicleV2__mdf_srch, self:= left, self := []));
	ds_key__party_key							:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__party_key,rKeyVehicleV2__party_key);
	ds_key__reverse_lic_plate			:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__reverse_lic_plate,rKeyVehicleV2__reverse_lic_plate);
	ds_key__source_rec_id					:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__source_rec_id,rKeyVehicleV2__source_rec_id);	
	ds_key__party_key_linkids			:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__party_key_linkids,rKeyVehicleV2__party_key_linkids);	
	ds_key__title_number					:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__title_number,rKeyVehicleV2__title_number);
	ds_key__vehicles_address			:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__vehicles_address,rKeyVehicleV2__vehicles_address);	
	ds_key__vin										:= 	project(PRTE_CSV.VehicleV2.dthor_data400__key__Vehiclev2__vin,rKeyVehicleV2__vin);
	ds_key__wc_vehicle_bodystyle	:= 	project(PRTE_CSV.VehicleV2.dthor_data400__wc_vehicle_bodystyle,rKeyVehicleV2__wc_vehicle_bodystyle);
	ds_key__wc_vehicle_make				:= 	project(PRTE_CSV.VehicleV2.dthor_data400__wc_vehicle_make,rKeyVehicleV2__wc_vehicle_make);

	// Index definitions for keys
	kKey_keymodelindex_public		:=	index(ds_key_keymodelindex_public,{str,i},{ds_key_keymodelindex_public},'~prte::key::vehicle::' + pIndexVersion + '::keymodelindex_public');
	kKey_keynameindex_public		:=	index(ds_key_keynameindex_public,{str,i},{ds_key_keynameindex_public},'~prte::key::vehicle::' + pIndexVersion + '::keynameindex_public');
	kKey_autokey_address				:=	index(ds_key_autokey__address,{prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups},{ds_key_autokey__address},'~prte::key::vehiclev2::' + pIndexVersion + '::autokey::address');
	kKey_autokey_addressb2			:=	index(ds_key_autokey__addressb2,{prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid},{ds_key_autokey__addressb2},'~prte::key::vehiclev2::' + pIndexVersion + '::autokey::addressb2');
	kKey_autokey_citystname			:=	index(ds_key_autokey__citystname,{city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{ds_key_autokey__citystname},'~prte::key::vehiclev2::' + pIndexVersion + '::autokey::citystname');
	kKey_autokey_citystnameb2		:=	index(ds_key_autokey__citystnameb2,{city_code,st,cname_indic,cname_sec,bdid},{ds_key_autokey__citystnameb2},'~prte::key::vehiclev2::' + pIndexVersion + '::autokey::citystnameb2');
	kKey_autokey_fein2					:=	index(ds_key_autokey__fein2,{f1,f2,f3,f4,f5,f6,f7,f8,f9,cname_indic,cname_sec,bdid},{ds_key_autokey__fein2},'~prte::key::vehiclev2::' + pIndexVersion + '::autokey::fein2');
	kKey_autokey_name						:=	index(ds_key_autokey__name,{dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{ds_key_autokey__name},'~prte::key::vehiclev2::' + pIndexVersion + '::autokey::name');
	kKey_autokey_nameb2					:=	index(ds_key_autokey__nameb2,{cname_indic,cname_sec,bdid},{ds_key_autokey__nameb2},'~prte::key::vehiclev2::' + pIndexVersion + '::autokey::nameb2');
	kKey_autokey_namewords2			:=	index(ds_key_autokey__namewords2,{word,state,seq,bdid},{ds_key_autokey__namewords2},'~prte::key::vehiclev2::' + pIndexVersion + '::autokey::namewords2');
	kKey_autokey_payload				:=	index(ds_key_autokey__payload,{fakeid},{ds_key_autokey__payload},'~prte::key::vehiclev2::' + pIndexVersion + '::autokey::payload');
	kKey_autokey_ssn2						:=	index(ds_key_autokey__ssn2,{s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did},{ds_key_autokey__ssn2},'~prte::key::vehiclev2::' + pIndexVersion + '::autokey::ssn2');
	kKey_autokey_stname					:=	index(ds_key_autokey__stname,{st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{ds_key_autokey__stname},'~prte::key::vehiclev2::' + pIndexVersion + '::autokey::stname');
	kKey_autokey_stnameb2				:=	index(ds_key_autokey__stnameb2,{st,cname_indic,cname_sec,bdid},{ds_key_autokey__stnameb2},'~prte::key::vehiclev2::' + pIndexVersion + '::autokey::stnameb2');
	kKey_autokey_zip						:=	index(ds_key_autokey__zip,{zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{ds_key_autokey__zip},'~prte::key::vehiclev2::' + pIndexVersion + '::autokey::zip');
	kKey_autokey_zipb2					:=	index(ds_key_autokey__zipb2,{zip,cname_indic,cname_sec,bdid},{ds_key_autokey__zipb2},'~prte::key::vehiclev2::' + pIndexVersion + '::autokey::zipb2');
	kKey_bdid										:=	index(ds_key__bdid,{Append_BDID},{Vehicle_Key,Iteration_Key,Sequence_Key},'~prte::key::vehiclev2::' + pIndexVersion + '::bdid');
	kKey_bocashell_did					:=	index(ds_key__bocashell_did,{DID},{ds_key__bocashell_did},'~prte::key::vehiclev2::' + pIndexVersion + '::bocashell_did');
	kKey_did										:=	index(ds_key__did,{Append_DID,is_minor},{Vehicle_Key,Iteration_Key,Sequence_Key},'~prte::key::vehiclev2::' + pIndexVersion + '::did');
	kKey_dl_number							:=	index(ds_key__dl_number,{DL_number,state_origin,is_minor},{Vehicle_Key,Iteration_Key,Sequence_Key},'~prte::key::vehiclev2::' + pIndexVersion + '::dl_number');
	kKey_lic_plate							:=	index(ds_key__lic_plate,{license_plate,state_origin,dph_lname,pfname,is_minor},{ds_key__lic_plate},'~prte::key::vehiclev2::' + pIndexVersion + '::lic_plate');
	kKey_lic_plate_blur					:=	index(ds_key__lic_plate_blur,{license_plate_blur},{ds_key__lic_plate_blur},'~prte::key::vehiclev2::' + pIndexVersion + '::lic_plate_blur');
	kKey_vehiclev2_linkids			:= 	index(ds_key__linkids,{ultid,orgid,seleid,proxid,powid,empid,dotid},{ds_key__linkids}, '~prte::key::vehiclev2::' + pIndexVersion + '::linkids');
	kKey_main_key								:=	index(ds_key__main_key,{Vehicle_Key,Iteration_Key},{ds_key__main_key},'~prte::key::vehiclev2::' + pIndexVersion + '::main_key');
	kKey_mfd_srch								:=	index(ds_key__mdf_srch,{zip5, prim_range,prim_name,suffix,predir,postdir},{ds_key__mdf_srch},'~prte::key::vehiclev2::' + pIndexVersion + '::mfd_srch');
	kKey_party_key							:=	index(ds_key__party_key,{Vehicle_Key,Iteration_Key,Sequence_Key},{ds_key__party_key},'~prte::key::vehiclev2::' + pIndexVersion + '::party_key');
	kKey_party_key_linkids			:=	index(ds_key__party_key_linkids,{Vehicle_Key,Iteration_Key,Sequence_Key},{ds_key__party_key_linkids},'~prte::key::vehiclev2::' + pIndexVersion + '::party_key::linkids');
	kKey_reverse_lic_plate			:=	index(ds_key__reverse_lic_plate,{reverse_license_plate,state_origin,dph_lname,pfname,is_minor},{ds_key__reverse_lic_plate},'~prte::key::vehiclev2::' + pIndexVersion + '::reverse_lic_plate');
	kKey_source_rec_id					:=	index(ds_key__source_rec_id,{source_rec_id},{ds_key__source_rec_id},'~prte::key::vehiclev2::' + pIndexVersion + '::source_rec_id');	
	kKey_title_number						:=	index(ds_key__title_number,{ttl_number,state_origin},{Vehicle_Key,Iteration_Key,Sequence_Key},'~prte::key::vehiclev2::' + pIndexVersion + '::title_number');
	kKey_vehicles_address				:= 	index(ds_key__vehicles_address,{zip5,prim_range,prim_name,suffix,predir},{ds_key__vehicles_address},'~prte::key::vehiclev2::' + pIndexVersion + '::vehicles_address');
	kKey_vin										:=	index(ds_key__vin,{VIN,state_origin},{Vehicle_Key,Iteration_Key},'~prte::key::vehiclev2::' + pIndexVersion + '::vin');
	kKey_wc_vehicle_bodystyle		:=	index(ds_key__wc_vehicle_bodystyle,{body_style,i},{ds_key__wc_vehicle_bodystyle},'~prte::key::wc_vehicle::' + pIndexVersion + '::bodystyle');
	kKey_wc_vehicle_make				:=	index(ds_key__wc_vehicle_make,{makecode},{ds_key__wc_vehicle_make},'~prte::key::wc_vehicle::' + pIndexVersion + '::make');
	
	return	sequential(
											parallel(	//fixed file introduced in 2013-02-21T13:53:09Z (Sandy Butler)
															  output(ds_data_wildcard_public,,'~prte::data::vehicle::' + pIndexVersion + '::wildcard_public', overwrite),	
																build(kKey_keymodelindex_public		,update),
																build(kKey_keynameindex_public		,update),
																build(kKey_autokey_address				,update),
																build(kKey_autokey_addressb2			,update),
																build(kKey_autokey_citystname			,update),
																build(kKey_autokey_citystnameb2		,update),
																build(kKey_autokey_fein2					,update),
																build(kKey_autokey_name						,update),
																build(kKey_autokey_nameb2					,update),
																build(kKey_autokey_namewords2			,update),
																build(kKey_autokey_payload				,update),
																build(kKey_autokey_ssn2						,update),
																build(kKey_autokey_stname					,update),
																build(kKey_autokey_stnameb2				,update),
																build(kKey_autokey_zip						,update),
																build(kKey_autokey_zipb2					,update),
																build(kKey_bdid										,update),
																build(kKey_bocashell_did					,update),
																build(kKey_did										,update),												
																build(kKey_dl_number							,update),
																build(kKey_lic_plate							,update),
																build(kKey_lic_plate_blur					,update),
																build(kKey_vehiclev2_linkids			,update),																
																build(kKey_main_key								,update),
																build(kKey_mfd_srch								,update),			//DF-17145
																build(kKey_party_key							,update),
																build(kKey_party_key_linkids			,update),																
																build(kKey_reverse_lic_plate			,update),
																build(kKey_source_rec_id					,update),																
																build(kKey_title_number						,update),
																build(kKey_vehicles_address				,update),																
																build(kKey_vin										,update),
																build(kKey_wc_vehicle_bodystyle		,update),	
																build(kKey_wc_vehicle_make				,update),																		
																PRTE.copymissingkeys('VehicleV2Keys',pIndexVersion,vPrevIndexVersion)
															),
											PRTE.UpdateVersion(	'VehicleV2Keys',											//	Package name
																					pIndexVersion,												//	Package version
																					_control.MyInfo.EmailAddressNormal,		//	Who to email with specifics
																					'B',																	//	B = Boca,A = Alpharetta
																					'N',																	//	N = Non-FCRA,F = FCRA
																					'N'																		//	N = Do not also include boolean,Y = Include boolean,too
																				)
										);
end;