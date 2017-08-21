import OSHAIR,Business_Header,Address,lib_stringlib,ut;

export normalize_programs(string filedate, string process_date) := FUNCTION

StrategicCodes := oshair.files().input.StrategicCodes.sprayed;

program_cleaned := OSHAIR.layout_OSHAIR_program_clean;

program_cleaned normalize_program(StrategicCodes L) := TRANSFORM
   self.dt_first_seen 						:=  (unsigned4)process_date;
	 self.dt_last_seen  						:=  (unsigned4)process_date;
	 self.dt_vendor_first_reported 	:=  (unsigned4)process_date;
	 self.dt_vendor_last_reported 	:=  (unsigned4)process_date;
   self.Activity_Number	:=	(integer)l.activity_nr;
   self.program_type		:=	l.prog_type;
   self.program_value		:=	l.prog_value;
end;

ds_programs 	:= 	project(StrategicCodes,normalize_program(LEFT));

dsAllPrograms	:=	distribute((OSHAIR.file_out_program_cleaned + ds_programs),hash32(Activity_Number));

OSHAIR.layout_OSHAIR_program_clean RollupPrograms(OSHAIR.layout_OSHAIR_program_clean l, OSHAIR.layout_OSHAIR_program_clean r) := transform
  self.dt_first_seen  := ut.EarliestDate(l.dt_first_seen ,r.dt_first_seen	);  
	self.dt_last_seen 	:= ut.LatestDate  (l.dt_last_seen	 ,r.dt_last_seen	);
	self.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported	,r.dt_vendor_first_reported	);	
  self.dt_vendor_last_reported 	:= ut.LatestDate	(l.dt_vendor_last_reported	,r.dt_vendor_last_reported	);
	self := l;
end;

ProgramsRollup	:= rollup(sort(dsAllPrograms,record, except dt_first_seen,dt_last_seen, 
														  dt_vendor_first_reported, dt_vendor_last_reported, local)
										, RollupPrograms(left, right), record
										,except dt_first_seen, dt_last_seen, 
														dt_vendor_first_reported, dt_vendor_last_reported
										, local);

return output(ProgramsRollup,,'~thor_data400::base::oshair::' + filedate + '::program',overwrite);

end;