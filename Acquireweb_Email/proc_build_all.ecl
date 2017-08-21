//-----------------------------------------------------------------------------
// Primary build process for the Acquireweb data.
// One parameter is required, which is the date of the file in YYYYMMDD format
// User may also pass a second parameter enabling the ability to specify only
// one of the processes to run:
//   BASE    : only recontruct the basefile from the raw inputs
//   AUTOKEY : Reconstruct the autokeys
//   STRATA  : Run the Strata statistics
//-----------------------------------------------------------------------------
IMPORT _control,ut,RoxieKeyBuild;

EXPORT proc_build_all(STRING version,STRING torun='ALL') := FUNCTION
  #workunit('name', 'Acquireweb build '+version)
	
  ut.mac_sf_buildprocess(Acquireweb_Email.proc_build_base(version),'~thor_data200::base::acquireweb',buildnewbasefile,3,,true)
	
  SEQUENTIAL
	(
	  IF(torun IN ['ALL','BASE'],
		  SEQUENTIAL
			(
			  buildnewbasefile,
		    fileservices.clearsuperfile('~thor::in::acquireweb::emails'),
		    fileservices.clearsuperfile('~thor::in::acquireweb::individuals')
			),OUTPUT('Basefile Not Updated',NAMED('Basefile'))
		),
		IF(torun IN ['ALL','AUTOKEY'],Acquireweb_Email.proc_build_autokey(version),OUTPUT('Autokey not generated',NAMED('Autokey'))),
		IF(torun IN ['ALL','STRATA'],Acquireweb_Email.proc_build_strata(version),OUTPUT('Strata not generated',NAMED('Strata')))
	);

  RETURN 'Done';
END;