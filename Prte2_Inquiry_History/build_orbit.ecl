﻿import orbit3, _control;

export build_orbit(string filedate) := FUNCTION

create_orbit_build := Orbit3.proc_Orbit3_CreateBuild('PRTE - FCRA_InquiryHistoryKeys', filedate, 'PF', email_list:= _control.MyInfo.EmailAddressNormal);
															
 return create_orbit_build;

end;