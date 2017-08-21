import standard,vehiclev2;

veh_veh := vehiclev2.file_VehicleV2_Main;
my_veh0 := veh_veh(StringLib.StringFind(StringLib.StringToUpperCase(VINA_vp_series_name),'CHARGER',1)<>0);
my_veh  := dedup(sort(distribute(my_veh0(StringLib.StringFind(StringLib.StringToUpperCase(VINA_vp_series_name),'SRT',1)<>0),hash(vehicle_key)),record,local),all,local);

veh_con := sort(distribute(vehiclev2.file_vehicleV2_party,hash(vehicle_key)),vehicle_key,iteration_key,local);


layout_veh_joined := record
  	string30		Vehicle_Key;
	string15		Iteration_Key;
	string2			Source_Code;
	string2			State_Origin;
	unsigned8		State_Bitmap_Flag;
	string25		Orig_VIN;
	string4			Orig_Year;
	string5			Orig_Make_Code;
	string36		Orig_Make_Desc;
	string3			Orig_Series_Code;
	string25		Orig_Series_Desc;
	string3			Orig_Model_Code;
	string30		Orig_Model_Desc;
	string5			Orig_Body_Code;
	string20		Orig_Body_Desc;
	string3			Orig_Major_Color_Code;
	string15		Orig_Major_Color_Desc;
	string3			Orig_Minor_Color_Code;
	string15		Orig_Minor_Color_Desc;
	string1 		VINA_Veh_Type;
	string5 		VINA_NCIC_Make;
	string2 		VINA_Model_Year_YY;
	string17		VINA_VIN;
	string4 		VINA_VP_Abbrev_Make_Name;
	string2 		VINA_VP_Year;
	string3 		VINA_VP_Series;
	string3 		VINA_VP_Model;
	string25		VINA_VP_Series_Name;
	string4 		VINA_Model_Year;
	string3 		VINA_Series;
	string3 		VINA_Model;
	string2 		VINA_Body_Style;
	string36		VINA_Make_Desc;
	string36		VINA_Model_Desc;
	string25		VINA_Series_Desc;
	string25		VINA_Body_Style_Desc;
	string5			Best_Make_Code;
	string3			Best_Series_Code;
	string3			Best_Model_Code;
	string5			Best_Body_Code;
	string4			Best_Model_Year;
	string3			Best_Major_Color_Code;
	string3			Best_Minor_Color_Code;
	string1			Latest_Vehicle_Flag;
	Standard.Name	Append_Clean_Name;
	string70		Append_Clean_CName;
	Standard.Addr	Append_Clean_Address;
	string8			Reg_Latest_Effective_Date;
	string8			Reg_Latest_Expiration_Date;
	string10		Reg_True_License_Plate;
	string10		Reg_License_Plate;
	string2			Reg_License_State;
end;

layout_veh_joined to_get_contacts(my_veh l, veh_con r) := transform 
	self := l;
	self := r;
end;
res  := join(my_veh,veh_con,left.vehicle_key=right.vehicle_key and left.iteration_key=right.iteration_key,to_get_contacts(left,right), left outer, local);


export _my_veh_joined := res:  persist('~thor_200::persist::rvh::my_veh_joined_charger_srt8');

