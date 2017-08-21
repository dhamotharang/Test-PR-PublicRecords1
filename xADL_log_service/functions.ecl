import ut,doxie,lib_fileservices;

shared ly := xADL_log_service.layouts;

//****** create log file when hitting xADL 

mywuid     := EVENTEXTRA('wuid') : GLOBAL;
myjobname  := EVENTEXTRA('jobname') : GLOBAL;
myjobowner := EVENTEXTRA('jobowner') : GLOBAL;
myplatform := EVENTEXTRA('platform') : GLOBAL;
mycluster  := EVENTEXTRA('cluster') : GLOBAL;	
mystart    := EVENTEXTRA('start') : GLOBAL;
mystop     := EVENTEXTRA('stop') : GLOBAL;
mycount    := EVENTEXTRA('count') : GLOBAL;
myDIDcount := EVENTEXTRA('DIDcount') : GLOBAL;
mythreshold := EVENTEXTRA('threshold') : GLOBAL;
mymatchset := EVENTEXTRA('matchset') : GLOBAL;
myADLroute := EVENTEXTRA('ADLroute') : GLOBAL;

myextra    := EVENTEXTRA : GLOBAL;

//get info by using workunitservices

wu_messages  := WorkunitServices.WorkunitMessages(mywuid);
wu_filesread := WorkunitServices.WorkunitFilesRead(mywuid);
wu_timings  := WorkunitServices.WorkunitTimings(mywuid);

filesread_name := wu_filesread(regexfind('base::hss_name_address_w|base::hss_name_ssn_w',name))[1].name;

ly.rec_log   tRecord(ly.rec_log pInput)       :=

       transform

              self.wuid        :=     mywuid;
			  self.cluster     :=     mycluster;
		      self.platform    :=     myplatform;
		      self.jobname     :=     myjobname;
		      self.jobowner    :=     myjobowner;
			  self.start_time  :=     mystart;
			  self.stop_time   :=     mystop;
			  self.thor_time   :=    if((unsigned)mystop > 0, (decimal8_5)(((unsigned)mystop - (unsigned)mystart)/1000/60/60), 0);
			  self.total_count :=    (unsigned)mycount;
			  self.DID_count   :=    (unsigned)myDIDcount;
			  self.low_score_threshold := (unsigned)mythreshold;
			  self.matchset     :=     mymatchset;	  
			  self.throughput   :=   (decimal10_3)((unsigned)mycount/1000000/self.thor_time);
			  self.ECL_version  :=  if(count(wu_messages(location in ['DID_Add.MAC_Match_Flex', 'DID_Add.Mac_Match_Fast_Roxie'])) >= 1, 1.0, 0);
		      self.xadl_version :=  filesread_name[StringLib.StringFind(filesread_name,'_w',1) + 2..];
			  self.total_thor_time := (decimal8_5)(wu_timings(name = 'Total thor time')[1].duration/1000/60/60);
              self.ADL_route   := myADLroute;
			  end;
f_log   :=   project(dataset([{''}], ly.rec_log), trecord(left));

ly.base_log   tRecordchild(ly.rec_log pInput)       :=

       transform

             
			 self.WUfilesRead := project(wu_filesRead, ly.rec_WU_filesread);
		     self.WUMessages  := project(wu_messages, ly.rec_WU_messages);
          	 self.WUTimings   := project(wu_timings(name = 'Total thor time' or name = 'EclServer: total time')
			 , ly.rec_WU_timings);

			 self := pInput;
			  end;
f_log_base   :=   project(f_log, trecordchild(left));

//******** move log files to QA
move_toQA := xADL_log_service.proc_move_files_toQA(mywuid).WriteMoveQA(f_log_base);

//******** send email notice when build complete
send_success_msg := xADL_log_service.email_notification_lists(myjobname, mywuid).build_complete;

export FUNCTIONS := 
parallel(
	
output(mywuid, named('mywuid')),
output(myjobname, named('myjobname')),
output(myjobowner, named('myjobowner')),
output(myplatform, named('myplatform')),
output(mycluster, named('mycluster')),
output(mystart, named('mystart')),
output(mystop, named('mystop')),
output(mycount, named('totalcount')),
output(myDIDcount, named('DIDcount')),
output(mythreshold, named('mythreshold')),
output(mymatchset, named('mymatchset')),
output(myADLroute, named('myADLroute')),
output(myextra, named('myEvent')),
OUTPUT(WorkunitServices.WorkunitTimings(mywuid ), named('WorkunitTimings')),
OUTPUT(WorkunitServices.WorkunitTimeStamps(mywuid ), named('WorkunitTimeStamps')),
OUTPUT(WorkunitServices.WorkunitMessages(mywuid ), named('WorkunitMessages')),
OUTPUT(WorkunitServices.WorkunitFilesRead(mywuid ), named('WorkunitFilesRead')),
OUTPUT(WorkunitServices.WorkunitFilesWritten(mywuid ), named('WorkunitFilesWritten')),
move_toQA,
send_success_msg);
FUNCTIONS : WHEN('xADLlogger');

