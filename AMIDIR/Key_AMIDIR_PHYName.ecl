import AMIDIR, Doxie;

file_in := AMIDIR.File_AMIDIR_DID_SSN_BDID;
AMIDIR_phyname_base := file_in(Physician_Name_Clean_lname<> '');

dedup_phyname_base := dedup(AMIDIR_phyname_base,all);

export key_AMIDIR_phyname := index(AMIDIR_phyname_base, 
                                {l_Physician_Name_Clean_lname := Physician_Name_Clean_lname, l_Physician_Name_Clean_fname := Physician_Name_Clean_fname,
								l_Physician_Name_Clean_mname := Physician_Name_Clean_mname},{dedup_phyname_base},
				            '~thor_data400::key::amidir_phyname_' + Doxie.Version_SuperKey);




