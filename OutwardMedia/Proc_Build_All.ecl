IMPORT _control,ut,RoxieKeyBuild;

EXPORT proc_build_all(STRING version,STRING torun='ALL') := FUNCTION
  #workunit('name', 'OutwardMedia build')
	
	base_f := OutwardMedia.proc_build_base(version);
	
  ut.mac_sf_buildprocess(base_f,OutwardMedia.cluster+'base::outwardmedia',buildnewbasefile,3,,true);
		
  Sequential
	(
	  IF(torun IN ['ALL','BASE'],
		  Sequential
			(
			  buildnewbasefile,
				Proc_build_autokey(Version)),
		   output('Basefile Not Updated',NAMED('Basefile'))
		),
		IF(torun IN ['ALL','AUTOKEY'],OutwardMedia.proc_build_autokey(version),output('Autokey not generated',NAMED('Autokey'))),
		IF(torun IN ['ALL','STRATA'],OutwardMedia.proc_build_strata(version),output('Strata not generated',NAMED('Autokey'))),
		IF(torun IN ['ALL','STRATA'],OutwardMedia.Proc_build_strata_10Fields(version),output('Tenfieldsstrata not generated',NAMED('Autokey')))
	);

  RETURN 'BuildComplete';
END;
