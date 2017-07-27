//Run this in a Build window before plateform and after platform change and write down the corresponding Workunits, 
//respectively. The workunits need t go to QA_PlatFormComparisonSummary as WU_EmpIdDown_Before and WU_EmpIdDown_After.
 
//Note, all the QA_ tests are sensitive to BIPV2.KeySuffix_mod2.constant_ThisBuild_versionDate. Make sure no change
//to BIPV2.KeySuffix_mod2.constant_ThisBuild_versionDate during the whole testing period.
import BIPV2_Files,BIPV2_Build;
iteration := '1';
lih := dataset('~thor::cemtemp::EmpIdDownInCA',BIPV2.CommonBase.Layout, THOR, OPT); //BIPV2_Files.files_empid_down().DS_BUILDING;
#OPTION('multiplePersistInstances',FALSE);
#workunit('priority','high');
possiblematches:='~thor_data400::bipv2_empid_down::possiblematches::' + BIPV2.KeySuffix_mod2.constant_ThisBuild_versionDate + '::it1';
salt_iter :='~thor_data400::bipv2_empid_down::salt_iter::' + BIPV2.KeySuffix_mod2.constant_ThisBuild_versionDate + '::it1'; 
 SEQUENTIAL(
 STD.File.StartSuperFileTransaction(),
 //STD.File.RemoveSuperFile('~tthor_data400::bipv2_empid_down::linkinghistory','~thor_data400::bipv2_empid_down::possiblematches::20150512::it1'),
 //STD.File.RemoveSuperFile('~thor_data400::bipv2_empid_down::building','~thor_data400::bipv2_empid_down::salt_iter::20150512::it1'),
 STD.File.RemoveSuperFile('~thor_data400::bipv2_empid_down::linkinghistory',possiblematches),
 STD.File.RemoveSuperFile('~thor_data400::bipv2_empid_down::building',salt_iter),
 STD.File.FinishSuperFileTransaction(),
 BIPV2_Build.proc_empid_down(lih,iteration).runIter;
);

