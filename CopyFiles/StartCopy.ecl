import STD;
EXPORT StartCopy(string jobowner = thorlib.jobowner(), boolean clearsuper = false) := module

  export filelistsuper := '~thor::operational::copy::'+jobowner+'::qa::filelist';
	export deletesuper := '~thor::operational::copy::'+jobowner+'::delete::filelist';
	
	export filestocopy := fileservices.logicalfilelist('thor::operational::copy::filelist::'+jobowner+'*');

	filenames := record
			string20 wuid := '';
			string100 files := '';
			boolean issuper;
			boolean iscompressed;
			string cmd;
			string supername := '';
			integer subfilecount := 0;
			dataset(FsLogicalFileNameRecord) supernames;
		end;

	export GetFileListToCopy := dataset(filelistsuper,filenames,thor,opt);

	export CreateSupers := sequential(
													if (~fileservices.superfileexists('~'+filelistsuper),
														fileservices.createsuperfile('~'+filelistsuper)),
													if (~fileservices.superfileexists('~'+deletesuper),
														fileservices.createsuperfile('~'+deletesuper))
														);
	export Prep := nothor(
														apply(filestocopy,
																if (fileservices.FindSuperFileSubName(filelistsuper,'~'+name) = 0,
																		sequential
																			(
																			if (clearsuper,
																					fileservices.clearsuperfile(filelistsuper)),
																				fileservices.addsuperfile(filelistsuper, '~'+name)
																			)
																		)
															)
														);

	export CopyFiles := function
	
		return	sequential
											(
											nothor(apply(global(GetFileListToCopy(~issuper),few),
														sequential(
															if (~fileservices.fileexists('~'+files),
																	STD.File.DfuPlusExec(cmd)
																	),
																if (subfilecount > 0,
																		sequential
																		(	
																			if (~fileservices.superfileexists('~'+supername),
																				fileservices.createsuperfile('~'+supername)),
																			if (fileservices.FindSuperFileSubName('~'+supername,'~'+files) = 0,
																				if (subfilecount > 1,		
																					fileservices.addsuperfile('~'+supername,'~'+files),
																					sequential
																						(
																							fileservices.removeownedsubfiles('~'+supername,true),
																							fileservices.addsuperfile('~'+supername,'~'+files)
																						)
																					)
																				)
																		)
																	)
														 ))),
														 fileservices.addsuperfile(deletesuper,filelistsuper,,true),
														 fileservices.clearsuperfile(filelistsuper),
														 fileservices.clearsuperfile(deletesuper,true)
													);
	end;
	
	export rerun := CopyFiles;
	
	export run := if (~regexfind('hthor',thorlib.cluster(),nocase),
										fail('Run on hthor'),						
											sequential(
															CreateSupers,
															if (fileservices.GetSuperFileSubCount(filelistsuper) > 0,
																	output('Clear all subfiles in ' + filelistsuper + ' and re-run the job'),
																		sequential
																		(
																			Prep,
																			CopyFiles
																		)
																)
														)
											);

end;