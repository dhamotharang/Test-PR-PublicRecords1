//Run this in a build window before plateform and after platform change and write down the corresponding Workunits, 
//respectively. The workunits need t go to QA_PlatFormComparisonSummary as WU_DotID_Before and WU_DotID_After.
import BIPV2_Files, STD,BIPV2, BIPV2_Build;
iteration := '1';
ds_dot:=dataset('~thor::cemtemp::DotIterationInCA',BIPV2_Files.files_dotid().l_DOTID, THOR, OPT);
lih := ds_dot; //BIPV2_Files.files_dotid.DS_BUILDING;
#OPTION('multiplePersistInstances',FALSE);
#workunit('priority','high');
changes_it1 :='~temp::dotid::bipv2_dotid::changes_it1_' + BIPV2.KeySuffix_mod2.constant_ThisBuild_versionDate;
salt_iter :='~thor_data400::bipv2_dotid::salt_iter::' + BIPV2.KeySuffix_mod2.constant_ThisBuild_versionDate + '::it1';
SEQUENTIAL(
 STD.File.StartSuperFileTransaction(),
 STD.File.RemoveSuperFile('~keep::bipv2_dotid::dotid::matchhistory',changes_it1),
 STD.File.RemoveSuperFile('~thor_data400::bipv2_dotid::building',salt_iter),
 STD.File.FinishSuperFileTransaction(),
 BIPV2_Build.proc_dotid(lih,iteration).runIter
);
