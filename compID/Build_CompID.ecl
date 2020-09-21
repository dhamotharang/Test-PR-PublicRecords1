import ut,watchdog,RoxieKeyBuild;

list_out	:='~thor_data400::out::compid::id_list';
delta_out	:= '~thor_data400::delta::best_compid';
DeSpry		:= DeSpray_compID();

#if(Mode.IsWeekly)
	file_out:=compID_weekly(state in Set_States);
	ut.mac_sf_buildprocess(Mod_maintain_list(File_compID_list, file_out).add, list_out, listOUT_weekly, 3,,true);
	samples		:= output(enth(file_out,1000),named('Weekly_sample'));
	stats		:= output(table(file_out,{
								total_inserts_enhanced:=count(group)
										},'dummy',few),named('Weekly_stats'));
	Spry		:= Spray_CompID();
	split		:= Build_all(file_out,Version,true).split_;
	move2SF		:= Build_all(file_out,Version,true).promote_();
	zout:=sequential(watchdog.Input_set
					,watchdog.bwr_best(false)
					,Spry
					,listOUT_weekly
					,samples
					,stats
					,split
					,move2SF
					);
#elseif(Mode.IsMonthly)
	file_out:=compID_monthly(state in Set_States);
	ut.mac_sf_buildprocess(Delta, delta_out,	deltaOUT, 3,,true);
	ut.mac_sf_buildprocess(Mod_maintain_list(File_compID_list,	file_out).add_n_del, list_out, listOUT_monthly, 3,,true);
	samples		:= output(enth(file_out,1000),named('Monthly_sample'));
	stats		:= output(table(file_out,{
								new_cores:=sum(group,if(new_cid_adl<>'' and original_cid_adl='',1,0))
								,collapse:=sum(group,if(adl_stability_flag='C',1,0))
								,split:=sum(group,if(adl_stability_flag='S',1,0))
								,changes:=sum(group,if(new_cid_adl<>'' and original_cid_adl<>'',1,0))
								,total:=count(group)
										},'dummy',few),named('Monthly_stats'));
	//bld_key		:= Build_key(Version);
	//updatedops := RoxieKeyBuild.updateversion('CompIDKeys',Version,'skasavajjala@seisint.com',,'N');
	split		:= Build_all(file_out,Version,true).split_;
	move2SF		:= Build_all(file_out,Version,true).promote_();
  outstrata := compID.out_strata_population(Version);

	zout:=sequential(watchdog.Input_set
					,watchdog.bwr_best(true)
					,BestDL
					,deltaOUT
					,listOUT_monthly
					,samples
					,stats
					//,bld_key
					//,updatedops
					,split
					,move2SF
					,outstrata
					);
#end
export Build_compID:=sequential(zout
								,DeSpry
								)
								: success(Send_Email(Version).Build_Success)
								, failure(Send_Email(Version).Build_Failure)
								;