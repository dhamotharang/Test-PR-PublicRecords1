import ut;

ut.MAC_SK_BuildProcess_v2(dnb.Key_DNB_BDID,'~thor_data400::key::dnb_bdid',do1);
ut.mac_sk_buildprocess_v2(dnb.Key_DnB_ContactName,'~thor_Data400::key::dnb_contactname',do2);
ut.MAC_SK_BuildProcess_v2(dnb.key_DNB_DunsNum,'~thor_data400::key::dnb_dunsnum',do3);
ut.mac_sk_buildprocess_v2(dnb.key_dnb_contacts_dunsnum,'~thor_data400::key::dnb_contacts_dunsnum',do4);

export Proc_build_keys := parallel(do1,do2,do3,do4);