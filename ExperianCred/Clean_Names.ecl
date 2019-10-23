import ut, address;

export Clean_Names(string ver):= module

norm_name 	 := ExperianCred.Normalize_Names(ver).all;
cached_names :=	distribute(Files.Cashed_Names_File, hash(Orig_lname, Orig_fname, Orig_mname)) :INDEPENDENT; 

d_names		 := distribute(norm_name, hash(Orig_lname, Orig_fname, Orig_mname)) :INDEPENDENT; 
dedup_names  := dedup(sort(d_names,Orig_lname, Orig_fname, Orig_mname, Orig_suffix, LOCAL),Orig_lname, Orig_fname, Orig_mname, Orig_suffix,LOCAL) ; 

//-----------------------------------------------------------------
//Match names to cleaned cached names
//-----------------------------------------------------------------

Layouts.Layout_Clean_Name t_get_cleaned_name(dedup_names le, cached_names ri) := transform
	self.Clean_Name := ri.Clean_Name;
	self := le;
end;

names_cleaned_cache := join(dedup_names, cached_names,
							left.Orig_fname = right.Orig_fname and
						    left.Orig_mname = right.Orig_mname and
						    left.Orig_lname = right.Orig_lname and
							left.Orig_suffix = right.Orig_suffix,
							t_get_cleaned_name(left, right), 
							left outer, 
							local);

names_in_cache 		:= names_cleaned_cache(Clean_Name <> '');
names_to_clean  	:= names_cleaned_cache(Clean_Name = '');

//-----------------------------------------------------------------
//Clean remaining names and add them to cleaned cached names
//-----------------------------------------------------------------

bad_name := ['NMN', 'EST', 'ESTATE'];

Layouts.Layout_Clean_Name t_CleanName(names_to_clean le) := TRANSFORM
	get_suffix(string suffix, string gender) := map(suffix = 'J' and gender <> 'F' => 'JR',
									 suffix = 'S'  and gender <> 'F' => 'SR',
									 suffix = '2'  and gender <> 'F' => 'II',
									 suffix = '3'  and gender <> 'F'=> 'III',
									 suffix = '4'  and gender <> 'F'=> 'IV',
									 '');
									 
									 
 Orig_lname := if(le.Orig_lname not in bad_name, le.Orig_lname , '');
 Orig_fname := if(le.Orig_fname not in bad_name, le.Orig_fname , '');
 Orig_mname := if(le.Orig_mname not in bad_name, le.Orig_mname  , '');
	
	fml_name 	:= if(trim(Orig_lname, left, right) <> '' and  trim(Orig_fname, left, right) <> '',
						  trim(Orig_fname, left, right)+' '+  trim(Orig_mname, left, right) + ' ' +  trim(Orig_lname, left, right) + ' ' + get_suffix(le.Orig_suffix,le.gender),
						'');

	CleanName := address.cleanpersonfml73(fml_name);

	self.Clean_Name :=  CleanName;
	SELF := le;
END;

name_clean := project(names_to_clean, t_CleanName(LEFT));

SEQUENTIAL(OUTPUT(name_clean,,Superfile_List.Cache_Name_File + ver ,overwrite,__compressed__);
		   FileServices.StartSuperFileTransaction(),				
		   FileServices.AddSuperFile(Superfile_List.Cache_Name_File,Superfile_List.Cache_Name_File + ver),
		   FileServices.FinishSuperFileTransaction());

all_cleaned_names := if(exists(names_in_cache) and exists(name_clean),  
						names_in_cache + name_clean,
						if(exists(names_in_cache), 
						names_in_cache, name_clean)); 
						 
export ALL:= all_cleaned_names;

END;