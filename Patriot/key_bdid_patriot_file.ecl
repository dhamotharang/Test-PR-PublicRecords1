import ut, doxie, Business_Header, Business_Header_SS, Data_Services;

layout_pat_keybuild := record
	patriot.Layout_Patriot;
	unsigned8	__fpos {virtual(fileposition)};
end;

pat := dataset('~thor_data400::in::patriot_file',Layout_Pat_keybuild,flat);

layout_pat_temp := record
layout_pat_keybuild;
unsigned6 bdid := 0;
unsigned2 bdid_score := 0;
unsigned2 name_similar_score := 0;
end;

pat_temp := project(pat(cname <> ''), transform(layout_pat_temp, self := left));

Business_Header_SS.MAC_Match_CompanyName(pat_temp,
                                         pat_bdid,
										 bdid,
										 bdid_score,
										 name_similar_score,
										 cname)
                                         
layout_bdid_key := record
unsigned6 bdid := 0;
layout_pat_keybuild;
end;

pat_bdid_key := project(pat_bdid(bdid <> 0), transform(layout_bdid_key, self := left));

pat_bdid_key_dedup := dedup(pat_bdid_key, all);

export key_bdid_patriot_file := INDEX(pat_bdid_key_dedup,{bdid},{pat_bdid_key},Data_Services.Data_location.Prefix()+'thor_data400::key::patriot_bdid_file_'+doxie.Version_SuperKey);
