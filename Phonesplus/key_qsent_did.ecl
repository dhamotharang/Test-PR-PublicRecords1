import doxie_files, doxie, Cellphone, ut;

f_qsent := _keybuild_qsent_base;//Phonesplus.file_qsent_base;

key_qsent := RECORD
	//CCPA-5 include 2 new CCPA fields, global_sid and record_sid
	Phonesplus.layoutCommonKeys_CCPA;
END;

key_qsent slim_phonesplus(f_qsent input) :=  TRANSFORM 
	SELF := input; 
END;

p_qsent := PROJECT(f_qsent,slim_phonesplus(LEFT));

//ut.mac_suppress_by_phonetype(p_qsent,homephone,state,ph_out1,true,did);
//ut.mac_suppress_by_phonetype(ph_out1,cellphone,state,ph_out2,true,did);

fqsent_did := p_qsent((unsigned)did<>0, (unsigned)CellPhone<>0);
export key_qsent_did := index(fqsent_did,
                                {unsigned6 l_did := did},{fqsent_did},
                                ut.foreign_prod+'thor_data400::key::qsent_did_'+doxie.Version_SuperKey);