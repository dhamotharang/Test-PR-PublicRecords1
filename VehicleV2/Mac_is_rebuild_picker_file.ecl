export Mac_is_rebuild_picker_file(outfile,rebuild_picker) := macro

//count vina subfile  

GetSubName := nothor(fileservices.GetSuperFileSubName('~thor_data400::in::vehreg_vina_info_all',1)); 

subname := dataset([{GetSubName}], {string subname});

old_subname := dataset('~thor_data400::out::VehReg_VINA_superfile_subname', {string subname}, flat);

rewrite_subname := output(subname,,'~thor_data400::out::VehReg_VINA_superfile_subname', overwrite);

//build picker file on Thor and despray to edata12 if VINA file update

rebuild_picker := if(subname[1].subname != old_subname[1].subname, true, false);
outfile   := rewrite_subname;

endmacro;