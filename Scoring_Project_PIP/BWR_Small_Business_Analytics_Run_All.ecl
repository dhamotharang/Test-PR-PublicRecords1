Import scoring_project_pip, Std, ut;

SBFE_SBOM1601 := Scoring_Project_PIP.BWR_Small_Business_Analytics_SBFE_SBOM1601_Attributes;
SBFE_SBBM1601 := Scoring_Project_PIP.BWR_Small_Business_Analytics_SBFE_SBBM1601_Attributes;


NonSBFE_SLBO1702 := Scoring_Project_PIP.BWR_Small_Business_Analytics_NonSBFE_SLBO1702_Attributes;
NonSBFE_SLBB1702 := Scoring_Project_PIP.BWR_Small_Business_Analytics_NonSBFE_SLBB1702_Attributes;
NonSBFE_SLBO1809 := Scoring_Project_PIP.BWR_Small_Business_Analytics_NonSBFE_SLBO1809_Attributes;
NonSBFE_SLBB1809 := Scoring_Project_PIP.BWR_Small_Business_Analytics_NonSBFE_SLBB1809_Attributes;


//three sets of two parallels, scheduled at midnight
SEQUENTIAL(SBFE_SBOM1601, SBFE_SBBM1601, NonSBFE_SLBO1702, NonSBFE_SLBB1702, NonSBFE_SLBO1809, NonSBFE_SLBB1809): WHEN (CRON('0 5 * * *'));

// SEQUENTIAL(SBFE_SBOM1601, SBFE_SBBM1601, NonSBFE_SLBO1702, NonSBFE_SLBB1702, NonSBFE_SLBO1809, NonSBFE_SLBB1809): WHEN (CRON('0 5 * * *'));

//three sets of two parallels, instantly
// SEQUENTIAL(PARALLEL(SBFE_SBOM1601, SBFE_SBBM1601), PARALLEL(NonSBFE_SLBO1702, NonSBFE_SLBB1702), PARALLEL(NonSBFE_SLBO1809, NonSBFE_SLBB1809));
 // WHEN (CRON('11 55 * * *'));

// Small_Business_Models_Run := SEQUENTIAL(SBFE_SBOM1601, SBFE_SBBM1601, WAIT('SBFE_SBOM1601'), NonSBFE_SLBO1702, WAIT('SBFE_SBBM1601'), NonSBFE_SLBB1702,
	// WAIT('NonSBFE_SLBO1702'), NonSBFE_SLBO1809, WAIT('NonSBFE_SLBB1702'), NonSBFE_SLBB1809);
// Small_Business_Models_Run : WHEN (CRON('11 55 * * *'));