import Calbus;

//*********************************************************************************
//*** USAGE :-
//*** Calbus.Mac_Calbus_Spray
//*** (
//***	'edata12.br.seisint.com',   //edata12
//***	'/data_build_1/Calbus/',     //File Path
//***	'20070607',                 //process date
//***	'20070607',                 //file date
//***	'Ca_20070607_FTACT.txt',    //File name
//***	'thor_dataland_linux',      //Group name
//***	'N'                         //Clear Superfile - should always be set to "N"
//*** )
//**********************************************************************************
export Mac_Calbus_Spray(source_IP,source_path,process_date,filedate,file_name,group_name,clear_Super='N',retval) := 
macro
#uniquename(spray_main)
#uniquename(super_main)
#uniquename(super_main1)
#uniquename(cleaned_ds)
#uniquename(cleaned_file)
#uniquename(raw_delete)
#uniquename(deleteIfExist)
#uniquename(doCleanup)
#uniquename(recSize)
#uniquename(CreateSuperfiles)
#uniquename(CreateSuperIfNotExist)
#uniquename(do_super)
#uniquename(do_super1)
#uniquename(out_super)


//#workunit('name','Calbus Spray -' + process_date);

// Calbus input record length
%recSize% := 396;  //New length with NAICS code


%doCleanup% := sequential(FileServices.RemoveSuperFile(Calbus.Constants.Cluster + 'in::Calbus::Old',
                                                        Calbus.Constants.Cluster + 'in::Calbus::'+filedate+'::cleaned'),
						   FileServices.RemoveSuperFile(Calbus.Constants.Cluster + 'in::Calbus::Delete',
														Calbus.Constants.Cluster + 'in::Calbus::'+filedate+'::cleaned'),
	                       FileServices.RemoveSuperFile(Calbus.Constants.Cluster + 'in::Calbus::Superfile2',
														Calbus.Constants.Cluster + 'in::Calbus::'+filedate+'::cleaned'),
						   FileServices.DeleteLogicalFile(Calbus.Constants.Cluster + 'in::Calbus::'+filedate+'::cleaned'));

%deleteIfExist% := if(FileServices.FileExists(Calbus.Constants.Cluster + 'in::Calbus::'+filedate+'::cleaned'),
					  %doCleanup%);

%spray_main% := FileServices.SprayFixed(Source_IP,source_path + file_name,%recSize%,group_name,Calbus.Constants.Cluster +'in::Calbus::raw_'+filedate,-1,,,true,true);

%cleaned_ds% := output(Calbus.Cleaned_Calbus(process_date, filedate),,Calbus.constants.cluster + 'in::Calbus::'+filedate+'::cleaned',overwrite);

%raw_delete% := if (FileServices.FileExists(Calbus.Constants.Cluster + 'in::Calbus::raw_'+ filedate), 
					FileServices.DeleteLogicalFile(Calbus.Constants.Cluster + 'in::Calbus::raw_'+ filedate));

%CreateSuperfiles% := sequential(FileServices.CreateSuperFile(Calbus.Constants.Cluster + 'in::Calbus::Superfile2',false),
								  FileServices.CreateSuperFile(Calbus.Constants.Cluster + 'in::Calbus::Delete',false),
								  FileServices.CreateSuperFile(Calbus.Constants.Cluster + 'in::Calbus::Old',false)																	
								  );
%CreateSuperIfNotExist% := if (~FileServices.SuperFileExists(Calbus.Constants.Cluster + 'in::Calbus::Superfile2'),%CreateSuperfiles%); 
			
%super_main% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(Calbus.Constants.Cluster + 'in::Calbus::Delete',
				                          Calbus.Constants.Cluster + 'in::Calbus::Old',, true),
				FileServices.ClearSuperFile(Calbus.Constants.Cluster + 'in::Calbus::Old'),
				FileServices.AddSuperFile(Calbus.Constants.Cluster + 'in::Calbus::Old', 
				                          Calbus.Constants.Cluster + 'in::Calbus::Superfile2',, true),
				FileServices.ClearSuperFile(Calbus.Constants.Cluster + 'in::Calbus::Superfile2'),
				FileServices.AddSuperFile(Calbus.Constants.Cluster + 'in::Calbus::Superfile2', 
				                          Calbus.Constants.Cluster + 'in::Calbus::'+filedate+'::cleaned'), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile(Calbus.Constants.Cluster + 'in::Calbus::Delete',true));

%super_main1% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(Calbus.Constants.Cluster + 'in::Calbus::Delete',
				                          Calbus.Constants.Cluster + 'in::Calbus::Old',, true),
				FileServices.ClearSuperFile(Calbus.Constants.Cluster + 'in::Calbus::Old'),
				FileServices.AddSuperFile(Calbus.Constants.Cluster + 'in::Calbus::Old', 
				                          Calbus.Constants.Cluster + 'in::Calbus::Superfile2',, true),
				FileServices.AddSuperFile(Calbus.Constants.Cluster + 'in::Calbus::Superfile2', 
				                          Calbus.Constants.Cluster + 'in::Calbus::'+filedate+'::cleaned'), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile(Calbus.Constants.Cluster + 'in::Calbus::Delete',true));


%do_super%  := sequential(output('do super 1...'),%CreateSuperIfNotExist%, %deleteIfExist%, %spray_main%, %cleaned_ds%, %super_main%, %raw_delete%);

%do_super1% := sequential(output('do super 2...'),%CreateSuperIfNotExist%, %deleteIfExist%, %spray_main%, %cleaned_ds%, %super_main1%, %raw_delete%);
%out_super% := if(clear_Super = 'Y',sequential(%do_super%),sequential(%do_super1%));

retval := sequential(%out_super%);

endmacro;