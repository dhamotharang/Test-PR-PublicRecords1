IMPORT Data_Services, doxie_files, doxie, Cellphone, ut, data_services;

f_phonesplus := phonesplus_v2._keybuild_phonesplus_base;//Phonesplus.file_phonesplus_base;

key_phonesplus := RECORD
  Phonesplus_v2.Layout_Phonesplus_Base;
END;

key_phonesplus slim_phonesplus(f_phonesplus input) :=  TRANSFORM 
	SELF.Prim_Range := TRIM(input.Prim_Range);
	SELF.Prim_Name := TRIM(input.Prim_Name);
	SELF.Predir := TRIM(input.Predir);
	SELF.Addr_Suffix := TRIM(input.Addr_Suffix);
	SELF.Sec_Range := TRIM(input.Sec_Range);
	SELF.Zip5 := TRIM(input.Zip5);
	SELF := input; 
END;

p_phonesplus := PROJECT(f_phonesplus,slim_phonesplus(LEFT));

_fphonesplus_address := p_phonesplus(TRIM(prim_range) <> '' AND TRIM(prim_name) <> '' AND TRIM(zip5) <> '' AND TRIM(cellphone) NOT IN ['', '0']);

export Key_Address := INDEX(_fphonesplus_address,
																{prim_range, prim_name, predir, addr_suffix, sec_range, zip5},{_fphonesplus_address},
																data_services.data_location.Prefix('phonesPlus') + 'thor_data400::key::phonesplusv2_address_full_' + doxie.Version_SuperKey);


