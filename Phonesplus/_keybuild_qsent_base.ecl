import ut;

//CCPA-5 use layout that has 2 new CCPA fields, global_sid and record_sid
ds := dataset('~thor_data400::base::qsent', Phonesplus.layoutCommonOut_CCPA, thor);

ut.mac_suppress_by_phonetype(ds,cellphone,state,_fphonesplus_cell,true,did);
ut.mac_suppress_by_phonetype(_fphonesplus_cell,homephone,state,_fphonesplus_home,true,did);

export _keybuild_qsent_base := _fphonesplus_home(cellphone<>'');