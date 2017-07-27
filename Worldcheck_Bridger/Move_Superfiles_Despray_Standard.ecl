import _Control;

export Move_Superfiles_Despray_Standard (string filedate) := function

//Move Base Files to Superfiles - Standard Region 1-8 Search Files//////////////////////////////////////////////////////////////////////////////////////////
super_rg_1_srch 	:= sequential(FileServices.StartSuperFileTransaction(),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_1_search::delete',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_1_search::grandfather',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_1_search::grandfather'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_1_search::grandfather',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_1_search::father',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_1_search::father'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_1_search::father', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_1_search',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_1_search'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_1_search', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_1_search::'+filedate+'.xml'), 
							FileServices.FinishSuperFileTransaction(),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name   + 'base::worldcheck_bridger::region_1_search::delete',true));


super_rg_2_srch 	:= sequential(FileServices.StartSuperFileTransaction(),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_2_search::delete',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_2_search::grandfather',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_2_search::grandfather'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_2_search::grandfather',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_2_search::father',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_2_search::father'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_2_search::father', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_2_search',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_2_search'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_2_search', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_2_search::'+filedate+'.xml'), 
							FileServices.FinishSuperFileTransaction(),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name   + 'base::worldcheck_bridger::region_2_search::delete',true));


super_rg_3_srch 	:= sequential(FileServices.StartSuperFileTransaction(),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_3_search::delete',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_3_search::grandfather',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_3_search::grandfather'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_3_search::grandfather',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_3_search::father',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_3_search::father'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_3_search::father', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_3_search',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_3_search'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_3_search', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_3_search::'+filedate+'.xml'), 
							FileServices.FinishSuperFileTransaction(),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name   + 'base::worldcheck_bridger::region_3_search::delete',true));


super_rg_4_srch 	:= sequential(FileServices.StartSuperFileTransaction(),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_4_search::delete',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_4_search::grandfather',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_4_search::grandfather'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_4_search::grandfather',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_4_search::father',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_4_search::father'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_4_search::father', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_4_search',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_4_search'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_4_search', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_4_search::'+filedate+'.xml'), 
							FileServices.FinishSuperFileTransaction(),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name   + 'base::worldcheck_bridger::region_4_search::delete',true));


super_rg_5_srch 	:= sequential(FileServices.StartSuperFileTransaction(),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_5_search::delete',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_5_search::grandfather',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_5_search::grandfather'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_5_search::grandfather',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_5_search::father',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_5_search::father'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_5_search::father', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_5_search',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_5_search'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_5_search', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_5_search::'+filedate+'.xml'), 
							FileServices.FinishSuperFileTransaction(),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name   + 'base::worldcheck_bridger::region_5_search::delete',true));


super_rg_6_srch 	:= sequential(FileServices.StartSuperFileTransaction(),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_6_search::delete',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_6_search::grandfather',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_6_search::grandfather'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_6_search::grandfather',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_6_search::father',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_6_search::father'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_6_search::father', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_6_search',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_6_search'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_6_search', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_6_search::'+filedate+'.xml'), 
							FileServices.FinishSuperFileTransaction(),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name   + 'base::worldcheck_bridger::region_6_search::delete',true));


super_rg_7_srch 	:= sequential(FileServices.StartSuperFileTransaction(),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_7_search::delete',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_7_search::grandfather',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_7_search::grandfather'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_7_search::grandfather',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_7_search::father',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_7_search::father'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_7_search::father', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_7_search',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_7_search'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_7_search', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_7_search::'+filedate+'.xml'), 
							FileServices.FinishSuperFileTransaction(),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name   + 'base::worldcheck_bridger::region_7_search::delete',true));

super_rg_8_srch 	:= sequential(FileServices.StartSuperFileTransaction(),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_8_search::delete',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_8_search::grandfather',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_8_search::grandfather'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_8_search::grandfather',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_8_search::father',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_8_search::father'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_8_search::father', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_8_search',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_8_search'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_8_search', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_8_search::'+filedate+'.xml'), 
							FileServices.FinishSuperFileTransaction(),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name   + 'base::worldcheck_bridger::region_8_search::delete',true));

//Move Base Files to Superfiles - Standard Region 1-8 Entity Files//////////////////////////////////////////////////////////////////////////////////////////

