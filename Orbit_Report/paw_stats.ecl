export paw_stats(getretval) := macro
import PAW,codes,ut,lib_fileservices,_Control;
myds := PAW.File_Base;

string_rec := record
	string st := 'National';
	string rep_date := '';
end;

string_rec proj_recs(myds l) := transform
	self.rep_date := ((string)l.dt_last_seen)[5..8] + ((string)l.dt_last_seen)[3..4] + ((string)l.dt_last_seen)[1..2];
	self := l;
end;

proj_out := project(myds,proj_recs(left));

Orbit_Report.Run_Stats('paw',proj_out,st,rep_date,'emailme','st',getretval,'true');

endmacro;
