//------------------------------ This can work subject upon HPCC bug 14936 is fixed.
//If things go wrong, you'd better to start from specificities calculation below. Then start the test.
/* Rec:=RECORD
     unsigned6 rcid;
     string2 source;
     unsigned6 empid;
     unsigned6 seleid;
     unsigned6 orgid;
     unsigned6 ultid;
     string50 contact_job_title_derived;
     string10 prim_range;
     string28 prim_name;
     string5 zip;
     string4 zip4;
     string20 fname;
     string20 lname;
     string10 contact_phone;
     unsigned6 contact_did;
     string9 contact_ssn;
     string120 company_name;
     string8 sec_range;
     string25 v_city_name;
     string2 st;
     string2 company_inc_state;
     string32 company_charter_number;
     string9 active_duns_number;
     string9 hist_duns_number;
     string30 active_domestic_corp_key;
     string30 hist_domestic_corp_key;
     string30 foreign_corp_key;
     string30 unk_corp_key;
     string9 company_fein;
     string10 cnp_btype;
     string250 cnp_name;
     string50 company_name_type_derived;
     unsigned6 company_bdid;
     unsigned3 nodes_total;
     unsigned4 dt_first_seen;
     unsigned4 dt_last_seen;
     string1 iscorp;
     string120 cname_devanitize;
     string1 iscorpenhanced;
    END;
   
   
   import BIPV2_Files,BIPV2_build;
   iteration := '1';
   pversion  := '20160112';
   #OPTION('multiplePersistInstances',FALSE);
   lih := dataset('~thor_data400::bipv2_empid_platform::init::20160112copy',rec,thor);
   #workunit('name','BIPv2_EmpID ' + pversion + ' Specificities ');
   #workunit('priority','high');
   BIPV2_EmpID_PlatForm.proc_empid_PlatForm(lih,iteration).runSpecBuild;
*/
//-------------------This is the test part
//Run this in a build window before platform and after platform change and write down the corresponding Workunits, 
//respectively. The workunits need to go to QA_PlatFormComparisonSummary as WU_EmpID_Before and WU_EmpID_After  
/* //Old code
	import BIPV2_Files,BIPV2_Build;
   iteration := '1';
   #OPTION('multiplePersistInstances',FALSE);
   lih := dataset('~thor::cemtemp::EmpIdInCA',BIPV2_Files.files_empid().Layout_EmpID, THOR, OPT); //BIPV2_Files.files_empid().DS_BUILDING;
   #workunit('priority','high');
   
   changes_it1 :='~temp::empid::bipv2_empid::changes_it1_' + BIPV2.KeySuffix_mod2.constant_ThisBuild_versionDate;
   salt_iter :='~thor_data400::bipv2_empid::salt_iter::' + BIPV2.KeySuffix_mod2.constant_ThisBuild_versionDate + '::it1';
   SEQUENTIAL(
   STD.File.StartSuperFileTransaction(),
   //STD.File.RemoveSuperFile('~keep::bipv2_empid::empid::matchhistory','~temp::empid::bipv2_empid::changes_it1_20150512'),
   //STD.File.RemoveSuperFile('~thor_data400::bipv2_empid::building','~thor_data400::bipv2_empid::salt_iter::20150512::it1'),
   STD.File.RemoveSuperFile('~keep::bipv2_empid::empid::matchhistory',changes_it1),
   STD.File.RemoveSuperFile('~thor_data400::bipv2_empid::building',salt_iter),
   STD.File.FinishSuperFileTransaction(),
   BIPV2_Build.proc_empid(lih,iteration).runIter
   );
*/
Rec:=RECORD
  unsigned6 rcid;
  string2 source;
  unsigned6 empid;
  unsigned6 seleid;
  unsigned6 orgid;
  unsigned6 ultid;
  string50 contact_job_title_derived;
  string10 prim_range;
  string28 prim_name;
  string5 zip;
  string4 zip4;
  string20 fname;
  string20 lname;
  string10 contact_phone;
  unsigned6 contact_did;
  string9 contact_ssn;
  string120 company_name;
  string8 sec_range;
  string25 v_city_name;
  string2 st;
  string2 company_inc_state;
  string32 company_charter_number;
  string9 active_duns_number;
  string9 hist_duns_number;
  string30 active_domestic_corp_key;
  string30 hist_domestic_corp_key;
  string30 foreign_corp_key;
  string30 unk_corp_key;
  string9 company_fein;
  string10 cnp_btype;
  string250 cnp_name;
  string50 company_name_type_derived;
  unsigned6 company_bdid;
  unsigned3 nodes_total;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  string1 iscorp;
  string120 cname_devanitize;
  string1 iscorpenhanced;
 END;
 
 import BIPV2_Files,BIPV2_build;
iteration := '1';
pversion  := '20160112';
#OPTION('multiplePersistInstances',FALSE);
lih := dataset('~thor_data400::bipv2_empid_platform::init::20160112copy',rec,thor);
#workunit('name','BIPv2_EmpID ' + pversion + ' iter ' + iteration);
#workunit('priority','high');
//BIPV2_build.proc_empid(lih,iteration).runIter;
BIPV2_EmpID_PlatForm.proc_empid_PlatForm(lih,iteration).runIter

