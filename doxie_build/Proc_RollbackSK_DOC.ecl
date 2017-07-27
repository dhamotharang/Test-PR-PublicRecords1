import ut,doxie_build;

ut.MAC_SK_Move('~thor_data400::key::corrections_activity_' + doxie_build.buildstate,'R',do1)
ut.MAC_SK_Move('~thor_data400::key::corrections_offenders_' + doxie_build.buildstate,'R',do2)
ut.MAC_SK_Move('~thor_data400::key::corrections_offenders_docnum_' + doxie_build.buildstate,'R',do3)
ut.MAC_SK_Move('~thor_data400::key::corrections_offender_offenderkey_' + doxie_build.buildstate,'R',do4)
ut.MAC_SK_Move('~thor_data400::key::corrections_offenses_' + doxie_build.buildstate,'R',do5)
ut.MAC_SK_Move('~thor_data400::key::corrections_court_offenses_' + doxie_build.buildstate,'R',do6)
ut.MAC_SK_Move('~thor_data400::key::corrections_punishment_' + doxie_build.buildstate,'R',do7)


export Proc_RollbackSK_DOC := parallel(do1,do2,do3,do4,do5,do6,do7);
