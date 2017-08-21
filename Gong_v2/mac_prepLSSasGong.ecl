import RoxieKeyBuild;

export mac_prepLSSasGong(sourcefile,destfile, fileno, group_name= '',email_target='\' \'') := macro

#option('KEEP_THOR_SPILLS', 1);
#workunit('priority','high');
#workunit('name','Yogurt:Gong Spray & Base File Build: '+fileno[1..8] + '_' + fileno[9..10]);
#OPTION('AllowedClusters','thor400_44,thor400_60');
//#OPTION('AllowAutoSwitchQueue','1');
//#stored('did_add_force','thor');
//#stored('roxie_regression_system','stg_vip');

#uniquename(clear_it)
#uniquename(spray_it)
#uniquename(move_it)
%clear_it% := FileServices.ClearSuperFile(Gong_v2.thor_cluster+'in::gongv2_update',true);

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


sequential(%clear_it%,
			%get_priority1%,
			%get_priority2%,
			 gong_v2.proc_LSSasGong_jtrost(Gong_v2.File_Raw_LSS,fileno),
			%clear_it%,
			 Gong_v2.proc_build_all_jtrost);
			//notify('GONG SPRAY COMPLETE','*'), //Begin Gong Base File Build - Builds Base File
      //FileServices.SendEmail('cbrodeur@seisint.com, cguyton@seisint.com', 'GONG - Notify Sent', thorlib.wuid() + ': Gong spray complete')
			//);
			

endmacro;

