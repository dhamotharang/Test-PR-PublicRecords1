
r_party := record
	string30	Vehicle_Key					:=	VehicleV2.file_vehicleV2_party.Vehicle_Key;
	string2		State_Origin				:=	VehicleV2.file_vehicleV2_party.State_Origin;
	string6		Reg_First_Date				:=	VehicleV2.file_vehicleV2_party.Reg_First_Date;
	string6		Reg_Earliest_Effective_Date	:=	VehicleV2.file_vehicleV2_party.Reg_Earliest_Effective_Date;
	string6		Reg_Latest_Effective_Date	:=	VehicleV2.file_vehicleV2_party.Reg_Latest_Effective_Date;
	string6		Ttl_Earliest_Issue_Date		:=	VehicleV2.file_vehicleV2_party.Ttl_Earliest_Issue_Date;
	string6		Ttl_Latest_Issue_Date		:=	VehicleV2.file_vehicleV2_party.Ttl_Latest_Issue_Date;
end;

ds_party:=table(VehicleV2.file_vehicleV2_party
										(
										State_Origin='MO'
										,Reg_Earliest_Effective_Date<>''
										,Reg_Earliest_Effective_Date[1]<>'2'
										,Reg_Earliest_Effective_Date[1]<>'1'
										)
										,r_party);

r_main := record
	string30	Vehicle_Key	:=	VehicleV2.file_Vehicle_main.Vehicle_Key;
	string25	Orig_VIN	:=	VehicleV2.file_Vehicle_main.Orig_VIN;
end;

ds_main:=table(VehicleV2.file_Vehicle_main,r_main);

r_all	:= record
	ds_party;
	string25	Orig_VIN;
end;

r_all join_vin(ds_party L, ds_main R) := transform
	self.Orig_VIN	:= 	R.Orig_VIN;
	self			:= 	L;
end;



ds_all	:= join(ds_party, ds_main
							,left.Vehicle_Key=right.Vehicle_Key
							,join_vin(left,right)
							,local
							,keep(100)
							)
							: persist('~thor_data400::persist::jbello_Reg_DATES_vin')
							;


output(ds_all);

