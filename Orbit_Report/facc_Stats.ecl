export facc_stats(getretval) := macro
import FLAccidents_Ecrash,codes,ut,lib_fileservices,_Control;
myds := pull(FLAccidents_Ecrash.key_EcrashV2_accnbrv1 (report_code = 'FA'));

string_rec := record
	string state := 'FL';
	string mydate := '';
end;

string_rec proj_recs(myds l) := transform
	self.mydate := l.accident_date;
	self := l;
end;

proj_out := project(myds,proj_recs(left));

Orbit_Report.Run_Stats('facc',proj_out,state,mydate,'emailme','st',getretval);

endmacro;


