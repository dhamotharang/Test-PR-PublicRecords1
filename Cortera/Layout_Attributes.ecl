﻿Number := string;
Ratio := string;
EXPORT Layout_Attributes := RECORD

  integer4	ULTIMATE_LINKID;
  string		CORTERA_SCORE;
  string		CPR_SCORE;
  string		CPR_SEGMENT;
  Ratio			DBT;
  Number		AVG_BAL;
  Number		AIR_SPEND;
  Number		FUEL_SPEND; 
  Number		LEASING_SPEND; 
  Number		LTL_SPEND;
  Number		RAIL_SPEND; 
  Number		TL_SPEND; 
  Number		TRANSVC_SPEND; 
  Number		TRANSUP_SPEND; 
  Number		BST_SPEND; 
  Number		DG_SPEND; 
  Number		ELECTRICAL_SPEND; 
  Number		HVAC_SPEND; 
  Number		OTHER_B_SPEND;
  Number		PLUMBING_SPEND; 
  Number		RS_SPEND; 
  Number		WP_SPEND; 
  Number		CHEMICAL_SPEND; 
  Number		ELECTRONIC_SPEND; 
  Number		METAL_SPEND; 
  Number		OTHER_M_SPEND;
  Number		PACKAGING_SPEND; 
  Number		PVF_SPEND; 
  Number		PLASTIC_SPEND; 
  Number		TEXTILE_SPEND; 
  Number		BS_SPEND; 
  Number		CE_SPEND; 
  Number		HARDWARE_SPEND;
	Number		IE_SPEND; 
  Number		IS_SPEND; 
	Number		IT_SPEND; 
  Number		MLS_SPEND; 
  Number		OS_SPEND; 
  Number		PP_SPEND; 
  Number		SIS_SPEND; 
	Number		APPAREL_SPEND; 
  Number		BEVERAGES_SPEND; 
  Number		CONSTR_SPEND; 
  Number		CONSULTING_SPEND; 
  Number		FS_SPEND; 
  Number		FP_SPEND; 
  Number		INSURANCE_SPEND; 
  Number		LS_SPEND; 
  Number		OIL_GAS_SPEND;
  Number		UTILITIES_SPEND; 
	Number		OTHER_SPEND; 
  Number		ADVT_SPEND; 
  Ratio			AIR_GROWTH; 
  Ratio			FUEL_GROWTH; 
  Ratio			LEASING_GROWTH; 
  Ratio			LTL_GROWTH; 
  Ratio			RAIL_GROWTH; 
  Ratio			TL_GROWTH; 
  Ratio			TRANSVC_GROWTH; 
  Ratio			TRANSUP_GROWTH; 
  Ratio			BST_GROWTH; 
  Ratio			DG_GROWTH; 
  Ratio			ELECTRICAL_GROWTH; 
  Ratio			HVAC_GROWTH; 
  Ratio			OTHER_B_GROWTH; 
  Ratio			PLUMBING_GROWTH; 
  Ratio			RS_GROWTH; 
  Ratio			WP_GROWTH; 
  Ratio			CHEMICAL_GROWTH; 
  Ratio			ELECTRONIC_GROWTH; 
  Ratio			METAL_GROWTH; 
  Ratio			OTHER_M_GROWTH;
  Ratio			PACKAGING_GROWTH; 
  Ratio			PVF_GROWTH; 
  Ratio			PLASTIC_GROWTH; 
  Ratio			TEXTILE_GROWTH; 
  Ratio			BS_GROWTH; 
  Ratio			CE_GROWTH; 
  Ratio			HARDWARE_GROWTH; 
  Ratio			IE_GROWTH; 
  Ratio			IS_GROWTH; 
  Ratio			IT_GROWTH; 
  Ratio			MLS_GROWTH; 
  Ratio			OS_GROWTH; 
  Ratio			PP_GROWTH; 
  Ratio			SIS_GROWTH; 
  Ratio			APPAREL_GROWTH; 
  Ratio			BEVERAGES_GROWTH; 
  Ratio			CONSTR_GROWTH; 
  Ratio			CONSULTING_GROWTH; 
  Ratio			FS_GROWTH; 
  Ratio			FP_GROWTH; 
  Ratio			INSURANCE_GROWTH; 
  Ratio			LS_GROWTH; 
  Ratio			OIL_GAS_GROWTH;
  Ratio			UTILITIES_GROWTH; 
  Ratio			OTHER_GROWTH; 
  Ratio			ADVT_GROWTH; 
  Ratio			TOP5_GROWTH; 
  Number		SHIPPING_Y1; 
  Ratio			SHIPPING_GROWTH; 
  Number		MATERIALS_Y1; 
  Ratio			MATERIALS_GROWTH; 
  Number		OPERATIONS_Y1; 
  Ratio			OPERATIONS_GROWTH; 
  Ratio			TOTAL_PAID_AVERAGE_0T12; 
  Ratio			TOTAL_PAID_MONTHSPASTWORST_24; 
  Ratio			TOTAL_PAID_SLOPE_0T12; 
  Ratio			TOTAL_PAID_SLOPE_0T6; 
  Ratio			TOTAL_PAID_SLOPE_6T12; 
  Ratio			TOTAL_PAID_SLOPE_6T18; 
  Ratio			TOTAL_PAID_VOLATILITY_0T12; 
  Ratio			TOTAL_PAID_VOLATILITY_0T6; 
  Ratio			TOTAL_PAID_VOLATILITY_12T18; 
  Ratio			TOTAL_PAID_VOLATILITY_6T12; 
  Number		TOTAL_SPEND_MONTHSPASTLEAST_24; 
  Number		TOTAL_SPEND_MONTHSPASTMOST_24; 
  Ratio			TOTAL_SPEND_SLOPE_0T12; 
  Ratio			TOTAL_SPEND_SLOPE_0T24; 
  Ratio			TOTAL_SPEND_SLOPE_0T6; 
  Ratio			TOTAL_SPEND_SLOPE_6T12; 
  Ratio			TOTAL_SPEND_SUM_12; 
  Ratio			TOTAL_SPEND_VOLATILITY_0T12; 
  Ratio			TOTAL_SPEND_VOLATILITY_0T6; 
  Ratio			TOTAL_SPEND_VOLATILITY_12T18; 
  Ratio			TOTAL_SPEND_VOLATILITY_6T12; 
  Ratio			MFGMAT_PAID_AVERAGE_12; 
  Number		MFGMAT_PAID_MONTHSPASTWORST_24; 
  Ratio			MFGMAT_PAID_SLOPE_0T12; 
  Ratio			MFGMAT_PAID_SLOPE_0T24; 
  Ratio			MFGMAT_PAID_SLOPE_0T6; 
  Ratio			MFGMAT_PAID_VOLATILITY_0T12; 
  Ratio			MFGMAT_PAID_VOLATILITY_0T6; 
  Ratio			MFGMAT_SPEND_MONTHSPASTLEAST_24; 
  Ratio			MFGMAT_SPEND_MONTHSPASTMOST_24; 
  Ratio			MFGMAT_SPEND_SLOPE_0T12; 
  Ratio			MFGMAT_SPEND_SLOPE_0T24; 
  Ratio			MFGMAT_SPEND_SLOPE_0T6; 
  Ratio			MFGMAT_SPEND_SUM_12; 
  Ratio			MFGMAT_SPEND_VOLATILITY_0T6; 
  Ratio			MFGMAT_SPEND_VOLATILITY_6T12; 
  Ratio			OPS_PAID_AVERAGE_12; 
  Ratio			OPS_PAID_MONTHSPASTWORST_24; 
  Ratio			OPS_PAID_SLOPE_0T12; 
  Ratio			OPS_PAID_SLOPE_0T24; 
  Ratio			OPS_PAID_SLOPE_0T6; 
  Ratio			OPS_PAID_VOLATILITY_0T12; 
  Ratio			OPS_PAID_VOLATILITY_0T6; 
  Number		OPS_SPEND_MONTHSPASTLEAST_24; 
  Number		OPS_SPEND_MONTHSPASTMOST_24; 
  Ratio			OPS_SPEND_SLOPE_0T12; 
  Ratio			OPS_SPEND_SLOPE_0T24; 
  Ratio			OPS_SPEND_SLOPE_0T6; 
  Number		OPS_SPEND_SUM_12; 
  Ratio			OPS_SPEND_VOLATILITY_0T6; 
  Ratio			OPS_SPEND_VOLATILITY_6T12; 
  Ratio			FLEET_PAID_AVERAGE_12; 
  Number		FLEET_PAID_MONTHSPASTWORST_24; 
  Ratio			FLEET_PAID_SLOPE_0T12; 
  Ratio			FLEET_PAID_SLOPE_0T24; 
  Ratio			FLEET_PAID_SLOPE_0T6; 
  Ratio			FLEET_PAID_VOLATILITY_0T12; 
  Ratio			FLEET_PAID_VOLATILITY_0T6; 
  Number		FLEET_SPEND_MONTHSPASTLEAST_24; 
  Number		FLEET_SPEND_MONTHSPASTMOST_24; 
  Ratio			FLEET_SPEND_SLOPE_0T12; 
  Ratio			FLEET_SPEND_SLOPE_0T24; 
  Ratio			FLEET_SPEND_SLOPE_0T6; 
  Number		FLEET_SPEND_SUM_12; 
  Ratio			FLEET_SPEND_VOLATILITY_0T6; 
  Ratio			FLEET_SPEND_VOLATILITY_6T12; 
  Ratio			CARRIER_PAID_AVERAGE_12;
  Number		CARRIER_PAID_MONTHSPASTWORST_24; 
  Ratio			CARRIER_PAID_SLOPE_0T12; 
  Ratio			CARRIER_PAID_SLOPE_0T24; 
  Ratio			CARRIER_PAID_SLOPE_0T6; 
  Ratio			CARRIER_PAID_VOLATILITY_0T12; 
  Ratio			CARRIER_PAID_VOLATILITY_0T6; 
  Number		CARRIER_SPEND_MONTHSPASTLEAST_24; 
  Number		CARRIER_SPEND_MONTHSPASTMOST_24; 
  Ratio			CARRIER_SPEND_SLOPE_0T12; 
  Ratio			CARRIER_SPEND_SLOPE_0T24; 
  Ratio			CARRIER_SPEND_SLOPE_0T6; 
  Number		CARRIER_SPEND_SUM_12; 
  Ratio			CARRIER_SPEND_VOLATILITY_0T6; 
  Ratio			CARRIER_SPEND_VOLATILITY_6T12; 
  Ratio			BLDGMATS_PAID_AVERAGE_12; 
  Number		BLDGMATS_PAID_MONTHSPASTWORST_24; 
  Ratio			BLDGMATS_PAID_SLOPE_0T12; 
  Ratio			BLDGMATS_PAID_SLOPE_0T24; 
  Ratio			BLDGMATS_PAID_SLOPE_0T6; 
  Ratio			BLDGMATS_PAID_VOLATILITY_0T12; 
  Ratio			BLDGMATS_PAID_VOLATILITY_0T6; 
  Number		BLDGMATS_SPEND_MONTHSPASTLEAST_24; 
  Number		BLDGMATS_SPEND_MONTHSPASTMOST_24; 
  Ratio			BLDGMATS_SPEND_SLOPE_0T12; 
  Ratio			BLDGMATS_SPEND_SLOPE_0T24; 
  Ratio			BLDGMATS_SPEND_SLOPE_0T6; 
  Number		BLDGMATS_SPEND_SUM_12; 
  Ratio			BLDGMATS_SPEND_VOLATILITY_0T6; 
  Ratio			BLDGMATS_SPEND_VOLATILITY_6T12; 
  Ratio			TOP5_PAID_AVERAGE_12; 
  Number		TOP5_PAID_MONTHSPASTWORST_24; 
  Ratio			TOP5_PAID_SLOPE_0T12; 
  Ratio			TOP5_PAID_SLOPE_0T24; 
	Ratio			TOP5_PAID_SLOPE_0T6; 
  Ratio			TOP5_PAID_VOLATILITY_0T12; 
  Ratio			TOP5_PAID_VOLATILITY_0T6; 
  Number		TOP5_SPEND_MONTHSPASTLEAST_24; 
  Number		TOP5_SPEND_MONTHSPASTMOST_24; 
  Ratio			TOP5_SPEND_SLOPE_0T12; 
  Ratio			TOP5_SPEND_SLOPE_0T24; 
  Ratio			TOP5_SPEND_SLOPE_0T6; 
  Number		TOP5_SPEND_SUM_12; 
  Ratio			TOP5_SPEND_VOLATILITY_0T6; 
  Ratio			TOP5_SPEND_VOLATILITY_6T12; 
  Ratio			TOTAL_NUMREL_AVG12; 
  Number		TOTAL_NUMREL_MONTHPSPASTMOST_24; 
  Number		TOTAL_NUMREL_MONTHSPASTLEAST_24; 
  Ratio			TOTAL_NUMREL_SLOPE_0T12; 
  Ratio			TOTAL_NUMREL_SLOPE_0T24; 
  Ratio			TOTAL_NUMREL_SLOPE_0T6; 
  Ratio			TOTAL_NUMREL_SLOPE_6T12; 
  Ratio			TOTAL_NUMREL_VAR_0T12; 
  Ratio			TOTAL_NUMREL_VAR_0T24; 
  Ratio			TOTAL_NUMREL_VAR_12T24; 
  Ratio			TOTAL_NUMREL_VAR_6T18; 
  Ratio			MFGMAT_NUMREL_AVG12; 
  Ratio			MFGMAT_NUMREL_SLOPE_0T12; 
  Ratio			MFGMAT_NUMREL_SLOPE_0T24; 
  Ratio			MFGMAT_NUMREL_SLOPE_0T6; 
  Ratio			MFGMAT_NUMREL_SLOPE_6T12; 
  Ratio			MFGMAT_NUMREL_VAR_0T12; 
  Ratio			MFGMAT_NUMREL_VAR_12T24; 
  Ratio			OPS_NUMREL_AVG12; 
  Ratio			OPS_NUMREL_SLOPE_0T12; 
  Ratio			OPS_NUMREL_SLOPE_0T24; 
  Ratio			OPS_NUMREL_SLOPE_0T6; 
  Ratio			OPS_NUMREL_SLOPE_6T12; 
  Ratio			OPS_NUMREL_VAR_0T12; 
  Ratio			OPS_NUMREL_VAR_12T24; 
  Ratio			FLEET_NUMREL_AVG12; 
  Ratio			FLEET_NUMREL_SLOPE_0T12; 
  Ratio			FLEET_NUMREL_SLOPE_0T24; 
  Ratio			FLEET_NUMREL_SLOPE_0T6; 
  Ratio			FLEET_NUMREL_SLOPE_6T12; 
  Number		FLEET_NUMREL_VAR_0T12; 
  Ratio			FLEET_NUMREL_VAR_12T24; 
  Ratio			CARRIER_NUMREL_AVG12; 
  Ratio			CARRIER_NUMREL_SLOPE_0T12; 
  Ratio			CARRIER_NUMREL_SLOPE_0T24; 
  Ratio			CARRIER_NUMREL_SLOPE_0T6; 
  Ratio			CARRIER_NUMREL_SLOPE_6T12; 
  Ratio			CARRIER_NUMREL_VAR_0T12; 
  Ratio			CARRIER_NUMREL_VAR_12T24; 
  Ratio			BLDGMATS_NUMREL_AVG12; 
  Ratio			BLDGMATS_NUMREL_SLOPE_0T12; 
  Ratio			BLDGMATS_NUMREL_SLOPE_0T24; 
  Ratio			BLDGMATS_NUMREL_SLOPE_0T6; 
  Ratio			BLDGMATS_NUMREL_SLOPE_6T12; 
  Ratio			BLDGMATS_NUMREL_VAR_0T12; 
  Ratio			BLDGMATS_NUMREL_VAR_12T24; 
  Ratio			TOTAL_MONTHSOUTSTANDING_SLOPE24; 
  Ratio			TOTAL_PERCPROV30_AVG_0T12; 
  Ratio			TOTAL_PERCPROV30_SLOPE_0T12; 
  Ratio			TOTAL_PERCPROV30_SLOPE_0T24; 
  Ratio			TOTAL_PERCPROV30_SLOPE_0T6; 
  Ratio			TOTAL_PERCPROV30_SLOPE_6T12; 
  Ratio			TOTAL_PERCPROV60_AVG_0T12; 
  Ratio			TOTAL_PERCPROV60_SLOPE_0T12; 
  Ratio			TOTAL_PERCPROV60_SLOPE_0T24; 
  Ratio			TOTAL_PERCPROV60_SLOPE_0T6; 
  Ratio			TOTAL_PERCPROV60_SLOPE_6T12; 
  Ratio			TOTAL_PERCPROV90_AVG_0T12; 
  Ratio			TOTAL_PERCPROV90_LOWERLIM_0T12; 
  Ratio			TOTAL_PERCPROV90_SLOPE_0T24; 
  Ratio			TOTAL_PERCPROV90_SLOPE_0T6; 
  Ratio			TOTAL_PERCPROV90_SLOPE_6T12; 
  Ratio			TOTAL_PERCPROVOUTSTANDING_ADJUSTEDSLOPE_0T12; 
  Ratio			MFGMAT_MONTHSOUTSTANDING_SLOPE24; 
  Ratio			MFGMAT_PERCPROV30_SLOPE_0T12; 
  Ratio			MFGMAT_PERCPROV30_SLOPE_6T12; 
  Ratio			MFGMAT_PERCPROV60_SLOPE_0T12; 
  Ratio			MFGMAT_PERCPROV60_SLOPE_6T12; 
  Ratio			MFGMAT_PERCPROV90_SLOPE_0T24; 
  Ratio			MFGMAT_PERCPROV90_SLOPE_0T6; 
  Ratio			MFGMAT_PERCPROV90_SLOPE_6T12; 
  Ratio			MFGMAT_PERCPROVOUTSTANDING_ADJUSTEDSLOPE_0T12; 
  Ratio			OPS_MONTHSOUTSTANDING_SLOPE24; 
  Ratio			OPS_PERCPROV30_SLOPE_0T12; 
  Ratio			OPS_PERCPROV30_SLOPE_6T12; 
  Ratio			OPS_PERCPROV60_SLOPE_0T12; 
  Ratio			OPS_PERCPROV60_SLOPE_6T12; 
  Ratio			OPS_PERCPROV90_SLOPE_0T24; 
  Ratio			OPS_PERCPROV90_SLOPE_0T6; 
  Ratio			OPS_PERCPROV90_SLOPE_6T12; 
  Ratio			OPS_PERCPROVOUTSTANDING_ADJUSTEDSLOPE_0T12; 
  Ratio			FLEET_MONTHSOUTSTANDING_SLOPE24; 
  Ratio			FLEET_PERCPROV30_SLOPE_0T12; 
  Ratio			FLEET_PERCPROV30_SLOPE_6T12; 
  Ratio			FLEET_PERCPROV60_SLOPE_0T12; 
  Ratio			FLEET_PERCPROV60_SLOPE_6T12; 
  Ratio			FLEET_PERCPROV90_SLOPE_0T24; 
  Ratio			FLEET_PERCPROV90_SLOPE_0T6; 
  Ratio			FLEET_PERCPROV90_SLOPE_6T12; 
  Ratio			FLEET_PERCPROVOUTSTANDING_ADJUSTEDSLOPE_0T12; 
  Ratio			CARRIER_MONTHSOUTSTANDING_SLOPE24; 
  Ratio			CARRIER_PERCPROV30_SLOPE_0T12; 
  Ratio			CARRIER_PERCPROV30_SLOPE_6T12; 
  Ratio			CARRIER_PERCPROV60_SLOPE_0T12; 
  Ratio			CARRIER_PERCPROV60_SLOPE_6T12; 
  Ratio			CARRIER_PERCPROV90_SLOPE_0T24; 
  Ratio			CARRIER_PERCPROV90_SLOPE_0T6; 
  Ratio			CARRIER_PERCPROV90_SLOPE_6T12; 
  Ratio			CARRIER_PERCPROVOUTSTANDING_ADJUSTEDSLOPE_0T12; 
  Ratio			BLDGMATS_MONTHSOUTSTANDING_SLOPE24; 
  Ratio 		BLDGMATS_PERCPROV30_SLOPE_0T12; 
  Ratio			BLDGMATS_PERCPROV30_SLOPE_6T12; 
  Ratio			BLDGMATS_PERCPROV60_SLOPE_0T12; 
  Ratio			BLDGMATS_PERCPROV60_SLOPE_6T12; 
  Ratio			BLDGMATS_PERCPROV90_SLOPE_0T24; 
  Ratio			BLDGMATS_PERCPROV90_SLOPE_0T6; 
  Ratio			BLDGMATS_PERCPROV90_SLOPE_6T12; 
  Ratio			BLDGMATS_PERCPROVOUTSTANDING_ADJUSTEDSLOPE_0T12; 
  Ratio			TOP5_MONTHSOUTSTANDING_SLOPE24; 
  Ratio			TOP5_PERCPROV30_SLOPE_0T12; 
  Ratio			TOP5_PERCPROV30_SLOPE_6T12; 
  Ratio			TOP5_PERCPROV60_SLOPE_0T12; 
  Ratio			TOP5_PERCPROV60_SLOPE_6T12; 
  Ratio			TOP5_PERCPROV90_SLOPE_0T24; 
  Ratio			TOP5_PERCPROV90_SLOPE_0T6; 
  Ratio			TOP5_PERCPROV90_SLOPE_6T12; 
  Ratio			TOP5_PERCPROVOUTSTANDING_ADJUSTEDSLOPE_0T12;

END;