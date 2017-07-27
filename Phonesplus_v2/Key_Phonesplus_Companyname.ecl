import ut,doxie,data_services;

xl_phonesplus := RECORD
	Phonesplus_v2.Layout_Phonesplus_Base;
	unsigned integer6 fdid;
	integer8 zero;
	string0 blk;
	unsigned integer4 lookups;
 END;

f_phonesplus := dataset('~thor_data400::persist::phonesplusv2_fdids',xl_phonesplus,thor);

ut.mac_suppress_by_phonetype(f_phonesplus,cellphone,state,_dist_DSphonesplus_slim1,true,did);
ut.mac_suppress_by_phonetype(_dist_DSphonesplus_slim1,cellphone,state,dist_DSphonesplus_slim,true,did);

export key_phonesplus_companyname := index(dist_DSphonesplus_slim,{Company},{fdid},data_services.data_location.prefix('phonesPlus') +
                                         'thor_data400::key::phonesplusv2_companyname_'+doxie.Version_SuperKey);

