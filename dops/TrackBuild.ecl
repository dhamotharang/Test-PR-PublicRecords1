import STD, DOPS, _Control;
// p_vertical: 'P' = Public Records, 'I' = Insurance, 'H' = Health care
EXPORT TrackBuild(string p_vertical = 'P'
									,string p_location = dops.constants.location
									,string p_dopsenv = 'dev') := module

	////////////////////////////////////////////////////
	// DECLRATIONS & DEFINITIONS
	////////////////////////////////////////////////////
	export FileTrackBuildPrefix := '~dops::trackbuild::';
	
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
									) := function
		// get WU state							
		
		dBuildInfo := dataset([{p_dopsdatasetname,p_buildversion,p_componentname
												,WORKUNIT,(string)STD.Date.Today() + (string)STD.Date.CurrentTime(true)
												,p_vertical,p_location,'','',''}],rTrackBuild);
		
		return 	sequential
								(
									fPrepSupers(FileInfoPrefix)
									,output(dBuildInfo,,FileInfoPrefix + '::' + WORKUNIT,overwrite)
									
								);
						
		
	end;
	
	////////////////////////////////////////////////////
	// get the latest tracking info from prod super by default
	// but when tracking use, using super 
	////////////////////////////////////////////////////
	export dGetInfo(string TrackBuildFile = SP_FileTrackBuild(FileInfoPrefix)) 
																:= dataset(TrackBuildFile,rTrackBuild,thor,opt);
	
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
	export fGetWUStatus(string TrackBuildFile = SP_FileTrackBuild(FileInfoPrefix)) := function
			dInfo := sort(dGetInfo(TrackBuildFile),wuid);
			
			rTrackBuild xGetWUStatus(dInfo l) := transform
				dWUInfo := STD.system.Workunit.WorkunitList(lowwuid := l.wuid, highwuid := l.wuid);
				dWUTimeStamps := sort(STD.system.Workunit.WorkunitTimeStamps(l.wuid),-time);
				jobstate := STD.str.ToUpperCase(trim(dWUInfo[1].state,left,right));
				self.jobstatus := jobstate;
				self.created := regexreplace('[-:TZ]',dWUTimeStamps(STD.Str.ToUpperCase(id) = 'CREATED')[1].time,'',nocase);
				self.modified := regexreplace('[-:TZ]',dWUTimeStamps[1].time,'',nocase);
				
				self := l;
			end;
			
			dGetWUStatus := project(dInfo,xGetWUStatus(left));
			
			return dGetWUStatus;
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
			
		end;
	
		rBTList := record, maxlength(50000)
			dataset(rBTInfoXML) BTList{xpath('btinfo')};
		end;
		
		rBTList xBTList(dDetails L) := transform
			self.BTList   := DATASET([{ trim(l.datasetname,left,right), trim(l.buildversion,left,right), trim(l.componentname,left,right), trim(l.wuid,left,right), trim(l.datetime,left,right), trim(l.vertical,left,right), trim(l.location,left,right), trim(l.created,left,right), trim(l.modified,left,right), trim(l.jobstatus,left,right), trim(l.emailid,left,right), trim(l.thresholdinsecs,left,right), trim(l.reason,left,right)}], rBTInfoXML);
			self := L;
		end;

		dBTList := project(dDetails, xBTList(left));

		rBuildTrackingInfoRequest := record, maxlength(50000)
			dataset(rBTList) btinfo{xpath('btlist')} := dBTList;
			boolean isGetInfo{xpath('isGetInfo')} := isGetInfo;
			string vertical{xpath('vertical')} := p_vertical;
			string location{xpath('location')} := dops.constants.location;
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
																			output(dDopsBTUpdate)
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
																		,STD.System.Email.SendEmail(toemaillist
																					,'SOAPCALL ERRORS: Build Tracking job'
																					,'Check ' + SU_FileTrackBuild(FileInfoPrefix) + '::persist, for soapcall errors\n' + 'http://'+localesp+':8010/?Wuid='+WORKUNIT+'&Widget=WUDetailsWidget#/stub/Summary' + '\n'
																					,
																					,
																					,fromemail)
																	)
																,output('Nothing to track')
														)
												,fileservices.deletelogicalfile(LF_PrepforTracking(FlagPrefix))
										)
										,output('Another PrepForTracking job running')
									)
									,fail('run on a hthor target')
								);
	end;
	
	////////////////////////////////////////////////////
	// Track jobs and send email if over threshold
	////////////////////////////////////////////////////
	export fTrackAndEmail() := function
	
		dGetRecordsFromDB := DB_BTInfo(dataset([{'', '', '', '', '', '', '', '', '', '', '', '',''}],rTrackBuild),true);
	
		rGetTimeDiff := record
			rTrackBuild;
			integer timeinsecs;
			integer thresholddeviation;
			string emailsubject := '';
			string emailmessage := '';
		end;
		
		rGetTimeDiff xGetTimeDiff(dGetRecordsFromDB l) := transform
			startseconds := if (l.created <> '',STD.Date.SecondsFromParts((integer)l.created [1..4]
																												,(integer)l.created [5..6]
																												,(integer)l.created [7..8]
																												,(integer)l.created [9..10]
																												,(integer)l.created [11..12]
																												,(integer)l.created [13..14]
																												,true)
																						,0);
			endseconds := if (l.modified <> '',STD.Date.SecondsFromParts((integer)l.modified[1..4]
																												,(integer)l.modified[5..6]
																												,(integer)l.modified[7..8]
																												,(integer)l.modified[9..10]
																												,(integer)l.modified[11..12]
																												,(integer)l.modified[13..14]
																												,true)
																						,0);
			timediff := endseconds - startseconds;
			td := timediff - (integer)l.thresholdinsecs;
			s_prefix := 'ACTION Required: ' + l.datasetname + ' ' + l.componentname;
			m_prefix := 'workunit: ' + 'http://'+localesp+':8010/?Wuid='+l.wuid+'&Widget=WUDetailsWidget#/stub/Summary' + '\n';
			self.timeinsecs := timediff;
			self.thresholddeviation := td;
			self.emailsubject := MAP( (td > 3600) and trim(l.reason,left,right) = ''
																		=> s_prefix + ' job over threshold'
																,l.jobstatus in ['ABORTED', 'FAILED'] and trim(l.reason,left,right) = ''
																		=> s_prefix + ' job aborted/failed'
																,'NA');
			self.emailmessage := MAP( (td > 3600) and trim(l.reason,left,right) = ''
																		=> m_prefix + '\n' + 'threshold (in secs): ' + (string)l.thresholdinsecs + '\n' + 'actual runtime (in secs): ' + (string)timediff + ', which is over an hour from threshold time' + '\n' + 'set reason here: '
																,l.jobstatus in ['ABORTED', 'FAILED'] and trim(l.reason,left,right) = ''
																		=> m_prefix + '\n' + 'Was it restarted? set reason here: '
																,'NA');
																
			self := l;
		end;
	
		dGetTimeDiff := project(dGetRecordsFromDB,xGetTimeDiff(left)) : independent;
	
		return if (regexfind('hthor', STD.System.Job.Target())
								,if (~fileservices.fileexists(LF_EmailNotify(FlagPrefix))
										,sequential
											(
												output(dataset([{WORKUNIT}],{string wuidflag}),,LF_EmailNotify(FlagPrefix),overwrite)
												,output(dGetTimeDiff)
												,apply
												(
													dGetTimeDiff
													,if (emailid <> '' and emailsubject <> 'NA'
															,STD.System.Email.SendEmail(emailid,
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
	export RunPrepForTracking() := fPrepInfoForTracking() : success(output('Workunit completed successfully'))
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