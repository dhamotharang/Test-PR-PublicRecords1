import addr_latest;

export mac_la_spray(FTPServerIP,infile,group_name ='\'thor_dell400\'',email_target='\' \'') := macro

#uniquename(max_rec_size)
#uniquename(super_in)
#uniquename(thor_file)
#uniquename(spray_in)
#uniquename(add_to_super)

%max_rec_size% := 300;
%super_in% := '~thor_data400::in::linebarger_spray';
%thor_file% := '~thor_data400::in::linebarger_raw_' + thorlib.wuid();

%spray_in% := FileServices.SprayVariable(FTPServerIP,infile,%max_rec_size%,,,,group_name,%thor_file%,-1,,,true,true);

%add_to_super% := 
sequential(
	FileServices.StartSuperFileTransaction(),
	FileServices.AddSuperFile(%super_in% + '_Delete', %super_in% + '_Grandfather',, true),
	FileServices.ClearSuperFile(%super_in% + '_Grandfather'),
	FileServices.AddSuperFile(%super_in% + '_Grandfather', %super_in% + '_Father',, true),
	FileServices.ClearSuperFile(%super_in% + '_Father'),
	FileServices.AddSuperFile(%super_in% + '_Father', %super_in%,, true),
	FileServices.ClearSuperFile(%super_in%),
	FileServices.AddSuperFile(%super_in%, %thor_file%), 
	FileServices.FinishSuperFileTransaction(),
	FileServices.ClearSuperFile(%super_in% + '_Delete',true));

sequential(%spray_in%, %add_to_super%)
 : success(lib_fileservices.FileServices.sendemail(if(email_target<>' ',email_target,Addr_latest.Spray_Notification_Email_Address),'Linebarger Spray Succeeded',
           infile + ' has been sprayed to thor')),
   failure(lib_fileservices.FileServices.sendemail(if(email_target<>' ',email_target,Addr_latest.Spray_Notification_Email_Address),'Linebarger Spray Failure',
           FAILMESSAGE));

endmacro;