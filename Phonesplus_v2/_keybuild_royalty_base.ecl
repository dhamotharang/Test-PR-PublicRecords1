import doxie_files, doxie, Cellphone, ut;

f_phonesplus := Phonesplus_v2.File_Royalty_Base(current_rec);

ut.mac_suppress_by_phonetype(f_phonesplus,cellphone,state,_fphonesplus_cell,true,did);

export _keybuild_royalty_base := Phonesplus_v2.Prep_Build.applyRegulatoryPhonesPlus(f_phonesplus(cellphone<>''));