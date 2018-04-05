import doxie, ut, Data_Services, std; 

	FLAccidents_Ecrash.Layouts.key_slim_layout	ModifyLayout(FLAccidents_Ecrash.Layouts.key_search_layout l)	:= transform
		self.lname	:= l.lname;
		self.fname	:= l.fname;
		self.mname	:= l.mname;
		self	      := l;
	end;
	
	FLAccidents_Ecrash.Layouts.key_search_layout copyNames(FLAccidents_Ecrash.Layouts.key_search_layout l) := transform
		self.fname := l.orig_fname;
		self.lname := l.orig_lname;
		self.mname := l.orig_mname;
		self       := l;
	end;
	 
dsKeyBuild := FLAccidents_Ecrash.File_KeybuildV2.eCrashSearchRecs(lname <> '');

mSSv2:= PROJECT(dsKeyBuild(trim(lname, left, right) <> trim(orig_lname, left, right) and  
                           (STD.STr.CountWords(lname,' ') > 1 or STD.STr.CountWords(orig_lname,' ') > 1) and 
													 orig_lname <> ''),
								copyNames(left));

dsSlimFile := project(mSSv2 + dsKeyBuild, ModifyLayout(left));
ds_LastName	:= dedup(sort(distributed(dsSlimFile, hash64(accident_nbr)), 
                          accident_nbr,lname,report_code,jurisdiction_state,jurisdiction,accident_date,report_type_id, local),
										 accident_nbr,lname,report_code,jurisdiction_state,jurisdiction,accident_date,report_type_id, local); 


EXPORT Key_EcrashV2_LastName := 	INDEX(ds_LastName
																				,{lname,jurisdiction_state,jurisdiction}
																				,{ds_LastName}
																				,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::eCrashV2_LastName_State_' + doxie.Version_SuperKey);
																					
																						
																										