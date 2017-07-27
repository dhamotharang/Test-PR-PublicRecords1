import VehLic;

#if(BuildType = BuildType_Accurint)
  export File_Base_Vehicles_Dev := dataset('~thor_data400::base::vehicles_' + VehLic.Version_Development,VehLic.Layout_Vehicles_bdid,flat,unsorted,__compressed__);
#end
#if(BuildType = BuildType_Matrix)
  export File_Base_Vehicles_Dev := dataset('~thor_200::base::matrix_vehicles_' + vehlic.Version_Development_Matrix ,VehLic.Layout_Vehicles_bdid,flat,unsorted);
#end
