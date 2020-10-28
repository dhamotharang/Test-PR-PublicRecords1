import Orbit3, std, _Control;
export Fn_Update_Orbit (string pVersion):= module 

buildname			:= 'FCRA Inquiry History';

prev_version	:= INQL_FFD.Fn_Get_Current_Version.fcra_last_key_dops_prod;
gtoken				:= Orbit3.GetToken();

// createBuild   := Orbit3.Proc_Orbit3_CreateBuild('FCRA Inquiry History',pVersion,'BUILD_AVAILABLE_FOR_USE', false, false, true, true, false) ;
createBuild   := orbit3.Proc_Orbit3_CreateBuild('FCRA Inquiry History',pVersion,,,'BUILD_AVAILABLE_FOR_USE', false, false, true, true) ;
getBuild			:= Orbit3.GetBuildCandidates(buildname,pVersion ,gtoken, pVersion )
											(Version <=Std.Date.ConvertDateFormat(pVersion,'%Y%m%d','%m-%d-%Y') and 
										 	 Version > Std.Date.ConvertDateFormat(prev_Version,'%Y%m%d','%m-%d-%Y')); 

fn_add_components (string ComponentType,string DataType,string Family,string Id,string Name,string Status,string Version) := function
				return Orbit3.AddComponentstoBuild(gtoken,
																					buildname,
																					pVersion,
																					// _Control.MyInfo.EmailAddressNotify,
																					dataset([{ComponentType,DataType,Family,Id,Name,Status,Version}],Orbit3.Layouts.OrbitBuildInstanceLayout) 
									);
end;
											
add_components := apply(getBuild, Sequential(fn_add_components( ComponentType,DataType,Family,Id,Name,Status,Version)));

export run:= sequential (createBuild , add_components);

end;
