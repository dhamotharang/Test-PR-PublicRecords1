/*2017-02-28T09:41:41Z (Wendy Ma)
DF-18485
*/
/*2016-09-22T21:14:50Z (Wendy Ma)
DF-17551 add FCRA best append and build type for FCRA best 
*/
import bankrupt,ut,STRATA,FCRA_list,STD;
export BWR_Best(boolean isnewheader = false, string build_type = '') := function 

string20 var1 := '' : stored('watchtype');

var2 := if ( var1 <> '',trim(var1), 'glb' );

Output('Running Watchdog Type : '+var2);

prep_header := ReClean_address.header_;
prep_infutor:= ReClean_address.infutor_;
prep_infutor_narc:= ReClean_address.infutor_narc;

bjoin := watchdog.BestJoined(isnewheader, build_type);

bregular   := project(bjoin, transform(watchdog.Layout_Best, self := left));
bmarketing := project(bjoin, transform(watchdog.Layout_Best, self.phone := if(left.marketing_flag <> 'Y', left.phone, ''), self := left));
bSupplemental	:=	watchdog.BestSupplemental(watchdog.RunDate_build);

//generate approved FCRA list 
FCRA_list_base := FCRA_list.Proc_CreateList().buildbase;
//filter on ADL_ind,re-append RAWAID, suppression and optout 
bFCRAbestList := DISTRIBUTE(FCRA_list.fn_fcra_best_patch(bregular).monthly_optout, RANDOM());
//despray FCRA best file 
despray_FCRAbest := FCRA_list.fn_despray(watchdog.RunDate_build).dmonthly;

ut.MAC_SF_BuildProcess(bregular,'~thor_data400::BASE::Watchdog_Best',one,2,,true);
ut.MAC_SF_BuildProcess(bregular,'~thor_data400::BASE::Watchdog_Best_nonglb',two,2,,true);
ut.MAC_SF_BuildProcess(bregular,'~thor_data400::BASE::Watchdog_Best_nonglb_noneq',twoDotOne,2,,true);
ut.mac_sf_buildprocess(bregular,'~thor_data400::BASE::Watchdog_Best_nonutility',three,2,,true);
ut.MAC_SF_BuildProcess(bregular,'~thor_data400::BASE::Watchdog_Best_nonglb_nonutility',four,2,,true);
ut.MAC_SF_BuildProcess(bmarketing,'~thor_data400::BASE::Watchdog_Best_marketing',five,2,,true);
ut.MAC_SF_BuildProcess(bmarketing,'~thor_data400::BASE::Watchdog_Best_marketing_noneq',fiveDotOne,2,,true);
ut.MAC_SF_BuildProcess(bregular,'~thor_data400::base::best_compid',six,2,,true);
ut.MAC_SF_BuildProcess(bregular,'~thor_data400::base::best_compid_weekly',six_weekly,2,,true);
ut.MAC_SF_BuildProcess(bregular,'~thor_data400::BASE::Watchdog_Best_noneq',seven,2,,true);
ut.MAC_SF_BuildProcess(bregular,'~thor_data400::BASE::Watchdog_Best_nonen',eight,2,,true);
ut.MAC_SF_BuildProcess(bregular,'~thor_data400::BASE::Watchdog_Best_nonglb_noneq',nine,2,,true);
ut.MAC_SF_BuildProcess(bregular,'~thor_data400::BASE::Watchdog_Best_nonen_noneq',ten,2,,true);
ut.MAC_SF_BuildProcess(bSupplemental,'~thor_data400::Base::Watchdog_Best_Supplemental',eleven,2,,true);
ut.MAC_SF_BuildProcess(bFCRAbestList,'~thor_data400::Base::Watchdog_Best_FCRA_list',twelve,3,true,true);
ut.MAC_SF_BuildProcess(bregular,'~thor_data400::Base::Watchdog_Best_FCRA_nonen',thirteen,2,,true);
ut.MAC_SF_BuildProcess(bregular,'~thor_data400::Base::Watchdog_Best_FCRA_noneq',fourteen,2,,true);

//Added Strata to Watchdog Best 
beststats := watchdog.Out_Strata_All(Watchdog.File_Best).stats_all;
bestnonglbstats := watchdog.Out_Strata_All(Watchdog.File_Best_nonglb).stats_all;
bestnonglbnoneqstats := watchdog.Out_Strata_All(Watchdog.File_Best_nonglb_nonEquifax).stats_all;
bestnoneqstats := watchdog.Out_Strata_All(Watchdog.File_Best_nonEquifax).stats_all;
bestnoneneqstats := watchdog.Out_Strata_All(Watchdog.File_Best_nonEquifax_nonExperian).stats_all;
bestnonen := watchdog.Out_Strata_All(Watchdog.File_Best_nonExperian).stats_all;
bestnonglbutil := watchdog.Out_Strata_All(Watchdog.File_Best_nonglb_nonutility).stats_all;
bestnonutil := watchdog.Out_Strata_All(Watchdog.File_Best_nonutility).stats_all;
supplemental := watchdog.Out_Strata_Best_Supplemental(Watchdog.File_Best_Supplemental).Stats_Best_Supplemental;

