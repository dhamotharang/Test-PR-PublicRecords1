import lib_workunitservices,STD,ut;
EXPORT PrepForYogurt(string location, string environment) := module

	shared basename := 'yogurt::base::';
	
	shared filestoprocess := basename + location + '::' + environment + '::qa::filestocopy';
	shared filestodelete := basename + location + '::' + environment + '::qa::filestodelete';
	shared firstgeneration := regexreplace('::qa::',filestoprocess,'::father::');
	shared deletesuper := regexreplace('::qa::',filestoprocess,'::delete::');

	export ReadFileList := dataset('~'+filestoprocess,{string20 wuid, string100 files, boolean issuper, string cmd},thor,opt);

	export maxWU := max(ReadFileList,wuid);

	export GetFilesInWorkunit(string wid) := function
		InRecord := record
			string Name{xpath('Wuid')} := wid;
		end;

	
		subfiles := record
			string100 name {XPATH('Name')} := '';
		end;

	
		resultnames := record
			string100 name {XPATH('FileName')} := '';
		end;

	
		OutRecord := record,maxlength(300000)
			string20 Wuid{xpath('Wuid')};
			dataset(subfiles) sourcefiles{xpath('SourceFiles/ECLSourceFile')};
			//dataset(resultnames) resultfiles{xpath('Results/ECLResult')};
		end;
	
		results := SOAPCALL('http://10.241.20.202:8010/WsWorkunits', 'WUInfo', 
											InRecord, dataset(OutRecord),
											xpath('WUInfoResponse/Workunit')
										 );

		filenames := record
			string20 wuid := wid;
			string100 files := '';
		end;
	
		filenames norm_sources(results l, subfiles r) := transform
			self.files := r.name;
			self := l;
		end;
	
		filesused := normalize(results,left.sourcefiles,norm_sources(left,right));
	
		
		fulllist := dedup(sort(filesused(files <> '') ,files),record);

		fullset := record
			string100 files;
		end;

		final_layout := record
			string20 wuid;
			dataset(fullset) fnames;
		end;

		final_layout proj_recs(fulllist l) := transform
			self.fnames := row(l,fullset);
			self := l;
		end;
	
		proj_out := project(fulllist,proj_recs(left));

		final_layout rolluprecs(proj_out l, proj_out r) := transform
			self.fnames := l.fnames + row({r.fnames[1].files},fullset);
			self := l;
		end;
	
		rollout := rollup(proj_out,wuid,rolluprecs(left, right),local);	

		return rollout;
	end;
