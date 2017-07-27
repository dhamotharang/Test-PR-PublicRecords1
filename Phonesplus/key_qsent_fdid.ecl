import doxie_files, ut, doxie, autokey;

f_qsent := Phonesplus.file_qsent_base(PublishCode != 'NP');

xl_qsent := RECORD
	Phonesplus.layoutCommonKeys;
	unsigned6 fdid;
END;

xl_qsent xpand_qsent(f_qsent le, integer qsent_cntr) :=  TRANSFORM 
	SELF.fdid := qsent_cntr + autokey.did_adder('NXTO'); 
	SELF := le; 
END;

DS_qsent_xpand := project(f_qsent, xpand_qsent(left, counter));

export key_qsent_fdid := index(DS_qsent_xpand,{fdid},{DS_qsent_xpand},
                                  '~thor_data400::key::qsent_fdids_' + doxie.Version_SuperKey);