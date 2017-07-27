import ut;

pre1 := ut.SF_MaintBuilding('~thor_data400::base::busreg_company');
pre2 := ut.sf_maintBuilding('~thor_data400::base::busreg_contact');

ut.MAC_SK_BuildProcess_v2(busreg.key_busreg_company_bdid,'~thor_data400::key::busreg_company_bdid',do1);
ut.MAC_SK_BuildProcess_v2(busreg.key_busreg_contact_bdid,'~thor_data400::key::busreg_contact_bdid',do2);

ut.MAC_SK_Move_v2('~thor_data400::key::busreg_company_bdid','Q',do3,2);
ut.MAC_SK_Move_v2('~thor_Data400::key::busreg_contact_bdid','Q',do4,2);

post1 := ut.SF_MaintBuilt('~thor_data400::base::busreg_company');
post2 := ut.SF_MaintBuilt('~thor_Data400::base::busreg_contact');

export proc_build_keys := sequential(pre1,pre2,do1,do2,do3,do4,post1,post2);
