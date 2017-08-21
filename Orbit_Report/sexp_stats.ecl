export sexp_stats(getretval) := macro
import sexoffender,codes,ut,lib_fileservices,_Control;
myds := sexoffender.file_Main;

string_rec := record
	string inst := 'National';
	string exp_date := '';
end;

string_rec proj_recs(myds l) := transform
	self.exp_date := l.dt_last_reported;
	self := l;
end;

proj_out := project(myds,proj_recs(left));

Orbit_Report.Run_Stats('sexp',proj_out,inst,exp_date,'emailme','st',getretval,'true');

endmacro;
