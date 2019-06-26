﻿import ut,header,dops,_control,std;

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

build_version:= header.version_build;
dops_datasetname:='PersonHeaderKeys';
build_component:='KEY BUILD:nFCRA';

preMove:= STD.File.MoveExternalFile(_control.IPAddress.bctlpedata10, _Constant.QH_path_ready + _Constant.QH_filename, _Constant.QH_path_done + _Constant.QH_filename);

dlog:=dops.TrackBuild().fSetInfoinWorktunit(dops_datasetname,build_version,build_component);
sequential(
    dlog,
    Header.proc_postHeaderBuilds().headerKeys,
    preMove);

//  Builds file_header_building and all header keys including
// Relatives and XADL1.  It moves all except source keys to _QA
// superfiles. It also builds and desprays DISTRIX Hash
// files in a quarterly bases ie. when versio_build[5..6] in
// ['03','06','09','12']; for notification of completion
// add your email address in misc.header_hash_split.
// This step will use all the base files created in earlier steps
// Estimated THOR time: 72-96hrs

// 20190324 W20190421-062917
// 20190225 W20190320-072916
// 20180926 W20181023-081707
// 20180724 W20180821-161144
// 20180522 W20180618-094216
// 20180130 W20180301-155327