super_rg_1_ent 	:= sequential(FileServices.StartSuperFileTransaction(),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_1_entity::delete',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_1_entity::grandfather',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_1_entity::grandfather'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_1_entity::grandfather',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_1_entity::father',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_1_entity::father'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_1_entity::father', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_1_entity',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_1_entity'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_1_entity', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_1_entity::'+filedate+'.xml'), 
							FileServices.FinishSuperFileTransaction(),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name   + 'base::worldcheck_bridger::region_1_entity::delete',true));


super_rg_2_ent 	:= sequential(FileServices.StartSuperFileTransaction(),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_2_entity::delete',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_2_entity::grandfather',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_2_entity::grandfather'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_2_entity::grandfather',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_2_entity::father',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_2_entity::father'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_2_entity::father', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_2_entity',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_2_entity'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_2_entity', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_2_entity::'+filedate+'.xml'), 
							FileServices.FinishSuperFileTransaction(),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name   + 'base::worldcheck_bridger::region_2_entity::delete',true));


super_rg_3_ent 	:= sequential(FileServices.StartSuperFileTransaction(),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_3_entity::delete',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_3_entity::grandfather',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_3_entity::grandfather'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_3_entity::grandfather',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_3_entity::father',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_3_entity::father'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_3_entity::father', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_3_entity',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_3_entity'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_3_entity', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_3_entity::'+filedate+'.xml'), 
							FileServices.FinishSuperFileTransaction(),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name   + 'base::worldcheck_bridger::region_3_entity::delete',true));

super_rg_4_ent 	:= sequential(FileServices.StartSuperFileTransaction(),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_4_entity::delete',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_4_entity::grandfather',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_4_entity::grandfather'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_4_entity::grandfather',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_4_entity::father',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_4_entity::father'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_4_entity::father', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_4_entity',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_4_entity'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_4_entity', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_4_entity::'+filedate+'.xml'), 
							FileServices.FinishSuperFileTransaction(),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name   + 'base::worldcheck_bridger::region_4_entity::delete',true));

super_rg_5_ent 	:= sequential(FileServices.StartSuperFileTransaction(),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_5_entity::delete',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_5_entity::grandfather',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_5_entity::grandfather'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_5_entity::grandfather',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_5_entity::father',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_5_entity::father'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_5_entity::father', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_5_entity',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_5_entity'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_5_entity', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_5_entity::'+filedate+'.xml'), 
							FileServices.FinishSuperFileTransaction(),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name   + 'base::worldcheck_bridger::region_5_entity::delete',true));

super_rg_6_ent 	:= sequential(FileServices.StartSuperFileTransaction(),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_6_entity::delete',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_6_entity::grandfather',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_6_entity::grandfather'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_6_entity::grandfather',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_6_entity::father',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_6_entity::father'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_6_entity::father', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_6_entity',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_6_entity'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_6_entity', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_6_entity::'+filedate+'.xml'), 
							FileServices.FinishSuperFileTransaction(),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name   + 'base::worldcheck_bridger::region_6_entity::delete',true));

super_rg_7_ent 	:= sequential(FileServices.StartSuperFileTransaction(),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_7_entity::delete',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_7_entity::grandfather',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_7_entity::grandfather'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_7_entity::grandfather',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_7_entity::father',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_7_entity::father'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_7_entity::father', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_7_entity',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_7_entity'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_7_entity', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_7_entity::'+filedate+'.xml'), 
							FileServices.FinishSuperFileTransaction(),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name   + 'base::worldcheck_bridger::region_7_entity::delete',true));

super_rg_8_ent 	:= sequential(FileServices.StartSuperFileTransaction(),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_8_entity::delete',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_8_entity::grandfather',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_8_entity::grandfather'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_8_entity::grandfather',
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_8_entity::father',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_8_entity::father'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_8_entity::father', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_8_entity',, true),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_8_entity'),
							FileServices.AddSuperFile(  worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_8_entity', 
														worldcheck_bridger.cluster_name + 'base::worldcheck_bridger::region_8_entity::'+filedate+'.xml'), 
							FileServices.FinishSuperFileTransaction(),
							FileServices.ClearSuperFile(worldcheck_bridger.cluster_name   + 'base::worldcheck_bridger::region_8_entity::delete',true));


