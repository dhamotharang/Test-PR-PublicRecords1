import bankrupt,ut;
export BWR_Best(boolean isnewheader = false) := function 

string20 var1 := '' : stored('watchtype');
prep_header := ReClean_address.header_;
prep_infutor:= ReClean_address.infutor_;

bjoin := watchdog.BestJoined(isnewheader);

bregular   := project(bjoin, transform(watchdog.Layout_Best, self := left));
bmarketing := project(bjoin, transform(watchdog.Layout_Best, self.phone := if(left.marketing_flag <> 'Y', left.phone, ''), self := left));

ut.MAC_SF_BuildProcess(bregular,'~thor_data400::BASE::Watchdog_Best',one,2);
ut.MAC_SF_BuildProcess(bregular,'~thor_data400::BASE::Watchdog_Best_nonglb',two,2);
ut.mac_sf_buildprocess(bregular,'~thor_data400::BASE::Watchdog_Best_nonutility',three,2);
ut.MAC_SF_BuildProcess(bregular,'~thor_data400::BASE::Watchdog_Best_nonglb_nonutility',four,2);
ut.MAC_SF_BuildProcess(bmarketing,'~thor_data400::BASE::Watchdog_Best_marketing',five,2);
ut.MAC_SF_BuildProcess(bregular,'~thor_data400::base::best_compid',six,2);
ut.MAC_SF_BuildProcess(bregular,'~thor_data400::base::best_compid_weekly',six_weekly,2);
ut.MAC_SF_BuildProcess(bregular,'~thor_data400::BASE::Watchdog_Best_noneq',seven,2);
ut.MAC_SF_BuildProcess(bregular,'~thor_data400::BASE::Watchdog_Best_nonen',eight,2);
ut.MAC_SF_BuildProcess(bregular,'~thor_data400::BASE::Watchdog_Best_nonglb_noneq',nine,2);

//Output the stats
b := output(watchdog.Stats1_best_x_date, named('Best_Stats'));

//output count
c := output(count(watchdog.BestJoined(isnewheader)),named('Total_DIDs'));

 result:= sequential(prep_header
										,prep_infutor
										,map(	var1='nonglb'             => two
													,var1='nonutility'        => three
													,var1='nonglb_nonutility' => four
													,var1='marketing'         => five
													,var1='compid'            => six
													,var1='compid_weekly'     => six_weekly
													,var1='glb_noneq'         => seven
													,var1='glb_nonen'         => eight
													,                            one
													)	,b,c);
return result; 

end; 
							
							