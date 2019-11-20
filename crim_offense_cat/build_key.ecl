import crim_offense_cat, RoxieKeyBuild, dx_crim_offense_cat, std;
export build_key(string filedate, boolean pUseProd = false)  := function
    key_data := dataset(crim_offense_cat.Filenames(pUseProd).base, crim_offense_cat.layouts.base_layout, thor, __compressed__, opt);     
    RoxieKeybuild.MAC_build_logical(
                                    dx_crim_offense_cat.key(pUseProd), 
                                    key_data, 
                                    dx_crim_offense_cat.names(pUseProd).key,
                                    crim_offense_cat.filenames(pUseProd).key + '_' + filedate,
                                    seq_build
                                    );
    RoxieKeyBuild.Mac_SK_Move_v3(crim_offense_cat.filenames(pUseProd).key+'_@version@', 'D', seq_move,filedate, 2);
    all_seq := if(STD.File.FileExists(crim_offense_cat.filenames(pUseProd).key+ '_' + filedate),
                    output(crim_offense_cat.filenames(pUseProd).key+ '_' + filedate +' already exists, ceasing key operations.'),
                    sequential(
                            seq_build,
                            seq_move
                            )
                    );
    return all_Seq;
end;