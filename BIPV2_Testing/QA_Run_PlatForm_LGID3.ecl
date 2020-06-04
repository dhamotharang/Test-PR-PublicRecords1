/*  //Specificity may need to re-calculate because our development in the dataland2 may change it.
    //use the following to re-calculate the specificity every time when you start a test.
   
   rec:=RECORD
   unsigned6 rcid;
   string2 source;
   unsigned6 dotid;
   unsigned6 proxid;
   unsigned6 lgid3;
   unsigned6 seleid;
   unsigned6 orgid;
   unsigned6 ultid;
   unsigned3 nodes_total;
   string120 company_name;
   string30 cnp_number;
   string9 active_duns_number;
   string9 duns_number;
   string9 company_fein;
   string2 company_inc_state;
   string32 company_charter_number;
   string10 cnp_btype;
   string50 company_name_type_derived;
   string9 hist_duns_number;
   string30 active_domestic_corp_key;
   string30 hist_domestic_corp_key;
   string30 foreign_corp_key;
   string30 unk_corp_key;
   string250 cnp_name;
   string1 cnp_hasnumber;
   string20 cnp_lowv;
   boolean cnp_translated;
   integer4 cnp_classid;
   string10 prim_range;
   string28 prim_name;
   string8 sec_range;
   string25 v_city_name;
   string2 st;
   string5 zip;
   unsigned4 dt_first_seen;
   unsigned4 dt_last_seen;
   string34 sbfe_id;
   boolean has_lgid;
   boolean is_sele_level;
   boolean is_org_level;
   boolean is_ult_level;
   unsigned6 parent_proxid;
   unsigned6 sele_proxid;
   unsigned6 org_proxid;
   unsigned6 ultimate_proxid;
   unsigned2 levels_from_top;
   string10 nodes_below_st;
   string20 lgid3ifhrchy;
   unsigned6 originalseleid;
   unsigned6 originalorgid;
   END;
   import BIPV2_Files,BIPV2_LGID3;
   iteration := '1';
   lih := dataset('~thor::cemtemp::LgIDIterationInCA_F',rec, THOR, OPT); //BIPV2_Files.files_lgid3.DS_BUILDING;
   #OPTION('multiplePersistInstances',FALSE);
   #workunit('priority','high');
   BIPV2_LGID3_PlatForm._proc_lgid3(lih,iteration).runSpecBuild;
   
*/


//Run this in a Build window before plateform and after platform change and write down the corresponding Workunits, 
//respectively. The workunits need t go to QA_PlatFormComparisonSummary as WU_LGID3_Before and WU_LGID3_After.

import BIPV2_Files,BIPV2_LGID3,BIPV2,STD;
iteration := '1';
rec:=RECORD
unsigned6 rcid;
string2 source;
unsigned6 dotid;
unsigned6 proxid;
unsigned6 lgid3;
unsigned6 seleid;
unsigned6 orgid;
unsigned6 ultid;
unsigned3 nodes_total;
string120 company_name;
string30 cnp_number;
string9 active_duns_number;
string9 duns_number;
string9 company_fein;
string2 company_inc_state;
string32 company_charter_number;
string10 cnp_btype;
string50 company_name_type_derived;
string9 hist_duns_number;
string30 active_domestic_corp_key;
string30 hist_domestic_corp_key;
string30 foreign_corp_key;
string30 unk_corp_key;
string250 cnp_name;
string1 cnp_hasnumber;
string20 cnp_lowv;
boolean cnp_translated;
integer4 cnp_classid;
string10 prim_range;
string28 prim_name;
string8 sec_range;
string25 v_city_name;
string2 st;
string5 zip;
unsigned4 dt_first_seen;
unsigned4 dt_last_seen;
string34 sbfe_id;
boolean has_lgid;
boolean is_sele_level;
boolean is_org_level;
boolean is_ult_level;
unsigned6 parent_proxid;
unsigned6 sele_proxid;
unsigned6 org_proxid;
unsigned6 ultimate_proxid;
unsigned2 levels_from_top;
string10 nodes_below_st;
string20 lgid3ifhrchy;
unsigned6 originalseleid;
unsigned6 originalorgid;
END;

lih := dataset('~thor::cemtemp::LgIDIterationInCA_F',rec, THOR, OPT); // BIPV2_Files.files_lgid3.DS_BUILDING;
#OPTION('multiplePersistInstances',FALSE);
#workunit('priority','high');
changes_it1:='~temp::lgid3::bipv2_lgid3_platform::changes_it1_' + BIPV2.KeySuffix_mod2.constant_ThisBuild_versionDate;
salt_iter :='~thor_data400::bipv2_lgid3_platform::salt_iter::' + BIPV2.KeySuffix_mod2.constant_ThisBuild_versionDate + '::it1';
possiblematches:='~thor_data400::bipv2_lgid3_platform::possiblematches::' + BIPV2.KeySuffix_mod2.constant_ThisBuild_versionDate + '::it1';
SEQUENTIAL(
STD.File.StartSuperFileTransaction(),
STD.File.RemoveSuperFile('~keep::bipv2_lgid3_platform::lgid3::matchhistory',changes_it1),
STD.File.RemoveSuperFile('~thor_data400::bipv2_lgid3_platform::building',salt_iter),
STD.File.RemoveSuperFile('~thor_data400::bipv2_lgid3_platform::linkinghistory',possiblematches),
STD.File.FinishSuperFileTransaction(),
//BIPV2_LGID3._proc_lgid3(lih,iteration).runIter
BIPV2_LGID3_PlatForm._proc_lgid3(lih,iteration).runIter;
);