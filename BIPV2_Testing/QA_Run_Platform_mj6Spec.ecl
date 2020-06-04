//Run this in a build window before plateform and after platform change and write down the corresponding Workunits, 
//respectively. The workunits need t go to QA_PlatFormComparisonSummary as WU_Mj6Spec_Before and WU_Mj6Spec_After.
import BIPV2_ProxID_mj6;
#OPTION('multiplePersistInstances',FALSE);
#workunit('priority','high');
rec:=RECORD
unsigned6 rcid;
string2 source;
unsigned6 dotid;
unsigned6 proxid;
unsigned6 lgid3;
unsigned6 orgid;
unsigned6 ultid;
string250 cnp_name;
string30 cnp_number;
string10 prim_range;
string28 prim_name_derived;
string8 sec_range;
string25 v_city_name;
string2 st;
string5 zip;
string9 active_duns_number;
string9 hist_duns_number;
string9 active_enterprise_number;
string9 hist_enterprise_number;
string9 ebr_file_number;
string30 active_domestic_corp_key;
string30 hist_domestic_corp_key;
string30 foreign_corp_key;
string30 unk_corp_key;
unsigned4 dt_first_seen;
unsigned4 dt_last_seen;
string9 company_fein;
string10 company_phone;
string2 company_inc_state;
string32 company_charter_number;
END;

//dotbase := BIPV2_ProxID_mj6._files().base.built(st='CA');
h:=dataset('~thor::cemtemp::mj6Input_CA',rec, THOR, OPT);
SpecMod := BIPV2_ProxID_mj6_PlatForm.specificities(h);
sequential(
SpecMod.Build
,parallel(
OUTPUT(SpecMod.Specificities ,NAMED('Specificities'))
,OUTPUT(SpecMod.SpcShift      ,NAMED('SpcShift'     ))
// ,SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,'BIPV2_ProxID_mj6._SPC',dotbase,,false)
)
);