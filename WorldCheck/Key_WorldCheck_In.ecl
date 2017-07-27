import doxie_files, doxie,ut;

r := 
RECORD, maxlength(30010)
	STRING10 uid;
	WorldCheck.Layout_WorldCheck_in - [external_sources, further_information, uid];
END;

f1_worldcheck := PROJECT(worldcheck.File_WorldCheck_In,r);

f1_worldcheck worldtran(f1_worldcheck input) := transform
self.E_I_Ind := if(input.e_i_ind in ['M','F'],'I',input.e_i_ind);
self.locations := regexreplace('~,|~,~|~',input.Locations,'');
self := input;
end;

f_worldcheck := project(f1_worldcheck,worldtran(left));

export Key_WorldCheck_in := index(f_worldcheck
                                  ,{uid}
							      ,{f_worldcheck}
								  ,'~thor_data400::key::WorldCheck::in_'+doxie.Version_SuperKey);