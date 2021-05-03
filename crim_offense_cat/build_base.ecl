//Buils base file and handles version control
import crim_offense_cat, PromoteSupers, std;
export build_base(string filedate, boolean pUseProd = false)  := function
        //Different process if running for the first time
        base_rec :=  crim_offense_cat.build_base_data(pUseProd); //crim_offense_cat.build_base_update(pUseProd);
        //processed_data := dataset(crim_offense_cat.Filenames(pUseProd).processedbase, crim_offense_cat.layouts.base_layout, thor, __compressed__, opt);
        seq_base := output(base_rec,,crim_offense_cat.Filenames(pUseProd).base + '_' + filedate, thor, overwrite, __compressed__);
        all_seq :=      sequential(
                                std.File.Startsuperfiletransaction(),
                                crim_offense_cat.CheckSuperfiles(crim_offense_cat.Filenames(pUseProd).base), //creates missing superfiles
                                seq_base,
                                std.file.PromoteSuperFileList([ crim_offense_cat.filenames(pUseProd).Base,
                                                                crim_offense_cat.filenames(pUseProd).Base + '_father',
                                                                crim_offense_cat.filenames(pUseProd).Base + '_grandfather'],
                                                                crim_offense_cat.filenames(pUseProd).Base+'_' + filedate
                                                                ),
                                //std.file.AddSuperFile(crim_offense_cat.filenames(pUseProd).processedBase, crim_offense_cat.filenames(pUseProd).Base+'_' + filedate),
                                std.File.finishsuperfiletransaction()
                                );
        return all_seq;
end;
