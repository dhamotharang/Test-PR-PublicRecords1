import ut;

ds := dataset(ut.foreign_prod + 'thor_data400::base::qsent', Phonesplus.layoutCommonOut, thor);

ut.mac_suppress_by_phonetype(ds,cellphone,state,_fphonesplus_cell,true,did);
ut.mac_suppress_by_phonetype(_fphonesplus_cell,homephone,state,_fphonesplus_home,true,did);

export _keybuild_qsent_base := _fphonesplus_home(cellphone<>'');