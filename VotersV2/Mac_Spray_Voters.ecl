import VotersV2;

//*******************************************************************************************
//*** Usage :-
//*** VotersV2.Mac_Spray_Voters
//*** (
//*** 	'edata12.br.seisint.com',     //edata12
//***   '/data_build_1/emerges/ri/',  //File Path
//*** 	'RI',                         //Source State
//*** 	'20061220',                   //filedate
//*** 	'RI_voter_689470_dec_20_2006_emerges_cass_v1_target.txt',  //File name
//***	'thor_dataland_linux',        //Group name
//***   'N'                           //Clear Superfile
//*** )
//*******************************************************************************************

export Mac_Spray_Voters(source_IP,source_path,source_state,filedate,file_name,group_name,clear_Super='N') := 
macro
#uniquename(spray_main)
#uniquename(super_main)
#uniquename(super_main1)
#uniquename(cleaned_file)
#uniquename(raw_delete)
#uniquename(deleteIfExist)
#uniquename(doCleanup)
#uniquename(recSize)
#uniquename(CreateSuperFiles)
#uniquename(CreateSuperIfNotExist)
#uniquename(do_super)
#uniquename(do_super1)
#uniquename(out_super)

#workunit('name',source_state+' Voter Reg Spray ');

%recSize% := 1888;


%doCleanup% := sequential(FileServices.RemoveSuperFile(VotersV2.cluster + 'in::Voters::'+source_state+'::Old',
														VotersV2.cluster + 'in::Voters::'+source_state+'::'+filedate+'::cleaned'),
						   FileServices.RemoveSuperFile(VotersV2.cluster + 'in::Voters::'+source_state+'::Delete',
														VotersV2.cluster + 'in::Voters::'+source_state+'::'+filedate+'::cleaned'),
				           FileServices.RemoveSuperFile(VotersV2.cluster + 'in::Voters::'+source_state+'::Superfile',
														VotersV2.cluster + 'in::Voters::'+source_state+'::'+filedate+'::cleaned'),
						   FileServices.DeleteLogicalFile(VotersV2.cluster + 'in::Voters::'+source_state+'::'+filedate+'::cleaned'));

%deleteIfExist% := if(FileServices.FileExists(VotersV2.cluster + 'in::Voters::'+source_state+'::'+filedate+'::cleaned'),
					  %doCleanup%);

%spray_main% := FileServices.SprayFixed(Source_IP,source_path + file_name,%recSize%,group_name,VotersV2.cluster +'in::Voters::'+source_state+'::raw_'+filedate,-1,,,true,true);

%raw_delete% := if (FileServices.FileExists(VotersV2.cluster + 'in::Voters::'+source_state+'::raw_'+ filedate), 
					FileServices.DeleteLogicalFile(VotersV2.cluster + 'in::Voters::'+source_state+'::raw_'+ filedate));


%CreateSuperfiles% := sequential(FileServices.CreateSuperFile(VotersV2.cluster + 'in::Voters::'+source_state+'::Superfile',false),
                                  FileServices.CreateSuperFile(VotersV2.cluster + 'in::Voters::'+source_state+'::Delete',false),
								  FileServices.CreateSuperFile(VotersV2.cluster + 'in::Voters::'+source_state+'::Old',false),
								  FileServices.StartSuperFileTransaction(),
								  FileServices.AddSuperFile(VotersV2.Cluster + 'in::Voters::main::Superfile'
								                           ,VotersV2.Cluster + 'in::Voters::'+source_state+'::Superfile'),
								  FileServices.FinishSuperFileTransaction()
								 );
%CreateSuperIfNotExist% := if (~FileServices.SuperFileExists(VotersV2.cluster + 'in::Voters::'+source_state+'::Superfile'),%CreateSuperfiles%); 
			
%cleaned_file% := output(VotersV2.Cleaned_Voters(source_state, filedate),,VotersV2.cluster + 'in::Voters::'+source_state+'::'+filedate+'::cleaned',overwrite);

%super_main% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(VotersV2.cluster + 'in::Voters::'+source_state+'::Delete',
				                          VotersV2.cluster + 'in::Voters::'+source_state+'::Old',, true),
				FileServices.ClearSuperFile(VotersV2.cluster + 'in::Voters::'+source_state+'::Old'),
				FileServices.AddSuperFile(VotersV2.cluster + 'in::Voters::'+source_state+'::Old', 
				                          VotersV2.cluster + 'in::Voters::'+source_state+'::Superfile',, true),
				FileServices.ClearSuperFile(VotersV2.cluster + 'in::Voters::'+source_state+'::Superfile'),
				FileServices.AddSuperFile(VotersV2.cluster + 'in::Voters::'+source_state+'::Superfile', 
				                          VotersV2.cluster + 'in::Voters::'+source_state+'::'+filedate+'::cleaned'), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile(VotersV2.cluster + 'in::Voters::'+source_state+'::Delete',true));

%super_main1% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(VotersV2.cluster + 'in::Voters::'+source_state+'::Delete',
				                          VotersV2.cluster + 'in::Voters::'+source_state+'::Old',, true),
				FileServices.ClearSuperFile(VotersV2.cluster + 'in::Voters::'+source_state+'::Old'),
				FileServices.AddSuperFile(VotersV2.cluster + 'in::Voters::'+source_state+'::Old', 
				                          VotersV2.cluster + 'in::Voters::'+source_state+'::Superfile',, true),
				FileServices.AddSuperFile(VotersV2.cluster + 'in::Voters::'+source_state+'::Superfile', 
				                          VotersV2.cluster + 'in::Voters::'+source_state+'::'+filedate+'::cleaned'), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile(VotersV2.cluster + 'in::Voters::'+source_state+'::Delete',true));


%do_super%  := sequential(output('do super 1...'),%CreateSuperIfNotExist%, %deleteIfExist%, %spray_main%, %cleaned_file%, %super_main%, %raw_delete%);

%do_super1% := sequential(output('do super 2...'),%CreateSuperIfNotExist%, %deleteIfExist%, %spray_main%, %cleaned_file%, %super_main1%, %raw_delete%);

%out_super% := if(clear_Super = 'Y',sequential(%do_super%),sequential(%do_super1%));

sequential(%out_super%);

endmacro;