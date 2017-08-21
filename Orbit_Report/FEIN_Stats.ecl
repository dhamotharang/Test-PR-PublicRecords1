export FEIN_stats(getretval) := macro
import DNB_FEINV2,codes,ut,lib_fileservices,_Control;
myds_fein := DNB_FEINV2.File_DNB_Fein_base_main(date_first_seen <> '');

air_string_rec := record
	string inst := 'National';
	string exp_date := '';
end;

air_string_rec proj_recs_air(myds_fein l) := transform
	self.exp_date := l.date_first_seen;
	self := l;
end;

proj_out_air := project(myds_fein,proj_recs_air(left));

Orbit_Report.Run_Stats('fein',proj_out_air,inst,exp_date,'emailme','st',getretval,'true');

endmacro;