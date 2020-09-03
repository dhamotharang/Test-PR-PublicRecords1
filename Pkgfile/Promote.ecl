EXPORT Promote(string clustername = '') := module
	// Promote newly created files into backup superfile, maintains
	// configs.noofgenerations (defaulted to 10) 
	export Backup(string filetype, string p_filename = '') := function
	
		return	if (~fileservices.fileexists(files(filetype, clustername).backupfile),
									fileservices.createsuperfile(files(filetype, clustername).backupfile),
									if (~fileservices.fileexists(files(filetype, clustername).pfile),
										fileservices.createsuperfile(files(filetype, clustername).pfile),
						
										sequential
										(
											fileservices.StartSuperFileTransaction(),
											if (fileservices.getsuperfilesubcount(files(filetype, clustername).backupfile) >= configs().generations,
												fileservices.RemoveSuperFile(files(filetype, clustername).backupfile,'~'+fileservices.getsuperfilesubname(files(filetype, clustername).backupfile,1),true)
												),
											if (fileservices.FindSuperFileSubName(files(filetype, clustername).backupfile, files(filetype, clustername).pfile) = 0
												,fileservices.addsuperfile(files(filetype, clustername).backupfile, files(filetype, clustername).pfile,,true)
												),
											fileservices.clearsuperfile(files(filetype, clustername).pfile),
											if (p_filename <> '',
													fileservices.addsuperfile(pkgfile.files(filetype, clustername).pfile, p_filename)),
											fileservices.FinishSuperFileTransaction()
											)
										)
							);
	end;
	// Promote newly created files into backup superfile
	// filetype = 'flat' or 'xml'
	export New(l_Dataset, filetype, filepromoted, fileversion) := macro
		#uniquename(pkgfileversion)
		%pkgfileversion% := if (fileservices.fileexists(pkgfile.files(filetype, clustername).pfile+fileversion),WORKUNIT[2..]+RANDOM(),fileversion) : independent;
		filepromoted := sequential(
									if (filetype = 'xml',
									output(l_Dataset,,pkgfile.files(filetype, clustername).pfile+%pkgfileversion%,xml('Package',heading('<RoxiePackages>\n','</RoxiePackages>\n'),OPT),overwrite),
									output(l_Dataset,,pkgfile.files(filetype, clustername).pfile+%pkgfileversion%,overwrite)
									),
								pkgfile.Promote(clustername).backup(filetype,pkgfile.files(filetype, clustername).pfile+%pkgfileversion%)
								
						);
	endmacro;
	
	
end;