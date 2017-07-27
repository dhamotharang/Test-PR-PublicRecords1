import doxie_files, ut, doxie, autokey;

f_phonesplus := Phonesplus.file_phonesplus_base;

xl_phonesplus := RECORD
	Phonesplus.layoutCommonKeys;
	unsigned6 fdid;
END;

xl_phonesplus xpand_phonesplus(f_phonesplus le, integer phonesplus_cntr) :=  TRANSFORM 
	SELF.fdid := phonesplus_cntr + autokey.did_adder('NXTO'); 
	SELF := le; 
END;

DS_phonesplus_xpand := project(f_phonesplus, xpand_phonesplus(left, counter));

export key_phonesplus_fdid := index(DS_phonesplus_xpand,{fdid},{DS_phonesplus_xpand},
                                  '~thor_data400::key::phonesplus_fdids_' + doxie.Version_SuperKey);