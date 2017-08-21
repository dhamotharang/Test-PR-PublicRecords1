import doxie_files, doxie, Cellphone, ut;

f_phonesplus := phonesplus._keybuild_phonesplus_base;//Phonesplus.file_phonesplus_base;

key_phonesplus := RECORD
	Phonesplus.layoutCommonKeys;
END;

key_phonesplus slim_phonesplus(f_phonesplus input) :=  TRANSFORM 
	SELF := input; 
END;

p_phonesplus := PROJECT(f_phonesplus,slim_phonesplus(LEFT));


_fphonesplus_did := p_phonesplus((unsigned)did<>0, (unsigned)CellPhone<>0);
//ut.mac_suppress_by_phonetype(_fphonesplus_did,cellphone,state,_fphonesplus_did1,true,did);
//ut.mac_suppress_by_phonetype(_fphonesplus_did1,homephone,state,fphonesplus_did,true,did);

export key_phonesplus_did := index(_fphonesplus_did,
                                {unsigned6 l_did := did},{_fphonesplus_did},
                                // ut.foreign_prod + 'thor_data400::key::phonesplus_did_'+doxie.Version_SuperKey);
                                ut.foreign_prod+'thor_data400::key::phonesplus_did_'+doxie.Version_SuperKey);


