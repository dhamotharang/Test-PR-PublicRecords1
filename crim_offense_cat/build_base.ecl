import crim_offense_cat, PromoteSupers, std;
export build_base(string filedate, boolean pUseProd = false)  := function
        base_rec := crim_offense_cat.build_base_data(pUseProd);
        PromoteSupers.Mac_SF_BuildProcess(base_rec, 
                crim_offense_cat.Filenames(pUseProd).base, seq_base,2,,true,filedate);
        all_seq := if(STD.File.FileExists(crim_offense_cat.Filenames(pUseProd).base + filedate),
                        output(crim_offense_cat.Filenames(pUseProd).base +'_'+ filedate +' already exists, ceasing base file operations.'),        
                        sequential(
                                crim_offense_cat.CheckSuperfiles(crim_offense_cat.Filenames(pUseProd).base),
                                seq_base
                                )
                        );
        return all_seq;
end;
