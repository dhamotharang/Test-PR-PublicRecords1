export edata_stats(getretval) := macro
import email_data,codes,ut,lib_fileservices,_Control;
myds_edata := email_data.File_Email_Base;

edata_string_rec := record
	string inst := 'National';
	string exp_date := '';
end;

edata_string_rec proj_recs_edata(myds_edata l) := transform
	self.exp_date := l.process_date;
	self := l;
end;

proj_out_edata := project(myds_edata,proj_recs_edata(left));

Orbit_Report.Run_Stats('edata',proj_out_edata,inst,exp_date,'emailme','st',getretval,'true');

endmacro;
