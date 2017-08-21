import ut, address;

File_optin := if(exists(provider1) and exists(provider2),
                 provider1+provider2,
				 if(exists(provider1),provider1,provider2));
				 
cached_names := distribute(Files.File_Name_Cache,hash(orig_fname,orig_lname));

Layout_Temp_Sequence := record
	unsigned Seq_Rec_Id :=0;
	file_optin;
end;

proj_input_files := project(File_optin, Layout_Temp_Sequence);

//Add a record sequence
ut.MAC_Sequence_Records(proj_input_files, Seq_Rec_Id, input_files_id);

dist_file_optin := distribute(input_files_id,hash(firstname,lastname));
str_file_optin := sort(dist_file_optin,firstname,lastname,local);

Layouts.Layout_Clean_Name t_set_name(str_file_optin le,cached_names ri) := TRANSFORM
self.clean_name := ri.clean_name;
self := le;
end;

cleaned_name_cache := join(str_file_optin,cached_names,
						left.firstname = right.Orig_fname and
						left.lastname = right.Orig_lname,
						t_set_name(left, right),
						left outer,
						keep(1),
						local);
// cleaned_name_cache := project(srt_file_in,Layouts.Layout_Clean_Name);
						
names_in_cache := cleaned_name_cache(Clean_Name <> '');
names_to_clean := cleaned_name_cache(Clean_Name = '');

Layouts.Layout_Clean_Name t_CleanName(names_to_clean le) := TRANSFORM
	fml_name 	:= if(trim(le.lastname, left, right) <> '' and  trim(le.firstname, left, right) <> '',
						  trim(le.firstname, left, right)+' '+  trim(le.lastname, left, right),
						  '');
	CleanName4	:= address.cleanpersonfml73(fml_name);


	SELF.Clean_Name := CleanName4;
	SELF := le;
END;

name_clean := project(names_to_clean, t_CleanName(LEFT));

Layouts.Layout_Clean_Cache t_set_cache(name_clean le) := TRANSFORM
	self.orig_fname := le.firstname;
	self.orig_lname := le.lastname;
	self := le;
END;

cln_name_cache := project(name_clean, t_set_cache(left));
dist_cln_name_cache := distribute(cln_name_cache,hash(orig_fname,orig_lname,clean_name));
str_cln_name_cache := sort(dist_cln_name_cache,orig_fname,orig_lname,clean_name,local);
dedup_cln_name_cache := dedup(str_cln_name_cache,orig_fname,orig_lname,clean_name,local);

SEQUENTIAL(OUTPUT(dedup_cln_name_cache,,Superfile_List.Cache_Name_File + version ,overwrite,__compressed__);
		   FileServices.StartSuperFileTransaction(),
		   FileServices.AddSuperFile(Superfile_List.Cache_Name_File,Superfile_List.Cache_Name_File + version),
		   FileServices.FinishSuperFileTransaction());

all_cleaned_names := if(exists(names_in_cache) and exists(name_clean),  
						names_in_cache + name_clean,
						if(exists(names_in_cache), 
						names_in_cache, name_clean)); 
						 
export Clean_Names := all_cleaned_names:persist('~thor_data400::persist::optincellphones_clean_names');