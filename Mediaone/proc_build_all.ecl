IMPORT _control,ut,RoxieKeyBuild,Orbit3;

EXPORT proc_build_all(STRING version,STRING torun='ALL') := FUNCTION
  #workunit('name', 'Yogurt: Mediaone build')
	
  ut.mac_sf_buildprocess(Mediaone.proc_build_base(version),'~thor::base::mediaone',buildnewbasefile,3,,true);
	
	orbit_update := Orbit3.Proc_Orbit3_CreateBuild_npf('Mediaone',version);
	
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
		IF(torun IN ['ALL','STRATA'],Mediaone.proc_build_strata(version),OUTPUT('Strata not generated',NAMED('Strata'))),
		orbit_update
	);

  RETURN 'Done';
END;