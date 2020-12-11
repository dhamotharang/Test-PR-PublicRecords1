import orbit3, _control;

export build_orbit(string filedate) := FUNCTION

orbit_update := 	Orbit3.proc_Orbit3_CreateBuild('PRTE - Phone TCPA', filedate, 'PN', email_list:= _control.MyInfo.EmailAddressNormal);				 

Return orbit_update;

end;