IMPORT _control,ut,RoxieKeyBuild;

EXPORT proc_build_all(STRING version,STRING torun='ALL') := FUNCTION
  #workunit('name', 'Yogurt: Mediaone build')
	
  ut.mac_sf_buildprocess(Mediaone.proc_build_base(version),'~thor::base::mediaone',buildnewbasefile,3,,true);
	
  SEQUENTIAL
	(
	  IF(torun IN ['ALL','BASE'],
		  SEQUENTIAL
			(
			  buildnewbasefile,
		    fileservices.clearsuperfile('~thor::in::mediaone')
			),OUTPUT('Basefile Not Updated',NAMED('Basefile'))
		),
		IF(torun IN ['ALL','AUTOKEY'],Mediaone.proc_build_autokey(version),OUTPUT('Autokey not generated',NAMED('Autokey'))),
		IF(torun IN ['ALL','STRATA'],Mediaone.proc_build_strata(version),OUTPUT('Strata not generated',NAMED('Strata')))
	);

  RETURN 'Done';
END;