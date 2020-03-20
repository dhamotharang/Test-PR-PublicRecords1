﻿Generated by SALT V3.11.4
Command line options: -MScrubs_Cortera -eC:\Users\oneillbw\AppData\Local\Temp\TFRDECB.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_Cortera
FILENAME:Cortera
NAMESCOPE:Attributes
// Uncomment up to NINES for internal or external adl
// IDFIELD:EXISTS:<NameOfIDField>
// RIDFIELD:<NameOfRidField>
// RECORDS:<NumberOfRecordsInDataFile>
// POPULATION:<ExpectedNumberOfEntitiesInDataFile>
// NINES:<Precision required 3 = 99.9%, 2 = 99% etc>
// Uncomment Process if doing external adl
// PROCESS:<ProcessName>
// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields
// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking
// FUZZY can be used to create new types of FUZZY linking
// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.
// If the actual specificity for a field is <1, round it up to 1 rather than down to 0.  If your cluster is running
// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.
// FIELDTYPE:Number:ALLOW(0123456789)
FIELDTYPE:Number:ALLOW(0123456789)
FIELDTYPE:Ratio:ALLOW(0123456789.-E):LENGTHS(0,1..)
 
FIELD:ultimate_linkid:LIKE(Number):0,0
FIELD:cortera_score:LIKE(Number):0,0
FIELD:cpr_score:LIKE(Number):0,0
FIELD:cpr_segment:LIKE(Number):0,0
FIELD:dbt:LIKE(Ratio):0,0
FIELD:avg_bal:LIKE(Number):0,0
FIELD:air_spend:LIKE(Number):0,0
FIELD:fuel_spend:LIKE(Number):0,0
FIELD:leasing_spend:LIKE(Number):0,0
FIELD:ltl_spend:LIKE(Number):0,0
FIELD:rail_spend:LIKE(Number):0,0
FIELD:tl_spend:LIKE(Number):0,0
FIELD:transvc_spend:LIKE(Number):0,0
FIELD:transup_spend:LIKE(Number):0,0
FIELD:bst_spend:LIKE(Number):0,0
FIELD:dg_spend:LIKE(Number):0,0
FIELD:electrical_spend:LIKE(Number):0,0
FIELD:hvac_spend:LIKE(Number):0,0
FIELD:other_b_spend:LIKE(Number):0,0
FIELD:plumbing_spend:LIKE(Number):0,0
FIELD:rs_spend:LIKE(Number):0,0
FIELD:wp_spend:LIKE(Number):0,0
FIELD:chemical_spend:LIKE(Number):0,0
FIELD:electronic_spend:LIKE(Number):0,0
FIELD:metal_spend:LIKE(Number):0,0
FIELD:other_m_spend:LIKE(Number):0,0
FIELD:packaging_spend:LIKE(Number):0,0
FIELD:pvf_spend:LIKE(Number):0,0
FIELD:plastic_spend:LIKE(Number):0,0
FIELD:textile_spend:LIKE(Number):0,0
FIELD:bs_spend:LIKE(Number):0,0
FIELD:ce_spend:LIKE(Number):0,0
FIELD:hardware_spend:LIKE(Number):0,0
FIELD:ie_spend:LIKE(Number):0,0
FIELD:is_spend:LIKE(Number):0,0
FIELD:it_spend:LIKE(Number):0,0
FIELD:mls_spend:LIKE(Number):0,0
FIELD:os_spend:LIKE(Number):0,0
FIELD:pp_spend:LIKE(Number):0,0
FIELD:sis_spend:LIKE(Number):0,0
FIELD:apparel_spend:LIKE(Number):0,0
FIELD:beverages_spend:LIKE(Number):0,0
FIELD:constr_spend:LIKE(Number):0,0
FIELD:consulting_spend:LIKE(Number):0,0
FIELD:fs_spend:LIKE(Number):0,0
FIELD:fp_spend:LIKE(Number):0,0
FIELD:insurance_spend:LIKE(Number):0,0
FIELD:ls_spend:LIKE(Number):0,0
FIELD:oil_gas_spend:LIKE(Number):0,0
FIELD:utilities_spend:LIKE(Number):0,0
FIELD:other_spend:LIKE(Number):0,0
FIELD:advt_spend:LIKE(Number):0,0
FIELD:air_growth:LIKE(Ratio):0,0
FIELD:fuel_growth:LIKE(Ratio):0,0
FIELD:leasing_growth:LIKE(Ratio):0,0
FIELD:ltl_growth:LIKE(Ratio):0,0
FIELD:rail_growth:LIKE(Ratio):0,0
FIELD:tl_growth:LIKE(Ratio):0,0
FIELD:transvc_growth:LIKE(Ratio):0,0
FIELD:transup_growth:LIKE(Ratio):0,0
FIELD:bst_growth:LIKE(Ratio):0,0
FIELD:dg_growth:LIKE(Ratio):0,0
FIELD:electrical_growth:LIKE(Ratio):0,0
FIELD:hvac_growth:LIKE(Ratio):0,0
FIELD:other_b_growth:LIKE(Ratio):0,0
FIELD:plumbing_growth:LIKE(Ratio):0,0
FIELD:rs_growth:LIKE(Ratio):0,0
FIELD:wp_growth:LIKE(Ratio):0,0
FIELD:chemical_growth:LIKE(Ratio):0,0
FIELD:electronic_growth:LIKE(Ratio):0,0
FIELD:metal_growth:LIKE(Ratio):0,0
FIELD:other_m_growth:LIKE(Ratio):0,0
FIELD:packaging_growth:LIKE(Ratio):0,0
FIELD:pvf_growth:LIKE(Ratio):0,0
FIELD:plastic_growth:LIKE(Ratio):0,0
FIELD:textile_growth:LIKE(Ratio):0,0
FIELD:bs_growth:LIKE(Ratio):0,0
FIELD:ce_growth:LIKE(Ratio):0,0
FIELD:hardware_growth:LIKE(Ratio):0,0
FIELD:ie_growth:LIKE(Ratio):0,0
FIELD:is_growth:LIKE(Ratio):0,0
FIELD:it_growth:LIKE(Ratio):0,0
FIELD:mls_growth:LIKE(Ratio):0,0
FIELD:os_growth:LIKE(Ratio):0,0
FIELD:pp_growth:LIKE(Ratio):0,0
FIELD:sis_growth:LIKE(Ratio):0,0
FIELD:apparel_growth:LIKE(Ratio):0,0
FIELD:beverages_growth:LIKE(Ratio):0,0
FIELD:constr_growth:LIKE(Ratio):0,0
FIELD:consulting_growth:LIKE(Ratio):0,0
FIELD:fs_growth:LIKE(Ratio):0,0
FIELD:fp_growth:LIKE(Ratio):0,0
FIELD:insurance_growth:LIKE(Ratio):0,0
FIELD:ls_growth:LIKE(Ratio):0,0
FIELD:oil_gas_growth:LIKE(Ratio):0,0
FIELD:utilities_growth:LIKE(Ratio):0,0
FIELD:other_growth:LIKE(Ratio):0,0
FIELD:advt_growth:LIKE(Ratio):0,0
FIELD:top5_growth:LIKE(Ratio):0,0
FIELD:shipping_y1:LIKE(Number):0,0
FIELD:shipping_growth:LIKE(Ratio):0,0
FIELD:materials_y1:LIKE(Number):0,0
FIELD:materials_growth:LIKE(Ratio):0,0
FIELD:operations_y1:LIKE(Number):0,0
FIELD:operations_growth:LIKE(Ratio):0,0
FIELD:total_paid_average_0t12:LIKE(Ratio):0,0
FIELD:total_paid_monthspastworst_24:LIKE(Ratio):0,0
FIELD:total_paid_slope_0t12:LIKE(Ratio):0,0
FIELD:total_paid_slope_0t6:LIKE(Ratio):0,0
FIELD:total_paid_slope_6t12:LIKE(Ratio):0,0
FIELD:total_paid_slope_6t18:LIKE(Ratio):0,0
FIELD:total_paid_volatility_0t12:LIKE(Ratio):0,0
FIELD:total_paid_volatility_0t6:LIKE(Ratio):0,0
FIELD:total_paid_volatility_12t18:LIKE(Ratio):0,0
FIELD:total_paid_volatility_6t12:LIKE(Ratio):0,0
FIELD:total_spend_monthspastleast_24:LIKE(Number):0,0
FIELD:total_spend_monthspastmost_24:LIKE(Number):0,0
FIELD:total_spend_slope_0t12:LIKE(Ratio):0,0
FIELD:total_spend_slope_0t24:LIKE(Ratio):0,0
FIELD:total_spend_slope_0t6:LIKE(Ratio):0,0
FIELD:total_spend_slope_6t12:LIKE(Ratio):0,0
FIELD:total_spend_sum_12:LIKE(Ratio):0,0
FIELD:total_spend_volatility_0t12:LIKE(Ratio):0,0
FIELD:total_spend_volatility_0t6:LIKE(Ratio):0,0
FIELD:total_spend_volatility_12t18:LIKE(Ratio):0,0
FIELD:total_spend_volatility_6t12:LIKE(Ratio):0,0
FIELD:mfgmat_paid_average_12:LIKE(Ratio):0,0
FIELD:mfgmat_paid_monthspastworst_24:LIKE(Number):0,0
FIELD:mfgmat_paid_slope_0t12:LIKE(Ratio):0,0
FIELD:mfgmat_paid_slope_0t24:LIKE(Ratio):0,0
FIELD:mfgmat_paid_slope_0t6:LIKE(Ratio):0,0
FIELD:mfgmat_paid_volatility_0t12:LIKE(Ratio):0,0
FIELD:mfgmat_paid_volatility_0t6:LIKE(Ratio):0,0
FIELD:mfgmat_spend_monthspastleast_24:LIKE(Number):0,0
FIELD:mfgmat_spend_monthspastmost_24:LIKE(Number):0,0
FIELD:mfgmat_spend_slope_0t12:LIKE(Ratio):0,0
FIELD:mfgmat_spend_slope_0t24:LIKE(Ratio):0,0
FIELD:mfgmat_spend_slope_0t6:LIKE(Ratio):0,0
FIELD:mfgmat_spend_sum_12:LIKE(Ratio):0,0
FIELD:mfgmat_spend_volatility_0t6:LIKE(Ratio):0,0
FIELD:mfgmat_spend_volatility_6t12:LIKE(Ratio):0,0
FIELD:ops_paid_average_12:LIKE(Ratio):0,0
FIELD:ops_paid_monthspastworst_24:LIKE(Ratio):0,0
FIELD:ops_paid_slope_0t12:LIKE(Ratio):0,0
FIELD:ops_paid_slope_0t24:LIKE(Ratio):0,0
FIELD:ops_paid_slope_0t6:LIKE(Ratio):0,0
FIELD:ops_paid_volatility_0t12:LIKE(Ratio):0,0
FIELD:ops_paid_volatility_0t6:LIKE(Ratio):0,0
FIELD:ops_spend_monthspastleast_24:LIKE(Number):0,0
FIELD:ops_spend_monthspastmost_24:LIKE(Number):0,0
FIELD:ops_spend_slope_0t12:LIKE(Ratio):0,0
FIELD:ops_spend_slope_0t24:LIKE(Ratio):0,0
FIELD:ops_spend_slope_0t6:LIKE(Ratio):0,0
FIELD:ops_spend_sum_12:TYPE(STRING):0,0
FIELD:ops_spend_volatility_0t6:TYPE(STRING):0,0
FIELD:ops_spend_volatility_6t12:TYPE(STRING):0,0
FIELD:fleet_paid_average_12:TYPE(STRING):0,0
FIELD:fleet_paid_monthspastworst_24:LIKE(Number):0,0
FIELD:fleet_paid_slope_0t12:LIKE(Ratio):0,0
FIELD:fleet_paid_slope_0t24:LIKE(Ratio):0,0
FIELD:fleet_paid_slope_0t6:LIKE(Ratio):0,0
FIELD:fleet_paid_volatility_0t12:LIKE(Ratio):0,0
FIELD:fleet_paid_volatility_0t6:LIKE(Ratio):0,0
FIELD:fleet_spend_monthspastleast_24:TYPE(STRING):0,0
FIELD:fleet_spend_monthspastmost_24:TYPE(STRING):0,0
FIELD:fleet_spend_slope_0t12:LIKE(Ratio):0,0
FIELD:fleet_spend_slope_0t24:LIKE(Ratio):0,0
FIELD:fleet_spend_slope_0t6:LIKE(Ratio):0,0
FIELD:fleet_spend_sum_12:TYPE(STRING):0,0
FIELD:fleet_spend_volatility_0t6:TYPE(STRING):0,0
FIELD:fleet_spend_volatility_6t12:TYPE(STRING):0,0
FIELD:carrier_paid_average_12:TYPE(STRING):0,0
FIELD:carrier_paid_monthspastworst_24:TYPE(STRING):0,0
FIELD:carrier_paid_slope_0t12:LIKE(Ratio):0,0
FIELD:carrier_paid_slope_0t24:LIKE(Ratio):0,0
FIELD:carrier_paid_slope_0t6:LIKE(Ratio):0,0
FIELD:carrier_paid_volatility_0t12:LIKE(Ratio):0,0
FIELD:carrier_paid_volatility_0t6:LIKE(Ratio):0,0
FIELD:carrier_spend_monthspastleast_24:TYPE(STRING):0,0
FIELD:carrier_spend_monthspastmost_24:TYPE(STRING):0,0
FIELD:carrier_spend_slope_0t12:LIKE(Ratio):0,0
FIELD:carrier_spend_slope_0t24:LIKE(Ratio):0,0
FIELD:carrier_spend_slope_0t6:LIKE(Ratio):0,0
FIELD:carrier_spend_sum_12:TYPE(STRING):0,0
FIELD:carrier_spend_volatility_0t6:LIKE(Ratio):0,0
FIELD:carrier_spend_volatility_6t12:LIKE(Ratio):0,0
FIELD:bldgmats_paid_average_12:TYPE(STRING):0,0
FIELD:bldgmats_paid_monthspastworst_24:TYPE(STRING):0,0
FIELD:bldgmats_paid_slope_0t12:LIKE(Ratio):0,0
FIELD:bldgmats_paid_slope_0t24:LIKE(Ratio):0,0
FIELD:bldgmats_paid_slope_0t6:LIKE(Ratio):0,0
FIELD:bldgmats_paid_volatility_0t12:LIKE(Ratio):0,0
FIELD:bldgmats_paid_volatility_0t6:LIKE(Ratio):0,0
FIELD:bldgmats_spend_monthspastleast_24:TYPE(STRING):0,0
FIELD:bldgmats_spend_monthspastmost_24:TYPE(STRING):0,0
FIELD:bldgmats_spend_slope_0t12:LIKE(Ratio):0,0
FIELD:bldgmats_spend_slope_0t24:LIKE(Ratio):0,0
FIELD:bldgmats_spend_slope_0t6:LIKE(Ratio):0,0
FIELD:bldgmats_spend_sum_12:TYPE(STRING):0,0
FIELD:bldgmats_spend_volatility_0t6:LIKE(Ratio):0,0
FIELD:bldgmats_spend_volatility_6t12:LIKE(Ratio):0,0
FIELD:top5_paid_average_12:TYPE(STRING):0,0
FIELD:top5_paid_monthspastworst_24:TYPE(STRING):0,0
FIELD:top5_paid_slope_0t12:LIKE(Ratio):0,0
FIELD:top5_paid_slope_0t24:LIKE(Ratio):0,0
FIELD:top5_paid_slope_0t6:LIKE(Ratio):0,0
FIELD:top5_paid_volatility_0t12:LIKE(Ratio):0,0
FIELD:top5_paid_volatility_0t6:LIKE(Ratio):0,0
FIELD:top5_spend_monthspastleast_24:TYPE(STRING):0,0
FIELD:top5_spend_monthspastmost_24:TYPE(STRING):0,0
FIELD:top5_spend_slope_0t12:LIKE(Ratio):0,0
FIELD:top5_spend_slope_0t24:LIKE(Ratio):0,0
FIELD:top5_spend_slope_0t6:LIKE(Ratio):0,0
FIELD:top5_spend_sum_12:TYPE(STRING):0,0
FIELD:top5_spend_volatility_0t6:LIKE(Ratio):0,0
FIELD:top5_spend_volatility_6t12:LIKE(Ratio):0,0
FIELD:total_numrel_avg12:TYPE(STRING):0,0
FIELD:total_numrel_monthpspastmost_24:TYPE(STRING):0,0
FIELD:total_numrel_monthspastleast_24:TYPE(STRING):0,0
FIELD:total_numrel_slope_0t12:LIKE(Ratio):0,0
FIELD:total_numrel_slope_0t24:LIKE(Ratio):0,0
FIELD:total_numrel_slope_0t6:LIKE(Ratio):0,0
FIELD:total_numrel_slope_6t12:LIKE(Ratio):0,0
FIELD:total_numrel_var_0t12:TYPE(STRING):0,0
FIELD:total_numrel_var_0t24:TYPE(STRING):0,0
FIELD:total_numrel_var_12t24:TYPE(STRING):0,0
FIELD:total_numrel_var_6t18:TYPE(STRING):0,0
FIELD:mfgmat_numrel_avg12:TYPE(STRING):0,0
FIELD:mfgmat_numrel_slope_0t12:LIKE(Ratio):0,0
FIELD:mfgmat_numrel_slope_0t24:LIKE(Ratio):0,0
FIELD:mfgmat_numrel_slope_0t6:LIKE(Ratio):0,0
FIELD:mfgmat_numrel_slope_6t12:LIKE(Ratio):0,0
FIELD:mfgmat_numrel_var_0t12:TYPE(STRING):0,0
FIELD:mfgmat_numrel_var_12t24:TYPE(STRING):0,0
FIELD:ops_numrel_avg12:TYPE(STRING):0,0
FIELD:ops_numrel_slope_0t12:LIKE(Ratio):0,0
FIELD:ops_numrel_slope_0t24:LIKE(Ratio):0,0
FIELD:ops_numrel_slope_0t6:LIKE(Ratio):0,0
FIELD:ops_numrel_slope_6t12:LIKE(Ratio):0,0
FIELD:ops_numrel_var_0t12:TYPE(STRING):0,0
FIELD:ops_numrel_var_12t24:TYPE(STRING):0,0
FIELD:fleet_numrel_avg12:TYPE(STRING):0,0
FIELD:fleet_numrel_slope_0t12:LIKE(Ratio):0,0
FIELD:fleet_numrel_slope_0t24:LIKE(Ratio):0,0
FIELD:fleet_numrel_slope_0t6:LIKE(Ratio):0,0
FIELD:fleet_numrel_slope_6t12:LIKE(Ratio):0,0
FIELD:fleet_numrel_var_0t12:TYPE(STRING):0,0
FIELD:fleet_numrel_var_12t24:TYPE(STRING):0,0
FIELD:carrier_numrel_avg12:TYPE(STRING):0,0
FIELD:carrier_numrel_slope_0t12:LIKE(Ratio):0,0
FIELD:carrier_numrel_slope_0t24:LIKE(Ratio):0,0
FIELD:carrier_numrel_slope_0t6:LIKE(Ratio):0,0
FIELD:carrier_numrel_slope_6t12:LIKE(Ratio):0,0
FIELD:carrier_numrel_var_0t12:TYPE(STRING):0,0
FIELD:carrier_numrel_var_12t24:TYPE(STRING):0,0
FIELD:bldgmats_numrel_avg12:TYPE(STRING):0,0
FIELD:bldgmats_numrel_slope_0t12:LIKE(Ratio):0,0
FIELD:bldgmats_numrel_slope_0t24:LIKE(Ratio):0,0
FIELD:bldgmats_numrel_slope_0t6:LIKE(Ratio):0,0
FIELD:bldgmats_numrel_slope_6t12:LIKE(Ratio):0,0
FIELD:bldgmats_numrel_var_0t12:LIKE(Ratio):0,0
FIELD:bldgmats_numrel_var_12t24:LIKE(Ratio):0,0
FIELD:total_monthsoutstanding_slope24:TYPE(STRING):0,0
FIELD:total_percprov30_avg_0t12:TYPE(STRING):0,0
FIELD:total_percprov30_slope_0t12:LIKE(Ratio):0,0
FIELD:total_percprov30_slope_0t24:LIKE(Ratio):0,0
FIELD:total_percprov30_slope_0t6:LIKE(Ratio):0,0
FIELD:total_percprov30_slope_6t12:LIKE(Ratio):0,0
FIELD:total_percprov60_avg_0t12:TYPE(STRING):0,0
FIELD:total_percprov60_slope_0t12:LIKE(Ratio):0,0
FIELD:total_percprov60_slope_0t24:LIKE(Ratio):0,0
FIELD:total_percprov60_slope_0t6:LIKE(Ratio):0,0
FIELD:total_percprov60_slope_6t12:LIKE(Ratio):0,0
FIELD:total_percprov90_avg_0t12:TYPE(STRING):0,0
FIELD:total_percprov90_lowerlim_0t12:TYPE(STRING):0,0
FIELD:total_percprov90_slope_0t24:LIKE(Ratio):0,0
FIELD:total_percprov90_slope_0t6:LIKE(Ratio):0,0
FIELD:total_percprov90_slope_6t12:LIKE(Ratio):0,0
FIELD:total_percprovoutstanding_adjustedslope_0t12:TYPE(STRING):0,0
FIELD:mfgmat_monthsoutstanding_slope24:TYPE(STRING):0,0
FIELD:mfgmat_percprov30_slope_0t12:LIKE(Ratio):0,0
FIELD:mfgmat_percprov30_slope_6t12:LIKE(Ratio):0,0
FIELD:mfgmat_percprov60_slope_0t12:LIKE(Ratio):0,0
FIELD:mfgmat_percprov60_slope_6t12:LIKE(Ratio):0,0
FIELD:mfgmat_percprov90_slope_0t24:LIKE(Ratio):0,0
FIELD:mfgmat_percprov90_slope_0t6:LIKE(Ratio):0,0
FIELD:mfgmat_percprov90_slope_6t12:LIKE(Ratio):0,0
FIELD:mfgmat_percprovoutstanding_adjustedslope_0t12:TYPE(STRING):0,0
FIELD:ops_monthsoutstanding_slope24:TYPE(STRING):0,0
FIELD:ops_percprov30_slope_0t12:LIKE(Ratio):0,0
FIELD:ops_percprov30_slope_6t12:LIKE(Ratio):0,0
FIELD:ops_percprov60_slope_0t12:LIKE(Ratio):0,0
FIELD:ops_percprov60_slope_6t12:LIKE(Ratio):0,0
FIELD:ops_percprov90_slope_0t24:LIKE(Ratio):0,0
FIELD:ops_percprov90_slope_0t6:LIKE(Ratio):0,0
FIELD:ops_percprov90_slope_6t12:LIKE(Ratio):0,0
FIELD:ops_percprovoutstanding_adjustedslope_0t12:TYPE(STRING):0,0
FIELD:fleet_monthsoutstanding_slope24:TYPE(STRING):0,0
FIELD:fleet_percprov30_slope_0t12:LIKE(Ratio):0,0
FIELD:fleet_percprov30_slope_6t12:LIKE(Ratio):0,0
FIELD:fleet_percprov60_slope_0t12:LIKE(Ratio):0,0
FIELD:fleet_percprov60_slope_6t12:LIKE(Ratio):0,0
FIELD:fleet_percprov90_slope_0t24:LIKE(Ratio):0,0
FIELD:fleet_percprov90_slope_0t6:LIKE(Ratio):0,0
FIELD:fleet_percprov90_slope_6t12:LIKE(Ratio):0,0
FIELD:fleet_percprovoutstanding_adjustedslope_0t12:TYPE(STRING):0,0
FIELD:carrier_monthsoutstanding_slope24:TYPE(STRING):0,0
FIELD:carrier_percprov30_slope_0t12:LIKE(Ratio):0,0
FIELD:carrier_percprov30_slope_6t12:LIKE(Ratio):0,0
FIELD:carrier_percprov60_slope_0t12:LIKE(Ratio):0,0
FIELD:carrier_percprov60_slope_6t12:LIKE(Ratio):0,0
FIELD:carrier_percprov90_slope_0t24:LIKE(Ratio):0,0
FIELD:carrier_percprov90_slope_0t6:LIKE(Ratio):0,0
FIELD:carrier_percprov90_slope_6t12:LIKE(Ratio):0,0
FIELD:carrier_percprovoutstanding_adjustedslope_0t12:TYPE(STRING):0,0
FIELD:bldgmats_monthsoutstanding_slope24:TYPE(STRING):0,0
FIELD:bldgmats_percprov30_slope_0t12:LIKE(Ratio):0,0
FIELD:bldgmats_percprov30_slope_6t12:LIKE(Ratio):0,0
FIELD:bldgmats_percprov60_slope_0t12:LIKE(Ratio):0,0
FIELD:bldgmats_percprov60_slope_6t12:LIKE(Ratio):0,0
FIELD:bldgmats_percprov90_slope_0t24:LIKE(Ratio):0,0
FIELD:bldgmats_percprov90_slope_0t6:LIKE(Ratio):0,0
FIELD:bldgmats_percprov90_slope_6t12:LIKE(Ratio):0,0
FIELD:bldgmats_percprovoutstanding_adjustedslope_0t12:TYPE(STRING):0,0
FIELD:top5_monthsoutstanding_slope24:TYPE(STRING):0,0
FIELD:top5_percprov30_slope_0t12:LIKE(Ratio):0,0
FIELD:top5_percprov30_slope_6t12:LIKE(Ratio):0,0
FIELD:top5_percprov60_slope_0t12:LIKE(Ratio):0,0
FIELD:top5_percprov60_slope_6t12:LIKE(Ratio):0,0
FIELD:top5_percprov90_slope_0t24:LIKE(Ratio):0,0
FIELD:top5_percprov90_slope_0t6:LIKE(Ratio):0,0
FIELD:top5_percprov90_slope_6t12:LIKE(Ratio):0,0
FIELD:top5_percprovoutstanding_adjustedslope_0t12:LIKE(Ratio):0,0
 
Total available specificity:0
Search Threshold set at -4
Use of PERSISTs in code set at:3
 
__Glossary__
Edit Distance: An edit distance of (say) one implies that one string can be converted into another by doing one of
  - Changing one character
  - Deleting one character
  - Transposing two characters
 
Forcing Criteria: In addition to the general 'best match' logic it is possible to insist that
one particular field must match to some degree or the whole record is considered a bad match.
The criterial applied to that one field is the forcing criteria.
 
Cascade: Best Type rules are applied in such a way that the rules are applied one by one UNTIL the first rule succeeds; subsequent rules are then skipped.
 
__General Notes__
How is it decided how much to subtract for a bad match?
SALT computes for each field the percentage likelihood that a valid cluster will have two or more values for a given field
this value (called the switch value in the SALT literature) is then used to produce the subtraction value from the match value.
The value in this document is the one typed into the SPC file; the code will use a value computed at run-time.
 