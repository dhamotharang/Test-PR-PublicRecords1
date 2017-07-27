import ut,doxie_build,autokey;

ut.MAC_SK_Move('~thor_data400::key::corrections_activity_' + doxie_build.buildstate,'P',do1)
ut.MAC_SK_Move('~thor_data400::key::corrections_offenders_' + doxie_build.buildstate,'P',do2)
ut.MAC_SK_Move('~thor_data400::key::corrections_offenders_docnum_' + doxie_build.buildstate,'P',do3)
ut.MAC_SK_Move('~thor_data400::key::corrections_offenders_offenderkey_' + doxie_build.buildstate,'P',do4)
ut.MAC_SK_Move('~thor_data400::key::corrections_offenses_' + doxie_build.buildstate,'P',do5)
ut.MAC_SK_Move('~thor_data400::key::corrections_court_offenses_' + doxie_build.buildstate,'P',do6)
ut.MAC_SK_Move('~thor_data400::key::corrections_punishment_' + doxie_build.buildstate,'P',do7)
ut.MAC_SK_Move('~thor_data400::key::corrections_fdid_'+doxie_build.buildstate,'Q',do8)
autokey.MAC_AcceptSK_to_QA('~thor_data400::key::corrections_'+buildstate,autokeymove);

export proc_AcceptSK_DOC_To_Prod := parallel(do1,do2,do3,do4,do5,do6,do7,do8,autokeymove);