import STD,lib_fileservices,ut;
export ArchiveFiles(string location, string environment, integer noofpartitions = 0, integer whichpartition = 0) := module
	
	export rundatetime := ut.GetTimeDate() : independent;
	
	export basename := 'yogurt::base::';
	
	export filestoprocess := basename + location + '::' + environment + '::qa::filestoprocess';
	export firstgeneration := regexreplace('::qa::',filestoprocess,'::father::');
	export deletesuper := regexreplace('::qa::',filestoprocess,'::delete::');
	export usingsuper := regexreplace('::qa::',filestoprocess,'::using::');
	export processed := regexreplace('::qa::',filestoprocess,'::processed::');
	export processeddelete := regexreplace('::qa::',filestoprocess,'::processed::delete::');
	export processedfile := '~'+processed+rundatetime;
	export errorqa := regexreplace('::qa::',filestoprocess,'::error::');
	export errordelete := regexreplace('::qa::',filestoprocess,'::error::delete::');
	export errorfile := '~'+errorqa+rundatetime;
	
	export filesrec := record
		string20 wuid;
		string100 files;
		boolean issuper;
		string cmd;
		string modified;
	end;

	export postfilesrec := record
		string20 wuid;
		string100 files;
		boolean issuper;
		string cmd;
		string20 createdate;
	end;

	export filestocopy := fileservices.logicalfilelist(basename + location + '::' + environment + '*filestocopy');

	export IsNewList := if (count(filestocopy) > 0, true, false);

	export CreateSupers := sequential(
													if (~fileservices.superfileexists('~'+filestoprocess),
														fileservices.createsuperfile('~'+filestoprocess)),
													if (~fileservices.superfileexists('~'+firstgeneration),
														fileservices.createsuperfile('~'+firstgeneration)),
													if (~fileservices.superfileexists('~'+deletesuper),
														fileservices.createsuperfile('~'+deletesuper)),
													if (~fileservices.superfileexists('~'+usingsuper),
														fileservices.createsuperfile('~'+usingsuper)),
													if (~fileservices.superfileexists('~'+processeddelete),
														fileservices.createsuperfile('~'+processeddelete)),
													if (~fileservices.superfileexists('~'+processed),
														fileservices.createsuperfile('~'+processed)),
													if (~fileservices.superfileexists('~'+errordelete),
														fileservices.createsuperfile('~'+errordelete)),
													if (~fileservices.superfileexists('~'+errorqa),
														fileservices.createsuperfile('~'+errorqa))
														);
	
	export MoveFiles := sequential(
													fileservices.removeownedsubfiles('~'+deletesuper,true),
													fileservices.addsuperfile('~'+deletesuper,'~'+firstgeneration,,true),
													fileservices.clearsuperfile('~'+firstgeneration),
													fileservices.addsuperfile('~'+firstgeneration,'~'+filestoprocess,,true),
													fileservices.clearsuperfile('~'+filestoprocess)
													);
	
	export PrepForCopy := nothor(apply(filestocopy,
														sequential
															(
																if (fileservices.fileexists('~'+regexreplace('filestocopy',name,'filestoprocess')),
																	sequential(
																		apply(fileservices.logicalfilesuperowners('~'+regexreplace('filestocopy',name,'filestoprocess')),
																				fileservices.removesuperfile('~'+name,'~'+regexreplace('filestocopy',name,'filestoprocess'))
																				),
																				fileservices.deletelogicalfile('~'+regexreplace('filestocopy',name,'filestoprocess'))
																				)
																		),
																fileservices.renamelogicalfile('~'+name,'~'+regexreplace('filestocopy',name,'filestoprocess')),
																fileservices.addsuperfile('~'+filestoprocess, '~'+regexreplace('filestocopy',name,'filestoprocess')),
																fileservices.addsuperfile('~'+usingsuper, '~'+regexreplace('filestocopy',name,'filestoprocess'))
															)
														));

	//export SlimmedFilesToCopy := dedup(sort(dataset('~'+filestoprocess, filesrec, thor, opt)(~(regexfind('foreign',files) 
	
	export SlimmedFilesToCopy := function
		SlimmedDs := dedup(sort(dataset('~'+filestoprocess, filesrec, thor, opt)(~(regexfind('foreign',files) 
																																							or regexfind(':: ',files)
																																							or regexfind('thor::base::aid_nonheader::ace',files)
																																							or regexfind('::nid::',files))),files),files)
																																							(files not in thorbackup.SkipCopyList);


		
		string_rec := record
			SlimmedDs;
			string s_pattern := '';
			integer s_cnt := 0; 
		end;

		string_rec getpatterns(SlimmedDs l) := transform
			mypattern := regexreplace('-',regexreplace('[0-9]+',regexreplace('[0-9]+[a-z]',l.files,'*',nocase),'*',nocase),'*');
			self.s_pattern := mypattern;
			self := l;
		end;

		patds := sort(projecT(SlimmedDs,getpatterns(left)),s_pattern, -wuid);


		string_rec get_names(patds l,patds r) := transform
			
			self.s_cnt := if (l.s_pattern = r.s_pattern, l.s_cnt + 1, 1);
			self := r;
		end;
		
		iterate_it := iterate(patds,get_names(left,right));

		return iterate_it(s_cnt <= thorbackup.Constants.yogurt().no_of_files_to_keep);
		
	end;
																																																																		
	export integer totalrecords :=  count(SlimmedFilesToCopy);

	export floor(integer no) := (integer)no;
	export ceil(integer no) := (integer)no + 1;

	export mincnt := if (noofpartitions = 0 or whichpartition = 0, 1, floor(((totalrecords / noofpartitions) * (whichpartition - 1)) + 1));
	export maxcnt := if (noofpartitions = 0 or whichpartition = 0, totalrecords, ceil((totalrecords / noofpartitions) * whichpartition));

	export jobstatusfile := '~yogurt::filecopy::running_for_'+(string)whichpartition+'_of_'+(string)noofpartitions;

	export writejobstatusfile := output(dataset([{whichpartition,noofpartitions}],{integer whichpart, integer noofpart}),,'~yogurt::filecopy::running_for_'+(string)whichpartition+'_of_'+(string)noofpartitions, overwrite);
	
	export isjobrunning := if (count(fileservices.logicalfilelist('yogurt::filecopy::running_for_*')) > 0,true, false);

	export PostCopy() := 	function
		
	
		ds := dedup(sort(dataset('~'+filestoprocess, filesrec, thor, opt)(~(regexfind('foreign',files) or regexfind(':: ',files))),-wuid, files),files);
		
		postfilesrec getCreateDate(ds l) := transform
			self.createdate := rundatetime;
			self := l;
		end;
		
		OutFileWithCreateDate := project(ds,getCreateDate(left));
		
		postds := dataset('~'+processed, postfilesrec, thor, opt);
		return sequential
							(
								output(sort(OutFileWithCreateDate + postds, -createdate),,'~'+processedfile,overwrite),
								CreateSupers,
								fileservices.RemoveOwnedSubFiles('~'+processeddelete,true),
								fileservices.addsuperfile('~'+processeddelete,'~'+processed,,true),
								fileservices.clearsuperfile('~'+processed),
								fileservices.addsuperfile('~'+processed,'~'+processedfile),
							);
	end;
	
	export GetActualFileListToCopyWithoutPersist() := function
	
		
		
		filesrec_cnt := record
			filesrec;
			integer l_cnt := 0;
			boolean isChanged;
		end;
		
		filesrec_cnt addcnt_trans(SlimmedFilesToCopy l, integer cnt) := transform
			self.isChanged := if (~fileservices.fileexists('~'+l.files),
														true,
														/*if (l.modified <> fileservices.logicalfilelist(l.files)[1].modified,
																true,
																false)*/
																false
														);
			self.l_cnt := cnt;
			self := l;
		end;
		
		add_cnt := project(SlimmedFilesToCopy,addcnt_trans(left, counter))(l_cnt >= mincnt and l_cnt <= maxcnt and isChanged);// : persist('~yogurt::persist::slimmedfiles');
		
		// filesrec_cnt updatecnt_trans(add_cnt l,add_cnt r) := transform
			// self.l_cnt := l.l_cnt + 1;
			// self := r;
		// end;
		
		// count_updated := iterate(add_cnt,updatecnt_trans(left,right));
		
		return add_cnt;
		
	end;
	
	
	export GetActualFileListToCopy() := function
	
		
		
		filesrec_cnt := record
			filesrec;
			integer l_cnt := 0;
			boolean isChanged;
		end;
		
		filesrec_cnt addcnt_trans(SlimmedFilesToCopy l, integer cnt) := transform
			self.isChanged := if (~fileservices.fileexists('~'+l.files),
														true,
														// there are scenarios when the file copied to destination
														// is older than file on source (due to delayed copy)
														// in which the file will not copy, need find an alternative
														// this scenario is rare.
														// if (l.modified > fileservices.logicalfilelist(l.files)[1].modified,
																// true,
																// false)
																false
														);
			self.l_cnt := cnt;
			self := l;
		end;
		
		add_cnt := project(SlimmedFilesToCopy,addcnt_trans(left, counter))(l_cnt >= mincnt and l_cnt <= maxcnt and isChanged) : independent; //persist('~yogurt::persist::slimmedfiles');
		
		// filesrec_cnt updatecnt_trans(add_cnt l,add_cnt r) := transform
			// self.l_cnt := l.l_cnt + 1;
			// self := r;
		// end;
		
		// count_updated := iterate(add_cnt,updatecnt_trans(left,right));
		
		return add_cnt;
		
	end;
	
	export CopyFiles := function
	
		return 	apply(GetActualFileListToCopy(),
														sequential(
																output( 'Copying file ' + (string) l_cnt),
																STD.File.DfuPlusExec(cmd)
																)
														 );
	end;
	
	
	export GetErrorMessages(string wid) := function
		InRecord := record
			string Name{xpath('Wuid')} := wid;
		end;

	
		messages := record, maxlength(30000)
			string message {XPATH('Message')} := '';
		end;

	
		resultnames := record
			string100 name {XPATH('FileName')} := '';
		end;

	
		OutRecord := record,maxlength(300000)
			string20 Wuid{xpath('Wuid')};
			dataset(messages) errormessages{xpath('Exceptions/ECLException')};
			//dataset(resultnames) resultfiles{xpath('Results/ECLResult')};
		end;
	
		results := SOAPCALL('http://10.173.26.7:8010/WsWorkunits', 'WUInfo', 
											InRecord, dataset(OutRecord),
											xpath('WUInfoResponse/Workunit')
										 );

		filenames := record, maxlength(30000)
			string20 wuid := wid;
			string20 errortime;
			integer emailsent;
			string messages := '';
		end;
	
		filenames norm_sources(results l, messages r) := transform
			self.messages := r.message;
			self.errortime := rundatetime;
			self.emailsent := 0;
			self := l;
		end;
	
		filesused := normalize(results,left.errormessages,norm_sources(left,right));
	
		fulllist := dedup(sort(filesused(regexfind('FAILED',stringlib.stringtouppercase(messages)) ) ,messages),record);

		errords := dataset('~'+errorqa, filenames, CSV(SEPARATOR('\t'),QUOTE('\"'),TERMINATOR('\r\n')),OPT);
		
		finalerrorlist := dedup(sort(fulllist + errords,wuid,messages,-emailsent,-errortime),wuid,messages);

		// Email prep work
		
		linestring := RECORD
			STRING300000 line; 
		END;

		headerRec := DATASET([{'errormessage, errortime'}], linestring);

		linestring converttoline (finalerrorlist L) := TRANSFORM
				SELF.line         := L.messages + ',' +  regexreplace('-',L.errortime,'');
		END;
		
		singlelinerecord := PROJECT (finalerrorlist(emailsent = 0), converttoline(LEFT));

		
		myrec := RECORD
			UNSIGNED  code0; 
			STRING300000 line; 
		END;

		myrec ref(singlelinerecord l) := TRANSFORM 
			SELF.code0 := 0; 
			SELF       := l; 
		END;

		inputs := PROJECT(headerRec+singlelinerecord, ref(LEFT));

		MyRec rollupForm (myrec L, myrec R) := TRANSFORM
			SELF.line := TRIM(L.line, left, right) + '\n' + TRIM(R.line, LEFT, RIGHT); 
			SELF      := L;
		END;

		XtabOut := ROLLUP(inputs, rollupForm(LEFT,RIGHT), CODE0);
	
	
		mailerrors :=	FileServices.SendEmailAttachText( thorbackup.constants.yogurt().emailerrors
																						,'Yogurt file copy errors - ' + rundatetime
																						,'Please see attached file for errors'
																						, TRIM(XtabOut[1].line, LEFT, RIGHT)
																						,'text/xml'
																						,'YogurtCopyErrors.csv'
																						,
																						,
																						,thorbackup.constants.yogurt().senderemail);
		
		filenames resetemailflag(finalerrorlist l) := transform
			self.emailsent := 1;
			self := l;
		end;
		
		createerrorfile := project(finalerrorlist,resetemailflag(left));
		
		return if (count(singlelinerecord) > 0,
									sequential(
										mailerrors,
										output(createerrorfile,,'~'+errorfile, CSV(SEPARATOR('\t'),QUOTE('\"'),TERMINATOR('\r\n')),overwrite),
										CreateSupers,
										fileservices.clearsuperfile('~'+errordelete,true),
										fileservices.addsuperfile('~'+errordelete,'~'+errorqa,,true),
										fileservices.clearsuperfile('~'+errorqa),
										fileservices.addsuperfile('~'+errorqa,'~'+errorfile),
								));
	end;
	
	export rerun := if (fileservices.fileexists(jobstatusfile)
											,output('Another process running or the previous WU failed..delete ' + jobstatusfile + ' and re-run')
											,sequential
													(
														// MoveFiles,
														// PrepForCopy,
														writejobstatusfile,
														output(mincnt, named('Start_Count')),
														output(maxcnt, named('End_Count')),
														CopyFiles,
														PostCopy(),
														GetErrorMessages(WORKUNIT),
														fileservices.deletelogicalfile(jobstatusfile),
															if (~isjobrunning,
																fileservices.clearsuperfile('~'+usingsuper))
														)) : failure(sequential(
																				fileservices.deletelogicalfile(jobstatusfile),
																				fileservices.sendemail(thorbackup.constants.yogurt().emailerrors,
			'Yogurt Copy Process failed on http://10.173.26.7:8010/ - ' + ut.GetTimeDate(),
			'workunit: ' + workunit+ '\r\n' + failmessage
																	,
																	,
																	,thorbackup.constants.yogurt().senderemail)
									));
	
	
	export run := sequential
									(
										CreateSupers,
										//if (fileservices.GetSuperFileSubCount('~'+usingsuper) > 0
											if (fileservices.fileexists(jobstatusfile)
											,output('Another process running or the previous WU failed..delete ' + jobstatusfile + ' and re-run')
											,if (IsNewList,
												sequential
													(
														MoveFiles,
														PrepForCopy,
														writejobstatusfile,
														output(mincnt, named('Start_Count')),
														output(maxcnt, named('End_Count')),
														CopyFiles,
														PostCopy(),
														GetErrorMessages(WORKUNIT),
														fileservices.deletelogicalfile(jobstatusfile),
														if (~isjobrunning,
															fileservices.clearsuperfile('~'+usingsuper))
														),
													output('No New Files to Copy')
													)
												)
										)  : failure(sequential(
																	fileservices.deletelogicalfile(jobstatusfile),
																	fileservices.sendemail(thorbackup.constants.yogurt().emailerrors,
			'Yogurt Copy Process failed on http://10.173.26.7:8010/ - ' + ut.GetTimeDate(),
			'workunit: ' + workunit + '\r\n' + failmessage
																	,
																	,
																	,thorbackup.constants.yogurt().senderemail)
											));
	
end;


