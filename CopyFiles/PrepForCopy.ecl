import ut, STD;
export PrepForCopy(string sourceespip, string destespip, string destcluster, string srcdali, string jobowner = thorlib.jobowner()) := module
	
	export getsuperlist := sort(Fileservices.LogicalFileSuperSubList()(~regexfind('insuranceheader:name_count',supername)), subname);

	export GetFilesByWU(string wid) := function
	
		InRecord := record
			string Name{xpath('Wuid')} := wid;
		end;

	
		subfiles := record
			string100 name {XPATH('Name')} := '';
			//string100 issuper {XPATH('IsSuperFile')} := '';
		end;

	
		resultnames := record
			string100 name {XPATH('FileName')} := '';
		end;

	
		OutRecord := record,maxlength(300000)
			string20 Wuid{xpath('Wuid')};
			dataset(subfiles) sourcefiles{xpath('SourceFiles/ECLSourceFile')};
			//dataset(resultnames) resultfiles{xpath('Results/ECLResult')};
		end;
	
		results := SOAPCALL('http://'+sourceespip+':8010/WsWorkunits', 'WUInfo', 
											InRecord, dataset(OutRecord),
											xpath('WUInfoResponse/Workunit')
											,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues())
										 );
		filenames := record
			string20 wuid := wid;
			string100 files := '';
			boolean issuper;
			boolean iscompressed;
			string cmd;
			string supername := '';
			integer subfilecount := 0;
			dataset(FsLogicalFileNameRecord) supernames;
			
		end;
	
		
		filenames norm_sources(results l, subfiles r) := transform
			l_issuper := if (fileservices.superfileexists('~'+r.name),true,false);
			l_iscomp := if(~l_issuper, ut.isCompressed('~'+r.name),false);
			self.files := r.name;//if (copyfiles.isPersist(r.name,'10.241.20.202'), r.name,'');
			self.issuper := l_issuper;
			self.iscompressed := l_iscomp;
			self.cmd := if (~l_issuper,
															if (l_iscomp,
																	copyfiles.constants(destespip, destcluster, srcdali).dfuinfo.serv 
									+ copyfiles.constants(destespip, destcluster, srcdali).dfuinfo.over 
									+ copyfiles.constants(destespip, destcluster, srcdali).dfuinfo.repl 
									+ copyfiles.constants(destespip, destcluster, srcdali).dfuinfo.action 
									+ copyfiles.constants(destespip, destcluster, srcdali).dfuinfo.dstcluster 
									+ 'dstname=~'+r.name 
									+ ' srcname=~'+r.name 
									+ copyfiles.constants(destespip, destcluster, srcdali).dfuinfo.nsplit 
									+ copyfiles.constants(destespip, destcluster, srcdali).dfuinfo.wrap 
									+ copyfiles.constants(destespip, destcluster, srcdali).dfuinfo.srcdali + ' compress=1',
													copyfiles.constants(destespip, destcluster, srcdali).dfuinfo.serv 
									+ copyfiles.constants(destespip, destcluster, srcdali).dfuinfo.over 
									+ copyfiles.constants(destespip, destcluster, srcdali).dfuinfo.repl 
									+ copyfiles.constants(destespip, destcluster, srcdali).dfuinfo.action 
									+ copyfiles.constants(destespip, destcluster, srcdali).dfuinfo.dstcluster 
									+ 'dstname=~'+r.name 
									+ ' srcname=~'+r.name 
									+ copyfiles.constants(destespip, destcluster, srcdali).dfuinfo.nsplit 
									+ copyfiles.constants(destespip, destcluster, srcdali).dfuinfo.wrap 
									+ copyfiles.constants(destespip, destcluster, srcdali).dfuinfo.srcdali
																	),
																	''
																);
			self.supernames := if (~l_issuper,if (fileservices.fileexists('~'+r.name),
																		fileservices.logicalfilesuperowners('~'+r.name),
																		dataset([],FsLogicalFileNameRecord)
																		),dataset([],FsLogicalFileNameRecord));
			//self.modified := fileservices.logicalfilelist(trim(r.name,left,right))[1].modified;
			self := l;
			
		end;
	
		filesusedfull := sort(normalize(results,left.sourcefiles,norm_sources(left,right))(~(files = ''
																				or regexfind('hpccinternal',files,nocase)
																				or regexfind('spill',files,nocase)
																				or regexfind('persist',files,nocase)
																				or regexfind('thor_data400::base::insuranceheader:name_count',files,nocase)
																				or regexfind('aidtemp',files,nocase))
																				//or supernames(regexfind('thor_data400::base::insuranceheader:name_count',name,nocase))
																				), files);
		
		filesused := filesusedfull(count(supernames) > 0);
		
		fileusednocount := filesusedfull(count(supernames) < 1);
		
		filenames norm_supers(filesused l, FsLogicalFileNameRecord r) := transform
			self.supername := r.name;
			self.subfilecount := if (trim(r.name,left,right) <> '',
																	if (~regexfind('insuranceheader:name_count',r.name,nocase),
																			fileservices.GetSuperFileSubCount('~'+r.name),
																			l.subfilecount
																			),
																	l.subfilecount);
			//self.modified := fileservices.logicalfilelist(trim(r.name,left,right))[1].modified;
			self := l;
			
		end;
		
		getrecswithsuper := normalize(filesused,left.supernames,norm_supers(left,right))(~regexfind('insuranceheader:name_count',supername,nocase));
		
		
		return getrecswithsuper + fileusednocount;
	end;
	
	export CopyFileList(string wid) := if (~regexfind('hthor',thorlib.cluster(),nocase),
																		fail('Run on hthor'),
															sequential(
																 output(GetFilesByWU(wid),,'~thor::operational::copy::filelist::'+jobowner+'::'+WORKUNIT,overwrite),
																 STD.File.DfuPlusExec(copyfiles.constants(destespip, destcluster, srcdali).dfuinfo.serv 
									+ copyfiles.constants(destespip, destcluster, srcdali).dfuinfo.over 
									+ copyfiles.constants(destespip, destcluster, srcdali).dfuinfo.repl 
									+ copyfiles.constants(destespip, destcluster, srcdali).dfuinfo.action 
									+ copyfiles.constants(destespip, destcluster, srcdali).dfuinfo.dstcluster 
									+ 'dstname='+'~thor::operational::copy::filelist::'+jobowner+'::'+WORKUNIT 
									+ ' srcname='+'~thor::operational::copy::filelist::'+jobowner+'::'+WORKUNIT 
									+ copyfiles.constants(destespip, destcluster, srcdali).dfuinfo.nsplit 
									+ copyfiles.constants(destespip, destcluster, srcdali).dfuinfo.wrap 
									+ copyfiles.constants(destespip, destcluster, srcdali).dfuinfo.srcdali),
									fileservices.deletelogicalfile('~thor::operational::copy::filelist::'+jobowner+'::'+WORKUNIT)));
	
end;