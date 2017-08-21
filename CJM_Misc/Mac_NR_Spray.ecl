export Mac_NR_Spray(sourcefile,filedate,group_name='\'thor_200\'',email_target='\' \'') := 
macro
#uniquename(spray_NR)
#uniquename(super_NR)
#uniquename(recordsize)
#uniquename(fullfile)
#uniquename(daily)
#uniquename(dedup_daily)
#uniquename(basefile)
#uniquename(baseout)
#uniquename(sourceIP)

#workunit('name','OPT Out NR Spray '+filedate);

%sourceIP% := _control.IPAddress.edata12;
%recordsize% :=503;

%spray_NR% := FileServices.SprayFixed(%sourceIP%,sourcefile, %recordsize%, group_name,'~thor_data400::in::optout_nr_did_'+filedate ,-1,,,true,true);

%super_NR% := sequential(
				FileServices.ClearSuperFile('~thor_data400::base::optout_name_removal_father'),
				FileServices.AddSuperFile('~thor_data400::base::optout_name_removal_father', '~thor_data400::base::optout_name_removal',,true),
				FileServices.ClearSuperFile('~thor_data400::base::optout_name_removal'),
				FileServices.AddSuperFile('~thor_data400::base::optout_name_removal', '~thor_data400::in::optout_nr_did_'+filedate)
				);
	
sequential(%spray_NR%,%super_NR%)
 : success(FileServices.sendemail(if(email_target<>' ',email_target,'avenkatachalam@seisint.com'),'NR Spray Succeeded','NR Spray Succeeded')),
   failure(FileServices.sendemail(if(email_target<>' ',email_target,'avenkatachalam@seisint.com'),'NR Spray Failure','NR Spray Failure'))
 ;

endmacro;