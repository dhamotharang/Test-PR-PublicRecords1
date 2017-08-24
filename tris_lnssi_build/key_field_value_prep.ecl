IMPORT data_services,tris_lnssi_build;

EXPORT key_field_value_prep := function

keyname := data_services.Data_location.prefix('tris_lnssi')+
                  'thor_data400::key::tris_lnssi::qa::field_value';

in_file := tris_lnssi_build.file_base;

tris_lnssi_build.layout_key_field_value prep_key(in_file L):=transform

    self.Contrib_Risk_field := if(L.Contrib_Risk_field[1..8]='ISP-NAME','ISP-NAME',L.Contrib_Risk_field);
    self:=L;

end;

pre_in_file := project(in_file,prep_key(LEFT));

RETURN INDEX(pre_in_file,
                        {Contrib_Risk_field,Contrib_Risk_Value}, 
                        {pre_in_file},
                        keyname   );

end;