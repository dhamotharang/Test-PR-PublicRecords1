// Runs daily 2:30PM 
import STD ; 

#WORKUNIT('name','UT/C++ Monitoring Process');

pversion := (string) std.date.CurrentDate() ; 

Sequential ( CodeMonitoring.Proc_MonitorAttributes_C (pversion), 
             CodeMonitoring.Proc_MonitorAttributes_UT(pversion),
						 CodeMonitoring.Proc_Monitor_LinkingTools(pversion),
						 CodeMonitoring.Proc_Monitor_wk_ut(pversion))  :  WHEN(CRON('30 19 * * *')),
						 FAILURE(FileServices.SendEmail( 'Ayeesha.Kayttala@lexisnexis.com','Monitoring Process failed','The failed workunit is:' + workunit + FailMessage));
             
