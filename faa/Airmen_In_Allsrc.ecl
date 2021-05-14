EXPORT Airmen_In_Allsrc :=  module

export File_In_pilot := dataset('~thor_data400::in::faa::airmen_pilot',faa.layouts.airmen.pilotraw,thor);
export File_In_certificate := dataset('~thor_data400::in::faa::airmen_certificate',layout_airmen_certificate.v1,thor);

//JIRA DF-27328 - the nonpilot file is now coming in as a variable length instead of fixed
file_In_nonpilot_raw := dataset('~thor_data400::in::faa::airmen_nonpilot',{string215 line},csv( heading(0),separator(''),Terminator(['\n','\r\n']),Quote('')));

faa.layouts.airmen.nonpilotraw convert_to_fixed (file_In_nonpilot_raw input) := transform
   self.letter_code := input.line[..1];
   self.unique_id		:= input.line[2..8];	
   self.orig_rec_type 	:= input.line[9..10];
   self.orig_fname	:= input.line[11..40];
   self.orig_lname := input.line[41..70];
   self.street1 := input.line[71..103];
   self.street2 := input.line[104..136];
   self.city := input.line[137..153];
   self.state := input.line[154..155];
   self.zip_code := input.line[156..165];
   self.country := input.line[166..183];
   self.region := input.line[184..185];
   self.med_class := input.line[186..186];
   self.med_date := input.line[187..192];
   self.med_exp_date := input.line[193..198];
   self.basic_med_course_date := input.line[199..206];
   self.basic_med_cmec_date := input.line[207..214];    
   self := [];	
end;

export File_In_nonpilot := project(file_In_nonpilot_raw, convert_to_fixed(LEFT));

end;