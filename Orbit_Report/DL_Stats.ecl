export DL_Stats(getretval) := macro

import Driversv2,codes,ut,lib_fileservices,_Control;

#uniquename(myds)
%myds% := Driversv2.File_DL;

#uniquename(my_recs)
%my_recs% := record
	string2 my_orig_state;
	string8 my_lic_issue_date;
end;

#uniquename(proj_recs)
%my_recs% %proj_recs%(%myds% l) := transform
self.my_orig_state := l.orig_state;
self.my_lic_issue_date := (string8)l.lic_issue_date;
end;

#uniquename(proj_out)
%proj_out% := project(%myds%(lic_issue_date != 0),%proj_recs%(left));

Orbit_Report.Run_Stats('dl',%proj_out%,my_orig_state,my_lic_issue_date,'emailme','st',getretval);

endmacro;

