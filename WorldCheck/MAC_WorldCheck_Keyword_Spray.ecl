import WorldCheck, lib_stringlib, _Control;

export MAC_WorldCheck_Keyword_Spray(filedate
                                   ,file_name
								   ,group_name ='\'thor_dell400\'') := 
macro

#uniquename(spray_keywords)
#uniquename(super_keywords)
#uniquename(sourceCsvSeparator)
#uniquename(sourceCsvTeminator)
#uniquename(Layout_In_File)
#uniquename(outfile)
#uniquename(ds)
#uniquename(trfProject)
#uniquename(temp_delete)

#workunit('name','World Check Keyword ' + filedate + ' Spray ');

%sourceCsvSeparator% := '\\t';
%sourceCsvTeminator% := '\\n,\\r\\n';

/*
SprayVariable( const varstring sourceIP
             , const varstring sourcePath
			 , integer4 sourceMaxRecordSize=8192
			 , const varstring sourceCsvSeparate='\\,'
			 , const varstring sourceCsvTerminate='\\n,\\r\\n'
			 , const varstring sourceCsvQuote='\''
			 , const varstring destinationGroup
			 , const varstring destinationLogicalName
			 , integer4 timeOut=-1
			 , const varstring espServerIpPort=lib_system.ws_fs_server
			 , integer4 maxConnections=-1
			 , boolean allowoverwrite=false
			 , boolean replicate=false
			 , boolean compress=false) : c,action,context,entrypoint='fsSprayVariable'; 
*/

%spray_keywords% := fileservices.SprayVariable(_Control.IPAddress.edata12
                                              ,'/data_999/world_check/data/'+filedate+'/'+file_name
					    					  ,200
											  ,%sourceCsvSeparator%
										      ,%sourceCsvTeminator%
										      ,
										      ,group_name
										      ,WorldCheck.cluster + 'in::WorldCheck::'+filedate+'::temp_keywords'
										      ,
										      ,
										      ,
										      ,true
										      ,true
										      ,false);   										  

%Layout_In_File% := record, maxlength(200)
	WorldCheck.Layout_WorldCheck_Keywords_in;
end;

%Layout_In_File% %trfProject%(%Layout_In_File% l) := transform
	self := l;
end;

%outfile% := project(dataset(WorldCheck.cluster + 'in::WorldCheck::'+filedate+'::temp_keywords'
                            ,%Layout_In_File%
							,csv(heading(10)
							    ,separator('\t')
							    ,terminator(['\r\n','\r','\n'])
								,maxlength(200)
								)
							)(LENGTH(source_full_name) > 0 OR LENGTH(authority_country) > 0)
					,%trfProject%(left));

%ds% := output(%outfile%,,WorldCheck.cluster + 'in::WorldCheck::'+filedate+'::keywords',overwrite);

%temp_delete% := if (FileServices.FileExists(       WorldCheck.cluster + 'in::WorldCheck::'+filedate+'::temp_keywords')
                    ,FileServices.DeleteLogicalFile(WorldCheck.cluster + 'in::WorldCheck::'+filedate+'::temp_keywords'));

// %super_keywords% := sequential(FileServices.StartSuperFileTransaction(),
				// FileServices.AddSuperFile(WorldCheck.cluster + 'in::WorldCheck::keywords_Delete',
				                          // WorldCheck.cluster + 'in::WorldCheck::keywords_old',, true),
				// FileServices.ClearSuperFile(WorldCheck.cluster + 'in::WorldCheck::keywords_old'),
				// FileServices.AddSuperFile(WorldCheck.cluster + 'in::WorldCheck::keywords_old', 
				                          // WorldCheck.cluster + 'in::WorldCheck::keywords_Superfile',, true),
				// FileServices.ClearSuperFile(WorldCheck.cluster + 'in::WorldCheck::keywords_Superfile'),
				// FileServices.AddSuperFile(WorldCheck.cluster + 'in::WorldCheck::keywords_Superfile', 
				                          // WorldCheck.cluster + 'in::WorldCheck::'+filedate+'::keywords'), 
				// FileServices.FinishSuperFileTransaction(),
				// FileServices.ClearSuperFile(WorldCheck.cluster + 'in::WorldCheck::keywords_Delete',true));

%super_keywords% := sequential(FileServices.StartSuperFileTransaction(),
    				FileServices.AddSuperFile(  WorldCheck.cluster_name + 'in::WorldCheck::Keywords::Delete',
	    			                            WorldCheck.cluster_name + 'in::WorldCheck::Keywords::Grandfather',, true),
		    		FileServices.ClearSuperFile(WorldCheck.cluster_name + 'in::WorldCheck::Keywords::Grandfather'),
			    	FileServices.AddSuperFile(  WorldCheck.cluster_name + 'in::WorldCheck::Keywords::Grandfather',
				                                WorldCheck.cluster_name + 'in::WorldCheck::Keywords::Father',, true),
				    FileServices.ClearSuperFile(WorldCheck.cluster_name + 'in::WorldCheck::Keywords::Father'),
				    FileServices.AddSuperFile(  WorldCheck.cluster_name + 'in::WorldCheck::Keywords::Father', 
				                                WorldCheck.cluster_name + 'in::WorldCheck::Keywords',, true),
				    FileServices.ClearSuperFile(WorldCheck.cluster_name + 'in::WorldCheck::Keywords'),
				    FileServices.AddSuperFile(  WorldCheck.cluster_name + 'in::WorldCheck::Keywords',     
    				                            WorldCheck.cluster_name + 'in::worldcheck::' + filedate + '::Keywords'), 
	    			FileServices.FinishSuperFileTransaction(),
		    		FileServices.ClearSuperFile(WorldCheck.cluster_name + 'in::WorldCheck::Keywords::Delete',true));

#uniquename(do_super)

%do_super%  := sequential(%spray_keywords%
                           ,%ds%
						   ,%super_keywords%
						   ,%temp_delete%
						   );

sequential(%do_super%);

endmacro;
