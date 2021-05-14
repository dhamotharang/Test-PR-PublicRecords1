//builds key and handles version control
import crim_offense_cat, RoxieKeyBuild, dx_crim_offense_cat, std;
//#option('multiplePersistInstances',FALSE);
export build_key(string filedate, boolean pUseProd = false)  := function
    key_data := dataset(crim_offense_cat.Filenames(pUseProd).Base, crim_offense_cat.layouts.base_layout, thor, __compressed__);   
    RoxieKeybuild.MAC_build_logical(
                                    dx_crim_offense_cat.key(pUseProd), 
                                    key_data, 
                                    dx_crim_offense_cat.names(pUseProd).key,
                                    crim_offense_cat.filenames(pUseProd).key + '::' + filedate + '::charge',
                                    seq_build
                                    );
    RoxieKeyBuild.Mac_SK_Move_v3(crim_offense_cat.filenames(pUseProd).key+'::@version@'+ '::charge', 'D', seq_move,filedate, 2);
    all_seq :=  sequential(
                        seq_build,
                        seq_move
                );
    return all_Seq;
end;