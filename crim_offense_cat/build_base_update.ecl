import crim_offense_cat;
export build_base_update(boolean pUseProd = false) := function
    new_offenses := crim_offense_cat.build_base_data(pUseProd);
    old_offenses := dataset(crim_offense_cat.Filenames(pUseProd).base, crim_offense_cat.layouts.base_layout, thor, __compressed__, opt); 
    all_offenses := merge(new_offenses,old_offenses);
    all_offenses_dedup := dedup(sort(all_offenses, offensecharge), offensecharge);
    return all_offenses;
end;