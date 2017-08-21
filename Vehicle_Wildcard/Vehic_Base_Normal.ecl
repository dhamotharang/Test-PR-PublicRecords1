import vehiclev2,ut,Driversv2, Vehicle_Wildcard, STD;

fatrec := record
	vehicle_wildcard.Layout_BaseFile;
	string20 	customer_name;
	string9		FEID_ssn;
	string20 dl_number;
	string8		Reg_Latest_Expiration_Date;
	string2		Source_Code;
end;

//exclude Infutor vehicle and motorcycle -- Infutor data currently allowed after dedupe against other source data. Bug #162814
exclusion_list := ['1V', '2V'];

SSNIsValid(STRING9 ssn) := (INTEGER)ssn > 0;
ChooseSSN(STRING9 ssn1, STRING9 ssn2) := IF(SSNIsValid(ssn1), ssn1, ssn2);

j := join (distribute(VehicleV2.file_VehicleV2_Party,hash(vehicle_key)) , distribute(VehicleV2.file_VehicleV2_main,hash(vehicle_key)), left.vehicle_key = right.vehicle_key and left.iteration_key =right.iteration_key and left.source_code = right.source_code,
                transform({VehicleV2.file_VehicleV2_Party , string vin}, 
								self.VIN := if(right.VINA_VIN<>'', right.VINA_VIN, right.Orig_VIN), self:= left),local); 
								
j_dup := dedup(sort(distribute(j, hash(vin)),vin,history,-date_vendor_last_reported, local),vin, local);
 j_out := VehicleV2.file_VehicleV2_Party(source_code not in ['1V', '2V']) + project(j_dup(source_code in ['1V', '2V']),transform({VehicleV2.Layout_Base_Party-[SRC_FIRST_DATE, SRC_LAST_DATE]},self:=left)); 

	// Wildcard search allow Expired records
veh_latest  :=j_out(history ='' /*and source_code not in exclusion_list*/); 
veh_history := j_out(history <>''  /*and source_code not in exclusion_list*/);

his_exp := project(veh_history , transform( {VehicleV2.file_VehicleV2_Party}, 
 

                   self.history := if(trim(left.Reg_Latest_Expiration_Date,left,right) <> '' and left.Reg_Latest_Expiration_Date	>	(string4)((unsigned2)((STRING8) STD.Date.Today())[1..4]	-	1)	+	((STRING8) STD.Date.Today())[5..8],'E',
																			If(left.source_code in ['1V', '2V'],'U','H')),
                   self := left))+veh_latest;
									 
veh_d :=distribute(his_exp(
orig_name_type != '7'  and history ~in ['H']),hash(vehicle_key));

veh_d_reg :=dedup(sort(veh_d(orig_name_type='4' or source_code in ['1V', '2V']),vehicle_key,iteration_key,sequence_key,local),
	vehicle_key,iteration_key,
	sequence_key,local);


veh_use := join(veh_d,veh_d_reg,left.vehicle_key=right.vehicle_key and left.iteration_key=right.iteration_key
		and left.sequence_key = right.sequence_key and left.orig_name_type = right.orig_name_type,transform(VehicleV2.Layout_Base_party,  self:=left),keep(1),local);


