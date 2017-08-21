import ut,doxie_build,autokey,roxiekeybuild;

RoxieKeyBuild.MAC_SK_Move('~thor_data400::key::corrections_activity_' + doxie_build.buildstate,'Q',do1);
RoxieKeyBuild.MAC_SK_Move('~thor_data400::key::corrections_offenders_' + doxie_build.buildstate,'Q',do2);
RoxieKeyBuild.MAC_SK_Move('~thor_data400::key::corrections_offenders_docnum_' + doxie_build.buildstate,'Q',do3);
RoxieKeyBuild.MAC_SK_Move('~thor_data400::key::corrections_offenders_offenderkey_' + doxie_build.buildstate,'Q',do4);
RoxieKeyBuild.MAC_SK_Move('~thor_data400::key::corrections_offenders_casenumber_' + doxie_build.buildstate,'Q',do20);
RoxieKeyBuild.MAC_SK_Move('~thor_data400::key::corrections_offenses_' + doxie_build.buildstate,'Q',do5);
RoxieKeyBuild.MAC_SK_Move('~thor_data400::key::corrections_court_offenses_' + doxie_build.buildstate,'Q',do6);
RoxieKeyBuild.MAC_SK_Move('~thor_data400::key::corrections_punishment_' + doxie_build.buildstate,'Q',do7);
RoxieKeyBuild.MAC_SK_Move('~thor_data400::key::corrections_fdid_'+doxie_build.buildstate,'Q',do8);

// BocaShell and FCRA Keys
RoxieKeyBuild.Mac_SK_Move('~thor_data400::key::corrections_offenders::bocashell_did','Q', do9);
RoxieKeyBuild.Mac_SK_Move('~thor_data400::key::corrections_offenders::fcra::bocashell_did','Q', do10);
RoxieKeyBuild.Mac_SK_Move('~thor_200::key::criminal_offenders::fcra::@version@::did','Q',do11);
RoxieKeyBuild.Mac_SK_Move('~thor_200::key::criminal_offenses::fcra::@version@::offender_key','Q',do12);
RoxieKeyBuild.Mac_SK_Move('~thor_200::key::criminal_punishment::fcra::@version@::offender_key.punishment_type','Q',do13);
RoxieKeyBuild.Mac_SK_Move('~thor_200::key::criminal_offenders::fcra::@version@::docnum','Q', do14);
RoxieKeyBuild.Mac_SK_Move('~thor_data400::key::corrections::fcra::offenders_offenderkey_'+ doxie_build.buildstate,'Q',do15);
RoxieKeyBuild.Mac_SK_Move('~thor_data400::key::corrections::fcra::court_offenses_'+ doxie_build.buildstate,'Q',do16);
RoxieKeyBuild.Mac_SK_Move('~thor_data400::key::corrections::fcra::activity_'+ doxie_build.buildstate,'Q',do17);
//RoxieKeyBuild.Mac_SK_Move('~thor_200::key::criminal_court_offenses::fcra::@version@::offender_key','Q',do18);
//RoxieKeyBuild.Mac_SK_Move('~thor_data400::key::corrections::fcra::doc_offenses_public_'+ doxie_build.buildstate,'Q',do19); 

autokey.MAC_AcceptSK_to_QA('~thor_data400::key::corrections_'+buildstate,autokeymove);

export proc_AcceptSK_DOC_To_QA := parallel(do1,do2,do3,do4,do5,do6,do7,do8,do9,do10,do11,do12,do13,do14,do15,do16,do17,do20,/*,do18,do19,*/autokeymove);