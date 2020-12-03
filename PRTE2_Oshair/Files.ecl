Import Oshair,address;
EXPORT files := module

EXPORT Accident_IN := DATASET(constants.In_Accident, Layouts.Accident, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );

Export Accident_base:= DATASET(constants.Base_Accident, Layouts.Accident, FLAT );

EXPORT Inspection_IN := DATASET(constants.In_Inspection, Layouts.Inspection, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );

Export Inspection_base:= DATASET(constants.Base_Inspection, Layouts.layout_OSHAIR_inspection_clean_BIP_Ext, FLAT );

EXPORT Violations_IN := DATASET(constants.In_Violations, Layouts.Violations, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
Export Violations_base:= DATASET(constants.Base_Violations, Layouts.Violations, FLAT );

EXPORT Substance_IN := DATASET(constants.In_Substance, Layouts.Substance, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
Export Substance_base:= DATASET(constants.Base_Substance, Layouts.Substance, FLAT );

EXPORT Program_IN := DATASET(constants.In_Program, Layouts.Program, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
Export Program_base:= DATASET(constants.Base_Program, Layouts.Program, FLAT );


//program
Export f_oshair_program:=project(program_base,
Transform(layouts.layout_OSHAIR_program_clean,
self:=LEFT; 
self:=[];
));

slimLayout_program	:=	record
		layouts.layout_OSHAIR_program_clean	 
		  - dt_first_seen	- dt_last_seen						 
			- dt_vendor_first_reported - dt_vendor_last_reported;	  
end;

export NewKeyBuild_program	:=	project(f_oshair_program, TRANSFORM(slimLayout_program,SELF := LEFT;));

export NewKeyBuild_program2	:=	project(NewKeyBuild_program,
                                TRANSFORM(layouts.program2,
																	self:=LEFT; 
                                  self:=[];
                                  ));


//accident
Export f_oshair	:=	Project(accident_Base,
Transform(layouts.layout_OSHAIR_accident_clean,
self:=LEFT; 
self:=[];
));

shared slimLayout	:=	record
		layouts.layout_OSHAIR_accident_clean	 
		  - dt_first_seen	- dt_last_seen						 
			- dt_vendor_first_reported - dt_vendor_last_reported;	  
end;

slimLayout ClnAddr(f_oshair l) := TRANSFORM
	tempName 								:= Address.CleanPersonFML73_fields(L.name);
	self.victim.title	:=			tempName.title;
	 self.victim.fname							:= tempName.fname;
	 self.victim.mname							:= tempName.mname;
	 self.victim.lname	:=					tempName.lname;
	 self.victim.name_suffix:=				tempName.name_suffix;
	 self.victim.name_score:= tempName.name_score;
 self := L;
 SELF := [];
	end;
export NewKeyBuild_Accident	:= PROJECT(f_oshair, ClnAddr(LEFT));

Export NewKeyBuild_Accident2:=project(NewKeyBuild_Accident,
Transform(layouts.accident2,
Self:=Left;
self := []; 
));

//export NewKeyBuild_Accident2:=project(NewKeyBuild_Accident,layouts.accident2);


//inspection
export file_out_inspection_cleaned_both := project(Inspection_base,
Transform(layouts.layout_OSHAIR_inspection_clean_BIP,
self:=LEFT; 
self:=[];
));

export file_out_inspection_cleaned := project(file_out_inspection_cleaned_both,layouts.layout_OSHAIR_inspection_clean);


Export file_out_inspection_cleaned2	:=	project(file_out_inspection_cleaned, 
                                  TRANSFORM(layouts.inspection2,
																	self:=LEFT; 
                                  self:=[];
                                  ));

//bdid

slim_oshair_bdid := record
	file_out_inspection_cleaned.BDID;
	file_out_inspection_cleaned.Activity_Number;
end;

Export tbl_bdid := table (file_out_inspection_cleaned (BDID<>0), slim_oshair_bdid);

//violation
export file_out_violations_cleaned := project(Violations_base,OSHAIR.layout_OSHAIR_violations_clean);

 slimLayout_violations	:=	record
		OSHAIR.layout_OSHAIR_violations_clean	 
		  - dt_first_seen	- dt_last_seen						 
			- dt_vendor_first_reported - dt_vendor_last_reported;	  
end;

Export NewKeyBuild_violations	:=	project(file_out_violations_cleaned, TRANSFORM(slimLayout_violations,SELF := LEFT;));

//substance
export file_out_hazardous_substance_cleaned := project(Substance_base,OSHAIR.layout_OSHAIR_hazardous_substance_clean);

slimLayout_substance	:=	record
		OSHAIR.layout_OSHAIR_hazardous_substance_clean	 
		  - dt_first_seen	- dt_last_seen						 
			- dt_vendor_first_reported - dt_vendor_last_reported;	  
end;

Export NewKeyBuild_substance	:=	project(file_out_hazardous_substance_cleaned, TRANSFORM(slimLayout_substance,SELF := LEFT;));

Export NewKeyBuild_substance2	:=	project(NewKeyBuild_substance, 
                                  TRANSFORM(layouts.substance2,
																	self:=LEFT; 
                                  self:=[];
                                  ));
		
Export NewKeyBuild_violations2	:=	project(NewKeyBuild_violations, 
                                  TRANSFORM(layouts.violations2,
																	self:=LEFT; 
                                  self:=[];
                                  ));		

END;