export sanctn_stats(getretval) := macro
import sanctn,codes,ut,lib_fileservices,_Control;
myds := SANCTN.file_out_incident_cleaned;

string_rec := record
	string st := 'National';
	string exp_date := '';
end;

string_rec proj_recs(myds l) := transform
	self.exp_date := l.incident_date_clean;
	self := l;
end;

proj_out := project(myds,proj_recs(left));

Orbit_Report.Run_Stats('sanctn',proj_out,st,exp_date,'emailme','st',getretval,'true');

endmacro;
