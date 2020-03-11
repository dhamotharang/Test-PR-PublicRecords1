import crim_offense_cat;
export build_base_update(boolean pUseProd = false) := function
    new_offenses := crim_offense_cat.build_base_data(pUseProd);
    old_offenses := dataset(crim_offense_cat.Filenames(pUseProd).processedbase, crim_offense_cat.layouts.base_layout, thor, __compressed__, opt);
    unique_new_offenses := join(distribute(new_offenses, hash(offensecharge)), distribute(old_offenses, hash(offensecharge)), left.offensecharge = right.offensecharge, left only, local);
    return unique_new_offenses;
end;