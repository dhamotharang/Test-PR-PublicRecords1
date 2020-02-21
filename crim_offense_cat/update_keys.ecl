import std, crim_offense_cat, orbit3;
//pUseProd must be set to true only when running on prod
export update_keys(string new_input_folder = '20200206', pUseProd = false) := function
        inSP := nothor(STD.File.SuperFileContents(crim_offense_cat.Filenames(pUseProd).processedIn));
        newName := crim_offense_cat.filenames(pUseProd).BaseIn+ '::'+ new_input_folder;
        isSameAsLast := count(inSP(name = newName[2..]))>0;
        update_orbit := orbit3.proc_Orbit3_CreateBuild_AddItem('Criminal Offense Keys', new_input_folder);
        return sequential(  
                        if( isSameAsLast,
                                output(newName + 'already in superfile, skipping input version control'),
                                sequential(
                                        if(std.File.FileExists(newName),
                                                output('input file with same name has been sprayed previously, change name to respray'), //have to stop father and child from ever being the same
                                                crim_offense_cat.spray_input(new_input_folder)
                                                ),
                                        STD.File.PromoteSuperFileList(
                                                [       
                                                        crim_offense_cat.filenames(pUseProd).BaseIn,
                                                        crim_offense_cat.filenames(pUseProd).BaseIn +'_father'
                                                        ],
                                                crim_offense_cat.filenames(pUseProd).BaseIn+ '::'+ new_input_folder
                                                ),
                                        std.file.AddSuperFile(crim_offense_cat.filenames(pUseProd).processedIn, crim_offense_cat.filenames(pUseProd).BaseIn+ '::'+ new_input_folder)
                                        )
                                ),
                        crim_offense_cat.Mac_build_all(new_input_folder +'b', pUseProd), //runs key process once input is sprayed and version controlled
                        update_orbit
                        );
end;
