export areport_stats(getretval) := macro
import FLAccidents,codes,ut,lib_fileservices,_Control;
myds_areport := FLAccidents.BaseFile_NtlAccidents_Alpharetta;

areport_string_rec := record
	string inst := 'National';
	string exp_date := '';
end;

areport_string_rec proj_recs_areport(myds_areport l) := transform
	self.exp_date := l.loss_date[7..10] + l.loss_date[1..2] + l.loss_date[4..5];
	self := l;
end;

proj_out_areport := project(myds_areport,proj_recs_areport(left));

Orbit_Report.Run_Stats('areport',proj_out_areport,inst,exp_date,'emailme','st',getretval,'true');

endmacro;
