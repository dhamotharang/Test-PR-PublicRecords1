import iesp;
EXPORT Individual_ReportService_Functions := MODULE 

	export verifyProviderSantion(dataset(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx) source) := function
			hasProviderorSanctionData := exists(source.Sanctions) or exists(source.UniqueIds) or exists(source.Names) or 
																	 exists(source.NationalProviderIds) or exists(source.UPINs) or exists(source.Licenses);
			return hasProviderorSanctionData;
	end;
	export verifyPersonRelativesData(dataset(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx) source) := function
			hasPersonRelativesData := exists(source.Relatives);
			return hasPersonRelativesData;
	end;
	export verifyPersonNeighborsData(dataset(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx) source) := function
			hasPersonNeighborsData := exists(source.Neighbors);
			return hasPersonNeighborsData;
	end;
	export verifyPersonHNeighborsData(dataset(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx) source) := function
			hasPersonHNeighborsData := exists(source.HistoricalNeighbors);
			return hasPersonHNeighborsData;
	end;
	export verifyPersonAssociatesData(dataset(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx) source) := function
			hasPersonAssociatesData := exists(source.Associates);
			return hasPersonAssociatesData;
	end;
	export verifyPersonDODsData(dataset(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx) source) := function
			hasPersonDODsData := exists(source.DODs);
			return hasPersonDODsData;
	end;
	export verifyCriminalData(dataset(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx) source) := function
			hasCriminalData := exists(source.CriminalRecords);
			return hasCriminalData;
	end;
	export verifyCorporateData(dataset(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx) source) := function
			hasCorporateData := exists(source.CorporateAffiliations);
			return hasCorporateData;
	end;
	export verifyProfLicData(dataset(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx) source) := function
			hasProfLicData := exists(source.ProfessionalLicenses);
			return hasProfLicData;
	end;
	export verifyDEAData(dataset(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx) source) := function
			hasDEAData := exists(source.DEAInformation);
			return hasDEAData;
	end;
	export verifyBankruptciesData(dataset(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx) source) := function
			hasBankruptciesData := exists(source.Bankruptcies);
			return hasBankruptciesData;
	end;
	export verifyLiensJudgmentsData(dataset(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx) source) := function
			hasLiensJudgmentsData := exists(source.LiensJudgments);
			return hasLiensJudgmentsData;
	end;
	export verifyGSASanctionsData(dataset(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx) source) := function
			hasGSASanctionsData := exists(source.GSASanctions);
			return hasGSASanctionsData;
	end;
	export verifyResults(dataset(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx) source) := function
			hasProviderorSanctionData := verifyProviderSantion(source);
			hasPersonRelativesData := verifyPersonRelativesData(source);
			hasPersonNeighborsData := verifyPersonNeighborsData(source);
			hasPersonHNeighborsData := verifyPersonHNeighborsData(source);
			hasPersonAssociatesData := verifyPersonAssociatesData(source);
			hasPersonDODsData := verifyPersonDODsData(source);
			hasCriminalData := verifyCriminalData(source);
			hasCorporateData := verifyCorporateData(source);
			hasProfLicData := verifyProfLicData(source);
			hasDEAData := verifyDEAData(source);
			hasBankruptciesData := verifyBankruptciesData(source);
			hasLiensJudgmentsData := verifyLiensJudgmentsData(source);
			hasGSASanctionsData := verifyGSASanctionsData(source);
			hasSomething2Report := hasPersonRelativesData or hasPersonNeighborsData or hasPersonHNeighborsData or 
														 hasPersonAssociatesData or hasPersonDODsData or hasCriminalData or hasCorporateData or 
														 hasProfLicData or hasDEAData or hasBankruptciesData or hasLiensJudgmentsData or 
														 hasGSASanctionsData or hasProviderorSanctionData;

			return hasSomething2Report;
	end;

End;
