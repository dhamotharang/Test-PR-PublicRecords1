export Airmen_stats(getretval) := macro
import FAA,codes,ut,lib_fileservices,_Control;
myds := faa.file_airmen_certificate_out;

string_rec := record
	string st := 'National';
	string exp_date := '';
end;

string_rec proj_recs(myds l) := transform
	self.exp_date := l.cer_exp_date[5..8] + l.cer_exp_date[3..4] + l.cer_exp_date[1..2];
	self := l;
end;

proj_out := project(myds,proj_recs(left));

Orbit_Report.Run_Stats('airmen',proj_out,st,exp_date,'emailme','st',getretval,'true');

endmacro;
