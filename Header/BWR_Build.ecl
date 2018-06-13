#WORKUNIT('protect',true);
// Header.BWR_Build

// USER INSTRUCTION
// 1) sandbox header.version_build to the appropriate version
// excecute notify('Build_Header_raw','*') to start a new ingest
// excecute notify('Build_Header_base','*') to resume the build after LAB pairs are ready

envVars :=
 '#WORKUNIT(\'protect\',true);\n'
+'#WORKUNIT(\'priority\',\'high\');\n'
+'#WORKUNIT(\'priority\',11);\n'
+'#STORED (\'production\', false);\n'
+'#STORED (\'_Validate_Year_Range_Low\', \'1800\');\n'
+'#STORED (\'_Validate_Year_Range_high\', ut.GetDate[1..4]);\n'
+'#OPTION (\'multiplePersistInstances\',FALSE);\n'
+'#OPTION (\'implicitSubSort\',FALSE);\n'
+'#OPTION (\'implicitBuildIndexSubSort\',FALSE);\n'
+'#OPTION (\'implicitJoinSubSort\',FALSE);\n'
+'#OPTION (\'implicitGroupSubSort\',FALSE);\n'
;
lECL1 :=
envVars
+'Header.proc_Header.STEP1;\n'
+'// sets inputs, builds source keys and header_raw. When it completes,\n'
+'// transfer output stats to Header_Build_Stats.xls and verify\n'
+'// BasicMatch Stats for unusual source spikes/drops or new sources\n'
+'// *** CONTINUE ONLY AFTER STATS HAVE BEEN SATISFACTORILY REVIEWED ****\n'
+'// Estimated THOR time: 24-48hrs\n'
;
lECL2 :=
envVars
+'Header.proc_Header.STEP2;\n'
+'// syncs header_raw to LAB LexId. Outputs header_raw_syncd and final header base file.\n'
+'// Start it after receiving confirmation that iHeader linking has completed\n'
+'// and a new LAB pairs file is available for use in Boca.\n'
+'// Transfer output stats to Header_Build_Stats.xls and verify\n'
+'// STATS, segementation, new_dids_by_src, and src counts\n'
+'// *** CONTINUE ONLY AFTER STATS HAVE BEEN SATISFACTORILY REVIEWED ****\n'
+'// Estimated THOR time: 24-48hrs\n'
;
lECL3 :=
envVars
+'Header.proc_postHeaderBuilds.XADLkeys;\n'
+'// builds a) XADL2 keys b)re-ADL external sources c)XADL1 base files.\n'
+'// a and b must have completed successfuly before\n'
+'// relatives may start.\n'
+'// Estimated THOR time: XADL2 keys 24hrs\n'
+'// External re-ADL 4-6hrs\n'
+'// XADL1 base files 48-72hrs\n'
;
lECL4 :=
envVars
+'Header.proc_postHeaderBuilds.relatives;\n'
+'// XADL2 and re-ADL external sources must have completed successfuly\n'
+'// in previous step before relatives build starts.\n'
+'// This is a disk space hog.  Some self joins are broken into pieces\n'
+'// to free up temporary space during the build or the sorts will fail.\n'
+'// Estimated THOR time: 36-48hrs\n'
;
lECL5 :=
envVars
+'Header.proc_postHeaderBuilds.headerKeys;\n'
+'//  Builds file_header_building and all header keys including\n'
+'// Relatives and XADL1.  It moves all except source keys to _QA\n'
+'// superfiles. It also builds and desprays DISTRIX Hash\n'
+'// files in a quarterly bases ie. when versio_build[5..6] in\n'
+'// [\'03\',\'06\',\'09\',\'12\']; for notification of completion\n'
+'// add your email address in misc.header_hash_split.\n'
+'// This step will use all the base files created in earlier steps\n'
+'// Estimated THOR time: 72-96hrs\n'
;
lECL6 :=
envVars
+'Header.proc_postHeaderBuilds.booleanSrch;\n'
+'// builds Power Search Boolean keys.\n'
+'// This is a disk space hog.  While it may be run as soon as\n'
+'// a new header base file is ready, it is recomende to wait\n'
+'// for header keys to finish to avoid THOR time and space\n'
+'// competiton.\n'
+'// Estimated THOR time: 24hrs\n'
;
lECL7 :=
envVars
+'Header.proc_postHeaderBuilds.FCRAheader;\n'
+'// re-ADLs FCRA EN, builds FCRA header flavor and keys.\n'
+'// While it may be run as soon as a new header base file is ready,\n'
+'// be mindfull of queue activity to avoid THOR time competiton.\n'
+'// Like Power search boolean, this is one of the last packages to be QA\'d.\n'
+'// Estimated THOR time: 24hrs\n'
;
lECL8 :=
envVars
+'Header.proc_postHeaderBuilds.finalize;\n'
+'//  *** ENSURE THAT QH IS NOT -IN PROCESS- BEFORE EXCECUTING ****\n'
+'// Moves header_raw to _PROD and source keys to _QA superfiles.\n'
+'// This is done manually to avoid collisions with Quick Header(QH).\n'
+'// The next QH will use these new files at build time.\n'
+'// NOTE: Check-in Header.version_build with the version just completed\n'
+'// The next Utility build will use this date to filter out\n'
+'// over five years old utility records as per vendor agreement\n'
+'// Estimated THOR time: 1hrs\n'
;
lECL9 :=
 'Header.proc_postHeaderBuilds.verify_all_Keys;\n'
+'// Verify that all keys and base superfiles contain the corect build version\n'
+'// Estimated THOR time: 30sec\n'
;

// Load all to the scheduler; however, load each one at a time
// Scheduler only responds to the last event defined in the scheduled workunit
// and ignores the rest.
// #workunit('name','PersonHeader: Build_Header_raw'     ); header.fSubmitNewWorkunit(lECL1, 'thor400_44') : WHEN('Build_Header_raw');
// #workunit('name','PersonHeader: Build_Header_base'    ); header.fSubmitNewWorkunit(lECL2, 'thor400_44') : WHEN('Build_Header_base');
// #workunit('name','PersonHeader: Build_XADL'           ); header.fSubmitNewWorkunit(lECL3, 'thor400_60') : WHEN('Build_XADL');
// #workunit('name','PersonHeader: Build_Relatives'      ); header.fSubmitNewWorkunit(lECL4, 'thor400_60') : WHEN('Build_Relatives');
// #workunit('name','PersonHeader: Build_Header_Keys'    ); header.fSubmitNewWorkunit(lECL5, 'thor400_60') : WHEN('Build_Header_Keys');
// #workunit('name','PersonHeader: Finalize_Header_build'); header.fSubmitNewWorkunit(lECL8, 'thor400_60') : WHEN('Finalize_Header_build');
// #workunit('name','PersonHeader: Build_FCRA_Header'    ); header.fSubmitNewWorkunit(lECL7, 'thor400_60') : WHEN('Build_FCRA_Header');
// #workunit('name','PersonHeader: Build_Header_boolean' ); header.fSubmitNewWorkunit(lECL6, 'thor400_60') : WHEN('Build_Header_boolean');

// #workunit('name','PersonHeader: Verify_Header_keys'   ); header.fSubmitNewWorkunit(lECL9, 'hthor')      : WHEN('Verify_Header_keys');

