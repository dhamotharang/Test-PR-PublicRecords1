import vehlic;

fl_direct_max := '20060531'; //registration_effective_date
id_direct_max := '20060931'; //registration_expiration_date
ky_direct_max := '20060731'; //title_issue_date
mn_direct_max := '20061031'; //registration_expiration_date
mo_direct_max := '20060531'; //title_issue_date
ms_direct_max := '20060531'; //title_issue_date
mt_direct_max := '20060731'; //title_issue_date
nd_direct_max := '20060931'; //registration_expiration_date
ne_direct_max := '20060731'; //registration_effective_date
nm_direct_max := '20060931'; //registration_expiration_date
nv_direct_max := '20060631'; //registration_effective_date
oh_direct_max := '20060731'; //registration_effective_date
tx_direct_max := '20060731'; //registration_effective_date
//wi_direct_max := '20060831'; //registration_effective_date
wy_direct_max := '20060631'; //registration_effective_date

//Remove WI - No longer treating it as an overlap.  Instead letting Experian_Updating_as_Vehicles handle WI records.
overlapping_states := ['FL','ID','KY','MN','MO','MS','MT','ND','NE','NM','NV','OH','TX','WY'];

//registration_effective_date_states  := ['FL','NE','NV','OH','TX','WI','WY'];
//first_registration_date_states      := ['KY','MN','MO','MS'];
//registration_expiration_date_states := ['ID','ND','NM'];
//title_issue_date_states             := ['MT'];

direct_in   := vehlic.File_Vehicles;
//experian_in := vehlic.File_Experian_Updating_Full;
//Solution to handle overload of sub-files in superfile(s).
d0         :=         dataset('~thor_data400::in::vehreg_experian_updating',vehlic.Layout_Experian_Updating_Full_premerge,flat);
d1         :=         dataset('~thor_data400::in::vehreg_experian_updating_01',vehlic.Layout_Experian_Updating_Full_premerge,flat);
d2         :=         dataset('~thor_data400::in::vehreg_experian_updating_02',vehlic.Layout_Experian_Updating_Full_premerge,flat);
d3         :=         dataset('~thor_data400::in::vehreg_experian_updating_03',vehlic.Layout_Experian_Updating_Full_premerge,flat);
d4         :=         dataset('~thor_data400::in::vehreg_experian_updating_04',vehlic.Layout_Experian_Updating_Full_premerge,flat);
d5         :=         dataset('~thor_data400::in::vehreg_experian_updating_05',vehlic.Layout_Experian_Updating_Full_premerge,flat);
d6         :=         dataset('~thor_data400::in::vehreg_experian_updating_06',vehlic.Layout_Experian_Updating_Full_premerge,flat);
d7         :=         dataset('~thor_data400::in::vehreg_experian_updating_07',vehlic.Layout_Experian_Updating_Full_premerge,flat);
d8         :=         dataset('~thor_data400::in::vehreg_experian_updating_08',vehlic.Layout_Experian_Updating_Full_premerge,flat);
 
experian_in := d1+d2+d3+d4+d5+d6+d7+d8+d0;

vehlic.Layout_Experian_Updating_Full t_map_premerge_to_expanded(vehlic.Layout_Experian_Updating_Full_premerge l) := transform
 self := l;
 self := [];
end;

dExperianPremergeExpanded := project(experian_in,t_map_premerge_to_expanded(left));

experian_concat := dExperianPremergeExpanded(append_state_origin not in overlapping_states)+vehlic.File_Experian_Updating_Full;

experian_overlapping     := experian_concat(append_state_origin     in overlapping_states);
experian_not_overlapping := experian_concat(append_state_origin not in overlapping_states);

experian_fl := experian_overlapping(append_state_origin='FL');
experian_id := experian_overlapping(append_state_origin='ID');
experian_ky := experian_overlapping(append_state_origin='KY');
experian_mn := experian_overlapping(append_state_origin='MN');
experian_mo := experian_overlapping(append_state_origin='MO');
experian_ms := experian_overlapping(append_state_origin='MS');
experian_mt := experian_overlapping(append_state_origin='MT');
experian_nd := experian_overlapping(append_state_origin='ND');
experian_ne := experian_overlapping(append_state_origin='NE');
experian_nm := experian_overlapping(append_state_origin='NM');
experian_nv := experian_overlapping(append_state_origin='NV');
experian_oh := experian_overlapping(append_state_origin='OH');
experian_tx := experian_overlapping(append_state_origin='TX');
//experian_wi := experian_overlapping(append_state_origin='WI');
experian_wy := experian_overlapping(append_state_origin='WY');

//The intent is to drop records already thought to be contained in the Direct data based on the coverage dates
experian_fl_to_keep_reg  := experian_fl(reg_renew_dt<>'',  reg_renew_dt   > fl_direct_max);
experian_fl_to_keep_tit  := experian_fl(title_trans_dt<>'',title_trans_dt > fl_direct_max);

experian_id_to_keep_reg  := experian_id(reg_exp_dt<>'',    reg_exp_dt     > id_direct_max);
experian_id_to_keep_reg2 := experian_id(reg_renew_dt<>'',  reg_renew_dt   > id_direct_max);
experian_id_to_keep_tit  := experian_id(title_trans_dt<>'',title_trans_dt > id_direct_max);

experian_ky_to_keep_reg  := experian_ky(org_reg_dt<>'',    org_reg_dt     > ky_direct_max);
experian_ky_to_keep_reg2 := experian_ky(reg_renew_dt<>'',  reg_renew_dt   > ky_direct_max);
experian_ky_to_keep_tit  := experian_ky(title_trans_dt<>'',title_trans_dt > ky_direct_max);

