IMPORT tools;
EXPORT fn_consolidate_inputs := MODULE

        SHARED consolidate(string superFile) := function

              ver       := tools.fun_GetFilenameVersion(superFile);
              del_sf    := '~thor_data400::in::transunioncred_del';
              new_files := DATASET(superfile,TransunionCred.Layouts.load,   THOR);
              one_file  := project(new_files,transform(TransunionCred.Layouts.load-cr,self:=left));
              
              build_one_file := output(one_file,,superfile+'_'+ver,compressed,overwrite);
              tidy_superfiles := sequential(  
                                               fileservices.StartSuperFileTransaction()
                                              ,fileservices.CreateSuperFile(del_sf,,true)
                                              ,fileservices.ClearSuperFile(del_sf)
                                              ,fileservices.AddSuperFile(del_sf,superfile,,true)
                                              ,fileservices.ClearSuperFile(superFile)
                                              ,fileservices.AddSuperFile(superFile,superfile+'_'+ver)
                                              ,fileservices.FinishSuperFileTransaction()
                                              ,fileservices.RemoveOwnedSubFiles(del_sf,true)
                                              ,fileservices.ClearSuperFile(del_sf)
              );

              return sequential(  
                                   build_one_file
                                  ,tidy_superFiles
              );

        END;

        EXPORT Updates := consolidate(TransunionCred.Superfile_list.Updates);
        EXPORT Load    := consolidate(TransunionCred.Superfile_list.Load);

END;