import ut,watchdog;

list_out	:='~thor_data400::out::compid::id_list';
delta_out	:= '~thor_data400::delta::best_compid';
DeSpry		:= DeSpray_compID();

#if(IsWeekly)
	file_out:=compID_weekly(version,true);
	ut.mac_sf_buildprocess(Mod_maintain_list(File_compID_list, compID_weekly(version,true)).add, list_out, listOUT_weekly, 3,,true);
	samples		:= output(choosen(enth(sort(file_out,record),1,2),1000),named('Weekly_sample'));
	stats		:= output(table(file_out,{adl_stability_flag,cnt:=count(group)},adl_stability_flag),named('Weekly_stats'));
	Spry		:= Spray_CompID();
	split		:= Build_all(file_out,Version,true).split_;
	move2SF		:= Build_all(file_out,Version,true).promote_();
	zout:=sequential(Spry
					,listOUT_weekly
					,samples
					,stats
					,split
					,move2SF
					);
#elseif(IsMonthly)
	file_out:=compID_monthly;
	ut.mac_sf_buildprocess(Delta, delta_out,	deltaOUT, 3,,true);
	ut.mac_sf_buildprocess(Mod_maintain_list(File_compID_list,	compID_monthly).add_n_del, list_out, listOUT_monthly, 3,,true);
	samples		:= output(choosen(enth(sort(file_out,record),1,10),1000),named('Monthly_sample'));
	stats		:= output(table(file_out,{adl_stability_flag,cnt:=count(group)},adl_stability_flag),named('Monthly_stats'));
	bld_key		:= Build_key(Version);
	split		:= Build_all(file_out,Version,true).split_;
	move2SF		:= Build_all(file_out,Version,true).promote_();
	zout:=sequential(watchdog.bwr_best
					,deltaOUT
					,listOUT_monthly
					,samples
					,stats
					,bld_key
					,split
					,move2SF
					);
#end
export Build_compID:=sequential(zout
								,DeSpry
								)
							// : success(Send_Email(Version).Build_Success)
							// , failure(Send_Email(Version).Build_Failure)
							;