//Marketing Best
mkbest := watchdog.Out_Strata_All(Watchdog.File_Best_marketing).stats_all;
mkNonEQbest := watchdog.Out_Strata_All(Watchdog.File_Best_marketing_nonEquifax).stats_all;

//FCRA Best
bestfcrastats := watchdog.Out_Strata_All(Watchdog.File_Best_FCRA).stats_all;
bestfcranonen := watchdog.Out_Strata_All(Watchdog.File_Best_FCRA_nonEN).stats_all;
bestfcranoneq := watchdog.Out_Strata_All(Watchdog.File_Best_FCRA_nonEQ).stats_all;

STRATA.createXMLStats(beststats,'Watchdog','Best',watchdog.RunDate_build,'sudhir.kasavajjala@lexisnexis.com',zBest_Stats,'View','Population');
STRATA.createXMLStats(bestnonglbstats,'Watchdog','BestNonGLB',watchdog.RunDate_build,'sudhir.kasavajjala@lexisnexis.com',zBestNonglb_Stats,'View','Population');
STRATA.createXMLStats(bestnonglbnoneqstats,'Watchdog','BestNonGLBNonEQ',watchdog.RunDate_build,'sudhir.kasavajjala@lexisnexis.com',zBestNonglbNonEQ_Stats,'View','Population');
STRATA.createXMLStats(bestnoneqstats,'Watchdog','BestNonEq',watchdog.RunDate_build,'sudhir.kasavajjala@lexisnexis.com',zBestNonEQ_Stats,'View','Population');
STRATA.createXMLStats(bestnoneneqstats,'Watchdog','BestNonEqNonEN',watchdog.RunDate_build,'sudhir.kasavajjala@lexisnexis.com',zBestNonEQEN_Stats,'View','Population');
STRATA.createXMLStats(bestnonen,'Watchdog','BestNonEN',watchdog.RunDate_build,'sudhir.kasavajjala@lexisnexis.com',zBestNonEN_Stats,'View','Population');
STRATA.createXMLStats(bestnonglbutil,'Watchdog','BestNonGLBNonUtil',watchdog.RunDate_build,'sudhir.kasavajjala@lexisnexis.com',zBestNonGLBNonUtil_Stats,'View','Population');
STRATA.createXMLStats(bestnonutil,'Watchdog','BestNonUtil',watchdog.RunDate_build,'sudhir.kasavajjala@lexisnexis.com',zBestNonUtil_Stats,'View','Population');
STRATA.createXMLStats(supplemental,'Watchdog','BestSupplemental',watchdog.RunDate_build,'sudhir.kasavajjala@lexisnexis.com',zSupplemental_Stats,'View','Population');
STRATA.createXMLStats(mkbest,'Watchdog','MarketingBest',watchdog.RunDate_build,'sudhir.kasavajjala@lexisnexis.com',zMkBest_Stats,'View','Population');
STRATA.createXMLStats(mkNonEQbest,'Watchdog','MarketingNonEQBest',watchdog.RunDate_build,'sudhir.kasavajjala@lexisnexis.com',zMkBestNonEQ_Stats,'View','Population');
STRATA.createXMLStats(bestfcrastats,'Watchdog','BestFCRA',watchdog.RunDate_build,'sudhir.kasavajjala@lexisnexis.com',zBestFCRA_Stats,'View','Population');
STRATA.createXMLStats(bestfcranonen,'Watchdog','BestFCRANonEN',watchdog.RunDate_build,'sudhir.kasavajjala@lexisnexis.com',zBestFCRAnonEN_Stats,'View','Population');
STRATA.createXMLStats(bestfcranoneq,'Watchdog','BestFCRANonEQ',watchdog.RunDate_build,'sudhir.kasavajjala@lexisnexis.com',zBestFCRAnonEQ_Stats,'View','Population');

//Output the stats
b := output(watchdog.Stats1_best_x_date, named('Best_Stats'));

//Validate the stats

e := if ( var2 <> 'marketing',Watchdog.valid_counts(var2).out_all);

//output count
c := output(count(watchdog.BestJoined(isnewheader,build_type)),named('Total_DIDs'));

//output sample changes

d := watchdog.BestSampleChanges;

//validate LF generation


stored_wu := record
string wtype := '';
string WUID := '';
end;

ds := dataset( '~thor::wdog::wuinfo::'+var2,stored_wu,thor);
dout := if ( nothor( STD.File.fileexists( '~thor::wdog::wuinfo::'+var2 )), 
                 ds + dataset( [ { var2,workunit}],stored_wu ),
								  dataset( [ { var2,workunit}],stored_wu ) 
								 );
