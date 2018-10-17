export Mac_BK_Daily_Spray(Mainfile,Searchfile,filedate,group_name ='\'thor_dell400\'',email_target='\' \'') := 
macro
import Bankruptcyv2,_Control;
#uniquename(spray_main)
#uniquename(spray_search)
#uniquename(super_main)
#uniquename(super_search)
#uniquename(recordsizeMain)
#uniquename(recordsizeSearch)
#uniquename(build_bk_keys)
#uniquename(sourceIP)

#workunit('name','Yogurt:Bankruptcy FCRA Key Build '+filedate);
/*
%recordsizeMain% :=1533;
%recordsizeSearch% :=478;
%sourceIP% := _control.IPAddress.edata12;

%spray_main% := FileServices.SprayFixed(%sourceIP%,Mainfile, %recordsizeMain%,group_name,'~thor_data400::in::bk_main_'+filedate ,-1,,,true,true);
%spray_search% := FileServices.SprayFixed(%sourceIP%,searchfile,%recordsizeSearch%,group_name,'~thor_data400::in::bk_search_'+filedate ,-1,,,true,true);
%super_main% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile('~thor_data400::base::bankrupt_Main_Delete','~thor_data400::base::bankrupt_main_father',, true),
				FileServices.ClearSuperFile('~thor_data400::base::bankrupt_main_father'),
				FileServices.AddSuperFile('~thor_data400::base::bankrupt_main_father', '~thor_data400::base::bankrupt_main',, true),
				FileServices.ClearSuperFile('~thor_data400::base::bankrupt_main'),
				FileServices.AddSuperFile('~thor_data400::base::bankrupt_main', '~thor_data400::in::bk_main_'+filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_data400::base::bankrupt_main_delete',true));

%super_search% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile('~thor_data400::base::bankrupt_search_Delete','~thor_data400::base::bankrupt_search_father',, true),
				FileServices.ClearSuperFile('~thor_data400::base::bankrupt_search_father'),
				FileServices.AddSuperFile('~thor_data400::base::bankrupt_search_father', '~thor_data400::base::bankrupt_search',, true),
				FileServices.ClearSuperFile('~thor_data400::base::bankrupt_search'),
				FileServices.AddSuperFile('~thor_data400::base::bankrupt_search', '~thor_data400::in::bk_search_'+filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_data400::base::bankrupt_search_delete',true));

bankrupt.proc_build_key(filedate,%build_bk_keys%);

#uniquename(send_succ_msg)
#uniquename(send_fail_msg)

RoxieKeyBuild.Mac_Daily_Email_Local('BK','SUCC', filedate, %send_succ_msg%,if(email_target<>' ',email_target,Bankrupt.Spray_Notification_Email_Address));
RoxieKeyBuild.Mac_Daily_Email_Local('BK','FAIL', filedate, %send_fail_msg%,if(email_target<>' ',email_target,'cpettola@seisint.com;cbrodeur@seisint.com'));

STRATA.CreateAsHeaderStats(Bankrupt.BK_as_Header(BankruptcyV2.file_bankruptcy_search_v3,BankruptcyV2.file_bankruptcy_main_v3),
                           'Bankruptcy',
					       'data',
					       filedate,
					       '',
                           zAsHeaderStats
                          );
						  
STRATA.CreateAsBusinessHeaderStats(Bankrupt.fBankrupt_As_Business_Header(Bankrupt.file_bk_search,Bankrupt.File_BK_Main),
                                   'Bankruptcy',
					               'data',
					               filedate,
					               '',
                                   zAsBusinessHeaderStats
                                  );

Bankrupt.Out_Population_Stats(Bankrupt.File_BK_Search,Bankrupt.File_BK_Main,filedate,zPopulationStats)

*/
sequential(/*parallel(%spray_main%,%spray_search%),parallel(%super_main%,%super_search%),*/
		//parallel(%build_bk_keys%,Bankruptcyv2.Proc_Build_FCRA_Keys(filedate)),
		Bankruptcyv2.Proc_Build_FCRA_Keys(filedate),
		bankruptcyv2.Proc_Accept_FCRA_SK_To_QA,
		BankruptcyV3.Proc_FCRA_Field_Deprecation_Stats,			//DF-21108 show the non-blank or non-zero count of deprecated fields
		//Roxiekeybuild.updateversion('BankruptcyKeys',filedate,'avenkatachalam@seisint.com,cbrodeur@seisint.com'),

	
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//AUTOMATIC DOPS UPDATE PROCESS - DEACTIVATE WHEN RUNNING THE BUILD MANUALLY (i.e. LAYOUT CHANGES)	
		Roxiekeybuild.updateversion('FCRA_BankruptcyKeys',filedate,'avenkatachalam@seisint.com,christopher.brodeur@lexisnexis.com,manuel.tarectecan@lexisnexis.com,randy.reyes@lexisnexis.com,BocaRoxiePackageTeam@lexisnexis.com,intel357@bellsouth.net','Y','F',,'Y'),
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
		if(ut.Weekday((integer)filedate[1..8]) <> 'SATURDAY' and ut.Weekday((integer)filedate[1..8]) <> 'SUNDAY',
					 Orbit3.proc_Orbit3_CreateBuild('FCRA Bankruptcy',filedate,'F'),
					 output('No Orbit Entry Needed for weekend builds')),
		
		
		bankruptcyv2.daily_count_stats_for_banko('fcra',,true,true)
		//if (_Control.ThisEnvironment.Name = 'Dataland',output('Package Sent'),fileservices.sendemail('Roxiedeployment@seisint.com,QualityAssurance@seisint.com',
			//'Roxie Prod FCRA BK Package Files ' + ut.GetDate,
			//'FCRA BK Package link: http://rigel.br.seisint.com/~hozed/pkgfiles/bkfcraprodpkg.txt\n')),
			/*parallel(zPopulationStats,
					  zAsHeaderStats,
					  zAsBusinessHeaderStats
					 )*/
		   ) :  when(event('Yogurt:BANKRUPTCY BASE BUILD COMPLETE','*'),count(1));
           // success(%send_succ_msg%),
           // failure(%send_fail_msg%);

endmacro;