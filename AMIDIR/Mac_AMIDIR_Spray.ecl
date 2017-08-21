import AMIDIR;

//export Mac_AMIDIR_Spray(source_IP,source_path,filedate,file_name,group_name ='\'thor_dataland_linux\'',clear_Super ='N', spray_tables ='Y') := 
export Mac_AMIDIR_Spray(source_IP,source_path,filedate,file_name,group_name ='\'thor_dell400\'',clear_Super ='N', spray_tables ='Y') := 
macro
#uniquename(spray_main)
#uniquename(super_main)
#uniquename(super_main1)
#uniquename(spray_hosp)
#uniquename(spray_schl)
#uniquename(spray_spec)
#uniquename(spray_countyp)
#uniquename(Layout_In_File)
#uniquename(Layout_Out_File)
#uniquename(outfile)
#uniquename(ds)
#uniquename(trfProject)
#uniquename(temp_delete)
#uniquename(deleteIfExist)
#uniquename(doCleanup)
#uniquename(recSize)
#uniquename(hospRecSize)
#uniquename(schlRecSize)
#uniquename(specRecSize)
#uniquename(countypRecSize)
#uniquename(Create_Superfiles)
#uniquename(CreateSuperFiles)


#workunit('name','AMIDIR Spray ');

%recSize% := 566;
%hospRecSize% := 36;
%schlRecSize% := 57;
%specRecSize% := 45;
%countypRecSize% := 21;

%doCleanup% := sequential(FileServices.RemoveSuperFile(AMIDIR.Cluster + 'in::AMIDIR::old',
																											 AMIDIR.Cluster + 'in::AMIDIR::data_'+file_name + '_' + filedate),
													FileServices.RemoveSuperFile(AMIDIR.Cluster + 'in::AMIDIR::Delete',
																											 AMIDIR.Cluster + 'in::AMIDIR::data_'+file_name + '_' + filedate),
													FileServices.RemoveSuperFile(AMIDIR.Cluster + 'in::AMIDIR::Superfile',
																											 AMIDIR.Cluster + 'in::AMIDIR::data_'+file_name + '_' + filedate),
													FileServices.DeleteLogicalFile(AMIDIR.Cluster + 'in::AMIDIR::data_'+file_name + '_' + filedate));

%deleteIfExist% := if(FileServices.FileExists(AMIDIR.Cluster + 'in::AMIDIR::data_'+file_name + '_' + filedate),
										  %doCleanup%);

%spray_main% := FileServices.SprayFixed(Source_IP,source_path + file_name,%recSize%,group_name,AMIDIR.Cluster +'in::AMIDIR::temp_'+ file_name + '_' + filedate,-1,,,true,true);

%spray_hosp% := FileServices.SprayFixed(Source_IP,source_path + 'amihosp.TXT',%hospRecSize%,group_name,AMIDIR.Cluster +'in::AMIDIR::AMIHOSP',-1,,,true,true);

%spray_schl% := FileServices.SprayFixed(Source_IP,source_path + 'amischl.TXT',%schlRecSize%,group_name,AMIDIR.Cluster +'in::AMIDIR::AMISCHL',-1,,,true,true);

%spray_spec% := FileServices.SprayFixed(Source_IP,source_path + 'amispec.TXT',%specRecSize%,group_name,AMIDIR.Cluster +'in::AMIDIR::AMISPEC',-1,,,true,true);

%spray_countyp% := FileServices.SprayFixed(Source_IP,source_path + 'countyp.TXT',%countypRecSize%,group_name,AMIDIR.Cluster +'in::AMIDIR::AMICOUNTYP',-1,,,true,true);

%Layout_In_File% := record
	AMIDIR.Layout_AMIDIR_In;
end;

%Layout_Out_File% := record
	string8 processdate := '';
	//%Layout_In_File%;
	AMIDIR.Layout_AMIDIR;
end;

%Layout_Out_File% %trfProject%(%Layout_In_File% l) := transform
	self.processdate := filedate;
	self.CARRIAGE_RETURN := '\n';
	self := l;
end;

%outfile% := project(dataset(AMIDIR.Cluster + 'in::AMIDIR::temp_'+file_name + '_' + filedate,%Layout_In_File%,flat),
                     %trfProject%(left));

%ds% := output(%outfile%,,AMIDIR.Cluster + 'in::AMIDIR::data_'+file_name + '_' + filedate,overwrite);

%temp_delete% := if (FileServices.FileExists(AMIDIR.Cluster + 'in::AMIDIR::temp_'+file_name + '_' + filedate), 
										 FileServices.DeleteLogicalFile(AMIDIR.Cluster + 'in::AMIDIR::temp_'+file_name + '_' + filedate));


%Create_Superfiles% := sequential(FileServices.CreateSuperFile(AMIDIR.Cluster + 'in::AMIDIR::Superfile',false),
																	FileServices.CreateSuperFile(AMIDIR.Cluster + 'in::AMIDIR::Delete',false),
																	FileServices.CreateSuperFile(AMIDIR.Cluster + 'in::AMIDIR::Old',false)																	
																);
%CreateSuperFiles% := if (~FileServices.SuperFileExists(AMIDIR.Cluster + 'in::AMIDIR::Superfile'),%Create_Superfiles%); 

%super_main% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(AMIDIR.Cluster + 'in::AMIDIR::Delete',
				                          AMIDIR.Cluster + 'in::AMIDIR::old',, true),
				FileServices.ClearSuperFile(AMIDIR.Cluster + 'in::AMIDIR::old'),
				FileServices.AddSuperFile(AMIDIR.Cluster + 'in::AMIDIR::old', 
				                          AMIDIR.Cluster + 'in::AMIDIR::Superfile',, true),
				FileServices.ClearSuperFile(AMIDIR.Cluster + 'in::AMIDIR::Superfile'),
				FileServices.AddSuperFile(AMIDIR.Cluster + 'in::AMIDIR::Superfile', 
				                          AMIDIR.Cluster + 'in::AMIDIR::data_'+file_name + '_' + filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile(AMIDIR.Cluster + 'in::AMIDIR::Delete',true));

%super_main1% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(AMIDIR.Cluster + 'in::AMIDIR::Delete',
				                          AMIDIR.Cluster + 'in::AMIDIR::old',, true),
				FileServices.ClearSuperFile(AMIDIR.Cluster + 'in::AMIDIR::old'),
				FileServices.AddSuperFile(AMIDIR.Cluster + 'in::AMIDIR::old', 
				                          AMIDIR.Cluster + 'in::AMIDIR::Superfile',, true),
				FileServices.AddSuperFile(AMIDIR.Cluster + 'in::AMIDIR::Superfile', 
				                          AMIDIR.Cluster + 'in::AMIDIR::data_'+file_name + '_' + filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile(AMIDIR.Cluster + 'in::AMIDIR::Delete',true));

#uniquename(do_super)
#uniquename(do_super1)
#uniquename(out_super)
#uniquename(out_tables)

%do_super%  := sequential(output('do super 1...'),%CreateSuperFiles%, %deleteIfExist%, %spray_main%, %ds%, %super_main%, %temp_delete%);

%do_super1% := sequential(output('do super 2...'),%CreateSuperFiles%, %deleteIfExist%, %spray_main%, %ds%, %super_main1%, %temp_delete%);

%out_super% := if(clear_Super = 'Y',sequential(%do_super%),sequential(%do_super1%));

%out_tables% := if(spray_tables = 'Y', parallel(%spray_hosp%,%spray_schl%,%spray_spec%,%spray_countyp%));

sequential(%out_super%,%out_tables%);

endmacro;
