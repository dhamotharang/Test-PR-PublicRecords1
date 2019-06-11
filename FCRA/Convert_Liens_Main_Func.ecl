import Liensv2;

export Convert_Liens_Main_Func := function
	

ds :=  dataset('~thor_data400::base::override::fcra::qa::liensv2_main',FCRA.Layout_Override_Liens_Main_In,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);

FCRA.Layout_Override_Liensv2_main proj_func(ds l) := transform
	self.filing_status := row(l,Liensv2.layout_liens_main_module.layout_filing_status);
	//DF-23788 - field name is different in input layout and key layout
	self.satisifaction_type := l.satisfaction_type;
	self := l;
end;	

proj_out := dedup(sort(distribute(project(ds,proj_func(left)),hash(tmsid)),tmsid,rmsid,-flag_file_id,local),except flag_file_id,keep(1),local);

FCRA.Layout_Override_Liensv2_main tmakechildren(proj_out L, proj_out R) := transform

self.filing_status := L.filing_status + row({r.filing_status[1].filing_status, r.filing_status[1].filing_status_desc},liensv2.Layout_liens_main_module_for_hogan.layout_filing_status);
self := L;
end;

roll_out := rollup(proj_out, tmsid+rmsid, tmakechildren(left, right), local);


return roll_out;

end;