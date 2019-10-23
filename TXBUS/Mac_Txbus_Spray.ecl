import Txbus;
//*********************************************************************************
//*** USAGE :-
//*** Txbus.Mac_Txbus_Spray
//*** (
//***	'edata12.br.seisint.com',   //edata12
//***	'/data_build_1/txbus/',     //File Path
//***	'20070607',                 //process date
//***	'20070607',                 //file date
//***	'thor_dataland_linux',      //Group name
//*** )
//**********************************************************************************
export Mac_Txbus_Spray(source_IP,source_path,process_date,filedate,file_name,group_name,retval) := 
macro
#uniquename(spray_main)
#uniquename(check_rawFile_exist)
#uniquename(cleaned_ds)
#uniquename(CreateSuperfile)
#uniquename(CreateSuperIfNotExist)
#uniquename(CreateRawSuperfile)
#uniquename(CreateRawSuperIfNotExist)
#uniquename(super_Clean_main)
#uniquename(add_Clean_super)
#uniquename(do_super)
#uniquename(add_Raw_super)
#uniquename(add_super)
#uniquename(out_clen)
#uniquename(recSize)
#uniquename(Message_raw_file)
#uniquename(Message_clean_file)
#uniquename(Message_super_file)
// TXBUS input record lenght
%recSize% := 303;

%Message_raw_file%     := output(Txbus.Constants.Cluster +'in::Txbus::'+ filedate +'::stact_raw   --'  + '\n   Input spray File existed already, skipped the spray step');
%Message_clean_file%   := output(Txbus.constants.cluster +'in::Txbus::'+filedate+'::stact_cleaned   --' + '\n Cleaned File existed already, skipped the Cleaned_Txbus step');
%Message_super_file%   := output('Cleaned file version already exist in the superFile   --' + Txbus.Constants.Cluster + 'in::Txbus::Superfile');

%spray_main% 					 := FileServices.SprayFixed(Source_IP,source_path + file_name,%recSize%,group_name,Txbus.Constants.Cluster +'in::Txbus::'+ filedate +'::stact_raw',-1,,,true,true);
%check_rawFile_exist%  := if (not FileServices.FileExists(Txbus.Constants.Cluster +'in::Txbus::'+ filedate +'::stact_raw'),%spray_main%,%Message_raw_file% );
%out_clen%   					 := output(Txbus.Cleaned_Txbus(process_date, filedate),,Txbus.constants.cluster + 'in::Txbus::'+filedate+'::stact_cleaned',overwrite);
%cleaned_ds% 					 := if (not FileServices.FileExists(Txbus.constants.cluster + 'in::Txbus::'+filedate+'::stact_cleaned'),%out_clen%,%Message_clean_file%);
                                     

%CreateSuperfile%         := FileServices.CreateSuperFile(Txbus.Constants.Cluster + 'in::Txbus::qa::Clean_updates::Superfile',false);
%CreateSuperIfNotExist%   := if (~FileServices.SuperFileExists(Txbus.Constants.Cluster + 'in::Txbus::qa::Clean_updates::Superfile'),%CreateSuperfile%); 
%CreateRawSuperfile%      := FileServices.CreateSuperFile(Txbus.Constants.Cluster + 'in::Txbus::Raw::Superfile',false);
%CreateRawSuperIfNotExist%:= if (~FileServices.SuperFileExists(Txbus.Constants.Cluster + 'in::Txbus::Raw::Superfile'),%CreateRawSuperfile%);

%add_Raw_super% 		   := sequential(FileServices.StartSuperFileTransaction(),					
																		 FileServices.AddSuperFile(Txbus.Constants.Cluster + 'in::Txbus::Raw::Superfile', 
																															 Txbus.Constants.Cluster + 'in::Txbus::'+ filedate +'::stact_raw'), 
																		 FileServices.FinishSuperFileTransaction(),
																		 output(Txbus.constants.cluster +'in::Txbus::'+ filedate +'::stact_raw  --' + '\n Raw file has been added to the superFile')
																		 );
%add_Clean_super% 		 := sequential(FileServices.StartSuperFileTransaction(),					
																		 FileServices.AddSuperFile(Txbus.Constants.Cluster + 'in::Txbus::qa::Clean_updates::Superfile', 
																															 Txbus.Constants.Cluster + 'in::Txbus::'+filedate+'::stact_cleaned'), 
																		 FileServices.FinishSuperFileTransaction(),
																		 output(Txbus.constants.cluster +'in::Txbus::'+filedate+'::stact_cleaned  --' + '\n Cleaned file has been added to the superFile')
																		 );

%super_Clean_main% 		 :=if(FileServices.FindSuperFileSubName(Txbus.Constants.Cluster + 'in::Txbus::qa::Clean_updates::Superfile',Txbus.Constants.Cluster + 'in::Txbus::'+filedate+'::stact_cleaned') = 0, %add_Clean_super%,%Message_super_file%);
%do_super% 						 := sequential(%CreateSuperIfNotExist%, %check_rawFile_exist%, %CreateRawSuperIfNotExist%, %cleaned_ds%, %add_Raw_super%, %super_Clean_main%);
retval 						 	   := %do_super%;

endmacro;