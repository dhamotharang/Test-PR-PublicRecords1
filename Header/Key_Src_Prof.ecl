Import Data_Services, prof_license,ut;

keybuildLayout	:=	record
	 header.Layout_Source_ID;
	 prof_license.layout_proflic_out;
	end;

dProflic_as_Source	:=	project(header.Files_SeqdSrc().PL,keybuildLayout);

mac_key_src(dProflic_as_Source, prof_license.layout_proflic_out, 
						proflic_child, 
						ut.foreign_prod+'thor_data400::key::Prof_src_index_',id)
						
export Key_Src_Prof := id;