//-------------------------------------------

	
	export GetYogurtWUIDs := lib_workunitservices.WorkunitServices.workunitlist
														(lowwuid := maxWU
															, highwuid := dops.constants.yogurt().endwu)
															(regexfind('yogurt',stringlib.StringToLowerCase(job)) and 
																~( job = 'Prep Yogurt Copy' 
																	//or wuid = maxWU 
																	or state in ['running','blocked'] )
																);

	export GetFileList(string wuid = '') := function
		
		wuds := if (wuid <> '',dataset([{wuid,'','','','','','',0,'','',false,false}],lib_workunitservices.wsworkunitrecord),sort(GetYogurtWUIDs,-wuid));

		fullset := record
			string100 files;
		end;

		string_rec := record,maxlength(30000)
			string20 wuid;
			dataset(fullset) fnames;
		end;

		string_rec proj_recs(wuds l) := transform
			self.wuid := l.wuid;
			self.fnames := GetFilesInWorkunit(l.wuid)[1].fnames;
		end;

		proj_out := project(wuds,proj_recs(left));

		filesrec_flat := record
			string20 wuid;
			string100 files;
			boolean issuper;
			string cmd;
		end;
		
		filesrec_flat norm_recs(proj_out l,fullset r) := transform
			self.files := r.files;
			self.issuper := if (fileservices.superfileexists('~'+r.files),true,false);
			self.cmd := dops.constants.yogurt().serv 
									+ dops.constants.yogurt().over 
									+ dops.constants.yogurt().repl 
									+ dops.constants.yogurt().action 
									+ dops.constants.yogurt().dstcluster 
									+ 'dstname=~'+r.files 
									+ ' srcname=~'+r.files 
									+ dops.constants.yogurt().nsplit 
									+ dops.constants.yogurt().wrap 
									+ dops.constants.yogurt().srcdali + ' compress=1';
			self := l;
		end;
		
		ds_flatten := normalize(proj_out,left.fnames,norm_recs(left,right))
																			(~(files = ''
																				or regexfind('hpccinternal',files)
																				or regexfind('spill',files)
																				or regexfind('persist',files)
																				or regexfind('::key::',files)
																				or regexfind('yogurt',files)
																				or regexfind('foreign',files)
																				or regexfind(':: ',files)
																				));
		
		return ds_flatten;
		
	end;
	
	export GetFilePatternstoDelete(string wuid = '') := function
		ds := GetFileList(wuid)(issuper and ~regexfind('^file::',files));
		

		// check if supers have more than 1 sub
		// check if subs have more than 1 super and does any super have more than 1 subcount
		
		dops.Layout_DeleteFilesInfo GetSupersWithOneSub(ds l) := transform
			sname := fileservices.GetSuperFileSubName('~'+l.files,1);
			self.name := l.files;
			self.subname := sname;
			self.hasmultiplesubs := if(sname <> '',dops.HasSupersWithMultipleSubs('~'+sname),false);
			self.datetime := ut.GetDate + ut.getTime();
		end;												

		deletesubs := project(ds(~(regexfind('insuranceheader:name_count',files)
																				or files = '')),GetSupersWithOneSub(left));
		
		
		dops.Layout_DeleteFilesInfo GetPatterns(deletesubs l) := transform
			self.subname := regexreplace('[0-9]+',regexreplace('[0-9]+[a-z]',l.subname,'*',nocase),'*',nocase);
			self := l;
		end;
		
		deletepatterns := project(deletesubs,GetPatterns(left));
		
		dops.Layout_DeleteFilesInfo CPatternSetup(deletepatterns l, dops.ChangePatternSetup r) := transform
			self.name := l.name;
			self.subname := l.subname;
			self.hasmultiplesubs := if (r.name <> '', r.hasmultiplesubs, l.hasmultiplesubs);
			self.datetime := if (r.name <> '', r.datetime, l.datetime);
		end;
		
		GetCPatternSetup := join(deletepatterns,dops.ChangePatternSetup,
																	left.name = right.name,
																	CPatternSetup(left,right),
																	left outer
																	);
																	
															
		
		return dedup(sort(GetCPatternSetup,name,-hasmultiplesubs),name);
		
	end;
	
	export CreateSupers := sequential(
													if (~fileservices.superfileexists('~'+filestoprocess),
														fileservices.createsuperfile('~'+filestoprocess)),
													if (~fileservices.superfileexists('~'+filestodelete),
														fileservices.createsuperfile('~'+filestodelete)),
													if (~fileservices.superfileexists('~'+firstgeneration),
														fileservices.createsuperfile('~'+firstgeneration)),
													if (~fileservices.superfileexists('~'+deletesuper),
														fileservices.createsuperfile('~'+deletesuper))
														);
	
	export MoveFiles := sequential(
													fileservices.clearsuperfile('~'+deletesuper,true),
													fileservices.addsuperfile('~'+deletesuper,'~'+firstgeneration,,true),
													fileservices.clearsuperfile('~'+firstgeneration),
													fileservices.addsuperfile('~'+firstgeneration,'~'+filestoprocess,,true),
													fileservices.clearsuperfile('~'+filestoprocess),
													fileservices.addsuperfile('~'+filestoprocess,'~'+basename+location+'::'+environment+'::'+dops.constants.yogurt().enddate+dops.constants.yogurt().l_time+'::filestocopy'),
													fileservices.clearsuperfile('~'+filestodelete,true),
													fileservices.addsuperfile('~'+filestodelete,'~'+basename+location+'::'+environment+'::'+dops.constants.yogurt().enddate+dops.constants.yogurt().l_time+'::filestodelete')
													);
	

	
	export CreatePrepFile := sequential
																		(
																			CreateSupers,
																			output(GetFileList()(~issuper),,'~'+basename+location+'::'+environment+'::'+dops.constants.yogurt().enddate+dops.constants.yogurt().l_time+'::filestocopy',overwrite),
																			output(GetFilePatternstoDelete(),,'~'+basename+location+'::'+environment+'::'+dops.constants.yogurt().enddate+dops.constants.yogurt().l_time+'::filestodelete',overwrite)
																		);
	
	
	
	export UpdateSupers := sequential
																		(
																			CreateSupers,
																			MoveFiles
																	);
																
	export SendFileListToYogurtThor := sequential(
																					STD.File.DfuPlusExec(dops.constants.yogurt('~'+filestoprocess).copyfilecmd),
																					STD.File.DfuPlusExec(dops.constants.yogurt('~'+filestodelete).copyfilecmd)
																					);
	
	export run := if(count(GetYogurtWUIDs) > 0,
								if (~fileservices.fileexists('~yogurt::job::running'),																		
									sequential
										(
											output(max(ReadFileList,wuid),named('Start_WUID')),
											output(dops.constants.yogurt().endwu,named('End_WUID')),
											output(dataset([],{string1 dummy}),,'~yogurt::job::running'),
											if (count(GetFileList()(~issuper)) > 0,
												sequential(
												CreatePrepFile,
												UpdateSupers,
												SendFileListToYogurtThor),
												output('No New Supers to Copy or Delete')
												),
											fileservices.deletelogicalfile('~yogurt::job::running')
											),
										output('Another job running or previous run failed. In case of failure delete yogurt::job::running file')
											
										),
										output('Nothing to send to yogurt')
										) : failure(
													sequential(
													fileservices.deletelogicalfile('~yogurt::job::running'),
													fileservices.sendemail(dops.constants.yogurt().emailerrors,
			'Yogurt Prep Process failed on http://prod_esp:8010 - ' + ut.GetTimeDate(),
			'workunit: ' + workunit + '\n re-schedule')));
	
end;