import WorldCheck_Bridger, lib_FileServices, _Control;

export proc_WorldCheck_Bridger_Spray (string st_file,
										string pp_file,
										string pp_nchar_file,
										string filedate) := function

#uniquename(st_file)
#uniquename(pp_file)
#uniquename(pp_nchar_file)

#uniquename(sourceCsvSeparator)
#uniquename(sourceCsvTeminator)
#uniquename(groupname)

#uniquename(spray_st_file)
#uniquename(spray_pp_file)
#uniquename(spray_pp_nchar_file)

#uniquename(super_st_file)
#uniquename(super_pp_file)
#uniquename(super_pp_nchar_file)

#workunit('name','World Check Bridger ' + filedate + ' Spray ');

%sourceCsvSeparator% 	:= '\\t';
%sourceCsvTeminator% 	:= '\\n,\\r\\n';
%groupname% 			:= 'thor400_30';

//used to remove oversized records
%spray_st_file% 	:= fileservices.SprayVariable(_Control.IPAddress.edata11
                                          ,'/bdb_82/wcb/input/'+filedate+'/'+st_file
										  //,st_file
										  ,100000
										  ,'\t'
										  ,'\\n,\\r\\n'
										  ,'"'
										  ,%groupname%
										  ,WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::standard::'+filedate
										  ,
										  ,
										  ,
										  ,true
										  ,true
										  ,false);  

%spray_pp_file% 	:= fileservices.SprayVariable(_Control.IPAddress.edata11
                                          ,'/bdb_82/wcb/input/'+filedate+'/'+pp_file
										  //,pp_file
										  ,100000
										  ,'\t'
										  ,'\\n,\\r\\n'
										  ,'"'
										  ,%groupname%
										  ,WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::premium_plus::'+filedate
										  ,
										  ,
										  ,
										  ,true
										  ,true
										  ,false); 

%spray_pp_nchar_file% 	:= fileservices.SprayVariable(_Control.IPAddress.edata11
                                          ,'/bdb_82/wcb/input/'+filedate+'/'+pp_nchar_file
										  //,pp_nchar_file
										  ,100000
										  ,'\t'
										  ,'\\n,\\r\\n'
										  ,'"'
										  ,%groupname%
										  ,WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::premium_plus_native_character::'+filedate
										  ,
										  ,
										  ,
										  ,true
										  ,true
										  ,false);    										  


%super_st_file% 	:= sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(  WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::standard::delete',
				                            WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::standard::grandfather',, true),
				FileServices.ClearSuperFile(WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::standard::grandfather'),
				FileServices.AddSuperFile(  WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::standard::grandfather',
				                            WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::standard::father',, true),
				FileServices.ClearSuperFile(WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::standard::father'),
				FileServices.AddSuperFile(  WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::standard::father', 
				                            WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::standard',, true),
				FileServices.ClearSuperFile(WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::standard'),
				FileServices.AddSuperFile(	WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::standard', 
    				                        WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::standard::' + filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile(WorldCheck_Bridger.cluster_name   + 'in::worldCheck_bridger::standard::delete',true));


%super_pp_file% 	:= sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(  WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::premium_plus::delete',
				                            WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::premium_plus::grandfather',, true),
				FileServices.ClearSuperFile(WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::premium_plus::grandfather'),
				FileServices.AddSuperFile(  WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::premium_plus::grandfather',
				                            WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::premium_plus::father',, true),
				FileServices.ClearSuperFile(WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::premium_plus::father'),
				FileServices.AddSuperFile(  WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::premium_plus::father', 
				                            WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::premium_plus',, true),
				FileServices.ClearSuperFile(WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::premium_plus'),
				FileServices.AddSuperFile(  WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::premium_plus', 
    				                        WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::premium_plus::' + filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile(WorldCheck_Bridger.cluster_name   + 'in::worldCheck_bridger::premium_plus::delete',true));


%super_pp_nchar_file% 	:= sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(  WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::premium_plus_native_character::delete',
				                            WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::premium_plus_native_character::grandfather',, true),
				FileServices.ClearSuperFile(WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::premium_plus_native_character::grandfather'),
				FileServices.AddSuperFile(  WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::premium_plus_native_character::grandfather',
				                            WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::premium_plus_native_character::father',, true),
				FileServices.ClearSuperFile(WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::premium_plus_native_character::father'),
				FileServices.AddSuperFile(  WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::premium_plus_native_character::father', 
				                            WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::premium_plus_native_character',, true),
				FileServices.ClearSuperFile(WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::premium_plus_native_character'),
				FileServices.AddSuperFile(  WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::premium_plus_native_character', 
    				                        WorldCheck_Bridger.cluster_name + 'in::worldCheck_bridger::premium_plus_native_character::' + filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile(WorldCheck_Bridger.cluster_name   + 'in::worldCheck_bridger::premium_plus_native_character::delete',true));


#uniquename(do_super)
%do_super%  		:= sequential(%spray_st_file%,
					%spray_pp_file%,
					%spray_pp_nchar_file%,
					%super_st_file%,
					%super_pp_file%,
					%super_pp_nchar_file%);

return sequential(%do_super%);

end;
