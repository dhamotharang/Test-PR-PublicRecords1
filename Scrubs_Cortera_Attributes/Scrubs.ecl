IMPORT SALT36;
EXPORT Scrubs := MODULE

// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_In_Attributes)
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
  EXPORT  Bitmap_Layout := RECORD(Layout_In_Attributes)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
    UNSIGNED8 ScrubsBits4;
    UNSIGNED8 ScrubsBits5;
    UNSIGNED8 ScrubsBits6;
    UNSIGNED8 ScrubsBits7;
    UNSIGNED8 ScrubsBits8;
    UNSIGNED8 ScrubsBits9;
  END;
EXPORT FromNone(DATASET(Layout_In_Attributes) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.ultimate_linkid_Invalid := Fields.InValid_ultimate_linkid((SALT36.StrType)le.ultimate_linkid);
    SELF.cortera_score_Invalid := Fields.InValid_cortera_score((SALT36.StrType)le.cortera_score);
    SELF.cpr_score_Invalid := Fields.InValid_cpr_score((SALT36.StrType)le.cpr_score);
    SELF.cpr_segment_Invalid := Fields.InValid_cpr_segment((SALT36.StrType)le.cpr_segment);
    SELF.dbt_Invalid := Fields.InValid_dbt((SALT36.StrType)le.dbt);
    SELF.avg_bal_Invalid := Fields.InValid_avg_bal((SALT36.StrType)le.avg_bal);
    SELF.air_spend_Invalid := Fields.InValid_air_spend((SALT36.StrType)le.air_spend);
    SELF.fuel_spend_Invalid := Fields.InValid_fuel_spend((SALT36.StrType)le.fuel_spend);
    SELF.leasing_spend_Invalid := Fields.InValid_leasing_spend((SALT36.StrType)le.leasing_spend);
    SELF.ltl_spend_Invalid := Fields.InValid_ltl_spend((SALT36.StrType)le.ltl_spend);
    SELF.rail_spend_Invalid := Fields.InValid_rail_spend((SALT36.StrType)le.rail_spend);
    SELF.tl_spend_Invalid := Fields.InValid_tl_spend((SALT36.StrType)le.tl_spend);
    SELF.transvc_spend_Invalid := Fields.InValid_transvc_spend((SALT36.StrType)le.transvc_spend);
    SELF.transup_spend_Invalid := Fields.InValid_transup_spend((SALT36.StrType)le.transup_spend);
    SELF.bst_spend_Invalid := Fields.InValid_bst_spend((SALT36.StrType)le.bst_spend);
    SELF.dg_spend_Invalid := Fields.InValid_dg_spend((SALT36.StrType)le.dg_spend);
    SELF.electrical_spend_Invalid := Fields.InValid_electrical_spend((SALT36.StrType)le.electrical_spend);
    SELF.hvac_spend_Invalid := Fields.InValid_hvac_spend((SALT36.StrType)le.hvac_spend);
    SELF.other_b_spend_Invalid := Fields.InValid_other_b_spend((SALT36.StrType)le.other_b_spend);
    SELF.plumbing_spend_Invalid := Fields.InValid_plumbing_spend((SALT36.StrType)le.plumbing_spend);
    SELF.rs_spend_Invalid := Fields.InValid_rs_spend((SALT36.StrType)le.rs_spend);
    SELF.wp_spend_Invalid := Fields.InValid_wp_spend((SALT36.StrType)le.wp_spend);
    SELF.chemical_spend_Invalid := Fields.InValid_chemical_spend((SALT36.StrType)le.chemical_spend);
    SELF.electronic_spend_Invalid := Fields.InValid_electronic_spend((SALT36.StrType)le.electronic_spend);
    SELF.metal_spend_Invalid := Fields.InValid_metal_spend((SALT36.StrType)le.metal_spend);
    SELF.other_m_spend_Invalid := Fields.InValid_other_m_spend((SALT36.StrType)le.other_m_spend);
    SELF.packaging_spend_Invalid := Fields.InValid_packaging_spend((SALT36.StrType)le.packaging_spend);
    SELF.pvf_spend_Invalid := Fields.InValid_pvf_spend((SALT36.StrType)le.pvf_spend);
    SELF.plastic_spend_Invalid := Fields.InValid_plastic_spend((SALT36.StrType)le.plastic_spend);
    SELF.textile_spend_Invalid := Fields.InValid_textile_spend((SALT36.StrType)le.textile_spend);
    SELF.bs_spend_Invalid := Fields.InValid_bs_spend((SALT36.StrType)le.bs_spend);
    SELF.ce_spend_Invalid := Fields.InValid_ce_spend((SALT36.StrType)le.ce_spend);
    SELF.hardware_spend_Invalid := Fields.InValid_hardware_spend((SALT36.StrType)le.hardware_spend);
    SELF.ie_spend_Invalid := Fields.InValid_ie_spend((SALT36.StrType)le.ie_spend);
    SELF.is_spend_Invalid := Fields.InValid_is_spend((SALT36.StrType)le.is_spend);
    SELF.it_spend_Invalid := Fields.InValid_it_spend((SALT36.StrType)le.it_spend);
    SELF.mls_spend_Invalid := Fields.InValid_mls_spend((SALT36.StrType)le.mls_spend);
    SELF.os_spend_Invalid := Fields.InValid_os_spend((SALT36.StrType)le.os_spend);
    SELF.pp_spend_Invalid := Fields.InValid_pp_spend((SALT36.StrType)le.pp_spend);
    SELF.sis_spend_Invalid := Fields.InValid_sis_spend((SALT36.StrType)le.sis_spend);
    SELF.apparel_spend_Invalid := Fields.InValid_apparel_spend((SALT36.StrType)le.apparel_spend);
    SELF.beverages_spend_Invalid := Fields.InValid_beverages_spend((SALT36.StrType)le.beverages_spend);
    SELF.constr_spend_Invalid := Fields.InValid_constr_spend((SALT36.StrType)le.constr_spend);
    SELF.consulting_spend_Invalid := Fields.InValid_consulting_spend((SALT36.StrType)le.consulting_spend);
    SELF.fs_spend_Invalid := Fields.InValid_fs_spend((SALT36.StrType)le.fs_spend);
    SELF.fp_spend_Invalid := Fields.InValid_fp_spend((SALT36.StrType)le.fp_spend);
    SELF.insurance_spend_Invalid := Fields.InValid_insurance_spend((SALT36.StrType)le.insurance_spend);
    SELF.ls_spend_Invalid := Fields.InValid_ls_spend((SALT36.StrType)le.ls_spend);
    SELF.oil_gas_spend_Invalid := Fields.InValid_oil_gas_spend((SALT36.StrType)le.oil_gas_spend);
    SELF.utilities_spend_Invalid := Fields.InValid_utilities_spend((SALT36.StrType)le.utilities_spend);
    SELF.other_spend_Invalid := Fields.InValid_other_spend((SALT36.StrType)le.other_spend);
    SELF.advt_spend_Invalid := Fields.InValid_advt_spend((SALT36.StrType)le.advt_spend);
    SELF.air_growth_Invalid := Fields.InValid_air_growth((SALT36.StrType)le.air_growth);
    SELF.fuel_growth_Invalid := Fields.InValid_fuel_growth((SALT36.StrType)le.fuel_growth);
    SELF.leasing_growth_Invalid := Fields.InValid_leasing_growth((SALT36.StrType)le.leasing_growth);
    SELF.ltl_growth_Invalid := Fields.InValid_ltl_growth((SALT36.StrType)le.ltl_growth);
    SELF.rail_growth_Invalid := Fields.InValid_rail_growth((SALT36.StrType)le.rail_growth);
    SELF.tl_growth_Invalid := Fields.InValid_tl_growth((SALT36.StrType)le.tl_growth);
    SELF.transvc_growth_Invalid := Fields.InValid_transvc_growth((SALT36.StrType)le.transvc_growth);
    SELF.transup_growth_Invalid := Fields.InValid_transup_growth((SALT36.StrType)le.transup_growth);
    SELF.bst_growth_Invalid := Fields.InValid_bst_growth((SALT36.StrType)le.bst_growth);
    SELF.dg_growth_Invalid := Fields.InValid_dg_growth((SALT36.StrType)le.dg_growth);
    SELF.electrical_growth_Invalid := Fields.InValid_electrical_growth((SALT36.StrType)le.electrical_growth);
    SELF.hvac_growth_Invalid := Fields.InValid_hvac_growth((SALT36.StrType)le.hvac_growth);
    SELF.other_b_growth_Invalid := Fields.InValid_other_b_growth((SALT36.StrType)le.other_b_growth);
    SELF.plumbing_growth_Invalid := Fields.InValid_plumbing_growth((SALT36.StrType)le.plumbing_growth);
    SELF.rs_growth_Invalid := Fields.InValid_rs_growth((SALT36.StrType)le.rs_growth);
    SELF.wp_growth_Invalid := Fields.InValid_wp_growth((SALT36.StrType)le.wp_growth);
    SELF.chemical_growth_Invalid := Fields.InValid_chemical_growth((SALT36.StrType)le.chemical_growth);
    SELF.electronic_growth_Invalid := Fields.InValid_electronic_growth((SALT36.StrType)le.electronic_growth);
    SELF.metal_growth_Invalid := Fields.InValid_metal_growth((SALT36.StrType)le.metal_growth);
    SELF.other_m_growth_Invalid := Fields.InValid_other_m_growth((SALT36.StrType)le.other_m_growth);
    SELF.packaging_growth_Invalid := Fields.InValid_packaging_growth((SALT36.StrType)le.packaging_growth);
    SELF.pvf_growth_Invalid := Fields.InValid_pvf_growth((SALT36.StrType)le.pvf_growth);
    SELF.plastic_growth_Invalid := Fields.InValid_plastic_growth((SALT36.StrType)le.plastic_growth);
    SELF.textile_growth_Invalid := Fields.InValid_textile_growth((SALT36.StrType)le.textile_growth);
    SELF.bs_growth_Invalid := Fields.InValid_bs_growth((SALT36.StrType)le.bs_growth);
    SELF.ce_growth_Invalid := Fields.InValid_ce_growth((SALT36.StrType)le.ce_growth);
    SELF.hardware_growth_Invalid := Fields.InValid_hardware_growth((SALT36.StrType)le.hardware_growth);
    SELF.ie_growth_Invalid := Fields.InValid_ie_growth((SALT36.StrType)le.ie_growth);
    SELF.is_growth_Invalid := Fields.InValid_is_growth((SALT36.StrType)le.is_growth);
    SELF.it_growth_Invalid := Fields.InValid_it_growth((SALT36.StrType)le.it_growth);
    SELF.mls_growth_Invalid := Fields.InValid_mls_growth((SALT36.StrType)le.mls_growth);
    SELF.os_growth_Invalid := Fields.InValid_os_growth((SALT36.StrType)le.os_growth);
    SELF.pp_growth_Invalid := Fields.InValid_pp_growth((SALT36.StrType)le.pp_growth);
    SELF.sis_growth_Invalid := Fields.InValid_sis_growth((SALT36.StrType)le.sis_growth);
    SELF.apparel_growth_Invalid := Fields.InValid_apparel_growth((SALT36.StrType)le.apparel_growth);
    SELF.beverages_growth_Invalid := Fields.InValid_beverages_growth((SALT36.StrType)le.beverages_growth);
    SELF.constr_growth_Invalid := Fields.InValid_constr_growth((SALT36.StrType)le.constr_growth);
    SELF.consulting_growth_Invalid := Fields.InValid_consulting_growth((SALT36.StrType)le.consulting_growth);
    SELF.fs_growth_Invalid := Fields.InValid_fs_growth((SALT36.StrType)le.fs_growth);
    SELF.fp_growth_Invalid := Fields.InValid_fp_growth((SALT36.StrType)le.fp_growth);
    SELF.insurance_growth_Invalid := Fields.InValid_insurance_growth((SALT36.StrType)le.insurance_growth);
    SELF.ls_growth_Invalid := Fields.InValid_ls_growth((SALT36.StrType)le.ls_growth);
    SELF.oil_gas_growth_Invalid := Fields.InValid_oil_gas_growth((SALT36.StrType)le.oil_gas_growth);
    SELF.utilities_growth_Invalid := Fields.InValid_utilities_growth((SALT36.StrType)le.utilities_growth);
    SELF.other_growth_Invalid := Fields.InValid_other_growth((SALT36.StrType)le.other_growth);
    SELF.advt_growth_Invalid := Fields.InValid_advt_growth((SALT36.StrType)le.advt_growth);
    SELF.top5_growth_Invalid := Fields.InValid_top5_growth((SALT36.StrType)le.top5_growth);
    SELF.shipping_y1_Invalid := Fields.InValid_shipping_y1((SALT36.StrType)le.shipping_y1);
    SELF.shipping_growth_Invalid := Fields.InValid_shipping_growth((SALT36.StrType)le.shipping_growth);
    SELF.materials_y1_Invalid := Fields.InValid_materials_y1((SALT36.StrType)le.materials_y1);
    SELF.materials_growth_Invalid := Fields.InValid_materials_growth((SALT36.StrType)le.materials_growth);
    SELF.operations_y1_Invalid := Fields.InValid_operations_y1((SALT36.StrType)le.operations_y1);
    SELF.operations_growth_Invalid := Fields.InValid_operations_growth((SALT36.StrType)le.operations_growth);
    SELF.total_paid_average_0t12_Invalid := Fields.InValid_total_paid_average_0t12((SALT36.StrType)le.total_paid_average_0t12);
    SELF.total_paid_monthspastworst_24_Invalid := Fields.InValid_total_paid_monthspastworst_24((SALT36.StrType)le.total_paid_monthspastworst_24);
    SELF.total_paid_slope_0t12_Invalid := Fields.InValid_total_paid_slope_0t12((SALT36.StrType)le.total_paid_slope_0t12);
    SELF.total_paid_slope_0t6_Invalid := Fields.InValid_total_paid_slope_0t6((SALT36.StrType)le.total_paid_slope_0t6);
    SELF.total_paid_slope_6t12_Invalid := Fields.InValid_total_paid_slope_6t12((SALT36.StrType)le.total_paid_slope_6t12);
    SELF.total_paid_slope_6t18_Invalid := Fields.InValid_total_paid_slope_6t18((SALT36.StrType)le.total_paid_slope_6t18);
    SELF.total_paid_volatility_0t12_Invalid := Fields.InValid_total_paid_volatility_0t12((SALT36.StrType)le.total_paid_volatility_0t12);
    SELF.total_paid_volatility_0t6_Invalid := Fields.InValid_total_paid_volatility_0t6((SALT36.StrType)le.total_paid_volatility_0t6);
    SELF.total_paid_volatility_12t18_Invalid := Fields.InValid_total_paid_volatility_12t18((SALT36.StrType)le.total_paid_volatility_12t18);
    SELF.total_paid_volatility_6t12_Invalid := Fields.InValid_total_paid_volatility_6t12((SALT36.StrType)le.total_paid_volatility_6t12);
    SELF.total_spend_monthspastleast_24_Invalid := Fields.InValid_total_spend_monthspastleast_24((SALT36.StrType)le.total_spend_monthspastleast_24);
    SELF.total_spend_monthspastmost_24_Invalid := Fields.InValid_total_spend_monthspastmost_24((SALT36.StrType)le.total_spend_monthspastmost_24);
    SELF.total_spend_slope_0t12_Invalid := Fields.InValid_total_spend_slope_0t12((SALT36.StrType)le.total_spend_slope_0t12);
    SELF.total_spend_slope_0t24_Invalid := Fields.InValid_total_spend_slope_0t24((SALT36.StrType)le.total_spend_slope_0t24);
    SELF.total_spend_slope_0t6_Invalid := Fields.InValid_total_spend_slope_0t6((SALT36.StrType)le.total_spend_slope_0t6);
    SELF.total_spend_slope_6t12_Invalid := Fields.InValid_total_spend_slope_6t12((SALT36.StrType)le.total_spend_slope_6t12);
    SELF.total_spend_sum_12_Invalid := Fields.InValid_total_spend_sum_12((SALT36.StrType)le.total_spend_sum_12);
    SELF.total_spend_volatility_0t12_Invalid := Fields.InValid_total_spend_volatility_0t12((SALT36.StrType)le.total_spend_volatility_0t12);
    SELF.total_spend_volatility_0t6_Invalid := Fields.InValid_total_spend_volatility_0t6((SALT36.StrType)le.total_spend_volatility_0t6);
    SELF.total_spend_volatility_12t18_Invalid := Fields.InValid_total_spend_volatility_12t18((SALT36.StrType)le.total_spend_volatility_12t18);
    SELF.total_spend_volatility_6t12_Invalid := Fields.InValid_total_spend_volatility_6t12((SALT36.StrType)le.total_spend_volatility_6t12);
    SELF.mfgmat_paid_average_12_Invalid := Fields.InValid_mfgmat_paid_average_12((SALT36.StrType)le.mfgmat_paid_average_12);
    SELF.mfgmat_paid_monthspastworst_24_Invalid := Fields.InValid_mfgmat_paid_monthspastworst_24((SALT36.StrType)le.mfgmat_paid_monthspastworst_24);
    SELF.mfgmat_paid_slope_0t12_Invalid := Fields.InValid_mfgmat_paid_slope_0t12((SALT36.StrType)le.mfgmat_paid_slope_0t12);
    SELF.mfgmat_paid_slope_0t24_Invalid := Fields.InValid_mfgmat_paid_slope_0t24((SALT36.StrType)le.mfgmat_paid_slope_0t24);
    SELF.mfgmat_paid_slope_0t6_Invalid := Fields.InValid_mfgmat_paid_slope_0t6((SALT36.StrType)le.mfgmat_paid_slope_0t6);
    SELF.mfgmat_paid_volatility_0t12_Invalid := Fields.InValid_mfgmat_paid_volatility_0t12((SALT36.StrType)le.mfgmat_paid_volatility_0t12);
    SELF.mfgmat_paid_volatility_0t6_Invalid := Fields.InValid_mfgmat_paid_volatility_0t6((SALT36.StrType)le.mfgmat_paid_volatility_0t6);
    SELF.mfgmat_spend_monthspastleast_24_Invalid := Fields.InValid_mfgmat_spend_monthspastleast_24((SALT36.StrType)le.mfgmat_spend_monthspastleast_24);
    SELF.mfgmat_spend_monthspastmost_24_Invalid := Fields.InValid_mfgmat_spend_monthspastmost_24((SALT36.StrType)le.mfgmat_spend_monthspastmost_24);
    SELF.mfgmat_spend_slope_0t12_Invalid := Fields.InValid_mfgmat_spend_slope_0t12((SALT36.StrType)le.mfgmat_spend_slope_0t12);
    SELF.mfgmat_spend_slope_0t24_Invalid := Fields.InValid_mfgmat_spend_slope_0t24((SALT36.StrType)le.mfgmat_spend_slope_0t24);
    SELF.mfgmat_spend_slope_0t6_Invalid := Fields.InValid_mfgmat_spend_slope_0t6((SALT36.StrType)le.mfgmat_spend_slope_0t6);
    SELF.mfgmat_spend_sum_12_Invalid := Fields.InValid_mfgmat_spend_sum_12((SALT36.StrType)le.mfgmat_spend_sum_12);
    SELF.mfgmat_spend_volatility_0t6_Invalid := Fields.InValid_mfgmat_spend_volatility_0t6((SALT36.StrType)le.mfgmat_spend_volatility_0t6);
    SELF.mfgmat_spend_volatility_6t12_Invalid := Fields.InValid_mfgmat_spend_volatility_6t12((SALT36.StrType)le.mfgmat_spend_volatility_6t12);
    SELF.ops_paid_average_12_Invalid := Fields.InValid_ops_paid_average_12((SALT36.StrType)le.ops_paid_average_12);
    SELF.ops_paid_monthspastworst_24_Invalid := Fields.InValid_ops_paid_monthspastworst_24((SALT36.StrType)le.ops_paid_monthspastworst_24);
    SELF.ops_paid_slope_0t12_Invalid := Fields.InValid_ops_paid_slope_0t12((SALT36.StrType)le.ops_paid_slope_0t12);
    SELF.ops_paid_slope_0t24_Invalid := Fields.InValid_ops_paid_slope_0t24((SALT36.StrType)le.ops_paid_slope_0t24);
    SELF.ops_paid_slope_0t6_Invalid := Fields.InValid_ops_paid_slope_0t6((SALT36.StrType)le.ops_paid_slope_0t6);
    SELF.ops_paid_volatility_0t12_Invalid := Fields.InValid_ops_paid_volatility_0t12((SALT36.StrType)le.ops_paid_volatility_0t12);
    SELF.ops_paid_volatility_0t6_Invalid := Fields.InValid_ops_paid_volatility_0t6((SALT36.StrType)le.ops_paid_volatility_0t6);
    SELF.ops_spend_monthspastleast_24_Invalid := Fields.InValid_ops_spend_monthspastleast_24((SALT36.StrType)le.ops_spend_monthspastleast_24);
    SELF.ops_spend_monthspastmost_24_Invalid := Fields.InValid_ops_spend_monthspastmost_24((SALT36.StrType)le.ops_spend_monthspastmost_24);
    SELF.ops_spend_slope_0t12_Invalid := Fields.InValid_ops_spend_slope_0t12((SALT36.StrType)le.ops_spend_slope_0t12);
    SELF.ops_spend_slope_0t24_Invalid := Fields.InValid_ops_spend_slope_0t24((SALT36.StrType)le.ops_spend_slope_0t24);
    SELF.ops_spend_slope_0t6_Invalid := Fields.InValid_ops_spend_slope_0t6((SALT36.StrType)le.ops_spend_slope_0t6);
    SELF.fleet_paid_monthspastworst_24_Invalid := Fields.InValid_fleet_paid_monthspastworst_24((SALT36.StrType)le.fleet_paid_monthspastworst_24);
    SELF.fleet_paid_slope_0t12_Invalid := Fields.InValid_fleet_paid_slope_0t12((SALT36.StrType)le.fleet_paid_slope_0t12);
    SELF.fleet_paid_slope_0t24_Invalid := Fields.InValid_fleet_paid_slope_0t24((SALT36.StrType)le.fleet_paid_slope_0t24);
    SELF.fleet_paid_slope_0t6_Invalid := Fields.InValid_fleet_paid_slope_0t6((SALT36.StrType)le.fleet_paid_slope_0t6);
    SELF.fleet_paid_volatility_0t12_Invalid := Fields.InValid_fleet_paid_volatility_0t12((SALT36.StrType)le.fleet_paid_volatility_0t12);
    SELF.fleet_paid_volatility_0t6_Invalid := Fields.InValid_fleet_paid_volatility_0t6((SALT36.StrType)le.fleet_paid_volatility_0t6);
    SELF.fleet_spend_slope_0t12_Invalid := Fields.InValid_fleet_spend_slope_0t12((SALT36.StrType)le.fleet_spend_slope_0t12);
    SELF.fleet_spend_slope_0t24_Invalid := Fields.InValid_fleet_spend_slope_0t24((SALT36.StrType)le.fleet_spend_slope_0t24);
    SELF.fleet_spend_slope_0t6_Invalid := Fields.InValid_fleet_spend_slope_0t6((SALT36.StrType)le.fleet_spend_slope_0t6);
    SELF.carrier_paid_slope_0t12_Invalid := Fields.InValid_carrier_paid_slope_0t12((SALT36.StrType)le.carrier_paid_slope_0t12);
    SELF.carrier_paid_slope_0t24_Invalid := Fields.InValid_carrier_paid_slope_0t24((SALT36.StrType)le.carrier_paid_slope_0t24);
    SELF.carrier_paid_slope_0t6_Invalid := Fields.InValid_carrier_paid_slope_0t6((SALT36.StrType)le.carrier_paid_slope_0t6);
    SELF.carrier_paid_volatility_0t12_Invalid := Fields.InValid_carrier_paid_volatility_0t12((SALT36.StrType)le.carrier_paid_volatility_0t12);
    SELF.carrier_paid_volatility_0t6_Invalid := Fields.InValid_carrier_paid_volatility_0t6((SALT36.StrType)le.carrier_paid_volatility_0t6);
    SELF.carrier_spend_slope_0t12_Invalid := Fields.InValid_carrier_spend_slope_0t12((SALT36.StrType)le.carrier_spend_slope_0t12);
    SELF.carrier_spend_slope_0t24_Invalid := Fields.InValid_carrier_spend_slope_0t24((SALT36.StrType)le.carrier_spend_slope_0t24);
    SELF.carrier_spend_slope_0t6_Invalid := Fields.InValid_carrier_spend_slope_0t6((SALT36.StrType)le.carrier_spend_slope_0t6);
    SELF.carrier_spend_volatility_0t6_Invalid := Fields.InValid_carrier_spend_volatility_0t6((SALT36.StrType)le.carrier_spend_volatility_0t6);
    SELF.carrier_spend_volatility_6t12_Invalid := Fields.InValid_carrier_spend_volatility_6t12((SALT36.StrType)le.carrier_spend_volatility_6t12);
    SELF.bldgmats_paid_slope_0t12_Invalid := Fields.InValid_bldgmats_paid_slope_0t12((SALT36.StrType)le.bldgmats_paid_slope_0t12);
    SELF.bldgmats_paid_slope_0t24_Invalid := Fields.InValid_bldgmats_paid_slope_0t24((SALT36.StrType)le.bldgmats_paid_slope_0t24);
    SELF.bldgmats_paid_slope_0t6_Invalid := Fields.InValid_bldgmats_paid_slope_0t6((SALT36.StrType)le.bldgmats_paid_slope_0t6);
    SELF.bldgmats_paid_volatility_0t12_Invalid := Fields.InValid_bldgmats_paid_volatility_0t12((SALT36.StrType)le.bldgmats_paid_volatility_0t12);
    SELF.bldgmats_paid_volatility_0t6_Invalid := Fields.InValid_bldgmats_paid_volatility_0t6((SALT36.StrType)le.bldgmats_paid_volatility_0t6);
    SELF.bldgmats_spend_slope_0t12_Invalid := Fields.InValid_bldgmats_spend_slope_0t12((SALT36.StrType)le.bldgmats_spend_slope_0t12);
    SELF.bldgmats_spend_slope_0t24_Invalid := Fields.InValid_bldgmats_spend_slope_0t24((SALT36.StrType)le.bldgmats_spend_slope_0t24);
    SELF.bldgmats_spend_slope_0t6_Invalid := Fields.InValid_bldgmats_spend_slope_0t6((SALT36.StrType)le.bldgmats_spend_slope_0t6);
    SELF.bldgmats_spend_volatility_0t6_Invalid := Fields.InValid_bldgmats_spend_volatility_0t6((SALT36.StrType)le.bldgmats_spend_volatility_0t6);
    SELF.bldgmats_spend_volatility_6t12_Invalid := Fields.InValid_bldgmats_spend_volatility_6t12((SALT36.StrType)le.bldgmats_spend_volatility_6t12);
    SELF.top5_paid_slope_0t12_Invalid := Fields.InValid_top5_paid_slope_0t12((SALT36.StrType)le.top5_paid_slope_0t12);
    SELF.top5_paid_slope_0t24_Invalid := Fields.InValid_top5_paid_slope_0t24((SALT36.StrType)le.top5_paid_slope_0t24);
    SELF.top5_paid_slope_0t6_Invalid := Fields.InValid_top5_paid_slope_0t6((SALT36.StrType)le.top5_paid_slope_0t6);
    SELF.top5_paid_volatility_0t12_Invalid := Fields.InValid_top5_paid_volatility_0t12((SALT36.StrType)le.top5_paid_volatility_0t12);
    SELF.top5_paid_volatility_0t6_Invalid := Fields.InValid_top5_paid_volatility_0t6((SALT36.StrType)le.top5_paid_volatility_0t6);
    SELF.top5_spend_slope_0t12_Invalid := Fields.InValid_top5_spend_slope_0t12((SALT36.StrType)le.top5_spend_slope_0t12);
    SELF.top5_spend_slope_0t24_Invalid := Fields.InValid_top5_spend_slope_0t24((SALT36.StrType)le.top5_spend_slope_0t24);
    SELF.top5_spend_slope_0t6_Invalid := Fields.InValid_top5_spend_slope_0t6((SALT36.StrType)le.top5_spend_slope_0t6);
    SELF.top5_spend_volatility_0t6_Invalid := Fields.InValid_top5_spend_volatility_0t6((SALT36.StrType)le.top5_spend_volatility_0t6);
    SELF.top5_spend_volatility_6t12_Invalid := Fields.InValid_top5_spend_volatility_6t12((SALT36.StrType)le.top5_spend_volatility_6t12);
    SELF.total_numrel_slope_0t12_Invalid := Fields.InValid_total_numrel_slope_0t12((SALT36.StrType)le.total_numrel_slope_0t12);
    SELF.total_numrel_slope_0t24_Invalid := Fields.InValid_total_numrel_slope_0t24((SALT36.StrType)le.total_numrel_slope_0t24);
    SELF.total_numrel_slope_0t6_Invalid := Fields.InValid_total_numrel_slope_0t6((SALT36.StrType)le.total_numrel_slope_0t6);
    SELF.total_numrel_slope_6t12_Invalid := Fields.InValid_total_numrel_slope_6t12((SALT36.StrType)le.total_numrel_slope_6t12);
    SELF.mfgmat_numrel_slope_0t12_Invalid := Fields.InValid_mfgmat_numrel_slope_0t12((SALT36.StrType)le.mfgmat_numrel_slope_0t12);
    SELF.mfgmat_numrel_slope_0t24_Invalid := Fields.InValid_mfgmat_numrel_slope_0t24((SALT36.StrType)le.mfgmat_numrel_slope_0t24);
    SELF.mfgmat_numrel_slope_0t6_Invalid := Fields.InValid_mfgmat_numrel_slope_0t6((SALT36.StrType)le.mfgmat_numrel_slope_0t6);
    SELF.mfgmat_numrel_slope_6t12_Invalid := Fields.InValid_mfgmat_numrel_slope_6t12((SALT36.StrType)le.mfgmat_numrel_slope_6t12);
    SELF.ops_numrel_slope_0t12_Invalid := Fields.InValid_ops_numrel_slope_0t12((SALT36.StrType)le.ops_numrel_slope_0t12);
    SELF.ops_numrel_slope_0t24_Invalid := Fields.InValid_ops_numrel_slope_0t24((SALT36.StrType)le.ops_numrel_slope_0t24);
    SELF.ops_numrel_slope_0t6_Invalid := Fields.InValid_ops_numrel_slope_0t6((SALT36.StrType)le.ops_numrel_slope_0t6);
    SELF.ops_numrel_slope_6t12_Invalid := Fields.InValid_ops_numrel_slope_6t12((SALT36.StrType)le.ops_numrel_slope_6t12);
    SELF.fleet_numrel_slope_0t12_Invalid := Fields.InValid_fleet_numrel_slope_0t12((SALT36.StrType)le.fleet_numrel_slope_0t12);
    SELF.fleet_numrel_slope_0t24_Invalid := Fields.InValid_fleet_numrel_slope_0t24((SALT36.StrType)le.fleet_numrel_slope_0t24);
    SELF.fleet_numrel_slope_0t6_Invalid := Fields.InValid_fleet_numrel_slope_0t6((SALT36.StrType)le.fleet_numrel_slope_0t6);
    SELF.fleet_numrel_slope_6t12_Invalid := Fields.InValid_fleet_numrel_slope_6t12((SALT36.StrType)le.fleet_numrel_slope_6t12);
    SELF.carrier_numrel_slope_0t12_Invalid := Fields.InValid_carrier_numrel_slope_0t12((SALT36.StrType)le.carrier_numrel_slope_0t12);
    SELF.carrier_numrel_slope_0t24_Invalid := Fields.InValid_carrier_numrel_slope_0t24((SALT36.StrType)le.carrier_numrel_slope_0t24);
    SELF.carrier_numrel_slope_0t6_Invalid := Fields.InValid_carrier_numrel_slope_0t6((SALT36.StrType)le.carrier_numrel_slope_0t6);
    SELF.carrier_numrel_slope_6t12_Invalid := Fields.InValid_carrier_numrel_slope_6t12((SALT36.StrType)le.carrier_numrel_slope_6t12);
    SELF.bldgmats_numrel_slope_0t12_Invalid := Fields.InValid_bldgmats_numrel_slope_0t12((SALT36.StrType)le.bldgmats_numrel_slope_0t12);
    SELF.bldgmats_numrel_slope_0t24_Invalid := Fields.InValid_bldgmats_numrel_slope_0t24((SALT36.StrType)le.bldgmats_numrel_slope_0t24);
    SELF.bldgmats_numrel_slope_0t6_Invalid := Fields.InValid_bldgmats_numrel_slope_0t6((SALT36.StrType)le.bldgmats_numrel_slope_0t6);
    SELF.bldgmats_numrel_slope_6t12_Invalid := Fields.InValid_bldgmats_numrel_slope_6t12((SALT36.StrType)le.bldgmats_numrel_slope_6t12);
    SELF.bldgmats_numrel_var_0t12_Invalid := Fields.InValid_bldgmats_numrel_var_0t12((SALT36.StrType)le.bldgmats_numrel_var_0t12);
    SELF.bldgmats_numrel_var_12t24_Invalid := Fields.InValid_bldgmats_numrel_var_12t24((SALT36.StrType)le.bldgmats_numrel_var_12t24);
    SELF.total_percprov30_slope_0t12_Invalid := Fields.InValid_total_percprov30_slope_0t12((SALT36.StrType)le.total_percprov30_slope_0t12);
    SELF.total_percprov30_slope_0t24_Invalid := Fields.InValid_total_percprov30_slope_0t24((SALT36.StrType)le.total_percprov30_slope_0t24);
    SELF.total_percprov30_slope_0t6_Invalid := Fields.InValid_total_percprov30_slope_0t6((SALT36.StrType)le.total_percprov30_slope_0t6);
    SELF.total_percprov30_slope_6t12_Invalid := Fields.InValid_total_percprov30_slope_6t12((SALT36.StrType)le.total_percprov30_slope_6t12);
    SELF.total_percprov60_slope_0t12_Invalid := Fields.InValid_total_percprov60_slope_0t12((SALT36.StrType)le.total_percprov60_slope_0t12);
    SELF.total_percprov60_slope_0t24_Invalid := Fields.InValid_total_percprov60_slope_0t24((SALT36.StrType)le.total_percprov60_slope_0t24);
    SELF.total_percprov60_slope_0t6_Invalid := Fields.InValid_total_percprov60_slope_0t6((SALT36.StrType)le.total_percprov60_slope_0t6);
    SELF.total_percprov60_slope_6t12_Invalid := Fields.InValid_total_percprov60_slope_6t12((SALT36.StrType)le.total_percprov60_slope_6t12);
    SELF.total_percprov90_slope_0t24_Invalid := Fields.InValid_total_percprov90_slope_0t24((SALT36.StrType)le.total_percprov90_slope_0t24);
    SELF.total_percprov90_slope_0t6_Invalid := Fields.InValid_total_percprov90_slope_0t6((SALT36.StrType)le.total_percprov90_slope_0t6);
    SELF.total_percprov90_slope_6t12_Invalid := Fields.InValid_total_percprov90_slope_6t12((SALT36.StrType)le.total_percprov90_slope_6t12);
    SELF.mfgmat_percprov30_slope_0t12_Invalid := Fields.InValid_mfgmat_percprov30_slope_0t12((SALT36.StrType)le.mfgmat_percprov30_slope_0t12);
    SELF.mfgmat_percprov30_slope_6t12_Invalid := Fields.InValid_mfgmat_percprov30_slope_6t12((SALT36.StrType)le.mfgmat_percprov30_slope_6t12);
    SELF.mfgmat_percprov60_slope_0t12_Invalid := Fields.InValid_mfgmat_percprov60_slope_0t12((SALT36.StrType)le.mfgmat_percprov60_slope_0t12);
    SELF.mfgmat_percprov60_slope_6t12_Invalid := Fields.InValid_mfgmat_percprov60_slope_6t12((SALT36.StrType)le.mfgmat_percprov60_slope_6t12);
    SELF.mfgmat_percprov90_slope_0t24_Invalid := Fields.InValid_mfgmat_percprov90_slope_0t24((SALT36.StrType)le.mfgmat_percprov90_slope_0t24);
    SELF.mfgmat_percprov90_slope_0t6_Invalid := Fields.InValid_mfgmat_percprov90_slope_0t6((SALT36.StrType)le.mfgmat_percprov90_slope_0t6);
    SELF.mfgmat_percprov90_slope_6t12_Invalid := Fields.InValid_mfgmat_percprov90_slope_6t12((SALT36.StrType)le.mfgmat_percprov90_slope_6t12);
    SELF.ops_percprov30_slope_0t12_Invalid := Fields.InValid_ops_percprov30_slope_0t12((SALT36.StrType)le.ops_percprov30_slope_0t12);
    SELF.ops_percprov30_slope_6t12_Invalid := Fields.InValid_ops_percprov30_slope_6t12((SALT36.StrType)le.ops_percprov30_slope_6t12);
    SELF.ops_percprov60_slope_0t12_Invalid := Fields.InValid_ops_percprov60_slope_0t12((SALT36.StrType)le.ops_percprov60_slope_0t12);
    SELF.ops_percprov60_slope_6t12_Invalid := Fields.InValid_ops_percprov60_slope_6t12((SALT36.StrType)le.ops_percprov60_slope_6t12);
    SELF.ops_percprov90_slope_0t24_Invalid := Fields.InValid_ops_percprov90_slope_0t24((SALT36.StrType)le.ops_percprov90_slope_0t24);
    SELF.ops_percprov90_slope_0t6_Invalid := Fields.InValid_ops_percprov90_slope_0t6((SALT36.StrType)le.ops_percprov90_slope_0t6);
    SELF.ops_percprov90_slope_6t12_Invalid := Fields.InValid_ops_percprov90_slope_6t12((SALT36.StrType)le.ops_percprov90_slope_6t12);
    SELF.fleet_percprov30_slope_0t12_Invalid := Fields.InValid_fleet_percprov30_slope_0t12((SALT36.StrType)le.fleet_percprov30_slope_0t12);
    SELF.fleet_percprov30_slope_6t12_Invalid := Fields.InValid_fleet_percprov30_slope_6t12((SALT36.StrType)le.fleet_percprov30_slope_6t12);
    SELF.fleet_percprov60_slope_0t12_Invalid := Fields.InValid_fleet_percprov60_slope_0t12((SALT36.StrType)le.fleet_percprov60_slope_0t12);
    SELF.fleet_percprov60_slope_6t12_Invalid := Fields.InValid_fleet_percprov60_slope_6t12((SALT36.StrType)le.fleet_percprov60_slope_6t12);
    SELF.fleet_percprov90_slope_0t24_Invalid := Fields.InValid_fleet_percprov90_slope_0t24((SALT36.StrType)le.fleet_percprov90_slope_0t24);
    SELF.fleet_percprov90_slope_0t6_Invalid := Fields.InValid_fleet_percprov90_slope_0t6((SALT36.StrType)le.fleet_percprov90_slope_0t6);
    SELF.fleet_percprov90_slope_6t12_Invalid := Fields.InValid_fleet_percprov90_slope_6t12((SALT36.StrType)le.fleet_percprov90_slope_6t12);
    SELF.carrier_percprov30_slope_0t12_Invalid := Fields.InValid_carrier_percprov30_slope_0t12((SALT36.StrType)le.carrier_percprov30_slope_0t12);
    SELF.carrier_percprov30_slope_6t12_Invalid := Fields.InValid_carrier_percprov30_slope_6t12((SALT36.StrType)le.carrier_percprov30_slope_6t12);
    SELF.carrier_percprov60_slope_0t12_Invalid := Fields.InValid_carrier_percprov60_slope_0t12((SALT36.StrType)le.carrier_percprov60_slope_0t12);
    SELF.carrier_percprov60_slope_6t12_Invalid := Fields.InValid_carrier_percprov60_slope_6t12((SALT36.StrType)le.carrier_percprov60_slope_6t12);
    SELF.carrier_percprov90_slope_0t24_Invalid := Fields.InValid_carrier_percprov90_slope_0t24((SALT36.StrType)le.carrier_percprov90_slope_0t24);
    SELF.carrier_percprov90_slope_0t6_Invalid := Fields.InValid_carrier_percprov90_slope_0t6((SALT36.StrType)le.carrier_percprov90_slope_0t6);
    SELF.carrier_percprov90_slope_6t12_Invalid := Fields.InValid_carrier_percprov90_slope_6t12((SALT36.StrType)le.carrier_percprov90_slope_6t12);
    SELF.bldgmats_percprov30_slope_0t12_Invalid := Fields.InValid_bldgmats_percprov30_slope_0t12((SALT36.StrType)le.bldgmats_percprov30_slope_0t12);
    SELF.bldgmats_percprov30_slope_6t12_Invalid := Fields.InValid_bldgmats_percprov30_slope_6t12((SALT36.StrType)le.bldgmats_percprov30_slope_6t12);
    SELF.bldgmats_percprov60_slope_0t12_Invalid := Fields.InValid_bldgmats_percprov60_slope_0t12((SALT36.StrType)le.bldgmats_percprov60_slope_0t12);
    SELF.bldgmats_percprov60_slope_6t12_Invalid := Fields.InValid_bldgmats_percprov60_slope_6t12((SALT36.StrType)le.bldgmats_percprov60_slope_6t12);
    SELF.bldgmats_percprov90_slope_0t24_Invalid := Fields.InValid_bldgmats_percprov90_slope_0t24((SALT36.StrType)le.bldgmats_percprov90_slope_0t24);
    SELF.bldgmats_percprov90_slope_0t6_Invalid := Fields.InValid_bldgmats_percprov90_slope_0t6((SALT36.StrType)le.bldgmats_percprov90_slope_0t6);
    SELF.bldgmats_percprov90_slope_6t12_Invalid := Fields.InValid_bldgmats_percprov90_slope_6t12((SALT36.StrType)le.bldgmats_percprov90_slope_6t12);
    SELF.top5_percprov30_slope_0t12_Invalid := Fields.InValid_top5_percprov30_slope_0t12((SALT36.StrType)le.top5_percprov30_slope_0t12);
    SELF.top5_percprov30_slope_6t12_Invalid := Fields.InValid_top5_percprov30_slope_6t12((SALT36.StrType)le.top5_percprov30_slope_6t12);
    SELF.top5_percprov60_slope_0t12_Invalid := Fields.InValid_top5_percprov60_slope_0t12((SALT36.StrType)le.top5_percprov60_slope_0t12);
    SELF.top5_percprov60_slope_6t12_Invalid := Fields.InValid_top5_percprov60_slope_6t12((SALT36.StrType)le.top5_percprov60_slope_6t12);
    SELF.top5_percprov90_slope_0t24_Invalid := Fields.InValid_top5_percprov90_slope_0t24((SALT36.StrType)le.top5_percprov90_slope_0t24);
    SELF.top5_percprov90_slope_0t6_Invalid := Fields.InValid_top5_percprov90_slope_0t6((SALT36.StrType)le.top5_percprov90_slope_0t6);
    SELF.top5_percprov90_slope_6t12_Invalid := Fields.InValid_top5_percprov90_slope_6t12((SALT36.StrType)le.top5_percprov90_slope_6t12);
    SELF.top5_percprovoutstanding_adjustedslope_0t12_Invalid := Fields.InValid_top5_percprovoutstanding_adjustedslope_0t12((SALT36.StrType)le.top5_percprovoutstanding_adjustedslope_0t12);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_In_Attributes);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.ultimate_linkid_Invalid << 0 ) + ( le.cortera_score_Invalid << 2 ) + ( le.cpr_score_Invalid << 4 ) + ( le.cpr_segment_Invalid << 6 ) + ( le.dbt_Invalid << 8 ) + ( le.avg_bal_Invalid << 10 ) + ( le.air_spend_Invalid << 12 ) + ( le.fuel_spend_Invalid << 14 ) + ( le.leasing_spend_Invalid << 16 ) + ( le.ltl_spend_Invalid << 18 ) + ( le.rail_spend_Invalid << 20 ) + ( le.tl_spend_Invalid << 22 ) + ( le.transvc_spend_Invalid << 24 ) + ( le.transup_spend_Invalid << 26 ) + ( le.bst_spend_Invalid << 28 ) + ( le.dg_spend_Invalid << 30 ) + ( le.electrical_spend_Invalid << 32 ) + ( le.hvac_spend_Invalid << 34 ) + ( le.other_b_spend_Invalid << 36 ) + ( le.plumbing_spend_Invalid << 38 ) + ( le.rs_spend_Invalid << 40 ) + ( le.wp_spend_Invalid << 42 ) + ( le.chemical_spend_Invalid << 44 ) + ( le.electronic_spend_Invalid << 46 ) + ( le.metal_spend_Invalid << 48 ) + ( le.other_m_spend_Invalid << 50 ) + ( le.packaging_spend_Invalid << 52 ) + ( le.pvf_spend_Invalid << 54 ) + ( le.plastic_spend_Invalid << 56 ) + ( le.textile_spend_Invalid << 58 ) + ( le.bs_spend_Invalid << 60 ) + ( le.ce_spend_Invalid << 62 );
    SELF.ScrubsBits2 := ( le.hardware_spend_Invalid << 0 ) + ( le.ie_spend_Invalid << 2 ) + ( le.is_spend_Invalid << 4 ) + ( le.it_spend_Invalid << 6 ) + ( le.mls_spend_Invalid << 8 ) + ( le.os_spend_Invalid << 10 ) + ( le.pp_spend_Invalid << 12 ) + ( le.sis_spend_Invalid << 14 ) + ( le.apparel_spend_Invalid << 16 ) + ( le.beverages_spend_Invalid << 18 ) + ( le.constr_spend_Invalid << 20 ) + ( le.consulting_spend_Invalid << 22 ) + ( le.fs_spend_Invalid << 24 ) + ( le.fp_spend_Invalid << 26 ) + ( le.insurance_spend_Invalid << 28 ) + ( le.ls_spend_Invalid << 30 ) + ( le.oil_gas_spend_Invalid << 32 ) + ( le.utilities_spend_Invalid << 34 ) + ( le.other_spend_Invalid << 36 ) + ( le.advt_spend_Invalid << 38 ) + ( le.air_growth_Invalid << 40 ) + ( le.fuel_growth_Invalid << 42 ) + ( le.leasing_growth_Invalid << 44 ) + ( le.ltl_growth_Invalid << 46 ) + ( le.rail_growth_Invalid << 48 ) + ( le.tl_growth_Invalid << 50 ) + ( le.transvc_growth_Invalid << 52 ) + ( le.transup_growth_Invalid << 54 ) + ( le.bst_growth_Invalid << 56 ) + ( le.dg_growth_Invalid << 58 ) + ( le.electrical_growth_Invalid << 60 ) + ( le.hvac_growth_Invalid << 62 );
    SELF.ScrubsBits3 := ( le.other_b_growth_Invalid << 0 ) + ( le.plumbing_growth_Invalid << 2 ) + ( le.rs_growth_Invalid << 4 ) + ( le.wp_growth_Invalid << 6 ) + ( le.chemical_growth_Invalid << 8 ) + ( le.electronic_growth_Invalid << 10 ) + ( le.metal_growth_Invalid << 12 ) + ( le.other_m_growth_Invalid << 14 ) + ( le.packaging_growth_Invalid << 16 ) + ( le.pvf_growth_Invalid << 18 ) + ( le.plastic_growth_Invalid << 20 ) + ( le.textile_growth_Invalid << 22 ) + ( le.bs_growth_Invalid << 24 ) + ( le.ce_growth_Invalid << 26 ) + ( le.hardware_growth_Invalid << 28 ) + ( le.ie_growth_Invalid << 30 ) + ( le.is_growth_Invalid << 32 ) + ( le.it_growth_Invalid << 34 ) + ( le.mls_growth_Invalid << 36 ) + ( le.os_growth_Invalid << 38 ) + ( le.pp_growth_Invalid << 40 ) + ( le.sis_growth_Invalid << 42 ) + ( le.apparel_growth_Invalid << 44 ) + ( le.beverages_growth_Invalid << 46 ) + ( le.constr_growth_Invalid << 48 ) + ( le.consulting_growth_Invalid << 50 ) + ( le.fs_growth_Invalid << 52 ) + ( le.fp_growth_Invalid << 54 ) + ( le.insurance_growth_Invalid << 56 ) + ( le.ls_growth_Invalid << 58 ) + ( le.oil_gas_growth_Invalid << 60 ) + ( le.utilities_growth_Invalid << 62 );
    SELF.ScrubsBits4 := ( le.other_growth_Invalid << 0 ) + ( le.advt_growth_Invalid << 2 ) + ( le.top5_growth_Invalid << 4 ) + ( le.shipping_y1_Invalid << 6 ) + ( le.shipping_growth_Invalid << 8 ) + ( le.materials_y1_Invalid << 10 ) + ( le.materials_growth_Invalid << 12 ) + ( le.operations_y1_Invalid << 14 ) + ( le.operations_growth_Invalid << 16 ) + ( le.total_paid_average_0t12_Invalid << 18 ) + ( le.total_paid_monthspastworst_24_Invalid << 20 ) + ( le.total_paid_slope_0t12_Invalid << 22 ) + ( le.total_paid_slope_0t6_Invalid << 24 ) + ( le.total_paid_slope_6t12_Invalid << 26 ) + ( le.total_paid_slope_6t18_Invalid << 28 ) + ( le.total_paid_volatility_0t12_Invalid << 30 ) + ( le.total_paid_volatility_0t6_Invalid << 32 ) + ( le.total_paid_volatility_12t18_Invalid << 34 ) + ( le.total_paid_volatility_6t12_Invalid << 36 ) + ( le.total_spend_monthspastleast_24_Invalid << 38 ) + ( le.total_spend_monthspastmost_24_Invalid << 40 ) + ( le.total_spend_slope_0t12_Invalid << 42 ) + ( le.total_spend_slope_0t24_Invalid << 44 ) + ( le.total_spend_slope_0t6_Invalid << 46 ) + ( le.total_spend_slope_6t12_Invalid << 48 ) + ( le.total_spend_sum_12_Invalid << 50 ) + ( le.total_spend_volatility_0t12_Invalid << 52 ) + ( le.total_spend_volatility_0t6_Invalid << 54 ) + ( le.total_spend_volatility_12t18_Invalid << 56 ) + ( le.total_spend_volatility_6t12_Invalid << 58 ) + ( le.mfgmat_paid_average_12_Invalid << 60 ) + ( le.mfgmat_paid_monthspastworst_24_Invalid << 62 );
    SELF.ScrubsBits5 := ( le.mfgmat_paid_slope_0t12_Invalid << 0 ) + ( le.mfgmat_paid_slope_0t24_Invalid << 2 ) + ( le.mfgmat_paid_slope_0t6_Invalid << 4 ) + ( le.mfgmat_paid_volatility_0t12_Invalid << 6 ) + ( le.mfgmat_paid_volatility_0t6_Invalid << 8 ) + ( le.mfgmat_spend_monthspastleast_24_Invalid << 10 ) + ( le.mfgmat_spend_monthspastmost_24_Invalid << 12 ) + ( le.mfgmat_spend_slope_0t12_Invalid << 14 ) + ( le.mfgmat_spend_slope_0t24_Invalid << 16 ) + ( le.mfgmat_spend_slope_0t6_Invalid << 18 ) + ( le.mfgmat_spend_sum_12_Invalid << 20 ) + ( le.mfgmat_spend_volatility_0t6_Invalid << 22 ) + ( le.mfgmat_spend_volatility_6t12_Invalid << 24 ) + ( le.ops_paid_average_12_Invalid << 26 ) + ( le.ops_paid_monthspastworst_24_Invalid << 28 ) + ( le.ops_paid_slope_0t12_Invalid << 30 ) + ( le.ops_paid_slope_0t24_Invalid << 32 ) + ( le.ops_paid_slope_0t6_Invalid << 34 ) + ( le.ops_paid_volatility_0t12_Invalid << 36 ) + ( le.ops_paid_volatility_0t6_Invalid << 38 ) + ( le.ops_spend_monthspastleast_24_Invalid << 40 ) + ( le.ops_spend_monthspastmost_24_Invalid << 42 ) + ( le.ops_spend_slope_0t12_Invalid << 44 ) + ( le.ops_spend_slope_0t24_Invalid << 46 ) + ( le.ops_spend_slope_0t6_Invalid << 48 ) + ( le.fleet_paid_monthspastworst_24_Invalid << 50 ) + ( le.fleet_paid_slope_0t12_Invalid << 52 ) + ( le.fleet_paid_slope_0t24_Invalid << 54 ) + ( le.fleet_paid_slope_0t6_Invalid << 56 ) + ( le.fleet_paid_volatility_0t12_Invalid << 58 ) + ( le.fleet_paid_volatility_0t6_Invalid << 60 ) + ( le.fleet_spend_slope_0t12_Invalid << 62 );
    SELF.ScrubsBits6 := ( le.fleet_spend_slope_0t24_Invalid << 0 ) + ( le.fleet_spend_slope_0t6_Invalid << 2 ) + ( le.carrier_paid_slope_0t12_Invalid << 4 ) + ( le.carrier_paid_slope_0t24_Invalid << 6 ) + ( le.carrier_paid_slope_0t6_Invalid << 8 ) + ( le.carrier_paid_volatility_0t12_Invalid << 10 ) + ( le.carrier_paid_volatility_0t6_Invalid << 12 ) + ( le.carrier_spend_slope_0t12_Invalid << 14 ) + ( le.carrier_spend_slope_0t24_Invalid << 16 ) + ( le.carrier_spend_slope_0t6_Invalid << 18 ) + ( le.carrier_spend_volatility_0t6_Invalid << 20 ) + ( le.carrier_spend_volatility_6t12_Invalid << 22 ) + ( le.bldgmats_paid_slope_0t12_Invalid << 24 ) + ( le.bldgmats_paid_slope_0t24_Invalid << 26 ) + ( le.bldgmats_paid_slope_0t6_Invalid << 28 ) + ( le.bldgmats_paid_volatility_0t12_Invalid << 30 ) + ( le.bldgmats_paid_volatility_0t6_Invalid << 32 ) + ( le.bldgmats_spend_slope_0t12_Invalid << 34 ) + ( le.bldgmats_spend_slope_0t24_Invalid << 36 ) + ( le.bldgmats_spend_slope_0t6_Invalid << 38 ) + ( le.bldgmats_spend_volatility_0t6_Invalid << 40 ) + ( le.bldgmats_spend_volatility_6t12_Invalid << 42 ) + ( le.top5_paid_slope_0t12_Invalid << 44 ) + ( le.top5_paid_slope_0t24_Invalid << 46 ) + ( le.top5_paid_slope_0t6_Invalid << 48 ) + ( le.top5_paid_volatility_0t12_Invalid << 50 ) + ( le.top5_paid_volatility_0t6_Invalid << 52 ) + ( le.top5_spend_slope_0t12_Invalid << 54 ) + ( le.top5_spend_slope_0t24_Invalid << 56 ) + ( le.top5_spend_slope_0t6_Invalid << 58 ) + ( le.top5_spend_volatility_0t6_Invalid << 60 ) + ( le.top5_spend_volatility_6t12_Invalid << 62 );
    SELF.ScrubsBits7 := ( le.total_numrel_slope_0t12_Invalid << 0 ) + ( le.total_numrel_slope_0t24_Invalid << 2 ) + ( le.total_numrel_slope_0t6_Invalid << 4 ) + ( le.total_numrel_slope_6t12_Invalid << 6 ) + ( le.mfgmat_numrel_slope_0t12_Invalid << 8 ) + ( le.mfgmat_numrel_slope_0t24_Invalid << 10 ) + ( le.mfgmat_numrel_slope_0t6_Invalid << 12 ) + ( le.mfgmat_numrel_slope_6t12_Invalid << 14 ) + ( le.ops_numrel_slope_0t12_Invalid << 16 ) + ( le.ops_numrel_slope_0t24_Invalid << 18 ) + ( le.ops_numrel_slope_0t6_Invalid << 20 ) + ( le.ops_numrel_slope_6t12_Invalid << 22 ) + ( le.fleet_numrel_slope_0t12_Invalid << 24 ) + ( le.fleet_numrel_slope_0t24_Invalid << 26 ) + ( le.fleet_numrel_slope_0t6_Invalid << 28 ) + ( le.fleet_numrel_slope_6t12_Invalid << 30 ) + ( le.carrier_numrel_slope_0t12_Invalid << 32 ) + ( le.carrier_numrel_slope_0t24_Invalid << 34 ) + ( le.carrier_numrel_slope_0t6_Invalid << 36 ) + ( le.carrier_numrel_slope_6t12_Invalid << 38 ) + ( le.bldgmats_numrel_slope_0t12_Invalid << 40 ) + ( le.bldgmats_numrel_slope_0t24_Invalid << 42 ) + ( le.bldgmats_numrel_slope_0t6_Invalid << 44 ) + ( le.bldgmats_numrel_slope_6t12_Invalid << 46 ) + ( le.bldgmats_numrel_var_0t12_Invalid << 48 ) + ( le.bldgmats_numrel_var_12t24_Invalid << 50 ) + ( le.total_percprov30_slope_0t12_Invalid << 52 ) + ( le.total_percprov30_slope_0t24_Invalid << 54 ) + ( le.total_percprov30_slope_0t6_Invalid << 56 ) + ( le.total_percprov30_slope_6t12_Invalid << 58 ) + ( le.total_percprov60_slope_0t12_Invalid << 60 ) + ( le.total_percprov60_slope_0t24_Invalid << 62 );
    SELF.ScrubsBits8 := ( le.total_percprov60_slope_0t6_Invalid << 0 ) + ( le.total_percprov60_slope_6t12_Invalid << 2 ) + ( le.total_percprov90_slope_0t24_Invalid << 4 ) + ( le.total_percprov90_slope_0t6_Invalid << 6 ) + ( le.total_percprov90_slope_6t12_Invalid << 8 ) + ( le.mfgmat_percprov30_slope_0t12_Invalid << 10 ) + ( le.mfgmat_percprov30_slope_6t12_Invalid << 12 ) + ( le.mfgmat_percprov60_slope_0t12_Invalid << 14 ) + ( le.mfgmat_percprov60_slope_6t12_Invalid << 16 ) + ( le.mfgmat_percprov90_slope_0t24_Invalid << 18 ) + ( le.mfgmat_percprov90_slope_0t6_Invalid << 20 ) + ( le.mfgmat_percprov90_slope_6t12_Invalid << 22 ) + ( le.ops_percprov30_slope_0t12_Invalid << 24 ) + ( le.ops_percprov30_slope_6t12_Invalid << 26 ) + ( le.ops_percprov60_slope_0t12_Invalid << 28 ) + ( le.ops_percprov60_slope_6t12_Invalid << 30 ) + ( le.ops_percprov90_slope_0t24_Invalid << 32 ) + ( le.ops_percprov90_slope_0t6_Invalid << 34 ) + ( le.ops_percprov90_slope_6t12_Invalid << 36 ) + ( le.fleet_percprov30_slope_0t12_Invalid << 38 ) + ( le.fleet_percprov30_slope_6t12_Invalid << 40 ) + ( le.fleet_percprov60_slope_0t12_Invalid << 42 ) + ( le.fleet_percprov60_slope_6t12_Invalid << 44 ) + ( le.fleet_percprov90_slope_0t24_Invalid << 46 ) + ( le.fleet_percprov90_slope_0t6_Invalid << 48 ) + ( le.fleet_percprov90_slope_6t12_Invalid << 50 ) + ( le.carrier_percprov30_slope_0t12_Invalid << 52 ) + ( le.carrier_percprov30_slope_6t12_Invalid << 54 ) + ( le.carrier_percprov60_slope_0t12_Invalid << 56 ) + ( le.carrier_percprov60_slope_6t12_Invalid << 58 ) + ( le.carrier_percprov90_slope_0t24_Invalid << 60 ) + ( le.carrier_percprov90_slope_0t6_Invalid << 62 );
    SELF.ScrubsBits9 := ( le.carrier_percprov90_slope_6t12_Invalid << 0 ) + ( le.bldgmats_percprov30_slope_0t12_Invalid << 2 ) + ( le.bldgmats_percprov30_slope_6t12_Invalid << 4 ) + ( le.bldgmats_percprov60_slope_0t12_Invalid << 6 ) + ( le.bldgmats_percprov60_slope_6t12_Invalid << 8 ) + ( le.bldgmats_percprov90_slope_0t24_Invalid << 10 ) + ( le.bldgmats_percprov90_slope_0t6_Invalid << 12 ) + ( le.bldgmats_percprov90_slope_6t12_Invalid << 14 ) + ( le.top5_percprov30_slope_0t12_Invalid << 16 ) + ( le.top5_percprov30_slope_6t12_Invalid << 18 ) + ( le.top5_percprov60_slope_0t12_Invalid << 20 ) + ( le.top5_percprov60_slope_6t12_Invalid << 22 ) + ( le.top5_percprov90_slope_0t24_Invalid << 24 ) + ( le.top5_percprov90_slope_0t6_Invalid << 26 ) + ( le.top5_percprov90_slope_6t12_Invalid << 28 ) + ( le.top5_percprovoutstanding_adjustedslope_0t12_Invalid << 30 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_In_Attributes);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.ultimate_linkid_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.cortera_score_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.cpr_score_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.cpr_segment_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.dbt_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.avg_bal_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.air_spend_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.fuel_spend_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.leasing_spend_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.ltl_spend_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.rail_spend_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.tl_spend_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.transvc_spend_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.transup_spend_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.bst_spend_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.dg_spend_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.electrical_spend_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.hvac_spend_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.other_b_spend_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF.plumbing_spend_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.rs_spend_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF.wp_spend_Invalid := (le.ScrubsBits1 >> 42) & 3;
    SELF.chemical_spend_Invalid := (le.ScrubsBits1 >> 44) & 3;
    SELF.electronic_spend_Invalid := (le.ScrubsBits1 >> 46) & 3;
    SELF.metal_spend_Invalid := (le.ScrubsBits1 >> 48) & 3;
    SELF.other_m_spend_Invalid := (le.ScrubsBits1 >> 50) & 3;
    SELF.packaging_spend_Invalid := (le.ScrubsBits1 >> 52) & 3;
    SELF.pvf_spend_Invalid := (le.ScrubsBits1 >> 54) & 3;
    SELF.plastic_spend_Invalid := (le.ScrubsBits1 >> 56) & 3;
    SELF.textile_spend_Invalid := (le.ScrubsBits1 >> 58) & 3;
    SELF.bs_spend_Invalid := (le.ScrubsBits1 >> 60) & 3;
    SELF.ce_spend_Invalid := (le.ScrubsBits1 >> 62) & 3;
    SELF.hardware_spend_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.ie_spend_Invalid := (le.ScrubsBits2 >> 2) & 3;
    SELF.is_spend_Invalid := (le.ScrubsBits2 >> 4) & 3;
    SELF.it_spend_Invalid := (le.ScrubsBits2 >> 6) & 3;
    SELF.mls_spend_Invalid := (le.ScrubsBits2 >> 8) & 3;
    SELF.os_spend_Invalid := (le.ScrubsBits2 >> 10) & 3;
    SELF.pp_spend_Invalid := (le.ScrubsBits2 >> 12) & 3;
    SELF.sis_spend_Invalid := (le.ScrubsBits2 >> 14) & 3;
    SELF.apparel_spend_Invalid := (le.ScrubsBits2 >> 16) & 3;
    SELF.beverages_spend_Invalid := (le.ScrubsBits2 >> 18) & 3;
    SELF.constr_spend_Invalid := (le.ScrubsBits2 >> 20) & 3;
    SELF.consulting_spend_Invalid := (le.ScrubsBits2 >> 22) & 3;
    SELF.fs_spend_Invalid := (le.ScrubsBits2 >> 24) & 3;
    SELF.fp_spend_Invalid := (le.ScrubsBits2 >> 26) & 3;
    SELF.insurance_spend_Invalid := (le.ScrubsBits2 >> 28) & 3;
    SELF.ls_spend_Invalid := (le.ScrubsBits2 >> 30) & 3;
    SELF.oil_gas_spend_Invalid := (le.ScrubsBits2 >> 32) & 3;
    SELF.utilities_spend_Invalid := (le.ScrubsBits2 >> 34) & 3;
    SELF.other_spend_Invalid := (le.ScrubsBits2 >> 36) & 3;
    SELF.advt_spend_Invalid := (le.ScrubsBits2 >> 38) & 3;
    SELF.air_growth_Invalid := (le.ScrubsBits2 >> 40) & 3;
    SELF.fuel_growth_Invalid := (le.ScrubsBits2 >> 42) & 3;
    SELF.leasing_growth_Invalid := (le.ScrubsBits2 >> 44) & 3;
    SELF.ltl_growth_Invalid := (le.ScrubsBits2 >> 46) & 3;
    SELF.rail_growth_Invalid := (le.ScrubsBits2 >> 48) & 3;
    SELF.tl_growth_Invalid := (le.ScrubsBits2 >> 50) & 3;
    SELF.transvc_growth_Invalid := (le.ScrubsBits2 >> 52) & 3;
    SELF.transup_growth_Invalid := (le.ScrubsBits2 >> 54) & 3;
    SELF.bst_growth_Invalid := (le.ScrubsBits2 >> 56) & 3;
    SELF.dg_growth_Invalid := (le.ScrubsBits2 >> 58) & 3;
    SELF.electrical_growth_Invalid := (le.ScrubsBits2 >> 60) & 3;
    SELF.hvac_growth_Invalid := (le.ScrubsBits2 >> 62) & 3;
    SELF.other_b_growth_Invalid := (le.ScrubsBits3 >> 0) & 3;
    SELF.plumbing_growth_Invalid := (le.ScrubsBits3 >> 2) & 3;
    SELF.rs_growth_Invalid := (le.ScrubsBits3 >> 4) & 3;
    SELF.wp_growth_Invalid := (le.ScrubsBits3 >> 6) & 3;
    SELF.chemical_growth_Invalid := (le.ScrubsBits3 >> 8) & 3;
    SELF.electronic_growth_Invalid := (le.ScrubsBits3 >> 10) & 3;
    SELF.metal_growth_Invalid := (le.ScrubsBits3 >> 12) & 3;
    SELF.other_m_growth_Invalid := (le.ScrubsBits3 >> 14) & 3;
    SELF.packaging_growth_Invalid := (le.ScrubsBits3 >> 16) & 3;
    SELF.pvf_growth_Invalid := (le.ScrubsBits3 >> 18) & 3;
    SELF.plastic_growth_Invalid := (le.ScrubsBits3 >> 20) & 3;
    SELF.textile_growth_Invalid := (le.ScrubsBits3 >> 22) & 3;
    SELF.bs_growth_Invalid := (le.ScrubsBits3 >> 24) & 3;
    SELF.ce_growth_Invalid := (le.ScrubsBits3 >> 26) & 3;
    SELF.hardware_growth_Invalid := (le.ScrubsBits3 >> 28) & 3;
    SELF.ie_growth_Invalid := (le.ScrubsBits3 >> 30) & 3;
    SELF.is_growth_Invalid := (le.ScrubsBits3 >> 32) & 3;
    SELF.it_growth_Invalid := (le.ScrubsBits3 >> 34) & 3;
    SELF.mls_growth_Invalid := (le.ScrubsBits3 >> 36) & 3;
    SELF.os_growth_Invalid := (le.ScrubsBits3 >> 38) & 3;
    SELF.pp_growth_Invalid := (le.ScrubsBits3 >> 40) & 3;
    SELF.sis_growth_Invalid := (le.ScrubsBits3 >> 42) & 3;
    SELF.apparel_growth_Invalid := (le.ScrubsBits3 >> 44) & 3;
    SELF.beverages_growth_Invalid := (le.ScrubsBits3 >> 46) & 3;
    SELF.constr_growth_Invalid := (le.ScrubsBits3 >> 48) & 3;
    SELF.consulting_growth_Invalid := (le.ScrubsBits3 >> 50) & 3;
    SELF.fs_growth_Invalid := (le.ScrubsBits3 >> 52) & 3;
    SELF.fp_growth_Invalid := (le.ScrubsBits3 >> 54) & 3;
    SELF.insurance_growth_Invalid := (le.ScrubsBits3 >> 56) & 3;
    SELF.ls_growth_Invalid := (le.ScrubsBits3 >> 58) & 3;
    SELF.oil_gas_growth_Invalid := (le.ScrubsBits3 >> 60) & 3;
    SELF.utilities_growth_Invalid := (le.ScrubsBits3 >> 62) & 3;
    SELF.other_growth_Invalid := (le.ScrubsBits4 >> 0) & 3;
    SELF.advt_growth_Invalid := (le.ScrubsBits4 >> 2) & 3;
    SELF.top5_growth_Invalid := (le.ScrubsBits4 >> 4) & 3;
    SELF.shipping_y1_Invalid := (le.ScrubsBits4 >> 6) & 3;
    SELF.shipping_growth_Invalid := (le.ScrubsBits4 >> 8) & 3;
    SELF.materials_y1_Invalid := (le.ScrubsBits4 >> 10) & 3;
    SELF.materials_growth_Invalid := (le.ScrubsBits4 >> 12) & 3;
    SELF.operations_y1_Invalid := (le.ScrubsBits4 >> 14) & 3;
    SELF.operations_growth_Invalid := (le.ScrubsBits4 >> 16) & 3;
    SELF.total_paid_average_0t12_Invalid := (le.ScrubsBits4 >> 18) & 3;
    SELF.total_paid_monthspastworst_24_Invalid := (le.ScrubsBits4 >> 20) & 3;
    SELF.total_paid_slope_0t12_Invalid := (le.ScrubsBits4 >> 22) & 3;
    SELF.total_paid_slope_0t6_Invalid := (le.ScrubsBits4 >> 24) & 3;
    SELF.total_paid_slope_6t12_Invalid := (le.ScrubsBits4 >> 26) & 3;
    SELF.total_paid_slope_6t18_Invalid := (le.ScrubsBits4 >> 28) & 3;
    SELF.total_paid_volatility_0t12_Invalid := (le.ScrubsBits4 >> 30) & 3;
    SELF.total_paid_volatility_0t6_Invalid := (le.ScrubsBits4 >> 32) & 3;
    SELF.total_paid_volatility_12t18_Invalid := (le.ScrubsBits4 >> 34) & 3;
    SELF.total_paid_volatility_6t12_Invalid := (le.ScrubsBits4 >> 36) & 3;
    SELF.total_spend_monthspastleast_24_Invalid := (le.ScrubsBits4 >> 38) & 3;
    SELF.total_spend_monthspastmost_24_Invalid := (le.ScrubsBits4 >> 40) & 3;
    SELF.total_spend_slope_0t12_Invalid := (le.ScrubsBits4 >> 42) & 3;
    SELF.total_spend_slope_0t24_Invalid := (le.ScrubsBits4 >> 44) & 3;
    SELF.total_spend_slope_0t6_Invalid := (le.ScrubsBits4 >> 46) & 3;
    SELF.total_spend_slope_6t12_Invalid := (le.ScrubsBits4 >> 48) & 3;
    SELF.total_spend_sum_12_Invalid := (le.ScrubsBits4 >> 50) & 3;
    SELF.total_spend_volatility_0t12_Invalid := (le.ScrubsBits4 >> 52) & 3;
    SELF.total_spend_volatility_0t6_Invalid := (le.ScrubsBits4 >> 54) & 3;
    SELF.total_spend_volatility_12t18_Invalid := (le.ScrubsBits4 >> 56) & 3;
    SELF.total_spend_volatility_6t12_Invalid := (le.ScrubsBits4 >> 58) & 3;
    SELF.mfgmat_paid_average_12_Invalid := (le.ScrubsBits4 >> 60) & 3;
    SELF.mfgmat_paid_monthspastworst_24_Invalid := (le.ScrubsBits4 >> 62) & 3;
    SELF.mfgmat_paid_slope_0t12_Invalid := (le.ScrubsBits5 >> 0) & 3;
    SELF.mfgmat_paid_slope_0t24_Invalid := (le.ScrubsBits5 >> 2) & 3;
    SELF.mfgmat_paid_slope_0t6_Invalid := (le.ScrubsBits5 >> 4) & 3;
    SELF.mfgmat_paid_volatility_0t12_Invalid := (le.ScrubsBits5 >> 6) & 3;
    SELF.mfgmat_paid_volatility_0t6_Invalid := (le.ScrubsBits5 >> 8) & 3;
    SELF.mfgmat_spend_monthspastleast_24_Invalid := (le.ScrubsBits5 >> 10) & 3;
    SELF.mfgmat_spend_monthspastmost_24_Invalid := (le.ScrubsBits5 >> 12) & 3;
    SELF.mfgmat_spend_slope_0t12_Invalid := (le.ScrubsBits5 >> 14) & 3;
    SELF.mfgmat_spend_slope_0t24_Invalid := (le.ScrubsBits5 >> 16) & 3;
    SELF.mfgmat_spend_slope_0t6_Invalid := (le.ScrubsBits5 >> 18) & 3;
    SELF.mfgmat_spend_sum_12_Invalid := (le.ScrubsBits5 >> 20) & 3;
    SELF.mfgmat_spend_volatility_0t6_Invalid := (le.ScrubsBits5 >> 22) & 3;
    SELF.mfgmat_spend_volatility_6t12_Invalid := (le.ScrubsBits5 >> 24) & 3;
    SELF.ops_paid_average_12_Invalid := (le.ScrubsBits5 >> 26) & 3;
    SELF.ops_paid_monthspastworst_24_Invalid := (le.ScrubsBits5 >> 28) & 3;
    SELF.ops_paid_slope_0t12_Invalid := (le.ScrubsBits5 >> 30) & 3;
    SELF.ops_paid_slope_0t24_Invalid := (le.ScrubsBits5 >> 32) & 3;
    SELF.ops_paid_slope_0t6_Invalid := (le.ScrubsBits5 >> 34) & 3;
    SELF.ops_paid_volatility_0t12_Invalid := (le.ScrubsBits5 >> 36) & 3;
    SELF.ops_paid_volatility_0t6_Invalid := (le.ScrubsBits5 >> 38) & 3;
    SELF.ops_spend_monthspastleast_24_Invalid := (le.ScrubsBits5 >> 40) & 3;
    SELF.ops_spend_monthspastmost_24_Invalid := (le.ScrubsBits5 >> 42) & 3;
    SELF.ops_spend_slope_0t12_Invalid := (le.ScrubsBits5 >> 44) & 3;
    SELF.ops_spend_slope_0t24_Invalid := (le.ScrubsBits5 >> 46) & 3;
    SELF.ops_spend_slope_0t6_Invalid := (le.ScrubsBits5 >> 48) & 3;
    SELF.fleet_paid_monthspastworst_24_Invalid := (le.ScrubsBits5 >> 50) & 3;
    SELF.fleet_paid_slope_0t12_Invalid := (le.ScrubsBits5 >> 52) & 3;
    SELF.fleet_paid_slope_0t24_Invalid := (le.ScrubsBits5 >> 54) & 3;
    SELF.fleet_paid_slope_0t6_Invalid := (le.ScrubsBits5 >> 56) & 3;
    SELF.fleet_paid_volatility_0t12_Invalid := (le.ScrubsBits5 >> 58) & 3;
    SELF.fleet_paid_volatility_0t6_Invalid := (le.ScrubsBits5 >> 60) & 3;
    SELF.fleet_spend_slope_0t12_Invalid := (le.ScrubsBits5 >> 62) & 3;
    SELF.fleet_spend_slope_0t24_Invalid := (le.ScrubsBits6 >> 0) & 3;
    SELF.fleet_spend_slope_0t6_Invalid := (le.ScrubsBits6 >> 2) & 3;
    SELF.carrier_paid_slope_0t12_Invalid := (le.ScrubsBits6 >> 4) & 3;
    SELF.carrier_paid_slope_0t24_Invalid := (le.ScrubsBits6 >> 6) & 3;
    SELF.carrier_paid_slope_0t6_Invalid := (le.ScrubsBits6 >> 8) & 3;
    SELF.carrier_paid_volatility_0t12_Invalid := (le.ScrubsBits6 >> 10) & 3;
    SELF.carrier_paid_volatility_0t6_Invalid := (le.ScrubsBits6 >> 12) & 3;
    SELF.carrier_spend_slope_0t12_Invalid := (le.ScrubsBits6 >> 14) & 3;
    SELF.carrier_spend_slope_0t24_Invalid := (le.ScrubsBits6 >> 16) & 3;
    SELF.carrier_spend_slope_0t6_Invalid := (le.ScrubsBits6 >> 18) & 3;
    SELF.carrier_spend_volatility_0t6_Invalid := (le.ScrubsBits6 >> 20) & 3;
    SELF.carrier_spend_volatility_6t12_Invalid := (le.ScrubsBits6 >> 22) & 3;
    SELF.bldgmats_paid_slope_0t12_Invalid := (le.ScrubsBits6 >> 24) & 3;
    SELF.bldgmats_paid_slope_0t24_Invalid := (le.ScrubsBits6 >> 26) & 3;
    SELF.bldgmats_paid_slope_0t6_Invalid := (le.ScrubsBits6 >> 28) & 3;
    SELF.bldgmats_paid_volatility_0t12_Invalid := (le.ScrubsBits6 >> 30) & 3;
    SELF.bldgmats_paid_volatility_0t6_Invalid := (le.ScrubsBits6 >> 32) & 3;
    SELF.bldgmats_spend_slope_0t12_Invalid := (le.ScrubsBits6 >> 34) & 3;
    SELF.bldgmats_spend_slope_0t24_Invalid := (le.ScrubsBits6 >> 36) & 3;
    SELF.bldgmats_spend_slope_0t6_Invalid := (le.ScrubsBits6 >> 38) & 3;
    SELF.bldgmats_spend_volatility_0t6_Invalid := (le.ScrubsBits6 >> 40) & 3;
    SELF.bldgmats_spend_volatility_6t12_Invalid := (le.ScrubsBits6 >> 42) & 3;
    SELF.top5_paid_slope_0t12_Invalid := (le.ScrubsBits6 >> 44) & 3;
    SELF.top5_paid_slope_0t24_Invalid := (le.ScrubsBits6 >> 46) & 3;
    SELF.top5_paid_slope_0t6_Invalid := (le.ScrubsBits6 >> 48) & 3;
    SELF.top5_paid_volatility_0t12_Invalid := (le.ScrubsBits6 >> 50) & 3;
    SELF.top5_paid_volatility_0t6_Invalid := (le.ScrubsBits6 >> 52) & 3;
    SELF.top5_spend_slope_0t12_Invalid := (le.ScrubsBits6 >> 54) & 3;
    SELF.top5_spend_slope_0t24_Invalid := (le.ScrubsBits6 >> 56) & 3;
    SELF.top5_spend_slope_0t6_Invalid := (le.ScrubsBits6 >> 58) & 3;
    SELF.top5_spend_volatility_0t6_Invalid := (le.ScrubsBits6 >> 60) & 3;
    SELF.top5_spend_volatility_6t12_Invalid := (le.ScrubsBits6 >> 62) & 3;
    SELF.total_numrel_slope_0t12_Invalid := (le.ScrubsBits7 >> 0) & 3;
    SELF.total_numrel_slope_0t24_Invalid := (le.ScrubsBits7 >> 2) & 3;
    SELF.total_numrel_slope_0t6_Invalid := (le.ScrubsBits7 >> 4) & 3;
    SELF.total_numrel_slope_6t12_Invalid := (le.ScrubsBits7 >> 6) & 3;
    SELF.mfgmat_numrel_slope_0t12_Invalid := (le.ScrubsBits7 >> 8) & 3;
    SELF.mfgmat_numrel_slope_0t24_Invalid := (le.ScrubsBits7 >> 10) & 3;
    SELF.mfgmat_numrel_slope_0t6_Invalid := (le.ScrubsBits7 >> 12) & 3;
    SELF.mfgmat_numrel_slope_6t12_Invalid := (le.ScrubsBits7 >> 14) & 3;
    SELF.ops_numrel_slope_0t12_Invalid := (le.ScrubsBits7 >> 16) & 3;
    SELF.ops_numrel_slope_0t24_Invalid := (le.ScrubsBits7 >> 18) & 3;
    SELF.ops_numrel_slope_0t6_Invalid := (le.ScrubsBits7 >> 20) & 3;
    SELF.ops_numrel_slope_6t12_Invalid := (le.ScrubsBits7 >> 22) & 3;
    SELF.fleet_numrel_slope_0t12_Invalid := (le.ScrubsBits7 >> 24) & 3;
    SELF.fleet_numrel_slope_0t24_Invalid := (le.ScrubsBits7 >> 26) & 3;
    SELF.fleet_numrel_slope_0t6_Invalid := (le.ScrubsBits7 >> 28) & 3;
    SELF.fleet_numrel_slope_6t12_Invalid := (le.ScrubsBits7 >> 30) & 3;
    SELF.carrier_numrel_slope_0t12_Invalid := (le.ScrubsBits7 >> 32) & 3;
    SELF.carrier_numrel_slope_0t24_Invalid := (le.ScrubsBits7 >> 34) & 3;
    SELF.carrier_numrel_slope_0t6_Invalid := (le.ScrubsBits7 >> 36) & 3;
    SELF.carrier_numrel_slope_6t12_Invalid := (le.ScrubsBits7 >> 38) & 3;
    SELF.bldgmats_numrel_slope_0t12_Invalid := (le.ScrubsBits7 >> 40) & 3;
    SELF.bldgmats_numrel_slope_0t24_Invalid := (le.ScrubsBits7 >> 42) & 3;
    SELF.bldgmats_numrel_slope_0t6_Invalid := (le.ScrubsBits7 >> 44) & 3;
    SELF.bldgmats_numrel_slope_6t12_Invalid := (le.ScrubsBits7 >> 46) & 3;
    SELF.bldgmats_numrel_var_0t12_Invalid := (le.ScrubsBits7 >> 48) & 3;
    SELF.bldgmats_numrel_var_12t24_Invalid := (le.ScrubsBits7 >> 50) & 3;
    SELF.total_percprov30_slope_0t12_Invalid := (le.ScrubsBits7 >> 52) & 3;
    SELF.total_percprov30_slope_0t24_Invalid := (le.ScrubsBits7 >> 54) & 3;
    SELF.total_percprov30_slope_0t6_Invalid := (le.ScrubsBits7 >> 56) & 3;
    SELF.total_percprov30_slope_6t12_Invalid := (le.ScrubsBits7 >> 58) & 3;
    SELF.total_percprov60_slope_0t12_Invalid := (le.ScrubsBits7 >> 60) & 3;
    SELF.total_percprov60_slope_0t24_Invalid := (le.ScrubsBits7 >> 62) & 3;
    SELF.total_percprov60_slope_0t6_Invalid := (le.ScrubsBits8 >> 0) & 3;
    SELF.total_percprov60_slope_6t12_Invalid := (le.ScrubsBits8 >> 2) & 3;
    SELF.total_percprov90_slope_0t24_Invalid := (le.ScrubsBits8 >> 4) & 3;
    SELF.total_percprov90_slope_0t6_Invalid := (le.ScrubsBits8 >> 6) & 3;
    SELF.total_percprov90_slope_6t12_Invalid := (le.ScrubsBits8 >> 8) & 3;
    SELF.mfgmat_percprov30_slope_0t12_Invalid := (le.ScrubsBits8 >> 10) & 3;
    SELF.mfgmat_percprov30_slope_6t12_Invalid := (le.ScrubsBits8 >> 12) & 3;
    SELF.mfgmat_percprov60_slope_0t12_Invalid := (le.ScrubsBits8 >> 14) & 3;
    SELF.mfgmat_percprov60_slope_6t12_Invalid := (le.ScrubsBits8 >> 16) & 3;
    SELF.mfgmat_percprov90_slope_0t24_Invalid := (le.ScrubsBits8 >> 18) & 3;
    SELF.mfgmat_percprov90_slope_0t6_Invalid := (le.ScrubsBits8 >> 20) & 3;
    SELF.mfgmat_percprov90_slope_6t12_Invalid := (le.ScrubsBits8 >> 22) & 3;
    SELF.ops_percprov30_slope_0t12_Invalid := (le.ScrubsBits8 >> 24) & 3;
    SELF.ops_percprov30_slope_6t12_Invalid := (le.ScrubsBits8 >> 26) & 3;
    SELF.ops_percprov60_slope_0t12_Invalid := (le.ScrubsBits8 >> 28) & 3;
    SELF.ops_percprov60_slope_6t12_Invalid := (le.ScrubsBits8 >> 30) & 3;
    SELF.ops_percprov90_slope_0t24_Invalid := (le.ScrubsBits8 >> 32) & 3;
    SELF.ops_percprov90_slope_0t6_Invalid := (le.ScrubsBits8 >> 34) & 3;
    SELF.ops_percprov90_slope_6t12_Invalid := (le.ScrubsBits8 >> 36) & 3;
    SELF.fleet_percprov30_slope_0t12_Invalid := (le.ScrubsBits8 >> 38) & 3;
    SELF.fleet_percprov30_slope_6t12_Invalid := (le.ScrubsBits8 >> 40) & 3;
    SELF.fleet_percprov60_slope_0t12_Invalid := (le.ScrubsBits8 >> 42) & 3;
    SELF.fleet_percprov60_slope_6t12_Invalid := (le.ScrubsBits8 >> 44) & 3;
    SELF.fleet_percprov90_slope_0t24_Invalid := (le.ScrubsBits8 >> 46) & 3;
    SELF.fleet_percprov90_slope_0t6_Invalid := (le.ScrubsBits8 >> 48) & 3;
    SELF.fleet_percprov90_slope_6t12_Invalid := (le.ScrubsBits8 >> 50) & 3;
    SELF.carrier_percprov30_slope_0t12_Invalid := (le.ScrubsBits8 >> 52) & 3;
    SELF.carrier_percprov30_slope_6t12_Invalid := (le.ScrubsBits8 >> 54) & 3;
    SELF.carrier_percprov60_slope_0t12_Invalid := (le.ScrubsBits8 >> 56) & 3;
    SELF.carrier_percprov60_slope_6t12_Invalid := (le.ScrubsBits8 >> 58) & 3;
    SELF.carrier_percprov90_slope_0t24_Invalid := (le.ScrubsBits8 >> 60) & 3;
    SELF.carrier_percprov90_slope_0t6_Invalid := (le.ScrubsBits8 >> 62) & 3;
    SELF.carrier_percprov90_slope_6t12_Invalid := (le.ScrubsBits9 >> 0) & 3;
    SELF.bldgmats_percprov30_slope_0t12_Invalid := (le.ScrubsBits9 >> 2) & 3;
    SELF.bldgmats_percprov30_slope_6t12_Invalid := (le.ScrubsBits9 >> 4) & 3;
    SELF.bldgmats_percprov60_slope_0t12_Invalid := (le.ScrubsBits9 >> 6) & 3;
    SELF.bldgmats_percprov60_slope_6t12_Invalid := (le.ScrubsBits9 >> 8) & 3;
    SELF.bldgmats_percprov90_slope_0t24_Invalid := (le.ScrubsBits9 >> 10) & 3;
    SELF.bldgmats_percprov90_slope_0t6_Invalid := (le.ScrubsBits9 >> 12) & 3;
    SELF.bldgmats_percprov90_slope_6t12_Invalid := (le.ScrubsBits9 >> 14) & 3;
    SELF.top5_percprov30_slope_0t12_Invalid := (le.ScrubsBits9 >> 16) & 3;
    SELF.top5_percprov30_slope_6t12_Invalid := (le.ScrubsBits9 >> 18) & 3;
    SELF.top5_percprov60_slope_0t12_Invalid := (le.ScrubsBits9 >> 20) & 3;
    SELF.top5_percprov60_slope_6t12_Invalid := (le.ScrubsBits9 >> 22) & 3;
    SELF.top5_percprov90_slope_0t24_Invalid := (le.ScrubsBits9 >> 24) & 3;
    SELF.top5_percprov90_slope_0t6_Invalid := (le.ScrubsBits9 >> 26) & 3;
    SELF.top5_percprov90_slope_6t12_Invalid := (le.ScrubsBits9 >> 28) & 3;
    SELF.top5_percprovoutstanding_adjustedslope_0t12_Invalid := (le.ScrubsBits9 >> 30) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    ultimate_linkid_ALLOW_ErrorCount := COUNT(GROUP,h.ultimate_linkid_Invalid=1);
    ultimate_linkid_LENGTH_ErrorCount := COUNT(GROUP,h.ultimate_linkid_Invalid=2);
    ultimate_linkid_Total_ErrorCount := COUNT(GROUP,h.ultimate_linkid_Invalid>0);
    cortera_score_ALLOW_ErrorCount := COUNT(GROUP,h.cortera_score_Invalid=1);
    cortera_score_LENGTH_ErrorCount := COUNT(GROUP,h.cortera_score_Invalid=2);
    cortera_score_Total_ErrorCount := COUNT(GROUP,h.cortera_score_Invalid>0);
    cpr_score_ALLOW_ErrorCount := COUNT(GROUP,h.cpr_score_Invalid=1);
    cpr_score_LENGTH_ErrorCount := COUNT(GROUP,h.cpr_score_Invalid=2);
    cpr_score_Total_ErrorCount := COUNT(GROUP,h.cpr_score_Invalid>0);
    cpr_segment_ALLOW_ErrorCount := COUNT(GROUP,h.cpr_segment_Invalid=1);
    cpr_segment_LENGTH_ErrorCount := COUNT(GROUP,h.cpr_segment_Invalid=2);
    cpr_segment_Total_ErrorCount := COUNT(GROUP,h.cpr_segment_Invalid>0);
    dbt_ALLOW_ErrorCount := COUNT(GROUP,h.dbt_Invalid=1);
    dbt_LENGTH_ErrorCount := COUNT(GROUP,h.dbt_Invalid=2);
    dbt_Total_ErrorCount := COUNT(GROUP,h.dbt_Invalid>0);
    avg_bal_ALLOW_ErrorCount := COUNT(GROUP,h.avg_bal_Invalid=1);
    avg_bal_LENGTH_ErrorCount := COUNT(GROUP,h.avg_bal_Invalid=2);
    avg_bal_Total_ErrorCount := COUNT(GROUP,h.avg_bal_Invalid>0);
    air_spend_ALLOW_ErrorCount := COUNT(GROUP,h.air_spend_Invalid=1);
    air_spend_LENGTH_ErrorCount := COUNT(GROUP,h.air_spend_Invalid=2);
    air_spend_Total_ErrorCount := COUNT(GROUP,h.air_spend_Invalid>0);
    fuel_spend_ALLOW_ErrorCount := COUNT(GROUP,h.fuel_spend_Invalid=1);
    fuel_spend_LENGTH_ErrorCount := COUNT(GROUP,h.fuel_spend_Invalid=2);
    fuel_spend_Total_ErrorCount := COUNT(GROUP,h.fuel_spend_Invalid>0);
    leasing_spend_ALLOW_ErrorCount := COUNT(GROUP,h.leasing_spend_Invalid=1);
    leasing_spend_LENGTH_ErrorCount := COUNT(GROUP,h.leasing_spend_Invalid=2);
    leasing_spend_Total_ErrorCount := COUNT(GROUP,h.leasing_spend_Invalid>0);
    ltl_spend_ALLOW_ErrorCount := COUNT(GROUP,h.ltl_spend_Invalid=1);
    ltl_spend_LENGTH_ErrorCount := COUNT(GROUP,h.ltl_spend_Invalid=2);
    ltl_spend_Total_ErrorCount := COUNT(GROUP,h.ltl_spend_Invalid>0);
    rail_spend_ALLOW_ErrorCount := COUNT(GROUP,h.rail_spend_Invalid=1);
    rail_spend_LENGTH_ErrorCount := COUNT(GROUP,h.rail_spend_Invalid=2);
    rail_spend_Total_ErrorCount := COUNT(GROUP,h.rail_spend_Invalid>0);
    tl_spend_ALLOW_ErrorCount := COUNT(GROUP,h.tl_spend_Invalid=1);
    tl_spend_LENGTH_ErrorCount := COUNT(GROUP,h.tl_spend_Invalid=2);
    tl_spend_Total_ErrorCount := COUNT(GROUP,h.tl_spend_Invalid>0);
    transvc_spend_ALLOW_ErrorCount := COUNT(GROUP,h.transvc_spend_Invalid=1);
    transvc_spend_LENGTH_ErrorCount := COUNT(GROUP,h.transvc_spend_Invalid=2);
    transvc_spend_Total_ErrorCount := COUNT(GROUP,h.transvc_spend_Invalid>0);
    transup_spend_ALLOW_ErrorCount := COUNT(GROUP,h.transup_spend_Invalid=1);
    transup_spend_LENGTH_ErrorCount := COUNT(GROUP,h.transup_spend_Invalid=2);
    transup_spend_Total_ErrorCount := COUNT(GROUP,h.transup_spend_Invalid>0);
    bst_spend_ALLOW_ErrorCount := COUNT(GROUP,h.bst_spend_Invalid=1);
    bst_spend_LENGTH_ErrorCount := COUNT(GROUP,h.bst_spend_Invalid=2);
    bst_spend_Total_ErrorCount := COUNT(GROUP,h.bst_spend_Invalid>0);
    dg_spend_ALLOW_ErrorCount := COUNT(GROUP,h.dg_spend_Invalid=1);
    dg_spend_LENGTH_ErrorCount := COUNT(GROUP,h.dg_spend_Invalid=2);
    dg_spend_Total_ErrorCount := COUNT(GROUP,h.dg_spend_Invalid>0);
    electrical_spend_ALLOW_ErrorCount := COUNT(GROUP,h.electrical_spend_Invalid=1);
    electrical_spend_LENGTH_ErrorCount := COUNT(GROUP,h.electrical_spend_Invalid=2);
    electrical_spend_Total_ErrorCount := COUNT(GROUP,h.electrical_spend_Invalid>0);
    hvac_spend_ALLOW_ErrorCount := COUNT(GROUP,h.hvac_spend_Invalid=1);
    hvac_spend_LENGTH_ErrorCount := COUNT(GROUP,h.hvac_spend_Invalid=2);
    hvac_spend_Total_ErrorCount := COUNT(GROUP,h.hvac_spend_Invalid>0);
    other_b_spend_ALLOW_ErrorCount := COUNT(GROUP,h.other_b_spend_Invalid=1);
    other_b_spend_LENGTH_ErrorCount := COUNT(GROUP,h.other_b_spend_Invalid=2);
    other_b_spend_Total_ErrorCount := COUNT(GROUP,h.other_b_spend_Invalid>0);
    plumbing_spend_ALLOW_ErrorCount := COUNT(GROUP,h.plumbing_spend_Invalid=1);
    plumbing_spend_LENGTH_ErrorCount := COUNT(GROUP,h.plumbing_spend_Invalid=2);
    plumbing_spend_Total_ErrorCount := COUNT(GROUP,h.plumbing_spend_Invalid>0);
    rs_spend_ALLOW_ErrorCount := COUNT(GROUP,h.rs_spend_Invalid=1);
    rs_spend_LENGTH_ErrorCount := COUNT(GROUP,h.rs_spend_Invalid=2);
    rs_spend_Total_ErrorCount := COUNT(GROUP,h.rs_spend_Invalid>0);
    wp_spend_ALLOW_ErrorCount := COUNT(GROUP,h.wp_spend_Invalid=1);
    wp_spend_LENGTH_ErrorCount := COUNT(GROUP,h.wp_spend_Invalid=2);
    wp_spend_Total_ErrorCount := COUNT(GROUP,h.wp_spend_Invalid>0);
    chemical_spend_ALLOW_ErrorCount := COUNT(GROUP,h.chemical_spend_Invalid=1);
    chemical_spend_LENGTH_ErrorCount := COUNT(GROUP,h.chemical_spend_Invalid=2);
    chemical_spend_Total_ErrorCount := COUNT(GROUP,h.chemical_spend_Invalid>0);
    electronic_spend_ALLOW_ErrorCount := COUNT(GROUP,h.electronic_spend_Invalid=1);
    electronic_spend_LENGTH_ErrorCount := COUNT(GROUP,h.electronic_spend_Invalid=2);
    electronic_spend_Total_ErrorCount := COUNT(GROUP,h.electronic_spend_Invalid>0);
    metal_spend_ALLOW_ErrorCount := COUNT(GROUP,h.metal_spend_Invalid=1);
    metal_spend_LENGTH_ErrorCount := COUNT(GROUP,h.metal_spend_Invalid=2);
    metal_spend_Total_ErrorCount := COUNT(GROUP,h.metal_spend_Invalid>0);
    other_m_spend_ALLOW_ErrorCount := COUNT(GROUP,h.other_m_spend_Invalid=1);
    other_m_spend_LENGTH_ErrorCount := COUNT(GROUP,h.other_m_spend_Invalid=2);
    other_m_spend_Total_ErrorCount := COUNT(GROUP,h.other_m_spend_Invalid>0);
    packaging_spend_ALLOW_ErrorCount := COUNT(GROUP,h.packaging_spend_Invalid=1);
    packaging_spend_LENGTH_ErrorCount := COUNT(GROUP,h.packaging_spend_Invalid=2);
    packaging_spend_Total_ErrorCount := COUNT(GROUP,h.packaging_spend_Invalid>0);
    pvf_spend_ALLOW_ErrorCount := COUNT(GROUP,h.pvf_spend_Invalid=1);
    pvf_spend_LENGTH_ErrorCount := COUNT(GROUP,h.pvf_spend_Invalid=2);
    pvf_spend_Total_ErrorCount := COUNT(GROUP,h.pvf_spend_Invalid>0);
    plastic_spend_ALLOW_ErrorCount := COUNT(GROUP,h.plastic_spend_Invalid=1);
    plastic_spend_LENGTH_ErrorCount := COUNT(GROUP,h.plastic_spend_Invalid=2);
    plastic_spend_Total_ErrorCount := COUNT(GROUP,h.plastic_spend_Invalid>0);
    textile_spend_ALLOW_ErrorCount := COUNT(GROUP,h.textile_spend_Invalid=1);
    textile_spend_LENGTH_ErrorCount := COUNT(GROUP,h.textile_spend_Invalid=2);
    textile_spend_Total_ErrorCount := COUNT(GROUP,h.textile_spend_Invalid>0);
    bs_spend_ALLOW_ErrorCount := COUNT(GROUP,h.bs_spend_Invalid=1);
    bs_spend_LENGTH_ErrorCount := COUNT(GROUP,h.bs_spend_Invalid=2);
    bs_spend_Total_ErrorCount := COUNT(GROUP,h.bs_spend_Invalid>0);
    ce_spend_ALLOW_ErrorCount := COUNT(GROUP,h.ce_spend_Invalid=1);
    ce_spend_LENGTH_ErrorCount := COUNT(GROUP,h.ce_spend_Invalid=2);
    ce_spend_Total_ErrorCount := COUNT(GROUP,h.ce_spend_Invalid>0);
    hardware_spend_ALLOW_ErrorCount := COUNT(GROUP,h.hardware_spend_Invalid=1);
    hardware_spend_LENGTH_ErrorCount := COUNT(GROUP,h.hardware_spend_Invalid=2);
    hardware_spend_Total_ErrorCount := COUNT(GROUP,h.hardware_spend_Invalid>0);
    ie_spend_ALLOW_ErrorCount := COUNT(GROUP,h.ie_spend_Invalid=1);
    ie_spend_LENGTH_ErrorCount := COUNT(GROUP,h.ie_spend_Invalid=2);
    ie_spend_Total_ErrorCount := COUNT(GROUP,h.ie_spend_Invalid>0);
    is_spend_ALLOW_ErrorCount := COUNT(GROUP,h.is_spend_Invalid=1);
    is_spend_LENGTH_ErrorCount := COUNT(GROUP,h.is_spend_Invalid=2);
    is_spend_Total_ErrorCount := COUNT(GROUP,h.is_spend_Invalid>0);
    it_spend_ALLOW_ErrorCount := COUNT(GROUP,h.it_spend_Invalid=1);
    it_spend_LENGTH_ErrorCount := COUNT(GROUP,h.it_spend_Invalid=2);
    it_spend_Total_ErrorCount := COUNT(GROUP,h.it_spend_Invalid>0);
    mls_spend_ALLOW_ErrorCount := COUNT(GROUP,h.mls_spend_Invalid=1);
    mls_spend_LENGTH_ErrorCount := COUNT(GROUP,h.mls_spend_Invalid=2);
    mls_spend_Total_ErrorCount := COUNT(GROUP,h.mls_spend_Invalid>0);
    os_spend_ALLOW_ErrorCount := COUNT(GROUP,h.os_spend_Invalid=1);
    os_spend_LENGTH_ErrorCount := COUNT(GROUP,h.os_spend_Invalid=2);
    os_spend_Total_ErrorCount := COUNT(GROUP,h.os_spend_Invalid>0);
    pp_spend_ALLOW_ErrorCount := COUNT(GROUP,h.pp_spend_Invalid=1);
    pp_spend_LENGTH_ErrorCount := COUNT(GROUP,h.pp_spend_Invalid=2);
    pp_spend_Total_ErrorCount := COUNT(GROUP,h.pp_spend_Invalid>0);
    sis_spend_ALLOW_ErrorCount := COUNT(GROUP,h.sis_spend_Invalid=1);
    sis_spend_LENGTH_ErrorCount := COUNT(GROUP,h.sis_spend_Invalid=2);
    sis_spend_Total_ErrorCount := COUNT(GROUP,h.sis_spend_Invalid>0);
    apparel_spend_ALLOW_ErrorCount := COUNT(GROUP,h.apparel_spend_Invalid=1);
    apparel_spend_LENGTH_ErrorCount := COUNT(GROUP,h.apparel_spend_Invalid=2);
    apparel_spend_Total_ErrorCount := COUNT(GROUP,h.apparel_spend_Invalid>0);
    beverages_spend_ALLOW_ErrorCount := COUNT(GROUP,h.beverages_spend_Invalid=1);
    beverages_spend_LENGTH_ErrorCount := COUNT(GROUP,h.beverages_spend_Invalid=2);
    beverages_spend_Total_ErrorCount := COUNT(GROUP,h.beverages_spend_Invalid>0);
    constr_spend_ALLOW_ErrorCount := COUNT(GROUP,h.constr_spend_Invalid=1);
    constr_spend_LENGTH_ErrorCount := COUNT(GROUP,h.constr_spend_Invalid=2);
    constr_spend_Total_ErrorCount := COUNT(GROUP,h.constr_spend_Invalid>0);
    consulting_spend_ALLOW_ErrorCount := COUNT(GROUP,h.consulting_spend_Invalid=1);
    consulting_spend_LENGTH_ErrorCount := COUNT(GROUP,h.consulting_spend_Invalid=2);
    consulting_spend_Total_ErrorCount := COUNT(GROUP,h.consulting_spend_Invalid>0);
    fs_spend_ALLOW_ErrorCount := COUNT(GROUP,h.fs_spend_Invalid=1);
    fs_spend_LENGTH_ErrorCount := COUNT(GROUP,h.fs_spend_Invalid=2);
    fs_spend_Total_ErrorCount := COUNT(GROUP,h.fs_spend_Invalid>0);
    fp_spend_ALLOW_ErrorCount := COUNT(GROUP,h.fp_spend_Invalid=1);
    fp_spend_LENGTH_ErrorCount := COUNT(GROUP,h.fp_spend_Invalid=2);
    fp_spend_Total_ErrorCount := COUNT(GROUP,h.fp_spend_Invalid>0);
    insurance_spend_ALLOW_ErrorCount := COUNT(GROUP,h.insurance_spend_Invalid=1);
    insurance_spend_LENGTH_ErrorCount := COUNT(GROUP,h.insurance_spend_Invalid=2);
    insurance_spend_Total_ErrorCount := COUNT(GROUP,h.insurance_spend_Invalid>0);
    ls_spend_ALLOW_ErrorCount := COUNT(GROUP,h.ls_spend_Invalid=1);
    ls_spend_LENGTH_ErrorCount := COUNT(GROUP,h.ls_spend_Invalid=2);
    ls_spend_Total_ErrorCount := COUNT(GROUP,h.ls_spend_Invalid>0);
    oil_gas_spend_ALLOW_ErrorCount := COUNT(GROUP,h.oil_gas_spend_Invalid=1);
    oil_gas_spend_LENGTH_ErrorCount := COUNT(GROUP,h.oil_gas_spend_Invalid=2);
    oil_gas_spend_Total_ErrorCount := COUNT(GROUP,h.oil_gas_spend_Invalid>0);
    utilities_spend_ALLOW_ErrorCount := COUNT(GROUP,h.utilities_spend_Invalid=1);
    utilities_spend_LENGTH_ErrorCount := COUNT(GROUP,h.utilities_spend_Invalid=2);
    utilities_spend_Total_ErrorCount := COUNT(GROUP,h.utilities_spend_Invalid>0);
    other_spend_ALLOW_ErrorCount := COUNT(GROUP,h.other_spend_Invalid=1);
    other_spend_LENGTH_ErrorCount := COUNT(GROUP,h.other_spend_Invalid=2);
    other_spend_Total_ErrorCount := COUNT(GROUP,h.other_spend_Invalid>0);
    advt_spend_ALLOW_ErrorCount := COUNT(GROUP,h.advt_spend_Invalid=1);
    advt_spend_LENGTH_ErrorCount := COUNT(GROUP,h.advt_spend_Invalid=2);
    advt_spend_Total_ErrorCount := COUNT(GROUP,h.advt_spend_Invalid>0);
    air_growth_ALLOW_ErrorCount := COUNT(GROUP,h.air_growth_Invalid=1);
    air_growth_LENGTH_ErrorCount := COUNT(GROUP,h.air_growth_Invalid=2);
    air_growth_Total_ErrorCount := COUNT(GROUP,h.air_growth_Invalid>0);
    fuel_growth_ALLOW_ErrorCount := COUNT(GROUP,h.fuel_growth_Invalid=1);
    fuel_growth_LENGTH_ErrorCount := COUNT(GROUP,h.fuel_growth_Invalid=2);
    fuel_growth_Total_ErrorCount := COUNT(GROUP,h.fuel_growth_Invalid>0);
    leasing_growth_ALLOW_ErrorCount := COUNT(GROUP,h.leasing_growth_Invalid=1);
    leasing_growth_LENGTH_ErrorCount := COUNT(GROUP,h.leasing_growth_Invalid=2);
    leasing_growth_Total_ErrorCount := COUNT(GROUP,h.leasing_growth_Invalid>0);
    ltl_growth_ALLOW_ErrorCount := COUNT(GROUP,h.ltl_growth_Invalid=1);
    ltl_growth_LENGTH_ErrorCount := COUNT(GROUP,h.ltl_growth_Invalid=2);
    ltl_growth_Total_ErrorCount := COUNT(GROUP,h.ltl_growth_Invalid>0);
    rail_growth_ALLOW_ErrorCount := COUNT(GROUP,h.rail_growth_Invalid=1);
    rail_growth_LENGTH_ErrorCount := COUNT(GROUP,h.rail_growth_Invalid=2);
    rail_growth_Total_ErrorCount := COUNT(GROUP,h.rail_growth_Invalid>0);
    tl_growth_ALLOW_ErrorCount := COUNT(GROUP,h.tl_growth_Invalid=1);
    tl_growth_LENGTH_ErrorCount := COUNT(GROUP,h.tl_growth_Invalid=2);
    tl_growth_Total_ErrorCount := COUNT(GROUP,h.tl_growth_Invalid>0);
    transvc_growth_ALLOW_ErrorCount := COUNT(GROUP,h.transvc_growth_Invalid=1);
    transvc_growth_LENGTH_ErrorCount := COUNT(GROUP,h.transvc_growth_Invalid=2);
    transvc_growth_Total_ErrorCount := COUNT(GROUP,h.transvc_growth_Invalid>0);
    transup_growth_ALLOW_ErrorCount := COUNT(GROUP,h.transup_growth_Invalid=1);
    transup_growth_LENGTH_ErrorCount := COUNT(GROUP,h.transup_growth_Invalid=2);
    transup_growth_Total_ErrorCount := COUNT(GROUP,h.transup_growth_Invalid>0);
    bst_growth_ALLOW_ErrorCount := COUNT(GROUP,h.bst_growth_Invalid=1);
    bst_growth_LENGTH_ErrorCount := COUNT(GROUP,h.bst_growth_Invalid=2);
    bst_growth_Total_ErrorCount := COUNT(GROUP,h.bst_growth_Invalid>0);
    dg_growth_ALLOW_ErrorCount := COUNT(GROUP,h.dg_growth_Invalid=1);
    dg_growth_LENGTH_ErrorCount := COUNT(GROUP,h.dg_growth_Invalid=2);
    dg_growth_Total_ErrorCount := COUNT(GROUP,h.dg_growth_Invalid>0);
    electrical_growth_ALLOW_ErrorCount := COUNT(GROUP,h.electrical_growth_Invalid=1);
    electrical_growth_LENGTH_ErrorCount := COUNT(GROUP,h.electrical_growth_Invalid=2);
    electrical_growth_Total_ErrorCount := COUNT(GROUP,h.electrical_growth_Invalid>0);
    hvac_growth_ALLOW_ErrorCount := COUNT(GROUP,h.hvac_growth_Invalid=1);
    hvac_growth_LENGTH_ErrorCount := COUNT(GROUP,h.hvac_growth_Invalid=2);
    hvac_growth_Total_ErrorCount := COUNT(GROUP,h.hvac_growth_Invalid>0);
    other_b_growth_ALLOW_ErrorCount := COUNT(GROUP,h.other_b_growth_Invalid=1);
    other_b_growth_LENGTH_ErrorCount := COUNT(GROUP,h.other_b_growth_Invalid=2);
    other_b_growth_Total_ErrorCount := COUNT(GROUP,h.other_b_growth_Invalid>0);
    plumbing_growth_ALLOW_ErrorCount := COUNT(GROUP,h.plumbing_growth_Invalid=1);
    plumbing_growth_LENGTH_ErrorCount := COUNT(GROUP,h.plumbing_growth_Invalid=2);
    plumbing_growth_Total_ErrorCount := COUNT(GROUP,h.plumbing_growth_Invalid>0);
    rs_growth_ALLOW_ErrorCount := COUNT(GROUP,h.rs_growth_Invalid=1);
    rs_growth_LENGTH_ErrorCount := COUNT(GROUP,h.rs_growth_Invalid=2);
    rs_growth_Total_ErrorCount := COUNT(GROUP,h.rs_growth_Invalid>0);
    wp_growth_ALLOW_ErrorCount := COUNT(GROUP,h.wp_growth_Invalid=1);
    wp_growth_LENGTH_ErrorCount := COUNT(GROUP,h.wp_growth_Invalid=2);
    wp_growth_Total_ErrorCount := COUNT(GROUP,h.wp_growth_Invalid>0);
    chemical_growth_ALLOW_ErrorCount := COUNT(GROUP,h.chemical_growth_Invalid=1);
    chemical_growth_LENGTH_ErrorCount := COUNT(GROUP,h.chemical_growth_Invalid=2);
    chemical_growth_Total_ErrorCount := COUNT(GROUP,h.chemical_growth_Invalid>0);
    electronic_growth_ALLOW_ErrorCount := COUNT(GROUP,h.electronic_growth_Invalid=1);
    electronic_growth_LENGTH_ErrorCount := COUNT(GROUP,h.electronic_growth_Invalid=2);
    electronic_growth_Total_ErrorCount := COUNT(GROUP,h.electronic_growth_Invalid>0);
    metal_growth_ALLOW_ErrorCount := COUNT(GROUP,h.metal_growth_Invalid=1);
    metal_growth_LENGTH_ErrorCount := COUNT(GROUP,h.metal_growth_Invalid=2);
    metal_growth_Total_ErrorCount := COUNT(GROUP,h.metal_growth_Invalid>0);
    other_m_growth_ALLOW_ErrorCount := COUNT(GROUP,h.other_m_growth_Invalid=1);
    other_m_growth_LENGTH_ErrorCount := COUNT(GROUP,h.other_m_growth_Invalid=2);
    other_m_growth_Total_ErrorCount := COUNT(GROUP,h.other_m_growth_Invalid>0);
    packaging_growth_ALLOW_ErrorCount := COUNT(GROUP,h.packaging_growth_Invalid=1);
    packaging_growth_LENGTH_ErrorCount := COUNT(GROUP,h.packaging_growth_Invalid=2);
    packaging_growth_Total_ErrorCount := COUNT(GROUP,h.packaging_growth_Invalid>0);
    pvf_growth_ALLOW_ErrorCount := COUNT(GROUP,h.pvf_growth_Invalid=1);
    pvf_growth_LENGTH_ErrorCount := COUNT(GROUP,h.pvf_growth_Invalid=2);
    pvf_growth_Total_ErrorCount := COUNT(GROUP,h.pvf_growth_Invalid>0);
    plastic_growth_ALLOW_ErrorCount := COUNT(GROUP,h.plastic_growth_Invalid=1);
    plastic_growth_LENGTH_ErrorCount := COUNT(GROUP,h.plastic_growth_Invalid=2);
    plastic_growth_Total_ErrorCount := COUNT(GROUP,h.plastic_growth_Invalid>0);
    textile_growth_ALLOW_ErrorCount := COUNT(GROUP,h.textile_growth_Invalid=1);
    textile_growth_LENGTH_ErrorCount := COUNT(GROUP,h.textile_growth_Invalid=2);
    textile_growth_Total_ErrorCount := COUNT(GROUP,h.textile_growth_Invalid>0);
    bs_growth_ALLOW_ErrorCount := COUNT(GROUP,h.bs_growth_Invalid=1);
    bs_growth_LENGTH_ErrorCount := COUNT(GROUP,h.bs_growth_Invalid=2);
    bs_growth_Total_ErrorCount := COUNT(GROUP,h.bs_growth_Invalid>0);
    ce_growth_ALLOW_ErrorCount := COUNT(GROUP,h.ce_growth_Invalid=1);
    ce_growth_LENGTH_ErrorCount := COUNT(GROUP,h.ce_growth_Invalid=2);
    ce_growth_Total_ErrorCount := COUNT(GROUP,h.ce_growth_Invalid>0);
    hardware_growth_ALLOW_ErrorCount := COUNT(GROUP,h.hardware_growth_Invalid=1);
    hardware_growth_LENGTH_ErrorCount := COUNT(GROUP,h.hardware_growth_Invalid=2);
    hardware_growth_Total_ErrorCount := COUNT(GROUP,h.hardware_growth_Invalid>0);
    ie_growth_ALLOW_ErrorCount := COUNT(GROUP,h.ie_growth_Invalid=1);
    ie_growth_LENGTH_ErrorCount := COUNT(GROUP,h.ie_growth_Invalid=2);
    ie_growth_Total_ErrorCount := COUNT(GROUP,h.ie_growth_Invalid>0);
    is_growth_ALLOW_ErrorCount := COUNT(GROUP,h.is_growth_Invalid=1);
    is_growth_LENGTH_ErrorCount := COUNT(GROUP,h.is_growth_Invalid=2);
    is_growth_Total_ErrorCount := COUNT(GROUP,h.is_growth_Invalid>0);
    it_growth_ALLOW_ErrorCount := COUNT(GROUP,h.it_growth_Invalid=1);
    it_growth_LENGTH_ErrorCount := COUNT(GROUP,h.it_growth_Invalid=2);
    it_growth_Total_ErrorCount := COUNT(GROUP,h.it_growth_Invalid>0);
    mls_growth_ALLOW_ErrorCount := COUNT(GROUP,h.mls_growth_Invalid=1);
    mls_growth_LENGTH_ErrorCount := COUNT(GROUP,h.mls_growth_Invalid=2);
    mls_growth_Total_ErrorCount := COUNT(GROUP,h.mls_growth_Invalid>0);
    os_growth_ALLOW_ErrorCount := COUNT(GROUP,h.os_growth_Invalid=1);
    os_growth_LENGTH_ErrorCount := COUNT(GROUP,h.os_growth_Invalid=2);
    os_growth_Total_ErrorCount := COUNT(GROUP,h.os_growth_Invalid>0);
    pp_growth_ALLOW_ErrorCount := COUNT(GROUP,h.pp_growth_Invalid=1);
    pp_growth_LENGTH_ErrorCount := COUNT(GROUP,h.pp_growth_Invalid=2);
    pp_growth_Total_ErrorCount := COUNT(GROUP,h.pp_growth_Invalid>0);
    sis_growth_ALLOW_ErrorCount := COUNT(GROUP,h.sis_growth_Invalid=1);
    sis_growth_LENGTH_ErrorCount := COUNT(GROUP,h.sis_growth_Invalid=2);
    sis_growth_Total_ErrorCount := COUNT(GROUP,h.sis_growth_Invalid>0);
    apparel_growth_ALLOW_ErrorCount := COUNT(GROUP,h.apparel_growth_Invalid=1);
    apparel_growth_LENGTH_ErrorCount := COUNT(GROUP,h.apparel_growth_Invalid=2);
    apparel_growth_Total_ErrorCount := COUNT(GROUP,h.apparel_growth_Invalid>0);
    beverages_growth_ALLOW_ErrorCount := COUNT(GROUP,h.beverages_growth_Invalid=1);
    beverages_growth_LENGTH_ErrorCount := COUNT(GROUP,h.beverages_growth_Invalid=2);
    beverages_growth_Total_ErrorCount := COUNT(GROUP,h.beverages_growth_Invalid>0);
    constr_growth_ALLOW_ErrorCount := COUNT(GROUP,h.constr_growth_Invalid=1);
    constr_growth_LENGTH_ErrorCount := COUNT(GROUP,h.constr_growth_Invalid=2);
    constr_growth_Total_ErrorCount := COUNT(GROUP,h.constr_growth_Invalid>0);
    consulting_growth_ALLOW_ErrorCount := COUNT(GROUP,h.consulting_growth_Invalid=1);
    consulting_growth_LENGTH_ErrorCount := COUNT(GROUP,h.consulting_growth_Invalid=2);
    consulting_growth_Total_ErrorCount := COUNT(GROUP,h.consulting_growth_Invalid>0);
    fs_growth_ALLOW_ErrorCount := COUNT(GROUP,h.fs_growth_Invalid=1);
    fs_growth_LENGTH_ErrorCount := COUNT(GROUP,h.fs_growth_Invalid=2);
    fs_growth_Total_ErrorCount := COUNT(GROUP,h.fs_growth_Invalid>0);
    fp_growth_ALLOW_ErrorCount := COUNT(GROUP,h.fp_growth_Invalid=1);
    fp_growth_LENGTH_ErrorCount := COUNT(GROUP,h.fp_growth_Invalid=2);
    fp_growth_Total_ErrorCount := COUNT(GROUP,h.fp_growth_Invalid>0);
    insurance_growth_ALLOW_ErrorCount := COUNT(GROUP,h.insurance_growth_Invalid=1);
    insurance_growth_LENGTH_ErrorCount := COUNT(GROUP,h.insurance_growth_Invalid=2);
    insurance_growth_Total_ErrorCount := COUNT(GROUP,h.insurance_growth_Invalid>0);
    ls_growth_ALLOW_ErrorCount := COUNT(GROUP,h.ls_growth_Invalid=1);
    ls_growth_LENGTH_ErrorCount := COUNT(GROUP,h.ls_growth_Invalid=2);
    ls_growth_Total_ErrorCount := COUNT(GROUP,h.ls_growth_Invalid>0);
    oil_gas_growth_ALLOW_ErrorCount := COUNT(GROUP,h.oil_gas_growth_Invalid=1);
    oil_gas_growth_LENGTH_ErrorCount := COUNT(GROUP,h.oil_gas_growth_Invalid=2);
    oil_gas_growth_Total_ErrorCount := COUNT(GROUP,h.oil_gas_growth_Invalid>0);
    utilities_growth_ALLOW_ErrorCount := COUNT(GROUP,h.utilities_growth_Invalid=1);
    utilities_growth_LENGTH_ErrorCount := COUNT(GROUP,h.utilities_growth_Invalid=2);
    utilities_growth_Total_ErrorCount := COUNT(GROUP,h.utilities_growth_Invalid>0);
    other_growth_ALLOW_ErrorCount := COUNT(GROUP,h.other_growth_Invalid=1);
    other_growth_LENGTH_ErrorCount := COUNT(GROUP,h.other_growth_Invalid=2);
    other_growth_Total_ErrorCount := COUNT(GROUP,h.other_growth_Invalid>0);
    advt_growth_ALLOW_ErrorCount := COUNT(GROUP,h.advt_growth_Invalid=1);
    advt_growth_LENGTH_ErrorCount := COUNT(GROUP,h.advt_growth_Invalid=2);
    advt_growth_Total_ErrorCount := COUNT(GROUP,h.advt_growth_Invalid>0);
    top5_growth_ALLOW_ErrorCount := COUNT(GROUP,h.top5_growth_Invalid=1);
    top5_growth_LENGTH_ErrorCount := COUNT(GROUP,h.top5_growth_Invalid=2);
    top5_growth_Total_ErrorCount := COUNT(GROUP,h.top5_growth_Invalid>0);
    shipping_y1_ALLOW_ErrorCount := COUNT(GROUP,h.shipping_y1_Invalid=1);
    shipping_y1_LENGTH_ErrorCount := COUNT(GROUP,h.shipping_y1_Invalid=2);
    shipping_y1_Total_ErrorCount := COUNT(GROUP,h.shipping_y1_Invalid>0);
    shipping_growth_ALLOW_ErrorCount := COUNT(GROUP,h.shipping_growth_Invalid=1);
    shipping_growth_LENGTH_ErrorCount := COUNT(GROUP,h.shipping_growth_Invalid=2);
    shipping_growth_Total_ErrorCount := COUNT(GROUP,h.shipping_growth_Invalid>0);
    materials_y1_ALLOW_ErrorCount := COUNT(GROUP,h.materials_y1_Invalid=1);
    materials_y1_LENGTH_ErrorCount := COUNT(GROUP,h.materials_y1_Invalid=2);
    materials_y1_Total_ErrorCount := COUNT(GROUP,h.materials_y1_Invalid>0);
    materials_growth_ALLOW_ErrorCount := COUNT(GROUP,h.materials_growth_Invalid=1);
    materials_growth_LENGTH_ErrorCount := COUNT(GROUP,h.materials_growth_Invalid=2);
    materials_growth_Total_ErrorCount := COUNT(GROUP,h.materials_growth_Invalid>0);
    operations_y1_ALLOW_ErrorCount := COUNT(GROUP,h.operations_y1_Invalid=1);
    operations_y1_LENGTH_ErrorCount := COUNT(GROUP,h.operations_y1_Invalid=2);
    operations_y1_Total_ErrorCount := COUNT(GROUP,h.operations_y1_Invalid>0);
    operations_growth_ALLOW_ErrorCount := COUNT(GROUP,h.operations_growth_Invalid=1);
    operations_growth_LENGTH_ErrorCount := COUNT(GROUP,h.operations_growth_Invalid=2);
    operations_growth_Total_ErrorCount := COUNT(GROUP,h.operations_growth_Invalid>0);
    total_paid_average_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_paid_average_0t12_Invalid=1);
    total_paid_average_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.total_paid_average_0t12_Invalid=2);
    total_paid_average_0t12_Total_ErrorCount := COUNT(GROUP,h.total_paid_average_0t12_Invalid>0);
    total_paid_monthspastworst_24_ALLOW_ErrorCount := COUNT(GROUP,h.total_paid_monthspastworst_24_Invalid=1);
    total_paid_monthspastworst_24_LENGTH_ErrorCount := COUNT(GROUP,h.total_paid_monthspastworst_24_Invalid=2);
    total_paid_monthspastworst_24_Total_ErrorCount := COUNT(GROUP,h.total_paid_monthspastworst_24_Invalid>0);
    total_paid_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_paid_slope_0t12_Invalid=1);
    total_paid_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.total_paid_slope_0t12_Invalid=2);
    total_paid_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.total_paid_slope_0t12_Invalid>0);
    total_paid_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.total_paid_slope_0t6_Invalid=1);
    total_paid_slope_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.total_paid_slope_0t6_Invalid=2);
    total_paid_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.total_paid_slope_0t6_Invalid>0);
    total_paid_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_paid_slope_6t12_Invalid=1);
    total_paid_slope_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.total_paid_slope_6t12_Invalid=2);
    total_paid_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.total_paid_slope_6t12_Invalid>0);
    total_paid_slope_6t18_ALLOW_ErrorCount := COUNT(GROUP,h.total_paid_slope_6t18_Invalid=1);
    total_paid_slope_6t18_LENGTH_ErrorCount := COUNT(GROUP,h.total_paid_slope_6t18_Invalid=2);
    total_paid_slope_6t18_Total_ErrorCount := COUNT(GROUP,h.total_paid_slope_6t18_Invalid>0);
    total_paid_volatility_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_paid_volatility_0t12_Invalid=1);
    total_paid_volatility_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.total_paid_volatility_0t12_Invalid=2);
    total_paid_volatility_0t12_Total_ErrorCount := COUNT(GROUP,h.total_paid_volatility_0t12_Invalid>0);
    total_paid_volatility_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.total_paid_volatility_0t6_Invalid=1);
    total_paid_volatility_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.total_paid_volatility_0t6_Invalid=2);
    total_paid_volatility_0t6_Total_ErrorCount := COUNT(GROUP,h.total_paid_volatility_0t6_Invalid>0);
    total_paid_volatility_12t18_ALLOW_ErrorCount := COUNT(GROUP,h.total_paid_volatility_12t18_Invalid=1);
    total_paid_volatility_12t18_LENGTH_ErrorCount := COUNT(GROUP,h.total_paid_volatility_12t18_Invalid=2);
    total_paid_volatility_12t18_Total_ErrorCount := COUNT(GROUP,h.total_paid_volatility_12t18_Invalid>0);
    total_paid_volatility_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_paid_volatility_6t12_Invalid=1);
    total_paid_volatility_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.total_paid_volatility_6t12_Invalid=2);
    total_paid_volatility_6t12_Total_ErrorCount := COUNT(GROUP,h.total_paid_volatility_6t12_Invalid>0);
    total_spend_monthspastleast_24_ALLOW_ErrorCount := COUNT(GROUP,h.total_spend_monthspastleast_24_Invalid=1);
    total_spend_monthspastleast_24_LENGTH_ErrorCount := COUNT(GROUP,h.total_spend_monthspastleast_24_Invalid=2);
    total_spend_monthspastleast_24_Total_ErrorCount := COUNT(GROUP,h.total_spend_monthspastleast_24_Invalid>0);
    total_spend_monthspastmost_24_ALLOW_ErrorCount := COUNT(GROUP,h.total_spend_monthspastmost_24_Invalid=1);
    total_spend_monthspastmost_24_LENGTH_ErrorCount := COUNT(GROUP,h.total_spend_monthspastmost_24_Invalid=2);
    total_spend_monthspastmost_24_Total_ErrorCount := COUNT(GROUP,h.total_spend_monthspastmost_24_Invalid>0);
    total_spend_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_spend_slope_0t12_Invalid=1);
    total_spend_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.total_spend_slope_0t12_Invalid=2);
    total_spend_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.total_spend_slope_0t12_Invalid>0);
    total_spend_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.total_spend_slope_0t24_Invalid=1);
    total_spend_slope_0t24_LENGTH_ErrorCount := COUNT(GROUP,h.total_spend_slope_0t24_Invalid=2);
    total_spend_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.total_spend_slope_0t24_Invalid>0);
    total_spend_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.total_spend_slope_0t6_Invalid=1);
    total_spend_slope_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.total_spend_slope_0t6_Invalid=2);
    total_spend_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.total_spend_slope_0t6_Invalid>0);
    total_spend_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_spend_slope_6t12_Invalid=1);
    total_spend_slope_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.total_spend_slope_6t12_Invalid=2);
    total_spend_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.total_spend_slope_6t12_Invalid>0);
    total_spend_sum_12_ALLOW_ErrorCount := COUNT(GROUP,h.total_spend_sum_12_Invalid=1);
    total_spend_sum_12_LENGTH_ErrorCount := COUNT(GROUP,h.total_spend_sum_12_Invalid=2);
    total_spend_sum_12_Total_ErrorCount := COUNT(GROUP,h.total_spend_sum_12_Invalid>0);
    total_spend_volatility_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_spend_volatility_0t12_Invalid=1);
    total_spend_volatility_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.total_spend_volatility_0t12_Invalid=2);
    total_spend_volatility_0t12_Total_ErrorCount := COUNT(GROUP,h.total_spend_volatility_0t12_Invalid>0);
    total_spend_volatility_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.total_spend_volatility_0t6_Invalid=1);
    total_spend_volatility_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.total_spend_volatility_0t6_Invalid=2);
    total_spend_volatility_0t6_Total_ErrorCount := COUNT(GROUP,h.total_spend_volatility_0t6_Invalid>0);
    total_spend_volatility_12t18_ALLOW_ErrorCount := COUNT(GROUP,h.total_spend_volatility_12t18_Invalid=1);
    total_spend_volatility_12t18_LENGTH_ErrorCount := COUNT(GROUP,h.total_spend_volatility_12t18_Invalid=2);
    total_spend_volatility_12t18_Total_ErrorCount := COUNT(GROUP,h.total_spend_volatility_12t18_Invalid>0);
    total_spend_volatility_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_spend_volatility_6t12_Invalid=1);
    total_spend_volatility_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.total_spend_volatility_6t12_Invalid=2);
    total_spend_volatility_6t12_Total_ErrorCount := COUNT(GROUP,h.total_spend_volatility_6t12_Invalid>0);
    mfgmat_paid_average_12_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_paid_average_12_Invalid=1);
    mfgmat_paid_average_12_LENGTH_ErrorCount := COUNT(GROUP,h.mfgmat_paid_average_12_Invalid=2);
    mfgmat_paid_average_12_Total_ErrorCount := COUNT(GROUP,h.mfgmat_paid_average_12_Invalid>0);
    mfgmat_paid_monthspastworst_24_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_paid_monthspastworst_24_Invalid=1);
    mfgmat_paid_monthspastworst_24_LENGTH_ErrorCount := COUNT(GROUP,h.mfgmat_paid_monthspastworst_24_Invalid=2);
    mfgmat_paid_monthspastworst_24_Total_ErrorCount := COUNT(GROUP,h.mfgmat_paid_monthspastworst_24_Invalid>0);
    mfgmat_paid_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_paid_slope_0t12_Invalid=1);
    mfgmat_paid_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.mfgmat_paid_slope_0t12_Invalid=2);
    mfgmat_paid_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.mfgmat_paid_slope_0t12_Invalid>0);
    mfgmat_paid_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_paid_slope_0t24_Invalid=1);
    mfgmat_paid_slope_0t24_LENGTH_ErrorCount := COUNT(GROUP,h.mfgmat_paid_slope_0t24_Invalid=2);
    mfgmat_paid_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.mfgmat_paid_slope_0t24_Invalid>0);
    mfgmat_paid_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_paid_slope_0t6_Invalid=1);
    mfgmat_paid_slope_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.mfgmat_paid_slope_0t6_Invalid=2);
    mfgmat_paid_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.mfgmat_paid_slope_0t6_Invalid>0);
    mfgmat_paid_volatility_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_paid_volatility_0t12_Invalid=1);
    mfgmat_paid_volatility_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.mfgmat_paid_volatility_0t12_Invalid=2);
    mfgmat_paid_volatility_0t12_Total_ErrorCount := COUNT(GROUP,h.mfgmat_paid_volatility_0t12_Invalid>0);
    mfgmat_paid_volatility_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_paid_volatility_0t6_Invalid=1);
    mfgmat_paid_volatility_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.mfgmat_paid_volatility_0t6_Invalid=2);
    mfgmat_paid_volatility_0t6_Total_ErrorCount := COUNT(GROUP,h.mfgmat_paid_volatility_0t6_Invalid>0);
    mfgmat_spend_monthspastleast_24_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_spend_monthspastleast_24_Invalid=1);
    mfgmat_spend_monthspastleast_24_LENGTH_ErrorCount := COUNT(GROUP,h.mfgmat_spend_monthspastleast_24_Invalid=2);
    mfgmat_spend_monthspastleast_24_Total_ErrorCount := COUNT(GROUP,h.mfgmat_spend_monthspastleast_24_Invalid>0);
    mfgmat_spend_monthspastmost_24_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_spend_monthspastmost_24_Invalid=1);
    mfgmat_spend_monthspastmost_24_LENGTH_ErrorCount := COUNT(GROUP,h.mfgmat_spend_monthspastmost_24_Invalid=2);
    mfgmat_spend_monthspastmost_24_Total_ErrorCount := COUNT(GROUP,h.mfgmat_spend_monthspastmost_24_Invalid>0);
    mfgmat_spend_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_spend_slope_0t12_Invalid=1);
    mfgmat_spend_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.mfgmat_spend_slope_0t12_Invalid=2);
    mfgmat_spend_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.mfgmat_spend_slope_0t12_Invalid>0);
    mfgmat_spend_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_spend_slope_0t24_Invalid=1);
    mfgmat_spend_slope_0t24_LENGTH_ErrorCount := COUNT(GROUP,h.mfgmat_spend_slope_0t24_Invalid=2);
    mfgmat_spend_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.mfgmat_spend_slope_0t24_Invalid>0);
    mfgmat_spend_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_spend_slope_0t6_Invalid=1);
    mfgmat_spend_slope_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.mfgmat_spend_slope_0t6_Invalid=2);
    mfgmat_spend_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.mfgmat_spend_slope_0t6_Invalid>0);
    mfgmat_spend_sum_12_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_spend_sum_12_Invalid=1);
    mfgmat_spend_sum_12_LENGTH_ErrorCount := COUNT(GROUP,h.mfgmat_spend_sum_12_Invalid=2);
    mfgmat_spend_sum_12_Total_ErrorCount := COUNT(GROUP,h.mfgmat_spend_sum_12_Invalid>0);
    mfgmat_spend_volatility_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_spend_volatility_0t6_Invalid=1);
    mfgmat_spend_volatility_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.mfgmat_spend_volatility_0t6_Invalid=2);
    mfgmat_spend_volatility_0t6_Total_ErrorCount := COUNT(GROUP,h.mfgmat_spend_volatility_0t6_Invalid>0);
    mfgmat_spend_volatility_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_spend_volatility_6t12_Invalid=1);
    mfgmat_spend_volatility_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.mfgmat_spend_volatility_6t12_Invalid=2);
    mfgmat_spend_volatility_6t12_Total_ErrorCount := COUNT(GROUP,h.mfgmat_spend_volatility_6t12_Invalid>0);
    ops_paid_average_12_ALLOW_ErrorCount := COUNT(GROUP,h.ops_paid_average_12_Invalid=1);
    ops_paid_average_12_LENGTH_ErrorCount := COUNT(GROUP,h.ops_paid_average_12_Invalid=2);
    ops_paid_average_12_Total_ErrorCount := COUNT(GROUP,h.ops_paid_average_12_Invalid>0);
    ops_paid_monthspastworst_24_ALLOW_ErrorCount := COUNT(GROUP,h.ops_paid_monthspastworst_24_Invalid=1);
    ops_paid_monthspastworst_24_LENGTH_ErrorCount := COUNT(GROUP,h.ops_paid_monthspastworst_24_Invalid=2);
    ops_paid_monthspastworst_24_Total_ErrorCount := COUNT(GROUP,h.ops_paid_monthspastworst_24_Invalid>0);
    ops_paid_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.ops_paid_slope_0t12_Invalid=1);
    ops_paid_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.ops_paid_slope_0t12_Invalid=2);
    ops_paid_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.ops_paid_slope_0t12_Invalid>0);
    ops_paid_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.ops_paid_slope_0t24_Invalid=1);
    ops_paid_slope_0t24_LENGTH_ErrorCount := COUNT(GROUP,h.ops_paid_slope_0t24_Invalid=2);
    ops_paid_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.ops_paid_slope_0t24_Invalid>0);
    ops_paid_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.ops_paid_slope_0t6_Invalid=1);
    ops_paid_slope_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.ops_paid_slope_0t6_Invalid=2);
    ops_paid_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.ops_paid_slope_0t6_Invalid>0);
    ops_paid_volatility_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.ops_paid_volatility_0t12_Invalid=1);
    ops_paid_volatility_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.ops_paid_volatility_0t12_Invalid=2);
    ops_paid_volatility_0t12_Total_ErrorCount := COUNT(GROUP,h.ops_paid_volatility_0t12_Invalid>0);
    ops_paid_volatility_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.ops_paid_volatility_0t6_Invalid=1);
    ops_paid_volatility_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.ops_paid_volatility_0t6_Invalid=2);
    ops_paid_volatility_0t6_Total_ErrorCount := COUNT(GROUP,h.ops_paid_volatility_0t6_Invalid>0);
    ops_spend_monthspastleast_24_ALLOW_ErrorCount := COUNT(GROUP,h.ops_spend_monthspastleast_24_Invalid=1);
    ops_spend_monthspastleast_24_LENGTH_ErrorCount := COUNT(GROUP,h.ops_spend_monthspastleast_24_Invalid=2);
    ops_spend_monthspastleast_24_Total_ErrorCount := COUNT(GROUP,h.ops_spend_monthspastleast_24_Invalid>0);
    ops_spend_monthspastmost_24_ALLOW_ErrorCount := COUNT(GROUP,h.ops_spend_monthspastmost_24_Invalid=1);
    ops_spend_monthspastmost_24_LENGTH_ErrorCount := COUNT(GROUP,h.ops_spend_monthspastmost_24_Invalid=2);
    ops_spend_monthspastmost_24_Total_ErrorCount := COUNT(GROUP,h.ops_spend_monthspastmost_24_Invalid>0);
    ops_spend_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.ops_spend_slope_0t12_Invalid=1);
    ops_spend_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.ops_spend_slope_0t12_Invalid=2);
    ops_spend_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.ops_spend_slope_0t12_Invalid>0);
    ops_spend_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.ops_spend_slope_0t24_Invalid=1);
    ops_spend_slope_0t24_LENGTH_ErrorCount := COUNT(GROUP,h.ops_spend_slope_0t24_Invalid=2);
    ops_spend_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.ops_spend_slope_0t24_Invalid>0);
    ops_spend_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.ops_spend_slope_0t6_Invalid=1);
    ops_spend_slope_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.ops_spend_slope_0t6_Invalid=2);
    ops_spend_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.ops_spend_slope_0t6_Invalid>0);
    fleet_paid_monthspastworst_24_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_paid_monthspastworst_24_Invalid=1);
    fleet_paid_monthspastworst_24_LENGTH_ErrorCount := COUNT(GROUP,h.fleet_paid_monthspastworst_24_Invalid=2);
    fleet_paid_monthspastworst_24_Total_ErrorCount := COUNT(GROUP,h.fleet_paid_monthspastworst_24_Invalid>0);
    fleet_paid_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_paid_slope_0t12_Invalid=1);
    fleet_paid_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.fleet_paid_slope_0t12_Invalid=2);
    fleet_paid_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.fleet_paid_slope_0t12_Invalid>0);
    fleet_paid_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_paid_slope_0t24_Invalid=1);
    fleet_paid_slope_0t24_LENGTH_ErrorCount := COUNT(GROUP,h.fleet_paid_slope_0t24_Invalid=2);
    fleet_paid_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.fleet_paid_slope_0t24_Invalid>0);
    fleet_paid_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_paid_slope_0t6_Invalid=1);
    fleet_paid_slope_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.fleet_paid_slope_0t6_Invalid=2);
    fleet_paid_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.fleet_paid_slope_0t6_Invalid>0);
    fleet_paid_volatility_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_paid_volatility_0t12_Invalid=1);
    fleet_paid_volatility_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.fleet_paid_volatility_0t12_Invalid=2);
    fleet_paid_volatility_0t12_Total_ErrorCount := COUNT(GROUP,h.fleet_paid_volatility_0t12_Invalid>0);
    fleet_paid_volatility_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_paid_volatility_0t6_Invalid=1);
    fleet_paid_volatility_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.fleet_paid_volatility_0t6_Invalid=2);
    fleet_paid_volatility_0t6_Total_ErrorCount := COUNT(GROUP,h.fleet_paid_volatility_0t6_Invalid>0);
    fleet_spend_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_spend_slope_0t12_Invalid=1);
    fleet_spend_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.fleet_spend_slope_0t12_Invalid=2);
    fleet_spend_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.fleet_spend_slope_0t12_Invalid>0);
    fleet_spend_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_spend_slope_0t24_Invalid=1);
    fleet_spend_slope_0t24_LENGTH_ErrorCount := COUNT(GROUP,h.fleet_spend_slope_0t24_Invalid=2);
    fleet_spend_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.fleet_spend_slope_0t24_Invalid>0);
    fleet_spend_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_spend_slope_0t6_Invalid=1);
    fleet_spend_slope_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.fleet_spend_slope_0t6_Invalid=2);
    fleet_spend_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.fleet_spend_slope_0t6_Invalid>0);
    carrier_paid_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_paid_slope_0t12_Invalid=1);
    carrier_paid_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.carrier_paid_slope_0t12_Invalid=2);
    carrier_paid_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.carrier_paid_slope_0t12_Invalid>0);
    carrier_paid_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_paid_slope_0t24_Invalid=1);
    carrier_paid_slope_0t24_LENGTH_ErrorCount := COUNT(GROUP,h.carrier_paid_slope_0t24_Invalid=2);
    carrier_paid_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.carrier_paid_slope_0t24_Invalid>0);
    carrier_paid_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_paid_slope_0t6_Invalid=1);
    carrier_paid_slope_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.carrier_paid_slope_0t6_Invalid=2);
    carrier_paid_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.carrier_paid_slope_0t6_Invalid>0);
    carrier_paid_volatility_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_paid_volatility_0t12_Invalid=1);
    carrier_paid_volatility_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.carrier_paid_volatility_0t12_Invalid=2);
    carrier_paid_volatility_0t12_Total_ErrorCount := COUNT(GROUP,h.carrier_paid_volatility_0t12_Invalid>0);
    carrier_paid_volatility_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_paid_volatility_0t6_Invalid=1);
    carrier_paid_volatility_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.carrier_paid_volatility_0t6_Invalid=2);
    carrier_paid_volatility_0t6_Total_ErrorCount := COUNT(GROUP,h.carrier_paid_volatility_0t6_Invalid>0);
    carrier_spend_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_spend_slope_0t12_Invalid=1);
    carrier_spend_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.carrier_spend_slope_0t12_Invalid=2);
    carrier_spend_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.carrier_spend_slope_0t12_Invalid>0);
    carrier_spend_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_spend_slope_0t24_Invalid=1);
    carrier_spend_slope_0t24_LENGTH_ErrorCount := COUNT(GROUP,h.carrier_spend_slope_0t24_Invalid=2);
    carrier_spend_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.carrier_spend_slope_0t24_Invalid>0);
    carrier_spend_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_spend_slope_0t6_Invalid=1);
    carrier_spend_slope_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.carrier_spend_slope_0t6_Invalid=2);
    carrier_spend_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.carrier_spend_slope_0t6_Invalid>0);
    carrier_spend_volatility_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_spend_volatility_0t6_Invalid=1);
    carrier_spend_volatility_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.carrier_spend_volatility_0t6_Invalid=2);
    carrier_spend_volatility_0t6_Total_ErrorCount := COUNT(GROUP,h.carrier_spend_volatility_0t6_Invalid>0);
    carrier_spend_volatility_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_spend_volatility_6t12_Invalid=1);
    carrier_spend_volatility_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.carrier_spend_volatility_6t12_Invalid=2);
    carrier_spend_volatility_6t12_Total_ErrorCount := COUNT(GROUP,h.carrier_spend_volatility_6t12_Invalid>0);
    bldgmats_paid_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_paid_slope_0t12_Invalid=1);
    bldgmats_paid_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.bldgmats_paid_slope_0t12_Invalid=2);
    bldgmats_paid_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.bldgmats_paid_slope_0t12_Invalid>0);
    bldgmats_paid_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_paid_slope_0t24_Invalid=1);
    bldgmats_paid_slope_0t24_LENGTH_ErrorCount := COUNT(GROUP,h.bldgmats_paid_slope_0t24_Invalid=2);
    bldgmats_paid_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.bldgmats_paid_slope_0t24_Invalid>0);
    bldgmats_paid_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_paid_slope_0t6_Invalid=1);
    bldgmats_paid_slope_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.bldgmats_paid_slope_0t6_Invalid=2);
    bldgmats_paid_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.bldgmats_paid_slope_0t6_Invalid>0);
    bldgmats_paid_volatility_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_paid_volatility_0t12_Invalid=1);
    bldgmats_paid_volatility_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.bldgmats_paid_volatility_0t12_Invalid=2);
    bldgmats_paid_volatility_0t12_Total_ErrorCount := COUNT(GROUP,h.bldgmats_paid_volatility_0t12_Invalid>0);
    bldgmats_paid_volatility_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_paid_volatility_0t6_Invalid=1);
    bldgmats_paid_volatility_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.bldgmats_paid_volatility_0t6_Invalid=2);
    bldgmats_paid_volatility_0t6_Total_ErrorCount := COUNT(GROUP,h.bldgmats_paid_volatility_0t6_Invalid>0);
    bldgmats_spend_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_spend_slope_0t12_Invalid=1);
    bldgmats_spend_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.bldgmats_spend_slope_0t12_Invalid=2);
    bldgmats_spend_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.bldgmats_spend_slope_0t12_Invalid>0);
    bldgmats_spend_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_spend_slope_0t24_Invalid=1);
    bldgmats_spend_slope_0t24_LENGTH_ErrorCount := COUNT(GROUP,h.bldgmats_spend_slope_0t24_Invalid=2);
    bldgmats_spend_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.bldgmats_spend_slope_0t24_Invalid>0);
    bldgmats_spend_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_spend_slope_0t6_Invalid=1);
    bldgmats_spend_slope_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.bldgmats_spend_slope_0t6_Invalid=2);
    bldgmats_spend_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.bldgmats_spend_slope_0t6_Invalid>0);
    bldgmats_spend_volatility_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_spend_volatility_0t6_Invalid=1);
    bldgmats_spend_volatility_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.bldgmats_spend_volatility_0t6_Invalid=2);
    bldgmats_spend_volatility_0t6_Total_ErrorCount := COUNT(GROUP,h.bldgmats_spend_volatility_0t6_Invalid>0);
    bldgmats_spend_volatility_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_spend_volatility_6t12_Invalid=1);
    bldgmats_spend_volatility_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.bldgmats_spend_volatility_6t12_Invalid=2);
    bldgmats_spend_volatility_6t12_Total_ErrorCount := COUNT(GROUP,h.bldgmats_spend_volatility_6t12_Invalid>0);
    top5_paid_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.top5_paid_slope_0t12_Invalid=1);
    top5_paid_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.top5_paid_slope_0t12_Invalid=2);
    top5_paid_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.top5_paid_slope_0t12_Invalid>0);
    top5_paid_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.top5_paid_slope_0t24_Invalid=1);
    top5_paid_slope_0t24_LENGTH_ErrorCount := COUNT(GROUP,h.top5_paid_slope_0t24_Invalid=2);
    top5_paid_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.top5_paid_slope_0t24_Invalid>0);
    top5_paid_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.top5_paid_slope_0t6_Invalid=1);
    top5_paid_slope_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.top5_paid_slope_0t6_Invalid=2);
    top5_paid_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.top5_paid_slope_0t6_Invalid>0);
    top5_paid_volatility_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.top5_paid_volatility_0t12_Invalid=1);
    top5_paid_volatility_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.top5_paid_volatility_0t12_Invalid=2);
    top5_paid_volatility_0t12_Total_ErrorCount := COUNT(GROUP,h.top5_paid_volatility_0t12_Invalid>0);
    top5_paid_volatility_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.top5_paid_volatility_0t6_Invalid=1);
    top5_paid_volatility_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.top5_paid_volatility_0t6_Invalid=2);
    top5_paid_volatility_0t6_Total_ErrorCount := COUNT(GROUP,h.top5_paid_volatility_0t6_Invalid>0);
    top5_spend_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.top5_spend_slope_0t12_Invalid=1);
    top5_spend_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.top5_spend_slope_0t12_Invalid=2);
    top5_spend_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.top5_spend_slope_0t12_Invalid>0);
    top5_spend_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.top5_spend_slope_0t24_Invalid=1);
    top5_spend_slope_0t24_LENGTH_ErrorCount := COUNT(GROUP,h.top5_spend_slope_0t24_Invalid=2);
    top5_spend_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.top5_spend_slope_0t24_Invalid>0);
    top5_spend_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.top5_spend_slope_0t6_Invalid=1);
    top5_spend_slope_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.top5_spend_slope_0t6_Invalid=2);
    top5_spend_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.top5_spend_slope_0t6_Invalid>0);
    top5_spend_volatility_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.top5_spend_volatility_0t6_Invalid=1);
    top5_spend_volatility_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.top5_spend_volatility_0t6_Invalid=2);
    top5_spend_volatility_0t6_Total_ErrorCount := COUNT(GROUP,h.top5_spend_volatility_0t6_Invalid>0);
    top5_spend_volatility_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.top5_spend_volatility_6t12_Invalid=1);
    top5_spend_volatility_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.top5_spend_volatility_6t12_Invalid=2);
    top5_spend_volatility_6t12_Total_ErrorCount := COUNT(GROUP,h.top5_spend_volatility_6t12_Invalid>0);
    total_numrel_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_numrel_slope_0t12_Invalid=1);
    total_numrel_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.total_numrel_slope_0t12_Invalid=2);
    total_numrel_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.total_numrel_slope_0t12_Invalid>0);
    total_numrel_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.total_numrel_slope_0t24_Invalid=1);
    total_numrel_slope_0t24_LENGTH_ErrorCount := COUNT(GROUP,h.total_numrel_slope_0t24_Invalid=2);
    total_numrel_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.total_numrel_slope_0t24_Invalid>0);
    total_numrel_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.total_numrel_slope_0t6_Invalid=1);
    total_numrel_slope_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.total_numrel_slope_0t6_Invalid=2);
    total_numrel_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.total_numrel_slope_0t6_Invalid>0);
    total_numrel_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_numrel_slope_6t12_Invalid=1);
    total_numrel_slope_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.total_numrel_slope_6t12_Invalid=2);
    total_numrel_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.total_numrel_slope_6t12_Invalid>0);
    mfgmat_numrel_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_numrel_slope_0t12_Invalid=1);
    mfgmat_numrel_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.mfgmat_numrel_slope_0t12_Invalid=2);
    mfgmat_numrel_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.mfgmat_numrel_slope_0t12_Invalid>0);
    mfgmat_numrel_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_numrel_slope_0t24_Invalid=1);
    mfgmat_numrel_slope_0t24_LENGTH_ErrorCount := COUNT(GROUP,h.mfgmat_numrel_slope_0t24_Invalid=2);
    mfgmat_numrel_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.mfgmat_numrel_slope_0t24_Invalid>0);
    mfgmat_numrel_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_numrel_slope_0t6_Invalid=1);
    mfgmat_numrel_slope_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.mfgmat_numrel_slope_0t6_Invalid=2);
    mfgmat_numrel_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.mfgmat_numrel_slope_0t6_Invalid>0);
    mfgmat_numrel_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_numrel_slope_6t12_Invalid=1);
    mfgmat_numrel_slope_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.mfgmat_numrel_slope_6t12_Invalid=2);
    mfgmat_numrel_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.mfgmat_numrel_slope_6t12_Invalid>0);
    ops_numrel_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.ops_numrel_slope_0t12_Invalid=1);
    ops_numrel_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.ops_numrel_slope_0t12_Invalid=2);
    ops_numrel_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.ops_numrel_slope_0t12_Invalid>0);
    ops_numrel_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.ops_numrel_slope_0t24_Invalid=1);
    ops_numrel_slope_0t24_LENGTH_ErrorCount := COUNT(GROUP,h.ops_numrel_slope_0t24_Invalid=2);
    ops_numrel_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.ops_numrel_slope_0t24_Invalid>0);
    ops_numrel_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.ops_numrel_slope_0t6_Invalid=1);
    ops_numrel_slope_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.ops_numrel_slope_0t6_Invalid=2);
    ops_numrel_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.ops_numrel_slope_0t6_Invalid>0);
    ops_numrel_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.ops_numrel_slope_6t12_Invalid=1);
    ops_numrel_slope_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.ops_numrel_slope_6t12_Invalid=2);
    ops_numrel_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.ops_numrel_slope_6t12_Invalid>0);
    fleet_numrel_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_numrel_slope_0t12_Invalid=1);
    fleet_numrel_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.fleet_numrel_slope_0t12_Invalid=2);
    fleet_numrel_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.fleet_numrel_slope_0t12_Invalid>0);
    fleet_numrel_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_numrel_slope_0t24_Invalid=1);
    fleet_numrel_slope_0t24_LENGTH_ErrorCount := COUNT(GROUP,h.fleet_numrel_slope_0t24_Invalid=2);
    fleet_numrel_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.fleet_numrel_slope_0t24_Invalid>0);
    fleet_numrel_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_numrel_slope_0t6_Invalid=1);
    fleet_numrel_slope_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.fleet_numrel_slope_0t6_Invalid=2);
    fleet_numrel_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.fleet_numrel_slope_0t6_Invalid>0);
    fleet_numrel_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_numrel_slope_6t12_Invalid=1);
    fleet_numrel_slope_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.fleet_numrel_slope_6t12_Invalid=2);
    fleet_numrel_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.fleet_numrel_slope_6t12_Invalid>0);
    carrier_numrel_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_numrel_slope_0t12_Invalid=1);
    carrier_numrel_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.carrier_numrel_slope_0t12_Invalid=2);
    carrier_numrel_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.carrier_numrel_slope_0t12_Invalid>0);
    carrier_numrel_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_numrel_slope_0t24_Invalid=1);
    carrier_numrel_slope_0t24_LENGTH_ErrorCount := COUNT(GROUP,h.carrier_numrel_slope_0t24_Invalid=2);
    carrier_numrel_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.carrier_numrel_slope_0t24_Invalid>0);
    carrier_numrel_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_numrel_slope_0t6_Invalid=1);
    carrier_numrel_slope_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.carrier_numrel_slope_0t6_Invalid=2);
    carrier_numrel_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.carrier_numrel_slope_0t6_Invalid>0);
    carrier_numrel_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_numrel_slope_6t12_Invalid=1);
    carrier_numrel_slope_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.carrier_numrel_slope_6t12_Invalid=2);
    carrier_numrel_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.carrier_numrel_slope_6t12_Invalid>0);
    bldgmats_numrel_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_slope_0t12_Invalid=1);
    bldgmats_numrel_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_slope_0t12_Invalid=2);
    bldgmats_numrel_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_slope_0t12_Invalid>0);
    bldgmats_numrel_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_slope_0t24_Invalid=1);
    bldgmats_numrel_slope_0t24_LENGTH_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_slope_0t24_Invalid=2);
    bldgmats_numrel_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_slope_0t24_Invalid>0);
    bldgmats_numrel_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_slope_0t6_Invalid=1);
    bldgmats_numrel_slope_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_slope_0t6_Invalid=2);
    bldgmats_numrel_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_slope_0t6_Invalid>0);
    bldgmats_numrel_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_slope_6t12_Invalid=1);
    bldgmats_numrel_slope_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_slope_6t12_Invalid=2);
    bldgmats_numrel_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_slope_6t12_Invalid>0);
    bldgmats_numrel_var_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_var_0t12_Invalid=1);
    bldgmats_numrel_var_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_var_0t12_Invalid=2);
    bldgmats_numrel_var_0t12_Total_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_var_0t12_Invalid>0);
    bldgmats_numrel_var_12t24_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_var_12t24_Invalid=1);
    bldgmats_numrel_var_12t24_LENGTH_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_var_12t24_Invalid=2);
    bldgmats_numrel_var_12t24_Total_ErrorCount := COUNT(GROUP,h.bldgmats_numrel_var_12t24_Invalid>0);
    total_percprov30_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_percprov30_slope_0t12_Invalid=1);
    total_percprov30_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.total_percprov30_slope_0t12_Invalid=2);
    total_percprov30_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.total_percprov30_slope_0t12_Invalid>0);
    total_percprov30_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.total_percprov30_slope_0t24_Invalid=1);
    total_percprov30_slope_0t24_LENGTH_ErrorCount := COUNT(GROUP,h.total_percprov30_slope_0t24_Invalid=2);
    total_percprov30_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.total_percprov30_slope_0t24_Invalid>0);
    total_percprov30_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.total_percprov30_slope_0t6_Invalid=1);
    total_percprov30_slope_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.total_percprov30_slope_0t6_Invalid=2);
    total_percprov30_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.total_percprov30_slope_0t6_Invalid>0);
    total_percprov30_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_percprov30_slope_6t12_Invalid=1);
    total_percprov30_slope_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.total_percprov30_slope_6t12_Invalid=2);
    total_percprov30_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.total_percprov30_slope_6t12_Invalid>0);
    total_percprov60_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_percprov60_slope_0t12_Invalid=1);
    total_percprov60_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.total_percprov60_slope_0t12_Invalid=2);
    total_percprov60_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.total_percprov60_slope_0t12_Invalid>0);
    total_percprov60_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.total_percprov60_slope_0t24_Invalid=1);
    total_percprov60_slope_0t24_LENGTH_ErrorCount := COUNT(GROUP,h.total_percprov60_slope_0t24_Invalid=2);
    total_percprov60_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.total_percprov60_slope_0t24_Invalid>0);
    total_percprov60_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.total_percprov60_slope_0t6_Invalid=1);
    total_percprov60_slope_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.total_percprov60_slope_0t6_Invalid=2);
    total_percprov60_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.total_percprov60_slope_0t6_Invalid>0);
    total_percprov60_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_percprov60_slope_6t12_Invalid=1);
    total_percprov60_slope_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.total_percprov60_slope_6t12_Invalid=2);
    total_percprov60_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.total_percprov60_slope_6t12_Invalid>0);
    total_percprov90_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.total_percprov90_slope_0t24_Invalid=1);
    total_percprov90_slope_0t24_LENGTH_ErrorCount := COUNT(GROUP,h.total_percprov90_slope_0t24_Invalid=2);
    total_percprov90_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.total_percprov90_slope_0t24_Invalid>0);
    total_percprov90_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.total_percprov90_slope_0t6_Invalid=1);
    total_percprov90_slope_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.total_percprov90_slope_0t6_Invalid=2);
    total_percprov90_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.total_percprov90_slope_0t6_Invalid>0);
    total_percprov90_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.total_percprov90_slope_6t12_Invalid=1);
    total_percprov90_slope_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.total_percprov90_slope_6t12_Invalid=2);
    total_percprov90_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.total_percprov90_slope_6t12_Invalid>0);
    mfgmat_percprov30_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_percprov30_slope_0t12_Invalid=1);
    mfgmat_percprov30_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.mfgmat_percprov30_slope_0t12_Invalid=2);
    mfgmat_percprov30_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.mfgmat_percprov30_slope_0t12_Invalid>0);
    mfgmat_percprov30_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_percprov30_slope_6t12_Invalid=1);
    mfgmat_percprov30_slope_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.mfgmat_percprov30_slope_6t12_Invalid=2);
    mfgmat_percprov30_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.mfgmat_percprov30_slope_6t12_Invalid>0);
    mfgmat_percprov60_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_percprov60_slope_0t12_Invalid=1);
    mfgmat_percprov60_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.mfgmat_percprov60_slope_0t12_Invalid=2);
    mfgmat_percprov60_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.mfgmat_percprov60_slope_0t12_Invalid>0);
    mfgmat_percprov60_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_percprov60_slope_6t12_Invalid=1);
    mfgmat_percprov60_slope_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.mfgmat_percprov60_slope_6t12_Invalid=2);
    mfgmat_percprov60_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.mfgmat_percprov60_slope_6t12_Invalid>0);
    mfgmat_percprov90_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_percprov90_slope_0t24_Invalid=1);
    mfgmat_percprov90_slope_0t24_LENGTH_ErrorCount := COUNT(GROUP,h.mfgmat_percprov90_slope_0t24_Invalid=2);
    mfgmat_percprov90_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.mfgmat_percprov90_slope_0t24_Invalid>0);
    mfgmat_percprov90_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_percprov90_slope_0t6_Invalid=1);
    mfgmat_percprov90_slope_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.mfgmat_percprov90_slope_0t6_Invalid=2);
    mfgmat_percprov90_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.mfgmat_percprov90_slope_0t6_Invalid>0);
    mfgmat_percprov90_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.mfgmat_percprov90_slope_6t12_Invalid=1);
    mfgmat_percprov90_slope_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.mfgmat_percprov90_slope_6t12_Invalid=2);
    mfgmat_percprov90_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.mfgmat_percprov90_slope_6t12_Invalid>0);
    ops_percprov30_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.ops_percprov30_slope_0t12_Invalid=1);
    ops_percprov30_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.ops_percprov30_slope_0t12_Invalid=2);
    ops_percprov30_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.ops_percprov30_slope_0t12_Invalid>0);
    ops_percprov30_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.ops_percprov30_slope_6t12_Invalid=1);
    ops_percprov30_slope_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.ops_percprov30_slope_6t12_Invalid=2);
    ops_percprov30_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.ops_percprov30_slope_6t12_Invalid>0);
    ops_percprov60_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.ops_percprov60_slope_0t12_Invalid=1);
    ops_percprov60_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.ops_percprov60_slope_0t12_Invalid=2);
    ops_percprov60_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.ops_percprov60_slope_0t12_Invalid>0);
    ops_percprov60_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.ops_percprov60_slope_6t12_Invalid=1);
    ops_percprov60_slope_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.ops_percprov60_slope_6t12_Invalid=2);
    ops_percprov60_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.ops_percprov60_slope_6t12_Invalid>0);
    ops_percprov90_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.ops_percprov90_slope_0t24_Invalid=1);
    ops_percprov90_slope_0t24_LENGTH_ErrorCount := COUNT(GROUP,h.ops_percprov90_slope_0t24_Invalid=2);
    ops_percprov90_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.ops_percprov90_slope_0t24_Invalid>0);
    ops_percprov90_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.ops_percprov90_slope_0t6_Invalid=1);
    ops_percprov90_slope_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.ops_percprov90_slope_0t6_Invalid=2);
    ops_percprov90_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.ops_percprov90_slope_0t6_Invalid>0);
    ops_percprov90_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.ops_percprov90_slope_6t12_Invalid=1);
    ops_percprov90_slope_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.ops_percprov90_slope_6t12_Invalid=2);
    ops_percprov90_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.ops_percprov90_slope_6t12_Invalid>0);
    fleet_percprov30_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_percprov30_slope_0t12_Invalid=1);
    fleet_percprov30_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.fleet_percprov30_slope_0t12_Invalid=2);
    fleet_percprov30_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.fleet_percprov30_slope_0t12_Invalid>0);
    fleet_percprov30_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_percprov30_slope_6t12_Invalid=1);
    fleet_percprov30_slope_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.fleet_percprov30_slope_6t12_Invalid=2);
    fleet_percprov30_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.fleet_percprov30_slope_6t12_Invalid>0);
    fleet_percprov60_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_percprov60_slope_0t12_Invalid=1);
    fleet_percprov60_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.fleet_percprov60_slope_0t12_Invalid=2);
    fleet_percprov60_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.fleet_percprov60_slope_0t12_Invalid>0);
    fleet_percprov60_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_percprov60_slope_6t12_Invalid=1);
    fleet_percprov60_slope_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.fleet_percprov60_slope_6t12_Invalid=2);
    fleet_percprov60_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.fleet_percprov60_slope_6t12_Invalid>0);
    fleet_percprov90_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_percprov90_slope_0t24_Invalid=1);
    fleet_percprov90_slope_0t24_LENGTH_ErrorCount := COUNT(GROUP,h.fleet_percprov90_slope_0t24_Invalid=2);
    fleet_percprov90_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.fleet_percprov90_slope_0t24_Invalid>0);
    fleet_percprov90_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_percprov90_slope_0t6_Invalid=1);
    fleet_percprov90_slope_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.fleet_percprov90_slope_0t6_Invalid=2);
    fleet_percprov90_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.fleet_percprov90_slope_0t6_Invalid>0);
    fleet_percprov90_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.fleet_percprov90_slope_6t12_Invalid=1);
    fleet_percprov90_slope_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.fleet_percprov90_slope_6t12_Invalid=2);
    fleet_percprov90_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.fleet_percprov90_slope_6t12_Invalid>0);
    carrier_percprov30_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_percprov30_slope_0t12_Invalid=1);
    carrier_percprov30_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.carrier_percprov30_slope_0t12_Invalid=2);
    carrier_percprov30_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.carrier_percprov30_slope_0t12_Invalid>0);
    carrier_percprov30_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_percprov30_slope_6t12_Invalid=1);
    carrier_percprov30_slope_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.carrier_percprov30_slope_6t12_Invalid=2);
    carrier_percprov30_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.carrier_percprov30_slope_6t12_Invalid>0);
    carrier_percprov60_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_percprov60_slope_0t12_Invalid=1);
    carrier_percprov60_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.carrier_percprov60_slope_0t12_Invalid=2);
    carrier_percprov60_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.carrier_percprov60_slope_0t12_Invalid>0);
    carrier_percprov60_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_percprov60_slope_6t12_Invalid=1);
    carrier_percprov60_slope_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.carrier_percprov60_slope_6t12_Invalid=2);
    carrier_percprov60_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.carrier_percprov60_slope_6t12_Invalid>0);
    carrier_percprov90_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_percprov90_slope_0t24_Invalid=1);
    carrier_percprov90_slope_0t24_LENGTH_ErrorCount := COUNT(GROUP,h.carrier_percprov90_slope_0t24_Invalid=2);
    carrier_percprov90_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.carrier_percprov90_slope_0t24_Invalid>0);
    carrier_percprov90_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_percprov90_slope_0t6_Invalid=1);
    carrier_percprov90_slope_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.carrier_percprov90_slope_0t6_Invalid=2);
    carrier_percprov90_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.carrier_percprov90_slope_0t6_Invalid>0);
    carrier_percprov90_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_percprov90_slope_6t12_Invalid=1);
    carrier_percprov90_slope_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.carrier_percprov90_slope_6t12_Invalid=2);
    carrier_percprov90_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.carrier_percprov90_slope_6t12_Invalid>0);
    bldgmats_percprov30_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_percprov30_slope_0t12_Invalid=1);
    bldgmats_percprov30_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.bldgmats_percprov30_slope_0t12_Invalid=2);
    bldgmats_percprov30_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.bldgmats_percprov30_slope_0t12_Invalid>0);
    bldgmats_percprov30_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_percprov30_slope_6t12_Invalid=1);
    bldgmats_percprov30_slope_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.bldgmats_percprov30_slope_6t12_Invalid=2);
    bldgmats_percprov30_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.bldgmats_percprov30_slope_6t12_Invalid>0);
    bldgmats_percprov60_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_percprov60_slope_0t12_Invalid=1);
    bldgmats_percprov60_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.bldgmats_percprov60_slope_0t12_Invalid=2);
    bldgmats_percprov60_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.bldgmats_percprov60_slope_0t12_Invalid>0);
    bldgmats_percprov60_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_percprov60_slope_6t12_Invalid=1);
    bldgmats_percprov60_slope_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.bldgmats_percprov60_slope_6t12_Invalid=2);
    bldgmats_percprov60_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.bldgmats_percprov60_slope_6t12_Invalid>0);
    bldgmats_percprov90_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_percprov90_slope_0t24_Invalid=1);
    bldgmats_percprov90_slope_0t24_LENGTH_ErrorCount := COUNT(GROUP,h.bldgmats_percprov90_slope_0t24_Invalid=2);
    bldgmats_percprov90_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.bldgmats_percprov90_slope_0t24_Invalid>0);
    bldgmats_percprov90_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_percprov90_slope_0t6_Invalid=1);
    bldgmats_percprov90_slope_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.bldgmats_percprov90_slope_0t6_Invalid=2);
    bldgmats_percprov90_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.bldgmats_percprov90_slope_0t6_Invalid>0);
    bldgmats_percprov90_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.bldgmats_percprov90_slope_6t12_Invalid=1);
    bldgmats_percprov90_slope_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.bldgmats_percprov90_slope_6t12_Invalid=2);
    bldgmats_percprov90_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.bldgmats_percprov90_slope_6t12_Invalid>0);
    top5_percprov30_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.top5_percprov30_slope_0t12_Invalid=1);
    top5_percprov30_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.top5_percprov30_slope_0t12_Invalid=2);
    top5_percprov30_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.top5_percprov30_slope_0t12_Invalid>0);
    top5_percprov30_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.top5_percprov30_slope_6t12_Invalid=1);
    top5_percprov30_slope_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.top5_percprov30_slope_6t12_Invalid=2);
    top5_percprov30_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.top5_percprov30_slope_6t12_Invalid>0);
    top5_percprov60_slope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.top5_percprov60_slope_0t12_Invalid=1);
    top5_percprov60_slope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.top5_percprov60_slope_0t12_Invalid=2);
    top5_percprov60_slope_0t12_Total_ErrorCount := COUNT(GROUP,h.top5_percprov60_slope_0t12_Invalid>0);
    top5_percprov60_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.top5_percprov60_slope_6t12_Invalid=1);
    top5_percprov60_slope_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.top5_percprov60_slope_6t12_Invalid=2);
    top5_percprov60_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.top5_percprov60_slope_6t12_Invalid>0);
    top5_percprov90_slope_0t24_ALLOW_ErrorCount := COUNT(GROUP,h.top5_percprov90_slope_0t24_Invalid=1);
    top5_percprov90_slope_0t24_LENGTH_ErrorCount := COUNT(GROUP,h.top5_percprov90_slope_0t24_Invalid=2);
    top5_percprov90_slope_0t24_Total_ErrorCount := COUNT(GROUP,h.top5_percprov90_slope_0t24_Invalid>0);
    top5_percprov90_slope_0t6_ALLOW_ErrorCount := COUNT(GROUP,h.top5_percprov90_slope_0t6_Invalid=1);
    top5_percprov90_slope_0t6_LENGTH_ErrorCount := COUNT(GROUP,h.top5_percprov90_slope_0t6_Invalid=2);
    top5_percprov90_slope_0t6_Total_ErrorCount := COUNT(GROUP,h.top5_percprov90_slope_0t6_Invalid>0);
    top5_percprov90_slope_6t12_ALLOW_ErrorCount := COUNT(GROUP,h.top5_percprov90_slope_6t12_Invalid=1);
    top5_percprov90_slope_6t12_LENGTH_ErrorCount := COUNT(GROUP,h.top5_percprov90_slope_6t12_Invalid=2);
    top5_percprov90_slope_6t12_Total_ErrorCount := COUNT(GROUP,h.top5_percprov90_slope_6t12_Invalid>0);
    top5_percprovoutstanding_adjustedslope_0t12_ALLOW_ErrorCount := COUNT(GROUP,h.top5_percprovoutstanding_adjustedslope_0t12_Invalid=1);
    top5_percprovoutstanding_adjustedslope_0t12_LENGTH_ErrorCount := COUNT(GROUP,h.top5_percprovoutstanding_adjustedslope_0t12_Invalid=2);
    top5_percprovoutstanding_adjustedslope_0t12_Total_ErrorCount := COUNT(GROUP,h.top5_percprovoutstanding_adjustedslope_0t12_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT36.StrType ErrorMessage;
    SALT36.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.ultimate_linkid_Invalid,le.cortera_score_Invalid,le.cpr_score_Invalid,le.cpr_segment_Invalid,le.dbt_Invalid,le.avg_bal_Invalid,le.air_spend_Invalid,le.fuel_spend_Invalid,le.leasing_spend_Invalid,le.ltl_spend_Invalid,le.rail_spend_Invalid,le.tl_spend_Invalid,le.transvc_spend_Invalid,le.transup_spend_Invalid,le.bst_spend_Invalid,le.dg_spend_Invalid,le.electrical_spend_Invalid,le.hvac_spend_Invalid,le.other_b_spend_Invalid,le.plumbing_spend_Invalid,le.rs_spend_Invalid,le.wp_spend_Invalid,le.chemical_spend_Invalid,le.electronic_spend_Invalid,le.metal_spend_Invalid,le.other_m_spend_Invalid,le.packaging_spend_Invalid,le.pvf_spend_Invalid,le.plastic_spend_Invalid,le.textile_spend_Invalid,le.bs_spend_Invalid,le.ce_spend_Invalid,le.hardware_spend_Invalid,le.ie_spend_Invalid,le.is_spend_Invalid,le.it_spend_Invalid,le.mls_spend_Invalid,le.os_spend_Invalid,le.pp_spend_Invalid,le.sis_spend_Invalid,le.apparel_spend_Invalid,le.beverages_spend_Invalid,le.constr_spend_Invalid,le.consulting_spend_Invalid,le.fs_spend_Invalid,le.fp_spend_Invalid,le.insurance_spend_Invalid,le.ls_spend_Invalid,le.oil_gas_spend_Invalid,le.utilities_spend_Invalid,le.other_spend_Invalid,le.advt_spend_Invalid,le.air_growth_Invalid,le.fuel_growth_Invalid,le.leasing_growth_Invalid,le.ltl_growth_Invalid,le.rail_growth_Invalid,le.tl_growth_Invalid,le.transvc_growth_Invalid,le.transup_growth_Invalid,le.bst_growth_Invalid,le.dg_growth_Invalid,le.electrical_growth_Invalid,le.hvac_growth_Invalid,le.other_b_growth_Invalid,le.plumbing_growth_Invalid,le.rs_growth_Invalid,le.wp_growth_Invalid,le.chemical_growth_Invalid,le.electronic_growth_Invalid,le.metal_growth_Invalid,le.other_m_growth_Invalid,le.packaging_growth_Invalid,le.pvf_growth_Invalid,le.plastic_growth_Invalid,le.textile_growth_Invalid,le.bs_growth_Invalid,le.ce_growth_Invalid,le.hardware_growth_Invalid,le.ie_growth_Invalid,le.is_growth_Invalid,le.it_growth_Invalid,le.mls_growth_Invalid,le.os_growth_Invalid,le.pp_growth_Invalid,le.sis_growth_Invalid,le.apparel_growth_Invalid,le.beverages_growth_Invalid,le.constr_growth_Invalid,le.consulting_growth_Invalid,le.fs_growth_Invalid,le.fp_growth_Invalid,le.insurance_growth_Invalid,le.ls_growth_Invalid,le.oil_gas_growth_Invalid,le.utilities_growth_Invalid,le.other_growth_Invalid,le.advt_growth_Invalid,le.top5_growth_Invalid,le.shipping_y1_Invalid,le.shipping_growth_Invalid,le.materials_y1_Invalid,le.materials_growth_Invalid,le.operations_y1_Invalid,le.operations_growth_Invalid,le.total_paid_average_0t12_Invalid,le.total_paid_monthspastworst_24_Invalid,le.total_paid_slope_0t12_Invalid,le.total_paid_slope_0t6_Invalid,le.total_paid_slope_6t12_Invalid,le.total_paid_slope_6t18_Invalid,le.total_paid_volatility_0t12_Invalid,le.total_paid_volatility_0t6_Invalid,le.total_paid_volatility_12t18_Invalid,le.total_paid_volatility_6t12_Invalid,le.total_spend_monthspastleast_24_Invalid,le.total_spend_monthspastmost_24_Invalid,le.total_spend_slope_0t12_Invalid,le.total_spend_slope_0t24_Invalid,le.total_spend_slope_0t6_Invalid,le.total_spend_slope_6t12_Invalid,le.total_spend_sum_12_Invalid,le.total_spend_volatility_0t12_Invalid,le.total_spend_volatility_0t6_Invalid,le.total_spend_volatility_12t18_Invalid,le.total_spend_volatility_6t12_Invalid,le.mfgmat_paid_average_12_Invalid,le.mfgmat_paid_monthspastworst_24_Invalid,le.mfgmat_paid_slope_0t12_Invalid,le.mfgmat_paid_slope_0t24_Invalid,le.mfgmat_paid_slope_0t6_Invalid,le.mfgmat_paid_volatility_0t12_Invalid,le.mfgmat_paid_volatility_0t6_Invalid,le.mfgmat_spend_monthspastleast_24_Invalid,le.mfgmat_spend_monthspastmost_24_Invalid,le.mfgmat_spend_slope_0t12_Invalid,le.mfgmat_spend_slope_0t24_Invalid,le.mfgmat_spend_slope_0t6_Invalid,le.mfgmat_spend_sum_12_Invalid,le.mfgmat_spend_volatility_0t6_Invalid,le.mfgmat_spend_volatility_6t12_Invalid,le.ops_paid_average_12_Invalid,le.ops_paid_monthspastworst_24_Invalid,le.ops_paid_slope_0t12_Invalid,le.ops_paid_slope_0t24_Invalid,le.ops_paid_slope_0t6_Invalid,le.ops_paid_volatility_0t12_Invalid,le.ops_paid_volatility_0t6_Invalid,le.ops_spend_monthspastleast_24_Invalid,le.ops_spend_monthspastmost_24_Invalid,le.ops_spend_slope_0t12_Invalid,le.ops_spend_slope_0t24_Invalid,le.ops_spend_slope_0t6_Invalid,le.fleet_paid_monthspastworst_24_Invalid,le.fleet_paid_slope_0t12_Invalid,le.fleet_paid_slope_0t24_Invalid,le.fleet_paid_slope_0t6_Invalid,le.fleet_paid_volatility_0t12_Invalid,le.fleet_paid_volatility_0t6_Invalid,le.fleet_spend_slope_0t12_Invalid,le.fleet_spend_slope_0t24_Invalid,le.fleet_spend_slope_0t6_Invalid,le.carrier_paid_slope_0t12_Invalid,le.carrier_paid_slope_0t24_Invalid,le.carrier_paid_slope_0t6_Invalid,le.carrier_paid_volatility_0t12_Invalid,le.carrier_paid_volatility_0t6_Invalid,le.carrier_spend_slope_0t12_Invalid,le.carrier_spend_slope_0t24_Invalid,le.carrier_spend_slope_0t6_Invalid,le.carrier_spend_volatility_0t6_Invalid,le.carrier_spend_volatility_6t12_Invalid,le.bldgmats_paid_slope_0t12_Invalid,le.bldgmats_paid_slope_0t24_Invalid,le.bldgmats_paid_slope_0t6_Invalid,le.bldgmats_paid_volatility_0t12_Invalid,le.bldgmats_paid_volatility_0t6_Invalid,le.bldgmats_spend_slope_0t12_Invalid,le.bldgmats_spend_slope_0t24_Invalid,le.bldgmats_spend_slope_0t6_Invalid,le.bldgmats_spend_volatility_0t6_Invalid,le.bldgmats_spend_volatility_6t12_Invalid,le.top5_paid_slope_0t12_Invalid,le.top5_paid_slope_0t24_Invalid,le.top5_paid_slope_0t6_Invalid,le.top5_paid_volatility_0t12_Invalid,le.top5_paid_volatility_0t6_Invalid,le.top5_spend_slope_0t12_Invalid,le.top5_spend_slope_0t24_Invalid,le.top5_spend_slope_0t6_Invalid,le.top5_spend_volatility_0t6_Invalid,le.top5_spend_volatility_6t12_Invalid,le.total_numrel_slope_0t12_Invalid,le.total_numrel_slope_0t24_Invalid,le.total_numrel_slope_0t6_Invalid,le.total_numrel_slope_6t12_Invalid,le.mfgmat_numrel_slope_0t12_Invalid,le.mfgmat_numrel_slope_0t24_Invalid,le.mfgmat_numrel_slope_0t6_Invalid,le.mfgmat_numrel_slope_6t12_Invalid,le.ops_numrel_slope_0t12_Invalid,le.ops_numrel_slope_0t24_Invalid,le.ops_numrel_slope_0t6_Invalid,le.ops_numrel_slope_6t12_Invalid,le.fleet_numrel_slope_0t12_Invalid,le.fleet_numrel_slope_0t24_Invalid,le.fleet_numrel_slope_0t6_Invalid,le.fleet_numrel_slope_6t12_Invalid,le.carrier_numrel_slope_0t12_Invalid,le.carrier_numrel_slope_0t24_Invalid,le.carrier_numrel_slope_0t6_Invalid,le.carrier_numrel_slope_6t12_Invalid,le.bldgmats_numrel_slope_0t12_Invalid,le.bldgmats_numrel_slope_0t24_Invalid,le.bldgmats_numrel_slope_0t6_Invalid,le.bldgmats_numrel_slope_6t12_Invalid,le.bldgmats_numrel_var_0t12_Invalid,le.bldgmats_numrel_var_12t24_Invalid,le.total_percprov30_slope_0t12_Invalid,le.total_percprov30_slope_0t24_Invalid,le.total_percprov30_slope_0t6_Invalid,le.total_percprov30_slope_6t12_Invalid,le.total_percprov60_slope_0t12_Invalid,le.total_percprov60_slope_0t24_Invalid,le.total_percprov60_slope_0t6_Invalid,le.total_percprov60_slope_6t12_Invalid,le.total_percprov90_slope_0t24_Invalid,le.total_percprov90_slope_0t6_Invalid,le.total_percprov90_slope_6t12_Invalid,le.mfgmat_percprov30_slope_0t12_Invalid,le.mfgmat_percprov30_slope_6t12_Invalid,le.mfgmat_percprov60_slope_0t12_Invalid,le.mfgmat_percprov60_slope_6t12_Invalid,le.mfgmat_percprov90_slope_0t24_Invalid,le.mfgmat_percprov90_slope_0t6_Invalid,le.mfgmat_percprov90_slope_6t12_Invalid,le.ops_percprov30_slope_0t12_Invalid,le.ops_percprov30_slope_6t12_Invalid,le.ops_percprov60_slope_0t12_Invalid,le.ops_percprov60_slope_6t12_Invalid,le.ops_percprov90_slope_0t24_Invalid,le.ops_percprov90_slope_0t6_Invalid,le.ops_percprov90_slope_6t12_Invalid,le.fleet_percprov30_slope_0t12_Invalid,le.fleet_percprov30_slope_6t12_Invalid,le.fleet_percprov60_slope_0t12_Invalid,le.fleet_percprov60_slope_6t12_Invalid,le.fleet_percprov90_slope_0t24_Invalid,le.fleet_percprov90_slope_0t6_Invalid,le.fleet_percprov90_slope_6t12_Invalid,le.carrier_percprov30_slope_0t12_Invalid,le.carrier_percprov30_slope_6t12_Invalid,le.carrier_percprov60_slope_0t12_Invalid,le.carrier_percprov60_slope_6t12_Invalid,le.carrier_percprov90_slope_0t24_Invalid,le.carrier_percprov90_slope_0t6_Invalid,le.carrier_percprov90_slope_6t12_Invalid,le.bldgmats_percprov30_slope_0t12_Invalid,le.bldgmats_percprov30_slope_6t12_Invalid,le.bldgmats_percprov60_slope_0t12_Invalid,le.bldgmats_percprov60_slope_6t12_Invalid,le.bldgmats_percprov90_slope_0t24_Invalid,le.bldgmats_percprov90_slope_0t6_Invalid,le.bldgmats_percprov90_slope_6t12_Invalid,le.top5_percprov30_slope_0t12_Invalid,le.top5_percprov30_slope_6t12_Invalid,le.top5_percprov60_slope_0t12_Invalid,le.top5_percprov60_slope_6t12_Invalid,le.top5_percprov90_slope_0t24_Invalid,le.top5_percprov90_slope_0t6_Invalid,le.top5_percprov90_slope_6t12_Invalid,le.top5_percprovoutstanding_adjustedslope_0t12_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_ultimate_linkid(le.ultimate_linkid_Invalid),Fields.InvalidMessage_cortera_score(le.cortera_score_Invalid),Fields.InvalidMessage_cpr_score(le.cpr_score_Invalid),Fields.InvalidMessage_cpr_segment(le.cpr_segment_Invalid),Fields.InvalidMessage_dbt(le.dbt_Invalid),Fields.InvalidMessage_avg_bal(le.avg_bal_Invalid),Fields.InvalidMessage_air_spend(le.air_spend_Invalid),Fields.InvalidMessage_fuel_spend(le.fuel_spend_Invalid),Fields.InvalidMessage_leasing_spend(le.leasing_spend_Invalid),Fields.InvalidMessage_ltl_spend(le.ltl_spend_Invalid),Fields.InvalidMessage_rail_spend(le.rail_spend_Invalid),Fields.InvalidMessage_tl_spend(le.tl_spend_Invalid),Fields.InvalidMessage_transvc_spend(le.transvc_spend_Invalid),Fields.InvalidMessage_transup_spend(le.transup_spend_Invalid),Fields.InvalidMessage_bst_spend(le.bst_spend_Invalid),Fields.InvalidMessage_dg_spend(le.dg_spend_Invalid),Fields.InvalidMessage_electrical_spend(le.electrical_spend_Invalid),Fields.InvalidMessage_hvac_spend(le.hvac_spend_Invalid),Fields.InvalidMessage_other_b_spend(le.other_b_spend_Invalid),Fields.InvalidMessage_plumbing_spend(le.plumbing_spend_Invalid),Fields.InvalidMessage_rs_spend(le.rs_spend_Invalid),Fields.InvalidMessage_wp_spend(le.wp_spend_Invalid),Fields.InvalidMessage_chemical_spend(le.chemical_spend_Invalid),Fields.InvalidMessage_electronic_spend(le.electronic_spend_Invalid),Fields.InvalidMessage_metal_spend(le.metal_spend_Invalid),Fields.InvalidMessage_other_m_spend(le.other_m_spend_Invalid),Fields.InvalidMessage_packaging_spend(le.packaging_spend_Invalid),Fields.InvalidMessage_pvf_spend(le.pvf_spend_Invalid),Fields.InvalidMessage_plastic_spend(le.plastic_spend_Invalid),Fields.InvalidMessage_textile_spend(le.textile_spend_Invalid),Fields.InvalidMessage_bs_spend(le.bs_spend_Invalid),Fields.InvalidMessage_ce_spend(le.ce_spend_Invalid),Fields.InvalidMessage_hardware_spend(le.hardware_spend_Invalid),Fields.InvalidMessage_ie_spend(le.ie_spend_Invalid),Fields.InvalidMessage_is_spend(le.is_spend_Invalid),Fields.InvalidMessage_it_spend(le.it_spend_Invalid),Fields.InvalidMessage_mls_spend(le.mls_spend_Invalid),Fields.InvalidMessage_os_spend(le.os_spend_Invalid),Fields.InvalidMessage_pp_spend(le.pp_spend_Invalid),Fields.InvalidMessage_sis_spend(le.sis_spend_Invalid),Fields.InvalidMessage_apparel_spend(le.apparel_spend_Invalid),Fields.InvalidMessage_beverages_spend(le.beverages_spend_Invalid),Fields.InvalidMessage_constr_spend(le.constr_spend_Invalid),Fields.InvalidMessage_consulting_spend(le.consulting_spend_Invalid),Fields.InvalidMessage_fs_spend(le.fs_spend_Invalid),Fields.InvalidMessage_fp_spend(le.fp_spend_Invalid),Fields.InvalidMessage_insurance_spend(le.insurance_spend_Invalid),Fields.InvalidMessage_ls_spend(le.ls_spend_Invalid),Fields.InvalidMessage_oil_gas_spend(le.oil_gas_spend_Invalid),Fields.InvalidMessage_utilities_spend(le.utilities_spend_Invalid),Fields.InvalidMessage_other_spend(le.other_spend_Invalid),Fields.InvalidMessage_advt_spend(le.advt_spend_Invalid),Fields.InvalidMessage_air_growth(le.air_growth_Invalid),Fields.InvalidMessage_fuel_growth(le.fuel_growth_Invalid),Fields.InvalidMessage_leasing_growth(le.leasing_growth_Invalid),Fields.InvalidMessage_ltl_growth(le.ltl_growth_Invalid),Fields.InvalidMessage_rail_growth(le.rail_growth_Invalid),Fields.InvalidMessage_tl_growth(le.tl_growth_Invalid),Fields.InvalidMessage_transvc_growth(le.transvc_growth_Invalid),Fields.InvalidMessage_transup_growth(le.transup_growth_Invalid),Fields.InvalidMessage_bst_growth(le.bst_growth_Invalid),Fields.InvalidMessage_dg_growth(le.dg_growth_Invalid),Fields.InvalidMessage_electrical_growth(le.electrical_growth_Invalid),Fields.InvalidMessage_hvac_growth(le.hvac_growth_Invalid),Fields.InvalidMessage_other_b_growth(le.other_b_growth_Invalid),Fields.InvalidMessage_plumbing_growth(le.plumbing_growth_Invalid),Fields.InvalidMessage_rs_growth(le.rs_growth_Invalid),Fields.InvalidMessage_wp_growth(le.wp_growth_Invalid),Fields.InvalidMessage_chemical_growth(le.chemical_growth_Invalid),Fields.InvalidMessage_electronic_growth(le.electronic_growth_Invalid),Fields.InvalidMessage_metal_growth(le.metal_growth_Invalid),Fields.InvalidMessage_other_m_growth(le.other_m_growth_Invalid),Fields.InvalidMessage_packaging_growth(le.packaging_growth_Invalid),Fields.InvalidMessage_pvf_growth(le.pvf_growth_Invalid),Fields.InvalidMessage_plastic_growth(le.plastic_growth_Invalid),Fields.InvalidMessage_textile_growth(le.textile_growth_Invalid),Fields.InvalidMessage_bs_growth(le.bs_growth_Invalid),Fields.InvalidMessage_ce_growth(le.ce_growth_Invalid),Fields.InvalidMessage_hardware_growth(le.hardware_growth_Invalid),Fields.InvalidMessage_ie_growth(le.ie_growth_Invalid),Fields.InvalidMessage_is_growth(le.is_growth_Invalid),Fields.InvalidMessage_it_growth(le.it_growth_Invalid),Fields.InvalidMessage_mls_growth(le.mls_growth_Invalid),Fields.InvalidMessage_os_growth(le.os_growth_Invalid),Fields.InvalidMessage_pp_growth(le.pp_growth_Invalid),Fields.InvalidMessage_sis_growth(le.sis_growth_Invalid),Fields.InvalidMessage_apparel_growth(le.apparel_growth_Invalid),Fields.InvalidMessage_beverages_growth(le.beverages_growth_Invalid),Fields.InvalidMessage_constr_growth(le.constr_growth_Invalid),Fields.InvalidMessage_consulting_growth(le.consulting_growth_Invalid),Fields.InvalidMessage_fs_growth(le.fs_growth_Invalid),Fields.InvalidMessage_fp_growth(le.fp_growth_Invalid),Fields.InvalidMessage_insurance_growth(le.insurance_growth_Invalid),Fields.InvalidMessage_ls_growth(le.ls_growth_Invalid),Fields.InvalidMessage_oil_gas_growth(le.oil_gas_growth_Invalid),Fields.InvalidMessage_utilities_growth(le.utilities_growth_Invalid),Fields.InvalidMessage_other_growth(le.other_growth_Invalid),Fields.InvalidMessage_advt_growth(le.advt_growth_Invalid),Fields.InvalidMessage_top5_growth(le.top5_growth_Invalid),Fields.InvalidMessage_shipping_y1(le.shipping_y1_Invalid),Fields.InvalidMessage_shipping_growth(le.shipping_growth_Invalid),Fields.InvalidMessage_materials_y1(le.materials_y1_Invalid),Fields.InvalidMessage_materials_growth(le.materials_growth_Invalid),Fields.InvalidMessage_operations_y1(le.operations_y1_Invalid),Fields.InvalidMessage_operations_growth(le.operations_growth_Invalid),Fields.InvalidMessage_total_paid_average_0t12(le.total_paid_average_0t12_Invalid),Fields.InvalidMessage_total_paid_monthspastworst_24(le.total_paid_monthspastworst_24_Invalid),Fields.InvalidMessage_total_paid_slope_0t12(le.total_paid_slope_0t12_Invalid),Fields.InvalidMessage_total_paid_slope_0t6(le.total_paid_slope_0t6_Invalid),Fields.InvalidMessage_total_paid_slope_6t12(le.total_paid_slope_6t12_Invalid),Fields.InvalidMessage_total_paid_slope_6t18(le.total_paid_slope_6t18_Invalid),Fields.InvalidMessage_total_paid_volatility_0t12(le.total_paid_volatility_0t12_Invalid),Fields.InvalidMessage_total_paid_volatility_0t6(le.total_paid_volatility_0t6_Invalid),Fields.InvalidMessage_total_paid_volatility_12t18(le.total_paid_volatility_12t18_Invalid),Fields.InvalidMessage_total_paid_volatility_6t12(le.total_paid_volatility_6t12_Invalid),Fields.InvalidMessage_total_spend_monthspastleast_24(le.total_spend_monthspastleast_24_Invalid),Fields.InvalidMessage_total_spend_monthspastmost_24(le.total_spend_monthspastmost_24_Invalid),Fields.InvalidMessage_total_spend_slope_0t12(le.total_spend_slope_0t12_Invalid),Fields.InvalidMessage_total_spend_slope_0t24(le.total_spend_slope_0t24_Invalid),Fields.InvalidMessage_total_spend_slope_0t6(le.total_spend_slope_0t6_Invalid),Fields.InvalidMessage_total_spend_slope_6t12(le.total_spend_slope_6t12_Invalid),Fields.InvalidMessage_total_spend_sum_12(le.total_spend_sum_12_Invalid),Fields.InvalidMessage_total_spend_volatility_0t12(le.total_spend_volatility_0t12_Invalid),Fields.InvalidMessage_total_spend_volatility_0t6(le.total_spend_volatility_0t6_Invalid),Fields.InvalidMessage_total_spend_volatility_12t18(le.total_spend_volatility_12t18_Invalid),Fields.InvalidMessage_total_spend_volatility_6t12(le.total_spend_volatility_6t12_Invalid),Fields.InvalidMessage_mfgmat_paid_average_12(le.mfgmat_paid_average_12_Invalid),Fields.InvalidMessage_mfgmat_paid_monthspastworst_24(le.mfgmat_paid_monthspastworst_24_Invalid),Fields.InvalidMessage_mfgmat_paid_slope_0t12(le.mfgmat_paid_slope_0t12_Invalid),Fields.InvalidMessage_mfgmat_paid_slope_0t24(le.mfgmat_paid_slope_0t24_Invalid),Fields.InvalidMessage_mfgmat_paid_slope_0t6(le.mfgmat_paid_slope_0t6_Invalid),Fields.InvalidMessage_mfgmat_paid_volatility_0t12(le.mfgmat_paid_volatility_0t12_Invalid),Fields.InvalidMessage_mfgmat_paid_volatility_0t6(le.mfgmat_paid_volatility_0t6_Invalid),Fields.InvalidMessage_mfgmat_spend_monthspastleast_24(le.mfgmat_spend_monthspastleast_24_Invalid),Fields.InvalidMessage_mfgmat_spend_monthspastmost_24(le.mfgmat_spend_monthspastmost_24_Invalid),Fields.InvalidMessage_mfgmat_spend_slope_0t12(le.mfgmat_spend_slope_0t12_Invalid),Fields.InvalidMessage_mfgmat_spend_slope_0t24(le.mfgmat_spend_slope_0t24_Invalid),Fields.InvalidMessage_mfgmat_spend_slope_0t6(le.mfgmat_spend_slope_0t6_Invalid),Fields.InvalidMessage_mfgmat_spend_sum_12(le.mfgmat_spend_sum_12_Invalid),Fields.InvalidMessage_mfgmat_spend_volatility_0t6(le.mfgmat_spend_volatility_0t6_Invalid),Fields.InvalidMessage_mfgmat_spend_volatility_6t12(le.mfgmat_spend_volatility_6t12_Invalid),Fields.InvalidMessage_ops_paid_average_12(le.ops_paid_average_12_Invalid),Fields.InvalidMessage_ops_paid_monthspastworst_24(le.ops_paid_monthspastworst_24_Invalid),Fields.InvalidMessage_ops_paid_slope_0t12(le.ops_paid_slope_0t12_Invalid),Fields.InvalidMessage_ops_paid_slope_0t24(le.ops_paid_slope_0t24_Invalid),Fields.InvalidMessage_ops_paid_slope_0t6(le.ops_paid_slope_0t6_Invalid),Fields.InvalidMessage_ops_paid_volatility_0t12(le.ops_paid_volatility_0t12_Invalid),Fields.InvalidMessage_ops_paid_volatility_0t6(le.ops_paid_volatility_0t6_Invalid),Fields.InvalidMessage_ops_spend_monthspastleast_24(le.ops_spend_monthspastleast_24_Invalid),Fields.InvalidMessage_ops_spend_monthspastmost_24(le.ops_spend_monthspastmost_24_Invalid),Fields.InvalidMessage_ops_spend_slope_0t12(le.ops_spend_slope_0t12_Invalid),Fields.InvalidMessage_ops_spend_slope_0t24(le.ops_spend_slope_0t24_Invalid),Fields.InvalidMessage_ops_spend_slope_0t6(le.ops_spend_slope_0t6_Invalid),Fields.InvalidMessage_fleet_paid_monthspastworst_24(le.fleet_paid_monthspastworst_24_Invalid),Fields.InvalidMessage_fleet_paid_slope_0t12(le.fleet_paid_slope_0t12_Invalid),Fields.InvalidMessage_fleet_paid_slope_0t24(le.fleet_paid_slope_0t24_Invalid),Fields.InvalidMessage_fleet_paid_slope_0t6(le.fleet_paid_slope_0t6_Invalid),Fields.InvalidMessage_fleet_paid_volatility_0t12(le.fleet_paid_volatility_0t12_Invalid),Fields.InvalidMessage_fleet_paid_volatility_0t6(le.fleet_paid_volatility_0t6_Invalid),Fields.InvalidMessage_fleet_spend_slope_0t12(le.fleet_spend_slope_0t12_Invalid),Fields.InvalidMessage_fleet_spend_slope_0t24(le.fleet_spend_slope_0t24_Invalid),Fields.InvalidMessage_fleet_spend_slope_0t6(le.fleet_spend_slope_0t6_Invalid),Fields.InvalidMessage_carrier_paid_slope_0t12(le.carrier_paid_slope_0t12_Invalid),Fields.InvalidMessage_carrier_paid_slope_0t24(le.carrier_paid_slope_0t24_Invalid),Fields.InvalidMessage_carrier_paid_slope_0t6(le.carrier_paid_slope_0t6_Invalid),Fields.InvalidMessage_carrier_paid_volatility_0t12(le.carrier_paid_volatility_0t12_Invalid),Fields.InvalidMessage_carrier_paid_volatility_0t6(le.carrier_paid_volatility_0t6_Invalid),Fields.InvalidMessage_carrier_spend_slope_0t12(le.carrier_spend_slope_0t12_Invalid),Fields.InvalidMessage_carrier_spend_slope_0t24(le.carrier_spend_slope_0t24_Invalid),Fields.InvalidMessage_carrier_spend_slope_0t6(le.carrier_spend_slope_0t6_Invalid),Fields.InvalidMessage_carrier_spend_volatility_0t6(le.carrier_spend_volatility_0t6_Invalid),Fields.InvalidMessage_carrier_spend_volatility_6t12(le.carrier_spend_volatility_6t12_Invalid),Fields.InvalidMessage_bldgmats_paid_slope_0t12(le.bldgmats_paid_slope_0t12_Invalid),Fields.InvalidMessage_bldgmats_paid_slope_0t24(le.bldgmats_paid_slope_0t24_Invalid),Fields.InvalidMessage_bldgmats_paid_slope_0t6(le.bldgmats_paid_slope_0t6_Invalid),Fields.InvalidMessage_bldgmats_paid_volatility_0t12(le.bldgmats_paid_volatility_0t12_Invalid),Fields.InvalidMessage_bldgmats_paid_volatility_0t6(le.bldgmats_paid_volatility_0t6_Invalid),Fields.InvalidMessage_bldgmats_spend_slope_0t12(le.bldgmats_spend_slope_0t12_Invalid),Fields.InvalidMessage_bldgmats_spend_slope_0t24(le.bldgmats_spend_slope_0t24_Invalid),Fields.InvalidMessage_bldgmats_spend_slope_0t6(le.bldgmats_spend_slope_0t6_Invalid),Fields.InvalidMessage_bldgmats_spend_volatility_0t6(le.bldgmats_spend_volatility_0t6_Invalid),Fields.InvalidMessage_bldgmats_spend_volatility_6t12(le.bldgmats_spend_volatility_6t12_Invalid),Fields.InvalidMessage_top5_paid_slope_0t12(le.top5_paid_slope_0t12_Invalid),Fields.InvalidMessage_top5_paid_slope_0t24(le.top5_paid_slope_0t24_Invalid),Fields.InvalidMessage_top5_paid_slope_0t6(le.top5_paid_slope_0t6_Invalid),Fields.InvalidMessage_top5_paid_volatility_0t12(le.top5_paid_volatility_0t12_Invalid),Fields.InvalidMessage_top5_paid_volatility_0t6(le.top5_paid_volatility_0t6_Invalid),Fields.InvalidMessage_top5_spend_slope_0t12(le.top5_spend_slope_0t12_Invalid),Fields.InvalidMessage_top5_spend_slope_0t24(le.top5_spend_slope_0t24_Invalid),Fields.InvalidMessage_top5_spend_slope_0t6(le.top5_spend_slope_0t6_Invalid),Fields.InvalidMessage_top5_spend_volatility_0t6(le.top5_spend_volatility_0t6_Invalid),Fields.InvalidMessage_top5_spend_volatility_6t12(le.top5_spend_volatility_6t12_Invalid),Fields.InvalidMessage_total_numrel_slope_0t12(le.total_numrel_slope_0t12_Invalid),Fields.InvalidMessage_total_numrel_slope_0t24(le.total_numrel_slope_0t24_Invalid),Fields.InvalidMessage_total_numrel_slope_0t6(le.total_numrel_slope_0t6_Invalid),Fields.InvalidMessage_total_numrel_slope_6t12(le.total_numrel_slope_6t12_Invalid),Fields.InvalidMessage_mfgmat_numrel_slope_0t12(le.mfgmat_numrel_slope_0t12_Invalid),Fields.InvalidMessage_mfgmat_numrel_slope_0t24(le.mfgmat_numrel_slope_0t24_Invalid),Fields.InvalidMessage_mfgmat_numrel_slope_0t6(le.mfgmat_numrel_slope_0t6_Invalid),Fields.InvalidMessage_mfgmat_numrel_slope_6t12(le.mfgmat_numrel_slope_6t12_Invalid),Fields.InvalidMessage_ops_numrel_slope_0t12(le.ops_numrel_slope_0t12_Invalid),Fields.InvalidMessage_ops_numrel_slope_0t24(le.ops_numrel_slope_0t24_Invalid),Fields.InvalidMessage_ops_numrel_slope_0t6(le.ops_numrel_slope_0t6_Invalid),Fields.InvalidMessage_ops_numrel_slope_6t12(le.ops_numrel_slope_6t12_Invalid),Fields.InvalidMessage_fleet_numrel_slope_0t12(le.fleet_numrel_slope_0t12_Invalid),Fields.InvalidMessage_fleet_numrel_slope_0t24(le.fleet_numrel_slope_0t24_Invalid),Fields.InvalidMessage_fleet_numrel_slope_0t6(le.fleet_numrel_slope_0t6_Invalid),Fields.InvalidMessage_fleet_numrel_slope_6t12(le.fleet_numrel_slope_6t12_Invalid),Fields.InvalidMessage_carrier_numrel_slope_0t12(le.carrier_numrel_slope_0t12_Invalid),Fields.InvalidMessage_carrier_numrel_slope_0t24(le.carrier_numrel_slope_0t24_Invalid),Fields.InvalidMessage_carrier_numrel_slope_0t6(le.carrier_numrel_slope_0t6_Invalid),Fields.InvalidMessage_carrier_numrel_slope_6t12(le.carrier_numrel_slope_6t12_Invalid),Fields.InvalidMessage_bldgmats_numrel_slope_0t12(le.bldgmats_numrel_slope_0t12_Invalid),Fields.InvalidMessage_bldgmats_numrel_slope_0t24(le.bldgmats_numrel_slope_0t24_Invalid),Fields.InvalidMessage_bldgmats_numrel_slope_0t6(le.bldgmats_numrel_slope_0t6_Invalid),Fields.InvalidMessage_bldgmats_numrel_slope_6t12(le.bldgmats_numrel_slope_6t12_Invalid),Fields.InvalidMessage_bldgmats_numrel_var_0t12(le.bldgmats_numrel_var_0t12_Invalid),Fields.InvalidMessage_bldgmats_numrel_var_12t24(le.bldgmats_numrel_var_12t24_Invalid),Fields.InvalidMessage_total_percprov30_slope_0t12(le.total_percprov30_slope_0t12_Invalid),Fields.InvalidMessage_total_percprov30_slope_0t24(le.total_percprov30_slope_0t24_Invalid),Fields.InvalidMessage_total_percprov30_slope_0t6(le.total_percprov30_slope_0t6_Invalid),Fields.InvalidMessage_total_percprov30_slope_6t12(le.total_percprov30_slope_6t12_Invalid),Fields.InvalidMessage_total_percprov60_slope_0t12(le.total_percprov60_slope_0t12_Invalid),Fields.InvalidMessage_total_percprov60_slope_0t24(le.total_percprov60_slope_0t24_Invalid),Fields.InvalidMessage_total_percprov60_slope_0t6(le.total_percprov60_slope_0t6_Invalid),Fields.InvalidMessage_total_percprov60_slope_6t12(le.total_percprov60_slope_6t12_Invalid),Fields.InvalidMessage_total_percprov90_slope_0t24(le.total_percprov90_slope_0t24_Invalid),Fields.InvalidMessage_total_percprov90_slope_0t6(le.total_percprov90_slope_0t6_Invalid),Fields.InvalidMessage_total_percprov90_slope_6t12(le.total_percprov90_slope_6t12_Invalid),Fields.InvalidMessage_mfgmat_percprov30_slope_0t12(le.mfgmat_percprov30_slope_0t12_Invalid),Fields.InvalidMessage_mfgmat_percprov30_slope_6t12(le.mfgmat_percprov30_slope_6t12_Invalid),Fields.InvalidMessage_mfgmat_percprov60_slope_0t12(le.mfgmat_percprov60_slope_0t12_Invalid),Fields.InvalidMessage_mfgmat_percprov60_slope_6t12(le.mfgmat_percprov60_slope_6t12_Invalid),Fields.InvalidMessage_mfgmat_percprov90_slope_0t24(le.mfgmat_percprov90_slope_0t24_Invalid),Fields.InvalidMessage_mfgmat_percprov90_slope_0t6(le.mfgmat_percprov90_slope_0t6_Invalid),Fields.InvalidMessage_mfgmat_percprov90_slope_6t12(le.mfgmat_percprov90_slope_6t12_Invalid),Fields.InvalidMessage_ops_percprov30_slope_0t12(le.ops_percprov30_slope_0t12_Invalid),Fields.InvalidMessage_ops_percprov30_slope_6t12(le.ops_percprov30_slope_6t12_Invalid),Fields.InvalidMessage_ops_percprov60_slope_0t12(le.ops_percprov60_slope_0t12_Invalid),Fields.InvalidMessage_ops_percprov60_slope_6t12(le.ops_percprov60_slope_6t12_Invalid),Fields.InvalidMessage_ops_percprov90_slope_0t24(le.ops_percprov90_slope_0t24_Invalid),Fields.InvalidMessage_ops_percprov90_slope_0t6(le.ops_percprov90_slope_0t6_Invalid),Fields.InvalidMessage_ops_percprov90_slope_6t12(le.ops_percprov90_slope_6t12_Invalid),Fields.InvalidMessage_fleet_percprov30_slope_0t12(le.fleet_percprov30_slope_0t12_Invalid),Fields.InvalidMessage_fleet_percprov30_slope_6t12(le.fleet_percprov30_slope_6t12_Invalid),Fields.InvalidMessage_fleet_percprov60_slope_0t12(le.fleet_percprov60_slope_0t12_Invalid),Fields.InvalidMessage_fleet_percprov60_slope_6t12(le.fleet_percprov60_slope_6t12_Invalid),Fields.InvalidMessage_fleet_percprov90_slope_0t24(le.fleet_percprov90_slope_0t24_Invalid),Fields.InvalidMessage_fleet_percprov90_slope_0t6(le.fleet_percprov90_slope_0t6_Invalid),Fields.InvalidMessage_fleet_percprov90_slope_6t12(le.fleet_percprov90_slope_6t12_Invalid),Fields.InvalidMessage_carrier_percprov30_slope_0t12(le.carrier_percprov30_slope_0t12_Invalid),Fields.InvalidMessage_carrier_percprov30_slope_6t12(le.carrier_percprov30_slope_6t12_Invalid),Fields.InvalidMessage_carrier_percprov60_slope_0t12(le.carrier_percprov60_slope_0t12_Invalid),Fields.InvalidMessage_carrier_percprov60_slope_6t12(le.carrier_percprov60_slope_6t12_Invalid),Fields.InvalidMessage_carrier_percprov90_slope_0t24(le.carrier_percprov90_slope_0t24_Invalid),Fields.InvalidMessage_carrier_percprov90_slope_0t6(le.carrier_percprov90_slope_0t6_Invalid),Fields.InvalidMessage_carrier_percprov90_slope_6t12(le.carrier_percprov90_slope_6t12_Invalid),Fields.InvalidMessage_bldgmats_percprov30_slope_0t12(le.bldgmats_percprov30_slope_0t12_Invalid),Fields.InvalidMessage_bldgmats_percprov30_slope_6t12(le.bldgmats_percprov30_slope_6t12_Invalid),Fields.InvalidMessage_bldgmats_percprov60_slope_0t12(le.bldgmats_percprov60_slope_0t12_Invalid),Fields.InvalidMessage_bldgmats_percprov60_slope_6t12(le.bldgmats_percprov60_slope_6t12_Invalid),Fields.InvalidMessage_bldgmats_percprov90_slope_0t24(le.bldgmats_percprov90_slope_0t24_Invalid),Fields.InvalidMessage_bldgmats_percprov90_slope_0t6(le.bldgmats_percprov90_slope_0t6_Invalid),Fields.InvalidMessage_bldgmats_percprov90_slope_6t12(le.bldgmats_percprov90_slope_6t12_Invalid),Fields.InvalidMessage_top5_percprov30_slope_0t12(le.top5_percprov30_slope_0t12_Invalid),Fields.InvalidMessage_top5_percprov30_slope_6t12(le.top5_percprov30_slope_6t12_Invalid),Fields.InvalidMessage_top5_percprov60_slope_0t12(le.top5_percprov60_slope_0t12_Invalid),Fields.InvalidMessage_top5_percprov60_slope_6t12(le.top5_percprov60_slope_6t12_Invalid),Fields.InvalidMessage_top5_percprov90_slope_0t24(le.top5_percprov90_slope_0t24_Invalid),Fields.InvalidMessage_top5_percprov90_slope_0t6(le.top5_percprov90_slope_0t6_Invalid),Fields.InvalidMessage_top5_percprov90_slope_6t12(le.top5_percprov90_slope_6t12_Invalid),Fields.InvalidMessage_top5_percprovoutstanding_adjustedslope_0t12(le.top5_percprovoutstanding_adjustedslope_0t12_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.ultimate_linkid_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cortera_score_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cpr_score_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cpr_segment_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dbt_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.avg_bal_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.air_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fuel_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.leasing_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ltl_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.rail_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.tl_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.transvc_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.transup_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bst_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dg_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.electrical_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.hvac_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.other_b_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.plumbing_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.rs_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.wp_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.chemical_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.electronic_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.metal_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.other_m_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.packaging_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.pvf_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.plastic_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.textile_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bs_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ce_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.hardware_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ie_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.is_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.it_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mls_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.os_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.pp_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.sis_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.apparel_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.beverages_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.constr_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.consulting_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fs_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fp_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.insurance_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ls_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.oil_gas_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.utilities_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.other_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.advt_spend_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.air_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fuel_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.leasing_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ltl_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.rail_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.tl_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.transvc_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.transup_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bst_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dg_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.electrical_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.hvac_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.other_b_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.plumbing_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.rs_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.wp_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.chemical_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.electronic_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.metal_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.other_m_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.packaging_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.pvf_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.plastic_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.textile_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bs_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ce_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.hardware_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ie_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.is_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.it_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mls_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.os_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.pp_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.sis_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.apparel_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.beverages_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.constr_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.consulting_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fs_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fp_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.insurance_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ls_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.oil_gas_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.utilities_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.other_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.advt_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.top5_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.shipping_y1_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.shipping_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.materials_y1_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.materials_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.operations_y1_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.operations_growth_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_paid_average_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_paid_monthspastworst_24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_paid_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_paid_slope_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_paid_slope_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_paid_slope_6t18_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_paid_volatility_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_paid_volatility_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_paid_volatility_12t18_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_paid_volatility_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_spend_monthspastleast_24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_spend_monthspastmost_24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_spend_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_spend_slope_0t24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_spend_slope_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_spend_slope_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_spend_sum_12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_spend_volatility_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_spend_volatility_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_spend_volatility_12t18_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_spend_volatility_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mfgmat_paid_average_12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mfgmat_paid_monthspastworst_24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mfgmat_paid_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mfgmat_paid_slope_0t24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mfgmat_paid_slope_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mfgmat_paid_volatility_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mfgmat_paid_volatility_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mfgmat_spend_monthspastleast_24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mfgmat_spend_monthspastmost_24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mfgmat_spend_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mfgmat_spend_slope_0t24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mfgmat_spend_slope_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mfgmat_spend_sum_12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mfgmat_spend_volatility_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mfgmat_spend_volatility_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ops_paid_average_12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ops_paid_monthspastworst_24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ops_paid_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ops_paid_slope_0t24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ops_paid_slope_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ops_paid_volatility_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ops_paid_volatility_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ops_spend_monthspastleast_24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ops_spend_monthspastmost_24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ops_spend_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ops_spend_slope_0t24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ops_spend_slope_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fleet_paid_monthspastworst_24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fleet_paid_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fleet_paid_slope_0t24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fleet_paid_slope_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fleet_paid_volatility_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fleet_paid_volatility_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fleet_spend_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fleet_spend_slope_0t24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fleet_spend_slope_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.carrier_paid_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.carrier_paid_slope_0t24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.carrier_paid_slope_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.carrier_paid_volatility_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.carrier_paid_volatility_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.carrier_spend_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.carrier_spend_slope_0t24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.carrier_spend_slope_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.carrier_spend_volatility_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.carrier_spend_volatility_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bldgmats_paid_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bldgmats_paid_slope_0t24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bldgmats_paid_slope_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bldgmats_paid_volatility_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bldgmats_paid_volatility_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bldgmats_spend_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bldgmats_spend_slope_0t24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bldgmats_spend_slope_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bldgmats_spend_volatility_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bldgmats_spend_volatility_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.top5_paid_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.top5_paid_slope_0t24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.top5_paid_slope_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.top5_paid_volatility_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.top5_paid_volatility_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.top5_spend_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.top5_spend_slope_0t24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.top5_spend_slope_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.top5_spend_volatility_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.top5_spend_volatility_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_numrel_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_numrel_slope_0t24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_numrel_slope_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_numrel_slope_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mfgmat_numrel_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mfgmat_numrel_slope_0t24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mfgmat_numrel_slope_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mfgmat_numrel_slope_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ops_numrel_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ops_numrel_slope_0t24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ops_numrel_slope_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ops_numrel_slope_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fleet_numrel_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fleet_numrel_slope_0t24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fleet_numrel_slope_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fleet_numrel_slope_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.carrier_numrel_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.carrier_numrel_slope_0t24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.carrier_numrel_slope_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.carrier_numrel_slope_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bldgmats_numrel_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bldgmats_numrel_slope_0t24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bldgmats_numrel_slope_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bldgmats_numrel_slope_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bldgmats_numrel_var_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bldgmats_numrel_var_12t24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_percprov30_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_percprov30_slope_0t24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_percprov30_slope_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_percprov30_slope_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_percprov60_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_percprov60_slope_0t24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_percprov60_slope_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_percprov60_slope_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_percprov90_slope_0t24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_percprov90_slope_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.total_percprov90_slope_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mfgmat_percprov30_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mfgmat_percprov30_slope_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mfgmat_percprov60_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mfgmat_percprov60_slope_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mfgmat_percprov90_slope_0t24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mfgmat_percprov90_slope_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mfgmat_percprov90_slope_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ops_percprov30_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ops_percprov30_slope_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ops_percprov60_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ops_percprov60_slope_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ops_percprov90_slope_0t24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ops_percprov90_slope_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ops_percprov90_slope_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fleet_percprov30_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fleet_percprov30_slope_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fleet_percprov60_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fleet_percprov60_slope_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fleet_percprov90_slope_0t24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fleet_percprov90_slope_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fleet_percprov90_slope_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.carrier_percprov30_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.carrier_percprov30_slope_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.carrier_percprov60_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.carrier_percprov60_slope_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.carrier_percprov90_slope_0t24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.carrier_percprov90_slope_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.carrier_percprov90_slope_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bldgmats_percprov30_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bldgmats_percprov30_slope_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bldgmats_percprov60_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bldgmats_percprov60_slope_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bldgmats_percprov90_slope_0t24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bldgmats_percprov90_slope_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bldgmats_percprov90_slope_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.top5_percprov30_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.top5_percprov30_slope_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.top5_percprov60_slope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.top5_percprov60_slope_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.top5_percprov90_slope_0t24_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.top5_percprov90_slope_0t6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.top5_percprov90_slope_6t12_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.top5_percprovoutstanding_adjustedslope_0t12_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'ultimate_linkid','cortera_score','cpr_score','cpr_segment','dbt','avg_bal','air_spend','fuel_spend','leasing_spend','ltl_spend','rail_spend','tl_spend','transvc_spend','transup_spend','bst_spend','dg_spend','electrical_spend','hvac_spend','other_b_spend','plumbing_spend','rs_spend','wp_spend','chemical_spend','electronic_spend','metal_spend','other_m_spend','packaging_spend','pvf_spend','plastic_spend','textile_spend','bs_spend','ce_spend','hardware_spend','ie_spend','is_spend','it_spend','mls_spend','os_spend','pp_spend','sis_spend','apparel_spend','beverages_spend','constr_spend','consulting_spend','fs_spend','fp_spend','insurance_spend','ls_spend','oil_gas_spend','utilities_spend','other_spend','advt_spend','air_growth','fuel_growth','leasing_growth','ltl_growth','rail_growth','tl_growth','transvc_growth','transup_growth','bst_growth','dg_growth','electrical_growth','hvac_growth','other_b_growth','plumbing_growth','rs_growth','wp_growth','chemical_growth','electronic_growth','metal_growth','other_m_growth','packaging_growth','pvf_growth','plastic_growth','textile_growth','bs_growth','ce_growth','hardware_growth','ie_growth','is_growth','it_growth','mls_growth','os_growth','pp_growth','sis_growth','apparel_growth','beverages_growth','constr_growth','consulting_growth','fs_growth','fp_growth','insurance_growth','ls_growth','oil_gas_growth','utilities_growth','other_growth','advt_growth','top5_growth','shipping_y1','shipping_growth','materials_y1','materials_growth','operations_y1','operations_growth','total_paid_average_0t12','total_paid_monthspastworst_24','total_paid_slope_0t12','total_paid_slope_0t6','total_paid_slope_6t12','total_paid_slope_6t18','total_paid_volatility_0t12','total_paid_volatility_0t6','total_paid_volatility_12t18','total_paid_volatility_6t12','total_spend_monthspastleast_24','total_spend_monthspastmost_24','total_spend_slope_0t12','total_spend_slope_0t24','total_spend_slope_0t6','total_spend_slope_6t12','total_spend_sum_12','total_spend_volatility_0t12','total_spend_volatility_0t6','total_spend_volatility_12t18','total_spend_volatility_6t12','mfgmat_paid_average_12','mfgmat_paid_monthspastworst_24','mfgmat_paid_slope_0t12','mfgmat_paid_slope_0t24','mfgmat_paid_slope_0t6','mfgmat_paid_volatility_0t12','mfgmat_paid_volatility_0t6','mfgmat_spend_monthspastleast_24','mfgmat_spend_monthspastmost_24','mfgmat_spend_slope_0t12','mfgmat_spend_slope_0t24','mfgmat_spend_slope_0t6','mfgmat_spend_sum_12','mfgmat_spend_volatility_0t6','mfgmat_spend_volatility_6t12','ops_paid_average_12','ops_paid_monthspastworst_24','ops_paid_slope_0t12','ops_paid_slope_0t24','ops_paid_slope_0t6','ops_paid_volatility_0t12','ops_paid_volatility_0t6','ops_spend_monthspastleast_24','ops_spend_monthspastmost_24','ops_spend_slope_0t12','ops_spend_slope_0t24','ops_spend_slope_0t6','fleet_paid_monthspastworst_24','fleet_paid_slope_0t12','fleet_paid_slope_0t24','fleet_paid_slope_0t6','fleet_paid_volatility_0t12','fleet_paid_volatility_0t6','fleet_spend_slope_0t12','fleet_spend_slope_0t24','fleet_spend_slope_0t6','carrier_paid_slope_0t12','carrier_paid_slope_0t24','carrier_paid_slope_0t6','carrier_paid_volatility_0t12','carrier_paid_volatility_0t6','carrier_spend_slope_0t12','carrier_spend_slope_0t24','carrier_spend_slope_0t6','carrier_spend_volatility_0t6','carrier_spend_volatility_6t12','bldgmats_paid_slope_0t12','bldgmats_paid_slope_0t24','bldgmats_paid_slope_0t6','bldgmats_paid_volatility_0t12','bldgmats_paid_volatility_0t6','bldgmats_spend_slope_0t12','bldgmats_spend_slope_0t24','bldgmats_spend_slope_0t6','bldgmats_spend_volatility_0t6','bldgmats_spend_volatility_6t12','top5_paid_slope_0t12','top5_paid_slope_0t24','top5_paid_slope_0t6','top5_paid_volatility_0t12','top5_paid_volatility_0t6','top5_spend_slope_0t12','top5_spend_slope_0t24','top5_spend_slope_0t6','top5_spend_volatility_0t6','top5_spend_volatility_6t12','total_numrel_slope_0t12','total_numrel_slope_0t24','total_numrel_slope_0t6','total_numrel_slope_6t12','mfgmat_numrel_slope_0t12','mfgmat_numrel_slope_0t24','mfgmat_numrel_slope_0t6','mfgmat_numrel_slope_6t12','ops_numrel_slope_0t12','ops_numrel_slope_0t24','ops_numrel_slope_0t6','ops_numrel_slope_6t12','fleet_numrel_slope_0t12','fleet_numrel_slope_0t24','fleet_numrel_slope_0t6','fleet_numrel_slope_6t12','carrier_numrel_slope_0t12','carrier_numrel_slope_0t24','carrier_numrel_slope_0t6','carrier_numrel_slope_6t12','bldgmats_numrel_slope_0t12','bldgmats_numrel_slope_0t24','bldgmats_numrel_slope_0t6','bldgmats_numrel_slope_6t12','bldgmats_numrel_var_0t12','bldgmats_numrel_var_12t24','total_percprov30_slope_0t12','total_percprov30_slope_0t24','total_percprov30_slope_0t6','total_percprov30_slope_6t12','total_percprov60_slope_0t12','total_percprov60_slope_0t24','total_percprov60_slope_0t6','total_percprov60_slope_6t12','total_percprov90_slope_0t24','total_percprov90_slope_0t6','total_percprov90_slope_6t12','mfgmat_percprov30_slope_0t12','mfgmat_percprov30_slope_6t12','mfgmat_percprov60_slope_0t12','mfgmat_percprov60_slope_6t12','mfgmat_percprov90_slope_0t24','mfgmat_percprov90_slope_0t6','mfgmat_percprov90_slope_6t12','ops_percprov30_slope_0t12','ops_percprov30_slope_6t12','ops_percprov60_slope_0t12','ops_percprov60_slope_6t12','ops_percprov90_slope_0t24','ops_percprov90_slope_0t6','ops_percprov90_slope_6t12','fleet_percprov30_slope_0t12','fleet_percprov30_slope_6t12','fleet_percprov60_slope_0t12','fleet_percprov60_slope_6t12','fleet_percprov90_slope_0t24','fleet_percprov90_slope_0t6','fleet_percprov90_slope_6t12','carrier_percprov30_slope_0t12','carrier_percprov30_slope_6t12','carrier_percprov60_slope_0t12','carrier_percprov60_slope_6t12','carrier_percprov90_slope_0t24','carrier_percprov90_slope_0t6','carrier_percprov90_slope_6t12','bldgmats_percprov30_slope_0t12','bldgmats_percprov30_slope_6t12','bldgmats_percprov60_slope_0t12','bldgmats_percprov60_slope_6t12','bldgmats_percprov90_slope_0t24','bldgmats_percprov90_slope_0t6','bldgmats_percprov90_slope_6t12','top5_percprov30_slope_0t12','top5_percprov30_slope_6t12','top5_percprov60_slope_0t12','top5_percprov60_slope_6t12','top5_percprov90_slope_0t24','top5_percprov90_slope_0t6','top5_percprov90_slope_6t12','top5_percprovoutstanding_adjustedslope_0t12','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Number','Number','Number','Number','Ratio','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Number','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Number','Ratio','Number','Ratio','Number','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Number','Number','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Number','Ratio','Ratio','Ratio','Ratio','Ratio','Number','Number','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Number','Number','Ratio','Ratio','Ratio','Number','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','Ratio','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT36.StrType)le.ultimate_linkid,(SALT36.StrType)le.cortera_score,(SALT36.StrType)le.cpr_score,(SALT36.StrType)le.cpr_segment,(SALT36.StrType)le.dbt,(SALT36.StrType)le.avg_bal,(SALT36.StrType)le.air_spend,(SALT36.StrType)le.fuel_spend,(SALT36.StrType)le.leasing_spend,(SALT36.StrType)le.ltl_spend,(SALT36.StrType)le.rail_spend,(SALT36.StrType)le.tl_spend,(SALT36.StrType)le.transvc_spend,(SALT36.StrType)le.transup_spend,(SALT36.StrType)le.bst_spend,(SALT36.StrType)le.dg_spend,(SALT36.StrType)le.electrical_spend,(SALT36.StrType)le.hvac_spend,(SALT36.StrType)le.other_b_spend,(SALT36.StrType)le.plumbing_spend,(SALT36.StrType)le.rs_spend,(SALT36.StrType)le.wp_spend,(SALT36.StrType)le.chemical_spend,(SALT36.StrType)le.electronic_spend,(SALT36.StrType)le.metal_spend,(SALT36.StrType)le.other_m_spend,(SALT36.StrType)le.packaging_spend,(SALT36.StrType)le.pvf_spend,(SALT36.StrType)le.plastic_spend,(SALT36.StrType)le.textile_spend,(SALT36.StrType)le.bs_spend,(SALT36.StrType)le.ce_spend,(SALT36.StrType)le.hardware_spend,(SALT36.StrType)le.ie_spend,(SALT36.StrType)le.is_spend,(SALT36.StrType)le.it_spend,(SALT36.StrType)le.mls_spend,(SALT36.StrType)le.os_spend,(SALT36.StrType)le.pp_spend,(SALT36.StrType)le.sis_spend,(SALT36.StrType)le.apparel_spend,(SALT36.StrType)le.beverages_spend,(SALT36.StrType)le.constr_spend,(SALT36.StrType)le.consulting_spend,(SALT36.StrType)le.fs_spend,(SALT36.StrType)le.fp_spend,(SALT36.StrType)le.insurance_spend,(SALT36.StrType)le.ls_spend,(SALT36.StrType)le.oil_gas_spend,(SALT36.StrType)le.utilities_spend,(SALT36.StrType)le.other_spend,(SALT36.StrType)le.advt_spend,(SALT36.StrType)le.air_growth,(SALT36.StrType)le.fuel_growth,(SALT36.StrType)le.leasing_growth,(SALT36.StrType)le.ltl_growth,(SALT36.StrType)le.rail_growth,(SALT36.StrType)le.tl_growth,(SALT36.StrType)le.transvc_growth,(SALT36.StrType)le.transup_growth,(SALT36.StrType)le.bst_growth,(SALT36.StrType)le.dg_growth,(SALT36.StrType)le.electrical_growth,(SALT36.StrType)le.hvac_growth,(SALT36.StrType)le.other_b_growth,(SALT36.StrType)le.plumbing_growth,(SALT36.StrType)le.rs_growth,(SALT36.StrType)le.wp_growth,(SALT36.StrType)le.chemical_growth,(SALT36.StrType)le.electronic_growth,(SALT36.StrType)le.metal_growth,(SALT36.StrType)le.other_m_growth,(SALT36.StrType)le.packaging_growth,(SALT36.StrType)le.pvf_growth,(SALT36.StrType)le.plastic_growth,(SALT36.StrType)le.textile_growth,(SALT36.StrType)le.bs_growth,(SALT36.StrType)le.ce_growth,(SALT36.StrType)le.hardware_growth,(SALT36.StrType)le.ie_growth,(SALT36.StrType)le.is_growth,(SALT36.StrType)le.it_growth,(SALT36.StrType)le.mls_growth,(SALT36.StrType)le.os_growth,(SALT36.StrType)le.pp_growth,(SALT36.StrType)le.sis_growth,(SALT36.StrType)le.apparel_growth,(SALT36.StrType)le.beverages_growth,(SALT36.StrType)le.constr_growth,(SALT36.StrType)le.consulting_growth,(SALT36.StrType)le.fs_growth,(SALT36.StrType)le.fp_growth,(SALT36.StrType)le.insurance_growth,(SALT36.StrType)le.ls_growth,(SALT36.StrType)le.oil_gas_growth,(SALT36.StrType)le.utilities_growth,(SALT36.StrType)le.other_growth,(SALT36.StrType)le.advt_growth,(SALT36.StrType)le.top5_growth,(SALT36.StrType)le.shipping_y1,(SALT36.StrType)le.shipping_growth,(SALT36.StrType)le.materials_y1,(SALT36.StrType)le.materials_growth,(SALT36.StrType)le.operations_y1,(SALT36.StrType)le.operations_growth,(SALT36.StrType)le.total_paid_average_0t12,(SALT36.StrType)le.total_paid_monthspastworst_24,(SALT36.StrType)le.total_paid_slope_0t12,(SALT36.StrType)le.total_paid_slope_0t6,(SALT36.StrType)le.total_paid_slope_6t12,(SALT36.StrType)le.total_paid_slope_6t18,(SALT36.StrType)le.total_paid_volatility_0t12,(SALT36.StrType)le.total_paid_volatility_0t6,(SALT36.StrType)le.total_paid_volatility_12t18,(SALT36.StrType)le.total_paid_volatility_6t12,(SALT36.StrType)le.total_spend_monthspastleast_24,(SALT36.StrType)le.total_spend_monthspastmost_24,(SALT36.StrType)le.total_spend_slope_0t12,(SALT36.StrType)le.total_spend_slope_0t24,(SALT36.StrType)le.total_spend_slope_0t6,(SALT36.StrType)le.total_spend_slope_6t12,(SALT36.StrType)le.total_spend_sum_12,(SALT36.StrType)le.total_spend_volatility_0t12,(SALT36.StrType)le.total_spend_volatility_0t6,(SALT36.StrType)le.total_spend_volatility_12t18,(SALT36.StrType)le.total_spend_volatility_6t12,(SALT36.StrType)le.mfgmat_paid_average_12,(SALT36.StrType)le.mfgmat_paid_monthspastworst_24,(SALT36.StrType)le.mfgmat_paid_slope_0t12,(SALT36.StrType)le.mfgmat_paid_slope_0t24,(SALT36.StrType)le.mfgmat_paid_slope_0t6,(SALT36.StrType)le.mfgmat_paid_volatility_0t12,(SALT36.StrType)le.mfgmat_paid_volatility_0t6,(SALT36.StrType)le.mfgmat_spend_monthspastleast_24,(SALT36.StrType)le.mfgmat_spend_monthspastmost_24,(SALT36.StrType)le.mfgmat_spend_slope_0t12,(SALT36.StrType)le.mfgmat_spend_slope_0t24,(SALT36.StrType)le.mfgmat_spend_slope_0t6,(SALT36.StrType)le.mfgmat_spend_sum_12,(SALT36.StrType)le.mfgmat_spend_volatility_0t6,(SALT36.StrType)le.mfgmat_spend_volatility_6t12,(SALT36.StrType)le.ops_paid_average_12,(SALT36.StrType)le.ops_paid_monthspastworst_24,(SALT36.StrType)le.ops_paid_slope_0t12,(SALT36.StrType)le.ops_paid_slope_0t24,(SALT36.StrType)le.ops_paid_slope_0t6,(SALT36.StrType)le.ops_paid_volatility_0t12,(SALT36.StrType)le.ops_paid_volatility_0t6,(SALT36.StrType)le.ops_spend_monthspastleast_24,(SALT36.StrType)le.ops_spend_monthspastmost_24,(SALT36.StrType)le.ops_spend_slope_0t12,(SALT36.StrType)le.ops_spend_slope_0t24,(SALT36.StrType)le.ops_spend_slope_0t6,(SALT36.StrType)le.fleet_paid_monthspastworst_24,(SALT36.StrType)le.fleet_paid_slope_0t12,(SALT36.StrType)le.fleet_paid_slope_0t24,(SALT36.StrType)le.fleet_paid_slope_0t6,(SALT36.StrType)le.fleet_paid_volatility_0t12,(SALT36.StrType)le.fleet_paid_volatility_0t6,(SALT36.StrType)le.fleet_spend_slope_0t12,(SALT36.StrType)le.fleet_spend_slope_0t24,(SALT36.StrType)le.fleet_spend_slope_0t6,(SALT36.StrType)le.carrier_paid_slope_0t12,(SALT36.StrType)le.carrier_paid_slope_0t24,(SALT36.StrType)le.carrier_paid_slope_0t6,(SALT36.StrType)le.carrier_paid_volatility_0t12,(SALT36.StrType)le.carrier_paid_volatility_0t6,(SALT36.StrType)le.carrier_spend_slope_0t12,(SALT36.StrType)le.carrier_spend_slope_0t24,(SALT36.StrType)le.carrier_spend_slope_0t6,(SALT36.StrType)le.carrier_spend_volatility_0t6,(SALT36.StrType)le.carrier_spend_volatility_6t12,(SALT36.StrType)le.bldgmats_paid_slope_0t12,(SALT36.StrType)le.bldgmats_paid_slope_0t24,(SALT36.StrType)le.bldgmats_paid_slope_0t6,(SALT36.StrType)le.bldgmats_paid_volatility_0t12,(SALT36.StrType)le.bldgmats_paid_volatility_0t6,(SALT36.StrType)le.bldgmats_spend_slope_0t12,(SALT36.StrType)le.bldgmats_spend_slope_0t24,(SALT36.StrType)le.bldgmats_spend_slope_0t6,(SALT36.StrType)le.bldgmats_spend_volatility_0t6,(SALT36.StrType)le.bldgmats_spend_volatility_6t12,(SALT36.StrType)le.top5_paid_slope_0t12,(SALT36.StrType)le.top5_paid_slope_0t24,(SALT36.StrType)le.top5_paid_slope_0t6,(SALT36.StrType)le.top5_paid_volatility_0t12,(SALT36.StrType)le.top5_paid_volatility_0t6,(SALT36.StrType)le.top5_spend_slope_0t12,(SALT36.StrType)le.top5_spend_slope_0t24,(SALT36.StrType)le.top5_spend_slope_0t6,(SALT36.StrType)le.top5_spend_volatility_0t6,(SALT36.StrType)le.top5_spend_volatility_6t12,(SALT36.StrType)le.total_numrel_slope_0t12,(SALT36.StrType)le.total_numrel_slope_0t24,(SALT36.StrType)le.total_numrel_slope_0t6,(SALT36.StrType)le.total_numrel_slope_6t12,(SALT36.StrType)le.mfgmat_numrel_slope_0t12,(SALT36.StrType)le.mfgmat_numrel_slope_0t24,(SALT36.StrType)le.mfgmat_numrel_slope_0t6,(SALT36.StrType)le.mfgmat_numrel_slope_6t12,(SALT36.StrType)le.ops_numrel_slope_0t12,(SALT36.StrType)le.ops_numrel_slope_0t24,(SALT36.StrType)le.ops_numrel_slope_0t6,(SALT36.StrType)le.ops_numrel_slope_6t12,(SALT36.StrType)le.fleet_numrel_slope_0t12,(SALT36.StrType)le.fleet_numrel_slope_0t24,(SALT36.StrType)le.fleet_numrel_slope_0t6,(SALT36.StrType)le.fleet_numrel_slope_6t12,(SALT36.StrType)le.carrier_numrel_slope_0t12,(SALT36.StrType)le.carrier_numrel_slope_0t24,(SALT36.StrType)le.carrier_numrel_slope_0t6,(SALT36.StrType)le.carrier_numrel_slope_6t12,(SALT36.StrType)le.bldgmats_numrel_slope_0t12,(SALT36.StrType)le.bldgmats_numrel_slope_0t24,(SALT36.StrType)le.bldgmats_numrel_slope_0t6,(SALT36.StrType)le.bldgmats_numrel_slope_6t12,(SALT36.StrType)le.bldgmats_numrel_var_0t12,(SALT36.StrType)le.bldgmats_numrel_var_12t24,(SALT36.StrType)le.total_percprov30_slope_0t12,(SALT36.StrType)le.total_percprov30_slope_0t24,(SALT36.StrType)le.total_percprov30_slope_0t6,(SALT36.StrType)le.total_percprov30_slope_6t12,(SALT36.StrType)le.total_percprov60_slope_0t12,(SALT36.StrType)le.total_percprov60_slope_0t24,(SALT36.StrType)le.total_percprov60_slope_0t6,(SALT36.StrType)le.total_percprov60_slope_6t12,(SALT36.StrType)le.total_percprov90_slope_0t24,(SALT36.StrType)le.total_percprov90_slope_0t6,(SALT36.StrType)le.total_percprov90_slope_6t12,(SALT36.StrType)le.mfgmat_percprov30_slope_0t12,(SALT36.StrType)le.mfgmat_percprov30_slope_6t12,(SALT36.StrType)le.mfgmat_percprov60_slope_0t12,(SALT36.StrType)le.mfgmat_percprov60_slope_6t12,(SALT36.StrType)le.mfgmat_percprov90_slope_0t24,(SALT36.StrType)le.mfgmat_percprov90_slope_0t6,(SALT36.StrType)le.mfgmat_percprov90_slope_6t12,(SALT36.StrType)le.ops_percprov30_slope_0t12,(SALT36.StrType)le.ops_percprov30_slope_6t12,(SALT36.StrType)le.ops_percprov60_slope_0t12,(SALT36.StrType)le.ops_percprov60_slope_6t12,(SALT36.StrType)le.ops_percprov90_slope_0t24,(SALT36.StrType)le.ops_percprov90_slope_0t6,(SALT36.StrType)le.ops_percprov90_slope_6t12,(SALT36.StrType)le.fleet_percprov30_slope_0t12,(SALT36.StrType)le.fleet_percprov30_slope_6t12,(SALT36.StrType)le.fleet_percprov60_slope_0t12,(SALT36.StrType)le.fleet_percprov60_slope_6t12,(SALT36.StrType)le.fleet_percprov90_slope_0t24,(SALT36.StrType)le.fleet_percprov90_slope_0t6,(SALT36.StrType)le.fleet_percprov90_slope_6t12,(SALT36.StrType)le.carrier_percprov30_slope_0t12,(SALT36.StrType)le.carrier_percprov30_slope_6t12,(SALT36.StrType)le.carrier_percprov60_slope_0t12,(SALT36.StrType)le.carrier_percprov60_slope_6t12,(SALT36.StrType)le.carrier_percprov90_slope_0t24,(SALT36.StrType)le.carrier_percprov90_slope_0t6,(SALT36.StrType)le.carrier_percprov90_slope_6t12,(SALT36.StrType)le.bldgmats_percprov30_slope_0t12,(SALT36.StrType)le.bldgmats_percprov30_slope_6t12,(SALT36.StrType)le.bldgmats_percprov60_slope_0t12,(SALT36.StrType)le.bldgmats_percprov60_slope_6t12,(SALT36.StrType)le.bldgmats_percprov90_slope_0t24,(SALT36.StrType)le.bldgmats_percprov90_slope_0t6,(SALT36.StrType)le.bldgmats_percprov90_slope_6t12,(SALT36.StrType)le.top5_percprov30_slope_0t12,(SALT36.StrType)le.top5_percprov30_slope_6t12,(SALT36.StrType)le.top5_percprov60_slope_0t12,(SALT36.StrType)le.top5_percprov60_slope_6t12,(SALT36.StrType)le.top5_percprov90_slope_0t24,(SALT36.StrType)le.top5_percprov90_slope_0t6,(SALT36.StrType)le.top5_percprov90_slope_6t12,(SALT36.StrType)le.top5_percprovoutstanding_adjustedslope_0t12,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,272,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT36.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'ultimate_linkid:Number:ALLOW','ultimate_linkid:Number:LENGTH'
          ,'cortera_score:Number:ALLOW','cortera_score:Number:LENGTH'
          ,'cpr_score:Number:ALLOW','cpr_score:Number:LENGTH'
          ,'cpr_segment:Number:ALLOW','cpr_segment:Number:LENGTH'
          ,'dbt:Ratio:ALLOW','dbt:Ratio:LENGTH'
          ,'avg_bal:Number:ALLOW','avg_bal:Number:LENGTH'
          ,'air_spend:Number:ALLOW','air_spend:Number:LENGTH'
          ,'fuel_spend:Number:ALLOW','fuel_spend:Number:LENGTH'
          ,'leasing_spend:Number:ALLOW','leasing_spend:Number:LENGTH'
          ,'ltl_spend:Number:ALLOW','ltl_spend:Number:LENGTH'
          ,'rail_spend:Number:ALLOW','rail_spend:Number:LENGTH'
          ,'tl_spend:Number:ALLOW','tl_spend:Number:LENGTH'
          ,'transvc_spend:Number:ALLOW','transvc_spend:Number:LENGTH'
          ,'transup_spend:Number:ALLOW','transup_spend:Number:LENGTH'
          ,'bst_spend:Number:ALLOW','bst_spend:Number:LENGTH'
          ,'dg_spend:Number:ALLOW','dg_spend:Number:LENGTH'
          ,'electrical_spend:Number:ALLOW','electrical_spend:Number:LENGTH'
          ,'hvac_spend:Number:ALLOW','hvac_spend:Number:LENGTH'
          ,'other_b_spend:Number:ALLOW','other_b_spend:Number:LENGTH'
          ,'plumbing_spend:Number:ALLOW','plumbing_spend:Number:LENGTH'
          ,'rs_spend:Number:ALLOW','rs_spend:Number:LENGTH'
          ,'wp_spend:Number:ALLOW','wp_spend:Number:LENGTH'
          ,'chemical_spend:Number:ALLOW','chemical_spend:Number:LENGTH'
          ,'electronic_spend:Number:ALLOW','electronic_spend:Number:LENGTH'
          ,'metal_spend:Number:ALLOW','metal_spend:Number:LENGTH'
          ,'other_m_spend:Number:ALLOW','other_m_spend:Number:LENGTH'
          ,'packaging_spend:Number:ALLOW','packaging_spend:Number:LENGTH'
          ,'pvf_spend:Number:ALLOW','pvf_spend:Number:LENGTH'
          ,'plastic_spend:Number:ALLOW','plastic_spend:Number:LENGTH'
          ,'textile_spend:Number:ALLOW','textile_spend:Number:LENGTH'
          ,'bs_spend:Number:ALLOW','bs_spend:Number:LENGTH'
          ,'ce_spend:Number:ALLOW','ce_spend:Number:LENGTH'
          ,'hardware_spend:Number:ALLOW','hardware_spend:Number:LENGTH'
          ,'ie_spend:Number:ALLOW','ie_spend:Number:LENGTH'
          ,'is_spend:Number:ALLOW','is_spend:Number:LENGTH'
          ,'it_spend:Number:ALLOW','it_spend:Number:LENGTH'
          ,'mls_spend:Number:ALLOW','mls_spend:Number:LENGTH'
          ,'os_spend:Number:ALLOW','os_spend:Number:LENGTH'
          ,'pp_spend:Number:ALLOW','pp_spend:Number:LENGTH'
          ,'sis_spend:Number:ALLOW','sis_spend:Number:LENGTH'
          ,'apparel_spend:Number:ALLOW','apparel_spend:Number:LENGTH'
          ,'beverages_spend:Number:ALLOW','beverages_spend:Number:LENGTH'
          ,'constr_spend:Number:ALLOW','constr_spend:Number:LENGTH'
          ,'consulting_spend:Number:ALLOW','consulting_spend:Number:LENGTH'
          ,'fs_spend:Number:ALLOW','fs_spend:Number:LENGTH'
          ,'fp_spend:Number:ALLOW','fp_spend:Number:LENGTH'
          ,'insurance_spend:Number:ALLOW','insurance_spend:Number:LENGTH'
          ,'ls_spend:Number:ALLOW','ls_spend:Number:LENGTH'
          ,'oil_gas_spend:Number:ALLOW','oil_gas_spend:Number:LENGTH'
          ,'utilities_spend:Number:ALLOW','utilities_spend:Number:LENGTH'
          ,'other_spend:Number:ALLOW','other_spend:Number:LENGTH'
          ,'advt_spend:Number:ALLOW','advt_spend:Number:LENGTH'
          ,'air_growth:Ratio:ALLOW','air_growth:Ratio:LENGTH'
          ,'fuel_growth:Ratio:ALLOW','fuel_growth:Ratio:LENGTH'
          ,'leasing_growth:Ratio:ALLOW','leasing_growth:Ratio:LENGTH'
          ,'ltl_growth:Ratio:ALLOW','ltl_growth:Ratio:LENGTH'
          ,'rail_growth:Ratio:ALLOW','rail_growth:Ratio:LENGTH'
          ,'tl_growth:Ratio:ALLOW','tl_growth:Ratio:LENGTH'
          ,'transvc_growth:Ratio:ALLOW','transvc_growth:Ratio:LENGTH'
          ,'transup_growth:Ratio:ALLOW','transup_growth:Ratio:LENGTH'
          ,'bst_growth:Ratio:ALLOW','bst_growth:Ratio:LENGTH'
          ,'dg_growth:Ratio:ALLOW','dg_growth:Ratio:LENGTH'
          ,'electrical_growth:Ratio:ALLOW','electrical_growth:Ratio:LENGTH'
          ,'hvac_growth:Ratio:ALLOW','hvac_growth:Ratio:LENGTH'
          ,'other_b_growth:Ratio:ALLOW','other_b_growth:Ratio:LENGTH'
          ,'plumbing_growth:Ratio:ALLOW','plumbing_growth:Ratio:LENGTH'
          ,'rs_growth:Ratio:ALLOW','rs_growth:Ratio:LENGTH'
          ,'wp_growth:Ratio:ALLOW','wp_growth:Ratio:LENGTH'
          ,'chemical_growth:Ratio:ALLOW','chemical_growth:Ratio:LENGTH'
          ,'electronic_growth:Ratio:ALLOW','electronic_growth:Ratio:LENGTH'
          ,'metal_growth:Ratio:ALLOW','metal_growth:Ratio:LENGTH'
          ,'other_m_growth:Ratio:ALLOW','other_m_growth:Ratio:LENGTH'
          ,'packaging_growth:Ratio:ALLOW','packaging_growth:Ratio:LENGTH'
          ,'pvf_growth:Ratio:ALLOW','pvf_growth:Ratio:LENGTH'
          ,'plastic_growth:Ratio:ALLOW','plastic_growth:Ratio:LENGTH'
          ,'textile_growth:Ratio:ALLOW','textile_growth:Ratio:LENGTH'
          ,'bs_growth:Ratio:ALLOW','bs_growth:Ratio:LENGTH'
          ,'ce_growth:Ratio:ALLOW','ce_growth:Ratio:LENGTH'
          ,'hardware_growth:Ratio:ALLOW','hardware_growth:Ratio:LENGTH'
          ,'ie_growth:Ratio:ALLOW','ie_growth:Ratio:LENGTH'
          ,'is_growth:Ratio:ALLOW','is_growth:Ratio:LENGTH'
          ,'it_growth:Ratio:ALLOW','it_growth:Ratio:LENGTH'
          ,'mls_growth:Ratio:ALLOW','mls_growth:Ratio:LENGTH'
          ,'os_growth:Ratio:ALLOW','os_growth:Ratio:LENGTH'
          ,'pp_growth:Ratio:ALLOW','pp_growth:Ratio:LENGTH'
          ,'sis_growth:Ratio:ALLOW','sis_growth:Ratio:LENGTH'
          ,'apparel_growth:Ratio:ALLOW','apparel_growth:Ratio:LENGTH'
          ,'beverages_growth:Ratio:ALLOW','beverages_growth:Ratio:LENGTH'
          ,'constr_growth:Ratio:ALLOW','constr_growth:Ratio:LENGTH'
          ,'consulting_growth:Ratio:ALLOW','consulting_growth:Ratio:LENGTH'
          ,'fs_growth:Ratio:ALLOW','fs_growth:Ratio:LENGTH'
          ,'fp_growth:Ratio:ALLOW','fp_growth:Ratio:LENGTH'
          ,'insurance_growth:Ratio:ALLOW','insurance_growth:Ratio:LENGTH'
          ,'ls_growth:Ratio:ALLOW','ls_growth:Ratio:LENGTH'
          ,'oil_gas_growth:Ratio:ALLOW','oil_gas_growth:Ratio:LENGTH'
          ,'utilities_growth:Ratio:ALLOW','utilities_growth:Ratio:LENGTH'
          ,'other_growth:Ratio:ALLOW','other_growth:Ratio:LENGTH'
          ,'advt_growth:Ratio:ALLOW','advt_growth:Ratio:LENGTH'
          ,'top5_growth:Ratio:ALLOW','top5_growth:Ratio:LENGTH'
          ,'shipping_y1:Number:ALLOW','shipping_y1:Number:LENGTH'
          ,'shipping_growth:Ratio:ALLOW','shipping_growth:Ratio:LENGTH'
          ,'materials_y1:Number:ALLOW','materials_y1:Number:LENGTH'
          ,'materials_growth:Ratio:ALLOW','materials_growth:Ratio:LENGTH'
          ,'operations_y1:Number:ALLOW','operations_y1:Number:LENGTH'
          ,'operations_growth:Ratio:ALLOW','operations_growth:Ratio:LENGTH'
          ,'total_paid_average_0t12:Ratio:ALLOW','total_paid_average_0t12:Ratio:LENGTH'
          ,'total_paid_monthspastworst_24:Ratio:ALLOW','total_paid_monthspastworst_24:Ratio:LENGTH'
          ,'total_paid_slope_0t12:Ratio:ALLOW','total_paid_slope_0t12:Ratio:LENGTH'
          ,'total_paid_slope_0t6:Ratio:ALLOW','total_paid_slope_0t6:Ratio:LENGTH'
          ,'total_paid_slope_6t12:Ratio:ALLOW','total_paid_slope_6t12:Ratio:LENGTH'
          ,'total_paid_slope_6t18:Ratio:ALLOW','total_paid_slope_6t18:Ratio:LENGTH'
          ,'total_paid_volatility_0t12:Ratio:ALLOW','total_paid_volatility_0t12:Ratio:LENGTH'
          ,'total_paid_volatility_0t6:Ratio:ALLOW','total_paid_volatility_0t6:Ratio:LENGTH'
          ,'total_paid_volatility_12t18:Ratio:ALLOW','total_paid_volatility_12t18:Ratio:LENGTH'
          ,'total_paid_volatility_6t12:Ratio:ALLOW','total_paid_volatility_6t12:Ratio:LENGTH'
          ,'total_spend_monthspastleast_24:Number:ALLOW','total_spend_monthspastleast_24:Number:LENGTH'
          ,'total_spend_monthspastmost_24:Number:ALLOW','total_spend_monthspastmost_24:Number:LENGTH'
          ,'total_spend_slope_0t12:Ratio:ALLOW','total_spend_slope_0t12:Ratio:LENGTH'
          ,'total_spend_slope_0t24:Ratio:ALLOW','total_spend_slope_0t24:Ratio:LENGTH'
          ,'total_spend_slope_0t6:Ratio:ALLOW','total_spend_slope_0t6:Ratio:LENGTH'
          ,'total_spend_slope_6t12:Ratio:ALLOW','total_spend_slope_6t12:Ratio:LENGTH'
          ,'total_spend_sum_12:Ratio:ALLOW','total_spend_sum_12:Ratio:LENGTH'
          ,'total_spend_volatility_0t12:Ratio:ALLOW','total_spend_volatility_0t12:Ratio:LENGTH'
          ,'total_spend_volatility_0t6:Ratio:ALLOW','total_spend_volatility_0t6:Ratio:LENGTH'
          ,'total_spend_volatility_12t18:Ratio:ALLOW','total_spend_volatility_12t18:Ratio:LENGTH'
          ,'total_spend_volatility_6t12:Ratio:ALLOW','total_spend_volatility_6t12:Ratio:LENGTH'
          ,'mfgmat_paid_average_12:Ratio:ALLOW','mfgmat_paid_average_12:Ratio:LENGTH'
          ,'mfgmat_paid_monthspastworst_24:Number:ALLOW','mfgmat_paid_monthspastworst_24:Number:LENGTH'
          ,'mfgmat_paid_slope_0t12:Ratio:ALLOW','mfgmat_paid_slope_0t12:Ratio:LENGTH'
          ,'mfgmat_paid_slope_0t24:Ratio:ALLOW','mfgmat_paid_slope_0t24:Ratio:LENGTH'
          ,'mfgmat_paid_slope_0t6:Ratio:ALLOW','mfgmat_paid_slope_0t6:Ratio:LENGTH'
          ,'mfgmat_paid_volatility_0t12:Ratio:ALLOW','mfgmat_paid_volatility_0t12:Ratio:LENGTH'
          ,'mfgmat_paid_volatility_0t6:Ratio:ALLOW','mfgmat_paid_volatility_0t6:Ratio:LENGTH'
          ,'mfgmat_spend_monthspastleast_24:Number:ALLOW','mfgmat_spend_monthspastleast_24:Number:LENGTH'
          ,'mfgmat_spend_monthspastmost_24:Number:ALLOW','mfgmat_spend_monthspastmost_24:Number:LENGTH'
          ,'mfgmat_spend_slope_0t12:Ratio:ALLOW','mfgmat_spend_slope_0t12:Ratio:LENGTH'
          ,'mfgmat_spend_slope_0t24:Ratio:ALLOW','mfgmat_spend_slope_0t24:Ratio:LENGTH'
          ,'mfgmat_spend_slope_0t6:Ratio:ALLOW','mfgmat_spend_slope_0t6:Ratio:LENGTH'
          ,'mfgmat_spend_sum_12:Ratio:ALLOW','mfgmat_spend_sum_12:Ratio:LENGTH'
          ,'mfgmat_spend_volatility_0t6:Ratio:ALLOW','mfgmat_spend_volatility_0t6:Ratio:LENGTH'
          ,'mfgmat_spend_volatility_6t12:Ratio:ALLOW','mfgmat_spend_volatility_6t12:Ratio:LENGTH'
          ,'ops_paid_average_12:Ratio:ALLOW','ops_paid_average_12:Ratio:LENGTH'
          ,'ops_paid_monthspastworst_24:Ratio:ALLOW','ops_paid_monthspastworst_24:Ratio:LENGTH'
          ,'ops_paid_slope_0t12:Ratio:ALLOW','ops_paid_slope_0t12:Ratio:LENGTH'
          ,'ops_paid_slope_0t24:Ratio:ALLOW','ops_paid_slope_0t24:Ratio:LENGTH'
          ,'ops_paid_slope_0t6:Ratio:ALLOW','ops_paid_slope_0t6:Ratio:LENGTH'
          ,'ops_paid_volatility_0t12:Ratio:ALLOW','ops_paid_volatility_0t12:Ratio:LENGTH'
          ,'ops_paid_volatility_0t6:Ratio:ALLOW','ops_paid_volatility_0t6:Ratio:LENGTH'
          ,'ops_spend_monthspastleast_24:Number:ALLOW','ops_spend_monthspastleast_24:Number:LENGTH'
          ,'ops_spend_monthspastmost_24:Number:ALLOW','ops_spend_monthspastmost_24:Number:LENGTH'
          ,'ops_spend_slope_0t12:Ratio:ALLOW','ops_spend_slope_0t12:Ratio:LENGTH'
          ,'ops_spend_slope_0t24:Ratio:ALLOW','ops_spend_slope_0t24:Ratio:LENGTH'
          ,'ops_spend_slope_0t6:Ratio:ALLOW','ops_spend_slope_0t6:Ratio:LENGTH'
          ,'fleet_paid_monthspastworst_24:Number:ALLOW','fleet_paid_monthspastworst_24:Number:LENGTH'
          ,'fleet_paid_slope_0t12:Ratio:ALLOW','fleet_paid_slope_0t12:Ratio:LENGTH'
          ,'fleet_paid_slope_0t24:Ratio:ALLOW','fleet_paid_slope_0t24:Ratio:LENGTH'
          ,'fleet_paid_slope_0t6:Ratio:ALLOW','fleet_paid_slope_0t6:Ratio:LENGTH'
          ,'fleet_paid_volatility_0t12:Ratio:ALLOW','fleet_paid_volatility_0t12:Ratio:LENGTH'
          ,'fleet_paid_volatility_0t6:Ratio:ALLOW','fleet_paid_volatility_0t6:Ratio:LENGTH'
          ,'fleet_spend_slope_0t12:Ratio:ALLOW','fleet_spend_slope_0t12:Ratio:LENGTH'
          ,'fleet_spend_slope_0t24:Ratio:ALLOW','fleet_spend_slope_0t24:Ratio:LENGTH'
          ,'fleet_spend_slope_0t6:Ratio:ALLOW','fleet_spend_slope_0t6:Ratio:LENGTH'
          ,'carrier_paid_slope_0t12:Ratio:ALLOW','carrier_paid_slope_0t12:Ratio:LENGTH'
          ,'carrier_paid_slope_0t24:Ratio:ALLOW','carrier_paid_slope_0t24:Ratio:LENGTH'
          ,'carrier_paid_slope_0t6:Ratio:ALLOW','carrier_paid_slope_0t6:Ratio:LENGTH'
          ,'carrier_paid_volatility_0t12:Ratio:ALLOW','carrier_paid_volatility_0t12:Ratio:LENGTH'
          ,'carrier_paid_volatility_0t6:Ratio:ALLOW','carrier_paid_volatility_0t6:Ratio:LENGTH'
          ,'carrier_spend_slope_0t12:Ratio:ALLOW','carrier_spend_slope_0t12:Ratio:LENGTH'
          ,'carrier_spend_slope_0t24:Ratio:ALLOW','carrier_spend_slope_0t24:Ratio:LENGTH'
          ,'carrier_spend_slope_0t6:Ratio:ALLOW','carrier_spend_slope_0t6:Ratio:LENGTH'
          ,'carrier_spend_volatility_0t6:Ratio:ALLOW','carrier_spend_volatility_0t6:Ratio:LENGTH'
          ,'carrier_spend_volatility_6t12:Ratio:ALLOW','carrier_spend_volatility_6t12:Ratio:LENGTH'
          ,'bldgmats_paid_slope_0t12:Ratio:ALLOW','bldgmats_paid_slope_0t12:Ratio:LENGTH'
          ,'bldgmats_paid_slope_0t24:Ratio:ALLOW','bldgmats_paid_slope_0t24:Ratio:LENGTH'
          ,'bldgmats_paid_slope_0t6:Ratio:ALLOW','bldgmats_paid_slope_0t6:Ratio:LENGTH'
          ,'bldgmats_paid_volatility_0t12:Ratio:ALLOW','bldgmats_paid_volatility_0t12:Ratio:LENGTH'
          ,'bldgmats_paid_volatility_0t6:Ratio:ALLOW','bldgmats_paid_volatility_0t6:Ratio:LENGTH'
          ,'bldgmats_spend_slope_0t12:Ratio:ALLOW','bldgmats_spend_slope_0t12:Ratio:LENGTH'
          ,'bldgmats_spend_slope_0t24:Ratio:ALLOW','bldgmats_spend_slope_0t24:Ratio:LENGTH'
          ,'bldgmats_spend_slope_0t6:Ratio:ALLOW','bldgmats_spend_slope_0t6:Ratio:LENGTH'
          ,'bldgmats_spend_volatility_0t6:Ratio:ALLOW','bldgmats_spend_volatility_0t6:Ratio:LENGTH'
          ,'bldgmats_spend_volatility_6t12:Ratio:ALLOW','bldgmats_spend_volatility_6t12:Ratio:LENGTH'
          ,'top5_paid_slope_0t12:Ratio:ALLOW','top5_paid_slope_0t12:Ratio:LENGTH'
          ,'top5_paid_slope_0t24:Ratio:ALLOW','top5_paid_slope_0t24:Ratio:LENGTH'
          ,'top5_paid_slope_0t6:Ratio:ALLOW','top5_paid_slope_0t6:Ratio:LENGTH'
          ,'top5_paid_volatility_0t12:Ratio:ALLOW','top5_paid_volatility_0t12:Ratio:LENGTH'
          ,'top5_paid_volatility_0t6:Ratio:ALLOW','top5_paid_volatility_0t6:Ratio:LENGTH'
          ,'top5_spend_slope_0t12:Ratio:ALLOW','top5_spend_slope_0t12:Ratio:LENGTH'
          ,'top5_spend_slope_0t24:Ratio:ALLOW','top5_spend_slope_0t24:Ratio:LENGTH'
          ,'top5_spend_slope_0t6:Ratio:ALLOW','top5_spend_slope_0t6:Ratio:LENGTH'
          ,'top5_spend_volatility_0t6:Ratio:ALLOW','top5_spend_volatility_0t6:Ratio:LENGTH'
          ,'top5_spend_volatility_6t12:Ratio:ALLOW','top5_spend_volatility_6t12:Ratio:LENGTH'
          ,'total_numrel_slope_0t12:Ratio:ALLOW','total_numrel_slope_0t12:Ratio:LENGTH'
          ,'total_numrel_slope_0t24:Ratio:ALLOW','total_numrel_slope_0t24:Ratio:LENGTH'
          ,'total_numrel_slope_0t6:Ratio:ALLOW','total_numrel_slope_0t6:Ratio:LENGTH'
          ,'total_numrel_slope_6t12:Ratio:ALLOW','total_numrel_slope_6t12:Ratio:LENGTH'
          ,'mfgmat_numrel_slope_0t12:Ratio:ALLOW','mfgmat_numrel_slope_0t12:Ratio:LENGTH'
          ,'mfgmat_numrel_slope_0t24:Ratio:ALLOW','mfgmat_numrel_slope_0t24:Ratio:LENGTH'
          ,'mfgmat_numrel_slope_0t6:Ratio:ALLOW','mfgmat_numrel_slope_0t6:Ratio:LENGTH'
          ,'mfgmat_numrel_slope_6t12:Ratio:ALLOW','mfgmat_numrel_slope_6t12:Ratio:LENGTH'
          ,'ops_numrel_slope_0t12:Ratio:ALLOW','ops_numrel_slope_0t12:Ratio:LENGTH'
          ,'ops_numrel_slope_0t24:Ratio:ALLOW','ops_numrel_slope_0t24:Ratio:LENGTH'
          ,'ops_numrel_slope_0t6:Ratio:ALLOW','ops_numrel_slope_0t6:Ratio:LENGTH'
          ,'ops_numrel_slope_6t12:Ratio:ALLOW','ops_numrel_slope_6t12:Ratio:LENGTH'
          ,'fleet_numrel_slope_0t12:Ratio:ALLOW','fleet_numrel_slope_0t12:Ratio:LENGTH'
          ,'fleet_numrel_slope_0t24:Ratio:ALLOW','fleet_numrel_slope_0t24:Ratio:LENGTH'
          ,'fleet_numrel_slope_0t6:Ratio:ALLOW','fleet_numrel_slope_0t6:Ratio:LENGTH'
          ,'fleet_numrel_slope_6t12:Ratio:ALLOW','fleet_numrel_slope_6t12:Ratio:LENGTH'
          ,'carrier_numrel_slope_0t12:Ratio:ALLOW','carrier_numrel_slope_0t12:Ratio:LENGTH'
          ,'carrier_numrel_slope_0t24:Ratio:ALLOW','carrier_numrel_slope_0t24:Ratio:LENGTH'
          ,'carrier_numrel_slope_0t6:Ratio:ALLOW','carrier_numrel_slope_0t6:Ratio:LENGTH'
          ,'carrier_numrel_slope_6t12:Ratio:ALLOW','carrier_numrel_slope_6t12:Ratio:LENGTH'
          ,'bldgmats_numrel_slope_0t12:Ratio:ALLOW','bldgmats_numrel_slope_0t12:Ratio:LENGTH'
          ,'bldgmats_numrel_slope_0t24:Ratio:ALLOW','bldgmats_numrel_slope_0t24:Ratio:LENGTH'
          ,'bldgmats_numrel_slope_0t6:Ratio:ALLOW','bldgmats_numrel_slope_0t6:Ratio:LENGTH'
          ,'bldgmats_numrel_slope_6t12:Ratio:ALLOW','bldgmats_numrel_slope_6t12:Ratio:LENGTH'
          ,'bldgmats_numrel_var_0t12:Ratio:ALLOW','bldgmats_numrel_var_0t12:Ratio:LENGTH'
          ,'bldgmats_numrel_var_12t24:Ratio:ALLOW','bldgmats_numrel_var_12t24:Ratio:LENGTH'
          ,'total_percprov30_slope_0t12:Ratio:ALLOW','total_percprov30_slope_0t12:Ratio:LENGTH'
          ,'total_percprov30_slope_0t24:Ratio:ALLOW','total_percprov30_slope_0t24:Ratio:LENGTH'
          ,'total_percprov30_slope_0t6:Ratio:ALLOW','total_percprov30_slope_0t6:Ratio:LENGTH'
          ,'total_percprov30_slope_6t12:Ratio:ALLOW','total_percprov30_slope_6t12:Ratio:LENGTH'
          ,'total_percprov60_slope_0t12:Ratio:ALLOW','total_percprov60_slope_0t12:Ratio:LENGTH'
          ,'total_percprov60_slope_0t24:Ratio:ALLOW','total_percprov60_slope_0t24:Ratio:LENGTH'
          ,'total_percprov60_slope_0t6:Ratio:ALLOW','total_percprov60_slope_0t6:Ratio:LENGTH'
          ,'total_percprov60_slope_6t12:Ratio:ALLOW','total_percprov60_slope_6t12:Ratio:LENGTH'
          ,'total_percprov90_slope_0t24:Ratio:ALLOW','total_percprov90_slope_0t24:Ratio:LENGTH'
          ,'total_percprov90_slope_0t6:Ratio:ALLOW','total_percprov90_slope_0t6:Ratio:LENGTH'
          ,'total_percprov90_slope_6t12:Ratio:ALLOW','total_percprov90_slope_6t12:Ratio:LENGTH'
          ,'mfgmat_percprov30_slope_0t12:Ratio:ALLOW','mfgmat_percprov30_slope_0t12:Ratio:LENGTH'
          ,'mfgmat_percprov30_slope_6t12:Ratio:ALLOW','mfgmat_percprov30_slope_6t12:Ratio:LENGTH'
          ,'mfgmat_percprov60_slope_0t12:Ratio:ALLOW','mfgmat_percprov60_slope_0t12:Ratio:LENGTH'
          ,'mfgmat_percprov60_slope_6t12:Ratio:ALLOW','mfgmat_percprov60_slope_6t12:Ratio:LENGTH'
          ,'mfgmat_percprov90_slope_0t24:Ratio:ALLOW','mfgmat_percprov90_slope_0t24:Ratio:LENGTH'
          ,'mfgmat_percprov90_slope_0t6:Ratio:ALLOW','mfgmat_percprov90_slope_0t6:Ratio:LENGTH'
          ,'mfgmat_percprov90_slope_6t12:Ratio:ALLOW','mfgmat_percprov90_slope_6t12:Ratio:LENGTH'
          ,'ops_percprov30_slope_0t12:Ratio:ALLOW','ops_percprov30_slope_0t12:Ratio:LENGTH'
          ,'ops_percprov30_slope_6t12:Ratio:ALLOW','ops_percprov30_slope_6t12:Ratio:LENGTH'
          ,'ops_percprov60_slope_0t12:Ratio:ALLOW','ops_percprov60_slope_0t12:Ratio:LENGTH'
          ,'ops_percprov60_slope_6t12:Ratio:ALLOW','ops_percprov60_slope_6t12:Ratio:LENGTH'
          ,'ops_percprov90_slope_0t24:Ratio:ALLOW','ops_percprov90_slope_0t24:Ratio:LENGTH'
          ,'ops_percprov90_slope_0t6:Ratio:ALLOW','ops_percprov90_slope_0t6:Ratio:LENGTH'
          ,'ops_percprov90_slope_6t12:Ratio:ALLOW','ops_percprov90_slope_6t12:Ratio:LENGTH'
          ,'fleet_percprov30_slope_0t12:Ratio:ALLOW','fleet_percprov30_slope_0t12:Ratio:LENGTH'
          ,'fleet_percprov30_slope_6t12:Ratio:ALLOW','fleet_percprov30_slope_6t12:Ratio:LENGTH'
          ,'fleet_percprov60_slope_0t12:Ratio:ALLOW','fleet_percprov60_slope_0t12:Ratio:LENGTH'
          ,'fleet_percprov60_slope_6t12:Ratio:ALLOW','fleet_percprov60_slope_6t12:Ratio:LENGTH'
          ,'fleet_percprov90_slope_0t24:Ratio:ALLOW','fleet_percprov90_slope_0t24:Ratio:LENGTH'
          ,'fleet_percprov90_slope_0t6:Ratio:ALLOW','fleet_percprov90_slope_0t6:Ratio:LENGTH'
          ,'fleet_percprov90_slope_6t12:Ratio:ALLOW','fleet_percprov90_slope_6t12:Ratio:LENGTH'
          ,'carrier_percprov30_slope_0t12:Ratio:ALLOW','carrier_percprov30_slope_0t12:Ratio:LENGTH'
          ,'carrier_percprov30_slope_6t12:Ratio:ALLOW','carrier_percprov30_slope_6t12:Ratio:LENGTH'
          ,'carrier_percprov60_slope_0t12:Ratio:ALLOW','carrier_percprov60_slope_0t12:Ratio:LENGTH'
          ,'carrier_percprov60_slope_6t12:Ratio:ALLOW','carrier_percprov60_slope_6t12:Ratio:LENGTH'
          ,'carrier_percprov90_slope_0t24:Ratio:ALLOW','carrier_percprov90_slope_0t24:Ratio:LENGTH'
          ,'carrier_percprov90_slope_0t6:Ratio:ALLOW','carrier_percprov90_slope_0t6:Ratio:LENGTH'
          ,'carrier_percprov90_slope_6t12:Ratio:ALLOW','carrier_percprov90_slope_6t12:Ratio:LENGTH'
          ,'bldgmats_percprov30_slope_0t12:Ratio:ALLOW','bldgmats_percprov30_slope_0t12:Ratio:LENGTH'
          ,'bldgmats_percprov30_slope_6t12:Ratio:ALLOW','bldgmats_percprov30_slope_6t12:Ratio:LENGTH'
          ,'bldgmats_percprov60_slope_0t12:Ratio:ALLOW','bldgmats_percprov60_slope_0t12:Ratio:LENGTH'
          ,'bldgmats_percprov60_slope_6t12:Ratio:ALLOW','bldgmats_percprov60_slope_6t12:Ratio:LENGTH'
          ,'bldgmats_percprov90_slope_0t24:Ratio:ALLOW','bldgmats_percprov90_slope_0t24:Ratio:LENGTH'
          ,'bldgmats_percprov90_slope_0t6:Ratio:ALLOW','bldgmats_percprov90_slope_0t6:Ratio:LENGTH'
          ,'bldgmats_percprov90_slope_6t12:Ratio:ALLOW','bldgmats_percprov90_slope_6t12:Ratio:LENGTH'
          ,'top5_percprov30_slope_0t12:Ratio:ALLOW','top5_percprov30_slope_0t12:Ratio:LENGTH'
          ,'top5_percprov30_slope_6t12:Ratio:ALLOW','top5_percprov30_slope_6t12:Ratio:LENGTH'
          ,'top5_percprov60_slope_0t12:Ratio:ALLOW','top5_percprov60_slope_0t12:Ratio:LENGTH'
          ,'top5_percprov60_slope_6t12:Ratio:ALLOW','top5_percprov60_slope_6t12:Ratio:LENGTH'
          ,'top5_percprov90_slope_0t24:Ratio:ALLOW','top5_percprov90_slope_0t24:Ratio:LENGTH'
          ,'top5_percprov90_slope_0t6:Ratio:ALLOW','top5_percprov90_slope_0t6:Ratio:LENGTH'
          ,'top5_percprov90_slope_6t12:Ratio:ALLOW','top5_percprov90_slope_6t12:Ratio:LENGTH'
          ,'top5_percprovoutstanding_adjustedslope_0t12:Ratio:ALLOW','top5_percprovoutstanding_adjustedslope_0t12:Ratio:LENGTH','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_ultimate_linkid(1),Fields.InvalidMessage_ultimate_linkid(2)
          ,Fields.InvalidMessage_cortera_score(1),Fields.InvalidMessage_cortera_score(2)
          ,Fields.InvalidMessage_cpr_score(1),Fields.InvalidMessage_cpr_score(2)
          ,Fields.InvalidMessage_cpr_segment(1),Fields.InvalidMessage_cpr_segment(2)
          ,Fields.InvalidMessage_dbt(1),Fields.InvalidMessage_dbt(2)
          ,Fields.InvalidMessage_avg_bal(1),Fields.InvalidMessage_avg_bal(2)
          ,Fields.InvalidMessage_air_spend(1),Fields.InvalidMessage_air_spend(2)
          ,Fields.InvalidMessage_fuel_spend(1),Fields.InvalidMessage_fuel_spend(2)
          ,Fields.InvalidMessage_leasing_spend(1),Fields.InvalidMessage_leasing_spend(2)
          ,Fields.InvalidMessage_ltl_spend(1),Fields.InvalidMessage_ltl_spend(2)
          ,Fields.InvalidMessage_rail_spend(1),Fields.InvalidMessage_rail_spend(2)
          ,Fields.InvalidMessage_tl_spend(1),Fields.InvalidMessage_tl_spend(2)
          ,Fields.InvalidMessage_transvc_spend(1),Fields.InvalidMessage_transvc_spend(2)
          ,Fields.InvalidMessage_transup_spend(1),Fields.InvalidMessage_transup_spend(2)
          ,Fields.InvalidMessage_bst_spend(1),Fields.InvalidMessage_bst_spend(2)
          ,Fields.InvalidMessage_dg_spend(1),Fields.InvalidMessage_dg_spend(2)
          ,Fields.InvalidMessage_electrical_spend(1),Fields.InvalidMessage_electrical_spend(2)
          ,Fields.InvalidMessage_hvac_spend(1),Fields.InvalidMessage_hvac_spend(2)
          ,Fields.InvalidMessage_other_b_spend(1),Fields.InvalidMessage_other_b_spend(2)
          ,Fields.InvalidMessage_plumbing_spend(1),Fields.InvalidMessage_plumbing_spend(2)
          ,Fields.InvalidMessage_rs_spend(1),Fields.InvalidMessage_rs_spend(2)
          ,Fields.InvalidMessage_wp_spend(1),Fields.InvalidMessage_wp_spend(2)
          ,Fields.InvalidMessage_chemical_spend(1),Fields.InvalidMessage_chemical_spend(2)
          ,Fields.InvalidMessage_electronic_spend(1),Fields.InvalidMessage_electronic_spend(2)
          ,Fields.InvalidMessage_metal_spend(1),Fields.InvalidMessage_metal_spend(2)
          ,Fields.InvalidMessage_other_m_spend(1),Fields.InvalidMessage_other_m_spend(2)
          ,Fields.InvalidMessage_packaging_spend(1),Fields.InvalidMessage_packaging_spend(2)
          ,Fields.InvalidMessage_pvf_spend(1),Fields.InvalidMessage_pvf_spend(2)
          ,Fields.InvalidMessage_plastic_spend(1),Fields.InvalidMessage_plastic_spend(2)
          ,Fields.InvalidMessage_textile_spend(1),Fields.InvalidMessage_textile_spend(2)
          ,Fields.InvalidMessage_bs_spend(1),Fields.InvalidMessage_bs_spend(2)
          ,Fields.InvalidMessage_ce_spend(1),Fields.InvalidMessage_ce_spend(2)
          ,Fields.InvalidMessage_hardware_spend(1),Fields.InvalidMessage_hardware_spend(2)
          ,Fields.InvalidMessage_ie_spend(1),Fields.InvalidMessage_ie_spend(2)
          ,Fields.InvalidMessage_is_spend(1),Fields.InvalidMessage_is_spend(2)
          ,Fields.InvalidMessage_it_spend(1),Fields.InvalidMessage_it_spend(2)
          ,Fields.InvalidMessage_mls_spend(1),Fields.InvalidMessage_mls_spend(2)
          ,Fields.InvalidMessage_os_spend(1),Fields.InvalidMessage_os_spend(2)
          ,Fields.InvalidMessage_pp_spend(1),Fields.InvalidMessage_pp_spend(2)
          ,Fields.InvalidMessage_sis_spend(1),Fields.InvalidMessage_sis_spend(2)
          ,Fields.InvalidMessage_apparel_spend(1),Fields.InvalidMessage_apparel_spend(2)
          ,Fields.InvalidMessage_beverages_spend(1),Fields.InvalidMessage_beverages_spend(2)
          ,Fields.InvalidMessage_constr_spend(1),Fields.InvalidMessage_constr_spend(2)
          ,Fields.InvalidMessage_consulting_spend(1),Fields.InvalidMessage_consulting_spend(2)
          ,Fields.InvalidMessage_fs_spend(1),Fields.InvalidMessage_fs_spend(2)
          ,Fields.InvalidMessage_fp_spend(1),Fields.InvalidMessage_fp_spend(2)
          ,Fields.InvalidMessage_insurance_spend(1),Fields.InvalidMessage_insurance_spend(2)
          ,Fields.InvalidMessage_ls_spend(1),Fields.InvalidMessage_ls_spend(2)
          ,Fields.InvalidMessage_oil_gas_spend(1),Fields.InvalidMessage_oil_gas_spend(2)
          ,Fields.InvalidMessage_utilities_spend(1),Fields.InvalidMessage_utilities_spend(2)
          ,Fields.InvalidMessage_other_spend(1),Fields.InvalidMessage_other_spend(2)
          ,Fields.InvalidMessage_advt_spend(1),Fields.InvalidMessage_advt_spend(2)
          ,Fields.InvalidMessage_air_growth(1),Fields.InvalidMessage_air_growth(2)
          ,Fields.InvalidMessage_fuel_growth(1),Fields.InvalidMessage_fuel_growth(2)
          ,Fields.InvalidMessage_leasing_growth(1),Fields.InvalidMessage_leasing_growth(2)
          ,Fields.InvalidMessage_ltl_growth(1),Fields.InvalidMessage_ltl_growth(2)
          ,Fields.InvalidMessage_rail_growth(1),Fields.InvalidMessage_rail_growth(2)
          ,Fields.InvalidMessage_tl_growth(1),Fields.InvalidMessage_tl_growth(2)
          ,Fields.InvalidMessage_transvc_growth(1),Fields.InvalidMessage_transvc_growth(2)
          ,Fields.InvalidMessage_transup_growth(1),Fields.InvalidMessage_transup_growth(2)
          ,Fields.InvalidMessage_bst_growth(1),Fields.InvalidMessage_bst_growth(2)
          ,Fields.InvalidMessage_dg_growth(1),Fields.InvalidMessage_dg_growth(2)
          ,Fields.InvalidMessage_electrical_growth(1),Fields.InvalidMessage_electrical_growth(2)
          ,Fields.InvalidMessage_hvac_growth(1),Fields.InvalidMessage_hvac_growth(2)
          ,Fields.InvalidMessage_other_b_growth(1),Fields.InvalidMessage_other_b_growth(2)
          ,Fields.InvalidMessage_plumbing_growth(1),Fields.InvalidMessage_plumbing_growth(2)
          ,Fields.InvalidMessage_rs_growth(1),Fields.InvalidMessage_rs_growth(2)
          ,Fields.InvalidMessage_wp_growth(1),Fields.InvalidMessage_wp_growth(2)
          ,Fields.InvalidMessage_chemical_growth(1),Fields.InvalidMessage_chemical_growth(2)
          ,Fields.InvalidMessage_electronic_growth(1),Fields.InvalidMessage_electronic_growth(2)
          ,Fields.InvalidMessage_metal_growth(1),Fields.InvalidMessage_metal_growth(2)
          ,Fields.InvalidMessage_other_m_growth(1),Fields.InvalidMessage_other_m_growth(2)
          ,Fields.InvalidMessage_packaging_growth(1),Fields.InvalidMessage_packaging_growth(2)
          ,Fields.InvalidMessage_pvf_growth(1),Fields.InvalidMessage_pvf_growth(2)
          ,Fields.InvalidMessage_plastic_growth(1),Fields.InvalidMessage_plastic_growth(2)
          ,Fields.InvalidMessage_textile_growth(1),Fields.InvalidMessage_textile_growth(2)
          ,Fields.InvalidMessage_bs_growth(1),Fields.InvalidMessage_bs_growth(2)
          ,Fields.InvalidMessage_ce_growth(1),Fields.InvalidMessage_ce_growth(2)
          ,Fields.InvalidMessage_hardware_growth(1),Fields.InvalidMessage_hardware_growth(2)
          ,Fields.InvalidMessage_ie_growth(1),Fields.InvalidMessage_ie_growth(2)
          ,Fields.InvalidMessage_is_growth(1),Fields.InvalidMessage_is_growth(2)
          ,Fields.InvalidMessage_it_growth(1),Fields.InvalidMessage_it_growth(2)
          ,Fields.InvalidMessage_mls_growth(1),Fields.InvalidMessage_mls_growth(2)
          ,Fields.InvalidMessage_os_growth(1),Fields.InvalidMessage_os_growth(2)
          ,Fields.InvalidMessage_pp_growth(1),Fields.InvalidMessage_pp_growth(2)
          ,Fields.InvalidMessage_sis_growth(1),Fields.InvalidMessage_sis_growth(2)
          ,Fields.InvalidMessage_apparel_growth(1),Fields.InvalidMessage_apparel_growth(2)
          ,Fields.InvalidMessage_beverages_growth(1),Fields.InvalidMessage_beverages_growth(2)
          ,Fields.InvalidMessage_constr_growth(1),Fields.InvalidMessage_constr_growth(2)
          ,Fields.InvalidMessage_consulting_growth(1),Fields.InvalidMessage_consulting_growth(2)
          ,Fields.InvalidMessage_fs_growth(1),Fields.InvalidMessage_fs_growth(2)
          ,Fields.InvalidMessage_fp_growth(1),Fields.InvalidMessage_fp_growth(2)
          ,Fields.InvalidMessage_insurance_growth(1),Fields.InvalidMessage_insurance_growth(2)
          ,Fields.InvalidMessage_ls_growth(1),Fields.InvalidMessage_ls_growth(2)
          ,Fields.InvalidMessage_oil_gas_growth(1),Fields.InvalidMessage_oil_gas_growth(2)
          ,Fields.InvalidMessage_utilities_growth(1),Fields.InvalidMessage_utilities_growth(2)
          ,Fields.InvalidMessage_other_growth(1),Fields.InvalidMessage_other_growth(2)
          ,Fields.InvalidMessage_advt_growth(1),Fields.InvalidMessage_advt_growth(2)
          ,Fields.InvalidMessage_top5_growth(1),Fields.InvalidMessage_top5_growth(2)
          ,Fields.InvalidMessage_shipping_y1(1),Fields.InvalidMessage_shipping_y1(2)
          ,Fields.InvalidMessage_shipping_growth(1),Fields.InvalidMessage_shipping_growth(2)
          ,Fields.InvalidMessage_materials_y1(1),Fields.InvalidMessage_materials_y1(2)
          ,Fields.InvalidMessage_materials_growth(1),Fields.InvalidMessage_materials_growth(2)
          ,Fields.InvalidMessage_operations_y1(1),Fields.InvalidMessage_operations_y1(2)
          ,Fields.InvalidMessage_operations_growth(1),Fields.InvalidMessage_operations_growth(2)
          ,Fields.InvalidMessage_total_paid_average_0t12(1),Fields.InvalidMessage_total_paid_average_0t12(2)
          ,Fields.InvalidMessage_total_paid_monthspastworst_24(1),Fields.InvalidMessage_total_paid_monthspastworst_24(2)
          ,Fields.InvalidMessage_total_paid_slope_0t12(1),Fields.InvalidMessage_total_paid_slope_0t12(2)
          ,Fields.InvalidMessage_total_paid_slope_0t6(1),Fields.InvalidMessage_total_paid_slope_0t6(2)
          ,Fields.InvalidMessage_total_paid_slope_6t12(1),Fields.InvalidMessage_total_paid_slope_6t12(2)
          ,Fields.InvalidMessage_total_paid_slope_6t18(1),Fields.InvalidMessage_total_paid_slope_6t18(2)
          ,Fields.InvalidMessage_total_paid_volatility_0t12(1),Fields.InvalidMessage_total_paid_volatility_0t12(2)
          ,Fields.InvalidMessage_total_paid_volatility_0t6(1),Fields.InvalidMessage_total_paid_volatility_0t6(2)
          ,Fields.InvalidMessage_total_paid_volatility_12t18(1),Fields.InvalidMessage_total_paid_volatility_12t18(2)
          ,Fields.InvalidMessage_total_paid_volatility_6t12(1),Fields.InvalidMessage_total_paid_volatility_6t12(2)
          ,Fields.InvalidMessage_total_spend_monthspastleast_24(1),Fields.InvalidMessage_total_spend_monthspastleast_24(2)
          ,Fields.InvalidMessage_total_spend_monthspastmost_24(1),Fields.InvalidMessage_total_spend_monthspastmost_24(2)
          ,Fields.InvalidMessage_total_spend_slope_0t12(1),Fields.InvalidMessage_total_spend_slope_0t12(2)
          ,Fields.InvalidMessage_total_spend_slope_0t24(1),Fields.InvalidMessage_total_spend_slope_0t24(2)
          ,Fields.InvalidMessage_total_spend_slope_0t6(1),Fields.InvalidMessage_total_spend_slope_0t6(2)
          ,Fields.InvalidMessage_total_spend_slope_6t12(1),Fields.InvalidMessage_total_spend_slope_6t12(2)
          ,Fields.InvalidMessage_total_spend_sum_12(1),Fields.InvalidMessage_total_spend_sum_12(2)
          ,Fields.InvalidMessage_total_spend_volatility_0t12(1),Fields.InvalidMessage_total_spend_volatility_0t12(2)
          ,Fields.InvalidMessage_total_spend_volatility_0t6(1),Fields.InvalidMessage_total_spend_volatility_0t6(2)
          ,Fields.InvalidMessage_total_spend_volatility_12t18(1),Fields.InvalidMessage_total_spend_volatility_12t18(2)
          ,Fields.InvalidMessage_total_spend_volatility_6t12(1),Fields.InvalidMessage_total_spend_volatility_6t12(2)
          ,Fields.InvalidMessage_mfgmat_paid_average_12(1),Fields.InvalidMessage_mfgmat_paid_average_12(2)
          ,Fields.InvalidMessage_mfgmat_paid_monthspastworst_24(1),Fields.InvalidMessage_mfgmat_paid_monthspastworst_24(2)
          ,Fields.InvalidMessage_mfgmat_paid_slope_0t12(1),Fields.InvalidMessage_mfgmat_paid_slope_0t12(2)
          ,Fields.InvalidMessage_mfgmat_paid_slope_0t24(1),Fields.InvalidMessage_mfgmat_paid_slope_0t24(2)
          ,Fields.InvalidMessage_mfgmat_paid_slope_0t6(1),Fields.InvalidMessage_mfgmat_paid_slope_0t6(2)
          ,Fields.InvalidMessage_mfgmat_paid_volatility_0t12(1),Fields.InvalidMessage_mfgmat_paid_volatility_0t12(2)
          ,Fields.InvalidMessage_mfgmat_paid_volatility_0t6(1),Fields.InvalidMessage_mfgmat_paid_volatility_0t6(2)
          ,Fields.InvalidMessage_mfgmat_spend_monthspastleast_24(1),Fields.InvalidMessage_mfgmat_spend_monthspastleast_24(2)
          ,Fields.InvalidMessage_mfgmat_spend_monthspastmost_24(1),Fields.InvalidMessage_mfgmat_spend_monthspastmost_24(2)
          ,Fields.InvalidMessage_mfgmat_spend_slope_0t12(1),Fields.InvalidMessage_mfgmat_spend_slope_0t12(2)
          ,Fields.InvalidMessage_mfgmat_spend_slope_0t24(1),Fields.InvalidMessage_mfgmat_spend_slope_0t24(2)
          ,Fields.InvalidMessage_mfgmat_spend_slope_0t6(1),Fields.InvalidMessage_mfgmat_spend_slope_0t6(2)
          ,Fields.InvalidMessage_mfgmat_spend_sum_12(1),Fields.InvalidMessage_mfgmat_spend_sum_12(2)
          ,Fields.InvalidMessage_mfgmat_spend_volatility_0t6(1),Fields.InvalidMessage_mfgmat_spend_volatility_0t6(2)
          ,Fields.InvalidMessage_mfgmat_spend_volatility_6t12(1),Fields.InvalidMessage_mfgmat_spend_volatility_6t12(2)
          ,Fields.InvalidMessage_ops_paid_average_12(1),Fields.InvalidMessage_ops_paid_average_12(2)
          ,Fields.InvalidMessage_ops_paid_monthspastworst_24(1),Fields.InvalidMessage_ops_paid_monthspastworst_24(2)
          ,Fields.InvalidMessage_ops_paid_slope_0t12(1),Fields.InvalidMessage_ops_paid_slope_0t12(2)
          ,Fields.InvalidMessage_ops_paid_slope_0t24(1),Fields.InvalidMessage_ops_paid_slope_0t24(2)
          ,Fields.InvalidMessage_ops_paid_slope_0t6(1),Fields.InvalidMessage_ops_paid_slope_0t6(2)
          ,Fields.InvalidMessage_ops_paid_volatility_0t12(1),Fields.InvalidMessage_ops_paid_volatility_0t12(2)
          ,Fields.InvalidMessage_ops_paid_volatility_0t6(1),Fields.InvalidMessage_ops_paid_volatility_0t6(2)
          ,Fields.InvalidMessage_ops_spend_monthspastleast_24(1),Fields.InvalidMessage_ops_spend_monthspastleast_24(2)
          ,Fields.InvalidMessage_ops_spend_monthspastmost_24(1),Fields.InvalidMessage_ops_spend_monthspastmost_24(2)
          ,Fields.InvalidMessage_ops_spend_slope_0t12(1),Fields.InvalidMessage_ops_spend_slope_0t12(2)
          ,Fields.InvalidMessage_ops_spend_slope_0t24(1),Fields.InvalidMessage_ops_spend_slope_0t24(2)
          ,Fields.InvalidMessage_ops_spend_slope_0t6(1),Fields.InvalidMessage_ops_spend_slope_0t6(2)
          ,Fields.InvalidMessage_fleet_paid_monthspastworst_24(1),Fields.InvalidMessage_fleet_paid_monthspastworst_24(2)
          ,Fields.InvalidMessage_fleet_paid_slope_0t12(1),Fields.InvalidMessage_fleet_paid_slope_0t12(2)
          ,Fields.InvalidMessage_fleet_paid_slope_0t24(1),Fields.InvalidMessage_fleet_paid_slope_0t24(2)
          ,Fields.InvalidMessage_fleet_paid_slope_0t6(1),Fields.InvalidMessage_fleet_paid_slope_0t6(2)
          ,Fields.InvalidMessage_fleet_paid_volatility_0t12(1),Fields.InvalidMessage_fleet_paid_volatility_0t12(2)
          ,Fields.InvalidMessage_fleet_paid_volatility_0t6(1),Fields.InvalidMessage_fleet_paid_volatility_0t6(2)
          ,Fields.InvalidMessage_fleet_spend_slope_0t12(1),Fields.InvalidMessage_fleet_spend_slope_0t12(2)
          ,Fields.InvalidMessage_fleet_spend_slope_0t24(1),Fields.InvalidMessage_fleet_spend_slope_0t24(2)
          ,Fields.InvalidMessage_fleet_spend_slope_0t6(1),Fields.InvalidMessage_fleet_spend_slope_0t6(2)
          ,Fields.InvalidMessage_carrier_paid_slope_0t12(1),Fields.InvalidMessage_carrier_paid_slope_0t12(2)
          ,Fields.InvalidMessage_carrier_paid_slope_0t24(1),Fields.InvalidMessage_carrier_paid_slope_0t24(2)
          ,Fields.InvalidMessage_carrier_paid_slope_0t6(1),Fields.InvalidMessage_carrier_paid_slope_0t6(2)
          ,Fields.InvalidMessage_carrier_paid_volatility_0t12(1),Fields.InvalidMessage_carrier_paid_volatility_0t12(2)
          ,Fields.InvalidMessage_carrier_paid_volatility_0t6(1),Fields.InvalidMessage_carrier_paid_volatility_0t6(2)
          ,Fields.InvalidMessage_carrier_spend_slope_0t12(1),Fields.InvalidMessage_carrier_spend_slope_0t12(2)
          ,Fields.InvalidMessage_carrier_spend_slope_0t24(1),Fields.InvalidMessage_carrier_spend_slope_0t24(2)
          ,Fields.InvalidMessage_carrier_spend_slope_0t6(1),Fields.InvalidMessage_carrier_spend_slope_0t6(2)
          ,Fields.InvalidMessage_carrier_spend_volatility_0t6(1),Fields.InvalidMessage_carrier_spend_volatility_0t6(2)
          ,Fields.InvalidMessage_carrier_spend_volatility_6t12(1),Fields.InvalidMessage_carrier_spend_volatility_6t12(2)
          ,Fields.InvalidMessage_bldgmats_paid_slope_0t12(1),Fields.InvalidMessage_bldgmats_paid_slope_0t12(2)
          ,Fields.InvalidMessage_bldgmats_paid_slope_0t24(1),Fields.InvalidMessage_bldgmats_paid_slope_0t24(2)
          ,Fields.InvalidMessage_bldgmats_paid_slope_0t6(1),Fields.InvalidMessage_bldgmats_paid_slope_0t6(2)
          ,Fields.InvalidMessage_bldgmats_paid_volatility_0t12(1),Fields.InvalidMessage_bldgmats_paid_volatility_0t12(2)
          ,Fields.InvalidMessage_bldgmats_paid_volatility_0t6(1),Fields.InvalidMessage_bldgmats_paid_volatility_0t6(2)
          ,Fields.InvalidMessage_bldgmats_spend_slope_0t12(1),Fields.InvalidMessage_bldgmats_spend_slope_0t12(2)
          ,Fields.InvalidMessage_bldgmats_spend_slope_0t24(1),Fields.InvalidMessage_bldgmats_spend_slope_0t24(2)
          ,Fields.InvalidMessage_bldgmats_spend_slope_0t6(1),Fields.InvalidMessage_bldgmats_spend_slope_0t6(2)
          ,Fields.InvalidMessage_bldgmats_spend_volatility_0t6(1),Fields.InvalidMessage_bldgmats_spend_volatility_0t6(2)
          ,Fields.InvalidMessage_bldgmats_spend_volatility_6t12(1),Fields.InvalidMessage_bldgmats_spend_volatility_6t12(2)
          ,Fields.InvalidMessage_top5_paid_slope_0t12(1),Fields.InvalidMessage_top5_paid_slope_0t12(2)
          ,Fields.InvalidMessage_top5_paid_slope_0t24(1),Fields.InvalidMessage_top5_paid_slope_0t24(2)
          ,Fields.InvalidMessage_top5_paid_slope_0t6(1),Fields.InvalidMessage_top5_paid_slope_0t6(2)
          ,Fields.InvalidMessage_top5_paid_volatility_0t12(1),Fields.InvalidMessage_top5_paid_volatility_0t12(2)
          ,Fields.InvalidMessage_top5_paid_volatility_0t6(1),Fields.InvalidMessage_top5_paid_volatility_0t6(2)
          ,Fields.InvalidMessage_top5_spend_slope_0t12(1),Fields.InvalidMessage_top5_spend_slope_0t12(2)
          ,Fields.InvalidMessage_top5_spend_slope_0t24(1),Fields.InvalidMessage_top5_spend_slope_0t24(2)
          ,Fields.InvalidMessage_top5_spend_slope_0t6(1),Fields.InvalidMessage_top5_spend_slope_0t6(2)
          ,Fields.InvalidMessage_top5_spend_volatility_0t6(1),Fields.InvalidMessage_top5_spend_volatility_0t6(2)
          ,Fields.InvalidMessage_top5_spend_volatility_6t12(1),Fields.InvalidMessage_top5_spend_volatility_6t12(2)
          ,Fields.InvalidMessage_total_numrel_slope_0t12(1),Fields.InvalidMessage_total_numrel_slope_0t12(2)
          ,Fields.InvalidMessage_total_numrel_slope_0t24(1),Fields.InvalidMessage_total_numrel_slope_0t24(2)
          ,Fields.InvalidMessage_total_numrel_slope_0t6(1),Fields.InvalidMessage_total_numrel_slope_0t6(2)
          ,Fields.InvalidMessage_total_numrel_slope_6t12(1),Fields.InvalidMessage_total_numrel_slope_6t12(2)
          ,Fields.InvalidMessage_mfgmat_numrel_slope_0t12(1),Fields.InvalidMessage_mfgmat_numrel_slope_0t12(2)
          ,Fields.InvalidMessage_mfgmat_numrel_slope_0t24(1),Fields.InvalidMessage_mfgmat_numrel_slope_0t24(2)
          ,Fields.InvalidMessage_mfgmat_numrel_slope_0t6(1),Fields.InvalidMessage_mfgmat_numrel_slope_0t6(2)
          ,Fields.InvalidMessage_mfgmat_numrel_slope_6t12(1),Fields.InvalidMessage_mfgmat_numrel_slope_6t12(2)
          ,Fields.InvalidMessage_ops_numrel_slope_0t12(1),Fields.InvalidMessage_ops_numrel_slope_0t12(2)
          ,Fields.InvalidMessage_ops_numrel_slope_0t24(1),Fields.InvalidMessage_ops_numrel_slope_0t24(2)
          ,Fields.InvalidMessage_ops_numrel_slope_0t6(1),Fields.InvalidMessage_ops_numrel_slope_0t6(2)
          ,Fields.InvalidMessage_ops_numrel_slope_6t12(1),Fields.InvalidMessage_ops_numrel_slope_6t12(2)
          ,Fields.InvalidMessage_fleet_numrel_slope_0t12(1),Fields.InvalidMessage_fleet_numrel_slope_0t12(2)
          ,Fields.InvalidMessage_fleet_numrel_slope_0t24(1),Fields.InvalidMessage_fleet_numrel_slope_0t24(2)
          ,Fields.InvalidMessage_fleet_numrel_slope_0t6(1),Fields.InvalidMessage_fleet_numrel_slope_0t6(2)
          ,Fields.InvalidMessage_fleet_numrel_slope_6t12(1),Fields.InvalidMessage_fleet_numrel_slope_6t12(2)
          ,Fields.InvalidMessage_carrier_numrel_slope_0t12(1),Fields.InvalidMessage_carrier_numrel_slope_0t12(2)
          ,Fields.InvalidMessage_carrier_numrel_slope_0t24(1),Fields.InvalidMessage_carrier_numrel_slope_0t24(2)
          ,Fields.InvalidMessage_carrier_numrel_slope_0t6(1),Fields.InvalidMessage_carrier_numrel_slope_0t6(2)
          ,Fields.InvalidMessage_carrier_numrel_slope_6t12(1),Fields.InvalidMessage_carrier_numrel_slope_6t12(2)
          ,Fields.InvalidMessage_bldgmats_numrel_slope_0t12(1),Fields.InvalidMessage_bldgmats_numrel_slope_0t12(2)
          ,Fields.InvalidMessage_bldgmats_numrel_slope_0t24(1),Fields.InvalidMessage_bldgmats_numrel_slope_0t24(2)
          ,Fields.InvalidMessage_bldgmats_numrel_slope_0t6(1),Fields.InvalidMessage_bldgmats_numrel_slope_0t6(2)
          ,Fields.InvalidMessage_bldgmats_numrel_slope_6t12(1),Fields.InvalidMessage_bldgmats_numrel_slope_6t12(2)
          ,Fields.InvalidMessage_bldgmats_numrel_var_0t12(1),Fields.InvalidMessage_bldgmats_numrel_var_0t12(2)
          ,Fields.InvalidMessage_bldgmats_numrel_var_12t24(1),Fields.InvalidMessage_bldgmats_numrel_var_12t24(2)
          ,Fields.InvalidMessage_total_percprov30_slope_0t12(1),Fields.InvalidMessage_total_percprov30_slope_0t12(2)
          ,Fields.InvalidMessage_total_percprov30_slope_0t24(1),Fields.InvalidMessage_total_percprov30_slope_0t24(2)
          ,Fields.InvalidMessage_total_percprov30_slope_0t6(1),Fields.InvalidMessage_total_percprov30_slope_0t6(2)
          ,Fields.InvalidMessage_total_percprov30_slope_6t12(1),Fields.InvalidMessage_total_percprov30_slope_6t12(2)
          ,Fields.InvalidMessage_total_percprov60_slope_0t12(1),Fields.InvalidMessage_total_percprov60_slope_0t12(2)
          ,Fields.InvalidMessage_total_percprov60_slope_0t24(1),Fields.InvalidMessage_total_percprov60_slope_0t24(2)
          ,Fields.InvalidMessage_total_percprov60_slope_0t6(1),Fields.InvalidMessage_total_percprov60_slope_0t6(2)
          ,Fields.InvalidMessage_total_percprov60_slope_6t12(1),Fields.InvalidMessage_total_percprov60_slope_6t12(2)
          ,Fields.InvalidMessage_total_percprov90_slope_0t24(1),Fields.InvalidMessage_total_percprov90_slope_0t24(2)
          ,Fields.InvalidMessage_total_percprov90_slope_0t6(1),Fields.InvalidMessage_total_percprov90_slope_0t6(2)
          ,Fields.InvalidMessage_total_percprov90_slope_6t12(1),Fields.InvalidMessage_total_percprov90_slope_6t12(2)
          ,Fields.InvalidMessage_mfgmat_percprov30_slope_0t12(1),Fields.InvalidMessage_mfgmat_percprov30_slope_0t12(2)
          ,Fields.InvalidMessage_mfgmat_percprov30_slope_6t12(1),Fields.InvalidMessage_mfgmat_percprov30_slope_6t12(2)
          ,Fields.InvalidMessage_mfgmat_percprov60_slope_0t12(1),Fields.InvalidMessage_mfgmat_percprov60_slope_0t12(2)
          ,Fields.InvalidMessage_mfgmat_percprov60_slope_6t12(1),Fields.InvalidMessage_mfgmat_percprov60_slope_6t12(2)
          ,Fields.InvalidMessage_mfgmat_percprov90_slope_0t24(1),Fields.InvalidMessage_mfgmat_percprov90_slope_0t24(2)
          ,Fields.InvalidMessage_mfgmat_percprov90_slope_0t6(1),Fields.InvalidMessage_mfgmat_percprov90_slope_0t6(2)
          ,Fields.InvalidMessage_mfgmat_percprov90_slope_6t12(1),Fields.InvalidMessage_mfgmat_percprov90_slope_6t12(2)
          ,Fields.InvalidMessage_ops_percprov30_slope_0t12(1),Fields.InvalidMessage_ops_percprov30_slope_0t12(2)
          ,Fields.InvalidMessage_ops_percprov30_slope_6t12(1),Fields.InvalidMessage_ops_percprov30_slope_6t12(2)
          ,Fields.InvalidMessage_ops_percprov60_slope_0t12(1),Fields.InvalidMessage_ops_percprov60_slope_0t12(2)
          ,Fields.InvalidMessage_ops_percprov60_slope_6t12(1),Fields.InvalidMessage_ops_percprov60_slope_6t12(2)
          ,Fields.InvalidMessage_ops_percprov90_slope_0t24(1),Fields.InvalidMessage_ops_percprov90_slope_0t24(2)
          ,Fields.InvalidMessage_ops_percprov90_slope_0t6(1),Fields.InvalidMessage_ops_percprov90_slope_0t6(2)
          ,Fields.InvalidMessage_ops_percprov90_slope_6t12(1),Fields.InvalidMessage_ops_percprov90_slope_6t12(2)
          ,Fields.InvalidMessage_fleet_percprov30_slope_0t12(1),Fields.InvalidMessage_fleet_percprov30_slope_0t12(2)
          ,Fields.InvalidMessage_fleet_percprov30_slope_6t12(1),Fields.InvalidMessage_fleet_percprov30_slope_6t12(2)
          ,Fields.InvalidMessage_fleet_percprov60_slope_0t12(1),Fields.InvalidMessage_fleet_percprov60_slope_0t12(2)
          ,Fields.InvalidMessage_fleet_percprov60_slope_6t12(1),Fields.InvalidMessage_fleet_percprov60_slope_6t12(2)
          ,Fields.InvalidMessage_fleet_percprov90_slope_0t24(1),Fields.InvalidMessage_fleet_percprov90_slope_0t24(2)
          ,Fields.InvalidMessage_fleet_percprov90_slope_0t6(1),Fields.InvalidMessage_fleet_percprov90_slope_0t6(2)
          ,Fields.InvalidMessage_fleet_percprov90_slope_6t12(1),Fields.InvalidMessage_fleet_percprov90_slope_6t12(2)
          ,Fields.InvalidMessage_carrier_percprov30_slope_0t12(1),Fields.InvalidMessage_carrier_percprov30_slope_0t12(2)
          ,Fields.InvalidMessage_carrier_percprov30_slope_6t12(1),Fields.InvalidMessage_carrier_percprov30_slope_6t12(2)
          ,Fields.InvalidMessage_carrier_percprov60_slope_0t12(1),Fields.InvalidMessage_carrier_percprov60_slope_0t12(2)
          ,Fields.InvalidMessage_carrier_percprov60_slope_6t12(1),Fields.InvalidMessage_carrier_percprov60_slope_6t12(2)
          ,Fields.InvalidMessage_carrier_percprov90_slope_0t24(1),Fields.InvalidMessage_carrier_percprov90_slope_0t24(2)
          ,Fields.InvalidMessage_carrier_percprov90_slope_0t6(1),Fields.InvalidMessage_carrier_percprov90_slope_0t6(2)
          ,Fields.InvalidMessage_carrier_percprov90_slope_6t12(1),Fields.InvalidMessage_carrier_percprov90_slope_6t12(2)
          ,Fields.InvalidMessage_bldgmats_percprov30_slope_0t12(1),Fields.InvalidMessage_bldgmats_percprov30_slope_0t12(2)
          ,Fields.InvalidMessage_bldgmats_percprov30_slope_6t12(1),Fields.InvalidMessage_bldgmats_percprov30_slope_6t12(2)
          ,Fields.InvalidMessage_bldgmats_percprov60_slope_0t12(1),Fields.InvalidMessage_bldgmats_percprov60_slope_0t12(2)
          ,Fields.InvalidMessage_bldgmats_percprov60_slope_6t12(1),Fields.InvalidMessage_bldgmats_percprov60_slope_6t12(2)
          ,Fields.InvalidMessage_bldgmats_percprov90_slope_0t24(1),Fields.InvalidMessage_bldgmats_percprov90_slope_0t24(2)
          ,Fields.InvalidMessage_bldgmats_percprov90_slope_0t6(1),Fields.InvalidMessage_bldgmats_percprov90_slope_0t6(2)
          ,Fields.InvalidMessage_bldgmats_percprov90_slope_6t12(1),Fields.InvalidMessage_bldgmats_percprov90_slope_6t12(2)
          ,Fields.InvalidMessage_top5_percprov30_slope_0t12(1),Fields.InvalidMessage_top5_percprov30_slope_0t12(2)
          ,Fields.InvalidMessage_top5_percprov30_slope_6t12(1),Fields.InvalidMessage_top5_percprov30_slope_6t12(2)
          ,Fields.InvalidMessage_top5_percprov60_slope_0t12(1),Fields.InvalidMessage_top5_percprov60_slope_0t12(2)
          ,Fields.InvalidMessage_top5_percprov60_slope_6t12(1),Fields.InvalidMessage_top5_percprov60_slope_6t12(2)
          ,Fields.InvalidMessage_top5_percprov90_slope_0t24(1),Fields.InvalidMessage_top5_percprov90_slope_0t24(2)
          ,Fields.InvalidMessage_top5_percprov90_slope_0t6(1),Fields.InvalidMessage_top5_percprov90_slope_0t6(2)
          ,Fields.InvalidMessage_top5_percprov90_slope_6t12(1),Fields.InvalidMessage_top5_percprov90_slope_6t12(2)
          ,Fields.InvalidMessage_top5_percprovoutstanding_adjustedslope_0t12(1),Fields.InvalidMessage_top5_percprovoutstanding_adjustedslope_0t12(2),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.ultimate_linkid_ALLOW_ErrorCount,le.ultimate_linkid_LENGTH_ErrorCount
          ,le.cortera_score_ALLOW_ErrorCount,le.cortera_score_LENGTH_ErrorCount
          ,le.cpr_score_ALLOW_ErrorCount,le.cpr_score_LENGTH_ErrorCount
          ,le.cpr_segment_ALLOW_ErrorCount,le.cpr_segment_LENGTH_ErrorCount
          ,le.dbt_ALLOW_ErrorCount,le.dbt_LENGTH_ErrorCount
          ,le.avg_bal_ALLOW_ErrorCount,le.avg_bal_LENGTH_ErrorCount
          ,le.air_spend_ALLOW_ErrorCount,le.air_spend_LENGTH_ErrorCount
          ,le.fuel_spend_ALLOW_ErrorCount,le.fuel_spend_LENGTH_ErrorCount
          ,le.leasing_spend_ALLOW_ErrorCount,le.leasing_spend_LENGTH_ErrorCount
          ,le.ltl_spend_ALLOW_ErrorCount,le.ltl_spend_LENGTH_ErrorCount
          ,le.rail_spend_ALLOW_ErrorCount,le.rail_spend_LENGTH_ErrorCount
          ,le.tl_spend_ALLOW_ErrorCount,le.tl_spend_LENGTH_ErrorCount
          ,le.transvc_spend_ALLOW_ErrorCount,le.transvc_spend_LENGTH_ErrorCount
          ,le.transup_spend_ALLOW_ErrorCount,le.transup_spend_LENGTH_ErrorCount
          ,le.bst_spend_ALLOW_ErrorCount,le.bst_spend_LENGTH_ErrorCount
          ,le.dg_spend_ALLOW_ErrorCount,le.dg_spend_LENGTH_ErrorCount
          ,le.electrical_spend_ALLOW_ErrorCount,le.electrical_spend_LENGTH_ErrorCount
          ,le.hvac_spend_ALLOW_ErrorCount,le.hvac_spend_LENGTH_ErrorCount
          ,le.other_b_spend_ALLOW_ErrorCount,le.other_b_spend_LENGTH_ErrorCount
          ,le.plumbing_spend_ALLOW_ErrorCount,le.plumbing_spend_LENGTH_ErrorCount
          ,le.rs_spend_ALLOW_ErrorCount,le.rs_spend_LENGTH_ErrorCount
          ,le.wp_spend_ALLOW_ErrorCount,le.wp_spend_LENGTH_ErrorCount
          ,le.chemical_spend_ALLOW_ErrorCount,le.chemical_spend_LENGTH_ErrorCount
          ,le.electronic_spend_ALLOW_ErrorCount,le.electronic_spend_LENGTH_ErrorCount
          ,le.metal_spend_ALLOW_ErrorCount,le.metal_spend_LENGTH_ErrorCount
          ,le.other_m_spend_ALLOW_ErrorCount,le.other_m_spend_LENGTH_ErrorCount
          ,le.packaging_spend_ALLOW_ErrorCount,le.packaging_spend_LENGTH_ErrorCount
          ,le.pvf_spend_ALLOW_ErrorCount,le.pvf_spend_LENGTH_ErrorCount
          ,le.plastic_spend_ALLOW_ErrorCount,le.plastic_spend_LENGTH_ErrorCount
          ,le.textile_spend_ALLOW_ErrorCount,le.textile_spend_LENGTH_ErrorCount
          ,le.bs_spend_ALLOW_ErrorCount,le.bs_spend_LENGTH_ErrorCount
          ,le.ce_spend_ALLOW_ErrorCount,le.ce_spend_LENGTH_ErrorCount
          ,le.hardware_spend_ALLOW_ErrorCount,le.hardware_spend_LENGTH_ErrorCount
          ,le.ie_spend_ALLOW_ErrorCount,le.ie_spend_LENGTH_ErrorCount
          ,le.is_spend_ALLOW_ErrorCount,le.is_spend_LENGTH_ErrorCount
          ,le.it_spend_ALLOW_ErrorCount,le.it_spend_LENGTH_ErrorCount
          ,le.mls_spend_ALLOW_ErrorCount,le.mls_spend_LENGTH_ErrorCount
          ,le.os_spend_ALLOW_ErrorCount,le.os_spend_LENGTH_ErrorCount
          ,le.pp_spend_ALLOW_ErrorCount,le.pp_spend_LENGTH_ErrorCount
          ,le.sis_spend_ALLOW_ErrorCount,le.sis_spend_LENGTH_ErrorCount
          ,le.apparel_spend_ALLOW_ErrorCount,le.apparel_spend_LENGTH_ErrorCount
          ,le.beverages_spend_ALLOW_ErrorCount,le.beverages_spend_LENGTH_ErrorCount
          ,le.constr_spend_ALLOW_ErrorCount,le.constr_spend_LENGTH_ErrorCount
          ,le.consulting_spend_ALLOW_ErrorCount,le.consulting_spend_LENGTH_ErrorCount
          ,le.fs_spend_ALLOW_ErrorCount,le.fs_spend_LENGTH_ErrorCount
          ,le.fp_spend_ALLOW_ErrorCount,le.fp_spend_LENGTH_ErrorCount
          ,le.insurance_spend_ALLOW_ErrorCount,le.insurance_spend_LENGTH_ErrorCount
          ,le.ls_spend_ALLOW_ErrorCount,le.ls_spend_LENGTH_ErrorCount
          ,le.oil_gas_spend_ALLOW_ErrorCount,le.oil_gas_spend_LENGTH_ErrorCount
          ,le.utilities_spend_ALLOW_ErrorCount,le.utilities_spend_LENGTH_ErrorCount
          ,le.other_spend_ALLOW_ErrorCount,le.other_spend_LENGTH_ErrorCount
          ,le.advt_spend_ALLOW_ErrorCount,le.advt_spend_LENGTH_ErrorCount
          ,le.air_growth_ALLOW_ErrorCount,le.air_growth_LENGTH_ErrorCount
          ,le.fuel_growth_ALLOW_ErrorCount,le.fuel_growth_LENGTH_ErrorCount
          ,le.leasing_growth_ALLOW_ErrorCount,le.leasing_growth_LENGTH_ErrorCount
          ,le.ltl_growth_ALLOW_ErrorCount,le.ltl_growth_LENGTH_ErrorCount
          ,le.rail_growth_ALLOW_ErrorCount,le.rail_growth_LENGTH_ErrorCount
          ,le.tl_growth_ALLOW_ErrorCount,le.tl_growth_LENGTH_ErrorCount
          ,le.transvc_growth_ALLOW_ErrorCount,le.transvc_growth_LENGTH_ErrorCount
          ,le.transup_growth_ALLOW_ErrorCount,le.transup_growth_LENGTH_ErrorCount
          ,le.bst_growth_ALLOW_ErrorCount,le.bst_growth_LENGTH_ErrorCount
          ,le.dg_growth_ALLOW_ErrorCount,le.dg_growth_LENGTH_ErrorCount
          ,le.electrical_growth_ALLOW_ErrorCount,le.electrical_growth_LENGTH_ErrorCount
          ,le.hvac_growth_ALLOW_ErrorCount,le.hvac_growth_LENGTH_ErrorCount
          ,le.other_b_growth_ALLOW_ErrorCount,le.other_b_growth_LENGTH_ErrorCount
          ,le.plumbing_growth_ALLOW_ErrorCount,le.plumbing_growth_LENGTH_ErrorCount
          ,le.rs_growth_ALLOW_ErrorCount,le.rs_growth_LENGTH_ErrorCount
          ,le.wp_growth_ALLOW_ErrorCount,le.wp_growth_LENGTH_ErrorCount
          ,le.chemical_growth_ALLOW_ErrorCount,le.chemical_growth_LENGTH_ErrorCount
          ,le.electronic_growth_ALLOW_ErrorCount,le.electronic_growth_LENGTH_ErrorCount
          ,le.metal_growth_ALLOW_ErrorCount,le.metal_growth_LENGTH_ErrorCount
          ,le.other_m_growth_ALLOW_ErrorCount,le.other_m_growth_LENGTH_ErrorCount
          ,le.packaging_growth_ALLOW_ErrorCount,le.packaging_growth_LENGTH_ErrorCount
          ,le.pvf_growth_ALLOW_ErrorCount,le.pvf_growth_LENGTH_ErrorCount
          ,le.plastic_growth_ALLOW_ErrorCount,le.plastic_growth_LENGTH_ErrorCount
          ,le.textile_growth_ALLOW_ErrorCount,le.textile_growth_LENGTH_ErrorCount
          ,le.bs_growth_ALLOW_ErrorCount,le.bs_growth_LENGTH_ErrorCount
          ,le.ce_growth_ALLOW_ErrorCount,le.ce_growth_LENGTH_ErrorCount
          ,le.hardware_growth_ALLOW_ErrorCount,le.hardware_growth_LENGTH_ErrorCount
          ,le.ie_growth_ALLOW_ErrorCount,le.ie_growth_LENGTH_ErrorCount
          ,le.is_growth_ALLOW_ErrorCount,le.is_growth_LENGTH_ErrorCount
          ,le.it_growth_ALLOW_ErrorCount,le.it_growth_LENGTH_ErrorCount
          ,le.mls_growth_ALLOW_ErrorCount,le.mls_growth_LENGTH_ErrorCount
          ,le.os_growth_ALLOW_ErrorCount,le.os_growth_LENGTH_ErrorCount
          ,le.pp_growth_ALLOW_ErrorCount,le.pp_growth_LENGTH_ErrorCount
          ,le.sis_growth_ALLOW_ErrorCount,le.sis_growth_LENGTH_ErrorCount
          ,le.apparel_growth_ALLOW_ErrorCount,le.apparel_growth_LENGTH_ErrorCount
          ,le.beverages_growth_ALLOW_ErrorCount,le.beverages_growth_LENGTH_ErrorCount
          ,le.constr_growth_ALLOW_ErrorCount,le.constr_growth_LENGTH_ErrorCount
          ,le.consulting_growth_ALLOW_ErrorCount,le.consulting_growth_LENGTH_ErrorCount
          ,le.fs_growth_ALLOW_ErrorCount,le.fs_growth_LENGTH_ErrorCount
          ,le.fp_growth_ALLOW_ErrorCount,le.fp_growth_LENGTH_ErrorCount
          ,le.insurance_growth_ALLOW_ErrorCount,le.insurance_growth_LENGTH_ErrorCount
          ,le.ls_growth_ALLOW_ErrorCount,le.ls_growth_LENGTH_ErrorCount
          ,le.oil_gas_growth_ALLOW_ErrorCount,le.oil_gas_growth_LENGTH_ErrorCount
          ,le.utilities_growth_ALLOW_ErrorCount,le.utilities_growth_LENGTH_ErrorCount
          ,le.other_growth_ALLOW_ErrorCount,le.other_growth_LENGTH_ErrorCount
          ,le.advt_growth_ALLOW_ErrorCount,le.advt_growth_LENGTH_ErrorCount
          ,le.top5_growth_ALLOW_ErrorCount,le.top5_growth_LENGTH_ErrorCount
          ,le.shipping_y1_ALLOW_ErrorCount,le.shipping_y1_LENGTH_ErrorCount
          ,le.shipping_growth_ALLOW_ErrorCount,le.shipping_growth_LENGTH_ErrorCount
          ,le.materials_y1_ALLOW_ErrorCount,le.materials_y1_LENGTH_ErrorCount
          ,le.materials_growth_ALLOW_ErrorCount,le.materials_growth_LENGTH_ErrorCount
          ,le.operations_y1_ALLOW_ErrorCount,le.operations_y1_LENGTH_ErrorCount
          ,le.operations_growth_ALLOW_ErrorCount,le.operations_growth_LENGTH_ErrorCount
          ,le.total_paid_average_0t12_ALLOW_ErrorCount,le.total_paid_average_0t12_LENGTH_ErrorCount
          ,le.total_paid_monthspastworst_24_ALLOW_ErrorCount,le.total_paid_monthspastworst_24_LENGTH_ErrorCount
          ,le.total_paid_slope_0t12_ALLOW_ErrorCount,le.total_paid_slope_0t12_LENGTH_ErrorCount
          ,le.total_paid_slope_0t6_ALLOW_ErrorCount,le.total_paid_slope_0t6_LENGTH_ErrorCount
          ,le.total_paid_slope_6t12_ALLOW_ErrorCount,le.total_paid_slope_6t12_LENGTH_ErrorCount
          ,le.total_paid_slope_6t18_ALLOW_ErrorCount,le.total_paid_slope_6t18_LENGTH_ErrorCount
          ,le.total_paid_volatility_0t12_ALLOW_ErrorCount,le.total_paid_volatility_0t12_LENGTH_ErrorCount
          ,le.total_paid_volatility_0t6_ALLOW_ErrorCount,le.total_paid_volatility_0t6_LENGTH_ErrorCount
          ,le.total_paid_volatility_12t18_ALLOW_ErrorCount,le.total_paid_volatility_12t18_LENGTH_ErrorCount
          ,le.total_paid_volatility_6t12_ALLOW_ErrorCount,le.total_paid_volatility_6t12_LENGTH_ErrorCount
          ,le.total_spend_monthspastleast_24_ALLOW_ErrorCount,le.total_spend_monthspastleast_24_LENGTH_ErrorCount
          ,le.total_spend_monthspastmost_24_ALLOW_ErrorCount,le.total_spend_monthspastmost_24_LENGTH_ErrorCount
          ,le.total_spend_slope_0t12_ALLOW_ErrorCount,le.total_spend_slope_0t12_LENGTH_ErrorCount
          ,le.total_spend_slope_0t24_ALLOW_ErrorCount,le.total_spend_slope_0t24_LENGTH_ErrorCount
          ,le.total_spend_slope_0t6_ALLOW_ErrorCount,le.total_spend_slope_0t6_LENGTH_ErrorCount
          ,le.total_spend_slope_6t12_ALLOW_ErrorCount,le.total_spend_slope_6t12_LENGTH_ErrorCount
          ,le.total_spend_sum_12_ALLOW_ErrorCount,le.total_spend_sum_12_LENGTH_ErrorCount
          ,le.total_spend_volatility_0t12_ALLOW_ErrorCount,le.total_spend_volatility_0t12_LENGTH_ErrorCount
          ,le.total_spend_volatility_0t6_ALLOW_ErrorCount,le.total_spend_volatility_0t6_LENGTH_ErrorCount
          ,le.total_spend_volatility_12t18_ALLOW_ErrorCount,le.total_spend_volatility_12t18_LENGTH_ErrorCount
          ,le.total_spend_volatility_6t12_ALLOW_ErrorCount,le.total_spend_volatility_6t12_LENGTH_ErrorCount
          ,le.mfgmat_paid_average_12_ALLOW_ErrorCount,le.mfgmat_paid_average_12_LENGTH_ErrorCount
          ,le.mfgmat_paid_monthspastworst_24_ALLOW_ErrorCount,le.mfgmat_paid_monthspastworst_24_LENGTH_ErrorCount
          ,le.mfgmat_paid_slope_0t12_ALLOW_ErrorCount,le.mfgmat_paid_slope_0t12_LENGTH_ErrorCount
          ,le.mfgmat_paid_slope_0t24_ALLOW_ErrorCount,le.mfgmat_paid_slope_0t24_LENGTH_ErrorCount
          ,le.mfgmat_paid_slope_0t6_ALLOW_ErrorCount,le.mfgmat_paid_slope_0t6_LENGTH_ErrorCount
          ,le.mfgmat_paid_volatility_0t12_ALLOW_ErrorCount,le.mfgmat_paid_volatility_0t12_LENGTH_ErrorCount
          ,le.mfgmat_paid_volatility_0t6_ALLOW_ErrorCount,le.mfgmat_paid_volatility_0t6_LENGTH_ErrorCount
          ,le.mfgmat_spend_monthspastleast_24_ALLOW_ErrorCount,le.mfgmat_spend_monthspastleast_24_LENGTH_ErrorCount
          ,le.mfgmat_spend_monthspastmost_24_ALLOW_ErrorCount,le.mfgmat_spend_monthspastmost_24_LENGTH_ErrorCount
          ,le.mfgmat_spend_slope_0t12_ALLOW_ErrorCount,le.mfgmat_spend_slope_0t12_LENGTH_ErrorCount
          ,le.mfgmat_spend_slope_0t24_ALLOW_ErrorCount,le.mfgmat_spend_slope_0t24_LENGTH_ErrorCount
          ,le.mfgmat_spend_slope_0t6_ALLOW_ErrorCount,le.mfgmat_spend_slope_0t6_LENGTH_ErrorCount
          ,le.mfgmat_spend_sum_12_ALLOW_ErrorCount,le.mfgmat_spend_sum_12_LENGTH_ErrorCount
          ,le.mfgmat_spend_volatility_0t6_ALLOW_ErrorCount,le.mfgmat_spend_volatility_0t6_LENGTH_ErrorCount
          ,le.mfgmat_spend_volatility_6t12_ALLOW_ErrorCount,le.mfgmat_spend_volatility_6t12_LENGTH_ErrorCount
          ,le.ops_paid_average_12_ALLOW_ErrorCount,le.ops_paid_average_12_LENGTH_ErrorCount
          ,le.ops_paid_monthspastworst_24_ALLOW_ErrorCount,le.ops_paid_monthspastworst_24_LENGTH_ErrorCount
          ,le.ops_paid_slope_0t12_ALLOW_ErrorCount,le.ops_paid_slope_0t12_LENGTH_ErrorCount
          ,le.ops_paid_slope_0t24_ALLOW_ErrorCount,le.ops_paid_slope_0t24_LENGTH_ErrorCount
          ,le.ops_paid_slope_0t6_ALLOW_ErrorCount,le.ops_paid_slope_0t6_LENGTH_ErrorCount
          ,le.ops_paid_volatility_0t12_ALLOW_ErrorCount,le.ops_paid_volatility_0t12_LENGTH_ErrorCount
          ,le.ops_paid_volatility_0t6_ALLOW_ErrorCount,le.ops_paid_volatility_0t6_LENGTH_ErrorCount
          ,le.ops_spend_monthspastleast_24_ALLOW_ErrorCount,le.ops_spend_monthspastleast_24_LENGTH_ErrorCount
          ,le.ops_spend_monthspastmost_24_ALLOW_ErrorCount,le.ops_spend_monthspastmost_24_LENGTH_ErrorCount
          ,le.ops_spend_slope_0t12_ALLOW_ErrorCount,le.ops_spend_slope_0t12_LENGTH_ErrorCount
          ,le.ops_spend_slope_0t24_ALLOW_ErrorCount,le.ops_spend_slope_0t24_LENGTH_ErrorCount
          ,le.ops_spend_slope_0t6_ALLOW_ErrorCount,le.ops_spend_slope_0t6_LENGTH_ErrorCount
          ,le.fleet_paid_monthspastworst_24_ALLOW_ErrorCount,le.fleet_paid_monthspastworst_24_LENGTH_ErrorCount
          ,le.fleet_paid_slope_0t12_ALLOW_ErrorCount,le.fleet_paid_slope_0t12_LENGTH_ErrorCount
          ,le.fleet_paid_slope_0t24_ALLOW_ErrorCount,le.fleet_paid_slope_0t24_LENGTH_ErrorCount
          ,le.fleet_paid_slope_0t6_ALLOW_ErrorCount,le.fleet_paid_slope_0t6_LENGTH_ErrorCount
          ,le.fleet_paid_volatility_0t12_ALLOW_ErrorCount,le.fleet_paid_volatility_0t12_LENGTH_ErrorCount
          ,le.fleet_paid_volatility_0t6_ALLOW_ErrorCount,le.fleet_paid_volatility_0t6_LENGTH_ErrorCount
          ,le.fleet_spend_slope_0t12_ALLOW_ErrorCount,le.fleet_spend_slope_0t12_LENGTH_ErrorCount
          ,le.fleet_spend_slope_0t24_ALLOW_ErrorCount,le.fleet_spend_slope_0t24_LENGTH_ErrorCount
          ,le.fleet_spend_slope_0t6_ALLOW_ErrorCount,le.fleet_spend_slope_0t6_LENGTH_ErrorCount
          ,le.carrier_paid_slope_0t12_ALLOW_ErrorCount,le.carrier_paid_slope_0t12_LENGTH_ErrorCount
          ,le.carrier_paid_slope_0t24_ALLOW_ErrorCount,le.carrier_paid_slope_0t24_LENGTH_ErrorCount
          ,le.carrier_paid_slope_0t6_ALLOW_ErrorCount,le.carrier_paid_slope_0t6_LENGTH_ErrorCount
          ,le.carrier_paid_volatility_0t12_ALLOW_ErrorCount,le.carrier_paid_volatility_0t12_LENGTH_ErrorCount
          ,le.carrier_paid_volatility_0t6_ALLOW_ErrorCount,le.carrier_paid_volatility_0t6_LENGTH_ErrorCount
          ,le.carrier_spend_slope_0t12_ALLOW_ErrorCount,le.carrier_spend_slope_0t12_LENGTH_ErrorCount
          ,le.carrier_spend_slope_0t24_ALLOW_ErrorCount,le.carrier_spend_slope_0t24_LENGTH_ErrorCount
          ,le.carrier_spend_slope_0t6_ALLOW_ErrorCount,le.carrier_spend_slope_0t6_LENGTH_ErrorCount
          ,le.carrier_spend_volatility_0t6_ALLOW_ErrorCount,le.carrier_spend_volatility_0t6_LENGTH_ErrorCount
          ,le.carrier_spend_volatility_6t12_ALLOW_ErrorCount,le.carrier_spend_volatility_6t12_LENGTH_ErrorCount
          ,le.bldgmats_paid_slope_0t12_ALLOW_ErrorCount,le.bldgmats_paid_slope_0t12_LENGTH_ErrorCount
          ,le.bldgmats_paid_slope_0t24_ALLOW_ErrorCount,le.bldgmats_paid_slope_0t24_LENGTH_ErrorCount
          ,le.bldgmats_paid_slope_0t6_ALLOW_ErrorCount,le.bldgmats_paid_slope_0t6_LENGTH_ErrorCount
          ,le.bldgmats_paid_volatility_0t12_ALLOW_ErrorCount,le.bldgmats_paid_volatility_0t12_LENGTH_ErrorCount
          ,le.bldgmats_paid_volatility_0t6_ALLOW_ErrorCount,le.bldgmats_paid_volatility_0t6_LENGTH_ErrorCount
          ,le.bldgmats_spend_slope_0t12_ALLOW_ErrorCount,le.bldgmats_spend_slope_0t12_LENGTH_ErrorCount
          ,le.bldgmats_spend_slope_0t24_ALLOW_ErrorCount,le.bldgmats_spend_slope_0t24_LENGTH_ErrorCount
          ,le.bldgmats_spend_slope_0t6_ALLOW_ErrorCount,le.bldgmats_spend_slope_0t6_LENGTH_ErrorCount
          ,le.bldgmats_spend_volatility_0t6_ALLOW_ErrorCount,le.bldgmats_spend_volatility_0t6_LENGTH_ErrorCount
          ,le.bldgmats_spend_volatility_6t12_ALLOW_ErrorCount,le.bldgmats_spend_volatility_6t12_LENGTH_ErrorCount
          ,le.top5_paid_slope_0t12_ALLOW_ErrorCount,le.top5_paid_slope_0t12_LENGTH_ErrorCount
          ,le.top5_paid_slope_0t24_ALLOW_ErrorCount,le.top5_paid_slope_0t24_LENGTH_ErrorCount
          ,le.top5_paid_slope_0t6_ALLOW_ErrorCount,le.top5_paid_slope_0t6_LENGTH_ErrorCount
          ,le.top5_paid_volatility_0t12_ALLOW_ErrorCount,le.top5_paid_volatility_0t12_LENGTH_ErrorCount
          ,le.top5_paid_volatility_0t6_ALLOW_ErrorCount,le.top5_paid_volatility_0t6_LENGTH_ErrorCount
          ,le.top5_spend_slope_0t12_ALLOW_ErrorCount,le.top5_spend_slope_0t12_LENGTH_ErrorCount
          ,le.top5_spend_slope_0t24_ALLOW_ErrorCount,le.top5_spend_slope_0t24_LENGTH_ErrorCount
          ,le.top5_spend_slope_0t6_ALLOW_ErrorCount,le.top5_spend_slope_0t6_LENGTH_ErrorCount
          ,le.top5_spend_volatility_0t6_ALLOW_ErrorCount,le.top5_spend_volatility_0t6_LENGTH_ErrorCount
          ,le.top5_spend_volatility_6t12_ALLOW_ErrorCount,le.top5_spend_volatility_6t12_LENGTH_ErrorCount
          ,le.total_numrel_slope_0t12_ALLOW_ErrorCount,le.total_numrel_slope_0t12_LENGTH_ErrorCount
          ,le.total_numrel_slope_0t24_ALLOW_ErrorCount,le.total_numrel_slope_0t24_LENGTH_ErrorCount
          ,le.total_numrel_slope_0t6_ALLOW_ErrorCount,le.total_numrel_slope_0t6_LENGTH_ErrorCount
          ,le.total_numrel_slope_6t12_ALLOW_ErrorCount,le.total_numrel_slope_6t12_LENGTH_ErrorCount
          ,le.mfgmat_numrel_slope_0t12_ALLOW_ErrorCount,le.mfgmat_numrel_slope_0t12_LENGTH_ErrorCount
          ,le.mfgmat_numrel_slope_0t24_ALLOW_ErrorCount,le.mfgmat_numrel_slope_0t24_LENGTH_ErrorCount
          ,le.mfgmat_numrel_slope_0t6_ALLOW_ErrorCount,le.mfgmat_numrel_slope_0t6_LENGTH_ErrorCount
          ,le.mfgmat_numrel_slope_6t12_ALLOW_ErrorCount,le.mfgmat_numrel_slope_6t12_LENGTH_ErrorCount
          ,le.ops_numrel_slope_0t12_ALLOW_ErrorCount,le.ops_numrel_slope_0t12_LENGTH_ErrorCount
          ,le.ops_numrel_slope_0t24_ALLOW_ErrorCount,le.ops_numrel_slope_0t24_LENGTH_ErrorCount
          ,le.ops_numrel_slope_0t6_ALLOW_ErrorCount,le.ops_numrel_slope_0t6_LENGTH_ErrorCount
          ,le.ops_numrel_slope_6t12_ALLOW_ErrorCount,le.ops_numrel_slope_6t12_LENGTH_ErrorCount
          ,le.fleet_numrel_slope_0t12_ALLOW_ErrorCount,le.fleet_numrel_slope_0t12_LENGTH_ErrorCount
          ,le.fleet_numrel_slope_0t24_ALLOW_ErrorCount,le.fleet_numrel_slope_0t24_LENGTH_ErrorCount
          ,le.fleet_numrel_slope_0t6_ALLOW_ErrorCount,le.fleet_numrel_slope_0t6_LENGTH_ErrorCount
          ,le.fleet_numrel_slope_6t12_ALLOW_ErrorCount,le.fleet_numrel_slope_6t12_LENGTH_ErrorCount
          ,le.carrier_numrel_slope_0t12_ALLOW_ErrorCount,le.carrier_numrel_slope_0t12_LENGTH_ErrorCount
          ,le.carrier_numrel_slope_0t24_ALLOW_ErrorCount,le.carrier_numrel_slope_0t24_LENGTH_ErrorCount
          ,le.carrier_numrel_slope_0t6_ALLOW_ErrorCount,le.carrier_numrel_slope_0t6_LENGTH_ErrorCount
          ,le.carrier_numrel_slope_6t12_ALLOW_ErrorCount,le.carrier_numrel_slope_6t12_LENGTH_ErrorCount
          ,le.bldgmats_numrel_slope_0t12_ALLOW_ErrorCount,le.bldgmats_numrel_slope_0t12_LENGTH_ErrorCount
          ,le.bldgmats_numrel_slope_0t24_ALLOW_ErrorCount,le.bldgmats_numrel_slope_0t24_LENGTH_ErrorCount
          ,le.bldgmats_numrel_slope_0t6_ALLOW_ErrorCount,le.bldgmats_numrel_slope_0t6_LENGTH_ErrorCount
          ,le.bldgmats_numrel_slope_6t12_ALLOW_ErrorCount,le.bldgmats_numrel_slope_6t12_LENGTH_ErrorCount
          ,le.bldgmats_numrel_var_0t12_ALLOW_ErrorCount,le.bldgmats_numrel_var_0t12_LENGTH_ErrorCount
          ,le.bldgmats_numrel_var_12t24_ALLOW_ErrorCount,le.bldgmats_numrel_var_12t24_LENGTH_ErrorCount
          ,le.total_percprov30_slope_0t12_ALLOW_ErrorCount,le.total_percprov30_slope_0t12_LENGTH_ErrorCount
          ,le.total_percprov30_slope_0t24_ALLOW_ErrorCount,le.total_percprov30_slope_0t24_LENGTH_ErrorCount
          ,le.total_percprov30_slope_0t6_ALLOW_ErrorCount,le.total_percprov30_slope_0t6_LENGTH_ErrorCount
          ,le.total_percprov30_slope_6t12_ALLOW_ErrorCount,le.total_percprov30_slope_6t12_LENGTH_ErrorCount
          ,le.total_percprov60_slope_0t12_ALLOW_ErrorCount,le.total_percprov60_slope_0t12_LENGTH_ErrorCount
          ,le.total_percprov60_slope_0t24_ALLOW_ErrorCount,le.total_percprov60_slope_0t24_LENGTH_ErrorCount
          ,le.total_percprov60_slope_0t6_ALLOW_ErrorCount,le.total_percprov60_slope_0t6_LENGTH_ErrorCount
          ,le.total_percprov60_slope_6t12_ALLOW_ErrorCount,le.total_percprov60_slope_6t12_LENGTH_ErrorCount
          ,le.total_percprov90_slope_0t24_ALLOW_ErrorCount,le.total_percprov90_slope_0t24_LENGTH_ErrorCount
          ,le.total_percprov90_slope_0t6_ALLOW_ErrorCount,le.total_percprov90_slope_0t6_LENGTH_ErrorCount
          ,le.total_percprov90_slope_6t12_ALLOW_ErrorCount,le.total_percprov90_slope_6t12_LENGTH_ErrorCount
          ,le.mfgmat_percprov30_slope_0t12_ALLOW_ErrorCount,le.mfgmat_percprov30_slope_0t12_LENGTH_ErrorCount
          ,le.mfgmat_percprov30_slope_6t12_ALLOW_ErrorCount,le.mfgmat_percprov30_slope_6t12_LENGTH_ErrorCount
          ,le.mfgmat_percprov60_slope_0t12_ALLOW_ErrorCount,le.mfgmat_percprov60_slope_0t12_LENGTH_ErrorCount
          ,le.mfgmat_percprov60_slope_6t12_ALLOW_ErrorCount,le.mfgmat_percprov60_slope_6t12_LENGTH_ErrorCount
          ,le.mfgmat_percprov90_slope_0t24_ALLOW_ErrorCount,le.mfgmat_percprov90_slope_0t24_LENGTH_ErrorCount
          ,le.mfgmat_percprov90_slope_0t6_ALLOW_ErrorCount,le.mfgmat_percprov90_slope_0t6_LENGTH_ErrorCount
          ,le.mfgmat_percprov90_slope_6t12_ALLOW_ErrorCount,le.mfgmat_percprov90_slope_6t12_LENGTH_ErrorCount
          ,le.ops_percprov30_slope_0t12_ALLOW_ErrorCount,le.ops_percprov30_slope_0t12_LENGTH_ErrorCount
          ,le.ops_percprov30_slope_6t12_ALLOW_ErrorCount,le.ops_percprov30_slope_6t12_LENGTH_ErrorCount
          ,le.ops_percprov60_slope_0t12_ALLOW_ErrorCount,le.ops_percprov60_slope_0t12_LENGTH_ErrorCount
          ,le.ops_percprov60_slope_6t12_ALLOW_ErrorCount,le.ops_percprov60_slope_6t12_LENGTH_ErrorCount
          ,le.ops_percprov90_slope_0t24_ALLOW_ErrorCount,le.ops_percprov90_slope_0t24_LENGTH_ErrorCount
          ,le.ops_percprov90_slope_0t6_ALLOW_ErrorCount,le.ops_percprov90_slope_0t6_LENGTH_ErrorCount
          ,le.ops_percprov90_slope_6t12_ALLOW_ErrorCount,le.ops_percprov90_slope_6t12_LENGTH_ErrorCount
          ,le.fleet_percprov30_slope_0t12_ALLOW_ErrorCount,le.fleet_percprov30_slope_0t12_LENGTH_ErrorCount
          ,le.fleet_percprov30_slope_6t12_ALLOW_ErrorCount,le.fleet_percprov30_slope_6t12_LENGTH_ErrorCount
          ,le.fleet_percprov60_slope_0t12_ALLOW_ErrorCount,le.fleet_percprov60_slope_0t12_LENGTH_ErrorCount
          ,le.fleet_percprov60_slope_6t12_ALLOW_ErrorCount,le.fleet_percprov60_slope_6t12_LENGTH_ErrorCount
          ,le.fleet_percprov90_slope_0t24_ALLOW_ErrorCount,le.fleet_percprov90_slope_0t24_LENGTH_ErrorCount
          ,le.fleet_percprov90_slope_0t6_ALLOW_ErrorCount,le.fleet_percprov90_slope_0t6_LENGTH_ErrorCount
          ,le.fleet_percprov90_slope_6t12_ALLOW_ErrorCount,le.fleet_percprov90_slope_6t12_LENGTH_ErrorCount
          ,le.carrier_percprov30_slope_0t12_ALLOW_ErrorCount,le.carrier_percprov30_slope_0t12_LENGTH_ErrorCount
          ,le.carrier_percprov30_slope_6t12_ALLOW_ErrorCount,le.carrier_percprov30_slope_6t12_LENGTH_ErrorCount
          ,le.carrier_percprov60_slope_0t12_ALLOW_ErrorCount,le.carrier_percprov60_slope_0t12_LENGTH_ErrorCount
          ,le.carrier_percprov60_slope_6t12_ALLOW_ErrorCount,le.carrier_percprov60_slope_6t12_LENGTH_ErrorCount
          ,le.carrier_percprov90_slope_0t24_ALLOW_ErrorCount,le.carrier_percprov90_slope_0t24_LENGTH_ErrorCount
          ,le.carrier_percprov90_slope_0t6_ALLOW_ErrorCount,le.carrier_percprov90_slope_0t6_LENGTH_ErrorCount
          ,le.carrier_percprov90_slope_6t12_ALLOW_ErrorCount,le.carrier_percprov90_slope_6t12_LENGTH_ErrorCount
          ,le.bldgmats_percprov30_slope_0t12_ALLOW_ErrorCount,le.bldgmats_percprov30_slope_0t12_LENGTH_ErrorCount
          ,le.bldgmats_percprov30_slope_6t12_ALLOW_ErrorCount,le.bldgmats_percprov30_slope_6t12_LENGTH_ErrorCount
          ,le.bldgmats_percprov60_slope_0t12_ALLOW_ErrorCount,le.bldgmats_percprov60_slope_0t12_LENGTH_ErrorCount
          ,le.bldgmats_percprov60_slope_6t12_ALLOW_ErrorCount,le.bldgmats_percprov60_slope_6t12_LENGTH_ErrorCount
          ,le.bldgmats_percprov90_slope_0t24_ALLOW_ErrorCount,le.bldgmats_percprov90_slope_0t24_LENGTH_ErrorCount
          ,le.bldgmats_percprov90_slope_0t6_ALLOW_ErrorCount,le.bldgmats_percprov90_slope_0t6_LENGTH_ErrorCount
          ,le.bldgmats_percprov90_slope_6t12_ALLOW_ErrorCount,le.bldgmats_percprov90_slope_6t12_LENGTH_ErrorCount
          ,le.top5_percprov30_slope_0t12_ALLOW_ErrorCount,le.top5_percprov30_slope_0t12_LENGTH_ErrorCount
          ,le.top5_percprov30_slope_6t12_ALLOW_ErrorCount,le.top5_percprov30_slope_6t12_LENGTH_ErrorCount
          ,le.top5_percprov60_slope_0t12_ALLOW_ErrorCount,le.top5_percprov60_slope_0t12_LENGTH_ErrorCount
          ,le.top5_percprov60_slope_6t12_ALLOW_ErrorCount,le.top5_percprov60_slope_6t12_LENGTH_ErrorCount
          ,le.top5_percprov90_slope_0t24_ALLOW_ErrorCount,le.top5_percprov90_slope_0t24_LENGTH_ErrorCount
          ,le.top5_percprov90_slope_0t6_ALLOW_ErrorCount,le.top5_percprov90_slope_0t6_LENGTH_ErrorCount
          ,le.top5_percprov90_slope_6t12_ALLOW_ErrorCount,le.top5_percprov90_slope_6t12_LENGTH_ErrorCount
          ,le.top5_percprovoutstanding_adjustedslope_0t12_ALLOW_ErrorCount,le.top5_percprovoutstanding_adjustedslope_0t12_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.ultimate_linkid_ALLOW_ErrorCount,le.ultimate_linkid_LENGTH_ErrorCount
          ,le.cortera_score_ALLOW_ErrorCount,le.cortera_score_LENGTH_ErrorCount
          ,le.cpr_score_ALLOW_ErrorCount,le.cpr_score_LENGTH_ErrorCount
          ,le.cpr_segment_ALLOW_ErrorCount,le.cpr_segment_LENGTH_ErrorCount
          ,le.dbt_ALLOW_ErrorCount,le.dbt_LENGTH_ErrorCount
          ,le.avg_bal_ALLOW_ErrorCount,le.avg_bal_LENGTH_ErrorCount
          ,le.air_spend_ALLOW_ErrorCount,le.air_spend_LENGTH_ErrorCount
          ,le.fuel_spend_ALLOW_ErrorCount,le.fuel_spend_LENGTH_ErrorCount
          ,le.leasing_spend_ALLOW_ErrorCount,le.leasing_spend_LENGTH_ErrorCount
          ,le.ltl_spend_ALLOW_ErrorCount,le.ltl_spend_LENGTH_ErrorCount
          ,le.rail_spend_ALLOW_ErrorCount,le.rail_spend_LENGTH_ErrorCount
          ,le.tl_spend_ALLOW_ErrorCount,le.tl_spend_LENGTH_ErrorCount
          ,le.transvc_spend_ALLOW_ErrorCount,le.transvc_spend_LENGTH_ErrorCount
          ,le.transup_spend_ALLOW_ErrorCount,le.transup_spend_LENGTH_ErrorCount
          ,le.bst_spend_ALLOW_ErrorCount,le.bst_spend_LENGTH_ErrorCount
          ,le.dg_spend_ALLOW_ErrorCount,le.dg_spend_LENGTH_ErrorCount
          ,le.electrical_spend_ALLOW_ErrorCount,le.electrical_spend_LENGTH_ErrorCount
          ,le.hvac_spend_ALLOW_ErrorCount,le.hvac_spend_LENGTH_ErrorCount
          ,le.other_b_spend_ALLOW_ErrorCount,le.other_b_spend_LENGTH_ErrorCount
          ,le.plumbing_spend_ALLOW_ErrorCount,le.plumbing_spend_LENGTH_ErrorCount
          ,le.rs_spend_ALLOW_ErrorCount,le.rs_spend_LENGTH_ErrorCount
          ,le.wp_spend_ALLOW_ErrorCount,le.wp_spend_LENGTH_ErrorCount
          ,le.chemical_spend_ALLOW_ErrorCount,le.chemical_spend_LENGTH_ErrorCount
          ,le.electronic_spend_ALLOW_ErrorCount,le.electronic_spend_LENGTH_ErrorCount
          ,le.metal_spend_ALLOW_ErrorCount,le.metal_spend_LENGTH_ErrorCount
          ,le.other_m_spend_ALLOW_ErrorCount,le.other_m_spend_LENGTH_ErrorCount
          ,le.packaging_spend_ALLOW_ErrorCount,le.packaging_spend_LENGTH_ErrorCount
          ,le.pvf_spend_ALLOW_ErrorCount,le.pvf_spend_LENGTH_ErrorCount
          ,le.plastic_spend_ALLOW_ErrorCount,le.plastic_spend_LENGTH_ErrorCount
          ,le.textile_spend_ALLOW_ErrorCount,le.textile_spend_LENGTH_ErrorCount
          ,le.bs_spend_ALLOW_ErrorCount,le.bs_spend_LENGTH_ErrorCount
          ,le.ce_spend_ALLOW_ErrorCount,le.ce_spend_LENGTH_ErrorCount
          ,le.hardware_spend_ALLOW_ErrorCount,le.hardware_spend_LENGTH_ErrorCount
          ,le.ie_spend_ALLOW_ErrorCount,le.ie_spend_LENGTH_ErrorCount
          ,le.is_spend_ALLOW_ErrorCount,le.is_spend_LENGTH_ErrorCount
          ,le.it_spend_ALLOW_ErrorCount,le.it_spend_LENGTH_ErrorCount
          ,le.mls_spend_ALLOW_ErrorCount,le.mls_spend_LENGTH_ErrorCount
          ,le.os_spend_ALLOW_ErrorCount,le.os_spend_LENGTH_ErrorCount
          ,le.pp_spend_ALLOW_ErrorCount,le.pp_spend_LENGTH_ErrorCount
          ,le.sis_spend_ALLOW_ErrorCount,le.sis_spend_LENGTH_ErrorCount
          ,le.apparel_spend_ALLOW_ErrorCount,le.apparel_spend_LENGTH_ErrorCount
          ,le.beverages_spend_ALLOW_ErrorCount,le.beverages_spend_LENGTH_ErrorCount
          ,le.constr_spend_ALLOW_ErrorCount,le.constr_spend_LENGTH_ErrorCount
          ,le.consulting_spend_ALLOW_ErrorCount,le.consulting_spend_LENGTH_ErrorCount
          ,le.fs_spend_ALLOW_ErrorCount,le.fs_spend_LENGTH_ErrorCount
          ,le.fp_spend_ALLOW_ErrorCount,le.fp_spend_LENGTH_ErrorCount
          ,le.insurance_spend_ALLOW_ErrorCount,le.insurance_spend_LENGTH_ErrorCount
          ,le.ls_spend_ALLOW_ErrorCount,le.ls_spend_LENGTH_ErrorCount
          ,le.oil_gas_spend_ALLOW_ErrorCount,le.oil_gas_spend_LENGTH_ErrorCount
          ,le.utilities_spend_ALLOW_ErrorCount,le.utilities_spend_LENGTH_ErrorCount
          ,le.other_spend_ALLOW_ErrorCount,le.other_spend_LENGTH_ErrorCount
          ,le.advt_spend_ALLOW_ErrorCount,le.advt_spend_LENGTH_ErrorCount
          ,le.air_growth_ALLOW_ErrorCount,le.air_growth_LENGTH_ErrorCount
          ,le.fuel_growth_ALLOW_ErrorCount,le.fuel_growth_LENGTH_ErrorCount
          ,le.leasing_growth_ALLOW_ErrorCount,le.leasing_growth_LENGTH_ErrorCount
          ,le.ltl_growth_ALLOW_ErrorCount,le.ltl_growth_LENGTH_ErrorCount
          ,le.rail_growth_ALLOW_ErrorCount,le.rail_growth_LENGTH_ErrorCount
          ,le.tl_growth_ALLOW_ErrorCount,le.tl_growth_LENGTH_ErrorCount
          ,le.transvc_growth_ALLOW_ErrorCount,le.transvc_growth_LENGTH_ErrorCount
          ,le.transup_growth_ALLOW_ErrorCount,le.transup_growth_LENGTH_ErrorCount
          ,le.bst_growth_ALLOW_ErrorCount,le.bst_growth_LENGTH_ErrorCount
          ,le.dg_growth_ALLOW_ErrorCount,le.dg_growth_LENGTH_ErrorCount
          ,le.electrical_growth_ALLOW_ErrorCount,le.electrical_growth_LENGTH_ErrorCount
          ,le.hvac_growth_ALLOW_ErrorCount,le.hvac_growth_LENGTH_ErrorCount
          ,le.other_b_growth_ALLOW_ErrorCount,le.other_b_growth_LENGTH_ErrorCount
          ,le.plumbing_growth_ALLOW_ErrorCount,le.plumbing_growth_LENGTH_ErrorCount
          ,le.rs_growth_ALLOW_ErrorCount,le.rs_growth_LENGTH_ErrorCount
          ,le.wp_growth_ALLOW_ErrorCount,le.wp_growth_LENGTH_ErrorCount
          ,le.chemical_growth_ALLOW_ErrorCount,le.chemical_growth_LENGTH_ErrorCount
          ,le.electronic_growth_ALLOW_ErrorCount,le.electronic_growth_LENGTH_ErrorCount
          ,le.metal_growth_ALLOW_ErrorCount,le.metal_growth_LENGTH_ErrorCount
          ,le.other_m_growth_ALLOW_ErrorCount,le.other_m_growth_LENGTH_ErrorCount
          ,le.packaging_growth_ALLOW_ErrorCount,le.packaging_growth_LENGTH_ErrorCount
          ,le.pvf_growth_ALLOW_ErrorCount,le.pvf_growth_LENGTH_ErrorCount
          ,le.plastic_growth_ALLOW_ErrorCount,le.plastic_growth_LENGTH_ErrorCount
          ,le.textile_growth_ALLOW_ErrorCount,le.textile_growth_LENGTH_ErrorCount
          ,le.bs_growth_ALLOW_ErrorCount,le.bs_growth_LENGTH_ErrorCount
          ,le.ce_growth_ALLOW_ErrorCount,le.ce_growth_LENGTH_ErrorCount
          ,le.hardware_growth_ALLOW_ErrorCount,le.hardware_growth_LENGTH_ErrorCount
          ,le.ie_growth_ALLOW_ErrorCount,le.ie_growth_LENGTH_ErrorCount
          ,le.is_growth_ALLOW_ErrorCount,le.is_growth_LENGTH_ErrorCount
          ,le.it_growth_ALLOW_ErrorCount,le.it_growth_LENGTH_ErrorCount
          ,le.mls_growth_ALLOW_ErrorCount,le.mls_growth_LENGTH_ErrorCount
          ,le.os_growth_ALLOW_ErrorCount,le.os_growth_LENGTH_ErrorCount
          ,le.pp_growth_ALLOW_ErrorCount,le.pp_growth_LENGTH_ErrorCount
          ,le.sis_growth_ALLOW_ErrorCount,le.sis_growth_LENGTH_ErrorCount
          ,le.apparel_growth_ALLOW_ErrorCount,le.apparel_growth_LENGTH_ErrorCount
          ,le.beverages_growth_ALLOW_ErrorCount,le.beverages_growth_LENGTH_ErrorCount
          ,le.constr_growth_ALLOW_ErrorCount,le.constr_growth_LENGTH_ErrorCount
          ,le.consulting_growth_ALLOW_ErrorCount,le.consulting_growth_LENGTH_ErrorCount
          ,le.fs_growth_ALLOW_ErrorCount,le.fs_growth_LENGTH_ErrorCount
          ,le.fp_growth_ALLOW_ErrorCount,le.fp_growth_LENGTH_ErrorCount
          ,le.insurance_growth_ALLOW_ErrorCount,le.insurance_growth_LENGTH_ErrorCount
          ,le.ls_growth_ALLOW_ErrorCount,le.ls_growth_LENGTH_ErrorCount
          ,le.oil_gas_growth_ALLOW_ErrorCount,le.oil_gas_growth_LENGTH_ErrorCount
          ,le.utilities_growth_ALLOW_ErrorCount,le.utilities_growth_LENGTH_ErrorCount
          ,le.other_growth_ALLOW_ErrorCount,le.other_growth_LENGTH_ErrorCount
          ,le.advt_growth_ALLOW_ErrorCount,le.advt_growth_LENGTH_ErrorCount
          ,le.top5_growth_ALLOW_ErrorCount,le.top5_growth_LENGTH_ErrorCount
          ,le.shipping_y1_ALLOW_ErrorCount,le.shipping_y1_LENGTH_ErrorCount
          ,le.shipping_growth_ALLOW_ErrorCount,le.shipping_growth_LENGTH_ErrorCount
          ,le.materials_y1_ALLOW_ErrorCount,le.materials_y1_LENGTH_ErrorCount
          ,le.materials_growth_ALLOW_ErrorCount,le.materials_growth_LENGTH_ErrorCount
          ,le.operations_y1_ALLOW_ErrorCount,le.operations_y1_LENGTH_ErrorCount
          ,le.operations_growth_ALLOW_ErrorCount,le.operations_growth_LENGTH_ErrorCount
          ,le.total_paid_average_0t12_ALLOW_ErrorCount,le.total_paid_average_0t12_LENGTH_ErrorCount
          ,le.total_paid_monthspastworst_24_ALLOW_ErrorCount,le.total_paid_monthspastworst_24_LENGTH_ErrorCount
          ,le.total_paid_slope_0t12_ALLOW_ErrorCount,le.total_paid_slope_0t12_LENGTH_ErrorCount
          ,le.total_paid_slope_0t6_ALLOW_ErrorCount,le.total_paid_slope_0t6_LENGTH_ErrorCount
          ,le.total_paid_slope_6t12_ALLOW_ErrorCount,le.total_paid_slope_6t12_LENGTH_ErrorCount
          ,le.total_paid_slope_6t18_ALLOW_ErrorCount,le.total_paid_slope_6t18_LENGTH_ErrorCount
          ,le.total_paid_volatility_0t12_ALLOW_ErrorCount,le.total_paid_volatility_0t12_LENGTH_ErrorCount
          ,le.total_paid_volatility_0t6_ALLOW_ErrorCount,le.total_paid_volatility_0t6_LENGTH_ErrorCount
          ,le.total_paid_volatility_12t18_ALLOW_ErrorCount,le.total_paid_volatility_12t18_LENGTH_ErrorCount
          ,le.total_paid_volatility_6t12_ALLOW_ErrorCount,le.total_paid_volatility_6t12_LENGTH_ErrorCount
          ,le.total_spend_monthspastleast_24_ALLOW_ErrorCount,le.total_spend_monthspastleast_24_LENGTH_ErrorCount
          ,le.total_spend_monthspastmost_24_ALLOW_ErrorCount,le.total_spend_monthspastmost_24_LENGTH_ErrorCount
          ,le.total_spend_slope_0t12_ALLOW_ErrorCount,le.total_spend_slope_0t12_LENGTH_ErrorCount
          ,le.total_spend_slope_0t24_ALLOW_ErrorCount,le.total_spend_slope_0t24_LENGTH_ErrorCount
          ,le.total_spend_slope_0t6_ALLOW_ErrorCount,le.total_spend_slope_0t6_LENGTH_ErrorCount
          ,le.total_spend_slope_6t12_ALLOW_ErrorCount,le.total_spend_slope_6t12_LENGTH_ErrorCount
          ,le.total_spend_sum_12_ALLOW_ErrorCount,le.total_spend_sum_12_LENGTH_ErrorCount
          ,le.total_spend_volatility_0t12_ALLOW_ErrorCount,le.total_spend_volatility_0t12_LENGTH_ErrorCount
          ,le.total_spend_volatility_0t6_ALLOW_ErrorCount,le.total_spend_volatility_0t6_LENGTH_ErrorCount
          ,le.total_spend_volatility_12t18_ALLOW_ErrorCount,le.total_spend_volatility_12t18_LENGTH_ErrorCount
          ,le.total_spend_volatility_6t12_ALLOW_ErrorCount,le.total_spend_volatility_6t12_LENGTH_ErrorCount
          ,le.mfgmat_paid_average_12_ALLOW_ErrorCount,le.mfgmat_paid_average_12_LENGTH_ErrorCount
          ,le.mfgmat_paid_monthspastworst_24_ALLOW_ErrorCount,le.mfgmat_paid_monthspastworst_24_LENGTH_ErrorCount
          ,le.mfgmat_paid_slope_0t12_ALLOW_ErrorCount,le.mfgmat_paid_slope_0t12_LENGTH_ErrorCount
          ,le.mfgmat_paid_slope_0t24_ALLOW_ErrorCount,le.mfgmat_paid_slope_0t24_LENGTH_ErrorCount
          ,le.mfgmat_paid_slope_0t6_ALLOW_ErrorCount,le.mfgmat_paid_slope_0t6_LENGTH_ErrorCount
          ,le.mfgmat_paid_volatility_0t12_ALLOW_ErrorCount,le.mfgmat_paid_volatility_0t12_LENGTH_ErrorCount
          ,le.mfgmat_paid_volatility_0t6_ALLOW_ErrorCount,le.mfgmat_paid_volatility_0t6_LENGTH_ErrorCount
          ,le.mfgmat_spend_monthspastleast_24_ALLOW_ErrorCount,le.mfgmat_spend_monthspastleast_24_LENGTH_ErrorCount
          ,le.mfgmat_spend_monthspastmost_24_ALLOW_ErrorCount,le.mfgmat_spend_monthspastmost_24_LENGTH_ErrorCount
          ,le.mfgmat_spend_slope_0t12_ALLOW_ErrorCount,le.mfgmat_spend_slope_0t12_LENGTH_ErrorCount
          ,le.mfgmat_spend_slope_0t24_ALLOW_ErrorCount,le.mfgmat_spend_slope_0t24_LENGTH_ErrorCount
          ,le.mfgmat_spend_slope_0t6_ALLOW_ErrorCount,le.mfgmat_spend_slope_0t6_LENGTH_ErrorCount
          ,le.mfgmat_spend_sum_12_ALLOW_ErrorCount,le.mfgmat_spend_sum_12_LENGTH_ErrorCount
          ,le.mfgmat_spend_volatility_0t6_ALLOW_ErrorCount,le.mfgmat_spend_volatility_0t6_LENGTH_ErrorCount
          ,le.mfgmat_spend_volatility_6t12_ALLOW_ErrorCount,le.mfgmat_spend_volatility_6t12_LENGTH_ErrorCount
          ,le.ops_paid_average_12_ALLOW_ErrorCount,le.ops_paid_average_12_LENGTH_ErrorCount
          ,le.ops_paid_monthspastworst_24_ALLOW_ErrorCount,le.ops_paid_monthspastworst_24_LENGTH_ErrorCount
          ,le.ops_paid_slope_0t12_ALLOW_ErrorCount,le.ops_paid_slope_0t12_LENGTH_ErrorCount
          ,le.ops_paid_slope_0t24_ALLOW_ErrorCount,le.ops_paid_slope_0t24_LENGTH_ErrorCount
          ,le.ops_paid_slope_0t6_ALLOW_ErrorCount,le.ops_paid_slope_0t6_LENGTH_ErrorCount
          ,le.ops_paid_volatility_0t12_ALLOW_ErrorCount,le.ops_paid_volatility_0t12_LENGTH_ErrorCount
          ,le.ops_paid_volatility_0t6_ALLOW_ErrorCount,le.ops_paid_volatility_0t6_LENGTH_ErrorCount
          ,le.ops_spend_monthspastleast_24_ALLOW_ErrorCount,le.ops_spend_monthspastleast_24_LENGTH_ErrorCount
          ,le.ops_spend_monthspastmost_24_ALLOW_ErrorCount,le.ops_spend_monthspastmost_24_LENGTH_ErrorCount
          ,le.ops_spend_slope_0t12_ALLOW_ErrorCount,le.ops_spend_slope_0t12_LENGTH_ErrorCount
          ,le.ops_spend_slope_0t24_ALLOW_ErrorCount,le.ops_spend_slope_0t24_LENGTH_ErrorCount
          ,le.ops_spend_slope_0t6_ALLOW_ErrorCount,le.ops_spend_slope_0t6_LENGTH_ErrorCount
          ,le.fleet_paid_monthspastworst_24_ALLOW_ErrorCount,le.fleet_paid_monthspastworst_24_LENGTH_ErrorCount
          ,le.fleet_paid_slope_0t12_ALLOW_ErrorCount,le.fleet_paid_slope_0t12_LENGTH_ErrorCount
          ,le.fleet_paid_slope_0t24_ALLOW_ErrorCount,le.fleet_paid_slope_0t24_LENGTH_ErrorCount
          ,le.fleet_paid_slope_0t6_ALLOW_ErrorCount,le.fleet_paid_slope_0t6_LENGTH_ErrorCount
          ,le.fleet_paid_volatility_0t12_ALLOW_ErrorCount,le.fleet_paid_volatility_0t12_LENGTH_ErrorCount
          ,le.fleet_paid_volatility_0t6_ALLOW_ErrorCount,le.fleet_paid_volatility_0t6_LENGTH_ErrorCount
          ,le.fleet_spend_slope_0t12_ALLOW_ErrorCount,le.fleet_spend_slope_0t12_LENGTH_ErrorCount
          ,le.fleet_spend_slope_0t24_ALLOW_ErrorCount,le.fleet_spend_slope_0t24_LENGTH_ErrorCount
          ,le.fleet_spend_slope_0t6_ALLOW_ErrorCount,le.fleet_spend_slope_0t6_LENGTH_ErrorCount
          ,le.carrier_paid_slope_0t12_ALLOW_ErrorCount,le.carrier_paid_slope_0t12_LENGTH_ErrorCount
          ,le.carrier_paid_slope_0t24_ALLOW_ErrorCount,le.carrier_paid_slope_0t24_LENGTH_ErrorCount
          ,le.carrier_paid_slope_0t6_ALLOW_ErrorCount,le.carrier_paid_slope_0t6_LENGTH_ErrorCount
          ,le.carrier_paid_volatility_0t12_ALLOW_ErrorCount,le.carrier_paid_volatility_0t12_LENGTH_ErrorCount
          ,le.carrier_paid_volatility_0t6_ALLOW_ErrorCount,le.carrier_paid_volatility_0t6_LENGTH_ErrorCount
          ,le.carrier_spend_slope_0t12_ALLOW_ErrorCount,le.carrier_spend_slope_0t12_LENGTH_ErrorCount
          ,le.carrier_spend_slope_0t24_ALLOW_ErrorCount,le.carrier_spend_slope_0t24_LENGTH_ErrorCount
          ,le.carrier_spend_slope_0t6_ALLOW_ErrorCount,le.carrier_spend_slope_0t6_LENGTH_ErrorCount
          ,le.carrier_spend_volatility_0t6_ALLOW_ErrorCount,le.carrier_spend_volatility_0t6_LENGTH_ErrorCount
          ,le.carrier_spend_volatility_6t12_ALLOW_ErrorCount,le.carrier_spend_volatility_6t12_LENGTH_ErrorCount
          ,le.bldgmats_paid_slope_0t12_ALLOW_ErrorCount,le.bldgmats_paid_slope_0t12_LENGTH_ErrorCount
          ,le.bldgmats_paid_slope_0t24_ALLOW_ErrorCount,le.bldgmats_paid_slope_0t24_LENGTH_ErrorCount
          ,le.bldgmats_paid_slope_0t6_ALLOW_ErrorCount,le.bldgmats_paid_slope_0t6_LENGTH_ErrorCount
          ,le.bldgmats_paid_volatility_0t12_ALLOW_ErrorCount,le.bldgmats_paid_volatility_0t12_LENGTH_ErrorCount
          ,le.bldgmats_paid_volatility_0t6_ALLOW_ErrorCount,le.bldgmats_paid_volatility_0t6_LENGTH_ErrorCount
          ,le.bldgmats_spend_slope_0t12_ALLOW_ErrorCount,le.bldgmats_spend_slope_0t12_LENGTH_ErrorCount
          ,le.bldgmats_spend_slope_0t24_ALLOW_ErrorCount,le.bldgmats_spend_slope_0t24_LENGTH_ErrorCount
          ,le.bldgmats_spend_slope_0t6_ALLOW_ErrorCount,le.bldgmats_spend_slope_0t6_LENGTH_ErrorCount
          ,le.bldgmats_spend_volatility_0t6_ALLOW_ErrorCount,le.bldgmats_spend_volatility_0t6_LENGTH_ErrorCount
          ,le.bldgmats_spend_volatility_6t12_ALLOW_ErrorCount,le.bldgmats_spend_volatility_6t12_LENGTH_ErrorCount
          ,le.top5_paid_slope_0t12_ALLOW_ErrorCount,le.top5_paid_slope_0t12_LENGTH_ErrorCount
          ,le.top5_paid_slope_0t24_ALLOW_ErrorCount,le.top5_paid_slope_0t24_LENGTH_ErrorCount
          ,le.top5_paid_slope_0t6_ALLOW_ErrorCount,le.top5_paid_slope_0t6_LENGTH_ErrorCount
          ,le.top5_paid_volatility_0t12_ALLOW_ErrorCount,le.top5_paid_volatility_0t12_LENGTH_ErrorCount
          ,le.top5_paid_volatility_0t6_ALLOW_ErrorCount,le.top5_paid_volatility_0t6_LENGTH_ErrorCount
          ,le.top5_spend_slope_0t12_ALLOW_ErrorCount,le.top5_spend_slope_0t12_LENGTH_ErrorCount
          ,le.top5_spend_slope_0t24_ALLOW_ErrorCount,le.top5_spend_slope_0t24_LENGTH_ErrorCount
          ,le.top5_spend_slope_0t6_ALLOW_ErrorCount,le.top5_spend_slope_0t6_LENGTH_ErrorCount
          ,le.top5_spend_volatility_0t6_ALLOW_ErrorCount,le.top5_spend_volatility_0t6_LENGTH_ErrorCount
          ,le.top5_spend_volatility_6t12_ALLOW_ErrorCount,le.top5_spend_volatility_6t12_LENGTH_ErrorCount
          ,le.total_numrel_slope_0t12_ALLOW_ErrorCount,le.total_numrel_slope_0t12_LENGTH_ErrorCount
          ,le.total_numrel_slope_0t24_ALLOW_ErrorCount,le.total_numrel_slope_0t24_LENGTH_ErrorCount
          ,le.total_numrel_slope_0t6_ALLOW_ErrorCount,le.total_numrel_slope_0t6_LENGTH_ErrorCount
          ,le.total_numrel_slope_6t12_ALLOW_ErrorCount,le.total_numrel_slope_6t12_LENGTH_ErrorCount
          ,le.mfgmat_numrel_slope_0t12_ALLOW_ErrorCount,le.mfgmat_numrel_slope_0t12_LENGTH_ErrorCount
          ,le.mfgmat_numrel_slope_0t24_ALLOW_ErrorCount,le.mfgmat_numrel_slope_0t24_LENGTH_ErrorCount
          ,le.mfgmat_numrel_slope_0t6_ALLOW_ErrorCount,le.mfgmat_numrel_slope_0t6_LENGTH_ErrorCount
          ,le.mfgmat_numrel_slope_6t12_ALLOW_ErrorCount,le.mfgmat_numrel_slope_6t12_LENGTH_ErrorCount
          ,le.ops_numrel_slope_0t12_ALLOW_ErrorCount,le.ops_numrel_slope_0t12_LENGTH_ErrorCount
          ,le.ops_numrel_slope_0t24_ALLOW_ErrorCount,le.ops_numrel_slope_0t24_LENGTH_ErrorCount
          ,le.ops_numrel_slope_0t6_ALLOW_ErrorCount,le.ops_numrel_slope_0t6_LENGTH_ErrorCount
          ,le.ops_numrel_slope_6t12_ALLOW_ErrorCount,le.ops_numrel_slope_6t12_LENGTH_ErrorCount
          ,le.fleet_numrel_slope_0t12_ALLOW_ErrorCount,le.fleet_numrel_slope_0t12_LENGTH_ErrorCount
          ,le.fleet_numrel_slope_0t24_ALLOW_ErrorCount,le.fleet_numrel_slope_0t24_LENGTH_ErrorCount
          ,le.fleet_numrel_slope_0t6_ALLOW_ErrorCount,le.fleet_numrel_slope_0t6_LENGTH_ErrorCount
          ,le.fleet_numrel_slope_6t12_ALLOW_ErrorCount,le.fleet_numrel_slope_6t12_LENGTH_ErrorCount
          ,le.carrier_numrel_slope_0t12_ALLOW_ErrorCount,le.carrier_numrel_slope_0t12_LENGTH_ErrorCount
          ,le.carrier_numrel_slope_0t24_ALLOW_ErrorCount,le.carrier_numrel_slope_0t24_LENGTH_ErrorCount
          ,le.carrier_numrel_slope_0t6_ALLOW_ErrorCount,le.carrier_numrel_slope_0t6_LENGTH_ErrorCount
          ,le.carrier_numrel_slope_6t12_ALLOW_ErrorCount,le.carrier_numrel_slope_6t12_LENGTH_ErrorCount
          ,le.bldgmats_numrel_slope_0t12_ALLOW_ErrorCount,le.bldgmats_numrel_slope_0t12_LENGTH_ErrorCount
          ,le.bldgmats_numrel_slope_0t24_ALLOW_ErrorCount,le.bldgmats_numrel_slope_0t24_LENGTH_ErrorCount
          ,le.bldgmats_numrel_slope_0t6_ALLOW_ErrorCount,le.bldgmats_numrel_slope_0t6_LENGTH_ErrorCount
          ,le.bldgmats_numrel_slope_6t12_ALLOW_ErrorCount,le.bldgmats_numrel_slope_6t12_LENGTH_ErrorCount
          ,le.bldgmats_numrel_var_0t12_ALLOW_ErrorCount,le.bldgmats_numrel_var_0t12_LENGTH_ErrorCount
          ,le.bldgmats_numrel_var_12t24_ALLOW_ErrorCount,le.bldgmats_numrel_var_12t24_LENGTH_ErrorCount
          ,le.total_percprov30_slope_0t12_ALLOW_ErrorCount,le.total_percprov30_slope_0t12_LENGTH_ErrorCount
          ,le.total_percprov30_slope_0t24_ALLOW_ErrorCount,le.total_percprov30_slope_0t24_LENGTH_ErrorCount
          ,le.total_percprov30_slope_0t6_ALLOW_ErrorCount,le.total_percprov30_slope_0t6_LENGTH_ErrorCount
          ,le.total_percprov30_slope_6t12_ALLOW_ErrorCount,le.total_percprov30_slope_6t12_LENGTH_ErrorCount
          ,le.total_percprov60_slope_0t12_ALLOW_ErrorCount,le.total_percprov60_slope_0t12_LENGTH_ErrorCount
          ,le.total_percprov60_slope_0t24_ALLOW_ErrorCount,le.total_percprov60_slope_0t24_LENGTH_ErrorCount
          ,le.total_percprov60_slope_0t6_ALLOW_ErrorCount,le.total_percprov60_slope_0t6_LENGTH_ErrorCount
          ,le.total_percprov60_slope_6t12_ALLOW_ErrorCount,le.total_percprov60_slope_6t12_LENGTH_ErrorCount
          ,le.total_percprov90_slope_0t24_ALLOW_ErrorCount,le.total_percprov90_slope_0t24_LENGTH_ErrorCount
          ,le.total_percprov90_slope_0t6_ALLOW_ErrorCount,le.total_percprov90_slope_0t6_LENGTH_ErrorCount
          ,le.total_percprov90_slope_6t12_ALLOW_ErrorCount,le.total_percprov90_slope_6t12_LENGTH_ErrorCount
          ,le.mfgmat_percprov30_slope_0t12_ALLOW_ErrorCount,le.mfgmat_percprov30_slope_0t12_LENGTH_ErrorCount
          ,le.mfgmat_percprov30_slope_6t12_ALLOW_ErrorCount,le.mfgmat_percprov30_slope_6t12_LENGTH_ErrorCount
          ,le.mfgmat_percprov60_slope_0t12_ALLOW_ErrorCount,le.mfgmat_percprov60_slope_0t12_LENGTH_ErrorCount
          ,le.mfgmat_percprov60_slope_6t12_ALLOW_ErrorCount,le.mfgmat_percprov60_slope_6t12_LENGTH_ErrorCount
          ,le.mfgmat_percprov90_slope_0t24_ALLOW_ErrorCount,le.mfgmat_percprov90_slope_0t24_LENGTH_ErrorCount
          ,le.mfgmat_percprov90_slope_0t6_ALLOW_ErrorCount,le.mfgmat_percprov90_slope_0t6_LENGTH_ErrorCount
          ,le.mfgmat_percprov90_slope_6t12_ALLOW_ErrorCount,le.mfgmat_percprov90_slope_6t12_LENGTH_ErrorCount
          ,le.ops_percprov30_slope_0t12_ALLOW_ErrorCount,le.ops_percprov30_slope_0t12_LENGTH_ErrorCount
          ,le.ops_percprov30_slope_6t12_ALLOW_ErrorCount,le.ops_percprov30_slope_6t12_LENGTH_ErrorCount
          ,le.ops_percprov60_slope_0t12_ALLOW_ErrorCount,le.ops_percprov60_slope_0t12_LENGTH_ErrorCount
          ,le.ops_percprov60_slope_6t12_ALLOW_ErrorCount,le.ops_percprov60_slope_6t12_LENGTH_ErrorCount
          ,le.ops_percprov90_slope_0t24_ALLOW_ErrorCount,le.ops_percprov90_slope_0t24_LENGTH_ErrorCount
          ,le.ops_percprov90_slope_0t6_ALLOW_ErrorCount,le.ops_percprov90_slope_0t6_LENGTH_ErrorCount
          ,le.ops_percprov90_slope_6t12_ALLOW_ErrorCount,le.ops_percprov90_slope_6t12_LENGTH_ErrorCount
          ,le.fleet_percprov30_slope_0t12_ALLOW_ErrorCount,le.fleet_percprov30_slope_0t12_LENGTH_ErrorCount
          ,le.fleet_percprov30_slope_6t12_ALLOW_ErrorCount,le.fleet_percprov30_slope_6t12_LENGTH_ErrorCount
          ,le.fleet_percprov60_slope_0t12_ALLOW_ErrorCount,le.fleet_percprov60_slope_0t12_LENGTH_ErrorCount
          ,le.fleet_percprov60_slope_6t12_ALLOW_ErrorCount,le.fleet_percprov60_slope_6t12_LENGTH_ErrorCount
          ,le.fleet_percprov90_slope_0t24_ALLOW_ErrorCount,le.fleet_percprov90_slope_0t24_LENGTH_ErrorCount
          ,le.fleet_percprov90_slope_0t6_ALLOW_ErrorCount,le.fleet_percprov90_slope_0t6_LENGTH_ErrorCount
          ,le.fleet_percprov90_slope_6t12_ALLOW_ErrorCount,le.fleet_percprov90_slope_6t12_LENGTH_ErrorCount
          ,le.carrier_percprov30_slope_0t12_ALLOW_ErrorCount,le.carrier_percprov30_slope_0t12_LENGTH_ErrorCount
          ,le.carrier_percprov30_slope_6t12_ALLOW_ErrorCount,le.carrier_percprov30_slope_6t12_LENGTH_ErrorCount
          ,le.carrier_percprov60_slope_0t12_ALLOW_ErrorCount,le.carrier_percprov60_slope_0t12_LENGTH_ErrorCount
          ,le.carrier_percprov60_slope_6t12_ALLOW_ErrorCount,le.carrier_percprov60_slope_6t12_LENGTH_ErrorCount
          ,le.carrier_percprov90_slope_0t24_ALLOW_ErrorCount,le.carrier_percprov90_slope_0t24_LENGTH_ErrorCount
          ,le.carrier_percprov90_slope_0t6_ALLOW_ErrorCount,le.carrier_percprov90_slope_0t6_LENGTH_ErrorCount
          ,le.carrier_percprov90_slope_6t12_ALLOW_ErrorCount,le.carrier_percprov90_slope_6t12_LENGTH_ErrorCount
          ,le.bldgmats_percprov30_slope_0t12_ALLOW_ErrorCount,le.bldgmats_percprov30_slope_0t12_LENGTH_ErrorCount
          ,le.bldgmats_percprov30_slope_6t12_ALLOW_ErrorCount,le.bldgmats_percprov30_slope_6t12_LENGTH_ErrorCount
          ,le.bldgmats_percprov60_slope_0t12_ALLOW_ErrorCount,le.bldgmats_percprov60_slope_0t12_LENGTH_ErrorCount
          ,le.bldgmats_percprov60_slope_6t12_ALLOW_ErrorCount,le.bldgmats_percprov60_slope_6t12_LENGTH_ErrorCount
          ,le.bldgmats_percprov90_slope_0t24_ALLOW_ErrorCount,le.bldgmats_percprov90_slope_0t24_LENGTH_ErrorCount
          ,le.bldgmats_percprov90_slope_0t6_ALLOW_ErrorCount,le.bldgmats_percprov90_slope_0t6_LENGTH_ErrorCount
          ,le.bldgmats_percprov90_slope_6t12_ALLOW_ErrorCount,le.bldgmats_percprov90_slope_6t12_LENGTH_ErrorCount
          ,le.top5_percprov30_slope_0t12_ALLOW_ErrorCount,le.top5_percprov30_slope_0t12_LENGTH_ErrorCount
          ,le.top5_percprov30_slope_6t12_ALLOW_ErrorCount,le.top5_percprov30_slope_6t12_LENGTH_ErrorCount
          ,le.top5_percprov60_slope_0t12_ALLOW_ErrorCount,le.top5_percprov60_slope_0t12_LENGTH_ErrorCount
          ,le.top5_percprov60_slope_6t12_ALLOW_ErrorCount,le.top5_percprov60_slope_6t12_LENGTH_ErrorCount
          ,le.top5_percprov90_slope_0t24_ALLOW_ErrorCount,le.top5_percprov90_slope_0t24_LENGTH_ErrorCount
          ,le.top5_percprov90_slope_0t6_ALLOW_ErrorCount,le.top5_percprov90_slope_0t6_LENGTH_ErrorCount
          ,le.top5_percprov90_slope_6t12_ALLOW_ErrorCount,le.top5_percprov90_slope_6t12_LENGTH_ErrorCount
          ,le.top5_percprovoutstanding_adjustedslope_0t12_ALLOW_ErrorCount,le.top5_percprovoutstanding_adjustedslope_0t12_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,544,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT36.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT36.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
