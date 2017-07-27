import OSHAIR,Business_Header,Lib_AddrClean,lib_stringlib;;

export normalize_programs(string filedate) := FUNCTION

input_OSHAIR    := OSHAIR.File_in_OSHAIR;
program_cleaned := OSHAIR.layout_OSHAIR_program_clean;

/* Normalize the program sub-records */
program_cleaned normalize_program(input_OSHAIR L, OSHAIR.layout_OSHAIR_in_ASCII.OSHAIR_Program_Rec R) := TRANSFORM
   self.Activity_Number    := L.Activity_Number;
   self                    := R;
end;

ds_programs := normalize(input_OSHAIR,Left.Programs,normalize_program(LEFT,RIGHT));

return output(distribute(ds_Programs
                         ,hash32(ds_Programs.Activity_Number))
									,
		      ,'~thor_data400::base::oshair::' + filedate + '::program'
			  ,overwrite);

end;