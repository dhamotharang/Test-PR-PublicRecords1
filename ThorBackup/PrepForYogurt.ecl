/*2014-10-03T23:55:34Z (ananth_p venkatachalam)
Move to new module
*/
import lib_workunitservices,STD,ut, dops;
EXPORT PrepForYogurt(string location, string environment, string last_wuid = '') := module

	shared filedate := thorbackup.constants.yogurt().enddate+thorbackup.constants.yogurt().l_time : independent;
	shared basename := 'yogurt::base::';
	
	shared filestoprocess := basename + location + '::' + environment + '::qa::filestocopy';
	shared filestodelete := basename + location + '::' + environment + '::qa::filestodelete';
	shared firstgeneration := regexreplace('::qa::',filestoprocess,'::father::');
	shared deletesuper := regexreplace('::qa::',filestoprocess,'::delete::');

	export ReadFileList := dataset('~'+filestoprocess,{string20 wuid, string100 files, boolean issuper, string cmd, string modified},thor,opt);

	//export maxWU := max(ReadFileList,wuid);
	
	export maxWU := if (last_wuid <> '', last_wuid, if(count(ReadFileList) > 0, max(ReadFileList,wuid), thorbackup.Constants.Yogurt().startwudaysbehind));

	export getMaxWU := if (maxWU > thorbackup.Constants.Yogurt().startwudaysbehind, maxWU, thorbackup.Constants.Yogurt().startwudaysbehind);

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
	
		results := SOAPCALL('http://'+thorbackup.Constants.esp.bocaprodthor+':8010/WsWorkunits', 'WUInfo', 
											InRecord, dataset(OutRecord),
											xpath('WUInfoResponse/Workunit')
										 );

		filenames := record
			string20 wuid := wid;
			string100 files := '';
			string30 modified;
		end;
	
		filenames norm_sources(results l, subfiles r) := transform
			self.files := r.name;//if (thorbackup.isPersist(r.name,'10.241.20.202'), r.name,'');
			self.modified := '';//fileservices.logicalfilelist(trim(r.name,left,right))[1].modified;
			self := l;
		end;
	
		filesused := sort(normalize(results,left.sourcefiles,norm_sources(left,right)),files);
	/*
		getfilelist := sort(fileservices.logicalfilelist(),name);
	
		filenames getmodified(getfilelist l, filesused_premod r) := transform
			self.modified := l.modified;
			self := r;
		end;
		
		filesused := join(getfilelist,filesused_premod,left.name = right.files,getmodified(left,right));
		*/
		fulllist := dedup(sort(filesused(~(files = ''
																				or regexfind('hpccinternal',files,nocase)
																				or regexfind('spill',files,nocase)
																				or regexfind('persist',files,nocase)
																				//or regexfind('::key::',files,nocase)
																				or regexfind('yogurt',files,nocase)
																				// or regexfind('foreign',files,nocase)
																				or regexfind(':: ',files,nocase)
																				or regexfind('thor::base::aidtemp',files,nocase)
																				or regexfind('__p[0-9]+$', files,nocase)
																				or regexfind('::temp::', files,nocase)
																				or regexfind('::nid::', files,nocase)
																				or regexfind('[/~()]', files,nocase)
																				or regexfind('10.173.231.12',files,nocase)
																				or regexfind('10.241.20.205',files,nocase)
																				or regexfind('10.241.50.45',files,nocase)
																				or regexfind('thor_data400::in::seq',files,nocase)
																				or regexfind('^file::.*$',files,nocase)
																				)) ,files),record);

		fullset := record
			string100 files;
			string30 modified;
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
			self.fnames := l.fnames + row({r.fnames[1].files,r.fnames[1].modified},fullset);
			self := l;
		end;
	
		rollout := rollup(proj_out,wuid,rolluprecs(left, right),local);	

		return rollout;
	end;
