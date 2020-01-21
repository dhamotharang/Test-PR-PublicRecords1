import crim_offense_cat;
export build_base_update(boolean pUseProd = false) := function
    new_offenses := sort(crim_offense_cat.build_base_data(pUseProd), offensecharge);
    old_offenses := sort(dataset(crim_offense_cat.Filenames(pUseProd).base, crim_offense_cat.layouts.base_layout, thor, __compressed__, opt), offensecharge);
    all_offenses := merge(new_offenses, old_offenses, sorted(offensecharge), ordered(true));
    all_offenses_dedup := dedup(all_offenses, offensecharge);
    return all_offenses;
end;