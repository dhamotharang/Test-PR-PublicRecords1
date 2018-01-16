import ut,doxie,Data_Services;

xl_phonesplus := RECORD
	Phonesplus_v2.Layout_Phonesplus_Base;
	unsigned integer6 fdid;
	integer8 zero;
	string0 blk;
	unsigned integer4 lookups;
 END;

f_phonesplus := dataset('~thor_data400::persist::phonesplusv2_royalty_fdids',xl_phonesplus,thor);

ut.mac_suppress_by_phonetype(f_phonesplus,cellphone,state,_dist_DSphonesplus_slim1,true,did);
ut.mac_suppress_by_phonetype(_dist_DSphonesplus_slim1,cellphone,state,dist_DSphonesplus_slim,true,did);

export Key_Royalty_Companyname := index(dist_DSphonesplus_slim,{Company},{fdid},
                                         Data_Services.Data_location.Prefix()+'thor_data400::key::phonesplusv2_royalty_companyname_'+doxie.Version_SuperKey);

