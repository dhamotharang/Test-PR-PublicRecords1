export Correct_Misparsed_Names(string ver) := module

input_files := Files.File_In ;

corrected_misparsed_names := experiancred.fn_correct_misparsed_names(input_files);

Layouts.Layout_In t_reset_orig_names (corrected_misparsed_names le) := transform
	self.Surname          := le.reparsed_surname;
	self.First_Name		    := le.reparsed_first_name;			
	self.Middle_Name			:= le.reparsed_middle_name;			
	self.Generation_Code  := le.reparsed_generation;	

	self.Surname2				  := le.reparsed_surname2;	
	self.First_Name2			:= le.reparsed_first_name2;			
	self.Middle_Name2			:= le.reparsed_middle_name2;			
	self.Generation_Code2 := le.reparsed_generation2;	
	
	self.Surname3		      := le.reparsed_surname3;	 					
	self.First_Name3	    := le.reparsed_first_name3;							
	self.Middle_Name3		  := le.reparsed_middle_name3;					
	self.Generation_Code3 := le.reparsed_generation3;						

	self.Surname4	        := le.reparsed_surname4;							
	self.First_Name4	    := le.reparsed_first_name4;							
	self.Middle_Name4	    := le.reparsed_middle_name4;						
	self.Generation_Code4	:= le.reparsed_generation4;			
	self := le;
end;

reset_orig_names := project(corrected_misparsed_names, t_reset_orig_names(left));

export ALL := reset_orig_names;

END;