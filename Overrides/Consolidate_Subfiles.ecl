// Macro will combine files in full super

EXPORT Consolidate_SubFiles(in_layout, fullsuperfile, ret, testmode = 'true', iscsv = 'true', backup = 'true') := macro
	
	ret := sequential
						(
							if (backup,
								if (~fileservices.superfileexists(fullsuperfile+'_backup'),
									fileservices.createsuperfile(fullsuperfile+'_backup'))),
							if (iscsv,
								output(dataset(fullsuperfile,in_layout,csv(separator('\t'),quote('\"'),terminator('\r\n'))),,fullsuperfile+'_'+WORKUNIT,csv(separator('\t'),quote('\"'),terminator('\r\n')),overwrite),
								output(dataset(fullsuperfile,in_layout,thor),,fullsuperfile+'_'+WORKUNIT,overwrite)),
							if (~testmode,
								sequential(
									if (backup,
										fileservices.addsuperfile(fullsuperfile+'_backup',fullsuperfile,,true)),
									fileservices.clearsuperfile(fullsuperfile),
									fileservices.addsuperfile(fullsuperfile,fullsuperfile+'_'+WORKUNIT)
									),
							output('Running in testmode, hence no file movement')
								)
							);
		
endmacro;