import Orbit3, std, _Control;
export Fn_Update_Orbit (string pVersion, boolean isFCRA = false, boolean pDaily	= true):= module 

buildname			:= if(isfcra,'FCRA Inquiry Tracking', if(pDaily, 'Inquiry Tracking Update', 'Inquiry Tracking' ));

prev_version	:= if(isfcra,inql_v2._Versions.dops_fcra_keys_prod,
                   if(pDaily,inql_v2._Versions.dops_nonfcra_update_keys_prod, inql_v2._Versions.dops_nonfcra_keys_prod));
										
gtoken				:= Orbit3.GetToken();

createBuild   := Orbit3.Proc_Orbit3_CreateBuild_npf(buildname,pVersion,'BUILD_AVAILABLE_FOR_USE', false, false, true, true, false) ;

getBuild			:= Orbit3.GetBuildCandidates(buildname,pVersion ,gtoken, pVersion )
											(Version <=Std.Date.ConvertDateFormat(pVersion,'%Y%m%d','%m-%d-%Y') and 
										 	 Version >	Std.Date.ConvertDateFormat(prev_Version,'%Y%m%d','%m-%d-%Y')); 

fn_add_components (string ComponentType,string DataType,string Family,string Id,string Name,string Status,string Version) := function
				return Orbit3.AddComponentstoBuild(gtoken,
																					buildname,
																					pVersion,
																					_Control.MyInfo.EmailAddressNotify,
																					dataset([{ComponentType,DataType,Family,Id,Name,Status,Version}],Orbit3.Layouts.OrbitBuildInstanceLayout) 
									);
end;
											
add_components := apply(getBuild, Sequential(fn_add_components( ComponentType,DataType,Family,Id,Name,Status,Version)));

export run:= sequential (createBuild , add_components);

end;