d := dataset('~thor_data400::base::mar_div::intermediate',marriage_divorce_v2.layout_mar_div_intermediate,flat);

export file_mar_div_base := project(d, transform(marriage_divorce_v2.layout_mar_div_base, self := left));
