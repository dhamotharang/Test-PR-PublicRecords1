
import ut;

#workunit('name','Yogurt:Watchdog-marketing enhance');

#stored ('watchtype', 'marketing'); 

//Get filedate from the watchdog check file
fd := dataset('~thor_data400::in::watchdog_check2',{string8 fdate},thor);
string8 filedate := fd[1].fdate : stored('filedate');


my_best_marketing_enhanced := watchdog.BestMarketingEnhanced;
my_layout := watchdog.Layout_Best;
//base_file_out := output(project(my_best_marketing_enhanced,my_layout));

outf:= output(project(my_best_marketing_enhanced,my_layout),,'~thor_data400::base::watchdog_best_marketing_enhanced_'+filedate,overwrite,compressed);

sf_cleanup := sequential(
			fileservices.startsuperfiletransaction(),
//			fileservices.clearsuperfile('~thor_data400::base::watchdog_best_marketing_father',false),
//			fileservices.addsuperfile  ('~thor_data400::base::watchdog_best_marketing_father','~thor_data400::base::watchdog_best_marketing',0,true),
			fileservices.clearsuperfile('~thor_data400::base::watchdog_best_marketing',true),
			fileservices.finishsuperfiletransaction(),
			fileservices.addsuperfile  ('~thor_data400::base::watchdog_best_marketing','~thor_data400::base::watchdog_best_marketing_enhanced_'+filedate),
	
			);	

send_bad_email := fileservices.SendEmail('skasavajjala@seisint.com','Watchdog-marketing Enhance FAILED','');
send_email := fileservices.SendEmail('skasavajjala@seisint.com','Watchdog-marketing Enhance FINISHED','');

export BWR_BestMarketingEnhanced := sequential(outf,sf_cleanup,send_email) : FAILURE(send_bad_email);
