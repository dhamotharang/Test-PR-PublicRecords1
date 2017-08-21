IMPORT _control,ut,RoxieKeyBuild;

//TODO - not sure if CT needs phase1 autokeys at all... and almost sure we do not need statistics and strata

EXPORT z_p1_proc_build_all_ORIG(STRING version,STRING torun='ALL') := FUNCTION
  #workunit('name', 'PRTE2_Email build')
  ut.mac_sf_buildprocess(p1_build_base.(version),_constants.phase1SuperFileString,buildnewbasefile,3,,true);
	
  SEQUENTIAL
	(
	  IF(torun IN ['ALL','BASE'],
		  SEQUENTIAL
			(
			  buildnewbasefile,
		    fileservices.clearsuperfile(_constants.phase1SuperFileString)
			),OUTPUT('Basefile Not Updated',NAMED('Basefile'))
		),
		IF(torun IN ['ALL','AUTOKEY'],p1_build_autokey(version),OUTPUT('Autokey not generated',NAMED('Autokey'))),
		IF(torun IN ['ALL','STRATA'],p1_procs_ORIG.build_strata(version),OUTPUT('Strata not generated',NAMED('Strata')))
	);

  RETURN 'Done';
END;