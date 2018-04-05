IMPORT data_services,tris_lnssi_build;

EXPORT key_field_value_prep := function

keyname := data_services.Data_location.prefix('tris_lnssi')+
                  'thor_data400::key::tris_lnssi::qa::field_value';

in_file := tris_lnssi_build.file_base;

// place holder for key mappings / trimming etc.
tris_lnssi_build.layout_key_field_value prep_key(in_file L):=transform

    self:=L;

end;

pre_in_file := dedup(project(in_file,prep_key(LEFT)),record,all);

// group and roll up by Contrib_Risk_Attr and take the lowest only
pre_in_file_grouped := group(
                             sort(pre_in_file, Contrib_Risk_field, Contrib_Risk_Value, Contrib_State_Excl)
                             ,                 Contrib_Risk_field, Contrib_Risk_Value, Contrib_State_Excl   );


tris_lnssi_build.layout_key_field_value 
    roll_risk_attr(pre_in_file_grouped L, dataset(recordof(pre_in_file_grouped)) l_rows)
        :=transform

    SELF.Contrib_Risk_Attr := min(l_rows,Contrib_Risk_Attr);
    SELF:=L;
END;
pre_key := rollup(pre_in_file_grouped,group,roll_risk_attr(LEFT,ROWS(LEFT)));

RETURN INDEX(pre_key,
                        {Contrib_Risk_field,Contrib_Risk_Value}, 
                        {pre_key},
                        keyname   );

end;