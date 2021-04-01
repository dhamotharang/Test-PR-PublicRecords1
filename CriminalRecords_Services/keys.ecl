IMPORT doxie_files, Criminal_Records;

EXPORT keys := MODULE
  // direct search keys
  EXPORT k_offender_sdid := doxie_files.Key_Offenders;
  EXPORT k_offender_docnum := doxie_files.Key_offenders_docnum;
  
  // report-generation keys
  EXPORT k_offender_ofk := doxie_files.Key_Offenders_OffenderKey;
  EXPORT k_activity_ok := doxie_files.Key_Activity;
  EXPORT k_punishment_ok := doxie_files.Key_Punishment;
  EXPORT k_offenses_ok := doxie_files.Key_Offenses;
  EXPORT k_courtOffenses_ofk := doxie_files.Key_Court_Offenses;

  // key availability tests
  EXPORT testkeys := MACRO
    OUTPUT(CriminalRecords_Services.keys.k_offender_sdid, NAMED('k_offender_sdid'));
    OUTPUT(CriminalRecords_Services.keys.k_offender_docnum, NAMED('k_offender_docnum'));
    OUTPUT(CriminalRecords_Services.keys.k_offender_ofk, NAMED('k_offender_ofk'));
    OUTPUT(CriminalRecords_Services.keys.k_activity_ok, NAMED('k_activity_ok'));
    OUTPUT(CriminalRecords_Services.keys.k_punishment_ok, NAMED('k_punishment_ok'));
    OUTPUT(CriminalRecords_Services.keys.k_offenses_ok, NAMED('k_offenses_ok'));
    OUTPUT(CriminalRecords_Services.keys.k_courtOffenses_ofk, NAMED('k_courtOffenses_ofk'));
    OUTPUT(Criminal_Records.Key_Payload, NAMED('k_auto')); // for testing only
  ENDMACRO;
END;
