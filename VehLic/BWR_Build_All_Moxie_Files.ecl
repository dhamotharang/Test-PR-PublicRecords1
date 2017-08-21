import VehLic, lib_FileServices;

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

leMailTarget := 'cpettola@seisint.com';

fSendMail(string pSubject, string pBody)
 := lib_fileservices.fileservices.sendemail(leMailTarget,pSubject,pBody);

sequential
  (
	fVersionCheck,
	VehLic.Out_Base_Dev,
	fSendMail('Vehicle Build 1 of 4','Vehicle Build ' + Vehlic.Version_Development + ': BASE file complete.'),
	VehLic.Out_Moxie_Dev,
	VehLic.Out_Moxie_Dev_FPos_Data_Key,
	fSendMail('Vehicle Build 2 of 4','Vehicle Build ' + Vehlic.Version_Development + ': fpos.data.key complete.'),
	parallel
	 (
	  VehLic.Out_Base_Dev_Stats,
	  VehLic.Out_Moxie_Dev_Keys,
	  VehLic.Out_Base_Dev_New_Records_Sample
	 ),
	fSendMail('Vehicle Build 3 of 4','Vehicle Build ' + Vehlic.Version_Development + ': Moxie keys complete.'),
	VehLic.Out_Doxie_Dev_Keys
  )
 : success(fSendMail('Vehicle Build 4 of 4','Vehicle Build ' + Vehlic.Version_Development + ': Complete.  WUID: ' + workunit))
 , failure(fSendMail('Vehicle Build FAILED','Vehicle Build ' + Vehlic.Version_Development + ' Failed.  WUID: ' + workunit))
 ;