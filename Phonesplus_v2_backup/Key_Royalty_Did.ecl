import doxie_files, doxie, Cellphone, ut, data_services;

f_phonesplus := phonesplus_v2._keybuild_royalty_base;//Phonesplus.file_phonesplus_base;

key_phonesplus := RECORD
  Phonesplus_v2.Layout_Phonesplus_Base;
END;

key_phonesplus slim_phonesplus(f_phonesplus input) :=  TRANSFORM 
	SELF := input; 
END;

p_phonesplus := PROJECT(f_phonesplus,slim_phonesplus(LEFT));


_fphonesplus_did := p_phonesplus((unsigned)did<>0, (unsigned)cellphone<>0);
//ut.mac_suppress_by_phonetype(_fphonesplus_did,cellphone,state,_fphonesplus_did1,true,did);
//ut.mac_suppress_by_phonetype(_fphonesplus_did1,homephone,state,fphonesplus_did,true,did);

export Key_Royalty_Did := index(_fphonesplus_did,
                                {unsigned6 l_did := did},{_fphonesplus_did},
                                data_services.data_location.prefix('Wired_Assets')+'thor_data400::key::phonesplusv2_royalty_did_'+doxie.Version_SuperKey);

