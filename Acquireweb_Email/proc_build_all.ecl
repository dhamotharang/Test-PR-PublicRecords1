//-----------------------------------------------------------------------------
// Primary build process for the Acquireweb data.
// One parameter is required, which is the date of the file in YYYYMMDD format
// User may also pass a second parameter enabling the ability to specify only
// one of the processes to run:
//   BASE    : only recontruct the basefile from the raw inputs
//   AUTOKEY : Reconstruct the autokeys
//   STRATA  : Run the Strata statistics
//-----------------------------------------------------------------------------
IMPORT _control,ut,RoxieKeyBuild,Orbit3,PromoteSupers, Acquireweb_Plus;

EXPORT proc_build_all(STRING version,STRING torun='ALL') := FUNCTION
  #workunit('name', 'Yogurt:Acquireweb build');
	
  PromoteSupers.mac_sf_buildprocess(Acquireweb_Email.proc_build_base(version),'~thor_data200::base::acquireweb',buildnewbasefile,3,,true)

	create_orbit_build:= Orbit3.Proc_Orbit3_CreateBuild_npf ('AcquireWeb',version);
	
  SEQUENTIAL
	(
	  IF(torun IN ['ALL','BASE'],
		  SEQUENTIAL
			(
			  buildnewbasefile,
				Acquireweb_Plus.Proc_build_business_base(version),
		    fileservices.clearsuperfile('~thor::in::acquireweb::emails'),
		    fileservices.clearsuperfile('~thor::in::acquireweb::individuals'),
				fileservices.clearsuperfile('~thor::in::acquireweb::business'),
		    fileservices.clearsuperfile('~thor::in::acquireweb::ipaddress')
			),OUTPUT('Basefile Not Updated',NAMED('Basefile'))
		),
		IF(torun IN ['ALL','AUTOKEY'],Acquireweb_Email.proc_build_autokey(version),OUTPUT('Autokey not generated',NAMED('Autokey'))),
		IF(torun IN ['ALL','STRATA'],Acquireweb_Email.proc_build_strata(version),OUTPUT('Strata not generated',NAMED('Strata'))),
		create_orbit_build
	);

  RETURN 'Done';
END;