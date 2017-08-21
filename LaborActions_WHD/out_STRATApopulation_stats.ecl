import STRATA, LaborActions_WHD;

export out_STRATApopulation_stats(string pversion) := function

rPopulationStats_LaborActions_WHD := record
    LaborActions_WHD.Files().Base.qa.State;    // field to group by --  all values are "US"
		CountGroup                                 := count(group);
    DartID_CountPopulated                      := sum(group,if(LaborActions_WHD.Files().Base.qa.DartID<>'',1,0));
		DateAdded_CountPopulated                   := sum(group,if((string)LaborActions_WHD.Files().Base.qa.DateAdded<>'',1,0));
		DateUpdated_CountPopulated                 := sum(group,if((string)LaborActions_WHD.Files().Base.qa.DateUpdated<>'',1,0));
		Website_CountPopulated                     := sum(group,if(LaborActions_WHD.Files().Base.qa.Website<>'',1,0));
		CaseID_CountPopulated                      := sum(group,if(LaborActions_WHD.Files().Base.qa.CaseID<>'',1,0));
		EmployerName_CountPopulated                := sum(group,if(LaborActions_WHD.Files().Base.qa.EmployerName<>'',1,0));
		Address1_CountPopulated                    := sum(group,if(LaborActions_WHD.Files().Base.qa.Address1<>'',1,0));
		City_CountPopulated                        := sum(group,if(LaborActions_WHD.Files().Base.qa.City<>'',1,0));
		EmployerState_CountPopulated               := sum(group,if(LaborActions_WHD.Files().Base.qa.EmployerState<>'',1,0));
		ZipCode_CountPopulated                     := sum(group,if(LaborActions_WHD.Files().Base.qa.ZipCode<>'',1,0));
		NAICSCode_CountPopulated                   := sum(group,if(LaborActions_WHD.Files().Base.qa.NAICSCode<>'',1,0));
		TotalViolations_CountPopulated             := sum(group,if((LaborActions_WHD.Files().Base.qa.TotalViolations<>'') and
																															 (LaborActions_WHD.Files().Base.qa.TotalViolations<>'0'),1,0));
		BW_TotalAgreedAmount_CountPopulated        := sum(group,if((LaborActions_WHD.Files().Base.qa.BW_TotalAgreedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.BW_TotalAgreedAmount<>'0'),1,0));
		CMP_TotalAssessments_CountPopulated        := sum(group,if((LaborActions_WHD.Files().Base.qa.CMP_TotalAssessments<>'') and
																															 (LaborActions_WHD.Files().Base.qa.CMP_TotalAssessments<>'0'),1,0));
		EE_TotalViolations_CountPopulated          := sum(group,if((LaborActions_WHD.Files().Base.qa.EE_TotalViolations<>'') and
																															 (LaborActions_WHD.Files().Base.qa.EE_TotalViolations<>'0'),1,0));
		EE_TotalAgreedCount_CountPopulated         := sum(group,if((LaborActions_WHD.Files().Base.qa.EE_TotalAgreedCount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.EE_TotalAgreedCount<>'0'),1,0));
		CA_CountViolations_CountPopulated          := sum(group,if((LaborActions_WHD.Files().Base.qa.CA_CountViolations<>'') and
																															 (LaborActions_WHD.Files().Base.qa.CA_CountViolations<>'0'),1,0));
		CA_BW_AgreedAmount_CountPopulated          := sum(group,if((LaborActions_WHD.Files().Base.qa.CA_BW_AgreedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.CA_BW_AgreedAmount<>'0'),1,0));
		CA_EE_AgreedCount_CountPopulated           := sum(group,if((LaborActions_WHD.Files().Base.qa.CA_EE_AgreedCount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.CA_EE_AgreedCount<>'0'),1,0));
		CCPA_CountViolations_CountPopulated        := sum(group,if((LaborActions_WHD.Files().Base.qa.CCPA_CountViolations<>'') and
																															 (LaborActions_WHD.Files().Base.qa.CCPA_CountViolations<>'0'),1,0));
		CCPA_BW_AgreedAmount_CountPopulated        := sum(group,if((LaborActions_WHD.Files().Base.qa.CCPA_BW_AgreedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.CCPA_BW_AgreedAmount<>'0'),1,0));
		CCPA_EE_AgreedCount_CountPopulated         := sum(group,if((LaborActions_WHD.Files().Base.qa.CCPA_EE_AgreedCount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.CCPA_EE_AgreedCount<>'0'),1,0));
		CREW_CountViolations_CountPopulated        := sum(group,if((LaborActions_WHD.Files().Base.qa.CREW_CountViolations<>'') and
																															 (LaborActions_WHD.Files().Base.qa.CREW_CountViolations<>'0'),1,0));
		CREW_BW_AgreedAmount_CountPopulated        := sum(group,if((LaborActions_WHD.Files().Base.qa.CREW_BW_AgreedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.CREW_BW_AgreedAmount<>'0'),1,0));
		CREW_CMP_AssessedAmount_CountPopulated     := sum(group,if((LaborActions_WHD.Files().Base.qa.CREW_CMP_AssessedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.CREW_CMP_AssessedAmount<>'0'),1,0));
		CREW_EE_AgreedCount_CountPopulated         := sum(group,if((LaborActions_WHD.Files().Base.qa.CREW_EE_AgreedCount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.CREW_EE_AgreedCount<>'0'),1,0));
		CWHSSA_CountViolations_CountPopulated      := sum(group,if((LaborActions_WHD.Files().Base.qa.CWHSSA_CountViolations<>'') and
																															 (LaborActions_WHD.Files().Base.qa.CWHSSA_CountViolations<>'0'),1,0));
		CWHSSA_BW_AgreedAmount_CountPopulated      := sum(group,if((LaborActions_WHD.Files().Base.qa.CWHSSA_BW_AgreedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.CWHSSA_BW_AgreedAmount<>'0'),1,0));
		CWHSSA_EE_AgreedCount_CountPopulated       := sum(group,if((LaborActions_WHD.Files().Base.qa.CWHSSA_EE_AgreedCount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.CWHSSA_EE_AgreedCount<>'0'),1,0));
		DBRA_CL_CountViolations_CountPopulated     := sum(group,if((LaborActions_WHD.Files().Base.qa.DBRA_CL_CountViolations<>'') and
																															 (LaborActions_WHD.Files().Base.qa.DBRA_CL_CountViolations<>'0'),1,0));
		DBRA_BW_AgreedAmount_CountPopulated        := sum(group,if((LaborActions_WHD.Files().Base.qa.DBRA_BW_AgreedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.DBRA_BW_AgreedAmount<>'0'),1,0));
		DBRA_EE_AgreedCount_CountPopulated         := sum(group,if((LaborActions_WHD.Files().Base.qa.DBRA_EE_AgreedCount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.DBRA_EE_AgreedCount<>'0'),1,0));
		EEV_CountViolations_CountPopulated         := sum(group,if((LaborActions_WHD.Files().Base.qa.EEV_CountViolations<>'') and
																															 (LaborActions_WHD.Files().Base.qa.EEV_CountViolations<>'0'),1,0));
		EPPA_CountViolations_CountPopulated        := sum(group,if((LaborActions_WHD.Files().Base.qa.EPPA_CountViolations<>'') and
																															 (LaborActions_WHD.Files().Base.qa.EPPA_CountViolations<>'0'),1,0));
		EPPA_BW_AgreedAmount_CountPopulated        := sum(group,if((LaborActions_WHD.Files().Base.qa.EPPA_BW_AgreedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.EPPA_BW_AgreedAmount<>'0'),1,0));
		EPPA_CMP_AssessedAmount_CountPopulated     := sum(group,if((LaborActions_WHD.Files().Base.qa.EPPA_CMP_AssessedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.EPPA_CMP_AssessedAmount<>'0'),1,0));
		EPPA_EE_AgreedCount_CountPopulated         := sum(group,if((LaborActions_WHD.Files().Base.qa.EPPA_EE_AgreedCount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.EPPA_EE_AgreedCount<>'0'),1,0));
		FLSA_CountViolations_CountPopulated        := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_CountViolations<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_CountViolations<>'0'),1,0));
		FLSA_BW_15a3_AgreedAmount_CountPopulated   := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_BW_15a3_AgreedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_BW_15a3_AgreedAmount<>'0'),1,0));
		FLSA_BW_AgreedAmount_CountPopulated        := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_BW_AgreedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_BW_AgreedAmount<>'0'),1,0));
		FLSA_BW_MinWage_AgreedAmount_CountPopulated := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_BW_MinWage_AgreedAmount<>'') and
																															  (LaborActions_WHD.Files().Base.qa.FLSA_BW_MinWage_AgreedAmount<>'0'),1,0));
		FLSA_BW_Overtime_AgreedAmount_CountPopulated:= sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_BW_Overtime_AgreedAmount<>'') and
																														    (LaborActions_WHD.Files().Base.qa.FLSA_BW_Overtime_AgreedAmount<>'0'),1,0));
		FLSA_CMP_AssessedAmount_CountPopulated     := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_CMP_AssessedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_CMP_AssessedAmount<>'0'),1,0));
		FLSA_EE_AgreedCount_CountPopulated         := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_EE_AgreedCount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_EE_AgreedCount<>'0'),1,0));
		FLSA_CL_CountViolations_CountPopulated     := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_CL_CountViolations<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_CL_CountViolations<>'0'),1,0));
		FLSA_CL_CountMinorsEmployed_CountPopulated := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_CL_CountMinorsEmployed<>'') and 
																															 (LaborActions_WHD.Files().Base.qa.FLSA_CL_CountMinorsEmployed<>'0'),1,0));
		FLSA_CL_CMP_AssessedAmount_CountPopulated  := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_CL_CMP_AssessedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_CL_CMP_AssessedAmount<>'0'),1,0));
		FLSA_HMWKR_CountViolations_CountPopulated  := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_HMWKR_CountViolations<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_HMWKR_CountViolations<>'0'),1,0));
		FLSA_HMWKR_BW_AgreedAmount_CountPopulated  := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_HMWKR_BW_AgreedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_HMWKR_BW_AgreedAmount<>'0'),1,0));
		FLSA_HMWKR_CMP_AssessedAmount_CountPopulated:= sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_HMWKR_CMP_AssessedAmount<>'') and
																													  	  (LaborActions_WHD.Files().Base.qa.FLSA_HMWKR_CMP_AssessedAmount<>'0'),1,0));
		FLSA_HMWKR_EE_AgreedCount_CountPopulated   := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_HMWKR_EE_AgreedCount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_HMWKR_EE_AgreedCount<>'0'),1,0));
		FLSA_SMW14_BW_AgreedAmount_CountPopulated  := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_SMW14_BW_AgreedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_SMW14_BW_AgreedAmount<>'0'),1,0));
		FLSA_SMW14_CountViolations_CountPopulated  := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_SMW14_CountViolations<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_SMW14_CountViolations<>'0'),1,0));
		FLSA_SMW14_EE_AgreedCount_CountPopulated   := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_SMW14_EE_AgreedCount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_SMW14_EE_AgreedCount<>'0'),1,0));
		FLSA_SMWAP_CountViolations_CountPopulated  := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_SMWAP_CountViolations<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_SMWAP_CountViolations<>'0'),1,0));
		FLSA_SMWAP_BW_AgreedAmount_CountPopulated  := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_SMWAP_BW_AgreedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_SMWAP_BW_AgreedAmount<>'0'),1,0));
		FLSA_SMWAP_EE_AgreedCount_CountPopulated   := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_SMWAP_EE_AgreedCount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_SMWAP_EE_AgreedCount<>'0'),1,0));
		FLSA_SMWFT_CountViolations_CountPopulated  := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_SMWFT_CountViolations<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_SMWFT_CountViolations<>'0'),1,0));
		FLSA_SMWFT_BW_AgreedAmount_CountPopulated  := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_SMWFT_BW_AgreedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_SMWFT_BW_AgreedAmount<>'0'),1,0));
		FLSA_SMWFT_EE_AgreedCount_CountPopulated   := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_SMWFT_EE_AgreedCount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_SMWFT_EE_AgreedCount<>'0'),1,0));
		FLSA_SMWL_CountViolations_CountPopulated   := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_SMWL_CountViolations<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_SMWL_CountViolations<>'0'),1,0));
		FLSA_SMWL_BW_AgreedAmount_CountPopulated   := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_SMWL_BW_AgreedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_SMWL_BW_AgreedAmount<>'0'),1,0));
		FLSA_SMWL_EE_AgreedCount_CountPopulated    := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_SMWL_EE_AgreedCount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_SMWL_EE_AgreedCount<>'0'),1,0));
		FLSA_SMWMG_CountViolations_CountPopulated  := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_SMWMG_CountViolations<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_SMWMG_CountViolations<>'0') ,1,0));
		FLSA_SMWMG_BW_AgreedAmount_CountPopulated  := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_SMWMG_BW_AgreedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_SMWMG_BW_AgreedAmount<>'0'),1,0));
		FLSA_SMWMG_EE_AgreedCount_CountPopulated   := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_SMWMG_EE_AgreedCount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_SMWMG_EE_AgreedCount<>'0'),1,0));
		FLSA_SMWPW_CountViolations_CountPopulated  := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_SMWPW_CountViolations<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_SMWPW_CountViolations<>'0'),1,0));
		FLSA_SMWPW_BW_AgreedAmount_CountPopulated  := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_SMWPW_BW_AgreedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_SMWPW_BW_AgreedAmount<>'0'),1,0));
		FLSA_SMWPW_EE_AgreedCount_CountPopulated   := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_SMWPW_EE_AgreedCount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_SMWPW_EE_AgreedCount<>'0'),1,0));
		FLSA_SMWSL_CountViolations_CountPopulated  := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_SMWSL_CountViolations<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_SMWSL_CountViolations<>'0'),1,0));
		FLSA_SMWSL_BW_AgreedAmount_CountPopulated  := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_SMWSL_BW_AgreedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_SMWSL_BW_AgreedAmount<>'0'),1,0));
		FLSA_SMWSL_EE_AgreedCount_CountPopulated   := sum(group,if((LaborActions_WHD.Files().Base.qa.FLSA_SMWSL_EE_AgreedCount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FLSA_SMWSL_EE_AgreedCount<>'0'),1,0));
		FMLA_CountViolations_CountPopulated        := sum(group,if((LaborActions_WHD.Files().Base.qa.FMLA_CountViolations<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FMLA_CountViolations<>'0'),1,0));
		FMLA_BW_AgreedAmount_CountPopulated        := sum(group,if((LaborActions_WHD.Files().Base.qa.FMLA_BW_AgreedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FMLA_BW_AgreedAmount<>'0'),1,0));
		FMLA_CMP_AssessedAmount_CountPopulated     := sum(group,if((LaborActions_WHD.Files().Base.qa.FMLA_CMP_AssessedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FMLA_CMP_AssessedAmount<>'0'),1,0));
		FMLA_EE_AgreedCount_CountPopulated         := sum(group,if((LaborActions_WHD.Files().Base.qa.FMLA_EE_AgreedCount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.FMLA_EE_AgreedCount<>'0'),1,0));
		H1A_CountViolations_CountPopulated         := sum(group,if((LaborActions_WHD.Files().Base.qa.H1A_CountViolations<>'') and
																															 (LaborActions_WHD.Files().Base.qa.H1A_CountViolations<>'0'),1,0));
		H1A_BW_AgreedAmount_CountPopulated         := sum(group,if((LaborActions_WHD.Files().Base.qa.H1A_BW_AgreedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.H1A_BW_AgreedAmount<>'0'),1,0));
		H1A_CMP_AssessedAmount_CountPopulated      := sum(group,if((LaborActions_WHD.Files().Base.qa.H1A_CMP_AssessedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.H1A_CMP_AssessedAmount<>'0'),1,0));
		H1A_EE_AgreedCount_CountPopulated          := sum(group,if((LaborActions_WHD.Files().Base.qa.H1A_EE_AgreedCount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.H1A_EE_AgreedCount<>'0'),1,0));
		H1B_CountViolations_CountPopulated         := sum(group,if((LaborActions_WHD.Files().Base.qa.H1B_CountViolations<>'') and
																															 (LaborActions_WHD.Files().Base.qa.H1B_CountViolations<>'0'),1,0));
		H1B_BW_AgreedAmount_CountPopulated         := sum(group,if((LaborActions_WHD.Files().Base.qa.H1B_BW_AgreedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.H1B_BW_AgreedAmount<>'0'),1,0));
		H1B_CMP_AssessedAmount_CountPopulated      := sum(group,if((LaborActions_WHD.Files().Base.qa.H1B_CMP_AssessedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.H1B_CMP_AssessedAmount<>'0'),1,0));
		H1B_EE_AgreedCount_CountPopulated          := sum(group,if((LaborActions_WHD.Files().Base.qa.H1B_EE_AgreedCount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.H1B_EE_AgreedCount<>'0'),1,0));
		H2A_CountViolations_CountPopulated         := sum(group,if((LaborActions_WHD.Files().Base.qa.H2A_CountViolations<>'') and
																															 (LaborActions_WHD.Files().Base.qa.H2A_CountViolations<>'0'),1,0));
		H2A_BW_AgreedAmount_CountPopulated         := sum(group,if((LaborActions_WHD.Files().Base.qa.H2A_BW_AgreedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.H2A_BW_AgreedAmount<>'0'),1,0));
		H2A_CMP_AssessedAmount_CountPopulated      := sum(group,if((LaborActions_WHD.Files().Base.qa.H2A_CMP_AssessedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.H2A_CMP_AssessedAmount<>'0'),1,0));
		H2A_EE_AgreedCount_CountPopulated          := sum(group,if((LaborActions_WHD.Files().Base.qa.H2A_EE_AgreedCount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.H2A_EE_AgreedCount<>'0'),1,0));
		H2B_CountViolations_CountPopulated         := sum(group,if((LaborActions_WHD.Files().Base.qa.H2B_CountViolations<>'') and
																															 (LaborActions_WHD.Files().Base.qa.H2B_CountViolations<>'0'),1,0));
		H2B_BW_AgreedAmount_CountPopulated         := sum(group,if((LaborActions_WHD.Files().Base.qa.H2B_BW_AgreedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.H2B_BW_AgreedAmount<>'0'),1,0));
		H2B_EE_AgreedCount_CountPopulated          := sum(group,if((LaborActions_WHD.Files().Base.qa.H2B_EE_AgreedCount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.H2B_EE_AgreedCount<>'0'),1,0));
		MPSA_CountViolations_CountPopulated        := sum(group,if((LaborActions_WHD.Files().Base.qa.MPSA_CountViolations<>'') and
																															 (LaborActions_WHD.Files().Base.qa.MPSA_CountViolations<>'0'),1,0));
		MPSA_BW_AgreedAmount_CountPopulated        := sum(group,if((LaborActions_WHD.Files().Base.qa.MPSA_BW_AgreedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.MPSA_BW_AgreedAmount<>'0'),1,0));
		MPSA_CMP_AssessedAmount_CountPopulated     := sum(group,if((LaborActions_WHD.Files().Base.qa.MPSA_CMP_AssessedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.MPSA_CMP_AssessedAmount<>'0'),1,0));
		MPSA_EE_AgreedCount_CountPopulated         := sum(group,if((LaborActions_WHD.Files().Base.qa.MPSA_EE_AgreedCount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.MPSA_EE_AgreedCount<>'0'),1,0));
		OSHA_CountViolations_CountPopulated        := sum(group,if((LaborActions_WHD.Files().Base.qa.OSHA_CountViolations<>'') and
																															 (LaborActions_WHD.Files().Base.qa.OSHA_CountViolations<>'0'),1,0));
		OSHA_BW_AgreedAmount_CountPopulated        := sum(group,if((LaborActions_WHD.Files().Base.qa.OSHA_BW_AgreedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.OSHA_BW_AgreedAmount<>'0'),1,0));
		OSHA_CMP_AssessedAmount_CountPopulated     := sum(group,if((LaborActions_WHD.Files().Base.qa.OSHA_CMP_AssessedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.OSHA_CMP_AssessedAmount<>'0'),1,0));
		OSHA_EE_AgreedCount_CountPopulated         := sum(group,if((LaborActions_WHD.Files().Base.qa.OSHA_EE_AgreedCount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.OSHA_EE_AgreedCount<>'0'),1,0));
		PCA_CountViolations_CountPopulated         := sum(group,if((LaborActions_WHD.Files().Base.qa.PCA_CountViolations<>'') and
																															 (LaborActions_WHD.Files().Base.qa.PCA_CountViolations<>'0'),1,0));
		PCA_BW_AgreedAmount_CountPopulated         := sum(group,if((LaborActions_WHD.Files().Base.qa.PCA_BW_AgreedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.PCA_BW_AgreedAmount<>'0'),1,0));
		PCA_EE_AgreedCount_CountPopulated          := sum(group,if((LaborActions_WHD.Files().Base.qa.PCA_EE_AgreedCount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.PCA_EE_AgreedCount<>'0'),1,0));
		SCA_CountViolations_CountPopulated         := sum(group,if((LaborActions_WHD.Files().Base.qa.SCA_CountViolations<>'') and
																															 (LaborActions_WHD.Files().Base.qa.SCA_CountViolations<>'0'),1,0));
		SCA_BW_AgreedAmount_CountPopulated         := sum(group,if((LaborActions_WHD.Files().Base.qa.SCA_BW_AgreedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.SCA_BW_AgreedAmount<>'0'),1,0));
		SCA_EE_AgreedCount_CountPopulated          := sum(group,if((LaborActions_WHD.Files().Base.qa.SCA_EE_AgreedCount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.SCA_EE_AgreedCount<>'0'),1,0));
		SRAW_CountViolations_CountPopulated        := sum(group,if((LaborActions_WHD.Files().Base.qa.SRAW_CountViolations<>'') and
																															 (LaborActions_WHD.Files().Base.qa.SRAW_CountViolations<>'0'),1,0));
		SRAW_BW_AgreedAmount_CountPopulated        := sum(group,if((LaborActions_WHD.Files().Base.qa.SRAW_BW_AgreedAmount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.SRAW_BW_AgreedAmount<>'0'),1,0));
		SRAW_EE_AgreedCount_CountPopulated         := sum(group,if((LaborActions_WHD.Files().Base.qa.SRAW_EE_AgreedCount<>'') and
																															 (LaborActions_WHD.Files().Base.qa.SRAW_EE_AgreedCount<>'0'),1,0));
		unique_id_CountPopulated                   := sum(group,if((string)LaborActions_WHD.Files().Base.qa.unique_id<>'',1,0));
		Append_MailAddress1_CountPopulated         := sum(group,if(LaborActions_WHD.Files().Base.qa.Append_MailAddress1<>'',1,0));
		Append_MailAddressLast_CountPopulated      := sum(group,if(LaborActions_WHD.Files().Base.qa.Append_MailAddressLast<>'',1,0));
		Date_FirstSeen_CountPopulated              := sum(group,if((string)LaborActions_WHD.Files().Base.qa.Date_FirstSeen<>'',1,0));
		Date_LastSeen_CountPopulated               := sum(group,if((string)LaborActions_WHD.Files().Base.qa.Date_LastSeen<>'',1,0));
		bdid_CountPopulated                        := sum(group,if((string)LaborActions_WHD.Files().Base.qa.bdid<>'',1,0));

	end;

dPopulationStats_LaborActions_WHD := table(LaborActions_WHD.Files().Base.qa,rPopulationStats_LaborActions_WHD,few);                                                               

STRATA.createXMLStats(dPopulationStats_LaborActions_WHD,
            'LaborActions_WHDv2','base',pversion,
						'',resultsOut,'view','population');
		 
 return resultsOut;
 
 end;
 