experian_mn_to_keep_reg  := experian_mn(reg_exp_dt<>'',    reg_exp_dt     > mn_direct_max);
experian_mn_to_keep_reg2 := experian_mn(reg_renew_dt<>'',  reg_renew_dt   > mn_direct_max);
experian_mn_to_keep_tit  := experian_mn(title_trans_dt<>'',title_trans_dt > mn_direct_max);

experian_mo_to_keep_reg  := experian_mo(org_reg_dt<>'',    org_reg_dt     > mo_direct_max);
experian_mo_to_keep_reg2 := experian_mo(reg_renew_dt<>'',  reg_renew_dt   > mo_direct_max);
experian_mo_to_keep_tit  := experian_mo(title_trans_dt<>'',title_trans_dt > mo_direct_max);

experian_ms_to_keep_reg  := experian_ms(org_reg_dt<>'',    org_reg_dt     > ms_direct_max);
experian_ms_to_keep_reg2 := experian_ms(reg_renew_dt<>'',  reg_renew_dt   > ms_direct_max);
experian_ms_to_keep_tit  := experian_ms(title_trans_dt<>'',title_trans_dt > ms_direct_max);

experian_mt_to_keep_reg  := experian_mt(reg_renew_dt<>'',  reg_renew_dt   > mt_direct_max);
experian_mt_to_keep_tit  := experian_mt(title_trans_dt<>'',title_trans_dt > mt_direct_max);

experian_nd_to_keep_reg  := experian_nd(reg_exp_dt<>'',    reg_exp_dt     > nd_direct_max);
experian_nd_to_keep_reg2 := experian_nd(reg_renew_dt<>'',  reg_renew_dt   > nd_direct_max);
experian_nd_to_keep_tit  := experian_nd(title_trans_dt<>'',title_trans_dt > nd_direct_max);

experian_ne_to_keep_reg  := experian_ne(reg_renew_dt<>'',  reg_renew_dt   > ne_direct_max);
experian_ne_to_keep_tit  := experian_ne(title_trans_dt<>'',title_trans_dt > ne_direct_max);

experian_nm_to_keep_reg  := experian_nm(reg_exp_dt<>'',    reg_exp_dt     > nm_direct_max);
experian_nm_to_keep_reg2 := experian_nm(reg_renew_dt<>'',  reg_renew_dt   > nm_direct_max);
experian_nm_to_keep_tit  := experian_nm(title_trans_dt<>'',title_trans_dt > nm_direct_max);

experian_nv_to_keep_reg  := experian_nv(reg_renew_dt<>'',  reg_renew_dt   > nv_direct_max);
experian_nv_to_keep_tit  := experian_nv(title_trans_dt<>'',title_trans_dt > nv_direct_max);

experian_oh_to_keep_reg  := experian_oh(reg_renew_dt<>'',  reg_renew_dt   > oh_direct_max);
experian_oh_to_keep_tit  := experian_oh(title_trans_dt<>'',title_trans_dt > oh_direct_max);

experian_tx_to_keep_reg  := experian_tx(reg_renew_dt<>'',  reg_renew_dt   > tx_direct_max);
experian_tx_to_keep_tit  := experian_tx(title_trans_dt<>'',title_trans_dt > tx_direct_max);

//experian_wi_to_keep_reg  := experian_wi(reg_renew_dt<>'',  reg_renew_dt   > wi_direct_max);
//experian_wi_to_keep_tit  := experian_wi(title_trans_dt<>'',title_trans_dt > wi_direct_max);

experian_wy_to_keep_reg  := experian_wy(reg_renew_dt<>'',  reg_renew_dt   > wy_direct_max);
experian_wy_to_keep_tit  := experian_wy(title_trans_dt<>'',title_trans_dt > wy_direct_max);

experian_overlapping_to_keep := 
  experian_fl_to_keep_reg
+ experian_fl_to_keep_tit
+ experian_id_to_keep_reg
+ experian_id_to_keep_reg2
+ experian_id_to_keep_tit
+ experian_ky_to_keep_reg
+ experian_ky_to_keep_reg2
+ experian_ky_to_keep_tit
+ experian_mn_to_keep_reg
+ experian_mn_to_keep_reg2
+ experian_mn_to_keep_tit
+ experian_mo_to_keep_reg
+ experian_mo_to_keep_reg2
+ experian_mo_to_keep_tit
+ experian_ms_to_keep_reg
+ experian_ms_to_keep_reg2
+ experian_ms_to_keep_tit
+ experian_mt_to_keep_reg
+ experian_mt_to_keep_tit
+ experian_nd_to_keep_reg
+ experian_nd_to_keep_reg2
+ experian_nd_to_keep_tit
+ experian_ne_to_keep_reg
+ experian_ne_to_keep_tit
+ experian_nm_to_keep_reg
+ experian_nm_to_keep_reg2
+ experian_nm_to_keep_tit
+ experian_nv_to_keep_reg
+ experian_nv_to_keep_tit
+ experian_oh_to_keep_reg
+ experian_oh_to_keep_tit
+ experian_tx_to_keep_reg
+ experian_tx_to_keep_tit
//+ experian_wi_to_keep_reg
//+ experian_wi_to_keep_tit
+ experian_wy_to_keep_reg
+ experian_wy_to_keep_tit
;

experian_out := experian_overlapping_to_keep+experian_not_overlapping;

export File_Experian_Unique := experian_out;