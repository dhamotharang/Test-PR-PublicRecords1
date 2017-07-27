import WorldCheck,lib_FileServices,_Control;

export proc_WorldCheck_Spray (string filename
                             ,string filedate) := function

#uniquename(spray_main)
#uniquename(super_main)
#uniquename(sourceCsvSeparator)
#uniquename(sourceCsvTeminator)
#uniquename(groupname)
#uniquename(Layout_In_File)
#uniquename(outfile)
#uniquename(ds)
#uniquename(trfProject)
#uniquename(temp_delete)

#workunit('name','World Check ' + filedate + ' Spray ');

%sourceCsvSeparator% := '\\t';
%sourceCsvTeminator% := '\\n,\\r\\n';
%groupname% := 'thor_dell400';

%spray_main% := fileservices.SprayVariable(_Control.IPAddress.edata12
                                          //,'/data_999/world_check/data/'+filedate+'/'+filename
										  ,filename
										  ,
										  ,'\t'
										  ,'\\n,\\r\\n'
										  ,'"'
										  ,%groupname%
										  ,WorldCheck.cluster_name + 'in::WorldCheck::'+filedate+'::temp_data'
										  ,
										  ,
										  ,
										  ,true
										  ,true
										  ,false);   										  

%Layout_In_File% := record, maxlength(30000)
	WorldCheck.Layout_WorldCheck_in;
end;

%Layout_In_File% %trfProject%(%Layout_In_File% l) := transform
	self := l;
end;

%outfile% := distribute(project(dataset(WorldCheck.cluster_name + 'in::WorldCheck::'+filedate+'::temp_data'
                                       ,%Layout_In_File%
							           ,csv(heading(1)
							               ,separator('\t')
							               ,terminator(['\r\n','\r','\n'])
								           ,maxlength(30000)
								           )
							           )
					           ,%trfProject%(left))
					   ,hash32(UID));

%ds% := output(%outfile%,,WorldCheck.cluster_name + 'in::WorldCheck::'+filedate+'::Data',overwrite);

%temp_delete% := if (FileServices.FileExists(       WorldCheck.cluster_name + 'in::WorldCheck::'+filedate+'::temp_data')
                    ,FileServices.DeleteLogicalFile(WorldCheck.cluster_name + 'in::WorldCheck::'+filedate+'::temp_data'));

%super_main% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(  WorldCheck.cluster_name + 'in::WorldCheck::Delete',
				                            WorldCheck.cluster_name + 'in::WorldCheck::Grandfather',, true),
				FileServices.ClearSuperFile(WorldCheck.cluster_name + 'in::WorldCheck::Grandfather'),
				FileServices.AddSuperFile(  WorldCheck.cluster_name + 'in::WorldCheck::Grandfather',
				                            WorldCheck.cluster_name + 'in::WorldCheck::Father',, true),
				FileServices.ClearSuperFile(WorldCheck.cluster_name + 'in::WorldCheck::Father'),
				FileServices.AddSuperFile(  WorldCheck.cluster_name + 'in::WorldCheck::Father', 
				                            WorldCheck.cluster_name + 'in::WorldCheck',, true),
				FileServices.ClearSuperFile(WorldCheck.cluster_name + 'in::WorldCheck'),
				FileServices.AddSuperFile(  WorldCheck.cluster_name + 'in::WorldCheck', 
    				                        WorldCheck.cluster_name + 'in::WorldCheck::' + filedate + '::Data'), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile(WorldCheck.cluster_name   + 'in::WorldCheck::Delete',true));


#uniquename(do_super)
%do_super%  := sequential(%spray_main%
                           ,%ds%
						   ,%super_main%
						   ,%temp_delete%
				   
						   
						   );

return sequential(%do_super%);

end;
