export FCC_stats(getretval) := macro
import FCC,codes,ut,lib_fileservices,_Control;
myds := fcc.File_FCC_base;

string_rec := record
	string inst := 'National';
	string exp_date := '';
end;

string_rec proj_recs(myds l) := transform
	self.exp_date := l.date_of_last_change;
	self := l;
end;

proj_out := project(myds,proj_recs(left));

Orbit_Report.Run_Stats('fcc',proj_out,inst,exp_date,'emailme','st',getretval,'true');

endmacro;
