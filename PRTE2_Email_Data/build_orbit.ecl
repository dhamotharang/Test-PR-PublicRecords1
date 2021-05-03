import orbit3, _control;

export build_orbit(string filedate) := FUNCTION

orbit_update := parallel(Orbit3.proc_Orbit3_CreateBuild('PRTE - EmailDataKeys', filedate, 'PN', email_list:= _control.MyInfo.EmailAddressNormal),
                         Orbit3.proc_Orbit3_CreateBuild('PRTE - FCRA_EmailDataKeys', filedate, 'PF', email_list:= _control.MyInfo.EmailAddressNormal));
												 
												 
Return orbit_update;
end;