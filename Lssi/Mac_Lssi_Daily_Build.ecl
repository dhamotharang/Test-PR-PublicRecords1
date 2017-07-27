import doxie,lssi;

export Mac_Lssi_Daily_Build(sourceIP,sourcefile,destfile,group_name='\'thor_200\'',email_target='\' \'') := macro
#workunit('name', 'lssi daily build');
#stored('did_add_force','thor');

#uniquename(max_rec_size)	
%max_rec_size%:=800;

#uniquename(spray_it)
#uniquename(move_it)
%spray_it% := FileServices.SprayVariable(sourceIP,sourcefile,%max_rec_size%,,,,group_name,destfile,-1,,,true,true);	
%move_it% := 
sequential(FileServices.StartSuperFileTransaction(),
		 FileServices.ClearSuperFile('~thor_data400::in::lssi_update_grandfather'),
		 FileServices.AddSuperFile('~thor_data400::in::lssi_update_grandfather', 
		                           '~thor_data400::in::lssi_update_father',, true),
		 FileServices.ClearSuperFile('~thor_data400::in::lssi_update_father'),
           FileServices.AddSuperFile('~thor_data400::in::lssi_update_father', 
                                     '~thor_data400::in::lssi_update',, true),
           FileServices.ClearSuperFile('~thor_data400::in::lssi_update'),
           FileServices.AddSuperFile('~thor_data400::in::lssi_update', destfile),
           FileServices.FinishSuperFileTransaction());

#uniquename(get_priority1)
#uniquename(get_priority2)
#uniquename(build_it)

#uniquename(date_pos)
%date_pos% := stringlib.StringFind(stringlib.StringToUpperCase(destfile),'IN::LSSI_',1);

//if trying to build a file bearing an older date, send a warning message 
#if((unsigned)(destfile[%date_pos%+9..%date_pos%+16])<(unsigned)StringLib.GetDateYYYYMMDD()) 
    FileServices.sendemail(if(email_target<>' ',email_target,lssi.Notification_Email_Address),'LSSI Daily Build Warning','Trying to build a file with old date: ' + destfile[%date_pos%+9..%date_pos%+16]);
#end

%get_priority1% := output('spraying...') : success(%spray_it%);
%get_priority2% := output('building...') : success(%move_it%);
%build_it% := lssi.Proc_Build_LSSI_Update_All;    

#uniquename(send_succ_msg)
#uniquename(send_fail_msg)

doxie.Mac_Daily_Email('LSSI','SUCC',%send_succ_msg%,if(email_target<>' ',email_target,lssi.Notification_Email_Address));
doxie.Mac_Daily_Email('LSSI','FAIL',%send_fail_msg%,if(email_target<>' ',email_target,lssi.Notification_Email_Address));

sequential(%get_priority1%,%get_priority2%,%build_it%) :
           success(%send_succ_msg%),
           failure(%send_fail_msg%);

endmacro;