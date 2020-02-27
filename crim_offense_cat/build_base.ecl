//Buils base file and handles version control
import crim_offense_cat, PromoteSupers, std;
export build_base(string filedate, boolean pUseProd = false)  := function
        //Different process if running for the first time
        base_rec := crim_offense_cat.build_base_update(pUseProd);
        processed_data := dataset(crim_offense_cat.Filenames(pUseProd).processedbase, crim_offense_cat.layouts.base_layout, thor, opt);
        store_first_input := if(~exists(processed_data), 
                                        std.file.AddSuperFile(crim_offense_cat.filenames(pUseProd).ProcessedIn,
                                                std.file.getsuperfilesubname(crim_offense_cat.filenames(pUseProd).basein,1)),
                                        output('not first time, adding '+ filedate));
        //PromoteSupers.Mac_SF_BuildProcess(base_rec, crim_offense_cat.Filenames(pUseProd).base, seq_base,3,,true,filedate); //we changed to a different version control
        seq_base := output(base_rec,,crim_offense_cat.Filenames(pUseProd).base + '_' + filedate, overwrite);
        all_seq :=      sequential(
                                crim_offense_cat.CheckSuperfiles(crim_offense_cat.Filenames(pUseProd).base), //creates missing superfiles
                                store_first_input,
                                output(crim_offense_cat.checkSuperEmpty(crim_offense_cat.filenames(pUseProd).processedBase)),
                                seq_base,
                                std.file.AddSuperFile(crim_offense_cat.filenames(pUseProd).processedBase, crim_offense_cat.filenames(pUseProd).Base+'_' + filedate)
                                );
        return all_seq;
end;
