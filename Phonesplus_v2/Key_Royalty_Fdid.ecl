import doxie_files, ut, doxie, autokey;

f_phonesplus := phonesplus_v2._keybuild_royalty_base;

xl_phonesplus := RECORD
	Phonesplus_v2.Layout_Phonesplus_Base;
	unsigned6 fdid;
END;

xl_phonesplus xpand_phonesplus(f_phonesplus le, integer phonesplus_cntr) :=  TRANSFORM 
	SELF.fdid := phonesplus_cntr + autokey.did_adder('NXTO'); 
	SELF := le; 
END;

_DS_phonesplus_xpand := project(f_phonesplus, xpand_phonesplus(left, counter));
//ut.mac_suppress_by_phonetype(_DS_phonesplus_xpand,cellphone,state,_DS_phonesplus_xpand1,true,did);
//ut.mac_suppress_by_phonetype(_DS_phonesplus_xpand1,homephone,state,DS_phonesplus_xpand,true,did);

export Key_Royalty_Fdid := index(_DS_phonesplus_xpand,{fdid},{_DS_phonesplus_xpand},
                                  // ut.foreign_prod+'thor_data400::key::phonesplus_fdids_' + doxie.Version_SuperKey);
                                  '~thor_data400::key::phonesplusv2_royalty_fdids_' + doxie.Version_SuperKey);