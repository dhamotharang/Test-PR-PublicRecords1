import 
header,
watchdog,
dea,
driversV2,
prof_licenseV2,
vehiclev2,
doxie_files,
atf,
faa,
emerges,
votersv2,
sexoffender,
liensv2,
bankruptcyv2,
ln_propertyv2,
property,
doxie,
paw,
corp2,
uccv2,
business_header,
marriage_divorce_v2,
flaccidents,
patriot;

//
my_best_in 	:= pull(watchdog.Key_watchdog_glb);
my_best		:= sort(distribute(my_best_in,hash(did)),did,LOCAL);
//
// my_head 		:= dataset('~thor_data400::Base::HeaderKey_Building', header.Layout_Header, flat);
// my_fc			:= pull(property.Key_Foreclosure_DID);
// my_bk			:= pull(bankruptcyv2.key_bankruptcy_did);
// my_prop			:= pull(ln_propertyv2.key_Property_did);

layout_report1:= RECORD
recordof(my_best);
//assets
boolean has_mvr:=false;
boolean has_prop:=false;
boolean has_aircraft:=false;
boolean has_watercraft:= false;		
// business related
boolean has_paw:=false;
boolean has_corp := false;				
boolean	has_business := false;		
boolean has_ucc := false;					
// general (phone later)
boolean has_voter:=false;
boolean has_death := false;				
boolean has_marr_div := false;			
// licenses
boolean has_dl:=false;
boolean has_proflic:=false;
boolean has_dea:=false;
boolean has_atf:=false;
boolean has_airmen:=false;
boolean has_ccw:=false;
boolean has_huntfish:=false;
// derogatory/court
boolean has_crim:=false;
boolean has_sor:=false;
boolean has_lien:=false;
boolean has_bank:=false;
boolean has_foreclosure := false;			
boolean has_patriot_act := false;				
boolean has_civil_court := false;		
boolean has_official_records := false;	
boolean has_fl_accident := false;				
// rules based
end;



//********************  MACRO ******************************
mac_find_did(ds_left,ds_right,right_did,has_fld,joined_ds) := MACRO
#uniquename(find_did)
layout_report1 %find_did%(ds_left L, ds_right R) := TRANSFORM
self.has_fld:= if(L.did = (integer) R.right_did,true,false);
self:=L;
END;
#uniquename(ds_right_sorted)
%ds_right_sorted%:=sort(distribute(ds_right,hash((integer) right_did)),(integer) right_did,LOCAL);
joined_ds := JOIN(ds_left,%ds_right_sorted%, LEFT.did=(integer)RIGHT.right_did, %find_did%(LEFT,RIGHT),LEFT OUTER,LOCAL, KEEP(1));
ENDMACRO;
//******************** END MACRO ******************************

dl_dids 				:= pull(driversv2.Key_DL_DID);
mac_find_did(my_best,dl_dids,did,has_dl,my_best_1);

// IMPORTANT : Rember to use the output of previous step as input to the next..
proflic_dids		:= pull(prof_licensev2.Key_Proflic_Did);
mac_find_did(my_best_1,proflic_dids,did,has_proflic,my_best_2);

mvr_dids				:= pull(vehiclev2.Key_Vehicle_DID);
mac_find_did(my_best_2,mvr_dids,append_did,has_mvr,my_best_3);

dea_dids 			:= pull(dea.key_dea_did);
mac_find_did(my_best_3,dea_dids,my_did,has_dea,my_best_4);

atf_dids 			:= pull(atf.key_atf_did);
mac_find_did(my_best_4,atf_dids,did,has_atf,my_best_5);

aircraft_dids 	:= pull(faa.key_Aircraft_did);
mac_find_did(my_best_5,aircraft_dids,did,has_aircraft,my_best_6);

airmen_dids 		:= pull(faa.key_airmen_did);
mac_find_did(my_best_6,airmen_dids,did,has_airmen,my_best_7);

ccw_dids 			:= pull(emerges.key_ccw_did);
mac_find_did(my_best_7,ccw_dids,did_out6,has_ccw,my_best_8);