//-------------------------------------------

	
	export GetYogurtWUIDs := function
	
		wulist := lib_workunitservices.WorkunitServices.workunitlist
														(lowwuid := getMaxWU // get the WU that is 20 days old from now (OR)
																									// if the WU in the list from file is older than 20 days
																									// whichever is older
															, highwuid := thorbackup.constants.yogurt().endwu)
															(regexfind('yogurt',stringlib.StringToLowerCase(job)) and 
																~( job = 'Prep Yogurt Copy' 
																	//or wuid = maxWU 
																	or state in ['running','blocked'] ));
																	/*and
																	// in the compiled list get WU's
																	// that has last modified older than max WU (even though the WU was running
																	// and it finished after the last WU in compile list the WU will be picked.
																	(regexreplace('[^0-9]',modified,'') >= regexreplace('[^0-9]',MaxWU,''))
																)*/;
	
	
		lib_workunitservices.wsworkunitrecord getmodified(wulist l) := transform
			self.modified := thorbackup.GetWUModified(thorbackup.Constants.esp.bocaprodthor,l.wuid);
			self := l;
		end;
		
		return project(wulist,getmodified(left))(regexreplace('[^0-9]',modified,'') >= regexreplace('[^0-9]',MaxWU,''));
	end;

	export GetFileList(string wuid = '',boolean ignoreforeign = false) := function
		
		wuds := if (wuid <> '',dataset([{wuid,'','','','','','',0,'','',false,false}],lib_workunitservices.wsworkunitrecord),sort(GetYogurtWUIDs,-wuid));

		fullset := record
			string100 files;
			string30 modified;
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

		filesrec_flat_temp := record
			string20 wuid;
			string100 files;
			boolean issuper;
			string30 modified;
			string filepattern;
			string cmd;
			boolean isPersist := false;
		end;
		
		filesrec_flat_temp norm_recs(proj_out l,fullset r) := transform
			self.files := r.files;
			self.issuper := if (fileservices.superfileexists('~'+r.files),true,false);
			self.modified := r.modified;
			self.filepattern := regexreplace('[*]+',regexreplace('[-_]',regexreplace('[0-9]+',regexreplace('[0-9]+[a-z]',r.files,'*',nocase),'*',nocase),'*'),'*');
			self.cmd := thorbackup.constants.yogurt().serv 
									+ thorbackup.constants.yogurt().over 
									+ thorbackup.constants.yogurt().repl 
									+ thorbackup.constants.yogurt().action 
									+ thorbackup.constants.yogurt().dstcluster 
									+ 'dstname=~'+r.files 
									+ ' srcname=~'+r.files 
									+ thorbackup.constants.yogurt().nsplit 
									+ thorbackup.constants.yogurt().wrap 
									+ thorbackup.constants.yogurt().srcdali + ' compress=1';
			self := l;
		end;
		
		ds_flatten := //if (ignoreforeign,
															sort(normalize(proj_out,left.fnames,norm_recs(left,right)),files);
																			/*(~(files = ''
																				or regexfind('hpccinternal',files,nocase)
																				or regexfind('spill',files,nocase)
																				or regexfind('persist',files,nocase)
																				or regexfind('::key::',files,nocase)
																				or regexfind('yogurt',files,nocase)
																				//or regexfind('foreign',files,nocase)
																				or regexfind(':: ',files,nocase)
																				or regexfind('thor::base::aidtemp',files,nocase)
																				or regexfind('__p[0-9]+$', files,nocase)
																				or regexfind('::temp::', files,nocase)
																				or regexfind('::nid::', files,nocase)
																				or regexfind('[/~()]', files,nocase)
																				)),
															normalize(proj_out,left.fnames,norm_recs(left,right))
																			(~(files = ''
																				or regexfind('hpccinternal',files,nocase)
																				or regexfind('spill',files,nocase)
																				or regexfind('persist',files,nocase)
																				or regexfind('::key::',files,nocase)
																				or regexfind('yogurt',files,nocase)
																				or regexfind('foreign',files,nocase)
																				or regexfind(':: ',files,nocase)
																				or regexfind('thor::base::aidtemp',files,nocase)
																				or regexfind('__p[0-9]+$', files,nocase)
																				or regexfind('::temp::', files,nocase)
																				or regexfind('::nid::', files,nocase)
																				or regexfind('[/~()]', files,nocase)
																				))*/
														//	);
		
		getfilelist := sort(fileservices.logicalfilelist(),name);
	
		filesrec_flat_temp getmodified(getfilelist l, ds_flatten r) := transform
			self.isPersist := if (~r.issuper and r.files <> ''
																,thorbackup.isPersist(r.files,thorbackup.Constants.esp.bocaprodthor)
																,false
																);
			self.modified := l.modified;
			self := r;
		end;
		
		getmodifiedrecs := sort(join(getfilelist,ds_flatten,left.name = right.files,getmodified(left,right), right outer),files)(~isPersist);
		/*
		fullsuperlist := sort(fileservices.logicalfilesupersublist(),supername);
			
		
		filesrec_flat_temp getsuperexists(fullsuperlist l, getmodifiedrecs r) := transform
			self.issuper := if (trim(r.files,left,right) <> '', true, false);
			self := r;
		end;
		
		getsupers := join(fullsuperlist,getmodifiedrecs,
													left.supername = right.files,
													getsuperexists(left,right),
													right outer);
		*/
		
		filesrec_flat := record
			string20 wuid;
			string100 files;
			boolean issuper;
			string cmd;
			string modified;
		end;
		
		filesrec_flat slim_recs(getmodifiedrecs l) := transform
			self := l;
		end;
		
		// slim down to 4 files per pattern to copy.
		// don't have to copy all files over and over again
		// as we are keeping only 2-4 files anyways on backup thor
		slimmed_recs := project(dedup(sort(getmodifiedrecs,wuid,filepattern,-modified),wuid,filepattern,keep(4)),slim_recs(left)) : independent;
		
		return slimmed_recs;
		
	end;
	
	export GetFilePatternstoDelete(string wuid = '') := function
		ds := GetFileList(wuid)(~(regexfind('^file::',files)
															or regexfind('insuranceheader:name_count',files)
																				or files = ''));
		

		
		thorbackup.Layout_DeleteFilesInfo GetSupersWithOneSub(ds l) := transform
			superowner := if (fileservices.fileexists('~'+trim(l.files,left,right))
													,fileservices.logicalfilesuperowners('~'+trim(l.files,left,right))[1].name
													,''
													);
			self.name := if (superowner <> '',
													superowner,
													regexreplace('\\*',regexreplace('[*]+',regexreplace('[-_]',regexreplace('[0-9]+',regexreplace('[0-9]+[a-z]',l.files,'*',nocase),'*',nocase),'*'),'*'),'nosuper')
													);
			self.subname := l.files;
			self.hasmultiplesubs := false;//if(sname <> '',thorbackup.HasSupersWithMultipleSubs('~'+l.files),false);
			self.datetime := ut.GetDate + ut.getTime();
		end;												

		deletesubs := project(ds(~issuper),GetSupersWithOneSub(left));
		
		
		thorbackup.Layout_DeleteFilesInfo GetPatterns(deletesubs l) := transform
			self.subname := regexreplace('[*]+',regexreplace('[-_]',regexreplace('[0-9]+',regexreplace('[0-9]+[a-z]',l.subname,'*',nocase),'*',nocase),'*'),'*');
			self := l;
		end;
		
		deletepatterns := project(deletesubs(name <> ''),GetPatterns(left));
		
		thorbackup.Layout_DeleteFilesInfo CPatternSetup(deletepatterns l, thorbackup.ChangePatternSetup r) := transform
			self.name := l.name;
			self.subname := l.subname;
			self.hasmultiplesubs := if (r.name <> '', r.hasmultiplesubs, l.hasmultiplesubs);
			self.datetime := if (r.name <> '', r.datetime, l.datetime);
		end;
		
		GetCPatternSetup := join(deletepatterns,thorbackup.ChangePatternSetup,
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
													fileservices.addsuperfile('~'+filestoprocess,'~'+basename+location+'::'+environment+'::'+filedate+'::filestocopy'),
													fileservices.clearsuperfile('~'+filestodelete,true),
													fileservices.addsuperfile('~'+filestodelete,'~'+basename+location+'::'+environment+'::'+filedate+'::filestodelete')
													);
	

	
	export CreatePrepFile := sequential
																		(
																			CreateSupers,
																			output(GetFileList()(~issuper),,'~'+basename+location+'::'+environment+'::'+filedate+'::filestocopy',overwrite),
																			output(GetFilePatternstoDelete(),,'~'+basename+location+'::'+environment+'::'+filedate+'::filestodelete',overwrite)
																		);
	
	
	
	export UpdateSupers := sequential
																		(
																			CreateSupers,
																			MoveFiles
																	);
																
	export SendFileListToYogurtThor := sequential(
																					STD.File.DfuPlusExec(thorbackup.constants.yogurt('~'+filestoprocess).copyfilecmd),
																					STD.File.DfuPlusExec(thorbackup.constants.yogurt('~'+filestodelete).copyfilecmd)
																					);
	
	export ReSubmit() := function
	
		return output(
									dops.WorkUnitModule(thorbackup.Constants.esp.bocaprodthor,'8010').fSubmitNewWorkunit
													(
														'#workunit(\'name\',\'Backup Thor Files\');\r\n'+
														'thorbackup.PrepForYogurt(\''+location+'\',\''+environment+'\',\''+last_wuid+'\').run: WHEN(CRON(\'7 * * * *\'));'
														,'hthor'
													)
											);
	
	end;
	
	export run := if(count(GetYogurtWUIDs) > 0,
								if (~fileservices.fileexists('~yogurt::job::running'),																		
									sequential
										(
											
											output(getMaxWU,named('Start_WUID')),
											output(thorbackup.constants.yogurt().endwu,named('End_WUID')),
											output(MaxWU,named('Last_Captured_WUID')),
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
													ReSubmit(),
													fileservices.sendemail(thorbackup.constants.yogurt().emailerrors,
			environment + ' ' + location + ' Yogurt Prep Process failed on http://prod_esp:8010 - ' + filedate,
			'workunit: ' + workunit + '\n re-scheduled'+ '\r\n' + failmessage
																	,
																	,
																	,thorbackup.constants.yogurt().senderemail)));
	
end;