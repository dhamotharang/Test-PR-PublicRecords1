// change to true if the base files have been checked in to prod superfiles.
import ut;
#stored('production',false);

ut.MAC_SK_BuildProcess(key_prep_address_did,'~thor_Data400::key::hss_na_did','~thor_data400::key::hss_na_did',do1,2)
ut.MAC_SK_BuildProcess(key_prep_ssn_did,'~thor_Data400::key::hss_ns_did','~thor_data400::key::hss_ns_did',do2,2)
ut.MAC_SK_BuildProcess(key_prep_dob_did,'~thor_Data400::key::hss_nd_did','~thor_data400::key::hss_nd_did',do3,2)
ut.MAC_SK_BuildProcess(key_prep_phone_did,'~thor_Data400::key::hss_np_did','~thor_data400::key::hss_np_did',do4,2)
ut.mac_sk_buildprocess(key_prep_fuzzy_did,'~thor_Data400::key::hss_fz_did','~thor_data400::key::hss_fz_did',do5,2)
export proc_build_didkeys := parallel(do1,do2,do3,do4,do5);