//Despray Base Files - Standard Region Search Files//////////////////////////////////////////////////////////////////////////////////////////
despray_rg_1_srch	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_1_search::'+filedate+'.xml', _Control.IPAddress.edata11, '/bdb_82/wcb/output/'+filedate+'/worldcheck_region_1_build.xml',,,,true);
despray_rg_2_srch	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_2_search::'+filedate+'.xml', _Control.IPAddress.edata11, '/bdb_82/wcb/output/'+filedate+'/worldcheck_region_2_build.xml',,,,true);
despray_rg_3_srch	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_3_search::'+filedate+'.xml', _Control.IPAddress.edata11, '/bdb_82/wcb/output/'+filedate+'/worldcheck_region_3_build.xml',,,,true);
despray_rg_4_srch	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_4_search::'+filedate+'.xml', _Control.IPAddress.edata11, '/bdb_82/wcb/output/'+filedate+'/worldcheck_region_4_build.xml',,,,true);
despray_rg_5_srch	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_5_search::'+filedate+'.xml', _Control.IPAddress.edata11, '/bdb_82/wcb/output/'+filedate+'/worldcheck_region_5_build.xml',,,,true);
despray_rg_6_srch	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_6_search::'+filedate+'.xml', _Control.IPAddress.edata11, '/bdb_82/wcb/output/'+filedate+'/worldcheck_region_6_build.xml',,,,true);
despray_rg_7_srch	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_7_search::'+filedate+'.xml', _Control.IPAddress.edata11, '/bdb_82/wcb/output/'+filedate+'/worldcheck_region_7_build.xml',,,,true);
despray_rg_8_srch	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_8_search::'+filedate+'.xml', _Control.IPAddress.edata11, '/bdb_82/wcb/output/'+filedate+'/worldcheck_region_8_build.xml',,,,true);

//despray_rg_1_srch	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_1_search::'+filedate+'.xml', _Control.IPAddress.edata12, '/data_999/world_check_bridger/standard_output/'+filedate+'/worldcheck_region_1_build.xml',,,,true);
//despray_rg_2_srch	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_2_search::'+filedate+'.xml', _Control.IPAddress.edata12, '/data_999/world_check_bridger/standard_output/'+filedate+'/worldcheck_region_2_build.xml',,,,true);
//despray_rg_3_srch	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_3_search::'+filedate+'.xml', _Control.IPAddress.edata12, '/data_999/world_check_bridger/standard_output/'+filedate+'/worldcheck_region_3_build.xml',,,,true);
//despray_rg_4_srch	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_4_search::'+filedate+'.xml', _Control.IPAddress.edata12, '/data_999/world_check_bridger/standard_output/'+filedate+'/worldcheck_region_4_build.xml',,,,true);
//despray_rg_5_srch	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_5_search::'+filedate+'.xml', _Control.IPAddress.edata12, '/data_999/world_check_bridger/standard_output/'+filedate+'/worldcheck_region_5_build.xml',,,,true);
//despray_rg_6_srch	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_6_search::'+filedate+'.xml', _Control.IPAddress.edata12, '/data_999/world_check_bridger/standard_output/'+filedate+'/worldcheck_region_6_build.xml',,,,true);
//despray_rg_7_srch	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_7_search::'+filedate+'.xml', _Control.IPAddress.edata12, '/data_999/world_check_bridger/standard_output/'+filedate+'/worldcheck_region_7_build.xml',,,,true);
//despray_rg_8_srch	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_8_search::'+filedate+'.xml', _Control.IPAddress.edata12, '/data_999/world_check_bridger/standard_output/'+filedate+'/worldcheck_region_8_build.xml',,,,true);

