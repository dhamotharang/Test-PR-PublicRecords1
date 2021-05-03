import orbit3, _control;

export build_orbit(string filedate) := FUNCTION

create_orbit_build := parallel(
																Orbit3.proc_Orbit3_CreateBuild('PRTE - DOCKeys', filedate, 'PN', email_list:= _control.MyInfo.EmailAddressNormal),
																Orbit3.proc_Orbit3_CreateBuild('PRTE - FCRA_DOCKeys', filedate, 'PF', email_list:= _control.MyInfo.EmailAddressNormal));

 return create_orbit_build;

end;