EXPORT Codes_Sanctions := Module
	Export getSanction_USTAT(boolean state_restriction,	boolean	oig_restriction 	,	boolean opm_restriction	,	boolean future_oig_opm 	,	boolean future_prac_state,	boolean future_any_state ) := Function
			ustat_oig := IF(oig_restriction,Healthcare_Shared.Constants.ustat_Sanc_OIG,0);
			ustat_opm := IF(opm_restriction,Healthcare_Shared.Constants.ustat_Sanc_OPM,0);
			ustat_stateRestrictions := IF(state_restriction,Healthcare_Shared.Constants.ustat_Sanc_StateRestrict,0);
			ustat_oig_opm_future := IF(future_oig_opm,Healthcare_Shared.Constants.ustat_Sanc_OIG_OPM_future,0);
			ustat_prac_stateRestrictions_future := IF(future_prac_state,Healthcare_Shared.Constants.ustat_Sanc_prac_StateRestrict_future,0);
			ustat_any_stateRestrictions_future := IF(future_any_state,Healthcare_Shared.Constants.ustat_Sanc_any_StateRestrict_future,0);
			sanction_ustat := ustat_oig + ustat_opm + ustat_stateRestrictions + ustat_oig_opm_future + ustat_prac_stateRestrictions_future + ustat_any_stateRestrictions_future;
			return sanction_ustat;
	end;
	Export getOIGSanction_USTAT(boolean OIG_SANCTION_CURRENT_FRAUD, boolean OIG_SANCTION_CURRENT_LICENSE, boolean OIG_SANCTION_CURRENT_PROGRAM, boolean OIG_SANCTION_CURRENT_QUALITY, boolean OIG_SANCTION_CURRENT_RX, boolean OIG_SANCTION_CURRENT_OTHER, boolean OIG_SANCTION_HISTORICAL_FRAUD, boolean OIG_SANCTION_HISTORICAL_LICENSE, boolean OIG_SANCTION_HISTORICAL_PROGRAM, boolean OIG_SANCTION_HISTORICAL_QUALITY, boolean OIG_SANCTION_HISTORICAL_RX, boolean OIG_SANCTION_HISTORICAL_OTHER) := Function
			ustat_CurrentFAB := if(OIG_SANCTION_CURRENT_FRAUD,Healthcare_Shared.Constants.ustat_OIG_Current_FAB,0); 
			ustat_CurrentLicense := if(OIG_SANCTION_CURRENT_LICENSE,Healthcare_Shared.Constants.ustat_OIG_Current_License,0); 
			ustat_CurrentProgram := if(OIG_SANCTION_CURRENT_PROGRAM,Healthcare_Shared.Constants.ustat_OIG_Current_Program,0); 
			ustat_CurrentQOC := if(OIG_SANCTION_CURRENT_QUALITY,Healthcare_Shared.Constants.ustat_OIG_Current_Quality,0); 
			ustat_CurrentRX := if(OIG_SANCTION_CURRENT_RX,Healthcare_Shared.Constants.ustat_OIG_Current_RX,0); 
			ustat_CurrentOther := if(OIG_SANCTION_CURRENT_OTHER,Healthcare_Shared.Constants.ustat_OIG_Current_Other,0); 
			ustat_HistoryFAB := if(OIG_SANCTION_HISTORICAL_FRAUD,Healthcare_Shared.Constants.ustat_OIG_History_FAB,0); 
			ustat_HistoryLicense := if(OIG_SANCTION_HISTORICAL_LICENSE,Healthcare_Shared.Constants.ustat_OIG_History_License,0); 
			ustat_HistoryProgram := if(OIG_SANCTION_HISTORICAL_PROGRAM,Healthcare_Shared.Constants.ustat_OIG_History_Program,0); 
			ustat_HistoryQOC := if(OIG_SANCTION_HISTORICAL_QUALITY,Healthcare_Shared.Constants.ustat_OIG_History_Quality,0); 
			ustat_HistoryRX := if(OIG_SANCTION_HISTORICAL_RX,Healthcare_Shared.Constants.ustat_OIG_History_RX,0); 
			ustat_HistoryOther := if(OIG_SANCTION_HISTORICAL_OTHER,Healthcare_Shared.Constants.ustat_OIG_History_Other,0); 
			// ustat_Reinstate := if(hasOIG and (isReinstate or SancCategory = 'REINSTATEMENT'),Healthcare_Shared.Constants.ustat_OIG_Reinstate,0); 
			oig_ustat := ustat_CurrentFAB + ustat_CurrentLicense + ustat_CurrentProgram + ustat_CurrentQOC +
										ustat_CurrentRX + ustat_CurrentOther + ustat_HistoryFAB + ustat_HistoryLicense +
										ustat_HistoryProgram + ustat_HistoryQOC + ustat_HistoryRX + ustat_HistoryOther;// + ustat_Reinstate;
			return oig_ustat;
	end;
	Export getOPMSanction_USTAT(boolean OPM_SANCTION_CURRENT_FRAUD, boolean OPM_SANCTION_CURRENT_LICENSE, boolean OPM_SANCTION_CURRENT_PROGRAM, boolean OPM_SANCTION_CURRENT_QUALITY, boolean OPM_SANCTION_CURRENT_RX, boolean OPM_SANCTION_CURRENT_OTHER, boolean OPM_SANCTION_HISTORICAL_FRAUD, boolean OPM_SANCTION_HISTORICAL_LICENSE, boolean OPM_SANCTION_HISTORICAL_PROGRAM, boolean OPM_SANCTION_HISTORICAL_QUALITY, boolean OPM_SANCTION_HISTORICAL_RX, boolean OPM_SANCTION_HISTORICAL_OTHER) := Function
			ustat_CurrentFAB := if(OPM_SANCTION_CURRENT_FRAUD,Healthcare_Shared.Constants.ustat_OPM_Current_FAB,0); 
			ustat_CurrentLicense := if(OPM_SANCTION_CURRENT_LICENSE,Healthcare_Shared.Constants.ustat_OPM_Current_License,0); 
			ustat_CurrentProgram := if(OPM_SANCTION_CURRENT_PROGRAM,Healthcare_Shared.Constants.ustat_OPM_Current_Program,0); 
			ustat_CurrentQOC := if(OPM_SANCTION_CURRENT_QUALITY,Healthcare_Shared.Constants.ustat_OPM_Current_Quality,0); 
			ustat_CurrentRX := if(OPM_SANCTION_CURRENT_RX,Healthcare_Shared.Constants.ustat_OPM_Current_RX,0); 
			ustat_CurrentOther := if(OPM_SANCTION_CURRENT_OTHER,Healthcare_Shared.Constants.ustat_OPM_Current_Other,0); 
			ustat_HistoryFAB := if(OPM_SANCTION_HISTORICAL_FRAUD,Healthcare_Shared.Constants.ustat_OPM_History_FAB,0); 
			ustat_HistoryLicense := if(OPM_SANCTION_HISTORICAL_LICENSE,Healthcare_Shared.Constants.ustat_OPM_History_License,0); 
			ustat_HistoryProgram := if(OPM_SANCTION_HISTORICAL_PROGRAM,Healthcare_Shared.Constants.ustat_OPM_History_Program,0); 
			ustat_HistoryQOC := if(OPM_SANCTION_HISTORICAL_QUALITY,Healthcare_Shared.Constants.ustat_OPM_History_Quality,0); 
			ustat_HistoryRX := if(OPM_SANCTION_HISTORICAL_RX,Healthcare_Shared.Constants.ustat_OPM_History_RX,0); 
			ustat_HistoryOther := if(OPM_SANCTION_HISTORICAL_OTHER,Healthcare_Shared.Constants.ustat_OPM_History_Other,0); 
			// ustat_Reinstate := if(hasOPM and (isReinstate or SancCategory = 'REINSTATEMENT'),Healthcare_Shared.Constants.ustat_OPM_Reinstate,0); 
			OPM_ustat := ustat_CurrentFAB + ustat_CurrentLicense + ustat_CurrentProgram + ustat_CurrentQOC +
										ustat_CurrentRX + ustat_CurrentOther + ustat_HistoryFAB + ustat_HistoryLicense +
										ustat_HistoryProgram + ustat_HistoryQOC + ustat_HistoryRX + ustat_HistoryOther;
			return opm_ustat;
	end;
	Export getStateSanction_USTAT(boolean STATE_PRAC_SANCTION_CURRENT_FRAUD, boolean STATE_PRAC_SANCTION_CURRENT_LICENSE, boolean STATE_PRAC_SANCTION_CURRENT_PROGRAM, boolean STATE_PRAC_SANCTION_CURRENT_QUALITY, boolean STATE_PRAC_SANCTION_CURRENT_RX, boolean STATE_PRAC_SANCTION_CURRENT_OTHER, boolean STATE_PRAC_SANCTION_HISTORICAL_FRAUD, boolean STATE_PRAC_SANCTION_HISTORICAL_LICENSE, boolean STATE_PRAC_SANCTION_HISTORICAL_PROGRAM, boolean STATE_PRAC_SANCTION_HISTORICAL_QUALITY, boolean STATE_PRAC_SANCTION_HISTORICAL_RX, boolean STATE_PRAC_SANCTION_HISTORICAL_OTHER, boolean STATE_PRAC_SANCTION_HISTORICAL_REINSTATEMENT, boolean STATE_OTHER_SANCTION_CURRENT_FRAUD, boolean STATE_OTHER_SANCTION_CURRENT_LICENSE, boolean STATE_OTHER_SANCTION_CURRENT_PROGRAM, boolean STATE_OTHER_SANCTION_CURRENT_QUALITY, boolean STATE_OTHER_SANCTION_CURRENT_RX, boolean STATE_OTHER_SANCTION_CURRENT_OTHER, boolean STATE_OTHER_SANCTION_HISTORICAL_FRAUD, boolean STATE_OTHER_SANCTION_HISTORICAL_LICENSE, boolean STATE_OTHER_SANCTION_HISTORICAL_PROGRAM, boolean STATE_OTHER_SANCTION_HISTORICAL_QUALITY, boolean STATE_OTHER_SANCTION_HISTORICAL_RX, boolean STATE_OTHER_SANCTION_HISTORICAL_OTHER, boolean STATE_OTHER_SANCTION_HISTORICAL_REINSTATEMENT) := Function
			ustat_CurrentFAB := if(STATE_PRAC_SANCTION_CURRENT_FRAUD,Healthcare_Shared.Constants.ustat_OIG_Current_FAB,0); 
			ustat_CurrentLicense := if(STATE_PRAC_SANCTION_CURRENT_LICENSE,Healthcare_Shared.Constants.ustat_OIG_Current_License,0); 
			ustat_CurrentProgram := if(STATE_PRAC_SANCTION_CURRENT_PROGRAM,Healthcare_Shared.Constants.ustat_OIG_Current_Program,0); 
			ustat_CurrentQOC := if(STATE_PRAC_SANCTION_CURRENT_QUALITY,Healthcare_Shared.Constants.ustat_OIG_Current_Quality,0); 
			ustat_CurrentRX := if(STATE_PRAC_SANCTION_CURRENT_RX,Healthcare_Shared.Constants.ustat_OIG_Current_RX,0); 
			ustat_CurrentOther := if(STATE_PRAC_SANCTION_CURRENT_OTHER,Healthcare_Shared.Constants.ustat_OIG_Current_Other,0); 
			ustat_HistoryFAB := if(STATE_PRAC_SANCTION_HISTORICAL_FRAUD,Healthcare_Shared.Constants.ustat_OIG_History_FAB,0); 
			ustat_HistoryLicense := if(STATE_PRAC_SANCTION_HISTORICAL_LICENSE,Healthcare_Shared.Constants.ustat_OIG_History_License,0); 
			ustat_HistoryProgram := if(STATE_PRAC_SANCTION_HISTORICAL_PROGRAM,Healthcare_Shared.Constants.ustat_OIG_History_Program,0); 
			ustat_HistoryQOC := if(STATE_PRAC_SANCTION_HISTORICAL_QUALITY,Healthcare_Shared.Constants.ustat_OIG_History_Quality,0); 
			ustat_HistoryRX := if(STATE_PRAC_SANCTION_HISTORICAL_RX,Healthcare_Shared.Constants.ustat_OIG_History_RX,0); 
			ustat_HistoryOther := if(STATE_PRAC_SANCTION_HISTORICAL_OTHER,Healthcare_Shared.Constants.ustat_OIG_History_Other,0); 
			ustat_Reinstate := if(STATE_PRAC_SANCTION_HISTORICAL_REINSTATEMENT,Healthcare_Shared.Constants.ustat_OIG_Reinstate,0); 
			ustat_NonPracStateCurrentFAB := if(STATE_OTHER_SANCTION_CURRENT_FRAUD,Healthcare_Shared.Constants.ustat_OIG_Current_FAB,0); 
			ustat_NonPracStateCurrentLicense := if(STATE_OTHER_SANCTION_CURRENT_LICENSE,Healthcare_Shared.Constants.ustat_OIG_Current_License,0); 
			ustat_NonPracStateCurrentProgram := if(STATE_OTHER_SANCTION_CURRENT_PROGRAM,Healthcare_Shared.Constants.ustat_OIG_Current_Program,0); 
			ustat_NonPracStateCurrentQOC := if(STATE_OTHER_SANCTION_CURRENT_QUALITY,Healthcare_Shared.Constants.ustat_OIG_Current_Quality,0); 
			ustat_NonPracStateCurrentRX := if(STATE_OTHER_SANCTION_CURRENT_RX,Healthcare_Shared.Constants.ustat_OIG_Current_RX,0); 
			ustat_NonPracStateCurrentOther := if(STATE_OTHER_SANCTION_CURRENT_OTHER,Healthcare_Shared.Constants.ustat_OIG_Current_Other,0); 
			ustat_NonPracStateHistoryFAB := if(STATE_OTHER_SANCTION_HISTORICAL_FRAUD,Healthcare_Shared.Constants.ustat_OIG_History_FAB,0); 
			ustat_NonPracStateHistoryLicense := if(STATE_OTHER_SANCTION_HISTORICAL_LICENSE,Healthcare_Shared.Constants.ustat_OIG_History_License,0); 
			ustat_NonPracStateHistoryProgram := if(STATE_OTHER_SANCTION_HISTORICAL_PROGRAM,Healthcare_Shared.Constants.ustat_OIG_History_Program,0); 
			ustat_NonPracStateHistoryQOC := if(STATE_OTHER_SANCTION_HISTORICAL_QUALITY,Healthcare_Shared.Constants.ustat_OIG_History_Quality,0); 
			ustat_NonPracStateHistoryRX := if(STATE_OTHER_SANCTION_HISTORICAL_RX,Healthcare_Shared.Constants.ustat_OIG_History_RX,0); 
			ustat_NonPracStateHistoryOther := if(STATE_OTHER_SANCTION_HISTORICAL_OTHER,Healthcare_Shared.Constants.ustat_OIG_History_Other,0); 
			ustat_NonPracStateReinstate := if(STATE_OTHER_SANCTION_HISTORICAL_REINSTATEMENT,Healthcare_Shared.Constants.ustat_OIG_Reinstate,0); 
			stRestrict_ustat := ustat_CurrentFAB + ustat_CurrentLicense + ustat_CurrentProgram + ustat_CurrentQOC +
										ustat_CurrentRX + ustat_CurrentOther + ustat_HistoryFAB + ustat_HistoryLicense +
										ustat_HistoryProgram + ustat_HistoryQOC + ustat_HistoryRX + ustat_HistoryOther + ustat_Reinstate +
										ustat_NonPracStateCurrentFAB + ustat_NonPracStateCurrentLicense + ustat_NonPracStateCurrentProgram +
										ustat_NonPracStateCurrentQOC + ustat_NonPracStateCurrentRX + ustat_NonPracStateCurrentOther +
										ustat_NonPracStateHistoryFAB + ustat_NonPracStateHistoryLicense + ustat_NonPracStateHistoryProgram +
										ustat_NonPracStateHistoryQOC + ustat_NonPracStateHistoryRX + ustat_NonPracStateHistoryOther +
										ustat_NonPracStateReinstate;
			return stRestrict_ustat;
	end;
	Export getSanction_CIC(boolean hasOIG, boolean hasOPM, boolean hasStateRestrictions) := Function
		return map(hasOIG or hasOPM or hasStateRestrictions => 'Y',
										'');
	end;
	Export getOIGSanction_CIC(boolean hasOIG) := Function
		return map(hasOIG => 'Y',
										'');
	end;
	Export getOPMSanction_CIC(boolean hasOPM) := Function
		return map(hasOPM => 'Y',
										'');
	end;
	Export getStSanction_CIC(boolean hasStateRestrictions) := Function
		return map(hasStateRestrictions => 'Y',
										'');
	end;
End;