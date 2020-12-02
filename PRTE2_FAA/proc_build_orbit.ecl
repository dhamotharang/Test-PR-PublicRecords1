import orbit3, _control;

export proc_build_orbit(string filedate) := FUNCTION

orbit_update := parallel(Orbit3.proc_Orbit3_CreateBuild('PRTE - FAAKeys', filedate, 'PN', email_list:= _control.MyInfo.EmailAddressNormal),
                         Orbit3.proc_Orbit3_CreateBuild('PRTE - FCRA_FAAKeys', filedate, 'PF', email_list:= _control.MyInfo.EmailAddressNormal));
												 
												 
Return orbit_update;
end;