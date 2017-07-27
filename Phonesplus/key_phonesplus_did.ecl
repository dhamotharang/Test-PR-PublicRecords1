import doxie_files, doxie, Cellphone;

f_phonesplus := Phonesplus.file_phonesplus_base;

key_phonesplus := RECORD
	Phonesplus.layoutCommonKeys;
END;

key_phonesplus slim_phonesplus(f_phonesplus input) :=  TRANSFORM 
	SELF := input; 
END;

p_phonesplus := PROJECT(f_phonesplus,slim_phonesplus(LEFT));


fphonesplus_did := p_phonesplus((unsigned)did<>0, (unsigned)CellPhone<>0);
export key_phonesplus_did := index(fphonesplus_did,
                                {unsigned6 l_did := did},{fphonesplus_did},
                                '~thor_data400::key::phonesplus_did_'+doxie.Version_SuperKey);


