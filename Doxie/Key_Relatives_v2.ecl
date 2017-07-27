import header,doxie,ut,data_services;
res := header.file_relative_title.file;

rel_title_layout := RECORD
   unsigned1 title;
   unsigned8 permissions;
  END;
	
key_layout := record
		res.person1;
		res.same_lname;
		res.number_cohabits,
		res.recent_cohabit,
		res.person2;
		res.prim_range;
		DATASET(rel_title_layout) rel_title;
end;

res_k := project(res, transform(key_layout, self.person1 := left.person2, self.person2 := left.person1, self := left));

export Key_Relatives_v2 := INDEX(res_k,
{person1,same_lname,number_cohabits,recent_cohabit,person2},
{res_k}, 
data_services.Data_Location.Relatives+'thor_data400::key::relatives_v2_' + 
version_superkey);


