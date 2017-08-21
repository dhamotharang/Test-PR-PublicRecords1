export bheader_stats(getretval) := macro
import business_header,codes,ut,lib_fileservices,_Control;
myds_bheader := business_header.File_Business_Header_Base;

bheader_string_rec := record
	string inst := 'National';
	string exp_date := '';
end;

bheader_string_rec proj_recs_bheader(myds_bheader l) := transform
	self.exp_date := (string8)l.dt_last_seen;
	self := l;
end;

proj_out_bheader := project(myds_bheader,proj_recs_bheader(left));

Orbit_Report.Run_Stats('bheader',proj_out_bheader,inst,exp_date,'emailme','st',getretval,'true');

endmacro;
