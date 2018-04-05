﻿// Machine-readable versions of the spec file and subsets thereof
EXPORT GenerationMod := MODULE
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_Cortera_Attributes\n'
    + 'FILENAME:In_Attributes\n'
    + '// Uncomment up to NINES for internal or external adl\n'
    + '// IDFIELD:EXISTS:<NameOfIDField>\n'
    + '// RIDFIELD:<NameOfRidField>\n'
    + '// RECORDS:<NumberOfRecordsInDataFile>\n'
    + '// POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '// NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '// Uncomment Process if doing external adl\n'
    + '// PROCESS:<ProcessName>\n'
    + '// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields\n'
    + '// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '// FUZZY can be used to create new types of FUZZY linking\n'
    + '// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.\n'
    + '// If the actual specificity for a field is <1, round it up to 1 rather than down to 0.  If your cluster is running\n'
    + '// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.\n'
    + 'FIELDTYPE:Number:ALLOW(0123456789):LENGTHS(0,1..)\n'
    + 'FIELDTYPE:Ratio:ALLOW(0123456789.-E):LENGTHS(0,1..)\n'
    + '\n'
    + 'FIELD:ultimate_linkid:LIKE(Number):0,0\n'
    + 'FIELD:cortera_score:LIKE(Number):0,0\n'
    + 'FIELD:cpr_score:LIKE(Number):0,0\n'
    + 'FIELD:cpr_segment:LIKE(Number):0,0\n'
    + 'FIELD:dbt:LIKE(Ratio):0,0\n'
    + 'FIELD:avg_bal:LIKE(Number):0,0\n'
    + 'FIELD:air_spend:LIKE(Number):0,0\n'
    + 'FIELD:fuel_spend:LIKE(Number):0,0\n'
    + 'FIELD:leasing_spend:LIKE(Number):0,0\n'
    + 'FIELD:ltl_spend:LIKE(Number):0,0\n'
    + 'FIELD:rail_spend:LIKE(Number):0,0\n'
    + 'FIELD:tl_spend:LIKE(Number):0,0\n'
    + 'FIELD:transvc_spend:LIKE(Number):0,0\n'
    + 'FIELD:transup_spend:LIKE(Number):0,0\n'
    + 'FIELD:bst_spend:LIKE(Number):0,0\n'
    + 'FIELD:dg_spend:LIKE(Number):0,0\n'
    + 'FIELD:electrical_spend:LIKE(Number):0,0\n'
    + 'FIELD:hvac_spend:LIKE(Number):0,0\n'
    + 'FIELD:other_b_spend:LIKE(Number):0,0\n'
    + 'FIELD:plumbing_spend:LIKE(Number):0,0\n'
    + 'FIELD:rs_spend:LIKE(Number):0,0\n'
    + 'FIELD:wp_spend:LIKE(Number):0,0\n'
    + 'FIELD:chemical_spend:LIKE(Number):0,0\n'
    + 'FIELD:electronic_spend:LIKE(Number):0,0\n'
    + 'FIELD:metal_spend:LIKE(Number):0,0\n'
    + 'FIELD:other_m_spend:LIKE(Number):0,0\n'
    + 'FIELD:packaging_spend:LIKE(Number):0,0\n'
    + 'FIELD:pvf_spend:LIKE(Number):0,0\n'
    + 'FIELD:plastic_spend:LIKE(Number):0,0\n'
    + 'FIELD:textile_spend:LIKE(Number):0,0\n'
    + 'FIELD:bs_spend:LIKE(Number):0,0\n'
    + 'FIELD:ce_spend:LIKE(Number):0,0\n'
    + 'FIELD:hardware_spend:LIKE(Number):0,0\n'
    + 'FIELD:ie_spend:LIKE(Number):0,0\n'
    + 'FIELD:is_spend:LIKE(Number):0,0\n'
    + 'FIELD:it_spend:LIKE(Number):0,0\n'
    + 'FIELD:mls_spend:LIKE(Number):0,0\n'
    + 'FIELD:os_spend:LIKE(Number):0,0\n'
    + 'FIELD:pp_spend:LIKE(Number):0,0\n'
    + 'FIELD:sis_spend:LIKE(Number):0,0\n'
    + 'FIELD:apparel_spend:LIKE(Number):0,0\n'
    + 'FIELD:beverages_spend:LIKE(Number):0,0\n'
    + 'FIELD:constr_spend:LIKE(Number):0,0\n'
    + 'FIELD:consulting_spend:LIKE(Number):0,0\n'
    + 'FIELD:fs_spend:LIKE(Number):0,0\n'
    + 'FIELD:fp_spend:LIKE(Number):0,0\n'
    + 'FIELD:insurance_spend:LIKE(Number):0,0\n'
    + 'FIELD:ls_spend:LIKE(Number):0,0\n'
    + 'FIELD:oil_gas_spend:LIKE(Number):0,0\n'
    + 'FIELD:utilities_spend:LIKE(Number):0,0\n'
    + 'FIELD:other_spend:LIKE(Number):0,0\n'
    + 'FIELD:advt_spend:LIKE(Number):0,0\n'
    + 'FIELD:air_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:fuel_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:leasing_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:ltl_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:rail_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:tl_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:transvc_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:transup_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:bst_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:dg_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:electrical_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:hvac_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:other_b_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:plumbing_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:rs_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:wp_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:chemical_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:electronic_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:metal_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:other_m_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:packaging_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:pvf_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:plastic_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:textile_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:bs_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:ce_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:hardware_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:ie_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:is_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:it_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:mls_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:os_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:pp_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:sis_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:apparel_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:beverages_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:constr_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:consulting_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:fs_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:fp_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:insurance_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:ls_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:oil_gas_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:utilities_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:other_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:advt_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:top5_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:shipping_y1:LIKE(Number):0,0\n'
    + 'FIELD:shipping_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:materials_y1:LIKE(Number):0,0\n'
    + 'FIELD:materials_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:operations_y1:LIKE(Number):0,0\n'
    + 'FIELD:operations_growth:LIKE(Ratio):0,0\n'
    + 'FIELD:total_paid_average_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:total_paid_monthspastworst_24:LIKE(Ratio):0,0\n'
    + 'FIELD:total_paid_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:total_paid_slope_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:total_paid_slope_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:total_paid_slope_6t18:LIKE(Ratio):0,0\n'
    + 'FIELD:total_paid_volatility_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:total_paid_volatility_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:total_paid_volatility_12t18:LIKE(Ratio):0,0\n'
    + 'FIELD:total_paid_volatility_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:total_spend_monthspastleast_24:LIKE(Number):0,0\n'
    + 'FIELD:total_spend_monthspastmost_24:LIKE(Number):0,0\n'
    + 'FIELD:total_spend_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:total_spend_slope_0t24:LIKE(Ratio):0,0\n'
    + 'FIELD:total_spend_slope_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:total_spend_slope_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:total_spend_sum_12:LIKE(Ratio):0,0\n'
    + 'FIELD:total_spend_volatility_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:total_spend_volatility_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:total_spend_volatility_12t18:LIKE(Ratio):0,0\n'
    + 'FIELD:total_spend_volatility_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:mfgmat_paid_average_12:LIKE(Ratio):0,0\n'
    + 'FIELD:mfgmat_paid_monthspastworst_24:LIKE(Number):0,0\n'
    + 'FIELD:mfgmat_paid_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:mfgmat_paid_slope_0t24:LIKE(Ratio):0,0\n'
    + 'FIELD:mfgmat_paid_slope_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:mfgmat_paid_volatility_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:mfgmat_paid_volatility_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:mfgmat_spend_monthspastleast_24:LIKE(Number):0,0\n'
    + 'FIELD:mfgmat_spend_monthspastmost_24:LIKE(Number):0,0\n'
    + 'FIELD:mfgmat_spend_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:mfgmat_spend_slope_0t24:LIKE(Ratio):0,0\n'
    + 'FIELD:mfgmat_spend_slope_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:mfgmat_spend_sum_12:LIKE(Ratio):0,0\n'
    + 'FIELD:mfgmat_spend_volatility_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:mfgmat_spend_volatility_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:ops_paid_average_12:LIKE(Ratio):0,0\n'
    + 'FIELD:ops_paid_monthspastworst_24:LIKE(Ratio):0,0\n'
    + 'FIELD:ops_paid_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:ops_paid_slope_0t24:LIKE(Ratio):0,0\n'
    + 'FIELD:ops_paid_slope_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:ops_paid_volatility_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:ops_paid_volatility_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:ops_spend_monthspastleast_24:LIKE(Number):0,0\n'
    + 'FIELD:ops_spend_monthspastmost_24:LIKE(Number):0,0\n'
    + 'FIELD:ops_spend_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:ops_spend_slope_0t24:LIKE(Ratio):0,0\n'
    + 'FIELD:ops_spend_slope_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:ops_spend_sum_12:TYPE(STRING):0,0\n'
    + 'FIELD:ops_spend_volatility_0t6:TYPE(STRING):0,0\n'
    + 'FIELD:ops_spend_volatility_6t12:TYPE(STRING):0,0\n'
    + 'FIELD:fleet_paid_average_12:TYPE(STRING):0,0\n'
    + 'FIELD:fleet_paid_monthspastworst_24:LIKE(Number):0,0\n'
    + 'FIELD:fleet_paid_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:fleet_paid_slope_0t24:LIKE(Ratio):0,0\n'
    + 'FIELD:fleet_paid_slope_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:fleet_paid_volatility_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:fleet_paid_volatility_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:fleet_spend_monthspastleast_24:TYPE(STRING):0,0\n'
    + 'FIELD:fleet_spend_monthspastmost_24:TYPE(STRING):0,0\n'
    + 'FIELD:fleet_spend_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:fleet_spend_slope_0t24:LIKE(Ratio):0,0\n'
    + 'FIELD:fleet_spend_slope_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:fleet_spend_sum_12:TYPE(STRING):0,0\n'
    + 'FIELD:fleet_spend_volatility_0t6:TYPE(STRING):0,0\n'
    + 'FIELD:fleet_spend_volatility_6t12:TYPE(STRING):0,0\n'
    + 'FIELD:carrier_paid_average_12:TYPE(STRING):0,0\n'
    + 'FIELD:carrier_paid_monthspastworst_24:TYPE(STRING):0,0\n'
    + 'FIELD:carrier_paid_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:carrier_paid_slope_0t24:LIKE(Ratio):0,0\n'
    + 'FIELD:carrier_paid_slope_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:carrier_paid_volatility_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:carrier_paid_volatility_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:carrier_spend_monthspastleast_24:TYPE(STRING):0,0\n'
    + 'FIELD:carrier_spend_monthspastmost_24:TYPE(STRING):0,0\n'
    + 'FIELD:carrier_spend_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:carrier_spend_slope_0t24:LIKE(Ratio):0,0\n'
    + 'FIELD:carrier_spend_slope_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:carrier_spend_sum_12:TYPE(STRING):0,0\n'
    + 'FIELD:carrier_spend_volatility_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:carrier_spend_volatility_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:bldgmats_paid_average_12:TYPE(STRING):0,0\n'
    + 'FIELD:bldgmats_paid_monthspastworst_24:TYPE(STRING):0,0\n'
    + 'FIELD:bldgmats_paid_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:bldgmats_paid_slope_0t24:LIKE(Ratio):0,0\n'
    + 'FIELD:bldgmats_paid_slope_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:bldgmats_paid_volatility_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:bldgmats_paid_volatility_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:bldgmats_spend_monthspastleast_24:TYPE(STRING):0,0\n'
    + 'FIELD:bldgmats_spend_monthspastmost_24:TYPE(STRING):0,0\n'
    + 'FIELD:bldgmats_spend_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:bldgmats_spend_slope_0t24:LIKE(Ratio):0,0\n'
    + 'FIELD:bldgmats_spend_slope_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:bldgmats_spend_sum_12:TYPE(STRING):0,0\n'
    + 'FIELD:bldgmats_spend_volatility_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:bldgmats_spend_volatility_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:top5_paid_average_12:TYPE(STRING):0,0\n'
    + 'FIELD:top5_paid_monthspastworst_24:TYPE(STRING):0,0\n'
    + 'FIELD:top5_paid_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:top5_paid_slope_0t24:LIKE(Ratio):0,0\n'
    + 'FIELD:top5_paid_slope_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:top5_paid_volatility_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:top5_paid_volatility_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:top5_spend_monthspastleast_24:TYPE(STRING):0,0\n'
    + 'FIELD:top5_spend_monthspastmost_24:TYPE(STRING):0,0\n'
    + 'FIELD:top5_spend_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:top5_spend_slope_0t24:LIKE(Ratio):0,0\n'
    + 'FIELD:top5_spend_slope_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:top5_spend_sum_12:TYPE(STRING):0,0\n'
    + 'FIELD:top5_spend_volatility_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:top5_spend_volatility_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:total_numrel_avg12:TYPE(STRING):0,0\n'
    + 'FIELD:total_numrel_monthpspastmost_24:TYPE(STRING):0,0\n'
    + 'FIELD:total_numrel_monthspastleast_24:TYPE(STRING):0,0\n'
    + 'FIELD:total_numrel_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:total_numrel_slope_0t24:LIKE(Ratio):0,0\n'
    + 'FIELD:total_numrel_slope_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:total_numrel_slope_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:total_numrel_var_0t12:TYPE(STRING):0,0\n'
    + 'FIELD:total_numrel_var_0t24:TYPE(STRING):0,0\n'
    + 'FIELD:total_numrel_var_12t24:TYPE(STRING):0,0\n'
    + 'FIELD:total_numrel_var_6t18:TYPE(STRING):0,0\n'
    + 'FIELD:mfgmat_numrel_avg12:TYPE(STRING):0,0\n'
    + 'FIELD:mfgmat_numrel_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:mfgmat_numrel_slope_0t24:LIKE(Ratio):0,0\n'
    + 'FIELD:mfgmat_numrel_slope_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:mfgmat_numrel_slope_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:mfgmat_numrel_var_0t12:TYPE(STRING):0,0\n'
    + 'FIELD:mfgmat_numrel_var_12t24:TYPE(STRING):0,0\n'
    + 'FIELD:ops_numrel_avg12:TYPE(STRING):0,0\n'
    + 'FIELD:ops_numrel_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:ops_numrel_slope_0t24:LIKE(Ratio):0,0\n'
    + 'FIELD:ops_numrel_slope_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:ops_numrel_slope_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:ops_numrel_var_0t12:TYPE(STRING):0,0\n'
    + 'FIELD:ops_numrel_var_12t24:TYPE(STRING):0,0\n'
    + 'FIELD:fleet_numrel_avg12:TYPE(STRING):0,0\n'
    + 'FIELD:fleet_numrel_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:fleet_numrel_slope_0t24:LIKE(Ratio):0,0\n'
    + 'FIELD:fleet_numrel_slope_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:fleet_numrel_slope_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:fleet_numrel_var_0t12:TYPE(STRING):0,0\n'
    + 'FIELD:fleet_numrel_var_12t24:TYPE(STRING):0,0\n'
    + 'FIELD:carrier_numrel_avg12:TYPE(STRING):0,0\n'
    + 'FIELD:carrier_numrel_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:carrier_numrel_slope_0t24:LIKE(Ratio):0,0\n'
    + 'FIELD:carrier_numrel_slope_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:carrier_numrel_slope_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:carrier_numrel_var_0t12:TYPE(STRING):0,0\n'
    + 'FIELD:carrier_numrel_var_12t24:TYPE(STRING):0,0\n'
    + 'FIELD:bldgmats_numrel_avg12:TYPE(STRING):0,0\n'
    + 'FIELD:bldgmats_numrel_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:bldgmats_numrel_slope_0t24:LIKE(Ratio):0,0\n'
    + 'FIELD:bldgmats_numrel_slope_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:bldgmats_numrel_slope_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:bldgmats_numrel_var_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:bldgmats_numrel_var_12t24:LIKE(Ratio):0,0\n'
    + 'FIELD:total_monthsoutstanding_slope24:TYPE(STRING):0,0\n'
    + 'FIELD:total_percprov30_avg_0t12:TYPE(STRING):0,0\n'
    + 'FIELD:total_percprov30_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:total_percprov30_slope_0t24:LIKE(Ratio):0,0\n'
    + 'FIELD:total_percprov30_slope_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:total_percprov30_slope_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:total_percprov60_avg_0t12:TYPE(STRING):0,0\n'
    + 'FIELD:total_percprov60_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:total_percprov60_slope_0t24:LIKE(Ratio):0,0\n'
    + 'FIELD:total_percprov60_slope_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:total_percprov60_slope_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:total_percprov90_avg_0t12:TYPE(STRING):0,0\n'
    + 'FIELD:total_percprov90_lowerlim_0t12:TYPE(STRING):0,0\n'
    + 'FIELD:total_percprov90_slope_0t24:LIKE(Ratio):0,0\n'
    + 'FIELD:total_percprov90_slope_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:total_percprov90_slope_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:total_percprovoutstanding_adjustedslope_0t12:TYPE(STRING):0,0\n'
    + 'FIELD:mfgmat_monthsoutstanding_slope24:TYPE(STRING):0,0\n'
    + 'FIELD:mfgmat_percprov30_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:mfgmat_percprov30_slope_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:mfgmat_percprov60_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:mfgmat_percprov60_slope_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:mfgmat_percprov90_slope_0t24:LIKE(Ratio):0,0\n'
    + 'FIELD:mfgmat_percprov90_slope_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:mfgmat_percprov90_slope_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:mfgmat_percprovoutstanding_adjustedslope_0t12:TYPE(STRING):0,0\n'
    + 'FIELD:ops_monthsoutstanding_slope24:TYPE(STRING):0,0\n'
    + 'FIELD:ops_percprov30_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:ops_percprov30_slope_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:ops_percprov60_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:ops_percprov60_slope_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:ops_percprov90_slope_0t24:LIKE(Ratio):0,0\n'
    + 'FIELD:ops_percprov90_slope_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:ops_percprov90_slope_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:ops_percprovoutstanding_adjustedslope_0t12:TYPE(STRING):0,0\n'
    + 'FIELD:fleet_monthsoutstanding_slope24:TYPE(STRING):0,0\n'
    + 'FIELD:fleet_percprov30_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:fleet_percprov30_slope_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:fleet_percprov60_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:fleet_percprov60_slope_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:fleet_percprov90_slope_0t24:LIKE(Ratio):0,0\n'
    + 'FIELD:fleet_percprov90_slope_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:fleet_percprov90_slope_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:fleet_percprovoutstanding_adjustedslope_0t12:TYPE(STRING):0,0\n'
    + 'FIELD:carrier_monthsoutstanding_slope24:TYPE(STRING):0,0\n'
    + 'FIELD:carrier_percprov30_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:carrier_percprov30_slope_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:carrier_percprov60_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:carrier_percprov60_slope_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:carrier_percprov90_slope_0t24:LIKE(Ratio):0,0\n'
    + 'FIELD:carrier_percprov90_slope_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:carrier_percprov90_slope_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:carrier_percprovoutstanding_adjustedslope_0t12:TYPE(STRING):0,0\n'
    + 'FIELD:bldgmats_monthsoutstanding_slope24:TYPE(STRING):0,0\n'
    + 'FIELD:bldgmats_percprov30_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:bldgmats_percprov30_slope_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:bldgmats_percprov60_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:bldgmats_percprov60_slope_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:bldgmats_percprov90_slope_0t24:LIKE(Ratio):0,0\n'
    + 'FIELD:bldgmats_percprov90_slope_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:bldgmats_percprov90_slope_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:bldgmats_percprovoutstanding_adjustedslope_0t12:TYPE(STRING):0,0\n'
    + 'FIELD:top5_monthsoutstanding_slope24:TYPE(STRING):0,0\n'
    + 'FIELD:top5_percprov30_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:top5_percprov30_slope_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:top5_percprov60_slope_0t12:LIKE(Ratio):0,0\n'
    + 'FIELD:top5_percprov60_slope_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:top5_percprov90_slope_0t24:LIKE(Ratio):0,0\n'
    + 'FIELD:top5_percprov90_slope_0t6:LIKE(Ratio):0,0\n'
    + 'FIELD:top5_percprov90_slope_6t12:LIKE(Ratio):0,0\n'
    + 'FIELD:top5_percprovoutstanding_adjustedslope_0t12:LIKE(Ratio):0,0\n'
    ;

  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});

END;
