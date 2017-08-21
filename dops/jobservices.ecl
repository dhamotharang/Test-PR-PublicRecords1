/*2012-03-05T14:17:20Z (Tamika Edman_Prod)

*/
import ut,lib_workunitservices,lib_fileservices;

export jobservices := module

	export jobinfo_layout := record
			string jname;
			string wuid;
			string state;
			string lastmodified;
			integer duration;
			string comments;
			string emailid;
	end;

	export gettimediff(string indatetime) := function
		string year := indatetime[1..4];
		string month := indatetime[6..7];
		string day := indatetime[9..10];
		integer hour := (integer)indatetime[12..13];
		integer mins := (integer)indatetime[15..16];
		integer secs := (integer)indatetime[18..19];
		string ltime := ut.now('%Y%m%d%H%M%S',true);
		string lyear := ltime[1..4];
		string lmonth := ltime[5..6];
		string lday := ltime[7..8];
		integer lhour := (integer)ltime[9..10];
		integer lmins := (integer)ltime[11..12];
		integer lsecs := (integer)ltime[13..14];
		
		return ((ut.DaysSince1900(lyear,lmonth,lday) + (((lhour*60) + lmins)/1440)) - (ut.DaysSince1900(year,month,day) + (((hour*60) + mins)/1440))) * 24 * 60 * 60;
		
	end;

	export getjoblist(string lwuid = '',string hwuid = '') := function

		new_layout := record
			string jname;
			dataset(WsWorkunitRecord) wds;
		end;

		norm_layout := record
			string jname;
			WsWorkunitRecord;
		end;

		jobds := dops.monitor_jobs.add_jobs_to_monitor;

		wuds := lib_workunitservices.WorkunitServices.workunitlist(lowwuid := lwuid,highwuid := hwuid) : independent;

		newds := project(jobds,transform(new_layout,self.wds := wuds(regexfind(left.jname,job) and state in ['running','completed','aborting','aborted','blocked','scheduled','wait']);self := left));

		norm_layout norm_recs(newds l,WsWorkunitRecord r) := transform
			self.jname := l.jname;
			self := r;
		end;

		normds := normalize(newds,left.wds,norm_recs(left,right));

		return normds;

	end;
	
	export getjobsinfo(string lwuid = '',string hwuid = '') := function
		
		joblist := getjoblist();
		
		jobinfods := dataset('~thor::jobs::info::first',jobinfo_layout,thor,opt);
		
		fulljobslist := getjoblist(lwuid,hwuid);
		
		jobinfo_layout get_status_duration(fulljobslist l,jobinfods r) := transform
			string setthold := dops.monitor_jobs.add_jobs_to_monitor(jname = l.jname)[1].thresholdval;
									
			integer getthold := (integer)setthold * 60;
			integer getdiff := if(l.state not in ['completed','wait','scheduled','aborted','aborting','failed'],gettimediff(l.modified),0);
			self.jname := l.jname;
			self.wuid := l.wuid;
			self.state := l.state;
			self.duration := getdiff;
			self.lastmodified := l.modified;
			self.comments := if (setthold <> '0',
								//threshold comment
								if ( getdiff > getthold and l.state = r.state and l.state not in ['completed','wait','scheduled','aborted','aborting','failed'],
										l.jname + ' is in ' + l.state + ' state for longer than ' + setthold + ' mins. Please check ' + l.wuid,
												if(l.state <> r.state and l.state in ['aborted','aborting','failed'],
												l.jname + ' ' + ' was aborted or failed. Check WU ' + l.wuid,
												'')),
								// job finished
								if ( l.state <> r.state and l.state = 'completed' and r.state <> '',
									l.jname + ' completed, add to package file',
									'')
								);
			self.emailid := dops.monitor_jobs.add_jobs_to_monitor(jname = l.jname)[1].emaillist;
		end;
		
		getnewstatus := join(fulljobslist,jobinfods,left.wuid = right.wuid,
									get_status_duration(left,right),
									left outer);
		
		return getnewstatus;
		
	end;
	
	export send_alert_emails(string lwuid = '',string hwuid = '') := function
		// jobinfods := dataset('~thor::jobs::info',jobinfo_layout,thor,opt);
		jobinfods := dataset('~thor::jobs::info::first',jobinfo_layout,thor,opt);
		jobinfodssec := dataset('~thor::jobs::info::second',jobinfo_layout,thor);
		return sequential(
					// output(getjobsinfo(lwuid,hwuid),,'~thor::jobs::info::monitor_'+datetime,overwrite),
					//output(getjobsinfo(lwuid,hwuid),,'~thor::jobs::info::second',overwrite)//,
					output(getjobsinfo(lwuid,hwuid),,'~thor::jobs::info::second',overwrite),
					/*if (~fileservices.superfileexists('~thor::jobs::info'),
						fileservices.createsuperfile('~thor::jobs::info')
					),
					fileservices.clearsuperfile('~thor::jobs::info',true),*/
					// fileservices.addsuperfile('~thor::jobs::info','~thor::jobs::info::monitor_'+datetime),
					output(jobinfodssec,,'~thor::jobs::info::first',overwrite),
					apply(jobinfods(comments <> '' and emailid <> ''),
						fileservices.sendemail(
												emailid,
												'ALERT: '+jname+':'+wuid,
												comments
										)
						)
						);
		
	end;
	
end;