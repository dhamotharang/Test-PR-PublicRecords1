import VehLic;

#if(VehLic.BuildType = VehLic.BuildType_Accurint)
  #workunit('name','Vehicles ' + vehlic.Version_Development);
  lVersionDate 		:= VehLic.Version_Development;
  lFileNamePrefix	:= '';
#end
#if(VehLic.BuildType = VehLic.BuildType_Matrix)
  #workunit('name','Matrix Vehicles ' + vehlic.Version_Development_Matrix);
  lVersionDate 		:= VehLic.Version_Development_Matrix;
  lFileNamePrefix	:= 'matrix_';
#end

VehLic.Layout_Vehreg_ToMike tPatchVehNo(VehLic.Layout_Vehicles pInput)	 // Transfor for Moxie file
 :=
  transform   
	self.VEHICLE_NUMBERxBG1 := trim(pInput.VEHICLE_NUMBERxBG1,all) + '00000000000000000000';
	self 					:= pInput;
  end
 ;

sEmptySet		:= [];
sBadStateSet 	:= [];

#if(sBadStateSet <> sEmptySet)
  dMoxie	:= project(VehLic.File_Base_Vehicles_Dev(~orig_state in sBadStateSet),tPatchVehNo(left));
  dDev		:= project(VehLic.File_Base_Vehicles_Dev(orig_state in sBadStateSet),tPatchVehNo(left));
  #if(VehLic.BuildType = VehLic.BuildType_Accurint)
    lOutMoxie := output(dMoxie,,'~thor_data400::out::' + trim(lFileNamePrefix) + 'vehicles_moxie',overwrite,__compressed__);
    lOutDev	:= output(dDev,,'~thor_data400::out::' + trim(lFileNamePrefix) + 'vehicles_dev',overwrite,__compressed__);
  #end
  #if(VehLic.BuildType = VehLic.BuildType_Matrix)
    lOutMoxie := output(dMoxie,,'~thor_data400::out::' + trim(lFileNamePrefix) + 'vehicles_moxie',overwrite);
    lOutDev	:= output(dDev,,'~thor_data400::out::' + trim(lFileNamePrefix) + 'vehicles_dev',overwrite);
  #end
  export Out_Moxie_Dev := parallel(lOutMoxie,lOutDev);
#end
#if(sBadStateSet = sEmptySet)
  dMoxie	:= project(VehLic.File_Base_Vehicles_Dev,tPatchVehNo(left));
  #if(VehLic.BuildType = VehLic.BuildType_Accurint)
    lOutMoxie := output(dMoxie,,'~thor_data400::out::' + trim(lFileNamePrefix) + 'vehicles_moxie',overwrite,__compressed__);
  #end
  #if(VehLic.BuildType = VehLic.BuildType_Matrix)
    lOutMoxie := output(dMoxie,,'~thor_data400::out::' + trim(lFileNamePrefix) + 'vehicles_moxie',overwrite);
  #end
  export Out_Moxie_Dev := lOutMoxie;
#end