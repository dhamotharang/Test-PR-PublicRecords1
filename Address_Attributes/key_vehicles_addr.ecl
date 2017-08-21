import	risk_indicators,VehicleV2,VehLic,Doxie,ut,lib_StringLib,NID;

get_recs	:=	distribute(VehicleV2.file_VehicleV2_Party_Clean_Sequence_Key,hash(vehicle_key,iteration_key,sequence_key));

slim_rec	:=
record
	string10 license_plate;
	string30 Vehicle_Key;
	string15 Iteration_Key;
	string15 Sequence_Key;
	string2  reg_previous_license_state;
	string2  state_origin;
	string2  st;
	string2  Reg_License_State;
	string2  state;
	string1  state_type;
	get_recs.orig_name_type;
	get_recs.history;
	get_recs.Reg_Latest_Effective_Date;
	get_recs.Reg_Latest_Expiration_Date;
	get_recs.Ttl_Latest_Issue_Date;
	get_recs.orig_dob;
	get_recs.orig_ssn;
	get_recs.append_ssn;
	get_recs.Append_Clean_Name.fname;
	get_recs.Append_Clean_Name.lname;
	get_recs.Append_Clean_Name.mname;
	get_recs.Append_Clean_Address.predir;
	get_recs.Append_Clean_Address.prim_name;
	get_recs.Append_Clean_Address.prim_range;
	get_recs.Append_Clean_Address.addr_suffix;
	get_recs.Append_Clean_Address.postdir;
	get_recs.Append_Clean_Address.sec_range;
	get_recs.Append_Clean_Address.v_city_name;
	get_recs.Append_Clean_Address.zip5;
	get_recs.Append_Clean_Cname;
	//added for address key
	get_recs.Append_Clean_Address.fips_county;
	get_recs.Append_Clean_Address.geo_lat;
	get_recs.Append_Clean_Address.geo_long;
	get_recs.Append_Clean_Address.geo_blk;
	get_recs.Append_Clean_Address.geo_match;
end;

lic_plate_rec	:=
record
	string10 license_plate;
	string30 Vehicle_Key;
	string15 Iteration_Key;
	string15 Sequence_Key;
	string2  state_origin;
	boolean is_current;
	boolean is_minor;
	unsigned4 date;
	string6 dph_lname;
	string20 pfname;
	get_recs.orig_dob;
	string9 use_ssn;
	get_recs.Append_Clean_Name.fname;
	get_recs.Append_Clean_Name.lname;
	get_recs.Append_Clean_Name.mname;
	get_recs.Append_Clean_Address.predir;
	get_recs.Append_Clean_Address.prim_name;
	get_recs.Append_Clean_Address.prim_range;
	get_recs.Append_Clean_Address.addr_suffix;
	get_recs.Append_Clean_Address.postdir;
	get_recs.Append_Clean_Address.sec_range;
	get_recs.Append_Clean_Address.v_city_name;
	get_recs.Append_Clean_Address.zip5;
	get_recs.Append_Clean_Cname;
	string1 state_type;
	//added for address key
	get_recs.Append_Clean_Address.fips_county;
	get_recs.Append_Clean_Address.geo_lat;
	get_recs.Append_Clean_Address.geo_long;
	get_recs.Append_Clean_Address.geo_blk;
	get_recs.Append_Clean_Address.geo_match;
end;

slim_rec	tnormalizeplate(get_recs L,integer cnt)	:=
transform
	self.license_plate	:=	trim(choose(cnt,L.reg_true_license_plate,L.Reg_License_Plate,l.Reg_Previous_License_Plate),all);
	// set to C for previous registered state
	self.state_type			:=	if(cnt=3,'C','');
	self.st							:=	L.append_clean_address.st;
	self.state					:=	if(cnt=3,l.reg_previous_license_state,'');
	self								:=	l.append_clean_name;
	self								:=	l.append_clean_address;
	self								:=	L;
end;

party_plate_norm 	:=	normalize(	get_recs(reg_true_license_plate	!=	''	or	Reg_License_Plate	!=	''	or	Reg_Previous_License_Plate	!=	''),
																	3,
																	tnormalizeplate(left,counter),
																	local
																);

slim_rec	tnormalizestate(party_plate_norm L,integer cnt)	:=
transform
	self.state			:=	choose(cnt,l.state_origin,l.st,l.Reg_License_State);
	// set to A for state_origin and B for st
	self.state_type	:=	if(cnt	=	1,'A','B');
	self						:=	L;
end;

party_norm 	:=	normalize(	party_plate_norm((state_origin	!=	''	or	st	!=	''	or	Reg_License_State	!=	'')	and	state_type	<>	'C'),
														3,
														tnormalizestate(left,counter),
														local
													);
		
party_norm_all	:=	party_norm	+	party_plate_norm(state_type	=	'C');		

