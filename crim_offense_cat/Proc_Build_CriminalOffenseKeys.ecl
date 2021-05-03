import std, crim_offense_cat, orbit3, dops, VersionControl;
//pUseProd must be set to true only when running on prod
export Proc_Build_CriminalOffenseKeys(string new_input_folder, boolean pUseProd = true) := function
        inSP := nothor(STD.File.SuperFileContents(crim_offense_cat.Filenames(pUseProd).basein));
        basein := crim_offense_cat.filenames(pUseProd).BaseIn;
        newName := basein + '::'+ new_input_folder;
        isSameAsLast := count(inSP(name = newName[2..]))>0;
        UpdateDops := if(pUseProd and VersionControl._Flags.IsDataland = false, 
                                dops.updateversion('CriminalOffenseKeys', new_input_folder, crim_offense_cat.send_email(new_input_folder).notificationlist,,'N'),
                                output('debug no dops')
                                );
        UpdateOrbit := if(pUseProd and VersionControl._Flags.IsDataland = false,
                                orbit3.proc_Orbit3_CreateBuild_AddItem('Criminal Offense Keys', new_input_folder),
                                output('debug no orbit')
                                );
        return sequential(
                        if( isSameAsLast,
                                output(newName + ' already in superfile, skipping input version control'),
                                sequential(
                                        if(std.File.FileExists(newName),
                                                output('input file with same name has been sprayed previously, change name to respray'), //have to stop father and child from ever being the same
                                                crim_offense_cat.spray_input(new_input_folder, pUseprod)
                                                ),
                                        std.file.clearsuperfile(crim_offense_cat.Filenames(pUseProd).basein),
                                        std.file.AddSuperFile(crim_offense_cat.filenames(pUseProd).basein, newName)
                                        )
                                ),
                        crim_offense_cat.Mac_build_all(new_input_folder, pUseProd), //runs key process once input is sprayed and version controlled,
                        //std.file.AddSuperFile(crim_offense_cat.filenames(pUseProd).processedIn, newName),
                        UpdateDops,
                        UpdateOrbit
                        );
end;
