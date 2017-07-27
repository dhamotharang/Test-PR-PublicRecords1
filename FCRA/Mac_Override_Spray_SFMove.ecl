export Mac_Override_Spray_SFMove(sourceIP,filename,recordsize,datasetname,filedate,group_name ='\'thor_dell400\'') :=
macro

#uniquename(sprayfile)
#uniquename(super_main)

	%sprayfile% := FileServices.SprayFixed(sourceIP,filename, recordsize,group_name,'~thor_data400::in::override::fcra::'+filedate+'::'+datasetname,-1,,,true,true);
	%super_main% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile('~thor_data400::base::override::fcra::delete::'+datasetname,'~thor_data400::base::override::fcra::father::'+datasetname,, true),
				FileServices.ClearSuperFile('~thor_data400::base::override::fcra::father::'+datasetname),
				FileServices.AddSuperFile('~thor_data400::base::override::fcra::father::'+datasetname, '~thor_data400::base::override::fcra::qa::'+datasetname,, true),
				FileServices.ClearSuperFile('~thor_data400::base::override::fcra::qa::'+datasetname),
				FileServices.AddSuperFile('~thor_data400::base::override::fcra::qa::'+datasetname, '~thor_data400::in::override::fcra::'+filedate+'::'+datasetname), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_data400::base::override::fcra::delete::'+datasetname,true));

sequential(%sprayfile%,%super_main%);
	
endmacro;