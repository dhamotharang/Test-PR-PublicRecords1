import doxie, autokey, Data_Services;

f_qsent := Phonesplus.file_qsent_base(PublishCode != 'NP');

xl_qsent := RECORD
	//CCPA-5 include 2 new CCPA fields, global_sid and record_sid
	Phonesplus.layoutCommonKeys_CCPA;
	unsigned6 fdid;
END;

xl_qsent xpand_qsent(f_qsent le, integer qsent_cntr) :=  TRANSFORM 
	SELF.fdid := qsent_cntr + autokey.did_adder('NXTO'); 
	SELF := le; 
END;

DS_qsent_xpand := project(f_qsent, xpand_qsent(left, counter));

//ut.mac_suppress_by_phonetype(DS_qsent_xpand,homephone,state,ph_out1,true,did);
//ut.mac_suppress_by_phonetype(ph_out1,cellphone,state,ph_out2,true,did);

export key_qsent_fdid := index(DS_qsent_xpand,{fdid},{DS_qsent_xpand},
                               Data_Services.Data_location.Prefix()+'thor_data400::key::qsent_fdids_' + doxie.Version_SuperKey);
