import ut;
export proc_build_Entiera(string pVersion) := function

//build base file
ut.MAC_SF_BuildProcess(entiera.Standardized_Entiera_Data
											,Entiera.Entiera_Constants().Cluster+'base::entiera::basefile'
											,aEntieraMainBuild
											,2			//	generations
											,false	//	csv?
											,true		//	compress?
											); 



//build keys&autokeys
build_all_keys := Entiera.proc_build_keys(pVersion);

//boolean keys if needed
//strata if needed
zDoPopulationStats:=Entiera_Pop_Stats(pVersion);

// -- Actions
build_all_files_keys := sequential(aEntieraMainBuild,build_all_keys,zDoPopulationStats);

return build_all_files_keys;

end;