//modified code to fix using father
dout_all :=  Sequential(output( dout ,,'~thor::wdog::wuinfo::'+var2+'::'+workunit[2..9] ,overwrite),									                                                   
										   if (~(STD.File.Fileexists ( '~thor::wdog::wuinfo::'+var2)),STD.File.createsuperfile(  '~thor::wdog::wuinfo::'+var2)),
										   if (~( STD.File.Fileexists ( '~thor::wdog::wuinfo::'+var2+'_father')),STD.File.createsuperfile(  '~thor::wdog::wuinfo::'+var2+'_father')),																				 
											 STD.File.StartSuperFileTransaction(),	
											 STD.File.RemoveOwnedSubFiles( '~thor::wdog::wuinfo::'+var2+'_father'),
										   STD.File.AddSuperfile('~thor::wdog::wuinfo::'+var2+'_father','~thor::wdog::wuinfo::'+var2,addcontents := true), 
										   STD.File.RemoveOwnedSubFiles(  '~thor::wdog::wuinfo::'+var2),
									     STD.File.AddSuperfile('~thor::wdog::wuinfo::'+var2  , '~thor::wdog::wuinfo::'+var2+'::'+workunit[2..9]),
											 STD.File.FinishSuperFileTransaction()
									);
send_bad_email := STD.System.Email.SendEmail('michael.gould@lexisnexisrisk.com,sudhir.kasavajjala@lexisnexis.com','Watchdog '+ var1 + ' Build Failed',workunit);
  	
 result:= sequential(if(build_type ='fcra_best_append', 
                     map(var1 = 'fcra_best_append' => Sequential(
										 FCRA_list.Inputs_Clear,
										 FCRA_list.Inputs_set,
                     FCRA_list_base,
										 twelve,
										 despray_FCRAbest,
										 zBestFCRA_Stats,
										 notify('WATCHDOG FCRA BEST BUILD COMPLETE','*')),
										 var1 = 'fcra_best_nonEN' => Sequential(
										 thirteen,
										 zBestFCRAnonEN_Stats,
										 notify('WATCHDOG FCRA BEST NONEN BUILD COMPLETE','*')),
										 var1 = 'fcra_best_nonEQ' => Sequential(
										 fourteen,
										 zBestFCRAnonEQ_Stats,
										 notify('WATCHDOG FCRA BEST NONEQ BUILD COMPLETE','*'))
                     ,fail('Bad watchtype provided. Check for a Typo or bad build_type value (is this an nFCRA build?)')),
                     sequential(
                     prep_header
										,prep_infutor
										,prep_infutor_narc
										,c
										,e
										,map(	var1='nonglb'             => Sequential(two,zBestNonglb_Stats,notify('WATCHDOG NONGLB BASE BUILD COMPLETE','*'))
													,var1='nonglb_noneq'			=> Sequential(twoDotOne,zBestNonglbNonEQ_Stats,notify('WATCHDOG NONGLB NONEQ BASE BUILD COMPLETE','*'))
													,var1='nonutility'        => Sequential(three,zBestNonUtil_Stats,notify('WATCHDOG GLB NONUTILITY BASE BUILD COMPLETE','*'))
													,var1='nonglb_nonutility' => Sequential(four,zBestNonGLBNonUtil_Stats,notify('WATCHDOG NONGLB NONUTILITY BASE BUILD COMPLETE','*'))
												  ,var1='marketing'         => Sequential(five,zMkBest_Stats)
													,var1='marketing_noneq'   => Sequential(fiveDotOne,zMkBestNonEQ_Stats,notify('WATCHDOG MARKETING NONEQ BUILD COMPLETE','*'))
													,var1='compid'            => six
													,var1='compid_weekly'     => six_weekly
													,var1='glb_noneq'         => Sequential(seven,zBestNonEQ_Stats,notify('WATCHDOG GLB NONEQ BASE BUILD COMPLETE','*'))
													,var1='glb_nonen'         => Sequential(eight,zBestNonEN_Stats,notify('WATCHDOG GLB NONEN BASE BUILD COMPLETE','*'))
													,var1='glb_nonen_noneq'   => Sequential(ten,zBestNonEQEN_Stats,notify('WATCHDOG GLB NONEN NONEQ BASE BUILD COMPLETE','*'))
													,var1='supplemental'			=> Sequential(eleven,zSupplemental_Stats,notify('WATCHDOG SUPPLEMENTAL BASE BUILD COMPLETE','*'))
													,var1='glb'               => Sequential(one,zBest_Stats,notify('WATCHDOG GLB BASE BUILD COMPLETE','*'))
													,fail('Bad watchtype provided. Check for a Typo or bad build_type value (is this an FCRA build?)')
                          ),dout_all,	b,d))) : FAILURE(send_bad_email); 
											//		dout_all,	b,d) : FAILURE(send_bad_email);
return result; 

end; 
							
							
