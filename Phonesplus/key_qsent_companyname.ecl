import ut,doxie;

xl_qsent := RECORD
	// CCPA-5 include 2 new CCPA fields, global_sid and record_sid
	Phonesplus.layoutCommonKeys_CCPA;
	unsigned integer6 fdid;
	integer8 zero;
	string0 blk;
	unsigned integer4 lookups;
 END;

f_qsent := dataset('~thor_data400::persist::qsent_fdids',xl_qsent,thor);

ut.mac_suppress_by_phonetype(f_qsent,homephone,state,ph_out1,true,did);
ut.mac_suppress_by_phonetype(ph_out1,cellphone,state,ph_out2,true,did);

export key_qsent_companyname := index(ph_out2,{company},{fdid},
                                        ut.foreign_prod + 'thor_data400::key::qsent_companyname_'+doxie.Version_SuperKey);