IMPORT SALT311,STD;
EXPORT Attributes_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 482;
  EXPORT NumRulesFromFieldType := 482;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 272;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Attributes_Layout_Cortera)
    UNSIGNED1 ultimate_linkid_Invalid;
    UNSIGNED1 cortera_score_Invalid;
    UNSIGNED1 cpr_score_Invalid;
    UNSIGNED1 cpr_segment_Invalid;
    UNSIGNED1 dbt_Invalid;
    UNSIGNED1 avg_bal_Invalid;
    UNSIGNED1 air_spend_Invalid;
    UNSIGNED1 fuel_spend_Invalid;
    UNSIGNED1 leasing_spend_Invalid;
    UNSIGNED1 ltl_spend_Invalid;
    UNSIGNED1 rail_spend_Invalid;
    UNSIGNED1 tl_spend_Invalid;
    UNSIGNED1 transvc_spend_Invalid;
    UNSIGNED1 transup_spend_Invalid;
    UNSIGNED1 bst_spend_Invalid;
    UNSIGNED1 dg_spend_Invalid;
    UNSIGNED1 electrical_spend_Invalid;
    UNSIGNED1 hvac_spend_Invalid;
    UNSIGNED1 other_b_spend_Invalid;
    UNSIGNED1 plumbing_spend_Invalid;
    UNSIGNED1 rs_spend_Invalid;
    UNSIGNED1 wp_spend_Invalid;
    UNSIGNED1 chemical_spend_Invalid;
    UNSIGNED1 electronic_spend_Invalid;
    UNSIGNED1 metal_spend_Invalid;
    UNSIGNED1 other_m_spend_Invalid;
    UNSIGNED1 packaging_spend_Invalid;
    UNSIGNED1 pvf_spend_Invalid;
    UNSIGNED1 plastic_spend_Invalid;
    UNSIGNED1 textile_spend_Invalid;
    UNSIGNED1 bs_spend_Invalid;
    UNSIGNED1 ce_spend_Invalid;
    UNSIGNED1 hardware_spend_Invalid;
    UNSIGNED1 ie_spend_Invalid;
    UNSIGNED1 is_spend_Invalid;
    UNSIGNED1 it_spend_Invalid;
    UNSIGNED1 mls_spend_Invalid;
    UNSIGNED1 os_spend_Invalid;
    UNSIGNED1 pp_spend_Invalid;
    UNSIGNED1 sis_spend_Invalid;
    UNSIGNED1 apparel_spend_Invalid;
    UNSIGNED1 beverages_spend_Invalid;
    UNSIGNED1 constr_spend_Invalid;
    UNSIGNED1 consulting_spend_Invalid;
    UNSIGNED1 fs_spend_Invalid;
    UNSIGNED1 fp_spend_Invalid;
    UNSIGNED1 insurance_spend_Invalid;
    UNSIGNED1 ls_spend_Invalid;
    UNSIGNED1 oil_gas_spend_Invalid;
    UNSIGNED1 utilities_spend_Invalid;
    UNSIGNED1 other_spend_Invalid;
    UNSIGNED1 advt_spend_Invalid;
    UNSIGNED1 air_growth_Invalid;
    UNSIGNED1 fuel_growth_Invalid;
    UNSIGNED1 leasing_growth_Invalid;
    UNSIGNED1 ltl_growth_Invalid;
    UNSIGNED1 rail_growth_Invalid;
    UNSIGNED1 tl_growth_Invalid;
    UNSIGNED1 transvc_growth_Invalid;
    UNSIGNED1 transup_growth_Invalid;
    UNSIGNED1 bst_growth_Invalid;
    UNSIGNED1 dg_growth_Invalid;
    UNSIGNED1 electrical_growth_Invalid;
    UNSIGNED1 hvac_growth_Invalid;
    UNSIGNED1 other_b_growth_Invalid;
    UNSIGNED1 plumbing_growth_Invalid;
    UNSIGNED1 rs_growth_Invalid;
    UNSIGNED1 wp_growth_Invalid;
    UNSIGNED1 chemical_growth_Invalid;
    UNSIGNED1 electronic_growth_Invalid;
    UNSIGNED1 metal_growth_Invalid;
    UNSIGNED1 other_m_growth_Invalid;
    UNSIGNED1 packaging_growth_Invalid;
    UNSIGNED1 pvf_growth_Invalid;
    UNSIGNED1 plastic_growth_Invalid;
    UNSIGNED1 textile_growth_Invalid;
    UNSIGNED1 bs_growth_Invalid;
    UNSIGNED1 ce_growth_Invalid;
    UNSIGNED1 hardware_growth_Invalid;
    UNSIGNED1 ie_growth_Invalid;
    UNSIGNED1 is_growth_Invalid;
    UNSIGNED1 it_growth_Invalid;
    UNSIGNED1 mls_growth_Invalid;
    UNSIGNED1 os_growth_Invalid;
    UNSIGNED1 pp_growth_Invalid;
    UNSIGNED1 sis_growth_Invalid;
    UNSIGNED1 apparel_growth_Invalid;
    UNSIGNED1 beverages_growth_Invalid;
    UNSIGNED1 constr_growth_Invalid;
    UNSIGNED1 consulting_growth_Invalid;
    UNSIGNED1 fs_growth_Invalid;
    UNSIGNED1 fp_growth_Invalid;
    UNSIGNED1 insurance_growth_Invalid;
    UNSIGNED1 ls_growth_Invalid;
    UNSIGNED1 oil_gas_growth_Invalid;
    UNSIGNED1 utilities_growth_Invalid;
    UNSIGNED1 other_growth_Invalid;
    UNSIGNED1 advt_growth_Invalid;
    UNSIGNED1 top5_growth_Invalid;
    UNSIGNED1 shipping_y1_Invalid;
    UNSIGNED1 shipping_growth_Invalid;
    UNSIGNED1 materials_y1_Invalid;
    UNSIGNED1 materials_growth_Invalid;
    UNSIGNED1 operations_y1_Invalid;
    UNSIGNED1 operations_growth_Invalid;
    UNSIGNED1 total_paid_average_0t12_Invalid;
    UNSIGNED1 total_paid_monthspastworst_24_Invalid;
    UNSIGNED1 total_paid_slope_0t12_Invalid;
    UNSIGNED1 total_paid_slope_0t6_Invalid;
    UNSIGNED1 total_paid_slope_6t12_Invalid;
    UNSIGNED1 total_paid_slope_6t18_Invalid;
    UNSIGNED1 total_paid_volatility_0t12_Invalid;
    UNSIGNED1 total_paid_volatility_0t6_Invalid;
    UNSIGNED1 total_paid_volatility_12t18_Invalid;
    UNSIGNED1 total_paid_volatility_6t12_Invalid;
    UNSIGNED1 total_spend_monthspastleast_24_Invalid;
    UNSIGNED1 total_spend_monthspastmost_24_Invalid;
    UNSIGNED1 total_spend_slope_0t12_Invalid;
    UNSIGNED1 total_spend_slope_0t24_Invalid;
    UNSIGNED1 total_spend_slope_0t6_Invalid;
    UNSIGNED1 total_spend_slope_6t12_Invalid;
    UNSIGNED1 total_spend_sum_12_Invalid;
    UNSIGNED1 total_spend_volatility_0t12_Invalid;
    UNSIGNED1 total_spend_volatility_0t6_Invalid;
    UNSIGNED1 total_spend_volatility_12t18_Invalid;
    UNSIGNED1 total_spend_volatility_6t12_Invalid;
    UNSIGNED1 mfgmat_paid_average_12_Invalid;
    UNSIGNED1 mfgmat_paid_monthspastworst_24_Invalid;
    UNSIGNED1 mfgmat_paid_slope_0t12_Invalid;
    UNSIGNED1 mfgmat_paid_slope_0t24_Invalid;
    UNSIGNED1 mfgmat_paid_slope_0t6_Invalid;
    UNSIGNED1 mfgmat_paid_volatility_0t12_Invalid;
    UNSIGNED1 mfgmat_paid_volatility_0t6_Invalid;
    UNSIGNED1 mfgmat_spend_monthspastleast_24_Invalid;
    UNSIGNED1 mfgmat_spend_monthspastmost_24_Invalid;
    UNSIGNED1 mfgmat_spend_slope_0t12_Invalid;
    UNSIGNED1 mfgmat_spend_slope_0t24_Invalid;
    UNSIGNED1 mfgmat_spend_slope_0t6_Invalid;
    UNSIGNED1 mfgmat_spend_sum_12_Invalid;
    UNSIGNED1 mfgmat_spend_volatility_0t6_Invalid;
    UNSIGNED1 mfgmat_spend_volatility_6t12_Invalid;
    UNSIGNED1 ops_paid_average_12_Invalid;
    UNSIGNED1 ops_paid_monthspastworst_24_Invalid;
    UNSIGNED1 ops_paid_slope_0t12_Invalid;
    UNSIGNED1 ops_paid_slope_0t24_Invalid;
    UNSIGNED1 ops_paid_slope_0t6_Invalid;
    UNSIGNED1 ops_paid_volatility_0t12_Invalid;
    UNSIGNED1 ops_paid_volatility_0t6_Invalid;
    UNSIGNED1 ops_spend_monthspastleast_24_Invalid;
    UNSIGNED1 ops_spend_monthspastmost_24_Invalid;
    UNSIGNED1 ops_spend_slope_0t12_Invalid;
    UNSIGNED1 ops_spend_slope_0t24_Invalid;
    UNSIGNED1 ops_spend_slope_0t6_Invalid;
    UNSIGNED1 fleet_paid_monthspastworst_24_Invalid;
    UNSIGNED1 fleet_paid_slope_0t12_Invalid;
    UNSIGNED1 fleet_paid_slope_0t24_Invalid;
    UNSIGNED1 fleet_paid_slope_0t6_Invalid;
    UNSIGNED1 fleet_paid_volatility_0t12_Invalid;
    UNSIGNED1 fleet_paid_volatility_0t6_Invalid;
    UNSIGNED1 fleet_spend_slope_0t12_Invalid;
    UNSIGNED1 fleet_spend_slope_0t24_Invalid;
    UNSIGNED1 fleet_spend_slope_0t6_Invalid;
    UNSIGNED1 carrier_paid_slope_0t12_Invalid;
    UNSIGNED1 carrier_paid_slope_0t24_Invalid;
    UNSIGNED1 carrier_paid_slope_0t6_Invalid;
    UNSIGNED1 carrier_paid_volatility_0t12_Invalid;
    UNSIGNED1 carrier_paid_volatility_0t6_Invalid;
    UNSIGNED1 carrier_spend_slope_0t12_Invalid;
    UNSIGNED1 carrier_spend_slope_0t24_Invalid;
    UNSIGNED1 carrier_spend_slope_0t6_Invalid;
    UNSIGNED1 carrier_spend_volatility_0t6_Invalid;
    UNSIGNED1 carrier_spend_volatility_6t12_Invalid;
    UNSIGNED1 bldgmats_paid_slope_0t12_Invalid;
    UNSIGNED1 bldgmats_paid_slope_0t24_Invalid;
    UNSIGNED1 bldgmats_paid_slope_0t6_Invalid;
    UNSIGNED1 bldgmats_paid_volatility_0t12_Invalid;
    UNSIGNED1 bldgmats_paid_volatility_0t6_Invalid;
    UNSIGNED1 bldgmats_spend_slope_0t12_Invalid;
    UNSIGNED1 bldgmats_spend_slope_0t24_Invalid;
    UNSIGNED1 bldgmats_spend_slope_0t6_Invalid;
    UNSIGNED1 bldgmats_spend_volatility_0t6_Invalid;
    UNSIGNED1 bldgmats_spend_volatility_6t12_Invalid;
    UNSIGNED1 top5_paid_slope_0t12_Invalid;
    UNSIGNED1 top5_paid_slope_0t24_Invalid;
    UNSIGNED1 top5_paid_slope_0t6_Invalid;
    UNSIGNED1 top5_paid_volatility_0t12_Invalid;
    UNSIGNED1 top5_paid_volatility_0t6_Invalid;
    UNSIGNED1 top5_spend_slope_0t12_Invalid;
    UNSIGNED1 top5_spend_slope_0t24_Invalid;
    UNSIGNED1 top5_spend_slope_0t6_Invalid;
    UNSIGNED1 top5_spend_volatility_0t6_Invalid;
    UNSIGNED1 top5_spend_volatility_6t12_Invalid;
    UNSIGNED1 total_numrel_slope_0t12_Invalid;
    UNSIGNED1 total_numrel_slope_0t24_Invalid;
    UNSIGNED1 total_numrel_slope_0t6_Invalid;
    UNSIGNED1 total_numrel_slope_6t12_Invalid;
    UNSIGNED1 mfgmat_numrel_slope_0t12_Invalid;
    UNSIGNED1 mfgmat_numrel_slope_0t24_Invalid;
    UNSIGNED1 mfgmat_numrel_slope_0t6_Invalid;
    UNSIGNED1 mfgmat_numrel_slope_6t12_Invalid;
    UNSIGNED1 ops_numrel_slope_0t12_Invalid;
    UNSIGNED1 ops_numrel_slope_0t24_Invalid;
    UNSIGNED1 ops_numrel_slope_0t6_Invalid;
    UNSIGNED1 ops_numrel_slope_6t12_Invalid;
    UNSIGNED1 fleet_numrel_slope_0t12_Invalid;
    UNSIGNED1 fleet_numrel_slope_0t24_Invalid;
    UNSIGNED1 fleet_numrel_slope_0t6_Invalid;
    UNSIGNED1 fleet_numrel_slope_6t12_Invalid;
    UNSIGNED1 carrier_numrel_slope_0t12_Invalid;
    UNSIGNED1 carrier_numrel_slope_0t24_Invalid;
    UNSIGNED1 carrier_numrel_slope_0t6_Invalid;
    UNSIGNED1 carrier_numrel_slope_6t12_Invalid;
    UNSIGNED1 bldgmats_numrel_slope_0t12_Invalid;
    UNSIGNED1 bldgmats_numrel_slope_0t24_Invalid;
    UNSIGNED1 bldgmats_numrel_slope_0t6_Invalid;
    UNSIGNED1 bldgmats_numrel_slope_6t12_Invalid;
    UNSIGNED1 bldgmats_numrel_var_0t12_Invalid;
    UNSIGNED1 bldgmats_numrel_var_12t24_Invalid;
    UNSIGNED1 total_percprov30_slope_0t12_Invalid;
    UNSIGNED1 total_percprov30_slope_0t24_Invalid;
    UNSIGNED1 total_percprov30_slope_0t6_Invalid;
    UNSIGNED1 total_percprov30_slope_6t12_Invalid;
    UNSIGNED1 total_percprov60_slope_0t12_Invalid;
    UNSIGNED1 total_percprov60_slope_0t24_Invalid;
    UNSIGNED1 total_percprov60_slope_0t6_Invalid;
    UNSIGNED1 total_percprov60_slope_6t12_Invalid;
    UNSIGNED1 total_percprov90_slope_0t24_Invalid;
    UNSIGNED1 total_percprov90_slope_0t6_Invalid;
    UNSIGNED1 total_percprov90_slope_6t12_Invalid;
    UNSIGNED1 mfgmat_percprov30_slope_0t12_Invalid;
    UNSIGNED1 mfgmat_percprov30_slope_6t12_Invalid;
    UNSIGNED1 mfgmat_percprov60_slope_0t12_Invalid;
    UNSIGNED1 mfgmat_percprov60_slope_6t12_Invalid;
    UNSIGNED1 mfgmat_percprov90_slope_0t24_Invalid;
    UNSIGNED1 mfgmat_percprov90_slope_0t6_Invalid;
    UNSIGNED1 mfgmat_percprov90_slope_6t12_Invalid;
    UNSIGNED1 ops_percprov30_slope_0t12_Invalid;
    UNSIGNED1 ops_percprov30_slope_6t12_Invalid;
    UNSIGNED1 ops_percprov60_slope_0t12_Invalid;
    UNSIGNED1 ops_percprov60_slope_6t12_Invalid;
    UNSIGNED1 ops_percprov90_slope_0t24_Invalid;
    UNSIGNED1 ops_percprov90_slope_0t6_Invalid;
    UNSIGNED1 ops_percprov90_slope_6t12_Invalid;
    UNSIGNED1 fleet_percprov30_slope_0t12_Invalid;
    UNSIGNED1 fleet_percprov30_slope_6t12_Invalid;
    UNSIGNED1 fleet_percprov60_slope_0t12_Invalid;
    UNSIGNED1 fleet_percprov60_slope_6t12_Invalid;
    UNSIGNED1 fleet_percprov90_slope_0t24_Invalid;
    UNSIGNED1 fleet_percprov90_slope_0t6_Invalid;
    UNSIGNED1 fleet_percprov90_slope_6t12_Invalid;
    UNSIGNED1 carrier_percprov30_slope_0t12_Invalid;
    UNSIGNED1 carrier_percprov30_slope_6t12_Invalid;
    UNSIGNED1 carrier_percprov60_slope_0t12_Invalid;
    UNSIGNED1 carrier_percprov60_slope_6t12_Invalid;
    UNSIGNED1 carrier_percprov90_slope_0t24_Invalid;
    UNSIGNED1 carrier_percprov90_slope_0t6_Invalid;
    UNSIGNED1 carrier_percprov90_slope_6t12_Invalid;
    UNSIGNED1 bldgmats_percprov30_slope_0t12_Invalid;
    UNSIGNED1 bldgmats_percprov30_slope_6t12_Invalid;
    UNSIGNED1 bldgmats_percprov60_slope_0t12_Invalid;
    UNSIGNED1 bldgmats_percprov60_slope_6t12_Invalid;
    UNSIGNED1 bldgmats_percprov90_slope_0t24_Invalid;
    UNSIGNED1 bldgmats_percprov90_slope_0t6_Invalid;
    UNSIGNED1 bldgmats_percprov90_slope_6t12_Invalid;
    UNSIGNED1 top5_percprov30_slope_0t12_Invalid;
    UNSIGNED1 top5_percprov30_slope_6t12_Invalid;
    UNSIGNED1 top5_percprov60_slope_0t12_Invalid;
    UNSIGNED1 top5_percprov60_slope_6t12_Invalid;
    UNSIGNED1 top5_percprov90_slope_0t24_Invalid;
    UNSIGNED1 top5_percprov90_slope_0t6_Invalid;
    UNSIGNED1 top5_percprov90_slope_6t12_Invalid;
    UNSIGNED1 top5_percprovoutstanding_adjustedslope_0t12_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Attributes_Layout_Cortera)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
    UNSIGNED8 ScrubsBits4;
    UNSIGNED8 ScrubsBits5;
    UNSIGNED8 ScrubsBits6;
    UNSIGNED8 ScrubsBits7;
    UNSIGNED8 ScrubsBits8;
  END;
EXPORT FromNone(DATASET(Attributes_Layout_Cortera) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.ultimate_linkid_Invalid := Attributes_Fields.InValid_ultimate_linkid((SALT311.StrType)le.ultimate_linkid);
    SELF.cortera_score_Invalid := Attributes_Fields.InValid_cortera_score((SALT311.StrType)le.cortera_score);
    SELF.cpr_score_Invalid := Attributes_Fields.InValid_cpr_score((SALT311.StrType)le.cpr_score);
    SELF.cpr_segment_Invalid := Attributes_Fields.InValid_cpr_segment((SALT311.StrType)le.cpr_segment);
    SELF.dbt_Invalid := Attributes_Fields.InValid_dbt((SALT311.StrType)le.dbt);
    SELF.avg_bal_Invalid := Attributes_Fields.InValid_avg_bal((SALT311.StrType)le.avg_bal);
    SELF.air_spend_Invalid := Attributes_Fields.InValid_air_spend((SALT311.StrType)le.air_spend);
    SELF.fuel_spend_Invalid := Attributes_Fields.InValid_fuel_spend((SALT311.StrType)le.fuel_spend);
    SELF.leasing_spend_Invalid := Attributes_Fields.InValid_leasing_spend((SALT311.StrType)le.leasing_spend);
    SELF.ltl_spend_Invalid := Attributes_Fields.InValid_ltl_spend((SALT311.StrType)le.ltl_spend);
    SELF.rail_spend_Invalid := Attributes_Fields.InValid_rail_spend((SALT311.StrType)le.rail_spend);
    SELF.tl_spend_Invalid := Attributes_Fields.InValid_tl_spend((SALT311.StrType)le.tl_spend);
    SELF.transvc_spend_Invalid := Attributes_Fields.InValid_transvc_spend((SALT311.StrType)le.transvc_spend);
    SELF.transup_spend_Invalid := Attributes_Fields.InValid_transup_spend((SALT311.StrType)le.transup_spend);
    SELF.bst_spend_Invalid := Attributes_Fields.InValid_bst_spend((SALT311.StrType)le.bst_spend);
    SELF.dg_spend_Invalid := Attributes_Fields.InValid_dg_spend((SALT311.StrType)le.dg_spend);
    SELF.electrical_spend_Invalid := Attributes_Fields.InValid_electrical_spend((SALT311.StrType)le.electrical_spend);
    SELF.hvac_spend_Invalid := Attributes_Fields.InValid_hvac_spend((SALT311.StrType)le.hvac_spend);
    SELF.other_b_spend_Invalid := Attributes_Fields.InValid_other_b_spend((SALT311.StrType)le.other_b_spend);
    SELF.plumbing_spend_Invalid := Attributes_Fields.InValid_plumbing_spend((SALT311.StrType)le.plumbing_spend);
    SELF.rs_spend_Invalid := Attributes_Fields.InValid_rs_spend((SALT311.StrType)le.rs_spend);
    SELF.wp_spend_Invalid := Attributes_Fields.InValid_wp_spend((SALT311.StrType)le.wp_spend);
    SELF.chemical_spend_Invalid := Attributes_Fields.InValid_chemical_spend((SALT311.StrType)le.chemical_spend);
    SELF.electronic_spend_Invalid := Attributes_Fields.InValid_electronic_spend((SALT311.StrType)le.electronic_spend);
    SELF.metal_spend_Invalid := Attributes_Fields.InValid_metal_spend((SALT311.StrType)le.metal_spend);
    SELF.other_m_spend_Invalid := Attributes_Fields.InValid_other_m_spend((SALT311.StrType)le.other_m_spend);
    SELF.packaging_spend_Invalid := Attributes_Fields.InValid_packaging_spend((SALT311.StrType)le.packaging_spend);
    SELF.pvf_spend_Invalid := Attributes_Fields.InValid_pvf_spend((SALT311.StrType)le.pvf_spend);
    SELF.plastic_spend_Invalid := Attributes_Fields.InValid_plastic_spend((SALT311.StrType)le.plastic_spend);
    SELF.textile_spend_Invalid := Attributes_Fields.InValid_textile_spend((SALT311.StrType)le.textile_spend);
    SELF.bs_spend_Invalid := Attributes_Fields.InValid_bs_spend((SALT311.StrType)le.bs_spend);
    SELF.ce_spend_Invalid := Attributes_Fields.InValid_ce_spend((SALT311.StrType)le.ce_spend);
    SELF.hardware_spend_Invalid := Attributes_Fields.InValid_hardware_spend((SALT311.StrType)le.hardware_spend);
    SELF.ie_spend_Invalid := Attributes_Fields.InValid_ie_spend((SALT311.StrType)le.ie_spend);
    SELF.is_spend_Invalid := Attributes_Fields.InValid_is_spend((SALT311.StrType)le.is_spend);
    SELF.it_spend_Invalid := Attributes_Fields.InValid_it_spend((SALT311.StrType)le.it_spend);
    SELF.mls_spend_Invalid := Attributes_Fields.InValid_mls_spend((SALT311.StrType)le.mls_spend);
    SELF.os_spend_Invalid := Attributes_Fields.InValid_os_spend((SALT311.StrType)le.os_spend);
    SELF.pp_spend_Invalid := Attributes_Fields.InValid_pp_spend((SALT311.StrType)le.pp_spend);
    SELF.sis_spend_Invalid := Attributes_Fields.InValid_sis_spend((SALT311.StrType)le.sis_spend);
    SELF.apparel_spend_Invalid := Attributes_Fields.InValid_apparel_spend((SALT311.StrType)le.apparel_spend);
    SELF.beverages_spend_Invalid := Attributes_Fields.InValid_beverages_spend((SALT311.StrType)le.beverages_spend);
    SELF.constr_spend_Invalid := Attributes_Fields.InValid_constr_spend((SALT311.StrType)le.constr_spend);
    SELF.consulting_spend_Invalid := Attributes_Fields.InValid_consulting_spend((SALT311.StrType)le.consulting_spend);
    SELF.fs_spend_Invalid := Attributes_Fields.InValid_fs_spend((SALT311.StrType)le.fs_spend);
    SELF.fp_spend_Invalid := Attributes_Fields.InValid_fp_spend((SALT311.StrType)le.fp_spend);
    SELF.insurance_spend_Invalid := Attributes_Fields.InValid_insurance_spend((SALT311.StrType)le.insurance_spend);
    SELF.ls_spend_Invalid := Attributes_Fields.InValid_ls_spend((SALT311.StrType)le.ls_spend);
    SELF.oil_gas_spend_Invalid := Attributes_Fields.InValid_oil_gas_spend((SALT311.StrType)le.oil_gas_spend);
    SELF.utilities_spend_Invalid := Attributes_Fields.InValid_utilities_spend((SALT311.StrType)le.utilities_spend);
    SELF.other_spend_Invalid := Attributes_Fields.InValid_other_spend((SALT311.StrType)le.other_spend);
    SELF.advt_spend_Invalid := Attributes_Fields.InValid_advt_spend((SALT311.StrType)le.advt_spend);
    SELF.air_growth_Invalid := Attributes_Fields.InValid_air_growth((SALT311.StrType)le.air_growth);
    SELF.fuel_growth_Invalid := Attributes_Fields.InValid_fuel_growth((SALT311.StrType)le.fuel_growth);
    SELF.leasing_growth_Invalid := Attributes_Fields.InValid_leasing_growth((SALT311.StrType)le.leasing_growth);
    SELF.ltl_growth_Invalid := Attributes_Fields.InValid_ltl_growth((SALT311.StrType)le.ltl_growth);
    SELF.rail_growth_Invalid := Attributes_Fields.InValid_rail_growth((SALT311.StrType)le.rail_growth);
    SELF.tl_growth_Invalid := Attributes_Fields.InValid_tl_growth((SALT311.StrType)le.tl_growth);
    SELF.transvc_growth_Invalid := Attributes_Fields.InValid_transvc_growth((SALT311.StrType)le.transvc_growth);
    SELF.transup_growth_Invalid := Attributes_Fields.InValid_transup_growth((SALT311.StrType)le.transup_growth);
    SELF.bst_growth_Invalid := Attributes_Fields.InValid_bst_growth((SALT311.StrType)le.bst_growth);
    SELF.dg_growth_Invalid := Attributes_Fields.InValid_dg_growth((SALT311.StrType)le.dg_growth);
    SELF.electrical_growth_Invalid := Attributes_Fields.InValid_electrical_growth((SALT311.StrType)le.electrical_growth);
    SELF.hvac_growth_Invalid := Attributes_Fields.InValid_hvac_growth((SALT311.StrType)le.hvac_growth);
    SELF.other_b_growth_Invalid := Attributes_Fields.InValid_other_b_growth((SALT311.StrType)le.other_b_growth);
    SELF.plumbing_growth_Invalid := Attributes_Fields.InValid_plumbing_growth((SALT311.StrType)le.plumbing_growth);
    SELF.rs_growth_Invalid := Attributes_Fields.InValid_rs_growth((SALT311.StrType)le.rs_growth);
    SELF.wp_growth_Invalid := Attributes_Fields.InValid_wp_growth((SALT311.StrType)le.wp_growth);
    SELF.chemical_growth_Invalid := Attributes_Fields.InValid_chemical_growth((SALT311.StrType)le.chemical_growth);
    SELF.electronic_growth_Invalid := Attributes_Fields.InValid_electronic_growth((SALT311.StrType)le.electronic_growth);
    SELF.metal_growth_Invalid := Attributes_Fields.InValid_metal_growth((SALT311.StrType)le.metal_growth);
    SELF.other_m_growth_Invalid := Attributes_Fields.InValid_other_m_growth((SALT311.StrType)le.other_m_growth);
    SELF.packaging_growth_Invalid := Attributes_Fields.InValid_packaging_growth((SALT311.StrType)le.packaging_growth);
    SELF.pvf_growth_Invalid := Attributes_Fields.InValid_pvf_growth((SALT311.StrType)le.pvf_growth);
    SELF.plastic_growth_Invalid := Attributes_Fields.InValid_plastic_growth((SALT311.StrType)le.plastic_growth);
    SELF.textile_growth_Invalid := Attributes_Fields.InValid_textile_growth((SALT311.StrType)le.textile_growth);
    SELF.bs_growth_Invalid := Attributes_Fields.InValid_bs_growth((SALT311.StrType)le.bs_growth);
    SELF.ce_growth_Invalid := Attributes_Fields.InValid_ce_growth((SALT311.StrType)le.ce_growth);
    SELF.hardware_growth_Invalid := Attributes_Fields.InValid_hardware_growth((SALT311.StrType)le.hardware_growth);
    SELF.ie_growth_Invalid := Attributes_Fields.InValid_ie_growth((SALT311.StrType)le.ie_growth);
    SELF.is_growth_Invalid := Attributes_Fields.InValid_is_growth((SALT311.StrType)le.is_growth);
    SELF.it_growth_Invalid := Attributes_Fields.InValid_it_growth((SALT311.StrType)le.it_growth);
    SELF.mls_growth_Invalid := Attributes_Fields.InValid_mls_growth((SALT311.StrType)le.mls_growth);
    SELF.os_growth_Invalid := Attributes_Fields.InValid_os_growth((SALT311.StrType)le.os_growth);
    SELF.pp_growth_Invalid := Attributes_Fields.InValid_pp_growth((SALT311.StrType)le.pp_growth);
    SELF.sis_growth_Invalid := Attributes_Fields.InValid_sis_growth((SALT311.StrType)le.sis_growth);
    SELF.apparel_growth_Invalid := Attributes_Fields.InValid_apparel_growth((SALT311.StrType)le.apparel_growth);
    SELF.beverages_growth_Invalid := Attributes_Fields.InValid_beverages_growth((SALT311.StrType)le.beverages_growth);
    SELF.constr_growth_Invalid := Attributes_Fields.InValid_constr_growth((SALT311.StrType)le.constr_growth);
    SELF.consulting_growth_Invalid := Attributes_Fields.InValid_consulting_growth((SALT311.StrType)le.consulting_growth);
    SELF.fs_growth_Invalid := Attributes_Fields.InValid_fs_growth((SALT311.StrType)le.fs_growth);
    SELF.fp_growth_Invalid := Attributes_Fields.InValid_fp_growth((SALT311.StrType)le.fp_growth);
    SELF.insurance_growth_Invalid := Attributes_Fields.InValid_insurance_growth((SALT311.StrType)le.insurance_growth);
    SELF.ls_growth_Invalid := Attributes_Fields.InValid_ls_growth((SALT311.StrType)le.ls_growth);
    SELF.oil_gas_growth_Invalid := Attributes_Fields.InValid_oil_gas_growth((SALT311.StrType)le.oil_gas_growth);
    SELF.utilities_growth_Invalid := Attributes_Fields.InValid_utilities_growth((SALT311.StrType)le.utilities_growth);
    SELF.other_growth_Invalid := Attributes_Fields.InValid_other_growth((SALT311.StrType)le.other_growth);
    SELF.advt_growth_Invalid := Attributes_Fields.InValid_advt_growth((SALT311.StrType)le.advt_growth);
    SELF.top5_growth_Invalid := Attributes_Fields.InValid_top5_growth((SALT311.StrType)le.top5_growth);
    SELF.shipping_y1_Invalid := Attributes_Fields.InValid_shipping_y1((SALT311.StrType)le.shipping_y1);
    SELF.shipping_growth_Invalid := Attributes_Fields.InValid_shipping_growth((SALT311.StrType)le.shipping_growth);
    SELF.materials_y1_Invalid := Attributes_Fields.InValid_materials_y1((SALT311.StrType)le.materials_y1);
    SELF.materials_growth_Invalid := Attributes_Fields.InValid_materials_growth((SALT311.StrType)le.materials_growth);
    SELF.operations_y1_Invalid := Attributes_Fields.InValid_operations_y1((SALT311.StrType)le.operations_y1);
    SELF.operations_growth_Invalid := Attributes_Fields.InValid_operations_growth((SALT311.StrType)le.operations_growth);
    SELF.total_paid_average_0t12_Invalid := Attributes_Fields.InValid_total_paid_average_0t12((SALT311.StrType)le.total_paid_average_0t12);
    SELF.total_paid_monthspastworst_24_Invalid := Attributes_Fields.InValid_total_paid_monthspastworst_24((SALT311.StrType)le.total_paid_monthspastworst_24);
    SELF.total_paid_slope_0t12_Invalid := Attributes_Fields.InValid_total_paid_slope_0t12((SALT311.StrType)le.total_paid_slope_0t12);
    SELF.total_paid_slope_0t6_Invalid := Attributes_Fields.InValid_total_paid_slope_0t6((SALT311.StrType)le.total_paid_slope_0t6);
    SELF.total_paid_slope_6t12_Invalid := Attributes_Fields.InValid_total_paid_slope_6t12((SALT311.StrType)le.total_paid_slope_6t12);
    SELF.total_paid_slope_6t18_Invalid := Attributes_Fields.InValid_total_paid_slope_6t18((SALT311.StrType)le.total_paid_slope_6t18);
    SELF.total_paid_volatility_0t12_Invalid := Attributes_Fields.InValid_total_paid_volatility_0t12((SALT311.StrType)le.total_paid_volatility_0t12);
    SELF.total_paid_volatility_0t6_Invalid := Attributes_Fields.InValid_total_paid_volatility_0t6((SALT311.StrType)le.total_paid_volatility_0t6);
    SELF.total_paid_volatility_12t18_Invalid := Attributes_Fields.InValid_total_paid_volatility_12t18((SALT311.StrType)le.total_paid_volatility_12t18);
    SELF.total_paid_volatility_6t12_Invalid := Attributes_Fields.InValid_total_paid_volatility_6t12((SALT311.StrType)le.total_paid_volatility_6t12);
    SELF.total_spend_monthspastleast_24_Invalid := Attributes_Fields.InValid_total_spend_monthspastleast_24((SALT311.StrType)le.total_spend_monthspastleast_24);
    SELF.total_spend_monthspastmost_24_Invalid := Attributes_Fields.InValid_total_spend_monthspastmost_24((SALT311.StrType)le.total_spend_monthspastmost_24);
    SELF.total_spend_slope_0t12_Invalid := Attributes_Fields.InValid_total_spend_slope_0t12((SALT311.StrType)le.total_spend_slope_0t12);
    SELF.total_spend_slope_0t24_Invalid := Attributes_Fields.InValid_total_spend_slope_0t24((SALT311.StrType)le.total_spend_slope_0t24);
    SELF.total_spend_slope_0t6_Invalid := Attributes_Fields.InValid_total_spend_slope_0t6((SALT311.StrType)le.total_spend_slope_0t6);
    SELF.total_spend_slope_6t12_Invalid := Attributes_Fields.InValid_total_spend_slope_6t12((SALT311.StrType)le.total_spend_slope_6t12);
    SELF.total_spend_sum_12_Invalid := Attributes_Fields.InValid_total_spend_sum_12((SALT311.StrType)le.total_spend_sum_12);
    SELF.total_spend_volatility_0t12_Invalid := Attributes_Fields.InValid_total_spend_volatility_0t12((SALT311.StrType)le.total_spend_volatility_0t12);
    SELF.total_spend_volatility_0t6_Invalid := Attributes_Fields.InValid_total_spend_volatility_0t6((SALT311.StrType)le.total_spend_volatility_0t6);
    SELF.total_spend_volatility_12t18_Invalid := Attributes_Fields.InValid_total_spend_volatility_12t18((SALT311.StrType)le.total_spend_volatility_12t18);
    SELF.total_spend_volatility_6t12_Invalid := Attributes_Fields.InValid_total_spend_volatility_6t12((SALT311.StrType)le.total_spend_volatility_6t12);
    SELF.mfgmat_paid_average_12_Invalid := Attributes_Fields.InValid_mfgmat_paid_average_12((SALT311.StrType)le.mfgmat_paid_average_12);
    SELF.mfgmat_paid_monthspastworst_24_Invalid := Attributes_Fields.InValid_mfgmat_paid_monthspastworst_24((SALT311.StrType)le.mfgmat_paid_monthspastworst_24);
    SELF.mfgmat_paid_slope_0t12_Invalid := Attributes_Fields.InValid_mfgmat_paid_slope_0t12((SALT311.StrType)le.mfgmat_paid_slope_0t12);
    SELF.mfgmat_paid_slope_0t24_Invalid := Attributes_Fields.InValid_mfgmat_paid_slope_0t24((SALT311.StrType)le.mfgmat_paid_slope_0t24);
    SELF.mfgmat_paid_slope_0t6_Invalid := Attributes_Fields.InValid_mfgmat_paid_slope_0t6((SALT311.StrType)le.mfgmat_paid_slope_0t6);
    SELF.mfgmat_paid_volatility_0t12_Invalid := Attributes_Fields.InValid_mfgmat_paid_volatility_0t12((SALT311.StrType)le.mfgmat_paid_volatility_0t12);
    SELF.mfgmat_paid_volatility_0t6_Invalid := Attributes_Fields.InValid_mfgmat_paid_volatility_0t6((SALT311.StrType)le.mfgmat_paid_volatility_0t6);
    SELF.mfgmat_spend_monthspastleast_24_Invalid := Attributes_Fields.InValid_mfgmat_spend_monthspastleast_24((SALT311.StrType)le.mfgmat_spend_monthspastleast_24);
    SELF.mfgmat_spend_monthspastmost_24_Invalid := Attributes_Fields.InValid_mfgmat_spend_monthspastmost_24((SALT311.StrType)le.mfgmat_spend_monthspastmost_24);
    SELF.mfgmat_spend_slope_0t12_Invalid := Attributes_Fields.InValid_mfgmat_spend_slope_0t12((SALT311.StrType)le.mfgmat_spend_slope_0t12);
    SELF.mfgmat_spend_slope_0t24_Invalid := Attributes_Fields.InValid_mfgmat_spend_slope_0t24((SALT311.StrType)le.mfgmat_spend_slope_0t24);
    SELF.mfgmat_spend_slope_0t6_Invalid := Attributes_Fields.InValid_mfgmat_spend_slope_0t6((SALT311.StrType)le.mfgmat_spend_slope_0t6);
    SELF.mfgmat_spend_sum_12_Invalid := Attributes_Fields.InValid_mfgmat_spend_sum_12((SALT311.StrType)le.mfgmat_spend_sum_12);
    SELF.mfgmat_spend_volatility_0t6_Invalid := Attributes_Fields.InValid_mfgmat_spend_volatility_0t6((SALT311.StrType)le.mfgmat_spend_volatility_0t6);
    SELF.mfgmat_spend_volatility_6t12_Invalid := Attributes_Fields.InValid_mfgmat_spend_volatility_6t12((SALT311.StrType)le.mfgmat_spend_volatility_6t12);
    SELF.ops_paid_average_12_Invalid := Attributes_Fields.InValid_ops_paid_average_12((SALT311.StrType)le.ops_paid_average_12);
    SELF.ops_paid_monthspastworst_24_Invalid := Attributes_Fields.InValid_ops_paid_monthspastworst_24((SALT311.StrType)le.ops_paid_monthspastworst_24);
    SELF.ops_paid_slope_0t12_Invalid := Attributes_Fields.InValid_ops_paid_slope_0t12((SALT311.StrType)le.ops_paid_slope_0t12);
    SELF.ops_paid_slope_0t24_Invalid := Attributes_Fields.InValid_ops_paid_slope_0t24((SALT311.StrType)le.ops_paid_slope_0t24);
    SELF.ops_paid_slope_0t6_Invalid := Attributes_Fields.InValid_ops_paid_slope_0t6((SALT311.StrType)le.ops_paid_slope_0t6);
    SELF.ops_paid_volatility_0t12_Invalid := Attributes_Fields.InValid_ops_paid_volatility_0t12((SALT311.StrType)le.ops_paid_volatility_0t12);
    SELF.ops_paid_volatility_0t6_Invalid := Attributes_Fields.InValid_ops_paid_volatility_0t6((SALT311.StrType)le.ops_paid_volatility_0t6);
    SELF.ops_spend_monthspastleast_24_Invalid := Attributes_Fields.InValid_ops_spend_monthspastleast_24((SALT311.StrType)le.ops_spend_monthspastleast_24);
    SELF.ops_spend_monthspastmost_24_Invalid := Attributes_Fields.InValid_ops_spend_monthspastmost_24((SALT311.StrType)le.ops_spend_monthspastmost_24);
    SELF.ops_spend_slope_0t12_Invalid := Attributes_Fields.InValid_ops_spend_slope_0t12((SALT311.StrType)le.ops_spend_slope_0t12);
    SELF.ops_spend_slope_0t24_Invalid := Attributes_Fields.InValid_ops_spend_slope_0t24((SALT311.StrType)le.ops_spend_slope_0t24);
    SELF.ops_spend_slope_0t6_Invalid := Attributes_Fields.InValid_ops_spend_slope_0t6((SALT311.StrType)le.ops_spend_slope_0t6);
    SELF.fleet_paid_monthspastworst_24_Invalid := Attributes_Fields.InValid_fleet_paid_monthspastworst_24((SALT311.StrType)le.fleet_paid_monthspastworst_24);
    SELF.fleet_paid_slope_0t12_Invalid := Attributes_Fields.InValid_fleet_paid_slope_0t12((SALT311.StrType)le.fleet_paid_slope_0t12);
    SELF.fleet_paid_slope_0t24_Invalid := Attributes_Fields.InValid_fleet_paid_slope_0t24((SALT311.StrType)le.fleet_paid_slope_0t24);
    SELF.fleet_paid_slope_0t6_Invalid := Attributes_Fields.InValid_fleet_paid_slope_0t6((SALT311.StrType)le.fleet_paid_slope_0t6);
    SELF.fleet_paid_volatility_0t12_Invalid := Attributes_Fields.InValid_fleet_paid_volatility_0t12((SALT311.StrType)le.fleet_paid_volatility_0t12);
    SELF.fleet_paid_volatility_0t6_Invalid := Attributes_Fields.InValid_fleet_paid_volatility_0t6((SALT311.StrType)le.fleet_paid_volatility_0t6);
    SELF.fleet_spend_slope_0t12_Invalid := Attributes_Fields.InValid_fleet_spend_slope_0t12((SALT311.StrType)le.fleet_spend_slope_0t12);
    SELF.fleet_spend_slope_0t24_Invalid := Attributes_Fields.InValid_fleet_spend_slope_0t24((SALT311.StrType)le.fleet_spend_slope_0t24);
    SELF.fleet_spend_slope_0t6_Invalid := Attributes_Fields.InValid_fleet_spend_slope_0t6((SALT311.StrType)le.fleet_spend_slope_0t6);
    SELF.carrier_paid_slope_0t12_Invalid := Attributes_Fields.InValid_carrier_paid_slope_0t12((SALT311.StrType)le.carrier_paid_slope_0t12);
    SELF.carrier_paid_slope_0t24_Invalid := Attributes_Fields.InValid_carrier_paid_slope_0t24((SALT311.StrType)le.carrier_paid_slope_0t24);
    SELF.carrier_paid_slope_0t6_Invalid := Attributes_Fields.InValid_carrier_paid_slope_0t6((SALT311.StrType)le.carrier_paid_slope_0t6);
    SELF.carrier_paid_volatility_0t12_Invalid := Attributes_Fields.InValid_carrier_paid_volatility_0t12((SALT311.StrType)le.carrier_paid_volatility_0t12);
    SELF.carrier_paid_volatility_0t6_Invalid := Attributes_Fields.InValid_carrier_paid_volatility_0t6((SALT311.StrType)le.carrier_paid_volatility_0t6);
    SELF.carrier_spend_slope_0t12_Invalid := Attributes_Fields.InValid_carrier_spend_slope_0t12((SALT311.StrType)le.carrier_spend_slope_0t12);
    SELF.carrier_spend_slope_0t24_Invalid := Attributes_Fields.InValid_carrier_spend_slope_0t24((SALT311.StrType)le.carrier_spend_slope_0t24);
    SELF.carrier_spend_slope_0t6_Invalid := Attributes_Fields.InValid_carrier_spend_slope_0t6((SALT311.StrType)le.carrier_spend_slope_0t6);
    SELF.carrier_spend_volatility_0t6_Invalid := Attributes_Fields.InValid_carrier_spend_volatility_0t6((SALT311.StrType)le.carrier_spend_volatility_0t6);
    SELF.carrier_spend_volatility_6t12_Invalid := Attributes_Fields.InValid_carrier_spend_volatility_6t12((SALT311.StrType)le.carrier_spend_volatility_6t12);
    SELF.bldgmats_paid_slope_0t12_Invalid := Attributes_Fields.InValid_bldgmats_paid_slope_0t12((SALT311.StrType)le.bldgmats_paid_slope_0t12);
    SELF.bldgmats_paid_slope_0t24_Invalid := Attributes_Fields.InValid_bldgmats_paid_slope_0t24((SALT311.StrType)le.bldgmats_paid_slope_0t24);
    SELF.bldgmats_paid_slope_0t6_Invalid := Attributes_Fields.InValid_bldgmats_paid_slope_0t6((SALT311.StrType)le.bldgmats_paid_slope_0t6);
    SELF.bldgmats_paid_volatility_0t12_Invalid := Attributes_Fields.InValid_bldgmats_paid_volatility_0t12((SALT311.StrType)le.bldgmats_paid_volatility_0t12);
    SELF.bldgmats_paid_volatility_0t6_Invalid := Attributes_Fields.InValid_bldgmats_paid_volatility_0t6((SALT311.StrType)le.bldgmats_paid_volatility_0t6);
    SELF.bldgmats_spend_slope_0t12_Invalid := Attributes_Fields.InValid_bldgmats_spend_slope_0t12((SALT311.StrType)le.bldgmats_spend_slope_0t12);
    SELF.bldgmats_spend_slope_0t24_Invalid := Attributes_Fields.InValid_bldgmats_spend_slope_0t24((SALT311.StrType)le.bldgmats_spend_slope_0t24);
    SELF.bldgmats_spend_slope_0t6_Invalid := Attributes_Fields.InValid_bldgmats_spend_slope_0t6((SALT311.StrType)le.bldgmats_spend_slope_0t6);
    SELF.bldgmats_spend_volatility_0t6_Invalid := Attributes_Fields.InValid_bldgmats_spend_volatility_0t6((SALT311.StrType)le.bldgmats_spend_volatility_0t6);
    SELF.bldgmats_spend_volatility_6t12_Invalid := Attributes_Fields.InValid_bldgmats_spend_volatility_6t12((SALT311.StrType)le.bldgmats_spend_volatility_6t12);
    SELF.top5_paid_slope_0t12_Invalid := Attributes_Fields.InValid_top5_paid_slope_0t12((SALT311.StrType)le.top5_paid_slope_0t12);
    SELF.top5_paid_slope_0t24_Invalid := Attributes_Fields.InValid_top5_paid_slope_0t24((SALT311.StrType)le.top5_paid_slope_0t24);
    SELF.top5_paid_slope_0t6_Invalid := Attributes_Fields.InValid_top5_paid_slope_0t6((SALT311.StrType)le.top5_paid_slope_0t6);
    SELF.top5_paid_volatility_0t12_Invalid := Attributes_Fields.InValid_top5_paid_volatility_0t12((SALT311.StrType)le.top5_paid_volatility_0t12);
    SELF.top5_paid_volatility_0t6_Invalid := Attributes_Fields.InValid_top5_paid_volatility_0t6((SALT311.StrType)le.top5_paid_volatility_0t6);
    SELF.top5_spend_slope_0t12_Invalid := Attributes_Fields.InValid_top5_spend_slope_0t12((SALT311.StrType)le.top5_spend_slope_0t12);
    SELF.top5_spend_slope_0t24_Invalid := Attributes_Fields.InValid_top5_spend_slope_0t24((SALT311.StrType)le.top5_spend_slope_0t24);
    SELF.top5_spend_slope_0t6_Invalid := Attributes_Fields.InValid_top5_spend_slope_0t6((SALT311.StrType)le.top5_spend_slope_0t6);
    SELF.top5_spend_volatility_0t6_Invalid := Attributes_Fields.InValid_top5_spend_volatility_0t6((SALT311.StrType)le.top5_spend_volatility_0t6);
    SELF.top5_spend_volatility_6t12_Invalid := Attributes_Fields.InValid_top5_spend_volatility_6t12((SALT311.StrType)le.top5_spend_volatility_6t12);
    SELF.total_numrel_slope_0t12_Invalid := Attributes_Fields.InValid_total_numrel_slope_0t12((SALT311.StrType)le.total_numrel_slope_0t12);
    SELF.total_numrel_slope_0t24_Invalid := Attributes_Fields.InValid_total_numrel_slope_0t24((SALT311.StrType)le.total_numrel_slope_0t24);
    SELF.total_numrel_slope_0t6_Invalid := Attributes_Fields.InValid_total_numrel_slope_0t6((SALT311.StrType)le.total_numrel_slope_0t6);
    SELF.total_numrel_slope_6t12_Invalid := Attributes_Fields.InValid_total_numrel_slope_6t12((SALT311.StrType)le.total_numrel_slope_6t12);
    SELF.mfgmat_numrel_slope_0t12_Invalid := Attributes_Fields.InValid_mfgmat_numrel_slope_0t12((SALT311.StrType)le.mfgmat_numrel_slope_0t12);
    SELF.mfgmat_numrel_slope_0t24_Invalid := Attributes_Fields.InValid_mfgmat_numrel_slope_0t24((SALT311.StrType)le.mfgmat_numrel_slope_0t24);
    SELF.mfgmat_numrel_slope_0t6_Invalid := Attributes_Fields.InValid_mfgmat_numrel_slope_0t6((SALT311.StrType)le.mfgmat_numrel_slope_0t6);
    SELF.mfgmat_numrel_slope_6t12_Invalid := Attributes_Fields.InValid_mfgmat_numrel_slope_6t12((SALT311.StrType)le.mfgmat_numrel_slope_6t12);
    SELF.ops_numrel_slope_0t12_Invalid := Attributes_Fields.InValid_ops_numrel_slope_0t12((SALT311.StrType)le.ops_numrel_slope_0t12);
    SELF.ops_numrel_slope_0t24_Invalid := Attributes_Fields.InValid_ops_numrel_slope_0t24((SALT311.StrType)le.ops_numrel_slope_0t24);
    SELF.ops_numrel_slope_0t6_Invalid := Attributes_Fields.InValid_ops_numrel_slope_0t6((SALT311.StrType)le.ops_numrel_slope_0t6);
    SELF.ops_numrel_slope_6t12_Invalid := Attributes_Fields.InValid_ops_numrel_slope_6t12((SALT311.StrType)le.ops_numrel_slope_6t12);
    SELF.fleet_numrel_slope_0t12_Invalid := Attributes_Fields.InValid_fleet_numrel_slope_0t12((SALT311.StrType)le.fleet_numrel_slope_0t12);
    SELF.fleet_numrel_slope_0t24_Invalid := Attributes_Fields.InValid_fleet_numrel_slope_0t24((SALT311.StrType)le.fleet_numrel_slope_0t24);
    SELF.fleet_numrel_slope_0t6_Invalid := Attributes_Fields.InValid_fleet_numrel_slope_0t6((SALT311.StrType)le.fleet_numrel_slope_0t6);
    SELF.fleet_numrel_slope_6t12_Invalid := Attributes_Fields.InValid_fleet_numrel_slope_6t12((SALT311.StrType)le.fleet_numrel_slope_6t12);
    SELF.carrier_numrel_slope_0t12_Invalid := Attributes_Fields.InValid_carrier_numrel_slope_0t12((SALT311.StrType)le.carrier_numrel_slope_0t12);
    SELF.carrier_numrel_slope_0t24_Invalid := Attributes_Fields.InValid_carrier_numrel_slope_0t24((SALT311.StrType)le.carrier_numrel_slope_0t24);
    SELF.carrier_numrel_slope_0t6_Invalid := Attributes_Fields.InValid_carrier_numrel_slope_0t6((SALT311.StrType)le.carrier_numrel_slope_0t6);
    SELF.carrier_numrel_slope_6t12_Invalid := Attributes_Fields.InValid_carrier_numrel_slope_6t12((SALT311.StrType)le.carrier_numrel_slope_6t12);
    SELF.bldgmats_numrel_slope_0t12_Invalid := Attributes_Fields.InValid_bldgmats_numrel_slope_0t12((SALT311.StrType)le.bldgmats_numrel_slope_0t12);
    SELF.bldgmats_numrel_slope_0t24_Invalid := Attributes_Fields.InValid_bldgmats_numrel_slope_0t24((SALT311.StrType)le.bldgmats_numrel_slope_0t24);
    SELF.bldgmats_numrel_slope_0t6_Invalid := Attributes_Fields.InValid_bldgmats_numrel_slope_0t6((SALT311.StrType)le.bldgmats_numrel_slope_0t6);
    SELF.bldgmats_numrel_slope_6t12_Invalid := Attributes_Fields.InValid_bldgmats_numrel_slope_6t12((SALT311.StrType)le.bldgmats_numrel_slope_6t12);
    SELF.bldgmats_numrel_var_0t12_Invalid := Attributes_Fields.InValid_bldgmats_numrel_var_0t12((SALT311.StrType)le.bldgmats_numrel_var_0t12);
    SELF.bldgmats_numrel_var_12t24_Invalid := Attributes_Fields.InValid_bldgmats_numrel_var_12t24((SALT311.StrType)le.bldgmats_numrel_var_12t24);
    SELF.total_percprov30_slope_0t12_Invalid := Attributes_Fields.InValid_total_percprov30_slope_0t12((SALT311.StrType)le.total_percprov30_slope_0t12);
    SELF.total_percprov30_slope_0t24_Invalid := Attributes_Fields.InValid_total_percprov30_slope_0t24((SALT311.StrType)le.total_percprov30_slope_0t24);
    SELF.total_percprov30_slope_0t6_Invalid := Attributes_Fields.InValid_total_percprov30_slope_0t6((SALT311.StrType)le.total_percprov30_slope_0t6);
    SELF.total_percprov30_slope_6t12_Invalid := Attributes_Fields.InValid_total_percprov30_slope_6t12((SALT311.StrType)le.total_percprov30_slope_6t12);
    SELF.total_percprov60_slope_0t12_Invalid := Attributes_Fields.InValid_total_percprov60_slope_0t12((SALT311.StrType)le.total_percprov60_slope_0t12);
    SELF.total_percprov60_slope_0t24_Invalid := Attributes_Fields.InValid_total_percprov60_slope_0t24((SALT311.StrType)le.total_percprov60_slope_0t24);
    SELF.total_percprov60_slope_0t6_Invalid := Attributes_Fields.InValid_total_percprov60_slope_0t6((SALT311.StrType)le.total_percprov60_slope_0t6);
    SELF.total_percprov60_slope_6t12_Invalid := Attributes_Fields.InValid_total_percprov60_slope_6t12((SALT311.StrType)le.total_percprov60_slope_6t12);
    SELF.total_percprov90_slope_0t24_Invalid := Attributes_Fields.InValid_total_percprov90_slope_0t24((SALT311.StrType)le.total_percprov90_slope_0t24);
    SELF.total_percprov90_slope_0t6_Invalid := Attributes_Fields.InValid_total_percprov90_slope_0t6((SALT311.StrType)le.total_percprov90_slope_0t6);
    SELF.total_percprov90_slope_6t12_Invalid := Attributes_Fields.InValid_total_percprov90_slope_6t12((SALT311.StrType)le.total_percprov90_slope_6t12);
    SELF.mfgmat_percprov30_slope_0t12_Invalid := Attributes_Fields.InValid_mfgmat_percprov30_slope_0t12((SALT311.StrType)le.mfgmat_percprov30_slope_0t12);
    SELF.mfgmat_percprov30_slope_6t12_Invalid := Attributes_Fields.InValid_mfgmat_percprov30_slope_6t12((SALT311.StrType)le.mfgmat_percprov30_slope_6t12);
    SELF.mfgmat_percprov60_slope_0t12_Invalid := Attributes_Fields.InValid_mfgmat_percprov60_slope_0t12((SALT311.StrType)le.mfgmat_percprov60_slope_0t12);
    SELF.mfgmat_percprov60_slope_6t12_Invalid := Attributes_Fields.InValid_mfgmat_percprov60_slope_6t12((SALT311.StrType)le.mfgmat_percprov60_slope_6t12);
    SELF.mfgmat_percprov90_slope_0t24_Invalid := Attributes_Fields.InValid_mfgmat_percprov90_slope_0t24((SALT311.StrType)le.mfgmat_percprov90_slope_0t24);
    SELF.mfgmat_percprov90_slope_0t6_Invalid := Attributes_Fields.InValid_mfgmat_percprov90_slope_0t6((SALT311.StrType)le.mfgmat_percprov90_slope_0t6);
    SELF.mfgmat_percprov90_slope_6t12_Invalid := Attributes_Fields.InValid_mfgmat_percprov90_slope_6t12((SALT311.StrType)le.mfgmat_percprov90_slope_6t12);
    SELF.ops_percprov30_slope_0t12_Invalid := Attributes_Fields.InValid_ops_percprov30_slope_0t12((SALT311.StrType)le.ops_percprov30_slope_0t12);
    SELF.ops_percprov30_slope_6t12_Invalid := Attributes_Fields.InValid_ops_percprov30_slope_6t12((SALT311.StrType)le.ops_percprov30_slope_6t12);
    SELF.ops_percprov60_slope_0t12_Invalid := Attributes_Fields.InValid_ops_percprov60_slope_0t12((SALT311.StrType)le.ops_percprov60_slope_0t12);
    SELF.ops_percprov60_slope_6t12_Invalid := Attributes_Fields.InValid_ops_percprov60_slope_6t12((SALT311.StrType)le.ops_percprov60_slope_6t12);
    SELF.ops_percprov90_slope_0t24_Invalid := Attributes_Fields.InValid_ops_percprov90_slope_0t24((SALT311.StrType)le.ops_percprov90_slope_0t24);
    SELF.ops_percprov90_slope_0t6_Invalid := Attributes_Fields.InValid_ops_percprov90_slope_0t6((SALT311.StrType)le.ops_percprov90_slope_0t6);
    SELF.ops_percprov90_slope_6t12_Invalid := Attributes_Fields.InValid_ops_percprov90_slope_6t12((SALT311.StrType)le.ops_percprov90_slope_6t12);
    SELF.fleet_percprov30_slope_0t12_Invalid := Attributes_Fields.InValid_fleet_percprov30_slope_0t12((SALT311.StrType)le.fleet_percprov30_slope_0t12);
    SELF.fleet_percprov30_slope_6t12_Invalid := Attributes_Fields.InValid_fleet_percprov30_slope_6t12((SALT311.StrType)le.fleet_percprov30_slope_6t12);
    SELF.fleet_percprov60_slope_0t12_Invalid := Attributes_Fields.InValid_fleet_percprov60_slope_0t12((SALT311.StrType)le.fleet_percprov60_slope_0t12);
    SELF.fleet_percprov60_slope_6t12_Invalid := Attributes_Fields.InValid_fleet_percprov60_slope_6t12((SALT311.StrType)le.fleet_percprov60_slope_6t12);
    SELF.fleet_percprov90_slope_0t24_Invalid := Attributes_Fields.InValid_fleet_percprov90_slope_0t24((SALT311.StrType)le.fleet_percprov90_slope_0t24);
    SELF.fleet_percprov90_slope_0t6_Invalid := Attributes_Fields.InValid_fleet_percprov90_slope_0t6((SALT311.StrType)le.fleet_percprov90_slope_0t6);
    SELF.fleet_percprov90_slope_6t12_Invalid := Attributes_Fields.InValid_fleet_percprov90_slope_6t12((SALT311.StrType)le.fleet_percprov90_slope_6t12);
    SELF.carrier_percprov30_slope_0t12_Invalid := Attributes_Fields.InValid_carrier_percprov30_slope_0t12((SALT311.StrType)le.carrier_percprov30_slope_0t12);
    SELF.carrier_percprov30_slope_6t12_Invalid := Attributes_Fields.InValid_carrier_percprov30_slope_6t12((SALT311.StrType)le.carrier_percprov30_slope_6t12);
    SELF.carrier_percprov60_slope_0t12_Invalid := Attributes_Fields.InValid_carrier_percprov60_slope_0t12((SALT311.StrType)le.carrier_percprov60_slope_0t12);
    SELF.carrier_percprov60_slope_6t12_Invalid := Attributes_Fields.InValid_carrier_percprov60_slope_6t12((SALT311.StrType)le.carrier_percprov60_slope_6t12);
    SELF.carrier_percprov90_slope_0t24_Invalid := Attributes_Fields.InValid_carrier_percprov90_slope_0t24((SALT311.StrType)le.carrier_percprov90_slope_0t24);
    SELF.carrier_percprov90_slope_0t6_Invalid := Attributes_Fields.InValid_carrier_percprov90_slope_0t6((SALT311.StrType)le.carrier_percprov90_slope_0t6);
    SELF.carrier_percprov90_slope_6t12_Invalid := Attributes_Fields.InValid_carrier_percprov90_slope_6t12((SALT311.StrType)le.carrier_percprov90_slope_6t12);
    SELF.bldgmats_percprov30_slope_0t12_Invalid := Attributes_Fields.InValid_bldgmats_percprov30_slope_0t12((SALT311.StrType)le.bldgmats_percprov30_slope_0t12);
    SELF.bldgmats_percprov30_slope_6t12_Invalid := Attributes_Fields.InValid_bldgmats_percprov30_slope_6t12((SALT311.StrType)le.bldgmats_percprov30_slope_6t12);
    SELF.bldgmats_percprov60_slope_0t12_Invalid := Attributes_Fields.InValid_bldgmats_percprov60_slope_0t12((SALT311.StrType)le.bldgmats_percprov60_slope_0t12);
    SELF.bldgmats_percprov60_slope_6t12_Invalid := Attributes_Fields.InValid_bldgmats_percprov60_slope_6t12((SALT311.StrType)le.bldgmats_percprov60_slope_6t12);
    SELF.bldgmats_percprov90_slope_0t24_Invalid := Attributes_Fields.InValid_bldgmats_percprov90_slope_0t24((SALT311.StrType)le.bldgmats_percprov90_slope_0t24);
    SELF.bldgmats_percprov90_slope_0t6_Invalid := Attributes_Fields.InValid_bldgmats_percprov90_slope_0t6((SALT311.StrType)le.bldgmats_percprov90_slope_0t6);
    SELF.bldgmats_percprov90_slope_6t12_Invalid := Attributes_Fields.InValid_bldgmats_percprov90_slope_6t12((SALT311.StrType)le.bldgmats_percprov90_slope_6t12);
    SELF.top5_percprov30_slope_0t12_Invalid := Attributes_Fields.InValid_top5_percprov30_slope_0t12((SALT311.StrType)le.top5_percprov30_slope_0t12);
    SELF.top5_percprov30_slope_6t12_Invalid := Attributes_Fields.InValid_top5_percprov30_slope_6t12((SALT311.StrType)le.top5_percprov30_slope_6t12);
    SELF.top5_percprov60_slope_0t12_Invalid := Attributes_Fields.InValid_top5_percprov60_slope_0t12((SALT311.StrType)le.top5_percprov60_slope_0t12);
    SELF.top5_percprov60_slope_6t12_Invalid := Attributes_Fields.InValid_top5_percprov60_slope_6t12((SALT311.StrType)le.top5_percprov60_slope_6t12);
    SELF.top5_percprov90_slope_0t24_Invalid := Attributes_Fields.InValid_top5_percprov90_slope_0t24((SALT311.StrType)le.top5_percprov90_slope_0t24);
    SELF.top5_percprov90_slope_0t6_Invalid := Attributes_Fields.InValid_top5_percprov90_slope_0t6((SALT311.StrType)le.top5_percprov90_slope_0t6);
    SELF.top5_percprov90_slope_6t12_Invalid := Attributes_Fields.InValid_top5_percprov90_slope_6t12((SALT311.StrType)le.top5_percprov90_slope_6t12);
    SELF.top5_percprovoutstanding_adjustedslope_0t12_Invalid := Attributes_Fields.InValid_top5_percprovoutstanding_adjustedslope_0t12((SALT311.StrType)le.top5_percprovoutstanding_adjustedslope_0t12);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Attributes_Layout_Cortera);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.ultimate_linkid_Invalid << 0 ) + ( le.cortera_score_Invalid << 1 ) + ( le.cpr_score_Invalid << 2 ) + ( le.cpr_segment_Invalid << 3 ) + ( le.dbt_Invalid << 4 ) + ( le.avg_bal_Invalid << 6 ) + ( le.air_spend_Invalid << 7 ) + ( le.fuel_spend_Invalid << 8 ) + ( le.leasing_spend_Invalid << 9 ) + ( le.ltl_spend_Invalid << 10 ) + ( le.rail_spend_Invalid << 11 ) + ( le.tl_spend_Invalid << 12 ) + ( le.transvc_spend_Invalid << 13 ) + ( le.transup_spend_Invalid << 14 ) + ( le.bst_spend_Invalid << 15 ) + ( le.dg_spend_Invalid << 16 ) + ( le.electrical_spend_Invalid << 17 ) + ( le.hvac_spend_Invalid << 18 ) + ( le.other_b_spend_Invalid << 19 ) + ( le.plumbing_spend_Invalid << 20 ) + ( le.rs_spend_Invalid << 21 ) + ( le.wp_spend_Invalid << 22 ) + ( le.chemical_spend_Invalid << 23 ) + ( le.electronic_spend_Invalid << 24 ) + ( le.metal_spend_Invalid << 25 ) + ( le.other_m_spend_Invalid << 26 ) + ( le.packaging_spend_Invalid << 27 ) + ( le.pvf_spend_Invalid << 28 ) + ( le.plastic_spend_Invalid << 29 ) + ( le.textile_spend_Invalid << 30 ) + ( le.bs_spend_Invalid << 31 ) + ( le.ce_spend_Invalid << 32 ) + ( le.hardware_spend_Invalid << 33 ) + ( le.ie_spend_Invalid << 34 ) + ( le.is_spend_Invalid << 35 ) + ( le.it_spend_Invalid << 36 ) + ( le.mls_spend_Invalid << 37 ) + ( le.os_spend_Invalid << 38 ) + ( le.pp_spend_Invalid << 39 ) + ( le.sis_spend_Invalid << 40 ) + ( le.apparel_spend_Invalid << 41 ) + ( le.beverages_spend_Invalid << 42 ) + ( le.constr_spend_Invalid << 43 ) + ( le.consulting_spend_Invalid << 44 ) + ( le.fs_spend_Invalid << 45 ) + ( le.fp_spend_Invalid << 46 ) + ( le.insurance_spend_Invalid << 47 ) + ( le.ls_spend_Invalid << 48 ) + ( le.oil_gas_spend_Invalid << 49 ) + ( le.utilities_spend_Invalid << 50 ) + ( le.other_spend_Invalid << 51 ) + ( le.advt_spend_Invalid << 52 ) + ( le.air_growth_Invalid << 53 ) + ( le.fuel_growth_Invalid << 55 ) + ( le.leasing_growth_Invalid << 57 ) + ( le.ltl_growth_Invalid << 59 ) + ( le.rail_growth_Invalid << 61 );
    SELF.ScrubsBits2 := ( le.tl_growth_Invalid << 0 ) + ( le.transvc_growth_Invalid << 2 ) + ( le.transup_growth_Invalid << 4 ) + ( le.bst_growth_Invalid << 6 ) + ( le.dg_growth_Invalid << 8 ) + ( le.electrical_growth_Invalid << 10 ) + ( le.hvac_growth_Invalid << 12 ) + ( le.other_b_growth_Invalid << 14 ) + ( le.plumbing_growth_Invalid << 16 ) + ( le.rs_growth_Invalid << 18 ) + ( le.wp_growth_Invalid << 20 ) + ( le.chemical_growth_Invalid << 22 ) + ( le.electronic_growth_Invalid << 24 ) + ( le.metal_growth_Invalid << 26 ) + ( le.other_m_growth_Invalid << 28 ) + ( le.packaging_growth_Invalid << 30 ) + ( le.pvf_growth_Invalid << 32 ) + ( le.plastic_growth_Invalid << 34 ) + ( le.textile_growth_Invalid << 36 ) + ( le.bs_growth_Invalid << 38 ) + ( le.ce_growth_Invalid << 40 ) + ( le.hardware_growth_Invalid << 42 ) + ( le.ie_growth_Invalid << 44 ) + ( le.is_growth_Invalid << 46 ) + ( le.it_growth_Invalid << 48 ) + ( le.mls_growth_Invalid << 50 ) + ( le.os_growth_Invalid << 52 ) + ( le.pp_growth_Invalid << 54 ) + ( le.sis_growth_Invalid << 56 ) + ( le.apparel_growth_Invalid << 58 ) + ( le.beverages_growth_Invalid << 60 ) + ( le.constr_growth_Invalid << 62 );
    SELF.ScrubsBits3 := ( le.consulting_growth_Invalid << 0 ) + ( le.fs_growth_Invalid << 2 ) + ( le.fp_growth_Invalid << 4 ) + ( le.insurance_growth_Invalid << 6 ) + ( le.ls_growth_Invalid << 8 ) + ( le.oil_gas_growth_Invalid << 10 ) + ( le.utilities_growth_Invalid << 12 ) + ( le.other_growth_Invalid << 14 ) + ( le.advt_growth_Invalid << 16 ) + ( le.top5_growth_Invalid << 18 ) + ( le.shipping_y1_Invalid << 20 ) + ( le.shipping_growth_Invalid << 21 ) + ( le.materials_y1_Invalid << 23 ) + ( le.materials_growth_Invalid << 24 ) + ( le.operations_y1_Invalid << 26 ) + ( le.operations_growth_Invalid << 27 ) + ( le.total_paid_average_0t12_Invalid << 29 ) + ( le.total_paid_monthspastworst_24_Invalid << 31 ) + ( le.total_paid_slope_0t12_Invalid << 33 ) + ( le.total_paid_slope_0t6_Invalid << 35 ) + ( le.total_paid_slope_6t12_Invalid << 37 ) + ( le.total_paid_slope_6t18_Invalid << 39 ) + ( le.total_paid_volatility_0t12_Invalid << 41 ) + ( le.total_paid_volatility_0t6_Invalid << 43 ) + ( le.total_paid_volatility_12t18_Invalid << 45 ) + ( le.total_paid_volatility_6t12_Invalid << 47 ) + ( le.total_spend_monthspastleast_24_Invalid << 49 ) + ( le.total_spend_monthspastmost_24_Invalid << 50 ) + ( le.total_spend_slope_0t12_Invalid << 51 ) + ( le.total_spend_slope_0t24_Invalid << 53 ) + ( le.total_spend_slope_0t6_Invalid << 55 ) + ( le.total_spend_slope_6t12_Invalid << 57 ) + ( le.total_spend_sum_12_Invalid << 59 ) + ( le.total_spend_volatility_0t12_Invalid << 61 );
    SELF.ScrubsBits4 := ( le.total_spend_volatility_0t6_Invalid << 0 ) + ( le.total_spend_volatility_12t18_Invalid << 2 ) + ( le.total_spend_volatility_6t12_Invalid << 4 ) + ( le.mfgmat_paid_average_12_Invalid << 6 ) + ( le.mfgmat_paid_monthspastworst_24_Invalid << 8 ) + ( le.mfgmat_paid_slope_0t12_Invalid << 9 ) + ( le.mfgmat_paid_slope_0t24_Invalid << 11 ) + ( le.mfgmat_paid_slope_0t6_Invalid << 13 ) + ( le.mfgmat_paid_volatility_0t12_Invalid << 15 ) + ( le.mfgmat_paid_volatility_0t6_Invalid << 17 ) + ( le.mfgmat_spend_monthspastleast_24_Invalid << 19 ) + ( le.mfgmat_spend_monthspastmost_24_Invalid << 20 ) + ( le.mfgmat_spend_slope_0t12_Invalid << 21 ) + ( le.mfgmat_spend_slope_0t24_Invalid << 23 ) + ( le.mfgmat_spend_slope_0t6_Invalid << 25 ) + ( le.mfgmat_spend_sum_12_Invalid << 27 ) + ( le.mfgmat_spend_volatility_0t6_Invalid << 29 ) + ( le.mfgmat_spend_volatility_6t12_Invalid << 31 ) + ( le.ops_paid_average_12_Invalid << 33 ) + ( le.ops_paid_monthspastworst_24_Invalid << 35 ) + ( le.ops_paid_slope_0t12_Invalid << 37 ) + ( le.ops_paid_slope_0t24_Invalid << 39 ) + ( le.ops_paid_slope_0t6_Invalid << 41 ) + ( le.ops_paid_volatility_0t12_Invalid << 43 ) + ( le.ops_paid_volatility_0t6_Invalid << 45 ) + ( le.ops_spend_monthspastleast_24_Invalid << 47 ) + ( le.ops_spend_monthspastmost_24_Invalid << 48 ) + ( le.ops_spend_slope_0t12_Invalid << 49 ) + ( le.ops_spend_slope_0t24_Invalid << 51 ) + ( le.ops_spend_slope_0t6_Invalid << 53 ) + ( le.fleet_paid_monthspastworst_24_Invalid << 55 ) + ( le.fleet_paid_slope_0t12_Invalid << 56 ) + ( le.fleet_paid_slope_0t24_Invalid << 58 ) + ( le.fleet_paid_slope_0t6_Invalid << 60 ) + ( le.fleet_paid_volatility_0t12_Invalid << 62 );
    SELF.ScrubsBits5 := ( le.fleet_paid_volatility_0t6_Invalid << 0 ) + ( le.fleet_spend_slope_0t12_Invalid << 2 ) + ( le.fleet_spend_slope_0t24_Invalid << 4 ) + ( le.fleet_spend_slope_0t6_Invalid << 6 ) + ( le.carrier_paid_slope_0t12_Invalid << 8 ) + ( le.carrier_paid_slope_0t24_Invalid << 10 ) + ( le.carrier_paid_slope_0t6_Invalid << 12 ) + ( le.carrier_paid_volatility_0t12_Invalid << 14 ) + ( le.carrier_paid_volatility_0t6_Invalid << 16 ) + ( le.carrier_spend_slope_0t12_Invalid << 18 ) + ( le.carrier_spend_slope_0t24_Invalid << 20 ) + ( le.carrier_spend_slope_0t6_Invalid << 22 ) + ( le.carrier_spend_volatility_0t6_Invalid << 24 ) + ( le.carrier_spend_volatility_6t12_Invalid << 26 ) + ( le.bldgmats_paid_slope_0t12_Invalid << 28 ) + ( le.bldgmats_paid_slope_0t24_Invalid << 30 ) + ( le.bldgmats_paid_slope_0t6_Invalid << 32 ) + ( le.bldgmats_paid_volatility_0t12_Invalid << 34 ) + ( le.bldgmats_paid_volatility_0t6_Invalid << 36 ) + ( le.bldgmats_spend_slope_0t12_Invalid << 38 ) + ( le.bldgmats_spend_slope_0t24_Invalid << 40 ) + ( le.bldgmats_spend_slope_0t6_Invalid << 42 ) + ( le.bldgmats_spend_volatility_0t6_Invalid << 44 ) + ( le.bldgmats_spend_volatility_6t12_Invalid << 46 ) + ( le.top5_paid_slope_0t12_Invalid << 48 ) + ( le.top5_paid_slope_0t24_Invalid << 50 ) + ( le.top5_paid_slope_0t6_Invalid << 52 ) + ( le.top5_paid_volatility_0t12_Invalid << 54 ) + ( le.top5_paid_volatility_0t6_Invalid << 56 ) + ( le.top5_spend_slope_0t12_Invalid << 58 ) + ( le.top5_spend_slope_0t24_Invalid << 60 ) + ( le.top5_spend_slope_0t6_Invalid << 62 );
    SELF.ScrubsBits6 := ( le.top5_spend_volatility_0t6_Invalid << 0 ) + ( le.top5_spend_volatility_6t12_Invalid << 2 ) + ( le.total_numrel_slope_0t12_Invalid << 4 ) + ( le.total_numrel_slope_0t24_Invalid << 6 ) + ( le.total_numrel_slope_0t6_Invalid << 8 ) + ( le.total_numrel_slope_6t12_Invalid << 10 ) + ( le.mfgmat_numrel_slope_0t12_Invalid << 12 ) + ( le.mfgmat_numrel_slope_0t24_Invalid << 14 ) + ( le.mfgmat_numrel_slope_0t6_Invalid << 16 ) + ( le.mfgmat_numrel_slope_6t12_Invalid << 18 ) + ( le.ops_numrel_slope_0t12_Invalid << 20 ) + ( le.ops_numrel_slope_0t24_Invalid << 22 ) + ( le.ops_numrel_slope_0t6_Invalid << 24 ) + ( le.ops_numrel_slope_6t12_Invalid << 26 ) + ( le.fleet_numrel_slope_0t12_Invalid << 28 ) + ( le.fleet_numrel_slope_0t24_Invalid << 30 ) + ( le.fleet_numrel_slope_0t6_Invalid << 32 ) + ( le.fleet_numrel_slope_6t12_Invalid << 34 ) + ( le.carrier_numrel_slope_0t12_Invalid << 36 ) + ( le.carrier_numrel_slope_0t24_Invalid << 38 ) + ( le.carrier_numrel_slope_0t6_Invalid << 40 ) + ( le.carrier_numrel_slope_6t12_Invalid << 42 ) + ( le.bldgmats_numrel_slope_0t12_Invalid << 44 ) + ( le.bldgmats_numrel_slope_0t24_Invalid << 46 ) + ( le.bldgmats_numrel_slope_0t6_Invalid << 48 ) + ( le.bldgmats_numrel_slope_6t12_Invalid << 50 ) + ( le.bldgmats_numrel_var_0t12_Invalid << 52 ) + ( le.bldgmats_numrel_var_12t24_Invalid << 54 ) + ( le.total_percprov30_slope_0t12_Invalid << 56 ) + ( le.total_percprov30_slope_0t24_Invalid << 58 ) + ( le.total_percprov30_slope_0t6_Invalid << 60 ) + ( le.total_percprov30_slope_6t12_Invalid << 62 );
    SELF.ScrubsBits7 := ( le.total_percprov60_slope_0t12_Invalid << 0 ) + ( le.total_percprov60_slope_0t24_Invalid << 2 ) + ( le.total_percprov60_slope_0t6_Invalid << 4 ) + ( le.total_percprov60_slope_6t12_Invalid << 6 ) + ( le.total_percprov90_slope_0t24_Invalid << 8 ) + ( le.total_percprov90_slope_0t6_Invalid << 10 ) + ( le.total_percprov90_slope_6t12_Invalid << 12 ) + ( le.mfgmat_percprov30_slope_0t12_Invalid << 14 ) + ( le.mfgmat_percprov30_slope_6t12_Invalid << 16 ) + ( le.mfgmat_percprov60_slope_0t12_Invalid << 18 ) + ( le.mfgmat_percprov60_slope_6t12_Invalid << 20 ) + ( le.mfgmat_percprov90_slope_0t24_Invalid << 22 ) + ( le.mfgmat_percprov90_slope_0t6_Invalid << 24 ) + ( le.mfgmat_percprov90_slope_6t12_Invalid << 26 ) + ( le.ops_percprov30_slope_0t12_Invalid << 28 ) + ( le.ops_percprov30_slope_6t12_Invalid << 30 ) + ( le.ops_percprov60_slope_0t12_Invalid << 32 ) + ( le.ops_percprov60_slope_6t12_Invalid << 34 ) + ( le.ops_percprov90_slope_0t24_Invalid << 36 ) + ( le.ops_percprov90_slope_0t6_Invalid << 38 ) + ( le.ops_percprov90_slope_6t12_Invalid << 40 ) + ( le.fleet_percprov30_slope_0t12_Invalid << 42 ) + ( le.fleet_percprov30_slope_6t12_Invalid << 44 ) + ( le.fleet_percprov60_slope_0t12_Invalid << 46 ) + ( le.fleet_percprov60_slope_6t12_Invalid << 48 ) + ( le.fleet_percprov90_slope_0t24_Invalid << 50 ) + ( le.fleet_percprov90_slope_0t6_Invalid << 52 ) + ( le.fleet_percprov90_slope_6t12_Invalid << 54 ) + ( le.carrier_percprov30_slope_0t12_Invalid << 56 ) + ( le.carrier_percprov30_slope_6t12_Invalid << 58 ) + ( le.carrier_percprov60_slope_0t12_Invalid << 60 ) + ( le.carrier_percprov60_slope_6t12_Invalid << 62 );
    SELF.ScrubsBits8 := ( le.carrier_percprov90_slope_0t24_Invalid << 0 ) + ( le.carrier_percprov90_slope_0t6_Invalid << 2 ) + ( le.carrier_percprov90_slope_6t12_Invalid << 4 ) + ( le.bldgmats_percprov30_slope_0t12_Invalid << 6 ) + ( le.bldgmats_percprov30_slope_6t12_Invalid << 8 ) + ( le.bldgmats_percprov60_slope_0t12_Invalid << 10 ) + ( le.bldgmats_percprov60_slope_6t12_Invalid << 12 ) + ( le.bldgmats_percprov90_slope_0t24_Invalid << 14 ) + ( le.bldgmats_percprov90_slope_0t6_Invalid << 16 ) + ( le.bldgmats_percprov90_slope_6t12_Invalid << 18 ) + ( le.top5_percprov30_slope_0t12_Invalid << 20 ) + ( le.top5_percprov30_slope_6t12_Invalid << 22 ) + ( le.top5_percprov60_slope_0t12_Invalid << 24 ) + ( le.top5_percprov60_slope_6t12_Invalid << 26 ) + ( le.top5_percprov90_slope_0t24_Invalid << 28 ) + ( le.top5_percprov90_slope_0t6_Invalid << 30 ) + ( le.top5_percprov90_slope_6t12_Invalid << 32 ) + ( le.top5_percprovoutstanding_adjustedslope_0t12_Invalid << 34 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Attributes_Layout_Cortera);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.ultimate_linkid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.cortera_score_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.cpr_score_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.cpr_segment_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.dbt_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.avg_bal_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.air_spend_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.fuel_spend_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.leasing_spend_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.ltl_spend_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.rail_spend_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.tl_spend_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.transvc_spend_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.transup_spend_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.bst_spend_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.dg_spend_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.electrical_spend_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.hvac_spend_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.other_b_spend_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.plumbing_spend_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.rs_spend_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.wp_spend_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.chemical_spend_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.electronic_spend_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.metal_spend_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.other_m_spend_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.packaging_spend_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.pvf_spend_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.plastic_spend_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.textile_spend_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.bs_spend_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.ce_spend_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.hardware_spend_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.ie_spend_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.is_spend_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.it_spend_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.mls_spend_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.os_spend_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.pp_spend_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.sis_spend_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.apparel_spend_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.beverages_spend_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.constr_spend_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.consulting_spend_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.fs_spend_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.fp_spend_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.insurance_spend_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.ls_spend_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.oil_gas_spend_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.utilities_spend_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.other_spend_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.advt_spend_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.air_growth_Invalid := (le.ScrubsBits1 >> 53) & 3;
    SELF.fuel_growth_Invalid := (le.ScrubsBits1 >> 55) & 3;
    SELF.leasing_growth_Invalid := (le.ScrubsBits1 >> 57) & 3;
    SELF.ltl_growth_Invalid := (le.ScrubsBits1 >> 59) & 3;
    SELF.rail_growth_Invalid := (le.ScrubsBits1 >> 61) & 3;
    SELF.tl_growth_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.transvc_growth_Invalid := (le.ScrubsBits2 >> 2) & 3;
    SELF.transup_growth_Invalid := (le.ScrubsBits2 >> 4) & 3;
    SELF.bst_growth_Invalid := (le.ScrubsBits2 >> 6) & 3;
    SELF.dg_growth_Invalid := (le.ScrubsBits2 >> 8) & 3;
    SELF.electrical_growth_Invalid := (le.ScrubsBits2 >> 10) & 3;
    SELF.hvac_growth_Invalid := (le.ScrubsBits2 >> 12) & 3;
    SELF.other_b_growth_Invalid := (le.ScrubsBits2 >> 14) & 3;
    SELF.plumbing_growth_Invalid := (le.ScrubsBits2 >> 16) & 3;
    SELF.rs_growth_Invalid := (le.ScrubsBits2 >> 18) & 3;
    SELF.wp_growth_Invalid := (le.ScrubsBits2 >> 20) & 3;
    SELF.chemical_growth_Invalid := (le.ScrubsBits2 >> 22) & 3;
    SELF.electronic_growth_Invalid := (le.ScrubsBits2 >> 24) & 3;
    SELF.metal_growth_Invalid := (le.ScrubsBits2 >> 26) & 3;
    SELF.other_m_growth_Invalid := (le.ScrubsBits2 >> 28) & 3;
    SELF.packaging_growth_Invalid := (le.ScrubsBits2 >> 30) & 3;
    SELF.pvf_growth_Invalid := (le.ScrubsBits2 >> 32) & 3;
    SELF.plastic_growth_Invalid := (le.ScrubsBits2 >> 34) & 3;
    SELF.textile_growth_Invalid := (le.ScrubsBits2 >> 36) & 3;
    SELF.bs_growth_Invalid := (le.ScrubsBits2 >> 38) & 3;
    SELF.ce_growth_Invalid := (le.ScrubsBits2 >> 40) & 3;
    SELF.hardware_growth_Invalid := (le.ScrubsBits2 >> 42) & 3;
    SELF.ie_growth_Invalid := (le.ScrubsBits2 >> 44) & 3;
    SELF.is_growth_Invalid := (le.ScrubsBits2 >> 46) & 3;
    SELF.it_growth_Invalid := (le.ScrubsBits2 >> 48) & 3;
    SELF.mls_growth_Invalid := (le.ScrubsBits2 >> 50) & 3;
    SELF.os_growth_Invalid := (le.ScrubsBits2 >> 52) & 3;
    SELF.pp_growth_Invalid := (le.ScrubsBits2 >> 54) & 3;
    SELF.sis_growth_Invalid := (le.ScrubsBits2 >> 56) & 3;
    SELF.apparel_growth_Invalid := (le.ScrubsBits2 >> 58) & 3;
    SELF.beverages_growth_Invalid := (le.ScrubsBits2 >> 60) & 3;
    SELF.constr_growth_Invalid := (le.ScrubsBits2 >> 62) & 3;
    SELF.consulting_growth_Invalid := (le.ScrubsBits3 >> 0) & 3;
    SELF.fs_growth_Invalid := (le.ScrubsBits3 >> 2) & 3;
    SELF.fp_growth_Invalid := (le.ScrubsBits3 >> 4) & 3;
    SELF.insurance_growth_Invalid := (le.ScrubsBits3 >> 6) & 3;
    SELF.ls_growth_Invalid := (le.ScrubsBits3 >> 8) & 3;
    SELF.oil_gas_growth_Invalid := (le.ScrubsBits3 >> 10) & 3;
    SELF.utilities_growth_Invalid := (le.ScrubsBits3 >> 12) & 3;
    SELF.other_growth_Invalid := (le.ScrubsBits3 >> 14) & 3;
    SELF.advt_growth_Invalid := (le.ScrubsBits3 >> 16) & 3;
    SELF.top5_growth_Invalid := (le.ScrubsBits3 >> 18) & 3;
    SELF.shipping_y1_Invalid := (le.ScrubsBits3 >> 20) & 1;
    SELF.shipping_growth_Invalid := (le.ScrubsBits3 >> 21) & 3;
    SELF.materials_y1_Invalid := (le.ScrubsBits3 >> 23) & 1;
    SELF.materials_growth_Invalid := (le.ScrubsBits3 >> 24) & 3;
    SELF.operations_y1_Invalid := (le.ScrubsBits3 >> 26) & 1;
    SELF.operations_growth_Invalid := (le.ScrubsBits3 >> 27) & 3;
    SELF.total_paid_average_0t12_Invalid := (le.ScrubsBits3 >> 29) & 3;
    SELF.total_paid_monthspastworst_24_Invalid := (le.ScrubsBits3 >> 31) & 3;
    SELF.total_paid_slope_0t12_Invalid := (le.ScrubsBits3 >> 33) & 3;
    SELF.total_paid_slope_0t6_Invalid := (le.ScrubsBits3 >> 35) & 3;
    SELF.total_paid_slope_6t12_Invalid := (le.ScrubsBits3 >> 37) & 3;
    SELF.total_paid_slope_6t18_Invalid := (le.ScrubsBits3 >> 39) & 3;
    SELF.total_paid_volatility_0t12_Invalid := (le.ScrubsBits3 >> 41) & 3;
    SELF.total_paid_volatility_0t6_Invalid := (le.ScrubsBits3 >> 43) & 3;
    SELF.total_paid_volatility_12t18_Invalid := (le.ScrubsBits3 >> 45) & 3;
    SELF.total_paid_volatility_6t12_Invalid := (le.ScrubsBits3 >> 47) & 3;
    SELF.total_spend_monthspastleast_24_Invalid := (le.ScrubsBits3 >> 49) & 1;
    SELF.total_spend_monthspastmost_24_Invalid := (le.ScrubsBits3 >> 50) & 1;
    SELF.total_spend_slope_0t12_Invalid := (le.ScrubsBits3 >> 51) & 3;
    SELF.total_spend_slope_0t24_Invalid := (le.ScrubsBits3 >> 53) & 3;
    SELF.total_spend_slope_0t6_Invalid := (le.ScrubsBits3 >> 55) & 3;
    SELF.total_spend_slope_6t12_Invalid := (le.ScrubsBits3 >> 57) & 3;
    SELF.total_spend_sum_12_Invalid := (le.ScrubsBits3 >> 59) & 3;
    SELF.total_spend_volatility_0t12_Invalid := (le.ScrubsBits3 >> 61) & 3;
    SELF.total_spend_volatility_0t6_Invalid := (le.ScrubsBits4 >> 0) & 3;
    SELF.total_spend_volatility_12t18_Invalid := (le.ScrubsBits4 >> 2) & 3;
    SELF.total_spend_volatility_6t12_Invalid := (le.ScrubsBits4 >> 4) & 3;
    SELF.mfgmat_paid_average_12_Invalid := (le.ScrubsBits4 >> 6) & 3;
    SELF.mfgmat_paid_monthspastworst_24_Invalid := (le.ScrubsBits4 >> 8) & 1;
    SELF.mfgmat_paid_slope_0t12_Invalid := (le.ScrubsBits4 >> 9) & 3;
    SELF.mfgmat_paid_slope_0t24_Invalid := (le.ScrubsBits4 >> 11) & 3;
    SELF.mfgmat_paid_slope_0t6_Invalid := (le.ScrubsBits4 >> 13) & 3;
    SELF.mfgmat_paid_volatility_0t12_Invalid := (le.ScrubsBits4 >> 15) & 3;
    SELF.mfgmat_paid_volatility_0t6_Invalid := (le.ScrubsBits4 >> 17) & 3;
    SELF.mfgmat_spend_monthspastleast_24_Invalid := (le.ScrubsBits4 >> 19) & 1;
    SELF.mfgmat_spend_monthspastmost_24_Invalid := (le.ScrubsBits4 >> 20) & 1;
    SELF.mfgmat_spend_slope_0t12_Invalid := (le.ScrubsBits4 >> 21) & 3;
    SELF.mfgmat_spend_slope_0t24_Invalid := (le.ScrubsBits4 >> 23) & 3;
    SELF.mfgmat_spend_slope_0t6_Invalid := (le.ScrubsBits4 >> 25) & 3;
    SELF.mfgmat_spend_sum_12_Invalid := (le.ScrubsBits4 >> 27) & 3;
    SELF.mfgmat_spend_volatility_0t6_Invalid := (le.ScrubsBits4 >> 29) & 3;
    SELF.mfgmat_spend_volatility_6t12_Invalid := (le.ScrubsBits4 >> 31) & 3;
    SELF.ops_paid_average_12_Invalid := (le.ScrubsBits4 >> 33) & 3;
    SELF.ops_paid_monthspastworst_24_Invalid := (le.ScrubsBits4 >> 35) & 3;
    SELF.ops_paid_slope_0t12_Invalid := (le.ScrubsBits4 >> 37) & 3;
    SELF.ops_paid_slope_0t24_Invalid := (le.ScrubsBits4 >> 39) & 3;
    SELF.ops_paid_slope_0t6_Invalid := (le.ScrubsBits4 >> 41) & 3;
    SELF.ops_paid_volatility_0t12_Invalid := (le.ScrubsBits4 >> 43) & 3;
    SELF.ops_paid_volatility_0t6_Invalid := (le.ScrubsBits4 >> 45) & 3;
    SELF.ops_spend_monthspastleast_24_Invalid := (le.ScrubsBits4 >> 47) & 1;
    SELF.ops_spend_monthspastmost_24_Invalid := (le.ScrubsBits4 >> 48) & 1;
    SELF.ops_spend_slope_0t12_Invalid := (le.ScrubsBits4 >> 49) & 3;
    SELF.ops_spend_slope_0t24_Invalid := (le.ScrubsBits4 >> 51) & 3;
    SELF.ops_spend_slope_0t6_Invalid := (le.ScrubsBits4 >> 53) & 3;
    SELF.fleet_paid_monthspastworst_24_Invalid := (le.ScrubsBits4 >> 55) & 1;
    SELF.fleet_paid_slope_0t12_Invalid := (le.ScrubsBits4 >> 56) & 3;
    SELF.fleet_paid_slope_0t24_Invalid := (le.ScrubsBits4 >> 58) & 3;
    SELF.fleet_paid_slope_0t6_Invalid := (le.ScrubsBits4 >> 60) & 3;
    SELF.fleet_paid_volatility_0t12_Invalid := (le.ScrubsBits4 >> 62) & 3;
    SELF.fleet_paid_volatility_0t6_Invalid := (le.ScrubsBits5 >> 0) & 3;
    SELF.fleet_spend_slope_0t12_Invalid := (le.ScrubsBits5 >> 2) & 3;
    SELF.fleet_spend_slope_0t24_Invalid := (le.ScrubsBits5 >> 4) & 3;
    SELF.fleet_spend_slope_0t6_Invalid := (le.ScrubsBits5 >> 6) & 3;
    SELF.carrier_paid_slope_0t12_Invalid := (le.ScrubsBits5 >> 8) & 3;
    SELF.carrier_paid_slope_0t24_Invalid := (le.ScrubsBits5 >> 10) & 3;
    SELF.carrier_paid_slope_0t6_Invalid := (le.ScrubsBits5 >> 12) & 3;
    SELF.carrier_paid_volatility_0t12_Invalid := (le.ScrubsBits5 >> 14) & 3;
    SELF.carrier_paid_volatility_0t6_Invalid := (le.ScrubsBits5 >> 16) & 3;
    SELF.carrier_spend_slope_0t12_Invalid := (le.ScrubsBits5 >> 18) & 3;
    SELF.carrier_spend_slope_0t24_Invalid := (le.ScrubsBits5 >> 20) & 3;
    SELF.carrier_spend_slope_0t6_Invalid := (le.ScrubsBits5 >> 22) & 3;
    SELF.carrier_spend_volatility_0t6_Invalid := (le.ScrubsBits5 >> 24) & 3;
    SELF.carrier_spend_volatility_6t12_Invalid := (le.ScrubsBits5 >> 26) & 3;
    SELF.bldgmats_paid_slope_0t12_Invalid := (le.ScrubsBits5 >> 28) & 3;
    SELF.bldgmats_paid_slope_0t24_Invalid := (le.ScrubsBits5 >> 30) & 3;
    SELF.bldgmats_paid_slope_0t6_Invalid := (le.ScrubsBits5 >> 32) & 3;
    SELF.bldgmats_paid_volatility_0t12_Invalid := (le.ScrubsBits5 >> 34) & 3;
    SELF.bldgmats_paid_volatility_0t6_Invalid := (le.ScrubsBits5 >> 36) & 3;
    SELF.bldgmats_spend_slope_0t12_Invalid := (le.ScrubsBits5 >> 38) & 3;
    SELF.bldgmats_spend_slope_0t24_Invalid := (le.ScrubsBits5 >> 40) & 3;
    SELF.bldgmats_spend_slope_0t6_Invalid := (le.ScrubsBits5 >> 42) & 3;
    SELF.bldgmats_spend_volatility_0t6_Invalid := (le.ScrubsBits5 >> 44) & 3;
    SELF.bldgmats_spend_volatility_6t12_Invalid := (le.ScrubsBits5 >> 46) & 3;
    SELF.top5_paid_slope_0t12_Invalid := (le.ScrubsBits5 >> 48) & 3;
    SELF.top5_paid_slope_0t24_Invalid := (le.ScrubsBits5 >> 50) & 3;
    SELF.top5_paid_slope_0t6_Invalid := (le.ScrubsBits5 >> 52) & 3;
    SELF.top5_paid_volatility_0t12_Invalid := (le.ScrubsBits5 >> 54) & 3;
    SELF.top5_paid_volatility_0t6_Invalid := (le.ScrubsBits5 >> 56) & 3;
    SELF.top5_spend_slope_0t12_Invalid := (le.ScrubsBits5 >> 58) & 3;
    SELF.top5_spend_slope_0t24_Invalid := (le.ScrubsBits5 >> 60) & 3;
    SELF.top5_spend_slope_0t6_Invalid := (le.ScrubsBits5 >> 62) & 3;
    SELF.top5_spend_volatility_0t6_Invalid := (le.ScrubsBits6 >> 0) & 3;
    SELF.top5_spend_volatility_6t12_Invalid := (le.ScrubsBits6 >> 2) & 3;
    SELF.total_numrel_slope_0t12_Invalid := (le.ScrubsBits6 >> 4) & 3;
    SELF.total_numrel_slope_0t24_Invalid := (le.ScrubsBits6 >> 6) & 3;
    SELF.total_numrel_slope_0t6_Invalid := (le.ScrubsBits6 >> 8) & 3;
    SELF.total_numrel_slope_6t12_Invalid := (le.ScrubsBits6 >> 10) & 3;
    SELF.mfgmat_numrel_slope_0t12_Invalid := (le.ScrubsBits6 >> 12) & 3;
    SELF.mfgmat_numrel_slope_0t24_Invalid := (le.ScrubsBits6 >> 14) & 3;
    SELF.mfgmat_numrel_slope_0t6_Invalid := (le.ScrubsBits6 >> 16) & 3;
    SELF.mfgmat_numrel_slope_6t12_Invalid := (le.ScrubsBits6 >> 18) & 3;
    SELF.ops_numrel_slope_0t12_Invalid := (le.ScrubsBits6 >> 20) & 3;
    SELF.ops_numrel_slope_0t24_Invalid := (le.ScrubsBits6 >> 22) & 3;
    SELF.ops_numrel_slope_0t6_Invalid := (le.ScrubsBits6 >> 24) & 3;
    SELF.ops_numrel_slope_6t12_Invalid := (le.ScrubsBits6 >> 26) & 3;
    SELF.fleet_numrel_slope_0t12_Invalid := (le.ScrubsBits6 >> 28) & 3;
    SELF.fleet_numrel_slope_0t24_Invalid := (le.ScrubsBits6 >> 30) & 3;
    SELF.fleet_numrel_slope_0t6_Invalid := (le.ScrubsBits6 >> 32) & 3;
    SELF.fleet_numrel_slope_6t12_Invalid := (le.ScrubsBits6 >> 34) & 3;
    SELF.carrier_numrel_slope_0t12_Invalid := (le.ScrubsBits6 >> 36) & 3;
    SELF.carrier_numrel_slope_0t24_Invalid := (le.ScrubsBits6 >> 38) & 3;
    SELF.carrier_numrel_slope_0t6_Invalid := (le.ScrubsBits6 >> 40) & 3;
    SELF.carrier_numrel_slope_6t12_Invalid := (le.ScrubsBits6 >> 42) & 3;
    SELF.bldgmats_numrel_slope_0t12_Invalid := (le.ScrubsBits6 >> 44) & 3;
    SELF.bldgmats_numrel_slope_0t24_Invalid := (le.ScrubsBits6 >> 46) & 3;
    SELF.bldgmats_numrel_slope_0t6_Invalid := (le.ScrubsBits6 >> 48) & 3;
    SELF.bldgmats_numrel_slope_6t12_Invalid := (le.ScrubsBits6 >> 50) & 3;
    SELF.bldgmats_numrel_var_0t12_Invalid := (le.ScrubsBits6 >> 52) & 3;
    SELF.bldgmats_numrel_var_12t24_Invalid := (le.ScrubsBits6 >> 54) & 3;
    SELF.total_percprov30_slope_0t12_Invalid := (le.ScrubsBits6 >> 56) & 3;
    SELF.total_percprov30_slope_0t24_Invalid := (le.ScrubsBits6 >> 58) & 3;
    SELF.total_percprov30_slope_0t6_Invalid := (le.ScrubsBits6 >> 60) & 3;
    SELF.total_percprov30_slope_6t12_Invalid := (le.ScrubsBits6 >> 62) & 3;
    SELF.total_percprov60_slope_0t12_Invalid := (le.ScrubsBits7 >> 0) & 3;
    SELF.total_percprov60_slope_0t24_Invalid := (le.ScrubsBits7 >> 2) & 3;
    SELF.total_percprov60_slope_0t6_Invalid := (le.ScrubsBits7 >> 4) & 3;
    SELF.total_percprov60_slope_6t12_Invalid := (le.ScrubsBits7 >> 6) & 3;
    SELF.total_percprov90_slope_0t24_Invalid := (le.ScrubsBits7 >> 8) & 3;
    SELF.total_percprov90_slope_0t6_Invalid := (le.ScrubsBits7 >> 10) & 3;
    SELF.total_percprov90_slope_6t12_Invalid := (le.ScrubsBits7 >> 12) & 3;
    SELF.mfgmat_percprov30_slope_0t12_Invalid := (le.ScrubsBits7 >> 14) & 3;
    SELF.mfgmat_percprov30_slope_6t12_Invalid := (le.ScrubsBits7 >> 16) & 3;
    SELF.mfgmat_percprov60_slope_0t12_Invalid := (le.ScrubsBits7 >> 18) & 3;
    SELF.mfgmat_percprov60_slope_6t12_Invalid := (le.ScrubsBits7 >> 20) & 3;
    SELF.mfgmat_percprov90_slope_0t24_Invalid := (le.ScrubsBits7 >> 22) & 3;
    SELF.mfgmat_percprov90_slope_0t6_Invalid := (le.ScrubsBits7 >> 24) & 3;
    SELF.mfgmat_percprov90_slope_6t12_Invalid := (le.ScrubsBits7 >> 26) & 3;
    SELF.ops_percprov30_slope_0t12_Invalid := (le.ScrubsBits7 >> 28) & 3;
    SELF.ops_percprov30_slope_6t12_Invalid := (le.ScrubsBits7 >> 30) & 3;
    SELF.ops_percprov60_slope_0t12_Invalid := (le.ScrubsBits7 >> 32) & 3;
    SELF.ops_percprov60_slope_6t12_Invalid := (le.ScrubsBits7 >> 34) & 3;
    SELF.ops_percprov90_slope_0t24_Invalid := (le.ScrubsBits7 >> 36) & 3;
    SELF.ops_percprov90_slope_0t6_Invalid := (le.ScrubsBits7 >> 38) & 3;
    SELF.ops_percprov90_slope_6t12_Invalid := (le.ScrubsBits7 >> 40) & 3;
    SELF.fleet_percprov30_slope_0t12_Invalid := (le.ScrubsBits7 >> 42) & 3;
    SELF.fleet_percprov30_slope_6t12_Invalid := (le.ScrubsBits7 >> 44) & 3;
    SELF.fleet_percprov60_slope_0t12_Invalid := (le.ScrubsBits7 >> 46) & 3;
    SELF.fleet_percprov60_slope_6t12_Invalid := (le.ScrubsBits7 >> 48) & 3;
    SELF.fleet_percprov90_slope_0t24_Invalid := (le.ScrubsBits7 >> 50) & 3;
    SELF.fleet_percprov90_slope_0t6_Invalid := (le.ScrubsBits7 >> 52) & 3;
    SELF.fleet_percprov90_slope_6t12_Invalid := (le.ScrubsBits7 >> 54) & 3;
    SELF.carrier_percprov30_slope_0t12_Invalid := (le.ScrubsBits7 >> 56) & 3;
    SELF.carrier_percprov30_slope_6t12_Invalid := (le.ScrubsBits7 >> 58) & 3;
    SELF.carrier_percprov60_slope_0t12_Invalid := (le.ScrubsBits7 >> 60) & 3;
    SELF.carrier_percprov60_slope_6t12_Invalid := (le.ScrubsBits7 >> 62) & 3;
    SELF.carrier_percprov90_slope_0t24_Invalid := (le.ScrubsBits8 >> 0) & 3;
    SELF.carrier_percprov90_slope_0t6_Invalid := (le.ScrubsBits8 >> 2) & 3;
    SELF.carrier_percprov90_slope_6t12_Invalid := (le.ScrubsBits8 >> 4) & 3;
    SELF.bldgmats_percprov30_slope_0t12_Invalid := (le.ScrubsBits8 >> 6) & 3;
    SELF.bldgmats_percprov30_slope_6t12_Invalid := (le.ScrubsBits8 >> 8) & 3;
    SELF.bldgmats_percprov60_slope_0t12_Invalid := (le.ScrubsBits8 >> 10) & 3;
    SELF.bldgmats_percprov60_slope_6t12_Invalid := (le.ScrubsBits8 >> 12) & 3;
    SELF.bldgmats_percprov90_slope_0t24_Invalid := (le.ScrubsBits8 >> 14) & 3;
    SELF.bldgmats_percprov90_slope_0t6_Invalid := (le.ScrubsBits8 >> 16) & 3;
    SELF.bldgmats_percprov90_slope_6t12_Invalid := (le.ScrubsBits8 >> 18) & 3;
    SELF.top5_percprov30_slope_0t12_Invalid := (le.ScrubsBits8 >> 20) & 3;
    SELF.top5_percprov30_slope_6t12_Invalid := (le.ScrubsBits8 >> 22) & 3;
    SELF.top5_percprov60_slope_0t12_Invalid := (le.ScrubsBits8 >> 24) & 3;
    SELF.top5_percprov60_slope_6t12_Invalid := (le.ScrubsBits8 >> 26) & 3;
    SELF.top5_percprov90_slope_0t24_Invalid := (le.ScrubsBits8 >> 28) & 3;
    SELF.top5_percprov90_slope_0t6_Invalid := (le.ScrubsBits8 >> 30) & 3;
    SELF.top5_percprov90_slope_6t12_Invalid := (le.ScrubsBits8 >> 32) & 3;
    SELF.top5_percprovoutstanding_adjustedslope_0t12_Invalid := (le.ScrubsBits8 >> 34) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    ultimate_linkid_ALLOW_ErrorCount := COUNT(GROUP,h.ultimate_linkid_Invalid=1);
    cortera_score_ALLOW_ErrorCount := COUNT(GROUP,h.cortera_score_Invalid=1);
    cpr_score_ALLOW_ErrorCount := COUNT(GROUP,h.cpr_score_Invalid=1);
    cpr_segment_ALLOW_ErrorCount := COUNT(GROUP,h.cpr_segment_Invalid=1);
    dbt_ALLOW_ErrorCount := COUNT(GROUP,h.dbt_Invalid=1);
    dbt_LENGTHS_ErrorCount := COUNT(GROUP,h.dbt_Invalid=2);
    dbt_Total_ErrorCount := COUNT(GROUP,h.dbt_Invalid>0);
    avg_bal_ALLOW_ErrorCount := COUNT(GROUP,h.avg_bal_Invalid=1);
    air_spend_ALLOW_ErrorCount := COUNT(GROUP,h.air_spend_Invalid=1);
    fuel_spend_ALLOW_ErrorCount := COUNT(GROUP,h.fuel_spend_Invalid=1);
    leasing_spend_ALLOW_ErrorCount := COUNT(GROUP,h.leasing_spend_Invalid=1);
    ltl_spend_ALLOW_ErrorCount := COUNT(GROUP,h.ltl_spend_Invalid=1);
    rail_spend_ALLOW_ErrorCount := COUNT(GROUP,h.rail_spend_Invalid=1);
    tl_spend_ALLOW_ErrorCount := COUNT(GROUP,h.tl_spend_Invalid=1);
    transvc_spend_ALLOW_ErrorCount := COUNT(GROUP,h.transvc_spend_Invalid=1);
    transup_spend_ALLOW_ErrorCount := COUNT(GROUP,h.transup_spend_Invalid=1);
    bst_spend_ALLOW_ErrorCount := COUNT(GROUP,h.bst_spend_Invalid=1);
    dg_spend_ALLOW_ErrorCount := COUNT(GROUP,h.dg_spend_Invalid=1);
    electrical_spend_ALLOW_ErrorCount := COUNT(GROUP,h.electrical_spend_Invalid=1);
    hvac_spend_ALLOW_ErrorCount := COUNT(GROUP,h.hvac_spend_Invalid=1);
    other_b_spend_ALLOW_ErrorCount := COUNT(GROUP,h.other_b_spend_Invalid=1);
    plumbing_spend_ALLOW_ErrorCount := COUNT(GROUP,h.plumbing_spend_Invalid=1);
    rs_spend_ALLOW_ErrorCount := COUNT(GROUP,h.rs_spend_Invalid=1);
    wp_spend_ALLOW_ErrorCount := COUNT(GROUP,h.wp_spend_Invalid=1);
    chemical_spend_ALLOW_ErrorCount := COUNT(GROUP,h.chemical_spend_Invalid=1);
    electronic_spend_ALLOW_ErrorCount := COUNT(GROUP,h.electronic_spend_Invalid=1);
    metal_spend_ALLOW_ErrorCount := COUNT(GROUP,h.metal_spend_Invalid=1);
    other_m_spend_ALLOW_ErrorCount := COUNT(GROUP,h.other_m_spend_Invalid=1);
    packaging_spend_ALLOW_ErrorCount := COUNT(GROUP,h.packaging_spend_Invalid=1);
    pvf_spend_ALLOW_ErrorCount := COUNT(GROUP,h.pvf_spend_Invalid=1);
    plastic_spend_ALLOW_ErrorCount := COUNT(GROUP,h.plastic_spend_Invalid=1);
    textile_spend_ALLOW_ErrorCount := COUNT(GROUP,h.textile_spend_Invalid=1);
    bs_spend_ALLOW_ErrorCount := COUNT(GROUP,h.bs_spend_Invalid=1);
    ce_spend_ALLOW_ErrorCount := COUNT(GROUP,h.ce_spend_Invalid=1);
    hardware_spend_ALLOW_ErrorCount := COUNT(GROUP,h.hardware_spend_Invalid=1);
    ie_spend_ALLOW_ErrorCount := COUNT(GROUP,h.ie_spend_Invalid=1);
    is_spend_ALLOW_ErrorCount := COUNT(GROUP,h.is_spend_Invalid=1);
    it_spend_ALLOW_ErrorCount := COUNT(GROUP,h.it_spend_Invalid=1);
    mls_spend_ALLOW_ErrorCount := COUNT(GROUP,h.mls_spend_Invalid=1);
    os_spend_ALLOW_ErrorCount := COUNT(GROUP,h.os_spend_Invalid=1);
    pp_spend_ALLOW_ErrorCount := COUNT(GROUP,h.pp_spend_Invalid=1);
    sis_spend_ALLOW_ErrorCount := COUNT(GROUP,h.sis_spend_Invalid=1);
    apparel_spend_ALLOW_ErrorCount := COUNT(GROUP,h.apparel_spend_Invalid=1);
    beverages_spend_ALLOW_ErrorCount := COUNT(GROUP,h.beverages_spend_Invalid=1);
    constr_spend_ALLOW_ErrorCount := COUNT(GROUP,h.constr_spend_Invalid=1);
    consulting_spend_ALLOW_ErrorCount := COUNT(GROUP,h.consulting_spend_Invalid=1);
    fs_spend_ALLOW_ErrorCount := COUNT(GROUP,h.fs_spend_Invalid=1);
    fp_spend_ALLOW_ErrorCount := COUNT(GROUP,h.fp_spend_Invalid=1);
    insurance_spend_ALLOW_ErrorCount := COUNT(GROUP,h.insurance_spend_Invalid=1);
    ls_spend_ALLOW_ErrorCount := COUNT(GROUP,h.ls_spend_Invalid=1);
    oil_gas_spend_ALLOW_ErrorCount := COUNT(GROUP,h.oil_gas_spend_Invalid=1);
    utilities_spend_ALLOW_ErrorCount := COUNT(GROUP,h.utilities_spend_Invalid=1);
    other_spend_ALLOW_ErrorCount := COUNT(GROUP,h.other_spend_Invalid=1);
    advt_spend_ALLOW_ErrorCount := COUNT(GROUP,h.advt_spend_Invalid=1);
    air_growth_ALLOW_ErrorCount := COUNT(GROUP,h.air_growth_Invalid=1);
    air_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.air_growth_Invalid=2);
    air_growth_Total_ErrorCount := COUNT(GROUP,h.air_growth_Invalid>0);
    fuel_growth_ALLOW_ErrorCount := COUNT(GROUP,h.fuel_growth_Invalid=1);
    fuel_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.fuel_growth_Invalid=2);
    fuel_growth_Total_ErrorCount := COUNT(GROUP,h.fuel_growth_Invalid>0);
    leasing_growth_ALLOW_ErrorCount := COUNT(GROUP,h.leasing_growth_Invalid=1);
    leasing_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.leasing_growth_Invalid=2);
    leasing_growth_Total_ErrorCount := COUNT(GROUP,h.leasing_growth_Invalid>0);
    ltl_growth_ALLOW_ErrorCount := COUNT(GROUP,h.ltl_growth_Invalid=1);
    ltl_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.ltl_growth_Invalid=2);
    ltl_growth_Total_ErrorCount := COUNT(GROUP,h.ltl_growth_Invalid>0);
    rail_growth_ALLOW_ErrorCount := COUNT(GROUP,h.rail_growth_Invalid=1);
    rail_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.rail_growth_Invalid=2);
    rail_growth_Total_ErrorCount := COUNT(GROUP,h.rail_growth_Invalid>0);
    tl_growth_ALLOW_ErrorCount := COUNT(GROUP,h.tl_growth_Invalid=1);
    tl_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.tl_growth_Invalid=2);
    tl_growth_Total_ErrorCount := COUNT(GROUP,h.tl_growth_Invalid>0);
    transvc_growth_ALLOW_ErrorCount := COUNT(GROUP,h.transvc_growth_Invalid=1);
    transvc_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.transvc_growth_Invalid=2);
    transvc_growth_Total_ErrorCount := COUNT(GROUP,h.transvc_growth_Invalid>0);
    transup_growth_ALLOW_ErrorCount := COUNT(GROUP,h.transup_growth_Invalid=1);
    transup_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.transup_growth_Invalid=2);
    transup_growth_Total_ErrorCount := COUNT(GROUP,h.transup_growth_Invalid>0);
    bst_growth_ALLOW_ErrorCount := COUNT(GROUP,h.bst_growth_Invalid=1);
    bst_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.bst_growth_Invalid=2);
    bst_growth_Total_ErrorCount := COUNT(GROUP,h.bst_growth_Invalid>0);
    dg_growth_ALLOW_ErrorCount := COUNT(GROUP,h.dg_growth_Invalid=1);
    dg_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.dg_growth_Invalid=2);
    dg_growth_Total_ErrorCount := COUNT(GROUP,h.dg_growth_Invalid>0);
    electrical_growth_ALLOW_ErrorCount := COUNT(GROUP,h.electrical_growth_Invalid=1);
    electrical_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.electrical_growth_Invalid=2);
    electrical_growth_Total_ErrorCount := COUNT(GROUP,h.electrical_growth_Invalid>0);
    hvac_growth_ALLOW_ErrorCount := COUNT(GROUP,h.hvac_growth_Invalid=1);
    hvac_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.hvac_growth_Invalid=2);
    hvac_growth_Total_ErrorCount := COUNT(GROUP,h.hvac_growth_Invalid>0);
    other_b_growth_ALLOW_ErrorCount := COUNT(GROUP,h.other_b_growth_Invalid=1);
    other_b_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.other_b_growth_Invalid=2);
    other_b_growth_Total_ErrorCount := COUNT(GROUP,h.other_b_growth_Invalid>0);
    plumbing_growth_ALLOW_ErrorCount := COUNT(GROUP,h.plumbing_growth_Invalid=1);
    plumbing_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.plumbing_growth_Invalid=2);
    plumbing_growth_Total_ErrorCount := COUNT(GROUP,h.plumbing_growth_Invalid>0);
    rs_growth_ALLOW_ErrorCount := COUNT(GROUP,h.rs_growth_Invalid=1);
    rs_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.rs_growth_Invalid=2);
    rs_growth_Total_ErrorCount := COUNT(GROUP,h.rs_growth_Invalid>0);
    wp_growth_ALLOW_ErrorCount := COUNT(GROUP,h.wp_growth_Invalid=1);
    wp_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.wp_growth_Invalid=2);
    wp_growth_Total_ErrorCount := COUNT(GROUP,h.wp_growth_Invalid>0);
    chemical_growth_ALLOW_ErrorCount := COUNT(GROUP,h.chemical_growth_Invalid=1);
    chemical_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.chemical_growth_Invalid=2);
    chemical_growth_Total_ErrorCount := COUNT(GROUP,h.chemical_growth_Invalid>0);
    electronic_growth_ALLOW_ErrorCount := COUNT(GROUP,h.electronic_growth_Invalid=1);
    electronic_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.electronic_growth_Invalid=2);
    electronic_growth_Total_ErrorCount := COUNT(GROUP,h.electronic_growth_Invalid>0);
    metal_growth_ALLOW_ErrorCount := COUNT(GROUP,h.metal_growth_Invalid=1);
    metal_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.metal_growth_Invalid=2);
    metal_growth_Total_ErrorCount := COUNT(GROUP,h.metal_growth_Invalid>0);
    other_m_growth_ALLOW_ErrorCount := COUNT(GROUP,h.other_m_growth_Invalid=1);
    other_m_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.other_m_growth_Invalid=2);
    other_m_growth_Total_ErrorCount := COUNT(GROUP,h.other_m_growth_Invalid>0);
    packaging_growth_ALLOW_ErrorCount := COUNT(GROUP,h.packaging_growth_Invalid=1);
    packaging_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.packaging_growth_Invalid=2);
    packaging_growth_Total_ErrorCount := COUNT(GROUP,h.packaging_growth_Invalid>0);
    pvf_growth_ALLOW_ErrorCount := COUNT(GROUP,h.pvf_growth_Invalid=1);
    pvf_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.pvf_growth_Invalid=2);
    pvf_growth_Total_ErrorCount := COUNT(GROUP,h.pvf_growth_Invalid>0);
    plastic_growth_ALLOW_ErrorCount := COUNT(GROUP,h.plastic_growth_Invalid=1);
    plastic_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.plastic_growth_Invalid=2);
    plastic_growth_Total_ErrorCount := COUNT(GROUP,h.plastic_growth_Invalid>0);
    textile_growth_ALLOW_ErrorCount := COUNT(GROUP,h.textile_growth_Invalid=1);
    textile_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.textile_growth_Invalid=2);
    textile_growth_Total_ErrorCount := COUNT(GROUP,h.textile_growth_Invalid>0);
    bs_growth_ALLOW_ErrorCount := COUNT(GROUP,h.bs_growth_Invalid=1);
    bs_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.bs_growth_Invalid=2);
    bs_growth_Total_ErrorCount := COUNT(GROUP,h.bs_growth_Invalid>0);
    ce_growth_ALLOW_ErrorCount := COUNT(GROUP,h.ce_growth_Invalid=1);
    ce_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.ce_growth_Invalid=2);
    ce_growth_Total_ErrorCount := COUNT(GROUP,h.ce_growth_Invalid>0);
    hardware_growth_ALLOW_ErrorCount := COUNT(GROUP,h.hardware_growth_Invalid=1);
    hardware_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.hardware_growth_Invalid=2);
    hardware_growth_Total_ErrorCount := COUNT(GROUP,h.hardware_growth_Invalid>0);
    ie_growth_ALLOW_ErrorCount := COUNT(GROUP,h.ie_growth_Invalid=1);
    ie_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.ie_growth_Invalid=2);
    ie_growth_Total_ErrorCount := COUNT(GROUP,h.ie_growth_Invalid>0);
    is_growth_ALLOW_ErrorCount := COUNT(GROUP,h.is_growth_Invalid=1);
    is_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.is_growth_Invalid=2);
    is_growth_Total_ErrorCount := COUNT(GROUP,h.is_growth_Invalid>0);
    it_growth_ALLOW_ErrorCount := COUNT(GROUP,h.it_growth_Invalid=1);
    it_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.it_growth_Invalid=2);
    it_growth_Total_ErrorCount := COUNT(GROUP,h.it_growth_Invalid>0);
    mls_growth_ALLOW_ErrorCount := COUNT(GROUP,h.mls_growth_Invalid=1);
    mls_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.mls_growth_Invalid=2);
    mls_growth_Total_ErrorCount := COUNT(GROUP,h.mls_growth_Invalid>0);
    os_growth_ALLOW_ErrorCount := COUNT(GROUP,h.os_growth_Invalid=1);
    os_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.os_growth_Invalid=2);
    os_growth_Total_ErrorCount := COUNT(GROUP,h.os_growth_Invalid>0);
    pp_growth_ALLOW_ErrorCount := COUNT(GROUP,h.pp_growth_Invalid=1);
    pp_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.pp_growth_Invalid=2);
    pp_growth_Total_ErrorCount := COUNT(GROUP,h.pp_growth_Invalid>0);
    sis_growth_ALLOW_ErrorCount := COUNT(GROUP,h.sis_growth_Invalid=1);
    sis_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.sis_growth_Invalid=2);
    sis_growth_Total_ErrorCount := COUNT(GROUP,h.sis_growth_Invalid>0);
    apparel_growth_ALLOW_ErrorCount := COUNT(GROUP,h.apparel_growth_Invalid=1);
    apparel_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.apparel_growth_Invalid=2);
    apparel_growth_Total_ErrorCount := COUNT(GROUP,h.apparel_growth_Invalid>0);
    beverages_growth_ALLOW_ErrorCount := COUNT(GROUP,h.beverages_growth_Invalid=1);
    beverages_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.beverages_growth_Invalid=2);
    beverages_growth_Total_ErrorCount := COUNT(GROUP,h.beverages_growth_Invalid>0);
    constr_growth_ALLOW_ErrorCount := COUNT(GROUP,h.constr_growth_Invalid=1);
    constr_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.constr_growth_Invalid=2);
    constr_growth_Total_ErrorCount := COUNT(GROUP,h.constr_growth_Invalid>0);
    consulting_growth_ALLOW_ErrorCount := COUNT(GROUP,h.consulting_growth_Invalid=1);
    consulting_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.consulting_growth_Invalid=2);
    consulting_growth_Total_ErrorCount := COUNT(GROUP,h.consulting_growth_Invalid>0);
    fs_growth_ALLOW_ErrorCount := COUNT(GROUP,h.fs_growth_Invalid=1);
    fs_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.fs_growth_Invalid=2);
    fs_growth_Total_ErrorCount := COUNT(GROUP,h.fs_growth_Invalid>0);
    fp_growth_ALLOW_ErrorCount := COUNT(GROUP,h.fp_growth_Invalid=1);
    fp_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.fp_growth_Invalid=2);
    fp_growth_Total_ErrorCount := COUNT(GROUP,h.fp_growth_Invalid>0);
    insurance_growth_ALLOW_ErrorCount := COUNT(GROUP,h.insurance_growth_Invalid=1);
    insurance_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.insurance_growth_Invalid=2);
    insurance_growth_Total_ErrorCount := COUNT(GROUP,h.insurance_growth_Invalid>0);
    ls_growth_ALLOW_ErrorCount := COUNT(GROUP,h.ls_growth_Invalid=1);
    ls_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.ls_growth_Invalid=2);
    ls_growth_Total_ErrorCount := COUNT(GROUP,h.ls_growth_Invalid>0);
    oil_gas_growth_ALLOW_ErrorCount := COUNT(GROUP,h.oil_gas_growth_Invalid=1);
    oil_gas_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.oil_gas_growth_Invalid=2);
    oil_gas_growth_Total_ErrorCount := COUNT(GROUP,h.oil_gas_growth_Invalid>0);
    utilities_growth_ALLOW_ErrorCount := COUNT(GROUP,h.utilities_growth_Invalid=1);
    utilities_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.utilities_growth_Invalid=2);
    utilities_growth_Total_ErrorCount := COUNT(GROUP,h.utilities_growth_Invalid>0);
    other_growth_ALLOW_ErrorCount := COUNT(GROUP,h.other_growth_Invalid=1);
    other_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.other_growth_Invalid=2);
    other_growth_Total_ErrorCount := COUNT(GROUP,h.other_growth_Invalid>0);
    advt_growth_ALLOW_ErrorCount := COUNT(GROUP,h.advt_growth_Invalid=1);
    advt_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.advt_growth_Invalid=2);
    advt_growth_Total_ErrorCount := COUNT(GROUP,h.advt_growth_Invalid>0);
    top5_growth_ALLOW_ErrorCount := COUNT(GROUP,h.top5_growth_Invalid=1);
    top5_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.top5_growth_Invalid=2);
    top5_growth_Total_ErrorCount := COUNT(GROUP,h.top5_growth_Invalid>0);
    shipping_y1_ALLOW_ErrorCount := COUNT(GROUP,h.shipping_y1_Invalid=1);
    shipping_growth_ALLOW_ErrorCount := COUNT(GROUP,h.shipping_growth_Invalid=1);
    shipping_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.shipping_growth_Invalid=2);
    shipping_growth_Total_ErrorCount := COUNT(GROUP,h.shipping_growth_Invalid>0);
    materials_y1_ALLOW_ErrorCount := COUNT(GROUP,h.materials_y1_Invalid=1);
    materials_growth_ALLOW_ErrorCount := COUNT(GROUP,h.materials_growth_Invalid=1);
    materials_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.materials_growth_Invalid=2);
    materials_growth_Total_ErrorCount := COUNT(GROUP,h.materials_growth_Invalid>0);
    operations_y1_ALLOW_ErrorCount := COUNT(GROUP,h.operations_y1_Invalid=1);
    operations_growth_ALLOW_ErrorCount := COUNT(GROUP,h.operations_growth_Invalid=1);
    operations_growth_LENGTHS_ErrorCount := COUNT(GROUP,h.operations_growth_Invalid=2);
    operations_growth_Total_ErrorCount := COUNT(GROUP,h.operations_growth_Invalid>0);
    total_paid_average_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_paid_average_0t12_Invalid=1);
    total_paid_average_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.total_paid_average_0t12_Invalid=2);
    total_paid_average_0t12_Total_ErrorCount := COUNT(GROUP,h.total_paid_average_0t12_Invalid>0);
    total_paid_monthspastworst_24_ALLOW_ErrorCount := COUNT(GROUP,h.total_paid_monthspastworst_24_Invalid=1);
    total_paid_monthspastworst_24_LENGTHS_ErrorCount := COUNT(GROUP,h.total_paid_monthspastworst_24_Invalid=2);
    total_paid_monthspastworst_24_Total_ErrorCount := COUNT(GROUP,h.total_paid_monthspastworst_24_Invalid>0);
    total_paid_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_paid_slope_0t12_Invalid=1);
    total_paid_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.total_paid_slope_0t12_Invalid=2);
    total_paid_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.total_paid_slope_0t12_Invalid>0);
    total_paid_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.total_paid_slope_0t6_Invalid=1);
    total_paid_slope_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.total_paid_slope_0t6_Invalid=2);
    total_paid_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.total_paid_slope_0t6_Invalid>0);
    total_paid_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_paid_slope_6t12_Invalid=1);
    total_paid_slope_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.total_paid_slope_6t12_Invalid=2);
    total_paid_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.total_paid_slope_6t12_Invalid>0);
    total_paid_slope_6t18_ALLOW_ErrorCount := COUNT(GROUP,h.total_paid_slope_6t18_Invalid=1);
    total_paid_slope_6t18_LENGTHS_ErrorCount := COUNT(GROUP,h.total_paid_slope_6t18_Invalid=2);
    total_paid_slope_6t18_Total_ErrorCount := COUNT(GROUP,h.total_paid_slope_6t18_Invalid>0);
    total_paid_volatility_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_paid_volatility_0t12_Invalid=1);
    total_paid_volatility_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.total_paid_volatility_0t12_Invalid=2);
    total_paid_volatility_0t12_Total_ErrorCount := COUNT(GROUP,h.total_paid_volatility_0t12_Invalid>0);
    total_paid_volatility_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.total_paid_volatility_0t6_Invalid=1);
    total_paid_volatility_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.total_paid_volatility_0t6_Invalid=2);
    total_paid_volatility_0t6_Total_ErrorCount := COUNT(GROUP,h.total_paid_volatility_0t6_Invalid>0);
    total_paid_volatility_12t18_ALLOW_ErrorCount := COUNT(GROUP,h.total_paid_volatility_12t18_Invalid=1);
    total_paid_volatility_12t18_LENGTHS_ErrorCount := COUNT(GROUP,h.total_paid_volatility_12t18_Invalid=2);
    total_paid_volatility_12t18_Total_ErrorCount := COUNT(GROUP,h.total_paid_volatility_12t18_Invalid>0);
    total_paid_volatility_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_paid_volatility_6t12_Invalid=1);
    total_paid_volatility_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.total_paid_volatility_6t12_Invalid=2);
    total_paid_volatility_6t12_Total_ErrorCount := COUNT(GROUP,h.total_paid_volatility_6t12_Invalid>0);
    total_spend_monthspastleast_24_ALLOW_ErrorCount := COUNT(GROUP,h.total_spend_monthspastleast_24_Invalid=1);
    total_spend_monthspastmost_24_ALLOW_ErrorCount := COUNT(GROUP,h.total_spend_monthspastmost_24_Invalid=1);
    total_spend_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_spend_slope_0t12_Invalid=1);
    total_spend_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.total_spend_slope_0t12_Invalid=2);
    total_spend_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.total_spend_slope_0t12_Invalid>0);
    total_spend_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.total_spend_slope_0t24_Invalid=1);
    total_spend_slope_0t24_LENGTHS_ErrorCount := COUNT(GROUP,h.total_spend_slope_0t24_Invalid=2);
    total_spend_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.total_spend_slope_0t24_Invalid>0);
    total_spend_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.total_spend_slope_0t6_Invalid=1);
    total_spend_slope_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.total_spend_slope_0t6_Invalid=2);
    total_spend_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.total_spend_slope_0t6_Invalid>0);
    total_spend_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_spend_slope_6t12_Invalid=1);
    total_spend_slope_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.total_spend_slope_6t12_Invalid=2);
    total_spend_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.total_spend_slope_6t12_Invalid>0);
    total_spend_sum_12_ALLOW_ErrorCount := COUNT(GROUP,h.total_spend_sum_12_Invalid=1);
    total_spend_sum_12_LENGTHS_ErrorCount := COUNT(GROUP,h.total_spend_sum_12_Invalid=2);
    total_spend_sum_12_Total_ErrorCount := COUNT(GROUP,h.total_spend_sum_12_Invalid>0);
    total_spend_volatility_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_spend_volatility_0t12_Invalid=1);
    total_spend_volatility_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.total_spend_volatility_0t12_Invalid=2);
    total_spend_volatility_0t12_Total_ErrorCount := COUNT(GROUP,h.total_spend_volatility_0t12_Invalid>0);
    total_spend_volatility_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.total_spend_volatility_0t6_Invalid=1);
    total_spend_volatility_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.total_spend_volatility_0t6_Invalid=2);
    total_spend_volatility_0t6_Total_ErrorCount := COUNT(GROUP,h.total_spend_volatility_0t6_Invalid>0);
    total_spend_volatility_12t18_ALLOW_ErrorCount := COUNT(GROUP,h.total_spend_volatility_12t18_Invalid=1);
    total_spend_volatility_12t18_LENGTHS_ErrorCount := COUNT(GROUP,h.total_spend_volatility_12t18_Invalid=2);
    total_spend_volatility_12t18_Total_ErrorCount := COUNT(GROUP,h.total_spend_volatility_12t18_Invalid>0);
    total_spend_volatility_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_spend_volatility_6t12_Invalid=1);
    total_spend_volatility_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.total_spend_volatility_6t12_Invalid=2);
    total_spend_volatility_6t12_Total_ErrorCount := COUNT(GROUP,h.total_spend_volatility_6t12_Invalid>0);
    mfgmat_paid_average_12_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_paid_average_12_Invalid=1);
    mfgmat_paid_average_12_LENGTHS_ErrorCount := COUNT(GROUP,h.mfgmat_paid_average_12_Invalid=2);
    mfgmat_paid_average_12_Total_ErrorCount := COUNT(GROUP,h.mfgmat_paid_average_12_Invalid>0);
    mfgmat_paid_monthspastworst_24_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_paid_monthspastworst_24_Invalid=1);
    mfgmat_paid_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_paid_slope_0t12_Invalid=1);
    mfgmat_paid_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.mfgmat_paid_slope_0t12_Invalid=2);
    mfgmat_paid_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.mfgmat_paid_slope_0t12_Invalid>0);
    mfgmat_paid_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_paid_slope_0t24_Invalid=1);
    mfgmat_paid_slope_0t24_LENGTHS_ErrorCount := COUNT(GROUP,h.mfgmat_paid_slope_0t24_Invalid=2);
    mfgmat_paid_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.mfgmat_paid_slope_0t24_Invalid>0);
    mfgmat_paid_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_paid_slope_0t6_Invalid=1);
    mfgmat_paid_slope_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.mfgmat_paid_slope_0t6_Invalid=2);
    mfgmat_paid_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.mfgmat_paid_slope_0t6_Invalid>0);
    mfgmat_paid_volatility_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_paid_volatility_0t12_Invalid=1);
    mfgmat_paid_volatility_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.mfgmat_paid_volatility_0t12_Invalid=2);
    mfgmat_paid_volatility_0t12_Total_ErrorCount := COUNT(GROUP,h.mfgmat_paid_volatility_0t12_Invalid>0);
    mfgmat_paid_volatility_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_paid_volatility_0t6_Invalid=1);
    mfgmat_paid_volatility_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.mfgmat_paid_volatility_0t6_Invalid=2);
    mfgmat_paid_volatility_0t6_Total_ErrorCount := COUNT(GROUP,h.mfgmat_paid_volatility_0t6_Invalid>0);
    mfgmat_spend_monthspastleast_24_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_spend_monthspastleast_24_Invalid=1);
    mfgmat_spend_monthspastmost_24_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_spend_monthspastmost_24_Invalid=1);
    mfgmat_spend_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_spend_slope_0t12_Invalid=1);
    mfgmat_spend_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.mfgmat_spend_slope_0t12_Invalid=2);
    mfgmat_spend_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.mfgmat_spend_slope_0t12_Invalid>0);
    mfgmat_spend_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_spend_slope_0t24_Invalid=1);
    mfgmat_spend_slope_0t24_LENGTHS_ErrorCount := COUNT(GROUP,h.mfgmat_spend_slope_0t24_Invalid=2);
    mfgmat_spend_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.mfgmat_spend_slope_0t24_Invalid>0);
    mfgmat_spend_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_spend_slope_0t6_Invalid=1);
    mfgmat_spend_slope_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.mfgmat_spend_slope_0t6_Invalid=2);
    mfgmat_spend_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.mfgmat_spend_slope_0t6_Invalid>0);
    mfgmat_spend_sum_12_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_spend_sum_12_Invalid=1);
    mfgmat_spend_sum_12_LENGTHS_ErrorCount := COUNT(GROUP,h.mfgmat_spend_sum_12_Invalid=2);
    mfgmat_spend_sum_12_Total_ErrorCount := COUNT(GROUP,h.mfgmat_spend_sum_12_Invalid>0);
    mfgmat_spend_volatility_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_spend_volatility_0t6_Invalid=1);
    mfgmat_spend_volatility_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.mfgmat_spend_volatility_0t6_Invalid=2);
    mfgmat_spend_volatility_0t6_Total_ErrorCount := COUNT(GROUP,h.mfgmat_spend_volatility_0t6_Invalid>0);
    mfgmat_spend_volatility_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_spend_volatility_6t12_Invalid=1);
    mfgmat_spend_volatility_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.mfgmat_spend_volatility_6t12_Invalid=2);
    mfgmat_spend_volatility_6t12_Total_ErrorCount := COUNT(GROUP,h.mfgmat_spend_volatility_6t12_Invalid>0);
    ops_paid_average_12_ALLOW_ErrorCount := COUNT(GROUP,h.ops_paid_average_12_Invalid=1);
    ops_paid_average_12_LENGTHS_ErrorCount := COUNT(GROUP,h.ops_paid_average_12_Invalid=2);
    ops_paid_average_12_Total_ErrorCount := COUNT(GROUP,h.ops_paid_average_12_Invalid>0);
    ops_paid_monthspastworst_24_ALLOW_ErrorCount := COUNT(GROUP,h.ops_paid_monthspastworst_24_Invalid=1);
    ops_paid_monthspastworst_24_LENGTHS_ErrorCount := COUNT(GROUP,h.ops_paid_monthspastworst_24_Invalid=2);
    ops_paid_monthspastworst_24_Total_ErrorCount := COUNT(GROUP,h.ops_paid_monthspastworst_24_Invalid>0);
    ops_paid_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.ops_paid_slope_0t12_Invalid=1);
    ops_paid_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.ops_paid_slope_0t12_Invalid=2);
    ops_paid_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.ops_paid_slope_0t12_Invalid>0);
    ops_paid_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.ops_paid_slope_0t24_Invalid=1);
    ops_paid_slope_0t24_LENGTHS_ErrorCount := COUNT(GROUP,h.ops_paid_slope_0t24_Invalid=2);
    ops_paid_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.ops_paid_slope_0t24_Invalid>0);
    ops_paid_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.ops_paid_slope_0t6_Invalid=1);
    ops_paid_slope_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.ops_paid_slope_0t6_Invalid=2);
    ops_paid_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.ops_paid_slope_0t6_Invalid>0);
    ops_paid_volatility_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.ops_paid_volatility_0t12_Invalid=1);
    ops_paid_volatility_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.ops_paid_volatility_0t12_Invalid=2);
    ops_paid_volatility_0t12_Total_ErrorCount := COUNT(GROUP,h.ops_paid_volatility_0t12_Invalid>0);
    ops_paid_volatility_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.ops_paid_volatility_0t6_Invalid=1);
    ops_paid_volatility_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.ops_paid_volatility_0t6_Invalid=2);
    ops_paid_volatility_0t6_Total_ErrorCount := COUNT(GROUP,h.ops_paid_volatility_0t6_Invalid>0);
    ops_spend_monthspastleast_24_ALLOW_ErrorCount := COUNT(GROUP,h.ops_spend_monthspastleast_24_Invalid=1);
    ops_spend_monthspastmost_24_ALLOW_ErrorCount := COUNT(GROUP,h.ops_spend_monthspastmost_24_Invalid=1);
    ops_spend_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.ops_spend_slope_0t12_Invalid=1);
    ops_spend_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.ops_spend_slope_0t12_Invalid=2);
    ops_spend_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.ops_spend_slope_0t12_Invalid>0);
    ops_spend_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.ops_spend_slope_0t24_Invalid=1);
    ops_spend_slope_0t24_LENGTHS_ErrorCount := COUNT(GROUP,h.ops_spend_slope_0t24_Invalid=2);
    ops_spend_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.ops_spend_slope_0t24_Invalid>0);
    ops_spend_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.ops_spend_slope_0t6_Invalid=1);
    ops_spend_slope_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.ops_spend_slope_0t6_Invalid=2);
    ops_spend_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.ops_spend_slope_0t6_Invalid>0);
    fleet_paid_monthspastworst_24_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_paid_monthspastworst_24_Invalid=1);
    fleet_paid_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_paid_slope_0t12_Invalid=1);
    fleet_paid_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.fleet_paid_slope_0t12_Invalid=2);
    fleet_paid_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.fleet_paid_slope_0t12_Invalid>0);
    fleet_paid_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_paid_slope_0t24_Invalid=1);
    fleet_paid_slope_0t24_LENGTHS_ErrorCount := COUNT(GROUP,h.fleet_paid_slope_0t24_Invalid=2);
    fleet_paid_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.fleet_paid_slope_0t24_Invalid>0);
    fleet_paid_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_paid_slope_0t6_Invalid=1);
    fleet_paid_slope_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.fleet_paid_slope_0t6_Invalid=2);
    fleet_paid_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.fleet_paid_slope_0t6_Invalid>0);
    fleet_paid_volatility_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_paid_volatility_0t12_Invalid=1);
    fleet_paid_volatility_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.fleet_paid_volatility_0t12_Invalid=2);
    fleet_paid_volatility_0t12_Total_ErrorCount := COUNT(GROUP,h.fleet_paid_volatility_0t12_Invalid>0);
    fleet_paid_volatility_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_paid_volatility_0t6_Invalid=1);
    fleet_paid_volatility_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.fleet_paid_volatility_0t6_Invalid=2);
    fleet_paid_volatility_0t6_Total_ErrorCount := COUNT(GROUP,h.fleet_paid_volatility_0t6_Invalid>0);
    fleet_spend_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_spend_slope_0t12_Invalid=1);
    fleet_spend_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.fleet_spend_slope_0t12_Invalid=2);
    fleet_spend_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.fleet_spend_slope_0t12_Invalid>0);
    fleet_spend_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_spend_slope_0t24_Invalid=1);
    fleet_spend_slope_0t24_LENGTHS_ErrorCount := COUNT(GROUP,h.fleet_spend_slope_0t24_Invalid=2);
    fleet_spend_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.fleet_spend_slope_0t24_Invalid>0);
    fleet_spend_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_spend_slope_0t6_Invalid=1);
    fleet_spend_slope_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.fleet_spend_slope_0t6_Invalid=2);
    fleet_spend_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.fleet_spend_slope_0t6_Invalid>0);
    carrier_paid_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_paid_slope_0t12_Invalid=1);
    carrier_paid_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.carrier_paid_slope_0t12_Invalid=2);
    carrier_paid_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.carrier_paid_slope_0t12_Invalid>0);
    carrier_paid_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_paid_slope_0t24_Invalid=1);
    carrier_paid_slope_0t24_LENGTHS_ErrorCount := COUNT(GROUP,h.carrier_paid_slope_0t24_Invalid=2);
    carrier_paid_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.carrier_paid_slope_0t24_Invalid>0);
    carrier_paid_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_paid_slope_0t6_Invalid=1);
    carrier_paid_slope_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.carrier_paid_slope_0t6_Invalid=2);
    carrier_paid_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.carrier_paid_slope_0t6_Invalid>0);
    carrier_paid_volatility_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_paid_volatility_0t12_Invalid=1);
    carrier_paid_volatility_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.carrier_paid_volatility_0t12_Invalid=2);
    carrier_paid_volatility_0t12_Total_ErrorCount := COUNT(GROUP,h.carrier_paid_volatility_0t12_Invalid>0);
    carrier_paid_volatility_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_paid_volatility_0t6_Invalid=1);
    carrier_paid_volatility_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.carrier_paid_volatility_0t6_Invalid=2);
    carrier_paid_volatility_0t6_Total_ErrorCount := COUNT(GROUP,h.carrier_paid_volatility_0t6_Invalid>0);
    carrier_spend_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_spend_slope_0t12_Invalid=1);
    carrier_spend_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.carrier_spend_slope_0t12_Invalid=2);
    carrier_spend_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.carrier_spend_slope_0t12_Invalid>0);
    carrier_spend_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_spend_slope_0t24_Invalid=1);
    carrier_spend_slope_0t24_LENGTHS_ErrorCount := COUNT(GROUP,h.carrier_spend_slope_0t24_Invalid=2);
    carrier_spend_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.carrier_spend_slope_0t24_Invalid>0);
    carrier_spend_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_spend_slope_0t6_Invalid=1);
    carrier_spend_slope_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.carrier_spend_slope_0t6_Invalid=2);
    carrier_spend_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.carrier_spend_slope_0t6_Invalid>0);
    carrier_spend_volatility_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_spend_volatility_0t6_Invalid=1);
    carrier_spend_volatility_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.carrier_spend_volatility_0t6_Invalid=2);
    carrier_spend_volatility_0t6_Total_ErrorCount := COUNT(GROUP,h.carrier_spend_volatility_0t6_Invalid>0);
    carrier_spend_volatility_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_spend_volatility_6t12_Invalid=1);
    carrier_spend_volatility_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.carrier_spend_volatility_6t12_Invalid=2);
    carrier_spend_volatility_6t12_Total_ErrorCount := COUNT(GROUP,h.carrier_spend_volatility_6t12_Invalid>0);
    bldgmats_paid_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_paid_slope_0t12_Invalid=1);
    bldgmats_paid_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.bldgmats_paid_slope_0t12_Invalid=2);
    bldgmats_paid_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.bldgmats_paid_slope_0t12_Invalid>0);
    bldgmats_paid_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_paid_slope_0t24_Invalid=1);
    bldgmats_paid_slope_0t24_LENGTHS_ErrorCount := COUNT(GROUP,h.bldgmats_paid_slope_0t24_Invalid=2);
    bldgmats_paid_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.bldgmats_paid_slope_0t24_Invalid>0);
    bldgmats_paid_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_paid_slope_0t6_Invalid=1);
    bldgmats_paid_slope_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.bldgmats_paid_slope_0t6_Invalid=2);
    bldgmats_paid_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.bldgmats_paid_slope_0t6_Invalid>0);
    bldgmats_paid_volatility_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_paid_volatility_0t12_Invalid=1);
    bldgmats_paid_volatility_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.bldgmats_paid_volatility_0t12_Invalid=2);
    bldgmats_paid_volatility_0t12_Total_ErrorCount := COUNT(GROUP,h.bldgmats_paid_volatility_0t12_Invalid>0);
    bldgmats_paid_volatility_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_paid_volatility_0t6_Invalid=1);
    bldgmats_paid_volatility_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.bldgmats_paid_volatility_0t6_Invalid=2);
    bldgmats_paid_volatility_0t6_Total_ErrorCount := COUNT(GROUP,h.bldgmats_paid_volatility_0t6_Invalid>0);
    bldgmats_spend_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_spend_slope_0t12_Invalid=1);
    bldgmats_spend_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.bldgmats_spend_slope_0t12_Invalid=2);
    bldgmats_spend_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.bldgmats_spend_slope_0t12_Invalid>0);
    bldgmats_spend_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_spend_slope_0t24_Invalid=1);
    bldgmats_spend_slope_0t24_LENGTHS_ErrorCount := COUNT(GROUP,h.bldgmats_spend_slope_0t24_Invalid=2);
    bldgmats_spend_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.bldgmats_spend_slope_0t24_Invalid>0);
    bldgmats_spend_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_spend_slope_0t6_Invalid=1);
    bldgmats_spend_slope_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.bldgmats_spend_slope_0t6_Invalid=2);
    bldgmats_spend_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.bldgmats_spend_slope_0t6_Invalid>0);
    bldgmats_spend_volatility_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_spend_volatility_0t6_Invalid=1);
    bldgmats_spend_volatility_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.bldgmats_spend_volatility_0t6_Invalid=2);
    bldgmats_spend_volatility_0t6_Total_ErrorCount := COUNT(GROUP,h.bldgmats_spend_volatility_0t6_Invalid>0);
    bldgmats_spend_volatility_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_spend_volatility_6t12_Invalid=1);
    bldgmats_spend_volatility_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.bldgmats_spend_volatility_6t12_Invalid=2);
    bldgmats_spend_volatility_6t12_Total_ErrorCount := COUNT(GROUP,h.bldgmats_spend_volatility_6t12_Invalid>0);
    top5_paid_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.top5_paid_slope_0t12_Invalid=1);
    top5_paid_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.top5_paid_slope_0t12_Invalid=2);
    top5_paid_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.top5_paid_slope_0t12_Invalid>0);
    top5_paid_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.top5_paid_slope_0t24_Invalid=1);
    top5_paid_slope_0t24_LENGTHS_ErrorCount := COUNT(GROUP,h.top5_paid_slope_0t24_Invalid=2);
    top5_paid_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.top5_paid_slope_0t24_Invalid>0);
    top5_paid_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.top5_paid_slope_0t6_Invalid=1);
    top5_paid_slope_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.top5_paid_slope_0t6_Invalid=2);
    top5_paid_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.top5_paid_slope_0t6_Invalid>0);
    top5_paid_volatility_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.top5_paid_volatility_0t12_Invalid=1);
    top5_paid_volatility_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.top5_paid_volatility_0t12_Invalid=2);
    top5_paid_volatility_0t12_Total_ErrorCount := COUNT(GROUP,h.top5_paid_volatility_0t12_Invalid>0);
    top5_paid_volatility_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.top5_paid_volatility_0t6_Invalid=1);
    top5_paid_volatility_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.top5_paid_volatility_0t6_Invalid=2);
    top5_paid_volatility_0t6_Total_ErrorCount := COUNT(GROUP,h.top5_paid_volatility_0t6_Invalid>0);
    top5_spend_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.top5_spend_slope_0t12_Invalid=1);
    top5_spend_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.top5_spend_slope_0t12_Invalid=2);
    top5_spend_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.top5_spend_slope_0t12_Invalid>0);
    top5_spend_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.top5_spend_slope_0t24_Invalid=1);
    top5_spend_slope_0t24_LENGTHS_ErrorCount := COUNT(GROUP,h.top5_spend_slope_0t24_Invalid=2);
    top5_spend_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.top5_spend_slope_0t24_Invalid>0);
    top5_spend_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.top5_spend_slope_0t6_Invalid=1);
    top5_spend_slope_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.top5_spend_slope_0t6_Invalid=2);
    top5_spend_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.top5_spend_slope_0t6_Invalid>0);
    top5_spend_volatility_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.top5_spend_volatility_0t6_Invalid=1);
    top5_spend_volatility_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.top5_spend_volatility_0t6_Invalid=2);
    top5_spend_volatility_0t6_Total_ErrorCount := COUNT(GROUP,h.top5_spend_volatility_0t6_Invalid>0);
    top5_spend_volatility_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.top5_spend_volatility_6t12_Invalid=1);
    top5_spend_volatility_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.top5_spend_volatility_6t12_Invalid=2);
    top5_spend_volatility_6t12_Total_ErrorCount := COUNT(GROUP,h.top5_spend_volatility_6t12_Invalid>0);
    total_numrel_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_numrel_slope_0t12_Invalid=1);
    total_numrel_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.total_numrel_slope_0t12_Invalid=2);
    total_numrel_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.total_numrel_slope_0t12_Invalid>0);
    total_numrel_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.total_numrel_slope_0t24_Invalid=1);
    total_numrel_slope_0t24_LENGTHS_ErrorCount := COUNT(GROUP,h.total_numrel_slope_0t24_Invalid=2);
    total_numrel_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.total_numrel_slope_0t24_Invalid>0);
    total_numrel_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.total_numrel_slope_0t6_Invalid=1);
    total_numrel_slope_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.total_numrel_slope_0t6_Invalid=2);
    total_numrel_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.total_numrel_slope_0t6_Invalid>0);
    total_numrel_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_numrel_slope_6t12_Invalid=1);
    total_numrel_slope_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.total_numrel_slope_6t12_Invalid=2);
    total_numrel_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.total_numrel_slope_6t12_Invalid>0);
    mfgmat_numrel_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_numrel_slope_0t12_Invalid=1);
    mfgmat_numrel_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.mfgmat_numrel_slope_0t12_Invalid=2);
    mfgmat_numrel_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.mfgmat_numrel_slope_0t12_Invalid>0);
    mfgmat_numrel_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_numrel_slope_0t24_Invalid=1);
    mfgmat_numrel_slope_0t24_LENGTHS_ErrorCount := COUNT(GROUP,h.mfgmat_numrel_slope_0t24_Invalid=2);
    mfgmat_numrel_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.mfgmat_numrel_slope_0t24_Invalid>0);
    mfgmat_numrel_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_numrel_slope_0t6_Invalid=1);
    mfgmat_numrel_slope_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.mfgmat_numrel_slope_0t6_Invalid=2);
    mfgmat_numrel_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.mfgmat_numrel_slope_0t6_Invalid>0);
    mfgmat_numrel_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_numrel_slope_6t12_Invalid=1);
    mfgmat_numrel_slope_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.mfgmat_numrel_slope_6t12_Invalid=2);
    mfgmat_numrel_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.mfgmat_numrel_slope_6t12_Invalid>0);
    ops_numrel_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.ops_numrel_slope_0t12_Invalid=1);
    ops_numrel_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.ops_numrel_slope_0t12_Invalid=2);
    ops_numrel_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.ops_numrel_slope_0t12_Invalid>0);
    ops_numrel_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.ops_numrel_slope_0t24_Invalid=1);
    ops_numrel_slope_0t24_LENGTHS_ErrorCount := COUNT(GROUP,h.ops_numrel_slope_0t24_Invalid=2);
    ops_numrel_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.ops_numrel_slope_0t24_Invalid>0);
    ops_numrel_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.ops_numrel_slope_0t6_Invalid=1);
    ops_numrel_slope_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.ops_numrel_slope_0t6_Invalid=2);
    ops_numrel_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.ops_numrel_slope_0t6_Invalid>0);
    ops_numrel_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.ops_numrel_slope_6t12_Invalid=1);
    ops_numrel_slope_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.ops_numrel_slope_6t12_Invalid=2);
    ops_numrel_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.ops_numrel_slope_6t12_Invalid>0);
    fleet_numrel_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_numrel_slope_0t12_Invalid=1);
    fleet_numrel_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.fleet_numrel_slope_0t12_Invalid=2);
    fleet_numrel_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.fleet_numrel_slope_0t12_Invalid>0);
    fleet_numrel_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_numrel_slope_0t24_Invalid=1);
    fleet_numrel_slope_0t24_LENGTHS_ErrorCount := COUNT(GROUP,h.fleet_numrel_slope_0t24_Invalid=2);
    fleet_numrel_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.fleet_numrel_slope_0t24_Invalid>0);
    fleet_numrel_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_numrel_slope_0t6_Invalid=1);
    fleet_numrel_slope_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.fleet_numrel_slope_0t6_Invalid=2);
    fleet_numrel_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.fleet_numrel_slope_0t6_Invalid>0);
    fleet_numrel_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_numrel_slope_6t12_Invalid=1);
    fleet_numrel_slope_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.fleet_numrel_slope_6t12_Invalid=2);
    fleet_numrel_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.fleet_numrel_slope_6t12_Invalid>0);
    carrier_numrel_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_numrel_slope_0t12_Invalid=1);
    carrier_numrel_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.carrier_numrel_slope_0t12_Invalid=2);
    carrier_numrel_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.carrier_numrel_slope_0t12_Invalid>0);
    carrier_numrel_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_numrel_slope_0t24_Invalid=1);
    carrier_numrel_slope_0t24_LENGTHS_ErrorCount := COUNT(GROUP,h.carrier_numrel_slope_0t24_Invalid=2);
    carrier_numrel_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.carrier_numrel_slope_0t24_Invalid>0);
    carrier_numrel_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_numrel_slope_0t6_Invalid=1);
    carrier_numrel_slope_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.carrier_numrel_slope_0t6_Invalid=2);
    carrier_numrel_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.carrier_numrel_slope_0t6_Invalid>0);
    carrier_numrel_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_numrel_slope_6t12_Invalid=1);
    carrier_numrel_slope_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.carrier_numrel_slope_6t12_Invalid=2);
    carrier_numrel_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.carrier_numrel_slope_6t12_Invalid>0);
    bldgmats_numrel_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_slope_0t12_Invalid=1);
    bldgmats_numrel_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_slope_0t12_Invalid=2);
    bldgmats_numrel_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_slope_0t12_Invalid>0);
    bldgmats_numrel_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_slope_0t24_Invalid=1);
    bldgmats_numrel_slope_0t24_LENGTHS_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_slope_0t24_Invalid=2);
    bldgmats_numrel_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_slope_0t24_Invalid>0);
    bldgmats_numrel_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_slope_0t6_Invalid=1);
    bldgmats_numrel_slope_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_slope_0t6_Invalid=2);
    bldgmats_numrel_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_slope_0t6_Invalid>0);
    bldgmats_numrel_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_slope_6t12_Invalid=1);
    bldgmats_numrel_slope_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_slope_6t12_Invalid=2);
    bldgmats_numrel_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_slope_6t12_Invalid>0);
    bldgmats_numrel_var_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_var_0t12_Invalid=1);
    bldgmats_numrel_var_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_var_0t12_Invalid=2);
    bldgmats_numrel_var_0t12_Total_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_var_0t12_Invalid>0);
    bldgmats_numrel_var_12t24_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_var_12t24_Invalid=1);
    bldgmats_numrel_var_12t24_LENGTHS_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_var_12t24_Invalid=2);
    bldgmats_numrel_var_12t24_Total_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_var_12t24_Invalid>0);
    total_percprov30_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_percprov30_slope_0t12_Invalid=1);
    total_percprov30_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.total_percprov30_slope_0t12_Invalid=2);
    total_percprov30_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.total_percprov30_slope_0t12_Invalid>0);
    total_percprov30_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.total_percprov30_slope_0t24_Invalid=1);
    total_percprov30_slope_0t24_LENGTHS_ErrorCount := COUNT(GROUP,h.total_percprov30_slope_0t24_Invalid=2);
    total_percprov30_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.total_percprov30_slope_0t24_Invalid>0);
    total_percprov30_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.total_percprov30_slope_0t6_Invalid=1);
    total_percprov30_slope_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.total_percprov30_slope_0t6_Invalid=2);
    total_percprov30_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.total_percprov30_slope_0t6_Invalid>0);
    total_percprov30_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_percprov30_slope_6t12_Invalid=1);
    total_percprov30_slope_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.total_percprov30_slope_6t12_Invalid=2);
    total_percprov30_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.total_percprov30_slope_6t12_Invalid>0);
    total_percprov60_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_percprov60_slope_0t12_Invalid=1);
    total_percprov60_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.total_percprov60_slope_0t12_Invalid=2);
    total_percprov60_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.total_percprov60_slope_0t12_Invalid>0);
    total_percprov60_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.total_percprov60_slope_0t24_Invalid=1);
    total_percprov60_slope_0t24_LENGTHS_ErrorCount := COUNT(GROUP,h.total_percprov60_slope_0t24_Invalid=2);
    total_percprov60_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.total_percprov60_slope_0t24_Invalid>0);
    total_percprov60_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.total_percprov60_slope_0t6_Invalid=1);
    total_percprov60_slope_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.total_percprov60_slope_0t6_Invalid=2);
    total_percprov60_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.total_percprov60_slope_0t6_Invalid>0);
    total_percprov60_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_percprov60_slope_6t12_Invalid=1);
    total_percprov60_slope_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.total_percprov60_slope_6t12_Invalid=2);
    total_percprov60_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.total_percprov60_slope_6t12_Invalid>0);
    total_percprov90_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.total_percprov90_slope_0t24_Invalid=1);
    total_percprov90_slope_0t24_LENGTHS_ErrorCount := COUNT(GROUP,h.total_percprov90_slope_0t24_Invalid=2);
    total_percprov90_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.total_percprov90_slope_0t24_Invalid>0);
    total_percprov90_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.total_percprov90_slope_0t6_Invalid=1);
    total_percprov90_slope_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.total_percprov90_slope_0t6_Invalid=2);
    total_percprov90_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.total_percprov90_slope_0t6_Invalid>0);
    total_percprov90_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_percprov90_slope_6t12_Invalid=1);
    total_percprov90_slope_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.total_percprov90_slope_6t12_Invalid=2);
    total_percprov90_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.total_percprov90_slope_6t12_Invalid>0);
    mfgmat_percprov30_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_percprov30_slope_0t12_Invalid=1);
    mfgmat_percprov30_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.mfgmat_percprov30_slope_0t12_Invalid=2);
    mfgmat_percprov30_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.mfgmat_percprov30_slope_0t12_Invalid>0);
    mfgmat_percprov30_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_percprov30_slope_6t12_Invalid=1);
    mfgmat_percprov30_slope_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.mfgmat_percprov30_slope_6t12_Invalid=2);
    mfgmat_percprov30_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.mfgmat_percprov30_slope_6t12_Invalid>0);
    mfgmat_percprov60_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_percprov60_slope_0t12_Invalid=1);
    mfgmat_percprov60_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.mfgmat_percprov60_slope_0t12_Invalid=2);
    mfgmat_percprov60_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.mfgmat_percprov60_slope_0t12_Invalid>0);
    mfgmat_percprov60_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_percprov60_slope_6t12_Invalid=1);
    mfgmat_percprov60_slope_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.mfgmat_percprov60_slope_6t12_Invalid=2);
    mfgmat_percprov60_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.mfgmat_percprov60_slope_6t12_Invalid>0);
    mfgmat_percprov90_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_percprov90_slope_0t24_Invalid=1);
    mfgmat_percprov90_slope_0t24_LENGTHS_ErrorCount := COUNT(GROUP,h.mfgmat_percprov90_slope_0t24_Invalid=2);
    mfgmat_percprov90_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.mfgmat_percprov90_slope_0t24_Invalid>0);
    mfgmat_percprov90_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_percprov90_slope_0t6_Invalid=1);
    mfgmat_percprov90_slope_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.mfgmat_percprov90_slope_0t6_Invalid=2);
    mfgmat_percprov90_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.mfgmat_percprov90_slope_0t6_Invalid>0);
    mfgmat_percprov90_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_percprov90_slope_6t12_Invalid=1);
    mfgmat_percprov90_slope_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.mfgmat_percprov90_slope_6t12_Invalid=2);
    mfgmat_percprov90_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.mfgmat_percprov90_slope_6t12_Invalid>0);
    ops_percprov30_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.ops_percprov30_slope_0t12_Invalid=1);
    ops_percprov30_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.ops_percprov30_slope_0t12_Invalid=2);
    ops_percprov30_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.ops_percprov30_slope_0t12_Invalid>0);
    ops_percprov30_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.ops_percprov30_slope_6t12_Invalid=1);
    ops_percprov30_slope_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.ops_percprov30_slope_6t12_Invalid=2);
    ops_percprov30_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.ops_percprov30_slope_6t12_Invalid>0);
    ops_percprov60_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.ops_percprov60_slope_0t12_Invalid=1);
    ops_percprov60_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.ops_percprov60_slope_0t12_Invalid=2);
    ops_percprov60_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.ops_percprov60_slope_0t12_Invalid>0);
    ops_percprov60_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.ops_percprov60_slope_6t12_Invalid=1);
    ops_percprov60_slope_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.ops_percprov60_slope_6t12_Invalid=2);
    ops_percprov60_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.ops_percprov60_slope_6t12_Invalid>0);
    ops_percprov90_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.ops_percprov90_slope_0t24_Invalid=1);
    ops_percprov90_slope_0t24_LENGTHS_ErrorCount := COUNT(GROUP,h.ops_percprov90_slope_0t24_Invalid=2);
    ops_percprov90_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.ops_percprov90_slope_0t24_Invalid>0);
    ops_percprov90_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.ops_percprov90_slope_0t6_Invalid=1);
    ops_percprov90_slope_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.ops_percprov90_slope_0t6_Invalid=2);
    ops_percprov90_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.ops_percprov90_slope_0t6_Invalid>0);
    ops_percprov90_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.ops_percprov90_slope_6t12_Invalid=1);
    ops_percprov90_slope_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.ops_percprov90_slope_6t12_Invalid=2);
    ops_percprov90_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.ops_percprov90_slope_6t12_Invalid>0);
    fleet_percprov30_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_percprov30_slope_0t12_Invalid=1);
    fleet_percprov30_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.fleet_percprov30_slope_0t12_Invalid=2);
    fleet_percprov30_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.fleet_percprov30_slope_0t12_Invalid>0);
    fleet_percprov30_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_percprov30_slope_6t12_Invalid=1);
    fleet_percprov30_slope_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.fleet_percprov30_slope_6t12_Invalid=2);
    fleet_percprov30_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.fleet_percprov30_slope_6t12_Invalid>0);
    fleet_percprov60_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_percprov60_slope_0t12_Invalid=1);
    fleet_percprov60_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.fleet_percprov60_slope_0t12_Invalid=2);
    fleet_percprov60_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.fleet_percprov60_slope_0t12_Invalid>0);
    fleet_percprov60_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_percprov60_slope_6t12_Invalid=1);
    fleet_percprov60_slope_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.fleet_percprov60_slope_6t12_Invalid=2);
    fleet_percprov60_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.fleet_percprov60_slope_6t12_Invalid>0);
    fleet_percprov90_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_percprov90_slope_0t24_Invalid=1);
    fleet_percprov90_slope_0t24_LENGTHS_ErrorCount := COUNT(GROUP,h.fleet_percprov90_slope_0t24_Invalid=2);
    fleet_percprov90_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.fleet_percprov90_slope_0t24_Invalid>0);
    fleet_percprov90_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_percprov90_slope_0t6_Invalid=1);
    fleet_percprov90_slope_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.fleet_percprov90_slope_0t6_Invalid=2);
    fleet_percprov90_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.fleet_percprov90_slope_0t6_Invalid>0);
    fleet_percprov90_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_percprov90_slope_6t12_Invalid=1);
    fleet_percprov90_slope_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.fleet_percprov90_slope_6t12_Invalid=2);
    fleet_percprov90_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.fleet_percprov90_slope_6t12_Invalid>0);
    carrier_percprov30_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_percprov30_slope_0t12_Invalid=1);
    carrier_percprov30_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.carrier_percprov30_slope_0t12_Invalid=2);
    carrier_percprov30_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.carrier_percprov30_slope_0t12_Invalid>0);
    carrier_percprov30_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_percprov30_slope_6t12_Invalid=1);
    carrier_percprov30_slope_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.carrier_percprov30_slope_6t12_Invalid=2);
    carrier_percprov30_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.carrier_percprov30_slope_6t12_Invalid>0);
    carrier_percprov60_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_percprov60_slope_0t12_Invalid=1);
    carrier_percprov60_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.carrier_percprov60_slope_0t12_Invalid=2);
    carrier_percprov60_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.carrier_percprov60_slope_0t12_Invalid>0);
    carrier_percprov60_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_percprov60_slope_6t12_Invalid=1);
    carrier_percprov60_slope_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.carrier_percprov60_slope_6t12_Invalid=2);
    carrier_percprov60_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.carrier_percprov60_slope_6t12_Invalid>0);
    carrier_percprov90_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_percprov90_slope_0t24_Invalid=1);
    carrier_percprov90_slope_0t24_LENGTHS_ErrorCount := COUNT(GROUP,h.carrier_percprov90_slope_0t24_Invalid=2);
    carrier_percprov90_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.carrier_percprov90_slope_0t24_Invalid>0);
    carrier_percprov90_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_percprov90_slope_0t6_Invalid=1);
    carrier_percprov90_slope_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.carrier_percprov90_slope_0t6_Invalid=2);
    carrier_percprov90_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.carrier_percprov90_slope_0t6_Invalid>0);
    carrier_percprov90_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_percprov90_slope_6t12_Invalid=1);
    carrier_percprov90_slope_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.carrier_percprov90_slope_6t12_Invalid=2);
    carrier_percprov90_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.carrier_percprov90_slope_6t12_Invalid>0);
    bldgmats_percprov30_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_percprov30_slope_0t12_Invalid=1);
    bldgmats_percprov30_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.bldgmats_percprov30_slope_0t12_Invalid=2);
    bldgmats_percprov30_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.bldgmats_percprov30_slope_0t12_Invalid>0);
    bldgmats_percprov30_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_percprov30_slope_6t12_Invalid=1);
    bldgmats_percprov30_slope_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.bldgmats_percprov30_slope_6t12_Invalid=2);
    bldgmats_percprov30_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.bldgmats_percprov30_slope_6t12_Invalid>0);
    bldgmats_percprov60_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_percprov60_slope_0t12_Invalid=1);
    bldgmats_percprov60_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.bldgmats_percprov60_slope_0t12_Invalid=2);
    bldgmats_percprov60_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.bldgmats_percprov60_slope_0t12_Invalid>0);
    bldgmats_percprov60_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_percprov60_slope_6t12_Invalid=1);
    bldgmats_percprov60_slope_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.bldgmats_percprov60_slope_6t12_Invalid=2);
    bldgmats_percprov60_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.bldgmats_percprov60_slope_6t12_Invalid>0);
    bldgmats_percprov90_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_percprov90_slope_0t24_Invalid=1);
    bldgmats_percprov90_slope_0t24_LENGTHS_ErrorCount := COUNT(GROUP,h.bldgmats_percprov90_slope_0t24_Invalid=2);
    bldgmats_percprov90_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.bldgmats_percprov90_slope_0t24_Invalid>0);
    bldgmats_percprov90_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_percprov90_slope_0t6_Invalid=1);
    bldgmats_percprov90_slope_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.bldgmats_percprov90_slope_0t6_Invalid=2);
    bldgmats_percprov90_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.bldgmats_percprov90_slope_0t6_Invalid>0);
    bldgmats_percprov90_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_percprov90_slope_6t12_Invalid=1);
    bldgmats_percprov90_slope_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.bldgmats_percprov90_slope_6t12_Invalid=2);
    bldgmats_percprov90_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.bldgmats_percprov90_slope_6t12_Invalid>0);
    top5_percprov30_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.top5_percprov30_slope_0t12_Invalid=1);
    top5_percprov30_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.top5_percprov30_slope_0t12_Invalid=2);
    top5_percprov30_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.top5_percprov30_slope_0t12_Invalid>0);
    top5_percprov30_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.top5_percprov30_slope_6t12_Invalid=1);
    top5_percprov30_slope_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.top5_percprov30_slope_6t12_Invalid=2);
    top5_percprov30_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.top5_percprov30_slope_6t12_Invalid>0);
    top5_percprov60_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.top5_percprov60_slope_0t12_Invalid=1);
    top5_percprov60_slope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.top5_percprov60_slope_0t12_Invalid=2);
    top5_percprov60_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.top5_percprov60_slope_0t12_Invalid>0);
    top5_percprov60_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.top5_percprov60_slope_6t12_Invalid=1);
    top5_percprov60_slope_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.top5_percprov60_slope_6t12_Invalid=2);
    top5_percprov60_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.top5_percprov60_slope_6t12_Invalid>0);
    top5_percprov90_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.top5_percprov90_slope_0t24_Invalid=1);
    top5_percprov90_slope_0t24_LENGTHS_ErrorCount := COUNT(GROUP,h.top5_percprov90_slope_0t24_Invalid=2);
    top5_percprov90_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.top5_percprov90_slope_0t24_Invalid>0);
    top5_percprov90_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.top5_percprov90_slope_0t6_Invalid=1);
    top5_percprov90_slope_0t6_LENGTHS_ErrorCount := COUNT(GROUP,h.top5_percprov90_slope_0t6_Invalid=2);
    top5_percprov90_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.top5_percprov90_slope_0t6_Invalid>0);
    top5_percprov90_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.top5_percprov90_slope_6t12_Invalid=1);
    top5_percprov90_slope_6t12_LENGTHS_ErrorCount := COUNT(GROUP,h.top5_percprov90_slope_6t12_Invalid=2);
    top5_percprov90_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.top5_percprov90_slope_6t12_Invalid>0);
    top5_percprovoutstanding_adjustedslope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.top5_percprovoutstanding_adjustedslope_0t12_Invalid=1);
    top5_percprovoutstanding_adjustedslope_0t12_LENGTHS_ErrorCount := COUNT(GROUP,h.top5_percprovoutstanding_adjustedslope_0t12_Invalid=2);
    top5_percprovoutstanding_adjustedslope_0t12_Total_ErrorCount := COUNT(GROUP,h.top5_percprovoutstanding_adjustedslope_0t12_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.ultimate_linkid_Invalid > 0 OR h.cortera_score_Invalid > 0 OR h.cpr_score_Invalid > 0 OR h.cpr_segment_Invalid > 0 OR h.dbt_Invalid > 0 OR h.avg_bal_Invalid > 0 OR h.air_spend_Invalid > 0 OR h.fuel_spend_Invalid > 0 OR h.leasing_spend_Invalid > 0 OR h.ltl_spend_Invalid > 0 OR h.rail_spend_Invalid > 0 OR h.tl_spend_Invalid > 0 OR h.transvc_spend_Invalid > 0 OR h.transup_spend_Invalid > 0 OR h.bst_spend_Invalid > 0 OR h.dg_spend_Invalid > 0 OR h.electrical_spend_Invalid > 0 OR h.hvac_spend_Invalid > 0 OR h.other_b_spend_Invalid > 0 OR h.plumbing_spend_Invalid > 0 OR h.rs_spend_Invalid > 0 OR h.wp_spend_Invalid > 0 OR h.chemical_spend_Invalid > 0 OR h.electronic_spend_Invalid > 0 OR h.metal_spend_Invalid > 0 OR h.other_m_spend_Invalid > 0 OR h.packaging_spend_Invalid > 0 OR h.pvf_spend_Invalid > 0 OR h.plastic_spend_Invalid > 0 OR h.textile_spend_Invalid > 0 OR h.bs_spend_Invalid > 0 OR h.ce_spend_Invalid > 0 OR h.hardware_spend_Invalid > 0 OR h.ie_spend_Invalid > 0 OR h.is_spend_Invalid > 0 OR h.it_spend_Invalid > 0 OR h.mls_spend_Invalid > 0 OR h.os_spend_Invalid > 0 OR h.pp_spend_Invalid > 0 OR h.sis_spend_Invalid > 0 OR h.apparel_spend_Invalid > 0 OR h.beverages_spend_Invalid > 0 OR h.constr_spend_Invalid > 0 OR h.consulting_spend_Invalid > 0 OR h.fs_spend_Invalid > 0 OR h.fp_spend_Invalid > 0 OR h.insurance_spend_Invalid > 0 OR h.ls_spend_Invalid > 0 OR h.oil_gas_spend_Invalid > 0 OR h.utilities_spend_Invalid > 0 OR h.other_spend_Invalid > 0 OR h.advt_spend_Invalid > 0 OR h.air_growth_Invalid > 0 OR h.fuel_growth_Invalid > 0 OR h.leasing_growth_Invalid > 0 OR h.ltl_growth_Invalid > 0 OR h.rail_growth_Invalid > 0 OR h.tl_growth_Invalid > 0 OR h.transvc_growth_Invalid > 0 OR h.transup_growth_Invalid > 0 OR h.bst_growth_Invalid > 0 OR h.dg_growth_Invalid > 0 OR h.electrical_growth_Invalid > 0 OR h.hvac_growth_Invalid > 0 OR h.other_b_growth_Invalid > 0 OR h.plumbing_growth_Invalid > 0 OR h.rs_growth_Invalid > 0 OR h.wp_growth_Invalid > 0 OR h.chemical_growth_Invalid > 0 OR h.electronic_growth_Invalid > 0 OR h.metal_growth_Invalid > 0 OR h.other_m_growth_Invalid > 0 OR h.packaging_growth_Invalid > 0 OR h.pvf_growth_Invalid > 0 OR h.plastic_growth_Invalid > 0 OR h.textile_growth_Invalid > 0 OR h.bs_growth_Invalid > 0 OR h.ce_growth_Invalid > 0 OR h.hardware_growth_Invalid > 0 OR h.ie_growth_Invalid > 0 OR h.is_growth_Invalid > 0 OR h.it_growth_Invalid > 0 OR h.mls_growth_Invalid > 0 OR h.os_growth_Invalid > 0 OR h.pp_growth_Invalid > 0 OR h.sis_growth_Invalid > 0 OR h.apparel_growth_Invalid > 0 OR h.beverages_growth_Invalid > 0 OR h.constr_growth_Invalid > 0 OR h.consulting_growth_Invalid > 0 OR h.fs_growth_Invalid > 0 OR h.fp_growth_Invalid > 0 OR h.insurance_growth_Invalid > 0 OR h.ls_growth_Invalid > 0 OR h.oil_gas_growth_Invalid > 0 OR h.utilities_growth_Invalid > 0 OR h.other_growth_Invalid > 0 OR h.advt_growth_Invalid > 0 OR h.top5_growth_Invalid > 0 OR h.shipping_y1_Invalid > 0 OR h.shipping_growth_Invalid > 0 OR h.materials_y1_Invalid > 0 OR h.materials_growth_Invalid > 0 OR h.operations_y1_Invalid > 0 OR h.operations_growth_Invalid > 0 OR h.total_paid_average_0t12_Invalid > 0 OR h.total_paid_monthspastworst_24_Invalid > 0 OR h.total_paid_slope_0t12_Invalid > 0 OR h.total_paid_slope_0t6_Invalid > 0 OR h.total_paid_slope_6t12_Invalid > 0 OR h.total_paid_slope_6t18_Invalid > 0 OR h.total_paid_volatility_0t12_Invalid > 0 OR h.total_paid_volatility_0t6_Invalid > 0 OR h.total_paid_volatility_12t18_Invalid > 0 OR h.total_paid_volatility_6t12_Invalid > 0 OR h.total_spend_monthspastleast_24_Invalid > 0 OR h.total_spend_monthspastmost_24_Invalid > 0 OR h.total_spend_slope_0t12_Invalid > 0 OR h.total_spend_slope_0t24_Invalid > 0 OR h.total_spend_slope_0t6_Invalid > 0 OR h.total_spend_slope_6t12_Invalid > 0 OR h.total_spend_sum_12_Invalid > 0 OR h.total_spend_volatility_0t12_Invalid > 0 OR h.total_spend_volatility_0t6_Invalid > 0 OR h.total_spend_volatility_12t18_Invalid > 0 OR h.total_spend_volatility_6t12_Invalid > 0 OR h.mfgmat_paid_average_12_Invalid > 0 OR h.mfgmat_paid_monthspastworst_24_Invalid > 0 OR h.mfgmat_paid_slope_0t12_Invalid > 0 OR h.mfgmat_paid_slope_0t24_Invalid > 0 OR h.mfgmat_paid_slope_0t6_Invalid > 0 OR h.mfgmat_paid_volatility_0t12_Invalid > 0 OR h.mfgmat_paid_volatility_0t6_Invalid > 0 OR h.mfgmat_spend_monthspastleast_24_Invalid > 0 OR h.mfgmat_spend_monthspastmost_24_Invalid > 0 OR h.mfgmat_spend_slope_0t12_Invalid > 0 OR h.mfgmat_spend_slope_0t24_Invalid > 0 OR h.mfgmat_spend_slope_0t6_Invalid > 0 OR h.mfgmat_spend_sum_12_Invalid > 0 OR h.mfgmat_spend_volatility_0t6_Invalid > 0 OR h.mfgmat_spend_volatility_6t12_Invalid > 0 OR h.ops_paid_average_12_Invalid > 0 OR h.ops_paid_monthspastworst_24_Invalid > 0 OR h.ops_paid_slope_0t12_Invalid > 0 OR h.ops_paid_slope_0t24_Invalid > 0 OR h.ops_paid_slope_0t6_Invalid > 0 OR h.ops_paid_volatility_0t12_Invalid > 0 OR h.ops_paid_volatility_0t6_Invalid > 0 OR h.ops_spend_monthspastleast_24_Invalid > 0 OR h.ops_spend_monthspastmost_24_Invalid > 0 OR h.ops_spend_slope_0t12_Invalid > 0 OR h.ops_spend_slope_0t24_Invalid > 0 OR h.ops_spend_slope_0t6_Invalid > 0 OR h.fleet_paid_monthspastworst_24_Invalid > 0 OR h.fleet_paid_slope_0t12_Invalid > 0 OR h.fleet_paid_slope_0t24_Invalid > 0 OR h.fleet_paid_slope_0t6_Invalid > 0 OR h.fleet_paid_volatility_0t12_Invalid > 0 OR h.fleet_paid_volatility_0t6_Invalid > 0 OR h.fleet_spend_slope_0t12_Invalid > 0 OR h.fleet_spend_slope_0t24_Invalid > 0 OR h.fleet_spend_slope_0t6_Invalid > 0 OR h.carrier_paid_slope_0t12_Invalid > 0 OR h.carrier_paid_slope_0t24_Invalid > 0 OR h.carrier_paid_slope_0t6_Invalid > 0 OR h.carrier_paid_volatility_0t12_Invalid > 0 OR h.carrier_paid_volatility_0t6_Invalid > 0 OR h.carrier_spend_slope_0t12_Invalid > 0 OR h.carrier_spend_slope_0t24_Invalid > 0 OR h.carrier_spend_slope_0t6_Invalid > 0 OR h.carrier_spend_volatility_0t6_Invalid > 0 OR h.carrier_spend_volatility_6t12_Invalid > 0 OR h.bldgmats_paid_slope_0t12_Invalid > 0 OR h.bldgmats_paid_slope_0t24_Invalid > 0 OR h.bldgmats_paid_slope_0t6_Invalid > 0 OR h.bldgmats_paid_volatility_0t12_Invalid > 0 OR h.bldgmats_paid_volatility_0t6_Invalid > 0 OR h.bldgmats_spend_slope_0t12_Invalid > 0 OR h.bldgmats_spend_slope_0t24_Invalid > 0 OR h.bldgmats_spend_slope_0t6_Invalid > 0 OR h.bldgmats_spend_volatility_0t6_Invalid > 0 OR h.bldgmats_spend_volatility_6t12_Invalid > 0 OR h.top5_paid_slope_0t12_Invalid > 0 OR h.top5_paid_slope_0t24_Invalid > 0 OR h.top5_paid_slope_0t6_Invalid > 0 OR h.top5_paid_volatility_0t12_Invalid > 0 OR h.top5_paid_volatility_0t6_Invalid > 0 OR h.top5_spend_slope_0t12_Invalid > 0 OR h.top5_spend_slope_0t24_Invalid > 0 OR h.top5_spend_slope_0t6_Invalid > 0 OR h.top5_spend_volatility_0t6_Invalid > 0 OR h.top5_spend_volatility_6t12_Invalid > 0 OR h.total_numrel_slope_0t12_Invalid > 0 OR h.total_numrel_slope_0t24_Invalid > 0 OR h.total_numrel_slope_0t6_Invalid > 0 OR h.total_numrel_slope_6t12_Invalid > 0 OR h.mfgmat_numrel_slope_0t12_Invalid > 0 OR h.mfgmat_numrel_slope_0t24_Invalid > 0 OR h.mfgmat_numrel_slope_0t6_Invalid > 0 OR h.mfgmat_numrel_slope_6t12_Invalid > 0 OR h.ops_numrel_slope_0t12_Invalid > 0 OR h.ops_numrel_slope_0t24_Invalid > 0 OR h.ops_numrel_slope_0t6_Invalid > 0 OR h.ops_numrel_slope_6t12_Invalid > 0 OR h.fleet_numrel_slope_0t12_Invalid > 0 OR h.fleet_numrel_slope_0t24_Invalid > 0 OR h.fleet_numrel_slope_0t6_Invalid > 0 OR h.fleet_numrel_slope_6t12_Invalid > 0 OR h.carrier_numrel_slope_0t12_Invalid > 0 OR h.carrier_numrel_slope_0t24_Invalid > 0 OR h.carrier_numrel_slope_0t6_Invalid > 0 OR h.carrier_numrel_slope_6t12_Invalid > 0 OR h.bldgmats_numrel_slope_0t12_Invalid > 0 OR h.bldgmats_numrel_slope_0t24_Invalid > 0 OR h.bldgmats_numrel_slope_0t6_Invalid > 0 OR h.bldgmats_numrel_slope_6t12_Invalid > 0 OR h.bldgmats_numrel_var_0t12_Invalid > 0 OR h.bldgmats_numrel_var_12t24_Invalid > 0 OR h.total_percprov30_slope_0t12_Invalid > 0 OR h.total_percprov30_slope_0t24_Invalid > 0 OR h.total_percprov30_slope_0t6_Invalid > 0 OR h.total_percprov30_slope_6t12_Invalid > 0 OR h.total_percprov60_slope_0t12_Invalid > 0 OR h.total_percprov60_slope_0t24_Invalid > 0 OR h.total_percprov60_slope_0t6_Invalid > 0 OR h.total_percprov60_slope_6t12_Invalid > 0 OR h.total_percprov90_slope_0t24_Invalid > 0 OR h.total_percprov90_slope_0t6_Invalid > 0 OR h.total_percprov90_slope_6t12_Invalid > 0 OR h.mfgmat_percprov30_slope_0t12_Invalid > 0 OR h.mfgmat_percprov30_slope_6t12_Invalid > 0 OR h.mfgmat_percprov60_slope_0t12_Invalid > 0 OR h.mfgmat_percprov60_slope_6t12_Invalid > 0 OR h.mfgmat_percprov90_slope_0t24_Invalid > 0 OR h.mfgmat_percprov90_slope_0t6_Invalid > 0 OR h.mfgmat_percprov90_slope_6t12_Invalid > 0 OR h.ops_percprov30_slope_0t12_Invalid > 0 OR h.ops_percprov30_slope_6t12_Invalid > 0 OR h.ops_percprov60_slope_0t12_Invalid > 0 OR h.ops_percprov60_slope_6t12_Invalid > 0 OR h.ops_percprov90_slope_0t24_Invalid > 0 OR h.ops_percprov90_slope_0t6_Invalid > 0 OR h.ops_percprov90_slope_6t12_Invalid > 0 OR h.fleet_percprov30_slope_0t12_Invalid > 0 OR h.fleet_percprov30_slope_6t12_Invalid > 0 OR h.fleet_percprov60_slope_0t12_Invalid > 0 OR h.fleet_percprov60_slope_6t12_Invalid > 0 OR h.fleet_percprov90_slope_0t24_Invalid > 0 OR h.fleet_percprov90_slope_0t6_Invalid > 0 OR h.fleet_percprov90_slope_6t12_Invalid > 0 OR h.carrier_percprov30_slope_0t12_Invalid > 0 OR h.carrier_percprov30_slope_6t12_Invalid > 0 OR h.carrier_percprov60_slope_0t12_Invalid > 0 OR h.carrier_percprov60_slope_6t12_Invalid > 0 OR h.carrier_percprov90_slope_0t24_Invalid > 0 OR h.carrier_percprov90_slope_0t6_Invalid > 0 OR h.carrier_percprov90_slope_6t12_Invalid > 0 OR h.bldgmats_percprov30_slope_0t12_Invalid > 0 OR h.bldgmats_percprov30_slope_6t12_Invalid > 0 OR h.bldgmats_percprov60_slope_0t12_Invalid > 0 OR h.bldgmats_percprov60_slope_6t12_Invalid > 0 OR h.bldgmats_percprov90_slope_0t24_Invalid > 0 OR h.bldgmats_percprov90_slope_0t6_Invalid > 0 OR h.bldgmats_percprov90_slope_6t12_Invalid > 0 OR h.top5_percprov30_slope_0t12_Invalid > 0 OR h.top5_percprov30_slope_6t12_Invalid > 0 OR h.top5_percprov60_slope_0t12_Invalid > 0 OR h.top5_percprov60_slope_6t12_Invalid > 0 OR h.top5_percprov90_slope_0t24_Invalid > 0 OR h.top5_percprov90_slope_0t6_Invalid > 0 OR h.top5_percprov90_slope_6t12_Invalid > 0 OR h.top5_percprovoutstanding_adjustedslope_0t12_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.ultimate_linkid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cortera_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpr_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpr_segment_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbt_Total_ErrorCount > 0, 1, 0) + IF(le.avg_bal_ALLOW_ErrorCount > 0, 1, 0) + IF(le.air_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fuel_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.leasing_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ltl_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rail_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.tl_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.transvc_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.transup_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bst_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dg_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.electrical_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.hvac_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other_b_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.plumbing_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rs_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.wp_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.chemical_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.electronic_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.metal_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other_m_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.packaging_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pvf_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.plastic_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.textile_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bs_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ce_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.hardware_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ie_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.is_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.it_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mls_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pp_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sis_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.apparel_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.beverages_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.constr_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.consulting_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fs_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fp_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.insurance_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ls_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.oil_gas_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.utilities_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.advt_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.air_growth_Total_ErrorCount > 0, 1, 0) + IF(le.fuel_growth_Total_ErrorCount > 0, 1, 0) + IF(le.leasing_growth_Total_ErrorCount > 0, 1, 0) + IF(le.ltl_growth_Total_ErrorCount > 0, 1, 0) + IF(le.rail_growth_Total_ErrorCount > 0, 1, 0) + IF(le.tl_growth_Total_ErrorCount > 0, 1, 0) + IF(le.transvc_growth_Total_ErrorCount > 0, 1, 0) + IF(le.transup_growth_Total_ErrorCount > 0, 1, 0) + IF(le.bst_growth_Total_ErrorCount > 0, 1, 0) + IF(le.dg_growth_Total_ErrorCount > 0, 1, 0) + IF(le.electrical_growth_Total_ErrorCount > 0, 1, 0) + IF(le.hvac_growth_Total_ErrorCount > 0, 1, 0) + IF(le.other_b_growth_Total_ErrorCount > 0, 1, 0) + IF(le.plumbing_growth_Total_ErrorCount > 0, 1, 0) + IF(le.rs_growth_Total_ErrorCount > 0, 1, 0) + IF(le.wp_growth_Total_ErrorCount > 0, 1, 0) + IF(le.chemical_growth_Total_ErrorCount > 0, 1, 0) + IF(le.electronic_growth_Total_ErrorCount > 0, 1, 0) + IF(le.metal_growth_Total_ErrorCount > 0, 1, 0) + IF(le.other_m_growth_Total_ErrorCount > 0, 1, 0) + IF(le.packaging_growth_Total_ErrorCount > 0, 1, 0) + IF(le.pvf_growth_Total_ErrorCount > 0, 1, 0) + IF(le.plastic_growth_Total_ErrorCount > 0, 1, 0) + IF(le.textile_growth_Total_ErrorCount > 0, 1, 0) + IF(le.bs_growth_Total_ErrorCount > 0, 1, 0) + IF(le.ce_growth_Total_ErrorCount > 0, 1, 0) + IF(le.hardware_growth_Total_ErrorCount > 0, 1, 0) + IF(le.ie_growth_Total_ErrorCount > 0, 1, 0) + IF(le.is_growth_Total_ErrorCount > 0, 1, 0) + IF(le.it_growth_Total_ErrorCount > 0, 1, 0) + IF(le.mls_growth_Total_ErrorCount > 0, 1, 0) + IF(le.os_growth_Total_ErrorCount > 0, 1, 0) + IF(le.pp_growth_Total_ErrorCount > 0, 1, 0) + IF(le.sis_growth_Total_ErrorCount > 0, 1, 0) + IF(le.apparel_growth_Total_ErrorCount > 0, 1, 0) + IF(le.beverages_growth_Total_ErrorCount > 0, 1, 0) + IF(le.constr_growth_Total_ErrorCount > 0, 1, 0) + IF(le.consulting_growth_Total_ErrorCount > 0, 1, 0) + IF(le.fs_growth_Total_ErrorCount > 0, 1, 0) + IF(le.fp_growth_Total_ErrorCount > 0, 1, 0) + IF(le.insurance_growth_Total_ErrorCount > 0, 1, 0) + IF(le.ls_growth_Total_ErrorCount > 0, 1, 0) + IF(le.oil_gas_growth_Total_ErrorCount > 0, 1, 0) + IF(le.utilities_growth_Total_ErrorCount > 0, 1, 0) + IF(le.other_growth_Total_ErrorCount > 0, 1, 0) + IF(le.advt_growth_Total_ErrorCount > 0, 1, 0) + IF(le.top5_growth_Total_ErrorCount > 0, 1, 0) + IF(le.shipping_y1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.shipping_growth_Total_ErrorCount > 0, 1, 0) + IF(le.materials_y1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.materials_growth_Total_ErrorCount > 0, 1, 0) + IF(le.operations_y1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.operations_growth_Total_ErrorCount > 0, 1, 0) + IF(le.total_paid_average_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.total_paid_monthspastworst_24_Total_ErrorCount > 0, 1, 0) + IF(le.total_paid_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.total_paid_slope_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.total_paid_slope_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.total_paid_slope_6t18_Total_ErrorCount > 0, 1, 0) + IF(le.total_paid_volatility_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.total_paid_volatility_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.total_paid_volatility_12t18_Total_ErrorCount > 0, 1, 0) + IF(le.total_paid_volatility_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.total_spend_monthspastleast_24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_spend_monthspastmost_24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_spend_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.total_spend_slope_0t24_Total_ErrorCount > 0, 1, 0) + IF(le.total_spend_slope_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.total_spend_slope_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.total_spend_sum_12_Total_ErrorCount > 0, 1, 0) + IF(le.total_spend_volatility_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.total_spend_volatility_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.total_spend_volatility_12t18_Total_ErrorCount > 0, 1, 0) + IF(le.total_spend_volatility_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.mfgmat_paid_average_12_Total_ErrorCount > 0, 1, 0) + IF(le.mfgmat_paid_monthspastworst_24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mfgmat_paid_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.mfgmat_paid_slope_0t24_Total_ErrorCount > 0, 1, 0) + IF(le.mfgmat_paid_slope_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.mfgmat_paid_volatility_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.mfgmat_paid_volatility_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.mfgmat_spend_monthspastleast_24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mfgmat_spend_monthspastmost_24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mfgmat_spend_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.mfgmat_spend_slope_0t24_Total_ErrorCount > 0, 1, 0) + IF(le.mfgmat_spend_slope_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.mfgmat_spend_sum_12_Total_ErrorCount > 0, 1, 0) + IF(le.mfgmat_spend_volatility_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.mfgmat_spend_volatility_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.ops_paid_average_12_Total_ErrorCount > 0, 1, 0) + IF(le.ops_paid_monthspastworst_24_Total_ErrorCount > 0, 1, 0) + IF(le.ops_paid_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.ops_paid_slope_0t24_Total_ErrorCount > 0, 1, 0) + IF(le.ops_paid_slope_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.ops_paid_volatility_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.ops_paid_volatility_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.ops_spend_monthspastleast_24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ops_spend_monthspastmost_24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ops_spend_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.ops_spend_slope_0t24_Total_ErrorCount > 0, 1, 0) + IF(le.ops_spend_slope_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.fleet_paid_monthspastworst_24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fleet_paid_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.fleet_paid_slope_0t24_Total_ErrorCount > 0, 1, 0) + IF(le.fleet_paid_slope_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.fleet_paid_volatility_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.fleet_paid_volatility_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.fleet_spend_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.fleet_spend_slope_0t24_Total_ErrorCount > 0, 1, 0) + IF(le.fleet_spend_slope_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.carrier_paid_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.carrier_paid_slope_0t24_Total_ErrorCount > 0, 1, 0) + IF(le.carrier_paid_slope_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.carrier_paid_volatility_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.carrier_paid_volatility_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.carrier_spend_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.carrier_spend_slope_0t24_Total_ErrorCount > 0, 1, 0) + IF(le.carrier_spend_slope_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.carrier_spend_volatility_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.carrier_spend_volatility_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.bldgmats_paid_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.bldgmats_paid_slope_0t24_Total_ErrorCount > 0, 1, 0) + IF(le.bldgmats_paid_slope_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.bldgmats_paid_volatility_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.bldgmats_paid_volatility_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.bldgmats_spend_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.bldgmats_spend_slope_0t24_Total_ErrorCount > 0, 1, 0) + IF(le.bldgmats_spend_slope_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.bldgmats_spend_volatility_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.bldgmats_spend_volatility_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.top5_paid_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.top5_paid_slope_0t24_Total_ErrorCount > 0, 1, 0) + IF(le.top5_paid_slope_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.top5_paid_volatility_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.top5_paid_volatility_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.top5_spend_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.top5_spend_slope_0t24_Total_ErrorCount > 0, 1, 0) + IF(le.top5_spend_slope_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.top5_spend_volatility_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.top5_spend_volatility_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.total_numrel_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.total_numrel_slope_0t24_Total_ErrorCount > 0, 1, 0) + IF(le.total_numrel_slope_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.total_numrel_slope_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.mfgmat_numrel_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.mfgmat_numrel_slope_0t24_Total_ErrorCount > 0, 1, 0) + IF(le.mfgmat_numrel_slope_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.mfgmat_numrel_slope_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.ops_numrel_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.ops_numrel_slope_0t24_Total_ErrorCount > 0, 1, 0) + IF(le.ops_numrel_slope_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.ops_numrel_slope_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.fleet_numrel_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.fleet_numrel_slope_0t24_Total_ErrorCount > 0, 1, 0) + IF(le.fleet_numrel_slope_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.fleet_numrel_slope_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.carrier_numrel_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.carrier_numrel_slope_0t24_Total_ErrorCount > 0, 1, 0) + IF(le.carrier_numrel_slope_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.carrier_numrel_slope_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.bldgmats_numrel_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.bldgmats_numrel_slope_0t24_Total_ErrorCount > 0, 1, 0) + IF(le.bldgmats_numrel_slope_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.bldgmats_numrel_slope_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.bldgmats_numrel_var_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.bldgmats_numrel_var_12t24_Total_ErrorCount > 0, 1, 0) + IF(le.total_percprov30_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.total_percprov30_slope_0t24_Total_ErrorCount > 0, 1, 0) + IF(le.total_percprov30_slope_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.total_percprov30_slope_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.total_percprov60_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.total_percprov60_slope_0t24_Total_ErrorCount > 0, 1, 0) + IF(le.total_percprov60_slope_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.total_percprov60_slope_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.total_percprov90_slope_0t24_Total_ErrorCount > 0, 1, 0) + IF(le.total_percprov90_slope_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.total_percprov90_slope_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.mfgmat_percprov30_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.mfgmat_percprov30_slope_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.mfgmat_percprov60_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.mfgmat_percprov60_slope_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.mfgmat_percprov90_slope_0t24_Total_ErrorCount > 0, 1, 0) + IF(le.mfgmat_percprov90_slope_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.mfgmat_percprov90_slope_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.ops_percprov30_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.ops_percprov30_slope_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.ops_percprov60_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.ops_percprov60_slope_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.ops_percprov90_slope_0t24_Total_ErrorCount > 0, 1, 0) + IF(le.ops_percprov90_slope_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.ops_percprov90_slope_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.fleet_percprov30_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.fleet_percprov30_slope_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.fleet_percprov60_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.fleet_percprov60_slope_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.fleet_percprov90_slope_0t24_Total_ErrorCount > 0, 1, 0) + IF(le.fleet_percprov90_slope_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.fleet_percprov90_slope_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.carrier_percprov30_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.carrier_percprov30_slope_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.carrier_percprov60_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.carrier_percprov60_slope_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.carrier_percprov90_slope_0t24_Total_ErrorCount > 0, 1, 0) + IF(le.carrier_percprov90_slope_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.carrier_percprov90_slope_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.bldgmats_percprov30_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.bldgmats_percprov30_slope_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.bldgmats_percprov60_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.bldgmats_percprov60_slope_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.bldgmats_percprov90_slope_0t24_Total_ErrorCount > 0, 1, 0) + IF(le.bldgmats_percprov90_slope_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.bldgmats_percprov90_slope_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.top5_percprov30_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.top5_percprov30_slope_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.top5_percprov60_slope_0t12_Total_ErrorCount > 0, 1, 0) + IF(le.top5_percprov60_slope_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.top5_percprov90_slope_0t24_Total_ErrorCount > 0, 1, 0) + IF(le.top5_percprov90_slope_0t6_Total_ErrorCount > 0, 1, 0) + IF(le.top5_percprov90_slope_6t12_Total_ErrorCount > 0, 1, 0) + IF(le.top5_percprovoutstanding_adjustedslope_0t12_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.ultimate_linkid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cortera_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpr_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cpr_segment_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.avg_bal_ALLOW_ErrorCount > 0, 1, 0) + IF(le.air_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fuel_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.leasing_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ltl_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rail_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.tl_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.transvc_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.transup_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bst_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dg_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.electrical_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.hvac_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other_b_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.plumbing_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rs_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.wp_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.chemical_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.electronic_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.metal_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other_m_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.packaging_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pvf_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.plastic_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.textile_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bs_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ce_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.hardware_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ie_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.is_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.it_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mls_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pp_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sis_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.apparel_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.beverages_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.constr_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.consulting_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fs_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fp_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.insurance_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ls_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.oil_gas_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.utilities_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.advt_spend_ALLOW_ErrorCount > 0, 1, 0) + IF(le.air_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.air_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fuel_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fuel_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.leasing_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.leasing_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ltl_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ltl_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.rail_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rail_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tl_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.tl_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.transvc_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.transvc_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.transup_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.transup_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bst_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bst_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dg_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dg_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.electrical_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.electrical_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.hvac_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.hvac_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.other_b_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other_b_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.plumbing_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.plumbing_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.rs_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rs_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.wp_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.wp_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.chemical_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.chemical_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.electronic_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.electronic_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.metal_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.metal_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.other_m_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other_m_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.packaging_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.packaging_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.pvf_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pvf_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.plastic_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.plastic_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.textile_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.textile_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bs_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bs_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ce_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ce_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.hardware_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.hardware_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ie_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ie_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.is_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.is_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.it_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.it_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mls_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mls_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.os_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.os_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.pp_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pp_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.sis_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sis_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.apparel_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.apparel_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.beverages_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.beverages_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.constr_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.constr_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.consulting_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.consulting_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fs_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fs_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fp_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fp_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.insurance_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.insurance_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ls_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ls_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.oil_gas_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.oil_gas_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.utilities_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.utilities_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.other_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.other_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.advt_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.advt_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.top5_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.top5_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.shipping_y1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.shipping_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.shipping_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.materials_y1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.materials_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.materials_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.operations_y1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.operations_growth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.operations_growth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_paid_average_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_paid_average_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_paid_monthspastworst_24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_paid_monthspastworst_24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_paid_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_paid_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_paid_slope_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_paid_slope_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_paid_slope_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_paid_slope_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_paid_slope_6t18_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_paid_slope_6t18_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_paid_volatility_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_paid_volatility_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_paid_volatility_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_paid_volatility_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_paid_volatility_12t18_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_paid_volatility_12t18_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_paid_volatility_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_paid_volatility_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_spend_monthspastleast_24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_spend_monthspastmost_24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_spend_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_spend_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_spend_slope_0t24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_spend_slope_0t24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_spend_slope_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_spend_slope_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_spend_slope_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_spend_slope_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_spend_sum_12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_spend_sum_12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_spend_volatility_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_spend_volatility_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_spend_volatility_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_spend_volatility_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_spend_volatility_12t18_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_spend_volatility_12t18_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_spend_volatility_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_spend_volatility_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mfgmat_paid_average_12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mfgmat_paid_average_12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mfgmat_paid_monthspastworst_24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mfgmat_paid_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mfgmat_paid_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mfgmat_paid_slope_0t24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mfgmat_paid_slope_0t24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mfgmat_paid_slope_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mfgmat_paid_slope_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mfgmat_paid_volatility_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mfgmat_paid_volatility_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mfgmat_paid_volatility_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mfgmat_paid_volatility_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mfgmat_spend_monthspastleast_24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mfgmat_spend_monthspastmost_24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mfgmat_spend_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mfgmat_spend_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mfgmat_spend_slope_0t24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mfgmat_spend_slope_0t24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mfgmat_spend_slope_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mfgmat_spend_slope_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mfgmat_spend_sum_12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mfgmat_spend_sum_12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mfgmat_spend_volatility_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mfgmat_spend_volatility_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mfgmat_spend_volatility_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mfgmat_spend_volatility_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ops_paid_average_12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ops_paid_average_12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ops_paid_monthspastworst_24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ops_paid_monthspastworst_24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ops_paid_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ops_paid_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ops_paid_slope_0t24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ops_paid_slope_0t24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ops_paid_slope_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ops_paid_slope_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ops_paid_volatility_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ops_paid_volatility_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ops_paid_volatility_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ops_paid_volatility_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ops_spend_monthspastleast_24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ops_spend_monthspastmost_24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ops_spend_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ops_spend_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ops_spend_slope_0t24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ops_spend_slope_0t24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ops_spend_slope_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ops_spend_slope_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fleet_paid_monthspastworst_24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fleet_paid_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fleet_paid_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fleet_paid_slope_0t24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fleet_paid_slope_0t24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fleet_paid_slope_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fleet_paid_slope_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fleet_paid_volatility_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fleet_paid_volatility_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fleet_paid_volatility_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fleet_paid_volatility_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fleet_spend_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fleet_spend_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fleet_spend_slope_0t24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fleet_spend_slope_0t24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fleet_spend_slope_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fleet_spend_slope_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.carrier_paid_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_paid_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.carrier_paid_slope_0t24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_paid_slope_0t24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.carrier_paid_slope_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_paid_slope_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.carrier_paid_volatility_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_paid_volatility_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.carrier_paid_volatility_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_paid_volatility_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.carrier_spend_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_spend_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.carrier_spend_slope_0t24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_spend_slope_0t24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.carrier_spend_slope_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_spend_slope_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.carrier_spend_volatility_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_spend_volatility_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.carrier_spend_volatility_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_spend_volatility_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bldgmats_paid_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bldgmats_paid_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bldgmats_paid_slope_0t24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bldgmats_paid_slope_0t24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bldgmats_paid_slope_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bldgmats_paid_slope_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bldgmats_paid_volatility_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bldgmats_paid_volatility_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bldgmats_paid_volatility_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bldgmats_paid_volatility_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bldgmats_spend_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bldgmats_spend_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bldgmats_spend_slope_0t24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bldgmats_spend_slope_0t24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bldgmats_spend_slope_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bldgmats_spend_slope_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bldgmats_spend_volatility_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bldgmats_spend_volatility_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bldgmats_spend_volatility_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bldgmats_spend_volatility_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.top5_paid_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.top5_paid_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.top5_paid_slope_0t24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.top5_paid_slope_0t24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.top5_paid_slope_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.top5_paid_slope_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.top5_paid_volatility_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.top5_paid_volatility_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.top5_paid_volatility_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.top5_paid_volatility_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.top5_spend_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.top5_spend_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.top5_spend_slope_0t24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.top5_spend_slope_0t24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.top5_spend_slope_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.top5_spend_slope_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.top5_spend_volatility_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.top5_spend_volatility_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.top5_spend_volatility_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.top5_spend_volatility_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_numrel_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_numrel_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_numrel_slope_0t24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_numrel_slope_0t24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_numrel_slope_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_numrel_slope_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_numrel_slope_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_numrel_slope_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mfgmat_numrel_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mfgmat_numrel_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mfgmat_numrel_slope_0t24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mfgmat_numrel_slope_0t24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mfgmat_numrel_slope_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mfgmat_numrel_slope_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mfgmat_numrel_slope_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mfgmat_numrel_slope_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ops_numrel_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ops_numrel_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ops_numrel_slope_0t24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ops_numrel_slope_0t24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ops_numrel_slope_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ops_numrel_slope_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ops_numrel_slope_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ops_numrel_slope_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fleet_numrel_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fleet_numrel_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fleet_numrel_slope_0t24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fleet_numrel_slope_0t24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fleet_numrel_slope_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fleet_numrel_slope_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fleet_numrel_slope_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fleet_numrel_slope_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.carrier_numrel_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_numrel_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.carrier_numrel_slope_0t24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_numrel_slope_0t24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.carrier_numrel_slope_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_numrel_slope_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.carrier_numrel_slope_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_numrel_slope_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bldgmats_numrel_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bldgmats_numrel_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bldgmats_numrel_slope_0t24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bldgmats_numrel_slope_0t24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bldgmats_numrel_slope_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bldgmats_numrel_slope_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bldgmats_numrel_slope_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bldgmats_numrel_slope_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bldgmats_numrel_var_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bldgmats_numrel_var_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bldgmats_numrel_var_12t24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bldgmats_numrel_var_12t24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_percprov30_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_percprov30_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_percprov30_slope_0t24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_percprov30_slope_0t24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_percprov30_slope_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_percprov30_slope_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_percprov30_slope_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_percprov30_slope_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_percprov60_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_percprov60_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_percprov60_slope_0t24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_percprov60_slope_0t24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_percprov60_slope_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_percprov60_slope_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_percprov60_slope_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_percprov60_slope_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_percprov90_slope_0t24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_percprov90_slope_0t24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_percprov90_slope_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_percprov90_slope_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_percprov90_slope_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_percprov90_slope_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mfgmat_percprov30_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mfgmat_percprov30_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mfgmat_percprov30_slope_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mfgmat_percprov30_slope_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mfgmat_percprov60_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mfgmat_percprov60_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mfgmat_percprov60_slope_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mfgmat_percprov60_slope_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mfgmat_percprov90_slope_0t24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mfgmat_percprov90_slope_0t24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mfgmat_percprov90_slope_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mfgmat_percprov90_slope_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mfgmat_percprov90_slope_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mfgmat_percprov90_slope_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ops_percprov30_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ops_percprov30_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ops_percprov30_slope_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ops_percprov30_slope_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ops_percprov60_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ops_percprov60_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ops_percprov60_slope_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ops_percprov60_slope_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ops_percprov90_slope_0t24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ops_percprov90_slope_0t24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ops_percprov90_slope_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ops_percprov90_slope_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ops_percprov90_slope_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ops_percprov90_slope_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fleet_percprov30_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fleet_percprov30_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fleet_percprov30_slope_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fleet_percprov30_slope_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fleet_percprov60_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fleet_percprov60_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fleet_percprov60_slope_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fleet_percprov60_slope_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fleet_percprov90_slope_0t24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fleet_percprov90_slope_0t24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fleet_percprov90_slope_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fleet_percprov90_slope_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fleet_percprov90_slope_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fleet_percprov90_slope_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.carrier_percprov30_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_percprov30_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.carrier_percprov30_slope_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_percprov30_slope_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.carrier_percprov60_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_percprov60_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.carrier_percprov60_slope_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_percprov60_slope_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.carrier_percprov90_slope_0t24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_percprov90_slope_0t24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.carrier_percprov90_slope_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_percprov90_slope_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.carrier_percprov90_slope_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.carrier_percprov90_slope_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bldgmats_percprov30_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bldgmats_percprov30_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bldgmats_percprov30_slope_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bldgmats_percprov30_slope_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bldgmats_percprov60_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bldgmats_percprov60_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bldgmats_percprov60_slope_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bldgmats_percprov60_slope_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bldgmats_percprov90_slope_0t24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bldgmats_percprov90_slope_0t24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bldgmats_percprov90_slope_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bldgmats_percprov90_slope_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bldgmats_percprov90_slope_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bldgmats_percprov90_slope_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.top5_percprov30_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.top5_percprov30_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.top5_percprov30_slope_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.top5_percprov30_slope_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.top5_percprov60_slope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.top5_percprov60_slope_0t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.top5_percprov60_slope_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.top5_percprov60_slope_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.top5_percprov90_slope_0t24_ALLOW_ErrorCount > 0, 1, 0) + IF(le.top5_percprov90_slope_0t24_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.top5_percprov90_slope_0t6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.top5_percprov90_slope_0t6_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.top5_percprov90_slope_6t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.top5_percprov90_slope_6t12_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.top5_percprovoutstanding_adjustedslope_0t12_ALLOW_ErrorCount > 0, 1, 0) + IF(le.top5_percprovoutstanding_adjustedslope_0t12_LENGTHS_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT311.StrType ErrorMessage;
    SALT311.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.ultimate_linkid_Invalid,le.cortera_score_Invalid,le.cpr_score_Invalid,le.cpr_segment_Invalid,le.dbt_Invalid,le.avg_bal_Invalid,le.air_spend_Invalid,le.fuel_spend_Invalid,le.leasing_spend_Invalid,le.ltl_spend_Invalid,le.rail_spend_Invalid,le.tl_spend_Invalid,le.transvc_spend_Invalid,le.transup_spend_Invalid,le.bst_spend_Invalid,le.dg_spend_Invalid,le.electrical_spend_Invalid,le.hvac_spend_Invalid,le.other_b_spend_Invalid,le.plumbing_spend_Invalid,le.rs_spend_Invalid,le.wp_spend_Invalid,le.chemical_spend_Invalid,le.electronic_spend_Invalid,le.metal_spend_Invalid,le.other_m_spend_Invalid,le.packaging_spend_Invalid,le.pvf_spend_Invalid,le.plastic_spend_Invalid,le.textile_spend_Invalid,le.bs_spend_Invalid,le.ce_spend_Invalid,le.hardware_spend_Invalid,le.ie_spend_Invalid,le.is_spend_Invalid,le.it_spend_Invalid,le.mls_spend_Invalid,le.os_spend_Invalid,le.pp_spend_Invalid,le.sis_spend_Invalid,le.apparel_spend_Invalid,le.beverages_spend_Invalid,le.constr_spend_Invalid,le.consulting_spend_Invalid,le.fs_spend_Invalid,le.fp_spend_Invalid,le.insurance_spend_Invalid,le.ls_spend_Invalid,le.oil_gas_spend_Invalid,le.utilities_spend_Invalid,le.other_spend_Invalid,le.advt_spend_Invalid,le.air_growth_Invalid,le.fuel_growth_Invalid,le.leasing_growth_Invalid,le.ltl_growth_Invalid,le.rail_growth_Invalid,le.tl_growth_Invalid,le.transvc_growth_Invalid,le.transup_growth_Invalid,le.bst_growth_Invalid,le.dg_growth_Invalid,le.electrical_growth_Invalid,le.hvac_growth_Invalid,le.other_b_growth_Invalid,le.plumbing_growth_Invalid,le.rs_growth_Invalid,le.wp_growth_Invalid,le.chemical_growth_Invalid,le.electronic_growth_Invalid,le.metal_growth_Invalid,le.other_m_growth_Invalid,le.packaging_growth_Invalid,le.pvf_growth_Invalid,le.plastic_growth_Invalid,le.textile_growth_Invalid,le.bs_growth_Invalid,le.ce_growth_Invalid,le.hardware_growth_Invalid,le.ie_growth_Invalid,le.is_growth_Invalid,le.it_growth_Invalid,le.mls_growth_Invalid,le.os_growth_Invalid,le.pp_growth_Invalid,le.sis_growth_Invalid,le.apparel_growth_Invalid,le.beverages_growth_Invalid,le.constr_growth_Invalid,le.consulting_growth_Invalid,le.fs_growth_Invalid,le.fp_growth_Invalid,le.insurance_growth_Invalid,le.ls_growth_Invalid,le.oil_gas_growth_Invalid,le.utilities_growth_Invalid,le.other_growth_Invalid,le.advt_growth_Invalid,le.top5_growth_Invalid,le.shipping_y1_Invalid,le.shipping_growth_Invalid,le.materials_y1_Invalid,le.materials_growth_Invalid,le.operations_y1_Invalid,le.operations_growth_Invalid,le.total_paid_average_0t12_Invalid,le.total_paid_monthspastworst_24_Invalid,le.total_paid_slope_0t12_Invalid,le.total_paid_slope_0t6_Invalid,le.total_paid_slope_6t12_Invalid,le.total_paid_slope_6t18_Invalid,le.total_paid_volatility_0t12_Invalid,le.total_paid_volatility_0t6_Invalid,le.total_paid_volatility_12t18_Invalid,le.total_paid_volatility_6t12_Invalid,le.total_spend_monthspastleast_24_Invalid,le.total_spend_monthspastmost_24_Invalid,le.total_spend_slope_0t12_Invalid,le.total_spend_slope_0t24_Invalid,le.total_spend_slope_0t6_Invalid,le.total_spend_slope_6t12_Invalid,le.total_spend_sum_12_Invalid,le.total_spend_volatility_0t12_Invalid,le.total_spend_volatility_0t6_Invalid,le.total_spend_volatility_12t18_Invalid,le.total_spend_volatility_6t12_Invalid,le.mfgmat_paid_average_12_Invalid,le.mfgmat_paid_monthspastworst_24_Invalid,le.mfgmat_paid_slope_0t12_Invalid,le.mfgmat_paid_slope_0t24_Invalid,le.mfgmat_paid_slope_0t6_Invalid,le.mfgmat_paid_volatility_0t12_Invalid,le.mfgmat_paid_volatility_0t6_Invalid,le.mfgmat_spend_monthspastleast_24_Invalid,le.mfgmat_spend_monthspastmost_24_Invalid,le.mfgmat_spend_slope_0t12_Invalid,le.mfgmat_spend_slope_0t24_Invalid,le.mfgmat_spend_slope_0t6_Invalid,le.mfgmat_spend_sum_12_Invalid,le.mfgmat_spend_volatility_0t6_Invalid,le.mfgmat_spend_volatility_6t12_Invalid,le.ops_paid_average_12_Invalid,le.ops_paid_monthspastworst_24_Invalid,le.ops_paid_slope_0t12_Invalid,le.ops_paid_slope_0t24_Invalid,le.ops_paid_slope_0t6_Invalid,le.ops_paid_volatility_0t12_Invalid,le.ops_paid_volatility_0t6_Invalid,le.ops_spend_monthspastleast_24_Invalid,le.ops_spend_monthspastmost_24_Invalid,le.ops_spend_slope_0t12_Invalid,le.ops_spend_slope_0t24_Invalid,le.ops_spend_slope_0t6_Invalid,le.fleet_paid_monthspastworst_24_Invalid,le.fleet_paid_slope_0t12_Invalid,le.fleet_paid_slope_0t24_Invalid,le.fleet_paid_slope_0t6_Invalid,le.fleet_paid_volatility_0t12_Invalid,le.fleet_paid_volatility_0t6_Invalid,le.fleet_spend_slope_0t12_Invalid,le.fleet_spend_slope_0t24_Invalid,le.fleet_spend_slope_0t6_Invalid,le.carrier_paid_slope_0t12_Invalid,le.carrier_paid_slope_0t24_Invalid,le.carrier_paid_slope_0t6_Invalid,le.carrier_paid_volatility_0t12_Invalid,le.carrier_paid_volatility_0t6_Invalid,le.carrier_spend_slope_0t12_Invalid,le.carrier_spend_slope_0t24_Invalid,le.carrier_spend_slope_0t6_Invalid,le.carrier_spend_volatility_0t6_Invalid,le.carrier_spend_volatility_6t12_Invalid,le.bldgmats_paid_slope_0t12_Invalid,le.bldgmats_paid_slope_0t24_Invalid,le.bldgmats_paid_slope_0t6_Invalid,le.bldgmats_paid_volatility_0t12_Invalid,le.bldgmats_paid_volatility_0t6_Invalid,le.bldgmats_spend_slope_0t12_Invalid,le.bldgmats_spend_slope_0t24_Invalid,le.bldgmats_spend_slope_0t6_Invalid,le.bldgmats_spend_volatility_0t6_Invalid,le.bldgmats_spend_volatility_6t12_Invalid,le.top5_paid_slope_0t12_Invalid,le.top5_paid_slope_0t24_Invalid,le.top5_paid_slope_0t6_Invalid,le.top5_paid_volatility_0t12_Invalid,le.top5_paid_volatility_0t6_Invalid,le.top5_spend_slope_0t12_Invalid,le.top5_spend_slope_0t24_Invalid,le.top5_spend_slope_0t6_Invalid,le.top5_spend_volatility_0t6_Invalid,le.top5_spend_volatility_6t12_Invalid,le.total_numrel_slope_0t12_Invalid,le.total_numrel_slope_0t24_Invalid,le.total_numrel_slope_0t6_Invalid,le.total_numrel_slope_6t12_Invalid,le.mfgmat_numrel_slope_0t12_Invalid,le.mfgmat_numrel_slope_0t24_Invalid,le.mfgmat_numrel_slope_0t6_Invalid,le.mfgmat_numrel_slope_6t12_Invalid,le.ops_numrel_slope_0t12_Invalid,le.ops_numrel_slope_0t24_Invalid,le.ops_numrel_slope_0t6_Invalid,le.ops_numrel_slope_6t12_Invalid,le.fleet_numrel_slope_0t12_Invalid,le.fleet_numrel_slope_0t24_Invalid,le.fleet_numrel_slope_0t6_Invalid,le.fleet_numrel_slope_6t12_Invalid,le.carrier_numrel_slope_0t12_Invalid,le.carrier_numrel_slope_0t24_Invalid,le.carrier_numrel_slope_0t6_Invalid,le.carrier_numrel_slope_6t12_Invalid,le.bldgmats_numrel_slope_0t12_Invalid,le.bldgmats_numrel_slope_0t24_Invalid,le.bldgmats_numrel_slope_0t6_Invalid,le.bldgmats_numrel_slope_6t12_Invalid,le.bldgmats_numrel_var_0t12_Invalid,le.bldgmats_numrel_var_12t24_Invalid,le.total_percprov30_slope_0t12_Invalid,le.total_percprov30_slope_0t24_Invalid,le.total_percprov30_slope_0t6_Invalid,le.total_percprov30_slope_6t12_Invalid,le.total_percprov60_slope_0t12_Invalid,le.total_percprov60_slope_0t24_Invalid,le.total_percprov60_slope_0t6_Invalid,le.total_percprov60_slope_6t12_Invalid,le.total_percprov90_slope_0t24_Invalid,le.total_percprov90_slope_0t6_Invalid,le.total_percprov90_slope_6t12_Invalid,le.mfgmat_percprov30_slope_0t12_Invalid,le.mfgmat_percprov30_slope_6t12_Invalid,le.mfgmat_percprov60_slope_0t12_Invalid,le.mfgmat_percprov60_slope_6t12_Invalid,le.mfgmat_percprov90_slope_0t24_Invalid,le.mfgmat_percprov90_slope_0t6_Invalid,le.mfgmat_percprov90_slope_6t12_Invalid,le.ops_percprov30_slope_0t12_Invalid,le.ops_percprov30_slope_6t12_Invalid,le.ops_percprov60_slope_0t12_Invalid,le.ops_percprov60_slope_6t12_Invalid,le.ops_percprov90_slope_0t24_Invalid,le.ops_percprov90_slope_0t6_Invalid,le.ops_percprov90_slope_6t12_Invalid,le.fleet_percprov30_slope_0t12_Invalid,le.fleet_percprov30_slope_6t12_Invalid,le.fleet_percprov60_slope_0t12_Invalid,le.fleet_percprov60_slope_6t12_Invalid,le.fleet_percprov90_slope_0t24_Invalid,le.fleet_percprov90_slope_0t6_Invalid,le.fleet_percprov90_slope_6t12_Invalid,le.carrier_percprov30_slope_0t12_Invalid,le.carrier_percprov30_slope_6t12_Invalid,le.carrier_percprov60_slope_0t12_Invalid,le.carrier_percprov60_slope_6t12_Invalid,le.carrier_percprov90_slope_0t24_Invalid,le.carrier_percprov90_slope_0t6_Invalid,le.carrier_percprov90_slope_6t12_Invalid,le.bldgmats_percprov30_slope_0t12_Invalid,le.bldgmats_percprov30_slope_6t12_Invalid,le.bldgmats_percprov60_slope_0t12_Invalid,le.bldgmats_percprov60_slope_6t12_Invalid,le.bldgmats_percprov90_slope_0t24_Invalid,le.bldgmats_percprov90_slope_0t6_Invalid,le.bldgmats_percprov90_slope_6t12_Invalid,le.top5_percprov30_slope_0t12_Invalid,le.top5_percprov30_slope_6t12_Invalid,le.top5_percprov60_slope_0t12_Invalid,le.top5_percprov60_slope_6t12_Invalid,le.top5_percprov90_slope_0t24_Invalid,le.top5_percprov90_slope_0t6_Invalid,le.top5_percprov90_slope_6t12_Invalid,le.top5_percprovoutstanding_adjustedslope_0t12_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Attributes_Fields.InvalidMessage_ultimate_linkid(le.ultimate_linkid_Invalid),Attributes_Fields.InvalidMessage_cortera_score(le.cortera_score_Invalid),Attributes_Fields.InvalidMessage_cpr_score(le.cpr_score_Invalid),Attributes_Fields.InvalidMessage_cpr_segment(le.cpr_segment_Invalid),Attributes_Fields.InvalidMessage_dbt(le.dbt_Invalid),Attributes_Fields.InvalidMessage_avg_bal(le.avg_bal_Invalid),Attributes_Fields.InvalidMessage_air_spend(le.air_spend_Invalid),Attributes_Fields.InvalidMessage_fuel_spend(le.fuel_spend_Invalid),Attributes_Fields.InvalidMessage_leasing_spend(le.leasing_spend_Invalid),Attributes_Fields.InvalidMessage_ltl_spend(le.ltl_spend_Invalid),Attributes_Fields.InvalidMessage_rail_spend(le.rail_spend_Invalid),Attributes_Fields.InvalidMessage_tl_spend(le.tl_spend_Invalid),Attributes_Fields.InvalidMessage_transvc_spend(le.transvc_spend_Invalid),Attributes_Fields.InvalidMessage_transup_spend(le.transup_spend_Invalid),Attributes_Fields.InvalidMessage_bst_spend(le.bst_spend_Invalid),Attributes_Fields.InvalidMessage_dg_spend(le.dg_spend_Invalid),Attributes_Fields.InvalidMessage_electrical_spend(le.electrical_spend_Invalid),Attributes_Fields.InvalidMessage_hvac_spend(le.hvac_spend_Invalid),Attributes_Fields.InvalidMessage_other_b_spend(le.other_b_spend_Invalid),Attributes_Fields.InvalidMessage_plumbing_spend(le.plumbing_spend_Invalid),Attributes_Fields.InvalidMessage_rs_spend(le.rs_spend_Invalid),Attributes_Fields.InvalidMessage_wp_spend(le.wp_spend_Invalid),Attributes_Fields.InvalidMessage_chemical_spend(le.chemical_spend_Invalid),Attributes_Fields.InvalidMessage_electronic_spend(le.electronic_spend_Invalid),Attributes_Fields.InvalidMessage_metal_spend(le.metal_spend_Invalid),Attributes_Fields.InvalidMessage_other_m_spend(le.other_m_spend_Invalid),Attributes_Fields.InvalidMessage_packaging_spend(le.packaging_spend_Invalid),Attributes_Fields.InvalidMessage_pvf_spend(le.pvf_spend_Invalid),Attributes_Fields.InvalidMessage_plastic_spend(le.plastic_spend_Invalid),Attributes_Fields.InvalidMessage_textile_spend(le.textile_spend_Invalid),Attributes_Fields.InvalidMessage_bs_spend(le.bs_spend_Invalid),Attributes_Fields.InvalidMessage_ce_spend(le.ce_spend_Invalid),Attributes_Fields.InvalidMessage_hardware_spend(le.hardware_spend_Invalid),Attributes_Fields.InvalidMessage_ie_spend(le.ie_spend_Invalid),Attributes_Fields.InvalidMessage_is_spend(le.is_spend_Invalid),Attributes_Fields.InvalidMessage_it_spend(le.it_spend_Invalid),Attributes_Fields.InvalidMessage_mls_spend(le.mls_spend_Invalid),Attributes_Fields.InvalidMessage_os_spend(le.os_spend_Invalid),Attributes_Fields.InvalidMessage_pp_spend(le.pp_spend_Invalid),Attributes_Fields.InvalidMessage_sis_spend(le.sis_spend_Invalid),Attributes_Fields.InvalidMessage_apparel_spend(le.apparel_spend_Invalid),Attributes_Fields.InvalidMessage_beverages_spend(le.beverages_spend_Invalid),Attributes_Fields.InvalidMessage_constr_spend(le.constr_spend_Invalid),Attributes_Fields.InvalidMessage_consulting_spend(le.consulting_spend_Invalid),Attributes_Fields.InvalidMessage_fs_spend(le.fs_spend_Invalid),Attributes_Fields.InvalidMessage_fp_spend(le.fp_spend_Invalid),Attributes_Fields.InvalidMessage_insurance_spend(le.insurance_spend_Invalid),Attributes_Fields.InvalidMessage_ls_spend(le.ls_spend_Invalid),Attributes_Fields.InvalidMessage_oil_gas_spend(le.oil_gas_spend_Invalid),Attributes_Fields.InvalidMessage_utilities_spend(le.utilities_spend_Invalid),Attributes_Fields.InvalidMessage_other_spend(le.other_spend_Invalid),Attributes_Fields.InvalidMessage_advt_spend(le.advt_spend_Invalid),Attributes_Fields.InvalidMessage_air_growth(le.air_growth_Invalid),Attributes_Fields.InvalidMessage_fuel_growth(le.fuel_growth_Invalid),Attributes_Fields.InvalidMessage_leasing_growth(le.leasing_growth_Invalid),Attributes_Fields.InvalidMessage_ltl_growth(le.ltl_growth_Invalid),Attributes_Fields.InvalidMessage_rail_growth(le.rail_growth_Invalid),Attributes_Fields.InvalidMessage_tl_growth(le.tl_growth_Invalid),Attributes_Fields.InvalidMessage_transvc_growth(le.transvc_growth_Invalid),Attributes_Fields.InvalidMessage_transup_growth(le.transup_growth_Invalid),Attributes_Fields.InvalidMessage_bst_growth(le.bst_growth_Invalid),Attributes_Fields.InvalidMessage_dg_growth(le.dg_growth_Invalid),Attributes_Fields.InvalidMessage_electrical_growth(le.electrical_growth_Invalid),Attributes_Fields.InvalidMessage_hvac_growth(le.hvac_growth_Invalid),Attributes_Fields.InvalidMessage_other_b_growth(le.other_b_growth_Invalid),Attributes_Fields.InvalidMessage_plumbing_growth(le.plumbing_growth_Invalid),Attributes_Fields.InvalidMessage_rs_growth(le.rs_growth_Invalid),Attributes_Fields.InvalidMessage_wp_growth(le.wp_growth_Invalid),Attributes_Fields.InvalidMessage_chemical_growth(le.chemical_growth_Invalid),Attributes_Fields.InvalidMessage_electronic_growth(le.electronic_growth_Invalid),Attributes_Fields.InvalidMessage_metal_growth(le.metal_growth_Invalid),Attributes_Fields.InvalidMessage_other_m_growth(le.other_m_growth_Invalid),Attributes_Fields.InvalidMessage_packaging_growth(le.packaging_growth_Invalid),Attributes_Fields.InvalidMessage_pvf_growth(le.pvf_growth_Invalid),Attributes_Fields.InvalidMessage_plastic_growth(le.plastic_growth_Invalid),Attributes_Fields.InvalidMessage_textile_growth(le.textile_growth_Invalid),Attributes_Fields.InvalidMessage_bs_growth(le.bs_growth_Invalid),Attributes_Fields.InvalidMessage_ce_growth(le.ce_growth_Invalid),Attributes_Fields.InvalidMessage_hardware_growth(le.hardware_growth_Invalid),Attributes_Fields.InvalidMessage_ie_growth(le.ie_growth_Invalid),Attributes_Fields.InvalidMessage_is_growth(le.is_growth_Invalid),Attributes_Fields.InvalidMessage_it_growth(le.it_growth_Invalid),Attributes_Fields.InvalidMessage_mls_growth(le.mls_growth_Invalid),Attributes_Fields.InvalidMessage_os_growth(le.os_growth_Invalid),Attributes_Fields.InvalidMessage_pp_growth(le.pp_growth_Invalid),Attributes_Fields.InvalidMessage_sis_growth(le.sis_growth_Invalid),Attributes_Fields.InvalidMessage_apparel_growth(le.apparel_growth_Invalid),Attributes_Fields.InvalidMessage_beverages_growth(le.beverages_growth_Invalid),Attributes_Fields.InvalidMessage_constr_growth(le.constr_growth_Invalid),Attributes_Fields.InvalidMessage_consulting_growth(le.consulting_growth_Invalid),Attributes_Fields.InvalidMessage_fs_growth(le.fs_growth_Invalid),Attributes_Fields.InvalidMessage_fp_growth(le.fp_growth_Invalid),Attributes_Fields.InvalidMessage_insurance_growth(le.insurance_growth_Invalid),Attributes_Fields.InvalidMessage_ls_growth(le.ls_growth_Invalid),Attributes_Fields.InvalidMessage_oil_gas_growth(le.oil_gas_growth_Invalid),Attributes_Fields.InvalidMessage_utilities_growth(le.utilities_growth_Invalid),Attributes_Fields.InvalidMessage_other_growth(le.other_growth_Invalid),Attributes_Fields.InvalidMessage_advt_growth(le.advt_growth_Invalid),Attributes_Fields.InvalidMessage_top5_growth(le.top5_growth_Invalid),Attributes_Fields.InvalidMessage_shipping_y1(le.shipping_y1_Invalid),Attributes_Fields.InvalidMessage_shipping_growth(le.shipping_growth_Invalid),Attributes_Fields.InvalidMessage_materials_y1(le.materials_y1_Invalid),Attributes_Fields.InvalidMessage_materials_growth(le.materials_growth_Invalid),Attributes_Fields.InvalidMessage_operations_y1(le.operations_y1_Invalid),Attributes_Fields.InvalidMessage_operations_growth(le.operations_growth_Invalid),Attributes_Fields.InvalidMessage_total_paid_average_0t12(le.total_paid_average_0t12_Invalid),Attributes_Fields.InvalidMessage_total_paid_monthspastworst_24(le.total_paid_monthspastworst_24_Invalid),Attributes_Fields.InvalidMessage_total_paid_slope_0t12(le.total_paid_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_total_paid_slope_0t6(le.total_paid_slope_0t6_Invalid),Attributes_Fields.InvalidMessage_total_paid_slope_6t12(le.total_paid_slope_6t12_Invalid),Attributes_Fields.InvalidMessage_total_paid_slope_6t18(le.total_paid_slope_6t18_Invalid),Attributes_Fields.InvalidMessage_total_paid_volatility_0t12(le.total_paid_volatility_0t12_Invalid),Attributes_Fields.InvalidMessage_total_paid_volatility_0t6(le.total_paid_volatility_0t6_Invalid),Attributes_Fields.InvalidMessage_total_paid_volatility_12t18(le.total_paid_volatility_12t18_Invalid),Attributes_Fields.InvalidMessage_total_paid_volatility_6t12(le.total_paid_volatility_6t12_Invalid),Attributes_Fields.InvalidMessage_total_spend_monthspastleast_24(le.total_spend_monthspastleast_24_Invalid),Attributes_Fields.InvalidMessage_total_spend_monthspastmost_24(le.total_spend_monthspastmost_24_Invalid),Attributes_Fields.InvalidMessage_total_spend_slope_0t12(le.total_spend_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_total_spend_slope_0t24(le.total_spend_slope_0t24_Invalid),Attributes_Fields.InvalidMessage_total_spend_slope_0t6(le.total_spend_slope_0t6_Invalid),Attributes_Fields.InvalidMessage_total_spend_slope_6t12(le.total_spend_slope_6t12_Invalid),Attributes_Fields.InvalidMessage_total_spend_sum_12(le.total_spend_sum_12_Invalid),Attributes_Fields.InvalidMessage_total_spend_volatility_0t12(le.total_spend_volatility_0t12_Invalid),Attributes_Fields.InvalidMessage_total_spend_volatility_0t6(le.total_spend_volatility_0t6_Invalid),Attributes_Fields.InvalidMessage_total_spend_volatility_12t18(le.total_spend_volatility_12t18_Invalid),Attributes_Fields.InvalidMessage_total_spend_volatility_6t12(le.total_spend_volatility_6t12_Invalid),Attributes_Fields.InvalidMessage_mfgmat_paid_average_12(le.mfgmat_paid_average_12_Invalid),Attributes_Fields.InvalidMessage_mfgmat_paid_monthspastworst_24(le.mfgmat_paid_monthspastworst_24_Invalid),Attributes_Fields.InvalidMessage_mfgmat_paid_slope_0t12(le.mfgmat_paid_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_mfgmat_paid_slope_0t24(le.mfgmat_paid_slope_0t24_Invalid),Attributes_Fields.InvalidMessage_mfgmat_paid_slope_0t6(le.mfgmat_paid_slope_0t6_Invalid),Attributes_Fields.InvalidMessage_mfgmat_paid_volatility_0t12(le.mfgmat_paid_volatility_0t12_Invalid),Attributes_Fields.InvalidMessage_mfgmat_paid_volatility_0t6(le.mfgmat_paid_volatility_0t6_Invalid),Attributes_Fields.InvalidMessage_mfgmat_spend_monthspastleast_24(le.mfgmat_spend_monthspastleast_24_Invalid),Attributes_Fields.InvalidMessage_mfgmat_spend_monthspastmost_24(le.mfgmat_spend_monthspastmost_24_Invalid),Attributes_Fields.InvalidMessage_mfgmat_spend_slope_0t12(le.mfgmat_spend_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_mfgmat_spend_slope_0t24(le.mfgmat_spend_slope_0t24_Invalid),Attributes_Fields.InvalidMessage_mfgmat_spend_slope_0t6(le.mfgmat_spend_slope_0t6_Invalid),Attributes_Fields.InvalidMessage_mfgmat_spend_sum_12(le.mfgmat_spend_sum_12_Invalid),Attributes_Fields.InvalidMessage_mfgmat_spend_volatility_0t6(le.mfgmat_spend_volatility_0t6_Invalid),Attributes_Fields.InvalidMessage_mfgmat_spend_volatility_6t12(le.mfgmat_spend_volatility_6t12_Invalid),Attributes_Fields.InvalidMessage_ops_paid_average_12(le.ops_paid_average_12_Invalid),Attributes_Fields.InvalidMessage_ops_paid_monthspastworst_24(le.ops_paid_monthspastworst_24_Invalid),Attributes_Fields.InvalidMessage_ops_paid_slope_0t12(le.ops_paid_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_ops_paid_slope_0t24(le.ops_paid_slope_0t24_Invalid),Attributes_Fields.InvalidMessage_ops_paid_slope_0t6(le.ops_paid_slope_0t6_Invalid),Attributes_Fields.InvalidMessage_ops_paid_volatility_0t12(le.ops_paid_volatility_0t12_Invalid),Attributes_Fields.InvalidMessage_ops_paid_volatility_0t6(le.ops_paid_volatility_0t6_Invalid),Attributes_Fields.InvalidMessage_ops_spend_monthspastleast_24(le.ops_spend_monthspastleast_24_Invalid),Attributes_Fields.InvalidMessage_ops_spend_monthspastmost_24(le.ops_spend_monthspastmost_24_Invalid),Attributes_Fields.InvalidMessage_ops_spend_slope_0t12(le.ops_spend_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_ops_spend_slope_0t24(le.ops_spend_slope_0t24_Invalid),Attributes_Fields.InvalidMessage_ops_spend_slope_0t6(le.ops_spend_slope_0t6_Invalid),Attributes_Fields.InvalidMessage_fleet_paid_monthspastworst_24(le.fleet_paid_monthspastworst_24_Invalid),Attributes_Fields.InvalidMessage_fleet_paid_slope_0t12(le.fleet_paid_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_fleet_paid_slope_0t24(le.fleet_paid_slope_0t24_Invalid),Attributes_Fields.InvalidMessage_fleet_paid_slope_0t6(le.fleet_paid_slope_0t6_Invalid),Attributes_Fields.InvalidMessage_fleet_paid_volatility_0t12(le.fleet_paid_volatility_0t12_Invalid),Attributes_Fields.InvalidMessage_fleet_paid_volatility_0t6(le.fleet_paid_volatility_0t6_Invalid),Attributes_Fields.InvalidMessage_fleet_spend_slope_0t12(le.fleet_spend_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_fleet_spend_slope_0t24(le.fleet_spend_slope_0t24_Invalid),Attributes_Fields.InvalidMessage_fleet_spend_slope_0t6(le.fleet_spend_slope_0t6_Invalid),Attributes_Fields.InvalidMessage_carrier_paid_slope_0t12(le.carrier_paid_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_carrier_paid_slope_0t24(le.carrier_paid_slope_0t24_Invalid),Attributes_Fields.InvalidMessage_carrier_paid_slope_0t6(le.carrier_paid_slope_0t6_Invalid),Attributes_Fields.InvalidMessage_carrier_paid_volatility_0t12(le.carrier_paid_volatility_0t12_Invalid),Attributes_Fields.InvalidMessage_carrier_paid_volatility_0t6(le.carrier_paid_volatility_0t6_Invalid),Attributes_Fields.InvalidMessage_carrier_spend_slope_0t12(le.carrier_spend_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_carrier_spend_slope_0t24(le.carrier_spend_slope_0t24_Invalid),Attributes_Fields.InvalidMessage_carrier_spend_slope_0t6(le.carrier_spend_slope_0t6_Invalid),Attributes_Fields.InvalidMessage_carrier_spend_volatility_0t6(le.carrier_spend_volatility_0t6_Invalid),Attributes_Fields.InvalidMessage_carrier_spend_volatility_6t12(le.carrier_spend_volatility_6t12_Invalid),Attributes_Fields.InvalidMessage_bldgmats_paid_slope_0t12(le.bldgmats_paid_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_bldgmats_paid_slope_0t24(le.bldgmats_paid_slope_0t24_Invalid),Attributes_Fields.InvalidMessage_bldgmats_paid_slope_0t6(le.bldgmats_paid_slope_0t6_Invalid),Attributes_Fields.InvalidMessage_bldgmats_paid_volatility_0t12(le.bldgmats_paid_volatility_0t12_Invalid),Attributes_Fields.InvalidMessage_bldgmats_paid_volatility_0t6(le.bldgmats_paid_volatility_0t6_Invalid),Attributes_Fields.InvalidMessage_bldgmats_spend_slope_0t12(le.bldgmats_spend_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_bldgmats_spend_slope_0t24(le.bldgmats_spend_slope_0t24_Invalid),Attributes_Fields.InvalidMessage_bldgmats_spend_slope_0t6(le.bldgmats_spend_slope_0t6_Invalid),Attributes_Fields.InvalidMessage_bldgmats_spend_volatility_0t6(le.bldgmats_spend_volatility_0t6_Invalid),Attributes_Fields.InvalidMessage_bldgmats_spend_volatility_6t12(le.bldgmats_spend_volatility_6t12_Invalid),Attributes_Fields.InvalidMessage_top5_paid_slope_0t12(le.top5_paid_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_top5_paid_slope_0t24(le.top5_paid_slope_0t24_Invalid),Attributes_Fields.InvalidMessage_top5_paid_slope_0t6(le.top5_paid_slope_0t6_Invalid),Attributes_Fields.InvalidMessage_top5_paid_volatility_0t12(le.top5_paid_volatility_0t12_Invalid),Attributes_Fields.InvalidMessage_top5_paid_volatility_0t6(le.top5_paid_volatility_0t6_Invalid),Attributes_Fields.InvalidMessage_top5_spend_slope_0t12(le.top5_spend_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_top5_spend_slope_0t24(le.top5_spend_slope_0t24_Invalid),Attributes_Fields.InvalidMessage_top5_spend_slope_0t6(le.top5_spend_slope_0t6_Invalid),Attributes_Fields.InvalidMessage_top5_spend_volatility_0t6(le.top5_spend_volatility_0t6_Invalid),Attributes_Fields.InvalidMessage_top5_spend_volatility_6t12(le.top5_spend_volatility_6t12_Invalid),Attributes_Fields.InvalidMessage_total_numrel_slope_0t12(le.total_numrel_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_total_numrel_slope_0t24(le.total_numrel_slope_0t24_Invalid),Attributes_Fields.InvalidMessage_total_numrel_slope_0t6(le.total_numrel_slope_0t6_Invalid),Attributes_Fields.InvalidMessage_total_numrel_slope_6t12(le.total_numrel_slope_6t12_Invalid),Attributes_Fields.InvalidMessage_mfgmat_numrel_slope_0t12(le.mfgmat_numrel_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_mfgmat_numrel_slope_0t24(le.mfgmat_numrel_slope_0t24_Invalid),Attributes_Fields.InvalidMessage_mfgmat_numrel_slope_0t6(le.mfgmat_numrel_slope_0t6_Invalid),Attributes_Fields.InvalidMessage_mfgmat_numrel_slope_6t12(le.mfgmat_numrel_slope_6t12_Invalid),Attributes_Fields.InvalidMessage_ops_numrel_slope_0t12(le.ops_numrel_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_ops_numrel_slope_0t24(le.ops_numrel_slope_0t24_Invalid),Attributes_Fields.InvalidMessage_ops_numrel_slope_0t6(le.ops_numrel_slope_0t6_Invalid),Attributes_Fields.InvalidMessage_ops_numrel_slope_6t12(le.ops_numrel_slope_6t12_Invalid),Attributes_Fields.InvalidMessage_fleet_numrel_slope_0t12(le.fleet_numrel_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_fleet_numrel_slope_0t24(le.fleet_numrel_slope_0t24_Invalid),Attributes_Fields.InvalidMessage_fleet_numrel_slope_0t6(le.fleet_numrel_slope_0t6_Invalid),Attributes_Fields.InvalidMessage_fleet_numrel_slope_6t12(le.fleet_numrel_slope_6t12_Invalid),Attributes_Fields.InvalidMessage_carrier_numrel_slope_0t12(le.carrier_numrel_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_carrier_numrel_slope_0t24(le.carrier_numrel_slope_0t24_Invalid),Attributes_Fields.InvalidMessage_carrier_numrel_slope_0t6(le.carrier_numrel_slope_0t6_Invalid),Attributes_Fields.InvalidMessage_carrier_numrel_slope_6t12(le.carrier_numrel_slope_6t12_Invalid),Attributes_Fields.InvalidMessage_bldgmats_numrel_slope_0t12(le.bldgmats_numrel_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_bldgmats_numrel_slope_0t24(le.bldgmats_numrel_slope_0t24_Invalid),Attributes_Fields.InvalidMessage_bldgmats_numrel_slope_0t6(le.bldgmats_numrel_slope_0t6_Invalid),Attributes_Fields.InvalidMessage_bldgmats_numrel_slope_6t12(le.bldgmats_numrel_slope_6t12_Invalid),Attributes_Fields.InvalidMessage_bldgmats_numrel_var_0t12(le.bldgmats_numrel_var_0t12_Invalid),Attributes_Fields.InvalidMessage_bldgmats_numrel_var_12t24(le.bldgmats_numrel_var_12t24_Invalid),Attributes_Fields.InvalidMessage_total_percprov30_slope_0t12(le.total_percprov30_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_total_percprov30_slope_0t24(le.total_percprov30_slope_0t24_Invalid),Attributes_Fields.InvalidMessage_total_percprov30_slope_0t6(le.total_percprov30_slope_0t6_Invalid),Attributes_Fields.InvalidMessage_total_percprov30_slope_6t12(le.total_percprov30_slope_6t12_Invalid),Attributes_Fields.InvalidMessage_total_percprov60_slope_0t12(le.total_percprov60_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_total_percprov60_slope_0t24(le.total_percprov60_slope_0t24_Invalid),Attributes_Fields.InvalidMessage_total_percprov60_slope_0t6(le.total_percprov60_slope_0t6_Invalid),Attributes_Fields.InvalidMessage_total_percprov60_slope_6t12(le.total_percprov60_slope_6t12_Invalid),Attributes_Fields.InvalidMessage_total_percprov90_slope_0t24(le.total_percprov90_slope_0t24_Invalid),Attributes_Fields.InvalidMessage_total_percprov90_slope_0t6(le.total_percprov90_slope_0t6_Invalid),Attributes_Fields.InvalidMessage_total_percprov90_slope_6t12(le.total_percprov90_slope_6t12_Invalid),Attributes_Fields.InvalidMessage_mfgmat_percprov30_slope_0t12(le.mfgmat_percprov30_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_mfgmat_percprov30_slope_6t12(le.mfgmat_percprov30_slope_6t12_Invalid),Attributes_Fields.InvalidMessage_mfgmat_percprov60_slope_0t12(le.mfgmat_percprov60_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_mfgmat_percprov60_slope_6t12(le.mfgmat_percprov60_slope_6t12_Invalid),Attributes_Fields.InvalidMessage_mfgmat_percprov90_slope_0t24(le.mfgmat_percprov90_slope_0t24_Invalid),Attributes_Fields.InvalidMessage_mfgmat_percprov90_slope_0t6(le.mfgmat_percprov90_slope_0t6_Invalid),Attributes_Fields.InvalidMessage_mfgmat_percprov90_slope_6t12(le.mfgmat_percprov90_slope_6t12_Invalid),Attributes_Fields.InvalidMessage_ops_percprov30_slope_0t12(le.ops_percprov30_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_ops_percprov30_slope_6t12(le.ops_percprov30_slope_6t12_Invalid),Attributes_Fields.InvalidMessage_ops_percprov60_slope_0t12(le.ops_percprov60_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_ops_percprov60_slope_6t12(le.ops_percprov60_slope_6t12_Invalid),Attributes_Fields.InvalidMessage_ops_percprov90_slope_0t24(le.ops_percprov90_slope_0t24_Invalid),Attributes_Fields.InvalidMessage_ops_percprov90_slope_0t6(le.ops_percprov90_slope_0t6_Invalid),Attributes_Fields.InvalidMessage_ops_percprov90_slope_6t12(le.ops_percprov90_slope_6t12_Invalid),Attributes_Fields.InvalidMessage_fleet_percprov30_slope_0t12(le.fleet_percprov30_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_fleet_percprov30_slope_6t12(le.fleet_percprov30_slope_6t12_Invalid),Attributes_Fields.InvalidMessage_fleet_percprov60_slope_0t12(le.fleet_percprov60_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_fleet_percprov60_slope_6t12(le.fleet_percprov60_slope_6t12_Invalid),Attributes_Fields.InvalidMessage_fleet_percprov90_slope_0t24(le.fleet_percprov90_slope_0t24_Invalid),Attributes_Fields.InvalidMessage_fleet_percprov90_slope_0t6(le.fleet_percprov90_slope_0t6_Invalid),Attributes_Fields.InvalidMessage_fleet_percprov90_slope_6t12(le.fleet_percprov90_slope_6t12_Invalid),Attributes_Fields.InvalidMessage_carrier_percprov30_slope_0t12(le.carrier_percprov30_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_carrier_percprov30_slope_6t12(le.carrier_percprov30_slope_6t12_Invalid),Attributes_Fields.InvalidMessage_carrier_percprov60_slope_0t12(le.carrier_percprov60_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_carrier_percprov60_slope_6t12(le.carrier_percprov60_slope_6t12_Invalid),Attributes_Fields.InvalidMessage_carrier_percprov90_slope_0t24(le.carrier_percprov90_slope_0t24_Invalid),Attributes_Fields.InvalidMessage_carrier_percprov90_slope_0t6(le.carrier_percprov90_slope_0t6_Invalid),Attributes_Fields.InvalidMessage_carrier_percprov90_slope_6t12(le.carrier_percprov90_slope_6t12_Invalid),Attributes_Fields.InvalidMessage_bldgmats_percprov30_slope_0t12(le.bldgmats_percprov30_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_bldgmats_percprov30_slope_6t12(le.bldgmats_percprov30_slope_6t12_Invalid),Attributes_Fields.InvalidMessage_bldgmats_percprov60_slope_0t12(le.bldgmats_percprov60_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_bldgmats_percprov60_slope_6t12(le.bldgmats_percprov60_slope_6t12_Invalid),Attributes_Fields.InvalidMessage_bldgmats_percprov90_slope_0t24(le.bldgmats_percprov90_slope_0t24_Invalid),Attributes_Fields.InvalidMessage_bldgmats_percprov90_slope_0t6(le.bldgmats_percprov90_slope_0t6_Invalid),Attributes_Fields.InvalidMessage_bldgmats_percprov90_slope_6t12(le.bldgmats_percprov90_slope_6t12_Invalid),Attributes_Fields.InvalidMessage_top5_percprov30_slope_0t12(le.top5_percprov30_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_top5_percprov30_slope_6t12(le.top5_percprov30_slope_6t12_Invalid),Attributes_Fields.InvalidMessage_top5_percprov60_slope_0t12(le.top5_percprov60_slope_0t12_Invalid),Attributes_Fields.InvalidMessage_top5_percprov60_slope_6t12(le.top5_percprov60_slope_6t12_Invalid),Attributes_Fields.InvalidMessage_top5_percprov90_slope_0t24(le.top5_percprov90_slope_0t24_Invalid),Attributes_Fields.InvalidMessage_top5_percprov90_slope_0t6(le.top5_percprov90_slope_0t6_Invalid),Attributes_Fields.InvalidMessage_top5_percprov90_slope_6t12(le.top5_percprov90_slope_6t12_Invalid),Attributes_Fields.InvalidMessage_top5_percprovoutstanding_adjustedslope_0t12(le.top5_percprovoutstanding_adjustedslope_0t12_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.ultimate_linkid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cortera_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpr_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cpr_segment_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dbt_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.avg_bal_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.air_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fuel_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.leasing_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ltl_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rail_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.tl_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.transvc_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.transup_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bst_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dg_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.electrical_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.hvac_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.other_b_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.plumbing_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rs_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.wp_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.chemical_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.electronic_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.metal_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.other_m_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.packaging_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pvf_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.plastic_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.textile_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bs_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ce_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.hardware_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ie_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.is_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.it_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mls_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.os_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pp_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sis_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.apparel_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.beverages_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.constr_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.consulting_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fs_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fp_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.insurance_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ls_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.oil_gas_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.utilities_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.other_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.advt_spend_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.air_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fuel_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.leasing_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ltl_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.rail_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tl_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.transvc_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.transup_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.bst_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.dg_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.electrical_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.hvac_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.other_b_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.plumbing_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.rs_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.wp_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.chemical_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.electronic_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.metal_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.other_m_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.packaging_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.pvf_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.plastic_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.textile_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.bs_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ce_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.hardware_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ie_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.is_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.it_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mls_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.os_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.pp_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.sis_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.apparel_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.beverages_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.constr_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.consulting_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fs_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fp_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.insurance_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ls_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.oil_gas_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.utilities_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.other_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.advt_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.top5_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.shipping_y1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.shipping_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.materials_y1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.materials_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.operations_y1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.operations_growth_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_paid_average_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_paid_monthspastworst_24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_paid_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_paid_slope_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_paid_slope_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_paid_slope_6t18_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_paid_volatility_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_paid_volatility_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_paid_volatility_12t18_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_paid_volatility_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_spend_monthspastleast_24_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.total_spend_monthspastmost_24_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.total_spend_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_spend_slope_0t24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_spend_slope_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_spend_slope_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_spend_sum_12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_spend_volatility_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_spend_volatility_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_spend_volatility_12t18_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_spend_volatility_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mfgmat_paid_average_12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mfgmat_paid_monthspastworst_24_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mfgmat_paid_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mfgmat_paid_slope_0t24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mfgmat_paid_slope_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mfgmat_paid_volatility_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mfgmat_paid_volatility_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mfgmat_spend_monthspastleast_24_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mfgmat_spend_monthspastmost_24_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mfgmat_spend_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mfgmat_spend_slope_0t24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mfgmat_spend_slope_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mfgmat_spend_sum_12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mfgmat_spend_volatility_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mfgmat_spend_volatility_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ops_paid_average_12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ops_paid_monthspastworst_24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ops_paid_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ops_paid_slope_0t24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ops_paid_slope_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ops_paid_volatility_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ops_paid_volatility_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ops_spend_monthspastleast_24_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ops_spend_monthspastmost_24_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ops_spend_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ops_spend_slope_0t24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ops_spend_slope_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fleet_paid_monthspastworst_24_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fleet_paid_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fleet_paid_slope_0t24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fleet_paid_slope_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fleet_paid_volatility_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fleet_paid_volatility_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fleet_spend_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fleet_spend_slope_0t24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fleet_spend_slope_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.carrier_paid_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.carrier_paid_slope_0t24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.carrier_paid_slope_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.carrier_paid_volatility_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.carrier_paid_volatility_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.carrier_spend_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.carrier_spend_slope_0t24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.carrier_spend_slope_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.carrier_spend_volatility_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.carrier_spend_volatility_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.bldgmats_paid_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.bldgmats_paid_slope_0t24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.bldgmats_paid_slope_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.bldgmats_paid_volatility_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.bldgmats_paid_volatility_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.bldgmats_spend_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.bldgmats_spend_slope_0t24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.bldgmats_spend_slope_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.bldgmats_spend_volatility_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.bldgmats_spend_volatility_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.top5_paid_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.top5_paid_slope_0t24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.top5_paid_slope_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.top5_paid_volatility_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.top5_paid_volatility_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.top5_spend_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.top5_spend_slope_0t24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.top5_spend_slope_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.top5_spend_volatility_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.top5_spend_volatility_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_numrel_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_numrel_slope_0t24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_numrel_slope_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_numrel_slope_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mfgmat_numrel_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mfgmat_numrel_slope_0t24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mfgmat_numrel_slope_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mfgmat_numrel_slope_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ops_numrel_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ops_numrel_slope_0t24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ops_numrel_slope_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ops_numrel_slope_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fleet_numrel_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fleet_numrel_slope_0t24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fleet_numrel_slope_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fleet_numrel_slope_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.carrier_numrel_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.carrier_numrel_slope_0t24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.carrier_numrel_slope_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.carrier_numrel_slope_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.bldgmats_numrel_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.bldgmats_numrel_slope_0t24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.bldgmats_numrel_slope_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.bldgmats_numrel_slope_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.bldgmats_numrel_var_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.bldgmats_numrel_var_12t24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_percprov30_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_percprov30_slope_0t24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_percprov30_slope_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_percprov30_slope_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_percprov60_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_percprov60_slope_0t24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_percprov60_slope_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_percprov60_slope_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_percprov90_slope_0t24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_percprov90_slope_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_percprov90_slope_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mfgmat_percprov30_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mfgmat_percprov30_slope_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mfgmat_percprov60_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mfgmat_percprov60_slope_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mfgmat_percprov90_slope_0t24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mfgmat_percprov90_slope_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mfgmat_percprov90_slope_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ops_percprov30_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ops_percprov30_slope_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ops_percprov60_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ops_percprov60_slope_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ops_percprov90_slope_0t24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ops_percprov90_slope_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ops_percprov90_slope_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fleet_percprov30_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fleet_percprov30_slope_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fleet_percprov60_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fleet_percprov60_slope_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fleet_percprov90_slope_0t24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fleet_percprov90_slope_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fleet_percprov90_slope_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.carrier_percprov30_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.carrier_percprov30_slope_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.carrier_percprov60_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.carrier_percprov60_slope_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.carrier_percprov90_slope_0t24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.carrier_percprov90_slope_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.carrier_percprov90_slope_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.bldgmats_percprov30_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.bldgmats_percprov30_slope_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.bldgmats_percprov60_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.bldgmats_percprov60_slope_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.bldgmats_percprov90_slope_0t24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.bldgmats_percprov90_slope_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.bldgmats_percprov90_slope_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.top5_percprov30_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.top5_percprov30_slope_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.top5_percprov60_slope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.top5_percprov60_slope_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.top5_percprov90_slope_0t24_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.top5_percprov90_slope_0t6_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.top5_percprov90_slope_6t12_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.top5_percprovoutstanding_adjustedslope_0t12_Invalid,'ALLOW','LENGTHS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'ultimate_linkid','cortera_score','cpr_score','cpr_segment','dbt','avg_bal','air_spend','fuel_spend','leasing_spend','ltl_spend','rail_spend','tl_spend','transvc_spend','transup_spend','bst_spend','dg_spend','electrical_spend','hvac_spend','other_b_spend','plumbing_spend','rs_spend','wp_spend','chemical_spend','electronic_spend','metal_spend','other_m_spend','packaging_spend','pvf_spend','plastic_spend','textile_spend','bs_spend','ce_spend','hardware_spend','ie_spend','is_spend','it_spend','mls_spend','os_spend','pp_spend','sis_spend','apparel_spend','beverages_spend','constr_spend','consulting_spend','fs_spend','fp_spend','insurance_spend','ls_spend','oil_gas_spend','utilities_spend','other_spend','advt_spend','air_growth','fuel_growth','leasing_growth','ltl_growth','rail_growth','tl_growth','transvc_growth','transup_growth','bst_growth','dg_growth','electrical_growth','hvac_growth','other_b_growth','plumbing_growth','rs_growth','wp_growth','chemical_growth','electronic_growth','metal_growth','other_m_growth','packaging_growth','pvf_growth','plastic_growth','textile_growth','bs_growth','ce_growth','hardware_growth','ie_growth','is_growth','it_growth','mls_growth','os_growth','pp_growth','sis_growth','apparel_growth','beverages_growth','constr_growth','consulting_growth','fs_growth','fp_growth','insurance_growth','ls_growth','oil_gas_growth','utilities_growth','other_growth','advt_growth','top5_growth','shipping_y1','shipping_growth','materials_y1','materials_growth','operations_y1','operations_growth','total_paid_average_0t12','total_paid_monthspastworst_24','total_paid_slope_0t12','total_paid_slope_0t6','total_paid_slope_6t12','total_paid_slope_6t18','total_paid_volatility_0t12','total_paid_volatility_0t6','total_paid_volatility_12t18','total_paid_volatility_6t12','total_spend_monthspastleast_24','total_spend_monthspastmost_24','total_spend_slope_0t12','total_spend_slope_0t24','total_spend_slope_0t6','total_spend_slope_6t12','total_spend_sum_12','total_spend_volatility_0t12','total_spend_volatility_0t6','total_spend_volatility_12t18','total_spend_volatility_6t12','mfgmat_paid_average_12','mfgmat_paid_monthspastworst_24','mfgmat_paid_slope_0t12','mfgmat_paid_slope_0t24','mfgmat_paid_slope_0t6','mfgmat_paid_volatility_0t12','mfgmat_paid_volatility_0t6','mfgmat_spend_monthspastleast_24','mfgmat_spend_monthspastmost_24','mfgmat_spend_slope_0t12','mfgmat_spend_slope_0t24','mfgmat_spend_slope_0t6','mfgmat_spend_sum_12','mfgmat_spend_volatility_0t6','mfgmat_spend_volatility_6t12','ops_paid_average_12','ops_paid_monthspastworst_24','ops_paid_slope_0t12','ops_paid_slope_0t24','ops_paid_slope_0t6','ops_paid_volatility_0t12','ops_paid_volatility_0t6','ops_spend_monthspastleast_24','ops_spend_monthspastmost_24','ops_spend_slope_0t12','ops_spend_slope_0t24','ops_spend_slope_0t6','fleet_paid_monthspastworst_24','fleet_paid_slope_0t12','fleet_paid_slope_0t24','fleet_paid_slope_0t6','fleet_paid_volatility_0t12','fleet_paid_volatility_0t6','fleet_spend_slope_0t12','fleet_spend_slope_0t24','fleet_spend_slope_0t6','carrier_paid_slope_0t12','carrier_paid_slope_0t24','carrier_paid_slope_0t6','carrier_paid_volatility_0t12','carrier_paid_volatility_0t6','carrier_spend_slope_0t12','carrier_spend_slope_0t24','carrier_spend_slope_0t6','carrier_spend_volatility_0t6','carrier_spend_volatility_6t12','bldgmats_paid_slope_0t12','bldgmats_paid_slope_0t24','bldgmats_paid_slope_0t6','bldgmats_paid_volatility_0t12','bldgmats_paid_volatility_0t6','bldgmats_spend_slope_0t12','bldgmats_spend_slope_0t24','bldgmats_spend_slope_0t6','bldgmats_spend_volatility_0t6','bldgmats_spend_volatility_6t12','top5_paid_slope_0t12','top5_paid_slope_0t24','top5_paid_slope_0t6','top5_paid_volatility_0t12','top5_paid_volatility_0t6','top5_spend_slope_0t12','top5_spend_slope_0t24','top5_spend_slope_0t6','top5_spend_volatility_0t6','top5_spend_volatility_6t12','total_numrel_slope_0t12','total_numrel_slope_0t24','total_numrel_slope_0t6','total_numrel_slope_6t12','mfgmat_numrel_slope_0t12','mfgmat_numrel_slope_0t24','mfgmat_numrel_slope_0t6','mfgmat_numrel_slope_6t12','ops_numrel_slope_0t12','ops_numrel_slope_0t24','ops_numrel_slope_0t6','ops_numrel_slope_6t12','fleet_numrel_slope_0t12','fleet_numrel_slope_0t24','fleet_numrel_slope_0t6','fleet_numrel_slope_6t12','carrier_numrel_slope_0t12','carrier_numrel_slope_0t24','carrier_numrel_slope_0t6','carrier_numrel_slope_6t12','bldgmats_numrel_slope_0t12','bldgmats_numrel_slope_0t24','bldgmats_numrel_slope_0t6','bldgmats_numrel_slope_6t12','bldgmats_numrel_var_0t12','bldgmats_numrel_var_12t24','total_percprov30_slope_0t12','total_percprov30_slope_0t24','total_percprov30_slope_0t6','total_percprov30_slope_6t12','total_percprov60_slope_0t12','total_percprov60_slope_0t24','total_percprov60_slope_0t6','total_percprov60_slope_6t12','total_percprov90_slope_0t24','total_percprov90_slope_0t6','total_percprov90_slope_6t12','mfgmat_percprov30_slope_0t12','mfgmat_percprov30_slope_6t12','mfgmat_percprov60_slope_0t12','mfgmat_percprov60_slope_6t12','mfgmat_percprov90_slope_0t24','mfgmat_percprov90_slope_0t6','mfgmat_percprov90_slope_6t12','ops_percprov30_slope_0t12','ops_percprov30_slope_6t12','ops_percprov60_slope_0t12','ops_percprov60_slope_6t12','ops_percprov90_slope_0t24','ops_percprov90_slope_0t6','ops_percprov90_slope_6t12','fleet_percprov30_slope_0t12','fleet_percprov30_slope_6t12','fleet_percprov60_slope_0t12','fleet_percprov60_slope_6t12','fleet_percprov90_slope_0t24','fleet_percprov90_slope_0t6','fleet_percprov90_slope_6t12','carrier_percprov30_slope_0t12','carrier_percprov30_slope_6t12','carrier_percprov60_slope_0t12','carrier_percprov60_slope_6t12','carrier_percprov90_slope_0t24','carrier_percprov90_slope_0t6','carrier_percprov90_slope_6t12','bldgmats_percprov30_slope_0t12','bldgmats_percprov30_slope_6t12','bldgmats_percprov60_slope_0t12','bldgmats_percprov60_slope_6t12','bldgmats_percprov90_slope_0t24','bldgmats_percprov90_slope_0t6','bldgmats_percprov90_slope_6t12','top5_percprov30_slope_0t12','top5_percprov30_slope_6t12','top5_percprov60_slope_0t12','top5_percprov60_slope_6t12','top5_percprov90_slope_0t24','top5_percprov90_slope_0t6','top5_percprov90_slope_6t12','top5_percprovoutstanding_adjustedslope_0t12','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Number','Number','Number','Number','Ratio','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Number','Ratio','Number','Ratio','Number','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Number','Number','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Number','Ratio','Ratio','Ratio','Ratio','Ratio','Number','Number','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Number','Number','Ratio','Ratio','Ratio','Number','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.ultimate_linkid,(SALT311.StrType)le.cortera_score,(SALT311.StrType)le.cpr_score,(SALT311.StrType)le.cpr_segment,(SALT311.StrType)le.dbt,(SALT311.StrType)le.avg_bal,(SALT311.StrType)le.air_spend,(SALT311.StrType)le.fuel_spend,(SALT311.StrType)le.leasing_spend,(SALT311.StrType)le.ltl_spend,(SALT311.StrType)le.rail_spend,(SALT311.StrType)le.tl_spend,(SALT311.StrType)le.transvc_spend,(SALT311.StrType)le.transup_spend,(SALT311.StrType)le.bst_spend,(SALT311.StrType)le.dg_spend,(SALT311.StrType)le.electrical_spend,(SALT311.StrType)le.hvac_spend,(SALT311.StrType)le.other_b_spend,(SALT311.StrType)le.plumbing_spend,(SALT311.StrType)le.rs_spend,(SALT311.StrType)le.wp_spend,(SALT311.StrType)le.chemical_spend,(SALT311.StrType)le.electronic_spend,(SALT311.StrType)le.metal_spend,(SALT311.StrType)le.other_m_spend,(SALT311.StrType)le.packaging_spend,(SALT311.StrType)le.pvf_spend,(SALT311.StrType)le.plastic_spend,(SALT311.StrType)le.textile_spend,(SALT311.StrType)le.bs_spend,(SALT311.StrType)le.ce_spend,(SALT311.StrType)le.hardware_spend,(SALT311.StrType)le.ie_spend,(SALT311.StrType)le.is_spend,(SALT311.StrType)le.it_spend,(SALT311.StrType)le.mls_spend,(SALT311.StrType)le.os_spend,(SALT311.StrType)le.pp_spend,(SALT311.StrType)le.sis_spend,(SALT311.StrType)le.apparel_spend,(SALT311.StrType)le.beverages_spend,(SALT311.StrType)le.constr_spend,(SALT311.StrType)le.consulting_spend,(SALT311.StrType)le.fs_spend,(SALT311.StrType)le.fp_spend,(SALT311.StrType)le.insurance_spend,(SALT311.StrType)le.ls_spend,(SALT311.StrType)le.oil_gas_spend,(SALT311.StrType)le.utilities_spend,(SALT311.StrType)le.other_spend,(SALT311.StrType)le.advt_spend,(SALT311.StrType)le.air_growth,(SALT311.StrType)le.fuel_growth,(SALT311.StrType)le.leasing_growth,(SALT311.StrType)le.ltl_growth,(SALT311.StrType)le.rail_growth,(SALT311.StrType)le.tl_growth,(SALT311.StrType)le.transvc_growth,(SALT311.StrType)le.transup_growth,(SALT311.StrType)le.bst_growth,(SALT311.StrType)le.dg_growth,(SALT311.StrType)le.electrical_growth,(SALT311.StrType)le.hvac_growth,(SALT311.StrType)le.other_b_growth,(SALT311.StrType)le.plumbing_growth,(SALT311.StrType)le.rs_growth,(SALT311.StrType)le.wp_growth,(SALT311.StrType)le.chemical_growth,(SALT311.StrType)le.electronic_growth,(SALT311.StrType)le.metal_growth,(SALT311.StrType)le.other_m_growth,(SALT311.StrType)le.packaging_growth,(SALT311.StrType)le.pvf_growth,(SALT311.StrType)le.plastic_growth,(SALT311.StrType)le.textile_growth,(SALT311.StrType)le.bs_growth,(SALT311.StrType)le.ce_growth,(SALT311.StrType)le.hardware_growth,(SALT311.StrType)le.ie_growth,(SALT311.StrType)le.is_growth,(SALT311.StrType)le.it_growth,(SALT311.StrType)le.mls_growth,(SALT311.StrType)le.os_growth,(SALT311.StrType)le.pp_growth,(SALT311.StrType)le.sis_growth,(SALT311.StrType)le.apparel_growth,(SALT311.StrType)le.beverages_growth,(SALT311.StrType)le.constr_growth,(SALT311.StrType)le.consulting_growth,(SALT311.StrType)le.fs_growth,(SALT311.StrType)le.fp_growth,(SALT311.StrType)le.insurance_growth,(SALT311.StrType)le.ls_growth,(SALT311.StrType)le.oil_gas_growth,(SALT311.StrType)le.utilities_growth,(SALT311.StrType)le.other_growth,(SALT311.StrType)le.advt_growth,(SALT311.StrType)le.top5_growth,(SALT311.StrType)le.shipping_y1,(SALT311.StrType)le.shipping_growth,(SALT311.StrType)le.materials_y1,(SALT311.StrType)le.materials_growth,(SALT311.StrType)le.operations_y1,(SALT311.StrType)le.operations_growth,(SALT311.StrType)le.total_paid_average_0t12,(SALT311.StrType)le.total_paid_monthspastworst_24,(SALT311.StrType)le.total_paid_slope_0t12,(SALT311.StrType)le.total_paid_slope_0t6,(SALT311.StrType)le.total_paid_slope_6t12,(SALT311.StrType)le.total_paid_slope_6t18,(SALT311.StrType)le.total_paid_volatility_0t12,(SALT311.StrType)le.total_paid_volatility_0t6,(SALT311.StrType)le.total_paid_volatility_12t18,(SALT311.StrType)le.total_paid_volatility_6t12,(SALT311.StrType)le.total_spend_monthspastleast_24,(SALT311.StrType)le.total_spend_monthspastmost_24,(SALT311.StrType)le.total_spend_slope_0t12,(SALT311.StrType)le.total_spend_slope_0t24,(SALT311.StrType)le.total_spend_slope_0t6,(SALT311.StrType)le.total_spend_slope_6t12,(SALT311.StrType)le.total_spend_sum_12,(SALT311.StrType)le.total_spend_volatility_0t12,(SALT311.StrType)le.total_spend_volatility_0t6,(SALT311.StrType)le.total_spend_volatility_12t18,(SALT311.StrType)le.total_spend_volatility_6t12,(SALT311.StrType)le.mfgmat_paid_average_12,(SALT311.StrType)le.mfgmat_paid_monthspastworst_24,(SALT311.StrType)le.mfgmat_paid_slope_0t12,(SALT311.StrType)le.mfgmat_paid_slope_0t24,(SALT311.StrType)le.mfgmat_paid_slope_0t6,(SALT311.StrType)le.mfgmat_paid_volatility_0t12,(SALT311.StrType)le.mfgmat_paid_volatility_0t6,(SALT311.StrType)le.mfgmat_spend_monthspastleast_24,(SALT311.StrType)le.mfgmat_spend_monthspastmost_24,(SALT311.StrType)le.mfgmat_spend_slope_0t12,(SALT311.StrType)le.mfgmat_spend_slope_0t24,(SALT311.StrType)le.mfgmat_spend_slope_0t6,(SALT311.StrType)le.mfgmat_spend_sum_12,(SALT311.StrType)le.mfgmat_spend_volatility_0t6,(SALT311.StrType)le.mfgmat_spend_volatility_6t12,(SALT311.StrType)le.ops_paid_average_12,(SALT311.StrType)le.ops_paid_monthspastworst_24,(SALT311.StrType)le.ops_paid_slope_0t12,(SALT311.StrType)le.ops_paid_slope_0t24,(SALT311.StrType)le.ops_paid_slope_0t6,(SALT311.StrType)le.ops_paid_volatility_0t12,(SALT311.StrType)le.ops_paid_volatility_0t6,(SALT311.StrType)le.ops_spend_monthspastleast_24,(SALT311.StrType)le.ops_spend_monthspastmost_24,(SALT311.StrType)le.ops_spend_slope_0t12,(SALT311.StrType)le.ops_spend_slope_0t24,(SALT311.StrType)le.ops_spend_slope_0t6,(SALT311.StrType)le.fleet_paid_monthspastworst_24,(SALT311.StrType)le.fleet_paid_slope_0t12,(SALT311.StrType)le.fleet_paid_slope_0t24,(SALT311.StrType)le.fleet_paid_slope_0t6,(SALT311.StrType)le.fleet_paid_volatility_0t12,(SALT311.StrType)le.fleet_paid_volatility_0t6,(SALT311.StrType)le.fleet_spend_slope_0t12,(SALT311.StrType)le.fleet_spend_slope_0t24,(SALT311.StrType)le.fleet_spend_slope_0t6,(SALT311.StrType)le.carrier_paid_slope_0t12,(SALT311.StrType)le.carrier_paid_slope_0t24,(SALT311.StrType)le.carrier_paid_slope_0t6,(SALT311.StrType)le.carrier_paid_volatility_0t12,(SALT311.StrType)le.carrier_paid_volatility_0t6,(SALT311.StrType)le.carrier_spend_slope_0t12,(SALT311.StrType)le.carrier_spend_slope_0t24,(SALT311.StrType)le.carrier_spend_slope_0t6,(SALT311.StrType)le.carrier_spend_volatility_0t6,(SALT311.StrType)le.carrier_spend_volatility_6t12,(SALT311.StrType)le.bldgmats_paid_slope_0t12,(SALT311.StrType)le.bldgmats_paid_slope_0t24,(SALT311.StrType)le.bldgmats_paid_slope_0t6,(SALT311.StrType)le.bldgmats_paid_volatility_0t12,(SALT311.StrType)le.bldgmats_paid_volatility_0t6,(SALT311.StrType)le.bldgmats_spend_slope_0t12,(SALT311.StrType)le.bldgmats_spend_slope_0t24,(SALT311.StrType)le.bldgmats_spend_slope_0t6,(SALT311.StrType)le.bldgmats_spend_volatility_0t6,(SALT311.StrType)le.bldgmats_spend_volatility_6t12,(SALT311.StrType)le.top5_paid_slope_0t12,(SALT311.StrType)le.top5_paid_slope_0t24,(SALT311.StrType)le.top5_paid_slope_0t6,(SALT311.StrType)le.top5_paid_volatility_0t12,(SALT311.StrType)le.top5_paid_volatility_0t6,(SALT311.StrType)le.top5_spend_slope_0t12,(SALT311.StrType)le.top5_spend_slope_0t24,(SALT311.StrType)le.top5_spend_slope_0t6,(SALT311.StrType)le.top5_spend_volatility_0t6,(SALT311.StrType)le.top5_spend_volatility_6t12,(SALT311.StrType)le.total_numrel_slope_0t12,(SALT311.StrType)le.total_numrel_slope_0t24,(SALT311.StrType)le.total_numrel_slope_0t6,(SALT311.StrType)le.total_numrel_slope_6t12,(SALT311.StrType)le.mfgmat_numrel_slope_0t12,(SALT311.StrType)le.mfgmat_numrel_slope_0t24,(SALT311.StrType)le.mfgmat_numrel_slope_0t6,(SALT311.StrType)le.mfgmat_numrel_slope_6t12,(SALT311.StrType)le.ops_numrel_slope_0t12,(SALT311.StrType)le.ops_numrel_slope_0t24,(SALT311.StrType)le.ops_numrel_slope_0t6,(SALT311.StrType)le.ops_numrel_slope_6t12,(SALT311.StrType)le.fleet_numrel_slope_0t12,(SALT311.StrType)le.fleet_numrel_slope_0t24,(SALT311.StrType)le.fleet_numrel_slope_0t6,(SALT311.StrType)le.fleet_numrel_slope_6t12,(SALT311.StrType)le.carrier_numrel_slope_0t12,(SALT311.StrType)le.carrier_numrel_slope_0t24,(SALT311.StrType)le.carrier_numrel_slope_0t6,(SALT311.StrType)le.carrier_numrel_slope_6t12,(SALT311.StrType)le.bldgmats_numrel_slope_0t12,(SALT311.StrType)le.bldgmats_numrel_slope_0t24,(SALT311.StrType)le.bldgmats_numrel_slope_0t6,(SALT311.StrType)le.bldgmats_numrel_slope_6t12,(SALT311.StrType)le.bldgmats_numrel_var_0t12,(SALT311.StrType)le.bldgmats_numrel_var_12t24,(SALT311.StrType)le.total_percprov30_slope_0t12,(SALT311.StrType)le.total_percprov30_slope_0t24,(SALT311.StrType)le.total_percprov30_slope_0t6,(SALT311.StrType)le.total_percprov30_slope_6t12,(SALT311.StrType)le.total_percprov60_slope_0t12,(SALT311.StrType)le.total_percprov60_slope_0t24,(SALT311.StrType)le.total_percprov60_slope_0t6,(SALT311.StrType)le.total_percprov60_slope_6t12,(SALT311.StrType)le.total_percprov90_slope_0t24,(SALT311.StrType)le.total_percprov90_slope_0t6,(SALT311.StrType)le.total_percprov90_slope_6t12,(SALT311.StrType)le.mfgmat_percprov30_slope_0t12,(SALT311.StrType)le.mfgmat_percprov30_slope_6t12,(SALT311.StrType)le.mfgmat_percprov60_slope_0t12,(SALT311.StrType)le.mfgmat_percprov60_slope_6t12,(SALT311.StrType)le.mfgmat_percprov90_slope_0t24,(SALT311.StrType)le.mfgmat_percprov90_slope_0t6,(SALT311.StrType)le.mfgmat_percprov90_slope_6t12,(SALT311.StrType)le.ops_percprov30_slope_0t12,(SALT311.StrType)le.ops_percprov30_slope_6t12,(SALT311.StrType)le.ops_percprov60_slope_0t12,(SALT311.StrType)le.ops_percprov60_slope_6t12,(SALT311.StrType)le.ops_percprov90_slope_0t24,(SALT311.StrType)le.ops_percprov90_slope_0t6,(SALT311.StrType)le.ops_percprov90_slope_6t12,(SALT311.StrType)le.fleet_percprov30_slope_0t12,(SALT311.StrType)le.fleet_percprov30_slope_6t12,(SALT311.StrType)le.fleet_percprov60_slope_0t12,(SALT311.StrType)le.fleet_percprov60_slope_6t12,(SALT311.StrType)le.fleet_percprov90_slope_0t24,(SALT311.StrType)le.fleet_percprov90_slope_0t6,(SALT311.StrType)le.fleet_percprov90_slope_6t12,(SALT311.StrType)le.carrier_percprov30_slope_0t12,(SALT311.StrType)le.carrier_percprov30_slope_6t12,(SALT311.StrType)le.carrier_percprov60_slope_0t12,(SALT311.StrType)le.carrier_percprov60_slope_6t12,(SALT311.StrType)le.carrier_percprov90_slope_0t24,(SALT311.StrType)le.carrier_percprov90_slope_0t6,(SALT311.StrType)le.carrier_percprov90_slope_6t12,(SALT311.StrType)le.bldgmats_percprov30_slope_0t12,(SALT311.StrType)le.bldgmats_percprov30_slope_6t12,(SALT311.StrType)le.bldgmats_percprov60_slope_0t12,(SALT311.StrType)le.bldgmats_percprov60_slope_6t12,(SALT311.StrType)le.bldgmats_percprov90_slope_0t24,(SALT311.StrType)le.bldgmats_percprov90_slope_0t6,(SALT311.StrType)le.bldgmats_percprov90_slope_6t12,(SALT311.StrType)le.top5_percprov30_slope_0t12,(SALT311.StrType)le.top5_percprov30_slope_6t12,(SALT311.StrType)le.top5_percprov60_slope_0t12,(SALT311.StrType)le.top5_percprov60_slope_6t12,(SALT311.StrType)le.top5_percprov90_slope_0t24,(SALT311.StrType)le.top5_percprov90_slope_0t6,(SALT311.StrType)le.top5_percprov90_slope_6t12,(SALT311.StrType)le.top5_percprovoutstanding_adjustedslope_0t12,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,272,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Attributes_Layout_Cortera) prevDS = DATASET([], Attributes_Layout_Cortera), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'ultimate_linkid:Number:ALLOW'
          ,'cortera_score:Number:ALLOW'
          ,'cpr_score:Number:ALLOW'
          ,'cpr_segment:Number:ALLOW'
          ,'dbt:Ratio:ALLOW','dbt:Ratio:LENGTHS'
          ,'avg_bal:Number:ALLOW'
          ,'air_spend:Number:ALLOW'
          ,'fuel_spend:Number:ALLOW'
          ,'leasing_spend:Number:ALLOW'
          ,'ltl_spend:Number:ALLOW'
          ,'rail_spend:Number:ALLOW'
          ,'tl_spend:Number:ALLOW'
          ,'transvc_spend:Number:ALLOW'
          ,'transup_spend:Number:ALLOW'
          ,'bst_spend:Number:ALLOW'
          ,'dg_spend:Number:ALLOW'
          ,'electrical_spend:Number:ALLOW'
          ,'hvac_spend:Number:ALLOW'
          ,'other_b_spend:Number:ALLOW'
          ,'plumbing_spend:Number:ALLOW'
          ,'rs_spend:Number:ALLOW'
          ,'wp_spend:Number:ALLOW'
          ,'chemical_spend:Number:ALLOW'
          ,'electronic_spend:Number:ALLOW'
          ,'metal_spend:Number:ALLOW'
          ,'other_m_spend:Number:ALLOW'
          ,'packaging_spend:Number:ALLOW'
          ,'pvf_spend:Number:ALLOW'
          ,'plastic_spend:Number:ALLOW'
          ,'textile_spend:Number:ALLOW'
          ,'bs_spend:Number:ALLOW'
          ,'ce_spend:Number:ALLOW'
          ,'hardware_spend:Number:ALLOW'
          ,'ie_spend:Number:ALLOW'
          ,'is_spend:Number:ALLOW'
          ,'it_spend:Number:ALLOW'
          ,'mls_spend:Number:ALLOW'
          ,'os_spend:Number:ALLOW'
          ,'pp_spend:Number:ALLOW'
          ,'sis_spend:Number:ALLOW'
          ,'apparel_spend:Number:ALLOW'
          ,'beverages_spend:Number:ALLOW'
          ,'constr_spend:Number:ALLOW'
          ,'consulting_spend:Number:ALLOW'
          ,'fs_spend:Number:ALLOW'
          ,'fp_spend:Number:ALLOW'
          ,'insurance_spend:Number:ALLOW'
          ,'ls_spend:Number:ALLOW'
          ,'oil_gas_spend:Number:ALLOW'
          ,'utilities_spend:Number:ALLOW'
          ,'other_spend:Number:ALLOW'
          ,'advt_spend:Number:ALLOW'
          ,'air_growth:Ratio:ALLOW','air_growth:Ratio:LENGTHS'
          ,'fuel_growth:Ratio:ALLOW','fuel_growth:Ratio:LENGTHS'
          ,'leasing_growth:Ratio:ALLOW','leasing_growth:Ratio:LENGTHS'
          ,'ltl_growth:Ratio:ALLOW','ltl_growth:Ratio:LENGTHS'
          ,'rail_growth:Ratio:ALLOW','rail_growth:Ratio:LENGTHS'
          ,'tl_growth:Ratio:ALLOW','tl_growth:Ratio:LENGTHS'
          ,'transvc_growth:Ratio:ALLOW','transvc_growth:Ratio:LENGTHS'
          ,'transup_growth:Ratio:ALLOW','transup_growth:Ratio:LENGTHS'
          ,'bst_growth:Ratio:ALLOW','bst_growth:Ratio:LENGTHS'
          ,'dg_growth:Ratio:ALLOW','dg_growth:Ratio:LENGTHS'
          ,'electrical_growth:Ratio:ALLOW','electrical_growth:Ratio:LENGTHS'
          ,'hvac_growth:Ratio:ALLOW','hvac_growth:Ratio:LENGTHS'
          ,'other_b_growth:Ratio:ALLOW','other_b_growth:Ratio:LENGTHS'
          ,'plumbing_growth:Ratio:ALLOW','plumbing_growth:Ratio:LENGTHS'
          ,'rs_growth:Ratio:ALLOW','rs_growth:Ratio:LENGTHS'
          ,'wp_growth:Ratio:ALLOW','wp_growth:Ratio:LENGTHS'
          ,'chemical_growth:Ratio:ALLOW','chemical_growth:Ratio:LENGTHS'
          ,'electronic_growth:Ratio:ALLOW','electronic_growth:Ratio:LENGTHS'
          ,'metal_growth:Ratio:ALLOW','metal_growth:Ratio:LENGTHS'
          ,'other_m_growth:Ratio:ALLOW','other_m_growth:Ratio:LENGTHS'
          ,'packaging_growth:Ratio:ALLOW','packaging_growth:Ratio:LENGTHS'
          ,'pvf_growth:Ratio:ALLOW','pvf_growth:Ratio:LENGTHS'
          ,'plastic_growth:Ratio:ALLOW','plastic_growth:Ratio:LENGTHS'
          ,'textile_growth:Ratio:ALLOW','textile_growth:Ratio:LENGTHS'
          ,'bs_growth:Ratio:ALLOW','bs_growth:Ratio:LENGTHS'
          ,'ce_growth:Ratio:ALLOW','ce_growth:Ratio:LENGTHS'
          ,'hardware_growth:Ratio:ALLOW','hardware_growth:Ratio:LENGTHS'
          ,'ie_growth:Ratio:ALLOW','ie_growth:Ratio:LENGTHS'
          ,'is_growth:Ratio:ALLOW','is_growth:Ratio:LENGTHS'
          ,'it_growth:Ratio:ALLOW','it_growth:Ratio:LENGTHS'
          ,'mls_growth:Ratio:ALLOW','mls_growth:Ratio:LENGTHS'
          ,'os_growth:Ratio:ALLOW','os_growth:Ratio:LENGTHS'
          ,'pp_growth:Ratio:ALLOW','pp_growth:Ratio:LENGTHS'
          ,'sis_growth:Ratio:ALLOW','sis_growth:Ratio:LENGTHS'
          ,'apparel_growth:Ratio:ALLOW','apparel_growth:Ratio:LENGTHS'
          ,'beverages_growth:Ratio:ALLOW','beverages_growth:Ratio:LENGTHS'
          ,'constr_growth:Ratio:ALLOW','constr_growth:Ratio:LENGTHS'
          ,'consulting_growth:Ratio:ALLOW','consulting_growth:Ratio:LENGTHS'
          ,'fs_growth:Ratio:ALLOW','fs_growth:Ratio:LENGTHS'
          ,'fp_growth:Ratio:ALLOW','fp_growth:Ratio:LENGTHS'
          ,'insurance_growth:Ratio:ALLOW','insurance_growth:Ratio:LENGTHS'
          ,'ls_growth:Ratio:ALLOW','ls_growth:Ratio:LENGTHS'
          ,'oil_gas_growth:Ratio:ALLOW','oil_gas_growth:Ratio:LENGTHS'
          ,'utilities_growth:Ratio:ALLOW','utilities_growth:Ratio:LENGTHS'
          ,'other_growth:Ratio:ALLOW','other_growth:Ratio:LENGTHS'
          ,'advt_growth:Ratio:ALLOW','advt_growth:Ratio:LENGTHS'
          ,'top5_growth:Ratio:ALLOW','top5_growth:Ratio:LENGTHS'
          ,'shipping_y1:Number:ALLOW'
          ,'shipping_growth:Ratio:ALLOW','shipping_growth:Ratio:LENGTHS'
          ,'materials_y1:Number:ALLOW'
          ,'materials_growth:Ratio:ALLOW','materials_growth:Ratio:LENGTHS'
          ,'operations_y1:Number:ALLOW'
          ,'operations_growth:Ratio:ALLOW','operations_growth:Ratio:LENGTHS'
          ,'total_paid_average_0t12:Ratio:ALLOW','total_paid_average_0t12:Ratio:LENGTHS'
          ,'total_paid_monthspastworst_24:Ratio:ALLOW','total_paid_monthspastworst_24:Ratio:LENGTHS'
          ,'total_paid_slope_0t12:Ratio:ALLOW','total_paid_slope_0t12:Ratio:LENGTHS'
          ,'total_paid_slope_0t6:Ratio:ALLOW','total_paid_slope_0t6:Ratio:LENGTHS'
          ,'total_paid_slope_6t12:Ratio:ALLOW','total_paid_slope_6t12:Ratio:LENGTHS'
          ,'total_paid_slope_6t18:Ratio:ALLOW','total_paid_slope_6t18:Ratio:LENGTHS'
          ,'total_paid_volatility_0t12:Ratio:ALLOW','total_paid_volatility_0t12:Ratio:LENGTHS'
          ,'total_paid_volatility_0t6:Ratio:ALLOW','total_paid_volatility_0t6:Ratio:LENGTHS'
          ,'total_paid_volatility_12t18:Ratio:ALLOW','total_paid_volatility_12t18:Ratio:LENGTHS'
          ,'total_paid_volatility_6t12:Ratio:ALLOW','total_paid_volatility_6t12:Ratio:LENGTHS'
          ,'total_spend_monthspastleast_24:Number:ALLOW'
          ,'total_spend_monthspastmost_24:Number:ALLOW'
          ,'total_spend_slope_0t12:Ratio:ALLOW','total_spend_slope_0t12:Ratio:LENGTHS'
          ,'total_spend_slope_0t24:Ratio:ALLOW','total_spend_slope_0t24:Ratio:LENGTHS'
          ,'total_spend_slope_0t6:Ratio:ALLOW','total_spend_slope_0t6:Ratio:LENGTHS'
          ,'total_spend_slope_6t12:Ratio:ALLOW','total_spend_slope_6t12:Ratio:LENGTHS'
          ,'total_spend_sum_12:Ratio:ALLOW','total_spend_sum_12:Ratio:LENGTHS'
          ,'total_spend_volatility_0t12:Ratio:ALLOW','total_spend_volatility_0t12:Ratio:LENGTHS'
          ,'total_spend_volatility_0t6:Ratio:ALLOW','total_spend_volatility_0t6:Ratio:LENGTHS'
          ,'total_spend_volatility_12t18:Ratio:ALLOW','total_spend_volatility_12t18:Ratio:LENGTHS'
          ,'total_spend_volatility_6t12:Ratio:ALLOW','total_spend_volatility_6t12:Ratio:LENGTHS'
          ,'mfgmat_paid_average_12:Ratio:ALLOW','mfgmat_paid_average_12:Ratio:LENGTHS'
          ,'mfgmat_paid_monthspastworst_24:Number:ALLOW'
          ,'mfgmat_paid_slope_0t12:Ratio:ALLOW','mfgmat_paid_slope_0t12:Ratio:LENGTHS'
          ,'mfgmat_paid_slope_0t24:Ratio:ALLOW','mfgmat_paid_slope_0t24:Ratio:LENGTHS'
          ,'mfgmat_paid_slope_0t6:Ratio:ALLOW','mfgmat_paid_slope_0t6:Ratio:LENGTHS'
          ,'mfgmat_paid_volatility_0t12:Ratio:ALLOW','mfgmat_paid_volatility_0t12:Ratio:LENGTHS'
          ,'mfgmat_paid_volatility_0t6:Ratio:ALLOW','mfgmat_paid_volatility_0t6:Ratio:LENGTHS'
          ,'mfgmat_spend_monthspastleast_24:Number:ALLOW'
          ,'mfgmat_spend_monthspastmost_24:Number:ALLOW'
          ,'mfgmat_spend_slope_0t12:Ratio:ALLOW','mfgmat_spend_slope_0t12:Ratio:LENGTHS'
          ,'mfgmat_spend_slope_0t24:Ratio:ALLOW','mfgmat_spend_slope_0t24:Ratio:LENGTHS'
          ,'mfgmat_spend_slope_0t6:Ratio:ALLOW','mfgmat_spend_slope_0t6:Ratio:LENGTHS'
          ,'mfgmat_spend_sum_12:Ratio:ALLOW','mfgmat_spend_sum_12:Ratio:LENGTHS'
          ,'mfgmat_spend_volatility_0t6:Ratio:ALLOW','mfgmat_spend_volatility_0t6:Ratio:LENGTHS'
          ,'mfgmat_spend_volatility_6t12:Ratio:ALLOW','mfgmat_spend_volatility_6t12:Ratio:LENGTHS'
          ,'ops_paid_average_12:Ratio:ALLOW','ops_paid_average_12:Ratio:LENGTHS'
          ,'ops_paid_monthspastworst_24:Ratio:ALLOW','ops_paid_monthspastworst_24:Ratio:LENGTHS'
          ,'ops_paid_slope_0t12:Ratio:ALLOW','ops_paid_slope_0t12:Ratio:LENGTHS'
          ,'ops_paid_slope_0t24:Ratio:ALLOW','ops_paid_slope_0t24:Ratio:LENGTHS'
          ,'ops_paid_slope_0t6:Ratio:ALLOW','ops_paid_slope_0t6:Ratio:LENGTHS'
          ,'ops_paid_volatility_0t12:Ratio:ALLOW','ops_paid_volatility_0t12:Ratio:LENGTHS'
          ,'ops_paid_volatility_0t6:Ratio:ALLOW','ops_paid_volatility_0t6:Ratio:LENGTHS'
          ,'ops_spend_monthspastleast_24:Number:ALLOW'
          ,'ops_spend_monthspastmost_24:Number:ALLOW'
          ,'ops_spend_slope_0t12:Ratio:ALLOW','ops_spend_slope_0t12:Ratio:LENGTHS'
          ,'ops_spend_slope_0t24:Ratio:ALLOW','ops_spend_slope_0t24:Ratio:LENGTHS'
          ,'ops_spend_slope_0t6:Ratio:ALLOW','ops_spend_slope_0t6:Ratio:LENGTHS'
          ,'fleet_paid_monthspastworst_24:Number:ALLOW'
          ,'fleet_paid_slope_0t12:Ratio:ALLOW','fleet_paid_slope_0t12:Ratio:LENGTHS'
          ,'fleet_paid_slope_0t24:Ratio:ALLOW','fleet_paid_slope_0t24:Ratio:LENGTHS'
          ,'fleet_paid_slope_0t6:Ratio:ALLOW','fleet_paid_slope_0t6:Ratio:LENGTHS'
          ,'fleet_paid_volatility_0t12:Ratio:ALLOW','fleet_paid_volatility_0t12:Ratio:LENGTHS'
          ,'fleet_paid_volatility_0t6:Ratio:ALLOW','fleet_paid_volatility_0t6:Ratio:LENGTHS'
          ,'fleet_spend_slope_0t12:Ratio:ALLOW','fleet_spend_slope_0t12:Ratio:LENGTHS'
          ,'fleet_spend_slope_0t24:Ratio:ALLOW','fleet_spend_slope_0t24:Ratio:LENGTHS'
          ,'fleet_spend_slope_0t6:Ratio:ALLOW','fleet_spend_slope_0t6:Ratio:LENGTHS'
          ,'carrier_paid_slope_0t12:Ratio:ALLOW','carrier_paid_slope_0t12:Ratio:LENGTHS'
          ,'carrier_paid_slope_0t24:Ratio:ALLOW','carrier_paid_slope_0t24:Ratio:LENGTHS'
          ,'carrier_paid_slope_0t6:Ratio:ALLOW','carrier_paid_slope_0t6:Ratio:LENGTHS'
          ,'carrier_paid_volatility_0t12:Ratio:ALLOW','carrier_paid_volatility_0t12:Ratio:LENGTHS'
          ,'carrier_paid_volatility_0t6:Ratio:ALLOW','carrier_paid_volatility_0t6:Ratio:LENGTHS'
          ,'carrier_spend_slope_0t12:Ratio:ALLOW','carrier_spend_slope_0t12:Ratio:LENGTHS'
          ,'carrier_spend_slope_0t24:Ratio:ALLOW','carrier_spend_slope_0t24:Ratio:LENGTHS'
          ,'carrier_spend_slope_0t6:Ratio:ALLOW','carrier_spend_slope_0t6:Ratio:LENGTHS'
          ,'carrier_spend_volatility_0t6:Ratio:ALLOW','carrier_spend_volatility_0t6:Ratio:LENGTHS'
          ,'carrier_spend_volatility_6t12:Ratio:ALLOW','carrier_spend_volatility_6t12:Ratio:LENGTHS'
          ,'bldgmats_paid_slope_0t12:Ratio:ALLOW','bldgmats_paid_slope_0t12:Ratio:LENGTHS'
          ,'bldgmats_paid_slope_0t24:Ratio:ALLOW','bldgmats_paid_slope_0t24:Ratio:LENGTHS'
          ,'bldgmats_paid_slope_0t6:Ratio:ALLOW','bldgmats_paid_slope_0t6:Ratio:LENGTHS'
          ,'bldgmats_paid_volatility_0t12:Ratio:ALLOW','bldgmats_paid_volatility_0t12:Ratio:LENGTHS'
          ,'bldgmats_paid_volatility_0t6:Ratio:ALLOW','bldgmats_paid_volatility_0t6:Ratio:LENGTHS'
          ,'bldgmats_spend_slope_0t12:Ratio:ALLOW','bldgmats_spend_slope_0t12:Ratio:LENGTHS'
          ,'bldgmats_spend_slope_0t24:Ratio:ALLOW','bldgmats_spend_slope_0t24:Ratio:LENGTHS'
          ,'bldgmats_spend_slope_0t6:Ratio:ALLOW','bldgmats_spend_slope_0t6:Ratio:LENGTHS'
          ,'bldgmats_spend_volatility_0t6:Ratio:ALLOW','bldgmats_spend_volatility_0t6:Ratio:LENGTHS'
          ,'bldgmats_spend_volatility_6t12:Ratio:ALLOW','bldgmats_spend_volatility_6t12:Ratio:LENGTHS'
          ,'top5_paid_slope_0t12:Ratio:ALLOW','top5_paid_slope_0t12:Ratio:LENGTHS'
          ,'top5_paid_slope_0t24:Ratio:ALLOW','top5_paid_slope_0t24:Ratio:LENGTHS'
          ,'top5_paid_slope_0t6:Ratio:ALLOW','top5_paid_slope_0t6:Ratio:LENGTHS'
          ,'top5_paid_volatility_0t12:Ratio:ALLOW','top5_paid_volatility_0t12:Ratio:LENGTHS'
          ,'top5_paid_volatility_0t6:Ratio:ALLOW','top5_paid_volatility_0t6:Ratio:LENGTHS'
          ,'top5_spend_slope_0t12:Ratio:ALLOW','top5_spend_slope_0t12:Ratio:LENGTHS'
          ,'top5_spend_slope_0t24:Ratio:ALLOW','top5_spend_slope_0t24:Ratio:LENGTHS'
          ,'top5_spend_slope_0t6:Ratio:ALLOW','top5_spend_slope_0t6:Ratio:LENGTHS'
          ,'top5_spend_volatility_0t6:Ratio:ALLOW','top5_spend_volatility_0t6:Ratio:LENGTHS'
          ,'top5_spend_volatility_6t12:Ratio:ALLOW','top5_spend_volatility_6t12:Ratio:LENGTHS'
          ,'total_numrel_slope_0t12:Ratio:ALLOW','total_numrel_slope_0t12:Ratio:LENGTHS'
          ,'total_numrel_slope_0t24:Ratio:ALLOW','total_numrel_slope_0t24:Ratio:LENGTHS'
          ,'total_numrel_slope_0t6:Ratio:ALLOW','total_numrel_slope_0t6:Ratio:LENGTHS'
          ,'total_numrel_slope_6t12:Ratio:ALLOW','total_numrel_slope_6t12:Ratio:LENGTHS'
          ,'mfgmat_numrel_slope_0t12:Ratio:ALLOW','mfgmat_numrel_slope_0t12:Ratio:LENGTHS'
          ,'mfgmat_numrel_slope_0t24:Ratio:ALLOW','mfgmat_numrel_slope_0t24:Ratio:LENGTHS'
          ,'mfgmat_numrel_slope_0t6:Ratio:ALLOW','mfgmat_numrel_slope_0t6:Ratio:LENGTHS'
          ,'mfgmat_numrel_slope_6t12:Ratio:ALLOW','mfgmat_numrel_slope_6t12:Ratio:LENGTHS'
          ,'ops_numrel_slope_0t12:Ratio:ALLOW','ops_numrel_slope_0t12:Ratio:LENGTHS'
          ,'ops_numrel_slope_0t24:Ratio:ALLOW','ops_numrel_slope_0t24:Ratio:LENGTHS'
          ,'ops_numrel_slope_0t6:Ratio:ALLOW','ops_numrel_slope_0t6:Ratio:LENGTHS'
          ,'ops_numrel_slope_6t12:Ratio:ALLOW','ops_numrel_slope_6t12:Ratio:LENGTHS'
          ,'fleet_numrel_slope_0t12:Ratio:ALLOW','fleet_numrel_slope_0t12:Ratio:LENGTHS'
          ,'fleet_numrel_slope_0t24:Ratio:ALLOW','fleet_numrel_slope_0t24:Ratio:LENGTHS'
          ,'fleet_numrel_slope_0t6:Ratio:ALLOW','fleet_numrel_slope_0t6:Ratio:LENGTHS'
          ,'fleet_numrel_slope_6t12:Ratio:ALLOW','fleet_numrel_slope_6t12:Ratio:LENGTHS'
          ,'carrier_numrel_slope_0t12:Ratio:ALLOW','carrier_numrel_slope_0t12:Ratio:LENGTHS'
          ,'carrier_numrel_slope_0t24:Ratio:ALLOW','carrier_numrel_slope_0t24:Ratio:LENGTHS'
          ,'carrier_numrel_slope_0t6:Ratio:ALLOW','carrier_numrel_slope_0t6:Ratio:LENGTHS'
          ,'carrier_numrel_slope_6t12:Ratio:ALLOW','carrier_numrel_slope_6t12:Ratio:LENGTHS'
          ,'bldgmats_numrel_slope_0t12:Ratio:ALLOW','bldgmats_numrel_slope_0t12:Ratio:LENGTHS'
          ,'bldgmats_numrel_slope_0t24:Ratio:ALLOW','bldgmats_numrel_slope_0t24:Ratio:LENGTHS'
          ,'bldgmats_numrel_slope_0t6:Ratio:ALLOW','bldgmats_numrel_slope_0t6:Ratio:LENGTHS'
          ,'bldgmats_numrel_slope_6t12:Ratio:ALLOW','bldgmats_numrel_slope_6t12:Ratio:LENGTHS'
          ,'bldgmats_numrel_var_0t12:Ratio:ALLOW','bldgmats_numrel_var_0t12:Ratio:LENGTHS'
          ,'bldgmats_numrel_var_12t24:Ratio:ALLOW','bldgmats_numrel_var_12t24:Ratio:LENGTHS'
          ,'total_percprov30_slope_0t12:Ratio:ALLOW','total_percprov30_slope_0t12:Ratio:LENGTHS'
          ,'total_percprov30_slope_0t24:Ratio:ALLOW','total_percprov30_slope_0t24:Ratio:LENGTHS'
          ,'total_percprov30_slope_0t6:Ratio:ALLOW','total_percprov30_slope_0t6:Ratio:LENGTHS'
          ,'total_percprov30_slope_6t12:Ratio:ALLOW','total_percprov30_slope_6t12:Ratio:LENGTHS'
          ,'total_percprov60_slope_0t12:Ratio:ALLOW','total_percprov60_slope_0t12:Ratio:LENGTHS'
          ,'total_percprov60_slope_0t24:Ratio:ALLOW','total_percprov60_slope_0t24:Ratio:LENGTHS'
          ,'total_percprov60_slope_0t6:Ratio:ALLOW','total_percprov60_slope_0t6:Ratio:LENGTHS'
          ,'total_percprov60_slope_6t12:Ratio:ALLOW','total_percprov60_slope_6t12:Ratio:LENGTHS'
          ,'total_percprov90_slope_0t24:Ratio:ALLOW','total_percprov90_slope_0t24:Ratio:LENGTHS'
          ,'total_percprov90_slope_0t6:Ratio:ALLOW','total_percprov90_slope_0t6:Ratio:LENGTHS'
          ,'total_percprov90_slope_6t12:Ratio:ALLOW','total_percprov90_slope_6t12:Ratio:LENGTHS'
          ,'mfgmat_percprov30_slope_0t12:Ratio:ALLOW','mfgmat_percprov30_slope_0t12:Ratio:LENGTHS'
          ,'mfgmat_percprov30_slope_6t12:Ratio:ALLOW','mfgmat_percprov30_slope_6t12:Ratio:LENGTHS'
          ,'mfgmat_percprov60_slope_0t12:Ratio:ALLOW','mfgmat_percprov60_slope_0t12:Ratio:LENGTHS'
          ,'mfgmat_percprov60_slope_6t12:Ratio:ALLOW','mfgmat_percprov60_slope_6t12:Ratio:LENGTHS'
          ,'mfgmat_percprov90_slope_0t24:Ratio:ALLOW','mfgmat_percprov90_slope_0t24:Ratio:LENGTHS'
          ,'mfgmat_percprov90_slope_0t6:Ratio:ALLOW','mfgmat_percprov90_slope_0t6:Ratio:LENGTHS'
          ,'mfgmat_percprov90_slope_6t12:Ratio:ALLOW','mfgmat_percprov90_slope_6t12:Ratio:LENGTHS'
          ,'ops_percprov30_slope_0t12:Ratio:ALLOW','ops_percprov30_slope_0t12:Ratio:LENGTHS'
          ,'ops_percprov30_slope_6t12:Ratio:ALLOW','ops_percprov30_slope_6t12:Ratio:LENGTHS'
          ,'ops_percprov60_slope_0t12:Ratio:ALLOW','ops_percprov60_slope_0t12:Ratio:LENGTHS'
          ,'ops_percprov60_slope_6t12:Ratio:ALLOW','ops_percprov60_slope_6t12:Ratio:LENGTHS'
          ,'ops_percprov90_slope_0t24:Ratio:ALLOW','ops_percprov90_slope_0t24:Ratio:LENGTHS'
          ,'ops_percprov90_slope_0t6:Ratio:ALLOW','ops_percprov90_slope_0t6:Ratio:LENGTHS'
          ,'ops_percprov90_slope_6t12:Ratio:ALLOW','ops_percprov90_slope_6t12:Ratio:LENGTHS'
          ,'fleet_percprov30_slope_0t12:Ratio:ALLOW','fleet_percprov30_slope_0t12:Ratio:LENGTHS'
          ,'fleet_percprov30_slope_6t12:Ratio:ALLOW','fleet_percprov30_slope_6t12:Ratio:LENGTHS'
          ,'fleet_percprov60_slope_0t12:Ratio:ALLOW','fleet_percprov60_slope_0t12:Ratio:LENGTHS'
          ,'fleet_percprov60_slope_6t12:Ratio:ALLOW','fleet_percprov60_slope_6t12:Ratio:LENGTHS'
          ,'fleet_percprov90_slope_0t24:Ratio:ALLOW','fleet_percprov90_slope_0t24:Ratio:LENGTHS'
          ,'fleet_percprov90_slope_0t6:Ratio:ALLOW','fleet_percprov90_slope_0t6:Ratio:LENGTHS'
          ,'fleet_percprov90_slope_6t12:Ratio:ALLOW','fleet_percprov90_slope_6t12:Ratio:LENGTHS'
          ,'carrier_percprov30_slope_0t12:Ratio:ALLOW','carrier_percprov30_slope_0t12:Ratio:LENGTHS'
          ,'carrier_percprov30_slope_6t12:Ratio:ALLOW','carrier_percprov30_slope_6t12:Ratio:LENGTHS'
          ,'carrier_percprov60_slope_0t12:Ratio:ALLOW','carrier_percprov60_slope_0t12:Ratio:LENGTHS'
          ,'carrier_percprov60_slope_6t12:Ratio:ALLOW','carrier_percprov60_slope_6t12:Ratio:LENGTHS'
          ,'carrier_percprov90_slope_0t24:Ratio:ALLOW','carrier_percprov90_slope_0t24:Ratio:LENGTHS'
          ,'carrier_percprov90_slope_0t6:Ratio:ALLOW','carrier_percprov90_slope_0t6:Ratio:LENGTHS'
          ,'carrier_percprov90_slope_6t12:Ratio:ALLOW','carrier_percprov90_slope_6t12:Ratio:LENGTHS'
          ,'bldgmats_percprov30_slope_0t12:Ratio:ALLOW','bldgmats_percprov30_slope_0t12:Ratio:LENGTHS'
          ,'bldgmats_percprov30_slope_6t12:Ratio:ALLOW','bldgmats_percprov30_slope_6t12:Ratio:LENGTHS'
          ,'bldgmats_percprov60_slope_0t12:Ratio:ALLOW','bldgmats_percprov60_slope_0t12:Ratio:LENGTHS'
          ,'bldgmats_percprov60_slope_6t12:Ratio:ALLOW','bldgmats_percprov60_slope_6t12:Ratio:LENGTHS'
          ,'bldgmats_percprov90_slope_0t24:Ratio:ALLOW','bldgmats_percprov90_slope_0t24:Ratio:LENGTHS'
          ,'bldgmats_percprov90_slope_0t6:Ratio:ALLOW','bldgmats_percprov90_slope_0t6:Ratio:LENGTHS'
          ,'bldgmats_percprov90_slope_6t12:Ratio:ALLOW','bldgmats_percprov90_slope_6t12:Ratio:LENGTHS'
          ,'top5_percprov30_slope_0t12:Ratio:ALLOW','top5_percprov30_slope_0t12:Ratio:LENGTHS'
          ,'top5_percprov30_slope_6t12:Ratio:ALLOW','top5_percprov30_slope_6t12:Ratio:LENGTHS'
          ,'top5_percprov60_slope_0t12:Ratio:ALLOW','top5_percprov60_slope_0t12:Ratio:LENGTHS'
          ,'top5_percprov60_slope_6t12:Ratio:ALLOW','top5_percprov60_slope_6t12:Ratio:LENGTHS'
          ,'top5_percprov90_slope_0t24:Ratio:ALLOW','top5_percprov90_slope_0t24:Ratio:LENGTHS'
          ,'top5_percprov90_slope_0t6:Ratio:ALLOW','top5_percprov90_slope_0t6:Ratio:LENGTHS'
          ,'top5_percprov90_slope_6t12:Ratio:ALLOW','top5_percprov90_slope_6t12:Ratio:LENGTHS'
          ,'top5_percprovoutstanding_adjustedslope_0t12:Ratio:ALLOW','top5_percprovoutstanding_adjustedslope_0t12:Ratio:LENGTHS'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Attributes_Fields.InvalidMessage_ultimate_linkid(1)
          ,Attributes_Fields.InvalidMessage_cortera_score(1)
          ,Attributes_Fields.InvalidMessage_cpr_score(1)
          ,Attributes_Fields.InvalidMessage_cpr_segment(1)
          ,Attributes_Fields.InvalidMessage_dbt(1),Attributes_Fields.InvalidMessage_dbt(2)
          ,Attributes_Fields.InvalidMessage_avg_bal(1)
          ,Attributes_Fields.InvalidMessage_air_spend(1)
          ,Attributes_Fields.InvalidMessage_fuel_spend(1)
          ,Attributes_Fields.InvalidMessage_leasing_spend(1)
          ,Attributes_Fields.InvalidMessage_ltl_spend(1)
          ,Attributes_Fields.InvalidMessage_rail_spend(1)
          ,Attributes_Fields.InvalidMessage_tl_spend(1)
          ,Attributes_Fields.InvalidMessage_transvc_spend(1)
          ,Attributes_Fields.InvalidMessage_transup_spend(1)
          ,Attributes_Fields.InvalidMessage_bst_spend(1)
          ,Attributes_Fields.InvalidMessage_dg_spend(1)
          ,Attributes_Fields.InvalidMessage_electrical_spend(1)
          ,Attributes_Fields.InvalidMessage_hvac_spend(1)
          ,Attributes_Fields.InvalidMessage_other_b_spend(1)
          ,Attributes_Fields.InvalidMessage_plumbing_spend(1)
          ,Attributes_Fields.InvalidMessage_rs_spend(1)
          ,Attributes_Fields.InvalidMessage_wp_spend(1)
          ,Attributes_Fields.InvalidMessage_chemical_spend(1)
          ,Attributes_Fields.InvalidMessage_electronic_spend(1)
          ,Attributes_Fields.InvalidMessage_metal_spend(1)
          ,Attributes_Fields.InvalidMessage_other_m_spend(1)
          ,Attributes_Fields.InvalidMessage_packaging_spend(1)
          ,Attributes_Fields.InvalidMessage_pvf_spend(1)
          ,Attributes_Fields.InvalidMessage_plastic_spend(1)
          ,Attributes_Fields.InvalidMessage_textile_spend(1)
          ,Attributes_Fields.InvalidMessage_bs_spend(1)
          ,Attributes_Fields.InvalidMessage_ce_spend(1)
          ,Attributes_Fields.InvalidMessage_hardware_spend(1)
          ,Attributes_Fields.InvalidMessage_ie_spend(1)
          ,Attributes_Fields.InvalidMessage_is_spend(1)
          ,Attributes_Fields.InvalidMessage_it_spend(1)
          ,Attributes_Fields.InvalidMessage_mls_spend(1)
          ,Attributes_Fields.InvalidMessage_os_spend(1)
          ,Attributes_Fields.InvalidMessage_pp_spend(1)
          ,Attributes_Fields.InvalidMessage_sis_spend(1)
          ,Attributes_Fields.InvalidMessage_apparel_spend(1)
          ,Attributes_Fields.InvalidMessage_beverages_spend(1)
          ,Attributes_Fields.InvalidMessage_constr_spend(1)
          ,Attributes_Fields.InvalidMessage_consulting_spend(1)
          ,Attributes_Fields.InvalidMessage_fs_spend(1)
          ,Attributes_Fields.InvalidMessage_fp_spend(1)
          ,Attributes_Fields.InvalidMessage_insurance_spend(1)
          ,Attributes_Fields.InvalidMessage_ls_spend(1)
          ,Attributes_Fields.InvalidMessage_oil_gas_spend(1)
          ,Attributes_Fields.InvalidMessage_utilities_spend(1)
          ,Attributes_Fields.InvalidMessage_other_spend(1)
          ,Attributes_Fields.InvalidMessage_advt_spend(1)
          ,Attributes_Fields.InvalidMessage_air_growth(1),Attributes_Fields.InvalidMessage_air_growth(2)
          ,Attributes_Fields.InvalidMessage_fuel_growth(1),Attributes_Fields.InvalidMessage_fuel_growth(2)
          ,Attributes_Fields.InvalidMessage_leasing_growth(1),Attributes_Fields.InvalidMessage_leasing_growth(2)
          ,Attributes_Fields.InvalidMessage_ltl_growth(1),Attributes_Fields.InvalidMessage_ltl_growth(2)
          ,Attributes_Fields.InvalidMessage_rail_growth(1),Attributes_Fields.InvalidMessage_rail_growth(2)
          ,Attributes_Fields.InvalidMessage_tl_growth(1),Attributes_Fields.InvalidMessage_tl_growth(2)
          ,Attributes_Fields.InvalidMessage_transvc_growth(1),Attributes_Fields.InvalidMessage_transvc_growth(2)
          ,Attributes_Fields.InvalidMessage_transup_growth(1),Attributes_Fields.InvalidMessage_transup_growth(2)
          ,Attributes_Fields.InvalidMessage_bst_growth(1),Attributes_Fields.InvalidMessage_bst_growth(2)
          ,Attributes_Fields.InvalidMessage_dg_growth(1),Attributes_Fields.InvalidMessage_dg_growth(2)
          ,Attributes_Fields.InvalidMessage_electrical_growth(1),Attributes_Fields.InvalidMessage_electrical_growth(2)
          ,Attributes_Fields.InvalidMessage_hvac_growth(1),Attributes_Fields.InvalidMessage_hvac_growth(2)
          ,Attributes_Fields.InvalidMessage_other_b_growth(1),Attributes_Fields.InvalidMessage_other_b_growth(2)
          ,Attributes_Fields.InvalidMessage_plumbing_growth(1),Attributes_Fields.InvalidMessage_plumbing_growth(2)
          ,Attributes_Fields.InvalidMessage_rs_growth(1),Attributes_Fields.InvalidMessage_rs_growth(2)
          ,Attributes_Fields.InvalidMessage_wp_growth(1),Attributes_Fields.InvalidMessage_wp_growth(2)
          ,Attributes_Fields.InvalidMessage_chemical_growth(1),Attributes_Fields.InvalidMessage_chemical_growth(2)
          ,Attributes_Fields.InvalidMessage_electronic_growth(1),Attributes_Fields.InvalidMessage_electronic_growth(2)
          ,Attributes_Fields.InvalidMessage_metal_growth(1),Attributes_Fields.InvalidMessage_metal_growth(2)
          ,Attributes_Fields.InvalidMessage_other_m_growth(1),Attributes_Fields.InvalidMessage_other_m_growth(2)
          ,Attributes_Fields.InvalidMessage_packaging_growth(1),Attributes_Fields.InvalidMessage_packaging_growth(2)
          ,Attributes_Fields.InvalidMessage_pvf_growth(1),Attributes_Fields.InvalidMessage_pvf_growth(2)
          ,Attributes_Fields.InvalidMessage_plastic_growth(1),Attributes_Fields.InvalidMessage_plastic_growth(2)
          ,Attributes_Fields.InvalidMessage_textile_growth(1),Attributes_Fields.InvalidMessage_textile_growth(2)
          ,Attributes_Fields.InvalidMessage_bs_growth(1),Attributes_Fields.InvalidMessage_bs_growth(2)
          ,Attributes_Fields.InvalidMessage_ce_growth(1),Attributes_Fields.InvalidMessage_ce_growth(2)
          ,Attributes_Fields.InvalidMessage_hardware_growth(1),Attributes_Fields.InvalidMessage_hardware_growth(2)
          ,Attributes_Fields.InvalidMessage_ie_growth(1),Attributes_Fields.InvalidMessage_ie_growth(2)
          ,Attributes_Fields.InvalidMessage_is_growth(1),Attributes_Fields.InvalidMessage_is_growth(2)
          ,Attributes_Fields.InvalidMessage_it_growth(1),Attributes_Fields.InvalidMessage_it_growth(2)
          ,Attributes_Fields.InvalidMessage_mls_growth(1),Attributes_Fields.InvalidMessage_mls_growth(2)
          ,Attributes_Fields.InvalidMessage_os_growth(1),Attributes_Fields.InvalidMessage_os_growth(2)
          ,Attributes_Fields.InvalidMessage_pp_growth(1),Attributes_Fields.InvalidMessage_pp_growth(2)
          ,Attributes_Fields.InvalidMessage_sis_growth(1),Attributes_Fields.InvalidMessage_sis_growth(2)
          ,Attributes_Fields.InvalidMessage_apparel_growth(1),Attributes_Fields.InvalidMessage_apparel_growth(2)
          ,Attributes_Fields.InvalidMessage_beverages_growth(1),Attributes_Fields.InvalidMessage_beverages_growth(2)
          ,Attributes_Fields.InvalidMessage_constr_growth(1),Attributes_Fields.InvalidMessage_constr_growth(2)
          ,Attributes_Fields.InvalidMessage_consulting_growth(1),Attributes_Fields.InvalidMessage_consulting_growth(2)
          ,Attributes_Fields.InvalidMessage_fs_growth(1),Attributes_Fields.InvalidMessage_fs_growth(2)
          ,Attributes_Fields.InvalidMessage_fp_growth(1),Attributes_Fields.InvalidMessage_fp_growth(2)
          ,Attributes_Fields.InvalidMessage_insurance_growth(1),Attributes_Fields.InvalidMessage_insurance_growth(2)
          ,Attributes_Fields.InvalidMessage_ls_growth(1),Attributes_Fields.InvalidMessage_ls_growth(2)
          ,Attributes_Fields.InvalidMessage_oil_gas_growth(1),Attributes_Fields.InvalidMessage_oil_gas_growth(2)
          ,Attributes_Fields.InvalidMessage_utilities_growth(1),Attributes_Fields.InvalidMessage_utilities_growth(2)
          ,Attributes_Fields.InvalidMessage_other_growth(1),Attributes_Fields.InvalidMessage_other_growth(2)
          ,Attributes_Fields.InvalidMessage_advt_growth(1),Attributes_Fields.InvalidMessage_advt_growth(2)
          ,Attributes_Fields.InvalidMessage_top5_growth(1),Attributes_Fields.InvalidMessage_top5_growth(2)
          ,Attributes_Fields.InvalidMessage_shipping_y1(1)
          ,Attributes_Fields.InvalidMessage_shipping_growth(1),Attributes_Fields.InvalidMessage_shipping_growth(2)
          ,Attributes_Fields.InvalidMessage_materials_y1(1)
          ,Attributes_Fields.InvalidMessage_materials_growth(1),Attributes_Fields.InvalidMessage_materials_growth(2)
          ,Attributes_Fields.InvalidMessage_operations_y1(1)
          ,Attributes_Fields.InvalidMessage_operations_growth(1),Attributes_Fields.InvalidMessage_operations_growth(2)
          ,Attributes_Fields.InvalidMessage_total_paid_average_0t12(1),Attributes_Fields.InvalidMessage_total_paid_average_0t12(2)
          ,Attributes_Fields.InvalidMessage_total_paid_monthspastworst_24(1),Attributes_Fields.InvalidMessage_total_paid_monthspastworst_24(2)
          ,Attributes_Fields.InvalidMessage_total_paid_slope_0t12(1),Attributes_Fields.InvalidMessage_total_paid_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_total_paid_slope_0t6(1),Attributes_Fields.InvalidMessage_total_paid_slope_0t6(2)
          ,Attributes_Fields.InvalidMessage_total_paid_slope_6t12(1),Attributes_Fields.InvalidMessage_total_paid_slope_6t12(2)
          ,Attributes_Fields.InvalidMessage_total_paid_slope_6t18(1),Attributes_Fields.InvalidMessage_total_paid_slope_6t18(2)
          ,Attributes_Fields.InvalidMessage_total_paid_volatility_0t12(1),Attributes_Fields.InvalidMessage_total_paid_volatility_0t12(2)
          ,Attributes_Fields.InvalidMessage_total_paid_volatility_0t6(1),Attributes_Fields.InvalidMessage_total_paid_volatility_0t6(2)
          ,Attributes_Fields.InvalidMessage_total_paid_volatility_12t18(1),Attributes_Fields.InvalidMessage_total_paid_volatility_12t18(2)
          ,Attributes_Fields.InvalidMessage_total_paid_volatility_6t12(1),Attributes_Fields.InvalidMessage_total_paid_volatility_6t12(2)
          ,Attributes_Fields.InvalidMessage_total_spend_monthspastleast_24(1)
          ,Attributes_Fields.InvalidMessage_total_spend_monthspastmost_24(1)
          ,Attributes_Fields.InvalidMessage_total_spend_slope_0t12(1),Attributes_Fields.InvalidMessage_total_spend_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_total_spend_slope_0t24(1),Attributes_Fields.InvalidMessage_total_spend_slope_0t24(2)
          ,Attributes_Fields.InvalidMessage_total_spend_slope_0t6(1),Attributes_Fields.InvalidMessage_total_spend_slope_0t6(2)
          ,Attributes_Fields.InvalidMessage_total_spend_slope_6t12(1),Attributes_Fields.InvalidMessage_total_spend_slope_6t12(2)
          ,Attributes_Fields.InvalidMessage_total_spend_sum_12(1),Attributes_Fields.InvalidMessage_total_spend_sum_12(2)
          ,Attributes_Fields.InvalidMessage_total_spend_volatility_0t12(1),Attributes_Fields.InvalidMessage_total_spend_volatility_0t12(2)
          ,Attributes_Fields.InvalidMessage_total_spend_volatility_0t6(1),Attributes_Fields.InvalidMessage_total_spend_volatility_0t6(2)
          ,Attributes_Fields.InvalidMessage_total_spend_volatility_12t18(1),Attributes_Fields.InvalidMessage_total_spend_volatility_12t18(2)
          ,Attributes_Fields.InvalidMessage_total_spend_volatility_6t12(1),Attributes_Fields.InvalidMessage_total_spend_volatility_6t12(2)
          ,Attributes_Fields.InvalidMessage_mfgmat_paid_average_12(1),Attributes_Fields.InvalidMessage_mfgmat_paid_average_12(2)
          ,Attributes_Fields.InvalidMessage_mfgmat_paid_monthspastworst_24(1)
          ,Attributes_Fields.InvalidMessage_mfgmat_paid_slope_0t12(1),Attributes_Fields.InvalidMessage_mfgmat_paid_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_mfgmat_paid_slope_0t24(1),Attributes_Fields.InvalidMessage_mfgmat_paid_slope_0t24(2)
          ,Attributes_Fields.InvalidMessage_mfgmat_paid_slope_0t6(1),Attributes_Fields.InvalidMessage_mfgmat_paid_slope_0t6(2)
          ,Attributes_Fields.InvalidMessage_mfgmat_paid_volatility_0t12(1),Attributes_Fields.InvalidMessage_mfgmat_paid_volatility_0t12(2)
          ,Attributes_Fields.InvalidMessage_mfgmat_paid_volatility_0t6(1),Attributes_Fields.InvalidMessage_mfgmat_paid_volatility_0t6(2)
          ,Attributes_Fields.InvalidMessage_mfgmat_spend_monthspastleast_24(1)
          ,Attributes_Fields.InvalidMessage_mfgmat_spend_monthspastmost_24(1)
          ,Attributes_Fields.InvalidMessage_mfgmat_spend_slope_0t12(1),Attributes_Fields.InvalidMessage_mfgmat_spend_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_mfgmat_spend_slope_0t24(1),Attributes_Fields.InvalidMessage_mfgmat_spend_slope_0t24(2)
          ,Attributes_Fields.InvalidMessage_mfgmat_spend_slope_0t6(1),Attributes_Fields.InvalidMessage_mfgmat_spend_slope_0t6(2)
          ,Attributes_Fields.InvalidMessage_mfgmat_spend_sum_12(1),Attributes_Fields.InvalidMessage_mfgmat_spend_sum_12(2)
          ,Attributes_Fields.InvalidMessage_mfgmat_spend_volatility_0t6(1),Attributes_Fields.InvalidMessage_mfgmat_spend_volatility_0t6(2)
          ,Attributes_Fields.InvalidMessage_mfgmat_spend_volatility_6t12(1),Attributes_Fields.InvalidMessage_mfgmat_spend_volatility_6t12(2)
          ,Attributes_Fields.InvalidMessage_ops_paid_average_12(1),Attributes_Fields.InvalidMessage_ops_paid_average_12(2)
          ,Attributes_Fields.InvalidMessage_ops_paid_monthspastworst_24(1),Attributes_Fields.InvalidMessage_ops_paid_monthspastworst_24(2)
          ,Attributes_Fields.InvalidMessage_ops_paid_slope_0t12(1),Attributes_Fields.InvalidMessage_ops_paid_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_ops_paid_slope_0t24(1),Attributes_Fields.InvalidMessage_ops_paid_slope_0t24(2)
          ,Attributes_Fields.InvalidMessage_ops_paid_slope_0t6(1),Attributes_Fields.InvalidMessage_ops_paid_slope_0t6(2)
          ,Attributes_Fields.InvalidMessage_ops_paid_volatility_0t12(1),Attributes_Fields.InvalidMessage_ops_paid_volatility_0t12(2)
          ,Attributes_Fields.InvalidMessage_ops_paid_volatility_0t6(1),Attributes_Fields.InvalidMessage_ops_paid_volatility_0t6(2)
          ,Attributes_Fields.InvalidMessage_ops_spend_monthspastleast_24(1)
          ,Attributes_Fields.InvalidMessage_ops_spend_monthspastmost_24(1)
          ,Attributes_Fields.InvalidMessage_ops_spend_slope_0t12(1),Attributes_Fields.InvalidMessage_ops_spend_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_ops_spend_slope_0t24(1),Attributes_Fields.InvalidMessage_ops_spend_slope_0t24(2)
          ,Attributes_Fields.InvalidMessage_ops_spend_slope_0t6(1),Attributes_Fields.InvalidMessage_ops_spend_slope_0t6(2)
          ,Attributes_Fields.InvalidMessage_fleet_paid_monthspastworst_24(1)
          ,Attributes_Fields.InvalidMessage_fleet_paid_slope_0t12(1),Attributes_Fields.InvalidMessage_fleet_paid_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_fleet_paid_slope_0t24(1),Attributes_Fields.InvalidMessage_fleet_paid_slope_0t24(2)
          ,Attributes_Fields.InvalidMessage_fleet_paid_slope_0t6(1),Attributes_Fields.InvalidMessage_fleet_paid_slope_0t6(2)
          ,Attributes_Fields.InvalidMessage_fleet_paid_volatility_0t12(1),Attributes_Fields.InvalidMessage_fleet_paid_volatility_0t12(2)
          ,Attributes_Fields.InvalidMessage_fleet_paid_volatility_0t6(1),Attributes_Fields.InvalidMessage_fleet_paid_volatility_0t6(2)
          ,Attributes_Fields.InvalidMessage_fleet_spend_slope_0t12(1),Attributes_Fields.InvalidMessage_fleet_spend_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_fleet_spend_slope_0t24(1),Attributes_Fields.InvalidMessage_fleet_spend_slope_0t24(2)
          ,Attributes_Fields.InvalidMessage_fleet_spend_slope_0t6(1),Attributes_Fields.InvalidMessage_fleet_spend_slope_0t6(2)
          ,Attributes_Fields.InvalidMessage_carrier_paid_slope_0t12(1),Attributes_Fields.InvalidMessage_carrier_paid_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_carrier_paid_slope_0t24(1),Attributes_Fields.InvalidMessage_carrier_paid_slope_0t24(2)
          ,Attributes_Fields.InvalidMessage_carrier_paid_slope_0t6(1),Attributes_Fields.InvalidMessage_carrier_paid_slope_0t6(2)
          ,Attributes_Fields.InvalidMessage_carrier_paid_volatility_0t12(1),Attributes_Fields.InvalidMessage_carrier_paid_volatility_0t12(2)
          ,Attributes_Fields.InvalidMessage_carrier_paid_volatility_0t6(1),Attributes_Fields.InvalidMessage_carrier_paid_volatility_0t6(2)
          ,Attributes_Fields.InvalidMessage_carrier_spend_slope_0t12(1),Attributes_Fields.InvalidMessage_carrier_spend_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_carrier_spend_slope_0t24(1),Attributes_Fields.InvalidMessage_carrier_spend_slope_0t24(2)
          ,Attributes_Fields.InvalidMessage_carrier_spend_slope_0t6(1),Attributes_Fields.InvalidMessage_carrier_spend_slope_0t6(2)
          ,Attributes_Fields.InvalidMessage_carrier_spend_volatility_0t6(1),Attributes_Fields.InvalidMessage_carrier_spend_volatility_0t6(2)
          ,Attributes_Fields.InvalidMessage_carrier_spend_volatility_6t12(1),Attributes_Fields.InvalidMessage_carrier_spend_volatility_6t12(2)
          ,Attributes_Fields.InvalidMessage_bldgmats_paid_slope_0t12(1),Attributes_Fields.InvalidMessage_bldgmats_paid_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_bldgmats_paid_slope_0t24(1),Attributes_Fields.InvalidMessage_bldgmats_paid_slope_0t24(2)
          ,Attributes_Fields.InvalidMessage_bldgmats_paid_slope_0t6(1),Attributes_Fields.InvalidMessage_bldgmats_paid_slope_0t6(2)
          ,Attributes_Fields.InvalidMessage_bldgmats_paid_volatility_0t12(1),Attributes_Fields.InvalidMessage_bldgmats_paid_volatility_0t12(2)
          ,Attributes_Fields.InvalidMessage_bldgmats_paid_volatility_0t6(1),Attributes_Fields.InvalidMessage_bldgmats_paid_volatility_0t6(2)
          ,Attributes_Fields.InvalidMessage_bldgmats_spend_slope_0t12(1),Attributes_Fields.InvalidMessage_bldgmats_spend_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_bldgmats_spend_slope_0t24(1),Attributes_Fields.InvalidMessage_bldgmats_spend_slope_0t24(2)
          ,Attributes_Fields.InvalidMessage_bldgmats_spend_slope_0t6(1),Attributes_Fields.InvalidMessage_bldgmats_spend_slope_0t6(2)
          ,Attributes_Fields.InvalidMessage_bldgmats_spend_volatility_0t6(1),Attributes_Fields.InvalidMessage_bldgmats_spend_volatility_0t6(2)
          ,Attributes_Fields.InvalidMessage_bldgmats_spend_volatility_6t12(1),Attributes_Fields.InvalidMessage_bldgmats_spend_volatility_6t12(2)
          ,Attributes_Fields.InvalidMessage_top5_paid_slope_0t12(1),Attributes_Fields.InvalidMessage_top5_paid_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_top5_paid_slope_0t24(1),Attributes_Fields.InvalidMessage_top5_paid_slope_0t24(2)
          ,Attributes_Fields.InvalidMessage_top5_paid_slope_0t6(1),Attributes_Fields.InvalidMessage_top5_paid_slope_0t6(2)
          ,Attributes_Fields.InvalidMessage_top5_paid_volatility_0t12(1),Attributes_Fields.InvalidMessage_top5_paid_volatility_0t12(2)
          ,Attributes_Fields.InvalidMessage_top5_paid_volatility_0t6(1),Attributes_Fields.InvalidMessage_top5_paid_volatility_0t6(2)
          ,Attributes_Fields.InvalidMessage_top5_spend_slope_0t12(1),Attributes_Fields.InvalidMessage_top5_spend_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_top5_spend_slope_0t24(1),Attributes_Fields.InvalidMessage_top5_spend_slope_0t24(2)
          ,Attributes_Fields.InvalidMessage_top5_spend_slope_0t6(1),Attributes_Fields.InvalidMessage_top5_spend_slope_0t6(2)
          ,Attributes_Fields.InvalidMessage_top5_spend_volatility_0t6(1),Attributes_Fields.InvalidMessage_top5_spend_volatility_0t6(2)
          ,Attributes_Fields.InvalidMessage_top5_spend_volatility_6t12(1),Attributes_Fields.InvalidMessage_top5_spend_volatility_6t12(2)
          ,Attributes_Fields.InvalidMessage_total_numrel_slope_0t12(1),Attributes_Fields.InvalidMessage_total_numrel_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_total_numrel_slope_0t24(1),Attributes_Fields.InvalidMessage_total_numrel_slope_0t24(2)
          ,Attributes_Fields.InvalidMessage_total_numrel_slope_0t6(1),Attributes_Fields.InvalidMessage_total_numrel_slope_0t6(2)
          ,Attributes_Fields.InvalidMessage_total_numrel_slope_6t12(1),Attributes_Fields.InvalidMessage_total_numrel_slope_6t12(2)
          ,Attributes_Fields.InvalidMessage_mfgmat_numrel_slope_0t12(1),Attributes_Fields.InvalidMessage_mfgmat_numrel_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_mfgmat_numrel_slope_0t24(1),Attributes_Fields.InvalidMessage_mfgmat_numrel_slope_0t24(2)
          ,Attributes_Fields.InvalidMessage_mfgmat_numrel_slope_0t6(1),Attributes_Fields.InvalidMessage_mfgmat_numrel_slope_0t6(2)
          ,Attributes_Fields.InvalidMessage_mfgmat_numrel_slope_6t12(1),Attributes_Fields.InvalidMessage_mfgmat_numrel_slope_6t12(2)
          ,Attributes_Fields.InvalidMessage_ops_numrel_slope_0t12(1),Attributes_Fields.InvalidMessage_ops_numrel_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_ops_numrel_slope_0t24(1),Attributes_Fields.InvalidMessage_ops_numrel_slope_0t24(2)
          ,Attributes_Fields.InvalidMessage_ops_numrel_slope_0t6(1),Attributes_Fields.InvalidMessage_ops_numrel_slope_0t6(2)
          ,Attributes_Fields.InvalidMessage_ops_numrel_slope_6t12(1),Attributes_Fields.InvalidMessage_ops_numrel_slope_6t12(2)
          ,Attributes_Fields.InvalidMessage_fleet_numrel_slope_0t12(1),Attributes_Fields.InvalidMessage_fleet_numrel_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_fleet_numrel_slope_0t24(1),Attributes_Fields.InvalidMessage_fleet_numrel_slope_0t24(2)
          ,Attributes_Fields.InvalidMessage_fleet_numrel_slope_0t6(1),Attributes_Fields.InvalidMessage_fleet_numrel_slope_0t6(2)
          ,Attributes_Fields.InvalidMessage_fleet_numrel_slope_6t12(1),Attributes_Fields.InvalidMessage_fleet_numrel_slope_6t12(2)
          ,Attributes_Fields.InvalidMessage_carrier_numrel_slope_0t12(1),Attributes_Fields.InvalidMessage_carrier_numrel_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_carrier_numrel_slope_0t24(1),Attributes_Fields.InvalidMessage_carrier_numrel_slope_0t24(2)
          ,Attributes_Fields.InvalidMessage_carrier_numrel_slope_0t6(1),Attributes_Fields.InvalidMessage_carrier_numrel_slope_0t6(2)
          ,Attributes_Fields.InvalidMessage_carrier_numrel_slope_6t12(1),Attributes_Fields.InvalidMessage_carrier_numrel_slope_6t12(2)
          ,Attributes_Fields.InvalidMessage_bldgmats_numrel_slope_0t12(1),Attributes_Fields.InvalidMessage_bldgmats_numrel_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_bldgmats_numrel_slope_0t24(1),Attributes_Fields.InvalidMessage_bldgmats_numrel_slope_0t24(2)
          ,Attributes_Fields.InvalidMessage_bldgmats_numrel_slope_0t6(1),Attributes_Fields.InvalidMessage_bldgmats_numrel_slope_0t6(2)
          ,Attributes_Fields.InvalidMessage_bldgmats_numrel_slope_6t12(1),Attributes_Fields.InvalidMessage_bldgmats_numrel_slope_6t12(2)
          ,Attributes_Fields.InvalidMessage_bldgmats_numrel_var_0t12(1),Attributes_Fields.InvalidMessage_bldgmats_numrel_var_0t12(2)
          ,Attributes_Fields.InvalidMessage_bldgmats_numrel_var_12t24(1),Attributes_Fields.InvalidMessage_bldgmats_numrel_var_12t24(2)
          ,Attributes_Fields.InvalidMessage_total_percprov30_slope_0t12(1),Attributes_Fields.InvalidMessage_total_percprov30_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_total_percprov30_slope_0t24(1),Attributes_Fields.InvalidMessage_total_percprov30_slope_0t24(2)
          ,Attributes_Fields.InvalidMessage_total_percprov30_slope_0t6(1),Attributes_Fields.InvalidMessage_total_percprov30_slope_0t6(2)
          ,Attributes_Fields.InvalidMessage_total_percprov30_slope_6t12(1),Attributes_Fields.InvalidMessage_total_percprov30_slope_6t12(2)
          ,Attributes_Fields.InvalidMessage_total_percprov60_slope_0t12(1),Attributes_Fields.InvalidMessage_total_percprov60_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_total_percprov60_slope_0t24(1),Attributes_Fields.InvalidMessage_total_percprov60_slope_0t24(2)
          ,Attributes_Fields.InvalidMessage_total_percprov60_slope_0t6(1),Attributes_Fields.InvalidMessage_total_percprov60_slope_0t6(2)
          ,Attributes_Fields.InvalidMessage_total_percprov60_slope_6t12(1),Attributes_Fields.InvalidMessage_total_percprov60_slope_6t12(2)
          ,Attributes_Fields.InvalidMessage_total_percprov90_slope_0t24(1),Attributes_Fields.InvalidMessage_total_percprov90_slope_0t24(2)
          ,Attributes_Fields.InvalidMessage_total_percprov90_slope_0t6(1),Attributes_Fields.InvalidMessage_total_percprov90_slope_0t6(2)
          ,Attributes_Fields.InvalidMessage_total_percprov90_slope_6t12(1),Attributes_Fields.InvalidMessage_total_percprov90_slope_6t12(2)
          ,Attributes_Fields.InvalidMessage_mfgmat_percprov30_slope_0t12(1),Attributes_Fields.InvalidMessage_mfgmat_percprov30_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_mfgmat_percprov30_slope_6t12(1),Attributes_Fields.InvalidMessage_mfgmat_percprov30_slope_6t12(2)
          ,Attributes_Fields.InvalidMessage_mfgmat_percprov60_slope_0t12(1),Attributes_Fields.InvalidMessage_mfgmat_percprov60_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_mfgmat_percprov60_slope_6t12(1),Attributes_Fields.InvalidMessage_mfgmat_percprov60_slope_6t12(2)
          ,Attributes_Fields.InvalidMessage_mfgmat_percprov90_slope_0t24(1),Attributes_Fields.InvalidMessage_mfgmat_percprov90_slope_0t24(2)
          ,Attributes_Fields.InvalidMessage_mfgmat_percprov90_slope_0t6(1),Attributes_Fields.InvalidMessage_mfgmat_percprov90_slope_0t6(2)
          ,Attributes_Fields.InvalidMessage_mfgmat_percprov90_slope_6t12(1),Attributes_Fields.InvalidMessage_mfgmat_percprov90_slope_6t12(2)
          ,Attributes_Fields.InvalidMessage_ops_percprov30_slope_0t12(1),Attributes_Fields.InvalidMessage_ops_percprov30_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_ops_percprov30_slope_6t12(1),Attributes_Fields.InvalidMessage_ops_percprov30_slope_6t12(2)
          ,Attributes_Fields.InvalidMessage_ops_percprov60_slope_0t12(1),Attributes_Fields.InvalidMessage_ops_percprov60_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_ops_percprov60_slope_6t12(1),Attributes_Fields.InvalidMessage_ops_percprov60_slope_6t12(2)
          ,Attributes_Fields.InvalidMessage_ops_percprov90_slope_0t24(1),Attributes_Fields.InvalidMessage_ops_percprov90_slope_0t24(2)
          ,Attributes_Fields.InvalidMessage_ops_percprov90_slope_0t6(1),Attributes_Fields.InvalidMessage_ops_percprov90_slope_0t6(2)
          ,Attributes_Fields.InvalidMessage_ops_percprov90_slope_6t12(1),Attributes_Fields.InvalidMessage_ops_percprov90_slope_6t12(2)
          ,Attributes_Fields.InvalidMessage_fleet_percprov30_slope_0t12(1),Attributes_Fields.InvalidMessage_fleet_percprov30_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_fleet_percprov30_slope_6t12(1),Attributes_Fields.InvalidMessage_fleet_percprov30_slope_6t12(2)
          ,Attributes_Fields.InvalidMessage_fleet_percprov60_slope_0t12(1),Attributes_Fields.InvalidMessage_fleet_percprov60_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_fleet_percprov60_slope_6t12(1),Attributes_Fields.InvalidMessage_fleet_percprov60_slope_6t12(2)
          ,Attributes_Fields.InvalidMessage_fleet_percprov90_slope_0t24(1),Attributes_Fields.InvalidMessage_fleet_percprov90_slope_0t24(2)
          ,Attributes_Fields.InvalidMessage_fleet_percprov90_slope_0t6(1),Attributes_Fields.InvalidMessage_fleet_percprov90_slope_0t6(2)
          ,Attributes_Fields.InvalidMessage_fleet_percprov90_slope_6t12(1),Attributes_Fields.InvalidMessage_fleet_percprov90_slope_6t12(2)
          ,Attributes_Fields.InvalidMessage_carrier_percprov30_slope_0t12(1),Attributes_Fields.InvalidMessage_carrier_percprov30_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_carrier_percprov30_slope_6t12(1),Attributes_Fields.InvalidMessage_carrier_percprov30_slope_6t12(2)
          ,Attributes_Fields.InvalidMessage_carrier_percprov60_slope_0t12(1),Attributes_Fields.InvalidMessage_carrier_percprov60_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_carrier_percprov60_slope_6t12(1),Attributes_Fields.InvalidMessage_carrier_percprov60_slope_6t12(2)
          ,Attributes_Fields.InvalidMessage_carrier_percprov90_slope_0t24(1),Attributes_Fields.InvalidMessage_carrier_percprov90_slope_0t24(2)
          ,Attributes_Fields.InvalidMessage_carrier_percprov90_slope_0t6(1),Attributes_Fields.InvalidMessage_carrier_percprov90_slope_0t6(2)
          ,Attributes_Fields.InvalidMessage_carrier_percprov90_slope_6t12(1),Attributes_Fields.InvalidMessage_carrier_percprov90_slope_6t12(2)
          ,Attributes_Fields.InvalidMessage_bldgmats_percprov30_slope_0t12(1),Attributes_Fields.InvalidMessage_bldgmats_percprov30_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_bldgmats_percprov30_slope_6t12(1),Attributes_Fields.InvalidMessage_bldgmats_percprov30_slope_6t12(2)
          ,Attributes_Fields.InvalidMessage_bldgmats_percprov60_slope_0t12(1),Attributes_Fields.InvalidMessage_bldgmats_percprov60_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_bldgmats_percprov60_slope_6t12(1),Attributes_Fields.InvalidMessage_bldgmats_percprov60_slope_6t12(2)
          ,Attributes_Fields.InvalidMessage_bldgmats_percprov90_slope_0t24(1),Attributes_Fields.InvalidMessage_bldgmats_percprov90_slope_0t24(2)
          ,Attributes_Fields.InvalidMessage_bldgmats_percprov90_slope_0t6(1),Attributes_Fields.InvalidMessage_bldgmats_percprov90_slope_0t6(2)
          ,Attributes_Fields.InvalidMessage_bldgmats_percprov90_slope_6t12(1),Attributes_Fields.InvalidMessage_bldgmats_percprov90_slope_6t12(2)
          ,Attributes_Fields.InvalidMessage_top5_percprov30_slope_0t12(1),Attributes_Fields.InvalidMessage_top5_percprov30_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_top5_percprov30_slope_6t12(1),Attributes_Fields.InvalidMessage_top5_percprov30_slope_6t12(2)
          ,Attributes_Fields.InvalidMessage_top5_percprov60_slope_0t12(1),Attributes_Fields.InvalidMessage_top5_percprov60_slope_0t12(2)
          ,Attributes_Fields.InvalidMessage_top5_percprov60_slope_6t12(1),Attributes_Fields.InvalidMessage_top5_percprov60_slope_6t12(2)
          ,Attributes_Fields.InvalidMessage_top5_percprov90_slope_0t24(1),Attributes_Fields.InvalidMessage_top5_percprov90_slope_0t24(2)
          ,Attributes_Fields.InvalidMessage_top5_percprov90_slope_0t6(1),Attributes_Fields.InvalidMessage_top5_percprov90_slope_0t6(2)
          ,Attributes_Fields.InvalidMessage_top5_percprov90_slope_6t12(1),Attributes_Fields.InvalidMessage_top5_percprov90_slope_6t12(2)
          ,Attributes_Fields.InvalidMessage_top5_percprovoutstanding_adjustedslope_0t12(1),Attributes_Fields.InvalidMessage_top5_percprovoutstanding_adjustedslope_0t12(2)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.ultimate_linkid_ALLOW_ErrorCount
          ,le.cortera_score_ALLOW_ErrorCount
          ,le.cpr_score_ALLOW_ErrorCount
          ,le.cpr_segment_ALLOW_ErrorCount
          ,le.dbt_ALLOW_ErrorCount,le.dbt_LENGTHS_ErrorCount
          ,le.avg_bal_ALLOW_ErrorCount
          ,le.air_spend_ALLOW_ErrorCount
          ,le.fuel_spend_ALLOW_ErrorCount
          ,le.leasing_spend_ALLOW_ErrorCount
          ,le.ltl_spend_ALLOW_ErrorCount
          ,le.rail_spend_ALLOW_ErrorCount
          ,le.tl_spend_ALLOW_ErrorCount
          ,le.transvc_spend_ALLOW_ErrorCount
          ,le.transup_spend_ALLOW_ErrorCount
          ,le.bst_spend_ALLOW_ErrorCount
          ,le.dg_spend_ALLOW_ErrorCount
          ,le.electrical_spend_ALLOW_ErrorCount
          ,le.hvac_spend_ALLOW_ErrorCount
          ,le.other_b_spend_ALLOW_ErrorCount
          ,le.plumbing_spend_ALLOW_ErrorCount
          ,le.rs_spend_ALLOW_ErrorCount
          ,le.wp_spend_ALLOW_ErrorCount
          ,le.chemical_spend_ALLOW_ErrorCount
          ,le.electronic_spend_ALLOW_ErrorCount
          ,le.metal_spend_ALLOW_ErrorCount
          ,le.other_m_spend_ALLOW_ErrorCount
          ,le.packaging_spend_ALLOW_ErrorCount
          ,le.pvf_spend_ALLOW_ErrorCount
          ,le.plastic_spend_ALLOW_ErrorCount
          ,le.textile_spend_ALLOW_ErrorCount
          ,le.bs_spend_ALLOW_ErrorCount
          ,le.ce_spend_ALLOW_ErrorCount
          ,le.hardware_spend_ALLOW_ErrorCount
          ,le.ie_spend_ALLOW_ErrorCount
          ,le.is_spend_ALLOW_ErrorCount
          ,le.it_spend_ALLOW_ErrorCount
          ,le.mls_spend_ALLOW_ErrorCount
          ,le.os_spend_ALLOW_ErrorCount
          ,le.pp_spend_ALLOW_ErrorCount
          ,le.sis_spend_ALLOW_ErrorCount
          ,le.apparel_spend_ALLOW_ErrorCount
          ,le.beverages_spend_ALLOW_ErrorCount
          ,le.constr_spend_ALLOW_ErrorCount
          ,le.consulting_spend_ALLOW_ErrorCount
          ,le.fs_spend_ALLOW_ErrorCount
          ,le.fp_spend_ALLOW_ErrorCount
          ,le.insurance_spend_ALLOW_ErrorCount
          ,le.ls_spend_ALLOW_ErrorCount
          ,le.oil_gas_spend_ALLOW_ErrorCount
          ,le.utilities_spend_ALLOW_ErrorCount
          ,le.other_spend_ALLOW_ErrorCount
          ,le.advt_spend_ALLOW_ErrorCount
          ,le.air_growth_ALLOW_ErrorCount,le.air_growth_LENGTHS_ErrorCount
          ,le.fuel_growth_ALLOW_ErrorCount,le.fuel_growth_LENGTHS_ErrorCount
          ,le.leasing_growth_ALLOW_ErrorCount,le.leasing_growth_LENGTHS_ErrorCount
          ,le.ltl_growth_ALLOW_ErrorCount,le.ltl_growth_LENGTHS_ErrorCount
          ,le.rail_growth_ALLOW_ErrorCount,le.rail_growth_LENGTHS_ErrorCount
          ,le.tl_growth_ALLOW_ErrorCount,le.tl_growth_LENGTHS_ErrorCount
          ,le.transvc_growth_ALLOW_ErrorCount,le.transvc_growth_LENGTHS_ErrorCount
          ,le.transup_growth_ALLOW_ErrorCount,le.transup_growth_LENGTHS_ErrorCount
          ,le.bst_growth_ALLOW_ErrorCount,le.bst_growth_LENGTHS_ErrorCount
          ,le.dg_growth_ALLOW_ErrorCount,le.dg_growth_LENGTHS_ErrorCount
          ,le.electrical_growth_ALLOW_ErrorCount,le.electrical_growth_LENGTHS_ErrorCount
          ,le.hvac_growth_ALLOW_ErrorCount,le.hvac_growth_LENGTHS_ErrorCount
          ,le.other_b_growth_ALLOW_ErrorCount,le.other_b_growth_LENGTHS_ErrorCount
          ,le.plumbing_growth_ALLOW_ErrorCount,le.plumbing_growth_LENGTHS_ErrorCount
          ,le.rs_growth_ALLOW_ErrorCount,le.rs_growth_LENGTHS_ErrorCount
          ,le.wp_growth_ALLOW_ErrorCount,le.wp_growth_LENGTHS_ErrorCount
          ,le.chemical_growth_ALLOW_ErrorCount,le.chemical_growth_LENGTHS_ErrorCount
          ,le.electronic_growth_ALLOW_ErrorCount,le.electronic_growth_LENGTHS_ErrorCount
          ,le.metal_growth_ALLOW_ErrorCount,le.metal_growth_LENGTHS_ErrorCount
          ,le.other_m_growth_ALLOW_ErrorCount,le.other_m_growth_LENGTHS_ErrorCount
          ,le.packaging_growth_ALLOW_ErrorCount,le.packaging_growth_LENGTHS_ErrorCount
          ,le.pvf_growth_ALLOW_ErrorCount,le.pvf_growth_LENGTHS_ErrorCount
          ,le.plastic_growth_ALLOW_ErrorCount,le.plastic_growth_LENGTHS_ErrorCount
          ,le.textile_growth_ALLOW_ErrorCount,le.textile_growth_LENGTHS_ErrorCount
          ,le.bs_growth_ALLOW_ErrorCount,le.bs_growth_LENGTHS_ErrorCount
          ,le.ce_growth_ALLOW_ErrorCount,le.ce_growth_LENGTHS_ErrorCount
          ,le.hardware_growth_ALLOW_ErrorCount,le.hardware_growth_LENGTHS_ErrorCount
          ,le.ie_growth_ALLOW_ErrorCount,le.ie_growth_LENGTHS_ErrorCount
          ,le.is_growth_ALLOW_ErrorCount,le.is_growth_LENGTHS_ErrorCount
          ,le.it_growth_ALLOW_ErrorCount,le.it_growth_LENGTHS_ErrorCount
          ,le.mls_growth_ALLOW_ErrorCount,le.mls_growth_LENGTHS_ErrorCount
          ,le.os_growth_ALLOW_ErrorCount,le.os_growth_LENGTHS_ErrorCount
          ,le.pp_growth_ALLOW_ErrorCount,le.pp_growth_LENGTHS_ErrorCount
          ,le.sis_growth_ALLOW_ErrorCount,le.sis_growth_LENGTHS_ErrorCount
          ,le.apparel_growth_ALLOW_ErrorCount,le.apparel_growth_LENGTHS_ErrorCount
          ,le.beverages_growth_ALLOW_ErrorCount,le.beverages_growth_LENGTHS_ErrorCount
          ,le.constr_growth_ALLOW_ErrorCount,le.constr_growth_LENGTHS_ErrorCount
          ,le.consulting_growth_ALLOW_ErrorCount,le.consulting_growth_LENGTHS_ErrorCount
          ,le.fs_growth_ALLOW_ErrorCount,le.fs_growth_LENGTHS_ErrorCount
          ,le.fp_growth_ALLOW_ErrorCount,le.fp_growth_LENGTHS_ErrorCount
          ,le.insurance_growth_ALLOW_ErrorCount,le.insurance_growth_LENGTHS_ErrorCount
          ,le.ls_growth_ALLOW_ErrorCount,le.ls_growth_LENGTHS_ErrorCount
          ,le.oil_gas_growth_ALLOW_ErrorCount,le.oil_gas_growth_LENGTHS_ErrorCount
          ,le.utilities_growth_ALLOW_ErrorCount,le.utilities_growth_LENGTHS_ErrorCount
          ,le.other_growth_ALLOW_ErrorCount,le.other_growth_LENGTHS_ErrorCount
          ,le.advt_growth_ALLOW_ErrorCount,le.advt_growth_LENGTHS_ErrorCount
          ,le.top5_growth_ALLOW_ErrorCount,le.top5_growth_LENGTHS_ErrorCount
          ,le.shipping_y1_ALLOW_ErrorCount
          ,le.shipping_growth_ALLOW_ErrorCount,le.shipping_growth_LENGTHS_ErrorCount
          ,le.materials_y1_ALLOW_ErrorCount
          ,le.materials_growth_ALLOW_ErrorCount,le.materials_growth_LENGTHS_ErrorCount
          ,le.operations_y1_ALLOW_ErrorCount
          ,le.operations_growth_ALLOW_ErrorCount,le.operations_growth_LENGTHS_ErrorCount
          ,le.total_paid_average_0t12_ALLOW_ErrorCount,le.total_paid_average_0t12_LENGTHS_ErrorCount
          ,le.total_paid_monthspastworst_24_ALLOW_ErrorCount,le.total_paid_monthspastworst_24_LENGTHS_ErrorCount
          ,le.total_paid_slope_0t12_ALLOW_ErrorCount,le.total_paid_slope_0t12_LENGTHS_ErrorCount
          ,le.total_paid_slope_0t6_ALLOW_ErrorCount,le.total_paid_slope_0t6_LENGTHS_ErrorCount
          ,le.total_paid_slope_6t12_ALLOW_ErrorCount,le.total_paid_slope_6t12_LENGTHS_ErrorCount
          ,le.total_paid_slope_6t18_ALLOW_ErrorCount,le.total_paid_slope_6t18_LENGTHS_ErrorCount
          ,le.total_paid_volatility_0t12_ALLOW_ErrorCount,le.total_paid_volatility_0t12_LENGTHS_ErrorCount
          ,le.total_paid_volatility_0t6_ALLOW_ErrorCount,le.total_paid_volatility_0t6_LENGTHS_ErrorCount
          ,le.total_paid_volatility_12t18_ALLOW_ErrorCount,le.total_paid_volatility_12t18_LENGTHS_ErrorCount
          ,le.total_paid_volatility_6t12_ALLOW_ErrorCount,le.total_paid_volatility_6t12_LENGTHS_ErrorCount
          ,le.total_spend_monthspastleast_24_ALLOW_ErrorCount
          ,le.total_spend_monthspastmost_24_ALLOW_ErrorCount
          ,le.total_spend_slope_0t12_ALLOW_ErrorCount,le.total_spend_slope_0t12_LENGTHS_ErrorCount
          ,le.total_spend_slope_0t24_ALLOW_ErrorCount,le.total_spend_slope_0t24_LENGTHS_ErrorCount
          ,le.total_spend_slope_0t6_ALLOW_ErrorCount,le.total_spend_slope_0t6_LENGTHS_ErrorCount
          ,le.total_spend_slope_6t12_ALLOW_ErrorCount,le.total_spend_slope_6t12_LENGTHS_ErrorCount
          ,le.total_spend_sum_12_ALLOW_ErrorCount,le.total_spend_sum_12_LENGTHS_ErrorCount
          ,le.total_spend_volatility_0t12_ALLOW_ErrorCount,le.total_spend_volatility_0t12_LENGTHS_ErrorCount
          ,le.total_spend_volatility_0t6_ALLOW_ErrorCount,le.total_spend_volatility_0t6_LENGTHS_ErrorCount
          ,le.total_spend_volatility_12t18_ALLOW_ErrorCount,le.total_spend_volatility_12t18_LENGTHS_ErrorCount
          ,le.total_spend_volatility_6t12_ALLOW_ErrorCount,le.total_spend_volatility_6t12_LENGTHS_ErrorCount
          ,le.mfgmat_paid_average_12_ALLOW_ErrorCount,le.mfgmat_paid_average_12_LENGTHS_ErrorCount
          ,le.mfgmat_paid_monthspastworst_24_ALLOW_ErrorCount
          ,le.mfgmat_paid_slope_0t12_ALLOW_ErrorCount,le.mfgmat_paid_slope_0t12_LENGTHS_ErrorCount
          ,le.mfgmat_paid_slope_0t24_ALLOW_ErrorCount,le.mfgmat_paid_slope_0t24_LENGTHS_ErrorCount
          ,le.mfgmat_paid_slope_0t6_ALLOW_ErrorCount,le.mfgmat_paid_slope_0t6_LENGTHS_ErrorCount
          ,le.mfgmat_paid_volatility_0t12_ALLOW_ErrorCount,le.mfgmat_paid_volatility_0t12_LENGTHS_ErrorCount
          ,le.mfgmat_paid_volatility_0t6_ALLOW_ErrorCount,le.mfgmat_paid_volatility_0t6_LENGTHS_ErrorCount
          ,le.mfgmat_spend_monthspastleast_24_ALLOW_ErrorCount
          ,le.mfgmat_spend_monthspastmost_24_ALLOW_ErrorCount
          ,le.mfgmat_spend_slope_0t12_ALLOW_ErrorCount,le.mfgmat_spend_slope_0t12_LENGTHS_ErrorCount
          ,le.mfgmat_spend_slope_0t24_ALLOW_ErrorCount,le.mfgmat_spend_slope_0t24_LENGTHS_ErrorCount
          ,le.mfgmat_spend_slope_0t6_ALLOW_ErrorCount,le.mfgmat_spend_slope_0t6_LENGTHS_ErrorCount
          ,le.mfgmat_spend_sum_12_ALLOW_ErrorCount,le.mfgmat_spend_sum_12_LENGTHS_ErrorCount
          ,le.mfgmat_spend_volatility_0t6_ALLOW_ErrorCount,le.mfgmat_spend_volatility_0t6_LENGTHS_ErrorCount
          ,le.mfgmat_spend_volatility_6t12_ALLOW_ErrorCount,le.mfgmat_spend_volatility_6t12_LENGTHS_ErrorCount
          ,le.ops_paid_average_12_ALLOW_ErrorCount,le.ops_paid_average_12_LENGTHS_ErrorCount
          ,le.ops_paid_monthspastworst_24_ALLOW_ErrorCount,le.ops_paid_monthspastworst_24_LENGTHS_ErrorCount
          ,le.ops_paid_slope_0t12_ALLOW_ErrorCount,le.ops_paid_slope_0t12_LENGTHS_ErrorCount
          ,le.ops_paid_slope_0t24_ALLOW_ErrorCount,le.ops_paid_slope_0t24_LENGTHS_ErrorCount
          ,le.ops_paid_slope_0t6_ALLOW_ErrorCount,le.ops_paid_slope_0t6_LENGTHS_ErrorCount
          ,le.ops_paid_volatility_0t12_ALLOW_ErrorCount,le.ops_paid_volatility_0t12_LENGTHS_ErrorCount
          ,le.ops_paid_volatility_0t6_ALLOW_ErrorCount,le.ops_paid_volatility_0t6_LENGTHS_ErrorCount
          ,le.ops_spend_monthspastleast_24_ALLOW_ErrorCount
          ,le.ops_spend_monthspastmost_24_ALLOW_ErrorCount
          ,le.ops_spend_slope_0t12_ALLOW_ErrorCount,le.ops_spend_slope_0t12_LENGTHS_ErrorCount
          ,le.ops_spend_slope_0t24_ALLOW_ErrorCount,le.ops_spend_slope_0t24_LENGTHS_ErrorCount
          ,le.ops_spend_slope_0t6_ALLOW_ErrorCount,le.ops_spend_slope_0t6_LENGTHS_ErrorCount
          ,le.fleet_paid_monthspastworst_24_ALLOW_ErrorCount
          ,le.fleet_paid_slope_0t12_ALLOW_ErrorCount,le.fleet_paid_slope_0t12_LENGTHS_ErrorCount
          ,le.fleet_paid_slope_0t24_ALLOW_ErrorCount,le.fleet_paid_slope_0t24_LENGTHS_ErrorCount
          ,le.fleet_paid_slope_0t6_ALLOW_ErrorCount,le.fleet_paid_slope_0t6_LENGTHS_ErrorCount
          ,le.fleet_paid_volatility_0t12_ALLOW_ErrorCount,le.fleet_paid_volatility_0t12_LENGTHS_ErrorCount
          ,le.fleet_paid_volatility_0t6_ALLOW_ErrorCount,le.fleet_paid_volatility_0t6_LENGTHS_ErrorCount
          ,le.fleet_spend_slope_0t12_ALLOW_ErrorCount,le.fleet_spend_slope_0t12_LENGTHS_ErrorCount
          ,le.fleet_spend_slope_0t24_ALLOW_ErrorCount,le.fleet_spend_slope_0t24_LENGTHS_ErrorCount
          ,le.fleet_spend_slope_0t6_ALLOW_ErrorCount,le.fleet_spend_slope_0t6_LENGTHS_ErrorCount
          ,le.carrier_paid_slope_0t12_ALLOW_ErrorCount,le.carrier_paid_slope_0t12_LENGTHS_ErrorCount
          ,le.carrier_paid_slope_0t24_ALLOW_ErrorCount,le.carrier_paid_slope_0t24_LENGTHS_ErrorCount
          ,le.carrier_paid_slope_0t6_ALLOW_ErrorCount,le.carrier_paid_slope_0t6_LENGTHS_ErrorCount
          ,le.carrier_paid_volatility_0t12_ALLOW_ErrorCount,le.carrier_paid_volatility_0t12_LENGTHS_ErrorCount
          ,le.carrier_paid_volatility_0t6_ALLOW_ErrorCount,le.carrier_paid_volatility_0t6_LENGTHS_ErrorCount
          ,le.carrier_spend_slope_0t12_ALLOW_ErrorCount,le.carrier_spend_slope_0t12_LENGTHS_ErrorCount
          ,le.carrier_spend_slope_0t24_ALLOW_ErrorCount,le.carrier_spend_slope_0t24_LENGTHS_ErrorCount
          ,le.carrier_spend_slope_0t6_ALLOW_ErrorCount,le.carrier_spend_slope_0t6_LENGTHS_ErrorCount
          ,le.carrier_spend_volatility_0t6_ALLOW_ErrorCount,le.carrier_spend_volatility_0t6_LENGTHS_ErrorCount
          ,le.carrier_spend_volatility_6t12_ALLOW_ErrorCount,le.carrier_spend_volatility_6t12_LENGTHS_ErrorCount
          ,le.bldgmats_paid_slope_0t12_ALLOW_ErrorCount,le.bldgmats_paid_slope_0t12_LENGTHS_ErrorCount
          ,le.bldgmats_paid_slope_0t24_ALLOW_ErrorCount,le.bldgmats_paid_slope_0t24_LENGTHS_ErrorCount
          ,le.bldgmats_paid_slope_0t6_ALLOW_ErrorCount,le.bldgmats_paid_slope_0t6_LENGTHS_ErrorCount
          ,le.bldgmats_paid_volatility_0t12_ALLOW_ErrorCount,le.bldgmats_paid_volatility_0t12_LENGTHS_ErrorCount
          ,le.bldgmats_paid_volatility_0t6_ALLOW_ErrorCount,le.bldgmats_paid_volatility_0t6_LENGTHS_ErrorCount
          ,le.bldgmats_spend_slope_0t12_ALLOW_ErrorCount,le.bldgmats_spend_slope_0t12_LENGTHS_ErrorCount
          ,le.bldgmats_spend_slope_0t24_ALLOW_ErrorCount,le.bldgmats_spend_slope_0t24_LENGTHS_ErrorCount
          ,le.bldgmats_spend_slope_0t6_ALLOW_ErrorCount,le.bldgmats_spend_slope_0t6_LENGTHS_ErrorCount
          ,le.bldgmats_spend_volatility_0t6_ALLOW_ErrorCount,le.bldgmats_spend_volatility_0t6_LENGTHS_ErrorCount
          ,le.bldgmats_spend_volatility_6t12_ALLOW_ErrorCount,le.bldgmats_spend_volatility_6t12_LENGTHS_ErrorCount
          ,le.top5_paid_slope_0t12_ALLOW_ErrorCount,le.top5_paid_slope_0t12_LENGTHS_ErrorCount
          ,le.top5_paid_slope_0t24_ALLOW_ErrorCount,le.top5_paid_slope_0t24_LENGTHS_ErrorCount
          ,le.top5_paid_slope_0t6_ALLOW_ErrorCount,le.top5_paid_slope_0t6_LENGTHS_ErrorCount
          ,le.top5_paid_volatility_0t12_ALLOW_ErrorCount,le.top5_paid_volatility_0t12_LENGTHS_ErrorCount
          ,le.top5_paid_volatility_0t6_ALLOW_ErrorCount,le.top5_paid_volatility_0t6_LENGTHS_ErrorCount
          ,le.top5_spend_slope_0t12_ALLOW_ErrorCount,le.top5_spend_slope_0t12_LENGTHS_ErrorCount
          ,le.top5_spend_slope_0t24_ALLOW_ErrorCount,le.top5_spend_slope_0t24_LENGTHS_ErrorCount
          ,le.top5_spend_slope_0t6_ALLOW_ErrorCount,le.top5_spend_slope_0t6_LENGTHS_ErrorCount
          ,le.top5_spend_volatility_0t6_ALLOW_ErrorCount,le.top5_spend_volatility_0t6_LENGTHS_ErrorCount
          ,le.top5_spend_volatility_6t12_ALLOW_ErrorCount,le.top5_spend_volatility_6t12_LENGTHS_ErrorCount
          ,le.total_numrel_slope_0t12_ALLOW_ErrorCount,le.total_numrel_slope_0t12_LENGTHS_ErrorCount
          ,le.total_numrel_slope_0t24_ALLOW_ErrorCount,le.total_numrel_slope_0t24_LENGTHS_ErrorCount
          ,le.total_numrel_slope_0t6_ALLOW_ErrorCount,le.total_numrel_slope_0t6_LENGTHS_ErrorCount
          ,le.total_numrel_slope_6t12_ALLOW_ErrorCount,le.total_numrel_slope_6t12_LENGTHS_ErrorCount
          ,le.mfgmat_numrel_slope_0t12_ALLOW_ErrorCount,le.mfgmat_numrel_slope_0t12_LENGTHS_ErrorCount
          ,le.mfgmat_numrel_slope_0t24_ALLOW_ErrorCount,le.mfgmat_numrel_slope_0t24_LENGTHS_ErrorCount
          ,le.mfgmat_numrel_slope_0t6_ALLOW_ErrorCount,le.mfgmat_numrel_slope_0t6_LENGTHS_ErrorCount
          ,le.mfgmat_numrel_slope_6t12_ALLOW_ErrorCount,le.mfgmat_numrel_slope_6t12_LENGTHS_ErrorCount
          ,le.ops_numrel_slope_0t12_ALLOW_ErrorCount,le.ops_numrel_slope_0t12_LENGTHS_ErrorCount
          ,le.ops_numrel_slope_0t24_ALLOW_ErrorCount,le.ops_numrel_slope_0t24_LENGTHS_ErrorCount
          ,le.ops_numrel_slope_0t6_ALLOW_ErrorCount,le.ops_numrel_slope_0t6_LENGTHS_ErrorCount
          ,le.ops_numrel_slope_6t12_ALLOW_ErrorCount,le.ops_numrel_slope_6t12_LENGTHS_ErrorCount
          ,le.fleet_numrel_slope_0t12_ALLOW_ErrorCount,le.fleet_numrel_slope_0t12_LENGTHS_ErrorCount
          ,le.fleet_numrel_slope_0t24_ALLOW_ErrorCount,le.fleet_numrel_slope_0t24_LENGTHS_ErrorCount
          ,le.fleet_numrel_slope_0t6_ALLOW_ErrorCount,le.fleet_numrel_slope_0t6_LENGTHS_ErrorCount
          ,le.fleet_numrel_slope_6t12_ALLOW_ErrorCount,le.fleet_numrel_slope_6t12_LENGTHS_ErrorCount
          ,le.carrier_numrel_slope_0t12_ALLOW_ErrorCount,le.carrier_numrel_slope_0t12_LENGTHS_ErrorCount
          ,le.carrier_numrel_slope_0t24_ALLOW_ErrorCount,le.carrier_numrel_slope_0t24_LENGTHS_ErrorCount
          ,le.carrier_numrel_slope_0t6_ALLOW_ErrorCount,le.carrier_numrel_slope_0t6_LENGTHS_ErrorCount
          ,le.carrier_numrel_slope_6t12_ALLOW_ErrorCount,le.carrier_numrel_slope_6t12_LENGTHS_ErrorCount
          ,le.bldgmats_numrel_slope_0t12_ALLOW_ErrorCount,le.bldgmats_numrel_slope_0t12_LENGTHS_ErrorCount
          ,le.bldgmats_numrel_slope_0t24_ALLOW_ErrorCount,le.bldgmats_numrel_slope_0t24_LENGTHS_ErrorCount
          ,le.bldgmats_numrel_slope_0t6_ALLOW_ErrorCount,le.bldgmats_numrel_slope_0t6_LENGTHS_ErrorCount
          ,le.bldgmats_numrel_slope_6t12_ALLOW_ErrorCount,le.bldgmats_numrel_slope_6t12_LENGTHS_ErrorCount
          ,le.bldgmats_numrel_var_0t12_ALLOW_ErrorCount,le.bldgmats_numrel_var_0t12_LENGTHS_ErrorCount
          ,le.bldgmats_numrel_var_12t24_ALLOW_ErrorCount,le.bldgmats_numrel_var_12t24_LENGTHS_ErrorCount
          ,le.total_percprov30_slope_0t12_ALLOW_ErrorCount,le.total_percprov30_slope_0t12_LENGTHS_ErrorCount
          ,le.total_percprov30_slope_0t24_ALLOW_ErrorCount,le.total_percprov30_slope_0t24_LENGTHS_ErrorCount
          ,le.total_percprov30_slope_0t6_ALLOW_ErrorCount,le.total_percprov30_slope_0t6_LENGTHS_ErrorCount
          ,le.total_percprov30_slope_6t12_ALLOW_ErrorCount,le.total_percprov30_slope_6t12_LENGTHS_ErrorCount
          ,le.total_percprov60_slope_0t12_ALLOW_ErrorCount,le.total_percprov60_slope_0t12_LENGTHS_ErrorCount
          ,le.total_percprov60_slope_0t24_ALLOW_ErrorCount,le.total_percprov60_slope_0t24_LENGTHS_ErrorCount
          ,le.total_percprov60_slope_0t6_ALLOW_ErrorCount,le.total_percprov60_slope_0t6_LENGTHS_ErrorCount
          ,le.total_percprov60_slope_6t12_ALLOW_ErrorCount,le.total_percprov60_slope_6t12_LENGTHS_ErrorCount
          ,le.total_percprov90_slope_0t24_ALLOW_ErrorCount,le.total_percprov90_slope_0t24_LENGTHS_ErrorCount
          ,le.total_percprov90_slope_0t6_ALLOW_ErrorCount,le.total_percprov90_slope_0t6_LENGTHS_ErrorCount
          ,le.total_percprov90_slope_6t12_ALLOW_ErrorCount,le.total_percprov90_slope_6t12_LENGTHS_ErrorCount
          ,le.mfgmat_percprov30_slope_0t12_ALLOW_ErrorCount,le.mfgmat_percprov30_slope_0t12_LENGTHS_ErrorCount
          ,le.mfgmat_percprov30_slope_6t12_ALLOW_ErrorCount,le.mfgmat_percprov30_slope_6t12_LENGTHS_ErrorCount
          ,le.mfgmat_percprov60_slope_0t12_ALLOW_ErrorCount,le.mfgmat_percprov60_slope_0t12_LENGTHS_ErrorCount
          ,le.mfgmat_percprov60_slope_6t12_ALLOW_ErrorCount,le.mfgmat_percprov60_slope_6t12_LENGTHS_ErrorCount
          ,le.mfgmat_percprov90_slope_0t24_ALLOW_ErrorCount,le.mfgmat_percprov90_slope_0t24_LENGTHS_ErrorCount
          ,le.mfgmat_percprov90_slope_0t6_ALLOW_ErrorCount,le.mfgmat_percprov90_slope_0t6_LENGTHS_ErrorCount
          ,le.mfgmat_percprov90_slope_6t12_ALLOW_ErrorCount,le.mfgmat_percprov90_slope_6t12_LENGTHS_ErrorCount
          ,le.ops_percprov30_slope_0t12_ALLOW_ErrorCount,le.ops_percprov30_slope_0t12_LENGTHS_ErrorCount
          ,le.ops_percprov30_slope_6t12_ALLOW_ErrorCount,le.ops_percprov30_slope_6t12_LENGTHS_ErrorCount
          ,le.ops_percprov60_slope_0t12_ALLOW_ErrorCount,le.ops_percprov60_slope_0t12_LENGTHS_ErrorCount
          ,le.ops_percprov60_slope_6t12_ALLOW_ErrorCount,le.ops_percprov60_slope_6t12_LENGTHS_ErrorCount
          ,le.ops_percprov90_slope_0t24_ALLOW_ErrorCount,le.ops_percprov90_slope_0t24_LENGTHS_ErrorCount
          ,le.ops_percprov90_slope_0t6_ALLOW_ErrorCount,le.ops_percprov90_slope_0t6_LENGTHS_ErrorCount
          ,le.ops_percprov90_slope_6t12_ALLOW_ErrorCount,le.ops_percprov90_slope_6t12_LENGTHS_ErrorCount
          ,le.fleet_percprov30_slope_0t12_ALLOW_ErrorCount,le.fleet_percprov30_slope_0t12_LENGTHS_ErrorCount
          ,le.fleet_percprov30_slope_6t12_ALLOW_ErrorCount,le.fleet_percprov30_slope_6t12_LENGTHS_ErrorCount
          ,le.fleet_percprov60_slope_0t12_ALLOW_ErrorCount,le.fleet_percprov60_slope_0t12_LENGTHS_ErrorCount
          ,le.fleet_percprov60_slope_6t12_ALLOW_ErrorCount,le.fleet_percprov60_slope_6t12_LENGTHS_ErrorCount
          ,le.fleet_percprov90_slope_0t24_ALLOW_ErrorCount,le.fleet_percprov90_slope_0t24_LENGTHS_ErrorCount
          ,le.fleet_percprov90_slope_0t6_ALLOW_ErrorCount,le.fleet_percprov90_slope_0t6_LENGTHS_ErrorCount
          ,le.fleet_percprov90_slope_6t12_ALLOW_ErrorCount,le.fleet_percprov90_slope_6t12_LENGTHS_ErrorCount
          ,le.carrier_percprov30_slope_0t12_ALLOW_ErrorCount,le.carrier_percprov30_slope_0t12_LENGTHS_ErrorCount
          ,le.carrier_percprov30_slope_6t12_ALLOW_ErrorCount,le.carrier_percprov30_slope_6t12_LENGTHS_ErrorCount
          ,le.carrier_percprov60_slope_0t12_ALLOW_ErrorCount,le.carrier_percprov60_slope_0t12_LENGTHS_ErrorCount
          ,le.carrier_percprov60_slope_6t12_ALLOW_ErrorCount,le.carrier_percprov60_slope_6t12_LENGTHS_ErrorCount
          ,le.carrier_percprov90_slope_0t24_ALLOW_ErrorCount,le.carrier_percprov90_slope_0t24_LENGTHS_ErrorCount
          ,le.carrier_percprov90_slope_0t6_ALLOW_ErrorCount,le.carrier_percprov90_slope_0t6_LENGTHS_ErrorCount
          ,le.carrier_percprov90_slope_6t12_ALLOW_ErrorCount,le.carrier_percprov90_slope_6t12_LENGTHS_ErrorCount
          ,le.bldgmats_percprov30_slope_0t12_ALLOW_ErrorCount,le.bldgmats_percprov30_slope_0t12_LENGTHS_ErrorCount
          ,le.bldgmats_percprov30_slope_6t12_ALLOW_ErrorCount,le.bldgmats_percprov30_slope_6t12_LENGTHS_ErrorCount
          ,le.bldgmats_percprov60_slope_0t12_ALLOW_ErrorCount,le.bldgmats_percprov60_slope_0t12_LENGTHS_ErrorCount
          ,le.bldgmats_percprov60_slope_6t12_ALLOW_ErrorCount,le.bldgmats_percprov60_slope_6t12_LENGTHS_ErrorCount
          ,le.bldgmats_percprov90_slope_0t24_ALLOW_ErrorCount,le.bldgmats_percprov90_slope_0t24_LENGTHS_ErrorCount
          ,le.bldgmats_percprov90_slope_0t6_ALLOW_ErrorCount,le.bldgmats_percprov90_slope_0t6_LENGTHS_ErrorCount
          ,le.bldgmats_percprov90_slope_6t12_ALLOW_ErrorCount,le.bldgmats_percprov90_slope_6t12_LENGTHS_ErrorCount
          ,le.top5_percprov30_slope_0t12_ALLOW_ErrorCount,le.top5_percprov30_slope_0t12_LENGTHS_ErrorCount
          ,le.top5_percprov30_slope_6t12_ALLOW_ErrorCount,le.top5_percprov30_slope_6t12_LENGTHS_ErrorCount
          ,le.top5_percprov60_slope_0t12_ALLOW_ErrorCount,le.top5_percprov60_slope_0t12_LENGTHS_ErrorCount
          ,le.top5_percprov60_slope_6t12_ALLOW_ErrorCount,le.top5_percprov60_slope_6t12_LENGTHS_ErrorCount
          ,le.top5_percprov90_slope_0t24_ALLOW_ErrorCount,le.top5_percprov90_slope_0t24_LENGTHS_ErrorCount
          ,le.top5_percprov90_slope_0t6_ALLOW_ErrorCount,le.top5_percprov90_slope_0t6_LENGTHS_ErrorCount
          ,le.top5_percprov90_slope_6t12_ALLOW_ErrorCount,le.top5_percprov90_slope_6t12_LENGTHS_ErrorCount
          ,le.top5_percprovoutstanding_adjustedslope_0t12_ALLOW_ErrorCount,le.top5_percprovoutstanding_adjustedslope_0t12_LENGTHS_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.ultimate_linkid_ALLOW_ErrorCount
          ,le.cortera_score_ALLOW_ErrorCount
          ,le.cpr_score_ALLOW_ErrorCount
          ,le.cpr_segment_ALLOW_ErrorCount
          ,le.dbt_ALLOW_ErrorCount,le.dbt_LENGTHS_ErrorCount
          ,le.avg_bal_ALLOW_ErrorCount
          ,le.air_spend_ALLOW_ErrorCount
          ,le.fuel_spend_ALLOW_ErrorCount
          ,le.leasing_spend_ALLOW_ErrorCount
          ,le.ltl_spend_ALLOW_ErrorCount
          ,le.rail_spend_ALLOW_ErrorCount
          ,le.tl_spend_ALLOW_ErrorCount
          ,le.transvc_spend_ALLOW_ErrorCount
          ,le.transup_spend_ALLOW_ErrorCount
          ,le.bst_spend_ALLOW_ErrorCount
          ,le.dg_spend_ALLOW_ErrorCount
          ,le.electrical_spend_ALLOW_ErrorCount
          ,le.hvac_spend_ALLOW_ErrorCount
          ,le.other_b_spend_ALLOW_ErrorCount
          ,le.plumbing_spend_ALLOW_ErrorCount
          ,le.rs_spend_ALLOW_ErrorCount
          ,le.wp_spend_ALLOW_ErrorCount
          ,le.chemical_spend_ALLOW_ErrorCount
          ,le.electronic_spend_ALLOW_ErrorCount
          ,le.metal_spend_ALLOW_ErrorCount
          ,le.other_m_spend_ALLOW_ErrorCount
          ,le.packaging_spend_ALLOW_ErrorCount
          ,le.pvf_spend_ALLOW_ErrorCount
          ,le.plastic_spend_ALLOW_ErrorCount
          ,le.textile_spend_ALLOW_ErrorCount
          ,le.bs_spend_ALLOW_ErrorCount
          ,le.ce_spend_ALLOW_ErrorCount
          ,le.hardware_spend_ALLOW_ErrorCount
          ,le.ie_spend_ALLOW_ErrorCount
          ,le.is_spend_ALLOW_ErrorCount
          ,le.it_spend_ALLOW_ErrorCount
          ,le.mls_spend_ALLOW_ErrorCount
          ,le.os_spend_ALLOW_ErrorCount
          ,le.pp_spend_ALLOW_ErrorCount
          ,le.sis_spend_ALLOW_ErrorCount
          ,le.apparel_spend_ALLOW_ErrorCount
          ,le.beverages_spend_ALLOW_ErrorCount
          ,le.constr_spend_ALLOW_ErrorCount
          ,le.consulting_spend_ALLOW_ErrorCount
          ,le.fs_spend_ALLOW_ErrorCount
          ,le.fp_spend_ALLOW_ErrorCount
          ,le.insurance_spend_ALLOW_ErrorCount
          ,le.ls_spend_ALLOW_ErrorCount
          ,le.oil_gas_spend_ALLOW_ErrorCount
          ,le.utilities_spend_ALLOW_ErrorCount
          ,le.other_spend_ALLOW_ErrorCount
          ,le.advt_spend_ALLOW_ErrorCount
          ,le.air_growth_ALLOW_ErrorCount,le.air_growth_LENGTHS_ErrorCount
          ,le.fuel_growth_ALLOW_ErrorCount,le.fuel_growth_LENGTHS_ErrorCount
          ,le.leasing_growth_ALLOW_ErrorCount,le.leasing_growth_LENGTHS_ErrorCount
          ,le.ltl_growth_ALLOW_ErrorCount,le.ltl_growth_LENGTHS_ErrorCount
          ,le.rail_growth_ALLOW_ErrorCount,le.rail_growth_LENGTHS_ErrorCount
          ,le.tl_growth_ALLOW_ErrorCount,le.tl_growth_LENGTHS_ErrorCount
          ,le.transvc_growth_ALLOW_ErrorCount,le.transvc_growth_LENGTHS_ErrorCount
          ,le.transup_growth_ALLOW_ErrorCount,le.transup_growth_LENGTHS_ErrorCount
          ,le.bst_growth_ALLOW_ErrorCount,le.bst_growth_LENGTHS_ErrorCount
          ,le.dg_growth_ALLOW_ErrorCount,le.dg_growth_LENGTHS_ErrorCount
          ,le.electrical_growth_ALLOW_ErrorCount,le.electrical_growth_LENGTHS_ErrorCount
          ,le.hvac_growth_ALLOW_ErrorCount,le.hvac_growth_LENGTHS_ErrorCount
          ,le.other_b_growth_ALLOW_ErrorCount,le.other_b_growth_LENGTHS_ErrorCount
          ,le.plumbing_growth_ALLOW_ErrorCount,le.plumbing_growth_LENGTHS_ErrorCount
          ,le.rs_growth_ALLOW_ErrorCount,le.rs_growth_LENGTHS_ErrorCount
          ,le.wp_growth_ALLOW_ErrorCount,le.wp_growth_LENGTHS_ErrorCount
          ,le.chemical_growth_ALLOW_ErrorCount,le.chemical_growth_LENGTHS_ErrorCount
          ,le.electronic_growth_ALLOW_ErrorCount,le.electronic_growth_LENGTHS_ErrorCount
          ,le.metal_growth_ALLOW_ErrorCount,le.metal_growth_LENGTHS_ErrorCount
          ,le.other_m_growth_ALLOW_ErrorCount,le.other_m_growth_LENGTHS_ErrorCount
          ,le.packaging_growth_ALLOW_ErrorCount,le.packaging_growth_LENGTHS_ErrorCount
          ,le.pvf_growth_ALLOW_ErrorCount,le.pvf_growth_LENGTHS_ErrorCount
          ,le.plastic_growth_ALLOW_ErrorCount,le.plastic_growth_LENGTHS_ErrorCount
          ,le.textile_growth_ALLOW_ErrorCount,le.textile_growth_LENGTHS_ErrorCount
          ,le.bs_growth_ALLOW_ErrorCount,le.bs_growth_LENGTHS_ErrorCount
          ,le.ce_growth_ALLOW_ErrorCount,le.ce_growth_LENGTHS_ErrorCount
          ,le.hardware_growth_ALLOW_ErrorCount,le.hardware_growth_LENGTHS_ErrorCount
          ,le.ie_growth_ALLOW_ErrorCount,le.ie_growth_LENGTHS_ErrorCount
          ,le.is_growth_ALLOW_ErrorCount,le.is_growth_LENGTHS_ErrorCount
          ,le.it_growth_ALLOW_ErrorCount,le.it_growth_LENGTHS_ErrorCount
          ,le.mls_growth_ALLOW_ErrorCount,le.mls_growth_LENGTHS_ErrorCount
          ,le.os_growth_ALLOW_ErrorCount,le.os_growth_LENGTHS_ErrorCount
          ,le.pp_growth_ALLOW_ErrorCount,le.pp_growth_LENGTHS_ErrorCount
          ,le.sis_growth_ALLOW_ErrorCount,le.sis_growth_LENGTHS_ErrorCount
          ,le.apparel_growth_ALLOW_ErrorCount,le.apparel_growth_LENGTHS_ErrorCount
          ,le.beverages_growth_ALLOW_ErrorCount,le.beverages_growth_LENGTHS_ErrorCount
          ,le.constr_growth_ALLOW_ErrorCount,le.constr_growth_LENGTHS_ErrorCount
          ,le.consulting_growth_ALLOW_ErrorCount,le.consulting_growth_LENGTHS_ErrorCount
          ,le.fs_growth_ALLOW_ErrorCount,le.fs_growth_LENGTHS_ErrorCount
          ,le.fp_growth_ALLOW_ErrorCount,le.fp_growth_LENGTHS_ErrorCount
          ,le.insurance_growth_ALLOW_ErrorCount,le.insurance_growth_LENGTHS_ErrorCount
          ,le.ls_growth_ALLOW_ErrorCount,le.ls_growth_LENGTHS_ErrorCount
          ,le.oil_gas_growth_ALLOW_ErrorCount,le.oil_gas_growth_LENGTHS_ErrorCount
          ,le.utilities_growth_ALLOW_ErrorCount,le.utilities_growth_LENGTHS_ErrorCount
          ,le.other_growth_ALLOW_ErrorCount,le.other_growth_LENGTHS_ErrorCount
          ,le.advt_growth_ALLOW_ErrorCount,le.advt_growth_LENGTHS_ErrorCount
          ,le.top5_growth_ALLOW_ErrorCount,le.top5_growth_LENGTHS_ErrorCount
          ,le.shipping_y1_ALLOW_ErrorCount
          ,le.shipping_growth_ALLOW_ErrorCount,le.shipping_growth_LENGTHS_ErrorCount
          ,le.materials_y1_ALLOW_ErrorCount
          ,le.materials_growth_ALLOW_ErrorCount,le.materials_growth_LENGTHS_ErrorCount
          ,le.operations_y1_ALLOW_ErrorCount
          ,le.operations_growth_ALLOW_ErrorCount,le.operations_growth_LENGTHS_ErrorCount
          ,le.total_paid_average_0t12_ALLOW_ErrorCount,le.total_paid_average_0t12_LENGTHS_ErrorCount
          ,le.total_paid_monthspastworst_24_ALLOW_ErrorCount,le.total_paid_monthspastworst_24_LENGTHS_ErrorCount
          ,le.total_paid_slope_0t12_ALLOW_ErrorCount,le.total_paid_slope_0t12_LENGTHS_ErrorCount
          ,le.total_paid_slope_0t6_ALLOW_ErrorCount,le.total_paid_slope_0t6_LENGTHS_ErrorCount
          ,le.total_paid_slope_6t12_ALLOW_ErrorCount,le.total_paid_slope_6t12_LENGTHS_ErrorCount
          ,le.total_paid_slope_6t18_ALLOW_ErrorCount,le.total_paid_slope_6t18_LENGTHS_ErrorCount
          ,le.total_paid_volatility_0t12_ALLOW_ErrorCount,le.total_paid_volatility_0t12_LENGTHS_ErrorCount
          ,le.total_paid_volatility_0t6_ALLOW_ErrorCount,le.total_paid_volatility_0t6_LENGTHS_ErrorCount
          ,le.total_paid_volatility_12t18_ALLOW_ErrorCount,le.total_paid_volatility_12t18_LENGTHS_ErrorCount
          ,le.total_paid_volatility_6t12_ALLOW_ErrorCount,le.total_paid_volatility_6t12_LENGTHS_ErrorCount
          ,le.total_spend_monthspastleast_24_ALLOW_ErrorCount
          ,le.total_spend_monthspastmost_24_ALLOW_ErrorCount
          ,le.total_spend_slope_0t12_ALLOW_ErrorCount,le.total_spend_slope_0t12_LENGTHS_ErrorCount
          ,le.total_spend_slope_0t24_ALLOW_ErrorCount,le.total_spend_slope_0t24_LENGTHS_ErrorCount
          ,le.total_spend_slope_0t6_ALLOW_ErrorCount,le.total_spend_slope_0t6_LENGTHS_ErrorCount
          ,le.total_spend_slope_6t12_ALLOW_ErrorCount,le.total_spend_slope_6t12_LENGTHS_ErrorCount
          ,le.total_spend_sum_12_ALLOW_ErrorCount,le.total_spend_sum_12_LENGTHS_ErrorCount
          ,le.total_spend_volatility_0t12_ALLOW_ErrorCount,le.total_spend_volatility_0t12_LENGTHS_ErrorCount
          ,le.total_spend_volatility_0t6_ALLOW_ErrorCount,le.total_spend_volatility_0t6_LENGTHS_ErrorCount
          ,le.total_spend_volatility_12t18_ALLOW_ErrorCount,le.total_spend_volatility_12t18_LENGTHS_ErrorCount
          ,le.total_spend_volatility_6t12_ALLOW_ErrorCount,le.total_spend_volatility_6t12_LENGTHS_ErrorCount
          ,le.mfgmat_paid_average_12_ALLOW_ErrorCount,le.mfgmat_paid_average_12_LENGTHS_ErrorCount
          ,le.mfgmat_paid_monthspastworst_24_ALLOW_ErrorCount
          ,le.mfgmat_paid_slope_0t12_ALLOW_ErrorCount,le.mfgmat_paid_slope_0t12_LENGTHS_ErrorCount
          ,le.mfgmat_paid_slope_0t24_ALLOW_ErrorCount,le.mfgmat_paid_slope_0t24_LENGTHS_ErrorCount
          ,le.mfgmat_paid_slope_0t6_ALLOW_ErrorCount,le.mfgmat_paid_slope_0t6_LENGTHS_ErrorCount
          ,le.mfgmat_paid_volatility_0t12_ALLOW_ErrorCount,le.mfgmat_paid_volatility_0t12_LENGTHS_ErrorCount
          ,le.mfgmat_paid_volatility_0t6_ALLOW_ErrorCount,le.mfgmat_paid_volatility_0t6_LENGTHS_ErrorCount
          ,le.mfgmat_spend_monthspastleast_24_ALLOW_ErrorCount
          ,le.mfgmat_spend_monthspastmost_24_ALLOW_ErrorCount
          ,le.mfgmat_spend_slope_0t12_ALLOW_ErrorCount,le.mfgmat_spend_slope_0t12_LENGTHS_ErrorCount
          ,le.mfgmat_spend_slope_0t24_ALLOW_ErrorCount,le.mfgmat_spend_slope_0t24_LENGTHS_ErrorCount
          ,le.mfgmat_spend_slope_0t6_ALLOW_ErrorCount,le.mfgmat_spend_slope_0t6_LENGTHS_ErrorCount
          ,le.mfgmat_spend_sum_12_ALLOW_ErrorCount,le.mfgmat_spend_sum_12_LENGTHS_ErrorCount
          ,le.mfgmat_spend_volatility_0t6_ALLOW_ErrorCount,le.mfgmat_spend_volatility_0t6_LENGTHS_ErrorCount
          ,le.mfgmat_spend_volatility_6t12_ALLOW_ErrorCount,le.mfgmat_spend_volatility_6t12_LENGTHS_ErrorCount
          ,le.ops_paid_average_12_ALLOW_ErrorCount,le.ops_paid_average_12_LENGTHS_ErrorCount
          ,le.ops_paid_monthspastworst_24_ALLOW_ErrorCount,le.ops_paid_monthspastworst_24_LENGTHS_ErrorCount
          ,le.ops_paid_slope_0t12_ALLOW_ErrorCount,le.ops_paid_slope_0t12_LENGTHS_ErrorCount
          ,le.ops_paid_slope_0t24_ALLOW_ErrorCount,le.ops_paid_slope_0t24_LENGTHS_ErrorCount
          ,le.ops_paid_slope_0t6_ALLOW_ErrorCount,le.ops_paid_slope_0t6_LENGTHS_ErrorCount
          ,le.ops_paid_volatility_0t12_ALLOW_ErrorCount,le.ops_paid_volatility_0t12_LENGTHS_ErrorCount
          ,le.ops_paid_volatility_0t6_ALLOW_ErrorCount,le.ops_paid_volatility_0t6_LENGTHS_ErrorCount
          ,le.ops_spend_monthspastleast_24_ALLOW_ErrorCount
          ,le.ops_spend_monthspastmost_24_ALLOW_ErrorCount
          ,le.ops_spend_slope_0t12_ALLOW_ErrorCount,le.ops_spend_slope_0t12_LENGTHS_ErrorCount
          ,le.ops_spend_slope_0t24_ALLOW_ErrorCount,le.ops_spend_slope_0t24_LENGTHS_ErrorCount
          ,le.ops_spend_slope_0t6_ALLOW_ErrorCount,le.ops_spend_slope_0t6_LENGTHS_ErrorCount
          ,le.fleet_paid_monthspastworst_24_ALLOW_ErrorCount
          ,le.fleet_paid_slope_0t12_ALLOW_ErrorCount,le.fleet_paid_slope_0t12_LENGTHS_ErrorCount
          ,le.fleet_paid_slope_0t24_ALLOW_ErrorCount,le.fleet_paid_slope_0t24_LENGTHS_ErrorCount
          ,le.fleet_paid_slope_0t6_ALLOW_ErrorCount,le.fleet_paid_slope_0t6_LENGTHS_ErrorCount
          ,le.fleet_paid_volatility_0t12_ALLOW_ErrorCount,le.fleet_paid_volatility_0t12_LENGTHS_ErrorCount
          ,le.fleet_paid_volatility_0t6_ALLOW_ErrorCount,le.fleet_paid_volatility_0t6_LENGTHS_ErrorCount
          ,le.fleet_spend_slope_0t12_ALLOW_ErrorCount,le.fleet_spend_slope_0t12_LENGTHS_ErrorCount
          ,le.fleet_spend_slope_0t24_ALLOW_ErrorCount,le.fleet_spend_slope_0t24_LENGTHS_ErrorCount
          ,le.fleet_spend_slope_0t6_ALLOW_ErrorCount,le.fleet_spend_slope_0t6_LENGTHS_ErrorCount
          ,le.carrier_paid_slope_0t12_ALLOW_ErrorCount,le.carrier_paid_slope_0t12_LENGTHS_ErrorCount
          ,le.carrier_paid_slope_0t24_ALLOW_ErrorCount,le.carrier_paid_slope_0t24_LENGTHS_ErrorCount
          ,le.carrier_paid_slope_0t6_ALLOW_ErrorCount,le.carrier_paid_slope_0t6_LENGTHS_ErrorCount
          ,le.carrier_paid_volatility_0t12_ALLOW_ErrorCount,le.carrier_paid_volatility_0t12_LENGTHS_ErrorCount
          ,le.carrier_paid_volatility_0t6_ALLOW_ErrorCount,le.carrier_paid_volatility_0t6_LENGTHS_ErrorCount
          ,le.carrier_spend_slope_0t12_ALLOW_ErrorCount,le.carrier_spend_slope_0t12_LENGTHS_ErrorCount
          ,le.carrier_spend_slope_0t24_ALLOW_ErrorCount,le.carrier_spend_slope_0t24_LENGTHS_ErrorCount
          ,le.carrier_spend_slope_0t6_ALLOW_ErrorCount,le.carrier_spend_slope_0t6_LENGTHS_ErrorCount
          ,le.carrier_spend_volatility_0t6_ALLOW_ErrorCount,le.carrier_spend_volatility_0t6_LENGTHS_ErrorCount
          ,le.carrier_spend_volatility_6t12_ALLOW_ErrorCount,le.carrier_spend_volatility_6t12_LENGTHS_ErrorCount
          ,le.bldgmats_paid_slope_0t12_ALLOW_ErrorCount,le.bldgmats_paid_slope_0t12_LENGTHS_ErrorCount
          ,le.bldgmats_paid_slope_0t24_ALLOW_ErrorCount,le.bldgmats_paid_slope_0t24_LENGTHS_ErrorCount
          ,le.bldgmats_paid_slope_0t6_ALLOW_ErrorCount,le.bldgmats_paid_slope_0t6_LENGTHS_ErrorCount
          ,le.bldgmats_paid_volatility_0t12_ALLOW_ErrorCount,le.bldgmats_paid_volatility_0t12_LENGTHS_ErrorCount
          ,le.bldgmats_paid_volatility_0t6_ALLOW_ErrorCount,le.bldgmats_paid_volatility_0t6_LENGTHS_ErrorCount
          ,le.bldgmats_spend_slope_0t12_ALLOW_ErrorCount,le.bldgmats_spend_slope_0t12_LENGTHS_ErrorCount
          ,le.bldgmats_spend_slope_0t24_ALLOW_ErrorCount,le.bldgmats_spend_slope_0t24_LENGTHS_ErrorCount
          ,le.bldgmats_spend_slope_0t6_ALLOW_ErrorCount,le.bldgmats_spend_slope_0t6_LENGTHS_ErrorCount
          ,le.bldgmats_spend_volatility_0t6_ALLOW_ErrorCount,le.bldgmats_spend_volatility_0t6_LENGTHS_ErrorCount
          ,le.bldgmats_spend_volatility_6t12_ALLOW_ErrorCount,le.bldgmats_spend_volatility_6t12_LENGTHS_ErrorCount
          ,le.top5_paid_slope_0t12_ALLOW_ErrorCount,le.top5_paid_slope_0t12_LENGTHS_ErrorCount
          ,le.top5_paid_slope_0t24_ALLOW_ErrorCount,le.top5_paid_slope_0t24_LENGTHS_ErrorCount
          ,le.top5_paid_slope_0t6_ALLOW_ErrorCount,le.top5_paid_slope_0t6_LENGTHS_ErrorCount
          ,le.top5_paid_volatility_0t12_ALLOW_ErrorCount,le.top5_paid_volatility_0t12_LENGTHS_ErrorCount
          ,le.top5_paid_volatility_0t6_ALLOW_ErrorCount,le.top5_paid_volatility_0t6_LENGTHS_ErrorCount
          ,le.top5_spend_slope_0t12_ALLOW_ErrorCount,le.top5_spend_slope_0t12_LENGTHS_ErrorCount
          ,le.top5_spend_slope_0t24_ALLOW_ErrorCount,le.top5_spend_slope_0t24_LENGTHS_ErrorCount
          ,le.top5_spend_slope_0t6_ALLOW_ErrorCount,le.top5_spend_slope_0t6_LENGTHS_ErrorCount
          ,le.top5_spend_volatility_0t6_ALLOW_ErrorCount,le.top5_spend_volatility_0t6_LENGTHS_ErrorCount
          ,le.top5_spend_volatility_6t12_ALLOW_ErrorCount,le.top5_spend_volatility_6t12_LENGTHS_ErrorCount
          ,le.total_numrel_slope_0t12_ALLOW_ErrorCount,le.total_numrel_slope_0t12_LENGTHS_ErrorCount
          ,le.total_numrel_slope_0t24_ALLOW_ErrorCount,le.total_numrel_slope_0t24_LENGTHS_ErrorCount
          ,le.total_numrel_slope_0t6_ALLOW_ErrorCount,le.total_numrel_slope_0t6_LENGTHS_ErrorCount
          ,le.total_numrel_slope_6t12_ALLOW_ErrorCount,le.total_numrel_slope_6t12_LENGTHS_ErrorCount
          ,le.mfgmat_numrel_slope_0t12_ALLOW_ErrorCount,le.mfgmat_numrel_slope_0t12_LENGTHS_ErrorCount
          ,le.mfgmat_numrel_slope_0t24_ALLOW_ErrorCount,le.mfgmat_numrel_slope_0t24_LENGTHS_ErrorCount
          ,le.mfgmat_numrel_slope_0t6_ALLOW_ErrorCount,le.mfgmat_numrel_slope_0t6_LENGTHS_ErrorCount
          ,le.mfgmat_numrel_slope_6t12_ALLOW_ErrorCount,le.mfgmat_numrel_slope_6t12_LENGTHS_ErrorCount
          ,le.ops_numrel_slope_0t12_ALLOW_ErrorCount,le.ops_numrel_slope_0t12_LENGTHS_ErrorCount
          ,le.ops_numrel_slope_0t24_ALLOW_ErrorCount,le.ops_numrel_slope_0t24_LENGTHS_ErrorCount
          ,le.ops_numrel_slope_0t6_ALLOW_ErrorCount,le.ops_numrel_slope_0t6_LENGTHS_ErrorCount
          ,le.ops_numrel_slope_6t12_ALLOW_ErrorCount,le.ops_numrel_slope_6t12_LENGTHS_ErrorCount
          ,le.fleet_numrel_slope_0t12_ALLOW_ErrorCount,le.fleet_numrel_slope_0t12_LENGTHS_ErrorCount
          ,le.fleet_numrel_slope_0t24_ALLOW_ErrorCount,le.fleet_numrel_slope_0t24_LENGTHS_ErrorCount
          ,le.fleet_numrel_slope_0t6_ALLOW_ErrorCount,le.fleet_numrel_slope_0t6_LENGTHS_ErrorCount
          ,le.fleet_numrel_slope_6t12_ALLOW_ErrorCount,le.fleet_numrel_slope_6t12_LENGTHS_ErrorCount
          ,le.carrier_numrel_slope_0t12_ALLOW_ErrorCount,le.carrier_numrel_slope_0t12_LENGTHS_ErrorCount
          ,le.carrier_numrel_slope_0t24_ALLOW_ErrorCount,le.carrier_numrel_slope_0t24_LENGTHS_ErrorCount
          ,le.carrier_numrel_slope_0t6_ALLOW_ErrorCount,le.carrier_numrel_slope_0t6_LENGTHS_ErrorCount
          ,le.carrier_numrel_slope_6t12_ALLOW_ErrorCount,le.carrier_numrel_slope_6t12_LENGTHS_ErrorCount
          ,le.bldgmats_numrel_slope_0t12_ALLOW_ErrorCount,le.bldgmats_numrel_slope_0t12_LENGTHS_ErrorCount
          ,le.bldgmats_numrel_slope_0t24_ALLOW_ErrorCount,le.bldgmats_numrel_slope_0t24_LENGTHS_ErrorCount
          ,le.bldgmats_numrel_slope_0t6_ALLOW_ErrorCount,le.bldgmats_numrel_slope_0t6_LENGTHS_ErrorCount
          ,le.bldgmats_numrel_slope_6t12_ALLOW_ErrorCount,le.bldgmats_numrel_slope_6t12_LENGTHS_ErrorCount
          ,le.bldgmats_numrel_var_0t12_ALLOW_ErrorCount,le.bldgmats_numrel_var_0t12_LENGTHS_ErrorCount
          ,le.bldgmats_numrel_var_12t24_ALLOW_ErrorCount,le.bldgmats_numrel_var_12t24_LENGTHS_ErrorCount
          ,le.total_percprov30_slope_0t12_ALLOW_ErrorCount,le.total_percprov30_slope_0t12_LENGTHS_ErrorCount
          ,le.total_percprov30_slope_0t24_ALLOW_ErrorCount,le.total_percprov30_slope_0t24_LENGTHS_ErrorCount
          ,le.total_percprov30_slope_0t6_ALLOW_ErrorCount,le.total_percprov30_slope_0t6_LENGTHS_ErrorCount
          ,le.total_percprov30_slope_6t12_ALLOW_ErrorCount,le.total_percprov30_slope_6t12_LENGTHS_ErrorCount
          ,le.total_percprov60_slope_0t12_ALLOW_ErrorCount,le.total_percprov60_slope_0t12_LENGTHS_ErrorCount
          ,le.total_percprov60_slope_0t24_ALLOW_ErrorCount,le.total_percprov60_slope_0t24_LENGTHS_ErrorCount
          ,le.total_percprov60_slope_0t6_ALLOW_ErrorCount,le.total_percprov60_slope_0t6_LENGTHS_ErrorCount
          ,le.total_percprov60_slope_6t12_ALLOW_ErrorCount,le.total_percprov60_slope_6t12_LENGTHS_ErrorCount
          ,le.total_percprov90_slope_0t24_ALLOW_ErrorCount,le.total_percprov90_slope_0t24_LENGTHS_ErrorCount
          ,le.total_percprov90_slope_0t6_ALLOW_ErrorCount,le.total_percprov90_slope_0t6_LENGTHS_ErrorCount
          ,le.total_percprov90_slope_6t12_ALLOW_ErrorCount,le.total_percprov90_slope_6t12_LENGTHS_ErrorCount
          ,le.mfgmat_percprov30_slope_0t12_ALLOW_ErrorCount,le.mfgmat_percprov30_slope_0t12_LENGTHS_ErrorCount
          ,le.mfgmat_percprov30_slope_6t12_ALLOW_ErrorCount,le.mfgmat_percprov30_slope_6t12_LENGTHS_ErrorCount
          ,le.mfgmat_percprov60_slope_0t12_ALLOW_ErrorCount,le.mfgmat_percprov60_slope_0t12_LENGTHS_ErrorCount
          ,le.mfgmat_percprov60_slope_6t12_ALLOW_ErrorCount,le.mfgmat_percprov60_slope_6t12_LENGTHS_ErrorCount
          ,le.mfgmat_percprov90_slope_0t24_ALLOW_ErrorCount,le.mfgmat_percprov90_slope_0t24_LENGTHS_ErrorCount
          ,le.mfgmat_percprov90_slope_0t6_ALLOW_ErrorCount,le.mfgmat_percprov90_slope_0t6_LENGTHS_ErrorCount
          ,le.mfgmat_percprov90_slope_6t12_ALLOW_ErrorCount,le.mfgmat_percprov90_slope_6t12_LENGTHS_ErrorCount
          ,le.ops_percprov30_slope_0t12_ALLOW_ErrorCount,le.ops_percprov30_slope_0t12_LENGTHS_ErrorCount
          ,le.ops_percprov30_slope_6t12_ALLOW_ErrorCount,le.ops_percprov30_slope_6t12_LENGTHS_ErrorCount
          ,le.ops_percprov60_slope_0t12_ALLOW_ErrorCount,le.ops_percprov60_slope_0t12_LENGTHS_ErrorCount
          ,le.ops_percprov60_slope_6t12_ALLOW_ErrorCount,le.ops_percprov60_slope_6t12_LENGTHS_ErrorCount
          ,le.ops_percprov90_slope_0t24_ALLOW_ErrorCount,le.ops_percprov90_slope_0t24_LENGTHS_ErrorCount
          ,le.ops_percprov90_slope_0t6_ALLOW_ErrorCount,le.ops_percprov90_slope_0t6_LENGTHS_ErrorCount
          ,le.ops_percprov90_slope_6t12_ALLOW_ErrorCount,le.ops_percprov90_slope_6t12_LENGTHS_ErrorCount
          ,le.fleet_percprov30_slope_0t12_ALLOW_ErrorCount,le.fleet_percprov30_slope_0t12_LENGTHS_ErrorCount
          ,le.fleet_percprov30_slope_6t12_ALLOW_ErrorCount,le.fleet_percprov30_slope_6t12_LENGTHS_ErrorCount
          ,le.fleet_percprov60_slope_0t12_ALLOW_ErrorCount,le.fleet_percprov60_slope_0t12_LENGTHS_ErrorCount
          ,le.fleet_percprov60_slope_6t12_ALLOW_ErrorCount,le.fleet_percprov60_slope_6t12_LENGTHS_ErrorCount
          ,le.fleet_percprov90_slope_0t24_ALLOW_ErrorCount,le.fleet_percprov90_slope_0t24_LENGTHS_ErrorCount
          ,le.fleet_percprov90_slope_0t6_ALLOW_ErrorCount,le.fleet_percprov90_slope_0t6_LENGTHS_ErrorCount
          ,le.fleet_percprov90_slope_6t12_ALLOW_ErrorCount,le.fleet_percprov90_slope_6t12_LENGTHS_ErrorCount
          ,le.carrier_percprov30_slope_0t12_ALLOW_ErrorCount,le.carrier_percprov30_slope_0t12_LENGTHS_ErrorCount
          ,le.carrier_percprov30_slope_6t12_ALLOW_ErrorCount,le.carrier_percprov30_slope_6t12_LENGTHS_ErrorCount
          ,le.carrier_percprov60_slope_0t12_ALLOW_ErrorCount,le.carrier_percprov60_slope_0t12_LENGTHS_ErrorCount
          ,le.carrier_percprov60_slope_6t12_ALLOW_ErrorCount,le.carrier_percprov60_slope_6t12_LENGTHS_ErrorCount
          ,le.carrier_percprov90_slope_0t24_ALLOW_ErrorCount,le.carrier_percprov90_slope_0t24_LENGTHS_ErrorCount
          ,le.carrier_percprov90_slope_0t6_ALLOW_ErrorCount,le.carrier_percprov90_slope_0t6_LENGTHS_ErrorCount
          ,le.carrier_percprov90_slope_6t12_ALLOW_ErrorCount,le.carrier_percprov90_slope_6t12_LENGTHS_ErrorCount
          ,le.bldgmats_percprov30_slope_0t12_ALLOW_ErrorCount,le.bldgmats_percprov30_slope_0t12_LENGTHS_ErrorCount
          ,le.bldgmats_percprov30_slope_6t12_ALLOW_ErrorCount,le.bldgmats_percprov30_slope_6t12_LENGTHS_ErrorCount
          ,le.bldgmats_percprov60_slope_0t12_ALLOW_ErrorCount,le.bldgmats_percprov60_slope_0t12_LENGTHS_ErrorCount
          ,le.bldgmats_percprov60_slope_6t12_ALLOW_ErrorCount,le.bldgmats_percprov60_slope_6t12_LENGTHS_ErrorCount
          ,le.bldgmats_percprov90_slope_0t24_ALLOW_ErrorCount,le.bldgmats_percprov90_slope_0t24_LENGTHS_ErrorCount
          ,le.bldgmats_percprov90_slope_0t6_ALLOW_ErrorCount,le.bldgmats_percprov90_slope_0t6_LENGTHS_ErrorCount
          ,le.bldgmats_percprov90_slope_6t12_ALLOW_ErrorCount,le.bldgmats_percprov90_slope_6t12_LENGTHS_ErrorCount
          ,le.top5_percprov30_slope_0t12_ALLOW_ErrorCount,le.top5_percprov30_slope_0t12_LENGTHS_ErrorCount
          ,le.top5_percprov30_slope_6t12_ALLOW_ErrorCount,le.top5_percprov30_slope_6t12_LENGTHS_ErrorCount
          ,le.top5_percprov60_slope_0t12_ALLOW_ErrorCount,le.top5_percprov60_slope_0t12_LENGTHS_ErrorCount
          ,le.top5_percprov60_slope_6t12_ALLOW_ErrorCount,le.top5_percprov60_slope_6t12_LENGTHS_ErrorCount
          ,le.top5_percprov90_slope_0t24_ALLOW_ErrorCount,le.top5_percprov90_slope_0t24_LENGTHS_ErrorCount
          ,le.top5_percprov90_slope_0t6_ALLOW_ErrorCount,le.top5_percprov90_slope_0t6_LENGTHS_ErrorCount
          ,le.top5_percprov90_slope_6t12_ALLOW_ErrorCount,le.top5_percprov90_slope_6t12_LENGTHS_ErrorCount
          ,le.top5_percprovoutstanding_adjustedslope_0t12_ALLOW_ErrorCount,le.top5_percprovoutstanding_adjustedslope_0t12_LENGTHS_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 7,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT311.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT311.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := Attributes_hygiene(PROJECT(h, Attributes_Layout_Cortera));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'ultimate_linkid:' + getFieldTypeText(h.ultimate_linkid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cortera_score:' + getFieldTypeText(h.cortera_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpr_score:' + getFieldTypeText(h.cpr_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cpr_segment:' + getFieldTypeText(h.cpr_segment) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbt:' + getFieldTypeText(h.dbt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'avg_bal:' + getFieldTypeText(h.avg_bal) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'air_spend:' + getFieldTypeText(h.air_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fuel_spend:' + getFieldTypeText(h.fuel_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'leasing_spend:' + getFieldTypeText(h.leasing_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ltl_spend:' + getFieldTypeText(h.ltl_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rail_spend:' + getFieldTypeText(h.rail_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tl_spend:' + getFieldTypeText(h.tl_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'transvc_spend:' + getFieldTypeText(h.transvc_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'transup_spend:' + getFieldTypeText(h.transup_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bst_spend:' + getFieldTypeText(h.bst_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dg_spend:' + getFieldTypeText(h.dg_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'electrical_spend:' + getFieldTypeText(h.electrical_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hvac_spend:' + getFieldTypeText(h.hvac_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other_b_spend:' + getFieldTypeText(h.other_b_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'plumbing_spend:' + getFieldTypeText(h.plumbing_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rs_spend:' + getFieldTypeText(h.rs_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'wp_spend:' + getFieldTypeText(h.wp_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chemical_spend:' + getFieldTypeText(h.chemical_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'electronic_spend:' + getFieldTypeText(h.electronic_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'metal_spend:' + getFieldTypeText(h.metal_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other_m_spend:' + getFieldTypeText(h.other_m_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'packaging_spend:' + getFieldTypeText(h.packaging_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pvf_spend:' + getFieldTypeText(h.pvf_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'plastic_spend:' + getFieldTypeText(h.plastic_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'textile_spend:' + getFieldTypeText(h.textile_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bs_spend:' + getFieldTypeText(h.bs_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ce_spend:' + getFieldTypeText(h.ce_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hardware_spend:' + getFieldTypeText(h.hardware_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ie_spend:' + getFieldTypeText(h.ie_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'is_spend:' + getFieldTypeText(h.is_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'it_spend:' + getFieldTypeText(h.it_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mls_spend:' + getFieldTypeText(h.mls_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'os_spend:' + getFieldTypeText(h.os_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pp_spend:' + getFieldTypeText(h.pp_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sis_spend:' + getFieldTypeText(h.sis_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'apparel_spend:' + getFieldTypeText(h.apparel_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'beverages_spend:' + getFieldTypeText(h.beverages_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'constr_spend:' + getFieldTypeText(h.constr_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'consulting_spend:' + getFieldTypeText(h.consulting_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fs_spend:' + getFieldTypeText(h.fs_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fp_spend:' + getFieldTypeText(h.fp_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'insurance_spend:' + getFieldTypeText(h.insurance_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ls_spend:' + getFieldTypeText(h.ls_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'oil_gas_spend:' + getFieldTypeText(h.oil_gas_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'utilities_spend:' + getFieldTypeText(h.utilities_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other_spend:' + getFieldTypeText(h.other_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'advt_spend:' + getFieldTypeText(h.advt_spend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'air_growth:' + getFieldTypeText(h.air_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fuel_growth:' + getFieldTypeText(h.fuel_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'leasing_growth:' + getFieldTypeText(h.leasing_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ltl_growth:' + getFieldTypeText(h.ltl_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rail_growth:' + getFieldTypeText(h.rail_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tl_growth:' + getFieldTypeText(h.tl_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'transvc_growth:' + getFieldTypeText(h.transvc_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'transup_growth:' + getFieldTypeText(h.transup_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bst_growth:' + getFieldTypeText(h.bst_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dg_growth:' + getFieldTypeText(h.dg_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'electrical_growth:' + getFieldTypeText(h.electrical_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hvac_growth:' + getFieldTypeText(h.hvac_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other_b_growth:' + getFieldTypeText(h.other_b_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'plumbing_growth:' + getFieldTypeText(h.plumbing_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rs_growth:' + getFieldTypeText(h.rs_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'wp_growth:' + getFieldTypeText(h.wp_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chemical_growth:' + getFieldTypeText(h.chemical_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'electronic_growth:' + getFieldTypeText(h.electronic_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'metal_growth:' + getFieldTypeText(h.metal_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other_m_growth:' + getFieldTypeText(h.other_m_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'packaging_growth:' + getFieldTypeText(h.packaging_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pvf_growth:' + getFieldTypeText(h.pvf_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'plastic_growth:' + getFieldTypeText(h.plastic_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'textile_growth:' + getFieldTypeText(h.textile_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bs_growth:' + getFieldTypeText(h.bs_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ce_growth:' + getFieldTypeText(h.ce_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hardware_growth:' + getFieldTypeText(h.hardware_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ie_growth:' + getFieldTypeText(h.ie_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'is_growth:' + getFieldTypeText(h.is_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'it_growth:' + getFieldTypeText(h.it_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mls_growth:' + getFieldTypeText(h.mls_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'os_growth:' + getFieldTypeText(h.os_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pp_growth:' + getFieldTypeText(h.pp_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sis_growth:' + getFieldTypeText(h.sis_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'apparel_growth:' + getFieldTypeText(h.apparel_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'beverages_growth:' + getFieldTypeText(h.beverages_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'constr_growth:' + getFieldTypeText(h.constr_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'consulting_growth:' + getFieldTypeText(h.consulting_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fs_growth:' + getFieldTypeText(h.fs_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fp_growth:' + getFieldTypeText(h.fp_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'insurance_growth:' + getFieldTypeText(h.insurance_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ls_growth:' + getFieldTypeText(h.ls_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'oil_gas_growth:' + getFieldTypeText(h.oil_gas_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'utilities_growth:' + getFieldTypeText(h.utilities_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other_growth:' + getFieldTypeText(h.other_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'advt_growth:' + getFieldTypeText(h.advt_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'top5_growth:' + getFieldTypeText(h.top5_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'shipping_y1:' + getFieldTypeText(h.shipping_y1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'shipping_growth:' + getFieldTypeText(h.shipping_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'materials_y1:' + getFieldTypeText(h.materials_y1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'materials_growth:' + getFieldTypeText(h.materials_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'operations_y1:' + getFieldTypeText(h.operations_y1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'operations_growth:' + getFieldTypeText(h.operations_growth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_paid_average_0t12:' + getFieldTypeText(h.total_paid_average_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_paid_monthspastworst_24:' + getFieldTypeText(h.total_paid_monthspastworst_24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_paid_slope_0t12:' + getFieldTypeText(h.total_paid_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_paid_slope_0t6:' + getFieldTypeText(h.total_paid_slope_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_paid_slope_6t12:' + getFieldTypeText(h.total_paid_slope_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_paid_slope_6t18:' + getFieldTypeText(h.total_paid_slope_6t18) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_paid_volatility_0t12:' + getFieldTypeText(h.total_paid_volatility_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_paid_volatility_0t6:' + getFieldTypeText(h.total_paid_volatility_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_paid_volatility_12t18:' + getFieldTypeText(h.total_paid_volatility_12t18) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_paid_volatility_6t12:' + getFieldTypeText(h.total_paid_volatility_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_spend_monthspastleast_24:' + getFieldTypeText(h.total_spend_monthspastleast_24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_spend_monthspastmost_24:' + getFieldTypeText(h.total_spend_monthspastmost_24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_spend_slope_0t12:' + getFieldTypeText(h.total_spend_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_spend_slope_0t24:' + getFieldTypeText(h.total_spend_slope_0t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_spend_slope_0t6:' + getFieldTypeText(h.total_spend_slope_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_spend_slope_6t12:' + getFieldTypeText(h.total_spend_slope_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_spend_sum_12:' + getFieldTypeText(h.total_spend_sum_12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_spend_volatility_0t12:' + getFieldTypeText(h.total_spend_volatility_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_spend_volatility_0t6:' + getFieldTypeText(h.total_spend_volatility_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_spend_volatility_12t18:' + getFieldTypeText(h.total_spend_volatility_12t18) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_spend_volatility_6t12:' + getFieldTypeText(h.total_spend_volatility_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_paid_average_12:' + getFieldTypeText(h.mfgmat_paid_average_12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_paid_monthspastworst_24:' + getFieldTypeText(h.mfgmat_paid_monthspastworst_24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_paid_slope_0t12:' + getFieldTypeText(h.mfgmat_paid_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_paid_slope_0t24:' + getFieldTypeText(h.mfgmat_paid_slope_0t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_paid_slope_0t6:' + getFieldTypeText(h.mfgmat_paid_slope_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_paid_volatility_0t12:' + getFieldTypeText(h.mfgmat_paid_volatility_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_paid_volatility_0t6:' + getFieldTypeText(h.mfgmat_paid_volatility_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_spend_monthspastleast_24:' + getFieldTypeText(h.mfgmat_spend_monthspastleast_24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_spend_monthspastmost_24:' + getFieldTypeText(h.mfgmat_spend_monthspastmost_24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_spend_slope_0t12:' + getFieldTypeText(h.mfgmat_spend_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_spend_slope_0t24:' + getFieldTypeText(h.mfgmat_spend_slope_0t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_spend_slope_0t6:' + getFieldTypeText(h.mfgmat_spend_slope_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_spend_sum_12:' + getFieldTypeText(h.mfgmat_spend_sum_12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_spend_volatility_0t6:' + getFieldTypeText(h.mfgmat_spend_volatility_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_spend_volatility_6t12:' + getFieldTypeText(h.mfgmat_spend_volatility_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_paid_average_12:' + getFieldTypeText(h.ops_paid_average_12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_paid_monthspastworst_24:' + getFieldTypeText(h.ops_paid_monthspastworst_24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_paid_slope_0t12:' + getFieldTypeText(h.ops_paid_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_paid_slope_0t24:' + getFieldTypeText(h.ops_paid_slope_0t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_paid_slope_0t6:' + getFieldTypeText(h.ops_paid_slope_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_paid_volatility_0t12:' + getFieldTypeText(h.ops_paid_volatility_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_paid_volatility_0t6:' + getFieldTypeText(h.ops_paid_volatility_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_spend_monthspastleast_24:' + getFieldTypeText(h.ops_spend_monthspastleast_24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_spend_monthspastmost_24:' + getFieldTypeText(h.ops_spend_monthspastmost_24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_spend_slope_0t12:' + getFieldTypeText(h.ops_spend_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_spend_slope_0t24:' + getFieldTypeText(h.ops_spend_slope_0t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_spend_slope_0t6:' + getFieldTypeText(h.ops_spend_slope_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_spend_sum_12:' + getFieldTypeText(h.ops_spend_sum_12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_spend_volatility_0t6:' + getFieldTypeText(h.ops_spend_volatility_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_spend_volatility_6t12:' + getFieldTypeText(h.ops_spend_volatility_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_paid_average_12:' + getFieldTypeText(h.fleet_paid_average_12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_paid_monthspastworst_24:' + getFieldTypeText(h.fleet_paid_monthspastworst_24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_paid_slope_0t12:' + getFieldTypeText(h.fleet_paid_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_paid_slope_0t24:' + getFieldTypeText(h.fleet_paid_slope_0t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_paid_slope_0t6:' + getFieldTypeText(h.fleet_paid_slope_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_paid_volatility_0t12:' + getFieldTypeText(h.fleet_paid_volatility_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_paid_volatility_0t6:' + getFieldTypeText(h.fleet_paid_volatility_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_spend_monthspastleast_24:' + getFieldTypeText(h.fleet_spend_monthspastleast_24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_spend_monthspastmost_24:' + getFieldTypeText(h.fleet_spend_monthspastmost_24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_spend_slope_0t12:' + getFieldTypeText(h.fleet_spend_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_spend_slope_0t24:' + getFieldTypeText(h.fleet_spend_slope_0t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_spend_slope_0t6:' + getFieldTypeText(h.fleet_spend_slope_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_spend_sum_12:' + getFieldTypeText(h.fleet_spend_sum_12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_spend_volatility_0t6:' + getFieldTypeText(h.fleet_spend_volatility_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_spend_volatility_6t12:' + getFieldTypeText(h.fleet_spend_volatility_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_paid_average_12:' + getFieldTypeText(h.carrier_paid_average_12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_paid_monthspastworst_24:' + getFieldTypeText(h.carrier_paid_monthspastworst_24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_paid_slope_0t12:' + getFieldTypeText(h.carrier_paid_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_paid_slope_0t24:' + getFieldTypeText(h.carrier_paid_slope_0t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_paid_slope_0t6:' + getFieldTypeText(h.carrier_paid_slope_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_paid_volatility_0t12:' + getFieldTypeText(h.carrier_paid_volatility_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_paid_volatility_0t6:' + getFieldTypeText(h.carrier_paid_volatility_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_spend_monthspastleast_24:' + getFieldTypeText(h.carrier_spend_monthspastleast_24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_spend_monthspastmost_24:' + getFieldTypeText(h.carrier_spend_monthspastmost_24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_spend_slope_0t12:' + getFieldTypeText(h.carrier_spend_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_spend_slope_0t24:' + getFieldTypeText(h.carrier_spend_slope_0t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_spend_slope_0t6:' + getFieldTypeText(h.carrier_spend_slope_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_spend_sum_12:' + getFieldTypeText(h.carrier_spend_sum_12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_spend_volatility_0t6:' + getFieldTypeText(h.carrier_spend_volatility_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_spend_volatility_6t12:' + getFieldTypeText(h.carrier_spend_volatility_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_paid_average_12:' + getFieldTypeText(h.bldgmats_paid_average_12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_paid_monthspastworst_24:' + getFieldTypeText(h.bldgmats_paid_monthspastworst_24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_paid_slope_0t12:' + getFieldTypeText(h.bldgmats_paid_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_paid_slope_0t24:' + getFieldTypeText(h.bldgmats_paid_slope_0t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_paid_slope_0t6:' + getFieldTypeText(h.bldgmats_paid_slope_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_paid_volatility_0t12:' + getFieldTypeText(h.bldgmats_paid_volatility_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_paid_volatility_0t6:' + getFieldTypeText(h.bldgmats_paid_volatility_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_spend_monthspastleast_24:' + getFieldTypeText(h.bldgmats_spend_monthspastleast_24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_spend_monthspastmost_24:' + getFieldTypeText(h.bldgmats_spend_monthspastmost_24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_spend_slope_0t12:' + getFieldTypeText(h.bldgmats_spend_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_spend_slope_0t24:' + getFieldTypeText(h.bldgmats_spend_slope_0t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_spend_slope_0t6:' + getFieldTypeText(h.bldgmats_spend_slope_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_spend_sum_12:' + getFieldTypeText(h.bldgmats_spend_sum_12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_spend_volatility_0t6:' + getFieldTypeText(h.bldgmats_spend_volatility_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_spend_volatility_6t12:' + getFieldTypeText(h.bldgmats_spend_volatility_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'top5_paid_average_12:' + getFieldTypeText(h.top5_paid_average_12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'top5_paid_monthspastworst_24:' + getFieldTypeText(h.top5_paid_monthspastworst_24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'top5_paid_slope_0t12:' + getFieldTypeText(h.top5_paid_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'top5_paid_slope_0t24:' + getFieldTypeText(h.top5_paid_slope_0t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'top5_paid_slope_0t6:' + getFieldTypeText(h.top5_paid_slope_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'top5_paid_volatility_0t12:' + getFieldTypeText(h.top5_paid_volatility_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'top5_paid_volatility_0t6:' + getFieldTypeText(h.top5_paid_volatility_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'top5_spend_monthspastleast_24:' + getFieldTypeText(h.top5_spend_monthspastleast_24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'top5_spend_monthspastmost_24:' + getFieldTypeText(h.top5_spend_monthspastmost_24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'top5_spend_slope_0t12:' + getFieldTypeText(h.top5_spend_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'top5_spend_slope_0t24:' + getFieldTypeText(h.top5_spend_slope_0t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'top5_spend_slope_0t6:' + getFieldTypeText(h.top5_spend_slope_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'top5_spend_sum_12:' + getFieldTypeText(h.top5_spend_sum_12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'top5_spend_volatility_0t6:' + getFieldTypeText(h.top5_spend_volatility_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'top5_spend_volatility_6t12:' + getFieldTypeText(h.top5_spend_volatility_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_numrel_avg12:' + getFieldTypeText(h.total_numrel_avg12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_numrel_monthpspastmost_24:' + getFieldTypeText(h.total_numrel_monthpspastmost_24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_numrel_monthspastleast_24:' + getFieldTypeText(h.total_numrel_monthspastleast_24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_numrel_slope_0t12:' + getFieldTypeText(h.total_numrel_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_numrel_slope_0t24:' + getFieldTypeText(h.total_numrel_slope_0t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_numrel_slope_0t6:' + getFieldTypeText(h.total_numrel_slope_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_numrel_slope_6t12:' + getFieldTypeText(h.total_numrel_slope_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_numrel_var_0t12:' + getFieldTypeText(h.total_numrel_var_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_numrel_var_0t24:' + getFieldTypeText(h.total_numrel_var_0t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_numrel_var_12t24:' + getFieldTypeText(h.total_numrel_var_12t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_numrel_var_6t18:' + getFieldTypeText(h.total_numrel_var_6t18) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_numrel_avg12:' + getFieldTypeText(h.mfgmat_numrel_avg12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_numrel_slope_0t12:' + getFieldTypeText(h.mfgmat_numrel_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_numrel_slope_0t24:' + getFieldTypeText(h.mfgmat_numrel_slope_0t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_numrel_slope_0t6:' + getFieldTypeText(h.mfgmat_numrel_slope_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_numrel_slope_6t12:' + getFieldTypeText(h.mfgmat_numrel_slope_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_numrel_var_0t12:' + getFieldTypeText(h.mfgmat_numrel_var_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_numrel_var_12t24:' + getFieldTypeText(h.mfgmat_numrel_var_12t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_numrel_avg12:' + getFieldTypeText(h.ops_numrel_avg12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_numrel_slope_0t12:' + getFieldTypeText(h.ops_numrel_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_numrel_slope_0t24:' + getFieldTypeText(h.ops_numrel_slope_0t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_numrel_slope_0t6:' + getFieldTypeText(h.ops_numrel_slope_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_numrel_slope_6t12:' + getFieldTypeText(h.ops_numrel_slope_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_numrel_var_0t12:' + getFieldTypeText(h.ops_numrel_var_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_numrel_var_12t24:' + getFieldTypeText(h.ops_numrel_var_12t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_numrel_avg12:' + getFieldTypeText(h.fleet_numrel_avg12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_numrel_slope_0t12:' + getFieldTypeText(h.fleet_numrel_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_numrel_slope_0t24:' + getFieldTypeText(h.fleet_numrel_slope_0t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_numrel_slope_0t6:' + getFieldTypeText(h.fleet_numrel_slope_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_numrel_slope_6t12:' + getFieldTypeText(h.fleet_numrel_slope_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_numrel_var_0t12:' + getFieldTypeText(h.fleet_numrel_var_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_numrel_var_12t24:' + getFieldTypeText(h.fleet_numrel_var_12t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_numrel_avg12:' + getFieldTypeText(h.carrier_numrel_avg12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_numrel_slope_0t12:' + getFieldTypeText(h.carrier_numrel_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_numrel_slope_0t24:' + getFieldTypeText(h.carrier_numrel_slope_0t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_numrel_slope_0t6:' + getFieldTypeText(h.carrier_numrel_slope_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_numrel_slope_6t12:' + getFieldTypeText(h.carrier_numrel_slope_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_numrel_var_0t12:' + getFieldTypeText(h.carrier_numrel_var_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_numrel_var_12t24:' + getFieldTypeText(h.carrier_numrel_var_12t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_numrel_avg12:' + getFieldTypeText(h.bldgmats_numrel_avg12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_numrel_slope_0t12:' + getFieldTypeText(h.bldgmats_numrel_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_numrel_slope_0t24:' + getFieldTypeText(h.bldgmats_numrel_slope_0t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_numrel_slope_0t6:' + getFieldTypeText(h.bldgmats_numrel_slope_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_numrel_slope_6t12:' + getFieldTypeText(h.bldgmats_numrel_slope_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_numrel_var_0t12:' + getFieldTypeText(h.bldgmats_numrel_var_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_numrel_var_12t24:' + getFieldTypeText(h.bldgmats_numrel_var_12t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_monthsoutstanding_slope24:' + getFieldTypeText(h.total_monthsoutstanding_slope24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_percprov30_avg_0t12:' + getFieldTypeText(h.total_percprov30_avg_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_percprov30_slope_0t12:' + getFieldTypeText(h.total_percprov30_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_percprov30_slope_0t24:' + getFieldTypeText(h.total_percprov30_slope_0t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_percprov30_slope_0t6:' + getFieldTypeText(h.total_percprov30_slope_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_percprov30_slope_6t12:' + getFieldTypeText(h.total_percprov30_slope_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_percprov60_avg_0t12:' + getFieldTypeText(h.total_percprov60_avg_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_percprov60_slope_0t12:' + getFieldTypeText(h.total_percprov60_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_percprov60_slope_0t24:' + getFieldTypeText(h.total_percprov60_slope_0t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_percprov60_slope_0t6:' + getFieldTypeText(h.total_percprov60_slope_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_percprov60_slope_6t12:' + getFieldTypeText(h.total_percprov60_slope_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_percprov90_avg_0t12:' + getFieldTypeText(h.total_percprov90_avg_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_percprov90_lowerlim_0t12:' + getFieldTypeText(h.total_percprov90_lowerlim_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_percprov90_slope_0t24:' + getFieldTypeText(h.total_percprov90_slope_0t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_percprov90_slope_0t6:' + getFieldTypeText(h.total_percprov90_slope_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_percprov90_slope_6t12:' + getFieldTypeText(h.total_percprov90_slope_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_percprovoutstanding_adjustedslope_0t12:' + getFieldTypeText(h.total_percprovoutstanding_adjustedslope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_monthsoutstanding_slope24:' + getFieldTypeText(h.mfgmat_monthsoutstanding_slope24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_percprov30_slope_0t12:' + getFieldTypeText(h.mfgmat_percprov30_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_percprov30_slope_6t12:' + getFieldTypeText(h.mfgmat_percprov30_slope_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_percprov60_slope_0t12:' + getFieldTypeText(h.mfgmat_percprov60_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_percprov60_slope_6t12:' + getFieldTypeText(h.mfgmat_percprov60_slope_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_percprov90_slope_0t24:' + getFieldTypeText(h.mfgmat_percprov90_slope_0t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_percprov90_slope_0t6:' + getFieldTypeText(h.mfgmat_percprov90_slope_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_percprov90_slope_6t12:' + getFieldTypeText(h.mfgmat_percprov90_slope_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfgmat_percprovoutstanding_adjustedslope_0t12:' + getFieldTypeText(h.mfgmat_percprovoutstanding_adjustedslope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_monthsoutstanding_slope24:' + getFieldTypeText(h.ops_monthsoutstanding_slope24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_percprov30_slope_0t12:' + getFieldTypeText(h.ops_percprov30_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_percprov30_slope_6t12:' + getFieldTypeText(h.ops_percprov30_slope_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_percprov60_slope_0t12:' + getFieldTypeText(h.ops_percprov60_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_percprov60_slope_6t12:' + getFieldTypeText(h.ops_percprov60_slope_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_percprov90_slope_0t24:' + getFieldTypeText(h.ops_percprov90_slope_0t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_percprov90_slope_0t6:' + getFieldTypeText(h.ops_percprov90_slope_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_percprov90_slope_6t12:' + getFieldTypeText(h.ops_percprov90_slope_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ops_percprovoutstanding_adjustedslope_0t12:' + getFieldTypeText(h.ops_percprovoutstanding_adjustedslope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_monthsoutstanding_slope24:' + getFieldTypeText(h.fleet_monthsoutstanding_slope24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_percprov30_slope_0t12:' + getFieldTypeText(h.fleet_percprov30_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_percprov30_slope_6t12:' + getFieldTypeText(h.fleet_percprov30_slope_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_percprov60_slope_0t12:' + getFieldTypeText(h.fleet_percprov60_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_percprov60_slope_6t12:' + getFieldTypeText(h.fleet_percprov60_slope_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_percprov90_slope_0t24:' + getFieldTypeText(h.fleet_percprov90_slope_0t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_percprov90_slope_0t6:' + getFieldTypeText(h.fleet_percprov90_slope_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_percprov90_slope_6t12:' + getFieldTypeText(h.fleet_percprov90_slope_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fleet_percprovoutstanding_adjustedslope_0t12:' + getFieldTypeText(h.fleet_percprovoutstanding_adjustedslope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_monthsoutstanding_slope24:' + getFieldTypeText(h.carrier_monthsoutstanding_slope24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_percprov30_slope_0t12:' + getFieldTypeText(h.carrier_percprov30_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_percprov30_slope_6t12:' + getFieldTypeText(h.carrier_percprov30_slope_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_percprov60_slope_0t12:' + getFieldTypeText(h.carrier_percprov60_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_percprov60_slope_6t12:' + getFieldTypeText(h.carrier_percprov60_slope_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_percprov90_slope_0t24:' + getFieldTypeText(h.carrier_percprov90_slope_0t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_percprov90_slope_0t6:' + getFieldTypeText(h.carrier_percprov90_slope_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_percprov90_slope_6t12:' + getFieldTypeText(h.carrier_percprov90_slope_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_percprovoutstanding_adjustedslope_0t12:' + getFieldTypeText(h.carrier_percprovoutstanding_adjustedslope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_monthsoutstanding_slope24:' + getFieldTypeText(h.bldgmats_monthsoutstanding_slope24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_percprov30_slope_0t12:' + getFieldTypeText(h.bldgmats_percprov30_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_percprov30_slope_6t12:' + getFieldTypeText(h.bldgmats_percprov30_slope_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_percprov60_slope_0t12:' + getFieldTypeText(h.bldgmats_percprov60_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_percprov60_slope_6t12:' + getFieldTypeText(h.bldgmats_percprov60_slope_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_percprov90_slope_0t24:' + getFieldTypeText(h.bldgmats_percprov90_slope_0t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_percprov90_slope_0t6:' + getFieldTypeText(h.bldgmats_percprov90_slope_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_percprov90_slope_6t12:' + getFieldTypeText(h.bldgmats_percprov90_slope_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bldgmats_percprovoutstanding_adjustedslope_0t12:' + getFieldTypeText(h.bldgmats_percprovoutstanding_adjustedslope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'top5_monthsoutstanding_slope24:' + getFieldTypeText(h.top5_monthsoutstanding_slope24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'top5_percprov30_slope_0t12:' + getFieldTypeText(h.top5_percprov30_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'top5_percprov30_slope_6t12:' + getFieldTypeText(h.top5_percprov30_slope_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'top5_percprov60_slope_0t12:' + getFieldTypeText(h.top5_percprov60_slope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'top5_percprov60_slope_6t12:' + getFieldTypeText(h.top5_percprov60_slope_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'top5_percprov90_slope_0t24:' + getFieldTypeText(h.top5_percprov90_slope_0t24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'top5_percprov90_slope_0t6:' + getFieldTypeText(h.top5_percprov90_slope_0t6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'top5_percprov90_slope_6t12:' + getFieldTypeText(h.top5_percprov90_slope_6t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'top5_percprovoutstanding_adjustedslope_0t12:' + getFieldTypeText(h.top5_percprovoutstanding_adjustedslope_0t12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_ultimate_linkid_cnt
          ,le.populated_cortera_score_cnt
          ,le.populated_cpr_score_cnt
          ,le.populated_cpr_segment_cnt
          ,le.populated_dbt_cnt
          ,le.populated_avg_bal_cnt
          ,le.populated_air_spend_cnt
          ,le.populated_fuel_spend_cnt
          ,le.populated_leasing_spend_cnt
          ,le.populated_ltl_spend_cnt
          ,le.populated_rail_spend_cnt
          ,le.populated_tl_spend_cnt
          ,le.populated_transvc_spend_cnt
          ,le.populated_transup_spend_cnt
          ,le.populated_bst_spend_cnt
          ,le.populated_dg_spend_cnt
          ,le.populated_electrical_spend_cnt
          ,le.populated_hvac_spend_cnt
          ,le.populated_other_b_spend_cnt
          ,le.populated_plumbing_spend_cnt
          ,le.populated_rs_spend_cnt
          ,le.populated_wp_spend_cnt
          ,le.populated_chemical_spend_cnt
          ,le.populated_electronic_spend_cnt
          ,le.populated_metal_spend_cnt
          ,le.populated_other_m_spend_cnt
          ,le.populated_packaging_spend_cnt
          ,le.populated_pvf_spend_cnt
          ,le.populated_plastic_spend_cnt
          ,le.populated_textile_spend_cnt
          ,le.populated_bs_spend_cnt
          ,le.populated_ce_spend_cnt
          ,le.populated_hardware_spend_cnt
          ,le.populated_ie_spend_cnt
          ,le.populated_is_spend_cnt
          ,le.populated_it_spend_cnt
          ,le.populated_mls_spend_cnt
          ,le.populated_os_spend_cnt
          ,le.populated_pp_spend_cnt
          ,le.populated_sis_spend_cnt
          ,le.populated_apparel_spend_cnt
          ,le.populated_beverages_spend_cnt
          ,le.populated_constr_spend_cnt
          ,le.populated_consulting_spend_cnt
          ,le.populated_fs_spend_cnt
          ,le.populated_fp_spend_cnt
          ,le.populated_insurance_spend_cnt
          ,le.populated_ls_spend_cnt
          ,le.populated_oil_gas_spend_cnt
          ,le.populated_utilities_spend_cnt
          ,le.populated_other_spend_cnt
          ,le.populated_advt_spend_cnt
          ,le.populated_air_growth_cnt
          ,le.populated_fuel_growth_cnt
          ,le.populated_leasing_growth_cnt
          ,le.populated_ltl_growth_cnt
          ,le.populated_rail_growth_cnt
          ,le.populated_tl_growth_cnt
          ,le.populated_transvc_growth_cnt
          ,le.populated_transup_growth_cnt
          ,le.populated_bst_growth_cnt
          ,le.populated_dg_growth_cnt
          ,le.populated_electrical_growth_cnt
          ,le.populated_hvac_growth_cnt
          ,le.populated_other_b_growth_cnt
          ,le.populated_plumbing_growth_cnt
          ,le.populated_rs_growth_cnt
          ,le.populated_wp_growth_cnt
          ,le.populated_chemical_growth_cnt
          ,le.populated_electronic_growth_cnt
          ,le.populated_metal_growth_cnt
          ,le.populated_other_m_growth_cnt
          ,le.populated_packaging_growth_cnt
          ,le.populated_pvf_growth_cnt
          ,le.populated_plastic_growth_cnt
          ,le.populated_textile_growth_cnt
          ,le.populated_bs_growth_cnt
          ,le.populated_ce_growth_cnt
          ,le.populated_hardware_growth_cnt
          ,le.populated_ie_growth_cnt
          ,le.populated_is_growth_cnt
          ,le.populated_it_growth_cnt
          ,le.populated_mls_growth_cnt
          ,le.populated_os_growth_cnt
          ,le.populated_pp_growth_cnt
          ,le.populated_sis_growth_cnt
          ,le.populated_apparel_growth_cnt
          ,le.populated_beverages_growth_cnt
          ,le.populated_constr_growth_cnt
          ,le.populated_consulting_growth_cnt
          ,le.populated_fs_growth_cnt
          ,le.populated_fp_growth_cnt
          ,le.populated_insurance_growth_cnt
          ,le.populated_ls_growth_cnt
          ,le.populated_oil_gas_growth_cnt
          ,le.populated_utilities_growth_cnt
          ,le.populated_other_growth_cnt
          ,le.populated_advt_growth_cnt
          ,le.populated_top5_growth_cnt
          ,le.populated_shipping_y1_cnt
          ,le.populated_shipping_growth_cnt
          ,le.populated_materials_y1_cnt
          ,le.populated_materials_growth_cnt
          ,le.populated_operations_y1_cnt
          ,le.populated_operations_growth_cnt
          ,le.populated_total_paid_average_0t12_cnt
          ,le.populated_total_paid_monthspastworst_24_cnt
          ,le.populated_total_paid_slope_0t12_cnt
          ,le.populated_total_paid_slope_0t6_cnt
          ,le.populated_total_paid_slope_6t12_cnt
          ,le.populated_total_paid_slope_6t18_cnt
          ,le.populated_total_paid_volatility_0t12_cnt
          ,le.populated_total_paid_volatility_0t6_cnt
          ,le.populated_total_paid_volatility_12t18_cnt
          ,le.populated_total_paid_volatility_6t12_cnt
          ,le.populated_total_spend_monthspastleast_24_cnt
          ,le.populated_total_spend_monthspastmost_24_cnt
          ,le.populated_total_spend_slope_0t12_cnt
          ,le.populated_total_spend_slope_0t24_cnt
          ,le.populated_total_spend_slope_0t6_cnt
          ,le.populated_total_spend_slope_6t12_cnt
          ,le.populated_total_spend_sum_12_cnt
          ,le.populated_total_spend_volatility_0t12_cnt
          ,le.populated_total_spend_volatility_0t6_cnt
          ,le.populated_total_spend_volatility_12t18_cnt
          ,le.populated_total_spend_volatility_6t12_cnt
          ,le.populated_mfgmat_paid_average_12_cnt
          ,le.populated_mfgmat_paid_monthspastworst_24_cnt
          ,le.populated_mfgmat_paid_slope_0t12_cnt
          ,le.populated_mfgmat_paid_slope_0t24_cnt
          ,le.populated_mfgmat_paid_slope_0t6_cnt
          ,le.populated_mfgmat_paid_volatility_0t12_cnt
          ,le.populated_mfgmat_paid_volatility_0t6_cnt
          ,le.populated_mfgmat_spend_monthspastleast_24_cnt
          ,le.populated_mfgmat_spend_monthspastmost_24_cnt
          ,le.populated_mfgmat_spend_slope_0t12_cnt
          ,le.populated_mfgmat_spend_slope_0t24_cnt
          ,le.populated_mfgmat_spend_slope_0t6_cnt
          ,le.populated_mfgmat_spend_sum_12_cnt
          ,le.populated_mfgmat_spend_volatility_0t6_cnt
          ,le.populated_mfgmat_spend_volatility_6t12_cnt
          ,le.populated_ops_paid_average_12_cnt
          ,le.populated_ops_paid_monthspastworst_24_cnt
          ,le.populated_ops_paid_slope_0t12_cnt
          ,le.populated_ops_paid_slope_0t24_cnt
          ,le.populated_ops_paid_slope_0t6_cnt
          ,le.populated_ops_paid_volatility_0t12_cnt
          ,le.populated_ops_paid_volatility_0t6_cnt
          ,le.populated_ops_spend_monthspastleast_24_cnt
          ,le.populated_ops_spend_monthspastmost_24_cnt
          ,le.populated_ops_spend_slope_0t12_cnt
          ,le.populated_ops_spend_slope_0t24_cnt
          ,le.populated_ops_spend_slope_0t6_cnt
          ,le.populated_ops_spend_sum_12_cnt
          ,le.populated_ops_spend_volatility_0t6_cnt
          ,le.populated_ops_spend_volatility_6t12_cnt
          ,le.populated_fleet_paid_average_12_cnt
          ,le.populated_fleet_paid_monthspastworst_24_cnt
          ,le.populated_fleet_paid_slope_0t12_cnt
          ,le.populated_fleet_paid_slope_0t24_cnt
          ,le.populated_fleet_paid_slope_0t6_cnt
          ,le.populated_fleet_paid_volatility_0t12_cnt
          ,le.populated_fleet_paid_volatility_0t6_cnt
          ,le.populated_fleet_spend_monthspastleast_24_cnt
          ,le.populated_fleet_spend_monthspastmost_24_cnt
          ,le.populated_fleet_spend_slope_0t12_cnt
          ,le.populated_fleet_spend_slope_0t24_cnt
          ,le.populated_fleet_spend_slope_0t6_cnt
          ,le.populated_fleet_spend_sum_12_cnt
          ,le.populated_fleet_spend_volatility_0t6_cnt
          ,le.populated_fleet_spend_volatility_6t12_cnt
          ,le.populated_carrier_paid_average_12_cnt
          ,le.populated_carrier_paid_monthspastworst_24_cnt
          ,le.populated_carrier_paid_slope_0t12_cnt
          ,le.populated_carrier_paid_slope_0t24_cnt
          ,le.populated_carrier_paid_slope_0t6_cnt
          ,le.populated_carrier_paid_volatility_0t12_cnt
          ,le.populated_carrier_paid_volatility_0t6_cnt
          ,le.populated_carrier_spend_monthspastleast_24_cnt
          ,le.populated_carrier_spend_monthspastmost_24_cnt
          ,le.populated_carrier_spend_slope_0t12_cnt
          ,le.populated_carrier_spend_slope_0t24_cnt
          ,le.populated_carrier_spend_slope_0t6_cnt
          ,le.populated_carrier_spend_sum_12_cnt
          ,le.populated_carrier_spend_volatility_0t6_cnt
          ,le.populated_carrier_spend_volatility_6t12_cnt
          ,le.populated_bldgmats_paid_average_12_cnt
          ,le.populated_bldgmats_paid_monthspastworst_24_cnt
          ,le.populated_bldgmats_paid_slope_0t12_cnt
          ,le.populated_bldgmats_paid_slope_0t24_cnt
          ,le.populated_bldgmats_paid_slope_0t6_cnt
          ,le.populated_bldgmats_paid_volatility_0t12_cnt
          ,le.populated_bldgmats_paid_volatility_0t6_cnt
          ,le.populated_bldgmats_spend_monthspastleast_24_cnt
          ,le.populated_bldgmats_spend_monthspastmost_24_cnt
          ,le.populated_bldgmats_spend_slope_0t12_cnt
          ,le.populated_bldgmats_spend_slope_0t24_cnt
          ,le.populated_bldgmats_spend_slope_0t6_cnt
          ,le.populated_bldgmats_spend_sum_12_cnt
          ,le.populated_bldgmats_spend_volatility_0t6_cnt
          ,le.populated_bldgmats_spend_volatility_6t12_cnt
          ,le.populated_top5_paid_average_12_cnt
          ,le.populated_top5_paid_monthspastworst_24_cnt
          ,le.populated_top5_paid_slope_0t12_cnt
          ,le.populated_top5_paid_slope_0t24_cnt
          ,le.populated_top5_paid_slope_0t6_cnt
          ,le.populated_top5_paid_volatility_0t12_cnt
          ,le.populated_top5_paid_volatility_0t6_cnt
          ,le.populated_top5_spend_monthspastleast_24_cnt
          ,le.populated_top5_spend_monthspastmost_24_cnt
          ,le.populated_top5_spend_slope_0t12_cnt
          ,le.populated_top5_spend_slope_0t24_cnt
          ,le.populated_top5_spend_slope_0t6_cnt
          ,le.populated_top5_spend_sum_12_cnt
          ,le.populated_top5_spend_volatility_0t6_cnt
          ,le.populated_top5_spend_volatility_6t12_cnt
          ,le.populated_total_numrel_avg12_cnt
          ,le.populated_total_numrel_monthpspastmost_24_cnt
          ,le.populated_total_numrel_monthspastleast_24_cnt
          ,le.populated_total_numrel_slope_0t12_cnt
          ,le.populated_total_numrel_slope_0t24_cnt
          ,le.populated_total_numrel_slope_0t6_cnt
          ,le.populated_total_numrel_slope_6t12_cnt
          ,le.populated_total_numrel_var_0t12_cnt
          ,le.populated_total_numrel_var_0t24_cnt
          ,le.populated_total_numrel_var_12t24_cnt
          ,le.populated_total_numrel_var_6t18_cnt
          ,le.populated_mfgmat_numrel_avg12_cnt
          ,le.populated_mfgmat_numrel_slope_0t12_cnt
          ,le.populated_mfgmat_numrel_slope_0t24_cnt
          ,le.populated_mfgmat_numrel_slope_0t6_cnt
          ,le.populated_mfgmat_numrel_slope_6t12_cnt
          ,le.populated_mfgmat_numrel_var_0t12_cnt
          ,le.populated_mfgmat_numrel_var_12t24_cnt
          ,le.populated_ops_numrel_avg12_cnt
          ,le.populated_ops_numrel_slope_0t12_cnt
          ,le.populated_ops_numrel_slope_0t24_cnt
          ,le.populated_ops_numrel_slope_0t6_cnt
          ,le.populated_ops_numrel_slope_6t12_cnt
          ,le.populated_ops_numrel_var_0t12_cnt
          ,le.populated_ops_numrel_var_12t24_cnt
          ,le.populated_fleet_numrel_avg12_cnt
          ,le.populated_fleet_numrel_slope_0t12_cnt
          ,le.populated_fleet_numrel_slope_0t24_cnt
          ,le.populated_fleet_numrel_slope_0t6_cnt
          ,le.populated_fleet_numrel_slope_6t12_cnt
          ,le.populated_fleet_numrel_var_0t12_cnt
          ,le.populated_fleet_numrel_var_12t24_cnt
          ,le.populated_carrier_numrel_avg12_cnt
          ,le.populated_carrier_numrel_slope_0t12_cnt
          ,le.populated_carrier_numrel_slope_0t24_cnt
          ,le.populated_carrier_numrel_slope_0t6_cnt
          ,le.populated_carrier_numrel_slope_6t12_cnt
          ,le.populated_carrier_numrel_var_0t12_cnt
          ,le.populated_carrier_numrel_var_12t24_cnt
          ,le.populated_bldgmats_numrel_avg12_cnt
          ,le.populated_bldgmats_numrel_slope_0t12_cnt
          ,le.populated_bldgmats_numrel_slope_0t24_cnt
          ,le.populated_bldgmats_numrel_slope_0t6_cnt
          ,le.populated_bldgmats_numrel_slope_6t12_cnt
          ,le.populated_bldgmats_numrel_var_0t12_cnt
          ,le.populated_bldgmats_numrel_var_12t24_cnt
          ,le.populated_total_monthsoutstanding_slope24_cnt
          ,le.populated_total_percprov30_avg_0t12_cnt
          ,le.populated_total_percprov30_slope_0t12_cnt
          ,le.populated_total_percprov30_slope_0t24_cnt
          ,le.populated_total_percprov30_slope_0t6_cnt
          ,le.populated_total_percprov30_slope_6t12_cnt
          ,le.populated_total_percprov60_avg_0t12_cnt
          ,le.populated_total_percprov60_slope_0t12_cnt
          ,le.populated_total_percprov60_slope_0t24_cnt
          ,le.populated_total_percprov60_slope_0t6_cnt
          ,le.populated_total_percprov60_slope_6t12_cnt
          ,le.populated_total_percprov90_avg_0t12_cnt
          ,le.populated_total_percprov90_lowerlim_0t12_cnt
          ,le.populated_total_percprov90_slope_0t24_cnt
          ,le.populated_total_percprov90_slope_0t6_cnt
          ,le.populated_total_percprov90_slope_6t12_cnt
          ,le.populated_total_percprovoutstanding_adjustedslope_0t12_cnt
          ,le.populated_mfgmat_monthsoutstanding_slope24_cnt
          ,le.populated_mfgmat_percprov30_slope_0t12_cnt
          ,le.populated_mfgmat_percprov30_slope_6t12_cnt
          ,le.populated_mfgmat_percprov60_slope_0t12_cnt
          ,le.populated_mfgmat_percprov60_slope_6t12_cnt
          ,le.populated_mfgmat_percprov90_slope_0t24_cnt
          ,le.populated_mfgmat_percprov90_slope_0t6_cnt
          ,le.populated_mfgmat_percprov90_slope_6t12_cnt
          ,le.populated_mfgmat_percprovoutstanding_adjustedslope_0t12_cnt
          ,le.populated_ops_monthsoutstanding_slope24_cnt
          ,le.populated_ops_percprov30_slope_0t12_cnt
          ,le.populated_ops_percprov30_slope_6t12_cnt
          ,le.populated_ops_percprov60_slope_0t12_cnt
          ,le.populated_ops_percprov60_slope_6t12_cnt
          ,le.populated_ops_percprov90_slope_0t24_cnt
          ,le.populated_ops_percprov90_slope_0t6_cnt
          ,le.populated_ops_percprov90_slope_6t12_cnt
          ,le.populated_ops_percprovoutstanding_adjustedslope_0t12_cnt
          ,le.populated_fleet_monthsoutstanding_slope24_cnt
          ,le.populated_fleet_percprov30_slope_0t12_cnt
          ,le.populated_fleet_percprov30_slope_6t12_cnt
          ,le.populated_fleet_percprov60_slope_0t12_cnt
          ,le.populated_fleet_percprov60_slope_6t12_cnt
          ,le.populated_fleet_percprov90_slope_0t24_cnt
          ,le.populated_fleet_percprov90_slope_0t6_cnt
          ,le.populated_fleet_percprov90_slope_6t12_cnt
          ,le.populated_fleet_percprovoutstanding_adjustedslope_0t12_cnt
          ,le.populated_carrier_monthsoutstanding_slope24_cnt
          ,le.populated_carrier_percprov30_slope_0t12_cnt
          ,le.populated_carrier_percprov30_slope_6t12_cnt
          ,le.populated_carrier_percprov60_slope_0t12_cnt
          ,le.populated_carrier_percprov60_slope_6t12_cnt
          ,le.populated_carrier_percprov90_slope_0t24_cnt
          ,le.populated_carrier_percprov90_slope_0t6_cnt
          ,le.populated_carrier_percprov90_slope_6t12_cnt
          ,le.populated_carrier_percprovoutstanding_adjustedslope_0t12_cnt
          ,le.populated_bldgmats_monthsoutstanding_slope24_cnt
          ,le.populated_bldgmats_percprov30_slope_0t12_cnt
          ,le.populated_bldgmats_percprov30_slope_6t12_cnt
          ,le.populated_bldgmats_percprov60_slope_0t12_cnt
          ,le.populated_bldgmats_percprov60_slope_6t12_cnt
          ,le.populated_bldgmats_percprov90_slope_0t24_cnt
          ,le.populated_bldgmats_percprov90_slope_0t6_cnt
          ,le.populated_bldgmats_percprov90_slope_6t12_cnt
          ,le.populated_bldgmats_percprovoutstanding_adjustedslope_0t12_cnt
          ,le.populated_top5_monthsoutstanding_slope24_cnt
          ,le.populated_top5_percprov30_slope_0t12_cnt
          ,le.populated_top5_percprov30_slope_6t12_cnt
          ,le.populated_top5_percprov60_slope_0t12_cnt
          ,le.populated_top5_percprov60_slope_6t12_cnt
          ,le.populated_top5_percprov90_slope_0t24_cnt
          ,le.populated_top5_percprov90_slope_0t6_cnt
          ,le.populated_top5_percprov90_slope_6t12_cnt
          ,le.populated_top5_percprovoutstanding_adjustedslope_0t12_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_ultimate_linkid_pcnt
          ,le.populated_cortera_score_pcnt
          ,le.populated_cpr_score_pcnt
          ,le.populated_cpr_segment_pcnt
          ,le.populated_dbt_pcnt
          ,le.populated_avg_bal_pcnt
          ,le.populated_air_spend_pcnt
          ,le.populated_fuel_spend_pcnt
          ,le.populated_leasing_spend_pcnt
          ,le.populated_ltl_spend_pcnt
          ,le.populated_rail_spend_pcnt
          ,le.populated_tl_spend_pcnt
          ,le.populated_transvc_spend_pcnt
          ,le.populated_transup_spend_pcnt
          ,le.populated_bst_spend_pcnt
          ,le.populated_dg_spend_pcnt
          ,le.populated_electrical_spend_pcnt
          ,le.populated_hvac_spend_pcnt
          ,le.populated_other_b_spend_pcnt
          ,le.populated_plumbing_spend_pcnt
          ,le.populated_rs_spend_pcnt
          ,le.populated_wp_spend_pcnt
          ,le.populated_chemical_spend_pcnt
          ,le.populated_electronic_spend_pcnt
          ,le.populated_metal_spend_pcnt
          ,le.populated_other_m_spend_pcnt
          ,le.populated_packaging_spend_pcnt
          ,le.populated_pvf_spend_pcnt
          ,le.populated_plastic_spend_pcnt
          ,le.populated_textile_spend_pcnt
          ,le.populated_bs_spend_pcnt
          ,le.populated_ce_spend_pcnt
          ,le.populated_hardware_spend_pcnt
          ,le.populated_ie_spend_pcnt
          ,le.populated_is_spend_pcnt
          ,le.populated_it_spend_pcnt
          ,le.populated_mls_spend_pcnt
          ,le.populated_os_spend_pcnt
          ,le.populated_pp_spend_pcnt
          ,le.populated_sis_spend_pcnt
          ,le.populated_apparel_spend_pcnt
          ,le.populated_beverages_spend_pcnt
          ,le.populated_constr_spend_pcnt
          ,le.populated_consulting_spend_pcnt
          ,le.populated_fs_spend_pcnt
          ,le.populated_fp_spend_pcnt
          ,le.populated_insurance_spend_pcnt
          ,le.populated_ls_spend_pcnt
          ,le.populated_oil_gas_spend_pcnt
          ,le.populated_utilities_spend_pcnt
          ,le.populated_other_spend_pcnt
          ,le.populated_advt_spend_pcnt
          ,le.populated_air_growth_pcnt
          ,le.populated_fuel_growth_pcnt
          ,le.populated_leasing_growth_pcnt
          ,le.populated_ltl_growth_pcnt
          ,le.populated_rail_growth_pcnt
          ,le.populated_tl_growth_pcnt
          ,le.populated_transvc_growth_pcnt
          ,le.populated_transup_growth_pcnt
          ,le.populated_bst_growth_pcnt
          ,le.populated_dg_growth_pcnt
          ,le.populated_electrical_growth_pcnt
          ,le.populated_hvac_growth_pcnt
          ,le.populated_other_b_growth_pcnt
          ,le.populated_plumbing_growth_pcnt
          ,le.populated_rs_growth_pcnt
          ,le.populated_wp_growth_pcnt
          ,le.populated_chemical_growth_pcnt
          ,le.populated_electronic_growth_pcnt
          ,le.populated_metal_growth_pcnt
          ,le.populated_other_m_growth_pcnt
          ,le.populated_packaging_growth_pcnt
          ,le.populated_pvf_growth_pcnt
          ,le.populated_plastic_growth_pcnt
          ,le.populated_textile_growth_pcnt
          ,le.populated_bs_growth_pcnt
          ,le.populated_ce_growth_pcnt
          ,le.populated_hardware_growth_pcnt
          ,le.populated_ie_growth_pcnt
          ,le.populated_is_growth_pcnt
          ,le.populated_it_growth_pcnt
          ,le.populated_mls_growth_pcnt
          ,le.populated_os_growth_pcnt
          ,le.populated_pp_growth_pcnt
          ,le.populated_sis_growth_pcnt
          ,le.populated_apparel_growth_pcnt
          ,le.populated_beverages_growth_pcnt
          ,le.populated_constr_growth_pcnt
          ,le.populated_consulting_growth_pcnt
          ,le.populated_fs_growth_pcnt
          ,le.populated_fp_growth_pcnt
          ,le.populated_insurance_growth_pcnt
          ,le.populated_ls_growth_pcnt
          ,le.populated_oil_gas_growth_pcnt
          ,le.populated_utilities_growth_pcnt
          ,le.populated_other_growth_pcnt
          ,le.populated_advt_growth_pcnt
          ,le.populated_top5_growth_pcnt
          ,le.populated_shipping_y1_pcnt
          ,le.populated_shipping_growth_pcnt
          ,le.populated_materials_y1_pcnt
          ,le.populated_materials_growth_pcnt
          ,le.populated_operations_y1_pcnt
          ,le.populated_operations_growth_pcnt
          ,le.populated_total_paid_average_0t12_pcnt
          ,le.populated_total_paid_monthspastworst_24_pcnt
          ,le.populated_total_paid_slope_0t12_pcnt
          ,le.populated_total_paid_slope_0t6_pcnt
          ,le.populated_total_paid_slope_6t12_pcnt
          ,le.populated_total_paid_slope_6t18_pcnt
          ,le.populated_total_paid_volatility_0t12_pcnt
          ,le.populated_total_paid_volatility_0t6_pcnt
          ,le.populated_total_paid_volatility_12t18_pcnt
          ,le.populated_total_paid_volatility_6t12_pcnt
          ,le.populated_total_spend_monthspastleast_24_pcnt
          ,le.populated_total_spend_monthspastmost_24_pcnt
          ,le.populated_total_spend_slope_0t12_pcnt
          ,le.populated_total_spend_slope_0t24_pcnt
          ,le.populated_total_spend_slope_0t6_pcnt
          ,le.populated_total_spend_slope_6t12_pcnt
          ,le.populated_total_spend_sum_12_pcnt
          ,le.populated_total_spend_volatility_0t12_pcnt
          ,le.populated_total_spend_volatility_0t6_pcnt
          ,le.populated_total_spend_volatility_12t18_pcnt
          ,le.populated_total_spend_volatility_6t12_pcnt
          ,le.populated_mfgmat_paid_average_12_pcnt
          ,le.populated_mfgmat_paid_monthspastworst_24_pcnt
          ,le.populated_mfgmat_paid_slope_0t12_pcnt
          ,le.populated_mfgmat_paid_slope_0t24_pcnt
          ,le.populated_mfgmat_paid_slope_0t6_pcnt
          ,le.populated_mfgmat_paid_volatility_0t12_pcnt
          ,le.populated_mfgmat_paid_volatility_0t6_pcnt
          ,le.populated_mfgmat_spend_monthspastleast_24_pcnt
          ,le.populated_mfgmat_spend_monthspastmost_24_pcnt
          ,le.populated_mfgmat_spend_slope_0t12_pcnt
          ,le.populated_mfgmat_spend_slope_0t24_pcnt
          ,le.populated_mfgmat_spend_slope_0t6_pcnt
          ,le.populated_mfgmat_spend_sum_12_pcnt
          ,le.populated_mfgmat_spend_volatility_0t6_pcnt
          ,le.populated_mfgmat_spend_volatility_6t12_pcnt
          ,le.populated_ops_paid_average_12_pcnt
          ,le.populated_ops_paid_monthspastworst_24_pcnt
          ,le.populated_ops_paid_slope_0t12_pcnt
          ,le.populated_ops_paid_slope_0t24_pcnt
          ,le.populated_ops_paid_slope_0t6_pcnt
          ,le.populated_ops_paid_volatility_0t12_pcnt
          ,le.populated_ops_paid_volatility_0t6_pcnt
          ,le.populated_ops_spend_monthspastleast_24_pcnt
          ,le.populated_ops_spend_monthspastmost_24_pcnt
          ,le.populated_ops_spend_slope_0t12_pcnt
          ,le.populated_ops_spend_slope_0t24_pcnt
          ,le.populated_ops_spend_slope_0t6_pcnt
          ,le.populated_ops_spend_sum_12_pcnt
          ,le.populated_ops_spend_volatility_0t6_pcnt
          ,le.populated_ops_spend_volatility_6t12_pcnt
          ,le.populated_fleet_paid_average_12_pcnt
          ,le.populated_fleet_paid_monthspastworst_24_pcnt
          ,le.populated_fleet_paid_slope_0t12_pcnt
          ,le.populated_fleet_paid_slope_0t24_pcnt
          ,le.populated_fleet_paid_slope_0t6_pcnt
          ,le.populated_fleet_paid_volatility_0t12_pcnt
          ,le.populated_fleet_paid_volatility_0t6_pcnt
          ,le.populated_fleet_spend_monthspastleast_24_pcnt
          ,le.populated_fleet_spend_monthspastmost_24_pcnt
          ,le.populated_fleet_spend_slope_0t12_pcnt
          ,le.populated_fleet_spend_slope_0t24_pcnt
          ,le.populated_fleet_spend_slope_0t6_pcnt
          ,le.populated_fleet_spend_sum_12_pcnt
          ,le.populated_fleet_spend_volatility_0t6_pcnt
          ,le.populated_fleet_spend_volatility_6t12_pcnt
          ,le.populated_carrier_paid_average_12_pcnt
          ,le.populated_carrier_paid_monthspastworst_24_pcnt
          ,le.populated_carrier_paid_slope_0t12_pcnt
          ,le.populated_carrier_paid_slope_0t24_pcnt
          ,le.populated_carrier_paid_slope_0t6_pcnt
          ,le.populated_carrier_paid_volatility_0t12_pcnt
          ,le.populated_carrier_paid_volatility_0t6_pcnt
          ,le.populated_carrier_spend_monthspastleast_24_pcnt
          ,le.populated_carrier_spend_monthspastmost_24_pcnt
          ,le.populated_carrier_spend_slope_0t12_pcnt
          ,le.populated_carrier_spend_slope_0t24_pcnt
          ,le.populated_carrier_spend_slope_0t6_pcnt
          ,le.populated_carrier_spend_sum_12_pcnt
          ,le.populated_carrier_spend_volatility_0t6_pcnt
          ,le.populated_carrier_spend_volatility_6t12_pcnt
          ,le.populated_bldgmats_paid_average_12_pcnt
          ,le.populated_bldgmats_paid_monthspastworst_24_pcnt
          ,le.populated_bldgmats_paid_slope_0t12_pcnt
          ,le.populated_bldgmats_paid_slope_0t24_pcnt
          ,le.populated_bldgmats_paid_slope_0t6_pcnt
          ,le.populated_bldgmats_paid_volatility_0t12_pcnt
          ,le.populated_bldgmats_paid_volatility_0t6_pcnt
          ,le.populated_bldgmats_spend_monthspastleast_24_pcnt
          ,le.populated_bldgmats_spend_monthspastmost_24_pcnt
          ,le.populated_bldgmats_spend_slope_0t12_pcnt
          ,le.populated_bldgmats_spend_slope_0t24_pcnt
          ,le.populated_bldgmats_spend_slope_0t6_pcnt
          ,le.populated_bldgmats_spend_sum_12_pcnt
          ,le.populated_bldgmats_spend_volatility_0t6_pcnt
          ,le.populated_bldgmats_spend_volatility_6t12_pcnt
          ,le.populated_top5_paid_average_12_pcnt
          ,le.populated_top5_paid_monthspastworst_24_pcnt
          ,le.populated_top5_paid_slope_0t12_pcnt
          ,le.populated_top5_paid_slope_0t24_pcnt
          ,le.populated_top5_paid_slope_0t6_pcnt
          ,le.populated_top5_paid_volatility_0t12_pcnt
          ,le.populated_top5_paid_volatility_0t6_pcnt
          ,le.populated_top5_spend_monthspastleast_24_pcnt
          ,le.populated_top5_spend_monthspastmost_24_pcnt
          ,le.populated_top5_spend_slope_0t12_pcnt
          ,le.populated_top5_spend_slope_0t24_pcnt
          ,le.populated_top5_spend_slope_0t6_pcnt
          ,le.populated_top5_spend_sum_12_pcnt
          ,le.populated_top5_spend_volatility_0t6_pcnt
          ,le.populated_top5_spend_volatility_6t12_pcnt
          ,le.populated_total_numrel_avg12_pcnt
          ,le.populated_total_numrel_monthpspastmost_24_pcnt
          ,le.populated_total_numrel_monthspastleast_24_pcnt
          ,le.populated_total_numrel_slope_0t12_pcnt
          ,le.populated_total_numrel_slope_0t24_pcnt
          ,le.populated_total_numrel_slope_0t6_pcnt
          ,le.populated_total_numrel_slope_6t12_pcnt
          ,le.populated_total_numrel_var_0t12_pcnt
          ,le.populated_total_numrel_var_0t24_pcnt
          ,le.populated_total_numrel_var_12t24_pcnt
          ,le.populated_total_numrel_var_6t18_pcnt
          ,le.populated_mfgmat_numrel_avg12_pcnt
          ,le.populated_mfgmat_numrel_slope_0t12_pcnt
          ,le.populated_mfgmat_numrel_slope_0t24_pcnt
          ,le.populated_mfgmat_numrel_slope_0t6_pcnt
          ,le.populated_mfgmat_numrel_slope_6t12_pcnt
          ,le.populated_mfgmat_numrel_var_0t12_pcnt
          ,le.populated_mfgmat_numrel_var_12t24_pcnt
          ,le.populated_ops_numrel_avg12_pcnt
          ,le.populated_ops_numrel_slope_0t12_pcnt
          ,le.populated_ops_numrel_slope_0t24_pcnt
          ,le.populated_ops_numrel_slope_0t6_pcnt
          ,le.populated_ops_numrel_slope_6t12_pcnt
          ,le.populated_ops_numrel_var_0t12_pcnt
          ,le.populated_ops_numrel_var_12t24_pcnt
          ,le.populated_fleet_numrel_avg12_pcnt
          ,le.populated_fleet_numrel_slope_0t12_pcnt
          ,le.populated_fleet_numrel_slope_0t24_pcnt
          ,le.populated_fleet_numrel_slope_0t6_pcnt
          ,le.populated_fleet_numrel_slope_6t12_pcnt
          ,le.populated_fleet_numrel_var_0t12_pcnt
          ,le.populated_fleet_numrel_var_12t24_pcnt
          ,le.populated_carrier_numrel_avg12_pcnt
          ,le.populated_carrier_numrel_slope_0t12_pcnt
          ,le.populated_carrier_numrel_slope_0t24_pcnt
          ,le.populated_carrier_numrel_slope_0t6_pcnt
          ,le.populated_carrier_numrel_slope_6t12_pcnt
          ,le.populated_carrier_numrel_var_0t12_pcnt
          ,le.populated_carrier_numrel_var_12t24_pcnt
          ,le.populated_bldgmats_numrel_avg12_pcnt
          ,le.populated_bldgmats_numrel_slope_0t12_pcnt
          ,le.populated_bldgmats_numrel_slope_0t24_pcnt
          ,le.populated_bldgmats_numrel_slope_0t6_pcnt
          ,le.populated_bldgmats_numrel_slope_6t12_pcnt
          ,le.populated_bldgmats_numrel_var_0t12_pcnt
          ,le.populated_bldgmats_numrel_var_12t24_pcnt
          ,le.populated_total_monthsoutstanding_slope24_pcnt
          ,le.populated_total_percprov30_avg_0t12_pcnt
          ,le.populated_total_percprov30_slope_0t12_pcnt
          ,le.populated_total_percprov30_slope_0t24_pcnt
          ,le.populated_total_percprov30_slope_0t6_pcnt
          ,le.populated_total_percprov30_slope_6t12_pcnt
          ,le.populated_total_percprov60_avg_0t12_pcnt
          ,le.populated_total_percprov60_slope_0t12_pcnt
          ,le.populated_total_percprov60_slope_0t24_pcnt
          ,le.populated_total_percprov60_slope_0t6_pcnt
          ,le.populated_total_percprov60_slope_6t12_pcnt
          ,le.populated_total_percprov90_avg_0t12_pcnt
          ,le.populated_total_percprov90_lowerlim_0t12_pcnt
          ,le.populated_total_percprov90_slope_0t24_pcnt
          ,le.populated_total_percprov90_slope_0t6_pcnt
          ,le.populated_total_percprov90_slope_6t12_pcnt
          ,le.populated_total_percprovoutstanding_adjustedslope_0t12_pcnt
          ,le.populated_mfgmat_monthsoutstanding_slope24_pcnt
          ,le.populated_mfgmat_percprov30_slope_0t12_pcnt
          ,le.populated_mfgmat_percprov30_slope_6t12_pcnt
          ,le.populated_mfgmat_percprov60_slope_0t12_pcnt
          ,le.populated_mfgmat_percprov60_slope_6t12_pcnt
          ,le.populated_mfgmat_percprov90_slope_0t24_pcnt
          ,le.populated_mfgmat_percprov90_slope_0t6_pcnt
          ,le.populated_mfgmat_percprov90_slope_6t12_pcnt
          ,le.populated_mfgmat_percprovoutstanding_adjustedslope_0t12_pcnt
          ,le.populated_ops_monthsoutstanding_slope24_pcnt
          ,le.populated_ops_percprov30_slope_0t12_pcnt
          ,le.populated_ops_percprov30_slope_6t12_pcnt
          ,le.populated_ops_percprov60_slope_0t12_pcnt
          ,le.populated_ops_percprov60_slope_6t12_pcnt
          ,le.populated_ops_percprov90_slope_0t24_pcnt
          ,le.populated_ops_percprov90_slope_0t6_pcnt
          ,le.populated_ops_percprov90_slope_6t12_pcnt
          ,le.populated_ops_percprovoutstanding_adjustedslope_0t12_pcnt
          ,le.populated_fleet_monthsoutstanding_slope24_pcnt
          ,le.populated_fleet_percprov30_slope_0t12_pcnt
          ,le.populated_fleet_percprov30_slope_6t12_pcnt
          ,le.populated_fleet_percprov60_slope_0t12_pcnt
          ,le.populated_fleet_percprov60_slope_6t12_pcnt
          ,le.populated_fleet_percprov90_slope_0t24_pcnt
          ,le.populated_fleet_percprov90_slope_0t6_pcnt
          ,le.populated_fleet_percprov90_slope_6t12_pcnt
          ,le.populated_fleet_percprovoutstanding_adjustedslope_0t12_pcnt
          ,le.populated_carrier_monthsoutstanding_slope24_pcnt
          ,le.populated_carrier_percprov30_slope_0t12_pcnt
          ,le.populated_carrier_percprov30_slope_6t12_pcnt
          ,le.populated_carrier_percprov60_slope_0t12_pcnt
          ,le.populated_carrier_percprov60_slope_6t12_pcnt
          ,le.populated_carrier_percprov90_slope_0t24_pcnt
          ,le.populated_carrier_percprov90_slope_0t6_pcnt
          ,le.populated_carrier_percprov90_slope_6t12_pcnt
          ,le.populated_carrier_percprovoutstanding_adjustedslope_0t12_pcnt
          ,le.populated_bldgmats_monthsoutstanding_slope24_pcnt
          ,le.populated_bldgmats_percprov30_slope_0t12_pcnt
          ,le.populated_bldgmats_percprov30_slope_6t12_pcnt
          ,le.populated_bldgmats_percprov60_slope_0t12_pcnt
          ,le.populated_bldgmats_percprov60_slope_6t12_pcnt
          ,le.populated_bldgmats_percprov90_slope_0t24_pcnt
          ,le.populated_bldgmats_percprov90_slope_0t6_pcnt
          ,le.populated_bldgmats_percprov90_slope_6t12_pcnt
          ,le.populated_bldgmats_percprovoutstanding_adjustedslope_0t12_pcnt
          ,le.populated_top5_monthsoutstanding_slope24_pcnt
          ,le.populated_top5_percprov30_slope_0t12_pcnt
          ,le.populated_top5_percprov30_slope_6t12_pcnt
          ,le.populated_top5_percprov60_slope_0t12_pcnt
          ,le.populated_top5_percprov60_slope_6t12_pcnt
          ,le.populated_top5_percprov90_slope_0t24_pcnt
          ,le.populated_top5_percprov90_slope_0t6_pcnt
          ,le.populated_top5_percprov90_slope_6t12_pcnt
          ,le.populated_top5_percprovoutstanding_adjustedslope_0t12_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,333,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Attributes_Delta(prevDS, PROJECT(h, Attributes_Layout_Cortera));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),333,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Attributes_Layout_Cortera) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Cortera, Attributes_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
