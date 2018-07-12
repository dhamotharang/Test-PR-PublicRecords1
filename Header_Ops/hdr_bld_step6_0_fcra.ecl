﻿import ut,header;
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
#stored ('emailList', 'gabriel.marcan@lexisnexisrisk.com,Debendra.Kumar@lexisnexisrisk.com'); 
Header.proc_postHeaderBuilds.FCRAheader;
// re-ADLs FCRA EN, builds FCRA header flavor and keys.
// While it may be run as soon as a new header base file is ready,
// be mindfull of queue activity to avoid THOR time competiton.
// Like Power search boolean, this is one of the last packages to be QA'd.
// Estimated THOR time: 24hrs