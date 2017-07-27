/* Module containing filecode enum mappings. */
EXPORT m_filecode := module;

	export FilecodeEnum := enum (
          FC_UNKNOWN    = -1,
          CLIENT        =  0,
          SKA_INACT     /* =  1 */,
          SKA           /* =  2 */,
          LIC           /* =  3 */,
          DEA           /* =  4 */,
          SSA_DMF       /* =  5 */,
          SNC           /* =  6 */,
          SNC_OTHER     /* =  7 */,
          STFED_PRS     /* =  8 */,
          HIGH_RISK     /* =  9 */,
          CMS_UPIN      /* = 10 */,
          CHOICEPT      /* = 11 */,
          INACT         /* = 12 */,
          FAC           /* = 13 */,
          ABMS          /* = 14 */,
          FC_CLAIM      /* = 15 */,
          FC_NPI        /* = 16 */,
          FAC_NCP       /* = 17 */,
          FAC_AHD       /* = 18 */,
          MCH           /* = 19 */,
          FAC_DNB       /* = 20 */,
          NPI_TIN_XREF  /* = 21 */,
          TCH           /* = 22 */,
          DECEASED      /* = 23 */,
          ERX_FAX       /* = 24 */,
          REIN          /* = 25 */,
          ACI           /* = 26 */,
          VSF           /* = 27 */,
          ROSTER        /* = 28 */,
          FKA_DEA       /* = 29 */,
          FKA_NPI       /* = 30 */,
					CAM           = 64 /* = 64 */
      );


	export RefTable 		:= enum(basc_name, basc_addr, basc_ssn, t_client, t_client_facility, basc_cp, basc_facility, basc_claim, bad_phone, t_csnm, t_csnm_facility, basc_erx_fax);
		
	export FilecodeEnum basc_facility_enum(string filecode) := function
		 return map(filecode = 'FAC_DNB' 					=> FilecodeEnum.FAC_DNB, 
								filecode[1..3] = 'SKA' 				=> FilecodeEnum.SKA,		
								filecode[1..3] = 'NPI' 				=> FilecodeEnum.FC_NPI, 
								filecode[1..3] = 'LIC' 				=> FilecodeEnum.LIC,
								filecode[1..3] = 'DEA'				=> FilecodeEnum.DEA,
								filecode[1..7] = 'SNC_OIG'		=> FilecodeEnum.SNC,
								filecode[1..8] = 'SNC_FOPM' 	=> FilecodeEnum.SNC,
								filecode[1..9] = 'REIN_FOIG' 	=> FilecodeEnum.REIN,
								filecode[1..9] = 'REIN_FOPM' 	=> FilecodeEnum.REIN,
								filecode[1..9] = 'REIN_FOPM' 	=> FilecodeEnum.REIN,
								filecode[1..7] = 'FAC_AHD' 		=> FilecodeEnum.FAC_AHD,
								filecode[1..7] = 'FAC_NCP' 		=> FilecodeEnum.FAC_NCP,
								filecode[1..3] = 'FAC' 				=> FilecodeEnum.FAC,
								filecode[1..3] = 'OSC' 				=> FilecodeEnum.FAC,
								filecode[1..5] = 'INACT' 			=> FilecodeEnum.INACT,
								filecode[1..3] = 'MCH' 				=> FilecodeEnum.MCH,
								filecode[1..3] = 'TCH' 				=> FilecodeEnum.TCH,
								filecode = 'HIGH_RISK' 				=> FilecodeEnum.HIGH_RISK,
								filecode[1..4] = 'RST_' 			=> FilecodeEnum.ROSTER,
								FilecodeEnum.FC_UNKNOWN);
	end;
	
	export FilecodeEnum basc_name_enum(string filecode) := function
		 return map(filecode = 'SKA_INACT'  		=> FilecodeEnum.SKA_INACT,
								filecode[1..3] = 'SKA' 			=> FilecodeEnum.SKA,
								filecode[1..3] = 'NPI' 			=> FilecodeEnum.FC_NPI, 
								filecode[1..3] = 'LIC' 			=> FilecodeEnum.LIC,
								filecode[1..3] = 'DEA'			=> FilecodeEnum.DEA,
								filecode[1..7] = 'SNC_OIG' 	=> FilecodeEnum.SNC,
								filecode[1..7] = 'SNC_OPM' 	=> FilecodeEnum.SNC,
								filecode[1..8] = 'REIN_OIG' => FilecodeEnum.REIN,
								filecode[1..8] = 'REIN_OPM' => FilecodeEnum.REIN,
								filecode[1..7] = 'ACI_IDV' 	=> FilecodeEnum.ACI,
								filecode = 'CMS_UPIN' 			=> FilecodeEnum.CMS_UPIN,
								filecode = 'INACT_VSF'			=> FilecodeEnum.INACT, 
								filecode[1..5] = 'INACT' 		=> FilecodeEnum.INACT,
								filecode[1..4] = 'ABMS' 		=> FilecodeEnum.ABMS,
								filecode = 'HIGH_RISK' 			=> FilecodeEnum.HIGH_RISK,
								filecode = 'ACT_VSF'				=> FilecodeEnum.VSF,
								filecode[1..4] = 'RST_' 		=> FilecodeEnum.ROSTER,
								filecode = 'FKA_DEA' 				=> FilecodeEnum.FKA_DEA,
								filecode = 'FKA_NPI' 				=> FilecodeEnum.FKA_NPI,
								FilecodeEnum.FC_UNKNOWN);
	end;
	
	export FilecodeEnum basc_addr_enum(string filecode) := function
		return map(	filecode = 'STFED_PRS'  => FilecodeEnum.STFED_PRS,	
								filecode = 'HIGH_RISK'  => FilecodeEnum.HIGH_RISK,	
								FilecodeEnum.FC_UNKNOWN);
	end;
	
	export FilecodeEnum basc_claim_enum(string filecode) := function
		return map(	filecode[1..5] = 'CLAIM'  		=> FilecodeEnum.FC_CLAIM,	
								filecode[1..3] = 'CLM'  			=> FilecodeEnum.FC_CLAIM,	
								filecode = 'HIGH_RISK'  			=> FilecodeEnum.HIGH_RISK,	
								FilecodeEnum.FC_UNKNOWN);
	end;
		
	export FilecodeEnum basc_ssn_enum(string filecode) := function
		return map(	filecode[1..7] = 'SSA_DMF'  	=> FilecodeEnum.SSA_DMF,	
								filecode = 'HIGH_RISK'  			=> FilecodeEnum.HIGH_RISK,	
								FilecodeEnum.FC_UNKNOWN);
	end;

	export FilecodeEnum basc_cp_enum(string filecode) := function
		return map(	filecode[1..8] = 'CHOICEPT'  	=> FilecodeEnum.CHOICEPT,	
								filecode = 'HIGH_RISK'  			=> FilecodeEnum.HIGH_RISK,	
								FilecodeEnum.FC_UNKNOWN);
	end;
	
	export ToEnum(string filecode, RefTable table_id) := function
		return map(	table_id = RefTable.basc_name 		=> basc_name_enum(filecode),
								table_id = RefTable.basc_facility => basc_facility_enum(filecode),
								table_id = RefTable.basc_addr 		=> basc_addr_enum(filecode),
								table_id = RefTable.basc_claim 		=> basc_claim_enum(filecode),
								table_id = RefTable.basc_ssn 			=> basc_ssn_enum(filecode),
								table_id = RefTable.basc_cp 			=> basc_cp_enum(filecode),
								FilecodeEnum.FC_UNKNOWN);
	end;
	
	
	
end;