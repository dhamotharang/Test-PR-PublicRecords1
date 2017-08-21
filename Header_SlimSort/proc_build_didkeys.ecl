// change to true if the base files have been checked in to prod superfiles.
import ut;

ut.MAC_SK_BuildProcess_v2(key_prep_address_did,'~thor_Data400::key::hss_na_did',do1);
ut.MAC_SK_BuildProcess_v2(key_prep_ssn_did,'~thor_Data400::key::hss_ns_did',do2);
ut.MAC_SK_BuildProcess_v2(key_prep_dob_did,'~thor_Data400::key::hss_nd_did',do3);
ut.MAC_SK_BuildProcess_v2(key_prep_phone_did,'~thor_Data400::key::hss_np_did',do4);
ut.mac_sk_buildprocess_v2(key_prep_fuzzy_did,'~thor_Data400::key::hss_fz_did',do5);

export proc_build_didkeys := parallel(do1,do2,do3,do4,do5);