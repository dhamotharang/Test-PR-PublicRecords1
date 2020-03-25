IMPORT SALT311;
EXPORT Attributes_Fields := MODULE
 
EXPORT NumFields := 333;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Number','Ratio');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Number' => 1,'Ratio' => 2,0);
 
EXPORT MakeFT_Number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Number(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Ratio(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789.-E'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Ratio(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789.-E'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Ratio(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789.-E'),SALT311.HygieneErrors.NotLength('0,1..'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'ultimate_linkid','cortera_score','cpr_score','cpr_segment','dbt','avg_bal','air_spend','fuel_spend','leasing_spend','ltl_spend','rail_spend','tl_spend','transvc_spend','transup_spend','bst_spend','dg_spend','electrical_spend','hvac_spend','other_b_spend','plumbing_spend','rs_spend','wp_spend','chemical_spend','electronic_spend','metal_spend','other_m_spend','packaging_spend','pvf_spend','plastic_spend','textile_spend','bs_spend','ce_spend','hardware_spend','ie_spend','is_spend','it_spend','mls_spend','os_spend','pp_spend','sis_spend','apparel_spend','beverages_spend','constr_spend','consulting_spend','fs_spend','fp_spend','insurance_spend','ls_spend','oil_gas_spend','utilities_spend','other_spend','advt_spend','air_growth','fuel_growth','leasing_growth','ltl_growth','rail_growth','tl_growth','transvc_growth','transup_growth','bst_growth','dg_growth','electrical_growth','hvac_growth','other_b_growth','plumbing_growth','rs_growth','wp_growth','chemical_growth','electronic_growth','metal_growth','other_m_growth','packaging_growth','pvf_growth','plastic_growth','textile_growth','bs_growth','ce_growth','hardware_growth','ie_growth','is_growth','it_growth','mls_growth','os_growth','pp_growth','sis_growth','apparel_growth','beverages_growth','constr_growth','consulting_growth','fs_growth','fp_growth','insurance_growth','ls_growth','oil_gas_growth','utilities_growth','other_growth','advt_growth','top5_growth','shipping_y1','shipping_growth','materials_y1','materials_growth','operations_y1','operations_growth','total_paid_average_0t12','total_paid_monthspastworst_24','total_paid_slope_0t12','total_paid_slope_0t6','total_paid_slope_6t12','total_paid_slope_6t18','total_paid_volatility_0t12','total_paid_volatility_0t6','total_paid_volatility_12t18','total_paid_volatility_6t12','total_spend_monthspastleast_24','total_spend_monthspastmost_24','total_spend_slope_0t12','total_spend_slope_0t24','total_spend_slope_0t6','total_spend_slope_6t12','total_spend_sum_12','total_spend_volatility_0t12','total_spend_volatility_0t6','total_spend_volatility_12t18','total_spend_volatility_6t12','mfgmat_paid_average_12','mfgmat_paid_monthspastworst_24','mfgmat_paid_slope_0t12','mfgmat_paid_slope_0t24','mfgmat_paid_slope_0t6','mfgmat_paid_volatility_0t12','mfgmat_paid_volatility_0t6','mfgmat_spend_monthspastleast_24','mfgmat_spend_monthspastmost_24','mfgmat_spend_slope_0t12','mfgmat_spend_slope_0t24','mfgmat_spend_slope_0t6','mfgmat_spend_sum_12','mfgmat_spend_volatility_0t6','mfgmat_spend_volatility_6t12','ops_paid_average_12','ops_paid_monthspastworst_24','ops_paid_slope_0t12','ops_paid_slope_0t24','ops_paid_slope_0t6','ops_paid_volatility_0t12','ops_paid_volatility_0t6','ops_spend_monthspastleast_24','ops_spend_monthspastmost_24','ops_spend_slope_0t12','ops_spend_slope_0t24','ops_spend_slope_0t6','ops_spend_sum_12','ops_spend_volatility_0t6','ops_spend_volatility_6t12','fleet_paid_average_12','fleet_paid_monthspastworst_24','fleet_paid_slope_0t12','fleet_paid_slope_0t24','fleet_paid_slope_0t6','fleet_paid_volatility_0t12','fleet_paid_volatility_0t6','fleet_spend_monthspastleast_24','fleet_spend_monthspastmost_24','fleet_spend_slope_0t12','fleet_spend_slope_0t24','fleet_spend_slope_0t6','fleet_spend_sum_12','fleet_spend_volatility_0t6','fleet_spend_volatility_6t12','carrier_paid_average_12','carrier_paid_monthspastworst_24','carrier_paid_slope_0t12','carrier_paid_slope_0t24','carrier_paid_slope_0t6','carrier_paid_volatility_0t12','carrier_paid_volatility_0t6','carrier_spend_monthspastleast_24','carrier_spend_monthspastmost_24','carrier_spend_slope_0t12','carrier_spend_slope_0t24','carrier_spend_slope_0t6','carrier_spend_sum_12','carrier_spend_volatility_0t6','carrier_spend_volatility_6t12','bldgmats_paid_average_12','bldgmats_paid_monthspastworst_24','bldgmats_paid_slope_0t12','bldgmats_paid_slope_0t24','bldgmats_paid_slope_0t6','bldgmats_paid_volatility_0t12','bldgmats_paid_volatility_0t6','bldgmats_spend_monthspastleast_24','bldgmats_spend_monthspastmost_24','bldgmats_spend_slope_0t12','bldgmats_spend_slope_0t24','bldgmats_spend_slope_0t6','bldgmats_spend_sum_12','bldgmats_spend_volatility_0t6','bldgmats_spend_volatility_6t12','top5_paid_average_12','top5_paid_monthspastworst_24','top5_paid_slope_0t12','top5_paid_slope_0t24','top5_paid_slope_0t6','top5_paid_volatility_0t12','top5_paid_volatility_0t6','top5_spend_monthspastleast_24','top5_spend_monthspastmost_24','top5_spend_slope_0t12','top5_spend_slope_0t24','top5_spend_slope_0t6','top5_spend_sum_12','top5_spend_volatility_0t6','top5_spend_volatility_6t12','total_numrel_avg12','total_numrel_monthpspastmost_24','total_numrel_monthspastleast_24','total_numrel_slope_0t12','total_numrel_slope_0t24','total_numrel_slope_0t6','total_numrel_slope_6t12','total_numrel_var_0t12','total_numrel_var_0t24','total_numrel_var_12t24','total_numrel_var_6t18','mfgmat_numrel_avg12','mfgmat_numrel_slope_0t12','mfgmat_numrel_slope_0t24','mfgmat_numrel_slope_0t6','mfgmat_numrel_slope_6t12','mfgmat_numrel_var_0t12','mfgmat_numrel_var_12t24','ops_numrel_avg12','ops_numrel_slope_0t12','ops_numrel_slope_0t24','ops_numrel_slope_0t6','ops_numrel_slope_6t12','ops_numrel_var_0t12','ops_numrel_var_12t24','fleet_numrel_avg12','fleet_numrel_slope_0t12','fleet_numrel_slope_0t24','fleet_numrel_slope_0t6','fleet_numrel_slope_6t12','fleet_numrel_var_0t12','fleet_numrel_var_12t24','carrier_numrel_avg12','carrier_numrel_slope_0t12','carrier_numrel_slope_0t24','carrier_numrel_slope_0t6','carrier_numrel_slope_6t12','carrier_numrel_var_0t12','carrier_numrel_var_12t24','bldgmats_numrel_avg12','bldgmats_numrel_slope_0t12','bldgmats_numrel_slope_0t24','bldgmats_numrel_slope_0t6','bldgmats_numrel_slope_6t12','bldgmats_numrel_var_0t12','bldgmats_numrel_var_12t24','total_monthsoutstanding_slope24','total_percprov30_avg_0t12','total_percprov30_slope_0t12','total_percprov30_slope_0t24','total_percprov30_slope_0t6','total_percprov30_slope_6t12','total_percprov60_avg_0t12','total_percprov60_slope_0t12','total_percprov60_slope_0t24','total_percprov60_slope_0t6','total_percprov60_slope_6t12','total_percprov90_avg_0t12','total_percprov90_lowerlim_0t12','total_percprov90_slope_0t24','total_percprov90_slope_0t6','total_percprov90_slope_6t12','total_percprovoutstanding_adjustedslope_0t12','mfgmat_monthsoutstanding_slope24','mfgmat_percprov30_slope_0t12','mfgmat_percprov30_slope_6t12','mfgmat_percprov60_slope_0t12','mfgmat_percprov60_slope_6t12','mfgmat_percprov90_slope_0t24','mfgmat_percprov90_slope_0t6','mfgmat_percprov90_slope_6t12','mfgmat_percprovoutstanding_adjustedslope_0t12','ops_monthsoutstanding_slope24','ops_percprov30_slope_0t12','ops_percprov30_slope_6t12','ops_percprov60_slope_0t12','ops_percprov60_slope_6t12','ops_percprov90_slope_0t24','ops_percprov90_slope_0t6','ops_percprov90_slope_6t12','ops_percprovoutstanding_adjustedslope_0t12','fleet_monthsoutstanding_slope24','fleet_percprov30_slope_0t12','fleet_percprov30_slope_6t12','fleet_percprov60_slope_0t12','fleet_percprov60_slope_6t12','fleet_percprov90_slope_0t24','fleet_percprov90_slope_0t6','fleet_percprov90_slope_6t12','fleet_percprovoutstanding_adjustedslope_0t12','carrier_monthsoutstanding_slope24','carrier_percprov30_slope_0t12','carrier_percprov30_slope_6t12','carrier_percprov60_slope_0t12','carrier_percprov60_slope_6t12','carrier_percprov90_slope_0t24','carrier_percprov90_slope_0t6','carrier_percprov90_slope_6t12','carrier_percprovoutstanding_adjustedslope_0t12','bldgmats_monthsoutstanding_slope24','bldgmats_percprov30_slope_0t12','bldgmats_percprov30_slope_6t12','bldgmats_percprov60_slope_0t12','bldgmats_percprov60_slope_6t12','bldgmats_percprov90_slope_0t24','bldgmats_percprov90_slope_0t6','bldgmats_percprov90_slope_6t12','bldgmats_percprovoutstanding_adjustedslope_0t12','top5_monthsoutstanding_slope24','top5_percprov30_slope_0t12','top5_percprov30_slope_6t12','top5_percprov60_slope_0t12','top5_percprov60_slope_6t12','top5_percprov90_slope_0t24','top5_percprov90_slope_0t6','top5_percprov90_slope_6t12','top5_percprovoutstanding_adjustedslope_0t12');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'ultimate_linkid','cortera_score','cpr_score','cpr_segment','dbt','avg_bal','air_spend','fuel_spend','leasing_spend','ltl_spend','rail_spend','tl_spend','transvc_spend','transup_spend','bst_spend','dg_spend','electrical_spend','hvac_spend','other_b_spend','plumbing_spend','rs_spend','wp_spend','chemical_spend','electronic_spend','metal_spend','other_m_spend','packaging_spend','pvf_spend','plastic_spend','textile_spend','bs_spend','ce_spend','hardware_spend','ie_spend','is_spend','it_spend','mls_spend','os_spend','pp_spend','sis_spend','apparel_spend','beverages_spend','constr_spend','consulting_spend','fs_spend','fp_spend','insurance_spend','ls_spend','oil_gas_spend','utilities_spend','other_spend','advt_spend','air_growth','fuel_growth','leasing_growth','ltl_growth','rail_growth','tl_growth','transvc_growth','transup_growth','bst_growth','dg_growth','electrical_growth','hvac_growth','other_b_growth','plumbing_growth','rs_growth','wp_growth','chemical_growth','electronic_growth','metal_growth','other_m_growth','packaging_growth','pvf_growth','plastic_growth','textile_growth','bs_growth','ce_growth','hardware_growth','ie_growth','is_growth','it_growth','mls_growth','os_growth','pp_growth','sis_growth','apparel_growth','beverages_growth','constr_growth','consulting_growth','fs_growth','fp_growth','insurance_growth','ls_growth','oil_gas_growth','utilities_growth','other_growth','advt_growth','top5_growth','shipping_y1','shipping_growth','materials_y1','materials_growth','operations_y1','operations_growth','total_paid_average_0t12','total_paid_monthspastworst_24','total_paid_slope_0t12','total_paid_slope_0t6','total_paid_slope_6t12','total_paid_slope_6t18','total_paid_volatility_0t12','total_paid_volatility_0t6','total_paid_volatility_12t18','total_paid_volatility_6t12','total_spend_monthspastleast_24','total_spend_monthspastmost_24','total_spend_slope_0t12','total_spend_slope_0t24','total_spend_slope_0t6','total_spend_slope_6t12','total_spend_sum_12','total_spend_volatility_0t12','total_spend_volatility_0t6','total_spend_volatility_12t18','total_spend_volatility_6t12','mfgmat_paid_average_12','mfgmat_paid_monthspastworst_24','mfgmat_paid_slope_0t12','mfgmat_paid_slope_0t24','mfgmat_paid_slope_0t6','mfgmat_paid_volatility_0t12','mfgmat_paid_volatility_0t6','mfgmat_spend_monthspastleast_24','mfgmat_spend_monthspastmost_24','mfgmat_spend_slope_0t12','mfgmat_spend_slope_0t24','mfgmat_spend_slope_0t6','mfgmat_spend_sum_12','mfgmat_spend_volatility_0t6','mfgmat_spend_volatility_6t12','ops_paid_average_12','ops_paid_monthspastworst_24','ops_paid_slope_0t12','ops_paid_slope_0t24','ops_paid_slope_0t6','ops_paid_volatility_0t12','ops_paid_volatility_0t6','ops_spend_monthspastleast_24','ops_spend_monthspastmost_24','ops_spend_slope_0t12','ops_spend_slope_0t24','ops_spend_slope_0t6','ops_spend_sum_12','ops_spend_volatility_0t6','ops_spend_volatility_6t12','fleet_paid_average_12','fleet_paid_monthspastworst_24','fleet_paid_slope_0t12','fleet_paid_slope_0t24','fleet_paid_slope_0t6','fleet_paid_volatility_0t12','fleet_paid_volatility_0t6','fleet_spend_monthspastleast_24','fleet_spend_monthspastmost_24','fleet_spend_slope_0t12','fleet_spend_slope_0t24','fleet_spend_slope_0t6','fleet_spend_sum_12','fleet_spend_volatility_0t6','fleet_spend_volatility_6t12','carrier_paid_average_12','carrier_paid_monthspastworst_24','carrier_paid_slope_0t12','carrier_paid_slope_0t24','carrier_paid_slope_0t6','carrier_paid_volatility_0t12','carrier_paid_volatility_0t6','carrier_spend_monthspastleast_24','carrier_spend_monthspastmost_24','carrier_spend_slope_0t12','carrier_spend_slope_0t24','carrier_spend_slope_0t6','carrier_spend_sum_12','carrier_spend_volatility_0t6','carrier_spend_volatility_6t12','bldgmats_paid_average_12','bldgmats_paid_monthspastworst_24','bldgmats_paid_slope_0t12','bldgmats_paid_slope_0t24','bldgmats_paid_slope_0t6','bldgmats_paid_volatility_0t12','bldgmats_paid_volatility_0t6','bldgmats_spend_monthspastleast_24','bldgmats_spend_monthspastmost_24','bldgmats_spend_slope_0t12','bldgmats_spend_slope_0t24','bldgmats_spend_slope_0t6','bldgmats_spend_sum_12','bldgmats_spend_volatility_0t6','bldgmats_spend_volatility_6t12','top5_paid_average_12','top5_paid_monthspastworst_24','top5_paid_slope_0t12','top5_paid_slope_0t24','top5_paid_slope_0t6','top5_paid_volatility_0t12','top5_paid_volatility_0t6','top5_spend_monthspastleast_24','top5_spend_monthspastmost_24','top5_spend_slope_0t12','top5_spend_slope_0t24','top5_spend_slope_0t6','top5_spend_sum_12','top5_spend_volatility_0t6','top5_spend_volatility_6t12','total_numrel_avg12','total_numrel_monthpspastmost_24','total_numrel_monthspastleast_24','total_numrel_slope_0t12','total_numrel_slope_0t24','total_numrel_slope_0t6','total_numrel_slope_6t12','total_numrel_var_0t12','total_numrel_var_0t24','total_numrel_var_12t24','total_numrel_var_6t18','mfgmat_numrel_avg12','mfgmat_numrel_slope_0t12','mfgmat_numrel_slope_0t24','mfgmat_numrel_slope_0t6','mfgmat_numrel_slope_6t12','mfgmat_numrel_var_0t12','mfgmat_numrel_var_12t24','ops_numrel_avg12','ops_numrel_slope_0t12','ops_numrel_slope_0t24','ops_numrel_slope_0t6','ops_numrel_slope_6t12','ops_numrel_var_0t12','ops_numrel_var_12t24','fleet_numrel_avg12','fleet_numrel_slope_0t12','fleet_numrel_slope_0t24','fleet_numrel_slope_0t6','fleet_numrel_slope_6t12','fleet_numrel_var_0t12','fleet_numrel_var_12t24','carrier_numrel_avg12','carrier_numrel_slope_0t12','carrier_numrel_slope_0t24','carrier_numrel_slope_0t6','carrier_numrel_slope_6t12','carrier_numrel_var_0t12','carrier_numrel_var_12t24','bldgmats_numrel_avg12','bldgmats_numrel_slope_0t12','bldgmats_numrel_slope_0t24','bldgmats_numrel_slope_0t6','bldgmats_numrel_slope_6t12','bldgmats_numrel_var_0t12','bldgmats_numrel_var_12t24','total_monthsoutstanding_slope24','total_percprov30_avg_0t12','total_percprov30_slope_0t12','total_percprov30_slope_0t24','total_percprov30_slope_0t6','total_percprov30_slope_6t12','total_percprov60_avg_0t12','total_percprov60_slope_0t12','total_percprov60_slope_0t24','total_percprov60_slope_0t6','total_percprov60_slope_6t12','total_percprov90_avg_0t12','total_percprov90_lowerlim_0t12','total_percprov90_slope_0t24','total_percprov90_slope_0t6','total_percprov90_slope_6t12','total_percprovoutstanding_adjustedslope_0t12','mfgmat_monthsoutstanding_slope24','mfgmat_percprov30_slope_0t12','mfgmat_percprov30_slope_6t12','mfgmat_percprov60_slope_0t12','mfgmat_percprov60_slope_6t12','mfgmat_percprov90_slope_0t24','mfgmat_percprov90_slope_0t6','mfgmat_percprov90_slope_6t12','mfgmat_percprovoutstanding_adjustedslope_0t12','ops_monthsoutstanding_slope24','ops_percprov30_slope_0t12','ops_percprov30_slope_6t12','ops_percprov60_slope_0t12','ops_percprov60_slope_6t12','ops_percprov90_slope_0t24','ops_percprov90_slope_0t6','ops_percprov90_slope_6t12','ops_percprovoutstanding_adjustedslope_0t12','fleet_monthsoutstanding_slope24','fleet_percprov30_slope_0t12','fleet_percprov30_slope_6t12','fleet_percprov60_slope_0t12','fleet_percprov60_slope_6t12','fleet_percprov90_slope_0t24','fleet_percprov90_slope_0t6','fleet_percprov90_slope_6t12','fleet_percprovoutstanding_adjustedslope_0t12','carrier_monthsoutstanding_slope24','carrier_percprov30_slope_0t12','carrier_percprov30_slope_6t12','carrier_percprov60_slope_0t12','carrier_percprov60_slope_6t12','carrier_percprov90_slope_0t24','carrier_percprov90_slope_0t6','carrier_percprov90_slope_6t12','carrier_percprovoutstanding_adjustedslope_0t12','bldgmats_monthsoutstanding_slope24','bldgmats_percprov30_slope_0t12','bldgmats_percprov30_slope_6t12','bldgmats_percprov60_slope_0t12','bldgmats_percprov60_slope_6t12','bldgmats_percprov90_slope_0t24','bldgmats_percprov90_slope_0t6','bldgmats_percprov90_slope_6t12','bldgmats_percprovoutstanding_adjustedslope_0t12','top5_monthsoutstanding_slope24','top5_percprov30_slope_0t12','top5_percprov30_slope_6t12','top5_percprov60_slope_0t12','top5_percprov60_slope_6t12','top5_percprov90_slope_0t24','top5_percprov90_slope_0t6','top5_percprov90_slope_6t12','top5_percprovoutstanding_adjustedslope_0t12');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'ultimate_linkid' => 0,'cortera_score' => 1,'cpr_score' => 2,'cpr_segment' => 3,'dbt' => 4,'avg_bal' => 5,'air_spend' => 6,'fuel_spend' => 7,'leasing_spend' => 8,'ltl_spend' => 9,'rail_spend' => 10,'tl_spend' => 11,'transvc_spend' => 12,'transup_spend' => 13,'bst_spend' => 14,'dg_spend' => 15,'electrical_spend' => 16,'hvac_spend' => 17,'other_b_spend' => 18,'plumbing_spend' => 19,'rs_spend' => 20,'wp_spend' => 21,'chemical_spend' => 22,'electronic_spend' => 23,'metal_spend' => 24,'other_m_spend' => 25,'packaging_spend' => 26,'pvf_spend' => 27,'plastic_spend' => 28,'textile_spend' => 29,'bs_spend' => 30,'ce_spend' => 31,'hardware_spend' => 32,'ie_spend' => 33,'is_spend' => 34,'it_spend' => 35,'mls_spend' => 36,'os_spend' => 37,'pp_spend' => 38,'sis_spend' => 39,'apparel_spend' => 40,'beverages_spend' => 41,'constr_spend' => 42,'consulting_spend' => 43,'fs_spend' => 44,'fp_spend' => 45,'insurance_spend' => 46,'ls_spend' => 47,'oil_gas_spend' => 48,'utilities_spend' => 49,'other_spend' => 50,'advt_spend' => 51,'air_growth' => 52,'fuel_growth' => 53,'leasing_growth' => 54,'ltl_growth' => 55,'rail_growth' => 56,'tl_growth' => 57,'transvc_growth' => 58,'transup_growth' => 59,'bst_growth' => 60,'dg_growth' => 61,'electrical_growth' => 62,'hvac_growth' => 63,'other_b_growth' => 64,'plumbing_growth' => 65,'rs_growth' => 66,'wp_growth' => 67,'chemical_growth' => 68,'electronic_growth' => 69,'metal_growth' => 70,'other_m_growth' => 71,'packaging_growth' => 72,'pvf_growth' => 73,'plastic_growth' => 74,'textile_growth' => 75,'bs_growth' => 76,'ce_growth' => 77,'hardware_growth' => 78,'ie_growth' => 79,'is_growth' => 80,'it_growth' => 81,'mls_growth' => 82,'os_growth' => 83,'pp_growth' => 84,'sis_growth' => 85,'apparel_growth' => 86,'beverages_growth' => 87,'constr_growth' => 88,'consulting_growth' => 89,'fs_growth' => 90,'fp_growth' => 91,'insurance_growth' => 92,'ls_growth' => 93,'oil_gas_growth' => 94,'utilities_growth' => 95,'other_growth' => 96,'advt_growth' => 97,'top5_growth' => 98,'shipping_y1' => 99,'shipping_growth' => 100,'materials_y1' => 101,'materials_growth' => 102,'operations_y1' => 103,'operations_growth' => 104,'total_paid_average_0t12' => 105,'total_paid_monthspastworst_24' => 106,'total_paid_slope_0t12' => 107,'total_paid_slope_0t6' => 108,'total_paid_slope_6t12' => 109,'total_paid_slope_6t18' => 110,'total_paid_volatility_0t12' => 111,'total_paid_volatility_0t6' => 112,'total_paid_volatility_12t18' => 113,'total_paid_volatility_6t12' => 114,'total_spend_monthspastleast_24' => 115,'total_spend_monthspastmost_24' => 116,'total_spend_slope_0t12' => 117,'total_spend_slope_0t24' => 118,'total_spend_slope_0t6' => 119,'total_spend_slope_6t12' => 120,'total_spend_sum_12' => 121,'total_spend_volatility_0t12' => 122,'total_spend_volatility_0t6' => 123,'total_spend_volatility_12t18' => 124,'total_spend_volatility_6t12' => 125,'mfgmat_paid_average_12' => 126,'mfgmat_paid_monthspastworst_24' => 127,'mfgmat_paid_slope_0t12' => 128,'mfgmat_paid_slope_0t24' => 129,'mfgmat_paid_slope_0t6' => 130,'mfgmat_paid_volatility_0t12' => 131,'mfgmat_paid_volatility_0t6' => 132,'mfgmat_spend_monthspastleast_24' => 133,'mfgmat_spend_monthspastmost_24' => 134,'mfgmat_spend_slope_0t12' => 135,'mfgmat_spend_slope_0t24' => 136,'mfgmat_spend_slope_0t6' => 137,'mfgmat_spend_sum_12' => 138,'mfgmat_spend_volatility_0t6' => 139,'mfgmat_spend_volatility_6t12' => 140,'ops_paid_average_12' => 141,'ops_paid_monthspastworst_24' => 142,'ops_paid_slope_0t12' => 143,'ops_paid_slope_0t24' => 144,'ops_paid_slope_0t6' => 145,'ops_paid_volatility_0t12' => 146,'ops_paid_volatility_0t6' => 147,'ops_spend_monthspastleast_24' => 148,'ops_spend_monthspastmost_24' => 149,'ops_spend_slope_0t12' => 150,'ops_spend_slope_0t24' => 151,'ops_spend_slope_0t6' => 152,'ops_spend_sum_12' => 153,'ops_spend_volatility_0t6' => 154,'ops_spend_volatility_6t12' => 155,'fleet_paid_average_12' => 156,'fleet_paid_monthspastworst_24' => 157,'fleet_paid_slope_0t12' => 158,'fleet_paid_slope_0t24' => 159,'fleet_paid_slope_0t6' => 160,'fleet_paid_volatility_0t12' => 161,'fleet_paid_volatility_0t6' => 162,'fleet_spend_monthspastleast_24' => 163,'fleet_spend_monthspastmost_24' => 164,'fleet_spend_slope_0t12' => 165,'fleet_spend_slope_0t24' => 166,'fleet_spend_slope_0t6' => 167,'fleet_spend_sum_12' => 168,'fleet_spend_volatility_0t6' => 169,'fleet_spend_volatility_6t12' => 170,'carrier_paid_average_12' => 171,'carrier_paid_monthspastworst_24' => 172,'carrier_paid_slope_0t12' => 173,'carrier_paid_slope_0t24' => 174,'carrier_paid_slope_0t6' => 175,'carrier_paid_volatility_0t12' => 176,'carrier_paid_volatility_0t6' => 177,'carrier_spend_monthspastleast_24' => 178,'carrier_spend_monthspastmost_24' => 179,'carrier_spend_slope_0t12' => 180,'carrier_spend_slope_0t24' => 181,'carrier_spend_slope_0t6' => 182,'carrier_spend_sum_12' => 183,'carrier_spend_volatility_0t6' => 184,'carrier_spend_volatility_6t12' => 185,'bldgmats_paid_average_12' => 186,'bldgmats_paid_monthspastworst_24' => 187,'bldgmats_paid_slope_0t12' => 188,'bldgmats_paid_slope_0t24' => 189,'bldgmats_paid_slope_0t6' => 190,'bldgmats_paid_volatility_0t12' => 191,'bldgmats_paid_volatility_0t6' => 192,'bldgmats_spend_monthspastleast_24' => 193,'bldgmats_spend_monthspastmost_24' => 194,'bldgmats_spend_slope_0t12' => 195,'bldgmats_spend_slope_0t24' => 196,'bldgmats_spend_slope_0t6' => 197,'bldgmats_spend_sum_12' => 198,'bldgmats_spend_volatility_0t6' => 199,'bldgmats_spend_volatility_6t12' => 200,'top5_paid_average_12' => 201,'top5_paid_monthspastworst_24' => 202,'top5_paid_slope_0t12' => 203,'top5_paid_slope_0t24' => 204,'top5_paid_slope_0t6' => 205,'top5_paid_volatility_0t12' => 206,'top5_paid_volatility_0t6' => 207,'top5_spend_monthspastleast_24' => 208,'top5_spend_monthspastmost_24' => 209,'top5_spend_slope_0t12' => 210,'top5_spend_slope_0t24' => 211,'top5_spend_slope_0t6' => 212,'top5_spend_sum_12' => 213,'top5_spend_volatility_0t6' => 214,'top5_spend_volatility_6t12' => 215,'total_numrel_avg12' => 216,'total_numrel_monthpspastmost_24' => 217,'total_numrel_monthspastleast_24' => 218,'total_numrel_slope_0t12' => 219,'total_numrel_slope_0t24' => 220,'total_numrel_slope_0t6' => 221,'total_numrel_slope_6t12' => 222,'total_numrel_var_0t12' => 223,'total_numrel_var_0t24' => 224,'total_numrel_var_12t24' => 225,'total_numrel_var_6t18' => 226,'mfgmat_numrel_avg12' => 227,'mfgmat_numrel_slope_0t12' => 228,'mfgmat_numrel_slope_0t24' => 229,'mfgmat_numrel_slope_0t6' => 230,'mfgmat_numrel_slope_6t12' => 231,'mfgmat_numrel_var_0t12' => 232,'mfgmat_numrel_var_12t24' => 233,'ops_numrel_avg12' => 234,'ops_numrel_slope_0t12' => 235,'ops_numrel_slope_0t24' => 236,'ops_numrel_slope_0t6' => 237,'ops_numrel_slope_6t12' => 238,'ops_numrel_var_0t12' => 239,'ops_numrel_var_12t24' => 240,'fleet_numrel_avg12' => 241,'fleet_numrel_slope_0t12' => 242,'fleet_numrel_slope_0t24' => 243,'fleet_numrel_slope_0t6' => 244,'fleet_numrel_slope_6t12' => 245,'fleet_numrel_var_0t12' => 246,'fleet_numrel_var_12t24' => 247,'carrier_numrel_avg12' => 248,'carrier_numrel_slope_0t12' => 249,'carrier_numrel_slope_0t24' => 250,'carrier_numrel_slope_0t6' => 251,'carrier_numrel_slope_6t12' => 252,'carrier_numrel_var_0t12' => 253,'carrier_numrel_var_12t24' => 254,'bldgmats_numrel_avg12' => 255,'bldgmats_numrel_slope_0t12' => 256,'bldgmats_numrel_slope_0t24' => 257,'bldgmats_numrel_slope_0t6' => 258,'bldgmats_numrel_slope_6t12' => 259,'bldgmats_numrel_var_0t12' => 260,'bldgmats_numrel_var_12t24' => 261,'total_monthsoutstanding_slope24' => 262,'total_percprov30_avg_0t12' => 263,'total_percprov30_slope_0t12' => 264,'total_percprov30_slope_0t24' => 265,'total_percprov30_slope_0t6' => 266,'total_percprov30_slope_6t12' => 267,'total_percprov60_avg_0t12' => 268,'total_percprov60_slope_0t12' => 269,'total_percprov60_slope_0t24' => 270,'total_percprov60_slope_0t6' => 271,'total_percprov60_slope_6t12' => 272,'total_percprov90_avg_0t12' => 273,'total_percprov90_lowerlim_0t12' => 274,'total_percprov90_slope_0t24' => 275,'total_percprov90_slope_0t6' => 276,'total_percprov90_slope_6t12' => 277,'total_percprovoutstanding_adjustedslope_0t12' => 278,'mfgmat_monthsoutstanding_slope24' => 279,'mfgmat_percprov30_slope_0t12' => 280,'mfgmat_percprov30_slope_6t12' => 281,'mfgmat_percprov60_slope_0t12' => 282,'mfgmat_percprov60_slope_6t12' => 283,'mfgmat_percprov90_slope_0t24' => 284,'mfgmat_percprov90_slope_0t6' => 285,'mfgmat_percprov90_slope_6t12' => 286,'mfgmat_percprovoutstanding_adjustedslope_0t12' => 287,'ops_monthsoutstanding_slope24' => 288,'ops_percprov30_slope_0t12' => 289,'ops_percprov30_slope_6t12' => 290,'ops_percprov60_slope_0t12' => 291,'ops_percprov60_slope_6t12' => 292,'ops_percprov90_slope_0t24' => 293,'ops_percprov90_slope_0t6' => 294,'ops_percprov90_slope_6t12' => 295,'ops_percprovoutstanding_adjustedslope_0t12' => 296,'fleet_monthsoutstanding_slope24' => 297,'fleet_percprov30_slope_0t12' => 298,'fleet_percprov30_slope_6t12' => 299,'fleet_percprov60_slope_0t12' => 300,'fleet_percprov60_slope_6t12' => 301,'fleet_percprov90_slope_0t24' => 302,'fleet_percprov90_slope_0t6' => 303,'fleet_percprov90_slope_6t12' => 304,'fleet_percprovoutstanding_adjustedslope_0t12' => 305,'carrier_monthsoutstanding_slope24' => 306,'carrier_percprov30_slope_0t12' => 307,'carrier_percprov30_slope_6t12' => 308,'carrier_percprov60_slope_0t12' => 309,'carrier_percprov60_slope_6t12' => 310,'carrier_percprov90_slope_0t24' => 311,'carrier_percprov90_slope_0t6' => 312,'carrier_percprov90_slope_6t12' => 313,'carrier_percprovoutstanding_adjustedslope_0t12' => 314,'bldgmats_monthsoutstanding_slope24' => 315,'bldgmats_percprov30_slope_0t12' => 316,'bldgmats_percprov30_slope_6t12' => 317,'bldgmats_percprov60_slope_0t12' => 318,'bldgmats_percprov60_slope_6t12' => 319,'bldgmats_percprov90_slope_0t24' => 320,'bldgmats_percprov90_slope_0t6' => 321,'bldgmats_percprov90_slope_6t12' => 322,'bldgmats_percprovoutstanding_adjustedslope_0t12' => 323,'top5_monthsoutstanding_slope24' => 324,'top5_percprov30_slope_0t12' => 325,'top5_percprov30_slope_6t12' => 326,'top5_percprov60_slope_0t12' => 327,'top5_percprov60_slope_6t12' => 328,'top5_percprov90_slope_0t24' => 329,'top5_percprov90_slope_0t6' => 330,'top5_percprov90_slope_6t12' => 331,'top5_percprovoutstanding_adjustedslope_0t12' => 332,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],[],[],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],[],[],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],[],[],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_ultimate_linkid(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_ultimate_linkid(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_ultimate_linkid(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_cortera_score(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_cortera_score(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_cortera_score(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_cpr_score(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_cpr_score(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_cpr_score(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_cpr_segment(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_cpr_segment(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_cpr_segment(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_dbt(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_dbt(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_dbt(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_avg_bal(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_avg_bal(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_avg_bal(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_air_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_air_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_air_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_fuel_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_fuel_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_fuel_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_leasing_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_leasing_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_leasing_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_ltl_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_ltl_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_ltl_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_rail_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_rail_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_rail_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_tl_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_tl_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_tl_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_transvc_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_transvc_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_transvc_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_transup_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_transup_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_transup_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_bst_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_bst_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_bst_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_dg_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_dg_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_dg_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_electrical_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_electrical_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_electrical_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_hvac_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_hvac_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_hvac_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_other_b_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_other_b_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_other_b_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_plumbing_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_plumbing_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_plumbing_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_rs_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_rs_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_rs_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_wp_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_wp_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_wp_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_chemical_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_chemical_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_chemical_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_electronic_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_electronic_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_electronic_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_metal_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_metal_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_metal_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_other_m_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_other_m_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_other_m_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_packaging_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_packaging_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_packaging_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_pvf_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_pvf_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_pvf_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_plastic_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_plastic_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_plastic_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_textile_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_textile_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_textile_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_bs_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_bs_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_bs_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_ce_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_ce_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_ce_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_hardware_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_hardware_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_hardware_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_ie_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_ie_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_ie_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_is_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_is_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_is_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_it_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_it_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_it_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_mls_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_mls_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_mls_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_os_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_os_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_os_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_pp_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_pp_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_pp_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_sis_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_sis_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_sis_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_apparel_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_apparel_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_apparel_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_beverages_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_beverages_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_beverages_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_constr_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_constr_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_constr_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_consulting_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_consulting_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_consulting_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_fs_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_fs_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_fs_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_fp_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_fp_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_fp_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_insurance_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_insurance_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_insurance_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_ls_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_ls_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_ls_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_oil_gas_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_oil_gas_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_oil_gas_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_utilities_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_utilities_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_utilities_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_other_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_other_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_other_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_advt_spend(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_advt_spend(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_advt_spend(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_air_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_air_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_air_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_fuel_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_fuel_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_fuel_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_leasing_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_leasing_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_leasing_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_ltl_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_ltl_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_ltl_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_rail_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_rail_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_rail_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_tl_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_tl_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_tl_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_transvc_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_transvc_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_transvc_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_transup_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_transup_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_transup_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_bst_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_bst_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_bst_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_dg_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_dg_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_dg_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_electrical_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_electrical_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_electrical_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_hvac_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_hvac_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_hvac_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_other_b_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_other_b_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_other_b_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_plumbing_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_plumbing_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_plumbing_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_rs_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_rs_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_rs_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_wp_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_wp_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_wp_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_chemical_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_chemical_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_chemical_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_electronic_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_electronic_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_electronic_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_metal_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_metal_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_metal_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_other_m_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_other_m_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_other_m_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_packaging_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_packaging_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_packaging_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_pvf_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_pvf_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_pvf_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_plastic_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_plastic_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_plastic_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_textile_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_textile_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_textile_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_bs_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_bs_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_bs_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_ce_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_ce_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_ce_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_hardware_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_hardware_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_hardware_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_ie_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_ie_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_ie_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_is_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_is_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_is_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_it_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_it_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_it_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_mls_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_mls_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_mls_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_os_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_os_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_os_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_pp_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_pp_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_pp_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_sis_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_sis_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_sis_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_apparel_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_apparel_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_apparel_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_beverages_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_beverages_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_beverages_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_constr_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_constr_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_constr_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_consulting_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_consulting_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_consulting_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_fs_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_fs_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_fs_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_fp_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_fp_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_fp_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_insurance_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_insurance_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_insurance_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_ls_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_ls_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_ls_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_oil_gas_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_oil_gas_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_oil_gas_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_utilities_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_utilities_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_utilities_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_other_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_other_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_other_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_advt_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_advt_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_advt_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_top5_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_top5_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_top5_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_shipping_y1(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_shipping_y1(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_shipping_y1(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_shipping_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_shipping_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_shipping_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_materials_y1(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_materials_y1(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_materials_y1(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_materials_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_materials_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_materials_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_operations_y1(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_operations_y1(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_operations_y1(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_operations_growth(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_operations_growth(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_operations_growth(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_paid_average_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_paid_average_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_paid_average_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_paid_monthspastworst_24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_paid_monthspastworst_24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_paid_monthspastworst_24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_paid_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_paid_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_paid_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_paid_slope_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_paid_slope_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_paid_slope_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_paid_slope_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_paid_slope_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_paid_slope_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_paid_slope_6t18(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_paid_slope_6t18(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_paid_slope_6t18(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_paid_volatility_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_paid_volatility_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_paid_volatility_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_paid_volatility_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_paid_volatility_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_paid_volatility_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_paid_volatility_12t18(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_paid_volatility_12t18(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_paid_volatility_12t18(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_paid_volatility_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_paid_volatility_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_paid_volatility_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_spend_monthspastleast_24(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_total_spend_monthspastleast_24(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_total_spend_monthspastleast_24(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_total_spend_monthspastmost_24(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_total_spend_monthspastmost_24(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_total_spend_monthspastmost_24(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_total_spend_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_spend_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_spend_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_spend_slope_0t24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_spend_slope_0t24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_spend_slope_0t24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_spend_slope_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_spend_slope_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_spend_slope_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_spend_slope_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_spend_slope_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_spend_slope_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_spend_sum_12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_spend_sum_12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_spend_sum_12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_spend_volatility_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_spend_volatility_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_spend_volatility_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_spend_volatility_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_spend_volatility_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_spend_volatility_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_spend_volatility_12t18(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_spend_volatility_12t18(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_spend_volatility_12t18(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_spend_volatility_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_spend_volatility_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_spend_volatility_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_mfgmat_paid_average_12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_mfgmat_paid_average_12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_mfgmat_paid_average_12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_mfgmat_paid_monthspastworst_24(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_mfgmat_paid_monthspastworst_24(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_mfgmat_paid_monthspastworst_24(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_mfgmat_paid_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_mfgmat_paid_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_mfgmat_paid_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_mfgmat_paid_slope_0t24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_mfgmat_paid_slope_0t24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_mfgmat_paid_slope_0t24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_mfgmat_paid_slope_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_mfgmat_paid_slope_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_mfgmat_paid_slope_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_mfgmat_paid_volatility_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_mfgmat_paid_volatility_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_mfgmat_paid_volatility_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_mfgmat_paid_volatility_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_mfgmat_paid_volatility_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_mfgmat_paid_volatility_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_mfgmat_spend_monthspastleast_24(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_mfgmat_spend_monthspastleast_24(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_mfgmat_spend_monthspastleast_24(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_mfgmat_spend_monthspastmost_24(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_mfgmat_spend_monthspastmost_24(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_mfgmat_spend_monthspastmost_24(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_mfgmat_spend_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_mfgmat_spend_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_mfgmat_spend_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_mfgmat_spend_slope_0t24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_mfgmat_spend_slope_0t24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_mfgmat_spend_slope_0t24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_mfgmat_spend_slope_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_mfgmat_spend_slope_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_mfgmat_spend_slope_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_mfgmat_spend_sum_12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_mfgmat_spend_sum_12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_mfgmat_spend_sum_12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_mfgmat_spend_volatility_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_mfgmat_spend_volatility_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_mfgmat_spend_volatility_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_mfgmat_spend_volatility_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_mfgmat_spend_volatility_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_mfgmat_spend_volatility_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_ops_paid_average_12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_ops_paid_average_12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_ops_paid_average_12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_ops_paid_monthspastworst_24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_ops_paid_monthspastworst_24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_ops_paid_monthspastworst_24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_ops_paid_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_ops_paid_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_ops_paid_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_ops_paid_slope_0t24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_ops_paid_slope_0t24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_ops_paid_slope_0t24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_ops_paid_slope_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_ops_paid_slope_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_ops_paid_slope_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_ops_paid_volatility_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_ops_paid_volatility_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_ops_paid_volatility_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_ops_paid_volatility_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_ops_paid_volatility_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_ops_paid_volatility_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_ops_spend_monthspastleast_24(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_ops_spend_monthspastleast_24(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_ops_spend_monthspastleast_24(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_ops_spend_monthspastmost_24(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_ops_spend_monthspastmost_24(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_ops_spend_monthspastmost_24(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_ops_spend_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_ops_spend_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_ops_spend_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_ops_spend_slope_0t24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_ops_spend_slope_0t24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_ops_spend_slope_0t24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_ops_spend_slope_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_ops_spend_slope_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_ops_spend_slope_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_ops_spend_sum_12(SALT311.StrType s0) := s0;
EXPORT InValid_ops_spend_sum_12(SALT311.StrType s) := 0;
EXPORT InValidMessage_ops_spend_sum_12(UNSIGNED1 wh) := '';
 
EXPORT Make_ops_spend_volatility_0t6(SALT311.StrType s0) := s0;
EXPORT InValid_ops_spend_volatility_0t6(SALT311.StrType s) := 0;
EXPORT InValidMessage_ops_spend_volatility_0t6(UNSIGNED1 wh) := '';
 
EXPORT Make_ops_spend_volatility_6t12(SALT311.StrType s0) := s0;
EXPORT InValid_ops_spend_volatility_6t12(SALT311.StrType s) := 0;
EXPORT InValidMessage_ops_spend_volatility_6t12(UNSIGNED1 wh) := '';
 
EXPORT Make_fleet_paid_average_12(SALT311.StrType s0) := s0;
EXPORT InValid_fleet_paid_average_12(SALT311.StrType s) := 0;
EXPORT InValidMessage_fleet_paid_average_12(UNSIGNED1 wh) := '';
 
EXPORT Make_fleet_paid_monthspastworst_24(SALT311.StrType s0) := MakeFT_Number(s0);
EXPORT InValid_fleet_paid_monthspastworst_24(SALT311.StrType s) := InValidFT_Number(s);
EXPORT InValidMessage_fleet_paid_monthspastworst_24(UNSIGNED1 wh) := InValidMessageFT_Number(wh);
 
EXPORT Make_fleet_paid_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_fleet_paid_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_fleet_paid_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_fleet_paid_slope_0t24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_fleet_paid_slope_0t24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_fleet_paid_slope_0t24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_fleet_paid_slope_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_fleet_paid_slope_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_fleet_paid_slope_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_fleet_paid_volatility_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_fleet_paid_volatility_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_fleet_paid_volatility_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_fleet_paid_volatility_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_fleet_paid_volatility_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_fleet_paid_volatility_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_fleet_spend_monthspastleast_24(SALT311.StrType s0) := s0;
EXPORT InValid_fleet_spend_monthspastleast_24(SALT311.StrType s) := 0;
EXPORT InValidMessage_fleet_spend_monthspastleast_24(UNSIGNED1 wh) := '';
 
EXPORT Make_fleet_spend_monthspastmost_24(SALT311.StrType s0) := s0;
EXPORT InValid_fleet_spend_monthspastmost_24(SALT311.StrType s) := 0;
EXPORT InValidMessage_fleet_spend_monthspastmost_24(UNSIGNED1 wh) := '';
 
EXPORT Make_fleet_spend_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_fleet_spend_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_fleet_spend_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_fleet_spend_slope_0t24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_fleet_spend_slope_0t24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_fleet_spend_slope_0t24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_fleet_spend_slope_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_fleet_spend_slope_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_fleet_spend_slope_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_fleet_spend_sum_12(SALT311.StrType s0) := s0;
EXPORT InValid_fleet_spend_sum_12(SALT311.StrType s) := 0;
EXPORT InValidMessage_fleet_spend_sum_12(UNSIGNED1 wh) := '';
 
EXPORT Make_fleet_spend_volatility_0t6(SALT311.StrType s0) := s0;
EXPORT InValid_fleet_spend_volatility_0t6(SALT311.StrType s) := 0;
EXPORT InValidMessage_fleet_spend_volatility_0t6(UNSIGNED1 wh) := '';
 
EXPORT Make_fleet_spend_volatility_6t12(SALT311.StrType s0) := s0;
EXPORT InValid_fleet_spend_volatility_6t12(SALT311.StrType s) := 0;
EXPORT InValidMessage_fleet_spend_volatility_6t12(UNSIGNED1 wh) := '';
 
EXPORT Make_carrier_paid_average_12(SALT311.StrType s0) := s0;
EXPORT InValid_carrier_paid_average_12(SALT311.StrType s) := 0;
EXPORT InValidMessage_carrier_paid_average_12(UNSIGNED1 wh) := '';
 
EXPORT Make_carrier_paid_monthspastworst_24(SALT311.StrType s0) := s0;
EXPORT InValid_carrier_paid_monthspastworst_24(SALT311.StrType s) := 0;
EXPORT InValidMessage_carrier_paid_monthspastworst_24(UNSIGNED1 wh) := '';
 
EXPORT Make_carrier_paid_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_carrier_paid_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_carrier_paid_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_carrier_paid_slope_0t24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_carrier_paid_slope_0t24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_carrier_paid_slope_0t24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_carrier_paid_slope_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_carrier_paid_slope_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_carrier_paid_slope_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_carrier_paid_volatility_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_carrier_paid_volatility_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_carrier_paid_volatility_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_carrier_paid_volatility_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_carrier_paid_volatility_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_carrier_paid_volatility_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_carrier_spend_monthspastleast_24(SALT311.StrType s0) := s0;
EXPORT InValid_carrier_spend_monthspastleast_24(SALT311.StrType s) := 0;
EXPORT InValidMessage_carrier_spend_monthspastleast_24(UNSIGNED1 wh) := '';
 
EXPORT Make_carrier_spend_monthspastmost_24(SALT311.StrType s0) := s0;
EXPORT InValid_carrier_spend_monthspastmost_24(SALT311.StrType s) := 0;
EXPORT InValidMessage_carrier_spend_monthspastmost_24(UNSIGNED1 wh) := '';
 
EXPORT Make_carrier_spend_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_carrier_spend_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_carrier_spend_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_carrier_spend_slope_0t24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_carrier_spend_slope_0t24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_carrier_spend_slope_0t24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_carrier_spend_slope_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_carrier_spend_slope_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_carrier_spend_slope_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_carrier_spend_sum_12(SALT311.StrType s0) := s0;
EXPORT InValid_carrier_spend_sum_12(SALT311.StrType s) := 0;
EXPORT InValidMessage_carrier_spend_sum_12(UNSIGNED1 wh) := '';
 
EXPORT Make_carrier_spend_volatility_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_carrier_spend_volatility_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_carrier_spend_volatility_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_carrier_spend_volatility_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_carrier_spend_volatility_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_carrier_spend_volatility_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_bldgmats_paid_average_12(SALT311.StrType s0) := s0;
EXPORT InValid_bldgmats_paid_average_12(SALT311.StrType s) := 0;
EXPORT InValidMessage_bldgmats_paid_average_12(UNSIGNED1 wh) := '';
 
EXPORT Make_bldgmats_paid_monthspastworst_24(SALT311.StrType s0) := s0;
EXPORT InValid_bldgmats_paid_monthspastworst_24(SALT311.StrType s) := 0;
EXPORT InValidMessage_bldgmats_paid_monthspastworst_24(UNSIGNED1 wh) := '';
 
EXPORT Make_bldgmats_paid_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_bldgmats_paid_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_bldgmats_paid_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_bldgmats_paid_slope_0t24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_bldgmats_paid_slope_0t24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_bldgmats_paid_slope_0t24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_bldgmats_paid_slope_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_bldgmats_paid_slope_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_bldgmats_paid_slope_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_bldgmats_paid_volatility_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_bldgmats_paid_volatility_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_bldgmats_paid_volatility_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_bldgmats_paid_volatility_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_bldgmats_paid_volatility_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_bldgmats_paid_volatility_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_bldgmats_spend_monthspastleast_24(SALT311.StrType s0) := s0;
EXPORT InValid_bldgmats_spend_monthspastleast_24(SALT311.StrType s) := 0;
EXPORT InValidMessage_bldgmats_spend_monthspastleast_24(UNSIGNED1 wh) := '';
 
EXPORT Make_bldgmats_spend_monthspastmost_24(SALT311.StrType s0) := s0;
EXPORT InValid_bldgmats_spend_monthspastmost_24(SALT311.StrType s) := 0;
EXPORT InValidMessage_bldgmats_spend_monthspastmost_24(UNSIGNED1 wh) := '';
 
EXPORT Make_bldgmats_spend_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_bldgmats_spend_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_bldgmats_spend_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_bldgmats_spend_slope_0t24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_bldgmats_spend_slope_0t24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_bldgmats_spend_slope_0t24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_bldgmats_spend_slope_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_bldgmats_spend_slope_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_bldgmats_spend_slope_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_bldgmats_spend_sum_12(SALT311.StrType s0) := s0;
EXPORT InValid_bldgmats_spend_sum_12(SALT311.StrType s) := 0;
EXPORT InValidMessage_bldgmats_spend_sum_12(UNSIGNED1 wh) := '';
 
EXPORT Make_bldgmats_spend_volatility_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_bldgmats_spend_volatility_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_bldgmats_spend_volatility_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_bldgmats_spend_volatility_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_bldgmats_spend_volatility_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_bldgmats_spend_volatility_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_top5_paid_average_12(SALT311.StrType s0) := s0;
EXPORT InValid_top5_paid_average_12(SALT311.StrType s) := 0;
EXPORT InValidMessage_top5_paid_average_12(UNSIGNED1 wh) := '';
 
EXPORT Make_top5_paid_monthspastworst_24(SALT311.StrType s0) := s0;
EXPORT InValid_top5_paid_monthspastworst_24(SALT311.StrType s) := 0;
EXPORT InValidMessage_top5_paid_monthspastworst_24(UNSIGNED1 wh) := '';
 
EXPORT Make_top5_paid_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_top5_paid_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_top5_paid_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_top5_paid_slope_0t24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_top5_paid_slope_0t24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_top5_paid_slope_0t24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_top5_paid_slope_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_top5_paid_slope_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_top5_paid_slope_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_top5_paid_volatility_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_top5_paid_volatility_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_top5_paid_volatility_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_top5_paid_volatility_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_top5_paid_volatility_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_top5_paid_volatility_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_top5_spend_monthspastleast_24(SALT311.StrType s0) := s0;
EXPORT InValid_top5_spend_monthspastleast_24(SALT311.StrType s) := 0;
EXPORT InValidMessage_top5_spend_monthspastleast_24(UNSIGNED1 wh) := '';
 
EXPORT Make_top5_spend_monthspastmost_24(SALT311.StrType s0) := s0;
EXPORT InValid_top5_spend_monthspastmost_24(SALT311.StrType s) := 0;
EXPORT InValidMessage_top5_spend_monthspastmost_24(UNSIGNED1 wh) := '';
 
EXPORT Make_top5_spend_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_top5_spend_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_top5_spend_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_top5_spend_slope_0t24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_top5_spend_slope_0t24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_top5_spend_slope_0t24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_top5_spend_slope_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_top5_spend_slope_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_top5_spend_slope_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_top5_spend_sum_12(SALT311.StrType s0) := s0;
EXPORT InValid_top5_spend_sum_12(SALT311.StrType s) := 0;
EXPORT InValidMessage_top5_spend_sum_12(UNSIGNED1 wh) := '';
 
EXPORT Make_top5_spend_volatility_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_top5_spend_volatility_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_top5_spend_volatility_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_top5_spend_volatility_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_top5_spend_volatility_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_top5_spend_volatility_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_numrel_avg12(SALT311.StrType s0) := s0;
EXPORT InValid_total_numrel_avg12(SALT311.StrType s) := 0;
EXPORT InValidMessage_total_numrel_avg12(UNSIGNED1 wh) := '';
 
EXPORT Make_total_numrel_monthpspastmost_24(SALT311.StrType s0) := s0;
EXPORT InValid_total_numrel_monthpspastmost_24(SALT311.StrType s) := 0;
EXPORT InValidMessage_total_numrel_monthpspastmost_24(UNSIGNED1 wh) := '';
 
EXPORT Make_total_numrel_monthspastleast_24(SALT311.StrType s0) := s0;
EXPORT InValid_total_numrel_monthspastleast_24(SALT311.StrType s) := 0;
EXPORT InValidMessage_total_numrel_monthspastleast_24(UNSIGNED1 wh) := '';
 
EXPORT Make_total_numrel_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_numrel_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_numrel_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_numrel_slope_0t24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_numrel_slope_0t24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_numrel_slope_0t24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_numrel_slope_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_numrel_slope_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_numrel_slope_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_numrel_slope_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_numrel_slope_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_numrel_slope_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_numrel_var_0t12(SALT311.StrType s0) := s0;
EXPORT InValid_total_numrel_var_0t12(SALT311.StrType s) := 0;
EXPORT InValidMessage_total_numrel_var_0t12(UNSIGNED1 wh) := '';
 
EXPORT Make_total_numrel_var_0t24(SALT311.StrType s0) := s0;
EXPORT InValid_total_numrel_var_0t24(SALT311.StrType s) := 0;
EXPORT InValidMessage_total_numrel_var_0t24(UNSIGNED1 wh) := '';
 
EXPORT Make_total_numrel_var_12t24(SALT311.StrType s0) := s0;
EXPORT InValid_total_numrel_var_12t24(SALT311.StrType s) := 0;
EXPORT InValidMessage_total_numrel_var_12t24(UNSIGNED1 wh) := '';
 
EXPORT Make_total_numrel_var_6t18(SALT311.StrType s0) := s0;
EXPORT InValid_total_numrel_var_6t18(SALT311.StrType s) := 0;
EXPORT InValidMessage_total_numrel_var_6t18(UNSIGNED1 wh) := '';
 
EXPORT Make_mfgmat_numrel_avg12(SALT311.StrType s0) := s0;
EXPORT InValid_mfgmat_numrel_avg12(SALT311.StrType s) := 0;
EXPORT InValidMessage_mfgmat_numrel_avg12(UNSIGNED1 wh) := '';
 
EXPORT Make_mfgmat_numrel_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_mfgmat_numrel_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_mfgmat_numrel_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_mfgmat_numrel_slope_0t24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_mfgmat_numrel_slope_0t24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_mfgmat_numrel_slope_0t24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_mfgmat_numrel_slope_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_mfgmat_numrel_slope_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_mfgmat_numrel_slope_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_mfgmat_numrel_slope_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_mfgmat_numrel_slope_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_mfgmat_numrel_slope_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_mfgmat_numrel_var_0t12(SALT311.StrType s0) := s0;
EXPORT InValid_mfgmat_numrel_var_0t12(SALT311.StrType s) := 0;
EXPORT InValidMessage_mfgmat_numrel_var_0t12(UNSIGNED1 wh) := '';
 
EXPORT Make_mfgmat_numrel_var_12t24(SALT311.StrType s0) := s0;
EXPORT InValid_mfgmat_numrel_var_12t24(SALT311.StrType s) := 0;
EXPORT InValidMessage_mfgmat_numrel_var_12t24(UNSIGNED1 wh) := '';
 
EXPORT Make_ops_numrel_avg12(SALT311.StrType s0) := s0;
EXPORT InValid_ops_numrel_avg12(SALT311.StrType s) := 0;
EXPORT InValidMessage_ops_numrel_avg12(UNSIGNED1 wh) := '';
 
EXPORT Make_ops_numrel_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_ops_numrel_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_ops_numrel_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_ops_numrel_slope_0t24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_ops_numrel_slope_0t24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_ops_numrel_slope_0t24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_ops_numrel_slope_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_ops_numrel_slope_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_ops_numrel_slope_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_ops_numrel_slope_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_ops_numrel_slope_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_ops_numrel_slope_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_ops_numrel_var_0t12(SALT311.StrType s0) := s0;
EXPORT InValid_ops_numrel_var_0t12(SALT311.StrType s) := 0;
EXPORT InValidMessage_ops_numrel_var_0t12(UNSIGNED1 wh) := '';
 
EXPORT Make_ops_numrel_var_12t24(SALT311.StrType s0) := s0;
EXPORT InValid_ops_numrel_var_12t24(SALT311.StrType s) := 0;
EXPORT InValidMessage_ops_numrel_var_12t24(UNSIGNED1 wh) := '';
 
EXPORT Make_fleet_numrel_avg12(SALT311.StrType s0) := s0;
EXPORT InValid_fleet_numrel_avg12(SALT311.StrType s) := 0;
EXPORT InValidMessage_fleet_numrel_avg12(UNSIGNED1 wh) := '';
 
EXPORT Make_fleet_numrel_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_fleet_numrel_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_fleet_numrel_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_fleet_numrel_slope_0t24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_fleet_numrel_slope_0t24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_fleet_numrel_slope_0t24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_fleet_numrel_slope_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_fleet_numrel_slope_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_fleet_numrel_slope_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_fleet_numrel_slope_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_fleet_numrel_slope_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_fleet_numrel_slope_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_fleet_numrel_var_0t12(SALT311.StrType s0) := s0;
EXPORT InValid_fleet_numrel_var_0t12(SALT311.StrType s) := 0;
EXPORT InValidMessage_fleet_numrel_var_0t12(UNSIGNED1 wh) := '';
 
EXPORT Make_fleet_numrel_var_12t24(SALT311.StrType s0) := s0;
EXPORT InValid_fleet_numrel_var_12t24(SALT311.StrType s) := 0;
EXPORT InValidMessage_fleet_numrel_var_12t24(UNSIGNED1 wh) := '';
 
EXPORT Make_carrier_numrel_avg12(SALT311.StrType s0) := s0;
EXPORT InValid_carrier_numrel_avg12(SALT311.StrType s) := 0;
EXPORT InValidMessage_carrier_numrel_avg12(UNSIGNED1 wh) := '';
 
EXPORT Make_carrier_numrel_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_carrier_numrel_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_carrier_numrel_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_carrier_numrel_slope_0t24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_carrier_numrel_slope_0t24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_carrier_numrel_slope_0t24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_carrier_numrel_slope_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_carrier_numrel_slope_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_carrier_numrel_slope_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_carrier_numrel_slope_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_carrier_numrel_slope_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_carrier_numrel_slope_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_carrier_numrel_var_0t12(SALT311.StrType s0) := s0;
EXPORT InValid_carrier_numrel_var_0t12(SALT311.StrType s) := 0;
EXPORT InValidMessage_carrier_numrel_var_0t12(UNSIGNED1 wh) := '';
 
EXPORT Make_carrier_numrel_var_12t24(SALT311.StrType s0) := s0;
EXPORT InValid_carrier_numrel_var_12t24(SALT311.StrType s) := 0;
EXPORT InValidMessage_carrier_numrel_var_12t24(UNSIGNED1 wh) := '';
 
EXPORT Make_bldgmats_numrel_avg12(SALT311.StrType s0) := s0;
EXPORT InValid_bldgmats_numrel_avg12(SALT311.StrType s) := 0;
EXPORT InValidMessage_bldgmats_numrel_avg12(UNSIGNED1 wh) := '';
 
EXPORT Make_bldgmats_numrel_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_bldgmats_numrel_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_bldgmats_numrel_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_bldgmats_numrel_slope_0t24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_bldgmats_numrel_slope_0t24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_bldgmats_numrel_slope_0t24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_bldgmats_numrel_slope_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_bldgmats_numrel_slope_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_bldgmats_numrel_slope_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_bldgmats_numrel_slope_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_bldgmats_numrel_slope_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_bldgmats_numrel_slope_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_bldgmats_numrel_var_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_bldgmats_numrel_var_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_bldgmats_numrel_var_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_bldgmats_numrel_var_12t24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_bldgmats_numrel_var_12t24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_bldgmats_numrel_var_12t24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_monthsoutstanding_slope24(SALT311.StrType s0) := s0;
EXPORT InValid_total_monthsoutstanding_slope24(SALT311.StrType s) := 0;
EXPORT InValidMessage_total_monthsoutstanding_slope24(UNSIGNED1 wh) := '';
 
EXPORT Make_total_percprov30_avg_0t12(SALT311.StrType s0) := s0;
EXPORT InValid_total_percprov30_avg_0t12(SALT311.StrType s) := 0;
EXPORT InValidMessage_total_percprov30_avg_0t12(UNSIGNED1 wh) := '';
 
EXPORT Make_total_percprov30_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_percprov30_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_percprov30_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_percprov30_slope_0t24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_percprov30_slope_0t24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_percprov30_slope_0t24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_percprov30_slope_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_percprov30_slope_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_percprov30_slope_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_percprov30_slope_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_percprov30_slope_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_percprov30_slope_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_percprov60_avg_0t12(SALT311.StrType s0) := s0;
EXPORT InValid_total_percprov60_avg_0t12(SALT311.StrType s) := 0;
EXPORT InValidMessage_total_percprov60_avg_0t12(UNSIGNED1 wh) := '';
 
EXPORT Make_total_percprov60_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_percprov60_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_percprov60_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_percprov60_slope_0t24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_percprov60_slope_0t24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_percprov60_slope_0t24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_percprov60_slope_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_percprov60_slope_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_percprov60_slope_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_percprov60_slope_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_percprov60_slope_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_percprov60_slope_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_percprov90_avg_0t12(SALT311.StrType s0) := s0;
EXPORT InValid_total_percprov90_avg_0t12(SALT311.StrType s) := 0;
EXPORT InValidMessage_total_percprov90_avg_0t12(UNSIGNED1 wh) := '';
 
EXPORT Make_total_percprov90_lowerlim_0t12(SALT311.StrType s0) := s0;
EXPORT InValid_total_percprov90_lowerlim_0t12(SALT311.StrType s) := 0;
EXPORT InValidMessage_total_percprov90_lowerlim_0t12(UNSIGNED1 wh) := '';
 
EXPORT Make_total_percprov90_slope_0t24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_percprov90_slope_0t24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_percprov90_slope_0t24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_percprov90_slope_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_percprov90_slope_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_percprov90_slope_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_percprov90_slope_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_total_percprov90_slope_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_total_percprov90_slope_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_total_percprovoutstanding_adjustedslope_0t12(SALT311.StrType s0) := s0;
EXPORT InValid_total_percprovoutstanding_adjustedslope_0t12(SALT311.StrType s) := 0;
EXPORT InValidMessage_total_percprovoutstanding_adjustedslope_0t12(UNSIGNED1 wh) := '';
 
EXPORT Make_mfgmat_monthsoutstanding_slope24(SALT311.StrType s0) := s0;
EXPORT InValid_mfgmat_monthsoutstanding_slope24(SALT311.StrType s) := 0;
EXPORT InValidMessage_mfgmat_monthsoutstanding_slope24(UNSIGNED1 wh) := '';
 
EXPORT Make_mfgmat_percprov30_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_mfgmat_percprov30_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_mfgmat_percprov30_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_mfgmat_percprov30_slope_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_mfgmat_percprov30_slope_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_mfgmat_percprov30_slope_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_mfgmat_percprov60_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_mfgmat_percprov60_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_mfgmat_percprov60_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_mfgmat_percprov60_slope_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_mfgmat_percprov60_slope_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_mfgmat_percprov60_slope_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_mfgmat_percprov90_slope_0t24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_mfgmat_percprov90_slope_0t24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_mfgmat_percprov90_slope_0t24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_mfgmat_percprov90_slope_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_mfgmat_percprov90_slope_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_mfgmat_percprov90_slope_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_mfgmat_percprov90_slope_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_mfgmat_percprov90_slope_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_mfgmat_percprov90_slope_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_mfgmat_percprovoutstanding_adjustedslope_0t12(SALT311.StrType s0) := s0;
EXPORT InValid_mfgmat_percprovoutstanding_adjustedslope_0t12(SALT311.StrType s) := 0;
EXPORT InValidMessage_mfgmat_percprovoutstanding_adjustedslope_0t12(UNSIGNED1 wh) := '';
 
EXPORT Make_ops_monthsoutstanding_slope24(SALT311.StrType s0) := s0;
EXPORT InValid_ops_monthsoutstanding_slope24(SALT311.StrType s) := 0;
EXPORT InValidMessage_ops_monthsoutstanding_slope24(UNSIGNED1 wh) := '';
 
EXPORT Make_ops_percprov30_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_ops_percprov30_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_ops_percprov30_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_ops_percprov30_slope_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_ops_percprov30_slope_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_ops_percprov30_slope_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_ops_percprov60_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_ops_percprov60_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_ops_percprov60_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_ops_percprov60_slope_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_ops_percprov60_slope_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_ops_percprov60_slope_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_ops_percprov90_slope_0t24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_ops_percprov90_slope_0t24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_ops_percprov90_slope_0t24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_ops_percprov90_slope_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_ops_percprov90_slope_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_ops_percprov90_slope_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_ops_percprov90_slope_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_ops_percprov90_slope_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_ops_percprov90_slope_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_ops_percprovoutstanding_adjustedslope_0t12(SALT311.StrType s0) := s0;
EXPORT InValid_ops_percprovoutstanding_adjustedslope_0t12(SALT311.StrType s) := 0;
EXPORT InValidMessage_ops_percprovoutstanding_adjustedslope_0t12(UNSIGNED1 wh) := '';
 
EXPORT Make_fleet_monthsoutstanding_slope24(SALT311.StrType s0) := s0;
EXPORT InValid_fleet_monthsoutstanding_slope24(SALT311.StrType s) := 0;
EXPORT InValidMessage_fleet_monthsoutstanding_slope24(UNSIGNED1 wh) := '';
 
EXPORT Make_fleet_percprov30_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_fleet_percprov30_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_fleet_percprov30_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_fleet_percprov30_slope_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_fleet_percprov30_slope_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_fleet_percprov30_slope_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_fleet_percprov60_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_fleet_percprov60_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_fleet_percprov60_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_fleet_percprov60_slope_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_fleet_percprov60_slope_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_fleet_percprov60_slope_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_fleet_percprov90_slope_0t24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_fleet_percprov90_slope_0t24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_fleet_percprov90_slope_0t24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_fleet_percprov90_slope_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_fleet_percprov90_slope_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_fleet_percprov90_slope_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_fleet_percprov90_slope_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_fleet_percprov90_slope_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_fleet_percprov90_slope_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_fleet_percprovoutstanding_adjustedslope_0t12(SALT311.StrType s0) := s0;
EXPORT InValid_fleet_percprovoutstanding_adjustedslope_0t12(SALT311.StrType s) := 0;
EXPORT InValidMessage_fleet_percprovoutstanding_adjustedslope_0t12(UNSIGNED1 wh) := '';
 
EXPORT Make_carrier_monthsoutstanding_slope24(SALT311.StrType s0) := s0;
EXPORT InValid_carrier_monthsoutstanding_slope24(SALT311.StrType s) := 0;
EXPORT InValidMessage_carrier_monthsoutstanding_slope24(UNSIGNED1 wh) := '';
 
EXPORT Make_carrier_percprov30_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_carrier_percprov30_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_carrier_percprov30_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_carrier_percprov30_slope_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_carrier_percprov30_slope_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_carrier_percprov30_slope_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_carrier_percprov60_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_carrier_percprov60_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_carrier_percprov60_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_carrier_percprov60_slope_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_carrier_percprov60_slope_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_carrier_percprov60_slope_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_carrier_percprov90_slope_0t24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_carrier_percprov90_slope_0t24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_carrier_percprov90_slope_0t24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_carrier_percprov90_slope_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_carrier_percprov90_slope_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_carrier_percprov90_slope_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_carrier_percprov90_slope_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_carrier_percprov90_slope_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_carrier_percprov90_slope_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_carrier_percprovoutstanding_adjustedslope_0t12(SALT311.StrType s0) := s0;
EXPORT InValid_carrier_percprovoutstanding_adjustedslope_0t12(SALT311.StrType s) := 0;
EXPORT InValidMessage_carrier_percprovoutstanding_adjustedslope_0t12(UNSIGNED1 wh) := '';
 
EXPORT Make_bldgmats_monthsoutstanding_slope24(SALT311.StrType s0) := s0;
EXPORT InValid_bldgmats_monthsoutstanding_slope24(SALT311.StrType s) := 0;
EXPORT InValidMessage_bldgmats_monthsoutstanding_slope24(UNSIGNED1 wh) := '';
 
EXPORT Make_bldgmats_percprov30_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_bldgmats_percprov30_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_bldgmats_percprov30_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_bldgmats_percprov30_slope_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_bldgmats_percprov30_slope_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_bldgmats_percprov30_slope_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_bldgmats_percprov60_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_bldgmats_percprov60_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_bldgmats_percprov60_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_bldgmats_percprov60_slope_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_bldgmats_percprov60_slope_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_bldgmats_percprov60_slope_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_bldgmats_percprov90_slope_0t24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_bldgmats_percprov90_slope_0t24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_bldgmats_percprov90_slope_0t24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_bldgmats_percprov90_slope_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_bldgmats_percprov90_slope_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_bldgmats_percprov90_slope_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_bldgmats_percprov90_slope_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_bldgmats_percprov90_slope_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_bldgmats_percprov90_slope_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_bldgmats_percprovoutstanding_adjustedslope_0t12(SALT311.StrType s0) := s0;
EXPORT InValid_bldgmats_percprovoutstanding_adjustedslope_0t12(SALT311.StrType s) := 0;
EXPORT InValidMessage_bldgmats_percprovoutstanding_adjustedslope_0t12(UNSIGNED1 wh) := '';
 
EXPORT Make_top5_monthsoutstanding_slope24(SALT311.StrType s0) := s0;
EXPORT InValid_top5_monthsoutstanding_slope24(SALT311.StrType s) := 0;
EXPORT InValidMessage_top5_monthsoutstanding_slope24(UNSIGNED1 wh) := '';
 
EXPORT Make_top5_percprov30_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_top5_percprov30_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_top5_percprov30_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_top5_percprov30_slope_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_top5_percprov30_slope_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_top5_percprov30_slope_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_top5_percprov60_slope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_top5_percprov60_slope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_top5_percprov60_slope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_top5_percprov60_slope_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_top5_percprov60_slope_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_top5_percprov60_slope_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_top5_percprov90_slope_0t24(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_top5_percprov90_slope_0t24(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_top5_percprov90_slope_0t24(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_top5_percprov90_slope_0t6(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_top5_percprov90_slope_0t6(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_top5_percprov90_slope_0t6(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_top5_percprov90_slope_6t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_top5_percprov90_slope_6t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_top5_percprov90_slope_6t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
EXPORT Make_top5_percprovoutstanding_adjustedslope_0t12(SALT311.StrType s0) := MakeFT_Ratio(s0);
EXPORT InValid_top5_percprovoutstanding_adjustedslope_0t12(SALT311.StrType s) := InValidFT_Ratio(s);
EXPORT InValidMessage_top5_percprovoutstanding_adjustedslope_0t12(UNSIGNED1 wh) := InValidMessageFT_Ratio(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Cortera;
//Find those highly occuring pivot values to remove them from consideration
#uniquename(tr)
  %tr% := table(in_left+in_right,{ val := pivot_exp; });
#uniquename(r1)
  %r1% := record
    %tr%.val;    unsigned Cnt := COUNT(GROUP);
  end;
#uniquename(t1)
  %t1% := table(%tr%,%r1%,val,local); // Pre-aggregate before distribute
#uniquename(r2)
  %r2% := record
    %t1%.val;    unsigned Cnt := SUM(GROUP,%t1%.Cnt);
  end;
#uniquename(t2)
  %t2% := table(%t1%,%r2%,val); // Now do global aggregate
Bad_Pivots := %t2%(Cnt>100);
#uniquename(dl)
  %dl% := RECORD
    BOOLEAN Diff_ultimate_linkid;
    BOOLEAN Diff_cortera_score;
    BOOLEAN Diff_cpr_score;
    BOOLEAN Diff_cpr_segment;
    BOOLEAN Diff_dbt;
    BOOLEAN Diff_avg_bal;
    BOOLEAN Diff_air_spend;
    BOOLEAN Diff_fuel_spend;
    BOOLEAN Diff_leasing_spend;
    BOOLEAN Diff_ltl_spend;
    BOOLEAN Diff_rail_spend;
    BOOLEAN Diff_tl_spend;
    BOOLEAN Diff_transvc_spend;
    BOOLEAN Diff_transup_spend;
    BOOLEAN Diff_bst_spend;
    BOOLEAN Diff_dg_spend;
    BOOLEAN Diff_electrical_spend;
    BOOLEAN Diff_hvac_spend;
    BOOLEAN Diff_other_b_spend;
    BOOLEAN Diff_plumbing_spend;
    BOOLEAN Diff_rs_spend;
    BOOLEAN Diff_wp_spend;
    BOOLEAN Diff_chemical_spend;
    BOOLEAN Diff_electronic_spend;
    BOOLEAN Diff_metal_spend;
    BOOLEAN Diff_other_m_spend;
    BOOLEAN Diff_packaging_spend;
    BOOLEAN Diff_pvf_spend;
    BOOLEAN Diff_plastic_spend;
    BOOLEAN Diff_textile_spend;
    BOOLEAN Diff_bs_spend;
    BOOLEAN Diff_ce_spend;
    BOOLEAN Diff_hardware_spend;
    BOOLEAN Diff_ie_spend;
    BOOLEAN Diff_is_spend;
    BOOLEAN Diff_it_spend;
    BOOLEAN Diff_mls_spend;
    BOOLEAN Diff_os_spend;
    BOOLEAN Diff_pp_spend;
    BOOLEAN Diff_sis_spend;
    BOOLEAN Diff_apparel_spend;
    BOOLEAN Diff_beverages_spend;
    BOOLEAN Diff_constr_spend;
    BOOLEAN Diff_consulting_spend;
    BOOLEAN Diff_fs_spend;
    BOOLEAN Diff_fp_spend;
    BOOLEAN Diff_insurance_spend;
    BOOLEAN Diff_ls_spend;
    BOOLEAN Diff_oil_gas_spend;
    BOOLEAN Diff_utilities_spend;
    BOOLEAN Diff_other_spend;
    BOOLEAN Diff_advt_spend;
    BOOLEAN Diff_air_growth;
    BOOLEAN Diff_fuel_growth;
    BOOLEAN Diff_leasing_growth;
    BOOLEAN Diff_ltl_growth;
    BOOLEAN Diff_rail_growth;
    BOOLEAN Diff_tl_growth;
    BOOLEAN Diff_transvc_growth;
    BOOLEAN Diff_transup_growth;
    BOOLEAN Diff_bst_growth;
    BOOLEAN Diff_dg_growth;
    BOOLEAN Diff_electrical_growth;
    BOOLEAN Diff_hvac_growth;
    BOOLEAN Diff_other_b_growth;
    BOOLEAN Diff_plumbing_growth;
    BOOLEAN Diff_rs_growth;
    BOOLEAN Diff_wp_growth;
    BOOLEAN Diff_chemical_growth;
    BOOLEAN Diff_electronic_growth;
    BOOLEAN Diff_metal_growth;
    BOOLEAN Diff_other_m_growth;
    BOOLEAN Diff_packaging_growth;
    BOOLEAN Diff_pvf_growth;
    BOOLEAN Diff_plastic_growth;
    BOOLEAN Diff_textile_growth;
    BOOLEAN Diff_bs_growth;
    BOOLEAN Diff_ce_growth;
    BOOLEAN Diff_hardware_growth;
    BOOLEAN Diff_ie_growth;
    BOOLEAN Diff_is_growth;
    BOOLEAN Diff_it_growth;
    BOOLEAN Diff_mls_growth;
    BOOLEAN Diff_os_growth;
    BOOLEAN Diff_pp_growth;
    BOOLEAN Diff_sis_growth;
    BOOLEAN Diff_apparel_growth;
    BOOLEAN Diff_beverages_growth;
    BOOLEAN Diff_constr_growth;
    BOOLEAN Diff_consulting_growth;
    BOOLEAN Diff_fs_growth;
    BOOLEAN Diff_fp_growth;
    BOOLEAN Diff_insurance_growth;
    BOOLEAN Diff_ls_growth;
    BOOLEAN Diff_oil_gas_growth;
    BOOLEAN Diff_utilities_growth;
    BOOLEAN Diff_other_growth;
    BOOLEAN Diff_advt_growth;
    BOOLEAN Diff_top5_growth;
    BOOLEAN Diff_shipping_y1;
    BOOLEAN Diff_shipping_growth;
    BOOLEAN Diff_materials_y1;
    BOOLEAN Diff_materials_growth;
    BOOLEAN Diff_operations_y1;
    BOOLEAN Diff_operations_growth;
    BOOLEAN Diff_total_paid_average_0t12;
    BOOLEAN Diff_total_paid_monthspastworst_24;
    BOOLEAN Diff_total_paid_slope_0t12;
    BOOLEAN Diff_total_paid_slope_0t6;
    BOOLEAN Diff_total_paid_slope_6t12;
    BOOLEAN Diff_total_paid_slope_6t18;
    BOOLEAN Diff_total_paid_volatility_0t12;
    BOOLEAN Diff_total_paid_volatility_0t6;
    BOOLEAN Diff_total_paid_volatility_12t18;
    BOOLEAN Diff_total_paid_volatility_6t12;
    BOOLEAN Diff_total_spend_monthspastleast_24;
    BOOLEAN Diff_total_spend_monthspastmost_24;
    BOOLEAN Diff_total_spend_slope_0t12;
    BOOLEAN Diff_total_spend_slope_0t24;
    BOOLEAN Diff_total_spend_slope_0t6;
    BOOLEAN Diff_total_spend_slope_6t12;
    BOOLEAN Diff_total_spend_sum_12;
    BOOLEAN Diff_total_spend_volatility_0t12;
    BOOLEAN Diff_total_spend_volatility_0t6;
    BOOLEAN Diff_total_spend_volatility_12t18;
    BOOLEAN Diff_total_spend_volatility_6t12;
    BOOLEAN Diff_mfgmat_paid_average_12;
    BOOLEAN Diff_mfgmat_paid_monthspastworst_24;
    BOOLEAN Diff_mfgmat_paid_slope_0t12;
    BOOLEAN Diff_mfgmat_paid_slope_0t24;
    BOOLEAN Diff_mfgmat_paid_slope_0t6;
    BOOLEAN Diff_mfgmat_paid_volatility_0t12;
    BOOLEAN Diff_mfgmat_paid_volatility_0t6;
    BOOLEAN Diff_mfgmat_spend_monthspastleast_24;
    BOOLEAN Diff_mfgmat_spend_monthspastmost_24;
    BOOLEAN Diff_mfgmat_spend_slope_0t12;
    BOOLEAN Diff_mfgmat_spend_slope_0t24;
    BOOLEAN Diff_mfgmat_spend_slope_0t6;
    BOOLEAN Diff_mfgmat_spend_sum_12;
    BOOLEAN Diff_mfgmat_spend_volatility_0t6;
    BOOLEAN Diff_mfgmat_spend_volatility_6t12;
    BOOLEAN Diff_ops_paid_average_12;
    BOOLEAN Diff_ops_paid_monthspastworst_24;
    BOOLEAN Diff_ops_paid_slope_0t12;
    BOOLEAN Diff_ops_paid_slope_0t24;
    BOOLEAN Diff_ops_paid_slope_0t6;
    BOOLEAN Diff_ops_paid_volatility_0t12;
    BOOLEAN Diff_ops_paid_volatility_0t6;
    BOOLEAN Diff_ops_spend_monthspastleast_24;
    BOOLEAN Diff_ops_spend_monthspastmost_24;
    BOOLEAN Diff_ops_spend_slope_0t12;
    BOOLEAN Diff_ops_spend_slope_0t24;
    BOOLEAN Diff_ops_spend_slope_0t6;
    BOOLEAN Diff_ops_spend_sum_12;
    BOOLEAN Diff_ops_spend_volatility_0t6;
    BOOLEAN Diff_ops_spend_volatility_6t12;
    BOOLEAN Diff_fleet_paid_average_12;
    BOOLEAN Diff_fleet_paid_monthspastworst_24;
    BOOLEAN Diff_fleet_paid_slope_0t12;
    BOOLEAN Diff_fleet_paid_slope_0t24;
    BOOLEAN Diff_fleet_paid_slope_0t6;
    BOOLEAN Diff_fleet_paid_volatility_0t12;
    BOOLEAN Diff_fleet_paid_volatility_0t6;
    BOOLEAN Diff_fleet_spend_monthspastleast_24;
    BOOLEAN Diff_fleet_spend_monthspastmost_24;
    BOOLEAN Diff_fleet_spend_slope_0t12;
    BOOLEAN Diff_fleet_spend_slope_0t24;
    BOOLEAN Diff_fleet_spend_slope_0t6;
    BOOLEAN Diff_fleet_spend_sum_12;
    BOOLEAN Diff_fleet_spend_volatility_0t6;
    BOOLEAN Diff_fleet_spend_volatility_6t12;
    BOOLEAN Diff_carrier_paid_average_12;
    BOOLEAN Diff_carrier_paid_monthspastworst_24;
    BOOLEAN Diff_carrier_paid_slope_0t12;
    BOOLEAN Diff_carrier_paid_slope_0t24;
    BOOLEAN Diff_carrier_paid_slope_0t6;
    BOOLEAN Diff_carrier_paid_volatility_0t12;
    BOOLEAN Diff_carrier_paid_volatility_0t6;
    BOOLEAN Diff_carrier_spend_monthspastleast_24;
    BOOLEAN Diff_carrier_spend_monthspastmost_24;
    BOOLEAN Diff_carrier_spend_slope_0t12;
    BOOLEAN Diff_carrier_spend_slope_0t24;
    BOOLEAN Diff_carrier_spend_slope_0t6;
    BOOLEAN Diff_carrier_spend_sum_12;
    BOOLEAN Diff_carrier_spend_volatility_0t6;
    BOOLEAN Diff_carrier_spend_volatility_6t12;
    BOOLEAN Diff_bldgmats_paid_average_12;
    BOOLEAN Diff_bldgmats_paid_monthspastworst_24;
    BOOLEAN Diff_bldgmats_paid_slope_0t12;
    BOOLEAN Diff_bldgmats_paid_slope_0t24;
    BOOLEAN Diff_bldgmats_paid_slope_0t6;
    BOOLEAN Diff_bldgmats_paid_volatility_0t12;
    BOOLEAN Diff_bldgmats_paid_volatility_0t6;
    BOOLEAN Diff_bldgmats_spend_monthspastleast_24;
    BOOLEAN Diff_bldgmats_spend_monthspastmost_24;
    BOOLEAN Diff_bldgmats_spend_slope_0t12;
    BOOLEAN Diff_bldgmats_spend_slope_0t24;
    BOOLEAN Diff_bldgmats_spend_slope_0t6;
    BOOLEAN Diff_bldgmats_spend_sum_12;
    BOOLEAN Diff_bldgmats_spend_volatility_0t6;
    BOOLEAN Diff_bldgmats_spend_volatility_6t12;
    BOOLEAN Diff_top5_paid_average_12;
    BOOLEAN Diff_top5_paid_monthspastworst_24;
    BOOLEAN Diff_top5_paid_slope_0t12;
    BOOLEAN Diff_top5_paid_slope_0t24;
    BOOLEAN Diff_top5_paid_slope_0t6;
    BOOLEAN Diff_top5_paid_volatility_0t12;
    BOOLEAN Diff_top5_paid_volatility_0t6;
    BOOLEAN Diff_top5_spend_monthspastleast_24;
    BOOLEAN Diff_top5_spend_monthspastmost_24;
    BOOLEAN Diff_top5_spend_slope_0t12;
    BOOLEAN Diff_top5_spend_slope_0t24;
    BOOLEAN Diff_top5_spend_slope_0t6;
    BOOLEAN Diff_top5_spend_sum_12;
    BOOLEAN Diff_top5_spend_volatility_0t6;
    BOOLEAN Diff_top5_spend_volatility_6t12;
    BOOLEAN Diff_total_numrel_avg12;
    BOOLEAN Diff_total_numrel_monthpspastmost_24;
    BOOLEAN Diff_total_numrel_monthspastleast_24;
    BOOLEAN Diff_total_numrel_slope_0t12;
    BOOLEAN Diff_total_numrel_slope_0t24;
    BOOLEAN Diff_total_numrel_slope_0t6;
    BOOLEAN Diff_total_numrel_slope_6t12;
    BOOLEAN Diff_total_numrel_var_0t12;
    BOOLEAN Diff_total_numrel_var_0t24;
    BOOLEAN Diff_total_numrel_var_12t24;
    BOOLEAN Diff_total_numrel_var_6t18;
    BOOLEAN Diff_mfgmat_numrel_avg12;
    BOOLEAN Diff_mfgmat_numrel_slope_0t12;
    BOOLEAN Diff_mfgmat_numrel_slope_0t24;
    BOOLEAN Diff_mfgmat_numrel_slope_0t6;
    BOOLEAN Diff_mfgmat_numrel_slope_6t12;
    BOOLEAN Diff_mfgmat_numrel_var_0t12;
    BOOLEAN Diff_mfgmat_numrel_var_12t24;
    BOOLEAN Diff_ops_numrel_avg12;
    BOOLEAN Diff_ops_numrel_slope_0t12;
    BOOLEAN Diff_ops_numrel_slope_0t24;
    BOOLEAN Diff_ops_numrel_slope_0t6;
    BOOLEAN Diff_ops_numrel_slope_6t12;
    BOOLEAN Diff_ops_numrel_var_0t12;
    BOOLEAN Diff_ops_numrel_var_12t24;
    BOOLEAN Diff_fleet_numrel_avg12;
    BOOLEAN Diff_fleet_numrel_slope_0t12;
    BOOLEAN Diff_fleet_numrel_slope_0t24;
    BOOLEAN Diff_fleet_numrel_slope_0t6;
    BOOLEAN Diff_fleet_numrel_slope_6t12;
    BOOLEAN Diff_fleet_numrel_var_0t12;
    BOOLEAN Diff_fleet_numrel_var_12t24;
    BOOLEAN Diff_carrier_numrel_avg12;
    BOOLEAN Diff_carrier_numrel_slope_0t12;
    BOOLEAN Diff_carrier_numrel_slope_0t24;
    BOOLEAN Diff_carrier_numrel_slope_0t6;
    BOOLEAN Diff_carrier_numrel_slope_6t12;
    BOOLEAN Diff_carrier_numrel_var_0t12;
    BOOLEAN Diff_carrier_numrel_var_12t24;
    BOOLEAN Diff_bldgmats_numrel_avg12;
    BOOLEAN Diff_bldgmats_numrel_slope_0t12;
    BOOLEAN Diff_bldgmats_numrel_slope_0t24;
    BOOLEAN Diff_bldgmats_numrel_slope_0t6;
    BOOLEAN Diff_bldgmats_numrel_slope_6t12;
    BOOLEAN Diff_bldgmats_numrel_var_0t12;
    BOOLEAN Diff_bldgmats_numrel_var_12t24;
    BOOLEAN Diff_total_monthsoutstanding_slope24;
    BOOLEAN Diff_total_percprov30_avg_0t12;
    BOOLEAN Diff_total_percprov30_slope_0t12;
    BOOLEAN Diff_total_percprov30_slope_0t24;
    BOOLEAN Diff_total_percprov30_slope_0t6;
    BOOLEAN Diff_total_percprov30_slope_6t12;
    BOOLEAN Diff_total_percprov60_avg_0t12;
    BOOLEAN Diff_total_percprov60_slope_0t12;
    BOOLEAN Diff_total_percprov60_slope_0t24;
    BOOLEAN Diff_total_percprov60_slope_0t6;
    BOOLEAN Diff_total_percprov60_slope_6t12;
    BOOLEAN Diff_total_percprov90_avg_0t12;
    BOOLEAN Diff_total_percprov90_lowerlim_0t12;
    BOOLEAN Diff_total_percprov90_slope_0t24;
    BOOLEAN Diff_total_percprov90_slope_0t6;
    BOOLEAN Diff_total_percprov90_slope_6t12;
    BOOLEAN Diff_total_percprovoutstanding_adjustedslope_0t12;
    BOOLEAN Diff_mfgmat_monthsoutstanding_slope24;
    BOOLEAN Diff_mfgmat_percprov30_slope_0t12;
    BOOLEAN Diff_mfgmat_percprov30_slope_6t12;
    BOOLEAN Diff_mfgmat_percprov60_slope_0t12;
    BOOLEAN Diff_mfgmat_percprov60_slope_6t12;
    BOOLEAN Diff_mfgmat_percprov90_slope_0t24;
    BOOLEAN Diff_mfgmat_percprov90_slope_0t6;
    BOOLEAN Diff_mfgmat_percprov90_slope_6t12;
    BOOLEAN Diff_mfgmat_percprovoutstanding_adjustedslope_0t12;
    BOOLEAN Diff_ops_monthsoutstanding_slope24;
    BOOLEAN Diff_ops_percprov30_slope_0t12;
    BOOLEAN Diff_ops_percprov30_slope_6t12;
    BOOLEAN Diff_ops_percprov60_slope_0t12;
    BOOLEAN Diff_ops_percprov60_slope_6t12;
    BOOLEAN Diff_ops_percprov90_slope_0t24;
    BOOLEAN Diff_ops_percprov90_slope_0t6;
    BOOLEAN Diff_ops_percprov90_slope_6t12;
    BOOLEAN Diff_ops_percprovoutstanding_adjustedslope_0t12;
    BOOLEAN Diff_fleet_monthsoutstanding_slope24;
    BOOLEAN Diff_fleet_percprov30_slope_0t12;
    BOOLEAN Diff_fleet_percprov30_slope_6t12;
    BOOLEAN Diff_fleet_percprov60_slope_0t12;
    BOOLEAN Diff_fleet_percprov60_slope_6t12;
    BOOLEAN Diff_fleet_percprov90_slope_0t24;
    BOOLEAN Diff_fleet_percprov90_slope_0t6;
    BOOLEAN Diff_fleet_percprov90_slope_6t12;
    BOOLEAN Diff_fleet_percprovoutstanding_adjustedslope_0t12;
    BOOLEAN Diff_carrier_monthsoutstanding_slope24;
    BOOLEAN Diff_carrier_percprov30_slope_0t12;
    BOOLEAN Diff_carrier_percprov30_slope_6t12;
    BOOLEAN Diff_carrier_percprov60_slope_0t12;
    BOOLEAN Diff_carrier_percprov60_slope_6t12;
    BOOLEAN Diff_carrier_percprov90_slope_0t24;
    BOOLEAN Diff_carrier_percprov90_slope_0t6;
    BOOLEAN Diff_carrier_percprov90_slope_6t12;
    BOOLEAN Diff_carrier_percprovoutstanding_adjustedslope_0t12;
    BOOLEAN Diff_bldgmats_monthsoutstanding_slope24;
    BOOLEAN Diff_bldgmats_percprov30_slope_0t12;
    BOOLEAN Diff_bldgmats_percprov30_slope_6t12;
    BOOLEAN Diff_bldgmats_percprov60_slope_0t12;
    BOOLEAN Diff_bldgmats_percprov60_slope_6t12;
    BOOLEAN Diff_bldgmats_percprov90_slope_0t24;
    BOOLEAN Diff_bldgmats_percprov90_slope_0t6;
    BOOLEAN Diff_bldgmats_percprov90_slope_6t12;
    BOOLEAN Diff_bldgmats_percprovoutstanding_adjustedslope_0t12;
    BOOLEAN Diff_top5_monthsoutstanding_slope24;
    BOOLEAN Diff_top5_percprov30_slope_0t12;
    BOOLEAN Diff_top5_percprov30_slope_6t12;
    BOOLEAN Diff_top5_percprov60_slope_0t12;
    BOOLEAN Diff_top5_percprov60_slope_6t12;
    BOOLEAN Diff_top5_percprov90_slope_0t24;
    BOOLEAN Diff_top5_percprov90_slope_0t6;
    BOOLEAN Diff_top5_percprov90_slope_6t12;
    BOOLEAN Diff_top5_percprovoutstanding_adjustedslope_0t12;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_ultimate_linkid := le.ultimate_linkid <> ri.ultimate_linkid;
    SELF.Diff_cortera_score := le.cortera_score <> ri.cortera_score;
    SELF.Diff_cpr_score := le.cpr_score <> ri.cpr_score;
    SELF.Diff_cpr_segment := le.cpr_segment <> ri.cpr_segment;
    SELF.Diff_dbt := le.dbt <> ri.dbt;
    SELF.Diff_avg_bal := le.avg_bal <> ri.avg_bal;
    SELF.Diff_air_spend := le.air_spend <> ri.air_spend;
    SELF.Diff_fuel_spend := le.fuel_spend <> ri.fuel_spend;
    SELF.Diff_leasing_spend := le.leasing_spend <> ri.leasing_spend;
    SELF.Diff_ltl_spend := le.ltl_spend <> ri.ltl_spend;
    SELF.Diff_rail_spend := le.rail_spend <> ri.rail_spend;
    SELF.Diff_tl_spend := le.tl_spend <> ri.tl_spend;
    SELF.Diff_transvc_spend := le.transvc_spend <> ri.transvc_spend;
    SELF.Diff_transup_spend := le.transup_spend <> ri.transup_spend;
    SELF.Diff_bst_spend := le.bst_spend <> ri.bst_spend;
    SELF.Diff_dg_spend := le.dg_spend <> ri.dg_spend;
    SELF.Diff_electrical_spend := le.electrical_spend <> ri.electrical_spend;
    SELF.Diff_hvac_spend := le.hvac_spend <> ri.hvac_spend;
    SELF.Diff_other_b_spend := le.other_b_spend <> ri.other_b_spend;
    SELF.Diff_plumbing_spend := le.plumbing_spend <> ri.plumbing_spend;
    SELF.Diff_rs_spend := le.rs_spend <> ri.rs_spend;
    SELF.Diff_wp_spend := le.wp_spend <> ri.wp_spend;
    SELF.Diff_chemical_spend := le.chemical_spend <> ri.chemical_spend;
    SELF.Diff_electronic_spend := le.electronic_spend <> ri.electronic_spend;
    SELF.Diff_metal_spend := le.metal_spend <> ri.metal_spend;
    SELF.Diff_other_m_spend := le.other_m_spend <> ri.other_m_spend;
    SELF.Diff_packaging_spend := le.packaging_spend <> ri.packaging_spend;
    SELF.Diff_pvf_spend := le.pvf_spend <> ri.pvf_spend;
    SELF.Diff_plastic_spend := le.plastic_spend <> ri.plastic_spend;
    SELF.Diff_textile_spend := le.textile_spend <> ri.textile_spend;
    SELF.Diff_bs_spend := le.bs_spend <> ri.bs_spend;
    SELF.Diff_ce_spend := le.ce_spend <> ri.ce_spend;
    SELF.Diff_hardware_spend := le.hardware_spend <> ri.hardware_spend;
    SELF.Diff_ie_spend := le.ie_spend <> ri.ie_spend;
    SELF.Diff_is_spend := le.is_spend <> ri.is_spend;
    SELF.Diff_it_spend := le.it_spend <> ri.it_spend;
    SELF.Diff_mls_spend := le.mls_spend <> ri.mls_spend;
    SELF.Diff_os_spend := le.os_spend <> ri.os_spend;
    SELF.Diff_pp_spend := le.pp_spend <> ri.pp_spend;
    SELF.Diff_sis_spend := le.sis_spend <> ri.sis_spend;
    SELF.Diff_apparel_spend := le.apparel_spend <> ri.apparel_spend;
    SELF.Diff_beverages_spend := le.beverages_spend <> ri.beverages_spend;
    SELF.Diff_constr_spend := le.constr_spend <> ri.constr_spend;
    SELF.Diff_consulting_spend := le.consulting_spend <> ri.consulting_spend;
    SELF.Diff_fs_spend := le.fs_spend <> ri.fs_spend;
    SELF.Diff_fp_spend := le.fp_spend <> ri.fp_spend;
    SELF.Diff_insurance_spend := le.insurance_spend <> ri.insurance_spend;
    SELF.Diff_ls_spend := le.ls_spend <> ri.ls_spend;
    SELF.Diff_oil_gas_spend := le.oil_gas_spend <> ri.oil_gas_spend;
    SELF.Diff_utilities_spend := le.utilities_spend <> ri.utilities_spend;
    SELF.Diff_other_spend := le.other_spend <> ri.other_spend;
    SELF.Diff_advt_spend := le.advt_spend <> ri.advt_spend;
    SELF.Diff_air_growth := le.air_growth <> ri.air_growth;
    SELF.Diff_fuel_growth := le.fuel_growth <> ri.fuel_growth;
    SELF.Diff_leasing_growth := le.leasing_growth <> ri.leasing_growth;
    SELF.Diff_ltl_growth := le.ltl_growth <> ri.ltl_growth;
    SELF.Diff_rail_growth := le.rail_growth <> ri.rail_growth;
    SELF.Diff_tl_growth := le.tl_growth <> ri.tl_growth;
    SELF.Diff_transvc_growth := le.transvc_growth <> ri.transvc_growth;
    SELF.Diff_transup_growth := le.transup_growth <> ri.transup_growth;
    SELF.Diff_bst_growth := le.bst_growth <> ri.bst_growth;
    SELF.Diff_dg_growth := le.dg_growth <> ri.dg_growth;
    SELF.Diff_electrical_growth := le.electrical_growth <> ri.electrical_growth;
    SELF.Diff_hvac_growth := le.hvac_growth <> ri.hvac_growth;
    SELF.Diff_other_b_growth := le.other_b_growth <> ri.other_b_growth;
    SELF.Diff_plumbing_growth := le.plumbing_growth <> ri.plumbing_growth;
    SELF.Diff_rs_growth := le.rs_growth <> ri.rs_growth;
    SELF.Diff_wp_growth := le.wp_growth <> ri.wp_growth;
    SELF.Diff_chemical_growth := le.chemical_growth <> ri.chemical_growth;
    SELF.Diff_electronic_growth := le.electronic_growth <> ri.electronic_growth;
    SELF.Diff_metal_growth := le.metal_growth <> ri.metal_growth;
    SELF.Diff_other_m_growth := le.other_m_growth <> ri.other_m_growth;
    SELF.Diff_packaging_growth := le.packaging_growth <> ri.packaging_growth;
    SELF.Diff_pvf_growth := le.pvf_growth <> ri.pvf_growth;
    SELF.Diff_plastic_growth := le.plastic_growth <> ri.plastic_growth;
    SELF.Diff_textile_growth := le.textile_growth <> ri.textile_growth;
    SELF.Diff_bs_growth := le.bs_growth <> ri.bs_growth;
    SELF.Diff_ce_growth := le.ce_growth <> ri.ce_growth;
    SELF.Diff_hardware_growth := le.hardware_growth <> ri.hardware_growth;
    SELF.Diff_ie_growth := le.ie_growth <> ri.ie_growth;
    SELF.Diff_is_growth := le.is_growth <> ri.is_growth;
    SELF.Diff_it_growth := le.it_growth <> ri.it_growth;
    SELF.Diff_mls_growth := le.mls_growth <> ri.mls_growth;
    SELF.Diff_os_growth := le.os_growth <> ri.os_growth;
    SELF.Diff_pp_growth := le.pp_growth <> ri.pp_growth;
    SELF.Diff_sis_growth := le.sis_growth <> ri.sis_growth;
    SELF.Diff_apparel_growth := le.apparel_growth <> ri.apparel_growth;
    SELF.Diff_beverages_growth := le.beverages_growth <> ri.beverages_growth;
    SELF.Diff_constr_growth := le.constr_growth <> ri.constr_growth;
    SELF.Diff_consulting_growth := le.consulting_growth <> ri.consulting_growth;
    SELF.Diff_fs_growth := le.fs_growth <> ri.fs_growth;
    SELF.Diff_fp_growth := le.fp_growth <> ri.fp_growth;
    SELF.Diff_insurance_growth := le.insurance_growth <> ri.insurance_growth;
    SELF.Diff_ls_growth := le.ls_growth <> ri.ls_growth;
    SELF.Diff_oil_gas_growth := le.oil_gas_growth <> ri.oil_gas_growth;
    SELF.Diff_utilities_growth := le.utilities_growth <> ri.utilities_growth;
    SELF.Diff_other_growth := le.other_growth <> ri.other_growth;
    SELF.Diff_advt_growth := le.advt_growth <> ri.advt_growth;
    SELF.Diff_top5_growth := le.top5_growth <> ri.top5_growth;
    SELF.Diff_shipping_y1 := le.shipping_y1 <> ri.shipping_y1;
    SELF.Diff_shipping_growth := le.shipping_growth <> ri.shipping_growth;
    SELF.Diff_materials_y1 := le.materials_y1 <> ri.materials_y1;
    SELF.Diff_materials_growth := le.materials_growth <> ri.materials_growth;
    SELF.Diff_operations_y1 := le.operations_y1 <> ri.operations_y1;
    SELF.Diff_operations_growth := le.operations_growth <> ri.operations_growth;
    SELF.Diff_total_paid_average_0t12 := le.total_paid_average_0t12 <> ri.total_paid_average_0t12;
    SELF.Diff_total_paid_monthspastworst_24 := le.total_paid_monthspastworst_24 <> ri.total_paid_monthspastworst_24;
    SELF.Diff_total_paid_slope_0t12 := le.total_paid_slope_0t12 <> ri.total_paid_slope_0t12;
    SELF.Diff_total_paid_slope_0t6 := le.total_paid_slope_0t6 <> ri.total_paid_slope_0t6;
    SELF.Diff_total_paid_slope_6t12 := le.total_paid_slope_6t12 <> ri.total_paid_slope_6t12;
    SELF.Diff_total_paid_slope_6t18 := le.total_paid_slope_6t18 <> ri.total_paid_slope_6t18;
    SELF.Diff_total_paid_volatility_0t12 := le.total_paid_volatility_0t12 <> ri.total_paid_volatility_0t12;
    SELF.Diff_total_paid_volatility_0t6 := le.total_paid_volatility_0t6 <> ri.total_paid_volatility_0t6;
    SELF.Diff_total_paid_volatility_12t18 := le.total_paid_volatility_12t18 <> ri.total_paid_volatility_12t18;
    SELF.Diff_total_paid_volatility_6t12 := le.total_paid_volatility_6t12 <> ri.total_paid_volatility_6t12;
    SELF.Diff_total_spend_monthspastleast_24 := le.total_spend_monthspastleast_24 <> ri.total_spend_monthspastleast_24;
    SELF.Diff_total_spend_monthspastmost_24 := le.total_spend_monthspastmost_24 <> ri.total_spend_monthspastmost_24;
    SELF.Diff_total_spend_slope_0t12 := le.total_spend_slope_0t12 <> ri.total_spend_slope_0t12;
    SELF.Diff_total_spend_slope_0t24 := le.total_spend_slope_0t24 <> ri.total_spend_slope_0t24;
    SELF.Diff_total_spend_slope_0t6 := le.total_spend_slope_0t6 <> ri.total_spend_slope_0t6;
    SELF.Diff_total_spend_slope_6t12 := le.total_spend_slope_6t12 <> ri.total_spend_slope_6t12;
    SELF.Diff_total_spend_sum_12 := le.total_spend_sum_12 <> ri.total_spend_sum_12;
    SELF.Diff_total_spend_volatility_0t12 := le.total_spend_volatility_0t12 <> ri.total_spend_volatility_0t12;
    SELF.Diff_total_spend_volatility_0t6 := le.total_spend_volatility_0t6 <> ri.total_spend_volatility_0t6;
    SELF.Diff_total_spend_volatility_12t18 := le.total_spend_volatility_12t18 <> ri.total_spend_volatility_12t18;
    SELF.Diff_total_spend_volatility_6t12 := le.total_spend_volatility_6t12 <> ri.total_spend_volatility_6t12;
    SELF.Diff_mfgmat_paid_average_12 := le.mfgmat_paid_average_12 <> ri.mfgmat_paid_average_12;
    SELF.Diff_mfgmat_paid_monthspastworst_24 := le.mfgmat_paid_monthspastworst_24 <> ri.mfgmat_paid_monthspastworst_24;
    SELF.Diff_mfgmat_paid_slope_0t12 := le.mfgmat_paid_slope_0t12 <> ri.mfgmat_paid_slope_0t12;
    SELF.Diff_mfgmat_paid_slope_0t24 := le.mfgmat_paid_slope_0t24 <> ri.mfgmat_paid_slope_0t24;
    SELF.Diff_mfgmat_paid_slope_0t6 := le.mfgmat_paid_slope_0t6 <> ri.mfgmat_paid_slope_0t6;
    SELF.Diff_mfgmat_paid_volatility_0t12 := le.mfgmat_paid_volatility_0t12 <> ri.mfgmat_paid_volatility_0t12;
    SELF.Diff_mfgmat_paid_volatility_0t6 := le.mfgmat_paid_volatility_0t6 <> ri.mfgmat_paid_volatility_0t6;
    SELF.Diff_mfgmat_spend_monthspastleast_24 := le.mfgmat_spend_monthspastleast_24 <> ri.mfgmat_spend_monthspastleast_24;
    SELF.Diff_mfgmat_spend_monthspastmost_24 := le.mfgmat_spend_monthspastmost_24 <> ri.mfgmat_spend_monthspastmost_24;
    SELF.Diff_mfgmat_spend_slope_0t12 := le.mfgmat_spend_slope_0t12 <> ri.mfgmat_spend_slope_0t12;
    SELF.Diff_mfgmat_spend_slope_0t24 := le.mfgmat_spend_slope_0t24 <> ri.mfgmat_spend_slope_0t24;
    SELF.Diff_mfgmat_spend_slope_0t6 := le.mfgmat_spend_slope_0t6 <> ri.mfgmat_spend_slope_0t6;
    SELF.Diff_mfgmat_spend_sum_12 := le.mfgmat_spend_sum_12 <> ri.mfgmat_spend_sum_12;
    SELF.Diff_mfgmat_spend_volatility_0t6 := le.mfgmat_spend_volatility_0t6 <> ri.mfgmat_spend_volatility_0t6;
    SELF.Diff_mfgmat_spend_volatility_6t12 := le.mfgmat_spend_volatility_6t12 <> ri.mfgmat_spend_volatility_6t12;
    SELF.Diff_ops_paid_average_12 := le.ops_paid_average_12 <> ri.ops_paid_average_12;
    SELF.Diff_ops_paid_monthspastworst_24 := le.ops_paid_monthspastworst_24 <> ri.ops_paid_monthspastworst_24;
    SELF.Diff_ops_paid_slope_0t12 := le.ops_paid_slope_0t12 <> ri.ops_paid_slope_0t12;
    SELF.Diff_ops_paid_slope_0t24 := le.ops_paid_slope_0t24 <> ri.ops_paid_slope_0t24;
    SELF.Diff_ops_paid_slope_0t6 := le.ops_paid_slope_0t6 <> ri.ops_paid_slope_0t6;
    SELF.Diff_ops_paid_volatility_0t12 := le.ops_paid_volatility_0t12 <> ri.ops_paid_volatility_0t12;
    SELF.Diff_ops_paid_volatility_0t6 := le.ops_paid_volatility_0t6 <> ri.ops_paid_volatility_0t6;
    SELF.Diff_ops_spend_monthspastleast_24 := le.ops_spend_monthspastleast_24 <> ri.ops_spend_monthspastleast_24;
    SELF.Diff_ops_spend_monthspastmost_24 := le.ops_spend_monthspastmost_24 <> ri.ops_spend_monthspastmost_24;
    SELF.Diff_ops_spend_slope_0t12 := le.ops_spend_slope_0t12 <> ri.ops_spend_slope_0t12;
    SELF.Diff_ops_spend_slope_0t24 := le.ops_spend_slope_0t24 <> ri.ops_spend_slope_0t24;
    SELF.Diff_ops_spend_slope_0t6 := le.ops_spend_slope_0t6 <> ri.ops_spend_slope_0t6;
    SELF.Diff_ops_spend_sum_12 := le.ops_spend_sum_12 <> ri.ops_spend_sum_12;
    SELF.Diff_ops_spend_volatility_0t6 := le.ops_spend_volatility_0t6 <> ri.ops_spend_volatility_0t6;
    SELF.Diff_ops_spend_volatility_6t12 := le.ops_spend_volatility_6t12 <> ri.ops_spend_volatility_6t12;
    SELF.Diff_fleet_paid_average_12 := le.fleet_paid_average_12 <> ri.fleet_paid_average_12;
    SELF.Diff_fleet_paid_monthspastworst_24 := le.fleet_paid_monthspastworst_24 <> ri.fleet_paid_monthspastworst_24;
    SELF.Diff_fleet_paid_slope_0t12 := le.fleet_paid_slope_0t12 <> ri.fleet_paid_slope_0t12;
    SELF.Diff_fleet_paid_slope_0t24 := le.fleet_paid_slope_0t24 <> ri.fleet_paid_slope_0t24;
    SELF.Diff_fleet_paid_slope_0t6 := le.fleet_paid_slope_0t6 <> ri.fleet_paid_slope_0t6;
    SELF.Diff_fleet_paid_volatility_0t12 := le.fleet_paid_volatility_0t12 <> ri.fleet_paid_volatility_0t12;
    SELF.Diff_fleet_paid_volatility_0t6 := le.fleet_paid_volatility_0t6 <> ri.fleet_paid_volatility_0t6;
    SELF.Diff_fleet_spend_monthspastleast_24 := le.fleet_spend_monthspastleast_24 <> ri.fleet_spend_monthspastleast_24;
    SELF.Diff_fleet_spend_monthspastmost_24 := le.fleet_spend_monthspastmost_24 <> ri.fleet_spend_monthspastmost_24;
    SELF.Diff_fleet_spend_slope_0t12 := le.fleet_spend_slope_0t12 <> ri.fleet_spend_slope_0t12;
    SELF.Diff_fleet_spend_slope_0t24 := le.fleet_spend_slope_0t24 <> ri.fleet_spend_slope_0t24;
    SELF.Diff_fleet_spend_slope_0t6 := le.fleet_spend_slope_0t6 <> ri.fleet_spend_slope_0t6;
    SELF.Diff_fleet_spend_sum_12 := le.fleet_spend_sum_12 <> ri.fleet_spend_sum_12;
    SELF.Diff_fleet_spend_volatility_0t6 := le.fleet_spend_volatility_0t6 <> ri.fleet_spend_volatility_0t6;
    SELF.Diff_fleet_spend_volatility_6t12 := le.fleet_spend_volatility_6t12 <> ri.fleet_spend_volatility_6t12;
    SELF.Diff_carrier_paid_average_12 := le.carrier_paid_average_12 <> ri.carrier_paid_average_12;
    SELF.Diff_carrier_paid_monthspastworst_24 := le.carrier_paid_monthspastworst_24 <> ri.carrier_paid_monthspastworst_24;
    SELF.Diff_carrier_paid_slope_0t12 := le.carrier_paid_slope_0t12 <> ri.carrier_paid_slope_0t12;
    SELF.Diff_carrier_paid_slope_0t24 := le.carrier_paid_slope_0t24 <> ri.carrier_paid_slope_0t24;
    SELF.Diff_carrier_paid_slope_0t6 := le.carrier_paid_slope_0t6 <> ri.carrier_paid_slope_0t6;
    SELF.Diff_carrier_paid_volatility_0t12 := le.carrier_paid_volatility_0t12 <> ri.carrier_paid_volatility_0t12;
    SELF.Diff_carrier_paid_volatility_0t6 := le.carrier_paid_volatility_0t6 <> ri.carrier_paid_volatility_0t6;
    SELF.Diff_carrier_spend_monthspastleast_24 := le.carrier_spend_monthspastleast_24 <> ri.carrier_spend_monthspastleast_24;
    SELF.Diff_carrier_spend_monthspastmost_24 := le.carrier_spend_monthspastmost_24 <> ri.carrier_spend_monthspastmost_24;
    SELF.Diff_carrier_spend_slope_0t12 := le.carrier_spend_slope_0t12 <> ri.carrier_spend_slope_0t12;
    SELF.Diff_carrier_spend_slope_0t24 := le.carrier_spend_slope_0t24 <> ri.carrier_spend_slope_0t24;
    SELF.Diff_carrier_spend_slope_0t6 := le.carrier_spend_slope_0t6 <> ri.carrier_spend_slope_0t6;
    SELF.Diff_carrier_spend_sum_12 := le.carrier_spend_sum_12 <> ri.carrier_spend_sum_12;
    SELF.Diff_carrier_spend_volatility_0t6 := le.carrier_spend_volatility_0t6 <> ri.carrier_spend_volatility_0t6;
    SELF.Diff_carrier_spend_volatility_6t12 := le.carrier_spend_volatility_6t12 <> ri.carrier_spend_volatility_6t12;
    SELF.Diff_bldgmats_paid_average_12 := le.bldgmats_paid_average_12 <> ri.bldgmats_paid_average_12;
    SELF.Diff_bldgmats_paid_monthspastworst_24 := le.bldgmats_paid_monthspastworst_24 <> ri.bldgmats_paid_monthspastworst_24;
    SELF.Diff_bldgmats_paid_slope_0t12 := le.bldgmats_paid_slope_0t12 <> ri.bldgmats_paid_slope_0t12;
    SELF.Diff_bldgmats_paid_slope_0t24 := le.bldgmats_paid_slope_0t24 <> ri.bldgmats_paid_slope_0t24;
    SELF.Diff_bldgmats_paid_slope_0t6 := le.bldgmats_paid_slope_0t6 <> ri.bldgmats_paid_slope_0t6;
    SELF.Diff_bldgmats_paid_volatility_0t12 := le.bldgmats_paid_volatility_0t12 <> ri.bldgmats_paid_volatility_0t12;
    SELF.Diff_bldgmats_paid_volatility_0t6 := le.bldgmats_paid_volatility_0t6 <> ri.bldgmats_paid_volatility_0t6;
    SELF.Diff_bldgmats_spend_monthspastleast_24 := le.bldgmats_spend_monthspastleast_24 <> ri.bldgmats_spend_monthspastleast_24;
    SELF.Diff_bldgmats_spend_monthspastmost_24 := le.bldgmats_spend_monthspastmost_24 <> ri.bldgmats_spend_monthspastmost_24;
    SELF.Diff_bldgmats_spend_slope_0t12 := le.bldgmats_spend_slope_0t12 <> ri.bldgmats_spend_slope_0t12;
    SELF.Diff_bldgmats_spend_slope_0t24 := le.bldgmats_spend_slope_0t24 <> ri.bldgmats_spend_slope_0t24;
    SELF.Diff_bldgmats_spend_slope_0t6 := le.bldgmats_spend_slope_0t6 <> ri.bldgmats_spend_slope_0t6;
    SELF.Diff_bldgmats_spend_sum_12 := le.bldgmats_spend_sum_12 <> ri.bldgmats_spend_sum_12;
    SELF.Diff_bldgmats_spend_volatility_0t6 := le.bldgmats_spend_volatility_0t6 <> ri.bldgmats_spend_volatility_0t6;
    SELF.Diff_bldgmats_spend_volatility_6t12 := le.bldgmats_spend_volatility_6t12 <> ri.bldgmats_spend_volatility_6t12;
    SELF.Diff_top5_paid_average_12 := le.top5_paid_average_12 <> ri.top5_paid_average_12;
    SELF.Diff_top5_paid_monthspastworst_24 := le.top5_paid_monthspastworst_24 <> ri.top5_paid_monthspastworst_24;
    SELF.Diff_top5_paid_slope_0t12 := le.top5_paid_slope_0t12 <> ri.top5_paid_slope_0t12;
    SELF.Diff_top5_paid_slope_0t24 := le.top5_paid_slope_0t24 <> ri.top5_paid_slope_0t24;
    SELF.Diff_top5_paid_slope_0t6 := le.top5_paid_slope_0t6 <> ri.top5_paid_slope_0t6;
    SELF.Diff_top5_paid_volatility_0t12 := le.top5_paid_volatility_0t12 <> ri.top5_paid_volatility_0t12;
    SELF.Diff_top5_paid_volatility_0t6 := le.top5_paid_volatility_0t6 <> ri.top5_paid_volatility_0t6;
    SELF.Diff_top5_spend_monthspastleast_24 := le.top5_spend_monthspastleast_24 <> ri.top5_spend_monthspastleast_24;
    SELF.Diff_top5_spend_monthspastmost_24 := le.top5_spend_monthspastmost_24 <> ri.top5_spend_monthspastmost_24;
    SELF.Diff_top5_spend_slope_0t12 := le.top5_spend_slope_0t12 <> ri.top5_spend_slope_0t12;
    SELF.Diff_top5_spend_slope_0t24 := le.top5_spend_slope_0t24 <> ri.top5_spend_slope_0t24;
    SELF.Diff_top5_spend_slope_0t6 := le.top5_spend_slope_0t6 <> ri.top5_spend_slope_0t6;
    SELF.Diff_top5_spend_sum_12 := le.top5_spend_sum_12 <> ri.top5_spend_sum_12;
    SELF.Diff_top5_spend_volatility_0t6 := le.top5_spend_volatility_0t6 <> ri.top5_spend_volatility_0t6;
    SELF.Diff_top5_spend_volatility_6t12 := le.top5_spend_volatility_6t12 <> ri.top5_spend_volatility_6t12;
    SELF.Diff_total_numrel_avg12 := le.total_numrel_avg12 <> ri.total_numrel_avg12;
    SELF.Diff_total_numrel_monthpspastmost_24 := le.total_numrel_monthpspastmost_24 <> ri.total_numrel_monthpspastmost_24;
    SELF.Diff_total_numrel_monthspastleast_24 := le.total_numrel_monthspastleast_24 <> ri.total_numrel_monthspastleast_24;
    SELF.Diff_total_numrel_slope_0t12 := le.total_numrel_slope_0t12 <> ri.total_numrel_slope_0t12;
    SELF.Diff_total_numrel_slope_0t24 := le.total_numrel_slope_0t24 <> ri.total_numrel_slope_0t24;
    SELF.Diff_total_numrel_slope_0t6 := le.total_numrel_slope_0t6 <> ri.total_numrel_slope_0t6;
    SELF.Diff_total_numrel_slope_6t12 := le.total_numrel_slope_6t12 <> ri.total_numrel_slope_6t12;
    SELF.Diff_total_numrel_var_0t12 := le.total_numrel_var_0t12 <> ri.total_numrel_var_0t12;
    SELF.Diff_total_numrel_var_0t24 := le.total_numrel_var_0t24 <> ri.total_numrel_var_0t24;
    SELF.Diff_total_numrel_var_12t24 := le.total_numrel_var_12t24 <> ri.total_numrel_var_12t24;
    SELF.Diff_total_numrel_var_6t18 := le.total_numrel_var_6t18 <> ri.total_numrel_var_6t18;
    SELF.Diff_mfgmat_numrel_avg12 := le.mfgmat_numrel_avg12 <> ri.mfgmat_numrel_avg12;
    SELF.Diff_mfgmat_numrel_slope_0t12 := le.mfgmat_numrel_slope_0t12 <> ri.mfgmat_numrel_slope_0t12;
    SELF.Diff_mfgmat_numrel_slope_0t24 := le.mfgmat_numrel_slope_0t24 <> ri.mfgmat_numrel_slope_0t24;
    SELF.Diff_mfgmat_numrel_slope_0t6 := le.mfgmat_numrel_slope_0t6 <> ri.mfgmat_numrel_slope_0t6;
    SELF.Diff_mfgmat_numrel_slope_6t12 := le.mfgmat_numrel_slope_6t12 <> ri.mfgmat_numrel_slope_6t12;
    SELF.Diff_mfgmat_numrel_var_0t12 := le.mfgmat_numrel_var_0t12 <> ri.mfgmat_numrel_var_0t12;
    SELF.Diff_mfgmat_numrel_var_12t24 := le.mfgmat_numrel_var_12t24 <> ri.mfgmat_numrel_var_12t24;
    SELF.Diff_ops_numrel_avg12 := le.ops_numrel_avg12 <> ri.ops_numrel_avg12;
    SELF.Diff_ops_numrel_slope_0t12 := le.ops_numrel_slope_0t12 <> ri.ops_numrel_slope_0t12;
    SELF.Diff_ops_numrel_slope_0t24 := le.ops_numrel_slope_0t24 <> ri.ops_numrel_slope_0t24;
    SELF.Diff_ops_numrel_slope_0t6 := le.ops_numrel_slope_0t6 <> ri.ops_numrel_slope_0t6;
    SELF.Diff_ops_numrel_slope_6t12 := le.ops_numrel_slope_6t12 <> ri.ops_numrel_slope_6t12;
    SELF.Diff_ops_numrel_var_0t12 := le.ops_numrel_var_0t12 <> ri.ops_numrel_var_0t12;
    SELF.Diff_ops_numrel_var_12t24 := le.ops_numrel_var_12t24 <> ri.ops_numrel_var_12t24;
    SELF.Diff_fleet_numrel_avg12 := le.fleet_numrel_avg12 <> ri.fleet_numrel_avg12;
    SELF.Diff_fleet_numrel_slope_0t12 := le.fleet_numrel_slope_0t12 <> ri.fleet_numrel_slope_0t12;
    SELF.Diff_fleet_numrel_slope_0t24 := le.fleet_numrel_slope_0t24 <> ri.fleet_numrel_slope_0t24;
    SELF.Diff_fleet_numrel_slope_0t6 := le.fleet_numrel_slope_0t6 <> ri.fleet_numrel_slope_0t6;
    SELF.Diff_fleet_numrel_slope_6t12 := le.fleet_numrel_slope_6t12 <> ri.fleet_numrel_slope_6t12;
    SELF.Diff_fleet_numrel_var_0t12 := le.fleet_numrel_var_0t12 <> ri.fleet_numrel_var_0t12;
    SELF.Diff_fleet_numrel_var_12t24 := le.fleet_numrel_var_12t24 <> ri.fleet_numrel_var_12t24;
    SELF.Diff_carrier_numrel_avg12 := le.carrier_numrel_avg12 <> ri.carrier_numrel_avg12;
    SELF.Diff_carrier_numrel_slope_0t12 := le.carrier_numrel_slope_0t12 <> ri.carrier_numrel_slope_0t12;
    SELF.Diff_carrier_numrel_slope_0t24 := le.carrier_numrel_slope_0t24 <> ri.carrier_numrel_slope_0t24;
    SELF.Diff_carrier_numrel_slope_0t6 := le.carrier_numrel_slope_0t6 <> ri.carrier_numrel_slope_0t6;
    SELF.Diff_carrier_numrel_slope_6t12 := le.carrier_numrel_slope_6t12 <> ri.carrier_numrel_slope_6t12;
    SELF.Diff_carrier_numrel_var_0t12 := le.carrier_numrel_var_0t12 <> ri.carrier_numrel_var_0t12;
    SELF.Diff_carrier_numrel_var_12t24 := le.carrier_numrel_var_12t24 <> ri.carrier_numrel_var_12t24;
    SELF.Diff_bldgmats_numrel_avg12 := le.bldgmats_numrel_avg12 <> ri.bldgmats_numrel_avg12;
    SELF.Diff_bldgmats_numrel_slope_0t12 := le.bldgmats_numrel_slope_0t12 <> ri.bldgmats_numrel_slope_0t12;
    SELF.Diff_bldgmats_numrel_slope_0t24 := le.bldgmats_numrel_slope_0t24 <> ri.bldgmats_numrel_slope_0t24;
    SELF.Diff_bldgmats_numrel_slope_0t6 := le.bldgmats_numrel_slope_0t6 <> ri.bldgmats_numrel_slope_0t6;
    SELF.Diff_bldgmats_numrel_slope_6t12 := le.bldgmats_numrel_slope_6t12 <> ri.bldgmats_numrel_slope_6t12;
    SELF.Diff_bldgmats_numrel_var_0t12 := le.bldgmats_numrel_var_0t12 <> ri.bldgmats_numrel_var_0t12;
    SELF.Diff_bldgmats_numrel_var_12t24 := le.bldgmats_numrel_var_12t24 <> ri.bldgmats_numrel_var_12t24;
    SELF.Diff_total_monthsoutstanding_slope24 := le.total_monthsoutstanding_slope24 <> ri.total_monthsoutstanding_slope24;
    SELF.Diff_total_percprov30_avg_0t12 := le.total_percprov30_avg_0t12 <> ri.total_percprov30_avg_0t12;
    SELF.Diff_total_percprov30_slope_0t12 := le.total_percprov30_slope_0t12 <> ri.total_percprov30_slope_0t12;
    SELF.Diff_total_percprov30_slope_0t24 := le.total_percprov30_slope_0t24 <> ri.total_percprov30_slope_0t24;
    SELF.Diff_total_percprov30_slope_0t6 := le.total_percprov30_slope_0t6 <> ri.total_percprov30_slope_0t6;
    SELF.Diff_total_percprov30_slope_6t12 := le.total_percprov30_slope_6t12 <> ri.total_percprov30_slope_6t12;
    SELF.Diff_total_percprov60_avg_0t12 := le.total_percprov60_avg_0t12 <> ri.total_percprov60_avg_0t12;
    SELF.Diff_total_percprov60_slope_0t12 := le.total_percprov60_slope_0t12 <> ri.total_percprov60_slope_0t12;
    SELF.Diff_total_percprov60_slope_0t24 := le.total_percprov60_slope_0t24 <> ri.total_percprov60_slope_0t24;
    SELF.Diff_total_percprov60_slope_0t6 := le.total_percprov60_slope_0t6 <> ri.total_percprov60_slope_0t6;
    SELF.Diff_total_percprov60_slope_6t12 := le.total_percprov60_slope_6t12 <> ri.total_percprov60_slope_6t12;
    SELF.Diff_total_percprov90_avg_0t12 := le.total_percprov90_avg_0t12 <> ri.total_percprov90_avg_0t12;
    SELF.Diff_total_percprov90_lowerlim_0t12 := le.total_percprov90_lowerlim_0t12 <> ri.total_percprov90_lowerlim_0t12;
    SELF.Diff_total_percprov90_slope_0t24 := le.total_percprov90_slope_0t24 <> ri.total_percprov90_slope_0t24;
    SELF.Diff_total_percprov90_slope_0t6 := le.total_percprov90_slope_0t6 <> ri.total_percprov90_slope_0t6;
    SELF.Diff_total_percprov90_slope_6t12 := le.total_percprov90_slope_6t12 <> ri.total_percprov90_slope_6t12;
    SELF.Diff_total_percprovoutstanding_adjustedslope_0t12 := le.total_percprovoutstanding_adjustedslope_0t12 <> ri.total_percprovoutstanding_adjustedslope_0t12;
    SELF.Diff_mfgmat_monthsoutstanding_slope24 := le.mfgmat_monthsoutstanding_slope24 <> ri.mfgmat_monthsoutstanding_slope24;
    SELF.Diff_mfgmat_percprov30_slope_0t12 := le.mfgmat_percprov30_slope_0t12 <> ri.mfgmat_percprov30_slope_0t12;
    SELF.Diff_mfgmat_percprov30_slope_6t12 := le.mfgmat_percprov30_slope_6t12 <> ri.mfgmat_percprov30_slope_6t12;
    SELF.Diff_mfgmat_percprov60_slope_0t12 := le.mfgmat_percprov60_slope_0t12 <> ri.mfgmat_percprov60_slope_0t12;
    SELF.Diff_mfgmat_percprov60_slope_6t12 := le.mfgmat_percprov60_slope_6t12 <> ri.mfgmat_percprov60_slope_6t12;
    SELF.Diff_mfgmat_percprov90_slope_0t24 := le.mfgmat_percprov90_slope_0t24 <> ri.mfgmat_percprov90_slope_0t24;
    SELF.Diff_mfgmat_percprov90_slope_0t6 := le.mfgmat_percprov90_slope_0t6 <> ri.mfgmat_percprov90_slope_0t6;
    SELF.Diff_mfgmat_percprov90_slope_6t12 := le.mfgmat_percprov90_slope_6t12 <> ri.mfgmat_percprov90_slope_6t12;
    SELF.Diff_mfgmat_percprovoutstanding_adjustedslope_0t12 := le.mfgmat_percprovoutstanding_adjustedslope_0t12 <> ri.mfgmat_percprovoutstanding_adjustedslope_0t12;
    SELF.Diff_ops_monthsoutstanding_slope24 := le.ops_monthsoutstanding_slope24 <> ri.ops_monthsoutstanding_slope24;
    SELF.Diff_ops_percprov30_slope_0t12 := le.ops_percprov30_slope_0t12 <> ri.ops_percprov30_slope_0t12;
    SELF.Diff_ops_percprov30_slope_6t12 := le.ops_percprov30_slope_6t12 <> ri.ops_percprov30_slope_6t12;
    SELF.Diff_ops_percprov60_slope_0t12 := le.ops_percprov60_slope_0t12 <> ri.ops_percprov60_slope_0t12;
    SELF.Diff_ops_percprov60_slope_6t12 := le.ops_percprov60_slope_6t12 <> ri.ops_percprov60_slope_6t12;
    SELF.Diff_ops_percprov90_slope_0t24 := le.ops_percprov90_slope_0t24 <> ri.ops_percprov90_slope_0t24;
    SELF.Diff_ops_percprov90_slope_0t6 := le.ops_percprov90_slope_0t6 <> ri.ops_percprov90_slope_0t6;
    SELF.Diff_ops_percprov90_slope_6t12 := le.ops_percprov90_slope_6t12 <> ri.ops_percprov90_slope_6t12;
    SELF.Diff_ops_percprovoutstanding_adjustedslope_0t12 := le.ops_percprovoutstanding_adjustedslope_0t12 <> ri.ops_percprovoutstanding_adjustedslope_0t12;
    SELF.Diff_fleet_monthsoutstanding_slope24 := le.fleet_monthsoutstanding_slope24 <> ri.fleet_monthsoutstanding_slope24;
    SELF.Diff_fleet_percprov30_slope_0t12 := le.fleet_percprov30_slope_0t12 <> ri.fleet_percprov30_slope_0t12;
    SELF.Diff_fleet_percprov30_slope_6t12 := le.fleet_percprov30_slope_6t12 <> ri.fleet_percprov30_slope_6t12;
    SELF.Diff_fleet_percprov60_slope_0t12 := le.fleet_percprov60_slope_0t12 <> ri.fleet_percprov60_slope_0t12;
    SELF.Diff_fleet_percprov60_slope_6t12 := le.fleet_percprov60_slope_6t12 <> ri.fleet_percprov60_slope_6t12;
    SELF.Diff_fleet_percprov90_slope_0t24 := le.fleet_percprov90_slope_0t24 <> ri.fleet_percprov90_slope_0t24;
    SELF.Diff_fleet_percprov90_slope_0t6 := le.fleet_percprov90_slope_0t6 <> ri.fleet_percprov90_slope_0t6;
    SELF.Diff_fleet_percprov90_slope_6t12 := le.fleet_percprov90_slope_6t12 <> ri.fleet_percprov90_slope_6t12;
    SELF.Diff_fleet_percprovoutstanding_adjustedslope_0t12 := le.fleet_percprovoutstanding_adjustedslope_0t12 <> ri.fleet_percprovoutstanding_adjustedslope_0t12;
    SELF.Diff_carrier_monthsoutstanding_slope24 := le.carrier_monthsoutstanding_slope24 <> ri.carrier_monthsoutstanding_slope24;
    SELF.Diff_carrier_percprov30_slope_0t12 := le.carrier_percprov30_slope_0t12 <> ri.carrier_percprov30_slope_0t12;
    SELF.Diff_carrier_percprov30_slope_6t12 := le.carrier_percprov30_slope_6t12 <> ri.carrier_percprov30_slope_6t12;
    SELF.Diff_carrier_percprov60_slope_0t12 := le.carrier_percprov60_slope_0t12 <> ri.carrier_percprov60_slope_0t12;
    SELF.Diff_carrier_percprov60_slope_6t12 := le.carrier_percprov60_slope_6t12 <> ri.carrier_percprov60_slope_6t12;
    SELF.Diff_carrier_percprov90_slope_0t24 := le.carrier_percprov90_slope_0t24 <> ri.carrier_percprov90_slope_0t24;
    SELF.Diff_carrier_percprov90_slope_0t6 := le.carrier_percprov90_slope_0t6 <> ri.carrier_percprov90_slope_0t6;
    SELF.Diff_carrier_percprov90_slope_6t12 := le.carrier_percprov90_slope_6t12 <> ri.carrier_percprov90_slope_6t12;
    SELF.Diff_carrier_percprovoutstanding_adjustedslope_0t12 := le.carrier_percprovoutstanding_adjustedslope_0t12 <> ri.carrier_percprovoutstanding_adjustedslope_0t12;
    SELF.Diff_bldgmats_monthsoutstanding_slope24 := le.bldgmats_monthsoutstanding_slope24 <> ri.bldgmats_monthsoutstanding_slope24;
    SELF.Diff_bldgmats_percprov30_slope_0t12 := le.bldgmats_percprov30_slope_0t12 <> ri.bldgmats_percprov30_slope_0t12;
    SELF.Diff_bldgmats_percprov30_slope_6t12 := le.bldgmats_percprov30_slope_6t12 <> ri.bldgmats_percprov30_slope_6t12;
    SELF.Diff_bldgmats_percprov60_slope_0t12 := le.bldgmats_percprov60_slope_0t12 <> ri.bldgmats_percprov60_slope_0t12;
    SELF.Diff_bldgmats_percprov60_slope_6t12 := le.bldgmats_percprov60_slope_6t12 <> ri.bldgmats_percprov60_slope_6t12;
    SELF.Diff_bldgmats_percprov90_slope_0t24 := le.bldgmats_percprov90_slope_0t24 <> ri.bldgmats_percprov90_slope_0t24;
    SELF.Diff_bldgmats_percprov90_slope_0t6 := le.bldgmats_percprov90_slope_0t6 <> ri.bldgmats_percprov90_slope_0t6;
    SELF.Diff_bldgmats_percprov90_slope_6t12 := le.bldgmats_percprov90_slope_6t12 <> ri.bldgmats_percprov90_slope_6t12;
    SELF.Diff_bldgmats_percprovoutstanding_adjustedslope_0t12 := le.bldgmats_percprovoutstanding_adjustedslope_0t12 <> ri.bldgmats_percprovoutstanding_adjustedslope_0t12;
    SELF.Diff_top5_monthsoutstanding_slope24 := le.top5_monthsoutstanding_slope24 <> ri.top5_monthsoutstanding_slope24;
    SELF.Diff_top5_percprov30_slope_0t12 := le.top5_percprov30_slope_0t12 <> ri.top5_percprov30_slope_0t12;
    SELF.Diff_top5_percprov30_slope_6t12 := le.top5_percprov30_slope_6t12 <> ri.top5_percprov30_slope_6t12;
    SELF.Diff_top5_percprov60_slope_0t12 := le.top5_percprov60_slope_0t12 <> ri.top5_percprov60_slope_0t12;
    SELF.Diff_top5_percprov60_slope_6t12 := le.top5_percprov60_slope_6t12 <> ri.top5_percprov60_slope_6t12;
    SELF.Diff_top5_percprov90_slope_0t24 := le.top5_percprov90_slope_0t24 <> ri.top5_percprov90_slope_0t24;
    SELF.Diff_top5_percprov90_slope_0t6 := le.top5_percprov90_slope_0t6 <> ri.top5_percprov90_slope_0t6;
    SELF.Diff_top5_percprov90_slope_6t12 := le.top5_percprov90_slope_6t12 <> ri.top5_percprov90_slope_6t12;
    SELF.Diff_top5_percprovoutstanding_adjustedslope_0t12 := le.top5_percprovoutstanding_adjustedslope_0t12 <> ri.top5_percprovoutstanding_adjustedslope_0t12;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_ultimate_linkid,1,0)+ IF( SELF.Diff_cortera_score,1,0)+ IF( SELF.Diff_cpr_score,1,0)+ IF( SELF.Diff_cpr_segment,1,0)+ IF( SELF.Diff_dbt,1,0)+ IF( SELF.Diff_avg_bal,1,0)+ IF( SELF.Diff_air_spend,1,0)+ IF( SELF.Diff_fuel_spend,1,0)+ IF( SELF.Diff_leasing_spend,1,0)+ IF( SELF.Diff_ltl_spend,1,0)+ IF( SELF.Diff_rail_spend,1,0)+ IF( SELF.Diff_tl_spend,1,0)+ IF( SELF.Diff_transvc_spend,1,0)+ IF( SELF.Diff_transup_spend,1,0)+ IF( SELF.Diff_bst_spend,1,0)+ IF( SELF.Diff_dg_spend,1,0)+ IF( SELF.Diff_electrical_spend,1,0)+ IF( SELF.Diff_hvac_spend,1,0)+ IF( SELF.Diff_other_b_spend,1,0)+ IF( SELF.Diff_plumbing_spend,1,0)+ IF( SELF.Diff_rs_spend,1,0)+ IF( SELF.Diff_wp_spend,1,0)+ IF( SELF.Diff_chemical_spend,1,0)+ IF( SELF.Diff_electronic_spend,1,0)+ IF( SELF.Diff_metal_spend,1,0)+ IF( SELF.Diff_other_m_spend,1,0)+ IF( SELF.Diff_packaging_spend,1,0)+ IF( SELF.Diff_pvf_spend,1,0)+ IF( SELF.Diff_plastic_spend,1,0)+ IF( SELF.Diff_textile_spend,1,0)+ IF( SELF.Diff_bs_spend,1,0)+ IF( SELF.Diff_ce_spend,1,0)+ IF( SELF.Diff_hardware_spend,1,0)+ IF( SELF.Diff_ie_spend,1,0)+ IF( SELF.Diff_is_spend,1,0)+ IF( SELF.Diff_it_spend,1,0)+ IF( SELF.Diff_mls_spend,1,0)+ IF( SELF.Diff_os_spend,1,0)+ IF( SELF.Diff_pp_spend,1,0)+ IF( SELF.Diff_sis_spend,1,0)+ IF( SELF.Diff_apparel_spend,1,0)+ IF( SELF.Diff_beverages_spend,1,0)+ IF( SELF.Diff_constr_spend,1,0)+ IF( SELF.Diff_consulting_spend,1,0)+ IF( SELF.Diff_fs_spend,1,0)+ IF( SELF.Diff_fp_spend,1,0)+ IF( SELF.Diff_insurance_spend,1,0)+ IF( SELF.Diff_ls_spend,1,0)+ IF( SELF.Diff_oil_gas_spend,1,0)+ IF( SELF.Diff_utilities_spend,1,0)+ IF( SELF.Diff_other_spend,1,0)+ IF( SELF.Diff_advt_spend,1,0)+ IF( SELF.Diff_air_growth,1,0)+ IF( SELF.Diff_fuel_growth,1,0)+ IF( SELF.Diff_leasing_growth,1,0)+ IF( SELF.Diff_ltl_growth,1,0)+ IF( SELF.Diff_rail_growth,1,0)+ IF( SELF.Diff_tl_growth,1,0)+ IF( SELF.Diff_transvc_growth,1,0)+ IF( SELF.Diff_transup_growth,1,0)+ IF( SELF.Diff_bst_growth,1,0)+ IF( SELF.Diff_dg_growth,1,0)+ IF( SELF.Diff_electrical_growth,1,0)+ IF( SELF.Diff_hvac_growth,1,0)+ IF( SELF.Diff_other_b_growth,1,0)+ IF( SELF.Diff_plumbing_growth,1,0)+ IF( SELF.Diff_rs_growth,1,0)+ IF( SELF.Diff_wp_growth,1,0)+ IF( SELF.Diff_chemical_growth,1,0)+ IF( SELF.Diff_electronic_growth,1,0)+ IF( SELF.Diff_metal_growth,1,0)+ IF( SELF.Diff_other_m_growth,1,0)+ IF( SELF.Diff_packaging_growth,1,0)+ IF( SELF.Diff_pvf_growth,1,0)+ IF( SELF.Diff_plastic_growth,1,0)+ IF( SELF.Diff_textile_growth,1,0)+ IF( SELF.Diff_bs_growth,1,0)+ IF( SELF.Diff_ce_growth,1,0)+ IF( SELF.Diff_hardware_growth,1,0)+ IF( SELF.Diff_ie_growth,1,0)+ IF( SELF.Diff_is_growth,1,0)+ IF( SELF.Diff_it_growth,1,0)+ IF( SELF.Diff_mls_growth,1,0)+ IF( SELF.Diff_os_growth,1,0)+ IF( SELF.Diff_pp_growth,1,0)+ IF( SELF.Diff_sis_growth,1,0)+ IF( SELF.Diff_apparel_growth,1,0)+ IF( SELF.Diff_beverages_growth,1,0)+ IF( SELF.Diff_constr_growth,1,0)+ IF( SELF.Diff_consulting_growth,1,0)+ IF( SELF.Diff_fs_growth,1,0)+ IF( SELF.Diff_fp_growth,1,0)+ IF( SELF.Diff_insurance_growth,1,0)+ IF( SELF.Diff_ls_growth,1,0)+ IF( SELF.Diff_oil_gas_growth,1,0)+ IF( SELF.Diff_utilities_growth,1,0)+ IF( SELF.Diff_other_growth,1,0)+ IF( SELF.Diff_advt_growth,1,0)+ IF( SELF.Diff_top5_growth,1,0)+ IF( SELF.Diff_shipping_y1,1,0)+ IF( SELF.Diff_shipping_growth,1,0)+ IF( SELF.Diff_materials_y1,1,0)+ IF( SELF.Diff_materials_growth,1,0)+ IF( SELF.Diff_operations_y1,1,0)+ IF( SELF.Diff_operations_growth,1,0)+ IF( SELF.Diff_total_paid_average_0t12,1,0)+ IF( SELF.Diff_total_paid_monthspastworst_24,1,0)+ IF( SELF.Diff_total_paid_slope_0t12,1,0)+ IF( SELF.Diff_total_paid_slope_0t6,1,0)+ IF( SELF.Diff_total_paid_slope_6t12,1,0)+ IF( SELF.Diff_total_paid_slope_6t18,1,0)+ IF( SELF.Diff_total_paid_volatility_0t12,1,0)+ IF( SELF.Diff_total_paid_volatility_0t6,1,0)+ IF( SELF.Diff_total_paid_volatility_12t18,1,0)+ IF( SELF.Diff_total_paid_volatility_6t12,1,0)+ IF( SELF.Diff_total_spend_monthspastleast_24,1,0)+ IF( SELF.Diff_total_spend_monthspastmost_24,1,0)+ IF( SELF.Diff_total_spend_slope_0t12,1,0)+ IF( SELF.Diff_total_spend_slope_0t24,1,0)+ IF( SELF.Diff_total_spend_slope_0t6,1,0)+ IF( SELF.Diff_total_spend_slope_6t12,1,0)+ IF( SELF.Diff_total_spend_sum_12,1,0)+ IF( SELF.Diff_total_spend_volatility_0t12,1,0)+ IF( SELF.Diff_total_spend_volatility_0t6,1,0)+ IF( SELF.Diff_total_spend_volatility_12t18,1,0)+ IF( SELF.Diff_total_spend_volatility_6t12,1,0)+ IF( SELF.Diff_mfgmat_paid_average_12,1,0)+ IF( SELF.Diff_mfgmat_paid_monthspastworst_24,1,0)+ IF( SELF.Diff_mfgmat_paid_slope_0t12,1,0)+ IF( SELF.Diff_mfgmat_paid_slope_0t24,1,0)+ IF( SELF.Diff_mfgmat_paid_slope_0t6,1,0)+ IF( SELF.Diff_mfgmat_paid_volatility_0t12,1,0)+ IF( SELF.Diff_mfgmat_paid_volatility_0t6,1,0)+ IF( SELF.Diff_mfgmat_spend_monthspastleast_24,1,0)+ IF( SELF.Diff_mfgmat_spend_monthspastmost_24,1,0)+ IF( SELF.Diff_mfgmat_spend_slope_0t12,1,0)+ IF( SELF.Diff_mfgmat_spend_slope_0t24,1,0)+ IF( SELF.Diff_mfgmat_spend_slope_0t6,1,0)+ IF( SELF.Diff_mfgmat_spend_sum_12,1,0)+ IF( SELF.Diff_mfgmat_spend_volatility_0t6,1,0)+ IF( SELF.Diff_mfgmat_spend_volatility_6t12,1,0)+ IF( SELF.Diff_ops_paid_average_12,1,0)+ IF( SELF.Diff_ops_paid_monthspastworst_24,1,0)+ IF( SELF.Diff_ops_paid_slope_0t12,1,0)+ IF( SELF.Diff_ops_paid_slope_0t24,1,0)+ IF( SELF.Diff_ops_paid_slope_0t6,1,0)+ IF( SELF.Diff_ops_paid_volatility_0t12,1,0)+ IF( SELF.Diff_ops_paid_volatility_0t6,1,0)+ IF( SELF.Diff_ops_spend_monthspastleast_24,1,0)+ IF( SELF.Diff_ops_spend_monthspastmost_24,1,0)+ IF( SELF.Diff_ops_spend_slope_0t12,1,0)+ IF( SELF.Diff_ops_spend_slope_0t24,1,0)+ IF( SELF.Diff_ops_spend_slope_0t6,1,0)+ IF( SELF.Diff_ops_spend_sum_12,1,0)+ IF( SELF.Diff_ops_spend_volatility_0t6,1,0)+ IF( SELF.Diff_ops_spend_volatility_6t12,1,0)+ IF( SELF.Diff_fleet_paid_average_12,1,0)+ IF( SELF.Diff_fleet_paid_monthspastworst_24,1,0)+ IF( SELF.Diff_fleet_paid_slope_0t12,1,0)+ IF( SELF.Diff_fleet_paid_slope_0t24,1,0)+ IF( SELF.Diff_fleet_paid_slope_0t6,1,0)+ IF( SELF.Diff_fleet_paid_volatility_0t12,1,0)+ IF( SELF.Diff_fleet_paid_volatility_0t6,1,0)+ IF( SELF.Diff_fleet_spend_monthspastleast_24,1,0)+ IF( SELF.Diff_fleet_spend_monthspastmost_24,1,0)+ IF( SELF.Diff_fleet_spend_slope_0t12,1,0)+ IF( SELF.Diff_fleet_spend_slope_0t24,1,0)+ IF( SELF.Diff_fleet_spend_slope_0t6,1,0)+ IF( SELF.Diff_fleet_spend_sum_12,1,0)+ IF( SELF.Diff_fleet_spend_volatility_0t6,1,0)+ IF( SELF.Diff_fleet_spend_volatility_6t12,1,0)+ IF( SELF.Diff_carrier_paid_average_12,1,0)+ IF( SELF.Diff_carrier_paid_monthspastworst_24,1,0)+ IF( SELF.Diff_carrier_paid_slope_0t12,1,0)+ IF( SELF.Diff_carrier_paid_slope_0t24,1,0)+ IF( SELF.Diff_carrier_paid_slope_0t6,1,0)+ IF( SELF.Diff_carrier_paid_volatility_0t12,1,0)+ IF( SELF.Diff_carrier_paid_volatility_0t6,1,0)+ IF( SELF.Diff_carrier_spend_monthspastleast_24,1,0)+ IF( SELF.Diff_carrier_spend_monthspastmost_24,1,0)+ IF( SELF.Diff_carrier_spend_slope_0t12,1,0)+ IF( SELF.Diff_carrier_spend_slope_0t24,1,0)+ IF( SELF.Diff_carrier_spend_slope_0t6,1,0)+ IF( SELF.Diff_carrier_spend_sum_12,1,0)+ IF( SELF.Diff_carrier_spend_volatility_0t6,1,0)+ IF( SELF.Diff_carrier_spend_volatility_6t12,1,0)+ IF( SELF.Diff_bldgmats_paid_average_12,1,0)+ IF( SELF.Diff_bldgmats_paid_monthspastworst_24,1,0)+ IF( SELF.Diff_bldgmats_paid_slope_0t12,1,0)+ IF( SELF.Diff_bldgmats_paid_slope_0t24,1,0)+ IF( SELF.Diff_bldgmats_paid_slope_0t6,1,0)+ IF( SELF.Diff_bldgmats_paid_volatility_0t12,1,0)+ IF( SELF.Diff_bldgmats_paid_volatility_0t6,1,0)+ IF( SELF.Diff_bldgmats_spend_monthspastleast_24,1,0)+ IF( SELF.Diff_bldgmats_spend_monthspastmost_24,1,0)+ IF( SELF.Diff_bldgmats_spend_slope_0t12,1,0)+ IF( SELF.Diff_bldgmats_spend_slope_0t24,1,0)+ IF( SELF.Diff_bldgmats_spend_slope_0t6,1,0)+ IF( SELF.Diff_bldgmats_spend_sum_12,1,0)+ IF( SELF.Diff_bldgmats_spend_volatility_0t6,1,0)+ IF( SELF.Diff_bldgmats_spend_volatility_6t12,1,0)+ IF( SELF.Diff_top5_paid_average_12,1,0)+ IF( SELF.Diff_top5_paid_monthspastworst_24,1,0)+ IF( SELF.Diff_top5_paid_slope_0t12,1,0)+ IF( SELF.Diff_top5_paid_slope_0t24,1,0)+ IF( SELF.Diff_top5_paid_slope_0t6,1,0)+ IF( SELF.Diff_top5_paid_volatility_0t12,1,0)+ IF( SELF.Diff_top5_paid_volatility_0t6,1,0)+ IF( SELF.Diff_top5_spend_monthspastleast_24,1,0)+ IF( SELF.Diff_top5_spend_monthspastmost_24,1,0)+ IF( SELF.Diff_top5_spend_slope_0t12,1,0)+ IF( SELF.Diff_top5_spend_slope_0t24,1,0)+ IF( SELF.Diff_top5_spend_slope_0t6,1,0)+ IF( SELF.Diff_top5_spend_sum_12,1,0)+ IF( SELF.Diff_top5_spend_volatility_0t6,1,0)+ IF( SELF.Diff_top5_spend_volatility_6t12,1,0)+ IF( SELF.Diff_total_numrel_avg12,1,0)+ IF( SELF.Diff_total_numrel_monthpspastmost_24,1,0)+ IF( SELF.Diff_total_numrel_monthspastleast_24,1,0)+ IF( SELF.Diff_total_numrel_slope_0t12,1,0)+ IF( SELF.Diff_total_numrel_slope_0t24,1,0)+ IF( SELF.Diff_total_numrel_slope_0t6,1,0)+ IF( SELF.Diff_total_numrel_slope_6t12,1,0)+ IF( SELF.Diff_total_numrel_var_0t12,1,0)+ IF( SELF.Diff_total_numrel_var_0t24,1,0)+ IF( SELF.Diff_total_numrel_var_12t24,1,0)+ IF( SELF.Diff_total_numrel_var_6t18,1,0)+ IF( SELF.Diff_mfgmat_numrel_avg12,1,0)+ IF( SELF.Diff_mfgmat_numrel_slope_0t12,1,0)+ IF( SELF.Diff_mfgmat_numrel_slope_0t24,1,0)+ IF( SELF.Diff_mfgmat_numrel_slope_0t6,1,0)+ IF( SELF.Diff_mfgmat_numrel_slope_6t12,1,0)+ IF( SELF.Diff_mfgmat_numrel_var_0t12,1,0)+ IF( SELF.Diff_mfgmat_numrel_var_12t24,1,0)+ IF( SELF.Diff_ops_numrel_avg12,1,0)+ IF( SELF.Diff_ops_numrel_slope_0t12,1,0)+ IF( SELF.Diff_ops_numrel_slope_0t24,1,0)+ IF( SELF.Diff_ops_numrel_slope_0t6,1,0)+ IF( SELF.Diff_ops_numrel_slope_6t12,1,0)+ IF( SELF.Diff_ops_numrel_var_0t12,1,0)+ IF( SELF.Diff_ops_numrel_var_12t24,1,0)+ IF( SELF.Diff_fleet_numrel_avg12,1,0)+ IF( SELF.Diff_fleet_numrel_slope_0t12,1,0)+ IF( SELF.Diff_fleet_numrel_slope_0t24,1,0)+ IF( SELF.Diff_fleet_numrel_slope_0t6,1,0)+ IF( SELF.Diff_fleet_numrel_slope_6t12,1,0)+ IF( SELF.Diff_fleet_numrel_var_0t12,1,0)+ IF( SELF.Diff_fleet_numrel_var_12t24,1,0)+ IF( SELF.Diff_carrier_numrel_avg12,1,0)+ IF( SELF.Diff_carrier_numrel_slope_0t12,1,0)+ IF( SELF.Diff_carrier_numrel_slope_0t24,1,0)+ IF( SELF.Diff_carrier_numrel_slope_0t6,1,0)+ IF( SELF.Diff_carrier_numrel_slope_6t12,1,0)+ IF( SELF.Diff_carrier_numrel_var_0t12,1,0)+ IF( SELF.Diff_carrier_numrel_var_12t24,1,0)+ IF( SELF.Diff_bldgmats_numrel_avg12,1,0)+ IF( SELF.Diff_bldgmats_numrel_slope_0t12,1,0)+ IF( SELF.Diff_bldgmats_numrel_slope_0t24,1,0)+ IF( SELF.Diff_bldgmats_numrel_slope_0t6,1,0)+ IF( SELF.Diff_bldgmats_numrel_slope_6t12,1,0)+ IF( SELF.Diff_bldgmats_numrel_var_0t12,1,0)+ IF( SELF.Diff_bldgmats_numrel_var_12t24,1,0)+ IF( SELF.Diff_total_monthsoutstanding_slope24,1,0)+ IF( SELF.Diff_total_percprov30_avg_0t12,1,0)+ IF( SELF.Diff_total_percprov30_slope_0t12,1,0)+ IF( SELF.Diff_total_percprov30_slope_0t24,1,0)+ IF( SELF.Diff_total_percprov30_slope_0t6,1,0)+ IF( SELF.Diff_total_percprov30_slope_6t12,1,0)+ IF( SELF.Diff_total_percprov60_avg_0t12,1,0)+ IF( SELF.Diff_total_percprov60_slope_0t12,1,0)+ IF( SELF.Diff_total_percprov60_slope_0t24,1,0)+ IF( SELF.Diff_total_percprov60_slope_0t6,1,0)+ IF( SELF.Diff_total_percprov60_slope_6t12,1,0)+ IF( SELF.Diff_total_percprov90_avg_0t12,1,0)+ IF( SELF.Diff_total_percprov90_lowerlim_0t12,1,0)+ IF( SELF.Diff_total_percprov90_slope_0t24,1,0)+ IF( SELF.Diff_total_percprov90_slope_0t6,1,0)+ IF( SELF.Diff_total_percprov90_slope_6t12,1,0)+ IF( SELF.Diff_total_percprovoutstanding_adjustedslope_0t12,1,0)+ IF( SELF.Diff_mfgmat_monthsoutstanding_slope24,1,0)+ IF( SELF.Diff_mfgmat_percprov30_slope_0t12,1,0)+ IF( SELF.Diff_mfgmat_percprov30_slope_6t12,1,0)+ IF( SELF.Diff_mfgmat_percprov60_slope_0t12,1,0)+ IF( SELF.Diff_mfgmat_percprov60_slope_6t12,1,0)+ IF( SELF.Diff_mfgmat_percprov90_slope_0t24,1,0)+ IF( SELF.Diff_mfgmat_percprov90_slope_0t6,1,0)+ IF( SELF.Diff_mfgmat_percprov90_slope_6t12,1,0)+ IF( SELF.Diff_mfgmat_percprovoutstanding_adjustedslope_0t12,1,0)+ IF( SELF.Diff_ops_monthsoutstanding_slope24,1,0)+ IF( SELF.Diff_ops_percprov30_slope_0t12,1,0)+ IF( SELF.Diff_ops_percprov30_slope_6t12,1,0)+ IF( SELF.Diff_ops_percprov60_slope_0t12,1,0)+ IF( SELF.Diff_ops_percprov60_slope_6t12,1,0)+ IF( SELF.Diff_ops_percprov90_slope_0t24,1,0)+ IF( SELF.Diff_ops_percprov90_slope_0t6,1,0)+ IF( SELF.Diff_ops_percprov90_slope_6t12,1,0)+ IF( SELF.Diff_ops_percprovoutstanding_adjustedslope_0t12,1,0)+ IF( SELF.Diff_fleet_monthsoutstanding_slope24,1,0)+ IF( SELF.Diff_fleet_percprov30_slope_0t12,1,0)+ IF( SELF.Diff_fleet_percprov30_slope_6t12,1,0)+ IF( SELF.Diff_fleet_percprov60_slope_0t12,1,0)+ IF( SELF.Diff_fleet_percprov60_slope_6t12,1,0)+ IF( SELF.Diff_fleet_percprov90_slope_0t24,1,0)+ IF( SELF.Diff_fleet_percprov90_slope_0t6,1,0)+ IF( SELF.Diff_fleet_percprov90_slope_6t12,1,0)+ IF( SELF.Diff_fleet_percprovoutstanding_adjustedslope_0t12,1,0)+ IF( SELF.Diff_carrier_monthsoutstanding_slope24,1,0)+ IF( SELF.Diff_carrier_percprov30_slope_0t12,1,0)+ IF( SELF.Diff_carrier_percprov30_slope_6t12,1,0)+ IF( SELF.Diff_carrier_percprov60_slope_0t12,1,0)+ IF( SELF.Diff_carrier_percprov60_slope_6t12,1,0)+ IF( SELF.Diff_carrier_percprov90_slope_0t24,1,0)+ IF( SELF.Diff_carrier_percprov90_slope_0t6,1,0)+ IF( SELF.Diff_carrier_percprov90_slope_6t12,1,0)+ IF( SELF.Diff_carrier_percprovoutstanding_adjustedslope_0t12,1,0)+ IF( SELF.Diff_bldgmats_monthsoutstanding_slope24,1,0)+ IF( SELF.Diff_bldgmats_percprov30_slope_0t12,1,0)+ IF( SELF.Diff_bldgmats_percprov30_slope_6t12,1,0)+ IF( SELF.Diff_bldgmats_percprov60_slope_0t12,1,0)+ IF( SELF.Diff_bldgmats_percprov60_slope_6t12,1,0)+ IF( SELF.Diff_bldgmats_percprov90_slope_0t24,1,0)+ IF( SELF.Diff_bldgmats_percprov90_slope_0t6,1,0)+ IF( SELF.Diff_bldgmats_percprov90_slope_6t12,1,0)+ IF( SELF.Diff_bldgmats_percprovoutstanding_adjustedslope_0t12,1,0)+ IF( SELF.Diff_top5_monthsoutstanding_slope24,1,0)+ IF( SELF.Diff_top5_percprov30_slope_0t12,1,0)+ IF( SELF.Diff_top5_percprov30_slope_6t12,1,0)+ IF( SELF.Diff_top5_percprov60_slope_0t12,1,0)+ IF( SELF.Diff_top5_percprov60_slope_6t12,1,0)+ IF( SELF.Diff_top5_percprov90_slope_0t24,1,0)+ IF( SELF.Diff_top5_percprov90_slope_0t6,1,0)+ IF( SELF.Diff_top5_percprov90_slope_6t12,1,0)+ IF( SELF.Diff_top5_percprovoutstanding_adjustedslope_0t12,1,0);
  END;
// Now need to remove bad pivots from comparison
#uniquename(L)
  %L% := JOIN(in_left,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(R)
  %R% := JOIN(in_right,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(DiffL)
  %DiffL% := JOIN(%L%,%R%,evaluate(left,pivot_exp)=evaluate(right,pivot_exp),%fd%(left,right),hash);
#uniquename(Closest)
  %Closest% := DEDUP(SORT(%DiffL%,Val,Num_Diffs,local),Val,local); // Join will have distributed by pivot_exp
#uniquename(AggRec)
  %AggRec% := RECORD
    Count_Diff_ultimate_linkid := COUNT(GROUP,%Closest%.Diff_ultimate_linkid);
    Count_Diff_cortera_score := COUNT(GROUP,%Closest%.Diff_cortera_score);
    Count_Diff_cpr_score := COUNT(GROUP,%Closest%.Diff_cpr_score);
    Count_Diff_cpr_segment := COUNT(GROUP,%Closest%.Diff_cpr_segment);
    Count_Diff_dbt := COUNT(GROUP,%Closest%.Diff_dbt);
    Count_Diff_avg_bal := COUNT(GROUP,%Closest%.Diff_avg_bal);
    Count_Diff_air_spend := COUNT(GROUP,%Closest%.Diff_air_spend);
    Count_Diff_fuel_spend := COUNT(GROUP,%Closest%.Diff_fuel_spend);
    Count_Diff_leasing_spend := COUNT(GROUP,%Closest%.Diff_leasing_spend);
    Count_Diff_ltl_spend := COUNT(GROUP,%Closest%.Diff_ltl_spend);
    Count_Diff_rail_spend := COUNT(GROUP,%Closest%.Diff_rail_spend);
    Count_Diff_tl_spend := COUNT(GROUP,%Closest%.Diff_tl_spend);
    Count_Diff_transvc_spend := COUNT(GROUP,%Closest%.Diff_transvc_spend);
    Count_Diff_transup_spend := COUNT(GROUP,%Closest%.Diff_transup_spend);
    Count_Diff_bst_spend := COUNT(GROUP,%Closest%.Diff_bst_spend);
    Count_Diff_dg_spend := COUNT(GROUP,%Closest%.Diff_dg_spend);
    Count_Diff_electrical_spend := COUNT(GROUP,%Closest%.Diff_electrical_spend);
    Count_Diff_hvac_spend := COUNT(GROUP,%Closest%.Diff_hvac_spend);
    Count_Diff_other_b_spend := COUNT(GROUP,%Closest%.Diff_other_b_spend);
    Count_Diff_plumbing_spend := COUNT(GROUP,%Closest%.Diff_plumbing_spend);
    Count_Diff_rs_spend := COUNT(GROUP,%Closest%.Diff_rs_spend);
    Count_Diff_wp_spend := COUNT(GROUP,%Closest%.Diff_wp_spend);
    Count_Diff_chemical_spend := COUNT(GROUP,%Closest%.Diff_chemical_spend);
    Count_Diff_electronic_spend := COUNT(GROUP,%Closest%.Diff_electronic_spend);
    Count_Diff_metal_spend := COUNT(GROUP,%Closest%.Diff_metal_spend);
    Count_Diff_other_m_spend := COUNT(GROUP,%Closest%.Diff_other_m_spend);
    Count_Diff_packaging_spend := COUNT(GROUP,%Closest%.Diff_packaging_spend);
    Count_Diff_pvf_spend := COUNT(GROUP,%Closest%.Diff_pvf_spend);
    Count_Diff_plastic_spend := COUNT(GROUP,%Closest%.Diff_plastic_spend);
    Count_Diff_textile_spend := COUNT(GROUP,%Closest%.Diff_textile_spend);
    Count_Diff_bs_spend := COUNT(GROUP,%Closest%.Diff_bs_spend);
    Count_Diff_ce_spend := COUNT(GROUP,%Closest%.Diff_ce_spend);
    Count_Diff_hardware_spend := COUNT(GROUP,%Closest%.Diff_hardware_spend);
    Count_Diff_ie_spend := COUNT(GROUP,%Closest%.Diff_ie_spend);
    Count_Diff_is_spend := COUNT(GROUP,%Closest%.Diff_is_spend);
    Count_Diff_it_spend := COUNT(GROUP,%Closest%.Diff_it_spend);
    Count_Diff_mls_spend := COUNT(GROUP,%Closest%.Diff_mls_spend);
    Count_Diff_os_spend := COUNT(GROUP,%Closest%.Diff_os_spend);
    Count_Diff_pp_spend := COUNT(GROUP,%Closest%.Diff_pp_spend);
    Count_Diff_sis_spend := COUNT(GROUP,%Closest%.Diff_sis_spend);
    Count_Diff_apparel_spend := COUNT(GROUP,%Closest%.Diff_apparel_spend);
    Count_Diff_beverages_spend := COUNT(GROUP,%Closest%.Diff_beverages_spend);
    Count_Diff_constr_spend := COUNT(GROUP,%Closest%.Diff_constr_spend);
    Count_Diff_consulting_spend := COUNT(GROUP,%Closest%.Diff_consulting_spend);
    Count_Diff_fs_spend := COUNT(GROUP,%Closest%.Diff_fs_spend);
    Count_Diff_fp_spend := COUNT(GROUP,%Closest%.Diff_fp_spend);
    Count_Diff_insurance_spend := COUNT(GROUP,%Closest%.Diff_insurance_spend);
    Count_Diff_ls_spend := COUNT(GROUP,%Closest%.Diff_ls_spend);
    Count_Diff_oil_gas_spend := COUNT(GROUP,%Closest%.Diff_oil_gas_spend);
    Count_Diff_utilities_spend := COUNT(GROUP,%Closest%.Diff_utilities_spend);
    Count_Diff_other_spend := COUNT(GROUP,%Closest%.Diff_other_spend);
    Count_Diff_advt_spend := COUNT(GROUP,%Closest%.Diff_advt_spend);
    Count_Diff_air_growth := COUNT(GROUP,%Closest%.Diff_air_growth);
    Count_Diff_fuel_growth := COUNT(GROUP,%Closest%.Diff_fuel_growth);
    Count_Diff_leasing_growth := COUNT(GROUP,%Closest%.Diff_leasing_growth);
    Count_Diff_ltl_growth := COUNT(GROUP,%Closest%.Diff_ltl_growth);
    Count_Diff_rail_growth := COUNT(GROUP,%Closest%.Diff_rail_growth);
    Count_Diff_tl_growth := COUNT(GROUP,%Closest%.Diff_tl_growth);
    Count_Diff_transvc_growth := COUNT(GROUP,%Closest%.Diff_transvc_growth);
    Count_Diff_transup_growth := COUNT(GROUP,%Closest%.Diff_transup_growth);
    Count_Diff_bst_growth := COUNT(GROUP,%Closest%.Diff_bst_growth);
    Count_Diff_dg_growth := COUNT(GROUP,%Closest%.Diff_dg_growth);
    Count_Diff_electrical_growth := COUNT(GROUP,%Closest%.Diff_electrical_growth);
    Count_Diff_hvac_growth := COUNT(GROUP,%Closest%.Diff_hvac_growth);
    Count_Diff_other_b_growth := COUNT(GROUP,%Closest%.Diff_other_b_growth);
    Count_Diff_plumbing_growth := COUNT(GROUP,%Closest%.Diff_plumbing_growth);
    Count_Diff_rs_growth := COUNT(GROUP,%Closest%.Diff_rs_growth);
    Count_Diff_wp_growth := COUNT(GROUP,%Closest%.Diff_wp_growth);
    Count_Diff_chemical_growth := COUNT(GROUP,%Closest%.Diff_chemical_growth);
    Count_Diff_electronic_growth := COUNT(GROUP,%Closest%.Diff_electronic_growth);
    Count_Diff_metal_growth := COUNT(GROUP,%Closest%.Diff_metal_growth);
    Count_Diff_other_m_growth := COUNT(GROUP,%Closest%.Diff_other_m_growth);
    Count_Diff_packaging_growth := COUNT(GROUP,%Closest%.Diff_packaging_growth);
    Count_Diff_pvf_growth := COUNT(GROUP,%Closest%.Diff_pvf_growth);
    Count_Diff_plastic_growth := COUNT(GROUP,%Closest%.Diff_plastic_growth);
    Count_Diff_textile_growth := COUNT(GROUP,%Closest%.Diff_textile_growth);
    Count_Diff_bs_growth := COUNT(GROUP,%Closest%.Diff_bs_growth);
    Count_Diff_ce_growth := COUNT(GROUP,%Closest%.Diff_ce_growth);
    Count_Diff_hardware_growth := COUNT(GROUP,%Closest%.Diff_hardware_growth);
    Count_Diff_ie_growth := COUNT(GROUP,%Closest%.Diff_ie_growth);
    Count_Diff_is_growth := COUNT(GROUP,%Closest%.Diff_is_growth);
    Count_Diff_it_growth := COUNT(GROUP,%Closest%.Diff_it_growth);
    Count_Diff_mls_growth := COUNT(GROUP,%Closest%.Diff_mls_growth);
    Count_Diff_os_growth := COUNT(GROUP,%Closest%.Diff_os_growth);
    Count_Diff_pp_growth := COUNT(GROUP,%Closest%.Diff_pp_growth);
    Count_Diff_sis_growth := COUNT(GROUP,%Closest%.Diff_sis_growth);
    Count_Diff_apparel_growth := COUNT(GROUP,%Closest%.Diff_apparel_growth);
    Count_Diff_beverages_growth := COUNT(GROUP,%Closest%.Diff_beverages_growth);
    Count_Diff_constr_growth := COUNT(GROUP,%Closest%.Diff_constr_growth);
    Count_Diff_consulting_growth := COUNT(GROUP,%Closest%.Diff_consulting_growth);
    Count_Diff_fs_growth := COUNT(GROUP,%Closest%.Diff_fs_growth);
    Count_Diff_fp_growth := COUNT(GROUP,%Closest%.Diff_fp_growth);
    Count_Diff_insurance_growth := COUNT(GROUP,%Closest%.Diff_insurance_growth);
    Count_Diff_ls_growth := COUNT(GROUP,%Closest%.Diff_ls_growth);
    Count_Diff_oil_gas_growth := COUNT(GROUP,%Closest%.Diff_oil_gas_growth);
    Count_Diff_utilities_growth := COUNT(GROUP,%Closest%.Diff_utilities_growth);
    Count_Diff_other_growth := COUNT(GROUP,%Closest%.Diff_other_growth);
    Count_Diff_advt_growth := COUNT(GROUP,%Closest%.Diff_advt_growth);
    Count_Diff_top5_growth := COUNT(GROUP,%Closest%.Diff_top5_growth);
    Count_Diff_shipping_y1 := COUNT(GROUP,%Closest%.Diff_shipping_y1);
    Count_Diff_shipping_growth := COUNT(GROUP,%Closest%.Diff_shipping_growth);
    Count_Diff_materials_y1 := COUNT(GROUP,%Closest%.Diff_materials_y1);
    Count_Diff_materials_growth := COUNT(GROUP,%Closest%.Diff_materials_growth);
    Count_Diff_operations_y1 := COUNT(GROUP,%Closest%.Diff_operations_y1);
    Count_Diff_operations_growth := COUNT(GROUP,%Closest%.Diff_operations_growth);
    Count_Diff_total_paid_average_0t12 := COUNT(GROUP,%Closest%.Diff_total_paid_average_0t12);
    Count_Diff_total_paid_monthspastworst_24 := COUNT(GROUP,%Closest%.Diff_total_paid_monthspastworst_24);
    Count_Diff_total_paid_slope_0t12 := COUNT(GROUP,%Closest%.Diff_total_paid_slope_0t12);
    Count_Diff_total_paid_slope_0t6 := COUNT(GROUP,%Closest%.Diff_total_paid_slope_0t6);
    Count_Diff_total_paid_slope_6t12 := COUNT(GROUP,%Closest%.Diff_total_paid_slope_6t12);
    Count_Diff_total_paid_slope_6t18 := COUNT(GROUP,%Closest%.Diff_total_paid_slope_6t18);
    Count_Diff_total_paid_volatility_0t12 := COUNT(GROUP,%Closest%.Diff_total_paid_volatility_0t12);
    Count_Diff_total_paid_volatility_0t6 := COUNT(GROUP,%Closest%.Diff_total_paid_volatility_0t6);
    Count_Diff_total_paid_volatility_12t18 := COUNT(GROUP,%Closest%.Diff_total_paid_volatility_12t18);
    Count_Diff_total_paid_volatility_6t12 := COUNT(GROUP,%Closest%.Diff_total_paid_volatility_6t12);
    Count_Diff_total_spend_monthspastleast_24 := COUNT(GROUP,%Closest%.Diff_total_spend_monthspastleast_24);
    Count_Diff_total_spend_monthspastmost_24 := COUNT(GROUP,%Closest%.Diff_total_spend_monthspastmost_24);
    Count_Diff_total_spend_slope_0t12 := COUNT(GROUP,%Closest%.Diff_total_spend_slope_0t12);
    Count_Diff_total_spend_slope_0t24 := COUNT(GROUP,%Closest%.Diff_total_spend_slope_0t24);
    Count_Diff_total_spend_slope_0t6 := COUNT(GROUP,%Closest%.Diff_total_spend_slope_0t6);
    Count_Diff_total_spend_slope_6t12 := COUNT(GROUP,%Closest%.Diff_total_spend_slope_6t12);
    Count_Diff_total_spend_sum_12 := COUNT(GROUP,%Closest%.Diff_total_spend_sum_12);
    Count_Diff_total_spend_volatility_0t12 := COUNT(GROUP,%Closest%.Diff_total_spend_volatility_0t12);
    Count_Diff_total_spend_volatility_0t6 := COUNT(GROUP,%Closest%.Diff_total_spend_volatility_0t6);
    Count_Diff_total_spend_volatility_12t18 := COUNT(GROUP,%Closest%.Diff_total_spend_volatility_12t18);
    Count_Diff_total_spend_volatility_6t12 := COUNT(GROUP,%Closest%.Diff_total_spend_volatility_6t12);
    Count_Diff_mfgmat_paid_average_12 := COUNT(GROUP,%Closest%.Diff_mfgmat_paid_average_12);
    Count_Diff_mfgmat_paid_monthspastworst_24 := COUNT(GROUP,%Closest%.Diff_mfgmat_paid_monthspastworst_24);
    Count_Diff_mfgmat_paid_slope_0t12 := COUNT(GROUP,%Closest%.Diff_mfgmat_paid_slope_0t12);
    Count_Diff_mfgmat_paid_slope_0t24 := COUNT(GROUP,%Closest%.Diff_mfgmat_paid_slope_0t24);
    Count_Diff_mfgmat_paid_slope_0t6 := COUNT(GROUP,%Closest%.Diff_mfgmat_paid_slope_0t6);
    Count_Diff_mfgmat_paid_volatility_0t12 := COUNT(GROUP,%Closest%.Diff_mfgmat_paid_volatility_0t12);
    Count_Diff_mfgmat_paid_volatility_0t6 := COUNT(GROUP,%Closest%.Diff_mfgmat_paid_volatility_0t6);
    Count_Diff_mfgmat_spend_monthspastleast_24 := COUNT(GROUP,%Closest%.Diff_mfgmat_spend_monthspastleast_24);
    Count_Diff_mfgmat_spend_monthspastmost_24 := COUNT(GROUP,%Closest%.Diff_mfgmat_spend_monthspastmost_24);
    Count_Diff_mfgmat_spend_slope_0t12 := COUNT(GROUP,%Closest%.Diff_mfgmat_spend_slope_0t12);
    Count_Diff_mfgmat_spend_slope_0t24 := COUNT(GROUP,%Closest%.Diff_mfgmat_spend_slope_0t24);
    Count_Diff_mfgmat_spend_slope_0t6 := COUNT(GROUP,%Closest%.Diff_mfgmat_spend_slope_0t6);
    Count_Diff_mfgmat_spend_sum_12 := COUNT(GROUP,%Closest%.Diff_mfgmat_spend_sum_12);
    Count_Diff_mfgmat_spend_volatility_0t6 := COUNT(GROUP,%Closest%.Diff_mfgmat_spend_volatility_0t6);
    Count_Diff_mfgmat_spend_volatility_6t12 := COUNT(GROUP,%Closest%.Diff_mfgmat_spend_volatility_6t12);
    Count_Diff_ops_paid_average_12 := COUNT(GROUP,%Closest%.Diff_ops_paid_average_12);
    Count_Diff_ops_paid_monthspastworst_24 := COUNT(GROUP,%Closest%.Diff_ops_paid_monthspastworst_24);
    Count_Diff_ops_paid_slope_0t12 := COUNT(GROUP,%Closest%.Diff_ops_paid_slope_0t12);
    Count_Diff_ops_paid_slope_0t24 := COUNT(GROUP,%Closest%.Diff_ops_paid_slope_0t24);
    Count_Diff_ops_paid_slope_0t6 := COUNT(GROUP,%Closest%.Diff_ops_paid_slope_0t6);
    Count_Diff_ops_paid_volatility_0t12 := COUNT(GROUP,%Closest%.Diff_ops_paid_volatility_0t12);
    Count_Diff_ops_paid_volatility_0t6 := COUNT(GROUP,%Closest%.Diff_ops_paid_volatility_0t6);
    Count_Diff_ops_spend_monthspastleast_24 := COUNT(GROUP,%Closest%.Diff_ops_spend_monthspastleast_24);
    Count_Diff_ops_spend_monthspastmost_24 := COUNT(GROUP,%Closest%.Diff_ops_spend_monthspastmost_24);
    Count_Diff_ops_spend_slope_0t12 := COUNT(GROUP,%Closest%.Diff_ops_spend_slope_0t12);
    Count_Diff_ops_spend_slope_0t24 := COUNT(GROUP,%Closest%.Diff_ops_spend_slope_0t24);
    Count_Diff_ops_spend_slope_0t6 := COUNT(GROUP,%Closest%.Diff_ops_spend_slope_0t6);
    Count_Diff_ops_spend_sum_12 := COUNT(GROUP,%Closest%.Diff_ops_spend_sum_12);
    Count_Diff_ops_spend_volatility_0t6 := COUNT(GROUP,%Closest%.Diff_ops_spend_volatility_0t6);
    Count_Diff_ops_spend_volatility_6t12 := COUNT(GROUP,%Closest%.Diff_ops_spend_volatility_6t12);
    Count_Diff_fleet_paid_average_12 := COUNT(GROUP,%Closest%.Diff_fleet_paid_average_12);
    Count_Diff_fleet_paid_monthspastworst_24 := COUNT(GROUP,%Closest%.Diff_fleet_paid_monthspastworst_24);
    Count_Diff_fleet_paid_slope_0t12 := COUNT(GROUP,%Closest%.Diff_fleet_paid_slope_0t12);
    Count_Diff_fleet_paid_slope_0t24 := COUNT(GROUP,%Closest%.Diff_fleet_paid_slope_0t24);
    Count_Diff_fleet_paid_slope_0t6 := COUNT(GROUP,%Closest%.Diff_fleet_paid_slope_0t6);
    Count_Diff_fleet_paid_volatility_0t12 := COUNT(GROUP,%Closest%.Diff_fleet_paid_volatility_0t12);
    Count_Diff_fleet_paid_volatility_0t6 := COUNT(GROUP,%Closest%.Diff_fleet_paid_volatility_0t6);
    Count_Diff_fleet_spend_monthspastleast_24 := COUNT(GROUP,%Closest%.Diff_fleet_spend_monthspastleast_24);
    Count_Diff_fleet_spend_monthspastmost_24 := COUNT(GROUP,%Closest%.Diff_fleet_spend_monthspastmost_24);
    Count_Diff_fleet_spend_slope_0t12 := COUNT(GROUP,%Closest%.Diff_fleet_spend_slope_0t12);
    Count_Diff_fleet_spend_slope_0t24 := COUNT(GROUP,%Closest%.Diff_fleet_spend_slope_0t24);
    Count_Diff_fleet_spend_slope_0t6 := COUNT(GROUP,%Closest%.Diff_fleet_spend_slope_0t6);
    Count_Diff_fleet_spend_sum_12 := COUNT(GROUP,%Closest%.Diff_fleet_spend_sum_12);
    Count_Diff_fleet_spend_volatility_0t6 := COUNT(GROUP,%Closest%.Diff_fleet_spend_volatility_0t6);
    Count_Diff_fleet_spend_volatility_6t12 := COUNT(GROUP,%Closest%.Diff_fleet_spend_volatility_6t12);
    Count_Diff_carrier_paid_average_12 := COUNT(GROUP,%Closest%.Diff_carrier_paid_average_12);
    Count_Diff_carrier_paid_monthspastworst_24 := COUNT(GROUP,%Closest%.Diff_carrier_paid_monthspastworst_24);
    Count_Diff_carrier_paid_slope_0t12 := COUNT(GROUP,%Closest%.Diff_carrier_paid_slope_0t12);
    Count_Diff_carrier_paid_slope_0t24 := COUNT(GROUP,%Closest%.Diff_carrier_paid_slope_0t24);
    Count_Diff_carrier_paid_slope_0t6 := COUNT(GROUP,%Closest%.Diff_carrier_paid_slope_0t6);
    Count_Diff_carrier_paid_volatility_0t12 := COUNT(GROUP,%Closest%.Diff_carrier_paid_volatility_0t12);
    Count_Diff_carrier_paid_volatility_0t6 := COUNT(GROUP,%Closest%.Diff_carrier_paid_volatility_0t6);
    Count_Diff_carrier_spend_monthspastleast_24 := COUNT(GROUP,%Closest%.Diff_carrier_spend_monthspastleast_24);
    Count_Diff_carrier_spend_monthspastmost_24 := COUNT(GROUP,%Closest%.Diff_carrier_spend_monthspastmost_24);
    Count_Diff_carrier_spend_slope_0t12 := COUNT(GROUP,%Closest%.Diff_carrier_spend_slope_0t12);
    Count_Diff_carrier_spend_slope_0t24 := COUNT(GROUP,%Closest%.Diff_carrier_spend_slope_0t24);
    Count_Diff_carrier_spend_slope_0t6 := COUNT(GROUP,%Closest%.Diff_carrier_spend_slope_0t6);
    Count_Diff_carrier_spend_sum_12 := COUNT(GROUP,%Closest%.Diff_carrier_spend_sum_12);
    Count_Diff_carrier_spend_volatility_0t6 := COUNT(GROUP,%Closest%.Diff_carrier_spend_volatility_0t6);
    Count_Diff_carrier_spend_volatility_6t12 := COUNT(GROUP,%Closest%.Diff_carrier_spend_volatility_6t12);
    Count_Diff_bldgmats_paid_average_12 := COUNT(GROUP,%Closest%.Diff_bldgmats_paid_average_12);
    Count_Diff_bldgmats_paid_monthspastworst_24 := COUNT(GROUP,%Closest%.Diff_bldgmats_paid_monthspastworst_24);
    Count_Diff_bldgmats_paid_slope_0t12 := COUNT(GROUP,%Closest%.Diff_bldgmats_paid_slope_0t12);
    Count_Diff_bldgmats_paid_slope_0t24 := COUNT(GROUP,%Closest%.Diff_bldgmats_paid_slope_0t24);
    Count_Diff_bldgmats_paid_slope_0t6 := COUNT(GROUP,%Closest%.Diff_bldgmats_paid_slope_0t6);
    Count_Diff_bldgmats_paid_volatility_0t12 := COUNT(GROUP,%Closest%.Diff_bldgmats_paid_volatility_0t12);
    Count_Diff_bldgmats_paid_volatility_0t6 := COUNT(GROUP,%Closest%.Diff_bldgmats_paid_volatility_0t6);
    Count_Diff_bldgmats_spend_monthspastleast_24 := COUNT(GROUP,%Closest%.Diff_bldgmats_spend_monthspastleast_24);
    Count_Diff_bldgmats_spend_monthspastmost_24 := COUNT(GROUP,%Closest%.Diff_bldgmats_spend_monthspastmost_24);
    Count_Diff_bldgmats_spend_slope_0t12 := COUNT(GROUP,%Closest%.Diff_bldgmats_spend_slope_0t12);
    Count_Diff_bldgmats_spend_slope_0t24 := COUNT(GROUP,%Closest%.Diff_bldgmats_spend_slope_0t24);
    Count_Diff_bldgmats_spend_slope_0t6 := COUNT(GROUP,%Closest%.Diff_bldgmats_spend_slope_0t6);
    Count_Diff_bldgmats_spend_sum_12 := COUNT(GROUP,%Closest%.Diff_bldgmats_spend_sum_12);
    Count_Diff_bldgmats_spend_volatility_0t6 := COUNT(GROUP,%Closest%.Diff_bldgmats_spend_volatility_0t6);
    Count_Diff_bldgmats_spend_volatility_6t12 := COUNT(GROUP,%Closest%.Diff_bldgmats_spend_volatility_6t12);
    Count_Diff_top5_paid_average_12 := COUNT(GROUP,%Closest%.Diff_top5_paid_average_12);
    Count_Diff_top5_paid_monthspastworst_24 := COUNT(GROUP,%Closest%.Diff_top5_paid_monthspastworst_24);
    Count_Diff_top5_paid_slope_0t12 := COUNT(GROUP,%Closest%.Diff_top5_paid_slope_0t12);
    Count_Diff_top5_paid_slope_0t24 := COUNT(GROUP,%Closest%.Diff_top5_paid_slope_0t24);
    Count_Diff_top5_paid_slope_0t6 := COUNT(GROUP,%Closest%.Diff_top5_paid_slope_0t6);
    Count_Diff_top5_paid_volatility_0t12 := COUNT(GROUP,%Closest%.Diff_top5_paid_volatility_0t12);
    Count_Diff_top5_paid_volatility_0t6 := COUNT(GROUP,%Closest%.Diff_top5_paid_volatility_0t6);
    Count_Diff_top5_spend_monthspastleast_24 := COUNT(GROUP,%Closest%.Diff_top5_spend_monthspastleast_24);
    Count_Diff_top5_spend_monthspastmost_24 := COUNT(GROUP,%Closest%.Diff_top5_spend_monthspastmost_24);
    Count_Diff_top5_spend_slope_0t12 := COUNT(GROUP,%Closest%.Diff_top5_spend_slope_0t12);
    Count_Diff_top5_spend_slope_0t24 := COUNT(GROUP,%Closest%.Diff_top5_spend_slope_0t24);
    Count_Diff_top5_spend_slope_0t6 := COUNT(GROUP,%Closest%.Diff_top5_spend_slope_0t6);
    Count_Diff_top5_spend_sum_12 := COUNT(GROUP,%Closest%.Diff_top5_spend_sum_12);
    Count_Diff_top5_spend_volatility_0t6 := COUNT(GROUP,%Closest%.Diff_top5_spend_volatility_0t6);
    Count_Diff_top5_spend_volatility_6t12 := COUNT(GROUP,%Closest%.Diff_top5_spend_volatility_6t12);
    Count_Diff_total_numrel_avg12 := COUNT(GROUP,%Closest%.Diff_total_numrel_avg12);
    Count_Diff_total_numrel_monthpspastmost_24 := COUNT(GROUP,%Closest%.Diff_total_numrel_monthpspastmost_24);
    Count_Diff_total_numrel_monthspastleast_24 := COUNT(GROUP,%Closest%.Diff_total_numrel_monthspastleast_24);
    Count_Diff_total_numrel_slope_0t12 := COUNT(GROUP,%Closest%.Diff_total_numrel_slope_0t12);
    Count_Diff_total_numrel_slope_0t24 := COUNT(GROUP,%Closest%.Diff_total_numrel_slope_0t24);
    Count_Diff_total_numrel_slope_0t6 := COUNT(GROUP,%Closest%.Diff_total_numrel_slope_0t6);
    Count_Diff_total_numrel_slope_6t12 := COUNT(GROUP,%Closest%.Diff_total_numrel_slope_6t12);
    Count_Diff_total_numrel_var_0t12 := COUNT(GROUP,%Closest%.Diff_total_numrel_var_0t12);
    Count_Diff_total_numrel_var_0t24 := COUNT(GROUP,%Closest%.Diff_total_numrel_var_0t24);
    Count_Diff_total_numrel_var_12t24 := COUNT(GROUP,%Closest%.Diff_total_numrel_var_12t24);
    Count_Diff_total_numrel_var_6t18 := COUNT(GROUP,%Closest%.Diff_total_numrel_var_6t18);
    Count_Diff_mfgmat_numrel_avg12 := COUNT(GROUP,%Closest%.Diff_mfgmat_numrel_avg12);
    Count_Diff_mfgmat_numrel_slope_0t12 := COUNT(GROUP,%Closest%.Diff_mfgmat_numrel_slope_0t12);
    Count_Diff_mfgmat_numrel_slope_0t24 := COUNT(GROUP,%Closest%.Diff_mfgmat_numrel_slope_0t24);
    Count_Diff_mfgmat_numrel_slope_0t6 := COUNT(GROUP,%Closest%.Diff_mfgmat_numrel_slope_0t6);
    Count_Diff_mfgmat_numrel_slope_6t12 := COUNT(GROUP,%Closest%.Diff_mfgmat_numrel_slope_6t12);
    Count_Diff_mfgmat_numrel_var_0t12 := COUNT(GROUP,%Closest%.Diff_mfgmat_numrel_var_0t12);
    Count_Diff_mfgmat_numrel_var_12t24 := COUNT(GROUP,%Closest%.Diff_mfgmat_numrel_var_12t24);
    Count_Diff_ops_numrel_avg12 := COUNT(GROUP,%Closest%.Diff_ops_numrel_avg12);
    Count_Diff_ops_numrel_slope_0t12 := COUNT(GROUP,%Closest%.Diff_ops_numrel_slope_0t12);
    Count_Diff_ops_numrel_slope_0t24 := COUNT(GROUP,%Closest%.Diff_ops_numrel_slope_0t24);
    Count_Diff_ops_numrel_slope_0t6 := COUNT(GROUP,%Closest%.Diff_ops_numrel_slope_0t6);
    Count_Diff_ops_numrel_slope_6t12 := COUNT(GROUP,%Closest%.Diff_ops_numrel_slope_6t12);
    Count_Diff_ops_numrel_var_0t12 := COUNT(GROUP,%Closest%.Diff_ops_numrel_var_0t12);
    Count_Diff_ops_numrel_var_12t24 := COUNT(GROUP,%Closest%.Diff_ops_numrel_var_12t24);
    Count_Diff_fleet_numrel_avg12 := COUNT(GROUP,%Closest%.Diff_fleet_numrel_avg12);
    Count_Diff_fleet_numrel_slope_0t12 := COUNT(GROUP,%Closest%.Diff_fleet_numrel_slope_0t12);
    Count_Diff_fleet_numrel_slope_0t24 := COUNT(GROUP,%Closest%.Diff_fleet_numrel_slope_0t24);
    Count_Diff_fleet_numrel_slope_0t6 := COUNT(GROUP,%Closest%.Diff_fleet_numrel_slope_0t6);
    Count_Diff_fleet_numrel_slope_6t12 := COUNT(GROUP,%Closest%.Diff_fleet_numrel_slope_6t12);
    Count_Diff_fleet_numrel_var_0t12 := COUNT(GROUP,%Closest%.Diff_fleet_numrel_var_0t12);
    Count_Diff_fleet_numrel_var_12t24 := COUNT(GROUP,%Closest%.Diff_fleet_numrel_var_12t24);
    Count_Diff_carrier_numrel_avg12 := COUNT(GROUP,%Closest%.Diff_carrier_numrel_avg12);
    Count_Diff_carrier_numrel_slope_0t12 := COUNT(GROUP,%Closest%.Diff_carrier_numrel_slope_0t12);
    Count_Diff_carrier_numrel_slope_0t24 := COUNT(GROUP,%Closest%.Diff_carrier_numrel_slope_0t24);
    Count_Diff_carrier_numrel_slope_0t6 := COUNT(GROUP,%Closest%.Diff_carrier_numrel_slope_0t6);
    Count_Diff_carrier_numrel_slope_6t12 := COUNT(GROUP,%Closest%.Diff_carrier_numrel_slope_6t12);
    Count_Diff_carrier_numrel_var_0t12 := COUNT(GROUP,%Closest%.Diff_carrier_numrel_var_0t12);
    Count_Diff_carrier_numrel_var_12t24 := COUNT(GROUP,%Closest%.Diff_carrier_numrel_var_12t24);
    Count_Diff_bldgmats_numrel_avg12 := COUNT(GROUP,%Closest%.Diff_bldgmats_numrel_avg12);
    Count_Diff_bldgmats_numrel_slope_0t12 := COUNT(GROUP,%Closest%.Diff_bldgmats_numrel_slope_0t12);
    Count_Diff_bldgmats_numrel_slope_0t24 := COUNT(GROUP,%Closest%.Diff_bldgmats_numrel_slope_0t24);
    Count_Diff_bldgmats_numrel_slope_0t6 := COUNT(GROUP,%Closest%.Diff_bldgmats_numrel_slope_0t6);
    Count_Diff_bldgmats_numrel_slope_6t12 := COUNT(GROUP,%Closest%.Diff_bldgmats_numrel_slope_6t12);
    Count_Diff_bldgmats_numrel_var_0t12 := COUNT(GROUP,%Closest%.Diff_bldgmats_numrel_var_0t12);
    Count_Diff_bldgmats_numrel_var_12t24 := COUNT(GROUP,%Closest%.Diff_bldgmats_numrel_var_12t24);
    Count_Diff_total_monthsoutstanding_slope24 := COUNT(GROUP,%Closest%.Diff_total_monthsoutstanding_slope24);
    Count_Diff_total_percprov30_avg_0t12 := COUNT(GROUP,%Closest%.Diff_total_percprov30_avg_0t12);
    Count_Diff_total_percprov30_slope_0t12 := COUNT(GROUP,%Closest%.Diff_total_percprov30_slope_0t12);
    Count_Diff_total_percprov30_slope_0t24 := COUNT(GROUP,%Closest%.Diff_total_percprov30_slope_0t24);
    Count_Diff_total_percprov30_slope_0t6 := COUNT(GROUP,%Closest%.Diff_total_percprov30_slope_0t6);
    Count_Diff_total_percprov30_slope_6t12 := COUNT(GROUP,%Closest%.Diff_total_percprov30_slope_6t12);
    Count_Diff_total_percprov60_avg_0t12 := COUNT(GROUP,%Closest%.Diff_total_percprov60_avg_0t12);
    Count_Diff_total_percprov60_slope_0t12 := COUNT(GROUP,%Closest%.Diff_total_percprov60_slope_0t12);
    Count_Diff_total_percprov60_slope_0t24 := COUNT(GROUP,%Closest%.Diff_total_percprov60_slope_0t24);
    Count_Diff_total_percprov60_slope_0t6 := COUNT(GROUP,%Closest%.Diff_total_percprov60_slope_0t6);
    Count_Diff_total_percprov60_slope_6t12 := COUNT(GROUP,%Closest%.Diff_total_percprov60_slope_6t12);
    Count_Diff_total_percprov90_avg_0t12 := COUNT(GROUP,%Closest%.Diff_total_percprov90_avg_0t12);
    Count_Diff_total_percprov90_lowerlim_0t12 := COUNT(GROUP,%Closest%.Diff_total_percprov90_lowerlim_0t12);
    Count_Diff_total_percprov90_slope_0t24 := COUNT(GROUP,%Closest%.Diff_total_percprov90_slope_0t24);
    Count_Diff_total_percprov90_slope_0t6 := COUNT(GROUP,%Closest%.Diff_total_percprov90_slope_0t6);
    Count_Diff_total_percprov90_slope_6t12 := COUNT(GROUP,%Closest%.Diff_total_percprov90_slope_6t12);
    Count_Diff_total_percprovoutstanding_adjustedslope_0t12 := COUNT(GROUP,%Closest%.Diff_total_percprovoutstanding_adjustedslope_0t12);
    Count_Diff_mfgmat_monthsoutstanding_slope24 := COUNT(GROUP,%Closest%.Diff_mfgmat_monthsoutstanding_slope24);
    Count_Diff_mfgmat_percprov30_slope_0t12 := COUNT(GROUP,%Closest%.Diff_mfgmat_percprov30_slope_0t12);
    Count_Diff_mfgmat_percprov30_slope_6t12 := COUNT(GROUP,%Closest%.Diff_mfgmat_percprov30_slope_6t12);
    Count_Diff_mfgmat_percprov60_slope_0t12 := COUNT(GROUP,%Closest%.Diff_mfgmat_percprov60_slope_0t12);
    Count_Diff_mfgmat_percprov60_slope_6t12 := COUNT(GROUP,%Closest%.Diff_mfgmat_percprov60_slope_6t12);
    Count_Diff_mfgmat_percprov90_slope_0t24 := COUNT(GROUP,%Closest%.Diff_mfgmat_percprov90_slope_0t24);
    Count_Diff_mfgmat_percprov90_slope_0t6 := COUNT(GROUP,%Closest%.Diff_mfgmat_percprov90_slope_0t6);
    Count_Diff_mfgmat_percprov90_slope_6t12 := COUNT(GROUP,%Closest%.Diff_mfgmat_percprov90_slope_6t12);
    Count_Diff_mfgmat_percprovoutstanding_adjustedslope_0t12 := COUNT(GROUP,%Closest%.Diff_mfgmat_percprovoutstanding_adjustedslope_0t12);
    Count_Diff_ops_monthsoutstanding_slope24 := COUNT(GROUP,%Closest%.Diff_ops_monthsoutstanding_slope24);
    Count_Diff_ops_percprov30_slope_0t12 := COUNT(GROUP,%Closest%.Diff_ops_percprov30_slope_0t12);
    Count_Diff_ops_percprov30_slope_6t12 := COUNT(GROUP,%Closest%.Diff_ops_percprov30_slope_6t12);
    Count_Diff_ops_percprov60_slope_0t12 := COUNT(GROUP,%Closest%.Diff_ops_percprov60_slope_0t12);
    Count_Diff_ops_percprov60_slope_6t12 := COUNT(GROUP,%Closest%.Diff_ops_percprov60_slope_6t12);
    Count_Diff_ops_percprov90_slope_0t24 := COUNT(GROUP,%Closest%.Diff_ops_percprov90_slope_0t24);
    Count_Diff_ops_percprov90_slope_0t6 := COUNT(GROUP,%Closest%.Diff_ops_percprov90_slope_0t6);
    Count_Diff_ops_percprov90_slope_6t12 := COUNT(GROUP,%Closest%.Diff_ops_percprov90_slope_6t12);
    Count_Diff_ops_percprovoutstanding_adjustedslope_0t12 := COUNT(GROUP,%Closest%.Diff_ops_percprovoutstanding_adjustedslope_0t12);
    Count_Diff_fleet_monthsoutstanding_slope24 := COUNT(GROUP,%Closest%.Diff_fleet_monthsoutstanding_slope24);
    Count_Diff_fleet_percprov30_slope_0t12 := COUNT(GROUP,%Closest%.Diff_fleet_percprov30_slope_0t12);
    Count_Diff_fleet_percprov30_slope_6t12 := COUNT(GROUP,%Closest%.Diff_fleet_percprov30_slope_6t12);
    Count_Diff_fleet_percprov60_slope_0t12 := COUNT(GROUP,%Closest%.Diff_fleet_percprov60_slope_0t12);
    Count_Diff_fleet_percprov60_slope_6t12 := COUNT(GROUP,%Closest%.Diff_fleet_percprov60_slope_6t12);
    Count_Diff_fleet_percprov90_slope_0t24 := COUNT(GROUP,%Closest%.Diff_fleet_percprov90_slope_0t24);
    Count_Diff_fleet_percprov90_slope_0t6 := COUNT(GROUP,%Closest%.Diff_fleet_percprov90_slope_0t6);
    Count_Diff_fleet_percprov90_slope_6t12 := COUNT(GROUP,%Closest%.Diff_fleet_percprov90_slope_6t12);
    Count_Diff_fleet_percprovoutstanding_adjustedslope_0t12 := COUNT(GROUP,%Closest%.Diff_fleet_percprovoutstanding_adjustedslope_0t12);
    Count_Diff_carrier_monthsoutstanding_slope24 := COUNT(GROUP,%Closest%.Diff_carrier_monthsoutstanding_slope24);
    Count_Diff_carrier_percprov30_slope_0t12 := COUNT(GROUP,%Closest%.Diff_carrier_percprov30_slope_0t12);
    Count_Diff_carrier_percprov30_slope_6t12 := COUNT(GROUP,%Closest%.Diff_carrier_percprov30_slope_6t12);
    Count_Diff_carrier_percprov60_slope_0t12 := COUNT(GROUP,%Closest%.Diff_carrier_percprov60_slope_0t12);
    Count_Diff_carrier_percprov60_slope_6t12 := COUNT(GROUP,%Closest%.Diff_carrier_percprov60_slope_6t12);
    Count_Diff_carrier_percprov90_slope_0t24 := COUNT(GROUP,%Closest%.Diff_carrier_percprov90_slope_0t24);
    Count_Diff_carrier_percprov90_slope_0t6 := COUNT(GROUP,%Closest%.Diff_carrier_percprov90_slope_0t6);
    Count_Diff_carrier_percprov90_slope_6t12 := COUNT(GROUP,%Closest%.Diff_carrier_percprov90_slope_6t12);
    Count_Diff_carrier_percprovoutstanding_adjustedslope_0t12 := COUNT(GROUP,%Closest%.Diff_carrier_percprovoutstanding_adjustedslope_0t12);
    Count_Diff_bldgmats_monthsoutstanding_slope24 := COUNT(GROUP,%Closest%.Diff_bldgmats_monthsoutstanding_slope24);
    Count_Diff_bldgmats_percprov30_slope_0t12 := COUNT(GROUP,%Closest%.Diff_bldgmats_percprov30_slope_0t12);
    Count_Diff_bldgmats_percprov30_slope_6t12 := COUNT(GROUP,%Closest%.Diff_bldgmats_percprov30_slope_6t12);
    Count_Diff_bldgmats_percprov60_slope_0t12 := COUNT(GROUP,%Closest%.Diff_bldgmats_percprov60_slope_0t12);
    Count_Diff_bldgmats_percprov60_slope_6t12 := COUNT(GROUP,%Closest%.Diff_bldgmats_percprov60_slope_6t12);
    Count_Diff_bldgmats_percprov90_slope_0t24 := COUNT(GROUP,%Closest%.Diff_bldgmats_percprov90_slope_0t24);
    Count_Diff_bldgmats_percprov90_slope_0t6 := COUNT(GROUP,%Closest%.Diff_bldgmats_percprov90_slope_0t6);
    Count_Diff_bldgmats_percprov90_slope_6t12 := COUNT(GROUP,%Closest%.Diff_bldgmats_percprov90_slope_6t12);
    Count_Diff_bldgmats_percprovoutstanding_adjustedslope_0t12 := COUNT(GROUP,%Closest%.Diff_bldgmats_percprovoutstanding_adjustedslope_0t12);
    Count_Diff_top5_monthsoutstanding_slope24 := COUNT(GROUP,%Closest%.Diff_top5_monthsoutstanding_slope24);
    Count_Diff_top5_percprov30_slope_0t12 := COUNT(GROUP,%Closest%.Diff_top5_percprov30_slope_0t12);
    Count_Diff_top5_percprov30_slope_6t12 := COUNT(GROUP,%Closest%.Diff_top5_percprov30_slope_6t12);
    Count_Diff_top5_percprov60_slope_0t12 := COUNT(GROUP,%Closest%.Diff_top5_percprov60_slope_0t12);
    Count_Diff_top5_percprov60_slope_6t12 := COUNT(GROUP,%Closest%.Diff_top5_percprov60_slope_6t12);
    Count_Diff_top5_percprov90_slope_0t24 := COUNT(GROUP,%Closest%.Diff_top5_percprov90_slope_0t24);
    Count_Diff_top5_percprov90_slope_0t6 := COUNT(GROUP,%Closest%.Diff_top5_percprov90_slope_0t6);
    Count_Diff_top5_percprov90_slope_6t12 := COUNT(GROUP,%Closest%.Diff_top5_percprov90_slope_6t12);
    Count_Diff_top5_percprovoutstanding_adjustedslope_0t12 := COUNT(GROUP,%Closest%.Diff_top5_percprovoutstanding_adjustedslope_0t12);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
