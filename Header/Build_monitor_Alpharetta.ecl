IMPORT _control,ut,wk_ut,Data_Services,header;
EXPORT Build_monitor_Alpharetta(string emailList) := FUNCTION

// If you run every hour, then your are at most 1 hour late for reporting. (Once a day - max 24 hour delay) (avoid total time etc.)
aesp := _control.IPAddress.aprod_thor_esp;

w_s	:='W'+ut.date_math(workunit[2..9],-1)+'-000000';
w_e		:='W'+ut.date_math(workunit[2..9], 1)+'-000000';

gwl(string str) := wk_ut.get_WorkunitList(w_s,w_e,pJobname :=str ,pesp :=  aesp);

fList0 := gwl('Check for new Boca Header_Raw') 					// (Check for new Boca Header_Raw)
				+gwl('InsuranceHeader.proc_preprocess *_iter_*')// (InsuranceHeader PreProcess Build Completed (1-2))
				+gwl('InsuranceHeader.proc_salt *_iter_*') 		// (InsuranceHeader SALT Build Completed)
				+gwl('InsuranceHeader Linking Builds Master') 	// (InsuranceHeader Build Completed)
				+gwl('InsuranceHeader.proc_header * iter *') 	// (InsuranceHeader Build Completed)
				+gwl('SALT - Relative File') 					// (InsuranceHeader Relatives Build Completed)
				+gwl('InsuranceHeader.proc_stats 2*') 			// (InsuranceHeader HeaderStats Build Completed)
				+gwl('InsuranceHeader.proc_RidDidFile 2*') 		// (InsuranceHeader RID-DID File Build Completed)
				+gwl('Segmentation File Build') 				// (InsuranceHeader Segmentation Build Completed)
				// W20160107-160307	cfouts	InsuranceHeader.proc_fcra 201601
				+gwl('Prod xIDL Lab Build') 											// (InsuranceHeader ExternalLinking V2 Build Completed)
				;

o_fList0:=output(fList0,named('Alpha_list_all'));

fList := fList0(state = 'completed');
attachment:=header.mac_convert_ds.toHTML(fList0,wuid,cluster,owner,job,state);
o_fList:=output(fList,named('Alpha_list_completed'))
    :success(if(count(fList)>0,

                STD.System.Email.SendEmailAttachText(
				emailList,			                                        // recipientAddress
				'ATTENTION!! RECENT Alpharetta builds completed',  			// subjectText
				'See attachement and http://'+                              // bodyText
                    _Control.ThisEnvironment.ESP_IPAddress+':8010/?Wuid='+workunit
                    +'&Sequence=1&Widget=ResultWidget'
                    +' for details',
				attachment, 										// attachment
				'text/html',										// fileMimeType
				'alpharetta_recent_build_completed_report.html'  	// defaultFileName
                ))                   
);

llayout := {string date_time, string build_name, string version, string check_point, string wuid};

lgfl := dataset(Data_Services.foreign_prod+'thor_data400::log::PersonHeader_b',llayout,thor);
completedBuilds := lgfl(regexfind('PersonHeader Build Completed',check_point));
LatestNotCompletedVersion := max(lgfl(version not in set(completedBuilds,version)),version);
_version := LatestNotCompletedVersion;

#stored('buildName','PersonHeader');
#stored('version',_version);

lgflLocal := dataset('~thor_data400::log::PersonHeader',llayout,thor); // should be the same as lgfl. This line is for test/run in dataland

undocumentedFwuid := join(fList, lgflLocal, regexfind(LEFT.wuid,RIGHT.check_point)=TRUE, LEFT ONLY,ALL) :independent;
logs := project(undocumentedFwuid,transform({string check_point},SELF.check_point := 'Alpha:'+LEFT.wuid+' - '+LEFT.job));
documentFwuids := header.LogBuild.multi(logs);

return sequential(o_fList0,o_fList,output(undocumentedFwuid,named('new_completed_items')),documentFwuids);

END;;