huntfish_dids	:= pull(emerges.Key_HuntFish_Did);
mac_find_did(my_best_8,huntfish_dids,did,has_huntfish,my_best_9);

voter_dids 		:= pull(votersv2.Key_Voters_DID);
mac_find_did(my_best_9,voter_dids,did,has_voter,my_best_10);

sor_dids 			:= pull(sexoffender.Key_SexOffender_DID);
mac_find_did(my_best_10,sor_dids,sdid,has_sor,my_best_11);

lien_dids			:= pull(liensv2.key_liens_DID);
mac_find_did(my_best_11,lien_dids,did,has_lien,my_best_12);

bank_dids			:= bankruptcyv2.file_bankruptcy_search_v3;
mac_find_did(my_best_12,bank_dids,did,has_bank,my_best_13);

prop_dids			:= pull(ln_propertyv2.key_Property_did);
mac_find_did(my_best_13,prop_dids,s_did,has_prop,my_best_14);

paw_dids				:= pull(paw.Key_Did);
mac_find_did(my_best_14,paw_dids,did,has_paw,my_best_15);
 
crim_dids					:= pull(doxie_files.Key_Offenders);
mac_find_did(my_best_15,crim_dids,sdid,has_crim,my_best_16);

foreclosure_dids			:= pull(property.Key_Foreclosure_DID);
mac_find_did(my_best_16,foreclosure_dids,did,has_foreclosure,my_best_17);

watercraft_dids 		:= pull(doxie.key_watercraft_did);
mac_find_did(my_best_17,watercraft_dids,l_did,has_watercraft,my_best_18);

corp_dids 					:= pull(corp2.Key_cont_did);
mac_find_did(my_best_18,corp_dids,did,has_corp,my_best_19);

business_dids				:= pull(business_header.Key_Business_Contacts_DID);
mac_find_did(my_best_19,business_dids,did,has_business,my_best_20);

ucc_dids						:= pull(uccv2.Key_Did);
mac_find_did(my_best_20,ucc_dids,did,has_ucc,my_best_21);

death_dids					:= pull(doxie.key_death_masterV2_DID);
mac_find_did(my_best_21,death_dids,l_did,has_death,my_best_22);

marr_div_dids := pull(marriage_divorce_v2.key_mar_div_did);
mac_find_did(my_best_22,marr_div_dids,did,has_marr_div,my_best_23);

patriot_act_dids :=	pull(patriot.key_did_patriot_file);
mac_find_did(my_best_23,patriot_act_dids,did,has_patriot_act,my_best_24);

fl_accident_dids := pull(flaccidents.Key_Flcrash_Did);
mac_find_did(my_best_24,fl_accident_dids,l_did,has_fl_accident,my_best_25);

my_best_extended:=my_best_25;


layout_report1_weighted:= RECORD
layout_report1;
integer rel_weight;
END;

layout_report1_weighted calc_weight(my_best_extended L):= TRANSFORM
self.rel_weight:= 
//
IF(L.has_mvr ,1,0) + 
IF(L.has_prop ,1,0) + 
IF(L.has_aircraft ,1,0) + 
IF(L.has_watercraft,1,0)+

IF(L.has_paw ,1,0) + 
IF(L.has_corp,1,0)+
IF(L.has_business,1,0)+
IF(L.has_ucc,1,0)+

IF(L.has_voter ,1,0) + 
IF(L.has_death,1,0)+

IF(L.has_dl ,1,0) + 
IF(L.has_proflic ,1,0) + 
IF(L.has_dea ,1,0) + 
IF(L.has_atf ,1,0) + 
IF(L.has_airmen ,1,0) + 
IF(L.has_ccw ,1,0) + 
IF(L.has_huntfish ,1,0) + 

IF(L.has_crim ,1,0) +
IF(L.has_sor ,1,0) + 
IF(L.has_lien ,1,0) + 
IF(L.has_bank ,1,0) + 
IF(L.has_foreclosure,1,0)+

IF(L.has_civil_court,1,0)+
IF(L.has_official_records,1,0);
//
self:=L;
END;

ds_weighted:=project(my_best_extended , calc_weight(LEFT));

output(ds_weighted,,'~thor::misc::_get_test_records');

