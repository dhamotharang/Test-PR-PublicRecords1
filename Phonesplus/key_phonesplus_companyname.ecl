import ut,doxie;

xl_phonesplus := RECORD
	Phonesplus.layoutCommonKeys;
	unsigned integer6 fdid;
	integer8 zero;
	string0 blk;
	unsigned integer4 lookups;
 END;

f_phonesplus := dataset('~thor_data400::persist::phonesplus_fdids',xl_phonesplus,thor);

ut.mac_suppress_by_phonetype(f_phonesplus,cellphone,state,_dist_DSphonesplus_slim1,true,did);
ut.mac_suppress_by_phonetype(_dist_DSphonesplus_slim1,homephone,state,dist_DSphonesplus_slim,true,did);

export key_phonesplus_companyname := index(dist_DSphonesplus_slim,{company},{fdid},
                                        ut.foreign_prod + 'thor_data400::key::phonesplus_companyname_'+doxie.Version_SuperKey);