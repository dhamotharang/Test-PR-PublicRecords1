import RoxieKeyBuild;

export mac_prepLSSasGong(sourcefile,destfile, fileno, group_name='\'thor_200\'',email_target='\' \'') := macro

#option('KEEP_THOR_SPILLS', 1);
#workunit('priority','high');
#workunit('name','GongDailyV2 Preprocess: 200' + fileno[1..5] + '_' + fileno[6..7]);
#stored('did_add_force','thor');
//#stored('roxie_regression_system','stg_vip');

#uniquename(clear_it)
#uniquename(spray_it)
#uniquename(move_it)
%clear_it% := FileServices.ClearSuperFile(Gong_v2.thor_cluster+'in::gongv2_update');
%spray_it% := FileServices.SprayVariable('10.150.12.242',sourcefile,,,,,group_name,Gong_v2.thor_cluster+'in::gong::orig::'+destfile,-1,,,true,true);	
%move_it% := 
sequential(
FileServices.StartSuperFileTransaction(),
FileServices.AddSuperFile(Gong_v2.thor_cluster + 'in::gongv2_update', Gong_v2.thor_cluster+'in::gong::orig::'+destfile),
FileServices.FinishSuperFileTransaction());

#uniquename(get_priority1)
#uniquename(get_priority2)
#uniquename(build_it)

%get_priority1% := output('spraying...') : success(%spray_it%);
%get_priority2% := output('moving...')   : success(%move_it%);

Gong_v2.map_LSSasGong(Gong_v2.File_Raw_LSS,fileno,%build_it%)


		

#uniquename(send_succ_msg)
#uniquename(send_fail_msg)
RoxieKeyBuild.Mac_Daily_Email_Local('GONG DAILY V2','SUCC',fileno,%send_succ_msg%,if(email_target<>' ',email_target,lssi.Notification_Email_Address));
RoxieKeyBuild.Mac_Daily_Email_Local('GONG DAILY V2','FAIL',fileno,%send_fail_msg%,if(email_target<>' ',email_target,lssi.Notification_Email_Address));

sequential(%clear_it%,
			%get_priority1%,
			%get_priority2%,
			%build_it%,
			%clear_it%,
			%send_succ_msg%
			);

endmacro;

