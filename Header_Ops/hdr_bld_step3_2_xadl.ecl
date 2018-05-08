import header;
#WORKUNIT('protect',true);
#WORKUNIT('priority','high');
#WORKUNIT('priority',11);
#STORED ('production', false);
#STORED ('_Validate_Year_Range_Low', '1800');
#STORED ('_Validate_Year_Range_high', ut.GetDate[1..4]);
#OPTION ('multiplePersistInstances',FALSE);
#OPTION ('implicitSubSort',FALSE);
#OPTION ('implicitBuildIndexSubSort',FALSE);
#OPTION ('implicitJoinSubSort',FALSE);
#OPTION ('implicitGroupSubSort',FALSE);
Header.proc_postHeaderBuilds.XADLkeys;
// builds a) XADL2 keys b)re-ADL external sources c)XADL1 base files.
// a and b must have completed successfuly before
// relatives may start.
// Estimated THOR time: XADL2 keys 24hrs
// External re-ADL 4-6hrs
// XADL1 base files 48-72hrs
