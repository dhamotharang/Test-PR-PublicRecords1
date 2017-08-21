import _Control, Std;

export Move_Superfiles_Despray_Premium_Plus (string filedate) := function

//Move Base File to Superfiles - Premium Plus Search File//////////////////////////////////////////////////////////////////////////////////////////
super_pp_srch 	:= sequential(FileServices.StartSuperFileTransaction(),
						FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::premium_plus_search::delete',
													worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::premium_plus_search::grandfather',, true),
						FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::premium_plus_search::grandfather'),
						FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::premium_plus_search::grandfather',
													worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::premium_plus_search::father',, true),
						FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::premium_plus_search::father'),
						FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::premium_plus_search::father', 
													worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::premium_plus_search',, true),
						FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::premium_plus_search'),
						FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::premium_plus_search', 
													worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::premium_plus_search::'+filedate+'.xml'), 
						FileServices.FinishSuperFileTransaction(),
					FileServices.ClearSuperFile(	worldcheck_bridger.cluster_name   + 'base::worldcheck_bridger::premium_plus_search::delete',true));

//Move Base File to Superfiles - Premium Plus Entity File//////////////////////////////////////////////////////////////////////////////////////////
super_pp_entity := sequential(FileServices.StartSuperFileTransaction(),
						FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::premium_plus_entity::delete',
													worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::premium_plus_entity::grandfather',, true),
						FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::premium_plus_entity::grandfather'),
						FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::premium_plus_entity::grandfather',
													worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::premium_plus_entity::father',, true),
						FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::premium_plus_entity::father'),
						FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::premium_plus_entity::father', 
													worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::premium_plus_entity',, true),
						FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::premium_plus_entity'),
						FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::premium_plus_entity', 
													worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::premium_plus_entity::'+filedate+'.xml'), 
						FileServices.FinishSuperFileTransaction(),
						FileServices.ClearSuperFile(worldcheck_bridger.cluster_name   + 'base::worldcheck_bridger::premium_plus_entity::delete',true));
					
superFile := '~thor::base::worldcheck_bridger::premium_plus_entity';
sfList := [
	superFile,
	superFile+'::father',
	superFile+'::grandfather',
	superFile+'::delete'
	];
	
	promote(string filename) := Std.file.fPromoteSuperFileList(sfList, filename, deltail := true); 
/*
//Despray Base Files - Premium Plus Search Files//////////////////////////////////////////////////////////////////////////////////////////
despray_pp_srch		:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::premium_plus_search::'+filedate+'.xml', _Control.IPAddress.edata11, '/bdb_82/wcb/output/'+filedate+'/worldcheck_premium_plus_build.xml',,,,true);

//despray_pp_srch		:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::premium_plus_search::'+filedate+'.xml', _Control.IPAddress.edata12, '/data_999/world_check_bridger/premium_plus_output/'+filedate+'/worldcheck_premium_plus_build.xml',,,,true);

//Despray Base Files - Premium Plus Entity Files//////////////////////////////////////////////////////////////////////////////////////////
despray_pp_entity	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::premium_plus_entity::'+filedate+'.xml', _Control.IPAddress.edata11, 
'/bdb_82/wcb/output/'+filedate+'/worldcheck_premium_plus_entity.xml',,,,true);

despray_pp_fullentity(string filename)	:= 
				fileservices.Despray(filename, _Control.IPAddress.edata11,
				'/bdb_82/wcb/output/'+filedate+'/worldcheck_premium_plus.xml',,,,true);
*/
//Linux changes
//Despray Base Files - Premium Plus Search Files//////////////////////////////////////////////////////////////////////////////////////////
despray_pp_srch		:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::premium_plus_search::'+filedate+'.xml', _Control.IPAddress.bctlpedata10, '/data/bdb_82/wcb/output/'+filedate+'/worldcheck_premium_plus_build.xml',,,,true);

//despray_pp_srch		:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::premium_plus_search::'+filedate+'.xml', _Control.IPAddress.edata12, '/data_999/world_check_bridger/premium_plus_output/'+filedate+'/worldcheck_premium_plus_build.xml',,,,true);

//Despray Base Files - Premium Plus Entity Files//////////////////////////////////////////////////////////////////////////////////////////
despray_pp_entity	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::premium_plus_entity::'+filedate+'.xml', _Control.IPAddress.bctlpedata10, 
'/data/bdb_82/wcb/output/'+filedate+'/worldcheck_premium_plus_entity.xml',,,,true);

despray_pp_fullentity(string filename)	:= 
				fileservices.Despray(filename, _Control.IPAddress.bctlpedata10,
				'/data/bdb_82/wcb/output/'+filedate+'/worldcheck_premium_plus.xml',,,,true);


return	sequential(//super_pp_srch,
//					promote('~thor::base::worldcheck_bridger::premium_plus_entity::'+filedate+'.xml'),
					//despray_pp_srch,
					despray_pp_fullentity('~thor::base::worldcheck_bridger::premium_plus_entity::'+filedate+'.xml'));								

end;