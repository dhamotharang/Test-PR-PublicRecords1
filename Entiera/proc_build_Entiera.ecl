import ut;
export proc_build_Entiera(string version) := function

//build base file
ut.MAC_SF_BuildProcess(entiera.Standardized_Entiera_Data
											 ,Entiera.Entiera_Constants().Cluster+'base::entiera::basefile'
											 ,aEntieraMainBuild,2);



//build keys&autokeys
build_all_keys := Entiera.proc_build_keys(version);

//boolean keys if needed
//strata if needed

// -- Actions
build_all_files_keys := sequential(aEntieraMainBuild,build_all_keys);

return build_all_files_keys;

end;









