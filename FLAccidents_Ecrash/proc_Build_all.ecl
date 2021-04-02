//ECrash Morning deployments
// The following flags to be set to Y
//Morning = Auto Pckg deployment
// isprodready is set to Y and Autopkg is set to Y only on Sunday.
// FLAccidents_Ecrash.proc_Build_all('20200830','no','Y'); //Sunday Morning
// FLAccidents_Ecrash.proc_Build_all('20200830b','yes','N'); //Sunday Evening
// FLAccidents_Ecrash.proc_Build_all('20200829','no','N'); //Saturday Morning
// FLAccidents_Ecrash.proc_Build_all('20200829b','yes','Y'); //Saturday Evening
// FLAccidents_Ecrash.proc_Build_all('20200902','no','N');//Weekday Morning
// FLAccidents_Ecrash.proc_Build_all('20200902b','yes','N'); //Weekday Evening
import ut,orbit_report,Orbit3,Orbit3Insurance,dops;
export Proc_Build_all(string filedate,string morning = 'no',string issunday = 'N'):= function 

//Ecrash Auto pckg deployment
prEmailList := 'Sudhir.Kasavajjala@lexisnexis.com, DataDevelopment-InsRiskeCrash@lexisnexisrisk.com'; 
//Ecrash(Bankruptcy packages) Auto pckg deployment
prSundayEmailList := 'Sudhir.Kasavajjala@lexisnexis.com, BocaRoxiePackageTeam@lexisnexis.com,  DataDevelopment-InsRiskeCrash@lexisnexisrisk.com';
//Insurance Auto pckg deployment 
insEmailList := 'Sudhir.Kasavajjala@lexisnexis.com, alp-qadata.team@lexisnexis.com, InsDataOps@risk.lexisnexis.com, DataDevelopment-InsRiskeCrash@lexisnexisrisk.com';

prAutoProdEcrashV2DopsUpd := dops.updateversion('EcrashV2Keys',filedate,prEmailList,,'N',,'Y');
prAutoSundayProdEcrashV2DopsUpd := dops.updateversion('EcrashV2Keys',filedate,prSundayEmailList,'Y','N',,'Y');
prProdEcrashV2DopsUpd := dops.updateversion('EcrashV2Keys',filedate,prEmailList,,'N');
									 
insProdEcrashCruDeltaDopsUpd := dops.updateversion('EcrashCruDeltaKeys',filedate,insEmailList,,'N',,,'A'); 

//Insurance EcrashV2Keys will be auto prod early October 2020
//From now to October 2020 it will regular Prod package
//insAutoProdEcrashV2DopsUpd := dops.updateversion('EcrashV2Keys',filedate,insEmailList,,'N',,'Y','A');
insProdEcrashV2DopsUpd := dops.updateversion('EcrashV2Keys',filedate,insEmailList,,'N',,,'A');
		
updatedops := map(morning = 'yes' and issunday = 'N' => sequential(prAutoProdEcrashV2DopsUpd, insProdEcrashV2DopsUpd),
                  morning = 'yes' and issunday = 'Y' => sequential(prAutoSundayProdEcrashV2DopsUpd, insProdEcrashV2DopsUpd),
									Sequential(prProdEcrashV2DopsUpd, insProdEcrashV2DopsUpd, insProdEcrashCruDeltaDopsUpd));



Email_list := 'Sai.Nagula@lexisnexis.com, Sudhir.Kasavajjala@lexisnexis.com, DataDevelopment-InsRiskeCrash@lexisnexisrisk.com';

Spray_ECrash := Sequential(Spray_In(false)/*, Spray_In_Iyetek(false)*/): success( Sequential(FileServices.sendemail('DataReceiving@lexisnexis.com, sudhir.kasavajjala@lexisnexis.com, DataDevelopment-InsRiskeCrash@lexisnexisrisk.com','ECrash File Status' + filedate, 'Please archive ECrash files on LZ /super_credit/ecrash/build/'+ filedate))), failure(FileServices.sendemail(Email_list, '	ECrash Spray failure', failmessage));

orbit_report.facc_Stats(getretval); 

string timestamp := mod_Utilities.StrSysSeconds : independent;

//Orbit Create Build for PR eCrashV2Keys, Insurance EcrashCruDeltaKeys & Insurance eCrashV2Keys
orbit_date := (integer) filedate[1..8];
prOrbitCreateBuild := map(ut.Weekday(orbit_date) = 'SUNDAY' and morning = 'yes' =>  Orbit3.proc_Orbit3_CreateBuild ( 'Accident Reports - ECrashV2 National',filedate),
									        ut.Weekday(orbit_date) = 'FRIDAY' and morning = 'no' =>  Orbit3.proc_Orbit3_CreateBuild ( 'Accident Reports - ECrashV2 National',filedate), 
									        ut.Weekday(orbit_date)  in [ 'MONDAY','TUESDAY','WEDNESDAY','THURSDAY']  =>  Orbit3.proc_Orbit3_CreateBuild_AddItem ( 'Accident Reports - ECrashV2 National',filedate), 
									        output('No_Orbit_Entry_needed_PREcrashV2')
								         );												 
insOrbitCreateBuildEcrashCruDelta := if(ut.Weekday(orbit_date) not in ['SATURDAY','SUNDAY'] and morning = 'no', 
                                        Orbit3Insurance.Proc_Orbit3I_CreateBuild ('eCrashCRUAcidentsDelta', filedate),
																				output('No_Orbit_Entry_needed_InsEcrashCruDelta'));
insOrbitCreateBuildEcrashV2 := map(
                                   morning = 'yes' and issunday = 'N' => Orbit3Insurance.Proc_Orbit3I_CreateBuild ('eCrashV2Keys', filedate),
                                   morning = 'yes' and issunday = 'Y' => Orbit3Insurance.Proc_Orbit3I_CreateBuild ('eCrashV2Keys', filedate),
                                   Orbit3Insurance.Proc_Orbit3I_CreateBuild ('eCrashV2Keys', filedate)
																	 );
OrbitCreateBuild := sequential(
                               prOrbitCreateBuild,
															 insOrbitCreateBuildEcrashCruDelta,
															 insOrbitCreateBuildEcrashV2
															 );

crudateds := dataset('~thor_data400::out::ecrash_spversion',{string10	processdate},thor);

string10 spversion := crudateds[1].processdate;

alpha_dependent := sequential( 
	 ConcatInput
	,fn_ValidIn(false)
	,Spray_ECrash,  
	CreateSuperFiles, 
	proc_build_base(filedate)
	): failure ( if ( trim(spversion) <> trim(filedate), fileservices.sendemail(
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
	 fn_Inputstats.sentemail
	,proc_build_EcrashV2_keys(filedate)
	,updatedops
	,OrbitCreateBuild
	,Sample_data.qa
	,strata(filedate)
	,proc_build_dupe_extract(filedate,timestamp)
	,InFilesList
	,getretval
	,nationalgetretval) : success(Send_Email(filedate,'V2').buildsuccess), failure(Send_Email(filedate,'V1').buildfailure);


return if (ut.Weekday(orbit_date)  in [  'SATURDAY','SUNDAY' ]    and morning = 'no' ,Spray_ECrash, Sequential(alpha_dependent, build_key));
end;	
