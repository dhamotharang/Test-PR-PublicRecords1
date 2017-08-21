export txbus_stats(getretval) := macro
import txbus,codes,ut,lib_fileservices,_Control;
myds := txbus.File_Txbus_Base;

string_rec := record
	string state := 'TX';
	string mydate := '';
end;

string_rec proj_recs(myds l) := transform
	self.mydate := l.Outlet_Permit_Issue_Date;
	self := l;
end;

proj_out := project(myds,proj_recs(left));

Orbit_Report.Run_Stats('txbus',proj_out,state,mydate,'emailme','st',getretval);

endmacro;