import Calbus, Scrubs, Scrubs_Calbus;

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
//*** )
//**********************************************************************************
export Mac_Calbus_Spray(source_IP,source_path,process_date,filedate,file_name,group_name,retval) := 
macro
#uniquename(spray_main)
#uniquename(check_rawFile_exist)
#uniquename(cleaned_ds)
#uniquename(CreateSuperfile)
#uniquename(CreateSuperIfNotExist)
#uniquename(super_Clean_main)
#uniquename(add_Clean_super)
#uniquename(do_super)
#uniquename(add_super)
#uniquename(out_clen)
#uniquename(recSize)
#uniquename(Message_raw_file)
#uniquename(Message_clean_file)
#uniquename(Message_super_file)
#uniquename(scrub_file)
// Calbus input record length
%recSize% := 257;

%Message_raw_file%     := output(Calbus.Constants.Cluster +'in::Calbus::raw_'+filedate+'  --'  + '\n   Input spray File existed already, skipped the spray step');
%Message_clean_file%   := output(Calbus.constants.cluster + 'in::Calbus::'+filedate+'::cleaned   --' + '\n Cleaned File existed already, skipped the Cleaned_Calbus step');
%Message_super_file%   := output('Cleaned file version already exist in the superFile   --' + Calbus.Constants.Cluster + 'in::Calbus::Superfile3');

%spray_main% 					 := FileServices.SprayFixed(Source_IP,source_path + file_name,%recSize%,group_name,Calbus.Constants.Cluster +'in::Calbus::raw_'+filedate,-1,,,true,true);
%scrub_file% 				   := CALBUS.Scrub_Calbus(filedate).Report;
%check_rawFile_exist%  := if (not FileServices.FileExists(Calbus.Constants.Cluster +'in::Calbus::raw_'+filedate),%spray_main%,%Message_raw_file% );
%out_clen%   					 := output(Calbus.Cleaned_Calbus(process_date, filedate),,Calbus.constants.cluster + 'in::Calbus::'+filedate+'::cleaned',overwrite);
%cleaned_ds% 					 := if (not FileServices.FileExists(Calbus.constants.cluster + 'in::Calbus::'+filedate+'::cleaned'),%out_clen%,%Message_clean_file%);
                                     

%CreateSuperfile%      := FileServices.CreateSuperFile(Calbus.Constants.Cluster + 'in::Calbus::Superfile3',false);
%CreateSuperIfNotExist%:= if (~FileServices.SuperFileExists(Calbus.Constants.Cluster + 'in::Calbus::Superfile3'),%CreateSuperfile%); 
%add_Clean_super% 		 := sequential(FileServices.StartSuperFileTransaction(),					
																		 FileServices.AddSuperFile(Calbus.Constants.Cluster + 'in::Calbus::Superfile3', 
																															 Calbus.constants.cluster + 'in::Calbus::'+filedate+'::cleaned'), 
																		 FileServices.FinishSuperFileTransaction(),
																		 output(Calbus.constants.cluster +'in::Calbus::'+filedate+'::cleaned  --' + '\n Cleaned file has been added to the superFile')
																		 );

%super_Clean_main% 		 :=if(FileServices.FindSuperFileSubName(Calbus.Constants.Cluster + 'in::Calbus::Superfile3',Calbus.constants.cluster + 'in::Calbus::'+filedate+'::cleaned') = 0, %add_Clean_super%,%Message_super_file%);
%do_super% 						 := sequential(%CreateSuperIfNotExist%, %check_rawFile_exist%, %scrub_file%, %cleaned_ds%, %super_Clean_main%);

retval 						 	   := %do_super%;

endmacro;