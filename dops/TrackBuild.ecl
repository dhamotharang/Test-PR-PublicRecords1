﻿import STD, DOPS, _Control;
// p_vertical: 'P' = Public Records, 'I' = Insurance, 'H' = Health care
EXPORT TrackBuild(string p_vertical = 'P'
									,string p_location = dops.constants.location
									,string p_dopsenv = 'dev'
									,string p_wuid = '') := module

	////////////////////////////////////////////////////
	// DECLRATIONS & DEFINITIONS
	////////////////////////////////////////////////////
	
	// there is not alternative to clear an existing app value in WU
	// hence setting ignore values
	// add the filter in fTrackAndEmail and fConvertWUInfo
	export vsIgnoreDataset := ['PersonHeaderKeys'];
	export vsIgnoreComponent := ['KEY BUILD:MOVE'
																,'KEY BUILD:FCRA'
																,'KEY BUILD:BOOLEAN'];
	export vThresholdInSecs := 18000; // 5 hours (60 (secs) * 60 (mins) * 5)
	export vdopsurlprefix := 'http://uspr-buildtracking.risk.regn.net/';
	export FileTrackBuildPrefix := '~dops::trackbuild::';
	
	export applicationname := 'DOPS_'; // '_' is important to separate application with sequence
	
	export fromemail := 'bocaroxiepackageteam@lexisnexisrisk.com';
	export toemaillist := 'Anantha.Venkatachalam@lexisnexisrisk.com';
	
	export localesp := if ( regexfind('prod',_Control.ThisEnvironment.Name,nocase)
													,_Control.IPAddress.prod_thor_esp
													,_Control.IPAddress.dataland_esp);
												
	
	export FileInfoPrefix := FileTrackBuildPrefix + 'info';
	export FlagPrefix := FileTrackBuildPrefix + 'flag';
	
	export SP_FileTrackBuild(string FilePrefix) := FilePrefix +'::prod';
	export SU_FileTrackBuild(string FilePrefix) := FilePrefix +'::using';
	export SB_FileTrackBuild(string FilePrefix) := FilePrefix + '::backup';
	export SD_FileTrackBuild(string FilePrefix) := FilePrefix + '::delete';
	export LF_PrepforTracking(string FilePrefix) := FilePrefix + '::prepfortracking';
	export LF_EmailNotify(string FilePrefix) := FilePrefix + '::emailnotify';
	export LF_EmailResultstore(string FilePrefix) := FilePrefix + '::storeemailresult';
	export LF_PrepforTrackingResult(string FilePrefix) := FilePrefix + '::prepfortrackingresult';
	export LF_Errors(string FilePrefix) := FilePrefix + '::errors';
	
	export rTrackBuild := record
		string datasetname := '';
		string buildversion := '';
		string componentname := '';
		string wuid := '';
		string datetime := ''; // time when the info was first captured
		string vertical := ''; 
		string location := '';
		string created := ''; // time when WU was created
		string modified := ''; // time when WU was modified
		string jobstatus := '';
		string emailid := '';
		string thresholdinsecs := '';
		string reason := '';
		string wuerrors := '';

	end;
	
	export rAppInfo := record
		string wuid;
		string application;
		unsigned2 app_seq := 0;
		string seqs := '';
		string name;
		string value;
	end;
	
	/////////////////////////////////////////////////////
	// ESP functions
	/////////////////////////////////////////////////////
	export fGetAppDataFromWUDetails(
												string p_wuid
												,string p_esp = localesp
												,string p_port = '8010'
												) := function
		
		rWUInfoDetailsRequest := record
			string Wuid{xpath('Wuid')} := p_wuid;
		end;
		
		rWUResponseAppValues := record
			string Application{xpath('Application')};
			string Name{xpath('Name')};
			string Value{xpath('Value')};
		end;
		
		rWUInfoDetailsResponse := record
			string Wuid{xpath('Wuid')};
			dataset(rWUResponseAppValues) AppValues {xpath('ApplicationValues/ApplicationValue')};
		end;
		
		dWUInfoDetailsResponse := SOAPCALL('http://'+p_esp+':'+p_port+'/WsWorkunits'
											// 'http://10.176.152.60:4546/'
											,'WUInfoDetails'
											,rWUInfoDetailsRequest
											,dataset(rWUInfoDetailsResponse)
											,xpath('WUInfoResponse/Workunit')
											,LITERAL
										 );
		
		rGetAppData := record
			string wuid;
			dataset(rWUResponseAppValues) AppValues;
		end;
		
		rGetAppData xGetAppData(dWUInfoDetailsResponse l) := transform
			self := l;
		end;
		
		dGetAppData := project(dWUInfoDetailsResponse,xGetAppData(left));
		
		rAppInfo xNormKeyInfo(dGetAppData l, rWUResponseAppValues r) := transform
			self.wuid := l.wuid;
			self := r;
		end;

		dNormKeyInfo := normalize(dGetAppData,left.AppValues,xNormKeyInfo(left,right));
		
		rAppInfo xTokenizeAppInfo(dNormKeyInfo l) := transform
			self.app_seq := (unsigned2)STD.Str.SplitWords(l.application,'_')[2];
			self := l;
		end;
		
		dTokenizeAppInfo := project(dNormKeyInfo,xTokenizeAppInfo(left));
		
		return dTokenizeAppInfo;
		
	end;
	
	////////////////////////////////////////////////////
	// prep supers and remove the files if already in super
	////////////////////////////////////////////////////
	export fPrepSupers(string p_FileInfoPrefix) := function
		dLogicalOwners := STD.File.LogicalFileSuperOwners(p_FileInfoPrefix + '::' + WORKUNIT) : independent;
		
		return sequential
						(
							if (~STD.File.SuperFileExists(SD_FileTrackBuild(p_FileInfoPrefix))
										,STD.File.CreateSuperFile(SD_FileTrackBuild(p_FileInfoPrefix)))
							,if (~STD.File.SuperFileExists(SB_FileTrackBuild(p_FileInfoPrefix))
										,STD.File.CreateSuperFile(SB_FileTrackBuild(p_FileInfoPrefix)))
							,if (~STD.File.SuperFileExists(SP_FileTrackBuild(p_FileInfoPrefix))
										,STD.File.CreateSuperFile(SP_FileTrackBuild(p_FileInfoPrefix)))
							,if (~STD.File.SuperFileExists(SU_FileTrackBuild(p_FileInfoPrefix))
										,STD.File.CreateSuperFile(SU_FileTrackBuild(p_FileInfoPrefix)))
							,if( STD.File.FileExists(p_FileInfoPrefix + '::' + WORKUNIT)
									,if (count(dLogicalOwners) > 0
										,nothor(
											apply(
												global(dLogicalOwners,few)
													,STD.File.RemoveSuperFile('~'+name,p_FileInfoPrefix + '::' + WORKUNIT)
													)
												)
											)
										)
							);
									
	end;
	
	////////////////////////////////////////////////////
	// capture build information into a file
	// this function will be called by builds
	////////////////////////////////////////////////////
	export fSetInfo(string p_dopsdatasetname
									,string p_buildversion
									,string p_componentname
									// DUS-346: add email
									,string p_email = ''
									) := function
		// get WU state							
		
		dBuildInfo := dataset([{p_dopsdatasetname,p_buildversion,p_componentname
												,WORKUNIT,(string)STD.Date.Today() + (string)STD.Date.CurrentTime()
												,p_vertical,p_location
												,'','','',p_email}],rTrackBuild);
		
		return 	sequential
								(
									fPrepSupers(FileInfoPrefix)
									,output(dBuildInfo,,FileInfoPrefix + '::' + WORKUNIT,overwrite)
									
								);
						
		
	end;
	
	////////////////////////////////////////////////////
	// capture build information into WU details
	// this function will be called by builds in BWR
	////////////////////////////////////////////////////
	export fSetInfoinWorktunit(string p_dopsdatasetname
									,string p_buildversion
									,string p_componentname
									// DUS-346: add email
									,string p_email = ''
									) := function
	
		// isWorkunitExists := WORKUNIT in set(STD.System.Workunit.WorkunitList(appvalues := applicationname+'*/*=*'),wuid);
		
		seq_number := max(fGetAppDataFromWUDetails(WORKUNIT,localesp),app_seq)+1;
		app_value := p_dopsdatasetname+'|'+p_buildversion+'|'+p_componentname+'|'+(string)STD.Date.Today() + (string)STD.Date.CurrentTime()+'|'+p_vertical+'|'+p_location+'|'+p_email;
		return sequential(
										output('setting app value for '+app_value)
										,STD.System.Workunit.SetWorkunitAppValue(applicationname + (string)seq_number,'dopsmetrics',app_value)
										);
		
	end;
	
	////////////////////////////////////////////////////
	// Convert the information captured from WU into 
	// rTrackBuild layout
	////////////////////////////////////////////////////
	export fConvertWUInfo() := function
		dWUListWithAppInfo := if (p_wuid <> ''
															,STD.System.Workunit.WorkunitList(appvalues := applicationname+'*/*=*')(wuid = p_wuid)
															,STD.System.Workunit.WorkunitList(appvalues := applicationname+'*/*=*'));
		
		rChildRecord := record
			string wuid;
			dataset(rAppInfo) appinfo;
		end;
		
		rChildRecord xChildRecord(dWUListWithAppInfo l) := transform
			self.wuid := l.wuid;
			self.appinfo := fGetAppDataFromWUDetails(l.wuid);
		end;
		
		dChildRecord := project(dWUListWithAppInfo,xChildRecord(left));
		
		rTrackBuild xNormChildRecord(dChildRecord l, rAppInfo r) := transform
			self.datasetname := STD.Str.SplitWords(r.value,'|')[1];
			self.buildversion := STD.Str.SplitWords(r.value,'|')[2];
			self.componentname := STD.Str.SplitWords(r.value,'|')[3];
			self.wuid := r.wuid;
			self.datetime := STD.Str.SplitWords(r.value,'|')[4]; // time when the info was first captured
			self.vertical := STD.Str.SplitWords(r.value,'|')[5]; 
			self.location := STD.Str.SplitWords(r.value,'|')[6];
			self.emailid := STD.Str.SplitWords(r.value,'|')[7];
			self := l;
		end;
		
		dNormChildRecord := normalize(dChildRecord,left.appinfo,xNormChildRecord(left,right));
		
		return dNormChildRecord(~(datasetname in vsIgnoreDataset and componentname in vsIgnoreComponent));
		
	end;
	
	////////////////////////////////////////////////////
	// get the latest tracking info from prod super by default
	// but when tracking use, using super 
	////////////////////////////////////////////////////
	export dGetInfo(string TrackBuildFile = SP_FileTrackBuild(FileInfoPrefix)) 
																:= dataset(TrackBuildFile,rTrackBuild,thor,opt) + fConvertWUInfo()(vertical <> '' and location <> '' and datetime <> '');
	
	////////////////////////////////////////////////////
	// move all track logical files into "using" super
	////////////////////////////////////////////////////
	export fAddTrackFilesToSuper() := function
		dFileList := STD.File.LogicalFileList(regexreplace('~',FileInfoPrefix,'') + '*');
		return nothor(apply
						(
							global(dFileList,few)
							,if (count(STD.File.LogicalFileSuperOwners('~'+name)) = 0
									,sequential
											(
												STD.File.StartSuperFileTransaction()
												,STD.File.AddSuperFile(
														SU_FileTrackBuild(FileInfoPrefix)
														,'~'+name																		
																)
												,STD.File.FinishSuperFileTransaction()
											)
									)
						));
	end;
	
	////////////////////////////////////////////////////
	// Function to capture status and timestamp for each WU
	////////////////////////////////////////////////////
	export fGetWUStatus(string TrackBuildFile = SP_FileTrackBuild(FileInfoPrefix)
											,string p_esp = localesp
											,string p_port = '8010'
											) := function
			dInfo := sort(dGetInfo(TrackBuildFile),wuid);
			
			rTrackBuild xGetWUStatus(dInfo l) := transform
				wuidtofilter := if (p_wuid <> '', p_wuid, l.wuid);
				dWUInfo := STD.system.Workunit.WorkunitList(lowwuid := wuidtofilter, highwuid := wuidtofilter);
				dWUTimeStamps := sort(STD.system.Workunit.WorkunitTimeStamps(l.wuid),-time);
				vdate := l.datetime[1..8];
				vtime := l.datetime[9..];
				jobstate := STD.str.ToUpperCase(trim(dWUInfo[1].state,left,right));
				self.wuerrors := if (jobstate in  ['ABORTED','FAILED']
														,dops.WorkUnitModule(p_esp,p_port).GetWUErrors(l.wuid,true)[1].Message
														,'');
				self.jobstatus := jobstate;
				self.created := regexreplace('[-:TZ]',SORT(dWUTimeStamps(STD.Str.ToUpperCase(id) in ['CREATED','QUERYSTARTED']),time)[1].time,'',nocase);
				self.modified := regexreplace('[-:TZ]',dWUTimeStamps[1].time,'',nocase);
				self.datetime := vdate + intformat(STD.Date.Hour((integer)vtime),2,1)
																+ intformat(STD.Date.Minute((integer)vtime),2,1)
																+ intformat(STD.Date.Second((integer)vtime),2,1);
				self := l;
			end;
			
			dGetWUStatus := project(dInfo,xGetWUStatus(left));
			
			return dGetWUStatus(trim(created,left,right) <> '' and trim(modified,left,right) <> '' and length(trim(datetime,left,right)) = 14);
	end;
	
	////////////////////////////////////////////////////
	// function to pull/push records to/from dops database
	////////////////////////////////////////////////////
	export DB_BTInfo(dataset(rTrackBuild) dDetails
										,boolean isGetInfo = false
										) := function
		
		rBTInfoXML := record
			string datasetname{xpath('datasetname')};
			string buildversion{xpath('buildversion')};
      string componentname{xpath('componentname')};
      string wuid{xpath('wuid')};
      string datetime{xpath('datetime')}; // time when the info was first captured
      string vertical{xpath('vertical')};
      string location{xpath('location')};
      string created{xpath('created')}; // time when WU was created
      string modified{xpath('modified')}; // time when WU was modified
      string jobstatus{xpath('jobstatus')};
			string emailid {xpath('emailid')};
			string thresholdinsecs {xpath('thresholdinsecs')};
			string reason {xpath('reason')};
			string wuerrors {xpath('wuerrors')};
		end;
	
		rBTList := record, maxlength(50000)
			dataset(rBTInfoXML) BTList{xpath('btinfo')};
		end;
		
		rBTList xBTList(dDetails L) := transform
			self.BTList   := DATASET([{ trim(l.datasetname,left,right)
													,trim(l.buildversion,left,right)
													, trim(l.componentname,left,right)
													, trim(l.wuid,left,right)
													, trim(l.datetime,left,right)
													, trim(l.vertical,left,right)
													, trim(l.location,left,right)
													, trim(l.created,left,right)
													, trim(l.modified,left,right)
													, trim(l.jobstatus,left,right)
													, trim(l.emailid,left,right)
													, trim(l.thresholdinsecs,left,right)
													, trim(l.reason,left,right)
													, trim(l.wuerrors,left,right)}]
													, rBTInfoXML);
			self := L;
		end;

		dBTList := project(dDetails, xBTList(left));

		rBuildTrackingInfoRequest := record, maxlength(50000)
			dataset(rBTList) btinfo{xpath('btlist')} := dBTList;
			boolean isGetInfo{xpath('isGetInfo')} := isGetInfo;
			string vertical{xpath('vertical')} := p_vertical;
			string location{xpath('location')} := p_location;
		end;
		
		rSOAPResponse := SOAPCALL(
				
				dops.constants.prboca.serviceurl(p_dopsenv),
				////////////////////////////////////////////////////
				// to check the soap xml use local machine IP and run soapplus -s -p 4546
				// 'http://10.176.152.60:4546/',
				////////////////////////////////////////////////////
				'BuildTrackingInfo',
				rBuildTrackingInfoRequest,
				dataset(rBTList),
				xpath('BuildTrackingInfoResponse/BuildTrackingInfoResult'),
				NAMESPACE('http://lexisnexis.com/'),
				LITERAL,
				SOAPACTION('http://lexisnexis.com/BuildTrackingInfo'));
		
		rGetKey := record
			string l_wuid := '';
			dataset(rBTInfoXML) btlist;
		end;
		
		rGetKey xGetKey(rSOAPResponse l) := transform
			self.btlist := l.BTList;
			self.l_wuid := WORKUNIT;
		end;
		
		dGetKey := project(rSOAPResponse,xGetKey(left));
		
		rTrackBuild xNormRecs(dGetKey l,rBTInfoXML r) := transform
			self := r;
		end;
		
		dNormRecs := normalize(dGetKey, left.btlist, xNormRecs(left,right));
		
		return dNormRecs;
	
	end;
	
	////////////////////////////////////////////////////
	// move all track logical files
			// from "backup" to "delete"
			// from "prod" to "backup"
			// from "using" to "prod"
	////////////////////////////////////////////////////		
	export fPrepInfoForTracking() := function
			dGWS := fGetWUStatus(SU_FileTrackBuild(FileInfoPrefix)) : independent;
			dDopsBTUpdate := DB_BTInfo(dGWS) : independent;
			return if (regexfind('hthor', STD.System.Job.Target())
								,if (~fileservices.fileexists(LF_PrepforTracking(FlagPrefix))
										,sequential
										(
												output(dataset([{WORKUNIT}],{string wuidflag}),,LF_PrepforTracking(FlagPrefix),overwrite)
												,fAddTrackFilesToSuper()
												,if (count(dGWS) > 0
															,if (count(dDopsBTUpdate(trim(datasetname,left,right) = 'ERROR')) = 0
																		,sequential
																		(
																			output(dDopsBTUpdate,,LF_PrepforTrackingResult(FlagPrefix),overwrite)
																			,STD.File.StartSuperFileTransaction()
																			// from backup to delete
																			,STD.File.AddSuperFile(
																					SD_FileTrackBuild(FileInfoPrefix)
																					,SB_FileTrackBuild(FileInfoPrefix)
																					,,true																		
																					)
																			// from prod to backup
																			,STD.File.ClearSuperFile(SB_FileTrackBuild(FileInfoPrefix))
																			,STD.File.AddSuperFile(
																					SB_FileTrackBuild(FileInfoPrefix)
																					,SP_FileTrackBuild(FileInfoPrefix)
																					,,true																		
																					)
																			// from using to prod, just to hold the latest set of updates
																			,STD.File.ClearSuperFile(SP_FileTrackBuild(FileInfoPrefix))
																			,STD.File.AddSuperFile(
																					SP_FileTrackBuild(FileInfoPrefix)
																					,SU_FileTrackBuild(FileInfoPrefix)
																					,,true																		
																					)
																			// clear using
																			,STD.File.ClearSuperFile(SU_FileTrackBuild(FileInfoPrefix))
																			// delete files from "delete" super and delete them if not used in other supers
																			,STD.File.RemoveOwnedSubFiles(SD_FileTrackBuild(FileInfoPrefix),true)
																			,STD.File.FinishSuperFileTransaction()
																		)
																		,sequential
																				(
																					output(dDopsBTUpdate(trim(datasetname,left,right) = 'ERROR'),named('ERRORS'))
																					,STD.System.Email.SendEmail(toemaillist
																						,'SOAPCALL ERRORS: Build Tracking job'
																						,'Check ' + LF_Errors(FlagPrefix) + ' result, for soapcall errors\n' + 'http://'+localesp+':8010/?Wuid='+WORKUNIT+'&Widget=WUDetailsWidget#/stub/Summary' + '\n'
																						,
																						,
																						,fromemail)
																				)
																	)
																,output('Nothing to track')
														)
												,fileservices.deletelogicalfile(LF_PrepforTracking(FlagPrefix))
										)
										,output('Another PrepForTracking job running. Remove ' + LF_PrepforTracking(FlagPrefix) + ' if no jobs are running')
									)
									,fail('run on a hthor target')
								);
	end;
	
	////////////////////////////////////////////////////
	// Track jobs and send email if over threshold
	////////////////////////////////////////////////////
	export fTrackAndEmail() := function
	
		dGetRecordsFromDB := sort(DB_BTInfo(dataset([{'', '', '', '', '', '', '', '', '', '', '', '','',''}],rTrackBuild),true),datasetname, buildversion, componentname, datetime)(~(datasetname in vsIgnoreDataset and componentname in vsIgnoreComponent)) : independent;
	
		rGetTimeDiff := record
			rTrackBuild;
			integer timeinsecs := 0;
			integer thresholddeviation := 0;
			string emailsubject := '';
			string emailmessage := '';
			integer totaltimeinsecs := 0
		end;
		
		dGetNC := dGetRecordsFromDB(jobstatus not in ['COMPLETED']);
		dGetC := dGetRecordsFromDB(jobstatus in ['COMPLETED']);
		
		rGetTimeDiff xGetNotCompleted(dGetC l, dGetNC r) := transform
			self := r;
		end;
		
		dGetNotCompleted := join(dGetC
															,dGetNC
															,left.datasetname = right.datasetname 
																	and left.componentname = right.componentname 
																	and left.buildversion = right.buildversion
															,xGetNotCompleted(left,right)
															,right only);
		dConvertToNewLayout := project(dGetRecordsFromDB,transform(rGetTimeDiff, self := left));													
		rGetTimeDiff xGetTimeDiff(dConvertToNewLayout l, dConvertToNewLayout r) := transform
			startseconds := if (r.created <> '',STD.Date.SecondsFromParts((integer)r.created [1..4]
																												,(integer)r.created [5..6]
																												,(integer)r.created [7..8]
																												,(integer)r.created [9..10]
																												,(integer)r.created [11..12]
																												,(integer)r.created [13..14]
																												,true)
																						,0);
			endseconds := if (r.modified <> '',STD.Date.SecondsFromParts((integer)r.modified[1..4]
																												,(integer)r.modified[5..6]
																												,(integer)r.modified[7..8]
																												,(integer)r.modified[9..10]
																												,(integer)r.modified[11..12]
																												,(integer)r.modified[13..14]
																												,true)
																						,0);
			timediff := endseconds - startseconds;
			/*totaltime := if (l.datasetname = r.datasetname and l.componentname = r.componentname and l.buildversion = r.buildversion
													,l.totaltimeinsecs + timediff
													,0 + timediff);*/
			totaltime := timediff; // because now we r.created as time when first created and r.modified = time when last touched
			td := totaltime - (integer)r.thresholdinsecs;
			
			s_prefix := 'ACTION Required: ' + r.datasetname + ':' + r.buildversion +':'+ r.componentname;
			m_prefix := 'workunit: ' + 'http://'+localesp+':8010/?Wuid='+r.wuid+'&Widget=WUDetailsWidget#/stub/Summary' + '\n';
			colorcode := MAP( 
																r.jobstatus in ['ABORTED', 'FAILED'] and trim(r.reason,left,right) = ''
																		=> 'R'
																,(totaltime > (integer)r.thresholdinsecs) and trim(r.reason,left,right) = ''
																		=> 'Y'
																,'G');
			url := vdopsurlprefix + '/btreason.aspx?dbn_trackingname='+ r.datasetname + '&dbc_componentname=' + regexreplace(':',regexreplace(' ',r.componentname,'%20'),'%3A') + '&dbs_buildversion=' + r.buildversion +'&dbs_wuid='+ r.wuid + '&colorcode='+colorcode;
			self.timeinsecs := timediff;
			self.thresholddeviation := td;
			self.emailsubject := MAP( 
																r.jobstatus in ['ABORTED', 'FAILED'] and trim(r.reason,left,right) = ''
																		=> s_prefix + ' job aborted/failed'
																,(totaltime > (integer)r.thresholdinsecs) and trim(r.reason,left,right) = ''
																		=> s_prefix + ' job over threshold'
																,'NA');
			self.emailmessage := MAP( 
																r.jobstatus in ['ABORTED', 'FAILED'] and trim(r.reason,left,right) = ''
																		=> m_prefix + '\n' + 'Was it restarted? set reason here: ' + url
																,(totaltime > (integer)r.thresholdinsecs) and trim(r.reason,left,right) = ''
																		=> m_prefix + '\n' + 'threshold (in hrs): ' + (string)round(((integer)r.thresholdinsecs / 3600),1) + '\n' + 'actual total build time (in hrs): ' + (string)round((totaltime / 3600),1) + ', which is over set threshold time \n\nset reason here: ' + url
																,'NA');
			self.totaltimeinsecs := totaltime;
			self := r;
		end;
		
		dGetTimeDiff := dedup(sort(iterate(dConvertToNewLayout,xGetTimeDiff(left,right)),datasetname, -buildversion, componentname, -datetime),datasetname, buildversion, componentname) : independent;
		
		return if (regexfind('hthor', STD.System.Job.Target())
								,if (~fileservices.fileexists(LF_EmailNotify(FlagPrefix))
										,sequential
											(
												output(dataset([{WORKUNIT}],{string wuidflag}),,LF_EmailNotify(FlagPrefix),overwrite)
												,output(dGetTimeDiff,,LF_EmailResultstore(FlagPrefix),overwrite)
												,apply
												(
													dGetTimeDiff
													,if (emailid <> '' and emailsubject <> 'NA'
															,STD.System.Email.SendEmail('anantha.venkatachalam@lexisnexisrisk.com,'+emailid,
																emailsubject
																,emailmessage
																,
																,
																,fromemail)
															)
												)
												,fileservices.deletelogicalfile(LF_EmailNotify(FlagPrefix))
											)
										,output('Another TrackAndEmail job running')
									)
									,fail('run on a hthor target')
								);
	end;
	
	// separate calls to invoke the function
	// to capture the failures
	export RunPrepForTracking() := sequential
																		(
																			fPrepSupers(FileInfoPrefix)	
																			,fPrepInfoForTracking()
																		): success(output('Workunit completed successfully'))
									,failure(sequential
															(dops.GetWUErrorMessages(WORKUNIT
																							,localesp
																							,
																							,fromemail
																							,toemaillist)
																,fileservices.deletelogicalfile(LF_PrepforTracking(FlagPrefix))
															)
														);
	
	
	export RunTrackAndEmail() := fTrackAndEmail() : success(output('Workunit completed successfully'))
									,failure(sequential
															(dops.GetWUErrorMessages(WORKUNIT
																							,localesp
																							,
																							,fromemail
																							,toemaillist)
																,fileservices.deletelogicalfile(LF_EmailNotify(FlagPrefix))
															)
														);
end;