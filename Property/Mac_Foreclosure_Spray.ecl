export Mac_Foreclosure_Spray(sourceIP,sourcefile,filedate,group_name='\'thor400_92\'',email_target='\' \'') := 
macro
#uniquename(sprayIP)
#uniquename(spray_foreclosure)
#uniquename(super_foreclosure)
#uniquename(recordsize)
#uniquename(fullfile)
#uniquename(daily)
#uniquename(dedup_daily)
#uniquename(basefile)
#uniquename(baseout)

#workunit('name','Foreclosure Spray ' + filedate);

%sprayIP% := map(sourceIP = 'edata12' => _control.IPAddress.edata12,
								 sourceIP);

%recordsize% :=3835;

%spray_foreclosure% := FileServices.SprayFixed(%sprayIP%,sourcefile, %recordsize%, group_name,'~thor_data400::in::foreclosure_'+filedate ,-1,,,true,true);

%super_foreclosure% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile('~thor_data400::in::foreclosure_delete','~thor_data400::in::foreclosure_grandfather',, true),
				FileServices.ClearSuperFile('~thor_data400::in::foreclosure_grandfather'),
				FileServices.AddSuperFile('~thor_data400::in::foreclosure_grandfather','~thor_data400::in::foreclosure_father',, true),
				FileServices.ClearSuperFile('~thor_data400::in::foreclosure_father'),
				FileServices.AddSuperFile('~thor_data400::in::foreclosure_father', '~thor_data400::in::foreclosure',, true),
				FileServices.ClearSuperFile('~thor_data400::in::foreclosure'),
				FileServices.AddSuperFile('~thor_data400::in::foreclosure', '~thor_data400::in::foreclosure_'+filedate),
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_data400::in::foreclosure_delete',true));

sequential(%spray_foreclosure%,%super_foreclosure%)
 : success(FileServices.sendemail(if(email_target<>' ',email_target,'kgummadi@seisint.com'),'Foreclosure Spray Succeeded','Foreclosure Spray Succeeded')),
   failure(FileServices.sendemail(if(email_target<>' ',email_target,'kgummadi@seisint.com'),'Foreclosure Spray Failure','Foreclosure Spray Failure'))
 ;

endmacro;