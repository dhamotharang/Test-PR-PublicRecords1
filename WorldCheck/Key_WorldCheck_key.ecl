import doxie,data_services;

f1_worldcheck := WorldCheck.File_Main;

f1_worldcheck worldtran(f1_worldcheck input) := transform
self.E_I_Ind := if(input.e_i_ind in ['M','F'],'I',input.e_i_ind);
self := input;
end;

f_worldcheck := project(f1_worldcheck,worldtran(left));

export Key_WorldCheck_key := index(f_worldcheck
                                  ,{key}
							      ,{f_worldcheck}
								  ,data_services.data_location.prefix() + 'thor_data400::key::WorldCheck::key_'+doxie.Version_SuperKey);
