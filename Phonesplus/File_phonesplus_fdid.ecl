import address,autokey,ut,doxie;

phonesplusd   := Phonesplus.file_phonesplus_base;
Address.MAC_Multi_City(phonesplusd,p_city_name,zip5,multiCityPhonesplus);

xl_phonesplus := RECORD
	Phonesplus.layoutCommonKeys;
	unsigned6 fdid;
	zero := 0;
	blk := '';
	unsigned4 lookups := ut.bit_set(0,doxie.lookup_bit('NXTO'))| ut.bit_set(0,0);
END;

xl_phonesplus xpand_phonesplus(multiCityPhonesplus le,integer phonesplus_cntr) :=  TRANSFORM 
	SELF.fdid := phonesplus_cntr + autokey.did_adder('NXTO'); 
	SELF := le; 
END;
DS_phonesplus := PROJECT(multiCityPhonesplus,xpand_phonesplus(LEFT,COUNTER)) : PERSIST(ut.foreign_prod + 'thor_data400::persist::phonesplus_fdids');
dist_DSphonesplus := distribute(DS_phonesplus,random());


export File_phonesplus_fdid := dist_DSphonesplus;