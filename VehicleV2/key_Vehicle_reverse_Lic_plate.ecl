import VehicleV2, VehLic, Doxie, ut,lib_StringLib, NID;

get_recs	:= distribute(VehicleV2.file_VehicleV2_Party_Clean_Sequence_Key,hash(vehicle_key,iteration_key,sequence_key));

//slim_party := table(get_recs(reg_true_license_plate != '' or Reg_License_Plate != ''), {reg_true_license_plate, Reg_License_Plate, Vehicle_Key, Iteration_Key, Sequence_Key, state_origin});

slim_rec := record

string10 reverse_license_plate;
string30 Vehicle_Key;
string15 Iteration_Key;
string15 Sequence_Key;
string2  reg_previous_license_state;
string2  state_origin;
string2  st;
string2  Reg_License_State;
string2  state;
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
end;



reverse_lic_plate_rec := record

string10 reverse_license_plate;
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
end;

slim_rec tnormalizeplate(get_recs L, integer cnt) := transform

self.reverse_license_plate := StringLib.StringReverse(trim(choose(cnt, L.reg_true_license_plate, L.Reg_License_Plate, l.Reg_Previous_License_Plate)));
self.st := L.append_clean_address.st;
self.state := '';
self := l.append_clean_name;
self := l.append_clean_address;
self := L;
end;

party_plate_norm  := normalize(get_recs(reg_true_license_plate != '' or Reg_License_Plate != '' or Reg_Previous_License_Plate != ''),
		3, tnormalizeplate(left, counter));

slim_rec tnormalizestate(party_plate_norm L, integer cnt) := transform

self.state := choose(cnt, l.reg_previous_license_state,l.state_origin, L.st, l.Reg_License_State);
self := L;
end;

party_norm  := normalize(party_plate_norm(reg_previous_license_state != '' or state_origin != '' or st != '' or Reg_License_State != ''),
		4, tnormalizestate(left, counter));

reverse_lic_plate_rec tformat(party_norm L) := transform
self.state_origin := L.state;
self.is_current := l.orig_name_type in ['4','5'] and l.history='';
	age := ut.getage(l.orig_dob);
self.is_minor := if(age=0 or age>=18,FALSE,TRUE);
self.date :=(unsigned4) map(l.Reg_Latest_Effective_Date<>''=>l.Reg_Latest_Effective_Date,
								l.Reg_Latest_Expiration_Date<>''=>l.Reg_Latest_Expiration_Date,
								l.Ttl_Latest_Issue_Date);
self.use_ssn := if(l.orig_ssn<>'',l.orig_ssn,l.append_ssn);		
self.dph_lname :=	metaphonelib.DMetaPhone1(l.lname);			
self.pfname :=	NID.PreferredFirstVersionedStr(l.fname, NID.version);	
self := L;
end;

party_grp := group(sort(project(party_norm(reverse_license_plate <>'' and state <> ''), tformat(left)),
	vehicle_key,iteration_key,sequence_key,if(is_current,0,1),-date,  local),
	vehicle_key,iteration_key,sequence_key,local);

reverse_lic_plate_rec trickle_current_date(party_grp l,party_grp r,integer C):=transform
	self.is_current := if(C=1,r.is_current,l.is_current);
	self.date := if(C=1,r.date,l.date);
	self := r;
end;
	
party_iter := iterate(party_grp, trickle_current_date(left,right,counter));

party_dedup := ungroup(dedup(party_iter, all));

export Key_Vehicle_reverse_Lic_plate := index(party_dedup, {reverse_license_plate, state_origin,dph_lname,pfname,is_minor}, {party_dedup},
'~thor_data400::key::VehicleV2::reverse_lic_plate_'+ doxie.Version_SuperKey);
