import ut;

pre1 := ut.SF_MaintBuilding('~thor_data400::base::edgar_company');
pre2 := ut.SF_MaintBuilding('~thor_data400::base::edgar_contacts');

ut.MAC_SK_BuildProcess_v2(edgar.key_edgar_company_bdid,'~thor_data400::key::edgar_company_bdid',do1);
ut.MAC_SK_BuildProcess_v2(edgar.key_edgar_contacts_bdid,'~thor_data400::key::edgar_contacts_bdid',do2);

ut.MAC_SK_Move_v2('~thor_data400::key::edgar_company_bdid','Q',do3,2);
ut.MAC_SK_Move_v2('~thor_data400::key::edgar_contacts_bdid','Q',do4,2);

post1 := ut.SF_MaintBuilt('~thor_Data400::base::edgar_company');
post2 := ut.SF_MaintBuilt('~thor_Data400::base::edgar_contacts');

export make_edgar_bdid_keys := sequential(pre1,pre2,do1,do2,do3,do4,post1,post2);
