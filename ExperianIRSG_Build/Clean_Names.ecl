import ut, address;
norm_name 	 := ExperianIRSG_Build.Normalize_Record;
cached_names :=	distribute(Files.Cashed_Names_File, hash(Orig_lname, Orig_fname, Orig_mname)); 

d_names		 := distribute(norm_name, hash(Orig_lname, Orig_fname, Orig_mname)); 
srt_names	 := sort(d_names,Orig_lname, Orig_fname, Orig_mname,local);

//-----------------------------------------------------------------
//Match names to cleaned cached names
//-----------------------------------------------------------------

Layouts.Layout_Cln_Name t_get_cleaned_name(srt_names le, cached_names ri) := transform
	self.Clean_Name := ri.Clean_Name;
	self := le;
end;

names_cleaned_cache := join(srt_names, cached_names,
							left.Orig_fname = right.Orig_fname and
						    left.Orig_mname = right.Orig_mname and
						    left.Orig_lname = right.Orig_lname and
							left.Orig_suffix = right.Orig_suffix,
							t_get_cleaned_name(left, right),
							left outer,
							keep(1),
							local);

names_in_cache 		:= names_cleaned_cache(Clean_Name <> '');
names_to_clean  	:= names_cleaned_cache(Clean_Name = '');

//-----------------------------------------------------------------
//Clean remaining names and add them to cleaned cached names
//-----------------------------------------------------------------

Layouts.Layout_Cln_Name t_CleanName(names_to_clean le) := TRANSFORM
		lfm_name 	:= if(trim(le.Orig_lname, left, right) <> '' and  trim(le.Orig_fname, left, right) <> '',
				           trim(le.Orig_lname, left, right) +', '+ trim(le.Orig_fname, left, right) +' '+ trim(le.Orig_mname, left, right) + ' ' + trim(le.Orig_suffix, left,right),
						   '');
	
	fml_name 	:= if(trim(le.Orig_lname, left, right) <> '' and  trim(le.Orig_fname, left, right) <> '',
						  trim(le.Orig_fname, left, right)+' '+  trim(le.Orig_mname, left, right) + ' ' +  trim(le.Orig_lname, left, right) + ' ' + trim(le.Orig_suffix,left,right),
						'');
	
	
	// lfm_name	:= StringLib.StringCleanSpaces((trim(le.Orig_lname)+', '+ trim(le.Orig_fname)+' '+ trim(le.Orig_mname) + ' ' + trim(le.Orig_suffix)));
	// fml_name	:= StringLib.StringCleanSpaces((trim(le.Orig_fname)+' '+ trim(le.Orig_mname) +' '+ trim(le.Orig_lname) + ' ' + trim(le.Orig_suffix)));
	
	CleanName1	:= address.cleanpersonlfm73(lfm_name);
	CleanName2	:= address.cleanperson73(lfm_name);
	CleanName3	:= address.cleanpersonlfm73(StringLib.StringFindReplace(lfm_name, ',', ' '));
	CleanName4	:= address.cleanpersonfml73(fml_name);
	CleanName5	:= address.cleanperson73(fml_name);

	SELF.Clean_Name := map((unsigned1)CleanName4[71..73] > 0  => CleanName4, 
					 (unsigned1)CleanName1[71..73] > 0  => CleanName1,      
					 (unsigned1)CleanName3[71..73] > 0  => CleanName3,
					 (unsigned1)CleanName2[71..73] > 0  => CleanName2,
					 (unsigned1)CleanName5[71..73] > 0  => CleanName5,
					 CleanName4);
	SELF := le;
END;

name_clean := project(names_to_clean, t_CleanName(LEFT));

cln_name_cache := project(name_clean, Layouts.Layout_Clean_Name);

SEQUENTIAL(OUTPUT(cln_name_cache,,Superfile_List.IRSG_Cache_Name_File + version ,overwrite,__compressed__);
		   FileServices.StartSuperFileTransaction(),				
		   FileServices.AddSuperFile(Superfile_List.IRSG_Cache_Name_File,Superfile_List.IRSG_Cache_Name_File + version),
		   FileServices.FinishSuperFileTransaction());

all_cleaned_names := if(exists(names_in_cache) and exists(name_clean),  
						names_in_cache + name_clean,
						if(exists(names_in_cache), 
						names_in_cache, name_clean)); 
						 
export Clean_Names := all_cleaned_names;
