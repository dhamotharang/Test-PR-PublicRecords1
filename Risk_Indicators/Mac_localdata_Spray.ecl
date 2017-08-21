export Mac_localdata_Spray(sourceIP,sourcefile,filedate,localdata,recsize,group_name,email_target='\' \'') := 
macro
#uniquename(spray_localdata)
#uniquename(super_localdata)
#uniquename(recordsize)
#uniquename(fullfile)
#uniquename(daily)
#uniquename(dedup_daily)
#uniquename(basefile)
#uniquename(baseout)
#uniquename(KeyFileName)

#workunit('name',localdata+' Spray '+filedate);

%recordsize% :=recsize;

%spray_localdata% := FileServices.SprayFixed(sourceIP,sourcefile, %recordsize%, group_name,'~thor_data400::in::'+localdata+'_'+filedate ,-1,,,true,true);

%KeyFileName% := '~thor_data400::base::'+localdata+'_grandfather';

%super_localdata% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile('~thor_data400::base::'+localdata+'_delete','~thor_data400::base::'+localdata+'_grandfather',, true),
				FileServices.ClearSuperFile('~thor_data400::base::'+localdata+'_grandfather'),
				FileServices.AddSuperFile('~thor_data400::base::'+localdata+'_grandfather','~thor_data400::base::'+localdata+'_father',, true),
				FileServices.ClearSuperFile('~thor_data400::base::'+localdata+'_father'),
				FileServices.AddSuperFile('~thor_data400::base::'+localdata+'_father', '~thor_data400::base::'+localdata,, true),
				FileServices.ClearSuperFile('~thor_data400::base::'+localdata),
				FileServices.AddSuperFile('~thor_data400::base::'+localdata, '~thor_data400::in::'+localdata+'_'+filedate),
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_data400::base::'+localdata+'_Delete',true));

sequential(%spray_localdata%,if(lib_fileservices.fileservices.SuperFileExists(%KeyFileName%),
				%super_localdata%,output(%KeyFileName% + ' does not exist')))
 : success(FileServices.sendemail(if(email_target<>' ',email_target,'christopher.brodeur@lexisnexis.com'),localdata+' Spray Succeeded',localdata+' Spray Succeeded')),
   failure(FileServices.sendemail(if(email_target<>' ',email_target,'christopher.brodeur@lexisnexis.com'),localdata+' Spray Failure',localdata+' Spray Failure'))
 ;

endmacro;