import lib_fileservices;

EXPORT fChkOutput := function

string bname := '~thor_data400::base::watchdog_best';



 valid_lf :=  Sequential(	  if (  nothor(fileservices.GetSuperFileSubName( bname+'_nonglb',1)) <> 'thor_data400::base::watchdog_best_nonglb_'+Wdog_WU_All.wuid_nonglb 
																							         ,Sequential(output(nothor(fileservices.GetSuperFileSubName( bname+'_nonglb',1))),fileservices.ClearSuperfile(bname+'_nonglb')
																									        ,fail('Abort:  Watchdog Best nonglb Base LF is missing'))
																							         ,Sequential(Output('Watchdog Best nonglb LF did built.Continue...'),fileservices.Deletelogicalfile('~thor::wdog::wuinfo::nonglb'))), 
																											 
											 if (  nothor(fileservices.GetSuperFileSubName( bname+'_nonutility',1)) <> 'thor_data400::base::watchdog_best_nonutility_'+Wdog_WU_All.wuid_nonutility 
													                           ,Sequential(output(nothor(fileservices.GetSuperFileSubName( bname+'_nonutility',1))),fileservices.ClearSuperfile(bname+'_nonutility')
																										      ,fail('Abort:  Watchdog Best nonutility Base LF is missing'))
																											,Sequential(Output('Watchdog Best nonutility LF did built.Continue...'),fileservices.Deletelogicalfile('~thor::wdog::wuinfo::nonutility'))), 
																											
										   if (  nothor(fileservices.GetSuperFileSubName( bname+'_nonglb_nonutility',1)) <> 'thor_data400::base::watchdog_best_nonglb_nonutility_'+Wdog_WU_All.wuid_nonglb_nonut 
													                                  ,Sequential( output(nothor(fileservices.GetSuperFileSubName( bname+'_nonglb_nonutility',1))), fileservices.ClearSuperfile(bname+'_nonglb_nonutility')
																														     ,fail('Abort:  Watchdog Best nonglb_nonutility Base LF is missing'))
																														,Sequential(Output('Watchdog Best nonglb_nonutility LF did built.Continue...'),fileservices.Deletelogicalfile('~thor::wdog::wuinfo::nonglb_nonutility'))),  
																														
												  
																												
										   if (  nothor(fileservices.GetSuperFileSubName( bname+'_noneq',1)) <> 'thor_data400::base::watchdog_best_noneq_'+Wdog_WU_All.wuid_glbnoneq and not ( count(Wdog_WU_All.glbnoneqds)) > 1
													                           ,Sequential( output(nothor(fileservices.GetSuperFileSubName( bname+'_noneq',1))), fileservices.ClearSuperfile(bname+'_noneq')
																										     ,fail('Abort:  Watchdog Best noneq Base LF is missing'))
																											,Sequential(Output('Watchdog Best noneq LF did built.Continue...'),fileservices.Deletelogicalfile('~thor::wdog::wuinfo::glb_noneq'))),
																											
											 if (  nothor(fileservices.GetSuperFileSubName( bname+'_nonen',1)) <> 'thor_data400::base::watchdog_best_nonen_'+Wdog_WU_All.wuid_glbnonen and not ( count(Wdog_WU_All.glbnonends)) > 1
													                             ,Sequential( output( nothor(fileservices.GetSuperFileSubName( bname+'_nonen',1))) , fileservices.ClearSuperfile(bname+'_nonen')
																											     ,fail('Abort:  Watchdog Best nonen Base LF is missing'))
																												,Sequential(Output('Watchdog Best nonen LF did built.Continue...'),fileservices.Deletelogicalfile('~thor::wdog::wuinfo::glb_nonen'))),  
																												
										   if (  nothor(fileservices.GetSuperFileSubName( bname+'_nonen_noneq',1)) <> 'thor_data400::base::watchdog_best_nonen_noneq_'+Wdog_WU_All.wuid_glbnoneneq and not ( count(Wdog_WU_All.glbnoneneqds)) > 1
													                                  ,Sequential( output( nothor(fileservices.GetSuperFileSubName( bname+'_nonen_noneq',1))) , fileservices.ClearSuperfile(bname+'_nonen_noneq')
																														     ,fail('Abort:  Watchdog Best nonen_noneq Base LF is missing'))
											 																			,Sequential(Output('Watchdog Best nonen_noneq LF did built.Continue...'),fileservices.Deletelogicalfile('~thor::wdog::wuinfo::glb_nonen_noneq'))),
																														 
											 if (  nothor(fileservices.GetSuperFileSubName(bname,1)) <> 'thor_data400::base::watchdog_best_'+Wdog_WU_All.wuid_glb and not( count(Wdog_WU_All.glbds) ) > 1
													             ,Sequential( output( nothor(fileservices.GetSuperFileSubName(bname,1))), fileservices.ClearSuperfile(bname)
																			     ,fail('Abort:  Watchdog Best Base LF is missing'))
																			 ,Sequential(Output('Watchdog Best LF did built.Continue...'),fileservices.Deletelogicalfile('~thor::wdog::wuinfo::glb')) ) 
																			 
												
											
													) : SUCCESS(notify('WATCHDOG BEST FILES VALIDATED','*'));
													
return valid_lf;
													
end;