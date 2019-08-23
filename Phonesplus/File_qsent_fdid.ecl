import address,autokey,ut,doxie;

Qsentd   := _keybuild_qsent_base;//Phonesplus.file_qsent_base;
Address.MAC_Multi_City(Qsentd,p_city_name,zip5,multiCityPhonesplus);

xl_qsent := RECORD
	// Phonesplus.layoutCommonKeys;
	// CCPA-5 include 2 new CCPA fields, global_sid and record_sid
	Phonesplus.layoutCommonKeys_CCPA;
	unsigned6 fdid;
	zero := 0;
	blk := '';
	unsigned4 lookups := ut.bit_set(0,doxie.lookup_bit('NXTO'))| ut.bit_set(0,0);
END;

xl_qsent xpand_qsent(multiCityPhonesplus le,integer qsent_cntr) :=  TRANSFORM 
	SELF.fdid := qsent_cntr + autokey.did_adder('NXTO'); 
	SELF := le; 
END;
DS_qsent := PROJECT(multiCityPhonesplus,xpand_qsent(LEFT,COUNTER)) : PERSIST('~thor_data400::persist::qsent_fdids');
dist_DSqsent := distribute(DS_qsent,random());

export File_qsent_fdid := dist_DSqsent;