// Normalize Vehicles
fatrec take_person(VehicleV2.Layout_Base_party l,VehicleV2.file_VehicleV2_main r) := 
TRANSFORM
		self.FEID_SSN := l.append_ssn;
		self.dob := IF((INTEGER)l.append_dob = 0, l.orig_dob, l.append_dob);
		self.prim_range := l.Append_Clean_Address.prim_range;
		self.predir := l.Append_Clean_Address.predir;
		self.prim_name := l.Append_Clean_Address.prim_name;
		self.suffix:= l.Append_Clean_Address.addr_suffix;
		self.postdir:= l.Append_Clean_Address.postdir;
		self.unit_desig:= l.Append_Clean_Address.unit_desig;
		self.sec_range := l.Append_Clean_Address.sec_range;
		self.zip5 := l.Append_Clean_Address.zip5;
		self.city := l.Append_Clean_Address.v_city_name;
		self.state := l.Append_Clean_Address.st;
		self.sex := l.orig_sex;
		self.customer_name := l.Append_Clean_CName;
		self.fname := 	 l.Append_Clean_Name.fname;
		self.mname := 	 l.Append_Clean_Name.mname;
		self.lname := 	 l.Append_Clean_Name.lname;
		self.name_suffix := l.Append_Clean_Name.name_suffix;
		self.PLATE_NUMBER := if(l.reg_true_license_plate<>'',l.reg_true_license_plate, l.reg_license_plate);
		self.VIN := if(r.VINA_VIN<>'', r.VINA_VIN, r.Orig_VIN);
		self.DID := l.append_did;
		self.ssn := ChooseSSN(l.orig_ssn, l.append_ssn);
		self.orig_state := if(l.Reg_License_State <> '',l.Reg_License_State,L.State_origin);

		self.Make_Code := r.Best_Make_Code;
		self.Major_Color_Code := r.Best_Major_Color_Code;
		self.Minor_Color_Code := r.Best_Minor_Color_Code;
		self.Body_Code := r.Best_Body_Code;
		self.Year_Make := r.Best_Model_Year;
		SELF.person_source := CASE((unsigned1) l.orig_name_type,
								1 => '1',
								2 => '2',
								4 => '3',
								5 => '4', '0');
		SELF.veh_id := 0;
		self.sequence_key := l.sequence_key;
		self.vehicle_type := if(r.VINA_Veh_Type <> '',r.Vina_Veh_Type,r.Orig_Vehicle_Type_Code);
		self.decal_year := l.reg_decal_year;
		self.decal_type := '';
		self.make_description := if(r.VINA_Make_desc<>'', r.VINA_Make_desc, r.Orig_Make_desc);
		self.model_description := if(r.VINA_Model_Desc<>'' or r.VINA_Series_Desc <> '', trim(r.VINA_Model_Desc,left, right) + ' ' + trim(r.VINA_Series_Desc,left, right), r.Orig_Model_Desc);
		self.record_type := '';
		self.dl_number := if(l.orig_dl_number <>'',l.orig_dl_number,l.append_dl_number);
		self := r;
		self := l;
END;

veh_w_main := JOIN(veh_use, 
	distribute(VehicleV2.file_VehicleV2_main/*(source_code not in exclusion_list)*/,hash(vehicle_key)), 
					LEFT.vehicle_key = RIGHT.vehicle_key and left.iteration_key = right.iteration_key, take_person(left,right),
					keep(1),local);
					
fatrec get_dl_fields(fatrec l,Driversv2.file_dl_search r):=transform
	self.sex := if(l.sex='',r.sex_flag,l.sex);
	self.dob := if(l.dob='',(string) r.dob,l.dob);
	self := l;
END;

veh_w_main_d	:= distribute(veh_w_main(did <> 0), hash(did));
file_dl_d			:= distribute(Driversv2.file_dl_search(did <> 0), hash(did));

veh_w_dobgen1 := JOIN(veh_w_main_d,file_dl_d,
	left.did=right.did,get_dl_fields(left,right),keep(1), left outer, local);

veh_w_dlfields := veh_w_dobgen1 + veh_w_main(did=0);
	
veh_dups := veh_w_dlfields(lname <> '' or customer_name <> '');

veh_norm_dist := DISTRIBUTE(veh_dups, HASH(fname, mname, lname, customer_name, dob, 
												model_description, make_description, PLATE_NUMBER,
												ssn, did));
												
veh_norm_sort := SORT(veh_norm_dist, fname, mname, lname, customer_name, dob, model_description,
									 make_description, PLATE_NUMBER, ssn, did, state,history,-Reg_Latest_Expiration_Date, LOCAL);

veh_norm := dedup(veh_norm_sort, fname, mname, lname, customer_name, dob, model_description,
				  make_description, PLATE_NUMBER, ssn, did, state, LOCAL);
//DF-16772. Expression ignored.			
// count(veh_norm(source_code ~in exclusion_list));
// Count(veh_norm(source_code in exclusion_list));

// Slim down
vehicle_wildcard.Layout_BaseFile make_slim(veh_norm l) := transform
	self.fname := trim(trim(l.fname,left),right);
	self.Mname := trim(trim(if (l.fname = '' and l.lname = '', '', l.mname),left),right);
	self.Lname := trim(trim(if (l.fname = '' and l.lname = '', l.customer_name, l.lname),left),right);
	self.PLATE_NUMBER := trim(l.PLATE_NUMBER,all);
	self.make_code := trim(trim(l.make_code,left),right);
	self.model_description := trim(trim(l.model_description,left),right);
	self.body_code := trim(trim(l.body_code,left),right);
	self.vehicle_type := trim(trim(l.vehicle_type,left),right);
	self.major_color_code := trim(trim(l.major_color_code,left),right);
	self.minor_color_code := trim(trim(l.minor_color_code,left),right);
	self := l;
end;

slimmed := project(veh_norm, make_slim(left)):persist('~thor_data400::out::veh_wildcard_file');

export Vehic_Base_Normal := slimmed;