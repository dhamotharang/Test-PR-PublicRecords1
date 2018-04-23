IMPORT _control,ut,wk_ut,std;

bEsp := _control.IPAddress.prod_thor_esp;
aEsp := _control.IPAddress.aprod_thor_esp;

w_s	:='W'+ut.date_math(workunit[2..9],-730)+'-000000';
w_e	:='W'+ut.date_math(workunit[2..9], 1)+'-000000';

bGwl(string str) := wk_ut.get_WorkunitList(w_s,w_e,pJobname :=str ,pesp :=  bEsp);
aGwl(string str) := wk_ut.get_WorkunitList(w_s,w_e,pJobname :=str ,pesp :=  aEsp);

bJobIsScheduled(string job) := when(count(bGwl(job)(state='wait'))=1,output(bGwl(job),named('wuid_found'),extend));
aJobIsScheduled(string job) := when(count(aGwl(job)(state='wait'))=1,output(aGwl(job),named('wuid_found'),extend));

wLink := 'http://prod_esp.br.seisint.com:8010/?Wuid='+workunit+'&Widget=WUDetailsWidget#/stub/Summary';
noJobAlert(string emailList, string job) := fileservices.sendemail(emailList,'ERROR:Scheduled job: '+job,
													'Job not found in wait state, has more than 1 instance or is over 2 years old.\r\nSee: '+wLink);

GetTimeDate:=Std.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE), '%F%H%M%S%u');
bCheck_job(string emailList,string job ) := if(bJobIsScheduled(job),output(GetTimeDate+': '+job+' (FOUND)'),noJobAlert(job,emailList));
aCheck_job(string emailList,string job) := if(aJobIsScheduled(job),output(GetTimeDate+': '+job+' (FOUND)'),noJobAlert(job,emailList));

EXPORT build_monitor_scheduled_jobs(string emailList) := sequential(
					
			bCheck_job(emailList,'PersonHeader: Build_Header_raw'),
			bCheck_job(emailList,'PersonHeader: Create Raw Header Stats - on NOTIFY'),
			bCheck_job(emailList,'PersonHeader: Build_Header_base'),
			bCheck_job(emailList,'PersonHeader: Build_XADL'),
			bCheck_job(emailList,'PersonHeader: Build_Relatives'),
			bCheck_job(emailList,'PersonHeader: Build_Header_Keys'),
			bCheck_job(emailList,'PersonHeader: Finalize_Header_build'),
			bCheck_job(emailList,'PersonHeader: Build_FCRA_Header'),
			bCheck_job(emailList,'PersonHeader: Build_Header_boolean'),
            aCheck_job(emailList,'Boca.PersonHeader - Monitor copy from Boca')

);