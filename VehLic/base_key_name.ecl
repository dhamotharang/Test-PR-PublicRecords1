import vehlic;

#if(VehLic.BuildType = VehLic.BuildType_Accurint)
  export string29 base_key_name := '~thor_data400::key::moxie.mv.';
#end
#if(VehLic.BuildType = VehLic.BuildType_Matrix)
  export string32 base_key_name := '~thor_200::key::moxie.matrix_mv.';
#end
