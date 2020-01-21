import std, crim_offense_cat;
//pUseProd must be set to true only when running on prod
export update_keys(string new_input_folder = '20200116', pUseProd = false) := function
    return sequential(  if( nothor(global(std.file.FileExists(crim_offense_cat.filenames(pUseProd).BaseIn+ '::'+ new_input_folder))),
                                output('input file with same name has been sprayed previously, change name to respray'),
                                sequential( crim_offense_cat.spray_input(new_input_folder),
                                            STD.File.PromoteSuperFileList(
                                                    [crim_offense_cat.filenames(pUseProd).BaseIn, crim_offense_cat.filenames(pUseProd).BaseIn +'_father', crim_offense_cat.filenames(pUseProd).BaseIn +'_grandfather'],
                                                    crim_offense_cat.filenames(pUseProd).BaseIn+ '::'+ new_input_folder)
                                            )
                                ),
                        crim_offense_cat.Mac_build_all(new_input_folder, pUseProd) //runs key process once input is sprayed and version controlled
                        );

end;
