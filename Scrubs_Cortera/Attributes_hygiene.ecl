IMPORT SALT311,STD;
EXPORT Attributes_hygiene(dataset(Attributes_layout_Cortera) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_ultimate_linkid_cnt := COUNT(GROUP,h.ultimate_linkid <> (TYPEOF(h.ultimate_linkid))'');
    populated_ultimate_linkid_pcnt := AVE(GROUP,IF(h.ultimate_linkid = (TYPEOF(h.ultimate_linkid))'',0,100));
    maxlength_ultimate_linkid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultimate_linkid)));
    avelength_ultimate_linkid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultimate_linkid)),h.ultimate_linkid<>(typeof(h.ultimate_linkid))'');
    populated_cortera_score_cnt := COUNT(GROUP,h.cortera_score <> (TYPEOF(h.cortera_score))'');
    populated_cortera_score_pcnt := AVE(GROUP,IF(h.cortera_score = (TYPEOF(h.cortera_score))'',0,100));
    maxlength_cortera_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cortera_score)));
    avelength_cortera_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cortera_score)),h.cortera_score<>(typeof(h.cortera_score))'');
    populated_cpr_score_cnt := COUNT(GROUP,h.cpr_score <> (TYPEOF(h.cpr_score))'');
    populated_cpr_score_pcnt := AVE(GROUP,IF(h.cpr_score = (TYPEOF(h.cpr_score))'',0,100));
    maxlength_cpr_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpr_score)));
    avelength_cpr_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpr_score)),h.cpr_score<>(typeof(h.cpr_score))'');
    populated_cpr_segment_cnt := COUNT(GROUP,h.cpr_segment <> (TYPEOF(h.cpr_segment))'');
    populated_cpr_segment_pcnt := AVE(GROUP,IF(h.cpr_segment = (TYPEOF(h.cpr_segment))'',0,100));
    maxlength_cpr_segment := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpr_segment)));
    avelength_cpr_segment := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cpr_segment)),h.cpr_segment<>(typeof(h.cpr_segment))'');
    populated_dbt_cnt := COUNT(GROUP,h.dbt <> (TYPEOF(h.dbt))'');
    populated_dbt_pcnt := AVE(GROUP,IF(h.dbt = (TYPEOF(h.dbt))'',0,100));
    maxlength_dbt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbt)));
    avelength_dbt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbt)),h.dbt<>(typeof(h.dbt))'');
    populated_avg_bal_cnt := COUNT(GROUP,h.avg_bal <> (TYPEOF(h.avg_bal))'');
    populated_avg_bal_pcnt := AVE(GROUP,IF(h.avg_bal = (TYPEOF(h.avg_bal))'',0,100));
    maxlength_avg_bal := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.avg_bal)));
    avelength_avg_bal := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.avg_bal)),h.avg_bal<>(typeof(h.avg_bal))'');
    populated_air_spend_cnt := COUNT(GROUP,h.air_spend <> (TYPEOF(h.air_spend))'');
    populated_air_spend_pcnt := AVE(GROUP,IF(h.air_spend = (TYPEOF(h.air_spend))'',0,100));
    maxlength_air_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.air_spend)));
    avelength_air_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.air_spend)),h.air_spend<>(typeof(h.air_spend))'');
    populated_fuel_spend_cnt := COUNT(GROUP,h.fuel_spend <> (TYPEOF(h.fuel_spend))'');
    populated_fuel_spend_pcnt := AVE(GROUP,IF(h.fuel_spend = (TYPEOF(h.fuel_spend))'',0,100));
    maxlength_fuel_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fuel_spend)));
    avelength_fuel_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fuel_spend)),h.fuel_spend<>(typeof(h.fuel_spend))'');
    populated_leasing_spend_cnt := COUNT(GROUP,h.leasing_spend <> (TYPEOF(h.leasing_spend))'');
    populated_leasing_spend_pcnt := AVE(GROUP,IF(h.leasing_spend = (TYPEOF(h.leasing_spend))'',0,100));
    maxlength_leasing_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.leasing_spend)));
    avelength_leasing_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.leasing_spend)),h.leasing_spend<>(typeof(h.leasing_spend))'');
    populated_ltl_spend_cnt := COUNT(GROUP,h.ltl_spend <> (TYPEOF(h.ltl_spend))'');
    populated_ltl_spend_pcnt := AVE(GROUP,IF(h.ltl_spend = (TYPEOF(h.ltl_spend))'',0,100));
    maxlength_ltl_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ltl_spend)));
    avelength_ltl_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ltl_spend)),h.ltl_spend<>(typeof(h.ltl_spend))'');
    populated_rail_spend_cnt := COUNT(GROUP,h.rail_spend <> (TYPEOF(h.rail_spend))'');
    populated_rail_spend_pcnt := AVE(GROUP,IF(h.rail_spend = (TYPEOF(h.rail_spend))'',0,100));
    maxlength_rail_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rail_spend)));
    avelength_rail_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rail_spend)),h.rail_spend<>(typeof(h.rail_spend))'');
    populated_tl_spend_cnt := COUNT(GROUP,h.tl_spend <> (TYPEOF(h.tl_spend))'');
    populated_tl_spend_pcnt := AVE(GROUP,IF(h.tl_spend = (TYPEOF(h.tl_spend))'',0,100));
    maxlength_tl_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tl_spend)));
    avelength_tl_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tl_spend)),h.tl_spend<>(typeof(h.tl_spend))'');
    populated_transvc_spend_cnt := COUNT(GROUP,h.transvc_spend <> (TYPEOF(h.transvc_spend))'');
    populated_transvc_spend_pcnt := AVE(GROUP,IF(h.transvc_spend = (TYPEOF(h.transvc_spend))'',0,100));
    maxlength_transvc_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transvc_spend)));
    avelength_transvc_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transvc_spend)),h.transvc_spend<>(typeof(h.transvc_spend))'');
    populated_transup_spend_cnt := COUNT(GROUP,h.transup_spend <> (TYPEOF(h.transup_spend))'');
    populated_transup_spend_pcnt := AVE(GROUP,IF(h.transup_spend = (TYPEOF(h.transup_spend))'',0,100));
    maxlength_transup_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transup_spend)));
    avelength_transup_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transup_spend)),h.transup_spend<>(typeof(h.transup_spend))'');
    populated_bst_spend_cnt := COUNT(GROUP,h.bst_spend <> (TYPEOF(h.bst_spend))'');
    populated_bst_spend_pcnt := AVE(GROUP,IF(h.bst_spend = (TYPEOF(h.bst_spend))'',0,100));
    maxlength_bst_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bst_spend)));
    avelength_bst_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bst_spend)),h.bst_spend<>(typeof(h.bst_spend))'');
    populated_dg_spend_cnt := COUNT(GROUP,h.dg_spend <> (TYPEOF(h.dg_spend))'');
    populated_dg_spend_pcnt := AVE(GROUP,IF(h.dg_spend = (TYPEOF(h.dg_spend))'',0,100));
    maxlength_dg_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dg_spend)));
    avelength_dg_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dg_spend)),h.dg_spend<>(typeof(h.dg_spend))'');
    populated_electrical_spend_cnt := COUNT(GROUP,h.electrical_spend <> (TYPEOF(h.electrical_spend))'');
    populated_electrical_spend_pcnt := AVE(GROUP,IF(h.electrical_spend = (TYPEOF(h.electrical_spend))'',0,100));
    maxlength_electrical_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.electrical_spend)));
    avelength_electrical_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.electrical_spend)),h.electrical_spend<>(typeof(h.electrical_spend))'');
    populated_hvac_spend_cnt := COUNT(GROUP,h.hvac_spend <> (TYPEOF(h.hvac_spend))'');
    populated_hvac_spend_pcnt := AVE(GROUP,IF(h.hvac_spend = (TYPEOF(h.hvac_spend))'',0,100));
    maxlength_hvac_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hvac_spend)));
    avelength_hvac_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hvac_spend)),h.hvac_spend<>(typeof(h.hvac_spend))'');
    populated_other_b_spend_cnt := COUNT(GROUP,h.other_b_spend <> (TYPEOF(h.other_b_spend))'');
    populated_other_b_spend_pcnt := AVE(GROUP,IF(h.other_b_spend = (TYPEOF(h.other_b_spend))'',0,100));
    maxlength_other_b_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_b_spend)));
    avelength_other_b_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_b_spend)),h.other_b_spend<>(typeof(h.other_b_spend))'');
    populated_plumbing_spend_cnt := COUNT(GROUP,h.plumbing_spend <> (TYPEOF(h.plumbing_spend))'');
    populated_plumbing_spend_pcnt := AVE(GROUP,IF(h.plumbing_spend = (TYPEOF(h.plumbing_spend))'',0,100));
    maxlength_plumbing_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.plumbing_spend)));
    avelength_plumbing_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.plumbing_spend)),h.plumbing_spend<>(typeof(h.plumbing_spend))'');
    populated_rs_spend_cnt := COUNT(GROUP,h.rs_spend <> (TYPEOF(h.rs_spend))'');
    populated_rs_spend_pcnt := AVE(GROUP,IF(h.rs_spend = (TYPEOF(h.rs_spend))'',0,100));
    maxlength_rs_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rs_spend)));
    avelength_rs_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rs_spend)),h.rs_spend<>(typeof(h.rs_spend))'');
    populated_wp_spend_cnt := COUNT(GROUP,h.wp_spend <> (TYPEOF(h.wp_spend))'');
    populated_wp_spend_pcnt := AVE(GROUP,IF(h.wp_spend = (TYPEOF(h.wp_spend))'',0,100));
    maxlength_wp_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.wp_spend)));
    avelength_wp_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.wp_spend)),h.wp_spend<>(typeof(h.wp_spend))'');
    populated_chemical_spend_cnt := COUNT(GROUP,h.chemical_spend <> (TYPEOF(h.chemical_spend))'');
    populated_chemical_spend_pcnt := AVE(GROUP,IF(h.chemical_spend = (TYPEOF(h.chemical_spend))'',0,100));
    maxlength_chemical_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.chemical_spend)));
    avelength_chemical_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.chemical_spend)),h.chemical_spend<>(typeof(h.chemical_spend))'');
    populated_electronic_spend_cnt := COUNT(GROUP,h.electronic_spend <> (TYPEOF(h.electronic_spend))'');
    populated_electronic_spend_pcnt := AVE(GROUP,IF(h.electronic_spend = (TYPEOF(h.electronic_spend))'',0,100));
    maxlength_electronic_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.electronic_spend)));
    avelength_electronic_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.electronic_spend)),h.electronic_spend<>(typeof(h.electronic_spend))'');
    populated_metal_spend_cnt := COUNT(GROUP,h.metal_spend <> (TYPEOF(h.metal_spend))'');
    populated_metal_spend_pcnt := AVE(GROUP,IF(h.metal_spend = (TYPEOF(h.metal_spend))'',0,100));
    maxlength_metal_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.metal_spend)));
    avelength_metal_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.metal_spend)),h.metal_spend<>(typeof(h.metal_spend))'');
    populated_other_m_spend_cnt := COUNT(GROUP,h.other_m_spend <> (TYPEOF(h.other_m_spend))'');
    populated_other_m_spend_pcnt := AVE(GROUP,IF(h.other_m_spend = (TYPEOF(h.other_m_spend))'',0,100));
    maxlength_other_m_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_m_spend)));
    avelength_other_m_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_m_spend)),h.other_m_spend<>(typeof(h.other_m_spend))'');
    populated_packaging_spend_cnt := COUNT(GROUP,h.packaging_spend <> (TYPEOF(h.packaging_spend))'');
    populated_packaging_spend_pcnt := AVE(GROUP,IF(h.packaging_spend = (TYPEOF(h.packaging_spend))'',0,100));
    maxlength_packaging_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.packaging_spend)));
    avelength_packaging_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.packaging_spend)),h.packaging_spend<>(typeof(h.packaging_spend))'');
    populated_pvf_spend_cnt := COUNT(GROUP,h.pvf_spend <> (TYPEOF(h.pvf_spend))'');
    populated_pvf_spend_pcnt := AVE(GROUP,IF(h.pvf_spend = (TYPEOF(h.pvf_spend))'',0,100));
    maxlength_pvf_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pvf_spend)));
    avelength_pvf_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pvf_spend)),h.pvf_spend<>(typeof(h.pvf_spend))'');
    populated_plastic_spend_cnt := COUNT(GROUP,h.plastic_spend <> (TYPEOF(h.plastic_spend))'');
    populated_plastic_spend_pcnt := AVE(GROUP,IF(h.plastic_spend = (TYPEOF(h.plastic_spend))'',0,100));
    maxlength_plastic_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.plastic_spend)));
    avelength_plastic_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.plastic_spend)),h.plastic_spend<>(typeof(h.plastic_spend))'');
    populated_textile_spend_cnt := COUNT(GROUP,h.textile_spend <> (TYPEOF(h.textile_spend))'');
    populated_textile_spend_pcnt := AVE(GROUP,IF(h.textile_spend = (TYPEOF(h.textile_spend))'',0,100));
    maxlength_textile_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.textile_spend)));
    avelength_textile_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.textile_spend)),h.textile_spend<>(typeof(h.textile_spend))'');
    populated_bs_spend_cnt := COUNT(GROUP,h.bs_spend <> (TYPEOF(h.bs_spend))'');
    populated_bs_spend_pcnt := AVE(GROUP,IF(h.bs_spend = (TYPEOF(h.bs_spend))'',0,100));
    maxlength_bs_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bs_spend)));
    avelength_bs_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bs_spend)),h.bs_spend<>(typeof(h.bs_spend))'');
    populated_ce_spend_cnt := COUNT(GROUP,h.ce_spend <> (TYPEOF(h.ce_spend))'');
    populated_ce_spend_pcnt := AVE(GROUP,IF(h.ce_spend = (TYPEOF(h.ce_spend))'',0,100));
    maxlength_ce_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ce_spend)));
    avelength_ce_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ce_spend)),h.ce_spend<>(typeof(h.ce_spend))'');
    populated_hardware_spend_cnt := COUNT(GROUP,h.hardware_spend <> (TYPEOF(h.hardware_spend))'');
    populated_hardware_spend_pcnt := AVE(GROUP,IF(h.hardware_spend = (TYPEOF(h.hardware_spend))'',0,100));
    maxlength_hardware_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hardware_spend)));
    avelength_hardware_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hardware_spend)),h.hardware_spend<>(typeof(h.hardware_spend))'');
    populated_ie_spend_cnt := COUNT(GROUP,h.ie_spend <> (TYPEOF(h.ie_spend))'');
    populated_ie_spend_pcnt := AVE(GROUP,IF(h.ie_spend = (TYPEOF(h.ie_spend))'',0,100));
    maxlength_ie_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ie_spend)));
    avelength_ie_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ie_spend)),h.ie_spend<>(typeof(h.ie_spend))'');
    populated_is_spend_cnt := COUNT(GROUP,h.is_spend <> (TYPEOF(h.is_spend))'');
    populated_is_spend_pcnt := AVE(GROUP,IF(h.is_spend = (TYPEOF(h.is_spend))'',0,100));
    maxlength_is_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.is_spend)));
    avelength_is_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.is_spend)),h.is_spend<>(typeof(h.is_spend))'');
    populated_it_spend_cnt := COUNT(GROUP,h.it_spend <> (TYPEOF(h.it_spend))'');
    populated_it_spend_pcnt := AVE(GROUP,IF(h.it_spend = (TYPEOF(h.it_spend))'',0,100));
    maxlength_it_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.it_spend)));
    avelength_it_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.it_spend)),h.it_spend<>(typeof(h.it_spend))'');
    populated_mls_spend_cnt := COUNT(GROUP,h.mls_spend <> (TYPEOF(h.mls_spend))'');
    populated_mls_spend_pcnt := AVE(GROUP,IF(h.mls_spend = (TYPEOF(h.mls_spend))'',0,100));
    maxlength_mls_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mls_spend)));
    avelength_mls_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mls_spend)),h.mls_spend<>(typeof(h.mls_spend))'');
    populated_os_spend_cnt := COUNT(GROUP,h.os_spend <> (TYPEOF(h.os_spend))'');
    populated_os_spend_pcnt := AVE(GROUP,IF(h.os_spend = (TYPEOF(h.os_spend))'',0,100));
    maxlength_os_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.os_spend)));
    avelength_os_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.os_spend)),h.os_spend<>(typeof(h.os_spend))'');
    populated_pp_spend_cnt := COUNT(GROUP,h.pp_spend <> (TYPEOF(h.pp_spend))'');
    populated_pp_spend_pcnt := AVE(GROUP,IF(h.pp_spend = (TYPEOF(h.pp_spend))'',0,100));
    maxlength_pp_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pp_spend)));
    avelength_pp_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pp_spend)),h.pp_spend<>(typeof(h.pp_spend))'');
    populated_sis_spend_cnt := COUNT(GROUP,h.sis_spend <> (TYPEOF(h.sis_spend))'');
    populated_sis_spend_pcnt := AVE(GROUP,IF(h.sis_spend = (TYPEOF(h.sis_spend))'',0,100));
    maxlength_sis_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sis_spend)));
    avelength_sis_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sis_spend)),h.sis_spend<>(typeof(h.sis_spend))'');
    populated_apparel_spend_cnt := COUNT(GROUP,h.apparel_spend <> (TYPEOF(h.apparel_spend))'');
    populated_apparel_spend_pcnt := AVE(GROUP,IF(h.apparel_spend = (TYPEOF(h.apparel_spend))'',0,100));
    maxlength_apparel_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.apparel_spend)));
    avelength_apparel_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.apparel_spend)),h.apparel_spend<>(typeof(h.apparel_spend))'');
    populated_beverages_spend_cnt := COUNT(GROUP,h.beverages_spend <> (TYPEOF(h.beverages_spend))'');
    populated_beverages_spend_pcnt := AVE(GROUP,IF(h.beverages_spend = (TYPEOF(h.beverages_spend))'',0,100));
    maxlength_beverages_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.beverages_spend)));
    avelength_beverages_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.beverages_spend)),h.beverages_spend<>(typeof(h.beverages_spend))'');
    populated_constr_spend_cnt := COUNT(GROUP,h.constr_spend <> (TYPEOF(h.constr_spend))'');
    populated_constr_spend_pcnt := AVE(GROUP,IF(h.constr_spend = (TYPEOF(h.constr_spend))'',0,100));
    maxlength_constr_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.constr_spend)));
    avelength_constr_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.constr_spend)),h.constr_spend<>(typeof(h.constr_spend))'');
    populated_consulting_spend_cnt := COUNT(GROUP,h.consulting_spend <> (TYPEOF(h.consulting_spend))'');
    populated_consulting_spend_pcnt := AVE(GROUP,IF(h.consulting_spend = (TYPEOF(h.consulting_spend))'',0,100));
    maxlength_consulting_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.consulting_spend)));
    avelength_consulting_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.consulting_spend)),h.consulting_spend<>(typeof(h.consulting_spend))'');
    populated_fs_spend_cnt := COUNT(GROUP,h.fs_spend <> (TYPEOF(h.fs_spend))'');
    populated_fs_spend_pcnt := AVE(GROUP,IF(h.fs_spend = (TYPEOF(h.fs_spend))'',0,100));
    maxlength_fs_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fs_spend)));
    avelength_fs_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fs_spend)),h.fs_spend<>(typeof(h.fs_spend))'');
    populated_fp_spend_cnt := COUNT(GROUP,h.fp_spend <> (TYPEOF(h.fp_spend))'');
    populated_fp_spend_pcnt := AVE(GROUP,IF(h.fp_spend = (TYPEOF(h.fp_spend))'',0,100));
    maxlength_fp_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fp_spend)));
    avelength_fp_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fp_spend)),h.fp_spend<>(typeof(h.fp_spend))'');
    populated_insurance_spend_cnt := COUNT(GROUP,h.insurance_spend <> (TYPEOF(h.insurance_spend))'');
    populated_insurance_spend_pcnt := AVE(GROUP,IF(h.insurance_spend = (TYPEOF(h.insurance_spend))'',0,100));
    maxlength_insurance_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.insurance_spend)));
    avelength_insurance_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.insurance_spend)),h.insurance_spend<>(typeof(h.insurance_spend))'');
    populated_ls_spend_cnt := COUNT(GROUP,h.ls_spend <> (TYPEOF(h.ls_spend))'');
    populated_ls_spend_pcnt := AVE(GROUP,IF(h.ls_spend = (TYPEOF(h.ls_spend))'',0,100));
    maxlength_ls_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ls_spend)));
    avelength_ls_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ls_spend)),h.ls_spend<>(typeof(h.ls_spend))'');
    populated_oil_gas_spend_cnt := COUNT(GROUP,h.oil_gas_spend <> (TYPEOF(h.oil_gas_spend))'');
    populated_oil_gas_spend_pcnt := AVE(GROUP,IF(h.oil_gas_spend = (TYPEOF(h.oil_gas_spend))'',0,100));
    maxlength_oil_gas_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.oil_gas_spend)));
    avelength_oil_gas_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.oil_gas_spend)),h.oil_gas_spend<>(typeof(h.oil_gas_spend))'');
    populated_utilities_spend_cnt := COUNT(GROUP,h.utilities_spend <> (TYPEOF(h.utilities_spend))'');
    populated_utilities_spend_pcnt := AVE(GROUP,IF(h.utilities_spend = (TYPEOF(h.utilities_spend))'',0,100));
    maxlength_utilities_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.utilities_spend)));
    avelength_utilities_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.utilities_spend)),h.utilities_spend<>(typeof(h.utilities_spend))'');
    populated_other_spend_cnt := COUNT(GROUP,h.other_spend <> (TYPEOF(h.other_spend))'');
    populated_other_spend_pcnt := AVE(GROUP,IF(h.other_spend = (TYPEOF(h.other_spend))'',0,100));
    maxlength_other_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_spend)));
    avelength_other_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_spend)),h.other_spend<>(typeof(h.other_spend))'');
    populated_advt_spend_cnt := COUNT(GROUP,h.advt_spend <> (TYPEOF(h.advt_spend))'');
    populated_advt_spend_pcnt := AVE(GROUP,IF(h.advt_spend = (TYPEOF(h.advt_spend))'',0,100));
    maxlength_advt_spend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.advt_spend)));
    avelength_advt_spend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.advt_spend)),h.advt_spend<>(typeof(h.advt_spend))'');
    populated_air_growth_cnt := COUNT(GROUP,h.air_growth <> (TYPEOF(h.air_growth))'');
    populated_air_growth_pcnt := AVE(GROUP,IF(h.air_growth = (TYPEOF(h.air_growth))'',0,100));
    maxlength_air_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.air_growth)));
    avelength_air_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.air_growth)),h.air_growth<>(typeof(h.air_growth))'');
    populated_fuel_growth_cnt := COUNT(GROUP,h.fuel_growth <> (TYPEOF(h.fuel_growth))'');
    populated_fuel_growth_pcnt := AVE(GROUP,IF(h.fuel_growth = (TYPEOF(h.fuel_growth))'',0,100));
    maxlength_fuel_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fuel_growth)));
    avelength_fuel_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fuel_growth)),h.fuel_growth<>(typeof(h.fuel_growth))'');
    populated_leasing_growth_cnt := COUNT(GROUP,h.leasing_growth <> (TYPEOF(h.leasing_growth))'');
    populated_leasing_growth_pcnt := AVE(GROUP,IF(h.leasing_growth = (TYPEOF(h.leasing_growth))'',0,100));
    maxlength_leasing_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.leasing_growth)));
    avelength_leasing_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.leasing_growth)),h.leasing_growth<>(typeof(h.leasing_growth))'');
    populated_ltl_growth_cnt := COUNT(GROUP,h.ltl_growth <> (TYPEOF(h.ltl_growth))'');
    populated_ltl_growth_pcnt := AVE(GROUP,IF(h.ltl_growth = (TYPEOF(h.ltl_growth))'',0,100));
    maxlength_ltl_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ltl_growth)));
    avelength_ltl_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ltl_growth)),h.ltl_growth<>(typeof(h.ltl_growth))'');
    populated_rail_growth_cnt := COUNT(GROUP,h.rail_growth <> (TYPEOF(h.rail_growth))'');
    populated_rail_growth_pcnt := AVE(GROUP,IF(h.rail_growth = (TYPEOF(h.rail_growth))'',0,100));
    maxlength_rail_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rail_growth)));
    avelength_rail_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rail_growth)),h.rail_growth<>(typeof(h.rail_growth))'');
    populated_tl_growth_cnt := COUNT(GROUP,h.tl_growth <> (TYPEOF(h.tl_growth))'');
    populated_tl_growth_pcnt := AVE(GROUP,IF(h.tl_growth = (TYPEOF(h.tl_growth))'',0,100));
    maxlength_tl_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tl_growth)));
    avelength_tl_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tl_growth)),h.tl_growth<>(typeof(h.tl_growth))'');
    populated_transvc_growth_cnt := COUNT(GROUP,h.transvc_growth <> (TYPEOF(h.transvc_growth))'');
    populated_transvc_growth_pcnt := AVE(GROUP,IF(h.transvc_growth = (TYPEOF(h.transvc_growth))'',0,100));
    maxlength_transvc_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transvc_growth)));
    avelength_transvc_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transvc_growth)),h.transvc_growth<>(typeof(h.transvc_growth))'');
    populated_transup_growth_cnt := COUNT(GROUP,h.transup_growth <> (TYPEOF(h.transup_growth))'');
    populated_transup_growth_pcnt := AVE(GROUP,IF(h.transup_growth = (TYPEOF(h.transup_growth))'',0,100));
    maxlength_transup_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transup_growth)));
    avelength_transup_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transup_growth)),h.transup_growth<>(typeof(h.transup_growth))'');
    populated_bst_growth_cnt := COUNT(GROUP,h.bst_growth <> (TYPEOF(h.bst_growth))'');
    populated_bst_growth_pcnt := AVE(GROUP,IF(h.bst_growth = (TYPEOF(h.bst_growth))'',0,100));
    maxlength_bst_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bst_growth)));
    avelength_bst_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bst_growth)),h.bst_growth<>(typeof(h.bst_growth))'');
    populated_dg_growth_cnt := COUNT(GROUP,h.dg_growth <> (TYPEOF(h.dg_growth))'');
    populated_dg_growth_pcnt := AVE(GROUP,IF(h.dg_growth = (TYPEOF(h.dg_growth))'',0,100));
    maxlength_dg_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dg_growth)));
    avelength_dg_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dg_growth)),h.dg_growth<>(typeof(h.dg_growth))'');
    populated_electrical_growth_cnt := COUNT(GROUP,h.electrical_growth <> (TYPEOF(h.electrical_growth))'');
    populated_electrical_growth_pcnt := AVE(GROUP,IF(h.electrical_growth = (TYPEOF(h.electrical_growth))'',0,100));
    maxlength_electrical_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.electrical_growth)));
    avelength_electrical_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.electrical_growth)),h.electrical_growth<>(typeof(h.electrical_growth))'');
    populated_hvac_growth_cnt := COUNT(GROUP,h.hvac_growth <> (TYPEOF(h.hvac_growth))'');
    populated_hvac_growth_pcnt := AVE(GROUP,IF(h.hvac_growth = (TYPEOF(h.hvac_growth))'',0,100));
    maxlength_hvac_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hvac_growth)));
    avelength_hvac_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hvac_growth)),h.hvac_growth<>(typeof(h.hvac_growth))'');
    populated_other_b_growth_cnt := COUNT(GROUP,h.other_b_growth <> (TYPEOF(h.other_b_growth))'');
    populated_other_b_growth_pcnt := AVE(GROUP,IF(h.other_b_growth = (TYPEOF(h.other_b_growth))'',0,100));
    maxlength_other_b_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_b_growth)));
    avelength_other_b_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_b_growth)),h.other_b_growth<>(typeof(h.other_b_growth))'');
    populated_plumbing_growth_cnt := COUNT(GROUP,h.plumbing_growth <> (TYPEOF(h.plumbing_growth))'');
    populated_plumbing_growth_pcnt := AVE(GROUP,IF(h.plumbing_growth = (TYPEOF(h.plumbing_growth))'',0,100));
    maxlength_plumbing_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.plumbing_growth)));
    avelength_plumbing_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.plumbing_growth)),h.plumbing_growth<>(typeof(h.plumbing_growth))'');
    populated_rs_growth_cnt := COUNT(GROUP,h.rs_growth <> (TYPEOF(h.rs_growth))'');
    populated_rs_growth_pcnt := AVE(GROUP,IF(h.rs_growth = (TYPEOF(h.rs_growth))'',0,100));
    maxlength_rs_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rs_growth)));
    avelength_rs_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rs_growth)),h.rs_growth<>(typeof(h.rs_growth))'');
    populated_wp_growth_cnt := COUNT(GROUP,h.wp_growth <> (TYPEOF(h.wp_growth))'');
    populated_wp_growth_pcnt := AVE(GROUP,IF(h.wp_growth = (TYPEOF(h.wp_growth))'',0,100));
    maxlength_wp_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.wp_growth)));
    avelength_wp_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.wp_growth)),h.wp_growth<>(typeof(h.wp_growth))'');
    populated_chemical_growth_cnt := COUNT(GROUP,h.chemical_growth <> (TYPEOF(h.chemical_growth))'');
    populated_chemical_growth_pcnt := AVE(GROUP,IF(h.chemical_growth = (TYPEOF(h.chemical_growth))'',0,100));
    maxlength_chemical_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.chemical_growth)));
    avelength_chemical_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.chemical_growth)),h.chemical_growth<>(typeof(h.chemical_growth))'');
    populated_electronic_growth_cnt := COUNT(GROUP,h.electronic_growth <> (TYPEOF(h.electronic_growth))'');
    populated_electronic_growth_pcnt := AVE(GROUP,IF(h.electronic_growth = (TYPEOF(h.electronic_growth))'',0,100));
    maxlength_electronic_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.electronic_growth)));
    avelength_electronic_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.electronic_growth)),h.electronic_growth<>(typeof(h.electronic_growth))'');
    populated_metal_growth_cnt := COUNT(GROUP,h.metal_growth <> (TYPEOF(h.metal_growth))'');
    populated_metal_growth_pcnt := AVE(GROUP,IF(h.metal_growth = (TYPEOF(h.metal_growth))'',0,100));
    maxlength_metal_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.metal_growth)));
    avelength_metal_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.metal_growth)),h.metal_growth<>(typeof(h.metal_growth))'');
    populated_other_m_growth_cnt := COUNT(GROUP,h.other_m_growth <> (TYPEOF(h.other_m_growth))'');
    populated_other_m_growth_pcnt := AVE(GROUP,IF(h.other_m_growth = (TYPEOF(h.other_m_growth))'',0,100));
    maxlength_other_m_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_m_growth)));
    avelength_other_m_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_m_growth)),h.other_m_growth<>(typeof(h.other_m_growth))'');
    populated_packaging_growth_cnt := COUNT(GROUP,h.packaging_growth <> (TYPEOF(h.packaging_growth))'');
    populated_packaging_growth_pcnt := AVE(GROUP,IF(h.packaging_growth = (TYPEOF(h.packaging_growth))'',0,100));
    maxlength_packaging_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.packaging_growth)));
    avelength_packaging_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.packaging_growth)),h.packaging_growth<>(typeof(h.packaging_growth))'');
    populated_pvf_growth_cnt := COUNT(GROUP,h.pvf_growth <> (TYPEOF(h.pvf_growth))'');
    populated_pvf_growth_pcnt := AVE(GROUP,IF(h.pvf_growth = (TYPEOF(h.pvf_growth))'',0,100));
    maxlength_pvf_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pvf_growth)));
    avelength_pvf_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pvf_growth)),h.pvf_growth<>(typeof(h.pvf_growth))'');
    populated_plastic_growth_cnt := COUNT(GROUP,h.plastic_growth <> (TYPEOF(h.plastic_growth))'');
    populated_plastic_growth_pcnt := AVE(GROUP,IF(h.plastic_growth = (TYPEOF(h.plastic_growth))'',0,100));
    maxlength_plastic_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.plastic_growth)));
    avelength_plastic_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.plastic_growth)),h.plastic_growth<>(typeof(h.plastic_growth))'');
    populated_textile_growth_cnt := COUNT(GROUP,h.textile_growth <> (TYPEOF(h.textile_growth))'');
    populated_textile_growth_pcnt := AVE(GROUP,IF(h.textile_growth = (TYPEOF(h.textile_growth))'',0,100));
    maxlength_textile_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.textile_growth)));
    avelength_textile_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.textile_growth)),h.textile_growth<>(typeof(h.textile_growth))'');
    populated_bs_growth_cnt := COUNT(GROUP,h.bs_growth <> (TYPEOF(h.bs_growth))'');
    populated_bs_growth_pcnt := AVE(GROUP,IF(h.bs_growth = (TYPEOF(h.bs_growth))'',0,100));
    maxlength_bs_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bs_growth)));
    avelength_bs_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bs_growth)),h.bs_growth<>(typeof(h.bs_growth))'');
    populated_ce_growth_cnt := COUNT(GROUP,h.ce_growth <> (TYPEOF(h.ce_growth))'');
    populated_ce_growth_pcnt := AVE(GROUP,IF(h.ce_growth = (TYPEOF(h.ce_growth))'',0,100));
    maxlength_ce_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ce_growth)));
    avelength_ce_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ce_growth)),h.ce_growth<>(typeof(h.ce_growth))'');
    populated_hardware_growth_cnt := COUNT(GROUP,h.hardware_growth <> (TYPEOF(h.hardware_growth))'');
    populated_hardware_growth_pcnt := AVE(GROUP,IF(h.hardware_growth = (TYPEOF(h.hardware_growth))'',0,100));
    maxlength_hardware_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hardware_growth)));
    avelength_hardware_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hardware_growth)),h.hardware_growth<>(typeof(h.hardware_growth))'');
    populated_ie_growth_cnt := COUNT(GROUP,h.ie_growth <> (TYPEOF(h.ie_growth))'');
    populated_ie_growth_pcnt := AVE(GROUP,IF(h.ie_growth = (TYPEOF(h.ie_growth))'',0,100));
    maxlength_ie_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ie_growth)));
    avelength_ie_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ie_growth)),h.ie_growth<>(typeof(h.ie_growth))'');
    populated_is_growth_cnt := COUNT(GROUP,h.is_growth <> (TYPEOF(h.is_growth))'');
    populated_is_growth_pcnt := AVE(GROUP,IF(h.is_growth = (TYPEOF(h.is_growth))'',0,100));
    maxlength_is_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.is_growth)));
    avelength_is_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.is_growth)),h.is_growth<>(typeof(h.is_growth))'');
    populated_it_growth_cnt := COUNT(GROUP,h.it_growth <> (TYPEOF(h.it_growth))'');
    populated_it_growth_pcnt := AVE(GROUP,IF(h.it_growth = (TYPEOF(h.it_growth))'',0,100));
    maxlength_it_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.it_growth)));
    avelength_it_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.it_growth)),h.it_growth<>(typeof(h.it_growth))'');
    populated_mls_growth_cnt := COUNT(GROUP,h.mls_growth <> (TYPEOF(h.mls_growth))'');
    populated_mls_growth_pcnt := AVE(GROUP,IF(h.mls_growth = (TYPEOF(h.mls_growth))'',0,100));
    maxlength_mls_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mls_growth)));
    avelength_mls_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mls_growth)),h.mls_growth<>(typeof(h.mls_growth))'');
    populated_os_growth_cnt := COUNT(GROUP,h.os_growth <> (TYPEOF(h.os_growth))'');
    populated_os_growth_pcnt := AVE(GROUP,IF(h.os_growth = (TYPEOF(h.os_growth))'',0,100));
    maxlength_os_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.os_growth)));
    avelength_os_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.os_growth)),h.os_growth<>(typeof(h.os_growth))'');
    populated_pp_growth_cnt := COUNT(GROUP,h.pp_growth <> (TYPEOF(h.pp_growth))'');
    populated_pp_growth_pcnt := AVE(GROUP,IF(h.pp_growth = (TYPEOF(h.pp_growth))'',0,100));
    maxlength_pp_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pp_growth)));
    avelength_pp_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pp_growth)),h.pp_growth<>(typeof(h.pp_growth))'');
    populated_sis_growth_cnt := COUNT(GROUP,h.sis_growth <> (TYPEOF(h.sis_growth))'');
    populated_sis_growth_pcnt := AVE(GROUP,IF(h.sis_growth = (TYPEOF(h.sis_growth))'',0,100));
    maxlength_sis_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sis_growth)));
    avelength_sis_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sis_growth)),h.sis_growth<>(typeof(h.sis_growth))'');
    populated_apparel_growth_cnt := COUNT(GROUP,h.apparel_growth <> (TYPEOF(h.apparel_growth))'');
    populated_apparel_growth_pcnt := AVE(GROUP,IF(h.apparel_growth = (TYPEOF(h.apparel_growth))'',0,100));
    maxlength_apparel_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.apparel_growth)));
    avelength_apparel_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.apparel_growth)),h.apparel_growth<>(typeof(h.apparel_growth))'');
    populated_beverages_growth_cnt := COUNT(GROUP,h.beverages_growth <> (TYPEOF(h.beverages_growth))'');
    populated_beverages_growth_pcnt := AVE(GROUP,IF(h.beverages_growth = (TYPEOF(h.beverages_growth))'',0,100));
    maxlength_beverages_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.beverages_growth)));
    avelength_beverages_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.beverages_growth)),h.beverages_growth<>(typeof(h.beverages_growth))'');
    populated_constr_growth_cnt := COUNT(GROUP,h.constr_growth <> (TYPEOF(h.constr_growth))'');
    populated_constr_growth_pcnt := AVE(GROUP,IF(h.constr_growth = (TYPEOF(h.constr_growth))'',0,100));
    maxlength_constr_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.constr_growth)));
    avelength_constr_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.constr_growth)),h.constr_growth<>(typeof(h.constr_growth))'');
    populated_consulting_growth_cnt := COUNT(GROUP,h.consulting_growth <> (TYPEOF(h.consulting_growth))'');
    populated_consulting_growth_pcnt := AVE(GROUP,IF(h.consulting_growth = (TYPEOF(h.consulting_growth))'',0,100));
    maxlength_consulting_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.consulting_growth)));
    avelength_consulting_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.consulting_growth)),h.consulting_growth<>(typeof(h.consulting_growth))'');
    populated_fs_growth_cnt := COUNT(GROUP,h.fs_growth <> (TYPEOF(h.fs_growth))'');
    populated_fs_growth_pcnt := AVE(GROUP,IF(h.fs_growth = (TYPEOF(h.fs_growth))'',0,100));
    maxlength_fs_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fs_growth)));
    avelength_fs_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fs_growth)),h.fs_growth<>(typeof(h.fs_growth))'');
    populated_fp_growth_cnt := COUNT(GROUP,h.fp_growth <> (TYPEOF(h.fp_growth))'');
    populated_fp_growth_pcnt := AVE(GROUP,IF(h.fp_growth = (TYPEOF(h.fp_growth))'',0,100));
    maxlength_fp_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fp_growth)));
    avelength_fp_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fp_growth)),h.fp_growth<>(typeof(h.fp_growth))'');
    populated_insurance_growth_cnt := COUNT(GROUP,h.insurance_growth <> (TYPEOF(h.insurance_growth))'');
    populated_insurance_growth_pcnt := AVE(GROUP,IF(h.insurance_growth = (TYPEOF(h.insurance_growth))'',0,100));
    maxlength_insurance_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.insurance_growth)));
    avelength_insurance_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.insurance_growth)),h.insurance_growth<>(typeof(h.insurance_growth))'');
    populated_ls_growth_cnt := COUNT(GROUP,h.ls_growth <> (TYPEOF(h.ls_growth))'');
    populated_ls_growth_pcnt := AVE(GROUP,IF(h.ls_growth = (TYPEOF(h.ls_growth))'',0,100));
    maxlength_ls_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ls_growth)));
    avelength_ls_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ls_growth)),h.ls_growth<>(typeof(h.ls_growth))'');
    populated_oil_gas_growth_cnt := COUNT(GROUP,h.oil_gas_growth <> (TYPEOF(h.oil_gas_growth))'');
    populated_oil_gas_growth_pcnt := AVE(GROUP,IF(h.oil_gas_growth = (TYPEOF(h.oil_gas_growth))'',0,100));
    maxlength_oil_gas_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.oil_gas_growth)));
    avelength_oil_gas_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.oil_gas_growth)),h.oil_gas_growth<>(typeof(h.oil_gas_growth))'');
    populated_utilities_growth_cnt := COUNT(GROUP,h.utilities_growth <> (TYPEOF(h.utilities_growth))'');
    populated_utilities_growth_pcnt := AVE(GROUP,IF(h.utilities_growth = (TYPEOF(h.utilities_growth))'',0,100));
    maxlength_utilities_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.utilities_growth)));
    avelength_utilities_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.utilities_growth)),h.utilities_growth<>(typeof(h.utilities_growth))'');
    populated_other_growth_cnt := COUNT(GROUP,h.other_growth <> (TYPEOF(h.other_growth))'');
    populated_other_growth_pcnt := AVE(GROUP,IF(h.other_growth = (TYPEOF(h.other_growth))'',0,100));
    maxlength_other_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_growth)));
    avelength_other_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.other_growth)),h.other_growth<>(typeof(h.other_growth))'');
    populated_advt_growth_cnt := COUNT(GROUP,h.advt_growth <> (TYPEOF(h.advt_growth))'');
    populated_advt_growth_pcnt := AVE(GROUP,IF(h.advt_growth = (TYPEOF(h.advt_growth))'',0,100));
    maxlength_advt_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.advt_growth)));
    avelength_advt_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.advt_growth)),h.advt_growth<>(typeof(h.advt_growth))'');
    populated_top5_growth_cnt := COUNT(GROUP,h.top5_growth <> (TYPEOF(h.top5_growth))'');
    populated_top5_growth_pcnt := AVE(GROUP,IF(h.top5_growth = (TYPEOF(h.top5_growth))'',0,100));
    maxlength_top5_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_growth)));
    avelength_top5_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_growth)),h.top5_growth<>(typeof(h.top5_growth))'');
    populated_shipping_y1_cnt := COUNT(GROUP,h.shipping_y1 <> (TYPEOF(h.shipping_y1))'');
    populated_shipping_y1_pcnt := AVE(GROUP,IF(h.shipping_y1 = (TYPEOF(h.shipping_y1))'',0,100));
    maxlength_shipping_y1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.shipping_y1)));
    avelength_shipping_y1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.shipping_y1)),h.shipping_y1<>(typeof(h.shipping_y1))'');
    populated_shipping_growth_cnt := COUNT(GROUP,h.shipping_growth <> (TYPEOF(h.shipping_growth))'');
    populated_shipping_growth_pcnt := AVE(GROUP,IF(h.shipping_growth = (TYPEOF(h.shipping_growth))'',0,100));
    maxlength_shipping_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.shipping_growth)));
    avelength_shipping_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.shipping_growth)),h.shipping_growth<>(typeof(h.shipping_growth))'');
    populated_materials_y1_cnt := COUNT(GROUP,h.materials_y1 <> (TYPEOF(h.materials_y1))'');
    populated_materials_y1_pcnt := AVE(GROUP,IF(h.materials_y1 = (TYPEOF(h.materials_y1))'',0,100));
    maxlength_materials_y1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.materials_y1)));
    avelength_materials_y1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.materials_y1)),h.materials_y1<>(typeof(h.materials_y1))'');
    populated_materials_growth_cnt := COUNT(GROUP,h.materials_growth <> (TYPEOF(h.materials_growth))'');
    populated_materials_growth_pcnt := AVE(GROUP,IF(h.materials_growth = (TYPEOF(h.materials_growth))'',0,100));
    maxlength_materials_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.materials_growth)));
    avelength_materials_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.materials_growth)),h.materials_growth<>(typeof(h.materials_growth))'');
    populated_operations_y1_cnt := COUNT(GROUP,h.operations_y1 <> (TYPEOF(h.operations_y1))'');
    populated_operations_y1_pcnt := AVE(GROUP,IF(h.operations_y1 = (TYPEOF(h.operations_y1))'',0,100));
    maxlength_operations_y1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.operations_y1)));
    avelength_operations_y1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.operations_y1)),h.operations_y1<>(typeof(h.operations_y1))'');
    populated_operations_growth_cnt := COUNT(GROUP,h.operations_growth <> (TYPEOF(h.operations_growth))'');
    populated_operations_growth_pcnt := AVE(GROUP,IF(h.operations_growth = (TYPEOF(h.operations_growth))'',0,100));
    maxlength_operations_growth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.operations_growth)));
    avelength_operations_growth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.operations_growth)),h.operations_growth<>(typeof(h.operations_growth))'');
    populated_total_paid_average_0t12_cnt := COUNT(GROUP,h.total_paid_average_0t12 <> (TYPEOF(h.total_paid_average_0t12))'');
    populated_total_paid_average_0t12_pcnt := AVE(GROUP,IF(h.total_paid_average_0t12 = (TYPEOF(h.total_paid_average_0t12))'',0,100));
    maxlength_total_paid_average_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_paid_average_0t12)));
    avelength_total_paid_average_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_paid_average_0t12)),h.total_paid_average_0t12<>(typeof(h.total_paid_average_0t12))'');
    populated_total_paid_monthspastworst_24_cnt := COUNT(GROUP,h.total_paid_monthspastworst_24 <> (TYPEOF(h.total_paid_monthspastworst_24))'');
    populated_total_paid_monthspastworst_24_pcnt := AVE(GROUP,IF(h.total_paid_monthspastworst_24 = (TYPEOF(h.total_paid_monthspastworst_24))'',0,100));
    maxlength_total_paid_monthspastworst_24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_paid_monthspastworst_24)));
    avelength_total_paid_monthspastworst_24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_paid_monthspastworst_24)),h.total_paid_monthspastworst_24<>(typeof(h.total_paid_monthspastworst_24))'');
    populated_total_paid_slope_0t12_cnt := COUNT(GROUP,h.total_paid_slope_0t12 <> (TYPEOF(h.total_paid_slope_0t12))'');
    populated_total_paid_slope_0t12_pcnt := AVE(GROUP,IF(h.total_paid_slope_0t12 = (TYPEOF(h.total_paid_slope_0t12))'',0,100));
    maxlength_total_paid_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_paid_slope_0t12)));
    avelength_total_paid_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_paid_slope_0t12)),h.total_paid_slope_0t12<>(typeof(h.total_paid_slope_0t12))'');
    populated_total_paid_slope_0t6_cnt := COUNT(GROUP,h.total_paid_slope_0t6 <> (TYPEOF(h.total_paid_slope_0t6))'');
    populated_total_paid_slope_0t6_pcnt := AVE(GROUP,IF(h.total_paid_slope_0t6 = (TYPEOF(h.total_paid_slope_0t6))'',0,100));
    maxlength_total_paid_slope_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_paid_slope_0t6)));
    avelength_total_paid_slope_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_paid_slope_0t6)),h.total_paid_slope_0t6<>(typeof(h.total_paid_slope_0t6))'');
    populated_total_paid_slope_6t12_cnt := COUNT(GROUP,h.total_paid_slope_6t12 <> (TYPEOF(h.total_paid_slope_6t12))'');
    populated_total_paid_slope_6t12_pcnt := AVE(GROUP,IF(h.total_paid_slope_6t12 = (TYPEOF(h.total_paid_slope_6t12))'',0,100));
    maxlength_total_paid_slope_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_paid_slope_6t12)));
    avelength_total_paid_slope_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_paid_slope_6t12)),h.total_paid_slope_6t12<>(typeof(h.total_paid_slope_6t12))'');
    populated_total_paid_slope_6t18_cnt := COUNT(GROUP,h.total_paid_slope_6t18 <> (TYPEOF(h.total_paid_slope_6t18))'');
    populated_total_paid_slope_6t18_pcnt := AVE(GROUP,IF(h.total_paid_slope_6t18 = (TYPEOF(h.total_paid_slope_6t18))'',0,100));
    maxlength_total_paid_slope_6t18 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_paid_slope_6t18)));
    avelength_total_paid_slope_6t18 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_paid_slope_6t18)),h.total_paid_slope_6t18<>(typeof(h.total_paid_slope_6t18))'');
    populated_total_paid_volatility_0t12_cnt := COUNT(GROUP,h.total_paid_volatility_0t12 <> (TYPEOF(h.total_paid_volatility_0t12))'');
    populated_total_paid_volatility_0t12_pcnt := AVE(GROUP,IF(h.total_paid_volatility_0t12 = (TYPEOF(h.total_paid_volatility_0t12))'',0,100));
    maxlength_total_paid_volatility_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_paid_volatility_0t12)));
    avelength_total_paid_volatility_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_paid_volatility_0t12)),h.total_paid_volatility_0t12<>(typeof(h.total_paid_volatility_0t12))'');
    populated_total_paid_volatility_0t6_cnt := COUNT(GROUP,h.total_paid_volatility_0t6 <> (TYPEOF(h.total_paid_volatility_0t6))'');
    populated_total_paid_volatility_0t6_pcnt := AVE(GROUP,IF(h.total_paid_volatility_0t6 = (TYPEOF(h.total_paid_volatility_0t6))'',0,100));
    maxlength_total_paid_volatility_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_paid_volatility_0t6)));
    avelength_total_paid_volatility_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_paid_volatility_0t6)),h.total_paid_volatility_0t6<>(typeof(h.total_paid_volatility_0t6))'');
    populated_total_paid_volatility_12t18_cnt := COUNT(GROUP,h.total_paid_volatility_12t18 <> (TYPEOF(h.total_paid_volatility_12t18))'');
    populated_total_paid_volatility_12t18_pcnt := AVE(GROUP,IF(h.total_paid_volatility_12t18 = (TYPEOF(h.total_paid_volatility_12t18))'',0,100));
    maxlength_total_paid_volatility_12t18 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_paid_volatility_12t18)));
    avelength_total_paid_volatility_12t18 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_paid_volatility_12t18)),h.total_paid_volatility_12t18<>(typeof(h.total_paid_volatility_12t18))'');
    populated_total_paid_volatility_6t12_cnt := COUNT(GROUP,h.total_paid_volatility_6t12 <> (TYPEOF(h.total_paid_volatility_6t12))'');
    populated_total_paid_volatility_6t12_pcnt := AVE(GROUP,IF(h.total_paid_volatility_6t12 = (TYPEOF(h.total_paid_volatility_6t12))'',0,100));
    maxlength_total_paid_volatility_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_paid_volatility_6t12)));
    avelength_total_paid_volatility_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_paid_volatility_6t12)),h.total_paid_volatility_6t12<>(typeof(h.total_paid_volatility_6t12))'');
    populated_total_spend_monthspastleast_24_cnt := COUNT(GROUP,h.total_spend_monthspastleast_24 <> (TYPEOF(h.total_spend_monthspastleast_24))'');
    populated_total_spend_monthspastleast_24_pcnt := AVE(GROUP,IF(h.total_spend_monthspastleast_24 = (TYPEOF(h.total_spend_monthspastleast_24))'',0,100));
    maxlength_total_spend_monthspastleast_24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_spend_monthspastleast_24)));
    avelength_total_spend_monthspastleast_24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_spend_monthspastleast_24)),h.total_spend_monthspastleast_24<>(typeof(h.total_spend_monthspastleast_24))'');
    populated_total_spend_monthspastmost_24_cnt := COUNT(GROUP,h.total_spend_monthspastmost_24 <> (TYPEOF(h.total_spend_monthspastmost_24))'');
    populated_total_spend_monthspastmost_24_pcnt := AVE(GROUP,IF(h.total_spend_monthspastmost_24 = (TYPEOF(h.total_spend_monthspastmost_24))'',0,100));
    maxlength_total_spend_monthspastmost_24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_spend_monthspastmost_24)));
    avelength_total_spend_monthspastmost_24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_spend_monthspastmost_24)),h.total_spend_monthspastmost_24<>(typeof(h.total_spend_monthspastmost_24))'');
    populated_total_spend_slope_0t12_cnt := COUNT(GROUP,h.total_spend_slope_0t12 <> (TYPEOF(h.total_spend_slope_0t12))'');
    populated_total_spend_slope_0t12_pcnt := AVE(GROUP,IF(h.total_spend_slope_0t12 = (TYPEOF(h.total_spend_slope_0t12))'',0,100));
    maxlength_total_spend_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_spend_slope_0t12)));
    avelength_total_spend_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_spend_slope_0t12)),h.total_spend_slope_0t12<>(typeof(h.total_spend_slope_0t12))'');
    populated_total_spend_slope_0t24_cnt := COUNT(GROUP,h.total_spend_slope_0t24 <> (TYPEOF(h.total_spend_slope_0t24))'');
    populated_total_spend_slope_0t24_pcnt := AVE(GROUP,IF(h.total_spend_slope_0t24 = (TYPEOF(h.total_spend_slope_0t24))'',0,100));
    maxlength_total_spend_slope_0t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_spend_slope_0t24)));
    avelength_total_spend_slope_0t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_spend_slope_0t24)),h.total_spend_slope_0t24<>(typeof(h.total_spend_slope_0t24))'');
    populated_total_spend_slope_0t6_cnt := COUNT(GROUP,h.total_spend_slope_0t6 <> (TYPEOF(h.total_spend_slope_0t6))'');
    populated_total_spend_slope_0t6_pcnt := AVE(GROUP,IF(h.total_spend_slope_0t6 = (TYPEOF(h.total_spend_slope_0t6))'',0,100));
    maxlength_total_spend_slope_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_spend_slope_0t6)));
    avelength_total_spend_slope_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_spend_slope_0t6)),h.total_spend_slope_0t6<>(typeof(h.total_spend_slope_0t6))'');
    populated_total_spend_slope_6t12_cnt := COUNT(GROUP,h.total_spend_slope_6t12 <> (TYPEOF(h.total_spend_slope_6t12))'');
    populated_total_spend_slope_6t12_pcnt := AVE(GROUP,IF(h.total_spend_slope_6t12 = (TYPEOF(h.total_spend_slope_6t12))'',0,100));
    maxlength_total_spend_slope_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_spend_slope_6t12)));
    avelength_total_spend_slope_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_spend_slope_6t12)),h.total_spend_slope_6t12<>(typeof(h.total_spend_slope_6t12))'');
    populated_total_spend_sum_12_cnt := COUNT(GROUP,h.total_spend_sum_12 <> (TYPEOF(h.total_spend_sum_12))'');
    populated_total_spend_sum_12_pcnt := AVE(GROUP,IF(h.total_spend_sum_12 = (TYPEOF(h.total_spend_sum_12))'',0,100));
    maxlength_total_spend_sum_12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_spend_sum_12)));
    avelength_total_spend_sum_12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_spend_sum_12)),h.total_spend_sum_12<>(typeof(h.total_spend_sum_12))'');
    populated_total_spend_volatility_0t12_cnt := COUNT(GROUP,h.total_spend_volatility_0t12 <> (TYPEOF(h.total_spend_volatility_0t12))'');
    populated_total_spend_volatility_0t12_pcnt := AVE(GROUP,IF(h.total_spend_volatility_0t12 = (TYPEOF(h.total_spend_volatility_0t12))'',0,100));
    maxlength_total_spend_volatility_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_spend_volatility_0t12)));
    avelength_total_spend_volatility_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_spend_volatility_0t12)),h.total_spend_volatility_0t12<>(typeof(h.total_spend_volatility_0t12))'');
    populated_total_spend_volatility_0t6_cnt := COUNT(GROUP,h.total_spend_volatility_0t6 <> (TYPEOF(h.total_spend_volatility_0t6))'');
    populated_total_spend_volatility_0t6_pcnt := AVE(GROUP,IF(h.total_spend_volatility_0t6 = (TYPEOF(h.total_spend_volatility_0t6))'',0,100));
    maxlength_total_spend_volatility_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_spend_volatility_0t6)));
    avelength_total_spend_volatility_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_spend_volatility_0t6)),h.total_spend_volatility_0t6<>(typeof(h.total_spend_volatility_0t6))'');
    populated_total_spend_volatility_12t18_cnt := COUNT(GROUP,h.total_spend_volatility_12t18 <> (TYPEOF(h.total_spend_volatility_12t18))'');
    populated_total_spend_volatility_12t18_pcnt := AVE(GROUP,IF(h.total_spend_volatility_12t18 = (TYPEOF(h.total_spend_volatility_12t18))'',0,100));
    maxlength_total_spend_volatility_12t18 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_spend_volatility_12t18)));
    avelength_total_spend_volatility_12t18 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_spend_volatility_12t18)),h.total_spend_volatility_12t18<>(typeof(h.total_spend_volatility_12t18))'');
    populated_total_spend_volatility_6t12_cnt := COUNT(GROUP,h.total_spend_volatility_6t12 <> (TYPEOF(h.total_spend_volatility_6t12))'');
    populated_total_spend_volatility_6t12_pcnt := AVE(GROUP,IF(h.total_spend_volatility_6t12 = (TYPEOF(h.total_spend_volatility_6t12))'',0,100));
    maxlength_total_spend_volatility_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_spend_volatility_6t12)));
    avelength_total_spend_volatility_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_spend_volatility_6t12)),h.total_spend_volatility_6t12<>(typeof(h.total_spend_volatility_6t12))'');
    populated_mfgmat_paid_average_12_cnt := COUNT(GROUP,h.mfgmat_paid_average_12 <> (TYPEOF(h.mfgmat_paid_average_12))'');
    populated_mfgmat_paid_average_12_pcnt := AVE(GROUP,IF(h.mfgmat_paid_average_12 = (TYPEOF(h.mfgmat_paid_average_12))'',0,100));
    maxlength_mfgmat_paid_average_12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_paid_average_12)));
    avelength_mfgmat_paid_average_12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_paid_average_12)),h.mfgmat_paid_average_12<>(typeof(h.mfgmat_paid_average_12))'');
    populated_mfgmat_paid_monthspastworst_24_cnt := COUNT(GROUP,h.mfgmat_paid_monthspastworst_24 <> (TYPEOF(h.mfgmat_paid_monthspastworst_24))'');
    populated_mfgmat_paid_monthspastworst_24_pcnt := AVE(GROUP,IF(h.mfgmat_paid_monthspastworst_24 = (TYPEOF(h.mfgmat_paid_monthspastworst_24))'',0,100));
    maxlength_mfgmat_paid_monthspastworst_24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_paid_monthspastworst_24)));
    avelength_mfgmat_paid_monthspastworst_24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_paid_monthspastworst_24)),h.mfgmat_paid_monthspastworst_24<>(typeof(h.mfgmat_paid_monthspastworst_24))'');
    populated_mfgmat_paid_slope_0t12_cnt := COUNT(GROUP,h.mfgmat_paid_slope_0t12 <> (TYPEOF(h.mfgmat_paid_slope_0t12))'');
    populated_mfgmat_paid_slope_0t12_pcnt := AVE(GROUP,IF(h.mfgmat_paid_slope_0t12 = (TYPEOF(h.mfgmat_paid_slope_0t12))'',0,100));
    maxlength_mfgmat_paid_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_paid_slope_0t12)));
    avelength_mfgmat_paid_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_paid_slope_0t12)),h.mfgmat_paid_slope_0t12<>(typeof(h.mfgmat_paid_slope_0t12))'');
    populated_mfgmat_paid_slope_0t24_cnt := COUNT(GROUP,h.mfgmat_paid_slope_0t24 <> (TYPEOF(h.mfgmat_paid_slope_0t24))'');
    populated_mfgmat_paid_slope_0t24_pcnt := AVE(GROUP,IF(h.mfgmat_paid_slope_0t24 = (TYPEOF(h.mfgmat_paid_slope_0t24))'',0,100));
    maxlength_mfgmat_paid_slope_0t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_paid_slope_0t24)));
    avelength_mfgmat_paid_slope_0t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_paid_slope_0t24)),h.mfgmat_paid_slope_0t24<>(typeof(h.mfgmat_paid_slope_0t24))'');
    populated_mfgmat_paid_slope_0t6_cnt := COUNT(GROUP,h.mfgmat_paid_slope_0t6 <> (TYPEOF(h.mfgmat_paid_slope_0t6))'');
    populated_mfgmat_paid_slope_0t6_pcnt := AVE(GROUP,IF(h.mfgmat_paid_slope_0t6 = (TYPEOF(h.mfgmat_paid_slope_0t6))'',0,100));
    maxlength_mfgmat_paid_slope_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_paid_slope_0t6)));
    avelength_mfgmat_paid_slope_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_paid_slope_0t6)),h.mfgmat_paid_slope_0t6<>(typeof(h.mfgmat_paid_slope_0t6))'');
    populated_mfgmat_paid_volatility_0t12_cnt := COUNT(GROUP,h.mfgmat_paid_volatility_0t12 <> (TYPEOF(h.mfgmat_paid_volatility_0t12))'');
    populated_mfgmat_paid_volatility_0t12_pcnt := AVE(GROUP,IF(h.mfgmat_paid_volatility_0t12 = (TYPEOF(h.mfgmat_paid_volatility_0t12))'',0,100));
    maxlength_mfgmat_paid_volatility_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_paid_volatility_0t12)));
    avelength_mfgmat_paid_volatility_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_paid_volatility_0t12)),h.mfgmat_paid_volatility_0t12<>(typeof(h.mfgmat_paid_volatility_0t12))'');
    populated_mfgmat_paid_volatility_0t6_cnt := COUNT(GROUP,h.mfgmat_paid_volatility_0t6 <> (TYPEOF(h.mfgmat_paid_volatility_0t6))'');
    populated_mfgmat_paid_volatility_0t6_pcnt := AVE(GROUP,IF(h.mfgmat_paid_volatility_0t6 = (TYPEOF(h.mfgmat_paid_volatility_0t6))'',0,100));
    maxlength_mfgmat_paid_volatility_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_paid_volatility_0t6)));
    avelength_mfgmat_paid_volatility_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_paid_volatility_0t6)),h.mfgmat_paid_volatility_0t6<>(typeof(h.mfgmat_paid_volatility_0t6))'');
    populated_mfgmat_spend_monthspastleast_24_cnt := COUNT(GROUP,h.mfgmat_spend_monthspastleast_24 <> (TYPEOF(h.mfgmat_spend_monthspastleast_24))'');
    populated_mfgmat_spend_monthspastleast_24_pcnt := AVE(GROUP,IF(h.mfgmat_spend_monthspastleast_24 = (TYPEOF(h.mfgmat_spend_monthspastleast_24))'',0,100));
    maxlength_mfgmat_spend_monthspastleast_24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_spend_monthspastleast_24)));
    avelength_mfgmat_spend_monthspastleast_24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_spend_monthspastleast_24)),h.mfgmat_spend_monthspastleast_24<>(typeof(h.mfgmat_spend_monthspastleast_24))'');
    populated_mfgmat_spend_monthspastmost_24_cnt := COUNT(GROUP,h.mfgmat_spend_monthspastmost_24 <> (TYPEOF(h.mfgmat_spend_monthspastmost_24))'');
    populated_mfgmat_spend_monthspastmost_24_pcnt := AVE(GROUP,IF(h.mfgmat_spend_monthspastmost_24 = (TYPEOF(h.mfgmat_spend_monthspastmost_24))'',0,100));
    maxlength_mfgmat_spend_monthspastmost_24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_spend_monthspastmost_24)));
    avelength_mfgmat_spend_monthspastmost_24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_spend_monthspastmost_24)),h.mfgmat_spend_monthspastmost_24<>(typeof(h.mfgmat_spend_monthspastmost_24))'');
    populated_mfgmat_spend_slope_0t12_cnt := COUNT(GROUP,h.mfgmat_spend_slope_0t12 <> (TYPEOF(h.mfgmat_spend_slope_0t12))'');
    populated_mfgmat_spend_slope_0t12_pcnt := AVE(GROUP,IF(h.mfgmat_spend_slope_0t12 = (TYPEOF(h.mfgmat_spend_slope_0t12))'',0,100));
    maxlength_mfgmat_spend_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_spend_slope_0t12)));
    avelength_mfgmat_spend_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_spend_slope_0t12)),h.mfgmat_spend_slope_0t12<>(typeof(h.mfgmat_spend_slope_0t12))'');
    populated_mfgmat_spend_slope_0t24_cnt := COUNT(GROUP,h.mfgmat_spend_slope_0t24 <> (TYPEOF(h.mfgmat_spend_slope_0t24))'');
    populated_mfgmat_spend_slope_0t24_pcnt := AVE(GROUP,IF(h.mfgmat_spend_slope_0t24 = (TYPEOF(h.mfgmat_spend_slope_0t24))'',0,100));
    maxlength_mfgmat_spend_slope_0t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_spend_slope_0t24)));
    avelength_mfgmat_spend_slope_0t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_spend_slope_0t24)),h.mfgmat_spend_slope_0t24<>(typeof(h.mfgmat_spend_slope_0t24))'');
    populated_mfgmat_spend_slope_0t6_cnt := COUNT(GROUP,h.mfgmat_spend_slope_0t6 <> (TYPEOF(h.mfgmat_spend_slope_0t6))'');
    populated_mfgmat_spend_slope_0t6_pcnt := AVE(GROUP,IF(h.mfgmat_spend_slope_0t6 = (TYPEOF(h.mfgmat_spend_slope_0t6))'',0,100));
    maxlength_mfgmat_spend_slope_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_spend_slope_0t6)));
    avelength_mfgmat_spend_slope_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_spend_slope_0t6)),h.mfgmat_spend_slope_0t6<>(typeof(h.mfgmat_spend_slope_0t6))'');
    populated_mfgmat_spend_sum_12_cnt := COUNT(GROUP,h.mfgmat_spend_sum_12 <> (TYPEOF(h.mfgmat_spend_sum_12))'');
    populated_mfgmat_spend_sum_12_pcnt := AVE(GROUP,IF(h.mfgmat_spend_sum_12 = (TYPEOF(h.mfgmat_spend_sum_12))'',0,100));
    maxlength_mfgmat_spend_sum_12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_spend_sum_12)));
    avelength_mfgmat_spend_sum_12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_spend_sum_12)),h.mfgmat_spend_sum_12<>(typeof(h.mfgmat_spend_sum_12))'');
    populated_mfgmat_spend_volatility_0t6_cnt := COUNT(GROUP,h.mfgmat_spend_volatility_0t6 <> (TYPEOF(h.mfgmat_spend_volatility_0t6))'');
    populated_mfgmat_spend_volatility_0t6_pcnt := AVE(GROUP,IF(h.mfgmat_spend_volatility_0t6 = (TYPEOF(h.mfgmat_spend_volatility_0t6))'',0,100));
    maxlength_mfgmat_spend_volatility_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_spend_volatility_0t6)));
    avelength_mfgmat_spend_volatility_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_spend_volatility_0t6)),h.mfgmat_spend_volatility_0t6<>(typeof(h.mfgmat_spend_volatility_0t6))'');
    populated_mfgmat_spend_volatility_6t12_cnt := COUNT(GROUP,h.mfgmat_spend_volatility_6t12 <> (TYPEOF(h.mfgmat_spend_volatility_6t12))'');
    populated_mfgmat_spend_volatility_6t12_pcnt := AVE(GROUP,IF(h.mfgmat_spend_volatility_6t12 = (TYPEOF(h.mfgmat_spend_volatility_6t12))'',0,100));
    maxlength_mfgmat_spend_volatility_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_spend_volatility_6t12)));
    avelength_mfgmat_spend_volatility_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_spend_volatility_6t12)),h.mfgmat_spend_volatility_6t12<>(typeof(h.mfgmat_spend_volatility_6t12))'');
    populated_ops_paid_average_12_cnt := COUNT(GROUP,h.ops_paid_average_12 <> (TYPEOF(h.ops_paid_average_12))'');
    populated_ops_paid_average_12_pcnt := AVE(GROUP,IF(h.ops_paid_average_12 = (TYPEOF(h.ops_paid_average_12))'',0,100));
    maxlength_ops_paid_average_12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_paid_average_12)));
    avelength_ops_paid_average_12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_paid_average_12)),h.ops_paid_average_12<>(typeof(h.ops_paid_average_12))'');
    populated_ops_paid_monthspastworst_24_cnt := COUNT(GROUP,h.ops_paid_monthspastworst_24 <> (TYPEOF(h.ops_paid_monthspastworst_24))'');
    populated_ops_paid_monthspastworst_24_pcnt := AVE(GROUP,IF(h.ops_paid_monthspastworst_24 = (TYPEOF(h.ops_paid_monthspastworst_24))'',0,100));
    maxlength_ops_paid_monthspastworst_24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_paid_monthspastworst_24)));
    avelength_ops_paid_monthspastworst_24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_paid_monthspastworst_24)),h.ops_paid_monthspastworst_24<>(typeof(h.ops_paid_monthspastworst_24))'');
    populated_ops_paid_slope_0t12_cnt := COUNT(GROUP,h.ops_paid_slope_0t12 <> (TYPEOF(h.ops_paid_slope_0t12))'');
    populated_ops_paid_slope_0t12_pcnt := AVE(GROUP,IF(h.ops_paid_slope_0t12 = (TYPEOF(h.ops_paid_slope_0t12))'',0,100));
    maxlength_ops_paid_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_paid_slope_0t12)));
    avelength_ops_paid_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_paid_slope_0t12)),h.ops_paid_slope_0t12<>(typeof(h.ops_paid_slope_0t12))'');
    populated_ops_paid_slope_0t24_cnt := COUNT(GROUP,h.ops_paid_slope_0t24 <> (TYPEOF(h.ops_paid_slope_0t24))'');
    populated_ops_paid_slope_0t24_pcnt := AVE(GROUP,IF(h.ops_paid_slope_0t24 = (TYPEOF(h.ops_paid_slope_0t24))'',0,100));
    maxlength_ops_paid_slope_0t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_paid_slope_0t24)));
    avelength_ops_paid_slope_0t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_paid_slope_0t24)),h.ops_paid_slope_0t24<>(typeof(h.ops_paid_slope_0t24))'');
    populated_ops_paid_slope_0t6_cnt := COUNT(GROUP,h.ops_paid_slope_0t6 <> (TYPEOF(h.ops_paid_slope_0t6))'');
    populated_ops_paid_slope_0t6_pcnt := AVE(GROUP,IF(h.ops_paid_slope_0t6 = (TYPEOF(h.ops_paid_slope_0t6))'',0,100));
    maxlength_ops_paid_slope_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_paid_slope_0t6)));
    avelength_ops_paid_slope_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_paid_slope_0t6)),h.ops_paid_slope_0t6<>(typeof(h.ops_paid_slope_0t6))'');
    populated_ops_paid_volatility_0t12_cnt := COUNT(GROUP,h.ops_paid_volatility_0t12 <> (TYPEOF(h.ops_paid_volatility_0t12))'');
    populated_ops_paid_volatility_0t12_pcnt := AVE(GROUP,IF(h.ops_paid_volatility_0t12 = (TYPEOF(h.ops_paid_volatility_0t12))'',0,100));
    maxlength_ops_paid_volatility_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_paid_volatility_0t12)));
    avelength_ops_paid_volatility_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_paid_volatility_0t12)),h.ops_paid_volatility_0t12<>(typeof(h.ops_paid_volatility_0t12))'');
    populated_ops_paid_volatility_0t6_cnt := COUNT(GROUP,h.ops_paid_volatility_0t6 <> (TYPEOF(h.ops_paid_volatility_0t6))'');
    populated_ops_paid_volatility_0t6_pcnt := AVE(GROUP,IF(h.ops_paid_volatility_0t6 = (TYPEOF(h.ops_paid_volatility_0t6))'',0,100));
    maxlength_ops_paid_volatility_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_paid_volatility_0t6)));
    avelength_ops_paid_volatility_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_paid_volatility_0t6)),h.ops_paid_volatility_0t6<>(typeof(h.ops_paid_volatility_0t6))'');
    populated_ops_spend_monthspastleast_24_cnt := COUNT(GROUP,h.ops_spend_monthspastleast_24 <> (TYPEOF(h.ops_spend_monthspastleast_24))'');
    populated_ops_spend_monthspastleast_24_pcnt := AVE(GROUP,IF(h.ops_spend_monthspastleast_24 = (TYPEOF(h.ops_spend_monthspastleast_24))'',0,100));
    maxlength_ops_spend_monthspastleast_24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_spend_monthspastleast_24)));
    avelength_ops_spend_monthspastleast_24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_spend_monthspastleast_24)),h.ops_spend_monthspastleast_24<>(typeof(h.ops_spend_monthspastleast_24))'');
    populated_ops_spend_monthspastmost_24_cnt := COUNT(GROUP,h.ops_spend_monthspastmost_24 <> (TYPEOF(h.ops_spend_monthspastmost_24))'');
    populated_ops_spend_monthspastmost_24_pcnt := AVE(GROUP,IF(h.ops_spend_monthspastmost_24 = (TYPEOF(h.ops_spend_monthspastmost_24))'',0,100));
    maxlength_ops_spend_monthspastmost_24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_spend_monthspastmost_24)));
    avelength_ops_spend_monthspastmost_24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_spend_monthspastmost_24)),h.ops_spend_monthspastmost_24<>(typeof(h.ops_spend_monthspastmost_24))'');
    populated_ops_spend_slope_0t12_cnt := COUNT(GROUP,h.ops_spend_slope_0t12 <> (TYPEOF(h.ops_spend_slope_0t12))'');
    populated_ops_spend_slope_0t12_pcnt := AVE(GROUP,IF(h.ops_spend_slope_0t12 = (TYPEOF(h.ops_spend_slope_0t12))'',0,100));
    maxlength_ops_spend_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_spend_slope_0t12)));
    avelength_ops_spend_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_spend_slope_0t12)),h.ops_spend_slope_0t12<>(typeof(h.ops_spend_slope_0t12))'');
    populated_ops_spend_slope_0t24_cnt := COUNT(GROUP,h.ops_spend_slope_0t24 <> (TYPEOF(h.ops_spend_slope_0t24))'');
    populated_ops_spend_slope_0t24_pcnt := AVE(GROUP,IF(h.ops_spend_slope_0t24 = (TYPEOF(h.ops_spend_slope_0t24))'',0,100));
    maxlength_ops_spend_slope_0t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_spend_slope_0t24)));
    avelength_ops_spend_slope_0t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_spend_slope_0t24)),h.ops_spend_slope_0t24<>(typeof(h.ops_spend_slope_0t24))'');
    populated_ops_spend_slope_0t6_cnt := COUNT(GROUP,h.ops_spend_slope_0t6 <> (TYPEOF(h.ops_spend_slope_0t6))'');
    populated_ops_spend_slope_0t6_pcnt := AVE(GROUP,IF(h.ops_spend_slope_0t6 = (TYPEOF(h.ops_spend_slope_0t6))'',0,100));
    maxlength_ops_spend_slope_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_spend_slope_0t6)));
    avelength_ops_spend_slope_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_spend_slope_0t6)),h.ops_spend_slope_0t6<>(typeof(h.ops_spend_slope_0t6))'');
    populated_ops_spend_sum_12_cnt := COUNT(GROUP,h.ops_spend_sum_12 <> (TYPEOF(h.ops_spend_sum_12))'');
    populated_ops_spend_sum_12_pcnt := AVE(GROUP,IF(h.ops_spend_sum_12 = (TYPEOF(h.ops_spend_sum_12))'',0,100));
    maxlength_ops_spend_sum_12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_spend_sum_12)));
    avelength_ops_spend_sum_12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_spend_sum_12)),h.ops_spend_sum_12<>(typeof(h.ops_spend_sum_12))'');
    populated_ops_spend_volatility_0t6_cnt := COUNT(GROUP,h.ops_spend_volatility_0t6 <> (TYPEOF(h.ops_spend_volatility_0t6))'');
    populated_ops_spend_volatility_0t6_pcnt := AVE(GROUP,IF(h.ops_spend_volatility_0t6 = (TYPEOF(h.ops_spend_volatility_0t6))'',0,100));
    maxlength_ops_spend_volatility_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_spend_volatility_0t6)));
    avelength_ops_spend_volatility_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_spend_volatility_0t6)),h.ops_spend_volatility_0t6<>(typeof(h.ops_spend_volatility_0t6))'');
    populated_ops_spend_volatility_6t12_cnt := COUNT(GROUP,h.ops_spend_volatility_6t12 <> (TYPEOF(h.ops_spend_volatility_6t12))'');
    populated_ops_spend_volatility_6t12_pcnt := AVE(GROUP,IF(h.ops_spend_volatility_6t12 = (TYPEOF(h.ops_spend_volatility_6t12))'',0,100));
    maxlength_ops_spend_volatility_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_spend_volatility_6t12)));
    avelength_ops_spend_volatility_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_spend_volatility_6t12)),h.ops_spend_volatility_6t12<>(typeof(h.ops_spend_volatility_6t12))'');
    populated_fleet_paid_average_12_cnt := COUNT(GROUP,h.fleet_paid_average_12 <> (TYPEOF(h.fleet_paid_average_12))'');
    populated_fleet_paid_average_12_pcnt := AVE(GROUP,IF(h.fleet_paid_average_12 = (TYPEOF(h.fleet_paid_average_12))'',0,100));
    maxlength_fleet_paid_average_12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_paid_average_12)));
    avelength_fleet_paid_average_12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_paid_average_12)),h.fleet_paid_average_12<>(typeof(h.fleet_paid_average_12))'');
    populated_fleet_paid_monthspastworst_24_cnt := COUNT(GROUP,h.fleet_paid_monthspastworst_24 <> (TYPEOF(h.fleet_paid_monthspastworst_24))'');
    populated_fleet_paid_monthspastworst_24_pcnt := AVE(GROUP,IF(h.fleet_paid_monthspastworst_24 = (TYPEOF(h.fleet_paid_monthspastworst_24))'',0,100));
    maxlength_fleet_paid_monthspastworst_24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_paid_monthspastworst_24)));
    avelength_fleet_paid_monthspastworst_24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_paid_monthspastworst_24)),h.fleet_paid_monthspastworst_24<>(typeof(h.fleet_paid_monthspastworst_24))'');
    populated_fleet_paid_slope_0t12_cnt := COUNT(GROUP,h.fleet_paid_slope_0t12 <> (TYPEOF(h.fleet_paid_slope_0t12))'');
    populated_fleet_paid_slope_0t12_pcnt := AVE(GROUP,IF(h.fleet_paid_slope_0t12 = (TYPEOF(h.fleet_paid_slope_0t12))'',0,100));
    maxlength_fleet_paid_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_paid_slope_0t12)));
    avelength_fleet_paid_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_paid_slope_0t12)),h.fleet_paid_slope_0t12<>(typeof(h.fleet_paid_slope_0t12))'');
    populated_fleet_paid_slope_0t24_cnt := COUNT(GROUP,h.fleet_paid_slope_0t24 <> (TYPEOF(h.fleet_paid_slope_0t24))'');
    populated_fleet_paid_slope_0t24_pcnt := AVE(GROUP,IF(h.fleet_paid_slope_0t24 = (TYPEOF(h.fleet_paid_slope_0t24))'',0,100));
    maxlength_fleet_paid_slope_0t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_paid_slope_0t24)));
    avelength_fleet_paid_slope_0t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_paid_slope_0t24)),h.fleet_paid_slope_0t24<>(typeof(h.fleet_paid_slope_0t24))'');
    populated_fleet_paid_slope_0t6_cnt := COUNT(GROUP,h.fleet_paid_slope_0t6 <> (TYPEOF(h.fleet_paid_slope_0t6))'');
    populated_fleet_paid_slope_0t6_pcnt := AVE(GROUP,IF(h.fleet_paid_slope_0t6 = (TYPEOF(h.fleet_paid_slope_0t6))'',0,100));
    maxlength_fleet_paid_slope_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_paid_slope_0t6)));
    avelength_fleet_paid_slope_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_paid_slope_0t6)),h.fleet_paid_slope_0t6<>(typeof(h.fleet_paid_slope_0t6))'');
    populated_fleet_paid_volatility_0t12_cnt := COUNT(GROUP,h.fleet_paid_volatility_0t12 <> (TYPEOF(h.fleet_paid_volatility_0t12))'');
    populated_fleet_paid_volatility_0t12_pcnt := AVE(GROUP,IF(h.fleet_paid_volatility_0t12 = (TYPEOF(h.fleet_paid_volatility_0t12))'',0,100));
    maxlength_fleet_paid_volatility_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_paid_volatility_0t12)));
    avelength_fleet_paid_volatility_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_paid_volatility_0t12)),h.fleet_paid_volatility_0t12<>(typeof(h.fleet_paid_volatility_0t12))'');
    populated_fleet_paid_volatility_0t6_cnt := COUNT(GROUP,h.fleet_paid_volatility_0t6 <> (TYPEOF(h.fleet_paid_volatility_0t6))'');
    populated_fleet_paid_volatility_0t6_pcnt := AVE(GROUP,IF(h.fleet_paid_volatility_0t6 = (TYPEOF(h.fleet_paid_volatility_0t6))'',0,100));
    maxlength_fleet_paid_volatility_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_paid_volatility_0t6)));
    avelength_fleet_paid_volatility_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_paid_volatility_0t6)),h.fleet_paid_volatility_0t6<>(typeof(h.fleet_paid_volatility_0t6))'');
    populated_fleet_spend_monthspastleast_24_cnt := COUNT(GROUP,h.fleet_spend_monthspastleast_24 <> (TYPEOF(h.fleet_spend_monthspastleast_24))'');
    populated_fleet_spend_monthspastleast_24_pcnt := AVE(GROUP,IF(h.fleet_spend_monthspastleast_24 = (TYPEOF(h.fleet_spend_monthspastleast_24))'',0,100));
    maxlength_fleet_spend_monthspastleast_24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_spend_monthspastleast_24)));
    avelength_fleet_spend_monthspastleast_24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_spend_monthspastleast_24)),h.fleet_spend_monthspastleast_24<>(typeof(h.fleet_spend_monthspastleast_24))'');
    populated_fleet_spend_monthspastmost_24_cnt := COUNT(GROUP,h.fleet_spend_monthspastmost_24 <> (TYPEOF(h.fleet_spend_monthspastmost_24))'');
    populated_fleet_spend_monthspastmost_24_pcnt := AVE(GROUP,IF(h.fleet_spend_monthspastmost_24 = (TYPEOF(h.fleet_spend_monthspastmost_24))'',0,100));
    maxlength_fleet_spend_monthspastmost_24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_spend_monthspastmost_24)));
    avelength_fleet_spend_monthspastmost_24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_spend_monthspastmost_24)),h.fleet_spend_monthspastmost_24<>(typeof(h.fleet_spend_monthspastmost_24))'');
    populated_fleet_spend_slope_0t12_cnt := COUNT(GROUP,h.fleet_spend_slope_0t12 <> (TYPEOF(h.fleet_spend_slope_0t12))'');
    populated_fleet_spend_slope_0t12_pcnt := AVE(GROUP,IF(h.fleet_spend_slope_0t12 = (TYPEOF(h.fleet_spend_slope_0t12))'',0,100));
    maxlength_fleet_spend_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_spend_slope_0t12)));
    avelength_fleet_spend_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_spend_slope_0t12)),h.fleet_spend_slope_0t12<>(typeof(h.fleet_spend_slope_0t12))'');
    populated_fleet_spend_slope_0t24_cnt := COUNT(GROUP,h.fleet_spend_slope_0t24 <> (TYPEOF(h.fleet_spend_slope_0t24))'');
    populated_fleet_spend_slope_0t24_pcnt := AVE(GROUP,IF(h.fleet_spend_slope_0t24 = (TYPEOF(h.fleet_spend_slope_0t24))'',0,100));
    maxlength_fleet_spend_slope_0t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_spend_slope_0t24)));
    avelength_fleet_spend_slope_0t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_spend_slope_0t24)),h.fleet_spend_slope_0t24<>(typeof(h.fleet_spend_slope_0t24))'');
    populated_fleet_spend_slope_0t6_cnt := COUNT(GROUP,h.fleet_spend_slope_0t6 <> (TYPEOF(h.fleet_spend_slope_0t6))'');
    populated_fleet_spend_slope_0t6_pcnt := AVE(GROUP,IF(h.fleet_spend_slope_0t6 = (TYPEOF(h.fleet_spend_slope_0t6))'',0,100));
    maxlength_fleet_spend_slope_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_spend_slope_0t6)));
    avelength_fleet_spend_slope_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_spend_slope_0t6)),h.fleet_spend_slope_0t6<>(typeof(h.fleet_spend_slope_0t6))'');
    populated_fleet_spend_sum_12_cnt := COUNT(GROUP,h.fleet_spend_sum_12 <> (TYPEOF(h.fleet_spend_sum_12))'');
    populated_fleet_spend_sum_12_pcnt := AVE(GROUP,IF(h.fleet_spend_sum_12 = (TYPEOF(h.fleet_spend_sum_12))'',0,100));
    maxlength_fleet_spend_sum_12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_spend_sum_12)));
    avelength_fleet_spend_sum_12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_spend_sum_12)),h.fleet_spend_sum_12<>(typeof(h.fleet_spend_sum_12))'');
    populated_fleet_spend_volatility_0t6_cnt := COUNT(GROUP,h.fleet_spend_volatility_0t6 <> (TYPEOF(h.fleet_spend_volatility_0t6))'');
    populated_fleet_spend_volatility_0t6_pcnt := AVE(GROUP,IF(h.fleet_spend_volatility_0t6 = (TYPEOF(h.fleet_spend_volatility_0t6))'',0,100));
    maxlength_fleet_spend_volatility_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_spend_volatility_0t6)));
    avelength_fleet_spend_volatility_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_spend_volatility_0t6)),h.fleet_spend_volatility_0t6<>(typeof(h.fleet_spend_volatility_0t6))'');
    populated_fleet_spend_volatility_6t12_cnt := COUNT(GROUP,h.fleet_spend_volatility_6t12 <> (TYPEOF(h.fleet_spend_volatility_6t12))'');
    populated_fleet_spend_volatility_6t12_pcnt := AVE(GROUP,IF(h.fleet_spend_volatility_6t12 = (TYPEOF(h.fleet_spend_volatility_6t12))'',0,100));
    maxlength_fleet_spend_volatility_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_spend_volatility_6t12)));
    avelength_fleet_spend_volatility_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_spend_volatility_6t12)),h.fleet_spend_volatility_6t12<>(typeof(h.fleet_spend_volatility_6t12))'');
    populated_carrier_paid_average_12_cnt := COUNT(GROUP,h.carrier_paid_average_12 <> (TYPEOF(h.carrier_paid_average_12))'');
    populated_carrier_paid_average_12_pcnt := AVE(GROUP,IF(h.carrier_paid_average_12 = (TYPEOF(h.carrier_paid_average_12))'',0,100));
    maxlength_carrier_paid_average_12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_paid_average_12)));
    avelength_carrier_paid_average_12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_paid_average_12)),h.carrier_paid_average_12<>(typeof(h.carrier_paid_average_12))'');
    populated_carrier_paid_monthspastworst_24_cnt := COUNT(GROUP,h.carrier_paid_monthspastworst_24 <> (TYPEOF(h.carrier_paid_monthspastworst_24))'');
    populated_carrier_paid_monthspastworst_24_pcnt := AVE(GROUP,IF(h.carrier_paid_monthspastworst_24 = (TYPEOF(h.carrier_paid_monthspastworst_24))'',0,100));
    maxlength_carrier_paid_monthspastworst_24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_paid_monthspastworst_24)));
    avelength_carrier_paid_monthspastworst_24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_paid_monthspastworst_24)),h.carrier_paid_monthspastworst_24<>(typeof(h.carrier_paid_monthspastworst_24))'');
    populated_carrier_paid_slope_0t12_cnt := COUNT(GROUP,h.carrier_paid_slope_0t12 <> (TYPEOF(h.carrier_paid_slope_0t12))'');
    populated_carrier_paid_slope_0t12_pcnt := AVE(GROUP,IF(h.carrier_paid_slope_0t12 = (TYPEOF(h.carrier_paid_slope_0t12))'',0,100));
    maxlength_carrier_paid_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_paid_slope_0t12)));
    avelength_carrier_paid_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_paid_slope_0t12)),h.carrier_paid_slope_0t12<>(typeof(h.carrier_paid_slope_0t12))'');
    populated_carrier_paid_slope_0t24_cnt := COUNT(GROUP,h.carrier_paid_slope_0t24 <> (TYPEOF(h.carrier_paid_slope_0t24))'');
    populated_carrier_paid_slope_0t24_pcnt := AVE(GROUP,IF(h.carrier_paid_slope_0t24 = (TYPEOF(h.carrier_paid_slope_0t24))'',0,100));
    maxlength_carrier_paid_slope_0t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_paid_slope_0t24)));
    avelength_carrier_paid_slope_0t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_paid_slope_0t24)),h.carrier_paid_slope_0t24<>(typeof(h.carrier_paid_slope_0t24))'');
    populated_carrier_paid_slope_0t6_cnt := COUNT(GROUP,h.carrier_paid_slope_0t6 <> (TYPEOF(h.carrier_paid_slope_0t6))'');
    populated_carrier_paid_slope_0t6_pcnt := AVE(GROUP,IF(h.carrier_paid_slope_0t6 = (TYPEOF(h.carrier_paid_slope_0t6))'',0,100));
    maxlength_carrier_paid_slope_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_paid_slope_0t6)));
    avelength_carrier_paid_slope_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_paid_slope_0t6)),h.carrier_paid_slope_0t6<>(typeof(h.carrier_paid_slope_0t6))'');
    populated_carrier_paid_volatility_0t12_cnt := COUNT(GROUP,h.carrier_paid_volatility_0t12 <> (TYPEOF(h.carrier_paid_volatility_0t12))'');
    populated_carrier_paid_volatility_0t12_pcnt := AVE(GROUP,IF(h.carrier_paid_volatility_0t12 = (TYPEOF(h.carrier_paid_volatility_0t12))'',0,100));
    maxlength_carrier_paid_volatility_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_paid_volatility_0t12)));
    avelength_carrier_paid_volatility_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_paid_volatility_0t12)),h.carrier_paid_volatility_0t12<>(typeof(h.carrier_paid_volatility_0t12))'');
    populated_carrier_paid_volatility_0t6_cnt := COUNT(GROUP,h.carrier_paid_volatility_0t6 <> (TYPEOF(h.carrier_paid_volatility_0t6))'');
    populated_carrier_paid_volatility_0t6_pcnt := AVE(GROUP,IF(h.carrier_paid_volatility_0t6 = (TYPEOF(h.carrier_paid_volatility_0t6))'',0,100));
    maxlength_carrier_paid_volatility_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_paid_volatility_0t6)));
    avelength_carrier_paid_volatility_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_paid_volatility_0t6)),h.carrier_paid_volatility_0t6<>(typeof(h.carrier_paid_volatility_0t6))'');
    populated_carrier_spend_monthspastleast_24_cnt := COUNT(GROUP,h.carrier_spend_monthspastleast_24 <> (TYPEOF(h.carrier_spend_monthspastleast_24))'');
    populated_carrier_spend_monthspastleast_24_pcnt := AVE(GROUP,IF(h.carrier_spend_monthspastleast_24 = (TYPEOF(h.carrier_spend_monthspastleast_24))'',0,100));
    maxlength_carrier_spend_monthspastleast_24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_spend_monthspastleast_24)));
    avelength_carrier_spend_monthspastleast_24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_spend_monthspastleast_24)),h.carrier_spend_monthspastleast_24<>(typeof(h.carrier_spend_monthspastleast_24))'');
    populated_carrier_spend_monthspastmost_24_cnt := COUNT(GROUP,h.carrier_spend_monthspastmost_24 <> (TYPEOF(h.carrier_spend_monthspastmost_24))'');
    populated_carrier_spend_monthspastmost_24_pcnt := AVE(GROUP,IF(h.carrier_spend_monthspastmost_24 = (TYPEOF(h.carrier_spend_monthspastmost_24))'',0,100));
    maxlength_carrier_spend_monthspastmost_24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_spend_monthspastmost_24)));
    avelength_carrier_spend_monthspastmost_24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_spend_monthspastmost_24)),h.carrier_spend_monthspastmost_24<>(typeof(h.carrier_spend_monthspastmost_24))'');
    populated_carrier_spend_slope_0t12_cnt := COUNT(GROUP,h.carrier_spend_slope_0t12 <> (TYPEOF(h.carrier_spend_slope_0t12))'');
    populated_carrier_spend_slope_0t12_pcnt := AVE(GROUP,IF(h.carrier_spend_slope_0t12 = (TYPEOF(h.carrier_spend_slope_0t12))'',0,100));
    maxlength_carrier_spend_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_spend_slope_0t12)));
    avelength_carrier_spend_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_spend_slope_0t12)),h.carrier_spend_slope_0t12<>(typeof(h.carrier_spend_slope_0t12))'');
    populated_carrier_spend_slope_0t24_cnt := COUNT(GROUP,h.carrier_spend_slope_0t24 <> (TYPEOF(h.carrier_spend_slope_0t24))'');
    populated_carrier_spend_slope_0t24_pcnt := AVE(GROUP,IF(h.carrier_spend_slope_0t24 = (TYPEOF(h.carrier_spend_slope_0t24))'',0,100));
    maxlength_carrier_spend_slope_0t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_spend_slope_0t24)));
    avelength_carrier_spend_slope_0t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_spend_slope_0t24)),h.carrier_spend_slope_0t24<>(typeof(h.carrier_spend_slope_0t24))'');
    populated_carrier_spend_slope_0t6_cnt := COUNT(GROUP,h.carrier_spend_slope_0t6 <> (TYPEOF(h.carrier_spend_slope_0t6))'');
    populated_carrier_spend_slope_0t6_pcnt := AVE(GROUP,IF(h.carrier_spend_slope_0t6 = (TYPEOF(h.carrier_spend_slope_0t6))'',0,100));
    maxlength_carrier_spend_slope_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_spend_slope_0t6)));
    avelength_carrier_spend_slope_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_spend_slope_0t6)),h.carrier_spend_slope_0t6<>(typeof(h.carrier_spend_slope_0t6))'');
    populated_carrier_spend_sum_12_cnt := COUNT(GROUP,h.carrier_spend_sum_12 <> (TYPEOF(h.carrier_spend_sum_12))'');
    populated_carrier_spend_sum_12_pcnt := AVE(GROUP,IF(h.carrier_spend_sum_12 = (TYPEOF(h.carrier_spend_sum_12))'',0,100));
    maxlength_carrier_spend_sum_12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_spend_sum_12)));
    avelength_carrier_spend_sum_12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_spend_sum_12)),h.carrier_spend_sum_12<>(typeof(h.carrier_spend_sum_12))'');
    populated_carrier_spend_volatility_0t6_cnt := COUNT(GROUP,h.carrier_spend_volatility_0t6 <> (TYPEOF(h.carrier_spend_volatility_0t6))'');
    populated_carrier_spend_volatility_0t6_pcnt := AVE(GROUP,IF(h.carrier_spend_volatility_0t6 = (TYPEOF(h.carrier_spend_volatility_0t6))'',0,100));
    maxlength_carrier_spend_volatility_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_spend_volatility_0t6)));
    avelength_carrier_spend_volatility_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_spend_volatility_0t6)),h.carrier_spend_volatility_0t6<>(typeof(h.carrier_spend_volatility_0t6))'');
    populated_carrier_spend_volatility_6t12_cnt := COUNT(GROUP,h.carrier_spend_volatility_6t12 <> (TYPEOF(h.carrier_spend_volatility_6t12))'');
    populated_carrier_spend_volatility_6t12_pcnt := AVE(GROUP,IF(h.carrier_spend_volatility_6t12 = (TYPEOF(h.carrier_spend_volatility_6t12))'',0,100));
    maxlength_carrier_spend_volatility_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_spend_volatility_6t12)));
    avelength_carrier_spend_volatility_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_spend_volatility_6t12)),h.carrier_spend_volatility_6t12<>(typeof(h.carrier_spend_volatility_6t12))'');
    populated_bldgmats_paid_average_12_cnt := COUNT(GROUP,h.bldgmats_paid_average_12 <> (TYPEOF(h.bldgmats_paid_average_12))'');
    populated_bldgmats_paid_average_12_pcnt := AVE(GROUP,IF(h.bldgmats_paid_average_12 = (TYPEOF(h.bldgmats_paid_average_12))'',0,100));
    maxlength_bldgmats_paid_average_12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_paid_average_12)));
    avelength_bldgmats_paid_average_12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_paid_average_12)),h.bldgmats_paid_average_12<>(typeof(h.bldgmats_paid_average_12))'');
    populated_bldgmats_paid_monthspastworst_24_cnt := COUNT(GROUP,h.bldgmats_paid_monthspastworst_24 <> (TYPEOF(h.bldgmats_paid_monthspastworst_24))'');
    populated_bldgmats_paid_monthspastworst_24_pcnt := AVE(GROUP,IF(h.bldgmats_paid_monthspastworst_24 = (TYPEOF(h.bldgmats_paid_monthspastworst_24))'',0,100));
    maxlength_bldgmats_paid_monthspastworst_24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_paid_monthspastworst_24)));
    avelength_bldgmats_paid_monthspastworst_24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_paid_monthspastworst_24)),h.bldgmats_paid_monthspastworst_24<>(typeof(h.bldgmats_paid_monthspastworst_24))'');
    populated_bldgmats_paid_slope_0t12_cnt := COUNT(GROUP,h.bldgmats_paid_slope_0t12 <> (TYPEOF(h.bldgmats_paid_slope_0t12))'');
    populated_bldgmats_paid_slope_0t12_pcnt := AVE(GROUP,IF(h.bldgmats_paid_slope_0t12 = (TYPEOF(h.bldgmats_paid_slope_0t12))'',0,100));
    maxlength_bldgmats_paid_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_paid_slope_0t12)));
    avelength_bldgmats_paid_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_paid_slope_0t12)),h.bldgmats_paid_slope_0t12<>(typeof(h.bldgmats_paid_slope_0t12))'');
    populated_bldgmats_paid_slope_0t24_cnt := COUNT(GROUP,h.bldgmats_paid_slope_0t24 <> (TYPEOF(h.bldgmats_paid_slope_0t24))'');
    populated_bldgmats_paid_slope_0t24_pcnt := AVE(GROUP,IF(h.bldgmats_paid_slope_0t24 = (TYPEOF(h.bldgmats_paid_slope_0t24))'',0,100));
    maxlength_bldgmats_paid_slope_0t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_paid_slope_0t24)));
    avelength_bldgmats_paid_slope_0t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_paid_slope_0t24)),h.bldgmats_paid_slope_0t24<>(typeof(h.bldgmats_paid_slope_0t24))'');
    populated_bldgmats_paid_slope_0t6_cnt := COUNT(GROUP,h.bldgmats_paid_slope_0t6 <> (TYPEOF(h.bldgmats_paid_slope_0t6))'');
    populated_bldgmats_paid_slope_0t6_pcnt := AVE(GROUP,IF(h.bldgmats_paid_slope_0t6 = (TYPEOF(h.bldgmats_paid_slope_0t6))'',0,100));
    maxlength_bldgmats_paid_slope_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_paid_slope_0t6)));
    avelength_bldgmats_paid_slope_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_paid_slope_0t6)),h.bldgmats_paid_slope_0t6<>(typeof(h.bldgmats_paid_slope_0t6))'');
    populated_bldgmats_paid_volatility_0t12_cnt := COUNT(GROUP,h.bldgmats_paid_volatility_0t12 <> (TYPEOF(h.bldgmats_paid_volatility_0t12))'');
    populated_bldgmats_paid_volatility_0t12_pcnt := AVE(GROUP,IF(h.bldgmats_paid_volatility_0t12 = (TYPEOF(h.bldgmats_paid_volatility_0t12))'',0,100));
    maxlength_bldgmats_paid_volatility_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_paid_volatility_0t12)));
    avelength_bldgmats_paid_volatility_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_paid_volatility_0t12)),h.bldgmats_paid_volatility_0t12<>(typeof(h.bldgmats_paid_volatility_0t12))'');
    populated_bldgmats_paid_volatility_0t6_cnt := COUNT(GROUP,h.bldgmats_paid_volatility_0t6 <> (TYPEOF(h.bldgmats_paid_volatility_0t6))'');
    populated_bldgmats_paid_volatility_0t6_pcnt := AVE(GROUP,IF(h.bldgmats_paid_volatility_0t6 = (TYPEOF(h.bldgmats_paid_volatility_0t6))'',0,100));
    maxlength_bldgmats_paid_volatility_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_paid_volatility_0t6)));
    avelength_bldgmats_paid_volatility_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_paid_volatility_0t6)),h.bldgmats_paid_volatility_0t6<>(typeof(h.bldgmats_paid_volatility_0t6))'');
    populated_bldgmats_spend_monthspastleast_24_cnt := COUNT(GROUP,h.bldgmats_spend_monthspastleast_24 <> (TYPEOF(h.bldgmats_spend_monthspastleast_24))'');
    populated_bldgmats_spend_monthspastleast_24_pcnt := AVE(GROUP,IF(h.bldgmats_spend_monthspastleast_24 = (TYPEOF(h.bldgmats_spend_monthspastleast_24))'',0,100));
    maxlength_bldgmats_spend_monthspastleast_24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_spend_monthspastleast_24)));
    avelength_bldgmats_spend_monthspastleast_24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_spend_monthspastleast_24)),h.bldgmats_spend_monthspastleast_24<>(typeof(h.bldgmats_spend_monthspastleast_24))'');
    populated_bldgmats_spend_monthspastmost_24_cnt := COUNT(GROUP,h.bldgmats_spend_monthspastmost_24 <> (TYPEOF(h.bldgmats_spend_monthspastmost_24))'');
    populated_bldgmats_spend_monthspastmost_24_pcnt := AVE(GROUP,IF(h.bldgmats_spend_monthspastmost_24 = (TYPEOF(h.bldgmats_spend_monthspastmost_24))'',0,100));
    maxlength_bldgmats_spend_monthspastmost_24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_spend_monthspastmost_24)));
    avelength_bldgmats_spend_monthspastmost_24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_spend_monthspastmost_24)),h.bldgmats_spend_monthspastmost_24<>(typeof(h.bldgmats_spend_monthspastmost_24))'');
    populated_bldgmats_spend_slope_0t12_cnt := COUNT(GROUP,h.bldgmats_spend_slope_0t12 <> (TYPEOF(h.bldgmats_spend_slope_0t12))'');
    populated_bldgmats_spend_slope_0t12_pcnt := AVE(GROUP,IF(h.bldgmats_spend_slope_0t12 = (TYPEOF(h.bldgmats_spend_slope_0t12))'',0,100));
    maxlength_bldgmats_spend_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_spend_slope_0t12)));
    avelength_bldgmats_spend_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_spend_slope_0t12)),h.bldgmats_spend_slope_0t12<>(typeof(h.bldgmats_spend_slope_0t12))'');
    populated_bldgmats_spend_slope_0t24_cnt := COUNT(GROUP,h.bldgmats_spend_slope_0t24 <> (TYPEOF(h.bldgmats_spend_slope_0t24))'');
    populated_bldgmats_spend_slope_0t24_pcnt := AVE(GROUP,IF(h.bldgmats_spend_slope_0t24 = (TYPEOF(h.bldgmats_spend_slope_0t24))'',0,100));
    maxlength_bldgmats_spend_slope_0t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_spend_slope_0t24)));
    avelength_bldgmats_spend_slope_0t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_spend_slope_0t24)),h.bldgmats_spend_slope_0t24<>(typeof(h.bldgmats_spend_slope_0t24))'');
    populated_bldgmats_spend_slope_0t6_cnt := COUNT(GROUP,h.bldgmats_spend_slope_0t6 <> (TYPEOF(h.bldgmats_spend_slope_0t6))'');
    populated_bldgmats_spend_slope_0t6_pcnt := AVE(GROUP,IF(h.bldgmats_spend_slope_0t6 = (TYPEOF(h.bldgmats_spend_slope_0t6))'',0,100));
    maxlength_bldgmats_spend_slope_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_spend_slope_0t6)));
    avelength_bldgmats_spend_slope_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_spend_slope_0t6)),h.bldgmats_spend_slope_0t6<>(typeof(h.bldgmats_spend_slope_0t6))'');
    populated_bldgmats_spend_sum_12_cnt := COUNT(GROUP,h.bldgmats_spend_sum_12 <> (TYPEOF(h.bldgmats_spend_sum_12))'');
    populated_bldgmats_spend_sum_12_pcnt := AVE(GROUP,IF(h.bldgmats_spend_sum_12 = (TYPEOF(h.bldgmats_spend_sum_12))'',0,100));
    maxlength_bldgmats_spend_sum_12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_spend_sum_12)));
    avelength_bldgmats_spend_sum_12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_spend_sum_12)),h.bldgmats_spend_sum_12<>(typeof(h.bldgmats_spend_sum_12))'');
    populated_bldgmats_spend_volatility_0t6_cnt := COUNT(GROUP,h.bldgmats_spend_volatility_0t6 <> (TYPEOF(h.bldgmats_spend_volatility_0t6))'');
    populated_bldgmats_spend_volatility_0t6_pcnt := AVE(GROUP,IF(h.bldgmats_spend_volatility_0t6 = (TYPEOF(h.bldgmats_spend_volatility_0t6))'',0,100));
    maxlength_bldgmats_spend_volatility_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_spend_volatility_0t6)));
    avelength_bldgmats_spend_volatility_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_spend_volatility_0t6)),h.bldgmats_spend_volatility_0t6<>(typeof(h.bldgmats_spend_volatility_0t6))'');
    populated_bldgmats_spend_volatility_6t12_cnt := COUNT(GROUP,h.bldgmats_spend_volatility_6t12 <> (TYPEOF(h.bldgmats_spend_volatility_6t12))'');
    populated_bldgmats_spend_volatility_6t12_pcnt := AVE(GROUP,IF(h.bldgmats_spend_volatility_6t12 = (TYPEOF(h.bldgmats_spend_volatility_6t12))'',0,100));
    maxlength_bldgmats_spend_volatility_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_spend_volatility_6t12)));
    avelength_bldgmats_spend_volatility_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_spend_volatility_6t12)),h.bldgmats_spend_volatility_6t12<>(typeof(h.bldgmats_spend_volatility_6t12))'');
    populated_top5_paid_average_12_cnt := COUNT(GROUP,h.top5_paid_average_12 <> (TYPEOF(h.top5_paid_average_12))'');
    populated_top5_paid_average_12_pcnt := AVE(GROUP,IF(h.top5_paid_average_12 = (TYPEOF(h.top5_paid_average_12))'',0,100));
    maxlength_top5_paid_average_12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_paid_average_12)));
    avelength_top5_paid_average_12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_paid_average_12)),h.top5_paid_average_12<>(typeof(h.top5_paid_average_12))'');
    populated_top5_paid_monthspastworst_24_cnt := COUNT(GROUP,h.top5_paid_monthspastworst_24 <> (TYPEOF(h.top5_paid_monthspastworst_24))'');
    populated_top5_paid_monthspastworst_24_pcnt := AVE(GROUP,IF(h.top5_paid_monthspastworst_24 = (TYPEOF(h.top5_paid_monthspastworst_24))'',0,100));
    maxlength_top5_paid_monthspastworst_24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_paid_monthspastworst_24)));
    avelength_top5_paid_monthspastworst_24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_paid_monthspastworst_24)),h.top5_paid_monthspastworst_24<>(typeof(h.top5_paid_monthspastworst_24))'');
    populated_top5_paid_slope_0t12_cnt := COUNT(GROUP,h.top5_paid_slope_0t12 <> (TYPEOF(h.top5_paid_slope_0t12))'');
    populated_top5_paid_slope_0t12_pcnt := AVE(GROUP,IF(h.top5_paid_slope_0t12 = (TYPEOF(h.top5_paid_slope_0t12))'',0,100));
    maxlength_top5_paid_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_paid_slope_0t12)));
    avelength_top5_paid_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_paid_slope_0t12)),h.top5_paid_slope_0t12<>(typeof(h.top5_paid_slope_0t12))'');
    populated_top5_paid_slope_0t24_cnt := COUNT(GROUP,h.top5_paid_slope_0t24 <> (TYPEOF(h.top5_paid_slope_0t24))'');
    populated_top5_paid_slope_0t24_pcnt := AVE(GROUP,IF(h.top5_paid_slope_0t24 = (TYPEOF(h.top5_paid_slope_0t24))'',0,100));
    maxlength_top5_paid_slope_0t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_paid_slope_0t24)));
    avelength_top5_paid_slope_0t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_paid_slope_0t24)),h.top5_paid_slope_0t24<>(typeof(h.top5_paid_slope_0t24))'');
    populated_top5_paid_slope_0t6_cnt := COUNT(GROUP,h.top5_paid_slope_0t6 <> (TYPEOF(h.top5_paid_slope_0t6))'');
    populated_top5_paid_slope_0t6_pcnt := AVE(GROUP,IF(h.top5_paid_slope_0t6 = (TYPEOF(h.top5_paid_slope_0t6))'',0,100));
    maxlength_top5_paid_slope_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_paid_slope_0t6)));
    avelength_top5_paid_slope_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_paid_slope_0t6)),h.top5_paid_slope_0t6<>(typeof(h.top5_paid_slope_0t6))'');
    populated_top5_paid_volatility_0t12_cnt := COUNT(GROUP,h.top5_paid_volatility_0t12 <> (TYPEOF(h.top5_paid_volatility_0t12))'');
    populated_top5_paid_volatility_0t12_pcnt := AVE(GROUP,IF(h.top5_paid_volatility_0t12 = (TYPEOF(h.top5_paid_volatility_0t12))'',0,100));
    maxlength_top5_paid_volatility_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_paid_volatility_0t12)));
    avelength_top5_paid_volatility_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_paid_volatility_0t12)),h.top5_paid_volatility_0t12<>(typeof(h.top5_paid_volatility_0t12))'');
    populated_top5_paid_volatility_0t6_cnt := COUNT(GROUP,h.top5_paid_volatility_0t6 <> (TYPEOF(h.top5_paid_volatility_0t6))'');
    populated_top5_paid_volatility_0t6_pcnt := AVE(GROUP,IF(h.top5_paid_volatility_0t6 = (TYPEOF(h.top5_paid_volatility_0t6))'',0,100));
    maxlength_top5_paid_volatility_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_paid_volatility_0t6)));
    avelength_top5_paid_volatility_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_paid_volatility_0t6)),h.top5_paid_volatility_0t6<>(typeof(h.top5_paid_volatility_0t6))'');
    populated_top5_spend_monthspastleast_24_cnt := COUNT(GROUP,h.top5_spend_monthspastleast_24 <> (TYPEOF(h.top5_spend_monthspastleast_24))'');
    populated_top5_spend_monthspastleast_24_pcnt := AVE(GROUP,IF(h.top5_spend_monthspastleast_24 = (TYPEOF(h.top5_spend_monthspastleast_24))'',0,100));
    maxlength_top5_spend_monthspastleast_24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_spend_monthspastleast_24)));
    avelength_top5_spend_monthspastleast_24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_spend_monthspastleast_24)),h.top5_spend_monthspastleast_24<>(typeof(h.top5_spend_monthspastleast_24))'');
    populated_top5_spend_monthspastmost_24_cnt := COUNT(GROUP,h.top5_spend_monthspastmost_24 <> (TYPEOF(h.top5_spend_monthspastmost_24))'');
    populated_top5_spend_monthspastmost_24_pcnt := AVE(GROUP,IF(h.top5_spend_monthspastmost_24 = (TYPEOF(h.top5_spend_monthspastmost_24))'',0,100));
    maxlength_top5_spend_monthspastmost_24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_spend_monthspastmost_24)));
    avelength_top5_spend_monthspastmost_24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_spend_monthspastmost_24)),h.top5_spend_monthspastmost_24<>(typeof(h.top5_spend_monthspastmost_24))'');
    populated_top5_spend_slope_0t12_cnt := COUNT(GROUP,h.top5_spend_slope_0t12 <> (TYPEOF(h.top5_spend_slope_0t12))'');
    populated_top5_spend_slope_0t12_pcnt := AVE(GROUP,IF(h.top5_spend_slope_0t12 = (TYPEOF(h.top5_spend_slope_0t12))'',0,100));
    maxlength_top5_spend_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_spend_slope_0t12)));
    avelength_top5_spend_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_spend_slope_0t12)),h.top5_spend_slope_0t12<>(typeof(h.top5_spend_slope_0t12))'');
    populated_top5_spend_slope_0t24_cnt := COUNT(GROUP,h.top5_spend_slope_0t24 <> (TYPEOF(h.top5_spend_slope_0t24))'');
    populated_top5_spend_slope_0t24_pcnt := AVE(GROUP,IF(h.top5_spend_slope_0t24 = (TYPEOF(h.top5_spend_slope_0t24))'',0,100));
    maxlength_top5_spend_slope_0t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_spend_slope_0t24)));
    avelength_top5_spend_slope_0t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_spend_slope_0t24)),h.top5_spend_slope_0t24<>(typeof(h.top5_spend_slope_0t24))'');
    populated_top5_spend_slope_0t6_cnt := COUNT(GROUP,h.top5_spend_slope_0t6 <> (TYPEOF(h.top5_spend_slope_0t6))'');
    populated_top5_spend_slope_0t6_pcnt := AVE(GROUP,IF(h.top5_spend_slope_0t6 = (TYPEOF(h.top5_spend_slope_0t6))'',0,100));
    maxlength_top5_spend_slope_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_spend_slope_0t6)));
    avelength_top5_spend_slope_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_spend_slope_0t6)),h.top5_spend_slope_0t6<>(typeof(h.top5_spend_slope_0t6))'');
    populated_top5_spend_sum_12_cnt := COUNT(GROUP,h.top5_spend_sum_12 <> (TYPEOF(h.top5_spend_sum_12))'');
    populated_top5_spend_sum_12_pcnt := AVE(GROUP,IF(h.top5_spend_sum_12 = (TYPEOF(h.top5_spend_sum_12))'',0,100));
    maxlength_top5_spend_sum_12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_spend_sum_12)));
    avelength_top5_spend_sum_12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_spend_sum_12)),h.top5_spend_sum_12<>(typeof(h.top5_spend_sum_12))'');
    populated_top5_spend_volatility_0t6_cnt := COUNT(GROUP,h.top5_spend_volatility_0t6 <> (TYPEOF(h.top5_spend_volatility_0t6))'');
    populated_top5_spend_volatility_0t6_pcnt := AVE(GROUP,IF(h.top5_spend_volatility_0t6 = (TYPEOF(h.top5_spend_volatility_0t6))'',0,100));
    maxlength_top5_spend_volatility_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_spend_volatility_0t6)));
    avelength_top5_spend_volatility_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_spend_volatility_0t6)),h.top5_spend_volatility_0t6<>(typeof(h.top5_spend_volatility_0t6))'');
    populated_top5_spend_volatility_6t12_cnt := COUNT(GROUP,h.top5_spend_volatility_6t12 <> (TYPEOF(h.top5_spend_volatility_6t12))'');
    populated_top5_spend_volatility_6t12_pcnt := AVE(GROUP,IF(h.top5_spend_volatility_6t12 = (TYPEOF(h.top5_spend_volatility_6t12))'',0,100));
    maxlength_top5_spend_volatility_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_spend_volatility_6t12)));
    avelength_top5_spend_volatility_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_spend_volatility_6t12)),h.top5_spend_volatility_6t12<>(typeof(h.top5_spend_volatility_6t12))'');
    populated_total_numrel_avg12_cnt := COUNT(GROUP,h.total_numrel_avg12 <> (TYPEOF(h.total_numrel_avg12))'');
    populated_total_numrel_avg12_pcnt := AVE(GROUP,IF(h.total_numrel_avg12 = (TYPEOF(h.total_numrel_avg12))'',0,100));
    maxlength_total_numrel_avg12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_numrel_avg12)));
    avelength_total_numrel_avg12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_numrel_avg12)),h.total_numrel_avg12<>(typeof(h.total_numrel_avg12))'');
    populated_total_numrel_monthpspastmost_24_cnt := COUNT(GROUP,h.total_numrel_monthpspastmost_24 <> (TYPEOF(h.total_numrel_monthpspastmost_24))'');
    populated_total_numrel_monthpspastmost_24_pcnt := AVE(GROUP,IF(h.total_numrel_monthpspastmost_24 = (TYPEOF(h.total_numrel_monthpspastmost_24))'',0,100));
    maxlength_total_numrel_monthpspastmost_24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_numrel_monthpspastmost_24)));
    avelength_total_numrel_monthpspastmost_24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_numrel_monthpspastmost_24)),h.total_numrel_monthpspastmost_24<>(typeof(h.total_numrel_monthpspastmost_24))'');
    populated_total_numrel_monthspastleast_24_cnt := COUNT(GROUP,h.total_numrel_monthspastleast_24 <> (TYPEOF(h.total_numrel_monthspastleast_24))'');
    populated_total_numrel_monthspastleast_24_pcnt := AVE(GROUP,IF(h.total_numrel_monthspastleast_24 = (TYPEOF(h.total_numrel_monthspastleast_24))'',0,100));
    maxlength_total_numrel_monthspastleast_24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_numrel_monthspastleast_24)));
    avelength_total_numrel_monthspastleast_24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_numrel_monthspastleast_24)),h.total_numrel_monthspastleast_24<>(typeof(h.total_numrel_monthspastleast_24))'');
    populated_total_numrel_slope_0t12_cnt := COUNT(GROUP,h.total_numrel_slope_0t12 <> (TYPEOF(h.total_numrel_slope_0t12))'');
    populated_total_numrel_slope_0t12_pcnt := AVE(GROUP,IF(h.total_numrel_slope_0t12 = (TYPEOF(h.total_numrel_slope_0t12))'',0,100));
    maxlength_total_numrel_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_numrel_slope_0t12)));
    avelength_total_numrel_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_numrel_slope_0t12)),h.total_numrel_slope_0t12<>(typeof(h.total_numrel_slope_0t12))'');
    populated_total_numrel_slope_0t24_cnt := COUNT(GROUP,h.total_numrel_slope_0t24 <> (TYPEOF(h.total_numrel_slope_0t24))'');
    populated_total_numrel_slope_0t24_pcnt := AVE(GROUP,IF(h.total_numrel_slope_0t24 = (TYPEOF(h.total_numrel_slope_0t24))'',0,100));
    maxlength_total_numrel_slope_0t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_numrel_slope_0t24)));
    avelength_total_numrel_slope_0t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_numrel_slope_0t24)),h.total_numrel_slope_0t24<>(typeof(h.total_numrel_slope_0t24))'');
    populated_total_numrel_slope_0t6_cnt := COUNT(GROUP,h.total_numrel_slope_0t6 <> (TYPEOF(h.total_numrel_slope_0t6))'');
    populated_total_numrel_slope_0t6_pcnt := AVE(GROUP,IF(h.total_numrel_slope_0t6 = (TYPEOF(h.total_numrel_slope_0t6))'',0,100));
    maxlength_total_numrel_slope_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_numrel_slope_0t6)));
    avelength_total_numrel_slope_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_numrel_slope_0t6)),h.total_numrel_slope_0t6<>(typeof(h.total_numrel_slope_0t6))'');
    populated_total_numrel_slope_6t12_cnt := COUNT(GROUP,h.total_numrel_slope_6t12 <> (TYPEOF(h.total_numrel_slope_6t12))'');
    populated_total_numrel_slope_6t12_pcnt := AVE(GROUP,IF(h.total_numrel_slope_6t12 = (TYPEOF(h.total_numrel_slope_6t12))'',0,100));
    maxlength_total_numrel_slope_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_numrel_slope_6t12)));
    avelength_total_numrel_slope_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_numrel_slope_6t12)),h.total_numrel_slope_6t12<>(typeof(h.total_numrel_slope_6t12))'');
    populated_total_numrel_var_0t12_cnt := COUNT(GROUP,h.total_numrel_var_0t12 <> (TYPEOF(h.total_numrel_var_0t12))'');
    populated_total_numrel_var_0t12_pcnt := AVE(GROUP,IF(h.total_numrel_var_0t12 = (TYPEOF(h.total_numrel_var_0t12))'',0,100));
    maxlength_total_numrel_var_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_numrel_var_0t12)));
    avelength_total_numrel_var_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_numrel_var_0t12)),h.total_numrel_var_0t12<>(typeof(h.total_numrel_var_0t12))'');
    populated_total_numrel_var_0t24_cnt := COUNT(GROUP,h.total_numrel_var_0t24 <> (TYPEOF(h.total_numrel_var_0t24))'');
    populated_total_numrel_var_0t24_pcnt := AVE(GROUP,IF(h.total_numrel_var_0t24 = (TYPEOF(h.total_numrel_var_0t24))'',0,100));
    maxlength_total_numrel_var_0t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_numrel_var_0t24)));
    avelength_total_numrel_var_0t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_numrel_var_0t24)),h.total_numrel_var_0t24<>(typeof(h.total_numrel_var_0t24))'');
    populated_total_numrel_var_12t24_cnt := COUNT(GROUP,h.total_numrel_var_12t24 <> (TYPEOF(h.total_numrel_var_12t24))'');
    populated_total_numrel_var_12t24_pcnt := AVE(GROUP,IF(h.total_numrel_var_12t24 = (TYPEOF(h.total_numrel_var_12t24))'',0,100));
    maxlength_total_numrel_var_12t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_numrel_var_12t24)));
    avelength_total_numrel_var_12t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_numrel_var_12t24)),h.total_numrel_var_12t24<>(typeof(h.total_numrel_var_12t24))'');
    populated_total_numrel_var_6t18_cnt := COUNT(GROUP,h.total_numrel_var_6t18 <> (TYPEOF(h.total_numrel_var_6t18))'');
    populated_total_numrel_var_6t18_pcnt := AVE(GROUP,IF(h.total_numrel_var_6t18 = (TYPEOF(h.total_numrel_var_6t18))'',0,100));
    maxlength_total_numrel_var_6t18 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_numrel_var_6t18)));
    avelength_total_numrel_var_6t18 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_numrel_var_6t18)),h.total_numrel_var_6t18<>(typeof(h.total_numrel_var_6t18))'');
    populated_mfgmat_numrel_avg12_cnt := COUNT(GROUP,h.mfgmat_numrel_avg12 <> (TYPEOF(h.mfgmat_numrel_avg12))'');
    populated_mfgmat_numrel_avg12_pcnt := AVE(GROUP,IF(h.mfgmat_numrel_avg12 = (TYPEOF(h.mfgmat_numrel_avg12))'',0,100));
    maxlength_mfgmat_numrel_avg12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_numrel_avg12)));
    avelength_mfgmat_numrel_avg12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_numrel_avg12)),h.mfgmat_numrel_avg12<>(typeof(h.mfgmat_numrel_avg12))'');
    populated_mfgmat_numrel_slope_0t12_cnt := COUNT(GROUP,h.mfgmat_numrel_slope_0t12 <> (TYPEOF(h.mfgmat_numrel_slope_0t12))'');
    populated_mfgmat_numrel_slope_0t12_pcnt := AVE(GROUP,IF(h.mfgmat_numrel_slope_0t12 = (TYPEOF(h.mfgmat_numrel_slope_0t12))'',0,100));
    maxlength_mfgmat_numrel_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_numrel_slope_0t12)));
    avelength_mfgmat_numrel_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_numrel_slope_0t12)),h.mfgmat_numrel_slope_0t12<>(typeof(h.mfgmat_numrel_slope_0t12))'');
    populated_mfgmat_numrel_slope_0t24_cnt := COUNT(GROUP,h.mfgmat_numrel_slope_0t24 <> (TYPEOF(h.mfgmat_numrel_slope_0t24))'');
    populated_mfgmat_numrel_slope_0t24_pcnt := AVE(GROUP,IF(h.mfgmat_numrel_slope_0t24 = (TYPEOF(h.mfgmat_numrel_slope_0t24))'',0,100));
    maxlength_mfgmat_numrel_slope_0t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_numrel_slope_0t24)));
    avelength_mfgmat_numrel_slope_0t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_numrel_slope_0t24)),h.mfgmat_numrel_slope_0t24<>(typeof(h.mfgmat_numrel_slope_0t24))'');
    populated_mfgmat_numrel_slope_0t6_cnt := COUNT(GROUP,h.mfgmat_numrel_slope_0t6 <> (TYPEOF(h.mfgmat_numrel_slope_0t6))'');
    populated_mfgmat_numrel_slope_0t6_pcnt := AVE(GROUP,IF(h.mfgmat_numrel_slope_0t6 = (TYPEOF(h.mfgmat_numrel_slope_0t6))'',0,100));
    maxlength_mfgmat_numrel_slope_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_numrel_slope_0t6)));
    avelength_mfgmat_numrel_slope_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_numrel_slope_0t6)),h.mfgmat_numrel_slope_0t6<>(typeof(h.mfgmat_numrel_slope_0t6))'');
    populated_mfgmat_numrel_slope_6t12_cnt := COUNT(GROUP,h.mfgmat_numrel_slope_6t12 <> (TYPEOF(h.mfgmat_numrel_slope_6t12))'');
    populated_mfgmat_numrel_slope_6t12_pcnt := AVE(GROUP,IF(h.mfgmat_numrel_slope_6t12 = (TYPEOF(h.mfgmat_numrel_slope_6t12))'',0,100));
    maxlength_mfgmat_numrel_slope_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_numrel_slope_6t12)));
    avelength_mfgmat_numrel_slope_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_numrel_slope_6t12)),h.mfgmat_numrel_slope_6t12<>(typeof(h.mfgmat_numrel_slope_6t12))'');
    populated_mfgmat_numrel_var_0t12_cnt := COUNT(GROUP,h.mfgmat_numrel_var_0t12 <> (TYPEOF(h.mfgmat_numrel_var_0t12))'');
    populated_mfgmat_numrel_var_0t12_pcnt := AVE(GROUP,IF(h.mfgmat_numrel_var_0t12 = (TYPEOF(h.mfgmat_numrel_var_0t12))'',0,100));
    maxlength_mfgmat_numrel_var_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_numrel_var_0t12)));
    avelength_mfgmat_numrel_var_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_numrel_var_0t12)),h.mfgmat_numrel_var_0t12<>(typeof(h.mfgmat_numrel_var_0t12))'');
    populated_mfgmat_numrel_var_12t24_cnt := COUNT(GROUP,h.mfgmat_numrel_var_12t24 <> (TYPEOF(h.mfgmat_numrel_var_12t24))'');
    populated_mfgmat_numrel_var_12t24_pcnt := AVE(GROUP,IF(h.mfgmat_numrel_var_12t24 = (TYPEOF(h.mfgmat_numrel_var_12t24))'',0,100));
    maxlength_mfgmat_numrel_var_12t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_numrel_var_12t24)));
    avelength_mfgmat_numrel_var_12t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_numrel_var_12t24)),h.mfgmat_numrel_var_12t24<>(typeof(h.mfgmat_numrel_var_12t24))'');
    populated_ops_numrel_avg12_cnt := COUNT(GROUP,h.ops_numrel_avg12 <> (TYPEOF(h.ops_numrel_avg12))'');
    populated_ops_numrel_avg12_pcnt := AVE(GROUP,IF(h.ops_numrel_avg12 = (TYPEOF(h.ops_numrel_avg12))'',0,100));
    maxlength_ops_numrel_avg12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_numrel_avg12)));
    avelength_ops_numrel_avg12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_numrel_avg12)),h.ops_numrel_avg12<>(typeof(h.ops_numrel_avg12))'');
    populated_ops_numrel_slope_0t12_cnt := COUNT(GROUP,h.ops_numrel_slope_0t12 <> (TYPEOF(h.ops_numrel_slope_0t12))'');
    populated_ops_numrel_slope_0t12_pcnt := AVE(GROUP,IF(h.ops_numrel_slope_0t12 = (TYPEOF(h.ops_numrel_slope_0t12))'',0,100));
    maxlength_ops_numrel_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_numrel_slope_0t12)));
    avelength_ops_numrel_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_numrel_slope_0t12)),h.ops_numrel_slope_0t12<>(typeof(h.ops_numrel_slope_0t12))'');
    populated_ops_numrel_slope_0t24_cnt := COUNT(GROUP,h.ops_numrel_slope_0t24 <> (TYPEOF(h.ops_numrel_slope_0t24))'');
    populated_ops_numrel_slope_0t24_pcnt := AVE(GROUP,IF(h.ops_numrel_slope_0t24 = (TYPEOF(h.ops_numrel_slope_0t24))'',0,100));
    maxlength_ops_numrel_slope_0t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_numrel_slope_0t24)));
    avelength_ops_numrel_slope_0t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_numrel_slope_0t24)),h.ops_numrel_slope_0t24<>(typeof(h.ops_numrel_slope_0t24))'');
    populated_ops_numrel_slope_0t6_cnt := COUNT(GROUP,h.ops_numrel_slope_0t6 <> (TYPEOF(h.ops_numrel_slope_0t6))'');
    populated_ops_numrel_slope_0t6_pcnt := AVE(GROUP,IF(h.ops_numrel_slope_0t6 = (TYPEOF(h.ops_numrel_slope_0t6))'',0,100));
    maxlength_ops_numrel_slope_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_numrel_slope_0t6)));
    avelength_ops_numrel_slope_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_numrel_slope_0t6)),h.ops_numrel_slope_0t6<>(typeof(h.ops_numrel_slope_0t6))'');
    populated_ops_numrel_slope_6t12_cnt := COUNT(GROUP,h.ops_numrel_slope_6t12 <> (TYPEOF(h.ops_numrel_slope_6t12))'');
    populated_ops_numrel_slope_6t12_pcnt := AVE(GROUP,IF(h.ops_numrel_slope_6t12 = (TYPEOF(h.ops_numrel_slope_6t12))'',0,100));
    maxlength_ops_numrel_slope_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_numrel_slope_6t12)));
    avelength_ops_numrel_slope_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_numrel_slope_6t12)),h.ops_numrel_slope_6t12<>(typeof(h.ops_numrel_slope_6t12))'');
    populated_ops_numrel_var_0t12_cnt := COUNT(GROUP,h.ops_numrel_var_0t12 <> (TYPEOF(h.ops_numrel_var_0t12))'');
    populated_ops_numrel_var_0t12_pcnt := AVE(GROUP,IF(h.ops_numrel_var_0t12 = (TYPEOF(h.ops_numrel_var_0t12))'',0,100));
    maxlength_ops_numrel_var_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_numrel_var_0t12)));
    avelength_ops_numrel_var_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_numrel_var_0t12)),h.ops_numrel_var_0t12<>(typeof(h.ops_numrel_var_0t12))'');
    populated_ops_numrel_var_12t24_cnt := COUNT(GROUP,h.ops_numrel_var_12t24 <> (TYPEOF(h.ops_numrel_var_12t24))'');
    populated_ops_numrel_var_12t24_pcnt := AVE(GROUP,IF(h.ops_numrel_var_12t24 = (TYPEOF(h.ops_numrel_var_12t24))'',0,100));
    maxlength_ops_numrel_var_12t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_numrel_var_12t24)));
    avelength_ops_numrel_var_12t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_numrel_var_12t24)),h.ops_numrel_var_12t24<>(typeof(h.ops_numrel_var_12t24))'');
    populated_fleet_numrel_avg12_cnt := COUNT(GROUP,h.fleet_numrel_avg12 <> (TYPEOF(h.fleet_numrel_avg12))'');
    populated_fleet_numrel_avg12_pcnt := AVE(GROUP,IF(h.fleet_numrel_avg12 = (TYPEOF(h.fleet_numrel_avg12))'',0,100));
    maxlength_fleet_numrel_avg12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_numrel_avg12)));
    avelength_fleet_numrel_avg12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_numrel_avg12)),h.fleet_numrel_avg12<>(typeof(h.fleet_numrel_avg12))'');
    populated_fleet_numrel_slope_0t12_cnt := COUNT(GROUP,h.fleet_numrel_slope_0t12 <> (TYPEOF(h.fleet_numrel_slope_0t12))'');
    populated_fleet_numrel_slope_0t12_pcnt := AVE(GROUP,IF(h.fleet_numrel_slope_0t12 = (TYPEOF(h.fleet_numrel_slope_0t12))'',0,100));
    maxlength_fleet_numrel_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_numrel_slope_0t12)));
    avelength_fleet_numrel_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_numrel_slope_0t12)),h.fleet_numrel_slope_0t12<>(typeof(h.fleet_numrel_slope_0t12))'');
    populated_fleet_numrel_slope_0t24_cnt := COUNT(GROUP,h.fleet_numrel_slope_0t24 <> (TYPEOF(h.fleet_numrel_slope_0t24))'');
    populated_fleet_numrel_slope_0t24_pcnt := AVE(GROUP,IF(h.fleet_numrel_slope_0t24 = (TYPEOF(h.fleet_numrel_slope_0t24))'',0,100));
    maxlength_fleet_numrel_slope_0t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_numrel_slope_0t24)));
    avelength_fleet_numrel_slope_0t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_numrel_slope_0t24)),h.fleet_numrel_slope_0t24<>(typeof(h.fleet_numrel_slope_0t24))'');
    populated_fleet_numrel_slope_0t6_cnt := COUNT(GROUP,h.fleet_numrel_slope_0t6 <> (TYPEOF(h.fleet_numrel_slope_0t6))'');
    populated_fleet_numrel_slope_0t6_pcnt := AVE(GROUP,IF(h.fleet_numrel_slope_0t6 = (TYPEOF(h.fleet_numrel_slope_0t6))'',0,100));
    maxlength_fleet_numrel_slope_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_numrel_slope_0t6)));
    avelength_fleet_numrel_slope_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_numrel_slope_0t6)),h.fleet_numrel_slope_0t6<>(typeof(h.fleet_numrel_slope_0t6))'');
    populated_fleet_numrel_slope_6t12_cnt := COUNT(GROUP,h.fleet_numrel_slope_6t12 <> (TYPEOF(h.fleet_numrel_slope_6t12))'');
    populated_fleet_numrel_slope_6t12_pcnt := AVE(GROUP,IF(h.fleet_numrel_slope_6t12 = (TYPEOF(h.fleet_numrel_slope_6t12))'',0,100));
    maxlength_fleet_numrel_slope_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_numrel_slope_6t12)));
    avelength_fleet_numrel_slope_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_numrel_slope_6t12)),h.fleet_numrel_slope_6t12<>(typeof(h.fleet_numrel_slope_6t12))'');
    populated_fleet_numrel_var_0t12_cnt := COUNT(GROUP,h.fleet_numrel_var_0t12 <> (TYPEOF(h.fleet_numrel_var_0t12))'');
    populated_fleet_numrel_var_0t12_pcnt := AVE(GROUP,IF(h.fleet_numrel_var_0t12 = (TYPEOF(h.fleet_numrel_var_0t12))'',0,100));
    maxlength_fleet_numrel_var_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_numrel_var_0t12)));
    avelength_fleet_numrel_var_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_numrel_var_0t12)),h.fleet_numrel_var_0t12<>(typeof(h.fleet_numrel_var_0t12))'');
    populated_fleet_numrel_var_12t24_cnt := COUNT(GROUP,h.fleet_numrel_var_12t24 <> (TYPEOF(h.fleet_numrel_var_12t24))'');
    populated_fleet_numrel_var_12t24_pcnt := AVE(GROUP,IF(h.fleet_numrel_var_12t24 = (TYPEOF(h.fleet_numrel_var_12t24))'',0,100));
    maxlength_fleet_numrel_var_12t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_numrel_var_12t24)));
    avelength_fleet_numrel_var_12t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_numrel_var_12t24)),h.fleet_numrel_var_12t24<>(typeof(h.fleet_numrel_var_12t24))'');
    populated_carrier_numrel_avg12_cnt := COUNT(GROUP,h.carrier_numrel_avg12 <> (TYPEOF(h.carrier_numrel_avg12))'');
    populated_carrier_numrel_avg12_pcnt := AVE(GROUP,IF(h.carrier_numrel_avg12 = (TYPEOF(h.carrier_numrel_avg12))'',0,100));
    maxlength_carrier_numrel_avg12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_numrel_avg12)));
    avelength_carrier_numrel_avg12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_numrel_avg12)),h.carrier_numrel_avg12<>(typeof(h.carrier_numrel_avg12))'');
    populated_carrier_numrel_slope_0t12_cnt := COUNT(GROUP,h.carrier_numrel_slope_0t12 <> (TYPEOF(h.carrier_numrel_slope_0t12))'');
    populated_carrier_numrel_slope_0t12_pcnt := AVE(GROUP,IF(h.carrier_numrel_slope_0t12 = (TYPEOF(h.carrier_numrel_slope_0t12))'',0,100));
    maxlength_carrier_numrel_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_numrel_slope_0t12)));
    avelength_carrier_numrel_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_numrel_slope_0t12)),h.carrier_numrel_slope_0t12<>(typeof(h.carrier_numrel_slope_0t12))'');
    populated_carrier_numrel_slope_0t24_cnt := COUNT(GROUP,h.carrier_numrel_slope_0t24 <> (TYPEOF(h.carrier_numrel_slope_0t24))'');
    populated_carrier_numrel_slope_0t24_pcnt := AVE(GROUP,IF(h.carrier_numrel_slope_0t24 = (TYPEOF(h.carrier_numrel_slope_0t24))'',0,100));
    maxlength_carrier_numrel_slope_0t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_numrel_slope_0t24)));
    avelength_carrier_numrel_slope_0t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_numrel_slope_0t24)),h.carrier_numrel_slope_0t24<>(typeof(h.carrier_numrel_slope_0t24))'');
    populated_carrier_numrel_slope_0t6_cnt := COUNT(GROUP,h.carrier_numrel_slope_0t6 <> (TYPEOF(h.carrier_numrel_slope_0t6))'');
    populated_carrier_numrel_slope_0t6_pcnt := AVE(GROUP,IF(h.carrier_numrel_slope_0t6 = (TYPEOF(h.carrier_numrel_slope_0t6))'',0,100));
    maxlength_carrier_numrel_slope_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_numrel_slope_0t6)));
    avelength_carrier_numrel_slope_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_numrel_slope_0t6)),h.carrier_numrel_slope_0t6<>(typeof(h.carrier_numrel_slope_0t6))'');
    populated_carrier_numrel_slope_6t12_cnt := COUNT(GROUP,h.carrier_numrel_slope_6t12 <> (TYPEOF(h.carrier_numrel_slope_6t12))'');
    populated_carrier_numrel_slope_6t12_pcnt := AVE(GROUP,IF(h.carrier_numrel_slope_6t12 = (TYPEOF(h.carrier_numrel_slope_6t12))'',0,100));
    maxlength_carrier_numrel_slope_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_numrel_slope_6t12)));
    avelength_carrier_numrel_slope_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_numrel_slope_6t12)),h.carrier_numrel_slope_6t12<>(typeof(h.carrier_numrel_slope_6t12))'');
    populated_carrier_numrel_var_0t12_cnt := COUNT(GROUP,h.carrier_numrel_var_0t12 <> (TYPEOF(h.carrier_numrel_var_0t12))'');
    populated_carrier_numrel_var_0t12_pcnt := AVE(GROUP,IF(h.carrier_numrel_var_0t12 = (TYPEOF(h.carrier_numrel_var_0t12))'',0,100));
    maxlength_carrier_numrel_var_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_numrel_var_0t12)));
    avelength_carrier_numrel_var_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_numrel_var_0t12)),h.carrier_numrel_var_0t12<>(typeof(h.carrier_numrel_var_0t12))'');
    populated_carrier_numrel_var_12t24_cnt := COUNT(GROUP,h.carrier_numrel_var_12t24 <> (TYPEOF(h.carrier_numrel_var_12t24))'');
    populated_carrier_numrel_var_12t24_pcnt := AVE(GROUP,IF(h.carrier_numrel_var_12t24 = (TYPEOF(h.carrier_numrel_var_12t24))'',0,100));
    maxlength_carrier_numrel_var_12t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_numrel_var_12t24)));
    avelength_carrier_numrel_var_12t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_numrel_var_12t24)),h.carrier_numrel_var_12t24<>(typeof(h.carrier_numrel_var_12t24))'');
    populated_bldgmats_numrel_avg12_cnt := COUNT(GROUP,h.bldgmats_numrel_avg12 <> (TYPEOF(h.bldgmats_numrel_avg12))'');
    populated_bldgmats_numrel_avg12_pcnt := AVE(GROUP,IF(h.bldgmats_numrel_avg12 = (TYPEOF(h.bldgmats_numrel_avg12))'',0,100));
    maxlength_bldgmats_numrel_avg12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_numrel_avg12)));
    avelength_bldgmats_numrel_avg12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_numrel_avg12)),h.bldgmats_numrel_avg12<>(typeof(h.bldgmats_numrel_avg12))'');
    populated_bldgmats_numrel_slope_0t12_cnt := COUNT(GROUP,h.bldgmats_numrel_slope_0t12 <> (TYPEOF(h.bldgmats_numrel_slope_0t12))'');
    populated_bldgmats_numrel_slope_0t12_pcnt := AVE(GROUP,IF(h.bldgmats_numrel_slope_0t12 = (TYPEOF(h.bldgmats_numrel_slope_0t12))'',0,100));
    maxlength_bldgmats_numrel_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_numrel_slope_0t12)));
    avelength_bldgmats_numrel_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_numrel_slope_0t12)),h.bldgmats_numrel_slope_0t12<>(typeof(h.bldgmats_numrel_slope_0t12))'');
    populated_bldgmats_numrel_slope_0t24_cnt := COUNT(GROUP,h.bldgmats_numrel_slope_0t24 <> (TYPEOF(h.bldgmats_numrel_slope_0t24))'');
    populated_bldgmats_numrel_slope_0t24_pcnt := AVE(GROUP,IF(h.bldgmats_numrel_slope_0t24 = (TYPEOF(h.bldgmats_numrel_slope_0t24))'',0,100));
    maxlength_bldgmats_numrel_slope_0t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_numrel_slope_0t24)));
    avelength_bldgmats_numrel_slope_0t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_numrel_slope_0t24)),h.bldgmats_numrel_slope_0t24<>(typeof(h.bldgmats_numrel_slope_0t24))'');
    populated_bldgmats_numrel_slope_0t6_cnt := COUNT(GROUP,h.bldgmats_numrel_slope_0t6 <> (TYPEOF(h.bldgmats_numrel_slope_0t6))'');
    populated_bldgmats_numrel_slope_0t6_pcnt := AVE(GROUP,IF(h.bldgmats_numrel_slope_0t6 = (TYPEOF(h.bldgmats_numrel_slope_0t6))'',0,100));
    maxlength_bldgmats_numrel_slope_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_numrel_slope_0t6)));
    avelength_bldgmats_numrel_slope_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_numrel_slope_0t6)),h.bldgmats_numrel_slope_0t6<>(typeof(h.bldgmats_numrel_slope_0t6))'');
    populated_bldgmats_numrel_slope_6t12_cnt := COUNT(GROUP,h.bldgmats_numrel_slope_6t12 <> (TYPEOF(h.bldgmats_numrel_slope_6t12))'');
    populated_bldgmats_numrel_slope_6t12_pcnt := AVE(GROUP,IF(h.bldgmats_numrel_slope_6t12 = (TYPEOF(h.bldgmats_numrel_slope_6t12))'',0,100));
    maxlength_bldgmats_numrel_slope_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_numrel_slope_6t12)));
    avelength_bldgmats_numrel_slope_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_numrel_slope_6t12)),h.bldgmats_numrel_slope_6t12<>(typeof(h.bldgmats_numrel_slope_6t12))'');
    populated_bldgmats_numrel_var_0t12_cnt := COUNT(GROUP,h.bldgmats_numrel_var_0t12 <> (TYPEOF(h.bldgmats_numrel_var_0t12))'');
    populated_bldgmats_numrel_var_0t12_pcnt := AVE(GROUP,IF(h.bldgmats_numrel_var_0t12 = (TYPEOF(h.bldgmats_numrel_var_0t12))'',0,100));
    maxlength_bldgmats_numrel_var_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_numrel_var_0t12)));
    avelength_bldgmats_numrel_var_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_numrel_var_0t12)),h.bldgmats_numrel_var_0t12<>(typeof(h.bldgmats_numrel_var_0t12))'');
    populated_bldgmats_numrel_var_12t24_cnt := COUNT(GROUP,h.bldgmats_numrel_var_12t24 <> (TYPEOF(h.bldgmats_numrel_var_12t24))'');
    populated_bldgmats_numrel_var_12t24_pcnt := AVE(GROUP,IF(h.bldgmats_numrel_var_12t24 = (TYPEOF(h.bldgmats_numrel_var_12t24))'',0,100));
    maxlength_bldgmats_numrel_var_12t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_numrel_var_12t24)));
    avelength_bldgmats_numrel_var_12t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_numrel_var_12t24)),h.bldgmats_numrel_var_12t24<>(typeof(h.bldgmats_numrel_var_12t24))'');
    populated_total_monthsoutstanding_slope24_cnt := COUNT(GROUP,h.total_monthsoutstanding_slope24 <> (TYPEOF(h.total_monthsoutstanding_slope24))'');
    populated_total_monthsoutstanding_slope24_pcnt := AVE(GROUP,IF(h.total_monthsoutstanding_slope24 = (TYPEOF(h.total_monthsoutstanding_slope24))'',0,100));
    maxlength_total_monthsoutstanding_slope24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_monthsoutstanding_slope24)));
    avelength_total_monthsoutstanding_slope24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_monthsoutstanding_slope24)),h.total_monthsoutstanding_slope24<>(typeof(h.total_monthsoutstanding_slope24))'');
    populated_total_percprov30_avg_0t12_cnt := COUNT(GROUP,h.total_percprov30_avg_0t12 <> (TYPEOF(h.total_percprov30_avg_0t12))'');
    populated_total_percprov30_avg_0t12_pcnt := AVE(GROUP,IF(h.total_percprov30_avg_0t12 = (TYPEOF(h.total_percprov30_avg_0t12))'',0,100));
    maxlength_total_percprov30_avg_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov30_avg_0t12)));
    avelength_total_percprov30_avg_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov30_avg_0t12)),h.total_percprov30_avg_0t12<>(typeof(h.total_percprov30_avg_0t12))'');
    populated_total_percprov30_slope_0t12_cnt := COUNT(GROUP,h.total_percprov30_slope_0t12 <> (TYPEOF(h.total_percprov30_slope_0t12))'');
    populated_total_percprov30_slope_0t12_pcnt := AVE(GROUP,IF(h.total_percprov30_slope_0t12 = (TYPEOF(h.total_percprov30_slope_0t12))'',0,100));
    maxlength_total_percprov30_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov30_slope_0t12)));
    avelength_total_percprov30_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov30_slope_0t12)),h.total_percprov30_slope_0t12<>(typeof(h.total_percprov30_slope_0t12))'');
    populated_total_percprov30_slope_0t24_cnt := COUNT(GROUP,h.total_percprov30_slope_0t24 <> (TYPEOF(h.total_percprov30_slope_0t24))'');
    populated_total_percprov30_slope_0t24_pcnt := AVE(GROUP,IF(h.total_percprov30_slope_0t24 = (TYPEOF(h.total_percprov30_slope_0t24))'',0,100));
    maxlength_total_percprov30_slope_0t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov30_slope_0t24)));
    avelength_total_percprov30_slope_0t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov30_slope_0t24)),h.total_percprov30_slope_0t24<>(typeof(h.total_percprov30_slope_0t24))'');
    populated_total_percprov30_slope_0t6_cnt := COUNT(GROUP,h.total_percprov30_slope_0t6 <> (TYPEOF(h.total_percprov30_slope_0t6))'');
    populated_total_percprov30_slope_0t6_pcnt := AVE(GROUP,IF(h.total_percprov30_slope_0t6 = (TYPEOF(h.total_percprov30_slope_0t6))'',0,100));
    maxlength_total_percprov30_slope_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov30_slope_0t6)));
    avelength_total_percprov30_slope_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov30_slope_0t6)),h.total_percprov30_slope_0t6<>(typeof(h.total_percprov30_slope_0t6))'');
    populated_total_percprov30_slope_6t12_cnt := COUNT(GROUP,h.total_percprov30_slope_6t12 <> (TYPEOF(h.total_percprov30_slope_6t12))'');
    populated_total_percprov30_slope_6t12_pcnt := AVE(GROUP,IF(h.total_percprov30_slope_6t12 = (TYPEOF(h.total_percprov30_slope_6t12))'',0,100));
    maxlength_total_percprov30_slope_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov30_slope_6t12)));
    avelength_total_percprov30_slope_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov30_slope_6t12)),h.total_percprov30_slope_6t12<>(typeof(h.total_percprov30_slope_6t12))'');
    populated_total_percprov60_avg_0t12_cnt := COUNT(GROUP,h.total_percprov60_avg_0t12 <> (TYPEOF(h.total_percprov60_avg_0t12))'');
    populated_total_percprov60_avg_0t12_pcnt := AVE(GROUP,IF(h.total_percprov60_avg_0t12 = (TYPEOF(h.total_percprov60_avg_0t12))'',0,100));
    maxlength_total_percprov60_avg_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov60_avg_0t12)));
    avelength_total_percprov60_avg_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov60_avg_0t12)),h.total_percprov60_avg_0t12<>(typeof(h.total_percprov60_avg_0t12))'');
    populated_total_percprov60_slope_0t12_cnt := COUNT(GROUP,h.total_percprov60_slope_0t12 <> (TYPEOF(h.total_percprov60_slope_0t12))'');
    populated_total_percprov60_slope_0t12_pcnt := AVE(GROUP,IF(h.total_percprov60_slope_0t12 = (TYPEOF(h.total_percprov60_slope_0t12))'',0,100));
    maxlength_total_percprov60_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov60_slope_0t12)));
    avelength_total_percprov60_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov60_slope_0t12)),h.total_percprov60_slope_0t12<>(typeof(h.total_percprov60_slope_0t12))'');
    populated_total_percprov60_slope_0t24_cnt := COUNT(GROUP,h.total_percprov60_slope_0t24 <> (TYPEOF(h.total_percprov60_slope_0t24))'');
    populated_total_percprov60_slope_0t24_pcnt := AVE(GROUP,IF(h.total_percprov60_slope_0t24 = (TYPEOF(h.total_percprov60_slope_0t24))'',0,100));
    maxlength_total_percprov60_slope_0t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov60_slope_0t24)));
    avelength_total_percprov60_slope_0t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov60_slope_0t24)),h.total_percprov60_slope_0t24<>(typeof(h.total_percprov60_slope_0t24))'');
    populated_total_percprov60_slope_0t6_cnt := COUNT(GROUP,h.total_percprov60_slope_0t6 <> (TYPEOF(h.total_percprov60_slope_0t6))'');
    populated_total_percprov60_slope_0t6_pcnt := AVE(GROUP,IF(h.total_percprov60_slope_0t6 = (TYPEOF(h.total_percprov60_slope_0t6))'',0,100));
    maxlength_total_percprov60_slope_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov60_slope_0t6)));
    avelength_total_percprov60_slope_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov60_slope_0t6)),h.total_percprov60_slope_0t6<>(typeof(h.total_percprov60_slope_0t6))'');
    populated_total_percprov60_slope_6t12_cnt := COUNT(GROUP,h.total_percprov60_slope_6t12 <> (TYPEOF(h.total_percprov60_slope_6t12))'');
    populated_total_percprov60_slope_6t12_pcnt := AVE(GROUP,IF(h.total_percprov60_slope_6t12 = (TYPEOF(h.total_percprov60_slope_6t12))'',0,100));
    maxlength_total_percprov60_slope_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov60_slope_6t12)));
    avelength_total_percprov60_slope_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov60_slope_6t12)),h.total_percprov60_slope_6t12<>(typeof(h.total_percprov60_slope_6t12))'');
    populated_total_percprov90_avg_0t12_cnt := COUNT(GROUP,h.total_percprov90_avg_0t12 <> (TYPEOF(h.total_percprov90_avg_0t12))'');
    populated_total_percprov90_avg_0t12_pcnt := AVE(GROUP,IF(h.total_percprov90_avg_0t12 = (TYPEOF(h.total_percprov90_avg_0t12))'',0,100));
    maxlength_total_percprov90_avg_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov90_avg_0t12)));
    avelength_total_percprov90_avg_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov90_avg_0t12)),h.total_percprov90_avg_0t12<>(typeof(h.total_percprov90_avg_0t12))'');
    populated_total_percprov90_lowerlim_0t12_cnt := COUNT(GROUP,h.total_percprov90_lowerlim_0t12 <> (TYPEOF(h.total_percprov90_lowerlim_0t12))'');
    populated_total_percprov90_lowerlim_0t12_pcnt := AVE(GROUP,IF(h.total_percprov90_lowerlim_0t12 = (TYPEOF(h.total_percprov90_lowerlim_0t12))'',0,100));
    maxlength_total_percprov90_lowerlim_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov90_lowerlim_0t12)));
    avelength_total_percprov90_lowerlim_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov90_lowerlim_0t12)),h.total_percprov90_lowerlim_0t12<>(typeof(h.total_percprov90_lowerlim_0t12))'');
    populated_total_percprov90_slope_0t24_cnt := COUNT(GROUP,h.total_percprov90_slope_0t24 <> (TYPEOF(h.total_percprov90_slope_0t24))'');
    populated_total_percprov90_slope_0t24_pcnt := AVE(GROUP,IF(h.total_percprov90_slope_0t24 = (TYPEOF(h.total_percprov90_slope_0t24))'',0,100));
    maxlength_total_percprov90_slope_0t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov90_slope_0t24)));
    avelength_total_percprov90_slope_0t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov90_slope_0t24)),h.total_percprov90_slope_0t24<>(typeof(h.total_percprov90_slope_0t24))'');
    populated_total_percprov90_slope_0t6_cnt := COUNT(GROUP,h.total_percprov90_slope_0t6 <> (TYPEOF(h.total_percprov90_slope_0t6))'');
    populated_total_percprov90_slope_0t6_pcnt := AVE(GROUP,IF(h.total_percprov90_slope_0t6 = (TYPEOF(h.total_percprov90_slope_0t6))'',0,100));
    maxlength_total_percprov90_slope_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov90_slope_0t6)));
    avelength_total_percprov90_slope_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov90_slope_0t6)),h.total_percprov90_slope_0t6<>(typeof(h.total_percprov90_slope_0t6))'');
    populated_total_percprov90_slope_6t12_cnt := COUNT(GROUP,h.total_percprov90_slope_6t12 <> (TYPEOF(h.total_percprov90_slope_6t12))'');
    populated_total_percprov90_slope_6t12_pcnt := AVE(GROUP,IF(h.total_percprov90_slope_6t12 = (TYPEOF(h.total_percprov90_slope_6t12))'',0,100));
    maxlength_total_percprov90_slope_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov90_slope_6t12)));
    avelength_total_percprov90_slope_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprov90_slope_6t12)),h.total_percprov90_slope_6t12<>(typeof(h.total_percprov90_slope_6t12))'');
    populated_total_percprovoutstanding_adjustedslope_0t12_cnt := COUNT(GROUP,h.total_percprovoutstanding_adjustedslope_0t12 <> (TYPEOF(h.total_percprovoutstanding_adjustedslope_0t12))'');
    populated_total_percprovoutstanding_adjustedslope_0t12_pcnt := AVE(GROUP,IF(h.total_percprovoutstanding_adjustedslope_0t12 = (TYPEOF(h.total_percprovoutstanding_adjustedslope_0t12))'',0,100));
    maxlength_total_percprovoutstanding_adjustedslope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprovoutstanding_adjustedslope_0t12)));
    avelength_total_percprovoutstanding_adjustedslope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_percprovoutstanding_adjustedslope_0t12)),h.total_percprovoutstanding_adjustedslope_0t12<>(typeof(h.total_percprovoutstanding_adjustedslope_0t12))'');
    populated_mfgmat_monthsoutstanding_slope24_cnt := COUNT(GROUP,h.mfgmat_monthsoutstanding_slope24 <> (TYPEOF(h.mfgmat_monthsoutstanding_slope24))'');
    populated_mfgmat_monthsoutstanding_slope24_pcnt := AVE(GROUP,IF(h.mfgmat_monthsoutstanding_slope24 = (TYPEOF(h.mfgmat_monthsoutstanding_slope24))'',0,100));
    maxlength_mfgmat_monthsoutstanding_slope24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_monthsoutstanding_slope24)));
    avelength_mfgmat_monthsoutstanding_slope24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_monthsoutstanding_slope24)),h.mfgmat_monthsoutstanding_slope24<>(typeof(h.mfgmat_monthsoutstanding_slope24))'');
    populated_mfgmat_percprov30_slope_0t12_cnt := COUNT(GROUP,h.mfgmat_percprov30_slope_0t12 <> (TYPEOF(h.mfgmat_percprov30_slope_0t12))'');
    populated_mfgmat_percprov30_slope_0t12_pcnt := AVE(GROUP,IF(h.mfgmat_percprov30_slope_0t12 = (TYPEOF(h.mfgmat_percprov30_slope_0t12))'',0,100));
    maxlength_mfgmat_percprov30_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_percprov30_slope_0t12)));
    avelength_mfgmat_percprov30_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_percprov30_slope_0t12)),h.mfgmat_percprov30_slope_0t12<>(typeof(h.mfgmat_percprov30_slope_0t12))'');
    populated_mfgmat_percprov30_slope_6t12_cnt := COUNT(GROUP,h.mfgmat_percprov30_slope_6t12 <> (TYPEOF(h.mfgmat_percprov30_slope_6t12))'');
    populated_mfgmat_percprov30_slope_6t12_pcnt := AVE(GROUP,IF(h.mfgmat_percprov30_slope_6t12 = (TYPEOF(h.mfgmat_percprov30_slope_6t12))'',0,100));
    maxlength_mfgmat_percprov30_slope_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_percprov30_slope_6t12)));
    avelength_mfgmat_percprov30_slope_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_percprov30_slope_6t12)),h.mfgmat_percprov30_slope_6t12<>(typeof(h.mfgmat_percprov30_slope_6t12))'');
    populated_mfgmat_percprov60_slope_0t12_cnt := COUNT(GROUP,h.mfgmat_percprov60_slope_0t12 <> (TYPEOF(h.mfgmat_percprov60_slope_0t12))'');
    populated_mfgmat_percprov60_slope_0t12_pcnt := AVE(GROUP,IF(h.mfgmat_percprov60_slope_0t12 = (TYPEOF(h.mfgmat_percprov60_slope_0t12))'',0,100));
    maxlength_mfgmat_percprov60_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_percprov60_slope_0t12)));
    avelength_mfgmat_percprov60_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_percprov60_slope_0t12)),h.mfgmat_percprov60_slope_0t12<>(typeof(h.mfgmat_percprov60_slope_0t12))'');
    populated_mfgmat_percprov60_slope_6t12_cnt := COUNT(GROUP,h.mfgmat_percprov60_slope_6t12 <> (TYPEOF(h.mfgmat_percprov60_slope_6t12))'');
    populated_mfgmat_percprov60_slope_6t12_pcnt := AVE(GROUP,IF(h.mfgmat_percprov60_slope_6t12 = (TYPEOF(h.mfgmat_percprov60_slope_6t12))'',0,100));
    maxlength_mfgmat_percprov60_slope_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_percprov60_slope_6t12)));
    avelength_mfgmat_percprov60_slope_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_percprov60_slope_6t12)),h.mfgmat_percprov60_slope_6t12<>(typeof(h.mfgmat_percprov60_slope_6t12))'');
    populated_mfgmat_percprov90_slope_0t24_cnt := COUNT(GROUP,h.mfgmat_percprov90_slope_0t24 <> (TYPEOF(h.mfgmat_percprov90_slope_0t24))'');
    populated_mfgmat_percprov90_slope_0t24_pcnt := AVE(GROUP,IF(h.mfgmat_percprov90_slope_0t24 = (TYPEOF(h.mfgmat_percprov90_slope_0t24))'',0,100));
    maxlength_mfgmat_percprov90_slope_0t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_percprov90_slope_0t24)));
    avelength_mfgmat_percprov90_slope_0t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_percprov90_slope_0t24)),h.mfgmat_percprov90_slope_0t24<>(typeof(h.mfgmat_percprov90_slope_0t24))'');
    populated_mfgmat_percprov90_slope_0t6_cnt := COUNT(GROUP,h.mfgmat_percprov90_slope_0t6 <> (TYPEOF(h.mfgmat_percprov90_slope_0t6))'');
    populated_mfgmat_percprov90_slope_0t6_pcnt := AVE(GROUP,IF(h.mfgmat_percprov90_slope_0t6 = (TYPEOF(h.mfgmat_percprov90_slope_0t6))'',0,100));
    maxlength_mfgmat_percprov90_slope_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_percprov90_slope_0t6)));
    avelength_mfgmat_percprov90_slope_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_percprov90_slope_0t6)),h.mfgmat_percprov90_slope_0t6<>(typeof(h.mfgmat_percprov90_slope_0t6))'');
    populated_mfgmat_percprov90_slope_6t12_cnt := COUNT(GROUP,h.mfgmat_percprov90_slope_6t12 <> (TYPEOF(h.mfgmat_percprov90_slope_6t12))'');
    populated_mfgmat_percprov90_slope_6t12_pcnt := AVE(GROUP,IF(h.mfgmat_percprov90_slope_6t12 = (TYPEOF(h.mfgmat_percprov90_slope_6t12))'',0,100));
    maxlength_mfgmat_percprov90_slope_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_percprov90_slope_6t12)));
    avelength_mfgmat_percprov90_slope_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_percprov90_slope_6t12)),h.mfgmat_percprov90_slope_6t12<>(typeof(h.mfgmat_percprov90_slope_6t12))'');
    populated_mfgmat_percprovoutstanding_adjustedslope_0t12_cnt := COUNT(GROUP,h.mfgmat_percprovoutstanding_adjustedslope_0t12 <> (TYPEOF(h.mfgmat_percprovoutstanding_adjustedslope_0t12))'');
    populated_mfgmat_percprovoutstanding_adjustedslope_0t12_pcnt := AVE(GROUP,IF(h.mfgmat_percprovoutstanding_adjustedslope_0t12 = (TYPEOF(h.mfgmat_percprovoutstanding_adjustedslope_0t12))'',0,100));
    maxlength_mfgmat_percprovoutstanding_adjustedslope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_percprovoutstanding_adjustedslope_0t12)));
    avelength_mfgmat_percprovoutstanding_adjustedslope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfgmat_percprovoutstanding_adjustedslope_0t12)),h.mfgmat_percprovoutstanding_adjustedslope_0t12<>(typeof(h.mfgmat_percprovoutstanding_adjustedslope_0t12))'');
    populated_ops_monthsoutstanding_slope24_cnt := COUNT(GROUP,h.ops_monthsoutstanding_slope24 <> (TYPEOF(h.ops_monthsoutstanding_slope24))'');
    populated_ops_monthsoutstanding_slope24_pcnt := AVE(GROUP,IF(h.ops_monthsoutstanding_slope24 = (TYPEOF(h.ops_monthsoutstanding_slope24))'',0,100));
    maxlength_ops_monthsoutstanding_slope24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_monthsoutstanding_slope24)));
    avelength_ops_monthsoutstanding_slope24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_monthsoutstanding_slope24)),h.ops_monthsoutstanding_slope24<>(typeof(h.ops_monthsoutstanding_slope24))'');
    populated_ops_percprov30_slope_0t12_cnt := COUNT(GROUP,h.ops_percprov30_slope_0t12 <> (TYPEOF(h.ops_percprov30_slope_0t12))'');
    populated_ops_percprov30_slope_0t12_pcnt := AVE(GROUP,IF(h.ops_percprov30_slope_0t12 = (TYPEOF(h.ops_percprov30_slope_0t12))'',0,100));
    maxlength_ops_percprov30_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_percprov30_slope_0t12)));
    avelength_ops_percprov30_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_percprov30_slope_0t12)),h.ops_percprov30_slope_0t12<>(typeof(h.ops_percprov30_slope_0t12))'');
    populated_ops_percprov30_slope_6t12_cnt := COUNT(GROUP,h.ops_percprov30_slope_6t12 <> (TYPEOF(h.ops_percprov30_slope_6t12))'');
    populated_ops_percprov30_slope_6t12_pcnt := AVE(GROUP,IF(h.ops_percprov30_slope_6t12 = (TYPEOF(h.ops_percprov30_slope_6t12))'',0,100));
    maxlength_ops_percprov30_slope_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_percprov30_slope_6t12)));
    avelength_ops_percprov30_slope_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_percprov30_slope_6t12)),h.ops_percprov30_slope_6t12<>(typeof(h.ops_percprov30_slope_6t12))'');
    populated_ops_percprov60_slope_0t12_cnt := COUNT(GROUP,h.ops_percprov60_slope_0t12 <> (TYPEOF(h.ops_percprov60_slope_0t12))'');
    populated_ops_percprov60_slope_0t12_pcnt := AVE(GROUP,IF(h.ops_percprov60_slope_0t12 = (TYPEOF(h.ops_percprov60_slope_0t12))'',0,100));
    maxlength_ops_percprov60_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_percprov60_slope_0t12)));
    avelength_ops_percprov60_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_percprov60_slope_0t12)),h.ops_percprov60_slope_0t12<>(typeof(h.ops_percprov60_slope_0t12))'');
    populated_ops_percprov60_slope_6t12_cnt := COUNT(GROUP,h.ops_percprov60_slope_6t12 <> (TYPEOF(h.ops_percprov60_slope_6t12))'');
    populated_ops_percprov60_slope_6t12_pcnt := AVE(GROUP,IF(h.ops_percprov60_slope_6t12 = (TYPEOF(h.ops_percprov60_slope_6t12))'',0,100));
    maxlength_ops_percprov60_slope_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_percprov60_slope_6t12)));
    avelength_ops_percprov60_slope_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_percprov60_slope_6t12)),h.ops_percprov60_slope_6t12<>(typeof(h.ops_percprov60_slope_6t12))'');
    populated_ops_percprov90_slope_0t24_cnt := COUNT(GROUP,h.ops_percprov90_slope_0t24 <> (TYPEOF(h.ops_percprov90_slope_0t24))'');
    populated_ops_percprov90_slope_0t24_pcnt := AVE(GROUP,IF(h.ops_percprov90_slope_0t24 = (TYPEOF(h.ops_percprov90_slope_0t24))'',0,100));
    maxlength_ops_percprov90_slope_0t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_percprov90_slope_0t24)));
    avelength_ops_percprov90_slope_0t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_percprov90_slope_0t24)),h.ops_percprov90_slope_0t24<>(typeof(h.ops_percprov90_slope_0t24))'');
    populated_ops_percprov90_slope_0t6_cnt := COUNT(GROUP,h.ops_percprov90_slope_0t6 <> (TYPEOF(h.ops_percprov90_slope_0t6))'');
    populated_ops_percprov90_slope_0t6_pcnt := AVE(GROUP,IF(h.ops_percprov90_slope_0t6 = (TYPEOF(h.ops_percprov90_slope_0t6))'',0,100));
    maxlength_ops_percprov90_slope_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_percprov90_slope_0t6)));
    avelength_ops_percprov90_slope_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_percprov90_slope_0t6)),h.ops_percprov90_slope_0t6<>(typeof(h.ops_percprov90_slope_0t6))'');
    populated_ops_percprov90_slope_6t12_cnt := COUNT(GROUP,h.ops_percprov90_slope_6t12 <> (TYPEOF(h.ops_percprov90_slope_6t12))'');
    populated_ops_percprov90_slope_6t12_pcnt := AVE(GROUP,IF(h.ops_percprov90_slope_6t12 = (TYPEOF(h.ops_percprov90_slope_6t12))'',0,100));
    maxlength_ops_percprov90_slope_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_percprov90_slope_6t12)));
    avelength_ops_percprov90_slope_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_percprov90_slope_6t12)),h.ops_percprov90_slope_6t12<>(typeof(h.ops_percprov90_slope_6t12))'');
    populated_ops_percprovoutstanding_adjustedslope_0t12_cnt := COUNT(GROUP,h.ops_percprovoutstanding_adjustedslope_0t12 <> (TYPEOF(h.ops_percprovoutstanding_adjustedslope_0t12))'');
    populated_ops_percprovoutstanding_adjustedslope_0t12_pcnt := AVE(GROUP,IF(h.ops_percprovoutstanding_adjustedslope_0t12 = (TYPEOF(h.ops_percprovoutstanding_adjustedslope_0t12))'',0,100));
    maxlength_ops_percprovoutstanding_adjustedslope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_percprovoutstanding_adjustedslope_0t12)));
    avelength_ops_percprovoutstanding_adjustedslope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ops_percprovoutstanding_adjustedslope_0t12)),h.ops_percprovoutstanding_adjustedslope_0t12<>(typeof(h.ops_percprovoutstanding_adjustedslope_0t12))'');
    populated_fleet_monthsoutstanding_slope24_cnt := COUNT(GROUP,h.fleet_monthsoutstanding_slope24 <> (TYPEOF(h.fleet_monthsoutstanding_slope24))'');
    populated_fleet_monthsoutstanding_slope24_pcnt := AVE(GROUP,IF(h.fleet_monthsoutstanding_slope24 = (TYPEOF(h.fleet_monthsoutstanding_slope24))'',0,100));
    maxlength_fleet_monthsoutstanding_slope24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_monthsoutstanding_slope24)));
    avelength_fleet_monthsoutstanding_slope24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_monthsoutstanding_slope24)),h.fleet_monthsoutstanding_slope24<>(typeof(h.fleet_monthsoutstanding_slope24))'');
    populated_fleet_percprov30_slope_0t12_cnt := COUNT(GROUP,h.fleet_percprov30_slope_0t12 <> (TYPEOF(h.fleet_percprov30_slope_0t12))'');
    populated_fleet_percprov30_slope_0t12_pcnt := AVE(GROUP,IF(h.fleet_percprov30_slope_0t12 = (TYPEOF(h.fleet_percprov30_slope_0t12))'',0,100));
    maxlength_fleet_percprov30_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_percprov30_slope_0t12)));
    avelength_fleet_percprov30_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_percprov30_slope_0t12)),h.fleet_percprov30_slope_0t12<>(typeof(h.fleet_percprov30_slope_0t12))'');
    populated_fleet_percprov30_slope_6t12_cnt := COUNT(GROUP,h.fleet_percprov30_slope_6t12 <> (TYPEOF(h.fleet_percprov30_slope_6t12))'');
    populated_fleet_percprov30_slope_6t12_pcnt := AVE(GROUP,IF(h.fleet_percprov30_slope_6t12 = (TYPEOF(h.fleet_percprov30_slope_6t12))'',0,100));
    maxlength_fleet_percprov30_slope_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_percprov30_slope_6t12)));
    avelength_fleet_percprov30_slope_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_percprov30_slope_6t12)),h.fleet_percprov30_slope_6t12<>(typeof(h.fleet_percprov30_slope_6t12))'');
    populated_fleet_percprov60_slope_0t12_cnt := COUNT(GROUP,h.fleet_percprov60_slope_0t12 <> (TYPEOF(h.fleet_percprov60_slope_0t12))'');
    populated_fleet_percprov60_slope_0t12_pcnt := AVE(GROUP,IF(h.fleet_percprov60_slope_0t12 = (TYPEOF(h.fleet_percprov60_slope_0t12))'',0,100));
    maxlength_fleet_percprov60_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_percprov60_slope_0t12)));
    avelength_fleet_percprov60_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_percprov60_slope_0t12)),h.fleet_percprov60_slope_0t12<>(typeof(h.fleet_percprov60_slope_0t12))'');
    populated_fleet_percprov60_slope_6t12_cnt := COUNT(GROUP,h.fleet_percprov60_slope_6t12 <> (TYPEOF(h.fleet_percprov60_slope_6t12))'');
    populated_fleet_percprov60_slope_6t12_pcnt := AVE(GROUP,IF(h.fleet_percprov60_slope_6t12 = (TYPEOF(h.fleet_percprov60_slope_6t12))'',0,100));
    maxlength_fleet_percprov60_slope_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_percprov60_slope_6t12)));
    avelength_fleet_percprov60_slope_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_percprov60_slope_6t12)),h.fleet_percprov60_slope_6t12<>(typeof(h.fleet_percprov60_slope_6t12))'');
    populated_fleet_percprov90_slope_0t24_cnt := COUNT(GROUP,h.fleet_percprov90_slope_0t24 <> (TYPEOF(h.fleet_percprov90_slope_0t24))'');
    populated_fleet_percprov90_slope_0t24_pcnt := AVE(GROUP,IF(h.fleet_percprov90_slope_0t24 = (TYPEOF(h.fleet_percprov90_slope_0t24))'',0,100));
    maxlength_fleet_percprov90_slope_0t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_percprov90_slope_0t24)));
    avelength_fleet_percprov90_slope_0t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_percprov90_slope_0t24)),h.fleet_percprov90_slope_0t24<>(typeof(h.fleet_percprov90_slope_0t24))'');
    populated_fleet_percprov90_slope_0t6_cnt := COUNT(GROUP,h.fleet_percprov90_slope_0t6 <> (TYPEOF(h.fleet_percprov90_slope_0t6))'');
    populated_fleet_percprov90_slope_0t6_pcnt := AVE(GROUP,IF(h.fleet_percprov90_slope_0t6 = (TYPEOF(h.fleet_percprov90_slope_0t6))'',0,100));
    maxlength_fleet_percprov90_slope_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_percprov90_slope_0t6)));
    avelength_fleet_percprov90_slope_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_percprov90_slope_0t6)),h.fleet_percprov90_slope_0t6<>(typeof(h.fleet_percprov90_slope_0t6))'');
    populated_fleet_percprov90_slope_6t12_cnt := COUNT(GROUP,h.fleet_percprov90_slope_6t12 <> (TYPEOF(h.fleet_percprov90_slope_6t12))'');
    populated_fleet_percprov90_slope_6t12_pcnt := AVE(GROUP,IF(h.fleet_percprov90_slope_6t12 = (TYPEOF(h.fleet_percprov90_slope_6t12))'',0,100));
    maxlength_fleet_percprov90_slope_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_percprov90_slope_6t12)));
    avelength_fleet_percprov90_slope_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_percprov90_slope_6t12)),h.fleet_percprov90_slope_6t12<>(typeof(h.fleet_percprov90_slope_6t12))'');
    populated_fleet_percprovoutstanding_adjustedslope_0t12_cnt := COUNT(GROUP,h.fleet_percprovoutstanding_adjustedslope_0t12 <> (TYPEOF(h.fleet_percprovoutstanding_adjustedslope_0t12))'');
    populated_fleet_percprovoutstanding_adjustedslope_0t12_pcnt := AVE(GROUP,IF(h.fleet_percprovoutstanding_adjustedslope_0t12 = (TYPEOF(h.fleet_percprovoutstanding_adjustedslope_0t12))'',0,100));
    maxlength_fleet_percprovoutstanding_adjustedslope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_percprovoutstanding_adjustedslope_0t12)));
    avelength_fleet_percprovoutstanding_adjustedslope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fleet_percprovoutstanding_adjustedslope_0t12)),h.fleet_percprovoutstanding_adjustedslope_0t12<>(typeof(h.fleet_percprovoutstanding_adjustedslope_0t12))'');
    populated_carrier_monthsoutstanding_slope24_cnt := COUNT(GROUP,h.carrier_monthsoutstanding_slope24 <> (TYPEOF(h.carrier_monthsoutstanding_slope24))'');
    populated_carrier_monthsoutstanding_slope24_pcnt := AVE(GROUP,IF(h.carrier_monthsoutstanding_slope24 = (TYPEOF(h.carrier_monthsoutstanding_slope24))'',0,100));
    maxlength_carrier_monthsoutstanding_slope24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_monthsoutstanding_slope24)));
    avelength_carrier_monthsoutstanding_slope24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_monthsoutstanding_slope24)),h.carrier_monthsoutstanding_slope24<>(typeof(h.carrier_monthsoutstanding_slope24))'');
    populated_carrier_percprov30_slope_0t12_cnt := COUNT(GROUP,h.carrier_percprov30_slope_0t12 <> (TYPEOF(h.carrier_percprov30_slope_0t12))'');
    populated_carrier_percprov30_slope_0t12_pcnt := AVE(GROUP,IF(h.carrier_percprov30_slope_0t12 = (TYPEOF(h.carrier_percprov30_slope_0t12))'',0,100));
    maxlength_carrier_percprov30_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_percprov30_slope_0t12)));
    avelength_carrier_percprov30_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_percprov30_slope_0t12)),h.carrier_percprov30_slope_0t12<>(typeof(h.carrier_percprov30_slope_0t12))'');
    populated_carrier_percprov30_slope_6t12_cnt := COUNT(GROUP,h.carrier_percprov30_slope_6t12 <> (TYPEOF(h.carrier_percprov30_slope_6t12))'');
    populated_carrier_percprov30_slope_6t12_pcnt := AVE(GROUP,IF(h.carrier_percprov30_slope_6t12 = (TYPEOF(h.carrier_percprov30_slope_6t12))'',0,100));
    maxlength_carrier_percprov30_slope_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_percprov30_slope_6t12)));
    avelength_carrier_percprov30_slope_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_percprov30_slope_6t12)),h.carrier_percprov30_slope_6t12<>(typeof(h.carrier_percprov30_slope_6t12))'');
    populated_carrier_percprov60_slope_0t12_cnt := COUNT(GROUP,h.carrier_percprov60_slope_0t12 <> (TYPEOF(h.carrier_percprov60_slope_0t12))'');
    populated_carrier_percprov60_slope_0t12_pcnt := AVE(GROUP,IF(h.carrier_percprov60_slope_0t12 = (TYPEOF(h.carrier_percprov60_slope_0t12))'',0,100));
    maxlength_carrier_percprov60_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_percprov60_slope_0t12)));
    avelength_carrier_percprov60_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_percprov60_slope_0t12)),h.carrier_percprov60_slope_0t12<>(typeof(h.carrier_percprov60_slope_0t12))'');
    populated_carrier_percprov60_slope_6t12_cnt := COUNT(GROUP,h.carrier_percprov60_slope_6t12 <> (TYPEOF(h.carrier_percprov60_slope_6t12))'');
    populated_carrier_percprov60_slope_6t12_pcnt := AVE(GROUP,IF(h.carrier_percprov60_slope_6t12 = (TYPEOF(h.carrier_percprov60_slope_6t12))'',0,100));
    maxlength_carrier_percprov60_slope_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_percprov60_slope_6t12)));
    avelength_carrier_percprov60_slope_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_percprov60_slope_6t12)),h.carrier_percprov60_slope_6t12<>(typeof(h.carrier_percprov60_slope_6t12))'');
    populated_carrier_percprov90_slope_0t24_cnt := COUNT(GROUP,h.carrier_percprov90_slope_0t24 <> (TYPEOF(h.carrier_percprov90_slope_0t24))'');
    populated_carrier_percprov90_slope_0t24_pcnt := AVE(GROUP,IF(h.carrier_percprov90_slope_0t24 = (TYPEOF(h.carrier_percprov90_slope_0t24))'',0,100));
    maxlength_carrier_percprov90_slope_0t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_percprov90_slope_0t24)));
    avelength_carrier_percprov90_slope_0t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_percprov90_slope_0t24)),h.carrier_percprov90_slope_0t24<>(typeof(h.carrier_percprov90_slope_0t24))'');
    populated_carrier_percprov90_slope_0t6_cnt := COUNT(GROUP,h.carrier_percprov90_slope_0t6 <> (TYPEOF(h.carrier_percprov90_slope_0t6))'');
    populated_carrier_percprov90_slope_0t6_pcnt := AVE(GROUP,IF(h.carrier_percprov90_slope_0t6 = (TYPEOF(h.carrier_percprov90_slope_0t6))'',0,100));
    maxlength_carrier_percprov90_slope_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_percprov90_slope_0t6)));
    avelength_carrier_percprov90_slope_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_percprov90_slope_0t6)),h.carrier_percprov90_slope_0t6<>(typeof(h.carrier_percprov90_slope_0t6))'');
    populated_carrier_percprov90_slope_6t12_cnt := COUNT(GROUP,h.carrier_percprov90_slope_6t12 <> (TYPEOF(h.carrier_percprov90_slope_6t12))'');
    populated_carrier_percprov90_slope_6t12_pcnt := AVE(GROUP,IF(h.carrier_percprov90_slope_6t12 = (TYPEOF(h.carrier_percprov90_slope_6t12))'',0,100));
    maxlength_carrier_percprov90_slope_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_percprov90_slope_6t12)));
    avelength_carrier_percprov90_slope_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_percprov90_slope_6t12)),h.carrier_percprov90_slope_6t12<>(typeof(h.carrier_percprov90_slope_6t12))'');
    populated_carrier_percprovoutstanding_adjustedslope_0t12_cnt := COUNT(GROUP,h.carrier_percprovoutstanding_adjustedslope_0t12 <> (TYPEOF(h.carrier_percprovoutstanding_adjustedslope_0t12))'');
    populated_carrier_percprovoutstanding_adjustedslope_0t12_pcnt := AVE(GROUP,IF(h.carrier_percprovoutstanding_adjustedslope_0t12 = (TYPEOF(h.carrier_percprovoutstanding_adjustedslope_0t12))'',0,100));
    maxlength_carrier_percprovoutstanding_adjustedslope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_percprovoutstanding_adjustedslope_0t12)));
    avelength_carrier_percprovoutstanding_adjustedslope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_percprovoutstanding_adjustedslope_0t12)),h.carrier_percprovoutstanding_adjustedslope_0t12<>(typeof(h.carrier_percprovoutstanding_adjustedslope_0t12))'');
    populated_bldgmats_monthsoutstanding_slope24_cnt := COUNT(GROUP,h.bldgmats_monthsoutstanding_slope24 <> (TYPEOF(h.bldgmats_monthsoutstanding_slope24))'');
    populated_bldgmats_monthsoutstanding_slope24_pcnt := AVE(GROUP,IF(h.bldgmats_monthsoutstanding_slope24 = (TYPEOF(h.bldgmats_monthsoutstanding_slope24))'',0,100));
    maxlength_bldgmats_monthsoutstanding_slope24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_monthsoutstanding_slope24)));
    avelength_bldgmats_monthsoutstanding_slope24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_monthsoutstanding_slope24)),h.bldgmats_monthsoutstanding_slope24<>(typeof(h.bldgmats_monthsoutstanding_slope24))'');
    populated_bldgmats_percprov30_slope_0t12_cnt := COUNT(GROUP,h.bldgmats_percprov30_slope_0t12 <> (TYPEOF(h.bldgmats_percprov30_slope_0t12))'');
    populated_bldgmats_percprov30_slope_0t12_pcnt := AVE(GROUP,IF(h.bldgmats_percprov30_slope_0t12 = (TYPEOF(h.bldgmats_percprov30_slope_0t12))'',0,100));
    maxlength_bldgmats_percprov30_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_percprov30_slope_0t12)));
    avelength_bldgmats_percprov30_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_percprov30_slope_0t12)),h.bldgmats_percprov30_slope_0t12<>(typeof(h.bldgmats_percprov30_slope_0t12))'');
    populated_bldgmats_percprov30_slope_6t12_cnt := COUNT(GROUP,h.bldgmats_percprov30_slope_6t12 <> (TYPEOF(h.bldgmats_percprov30_slope_6t12))'');
    populated_bldgmats_percprov30_slope_6t12_pcnt := AVE(GROUP,IF(h.bldgmats_percprov30_slope_6t12 = (TYPEOF(h.bldgmats_percprov30_slope_6t12))'',0,100));
    maxlength_bldgmats_percprov30_slope_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_percprov30_slope_6t12)));
    avelength_bldgmats_percprov30_slope_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_percprov30_slope_6t12)),h.bldgmats_percprov30_slope_6t12<>(typeof(h.bldgmats_percprov30_slope_6t12))'');
    populated_bldgmats_percprov60_slope_0t12_cnt := COUNT(GROUP,h.bldgmats_percprov60_slope_0t12 <> (TYPEOF(h.bldgmats_percprov60_slope_0t12))'');
    populated_bldgmats_percprov60_slope_0t12_pcnt := AVE(GROUP,IF(h.bldgmats_percprov60_slope_0t12 = (TYPEOF(h.bldgmats_percprov60_slope_0t12))'',0,100));
    maxlength_bldgmats_percprov60_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_percprov60_slope_0t12)));
    avelength_bldgmats_percprov60_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_percprov60_slope_0t12)),h.bldgmats_percprov60_slope_0t12<>(typeof(h.bldgmats_percprov60_slope_0t12))'');
    populated_bldgmats_percprov60_slope_6t12_cnt := COUNT(GROUP,h.bldgmats_percprov60_slope_6t12 <> (TYPEOF(h.bldgmats_percprov60_slope_6t12))'');
    populated_bldgmats_percprov60_slope_6t12_pcnt := AVE(GROUP,IF(h.bldgmats_percprov60_slope_6t12 = (TYPEOF(h.bldgmats_percprov60_slope_6t12))'',0,100));
    maxlength_bldgmats_percprov60_slope_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_percprov60_slope_6t12)));
    avelength_bldgmats_percprov60_slope_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_percprov60_slope_6t12)),h.bldgmats_percprov60_slope_6t12<>(typeof(h.bldgmats_percprov60_slope_6t12))'');
    populated_bldgmats_percprov90_slope_0t24_cnt := COUNT(GROUP,h.bldgmats_percprov90_slope_0t24 <> (TYPEOF(h.bldgmats_percprov90_slope_0t24))'');
    populated_bldgmats_percprov90_slope_0t24_pcnt := AVE(GROUP,IF(h.bldgmats_percprov90_slope_0t24 = (TYPEOF(h.bldgmats_percprov90_slope_0t24))'',0,100));
    maxlength_bldgmats_percprov90_slope_0t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_percprov90_slope_0t24)));
    avelength_bldgmats_percprov90_slope_0t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_percprov90_slope_0t24)),h.bldgmats_percprov90_slope_0t24<>(typeof(h.bldgmats_percprov90_slope_0t24))'');
    populated_bldgmats_percprov90_slope_0t6_cnt := COUNT(GROUP,h.bldgmats_percprov90_slope_0t6 <> (TYPEOF(h.bldgmats_percprov90_slope_0t6))'');
    populated_bldgmats_percprov90_slope_0t6_pcnt := AVE(GROUP,IF(h.bldgmats_percprov90_slope_0t6 = (TYPEOF(h.bldgmats_percprov90_slope_0t6))'',0,100));
    maxlength_bldgmats_percprov90_slope_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_percprov90_slope_0t6)));
    avelength_bldgmats_percprov90_slope_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_percprov90_slope_0t6)),h.bldgmats_percprov90_slope_0t6<>(typeof(h.bldgmats_percprov90_slope_0t6))'');
    populated_bldgmats_percprov90_slope_6t12_cnt := COUNT(GROUP,h.bldgmats_percprov90_slope_6t12 <> (TYPEOF(h.bldgmats_percprov90_slope_6t12))'');
    populated_bldgmats_percprov90_slope_6t12_pcnt := AVE(GROUP,IF(h.bldgmats_percprov90_slope_6t12 = (TYPEOF(h.bldgmats_percprov90_slope_6t12))'',0,100));
    maxlength_bldgmats_percprov90_slope_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_percprov90_slope_6t12)));
    avelength_bldgmats_percprov90_slope_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_percprov90_slope_6t12)),h.bldgmats_percprov90_slope_6t12<>(typeof(h.bldgmats_percprov90_slope_6t12))'');
    populated_bldgmats_percprovoutstanding_adjustedslope_0t12_cnt := COUNT(GROUP,h.bldgmats_percprovoutstanding_adjustedslope_0t12 <> (TYPEOF(h.bldgmats_percprovoutstanding_adjustedslope_0t12))'');
    populated_bldgmats_percprovoutstanding_adjustedslope_0t12_pcnt := AVE(GROUP,IF(h.bldgmats_percprovoutstanding_adjustedslope_0t12 = (TYPEOF(h.bldgmats_percprovoutstanding_adjustedslope_0t12))'',0,100));
    maxlength_bldgmats_percprovoutstanding_adjustedslope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_percprovoutstanding_adjustedslope_0t12)));
    avelength_bldgmats_percprovoutstanding_adjustedslope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bldgmats_percprovoutstanding_adjustedslope_0t12)),h.bldgmats_percprovoutstanding_adjustedslope_0t12<>(typeof(h.bldgmats_percprovoutstanding_adjustedslope_0t12))'');
    populated_top5_monthsoutstanding_slope24_cnt := COUNT(GROUP,h.top5_monthsoutstanding_slope24 <> (TYPEOF(h.top5_monthsoutstanding_slope24))'');
    populated_top5_monthsoutstanding_slope24_pcnt := AVE(GROUP,IF(h.top5_monthsoutstanding_slope24 = (TYPEOF(h.top5_monthsoutstanding_slope24))'',0,100));
    maxlength_top5_monthsoutstanding_slope24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_monthsoutstanding_slope24)));
    avelength_top5_monthsoutstanding_slope24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_monthsoutstanding_slope24)),h.top5_monthsoutstanding_slope24<>(typeof(h.top5_monthsoutstanding_slope24))'');
    populated_top5_percprov30_slope_0t12_cnt := COUNT(GROUP,h.top5_percprov30_slope_0t12 <> (TYPEOF(h.top5_percprov30_slope_0t12))'');
    populated_top5_percprov30_slope_0t12_pcnt := AVE(GROUP,IF(h.top5_percprov30_slope_0t12 = (TYPEOF(h.top5_percprov30_slope_0t12))'',0,100));
    maxlength_top5_percprov30_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_percprov30_slope_0t12)));
    avelength_top5_percprov30_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_percprov30_slope_0t12)),h.top5_percprov30_slope_0t12<>(typeof(h.top5_percprov30_slope_0t12))'');
    populated_top5_percprov30_slope_6t12_cnt := COUNT(GROUP,h.top5_percprov30_slope_6t12 <> (TYPEOF(h.top5_percprov30_slope_6t12))'');
    populated_top5_percprov30_slope_6t12_pcnt := AVE(GROUP,IF(h.top5_percprov30_slope_6t12 = (TYPEOF(h.top5_percprov30_slope_6t12))'',0,100));
    maxlength_top5_percprov30_slope_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_percprov30_slope_6t12)));
    avelength_top5_percprov30_slope_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_percprov30_slope_6t12)),h.top5_percprov30_slope_6t12<>(typeof(h.top5_percprov30_slope_6t12))'');
    populated_top5_percprov60_slope_0t12_cnt := COUNT(GROUP,h.top5_percprov60_slope_0t12 <> (TYPEOF(h.top5_percprov60_slope_0t12))'');
    populated_top5_percprov60_slope_0t12_pcnt := AVE(GROUP,IF(h.top5_percprov60_slope_0t12 = (TYPEOF(h.top5_percprov60_slope_0t12))'',0,100));
    maxlength_top5_percprov60_slope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_percprov60_slope_0t12)));
    avelength_top5_percprov60_slope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_percprov60_slope_0t12)),h.top5_percprov60_slope_0t12<>(typeof(h.top5_percprov60_slope_0t12))'');
    populated_top5_percprov60_slope_6t12_cnt := COUNT(GROUP,h.top5_percprov60_slope_6t12 <> (TYPEOF(h.top5_percprov60_slope_6t12))'');
    populated_top5_percprov60_slope_6t12_pcnt := AVE(GROUP,IF(h.top5_percprov60_slope_6t12 = (TYPEOF(h.top5_percprov60_slope_6t12))'',0,100));
    maxlength_top5_percprov60_slope_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_percprov60_slope_6t12)));
    avelength_top5_percprov60_slope_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_percprov60_slope_6t12)),h.top5_percprov60_slope_6t12<>(typeof(h.top5_percprov60_slope_6t12))'');
    populated_top5_percprov90_slope_0t24_cnt := COUNT(GROUP,h.top5_percprov90_slope_0t24 <> (TYPEOF(h.top5_percprov90_slope_0t24))'');
    populated_top5_percprov90_slope_0t24_pcnt := AVE(GROUP,IF(h.top5_percprov90_slope_0t24 = (TYPEOF(h.top5_percprov90_slope_0t24))'',0,100));
    maxlength_top5_percprov90_slope_0t24 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_percprov90_slope_0t24)));
    avelength_top5_percprov90_slope_0t24 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_percprov90_slope_0t24)),h.top5_percprov90_slope_0t24<>(typeof(h.top5_percprov90_slope_0t24))'');
    populated_top5_percprov90_slope_0t6_cnt := COUNT(GROUP,h.top5_percprov90_slope_0t6 <> (TYPEOF(h.top5_percprov90_slope_0t6))'');
    populated_top5_percprov90_slope_0t6_pcnt := AVE(GROUP,IF(h.top5_percprov90_slope_0t6 = (TYPEOF(h.top5_percprov90_slope_0t6))'',0,100));
    maxlength_top5_percprov90_slope_0t6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_percprov90_slope_0t6)));
    avelength_top5_percprov90_slope_0t6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_percprov90_slope_0t6)),h.top5_percprov90_slope_0t6<>(typeof(h.top5_percprov90_slope_0t6))'');
    populated_top5_percprov90_slope_6t12_cnt := COUNT(GROUP,h.top5_percprov90_slope_6t12 <> (TYPEOF(h.top5_percprov90_slope_6t12))'');
    populated_top5_percprov90_slope_6t12_pcnt := AVE(GROUP,IF(h.top5_percprov90_slope_6t12 = (TYPEOF(h.top5_percprov90_slope_6t12))'',0,100));
    maxlength_top5_percprov90_slope_6t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_percprov90_slope_6t12)));
    avelength_top5_percprov90_slope_6t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_percprov90_slope_6t12)),h.top5_percprov90_slope_6t12<>(typeof(h.top5_percprov90_slope_6t12))'');
    populated_top5_percprovoutstanding_adjustedslope_0t12_cnt := COUNT(GROUP,h.top5_percprovoutstanding_adjustedslope_0t12 <> (TYPEOF(h.top5_percprovoutstanding_adjustedslope_0t12))'');
    populated_top5_percprovoutstanding_adjustedslope_0t12_pcnt := AVE(GROUP,IF(h.top5_percprovoutstanding_adjustedslope_0t12 = (TYPEOF(h.top5_percprovoutstanding_adjustedslope_0t12))'',0,100));
    maxlength_top5_percprovoutstanding_adjustedslope_0t12 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_percprovoutstanding_adjustedslope_0t12)));
    avelength_top5_percprovoutstanding_adjustedslope_0t12 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.top5_percprovoutstanding_adjustedslope_0t12)),h.top5_percprovoutstanding_adjustedslope_0t12<>(typeof(h.top5_percprovoutstanding_adjustedslope_0t12))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_ultimate_linkid_pcnt *   0.00 / 100 + T.Populated_cortera_score_pcnt *   0.00 / 100 + T.Populated_cpr_score_pcnt *   0.00 / 100 + T.Populated_cpr_segment_pcnt *   0.00 / 100 + T.Populated_dbt_pcnt *   0.00 / 100 + T.Populated_avg_bal_pcnt *   0.00 / 100 + T.Populated_air_spend_pcnt *   0.00 / 100 + T.Populated_fuel_spend_pcnt *   0.00 / 100 + T.Populated_leasing_spend_pcnt *   0.00 / 100 + T.Populated_ltl_spend_pcnt *   0.00 / 100 + T.Populated_rail_spend_pcnt *   0.00 / 100 + T.Populated_tl_spend_pcnt *   0.00 / 100 + T.Populated_transvc_spend_pcnt *   0.00 / 100 + T.Populated_transup_spend_pcnt *   0.00 / 100 + T.Populated_bst_spend_pcnt *   0.00 / 100 + T.Populated_dg_spend_pcnt *   0.00 / 100 + T.Populated_electrical_spend_pcnt *   0.00 / 100 + T.Populated_hvac_spend_pcnt *   0.00 / 100 + T.Populated_other_b_spend_pcnt *   0.00 / 100 + T.Populated_plumbing_spend_pcnt *   0.00 / 100 + T.Populated_rs_spend_pcnt *   0.00 / 100 + T.Populated_wp_spend_pcnt *   0.00 / 100 + T.Populated_chemical_spend_pcnt *   0.00 / 100 + T.Populated_electronic_spend_pcnt *   0.00 / 100 + T.Populated_metal_spend_pcnt *   0.00 / 100 + T.Populated_other_m_spend_pcnt *   0.00 / 100 + T.Populated_packaging_spend_pcnt *   0.00 / 100 + T.Populated_pvf_spend_pcnt *   0.00 / 100 + T.Populated_plastic_spend_pcnt *   0.00 / 100 + T.Populated_textile_spend_pcnt *   0.00 / 100 + T.Populated_bs_spend_pcnt *   0.00 / 100 + T.Populated_ce_spend_pcnt *   0.00 / 100 + T.Populated_hardware_spend_pcnt *   0.00 / 100 + T.Populated_ie_spend_pcnt *   0.00 / 100 + T.Populated_is_spend_pcnt *   0.00 / 100 + T.Populated_it_spend_pcnt *   0.00 / 100 + T.Populated_mls_spend_pcnt *   0.00 / 100 + T.Populated_os_spend_pcnt *   0.00 / 100 + T.Populated_pp_spend_pcnt *   0.00 / 100 + T.Populated_sis_spend_pcnt *   0.00 / 100 + T.Populated_apparel_spend_pcnt *   0.00 / 100 + T.Populated_beverages_spend_pcnt *   0.00 / 100 + T.Populated_constr_spend_pcnt *   0.00 / 100 + T.Populated_consulting_spend_pcnt *   0.00 / 100 + T.Populated_fs_spend_pcnt *   0.00 / 100 + T.Populated_fp_spend_pcnt *   0.00 / 100 + T.Populated_insurance_spend_pcnt *   0.00 / 100 + T.Populated_ls_spend_pcnt *   0.00 / 100 + T.Populated_oil_gas_spend_pcnt *   0.00 / 100 + T.Populated_utilities_spend_pcnt *   0.00 / 100 + T.Populated_other_spend_pcnt *   0.00 / 100 + T.Populated_advt_spend_pcnt *   0.00 / 100 + T.Populated_air_growth_pcnt *   0.00 / 100 + T.Populated_fuel_growth_pcnt *   0.00 / 100 + T.Populated_leasing_growth_pcnt *   0.00 / 100 + T.Populated_ltl_growth_pcnt *   0.00 / 100 + T.Populated_rail_growth_pcnt *   0.00 / 100 + T.Populated_tl_growth_pcnt *   0.00 / 100 + T.Populated_transvc_growth_pcnt *   0.00 / 100 + T.Populated_transup_growth_pcnt *   0.00 / 100 + T.Populated_bst_growth_pcnt *   0.00 / 100 + T.Populated_dg_growth_pcnt *   0.00 / 100 + T.Populated_electrical_growth_pcnt *   0.00 / 100 + T.Populated_hvac_growth_pcnt *   0.00 / 100 + T.Populated_other_b_growth_pcnt *   0.00 / 100 + T.Populated_plumbing_growth_pcnt *   0.00 / 100 + T.Populated_rs_growth_pcnt *   0.00 / 100 + T.Populated_wp_growth_pcnt *   0.00 / 100 + T.Populated_chemical_growth_pcnt *   0.00 / 100 + T.Populated_electronic_growth_pcnt *   0.00 / 100 + T.Populated_metal_growth_pcnt *   0.00 / 100 + T.Populated_other_m_growth_pcnt *   0.00 / 100 + T.Populated_packaging_growth_pcnt *   0.00 / 100 + T.Populated_pvf_growth_pcnt *   0.00 / 100 + T.Populated_plastic_growth_pcnt *   0.00 / 100 + T.Populated_textile_growth_pcnt *   0.00 / 100 + T.Populated_bs_growth_pcnt *   0.00 / 100 + T.Populated_ce_growth_pcnt *   0.00 / 100 + T.Populated_hardware_growth_pcnt *   0.00 / 100 + T.Populated_ie_growth_pcnt *   0.00 / 100 + T.Populated_is_growth_pcnt *   0.00 / 100 + T.Populated_it_growth_pcnt *   0.00 / 100 + T.Populated_mls_growth_pcnt *   0.00 / 100 + T.Populated_os_growth_pcnt *   0.00 / 100 + T.Populated_pp_growth_pcnt *   0.00 / 100 + T.Populated_sis_growth_pcnt *   0.00 / 100 + T.Populated_apparel_growth_pcnt *   0.00 / 100 + T.Populated_beverages_growth_pcnt *   0.00 / 100 + T.Populated_constr_growth_pcnt *   0.00 / 100 + T.Populated_consulting_growth_pcnt *   0.00 / 100 + T.Populated_fs_growth_pcnt *   0.00 / 100 + T.Populated_fp_growth_pcnt *   0.00 / 100 + T.Populated_insurance_growth_pcnt *   0.00 / 100 + T.Populated_ls_growth_pcnt *   0.00 / 100 + T.Populated_oil_gas_growth_pcnt *   0.00 / 100 + T.Populated_utilities_growth_pcnt *   0.00 / 100 + T.Populated_other_growth_pcnt *   0.00 / 100 + T.Populated_advt_growth_pcnt *   0.00 / 100 + T.Populated_top5_growth_pcnt *   0.00 / 100 + T.Populated_shipping_y1_pcnt *   0.00 / 100 + T.Populated_shipping_growth_pcnt *   0.00 / 100 + T.Populated_materials_y1_pcnt *   0.00 / 100 + T.Populated_materials_growth_pcnt *   0.00 / 100 + T.Populated_operations_y1_pcnt *   0.00 / 100 + T.Populated_operations_growth_pcnt *   0.00 / 100 + T.Populated_total_paid_average_0t12_pcnt *   0.00 / 100 + T.Populated_total_paid_monthspastworst_24_pcnt *   0.00 / 100 + T.Populated_total_paid_slope_0t12_pcnt *   0.00 / 100 + T.Populated_total_paid_slope_0t6_pcnt *   0.00 / 100 + T.Populated_total_paid_slope_6t12_pcnt *   0.00 / 100 + T.Populated_total_paid_slope_6t18_pcnt *   0.00 / 100 + T.Populated_total_paid_volatility_0t12_pcnt *   0.00 / 100 + T.Populated_total_paid_volatility_0t6_pcnt *   0.00 / 100 + T.Populated_total_paid_volatility_12t18_pcnt *   0.00 / 100 + T.Populated_total_paid_volatility_6t12_pcnt *   0.00 / 100 + T.Populated_total_spend_monthspastleast_24_pcnt *   0.00 / 100 + T.Populated_total_spend_monthspastmost_24_pcnt *   0.00 / 100 + T.Populated_total_spend_slope_0t12_pcnt *   0.00 / 100 + T.Populated_total_spend_slope_0t24_pcnt *   0.00 / 100 + T.Populated_total_spend_slope_0t6_pcnt *   0.00 / 100 + T.Populated_total_spend_slope_6t12_pcnt *   0.00 / 100 + T.Populated_total_spend_sum_12_pcnt *   0.00 / 100 + T.Populated_total_spend_volatility_0t12_pcnt *   0.00 / 100 + T.Populated_total_spend_volatility_0t6_pcnt *   0.00 / 100 + T.Populated_total_spend_volatility_12t18_pcnt *   0.00 / 100 + T.Populated_total_spend_volatility_6t12_pcnt *   0.00 / 100 + T.Populated_mfgmat_paid_average_12_pcnt *   0.00 / 100 + T.Populated_mfgmat_paid_monthspastworst_24_pcnt *   0.00 / 100 + T.Populated_mfgmat_paid_slope_0t12_pcnt *   0.00 / 100 + T.Populated_mfgmat_paid_slope_0t24_pcnt *   0.00 / 100 + T.Populated_mfgmat_paid_slope_0t6_pcnt *   0.00 / 100 + T.Populated_mfgmat_paid_volatility_0t12_pcnt *   0.00 / 100 + T.Populated_mfgmat_paid_volatility_0t6_pcnt *   0.00 / 100 + T.Populated_mfgmat_spend_monthspastleast_24_pcnt *   0.00 / 100 + T.Populated_mfgmat_spend_monthspastmost_24_pcnt *   0.00 / 100 + T.Populated_mfgmat_spend_slope_0t12_pcnt *   0.00 / 100 + T.Populated_mfgmat_spend_slope_0t24_pcnt *   0.00 / 100 + T.Populated_mfgmat_spend_slope_0t6_pcnt *   0.00 / 100 + T.Populated_mfgmat_spend_sum_12_pcnt *   0.00 / 100 + T.Populated_mfgmat_spend_volatility_0t6_pcnt *   0.00 / 100 + T.Populated_mfgmat_spend_volatility_6t12_pcnt *   0.00 / 100 + T.Populated_ops_paid_average_12_pcnt *   0.00 / 100 + T.Populated_ops_paid_monthspastworst_24_pcnt *   0.00 / 100 + T.Populated_ops_paid_slope_0t12_pcnt *   0.00 / 100 + T.Populated_ops_paid_slope_0t24_pcnt *   0.00 / 100 + T.Populated_ops_paid_slope_0t6_pcnt *   0.00 / 100 + T.Populated_ops_paid_volatility_0t12_pcnt *   0.00 / 100 + T.Populated_ops_paid_volatility_0t6_pcnt *   0.00 / 100 + T.Populated_ops_spend_monthspastleast_24_pcnt *   0.00 / 100 + T.Populated_ops_spend_monthspastmost_24_pcnt *   0.00 / 100 + T.Populated_ops_spend_slope_0t12_pcnt *   0.00 / 100 + T.Populated_ops_spend_slope_0t24_pcnt *   0.00 / 100 + T.Populated_ops_spend_slope_0t6_pcnt *   0.00 / 100 + T.Populated_ops_spend_sum_12_pcnt *   0.00 / 100 + T.Populated_ops_spend_volatility_0t6_pcnt *   0.00 / 100 + T.Populated_ops_spend_volatility_6t12_pcnt *   0.00 / 100 + T.Populated_fleet_paid_average_12_pcnt *   0.00 / 100 + T.Populated_fleet_paid_monthspastworst_24_pcnt *   0.00 / 100 + T.Populated_fleet_paid_slope_0t12_pcnt *   0.00 / 100 + T.Populated_fleet_paid_slope_0t24_pcnt *   0.00 / 100 + T.Populated_fleet_paid_slope_0t6_pcnt *   0.00 / 100 + T.Populated_fleet_paid_volatility_0t12_pcnt *   0.00 / 100 + T.Populated_fleet_paid_volatility_0t6_pcnt *   0.00 / 100 + T.Populated_fleet_spend_monthspastleast_24_pcnt *   0.00 / 100 + T.Populated_fleet_spend_monthspastmost_24_pcnt *   0.00 / 100 + T.Populated_fleet_spend_slope_0t12_pcnt *   0.00 / 100 + T.Populated_fleet_spend_slope_0t24_pcnt *   0.00 / 100 + T.Populated_fleet_spend_slope_0t6_pcnt *   0.00 / 100 + T.Populated_fleet_spend_sum_12_pcnt *   0.00 / 100 + T.Populated_fleet_spend_volatility_0t6_pcnt *   0.00 / 100 + T.Populated_fleet_spend_volatility_6t12_pcnt *   0.00 / 100 + T.Populated_carrier_paid_average_12_pcnt *   0.00 / 100 + T.Populated_carrier_paid_monthspastworst_24_pcnt *   0.00 / 100 + T.Populated_carrier_paid_slope_0t12_pcnt *   0.00 / 100 + T.Populated_carrier_paid_slope_0t24_pcnt *   0.00 / 100 + T.Populated_carrier_paid_slope_0t6_pcnt *   0.00 / 100 + T.Populated_carrier_paid_volatility_0t12_pcnt *   0.00 / 100 + T.Populated_carrier_paid_volatility_0t6_pcnt *   0.00 / 100 + T.Populated_carrier_spend_monthspastleast_24_pcnt *   0.00 / 100 + T.Populated_carrier_spend_monthspastmost_24_pcnt *   0.00 / 100 + T.Populated_carrier_spend_slope_0t12_pcnt *   0.00 / 100 + T.Populated_carrier_spend_slope_0t24_pcnt *   0.00 / 100 + T.Populated_carrier_spend_slope_0t6_pcnt *   0.00 / 100 + T.Populated_carrier_spend_sum_12_pcnt *   0.00 / 100 + T.Populated_carrier_spend_volatility_0t6_pcnt *   0.00 / 100 + T.Populated_carrier_spend_volatility_6t12_pcnt *   0.00 / 100 + T.Populated_bldgmats_paid_average_12_pcnt *   0.00 / 100 + T.Populated_bldgmats_paid_monthspastworst_24_pcnt *   0.00 / 100 + T.Populated_bldgmats_paid_slope_0t12_pcnt *   0.00 / 100 + T.Populated_bldgmats_paid_slope_0t24_pcnt *   0.00 / 100 + T.Populated_bldgmats_paid_slope_0t6_pcnt *   0.00 / 100 + T.Populated_bldgmats_paid_volatility_0t12_pcnt *   0.00 / 100 + T.Populated_bldgmats_paid_volatility_0t6_pcnt *   0.00 / 100 + T.Populated_bldgmats_spend_monthspastleast_24_pcnt *   0.00 / 100 + T.Populated_bldgmats_spend_monthspastmost_24_pcnt *   0.00 / 100 + T.Populated_bldgmats_spend_slope_0t12_pcnt *   0.00 / 100 + T.Populated_bldgmats_spend_slope_0t24_pcnt *   0.00 / 100 + T.Populated_bldgmats_spend_slope_0t6_pcnt *   0.00 / 100 + T.Populated_bldgmats_spend_sum_12_pcnt *   0.00 / 100 + T.Populated_bldgmats_spend_volatility_0t6_pcnt *   0.00 / 100 + T.Populated_bldgmats_spend_volatility_6t12_pcnt *   0.00 / 100 + T.Populated_top5_paid_average_12_pcnt *   0.00 / 100 + T.Populated_top5_paid_monthspastworst_24_pcnt *   0.00 / 100 + T.Populated_top5_paid_slope_0t12_pcnt *   0.00 / 100 + T.Populated_top5_paid_slope_0t24_pcnt *   0.00 / 100 + T.Populated_top5_paid_slope_0t6_pcnt *   0.00 / 100 + T.Populated_top5_paid_volatility_0t12_pcnt *   0.00 / 100 + T.Populated_top5_paid_volatility_0t6_pcnt *   0.00 / 100 + T.Populated_top5_spend_monthspastleast_24_pcnt *   0.00 / 100 + T.Populated_top5_spend_monthspastmost_24_pcnt *   0.00 / 100 + T.Populated_top5_spend_slope_0t12_pcnt *   0.00 / 100 + T.Populated_top5_spend_slope_0t24_pcnt *   0.00 / 100 + T.Populated_top5_spend_slope_0t6_pcnt *   0.00 / 100 + T.Populated_top5_spend_sum_12_pcnt *   0.00 / 100 + T.Populated_top5_spend_volatility_0t6_pcnt *   0.00 / 100 + T.Populated_top5_spend_volatility_6t12_pcnt *   0.00 / 100 + T.Populated_total_numrel_avg12_pcnt *   0.00 / 100 + T.Populated_total_numrel_monthpspastmost_24_pcnt *   0.00 / 100 + T.Populated_total_numrel_monthspastleast_24_pcnt *   0.00 / 100 + T.Populated_total_numrel_slope_0t12_pcnt *   0.00 / 100 + T.Populated_total_numrel_slope_0t24_pcnt *   0.00 / 100 + T.Populated_total_numrel_slope_0t6_pcnt *   0.00 / 100 + T.Populated_total_numrel_slope_6t12_pcnt *   0.00 / 100 + T.Populated_total_numrel_var_0t12_pcnt *   0.00 / 100 + T.Populated_total_numrel_var_0t24_pcnt *   0.00 / 100 + T.Populated_total_numrel_var_12t24_pcnt *   0.00 / 100 + T.Populated_total_numrel_var_6t18_pcnt *   0.00 / 100 + T.Populated_mfgmat_numrel_avg12_pcnt *   0.00 / 100 + T.Populated_mfgmat_numrel_slope_0t12_pcnt *   0.00 / 100 + T.Populated_mfgmat_numrel_slope_0t24_pcnt *   0.00 / 100 + T.Populated_mfgmat_numrel_slope_0t6_pcnt *   0.00 / 100 + T.Populated_mfgmat_numrel_slope_6t12_pcnt *   0.00 / 100 + T.Populated_mfgmat_numrel_var_0t12_pcnt *   0.00 / 100 + T.Populated_mfgmat_numrel_var_12t24_pcnt *   0.00 / 100 + T.Populated_ops_numrel_avg12_pcnt *   0.00 / 100 + T.Populated_ops_numrel_slope_0t12_pcnt *   0.00 / 100 + T.Populated_ops_numrel_slope_0t24_pcnt *   0.00 / 100 + T.Populated_ops_numrel_slope_0t6_pcnt *   0.00 / 100 + T.Populated_ops_numrel_slope_6t12_pcnt *   0.00 / 100 + T.Populated_ops_numrel_var_0t12_pcnt *   0.00 / 100 + T.Populated_ops_numrel_var_12t24_pcnt *   0.00 / 100 + T.Populated_fleet_numrel_avg12_pcnt *   0.00 / 100 + T.Populated_fleet_numrel_slope_0t12_pcnt *   0.00 / 100 + T.Populated_fleet_numrel_slope_0t24_pcnt *   0.00 / 100 + T.Populated_fleet_numrel_slope_0t6_pcnt *   0.00 / 100 + T.Populated_fleet_numrel_slope_6t12_pcnt *   0.00 / 100 + T.Populated_fleet_numrel_var_0t12_pcnt *   0.00 / 100 + T.Populated_fleet_numrel_var_12t24_pcnt *   0.00 / 100 + T.Populated_carrier_numrel_avg12_pcnt *   0.00 / 100 + T.Populated_carrier_numrel_slope_0t12_pcnt *   0.00 / 100 + T.Populated_carrier_numrel_slope_0t24_pcnt *   0.00 / 100 + T.Populated_carrier_numrel_slope_0t6_pcnt *   0.00 / 100 + T.Populated_carrier_numrel_slope_6t12_pcnt *   0.00 / 100 + T.Populated_carrier_numrel_var_0t12_pcnt *   0.00 / 100 + T.Populated_carrier_numrel_var_12t24_pcnt *   0.00 / 100 + T.Populated_bldgmats_numrel_avg12_pcnt *   0.00 / 100 + T.Populated_bldgmats_numrel_slope_0t12_pcnt *   0.00 / 100 + T.Populated_bldgmats_numrel_slope_0t24_pcnt *   0.00 / 100 + T.Populated_bldgmats_numrel_slope_0t6_pcnt *   0.00 / 100 + T.Populated_bldgmats_numrel_slope_6t12_pcnt *   0.00 / 100 + T.Populated_bldgmats_numrel_var_0t12_pcnt *   0.00 / 100 + T.Populated_bldgmats_numrel_var_12t24_pcnt *   0.00 / 100 + T.Populated_total_monthsoutstanding_slope24_pcnt *   0.00 / 100 + T.Populated_total_percprov30_avg_0t12_pcnt *   0.00 / 100 + T.Populated_total_percprov30_slope_0t12_pcnt *   0.00 / 100 + T.Populated_total_percprov30_slope_0t24_pcnt *   0.00 / 100 + T.Populated_total_percprov30_slope_0t6_pcnt *   0.00 / 100 + T.Populated_total_percprov30_slope_6t12_pcnt *   0.00 / 100 + T.Populated_total_percprov60_avg_0t12_pcnt *   0.00 / 100 + T.Populated_total_percprov60_slope_0t12_pcnt *   0.00 / 100 + T.Populated_total_percprov60_slope_0t24_pcnt *   0.00 / 100 + T.Populated_total_percprov60_slope_0t6_pcnt *   0.00 / 100 + T.Populated_total_percprov60_slope_6t12_pcnt *   0.00 / 100 + T.Populated_total_percprov90_avg_0t12_pcnt *   0.00 / 100 + T.Populated_total_percprov90_lowerlim_0t12_pcnt *   0.00 / 100 + T.Populated_total_percprov90_slope_0t24_pcnt *   0.00 / 100 + T.Populated_total_percprov90_slope_0t6_pcnt *   0.00 / 100 + T.Populated_total_percprov90_slope_6t12_pcnt *   0.00 / 100 + T.Populated_total_percprovoutstanding_adjustedslope_0t12_pcnt *   0.00 / 100 + T.Populated_mfgmat_monthsoutstanding_slope24_pcnt *   0.00 / 100 + T.Populated_mfgmat_percprov30_slope_0t12_pcnt *   0.00 / 100 + T.Populated_mfgmat_percprov30_slope_6t12_pcnt *   0.00 / 100 + T.Populated_mfgmat_percprov60_slope_0t12_pcnt *   0.00 / 100 + T.Populated_mfgmat_percprov60_slope_6t12_pcnt *   0.00 / 100 + T.Populated_mfgmat_percprov90_slope_0t24_pcnt *   0.00 / 100 + T.Populated_mfgmat_percprov90_slope_0t6_pcnt *   0.00 / 100 + T.Populated_mfgmat_percprov90_slope_6t12_pcnt *   0.00 / 100 + T.Populated_mfgmat_percprovoutstanding_adjustedslope_0t12_pcnt *   0.00 / 100 + T.Populated_ops_monthsoutstanding_slope24_pcnt *   0.00 / 100 + T.Populated_ops_percprov30_slope_0t12_pcnt *   0.00 / 100 + T.Populated_ops_percprov30_slope_6t12_pcnt *   0.00 / 100 + T.Populated_ops_percprov60_slope_0t12_pcnt *   0.00 / 100 + T.Populated_ops_percprov60_slope_6t12_pcnt *   0.00 / 100 + T.Populated_ops_percprov90_slope_0t24_pcnt *   0.00 / 100 + T.Populated_ops_percprov90_slope_0t6_pcnt *   0.00 / 100 + T.Populated_ops_percprov90_slope_6t12_pcnt *   0.00 / 100 + T.Populated_ops_percprovoutstanding_adjustedslope_0t12_pcnt *   0.00 / 100 + T.Populated_fleet_monthsoutstanding_slope24_pcnt *   0.00 / 100 + T.Populated_fleet_percprov30_slope_0t12_pcnt *   0.00 / 100 + T.Populated_fleet_percprov30_slope_6t12_pcnt *   0.00 / 100 + T.Populated_fleet_percprov60_slope_0t12_pcnt *   0.00 / 100 + T.Populated_fleet_percprov60_slope_6t12_pcnt *   0.00 / 100 + T.Populated_fleet_percprov90_slope_0t24_pcnt *   0.00 / 100 + T.Populated_fleet_percprov90_slope_0t6_pcnt *   0.00 / 100 + T.Populated_fleet_percprov90_slope_6t12_pcnt *   0.00 / 100 + T.Populated_fleet_percprovoutstanding_adjustedslope_0t12_pcnt *   0.00 / 100 + T.Populated_carrier_monthsoutstanding_slope24_pcnt *   0.00 / 100 + T.Populated_carrier_percprov30_slope_0t12_pcnt *   0.00 / 100 + T.Populated_carrier_percprov30_slope_6t12_pcnt *   0.00 / 100 + T.Populated_carrier_percprov60_slope_0t12_pcnt *   0.00 / 100 + T.Populated_carrier_percprov60_slope_6t12_pcnt *   0.00 / 100 + T.Populated_carrier_percprov90_slope_0t24_pcnt *   0.00 / 100 + T.Populated_carrier_percprov90_slope_0t6_pcnt *   0.00 / 100 + T.Populated_carrier_percprov90_slope_6t12_pcnt *   0.00 / 100 + T.Populated_carrier_percprovoutstanding_adjustedslope_0t12_pcnt *   0.00 / 100 + T.Populated_bldgmats_monthsoutstanding_slope24_pcnt *   0.00 / 100 + T.Populated_bldgmats_percprov30_slope_0t12_pcnt *   0.00 / 100 + T.Populated_bldgmats_percprov30_slope_6t12_pcnt *   0.00 / 100 + T.Populated_bldgmats_percprov60_slope_0t12_pcnt *   0.00 / 100 + T.Populated_bldgmats_percprov60_slope_6t12_pcnt *   0.00 / 100 + T.Populated_bldgmats_percprov90_slope_0t24_pcnt *   0.00 / 100 + T.Populated_bldgmats_percprov90_slope_0t6_pcnt *   0.00 / 100 + T.Populated_bldgmats_percprov90_slope_6t12_pcnt *   0.00 / 100 + T.Populated_bldgmats_percprovoutstanding_adjustedslope_0t12_pcnt *   0.00 / 100 + T.Populated_top5_monthsoutstanding_slope24_pcnt *   0.00 / 100 + T.Populated_top5_percprov30_slope_0t12_pcnt *   0.00 / 100 + T.Populated_top5_percprov30_slope_6t12_pcnt *   0.00 / 100 + T.Populated_top5_percprov60_slope_0t12_pcnt *   0.00 / 100 + T.Populated_top5_percprov60_slope_6t12_pcnt *   0.00 / 100 + T.Populated_top5_percprov90_slope_0t24_pcnt *   0.00 / 100 + T.Populated_top5_percprov90_slope_0t6_pcnt *   0.00 / 100 + T.Populated_top5_percprov90_slope_6t12_pcnt *   0.00 / 100 + T.Populated_top5_percprovoutstanding_adjustedslope_0t12_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT311.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'ultimate_linkid','cortera_score','cpr_score','cpr_segment','dbt','avg_bal','air_spend','fuel_spend','leasing_spend','ltl_spend','rail_spend','tl_spend','transvc_spend','transup_spend','bst_spend','dg_spend','electrical_spend','hvac_spend','other_b_spend','plumbing_spend','rs_spend','wp_spend','chemical_spend','electronic_spend','metal_spend','other_m_spend','packaging_spend','pvf_spend','plastic_spend','textile_spend','bs_spend','ce_spend','hardware_spend','ie_spend','is_spend','it_spend','mls_spend','os_spend','pp_spend','sis_spend','apparel_spend','beverages_spend','constr_spend','consulting_spend','fs_spend','fp_spend','insurance_spend','ls_spend','oil_gas_spend','utilities_spend','other_spend','advt_spend','air_growth','fuel_growth','leasing_growth','ltl_growth','rail_growth','tl_growth','transvc_growth','transup_growth','bst_growth','dg_growth','electrical_growth','hvac_growth','other_b_growth','plumbing_growth','rs_growth','wp_growth','chemical_growth','electronic_growth','metal_growth','other_m_growth','packaging_growth','pvf_growth','plastic_growth','textile_growth','bs_growth','ce_growth','hardware_growth','ie_growth','is_growth','it_growth','mls_growth','os_growth','pp_growth','sis_growth','apparel_growth','beverages_growth','constr_growth','consulting_growth','fs_growth','fp_growth','insurance_growth','ls_growth','oil_gas_growth','utilities_growth','other_growth','advt_growth','top5_growth','shipping_y1','shipping_growth','materials_y1','materials_growth','operations_y1','operations_growth','total_paid_average_0t12','total_paid_monthspastworst_24','total_paid_slope_0t12','total_paid_slope_0t6','total_paid_slope_6t12','total_paid_slope_6t18','total_paid_volatility_0t12','total_paid_volatility_0t6','total_paid_volatility_12t18','total_paid_volatility_6t12','total_spend_monthspastleast_24','total_spend_monthspastmost_24','total_spend_slope_0t12','total_spend_slope_0t24','total_spend_slope_0t6','total_spend_slope_6t12','total_spend_sum_12','total_spend_volatility_0t12','total_spend_volatility_0t6','total_spend_volatility_12t18','total_spend_volatility_6t12','mfgmat_paid_average_12','mfgmat_paid_monthspastworst_24','mfgmat_paid_slope_0t12','mfgmat_paid_slope_0t24','mfgmat_paid_slope_0t6','mfgmat_paid_volatility_0t12','mfgmat_paid_volatility_0t6','mfgmat_spend_monthspastleast_24','mfgmat_spend_monthspastmost_24','mfgmat_spend_slope_0t12','mfgmat_spend_slope_0t24','mfgmat_spend_slope_0t6','mfgmat_spend_sum_12','mfgmat_spend_volatility_0t6','mfgmat_spend_volatility_6t12','ops_paid_average_12','ops_paid_monthspastworst_24','ops_paid_slope_0t12','ops_paid_slope_0t24','ops_paid_slope_0t6','ops_paid_volatility_0t12','ops_paid_volatility_0t6','ops_spend_monthspastleast_24','ops_spend_monthspastmost_24','ops_spend_slope_0t12','ops_spend_slope_0t24','ops_spend_slope_0t6','ops_spend_sum_12','ops_spend_volatility_0t6','ops_spend_volatility_6t12','fleet_paid_average_12','fleet_paid_monthspastworst_24','fleet_paid_slope_0t12','fleet_paid_slope_0t24','fleet_paid_slope_0t6','fleet_paid_volatility_0t12','fleet_paid_volatility_0t6','fleet_spend_monthspastleast_24','fleet_spend_monthspastmost_24','fleet_spend_slope_0t12','fleet_spend_slope_0t24','fleet_spend_slope_0t6','fleet_spend_sum_12','fleet_spend_volatility_0t6','fleet_spend_volatility_6t12','carrier_paid_average_12','carrier_paid_monthspastworst_24','carrier_paid_slope_0t12','carrier_paid_slope_0t24','carrier_paid_slope_0t6','carrier_paid_volatility_0t12','carrier_paid_volatility_0t6','carrier_spend_monthspastleast_24','carrier_spend_monthspastmost_24','carrier_spend_slope_0t12','carrier_spend_slope_0t24','carrier_spend_slope_0t6','carrier_spend_sum_12','carrier_spend_volatility_0t6','carrier_spend_volatility_6t12','bldgmats_paid_average_12','bldgmats_paid_monthspastworst_24','bldgmats_paid_slope_0t12','bldgmats_paid_slope_0t24','bldgmats_paid_slope_0t6','bldgmats_paid_volatility_0t12','bldgmats_paid_volatility_0t6','bldgmats_spend_monthspastleast_24','bldgmats_spend_monthspastmost_24','bldgmats_spend_slope_0t12','bldgmats_spend_slope_0t24','bldgmats_spend_slope_0t6','bldgmats_spend_sum_12','bldgmats_spend_volatility_0t6','bldgmats_spend_volatility_6t12','top5_paid_average_12','top5_paid_monthspastworst_24','top5_paid_slope_0t12','top5_paid_slope_0t24','top5_paid_slope_0t6','top5_paid_volatility_0t12','top5_paid_volatility_0t6','top5_spend_monthspastleast_24','top5_spend_monthspastmost_24','top5_spend_slope_0t12','top5_spend_slope_0t24','top5_spend_slope_0t6','top5_spend_sum_12','top5_spend_volatility_0t6','top5_spend_volatility_6t12','total_numrel_avg12','total_numrel_monthpspastmost_24','total_numrel_monthspastleast_24','total_numrel_slope_0t12','total_numrel_slope_0t24','total_numrel_slope_0t6','total_numrel_slope_6t12','total_numrel_var_0t12','total_numrel_var_0t24','total_numrel_var_12t24','total_numrel_var_6t18','mfgmat_numrel_avg12','mfgmat_numrel_slope_0t12','mfgmat_numrel_slope_0t24','mfgmat_numrel_slope_0t6','mfgmat_numrel_slope_6t12','mfgmat_numrel_var_0t12','mfgmat_numrel_var_12t24','ops_numrel_avg12','ops_numrel_slope_0t12','ops_numrel_slope_0t24','ops_numrel_slope_0t6','ops_numrel_slope_6t12','ops_numrel_var_0t12','ops_numrel_var_12t24','fleet_numrel_avg12','fleet_numrel_slope_0t12','fleet_numrel_slope_0t24','fleet_numrel_slope_0t6','fleet_numrel_slope_6t12','fleet_numrel_var_0t12','fleet_numrel_var_12t24','carrier_numrel_avg12','carrier_numrel_slope_0t12','carrier_numrel_slope_0t24','carrier_numrel_slope_0t6','carrier_numrel_slope_6t12','carrier_numrel_var_0t12','carrier_numrel_var_12t24','bldgmats_numrel_avg12','bldgmats_numrel_slope_0t12','bldgmats_numrel_slope_0t24','bldgmats_numrel_slope_0t6','bldgmats_numrel_slope_6t12','bldgmats_numrel_var_0t12','bldgmats_numrel_var_12t24','total_monthsoutstanding_slope24','total_percprov30_avg_0t12','total_percprov30_slope_0t12','total_percprov30_slope_0t24','total_percprov30_slope_0t6','total_percprov30_slope_6t12','total_percprov60_avg_0t12','total_percprov60_slope_0t12','total_percprov60_slope_0t24','total_percprov60_slope_0t6','total_percprov60_slope_6t12','total_percprov90_avg_0t12','total_percprov90_lowerlim_0t12','total_percprov90_slope_0t24','total_percprov90_slope_0t6','total_percprov90_slope_6t12','total_percprovoutstanding_adjustedslope_0t12','mfgmat_monthsoutstanding_slope24','mfgmat_percprov30_slope_0t12','mfgmat_percprov30_slope_6t12','mfgmat_percprov60_slope_0t12','mfgmat_percprov60_slope_6t12','mfgmat_percprov90_slope_0t24','mfgmat_percprov90_slope_0t6','mfgmat_percprov90_slope_6t12','mfgmat_percprovoutstanding_adjustedslope_0t12','ops_monthsoutstanding_slope24','ops_percprov30_slope_0t12','ops_percprov30_slope_6t12','ops_percprov60_slope_0t12','ops_percprov60_slope_6t12','ops_percprov90_slope_0t24','ops_percprov90_slope_0t6','ops_percprov90_slope_6t12','ops_percprovoutstanding_adjustedslope_0t12','fleet_monthsoutstanding_slope24','fleet_percprov30_slope_0t12','fleet_percprov30_slope_6t12','fleet_percprov60_slope_0t12','fleet_percprov60_slope_6t12','fleet_percprov90_slope_0t24','fleet_percprov90_slope_0t6','fleet_percprov90_slope_6t12','fleet_percprovoutstanding_adjustedslope_0t12','carrier_monthsoutstanding_slope24','carrier_percprov30_slope_0t12','carrier_percprov30_slope_6t12','carrier_percprov60_slope_0t12','carrier_percprov60_slope_6t12','carrier_percprov90_slope_0t24','carrier_percprov90_slope_0t6','carrier_percprov90_slope_6t12','carrier_percprovoutstanding_adjustedslope_0t12','bldgmats_monthsoutstanding_slope24','bldgmats_percprov30_slope_0t12','bldgmats_percprov30_slope_6t12','bldgmats_percprov60_slope_0t12','bldgmats_percprov60_slope_6t12','bldgmats_percprov90_slope_0t24','bldgmats_percprov90_slope_0t6','bldgmats_percprov90_slope_6t12','bldgmats_percprovoutstanding_adjustedslope_0t12','top5_monthsoutstanding_slope24','top5_percprov30_slope_0t12','top5_percprov30_slope_6t12','top5_percprov60_slope_0t12','top5_percprov60_slope_6t12','top5_percprov90_slope_0t24','top5_percprov90_slope_0t6','top5_percprov90_slope_6t12','top5_percprovoutstanding_adjustedslope_0t12');
  SELF.populated_pcnt := CHOOSE(C,le.populated_ultimate_linkid_pcnt,le.populated_cortera_score_pcnt,le.populated_cpr_score_pcnt,le.populated_cpr_segment_pcnt,le.populated_dbt_pcnt,le.populated_avg_bal_pcnt,le.populated_air_spend_pcnt,le.populated_fuel_spend_pcnt,le.populated_leasing_spend_pcnt,le.populated_ltl_spend_pcnt,le.populated_rail_spend_pcnt,le.populated_tl_spend_pcnt,le.populated_transvc_spend_pcnt,le.populated_transup_spend_pcnt,le.populated_bst_spend_pcnt,le.populated_dg_spend_pcnt,le.populated_electrical_spend_pcnt,le.populated_hvac_spend_pcnt,le.populated_other_b_spend_pcnt,le.populated_plumbing_spend_pcnt,le.populated_rs_spend_pcnt,le.populated_wp_spend_pcnt,le.populated_chemical_spend_pcnt,le.populated_electronic_spend_pcnt,le.populated_metal_spend_pcnt,le.populated_other_m_spend_pcnt,le.populated_packaging_spend_pcnt,le.populated_pvf_spend_pcnt,le.populated_plastic_spend_pcnt,le.populated_textile_spend_pcnt,le.populated_bs_spend_pcnt,le.populated_ce_spend_pcnt,le.populated_hardware_spend_pcnt,le.populated_ie_spend_pcnt,le.populated_is_spend_pcnt,le.populated_it_spend_pcnt,le.populated_mls_spend_pcnt,le.populated_os_spend_pcnt,le.populated_pp_spend_pcnt,le.populated_sis_spend_pcnt,le.populated_apparel_spend_pcnt,le.populated_beverages_spend_pcnt,le.populated_constr_spend_pcnt,le.populated_consulting_spend_pcnt,le.populated_fs_spend_pcnt,le.populated_fp_spend_pcnt,le.populated_insurance_spend_pcnt,le.populated_ls_spend_pcnt,le.populated_oil_gas_spend_pcnt,le.populated_utilities_spend_pcnt,le.populated_other_spend_pcnt,le.populated_advt_spend_pcnt,le.populated_air_growth_pcnt,le.populated_fuel_growth_pcnt,le.populated_leasing_growth_pcnt,le.populated_ltl_growth_pcnt,le.populated_rail_growth_pcnt,le.populated_tl_growth_pcnt,le.populated_transvc_growth_pcnt,le.populated_transup_growth_pcnt,le.populated_bst_growth_pcnt,le.populated_dg_growth_pcnt,le.populated_electrical_growth_pcnt,le.populated_hvac_growth_pcnt,le.populated_other_b_growth_pcnt,le.populated_plumbing_growth_pcnt,le.populated_rs_growth_pcnt,le.populated_wp_growth_pcnt,le.populated_chemical_growth_pcnt,le.populated_electronic_growth_pcnt,le.populated_metal_growth_pcnt,le.populated_other_m_growth_pcnt,le.populated_packaging_growth_pcnt,le.populated_pvf_growth_pcnt,le.populated_plastic_growth_pcnt,le.populated_textile_growth_pcnt,le.populated_bs_growth_pcnt,le.populated_ce_growth_pcnt,le.populated_hardware_growth_pcnt,le.populated_ie_growth_pcnt,le.populated_is_growth_pcnt,le.populated_it_growth_pcnt,le.populated_mls_growth_pcnt,le.populated_os_growth_pcnt,le.populated_pp_growth_pcnt,le.populated_sis_growth_pcnt,le.populated_apparel_growth_pcnt,le.populated_beverages_growth_pcnt,le.populated_constr_growth_pcnt,le.populated_consulting_growth_pcnt,le.populated_fs_growth_pcnt,le.populated_fp_growth_pcnt,le.populated_insurance_growth_pcnt,le.populated_ls_growth_pcnt,le.populated_oil_gas_growth_pcnt,le.populated_utilities_growth_pcnt,le.populated_other_growth_pcnt,le.populated_advt_growth_pcnt,le.populated_top5_growth_pcnt,le.populated_shipping_y1_pcnt,le.populated_shipping_growth_pcnt,le.populated_materials_y1_pcnt,le.populated_materials_growth_pcnt,le.populated_operations_y1_pcnt,le.populated_operations_growth_pcnt,le.populated_total_paid_average_0t12_pcnt,le.populated_total_paid_monthspastworst_24_pcnt,le.populated_total_paid_slope_0t12_pcnt,le.populated_total_paid_slope_0t6_pcnt,le.populated_total_paid_slope_6t12_pcnt,le.populated_total_paid_slope_6t18_pcnt,le.populated_total_paid_volatility_0t12_pcnt,le.populated_total_paid_volatility_0t6_pcnt,le.populated_total_paid_volatility_12t18_pcnt,le.populated_total_paid_volatility_6t12_pcnt,le.populated_total_spend_monthspastleast_24_pcnt,le.populated_total_spend_monthspastmost_24_pcnt,le.populated_total_spend_slope_0t12_pcnt,le.populated_total_spend_slope_0t24_pcnt,le.populated_total_spend_slope_0t6_pcnt,le.populated_total_spend_slope_6t12_pcnt,le.populated_total_spend_sum_12_pcnt,le.populated_total_spend_volatility_0t12_pcnt,le.populated_total_spend_volatility_0t6_pcnt,le.populated_total_spend_volatility_12t18_pcnt,le.populated_total_spend_volatility_6t12_pcnt,le.populated_mfgmat_paid_average_12_pcnt,le.populated_mfgmat_paid_monthspastworst_24_pcnt,le.populated_mfgmat_paid_slope_0t12_pcnt,le.populated_mfgmat_paid_slope_0t24_pcnt,le.populated_mfgmat_paid_slope_0t6_pcnt,le.populated_mfgmat_paid_volatility_0t12_pcnt,le.populated_mfgmat_paid_volatility_0t6_pcnt,le.populated_mfgmat_spend_monthspastleast_24_pcnt,le.populated_mfgmat_spend_monthspastmost_24_pcnt,le.populated_mfgmat_spend_slope_0t12_pcnt,le.populated_mfgmat_spend_slope_0t24_pcnt,le.populated_mfgmat_spend_slope_0t6_pcnt,le.populated_mfgmat_spend_sum_12_pcnt,le.populated_mfgmat_spend_volatility_0t6_pcnt,le.populated_mfgmat_spend_volatility_6t12_pcnt,le.populated_ops_paid_average_12_pcnt,le.populated_ops_paid_monthspastworst_24_pcnt,le.populated_ops_paid_slope_0t12_pcnt,le.populated_ops_paid_slope_0t24_pcnt,le.populated_ops_paid_slope_0t6_pcnt,le.populated_ops_paid_volatility_0t12_pcnt,le.populated_ops_paid_volatility_0t6_pcnt,le.populated_ops_spend_monthspastleast_24_pcnt,le.populated_ops_spend_monthspastmost_24_pcnt,le.populated_ops_spend_slope_0t12_pcnt,le.populated_ops_spend_slope_0t24_pcnt,le.populated_ops_spend_slope_0t6_pcnt,le.populated_ops_spend_sum_12_pcnt,le.populated_ops_spend_volatility_0t6_pcnt,le.populated_ops_spend_volatility_6t12_pcnt,le.populated_fleet_paid_average_12_pcnt,le.populated_fleet_paid_monthspastworst_24_pcnt,le.populated_fleet_paid_slope_0t12_pcnt,le.populated_fleet_paid_slope_0t24_pcnt,le.populated_fleet_paid_slope_0t6_pcnt,le.populated_fleet_paid_volatility_0t12_pcnt,le.populated_fleet_paid_volatility_0t6_pcnt,le.populated_fleet_spend_monthspastleast_24_pcnt,le.populated_fleet_spend_monthspastmost_24_pcnt,le.populated_fleet_spend_slope_0t12_pcnt,le.populated_fleet_spend_slope_0t24_pcnt,le.populated_fleet_spend_slope_0t6_pcnt,le.populated_fleet_spend_sum_12_pcnt,le.populated_fleet_spend_volatility_0t6_pcnt,le.populated_fleet_spend_volatility_6t12_pcnt,le.populated_carrier_paid_average_12_pcnt,le.populated_carrier_paid_monthspastworst_24_pcnt,le.populated_carrier_paid_slope_0t12_pcnt,le.populated_carrier_paid_slope_0t24_pcnt,le.populated_carrier_paid_slope_0t6_pcnt,le.populated_carrier_paid_volatility_0t12_pcnt,le.populated_carrier_paid_volatility_0t6_pcnt,le.populated_carrier_spend_monthspastleast_24_pcnt,le.populated_carrier_spend_monthspastmost_24_pcnt,le.populated_carrier_spend_slope_0t12_pcnt,le.populated_carrier_spend_slope_0t24_pcnt,le.populated_carrier_spend_slope_0t6_pcnt,le.populated_carrier_spend_sum_12_pcnt,le.populated_carrier_spend_volatility_0t6_pcnt,le.populated_carrier_spend_volatility_6t12_pcnt,le.populated_bldgmats_paid_average_12_pcnt,le.populated_bldgmats_paid_monthspastworst_24_pcnt,le.populated_bldgmats_paid_slope_0t12_pcnt,le.populated_bldgmats_paid_slope_0t24_pcnt,le.populated_bldgmats_paid_slope_0t6_pcnt,le.populated_bldgmats_paid_volatility_0t12_pcnt,le.populated_bldgmats_paid_volatility_0t6_pcnt,le.populated_bldgmats_spend_monthspastleast_24_pcnt,le.populated_bldgmats_spend_monthspastmost_24_pcnt,le.populated_bldgmats_spend_slope_0t12_pcnt,le.populated_bldgmats_spend_slope_0t24_pcnt,le.populated_bldgmats_spend_slope_0t6_pcnt,le.populated_bldgmats_spend_sum_12_pcnt,le.populated_bldgmats_spend_volatility_0t6_pcnt,le.populated_bldgmats_spend_volatility_6t12_pcnt,le.populated_top5_paid_average_12_pcnt,le.populated_top5_paid_monthspastworst_24_pcnt,le.populated_top5_paid_slope_0t12_pcnt,le.populated_top5_paid_slope_0t24_pcnt,le.populated_top5_paid_slope_0t6_pcnt,le.populated_top5_paid_volatility_0t12_pcnt,le.populated_top5_paid_volatility_0t6_pcnt,le.populated_top5_spend_monthspastleast_24_pcnt,le.populated_top5_spend_monthspastmost_24_pcnt,le.populated_top5_spend_slope_0t12_pcnt,le.populated_top5_spend_slope_0t24_pcnt,le.populated_top5_spend_slope_0t6_pcnt,le.populated_top5_spend_sum_12_pcnt,le.populated_top5_spend_volatility_0t6_pcnt,le.populated_top5_spend_volatility_6t12_pcnt,le.populated_total_numrel_avg12_pcnt,le.populated_total_numrel_monthpspastmost_24_pcnt,le.populated_total_numrel_monthspastleast_24_pcnt,le.populated_total_numrel_slope_0t12_pcnt,le.populated_total_numrel_slope_0t24_pcnt,le.populated_total_numrel_slope_0t6_pcnt,le.populated_total_numrel_slope_6t12_pcnt,le.populated_total_numrel_var_0t12_pcnt,le.populated_total_numrel_var_0t24_pcnt,le.populated_total_numrel_var_12t24_pcnt,le.populated_total_numrel_var_6t18_pcnt,le.populated_mfgmat_numrel_avg12_pcnt,le.populated_mfgmat_numrel_slope_0t12_pcnt,le.populated_mfgmat_numrel_slope_0t24_pcnt,le.populated_mfgmat_numrel_slope_0t6_pcnt,le.populated_mfgmat_numrel_slope_6t12_pcnt,le.populated_mfgmat_numrel_var_0t12_pcnt,le.populated_mfgmat_numrel_var_12t24_pcnt,le.populated_ops_numrel_avg12_pcnt,le.populated_ops_numrel_slope_0t12_pcnt,le.populated_ops_numrel_slope_0t24_pcnt,le.populated_ops_numrel_slope_0t6_pcnt,le.populated_ops_numrel_slope_6t12_pcnt,le.populated_ops_numrel_var_0t12_pcnt,le.populated_ops_numrel_var_12t24_pcnt,le.populated_fleet_numrel_avg12_pcnt,le.populated_fleet_numrel_slope_0t12_pcnt,le.populated_fleet_numrel_slope_0t24_pcnt,le.populated_fleet_numrel_slope_0t6_pcnt,le.populated_fleet_numrel_slope_6t12_pcnt,le.populated_fleet_numrel_var_0t12_pcnt,le.populated_fleet_numrel_var_12t24_pcnt,le.populated_carrier_numrel_avg12_pcnt,le.populated_carrier_numrel_slope_0t12_pcnt,le.populated_carrier_numrel_slope_0t24_pcnt,le.populated_carrier_numrel_slope_0t6_pcnt,le.populated_carrier_numrel_slope_6t12_pcnt,le.populated_carrier_numrel_var_0t12_pcnt,le.populated_carrier_numrel_var_12t24_pcnt,le.populated_bldgmats_numrel_avg12_pcnt,le.populated_bldgmats_numrel_slope_0t12_pcnt,le.populated_bldgmats_numrel_slope_0t24_pcnt,le.populated_bldgmats_numrel_slope_0t6_pcnt,le.populated_bldgmats_numrel_slope_6t12_pcnt,le.populated_bldgmats_numrel_var_0t12_pcnt,le.populated_bldgmats_numrel_var_12t24_pcnt,le.populated_total_monthsoutstanding_slope24_pcnt,le.populated_total_percprov30_avg_0t12_pcnt,le.populated_total_percprov30_slope_0t12_pcnt,le.populated_total_percprov30_slope_0t24_pcnt,le.populated_total_percprov30_slope_0t6_pcnt,le.populated_total_percprov30_slope_6t12_pcnt,le.populated_total_percprov60_avg_0t12_pcnt,le.populated_total_percprov60_slope_0t12_pcnt,le.populated_total_percprov60_slope_0t24_pcnt,le.populated_total_percprov60_slope_0t6_pcnt,le.populated_total_percprov60_slope_6t12_pcnt,le.populated_total_percprov90_avg_0t12_pcnt,le.populated_total_percprov90_lowerlim_0t12_pcnt,le.populated_total_percprov90_slope_0t24_pcnt,le.populated_total_percprov90_slope_0t6_pcnt,le.populated_total_percprov90_slope_6t12_pcnt,le.populated_total_percprovoutstanding_adjustedslope_0t12_pcnt,le.populated_mfgmat_monthsoutstanding_slope24_pcnt,le.populated_mfgmat_percprov30_slope_0t12_pcnt,le.populated_mfgmat_percprov30_slope_6t12_pcnt,le.populated_mfgmat_percprov60_slope_0t12_pcnt,le.populated_mfgmat_percprov60_slope_6t12_pcnt,le.populated_mfgmat_percprov90_slope_0t24_pcnt,le.populated_mfgmat_percprov90_slope_0t6_pcnt,le.populated_mfgmat_percprov90_slope_6t12_pcnt,le.populated_mfgmat_percprovoutstanding_adjustedslope_0t12_pcnt,le.populated_ops_monthsoutstanding_slope24_pcnt,le.populated_ops_percprov30_slope_0t12_pcnt,le.populated_ops_percprov30_slope_6t12_pcnt,le.populated_ops_percprov60_slope_0t12_pcnt,le.populated_ops_percprov60_slope_6t12_pcnt,le.populated_ops_percprov90_slope_0t24_pcnt,le.populated_ops_percprov90_slope_0t6_pcnt,le.populated_ops_percprov90_slope_6t12_pcnt,le.populated_ops_percprovoutstanding_adjustedslope_0t12_pcnt,le.populated_fleet_monthsoutstanding_slope24_pcnt,le.populated_fleet_percprov30_slope_0t12_pcnt,le.populated_fleet_percprov30_slope_6t12_pcnt,le.populated_fleet_percprov60_slope_0t12_pcnt,le.populated_fleet_percprov60_slope_6t12_pcnt,le.populated_fleet_percprov90_slope_0t24_pcnt,le.populated_fleet_percprov90_slope_0t6_pcnt,le.populated_fleet_percprov90_slope_6t12_pcnt,le.populated_fleet_percprovoutstanding_adjustedslope_0t12_pcnt,le.populated_carrier_monthsoutstanding_slope24_pcnt,le.populated_carrier_percprov30_slope_0t12_pcnt,le.populated_carrier_percprov30_slope_6t12_pcnt,le.populated_carrier_percprov60_slope_0t12_pcnt,le.populated_carrier_percprov60_slope_6t12_pcnt,le.populated_carrier_percprov90_slope_0t24_pcnt,le.populated_carrier_percprov90_slope_0t6_pcnt,le.populated_carrier_percprov90_slope_6t12_pcnt,le.populated_carrier_percprovoutstanding_adjustedslope_0t12_pcnt,le.populated_bldgmats_monthsoutstanding_slope24_pcnt,le.populated_bldgmats_percprov30_slope_0t12_pcnt,le.populated_bldgmats_percprov30_slope_6t12_pcnt,le.populated_bldgmats_percprov60_slope_0t12_pcnt,le.populated_bldgmats_percprov60_slope_6t12_pcnt,le.populated_bldgmats_percprov90_slope_0t24_pcnt,le.populated_bldgmats_percprov90_slope_0t6_pcnt,le.populated_bldgmats_percprov90_slope_6t12_pcnt,le.populated_bldgmats_percprovoutstanding_adjustedslope_0t12_pcnt,le.populated_top5_monthsoutstanding_slope24_pcnt,le.populated_top5_percprov30_slope_0t12_pcnt,le.populated_top5_percprov30_slope_6t12_pcnt,le.populated_top5_percprov60_slope_0t12_pcnt,le.populated_top5_percprov60_slope_6t12_pcnt,le.populated_top5_percprov90_slope_0t24_pcnt,le.populated_top5_percprov90_slope_0t6_pcnt,le.populated_top5_percprov90_slope_6t12_pcnt,le.populated_top5_percprovoutstanding_adjustedslope_0t12_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_ultimate_linkid,le.maxlength_cortera_score,le.maxlength_cpr_score,le.maxlength_cpr_segment,le.maxlength_dbt,le.maxlength_avg_bal,le.maxlength_air_spend,le.maxlength_fuel_spend,le.maxlength_leasing_spend,le.maxlength_ltl_spend,le.maxlength_rail_spend,le.maxlength_tl_spend,le.maxlength_transvc_spend,le.maxlength_transup_spend,le.maxlength_bst_spend,le.maxlength_dg_spend,le.maxlength_electrical_spend,le.maxlength_hvac_spend,le.maxlength_other_b_spend,le.maxlength_plumbing_spend,le.maxlength_rs_spend,le.maxlength_wp_spend,le.maxlength_chemical_spend,le.maxlength_electronic_spend,le.maxlength_metal_spend,le.maxlength_other_m_spend,le.maxlength_packaging_spend,le.maxlength_pvf_spend,le.maxlength_plastic_spend,le.maxlength_textile_spend,le.maxlength_bs_spend,le.maxlength_ce_spend,le.maxlength_hardware_spend,le.maxlength_ie_spend,le.maxlength_is_spend,le.maxlength_it_spend,le.maxlength_mls_spend,le.maxlength_os_spend,le.maxlength_pp_spend,le.maxlength_sis_spend,le.maxlength_apparel_spend,le.maxlength_beverages_spend,le.maxlength_constr_spend,le.maxlength_consulting_spend,le.maxlength_fs_spend,le.maxlength_fp_spend,le.maxlength_insurance_spend,le.maxlength_ls_spend,le.maxlength_oil_gas_spend,le.maxlength_utilities_spend,le.maxlength_other_spend,le.maxlength_advt_spend,le.maxlength_air_growth,le.maxlength_fuel_growth,le.maxlength_leasing_growth,le.maxlength_ltl_growth,le.maxlength_rail_growth,le.maxlength_tl_growth,le.maxlength_transvc_growth,le.maxlength_transup_growth,le.maxlength_bst_growth,le.maxlength_dg_growth,le.maxlength_electrical_growth,le.maxlength_hvac_growth,le.maxlength_other_b_growth,le.maxlength_plumbing_growth,le.maxlength_rs_growth,le.maxlength_wp_growth,le.maxlength_chemical_growth,le.maxlength_electronic_growth,le.maxlength_metal_growth,le.maxlength_other_m_growth,le.maxlength_packaging_growth,le.maxlength_pvf_growth,le.maxlength_plastic_growth,le.maxlength_textile_growth,le.maxlength_bs_growth,le.maxlength_ce_growth,le.maxlength_hardware_growth,le.maxlength_ie_growth,le.maxlength_is_growth,le.maxlength_it_growth,le.maxlength_mls_growth,le.maxlength_os_growth,le.maxlength_pp_growth,le.maxlength_sis_growth,le.maxlength_apparel_growth,le.maxlength_beverages_growth,le.maxlength_constr_growth,le.maxlength_consulting_growth,le.maxlength_fs_growth,le.maxlength_fp_growth,le.maxlength_insurance_growth,le.maxlength_ls_growth,le.maxlength_oil_gas_growth,le.maxlength_utilities_growth,le.maxlength_other_growth,le.maxlength_advt_growth,le.maxlength_top5_growth,le.maxlength_shipping_y1,le.maxlength_shipping_growth,le.maxlength_materials_y1,le.maxlength_materials_growth,le.maxlength_operations_y1,le.maxlength_operations_growth,le.maxlength_total_paid_average_0t12,le.maxlength_total_paid_monthspastworst_24,le.maxlength_total_paid_slope_0t12,le.maxlength_total_paid_slope_0t6,le.maxlength_total_paid_slope_6t12,le.maxlength_total_paid_slope_6t18,le.maxlength_total_paid_volatility_0t12,le.maxlength_total_paid_volatility_0t6,le.maxlength_total_paid_volatility_12t18,le.maxlength_total_paid_volatility_6t12,le.maxlength_total_spend_monthspastleast_24,le.maxlength_total_spend_monthspastmost_24,le.maxlength_total_spend_slope_0t12,le.maxlength_total_spend_slope_0t24,le.maxlength_total_spend_slope_0t6,le.maxlength_total_spend_slope_6t12,le.maxlength_total_spend_sum_12,le.maxlength_total_spend_volatility_0t12,le.maxlength_total_spend_volatility_0t6,le.maxlength_total_spend_volatility_12t18,le.maxlength_total_spend_volatility_6t12,le.maxlength_mfgmat_paid_average_12,le.maxlength_mfgmat_paid_monthspastworst_24,le.maxlength_mfgmat_paid_slope_0t12,le.maxlength_mfgmat_paid_slope_0t24,le.maxlength_mfgmat_paid_slope_0t6,le.maxlength_mfgmat_paid_volatility_0t12,le.maxlength_mfgmat_paid_volatility_0t6,le.maxlength_mfgmat_spend_monthspastleast_24,le.maxlength_mfgmat_spend_monthspastmost_24,le.maxlength_mfgmat_spend_slope_0t12,le.maxlength_mfgmat_spend_slope_0t24,le.maxlength_mfgmat_spend_slope_0t6,le.maxlength_mfgmat_spend_sum_12,le.maxlength_mfgmat_spend_volatility_0t6,le.maxlength_mfgmat_spend_volatility_6t12,le.maxlength_ops_paid_average_12,le.maxlength_ops_paid_monthspastworst_24,le.maxlength_ops_paid_slope_0t12,le.maxlength_ops_paid_slope_0t24,le.maxlength_ops_paid_slope_0t6,le.maxlength_ops_paid_volatility_0t12,le.maxlength_ops_paid_volatility_0t6,le.maxlength_ops_spend_monthspastleast_24,le.maxlength_ops_spend_monthspastmost_24,le.maxlength_ops_spend_slope_0t12,le.maxlength_ops_spend_slope_0t24,le.maxlength_ops_spend_slope_0t6,le.maxlength_ops_spend_sum_12,le.maxlength_ops_spend_volatility_0t6,le.maxlength_ops_spend_volatility_6t12,le.maxlength_fleet_paid_average_12,le.maxlength_fleet_paid_monthspastworst_24,le.maxlength_fleet_paid_slope_0t12,le.maxlength_fleet_paid_slope_0t24,le.maxlength_fleet_paid_slope_0t6,le.maxlength_fleet_paid_volatility_0t12,le.maxlength_fleet_paid_volatility_0t6,le.maxlength_fleet_spend_monthspastleast_24,le.maxlength_fleet_spend_monthspastmost_24,le.maxlength_fleet_spend_slope_0t12,le.maxlength_fleet_spend_slope_0t24,le.maxlength_fleet_spend_slope_0t6,le.maxlength_fleet_spend_sum_12,le.maxlength_fleet_spend_volatility_0t6,le.maxlength_fleet_spend_volatility_6t12,le.maxlength_carrier_paid_average_12,le.maxlength_carrier_paid_monthspastworst_24,le.maxlength_carrier_paid_slope_0t12,le.maxlength_carrier_paid_slope_0t24,le.maxlength_carrier_paid_slope_0t6,le.maxlength_carrier_paid_volatility_0t12,le.maxlength_carrier_paid_volatility_0t6,le.maxlength_carrier_spend_monthspastleast_24,le.maxlength_carrier_spend_monthspastmost_24,le.maxlength_carrier_spend_slope_0t12,le.maxlength_carrier_spend_slope_0t24,le.maxlength_carrier_spend_slope_0t6,le.maxlength_carrier_spend_sum_12,le.maxlength_carrier_spend_volatility_0t6,le.maxlength_carrier_spend_volatility_6t12,le.maxlength_bldgmats_paid_average_12,le.maxlength_bldgmats_paid_monthspastworst_24,le.maxlength_bldgmats_paid_slope_0t12,le.maxlength_bldgmats_paid_slope_0t24,le.maxlength_bldgmats_paid_slope_0t6,le.maxlength_bldgmats_paid_volatility_0t12,le.maxlength_bldgmats_paid_volatility_0t6,le.maxlength_bldgmats_spend_monthspastleast_24,le.maxlength_bldgmats_spend_monthspastmost_24,le.maxlength_bldgmats_spend_slope_0t12,le.maxlength_bldgmats_spend_slope_0t24,le.maxlength_bldgmats_spend_slope_0t6,le.maxlength_bldgmats_spend_sum_12,le.maxlength_bldgmats_spend_volatility_0t6,le.maxlength_bldgmats_spend_volatility_6t12,le.maxlength_top5_paid_average_12,le.maxlength_top5_paid_monthspastworst_24,le.maxlength_top5_paid_slope_0t12,le.maxlength_top5_paid_slope_0t24,le.maxlength_top5_paid_slope_0t6,le.maxlength_top5_paid_volatility_0t12,le.maxlength_top5_paid_volatility_0t6,le.maxlength_top5_spend_monthspastleast_24,le.maxlength_top5_spend_monthspastmost_24,le.maxlength_top5_spend_slope_0t12,le.maxlength_top5_spend_slope_0t24,le.maxlength_top5_spend_slope_0t6,le.maxlength_top5_spend_sum_12,le.maxlength_top5_spend_volatility_0t6,le.maxlength_top5_spend_volatility_6t12,le.maxlength_total_numrel_avg12,le.maxlength_total_numrel_monthpspastmost_24,le.maxlength_total_numrel_monthspastleast_24,le.maxlength_total_numrel_slope_0t12,le.maxlength_total_numrel_slope_0t24,le.maxlength_total_numrel_slope_0t6,le.maxlength_total_numrel_slope_6t12,le.maxlength_total_numrel_var_0t12,le.maxlength_total_numrel_var_0t24,le.maxlength_total_numrel_var_12t24,le.maxlength_total_numrel_var_6t18,le.maxlength_mfgmat_numrel_avg12,le.maxlength_mfgmat_numrel_slope_0t12,le.maxlength_mfgmat_numrel_slope_0t24,le.maxlength_mfgmat_numrel_slope_0t6,le.maxlength_mfgmat_numrel_slope_6t12,le.maxlength_mfgmat_numrel_var_0t12,le.maxlength_mfgmat_numrel_var_12t24,le.maxlength_ops_numrel_avg12,le.maxlength_ops_numrel_slope_0t12,le.maxlength_ops_numrel_slope_0t24,le.maxlength_ops_numrel_slope_0t6,le.maxlength_ops_numrel_slope_6t12,le.maxlength_ops_numrel_var_0t12,le.maxlength_ops_numrel_var_12t24,le.maxlength_fleet_numrel_avg12,le.maxlength_fleet_numrel_slope_0t12,le.maxlength_fleet_numrel_slope_0t24,le.maxlength_fleet_numrel_slope_0t6,le.maxlength_fleet_numrel_slope_6t12,le.maxlength_fleet_numrel_var_0t12,le.maxlength_fleet_numrel_var_12t24,le.maxlength_carrier_numrel_avg12,le.maxlength_carrier_numrel_slope_0t12,le.maxlength_carrier_numrel_slope_0t24,le.maxlength_carrier_numrel_slope_0t6,le.maxlength_carrier_numrel_slope_6t12,le.maxlength_carrier_numrel_var_0t12,le.maxlength_carrier_numrel_var_12t24,le.maxlength_bldgmats_numrel_avg12,le.maxlength_bldgmats_numrel_slope_0t12,le.maxlength_bldgmats_numrel_slope_0t24,le.maxlength_bldgmats_numrel_slope_0t6,le.maxlength_bldgmats_numrel_slope_6t12,le.maxlength_bldgmats_numrel_var_0t12,le.maxlength_bldgmats_numrel_var_12t24,le.maxlength_total_monthsoutstanding_slope24,le.maxlength_total_percprov30_avg_0t12,le.maxlength_total_percprov30_slope_0t12,le.maxlength_total_percprov30_slope_0t24,le.maxlength_total_percprov30_slope_0t6,le.maxlength_total_percprov30_slope_6t12,le.maxlength_total_percprov60_avg_0t12,le.maxlength_total_percprov60_slope_0t12,le.maxlength_total_percprov60_slope_0t24,le.maxlength_total_percprov60_slope_0t6,le.maxlength_total_percprov60_slope_6t12,le.maxlength_total_percprov90_avg_0t12,le.maxlength_total_percprov90_lowerlim_0t12,le.maxlength_total_percprov90_slope_0t24,le.maxlength_total_percprov90_slope_0t6,le.maxlength_total_percprov90_slope_6t12,le.maxlength_total_percprovoutstanding_adjustedslope_0t12,le.maxlength_mfgmat_monthsoutstanding_slope24,le.maxlength_mfgmat_percprov30_slope_0t12,le.maxlength_mfgmat_percprov30_slope_6t12,le.maxlength_mfgmat_percprov60_slope_0t12,le.maxlength_mfgmat_percprov60_slope_6t12,le.maxlength_mfgmat_percprov90_slope_0t24,le.maxlength_mfgmat_percprov90_slope_0t6,le.maxlength_mfgmat_percprov90_slope_6t12,le.maxlength_mfgmat_percprovoutstanding_adjustedslope_0t12,le.maxlength_ops_monthsoutstanding_slope24,le.maxlength_ops_percprov30_slope_0t12,le.maxlength_ops_percprov30_slope_6t12,le.maxlength_ops_percprov60_slope_0t12,le.maxlength_ops_percprov60_slope_6t12,le.maxlength_ops_percprov90_slope_0t24,le.maxlength_ops_percprov90_slope_0t6,le.maxlength_ops_percprov90_slope_6t12,le.maxlength_ops_percprovoutstanding_adjustedslope_0t12,le.maxlength_fleet_monthsoutstanding_slope24,le.maxlength_fleet_percprov30_slope_0t12,le.maxlength_fleet_percprov30_slope_6t12,le.maxlength_fleet_percprov60_slope_0t12,le.maxlength_fleet_percprov60_slope_6t12,le.maxlength_fleet_percprov90_slope_0t24,le.maxlength_fleet_percprov90_slope_0t6,le.maxlength_fleet_percprov90_slope_6t12,le.maxlength_fleet_percprovoutstanding_adjustedslope_0t12,le.maxlength_carrier_monthsoutstanding_slope24,le.maxlength_carrier_percprov30_slope_0t12,le.maxlength_carrier_percprov30_slope_6t12,le.maxlength_carrier_percprov60_slope_0t12,le.maxlength_carrier_percprov60_slope_6t12,le.maxlength_carrier_percprov90_slope_0t24,le.maxlength_carrier_percprov90_slope_0t6,le.maxlength_carrier_percprov90_slope_6t12,le.maxlength_carrier_percprovoutstanding_adjustedslope_0t12,le.maxlength_bldgmats_monthsoutstanding_slope24,le.maxlength_bldgmats_percprov30_slope_0t12,le.maxlength_bldgmats_percprov30_slope_6t12,le.maxlength_bldgmats_percprov60_slope_0t12,le.maxlength_bldgmats_percprov60_slope_6t12,le.maxlength_bldgmats_percprov90_slope_0t24,le.maxlength_bldgmats_percprov90_slope_0t6,le.maxlength_bldgmats_percprov90_slope_6t12,le.maxlength_bldgmats_percprovoutstanding_adjustedslope_0t12,le.maxlength_top5_monthsoutstanding_slope24,le.maxlength_top5_percprov30_slope_0t12,le.maxlength_top5_percprov30_slope_6t12,le.maxlength_top5_percprov60_slope_0t12,le.maxlength_top5_percprov60_slope_6t12,le.maxlength_top5_percprov90_slope_0t24,le.maxlength_top5_percprov90_slope_0t6,le.maxlength_top5_percprov90_slope_6t12,le.maxlength_top5_percprovoutstanding_adjustedslope_0t12);
  SELF.avelength := CHOOSE(C,le.avelength_ultimate_linkid,le.avelength_cortera_score,le.avelength_cpr_score,le.avelength_cpr_segment,le.avelength_dbt,le.avelength_avg_bal,le.avelength_air_spend,le.avelength_fuel_spend,le.avelength_leasing_spend,le.avelength_ltl_spend,le.avelength_rail_spend,le.avelength_tl_spend,le.avelength_transvc_spend,le.avelength_transup_spend,le.avelength_bst_spend,le.avelength_dg_spend,le.avelength_electrical_spend,le.avelength_hvac_spend,le.avelength_other_b_spend,le.avelength_plumbing_spend,le.avelength_rs_spend,le.avelength_wp_spend,le.avelength_chemical_spend,le.avelength_electronic_spend,le.avelength_metal_spend,le.avelength_other_m_spend,le.avelength_packaging_spend,le.avelength_pvf_spend,le.avelength_plastic_spend,le.avelength_textile_spend,le.avelength_bs_spend,le.avelength_ce_spend,le.avelength_hardware_spend,le.avelength_ie_spend,le.avelength_is_spend,le.avelength_it_spend,le.avelength_mls_spend,le.avelength_os_spend,le.avelength_pp_spend,le.avelength_sis_spend,le.avelength_apparel_spend,le.avelength_beverages_spend,le.avelength_constr_spend,le.avelength_consulting_spend,le.avelength_fs_spend,le.avelength_fp_spend,le.avelength_insurance_spend,le.avelength_ls_spend,le.avelength_oil_gas_spend,le.avelength_utilities_spend,le.avelength_other_spend,le.avelength_advt_spend,le.avelength_air_growth,le.avelength_fuel_growth,le.avelength_leasing_growth,le.avelength_ltl_growth,le.avelength_rail_growth,le.avelength_tl_growth,le.avelength_transvc_growth,le.avelength_transup_growth,le.avelength_bst_growth,le.avelength_dg_growth,le.avelength_electrical_growth,le.avelength_hvac_growth,le.avelength_other_b_growth,le.avelength_plumbing_growth,le.avelength_rs_growth,le.avelength_wp_growth,le.avelength_chemical_growth,le.avelength_electronic_growth,le.avelength_metal_growth,le.avelength_other_m_growth,le.avelength_packaging_growth,le.avelength_pvf_growth,le.avelength_plastic_growth,le.avelength_textile_growth,le.avelength_bs_growth,le.avelength_ce_growth,le.avelength_hardware_growth,le.avelength_ie_growth,le.avelength_is_growth,le.avelength_it_growth,le.avelength_mls_growth,le.avelength_os_growth,le.avelength_pp_growth,le.avelength_sis_growth,le.avelength_apparel_growth,le.avelength_beverages_growth,le.avelength_constr_growth,le.avelength_consulting_growth,le.avelength_fs_growth,le.avelength_fp_growth,le.avelength_insurance_growth,le.avelength_ls_growth,le.avelength_oil_gas_growth,le.avelength_utilities_growth,le.avelength_other_growth,le.avelength_advt_growth,le.avelength_top5_growth,le.avelength_shipping_y1,le.avelength_shipping_growth,le.avelength_materials_y1,le.avelength_materials_growth,le.avelength_operations_y1,le.avelength_operations_growth,le.avelength_total_paid_average_0t12,le.avelength_total_paid_monthspastworst_24,le.avelength_total_paid_slope_0t12,le.avelength_total_paid_slope_0t6,le.avelength_total_paid_slope_6t12,le.avelength_total_paid_slope_6t18,le.avelength_total_paid_volatility_0t12,le.avelength_total_paid_volatility_0t6,le.avelength_total_paid_volatility_12t18,le.avelength_total_paid_volatility_6t12,le.avelength_total_spend_monthspastleast_24,le.avelength_total_spend_monthspastmost_24,le.avelength_total_spend_slope_0t12,le.avelength_total_spend_slope_0t24,le.avelength_total_spend_slope_0t6,le.avelength_total_spend_slope_6t12,le.avelength_total_spend_sum_12,le.avelength_total_spend_volatility_0t12,le.avelength_total_spend_volatility_0t6,le.avelength_total_spend_volatility_12t18,le.avelength_total_spend_volatility_6t12,le.avelength_mfgmat_paid_average_12,le.avelength_mfgmat_paid_monthspastworst_24,le.avelength_mfgmat_paid_slope_0t12,le.avelength_mfgmat_paid_slope_0t24,le.avelength_mfgmat_paid_slope_0t6,le.avelength_mfgmat_paid_volatility_0t12,le.avelength_mfgmat_paid_volatility_0t6,le.avelength_mfgmat_spend_monthspastleast_24,le.avelength_mfgmat_spend_monthspastmost_24,le.avelength_mfgmat_spend_slope_0t12,le.avelength_mfgmat_spend_slope_0t24,le.avelength_mfgmat_spend_slope_0t6,le.avelength_mfgmat_spend_sum_12,le.avelength_mfgmat_spend_volatility_0t6,le.avelength_mfgmat_spend_volatility_6t12,le.avelength_ops_paid_average_12,le.avelength_ops_paid_monthspastworst_24,le.avelength_ops_paid_slope_0t12,le.avelength_ops_paid_slope_0t24,le.avelength_ops_paid_slope_0t6,le.avelength_ops_paid_volatility_0t12,le.avelength_ops_paid_volatility_0t6,le.avelength_ops_spend_monthspastleast_24,le.avelength_ops_spend_monthspastmost_24,le.avelength_ops_spend_slope_0t12,le.avelength_ops_spend_slope_0t24,le.avelength_ops_spend_slope_0t6,le.avelength_ops_spend_sum_12,le.avelength_ops_spend_volatility_0t6,le.avelength_ops_spend_volatility_6t12,le.avelength_fleet_paid_average_12,le.avelength_fleet_paid_monthspastworst_24,le.avelength_fleet_paid_slope_0t12,le.avelength_fleet_paid_slope_0t24,le.avelength_fleet_paid_slope_0t6,le.avelength_fleet_paid_volatility_0t12,le.avelength_fleet_paid_volatility_0t6,le.avelength_fleet_spend_monthspastleast_24,le.avelength_fleet_spend_monthspastmost_24,le.avelength_fleet_spend_slope_0t12,le.avelength_fleet_spend_slope_0t24,le.avelength_fleet_spend_slope_0t6,le.avelength_fleet_spend_sum_12,le.avelength_fleet_spend_volatility_0t6,le.avelength_fleet_spend_volatility_6t12,le.avelength_carrier_paid_average_12,le.avelength_carrier_paid_monthspastworst_24,le.avelength_carrier_paid_slope_0t12,le.avelength_carrier_paid_slope_0t24,le.avelength_carrier_paid_slope_0t6,le.avelength_carrier_paid_volatility_0t12,le.avelength_carrier_paid_volatility_0t6,le.avelength_carrier_spend_monthspastleast_24,le.avelength_carrier_spend_monthspastmost_24,le.avelength_carrier_spend_slope_0t12,le.avelength_carrier_spend_slope_0t24,le.avelength_carrier_spend_slope_0t6,le.avelength_carrier_spend_sum_12,le.avelength_carrier_spend_volatility_0t6,le.avelength_carrier_spend_volatility_6t12,le.avelength_bldgmats_paid_average_12,le.avelength_bldgmats_paid_monthspastworst_24,le.avelength_bldgmats_paid_slope_0t12,le.avelength_bldgmats_paid_slope_0t24,le.avelength_bldgmats_paid_slope_0t6,le.avelength_bldgmats_paid_volatility_0t12,le.avelength_bldgmats_paid_volatility_0t6,le.avelength_bldgmats_spend_monthspastleast_24,le.avelength_bldgmats_spend_monthspastmost_24,le.avelength_bldgmats_spend_slope_0t12,le.avelength_bldgmats_spend_slope_0t24,le.avelength_bldgmats_spend_slope_0t6,le.avelength_bldgmats_spend_sum_12,le.avelength_bldgmats_spend_volatility_0t6,le.avelength_bldgmats_spend_volatility_6t12,le.avelength_top5_paid_average_12,le.avelength_top5_paid_monthspastworst_24,le.avelength_top5_paid_slope_0t12,le.avelength_top5_paid_slope_0t24,le.avelength_top5_paid_slope_0t6,le.avelength_top5_paid_volatility_0t12,le.avelength_top5_paid_volatility_0t6,le.avelength_top5_spend_monthspastleast_24,le.avelength_top5_spend_monthspastmost_24,le.avelength_top5_spend_slope_0t12,le.avelength_top5_spend_slope_0t24,le.avelength_top5_spend_slope_0t6,le.avelength_top5_spend_sum_12,le.avelength_top5_spend_volatility_0t6,le.avelength_top5_spend_volatility_6t12,le.avelength_total_numrel_avg12,le.avelength_total_numrel_monthpspastmost_24,le.avelength_total_numrel_monthspastleast_24,le.avelength_total_numrel_slope_0t12,le.avelength_total_numrel_slope_0t24,le.avelength_total_numrel_slope_0t6,le.avelength_total_numrel_slope_6t12,le.avelength_total_numrel_var_0t12,le.avelength_total_numrel_var_0t24,le.avelength_total_numrel_var_12t24,le.avelength_total_numrel_var_6t18,le.avelength_mfgmat_numrel_avg12,le.avelength_mfgmat_numrel_slope_0t12,le.avelength_mfgmat_numrel_slope_0t24,le.avelength_mfgmat_numrel_slope_0t6,le.avelength_mfgmat_numrel_slope_6t12,le.avelength_mfgmat_numrel_var_0t12,le.avelength_mfgmat_numrel_var_12t24,le.avelength_ops_numrel_avg12,le.avelength_ops_numrel_slope_0t12,le.avelength_ops_numrel_slope_0t24,le.avelength_ops_numrel_slope_0t6,le.avelength_ops_numrel_slope_6t12,le.avelength_ops_numrel_var_0t12,le.avelength_ops_numrel_var_12t24,le.avelength_fleet_numrel_avg12,le.avelength_fleet_numrel_slope_0t12,le.avelength_fleet_numrel_slope_0t24,le.avelength_fleet_numrel_slope_0t6,le.avelength_fleet_numrel_slope_6t12,le.avelength_fleet_numrel_var_0t12,le.avelength_fleet_numrel_var_12t24,le.avelength_carrier_numrel_avg12,le.avelength_carrier_numrel_slope_0t12,le.avelength_carrier_numrel_slope_0t24,le.avelength_carrier_numrel_slope_0t6,le.avelength_carrier_numrel_slope_6t12,le.avelength_carrier_numrel_var_0t12,le.avelength_carrier_numrel_var_12t24,le.avelength_bldgmats_numrel_avg12,le.avelength_bldgmats_numrel_slope_0t12,le.avelength_bldgmats_numrel_slope_0t24,le.avelength_bldgmats_numrel_slope_0t6,le.avelength_bldgmats_numrel_slope_6t12,le.avelength_bldgmats_numrel_var_0t12,le.avelength_bldgmats_numrel_var_12t24,le.avelength_total_monthsoutstanding_slope24,le.avelength_total_percprov30_avg_0t12,le.avelength_total_percprov30_slope_0t12,le.avelength_total_percprov30_slope_0t24,le.avelength_total_percprov30_slope_0t6,le.avelength_total_percprov30_slope_6t12,le.avelength_total_percprov60_avg_0t12,le.avelength_total_percprov60_slope_0t12,le.avelength_total_percprov60_slope_0t24,le.avelength_total_percprov60_slope_0t6,le.avelength_total_percprov60_slope_6t12,le.avelength_total_percprov90_avg_0t12,le.avelength_total_percprov90_lowerlim_0t12,le.avelength_total_percprov90_slope_0t24,le.avelength_total_percprov90_slope_0t6,le.avelength_total_percprov90_slope_6t12,le.avelength_total_percprovoutstanding_adjustedslope_0t12,le.avelength_mfgmat_monthsoutstanding_slope24,le.avelength_mfgmat_percprov30_slope_0t12,le.avelength_mfgmat_percprov30_slope_6t12,le.avelength_mfgmat_percprov60_slope_0t12,le.avelength_mfgmat_percprov60_slope_6t12,le.avelength_mfgmat_percprov90_slope_0t24,le.avelength_mfgmat_percprov90_slope_0t6,le.avelength_mfgmat_percprov90_slope_6t12,le.avelength_mfgmat_percprovoutstanding_adjustedslope_0t12,le.avelength_ops_monthsoutstanding_slope24,le.avelength_ops_percprov30_slope_0t12,le.avelength_ops_percprov30_slope_6t12,le.avelength_ops_percprov60_slope_0t12,le.avelength_ops_percprov60_slope_6t12,le.avelength_ops_percprov90_slope_0t24,le.avelength_ops_percprov90_slope_0t6,le.avelength_ops_percprov90_slope_6t12,le.avelength_ops_percprovoutstanding_adjustedslope_0t12,le.avelength_fleet_monthsoutstanding_slope24,le.avelength_fleet_percprov30_slope_0t12,le.avelength_fleet_percprov30_slope_6t12,le.avelength_fleet_percprov60_slope_0t12,le.avelength_fleet_percprov60_slope_6t12,le.avelength_fleet_percprov90_slope_0t24,le.avelength_fleet_percprov90_slope_0t6,le.avelength_fleet_percprov90_slope_6t12,le.avelength_fleet_percprovoutstanding_adjustedslope_0t12,le.avelength_carrier_monthsoutstanding_slope24,le.avelength_carrier_percprov30_slope_0t12,le.avelength_carrier_percprov30_slope_6t12,le.avelength_carrier_percprov60_slope_0t12,le.avelength_carrier_percprov60_slope_6t12,le.avelength_carrier_percprov90_slope_0t24,le.avelength_carrier_percprov90_slope_0t6,le.avelength_carrier_percprov90_slope_6t12,le.avelength_carrier_percprovoutstanding_adjustedslope_0t12,le.avelength_bldgmats_monthsoutstanding_slope24,le.avelength_bldgmats_percprov30_slope_0t12,le.avelength_bldgmats_percprov30_slope_6t12,le.avelength_bldgmats_percprov60_slope_0t12,le.avelength_bldgmats_percprov60_slope_6t12,le.avelength_bldgmats_percprov90_slope_0t24,le.avelength_bldgmats_percprov90_slope_0t6,le.avelength_bldgmats_percprov90_slope_6t12,le.avelength_bldgmats_percprovoutstanding_adjustedslope_0t12,le.avelength_top5_monthsoutstanding_slope24,le.avelength_top5_percprov30_slope_0t12,le.avelength_top5_percprov30_slope_6t12,le.avelength_top5_percprov60_slope_0t12,le.avelength_top5_percprov60_slope_6t12,le.avelength_top5_percprov90_slope_0t24,le.avelength_top5_percprov90_slope_0t6,le.avelength_top5_percprov90_slope_6t12,le.avelength_top5_percprovoutstanding_adjustedslope_0t12);
END;
EXPORT invSummary := NORMALIZE(summary0, 333, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.ultimate_linkid),TRIM((SALT311.StrType)le.cortera_score),TRIM((SALT311.StrType)le.cpr_score),TRIM((SALT311.StrType)le.cpr_segment),TRIM((SALT311.StrType)le.dbt),TRIM((SALT311.StrType)le.avg_bal),TRIM((SALT311.StrType)le.air_spend),TRIM((SALT311.StrType)le.fuel_spend),TRIM((SALT311.StrType)le.leasing_spend),TRIM((SALT311.StrType)le.ltl_spend),TRIM((SALT311.StrType)le.rail_spend),TRIM((SALT311.StrType)le.tl_spend),TRIM((SALT311.StrType)le.transvc_spend),TRIM((SALT311.StrType)le.transup_spend),TRIM((SALT311.StrType)le.bst_spend),TRIM((SALT311.StrType)le.dg_spend),TRIM((SALT311.StrType)le.electrical_spend),TRIM((SALT311.StrType)le.hvac_spend),TRIM((SALT311.StrType)le.other_b_spend),TRIM((SALT311.StrType)le.plumbing_spend),TRIM((SALT311.StrType)le.rs_spend),TRIM((SALT311.StrType)le.wp_spend),TRIM((SALT311.StrType)le.chemical_spend),TRIM((SALT311.StrType)le.electronic_spend),TRIM((SALT311.StrType)le.metal_spend),TRIM((SALT311.StrType)le.other_m_spend),TRIM((SALT311.StrType)le.packaging_spend),TRIM((SALT311.StrType)le.pvf_spend),TRIM((SALT311.StrType)le.plastic_spend),TRIM((SALT311.StrType)le.textile_spend),TRIM((SALT311.StrType)le.bs_spend),TRIM((SALT311.StrType)le.ce_spend),TRIM((SALT311.StrType)le.hardware_spend),TRIM((SALT311.StrType)le.ie_spend),TRIM((SALT311.StrType)le.is_spend),TRIM((SALT311.StrType)le.it_spend),TRIM((SALT311.StrType)le.mls_spend),TRIM((SALT311.StrType)le.os_spend),TRIM((SALT311.StrType)le.pp_spend),TRIM((SALT311.StrType)le.sis_spend),TRIM((SALT311.StrType)le.apparel_spend),TRIM((SALT311.StrType)le.beverages_spend),TRIM((SALT311.StrType)le.constr_spend),TRIM((SALT311.StrType)le.consulting_spend),TRIM((SALT311.StrType)le.fs_spend),TRIM((SALT311.StrType)le.fp_spend),TRIM((SALT311.StrType)le.insurance_spend),TRIM((SALT311.StrType)le.ls_spend),TRIM((SALT311.StrType)le.oil_gas_spend),TRIM((SALT311.StrType)le.utilities_spend),TRIM((SALT311.StrType)le.other_spend),TRIM((SALT311.StrType)le.advt_spend),TRIM((SALT311.StrType)le.air_growth),TRIM((SALT311.StrType)le.fuel_growth),TRIM((SALT311.StrType)le.leasing_growth),TRIM((SALT311.StrType)le.ltl_growth),TRIM((SALT311.StrType)le.rail_growth),TRIM((SALT311.StrType)le.tl_growth),TRIM((SALT311.StrType)le.transvc_growth),TRIM((SALT311.StrType)le.transup_growth),TRIM((SALT311.StrType)le.bst_growth),TRIM((SALT311.StrType)le.dg_growth),TRIM((SALT311.StrType)le.electrical_growth),TRIM((SALT311.StrType)le.hvac_growth),TRIM((SALT311.StrType)le.other_b_growth),TRIM((SALT311.StrType)le.plumbing_growth),TRIM((SALT311.StrType)le.rs_growth),TRIM((SALT311.StrType)le.wp_growth),TRIM((SALT311.StrType)le.chemical_growth),TRIM((SALT311.StrType)le.electronic_growth),TRIM((SALT311.StrType)le.metal_growth),TRIM((SALT311.StrType)le.other_m_growth),TRIM((SALT311.StrType)le.packaging_growth),TRIM((SALT311.StrType)le.pvf_growth),TRIM((SALT311.StrType)le.plastic_growth),TRIM((SALT311.StrType)le.textile_growth),TRIM((SALT311.StrType)le.bs_growth),TRIM((SALT311.StrType)le.ce_growth),TRIM((SALT311.StrType)le.hardware_growth),TRIM((SALT311.StrType)le.ie_growth),TRIM((SALT311.StrType)le.is_growth),TRIM((SALT311.StrType)le.it_growth),TRIM((SALT311.StrType)le.mls_growth),TRIM((SALT311.StrType)le.os_growth),TRIM((SALT311.StrType)le.pp_growth),TRIM((SALT311.StrType)le.sis_growth),TRIM((SALT311.StrType)le.apparel_growth),TRIM((SALT311.StrType)le.beverages_growth),TRIM((SALT311.StrType)le.constr_growth),TRIM((SALT311.StrType)le.consulting_growth),TRIM((SALT311.StrType)le.fs_growth),TRIM((SALT311.StrType)le.fp_growth),TRIM((SALT311.StrType)le.insurance_growth),TRIM((SALT311.StrType)le.ls_growth),TRIM((SALT311.StrType)le.oil_gas_growth),TRIM((SALT311.StrType)le.utilities_growth),TRIM((SALT311.StrType)le.other_growth),TRIM((SALT311.StrType)le.advt_growth),TRIM((SALT311.StrType)le.top5_growth),TRIM((SALT311.StrType)le.shipping_y1),TRIM((SALT311.StrType)le.shipping_growth),TRIM((SALT311.StrType)le.materials_y1),TRIM((SALT311.StrType)le.materials_growth),TRIM((SALT311.StrType)le.operations_y1),TRIM((SALT311.StrType)le.operations_growth),TRIM((SALT311.StrType)le.total_paid_average_0t12),TRIM((SALT311.StrType)le.total_paid_monthspastworst_24),TRIM((SALT311.StrType)le.total_paid_slope_0t12),TRIM((SALT311.StrType)le.total_paid_slope_0t6),TRIM((SALT311.StrType)le.total_paid_slope_6t12),TRIM((SALT311.StrType)le.total_paid_slope_6t18),TRIM((SALT311.StrType)le.total_paid_volatility_0t12),TRIM((SALT311.StrType)le.total_paid_volatility_0t6),TRIM((SALT311.StrType)le.total_paid_volatility_12t18),TRIM((SALT311.StrType)le.total_paid_volatility_6t12),TRIM((SALT311.StrType)le.total_spend_monthspastleast_24),TRIM((SALT311.StrType)le.total_spend_monthspastmost_24),TRIM((SALT311.StrType)le.total_spend_slope_0t12),TRIM((SALT311.StrType)le.total_spend_slope_0t24),TRIM((SALT311.StrType)le.total_spend_slope_0t6),TRIM((SALT311.StrType)le.total_spend_slope_6t12),TRIM((SALT311.StrType)le.total_spend_sum_12),TRIM((SALT311.StrType)le.total_spend_volatility_0t12),TRIM((SALT311.StrType)le.total_spend_volatility_0t6),TRIM((SALT311.StrType)le.total_spend_volatility_12t18),TRIM((SALT311.StrType)le.total_spend_volatility_6t12),TRIM((SALT311.StrType)le.mfgmat_paid_average_12),TRIM((SALT311.StrType)le.mfgmat_paid_monthspastworst_24),TRIM((SALT311.StrType)le.mfgmat_paid_slope_0t12),TRIM((SALT311.StrType)le.mfgmat_paid_slope_0t24),TRIM((SALT311.StrType)le.mfgmat_paid_slope_0t6),TRIM((SALT311.StrType)le.mfgmat_paid_volatility_0t12),TRIM((SALT311.StrType)le.mfgmat_paid_volatility_0t6),TRIM((SALT311.StrType)le.mfgmat_spend_monthspastleast_24),TRIM((SALT311.StrType)le.mfgmat_spend_monthspastmost_24),TRIM((SALT311.StrType)le.mfgmat_spend_slope_0t12),TRIM((SALT311.StrType)le.mfgmat_spend_slope_0t24),TRIM((SALT311.StrType)le.mfgmat_spend_slope_0t6),TRIM((SALT311.StrType)le.mfgmat_spend_sum_12),TRIM((SALT311.StrType)le.mfgmat_spend_volatility_0t6),TRIM((SALT311.StrType)le.mfgmat_spend_volatility_6t12),TRIM((SALT311.StrType)le.ops_paid_average_12),TRIM((SALT311.StrType)le.ops_paid_monthspastworst_24),TRIM((SALT311.StrType)le.ops_paid_slope_0t12),TRIM((SALT311.StrType)le.ops_paid_slope_0t24),TRIM((SALT311.StrType)le.ops_paid_slope_0t6),TRIM((SALT311.StrType)le.ops_paid_volatility_0t12),TRIM((SALT311.StrType)le.ops_paid_volatility_0t6),TRIM((SALT311.StrType)le.ops_spend_monthspastleast_24),TRIM((SALT311.StrType)le.ops_spend_monthspastmost_24),TRIM((SALT311.StrType)le.ops_spend_slope_0t12),TRIM((SALT311.StrType)le.ops_spend_slope_0t24),TRIM((SALT311.StrType)le.ops_spend_slope_0t6),TRIM((SALT311.StrType)le.ops_spend_sum_12),TRIM((SALT311.StrType)le.ops_spend_volatility_0t6),TRIM((SALT311.StrType)le.ops_spend_volatility_6t12),TRIM((SALT311.StrType)le.fleet_paid_average_12),TRIM((SALT311.StrType)le.fleet_paid_monthspastworst_24),TRIM((SALT311.StrType)le.fleet_paid_slope_0t12),TRIM((SALT311.StrType)le.fleet_paid_slope_0t24),TRIM((SALT311.StrType)le.fleet_paid_slope_0t6),TRIM((SALT311.StrType)le.fleet_paid_volatility_0t12),TRIM((SALT311.StrType)le.fleet_paid_volatility_0t6),TRIM((SALT311.StrType)le.fleet_spend_monthspastleast_24),TRIM((SALT311.StrType)le.fleet_spend_monthspastmost_24),TRIM((SALT311.StrType)le.fleet_spend_slope_0t12),TRIM((SALT311.StrType)le.fleet_spend_slope_0t24),TRIM((SALT311.StrType)le.fleet_spend_slope_0t6),TRIM((SALT311.StrType)le.fleet_spend_sum_12),TRIM((SALT311.StrType)le.fleet_spend_volatility_0t6),TRIM((SALT311.StrType)le.fleet_spend_volatility_6t12),TRIM((SALT311.StrType)le.carrier_paid_average_12),TRIM((SALT311.StrType)le.carrier_paid_monthspastworst_24),TRIM((SALT311.StrType)le.carrier_paid_slope_0t12),TRIM((SALT311.StrType)le.carrier_paid_slope_0t24),TRIM((SALT311.StrType)le.carrier_paid_slope_0t6),TRIM((SALT311.StrType)le.carrier_paid_volatility_0t12),TRIM((SALT311.StrType)le.carrier_paid_volatility_0t6),TRIM((SALT311.StrType)le.carrier_spend_monthspastleast_24),TRIM((SALT311.StrType)le.carrier_spend_monthspastmost_24),TRIM((SALT311.StrType)le.carrier_spend_slope_0t12),TRIM((SALT311.StrType)le.carrier_spend_slope_0t24),TRIM((SALT311.StrType)le.carrier_spend_slope_0t6),TRIM((SALT311.StrType)le.carrier_spend_sum_12),TRIM((SALT311.StrType)le.carrier_spend_volatility_0t6),TRIM((SALT311.StrType)le.carrier_spend_volatility_6t12),TRIM((SALT311.StrType)le.bldgmats_paid_average_12),TRIM((SALT311.StrType)le.bldgmats_paid_monthspastworst_24),TRIM((SALT311.StrType)le.bldgmats_paid_slope_0t12),TRIM((SALT311.StrType)le.bldgmats_paid_slope_0t24),TRIM((SALT311.StrType)le.bldgmats_paid_slope_0t6),TRIM((SALT311.StrType)le.bldgmats_paid_volatility_0t12),TRIM((SALT311.StrType)le.bldgmats_paid_volatility_0t6),TRIM((SALT311.StrType)le.bldgmats_spend_monthspastleast_24),TRIM((SALT311.StrType)le.bldgmats_spend_monthspastmost_24),TRIM((SALT311.StrType)le.bldgmats_spend_slope_0t12),TRIM((SALT311.StrType)le.bldgmats_spend_slope_0t24),TRIM((SALT311.StrType)le.bldgmats_spend_slope_0t6),TRIM((SALT311.StrType)le.bldgmats_spend_sum_12),TRIM((SALT311.StrType)le.bldgmats_spend_volatility_0t6),TRIM((SALT311.StrType)le.bldgmats_spend_volatility_6t12),TRIM((SALT311.StrType)le.top5_paid_average_12),TRIM((SALT311.StrType)le.top5_paid_monthspastworst_24),TRIM((SALT311.StrType)le.top5_paid_slope_0t12),TRIM((SALT311.StrType)le.top5_paid_slope_0t24),TRIM((SALT311.StrType)le.top5_paid_slope_0t6),TRIM((SALT311.StrType)le.top5_paid_volatility_0t12),TRIM((SALT311.StrType)le.top5_paid_volatility_0t6),TRIM((SALT311.StrType)le.top5_spend_monthspastleast_24),TRIM((SALT311.StrType)le.top5_spend_monthspastmost_24),TRIM((SALT311.StrType)le.top5_spend_slope_0t12),TRIM((SALT311.StrType)le.top5_spend_slope_0t24),TRIM((SALT311.StrType)le.top5_spend_slope_0t6),TRIM((SALT311.StrType)le.top5_spend_sum_12),TRIM((SALT311.StrType)le.top5_spend_volatility_0t6),TRIM((SALT311.StrType)le.top5_spend_volatility_6t12),TRIM((SALT311.StrType)le.total_numrel_avg12),TRIM((SALT311.StrType)le.total_numrel_monthpspastmost_24),TRIM((SALT311.StrType)le.total_numrel_monthspastleast_24),TRIM((SALT311.StrType)le.total_numrel_slope_0t12),TRIM((SALT311.StrType)le.total_numrel_slope_0t24),TRIM((SALT311.StrType)le.total_numrel_slope_0t6),TRIM((SALT311.StrType)le.total_numrel_slope_6t12),TRIM((SALT311.StrType)le.total_numrel_var_0t12),TRIM((SALT311.StrType)le.total_numrel_var_0t24),TRIM((SALT311.StrType)le.total_numrel_var_12t24),TRIM((SALT311.StrType)le.total_numrel_var_6t18),TRIM((SALT311.StrType)le.mfgmat_numrel_avg12),TRIM((SALT311.StrType)le.mfgmat_numrel_slope_0t12),TRIM((SALT311.StrType)le.mfgmat_numrel_slope_0t24),TRIM((SALT311.StrType)le.mfgmat_numrel_slope_0t6),TRIM((SALT311.StrType)le.mfgmat_numrel_slope_6t12),TRIM((SALT311.StrType)le.mfgmat_numrel_var_0t12),TRIM((SALT311.StrType)le.mfgmat_numrel_var_12t24),TRIM((SALT311.StrType)le.ops_numrel_avg12),TRIM((SALT311.StrType)le.ops_numrel_slope_0t12),TRIM((SALT311.StrType)le.ops_numrel_slope_0t24),TRIM((SALT311.StrType)le.ops_numrel_slope_0t6),TRIM((SALT311.StrType)le.ops_numrel_slope_6t12),TRIM((SALT311.StrType)le.ops_numrel_var_0t12),TRIM((SALT311.StrType)le.ops_numrel_var_12t24),TRIM((SALT311.StrType)le.fleet_numrel_avg12),TRIM((SALT311.StrType)le.fleet_numrel_slope_0t12),TRIM((SALT311.StrType)le.fleet_numrel_slope_0t24),TRIM((SALT311.StrType)le.fleet_numrel_slope_0t6),TRIM((SALT311.StrType)le.fleet_numrel_slope_6t12),TRIM((SALT311.StrType)le.fleet_numrel_var_0t12),TRIM((SALT311.StrType)le.fleet_numrel_var_12t24),TRIM((SALT311.StrType)le.carrier_numrel_avg12),TRIM((SALT311.StrType)le.carrier_numrel_slope_0t12),TRIM((SALT311.StrType)le.carrier_numrel_slope_0t24),TRIM((SALT311.StrType)le.carrier_numrel_slope_0t6),TRIM((SALT311.StrType)le.carrier_numrel_slope_6t12),TRIM((SALT311.StrType)le.carrier_numrel_var_0t12),TRIM((SALT311.StrType)le.carrier_numrel_var_12t24),TRIM((SALT311.StrType)le.bldgmats_numrel_avg12),TRIM((SALT311.StrType)le.bldgmats_numrel_slope_0t12),TRIM((SALT311.StrType)le.bldgmats_numrel_slope_0t24),TRIM((SALT311.StrType)le.bldgmats_numrel_slope_0t6),TRIM((SALT311.StrType)le.bldgmats_numrel_slope_6t12),TRIM((SALT311.StrType)le.bldgmats_numrel_var_0t12),TRIM((SALT311.StrType)le.bldgmats_numrel_var_12t24),TRIM((SALT311.StrType)le.total_monthsoutstanding_slope24),TRIM((SALT311.StrType)le.total_percprov30_avg_0t12),TRIM((SALT311.StrType)le.total_percprov30_slope_0t12),TRIM((SALT311.StrType)le.total_percprov30_slope_0t24),TRIM((SALT311.StrType)le.total_percprov30_slope_0t6),TRIM((SALT311.StrType)le.total_percprov30_slope_6t12),TRIM((SALT311.StrType)le.total_percprov60_avg_0t12),TRIM((SALT311.StrType)le.total_percprov60_slope_0t12),TRIM((SALT311.StrType)le.total_percprov60_slope_0t24),TRIM((SALT311.StrType)le.total_percprov60_slope_0t6),TRIM((SALT311.StrType)le.total_percprov60_slope_6t12),TRIM((SALT311.StrType)le.total_percprov90_avg_0t12),TRIM((SALT311.StrType)le.total_percprov90_lowerlim_0t12),TRIM((SALT311.StrType)le.total_percprov90_slope_0t24),TRIM((SALT311.StrType)le.total_percprov90_slope_0t6),TRIM((SALT311.StrType)le.total_percprov90_slope_6t12),TRIM((SALT311.StrType)le.total_percprovoutstanding_adjustedslope_0t12),TRIM((SALT311.StrType)le.mfgmat_monthsoutstanding_slope24),TRIM((SALT311.StrType)le.mfgmat_percprov30_slope_0t12),TRIM((SALT311.StrType)le.mfgmat_percprov30_slope_6t12),TRIM((SALT311.StrType)le.mfgmat_percprov60_slope_0t12),TRIM((SALT311.StrType)le.mfgmat_percprov60_slope_6t12),TRIM((SALT311.StrType)le.mfgmat_percprov90_slope_0t24),TRIM((SALT311.StrType)le.mfgmat_percprov90_slope_0t6),TRIM((SALT311.StrType)le.mfgmat_percprov90_slope_6t12),TRIM((SALT311.StrType)le.mfgmat_percprovoutstanding_adjustedslope_0t12),TRIM((SALT311.StrType)le.ops_monthsoutstanding_slope24),TRIM((SALT311.StrType)le.ops_percprov30_slope_0t12),TRIM((SALT311.StrType)le.ops_percprov30_slope_6t12),TRIM((SALT311.StrType)le.ops_percprov60_slope_0t12),TRIM((SALT311.StrType)le.ops_percprov60_slope_6t12),TRIM((SALT311.StrType)le.ops_percprov90_slope_0t24),TRIM((SALT311.StrType)le.ops_percprov90_slope_0t6),TRIM((SALT311.StrType)le.ops_percprov90_slope_6t12),TRIM((SALT311.StrType)le.ops_percprovoutstanding_adjustedslope_0t12),TRIM((SALT311.StrType)le.fleet_monthsoutstanding_slope24),TRIM((SALT311.StrType)le.fleet_percprov30_slope_0t12),TRIM((SALT311.StrType)le.fleet_percprov30_slope_6t12),TRIM((SALT311.StrType)le.fleet_percprov60_slope_0t12),TRIM((SALT311.StrType)le.fleet_percprov60_slope_6t12),TRIM((SALT311.StrType)le.fleet_percprov90_slope_0t24),TRIM((SALT311.StrType)le.fleet_percprov90_slope_0t6),TRIM((SALT311.StrType)le.fleet_percprov90_slope_6t12),TRIM((SALT311.StrType)le.fleet_percprovoutstanding_adjustedslope_0t12),TRIM((SALT311.StrType)le.carrier_monthsoutstanding_slope24),TRIM((SALT311.StrType)le.carrier_percprov30_slope_0t12),TRIM((SALT311.StrType)le.carrier_percprov30_slope_6t12),TRIM((SALT311.StrType)le.carrier_percprov60_slope_0t12),TRIM((SALT311.StrType)le.carrier_percprov60_slope_6t12),TRIM((SALT311.StrType)le.carrier_percprov90_slope_0t24),TRIM((SALT311.StrType)le.carrier_percprov90_slope_0t6),TRIM((SALT311.StrType)le.carrier_percprov90_slope_6t12),TRIM((SALT311.StrType)le.carrier_percprovoutstanding_adjustedslope_0t12),TRIM((SALT311.StrType)le.bldgmats_monthsoutstanding_slope24),TRIM((SALT311.StrType)le.bldgmats_percprov30_slope_0t12),TRIM((SALT311.StrType)le.bldgmats_percprov30_slope_6t12),TRIM((SALT311.StrType)le.bldgmats_percprov60_slope_0t12),TRIM((SALT311.StrType)le.bldgmats_percprov60_slope_6t12),TRIM((SALT311.StrType)le.bldgmats_percprov90_slope_0t24),TRIM((SALT311.StrType)le.bldgmats_percprov90_slope_0t6),TRIM((SALT311.StrType)le.bldgmats_percprov90_slope_6t12),TRIM((SALT311.StrType)le.bldgmats_percprovoutstanding_adjustedslope_0t12),TRIM((SALT311.StrType)le.top5_monthsoutstanding_slope24),TRIM((SALT311.StrType)le.top5_percprov30_slope_0t12),TRIM((SALT311.StrType)le.top5_percprov30_slope_6t12),TRIM((SALT311.StrType)le.top5_percprov60_slope_0t12),TRIM((SALT311.StrType)le.top5_percprov60_slope_6t12),TRIM((SALT311.StrType)le.top5_percprov90_slope_0t24),TRIM((SALT311.StrType)le.top5_percprov90_slope_0t6),TRIM((SALT311.StrType)le.top5_percprov90_slope_6t12),TRIM((SALT311.StrType)le.top5_percprovoutstanding_adjustedslope_0t12)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,333,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 333);
  SELF.FldNo2 := 1 + (C % 333);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.ultimate_linkid),TRIM((SALT311.StrType)le.cortera_score),TRIM((SALT311.StrType)le.cpr_score),TRIM((SALT311.StrType)le.cpr_segment),TRIM((SALT311.StrType)le.dbt),TRIM((SALT311.StrType)le.avg_bal),TRIM((SALT311.StrType)le.air_spend),TRIM((SALT311.StrType)le.fuel_spend),TRIM((SALT311.StrType)le.leasing_spend),TRIM((SALT311.StrType)le.ltl_spend),TRIM((SALT311.StrType)le.rail_spend),TRIM((SALT311.StrType)le.tl_spend),TRIM((SALT311.StrType)le.transvc_spend),TRIM((SALT311.StrType)le.transup_spend),TRIM((SALT311.StrType)le.bst_spend),TRIM((SALT311.StrType)le.dg_spend),TRIM((SALT311.StrType)le.electrical_spend),TRIM((SALT311.StrType)le.hvac_spend),TRIM((SALT311.StrType)le.other_b_spend),TRIM((SALT311.StrType)le.plumbing_spend),TRIM((SALT311.StrType)le.rs_spend),TRIM((SALT311.StrType)le.wp_spend),TRIM((SALT311.StrType)le.chemical_spend),TRIM((SALT311.StrType)le.electronic_spend),TRIM((SALT311.StrType)le.metal_spend),TRIM((SALT311.StrType)le.other_m_spend),TRIM((SALT311.StrType)le.packaging_spend),TRIM((SALT311.StrType)le.pvf_spend),TRIM((SALT311.StrType)le.plastic_spend),TRIM((SALT311.StrType)le.textile_spend),TRIM((SALT311.StrType)le.bs_spend),TRIM((SALT311.StrType)le.ce_spend),TRIM((SALT311.StrType)le.hardware_spend),TRIM((SALT311.StrType)le.ie_spend),TRIM((SALT311.StrType)le.is_spend),TRIM((SALT311.StrType)le.it_spend),TRIM((SALT311.StrType)le.mls_spend),TRIM((SALT311.StrType)le.os_spend),TRIM((SALT311.StrType)le.pp_spend),TRIM((SALT311.StrType)le.sis_spend),TRIM((SALT311.StrType)le.apparel_spend),TRIM((SALT311.StrType)le.beverages_spend),TRIM((SALT311.StrType)le.constr_spend),TRIM((SALT311.StrType)le.consulting_spend),TRIM((SALT311.StrType)le.fs_spend),TRIM((SALT311.StrType)le.fp_spend),TRIM((SALT311.StrType)le.insurance_spend),TRIM((SALT311.StrType)le.ls_spend),TRIM((SALT311.StrType)le.oil_gas_spend),TRIM((SALT311.StrType)le.utilities_spend),TRIM((SALT311.StrType)le.other_spend),TRIM((SALT311.StrType)le.advt_spend),TRIM((SALT311.StrType)le.air_growth),TRIM((SALT311.StrType)le.fuel_growth),TRIM((SALT311.StrType)le.leasing_growth),TRIM((SALT311.StrType)le.ltl_growth),TRIM((SALT311.StrType)le.rail_growth),TRIM((SALT311.StrType)le.tl_growth),TRIM((SALT311.StrType)le.transvc_growth),TRIM((SALT311.StrType)le.transup_growth),TRIM((SALT311.StrType)le.bst_growth),TRIM((SALT311.StrType)le.dg_growth),TRIM((SALT311.StrType)le.electrical_growth),TRIM((SALT311.StrType)le.hvac_growth),TRIM((SALT311.StrType)le.other_b_growth),TRIM((SALT311.StrType)le.plumbing_growth),TRIM((SALT311.StrType)le.rs_growth),TRIM((SALT311.StrType)le.wp_growth),TRIM((SALT311.StrType)le.chemical_growth),TRIM((SALT311.StrType)le.electronic_growth),TRIM((SALT311.StrType)le.metal_growth),TRIM((SALT311.StrType)le.other_m_growth),TRIM((SALT311.StrType)le.packaging_growth),TRIM((SALT311.StrType)le.pvf_growth),TRIM((SALT311.StrType)le.plastic_growth),TRIM((SALT311.StrType)le.textile_growth),TRIM((SALT311.StrType)le.bs_growth),TRIM((SALT311.StrType)le.ce_growth),TRIM((SALT311.StrType)le.hardware_growth),TRIM((SALT311.StrType)le.ie_growth),TRIM((SALT311.StrType)le.is_growth),TRIM((SALT311.StrType)le.it_growth),TRIM((SALT311.StrType)le.mls_growth),TRIM((SALT311.StrType)le.os_growth),TRIM((SALT311.StrType)le.pp_growth),TRIM((SALT311.StrType)le.sis_growth),TRIM((SALT311.StrType)le.apparel_growth),TRIM((SALT311.StrType)le.beverages_growth),TRIM((SALT311.StrType)le.constr_growth),TRIM((SALT311.StrType)le.consulting_growth),TRIM((SALT311.StrType)le.fs_growth),TRIM((SALT311.StrType)le.fp_growth),TRIM((SALT311.StrType)le.insurance_growth),TRIM((SALT311.StrType)le.ls_growth),TRIM((SALT311.StrType)le.oil_gas_growth),TRIM((SALT311.StrType)le.utilities_growth),TRIM((SALT311.StrType)le.other_growth),TRIM((SALT311.StrType)le.advt_growth),TRIM((SALT311.StrType)le.top5_growth),TRIM((SALT311.StrType)le.shipping_y1),TRIM((SALT311.StrType)le.shipping_growth),TRIM((SALT311.StrType)le.materials_y1),TRIM((SALT311.StrType)le.materials_growth),TRIM((SALT311.StrType)le.operations_y1),TRIM((SALT311.StrType)le.operations_growth),TRIM((SALT311.StrType)le.total_paid_average_0t12),TRIM((SALT311.StrType)le.total_paid_monthspastworst_24),TRIM((SALT311.StrType)le.total_paid_slope_0t12),TRIM((SALT311.StrType)le.total_paid_slope_0t6),TRIM((SALT311.StrType)le.total_paid_slope_6t12),TRIM((SALT311.StrType)le.total_paid_slope_6t18),TRIM((SALT311.StrType)le.total_paid_volatility_0t12),TRIM((SALT311.StrType)le.total_paid_volatility_0t6),TRIM((SALT311.StrType)le.total_paid_volatility_12t18),TRIM((SALT311.StrType)le.total_paid_volatility_6t12),TRIM((SALT311.StrType)le.total_spend_monthspastleast_24),TRIM((SALT311.StrType)le.total_spend_monthspastmost_24),TRIM((SALT311.StrType)le.total_spend_slope_0t12),TRIM((SALT311.StrType)le.total_spend_slope_0t24),TRIM((SALT311.StrType)le.total_spend_slope_0t6),TRIM((SALT311.StrType)le.total_spend_slope_6t12),TRIM((SALT311.StrType)le.total_spend_sum_12),TRIM((SALT311.StrType)le.total_spend_volatility_0t12),TRIM((SALT311.StrType)le.total_spend_volatility_0t6),TRIM((SALT311.StrType)le.total_spend_volatility_12t18),TRIM((SALT311.StrType)le.total_spend_volatility_6t12),TRIM((SALT311.StrType)le.mfgmat_paid_average_12),TRIM((SALT311.StrType)le.mfgmat_paid_monthspastworst_24),TRIM((SALT311.StrType)le.mfgmat_paid_slope_0t12),TRIM((SALT311.StrType)le.mfgmat_paid_slope_0t24),TRIM((SALT311.StrType)le.mfgmat_paid_slope_0t6),TRIM((SALT311.StrType)le.mfgmat_paid_volatility_0t12),TRIM((SALT311.StrType)le.mfgmat_paid_volatility_0t6),TRIM((SALT311.StrType)le.mfgmat_spend_monthspastleast_24),TRIM((SALT311.StrType)le.mfgmat_spend_monthspastmost_24),TRIM((SALT311.StrType)le.mfgmat_spend_slope_0t12),TRIM((SALT311.StrType)le.mfgmat_spend_slope_0t24),TRIM((SALT311.StrType)le.mfgmat_spend_slope_0t6),TRIM((SALT311.StrType)le.mfgmat_spend_sum_12),TRIM((SALT311.StrType)le.mfgmat_spend_volatility_0t6),TRIM((SALT311.StrType)le.mfgmat_spend_volatility_6t12),TRIM((SALT311.StrType)le.ops_paid_average_12),TRIM((SALT311.StrType)le.ops_paid_monthspastworst_24),TRIM((SALT311.StrType)le.ops_paid_slope_0t12),TRIM((SALT311.StrType)le.ops_paid_slope_0t24),TRIM((SALT311.StrType)le.ops_paid_slope_0t6),TRIM((SALT311.StrType)le.ops_paid_volatility_0t12),TRIM((SALT311.StrType)le.ops_paid_volatility_0t6),TRIM((SALT311.StrType)le.ops_spend_monthspastleast_24),TRIM((SALT311.StrType)le.ops_spend_monthspastmost_24),TRIM((SALT311.StrType)le.ops_spend_slope_0t12),TRIM((SALT311.StrType)le.ops_spend_slope_0t24),TRIM((SALT311.StrType)le.ops_spend_slope_0t6),TRIM((SALT311.StrType)le.ops_spend_sum_12),TRIM((SALT311.StrType)le.ops_spend_volatility_0t6),TRIM((SALT311.StrType)le.ops_spend_volatility_6t12),TRIM((SALT311.StrType)le.fleet_paid_average_12),TRIM((SALT311.StrType)le.fleet_paid_monthspastworst_24),TRIM((SALT311.StrType)le.fleet_paid_slope_0t12),TRIM((SALT311.StrType)le.fleet_paid_slope_0t24),TRIM((SALT311.StrType)le.fleet_paid_slope_0t6),TRIM((SALT311.StrType)le.fleet_paid_volatility_0t12),TRIM((SALT311.StrType)le.fleet_paid_volatility_0t6),TRIM((SALT311.StrType)le.fleet_spend_monthspastleast_24),TRIM((SALT311.StrType)le.fleet_spend_monthspastmost_24),TRIM((SALT311.StrType)le.fleet_spend_slope_0t12),TRIM((SALT311.StrType)le.fleet_spend_slope_0t24),TRIM((SALT311.StrType)le.fleet_spend_slope_0t6),TRIM((SALT311.StrType)le.fleet_spend_sum_12),TRIM((SALT311.StrType)le.fleet_spend_volatility_0t6),TRIM((SALT311.StrType)le.fleet_spend_volatility_6t12),TRIM((SALT311.StrType)le.carrier_paid_average_12),TRIM((SALT311.StrType)le.carrier_paid_monthspastworst_24),TRIM((SALT311.StrType)le.carrier_paid_slope_0t12),TRIM((SALT311.StrType)le.carrier_paid_slope_0t24),TRIM((SALT311.StrType)le.carrier_paid_slope_0t6),TRIM((SALT311.StrType)le.carrier_paid_volatility_0t12),TRIM((SALT311.StrType)le.carrier_paid_volatility_0t6),TRIM((SALT311.StrType)le.carrier_spend_monthspastleast_24),TRIM((SALT311.StrType)le.carrier_spend_monthspastmost_24),TRIM((SALT311.StrType)le.carrier_spend_slope_0t12),TRIM((SALT311.StrType)le.carrier_spend_slope_0t24),TRIM((SALT311.StrType)le.carrier_spend_slope_0t6),TRIM((SALT311.StrType)le.carrier_spend_sum_12),TRIM((SALT311.StrType)le.carrier_spend_volatility_0t6),TRIM((SALT311.StrType)le.carrier_spend_volatility_6t12),TRIM((SALT311.StrType)le.bldgmats_paid_average_12),TRIM((SALT311.StrType)le.bldgmats_paid_monthspastworst_24),TRIM((SALT311.StrType)le.bldgmats_paid_slope_0t12),TRIM((SALT311.StrType)le.bldgmats_paid_slope_0t24),TRIM((SALT311.StrType)le.bldgmats_paid_slope_0t6),TRIM((SALT311.StrType)le.bldgmats_paid_volatility_0t12),TRIM((SALT311.StrType)le.bldgmats_paid_volatility_0t6),TRIM((SALT311.StrType)le.bldgmats_spend_monthspastleast_24),TRIM((SALT311.StrType)le.bldgmats_spend_monthspastmost_24),TRIM((SALT311.StrType)le.bldgmats_spend_slope_0t12),TRIM((SALT311.StrType)le.bldgmats_spend_slope_0t24),TRIM((SALT311.StrType)le.bldgmats_spend_slope_0t6),TRIM((SALT311.StrType)le.bldgmats_spend_sum_12),TRIM((SALT311.StrType)le.bldgmats_spend_volatility_0t6),TRIM((SALT311.StrType)le.bldgmats_spend_volatility_6t12),TRIM((SALT311.StrType)le.top5_paid_average_12),TRIM((SALT311.StrType)le.top5_paid_monthspastworst_24),TRIM((SALT311.StrType)le.top5_paid_slope_0t12),TRIM((SALT311.StrType)le.top5_paid_slope_0t24),TRIM((SALT311.StrType)le.top5_paid_slope_0t6),TRIM((SALT311.StrType)le.top5_paid_volatility_0t12),TRIM((SALT311.StrType)le.top5_paid_volatility_0t6),TRIM((SALT311.StrType)le.top5_spend_monthspastleast_24),TRIM((SALT311.StrType)le.top5_spend_monthspastmost_24),TRIM((SALT311.StrType)le.top5_spend_slope_0t12),TRIM((SALT311.StrType)le.top5_spend_slope_0t24),TRIM((SALT311.StrType)le.top5_spend_slope_0t6),TRIM((SALT311.StrType)le.top5_spend_sum_12),TRIM((SALT311.StrType)le.top5_spend_volatility_0t6),TRIM((SALT311.StrType)le.top5_spend_volatility_6t12),TRIM((SALT311.StrType)le.total_numrel_avg12),TRIM((SALT311.StrType)le.total_numrel_monthpspastmost_24),TRIM((SALT311.StrType)le.total_numrel_monthspastleast_24),TRIM((SALT311.StrType)le.total_numrel_slope_0t12),TRIM((SALT311.StrType)le.total_numrel_slope_0t24),TRIM((SALT311.StrType)le.total_numrel_slope_0t6),TRIM((SALT311.StrType)le.total_numrel_slope_6t12),TRIM((SALT311.StrType)le.total_numrel_var_0t12),TRIM((SALT311.StrType)le.total_numrel_var_0t24),TRIM((SALT311.StrType)le.total_numrel_var_12t24),TRIM((SALT311.StrType)le.total_numrel_var_6t18),TRIM((SALT311.StrType)le.mfgmat_numrel_avg12),TRIM((SALT311.StrType)le.mfgmat_numrel_slope_0t12),TRIM((SALT311.StrType)le.mfgmat_numrel_slope_0t24),TRIM((SALT311.StrType)le.mfgmat_numrel_slope_0t6),TRIM((SALT311.StrType)le.mfgmat_numrel_slope_6t12),TRIM((SALT311.StrType)le.mfgmat_numrel_var_0t12),TRIM((SALT311.StrType)le.mfgmat_numrel_var_12t24),TRIM((SALT311.StrType)le.ops_numrel_avg12),TRIM((SALT311.StrType)le.ops_numrel_slope_0t12),TRIM((SALT311.StrType)le.ops_numrel_slope_0t24),TRIM((SALT311.StrType)le.ops_numrel_slope_0t6),TRIM((SALT311.StrType)le.ops_numrel_slope_6t12),TRIM((SALT311.StrType)le.ops_numrel_var_0t12),TRIM((SALT311.StrType)le.ops_numrel_var_12t24),TRIM((SALT311.StrType)le.fleet_numrel_avg12),TRIM((SALT311.StrType)le.fleet_numrel_slope_0t12),TRIM((SALT311.StrType)le.fleet_numrel_slope_0t24),TRIM((SALT311.StrType)le.fleet_numrel_slope_0t6),TRIM((SALT311.StrType)le.fleet_numrel_slope_6t12),TRIM((SALT311.StrType)le.fleet_numrel_var_0t12),TRIM((SALT311.StrType)le.fleet_numrel_var_12t24),TRIM((SALT311.StrType)le.carrier_numrel_avg12),TRIM((SALT311.StrType)le.carrier_numrel_slope_0t12),TRIM((SALT311.StrType)le.carrier_numrel_slope_0t24),TRIM((SALT311.StrType)le.carrier_numrel_slope_0t6),TRIM((SALT311.StrType)le.carrier_numrel_slope_6t12),TRIM((SALT311.StrType)le.carrier_numrel_var_0t12),TRIM((SALT311.StrType)le.carrier_numrel_var_12t24),TRIM((SALT311.StrType)le.bldgmats_numrel_avg12),TRIM((SALT311.StrType)le.bldgmats_numrel_slope_0t12),TRIM((SALT311.StrType)le.bldgmats_numrel_slope_0t24),TRIM((SALT311.StrType)le.bldgmats_numrel_slope_0t6),TRIM((SALT311.StrType)le.bldgmats_numrel_slope_6t12),TRIM((SALT311.StrType)le.bldgmats_numrel_var_0t12),TRIM((SALT311.StrType)le.bldgmats_numrel_var_12t24),TRIM((SALT311.StrType)le.total_monthsoutstanding_slope24),TRIM((SALT311.StrType)le.total_percprov30_avg_0t12),TRIM((SALT311.StrType)le.total_percprov30_slope_0t12),TRIM((SALT311.StrType)le.total_percprov30_slope_0t24),TRIM((SALT311.StrType)le.total_percprov30_slope_0t6),TRIM((SALT311.StrType)le.total_percprov30_slope_6t12),TRIM((SALT311.StrType)le.total_percprov60_avg_0t12),TRIM((SALT311.StrType)le.total_percprov60_slope_0t12),TRIM((SALT311.StrType)le.total_percprov60_slope_0t24),TRIM((SALT311.StrType)le.total_percprov60_slope_0t6),TRIM((SALT311.StrType)le.total_percprov60_slope_6t12),TRIM((SALT311.StrType)le.total_percprov90_avg_0t12),TRIM((SALT311.StrType)le.total_percprov90_lowerlim_0t12),TRIM((SALT311.StrType)le.total_percprov90_slope_0t24),TRIM((SALT311.StrType)le.total_percprov90_slope_0t6),TRIM((SALT311.StrType)le.total_percprov90_slope_6t12),TRIM((SALT311.StrType)le.total_percprovoutstanding_adjustedslope_0t12),TRIM((SALT311.StrType)le.mfgmat_monthsoutstanding_slope24),TRIM((SALT311.StrType)le.mfgmat_percprov30_slope_0t12),TRIM((SALT311.StrType)le.mfgmat_percprov30_slope_6t12),TRIM((SALT311.StrType)le.mfgmat_percprov60_slope_0t12),TRIM((SALT311.StrType)le.mfgmat_percprov60_slope_6t12),TRIM((SALT311.StrType)le.mfgmat_percprov90_slope_0t24),TRIM((SALT311.StrType)le.mfgmat_percprov90_slope_0t6),TRIM((SALT311.StrType)le.mfgmat_percprov90_slope_6t12),TRIM((SALT311.StrType)le.mfgmat_percprovoutstanding_adjustedslope_0t12),TRIM((SALT311.StrType)le.ops_monthsoutstanding_slope24),TRIM((SALT311.StrType)le.ops_percprov30_slope_0t12),TRIM((SALT311.StrType)le.ops_percprov30_slope_6t12),TRIM((SALT311.StrType)le.ops_percprov60_slope_0t12),TRIM((SALT311.StrType)le.ops_percprov60_slope_6t12),TRIM((SALT311.StrType)le.ops_percprov90_slope_0t24),TRIM((SALT311.StrType)le.ops_percprov90_slope_0t6),TRIM((SALT311.StrType)le.ops_percprov90_slope_6t12),TRIM((SALT311.StrType)le.ops_percprovoutstanding_adjustedslope_0t12),TRIM((SALT311.StrType)le.fleet_monthsoutstanding_slope24),TRIM((SALT311.StrType)le.fleet_percprov30_slope_0t12),TRIM((SALT311.StrType)le.fleet_percprov30_slope_6t12),TRIM((SALT311.StrType)le.fleet_percprov60_slope_0t12),TRIM((SALT311.StrType)le.fleet_percprov60_slope_6t12),TRIM((SALT311.StrType)le.fleet_percprov90_slope_0t24),TRIM((SALT311.StrType)le.fleet_percprov90_slope_0t6),TRIM((SALT311.StrType)le.fleet_percprov90_slope_6t12),TRIM((SALT311.StrType)le.fleet_percprovoutstanding_adjustedslope_0t12),TRIM((SALT311.StrType)le.carrier_monthsoutstanding_slope24),TRIM((SALT311.StrType)le.carrier_percprov30_slope_0t12),TRIM((SALT311.StrType)le.carrier_percprov30_slope_6t12),TRIM((SALT311.StrType)le.carrier_percprov60_slope_0t12),TRIM((SALT311.StrType)le.carrier_percprov60_slope_6t12),TRIM((SALT311.StrType)le.carrier_percprov90_slope_0t24),TRIM((SALT311.StrType)le.carrier_percprov90_slope_0t6),TRIM((SALT311.StrType)le.carrier_percprov90_slope_6t12),TRIM((SALT311.StrType)le.carrier_percprovoutstanding_adjustedslope_0t12),TRIM((SALT311.StrType)le.bldgmats_monthsoutstanding_slope24),TRIM((SALT311.StrType)le.bldgmats_percprov30_slope_0t12),TRIM((SALT311.StrType)le.bldgmats_percprov30_slope_6t12),TRIM((SALT311.StrType)le.bldgmats_percprov60_slope_0t12),TRIM((SALT311.StrType)le.bldgmats_percprov60_slope_6t12),TRIM((SALT311.StrType)le.bldgmats_percprov90_slope_0t24),TRIM((SALT311.StrType)le.bldgmats_percprov90_slope_0t6),TRIM((SALT311.StrType)le.bldgmats_percprov90_slope_6t12),TRIM((SALT311.StrType)le.bldgmats_percprovoutstanding_adjustedslope_0t12),TRIM((SALT311.StrType)le.top5_monthsoutstanding_slope24),TRIM((SALT311.StrType)le.top5_percprov30_slope_0t12),TRIM((SALT311.StrType)le.top5_percprov30_slope_6t12),TRIM((SALT311.StrType)le.top5_percprov60_slope_0t12),TRIM((SALT311.StrType)le.top5_percprov60_slope_6t12),TRIM((SALT311.StrType)le.top5_percprov90_slope_0t24),TRIM((SALT311.StrType)le.top5_percprov90_slope_0t6),TRIM((SALT311.StrType)le.top5_percprov90_slope_6t12),TRIM((SALT311.StrType)le.top5_percprovoutstanding_adjustedslope_0t12)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.ultimate_linkid),TRIM((SALT311.StrType)le.cortera_score),TRIM((SALT311.StrType)le.cpr_score),TRIM((SALT311.StrType)le.cpr_segment),TRIM((SALT311.StrType)le.dbt),TRIM((SALT311.StrType)le.avg_bal),TRIM((SALT311.StrType)le.air_spend),TRIM((SALT311.StrType)le.fuel_spend),TRIM((SALT311.StrType)le.leasing_spend),TRIM((SALT311.StrType)le.ltl_spend),TRIM((SALT311.StrType)le.rail_spend),TRIM((SALT311.StrType)le.tl_spend),TRIM((SALT311.StrType)le.transvc_spend),TRIM((SALT311.StrType)le.transup_spend),TRIM((SALT311.StrType)le.bst_spend),TRIM((SALT311.StrType)le.dg_spend),TRIM((SALT311.StrType)le.electrical_spend),TRIM((SALT311.StrType)le.hvac_spend),TRIM((SALT311.StrType)le.other_b_spend),TRIM((SALT311.StrType)le.plumbing_spend),TRIM((SALT311.StrType)le.rs_spend),TRIM((SALT311.StrType)le.wp_spend),TRIM((SALT311.StrType)le.chemical_spend),TRIM((SALT311.StrType)le.electronic_spend),TRIM((SALT311.StrType)le.metal_spend),TRIM((SALT311.StrType)le.other_m_spend),TRIM((SALT311.StrType)le.packaging_spend),TRIM((SALT311.StrType)le.pvf_spend),TRIM((SALT311.StrType)le.plastic_spend),TRIM((SALT311.StrType)le.textile_spend),TRIM((SALT311.StrType)le.bs_spend),TRIM((SALT311.StrType)le.ce_spend),TRIM((SALT311.StrType)le.hardware_spend),TRIM((SALT311.StrType)le.ie_spend),TRIM((SALT311.StrType)le.is_spend),TRIM((SALT311.StrType)le.it_spend),TRIM((SALT311.StrType)le.mls_spend),TRIM((SALT311.StrType)le.os_spend),TRIM((SALT311.StrType)le.pp_spend),TRIM((SALT311.StrType)le.sis_spend),TRIM((SALT311.StrType)le.apparel_spend),TRIM((SALT311.StrType)le.beverages_spend),TRIM((SALT311.StrType)le.constr_spend),TRIM((SALT311.StrType)le.consulting_spend),TRIM((SALT311.StrType)le.fs_spend),TRIM((SALT311.StrType)le.fp_spend),TRIM((SALT311.StrType)le.insurance_spend),TRIM((SALT311.StrType)le.ls_spend),TRIM((SALT311.StrType)le.oil_gas_spend),TRIM((SALT311.StrType)le.utilities_spend),TRIM((SALT311.StrType)le.other_spend),TRIM((SALT311.StrType)le.advt_spend),TRIM((SALT311.StrType)le.air_growth),TRIM((SALT311.StrType)le.fuel_growth),TRIM((SALT311.StrType)le.leasing_growth),TRIM((SALT311.StrType)le.ltl_growth),TRIM((SALT311.StrType)le.rail_growth),TRIM((SALT311.StrType)le.tl_growth),TRIM((SALT311.StrType)le.transvc_growth),TRIM((SALT311.StrType)le.transup_growth),TRIM((SALT311.StrType)le.bst_growth),TRIM((SALT311.StrType)le.dg_growth),TRIM((SALT311.StrType)le.electrical_growth),TRIM((SALT311.StrType)le.hvac_growth),TRIM((SALT311.StrType)le.other_b_growth),TRIM((SALT311.StrType)le.plumbing_growth),TRIM((SALT311.StrType)le.rs_growth),TRIM((SALT311.StrType)le.wp_growth),TRIM((SALT311.StrType)le.chemical_growth),TRIM((SALT311.StrType)le.electronic_growth),TRIM((SALT311.StrType)le.metal_growth),TRIM((SALT311.StrType)le.other_m_growth),TRIM((SALT311.StrType)le.packaging_growth),TRIM((SALT311.StrType)le.pvf_growth),TRIM((SALT311.StrType)le.plastic_growth),TRIM((SALT311.StrType)le.textile_growth),TRIM((SALT311.StrType)le.bs_growth),TRIM((SALT311.StrType)le.ce_growth),TRIM((SALT311.StrType)le.hardware_growth),TRIM((SALT311.StrType)le.ie_growth),TRIM((SALT311.StrType)le.is_growth),TRIM((SALT311.StrType)le.it_growth),TRIM((SALT311.StrType)le.mls_growth),TRIM((SALT311.StrType)le.os_growth),TRIM((SALT311.StrType)le.pp_growth),TRIM((SALT311.StrType)le.sis_growth),TRIM((SALT311.StrType)le.apparel_growth),TRIM((SALT311.StrType)le.beverages_growth),TRIM((SALT311.StrType)le.constr_growth),TRIM((SALT311.StrType)le.consulting_growth),TRIM((SALT311.StrType)le.fs_growth),TRIM((SALT311.StrType)le.fp_growth),TRIM((SALT311.StrType)le.insurance_growth),TRIM((SALT311.StrType)le.ls_growth),TRIM((SALT311.StrType)le.oil_gas_growth),TRIM((SALT311.StrType)le.utilities_growth),TRIM((SALT311.StrType)le.other_growth),TRIM((SALT311.StrType)le.advt_growth),TRIM((SALT311.StrType)le.top5_growth),TRIM((SALT311.StrType)le.shipping_y1),TRIM((SALT311.StrType)le.shipping_growth),TRIM((SALT311.StrType)le.materials_y1),TRIM((SALT311.StrType)le.materials_growth),TRIM((SALT311.StrType)le.operations_y1),TRIM((SALT311.StrType)le.operations_growth),TRIM((SALT311.StrType)le.total_paid_average_0t12),TRIM((SALT311.StrType)le.total_paid_monthspastworst_24),TRIM((SALT311.StrType)le.total_paid_slope_0t12),TRIM((SALT311.StrType)le.total_paid_slope_0t6),TRIM((SALT311.StrType)le.total_paid_slope_6t12),TRIM((SALT311.StrType)le.total_paid_slope_6t18),TRIM((SALT311.StrType)le.total_paid_volatility_0t12),TRIM((SALT311.StrType)le.total_paid_volatility_0t6),TRIM((SALT311.StrType)le.total_paid_volatility_12t18),TRIM((SALT311.StrType)le.total_paid_volatility_6t12),TRIM((SALT311.StrType)le.total_spend_monthspastleast_24),TRIM((SALT311.StrType)le.total_spend_monthspastmost_24),TRIM((SALT311.StrType)le.total_spend_slope_0t12),TRIM((SALT311.StrType)le.total_spend_slope_0t24),TRIM((SALT311.StrType)le.total_spend_slope_0t6),TRIM((SALT311.StrType)le.total_spend_slope_6t12),TRIM((SALT311.StrType)le.total_spend_sum_12),TRIM((SALT311.StrType)le.total_spend_volatility_0t12),TRIM((SALT311.StrType)le.total_spend_volatility_0t6),TRIM((SALT311.StrType)le.total_spend_volatility_12t18),TRIM((SALT311.StrType)le.total_spend_volatility_6t12),TRIM((SALT311.StrType)le.mfgmat_paid_average_12),TRIM((SALT311.StrType)le.mfgmat_paid_monthspastworst_24),TRIM((SALT311.StrType)le.mfgmat_paid_slope_0t12),TRIM((SALT311.StrType)le.mfgmat_paid_slope_0t24),TRIM((SALT311.StrType)le.mfgmat_paid_slope_0t6),TRIM((SALT311.StrType)le.mfgmat_paid_volatility_0t12),TRIM((SALT311.StrType)le.mfgmat_paid_volatility_0t6),TRIM((SALT311.StrType)le.mfgmat_spend_monthspastleast_24),TRIM((SALT311.StrType)le.mfgmat_spend_monthspastmost_24),TRIM((SALT311.StrType)le.mfgmat_spend_slope_0t12),TRIM((SALT311.StrType)le.mfgmat_spend_slope_0t24),TRIM((SALT311.StrType)le.mfgmat_spend_slope_0t6),TRIM((SALT311.StrType)le.mfgmat_spend_sum_12),TRIM((SALT311.StrType)le.mfgmat_spend_volatility_0t6),TRIM((SALT311.StrType)le.mfgmat_spend_volatility_6t12),TRIM((SALT311.StrType)le.ops_paid_average_12),TRIM((SALT311.StrType)le.ops_paid_monthspastworst_24),TRIM((SALT311.StrType)le.ops_paid_slope_0t12),TRIM((SALT311.StrType)le.ops_paid_slope_0t24),TRIM((SALT311.StrType)le.ops_paid_slope_0t6),TRIM((SALT311.StrType)le.ops_paid_volatility_0t12),TRIM((SALT311.StrType)le.ops_paid_volatility_0t6),TRIM((SALT311.StrType)le.ops_spend_monthspastleast_24),TRIM((SALT311.StrType)le.ops_spend_monthspastmost_24),TRIM((SALT311.StrType)le.ops_spend_slope_0t12),TRIM((SALT311.StrType)le.ops_spend_slope_0t24),TRIM((SALT311.StrType)le.ops_spend_slope_0t6),TRIM((SALT311.StrType)le.ops_spend_sum_12),TRIM((SALT311.StrType)le.ops_spend_volatility_0t6),TRIM((SALT311.StrType)le.ops_spend_volatility_6t12),TRIM((SALT311.StrType)le.fleet_paid_average_12),TRIM((SALT311.StrType)le.fleet_paid_monthspastworst_24),TRIM((SALT311.StrType)le.fleet_paid_slope_0t12),TRIM((SALT311.StrType)le.fleet_paid_slope_0t24),TRIM((SALT311.StrType)le.fleet_paid_slope_0t6),TRIM((SALT311.StrType)le.fleet_paid_volatility_0t12),TRIM((SALT311.StrType)le.fleet_paid_volatility_0t6),TRIM((SALT311.StrType)le.fleet_spend_monthspastleast_24),TRIM((SALT311.StrType)le.fleet_spend_monthspastmost_24),TRIM((SALT311.StrType)le.fleet_spend_slope_0t12),TRIM((SALT311.StrType)le.fleet_spend_slope_0t24),TRIM((SALT311.StrType)le.fleet_spend_slope_0t6),TRIM((SALT311.StrType)le.fleet_spend_sum_12),TRIM((SALT311.StrType)le.fleet_spend_volatility_0t6),TRIM((SALT311.StrType)le.fleet_spend_volatility_6t12),TRIM((SALT311.StrType)le.carrier_paid_average_12),TRIM((SALT311.StrType)le.carrier_paid_monthspastworst_24),TRIM((SALT311.StrType)le.carrier_paid_slope_0t12),TRIM((SALT311.StrType)le.carrier_paid_slope_0t24),TRIM((SALT311.StrType)le.carrier_paid_slope_0t6),TRIM((SALT311.StrType)le.carrier_paid_volatility_0t12),TRIM((SALT311.StrType)le.carrier_paid_volatility_0t6),TRIM((SALT311.StrType)le.carrier_spend_monthspastleast_24),TRIM((SALT311.StrType)le.carrier_spend_monthspastmost_24),TRIM((SALT311.StrType)le.carrier_spend_slope_0t12),TRIM((SALT311.StrType)le.carrier_spend_slope_0t24),TRIM((SALT311.StrType)le.carrier_spend_slope_0t6),TRIM((SALT311.StrType)le.carrier_spend_sum_12),TRIM((SALT311.StrType)le.carrier_spend_volatility_0t6),TRIM((SALT311.StrType)le.carrier_spend_volatility_6t12),TRIM((SALT311.StrType)le.bldgmats_paid_average_12),TRIM((SALT311.StrType)le.bldgmats_paid_monthspastworst_24),TRIM((SALT311.StrType)le.bldgmats_paid_slope_0t12),TRIM((SALT311.StrType)le.bldgmats_paid_slope_0t24),TRIM((SALT311.StrType)le.bldgmats_paid_slope_0t6),TRIM((SALT311.StrType)le.bldgmats_paid_volatility_0t12),TRIM((SALT311.StrType)le.bldgmats_paid_volatility_0t6),TRIM((SALT311.StrType)le.bldgmats_spend_monthspastleast_24),TRIM((SALT311.StrType)le.bldgmats_spend_monthspastmost_24),TRIM((SALT311.StrType)le.bldgmats_spend_slope_0t12),TRIM((SALT311.StrType)le.bldgmats_spend_slope_0t24),TRIM((SALT311.StrType)le.bldgmats_spend_slope_0t6),TRIM((SALT311.StrType)le.bldgmats_spend_sum_12),TRIM((SALT311.StrType)le.bldgmats_spend_volatility_0t6),TRIM((SALT311.StrType)le.bldgmats_spend_volatility_6t12),TRIM((SALT311.StrType)le.top5_paid_average_12),TRIM((SALT311.StrType)le.top5_paid_monthspastworst_24),TRIM((SALT311.StrType)le.top5_paid_slope_0t12),TRIM((SALT311.StrType)le.top5_paid_slope_0t24),TRIM((SALT311.StrType)le.top5_paid_slope_0t6),TRIM((SALT311.StrType)le.top5_paid_volatility_0t12),TRIM((SALT311.StrType)le.top5_paid_volatility_0t6),TRIM((SALT311.StrType)le.top5_spend_monthspastleast_24),TRIM((SALT311.StrType)le.top5_spend_monthspastmost_24),TRIM((SALT311.StrType)le.top5_spend_slope_0t12),TRIM((SALT311.StrType)le.top5_spend_slope_0t24),TRIM((SALT311.StrType)le.top5_spend_slope_0t6),TRIM((SALT311.StrType)le.top5_spend_sum_12),TRIM((SALT311.StrType)le.top5_spend_volatility_0t6),TRIM((SALT311.StrType)le.top5_spend_volatility_6t12),TRIM((SALT311.StrType)le.total_numrel_avg12),TRIM((SALT311.StrType)le.total_numrel_monthpspastmost_24),TRIM((SALT311.StrType)le.total_numrel_monthspastleast_24),TRIM((SALT311.StrType)le.total_numrel_slope_0t12),TRIM((SALT311.StrType)le.total_numrel_slope_0t24),TRIM((SALT311.StrType)le.total_numrel_slope_0t6),TRIM((SALT311.StrType)le.total_numrel_slope_6t12),TRIM((SALT311.StrType)le.total_numrel_var_0t12),TRIM((SALT311.StrType)le.total_numrel_var_0t24),TRIM((SALT311.StrType)le.total_numrel_var_12t24),TRIM((SALT311.StrType)le.total_numrel_var_6t18),TRIM((SALT311.StrType)le.mfgmat_numrel_avg12),TRIM((SALT311.StrType)le.mfgmat_numrel_slope_0t12),TRIM((SALT311.StrType)le.mfgmat_numrel_slope_0t24),TRIM((SALT311.StrType)le.mfgmat_numrel_slope_0t6),TRIM((SALT311.StrType)le.mfgmat_numrel_slope_6t12),TRIM((SALT311.StrType)le.mfgmat_numrel_var_0t12),TRIM((SALT311.StrType)le.mfgmat_numrel_var_12t24),TRIM((SALT311.StrType)le.ops_numrel_avg12),TRIM((SALT311.StrType)le.ops_numrel_slope_0t12),TRIM((SALT311.StrType)le.ops_numrel_slope_0t24),TRIM((SALT311.StrType)le.ops_numrel_slope_0t6),TRIM((SALT311.StrType)le.ops_numrel_slope_6t12),TRIM((SALT311.StrType)le.ops_numrel_var_0t12),TRIM((SALT311.StrType)le.ops_numrel_var_12t24),TRIM((SALT311.StrType)le.fleet_numrel_avg12),TRIM((SALT311.StrType)le.fleet_numrel_slope_0t12),TRIM((SALT311.StrType)le.fleet_numrel_slope_0t24),TRIM((SALT311.StrType)le.fleet_numrel_slope_0t6),TRIM((SALT311.StrType)le.fleet_numrel_slope_6t12),TRIM((SALT311.StrType)le.fleet_numrel_var_0t12),TRIM((SALT311.StrType)le.fleet_numrel_var_12t24),TRIM((SALT311.StrType)le.carrier_numrel_avg12),TRIM((SALT311.StrType)le.carrier_numrel_slope_0t12),TRIM((SALT311.StrType)le.carrier_numrel_slope_0t24),TRIM((SALT311.StrType)le.carrier_numrel_slope_0t6),TRIM((SALT311.StrType)le.carrier_numrel_slope_6t12),TRIM((SALT311.StrType)le.carrier_numrel_var_0t12),TRIM((SALT311.StrType)le.carrier_numrel_var_12t24),TRIM((SALT311.StrType)le.bldgmats_numrel_avg12),TRIM((SALT311.StrType)le.bldgmats_numrel_slope_0t12),TRIM((SALT311.StrType)le.bldgmats_numrel_slope_0t24),TRIM((SALT311.StrType)le.bldgmats_numrel_slope_0t6),TRIM((SALT311.StrType)le.bldgmats_numrel_slope_6t12),TRIM((SALT311.StrType)le.bldgmats_numrel_var_0t12),TRIM((SALT311.StrType)le.bldgmats_numrel_var_12t24),TRIM((SALT311.StrType)le.total_monthsoutstanding_slope24),TRIM((SALT311.StrType)le.total_percprov30_avg_0t12),TRIM((SALT311.StrType)le.total_percprov30_slope_0t12),TRIM((SALT311.StrType)le.total_percprov30_slope_0t24),TRIM((SALT311.StrType)le.total_percprov30_slope_0t6),TRIM((SALT311.StrType)le.total_percprov30_slope_6t12),TRIM((SALT311.StrType)le.total_percprov60_avg_0t12),TRIM((SALT311.StrType)le.total_percprov60_slope_0t12),TRIM((SALT311.StrType)le.total_percprov60_slope_0t24),TRIM((SALT311.StrType)le.total_percprov60_slope_0t6),TRIM((SALT311.StrType)le.total_percprov60_slope_6t12),TRIM((SALT311.StrType)le.total_percprov90_avg_0t12),TRIM((SALT311.StrType)le.total_percprov90_lowerlim_0t12),TRIM((SALT311.StrType)le.total_percprov90_slope_0t24),TRIM((SALT311.StrType)le.total_percprov90_slope_0t6),TRIM((SALT311.StrType)le.total_percprov90_slope_6t12),TRIM((SALT311.StrType)le.total_percprovoutstanding_adjustedslope_0t12),TRIM((SALT311.StrType)le.mfgmat_monthsoutstanding_slope24),TRIM((SALT311.StrType)le.mfgmat_percprov30_slope_0t12),TRIM((SALT311.StrType)le.mfgmat_percprov30_slope_6t12),TRIM((SALT311.StrType)le.mfgmat_percprov60_slope_0t12),TRIM((SALT311.StrType)le.mfgmat_percprov60_slope_6t12),TRIM((SALT311.StrType)le.mfgmat_percprov90_slope_0t24),TRIM((SALT311.StrType)le.mfgmat_percprov90_slope_0t6),TRIM((SALT311.StrType)le.mfgmat_percprov90_slope_6t12),TRIM((SALT311.StrType)le.mfgmat_percprovoutstanding_adjustedslope_0t12),TRIM((SALT311.StrType)le.ops_monthsoutstanding_slope24),TRIM((SALT311.StrType)le.ops_percprov30_slope_0t12),TRIM((SALT311.StrType)le.ops_percprov30_slope_6t12),TRIM((SALT311.StrType)le.ops_percprov60_slope_0t12),TRIM((SALT311.StrType)le.ops_percprov60_slope_6t12),TRIM((SALT311.StrType)le.ops_percprov90_slope_0t24),TRIM((SALT311.StrType)le.ops_percprov90_slope_0t6),TRIM((SALT311.StrType)le.ops_percprov90_slope_6t12),TRIM((SALT311.StrType)le.ops_percprovoutstanding_adjustedslope_0t12),TRIM((SALT311.StrType)le.fleet_monthsoutstanding_slope24),TRIM((SALT311.StrType)le.fleet_percprov30_slope_0t12),TRIM((SALT311.StrType)le.fleet_percprov30_slope_6t12),TRIM((SALT311.StrType)le.fleet_percprov60_slope_0t12),TRIM((SALT311.StrType)le.fleet_percprov60_slope_6t12),TRIM((SALT311.StrType)le.fleet_percprov90_slope_0t24),TRIM((SALT311.StrType)le.fleet_percprov90_slope_0t6),TRIM((SALT311.StrType)le.fleet_percprov90_slope_6t12),TRIM((SALT311.StrType)le.fleet_percprovoutstanding_adjustedslope_0t12),TRIM((SALT311.StrType)le.carrier_monthsoutstanding_slope24),TRIM((SALT311.StrType)le.carrier_percprov30_slope_0t12),TRIM((SALT311.StrType)le.carrier_percprov30_slope_6t12),TRIM((SALT311.StrType)le.carrier_percprov60_slope_0t12),TRIM((SALT311.StrType)le.carrier_percprov60_slope_6t12),TRIM((SALT311.StrType)le.carrier_percprov90_slope_0t24),TRIM((SALT311.StrType)le.carrier_percprov90_slope_0t6),TRIM((SALT311.StrType)le.carrier_percprov90_slope_6t12),TRIM((SALT311.StrType)le.carrier_percprovoutstanding_adjustedslope_0t12),TRIM((SALT311.StrType)le.bldgmats_monthsoutstanding_slope24),TRIM((SALT311.StrType)le.bldgmats_percprov30_slope_0t12),TRIM((SALT311.StrType)le.bldgmats_percprov30_slope_6t12),TRIM((SALT311.StrType)le.bldgmats_percprov60_slope_0t12),TRIM((SALT311.StrType)le.bldgmats_percprov60_slope_6t12),TRIM((SALT311.StrType)le.bldgmats_percprov90_slope_0t24),TRIM((SALT311.StrType)le.bldgmats_percprov90_slope_0t6),TRIM((SALT311.StrType)le.bldgmats_percprov90_slope_6t12),TRIM((SALT311.StrType)le.bldgmats_percprovoutstanding_adjustedslope_0t12),TRIM((SALT311.StrType)le.top5_monthsoutstanding_slope24),TRIM((SALT311.StrType)le.top5_percprov30_slope_0t12),TRIM((SALT311.StrType)le.top5_percprov30_slope_6t12),TRIM((SALT311.StrType)le.top5_percprov60_slope_0t12),TRIM((SALT311.StrType)le.top5_percprov60_slope_6t12),TRIM((SALT311.StrType)le.top5_percprov90_slope_0t24),TRIM((SALT311.StrType)le.top5_percprov90_slope_0t6),TRIM((SALT311.StrType)le.top5_percprov90_slope_6t12),TRIM((SALT311.StrType)le.top5_percprovoutstanding_adjustedslope_0t12)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),333*333,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'ultimate_linkid'}
      ,{2,'cortera_score'}
      ,{3,'cpr_score'}
      ,{4,'cpr_segment'}
      ,{5,'dbt'}
      ,{6,'avg_bal'}
      ,{7,'air_spend'}
      ,{8,'fuel_spend'}
      ,{9,'leasing_spend'}
      ,{10,'ltl_spend'}
      ,{11,'rail_spend'}
      ,{12,'tl_spend'}
      ,{13,'transvc_spend'}
      ,{14,'transup_spend'}
      ,{15,'bst_spend'}
      ,{16,'dg_spend'}
      ,{17,'electrical_spend'}
      ,{18,'hvac_spend'}
      ,{19,'other_b_spend'}
      ,{20,'plumbing_spend'}
      ,{21,'rs_spend'}
      ,{22,'wp_spend'}
      ,{23,'chemical_spend'}
      ,{24,'electronic_spend'}
      ,{25,'metal_spend'}
      ,{26,'other_m_spend'}
      ,{27,'packaging_spend'}
      ,{28,'pvf_spend'}
      ,{29,'plastic_spend'}
      ,{30,'textile_spend'}
      ,{31,'bs_spend'}
      ,{32,'ce_spend'}
      ,{33,'hardware_spend'}
      ,{34,'ie_spend'}
      ,{35,'is_spend'}
      ,{36,'it_spend'}
      ,{37,'mls_spend'}
      ,{38,'os_spend'}
      ,{39,'pp_spend'}
      ,{40,'sis_spend'}
      ,{41,'apparel_spend'}
      ,{42,'beverages_spend'}
      ,{43,'constr_spend'}
      ,{44,'consulting_spend'}
      ,{45,'fs_spend'}
      ,{46,'fp_spend'}
      ,{47,'insurance_spend'}
      ,{48,'ls_spend'}
      ,{49,'oil_gas_spend'}
      ,{50,'utilities_spend'}
      ,{51,'other_spend'}
      ,{52,'advt_spend'}
      ,{53,'air_growth'}
      ,{54,'fuel_growth'}
      ,{55,'leasing_growth'}
      ,{56,'ltl_growth'}
      ,{57,'rail_growth'}
      ,{58,'tl_growth'}
      ,{59,'transvc_growth'}
      ,{60,'transup_growth'}
      ,{61,'bst_growth'}
      ,{62,'dg_growth'}
      ,{63,'electrical_growth'}
      ,{64,'hvac_growth'}
      ,{65,'other_b_growth'}
      ,{66,'plumbing_growth'}
      ,{67,'rs_growth'}
      ,{68,'wp_growth'}
      ,{69,'chemical_growth'}
      ,{70,'electronic_growth'}
      ,{71,'metal_growth'}
      ,{72,'other_m_growth'}
      ,{73,'packaging_growth'}
      ,{74,'pvf_growth'}
      ,{75,'plastic_growth'}
      ,{76,'textile_growth'}
      ,{77,'bs_growth'}
      ,{78,'ce_growth'}
      ,{79,'hardware_growth'}
      ,{80,'ie_growth'}
      ,{81,'is_growth'}
      ,{82,'it_growth'}
      ,{83,'mls_growth'}
      ,{84,'os_growth'}
      ,{85,'pp_growth'}
      ,{86,'sis_growth'}
      ,{87,'apparel_growth'}
      ,{88,'beverages_growth'}
      ,{89,'constr_growth'}
      ,{90,'consulting_growth'}
      ,{91,'fs_growth'}
      ,{92,'fp_growth'}
      ,{93,'insurance_growth'}
      ,{94,'ls_growth'}
      ,{95,'oil_gas_growth'}
      ,{96,'utilities_growth'}
      ,{97,'other_growth'}
      ,{98,'advt_growth'}
      ,{99,'top5_growth'}
      ,{100,'shipping_y1'}
      ,{101,'shipping_growth'}
      ,{102,'materials_y1'}
      ,{103,'materials_growth'}
      ,{104,'operations_y1'}
      ,{105,'operations_growth'}
      ,{106,'total_paid_average_0t12'}
      ,{107,'total_paid_monthspastworst_24'}
      ,{108,'total_paid_slope_0t12'}
      ,{109,'total_paid_slope_0t6'}
      ,{110,'total_paid_slope_6t12'}
      ,{111,'total_paid_slope_6t18'}
      ,{112,'total_paid_volatility_0t12'}
      ,{113,'total_paid_volatility_0t6'}
      ,{114,'total_paid_volatility_12t18'}
      ,{115,'total_paid_volatility_6t12'}
      ,{116,'total_spend_monthspastleast_24'}
      ,{117,'total_spend_monthspastmost_24'}
      ,{118,'total_spend_slope_0t12'}
      ,{119,'total_spend_slope_0t24'}
      ,{120,'total_spend_slope_0t6'}
      ,{121,'total_spend_slope_6t12'}
      ,{122,'total_spend_sum_12'}
      ,{123,'total_spend_volatility_0t12'}
      ,{124,'total_spend_volatility_0t6'}
      ,{125,'total_spend_volatility_12t18'}
      ,{126,'total_spend_volatility_6t12'}
      ,{127,'mfgmat_paid_average_12'}
      ,{128,'mfgmat_paid_monthspastworst_24'}
      ,{129,'mfgmat_paid_slope_0t12'}
      ,{130,'mfgmat_paid_slope_0t24'}
      ,{131,'mfgmat_paid_slope_0t6'}
      ,{132,'mfgmat_paid_volatility_0t12'}
      ,{133,'mfgmat_paid_volatility_0t6'}
      ,{134,'mfgmat_spend_monthspastleast_24'}
      ,{135,'mfgmat_spend_monthspastmost_24'}
      ,{136,'mfgmat_spend_slope_0t12'}
      ,{137,'mfgmat_spend_slope_0t24'}
      ,{138,'mfgmat_spend_slope_0t6'}
      ,{139,'mfgmat_spend_sum_12'}
      ,{140,'mfgmat_spend_volatility_0t6'}
      ,{141,'mfgmat_spend_volatility_6t12'}
      ,{142,'ops_paid_average_12'}
      ,{143,'ops_paid_monthspastworst_24'}
      ,{144,'ops_paid_slope_0t12'}
      ,{145,'ops_paid_slope_0t24'}
      ,{146,'ops_paid_slope_0t6'}
      ,{147,'ops_paid_volatility_0t12'}
      ,{148,'ops_paid_volatility_0t6'}
      ,{149,'ops_spend_monthspastleast_24'}
      ,{150,'ops_spend_monthspastmost_24'}
      ,{151,'ops_spend_slope_0t12'}
      ,{152,'ops_spend_slope_0t24'}
      ,{153,'ops_spend_slope_0t6'}
      ,{154,'ops_spend_sum_12'}
      ,{155,'ops_spend_volatility_0t6'}
      ,{156,'ops_spend_volatility_6t12'}
      ,{157,'fleet_paid_average_12'}
      ,{158,'fleet_paid_monthspastworst_24'}
      ,{159,'fleet_paid_slope_0t12'}
      ,{160,'fleet_paid_slope_0t24'}
      ,{161,'fleet_paid_slope_0t6'}
      ,{162,'fleet_paid_volatility_0t12'}
      ,{163,'fleet_paid_volatility_0t6'}
      ,{164,'fleet_spend_monthspastleast_24'}
      ,{165,'fleet_spend_monthspastmost_24'}
      ,{166,'fleet_spend_slope_0t12'}
      ,{167,'fleet_spend_slope_0t24'}
      ,{168,'fleet_spend_slope_0t6'}
      ,{169,'fleet_spend_sum_12'}
      ,{170,'fleet_spend_volatility_0t6'}
      ,{171,'fleet_spend_volatility_6t12'}
      ,{172,'carrier_paid_average_12'}
      ,{173,'carrier_paid_monthspastworst_24'}
      ,{174,'carrier_paid_slope_0t12'}
      ,{175,'carrier_paid_slope_0t24'}
      ,{176,'carrier_paid_slope_0t6'}
      ,{177,'carrier_paid_volatility_0t12'}
      ,{178,'carrier_paid_volatility_0t6'}
      ,{179,'carrier_spend_monthspastleast_24'}
      ,{180,'carrier_spend_monthspastmost_24'}
      ,{181,'carrier_spend_slope_0t12'}
      ,{182,'carrier_spend_slope_0t24'}
      ,{183,'carrier_spend_slope_0t6'}
      ,{184,'carrier_spend_sum_12'}
      ,{185,'carrier_spend_volatility_0t6'}
      ,{186,'carrier_spend_volatility_6t12'}
      ,{187,'bldgmats_paid_average_12'}
      ,{188,'bldgmats_paid_monthspastworst_24'}
      ,{189,'bldgmats_paid_slope_0t12'}
      ,{190,'bldgmats_paid_slope_0t24'}
      ,{191,'bldgmats_paid_slope_0t6'}
      ,{192,'bldgmats_paid_volatility_0t12'}
      ,{193,'bldgmats_paid_volatility_0t6'}
      ,{194,'bldgmats_spend_monthspastleast_24'}
      ,{195,'bldgmats_spend_monthspastmost_24'}
      ,{196,'bldgmats_spend_slope_0t12'}
      ,{197,'bldgmats_spend_slope_0t24'}
      ,{198,'bldgmats_spend_slope_0t6'}
      ,{199,'bldgmats_spend_sum_12'}
      ,{200,'bldgmats_spend_volatility_0t6'}
      ,{201,'bldgmats_spend_volatility_6t12'}
      ,{202,'top5_paid_average_12'}
      ,{203,'top5_paid_monthspastworst_24'}
      ,{204,'top5_paid_slope_0t12'}
      ,{205,'top5_paid_slope_0t24'}
      ,{206,'top5_paid_slope_0t6'}
      ,{207,'top5_paid_volatility_0t12'}
      ,{208,'top5_paid_volatility_0t6'}
      ,{209,'top5_spend_monthspastleast_24'}
      ,{210,'top5_spend_monthspastmost_24'}
      ,{211,'top5_spend_slope_0t12'}
      ,{212,'top5_spend_slope_0t24'}
      ,{213,'top5_spend_slope_0t6'}
      ,{214,'top5_spend_sum_12'}
      ,{215,'top5_spend_volatility_0t6'}
      ,{216,'top5_spend_volatility_6t12'}
      ,{217,'total_numrel_avg12'}
      ,{218,'total_numrel_monthpspastmost_24'}
      ,{219,'total_numrel_monthspastleast_24'}
      ,{220,'total_numrel_slope_0t12'}
      ,{221,'total_numrel_slope_0t24'}
      ,{222,'total_numrel_slope_0t6'}
      ,{223,'total_numrel_slope_6t12'}
      ,{224,'total_numrel_var_0t12'}
      ,{225,'total_numrel_var_0t24'}
      ,{226,'total_numrel_var_12t24'}
      ,{227,'total_numrel_var_6t18'}
      ,{228,'mfgmat_numrel_avg12'}
      ,{229,'mfgmat_numrel_slope_0t12'}
      ,{230,'mfgmat_numrel_slope_0t24'}
      ,{231,'mfgmat_numrel_slope_0t6'}
      ,{232,'mfgmat_numrel_slope_6t12'}
      ,{233,'mfgmat_numrel_var_0t12'}
      ,{234,'mfgmat_numrel_var_12t24'}
      ,{235,'ops_numrel_avg12'}
      ,{236,'ops_numrel_slope_0t12'}
      ,{237,'ops_numrel_slope_0t24'}
      ,{238,'ops_numrel_slope_0t6'}
      ,{239,'ops_numrel_slope_6t12'}
      ,{240,'ops_numrel_var_0t12'}
      ,{241,'ops_numrel_var_12t24'}
      ,{242,'fleet_numrel_avg12'}
      ,{243,'fleet_numrel_slope_0t12'}
      ,{244,'fleet_numrel_slope_0t24'}
      ,{245,'fleet_numrel_slope_0t6'}
      ,{246,'fleet_numrel_slope_6t12'}
      ,{247,'fleet_numrel_var_0t12'}
      ,{248,'fleet_numrel_var_12t24'}
      ,{249,'carrier_numrel_avg12'}
      ,{250,'carrier_numrel_slope_0t12'}
      ,{251,'carrier_numrel_slope_0t24'}
      ,{252,'carrier_numrel_slope_0t6'}
      ,{253,'carrier_numrel_slope_6t12'}
      ,{254,'carrier_numrel_var_0t12'}
      ,{255,'carrier_numrel_var_12t24'}
      ,{256,'bldgmats_numrel_avg12'}
      ,{257,'bldgmats_numrel_slope_0t12'}
      ,{258,'bldgmats_numrel_slope_0t24'}
      ,{259,'bldgmats_numrel_slope_0t6'}
      ,{260,'bldgmats_numrel_slope_6t12'}
      ,{261,'bldgmats_numrel_var_0t12'}
      ,{262,'bldgmats_numrel_var_12t24'}
      ,{263,'total_monthsoutstanding_slope24'}
      ,{264,'total_percprov30_avg_0t12'}
      ,{265,'total_percprov30_slope_0t12'}
      ,{266,'total_percprov30_slope_0t24'}
      ,{267,'total_percprov30_slope_0t6'}
      ,{268,'total_percprov30_slope_6t12'}
      ,{269,'total_percprov60_avg_0t12'}
      ,{270,'total_percprov60_slope_0t12'}
      ,{271,'total_percprov60_slope_0t24'}
      ,{272,'total_percprov60_slope_0t6'}
      ,{273,'total_percprov60_slope_6t12'}
      ,{274,'total_percprov90_avg_0t12'}
      ,{275,'total_percprov90_lowerlim_0t12'}
      ,{276,'total_percprov90_slope_0t24'}
      ,{277,'total_percprov90_slope_0t6'}
      ,{278,'total_percprov90_slope_6t12'}
      ,{279,'total_percprovoutstanding_adjustedslope_0t12'}
      ,{280,'mfgmat_monthsoutstanding_slope24'}
      ,{281,'mfgmat_percprov30_slope_0t12'}
      ,{282,'mfgmat_percprov30_slope_6t12'}
      ,{283,'mfgmat_percprov60_slope_0t12'}
      ,{284,'mfgmat_percprov60_slope_6t12'}
      ,{285,'mfgmat_percprov90_slope_0t24'}
      ,{286,'mfgmat_percprov90_slope_0t6'}
      ,{287,'mfgmat_percprov90_slope_6t12'}
      ,{288,'mfgmat_percprovoutstanding_adjustedslope_0t12'}
      ,{289,'ops_monthsoutstanding_slope24'}
      ,{290,'ops_percprov30_slope_0t12'}
      ,{291,'ops_percprov30_slope_6t12'}
      ,{292,'ops_percprov60_slope_0t12'}
      ,{293,'ops_percprov60_slope_6t12'}
      ,{294,'ops_percprov90_slope_0t24'}
      ,{295,'ops_percprov90_slope_0t6'}
      ,{296,'ops_percprov90_slope_6t12'}
      ,{297,'ops_percprovoutstanding_adjustedslope_0t12'}
      ,{298,'fleet_monthsoutstanding_slope24'}
      ,{299,'fleet_percprov30_slope_0t12'}
      ,{300,'fleet_percprov30_slope_6t12'}
      ,{301,'fleet_percprov60_slope_0t12'}
      ,{302,'fleet_percprov60_slope_6t12'}
      ,{303,'fleet_percprov90_slope_0t24'}
      ,{304,'fleet_percprov90_slope_0t6'}
      ,{305,'fleet_percprov90_slope_6t12'}
      ,{306,'fleet_percprovoutstanding_adjustedslope_0t12'}
      ,{307,'carrier_monthsoutstanding_slope24'}
      ,{308,'carrier_percprov30_slope_0t12'}
      ,{309,'carrier_percprov30_slope_6t12'}
      ,{310,'carrier_percprov60_slope_0t12'}
      ,{311,'carrier_percprov60_slope_6t12'}
      ,{312,'carrier_percprov90_slope_0t24'}
      ,{313,'carrier_percprov90_slope_0t6'}
      ,{314,'carrier_percprov90_slope_6t12'}
      ,{315,'carrier_percprovoutstanding_adjustedslope_0t12'}
      ,{316,'bldgmats_monthsoutstanding_slope24'}
      ,{317,'bldgmats_percprov30_slope_0t12'}
      ,{318,'bldgmats_percprov30_slope_6t12'}
      ,{319,'bldgmats_percprov60_slope_0t12'}
      ,{320,'bldgmats_percprov60_slope_6t12'}
      ,{321,'bldgmats_percprov90_slope_0t24'}
      ,{322,'bldgmats_percprov90_slope_0t6'}
      ,{323,'bldgmats_percprov90_slope_6t12'}
      ,{324,'bldgmats_percprovoutstanding_adjustedslope_0t12'}
      ,{325,'top5_monthsoutstanding_slope24'}
      ,{326,'top5_percprov30_slope_0t12'}
      ,{327,'top5_percprov30_slope_6t12'}
      ,{328,'top5_percprov60_slope_0t12'}
      ,{329,'top5_percprov60_slope_6t12'}
      ,{330,'top5_percprov90_slope_0t24'}
      ,{331,'top5_percprov90_slope_0t6'}
      ,{332,'top5_percprov90_slope_6t12'}
      ,{333,'top5_percprovoutstanding_adjustedslope_0t12'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED2 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED2 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Attributes_Fields.InValid_ultimate_linkid((SALT311.StrType)le.ultimate_linkid),
    Attributes_Fields.InValid_cortera_score((SALT311.StrType)le.cortera_score),
    Attributes_Fields.InValid_cpr_score((SALT311.StrType)le.cpr_score),
    Attributes_Fields.InValid_cpr_segment((SALT311.StrType)le.cpr_segment),
    Attributes_Fields.InValid_dbt((SALT311.StrType)le.dbt),
    Attributes_Fields.InValid_avg_bal((SALT311.StrType)le.avg_bal),
    Attributes_Fields.InValid_air_spend((SALT311.StrType)le.air_spend),
    Attributes_Fields.InValid_fuel_spend((SALT311.StrType)le.fuel_spend),
    Attributes_Fields.InValid_leasing_spend((SALT311.StrType)le.leasing_spend),
    Attributes_Fields.InValid_ltl_spend((SALT311.StrType)le.ltl_spend),
    Attributes_Fields.InValid_rail_spend((SALT311.StrType)le.rail_spend),
    Attributes_Fields.InValid_tl_spend((SALT311.StrType)le.tl_spend),
    Attributes_Fields.InValid_transvc_spend((SALT311.StrType)le.transvc_spend),
    Attributes_Fields.InValid_transup_spend((SALT311.StrType)le.transup_spend),
    Attributes_Fields.InValid_bst_spend((SALT311.StrType)le.bst_spend),
    Attributes_Fields.InValid_dg_spend((SALT311.StrType)le.dg_spend),
    Attributes_Fields.InValid_electrical_spend((SALT311.StrType)le.electrical_spend),
    Attributes_Fields.InValid_hvac_spend((SALT311.StrType)le.hvac_spend),
    Attributes_Fields.InValid_other_b_spend((SALT311.StrType)le.other_b_spend),
    Attributes_Fields.InValid_plumbing_spend((SALT311.StrType)le.plumbing_spend),
    Attributes_Fields.InValid_rs_spend((SALT311.StrType)le.rs_spend),
    Attributes_Fields.InValid_wp_spend((SALT311.StrType)le.wp_spend),
    Attributes_Fields.InValid_chemical_spend((SALT311.StrType)le.chemical_spend),
    Attributes_Fields.InValid_electronic_spend((SALT311.StrType)le.electronic_spend),
    Attributes_Fields.InValid_metal_spend((SALT311.StrType)le.metal_spend),
    Attributes_Fields.InValid_other_m_spend((SALT311.StrType)le.other_m_spend),
    Attributes_Fields.InValid_packaging_spend((SALT311.StrType)le.packaging_spend),
    Attributes_Fields.InValid_pvf_spend((SALT311.StrType)le.pvf_spend),
    Attributes_Fields.InValid_plastic_spend((SALT311.StrType)le.plastic_spend),
    Attributes_Fields.InValid_textile_spend((SALT311.StrType)le.textile_spend),
    Attributes_Fields.InValid_bs_spend((SALT311.StrType)le.bs_spend),
    Attributes_Fields.InValid_ce_spend((SALT311.StrType)le.ce_spend),
    Attributes_Fields.InValid_hardware_spend((SALT311.StrType)le.hardware_spend),
    Attributes_Fields.InValid_ie_spend((SALT311.StrType)le.ie_spend),
    Attributes_Fields.InValid_is_spend((SALT311.StrType)le.is_spend),
    Attributes_Fields.InValid_it_spend((SALT311.StrType)le.it_spend),
    Attributes_Fields.InValid_mls_spend((SALT311.StrType)le.mls_spend),
    Attributes_Fields.InValid_os_spend((SALT311.StrType)le.os_spend),
    Attributes_Fields.InValid_pp_spend((SALT311.StrType)le.pp_spend),
    Attributes_Fields.InValid_sis_spend((SALT311.StrType)le.sis_spend),
    Attributes_Fields.InValid_apparel_spend((SALT311.StrType)le.apparel_spend),
    Attributes_Fields.InValid_beverages_spend((SALT311.StrType)le.beverages_spend),
    Attributes_Fields.InValid_constr_spend((SALT311.StrType)le.constr_spend),
    Attributes_Fields.InValid_consulting_spend((SALT311.StrType)le.consulting_spend),
    Attributes_Fields.InValid_fs_spend((SALT311.StrType)le.fs_spend),
    Attributes_Fields.InValid_fp_spend((SALT311.StrType)le.fp_spend),
    Attributes_Fields.InValid_insurance_spend((SALT311.StrType)le.insurance_spend),
    Attributes_Fields.InValid_ls_spend((SALT311.StrType)le.ls_spend),
    Attributes_Fields.InValid_oil_gas_spend((SALT311.StrType)le.oil_gas_spend),
    Attributes_Fields.InValid_utilities_spend((SALT311.StrType)le.utilities_spend),
    Attributes_Fields.InValid_other_spend((SALT311.StrType)le.other_spend),
    Attributes_Fields.InValid_advt_spend((SALT311.StrType)le.advt_spend),
    Attributes_Fields.InValid_air_growth((SALT311.StrType)le.air_growth),
    Attributes_Fields.InValid_fuel_growth((SALT311.StrType)le.fuel_growth),
    Attributes_Fields.InValid_leasing_growth((SALT311.StrType)le.leasing_growth),
    Attributes_Fields.InValid_ltl_growth((SALT311.StrType)le.ltl_growth),
    Attributes_Fields.InValid_rail_growth((SALT311.StrType)le.rail_growth),
    Attributes_Fields.InValid_tl_growth((SALT311.StrType)le.tl_growth),
    Attributes_Fields.InValid_transvc_growth((SALT311.StrType)le.transvc_growth),
    Attributes_Fields.InValid_transup_growth((SALT311.StrType)le.transup_growth),
    Attributes_Fields.InValid_bst_growth((SALT311.StrType)le.bst_growth),
    Attributes_Fields.InValid_dg_growth((SALT311.StrType)le.dg_growth),
    Attributes_Fields.InValid_electrical_growth((SALT311.StrType)le.electrical_growth),
    Attributes_Fields.InValid_hvac_growth((SALT311.StrType)le.hvac_growth),
    Attributes_Fields.InValid_other_b_growth((SALT311.StrType)le.other_b_growth),
    Attributes_Fields.InValid_plumbing_growth((SALT311.StrType)le.plumbing_growth),
    Attributes_Fields.InValid_rs_growth((SALT311.StrType)le.rs_growth),
    Attributes_Fields.InValid_wp_growth((SALT311.StrType)le.wp_growth),
    Attributes_Fields.InValid_chemical_growth((SALT311.StrType)le.chemical_growth),
    Attributes_Fields.InValid_electronic_growth((SALT311.StrType)le.electronic_growth),
    Attributes_Fields.InValid_metal_growth((SALT311.StrType)le.metal_growth),
    Attributes_Fields.InValid_other_m_growth((SALT311.StrType)le.other_m_growth),
    Attributes_Fields.InValid_packaging_growth((SALT311.StrType)le.packaging_growth),
    Attributes_Fields.InValid_pvf_growth((SALT311.StrType)le.pvf_growth),
    Attributes_Fields.InValid_plastic_growth((SALT311.StrType)le.plastic_growth),
    Attributes_Fields.InValid_textile_growth((SALT311.StrType)le.textile_growth),
    Attributes_Fields.InValid_bs_growth((SALT311.StrType)le.bs_growth),
    Attributes_Fields.InValid_ce_growth((SALT311.StrType)le.ce_growth),
    Attributes_Fields.InValid_hardware_growth((SALT311.StrType)le.hardware_growth),
    Attributes_Fields.InValid_ie_growth((SALT311.StrType)le.ie_growth),
    Attributes_Fields.InValid_is_growth((SALT311.StrType)le.is_growth),
    Attributes_Fields.InValid_it_growth((SALT311.StrType)le.it_growth),
    Attributes_Fields.InValid_mls_growth((SALT311.StrType)le.mls_growth),
    Attributes_Fields.InValid_os_growth((SALT311.StrType)le.os_growth),
    Attributes_Fields.InValid_pp_growth((SALT311.StrType)le.pp_growth),
    Attributes_Fields.InValid_sis_growth((SALT311.StrType)le.sis_growth),
    Attributes_Fields.InValid_apparel_growth((SALT311.StrType)le.apparel_growth),
    Attributes_Fields.InValid_beverages_growth((SALT311.StrType)le.beverages_growth),
    Attributes_Fields.InValid_constr_growth((SALT311.StrType)le.constr_growth),
    Attributes_Fields.InValid_consulting_growth((SALT311.StrType)le.consulting_growth),
    Attributes_Fields.InValid_fs_growth((SALT311.StrType)le.fs_growth),
    Attributes_Fields.InValid_fp_growth((SALT311.StrType)le.fp_growth),
    Attributes_Fields.InValid_insurance_growth((SALT311.StrType)le.insurance_growth),
    Attributes_Fields.InValid_ls_growth((SALT311.StrType)le.ls_growth),
    Attributes_Fields.InValid_oil_gas_growth((SALT311.StrType)le.oil_gas_growth),
    Attributes_Fields.InValid_utilities_growth((SALT311.StrType)le.utilities_growth),
    Attributes_Fields.InValid_other_growth((SALT311.StrType)le.other_growth),
    Attributes_Fields.InValid_advt_growth((SALT311.StrType)le.advt_growth),
    Attributes_Fields.InValid_top5_growth((SALT311.StrType)le.top5_growth),
    Attributes_Fields.InValid_shipping_y1((SALT311.StrType)le.shipping_y1),
    Attributes_Fields.InValid_shipping_growth((SALT311.StrType)le.shipping_growth),
    Attributes_Fields.InValid_materials_y1((SALT311.StrType)le.materials_y1),
    Attributes_Fields.InValid_materials_growth((SALT311.StrType)le.materials_growth),
    Attributes_Fields.InValid_operations_y1((SALT311.StrType)le.operations_y1),
    Attributes_Fields.InValid_operations_growth((SALT311.StrType)le.operations_growth),
    Attributes_Fields.InValid_total_paid_average_0t12((SALT311.StrType)le.total_paid_average_0t12),
    Attributes_Fields.InValid_total_paid_monthspastworst_24((SALT311.StrType)le.total_paid_monthspastworst_24),
    Attributes_Fields.InValid_total_paid_slope_0t12((SALT311.StrType)le.total_paid_slope_0t12),
    Attributes_Fields.InValid_total_paid_slope_0t6((SALT311.StrType)le.total_paid_slope_0t6),
    Attributes_Fields.InValid_total_paid_slope_6t12((SALT311.StrType)le.total_paid_slope_6t12),
    Attributes_Fields.InValid_total_paid_slope_6t18((SALT311.StrType)le.total_paid_slope_6t18),
    Attributes_Fields.InValid_total_paid_volatility_0t12((SALT311.StrType)le.total_paid_volatility_0t12),
    Attributes_Fields.InValid_total_paid_volatility_0t6((SALT311.StrType)le.total_paid_volatility_0t6),
    Attributes_Fields.InValid_total_paid_volatility_12t18((SALT311.StrType)le.total_paid_volatility_12t18),
    Attributes_Fields.InValid_total_paid_volatility_6t12((SALT311.StrType)le.total_paid_volatility_6t12),
    Attributes_Fields.InValid_total_spend_monthspastleast_24((SALT311.StrType)le.total_spend_monthspastleast_24),
    Attributes_Fields.InValid_total_spend_monthspastmost_24((SALT311.StrType)le.total_spend_monthspastmost_24),
    Attributes_Fields.InValid_total_spend_slope_0t12((SALT311.StrType)le.total_spend_slope_0t12),
    Attributes_Fields.InValid_total_spend_slope_0t24((SALT311.StrType)le.total_spend_slope_0t24),
    Attributes_Fields.InValid_total_spend_slope_0t6((SALT311.StrType)le.total_spend_slope_0t6),
    Attributes_Fields.InValid_total_spend_slope_6t12((SALT311.StrType)le.total_spend_slope_6t12),
    Attributes_Fields.InValid_total_spend_sum_12((SALT311.StrType)le.total_spend_sum_12),
    Attributes_Fields.InValid_total_spend_volatility_0t12((SALT311.StrType)le.total_spend_volatility_0t12),
    Attributes_Fields.InValid_total_spend_volatility_0t6((SALT311.StrType)le.total_spend_volatility_0t6),
    Attributes_Fields.InValid_total_spend_volatility_12t18((SALT311.StrType)le.total_spend_volatility_12t18),
    Attributes_Fields.InValid_total_spend_volatility_6t12((SALT311.StrType)le.total_spend_volatility_6t12),
    Attributes_Fields.InValid_mfgmat_paid_average_12((SALT311.StrType)le.mfgmat_paid_average_12),
    Attributes_Fields.InValid_mfgmat_paid_monthspastworst_24((SALT311.StrType)le.mfgmat_paid_monthspastworst_24),
    Attributes_Fields.InValid_mfgmat_paid_slope_0t12((SALT311.StrType)le.mfgmat_paid_slope_0t12),
    Attributes_Fields.InValid_mfgmat_paid_slope_0t24((SALT311.StrType)le.mfgmat_paid_slope_0t24),
    Attributes_Fields.InValid_mfgmat_paid_slope_0t6((SALT311.StrType)le.mfgmat_paid_slope_0t6),
    Attributes_Fields.InValid_mfgmat_paid_volatility_0t12((SALT311.StrType)le.mfgmat_paid_volatility_0t12),
    Attributes_Fields.InValid_mfgmat_paid_volatility_0t6((SALT311.StrType)le.mfgmat_paid_volatility_0t6),
    Attributes_Fields.InValid_mfgmat_spend_monthspastleast_24((SALT311.StrType)le.mfgmat_spend_monthspastleast_24),
    Attributes_Fields.InValid_mfgmat_spend_monthspastmost_24((SALT311.StrType)le.mfgmat_spend_monthspastmost_24),
    Attributes_Fields.InValid_mfgmat_spend_slope_0t12((SALT311.StrType)le.mfgmat_spend_slope_0t12),
    Attributes_Fields.InValid_mfgmat_spend_slope_0t24((SALT311.StrType)le.mfgmat_spend_slope_0t24),
    Attributes_Fields.InValid_mfgmat_spend_slope_0t6((SALT311.StrType)le.mfgmat_spend_slope_0t6),
    Attributes_Fields.InValid_mfgmat_spend_sum_12((SALT311.StrType)le.mfgmat_spend_sum_12),
    Attributes_Fields.InValid_mfgmat_spend_volatility_0t6((SALT311.StrType)le.mfgmat_spend_volatility_0t6),
    Attributes_Fields.InValid_mfgmat_spend_volatility_6t12((SALT311.StrType)le.mfgmat_spend_volatility_6t12),
    Attributes_Fields.InValid_ops_paid_average_12((SALT311.StrType)le.ops_paid_average_12),
    Attributes_Fields.InValid_ops_paid_monthspastworst_24((SALT311.StrType)le.ops_paid_monthspastworst_24),
    Attributes_Fields.InValid_ops_paid_slope_0t12((SALT311.StrType)le.ops_paid_slope_0t12),
    Attributes_Fields.InValid_ops_paid_slope_0t24((SALT311.StrType)le.ops_paid_slope_0t24),
    Attributes_Fields.InValid_ops_paid_slope_0t6((SALT311.StrType)le.ops_paid_slope_0t6),
    Attributes_Fields.InValid_ops_paid_volatility_0t12((SALT311.StrType)le.ops_paid_volatility_0t12),
    Attributes_Fields.InValid_ops_paid_volatility_0t6((SALT311.StrType)le.ops_paid_volatility_0t6),
    Attributes_Fields.InValid_ops_spend_monthspastleast_24((SALT311.StrType)le.ops_spend_monthspastleast_24),
    Attributes_Fields.InValid_ops_spend_monthspastmost_24((SALT311.StrType)le.ops_spend_monthspastmost_24),
    Attributes_Fields.InValid_ops_spend_slope_0t12((SALT311.StrType)le.ops_spend_slope_0t12),
    Attributes_Fields.InValid_ops_spend_slope_0t24((SALT311.StrType)le.ops_spend_slope_0t24),
    Attributes_Fields.InValid_ops_spend_slope_0t6((SALT311.StrType)le.ops_spend_slope_0t6),
    Attributes_Fields.InValid_ops_spend_sum_12((SALT311.StrType)le.ops_spend_sum_12),
    Attributes_Fields.InValid_ops_spend_volatility_0t6((SALT311.StrType)le.ops_spend_volatility_0t6),
    Attributes_Fields.InValid_ops_spend_volatility_6t12((SALT311.StrType)le.ops_spend_volatility_6t12),
    Attributes_Fields.InValid_fleet_paid_average_12((SALT311.StrType)le.fleet_paid_average_12),
    Attributes_Fields.InValid_fleet_paid_monthspastworst_24((SALT311.StrType)le.fleet_paid_monthspastworst_24),
    Attributes_Fields.InValid_fleet_paid_slope_0t12((SALT311.StrType)le.fleet_paid_slope_0t12),
    Attributes_Fields.InValid_fleet_paid_slope_0t24((SALT311.StrType)le.fleet_paid_slope_0t24),
    Attributes_Fields.InValid_fleet_paid_slope_0t6((SALT311.StrType)le.fleet_paid_slope_0t6),
    Attributes_Fields.InValid_fleet_paid_volatility_0t12((SALT311.StrType)le.fleet_paid_volatility_0t12),
    Attributes_Fields.InValid_fleet_paid_volatility_0t6((SALT311.StrType)le.fleet_paid_volatility_0t6),
    Attributes_Fields.InValid_fleet_spend_monthspastleast_24((SALT311.StrType)le.fleet_spend_monthspastleast_24),
    Attributes_Fields.InValid_fleet_spend_monthspastmost_24((SALT311.StrType)le.fleet_spend_monthspastmost_24),
    Attributes_Fields.InValid_fleet_spend_slope_0t12((SALT311.StrType)le.fleet_spend_slope_0t12),
    Attributes_Fields.InValid_fleet_spend_slope_0t24((SALT311.StrType)le.fleet_spend_slope_0t24),
    Attributes_Fields.InValid_fleet_spend_slope_0t6((SALT311.StrType)le.fleet_spend_slope_0t6),
    Attributes_Fields.InValid_fleet_spend_sum_12((SALT311.StrType)le.fleet_spend_sum_12),
    Attributes_Fields.InValid_fleet_spend_volatility_0t6((SALT311.StrType)le.fleet_spend_volatility_0t6),
    Attributes_Fields.InValid_fleet_spend_volatility_6t12((SALT311.StrType)le.fleet_spend_volatility_6t12),
    Attributes_Fields.InValid_carrier_paid_average_12((SALT311.StrType)le.carrier_paid_average_12),
    Attributes_Fields.InValid_carrier_paid_monthspastworst_24((SALT311.StrType)le.carrier_paid_monthspastworst_24),
    Attributes_Fields.InValid_carrier_paid_slope_0t12((SALT311.StrType)le.carrier_paid_slope_0t12),
    Attributes_Fields.InValid_carrier_paid_slope_0t24((SALT311.StrType)le.carrier_paid_slope_0t24),
    Attributes_Fields.InValid_carrier_paid_slope_0t6((SALT311.StrType)le.carrier_paid_slope_0t6),
    Attributes_Fields.InValid_carrier_paid_volatility_0t12((SALT311.StrType)le.carrier_paid_volatility_0t12),
    Attributes_Fields.InValid_carrier_paid_volatility_0t6((SALT311.StrType)le.carrier_paid_volatility_0t6),
    Attributes_Fields.InValid_carrier_spend_monthspastleast_24((SALT311.StrType)le.carrier_spend_monthspastleast_24),
    Attributes_Fields.InValid_carrier_spend_monthspastmost_24((SALT311.StrType)le.carrier_spend_monthspastmost_24),
    Attributes_Fields.InValid_carrier_spend_slope_0t12((SALT311.StrType)le.carrier_spend_slope_0t12),
    Attributes_Fields.InValid_carrier_spend_slope_0t24((SALT311.StrType)le.carrier_spend_slope_0t24),
    Attributes_Fields.InValid_carrier_spend_slope_0t6((SALT311.StrType)le.carrier_spend_slope_0t6),
    Attributes_Fields.InValid_carrier_spend_sum_12((SALT311.StrType)le.carrier_spend_sum_12),
    Attributes_Fields.InValid_carrier_spend_volatility_0t6((SALT311.StrType)le.carrier_spend_volatility_0t6),
    Attributes_Fields.InValid_carrier_spend_volatility_6t12((SALT311.StrType)le.carrier_spend_volatility_6t12),
    Attributes_Fields.InValid_bldgmats_paid_average_12((SALT311.StrType)le.bldgmats_paid_average_12),
    Attributes_Fields.InValid_bldgmats_paid_monthspastworst_24((SALT311.StrType)le.bldgmats_paid_monthspastworst_24),
    Attributes_Fields.InValid_bldgmats_paid_slope_0t12((SALT311.StrType)le.bldgmats_paid_slope_0t12),
    Attributes_Fields.InValid_bldgmats_paid_slope_0t24((SALT311.StrType)le.bldgmats_paid_slope_0t24),
    Attributes_Fields.InValid_bldgmats_paid_slope_0t6((SALT311.StrType)le.bldgmats_paid_slope_0t6),
    Attributes_Fields.InValid_bldgmats_paid_volatility_0t12((SALT311.StrType)le.bldgmats_paid_volatility_0t12),
    Attributes_Fields.InValid_bldgmats_paid_volatility_0t6((SALT311.StrType)le.bldgmats_paid_volatility_0t6),
    Attributes_Fields.InValid_bldgmats_spend_monthspastleast_24((SALT311.StrType)le.bldgmats_spend_monthspastleast_24),
    Attributes_Fields.InValid_bldgmats_spend_monthspastmost_24((SALT311.StrType)le.bldgmats_spend_monthspastmost_24),
    Attributes_Fields.InValid_bldgmats_spend_slope_0t12((SALT311.StrType)le.bldgmats_spend_slope_0t12),
    Attributes_Fields.InValid_bldgmats_spend_slope_0t24((SALT311.StrType)le.bldgmats_spend_slope_0t24),
    Attributes_Fields.InValid_bldgmats_spend_slope_0t6((SALT311.StrType)le.bldgmats_spend_slope_0t6),
    Attributes_Fields.InValid_bldgmats_spend_sum_12((SALT311.StrType)le.bldgmats_spend_sum_12),
    Attributes_Fields.InValid_bldgmats_spend_volatility_0t6((SALT311.StrType)le.bldgmats_spend_volatility_0t6),
    Attributes_Fields.InValid_bldgmats_spend_volatility_6t12((SALT311.StrType)le.bldgmats_spend_volatility_6t12),
    Attributes_Fields.InValid_top5_paid_average_12((SALT311.StrType)le.top5_paid_average_12),
    Attributes_Fields.InValid_top5_paid_monthspastworst_24((SALT311.StrType)le.top5_paid_monthspastworst_24),
    Attributes_Fields.InValid_top5_paid_slope_0t12((SALT311.StrType)le.top5_paid_slope_0t12),
    Attributes_Fields.InValid_top5_paid_slope_0t24((SALT311.StrType)le.top5_paid_slope_0t24),
    Attributes_Fields.InValid_top5_paid_slope_0t6((SALT311.StrType)le.top5_paid_slope_0t6),
    Attributes_Fields.InValid_top5_paid_volatility_0t12((SALT311.StrType)le.top5_paid_volatility_0t12),
    Attributes_Fields.InValid_top5_paid_volatility_0t6((SALT311.StrType)le.top5_paid_volatility_0t6),
    Attributes_Fields.InValid_top5_spend_monthspastleast_24((SALT311.StrType)le.top5_spend_monthspastleast_24),
    Attributes_Fields.InValid_top5_spend_monthspastmost_24((SALT311.StrType)le.top5_spend_monthspastmost_24),
    Attributes_Fields.InValid_top5_spend_slope_0t12((SALT311.StrType)le.top5_spend_slope_0t12),
    Attributes_Fields.InValid_top5_spend_slope_0t24((SALT311.StrType)le.top5_spend_slope_0t24),
    Attributes_Fields.InValid_top5_spend_slope_0t6((SALT311.StrType)le.top5_spend_slope_0t6),
    Attributes_Fields.InValid_top5_spend_sum_12((SALT311.StrType)le.top5_spend_sum_12),
    Attributes_Fields.InValid_top5_spend_volatility_0t6((SALT311.StrType)le.top5_spend_volatility_0t6),
    Attributes_Fields.InValid_top5_spend_volatility_6t12((SALT311.StrType)le.top5_spend_volatility_6t12),
    Attributes_Fields.InValid_total_numrel_avg12((SALT311.StrType)le.total_numrel_avg12),
    Attributes_Fields.InValid_total_numrel_monthpspastmost_24((SALT311.StrType)le.total_numrel_monthpspastmost_24),
    Attributes_Fields.InValid_total_numrel_monthspastleast_24((SALT311.StrType)le.total_numrel_monthspastleast_24),
    Attributes_Fields.InValid_total_numrel_slope_0t12((SALT311.StrType)le.total_numrel_slope_0t12),
    Attributes_Fields.InValid_total_numrel_slope_0t24((SALT311.StrType)le.total_numrel_slope_0t24),
    Attributes_Fields.InValid_total_numrel_slope_0t6((SALT311.StrType)le.total_numrel_slope_0t6),
    Attributes_Fields.InValid_total_numrel_slope_6t12((SALT311.StrType)le.total_numrel_slope_6t12),
    Attributes_Fields.InValid_total_numrel_var_0t12((SALT311.StrType)le.total_numrel_var_0t12),
    Attributes_Fields.InValid_total_numrel_var_0t24((SALT311.StrType)le.total_numrel_var_0t24),
    Attributes_Fields.InValid_total_numrel_var_12t24((SALT311.StrType)le.total_numrel_var_12t24),
    Attributes_Fields.InValid_total_numrel_var_6t18((SALT311.StrType)le.total_numrel_var_6t18),
    Attributes_Fields.InValid_mfgmat_numrel_avg12((SALT311.StrType)le.mfgmat_numrel_avg12),
    Attributes_Fields.InValid_mfgmat_numrel_slope_0t12((SALT311.StrType)le.mfgmat_numrel_slope_0t12),
    Attributes_Fields.InValid_mfgmat_numrel_slope_0t24((SALT311.StrType)le.mfgmat_numrel_slope_0t24),
    Attributes_Fields.InValid_mfgmat_numrel_slope_0t6((SALT311.StrType)le.mfgmat_numrel_slope_0t6),
    Attributes_Fields.InValid_mfgmat_numrel_slope_6t12((SALT311.StrType)le.mfgmat_numrel_slope_6t12),
    Attributes_Fields.InValid_mfgmat_numrel_var_0t12((SALT311.StrType)le.mfgmat_numrel_var_0t12),
    Attributes_Fields.InValid_mfgmat_numrel_var_12t24((SALT311.StrType)le.mfgmat_numrel_var_12t24),
    Attributes_Fields.InValid_ops_numrel_avg12((SALT311.StrType)le.ops_numrel_avg12),
    Attributes_Fields.InValid_ops_numrel_slope_0t12((SALT311.StrType)le.ops_numrel_slope_0t12),
    Attributes_Fields.InValid_ops_numrel_slope_0t24((SALT311.StrType)le.ops_numrel_slope_0t24),
    Attributes_Fields.InValid_ops_numrel_slope_0t6((SALT311.StrType)le.ops_numrel_slope_0t6),
    Attributes_Fields.InValid_ops_numrel_slope_6t12((SALT311.StrType)le.ops_numrel_slope_6t12),
    Attributes_Fields.InValid_ops_numrel_var_0t12((SALT311.StrType)le.ops_numrel_var_0t12),
    Attributes_Fields.InValid_ops_numrel_var_12t24((SALT311.StrType)le.ops_numrel_var_12t24),
    Attributes_Fields.InValid_fleet_numrel_avg12((SALT311.StrType)le.fleet_numrel_avg12),
    Attributes_Fields.InValid_fleet_numrel_slope_0t12((SALT311.StrType)le.fleet_numrel_slope_0t12),
    Attributes_Fields.InValid_fleet_numrel_slope_0t24((SALT311.StrType)le.fleet_numrel_slope_0t24),
    Attributes_Fields.InValid_fleet_numrel_slope_0t6((SALT311.StrType)le.fleet_numrel_slope_0t6),
    Attributes_Fields.InValid_fleet_numrel_slope_6t12((SALT311.StrType)le.fleet_numrel_slope_6t12),
    Attributes_Fields.InValid_fleet_numrel_var_0t12((SALT311.StrType)le.fleet_numrel_var_0t12),
    Attributes_Fields.InValid_fleet_numrel_var_12t24((SALT311.StrType)le.fleet_numrel_var_12t24),
    Attributes_Fields.InValid_carrier_numrel_avg12((SALT311.StrType)le.carrier_numrel_avg12),
    Attributes_Fields.InValid_carrier_numrel_slope_0t12((SALT311.StrType)le.carrier_numrel_slope_0t12),
    Attributes_Fields.InValid_carrier_numrel_slope_0t24((SALT311.StrType)le.carrier_numrel_slope_0t24),
    Attributes_Fields.InValid_carrier_numrel_slope_0t6((SALT311.StrType)le.carrier_numrel_slope_0t6),
    Attributes_Fields.InValid_carrier_numrel_slope_6t12((SALT311.StrType)le.carrier_numrel_slope_6t12),
    Attributes_Fields.InValid_carrier_numrel_var_0t12((SALT311.StrType)le.carrier_numrel_var_0t12),
    Attributes_Fields.InValid_carrier_numrel_var_12t24((SALT311.StrType)le.carrier_numrel_var_12t24),
    Attributes_Fields.InValid_bldgmats_numrel_avg12((SALT311.StrType)le.bldgmats_numrel_avg12),
    Attributes_Fields.InValid_bldgmats_numrel_slope_0t12((SALT311.StrType)le.bldgmats_numrel_slope_0t12),
    Attributes_Fields.InValid_bldgmats_numrel_slope_0t24((SALT311.StrType)le.bldgmats_numrel_slope_0t24),
    Attributes_Fields.InValid_bldgmats_numrel_slope_0t6((SALT311.StrType)le.bldgmats_numrel_slope_0t6),
    Attributes_Fields.InValid_bldgmats_numrel_slope_6t12((SALT311.StrType)le.bldgmats_numrel_slope_6t12),
    Attributes_Fields.InValid_bldgmats_numrel_var_0t12((SALT311.StrType)le.bldgmats_numrel_var_0t12),
    Attributes_Fields.InValid_bldgmats_numrel_var_12t24((SALT311.StrType)le.bldgmats_numrel_var_12t24),
    Attributes_Fields.InValid_total_monthsoutstanding_slope24((SALT311.StrType)le.total_monthsoutstanding_slope24),
    Attributes_Fields.InValid_total_percprov30_avg_0t12((SALT311.StrType)le.total_percprov30_avg_0t12),
    Attributes_Fields.InValid_total_percprov30_slope_0t12((SALT311.StrType)le.total_percprov30_slope_0t12),
    Attributes_Fields.InValid_total_percprov30_slope_0t24((SALT311.StrType)le.total_percprov30_slope_0t24),
    Attributes_Fields.InValid_total_percprov30_slope_0t6((SALT311.StrType)le.total_percprov30_slope_0t6),
    Attributes_Fields.InValid_total_percprov30_slope_6t12((SALT311.StrType)le.total_percprov30_slope_6t12),
    Attributes_Fields.InValid_total_percprov60_avg_0t12((SALT311.StrType)le.total_percprov60_avg_0t12),
    Attributes_Fields.InValid_total_percprov60_slope_0t12((SALT311.StrType)le.total_percprov60_slope_0t12),
    Attributes_Fields.InValid_total_percprov60_slope_0t24((SALT311.StrType)le.total_percprov60_slope_0t24),
    Attributes_Fields.InValid_total_percprov60_slope_0t6((SALT311.StrType)le.total_percprov60_slope_0t6),
    Attributes_Fields.InValid_total_percprov60_slope_6t12((SALT311.StrType)le.total_percprov60_slope_6t12),
    Attributes_Fields.InValid_total_percprov90_avg_0t12((SALT311.StrType)le.total_percprov90_avg_0t12),
    Attributes_Fields.InValid_total_percprov90_lowerlim_0t12((SALT311.StrType)le.total_percprov90_lowerlim_0t12),
    Attributes_Fields.InValid_total_percprov90_slope_0t24((SALT311.StrType)le.total_percprov90_slope_0t24),
    Attributes_Fields.InValid_total_percprov90_slope_0t6((SALT311.StrType)le.total_percprov90_slope_0t6),
    Attributes_Fields.InValid_total_percprov90_slope_6t12((SALT311.StrType)le.total_percprov90_slope_6t12),
    Attributes_Fields.InValid_total_percprovoutstanding_adjustedslope_0t12((SALT311.StrType)le.total_percprovoutstanding_adjustedslope_0t12),
    Attributes_Fields.InValid_mfgmat_monthsoutstanding_slope24((SALT311.StrType)le.mfgmat_monthsoutstanding_slope24),
    Attributes_Fields.InValid_mfgmat_percprov30_slope_0t12((SALT311.StrType)le.mfgmat_percprov30_slope_0t12),
    Attributes_Fields.InValid_mfgmat_percprov30_slope_6t12((SALT311.StrType)le.mfgmat_percprov30_slope_6t12),
    Attributes_Fields.InValid_mfgmat_percprov60_slope_0t12((SALT311.StrType)le.mfgmat_percprov60_slope_0t12),
    Attributes_Fields.InValid_mfgmat_percprov60_slope_6t12((SALT311.StrType)le.mfgmat_percprov60_slope_6t12),
    Attributes_Fields.InValid_mfgmat_percprov90_slope_0t24((SALT311.StrType)le.mfgmat_percprov90_slope_0t24),
    Attributes_Fields.InValid_mfgmat_percprov90_slope_0t6((SALT311.StrType)le.mfgmat_percprov90_slope_0t6),
    Attributes_Fields.InValid_mfgmat_percprov90_slope_6t12((SALT311.StrType)le.mfgmat_percprov90_slope_6t12),
    Attributes_Fields.InValid_mfgmat_percprovoutstanding_adjustedslope_0t12((SALT311.StrType)le.mfgmat_percprovoutstanding_adjustedslope_0t12),
    Attributes_Fields.InValid_ops_monthsoutstanding_slope24((SALT311.StrType)le.ops_monthsoutstanding_slope24),
    Attributes_Fields.InValid_ops_percprov30_slope_0t12((SALT311.StrType)le.ops_percprov30_slope_0t12),
    Attributes_Fields.InValid_ops_percprov30_slope_6t12((SALT311.StrType)le.ops_percprov30_slope_6t12),
    Attributes_Fields.InValid_ops_percprov60_slope_0t12((SALT311.StrType)le.ops_percprov60_slope_0t12),
    Attributes_Fields.InValid_ops_percprov60_slope_6t12((SALT311.StrType)le.ops_percprov60_slope_6t12),
    Attributes_Fields.InValid_ops_percprov90_slope_0t24((SALT311.StrType)le.ops_percprov90_slope_0t24),
    Attributes_Fields.InValid_ops_percprov90_slope_0t6((SALT311.StrType)le.ops_percprov90_slope_0t6),
    Attributes_Fields.InValid_ops_percprov90_slope_6t12((SALT311.StrType)le.ops_percprov90_slope_6t12),
    Attributes_Fields.InValid_ops_percprovoutstanding_adjustedslope_0t12((SALT311.StrType)le.ops_percprovoutstanding_adjustedslope_0t12),
    Attributes_Fields.InValid_fleet_monthsoutstanding_slope24((SALT311.StrType)le.fleet_monthsoutstanding_slope24),
    Attributes_Fields.InValid_fleet_percprov30_slope_0t12((SALT311.StrType)le.fleet_percprov30_slope_0t12),
    Attributes_Fields.InValid_fleet_percprov30_slope_6t12((SALT311.StrType)le.fleet_percprov30_slope_6t12),
    Attributes_Fields.InValid_fleet_percprov60_slope_0t12((SALT311.StrType)le.fleet_percprov60_slope_0t12),
    Attributes_Fields.InValid_fleet_percprov60_slope_6t12((SALT311.StrType)le.fleet_percprov60_slope_6t12),
    Attributes_Fields.InValid_fleet_percprov90_slope_0t24((SALT311.StrType)le.fleet_percprov90_slope_0t24),
    Attributes_Fields.InValid_fleet_percprov90_slope_0t6((SALT311.StrType)le.fleet_percprov90_slope_0t6),
    Attributes_Fields.InValid_fleet_percprov90_slope_6t12((SALT311.StrType)le.fleet_percprov90_slope_6t12),
    Attributes_Fields.InValid_fleet_percprovoutstanding_adjustedslope_0t12((SALT311.StrType)le.fleet_percprovoutstanding_adjustedslope_0t12),
    Attributes_Fields.InValid_carrier_monthsoutstanding_slope24((SALT311.StrType)le.carrier_monthsoutstanding_slope24),
    Attributes_Fields.InValid_carrier_percprov30_slope_0t12((SALT311.StrType)le.carrier_percprov30_slope_0t12),
    Attributes_Fields.InValid_carrier_percprov30_slope_6t12((SALT311.StrType)le.carrier_percprov30_slope_6t12),
    Attributes_Fields.InValid_carrier_percprov60_slope_0t12((SALT311.StrType)le.carrier_percprov60_slope_0t12),
    Attributes_Fields.InValid_carrier_percprov60_slope_6t12((SALT311.StrType)le.carrier_percprov60_slope_6t12),
    Attributes_Fields.InValid_carrier_percprov90_slope_0t24((SALT311.StrType)le.carrier_percprov90_slope_0t24),
    Attributes_Fields.InValid_carrier_percprov90_slope_0t6((SALT311.StrType)le.carrier_percprov90_slope_0t6),
    Attributes_Fields.InValid_carrier_percprov90_slope_6t12((SALT311.StrType)le.carrier_percprov90_slope_6t12),
    Attributes_Fields.InValid_carrier_percprovoutstanding_adjustedslope_0t12((SALT311.StrType)le.carrier_percprovoutstanding_adjustedslope_0t12),
    Attributes_Fields.InValid_bldgmats_monthsoutstanding_slope24((SALT311.StrType)le.bldgmats_monthsoutstanding_slope24),
    Attributes_Fields.InValid_bldgmats_percprov30_slope_0t12((SALT311.StrType)le.bldgmats_percprov30_slope_0t12),
    Attributes_Fields.InValid_bldgmats_percprov30_slope_6t12((SALT311.StrType)le.bldgmats_percprov30_slope_6t12),
    Attributes_Fields.InValid_bldgmats_percprov60_slope_0t12((SALT311.StrType)le.bldgmats_percprov60_slope_0t12),
    Attributes_Fields.InValid_bldgmats_percprov60_slope_6t12((SALT311.StrType)le.bldgmats_percprov60_slope_6t12),
    Attributes_Fields.InValid_bldgmats_percprov90_slope_0t24((SALT311.StrType)le.bldgmats_percprov90_slope_0t24),
    Attributes_Fields.InValid_bldgmats_percprov90_slope_0t6((SALT311.StrType)le.bldgmats_percprov90_slope_0t6),
    Attributes_Fields.InValid_bldgmats_percprov90_slope_6t12((SALT311.StrType)le.bldgmats_percprov90_slope_6t12),
    Attributes_Fields.InValid_bldgmats_percprovoutstanding_adjustedslope_0t12((SALT311.StrType)le.bldgmats_percprovoutstanding_adjustedslope_0t12),
    Attributes_Fields.InValid_top5_monthsoutstanding_slope24((SALT311.StrType)le.top5_monthsoutstanding_slope24),
    Attributes_Fields.InValid_top5_percprov30_slope_0t12((SALT311.StrType)le.top5_percprov30_slope_0t12),
    Attributes_Fields.InValid_top5_percprov30_slope_6t12((SALT311.StrType)le.top5_percprov30_slope_6t12),
    Attributes_Fields.InValid_top5_percprov60_slope_0t12((SALT311.StrType)le.top5_percprov60_slope_0t12),
    Attributes_Fields.InValid_top5_percprov60_slope_6t12((SALT311.StrType)le.top5_percprov60_slope_6t12),
    Attributes_Fields.InValid_top5_percprov90_slope_0t24((SALT311.StrType)le.top5_percprov90_slope_0t24),
    Attributes_Fields.InValid_top5_percprov90_slope_0t6((SALT311.StrType)le.top5_percprov90_slope_0t6),
    Attributes_Fields.InValid_top5_percprov90_slope_6t12((SALT311.StrType)le.top5_percprov90_slope_6t12),
    Attributes_Fields.InValid_top5_percprovoutstanding_adjustedslope_0t12((SALT311.StrType)le.top5_percprovoutstanding_adjustedslope_0t12),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,333,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Attributes_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Number','Number','Number','Number','Ratio','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Number','Ratio','Number','Ratio','Number','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Number','Number','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Number','Ratio','Ratio','Ratio','Ratio','Ratio','Number','Number','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Number','Number','Ratio','Ratio','Ratio','Unknown','Unknown','Unknown','Unknown','Number','Ratio','Ratio','Ratio','Ratio','Ratio','Unknown','Unknown','Ratio','Ratio','Ratio','Unknown','Unknown','Unknown','Unknown','Unknown','Ratio','Ratio','Ratio','Ratio','Ratio','Unknown','Unknown','Ratio','Ratio','Ratio','Unknown','Ratio','Ratio','Unknown','Unknown','Ratio','Ratio','Ratio','Ratio','Ratio','Unknown','Unknown','Ratio','Ratio','Ratio','Unknown','Ratio','Ratio','Unknown','Unknown','Ratio','Ratio','Ratio','Ratio','Ratio','Unknown','Unknown','Ratio','Ratio','Ratio','Unknown','Ratio','Ratio','Unknown','Unknown','Unknown','Ratio','Ratio','Ratio','Ratio','Unknown','Unknown','Unknown','Unknown','Unknown','Ratio','Ratio','Ratio','Ratio','Unknown','Unknown','Unknown','Ratio','Ratio','Ratio','Ratio','Unknown','Unknown','Unknown','Ratio','Ratio','Ratio','Ratio','Unknown','Unknown','Unknown','Ratio','Ratio','Ratio','Ratio','Unknown','Unknown','Unknown','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Unknown','Unknown','Ratio','Ratio','Ratio','Ratio','Unknown','Ratio','Ratio','Ratio','Ratio','Unknown','Unknown','Ratio','Ratio','Ratio','Unknown','Unknown','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Unknown','Unknown','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Unknown','Unknown','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Unknown','Unknown','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Unknown','Unknown','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Unknown','Unknown','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Attributes_Fields.InValidMessage_ultimate_linkid(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_cortera_score(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_cpr_score(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_cpr_segment(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_dbt(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_avg_bal(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_air_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fuel_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_leasing_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ltl_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_rail_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_tl_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_transvc_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_transup_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bst_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_dg_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_electrical_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_hvac_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_other_b_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_plumbing_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_rs_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_wp_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_chemical_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_electronic_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_metal_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_other_m_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_packaging_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_pvf_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_plastic_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_textile_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bs_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ce_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_hardware_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ie_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_is_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_it_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mls_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_os_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_pp_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_sis_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_apparel_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_beverages_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_constr_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_consulting_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fs_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fp_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_insurance_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ls_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_oil_gas_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_utilities_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_other_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_advt_spend(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_air_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fuel_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_leasing_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ltl_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_rail_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_tl_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_transvc_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_transup_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bst_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_dg_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_electrical_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_hvac_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_other_b_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_plumbing_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_rs_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_wp_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_chemical_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_electronic_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_metal_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_other_m_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_packaging_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_pvf_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_plastic_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_textile_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bs_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ce_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_hardware_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ie_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_is_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_it_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mls_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_os_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_pp_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_sis_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_apparel_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_beverages_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_constr_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_consulting_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fs_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fp_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_insurance_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ls_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_oil_gas_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_utilities_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_other_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_advt_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_top5_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_shipping_y1(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_shipping_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_materials_y1(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_materials_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_operations_y1(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_operations_growth(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_paid_average_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_paid_monthspastworst_24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_paid_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_paid_slope_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_paid_slope_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_paid_slope_6t18(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_paid_volatility_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_paid_volatility_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_paid_volatility_12t18(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_paid_volatility_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_spend_monthspastleast_24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_spend_monthspastmost_24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_spend_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_spend_slope_0t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_spend_slope_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_spend_slope_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_spend_sum_12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_spend_volatility_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_spend_volatility_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_spend_volatility_12t18(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_spend_volatility_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_paid_average_12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_paid_monthspastworst_24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_paid_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_paid_slope_0t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_paid_slope_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_paid_volatility_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_paid_volatility_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_spend_monthspastleast_24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_spend_monthspastmost_24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_spend_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_spend_slope_0t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_spend_slope_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_spend_sum_12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_spend_volatility_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_spend_volatility_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_paid_average_12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_paid_monthspastworst_24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_paid_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_paid_slope_0t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_paid_slope_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_paid_volatility_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_paid_volatility_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_spend_monthspastleast_24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_spend_monthspastmost_24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_spend_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_spend_slope_0t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_spend_slope_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_spend_sum_12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_spend_volatility_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_spend_volatility_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_paid_average_12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_paid_monthspastworst_24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_paid_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_paid_slope_0t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_paid_slope_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_paid_volatility_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_paid_volatility_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_spend_monthspastleast_24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_spend_monthspastmost_24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_spend_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_spend_slope_0t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_spend_slope_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_spend_sum_12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_spend_volatility_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_spend_volatility_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_paid_average_12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_paid_monthspastworst_24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_paid_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_paid_slope_0t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_paid_slope_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_paid_volatility_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_paid_volatility_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_spend_monthspastleast_24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_spend_monthspastmost_24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_spend_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_spend_slope_0t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_spend_slope_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_spend_sum_12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_spend_volatility_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_spend_volatility_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_paid_average_12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_paid_monthspastworst_24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_paid_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_paid_slope_0t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_paid_slope_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_paid_volatility_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_paid_volatility_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_spend_monthspastleast_24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_spend_monthspastmost_24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_spend_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_spend_slope_0t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_spend_slope_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_spend_sum_12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_spend_volatility_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_spend_volatility_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_top5_paid_average_12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_top5_paid_monthspastworst_24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_top5_paid_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_top5_paid_slope_0t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_top5_paid_slope_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_top5_paid_volatility_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_top5_paid_volatility_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_top5_spend_monthspastleast_24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_top5_spend_monthspastmost_24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_top5_spend_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_top5_spend_slope_0t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_top5_spend_slope_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_top5_spend_sum_12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_top5_spend_volatility_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_top5_spend_volatility_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_numrel_avg12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_numrel_monthpspastmost_24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_numrel_monthspastleast_24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_numrel_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_numrel_slope_0t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_numrel_slope_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_numrel_slope_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_numrel_var_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_numrel_var_0t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_numrel_var_12t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_numrel_var_6t18(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_numrel_avg12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_numrel_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_numrel_slope_0t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_numrel_slope_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_numrel_slope_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_numrel_var_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_numrel_var_12t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_numrel_avg12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_numrel_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_numrel_slope_0t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_numrel_slope_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_numrel_slope_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_numrel_var_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_numrel_var_12t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_numrel_avg12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_numrel_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_numrel_slope_0t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_numrel_slope_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_numrel_slope_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_numrel_var_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_numrel_var_12t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_numrel_avg12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_numrel_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_numrel_slope_0t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_numrel_slope_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_numrel_slope_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_numrel_var_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_numrel_var_12t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_numrel_avg12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_numrel_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_numrel_slope_0t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_numrel_slope_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_numrel_slope_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_numrel_var_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_numrel_var_12t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_monthsoutstanding_slope24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_percprov30_avg_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_percprov30_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_percprov30_slope_0t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_percprov30_slope_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_percprov30_slope_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_percprov60_avg_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_percprov60_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_percprov60_slope_0t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_percprov60_slope_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_percprov60_slope_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_percprov90_avg_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_percprov90_lowerlim_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_percprov90_slope_0t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_percprov90_slope_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_percprov90_slope_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_total_percprovoutstanding_adjustedslope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_monthsoutstanding_slope24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_percprov30_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_percprov30_slope_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_percprov60_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_percprov60_slope_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_percprov90_slope_0t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_percprov90_slope_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_percprov90_slope_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_mfgmat_percprovoutstanding_adjustedslope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_monthsoutstanding_slope24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_percprov30_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_percprov30_slope_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_percprov60_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_percprov60_slope_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_percprov90_slope_0t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_percprov90_slope_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_percprov90_slope_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_ops_percprovoutstanding_adjustedslope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_monthsoutstanding_slope24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_percprov30_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_percprov30_slope_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_percprov60_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_percprov60_slope_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_percprov90_slope_0t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_percprov90_slope_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_percprov90_slope_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_fleet_percprovoutstanding_adjustedslope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_monthsoutstanding_slope24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_percprov30_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_percprov30_slope_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_percprov60_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_percprov60_slope_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_percprov90_slope_0t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_percprov90_slope_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_percprov90_slope_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_carrier_percprovoutstanding_adjustedslope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_monthsoutstanding_slope24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_percprov30_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_percprov30_slope_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_percprov60_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_percprov60_slope_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_percprov90_slope_0t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_percprov90_slope_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_percprov90_slope_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_bldgmats_percprovoutstanding_adjustedslope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_top5_monthsoutstanding_slope24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_top5_percprov30_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_top5_percprov30_slope_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_top5_percprov60_slope_0t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_top5_percprov60_slope_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_top5_percprov90_slope_0t24(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_top5_percprov90_slope_0t6(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_top5_percprov90_slope_6t12(TotalErrors.ErrorNum),Attributes_Fields.InValidMessage_top5_percprovoutstanding_adjustedslope_0t12(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Cortera, Attributes_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
