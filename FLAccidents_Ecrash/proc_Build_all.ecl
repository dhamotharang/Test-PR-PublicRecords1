//ECrash Morning deployments
// The following flags to be set to Y
// isprodready is set to Y and Autopkg is set to Y only on Sunday.
import RoxieKeybuild,ut,orbit_report,Orbit3;
export Proc_Build_all(string filedate,string morning = 'no',string issunday = 'N'):= function 
updatedops := map(morning = 'yes' and issunday = 'N' => RoxieKeyBuild.updateversion('EcrashV2Keys',filedate,'skasavajjala@seisint.com',,'N',,'Y'),
                   morning = 'yes' and issunday = 'Y' => RoxieKeyBuild.updateversion('EcrashV2Keys',filedate,'skasavajjala@seisint.com; BocaRoxiePackageTeam@lexisnexis.com','Y','N',,'Y'),
									 Sequential(RoxieKeyBuild.updateversion('EcrashV2Keys',filedate,'skasavajjala@seisint.com',,'N'),RoxieKeyBuild.updateversion('EcrashCruDeltaKeys',filedate,'skasavajjala@seisint.com',,'N',,,'A')));



Email_list := 'Sai.Nagula@lexisnexis.com; hari.velappan@lexisnexis.com; Sudhir.Kasavajjala@lexisnexis.com';

Spray_ECrash := Sequential(FLAccidents_Ecrash.Spray_In(false)/*, FLAccidents_Ecrash.Spray_In_Iyetek(false)*/): success( Sequential(FileServices.sendemail('DataReceiving@lexisnexis.com; sudhir.kasavajjala@lexisnexis.com; john.freibaum@lexisnexis','ECrash File Status' + filedate, 'Please archive ECrash files on LZ /super_credit/ecrash/build/'+ filedate))), failure(FileServices.sendemail(Email_list, '	ECrash Spray failure', failmessage));

orbit_report.facc_Stats(getretval); 

string timestamp := ut.gettime() : independent;

verify_dops := if ( count(Sample_data.agency_data) <> 0, updatedops,Output('No_DopsUpdate_As_EA_Updates_Not_Processed'));

orbit_date := (integer) filedate[1..8];

create_build := map ( 

                  ut.Weekday(orbit_date)  = 'SUNDAY'   and morning = 'yes' =>  Orbit3.proc_Orbit3_CreateBuild ( 'Accident Reports - ECrashV2 National',filedate),
									ut.Weekday(orbit_date)  = 'FRIDAY'   and morning = 'no' =>  Orbit3.proc_Orbit3_CreateBuild ( 'Accident Reports - ECrashV2 National',filedate), 

									ut.Weekday(orbit_date)  in [ 'MONDAY','TUESDAY','WEDNESDAY','THURSDAY']  =>  Orbit3.proc_Orbit3_CreateBuild_AddItem ( 'Accident Reports - ECrashV2 National',filedate), 
									

									Output('No_Orbit_Entry_needed')
								);

create_build_ins := if ( ut.Weekday(orbit_date) not in ['SATURDAY','SUNDAY'] and   morning = 'no' , FLAccidents_Ecrash.Proc_Orbit3I_CreateBuild ('eCrashCRUAcidentsDelta', filedate ) ,Output('No_Orbit_Entry_needed') );

crudateds := dataset('~thor_data400::out::ecrash_spversion',{string10	processdate},thor);

string10 spversion := crudateds[1].processdate;

alpha_dependent := sequential( 
                    FLAccidents_Ecrash.ConcatInput
									  ,fn_ValidIn(false)
			              ,Spray_ECrash
			              ,FLAccidents_Ecrash.fn_Agency_DE
		                ,FLAccidents_Ecrash.map_basefile(filedate)
										) : failure ( if ( trim(spversion) <> trim(filedate), fileservices.sendemail(
													                                                      Email_Notification_Lists.NOC,
													                                                       '***ALERT*** ECRASH BUILD FAILURE , ENV: BOCA PROD, BUILD_DATE : '+filedate,
													                                                      email_msg.NOC_MSG
																			                                          ),
																																								
																																	fileservices.sendemail(
													                                                      Email_Notification_Lists.buildsuccess,
													                                                       'ECRASH BUILD , ENV: BOCA PROD, BUILD_DATE : '+filedate,
													                                                      'ECRASH CRU Build Triggered For Build Date: '+filedate+'.All Base files completed and so Please comment out alpha_dependent part in the build process'
																			                                          ) 
																								
																	));
																	
orbit_report.areport_Stats(nationalgetretval);

build_key := sequential(
			 FLAccidents_Ecrash.fn_Inputstats.sentemail
			,FLAccidents_Ecrash.proc_build_EcrashV2_keys(filedate)
			,verify_dops
			,create_build
			,create_build_ins
			,FLAccidents_Ecrash.Sample_data.qa
		  ,FLAccidents_Ecrash.strata(filedate)
			,FLAccidents_Ecrash.Prod_Superid_Change_extract(filedate) 
			,FLAccidents_Ecrash.Proc_TMafterTF_extract(filedate,timestamp)
			,FLAccidents_Ecrash.proc_build_dupe_extract(filedate,timestamp)
			,FLAccidents_Ecrash.Proc_build_Accident_watch(filedate,timestamp)
			,FLAccidents_Ecrash.InFilesList
			,getretval
			,nationalgetretval) : success(Send_Email(filedate,'V2').buildsuccess), failure(Send_Email(filedate,'V1').buildfailure);

return if (ut.Weekday(orbit_date)  in [  'SATURDAY','SUNDAY' ]    and morning = 'no' ,Spray_ECrash, Sequential(alpha_dependent, build_key));

end;	
