file_in := Fictitious_Business_Names.File_Clean_NameAddress;

Fictitious_Business_Names.Layout_Cleaned_File xform(file_in l) := Transform
	self.CCT1_Clean_title						:= l.clean_cleaned_name[1..5]			  ;
	self.CCT1_Clean_fname						:= l.clean_cleaned_name[6..25]			;
	self.CCT1_Clean_mname						:= l.clean_cleaned_name[26..45]		  ;
	self.CCT1_Clean_lname						:= l.clean_cleaned_name[46..65]		  ;
	self.CCT1_Clean_name_suffix	    := l.clean_cleaned_name[66..70]		  ;
	self.CCT1_Clean_cleaning_score		:= l.clean_cleaned_name[71..73]		  ;
	self.CCT2_Clean_title						:= l.clean_cleaned_name_2[1..5]			;
	self.CCT2_Clean_fname						:= l.clean_cleaned_name_2[6..25]		;
	self.CCT2_Clean_mname						:= l.clean_cleaned_name_2[26..45]		;
	self.CCT2_Clean_lname						:= l.clean_cleaned_name_2[46..65]		;
	self.CCT2_Clean_name_suffix	    := l.clean_cleaned_name_2[66..70]		;
	self.CCT2_Clean_cleaning_score		:= l.clean_cleaned_name_2[71..73]		;
	self :=l;
end;
export Cleaned_File := Project(file_in,xform(left)) : persist('persist::Ficititious_Business_Names::Cleaned_File');