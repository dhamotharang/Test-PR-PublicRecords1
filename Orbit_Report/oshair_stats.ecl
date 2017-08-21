export oshair_stats(getretval) := macro
import oshair,codes,ut,lib_fileservices,_Control;
myds := oshair.file_out_inspection_cleaned;

string_rec := record
	string st := 'National';
	string exp_date := '';
end;

string_rec proj_recs(myds l) := transform
	self.exp_date := (string)l.inspection_opening_date;
	
end;

proj_out := project(myds,proj_recs(left));

Orbit_Report.Run_Stats('oshair',proj_out,st,exp_date,'emailme','st',getretval,'true');

endmacro;
