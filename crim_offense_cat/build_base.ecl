import crim_offense_cat, PromoteSupers, std;
export build_base(string filedate, boolean pUseProd = false)  := function
        base_rec := if(count(nothor(STD.File.SuperFileContents(crim_offense_cat.Filenames(false).base))) > 0,
                                crim_offense_cat.build_base_update(pUseProd),
                                crim_offense_cat.build_base_data(pUseProd));

        PromoteSupers.Mac_SF_BuildProcess(base_rec, 
                crim_offense_cat.Filenames(pUseProd).base, seq_base,3,,true,filedate);
        
        all_seq :=      sequential(
                                crim_offense_cat.CheckSuperfiles(crim_offense_cat.Filenames(pUseProd).base),
                                seq_base
                                );
        return all_seq;
end;
