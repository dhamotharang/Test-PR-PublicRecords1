import VehLic;

#if(VehLic.BuildType = VehLic.BuildType_Accurint)
  #workunit('name','Vehicles ' + vehlic.Version_Development);
  #if(VehLic.Version_Development > VehLic.Version_Production)
    fVersionCheck := output('Version: ' + VehLic.Version_Development);
  #else
    fVersionCheck := fail('Version_Development is equal to Version_Production');
  #end
#end
#if(VehLic.BuildType = VehLic.BuildType_Matrix)
  #workunit('name','Matrix Vehicles ' + vehlic.Version_Development_Matrix);
  #if(VehLic.Version_Development > VehLic.Version_Production)
    fVersionCheck := output('Version: ' + VehLic.Version_Development_Matrix);
  #else
    fVersionCheck := fail('Version_Development_Matrix is equal to Version_Production_Matrix');
  #end
#end


sequential
  (
	fVersionCheck,
	VehLic.Out_Base_Dev,
	VehLic.Out_Moxie_Dev,
	VehLic.Out_Moxie_Dev_FPos_Data_Key,
	parallel
	 (
	  VehLic.Out_Base_Dev_Stats,
	  VehLic.Out_Moxie_Dev_Keys
	 ),
	VehLic.Out_Doxie_Dev_Keys
  )
 ;