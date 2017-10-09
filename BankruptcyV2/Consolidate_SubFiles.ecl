// Macro will combine files in full super

EXPORT Consolidate_SubFiles(in_layout, fullsuperfile, iscsv, ret) := macro
	
	ret := sequential
						(
							if (~fileservices.superfileexists(fullsuperfile+'_father'),
								fileservices.createsuperfile(fullsuperfile+'_father')),
							if (~fileservices.superfileexists(fullsuperfile+'_delete'),
								fileservices.createsuperfile(fullsuperfile+'_delete')),
							if (iscsv,
								output(dataset(fullsuperfile,in_layout,csv(quote('\"'))),,fullsuperfile+'_'+WORKUNIT,csv(quote('\"')),COMPRESSED,overwrite),
								output(dataset(fullsuperfile,in_layout,thor),,fullsuperfile+'_'+WORKUNIT,COMPRESSED,overwrite)),
							fileservices.startsuperfiletransaction(),
							fileservices.addsuperfile(fullsuperfile+'_delete',fullsuperfile+'_father',,true),
							fileservices.clearsuperfile(fullsuperfile+'_father'),
							fileservices.addsuperfile(fullsuperfile+'_father',fullsuperfile,,true),
							fileservices.clearsuperfile(fullsuperfile),
							fileservices.addsuperfile(fullsuperfile,fullsuperfile+'_'+WORKUNIT),
							fileservices.FinishSuperFileTransaction(),
							fileservices.RemoveOwnedSubFiles(fullsuperfile+'_delete',true),
							fileservices.clearsuperfile(fullsuperfile+'_delete')
							);
		
endmacro;