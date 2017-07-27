/* import BIPV2_Files,BIPV2_build;
   iteration := '1';
   pversion  := '20160112';
   #workunit('name','BIPV2_POWID ' + pversion + ' Init ');
   #workunit('priority','high');
   #OPTION('multiplePersistInstances',FALSE);
   BIPV2_POWID_PlatForm._proc_powid().initFromPOWID_Down(BIPV2_Files.files_powid_down.DS_BASE(st='CA'));
*/

 
	 
/* rec:=RECORD
     unsigned6 rcid;
     string2 source;
     unsigned6 powid;
     unsigned6 orgid;
     unsigned6 ultid;
     string120 company_name;
     string250 cnp_name;
     string30 cnp_number;
     string10 prim_range;
     string28 prim_name;
     string5 zip;
     string4 zip4;
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
     string50 company_name_type_derived;
     unsigned6 company_bdid;
     unsigned3 nodes_total;
     unsigned4 dt_first_seen;
     unsigned4 dt_last_seen;
     unsigned8 cnt_prox_per_lgid3;
     string20 rid_if_big_biz;
     unsigned8 num_incs;
     unsigned8 num_legal_names;
    END;
   
   import BIPV2_Files,BIPV2_build; //
      iteration := '1';
      pversion  := '20160112';
      lih := dataset('~thor_data400::bipv2_powid_PlatForm::init::20160112copy',rec,thor);
      #OPTION('multiplePersistInstances',FALSE);
      #workunit('name','BIPV2_POWID ' + pversion + ' Specificities ');
      #workunit('priority','high');
   	BIPV2_POWID_PlatForm._proc_powid(lih,iteration).runSpecBuild;
*/


 //Run this in a build window before plateform and after platform change and write down the corresponding Workunits, 
   //respectively. The workunits need t go to QA_PlatFormComparisonSummary as WU_POWID_Before and WU_POWID_After.
	 rec:=RECORD
  unsigned6 rcid;
  string2 source;
  unsigned6 powid;
  unsigned6 orgid;
  unsigned6 ultid;
  string120 company_name;
  string250 cnp_name;
  string30 cnp_number;
  string10 prim_range;
  string28 prim_name;
  string5 zip;
  string4 zip4;
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
  string50 company_name_type_derived;
  unsigned6 company_bdid;
  unsigned3 nodes_total;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned8 cnt_prox_per_lgid3;
  string20 rid_if_big_biz;
  unsigned8 num_incs;
  unsigned8 num_legal_names;
 END;
 
   import BIPV2_Files,BIPV2_Build;
   iteration := '1';
   //lih := dataset('~thor::cemtemp::PowIdInCA',BIPV2_Files.files_powid().Layout_POWID, THOR, OPT); //BIPV2_Files.files_powid().DS_BUILDING;
	 lih := dataset('~thor_data400::bipv2_powid_PlatForm::init::20160112copy',rec,thor);
   #OPTION('multiplePersistInstances',FALSE);
   #workunit('priority','high');
	 BIPV2_POWID_PlatForm._proc_powid(lih,iteration).runIter;