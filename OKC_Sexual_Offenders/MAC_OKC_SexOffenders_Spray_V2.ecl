import OKC_Sexual_Offenders, doxie_build;

// export MAC_OKC_SexOffenders_Spray_V2(source_IP,source_path,source_state,file_name,group_name ='\'thor_dataland_linux\'',clear_Super ='Y') := 
export Mac_OKC_SexOffenders_Spray_V2(source_IP,source_path,source_state,file_name,group_name ='\'thor_200\'',clear_Super ='Y') := 
macro
#uniquename(spray_main)
#uniquename(super_main)
#uniquename(super_main1)
#uniquename(sourceCsvSeparater)
#uniquename(sourceCsvTeminater)
#uniquename(sourceCsvQuote)
#uniquename(Layout_In_File)
#uniquename(Layout_In_File_V2)
#uniquename(outfile)
#uniquename(ds)
#uniquename(trfProject)
#uniquename(temp_delete)
#uniquename(deleteIfExist)
#uniquename(doCleanup)


#workunit('name','OKC SexOffender ' + source_state + ' Spray ');

%sourceCsvSeparater% := '\\|';
%sourceCsvTeminater% := '\\n,\\r\\n';
// %sourceCsvQuote% := '\"';
%sourceCsvQuote% := '';

%doCleanup% := sequential(FileServices.RemoveSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::old'
                                                       ,OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::data_'+file_name)
						  ,FileServices.RemoveSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::Delete'
						                               ,OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::data_'+file_name)
						  ,FileServices.RemoveSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::Superfile'
						                               ,OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::data_'+file_name)
						  ,//FileServices.DeleteLogicalFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::temp_'+file_name),
						     FileServices.DeleteLogicalFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::data_'+file_name));

%deleteIfExist% := if(FileServices.FileExists(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::data_'+file_name),
										  %doCleanup%);
/*                             SprayVariable(const varstring sourceIP
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
										  , boolean compress=false)
*/
%spray_main% := FileServices.SprayVariable(Source_IP
                                          ,source_path + file_name
										  ,9999
										  ,%sourceCsvSeparater%
										  ,
										  ,%sourceCsvQuote%
										  ,group_name
										  ,OKC_Sexual_Offenders.Cluster +'in::OKC_Sex_Off::'+source_state+'::temp_'+file_name
										  ,-1
										  ,
										  ,
										  ,true
										  ,true);

// Old source layout
%Layout_In_File% := record, maxlength(9999)
	OKC_Sexual_Offenders.Layout_OKC;
end;

// New source layout
%Layout_In_File_V2% := record, maxlength(9999)
	OKC_Sexual_Offenders.Layout_OKC_V2;
end;

// Trim the additional comments fields down to 1000 to be sure that the data can be parsed properly.
%Layout_In_File% %trfProject%(%Layout_In_File_v2% l) := transform
	self.orig_state   := if(trim(l.orig_state,left,right) = '', source_state, l.orig_state);
	//self.addl_comments_1 := if(length(l.addl_comments_1) > 1000,l.addl_comments_1(1..1000), l.addl_comments_1;
	self.addl_comments_1 := trim(l.addl_comments_1[1..1000],left,right);
	self.addl_comments_2 := trim(l.addl_comments_2[1..1000],left,right);
	self := l;
end;

%outfile% := project(dataset(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::temp_'+file_name,%Layout_In_File_V2%,csv(heading(1),separator('|'),terminator(['\r\n','\r','\n']),quote('"'),maxlength(9999))),
                     %trfProject%(left));

%ds% := output(%outfile%,,OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::data_'+file_name,overwrite);

%temp_delete% := if (FileServices.FileExists(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::temp_'+file_name), 
											FileServices.DeleteLogicalFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::temp_'+file_name));

%super_main% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::Delete',
				                          OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::old',, true),
				FileServices.ClearSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::old'),
				FileServices.AddSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::old', 
				                          OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::Superfile',, true),
				FileServices.ClearSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::Superfile'),
				FileServices.AddSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::Superfile', 
				                          OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::data_'+file_name), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::Delete',true));

%super_main1% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::Delete',
				                          OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::old',, true),
				FileServices.ClearSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::old'),
				FileServices.AddSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::old', 
				                          OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::Superfile',, true),
				FileServices.AddSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::Superfile', 
				                          OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::data_'+file_name), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile(OKC_Sexual_Offenders.Cluster + 'in::OKC_Sex_Off::'+source_state+'::Delete',true));

#uniquename(do_super)
#uniquename(do_super1)
#uniquename(out_super)

%do_super%  := sequential(output('do super 1...'),%deleteIfExist%, %spray_main%, %ds%, %super_main%, %temp_delete%);

%do_super1% := sequential(output('do super 2...'),%deleteIfExist%, %spray_main%, %ds%, %super_main1%, %temp_delete%);

%out_super% := if(clear_Super = 'Y',sequential(%do_super%),sequential(%do_super1%));

sequential(%out_super%);

endmacro;
