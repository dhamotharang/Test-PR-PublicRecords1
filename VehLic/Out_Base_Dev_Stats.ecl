import VehLic;

rStatsLayout
 :=
  record
	VehLic.File_Base_Vehicles_Dev.orig_state;
	Total 			:= count(group);
	Historic 		:= AVE(group,IF(VehLic.File_Base_Vehicles_Dev.history='H',100,0));
	Expired 		:= AVE(group,IF(VehLic.File_Base_Vehicles_Dev.history='E',100,0));
	Owner_1_DID 	:= AVE(group,IF(VehLic.File_Base_Vehicles_Dev.own_1_did<>'',100,0));
	Owner_1_SSN 	:= AVE(group,IF(VehLic.File_Base_Vehicles_Dev.own_1_ssn<>'',100,0));
	Owner_2_DID 	:= AVE(group,IF(VehLic.File_Base_Vehicles_Dev.own_2_did <> '',100,0));
	Owner_2_SSN 	:= AVE(group,IF(VehLic.File_Base_Vehicles_Dev.own_2_ssn<>'',100,0));
	Reg_1_DID		:= AVE(group,IF(VehLic.File_Base_Vehicles_Dev.reg_1_did <> '',100,0));
	Reg_1_SSN		:= AVE(group,IF(VehLic.File_Base_Vehicles_Dev.reg_1_ssn<>'',100,0));
	Reg_2_DID		:= AVE(group,IF(VehLic.File_Base_Vehicles_Dev.reg_2_did <> '',100,0));
	Reg_2_SSN		:= AVE(group,IF(VehLic.File_Base_Vehicles_Dev.reg_2_ssn<>'',100,0));
	Has_LH_1		:= AVE(group,IF(VehLic.File_Base_Vehicles_Dev.lh_1_customer_name<>'' and VehLic.File_Base_Vehicles_Dev.lh_1_customer_name[1..4]<>'NOT ',100,0));
	Has_LH_2		:= AVE(group,IF(VehLic.File_Base_Vehicles_Dev.lh_2_customer_name<>'' and VehLic.File_Base_Vehicles_Dev.lh_2_customer_name[1..4]<>'NOT ',100,0));
	Has_LH_3		:= AVE(group,IF(VehLic.File_Base_Vehicles_Dev.lh_3_customer_name<>'' and VehLic.File_Base_Vehicles_Dev.lh_3_customer_name[1..4]<>'NOT ',100,0));
	VINA_Hit 		:= AVE(group,IF(VehLic.File_Base_Vehicles_Dev.vin_2<>'',100,0));
  end
 ;

dStats := table(VehLic.File_Base_Vehicles_Dev,rStatsLayout,orig_state);

export Out_Base_Dev_Stats := output(choosen(dStats,all));