//Despray Base Files - Standard Region Entity Files//////////////////////////////////////////////////////////////////////////////////////////
despray_rg_1_ent	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_1_entity::'+filedate+'.xml', _Control.IPAddress.edata11, '/bdb_82/wcb/output/'+filedate+'/worldcheck_entity_region_1.xml',,,,true);
despray_rg_2_ent	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_2_entity::'+filedate+'.xml', _Control.IPAddress.edata11, '/bdb_82/wcb/output/'+filedate+'/worldcheck_entity_region_2.xml',,,,true);
despray_rg_3_ent	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_3_entity::'+filedate+'.xml', _Control.IPAddress.edata11, '/bdb_82/wcb/output/'+filedate+'/worldcheck_entity_region_3.xml',,,,true);
despray_rg_4_ent	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_4_entity::'+filedate+'.xml', _Control.IPAddress.edata11, '/bdb_82/wcb/output/'+filedate+'/worldcheck_entity_region_4.xml',,,,true);
despray_rg_5_ent	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_5_entity::'+filedate+'.xml', _Control.IPAddress.edata11, '/bdb_82/wcb/output/'+filedate+'/worldcheck_entity_region_5.xml',,,,true);
despray_rg_6_ent	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_6_entity::'+filedate+'.xml', _Control.IPAddress.edata11, '/bdb_82/wcb/output/'+filedate+'/worldcheck_entity_region_6.xml',,,,true);
despray_rg_7_ent	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_7_entity::'+filedate+'.xml', _Control.IPAddress.edata11, '/bdb_82/wcb/output/'+filedate+'/worldcheck_entity_region_7.xml',,,,true);
despray_rg_8_ent	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_8_entity::'+filedate+'.xml', _Control.IPAddress.edata11, '/bdb_82/wcb/output/'+filedate+'/worldcheck_entity_region_8.xml',,,,true);

//despray_rg_1_ent	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_1_entity::'+filedate+'.xml', _Control.IPAddress.edata12, '/data_999/world_check_bridger/standard_output/'+filedate+'/worldcheck_entity_region_1.xml',,,,true);
//despray_rg_2_ent	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_2_entity::'+filedate+'.xml', _Control.IPAddress.edata12, '/data_999/world_check_bridger/standard_output/'+filedate+'/worldcheck_entity_region_2.xml',,,,true);
//despray_rg_3_ent	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_3_entity::'+filedate+'.xml', _Control.IPAddress.edata12, '/data_999/world_check_bridger/standard_output/'+filedate+'/worldcheck_entity_region_3.xml',,,,true);
//despray_rg_4_ent	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_4_entity::'+filedate+'.xml', _Control.IPAddress.edata12, '/data_999/world_check_bridger/standard_output/'+filedate+'/worldcheck_entity_region_4.xml',,,,true);
//despray_rg_5_ent	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_5_entity::'+filedate+'.xml', _Control.IPAddress.edata12, '/data_999/world_check_bridger/standard_output/'+filedate+'/worldcheck_entity_region_5.xml',,,,true);
//despray_rg_6_ent	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_6_entity::'+filedate+'.xml', _Control.IPAddress.edata12, '/data_999/world_check_bridger/standard_output/'+filedate+'/worldcheck_entity_region_6.xml',,,,true);
//despray_rg_7_ent	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_7_entity::'+filedate+'.xml', _Control.IPAddress.edata12, '/data_999/world_check_bridger/standard_output/'+filedate+'/worldcheck_entity_region_7.xml',,,,true);
//despray_rg_8_ent	:= fileservices.Despray('~thor_data200::base::worldcheck_bridger::region_8_entity::'+filedate+'.xml', _Control.IPAddress.edata12, '/data_999/world_check_bridger/standard_output/'+filedate+'/worldcheck_entity_region_8.xml',,,,true);

return	sequential(super_rg_1_srch,
					super_rg_2_srch,
					super_rg_3_srch,
					super_rg_4_srch,
					super_rg_5_srch,
					super_rg_6_srch,
					super_rg_7_srch,
					super_rg_8_srch,
					super_rg_1_ent,
					super_rg_2_ent,
					super_rg_3_ent,
					super_rg_4_ent,
					super_rg_5_ent,
					super_rg_6_ent,
					super_rg_7_ent,
					super_rg_8_ent,
					despray_rg_1_srch,
					despray_rg_2_srch,
					despray_rg_3_srch,
					despray_rg_4_srch,
					despray_rg_5_srch,
					despray_rg_6_srch,
					despray_rg_7_srch,
					despray_rg_8_srch,
					despray_rg_1_ent,
					despray_rg_2_ent,
					despray_rg_3_ent,
					despray_rg_4_ent,
					despray_rg_5_ent,
					despray_rg_6_ent,
					despray_rg_7_ent,
					despray_rg_8_ent);								

end;