lic_plate_rec	tformat(party_norm_all	L)	:=
transform
	age								:=	ut.getage(l.orig_dob);
	
	self.state_origin	:=	L.state;
	self.is_current		:=	l.orig_name_type	in	['4','5']	and	l.history	=	'';
	self.is_minor			:=	if(age	=	0	or	age	>=	18,FALSE,TRUE);
	self.date					:=	(unsigned4)map(	l.Reg_Latest_Effective_Date		<>	''	=>	l.Reg_Latest_Effective_Date,
																				l.Reg_Latest_Expiration_Date	<>	''	=>l.Reg_Latest_Expiration_Date,
																				l.Ttl_Latest_Issue_Date
																			);
	self.use_ssn			:=	if(l.orig_ssn	<>	'',l.orig_ssn,l.append_ssn);		
	self.dph_lname		:=	metaphonelib.DMetaPhone1(l.lname);			
	self.pfname				:=	NID.PreferredFirstVersionedStr(l.fname, NID.version);	
	self							:=	L;
end;

party_grp	:=	group(	sort(	project(party_norm_all(license_plate	<>	''	and	state	<>	''),tformat(left)),
														vehicle_key,iteration_key,sequence_key,if(is_current,0,1),-date,
														local
													),
											vehicle_key,iteration_key,sequence_key,
											local
										);

lic_plate_rec	trickle_current_date(party_grp l,party_grp r,integer C)	:=
transform
	self.is_current	:=	if(C=1,r.is_current,l.is_current);
	self.date				:=	if(C=1,r.date,l.date);
	self						:=	r;
end;
	
party_iter	:=	iterate(party_grp,trickle_current_date(left,right,counter));

// Dedup all fields except state_type because since its sorted by state_type (sorted by record
//but this sort should put state_type in ascending order),the records that have
// the same state origin as the other state fields will keep 'A' in this field and thus we will know
// to keep this record in the moxie search,since the moxie search wants to keep only records where the
// state_origin matches the input state origin.
party_dedup	:=	ungroup(dedup(sort(party_iter,record),record,except	state_type));


//data sources
vehicle_addr 	:= party_dedup;
vehicle_main 	:= VehicleV2.file_VehicleV2_Main;

//layouts
layout_vehicle_address	:=
record
	string10 license_plate;
	string30 Vehicle_Key;
	string15 Iteration_Key;
	string15 Sequence_Key;
	string2  state_origin;
	boolean is_current;
	boolean is_minor;
	unsigned4 date;
	string6 dph_lname;
	string20 pfname;
	vehicle_addr.orig_dob;
	string9 use_ssn;
	vehicle_addr.fname;
	vehicle_addr.lname;
	vehicle_addr.mname;
	vehicle_addr.predir;
	vehicle_addr.prim_name;
	vehicle_addr.prim_range;
	vehicle_addr.addr_suffix;
	vehicle_addr.postdir;
	vehicle_addr.sec_range;
	vehicle_addr.v_city_name;
	vehicle_addr.zip5;
	vehicle_addr.Append_Clean_Cname;
	string1 state_type;
	vehicle_addr.fips_county;
	vehicle_addr.geo_lat;
	vehicle_addr.geo_long;
	vehicle_addr.geo_blk;
	vehicle_addr.geo_match;
end;


//filter vehicle_addr for current records and remove duplicates
vehicle_current	:=	dedup(	sort(vehicle_addr(is_current=true),vehicle_key,license_plate,local),
														vehicle_key,license_plate,
														local
													);

//join main to addr
address_attributes.layouts.vehicles	get_vehicles(vehicle_current l,vehicle_main r)	:=
transform
	//build geolink for neighborhood aggregation
	self.geolink			:=	l.state_origin	+	l.fips_county	+	l. geo_blk;
	self.suffix				:=	l.addr_suffix;
	self.p_city_name	:=	l.v_city_name;
	self.county				:=	l.fips_county;
	self.st						:=	l.state_origin;
	self							:=	l;
	self							:=	r;
	self							:=	[];
end;

vehicle_slim	:=	join(	distribute(vehicle_current,hash(vehicle_key)),
												distribute(vehicle_main,hash(vehicle_key)), 
												left.vehicle_key	=	right.vehicle_key,
												get_vehicles(left,right),
												left outer,
												local
											);

vehicle_slim_dist	:=	distribute(vehicle_slim,random());

cleaned	:=	vehicle_slim_dist(	zip5				!=	''	and 
																prim_range	!=	''	and 
																prim_name 	!=''
															);
								
export	key_vehicles_addr	:=	index(	cleaned,
																			{zip5,prim_range,prim_name,suffix,predir},
																			{cleaned},
																			'~thor_data400::key::vehiclev2::vehicles_address_'	+	doxie.Version_SuperKey
																		);

