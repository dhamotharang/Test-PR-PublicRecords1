import VehLic, Ut;

#if(VehLic.BuildType = VehLic.BuildType_Accurint)
  #workunit('name','Vehicles ' + vehlic.Version_Development);
  lVersionDate 		:= VehLic.Version_Development;
  lVersionAttr 		:= 'VehLic.Version_Development';
  lFileNamePrefix	:= '';
#end
#if(VehLic.BuildType = VehLic.BuildType_Matrix)
  #workunit('name','Matrix Vehicles ' + vehlic.Version_Development_Matrix);
  lVersionDate 		:= VehLic.Version_Development_Matrix;
  lVersionAttr 		:= 'VehLic.Version_Development_Matrix';
  lFileNamePrefix	:= 'matrix_';
#end

if(VehLic.BuildType<>VehLic.BuildType_Accurint,
   if(VehLic.BuildType<>VehLic.BuildType_Matrix,
	  fail('Please check the "VehLic.BuildType" attribute assignment.')
	 )
  );

if(ut.DaysApart(ut.GetDate,lVersionDate) >= 10,
   fail('Please check ' + lVersionAttr)
  );
   
export Out_Base_Dev := output(VehLic.Vehicles,,'~thor_data400::base::' + trim(lFileNamePrefix) + 'vehicles_' + lVersionDate,overwrite,__compressed__);