export calbus_stats(getretval) := macro
import calbus,codes,ut,lib_fileservices,_Control;
myds := calbus.File_Calbus_Base;

string_rec := record
	string state := 'CA';
	string mydate := '';
end;

string_rec proj_recs(myds l) := transform
	self.mydate := l.start_date;
	self := l;
end;

proj_out := project(myds,proj_recs(left));

Orbit_Report.Run_Stats('calbus',proj_out,state,mydate,'emailme','st',getretval);

endmacro;