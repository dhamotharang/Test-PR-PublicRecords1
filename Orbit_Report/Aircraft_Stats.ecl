export Aircraft_stats(getretval) := macro
import FAA,codes,ut,lib_fileservices,_Control;
myds_air := faa.file_aircraft_registration_out;

air_string_rec := record
	string inst := 'National';
	string exp_date := '';
end;

air_string_rec proj_recs_air(myds_air l) := transform
	self.exp_date := l.last_action_date;
	self := l;
end;

proj_out_air := project(myds_air,proj_recs_air(left));

Orbit_Report.Run_Stats('aircraft',proj_out_air,inst,exp_date,'emailme','st',getretval,'true');

endmacro;
